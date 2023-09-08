Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39BAEEB570
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 21:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2F610E95A;
	Fri,  8 Sep 2023 21:13:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDA510E95A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 21:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKn+wy4GO6pZDUMdy9WXnD58oNKPZBTSpaRWQRt2YGWr/yxS0fUDyL+2vS5rQB4emEomW6aNp60XzP/Jzyo2kvc7TD3n8PeyAysd38+sKxkpUdLYi798ZxgHhABI6JX6TUIcdEmLI2W4yzFsjIJRBq40CuaM61r2HyBcrYpVvXyGYlOo7qoihqIX8xUVhE3X2VDG6EcSAPQRNJufOSvo9U73o6bE+pX6yOsbtXfSU6r7WOIyGa1RwGSQq2TpWqnaj3Vm7LYzdGYwdeaQakvZXqR/bfm+VJmeuhpO+W78qMYrik8yaGtjWElN9WEPxovSyL0rLX5PHpmVfBf7ZPUMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiI+/quLJ8eNd/6SSY3zi/luDHNagp5r7hPmdpKBNKM=;
 b=n9+TWYANznCZZsWObB2fG0/ZhplkhSCvI1A1xWPwa5rL2APNksjZr4+uHgVvwm3omBXm4XIURmV2+EI/gaKq6GxtsZR9CfPQ510f7r1OBowqMgm6B4q2qAvTERqHLT+/Lc9c8QBG8OqnImXfoyhxrokrKcGD9s3jiWcoUWpNQyPZO3CwB7REtBq2zbUqGAepUwp+5XXVXd+MVLXxknBesxWC5dnjsJogHwtuBn+BzHPJn8DAgiLqYHxybpfOrURSAhe8lceLIeMECh6rd8dyGk/5b8mgiBEYBzj9IInJtEXHm0xwHZ0z7a9U2j9chGlk+JynU2QDV68QvCtYLKRm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiI+/quLJ8eNd/6SSY3zi/luDHNagp5r7hPmdpKBNKM=;
 b=Z97W+94e6a58lqOgCUQXElqnoyBPpZFz8XJ87tSquZVewUgmgFemOfSUP5WV0GVqyj9GVvATp7T62GP1sWjZASdXwAakFtqZ1b4pbdJLjgdyAb6q67zrx+cOkvMeufNaMz4bDhZNl0JI5DZ63tMClEFn0nsL0zeIzIAywhd0UFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 21:13:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 21:13:48 +0000
