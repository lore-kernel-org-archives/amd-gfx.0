Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AF9C83F01
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Aug 2023 20:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C315F10E149;
	Wed, 30 Aug 2023 20:37:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FE110E149
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 20:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YABcppHaoAOxqMNkOClNoUUZ1sNxTh2SWO7SsLAdXTlJWPv8A2TdnKjP3AA2qixOVkzHIE/BRFt7bitNaqwMTQ+NBOvLAK4180trrJuXswde73ZEc54ZAdzjUBAaHI5OB82lFdGSbC7YjOgdoE0T1H+58muvbcr+9yfDmMm6Q3SxshgqY3dzhgw6z6KIGrOgc1mYLZYJ1VjE3Bh4Tm6BSNaxEdPmXtKzh8af8bEIOXWF7CzMsOa09zbUqA9gFlVJaCnT4Kz9IHAJp/22LrUnqQ8J9VqQaR1bwQySHNT3LtqsKpfSA2n4XIUN8ncDl4iwCQX7u/GeJMc2KSO9xQ44Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KO9EVGRUNX2MUi6Yxz+IpozuWQDizX8TDmRH9N+O42U=;
 b=bAOD3JcQ0fARPELdb93GvaN9qgYVqbvAH0cGZpKGpJJlPa+4D+s1mHSLef+BSTItiEOiJ+XU8XnegQz155sNx+h38fgG/6h021YZue2UapwS+TzA4VUbhui6H1BW6II4twRatgSG3ZhVMZ18x1bYRIvSWrBrBFVDXGKxTeT9Uyp9gLYDj55ZNHTllkzAOPTWlduQWGxtl8iKq8R0RIe42HrvxTvpprbBeXMkMoweDizF3HIK+0ZVl+T9Kq2IS2tC97vufty3Q5OqLuS3cum8S0D0BE8sp8wqP3e2UKARRzuyb2h3OvPe7Ms9T80io200aNB11JtoV/mjZZ76xAr6tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO9EVGRUNX2MUi6Yxz+IpozuWQDizX8TDmRH9N+O42U=;
 b=aYQNJBzqjikXr6mhbJ1aDZZHasFSEF9spIjMLywVWtsQZvL3QXeNBPd0iR5pyKJOZDF6jMVFlH0UZSCCjwSdZU5Oqx3opzN/CfCcbEdr4Q4oC/Wxz60cwTSkKJTGugUOFRgnDvDX1izfxMUr8w4FTSiiNTcuVzMF3OLe5YKTfCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 20:37:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 20:37:30 +0000
