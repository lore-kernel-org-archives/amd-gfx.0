Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFDAD46BEE
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 18:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7975910E1C9;
	Wed, 28 Jan 2026 18:50:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kMG7rrgf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40BC10E1C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 18:50:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCFcxa81oeU8ew4xrlYWW+vSv2F0K5URT1o52vUTi4w/u35BYr0fWKAQ8kCZzqIPhiWPCuoSkmTk3nAm7hc+BxBj826nvlEFOnVxzZC+OoNK6kQTiQLjLlxrpapESFjMloQFYzVqx05iwRnW/X6YT7yb61JO1DrKLO5jtYg+4RJVLjRdlI6SzT086mX1iJjuPEOGy6iRZyhc7YfvkvcRDRWh8vTC051C7V4cNrp9L5AOLVvJufLvsvRCp9pghKYERdL+ufExNlOBZG3RODm1w4ipkz1SkprQBYv9llTpXaFBbsl1QA2BF4G3m4TIfnJEJ17lFgPQ2l3zp8O+ptvfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaMfIeFrC7ey5LOF1zjdN8TfM4QACaDGm0ikjnfVkYA=;
 b=I7YxLOtMcrhXYa+ik/DfM3iCBQAjwmPTqml2SPt01mbp61Jq1sQEd0l4NYe8fE8tJiwvStaF06AaPMEnYO6aaU7NqUDZxBRGNT+gPHItWGkkRkb4eFjC32rfDDcVLuFjerIQjReJctTYpvnJGByo6LJ9NdfsW7iG5upROpaVaWkkAgV3kiPOANcqQOeRXqEtp6wzS/rSIpo6HXLs24tUxTXVRFKQH/bHdtL7BXmJV0bTDHxAtBbmBV0Ac33MXwdfGHnegUVpjexKv03rk2KgfaOyJLIGzR+EJUgEy1o3bXe4xVgfBtvgoRRKSVFrST2IuOk/uCe8qWLoH2X64uIPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaMfIeFrC7ey5LOF1zjdN8TfM4QACaDGm0ikjnfVkYA=;
 b=kMG7rrgftEy7Tdt67hLXp2E0xH/2EAqr8DnASTQfBA1S0xJREIYxAJxunoCW1ZQXZnBPgAWg1jiE1JEPQbUB3974hPppLFN9NPq3wOMXsEdH6YBkOqJMfP/9j2l+7nNBJ/cZY2KymYKWs9LFIF6l5tri0VAOuaDsiJhlq/nXa4c=
