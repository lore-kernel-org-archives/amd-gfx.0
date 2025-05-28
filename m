Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E3FC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 07:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7316810E1ED;
	Wed, 28 May 2025 07:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CA9/d2AS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC35E10E1ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 07:47:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYmraQCeqQeqnORAO2aKwW/9O79FhcnEv5ONKyNIw3p0Xjw+6wKpTrQaskTObvHPdQwRCYeegsieFO4TtT26sqlTt/CKsaqBIuhXE+I3BcEEAPJCoTrOrOZYI3SzLwIe6CMY1WZKFikjyJj1w+Vh4j/zqi9CmEFw6pTvK9nMcRFfqcHbOEDVS6Rx/PsDIt5vdXGO5t+mJNbrSfDcPMWT/VSKE02943pHP0cMEPWHi+ZRZoHDNw7idEMNyfms5WKJfZem9JCVK+C8aW35bihM9VbK1MQ5yHtIfKFWAKe+J+hs69np0c/19IFHugyHwD7NFKLh2N39A+19oIJZcg5SPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPDMdX7yP9C1J5C4R7ko4HIJPIQ6Ga5OkTqTOXdZ7dY=;
 b=cK4SUU7JiQZUQGG87NjRGoVDmivoKVMjLfFPkiiRA5ZqsVnsPDMYOY8SHF9R7+jpwnvBEudFVDz+LjevIMzHUBI9eGdYs1Y95AbAROCyFOwKZK/UViu2K6nhO2xTAdkxm6cyc10pppN+fEMNEtMxUw6yDQ91VnZFTUZXcUzM6DdxB/579RAXKhyHt0TVvnDlniAIQXiOvm+WOmXegIJLXtcHV3CTQrPfb6HhDPYfZkSx2uhaqvKpgKKngm44fOS7F1L4m7nRkmiJArO+S277f3RUmQXqLAzAV8Bb4gtyHT3ohig6PKN9oqT3pji7X0SQjoU+lKMj9BrSDnFzVkdBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPDMdX7yP9C1J5C4R7ko4HIJPIQ6Ga5OkTqTOXdZ7dY=;
 b=CA9/d2ASIUCWweCFktYkFjXVR441j8/OPn+KUHJVC1BdIEIdYX+NrMZZBwZ/hwsR4ey2Cxj1jft4Asw74+iGuPgoJw4SmSkjTClBgxNeFttw+TaRKQOImJpaI4P+QIutWP/T/Ur7bhwUOOtMcofC8Ubk4kp/tGDNYSnMYob0ybw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Wed, 28 May 2025 07:47:03 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8769.021; Wed, 28 May 2025
 07:47:02 +0000
Message-ID: <0d82b43d-4548-4013-87e8-d13ee2f185d8@amd.com>
Date: Wed, 28 May 2025 13:16:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] drm/amdgpu: enable pdb0 for hibernation on SRIOV
To: Samuel Zhang <guoqing.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: victor.zhao@amd.com, haijun.chang@amd.com, Christian.Koenig@amd.com,
 Alexander.Deucher@amd.com, Owen.Zhang2@amd.com, Qing.Ma@amd.com,
 Emily.Deng@amd.com
