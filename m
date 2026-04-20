Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960EBF5A8C8
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 21:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE5510E749;
	Mon, 20 Apr 2026 21:32:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zxC/7MYJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477DD10E749
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 21:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSni83YVNSRNbpw0WZXtzdRsPlCRZHwWmciM3ogzAIo/QiPxtp99r+lmRkLSe+lTwIO/yStYw+Nbz7GjVUFiGGDls9Dg1daAG7h1SmvpTEBq7XNOgmmH22EaqtVoma6OptHOAox8wE8W63DI+BR2sqf/J9TNFzZw99XI8QnADp2noPE3rYWaP766Ahbg969496S7dqiab67E1CJcMdHYzkQN5UopVAe85+baA8PVbyeaDpl+IJnLpGggs3kAtkA2C2jl2BubKka9J20DeaxGc2K3pQuqNm90FfRcjL4TgoXui20R5iDWmJZNP0yVVIQZ2iNklSJ0yq5F2L3Xhadg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9c0qbUpOhWIIrjf/iRLEOSQblEw9zzk8eseqAwu0ng=;
 b=a2H5yLE28tDg47VMeGbvMZCnierxG1b1LZixB14eRj5oEHdJTPbqY7Q2qWrPM9JB2yzbAXBGY9f+og0Zz24GZolLopYlBRjPT5Uj2m/On3GqdtacjiD80Ij/bg2xWCXBIwglt09OLkK6N2h4rmnK556bgaNe4RdLaY9J5+m9/2GmXXhYOgLYSMxRhg/j6LrIPDBnl9kMZxRe9hB6LCCqQ1wb9qcztrZ+/7rebSEqRQSTqJpduJ5a7CnVb7De3f7iIOlMeP0NVACcuesyoPiaFRzWal9U3WjHQsRgcemzb9VuRRO0rX4ewH15XkbbCkxrli1nNbvxMWyMRBDR/iD5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9c0qbUpOhWIIrjf/iRLEOSQblEw9zzk8eseqAwu0ng=;
 b=zxC/7MYJofylsnzXWso13bmEQXTkibEsm+yHdmuRDKhLhVBmJgZiL320vCuTSeW+9fIraWGTgzSHEkzuD952VSiXptSba4vKx2jPob+9E4ycp2KKysKaSJh37Qle4kXPdDa2IEnSS6WuyAApVpwnPEK/+rXwUdCWFM9KzVYTNiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 21:32:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 21:32:06 +0000
Content-Type: multipart/alternative;
 boundary="------------3MPqkbXW4SGKddwIq7CS1Tbd"
