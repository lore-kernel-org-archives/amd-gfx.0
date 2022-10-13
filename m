Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC46C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 13:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F7B710E238;
	Thu, 13 Oct 2022 13:19:04 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2045.outbound.protection.outlook.com [40.107.212.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A8210E8B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 13:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2uwK5RvU53CcpVOQcVK8zkfxIM3TLfpVivCoDdG7MoFNOkxuv7ao73kcYRLZiyBzqW/MHyiTsv0Mao8F+OZbhihiBSP/avCdSGHN3VbjLoDBQmkg9jkkK6vn7p9bJFPINUe21d9Lhbyt45P3VJjEYs9ZsA3USg4kpYo5NTiqtMepRPc1ojvpGFPWm8iLSdmB79lMRETd4YZdwwbURy5olJNzq3enY1tv4fWfFrOF9xeWI2VFPAfoFqVrXO7CytNT4PJWQ5lwnDsOOajMRPcJIIkN1x8x885G6pKi994c/mXjntlA/1ORJqoOZqoxBzv/swCW+ysGp8Gw2VjnE2tyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+LlVqTRXVjBHl/tnxaS3XQ+x44XlgGHfwMJ0P9pWg0=;
 b=a3hSYmvtquUjhsgXsqQTPm6MIuIKOrmB770M2S9YQrRFDl55Qky7GywUY+jsXrdumtbw30q3ffPuYOafK/XmoOyq3JL9oU76bsi9kXfe02J1nfISzV4Y47P6FCrD1w3wWcRYBa3rhMjrCcyO79HEG81f2G1x2I3t40AOlKbSOCgbgg+CWWD895xmlQ6dlnj4N2jeXIZAGYJrGI4mhEi5bKTo3s0HHeauun82SIrSD8GB9KllxP/ws44RaU4IfBWMVb/99oXud4gp+uMwJNHkYsb+KjANZA2ef6jcPl1VlpD0tRNFWUYJHOxk2EUCuraP4pf33ljmPOx6dHdgTqIXsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+LlVqTRXVjBHl/tnxaS3XQ+x44XlgGHfwMJ0P9pWg0=;
 b=O9LACaJmx4VKiroSKMMlJQ73Jax6M15D9htpZKkb8hPZVZaemTyc3g8eCwYwweYRUPb+Zu9oOfNVffBCOmmF5q7q3sV+IMQnGWGnu7OQnz2Hi2freXKyf2q+DS9UoJGndPNw7ZaoWKGaJHBycHGVR4sv4vGL8g6GTOZYBLl7Sko=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 13:18:56 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::892:bccc:675a:6187%4]) with mapi id 15.20.5723.020; Thu, 13 Oct 2022
 13:18:56 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: add debugfs amdgpu_reset_level"
