Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85327C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 11:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD6C64F6C
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 11:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD6C64F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBBB96E217;
	Fri, 19 Mar 2021 11:27:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92566E217
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 11:27:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLfNYPF7PGFWLHF6plQpYrXJ8BP6gVnBhYV2xHLBZpLh2GVRNQwhxjBcd5G+eOsqGfRZrCAFq8fvHb3oQhD4dueamnVF0fL3QYrc+DE23whPG61/9gfNb92HcECYlhc5p+ZumE+EMb8re4PAGlAKCmI3d2XcMTpkui0aaoHJtP9MaY4aFPRhdc0UZZN8NQ8I+xgniJi/6qqtk64aVxSbxun13VZgkwgRwcTZyh5sMqaPgxHnPx9oPVSQEvnKChO9qqlDXgRlwO/lGZhNmwxdX/stKUSU/W1QGIFa3Rdcx5rLgrbIfL7oN4cKouwCmoArHBz4eDtWmkwGAJanTf1GVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7GAqAH/2MCaCGN5Eax1BNL/OmyqJtub64Rq75YDrLo=;
 b=G7DHMrHIB1UMykpNg1Ajho/3MS1MrboqcsB1Jeo+zKjGiv6cvZsUc+16tvDZ45Z9K62TBlZ/iD7FqhGZElYqkCCvHojEvfuhFQW2t+WWU99ijv+MV1PrKu0Sko2BrEIXl08Fae6SPHu9zSxGKrVozolMy/GF3vhORWD7WdjibeFqb7I7zsGLItrPasfyVAybXKmaffd0Yot/bct/CquCfRVWLnaWNKtp8I5+dBbvpOZ3JR7ZrLxYcOoCOKhqEz+nIFjKFynUf96sr9NoppC8PvlcSxGJfuKILHMDKlqyYlaKVqcT+PcWFENSdAWufHRhc+CVlLcVNvQuHFHEQ0PhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7GAqAH/2MCaCGN5Eax1BNL/OmyqJtub64Rq75YDrLo=;
 b=zo68YpaWMHcLiEF/Fr6uxA1ULrtjBidPeOqF4Dh8YUpFRtBtk3CWiovgR4DBUu6vY/yuS9jC9LYZKLFm/6MGxM1/NkI/DlDx0n+Turx8VWTbisU6nKIfqABhFUaMdwvg4UaBzzrZm4pkpqTfn8hm1LfKELVY8BT0ArnE7D97QtA=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4784.namprd12.prod.outlook.com (2603:10b6:208:39::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 11:27:01 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::58d5:c2:7a3c:4408%5]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 11:27:01 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not
 runpm capable is chosen
Thread-Topic: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not
 runpm capable is chosen
Thread-Index: AQHXHKABuRkeMzsUO0KIrrKF4uGir6qLK/ng
Date: Fri, 19 Mar 2021 11:27:01 +0000
Message-ID: <MN2PR12MB45492A307D0D53E9ED04F1F197689@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210319091155.537787-1-evan.quan@amd.com>
 <20210319091155.537787-2-evan.quan@amd.com>
