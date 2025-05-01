Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF080C369DC
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 12:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F9910E03B;
	Thu,  1 May 2025 12:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O55NIsTH";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F76610E03B
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 12:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5P5qz72XOegnm/adFrh9q0SpQleVBloo2hQZfVuVNt3Ml9apPoMcrwufZxTwm8KIZekv6aMcLbSW5SgSrSus6+ceeLg1SlYydMOLrC3CWA9S/C7xrIAJL0pYL3qzBFjFID2jIoDVEY9kyTZGUEJGl4b5/92xFef6fsRvF8QSdz47TW8NeueCYLideluSdAWcBoJmYiTvjvuBi0hs4Jyd8ZxukyDdLgPVFlS7gVrAbwNJquAkKZlky8FmYddtlzPwtYFrc7WzGhbp1Syh6I7Zb4mY1qU97/PMmivEtKWPJX8JCaPmR12gEhES+mYc6mw2DpdKdX9UL4Janu56xQCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wrzj3riE8Yn5uyYX5VHs6eFHbiW65xD7BqwTzg24Qk=;
 b=hLi2fmK5bkb+cyAXuW0k0RJ1SBDlSTHH82S2gJcX1958BtGjKQLQioV79eULIe9A1zbGb32ayl3feO6yBtGkZ6KGu+uxnr+hA9Fv+Bp8aPeYnvplDNgrBeyEAeKDDvxpMqie2tdy2bKK+bKxmfFdDju+UgfGetKuJfa+UQ1x7taOLZPq5a25fmrTjAYwy6MohSul0874Pn8Nr5BPGdKbUT3SK7uTwZlF/iF9yGIw38SZl5SEsfvhw5pWqRYEC+GLKRp8fLwUPEiCwsTLdEYkvv/RJRFXatkPbYe0/cX/kCTZH9Zrtr0jsvPFoLM/YihxH3e1V8vcnyxUg/h23CKikQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wrzj3riE8Yn5uyYX5VHs6eFHbiW65xD7BqwTzg24Qk=;
 b=O55NIsTHoysKlx9gvg/1vEMA0jdf89QqiAnd7pasmWg7H+DDMAUSlMJUUvHtfnHXd4qPSCkbRk8jHMlW8AsH4pHG2ELIy5YogMZhwOhyyHeStl3XnQ5XD4XNfTaivBhoKp4rzsL13LpGg3OTSNYXja+ob7pD0bdioKocoYc87As=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9173.namprd12.prod.outlook.com (2603:10b6:510:2ee::9)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Thu, 1 May
 2025 12:48:47 +0000
