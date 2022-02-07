Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1E9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 15:43:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E5C10E127;
	Mon,  7 Feb 2022 15:43:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E518210E127
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 15:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKU76yiXkp6k9IpeEWGCeAxtcajMuCx71hb8QcR1kI52X4P8kcqupOIXAeweXt00ln7ezItUDrhBt4V29t9Dh6mNukQCh6ICfsfGFGtN2bWlDr4Wmr6LQ8+QS3jPb8IcgenitXq4zeMq4q19KtVYTjhkmAovfZ55GLzLW8lOVuEZJA8I875TQJA3FBc3pTNXVnJYrnVf+YL3V/5v8TfzCsSXbpPh9cWSTBjW3Zj+zTMzvwjKWpiYk69ND8mKtnXrzx4fFLWh0xUXd3Gy1mfCJAwm0xvjrWG8DGjYAHXzsl+0dk8o9deGfp+9muE3c60Jk11aKejMrWjcauUG+nhg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvCjock+zueRBaH2VFUSKMB/cU+mH6xCB1qa6uF+DXQ=;
 b=CKxxuCvdPaqs/umKyxqCINI35pnkxHF/tNFvBedhAv03hdh2/qnP6s2s4UL5pv475roGAVGBaYol+giWNqOSw5nS+5M8lzMya9KUEv/sRNcrL8nVruv+q89EiqCJnBacLNpw54kQVwhKIW7wdqUFdLi7itzxgqza/6oAW9qYSCpI8ALjD85l07hghjxWcn57BFvckoThFaGCTzAQNwbXWvgmNpJL1C5PhOyt5ce4v5SPS+F7pmP0OIjM8zzRy5sFRxs4tYQniyNUhfS4f0gfUgwKZeGTVEG+2ksjUxiIM7uTxxXlYghM/wQgMYuDO3WwwnXmVzcpCZtx/nmEyzL4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvCjock+zueRBaH2VFUSKMB/cU+mH6xCB1qa6uF+DXQ=;
 b=pyEPAaqgdCMX4Msk/vJdeC1KtEivLIKRv5UQWKUmvERFfMlQ1mAkuIAebtvLUNrKZagq7+U7Ac3t6IW8QN+mesEwa+IXH0iwnyyS6VzQH1VdQtjVGcZYjWMWRZA7qoFwEhrlvVWncxW440Lf3JkmZ6PE/tZ1NZBkmKTqTjQnjVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 15:43:11 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 15:43:11 +0000
