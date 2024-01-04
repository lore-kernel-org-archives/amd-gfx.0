Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178F5C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 01:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC8B10E2D5;
	Thu,  4 Jan 2024 01:17:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540B710E2D5
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 01:17:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBcFkQ33S300ck5yJILGcmUYLk8TSNRzxPbNvJ8u4moWuKtKgrVrFAoF/2iLjuM3OpWhZc9qZWJQBWUF2cEu+fthOhqdiJ00W92+PaacFC2rfN9e1g4OYaB7JtoMVjABwXepSfL+6ZW4E+ue326LqiS3nOk0UqlVbqMohVc7KAwhxw62sH2nC8uBmYw3q3LDPl7idysmUi0TBNKrO9tI2Hf3/6zGa7z+zBQq4m4BXgIr//YYftyuv9Img1cldJzPKHaGNPa968eY1xFuSChjqPu4gTMGxTQfdWJdYuhEQdHv9CTFErFshA6ngT+JhZ7FC0ZkAQefi71QEHWAvv3VJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlnazGH1jP3IM23QGNjKWRUo25BW2bpMfAF+EX28lLU=;
 b=mzNottNlfCU3V2Rp2P7NBGVnJO3rpQPHCEnadMtkkpJLKEBPnEPwf6hSkdtHLwnwY5zWrF0KQcUziAlQ95/OSo3keHoDc4bw1jiipM+5WTUZEL2kp+QOxwCI5h1b5gqOFS4MB7+dkS8+FmbGapSzXTFgwo+fsUhu7/UgOwDFHvLT6DcssqOcJp1TZdrQAOgE+bQZKtG4jlr8/8cfxwrHDkpSwdzrlzhloDM6VpuU2jdIrdpuGlwVi9REc0t7cHIfJ7y5HzytlE7psKxtkAsBVdmaexkCmMHrTI7s6wJS929nhUY7ZrdV/FzqrrjPKDj76OH5MZ7hFXyt+ux8K+VS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlnazGH1jP3IM23QGNjKWRUo25BW2bpMfAF+EX28lLU=;
 b=Od5PPbZd0opukLUl8BosJejfWT4zNX3eiEtGuohoEA6sGE+Lxip33jvR1S1YhgjDNk3oY54RWOQmDpT6NZrRw3tkDdkfBEPMmR1zhPsQxePY74YylM3tWE4GH4Nl2tFUAikTKtO57bxqSuKToLmOKkHl8SSn6zv3wovYki9Abx4=
Received: from DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) by
 DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.13; Thu, 4 Jan 2024 01:17:28 +0000