Message-ID: <f2f17b8e-ce73-4d96-b5df-29d235f9ffca@amd.com>
Date: Mon, 20 Apr 2026 17:32:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Make all TLB-flushes heavy-weight
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com, christian.koenig@amd.com
References: <20260420155822.718805-1-felix.kuehling@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260420155822.718805-1-felix.kuehling@amd.com>
X-ClientProxiedBy: YQZPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: cf189d5e-8ba6-4933-b00a-08de9f2444ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: qfumuqqnbcwaHU1e8eEMrprJ2H4n9shwCVBUzYgKfzMMbN3IEmdD4k9oqtE4pBhACPujYQyOXo51x/33osQNL5IVavFfKTZDvWhDERVSwukp9U+H9k21p0zHxAoLWO/hirohL96xQmnppgjcgDC6K9DCTSYT/dY76xiIxSsV2xoe4G8c89YZ3VtYf0OyD509NcPA+3Bv/wBYary4QBMDHj0kgyj7zXKr2tBKNLdtoa0BWHrxZuDH9dXqsZjA1RL8Pq6lCm3dU0F1Wz4MIQfRvzrshQMIqMB6yOQ8yDRSnM3BfZ5EEgHX3kCt5EpElpQIs+/mKnsk1GhJaoPFTTNxXrFmErr0B1JqoAZLu/IIsVFh+r37i65vCZMbVKWIGYz201oTTU/UiiXcD/1lVUBUFa+BC8NsEMLar0+/LQU1canU2Msv4mjrNx4+bY1xYdotNKKbd4gQCPU56T03uKz9tzo/RFhlZguGmknxj6krAfRSL8bqzY653w+R9CXJuLJK4++GUDUEbx7VIclUQzEbh7TAdor1NOm75sYEuWGwpS5sn5Gw9TMsLijZnSXJxJNXKwiw7Wt1B1ESEj14wLsj1bGjeFJFQtyrYxmJhFJcIEfWWeuJrdMq0xkJBW3aNqqy9fC7K83+PpGeweEwbYSr6cRwIC5T7i89eAMJPiAXhr1t/XDc4wZM/s63Rn42hj9Cb4+9cAgQXiujIl4bmk9tCmgnniL6OhQ22D1j9mVNFNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzZOYjZDMG9RSkdqVTJWMjRveVRjdHFCa28ra1ZJWnM2YWZNL0txb0dsQUc2?=
 =?utf-8?B?YUpWU2ZJWDJmOE1rK1kxWmQ2M1R5ZGd4VGU4UWE4MVROTFg3QW0xbU4wODhZ?=
 =?utf-8?B?K3ZxL3Qvd2JNWmg4N3dhc0pINE4vMm9YY2VlR1BYejh1MkY1VEtKcEwvb3Jz?=
 =?utf-8?B?YUh4dkFDTk56bHlYWmZOUWVaMWNmRWJFTittdWNQMktwWkhtZUtNVUpaTkxB?=
 =?utf-8?B?WHV1MkZjeDloYkRUdzlWa3pGdk9rbDNKcWRHUndZYVU0QWVLVWlOR0Q4Ulk3?=
 =?utf-8?B?VGZaaEFjRjlKVGdnbWM0RkhkTm9HaUZCN0sycklKMHloY3VYL2hHcXJkRDNn?=
 =?utf-8?B?TUZITHZKbUlUeklId0NqT055R2JNR2lBY2gwcUZqcW5DTUlSNHl0S28vdElu?=
 =?utf-8?B?VUx5Y3lyRGJWUFFld29Zdy9JUXBHMmY2NTZ5TjZJR0pJVWJZRUhMRTlxdmRR?=
 =?utf-8?B?N0UxQk4xNmlaS2h2V3lGL2M5MWUvb2VucHlQNzJqQVJ4SnA0ZjBhQ2E1dzdp?=
 =?utf-8?B?eGo5R29iVkpTUm5XYlZuT1FRNmJkM1k4NlFEMjhzWHhOWVFRRWQ5Rmp4UTh3?=
 =?utf-8?B?NWFSR1BVVURKREZtcTBZZk1zVUw1aXIwa2NKUEgxWEw0dGI2YVV3ZjFyQi9P?=
 =?utf-8?B?ZzVEdk9YK1FPeHc3VjByUVFqTWlMYm1RMFoyY3ArbWNTRy85eFVBK1ozZTRo?=
 =?utf-8?B?MWhsM0F6MnNpY3VhYTdYQXFmSDBLSmJNaVQvdWdwaDQxdWZpMENMN0hmV3h1?=
 =?utf-8?B?MWQ4Nmw0cytWWHFkQkw2VkdmSXJjL2M5NEd1bEl6b3lqdUFxY0ZMTklIVjQ5?=
 =?utf-8?B?WTFLS2VNNlllQ252WnZhZWV1OFhHRmN6bXJ4VXFtaHZ0OVFQZ2tXL0xkai9P?=
 =?utf-8?B?VkJVMkN6RE9JRGlVU0pOV0M1SmVkd0xNRzBWQ2RleTI5QzA1SVZuN0tjNktn?=
 =?utf-8?B?bno3R3VkUlJHa2Nvakw1dmhiUmpRT2RlSmF6RDlrd0ZSUUxGbDRlNkJLbkpU?=
 =?utf-8?B?KzRVZnRtZDlwQUlQWmlRYUVndVI4RWUvUzFzakNKUm9sWjJDZmpMRG5DelNj?=
 =?utf-8?B?MkJGaGxjOVRCUnFyaStDOGlKZldRY0tTQ1UzV1RQWEgzbTdSS2pVRW9wbHRt?=
 =?utf-8?B?OUtBZnFjeEx2SStjdmYvTGNoQVpxTkdNZkhIbHcvcmFIbmM3NFVIWGQrMlo4?=
 =?utf-8?B?VmdBY0RRM2twNklXK2hLM1l6UlpyZm9jRFhJdHI0SDhTY21SYkhjRkQ5czBZ?=
 =?utf-8?B?Z1ZpZ3d5OGlvUWMxSC8wTmJOUUtMRFU1cVdlc2pjMzV0ZnZteWxub1JUdzZB?=
 =?utf-8?B?SVpSNjdCeW9KY2xZZ1U1SjRwWGhRMWpubG5qZmg1Y3BDSC9PcTV2OE9POVp1?=
 =?utf-8?B?QWY3UjNTRk1iRWV4YTkyT0srUEJEMndNNWlOQSthR2hTNVA4QkJ4STVwZmd3?=
 =?utf-8?B?cHdZbzQ2QmIxQ3p2eTZlUmNZUW5GVjFOUnNxK1BLQmo0VktCVW1vbC8xWGFw?=
 =?utf-8?B?YTd5NUlMQXMvSitNZjdFLzBaYmVZeFpVcE5HaVI1Z0ZrM1FwSzdZL1dSL3Rz?=
 =?utf-8?B?Skc1QUl1MXorWXJ5WGtCN1NkczhDZ09LOERQY2tLbkRRVFFJelhKdnpmbHh3?=
 =?utf-8?B?N0tqOStsTUx6aXN4clhHeUs4ekNGMW4zMythR1V4aGpob2JKUG5vSzdyQk8y?=
 =?utf-8?B?NldRTEJGL1dMS2g1RXBqdnZhQnAraWh1NDFiaWZybWZLNWNpNWFoYTZOOUpX?=
 =?utf-8?B?dWF0OEtEMjMveCt1RldxT1RYRlV0Q3hiNjJBWGtVVVZBUEJUNCtWcUFEWjJG?=
 =?utf-8?B?OGpucXZQOVBWMkMrTzFtb3B1MnJlblIxckQ1eHA3WFN2Tng2TWM4TWgvN3gx?=
 =?utf-8?B?Z2p3djdMMjU0SWZrYkxCd29EazdyUXpIalF1LzFNM1RQbXRrYzY0VmpqNzJr?=
 =?utf-8?B?c1BWSEFTQ3VJYng2YlpPbmtvUlExVVVvREFhR09wcGhZby81M1pVVlFoQ2xk?=
 =?utf-8?B?bXh1RFl2UE9qeVB0a3BjVi9VSzJmTHBBVnhydHAwck5KQ0JGSUx0SkRjMmta?=
 =?utf-8?B?d04wbVUzS2svM2s5bUdXck1kdXFuQ3dhV0FwbzNEQlFPRzBLaXBncXR3Sndo?=
 =?utf-8?B?RXllWmd4VG5BeVBJclpvNmFZdEozREhtY3B3ejllcG9UeGMzUzRKOThwT1hu?=
 =?utf-8?B?QjR2WkZ5WGUzbkF2NHozSkJSendISEN5NCtTdVg4OFpqWFMycSs1NmdjYnhu?=
 =?utf-8?B?ZzlINlZaeFp6d2g0NHhTRHVCMERWYWt2MnRtV0FsUXNWL2ZEK0pLWFpCVXdX?=
 =?utf-8?Q?1j1RLOCcIkcRGkmE5M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf189d5e-8ba6-4933-b00a-08de9f2444ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 21:32:05.9240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Z2XD1tiZsPOXa4ocHSjQu1pjAx46v+ajSRibmltSDC2D+2USj+/rbhbreM7p1I9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
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

