Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845A9C6FD19
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 03:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E300E10E031;
	Thu, 16 Mar 2023 03:41:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16B810E031
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 03:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUJmvfSg/XSXKp+KVvebtauU/6LxtsLOJ3Sousm3Ln6QrrsOdSObzjO+xdgL+F8zjDE8wy2qxEja/gRXt/jSzgcGTAduyJLZW4LWBmsHxesXy5e83c4lr8LH0ALMEf11vFxKvB44mMwV6eh/Umaq1qEoXSMp6eLeiERNFk34rBYPOtLeZTSb4n5rSu4Vr3XKQHor8X8I1pUCsem0FBl+jP2n0E4arp/B7jyYq0EUL5cY9MI5caY4h+v4MiD/pF53LejF8zieCSan35dBXTWlRDIIhcfYhWinFffcr1MjnWKsS39kxkcqzSN1al4InpK/OgKURx1g7Pf+8M4mFji7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9nbesNA3NRxX/VcEwktdhcfe6qU+3mpwhh2LfWgw48=;
 b=dHxbUtzOW45zGE8Z3v/AGS4qmCL+JZtwX1ZQzQEMF86y6fGMDu9MxzkKt+INb8s8xKyKkpj55ndcdyjHBhlz70gWygTW9bxaULxmRu+MI+zXjK5uoiJdPHn3fhgJvS/esWr0LCB4Y9P1x0Izr4uR6OW5LGzwXOK/u1lRVdSAEiPA+ZkHUiOVi2h7fn2fLq7EgQX5u/iec/XDUX0SpmxYlLbVISjaUmokfI0cUE3eNMRvOrcUEslqOcN73BZN5K3dbjxmOEEvgufuUNQuX+tiWmdnBntjh1fJKaNs0PTEROSq91LCOIZWac/a9J3prcEDbMV/26Q3BPyY5znOzvTLHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9nbesNA3NRxX/VcEwktdhcfe6qU+3mpwhh2LfWgw48=;
 b=PQiDhfklPLa0p38rHcmSwpxguko0vfOHF5g1k/GZOKZimHxnW+yq4+lR2lYol/S+EfdaZxncUqy/jAcALIBay7RU8L/e+yN7q317vfFdvNpz12pKCjZ65Q6GtmyGr6I2sAxLzf+K4HH4LSmHlQbD6j+X4lIGcAIiB5gGG6RtLEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 03:41:12 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::e43d:5bd2:7a85:d0cf%7]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 03:41:12 +0000
Message-ID: <31abcdc2-18c3-6f33-fb8b-2be09092051a@amd.com>
Date: Wed, 15 Mar 2023 23:41:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-CA
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230309022707.4141252-1-YuBiao.Wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu: Force signal hw_fences that are embedded
 in non-sched jobs
