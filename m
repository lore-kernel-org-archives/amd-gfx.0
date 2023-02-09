Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E42C05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 07:14:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3D310E921;
	Thu,  9 Feb 2023 07:14:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 706B010E921
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 07:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGiypWPBI366Nf0gpItk1rIfxCb7MYl3QZVV8z3cEAdvwXS+Ro/OVIG9vDh8Qq16LWKY9bbYoUVkAAgKbQAITfC8buL0TvxE7/3/qs6wWvaSoZIAq1awC/qNVWvLeoiulBltsjnUKD1ispGqcUdqbo31N2ZYWlOEpiE4qvOr+/xnDflwE8U7no01KBV1086mGOPGa9Nx3YXLpiely8IREo6qaxXexGs74aoI2V9k1K9XEF7vnnwxyMKJgYVyH1Swb06SZEc8s7WyAIGoWBnpjtGuiMN4MdszJPbknZ+Gdo2Vo4/Zla9ZHBPfbDFtgs6zay+HqR54jSMYLMebPUjqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLGc0DHSd6q913LL0uWzv90IdIBlqbzZo9/YGfkWnRk=;
 b=cQ+Kjn/8ptkQRPcrfq20SdXBL7be6vHjm6nlmF6PJ0H5Ph29V7dlox+k781o2+kADvHHlGz53vd2whqxBmcTwSL+osNOkxuI7X8uwkdhhB0m7Vrhq1dZG0vYr9v7w+lkhEPRg/KW5cun+q03L7AXqx6ZVQhmcmBk1ob2GFAyZgeVqyejMEHl/2T7W2JQtYOvsYid/A3ou8bXnWW4wMrdwYlezErasjWW2rB76htKHuDSfNsdPAqS7+M2dzG9iOmoSd69YJQn4JECixIlVkxxkAlHKwkNC8pODzWkfDqdNGHUm3LqkW5A7HpPLLHbhu0eZ4v3PBAOsiHTI2mwC7fhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLGc0DHSd6q913LL0uWzv90IdIBlqbzZo9/YGfkWnRk=;
 b=qp6GReIuRxWLnVZfg7P4Km0RbV5n3WWusKNFiPo87Pb4DhmR57jrJNy6GDUQ5AlEQvseqMsoSgmq3+Is/rh34LrkI3jAc8sioRtKd9Yu04Gcqi9vettsUdGIsfXheqnIH3Zt01vhrjNCK+izLVnh9uRzk9G7D7O8pu3aMijb0gE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 07:14:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::27cd:5a5c:4713:83f5%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 07:14:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Thread-Topic: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup
Thread-Index: AQHZPEGDYOeRDQ6vM023lPktTuRCpK7GMsjAgAAA3nA=
Date: Thu, 9 Feb 2023 07:14:42 +0000
Message-ID: <BN9PR12MB525768CF42F0D7EE964DD267FCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230209044616.560657-1-alexander.deucher@amd.com>
 <20230209044616.560657-2-alexander.deucher@amd.com>
 <BN9PR12MB52578D18FB80BD45372C85CDFCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52578D18FB80BD45372C85CDFCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=cdd5f4d3-6137-43e8-bff8-11efe56428a7;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-09T07:10:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7416:EE_
