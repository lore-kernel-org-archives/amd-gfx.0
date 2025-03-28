Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA58C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 13:40:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F303E10EA1B;
	Fri, 28 Mar 2025 13:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A5ZKG7FF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5D410EA1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 13:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2HWiLjCMPy4BpG5EF2sWOnsbR+DrA7HHKhMpqzPrU/gR310R+kBvqYE5ByHdvklYo7/ZX+KVai/TVKCbVXdOJ65Tjy0vgW/zavDwt4H64xl6fIs8HUu3Uab84+JMu4tbBVP4bhUoCuQf+/J1xSbYjQYppQrWDMJgLN09bCbo47DW/GeC1yzWZjYWMQM1qxRhUZWVVneqNyr+4Sq8mtYsaUoyR7VA3nmltulGAv3XIwOjIAl0yUdlTmgMdOk/4jWtI4RtyaFasfPmjBR7BA1pLklcggj9eW1zxZrqy15wrGGXMNjTBSnUYp5nF/0keQHXVN8JUK/ufuSA93UhNGLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ht7pdHxO8+/xX6UfE/ugippqIRwXDhJl4U5jwmr/hAA=;
 b=l99BdhIkzplMepPfDTVdreaCz+jEcpsZqFkSwp4Fj+5Gu5s0964Y219c7kVKMJ3zYtWqR+5FGgA9r6xETo2EWYsVO/JOn5376km8dFYdldTEINSMhTUI6S6cKRZOToVv8dRKO3+0NWXNUJvSWVu1I9x4tHZEP+c8BdkqfF1QBde7FSXw0Y4lxWHip7vIBkgeidNP8yFq/BZ64dh7Mj4wk4rJJL0hAChnPqAePvs5zB1nfa6jUHMlGeTv+QjN7IPNNEue+qxIbdOOfBMn3Avczcp1PFftjFNmsvkDfszL2x+Fa9SEBiNHZaTW2Rr0WEYig+KUyaIfJh+rXH/n798bQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ht7pdHxO8+/xX6UfE/ugippqIRwXDhJl4U5jwmr/hAA=;
 b=A5ZKG7FFs3+/DqLBK5EtIfToN0pNGnbv9xYUNMnpDNwYbN8/dw6X4djihEInTVgoJmQLxXNJvXEolF7NEzeW9FX97wpcS4jp0VY0AkgNVIC5qiEAK3tTNriYYu5NDc1syT0gJCZsGOkk+21QzCuyL63yf9F4YG1aQP34kxNhdk8=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 13:40:12 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%4]) with mapi id 15.20.8534.045; Fri, 28 Mar 2025
 13:40:11 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] Revert "drm/amdgpu: Increase KIQ invalidate_tlbs timeout"