Thread-Topic: [PATCH 1/3] Revert "drm/amdgpu: add debugfs amdgpu_reset_level"
Thread-Index: AQHY3t3evCHR4Nds/06vFlMGfxZcq64MTtLd
Date: Thu, 13 Oct 2022 13:18:56 +0000
Message-ID: <BL1PR12MB5144DA697E7ECFFCC439AF7AF7259@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20221013082745.46143-1-Victor.Zhao@amd.com>
In-Reply-To: <20221013082745.46143-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-13T13:18:55.739Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5899:EE_
x-ms-office365-filtering-correlation-id: 626ca710-0008-40d2-9027-08daad1d7ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5w9Nc6MrSd6IkalGu+LyyqqiteIlZOauUa+lmCst6QLfkgq2KwGKyOy/d6jbxFOC30vVCTJLVBlOVh+wkj1E6mRBDzpTLlQ7WgWvKac/ToFfhkfq1yK/LRV5i/yO69CWRGSzh9/Hq+VrRSDdJMDfrSlgcsos+rXrB2GySXq6XbmUEopuCBNW+zCpCWsfdL0qDcabE2RheehVJSF//hz+5l4MRDJKsoVEcW5G5YXXhXgzh+omBctdCHnO+hHtFce0KSzyKyET5FPVh1TRvz/wHbTjzjTjlvSumX81FdBVzydEQj629Tce31LHc5CnE/PiESMLVB4jg9WbUBMj/LlqqmFtNKWwh78qjqaF30oAsxq+UepmFFkWMMzUXmmFqx23VCbr64Xqg/xL/0J5zBjH/h0w5CrGfocb4jIRTQyqicDw5k9RzT8wJ7S23hMbZRtZ52OKpLfXpIIwQEaQA31GbqLJ67TCGQ7BMOuoOFf2mdPibAB04UuQ5gesG3jRryYVT68yC1YWzXlEYpKdAiurgQe3e+xD6R1ru1aq87RcxHgSoElqjnPt8kovb+2zAGcpVEkGmBg1tCuX/F8Fh+F4H2mm9d+RtryEeOle5o/15SPH75RORcbL1oFqWqzO7KD3FW+xy7byzLEkbvpkUJTNEavp+jdXYWPjvHSzMa1e41exh8rvm5r/Oaq4dBJ5X0fl7scr9z0zTqJabkOwCk9TwIkpmurCq+zZ9/jrdD2GLMji8C8Lnq+jUmQH1vmwZPYBkZljhShEEfIIf4XwhMizw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199015)(54906003)(83380400001)(38100700002)(186003)(5660300002)(6506007)(38070700005)(76116006)(55016003)(122000001)(8936002)(4326008)(64756008)(8676002)(66446008)(2906002)(66556008)(66476007)(110136005)(41300700001)(86362001)(478600001)(52536014)(26005)(316002)(7696005)(9686003)(66946007)(53546011)(71200400001)(19627405001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mth/JwB0weyxjQl3d/o/TKp+fCSR2B7BfSeXWNomRO/YYWUy1Py9tOPvh9Ll?=
 =?us-ascii?Q?59hfqhlcIsOrIqdRtH40AvgJpASe1mtNZ7LHJX/yYAj6U4Ymv2Q61J5xgMwJ?=
 =?us-ascii?Q?zNuD2q1AKq055X473M6YeOIMDNOJbiY9Yob9UkHooZYqdTnYYIOiTtnknpAs?=
 =?us-ascii?Q?6fvWWUMjBUiaYRgrY9jIgDFo+tNuwBm8yekK2MvF6sdfxFQQrBitOZrpLdPE?=
 =?us-ascii?Q?hac3Y2MaD+vwHlOcFTvnFXLXk+YDReQHFmHDL3bB5V4H/7jlEWge+CBCbQGZ?=
 =?us-ascii?Q?e2BWE+NbKJJXZxAm6O8RsguZjQNeWoIcfCOIVoj2ztfLtKfZVi38J73mw+Mq?=
 =?us-ascii?Q?XoQo5YQr7FOQVh4nOydEbEEZ/XDRoDjj2P3jopgxlHZfwlFygbzRR2yY9Xa4?=
 =?us-ascii?Q?+Yhel0tmivky1Qh86/5TrXrOzVItgAsnX3VvTD7VB9rXDNH39Ncx0s1hGIcr?=
 =?us-ascii?Q?5hNMNndj3i/g4MQlGN+Zm9amqhCH2IXDHeD5IQTr7Lip8W+zUQn+4Hyjj3rI?=
 =?us-ascii?Q?qVqi7v6bNA+1UMAHlt/8Yg4T0St0NbMlmQhCUK8kDrWetE0uNC78imTELwye?=
 =?us-ascii?Q?2vtXwkCrNQJQ7+u10sMxJZXo7DdFCiBjhqXKw3atsjuSJWRuO/RENMx0wIta?=
 =?us-ascii?Q?GxKjzgRB+DIkxXAKDhDCKupSruFFEm2UNSI7JhtCwHl93gO3h0eI9R5PMJz2?=
 =?us-ascii?Q?ibA1DndnRPq4L5dEj2L1Yyxn7QxGLtr71jgvvfNN3dOucS1QeHpWN1n2Fvxa?=
 =?us-ascii?Q?RaZERKQZ6MWCl8+/L6UliLzNjZ5p+EK+UfdLXL/pxwuPYWtalzBJ4tlxyXsd?=
 =?us-ascii?Q?vGA6BMLOMOpPXFFA5Bl6etrvvvlErKDnEqLJGzo8Cc0zihBjcns4pm9hWgg7?=
 =?us-ascii?Q?lZRr+FSVlNvaLV7xIKpxn0b7tFR7iokuaq5aFMkHTioLIsJA3Fufd35n5RLh?=
 =?us-ascii?Q?/kYnJnwU6BRab2XMLYDWs/dBSp3TAS6GkKFiNy9J4J2zz5Rbv8ljlubn/U1N?=
 =?us-ascii?Q?QGbRq/JySDXvsU3S2jzx6QbOfQW6g1FkELSRF3TqYOfDeW5pAkekfyeILSn3?=
 =?us-ascii?Q?Yr6fRATYZe5S5QdJIlJLlJ/g9KmGUhlK2/iP4pq7rocafvvU1OibL0dR+OPA?=
 =?us-ascii?Q?KWL4OG8bnUfFO9FIN1ReWFzEb1LH/Esyr2E8y0cmOOc1zCDf0X0BOPIgONPC?=
 =?us-ascii?Q?BR4/9jCS3RY75UvQfj9fP6U9dB9Ffrak5vUOYIwZ6r/j5v4Zfd9rIwukAZSY?=
 =?us-ascii?Q?lexsYMKlwd01edFhs74IlEzoXZzsvJz+iA+6j6qTUtzt1j/jtGtZOeffzUBu?=
 =?us-ascii?Q?eA3tO8uwNKHKfyoawNaiRKJRxIiKw7UhKEe6gd1zdSQtEHJpHwxzzq9VoaCv?=
 =?us-ascii?Q?6oig+hFO8a6+sSsxzjopT2/9b4qaV+5xLKF1HpD2GOX5wN5L9USYjA9MA7ph?=
 =?us-ascii?Q?foKM9LgqLHuhq5s+7NqdRSrPj14xsTdNzi9s8bFQY4UUHrQQ+jnhDC3iJaxa?=
 =?us-ascii?Q?nUoKIXvjakY2/kL1LECQUWHATP+8EEMhjaBaMNSxSUxzrVrr6ddG95BTxXkd?=
 =?us-ascii?Q?EGJBtx7ewwlsT6ZmOWk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144DA697E7ECFFCC439AF7AF7259BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626ca710-0008-40d2-9027-08daad1d7ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 13:18:56.5629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MgWzY9JD+iWivuSsZqtforv4mTwngSwPhjVMRNLooC4yLjhrmy1VwnpT1m/A2qqzXwFVpbrcsHt+hcOxdPVkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB5144DA697E7ECFFCC439AF7AF7259BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