Message-ID: <0241c3f2-4a45-a91d-8682-ddb386662e98@amd.com>
Date: Fri, 8 Sep 2023 17:13:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 07/11] drm/amdgpu: cleanup gmc_v10_0_flush_gpu_tlb_pasid
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-8-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230905060415.1400-8-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cde26fc-5b53-4a97-7dd8-08dbb0b07e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+IvpXOktrn7NCBLwHNr/MNSnOGe4M+GMzRlY6ywkCzEASUrqtJfq49TnqO7Qc2GPwrbiOwBlgR5mf0Nzp7ZW7M49e2sYOof0rRUlZIkB5j5CUYwQyVB0YjJKr8dfbIQbkHdC9F13OeVbZrlAWDt23eZ0SXlIW/h6dqWLKHoIMA/TPzwwsYZ79osjJzdtgZHOw9FsnTY+4QM8ct1ft9ILe7bqLoUFO2B1GnxLG2ELOVuaPb2d1d3T2HPNtSkaar3xVy7cEGvg1JQWDZZ7zIcb5JIkNyqkQYHTpgG1lUD4VpcMQV5TKuISNjxkAe3/k9DkQhlmyhlXEjlSEeBcoj7/DFrd0FKzoCTRbiPzO5NfvoPGfMAmo229WxCsV3Bmk7BNoI8RHXjm9DUcIr/tv4IL6DITSbfTFRyrstWrGAlp2NpwoJXn0RJJUOfOKPzt2NqTDfS+8LIWU8PDqrtHP9ChhEAEjikZXzbBjs0IJBCQ+U1fjnVl9z7irP5mdV5HWensZPPMCgMJQxloVBJ+hDyUqCAecYDn0fg2hv/8A8nZ1H4s4juEQaGPR7DoL52WGd4udK3MU6Jms74OqIqFpwl349JYySaqlO+b083y2YitCjs5ElfCZ8j8yUxWhh8QL5PgaFv3EXwNGpBRHZqxzchyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(186009)(451199024)(1800799009)(6506007)(53546011)(2616005)(478600001)(6486002)(4326008)(66476007)(66946007)(316002)(66556008)(36916002)(8676002)(8936002)(6512007)(41300700001)(5660300002)(83380400001)(44832011)(26005)(31686004)(66574015)(2906002)(31696002)(86362001)(36756003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFxdHR4WGZTbE9DK0xoNGRSdnFrbXZTSGZTcHAxWUdUWGxBMHV5Tmd3Zlk1?=
 =?utf-8?B?MGxodXovT09ESmJReWtmMWt2TXJnYXUyTURSY2RQZ2ZGc0FwTEVjOGUycGRz?=
 =?utf-8?B?dHRYandUSThRRHlXaGI5S0xSenBPVUgxREhGdWp6RnFxc1VBL3lraHFpaVl0?=
 =?utf-8?B?b3pnNzdWendTKy9QOVVDK0ZDMExZN1ZtVXlzVUUyM3V4eU5DbG5WZ2R4RkpN?=
 =?utf-8?B?NVBNKzdUYXIvRTBLdHVjZHUrV3VjNDR2SHVoQTMvV0NObVE1K20wYXh5N3o2?=
 =?utf-8?B?QVRKNTQ5cllxVEFaRmxXVXkvSGJ1bzhiajhlMitUUXVQRTI4UmVnVS9YeElj?=
 =?utf-8?B?L1A1TjhVTjJXeTI0dC9JY05iTjd2TUFBTUZ1Ym5aQi8wS2pBNXZzeWg2Ymhj?=
 =?utf-8?B?K1NRMUV6RWpHYjlpWGNFODdMaVdvT3ZvWDJUeDBtLy9NQWJpSU5ENFRlSVNn?=
 =?utf-8?B?RGRJb0gzdmFXbnhJblpndlUyRFV4dENpcS9PSXZxNXhBNW5ETkFWSVN3dFhL?=
 =?utf-8?B?NE4rbEZuMFUzam4wMEpSZUhpQ3BZSTkwakNiN2NFNk5WN2g2L3NVTmhUeVZT?=
 =?utf-8?B?cTRGMXB6VjVPR3dwWDZhajlFbTVDd25pNzhBSnRYWjJrRFByVW5kYytJVlJv?=
 =?utf-8?B?TWVxdC96OGVGMWhKdmpyWjhvaHhiYnk5Q21qNnlyUHl2WG5zbnRKc0R1ZzBk?=
 =?utf-8?B?SERyMDhPMVRORVNBTmFJdkNLcVFHQ3Iwd0NBRWovNjlid09KeTk3ajlvYWQ0?=
 =?utf-8?B?NlJNRFVsVUc3bzlrZVYxTkZYdzFtaHpBVkVXNFIweHUvZithcFRvSExyUWxu?=
 =?utf-8?B?Si8zc0laenhYbDNPVW1TR1NBaUd3TTNRSVR2cG83RzVHdEkvRHloOXA0VmFw?=
 =?utf-8?B?ZEEzb2FLRDFvem9CMDhvZjRpNndVd0xKT245UWh4T2dUck1wa3RHQlRiSE1S?=
 =?utf-8?B?RGJoa0Q3YWlUTU91RGFnUUpudTc0emJxTGxDQjRBZEtrOEJYZ28wM0tWQ3or?=
 =?utf-8?B?b3Z6Z2FtQ0FRc0FueXQ2OEc1ZDJ4QXNzL0tRekJYRTc0K1hyZDQ1djhLNzRT?=
 =?utf-8?B?OHhyWWcySW1SV2w3UUhXTjQ4RVhMSlc5RVh2aWJYUUxpc3Y3NmVQS25wNG1C?=
 =?utf-8?B?TzRFMlZ0MEVUREJrQ3JDeWNVbjVYZjlORU1Nc3NpdVEwajhSWFRuc0lTT2pi?=
 =?utf-8?B?ZVUxd0QwY1h1ZFMzTDlEQk9pVE83dmJKbjY4a08wSGs1bk5jVzRHM2pLclZC?=
 =?utf-8?B?Q3Zhazh5aTM5aGNVN09Ic3dtdkp5cGtwK3ZUYzhoR0Q3OHIwcUZBdk55UzJX?=
 =?utf-8?B?MHdQeStJMWxYb1R4ZXhIR3dEZWVRY0dDRGt2c3ppTStKTzdET3lZUGs4WTlL?=
 =?utf-8?B?SkpJS2h0dzlSQm1TZWp1V21ENkNKUWViQmVGTThKR0wzNFBweFdocEpuR0FH?=
 =?utf-8?B?YXdOdnZudEcxZUZ1eGtXVjVNMmZZL2luMmhWQWtIM3pYcWtMRFdBT1R3a2hR?=
 =?utf-8?B?TmhxMDhwRmc2MitrQkJnVFh0dmlDYUlOQ0tpVUJWTVBSVEVINVZWNEovSEhT?=
 =?utf-8?B?a0VVQmZTeXJUdWc3WFNPcWNMUlNzQzJLbHQrTjg1U3lBMm5nYnRHZjlNNEZa?=
 =?utf-8?B?cW9jVVNMZy94NDNNalB0MEIzN0dmWXFrWnhUSUViWnJrUzFGN3RrT0pZakF1?=
 =?utf-8?B?a0NKN2thRDJ2NUF4cjlzUU1lcHFQaGNUUXE0QmtXUmV5bWdxS2dFK0xMd01Y?=
 =?utf-8?B?Ymptakw3K0xxbG9BM2RrNTVuNkJYSlpRU21xclpVVEZndWFxQVZ2T2d0NElt?=
 =?utf-8?B?bUJjTlRDd0N4T3VBYjhBN01lakN1U1B6S0lOZzdpdW5HaFB2UWljbFVYdnI1?=
 =?utf-8?B?WGY3V2V4MWZKL0ZLM0N3MnhzUVB4Szg3UEtaelRrbEJGL1V1RFd3bzM1aXdV?=
 =?utf-8?B?THRMUXVHNG1leUpQS3RQZDRzaTBTY0xocHZjby9odlprSXp2QlNCN1U3YnlG?=
 =?utf-8?B?VVhjdjhLOVAzNFFEbmhBemZJcUdmZS9COG9td2l3ZGJaTWgzN2lGbGY4Q0l5?=
 =?utf-8?B?d1IyZk40SWlkTXBiVEtRSThUN2dZUmxyREpaM2M3d3UreU9xeVVDdEpEWXFY?=
 =?utf-8?Q?yY5Gua3E7muq8bl48UQAGWcwN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cde26fc-5b53-4a97-7dd8-08dbb0b07e85
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 21:13:48.7845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdpAhqK8JaDcRwhVkxNGrjlEvNdCtPL8VbWZuiSqRzG1grzI+wEV690Wsmhy3eaDMY/jDcmTXCfdolgW+T8hKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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

Patches 7-11 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


On 2023-09-05 02:04, Christian König wrote:
> The same PASID can be used by more than one VMID, reset each of them.
>
> Use the common KIQ handling.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 66 ++++++++------------------
>   1 file changed, 19 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 1f70c57bcd69..407ddb926941 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -341,57 +341,27 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>   					uint16_t pasid, uint32_t flush_type,
>   					bool all_hub, uint32_t inst)
>   {
> +	uint16_t queried;
>   	int vmid, i;
> -	signed long r;
> -	uint32_t seq;
> -	uint16_t queried_pasid;
> -	bool ret;
> -	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT : adev->usec_timeout;
> -	struct amdgpu_ring *ring = &adev->gfx.kiq[0].ring;
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> -
> -	if (amdgpu_emu_mode == 0 && ring->sched.ready) {
> -		spin_lock(&adev->gfx.kiq[0].ring_lock);
> -		/* 2 dwords flush + 8 dwords fence */
> -		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
> -		kiq->pmf->kiq_invalidate_tlbs(ring,
> -					pasid, flush_type, all_hub);
> -		r = amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_WAIT);
> -		if (r) {
> -			amdgpu_ring_undo(ring);
> -			spin_unlock(&adev->gfx.kiq[0].ring_lock);
> -			return -ETIME;
> -		}
> -
> -		amdgpu_ring_commit(ring);
> -		spin_unlock(&adev->gfx.kiq[0].ring_lock);
> -		r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
> -		if (r < 1) {
> -			dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
> -			return -ETIME;
> -		}
> -
> -		return 0;
> -	}
>   
>   	for (vmid = 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> -
> -		ret = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
> -				&queried_pasid);
> -		if (ret	&& queried_pasid == pasid) {
> -			if (all_hub) {
> -				for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
> -					gmc_v10_0_flush_gpu_tlb(adev, vmid,
> -							i, flush_type);
> -			} else {
> -				gmc_v10_0_flush_gpu_tlb(adev, vmid,
> -						AMDGPU_GFXHUB(0), flush_type);
> -			}
> -			if (!adev->enable_mes)
> -				break;
> +		bool valid;
> +
> +		valid = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
> +								  &queried);
> +		if (!valid || queried != pasid)
> +			continue;
> +
> +		if (all_hub) {
> +			for_each_set_bit(i, adev->vmhubs_mask,
> +					 AMDGPU_MAX_VMHUBS)
> +				gmc_v10_0_flush_gpu_tlb(adev, vmid, i,
> +							flush_type);
> +		} else {
> +			gmc_v10_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
> +						flush_type);
>   		}
>   	}
> -
>   	return 0;
>   }
>   
> @@ -1009,8 +979,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   
>   static int gmc_v10_0_hw_init(void *handle)
>   {
> -	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +	int r;
> +
> +	adev->gmc.flush_pasid_uses_kiq = !amdgpu_emu_mode;
>   
>   	/* The sequence of these two function calls matters.*/
>   	gmc_v10_0_init_golden_registers(adev);