In-Reply-To: <20210319091155.537787-2-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-19T11:26:59Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=fbc09ee3-99db-4c09-ba6a-28a77775390e;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.211.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e66fc93-331b-410b-1aab-08d8eac9ea75
x-ms-traffictypediagnostic: MN2PR12MB4784:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4784BBD95816783FD6161B4A97689@MN2PR12MB4784.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3vF1ThVw0m/HofaZcgcGXzxNfPCvTaVbE9MiyO8uQ006UD05GEXt5IfzidAGRUjmoyzaG3hQUBG/7YrpuRlEw/ZSgwZm+QExoGvjkPM1b/BbY0CbRjGbkwBHglqWB0sXjqNsXWIKmCL4BUUq1lY0loIJorOZRJEh3XWD+Q72je/VQ9HVVfSDXvqYGuoN6rWA/+nV0esVJKocb7IQvUKsCAEEjYQHkKgKLTDZvv3R55ZbgM4k27DqZr6XM58KebxyxmHliYhQf8EVl7RmuUoalEpLeQ/QHnlCUv0904uKBUlTh8P5QZqCucV5VZ1nyo/lqfZWS5nq3cHY1l4Ydqxug+XaEB5hXGy6i55RPuJYr8H0yvsWSKOUWVCoXA4sRTCHb+q8cWa/u9zhtm+mNKAoZsF3GE//4L94CwDqDLZODAe07XP/worFMoUMQisVbFCcrc7jVukv7iLAF0ksY46WG1M2cVTsuTd4YJsh2nB+mzqVZdv4Kt0XnbVRaWBVrXSa4InOM5cmAx7EC4wOGU2JbjTAJIV8cUqCO/Yn3Fq7n58+8QLcvFm3oNx5Us1Wm84dAYLJYsCY5mdLkoAkO2Red1zJT8olBhd/g8W5WtWfJSx38e4NWqWTNWlAGjJYboU8pgc6Fy8d3/mGxYezXjcR7f7dCRAFw/atpkmDid/Ll+D3DHFKbBT2BRK8MuaV8Dm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(33656002)(7696005)(45080400002)(66946007)(76116006)(4326008)(83380400001)(6506007)(86362001)(52536014)(66476007)(66446008)(66556008)(186003)(478600001)(71200400001)(53546011)(64756008)(110136005)(316002)(8936002)(5660300002)(55016002)(2906002)(55236004)(966005)(9686003)(8676002)(26005)(38100700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?B1I7wAFXpZwAAGcypYmR1/51eYfGnNCe9Cxk5eRNiajnQG9zD2+XmbufNwBm?=
 =?us-ascii?Q?bMcnFfPRhCFLElw+rgsLm5K/XUhuPbrWbdJpuiDXVq8g8Ys4U3D/hgg3xYF3?=
 =?us-ascii?Q?1T0R4bbf/uZ7uX9f/H21XKFFyDn/oBGYFa3Or3AJSoFkePfq9hcviamZt25O?=
 =?us-ascii?Q?i87azT8UqeD6PH4C0waMZH5WgVVehEVnLtQjqhBut2pezV/bbaunWZ3qWx89?=
 =?us-ascii?Q?/lz5WWCTKliUzI/Onj7f3U5Kb2PwduRBxY2xy1SyXNXL9OZ/zVA20S9asujT?=
 =?us-ascii?Q?+gKFaaadgecoGjKPG3DN2ZVN/NrTLOE4mWGlT0q8TmL9vD7PCd/+5S7m6WOt?=
 =?us-ascii?Q?EiaVnXfNRWVSK3X4U5SJEyUARckW7e4249CgmaenggmTDIfjkLxhs5efuYSz?=
 =?us-ascii?Q?UROJhfFFBAA+dyM1XgWWbvOcV+Ke5Wkoznp8v/0BSPieEZsyTMMzDUnp1zM+?=
 =?us-ascii?Q?mWqZfNIsLDbHZIPKyaxOGIRCZnN0YOipccffeGn/gMpx3IV4z1hBdRACNBS5?=
 =?us-ascii?Q?N4ArINWKIQ3PerV3q/9BfQz8AaQ5PfYqe2+3nnBrVqCiVImqSVZNZHtBEFfq?=
 =?us-ascii?Q?3qAenvy0ZLi4cMnOMZgsvJGW7OjozC9g6eut0K/+b09WoKUMhSzZgri0IpHB?=
 =?us-ascii?Q?d5VL+4wFZLuRuwZ6+F34/RQG3Y7TjCxmzuraY2N73J/l0GflvChPqf2c6t0+?=
 =?us-ascii?Q?RgApMEll3q5lcIFIjnhdmtSmNGmQqOj5XbvpRwdR8piE8KqnkUjjcpkp3j70?=
 =?us-ascii?Q?H1x/5bu1PKxMyFBMfk7QqcJrmMKC8Sz6eEsxnvohnmSdPKv+kZ0DCWhTI4V+?=
 =?us-ascii?Q?VB8wJwDdedsJaxMJ3iTCnj7T+PGwfZBrPToHSF829BvaWrsYYnMHUhHK/vX4?=
 =?us-ascii?Q?jgsWGDrj4t/dxZ3T9sgn5a0c6vfBrkmW/M2q0XQc8Q1C2ujSGhP+BzqiBPEd?=
 =?us-ascii?Q?+u95JWOSAq6olWrnyjmcJiXdBVyo5FlB7iYDKYIhoO0r4g0nDYsD2uq3wQSs?=
 =?us-ascii?Q?h2r/neiKLr/RpO4DZ+2MOn0ThKpTiattXvrK9NM4C+15hT59Nj46RNZAjlQ5?=
 =?us-ascii?Q?4kLg+LlJ+ZkQukcCI3kRUkz9/tbRzWc/vVmWPlKVNwIImju0JP1YjKxu2Ydm?=
 =?us-ascii?Q?uYrZ5Pa9SBaRozI1Pf2TKulBbKgC+D/OjgvRhmpIFobm+YFLeTr1ZAmH5yDe?=
 =?us-ascii?Q?1pDY2jTYGsWWEBF6FG/aKYiwcz//oA9R/3ww/9cRLaBXMWlCYcqDIBCsKvEJ?=
 =?us-ascii?Q?S8GahlwX3/l4fJUG9E07xTiirnkrSvWw+SoSEOid7EPizflq2n74fgcBPBX5?=
 =?us-ascii?Q?G7OxdhOZlOy27zYhQcRz95Rz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e66fc93-331b-410b-1aab-08d8eac9ea75
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 11:27:01.5266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pcf2jcGRvRP+4KHxGFl3DRubiYNm/p79dy/lgWhjK/qHVFFQG8hclSeHmiV8Gjm9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4784
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]



