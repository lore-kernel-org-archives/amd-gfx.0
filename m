Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45552D34097
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 16:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E053910E0D5;
	Tue, 27 Jan 2026 16:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J+PPvJh9";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9333D10E0D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 16:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoRhSgQFvpliN64gS+dyzg6VFaexgj8sgAx1LC3ziiTdkndyB6Xv0VxwxVaiqGFFpc+Wf22ImNfTNI0Rvfzj6tPG/kH1tSZhfvmZQp/U7GNHphOlUNjphLIfEdjh1sbXkXcoB/4QNXwYv9bAdxUSM4V+QJ0aSNUTCqzUxCCV+zzGUVul4WBq9FGsxp6ITVMPwz7vGHDFvqzWDrzBtF2qs+rVjzfNUSUhioMnE3tmJgikupxwlpEwLIx+f4epfVEkp0ddJoYMlbDMn1zohgKkS1H26v01e+/lv50DqEUAr6+onA/FQNLvbjtO70IQJsjv9I2p65PyND4h9uErRhBOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAKvtpzKq2bEmjP4QivVfMer/nVrgmjna/MYJJVRTmQ=;
 b=b8x8Q9OGgCPfyiH3plRfg3qmh03MiVlUKorXoSVdlK0XHw7UzZRkPOofSUHgyWNUUubv69Wyz0bX15cu9wkzblFeOkDmHXpYxxwQLbkpc6Tsphz87V2PiyzOX5SqYFA6m/2aBUne3d8WqEv4QdMA6xaxOA1mnRvYEvjK4pVtUO/6VU57AcU8IDufFk8S+rIZeS5dgjyX6dk1x2giUBt6OB/3uUoS60EYAOH4R7aYTjEAVda/qcpDIpvDOpnYPSimCg/BiIn0CKd72YUmF1WD+6aZh33S8PLgaKjIH0ZzCbAGyowEDKf367bKyFQwK7ZA2E7CwaE+h9WzeuklqDtIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAKvtpzKq2bEmjP4QivVfMer/nVrgmjna/MYJJVRTmQ=;
 b=J+PPvJh9wUL/QaYxdhQItnlHTJdQddh4ib7Hc3WzeRD/0v69eJ4/yzoRhLO3EyVVDLkOqY/6mmEx3PTL6Ve8QF0Hofob43QrSp9CzENCf1Yk26JXhnF2D5hW/SUKsNBky0HF0BeQLDIvULxwj3+KWmURHNnaZXgNTmgjUMQQgBc=
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 16:22:51 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 16:22:51 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Belanger, David" <David.Belanger@amd.com>
Subject: RE: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+ kfd
 mqd manager
Thread-Topic: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+ kfd
 mqd manager
Thread-Index: AQHcjq4p2ESIrM0jJkmq7uZ61UfzHLVmMsVg
Date: Tue, 27 Jan 2026 16:22:50 +0000
Message-ID: <BL3PR12MB64252E57E572DBBD5387C23DEE90A@BL3PR12MB6425.namprd12.prod.outlook.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
 <20260126102514.273891-4-lang.yu@amd.com>
