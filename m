Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2100C27C40
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 21:56:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1D610E31A;
	Wed, 22 Nov 2023 21:56:31 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760C310E31A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 21:56:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlEyDDSGgRBEudBwWecE+BaN2OY4fKTXNjfvWIdNpTfdssuz3hSQdWwCz52+DOPsLG0/SVxR7/K5Boz1sgoVJPpbIEAvLf++Pt2TUsGauFH/anydsOfNn5V6OiPb7T+mdCg+vlWU4OWsXRckC0kd2r2ZjVKSO2PeepacWXLEStqbpvIBfBid5hNJmskAgDhb8GgNr8cK3ftTR4mt/ag/bQgqWkW+yPYctnu/7bHr05h0V0T90xYVw2XOi5Wz+fr71ZslXlyh1f+ag+iwWwFtqma4SlQnXHDFfCcrItp1qbHRBWp8CriutNodMFUfMJHz5nPZ9vVUiv0kkBrsNdhx9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCFpnX/+xwk9E5K4bNMdhN3XTPc/6IP4w1qqiuUdq+M=;
 b=VgdihDRze9AsWrBseOWrcoLcNoAnxfHhwALdwfk3E1Z/QaDwMAOYfy5yMJ0EPVgrFud0bTKTzBONHhIv0P+IQCHcIni2VmLDIr5xs6ZbKV+cPI22I+aFVfuW0DoGtwufOIsbQiYT5M+SmPa9WkIHTIiWT5zcF3LwjKg7Izgqc3KP1gH4HXy1XM4PKwmCUY+KZZS6wSw3lR6BItwHqAeDOsz+Kb/z7sKEcW69Fg7RMRwsyYdQky6212anfs+SWbh0LqVnzDrR8ZOcrOrjq1IaCpDyBnA+8tNc04E7ibR1QXzG37lN0W68+WO37Z9E7+1kyfoGdTg3WbQLAVayA4RIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCFpnX/+xwk9E5K4bNMdhN3XTPc/6IP4w1qqiuUdq+M=;
 b=TxQlGxk9nYXZiO1gzKBOE0d0dHCBQpxYER1C8Tbw5uw1xfyMmp9Rn3IEKcVUXsMR+ldIm2wk+ZioAVVeeB8w7FM6T0nd0ln3o6mKDfh4naiWD5rq4R4M90/rzeHT4oB4ZuAz1KamQEeoH/E9cF4FKYSgTq3cPkYIibM5Vjby2Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 21:56:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 21:56:27 +0000