Received: from PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286]) by PH7PR12MB9173.namprd12.prod.outlook.com
 ([fe80::f397:98d7:65a7:3286%4]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 12:48:45 +0000
Message-ID: <349c9fb3-e51b-4399-9ac2-fb3553318c9a@amd.com>
Date: Thu, 1 May 2025 18:18:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn4.0.5: Fix GFX10_ADDR_CONFIG programming
 for vcn1.
To: Ruijing Dong <ruijing.dong@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian.Koenig@amd.com
Cc: alexander.deucher@amd.com, leo.liu@amd.com
References: <20250501002732.1266299-1-ruijing.dong@amd.com>
Content-Language: en-US
From: Saleemkhan jamadar <sjamadar@amd.com>
In-Reply-To: <20250501002732.1266299-1-ruijing.dong@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::15) To PH7PR12MB9173.namprd12.prod.outlook.com
 (2603:10b6:510:2ee::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9173:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e253a7-a1b5-44c5-5ca9-08dd88ae823d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1JURkpjM3l1Vy9zOFJhWE5tekxoOW1MZ1g2V2orcnBFMGJjR0FIL2Fqb3dM?=
 =?utf-8?B?b1pqZ0lwdlZuMWQwZEY2Zi80dWlaSWx3YU56WC9yTk9XejVtZEpNVk5pdzg3?=
 =?utf-8?B?OFltKzJKWHZsYjZ4T2pSRVhaQ1p3QzQxSWkrWVNDU2ZtOTkrK2x2NGpBUFdr?=
 =?utf-8?B?T3gwUkltNnpReHdkdG1ubVhxVStuR2NZbXlOaG5HMnJKL1UyNFVEQ3VsYTBG?=
 =?utf-8?B?NmVKb2YxZHJLY3M5TWFuenlOQ0lZQm9TY1lRdTdYQUlpQWNUYlpCbXJJcmNT?=
 =?utf-8?B?S1JPNjJEaldYbU0zTklOSWxidlRSZHY3Qm95VlEwZFRleEtOS3hzY2ErV3l4?=
 =?utf-8?B?bVRPVlAyTERHeXRvL2tGVjNYVC9hVWNZeHBTSzVCZ0hyV3FoWm81VVZCeGIy?=
 =?utf-8?B?Ym85M3Y2MG1EYjRKUEJOYndFQWZ1SDVDeERwSlNPN1RnV0ZNSktVT2pYWFo4?=
 =?utf-8?B?Zmd5R1NmRXRSMld4a0YxckJJMlF0SGQvZ3dKTFQ3ZkhvcmxrTklqbk1hcXVT?=
 =?utf-8?B?SVBGS0psOGI2MHpQeVZlYzk1QU1EbUJDUXlXS1gzdklBV2pTMDlwYmJVaWVL?=
 =?utf-8?B?ZjdnU1FzWjh1NWVLYWRhOTlJbDBuTEV3N3VERVZYdzM0blc2YkcwbWFPNXRY?=
 =?utf-8?B?Z0ZXV2hsb2kxOGdDK3BzQ0lpbS9oSGdVTjF4bWJIV1dIYnd4T21PQ0NwcmlH?=
 =?utf-8?B?TWRPZmw2ME1INDRONlBLd3BBdENaUVBZSXhiZ1c4TG1GbEF5bXIyenNaeTdO?=
 =?utf-8?B?ZDE3aG5aYmJacStLSEFacFdFaEV5Tm1jbWhicVdLYi9uTjVPUWVSUkJvcTFl?=
 =?utf-8?B?UzJEZEhlRmZVOG5RNHc4VjFCem9RUXQrS1BPcFBWdjdOcWhBUWttYnNzRGJs?=
 =?utf-8?B?V3lWR3l5OXBHZGUzSnRTbTRkUDZJVmd0VzlDZVB1UnU3Y0tkVStaRFZBbDZ3?=
 =?utf-8?B?b1puNmVXUzdrNnJ6c3JHSWFXRHJzaldLRUNPSkZ5VkZwQmJ3dWM2TGVsMFlu?=
 =?utf-8?B?SXoyZEt5c1ZYQWozQUlNcDY5YkVaOVNDdUVNU3c5dFJaK1REZXp4bFV6V1pN?=
 =?utf-8?B?TFpGY000cDJiVjAwdU9HQXBBYkhBeFNlU3FCZlV0TjZFWUJ0VmptTHJzWk9z?=
 =?utf-8?B?NkZ5YWJQQU9oS0lycWhxN0lyak9HcmZtTnRIYnIzWXpSS09kQmN0VHFNd1FQ?=
 =?utf-8?B?T3FNczk2cjRYOTcxcnlOSC8yWklYdGZtOFhHcnZleE5yTjlZTENwQUpic2F6?=
 =?utf-8?B?eDVSa2xJcnZzZmVmbUFkaUtZSTgwU09SbG1SWEN3WS9CV2hCa2ZXOHVqdmlW?=
 =?utf-8?B?elpoZEtxRGtHZVJmcHhKQmtETUlnUjQzMkdDMzFDa2x0Y2piWWVsMlRYeFVw?=
 =?utf-8?B?WDZqelNFM2VTckx4MU5XS3d0M21DU2w4SXVPWWlqSmZ2QWs3YXBxUzA2L245?=
 =?utf-8?B?TG5FNVhKMXFhd0pPMC9SaCtMaDhYeUxORW1abmE3QWRCSlN3OTdRcHA2OEZV?=
 =?utf-8?B?WWNvOUlIdmx4ZktvMGFWRXFrQjBTRHgweW5BQm04Tncwc3ZmdWRIWUFvL1Mv?=
 =?utf-8?B?L3Z5NnNpTFVkSGZrQ0s1eE5ycmgvWks3SHNzVWcxNnJieG1sbHdNMERxSXQ1?=
 =?utf-8?B?MG9xMnh2RlhlRk5DRWhoMHJYY09rajh0Q2plQ09RU2w1RStXRy9ueWJaaUhi?=
 =?utf-8?B?T3RUQmlGLzNqL2hXaVYvOEkvYXpXN201aGlSc1BVSkZ2a3BjMk4xaU5na0dK?=
 =?utf-8?B?cUtpck16MUh3UnczNVRxY3VDY3BlbGNXeDRpRVNzWjNpL0tGSTZ2dDRPaENx?=
 =?utf-8?B?UTBJNTFxVEh4eVpERFdPSDVwaHc0WFJrRVpxV2pFc2lNZTU4YklvMzBQeW02?=
 =?utf-8?B?K1F3RVROdXYzdWR3VXcwejh4ODAzQkNpWUkzSTdpcTJaTlFuWmlwelkrNTlO?=
 =?utf-8?Q?9CfkDHmW7eQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9173.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1h0aGcyeHo4aXZUcU1ZTnd5TkVHZjZVREtOUE1hMnF5NVZvbmVnVlB3WVh6?=
 =?utf-8?B?MjdpWmZvQUJibXFKYThjSFRnVjE4dlBycElLcWs1UG5hc2JZWUJOa3E3WjBL?=
 =?utf-8?B?TFZxNEhNaXA1dFR4Y1Rha2VwN0ZCNlkxNy9qWHhrcG45TjJzVEVSRy9qOHZM?=
 =?utf-8?B?UEs5NHpoYVVvK3A0ZjlPKzZENlcza3dsZ0ZlRU5NcUtUaHhJbGc3OG5iQ0NC?=
 =?utf-8?B?VWZ3QzFadjVBUnF3U09BS1pkS3lpbUdCY1c5ZnI1b0JINWhmckx5Q0cxS2JZ?=
 =?utf-8?B?UThzZ0dsNWxMLzNudDNqTjcwaFBRRlFOUEhZS2w4TmtLbkRMdmVXRnRkUGJ2?=
 =?utf-8?B?VzVOK0ZmTkpJTHB6VnJ6LzZ0ang3QlBrNXJSeTMvYXpRVTZRSmVWM2xqTnBX?=
 =?utf-8?B?alZWQ0hUTXJKdDMyelhzdE1HRkZTdGpPRzdNKzBDakd5RDAyZ1hSampUYkZj?=
 =?utf-8?B?UDBIU3JDMWFXdFdPNDNySng2Y3hqM1F1eW1PUEtaVS95Nkg5WWlrN0R0SVdZ?=
 =?utf-8?B?RUEvMVI1YlZNZlVsenhlcGtSWm1qSi9kWnZ4RTN3dm4xNkI2RU91ZnUxSzFC?=
 =?utf-8?B?akIxM295R21DSlNpa3lTaUFEUnZxUVIxdnJBK25hdHZVdFJ4U1pCT3NZM1Rm?=
 =?utf-8?B?RGV5bGk2U0I5TXdVNFVEWW1jTVBmbS9tUXVKemZzVi9pQmNpamI5djFNK0I2?=
 =?utf-8?B?b1pPWVFhNUhybWZIMmZDNTF5L0FuZHM0NDFseTJIN01QYm9uSUNTU2haVkJZ?=
 =?utf-8?B?eXMzY2NERzRoMERzaXkwNVNUb0FFTnhBbDc4RkhFdXExSXUwNVVxd3pKSjdR?=
 =?utf-8?B?b1FidVNPWm5oUE8rT21QQ1VrWlByRW4zZDU3endmbXF2alYyRHZDMGZpZjRk?=
 =?utf-8?B?T296dnJ4SzRlSVhnL1Y2UlZod0Z2U1N6bW9vZ3J0bnhrNFc0MEFFMm5pWjNr?=
 =?utf-8?B?a2FOWEhzbytBSSt6bnBRU2c2NlF0VjVoTW9HOVUxSWJTOElrV1JvaVZhVmF6?=
 =?utf-8?B?MU1HY1ZxUmE0ZXhsejlNR1pjOEszNU8vNmY4TXJycC80cHdCT0ZQNlEwNitz?=
 =?utf-8?B?bllaZlJqSFlMNEFXTWdiRVVKbnZ1N0xSVjBjcU1GdThQNDFmZ1FHb2hhTDJM?=
 =?utf-8?B?WFQwS0RQRHE0TExOUW51U2gzczhlUkFtTitVQ0luaW8zemJ4aEhPNm91UjFo?=
 =?utf-8?B?ZWdoUjRSWFIwUVI2ZGlUdVpOQTEyWlhNR29zWjhLNXdZdkdLb3Q4TloySHB3?=
 =?utf-8?B?eU5RQTIzM0VrS0JpeXNRWXhTRDBqMy8xNHZueVlseFRZMDJZb0pzQTlaWTZP?=
 =?utf-8?B?OWNRQ2V1WTI2Ni8vbkdObURRWUhaYTBPT3M2ZVl5dVo3eGVxNW5TQkpXTCsz?=
 =?utf-8?B?VHhwVElEbUFDckRMNm5NN2ZvR3A0QjhxM3RhcWJtcENHelpxcVF3NFkxYzRV?=
 =?utf-8?B?YmVjaXhCRlB4SGZZVFJnNG5qK0Nid1NwS09CL1RQRFBXbTZWMVRiNFdFczVX?=
 =?utf-8?B?aE5PNGJURENnTVkzMldLN1ROZ1ovRVVYWEZySWtYN0h4TnZZZjRiRHA0cEt5?=
 =?utf-8?B?NU1iWFNyR3g4akxFS3luYkJPVGM4ZEJoaXVPaXpCaHpSUGI1QXVPZUQ4a2tw?=
 =?utf-8?B?NGtzMzlVdUVPZVpWeXo4LzdpRGdyUjZGSVhNeXQ5eXlsbWhsVkV0ZmF1dGpK?=
 =?utf-8?B?MWdIaFFFbFpBRmZYVDJ5QmpHcTlJZmRXZWpvbHBOdmJ6cDFoWCtySEd4Y2JW?=
 =?utf-8?B?Nm51allGSXYvaFFEOUYxWkVGSDhnY2MyNURYMDJmRUdYTEI3ci95TGtxOGR2?=
 =?utf-8?B?SWlPWDlEZHZWQkVaN0E4cDdkc1pzb0NRcEFCUGVRRUZDT0RMblpqN0pILzI0?=
 =?utf-8?B?RzZqQUErUFIxdDFGY2NoOHVaNXQ0OTc0a0ZNOGUyWDdNZENqMnM5cEVMQUJy?=
 =?utf-8?B?RERYZlptRmFSTjBKUWhJbyt0YXh0emd1bGdiMjNpTFNqK1BJNVl4TkI1L0l1?=
 =?utf-8?B?MUF5Q3RtMlJsQXc2RVcxQjh2MlJOSnNBaHVMYm1YWmJSaWFvZ1A0L0ZISlVx?=
 =?utf-8?B?K3BwN2VPRG4wU3lmeDQzdmFkN2FMdE1DMzI0QUR2b29vUkZudEgzRDNOYzBi?=
 =?utf-8?Q?2Pju61pIPmfyZBBmrCXfNBjDr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e253a7-a1b5-44c5-5ca9-08dd88ae823d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9173.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 12:48:45.1288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaozRqdzVom7/4aFx0vM9GhI4K/NMwHYkTLyAOZ7GDKNNDlj2zIIqKt/l6eT6JQ05zM9TTkWFscmksYfpZH/EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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

Looks good to me.
Reviewed by : Saleemkhan Jamadar <saleemkhan.jamadar@amd.com>

On 5/1/2025 5:57 AM, Ruijing Dong wrote:
> The UVD_GFX10_ADDR_CONFIG's offset for vcn1 was programmed
> incorrectly, which causes the corrupted output from VCN1.
>
> This fixes the issue, copied from UVD_GFX10_ADDR_CONFIG
> programming from other VCN generations.
>
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index a8cfc63713ad..31cb19e144fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -563,7 +563,7 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
> -		VCN, inst_idx, regUVD_GFX10_ADDR_CONFIG),
> +		VCN, 0, regUVD_GFX10_ADDR_CONFIG),
>   		adev->gfx.config.gb_addr_config, 0, indirect);
>   }
>   
