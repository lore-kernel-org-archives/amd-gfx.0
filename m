Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06584C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 18:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C7710E778;
	Thu,  3 Nov 2022 18:04:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DD1110E778
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 18:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWyLOlzkCgIDVpWSNs2klbkO1hzDSyssmrK1jqf0gv1B/3tgxzMi/Fio60YnBZCadJ0Aw8FPXYDkXMpL3I5gevkUmtB22JhIJ/y4DnSblVYjPhe6H2KgZc9iNKNlZDyF3bpQsUoDi6dgrb312V1kw9Y2BplitPpnkA8e01q1F5qJSDcSWROas0e/7pCUJqqm89sRzC4Q15OLt4zO+zSl05WrWv4fMwMmn7FI+Iyi1BKwFHxNwOSjmC4+FUzk0a1fRa8t8BfUMG5bqZoaR9/58C+mCdGfBJFxSCBzn1cFogipZOG8Tjd3xdgGyMEfkpl0s55HVq572G/SLhZkH2+73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5sKiLbELAQTYYa6T9AQYhCqlrlDebY8Ojka2jZ6GEE=;
 b=EapkejY+WDBnwP+YlqyGZXAtZVZ8KLr7CfhdmVSUMepD73zmiWvxg3uVZfqN0f7Rj4Q8I8liPryBmQACyPYeijvfDdGDOlo4smJcD5rcp/aHn2yhtwEVxR9QYEOwrygk83lzFoEiUxr0LgJ5FHLme/zACK990GI9cNZDm3P+hxLdcNjnPSsxoJ3fEKFiu0/+mrw1ERip7w+KlLRbKzGn1VZ1a4Zwu3msOOJIioCcBurU3k+cUJLwBtWvhUmoIJFchvpxQNH10gzE6p9d0uqQM5iess1DZGMwYm0bwWuO/C+wnrlJcgu/BfeUlaY1yRlWm+5SwYLcAsZUYBQySB/bcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5sKiLbELAQTYYa6T9AQYhCqlrlDebY8Ojka2jZ6GEE=;
 b=dTanGDxf4axBEs8OqhVaoIRvjuLBPYuHS9L9ecTmwwS2r42ZuBiGDmdUUn5RNiDKf/GweYQDGZRr60PYFTEZuYkR8NdEhQJZJIwYKfQvexxlxRB7ARqsIC/DqVDizYi1TurX2HCm0e7eNBU+HTM82LRb1XGpE7uvclvj66iUS9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 18:04:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Thu, 3 Nov 2022
 18:04:00 +0000
