Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866AFEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 14:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1420D10E41D;
	Thu,  6 Jul 2023 14:48:02 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57EE110E41D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 14:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K39RsJOyCPvqc9rylO2iO058HI+XOQg5zkP3eii1CM0NKW8X1EoLeGM1aV1BVLfWb0MEn66xKo/zvIzofFK2kRli4rDaYz9XaoJJ+mC1H1h3cZ+NzPZvOls9JRm+zfovgrZamgNwJeeRYpjx1sHa4DYerJ1BE7xVhSKImzVak+eXLjErzBM+LCoNgnqd72Ij/SsSdUu5FOgGBkcZfNKlJXIriC79UPBYdgZCctcclKZ98m6PU18pUzPGGx1SRnah5xd3nrOoc/hTuAWh1yaA58ZYrMyYrIfculm9Evxo4JkmGNvNGbIuZggTkpancomI5n05kDpb6he7iyO2lAZbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJWIIn44R4FMz4FwcJqaMGAC0wDlOi9pQtEw0ZGY630=;
 b=DVJTOJOH4h8XBNzg6fmvVXZUibbhoW3jv9HD6so6eY69J29b1M481ScwnQCTmm89cvwumeGjo+JCzproOjwbr97uiodn+Sah9GRU+M8O2teu4w8/cL0Lnp+bImiInVtc1LCngSGbn/+1kpfly397P3U6PZ+QgE0FQcVx8SE4Z3AgBwaJStTOA5rfsdGG7U1GdGxAYw9/qGvS1+NEr7tSMc6dmbKu2lSjcBjnyKdc4Y/21Ec+DBZlR0kfhOss1PR3yfR4lGb4zhfGs++4PWdhf4NxzrMgsmHDo1YVQkbqZCjJ5w9NPeXEtj7KKsAXS8zOh6RxJ0LsKOSUTq4FYBxBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJWIIn44R4FMz4FwcJqaMGAC0wDlOi9pQtEw0ZGY630=;
 b=UJzLPn8ssiSxVsyDfmhWnnO/mXZhZ5xLudys2RKysWJqfaoZ5L4QS4PvyWhetJcyeuIBujfNNcWhJioL9IjilpjC9YpDnUQvb0/L2YMBLQO0TX8yvn0ZkmhOYj/i9E9cN5clkdlyAWDeNngq6cE2zIHwI6R2Vqtv374AC/b+j0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 14:47:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::384a:95a4:8819:ee84%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:47:57 +0000
