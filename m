Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8DFC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 20:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEDA10E8B9;
	Wed, 15 May 2024 20:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HqGx+Mce";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5275510E8B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 20:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ+tQlBDag4py67XZe3d5tSKAODdxCLjZigPXPnmNJ48hgzl89ERLDN6og1V3+h0JcQu3tpNkqj6bij9WMsEEC7BzaqChDUsc8vamZITMBNe5ubBX3fvz4rc1Xeo+lUqjCrE27VO2ERt3ClhHeXK7kOHS7SyE2RGm3Q56YtnFMC7LizeQJjay3O7qSC+3x1tkukiNoJupL/SY8v0QGL+PLvlWWVzpdeeRsNy8X7kxiVSHQgszhj6C9Ckp1STbD9Lue4Z0V55ehKZh8ixOZscoEMMczrKCNmegYJzZd5OEpX27iWNVxNKIFe6RWCJ1bNWFqv/8ox1NezzVut+NA6KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksn+s2ieJqqCWaW5lPAbZx0wIxpQXq+/nDnZY1bTkJs=;
 b=gMkUygILmxmRlN7O3SZHX1Ox5dreCAfFvjFKoOy4uai6Ftb+6haNJLuJQCPxk5weP4NOd0YC1KYujYVAZbQsWaK1VCgu3d0xrwQXFUQRuzGFXcyR7BGKSn7IPgksXkO1VLheBWwyLd+H2FSKvQS+dwEnrJo0/kyqh7RxUE8Wd72abhSlnq0cpA1EDr5eLovWRxCeV6MuvtkOvEgsdQ2OEzc2zX15v8Vhq8Xz1x8z3RsNBl7nJzMe2v9igd9t9Wv4dRjqLlFVQkmyfW5AM/kIEiH0p7Z0wF9PlQcglD6kjfEB5Uh3z6tpRDneVB/icEIJzzUayDa/p6qq4X33zpXEnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksn+s2ieJqqCWaW5lPAbZx0wIxpQXq+/nDnZY1bTkJs=;
 b=HqGx+MceZrr5A6SDwvt3JPWTUjsHKba2ooUKZuRPv83VA+Gy37gDH0HRsqzRpyMinUj6nVzg4tNwRYAuA5InBMzdBO1r7LjWbiB6r5AugkAASsk9sGL2yOh3JKYK5idZwI5sur9NEzOt4+cPUR+6iZboAeEoP5V690KonJ8k9Ho=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 20:10:06 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 20:10:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v3 2/4] drm/amdgpu: Add support to dump gfx10 cp registers
Thread-Topic: [PATCH v3 2/4] drm/amdgpu: Add support to dump gfx10 cp registers
Thread-Index: AQHapsJl+F0wMfDsPUa3gp4zCH924rGYuaPA
Date: Wed, 15 May 2024 20:10:06 +0000
Message-ID: <BL1PR12MB5144B860357AFBCC3A2518C8F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240515121754.1810181-1-sunil.khatri@amd.com>
 <20240515121754.1810181-2-sunil.khatri@amd.com>