Message-ID: <3c2b2ca4-adad-0fc3-370b-c9598ff71412@amd.com>
Date: Thu, 3 Nov 2022 13:03:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: drm/amdgpu: workaround for TLB seq race
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20221102145811.17968-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221102145811.17968-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0446.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef53b00-e99e-4901-e36e-08dabdc5c894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w70Qi12ILtwZt/AdoTSs8uYP3igDZARpOc3LhIL574SMmhtmQOVn3kmMpCEZDfUpQxChvBRVO5fTr7EE2CpptzL2+wWgtUfAJ+JZJF0bi6l0MgAa27IgGKZMJB77FW2TyBdiSRr5mB6rqmJ36VbgzNPE9tyP6dlm/GTtUT4H9AGePmwCw/cvQ+NpJi6S3HKs8LLBlTN9I9a8QO/63ZEk6gtlT0O+KjPSgzj7BUv+DL7+iOqT0DjlMOA8nOJaw3VeI7SSqoUNjTwRV+EDpjBLDkuwU1WJ7lXzjYK3nVbBWNruxV43nzkx9wcK1Wj78jQ8TdgwNegg3Qfh2MYgICMbwlerSxEJ1Xi19m4Ff9kmXW+lgbR+f1szuD2Gx+qTjfBlLOKmYjKh95P4gJ87468ONE9uB8E9q+UZtjLCNOJgweN+jhylvkzayozepwkWgXGdNSiI2+FUF7RgCfVI8PiSfIUmqjJVolM4aAKG3mu2F2k7xFicaHaakkc8cespP+Sn9307lfmnCUTk64InLYYXjeZ65wDCOf5hOQ13iyq2vfzY/QpusuKBd9BU07kLiYnsKYHViyg8stkY50I3lCACTKwyF5tPOC7jY+ZiML6u/yf8vlNl9vu/PDHmmoIyBJO599+sNcdnuZLUDLSJvR75Fz8M/h0RnDINxXeSm+17oMH0hWVGez9kQqW5pmK9gKXEixtuLwUKGsdoo/oRZE6g2t4oZzLsQpDSA6y5XjzYUCwgmz2sbEWaijgiFpPiNZns
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(2616005)(41300700001)(8676002)(186003)(66476007)(4326008)(66556008)(66946007)(6512007)(36756003)(5660300002)(26005)(53546011)(31696002)(6506007)(8936002)(966005)(6486002)(316002)(86362001)(83380400001)(478600001)(38100700002)(31686004)(66574015)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SERzMTJGSnVEc3BMRG1HTzZ0VDVFSWtQU1paekdmZWdnYlZ4Sm1jbXd5L0I5?=
 =?utf-8?B?RFFFazVHY0RLRENUcHVMcFlYbWdqdDQxWEpYQ2RaTUI1bzQ3TWh6T1NuYXpG?=
 =?utf-8?B?MVlIVzdwL0V5RmZmSktJNnJkcHBGUndFSFZ2ZmpmRmtsV2pXUWVmVWV2TDc3?=
 =?utf-8?B?WVExazhvN2FRY2I5Qml4QXNJdTdDcDJPZ24xbjd4cXpRM3J2MWdLdE9lZTI2?=
 =?utf-8?B?eWxjaTFFcjNuZjU3emRTZnJ3VVVQbEZhc2lQcTRzcktJemMwejhZS2Z3Zmxu?=
 =?utf-8?B?bGpTMXE0R09IWFNtLzd2T2F4VUJGaTFqdS9OVFJGWjBlK3FkRDRKc2phWDlo?=
 =?utf-8?B?aXJoMDZNbUlJUjAwUkorWGxtMGVEZEhtNjFuc3RWODhWRkpxSVh5WkpxSGZq?=
 =?utf-8?B?dmJ1WWtsZG1MOVkrN1M5U3Q3aE1waS9pdlE3OGJ4cFpTaitPRXdpTjhwdkJm?=
 =?utf-8?B?OEh5NllFdlQ5ckpiZ21XRmRDY1lIYUVTUEEwZDhFYzZWakt1M2NTNmsvNUhE?=
 =?utf-8?B?NXVGWS9rN3Erd1VyYiszeC9QUW5CdEZiNHFFL0FLbnByZUxLV2hIREhZdEVo?=
 =?utf-8?B?emNNV2ppQ29OMVhUZ0ZsMXA4MlJqRUVuMXgra3k5aGRkSDJnQklHT0N3QThJ?=
 =?utf-8?B?TGRMS0h0OG5UbkhIUXFUWGFHNG5oaXRXSnhOQjRjbjc5MkZVQ1JmV2VQN1ZB?=
 =?utf-8?B?djNhMCtmKys2Y09aZ09lOHREL3JScVM4RkdSa1VmS3FMTG9Pa0JLRWNBd1Nn?=
 =?utf-8?B?Q1ZrTTFmQWdZR0hXSFFWTm9jM3RiL1MzZmI5NGZ0RXdJczdTU2M1d1E0SlhO?=
 =?utf-8?B?bzIrdEVjVFFFUDh6ZDExWkxvQjZvekhVQnF5cE51Q0RyMFpXdEpjdTQzRmpi?=
 =?utf-8?B?VWtCZ1J2MWdMM05zTkZRbk52T1M0SU5MU1BMYlRKdmNjbjRGUGhpUVRBUGlJ?=
 =?utf-8?B?V2JSWWJMWGtYSENTMEVJKzFMY01Nb1RyU1pPMHB1QWx3dnhBTUZ3YmlmQUtw?=
 =?utf-8?B?VUNlR1BERnlYNklZYXN0cFoxWHNiSDRaUEw0ZVVibUdsVmFCL1gzamtNKzBC?=
 =?utf-8?B?UE1DWGNrbys5UVN0S2pLYjVqSUdwQUtOUGttc2ltR1drOXNDczZBK0c5enJs?=
 =?utf-8?B?aEluZ0FXTWE3cGl0UVdBUWxhSzdTNVorZExKalZXVnFva1pWMjF0VnhjWnAx?=
 =?utf-8?B?SjRIYjRFQ1Rtc1oxSWxkNzN4eFhNVVdHNGgzUHlGMVpsRUJGaUVEZWF6Z2Rm?=
 =?utf-8?B?UTVvdkpFSmcySHhxTEZqVEhldUNKeGJvb3FscEVTd0ZmODZBUEdkcnJtV3Q5?=
 =?utf-8?B?amxEbFhLWUl4RFlHOWhlZDZIc1RMbHVSUHpia1p3WVptQStueDM0TVMwYmo5?=
 =?utf-8?B?LzhZd2VkVVhudkgzZEFWRlpwa0F1ZU45Q2NzU2x1K21NYTlGTG9sQ3JEdUtx?=
 =?utf-8?B?RmtOYkFiazFPZHBlckdYSTUxdlh6UjBoTmZqMCtwSnFOWlNFSWpscllQNW04?=
 =?utf-8?B?NkpndXJGM1FJUUhnc1lTOXRKS3BDS0lJNEIvR3JieGtBMU8reEZhZ0JKakxX?=
 =?utf-8?B?Q1kvVEpIZ3hLQTZSRm9KeEgvWkhrdTAwNnROVkJwZlEwRk11cXdqMnFzL1gr?=
 =?utf-8?B?d1NwODhUQWJmZmxqSUZKcmt1R1MrYjYwTEFnVENBb2Npbi9jZjlkR095Vkow?=
 =?utf-8?B?b2ZldDFYa0lEb2xPc2tTL1dpMUFTU1FmVHduUlEvdWYrT0FrYVBGaVU3SFVW?=
 =?utf-8?B?V0Q1UHhWU3haYjh1OWRWMURSTkZYR3lrcHBRQkdGTk1YSW5wMmxET3BZall1?=
 =?utf-8?B?MlVCcWc4Qm11L3dmU1lwM1NpS2lweHUrZVNZdSs0S2h6cjBaZ3E4cjdHMGJF?=
 =?utf-8?B?QnQ1dUtvdHZlVmJob2s0bGp0K1ZuQ2Q1Rm44a2pBWEhLRE5CTytJL1hhLytK?=
 =?utf-8?B?Sm83SlVidS9BelhEbE5vSVpveldFWmg2UVJpMnc1WE00dW5ZV25MUXBlTTVk?=
 =?utf-8?B?dmpWQUxUMGdiTGhET3F5QlBRVWFuTVduTTkwMC9lNUdSNkxaN2V0UzJWd0J5?=
 =?utf-8?B?STdzbHltUzQ4VWNZM1B2ei8wSmJxRzVoOTd2UEhnQzExVWcxWFExdVpRSHFk?=
 =?utf-8?Q?sC2RBjqnStcTnx4Ut88UVn3V/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef53b00-e99e-4901-e36e-08dabdc5c894
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 18:03:59.9316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omZsNmEwLCB0lsRB7axcmVgP1fTmGD/ZVeTVUetV5Pi/my1VNDi7K4xpaZEbK3Ot9J23PLXjFPL9gC/NCP9y/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 11/2/2022 09:58, Christian König wrote:
> It can happen that we query the sequence value before the callback
> had a chance to run.
> 
> Work around that by grabbing the fence lock and releasing it again.
> Should be replaced by hw handling soon.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

You probably also want to add these tags:

Fixes: 5255e146c99a6 ("drm/amdgpu: rework TLB flushing")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2113

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 9ecb7f663e19..e51a46c9582b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -485,6 +485,21 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
>    */
>   static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>   {
> +	unsigned long flags;
> +	spinlock_t *lock;
> +
> +	/*
> +	 * Work around to stop racing between the fence signaling and handling
> +	 * the cb. The lock is static after initially setting it up, just make
> +	 * sure that the dma_fence structure isn't freed up.
> +	 */
> +	rcu_read_lock();
> +	lock = vm->last_tlb_flush->lock;
> +	rcu_read_unlock();
> +
> +	spin_lock_irqsave(lock, flags);
> +	spin_unlock_irqrestore(lock, flags);
> +
>   	return atomic64_read(&vm->tlb_seq);
>   }
>   