Message-ID: <92ebc9da-a504-4794-a93a-52565ac66333@amd.com>
Date: Wed, 22 Nov 2023 16:56:25 -0500
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
X-ClientProxiedBy: YT4PR01CA0225.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: f1257098-3f0a-42f0-15f1-08dbeba5e07e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mveg2LTmD+4Z2IN4LYS6ufk3+n2d3sgfQ1pO0B05MJbD9FreE1en8Zr2WSZ8VJQ3IydPOn0OTrBaHPWO790ObZC6soPzwKxHxqusYZ67QOCDi5d+ovVKmDttVAmn2JufZ0Pfke/J5TqiFdIpG/d2/2tVhtyjOG4SKy9na8Na7wk4oGCE3+Pgu4S314e9TmlpQafHEYeU/iMU65OjgcdR0fj+eIbPyNeMKfYfnKIJ1QRtxweL0O+R/yYqi1eeqgPKXU/xPsWLYmWuYDJ8wyyYcrm/P6cI8i9P9Xy0g239agvUOGhLu1spSqoxNi+0ie687oNgXzu+aIfhXAQ0H4VlVWsucyu9hbPKgbwz4EPNpkLTHMrQfV+58iC5pIN8yE0AfENZbHI63vBN7hNbFtPXbxpekuOMsw7AQtc3VMhnLGgaHo+B89v/pxyhq2JdYTSrTlrT/c/som5FkQsIaymoyRz5b1sx1sjd0DIEF6OzYRV8WxqoRjuWIaHfqrkUqlNeyrMYsHt/tQHYKhFd+WNWsRu5CKAvXRo2UoWIsp/aSCpFizBk2n1Hr91URrsnAiFOvsivw+dDAsuI3vOqivgFSHo0Lt6B9wmEP0XnJYhDPGzigj2u5+qRZXNoksIUPU3DNSPNp0EkBi5AiTz4oMMCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(316002)(66556008)(66476007)(53546011)(36916002)(41300700001)(66946007)(26005)(2616005)(4326008)(8676002)(8936002)(478600001)(6486002)(6512007)(6506007)(31686004)(44832011)(5660300002)(83380400001)(2906002)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUl1SWlCa0hUWnZBb3U2WHphcURtczFqY1NzYWZRb1JJUTBkM0h4U3k0Nytm?=
 =?utf-8?B?ZDFjMWxEV1RSVGZSZHNBdHY1K2NyVU1qa0VRRHA4aXN4cXF4eDIvYW8vazBZ?=
 =?utf-8?B?WjdubjdGay9EMlF0eXp3UW9YcWFmSWlWU2poclVjNXZZN2NKL3FjMTJKUUd2?=
 =?utf-8?B?MmdIamJieGl1WEV2aEhFQUhPalBzdnNPakYvZzdoUnVRdkI4NElQK29WUEpM?=
 =?utf-8?B?YnJabnEwT1lWNjY1ZTNIczNML2lZNHRFSVhpcGRoTUVlZ3liWnBqQkNiNmtR?=
 =?utf-8?B?MEJWMThpMXlIbHo1b2xSS3JqZG1iQkYxL242T05DNEptMXVUcFE1RkkzMUhp?=
 =?utf-8?B?NUliQ0NMTnRzZUhUbnBlTUZCRmZiK2VIUEZKRVhsbDFBTnU4eGt6eU5qZTBI?=
 =?utf-8?B?eitFaHBzbktWMnl0UkpqY0N6cDhBemsrMTNXRmRNMXBBbW9YbjhjVDZWNi8r?=
 =?utf-8?B?VlBVN0cwUVBpc2lEUTd0NGRXV2tXZU8yYWFITm9nZUZ0WEJnZWpMR2lDZ2xU?=
 =?utf-8?B?UEdvTWx6TEpPYjNQNGVpb3dkWEhzMm9HWmoxMGdiUUlzVjBuUkhYSXZhSkYr?=
 =?utf-8?B?c09jTWExVFhMT1kvczQ5UEE1bHJZN3JnN0ZaS2ZBY0hyNGlSclpLN0srL2t1?=
 =?utf-8?B?ZEZmbncwblVheGx5U21JQk5ZbGprQlNFWE55RXpkUU14NlpzQU52bW8zVWhl?=
 =?utf-8?B?OXJGdlhta3ZFNmRVdEpjSXFkVXNXQ2k1Y1dnYkhNaHZwVXR5d2o4Vklhb21O?=
 =?utf-8?B?bUNJcnNZL3dQNi9OK1BtZGtiL0RwcUNsN05KV0JUcDVVN1VrMTFKQW9JZE54?=
 =?utf-8?B?UFdrNWRSd1QxZGNsZk1zM0xhYVQ4QXZGbnFML1kxTmE0bkt0elJPVVp2SWhQ?=
 =?utf-8?B?d3VtcEFCb0ZlaXFEc3VRVk9YOVFaZ2R5czBqSlM1dHlTR2JYbThiZjNTYnow?=
 =?utf-8?B?d3NMcE1jUGY4dUQrOW9wWUQxTlpqdFFmend5RzlNWnJxZVZiVVRWZkVvVjlL?=
 =?utf-8?B?cElUWGZ5a1ZQZTdCRklCUGRwVXJoem9hTGh1YU1DRksveXlGQUNtQmVCU051?=
 =?utf-8?B?MkF4NG56SnN3M0FZUUZpUjRnVk80Wk12TElhRW4zY0VGYTZpSjNSVTJBRjh4?=
 =?utf-8?B?djc2OVJ2V2ltai9ScFF0Tm5tOFl5UXhWdlBPaExmdld2aGpXeXRJeVJSTEhz?=
 =?utf-8?B?MUV1V0pHNU02RG16bE1QWEhNalpUK3NHRVdYa3hLUjY2TDRQK3hUR09Sam1v?=
 =?utf-8?B?TTdpR0psUkkrOU1FcUNQMURNaUloVXZzV1FmdXl4K01RSjVvdWd5VHBUTFVs?=
 =?utf-8?B?OXppcXpQcEVwVWRqUXNnOXE4SEVLQW1sZklVMXZhMkxja3I5NGdUd0NxaXJG?=
 =?utf-8?B?UUVnS0RSaXc4WmlvQUliQ1JuN2hKOFFRem9DRFpWRXJGeHFzRy9FTmZHaVZp?=
 =?utf-8?B?dmpxYW1SVVhRRmpDM0RUNVVkWGN4elRvQlIzcXRJQW1jWTFNYmk5YzBVK05F?=
 =?utf-8?B?OVZqd0toQTJOd2JGaldTYWFKNTY4RnR6WWwxS3dFZll6NStSV1pIMlRibWNB?=
 =?utf-8?B?cGlwWTZtNXE3TWdwMUFDZDA2enBqaDFzTzZwTzgyaURZcTQyRUw2azd5Z1Fn?=
 =?utf-8?B?N0oycEhCckcvWi9tMjlad3pwdVA4Zno0VjFwUGppVjVaUkEvdGRGTnUrTGM4?=
 =?utf-8?B?RVlWNEhUeDREcjZVOSttcDRpRytVRHpraHNORmlqZWVoZ0pyQU9hMCt1Ykw5?=
 =?utf-8?B?bWJpMkpRbjIvOWN3cFFrVmxaTzdwaHhkRGRLSm0ybVBTbmJ2VGVEMHMvbnZ5?=
 =?utf-8?B?bU1PUGpLWmpzOXZXRmFyR1UvSE1NcktSOUFLRDhJN1JXdkIyYXhMOEt3TjV0?=
 =?utf-8?B?TFcxdFlWNWI1a1JOR3paSm5YRCtmUU5iOEgrQ3FwZlhlOXE5d0gzZ0tYQkJk?=
 =?utf-8?B?cW1EWDljeTRrSnRWREpXVS9zUkU1UUY1N1doUjRGbHorRGFnam9OYWptakEw?=
 =?utf-8?B?a3pycisySkNTOC8zOHpjOTJQejJQb0plVjZJT2wyQTRnL0EvUmgyY2JzZTRx?=
 =?utf-8?B?bHlWaE1RaWhVa3IzVGRVTG1kcldQbG5ZaS9vNGZJak5YVnZscE03bVBDcmZ5?=
 =?utf-8?Q?wX1dae6LHe+tWLXjf7P9tEs8G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1257098-3f0a-42f0-15f1-08dbeba5e07e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 21:56:27.3634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5o7PM/fEu5K3t7rt+c6y8OyalIlcI5S/tHhmG+wuIj9CCUlcNvJKaB9CR70eB2fgVcmZmxE+2S+rVx3Nk6r5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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

I don't see a reason to use kvzalloc here. You know the size of the 
structure, so kzalloc should be perfectly fine.


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

kfree


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
> +	user_args->trace_id = (uint32_t)i;

I suspect this should be done inside the lock. You don't want someone 
looking up the pcs_entry before it has been initialized.

Regards,
   Felix


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
