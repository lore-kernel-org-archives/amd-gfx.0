Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE6EC636D6
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 14:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D859810E222;
	Thu,  9 Feb 2023 14:07:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C95910E222
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 14:07:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyVLsEPp0GK8ZK3dM/rq3jBMtsUODEAWvKLseL6Y+33nlMKmtidrsRAsKDQ+Qip82y/US4PHLzdWIQNHusp7/19WafDQsHumvSgco2P0KCkeo29U6ZQUfRDfsOqYZVCdf/T4d5aWqNM7MSPalM4dn+DcaVLS1gSGxIiGr0hKSgACNMlSGeOIOUZqc8v5L09kKGdBvWwqg+JBvnh8aeqN1ZVEqSshWqpaEIQMlByl/eKjUn5iqGDSTi0Krz3ZJaof7+G0OF1BgSM6uDVK8QW/ov4j/Td5PmfmO3Dc9ZcWMmi3ZAZcXvZeg21YejBCRcDm80a/HS42kp5axQfhHmGP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTXS7LxeKjGPQxR27BCCdiQs9UxsAnz3j8lwr+m1YTw=;
 b=ZTMnAYsP8b5bBiJ7qWQw8GQ6+UdDF1fHPMXuBD6o7euyuGM6ARX5iXovNyykmfyDeKjYbqwNodRx+vvUU1+VYqeeQTbP3wr9Klk7CP6CDhmLovLmGHXm/TmaUmORVk6dRowdVrPDdymDUX0AV2d6oeiADpNW0poLqlBcxNk8yCF7Ig6J63gLOOSDW9yTiqo8HOxoDYOXVLwqTdzDvWyT45ABpxmCPmRjLAmRO3KLrhoSMmg4ELOWnKb0qjYyATsZk8q4TsR2qhCYd5qR3QPaN4pKK/Bk6rEFxx9ka6QbD2LTHvB5Btl1FT4W4JyModUOWObaYawVnGQD5NlO25UNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTXS7LxeKjGPQxR27BCCdiQs9UxsAnz3j8lwr+m1YTw=;
 b=HZGwymstTx/cjbXpJFKzesBX0Qo7LQ/T/mZ3JkKRK3c8HjzcojDiy46hPStdX9fv9gZZBQzoFnTUZmZxssol1gKsRLQ9G6vEJeBGzspXiCHAZJUs8A142+aQftu5MU1Fk6DOOGvZUfZQdBpa11TMOCdk9cWN9Omxcgo30Ao1C5A=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 14:07:37 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 14:07:37 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc11: fix system aperture set when AGP is
 enabled
Thread-Topic: [PATCH 1/2] drm/amdgpu/gmc11: fix system aperture set when AGP
 is enabled
