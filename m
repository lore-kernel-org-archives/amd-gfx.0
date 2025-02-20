Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD19C021B2
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 14:22:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F8110E980;
	Thu, 20 Feb 2025 14:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uXmKsAlY";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A35710E980
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 14:22:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTj7cyhexSLohD7y+IkjzSP8Gq9ww2ALTEey618c0WmIE7DJahwb2OEkJHiqG/HEmv8X6B9GhlJsrLADdwbgttJYxqDYhVpqUPSdINVGzZZNaNVa1GXvE60MMdaSW34D/fq5Ngw6jMFtghXiYn425rkRjqRdXRIE8vDwr1RUOPobjuLriwQROnsx7n0xn1rFOLxkDiVhJKGF/d9cxKTN8Hd3B6mBq3CM7ShpyMXrJ1/Ok/3iQyezPIZnl6zUZsYdV8QTOih+Gw1fg+NAZNSGCbYPQ+Gpges7HZqxbHwxB5pie6E7mkOL8aX0YyEVbBHWFyFqtR9ga2D4UyS/XBv5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm4joeIIf3ZkXxx6nDa5CnCVjbnxuUZHagWXZmWeTXQ=;
 b=Peo+SNGooCGkuad8zLP39kEXvsjsonx+b4Qsb0iQILo4DiKcTFMrCpcSncW6a+Cb2MYER3UgoFL4kxz4ogjY8C45hRxMcD4YnYKbqH6+612ieKcscfCa3UJHZT1BMLt4YTyL6iFHmW1ysup9JKRxne7K6yqSeMLMJGQXmyxt/1jDv6RZevOZO19iCPsdh5HHor5cogKBMJMW04jjtMIJ3U5YdJ5cllwjHIjHWhwHj4q8B40gyjetaps+RWuCo7zdizbunl6ZwssMuXAUlzGhGFELjNiQYuNSwr8XYxTILhK244eesEP2iyHe6A1n9652/BQmI83Upvf4NTLSi8BZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm4joeIIf3ZkXxx6nDa5CnCVjbnxuUZHagWXZmWeTXQ=;
 b=uXmKsAlY/NNV5DMLOzn2aJs6iciH/J4HOtBE9sMIZV4zNuDdfDtjs5b+WjGjBhWvIa0n4zMEc0Dj9+zD71k9kuhzLnseG5Cafwcoqw84pdwUfmJN898V1qW6vibewjNRU+S7axdUT85bCO2YvbsmKJZT9IFZ4fupRJ5dQrVCwk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 14:22:02 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:22:02 +0000
