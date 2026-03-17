Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98669F33805
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 06:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CEF10E347;
	Tue, 17 Mar 2026 06:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZJDI0qKZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A791610E342
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 06:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ribq9jVDFaTrf5l1G3h1CV0xQ0HF4HWtOOXbM5t30evcnYrUTEijhiUhdmf+vPNp4hq5hq1qN8v4I6gis/L2RAz9X6fPif0J15Dk8liUj19PV0IfMZq7wziQWGJBoMnZAvXoXHJZG4BZpj7oVlWqnreT72iYsWOTqn/YAIE3zPkrQ7sF1cEBwg0YLynE6FmkhsyMaCTH2O3FkHTaY2bwcXQacXhPFOYoPvfQONPmGhkBIgSfnyqo6HtxUuOnHXIyovrNepThUv5BiF6z9mKZohLU1g1g+wu9qQ97G6vsT65TmwMcYBuApvNKgG5b9+enlc7+YXUnhx0o1RZUBCCF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NFQ7MxVxIFZsCkbCawe1euugNsVIE8/Bcq8Pu3ZNLQ=;
 b=D7hnFiraG2vhVsTALRdh1crnxAWXU4oemZ8CyYocggNsVbxQWDbTSjthXcXt7BTLPek12N/bKCw1yNPuBoJ/P0OcA6D7/kzDOVIWzDUTnLSq8+ZYB0drL1Q4WjB6qoGNrg62aM/i4CqcyrxoX/a4daTtOjTCpfSQULeFb/3SOtcS+tnn17rUKqzr7CQr+Gj2hBABJGHu3J8A0XTuju9vh2jP5OACY/T3WKsWkOQ+Kwezm+7KlVQDR1eTnXhadvuJyR55VtB2dYQ3YXUq9Imcpy6ObgYuu/i3FdwglwdIeGkHHLwldXuoBqnK/jGG6c1MDFHxkwHORWdoweh7ujmhHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NFQ7MxVxIFZsCkbCawe1euugNsVIE8/Bcq8Pu3ZNLQ=;
 b=ZJDI0qKZ7nx79Q/MdQHy7G9pMDignc+gZgTrNJod5A/8fx4PzpuFWte6FJiYDk+fFvz8ZpXQN/zVjSB80kMTRLGSs3B1RxPWh+vJBXbhBGffbVt3O6Y6I6x0syJFa4Btaql5vadWeITOb1MdQWNVAEEnN2mpURM2Lzh2RzSklwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 06:54:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 06:54:25 +0000