Thread-Index: AQHZPIx+adHgjl/JvEGdSqa75QXi567Gpm2T
Date: Thu, 9 Feb 2023 14:07:37 +0000
Message-ID: <BN9PR12MB5257C720D97D90B3CAC594F9FCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230209134259.572460-1-alexander.deucher@amd.com>
In-Reply-To: <20230209134259.572460-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-09T14:06:53.5144618Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7707:EE_
x-ms-office365-filtering-correlation-id: 486f548b-b9b9-4ec5-85a6-08db0aa6ff92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BO6PH20m9AZI61Ooi03SVOzQCO2ukY1VpXdMVysVHBSYgtvKAb9SaFB1LvR0y0qN9d8flJ9Zu3mxn48OSmKicdOpkGm41ULp+Jj0cyruSbGFpiCzHCq9PVE1ml/tHdK2gf+FAdCuwmVp13RgUAz3P6wkxwOlNBraEuoaUZ6F2pDs+t4y6IfgplkBNXfA/ps2Tk88+9Egab062xF9PWSsPdH/BRfY7XW/d8sqxb+PCxmTTyaiNPmSjQT62dezJ4+LPGAWaA532+T2bEtGp1edeYxb744vCW0B+BSnDvAy2cCmxzPYMGhfiZ3tq7Mglx1uSQ4R+rDc2YqgLWx5oeLzCvqcDm1YhsP0Fx8InX66b+oWZ/Yrr7qc6Oggkp+L+dKgmeV6jPjRhjddaTl66CEsA/ingS7KTr26TsCMyK9DT2xS0tcnMX7tb2mbDjsHpXq+fFMb2oVZQaIbVJPQJ+Xu6ISobgLQsD8tAne4Lhmhm+0Dlq7EG59bM+BAevoFQ7eQrt1VRLo2V8qXh0z29WcUF4eBdw6ReG9JTc/06JfRdTOiA3DNtYabNJoNr8uJVnPeFISu0om2uXiBVYfKjMDmgaDVi/j7zAS812Hf32QiatSnH78LGL5Gugd4n8FQLcXnNzB8cw8inQ2cBg6MdgWQPoiZ8LfGwn93irz1RKScbMfZzY4TWJDB+wurSYAOrA3Cq/DvovdwX13IfhGVgk7AKA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(2906002)(52536014)(186003)(86362001)(122000001)(8936002)(38070700005)(5660300002)(26005)(55016003)(7696005)(478600001)(53546011)(6506007)(71200400001)(83380400001)(33656002)(9686003)(38100700002)(316002)(66946007)(64756008)(41300700001)(4326008)(8676002)(66476007)(66556008)(66446008)(91956017)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?owy6Az5tOkAnR2F1+L7bdP1leIOFKj4qPCOohqUOV9VPrlZp+69TBDepWmcc?=
 =?us-ascii?Q?r+vfzQJYx2eGt9t/O3OuCs2eZcM0fWAVgOjCJZ7x6gtKuIx97C+D9KxLw31K?=
 =?us-ascii?Q?RAIWSI0S78dIQbEIx5lUmnWKtK3sFivgSO033bQyxz9cVSJQjFvBRpgbM+ap?=
 =?us-ascii?Q?Dxfmm2qFMr6KX6ZLT9JhKYkxAT5FJ0wZbzRdPdIgc7HfFdAWaq6Uf3YfmYlH?=
 =?us-ascii?Q?FEAZRyaQtyGAQwa6z1up4omPWaNxGUH/8Lsr00n7TwCNXUhKHipzKrrXzqj8?=
 =?us-ascii?Q?Zt4KnLLc/LT69Ij4O0n0t8zVEZZQb/AMRmAQLyyeKOpfqh6PjlpqCDRkT7Zf?=
 =?us-ascii?Q?lm1unyH/Fb7hMjdjuxkqO5yEgHJEzEbFVPYInxVeaCEU/KJzqadvfhApmyYN?=
 =?us-ascii?Q?x69PhV0ljPu6XFZ40yQCBP+AJlmvXUb1GstGy1bWhKZu9kI5zPs8BDJKbJls?=
 =?us-ascii?Q?ZiewjHPTgeT8jIipI2b1bcpKcZgzW25X/UvcmUnTorDon2Ei259rCFh014vz?=
 =?us-ascii?Q?H8+NfiwQ0SFZ7/T2Eqv5nQV/C71c75sDrvGubY4xN2ONd+bcHGvMARl8fNKt?=
 =?us-ascii?Q?oO9j5greVrKEBYwVdwFo56JG2ZPOLwTbLQGXtHRPXV2USIQJ7xmZvKVxM++7?=
 =?us-ascii?Q?yt2SERd/1mwNXqrhAJ/OAdiYaDDIGlc6pHdwRraWVHg5jb7AoE4ZTdzLZdFG?=
 =?us-ascii?Q?LhxJ5mjjj+UWk1f37ARB1/mjYKbLxH3iPZwDQnHsd4Fcxl4Nh4rzzTN6XdS6?=
 =?us-ascii?Q?fgvFg7dcoVrLU8TwvWkDWgHIfDDgsbuDQuP6QSwotEV6pekeJWgX5Y9c4Vcr?=
 =?us-ascii?Q?iCb0JDKMxn/i1LZg/HQ1NNMz79h17vR8kd1BkxeRWAJ9hYCO8Eb5tNLWTP9M?=
 =?us-ascii?Q?CgOhlPAKTKjjgwi3X+vcB2PNWdrbYlv+gcX0crhf9j6PsNGLfiPetd96wakH?=
 =?us-ascii?Q?KFvy3FlSvpiy2a8L8GoB1LN/bPl36MRV7I051MVl5EvEKqYqMaTqpIhJkrlH?=
 =?us-ascii?Q?cq42sTJ1vKi1/I+Y57DK/Ccdllrar8jhj1NGOFxQZLCJK1fLkESnv7KZxk22?=
 =?us-ascii?Q?fVpm9KstLOag18vtIK5jwxmJx8H0Etct4b1jiWW/xZE0PrUXnz53j0JdVocv?=
 =?us-ascii?Q?iAeY9jyRUndUR0Vdh/nDFg1rtKzNocDOmlkm5Ud5ESV3qjyfWe8p26ja6EHh?=
 =?us-ascii?Q?3k5765iGKodJow901VjSYPlusSD2dMqc2h6e+Ct61IofvU5kOVP6hJgzZdu2?=
 =?us-ascii?Q?aGdalfybl9XwUxorOesVabT8yI183gXsET70xOznOmFpSjodSI1GfkWkZJ26?=
 =?us-ascii?Q?+ZrmLn47cWJ5nNLjqvCP0uB72GLw+TwLffpVIB/TNtHoEuYBvIvXVd+PZdYU?=
 =?us-ascii?Q?iAx8dMpH4OhtTQLdg/xVLOzcRZs5+w293xatRH4lxyx83qhKfIXPYjj57fOV?=
 =?us-ascii?Q?0VlKDPX45Sc4F5G3eZ9NHbKASxGPQvZ+bvcK/zNPnSOcbJkM0bbruEJZ7TvC?=
 =?us-ascii?Q?kfu354o71XyPGgj84XXKnUrTAloeOyGk+vsPFuJkfJw7qRd2UgmbDNHLmhwu?=
 =?us-ascii?Q?k31Jr7PTx2mIiOD2xzzr9jb7QcUrYVY9sB5s9fEJAoWr63euCLaT+6b6wNAx?=
 =?us-ascii?Q?WQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257C720D97D90B3CAC594F9FCD99BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486f548b-b9b9-4ec5-85a6-08db0aa6ff92
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 14:07:37.1073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80PGW1yhivkPSu5q0f9nXJ3AUdb4+em7M8hrZkaaJtVmLM1TLtmP+cnwxKi69JQ+n1x5zvSTUL4IGg6ySfjRLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
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

