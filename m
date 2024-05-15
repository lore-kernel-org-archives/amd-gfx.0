Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0FBC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 20:12:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0972710EBE7;
	Wed, 15 May 2024 20:12:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZFG+95wb";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93AAF10EBE7
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 20:12:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaKgwP6/5lXYUmtRgOxgoka34KZKn/6NUMEP5Ky394OE2D2oPxeWYBpUW7cXBQbzLinW6DhhjlxXB6LWrsv+d9xM5WKLSeNWX4siucVcuKr29CCwur3w/9qXOYnTUIejQ6x3jGi2cmrGv5J6ZfPw+r8VDF1uaeeVP0vqGhCKK0yO/wc++vCFcFp0kw8/byPDodX64hZyaJ3cQy8BnVAq2D8/OEf7zrcJLC+uuZT6kJ64Y0ZYCcDfji6qd7c+jAWs2gfY3oTdQzmzLxSC3eKahUlyXLG5VSAEBuJSfG48pBOhzrS7+/mtMoOE1QDfDjpabcSqzeuswVJ/sgoTIRxtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dln2CwsE+eywjrx+xOPpzZqNyYV6ISLgfHPh/BS/dTE=;
 b=MBHHSVUaSUP1fAae6gQDixZu/+oqaR23igSorKRzL/dMkcPrY5pIOU0oE6+/XIWfJwd13oaZpUQb6abWMMO7dMOR+NsAhQPZwrEzFHBiT2EoQJfrgyIBfUsOjR4g6u37BZNcnMScfbB1PJo6Xvr59jhzaEmo1tjqdR+Y/GT40JaD6FUnhsw2UCUrPIKLBGULTIkVDFXffC+8pvjU6dcs3I+ObQBfCcae+E3m8zTGgAs3X8yxvI5bF+NDGkG82PmkPomKh1RrCenGLXO5ah9zBVugscdzk2XvHCUhu0am0Ii7qpSohRVA3Iybg1eGUPgkDMmPw4Z7ZUZdXtP5luxZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dln2CwsE+eywjrx+xOPpzZqNyYV6ISLgfHPh/BS/dTE=;
 b=ZFG+95wbuFt2DGK/3+MqcdEuE7jkG7LwDHtp+y/ghD3XqTjMgmMX84h2HuK24d4RQY3nsNhlJvw9CJCmdruS8DgoDVZwKRLIcTLEwG5UdNMsQdO1Dp2nN6w+JFNZmStWPB9/33/X+Sct6W3CCPPYXWLp9pboOtQo4pZIuFA1Zhg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB6729.namprd12.prod.outlook.com (2603:10b6:303:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 20:12:20 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 20:12:20 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH v3 3/4] drm/amdgpu: add support to dump gfx10 queue
 registers
Thread-Topic: [PATCH v3 3/4] drm/amdgpu: add support to dump gfx10 queue
 registers
Thread-Index: AQHapsJmxIk0NDrOPUOJKXG1xcchULGYukeA
Date: Wed, 15 May 2024 20:12:20 +0000
Message-ID: <BL1PR12MB5144866E6DD7FD0EC9226EB9F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240515121754.1810181-1-sunil.khatri@amd.com>
 <20240515121754.1810181-3-sunil.khatri@amd.com>