Received: from DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) by
 CH3PR12MB9396.namprd12.prod.outlook.com (2603:10b6:610:1d0::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.7; Wed, 28 Jan 2026 18:50:20 +0000
Received: from DM4PR12MB6445.namprd12.prod.outlook.com
 ([fe80::234c:8389:afd3:f90a]) by DM4PR12MB6445.namprd12.prod.outlook.com
 ([fe80::234c:8389:afd3:f90a%3]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 18:50:20 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH v2 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Topic: [PATCH v2 1/4] drm/amdgpu: Add a helper macro to align mqd size
Thread-Index: AQHcj/zOudxN8OXBmkyjYljlFuNPILVn7UlA
Date: Wed, 28 Jan 2026 18:50:20 +0000
Message-ID: <DM4PR12MB644583AEF88F369D3C899E53EE91A@DM4PR12MB6445.namprd12.prod.outlook.com>
References: <20260128022111.281082-1-lang.yu@amd.com>
In-Reply-To: <20260128022111.281082-1-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-28T18:48:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6445:EE_|CH3PR12MB9396:EE_
x-ms-office365-filtering-correlation-id: f625d2d0-9bc3-44a1-5125-08de5e9e161a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cJ/Dh2ON1pQ8+SLgWg9VD32c7yy8hr4ZTWkpBQd/bUSLlEbGC3qIF96SLqdc?=
 =?us-ascii?Q?LZpe5z6FZwpr96H1W3+Ca9nXgomb7/2cCXtCuPCgyDait5FwTlI+45dirFh0?=
 =?us-ascii?Q?1h6ED7NW3lJmG3/L2i6iTyUqXadpbvbs7xY/IVajdpk88qw0abqLEoVLk2dj?=
 =?us-ascii?Q?bZ/5DO4iaPISlPq6WJD7lEvpSM+deUUMQ7TqChlPyTJ8EdHSp+Rzwb7owSap?=
 =?us-ascii?Q?kT6f69roxniVxBgfkRfH7wsgbPrlzg44Qsi3iOqP9Amu7osAjiAfKjmBkNPp?=
 =?us-ascii?Q?iZklRiVWTRtbdvLTRZ5rQ5f/flUZSqaqtp1JIOLp/OxnYckrWGsm+lzpyrSG?=
 =?us-ascii?Q?BY9S8Am7bOqSmmBLGEGK2jVRm8O7mNJk5Iv22bmKCSt1wjLy9yj3dqjxlBgL?=
 =?us-ascii?Q?+3hvy+jBTfn3ty+dHqPQe0nnIt+jAP2cGGsMQIVTwj0A6MKDrlLiItXK0aec?=
 =?us-ascii?Q?qLeiMZOcPBhOqQ9fy7ty6hvWcfildaCoLRvCvWxUvaHSTnQEUVubD/P/aC/p?=
 =?us-ascii?Q?5MTmExa0+0cMlNAtiYTKM3zoudBOWHQwnbhY1h4WsfdINuQpcdo2borC+oeB?=
 =?us-ascii?Q?AhA8ts0yqIsiJyZcCUn5k1kl+VATMbZEH/cavdqWSEaCVroa98Ksz7dp9D8P?=
 =?us-ascii?Q?h1oLd/hQx0bHtIDJqC+bNLGheXM8wu3LYucXb/9GIRs7ZYbjGfGFoYIQp3vA?=
 =?us-ascii?Q?LWyUXLGY33shPs+8SAQix+/IuwBN/XVUUqFs/MU5EPw9FM7OOv2OcDv++lsJ?=
 =?us-ascii?Q?8mrLI1AAiNoVu4tABJ55WtiKqL/KSWcYItxCwFEP6E1JPsZ9OM4YELk6+cfN?=
 =?us-ascii?Q?Q+1USo15LI1croaUEBmdYa+O7B9buYxQhDcFedFmuBya4DvLia3QfpABr/PQ?=
 =?us-ascii?Q?stHPiFd/B9UJ2BFK9K/ybh6tybH2Mc+h6r3q7Npyue4KvKGlKVUGUOCqa14G?=
 =?us-ascii?Q?7l1EAoyFAL3UERRoHtGc3pq3qQ3a/hGw55Q1p82A/r9QrlqKbQrmmBL9XGZ8?=
 =?us-ascii?Q?DES/wkkOLgHE3B6qjJRpoi/CAg0xmQE/xrODjYb7+I1uLe2Sl4KDztMOhj4h?=
 =?us-ascii?Q?m78AZBBw2cWgBtV8NhTuzlvDbd4SmjkbLQUXjfz3ky7AkQVN1e4ybDfoBZry?=
 =?us-ascii?Q?pkq0lB6b3hC42MVZw+vZUc6ePWh873UHEoYPZizyaQmLqgoUq44T8zGBZx36?=
 =?us-ascii?Q?eaATr846XQPPZMgVNRhxz0Nj2Zwhxaa6HHK7y5+ZtPzCz/SaEm0Up3OHLuIh?=
 =?us-ascii?Q?GsFMRIqb1dKKLF/JhhiYoccS/+XWQu+K6I+PxDOddi4TYkuDmDceBdc7AmbY?=
 =?us-ascii?Q?gZByZ7e9gpdvWzO9vDlWw5qngEANp02Pwn838NJis1kRGijFvDT1Py+Tbi8/?=
 =?us-ascii?Q?d+OLbPTI0xQUb9YNX1rYGnEK4iUYPFMANnjg1IXIkxTx9eXh9ukeCf+1TKYf?=
 =?us-ascii?Q?DJIY/fM6X+L1S5blXzQpkT5Bnio5plKfA+c0euHlCOX5M/egmQ1Nk5jOA3ZD?=
 =?us-ascii?Q?EZz8cXtTfeesIS7GVz75BJ7/Mljuk9H4wSRNJf5rQYqRMKDZ8/8UHLNaAHxf?=
 =?us-ascii?Q?mPqL3/AtX835dNM0fmYmFW+72Z4PT4Y3WN2K+K7Y8FHzw1WWMcxqpCb0PVi+?=
 =?us-ascii?Q?c6Pq+qqlYMp2o6Pj0No4w2E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?92h6CjGZxRWGdz1ft9nW3PXBp3GaiT7wdbi+q7+BEOTiDSk1TzJb18mR8xkE?=
 =?us-ascii?Q?R7DiKFDwn/6BUR7+RvAD220UXPf0aIFN7yoNpViYcDez01QPAFSJPGiy8gXs?=
 =?us-ascii?Q?8Fo0sQhq4Si1PidsTqFUSEu/vttxMFRH/2Q4GyRa66mtm3Up3yLi5JvSV9aO?=
 =?us-ascii?Q?vcFXiqcNJ4KX1VqkikZcdhzps3f7+Ntl5SEqc5FPH7aInVpgu/CYFxtNUXOj?=
 =?us-ascii?Q?pVSi5286bB+ezDVqzWTgP7ib5BSX32yBsqMKugXXg7EepwNgTFA35W3H9vDe?=
 =?us-ascii?Q?z1EyxNNx+Kpg1KDdmeGrkj+Xp1J6S06ejs8bHoCdBtSHZtARk34ecanUzoXC?=
 =?us-ascii?Q?VnpHIKdX+bYi0rqCMVlQvLlk1MB+9eKreCrqxRt5jj+g/Y1RZX5dXCdDX8OX?=
 =?us-ascii?Q?m+TtUqaUxUP1I9wecXqRPI7Cj+t61fMoiPNu8vLksd5Zk4bIeCTwg2F8ncMI?=
 =?us-ascii?Q?HpGJICEdk5+3ZnVTPpY9Mr9CWQpQ4OLm16XjZeBM5LPTPcAI/+3GD2clbYra?=
 =?us-ascii?Q?R94qTfLKqySM05hw/HRuEqomsHLVzgeCIvKzGHdiP7Qg526iwDCs/xgM1EOT?=
 =?us-ascii?Q?J4C4X/DziACBvJ/k8PjR5EJlLLrxYhoNUazd6fD9YSQTfN69J5q1E1TGLDZA?=
 =?us-ascii?Q?WctYdGyX9CT+V1AiyR7tl56EqvhxJnAuD7ZfutbfgV1pxb8ShLKmcDlfjv4y?=
 =?us-ascii?Q?ien6mH6bUm9a8/J/whtLIwK9NnrCe2xY5fhkfl4GRS+0q9h0SOebqH3IxwEE?=
 =?us-ascii?Q?PsiAYJYo0bEB7hWvsvkb3C0aQaPIWbY1KLc1MjLklJCCVOxXh3nqMCi5psAE?=
 =?us-ascii?Q?NQs738XG4z7jndiRXMiEY4hyDq8HMz8T4N+6QwfNjQgIpA3E9Q96ERvEwTcs?=
 =?us-ascii?Q?qQA9vy9Dk9m9ECVvc5KWzkk+SPJCTxQsXh/A56tNlHa/OfBLuwDpAoALdUZN?=
 =?us-ascii?Q?sTi6Eup8ZoAdPGThOsQlQHqQ9oi0bKIrHoJC22Frsk4flEtH8XONLVscFLlM?=
 =?us-ascii?Q?MY7VfupZmd1aE/4WbIrRtwfDxOoV6AozG3goiRrbRLY1KD3eAQDK+NhSK5q/?=
 =?us-ascii?Q?TGeRX3a43aK99SSX4Fqrs955q8bR9X8nvpo2nakzw/VuBXJq6aw2USUUf44P?=
 =?us-ascii?Q?ug75ZepNpsl12eJke5PeWTe7u8xXR6S3K3EIgMmlDyAEuyf1gfpdCmpDW6NK?=
 =?us-ascii?Q?Wu6mfx+6DtkEPoaD24tdEiyPsmUGplbh7DYYgRXntI6GplngOvwdvyOjytVn?=
 =?us-ascii?Q?EJRuvfcVlHAx6PGZJtzvtvxlZYFfIlRg3VOZ7MA9ztl+HLcnI9sudUolA1f1?=
 =?us-ascii?Q?/qVTGQrcRuvtBGrf38TUR4TxS5fbJaPlJfNkxQhv8fugAiPEqJJYedcI9Z6x?=
 =?us-ascii?Q?6IaMk9Yo5nCgjnWpCK/BmBhMZhGyPbvqY3LFN5GzF7ini6CyF1lOC0KAo1cV?=
 =?us-ascii?Q?JKCvAhTbkcG+2atuupueaNZIrra6+70aIIjiMPFUz7R9RlD5VqXVJ3Rrx8Sv?=
 =?us-ascii?Q?60J8/tg9oVRAyEWsdkspQ/KWFwGbp/LID0iwynoZQYBZsLhVi5toP5wxNsal?=
 =?us-ascii?Q?GwrDd0v3YM020BUUtwCWRkzDnru5jGx7+alN++ub26/997uRuimfopYUBNdf?=
 =?us-ascii?Q?27WgFx0XMKar3hSTmURdHyli/Ix6BMucF4xRz8e4zwme8KXp5tJ5Ezt67cTW?=
 =?us-ascii?Q?wufHHnIokSLY6U2QHKxR8al85imeowsdZLzVwmYi3tCksHYL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f625d2d0-9bc3-44a1-5125-08de5e9e161a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 18:50:20.1327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rZHhlbYfvUnwECQn0+nEgXNVOCfFcX8g7t/QBggh9yHOUG2qQMsA1+eKytWk8Q48syoFN1XJf4Z5Pz1XfX3Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9396
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is :
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>


> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Tuesday, January 27, 2026 9:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>;
> Belanger, David <David.Belanger@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: [PATCH v2 1/4] drm/amdgpu: Add a helper macro to align mqd size
>
> MES FW uses address(mqd_addr + sizeof(struct mqd) + 3*sizeof(uint32_t)) a=
s
> fence address and writes a 32 bit fence value to this address. Driver nee=
ds to
> allocate some extra memory(at least 4 DWs) in addition to sizeof(struct m=
qd)
> as mqd memory.
>
> For gfx11/12, sizeof(struct mqd) < PAGE_SIZE, KGD allocates mqd memory
> with PAGE_SIZE aligned works. For gfx12.1, sizeof(struct mqd) =3D=3D PAGE=
_SIZE,
> it doesn't work.
>
> KFD mqd manager hardcodes mqd size to PAGE_SIZE/MQD_SIZE across
> different IP versions to solve this issue.
>
> To avoid hardcoding in differnet places and across different IP versions.
> Let's use AMDGPU_MQD_SIZE_ALIGN instead. It is used in two places.
>
> 1. mqd memory alloction
> 2. mqd stride handling for multi xcc config
>
> v2: Use AMDGPU_GPU_PAGE_ALIGN. (Mukul)
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> Reviewed-by: David Belanger <david.belanger@amd.com> (v1)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9c11535c44c6..8c6edb0f58dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1239,6 +1239,14 @@ struct amdgpu_device {
>       struct amdgpu_kfd_dev           kfd;
>  };
>
> +/*
> + * MES FW uses address(mqd_addr + sizeof(struct mqd) +
> +3*sizeof(uint32_t))
> + * as fence address and writes a 32 bit fence value to this address.
> + * Driver needs to allocate at least 4 DWs extra memory in addition to
> + * sizeof(struct mqd). Add 8 DWs and align to AMDGPU_GPU_PAGE_SIZE for
> safety.
> + */
> +#define AMDGPU_MQD_SIZE_ALIGN(mqd_size)
> +AMDGPU_GPU_PAGE_ALIGN(((mqd_size) + 32))
> +
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
>                                        uint8_t ip, uint8_t inst)
>  {
> --
> 2.34.1