--_000_BN9PR12MB5257C720D97D90B3CAC594F9FCD99BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Alex Deu=
cher <alexander.deucher@amd.com>
Date: Thursday, February 9, 2023 at 21:43
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gmc11: fix system aperture set when AGP is =
enabled
Need to cover both FB and AGP apertures.

v2: fix missed gfxhub_v3_0_3.c

Fixes: c6eafee038ed ("Revert "Revert "drm/amdgpu/gmc11: enable AGP aperture=
""")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  | 4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v3_0.c
index 7c069010ca9a..be0d0f47415e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -159,9 +159,9 @@ static void gfxhub_v3_0_init_system_aperture_regs(struc=
t amdgpu_device *adev)

         /* Program the system aperture low logical page number. */
         WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-                    adev->gmc.vram_start >> 18);
+                    min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
         WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-                    adev->gmc.vram_end >> 18);
+                    max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);

         /* Set default page address. */
         value =3D adev->mem_scratch.gpu_addr - adev->gmc.vram_start
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v3_0_3.c
index 3dc17a3deedb..6e0bd628c889 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -159,14 +159,14 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(s=
truct amdgpu_device *adev)

         /* Disable AGP. */
         WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
-       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
-       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
+       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
+       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);

         /* Program the system aperture low logical page number. */
         WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-                    adev->gmc.vram_start >> 18);
+                    min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
         WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-                    adev->gmc.vram_end >> 18);
+                    max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);

         /* Set default page address. */
         value =3D adev->mem_scratch.gpu_addr - adev->gmc.vram_start
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_0.c
index 923fc09bc8fc..164948c50ac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -184,9 +184,9 @@ static void mmhub_v3_0_init_system_aperture_regs(struct=
 amdgpu_device *adev)

         /* Program the system aperture low logical page number. */
         WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-                    adev->gmc.vram_start >> 18);
+                    min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
         WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-                    adev->gmc.vram_end >> 18);
+                    max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);

         /* Set default page address. */
         value =3D adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_1.c
index c8d478f2afdc..26509b6b8c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -183,9 +183,9 @@ static void mmhub_v3_0_1_init_system_aperture_regs(stru=
ct amdgpu_device *adev)
          */
         /* Program the system aperture low logical page number. */
         WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
-                    adev->gmc.vram_start >> 18);
+                    min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18);
         WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
-                    adev->gmc.vram_end >> 18);
+                    max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);

         /* Set default page address. */
         value =3D adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_2.c
index 51580302ec42..26abbc6a47ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -175,9 +175,9 @@ static void mmhub_v3_0_2_init_system_aperture_regs(stru=
ct amdgpu_device *adev)
                  */
                 /* Program the system aperture low logical page number. */
                 WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR=
,
-                            adev->gmc.vram_start >> 18);
+                            min(adev->gmc.fb_start, adev->gmc.agp_start) >=
> 18);
                 WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADD=
R,
-                            adev->gmc.vram_end >> 18);
+                            max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18=
);
         }

         /* Set default page address. */
--
2.39.1

--_000_BN9PR12MB5257C720D97D90B3CAC594F9FCD99BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Revi=
ewed-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt"><o:p=
>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt">Rega=
rds,<br>
Hawking<o:p></o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Alex Deucher &lt;alexander.=
deucher@amd.com&gt;<br>
<b>Date: </b>Thursday, February 9, 2023 at 21:43<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject: </b>[PATCH 1/2] drm/amdgpu/gmc11: fix system aperture set when =
AGP is enabled<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Need to cover both FB and AGP apertures.<br>
<br>
v2: fix missed gfxhub_v3_0_3.c<br>
<br>
Fixes: c6eafee038ed (&quot;Revert &quot;Revert &quot;drm/amdgpu/gmc11: enab=
le AGP aperture&quot;&quot;&quot;)<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c&nbsp;&nbsp; | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 8 ++++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c&nbsp;&nbsp;&nbsp; | 4 ++--<br=
>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c&nbsp; | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c&nbsp; | 4 ++--<br>
&nbsp;5 files changed, 12 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfxhub_v3_0.c<br>
index 7c069010ca9a..be0d0f47415e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c<br>
@@ -159,9 +159,9 @@ static void gfxhub_v3_0_init_system_aperture_regs(struc=
t amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program the system aper=
ture low logical page number. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCM=
C_VM_SYSTEM_APERTURE_LOW_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 1=
8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min(adev-&gt;gmc.fb_start, adev-&g=
t;gmc.agp_start) &gt;&gt; 18);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCM=
C_VM_SYSTEM_APERTURE_HIGH_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max(adev-&gt;gmc.fb_end, adev-&gt;=
gmc.agp_end) &gt;&gt; 18);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set default page addres=
s. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D adev-&gt;mem_scr=
atch.gpu_addr - adev-&gt;gmc.vram_start<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v3_0_3.c<br>
index 3dc17a3deedb..6e0bd628c889 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c<br>
@@ -159,14 +159,14 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(s=
truct amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Disable AGP. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCM=
C_VM_AGP_BASE, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TO=
P, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BO=
T, 0x00FFFFFF);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BO=
T, adev-&gt;gmc.agp_start &gt;&gt; 24);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TO=
P, adev-&gt;gmc.agp_end &gt;&gt; 24);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program the system aper=
ture low logical page number. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCM=
C_VM_SYSTEM_APERTURE_LOW_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 1=
8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min(adev-&gt;gmc.fb_start, adev-&g=
t;gmc.agp_start) &gt;&gt; 18);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, regGCM=
C_VM_SYSTEM_APERTURE_HIGH_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max(adev-&gt;gmc.fb_end, adev-&gt;=
gmc.agp_end) &gt;&gt; 18);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set default page addres=
s. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D adev-&gt;mem_scr=
atch.gpu_addr - adev-&gt;gmc.vram_start<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v3_0.c<br>
index 923fc09bc8fc..164948c50ac3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c<br>
@@ -184,9 +184,9 @@ static void mmhub_v3_0_init_system_aperture_regs(struct=
 amdgpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program the system aper=
ture low logical page number. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, reg=
MMMC_VM_SYSTEM_APERTURE_LOW_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 1=
8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min(adev-&gt;gmc.fb_start, adev-&g=
t;gmc.agp_start) &gt;&gt; 18);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, reg=
MMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max(adev-&gt;gmc.fb_end, adev-&gt;=
gmc.agp_end) &gt;&gt; 18);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set default page addres=
s. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D adev-&gt;mem_scr=
atch.gpu_addr - adev-&gt;gmc.vram_start +<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_1.c<br>
index c8d478f2afdc..26509b6b8c24 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c<br>
@@ -183,9 +183,9 @@ static void mmhub_v3_0_1_init_system_aperture_regs(stru=
ct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program the system aper=
ture low logical page number. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, reg=
MMMC_VM_SYSTEM_APERTURE_LOW_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 1=
8);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; min(adev-&gt;gmc.fb_start, adev-&g=
t;gmc.agp_start) &gt;&gt; 18);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, reg=
MMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; max(adev-&gt;gmc.fb_end, adev-&gt;=
gmc.agp_end) &gt;&gt; 18);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set default page addres=
s. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D adev-&gt;mem_scr=
atch.gpu_addr - adev-&gt;gmc.vram_start +<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/am=
d/amdgpu/mmhub_v3_0_2.c<br>
index 51580302ec42..26abbc6a47ab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c<br>
@@ -175,9 +175,9 @@ static void mmhub_v3_0_2_init_system_aperture_regs(stru=
ct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Program the system aperture low logical page numbe=
r. */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW=
_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_start &gt;&gt; 18);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; min(adev-&gt;gmc.fb_start, adev-&gt;gmc.agp_start) &gt;&gt; 1=
8);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIG=
H_ADDR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; adev-&gt;gmc.vram_end &gt;&gt; 18);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; max(adev-&gt;gmc.fb_end, adev-&gt;gmc.agp_end) &gt;&gt; 18);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Set default page addres=
s. */<br>
-- <br>
2.39.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257C720D97D90B3CAC594F9FCD99BN9PR12MB5257namp_--