x-ms-office365-filtering-correlation-id: f05c2eb9-ae24-4258-2d9c-08db0a6d5109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3gA+T0vOtGQJUVLNUkKFDB/ukqPSoU0eaFS7WqZo1y/4anNFbVfjZEiDW8V08JdNZooAMC+kXCEM8mdRFt8V1n66KNPt/j2gqbKbjPwW/0K6JcS/XXgXNUChZkrDQFstFyoHax8JNnb5f70Vf4LIEUXsSINR5PiAhlbVJrvlL53eFZwHQ0V/Uo5WdFh4fZm4M3N7Iu36iXm4nQetnPE1oOloeZrBC7HK6aEo711phqM5O8f0l6DRckdoapwOJFRhp52J0UnLRroMR+1tO+Tzk0ix9X4fEtUbCgBPrLBIRLVi4h9bmLIdjllnKzaj75xN3JDCdbeIllD+U6vVCNQkLoQOtQtnm6f77LfeUxDvllF6d1ojPWec/qnzW6VM9+NAhc5XCJFeeDSdGLz9kMULljPNE7CWFvxujkwYMH/3kJ1q7isWrRNvsOgW/4S81eYWgQiL/AJbvPrOKljMP/R3NyKqTdU8IbLUlI+Y2hd7Gw26WqqO73lyuic/Z62TDfdVaKuds1poDB1V7HKfJAozLFb2hf6cDU7ECmE7JY6gb9N+dj04wsHoRHLnLtdcatOFiT++jhwpL3z9vMuIh/rAg4fsRaqzS+dhoxPoaoeQ2jPJUkU32K74fJUxkEFkdDFcyYR+xEvnptf0D++eDl/hM2SmbbcBs2TQ3nr59+X4PdrKv0sAxSWu+4dLGZdwq6IWT51GGEC58yKfC1FoIMOow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(38070700005)(6506007)(26005)(186003)(86362001)(53546011)(9686003)(478600001)(2940100002)(83380400001)(122000001)(52536014)(5660300002)(8936002)(4326008)(41300700001)(2906002)(8676002)(110136005)(71200400001)(7696005)(55016003)(66946007)(33656002)(64756008)(66446008)(66476007)(66556008)(316002)(38100700002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gGJxd/3+uOi3GcqgVjt5D6mNXkvK9Gl8QEfly8mtUbRuRuHpRLtNHhCmml9x?=
 =?us-ascii?Q?fYdqC6MffAfgrMfrBNS+tD7KDPXCDboKlYxAzlP/fAzRf2+cldPijHBNmkjw?=
 =?us-ascii?Q?ecQs4/GHx21Ka9QE2fe15CGPb8JwE9t9yEjVKBxwQXyuViICCmFd5xlRNCGk?=
 =?us-ascii?Q?F0+yEG3SYOWwbc2ugy5I4vsehEgNPczlEHyU3+wG1dbPpafjZlsfDtRNDLYh?=
 =?us-ascii?Q?CjIciCkMwk/6jO+JBKy4GGkgJe5Mw5afSIWqDnAjjjdQ/R6E9hL0x9TkkSGR?=
 =?us-ascii?Q?BXBr7/5bCFJmS38V5i2zP1SXbQ81snhzfk0ZYllQ8AGy2yDdWz8ClYlr8Tab?=
 =?us-ascii?Q?5PVNw7HZRQbOi4MJnyayExuu4v6oc5+OeigFIIVzsM9lG6vpyB5U7Xgh+lL6?=
 =?us-ascii?Q?rJw5ckn4Ac54iH0SZOpHCYnbaXUveyZYiU0r1w4l2aPCeXG7/y7qWphPElh4?=
 =?us-ascii?Q?SH4bq/kBIgTA0wOLSNxjpFTyoP0Ua6iPedv4AQoU9SztJW9Pmy7oB2Gk3BJk?=
 =?us-ascii?Q?Eh3Stl3UQ8JOL+mcyP328/sDFLNdW3+MayO2XgqwmQ9eAg3h/5qDT2z+zLBJ?=
 =?us-ascii?Q?XDCX3BTjYul3D0vHb8LInlbWoYbdFV1dZs/4GPvNrzQ6/4cWsiMAc9OzrJdH?=
 =?us-ascii?Q?5DeMQmi2M7czCyEYcphtqq/sbx7ujfK27+lZknM/y+TsMJ6IdIF/cvf2zgqL?=
 =?us-ascii?Q?+OSqZ4Tajbzc1+DI9bCXvkq9FaHB77Lc7FwK837u3xQ5oO6fNY91LDWTDkW9?=
 =?us-ascii?Q?MkvTT9Ox70prRTKwVL1kow9MYULpQzSL/a8eEpoROqGXMU+nXhqpyAsCU48m?=
 =?us-ascii?Q?0/aGSwOfN++dQ73RhUEHMyD0O4s9tYzHyg+tRXzPxBulN41KiNK/6s5rt0X3?=
 =?us-ascii?Q?18e1dzpyB+9mKr7YXIpDDL5nzBtdFn8vGiUwIEc7vVHr8TD8zHF9AnQODoCi?=
 =?us-ascii?Q?c2rueQS0dkwIwfxaQPXGZj+rqJ3AgybmHwRWR6TgS3qp1+F1AaRY8Wh1YSNQ?=
 =?us-ascii?Q?YJJGChB5i3gVFE/tjdBpxSLD4/4SPEeHANdCUqNa+sUnbkzg63HNrFCfMSPf?=
 =?us-ascii?Q?2Hy3msJGvC49XXTBWnRr6z+5F+Ej/P+5Aei2kNvBgePiU2P7PONSWx3Oz+p8?=
 =?us-ascii?Q?A2suUPi6OX0ZzFV1zpMyy+Lj2HI/AmEW8NyJ64z8Fv2UPxDY9EEjQhFUEUti?=
 =?us-ascii?Q?4rOYlKVelxnEy2CGDcAB1dIx2RrseQDaxgbYHtij5l/eM4CFTveqp8QIxU9O?=
 =?us-ascii?Q?M4uY9XFyTgiJegphaRk7tFKRu/L87roJoZoeT5KPIj38YWtweIIOQInLAGwu?=
 =?us-ascii?Q?Bn20HOQhAtDqowT+k1kR3Iy9yTUJoAS30wonpzdyHCo3PTwy9w5tCiXoEmMB?=
 =?us-ascii?Q?QKYmlKmPOzLvVMZiNrNl7jRgYxBjI6ypXQpSiTTDmVHVG4lwQr4ZkJ2I4+R4?=
 =?us-ascii?Q?q5tPkikx6ncG84S9CokdAUAO/tE2CYbHYYcnNx46ZcAxKOyUadP9UnSiDL9A?=
 =?us-ascii?Q?S1PQZpQ1m3cUi5PWVWmq8AfiZSUrJGr1/o+1pl3MY1xHMF+gCmNeyKEOgit2?=
 =?us-ascii?Q?ZC4uyd3EglhiqfSFTsuMX43rkSZe2F2KkHJST3Hm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05c2eb9-ae24-4258-2d9c-08db0a6d5109
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2023 07:14:42.9700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UVRscA69DsI7Sn1N9o/fBQGjd0ILWp/flk2Ggnhh3wQU3HkHdCz4BpFsBcPxysvyC8eq/XzSklZqnYeIMvk1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416
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

BTW, @Deucher, Alexander gfxhub_v3_0_3/mmhub_v3_0_3 also need similar fixes

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Thursday, February 9, 2023 15:13
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup

[AMD Official Use Only - General]

[AMD Official Use Only - General]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, February 9, 2023 12:46
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/display: minor cleanup of vm_setup

Use fb_start/end for consistency with gmc code for non- XGMI systems, they =
are equivalent to vram_start/end.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8ba4a57d8e6f..bf06875e6a01 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1191,7 +1191,7 @@ static void mmhub_read_system_context(struct amdgpu_d=
evice *adev, struct dc_phy_

        /* AGP aperture is disabled */
        if (agp_bot =3D=3D agp_top) {
-               logical_addr_low  =3D adev->gmc.vram_start >> 18;
+               logical_addr_low =3D adev->gmc.fb_start >> 18;
                if (adev->apu_flags & AMD_APU_IS_RAVEN2)
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which @@ -1201,9 +1201,9 @@ static void mmhub_read_system_context(s=
truct amdgpu_device *adev, struct dc_phy_
                         */
                        logical_addr_high =3D (adev->gmc.fb_end >> 18) + 0x=
1;
                else
-                       logical_addr_high =3D adev->gmc.vram_end >> 18;
+                       logical_addr_high =3D adev->gmc.fb_end >> 18;
        } else {
-               logical_addr_low  =3D min(adev->gmc.fb_start, adev->gmc.agp=
_start) >> 18;
+               logical_addr_low =3D min(adev->gmc.fb_start,
+adev->gmc.agp_start) >> 18;
                if (adev->apu_flags & AMD_APU_IS_RAVEN2)
                        /*
                         * Raven2 has a HW issue that it is unable to use t=
he vram which
--
2.39.1