Message-ID: <f3d3ac83-4ca9-496d-a583-780dc5a27e60@amd.com>
Date: Tue, 17 Mar 2026 07:54:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: prevent PASID reuse until poll is exhausted
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20260316191507.288273-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260316191507.288273-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 619ddfd3-7dc0-4f99-b051-08de83f2068b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WrAw/Nwguoe4EywrbPwlVENRuIlGMo1GAvwcMBYKYh26biLlhn1GNUZs1RPZHnCNlrtI4uNv2swljYTpNbgxlRKiyfSvZaWvUtwL1HUsZnRq3rgaEq66xEuTI0JQxpmxNhgrePgrL6E0vpu3Kna+goY9tAinfbCu5DfpuErQF+9RNbjnhnzlj5nXx99LxaMb+QTgtOWNjoS0YUx/aYpYBYqFQUMyZhSz7pih8tMU28UhQZ6uq0jBKAg/xtXV1H0qVEdF2Nv05dNrx7Lnu+Vc/WMYd/RtUq+Flgb/3Q6QFnINpO5ObsP1iGDUwhMQ07aowK38qHMdk2VXGRVjHCXyhP7R89DPjp+zA8o+MI3aKiUJEPrnaf7P8ljYTJueu2nsImeaH4OB+T+HkAFqOSVJ8hroLeGKkfdKjLvv4/E0u7+rba4IBvHTtBzvQRhN75zIHWc3UZT9Ix1PbsvE3tKiU561uIs7976g5mKqSByqYhuCZFxYnU1ogaRVIvPttZO/HiD855vVcy7EhPemXbKTpkpjKfuKrFV3CqZ52NUsgFrfJjAeA4N5otHCF4KTNgVuz5mdH13zRmG7mlbnNUboi0O8t9PkKmVXDYxfgP2zVT+SdmewgxcSu51tyqMXBpao+mtG58mYsH5sCpx90tlNjNhjg0l7MlTwtAe0qb4v6sFFP22ju45AKn7LXfq212UsoPf3vVcEUZ99vd6/zUJcZ0lXpGaONsBvtckbSMhYsK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTI3MlRCYkduUmFpUy9tdTFTTzd3M1RUOE01b3o4YmtVTE94SnVDSUEvd1R3?=
 =?utf-8?B?ZTkyWkhNZ0VxMVBjeDhtWHV5dFJhSk8xYU8xZ0V2MWcrQXh1ZDkxcmZaTTVx?=
 =?utf-8?B?bzlEY1hTaTAwalF4YW9nWFpSV1dOa3FsOGdyT3JHMkVheFBKMVdrVXlKKzhR?=
 =?utf-8?B?c3pRMkJ3dmVreUhwWEI1alFSL0NPSGZSWEY4WWtvMEt4b1ZHa3JscGlSZEdw?=
 =?utf-8?B?ZEVkRlRGUDBvbGhNaHRDdUM1NHZqbHR3OVQzTXN5dzNkVFIrV3RwOEpDcmdv?=
 =?utf-8?B?YTVrVTZneFdoeFJ1WDViT2VxdWRIYy80QXB3OHJySDl4Yjg4UzNLTjYxOVk1?=
 =?utf-8?B?bFhTSHV4a1BDUkNoT213Z0EwNnNNNEo4cDVSRGtVeTh2Vks3Q3lNQUdqZTU3?=
 =?utf-8?B?bXVoWFp0d2RiZWJBYStiaDZ0K1hvUGVSRDNUMGpCQzhGbG9MT0xLck9rb09E?=
 =?utf-8?B?aWNNUk1LelJEeWkwSEFOeWNreUJoL2dCdGZXaG1yeUhIZ204bUkzTHIrbEhU?=
 =?utf-8?B?K0Q4S243V0RSU2RTREpHM1V1S1NkU3JTOVZKM1I5KzhiWHA5RWZnRUk2dEl4?=
 =?utf-8?B?Y2hVeUwwWEdZQ2dFUG5wZkpPdGZmNytMNThvNis3VWQ5c2VDUEJWOHBmT2ZY?=
 =?utf-8?B?YmU1TmREWTl1WXJidFc5YVJKNWJVemZ5aWRISWExZUVYVmJqREJqcGtDU0Za?=
 =?utf-8?B?Q3NZZndTMTMzNGIyVk4xRnRtVFlENXUrZ1R6Q2RudHlhdUFPMkxvWG5Say9i?=
 =?utf-8?B?VTh1L3pPTEFZelR6QkdtcEpOREdaNjJYSllmNmNsNnVMdS95bjJsRGRwMm51?=
 =?utf-8?B?b2h0aTRtTzlaTlk4UWlVVzM1NkVad2FHZXlKaUNDSTdqMW9pRWZzOEt4VHFw?=
 =?utf-8?B?UnQ5MWRLZUNscnUyWnl5N1JFSXlrRXVGM1FVc1hnZWMyUXAzcmJydEFpa2tM?=
 =?utf-8?B?RjBOT29qNUY4dzc1VFVBUlZ6WXJQaGpOMmp6eGZCelVjZEFFR2I1RUVrZ0Q4?=
 =?utf-8?B?dURWV2h5ejNxSXJIaG5aQ2xtcWwycDZGaXg1ZmxjWVVpd1hiVXJ0ZElXSzR2?=
 =?utf-8?B?b2o5dXN1UG5LNWIxQ0xGWXpmZGR2RFhZVDBBRG4wenordFlSMVZES1VGbjlG?=
 =?utf-8?B?VzlNbTV5ZDRlWFFlRVRPQ3dwSVZZZlNlZjdkTGtHak1HWTNZaTJzbkwvelVl?=
 =?utf-8?B?azdhbGJqVGdkQytUdUJHVUNKYmlITkN2TzFMUmQ3OEZQTG5XRFhlU0xUR0Nm?=
 =?utf-8?B?enFFaG9UaENEVlJOUWI5OVdQNlBoUENsUU81TEMwZnhRS2JWMUpNcUtZUWRR?=
 =?utf-8?B?Z1cyVzBrSk95eVZMYjI3NktTSWkzTkRITUVnR3NKNUl3elBsZWVTVlgzSisy?=
 =?utf-8?B?Vnh5a3FyaGwwbEZ0b0lMSGhZRzRzaTBNQVo0T1RUR01tY2lDUU1mTEYwSHpN?=
 =?utf-8?B?MVdtcER1a25EaXladXNxWFlCSlR2Q25zK3NwSkd5bzRGY3BvYmo0cC9vK0lz?=
 =?utf-8?B?dGJZQllKUDk2V2w3Y2dvMTFQbmw0TFVkYzJXSmdyclV1RUZVcndxRzVxcWF4?=
 =?utf-8?B?ZklCMW1ZV296WGg1TUowaU1sWG1pdmptU1l2WDFlSnBtVXFtWjEvMWdocU9v?=
 =?utf-8?B?QkFxeFRYUTY2WkljSWoycWxRakc3bmlURGtSd3AwTTc5SFprY290Rmc4Vjlh?=
 =?utf-8?B?emlKK1d3aVgvNVBRcVZFK2pFRzZRNG9MYXp1aDRsNkUxSW5HZXNoUUxXUVBz?=
 =?utf-8?B?SkVtR0ZzTm9ESnRrQkI5UnNscDFBaEl3aGVOMm0yTDNzQmJLV0RQY09WbDZE?=
 =?utf-8?B?WERhT2pKTitYOFVocjZsVDR4NVFFUWF1SE1ZYnRjbGt5ZDRBNUpqTitmM1Bp?=
 =?utf-8?B?MzBzWHpwUjFwc1hSMThGSm4yWVArWFJUMDJrWEcrSkpRSG1LZmhHWS9xenhj?=
 =?utf-8?B?cTFYQ3ZkSndMWjF4UlViTDV6TW9PU1EyTy9tamlxdHlxemxxMkFQV3ZLbHpF?=
 =?utf-8?B?UnJuL0RGbmNRandJUWt1YUxDMkIzTkpGcExUTTBZRVhyR0hNdWpvbCtnRHpP?=
 =?utf-8?B?RGtaR2syZ0NrNE1XVHRUcHhDOFM3Tkx0QXRhSmxnTVdBVzVWbWRvaElSWmZj?=
 =?utf-8?B?dTFCd2dXbzJIMTRJbTBmMm55aUxEbEpteXlpSzRzNURZdkdDVXAwTDEzemNS?=
 =?utf-8?B?bjNFcGQ3aGQ2UWVOcWMxeWxNY1lmRW1lOThiV1VGTDIyS2NNQTI1NDhnRmJp?=
 =?utf-8?B?VkRvNndZVHNEMUMwc2ZXY0VmK2tiaS9ReEJBbm1ObnJCSGNYL0F0aDk4YU1I?=
 =?utf-8?Q?JJDxMcOMwZVeYY3kNG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619ddfd3-7dc0-4f99-b051-08de83f2068b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:54:25.0774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+KgQFOXY2qwkzRlIPCQvGWVdmB+sbksKsbm3IR/M7sS5sgC38/F6j+5l1Xp7oti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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