Thread-Topic: [PATCH] Revert "drm/amdgpu: Increase KIQ invalidate_tlbs timeout"
Thread-Index: AQHbn5a0DjEdBqd7WEazs3VKXv+8IbOIjp9g
Date: Fri, 28 Mar 2025 13:40:11 +0000
Message-ID: <BL1PR12MB5898C47DC2CBA35DAC5F2C1A85A02@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250328040525.3736064-1-jay.cornwall@amd.com>
In-Reply-To: <20250328040525.3736064-1-jay.cornwall@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ae76ebe7-b88e-4be0-bbe0-9266f45cdb2d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-28T13:40:04Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|DS7PR12MB8081:EE_
x-ms-office365-filtering-correlation-id: da543b77-6a2c-41f2-5986-08dd6dfe1041
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Lwd45gUnlikoGamPnGU/3QRGB+NjthmWnsHOs4A+2TuYpdx1jlgANiHNNN3a?=
 =?us-ascii?Q?WoXpWxLRtG6H8keMduYQdn1piWXm8LF9sc4lpe/qG/inHJLfJYun3IRZjOO7?=
 =?us-ascii?Q?48ezLoHItSvA+5GbmiLWESZvqkbt1xEH7x1RzozvT+YAmssTCt6bqeMbQwoa?=
 =?us-ascii?Q?VRhhnX9ckao/A/eZd4dCyNb0Py0QRbfAMukYjYm/SVRsY9IQbLcIGltIq4HZ?=
 =?us-ascii?Q?yZMgVf4hqWA0uWpZmWTkY0obAohK4WvivqE/xNsKC6kWR0IsYn85NCU3KwIO?=
 =?us-ascii?Q?9tPmLFA7y+4X5ELV5JKxcI04loUtAysahi70yUFK6n6VZNGUuHUwAoqhlmbD?=
 =?us-ascii?Q?bnz/bJo3F+t96N52hk4DeMj/aJ3HnU+yXAF8gi0xKdVG0pkm+qaa2N94cyB5?=
 =?us-ascii?Q?Q7BCXE13HW6Ed9dMd8gN56/prfG7zQUkrL5llkmlylk/0D4vwRx2snDp6lh4?=
 =?us-ascii?Q?G7Yb+QuVUarOzj7b4GeMSjYMII2e7W2Hq4iJni+4HnSNG/YkhwV0rBLpgLTV?=
 =?us-ascii?Q?159Lh8FnZptsrDu/wT0ZH9gu4Z1MuIaR2DZXP3dL7r883Z7x6gWA37vNVkX+?=
 =?us-ascii?Q?Rt7aefSbile01knt/t2CeHRr2m8MwUq0VrxLy0KmJp6JW4W8IG6z2K7r5Yta?=
 =?us-ascii?Q?bSfBkwyDGvVm7pCQ/5EL6pBPp2a/Td5hdJrld4Z1a/7OWneL5BjYAnwcVgK+?=
 =?us-ascii?Q?sa56xuskiNieBvlnrQ+oqlwCu0s1H5SFxFhAdyRk6UAxFekSS6E56ARMuS8o?=
 =?us-ascii?Q?7eoKT/wX3g4x3po9MwTJZEFytUi9rKaxiJP3aBz9PJ644auWztVlM5wm3ajm?=
 =?us-ascii?Q?sIwEAnf55utyaW0vPHIt4d1OndEuZoS+RhUM5c8TuK19GqIneZ5ABVZ1jvSa?=
 =?us-ascii?Q?v5IvnK8NJ5yJC0lw0NiCUKHXC5rq5crdxj7B/v2VT6Ha3+h7ti5XCsvCiQMd?=
 =?us-ascii?Q?3NacbcXK8wCMkLNYq0UxsNSFDqN8jHJO8FMoymetjDYsaYlCtuJDbHmYSP3U?=
 =?us-ascii?Q?m9xAdj28wuGtmm7fd99SOsxN973sBjsq9rPyWL4otsCGcnWNYkQ+/8MNoUuR?=
 =?us-ascii?Q?Kg5Swwqgo2K1xmrWmWYofmsiRnWsAuQsEIxBZCxW7fGUXYiQFDxvFsuJWG/l?=
 =?us-ascii?Q?jkIb7KH9x91T42bGFMvZuDy7DPCIy/K5zz7MYq20dWL6CrC0W59ldYyWGK19?=
 =?us-ascii?Q?vyTuFXF+DKGvS1esS7fYbK8nDwCi/PAtsu+AebEttxaZ932VlUSlxTv8m/Nz?=
 =?us-ascii?Q?JvPnZG8e+hMtGg7tmxXDZo+ieJBvLiKtPbhBoWUMgC6Q+S3abqRmyybr+fY4?=
 =?us-ascii?Q?R4MIkNw3j/QDmCxLwEF9rgMAvMJ/W4hAI6sQXRdims43GNsg37HYeZaCvIhi?=
 =?us-ascii?Q?duTJwAoXTMvzd9jlPf7VlAiLUruqMISFJRjH6C5MfKIv1COp+rBvh6QKYFED?=
 =?us-ascii?Q?t5ddcLoVvxEKmyXiloxcDuzvC8PD85WJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qdIXNPDRR4HD0j6h/mcvxOLNP+NOj+oO6JAKTozIa2hjU5R+Kpnh1o3bpvQX?=
 =?us-ascii?Q?FyCaPp36bF+5I0Y5bde85wmsrs7WZD11RC+O4Pnt4XG1RHIC4eAQnnzfyXZI?=
 =?us-ascii?Q?Yz9MJQRJlx+zfaHAWru7P1jV2u69SrCXuycMztX/hM3isC6PnMTA10Q+RCGx?=
 =?us-ascii?Q?xfYJ6CULLcRdJaSuMNLqn4lrA5RbWErKxa/NBOsYckILeOGolM7DeF7cLM7i?=
 =?us-ascii?Q?ty+m/znAPNwnpoE2qP/PXBcUPidBLwh/RSAaIOISSk91Iwr8iW0d+TPgeX5N?=
 =?us-ascii?Q?4c6yQDyJrNQHMw4yQ3piNOuOeqXOoHblpDrcU3Bo5S6lGirW1niRmqNQOmyg?=
 =?us-ascii?Q?8CiCNMHDPoxQoQJo/L7q5/um28R9QukwoDNGeOZzfsZrPQF3HP0FHjHkgCAw?=
 =?us-ascii?Q?dvi9jFaQG7/XvfryP0YqtmQYtKMQs8pu24XQvPLKobCtOSeniFo96ctjc7IX?=
 =?us-ascii?Q?zz4ar30x9iif5sDjGcBu0BAFvtaBAtlfg5Zm1u0jYseHBau0nhIVH4DZ72v7?=
 =?us-ascii?Q?X3ypPPHSBZZocGQDkq3cu9x1l23XoyMA9mUWJ8+TEP2aJVqPqCXIJGQtkPy2?=
 =?us-ascii?Q?03oR0k41kbpjTlqtqUdLixEua+Dyq2FkVrums5wQT1m7q7nPsltsWUSFMX+s?=
 =?us-ascii?Q?DCvC2fBqv84vA0ve1FHk+lxyhF2Z+bc42xFbcknkc5D+bGJo6/MlEIY83uNx?=
 =?us-ascii?Q?1RAQKqfiQmHpn9BU+2JQhhE9nukG/RIucoQ8eQJr76PW8B4POM9w5ozQh/Hs?=
 =?us-ascii?Q?L9dDCg0i7VDVFgWupqO8a++vdkuBHkhgsx9g6sJg1QGl3ffW++92FrdWZ+Tc?=
 =?us-ascii?Q?nmle652svYv7abSnaFJPWRr6P9afQeY/5+I0c5Dyld5ohSFDLq2v906WSlvU?=
 =?us-ascii?Q?Jgf/SPglk/XUQwtHbRgKmodbo2gFjkeK/qh382KoIunOeriQD0OvicRx/coD?=
 =?us-ascii?Q?xLFMQc6j1Ul9ix+7NbABbpAsFr2vmIOqrkYMI2VqG91gIVdGjANIR0qcFw5+?=
 =?us-ascii?Q?4UAFUMvIIq/QZ2AzEJamg070BboG0V9N5ONce0NdtSB+B5zjv2rq9r9IvJ+C?=
 =?us-ascii?Q?StZClU3cobmQYX4pbfsckqUU8PXqiME+yeJkSJzhV4k+znaWQ1uCwTn99vyR?=
 =?us-ascii?Q?w3QMKHUw68zcec87JrH/Dpyy+QcoMYssLoQjYgEr/ltve2fR/6qAtAFBygJ7?=
 =?us-ascii?Q?xd8OreZcOFoSfm1n5yA02osaA8jTtmwfqZ45vRyr3xeCjK12mu4ZZzPG0gr7?=
 =?us-ascii?Q?WUVA4NRCTelhR0vNO+8gNZtJ/b781hvChLFhu+m287ySaa5DrMMJpaZAm/jG?=
 =?us-ascii?Q?0HfH3Ee/XJ2dZuqel4cTCS394hO3fZqHXBiO1q1CZN4tB2DFUD7R4dsFyAG9?=
 =?us-ascii?Q?KqhKMXfjdky39BPXm2QmFAvB9wG1l1ZbRx2VoNxaWN4RRLZ8yhB1p0xICN3Y?=
 =?us-ascii?Q?uNE1AYJqEV7ra10IJ+57o0/2XrXSBXS1TF2xNhQVaYiM9zhsJabwVL0Pc3Hc?=
 =?us-ascii?Q?kxKSSE2PoBqHk9tw5emg5YbOn5vzitZR6PdvNSKqwB6JjEJgPO1ltM7UU4qR?=
 =?us-ascii?Q?63TMPvc4Fus4dd/eyyM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da543b77-6a2c-41f2-5986-08dd6dfe1041
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 13:40:11.8256 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dfPBq6oWtwjQi3hSj2VOHj0GKdIcABR9khjvth+gBhFkD99Mh0xVhDpNMj1yoIvMIrWzr6XQayxPQGuDYLEwyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: Cornwall, Jay <Jay.Cornwall@amd.com>
> Sent: Friday, March 28, 2025 12:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Russell, Kent
> <Kent.Russell@amd.com>
> Subject: [PATCH] Revert "drm/amdgpu: Increase KIQ invalidate_tlbs timeout=
"
>
> This reverts commit fdb90033846e2f23dfaaa01dc47fec7b94704d0e.
>
> Reportedly causing unknown issue in memory management code:
>
> [  128.047288] amdgpu 0000:65:00.0: amdgpu: Failed to map peer:0000:46:00=
.0
> mem_domain:2
> [...]
> [  137.815340] WARNING: CPU: 81 PID: 1006 at drivers/gpu/drm/ttm/ttm_bo.c=
:613
> ttm_bo_unpin+0x7e/0x90 [ttm]
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 ++++------------
>  2 files changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3cdb5f8325aa..ffca74a476da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -356,6 +356,7 @@ enum amdgpu_kiq_irq {
>       AMDGPU_CP_KIQ_IRQ_DRIVER0 =3D 0,
>       AMDGPU_CP_KIQ_IRQ_LAST
>  };
> +#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
>  #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
>  #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>  #define MAX_KIQ_REG_TRY 1000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c46e36a0cd9c..464625282872 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -699,10 +699,12 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>                                  uint32_t flush_type, bool all_hub,
>                                  uint32_t inst)
>  {
> +     u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
> +             adev->usec_timeout;
>       struct amdgpu_ring *ring =3D &adev->gfx.kiq[inst].ring;
>       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst];
>       unsigned int ndw;
> -     int r, cnt =3D 0;
> +     int r;
>       uint32_t seq;
>
>       /*
> @@ -759,17 +761,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> amdgpu_device *adev, uint16_t pasid,
>
>               amdgpu_ring_commit(ring);
>               spin_unlock(&adev->gfx.kiq[inst].ring_lock);
> -
> -             r =3D amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT=
);
> -
> -             might_sleep();
> -             while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
> -                    !amdgpu_reset_pending(adev->reset_domain)) {
> -                     msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
> -                     r =3D amdgpu_fence_wait_polling(ring, seq,
> MAX_KIQ_REG_WAIT);
> -             }
> -
> -             if (cnt > MAX_KIQ_REG_TRY) {
> +             if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1)=
 {
>                       dev_err(adev->dev, "timeout waiting for kiq fence\n=
");
>                       r =3D -ETIME;
>               }
> --
> 2.34.1

