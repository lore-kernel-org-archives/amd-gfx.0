Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901D4C61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164C010E319;
	Wed, 22 Nov 2023 22:22:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B7210E319
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:21:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OB0iznJzh0fvtozg4ahzoXaGeRHjwMw6I+Rf7cmk/MCROSL0VL9xczLLJt0f3OIeT39Kjo5YbRpD+F4BwdytMotwG8znWLKViwNKHx8oS/RrInBF984+ARU0ICZ+rm//tIBWJZbWvLP+5+sepkMPraz137OBWHAuslp671QQXTSWmj7xDj1JnqRQv8wSgTSsDB3Ryg3WMouGdXZvpG/QY7ZEtIxyn7rZT2DMxlmD2JpXJvQTF2Ij08ni2OdBfW75BCD5OvdBhxZRhEZuojdxtUl34mHb+1vHED4WlDcxwg30WT0l7xU7PpO6zUV4UV9GeGsrPg+OCv5neept1L0dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iNtWdHKIZI4w6wjaR6pyRlgkMlnxza8iDGFeAR0uyI=;
 b=HZkgvnKnfeoMmFtU9QK9OSZjdv+iQoFrddBxb2dtT27fWyQHuQ0JMK8wbs2ON8FUsyoJtBOOyWCNwhCwJ9GDwaPMscBVyLczGQDm/prEw6t0uAVBrqZP4V/T8c7cMD1VYJgAU8E/jDjsJPyHqUrHCkcHLqae3OTeIXalrJ66vrP1bMVOQH7mB8gmvmn/eT8sCywzdE0hnaa/0zFgHa03gBHac19xAKs4w+63AmpIIhjrRt3vhU0Vx0SSvZuee6wFNqheiZtheLIa+iN4bmtzx8ihhCoRymSgdD8o9loWUB9ldLE5FjmggG3GNlqXltc/l2Ud9pUYhoWsfQSA9q9ZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iNtWdHKIZI4w6wjaR6pyRlgkMlnxza8iDGFeAR0uyI=;
 b=MMME8FcbwbPiPEGBrUH58NMV7fISI9rmHRCvjtGLF1My5Oc/CMWtDH5ep42Xttpi0NlJMqu3O2pSPVFFO3I2yPl47x4HFdpiu38CHwFthwrE7XsBt+GlRc4951ZuXYTZURPZC5qJPv1NoLJQwj5qpX4WIgqGfqu43swajB4QcnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8225.namprd12.prod.outlook.com (2603:10b6:208:408::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 22:21:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 22:21:55 +0000
Message-ID: <e4ee9257-2f90-4a75-8849-014168bf3b7c@amd.com>
Date: Wed, 22 Nov 2023 17:21:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] drm/amdkfd: add trace_id return
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-7-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-7-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 59265b59-ac61-4049-ea4f-08dbeba96f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dbW41q8LyjTLBrswMNoDSRvurZ3N0UL71ePt8vpZH2mjaIjngm1Eeungp76X4hkusdeM32VphFVjciZxnao3o22HiKPvxdfeRbABdlbN04zXOhJRVaYEgPd/jx2IIOmIra/UWMsRdMY1uJMM8YvzOTPfl4Z9JmoPJi5euSbzxtJp5mDtHUayvhYvT1XefRRaJ6jlsggT9V4ru6YgmLagqwIBTZEJLkkERXIaHyryvEzEKRb0e2nz30RInkFv0zN5BqfJFZmvpMqSN53m9UQqCMbBcbp8K0rtnMjWgYZF6CKwwtmRz9CqfzRYAEs0ZfIhBKQEGGI/TmUFnZKV9Z2HKs1PxjlYBjmQLWexnwVOwPIeKXQUnsYHuOBBhzFe6DU47z/Ak9T0s84BShqguKd/GK6QksrQ6twfFMrvKKp5vxUcUavJxOTIbaz7lH2w7njZ5x9JxyZ3m88dvZCuj13ZRWIXbL+MMAfJDP8zDA5NLKIpYBQLW/2yT73L214ADE9iQji4yqWbdcvnKWidDxlSppH9uNzjvUoEv54HH2GqwVIFp3o0T4sGYnpB5oUNV5A9V/LGnc7xoKzntU1bHHWCu/P+ewVUvoVYxwvBcS9g/6AM6a4vUvGF5EfwsLtn+c61reUIbF4RO0e5c2QVGfhfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(66899024)(26005)(31696002)(36756003)(38100700002)(86362001)(83380400001)(316002)(8936002)(4326008)(66946007)(66556008)(66476007)(5660300002)(41300700001)(44832011)(31686004)(2906002)(8676002)(53546011)(6506007)(36916002)(6512007)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NSZUVCbGhWY2Q2TDhnVUxoSFppK3RzQW50VjJ6Q3JsckNRZVBWZHVxemtl?=
 =?utf-8?B?OFg5Q1ZFNXBJWWRsc3pwaHdDQS9UcU5BTXJENmh1b1BMaU5KSm15aEhCVFZk?=
 =?utf-8?B?SzJKTTY5cnozN0NPY09oVmtBcnNDUTFwdnhYNTEwNUhpbU1pcFp6aFNtSmk4?=
 =?utf-8?B?TVRjQi9GZGVHM3N5YTYreXpGZS9ZVmM2VloyTDg5TUxEeVNESE42VkxIT3NW?=
 =?utf-8?B?WTBQNE9lWVk2aVNpSitvYllVNFo2dWp5QU9tN3FOU3pvQmtYL1NkQmlNYTVm?=
 =?utf-8?B?MVJiOVcvR2dZdW9jT2lucXo4elZWTEFpRk41MXR5bHZqNC8zamlZbHpaMWVs?=
 =?utf-8?B?UVpUNjl1ckw2Kzl3MUJCbWVKMzBQRDhZeWxsb29IQlU4eUhnSmVjemY1d202?=
 =?utf-8?B?aWZOSkQ4WFpleGFvRngzTEZaL1REMzlQVGIyaGErNHF0dnZtREpUMVF6cncv?=
 =?utf-8?B?V3VrUG02ZjJrdWttNEFvR2pZVkxleWtGNU04Q2V5Mlp6WHZqcDRrYnVGVGhI?=
 =?utf-8?B?NDN4OFVDMjhkZS9UOVJHVGtJc1hpYXhNeE1zSTNlMHNSZDE2QUhFY1BMeHJE?=
 =?utf-8?B?ZHhUR0pWQkRMWnBpT3NjMnVUTDhEUzhWb0tkaHBteXJSeEtWb2gwMlVuMEV0?=
 =?utf-8?B?UjFnMi95eUdkcStmenYxdmxZdTZjdnd5N3p0Y0F6L1lrcnpXc21yeFNEcWpX?=
 =?utf-8?B?aytiSWJGdnVWaE5UQmFwMzlzWVArd0hRWjUyZDhoVkhGMzZEM09sWDBuTjdP?=
 =?utf-8?B?QkdiMWw3akg5UEhtNHhLcytObVF3UVkzMDZhdFk3MkRNbWhwZjh0TXA4ZGxJ?=
 =?utf-8?B?K2d6VFlucDZmWlZ0MldzTzBxV21Zb3lqanN1WEkzQjJSbU96SGRwMDRSUU5H?=
 =?utf-8?B?STJIcHdrN1VyTXNWUUg2bWJ3T1J1eTlEN2dZL0cyZmNpTHo0MjBremlEQjZO?=
 =?utf-8?B?a0FnQndaZmNUSWNHbTZPeUUrOVRZYld6NkRWWFFSeE1FUkk2U2R0dFNDSUN2?=
 =?utf-8?B?RGFQOVh6ZldHdnl4KzRLQk5MSWVHTnhTWUVRL3VQWTBRZ05qUzlyWTZ1UGdR?=
 =?utf-8?B?SG5zOEpTMlR6YXgyc3NwOUtFMVdVN3NTbUJEa3ZWaEp1THhUZDh1U0dDWllx?=
 =?utf-8?B?RkQ3eW5rOWg0V2tuU2FPbUd3cGVkd05Eem5GbkNQeUI4dUdKNUZlTkhCNWoz?=
 =?utf-8?B?M0VONUF4aXdIK0hPc0gvS2NNY3Y5YStGRnc1WXQrb2NhdVozRTZ2Y2Q1S2hQ?=
 =?utf-8?B?SXVpN0lRZ1h1TExjb3Z2RWZJY1JGVzlFMzRDNzg1dWRSckZCTUJab21vdHY4?=
 =?utf-8?B?M0R3T1oyb2hHZlUzRHA2bGMwVkRJdnIwa3JHTmF0L2Nac2NLVGp0dzI3N1or?=
 =?utf-8?B?N0h1UXdlZUZhL0trSE9TNFpXb2VZbkxCbHdUbmR2M1RndXB2NVNlNzc2NVR1?=
 =?utf-8?B?a0o1ZFMxMHd1dFFnSjVaVUZkaXJNNzJHN0NjVkZ5ekxrM0RFWGtHbDJVa0U3?=
 =?utf-8?B?eXBWaFpuUUNkSTFpL2NaTEVTREZTamJ0S2VQTnBMU3BhV0V6K2JwVFYyUWNj?=
 =?utf-8?B?MUZaTG1EWDlWUnBWbjlvVDlrdDlwK0dNUC8xcDJ4MDV6MnluRGFxVGcwSGVq?=
 =?utf-8?B?aTBUZEpYZ3hOZVM1TG1FL2RiUGtEajBYRnk2bS81VHRlcUEycmJaMjIwcnoz?=
 =?utf-8?B?blhRQXRmY1laUVNJYktPREpmTGNycWFZVDYrR2pCUWFDRGhBNWhYZmZUQmFn?=
 =?utf-8?B?SkZoaUZQM3ZBTTFSS0lxcEE1V0xpNmd1WjZPSmFmU1hBOUROa21paXQ1S01E?=
 =?utf-8?B?cXRNR2xjbEc4WUtzREVYQ01pQmI3R2dqL1RVaHlrUVg2YTdRQ01pbkpUb0JM?=
 =?utf-8?B?L29sY1hENGIrVW5zRmUvbkNncFF1ZGNscGpBWEN6Q0ZyNXdNM1VVMjZnS0dk?=
 =?utf-8?B?VkpIeFRncnl0QkU4eDE1c0NPVVh3WW1qekFSUmhnMmdFS1daUDFobUxGQU1m?=
 =?utf-8?B?QjVhb2w1L0xxejlmQmN1V1dCM3Byd2lMakV1R1JtcTdkMWQ4b3V3NW9kTytq?=
 =?utf-8?B?T25ocHI1YmJRRVF5U05vTkc0NE1NV25uM20yOUhCUVZWQWNCeXRERFl2QlJm?=
 =?utf-8?Q?nyE5kxBzn2WqSqdTSG0PlHgyn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59265b59-ac61-4049-ea4f-08dbeba96f66
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:21:55.5424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6FygXgpl6eP3YjXGavoF162Ao2fgqiXZ8ARK6fP+cyHcJZK2uKZQ4VvekIUbUSP7VWboocsWoGW0zhfz3owDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8225
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-11-03 09:11, James Zhu wrote:
> Add trace_id return for new pc sampling creation per device,
> Use IDR to quickly locate pc_sampling_entry for reference.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  6 ++++++
>   3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0e24e011f66b..bcaeedac8fe0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)
>   static void kfd_pc_sampling_init(struct kfd_node *dev)
>   {
>   	mutex_init(&dev->pcs_data.mutex);
> +	idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
>   }
>   
>   static void kfd_pc_sampling_exit(struct kfd_node *dev)
>   {
> +	idr_destroy(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr);
>   	mutex_destroy(&dev->pcs_data.mutex);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> index f0d910ee730c..4c9fc48e1a6a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
> @@ -99,6 +99,7 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
>   {
>   	struct kfd_pc_sample_info *supported_format = NULL;
>   	struct kfd_pc_sample_info user_info;
> +	struct pc_sampling_entry *pcs_entry;
>   	int ret;
>   	int i;
>   
> @@ -140,7 +141,19 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
>   		return ret ? ret : -EEXIST;
>   	}
>   
> -	/* TODO: add trace_id return */
> +	pcs_entry = kvzalloc(sizeof(*pcs_entry), GFP_KERNEL);
> +	if (!pcs_entry) {
> +		mutex_unlock(&pdd->dev->pcs_data.mutex);
> +		return -ENOMEM;
> +	}
> +
> +	i = idr_alloc_cyclic(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
> +				pcs_entry, 1, 0, GFP_KERNEL);
> +	if (i < 0) {
> +		mutex_unlock(&pdd->dev->pcs_data.mutex);
> +		kvfree(pcs_entry);
> +		return i;
> +	}
>   
>   	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
>   		memcpy(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
> @@ -149,6 +162,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
>   	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
>   	mutex_unlock(&pdd->dev->pcs_data.mutex);
>   
> +	pcs_entry->pdd = pdd;

One more thought: You have a bunch of pcs_entries pointing to pdd. What 
mechanism guarantees, that the pcs_entries are destroyed before the pdd 
on process termination? I think kfd_pc_sampling_exit doesn't run during 
process termination, because it deals with per-device data structures, 
not per-process data structures.

Should the IDR be in the PDD rather than the device? In that case you 
wouldn't even need the pdd pointer in struct pcs_entry.

I see you have a patch much later in the series "drm/amdkfd: add pc 
sampling release when process release". I'd prefer this squashed here 
and in the patches that add the start/stop functions.

Regards,
   Felix


> +	user_args->trace_id = (uint32_t)i;
> +
> +	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 81c925fb2952..642558026d16 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -258,6 +258,7 @@ struct kfd_dev;
>   
>   struct kfd_dev_pc_sampling_data {
>   	uint32_t use_count;         /* Num of PC sampling sessions */
> +	struct idr pc_sampling_idr;
>   	struct kfd_pc_sample_info pc_sample_info;
>   };
>   
> @@ -743,6 +744,11 @@ enum kfd_pdd_bound {
>    */
>   #define SDMA_ACTIVITY_DIVISOR  100
>   
> +struct pc_sampling_entry {
> +	bool enabled;
> +	struct kfd_process_device *pdd;
> +};
> +
>   /* Data that is per-process-per device. */
>   struct kfd_process_device {
>   	/* The device that owns this data. */
