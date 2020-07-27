Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD61C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 05:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FC420714
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 05:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ii7mOG4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B0189B57;
	Mon, 27 Jul 2020 05:04:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 587AF89B57
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 05:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRHTl9DTsg+SSqcMcqr8QGrz8F0yAdfZbPeYRkgKYJ48O5ns2Vr7JlHB3gpCyXGZSFIOo2ICVEgp+L9VEc0gGMYB0hfTd/9fF25eJ/jSB4PlJ179tgpO/FBOnrmZkzmq5fMHUs8TkB817lOdYsxHUwg5ziOdkv2MMooxiiO4awZTCAeGDaiROotRXvzyaa/lNdK94wdyu6UB7zt8l/gR+M8xhVgMttWfXMqZ0c0tSiy3p9J3FWvocsLHr5nel22pxS+gHlGyIEAWCGlVffVXXjLSxTriEeKxLSUTrbAuE2j2fgUQfGET94mUQMrTXMTWW/wPSVkRjerd9mKpOQQ/6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUtYvxwfK/cFP+TaRnp/jsWep0tPFldvrZ0lG7gQMXc=;
 b=DBRBOAOaMBzWQu9n2nMHu5OSdMu2pV2En+Xu7LKPHlZ4Yna7bg8CavCC3IwJdclLDuMFwnQoLViomv7zL6K6sNwjfmxypjMQZmEHT+b7JK2ZOrpnb7IBV8v0OMHVkzIb8N3E9AnC4jF0iwj3d2ycoAzcXmyHP35X/Txa3qMxEQykBRQKwenJ1XIn+ekeI49eoJIaU28MDZLt7VQyB29deAgxfXcn9rlFzJn2QUFFZAoPEANQtNI6cZkxCaL8CLS4hCkUCTHb+nIXGjNWSe6B9BtYkmZpa2NwFtEJ5rg1U8WX59aGw6AQ+1VEK2E1MzRzg/H07r6H7qGMQsv7ANhC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUtYvxwfK/cFP+TaRnp/jsWep0tPFldvrZ0lG7gQMXc=;
 b=ii7mOG4kgRFKciTDrZO/tgfQj43zFVaQCCz0tTbGQ9B6fg+8K4xxlBK8bByYdkox7lt6C3OIozQ851T/hmpGgcrDhAgpPJmcqfzBErZOz+CfsuMZeaTqHkJDjQEE/9emk6FLedOHGHCPTfW6ht3MOOMBmTboVbn3I9fjdp7OtOE=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 05:04:07 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::ad86:4e5e:66b8:3045%9]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 05:04:07 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amd/swsmu: allow asic to handle sensor type by
 itself
Thread-Topic: [PATCH 1/2] drm/amd/swsmu: allow asic to handle sensor type by
 itself
Thread-Index: AQHWY8KizIfl5rQVC0K5StBgp5F4yKka3vuQ
Date: Mon, 27 Jul 2020 05:04:06 +0000
Message-ID: <MN2PR12MB41759E8EFC8EAFDBDB46CC5D8E720@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200727030528.586004-1-kevin1.wang@amd.com>
In-Reply-To: <20200727030528.586004-1-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-27T05:04:00Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=3636d37f-8063-4009-beb7-0000c9c09979;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-27T05:04:00Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: fd18b66b-5dd9-4a53-9d0d-000043fe24be
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f9e763f-850b-4256-5416-08d831ea7d8d
x-ms-traffictypediagnostic: MN2PR12MB4079:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4079D3EEB7A2AD5CA605E70A8E720@MN2PR12MB4079.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XEeRIp9Td3clKrXr2kBNDNT73T/Q9cb+ublNdm9yR9lZBAtlOiI5csYT4Keqfqkg+tICkJGQ2F8DQ2Gp5GjvSUzsr7tf+INjp3b6d0WAxCTedkRjAVcZ3sVLcjUBlobLXuSR7gQ9M4H8kOblM2sPY8klP3Y7IHBAYhv5jXhtTmmbxc2GXnxYMIoqwulmd5yYt3wL1YmzAlM55TsvIwqphtXOqJuGieqD5kblkhMdiHePhgNyLh2bD3oAxGRmwiAVv/CFHBEN1mvHTujnFJJo4SUmPEZ0nr80Yky4t/pgD7JY3baZ2zQ5JeTmvIYtAuVd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(53546011)(6506007)(66556008)(66446008)(64756008)(2906002)(66476007)(7696005)(26005)(86362001)(186003)(66946007)(478600001)(76116006)(52536014)(9686003)(55016002)(5660300002)(316002)(8936002)(110136005)(8676002)(33656002)(71200400001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: iK8H6jllwJu1zNOmYjShnscuwcUeDNvovC6oufrLRQT3AyLIepSHgXlSHEfIS0sZ9QyIug8RunoqOnYC1HhJJbow41UGunwInClT61LPfUG5yyPB2hMWdbNW+TnlnK1AiXNt29o4wFKntnp7VJUGurXn1OGA0JOv12j8IH6dKL0U95qzSu/Yq0FDlsv0n//LBuE7fm91adwGryjn3EDsi4WX+o9a486M0gC1CZBOmhh0oFUQL+77LyFKHJOKVoLlL650NVyj9bihzOjyCjdFTE03CjVUPLgdXWtpmhVOrtTLsM0XQLgzrZ41R2abHYNbMYuH6uyHwDiJG7IJMWMrdAaFNQdsPj6E86VQhLwNFwnQNxEHbKFDhT4+qu7KIkBCaK9niWrfKKLnu3g2ShLQc/PwBIgNSQkPd6EFtsmbD8AN1/MhzHUG4+zt5Bt99WtBan/U59OmIZe2IRAr+gERZ4QU294VQ8goxtx4fVL8L/FywW4HGotC7mz9/4NhW+1F
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9e763f-850b-4256-5416-08d831ea7d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 05:04:06.9087 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2cXvjweTkG8RjG5M6CD3Qjek6WP4gP/4789Nc82DkObOSM1D+mh6KsJAfry12UT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>



-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Monday, July 27, 2020 11:05 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 1/2] drm/amd/swsmu: allow asic to handle sensor type by itself

1. allow asic to handle sensor type by itself.
2. if not, use smu common sensor to handle it.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 3b427fa099fe..55463e7a11e2 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1948,6 +1948,10 @@ int smu_read_sensor(struct smu_context *smu,
 
 	mutex_lock(&smu->mutex);
 
+	if (smu->ppt_funcs->read_sensor)
+		if (!smu->ppt_funcs->read_sensor(smu, sensor, data, size))
+			goto unlock;
+
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_STABLE_PSTATE_SCLK:
 		*((uint32_t *)data) = pstate_table->gfxclk_pstate.standard * 100; @@ -1978,11 +1982,12 @@ int smu_read_sensor(struct smu_context *smu,
 		*size = 4;
 		break;
 	default:
-		if (smu->ppt_funcs->read_sensor)
-			ret = smu->ppt_funcs->read_sensor(smu, sensor, data, size);
+		*size = 0;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
+unlock:
 	mutex_unlock(&smu->mutex);
 
 	return ret;
--
2.27.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
