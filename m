Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B551C47074
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Jan 2024 15:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2E810E029;
	Sun,  7 Jan 2024 15:31:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0941710E029
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Jan 2024 15:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2I37TXsfM+lwKmUg6jGj8sfxsBs0F8F5N+rUzWIPEcjwWbX+Jje3WlX60x8THzocBx7ps0bIwd1qJECabF1sDAQ+BnesE2Fr3xfpSMFZb8BbWkx1LTfkU2KgJitx7u3puxBRcrUKruzFvuYvirEyQVU08mB5dqvtu7SKHuvf2tjAD0Cmgt53QM4S8vBuNR9MsIaA/fzUt04HhyJy/ejlMVCwgdTR1+WP+lvJfCSmzaV3ujzEs8zWm+ExjT2qlmK2ATO8rl72bqj82pQA1aibnjleY6bEoR3TyWrAIEHmIGXMxax1Raab/qDkQNTveIVPM05J19F8l8VmoEzumL2dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87IApDeVfnb8sjhyL79i2kjnt8YTFFUnXRzJwO+tAgk=;
 b=TRm0ZC1SsIgHEyhPurelwvGa77n82obletSA2uXL6tjX5u1u2TwoAU8bLei/ON17ckIDo8H3AZ6hYl1ZzeyRsG97byAfOdaGM6u1bda/vkpZYlVUBgpGBmXtF3yU+IBMi/l2482F8rte7Yjqz8xZspZBRREOmg6ckTpstGNmOknsxn9o8CfyMlIB6A6g6lH0HW+ENFbN/vqXCXBaN90TCq3r80nimPDsYt730AGP3HYx2Eb19UOjpWyZ4YutS0WRkSpXm74WHtY5cre37FnlzI1wpP66CwKX2ZrDlgzcsFCc4NpViBGhZdqhidTrW0QJYBCystJGA2zx1vId92fu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87IApDeVfnb8sjhyL79i2kjnt8YTFFUnXRzJwO+tAgk=;
 b=wG7GlIDhb6GtisY9xQFtAskF+ZJ6FuUm6X54qkubnmG0biFbywVTNBXfCeRXCD2oMFWws2Yc6EHZxC/6fQ/YUakps3NpRyuUG5WFSN6YyCr3pnAMPs5ie3PuJpkMgA+nU+E0H+Qsd4l6KklPc3jQy8trZwDc/rAdWtUOEr8gA0I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BL1PR12MB5801.namprd12.prod.outlook.com (2603:10b6:208:391::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.20; Sun, 7 Jan
 2024 15:31:31 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::7ee2:4db2:1828:ba83%4]) with mapi id 15.20.7159.020; Sun, 7 Jan 2024
 15:31:31 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Morris" <Shiwu.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>
Subject: RE: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors v2
Thread-Topic: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors v2
Thread-Index: AQHaPYUthjskjuE4J0u1vb8gZmelhbDH2EYAgAapSDA=
Date: Sun, 7 Jan 2024 15:31:31 +0000
Message-ID: <BN9PR12MB5257E8F985D2207B11EE9ECEFC642@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240102140742.23917-1-Hawking.Zhang@amd.com>
 <20240102140742.23917-8-Hawking.Zhang@amd.com>
 <PH0PR12MB8773045911B6497C32A91BE8F960A@PH0PR12MB8773.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB8773045911B6497C32A91BE8F960A@PH0PR12MB8773.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7bf99cd7-1676-4010-85da-f02eeb8f8abf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-03T09:37:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BL1PR12MB5801:EE_
