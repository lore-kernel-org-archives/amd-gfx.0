Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F70C02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 15:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A3210E893;
	Thu,  6 Feb 2025 15:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kjExtg5X";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E9C10E888
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 15:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYwGaYv0VjnOBpmHYP/vEDssNZ/cslVsB0DosHp9ZBRK2CiVUMdvoENn/MUajERKbwTrFZbOv7h3jEAb8f4W1jfVF8XOsUB0mZ/C7iOiaRUAARKv4JlCGDW7KiBWS9WT96ZX3E/BUWJ3j04FOogEf97p6x06nDbsFD5irDwif8UHO96YT+itnHdCv8S0q55+RZE2j+Zy5mwBPpmwAB/8GUHwF1082AxvQEmtOjLrcMxZC3SDn/h/o9xaO7qotZ4jqhsdmXFwCmCW8ciy8NgivDMnqoCLZa584qUbOeBi8eqJKtHAGSnPfMLNqIYKdLXAAuK50BA1QelYqwrb0pVFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah/p/qJrc0GY8fdVlTV6ga+FtFZFltrB9niFKJW6hK8=;
 b=BGYTGthGytneJlEnYsXyd0z4z9PrSP2tLWSTR7Wmx6Iz/hIZS6fZ9eckop/zfPR1akricqK3gRKp2nzaL78t/d38iyfkis50NYtdz4a6ON7hz56vTh0X4U5DAtzx3nshKWrPafBzSVGxH3/sexg/NoQZetFocmdRB/IIOYmPDOOsFIhB2RloWePrmTwB0abRrmC7t42dLCfQDe3l9Z/of/XcVxUwIb+kMoSXiDDn/2dGHLzttmbttvw2azWoWuXszhUBIrvoKjWfByUuTeWZafQcqTb8rVM+guWd+AduuiZWSOp6ZMfPBIVvXtvf+/zTwCFtCW07TPixDPfLxv2CPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah/p/qJrc0GY8fdVlTV6ga+FtFZFltrB9niFKJW6hK8=;
 b=kjExtg5XwSTu0HpIFdt4lwuH+kiU4+yuQ4nffG0QGuwTG5pWjJWDE/0n0eoAw07FjYFXOzWDAzVhSAZzASF7R3JNCXwqPA4xUKlAEE7b5PkSKmb1JdOwX9RBoPfTusYB/htSrot0mxCfc1R6400vpjrn3z4AMz2Zoil+NTGEC14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 15:14:52 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 15:14:52 +0000
