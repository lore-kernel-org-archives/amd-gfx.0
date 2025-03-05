Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718C1C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 19:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6F110E2AF;
	Wed,  5 Mar 2025 19:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c9vWv15e";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A620C10E2AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 19:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp0nIV3hUGKEL2H9s+GWDvpjrCdCKGHNPgCuJ+0s2hD1wjzNtOmlNqWDE0f7LtXSoRW7AoH2jMuGSHTyQT+AKthCC2w0P9yt8GgLP87RjQ1g4cfCy6jGpf2jd2gejBeF8l4vzgmitKjcg7Gr01L1a5eBhzzGcRa03ZuPkAwGgW4OHvGqu7MIQfEy0xOBE8MIfeL5qErqHxywdxRwgt8x473BSLga/1n5WsuaO+B9VX/a+fVthyfw+dwyZ6FJQ0VAz0ia4bgoQgFxk+4aTBOIKzPl3GlJKcxmLYIZNWhzRIVTxmeXZALHXwzDjqlTMpTYT1uevCcxSKIOh4spJChpCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlks3JUzOS4107WjSPBJy7+eFdozSzy9GHg/fghQ4SM=;
 b=jgVHFq/DmDHdz9sfXl4Xg1qBnDBUNAYEv4cRCYrdYbCRNJURoSkYE3yJhCeGEgf8lwa2YSSIMJl/wfK/UmchIzaAphQElVxh7WQMgZjd1oqBcDWfEXCA4EjcwDu7fwuRs9Q5Gy/FB1Vhw1/V/ddkOanZvDQ5YUc9MCOQWm5dHgChtmzq77bEUNFzpFL7aU1xeaWYvMMFgEjwKMsU4OIkGctKIadsvDHy3pNG+dtNOisOZCxr/bVD3Dn/uNcNq78INVX/GR653ECrPkWlUM9iYXp2Krn1diNjyZi2j1tK+lmZ+gn0fzLEw+d82ChFck9fx/ZvZ5gdTv1O+7nhK+EHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlks3JUzOS4107WjSPBJy7+eFdozSzy9GHg/fghQ4SM=;
 b=c9vWv15ey3r3iLuHAlUYN+ZbzoqpVGwaKcPki+g1qw7dtLzPcl/jLsIvm00tCuoDUGd6kX6Okultv8a6udGowr1c9Lbbf0HHGE5vpGC9H72elvnGFR1hRKqCjlxc4zripUl4TlGo/uhf0ffafa3nCyjSKZAFRWbGgBCuPCwsowU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Wed, 5 Mar
 2025 19:48:53 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651%5]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 19:48:53 +0000
