Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24672C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A712074B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 08:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OMFgzBHz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A712074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183936E3F4;
	Mon, 14 Sep 2020 08:13:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278106E3F4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2020 08:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8jZXmUgFGivbPCY34MSST0Bu34oR4794TaCPxb3wzN8vy+6d16mzlVjAwI/ZVOIiC9wofhIQHZyqbbb5qX/dlevgqYVjEONi/F5ARYoP58e+RzJShmpm+b/yKD+CoRimmt26gIcuavKtYudIff5JuJJw/bvhxpf9s+oy9aWYMVLGCCRtAO+Bs90VsggSgK1idIjI2pNffJfFWr3sSwbBXKlZ2EaOylsFqgxDdR66Gqnrjl5azVKYg0NMSp826eN28Bz1aXCgfhWMbDAex8SDT/h4sN+XWYI+8kK7Hxs7TrvxOS4nGNz3BntwaPWw1JnBXhSkWI3u0Qq/fSb/UOC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imovUOITBfbR5o2YiZI9ctjr/Uz2Pef7QxO83Tv/UrE=;
 b=JwYZzTIqFsgUiBhHIXCkDGmtWcm6kglmMNET56l4bm4ySw21k0OONsfGO/lpT6bMHDMLRhFglOZ8luV77Ug/GDpU3/0+a4lyL2HGHKObZfzTWALuBEk+oM4c2cKz9tN2DV5F0Qh9wXwGGbWoeEYvNtR6TYfv2xomvraXAITsAU2lWgoZ3SO7FN1Iey6o3pRQ0sAwuw2hw1BFDojDXfht7S3o3Y2h0A6TzfZytio+idX7Ij+kh6WlpLqdvOwBppuEeGtQXqXnIEUYny88VlNlL3lChlG/l4YxnbJ4lrAsxoq3QUqXy68A0A1dXjiwK662DMONIr+w0VFUIsdhY0SOWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imovUOITBfbR5o2YiZI9ctjr/Uz2Pef7QxO83Tv/UrE=;
 b=OMFgzBHzHZoZURX1BuYWfjABbtIgGlFoOPbR9rEs1WqTflqBzexVBMmWJtfv38U4rZ3WmhNfC5jSAvdVRsmAumGrJOJG0JCEqfCPfW+X9GHJEMuvquBNNtWjpb+uLKaJzjHXMakcNFJ6uAWGW9qOAgcCJKyzVOy9OcHOYZLOSww=