In-Reply-To: <20240515121754.1810181-3-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=b76d944a-e265-4781-9e6e-44620b824aad;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-05-15T20:10:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB6729:EE_
x-ms-office365-filtering-correlation-id: 74c610fd-e96b-4d8f-1fe1-08dc751b5369
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?BjO8/MVm9FA090ifyANe6MTzpv+VMpzo4igbGZo482Lmqm8cm/NJD4boZ9tC?=
 =?us-ascii?Q?jHRSIePiqsL3O/wdJUUnh2CLWAk6bHRst9KUg55JEgdpEhHZE0MITuDhnaOy?=
 =?us-ascii?Q?j6pNkXFEy6eiX2emrG2LGWWKNVwz1ZTl372fox02GqPUOCmi7OKDypfe2Th6?=
 =?us-ascii?Q?AsxtPythxW/UB9q7E7TSz33+18N9lpSsePw/uSNHKwRRV+mP9t7vLUg6EK7R?=
 =?us-ascii?Q?lcRsKTx3yg+uAKpQaAVD98LgcbhGaU8GyfLAbtYFkYIUSpy2m0xHAG2vjfwq?=
 =?us-ascii?Q?6SJFn8eRvchALRTZ19TmA4qokXJmMZVOWWV1d6dm+gk6Djji4Qz0mvaNYCjn?=
 =?us-ascii?Q?5e/y0Dt2P8SxUWwyEVQGdQMS/29R3JA5zT+QDFJ0TfPU6xkbh+E7zvwgdYea?=
 =?us-ascii?Q?Ici5eAfK2VCiCkBamEzSvilBndPSRbQXmDbqi+BlhmaDbjssY72XgrnnpBNb?=
 =?us-ascii?Q?NBDNbxv1S//WJWLuR0goMk3Imi9FCYgneVEcNKtzJLTu40RFAV9tW2JTQhiN?=
 =?us-ascii?Q?9WBR2ZBP4OtWgPVzAsg+hBJS88iBxEGI+X1bD4GeoOWh92IqXWrAag1walzh?=
 =?us-ascii?Q?6nodpMwiCCCLaCnOq6Itn5vLA7l9soTVfCsAeejWHwXofeYTGB9Kkara96WJ?=
 =?us-ascii?Q?hatWr5TcRV+lo5aRhUJCRRRupLOaL+VCJ3YxONA8S6s7+pX0jtF6Na56Ol4C?=
 =?us-ascii?Q?EeT+lNysIP5ulDkNoYXUKMA5DTg/VJHlbUOOpLFkj4ZcA8DKKAM7LULFNyCX?=
 =?us-ascii?Q?R43cH1OJZF1akXPoLzXMmH3Vjn7yrEYCVzbzkS98Wyzk+nWh/jpZ2lZx2yh2?=
 =?us-ascii?Q?enCLjr/6DhhM4hFAWSSh8JO4WoGGDd7KgIdEZiUZ38CjFjMNDhJsusNDC7hs?=
 =?us-ascii?Q?DHIcM54fs/EZz6HNP3Shu8uOyhFSrqd59ZSGKx5u9aMvgB4wHS2+HyvyItxZ?=
 =?us-ascii?Q?txB4N3ejTr8BGuqB7NhE7jV7RPD8/3Ck7yVxA/BNEvNuKLR7TW44918eREYY?=
 =?us-ascii?Q?uGk5euCVsgCXr8eix8+IMv1nrj3RghaqrGU9M0+4JloPlKSrk4DphZYzMr/e?=
 =?us-ascii?Q?4PAHxhL7b5sex2uzfuJh6/Mw3abRRd/d/fHh9Z8DiH9dOF5EpVm4g1+20iQT?=
 =?us-ascii?Q?spTn93O+3gUUb7ZTs4zV1AprcjP1CdmhTLqY4Aguh3f3o4zLH7WRz+QjH9mw?=
 =?us-ascii?Q?7q0U/+BjaWhWhRX2pFGELLeuw0Vego5qxP/k5Kr3t7Upm1uBRt2WO1Li7NX6?=
 =?us-ascii?Q?RooYDdol9bcDVvxxkTXa4dxdQfDgcbtDwb7mHV+31UHmZbpajds7dwuG27wo?=
 =?us-ascii?Q?43geOVzOYpgqw4VrNCBl8GQpApwy66+EVtLJR+FmPdckNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?947WR64xxrlyezGg259b4TG4kHsPKN7rqdNe4w7CIU17kvxPTZdSRTZMJ0ku?=
 =?us-ascii?Q?0u433HngE+kiJIZ5FBnzp5NvV3bchGAosffMPjKECsM2Pz2UEB0ZL+G00QII?=
 =?us-ascii?Q?6WcHNjsLVBqMa6YumQpRamaIoaP5wm6iJAgdgBbymvXMNslcmFwHgsm3QLLB?=
 =?us-ascii?Q?UketHhrLVXvy5dxEi0Leg1fg6qFMYczXAq58TIB13tls4xNA9Gj6NCeiOtWR?=
 =?us-ascii?Q?5rHkfsY865Mq2UzbfigmeQ3NNlcigkt2peADWRl+IWgwB5w6SsjJSJyHAYSz?=
 =?us-ascii?Q?Q+1L2rE2qHqAvSVqJMAu4TL1SIcz0YAcj+p0rgCZZXjWxkx6DIM/SY0S+8Qt?=
 =?us-ascii?Q?XJfULopZ3s51Aym70tnG4HPO80O5ZvjDJ+RYBw8XbxESrSGd/InTIiWJCJhG?=
 =?us-ascii?Q?MNwxlhO7U9Kr1UKDX1Vps5VN/XubNDcQ+6YOrb8yViecdyyDBycpxT081B4i?=
 =?us-ascii?Q?MicLd7nysM9kNmCnp3+YwyJp9SsbXh37kWz7dZdvfULgw4V4uEzSNBr3rD4o?=
 =?us-ascii?Q?m9FvsG4r+wxv+os484ERNF4r+Fjb61vjRUKeSJpTpoJavhdX+6t3e17GffVf?=
 =?us-ascii?Q?xGzspEjERKetQS3PLKldGh9KiXZ9OpJJEdcjQ7Ec3At+/y7WM+JJ3//kyaf5?=
 =?us-ascii?Q?zrBj2LoNRB8Ks048GnTBOvMnKfoEQrIOyyNYPl06pbwmkyms1oIBzP7wtgDg?=
 =?us-ascii?Q?S5zCbYYzn/bKEcIl0y2/KiaUiQQkbiXE/dOxEzY+mLWJIHe15TnTFij4aOeC?=
 =?us-ascii?Q?kaKa/MGua37OjtsQ1d7zcYQrCq2iveeiuE3dmTHe9Va0jWUrdv0+Cxn52Lx8?=
 =?us-ascii?Q?f3y8rSWtQkPbEu9sgz+EPQTPvOpnv2Mx9+S/3sTf4egEK9VcRb+IGWVIrjuf?=
 =?us-ascii?Q?OolBCicm6sEI/Mj7KOVXA2Khy2080vy0UwlZubK/pnJ5/k1IZkG+WFoyVy5p?=
 =?us-ascii?Q?5OJkAvh7BFsvPWfIF/pXJyAvuT6ks/G6wHRiM8VrLJX096x+kI25+hpxqgeD?=
 =?us-ascii?Q?azKUUNBDDr6PIWGzKfNdWNM1OE8z6Y0WGdMZCd+2Qci055HL9n8uu4YzE3f4?=
 =?us-ascii?Q?DkTcBXYGzZyLqypFM0ENbOOyiW5/GTjJP1702OuEC14bewMLsGO1JjHCZ3a8?=
 =?us-ascii?Q?vJIwGo3bZ4vkMU5LKb8dNLaNktYzvxnRGikRxrUoKX+BMzSUv0qCtuGnM3tk?=
 =?us-ascii?Q?jYki1VTORfHmgZh7zjDUlVCPW35JADhhd5pqaPBkzCZpDWZ00kz9Ox7q0aLl?=
 =?us-ascii?Q?SseC8Mn6R8zJGP41OCfObMp+KKOqSRUEc5skqSGIESi24tTFhzhSGzHbW/La?=
 =?us-ascii?Q?ZY0xRiGFfz+hJ/XdUiP2mxKYsvUOCdxCiD3hEUH8evUOMfmKnDNVVGdLwx+4?=
 =?us-ascii?Q?3w7vqsqB0TKSDuwpPkdol3L5IOaqb30Xov/SybKjMpZy5/0980bwNR+nORCP?=
 =?us-ascii?Q?YUMcIwpqEsv4G7Si6Oa3117HOp+4dFD8AUP7DV5XOWIxUtvT/bldV88iR7U6?=
 =?us-ascii?Q?v4dGQShJ8AX3neHQU95f0RfmzFGLyALUHC6ZFzZ0pK+p9pBtns0DrXIskI2a?=
 =?us-ascii?Q?lUu9UxBrP9d84d2sBVw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c610fd-e96b-4d8f-1fe1-08dc751b5369
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 20:12:20.3664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnCIiMe28TC/cWeMM02qPSKkZSbucrXqCs6WWy+EM6HqHuhM7Qfuf9RwVK0W8Q2HTXCDE/v3AqUjsRtuaGrKZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6729
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
> Subject: [PATCH v3 3/4] drm/amdgpu: add support to dump gfx10 queue
> registers
>
> Add gfx queue register for all instances in ip dump for gfx10.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 86
> +++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index d96873c154ed..54232066cd3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -437,6 +437,7 @@ struct amdgpu_gfx {
>       /* IP reg dump */
>       uint32_t                        *ipdump_core;
>       uint32_t                        *ipdump_cp;
> +     uint32_t                        *ipdump_gfx_queue;

I'd call this ip_dump_gfx or ip_dump_gfx_queues to better align with that i=
t stores.

>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index daf9a3571183..5b8132ecc039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -424,6 +424,33 @@ static const struct amdgpu_hwip_reg_entry
> gc_cp_reg_list_10[] =3D {
>       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)  };
>
> +static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_10[] =3D=
 {
> +     /* gfx queue registers */
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_ACTIVE),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_BASE),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_BASE_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_OFFSET),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CSMD_RPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_WPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_WPTR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_GFX_HQD_DEQUEUE_REQUEST),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_MAPPED),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_GFX_HQD_QUE_MGR_CONTROL),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_HQ_CONTROL0),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_HQ_STATUS0),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_GFX_HQD_CE_WPTR_POLL_ADDR_LO),
> +     SOC15_REG_ENTRY_STR(GC, 0,
> mmCP_GFX_HQD_CE_WPTR_POLL_ADDR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_OFFSET),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_CSMD_RPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR_HI),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO),
> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI) };
> +
>  static const struct soc15_reg_golden golden_settings_gc_10_1[] =3D {
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4,
> 0xffffffff, 0x00400014),
>       SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL,
> 0xfcff8fff, 0xf8000100), @@ -4664,6 +4691,19 @@ static void
> gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
>       } else {
>               adev->gfx.ipdump_cp =3D ptr;
>       }
> +
> +     /* Allocate memory for gfx cp queue registers for all the instances=
 */