Message-ID: <f7756b36-c114-c1c6-e876-056c6e869f92@amd.com>
Date: Wed, 5 Mar 2025 14:48:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: remove unused debug gws support status
 variable
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250227173100.3160647-1-jonathan.kim@amd.com>
From: Amber Lin <amber.lin@amd.com>
In-Reply-To: <20250227173100.3160647-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0285.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::21) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: e84846c1-fb6a-43e8-e04c-08dd5c1ec224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N215MGJaS3hoMitBRGYycjM3R05WUFJuRGE1OW1EN1dNcHFFSWVLc3Y1T0FJ?=
 =?utf-8?B?WXp0dUZjUkwwQ001dDhFUm9JcVNxaklDVjRpWTJ2S2d4dHZZYUk0NTRJN2x2?=
 =?utf-8?B?V3ZTeGdEdzMwYmRlNVpnYUtCYUIreVNydm9Oakw5SHdzeWI1QnVmUEVzSmNy?=
 =?utf-8?B?aWQvU251elF1THF0a2dyZUxhMmxweHFxcTJLVHpUUFVwcXF0dlJFMlhCT0Vu?=
 =?utf-8?B?cEVlM2swY0hGNHFqajJMVENua2Vpc3diaURhazBPbnE3OHZ2cks0UTQ2Zmxs?=
 =?utf-8?B?TUd4MWRNWCs0UFc3NFZzNGR3N1dGd3VrRHNHWXQwOEI5NGNQY1FuSzExWktX?=
 =?utf-8?B?VE8wRXVpdmR6VWtpNGF0aDVRdWZTY3N6QWk5MzBJZkhLYUJvY1VNd1pEMFNB?=
 =?utf-8?B?NUNWTUh2cXVaVFZhNHNwQ3Q4L09tOFNrTVMvcHRCc1RMVEpNSzRJTlQ1SEpl?=
 =?utf-8?B?YnpsN3Eydk40OE9WZU1kN1pwY0E5RWp0c2h1c1NXNTFobWZjRVRQV1VjMzBM?=
 =?utf-8?B?bk05R3VKWFZHTm5zeDk1N1ZMWDRxTHhWQjJrUkdYSEFxdXN0Q3NpV3RrMndz?=
 =?utf-8?B?TlZWSGtkdDdmUUlOZGRSdW5tcWp4NGk5dGtFbzR0Q3ltV3I5bW9MdnA2WkdN?=
 =?utf-8?B?VDhrbDcyS3oyZzA5bjlBRHBIWjhCNUR2ckErQlRxcWhQbTlaREoxdHZwWW9p?=
 =?utf-8?B?L0F5QWRQdFpxbVZBY1BaQTI5SFRpSjFqNWV1M1BZa0FNakpNc3hYNGJKYkZi?=
 =?utf-8?B?SzEzY2llSkFRL3U5ZEZhU3NNb0lWNzVHNE11S1dsSFFMbHdQVk1SK284NGtP?=
 =?utf-8?B?SS9iZ3ZSbERNZzBNNHJZb3JkdGtFWGNvVUJqWTlmbXJSR2M1cktvQU5IWFdQ?=
 =?utf-8?B?SVpzeFNOOVdqMnF6cnhWYTNkVDFRNEJhVXdrTEtHeHhhcExoNkVjYm5SVTUx?=
 =?utf-8?B?Wk1XY1VFL2krdFc0MS9OMFBoYUJ6L01DNHVWZVNUWHR2bDlmZlg2dUZvWUhC?=
 =?utf-8?B?S1lJamk1Qmk0NUVtSzAreTB3ODRWWVZaMDJqSlVUazdLdW8yVUR6YTdFYWtF?=
 =?utf-8?B?T2s3ak0ybjNDSFBEalJMNklNNTBMdFdHdE4xVU1FRmRlRDV6UXM0VzJTd2Ey?=
 =?utf-8?B?K3lXZkZYR1lTL0llMzEvMHYzcm1BYVZlU0FHUFptdWRvNVhxdU5lbUxvMGpH?=
 =?utf-8?B?aVZxaHB1V1pPUmU4ckZHbEQxdVJ4NzdML2FOWVF1amJSaG9rdFNZT3IxM1ln?=
 =?utf-8?B?eUJnUjBCRms3b2wzQ1JxMURFanA2dWtOQTRHMFMwUmNRZy9VcVVGdks2TGpQ?=
 =?utf-8?B?ODA5UVFaUjhCdjBUOGVWMHRDNzhOS3hkVXpUaGt4Q3poNTNtUUdQaDlrcVFZ?=
 =?utf-8?B?Q0NrMGhyUlJMUlZOMGEvUFJldHpkR090Q3JQSHY3aDJITTFPUnhtZThIMzQw?=
 =?utf-8?B?QkUzSDA1TWVIUmhpYnBhUzVqYnZESCswVEcyQ1ViVnBVd1FCVmFiZUJ6bVNH?=
 =?utf-8?B?REcrMWc2Q0U5V21MRGVzYlp4T0lvWkY2UmJiMmxaUWZ1VFRyVEl4NTl0Q3FQ?=
 =?utf-8?B?YjVXck1iWUlFWjIvSEdMT0Q2UFptMnpmdTY2UHZINFMzRVNISWs4RzJQQnhU?=
 =?utf-8?B?RTB2SWdPRU9VZUxQaWFxdlFpVmY4UG9sVUFldkd5NFpFUG5LNSttMi9yRkd1?=
 =?utf-8?B?QzVtM1VCMnBqU0Jidm9yQndEV2ZMMEVoYTlUN2kxQ3BYSEZjVDZvd3Z2aUhi?=
 =?utf-8?B?RE8xWVhpdkx2eksxa3JybG12NjBjdkF1TnNCTkloSUIwNmY1enRKSTdKQk9o?=
 =?utf-8?B?bGZOb2EvZmNLa1lOYTdpT3lmcG53QTRoN0VpTWl6d0V2Q1N2UmtHR2N3M2lu?=
 =?utf-8?Q?v2DF2fyT74tyO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3kzL2xKbHR2UVQ1MldmNHdwL2paaGhaREFpY1FaaDZXQyt2dnQvUVF4TE5x?=
 =?utf-8?B?Y0JJKythZVRHdFdYUnFNQVhjQi9Wc0crYndvTHNib3lZaTZNWllVazZaSFMr?=
 =?utf-8?B?N0NwbDV1WkpueElxcGdBM2VzK0VvenE1QnRWeHJyWDFqYWRJcUUwVW5hNEw0?=
 =?utf-8?B?QndJWjh4bTBpRGU3eWJjQmZXVFZyUkk0Y09xMGZ5Rk40UW56WTJYSS9hZDRJ?=
 =?utf-8?B?TnBENFAvRHVZcDVCdngzZGRnUlZmUWt4czFqQmh5WVZLSXNncVQrWkR1elJp?=
 =?utf-8?B?ZDZIdzhyL0FkcHBmQUN0KzZ6dE4ySlVkRWh4YUJwaG9EWndZTjE1Qi9QVU92?=
 =?utf-8?B?RGJqTEtQcDRMSmp3c0VjbDZPZnZSUS9NWDNoNzU1d0gvY1owV1M1NjkwMFFt?=
 =?utf-8?B?TmFXUDF4NnhaN1hFME5hMGZ0RUlIcHg3UjlVc3hCVXlEYlBsK1pKS3Nuc29C?=
 =?utf-8?B?TTllYUNOUXR1YXF1c0hSN1ErY1dsOERoYmViMFpmcGkyL1hOblZOSVc1azh3?=
 =?utf-8?B?dTQwWkgrQjE1YTJGK1MzQlZQaDdwNjJweTQ3R3RlcjY4MVlXRXNCM1BRNVRj?=
 =?utf-8?B?T2RVcVRVRDBHV3BPTXU4Uk5SQ3ZkSGI3bE5iMWlsRE9JTUtYcnEyYURnK2xD?=
 =?utf-8?B?NzF0RGpZSm1lWWlNMkRsUUxJUnNnR1RDdlkvTTJscnlzT21rN2MybGx0V2U3?=
 =?utf-8?B?Y0lQdFUwRThOV2NOdE91YVhuMUUwMjIxcm15THJjUFhkMWU2ekllUDRzL2FY?=
 =?utf-8?B?V1BodDRvcnE2S3pZUFV5SmptdC9UaUs2Q1FMWVFBdlpjWlVmSXpaUXhMVFFP?=
 =?utf-8?B?M2xFancwSFBLbnoyMWZydHVaRzVtOUlvb21UVU13TldKc1FaQnhFWmd1T2RN?=
 =?utf-8?B?Sm85VE1raFpnN203WVpvN0Joa1RENzBuNzRPTHJWQmo0ZDY5Wk9mbG9lT0cv?=
 =?utf-8?B?NGJhSmhjVnh2MjV4MmJlU3M1ZG9QNUlrTEVVMUhWbDhmajZlcGlFTEIvcGly?=
 =?utf-8?B?VDVRTlZYa1V3YkdHTFIvOWdnRGduY2pzc1Y3UEt4L0Y3bE03NUpzYW8yenBB?=
 =?utf-8?B?MTc4VzNkRGwyaHJlQ1ZkcXZ0MUtaQlVPcWx2blpCWW1HSVJ1cDE2SW5OYy80?=
 =?utf-8?B?Yyt5SkgveDlqdDJURWpReWZ2bzEwZGJmV24zR0Y1YWxXZFQvMkRzQ3YwakFP?=
 =?utf-8?B?MDJobEVrR2o5K21pdmN6K0NTMTRtNjg2UTY3S0xYbUE2bHJzSWpZRWhwcDcw?=
 =?utf-8?B?SS93SXNUUTRielFTUEJWTHpFRHlvV2U5ZGltalpXaVMzeGk0bmZ6NmpJRzRU?=
 =?utf-8?B?YXRieXN2aWU3dzU1U2REdUc0WE5ySjRCV0RWQWV3YVFDOVRKcXM4R2hZNjhB?=
 =?utf-8?B?U1hvMWVJQnVUUTZPZDBUVE1yaGhmLzFDeUpiN0x5U3h6NVZvQ21FdkF5R2Vt?=
 =?utf-8?B?RGRMRXJWcW9Cbi81a1JKZmlVTE1TdWtvaVQ0WjFzMjBFWFVtZ0NPbnF0SW0z?=
 =?utf-8?B?T2RSNmt3NGozazNmSFlXNnkzRGt1VXdGOGxDUXlJY3pqME53ZG1Pb05rT3lL?=
 =?utf-8?B?cU5UWjNoNmswS3RiUDZLNlBjK3VaYWFEK2MrT0I1dWVSNGtjc205eUpxWGlI?=
 =?utf-8?B?M0ZIbUpxanZZZVMydjFTdTNOd0RLTTVtTU9qQ09WUmFNd1FrbFBjYVFCSTNU?=
 =?utf-8?B?TGFDSWhrVTRtQXhwVEhIM2RMd3gvMVpUeGVWcU9CTEdWclJjTmNQM2lVYVF6?=
 =?utf-8?B?aVZ1RU5zY2VnS25xaG9ocXVLbVVFYzV0RUpaZHBWd2JueFN6ck9uL1BhaWpn?=
 =?utf-8?B?dE5KeDBBMjZacUo1V21KZVAvQ1BGcFg0ZGlwRUdnQ1B1d3lpWVdjVGsvaVJn?=
 =?utf-8?B?Q25MS0I4bTA4cURiN011MVNva2RMMXVndzBoaDJPU09GMjVBcTlzNE9YZUd6?=
 =?utf-8?B?K0NualFNeDNtMThkRmRSTWtrcDI4MGlSRkdHd3ptTGYyZWRQRTFueVRUL2Qy?=
 =?utf-8?B?aklVRkc2Qm1QSzlHM1RLYUtVQ1VWaGwrQkljTmFDdmFWMmkvYi85QVlqZEw4?=
 =?utf-8?B?R01YUnpxWmNqeEVvNkhBV0ZDTG9hVTYvT2JUaERuRGJseFJjc0xLTFROQ0xk?=
 =?utf-8?Q?F7wr6bApK+8TdZhhL3W5N4W8F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84846c1-fb6a-43e8-e04c-08dd5c1ec224
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:48:53.4501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtsNesqADB8O9A9mjVpgy/OBFa3kAFr3Xob0Nbn8oXjbCbi27PnYMNmntnFuYAac
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
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

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 2025-02-27 12:31, Jonathan Kim wrote:
> Remove unused declaration of gws_debug_workaround.
> 
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 59619f794b6b..43950f3e6672 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -289,7 +289,6 @@ struct kfd_node {
>   
>   	/* Global GWS resource shared between processes */
>   	void *gws;
> -	bool gws_debug_workaround;
>   
>   	/* Clients watching SMI events */
>   	struct list_head smi_clients;