In-Reply-To: <20240515121754.1810181-2-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=44da3f9e-963f-45a6-bee8-aaeb592a3ff7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-15T20:08:05Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8355:EE_
x-ms-office365-filtering-correlation-id: f49ae4e1-45ed-41c6-f2df-08dc751b0367
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?1dIDRf56yudrMkolY2/WtSJuDBuvqySSmzccMOSFdRgu7WswuID9KkDACxPX?=
 =?us-ascii?Q?4ZmiXx0UakLvJ8uACbzc2FP9ccIbd56EBQdh54kqwAAl5vzG2qatOY2Xf1e7?=
 =?us-ascii?Q?W3zrkZ7XuPJl4E5ylfat89HVUuoAvF2JmSxGw9Qli1Q2JcfCgi+0RfvCZ3Lb?=
 =?us-ascii?Q?VubBUYG7OOoWFj+/AOx4wFM55LZLAItU3LsKcT33cCOzoft6Jm/aOJW8Vy7S?=
 =?us-ascii?Q?5KEaJxfC7/j2SMhdn0lQE2Ldj2hMrCyS5cxdFFPvikch+jF7+YNaJtuMGSGg?=
 =?us-ascii?Q?RrB/aiDT3pj4Ju0ycf0WcmIAifYo6FdeY6+Wug40o4FaWbNJEHuHswosElqC?=
 =?us-ascii?Q?GBhJtehAM2FS3KuZhDPvMYL8QqFOT//3nXmuiBRRWeRhI6Tlbo/97L1eIeJZ?=
 =?us-ascii?Q?bwY0iitI8zUxDKplM5Ld5Bz81Ov3ICYnDkD8GUtdvvYz7EcfjRPo+P8+g2Uc?=
 =?us-ascii?Q?A4IyuTWmVXoBzAXD8ZOQYIdCBb7iJX/3tJhTC/ZAFKC9N7lyTPhoOB+GwRpQ?=
 =?us-ascii?Q?QpHwJjyG1qJ0jG4t5rpYPaJsvYrZuJ5JOzdogCOED5YX4HuF2sLYnABKL2RZ?=
 =?us-ascii?Q?/TQwfuxJA984VlJkD7V0OtMbzMBUrs3FjpGAEU6Qfo2EFoVfTx2O55rmEMER?=
 =?us-ascii?Q?giSEL3GE1rsc4x66SJzJNKdkwOBl83315GTiu30dKpbR8fbCuadEv+ZM+XhH?=
 =?us-ascii?Q?X1kYKMNainEeB9NjqtOEtaCPuBl0T3JDbZ+qPFzSMAuttW0aFYpyWhQljeRo?=
 =?us-ascii?Q?s7D6Lg5KmHUOZH0Bs06hoPq2g8TIpDT8KJ6tcD1kP5y4AbA8DJMvjP+M7PTT?=
 =?us-ascii?Q?ngOHeJIQeJ+5NH87YLqXkZ5NhXVKw7ZKqEnx6sNcnEwRHFHk9rIBkP+EsVd6?=
 =?us-ascii?Q?KAhSWKNDsP3MDWl9QaHORUdwpo7/+rlaKnE9n0Hw3YLj91NJ0qoJ+JbrCdJZ?=
 =?us-ascii?Q?0ioLqOQM1bCKxaKNe2tdHOl/pHFjY3rhhjuv6XJM0oyOM1Un/wYHONxwqzvV?=
 =?us-ascii?Q?bkbfDu1oiEFHeeNKeBHpld7/+Nj6MMXI3ukRnGlTLQ9+0iAgrscEI/guhbyh?=
 =?us-ascii?Q?+kD/LCuRi9qQ1QxQRUIIHoLb2H7/p9utb7pDCiGBeiWWMb8moiqXbNlPAD+t?=
 =?us-ascii?Q?QMXJc52eeuwjljoI0EZ77k1D5pzz+HM36ETEMxkROnbO0PY6vsRLUjr0Km5z?=
 =?us-ascii?Q?19vNV5gq5nP74dn7P8o7xAy/CiHPbur+5ieREqdJaeUiR6UvFS09UT80swFQ?=
 =?us-ascii?Q?cVtdun7a9WGyONVZR2MBSt9mBKW7IympZt2llZMPl5g+bcZ7aYZ6D1+jUly6?=
 =?us-ascii?Q?qmiNuMTDgNiEGdRmAi1MY6uVPx7YS1XBBzII2BLMl7R1uQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5peIN4YzrxM3gVo+xHIQRa3+kp9dpiSVOKCmmF1n71upXA7D9cPPwZ++VBzS?=
 =?us-ascii?Q?OpXTNf4H4v6Ozh5jkCOqNDJNDg79k7ZOkDTSf9r7cE/bLO2cmtk8gRRB87DQ?=
 =?us-ascii?Q?dV7as982S7e4AJew04Y8FKWct9PD5XpHIo/4btzYqtOqIDp2eanazOxFl15i?=
 =?us-ascii?Q?gh/Cue+M08RbmrPVbH4Ngj+Vras2vFY0+SKwkCoimTjnp/KC50U21Yxd1GgG?=
 =?us-ascii?Q?2KIYPG88eXP2vDlTKIgXYs8jM0NDluvUcIsOAPdVBx8fVlWTLGZmKkJqjNow?=
 =?us-ascii?Q?r785xtgA0ncuUid03lnHXkwQz7aRiVbeGOpqP3jmkGb7GXjIzTUyz0ipMyhv?=
 =?us-ascii?Q?xwusIvhMT0ATXtirscMvl0HlrR7v7FR4QPCp4vxZpZOp0OdJpTcGxq19vtXX?=
 =?us-ascii?Q?HfYRHDu7u1FxLGqQPQXs1TS7wWikTHIBws+puwD8uogS0zNT2GYOlF7MMt3L?=
 =?us-ascii?Q?hhRe62CoVHvAW6Iwdem8JhNMO9qBFzqPwRClkK8SDvJhAPi6r8uWd1dlw+7a?=
 =?us-ascii?Q?NoWG15mTExajjp3riQWrYxe6SIEgp7hnJs1a0Fm5VsGThBvuXsyS2Zc9JI2r?=
 =?us-ascii?Q?oK33EgqBJePb27BS7H5nZInu69v2ZgJOorL1fhPp4ONYyxT6zgaAt/iBloVY?=
 =?us-ascii?Q?ti+zXQxLJFzPblaWTSyX++aO+dqiFKVDGgjdcsNBvoKtvHvFdPg0l5j6gFKj?=
 =?us-ascii?Q?IS6h9O/Ejn/2burHbpE+j+u9UUAtO8v1F5452RBARaSrin0KW8EnZZaquXma?=
 =?us-ascii?Q?FnCvQYdt5tb8CCIrJhlAXvm54l5lgfQ8AiN1tK/kwO3xRFNT8OpSQ7kzyvrS?=
 =?us-ascii?Q?XWDVjAUfRq5SSv86g0ZYJ8Vx8atuq+/9TgMfK6e+wjCJVhMm++ku6bZ7TFT/?=
 =?us-ascii?Q?+HTWDGi7T9fjSkh/E62RXgjpx2LLRIH686u0wQckOEgKz5eemP68hxP8U8kz?=
 =?us-ascii?Q?QjlAkzh5IH0WVpAROP5uiyIbCoBa9L4jzX7gDXitkcP5w0POFNHIxlciCe2z?=
 =?us-ascii?Q?n2gDf8dU3ZJRLdcADsu388vQPzNv9ekPxBwxUEwrro9eDhzJEW+TawBpdBJ5?=
 =?us-ascii?Q?BH4jIxM5KaF8tX13LjHW3/rANe66Z+5U613uzLu4v73vnVIn9lQ+NkD7p5w1?=
 =?us-ascii?Q?XjIfDN1+RczM/tB4IOHxuH4i7b6d15wHdWEG56M2jyb5M0D/uBxOvrDGn+WV?=
 =?us-ascii?Q?b1C/A8r1rHLmcE1xBPzxTKvr2QT61F/c0i3hY1Om7xp3fbsb8HRq3D076fd+?=
 =?us-ascii?Q?Fsjq9rWzJQnQK41pB+0kf7fHtJ49AeQqIvzbaj9yluPKSYsrQkJew2/y9zA0?=
 =?us-ascii?Q?purp7weYigIwynU92N4nmgdUcwggQ45WXXkLcczzHnQXCYkOhX1nEJ3WzREc?=
 =?us-ascii?Q?R02RDnX2YIC7epnC0AQzJHUSx72nQeWtYCNOs758Y32+dGcp8QZEj3UZaXF/?=
 =?us-ascii?Q?CMqA2us4tTpmkEAv1ZIic7NNRzmMP+goqO4RuoQffb+41ix75IYCyCNmztaH?=
 =?us-ascii?Q?boMJGBX16PWhOATTn/f8sps51ta496Y8s6Kc1eFkc2+PqfzG5Q5criOGkpt1?=
 =?us-ascii?Q?NrTmL8fyIW5+uD8d6hA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49ae4e1-45ed-41c6-f2df-08dc751b0367
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 20:10:06.0909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22ILtF/9RpdhrUHPy7sME1ssuJUb7NsX01NViXyDhIvD4b10ZP7nYc/4BVKzsYhmkesa8cXHHoJlgR5C3qFHmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355
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