References: <20250522104048.569456-1-guoqing.zhang@amd.com>
 <20250522104048.569456-4-guoqing.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250522104048.569456-4-guoqing.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd43acc-7005-4b7f-3221-08dd9dbbd576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1NwczdxaG5QYlhLYnZ0SWdKcWttcFJadzlYVVVKVzhveVlFblBsSlFjTEYv?=
 =?utf-8?B?a0JHYjBpZFdnU2NMd1lBVTFTL3hwS0NvTEVNWW1pbVVscFFZelFNd1pFZjho?=
 =?utf-8?B?ZnVySElNQjdMbzJKcGt2U0UyNm5KbHk0d3lQakNHdy9qVERJTDU0Y2ZadElw?=
 =?utf-8?B?UHQ0VUJuVHIxb1pEWXh5d2FUTTdtcS93dWZENWMrdlZCMWxvck5zRGlqRWpa?=
 =?utf-8?B?dTBrZGNHUFpickt5TlN0cXZtSE5WVGNkOHhITnlXWlFHU0RTbnpDSWpQWWk1?=
 =?utf-8?B?bFJXZ2VZWUVjZDUwelFPTTM2bFk2VUZCQk1WMTFQalA3dVFhU1VlYzhPMjlJ?=
 =?utf-8?B?Q1RsUW81ellFYzdKbTBadHBYUmhwWVNQMitJaUZyVWJUbHlqTVZ5SUQrS3pN?=
 =?utf-8?B?Wnl6dXJQdTZMYUVkRWN4NnJQRUtWaFJ4UlRXUk1NMmNueWl3S2s0c0ovWEk2?=
 =?utf-8?B?YkQ1L0tqbjlEZEVJUWJRejlYRXpYN3Q0SHFsQ2cyT2hPS1hYRnBFcU1COFdL?=
 =?utf-8?B?b3V3RXdhSEFIRG9GSzNqZFVZZStJRUdJM0xjNGEwVGNmY1hsYWVYaGZmbEty?=
 =?utf-8?B?ZnltQzZuRUlrNlNxdmFnMVdsaGgzQ2oydnMyWXpObFFvK3QrRGtOOFlXSkZH?=
 =?utf-8?B?TythOGQvZEI5NWppQ2lYS0lFYTlLelE0M0RxVVRjY0tuVFlVRXBqSnpLRWNO?=
 =?utf-8?B?SmFLV3hoaWZjS1lhYXVMRmw4dTZPSSs0dy9HYXRkeXFoa3VJZjA0T3EwMFhj?=
 =?utf-8?B?aXI3MHUxT3o5cTlPT0ZnT0pXQ3hDTkozcWlMNzZzZDNscVhCcUV4b0tGaHlW?=
 =?utf-8?B?S2ZQR29ZK3o2c3Z2WFFDaVczTXNydks0UUpGS3B5WVI2UmgxNHJXREtuWkZN?=
 =?utf-8?B?RitXSldZWTlTTWlMUFVUcVhyV2lpUTRFQjFkbGwwTzVOVFlISG5VZEY4UjMy?=
 =?utf-8?B?OGZoSml0dTlxTTh6cmhhKytzOEdZVnVDay9ESGo3dGE3RFVtRlBPN2RrUXJa?=
 =?utf-8?B?RkpTTkR4dFo1MkxveElzVnNBa0daN3czTlJlbnl5c241cG41d2RROFFub2to?=
 =?utf-8?B?Sk1DS0tmUDF0MTVHWkpsOUY2TEhrZkF3WmpNZ1BYc00wSlJMYUJlOGowSUVE?=
 =?utf-8?B?L2R5MjZ4ZVl3bW9kZ2tzTEsxYzhDTEZvZkQ1ZTdSUjJRVWxTdnRDSFZFQkFo?=
 =?utf-8?B?Ukp6bVpSMkRvdkVCL0RBZzZ3RHlZcXhGdnJXZHZhbEtoS3ZVTGpLZlBJWWJX?=
 =?utf-8?B?endJeGxkRUVoM25MekhHYTdUNGZ6V1F1TlRNcXkxTE95dDZEQ2hkRFgrZERG?=
 =?utf-8?B?SmExQVBPS3dZZmZ5MUIyeDNZNnRhWWo4L1F6ckErZmZCYUN1eCtrb0NIMDFD?=
 =?utf-8?B?QnZocldPdmNVSTRHWUhBNDViaGMzZ2lZSWR6OERJR2M0RkFVb25Pb1hZUWFy?=
 =?utf-8?B?WjJpWnlFR05MbUNmZTUvYmVoZk55WVU2ZkNNd1BLbmRHdWZhOFB2ZXk5UU1E?=
 =?utf-8?B?cyt4OEZNdzdiSkU3UnJNdXNyd3lOSXZiVzIvajRtOWtHaE9abXZ4aUJkS2Ri?=
 =?utf-8?B?VS9ZSHhubkVld21uUWp0YmV2ZG1EQXRVbUZLejJsMFVhTVVJWitYRUJXcHlM?=
 =?utf-8?B?ZFI2dytnaUs0aEF1aldFeVZOR09FdUNWdWNLVzdsS25sQUZibXJWUE5ndU1F?=
 =?utf-8?B?V2Z6UVNpQnlLK0RoS0FNeG1mMCtTWnZqUFVMdVF2eU5IMThvS0RCR3Rzei9L?=
 =?utf-8?B?Q3FiczNZUnE2eFk3UDdXTUJJUXZMb1A5bGZjaWZaS3ZteTlFUXhDd3p5STZS?=
 =?utf-8?B?U1ZpSGRzVFppR3U4bTg3TWRvcVJGZHlYWkFOU0tocHlub3VSd3hVYWNLUWow?=
 =?utf-8?B?N0FMaUI5Z0hMa1RkUkpnYXd1MVZYZXhGYzJRakRDVmcyd1dEWjIrVHNSL2lM?=
 =?utf-8?Q?imj41qzmmtg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZWRGNLL1hic1hDMUFpYUhKWHd2WkVzRkRHWHBBbFJLSjNCMEtvTUNYUTJO?=
 =?utf-8?B?eHgvRnIraFkxb3djbk81RTFraU1MMWlNbHpXRDJZd095Wk4ybHlES0crZzgw?=
 =?utf-8?B?Yjc0WnNkM1RoOVdTZ2lQK2I0OS94RmNtZTV4Z3dzMWtDVUY5WEsxMkQwOFc3?=
 =?utf-8?B?bW5kVWdFcythR0FuNzEzYTNoSUgvUS9DNzBkd0ZhRElrWUdXUmxDdS84cWlE?=
 =?utf-8?B?M0pSMkx2NENQSk5DMW03VkVTZzNVWTFEdjJ4L09pMURubHdtMnhIOWNHdEk5?=
 =?utf-8?B?OXUvT25ITjQ2MGFvUk5KMytUb3FRMTlKUWlUMzFlTjZSOXNQbms3eXJaTGFr?=
 =?utf-8?B?cm5TWGZXVjl3T3ppSHFKK3lpUVBJKzZENG5BVG5XektHRFpSR0taODI0NUtL?=
 =?utf-8?B?a1l4SnhYWXlldDlFZkVwenpGQlVVYUpad3lqbTZoNkhtaFB6enhmMkl4VEZI?=
 =?utf-8?B?QWtsRDJJeEN3ejFHSGFrL0NUeklzNGVjQ3laODBla0EzaEZmN3Y2bWxUZU9j?=
 =?utf-8?B?UzdtRHZFN2NGMjc3VzdSWHU5a2dqU2crWFlHb0tCTTQ0QzRzNDV3VTZteUFz?=
 =?utf-8?B?U0d2WDd2VUROYXlWcUhBRDFBaHJNcE51blhhMmxIRkhzdGtBbDVNZ1NsOU0w?=
 =?utf-8?B?d3NHcnlVbkIxRlhQbzNzTFdMYkplNGMvUFVTTmd5UWxtMWVndUVCdjN4Tko3?=
 =?utf-8?B?ektNWU1nVTY1ZzhZUEY0Q1RHK3ZPMXh6ZlBYdS94WnZJbVlEbWpJVFUyUE5K?=
 =?utf-8?B?RjE3WlMvZGg2WlowMEVjY2lUNUltWUt2MnU0STYyck8zalZxakt3V3pHaW5r?=
 =?utf-8?B?WDhmSWJHL2lEbDk5bDV2cVlDSTd2eTFIbWM3QkthWVNFcEJ5Mi9Hc3R6M0s3?=
 =?utf-8?B?bG8vQ2ZVeW5nQ0dDZ2d0RVJQT0xiUE1SaXZ1UVlSOUljVFE2ZmZsYmV0Zno4?=
 =?utf-8?B?cjZKUlZTanRJL2dycXo3QnBvOVR0NTIzQktPeXpxQXlNOHNFaVh3WkR5TjBk?=
 =?utf-8?B?TDJHclBGME94YXNSZEJDdnl2Z2k1UEJGZTgzL1lZTW8vcVMrNlc5UURsWllB?=
 =?utf-8?B?cEJNOUN3MzlEYzUyU2grUXhNNGgxUytGYytaK2FyZ1dmMHY0TkhTbnVsMU45?=
 =?utf-8?B?TUNHcmhGdHdoZVI3MFdLTWx5b2x0YkVqUit0MzFvbDlIeHE5a3NSSjJuL2tN?=
 =?utf-8?B?YUd6ZzNKanUvdjhiMnp3RlNDMnI0RmlvdVp5UjE4NkJiS0tyOWh0ZmEwREdH?=
 =?utf-8?B?SjFsbGZ0dlJhaXFqU0V6NzZxcDZWN1dzamZvVFR6OSsxMFp1Uk8xcURneG9P?=
 =?utf-8?B?V2JrOUpzMFdJbzlTL05xNUEwYkhNSUFjQk9WT2E4Ukc2K0lkYWNQU3Z5Titn?=
 =?utf-8?B?SGNUQklwUzByR0FQd2IrNDNISFFNSGtoa3c0aEVvc3QzYlhaU1NhYUVCQndU?=
 =?utf-8?B?czBlVUxxZW4vSEovYmtEcjM1YWs0bVEzRzcvbzNLK3I3M3hMamw1aHhMQzVC?=
 =?utf-8?B?ZXRRbmJpS0xmTndHaHdtRzRnbmZaWU9ORUphSEtnWDE2QzVIN2x3S2NqT2dn?=
 =?utf-8?B?NWYvdkZJMzVOaGw2NUhxNHFmcW9rYmJGL1JqbjhDSmc4Ri84b1dMNmt6UUpr?=
 =?utf-8?B?OEhFSmdkbXJncGo5MFlnZzlqcDVhb09xYkdScVB6UW5yamVSWFJQYnppSnRs?=
 =?utf-8?B?RkVhTlJibUV3UkxVQ3k3MCtpOHMycmZJZDN2L1Q5WTRjUkMwUkh3NElLWTQ0?=
 =?utf-8?B?MEpMbTEyMXhtM2lPNkFRaENRL1o4NmlBM0QrSVA3R3FSYW1OQVRmcVE4bDZW?=
 =?utf-8?B?NGpuZ1UwVHlxU3doSHdjR0Q4aFhSOXU4SHV6RFBlNW13ZnVNTWYrU3BPMXdn?=
 =?utf-8?B?RWxZNjRHZjBaQ0pGa3R5ZmZDa012NkFXS2hoUktKWVM4N3k3dzV4WjNaMllI?=
 =?utf-8?B?S0JrN2RWZDY3bG0rZlQzT1FhWVRxandFMmZNNVZvWWc2Z0d6SFBxVkx2eVFG?=
 =?utf-8?B?LzhwN0ttcWdTNTNleE5zcnV1ZkJGQTVZSk1CZjJzOG5mSU5TRE1mcmN3S29l?=
 =?utf-8?B?WGFTOCtEbnhyZE5UL0VLWERqY0dadzdLN2dwbTc3UHV2R2UyNTJxVGs0KzZI?=
 =?utf-8?Q?LYjBcsDj9BHFcNrzIUE3/Wh60?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd43acc-7005-4b7f-3221-08dd9dbbd576
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:47:02.7292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZPJu/x+6h4yNqZigcLB5iNXEGrugSlQ+DNEwyhN0esiJwVnnmAnOj7uhcFPvTIa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230
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



