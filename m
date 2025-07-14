Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6402BC83F1A
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 19:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6C210E354;
	Mon, 14 Jul 2025 19:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xkLOlrMG";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108E610E345
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 19:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRP8Uiv702SAfwr5vxAEVFKVtVmpnefH2mImwSPpeLEtt/4vtoh/4+PmhU6ZYM91jjyIv0pJ76oeZ8c22wHSpN0MBMQwBydPeiWhnV2VXO133HhJPpSBKiUrMsfouXf0DtGd1k6m5DAasSGhpIOenUe4pmx1YjtGBDDCLzB327xF1hcAZgDCpaF9XDPysUvxCjPsE8wyrf1rKMTkycV/kH/t8rn1DHqzPPfqjmegTwQG3AS/MHv0w8gAIIHODGAbhvX1rhXYQ+/qyDuTyzOBT2Qzojx22ekQ8/qFz4nFm8oENaXpmS8UqINOgsoqSH11x2+/XTLtrXnpOjpJUrAN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXIAnnK/dGcIy2f1Ok/8Hvs1wQoVBr0WzC+17Xe1hlQ=;
 b=ymMqGk1rgQi62L/DefXCZaLIOZQ4XXvklHcp6YpPWuGx2TG6Ldr96ry4/uR0K9HjT0x9EzKT7rGdv1gN+ca/NLRaQBVnQ3bcqgvwHNFPtg8g4PhKjL3FgApJIqavYMBQxKQBU6PFx3N6oVDdeHg618UE6EP6h9+ZwCrCNhGadD80gRYyHRYykoRm6AgciiukbJyEJoLJeKDm3ZpIiXanBxfo17wJb0e9kQTfxgYJig4mM06OYFSJxFZGmOgVT7ku6qrU9MI5dh2/lJmYAXh1ffZrOQ6N+PaydNuV7Gvp9gmPyt+iNdu8QzIU5JW1ROQnVxjWuTJI+Nstpy6H3r0mBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXIAnnK/dGcIy2f1Ok/8Hvs1wQoVBr0WzC+17Xe1hlQ=;
 b=xkLOlrMGRwm5YTCHct3WRj5DrTW/qY4SWwTHh/tOMhUcdo9Vl1Jl9+PhZZqMrPfx4Dqcgx9v5dtWhucS8Yq0APrVsH0ecQEPbPb5RbXboC4992UwmDDB6X3zhnXxJcWHxvI1wYSR747CjQHb7zl3YtA36bSTryX6v0hO6K8QZ/A=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 19:25:05 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 19:25:05 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: "Yi, Tony" <Tony.Yi@amd.com>, "Skvortsov, Victor"
 <Victor.Skvortsov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>, "Chan, Hing Pong"
 <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Check SQ_CONFIG register support on SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Check SQ_CONFIG register support on SRIOV