In-Reply-To: <20230309022707.4141252-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0084.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::18) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d7915d-bf62-4225-88c0-08db25d0496a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHdYJtQYfqpF0hvMCLxoPi18ldNzXKGN1AE2hQLXJ04E5PKvcWj2C8Z2UrYVAlusnKQGV9TdpxL03aCj1DA0WNgTnQ+bykY9LLcgjE59Bl2aGBe5+JtR69LBames/3n+RlUZPzHdJP2wl+44SlsB6PDAOMOoicMw3KQDlAam8ZA0yZudtHbtbOwBK37ODMNd6MubC5O53farLtr038SuuNoIG4S67IwwBr75ECgUa7dOrCUdXVp+GzLbWA9lxfoYMWwsSnFDT0n4G6N0GCPix4OTemz60U/XapvArgSevBAFVzEiuxj1HHOWTcnoleseNh70fH3DTwTIgIcdDgkONwJjkCFjl0h+QQngY4RnwPW7NpCki6HGpLOoz9wExZEYMaNy2kfiXVB27o6YUu5LCtcbBzf7tnUZykYri67qgQfUqOO8q0pnfcrRq9hem75nDrgP/BMTYa90ESHUIJlNoEzc5TWPoFedwM3+6nC0J+guCOuivwuLWyapTNPfxPkoF68GYFt4O1LKs2LcakyjzYkNIcq5x1rGiQXqm+B/FrzEGIxgdqKSXLSWhBgotktfljYTChM2MTbKdV9JTG/+M44qO0Hfdg3zZRWYZ042nmlZbSAPWVNQOX7tdQjUiv338m6mye5qhoa9ry0CmWwNWDZ4gCcBDy8pjyf/6j7CUi+M4Tgrp1uUAUESqF7xgJJksjeLfKOoTIHCKvSObesXknkcwmd+/rFqcIUZYpvslYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(366004)(346002)(39860400002)(396003)(451199018)(36756003)(86362001)(38100700002)(8936002)(41300700001)(31696002)(2906002)(5660300002)(26005)(4326008)(2616005)(6512007)(53546011)(55236004)(6506007)(186003)(316002)(54906003)(8676002)(6486002)(66476007)(66946007)(6666004)(44832011)(478600001)(66556008)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW5NYUpvbCtqRmhsUC9BYklHaFM3cVFPV05DRVhZL0kwRUw0OHQ1MmF5d2Vh?=
 =?utf-8?B?UkVSbE1hTTdHYm15bzRLcWE0eGpJbjl2Ry9MSUwya3JIY21NbHk3NjZQaUNQ?=
 =?utf-8?B?Ui81Y1BDeGxvelRQSHVzOVEwVk9NSGtlUi9GaEsyNm5GNXpuTzNSUmErMDdj?=
 =?utf-8?B?aUVyc2x0MmVKTldnenNIR1p2ZVNyQ3RBRGt5eHpWU2xwY3pzUklvWUJoNUVp?=
 =?utf-8?B?VEpzN0pqSmhhOWQ0S0J5YmZrL3Zha1gvZ01STVY2WEJ2TmprcithRFA2WlJL?=
 =?utf-8?B?a3ozSFVUU0Z1NTYrRmR6L3dRb0hWRzhQSDA3WlhPWElrQjZZWWJCMlpLRC9W?=
 =?utf-8?B?VWdKYlJTMXpJU2RrYlB6WWZ4eUJpRkUxSld1dGlPcDBOdjNESzdLVzFBNFFl?=
 =?utf-8?B?V3NnUXp6NnFGcFFuc0sxcmR3eCtJUWQ5NkxETk1aYjgvb3dpaDBrTFF4ZlBw?=
 =?utf-8?B?aldWNzhTSC9HMkE1TW9ERC9mclZ0WU5aWGVvMW9ZVmNWSnpiM29BN0VmMWZH?=
 =?utf-8?B?dERiSy9Vamd6ZmpkanBwVFRLYmpOajE0TVJCeElwWDlQZXlCdDJPUG5KT1pU?=
 =?utf-8?B?Q3QvMGlONnZFWWExRmFEbXhha2FWQWR4cCtEL3VLTnYxNUVvcmVTeDVLSHE0?=
 =?utf-8?B?bFBLbDZtTmJ2TkMrSkVEOWlORndWUHRPT05VN2VHcXQxQVJQM3I3bXpabUFO?=
 =?utf-8?B?QWZDT0syV3VKNWt5TEt5dDdwUFhBcGNvVm1VM1U5ZUd4aStzTkhOMTJudGZ5?=
 =?utf-8?B?OXhFUHluUDZDNHlpcWlrQnRUZHNRWTFhRlNBalNmUEZFU2JUNFlSNUdUZEhF?=
 =?utf-8?B?dXZRK2ZseExFUUVSRHlJekhIcjBsS1lrYkhlYzJVR0RWWTh1Rm1hMHhPbnVh?=
 =?utf-8?B?am44MmVZbmdQZ3JSeWQ2d0MxSkp2YzlQUm5hbFJJSlN2aitFdnhFNVdLQlcv?=
 =?utf-8?B?WlNLVDBQRmtoc2RLLzRlN0RZcGpvM3h5RytGb1dyVXRDY3hMNmdtNTdrbHMw?=
 =?utf-8?B?akFXbXNOZ1JYUWVRK3FiTFZNS0JtV3lhN0VoRDhEcDUzandLWXF0QXhhdUNu?=
 =?utf-8?B?WUFZdEZLeC9NamNFRHRDcklORGVpdEtPaXVQdnpjdFlVbHhjN2J0dS9aYVBs?=
 =?utf-8?B?MVdYYnA3eVoyTnd1SVhoRGFiUW9wcVRwVVZvbnJmdkR1MFFucTRibTUzM2tU?=
 =?utf-8?B?Q3BYb2o0MGx4eVIwZ2FSVUFOaTFvSzJaeElXK3F6ZkF1dVdhc0lyUTdsS0d6?=
 =?utf-8?B?RlJiM3JkU3dETDFhcTA4clEwek9oZkFLVk92Yk10LzY5LzhVbnY0bWxXdVkv?=
 =?utf-8?B?cENFWExrcGt4c0Nia0IxNHV4YlJwVHR2NkFsdDUrblRYK0hhbWtXY2diUG00?=
 =?utf-8?B?UE9PVkRJMnJEVmpmTDJZR2c4ZWpDamhUYU8xMkpRZzFBajNwUksrMFBWQTNO?=
 =?utf-8?B?eklmTHZPUnNyZG53ODRXMjFJVDVEMFh0cGRXb1dXUlNZYVlCSkdZYVVKUHY5?=
 =?utf-8?B?d1E0Z2ZXTW1qMWo2VDBmVFc2Z3ZyOHBuUTgvUWE5T1B5c1pEM2JpRmhDb3RI?=
 =?utf-8?B?a0FZVER6MnRKRHkxUVF3OFdmSllLaGh4SWZSR0t5Y0xxeVRpb1BTYWdVTHRH?=
 =?utf-8?B?amxMZEsrbG9sVGo1Y1F0bzljc3R5WVRkVFRxbjAwWHN1Y0wweTBSUGN0WkNG?=
 =?utf-8?B?L0x2ODkvTGVJSzJHS28ya1g0amNmZlVvMUJFN1RibnFBazRjM1NzN2Z3VXNT?=
 =?utf-8?B?UjNKZ0s5VnJzTXdHc1JNZjdJUXZ6S2FONkdHRVlPVS84bUU1QVY4eGhya0xo?=
 =?utf-8?B?aGRCWUNIbDhPNU5WVUFpYStkeVQ1TmRKV0s5SisxU2NHTkJVNEdrZVh1Wkdx?=
 =?utf-8?B?MVFoQzBDdnc1V015WDI2bVVYdjNLVDZ6STFyb2h3a3JqcVcvNjFkTnEzNVlu?=
 =?utf-8?B?TlZMY2ltZXkwZVg3R0ZXSFBPVXFCY0hlMytHN1Z5VFVGakM1UWdsMDBad3dT?=
 =?utf-8?B?bmNpaEt2WVNlck14NU5NN3JNdFFrMG5KcUpUOUthdW5WY212U1Q1d2dXUU5l?=
 =?utf-8?B?dlZ1NzdrMGNWWWVzb2hodlVkaVQyZk1yU1I1NWtYNkpkbnBIVEF4U0xPN2pS?=
 =?utf-8?Q?CnKJFwG4JUth/KhH+7Uwd481c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d7915d-bf62-4225-88c0-08db25d0496a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 03:41:12.1169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxqa73OSM3HAY6R3mqywCmtXNFCEbwGnDCiqAgwh5DqqzXWM9BN/AcR/QFcKllhp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-08 21:27, YuBiao Wang wrote:
> v2: Add comments to clarify in the code.
> 
> [Why]
> For engines not supporting soft reset, i.e. VCN, there will be a failed
> ib test before mode 1 reset during asic reset. The fences in this case
> are never signaled and next time when we try to free the sa_bo, kernel
> will hang.
> 
> [How]
> During pre_asic_reset, driver will clear job fences and afterwards the
> fences' refcount will be reduced to 1. For drm_sched_jobs it will be
> released in job_free_cb, and for non-sched jobs like ib_test, it's meant
> to be released in sa_bo_free but only when the fences are signaled. So
> we have to force signal the non_sched bad job's fence during
> pre_asic_reset or the clear is not complete.
> 
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index faff4a3f96e6..ad7c5b70c35a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -673,6 +673,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>  {
>  	int i;
>  	struct dma_fence *old, **ptr;
> +	struct amdgpu_job *job;
>  
>  	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>  		ptr = &ring->fence_drv.fences[i];
> @@ -680,6 +681,13 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>  		if (old && old->ops == &amdgpu_job_fence_ops) {
>  			RCU_INIT_POINTER(*ptr, NULL);
>  			dma_fence_put(old);
> +			/* For non-sched bad job, i.e. failed ib test, we need to force
> +			 * signal it right here or we won't be able to track them in fence drv
> +			 * and they will remain unsignaled during sa_bo free.
> +			 */
> +			job = container_of(old, struct amdgpu_job, hw_fence);
> +			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> +				dma_fence_signal(old);

Hi YuBiao,

Thanks for adding the clarifying comments and sending a v2 of this patch.

Perhaps move the chunk you're adding, to sit before, rather than after,
the statements of the if-conditional. Also move the "job" variable
declaration to be inside the if-conditional, since it is not used
by anything outside it. Something like this, (note a few small fixes to the comment),
	if (old && old->ops == &amdgpu_job_fence_ops) {
		struct amdgpu_job *job;

		/* For non-scheduler bad job, i.e. failed IB test, we need to signal
		 * it right here or we won't be able to track them in fence_drv
		 * and they will remain unsignaled during sa_bo free.
		 */
		job = container_of(old, struct amdgpu_job, hw_fence);
		if (!job->base.s_fence && !dma_fence_is_signaled(old))
			dma_fence_signal(old);
		RCU_INIT_POINTER(*ptr, NULL);
		dma_fence_put(old);
	}
Then, give it a test.
With that change, and upon successful test results, this patch is,
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
-- 
Regards,
Luben

