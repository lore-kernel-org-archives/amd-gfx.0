Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65EEC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88186206CD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Pv3tUP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88186206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EDE6E1F5;
	Tue,  1 Sep 2020 14:22:47 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D76C6E1F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 14:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTofvfQLTT6Hy0t2HBnZGrTw+czhK/7qYHDJntYB4bNjb1gOBZ2dOQLD3DzhQbvsvHxiTi4HmO4uMsoDdwQxvhw+4nCAAvqjINynm69mixIH2kl4sc3K3vgJGDhTOiZve27q5t3ZyW1HyXLrPFqhCADgWiFfqPR8Vv14Wpwo4yQNp6So/hdfSa4d4jUF8aJfBQsRvh2tRRMUk8CwvIWzz06Gj2YT4Ea0/ZxVfb3pDKOWIyAJAT6my27I+m17dSGv8sNkdqAKVJpVgN9kdoJJPK4clAz+4v/ucYx8UJa1TAaRx1f2bB0UAItiPkqXAaE5geXGWb0rZZhtl68lkqGFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSnMNF1Gn4unmh4luPZIjjljOkmN6s2hZCG/J7HH5cw=;
 b=gJDULoL3e3oZEkcy+H8Q/9ZwC1ion/ri0oeYvc8In59eR3ikP0nRO5/TUDDHlVpP7jyDmhlbTBTPJ5VV88uVVL3GerYtCOBlYl7EH/dNO5o9GhLze4Dt4GzZ5TQtAqg+GrrxA9gAKMRrY/Kuxc3/vHBrVkzcgiJYUrIPKz/cvAmy2wF5WmJD+sMrTgAzpb0s/8efLUzPA2mwcfZiQP3Old6qh9W3nfr3wDr/0tA6Dw38Qcv8xU0QsHmiifJPyT1M/iC+wR+CJOvFDwNh7U86kIaZma2Dft7NFtAmba9P3pWWu83sQn5ZPYF9HqixXdFSysK/mwLhvQeJwj/LwxPTOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSnMNF1Gn4unmh4luPZIjjljOkmN6s2hZCG/J7HH5cw=;
 b=0Pv3tUP2JZNg5BMUSAhp4CDyqoL6tUp7MAzjaI+ZfMODIM8HOtfJZ6ySwNKowqMZ4cZFZZ7YsTeodNJC+6QZ6PdAc1Ke51YHxtb3p1qEdXeKgR93Jt1XLwonDKeLJjZGffAN7NKlX2Dc4wnX36K9UlHn2M4ULq6d6T8E3zwHTbQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB1658.namprd12.prod.outlook.com (2603:10b6:4:5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Tue, 1 Sep 2020 14:22:44 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::60b8:886b:2c51:2983%3]) with mapi id 15.20.3348.015; Tue, 1 Sep 2020
 14:22:44 +0000
Subject: Re: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
To: "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20200901011727.14059-1-Dennis.Li@amd.com>
 <41d0b931-653a-0aba-2ab8-b51c459b2012@amd.com>
 <DM5PR12MB25336BB24DD7E7E6BCD04A4AED2E0@DM5PR12MB2533.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <f18f05f0-8b9e-5b6f-85da-fa8be56ad1ee@amd.com>
