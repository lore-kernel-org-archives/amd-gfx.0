Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A504CD172D4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 06:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B3310E11D;
	Mon,  2 Feb 2026 06:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ywBqwBTy";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B9310E11D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 06:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoJEaO6c+9iQP2xinqOhzkkUhSAIUge3np+8KuDktVh7L9D1z8Jpme6a8RVjlUGqt7h+L+N5DFbZXTA699m1sT5j4iuaxYMP4v7YxoqTeMLqCH1vLdl8tMMBIzNZldPURP90DDNfMfgouT7jqydk7iV3Vdu/gYfUz8/6vZ5uijwxBHIQp90HNXWp/JfixMo3Rh0dWC0vDLKY1fq+AtZ7mVR+hw6WiKNgsNXW7gbZ/TDV9SlD/NjPL0qeaqvAkKeju24G1nkOIAquX4/MSO1u54fuTvsd8Y3OCz/67O9OT+gAmec0KHWf8OlIh/B1OY/v8B6QLTlWVtMP4IvMHHU1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr430Qy+AbXHuFRDNYtuOOUOIAkjs0LERdJDI97FpQs=;
 b=iEEX7EV6D2ZZmzdryxtKfOEeqLNyhUoAdVtFfaiEdLJfXy33Y5wWzRTL/wJ0U3M+Fkh4E6LpeEAz0WSP6fvIaxV6Dz6oTPgjFJxKBu3iNP4LIoo7eddoix10xV5F96V+LneRuSDR0YB5TdgRBcPueYvSO5JyE5aNpr36VDpIyQVZM6ovNvi8OT7fF80CRH9qSyt9M/CSQlrv/nMKgs5pMhGUW4ymf5ba35GO4WT0uoC+RE2U/FfHKGOUDRzVGFNlKeAER+3GXIHVe8hXCqN81VewRQpLonul3fzt7iek+XjdYAiQRF2uuGYn2vqpeAXQ8aM9jwQ6mz9QOUhSJEutaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr430Qy+AbXHuFRDNYtuOOUOIAkjs0LERdJDI97FpQs=;
 b=ywBqwBTy8tnUW21dbjl3o61z2h6DHtW9DeqX9xq3+wQiOSv1omE1z+Ku8oSEj8JjGu5OZ/TAzwaBEOnO8VeU2DgepSkGkB0TSfJSVQIweAehzhfeM66hz+EfRXboaywlZWhe1T5x1NBUBM57f6btlD+y0XY8XSz0aAdhrnfNjOg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DS0PR12MB7898.namprd12.prod.outlook.com (2603:10b6:8:14c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Mon, 2 Feb
 2026 06:24:14 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:24:14 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is
 exceeded on init
Thread-Topic: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is
 exceeded on init
Thread-Index: AQHckizmZbCjLkdvlUaEtIAlwN5ay7Vu9EwQ
Date: Mon, 2 Feb 2026 06:24:14 +0000
Message-ID: <PH7PR12MB87966F7BDEC2610399874C2EB09AA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260130211031.446011-1-kent.russell@amd.com>
 <20260130211031.446011-2-kent.russell@amd.com>
In-Reply-To: <20260130211031.446011-2-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-02T06:22:36.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DS0PR12MB7898:EE_
x-ms-office365-filtering-correlation-id: 46ef2fb3-32f8-4b27-9c35-08de6223afd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Xd20M49yW7mT63V5idXfMt+46i1+eigtA3j8ETSEhv/6xEDYXViZPtCJ+EAz?=
 =?us-ascii?Q?xF1HfFcghvK+zGYH9vkfqUsniU2hMyZA6u/HLStR179NPs8WkZu0uNtwoP1G?=
 =?us-ascii?Q?nTKjSfVk6lJtZ/NkzQGCEG5S0X9iJGekgcwh2Fg/dKSTL45aNtJJI/m9l+Y5?=
 =?us-ascii?Q?+aSm/NMNct5AsQFqEbSqwvm8fnjJYVeEwRQljH05uD2i/sLqT+BzCNIzgv6s?=
 =?us-ascii?Q?pBQXCytoMd/k5LmPnRrmK/xnnL4uSw9JA1bhUB2P2J+AUgEBQEy09rmKrmEX?=
 =?us-ascii?Q?uofI5ATyzG1nkPXZ9hTnLDcX5IPBUJLZ7dSHvxpHagVXVhY1vfjlyzLvh/D+?=
 =?us-ascii?Q?lRAjnFJ/QGtId8xJ9F7wvOq6WhcWqLPSDrrfKQ4d+lLZPocBKdndPqNaA7Qh?=
 =?us-ascii?Q?w8xfFjMcw3SOrMman0pNbEaVf5YLFa6Z5I+vE5U0ZqhUH9xg83VpdVWMGu46?=
 =?us-ascii?Q?XvDCjQEwoZB1fWFCO6foA2Dw+ftndR+on8BKWInb15V944SPNZAkd26mI9ui?=
 =?us-ascii?Q?wzxhlASkS/fLr8m9lsVBGP0RcfCdGtwG0BM6VqU8YtATA6jv4cHoKsfrlFlQ?=
 =?us-ascii?Q?safpclkDBXtZUVC/jmDD+Zpsstw/gMh00cRlWhfPYA9fYQSodu5Xy0kPTShi?=
 =?us-ascii?Q?WafWXQLFyzbRVup+1axs9ZuMXhu5UE9/4amytEjbE8hUysOkhkAit5FF9qJ7?=
 =?us-ascii?Q?wAt/aq9bY3Ej3P62reBEMvtoERDWSn3RZijbGnmptOIabnFdi+aSz5Z2nd3R?=
 =?us-ascii?Q?xdhl4KjLjZIV3noiVrmFrmqjaK202qq2IkU4wOL20WReek6u/ScaQRjoDXXi?=
 =?us-ascii?Q?2gGRPW9HtjYtoPqyvQc+MtGRYS/Ial3oA33viXxHhopqlIOwkPQ94Me1ppIm?=
 =?us-ascii?Q?MBkCv7CkmTIN8mLGx7ho5cNcp91oif9kjxSLaTmRSzl4zE8XOzOQQ53wVCSf?=
 =?us-ascii?Q?wdtKw/xfNDmFSBt8bHIVeDxBUyaI3KBihEG0dwh3qlEypxZtzz8ncyF4aaKG?=
 =?us-ascii?Q?5mKU7pfLFnDr76YwQTNeqldbkYWUJBPvgor/hO7zxqSOoByYM9+107hTO6xy?=
 =?us-ascii?Q?ssEjQNKuR27cO2ZpgpoJXGebeWHoMblc6gWX89r1btPE8UiBfBgeIZ4+oOUW?=
 =?us-ascii?Q?VsAzXQv0/qLY/0xa/wn0Uku7wslITOsOsCmEDsC77SJKWzP7Htt2mkat7bDL?=
 =?us-ascii?Q?yYApecpQaxeKa1+rJKJyOvufxWCDRzve9iie+Al4BsMEQj84ePlSkpjs1TIV?=
 =?us-ascii?Q?dD9oXgPAAZcXZQ4sljfoDRTCtARs6ZR5I/loxS+3aLcYuj/hufOzzb8+AHBY?=
 =?us-ascii?Q?TJaqA03qfrA+EaEjmiKs8Wiqoq3DVf9HmmAkdJhS/o925iI8541vCux7aF3a?=
 =?us-ascii?Q?yzYCb0u2132raOiu9lJUrG0YiW/VIyn1J41qMD0HhbAYYigLiC1oGgbfu8cm?=
 =?us-ascii?Q?v6WkdGs42S1M6HCIYHga2EXn0kKkSft456K3d8CaPUxrh5ZtPyG647jttThC?=
 =?us-ascii?Q?CQVc9tu2BLpf6bZBRQVhcelSvimlh8C5f0uJBbF628a6SzaOVq3JSPAQgSZI?=
 =?us-ascii?Q?uK5vFVHzyXp6qEDEZidqG9Fld8DOdV+tE9z2x5LEztGIklQR4HHaw+yBSpeS?=
 =?us-ascii?Q?ZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IOscIWyts6w+CYDPL8d8XaRBlSaPKutjfPyyadxDtV9vj+QBH4eT5AwQyuhW?=
 =?us-ascii?Q?g7XyDhTtWuAbT6rbdwCUGgTcRs3/EBIlvjY8Eiwpra3bZiWHdVARJHD6KAFV?=
 =?us-ascii?Q?SPLdKAsy9pcvbKlmwaE6Ww2uD+OwuNXMq1rHkP70mlxWbGnmnNFK1ZTJToES?=
 =?us-ascii?Q?aVWzG0JT5k+JLfzB0uohS5GyUUiXY0v/XZ9zpGlDqLrkE0g/iANCTgnmMo39?=
 =?us-ascii?Q?aU7hhQeg7OGRL3OmHWzjfY8A6pbkMzQ7efiA1TtcoWZgMaw6ViwhIm5gVRJb?=
 =?us-ascii?Q?JfF/lxoLEVVzvXtqqwqoIbkBYKdt7kno29nRcs8hH3PDhc+pWbYrZZjOVwtQ?=
 =?us-ascii?Q?n1zjDtjLnx2avO4yFtQEk5qhB7lO/bvCNta1mSEfcr5YXAdy4pR8HUuwQJVQ?=
 =?us-ascii?Q?hTcSdsYDQcR/JeHk+FJmj58D3KMLh1260l6E+w6mO+Huo9QNZCA9aU8nfJkd?=
 =?us-ascii?Q?zM2gL5rxe23FO9Yg/iNpuYziGAqeUv3WVO21ejaCMFI+VkE/yFMDpAkkhQ/m?=
 =?us-ascii?Q?8fQc3d29/zrZjygDZ/6J/xQoUXCf9FFq9ApRHILhMKRi38jny10CxFQ1nd+f?=
 =?us-ascii?Q?C2QfmVT7WBdVc8kSEai3ZZGK252Ze2IE+kkTgnvnLOftcP8Rae7q9r8wi8yc?=
 =?us-ascii?Q?mAeo8P4135kRCQWiTf1+pLfy24QALJ1kCYT7h0GWFhQVGOjKKA+LMOAjcHOb?=
 =?us-ascii?Q?cM8QqIRjepYVwXNsq1VEWsGfSQqp5THDm3WKcPmwA8aTPrWweVoXKL3D08ZL?=
 =?us-ascii?Q?V76WcHNnpexy5nbbJWOsME//MHpbDcNTyotRlps5aGkVIXiNTvkgwQYFhB88?=
 =?us-ascii?Q?vT+8i7DMY1JhvLA9eRjeaRVxDBGt2ROPxzr+094gK/gLxsjCgziHEChlWEuv?=
 =?us-ascii?Q?5vw98o4dSRZHibzm2snO5ycV3W0Pfx7OrKm77F3yT7of1A8UqtwYEDRdgYQk?=
 =?us-ascii?Q?cPbBMNmLq+1/jtQgU4Hb3yb0BalpbEXaBRBweA3bngkQfi37WJ9FLc2JIunK?=
 =?us-ascii?Q?mAwPt8BN/luk1QfzhSiE4xGcb6BczP4UtVBAVGPCd4eY50P2ucUwtnk+3rui?=
 =?us-ascii?Q?7FkQy52QDSiJhb5+tWUNijbmY+lTO4YLBLt2CHrNTlW9mzlgPUM+/Kbzxuos?=
 =?us-ascii?Q?f4Z8WVlCBQfx9hN5YSAIdIWBr7LYYcCHkS1+wPzv0t/qRHiRr0wCXcl3IU0P?=
 =?us-ascii?Q?EOIkt/n7zSva5SGV3Y8MudeZe05fJJc2s1TXaAbl1GLuSnUSoc9etc0w7Cqg?=
 =?us-ascii?Q?E9jr8yfqPrYP6i2Se8BFHyRiIvuphLckL32lPnVgYhQmmGoHFdQWsAn7N+5G?=
 =?us-ascii?Q?utbHIpaA8ZTbXO7aNQk0JeRihJGx6Jui7IrjTmq6P+lSB0cduw/reB73DsZT?=
 =?us-ascii?Q?/QxdIehUzSQaGTG3pUljfLSqJpbSRiFWJWPbmwj5Xktde7BBQMgeYJa+kJX2?=
 =?us-ascii?Q?PbTxjAmkpFwtc9pkMc4QsFrruCKuEuvj2WRg1+rwWhwDKzv+kr4w1Cx576kx?=
 =?us-ascii?Q?Nf5CtBt9A+qlGQMVKp/w5JQ1V6MVLKuYgCw38TC6IhHQBcl/uytGFwFUIfKG?=
 =?us-ascii?Q?L5Uklt2TYbrXQV+RBz5++s3ltg+7JL7WJyboQ7RlAT3sgNeM82vssxpqClAK?=
 =?us-ascii?Q?TFnRIezfKAtr10Bs6Ptc4IVXhESw/9AConw29Llxz7o1+48GdKsQaFmwBRlf?=
 =?us-ascii?Q?TJ7tnM5Izjri7jFjCor3FMQ9a6/k1ooM1D0IGsr2nmzqxzSR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ef2fb3-32f8-4b27-9c35-08de6223afd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:24:14.6003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Xl0/ghk7PG5XIkWRCm33SkNaRtHhsi1dVlxQty1qRtDt3HSsPQi6vy1bZ6K2V8O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7898
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

Hi Dean,

Could you take a look into the patches as well? Thanks.

Tao

> -----Original Message-----
> From: Russell, Kent <Kent.Russell@amd.com>
> Sent: Saturday, January 31, 2026 5:11 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: Send an in-band CPER if threshold is exc=
eeded
> on init
>
> When we load the bad pages, send an in-band CPER if we have met or exceed=
ed
> the bad page threshold. This aligns with a previous patch where we sent a=
n out-of-
> band CPER for the same case
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 469d04a39d7d..dd7d837b52bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1715,6 +1715,9 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>               if (amdgpu_bad_page_threshold !=3D 0 &&
>                       control->ras_num_bad_pages >=3D ras-
> >bad_page_cnt_threshold)
>                       amdgpu_dpm_send_rma_reason(adev);
> +             if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
> +                 amdgpu_cper_generate_bp_threshold_record(adev))
> +                     dev_warn(adev->dev, "Failed to send in-band CPER fo=
r
> exceeding bad
> +page threshold");
>
>       } else if (hdr->header =3D=3D RAS_TABLE_HDR_BAD &&
>                  amdgpu_bad_page_threshold !=3D 0) {
> --
> 2.43.0