Received: from MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 by MN2PR12MB3710.namprd12.prod.outlook.com (2603:10b6:208:16d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 08:13:34 +0000
Received: from MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::9d0e:bc15:1b8f:84ad]) by MN2PR12MB4175.namprd12.prod.outlook.com
 ([fe80::9d0e:bc15:1b8f:84ad%2]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 08:13:33 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Topic: [PATCH] drm/amd/pm: support runtime pptable update for
 sienna_cichlid etc.
Thread-Index: AQHWim55nKQUrgJ3sEaHIQ+0bGvOdKlnyMIg
Date: Mon, 14 Sep 2020 08:13:33 +0000
Message-ID: <MN2PR12MB417543CC35B4E68506A31A5C8E230@MN2PR12MB4175.namprd12.prod.outlook.com>
References: <20200914081001.3932-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200914081001.3932-1-Jiansong.Chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-09-14T08:13:25Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9ededbf9-210b-425b-8f82-000022fd484e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-14T08:13:25Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 4f2a9d58-2a8f-494e-ab81-00000828ba12
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2dddece-3bfa-428f-1873-08d8588612f1
x-ms-traffictypediagnostic: MN2PR12MB3710:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB371007B6751E5EB0CAB2FA068E230@MN2PR12MB3710.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tjijzbIUapMpjsZzYVGXPv6UJjuzUK/4b992JqvMe7vHtRhWOgD+AL38k+jK9IoaL1rxZbKSWDajtlo/kaeQLI7yLq27+3FxkJpHxqLF2pyZ2Ee1C/lVBKNQKYcP6ctNuPMF5LOYiIGBz90QEmtsOy/d/AqWVMxFo0MXdggnVq44JwaXipqojHqc2GhRrNaxTvxLoSJI5WSLrwFI6swL/ifq0XrEsu7C+twBLrq+C2yLgBRO1N/fzAooUxFWezdiaPQvNpMC+yoBmtAt0aqj7ES4fiEXgsyFV1ndP/JA8GjidTGQ1Lbf519KkE9yy9mMWocnhKMLydi3kk6ySN/lMQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4175.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(2906002)(66476007)(66446008)(66946007)(76116006)(15650500001)(86362001)(316002)(64756008)(71200400001)(66556008)(6506007)(53546011)(26005)(7696005)(83380400001)(186003)(54906003)(8936002)(478600001)(4326008)(110136005)(55016002)(33656002)(52536014)(8676002)(5660300002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: moxEMw+YfvrLYS1yUu6t35FuoFcbystaiUal0UhSv3Qx3Ibyk/NAJwPvAJ/aAijvWoUhUNBYc1MJk03jMTr3txm69IEsKrQPYuuraiPVfOUj3IaG6M4nPhCplGdULAo08j/AkaJZZj0CM4E5UDHjL+QwObNEw16gHWsr/YC10NXlZx9ccHisDxndMTeWrpAq78jtbiL2miEUWI7WjyqzbZ9fx1MY7A7ybxbBxbjt8RIJELmTmwSWDnR7+y+erztCYYMsmee/zeQ5qDxv6A/1kyPtkqM3OmpFP8WC06rrq8UVwb49kPgAHiww2YSBrbzWQLn0JGo+DyU6Bl9IcDB5HYT4sVHxJlmCxOvg95inUu/7UqUHIDbdibOD589EDlwA5FPiZ3RGj9L9WtCPgbBS198kv/brMCubj6aCmzTffXj/vLArT+e/+k4C7Di+M3hdaO7JDvkoNjP9OZpaYCVEfBgEYS55xbZT8cKZRq7L2slhaXr+FyhT81t+B1DyHeT8lCwZMWRfHZ9cwi6cxk+sWPZa2TvYzV0Y7IuJtVS9qq8qk6GVu9/9jIEg5O/aumEPrP+A5oqj1rYd8dA7nlZuWpVmDJFpjEXyg5MSQyh1KSU0PAbaLbZyYTm+9kFEn58FuN8VAft6Y2vwyFW8YDpESg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4175.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dddece-3bfa-428f-1873-08d8588612f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 08:13:33.8293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+xYON3hkJSMsXEPu2QPnc3HfT60SIslryaFTDnfWBZ0DEiAPYOR4QRHGXBA58mF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3710
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>, "Chen, 
 Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Jiansong Chen <Jiansong.Chen@amd.com> 
Sent: Monday, September 14, 2020 4:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: support runtime pptable update for sienna_cichlid etc.

This avoids smu issue when enabling runtime pptable update for sienna_cichlid and so on. Runtime pptable udpate is needed for test and debug purpose.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I70b704ab4d6efd169f579c392e5dbc2737dc1fb2
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7a55ece1f124..7618f9972b8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1129,7 +1129,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 */
 	if (smu->uploading_custom_pp_table &&
 	    (adev->asic_type >= CHIP_NAVI10) &&
-	    (adev->asic_type <= CHIP_NAVI12))
+	    (adev->asic_type <= CHIP_NAVY_FLOUNDER))
 		return 0;
 
 	/*
@@ -1214,7 +1214,9 @@ static int smu_hw_fini(void *handle)  int smu_reset(struct smu_context *smu)  {
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
+	int ret;
+
+	amdgpu_gfx_off_ctrl(smu->adev, false);
 
 	ret = smu_hw_fini(adev);
 	if (ret)
@@ -1225,8 +1227,12 @@ int smu_reset(struct smu_context *smu)
 		return ret;
 
 	ret = smu_late_init(adev);
+	if (ret)
+		return ret;
 
-	return ret;
+	amdgpu_gfx_off_ctrl(smu->adev, true);
+
+	return 0;
 }
 
 static int smu_suspend(void *handle)
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