> -----Original Message-----
> From: Sunil Khatri <sunil.khatri@amd.com>
> Sent: Wednesday, May 15, 2024 8:18 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH v3 2/4] drm/amdgpu: Add support to dump gfx10 cp
> registers
>
> add support to dump registers of all instances of cp registers in gfx10
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 117
> +++++++++++++++++++++++-
>  2 files changed, 114 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 30d7f9c29478..d96873c154ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -436,6 +436,7 @@ struct amdgpu_gfx {
>
>       /* IP reg dump */
>       uint32_t                        *ipdump_core;
> +     uint32_t                        *ipdump_cp;

I'd call this ip_dump_compute or ip_dump_compute_queues to align with that =
the registers represent.

Alex

>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index f6d6a4b9802d..daf9a3571183 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -381,6 +381,49 @@ static const struct amdgpu_hwip_reg_entry
> gc_reg_list_10_1[] =3D {
>       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)  };
>
> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_10[] =3D {
> +     /* compute registers */
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_HQD_PQ_DOORBELL_CONTROL),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS) };
> +
>  static const struct soc15_reg_golden golden_settings_gc_10_1[] =3D {
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4,
> 0xffffffff, 0x00400014),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL,
> 0xfcff8fff, 0xf8000100), @@ -4595,10 +4638,11 @@ static int
> gfx_v10_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>                            hw_prio, NULL);
>  }
>
> -static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
> +static void gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
>  {
>       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
>       uint32_t *ptr;
> +     uint32_t inst;
>
>       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
>       if (ptr =3D=3D NULL) {
> @@ -4607,6 +4651,19 @@ static void gfx_v10_0_alloc_dump_mem(struct
> amdgpu_device *adev)
>       } else {
>               adev->gfx.ipdump_core =3D ptr;
>       }
> +
> +     /* Allocate memory for gfx cp registers for all the instances */
> +     reg_count =3D ARRAY_SIZE(gc_cp_reg_list_10);
> +     inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> +             adev->gfx.mec.num_queue_per_pipe;
> +
> +     ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +     if (ptr =3D=3D NULL) {
> +             DRM_ERROR("Failed to allocate memory for GFX CP IP
> Dump\n");
> +             adev->gfx.ipdump_cp =3D NULL;
> +     } else {
> +             adev->gfx.ipdump_cp =3D ptr;
> +     }
>  }
>
>  static int gfx_v10_0_sw_init(void *handle) @@ -4761,7 +4818,7 @@ static
> int gfx_v10_0_sw_init(void *handle)
>
>       gfx_v10_0_gpu_early_init(adev);
>
> -     gfx_v10_0_alloc_dump_mem(adev);
> +     gfx_v10_0_alloc_ip_dump(adev);
>
>       return 0;
>  }
> @@ -4816,6 +4873,7 @@ static int gfx_v10_0_sw_fini(void *handle)
>       gfx_v10_0_free_microcode(adev);
>
>       kfree(adev->gfx.ipdump_core);
> +     kfree(adev->gfx.ipdump_cp);
>
>       return 0;
>  }
> @@ -9280,7 +9338,7 @@ static void gfx_v10_0_emit_mem_sync(struct
> amdgpu_ring *ring)  static void gfx_v10_ip_print(void *handle, struct
> drm_printer *p)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -     uint32_t i;
> +     uint32_t i, j, k, reg, index =3D 0;
>       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
>
>       if (!adev->gfx.ipdump_core)
> @@ -9290,12 +9348,32 @@ static void gfx_v10_ip_print(void *handle, struct
> drm_printer *p)
>               drm_printf(p, "%-50s \t 0x%08x\n",
>                          gc_reg_list_10_1[i].reg_name,
>                          adev->gfx.ipdump_core[i]);
> +
> +     /* print cp registers for all instances */
> +     if (!adev->gfx.ipdump_cp)
> +             return;
> +
> +     reg_count =3D ARRAY_SIZE(gc_cp_reg_list_10);
> +
> +     for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +             for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +                     for (k =3D 0; k < adev->gfx.mec.num_queue_per_pipe;
> k++) {
> +                             drm_printf(p, "mec %d, pipe %d, queue
> %d\n", i, j, k);
> +                             for (reg =3D 0; reg < reg_count; reg++) {
> +                                     drm_printf(p, "%-50s \t 0x%08x\n",
> +
> gc_cp_reg_list_10[reg].reg_name,
> +                                                adev->gfx.ipdump_cp[inde=
x
> + reg]);
> +                             }
> +                             index +=3D reg_count;
> +                     }
> +             }
> +     }
>  }
>
>  static void gfx_v10_ip_dump(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -     uint32_t i;
> +     uint32_t i, j, k, reg, index =3D 0;
>       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
>
>       if (!adev->gfx.ipdump_core)
> @@ -9305,6 +9383,37 @@ static void gfx_v10_ip_dump(void *handle)
>       for (i =3D 0; i < reg_count; i++)
>               adev->gfx.ipdump_core[i] =3D
> RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>       amdgpu_gfx_off_ctrl(adev, true);
> +
> +     /* dump cp registers for all instances */
> +     if (!adev->gfx.ipdump_cp)
> +             return;
> +
> +     reg_count =3D ARRAY_SIZE(gc_cp_reg_list_10);
> +     amdgpu_gfx_off_ctrl(adev, false);
> +     mutex_lock(&adev->srbm_mutex);
> +     for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +             for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +                     for (k =3D 0; k < adev->gfx.mec.num_queue_per_pipe;
> k++) {
> +                             nv_grbm_select(adev, i, j, k, 0);
> +
> +                             for (reg =3D 0; reg < reg_count; reg++) {
> +                                     adev->gfx.ipdump_cp[index + reg] =
=3D
> +
>       RREG32(SOC15_REG_ENTRY_OFFSET(
> +
>       gc_cp_reg_list_10[reg]));
> +                             }
> +                             index +=3D reg_count;
> +                             /*
> +                              * Reading all registers take long and caus=
es
> watchdog timeout,
> +                              * releasing core for every set of register=
s read
> helps in cpu
> +                              * core not being locked.
> +                              */
> +                             msleep(1);
> +                     }
> +             }
> +     }
> +     nv_grbm_select(adev, 0, 0, 0, 0);
> +     mutex_unlock(&adev->srbm_mutex);
> +     amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
> --
> 2.34.1