> +     reg_count =3D ARRAY_SIZE(gc_gfx_queue_reg_list_10);
> +     inst =3D adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
> +             adev->gfx.me.num_queue_per_pipe;
> +
> +     ptr =3D kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
> +     if (ptr =3D=3D NULL) {
> +             DRM_ERROR("Failed to allocate memory for GFX CP IP
> Dump\n");
> +             adev->gfx.ipdump_gfx_queue =3D NULL;
> +     } else {
> +             adev->gfx.ipdump_gfx_queue =3D ptr;
> +     }
>  }
>
>  static int gfx_v10_0_sw_init(void *handle) @@ -4874,6 +4914,7 @@ static
> int gfx_v10_0_sw_fini(void *handle)
>
>       kfree(adev->gfx.ipdump_core);
>       kfree(adev->gfx.ipdump_cp);
> +     kfree(adev->gfx.ipdump_gfx_queue);
>
>       return 0;
>  }
> @@ -9368,6 +9409,26 @@ static void gfx_v10_ip_print(void *handle, struct
> drm_printer *p)
>                       }
>               }
>       }
> +
> +     /* print gfx queue registers for all instances */
> +     if (!adev->gfx.ipdump_gfx_queue)
> +             return;
> +
> +     reg_count =3D ARRAY_SIZE(gc_gfx_queue_reg_list_10);
> +
> +     for (i =3D 0; i < adev->gfx.me.num_me; i++) {
> +             for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +                     for (k =3D 0; k < adev->gfx.me.num_queue_per_pipe;
> k++) {
> +                             drm_printf(p, "me %d, pipe %d, queue %d\n",
> i, j, k);
> +                             for (reg =3D 0; reg < reg_count; reg++) {
> +                                     drm_printf(p, "%-50s \t 0x%08x\n",
> +
> gc_gfx_queue_reg_list_10[reg].reg_name,
> +                                                adev-
> >gfx.ipdump_gfx_queue[index + reg]);
> +                             }
> +                             index +=3D reg_count;
> +                     }
> +             }
> +     }
>  }
>
>  static void gfx_v10_ip_dump(void *handle) @@ -9414,6 +9475,31 @@ static
> void gfx_v10_ip_dump(void *handle)
>       nv_grbm_select(adev, 0, 0, 0, 0);
>       mutex_unlock(&adev->srbm_mutex);
>       amdgpu_gfx_off_ctrl(adev, true);
> +
> +     /* dump gfx queue registers for all instances */
> +     if (!adev->gfx.ipdump_gfx_queue)
> +             return;
> +
> +     reg_count =3D ARRAY_SIZE(gc_gfx_queue_reg_list_10);
> +     amdgpu_gfx_off_ctrl(adev, false);
> +     mutex_lock(&adev->srbm_mutex);
> +     for (i =3D 0; i < adev->gfx.me.num_me; i++) {
> +             for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++) {
> +                     for (k =3D 0; k < adev->gfx.me.num_queue_per_pipe;
> k++) {
> +                             nv_grbm_select(adev, i, j, k, 0);
> +
> +                             for (reg =3D 0; reg < reg_count; reg++) {
> +                                     adev->gfx.ipdump_gfx_queue[index +
> reg] =3D
> +
>       RREG32(SOC15_REG_ENTRY_OFFSET(
> +
>       gc_gfx_queue_reg_list_10[reg]));
> +                             }
> +                             index +=3D reg_count;
> +                     }
> +             }
> +     }

Does this one not need an msleep?

Alex

> +     nv_grbm_select(adev, 0, 0, 0, 0);
> +     mutex_unlock(&adev->srbm_mutex);
> +     amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
> --
> 2.34.1