-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, March 19, 2021 2:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: disable runpm if other reset method not runpm capable is chosen

Otherwise, the runpm will be always enabled on a BACO capable target even the reset method was forced as like mode1.

Change-Id: If6bf55c533e91470c9c83383788466161608f68d
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/cik.c        | 2 +-
 drivers/gpu/drm/amd/amdgpu/nv.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/si.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/vi.c         | 2 +-
 8 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 963ecfd84347..be12dd2550b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -589,6 +589,7 @@ struct amdgpu_allowed_register_entry {  };
 
 enum amd_reset_method {
+	AMD_RESET_METHOD_AUTO = -1,
 	AMD_RESET_METHOD_LEGACY = 0,
 	AMD_RESET_METHOD_MODE0,
 	AMD_RESET_METHOD_MODE1,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6a06234dbcad..78e5445b28b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -168,7 +168,7 @@ int amdgpu_noretry = -1;  int amdgpu_force_asic_type = -1;  int amdgpu_tmz = -1; /* auto */  uint amdgpu_freesync_vid_mode; -int amdgpu_reset_method = -1; /* auto */
+int amdgpu_reset_method = AMD_RESET_METHOD_AUTO; /* auto */
 int amdgpu_num_kcq = -1;
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8844f650b17f..49068ad698a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -168,6 +168,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		adev->runpm = true;
 		dev_info(adev->dev, "Using BOCO for runtime pm\n");
 	} else if (amdgpu_device_supports_baco(dev) &&
+		   (amdgpu_reset_method == AMD_RESET_METHOD_AUTO ||
+		    amdgpu_reset_method == AMD_RESET_METHOD_BACO) &&

< > Why to link runpm suspend method with reset method?

Thanks,
Lijo
 		   (amdgpu_runtime_pm != 0)) {
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index c0fcc41ee574..e671871f4d28 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1395,7 +1395,7 @@ cik_asic_reset_method(struct amdgpu_device *adev)
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
 		return amdgpu_reset_method;
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 2670ae00c2e5..1e751d415f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -529,7 +529,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	    amdgpu_reset_method == AMD_RESET_METHOD_PCI)
 		return amdgpu_reset_method;
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c index 7cbc2bb03bc6..b9db761a7cc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1420,7 +1420,7 @@ si_asic_reset_method(struct amdgpu_device *adev)
 	if (amdgpu_reset_method == AMD_RESET_METHOD_PCI)
 		return amdgpu_reset_method;
 	else if (amdgpu_reset_method != AMD_RESET_METHOD_LEGACY &&
-		 amdgpu_reset_method != -1)
+		 amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 			 amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index c354a11e2fd9..ad11f2e1f4db 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -689,7 +689,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
                 return amdgpu_reset_method;
         }
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c index ea338de5818a..6b380a25e22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -895,7 +895,7 @@ vi_asic_reset_method(struct amdgpu_device *adev)
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
 		return amdgpu_reset_method;
 
-	if (amdgpu_reset_method != -1)
+	if (amdgpu_reset_method != AMD_RESET_METHOD_AUTO)
 		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
 				  amdgpu_reset_method);
 
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Ce8308bfec7e047a7552b08d8eab7231c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637517419584010454%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=OuWg%2B92YCNnINVD%2BEtasOsEbOutT1XMFMZYsmRkh1Os%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
