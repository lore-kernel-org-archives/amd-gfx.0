Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80197D2ECF9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 07:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC5310E56A;
	Tue, 20 Jan 2026 07:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LNB2ObVn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A629E10E56A
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 07:21:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ktjp9b6I2qSHVtmUzn0l5vRgQEJZYWPC/DcwFKN8Kk0ZCA9kr5yxPh2CPY7tL6kvvucs4kD5ksYGsSFsjZ4VdgAm6PhNwoR3/W7uciDhwpmKEFtXzgJaBZ92zTjBgsPHRcwBQqu8AagL+wUrWUnpoLEgf33Ym3ey+BAKlyPFyOEz52SjbZ//Uvw1k1r739bWODgEWGMIB+PbtrPqgEMm0dakPcm6ys7epSLRb7ONRLXNhEpCwEyLEExcpOqtEO7YgrKFrFN9dHeOcNMzSnr3MuSNMippdh9gqExpV8QGd0YMMr7n6HuVCHSVEUrdxw6tIcpNRiy+yOjOyGwnBCjK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrIo3BpSgHgdlIee99kSNHXkzQqDr1kNbgYI8H1/4Is=;
 b=BrqEn9pJMSs3WS1NPNerBGBkAc6VFPOpCL/MltzZZnK/1c/Cu4KcxEaVVh3mzHUkmmRehYO1fBw9lYt1WWCz5RCtmsDmR4iMrGfg9CVrbheG2ovIWCe5XNL0iO6L7LPr6bDW/BK2Ivf2oKnBZVyC02/dQykWyshDd/6m8ZP7f9jQDX0P/rJw1DT/OMxqAJD8dIDj7JBur/lPC681v33rkiKpPkpGWvYcq3S1Sm/Lmle1JnfyOkQuFAzcCdT6SDc/g5ikStDcMq2XJyGcUlZdqWYQRlB4JjiNXIDWNrRjC3VKPleYQkqf7VYfKvz7czwTExT3XUMiwP4dY8pLrgRRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrIo3BpSgHgdlIee99kSNHXkzQqDr1kNbgYI8H1/4Is=;
 b=LNB2ObVn3uYYH1t6No1K2/BcYc29Nu6L4yptLFC5Ad8En2SHJkTQl02uVAvSmOxHS9eexYXBP1TGTrV2zlw7jf1kpPCoWaqpSssahQENWm6/Er+J6IlaNpS9nJ1dr1gvEcnP2J1xvz3tKENok0mjli7LCqtL5Yn2csFhrTfU7jI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:21:32 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 07:21:32 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 06/10] drm/amdgpu/cs: return -ETIME for guilty contexts
Thread-Topic: [PATCH 06/10] drm/amdgpu/cs: return -ETIME for guilty contexts
Thread-Index: AQHciazw09ACjIKG00OGs9UWPBghZbVap2zQ
Date: Tue, 20 Jan 2026 07:21:32 +0000
Message-ID: <BL1PR12MB5144C58F041720C62EFDFAB3E389A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260120013411.15659-1-alexander.deucher@amd.com>
 <20260120013411.15659-7-alexander.deucher@amd.com>