Message-ID: <afa08c12-0516-4e57-82d1-dc45d479c2bb@amd.com>
Date: Thu, 20 Feb 2025 09:22:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Correct the postion of reserve and unreserve
 memory
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250220115946.2051216-1-Emily.Deng@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250220115946.2051216-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::22) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 684fa990-ad4a-4b12-f7fa-08dd51b9f18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c09Wd1RnNmNmdTlpNFd5bHpjc3ppVklvRGhPN3BWcTBQT2E0dW5sYm85WFZu?=
 =?utf-8?B?dDBSMmVvZ0tyaTNNZVpUZldrbmFSWmtUWlVZbmdHWDNVSy9La2xFZ0xsd3p2?=
 =?utf-8?B?WDdCSTBIeURwc2VYUTNVMkpGN1N1Uk0xTjRESFNYWkZnWmo5U0tmL1VzTTBZ?=
 =?utf-8?B?ZWM2a3czTUprSVEwamZyNlh6dmoxNXdZQ1QzWmVWK2hGaTd4c2puSGV2dUt5?=
 =?utf-8?B?dVV0eUFyMEFkeXpRd2tnWW85OVdXdHNnS29iRmd3UWc5NndnNTFwY04wM0NP?=
 =?utf-8?B?Qmg5K2RTall2bEpUMXRTS3FwRUNHZHhFOFVJQUVhbDhhQ01sRkliMzBnM1dz?=
 =?utf-8?B?dWVzbVhmSnBJSTRKY1RvVHFnSG9ZaVhPeGhZcE9pZk9jdFhOMllmQTdmMTNX?=
 =?utf-8?B?b2NhbTBBOGtYTkZYcDBPN01LTExHR2FiMCtPVDRacldWWVhNay9zOEhGT0l0?=
 =?utf-8?B?R3dpeTJYemt1N0k1OXJaREpST0swZ2pUOTJkOEwwL2EvN1lYYTQ3Smk4Z1Mr?=
 =?utf-8?B?WHhZbFBoYTYyKy90Z3FlRHNCVTloNGp4VkRYalN0U1VPd284RFNndHVwd0Ru?=
 =?utf-8?B?QVhWaEgyNGJoa01paENIejRGQjhPVlhqbVowOGxzMTZ6ZjdiMURFSjNHaDFX?=
 =?utf-8?B?a1pEV0Q0VC9KZmlmcTRCTHJVSFRFZmJVQ3lhMEJwb1N1YXVjUzdvdFZjQ3lu?=
 =?utf-8?B?WTRGVy9zUGpkUS9DeFVPcklaMlhjbWxJbmkwK3pGdStLREdrVlhVaXliSWta?=
 =?utf-8?B?d3o5VnkwdVJOamN0cEFlUzN5Vm5hNTVhOGt3QXdacFQ2emtaWkI2VlVMVE1W?=
 =?utf-8?B?UGIwdUFDN0hvVEJaVERYVmNwV2sraHRsTkZmbDdZMzZQcUIyUDc1aGMyZkc5?=
 =?utf-8?B?T1FIZFJCN2FGb0dRM3RONUMyRVlHMVJQRmFxR0p0RXM5Yyt0bVg0TmNZUTRh?=
 =?utf-8?B?QnRoNXVjSTl5ZGt4MzQyTHRicDUrM09LY2JtbFUzcTBoeUdZVGE1Snk4SDcy?=
 =?utf-8?B?bjJsQlI3d05ObVlJelNoYXNlU1oyeXJQRm1BQzZXa2VPNm14aTZDUHVHSGhG?=
 =?utf-8?B?czNudkhJWmJaaTZWRkI2a29QdGJUd203cDFoS0hhUVRlTnNMOGo3NlJJd1I4?=
 =?utf-8?B?cU14ZjJBSDh5M0NFWmtUV0ZhTTdQa3U0K1JVSEp6TTBhd2tMOWxidFI4R3BW?=
 =?utf-8?B?VTZ6UVgrVnYxUlBFelBmUEFQbUU1Sy9UZWx2NDR5enI3SnVDeHZWdVQ5RnpJ?=
 =?utf-8?B?REJhR0RZZzZpVmxQQnNBMTdVNUJpYkVGZWFLSWxTRW9BbnBxZWt4Z0RTdmM3?=
 =?utf-8?B?djZJYzNHaWpCTEhnRHZXK05aZUZROEF6emNnazlxSjlXOGg1UWRxS1VsNXd1?=
 =?utf-8?B?a2FLajQxTktpa0gyUWtLcHBFQytRSWNvYmZ3OEtDTVUxaHZDaDhVZFA1N2Zu?=
 =?utf-8?B?a3c2SEN4QkJtVFJxejZuRzVHUjdRKzgzYi9ienE2Rm9XcG9waDIvNVlYcnhU?=
 =?utf-8?B?ZGVaRWJsZVB0RWZiazdVLzhBYTExakdxUEwxd2xtSE13WlRtdjhxaHdnMkdi?=
 =?utf-8?B?Z1ZqdHMwS3FuK1luRmZUTGkwMmpKNUNPSGhUaFA3Z2tWazdqdlZVR3VXZ1Bq?=
 =?utf-8?B?N0tRcko0M1lQalR3SkhpWmF5dkk3TmIwT2IwZU4wZUlzRE9NVEJoaFZReDhx?=
 =?utf-8?B?V0NvN1FnUUErdWMxNVZvMmhpRkQ0YjFYRTRFdWVUa3MyVHN3MWliQXEzQjNI?=
 =?utf-8?B?Z0JKN1Evc2FqRklnMzlKZzNRZGZMeGV4UXRwcTVZakJIUXB6UmRFSXo4MTVX?=
 =?utf-8?B?QnhKYWg2YWxlMmk3UDN6SFloeVNuV0FBYldFZlNJVzdPaDM2eFJvOGNRaFMr?=
 =?utf-8?Q?3kT5Tbt7YaSDK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnhpd2s5MXFwSjVvaU1nMnJMaUNhVVYrMkpUQXlRV3Q3cW1TNys5U1o1QmlQ?=
 =?utf-8?B?RHJmZzI3VHZ6c1hFNE55eWhJSWZQZHhRYVV6cUNIWUVlQ2JrOGJHYWs1MVRV?=
 =?utf-8?B?b0xUTGZ2T0sxTUREdk04THl5RER5SThRaXBTOUtyODgydnhjWDJYU2ZuYWJY?=
 =?utf-8?B?b3o2WWlFRWtXTFB4b1dPYkRndEJrRGhJOXlCOTFDV1NEcXlhWlUrODYza29t?=
 =?utf-8?B?VzdBYS94ZnlSTGlEYXh6ZFgxS2ZtOFNESlp0S1d0YTdHZlU0azV6ZWU1MjZJ?=
 =?utf-8?B?S3E1TjkycDhRRVZwWU95K0k2RVpkbmpPWjJudkc1NU53TXA3TGRkbGZYaU9n?=
 =?utf-8?B?WldIaFZCcWFveC9BdytIR3RlaVk3aGtSdGhydVhDaXBBSmJocCtPa24vcW5s?=
 =?utf-8?B?eFNDZGg2S3pMSnowUnN1T3BrUjBzT3VIbEp5Y2Q4YldJYkN6WkdWYnhNVmxF?=
 =?utf-8?B?R0NpOUpyb1VndE1iTHZOcUt4ekZ3VTMyeTFVLzgvZkVoTUlJNnlvdS81QUpw?=
 =?utf-8?B?bElhZGc3RGpIaTN2bGdSQmYvUEtwZzV1T3BKYTV6aEcydE8vbG5TWTBIVTVC?=
 =?utf-8?B?Wlo5NlZTemNEelZBUVZkalBFVGZEL1k5MkZuTy9sN1dNTWlpQkRacXJ4WTVP?=
 =?utf-8?B?LzRTQ1FFOHJNZ0VFKyt1YVZJZ2xoK0poZEFJRWwweS96R2RxeXNKbEtUNWFu?=
 =?utf-8?B?KzZoKzNzQlFjSTVUdkN6aW5kczlHYmJHZnNJRURsdkZBcEJYc1BMYTlWSTA2?=
 =?utf-8?B?Mzd1RjVYdlB6M0Z1OFF0V0JZRGVyR09oaTZSOHVhVURlK2RwMjZyUGVRTktr?=
 =?utf-8?B?ejZFYWJzVmZwdGpvQXZVMWgvN0RBSTdsTjJqQWFCNXBZNFVoUGpWajZDNEN5?=
 =?utf-8?B?aXhrWkxtQ0VhU2dQSWJwMUhhMXJwZFlvTmMzV0x3Z1BGdXVlY3NtVzZrc01x?=
 =?utf-8?B?R25vNDUzMTNtaFNBN3VSWjVGTDUwT3N4cUhuTlUrSlBJZVBTVHM4aGpJY0pT?=
 =?utf-8?B?Tzd0MGhjMDhFOWlDQ3dLSjd1QUlzZDlmTC9yblJhcVR3bk14QmRSR2F3OFpK?=
 =?utf-8?B?TzJOR25LeDA5RGkzeHovaGtyMjhqRzcrbDE2Y1V0L0RHY0d4UlBCRE51bnJD?=
 =?utf-8?B?bW1LK1cyR1dlZFhYMDh0cUVjYnp0UmxaZmNBdkg0THMyYzFOL2pRVk5iYmdG?=
 =?utf-8?B?cmR3OHVRYU5rbFVQMk00WXBqZTJpcHE4RFp6eHNUcXlVTTR6TkVOOUFjeVFo?=
 =?utf-8?B?ZTNlRU1rTkNJZEZVck9OZVAyQXU5RFFwRzZ4RkV3Q0VaM0w4TWROV1dxZkFu?=
 =?utf-8?B?TTF2S01EenhyRks2K1ZEQ0pWT2grNjFPVXVwRzBkZjNNSW0wcGgxK1IzR2oz?=
 =?utf-8?B?K2tFMjBjdEQwVUdVbDFjSVpodm9XblNxSGdXVWl5WjhSalRZdjRlY3N4MTRj?=
 =?utf-8?B?YU1TN004VUR5WWd2NlgwUlBYR0txT0NITWdPZ2pyMlkzZlNWbVBqTjQwRTh0?=
 =?utf-8?B?U0Z2YURQRE45Q3pyRERhWDNSd1IwaTRGRWNUbGNKNldqRTdXTVhMR1dVWDV2?=
 =?utf-8?B?OWVEc1M3WXFLOWtiUEdhMkJ5TllZN2lpa3RGQ095TWFoK2ZiaC9lSWF4SUc1?=
 =?utf-8?B?alhlWkN2Z2RCdTBVaWk1Y0NVWGJYMjljMGNKOU1PY0hPcmlzaWRoQkI2eTc5?=
 =?utf-8?B?QzdqUitaTFB4QjZWbDhhZnBCR2FHcXVOQ3phUHpsbThYWlJlNEVVN1RTYVJX?=
 =?utf-8?B?ZjkyaDFBMU5obmxuZmxGUDRMMzBkWUJpS3ZOcHByb05BQlBhOWlVQncrazhq?=
 =?utf-8?B?YVJ1K3JjZklKc012dXVCREo3R0JtelVnQ0hqemtSQk5VQi9peXlwajFUNFVr?=
 =?utf-8?B?SkEyMTlxSHFuOU9IRE03QjQ3QzZ2ZU1jZ1R1QXllTUlTcitRb00zcjdKT3Vp?=
 =?utf-8?B?QWM2Z0h0T1FWQVQvN3ZHVDllL0ZnNThWeFE5V2ZGQ0dwYmxlSmU2Qk9kVzY2?=
 =?utf-8?B?Tkd3Y2ZkaEI2N0YvNUE5Qi9lWlZwMnlvaFFJOHRBb1lNT2pZRFJGb0txWnZW?=
 =?utf-8?B?d2RsblhXeVNZQ29nK2djbzZqMWlEWXl0VnlIblZQN1YzR2JIc2hIdWRsb3dr?=
 =?utf-8?Q?eDFwCwnd5pnDmvHG8SyHS8zLt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684fa990-ad4a-4b12-f7fa-08dd51b9f18b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:22:02.0910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMXLlgskknJP7Z3Auwv9tnzESuBE254fpOTt38bZtljd+ifp7mpyRH+qELrN74SYSDUwJcePQF0QzFnoEfzSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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