Received: from DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::aaa7:40ef:adfd:9c26]) by DS7PR12MB6333.namprd12.prod.outlook.com
 ([fe80::aaa7:40ef:adfd:9c26%4]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 01:17:27 +0000
From: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: apply the RV2 system aperture fix to RN/CZN
 as well
Thread-Topic: [PATCH] drm/amdgpu: apply the RV2 system aperture fix to RN/CZN
 as well
Thread-Index: AQHaPo+PMv9wYvaExkKIxw6CnO3GnLDI1MuQ
Date: Thu, 4 Jan 2024 01:17:27 +0000
Message-ID: <DS7PR12MB6333D618EAF0FAC408920FF8F467A@DS7PR12MB6333.namprd12.prod.outlook.com>
References: <20240103215457.1780357-1-alexander.deucher@amd.com>
In-Reply-To: <20240103215457.1780357-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a26ff0af-64b8-4c38-8da5-3167cdc2924d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-04T00:57:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6333:EE_|DM6PR12MB4202:EE_
x-ms-office365-filtering-correlation-id: 609dbad5-64ed-454e-ca37-08dc0cc2ea5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h3b+jprcng79jCQfJj3Zdns44kpGSgyqr3vrG91q5L7lC80aP7Sli2fDTKjixOFpUICm7xp+2Xc9MXVDjJFghVOgqzlrKZFjpJr34XGGd2wg+KedKpzdp1gP3KsgnMUL2A/eEqGgGATUQKhO2MVN3OoJDj2QeVJYu5bok3Rk/k91bgB4M2aiyiams9sBwpkW1On+ANNpp8EcbK0mYcPevM19VaCugkF/yqgeCY2ErBU55tmhiZO5igaaWj8a9MBqYLFKXgAQ9o8x2+SNz1bkES/eOjjjiXi2pfZYus+dG06vjl+ZESxTsmPt2lYHak9hGppOdPbKs00CZaz/T4UpGjQA0f7hE5EWpLEPLL/u4376tGmp8kI2Lp6RyTxJT+Sblr5Mf8pey7rUAebelKQLECRsHnZ2Q4dejuRKoDmsE/NxousK7n12bYwP/fF29WG/tVUqBAziqlgRpNUGUvgTZnVvG4eDAG5XAnV4UtGAKZIucPURdcpwaUd4cS5zvMZ8iMXPysBHptwMubpTmEcRV9KcYM1BIQ3AXXQjJt0sTd/iFyaL/dujxN9d9+TrQjN/l6UbupNzzde6oSaF9PcrYTj/AQ0i6QvklqAt0md16catbrRptiS+yWSJDG3q2ukJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6333.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(71200400001)(7696005)(33656002)(478600001)(66946007)(86362001)(76116006)(66446008)(66556008)(110136005)(316002)(53546011)(66476007)(64756008)(55016003)(9686003)(41300700001)(122000001)(38100700002)(83380400001)(4326008)(52536014)(8676002)(8936002)(2906002)(38070700009)(26005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HwSdqKuQO6amVKVnGRJV5OYHbPta9lNFGu/UhtE/qkP4fKXWA9GewIb7QJ1u?=
 =?us-ascii?Q?AO1hcHRSF1UdZX3CpJmBWoZjPrcWtwDYC+cIjf2Bc4y120lovEuP2BXbZxuw?=
 =?us-ascii?Q?NE4lkKhzWFLnTrNRc5TmjRcCvhrAcs2xQr2RjMnQST0N82lEzVxr+tGD59eX?=
 =?us-ascii?Q?seIqPFUHpJSe1lgYNG0lQgOWJLFx07AwjJWdewL4+ur+Vxfpml5R1tJq0Y0p?=
 =?us-ascii?Q?zGeLmsmaZ1YRYQhmC+212KzSpnp64m7flkYJ5QPXS9lNrYh1fpxjePLnVZE9?=
 =?us-ascii?Q?augMAzTG3EU6R1ABbTc5ECyNNO2AAVmPagEDJs4tf7y7NXGrvvjplnLNMdUt?=
 =?us-ascii?Q?NHFte4qJNWrpxN0yDf/Xb2g/P/kbBC4OrYUWA7UIdWd/E8vFIo926X2L/Qm4?=
 =?us-ascii?Q?ffBCpdJoLypIt9weZmxQs/RBQWA+0DRfLKt474gJwf2v2lhA1m8SSK4WAQ//?=
 =?us-ascii?Q?TltVExsvZIZyZVdNgh/ZlP/pGT66Qas9xTG/MCUwUwm3YDfy4NGDu8viQ/sc?=
 =?us-ascii?Q?jNG3U/IOowbzN+eQuRKu663BnKX8rlExzOloCHMQ+44vkQ53YF3B3qlVzzYs?=
 =?us-ascii?Q?c23fFJ2umJYbjDqVV7MhofpvRhLvlqwM7GxTfIi15lR6zpQKW82hCq0WP6tP?=
 =?us-ascii?Q?Ez8aN4V2WGDbclto2ZKAyrSIkeuZTnRwXXHELAFQNzpEADEsmhXA9T82Ck8F?=
 =?us-ascii?Q?EXW4fdG9hknvAVy4R4HSAuyz9j5dTgK/h2RV/NepWtGtwUSp16Guwt7pVbbM?=
 =?us-ascii?Q?BnvgeGnLSEyJuceAw+Hf5ffen18lDS5Vw4uQj7AM43MGjv78xilSMDw36zrS?=
 =?us-ascii?Q?677RnCc8FMPO+mMpMRpCXuaUod++dsfjwWr+n/ZAoeTR4+Sjelg86JpJkEzf?=
 =?us-ascii?Q?xmoRhoSmooMuLrNh5FiTzcwS2iBQ/SMDN3f7GHbIKSx8NVXUe8N4vXVrE9SX?=
 =?us-ascii?Q?d1XMEbEAwH2SPQfRZuxFDWSusCyn3DNO3EcgO31ULqwi/KBcg6R3Gcv7bAya?=
 =?us-ascii?Q?oKXjo0r6LmBlFy7yH4wP1uoBH61XGuOpypcHH2Z1aM2EowfidfCPooJ9kWFZ?=
 =?us-ascii?Q?EllgWN5a7EylOwshLvhU2pT0pL8zJCzv4ZwEKsFtGItbfnLoQgp0yWoBQd3i?=
 =?us-ascii?Q?Mg+AYI+QwzbcsxSrUKdJ0ZsoMHqiQkXK38K0DCljANWgrxqk4wVgpScK2+vu?=
 =?us-ascii?Q?8u8pB0d+cntg9qOVjAWA84ezBVHIX09cFk32n16HwUGgcf613Pauj04xDQw4?=
 =?us-ascii?Q?gUCdZTjuxZYhbOAddAN2375xlZpbIiAkhP7WHHM6W0tigvtk7ug+GcwZja/5?=
 =?us-ascii?Q?F+eWR0mavdXf+4h1qUisRa1GiCrOmSGiyfq2mOj4QjpoDbjdY8UAUovkB+kc?=
 =?us-ascii?Q?w+hLb9PqHtBv3dw48r3tyl92AuY84ys1IekoY846mjSN/bZqQFR1j7KKf/B3?=
 =?us-ascii?Q?eVOVoQ9onbrlcSBt0TIZQSHlYBorKp1Naqrbi3xh+NmM5ktvpHuElyvk62DW?=
 =?us-ascii?Q?2qS6kQ+QUjffuQg0588hb0qgv3TD5jExP1P2BMuNNcHs6KXEeqNbwIFzUXu8?=
 =?us-ascii?Q?Y4a+FsJXVeUA80Uq6v0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609dbad5-64ed-454e-ca37-08dc0cc2ea5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 01:17:27.4607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czfA4Ns1exXKFyu35yd68fVHOAatvI7NELn8IRTGGIiAN5y1BzurW7ib3buzc+UAYmK1iZyiibjmHuyXHRKrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The patch is:  Reviewed-and-tested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, January 4, 2024 5:55 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: apply the RV2 system aperture fix to RN/CZN as=
 well

These chips needs the same fix.  This was previously not seen on then since=
 the AGP aperture expanded the system aperture, but this showed up again wh=
en AGP was disabled.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c          | 4 +++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c          | 4 +++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c           | 4 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_0.c
index 53a2ba5fcf4b..22175da0e16a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -102,7 +102,9 @@ static void gfxhub_v1_0_init_system_aperture_regs(struc=
t amdgpu_device *adev)
                WREG32_SOC15_RLC(GC, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
                        min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18)=
;

-               if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+               if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+                                      AMD_APU_IS_RENOIR |
+                                      AMD_APU_IS_GREEN_SARDINE))
                       /*
                        * Raven2 has a HW issue that it is unable to use th=
e
                        * vram which is out of MC_VM_SYSTEM_APERTURE_HIGH_A=
DDR.
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v1_2.c
index 55423ff1bb49..95d06da544e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -139,7 +139,9 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu=
_device *adev,
                        WREG32_SOC15_RLC(GC, GET_INST(GC, i), regMC_VM_SYST=
EM_APERTURE_LOW_ADDR,
                                min(adev->gmc.fb_start, adev->gmc.agp_start=
) >> 18);

-                       if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+                       if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+                                              AMD_APU_IS_RENOIR |
+                                              AMD_APU_IS_GREEN_SARDINE))
                               /*
                                * Raven2 has a HW issue that it is unable t=
o use the
                                * vram which is out of MC_VM_SYSTEM_APERTUR=
E_HIGH_ADDR.
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c
index 843219a91736..e3ddd22aa172 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -96,7 +96,9 @@ static void mmhub_v1_0_init_system_aperture_regs(struct a=
mdgpu_device *adev)
        WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_LOW_ADDR,
                     min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);

-       if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+       if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+                              AMD_APU_IS_RENOIR |
+                              AMD_APU_IS_GREEN_SARDINE))
                /*
                 * Raven2 has a HW issue that it is unable to use the vram =
which
                 * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So here is th=
e diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5a7ac1c35b58..0c35e4122612 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1294,7 +1294,9 @@ static void mmhub_read_system_context(struct amdgpu_d=
evice *adev, struct dc_phy_
        /* AGP aperture is disabled */
        if (agp_bot > agp_top) {
                logical_addr_low =3D adev->gmc.fb_start >> 18;
-               if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+               if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+                                      AMD_APU_IS_RENOIR |
+                                      AMD_APU_IS_GREEN_SARDINE))
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which
                         * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So he=
re is the @@ -1306,7 +1308,9 @@ static void mmhub_read_system_context(struc=
t amdgpu_device *adev, struct dc_phy_
                        logical_addr_high =3D adev->gmc.fb_end >> 18;
        } else {
                logical_addr_low =3D min(adev->gmc.fb_start, adev->gmc.agp_=
start) >> 18;
-               if (adev->apu_flags & AMD_APU_IS_RAVEN2)
+               if (adev->apu_flags & (AMD_APU_IS_RAVEN2 |
+                                      AMD_APU_IS_RENOIR |
+                                      AMD_APU_IS_GREEN_SARDINE))
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which
                         * is out of MC_VM_SYSTEM_APERTURE_HIGH_ADDR. So he=
re is the
--
2.42.0

