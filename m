Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5484EEB560
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 18:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 243D210E0F9;
	Fri,  8 Sep 2023 18:58:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6305310E0F9
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 18:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMvzC8hcyv1YaafD1bbUR5PSVONnMgn3jENS0BoFS3AVLPi/yl6AeeBjomoXWC0I17qQ7k5pG4PvObZJgXltZdZxJyHc5iy7wCKNO+5hH7XyM6ePte6tLQ/9rdHpKEIGpUuTZDj4IWZiuPfaLGdhaSpUdm692+bicg1L2mnKdC06iksM1FPPkn9bOX1++vAu+gOzYNDpWLaSmw5Lc2f6iGeRfQAnaE7G2lYqPAuKS9n9AmieDPg1pFQzKkKi/QKsgAKbaH5VI5ucMeQgW9aaRMuQ2wfQof+8TSL5CJNBSbwpRx/QD+WssRdi8twfIQ/pRJQ1vP+/C8K8zYvhAG1t8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhFnwJBqWC0YsOGQgIJXzziYgRhULW6T8Fnht+fkkbY=;
 b=D0x/QYYzrx/vYZzowxCl4Nua8jaRw8jTpMz6c2sL5v9Js1Nj0RjMeY0DhMCoc5koc2h+N6jJi6Bd8xXd5LZ+41DVgMr6Ybhf/Y+4RDnIQR4QXokKZbPJrFCo3xNi6Ito+GpvWdIfPMQfdHuDBCWvnBPvbsJIVFChu8sYbcij7WZ/PothGdZKt5GlHvR3pYm+RBWw5F3KAiN95EkshEB20BMi+stqojMXIhZMYys1F02t5EfSZHRphenYGySWtTtvp/uNnTdWmx50qiVqx0vK/mfhXHZCXeaPk+7dU/4OCLMgwCLVRaofxsvhyNH6qTTWaDtmWFo+0w/OjDraqLdFIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhFnwJBqWC0YsOGQgIJXzziYgRhULW6T8Fnht+fkkbY=;
 b=b+cg8k0fpuIaSfbgyz5om+pb9Ixa55AHeQVGQsRgpNoBbryPfb/a9hqVSaE1bTSvLVTUHBw1i235wxv+Efzhw/ne2Qbxtv7vufoewKljNcf9g5o/CkOUlP+KOlNeuXZ+9hdP6G9SKBuOLP8jqfLDYwo/JzAeaTLY6E2v1e8o3PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 18:58:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 18:58:06 +0000