This patch is missing your signed-off-by.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Victor Z=
hao <Victor.Zhao@amd.com>
Sent: Thursday, October 13, 2022 4:27 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Lazar, Lijo <Lijo.Lazar=
@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>
Subject: [PATCH 1/3] Revert "drm/amdgpu: add debugfs amdgpu_reset_level"

This reverts commit 3ae992d5e1194a16e3d977076eb5722fa6e410d8.

This commit breaks the reset logic for aldebaran, revert it for now.
Will move the mask inside the reset handler.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 4 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 3 ---
 4 files changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 3ce91f660c3f..0e6ddf05c23c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -274,9 +274,6 @@ extern int amdgpu_vcnfw_log;
 #define AMDGPU_RESET_VCE                        (1 << 13)
 #define AMDGPU_RESET_VCE1                       (1 << 14)

-#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0)
-#define AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
-
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
@@ -1065,7 +1062,6 @@ struct amdgpu_device {

         struct work_struct              reset_work;

-       uint32_t                                                amdgpu_rese=
t_level_mask;
         bool                            job_hang;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 6066aebf491c..de61a85c4b02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1954,8 +1954,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
                 return PTR_ERR(ent);
         }

-       debugfs_create_u32("amdgpu_reset_level", 0600, root, &adev->amdgpu_=
reset_level_mask);
-
         /* Register debugfs entries for amdgpu_ttm */
         amdgpu_ttm_debugfs_init(adev);
         amdgpu_debugfs_pm_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c