Message-ID: <b137eb65-248a-4def-8445-4ef29cbd9cd0@amd.com>
Date: Thu, 6 Feb 2025 20:44:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix missing L2 cache info in topology
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250129152029.32275-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250129152029.32275-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0033.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 039b6044-9ba2-4939-1889-08dd46c1014a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTZFajdqcks3R2IxRlhLY3NLQS9Fd0t2WE9SejBKNXQ5L1REQUIxaUJKemxM?=
 =?utf-8?B?ZDRIMWdVQ2YxZ09SSUVlNWphLzgwdEJuOVU4RmhDZng0SStPbm9MbUdLSmtH?=
 =?utf-8?B?UndsYThNdHJXUFNvTTZ0WEMxUFZNOTZINVlpK2l4Q0ZKbmNuTGNQTUMrMXd1?=
 =?utf-8?B?OTlOSlhLNnlFZUVnaEVsanowbTYyTXRobEJNQzBzSGpjQ1pDR3ltTENnQ0Rm?=
 =?utf-8?B?aVBlS3hRRjh0UTUvYWwzVVhDV3ZkV2RaYlB2YnQzRnlnZ01JY2l6VTE0SlNx?=
 =?utf-8?B?K2JNUlRwYXM3UTBuRTFyalMvUzhWeDZycmpBNFNmV1c3WmJQcFhtaEV6MzFk?=
 =?utf-8?B?SWJDdmJRMTBKdnRvczY0aENHZWo1UHJFVExZYTdaNkZ5cXhPdkZTNm9RdTYy?=
 =?utf-8?B?bnpyWEZ2UmkvRjlSYlVqTnJXVHl2WGNpRnlPK25UYVhKSmJmdmpDR2E2SVNL?=
 =?utf-8?B?Vllia1pQLzNrTDBsSG05OEJGQjlQdWFlNzN0Q3pXME44bk9CSzFqeDN0M01q?=
 =?utf-8?B?KzNCZVRxTUd6WjlqNS9qVUpUVGpIanBjTndubExBbklQbldiaGhBYVdoWlIy?=
 =?utf-8?B?cUZpMU0zRHVKVTBxdCsybU5ML1NaTlN2d1JsQnFPWHNHS215MGVDdnozaGE0?=
 =?utf-8?B?M1cxYS9MWGdIVmlhV0FqR1NtNzZuQnNzYzlFSGtkV25PNTNuaGJKbkc4MnZm?=
 =?utf-8?B?L09kb2R4NWhXRU5HVVd2NWh0VXJWMkdNbjJ6VXJuT0s2YzlNUzlUUmc4akFu?=
 =?utf-8?B?WGpsMVNVdXB3RGtLWThoWUFZVnRBa0VaWVpUYVhiaC8zVERxRWJkQ2l0OWJo?=
 =?utf-8?B?Tkd2dEc5cnQzb2tpL2lXSVIwT2ljYlZySDhwK1N1TTVqMDlaeVN5dUJocHda?=
 =?utf-8?B?WEswVk1CZExHa0xhWDNVaDVBNS9rcnpKRVZ6Z1VHdEhZSXg4YUVxZU00RUlX?=
 =?utf-8?B?UE1IdWs2Qjg2eU42TlpJaTRUa0tlZ3YxUUdOMlY0OXZOZXZXYTRFWmMyZ2VX?=
 =?utf-8?B?bUs5RHBueU1idVVNQnV4NTR4eGExandOV0hRSzFCblg5SFNYTlQwdW8rczk3?=
 =?utf-8?B?eW1Gd091WHhoRVZiRldRMXBRQTM0aHZJOU83YTdiTEQyS1VJcTBKbG42WXRr?=
 =?utf-8?B?V0Q2cFZmMCs5THRZZVRQOGpKcU9FSUJibXRVN1lldnhQdmMzYUVWQWQvTm8w?=
 =?utf-8?B?aHdXQlZQRlhsMHNSMnphYzJIay9LOFo1V2pBaDYxa3NocjhJYktPVGE5dmxz?=
 =?utf-8?B?cjllYWVBak5MNlZGRDViNENZU1YvMnNaUlpVSWZpaEJuOGVWdmNXaHpoY2Vn?=
 =?utf-8?B?Z0hMdkpDWlpaVWdheXR1QlAyWXlzNGxEU0lLWFlEZ0FQR2daa2ZEOGtQV3FD?=
 =?utf-8?B?dVRQSjRhR2VzMWtqZXlFZHhTemR5d0JzY2VMMUJNTlZGRHpGV1NUNHhUNm56?=
 =?utf-8?B?d2w4ME1XcjZTZzliZ2YwL2ZNdUpyNGl1Q056NHNlTzlWbDlzc2J0V0I0aEw3?=
 =?utf-8?B?alVtL2Y5emFSZklabTZ2YUpkSVRCOWNuSjl2WU40MXBMZmxua3M2b01aMmdD?=
 =?utf-8?B?RHN1M3gzbmVGcFM3a3dFR0VEVVgyTlZGQ0RYWThLU2orSnNkR2NyaUM3Wit6?=
 =?utf-8?B?M2pDZ0wzelJabTFjRTRiVXRVU2JLMUVoVFpPNVcvWUcxaCtWUGJNRU5rdktV?=
 =?utf-8?B?RTVBSExVUGtWRThldUZXN3FaUlJYZmV4dlJUam5ycFBnbGluTEJNNWd1Z2lu?=
 =?utf-8?B?QzBLVERuME1uRWYwcW9saEp5bExWdzNQeEFMTzU3SkxyVDBvSEUxRFVTVDNQ?=
 =?utf-8?B?dkxIRWhXaHFrM0ZnZmw2bithV2svc0pzdlpmSVRVRHVsbTlZTFBJZG5wb1pu?=
 =?utf-8?Q?8beCdwnLCL/eB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1F1TUlvTWExeklWVnhNMzI1QUJHM2s2VnA3ZzFpbHJta1J6VzJYUmhZblNo?=
 =?utf-8?B?YXptTkJpa0lLcEhQRklYQ05ZbjFnOGFMOFJGcFNDeU9uanJnS1Z6ZzQxRC9G?=
 =?utf-8?B?Q1NxbDh6MEV5VkVCcmsvNURxYStRWDhLcUtqanlkSC83eUlVRlE2MjhZdFpQ?=
 =?utf-8?B?VktLNzJCTXRFVndkMTRwcXBScEcxdVdiVmxwM0hrRlBHbXpjbFdWaXVKM0Vt?=
 =?utf-8?B?c1A3M21VSkwrVXZsKzZ4eEw1QWtFdVhHbHBRc0lOb0xQSW53YXNhY3ErUHZG?=
 =?utf-8?B?dGtxNUNUaVN2YmZrTkRHeGhBMzVrSTNsa25oM0FweGZWcHIyUjZBa21ML1dw?=
 =?utf-8?B?djFNZmMwTUo0dE5hZ3JqYmJQZ0wvZURwRFdjSXFldk95MUFsTEY5Ky9jcnpJ?=
 =?utf-8?B?eVN5VHZhbnB5SDVTN0FrME00eE05bkc2clB1WGlES1pQMVhDb0JxQXUwZHNk?=
 =?utf-8?B?Y01pVlMyOFd2eE55cG5ma0ltbnBid3QvWnhaak02Q1ZqQXBUNEhXMENXcWM4?=
 =?utf-8?B?VkFBL2RMZkVRME1PeDg0UTYyVGdUenhjTGdrdlVpNHROQUlrZHlrNDF0RzN2?=
 =?utf-8?B?UFJxQ2dzR2pPTWJ4bGx4UFM3OFJGQ055NC8vU3loUzNLbTkraWMzaFgweXo4?=
 =?utf-8?B?V0lYaCtxR0lZbzdmQVhQZzlWN2EvcTA1cllWd3NSYjYrYU1QdVlQZkJKdTBl?=
 =?utf-8?B?TFRqckhQejBLcS9qd0syTlZtbk9OUXROVHdESlVaaks4ckxpNHJZTDcxTTZD?=
 =?utf-8?B?NWJZc0VMMTVPQWFBbXRLRXJWVE53K0N5RUtDQjVrQ0NHSDBueFNCSVpiUkVG?=
 =?utf-8?B?Q0RhdGVibVYrR1k5ajd0aGRLZXV0SUo5YS9RZHI1K2h2WXJnWlBQeXpqay9T?=
 =?utf-8?B?QkpLR1czbnJ0MlBuWC8rcHEvckJHYTF3NUJnakptbitwM0R3ZDZvb0txbFNQ?=
 =?utf-8?B?dkdNOE43OUpaM0ovMkNXNHdYYzQ3aHAzR0JjZ2RObGtubUYyajU5UGRXeGZn?=
 =?utf-8?B?aG1MWDJCMFpvSThta3lQZW9tWjJsQlB4elc4UTQxRUxOc1MzTGNrcUNIWXBU?=
 =?utf-8?B?bGpWY2dURHA4d0oxVUwzY0hwTElXeGNKbldwOUpzQ3o4ZzdHdDZLbytja0hn?=
 =?utf-8?B?aGhzM1djV0UyeS9McU91OXA1WEw3TS9IalhiS0VOckFyTWpLL2pXTmdYMHdi?=
 =?utf-8?B?S0FrS1VjOVRmWjJFbU5CSXVzb0prYUxRcEtRL1VvMS9DeWQ5M0hsTlRsOHNz?=
 =?utf-8?B?WS9kQ2s4QlY0cjd6eUJJNVB1OUx3bEJ2NGl5OWJNYWRSYTQ1Tlc5MGU4L1pE?=
 =?utf-8?B?TEJUVDJzd1hNMk9kYlhXVVBWRnVqd2IwVDAwUitoS2U2UFJtS0tiZUhyR2NI?=
 =?utf-8?B?ODk4dVhTcnNuY0hRM0VsTUFuSStxdGlSQ01NZHIzTEdYNjBXKys2MnZBQ3Y2?=
 =?utf-8?B?N1VRZjRYNGdod01FQjdvRk9aQmthZ2h3VStmRmsrZHdxbTdWTzB2SFpRU21q?=
 =?utf-8?B?TDdxN2pGaWpXMVFFWkhQN29LNWRKcklCenV2QWc3TUZ6MytEQWU1QTJiNlJB?=
 =?utf-8?B?Vmc4KzUrS0JjMXkzZDAvbUYvV2dZOHhpSTRRbFIxVEhjcFpsVFRlWkpXV01L?=
 =?utf-8?B?ZXQ0YWs0THRUU3ZPSGg5eG1mVXNrTjFaWTROTUlXWjR5ZzZxREMwczdwQnlB?=
 =?utf-8?B?T0YrbDJHUGpJa01DQllOYS95ZHIxdVVob0tiR1B2V0l2RnZXZG02cnhGajNh?=
 =?utf-8?B?SnJYVVoydlZVZVZ3MHFCc2hOQjlQZElZa1Zhc0lrNXBNUWVIMitlQi9aMTh1?=
 =?utf-8?B?Mm9FSHhZRWx1Z05iUmJvTkNZNHNia3VWY2FkenZnZU4wSnR1RytVQnNTZWJE?=
 =?utf-8?B?azNrQ3RoazBOUHJOZkEvZmRLM3phbndiTTA3bVl2aGVxQTE4SDdKd0NXWWMr?=
 =?utf-8?B?VjR6VXhHUVVQcm9BTWgvQlcrd0RPVW1QY21aMlBzODZmNTRRNGs0Kzl2Mm1Z?=
 =?utf-8?B?bDFualo1bDBwVUE5NXl2RHZ5QkoxY3Q0U05QK0prRGVPVDNYb0h6eVFQTS9w?=
 =?utf-8?B?bDRRS0ZTR25NR2lVbzV3WkhBd3lnNFFIUU5VS0FZQUlBakRnTHg3Y0N2UkZJ?=
 =?utf-8?Q?IG7cV7F7M8iwJcqfCU6hPk1L+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039b6044-9ba2-4939-1889-08dd46c1014a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 15:14:52.5183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNRBO5uFdcYafoPlCWySn6sqk+koVfiKF96WDBWcXVEib3SUdmNWBaDR+cmlT85p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028
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



