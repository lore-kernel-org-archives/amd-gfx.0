Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AE3C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 03:25:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63692207D3
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 03:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DPyjJqPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63692207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D1786E81C;
	Tue, 25 Aug 2020 03:25:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8735E6E81C
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 03:25:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq4ToCs2qFZmm/6UeADZl4dcatVYz2rrpNid+u+ADV8oFct1PPgzi7D0YPWIqS6nPIOHEmraNJ83IrpFAbI8t5p5CNuTVTR9zsUG08381AL+ZByrAk2tQnRbIibmcDjvjF3GF0MqG/O0hl9Dh9/tWJpCfdvFcATXEPiDs87JCu9YMvbnbaGJXDw0cUku0e+ntWcGCYe6RLA6DzmDMV142glUbN2IMF9gXopEbUYrURM55tJxQLhRSYNfb0mO7TQdXXAinQZdpSUD6qIYnlbf4yK8S8Zh3HnDSh8AxqCkBeZKi2VuS8laqS2gp2oYvj5R17slr2tDCLGH/59OsLJMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKVMxRFkyuV/Qfnl3AU9guViKTFilRq73KjZBXuc6Cs=;
 b=TrhJGVd2PohPI2cCdSRvrP98kpLErnIUZHIo8BnJINxVbuE8iwhl7kMT4ds+Pa8dZwS7U8LzwVKf4lXBHT4yWU2Vpjy51Veh0tEmGM1WwPK/DHw3QnduhDQ4X10EsJHXvrUjeTeJav5l0U4wPOisMUvdThzMOjaXT0tXskFOdkiXIKK/mtIE+swnAnkAxyGWVlm1bTVb8yLBtaUWeE7BusHSO4RJf8N+e9jpdRtovvKCoADoD+1ocjpccYx3VqqYo9Y5REVIj13tVfCihKnuZ2d7XW4HyqV0r5A7M/Ami+PHtbU8HeaJxswfXkTepwgdgs++1F/tzhWirMrMguHiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKVMxRFkyuV/Qfnl3AU9guViKTFilRq73KjZBXuc6Cs=;
 b=DPyjJqPelgV5wpA2oTFCkuUaBd6kW9CTrmiLLqdHTaB78kYfYiumO2uTOKImKi+Wg8SFLNkoWve+s8ORrY07H3Ot0BBrV6nmCVRcQRxrlTIzeSbrIX2VzbV0KZjFIXHklLWy6fYnfpxrAHikFnPYgV9MIm0Jbtejxkcs3VFct8Q=
Received: from CH2PR12MB4326.namprd12.prod.outlook.com (2603:10b6:610:af::11)
 by CH2PR12MB3765.namprd12.prod.outlook.com (2603:10b6:610:25::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 03:25:06 +0000
Received: from CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7]) by CH2PR12MB4326.namprd12.prod.outlook.com
 ([fe80::f564:86dc:de1a:63b7%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 03:25:06 +0000
From: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Gui, Jack" <Jack.Gui@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add asd fw check before loading asd
Thread-Topic: [PATCH] drm/amdgpu: add asd fw check before loading asd
Thread-Index: AQHWeo6vuh7lGrw16EWg+6jvrLQAc6lIKW/A
Date: Tue, 25 Aug 2020 03:25:06 +0000
Message-ID: <CH2PR12MB43269AE2D426AAFA27134419EA570@CH2PR12MB4326.namprd12.prod.outlook.com>
References: <20200825032015.22192-1-tao.zhou1@amd.com>
In-Reply-To: <20200825032015.22192-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=30b64b34-d163-402a-ba81-bbbb1ee97c65;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-25T03:24:44Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b86ebee2-3abe-4b83-aed5-08d848a676ad
x-ms-traffictypediagnostic: CH2PR12MB3765:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3765228FE5FA698943769AFAEA570@CH2PR12MB3765.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArieWRFMMe4DhdNnvTsl7uonhGslStoOpEi474MOwL1paFKf85vXvsBzW1nQZ8q1njB1Vi4QPYXj4DhlPcZCmqKo70nvH9f2RPcm4n+uzrKA3MMSx/6MCUBzotoRq7hQGRZPdgn+HE2vs9EQnfNm1L6Gbmje29+XU9oPgF18hA8O96tpg5CLo3F0F3m0eWA6Gbq3+jwwil6zSuVIPxwEKKwuSYbutqY6CbUUuHvCnBKBV+XbeYkHDe6xjo7NNvXz6CikeqAIICg//bAf3CYKngD+5p+fQWD/qTEwcx6DygRnLSj3/W6fiSuUSax5tSfKl/H4NOfuGY8fjMi7a8FkQQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4326.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(478600001)(2906002)(33656002)(83380400001)(8936002)(26005)(5660300002)(6636002)(55016002)(86362001)(6506007)(76116006)(110136005)(66556008)(66476007)(66946007)(7696005)(316002)(66446008)(64756008)(53546011)(8676002)(52536014)(71200400001)(9686003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: QqLcuuZde9P6Bq2lrw3CzTKT5CQze061O3uFoD7lqv4PQ2waY2Fl9OmAiYxsKcyk/RoTZcIP9izFOz/RcIksx7QbG/WM0NArR6EF3SPYih2OOB8emlKGcAimw81yfdr4U+9kL1Qtgg9va9lG63yZnDTxEIxzAmJUhgvygnGxaHqHByJ2TCi+/55SUgxeTkMgydRzJwW1m179veWb4hQDWWbaRcemTML7jyCDUAEO9EXk0X/YvlJEDudO2gCtsWEt7eYqp1wWsVLnZFo1cDkQGLdtAxEgdlSvBKoDmFPgk/4nygyvBhCb7nP6entLzXl7PhOGJIraHwa72IdOmpvN2PbpsCu1/FGQ8Eq2+HYl+udxc6xVWUq5Zm/bWrboIjfBZICqN7vp2mArJ+wBFVCs+Sx6OjHTzOPs6TmffOjr48LTgW7LujdlSyO57ssaREUIGoChF4GxaSfm9O11LEQyhSF/6dSiHU8PLnxgI4AOJra+GYBZ4zE3OjL8nIudxrRgI6ekmrwq5sHaqfoebxinKJxNLRupGFBoPM7Xtr5bAolax8wCEu8V6tWnxKTnYKroWDiYVM8svhkYOwV4OP9Omh1HHn6zbbSsghDhtEeFS5KHd3Ay250cvpLfMPw7wcwIKTk3Nre1CfOk0Qr5L8uWSw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4326.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86ebee2-3abe-4b83-aed5-08d848a676ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 03:25:06.4580 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7PFO8PZCc5QyGrckNTrT3q50fxlvsyT9EGeXxyyUDmcqmME2t9VpqeiBPI4jiO/Iv2cuDbYsc7WfVUZMDJ7zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3765
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

Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Tuesday, August 25, 2020 11:20 AM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Gui, Jack <Jack.Gui@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add asd fw check before loading asd

asd is not ready for some ASICs in early stage, and psp->asd_fw is more generic than ASIC name in the check

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c22fb0194df7..d6c38e24f130 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -522,8 +522,7 @@ static int psp_asd_load(struct psp_context *psp)
  * add workaround to bypass it for sriov now.
  * TODO: add version check to make it common
  */
-if (amdgpu_sriov_vf(psp->adev) ||
-    (psp->adev->asic_type == CHIP_NAVY_FLOUNDER))
+if (amdgpu_sriov_vf(psp->adev) || !psp->asd_fw)
 return 0;

 cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