index 9da5ead50c90..831fb222139c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -37,8 +37,6 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
 {
         int ret =3D 0;

-       adev->amdgpu_reset_level_mask =3D 0x1;
-
         switch (adev->ip_versions[MP1_HWIP][0]) {
         case IP_VERSION(13, 0, 2):
                 ret =3D aldebaran_reset_init(adev);
@@ -76,9 +74,6 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *=
adev,
 {
         struct amdgpu_reset_handler *reset_handler =3D NULL;

-       if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
-               return -ENOSYS;
-
         if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
                 return -ENOSYS;

@@ -98,9 +93,6 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev=
,
         int ret;
         struct amdgpu_reset_handler *reset_handler =3D NULL;

-       if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
-               return -ENOSYS;
-
         if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
                 return -ENOSYS;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c
index 3e316b013fd9..d3558c34d406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -405,9 +405,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring=
, unsigned int vmid,
 {
         ktime_t deadline =3D ktime_add_us(ktime_get(), 10000);

-       if (!(ring->adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_SOFT=
_RECOVERY))
-               return false;
-
         if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || =
!fence)
                 return false;

--
2.25.1


--_000_BL1PR12MB5144DA697E7ECFFCC439AF7AF7259BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
This patch is missing your signed-off-by.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Victor Zhao &lt;Victor.Zhao@a=
md.com&gt;<br>
<b>Sent:</b> Thursday, October 13, 2022 4:27 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Grodzovsky, Andrey &lt;Andrey.Grodzovsky@amd.com&gt;; Lazar, Lij=
o &lt;Lijo.Lazar@amd.com&gt;; Zhao, Victor &lt;Victor.Zhao@amd.com&gt;<br>
<b>Subject:</b> [PATCH 1/3] Revert &quot;drm/amdgpu: add debugfs amdgpu_res=
et_level&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This reverts commit 3ae992d5e1194a16e3d977076eb572=
2fa6e410d8.<br>
<br>
This commit breaks the reset logic for aldebaran, revert it for now.<br>
Will move the mask inside the reset handler.<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; | 4 ----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 --<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c&nbsp;&nbsp; | 8 --------<br=
>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c&nbsp;&nbsp;&nbsp; | 3 ---<br=
>
&nbsp;4 files changed, 17 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 3ce91f660c3f..0e6ddf05c23c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -274,9 +274,6 @@ extern int amdgpu_vcnfw_log;<br>
&nbsp;#define AMDGPU_RESET_VCE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 13)<br>
&nbsp;#define AMDGPU_RESET_VCE1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (1 &lt;&lt; 14)<br>
&nbsp;<br>
-#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 &lt;&lt; 0)<br>
-#define AMDGPU_RESET_LEVEL_MODE2 (1 &lt;&lt; 1)<br>
-<br>
&nbsp;/* max cursor sizes (in pixels) */<br>
&nbsp;#define CIK_CURSOR_WIDTH 128<br>
&nbsp;#define CIK_CURSOR_HEIGHT 128<br>
@@ -1065,7 +1062,6 @@ struct amdgpu_device {<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rese=
t_work;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_reset_level_mask;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; job_hang;=
<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 6066aebf491c..de61a85c4b02 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -1954,8 +1954,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return PTR_ERR(ent);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_u32(&quot;amdgpu_reset=
_level&quot;, 0600, root, &amp;adev-&gt;amdgpu_reset_level_mask);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Register debugfs entrie=
s for amdgpu_ttm */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_debugfs_init(ad=
ev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_debugfs_pm_init(ade=
v);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_reset.c<br>
index 9da5ead50c90..831fb222139c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c<br>
@@ -37,8 +37,6 @@ int amdgpu_reset_init(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;amdgpu_reset_level_mask =3D =
0x1;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[MP1_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(13, 0, 2):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D aldebaran_reset_init(adev);<br>
@@ -76,9 +74,6 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *=
adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handle=
r *reset_handler =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;amdgpu_reset_level_mas=
k &amp; AMDGPU_RESET_LEVEL_MODE2))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOSYS;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_bit(AMDGPU_SKIP_M=
ODE2_RESET, &amp;reset_context-&gt;flags))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOSYS;<br>
&nbsp;<br>
@@ -98,9 +93,6 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev=
,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_handle=
r *reset_handler =3D NULL;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;amdgpu_reset_level_mas=
k &amp; AMDGPU_RESET_LEVEL_MODE2))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOSYS;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_bit(AMDGPU_SKIP_M=
ODE2_RESET, &amp;reset_context-&gt;flags))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOSYS;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.c<br>
index 3e316b013fd9..d3558c34d406 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c<br>
@@ -405,9 +405,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring=
, unsigned int vmid,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t deadline =3D ktime=
_add_us(ktime_get(), 10000);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(ring-&gt;adev-&gt;amdgpu_reset_=
level_mask &amp; AMDGPU_RESET_LEVEL_SOFT_RECOVERY))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(ring-&=
gt;adev) || !ring-&gt;funcs-&gt;soft_recovery || !fence)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144DA697E7ECFFCC439AF7AF7259BL1PR12MB5144namp_--