x-ms-office365-filtering-correlation-id: 27025b14-f8cf-4eeb-b3c3-08dc0f95b988
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLHmb3UskPyi6CPjojL7yghTgvh8C3jUK0x2ihWqouBNaBkk3xCpZhovMmDnScGWiRyyXjUD5J9SxJ+F20vkyvlssydaRLMDGHCMJ8qGnxZlbbuRYZ8CYrUUYq+QfM46au0Z7R/bHkhlZp76cMdtEo+ZxiqsDyO3cdHTliu6+uJdTJIDljELF2HhXYXZFq9R+tOoZ/QfI1r7DiQyllUtMk2lzvPwJnVKMIDUNOXgCXI3aRjdrcPLWQUlkePyfWORp8XPUiz4QidkmsgH3M+HYpAPdO2zLyz5hTRNwMzJ8pwcniqUvcTzcHTCMr4nLsB6e6KBiiKD4glps/hrbxFzblpk81zlVXj3d8URqiCqMOtFJre/nCoomp8ajVo6xxWAbdpusV6nKzIx8EgYWH+wNlhTYRUBg7OmJrtFPnulNHFRI6xrrV8YJRUEWKSlSE29FWLA7kfgTA9IvmLQmKElalnRX6x5qqz+jnfHFIQ9NlxwUHdDCqyutrtbCFpkbsgCzxMXmJawxKZEiam6FhxLzmwWMrUcpi/pDeqnmArvkeltOQd/F5y3jbRpHKPcBOSOfSqS8ljVNNnGKwGKXJqtI16NguF08epxuJihMayUII/dqcQBT9rfmS3WyACXHE0kVb2mhy4WRw2RieJX/og7Iw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(8676002)(38100700002)(8936002)(110136005)(54906003)(316002)(83380400001)(5660300002)(4326008)(52536014)(966005)(6636002)(478600001)(9686003)(53546011)(6506007)(7696005)(71200400001)(26005)(38070700009)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(122000001)(41300700001)(2906002)(30864003)(55016003)(86362001)(33656002)(921011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OSPWTvYVZ6KgqaKa5F7ndLuqsVN1YS2RYRkrLWYS6/cFfvqUanrOIcHFnbqJ?=
 =?us-ascii?Q?WKGWfQoPwNDCIcfKOE37vXk+pr+XQdxF8EYXAzbyPaTBwnQSAbsVYoFk+VZs?=
 =?us-ascii?Q?ughBX9ROLwH1n2EoET0wcklp8L/K2j+QgnIurjAefmzMFd4Mb2rE9wgnbJ9L?=
 =?us-ascii?Q?gwCW3Q2t0vzh0wOh/q4XD+ZN5AbLK6Hfd+qgK5x+Xap2zzAXMgai7hnxpOGn?=
 =?us-ascii?Q?afA1w7xWoajvtDCGlcTREoRDZeeXGK3YotzsAPBM/nZizxVT7EIiyv5MLkYZ?=
 =?us-ascii?Q?8cF9XcqjMrvHlWo5HvAAm+C7T9ROhDOXNg72UKfcOvAt8EMiojzadmowITPG?=
 =?us-ascii?Q?H5LaPZ9E0/OEJk0RI4en7gGDm2UHn9mP2Jl3JMJOdhtoZIL5jg5ZVf5ED/sz?=
 =?us-ascii?Q?RzzMaOJIoLGWaD1uGv85XyJJGrhiscId5qoefa2vqFi3sTVIxMJzT8LCr7hy?=
 =?us-ascii?Q?H55TnBPq0/imtjPrmWaP0el9wnIvFyc7rL/AyPBf4oeMT7k2PW1ZLJ0lirTR?=
 =?us-ascii?Q?ge3CEFt4e4BoTUrmj6+KRwPGTnFXCUdXnItp//ZOz8HG/x0gOioO/HCfBnOB?=
 =?us-ascii?Q?ib1OWhLN15IycQIO0YLz2FQ8qQ9Dis05TPeP7UTzjHkacnnnZ16esw43ng3A?=
 =?us-ascii?Q?Rp1xlaZ9c8br3kKLXx22lERW6YOSiY9UyCCvIxi6DkHLtmoR2btAPTVDhKt2?=
 =?us-ascii?Q?JsdZJuaug2vCX584GLkqAmlCFzJ8XbRj9/7KZWzF1qPEw3ykmjJxAsZZJ0hJ?=
 =?us-ascii?Q?lf67EtxNgMhmbzYzUAjwAN2P9twT5T58xHIgotQR6p1kl55lWZZIr5StJibG?=
 =?us-ascii?Q?dtIH2posEN2/VWogMdcF33/+bR2BMj2/aZrmsNsdep+l2lqpH0oOApUUrPHT?=
 =?us-ascii?Q?gZfKN0txnHzwJ2tLz1zfX3Ro9ThhAmYyq77LouM8zDYH2O9Y64+0By9SFHEY?=
 =?us-ascii?Q?wOZzi2+esCZG1ofpz6DKvUmx+90lBU8ndvL/5VRbDisRqKwkLBKwSEKgaDy1?=
 =?us-ascii?Q?wS8S6bIJbAPDyZO3PKS0jIS0a7Pdqp+LqErDMBVMG2de1FKgjM6Dq19o8T7Z?=
 =?us-ascii?Q?UvUgsZq3Y5huKi+YhKLvTGCW8ao1os1FH99kO5ERbFP0rg4iRJsNfnohz924?=
 =?us-ascii?Q?a0SYzO7qkaim1x2lawXMTfwITTuOM8CXvCmAOBBC92zpgxdGQ4ecm86PmgDE?=
 =?us-ascii?Q?V5pP+s/zeXYlaqJeKlzWeX0eYbXf95m5lErSKJeRHEsp4RfIGkicg6rVCo18?=
 =?us-ascii?Q?gD1NBCwHNPeejPVzaQOVNQXL6VYX/zZOhN79nGuxwvzRF8HBOpYfJ7AMNP6h?=
 =?us-ascii?Q?u5QA+Db0b34doPztD8U2kvCqroDi14vAFA/7bU/tHErZb6Mjco0JPAVAUeSL?=
 =?us-ascii?Q?dT7PRWQMVx2nnfJ4990327Mq0zjgOwifdH7xJ6fMbewXr+ADMOy91iRAgfX2?=
 =?us-ascii?Q?uY/zmFTCrCtxQB6rbDd6yLp+3gbCaUpkH7fy6xlFYS4u9+hZGQdcdX93mGBv?=
 =?us-ascii?Q?PfEOEwAzKnHrCapcB57vrwVO29qJtAQHDMf3E+6UjFfU04bZa22AHUT6fxnj?=
 =?us-ascii?Q?iM0o9XgNs9TDNJG02gc=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257E8F985D2207B11EE9ECEFC642BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27025b14-f8cf-4eeb-b3c3-08dc0f95b988
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2024 15:31:31.6919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gmNO75XTmcvTgO0objUMmr7mYm/kXbq+5fldLJICFI1qFfY6hEnyf2VsjZxrY1Jw+FOGZ+2vB/g6kBh2FQqMRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5801
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB5257E8F985D2207B11EE9ECEFC642BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Please check my comments inline.

Regards,
Hawking

-----Original Message-----
From: Zhang, Morris <Shiwu.Zhang@amd.com>
Sent: Wednesday, January 3, 2024 17:46
To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org; =
Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Li, Candice <Candice.Li@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Ma, Le <Le.Ma@amd.com>;=
 Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors=
 v2

[AMD Official Use Only - General]

--Brs,
Morris Zhang
MLSE Linux  ML SRDC
Ext. 25147

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounc=
es@lists.freedesktop.org>> On Behalf Of
> Hawking Zhang
> Sent: Tuesday, January 2, 2024 10:08 PM
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; =
Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>;
> Yang, Stanley <Stanley.Yang@amd.com<mailto:Stanley.Yang@amd.com>>; Wang, =
Yang(Kevin)
> <KevinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>; Chai, Thomas <Yi=
Peng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Li,
> Candice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deuche=
r@amd.com>>; Ma, Le
> <Le.Ma@amd.com<mailto:Le.Ma@amd.com>>; Lazar, Lijo <Lijo.Lazar@amd.com<ma=
ilto:Lijo.Lazar@amd.com>>; Zhang, Hawking
> <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
> Subject: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot
> errors v2
>
> Add ras helper function to query boot time gpu errors.
> v2: use aqua_vanjaram smn addressing pattern
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@=
amd.com>>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95
> +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |
> 15 +++-
>  3 files changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 616b6c911767..cd91533d641c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1328,6 +1328,7 @@ int emu_soc_asic_init(struct amdgpu_device
> *adev);  #define WREG32_FIELD_OFFSET(reg, offset, field, val) \
>       WREG32(mm##reg + offset, (RREG32(mm##reg + offset) &
> ~REG_FIELD_MASK(reg, field)) | (val) << REG_FIELD_SHIFT(reg, field))
>
> +#define AMDGPU_GET_REG_FIELD(x, h, l) (((x) & GENMASK_ULL(h, l)) >>
> +(l))
>  /*
>   * BIOS helpers.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index fc42fb6ee191..a901b00d4949 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3763,3 +3763,98 @@ int amdgpu_ras_error_statistic_ce_count(struct
> ras_err_data *err_data,
>
>       return 0;
>  }
> +
> +#define mmMP0_SMN_C2PMSG_92  0x1609C
> +#define mmMP0_SMN_C2PMSG_126 0x160BE
> +static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device
> *adev,
> +                                              u32 instance, u32
> +boot_error) {
> +     u32 socket_id, aid_id, hbm_id;
> +     u32 reg_data;
> +     u64 reg_addr;
> +
> +     socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_error);
> +     aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error);
> +     hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error);
> +
> +     /* The pattern for smn addressing in other SOC could be different f=
rom
> +      * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
> +      * is changed. In such case, replace the aqua_vanjaram implementati=
on
> +      * with more common helper */
> +     reg_addr =3D (mmMP0_SMN_C2PMSG_92 << 2) +
> +                aqua_vanjaram_encode_ext_smn_addressing(instance);
> +
> +     reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);
> +     dev_err(adev->dev, "socket: %d, aid: %d, firmware boot failed,
> + fw status
> is 0x%x\n",
> +             socket_id, aid_id, reg_data);
> +
> +     if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d,
> + memory
> training failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, firmware load
> + failed at
> boot time\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, wafl link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, xgmi link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr cp link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, usr dp link
> + training
> failed\n",
> +                      socket_id, aid_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm
> memory test failed\n",
> +                      socket_id, aid_id, hbm_id);
> +
> +     if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error))
> +             dev_info(adev->dev, "socket: %d, aid: %d, hbm: %d, hbm
> + bist
> test failed\n",
> +                      socket_id, aid_id, hbm_id); }
> +
> +static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,
> +                                          u32 instance, u32 *boot_error)=
 {
> +     u32 reg_addr;
> +     u32 reg_data;
> +     int retry_loop;
> +
> +     /* The pattern for smn addressing in other SOC could be different f=
rom
> +      * the one for aqua_vanjaram. We should revisit the code if the pat=
tern
> +      * is changed. In such case, replace the aqua_vanjaram implementati=
on
> +      * with more common helper */
> +     reg_addr =3D (mmMP0_SMN_C2PMSG_126 << 2) +
> +                aqua_vanjaram_encode_ext_smn_addressing(instance);
> +
> +     for (retry_loop =3D 0; retry_loop < 1000; retry_loop++) {
> +             reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr=
);
> +             if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {
> +                     *boot_error =3D reg_data;
> +                     return 0;
> +             }
> +             msleep(1);
> +     }
> +
> +     *boot_error =3D reg_data;
> +     return -ETIME;
> +}
> +
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances) {
> +     u32 boot_error =3D 0;
> +     u32 i;
> +
> +     for (i =3D 0; i < num_instances; i++) {
> +             if (amdgpu_ras_wait_for_boot_complete(adev, i,
> + &boot_error))
I suppose we need to check the boot_error value returned to report them in =
case that before timeout an error happens, right?
[Hawking]: We only need to dump the boot_error value if boot status bit is =
not set to 1 till the time out expired.

> +                     amdgpu_ras_boot_time_error_reporting(adev, i,
> boot_error);
> +     }
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 76fb85628716..5785b705c692 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -32,6 +32,19 @@
>
>  struct amdgpu_iv_entry;
>
> +#define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 0, 0)
> +#define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)
>       AMDGPU_GET_REG_FIELD(x, 1, 1)
> +#define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 2, 2)
> +#define AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 3, 3)
> +#define AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 4, 4)
> +#define AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(x)
>       AMDGPU_GET_REG_FIELD(x, 5, 5)
> +#define AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 6, 6)
> +#define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)
>       AMDGPU_GET_REG_FIELD(x, 7, 7)
> +#define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 10, 8)
> +#define AMDGPU_RAS_GPU_ERR_AID_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 12, 11)
> +#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)
>       AMDGPU_GET_REG_FIELD(x, 13, 13)
> +#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)
>       AMDGPU_GET_REG_FIELD(x, 31, 31)
> +
>  #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS                (0x1 << 0)
>  /* position of instance value in sub_block_index of
>   * ta_ras_trigger_error_input, the sub block uses lower 12 bits @@
> -818,5
> +831,5 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data
> *err_data,  int amdgpu_ras_error_statistic_ue_count(struct
> ras_err_data *err_data,
>               struct amdgpu_smuio_mcm_config_info *mcm_info,
>               struct ras_err_addr *err_addr, u64 count);
> -
> +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32
> +num_instances);
>  #endif
> --
> 2.17.1



--_000_BN9PR12MB5257E8F985D2207B11EE9ECEFC642BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Plea=
se check my comments inline.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Zhang, Morris &lt;Shiwu.Zhang@amd.com&gt; <br>

Sent: Wednesday, January 3, 2024 17:46<br>

To: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop=
.org; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@=
amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Chai, Thomas=
 &lt;YiPeng.Chai@amd.com&gt;; Li, Candice &lt;Candice.Li@amd.com&gt;<br>

Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Ma, Le &lt;Le.Ma@=
amd.com&gt;; Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Zhang, Hawking &lt;Haw=
king.Zhang@amd.com&gt;<br>

Subject: RE: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot errors=
 v2</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">[AMD=
 Official Use Only - General]</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--Br=
s,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Morr=
is Zhang</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">MLSE=
 Linux&nbsp; ML SRDC</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Ext.=
 25147</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 -----Original Message-----</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org"=
>amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Hawking Zhang</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Sent: Tuesday, January 2, 2024 10:08 PM</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a>; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com">Tao.Zhou1=
@amd.com</a>&gt;; </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.com">Stanley.Yang@amd=
.com</a>&gt;; Wang, Yang(Kevin) </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 &lt;<a href=3D"mailto:KevinYang.Wang@amd.com">KevinYang.Wang@amd.com</a>&g=
t;; Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com">YiPeng.Chai@amd=
.com</a>&gt;; Li, </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Candice &lt;<a href=3D"mailto:Candice.Li@amd.com">Candice.Li@amd.com</a>&g=
t;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Al=
exander.Deucher@amd.com</a>&gt;; Ma, Le </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 &lt;<a href=3D"mailto:Le.Ma@amd.com">Le.Ma@amd.com</a>&gt;; Lazar, Lijo &l=
t;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;; Zhang, =
Hawking </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Subject: [PATCH v2 3/5] drm/amdgpu: Add ras helper to query boot </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 errors v2</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Add ras helper function to query boot time gpu errors.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 v2: use aqua_vanjaram smn addressing pattern</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 Signed-off-by: Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">=
Hawking.Zhang@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 ---</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; =
1 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 95</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +++++++++++++++++++++++++&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 15 +++-</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; 3 files changed, 110 insertions(+), 1 deletion(-)</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 index 616b6c911767..cd91533d641c 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 @@ -1328,6 +1328,7 @@ int emu_soc_asic_init(struct amdgpu_device </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 *adev);&nbsp; #define WREG32_FIELD_OFFSET(reg, offset, field, val) \</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mm##reg + offset, (RREG32(mm##r=
eg + offset) &amp; </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 ~REG_FIELD_MASK(reg, field)) | (val) &lt;&lt; REG_FIELD_SHIFT(reg, field))=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_GET_REG_FIELD(x, h, l) (((x) &amp; GENMASK_ULL(h, l)) &gt;=
&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +(l))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; /*</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp; * BIOS helpers.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp; */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 index fc42fb6ee191..a901b00d4949 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 @@ -3763,3 +3763,98 @@ int amdgpu_ras_error_statistic_ce_count(struct</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 ras_err_data *err_data,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define mmMP0_SMN_C2PMSG_92&nbsp; 0x1609C</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define mmMP0_SMN_C2PMSG_126 0x160BE</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +static void amdgpu_ras_boot_time_error_reporting(struct amdgpu_device</sp=
an></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 *adev,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 instance, u32 </span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +boot_error) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; u32 socket_id, aid_id, hbm_id;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_data;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; u64 reg_addr;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; socket_id =3D AMDGPU_RAS_GPU_ERR_SOCKET_ID(boot_=
error);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; aid_id =3D AMDGPU_RAS_GPU_ERR_AID_ID(boot_error)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; hbm_id =3D AMDGPU_RAS_GPU_ERR_HBM_ID(boot_error)=
;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; /* The pattern for smn addressing in other SOC c=
ould be different from</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the one for aqua_vanjaram. We should rev=
isit the code if the pattern</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is changed. In such case, replace the aq=
ua_vanjaram implementation</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * with more common helper */</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; reg_addr =3D (mmMP0_SMN_C2PMSG_92 &lt;&lt; 2) +<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; aqua_vanjaram_encode_ext_smn_addressing(instance);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; reg_data =3D amdgpu_device_indirect_rreg_ext(ade=
v, reg_addr);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;dev, &quot;socket: %d, aid: %d,=
 firmware boot failed, </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + fw status</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 is 0x%x\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
socket_id, aid_id, reg_data);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_MEM_TRAINING(boot_error))=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, hbm: %d, </span></font></=
div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + memory</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 training failed\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id, hb=
m_id);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_FW_LOAD(boot_error))</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, firmware load </span></fo=
nt></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + failed at</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 boot time\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(boot_e=
rror))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, wafl link </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + training</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 failed\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(boot_e=
rror))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, xgmi link </span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + training</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 failed\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(boot=
_error))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, usr cp link </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + training</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 failed\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(boot=
_error))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, usr dp link </span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + training</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 failed\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id);</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(boot_error))=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, hbm: %d, hbm</span></font=
></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 memory test failed\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id, hb=
m_id);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; if (AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(boot_error)=
)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
dev_info(adev-&gt;dev, &quot;socket: %d, aid: %d, hbm: %d, hbm </span></fon=
t></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + bist</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 test failed\n&quot;,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; socket_id, aid_id, hb=
m_id); }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +static int amdgpu_ras_wait_for_boot_complete(struct amdgpu_device *adev,<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; u32 instance, u32 *boot_error) {</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_addr;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_data;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; int retry_loop;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; /* The pattern for smn addressing in other SOC c=
ould be different from</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the one for aqua_vanjaram. We should rev=
isit the code if the pattern</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is changed. In such case, replace the aq=
ua_vanjaram implementation</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * with more common helper */</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; reg_addr =3D (mmMP0_SMN_C2PMSG_126 &lt;&lt; 2) +=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; aqua_vanjaram_encode_ext_smn_addressing(instance);</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; for (retry_loop =3D 0; retry_loop &lt; 1000; ret=
ry_loop++) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
reg_data =3D amdgpu_device_indirect_rreg_ext(adev, reg_addr);</span></font>=
</div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (AMDGPU_RAS_GPU_ERR_BOOT_STATUS(reg_data)) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *boot_error =3D reg_data;</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</span></font></di=
v>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
msleep(1);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; *boot_error =3D reg_data;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; return -ETIME;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +}</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +num_instances) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; u32 boot_error =3D 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; u32 i;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_instances; i++) {</span=
></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
if (amdgpu_ras_wait_for_boot_complete(adev, i, </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 + &amp;boot_error))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">I su=
ppose we need to check the boot_error value returned to report them in case=
 that before timeout an error happens, right?</span></font></div>
<div><font face=3D"Calibri" size=3D"2" color=3D"#2F5496"><span style=3D"fon=
t-size:11pt;">[Hawking]: We only need to dump the boot_error value if boot =
status bit is not set to 1 till the time out expired.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_boot_time_error_=
reporting(adev, i,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 boot_error);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +}</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 index 76fb85628716..5785b705c692 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 @@ -32,6 +32,19 @@</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; struct amdgpu_iv_entry;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_MEM_TRAINING(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 0, 0)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_FW_LOAD(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 1, 1)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_WAFL_LINK_TRAINING(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 2, 2)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_XGMI_LINK_TRAINING(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 3, 3)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_USR_CP_LINK_TRAINING(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 4, 4)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_USR_DP_LINK_TRAINING(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 5, 5)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_HBM_MEM_TEST(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 6, 6)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 7, 7)</span></=
font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 10, 8)</span><=
/font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_AID_ID(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 12, 11)</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 13, 13)</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +#define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GET_REG_FIELD(x, 31, 31)</span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; #define AMDGPU_RAS_FLAG_INIT_BY_VBIOS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x1 &lt;&lt; 0=
)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; /* position of instance value in sub_block_index of</span></font></d=
iv>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp; * ta_ras_trigger_error_input, the sub block uses lower 12 bits=
 @@ </span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 -818,5</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +831,5 @@ int amdgpu_ras_error_statistic_ce_count(struct ras_err_data</spa=
n></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 *err_data,&nbsp; int amdgpu_ras_error_statistic_ue_count(struct </span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 ras_err_data *err_data,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct amdgpu_smuio_mcm_config_info *mcm_info,</span></font></div=
>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; struct ras_err_addr *err_addr, u64 count);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 -</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +void amdgpu_ras_query_boot_status(struct amdgpu_device *adev, u32 </span>=
</font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 +num_instances);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
&nbsp; #endif</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 --</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&gt;=
 2.17.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB5257E8F985D2207B11EE9ECEFC642BN9PR12MB5257namp_--