--------------3MPqkbXW4SGKddwIq7CS1Tbd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-04-20 11:58, Felix Kuehling wrote:
> With only one sequence number we cannot track the need for legacy vs
> heavy-weight flushes reliably. Always use heavy-weight.
>
> Signed-off-by: Felix Kuehling<felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c                  | 4 ++--
>   4 files changed, 10 insertions(+), 10 deletions(-)
Probably change to heavy-weight flush in this path, other changes look 
good to me.

amdgpu_gem_va_update_vm()
  {
   ....
           if (vm->is_compute_context) {
             .....
                                r = amdgpu_vm_flush_compute_tlb(adev, vm,
                             TLB_FLUSH_LEGACY,
                             xcc_mask);
}

Regards,
Philip
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 16fb39259911..0625104a7693 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1358,7 +1358,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
>   		if (WARN_ON_ONCE(!peer_pdd))
>   			continue;
> -		kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
> +		kfd_flush_tlb(peer_pdd);
>   	}
>   	kfree(devices_arr);
>   
> @@ -1453,7 +1453,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   		if (WARN_ON_ONCE(!peer_pdd))
>   			continue;
>   		if (flush_tlb)
> -			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
> +			kfd_flush_tlb(peer_pdd);
>   
>   		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
>   		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c1f668f12732..8d9bf4334090 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -595,7 +595,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
>   			qpd->vmid,
>   			qpd->page_table_base);
>   	/* invalidate the VM context after pasid and vmid mapping is set up */
> -	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
> +	kfd_flush_tlb(qpd_to_pdd(qpd));
>   
>   	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
>   		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->adev,
> @@ -633,7 +633,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
>   		if (flush_texture_cache_nocpsch(q->device, qpd))
>   			dev_err(dev, "Failed to flush TC\n");
>   
> -	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
> +	kfd_flush_tlb(qpd_to_pdd(qpd));
>   
>   	/* Release the vmid mapping */
>   	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
> @@ -1307,7 +1307,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   				dqm->dev->adev,
>   				qpd->vmid,
>   				qpd->page_table_base);
> -		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
> +		kfd_flush_tlb(pdd);
>   	}
>   
>   	/* Take a safe reference to the mm_struct, which may otherwise
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 53c26b1a25ca..dc8787dc399b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1559,13 +1559,13 @@ void kfd_signal_reset_event(struct kfd_node *dev);
>   void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
>   void kfd_signal_process_terminate_event(struct kfd_process *p);
>   
> -static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
> -				 enum TLB_FLUSH_TYPE type)
> +static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
>   {
>   	struct amdgpu_device *adev = pdd->dev->adev;
>   	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
>   
> -	amdgpu_vm_flush_compute_tlb(adev, vm, type, pdd->dev->xcc_mask);
> +	amdgpu_vm_flush_compute_tlb(adev, vm, TLB_FLUSH_HEAVYWEIGHT,
> +				    pdd->dev->xcc_mask);
>   }
>   
>   static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 015eb61f3440..5090f8c15428 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1418,7 +1418,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
>   			if (r)
>   				break;
>   		}
> -		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
> +		kfd_flush_tlb(pdd);
>   	}
>   
>   	return r;
> @@ -1560,7 +1560,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   			}
>   		}
>   
> -		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
> +		kfd_flush_tlb(pdd);
>   	}
>   
>   	return r;

--------------3MPqkbXW4SGKddwIq7CS1Tbd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-04-20 11:58, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260420155822.718805-1-felix.kuehling@amd.com">
      <pre wrap="" class="moz-quote-pre">With only one sequence number we cannot track the need for legacy vs
heavy-weight flushes reliably. Always use heavy-weight.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                  | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)
</pre>
    </blockquote>
    Probably change to heavy-weight flush in this path, other changes
    look good to me.<br>
    <br>
    amdgpu_gem_va_update_vm()<br>
    &nbsp;{<br>
    &nbsp; ....<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (vm-&gt;is_compute_context) {<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; .....<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r = amdgpu_vm_flush_compute_tlb(adev,
    vm,<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; TLB_FLUSH_LEGACY,<br>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; xcc_mask);<br>
    }<br>
    <br>
    Regards,<br>
    Philip
    <blockquote type="cite" cite="mid:20260420155822.718805-1-felix.kuehling@amd.com">
      <pre wrap="" class="moz-quote-pre">
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 16fb39259911..0625104a7693 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1358,7 +1358,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
-		kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(peer_pdd);
 	}
 	kfree(devices_arr);
 
@@ -1453,7 +1453,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
 		if (flush_tlb)
-			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
+			kfd_flush_tlb(peer_pdd);
 
 		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
 		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd-&gt;drm_priv);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c1f668f12732..8d9bf4334090 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -595,7 +595,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd-&gt;vmid,
 			qpd-&gt;page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
+	kfd_flush_tlb(qpd_to_pdd(qpd));
 
 	if (dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va)
 		dqm-&gt;dev-&gt;kfd2kgd-&gt;set_scratch_backing_va(dqm-&gt;dev-&gt;adev,
@@ -633,7 +633,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 		if (flush_texture_cache_nocpsch(q-&gt;device, qpd))
 			dev_err(dev, &quot;Failed to flush TC\n&quot;);
 
-	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
+	kfd_flush_tlb(qpd_to_pdd(qpd));
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd-&gt;vmid);
@@ -1307,7 +1307,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm-&gt;dev-&gt;adev,
 				qpd-&gt;vmid,
 				qpd-&gt;page_table_base);
-		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(pdd);
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 53c26b1a25ca..dc8787dc399b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1559,13 +1559,13 @@ void kfd_signal_reset_event(struct kfd_node *dev);
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
 void kfd_signal_process_terminate_event(struct kfd_process *p);
 
-static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
-				 enum TLB_FLUSH_TYPE type)
+static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
 {
 	struct amdgpu_device *adev = pdd-&gt;dev-&gt;adev;
 	struct amdgpu_vm *vm = drm_priv_to_vm(pdd-&gt;drm_priv);
 
-	amdgpu_vm_flush_compute_tlb(adev, vm, type, pdd-&gt;dev-&gt;xcc_mask);
+	amdgpu_vm_flush_compute_tlb(adev, vm, TLB_FLUSH_HEAVYWEIGHT,
+				    pdd-&gt;dev-&gt;xcc_mask);
 }
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 015eb61f3440..5090f8c15428 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1418,7 +1418,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+		kfd_flush_tlb(pdd);
 	}
 
 	return r;
@@ -1560,7 +1560,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			}
 		}
 
-		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(pdd);
 	}
 
 	return r;
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------3MPqkbXW4SGKddwIq7CS1Tbd--