Message-ID: <42a4ca26-1698-7838-df27-ce1e21eb065c@amd.com>
Date: Fri, 8 Sep 2023 14:58:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 01/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230905060415.1400-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0163.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c8da85-70f8-40a6-ae29-08dbb09d8952
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8JORQQD+R8IF1gkouh26yWfXvEUts37h7t2P/WBObChhNXuIxSiWRloS+LK+1AYyvCylGN2t35XYMYIF2iYlF9y043MXcAneMX0FzmQhk5AnPeJf9EfzipRNrvFhvfnlw0Ah8K1KH8enQTJqK1+N9DL0BoepX5zQXRJwaH07LtEhtBPibeisQeJFipW4HZuOyWh9FK5It65M3ZWlOVFu8kCc5mgYk91jiXS4HUYpgAA/hMMa6PWowlXw7xitjdX9fD5AorgAbqjp2aMLlzdy7mYTViSZHobXCLjkfEMKQ2TY2WZwxhu1k9aFOQYspAYz4K62ozXf1/+jBYa5JWdhLfuqgIevPbBFlgxxUFXlka/hEcyc8arvKxN47KwjEsFKOn7ubt5DiGI9u7Y3XkSZ18lrJ+UCskRJozMN8lYrBn34e5m+x9o4V/yuX2IEIUR8MtGCm3MXzCovRVWmBaeNSw/QPbDms4vbVgzId7PJJp3y12+MOcCQx/BwLCZcacpIbH+8oPmLZaWbpZVdY4mEqTHWdPkIEyYM1LcYr+SbyHX2MWVDSDIjcdALq8Bs4uQ+qiicgfS9RLUKpx3932GwZHyVGQQ0w4NMT2YfKvI7lvFvX92f1dXc/KzuNdq0ac6WPDgLtfpfGHThVGFvdgvvCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(1800799009)(186009)(451199024)(2616005)(38100700002)(26005)(36916002)(53546011)(6486002)(6506007)(36756003)(6512007)(83380400001)(66574015)(31696002)(86362001)(44832011)(5660300002)(41300700001)(8676002)(66556008)(66476007)(66946007)(316002)(31686004)(4326008)(8936002)(478600001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU9CeTRNSXFoTUtxaSsrMlFBT1Eya2VwY1I4M1I2M1REY1NYSUI3SWFSUFFS?=
 =?utf-8?B?UnAxblFuMTNNeWF0V043VGV5djBWSVo1NEhVSm45YVY1NVI2YWlrbDFMSGdx?=
 =?utf-8?B?bjY3dXgyS0tQSmo4YzZCMnZoQjR6NHV2NzBmLzZwWVZuNk94SGY2WmNHVTVq?=
 =?utf-8?B?WkFDZ1NEMGFsZ29Pam5XN1l1MlM2Zmlha29BZFVlVC9rdThiTW56YXRXRUVW?=
 =?utf-8?B?aTEwZ0NoRXIxMmdZQStaZmQyZVRaOTlsaFRWZFpBdWd6Z1VOTTZsQkdyTWMy?=
 =?utf-8?B?SEsraWRHVjZJemJMOTJWTWYrUGRQRW1IbThONmN0aXRHNnJ2eW5rQnRmTDNP?=
 =?utf-8?B?TTVpZm5aNzc5N3Y0R25JVzRiWUpIU1lZdXB1eVYveWZLTml5RXlVdXJhUmNu?=
 =?utf-8?B?eXV2cVV3MXBJZVRyMVNrcUhvTVRFN2p5K2E2bUJaenlWMG85SWUwV1V6bmNz?=
 =?utf-8?B?eThJMWR0aWFEMTNnR2pmWEp0enNRTnUzdi80NmlkcnZmUHE1NTNiY0J5OWlI?=
 =?utf-8?B?MlF0SlYxelpRS3FBYUc2aXhTMjdpSXY4U1ZEdUYwaUxQNS9SWHRGTEtIRTFP?=
 =?utf-8?B?M21rL0lnRUF3ZFdMeVIvVTNLZmlUMlVYcnJmWXQ0Tm1velkrdGlZcXNvRjFm?=
 =?utf-8?B?NkVSVE1ybE4xZUZiem5ndUt2a2E1cys3RW5uU0pZc05RN2hKL2VWUjM1OXFm?=
 =?utf-8?B?OEthM1hVZTlvTmtuY1c0U0IzMGRjL2Q3OElhRVY3MFI5SEJ5b0xIUEtDTk4x?=
 =?utf-8?B?R2NqOXRkN2ZveG9IQ2tZbGw2WjkxSTFka3N2SWZPeDNSZnE2KzF2Q0VQSTdL?=
 =?utf-8?B?ZS83VnFTNVJFaXg0cnVmTnRPQktOR1pSMGhUSGE4aUE4cFhoSmo0eERKVEVr?=
 =?utf-8?B?b1Y0RFVEVzdhYm9VYTVqeW5qZUt1ZE0xQVJLNElDU2JvUGoyVE5JSDZGSXVF?=
 =?utf-8?B?Q2hyTjVMR2dvZGpUd3N2T3JGVm5EL1lsdTJtVFowaFhFemZ3YWxDZFI5MDhY?=
 =?utf-8?B?dS83SG9POUovOXNqTjVmSCtkaVVpemZNcmJ1UW1KQ0F2ZU90c0tKK0grMCtT?=
 =?utf-8?B?dTM0Y2NLYm9nSWpHTTRheFYvVndPZlJoRDNQMDUyeGFHNGFWcEgvWUpFalVS?=
 =?utf-8?B?SlZSMzZ4a3pzQWlCa0xEQ0s2bGV3RG5hcmQxcUE0ZndNckZmOW1qTzZyZmc3?=
 =?utf-8?B?ckkrZ2lia0Y0VDQ1WXROWWczVGtjYkoxTFlDdVBGZWE1QnZHdmtRMHIyYW5X?=
 =?utf-8?B?eTNRTWZwbkRvamhLUWdkeG1oVzZ0c1lzSHFxdnRjeXFmemgzdjJCU080eG5y?=
 =?utf-8?B?UExjMU9RcGcvem9TandQcHVUQkpOYmxOT0JYc24vUUUwNTBYOTA2NndwUTMz?=
 =?utf-8?B?R2VlTkR2c0JPZ3lwMmtzUmpUUlRKbjAyWnBpL3JYbFZSQUNxQUdnMmREQkho?=
 =?utf-8?B?VWFKNVIwbGJ1czFzTzZyQU95YVBMZUlwbUdwd1VDZEZYbHZjNHgrSkViM1hF?=
 =?utf-8?B?Vm5OYjh1Mis3WE1oUEZsOStuU2NKenpPL0dXeHhvZ09VdjFuL3Z1ekhxRlBu?=
 =?utf-8?B?U1JlaHhZOXVEckdxeTVuMkFlSHNFeldFMU05dWFuaVEwRU5ZSlFLQkVIOEJR?=
 =?utf-8?B?ZDZxa3RuQVZJbEs1QU5VN1hqS1NMRTNGZmxUT2NkN0puSXZuYjNzTlFmSVNm?=
 =?utf-8?B?ZEM2eGN6YjE5Zkx4cHM0RzVWU0hCa21sVmNib3VzUytNeEgvT0hwOHFpV04r?=
 =?utf-8?B?RTkxeHMrbHhLQzd0SWZpaSszcE1QNm52dU9ETEV2WmxUVE9kL2NqdzlSd01r?=
 =?utf-8?B?d2dXS25Obmt1YUZIM2pGZDdQMEtZTW1KSWFvV1h5NVlLcTNyRWtUaHNLNVJF?=
 =?utf-8?B?RFd4V1pnOGNyTW92ZTZOZmdCWnVSMW5rSW9QTjBkOUZRdHg4Z3lreDNpZDdM?=
 =?utf-8?B?NnZGOG94R1RHbS9paG9RcFdvTkg4bjdrZWlFV1J0M29uZnA3NWNoYTY3VFo4?=
 =?utf-8?B?dkJVVSsrVlB5K3E0VUlMSHI0MTJ1UGNYSnN2ZTRPb0hvcVdyN0VmNzBHWGE3?=
 =?utf-8?B?Wm5hQmQ5V2t4RS9jRFZueGVPeEs2V3QxVVpvbFpPM29kVEk2TCs2L0lhdmpH?=
 =?utf-8?Q?t7G7k6UcaSUQryqE+t025+Q15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c8da85-70f8-40a6-ae29-08dbb09d8952
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 18:58:06.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gSZXL5MeHHsEVSICC/3X+YKhOF9aO5g6AAqXF1KQCIJ3X70uFndgjf2/i7IMNYU/cwrR18O2K7UHT73HREm/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-09-05 02:04, Christian König wrote:
> The KIQ code path was ignoring the second flush. Also avoid long lines and
> re-calculating the register offsets over and over again.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++++----------
>   1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 0673cda547bb..4f6990ba71cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -814,13 +814,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   					uint32_t vmhub, uint32_t flush_type)
>   {
>   	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
> +	u32 j, inv_req, inv_req2, tmp, sem, req, ack;
>   	const unsigned int eng = 17;
> -	u32 j, inv_req, inv_req2, tmp;
>   	struct amdgpu_vmhub *hub;
>   
>   	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
>   
>   	hub = &adev->vmhub[vmhub];
> +	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
> +	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> +	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;

If you use SOC15_REG_OFFSET here, you can drop all the if (vmhub >= 
AMDGPU_MMHUB0(0)) conditions below.

Other than that, the patch looks good to me.

Regards,
   Felix


> +
>   	if (adev->gmc.xgmi.num_physical_nodes &&
>   	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)) {
>   		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
> @@ -852,6 +856,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
>   						   1 << vmid);
> +		if (inv_req2)
> +			amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
> +							   inv_req2, 1 << vmid);
> +
>   		up_read(&adev->reset_domain->sem);
>   		return;
>   	}
> @@ -870,9 +878,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		for (j = 0; j < adev->usec_timeout; j++) {
>   			/* a read return value of 1 means semaphore acquire */
>   			if (vmhub >= AMDGPU_MMHUB0(0))
> -				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
>   			else
> -				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
>   			if (tmp & 0x1)
>   				break;
>   			udelay(1);
> @@ -884,9 +892,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   	do {
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
> +			WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
>   		else
> -			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
> +			WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
>   
>   		/*
>   		 * Issue a dummy read to wait for the ACK register to
> @@ -895,14 +903,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		 */
>   		if ((vmhub == AMDGPU_GFXHUB(0)) &&
>   		    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
> -			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
> -				      hub->eng_distance * eng);
> +			RREG32_NO_KIQ(req);
>   
>   		for (j = 0; j < adev->usec_timeout; j++) {
>   			if (vmhub >= AMDGPU_MMHUB0(0))
> -				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
>   			else
> -				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
>   			if (tmp & (1 << vmid))
>   				break;
>   			udelay(1);
> @@ -919,9 +926,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		 * write with 0 means semaphore release
>   		 */
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
> +			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
>   		else
> -			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
> +			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
>   	}
>   
>   	spin_unlock(&adev->gmc.invalidate_lock);
