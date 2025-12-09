Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83280D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:09:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D111110E492;
	Tue,  9 Dec 2025 08:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F986fB2t";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012063.outbound.protection.outlook.com
 [40.93.195.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A3D10E492
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:09:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK7xAqFvXO8gbqnPOJqrEXY8nzaFnFsBqWVkcu0WpELv86q6GKxBoS73vPAJr6ta1+1KfVt3d5iKpX0iWA/hSzvF/NdADgkxSXLw1U9cRIFR920Tng1mMtnL6zZeoDhEchFo26CuTgqAlTKhEMn+Jl7GapbaR91lEHtJk5QPNEBHTDIu2yXxkoYzJCuUs90YLZnYu5xl+/sfjHA1o+t91dSg1ntTdXKkiG4lLOr8IuaEDzGdwVxg5rSqk1DD8NhsCGxNBywlBZvCnouzgFFlBD84haOghgzz3X8LU7AR3qheKM/fnzPQNxxCmcajwlt5ZlsRlW/UD1iYnjKxk5Z4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7LFRDryKzRIQ5KkJ1kBQLaRSA+SwILWn7U3K41CBmY=;
 b=jGAvPFTHzVHJj2B+ew5RZWSdCdV4SsXZOBYz8q7HJwvNJCtangx54hoAQSKZA67yIEJQ39rFR27T9eOK/etlgQ7XAhVnhAZ4yFND8LnTghslm7QEUgMbQgsF4Tad9G4mUmuOniGjQhoC7UY91lQGP74ALz2PMEBhfevRREleBmRtbvaFd0RFqnPfile+wkseIbY5l594vYRZXOPqVhXZgqLbOx9jWlAt2AP74PGznMQ/BnLOKN11q99XXmI+96PCJDxRwWLAgKyy3cBLFXLRSlJnK6EXMmWL10KcsAiG8sjgcfrsegGs23+kriWgkRfveVi95PfA44hUPYz4KmSUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7LFRDryKzRIQ5KkJ1kBQLaRSA+SwILWn7U3K41CBmY=;
 b=F986fB2tCjk7/tp0nGsX71NWuYLTuR71V5VJeeam7XteoSP580+2+F1HaxBwUn+SGrrhvX5caf4gSnBQFjadY7/QojmK1wjwyNQbM5HdHHKwSLNdwj90gwTi0TWeS7JMdls0EcXLzn8Jtb+YOYcTkIpMbJhon78MZtIKQLz92Gg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Tue, 9 Dec
 2025 08:09:20 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 08:09:20 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: Add vram_type to ras_ta_init_flags
Thread-Topic: [PATCH 2/2] drm/amd/ras: Add vram_type to ras_ta_init_flags
Thread-Index: AQHcaOBms5+D4JxJQk+aUFngY2dPqbUY9HRQ
Date: Tue, 9 Dec 2025 08:09:20 +0000
Message-ID: <PH7PR12MB879681C0155FE4F39A35046DB0A3A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251209074912.530424-1-candice.li@amd.com>
 <20251209074912.530424-2-candice.li@amd.com>
In-Reply-To: <20251209074912.530424-2-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-09T08:09:12.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ2PR12MB9192:EE_
x-ms-office365-filtering-correlation-id: e2773469-9ac4-46a5-2f8b-08de36fa418e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?jOBCe/8xrV2btyZXSRzQfxu/pf+iRfW+/VA8bRvtaz/BHmCB4/oYc4IxPQ30?=
 =?us-ascii?Q?l4lh/cMAI7I358Ae5v0FiWymRAT/8ufEllcsJdgWlmQLoskL9ZHYz8DV44Qy?=
 =?us-ascii?Q?M+USx9qxb21ietJsSVu07JwBlqO52FJ03k57z4bIRKmWytT698OSEDQ5/OxV?=
 =?us-ascii?Q?G+DI41ZJ44W73jvaYAfirCdUYL8i7ABs7U5w7pCunoX8eTjbXSlQU180JSu6?=
 =?us-ascii?Q?aYBChc6sr0xsvPk2dx5pMCpgMUelCiTCM16KzuNYUSHQQtiRimRHOR+0zDmg?=
 =?us-ascii?Q?boSMgZ9NuQUO6tRiBLrknmuckd0bgtniQ81bzoJwulEPiyPwFuL/pU4jQLTt?=
 =?us-ascii?Q?ZyGLmgXJnBZATt9urJssLbaqAVILAcJx7TSFlYmftFO0N+4WTRK+l1KGf4lZ?=
 =?us-ascii?Q?17/EEcHfxoOzwi3bpVEM6yyKFDCNub8jmRZwXISZmhMzOMg5Y8xcytpXKEdH?=
 =?us-ascii?Q?/HMIqCybD1y2ArEN7Jn1yLYQXqY7K+ZNlkbr3jNrFUCJNLeD9ykT+cXczJlI?=
 =?us-ascii?Q?5YjnglCJBHsJPd6dK714StG6sHDq96vAyrsvauo4Fz7WcLpa8rzNOvQLyPZM?=
 =?us-ascii?Q?gbYfp+q1dHC5qJGxRw/ZQPMGfEuBPOUCdJ0OmQvJ5c9ntwNwNgGOSoGAS2OF?=
 =?us-ascii?Q?AOPyt6qksWufaJXpaVZuvzoyWuspVUkHQjKM5zjB8ADDQY22Bf/M9vLM5iGa?=
 =?us-ascii?Q?NprM66Mv2ojyreMVdeAM5gjAz/Rr77j+WSo3oVx60zo2C++rcPPc1H+lSCDR?=
 =?us-ascii?Q?8sC5YnvFgzmbB1SZYUT2FUFM4Gkex1JCXUQgKVat9L/iIwqrTqq7/anwDfbB?=
 =?us-ascii?Q?rAQlyMaZRtRhhc0XgSdy7d37md9l5leVfF6A+w4jOoOUK6h4Hwh814OdmdwJ?=
 =?us-ascii?Q?BOmpThFWDPJ4fccSnLyuvMKJ6r8v8RuGTRl18BVVxD7Bz77NZNucFDs7vM1X?=
 =?us-ascii?Q?8RLDfcw0QKZQWdfHT+pkGOnk017we1NBaz8Pko/MlhBPaJ88ySS0Bi3bBXNS?=
 =?us-ascii?Q?aw4DiFvOQUtdVkvk0eSVFhAAvLwuZBcMs8nxv20gwNoO8XNbm+48TVrIxmLN?=
 =?us-ascii?Q?TsOfBtoyhfj6/lOvx6SisLY2ENksTip0Ql2EEZnHKkYq5XTvW2AtXol0e83f?=
 =?us-ascii?Q?HvkKdSxdY07bT1pmgzWCr4rPCTZriyTltusDNeZaUFhx2h4J64ws2s9uZR+l?=
 =?us-ascii?Q?0raMmwXaTh9ZueUOF1Qf3iOAW4VPoccZtH59bhV/NNRwYFlBcBxAEEIwKQHS?=
 =?us-ascii?Q?XYWlcIpj1hENel+1iOEJbeoDrfHTK25ehEUeieo0X1nli4lQS5kGrThY024K?=
 =?us-ascii?Q?PrTiN8ukiOwcCIpwHmG209A3vqKR4BWXxtBN0WRjGeMOjsIiEHPfp0eVjS9p?=
 =?us-ascii?Q?IWnF3Wz44hl78oaFxZm2sZqA9dkBDQk9AhmYKblo3oLPgtpYfZ5g6upNO6Mm?=
 =?us-ascii?Q?6KUE/6hAmDGr91r1q+AG8JJrQ8h01VRz5fG1IG11mkAP09tI5SIDp01Mikzb?=
 =?us-ascii?Q?oXMtPueiUXc5LOeeun9llplUYOS4NEChgklb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m+NST53nw27RPXgLCtArvftuRk4U+m9WCrZzZ+MFridP04X8foIfd9OwmO9W?=
 =?us-ascii?Q?Tz4XI7zFWHYS7izc0RdZwfE/AcddAKgsoGTRX0oLXcHI8KIIzQEB/jBDUqug?=
 =?us-ascii?Q?Rv1m8BaP0q99eSh8JvG6ShfVIjO/uFQGffxBWGs88flcHpmRXIhmUb7IcXDu?=
 =?us-ascii?Q?SVD1wi2uwpkD/zJdx7H5fZKAkwVl/Stwcm2P2ZlWEPvZV995nE52/4RXnjPc?=
 =?us-ascii?Q?oY/yKu9D5iguJwdqmsm14mvCL043TUZlHJx6A6PD4odQPicQwijMuspO/RFy?=
 =?us-ascii?Q?sxlDzn7hLqklXwEt277hY0k5JBfwEMHBWd7rdgcs5ZtfWJX+j4tSq4Wgice0?=
 =?us-ascii?Q?qOeDA/I/5yMSsUjHzLsH0avB69F2kz5JcaNeCAU38Y5D5Soegw3YLvnWL8gh?=
 =?us-ascii?Q?HH+B87WQiAmRA4hXlhfKdaGW9wmkt6S6cw05akILuKqUK7Lr9uaKNhC1MPXM?=
 =?us-ascii?Q?Ax12jqurYTYvZ3WjpDjso/REPmGYvrsKmV5QQs3L0qrnaHDrxtRavo0+kO/I?=
 =?us-ascii?Q?atAi1loM6dQu3dnGiNxM79OTplTwlNHxi05AWXoyRQstiI1mYs+PGZJiXH0A?=
 =?us-ascii?Q?q/XbFeEJP0j0a6GhYeyK4LNf2gJsbBmyFPQleK7bT0YRFY0PTY8a7AINwLEE?=
 =?us-ascii?Q?YENQ9W/cJZNQNG8BUwy0D0plv+1ecvleHqi/tLsqoYNpVWYVcGVJ9S2sLMA1?=
 =?us-ascii?Q?eOrt7FcoHRWrQ9yvpWpZjEwh937zWusAHnaQXo8N52wDIKisYHXYMMw46FYz?=
 =?us-ascii?Q?yiapgZ6pCwxGNhLldMwnoc7tnAQXf/ujqD68bNLUMnvYUSKKWBSBbHSfBPA7?=
 =?us-ascii?Q?a3+5mV2yNMVMk0juGdOf+1uwjzt5TvovuDDdUXHhcEhZPy9kgv06z1I0RYlS?=
 =?us-ascii?Q?P0n/Wt4g2U4j9yjOovbuqvgmqDpaDGUIGLRER9wPMnvUMqVEhqyzSQTMtWxW?=
 =?us-ascii?Q?IBgHlXT9G3zjKxFxL0ZMizf3DwN9srZf48qkNlDg2pFXYXRK7eMxCjQcBgMQ?=
 =?us-ascii?Q?69QA4cD3gxip6fkJU9Ta3fwjnuedkKwkDrVE3M+8SEw9h4/Ov7cZsKM++Qve?=
 =?us-ascii?Q?eMlhPTnJTKacyqmft8rzX6HFwUp9buz8GxMkgq4rd8HLLPM4UWDBCic4uH5f?=
 =?us-ascii?Q?jRR8EBwT/7JipGE5p+HmPOIV1FuH733Jd+5bkyb+M69YTRxh59Ns6HUisaPj?=
 =?us-ascii?Q?fQi7nR6IFIEOlyhtmivaSk89ox6MvdDGJHQd7vjvF4YYD6WJbPr2PuYZZH+S?=
 =?us-ascii?Q?vzPaKfzY2Vo4XEVP3t2nPQgLusySl6Mnp2B2gsj0UTKYvITZG1COwMWN2lXI?=
 =?us-ascii?Q?oNwe2ja5+6jHOYPhN5WpwVtFnrNFmTU0UqWEfevUedFBUV8mYMDRMzgL+f6v?=
 =?us-ascii?Q?6IDmX2V7E02qSkhZFlx0CVQ1eP0Ys/9ONt8SujEiKen+72285LqqUz2HfNPI?=
 =?us-ascii?Q?8iETmKr488cMh/mEN/Eeb27u6Iz3XF4KmMS4xYRCrLtRPjBaN8GTbUQjqFr6?=
 =?us-ascii?Q?ZHRo+s3xCs6LsrPiRwza2tcxuXveCQXjfKO/zbybGZUKheYMtUZxDeI/9f+i?=
 =?us-ascii?Q?yMUA+eT9Qommus9WcHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2773469-9ac4-46a5-2f8b-08de36fa418e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2025 08:09:20.2159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQcYLxCOJR6JnPhFkf7XgTyChkedUx88wIXJoK/VO7c9+9pH2FbYGCEIiqZoMtNX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e Li
> Sent: Tuesday, December 9, 2025 3:49 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH 2/2] drm/amd/ras: Add vram_type to ras_ta_init_flags
>
> Add vram_type to ras_ta_init_flags.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 1 +
>  drivers/gpu/drm/amd/ras/rascore/ras_psp.c        | 1 +
>  drivers/gpu/drm/amd/ras/rascore/ras_psp.h        | 1 +
>  drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h      | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index 923bddd0af3a28..b86638fe0f32cf 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -216,6 +216,7 @@ static int amdgpu_ras_mgr_get_ras_ta_init_param(struc=
t
> ras_core_context *ras_cor
>       ras_ta_param->channel_dis_num =3D hweight32(adev->gmc.m_half_use) *=
 2;
>
>       ras_ta_param->active_umc_mask =3D adev->umc.active_mask;
> +     ras_ta_param->vram_type =3D (uint8_t)adev->gmc.vram_type;
>
>       if (!amdgpu_ras_mgr_get_curr_nps_mode(adev, &nps_mode))
>               ras_ta_param->nps_mode =3D nps_mode;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> index ccdb42d2dd6052..5d556e2a7000c2 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> @@ -507,6 +507,7 @@ static int send_load_ta_fw_cmd(struct ras_core_contex=
t
> *ras_core,
>       ta_init_flags->channel_dis_num =3D ta_ctx->init_param.channel_dis_n=
um;
>       ta_init_flags->nps_mode =3D ta_ctx->init_param.nps_mode;
>       ta_init_flags->active_umc_mask =3D ta_ctx->init_param.active_umc_ma=
sk;
> +     ta_init_flags->vram_type =3D ta_ctx->init_param.vram_type;
>
>       /* Setup load ras ta command */
>       memset(&psp_load_ta_cmd, 0, sizeof(psp_load_ta_cmd)); diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
> index 71776fecfd6649..347f5334c3f346 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.h
> @@ -51,6 +51,7 @@ struct ras_ta_init_param {
>       uint8_t channel_dis_num;
>       uint8_t nps_mode;
>       uint32_t active_umc_mask;
> +     uint8_t vram_type;
>  };
>
>  struct gpu_mem_block {
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
> b/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
> index 0921e36d3274e8..e910a75b302297 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_ta_if.h
> @@ -167,6 +167,7 @@ struct ras_ta_init_flags {
>       uint8_t channel_dis_num;
>       uint8_t nps_mode;
>       uint32_t active_umc_mask;
> +     uint8_t vram_type;
>  };
>
>  struct ras_ta_mca_addr {
> --
> 2.25.1