On 3/16/26 20:15, Eric Huang wrote:
> PASID resue could cause cache, TLBs and interrupt issues
> when process immediately runs into hw states left by previous
> process exited with the same PASID, to prevent the case, it
> introduces a freed list to store used ids to provid maximum
> safety avoiding resue.

Well absolutely clear NAK. This just hides problems instead of fixing them.

Even if we want to not re-use PASIDs immediately there are the cycle functions for that.

So this here is completely unecesssary.

Regards,
Christian.

> 
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 87 +++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  1 +
>  3 files changed, 85 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9cab36322c16..0443b05ddb1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -40,6 +40,21 @@
>   */
>  static DEFINE_IDA(amdgpu_pasid_ida);
>  
> +/*
> + * Freed PASID pool - PASIDs are stored here after being freed and only
> + * reused when no fresh PASIDs are available from the main allocator.
> + * This prevents immediate PASID reuse and gives hardware time to flush
> + * all references (caches, IOMMU TLBs and firmware state).
> + */
> +struct amdgpu_pasid_freed {
> +	struct list_head list;
> +	u32 pasid;
> +};
> +
> +static bool mpool_exhausted = false;
> +static LIST_HEAD(amdgpu_pasid_freed_list);
> +static DEFINE_SPINLOCK(amdgpu_pasid_freed_lock);
> +
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
>  	struct dma_fence_cb cb;
> @@ -51,7 +66,8 @@ struct amdgpu_pasid_cb {
>   * @bits: Maximum width of the PASID in bits, must be at least 1
>   *
>   * Allocates a PASID of the given width while keeping smaller PASIDs
> - * available if possible.
> + * available if possible. Prefers to allocate fresh PASIDs from the
> + * main pool. Only reuses freed PASIDs when the main pool is exhausted.
>   *
>   * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>   * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -61,13 +77,34 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  {
>  	int pasid = -EINVAL;
>  
> -	for (bits = min(bits, 31U); bits > 0; bits--) {
> +	/* First, try to allocate a fresh PASID from the main pool */
> +	for (bits = min(bits, 31U); bits > 0 && !mpool_exhausted; bits--) {
>  		pasid = ida_alloc_range(&amdgpu_pasid_ida, 1U << (bits - 1),
>  					(1U << bits) - 1, GFP_KERNEL);
>  		if (pasid != -ENOSPC)
>  			break;
>  	}
>  
> +	if (pasid == -ENOSPC && !mpool_exhausted)
> +		mpool_exhausted = true;
> +
> +	/* If main pool is exhausted, try to reuse a freed PASID */
> +	if (pasid < 0) {
> +		struct amdgpu_pasid_freed *entry;
> +
> +		spin_lock(&amdgpu_pasid_freed_lock);
> +		if (!list_empty(&amdgpu_pasid_freed_list)) {
> +			entry = list_first_entry(&amdgpu_pasid_freed_list,
> +						 struct amdgpu_pasid_freed, list);
> +			pasid = entry->pasid;
> +			list_del(&entry->list);
> +			spin_unlock(&amdgpu_pasid_freed_lock);
> +			kfree(entry);
> +		} else {
> +			spin_unlock(&amdgpu_pasid_freed_lock);
> +		}
> +	}
> +
>  	if (pasid >= 0)
>  		trace_amdgpu_pasid_allocated(pasid);
>  
> @@ -75,13 +112,34 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  }
>  
>  /**
> - * amdgpu_pasid_free - Free a PASID
> + * amdgpu_pasid_free - Free a PASID to the freed pool
>   * @pasid: PASID to free
> + *
> + * Add the PASID to the freed list instead of immediately returning it
> + * to the allocator. This PASID will only be reused when the main pool
> + * is exhausted, providing maximum delay before reuse and allowing time
> + * for hardware caches, IOMMU TLBs, and firmware to clear all references.
>   */
>  void amdgpu_pasid_free(u32 pasid)
>  {
> +	struct amdgpu_pasid_freed *entry;
> +
> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry) {
> +		/* Fallback: free directly to IDA if allocation fails */
> +		trace_amdgpu_pasid_freed(pasid);
> +		ida_free(&amdgpu_pasid_ida, pasid);
> +		mpool_exhausted = false;
> +		return;
> +	}
> +
> +	entry->pasid = pasid;
> +
> +	spin_lock(&amdgpu_pasid_freed_lock);
> +	list_add_tail(&entry->list, &amdgpu_pasid_freed_list);
> +	spin_unlock(&amdgpu_pasid_freed_lock);
> +
>  	trace_amdgpu_pasid_freed(pasid);
> -	ida_free(&amdgpu_pasid_ida, pasid);
>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -616,3 +674,24 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>  		}
>  	}
>  }
> +
> +/**
> + * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> + *
> + * Free all PASIDs from the freed list back to the IDA pool.
> + * This should be called during driver cleanup.
> + */
> +void amdgpu_pasid_mgr_cleanup(void)
> +{
> +	struct amdgpu_pasid_freed *entry, *tmp;
> +
> +	spin_lock(&amdgpu_pasid_freed_lock);
> +	list_for_each_entry_safe(entry, tmp, &amdgpu_pasid_freed_list, list) {
> +		list_del(&entry->list);
> +		/* Return PASID to the IDA pool during cleanup */
> +		ida_free(&amdgpu_pasid_ida, entry->pasid);
> +		kfree(entry);
> +	}
> +	spin_unlock(&amdgpu_pasid_freed_lock);
> +	mpool_exhausted = false;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index b3649cd3af56..a57919478d3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -74,6 +74,7 @@ int amdgpu_pasid_alloc(unsigned int bits);
>  void amdgpu_pasid_free(u32 pasid);
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
>  			       u32 pasid);
> +void amdgpu_pasid_mgr_cleanup(void);
>  
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>  			       struct amdgpu_vmid *id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index b89013a6aa0b..5b9bdb79efcf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2864,6 +2864,7 @@ void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  	xa_destroy(&adev->vm_manager.pasids);
>  
>  	amdgpu_vmid_mgr_fini(adev);
> +	amdgpu_pasid_mgr_cleanup();
>  }
>  
>  /**