Thread-Index: AQHb4fvW2YEzpzmO3Ee70Z7Z9EDkMrQyJfHg
Date: Mon, 14 Jul 2025 19:25:05 +0000
Message-ID: <BL1PR12MB5317700F3945B49EEE06BBB2F154A@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20250620155440.1897130-1-Tony.Yi@amd.com>
In-Reply-To: <20250620155440.1897130-1-Tony.Yi@amd.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-14T19:24:44.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|SA3PR12MB9106:EE_
x-ms-office365-filtering-correlation-id: 505a8978-13b2-474f-1854-08ddc30c2334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?pLSs3QdyB4M67Gn4MIthjhY85KcU0Jpz0+omD+sa3uicvGebelrVIkW89B6l?=
 =?us-ascii?Q?lRi5DItJWJVQwWuquyxVPhuLwo3zWEC6iRZvgyy+EIyn7nqFLIkqF8xoshP4?=
 =?us-ascii?Q?LyyxL6RPqE5P9vA9M4YLwIrO+8fKKAHpBaTqTxXY/x3ZDTA4il2jOQup5rem?=
 =?us-ascii?Q?IegD+m6mymGxSg5Ylc0SiUCxWc7dd84Lhrz/3NXzF9X8LY1HKm7Au5zNVUab?=
 =?us-ascii?Q?7DDDPUCzbicy5ZCEmhs//FUexLAq0mxlkVGfzwMTB8uMZFusLRx2utbc7ihf?=
 =?us-ascii?Q?0pRc3YB/0X0hc50CNmrC5xpu58wFo2dWdCoKw51W2mGvUupe8xOC6m1424dz?=
 =?us-ascii?Q?jUMYLRuSojC/AuMjZrvk0sOjYdSTzE8ieSKSDGlY9kvzyR/IlevsMhplwGlN?=
 =?us-ascii?Q?/GypW/vZcmTuNdK7lZovhEbVjDGfs7SfSW4E2wD8hlSSKB7xfbgZSExbzt0E?=
 =?us-ascii?Q?oxwOm2RjTYsuQ+i5b8zLv2/B266Q9SSxalCiScxBYNcpfpqZIz2bKTTQNRfX?=
 =?us-ascii?Q?TBlPTVIKnfG+1Uw/xG6rHxwvJhgZVWizM+7lci/Ig+1bsczkj3DUMdlhoPED?=
 =?us-ascii?Q?QOvk+lCG3FvGukbzqdwPBzZKvQdAaqQvY04Fw/ljdTcYsyVvXgeQYIIY+aME?=
 =?us-ascii?Q?wjtdpXbUhZ/dBRRuXiMh/ZrwcB6LeahgNQkkSc3NvetFPpNiu3Dpx+AVEQ6p?=
 =?us-ascii?Q?jBdMJ9SSPZST2FqOWcwbBQCt0r52oNpom/nxCoHJlxXnUB6JAzdyyDmzFBsg?=
 =?us-ascii?Q?f+omaA1mp3D+LizaFlbi3Twt8xj+IfKfpGTB6g3cnSMbeUEu/wM6tcqUp3lQ?=
 =?us-ascii?Q?6ii1EuJEpYXybiwxfZIa8AD23J86Txd7MftAlcMutWTbMyLSQ81i8asZwxAe?=
 =?us-ascii?Q?llGk10WrR2LzF3ka9eqsM7vPc90eyTld3YOvkKMkDGi50AwXpYBeEtNp1QvA?=
 =?us-ascii?Q?JF0GqYMPDoQupnTGc1IGuCtWjcRzYDSHDZRWjj9cUnKL1rGsbeVMGzvyURmt?=
 =?us-ascii?Q?BDsg0xboCcPyl5E9iXvXiLIjNdyO9LQX3Y/oojz8lTPFzYBVUOxqaU+2F+9T?=
 =?us-ascii?Q?7iB/BlwOGQrzRnoNyvS9IDhhnBeyXuNgNdaOLd7h+lLbSL8klLyCiPZpeID9?=
 =?us-ascii?Q?JgLKC5K2jCO2sufDrOCYvHaH3dQpKpYBz7cMrDHGlw42n4iY8pltKFHcN1K/?=
 =?us-ascii?Q?byamvAjTUfZLNIFOrwQrkkIGTZrAISmYxYqlRQJRxRXTtaecL31MRXEUbBnq?=
 =?us-ascii?Q?+mHmaDRYVE0/HCJF/+z2TObSSl6X8TXQsXpi2OJY5GiKQVGDWYrvsJiYfLN4?=
 =?us-ascii?Q?yZhFSW/HNg2Fu7ZdAYUv1iUOH/XFgKGG03Jv2rPvGvxrDRreqoFBO8upWND9?=
 =?us-ascii?Q?eHxYpbDKX6AuH7TiFkeSqwtsWBcU9sgzsDe2Q6zykvIGIjDIXs5vC2V6qWd/?=
 =?us-ascii?Q?Xg6vsuKtjPx+cv9h4dtrLqmOb2MBfihHQUNfXeng/latpCDQLLGKpETxpO+r?=
 =?us-ascii?Q?G3MCD3ytB/306h4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mBFe/hDm5LxDW228BrDD2kziEtYAZlCkj1m2Nq5beLrmo8zpyNQV5TxwiBhl?=
 =?us-ascii?Q?9xmpv7su4vqGrLx6GCRfO4Lie+dY+iEyVN2IboowRCCh3cS7gMu2+Pk6sel+?=
 =?us-ascii?Q?DFPdwKEJJehtn+sRKlhiqAAssu8+vIZH+Ow5b1lX+7YRRGssYsVjL8wVT2g3?=
 =?us-ascii?Q?JYODlqaB3oB+W6hxlwyiLDQCFKsiY6XXPHcfVOfLlPdncSP7/CEszAg92l7T?=
 =?us-ascii?Q?uXIMcPSXvRIG+Ad1IeeZnNUYa5GwtKQ+jfrv2JzVB/8LxsE3Ql3oUfNaCqQV?=
 =?us-ascii?Q?89Wu/gDS2hCrwHcqV5xsJ8h6aMxzK7AM6cc8eCfIiY6BZmqOfA67n3Psf9As?=
 =?us-ascii?Q?DzjNJDtmiJtzkaZBzqPwiBkAakE5gMRDpnW1IDDKEY//Fh8cyIwrNDAJm9XA?=
 =?us-ascii?Q?2g24HYnrYTyQZaFWvgMNf7S1D6MYt2gn/a0dbzNvWzoElmyUdU2FdZ+OtRv4?=
 =?us-ascii?Q?BowbD0MG9EMZChG5m+TefoGRxXQbcWfIdXAjNFFFZ/I7TURU1mvluOTxLTiO?=
 =?us-ascii?Q?Z2xkXeJuqjmn9SymTgP4nVICif3F0t7p2Mrxx/OSNXVj69Jk9t2CLps5ocdf?=
 =?us-ascii?Q?XaH5am9bwP2nYW4fT78H+/q15pcNCeG3MCK83aM3+X/qKAjVm7UaqN9fM9vA?=
 =?us-ascii?Q?UBnz6kyZbCDZmu+zKhTJXnn/VdNpvE8Zebu9rE5viIQ6sSiRBVqTLzsrwkLQ?=
 =?us-ascii?Q?Ll7C8bcbgeSYLCxdg2KbSJfiSh6PK4/pQ567urNq0+ya3cHz6BYzM0nKYUAE?=
 =?us-ascii?Q?MWlqGIIDsDQGYYy05/9jHlm0uxUQFS/3+iutXlxapOhld2eKCGLaWcC5NJO7?=
 =?us-ascii?Q?EYvK3zWFTH+o9gDKBW+t0fYBWqOThkzV0IZX+Z4I32WCp4OlVYSWWlyTqzrE?=
 =?us-ascii?Q?TsXK6KPJB0iluHjH6hRmY1rlQfXO1ac+yTx5GXEBeBFgmTHjxCzMDjRnBE6C?=
 =?us-ascii?Q?MG0TdAV/ZKSy3VkrzfraeL+t/WcSIFrhmFHfa2mFTfYmtCcmGQPDdLeSem++?=
 =?us-ascii?Q?HLg+z0UsiqXwjl0vEpjFmtqu45Jn8GTSfrFYjB0FSKd42o/IYdKkr/NS1Ut+?=
 =?us-ascii?Q?NX/6b6cVpH+t7wjCV89GUwKZAy28XMB5HHYT6jrE9EJfW827VUS7gYLCvV9N?=
 =?us-ascii?Q?ak92A+XVL79zu++9JbuJ2sRDVx4bQHLttN2KryGSzCLIPkqoaj2JZ73SFa4I?=
 =?us-ascii?Q?YUaf3+uShgzc9I+DjugEVtruA/yT8yEeEMSr/pBfGmr6qZ/ua92SR+0enHwL?=
 =?us-ascii?Q?YZojEBEBEsUBRiOkBPvqCsxgvQc+jIiLjKsAhftW07Fb0BvMG4Wi0DP6DY5Z?=
 =?us-ascii?Q?I2GWf2WEZ/PTr49n9w6/OP41TxcdaQe2c29t2fZphYD8QcxFPtje3JVSxul2?=
 =?us-ascii?Q?HsUugFxVW8ThDobMgIuK+vj35SUT47QXpWCxCJ05OhkSUtxhDaFAjtpKsMfa?=
 =?us-ascii?Q?s6sfxj06qbBOw/pCNWhMA8OJSc+AlO8XAOFz0H6M7IK2siodwAatUVhom3DO?=
 =?us-ascii?Q?7GRRzC1dw4HnD+fcJRpNZMVTam1UvcWJnHHL7joX17a/JB7iSpTQriU6sH8h?=
 =?us-ascii?Q?Tqz93iwDoygGA/olfEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505a8978-13b2-474f-1854-08ddc30c2334
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 19:25:05.4013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhad4Gf6c351eqpNpwkLVYbvCYsHXkiQsO3wZjCZ0LrPLlGcMKHNqblzervnMs0Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
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