On 5/22/2025 4:10 PM, Samuel Zhang wrote:
> When switching to new GPU index after hibernation and then resume,
> VRAM offset of each VRAM BO will be changed, and the cached gpu
> addresses needed to updated.
> 
> This is to enable pdb0 and switch to use pdb0-based virtual gpu
> address by default in amdgpu_bo_create_reserved(). since the virtual
> addresses do not change, this can avoid the need to update all
> cached gpu addresses all over the codebase.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 28 ++++++++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  8 ++++---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 13 +++++++----
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  6 +++--
>  4 files changed, 39 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d1fa5e8e3937..74b565283aa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -38,6 +38,8 @@
>  #include <drm/drm_drv.h>
>  #include <drm/ttm/ttm_tt.h>
>  
> +static const u64 four_gb = 0x100000000ULL;
> +
>  /**
>   * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
>   *
> @@ -251,10 +253,20 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	mc->gart_start = hive_vram_end + 1;
> +	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
> -	mc->fb_start = hive_vram_start;
> -	mc->fb_end = hive_vram_end;
> +	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
> +		/* set mc->vram_start to 0 to switch the returned GPU address of
> +		 * amdgpu_bo_create_reserved() from FB aperture to GART aperture.
> +		 */
> +		mc->vram_start = 0;
> +		mc->vram_end = mc->vram_start + mc->mc_vram_size - 1;
> +		mc->visible_vram_size = min(mc->visible_vram_size, mc->real_vram_size);
> +	} else {
> +		mc->fb_start = hive_vram_start;
> +		mc->fb_end = hive_vram_end;
> +	}
>  	dev_info(adev->dev, "VRAM: %lluM 0x%016llX - 0x%016llX (%lluM used)\n",
>  			mc->mc_vram_size >> 20, mc->vram_start,
>  			mc->vram_end, mc->real_vram_size >> 20);
> @@ -276,7 +288,6 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
>  			      enum amdgpu_gart_placement gart_placement)
>  {
> -	const uint64_t four_gb = 0x100000000ULL;
>  	u64 size_af, size_bf;
>  	/*To avoid the hole, limit the max mc address to AMDGPU_GMC_HOLE_START*/
>  	u64 max_mc_address = min(adev->gmc.mc_mask, AMDGPU_GMC_HOLE_START - 1);
> @@ -1053,9 +1064,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	 */
>  	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
>  	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
> -	u64 vram_addr = adev->vm_manager.vram_base_offset -
> -		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	u64 vram_end = vram_addr + vram_size;
> +	u64 vram_addr, vram_end;
>  	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
>  	int idx;
>  
> @@ -1068,6 +1077,11 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
>  	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
>  	flags |= AMDGPU_PDE_PTE_FLAG(adev);
>  
> +	vram_addr = adev->vm_manager.vram_base_offset;
> +	if (!amdgpu_virt_xgmi_migrate_enabled(adev))
> +		vram_addr -= adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> +	vram_end = vram_addr + vram_size;
> +
>  	/* The first n PDE0 entries are used as PTE,
>  	 * pointing to vram
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> index cb25f7f0dfc1..32a3987bef80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
> @@ -76,6 +76,8 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>  {
>  	uint64_t pt_base;
>  	int i;
> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
> +			adev->gmc.vram_start : adev->gmc.fb_start;
>  
>  	if (adev->gmc.pdb0_bo)
>  		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
> @@ -91,10 +93,10 @@ static void gfxhub_v1_2_xcc_init_gart_aperture_regs(struct amdgpu_device *adev,
>  		if (adev->gmc.pdb0_bo) {
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> -				     (u32)(adev->gmc.fb_start >> 12));
> +				     (u32)(gart_start >> 12));
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> -				     (u32)(adev->gmc.fb_start >> 44));
> +				     (u32)(gart_start >> 44));
>  
>  			WREG32_SOC15(GC, GET_INST(GC, i),
>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
> @@ -180,7 +182,7 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
>  		/* In the case squeezing vram into GART aperture, we don't use
>  		 * FB aperture and AGP aperture. Disable them.
>  		 */
> -		if (adev->gmc.pdb0_bo) {
> +		if (adev->gmc.pdb0_bo && adev->gmc.xgmi.connected_to_cpu) {
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_TOP, 0);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_FB_LOCATION_BASE, 0x00FFFFFF);
>  			WREG32_SOC15(GC, GET_INST(GC, i), regMC_VM_AGP_TOP, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 59385da80185..3003aa5a53e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -413,6 +413,11 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[] = {
>  	(0x001d43e0 + 0x00001800),
>  };
>  
> +static inline bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
> +{
> +	return adev->gmc.xgmi.connected_to_cpu || amdgpu_virt_xgmi_migrate_enabled(adev);
> +}
> +

What I meant is - since this is generic logic you could keep it as
amdgpu_gmc_* function and maintain as inline in amdgpu_gmc.h

Thanks,
Lijo

>  static inline bool gmc_v9_0_is_multi_chiplet(struct amdgpu_device *adev)
>  {
>  	return !!adev->aid_mask;
> @@ -1726,7 +1731,7 @@ static void gmc_v9_0_vram_gtt_location(struct amdgpu_device *adev,
>  
>  	/* add the xgmi offset of the physical node */
>  	base += adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>  		amdgpu_gmc_sysvm_location(adev, mc);
>  	} else {
>  		amdgpu_gmc_vram_location(adev, mc, base);
> @@ -1841,7 +1846,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		return 0;
>  	}
>  
> -	if (adev->gmc.xgmi.connected_to_cpu) {
> +	if (amdgpu_gmc_is_pdb0_enabled(adev)) {
>  		adev->gmc.vmid0_page_table_depth = 1;
>  		adev->gmc.vmid0_page_table_block_size = 12;
>  	} else {
> @@ -1867,7 +1872,7 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
>  		if (r)
>  			return r;
>  
> -		if (adev->gmc.xgmi.connected_to_cpu)
> +		if (amdgpu_gmc_is_pdb0_enabled(adev))
>  			r = amdgpu_gmc_pdb0_alloc(adev);
>  	}
>  
> @@ -2372,7 +2377,7 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	if (adev->gmc.xgmi.connected_to_cpu)
> +	if (amdgpu_gmc_is_pdb0_enabled(adev))
>  		amdgpu_gmc_init_pdb0(adev);
>  
>  	if (adev->gart.bo == NULL) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 84cde1239ee4..2e3d0db9bc24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -78,6 +78,8 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>  	uint64_t pt_base;
>  	u32 inst_mask;
>  	int i;
> +	uint64_t gart_start = amdgpu_virt_xgmi_migrate_enabled(adev) ?
> +			adev->gmc.vram_start : adev->gmc.fb_start;
>  
>  	if (adev->gmc.pdb0_bo)
>  		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
> @@ -94,10 +96,10 @@ static void mmhub_v1_8_init_gart_aperture_regs(struct amdgpu_device *adev)
>  		if (adev->gmc.pdb0_bo) {
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> -				     (u32)(adev->gmc.fb_start >> 12));
> +				     (u32)(gart_start >> 12));
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> -				     (u32)(adev->gmc.fb_start >> 44));
> +				     (u32)(gart_start >> 44));
>  
>  			WREG32_SOC15(MMHUB, i,
>  				     regVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,