On 1/29/2025 8:50 PM, Eric Huang wrote:
> In some ASICs L2 cache info may miss in kfd topology,
> because the first bitmap may be empty, that means
> the first cu may be inactive, so to find the first
> active cu will solve the issue.
> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4936697e6fc2..73d95041a388 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1665,17 +1665,31 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
>  				int cache_type, unsigned int cu_processor_id,
>  				struct kfd_node *knode)
>  {
> -	unsigned int cu_sibling_map_mask;
> +	unsigned int cu_sibling_map_mask = 0;
>  	int first_active_cu;
>  	int i, j, k, xcc, start, end;
>  	int num_xcc = NUM_XCC(knode->xcc_mask);
>  	struct kfd_cache_properties *pcache = NULL;
>  	enum amdgpu_memory_partition mode;
>  	struct amdgpu_device *adev = knode->adev;
> +	bool found = false;
>  
>  	start = ffs(knode->xcc_mask) - 1;
>  	end = start + num_xcc;
> -	cu_sibling_map_mask = cu_info->bitmap[start][0][0];
> +
> +	/* To find the bitmap in the first active cu */
> +	for (xcc = start; xcc < end && !found; xcc++) {

It seems there is an assumption made here that a CU in one XCC could
share this cache with CU in another XCC. This is not true for GFX 9.4.3
SOCs. In those, a CU in XCC0 doesn't share L2 with CU in XCC1.

Thanks,
Lijo

> +		for (i = 0; i < gfx_info->max_shader_engines && !found; i++) {
> +			for (j = 0; j < gfx_info->max_sh_per_se && !found; j++) {
> +				if (cu_info->bitmap[xcc][i % 4][j % 4]) {
> +					cu_sibling_map_mask =
> +						cu_info->bitmap[xcc][i % 4][j % 4];
> +					found = true;
> +				}
> +			}
> +		}
> +	}
> +
>  	cu_sibling_map_mask &=
>  		((1 << pcache_info[cache_type].num_cu_shared) - 1);
>  	first_active_cu = ffs(cu_sibling_map_mask);