Message-ID: <68544466-9816-e94d-2506-19a378b38a9d@amd.com>
Date: Mon, 7 Feb 2022 10:43:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] drm/amdkfd: Consolidate MQD manager functions
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220204234513.11714-1-mukul.joshi@amd.com>
 <20220204234513.11714-3-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220204234513.11714-3-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e836996-c5c9-49b6-1433-08d9ea508b8b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3805:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB38059CDD415AA919C13D47A9922C9@MN2PR12MB3805.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgnMxWYpCO+a82O7AzWvOopXT88QeWYe4fj/YqQ9ufDqXS47EEjstOJLkttvZ0rDS79K5/KJRBp0/7O/i/S1rAKRxkYCCAVVKt8tLMF3KLpQ0n3WY7g0/hUj8E9qax1/VYwdups55zi8V5tS3QDe0bvIrNvc7oExZx5EroHthip+7Xen9y+JVekOYS51GBO1dmYT7ebZkXsISBOaCjFPEyM5Fd4mvy4qyxIw6/Ou2AdwTz3dNFyZhvIAfv1hy4pvpcNdlS6bx88TLs3gWQnFNbK3I2ZLmaqGyws7DPpIvE2oGthkFsQsBwGsKzxAaCMIUdCyf52FzNgFokSkUvLsHtXIfFa8dRX/RgUZIel99HyaTbLcoiZXEOnVvqTRO1taRtjwvUGXsgZUNxFWG8bHv+4bu/BvHWte3vpDJbMGeDYfyj1MqUg8EUo/XXZrXrNP64AG6AdiN7Ufk9z9iu0uUb/DQ88yJtKlkLncfJTR7Vt6MqsSBq5CDHp4a/Ebu7rFKP7LF3gzQ64LfiOuAEjIgyYa1v/UIcZgGXe07I5Ks19SOvcfpp1f7gmxNF1ykuELjM2o47b8bOTtuyXQL3h4RyKXh1PgS+DBpNjRRNOHeSY2cgTYggQS/Cx9aPEuMEWr2G7h4vzv1nK4+G8tL/9i7Iomra7N2aKcTvnvV9qZOHWxiN7lpVCf+NulzaQLwNPZVAwv+/ya0/LAqR3P9JRZeiGHcoQr6q8x5QoQwnkWkZiJRTuxNNWDemi/gjaeaERe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(2616005)(38100700002)(30864003)(508600001)(186003)(2906002)(5660300002)(6506007)(6512007)(86362001)(31696002)(36756003)(316002)(66946007)(8676002)(66556008)(8936002)(66476007)(31686004)(44832011)(6486002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXI5M1dGUjZuM3haeDVGTWhKSjE2TXJnbFppdEcrMHpXZk02eVIwdnJJTHlC?=
 =?utf-8?B?d0R2Sjd5QjBKSUx0UWdpRmMzeTloZ2VIRGNTTi9pRlNhVkFLZ2l6d2twRDRQ?=
 =?utf-8?B?aXMzcnd2TmJ6eDlrQWZWVzVBTHNFeWJZNzBwTXlUVjFzTkFPWjFPc3NDTFBH?=
 =?utf-8?B?ZXE0MGM4TGNkVXc1YlhnajNJRXdwM3FjVXM5eFNVVVNSa25LcVM4c052dTNT?=
 =?utf-8?B?Zi9CYThiemVTSFFWU0w4dXN2ajJnV2JiVFN4ekp4R0o5dExSRkVZak1JazhV?=
 =?utf-8?B?bnEyV0pHN21GY2YwRlMzTXRjRnJsODJDNzBXUHFQZzFWS1A3WUlxKzN5akI5?=
 =?utf-8?B?OTRBRXlQaEhjZzM4Vk5rUXM3b1RnOU1VeGwxUVpoaHMrV1hoSjVZQ24wMzkz?=
 =?utf-8?B?S1VlY2x5UldJRkRuQmVDdG1hSy95STQ0d0NCWVBUZUg1azdyZzJVT3U1OVpJ?=
 =?utf-8?B?M1NvR3R4cFFXSFJIM2lOVVhoYXVLb1ZSSnFyNzNhUkpvQStBeURzOEQrRE9I?=
 =?utf-8?B?TDRYMGJOWkdEakh6aHQ3b1R6MWZBVE92OE9BUGtWcmE4eE8zZHFWdnBVT01Z?=
 =?utf-8?B?UWptcU9haHRKeit6aVcwQ3J1bktOM2pjSTBQWU13N0pCcVB6K0NwbWlTQU5u?=
 =?utf-8?B?MEhZYWU3ZmI3bHZmNHNseUdxd3I3WGhMSjdDNGw1dnJ0UTVMaDI1MURBZUls?=
 =?utf-8?B?SE5ieitUV0lQSlBNT29Ga1dHZ1ZkTjJPMWNIb1duRUFXbnBDbzVidk1sdlBh?=
 =?utf-8?B?OWxhdE9uZjRNeDBMeCtRR20vVzlDTHlwRmRsbEVzVW9CN3lEY3lTZzhWc1VR?=
 =?utf-8?B?ZGNDT0QvVFR3cWQ2MDg4Z0FjRDA5d0YwYW52dlZYYTdKMTFRRXpzSDFnODlC?=
 =?utf-8?B?VUNRQ0F5SnhaZThCZ2VheEZDc25iWWZCTTBIdkQ0RUJFVVkwTG0wVDN6aHND?=
 =?utf-8?B?SElidWNlNnROaXYybXlheFlldGRGZDR3SVBFV0UrK2hzVkZnajR2VENpV3ln?=
 =?utf-8?B?TUhnMkhORnJiQytqS3JPRzhBOUwzcnFLNDBvUk9Na2RhcmVjbUJXc2w4Yzhi?=
 =?utf-8?B?b21uRFA2bko5Mzd3d0FwcTJJNVh4UjNuRVhSQSt4alJpdkUycFE0dnRhK0NJ?=
 =?utf-8?B?dmZ1SHlycWZsMjNXV1NYQjNnQTRtbkJIMzFwOVRUUEpJd1JNUVNwcStEU0RW?=
 =?utf-8?B?SEhPTXFNbFV3bk5EUGhlOWdic09lZ0pLZVhNZ1o4V1N2QkRkdFQ3clJySGF6?=
 =?utf-8?B?MkIxWmhPZ3AxaEl2SFAwZjB6cVVvdmcvNU9ndzl0ZG5oaUdKbmpQN2JMVndj?=
 =?utf-8?B?LzNDU2haOG5ENUl5cUZDRzVVY1pBNElHSEkxOXk0aHIvUnZ1TnpQOU1KSmc0?=
 =?utf-8?B?dHRqSG5sRlVXWm9YUm54MHhqbEdyazI0NHE1WGdhL0xOQXI0aUh5ck1SR2sw?=
 =?utf-8?B?MHVqcCtvOGxxNTZoM1RKeVNCMUNxWVc2NGdzMVRDT2U5K0UwN1FUNU9PTUw0?=
 =?utf-8?B?dHVDUkdVUUt3WXRQVWZFQzRmTDVZdkd1Z29YblNYdXdmS2tMZFBoUk9OUXc3?=
 =?utf-8?B?Vm5iT2lPMXJwOHNOdm5Tb0RXNkxlRHMzZkViY0NZNW8rdzlreHZKZW9LQVpE?=
 =?utf-8?B?OEtrVk5kai93bGtlZkhWVXBXMU90TUVyWER4ZEpmSDFDeDlwRmwyakhTdVk4?=
 =?utf-8?B?aDF0eG92cmdINWxyM3l1V0dBTEJoaXZUbjI1YlJ3U2IrVXRCNUJYUExjdWFN?=
 =?utf-8?B?S01lWXFsWGg5dmpEZmNmM0FNWitoVm1nVTVmdm5sOUpDRTk1VHh4N0hoRTI4?=
 =?utf-8?B?SDZtN3dvYUFsOU9OMkU4RVNwZkZya0VISEdtYU95V2tub2lZM2hPa2ZsVkE2?=
 =?utf-8?B?NWQ1ZnlwdmE4dDU5c0RBNTRJV21NLzRMZ3h0c2NWbXdRWG1RSU9xTEh2K0VU?=
 =?utf-8?B?UG1MYVhhS2dsd1RiM0t5WWVzQzVIaEI4ODQzYWkva1ZwcXpCdWJVVGxKcXFq?=
 =?utf-8?B?djdDQzk4UmZNNWQ4Tk9TZmM2U01HVi9pT3QyNlpoY2JvbTJ2OVRiWDRrQm1P?=
 =?utf-8?B?RmorQTg3VmpvaWFxSHpsb3FOeGIzNWh2cTVqSk94MnllNHdYK3N1V3dCQmNQ?=
 =?utf-8?B?WmM4ZDlQWVE2YzI2NkNtZmxBdTFiRWNhWUpaMC9JOHJyK3RDZ2JHRWxuQ0pB?=
 =?utf-8?Q?MGOuUGLldMIPbJ4bQEOqVwg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e836996-c5c9-49b6-1433-08d9ea508b8b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 15:43:11.0785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWsb0yvBRUDbseLWSujfsktQ65H0851oCjrdtRUx/c0Vtnvg39MJ6YZlAN2AnegIMV3WKM+3h8yuCijtJVBB+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
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


Am 2022-02-04 um 18:45 schrieb Mukul Joshi:
> A few MQD manager functions are duplicated for all versions of
> MQD manager. Remove this duplication by moving the common
> functions into kfd_mqd_manager.c file.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 63 +++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  | 27 ++++++++
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 54 ---------------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 61 -----------------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 68 -------------------
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 53 ---------------
>   6 files changed, 90 insertions(+), 236 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index e2825ad4d699..f4a6af98db2d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -173,3 +173,66 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		}
>   	}
>   }
> +
> +int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> +		     uint32_t pipe_id, uint32_t queue_id,
> +		     struct queue_properties *p, struct mm_struct *mms)