In-Reply-To: <20260126102514.273891-4-lang.yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-27T16:14:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR12MB6425:EE_|SJ2PR12MB8182:EE_
x-ms-office365-filtering-correlation-id: 6e22bbcf-b8ee-4e42-3254-08de5dc05126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zen7XTeZ3eoH4xeJzDnfdsflAnOlqToavPsj9UM0hgKDIh8WFE2RhUF/DCz1?=
 =?us-ascii?Q?0B+WaZhHstCabLDCz/ATue9HB3UQz3uqt9P/bquLAzsQUSwllrp5WocYtTtx?=
 =?us-ascii?Q?3bgglza+zvAlHUIGI0YRPQ2yNitNzXteh+weGsvthXbX4tggOOOJuURkkske?=
 =?us-ascii?Q?N3LDJ2ck9QQ/TMtCV5Z3J5MsMVB3HDt0KyuegdT+wCOYnRDRl5cecW3RExHw?=
 =?us-ascii?Q?PGWYqZN6bEFnIe0kQ54eZER0ZvGqJQlLT5TbpVkOFPN/V/dnfzC74PEyfVVA?=
 =?us-ascii?Q?dUQ5TBHbzOUsfUmhQWb6aczUNf63r37abkFAaz4ljGNLMyslaHt85/LD5UCj?=
 =?us-ascii?Q?zydOJiZTz4Mr+6vrKtak+MHtcQgWDXS1k06Q6YeN+eN27gTLO4qVZCb2PU4v?=
 =?us-ascii?Q?7AJpUl35W/3aLdSmVB9+AF7pxBJOSIsroBrniN4XUQDYD2b1LFojH05waND0?=
 =?us-ascii?Q?PIIrzq+tMcUfbmoWEMZBh6hM+6N/Y6DxWK+3F7NddogtVR9pLRFIxebCcUi1?=
 =?us-ascii?Q?qlX9jZ+xbB3Fkzo5U2gV0v9IsX/khf5iqW6adaYk/+DAW21yIVySfLRoJ6++?=
 =?us-ascii?Q?LrNtc3NEwhFe1/rEmeiawmS9pK9rldPXid/G6M8lPfnNAoflTz/l+MAOx4SU?=
 =?us-ascii?Q?/poMVCwbpWV0i47/qZQ6PcsZakYkldM1AzZmAPxOEFnSNjl3Ha2TPmez2mcQ?=
 =?us-ascii?Q?qsXqB+Ss/Er+75dW1P8HII/fL5+86ZrVe71jYcdalwtvvX9RdEvCnjiR8/6K?=
 =?us-ascii?Q?PfMr86/5NlnVcsI0gAFh+y4PIxeyDm93EYAwwQYAuJmvF7ulL9jhEmC4rdJz?=
 =?us-ascii?Q?pPQ5KIGlDwoHxSPKYVQ/fMlHWwNcX5NGFmmpGVUU274XIXDq90eFyUhOmwWI?=
 =?us-ascii?Q?cNEywL40/2UNINy2XnDvv5mnxs50Rqqbjg3RjSRZ7opFZUmsM4XzZhhU6Toz?=
 =?us-ascii?Q?Qxx0Rpt6Eni2AefdZWjMWxhhQT1nvm1Uwln9fO/ZxkCA2LfPeXOUsyZKHw1D?=
 =?us-ascii?Q?5CC7jrywYtlIQV2FbubuyIbeCFFaRNc54KnP1WcxJ8YqUFSinO8YiffmTfwJ?=
 =?us-ascii?Q?kgFwAWCtnesbfdsyEBBRbU4iTS7TRzuNENr5Jfi2T7+BEFaD2kPq2ZO0w87v?=
 =?us-ascii?Q?dQ/tyEgTxPssHOp6DsctcgaLHtInm4acuXQbca2MT/u2IoWXq3dhcQsHcivC?=
 =?us-ascii?Q?thWtqkwY8RmlkzmdkdRCb6wJqt+niYONQ/8u3vFmS28iAtGgDB4aQtvzwmir?=
 =?us-ascii?Q?cTmCbVh/qZYpdeiguLhyvBBwH0mh2zx3+bFNHLoGZqK103viej32mGxNgbQ3?=
 =?us-ascii?Q?z60UPPh5lNmVUK2cTRt58DTe/TQwD4gBe6a2XG8cgacxV47y4XK84U7fWfFI?=
 =?us-ascii?Q?9P0qh90zrENuA63Gr2Emtyw+7r61FFRobZjnQuDsMV7W9Gx4OOr4KwX1UixE?=
 =?us-ascii?Q?iYGjCRfXBWamCWGKwW0ZK6/clk8KMmXh3gpW+jYW77K+dHUZ4ovHY3W4s9Sz?=
 =?us-ascii?Q?YKCZ0ffoPdVMLUxWbQDN2/eOeSebGj00LdAK3zY/PYUNG9eGk3iUAZSOB842?=
 =?us-ascii?Q?xXbcNriqpEes1N8JrJx9yZ5rIoCfRx17m+N4ZWPBt/xqJaj8/XedNUEYYoUG?=
 =?us-ascii?Q?CAtQDhrgH5Cl1M2LjuTWedQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nfqcWGiRWtgZP70JxrCXO3gWL2jndoweSHo5+vepdEY60o5WzstBty0OQ3Nr?=
 =?us-ascii?Q?aIKkik4wyxfb94f/4vB+Z+JJzGT4meJFprMaQtXdG4qPnuO0F6I59N/unp0F?=
 =?us-ascii?Q?rtXQxXWuG0hL/qA7XTqI1ufOUb6dCatuuw0lbxGpsR0gC9vdsmxs7t7b8rKU?=
 =?us-ascii?Q?0Tm2H4S1q1EyYVtqsDx2c4djuoXSKZeIFFrfrtRrkNyF07Jk26i7VHKxlJNG?=
 =?us-ascii?Q?JvLFmZVfYjJVt0S6ajLoM6IusVEAvG/iQZhLSr7O00/TRIZ2+FigD78JpUFV?=
 =?us-ascii?Q?SnHL344tw7n2qOIFF64MlHRwDVflFcOhZ+FWNgSnxK0LYayRnlDH1vCqlQid?=
 =?us-ascii?Q?41Nyh/cSmG8G435wCO2PkKwOPY9C63gRpN34IEC3vTnRMA1Ih272rg3Ltye7?=
 =?us-ascii?Q?HjkT23FnAbj0+Eo4zJxhae23fSaRSLqKu1yqb9DTF7GFwFSIGZCUDO5uuiNQ?=
 =?us-ascii?Q?umswI2Oi9AWyW8VhNxx1uNRchaBaWTfhQzd5JReVLOY6DAWdUxCFLNdwPBvl?=
 =?us-ascii?Q?QhgvYB64flpr8e47dg1bzICBozx+XM03uQkQneEw73y/5k8sSLTpYVlVO9b/?=
 =?us-ascii?Q?qRaSoVXI+gmQYMS16wpSW0B2iDUvUxwVRLRFLIcut/oNOSyN2HBK/P3VFzpJ?=
 =?us-ascii?Q?k1LMqzoCCTnLPbSp5qfSD3B791Rvrcfn6Mhz/zX116bn67rvDiFc007Ho9u7?=
 =?us-ascii?Q?x4LLKiPGzXJTA1s8wKejyAOr3/Vg3CROfxW1npIbRNibrM6wfypc4shOC+S9?=
 =?us-ascii?Q?7DVHCihHuR0sHsJL30dX9iLo/HLNtryQxx3y9E8s79YttbkgNNLZMTYCyavX?=
 =?us-ascii?Q?5QUB2U+zIa2xaRa7NR2nXqUF5r1qrCLQjoypCSkVLXH0BB8xTbgCQZ5Dm2PE?=
 =?us-ascii?Q?26VgdF0rebiEDdY+bJHUa86Q83qRq1Fey3IBDMfKh493zPkiJtA4SFMD3F5I?=
 =?us-ascii?Q?rZxS/9Et+dKC6mkzNNsuKWUZfccz5r/hCjrHHh6zFuxUlY/Kxu9uKtubqqY+?=
 =?us-ascii?Q?OSgmpRbiD2bciqjA0/bqs/SpwjuIwntAlIlUvQF/9u9wkE1Nds3+AMZfWcMa?=
 =?us-ascii?Q?UwcWx4fm6U7poEttpl3D81IAiQoB2Btqe4qjpzr8jJ10m7m4CU9BdIrvf3xT?=
 =?us-ascii?Q?OrPomZCBihtEocSeV6min6bTvyVNaeSQRFzmGUSqHfSwOdR60/bucZpwLGgC?=
 =?us-ascii?Q?rrt87xl1K47BaIecnCWQ0U6oCR+7DtZzRpTx2W5TTFfxmmZLwySShDYAVQIz?=
 =?us-ascii?Q?xE0lAwHfqtFgiVncaVyWhHVIfUJqfMNIVp3flqD264mxNveXr+wkViqItAZf?=
 =?us-ascii?Q?IrteNBCerNAAZ8saC3QiQFc2o3LUFC8GG1mQFhSeVzJ+kmluTO333a54R6ZH?=
 =?us-ascii?Q?3gT/3vNJT17wUakrewTIdOBxQLngk4dHtc4QPgIq7R7SniyOQtqtswWbZAnL?=
 =?us-ascii?Q?OZv/n9Q3G2nKqqTMNFLeB1pwjrpRNCbnL/YviPlqseS9bRHcjIxNoqMbp27G?=
 =?us-ascii?Q?oBuryZd9TdupycJEUgAq0asrNn6WYSa5aoNN21PoO89ZeWJLnFe5vEIoiXHa?=
 =?us-ascii?Q?KyxTIosCN3uAlrGcCfkQaU7ir9U7w8wHqygaqyUsPMecZgLuwBjwdEjG5JA7?=
 =?us-ascii?Q?CNvd+9r2J/KjRn4iTRdBsHU/ek5bCKkGleT9TsZmzLTu5At/OjQSyVwEWW8U?=
 =?us-ascii?Q?1JjfIhuyDsO9yBUQzGnQq96YQi3raTjbZlk40r8CoW754o62?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e22bbcf-b8ee-4e42-3254-08de5dc05126
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 16:22:50.9497 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jcypRadIJVazaGZdDCQLgotp+zEipDxO9fvBt60davaZM88F502YpTgi3m9Woaxrw4QmOkFiVPi1dMvRLZzqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Monday, January 26, 2026 5:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>;
> Belanger, David <David.Belanger@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> Subject: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+
> kfd mqd manager
>
> MES is enabled by default from gfx11+.
>
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  3 ++
> .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 22 +++-----------
> .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 10 +++----
>  .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 29 ++++---------------
>  4 files changed, 17 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index ceb6566ff3e1..d88d0de58edd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -292,6 +292,9 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev,
> struct kfd_mem_obj *mqd_mem_obj,  uint64_t kfd_mqd_stride(struct
> mqd_manager *mm,
>                       struct queue_properties *q)
>  {
> +     if (KFD_GC_VERSION(mm->dev) >=3D IP_VERSION(11, 0, 0))
> +             return AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
> +
>       return mm->mqd_size;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 5c44d0987737..7e5a7ab6d0c0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -102,20 +102,11 @@ static void set_priority(struct v11_compute_mqd
> *m, struct queue_properties *q)  static struct kfd_mem_obj
> *allocate_mqd(struct mqd_manager *mm,
>               struct queue_properties *q)
>  {
> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>       struct kfd_node *node =3D mm->dev;
>       struct kfd_mem_obj *mqd_mem_obj;
> -     int size;
> -
> -     /*
> -      * MES write to areas beyond MQD size. So allocate
> -      * 1 PAGE_SIZE memory for MQD is MES is enabled.
> -      */
> -     if (node->kfd->shared_resources.enable_mes)
> -             size =3D PAGE_SIZE;
> -     else
> -             size =3D sizeof(struct v11_compute_mqd);
>
> -     if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
> +     if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>               return NULL;
>
>       return mqd_mem_obj;
> @@ -127,18 +118,13 @@ static void init_mqd(struct mqd_manager *mm,
> void **mqd,  {
>       uint64_t addr;
>       struct v11_compute_mqd *m;
> -     int size;
> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>       uint32_t wa_mask =3D q->is_dbg_wa ? 0xffff : 0xffffffff;
>
>       m =3D (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
>       addr =3D mqd_mem_obj->gpu_addr;
>
> -     if (mm->dev->kfd->shared_resources.enable_mes)
> -             size =3D PAGE_SIZE;
> -     else
> -             size =3D sizeof(struct v11_compute_mqd);
> -
> -     memset(m, 0, size);
> +     memset(m, 0, mqd_size);
>
>       m->header =3D 0xC0310800;
>       m->compute_pipelinestat_enable =3D 1;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index b7ac2dea8775..a51f217329db 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -83,14 +83,11 @@ static void set_priority(struct v12_compute_mqd *m,
> struct queue_properties *q)  static struct kfd_mem_obj *allocate_mqd(stru=
ct
> mqd_manager *mm,
>               struct queue_properties *q)
>  {
> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>       struct kfd_node *node =3D mm->dev;
>       struct kfd_mem_obj *mqd_mem_obj;
>
> -     /*
> -      * Allocate one PAGE_SIZE memory for MQD as MES writes to areas
> beyond
> -      * struct MQD size.
> -      */
> -     if (kfd_gtt_sa_allocate(node, PAGE_SIZE, &mqd_mem_obj))
> +     if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>               return NULL;
>
>       return mqd_mem_obj;
> @@ -102,11 +99,12 @@ static void init_mqd(struct mqd_manager *mm, void
> **mqd,  {
>       uint64_t addr;
>       struct v12_compute_mqd *m;
> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>
>       m =3D (struct v12_compute_mqd *) mqd_mem_obj->cpu_ptr;
>       addr =3D mqd_mem_obj->gpu_addr;
>
> -     memset(m, 0, PAGE_SIZE);
> +     memset(m, 0, mqd_size);
>
>       m->header =3D 0xC0310800;
>       m->compute_pipelinestat_enable =3D 1;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 0b0d802a0917..d0776ba2cc99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -32,17 +32,6 @@
>  #include "amdgpu_amdkfd.h"
>  #include "kfd_device_queue_manager.h"
>
> -#define MQD_SIZE     (2 * PAGE_SIZE)
> -
> -static uint64_t mqd_stride_v12_1(struct mqd_manager *mm,
> -                             struct queue_properties *q)
> -{
> -     if (q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
> -             return MQD_SIZE;
> -     else
> -             return PAGE_SIZE;
> -}
> -
>  static inline struct v12_1_compute_mqd *get_mqd(void *mqd)  {
>       return (struct v12_1_compute_mqd *)mqd; @@ -148,21 +137,14 @@
> static void set_priority(struct v12_1_compute_mqd *m, struct
> queue_properties *q  static struct kfd_mem_obj *allocate_mqd(struct
> mqd_manager *mm,
>               struct queue_properties *q)
>  {
> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>       struct kfd_node *node =3D mm->dev;
>       struct kfd_mem_obj *mqd_mem_obj;
> -     unsigned int size;
>
> -     /*
> -      * Allocate two PAGE_SIZE memory for Compute MQD as MES writes
> to areas beyond
> -      * struct MQD size. Size of the Compute MQD is 1 PAGE_SIZE.
> -      * For SDMA MQD, we allocate 1 Page_size.
> -      */
>       if (q->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
> -             size =3D MQD_SIZE * NUM_XCC(node->xcc_mask);
> -     else
> -             size =3D PAGE_SIZE;
> +             mqd_size *=3D NUM_XCC(node->xcc_mask);
>

SDMA MQD allocation is not per XCC in the partition. This wastes a ton of m=
emory for SDMA queues.

Regards,
Mukul

> -     if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
> +     if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>               return NULL;
>
>       return mqd_mem_obj;
> @@ -174,11 +156,12 @@ static void init_mqd(struct mqd_manager *mm,
> void **mqd,  {
>       uint64_t addr;
>       struct v12_1_compute_mqd *m;
> +     u32 mqd_size =3D AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>
>       m =3D (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
>       addr =3D mqd_mem_obj->gpu_addr;
>
> -     memset(m, 0, MQD_SIZE);
> +     memset(m, 0, mqd_size);
>
>       m->header =3D 0xC0310800;
>       m->compute_pipelinestat_enable =3D 1;
> @@ -681,7 +664,7 @@ struct mqd_manager
> *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
>               mqd->is_occupied =3D kfd_is_occupied_cp;
>               mqd->mqd_size =3D sizeof(struct v12_1_compute_mqd);
>               mqd->get_wave_state =3D get_wave_state_v12_1;
> -             mqd->mqd_stride =3D mqd_stride_v12_1;
> +             mqd->mqd_stride =3D kfd_mqd_stride;
>  #if defined(CONFIG_DEBUG_FS)
>               mqd->debugfs_show_mqd =3D debugfs_show_mqd;  #endif
> --
> 2.34.1