Date: Tue, 1 Sep 2020 10:22:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <DM5PR12MB25336BB24DD7E7E6BCD04A4AED2E0@DM5PR12MB2533.namprd12.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To DM6PR12MB4340.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Tue, 1 Sep 2020 14:22:43 +0000
X-Originating-IP: [2607:fea8:3edf:49b0:cd0e:380:6380:d603]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7bfaa0cd-3ad5-4629-8f45-08d84e827e0a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1658:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1658DB90E12ADB64CEB77819EA2E0@DM5PR12MB1658.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbSiHQw1AWLVd10RyoOuRFK9LhyneuKwwE33FiymZtbCIxeYMZgvU6Inx0fgJKSmoj6D7FaSUz6J7hlH9pdv55HEFG8Puc0LC+taLmHZ2zSDYIly5JlePCWX5gvLn6DhGknK89rtikqFQVzzC1SbIKEmiShs4yjBZ/IsPhOunlXmXqYw+cIkFTHNemK7zychAM/BLhJXt5o9oZuWyx7OvcfseA/uNQJJclZ5qwy8vnmXwSsib4Eu5atZ10YOn/mmeWRWET0n3CSyF0thq5PTh/JtSISz6TjgpUcujizj0mGclIjmH9aSchbIIfLklbJK+rvpcqLcf3Rho4/ccgHLBVePJ6Z19zGfiMxc4O/16oyJFFwTkSGd+KkgduSAVwLilcFzdUL0CEkhmsqlPyTHgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(66946007)(2616005)(956004)(31696002)(316002)(66476007)(86362001)(6636002)(66556008)(52116002)(31686004)(110136005)(53546011)(16576012)(8676002)(186003)(6486002)(2906002)(8936002)(83380400001)(36756003)(5660300002)(478600001)(921003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PD+BRPQEHLdSH6O3qdT0C60IVmG1BUS/J88qBe8J/9YxFcJutxQBGwVhhKEvrd8/37eGYotmwHZ60ck/zrP5NbN+lenJkOwJauSg3xZtLqIoPDFE91c5yV9L3BaHcrYb+gEZf5WACQfjsTMes0giNFgVdm6WfMyGBU7Co7F8ttkxlyHbP3uaJQuhOUWzGSTDO/Sm8llDHAdv/cccGjjtuDw4AIGhrC1L3fsOG+mTl6v4++8jpE8t5jWVUcRI9ecSXiYk/BNT4bb246OxxQbNrsj5HoAIxjLzx0JDHU2d2faPNEO7H9JPMQiNScgvNhdZZgnyXe6YaN76uSppAsCuaJM5sqAC9+eM1UhsYHKuvti43mKKpAbbIF08DiDtgKpx9239BtYezX60iiDCk9LS+O9Y4nmgiF8TUQFNs/Z7UnM/H75/Wkf46Bb3tL9E5cp3ruVlHdNqb+3qFGgsWodklcboSBteRmDwKFxeyViZXyHQmwouSgfOdFzh2dNsQD9K5kqaQq5patiXiSuCpyfUeWqEeIvJsnFIad3rpaemTTXQWO8GZ5nGNx/GQEfTy8Qn1oSZ+Etr/Nxfh16NHx2umk8YhOFBJ60bQ6v/gzPtxIi3Ua1UohBkTuwMNtFnxQ7FcR8HJM8O12zZjjz/1ezH+Ax4GErbT16ogHU1xwEy8yAms3Yl5h3R1T0907vDDKHjdX8sxgBi295aWtRqWVtCwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfaa0cd-3ad5-4629-8f45-08d84e827e0a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 14:22:44.1784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVH0FAMUmUGan0LBnhPd+szzn2FNV79ZNNHpufeaq3OGRoIG2Tm6AzJfaah+1VWb4F/UXLSzto2+wMQlRQnG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1658
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now i get it, I missed the 'else' part.

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 8/31/20 10:45 PM, Li, Dennis wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Andrey,
>      
> RE- Isn't adev->reset_sem non-recursive ? How this works when you try to access registers from within GPU reset thread while adev->reset_sem is already write locked from amdgpu_device_lock_adev earlier in the same thread ?
>
> Deli: down_read_trylock will fail in this case, return false immediately and will not lock adev->reset_sem. In GPU reset thread, we should use MMIO instead of KIQ to access registers.
>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>
> Sent: Tuesday, September 1, 2020 9:40 AM
> To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: block ring buffer access during GPU recovery
>
>
> On 8/31/20 9:17 PM, Dennis Li wrote:
>> When GPU is in reset, its status isn't stable and ring buffer also
>> need be reset when resuming. Therefore driver should protect GPU
>> recovery thread from ring buffer accessed by other threads. Otherwise
>> GPU will randomly hang during recovery.
>>
>> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 172dc47b7f39..8db56a22cd1b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -319,8 +319,13 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>    {
>>    	uint32_t ret;
>>    
>> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>> -		return amdgpu_kiq_rreg(adev, reg);
>> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> +		amdgpu_sriov_runtime(adev) &&
>> +		down_read_trylock(&adev->reset_sem)) {
>> +		ret = amdgpu_kiq_rreg(adev, reg);
>> +		up_read(&adev->reset_sem);
>> +		return ret;
>> +	}
>
> Isn't adev->reset_sem non-recursive ? How this works when you try to access registers from within GPU reset thread while adev->reset_sem is already write locked from amdgpu_device_lock_adev earlier in the same thread ?
>
> Andrey
>
>
>>    
>>    	if ((reg * 4) < adev->rmmio_size)
>>    		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4)); @@ -332,6
>> +337,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
>>    		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
>>    		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>>    	}
>> +
>>    	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
>>    	return ret;
>>    }
>> @@ -407,8 +413,13 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
>>    void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
>>    		    uint32_t acc_flags)
>>    {
>> -	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>> -		return amdgpu_kiq_wreg(adev, reg, v);
>> +	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>> +		amdgpu_sriov_runtime(adev) &&
>> +		down_read_trylock(&adev->reset_sem)) {
>> +		amdgpu_kiq_wreg(adev, reg, v);
>> +		up_read(&adev->reset_sem);
>> +		return;
>> +	}
>>    
>>    	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
>>    }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index ad9ad622ccce..4ea2a065daa9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -287,7 +287,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>    	 */
>>    	if (adev->gfx.kiq.ring.sched.ready &&
>>    	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>> -	    !amdgpu_in_reset(adev)) {
>> +	    down_read_trylock(&adev->reset_sem)) {
>>    
>>    		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
>>    		const unsigned eng = 17;
>> @@ -297,6 +297,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct
>> amdgpu_device *adev, uint32_t vmid,
>>    
>>    		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>    				1 << vmid);
>> +
>> +		up_read(&adev->reset_sem);
>>    		return;
>>    	}
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index e1a0ae327cf5..33b7cf1c79ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -501,12 +501,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>>    	 */
>>    	if (adev->gfx.kiq.ring.sched.ready &&
>>    			(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
>> -			!amdgpu_in_reset(adev)) {
>> +			down_read_trylock(&adev->reset_sem)) {
>>    		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>>    		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>>    
>>    		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>>    						   1 << vmid);
>> +		up_read(&adev->reset_sem);
>>    		return;
>>    	}
>>    
>> @@ -599,7 +600,8 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>    	if (amdgpu_in_reset(adev))
>>    		return -EIO;
>>    
>> -	if (ring->sched.ready) {
>> +	if (ring->sched.ready &&
>> +		 down_read_trylock(&adev->reset_sem)) {
>>    		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
>>    		 * heavy-weight TLB flush (type 2), which flushes
>>    		 * both. Due to a race condition with concurrent @@ -626,6 +628,7
>> @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>    		if (r) {
>>    			amdgpu_ring_undo(ring);
>>    			spin_unlock(&adev->gfx.kiq.ring_lock);
>> +			up_read(&adev->reset_sem);
>>    			return -ETIME;
>>    		}
>>    
>> @@ -634,9 +637,10 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>    		r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
>>    		if (r < 1) {
>>    			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>> +			up_read(&adev->reset_sem);
>>    			return -ETIME;
>>    		}
>> -
>> +		up_read(&adev->reset_sem);
>>    		return 0;
>>    	}
>>    
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
