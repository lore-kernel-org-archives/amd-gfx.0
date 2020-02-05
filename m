Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B07C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 02:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B109C214AF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 02:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hFS5+YHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B109C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7053A6E113;
	Wed,  5 Feb 2020 02:14:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CB36E113
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 02:14:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npbQFkOr111/1MYFhSHfO7+BJ5GYTBIicf/uFmidn7lYlk2nhnWu6P/+mo15OvhUWD3fB5iPYkbHXAdY/P9uStyI3sGrnOqNJ0kdc5vZuNV5Vya8kCoFmhX50JIefAVnx2faJV6mNpKhcpku0B7j+g4ILniNkw5vT4SdNBa2aeDKRyXjA1kKPfOcYwPxMDnOyVPi+XAJMdbPysdpooPyN0pDnkwW+V25XK0dxWP9g9h0HVkmd3jBkGIztEMXeTJBrB2AQpC0m0PY1F5PLHTi2nR/wg84x4DOspwY+Y93vTOsQaBABkqlubSnjsl9UZiddxTAY8MX2sWCAdwoix2cDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzee/0zu0u+93BDy46qRjRp0rVhQ7X4OFaS6Gel42sI=;
 b=KA5i3ZQ3J8N/xGbHPM193MRWNltQE65vCsrmlxVTNyK6tSxSeIixfR4x8dVIoHRkzBsWIW5fXyqZ0vzg9Mw+F7UN5Tjz81ms5yVqdfz0kynWXaYMUqO/lt2IhEfQzjoo/vbC0vg/YsEpN9eUvlOOJV4x5vJPbnJLL/DW+xPx5J9u9aRjdtFcvlPeVlBuCzEfMiVY+WxcZ6cf5ryez1DKf2MwmR6rbuVs6kqM2bcAskuGEYNz09MKN+GWHgmi65saE+tKTW1f2UAg75REWUYPEbFzbE+E1JhJ9bdp2zVDoMd/CI5kBE+t6ZWGZccoL/RgzztiYsKQEadqEraiyG8xmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzee/0zu0u+93BDy46qRjRp0rVhQ7X4OFaS6Gel42sI=;
 b=hFS5+YHgUuIyRJjSQ5S+5xKdNLlIIi7bRF5CLqsLSW4h3RvTfke0G2b2cNuV05U1LEUMPH7jnvZDofgXPFcUOBkhHwwIjbeaj3s+20k8lT+0beoTs4GurZU0TrCfvYugia80DZdupAtJCspPewDWZkWVMJIaI5d4ilg3IfKo2y0=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3775.namprd12.prod.outlook.com (10.255.86.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 02:14:15 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 02:14:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update default voltage for boot od table for
 navi1x
Thread-Topic: [PATCH] drm/amdgpu: update default voltage for boot od table for
 navi1x
Thread-Index: AQHV22TG5d9NsjG/aEyM9oOEAVsXWqgL3OcA
Date: Wed, 5 Feb 2020 02:14:15 +0000
Message-ID: <MN2PR12MB334404F78227386E5E9F2CE4E4020@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200204140930.328662-1-alexander.deucher@amd.com>
In-Reply-To: <20200204140930.328662-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [153.118.50.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e7847a2-05c6-43ab-3a1f-08d7a9e1198f
x-ms-traffictypediagnostic: MN2PR12MB3775:|MN2PR12MB3775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37752A9A98DEF23675C25472E4020@MN2PR12MB3775.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(189003)(199004)(7696005)(110136005)(2906002)(316002)(15650500001)(52536014)(5660300002)(86362001)(53546011)(6506007)(186003)(26005)(81156014)(8936002)(33656002)(8676002)(81166006)(45080400002)(478600001)(966005)(55016002)(64756008)(66446008)(66556008)(66476007)(9686003)(66946007)(4326008)(76116006)(71200400001)(32563001)(357404004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3775;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7V0lb0qQ9/H9OZynS7h32//0qi+Lh5HHWxtdZ56bccS4WJee6i+W/IjbqdJJfZs8hIQ5RynPak8CyFTCGPXXeUGrAaI6NMfZs/9MPqpTsUKntW2LijxpFwIi46kFHVhv749HQcDtDBGl9odqtByjeh7cDJcX8cU8hl8dLLmOgOOAVxGjcFQafecIbzQmacRCCQiYiXd8j+Fe9yrXyB5j1x+KPpO4vFz8dFXhf49IRww7WMLNcx41bAOfzLvRhNCWgLLXydPJpvGOON+Oy0+wYavaEv+akqjik4qwG5HM9RJtQFo4F6ocmE0+h4CbOhGwdZoLvvAFU+Mj5b0omC7AowL57rNaiYB/Q6UyJ8Orl+H2iQX2gK4hQ9LTOGg+dpJHQgZRHCffFoGBAS2FSVHt1YZY1jH33+mrWqsFZVQX4xlDYWwHiT0p/uaEwKdzxhtqIQyHk+LoUseZo8ctH3KeLIcSClqEsSfhbRkII3xDu47xTy2A6E7nXEFp9BQTWeG0OCpYwqZZCF0GCMdA0Eat7wzQVSkiRKsYn9pzNbcJTtNcazCGKd5MBeVq92hsEwIjzD3mRvYgLk4tTzUrMnhscA==
x-ms-exchange-antispam-messagedata: uJNg2+w9GKX/IdVRPNFAuL7+wIkxXFfUwMDhsojIPJQxysoYQHEvDJSgNK3VKRD0pLeHBrckp4413e16DpGbNkyiKanADy8TlttGVS6MokNMmXOeDGRq84a7N/3QCcmh5fFEzhozIdf71d+gzzByKA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7847a2-05c6-43ab-3a1f-08d7a9e1198f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 02:14:15.6447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TBQmX9tJ5dq/WzMrU4GS5lOyeQGn/r5ZhTgHTk0UiJvesRVwvJDPdyGlg31EC/RV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3775
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, February 4, 2020 10:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: update default voltage for boot od table for navi1x

It needed to be updated as well so it will show the proper values
if you reset to the defaults.

Bug: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F1020&amp;data=02%7C01%7Cevan.quan%40amd.com%7C3d32affae9634cd9a06808d7a97be32e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637164221945744530&amp;sdata=3NpVEkdhWr6DnFixPlV91OFPCwvpyjCA3n5vTJu3tFg%3D&amp;reserved=0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 2c8c4cbce548..19a9846b730e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1977,7 +1977,7 @@ static int navi10_setup_od_limits(struct smu_context *smu) {
 }
 
 static int navi10_set_default_od_settings(struct smu_context *smu, bool initialize) {
-	OverDriveTable_t *od_table;
+	OverDriveTable_t *od_table, *boot_od_table;
 	int ret = 0;
 
 	ret = smu_v11_0_set_default_od_settings(smu, initialize, sizeof(OverDriveTable_t));
@@ -1985,6 +1985,7 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 		return ret;
 
 	od_table = (OverDriveTable_t *)smu->smu_table.overdrive_table;
+	boot_od_table = (OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
 	if (initialize) {
 		ret = navi10_setup_od_limits(smu);
 		if (ret) {
@@ -1998,6 +1999,8 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 										od_table->GfxclkFreq1);
 				if (ret)
 					od_table->GfxclkVolt1 = 0;
+				if (boot_od_table)
+					boot_od_table->GfxclkVolt1 = od_table->GfxclkVolt1;
 			}
 
 			if (!od_table->GfxclkVolt2) {
@@ -2006,6 +2009,8 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 										od_table->GfxclkFreq2);
 				if (ret)
 					od_table->GfxclkVolt2 = 0;
+				if (boot_od_table)
+					boot_od_table->GfxclkVolt2 = od_table->GfxclkVolt2;
 			}
 
 			if (!od_table->GfxclkVolt3) {
@@ -2014,6 +2019,8 @@ static int navi10_set_default_od_settings(struct smu_context *smu, bool initiali
 										od_table->GfxclkFreq3);
 				if (ret)
 					od_table->GfxclkVolt3 = 0;
+				if (boot_od_table)
+					boot_od_table->GfxclkVolt3 = od_table->GfxclkVolt3;
 			}
 		}
 	}
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C3d32affae9634cd9a06808d7a97be32e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637164221945744530&amp;sdata=RROln5GBKsBYmJtggV5szkEESSIRXqWiPfkcl4kUSkM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
