Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C92C3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 09:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DB1710E5E2;
	Tue,  6 May 2025 09:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q3kNKkDx";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563D710E5E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 09:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cswYtCd6WkpTO0vEprNHRUg6oiIIeu1RcwUJfLhVGf1gyJ+ugx5dLQZhGuuKK0g7l9oyZN5dHRKSSyZGamIxoFjpuUpNJfbB4uyfQ139hlibuOyCk+0QZZRqnhJmGx8ol5jERPCp7+gjTnwxpPlAcCSj1Q5Y/GQJ7iHxdILT1cGru1wtLT9bpWzL6/iJaacxkFkPIqB1EfiQHRyqrZnL4Gbnqam7B4RIjClpw7fqTa/1x6BiFOzwvwu1oh7zXMA5wGjAK5U68Oh1l9Q+PeAN8rnYWraR8t76IkmOZ07IwowH8aDQXLN5FJ9guRXGCDr7K2xGtH5w9K9KO3glQ9SSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xEwU5IO0Aurcz1zaSCDk2x840Xu7YLx4zfFWeyknrs=;
 b=cRhqBi1lSl7XgGIH4zn5GjG9bhmPweV4mc6A0hQHmkmKm4d6I0EmyK6eh9oDSa6ZgjK70UseqN+VvBJPSmygSPVDM94Tra3FgJUhEdOa5hS6OIcz48dkP/x86IUQ4gHQUhFgvrfXqb/WW1EhiSWrLjcpVDZqR/xIgcr7YvdZ/uar+KQrpi4KAmYYaTP7UDEnNn+4wDbrxOgi/FRSTHQKzGrSCp5euiQRuGV6XhtX3eaoGKPtF5+66Yo2z3WH6ILm1LUfQ/6L9MwC4PYbo0WF1n4c0dv1jt9rgegJmrkz0Rd4GGiANnVQ24aoYreOqwJGspWSY1Llod5CZoZZdiJFtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xEwU5IO0Aurcz1zaSCDk2x840Xu7YLx4zfFWeyknrs=;
 b=q3kNKkDxp3a6OQzBPBAfbZifxHJw5EJakRlPGApR8NWkJkHBaPJIm0YqkF/5ZkerQaRXv0JxF8CZ/0jip0ZvBuhnzXc7ooPOuvxnPf6/aSxWfp4XuRRnuKWlqW1N/JxSJCU0ka3wMx8MDoE6d4QV2umwf7wsyy8YS2ahjhTl2so=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5604.namprd12.prod.outlook.com (2603:10b6:303:18d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 6 May
 2025 09:05:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Tue, 6 May 2025
 09:05:29 +0000
Message-ID: <0066efc9-56b9-4096-8b17-37cb374a08c0@amd.com>
Date: Tue, 6 May 2025 11:05:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/amdgpu: add UAPI for user queue query status
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
 <20250430154809.2665473-6-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250430154809.2665473-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: acb7f647-7748-4104-9b0c-08dd8c7d2618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1JmTXN6alBBbkRhQVdQaVJOems5c0UvVzhkcHNtZk1FTE8wdnRaandQT3F0?=
 =?utf-8?B?VmtLZFRQK1ZHbk10dWJ0VmEvbmgyaGNRQzR6K2VvNnBqZWUrYi9LTGE5cFJs?=
 =?utf-8?B?cVZMb1p6ZVpJMnpMNksrZ1c3a3ErOVp5TmNucmVIM3R5UkFxaEdua1JBeDJi?=
 =?utf-8?B?QVZHM21jdFVDSDVQUGJ6MEszY1lzdTJ6eGgxYjBVU1J6Qk5HQk9uTzBHUm81?=
 =?utf-8?B?L2hWSVVkQmh1Wk94L3ZNTUw3cXpIa0tEaHdKbTBIZ1hkdEszYy8yR0hkTmFF?=
 =?utf-8?B?L0ZmR09zckFEdnVpUnY2QUJZcFkyWGIxRTRZQTRGUXRJdFZhWklhV2lQTHFX?=
 =?utf-8?B?aDQ5cHorZlFSNkNzbE1sQ2YyZG9tTkxPTGtEM3Eyb080WUpWam1Ib2FrT0lD?=
 =?utf-8?B?emQzS2tmZm8zWUkyS3ZTVlJTWXd6cnJES1FCWDR3cVBMcHhyVVpUZ1RlcVlS?=
 =?utf-8?B?bWpYS1lUN1FoOW1VQldzajlDZ1hLRzhjd3phMnVXei9wMW41T1dUZHI4RFZR?=
 =?utf-8?B?RHRXWlJaR0ZNTUpzRitnSTRVdlRYNy9oUjdCRmgrM3A3TzdwMjdYQ2xzekcv?=
 =?utf-8?B?VWFzWkZlYUJqcHJTSE9yaGFPS3cxdzhJbFg0TWZXS3RHbm1lTWg1dFdGYWEr?=
 =?utf-8?B?U1VpbkpDVU55ZzJVOVZERVpMQ21qMWVXWThOYkx5Q0w3N3Fvc3loNTBzSWoy?=
 =?utf-8?B?SWtTU0ZIeFhndEVBMjd0K0RFY3g0KzJyWE5seEd4SVFZck5mMUpoK0pyZ2lE?=
 =?utf-8?B?b0ZyMUFZRXA5V1dLTGpVWFRmSThIQjRxNUdOK0N4bTZqUjhSNnA4aXYzQlND?=
 =?utf-8?B?L09pRWljWnJtUTNsbG9ReWg5c3VyVXZKWnRsVVZYTUFzd2F2WVR4aDlENHBJ?=
 =?utf-8?B?N080SzNLMUZFU2lGY1NKWnp2dWp1dUxPWHBkZlZSYXlVc2M5Q3BnR3YwTDRr?=
 =?utf-8?B?SU5HYmJOankyTHlna3lZMHAvWDlqUlpIdDN1c2hhSE1kdFNVajMxYVZPT0hQ?=
 =?utf-8?B?ejVmS2NSY3RTUGhrYkRCVWpXQWJ5cFB3ZkJBSEhTb0RGdUxxZEhJdzFOdGxK?=
 =?utf-8?B?K3phVDRYelhpV2RkYnlKb2NlOUpZUURlR2hsVHBjQnIvdStsaUMxYWVzMURE?=
 =?utf-8?B?RHNlRFpmQktTWnhYK1FraWNOUVJJalFVbmNZYmV0RE1hRGtGTU4zYnBVWG9p?=
 =?utf-8?B?L0YrSmhSR3JZbnpYOEVZU1B5WUFSZFRHejZwanh2bnhDSFp3WVExSjlNQ3Iw?=
 =?utf-8?B?NjJqNEdENlJPeE5za2c2YVJJZFVJdllPOHdtN3o4UzVVR1haMVl2bWROWUdq?=
 =?utf-8?B?Y0ppb1NFak1iMmZ2WVA1bXBhcFN4a1FNTjk3V2ZwdGhFeEs5L3BPUGhGcG5X?=
 =?utf-8?B?ZVMrNkVqNjloUEtwOXVzTVFCQlRrQmxwNTNZS1dmKzlhT2N1bGR1YUZreXFw?=
 =?utf-8?B?Q2pvYVJ6OFMydURLUnNuWHU3TUdKcStnZmRLT3hjMjJFZ0tEMS81YzlQUFd0?=
 =?utf-8?B?eUgzL2VmQ2NpM3lIZG1kNWhYZGJOZS9odnEyNFZiWVBla2VnNHQ1SUVUK3ov?=
 =?utf-8?B?QWduSWw0U2NvT2tPRDcvb0g4MmtTQmtMT1NKMzhWZnk3SlZSZXZjWmVkRk5B?=
 =?utf-8?B?WG1xRUQxbnJzVStIY3NjN0UzNHhVMEdkMU51QVZuMFozUWtydFAwK0RaRW9k?=
 =?utf-8?B?a3pBWVhFeWpLUXpWVkhBUGdZdlE0TFlDcFJnRGF1Qk40by81blNPd1Y1eFhW?=
 =?utf-8?B?RWpHUzdJOUxYRFlzNzdLalpqVndXaFJXSmhnWEVHOFZUTXpCeXRkZDRkNm9o?=
 =?utf-8?B?ZHRYWGk4am5HR2RrSVk4WW90M2NsMWNuZXpPWitVZ1RiRE42aGJua2VPdlR0?=
 =?utf-8?B?RVYyb2RrMEM4WEl1UC8xSlJ6Wm1JOWErZVdTYjhiY3p6S2xPWExsWDU3TTJO?=
 =?utf-8?Q?45aMnQsRp+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pvY28yZ29MNTUwVjhMclg5U1ovZGtNemlZVGpMU2Q1RzBRVDdCdFlkeU1v?=
 =?utf-8?B?b2JDek5wS3U5TE1BamxXVVBRd2JUc0ZLMEc2dTFOR09DTm84WHlqdzVlc1hW?=
 =?utf-8?B?WSs3a3ZRMU90YlQyWmhMRk0vdDlLNThtdWl6WXp0cFpYZklpNnBscDVCOSti?=
 =?utf-8?B?RzhxTnhHN1hhMk5ucFFGb09YSE01NGRubVdLS2Joa0ZlbXAzU0FiMm8zNldW?=
 =?utf-8?B?K2VXenFFbUpFcUVsVTZrQnZmWDhqNm5lMTJ2RFRMdTIzcmVIaGdiNEo4aHQ4?=
 =?utf-8?B?ZmlDSWhhbUc2T1BJNXhVVkJaZ1ZlVXVIcmZqSXRpRzY0Tm5xRU1JdWl4aGho?=
 =?utf-8?B?bW5LNGl0d2tsUEVXRThMd0lWblYxK3c1UEtMTFFJZ0p3RGhZeDVYa0JlM3pt?=
 =?utf-8?B?RUtiMUdMZ1dLQzVqTWJ0Tm52ZUMyNEtCaEtwTHBlZVU1eWhvL0JzaWFQekpS?=
 =?utf-8?B?RlJMTzRzY1dERENHelhHdUtZLzRjWXN1am9xc1dib3p2Mmp2M3N2TVpjZmVP?=
 =?utf-8?B?bnlRd1loZG1MQmxGNit5c2hlQlJlSHRNVGpmTnNLNVZHeHRQRnMzWG0yVCtY?=
 =?utf-8?B?eG9QaHM3MVdxVU1VTk5hRnJhSHpiK3RUNlc4NE9uUE0xMmYrdWRSVlkxcFpP?=
 =?utf-8?B?bDZ4NWlOTXRldDVqRjU2VXdhTksya2g1bXNMd2JHU2lnd1hQUEZRcVNWRkJh?=
 =?utf-8?B?OVc4bGpjOHRVN1hMZmZSMk0ySHozcU53U0phaWhrMnRuSXQ2dUs4MXlRdXUw?=
 =?utf-8?B?Ulc1YkR0M3gwUGFwWUJxdWRhN3JsYlR4MlhKaEpmQUFoMHlwa1FPZXR0amQ1?=
 =?utf-8?B?WmFqUmEzSVI4T1BkSDU0WW9rRXF4QnFscVdTd0NXc3hQYmllQ2dlaUoxVWd4?=
 =?utf-8?B?UnpJeXV6NEh2UVdZTWNWQmpmbGRSY0NKbGRBdEJYK3NmRzNsUlFVNnpXME5n?=
 =?utf-8?B?NjFjSjRBaWZFa3JkTURoSjVuWWtJLzAvNldGNFd5RUlpWndvMzhwZExOTjVK?=
 =?utf-8?B?Zkw4Zko1SWZpZ1NNMjRHdjVRNW0vWTFYcElvc0N0c3JwN1ptdHNWYitIcXJ3?=
 =?utf-8?B?UVRPNzRubEFqUzE5SWhqdmNBMGwvbDhrVVp5SjhIYUhNaWkvV2dTUGlwMm9Q?=
 =?utf-8?B?VzVKN3pJYWEwaUtUVnVTZU1sbElDNmhsbGp0MjZxUmhISHlpSEY0RGNpTnFR?=
 =?utf-8?B?Q0JYYVhNZXFHYzJxUHVNNFUxVnVqMjk3dHJzQ3QvVXVKV0JZOTN6bTI4VEh6?=
 =?utf-8?B?RGVHMUNhcVJnRWR4M1plR2tDOEJqb0RxSFZ4ZTJrUnBRQ2xjV1hCNnRuVE01?=
 =?utf-8?B?UTNUTDFPY3d5eXBRUm9rWWZaZWpUSi9CYkNTSk1IaW11ZUpuWUlTSGZHMTFy?=
 =?utf-8?B?eFlXVDBNL2FLUHE0Z0dVOFQyVDhVUUNrRmFtekFsbFA5WjRzbjJsVEpJYkJx?=
 =?utf-8?B?KzVWMm50alA0MjVqY1M4QWFvT1dBaVVWWm9oWVBmV1IvUzhkRGtnazliMHhO?=
 =?utf-8?B?bTgvMFM3Um9WQlRaTjZPdzdrZ1V1UkprMFNrNGtnd1MvRGkyZWF0RzhhQUY1?=
 =?utf-8?B?VkJRYzJnRC9FNzhEcytDNVZLakFWMUpHV1ZrRWRUNzNKMCszcS9wRHQ5Qm1y?=
 =?utf-8?B?SzlYWS93UC9XUjYwYnB3WXlDRVIzN2gzSUt4NmZpb2RaM1RvTnB4REdiU0p0?=
 =?utf-8?B?RGJRclZjNU1wd3hlanhVUHpuUCtYVEh4djRnelkxelV1QTVHR2xVcjFBdGVD?=
 =?utf-8?B?N2xyV1JWMEN3NzQ1SGJFbWMzQzVqTWlVSXZjcXNRL0N1NlUrNzFyM0krWkNZ?=
 =?utf-8?B?aC96VWs0M1hDOGNnL2lxMWNjc3k1RjJJZDBKR3NoeisyL0NyYWpUWTdMZ3Rz?=
 =?utf-8?B?NU1UaktLRURWWmtlK3BYLzMvNlpGRHdCM015U1RscTQ5VGxkQjdFeVpDNUJs?=
 =?utf-8?B?VWdKbncyNXlkWnJvaDVPNG92QXdaWkZMQndxQVZPS0xFV1JjakhxSTRVVFgy?=
 =?utf-8?B?OFNla05QZEVsZnlzcnVuOWhjbEEvajlHc0ZQVDZlYXlKdUEyWW5yRHR4RjVp?=
 =?utf-8?B?c3BTSkR2ZUlhNG10TGZkTTVLZndZU3VtelBmUFVjaUhFTkNZazNSUkNnOVNP?=
 =?utf-8?Q?hizBq7b7fYFpAdb8dMq71gBxg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb7f647-7748-4104-9b0c-08dd8c7d2618
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:29.7203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CE2n34bG0bp/MPVEyjUaLHC2v+uHwQ1iPOOreX9KI1vnN4FjuHh+f7eozCv1XHj9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5604
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

On 4/30/25 17:48, Alex Deucher wrote:
> Add an API to query queue status such as whether the
> queue is hung or whether vram is lost.
> 
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 1fd96474e64c0..56f052a10ff38 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -328,6 +328,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE	1
>  #define AMDGPU_USERQ_OP_FREE	2
> +#define AMDGPU_USERQ_OP_QUERY_STATUS	3
>  
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> @@ -340,6 +341,12 @@ union drm_amdgpu_ctx {
>  /* for queues that need access to protected content */
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
>  
> +
> +/* the queue is hung */
> +#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
> +/* indicate vram lost since queue was created */
> +#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
> +
>  /*
>   * This structure is a container to pass input configuration
>   * info for all supported userqueue related operations.
> @@ -421,9 +428,16 @@ struct drm_amdgpu_userq_out {
>  	__u32 _pad;
>  };
>  
> +/* The structure to carry output of userqueue ops */
> +struct drm_amdgpu_userq_out_query_state {
> +	__u32 flags;
> +	__u32 _pad;
> +};
> +
>  union drm_amdgpu_userq {
>  	struct drm_amdgpu_userq_in in;
>  	struct drm_amdgpu_userq_out out;
> +	struct drm_amdgpu_userq_out_query_state out_qs;
>  };
>  
>  /* GFX V11 IP specific MQD parameters */