In-Reply-To: <20260120013411.15659-7-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T07:21:25.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6072:EE_
x-ms-office365-filtering-correlation-id: 8a7ff1f7-695e-408f-1c2b-08de57f48959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?na1wPMYjYzWn5V6Fx8FsGgJB5E59X/zL2c5+LQd/Px2j6WmUUDAAnqJYwwwU?=
 =?us-ascii?Q?EE+AWJGbp5MlJ8wX7Yn+7P9lsJuDUpqC2qIGeeroFoDIahm2kTX2OpNjL8h9?=
 =?us-ascii?Q?T7MQtAvCyNW41+5mAvmNnzyN2RUZpNd5pJBfcWiawDEnYw5BPgBsjs8VTb6v?=
 =?us-ascii?Q?jfk9rPhoqMAknqXoZdKKiivLY9tWn5ziyWVzwCMX455CoMlcHRliW/xu8urQ?=
 =?us-ascii?Q?M+y8q8A64yjLYiC9R7nGGzFI9Q3J0ChkaBrrAQliK1Z5ryrLY19+7NnV7NFQ?=
 =?us-ascii?Q?sCVEY2+4xnGiYLiyk0Ki3qsVzbdNOA3N+TepWQNd+mQeAaVJGgzQffm9H7GL?=
 =?us-ascii?Q?6jSHom7CG6CQnl7jaOH/C70vbHL3xqfuQRsaP0DcIy/VBocLK3cbv2UMUDVg?=
 =?us-ascii?Q?JS7qXaeYGOvSB4RT8n1vYatznxV5RMgySEXwPI50H8HOjIMQaaoT7NKtVsYm?=
 =?us-ascii?Q?N/d8YK9VxBLAZhxEjQ1fTh54XKEJVGC+VUGgdCk7QCdvtdSThGYi455ux/wr?=
 =?us-ascii?Q?IYx/aE7c5EAFxXsUk2hJxbnH+SFyG/qifn9f9f2ECU8uf09CFggRfiNEQTSN?=
 =?us-ascii?Q?kknGCEjC6QXIC1KrBTuQd99eLDoO6ePgcnwZPT0KW9R9+XA8Ryk9CWYXI7jZ?=
 =?us-ascii?Q?VgjZTSGVllnhEOejbWEq5QmYdAtIccrcHQ7h96YiahDpetwyclgI2+Tm+bGV?=
 =?us-ascii?Q?qij+zsx5O5mxQ1YLhzf79PM/+3NJYihxvxlu80D+3gGxXpd9U0Cs75PmrouT?=
 =?us-ascii?Q?sG7BfUcoq6nA7f77whyw/xQ7RGP6KRFQbIqlx9pGpC/AzHce/4miv2cF+sYK?=
 =?us-ascii?Q?urjXqxW/aOY9Zelf42b9QMiF1QI0OM83OKegtmQdyNdk5kBdJCz1rLGjloZX?=
 =?us-ascii?Q?JRg6DP4sTixqc4Cg/jyh/Hf7sTITydJXWXsHTdl4pT05dFvn+sA43wUKcqq6?=
 =?us-ascii?Q?iPY1Lpry0NZnhTEA3j19qg9BtBuRmHCEO7TGuUG2bw5BrjDe0ublCyJp+cDu?=
 =?us-ascii?Q?+3ws+z2NpVofxxleB7l1D7lffY92TvFyH2loy8hoj26dNImEclR7gWJlcgkw?=
 =?us-ascii?Q?ZQ1Nqh0Q7IZmjgzPyNugutHUNaSUcPBAsIE0ZwN91UZ7tRCSobn2VtSYvVa4?=
 =?us-ascii?Q?C9coRkvyhWmiq8G4mkcP9wUXmUD3B2lgQ8UFf/4PES+5PJi6UbTWoJjsrXnz?=
 =?us-ascii?Q?VT9MsBu1dVsrknw/w5GjA3Nx+fR561fLd6kWMjNsJHiHNlT5hI8ALjBV+R6t?=
 =?us-ascii?Q?msI3htHdP/C0n8X380p5wb6m7xajGUHR9+uL/pU15eMW6XIUWGqCEVFCvpxQ?=
 =?us-ascii?Q?GBv6IE+m17zdB2DPhVAJXyNdMKIEqSJKTF0HFEP9wszx4gzv6MpIcSokJWUg?=
 =?us-ascii?Q?IcgmUDwVTtFkbcrdKbqLebmQo0ALDoFa9kaM0oM4+fwxKsFaQn5wQ67r7i0Z?=
 =?us-ascii?Q?PFzQNEbLGgxpSctXS9lu6FMV/iKrnOZYpLsPXdxmgVc+jJ7Yl7i1lBjGIo21?=
 =?us-ascii?Q?26tS3XDS6fUOPEtHygtjcyAXoZHFmAxAEX9UTjDCxiTO1HAvXL5Xh65uHmrd?=
 =?us-ascii?Q?NE9Qm+hZoGj0k39DF00bJuCmidfAiiTo2PrUTmg5cwuT7GvfwNR5+vcUVZ7g?=
 =?us-ascii?Q?jk5f8u2j5d0lSDnWPZCohnk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WV5Mcp6xVZf3C2egf31A0qITYPseqlRapK44o4fe9gzwsdlDkAo16zs3ak05?=
 =?us-ascii?Q?fujq316syb42m0pFj9MK5a5pRH74wf6n91J/58wWXlbqiHt4R7jfry+HLTwu?=
 =?us-ascii?Q?cPDkLttNgHSkrLwTmo3hc9UsfGmclyf6xdI+E3kxbfXSdouSRo81iLaAbKBh?=
 =?us-ascii?Q?UOI4OMvpEIxYY11GpzxQIKnVHcHZH9kkPxvMZ600A1vVJeGu6BCQN4HHwB2k?=
 =?us-ascii?Q?+AdlFSr8mGbaV0BDPEHX4Dpo3y/4x83vRyYx9EwocpIHUsgn6qjZi7yIEmXc?=
 =?us-ascii?Q?T2pdFq2olTaubxjYIkL2bh//9rklTZK7oamm8xahYByiftFyNgknzTTAX4P5?=
 =?us-ascii?Q?KPO/BtHMhlOEsYzje/sUBbKMwLCjd9e4QpAouJkfap95aUz2boewOJydYXkJ?=
 =?us-ascii?Q?3zjPmxNEaSt1wIZT2pUOQqCvTJEaTn12kvPoPWrQZcClbNVHVIk96frTqlos?=
 =?us-ascii?Q?ubOg9oBOiBDE1s6LxdDWjMcmdwE9RqrRUuMnvJViKUvZqprq36bhl5vM1sKo?=
 =?us-ascii?Q?leKLB5Yv5Wy7nUm9ZCWIDS88fG3xxClEgliuQn7VQWtNa8XdcvX+ip/d12OQ?=
 =?us-ascii?Q?vZshCZypKeLfISqxLIqJFZmpiBgJcqRZMF+vJCto06rS30Axkf9h5dNW2nt/?=
 =?us-ascii?Q?kwYsrGvIP5blo6kS5UyVgoWzfFxMoEuZBoy3qr6memNOwOPgzkqhHJuopuIF?=
 =?us-ascii?Q?LICuO4/cZVSQlYMi3cx3NnCAOkbuzvaWY0XBDsZj+2qPopzTymSYZ4+ci5Vv?=
 =?us-ascii?Q?AG+3PKU9AyJiDU9pO4vmvKYCu6uIQdJIjLg3j1A+kr77r+s6Jhe+on/8ZdvC?=
 =?us-ascii?Q?FJ7rX5AwBalp4M/gZvGQn8inewpUXybYYPMYNJtQotlywHg2sxZALWsq/jsy?=
 =?us-ascii?Q?Jjzfm+tKNQAxm3589l+uaL+pf2JfaboaCdt3Q4V/8ZeihHr3QCHhCP8BYnIV?=
 =?us-ascii?Q?6LWfgphVzhCZzqGN379+91GEhjxh/US6hh9Hn9ya5G8L3hel54/NBSvmSqNA?=
 =?us-ascii?Q?AlECBFT68WkMGiaXe+1P+eq+oUlxt1QpKIWga0Fy6Mlv1ZJA3ht1rBbz9/CW?=
 =?us-ascii?Q?qXdiJMwuC+Pf+PdifRSSJQ2LVhxKKiH6jjw6zKEjRB8RDzUXFFPuPZWoxt6M?=
 =?us-ascii?Q?HaWrEdFeoYqj/dpymUkd1mMwzUrrgeYyGu/VrmA3vAbugVOTROb8wcHOKjS1?=
 =?us-ascii?Q?F0eYSZ7II3C7xVfUedOY1K+e3XH6KVxLFVgmV2K5FW4RzfwxgD50pYVGx2rf?=
 =?us-ascii?Q?Rev6mjB2siSKpYjZOcIoS2WiL6viztinlJIN6utjrdC1szDmVnuATbSsLhe7?=
 =?us-ascii?Q?bki99X0gklXIBBK+UraEM6fMc0Q3aOtcIf30s5VM1EoN7VMsYg2U0vv801wa?=
 =?us-ascii?Q?D2VUBZMVBC9w9roZJ4Zw/MHuUkMawkcNq4pEdF3Zcf+aRh6lBW52z5T2/52h?=
 =?us-ascii?Q?FDmcKf9kxTjl4NkhqwPw+bfWY/L07sxk6rEsqNRxgx0Mw+xkjTcWa9FaXLtL?=
 =?us-ascii?Q?2LhiwMgH4KYf2UscVcuZckR8oYCs+6WOV2qN/BXpSdZUlhVItwNRtLW6XsWl?=
 =?us-ascii?Q?etmjLj9fkR+GuvsiJpmh+RQAHCSoVDvb5LUR/QtARPEso0yy+B39z+Q/CIBb?=
 =?us-ascii?Q?slHQ+sqypEm3JEiaNPBbMKJvw+Vh5mC0dEZXyicy6I9+gaAVSzE+lazhH7KR?=
 =?us-ascii?Q?/Byg126+qR1VNHhWVthhzK5CYqFgkD++98AhsLiUkWlgJOM/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7ff1f7-695e-408f-1c2b-08de57f48959
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 07:21:32.0706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8ZUv3ah2YGtIo/lNRpl+LtnO8k6a6RB9EUsZPwH5wwtesKKtIfOhygABc5XaUTOC27cwvZUuXB1/tEFGcVzcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, January 20, 2026 9:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 06/10] drm/amdgpu/cs: return -ETIME for guilty contexts
>
> Return -ETIME rather than -ECANCELED for guilty contexts.
> Userspace only considers contexts to be guilty if they return -ETIME.  Re=
turning -
> ECANCELED means the context was innocent.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 4d53d9cb8490d..3112a7c5be81f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parse=
r
> *p,
>
>       if (atomic_read(&p->ctx->guilty)) {
>               amdgpu_ctx_put(p->ctx);
> -             return -ECANCELED;
> +             return -ETIME;
>       }
>
>       amdgpu_sync_create(&p->sync);
> --
> 2.52.0