Message-ID: <6d3b9035-fa20-faf5-fe9b-5c5c02e8fd4c@amd.com>
Date: Wed, 30 Aug 2023 16:37:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2] drm/amdkfd: Fix unaligned 64-bit doorbell warning
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230830200105.117601-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230830200105.117601-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: c15eb33a-f3e3-458e-7aeb-08dba998ee4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ga/LR8nov3ev0/zpKz1rYuhGY6GEtVk+MaXMMD8Aci5OehWjtm/9zFD6uSRyqrdjuNwGypJdAILkJzYQ8JfNCFYuX5gi5+xvkokbO77U84jjGzxhzl/RKAnk65G7Zh/d4Y67gba+Mo6RZSW+Y4Ka+RhwJ0qkn6tAeDaW7cFoVlQbF3PuCKC90LdZ8yG1cTCpJ52XUBKGgz5M1qKFWiVECXUHNcTxpfJ2BKL5CILwKUoRfRjD2+4tQGPQwYAQZLqs6/CS74kXhxUeQ5dEsUTLVDuEAUSKaRn7Dsx/+LbLOh5ri24OBeH2AOahu6uXPuXAG0iFBh77a8AEwftLWviAHVVv3xk4n4BFy2RoqnPBAzSPz8wMtgm4zlfvxnqknrjpsByYY/8SWGmQONaKS6ugYSPl3WV8gRU5uZuO1EfE7U1Yo6TSs5kti66eMNtLWxIaSMASWcSoCYFn+FnybYWM082Vvk7TiWT4HJCoWhgiyMEMTRVkJvZ9OjP4+tGnoOruBiIDfqmZ0HsTj98fs1Mp+WxV2KnO4WWQW8LvT59HLg8mbzlcage68jg5SvzMl6a+yHx0pfgIe+Xju6bRlKliRNJWkyKFUGPRvsCjpD/bDFPDHGg5YDr+UkfEYa0laIsibLNdZfZTNpSjfbPR+9+4Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(8936002)(478600001)(53546011)(31686004)(66476007)(6506007)(36916002)(66556008)(66946007)(6486002)(316002)(38100700002)(41300700001)(6512007)(36756003)(8676002)(5660300002)(31696002)(2616005)(26005)(86362001)(83380400001)(2906002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2piNEpzUzl5a3NHN2FSeFAzbFZUc2wvRnh2ak9ZTUZobE1sS3R2bkx0OVgz?=
 =?utf-8?B?enpEY29xcW9MSk5UMkdzMGM3L3ZBZnBBWDBYVWtFSHdNNDBFQ1FucGljSjJB?=
 =?utf-8?B?T3FqUFZoY1JYd1loTU5ML0hNTmkzbmRvVXpPd05IYmR4eG0zRnV0SCs2bnRj?=
 =?utf-8?B?bDByMjMyZDh6ajNyU040S2daM3A5Wjh3ZUxtWEJqWUhyNXNFTmFvRU1ZdUJH?=
 =?utf-8?B?cnBMcnNJWDBmTFB2T20yWWZGWk9ZN3pCQzJ4MWJ2R3ZiNmx4M1RPY2tvalZ5?=
 =?utf-8?B?enFRbXBiR3RtNVhETjdRai9UZFVjUzlDMVhDVWQrLzBueFhQc1prRzRIdjJo?=
 =?utf-8?B?Umc3K3JxWktvVjUvdFVUc09sR2k1MVJ6RXFxL0VmcFo5Vm1udFFER0lINng4?=
 =?utf-8?B?NDkwbnF5bEZyZU9wSjkrRklqaTBnNWhLck54VXU5QURvcW1YTnlBOEg2WTRi?=
 =?utf-8?B?OWI1Z2Z4c01aU2xhc1dacXFNeVpzdTRxbC81WlFLK3QySTA2NGxxYVVXaVk5?=
 =?utf-8?B?L0xFaXNzMEpVOC9aZXlBLzlEbzZYSGc4NzV0eHVINHluMEJ0OFB1bG02aTlK?=
 =?utf-8?B?TER3U281dVJwbzZsM1ptb3FFeXh4eWV5VFNWMjZhcFY2MHB0Tk5QT01HM2p1?=
 =?utf-8?B?V0ZNSDJYcEtiYTRYWHUxcmJaYmpOT0hFcVZpSExkRDZVOGNhbml0ZDBDeVNQ?=
 =?utf-8?B?TGdsTk1YcUlWcnV5NVlONmxVUnlGWmZmVGUyZW5RRHRDMlNMWkt5dU40dE95?=
 =?utf-8?B?UnN2dEhJS3YyWTlZTXpEMmZGU2pJYmt6WS9rTEtzcks3Mms4djFxcndkU3kz?=
 =?utf-8?B?V285dDZISVliWnpEMEgxT0RlSHF6eUQyMmJtVnlvYXFqMWpPSzVHOVdKTytm?=
 =?utf-8?B?YlNkOW1tUkZsaG91bldoc09jS3Y2YnRZZXdUdTFtazZWUlkxVkpkZzRLQTNu?=
 =?utf-8?B?Vi9XTXo4UE4zcnF4K3BPSjF2UDZrUEJMRGw3VGVxMXErc25rNE1nNGs2VDJq?=
 =?utf-8?B?KzcyN1JMWVF3YWI1U081T0tPekMzeFlLUk4ybW1RbXFtb1BIWDh4eGVhSHFP?=
 =?utf-8?B?ckRoZlgzdWVQRWpnd01VcklYZ2k2MXhXcG0xOWIxVHRmTE5VZWxtVDlYcXRO?=
 =?utf-8?B?TE0vOFBtMjRhRm1QMHkzalRZM3dLVlVod1pyeFg5dHE1MkRlK1hZckQyN0pP?=
 =?utf-8?B?V3VRT0JEYUE4MW4rNlhsQUZLamdWT1NBVkhOd3kreVhmUzdVbEJ6b1l1S3ox?=
 =?utf-8?B?VmpQNm9uYUVXRkM2Q2k5elZEUmoyZTZjWFNxMEw5YWxQRHJUaXBlaUJwOVFK?=
 =?utf-8?B?TVJSZ01ac1o2WitBZ3NqYi85QkJ1R1BxbUxwRURQZWphOG5kMktZbG5jVG1Z?=
 =?utf-8?B?RXJUQm9iNS9Wa1V6T1dTTFNWdmZBdWJQTUZ3OVlMaisyS0VkK21HbUI4MGdG?=
 =?utf-8?B?U0F2SEpEaXZpdFZQNnZTT0xXeEtkelVaYzhjK3l1LzV2NitGYzB5Vks1a3B4?=
 =?utf-8?B?Sm9DNDQ2K0J4Z2ZuN0loWGlRcStkTGQyaklyZ1VqcTBMV2MyZHlOQUdRR3hz?=
 =?utf-8?B?VUFVVFUwVW96dWFSaldOMXA1OEluV3VqQnZJWlkzSXZONUNOWjNKK3R1Tys4?=
 =?utf-8?B?OW9wdTRUL3hxanA4dmE2aDZGQ1U4cFdwWlMrN1NiWUVBeTdPa3Z2a3BhUDRZ?=
 =?utf-8?B?eDljZktIUDZFd0YxbUlMNmF6Um12Z2gwanVkZEowQStxRitoYU5ZQU9UOWJh?=
 =?utf-8?B?eERmSEViYm4xakNzdmhZdUtDSjI1eXlhdklwTVpBZGNUKzJ5UUhzeHBGRnZD?=
 =?utf-8?B?YklXSjB6NXZQUHBrSlM1M0NpK2JmOElOMmsvYldxcktLVkRyRzBtUmxDTm5Y?=
 =?utf-8?B?dFBqdlI0and2dDRxMmNQM1pidk5IOXJBZlBuMEl6MkRLSEJsV2xXbDV3UGtv?=
 =?utf-8?B?OFB5bkFZNG4yMXdudDhzRU5HazVIOUtabXFiUUxpOG1TMVRUVzgvc0hCa201?=
 =?utf-8?B?bUR6TlUxaXgrUE9WdmszYktKdDhUY1ErTDJXallXak9yUEt1U2lrbWtPQ0Vu?=
 =?utf-8?B?bm9kLzAyL1JMZ3VPTlJ2OHppSUcyZlZXOE5jWVQvTTJaQjAzd2JWb2hKNllJ?=
 =?utf-8?Q?lz6TIlF+utORJ5JHjew7oTl/h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15eb33a-f3e3-458e-7aeb-08dba998ee4e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:37:30.3318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoSPv946/6YfehVlpesFtcMjV7lGMs0vNNvPFQUyqAYlnkMyX/zmfmnVhDW/+XjRe4gRW0Ooi1ZfiWHNXdVY8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
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

On 2023-08-30 16:01, Mukul Joshi wrote:
> This patch fixes the following unaligned 64-bit doorbell
> warning seen when submitting packets on HIQ on GFX v9.4.3
> by making the HIQ doorbell 64-bit aligned.
> The warning is seen when GPU is loaded in any mode other
> than SPX mode.
>
> [  +0.000301] ------------[ cut here ]------------
> [  +0.000003] Unaligned 64-bit doorbell
> [  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64+0x72/0x80 [amdgpu]
> [  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80 [amdgpu]
> [  +0.000004] RSP: 0018:ffffc90004287730 EFLAGS: 00010246
> [  +0.000005] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> [  +0.000003] RDX: 0000000000000001 RSI: ffffffff82837c71 RDI: 00000000ffffffff
> [  +0.000003] RBP: ffffc90004287748 R08: 0000000000000003 R09: 0000000000000001
> [  +0.000002] R10: 000000000000001a R11: ffff88a034008198 R12: ffffc900013bd004
> [  +0.000003] R13: 0000000000000008 R14: ffffc900042877b0 R15: 000000000000007f
> [  +0.000003] FS:  00007fa8c7b62000(0000) GS:ffff889f88400000(0000) knlGS:0000000000000000
> [  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000003] CR2: 000056111c45aaf0 CR3: 00000001414f2002 CR4: 0000000000770ee0
> [  +0.000003] PKRU: 55555554
> [  +0.000002] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  kq_submit_packet+0x45/0x50 [amdgpu]
> [  +0.000524]  pm_send_set_resources+0x7f/0xc0 [amdgpu]
> [  +0.000500]  set_sched_resources+0xe4/0x160 [amdgpu]
> [  +0.000503]  start_cpsch+0x1c5/0x2a0 [amdgpu]
> [  +0.000497]  kgd2kfd_device_init.cold+0x816/0xb42 [amdgpu]
> [  +0.000743]  amdgpu_amdkfd_device_init+0x15f/0x1f0 [amdgpu]
> [  +0.000602]  amdgpu_device_init.cold+0x1813/0x2176 [amdgpu]
> [  +0.000684]  ? pci_bus_read_config_word+0x4a/0x80
> [  +0.000012]  ? do_pci_enable_device+0xdc/0x110
> [  +0.000008]  amdgpu_driver_load_kms+0x1a/0x110 [amdgpu]
> [  +0.000545]  amdgpu_pci_probe+0x197/0x400 [amdgpu]
>
> Fixes: cfeaeb3c0ce7 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbells")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Update the logic to make it work with both 32 bit
>    64 bit doorbells.
> - Add the Fixed tag.
>
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index c2e0b79dcc6d..e0d44f4af18e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -162,6 +162,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>   		return NULL;
>   
>   	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
> +	inx *= kfd->device_info.doorbell_size / sizeof(u32);

Sorry for going back and forth on this. But you pointed out offline, 
that amdgpu_doorbell_index_on_bar calculates the doorbell address on the 
bar by always multiplying with 2. I think we need to do the same thing 
here for calculating the CPU address of the doorbell. Otherwise the CPU 
may not write to the same doorbell that the GPU is listening on. In 
practice this only matters on GPUs that create multiple HIQs. But at 
least I'd like the driver to be internally consistent and calculate the 
doorbell addresses the same way in the two addresses spaces.


>   
>   	pr_debug("Get kernel queue doorbell\n"
>   			"     doorbell offset   == 0x%08X\n"
> @@ -175,7 +176,8 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>   {
>   	unsigned int inx;
>   
> -	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
> +	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
> +		* sizeof(u32) / kfd->device_info.doorbell_size;

Same as above.

Regards,
   Felix


>   
>   	mutex_lock(&kfd->doorbell_mutex);
>   	__clear_bit(inx, kfd->doorbell_bitmap);