Reviewed-by: Zhigang Luo <zhigang.luo@amd.com>

> -----Original Message-----
> From: Yi, Tony <Tony.Yi@amd.com>
> Sent: Friday, June 20, 2025 11:55 AM
> To: Yi, Tony <Tony.Yi@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.c=
om>;
> amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Lu=
o,
> Zhigang <Zhigang.Luo@amd.com>; Gande, Shravan kumar
> <Shravankumar.Gande@amd.com>; Chan, Hing Pong <Jeffrey.Chan@amd.com>
> Cc: Yi, Tony <Tony.Yi@amd.com>
> Subject: [PATCH] drm/amdgpu: Check SQ_CONFIG register support on SRIOV
>
> On SRIOV environments, check if RLCG supports SQ_CONFIG register
> programming.
>
> Signed-off-by: Tony Yi <Tony.Yi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    | 8 +++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     | 4 +++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 9320461bb486..3da3ebb1d9a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -152,8 +152,10 @@ enum AMDGIM_REG_ACCESS_FLAG {
>       AMDGIM_FEATURE_MMHUB_REG_RLC_EN   =3D (1 << 1),
>       /* Use RLC to program GC regs */
>       AMDGIM_FEATURE_GC_REG_RLC_EN      =3D (1 << 2),
> -     /* Use PSP to program L1_TLB_CNTL*/
> +     /* Use PSP to program L1_TLB_CNTL */
>       AMDGIM_FEATURE_L1_TLB_CNTL_PSP_EN =3D (1 << 3),
> +     /* Use RLCG to program SQ_CONFIG1 */
> +     AMDGIM_FEATURE_REG_ACCESS_SQ_CONFIG =3D (1 << 4),
>  };
>
>  struct amdgim_pf2vf_info_v1 {
> @@ -346,6 +348,10 @@ struct amdgpu_video_codec_info;  #define
> amdgpu_sriov_rlcg_error_report_enabled(adev) \
>          (amdgpu_sriov_reg_indirect_mmhub(adev) ||
> amdgpu_sriov_reg_indirect_gc(adev))
>
> +#define amdgpu_sriov_reg_access_sq_config(adev) \
> +(amdgpu_sriov_vf((adev)) && \
> +     ((adev)->virt.reg_access &
> (AMDGIM_FEATURE_REG_ACCESS_SQ_CONFIG)))
> +
>  #define amdgpu_passthrough(adev) \
>  ((adev)->virt.caps & AMDGPU_PASSTHROUGH_MODE)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 92ca13097aaa..33edad1f9dcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -113,7 +113,8 @@ union amd_sriov_reg_access_flags {
>               uint32_t vf_reg_access_mmhub            : 1;
>               uint32_t vf_reg_access_gc               : 1;
>               uint32_t vf_reg_access_l1_tlb_cntl      : 1;
> -             uint32_t reserved                       : 28;
> +             uint32_t vf_reg_access_sq_config        : 1;
> +             uint32_t reserved                       : 27;
>       } flags;
>       uint32_t all;
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index c233edf60569..4a5fc5b8ac6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1349,7 +1349,9 @@ static void gfx_v9_4_3_constants_init(struct
> amdgpu_device *adev)
>       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>       /* ToDo: GC 9.4.4 */
>       case IP_VERSION(9, 4, 3):
> -             if (adev->gfx.mec_fw_version >=3D 184)
> +             if (adev->gfx.mec_fw_version >=3D 184 &&
> +                 (amdgpu_sriov_reg_access_sq_config(adev) ||
> +                  !amdgpu_sriov_vf(adev)))
>                       adev->gmc.xnack_flags |=3D
> AMDGPU_GMC_XNACK_FLAG_CHAIN;
>               break;
>       case IP_VERSION(9, 5, 0):
> --
> 2.34.1