On 2025-02-20 6:59, Emily Deng wrote:
> Call amdgpu_amdkfd_reserve_mem_limit in svm_range_vram_node_new when
> creating a new SVM BO. Call amdgpu_amdkfd_unreserve_mem_limit
> in svm_range_bo_release when the SVM BO is deleted.
>
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 13 -------------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 79251f22b702..3bbc69751f7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -514,15 +514,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  	start = start_mgr << PAGE_SHIFT;
>  	end = (last_mgr + 1) << PAGE_SHIFT;
>  
> -	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
> -					prange->npages * PAGE_SIZE,
> -					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> -					node->xcp ? node->xcp->id : 0);
> -	if (r) {
> -		dev_dbg(node->adev->dev, "failed to reserve VRAM, r: %ld\n", r);
> -		return -ENOSPC;
> -	}
> -
>  	r = svm_range_vram_node_new(node, prange, true);
>  	if (r) {
>  		dev_dbg(node->adev->dev, "fail %ld to alloc vram\n", r);
> @@ -560,10 +551,6 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>  	}
>  
>  out:
> -	amdgpu_amdkfd_unreserve_mem_limit(node->adev,
> -					prange->npages * PAGE_SIZE,
> -					KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> -					node->xcp ? node->xcp->id : 0);
>  	return r < 0 ? r : 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index db3034b00dac..c861d8c90419 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -430,6 +430,10 @@ static void svm_range_bo_release(struct kref *kref)
>  		/* We're not in the eviction worker. Signal the fence. */
>  		dma_fence_signal(&svm_bo->eviction_fence->base);
>  	dma_fence_put(&svm_bo->eviction_fence->base);
> +	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
> +		svm_bo->bo->tbo.base.size,
> +		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +		svm_bo->node->xcp ? svm_bo->node->xcp->id : 0);
>  	amdgpu_bo_unref(&svm_bo->bo);
>  	kfree(svm_bo);
>  }
> @@ -581,6 +585,18 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>  		kfree(svm_bo);
>  		return -ESRCH;
>  	}
> +
> +	r = amdgpu_amdkfd_reserve_mem_limit(node->adev,
> +			prange->npages * PAGE_SIZE,
> +			KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +			node->xcp ? node->xcp->id : 0);
> +	if (r) {
> +		pr_debug("failed to reserve VRAM, r: %ld\n", r);
> +		mmput(mm);
> +		kfree(svm_bo);
> +		return -ENOSPC;
> +	}
> +

I believe the error handling would be simpler if you moved this after the mmput call. Then in case of an error just use goto to a new label after the unreserve_mem_limit call you're adding below. Other than that the patch looks good to me.

Regards,
  Felix


>  	svm_bo->node = node;
>  	svm_bo->eviction_fence =
>  		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
> @@ -655,6 +671,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>  reserve_bo_failed:
>  	amdgpu_bo_unref(&bo);
>  create_bo_failed:
> +	amdgpu_amdkfd_unreserve_mem_limit(svm_bo->node->adev,
> +		prange->npages * PAGE_SIZE,
> +		KFD_IOC_ALLOC_MEM_FLAGS_VRAM,
> +		node->xcp ? node->xcp->id : 0);
>  	dma_fence_put(&svm_bo->eviction_fence->base);
>  	kfree(svm_bo);
>  	prange->ttm_res = NULL;