Since these functions are no longer static, they should get an 
appropriate name prefix to avoid future namespace collisions. Just a 
kfd_ prefix will do.

I think there are existing functions in this file that could use the 
same treatment (in a separate patch).


> +{
> +	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
> +					      queue_id, p->doorbell_off);
> +}
> +
> +int destroy_mqd(struct mqd_manager *mm, void *mqd,
> +		enum kfd_preempt_type type, unsigned int timeout,
> +		uint32_t pipe_id,uint32_t queue_id)

This function is only applicable to CP queues. Therefore I'd give it a 
more specific name, e.g. kfd_destroy_cp_mqd. Similar for the other 
non-SDMA functions below.

Regards,
   Felix


> +{
> +	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
> +						pipe_id, queue_id);
> +}
> +
> +void free_mqd(struct mqd_manager *mm, void *mqd,
> +	      struct kfd_mem_obj *mqd_mem_obj)
> +{
> +	if (mqd_mem_obj->gtt_mem) {
> +		amdgpu_amdkfd_free_gtt_mem(mm->dev->adev, mqd_mem_obj->gtt_mem);
> +		kfree(mqd_mem_obj);
> +	} else {
> +		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> +	}
> +}
> +
> +bool is_occupied(struct mqd_manager *mm, void *mqd,
> +		 uint64_t queue_address, uint32_t pipe_id,
> +		 uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
> +						pipe_id, queue_id);
> +}
> +
> +int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		  uint32_t pipe_id, uint32_t queue_id,
> +		  struct queue_properties *p, struct mm_struct *mms)
> +{
> +	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> +						(uint32_t __user *)p->write_ptr,
> +						mms);
> +}
> +
> +/*
> + * preempt type here is ignored because there is only one way
> + * to preempt sdma queue
> + */
> +int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		     enum kfd_preempt_type type,
> +		     unsigned int timeout, uint32_t pipe_id,
> +		     uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> +}
> +
> +bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> +		      uint64_t queue_address, uint32_t pipe_id,
> +		      uint32_t queue_id)
> +{
> +	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> index 23486a23df84..76f20637b938 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -136,4 +136,31 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		const uint32_t *cu_mask, uint32_t cu_mask_count,
>   		uint32_t *se_mask);
>   
> +int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> +		uint32_t pipe_id, uint32_t queue_id,
> +		struct queue_properties *p, struct mm_struct *mms);
> +
> +int destroy_mqd(struct mqd_manager *mm, void *mqd,
> +		enum kfd_preempt_type type, unsigned int timeout,
> +		uint32_t pipe_id,uint32_t queue_id);
> +
> +void free_mqd(struct mqd_manager *mm, void *mqd,
> +		struct kfd_mem_obj *mqd_mem_obj);
> +
> +bool is_occupied(struct mqd_manager *mm, void *mqd,
> +		 uint64_t queue_address, uint32_t pipe_id,
> +		 uint32_t queue_id);
> +
> +int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		uint32_t pipe_id, uint32_t queue_id,
> +		struct queue_properties *p, struct mm_struct *mms);
> +
> +int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> +		enum kfd_preempt_type type,unsigned int timeout,
> +		uint32_t pipe_id, uint32_t queue_id);
> +
> +bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> +		uint64_t queue_address, uint32_t pipe_id,
> +		uint32_t queue_id);
> +
>   #endif /* KFD_MQD_MANAGER_H_ */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> index 96e3303fa27c..81b6b3d5f2e7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
> @@ -156,13 +156,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -}
> -
> -
>   static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
>   		    uint32_t queue_id, struct queue_properties *p,
>   		    struct mm_struct *mms)
> @@ -176,15 +169,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd, uint32_t pipe_id,
>   					  wptr_shift, wptr_mask, mms);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -			 uint32_t pipe_id, uint32_t queue_id,
> -			 struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   static void __update_mqd(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q, struct mqd_update_info *minfo,
>   			unsigned int atc_bit)
> @@ -271,15 +255,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -			enum kfd_preempt_type type,
> -			unsigned int timeout, uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy(mm->dev->adev, mqd, type, timeout,
> -					pipe_id, queue_id);
> -}
> -
>   static void checkpoint_mqd(struct mqd_manager *mm, void *mqd, void *mqd_dst, void *ctl_stack_dst)
>   {
>   	struct cik_mqd *m;
> @@ -351,35 +326,6 @@ static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	qp->is_active = 0;
>   }
>   
> -/*
> - * preempt type here is ignored because there is only one way
> - * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -				enum kfd_preempt_type type,
> -				unsigned int timeout, uint32_t pipe_id,
> -				uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -
> -	return mm->dev->kfd2kgd->hqd_is_occupied(mm->dev->adev, queue_address,
> -					pipe_id, queue_id);
> -
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   /*
>    * HIQ MQD Implementation, concrete implementation for HIQ MQD implementation.
>    * The HIQ queue in Kaveri is using the same MQD structure as all the user mode
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 0cc8679c24fa..8324757a1cf5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -154,14 +154,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
>   	return r;
>   }
>   
> -static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> -			    uint32_t pipe_id, uint32_t queue_id,
> -			    struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
> -					      queue_id, p->doorbell_off);
> -}
> -
>   static void update_mqd(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q,
>   			struct mqd_update_info *minfo)
> @@ -233,31 +225,6 @@ static uint32_t read_doorbell_id(void *mqd)
>   	return m->queue_doorbell_id0;
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -		       enum kfd_preempt_type type,
> -		       unsigned int timeout, uint32_t pipe_id,
> -		       uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy
> -		(mm->dev->adev, mqd, type, timeout,
> -		 pipe_id, queue_id);
> -}
> -
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_is_occupied(
> -		mm->dev->adev, queue_address,
> -		pipe_id, queue_id);
> -}
> -
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  void __user *ctl_stack,
>   			  u32 *ctl_stack_used_size,
> @@ -352,15 +319,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		uint32_t pipe_id, uint32_t queue_id,
> -		struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   #define SDMA_RLC_DUMMY_DEFAULT 0xf
>   
>   static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> @@ -390,25 +348,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -/*
> - *  * preempt type here is ignored because there is only one way
> - *  * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		enum kfd_preempt_type type,
> -		unsigned int timeout, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -		uint64_t queue_address, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>   				void *mqd,
>   				void *mqd_dst,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 87da4329dbf2..007886b2961e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -204,14 +204,6 @@ static int load_mqd(struct mqd_manager *mm, void *mqd,
>   					  wptr_shift, 0, mms);
>   }
>   
> -static int hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
> -			    uint32_t pipe_id, uint32_t queue_id,
> -			    struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hiq_mqd_load(mm->dev->adev, mqd, pipe_id,
> -					      queue_id, p->doorbell_off);
> -}
> -
>   static void update_mqd(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q,
>   			struct mqd_update_info *minfo)
> @@ -285,38 +277,6 @@ static uint32_t read_doorbell_id(void *mqd)
>   	return m->queue_doorbell_id0;
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -			enum kfd_preempt_type type,
> -			unsigned int timeout, uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy
> -		(mm->dev->adev, mqd, type, timeout,
> -		pipe_id, queue_id);
> -}
> -
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	struct kfd_dev *kfd = mm->dev;
> -
> -	if (mqd_mem_obj->gtt_mem) {
> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, mqd_mem_obj->gtt_mem);
> -		kfree(mqd_mem_obj);
> -	} else {
> -		kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -	}
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_is_occupied(
> -		mm->dev->adev, queue_address,
> -		pipe_id, queue_id);
> -}
> -
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  void __user *ctl_stack,
>   			  u32 *ctl_stack_used_size,
> @@ -422,15 +382,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		uint32_t pipe_id, uint32_t queue_id,
> -		struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   #define SDMA_RLC_DUMMY_DEFAULT 0xf
>   
>   static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
> @@ -460,25 +411,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -/*
> - *  * preempt type here is ignored because there is only one way
> - *  * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		enum kfd_preempt_type type,
> -		unsigned int timeout, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -		uint64_t queue_address, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>   				void *mqd,
>   				void *mqd_dst,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 137b208135a0..c0405bbe8e36 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -259,31 +259,6 @@ static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
>   	__update_mqd(mm, mqd, q, minfo, MTYPE_UC, 0);
>   }
>   
> -static int destroy_mqd(struct mqd_manager *mm, void *mqd,
> -			enum kfd_preempt_type type,
> -			unsigned int timeout, uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_destroy
> -		(mm->dev->adev, mqd, type, timeout,
> -		pipe_id, queue_id);
> -}
> -
> -static void free_mqd(struct mqd_manager *mm, void *mqd,
> -			struct kfd_mem_obj *mqd_mem_obj)
> -{
> -	kfd_gtt_sa_free(mm->dev, mqd_mem_obj);
> -}
> -
> -static bool is_occupied(struct mqd_manager *mm, void *mqd,
> -			uint64_t queue_address,	uint32_t pipe_id,
> -			uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_is_occupied(
> -		mm->dev->adev, queue_address,
> -		pipe_id, queue_id);
> -}
> -
>   static int get_wave_state(struct mqd_manager *mm, void *mqd,
>   			  void __user *ctl_stack,
>   			  u32 *ctl_stack_used_size,
> @@ -385,15 +360,6 @@ static void init_mqd_sdma(struct mqd_manager *mm, void **mqd,
>   	mm->update_mqd(mm, m, q, NULL);
>   }
>   
> -static int load_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		uint32_t pipe_id, uint32_t queue_id,
> -		struct queue_properties *p, struct mm_struct *mms)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_load(mm->dev->adev, mqd,
> -					       (uint32_t __user *)p->write_ptr,
> -					       mms);
> -}
> -
>   static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   			struct queue_properties *q,
>   			struct mqd_update_info *minfo)
> @@ -422,25 +388,6 @@ static void update_mqd_sdma(struct mqd_manager *mm, void *mqd,
>   	q->is_active = QUEUE_IS_ACTIVE(*q);
>   }
>   
> -/*
> - *  * preempt type here is ignored because there is only one way
> - *  * to preempt sdma queue
> - */
> -static int destroy_mqd_sdma(struct mqd_manager *mm, void *mqd,
> -		enum kfd_preempt_type type,
> -		unsigned int timeout, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_destroy(mm->dev->adev, mqd, timeout);
> -}
> -
> -static bool is_occupied_sdma(struct mqd_manager *mm, void *mqd,
> -		uint64_t queue_address, uint32_t pipe_id,
> -		uint32_t queue_id)
> -{
> -	return mm->dev->kfd2kgd->hqd_sdma_is_occupied(mm->dev->adev, mqd);
> -}
> -
>   static void checkpoint_mqd_sdma(struct mqd_manager *mm,
>   				void *mqd,
>   				void *mqd_dst,