Message-ID: <2f34d8aa-afe4-5ac6-0125-2ff3a68f093f@amd.com>
Date: Thu, 6 Jul 2023 16:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 06/10] drm/amdgpu: map usermode queue into MES
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-7-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230706123602.2331-7-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 141a80ba-a1ed-4d1f-f957-08db7e2ffc9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPSG+bcsoYKfVQ8qf3UO1YQ8xuj+oU1uls1DHDu5beX6iqYf4h2n/mlDezzyWT+vVC1vksliE3O7UBen9Rqq2JDK1Yf0qAAG4n2RaIhX6jsRdcbBpUj+jfX17mcIYWEaH/CmwtyEbfnRG9K7kJ9LaASDNHpLWvpLwwmFHAolUgnVE+yBeyVaNrf3aezJeiL9qzcAfrTqFhpnpesoL5iwegkLpCHPtmq7RVUL/nF3iSFKumFwAibABXQYjXkoeTdNCwtKmqDXNJIrSOaMSFH8x1DlemyHK8FddMZfs8hrPvySU887eiTpPqqjiBUftDG7wOETxSeuiIzVNUelawAVONp0h1NY0xZKw6ROReGd76s/qbCwluGlNTyQV8EIM4VDQ/2gazmOhFDBfxQTWiBEnxeMGka/WIvx2aQkwIUKHJ7KK9+UENiHJHuE5hcc/shho8A1sMrcKvJNMr0fqEGqtzU1yfA/q9S2hGq4iC953tekIbwwWO5M13wjSCk7Il6sztieApc4+qgNN8kj0u/evTe9wQ/tXr5WUmTY5UMyF7hsnDPKDCGmJWX+RsT5cStRpgWTxyddBOvti0D6Hfa2uFl+ycgtWhrR3Df/SLbeNOuTMhsjSlCHHOz6iscs7z3Ry59s1CVftzrvElYp8NompQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(66574015)(83380400001)(31696002)(36756003)(38100700002)(86362001)(6512007)(6486002)(6666004)(41300700001)(8676002)(5660300002)(8936002)(478600001)(316002)(2906002)(4326008)(66556008)(66476007)(66946007)(31686004)(186003)(2616005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWxrUk0yL0JZN1pReDV0SnBwMTh6cWNIZ1JoQkpWbmNFdWRWZmU5cnc3dVhu?=
 =?utf-8?B?SWhnZjRpYVUrTWxLNU9lM0hQUW9KVEQ3SzdvMlFxS3ZXLzh2MGY5TUliSEdE?=
 =?utf-8?B?b1ZLeDk0UTVvalVSbUhOODFFQXkyYTcyelZOdHNhSnVWMzVOWFFpenRpUTRj?=
 =?utf-8?B?WlR6QmgrQk15NmJWUndndityOEpWc1BKcm1QK3JnNGdzUWpteWwwU1ZCeXNo?=
 =?utf-8?B?V21aUEYwRm1rOFYrVFZZZ1duWEdHdTlUZUNXTzBoUFNNeGMrZVJFZkZ2WEVl?=
 =?utf-8?B?bENVeDFKR0l5ZFlzYWsrcThsMFpseHgvK1NWU1NxanY0a0Jjd01tTTBLb0Vq?=
 =?utf-8?B?dHBlV2FlUVZmWVRkRXVFdnZGUno0d3lFMHlTQ2F3SUVyN0JvR1RNakJxejJw?=
 =?utf-8?B?Z1VhbzVnVkk1WjVzdUlhZGNWVDNMT04zdy9JSWUzZXQyTGUrR0RNZ3dMMHo0?=
 =?utf-8?B?WTlmMEtwS0FQZE9DOVJJODJsTU1kUm9CQXQ5RXltS2k2R1Z6bk1WWk5jUFk3?=
 =?utf-8?B?ZzUyU0lRc1RTOTNBU3RFL2p2OHJPcExyZUhsOTBMWDNKTXVHdlNuQWN0cXlo?=
 =?utf-8?B?OWIwQ3ZsMmlvRG8ycFlDQnVHVVVHVjRLKzBaVjBER2RYd0xPQXFWNVFucjQ4?=
 =?utf-8?B?anllZ2F6M0cyUTF6RHk3NG5Mb2oyT3B6a0xVQjQ0WHJaNXJIRmdTaTVDOTB5?=
 =?utf-8?B?SS9ZKzRiekd6ZkNpaCt1TGdtZm9NV1BBbDN1elp3dmM5YjJmVHhmK0w1YmVN?=
 =?utf-8?B?VncybGtRUGIrbXdPY3llZUdyYTlkNlh5eGVxYlNocXJWRmpQam9ZRzhrM3Z5?=
 =?utf-8?B?WjJiTDhrTS9ONENNOFNzQmtZM3ZHTm1OZWlaaXAwS1BIZTBGeVpwU1MzaW8w?=
 =?utf-8?B?bVoyZm1kKzdsNnJYQ21IWTlnMlpoQnhUaFViZ3puK2twaG11WTdpTktwMEwy?=
 =?utf-8?B?T1M1SDB5NU90N29Ka2k5MGFRb25zaE9RaVl4SnFCM3V1RUNlNTRsZGd3Smc1?=
 =?utf-8?B?b25VcVFKSXlJOE1aZ0ZIVjJ5UHErL3RNdlZCcnNQbXhtS1dXL0dVVW1sZk0r?=
 =?utf-8?B?a3cyemh2a0JwUmppdjkzQm1EcEZkcWpNdXJtbENKcmRZT3p5MUpxcjNKOEY3?=
 =?utf-8?B?M3BxU3JrZnJkcmRUVmpXQndqT3BYbDVGREV5b0ZKV2c1TklxcGthUmJ2enVO?=
 =?utf-8?B?anpNcDdGdjVzRlUwRjBSVkE5Q05PN1p2MTB2YUlIbk5DbzRNeWtsbFZXbDVQ?=
 =?utf-8?B?WGtiSU42NlJmMGxqWHJNaC8rVnN1Z1dPV2lHVXFxaFVGQVkzcjVtQUEzd1J3?=
 =?utf-8?B?T2hEQTY4Vnd0czduUUU1ZEdCR2VOV3VDMVBrZDFwbW5pbmhCN2lmMEZveldi?=
 =?utf-8?B?WURhMTk5N0w1aWpEanVuaFZkZGZEN1NTbzhMUEZuYjdzL1BzbnBKNkxLUzI5?=
 =?utf-8?B?RTdkUW9qM3c0UjJxRjNyekNuMjJ4SXJ4aEdyL21YTmhaWGhkV2FRZDNpcWpO?=
 =?utf-8?B?aXI2LzFNeUVNdi9nMU9QSGdtL2Y2TUxEUTNzYTFJalYwKytlT0VQMWd5TUpL?=
 =?utf-8?B?S2ZrT3BRaUtSelpYNDk4KzBGQjdFRkdDN2NzbXNBQzMrZEpvNlhySkVGYTB0?=
 =?utf-8?B?M0tucGw2QndiYWsyQ2t5YSt6aTAzQ2tzWEZDNXZRaFh2bXVwVmhKWWRJb0R4?=
 =?utf-8?B?endyNUpjdkxOaXI0STBnSnRiYWlRQksrTTZJd29HSlczL3JTZ09hcmNkUDVi?=
 =?utf-8?B?UGluNHY2UGwvUVh6NlNLemhPa1FZWFdscENwZ1BtQ0oxbk1KOFowRktRaVpD?=
 =?utf-8?B?NDBpd01DdThmTzNTbGQ2cDFBNHVsUzR6enFVRjljbGV6d2VLeHRQY0lna2lz?=
 =?utf-8?B?WjVVWjA4MTcrNlNwbWU4S0R6S0ltdnhNZ081dkRXK0MrOGNUVlVBSnNOQllm?=
 =?utf-8?B?UEpnUjlmZ01xVzVaQ2RFK0t1dW9CcXhTMCtVckVmL2dENHZBd2REU0t4VzR1?=
 =?utf-8?B?OVhYc3IzM21pempISDlxL2Z0TjdXUEN5bjRlSFcrMDVKRUZGWEg4SU9iWW11?=
 =?utf-8?B?emc5Zk9LMGN6dHoxTXpsU054YlhTTXN5YUtlSXRuNTUzRFVrNndsYXJvL2lD?=
 =?utf-8?B?NTJJR205MEJNRFh1V21QVHRURy90QVp5bmpmWC8xbVlWdFVVQWtBUUVENWMw?=
 =?utf-8?Q?i75RTWyGsZpqKuoGQgBEDV28iJcDhq77GOT6rW0PHuZQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141a80ba-a1ed-4d1f-f957-08db7e2ffc9d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 14:47:57.2622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGiXavi+tmSg3W9+mUlU+qZdcA/Nv2ePErvI/9ZmAW/I19oI7x3cFiASXOFy2s0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.07.23 um 14:35 schrieb Shashank Sharma:
> This patch adds new functions to map/unmap a usermode queue into
> the FW, using the MES ring. As soon as this mapping is done, the
> queue would  be considered ready to accept the workload.
>
> V1: Addressed review comments from Alex on the RFC patch series
>      - Map/Unmap should be IP specific.
> V2:
>      Addressed review comments from Christian:
>      - Fix the wptr_mc_addr calculation (moved into another patch)
>      Addressed review comments from Alex:
>      - Do not add fptrs for map/unmap
>
> V3: Integration with doorbell manager
> V4: Rebase
> V5: Use gfx_v11_0 for function names (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 70 ++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7d3b19e08bbb..b4a0f26a0e8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6491,6 +6491,65 @@ const struct amdgpu_ip_block_version gfx_v11_0_ip_block =
>   	.funcs = &gfx_v11_0_ip_funcs,
>   };
>   
> +static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> +				  struct amdgpu_usermode_queue *queue)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct mes_remove_queue_input queue_input;
> +	int r;
> +
> +	memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
> +	queue_input.doorbell_offset = queue->doorbell_index;
> +	queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r)
> +		DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> +}
> +
> +static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
> +			       struct amdgpu_usermode_queue *queue,
> +			       struct amdgpu_mqd_prop *userq_props)
> +{
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct mes_add_queue_input queue_input;
> +	int r;
> +
> +	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
> +
> +	queue_input.process_va_start = 0;
> +	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
> +	queue_input.process_quantum = 100000; /* 10ms */
> +	queue_input.gang_quantum = 10000; /* 1ms */
> +	queue_input.paging = false;
> +
> +	queue_input.gang_context_addr = queue->gang_ctx_gpu_addr;
> +	queue_input.process_context_addr = queue->proc_ctx_gpu_addr;
> +	queue_input.inprocess_gang_priority = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +	queue_input.gang_global_priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> +
> +	queue_input.process_id = queue->vm->pasid;
> +	queue_input.queue_type = queue->queue_type;
> +	queue_input.mqd_addr = queue->mqd.gpu_addr;
> +	queue_input.wptr_addr = userq_props->wptr_gpu_addr;
> +	queue_input.queue_size = userq_props->queue_size >> 2;
> +	queue_input.doorbell_offset = userq_props->doorbell_index;
> +	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(queue->vm->root.bo);
> +
> +	amdgpu_mes_lock(&adev->mes);
> +	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> +	amdgpu_mes_unlock(&adev->mes);
> +	if (r) {
> +		DRM_ERROR("Failed to map queue in HW, err (%d)\n", r);
> +		return r;
> +	}
> +
> +	DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n", userq_props->doorbell_index);
> +	return 0;
> +}
> +
>   static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>   					      struct amdgpu_usermode_queue *queue)
>   {
> @@ -6601,8 +6660,18 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>   		goto free_mqd;
>   	}
>   
> +	/* Map userqueue into FW using MES */
> +	r = gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
> +	if (r) {
> +		DRM_ERROR("Failed to init MQD\n");
> +		goto free_ctx;
> +	}
> +
>   	return 0;
>   
> +free_ctx:
> +	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
> +
>   free_mqd:
>   	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr, &queue->mqd.cpu_ptr);
>   	return r;
> @@ -6613,6 +6682,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_userm
>   {
>   	struct amdgpu_userq_obj *mqd = &queue->mqd;
>   
> +	gfx_v11_0_userq_unmap(uq_mgr, queue);
>   	gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
>   	amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu_ptr);
>   }

