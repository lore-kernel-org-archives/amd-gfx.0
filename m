Return-Path: <SRS0=Yti/=P5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF775C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2A5611AF
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Nov 2021 03:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A2A5611AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1486E042;
	Wed, 10 Nov 2021 03:06:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D7096E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Nov 2021 03:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIxrEkCTb4wnqxBSCSKoCK9Atyum+BLF3a4nIX85QNV4rj7HaFvPhaoaTM2UgNt4WWQs9nvZ7f4y8BcQv04kY8KtzKpQ9kR64QP1DBW3NHFm6+x7lz9vnzjS0j6x+gV9aovoYu4l5eolMlwMozRoDF1Q8II2V8nTXQiH/kejur76ViKryYu7a5KH09DtIiZ4vU4q8khk7eqYouPGcbhvDCEP+JJOYL12fbndU8PPYCwmw7jMFfIj3BPbJbpQ9PMJ/bms1VUfWWYajbl1vEUY7E1+MMMDOxHjCRafbRju4vXG6nL66Ke4wPCVZrhpalImZ1CH6J/Gwc2Z6o8EVnEImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+vmSup0lo3ltlSRzpbidpFnNCNCZi0XSxdwlbeXZYM=;
 b=FJeB3Zzk9TzPp4GXt03AWrrdsrzrx2OcXTzYJ/OUgqdRcqnmQ9gveHt5ff/t0hg06HSnO0oyZOrJJeeGroPaKf1F2fxqzgkdDptWmUUQOmAnRCwol+Q6/DM9Px2YjVIROprnA7eBEy6IUTYYbOj0Kb6F1RLVd0RlMfxgNqx6tVOXx7wkjBPxqlXL3EO/VKWJ9dPMzUo9DkZQgIGWJu5ajX7vDKldeFFXfdHUaILW81B7cLr5CTtfj8YSShLwwkVRNjFP2HQtcqW+kaV+aR9d+CLemVMIqPFGkoeZcxJX0C9dAIv/6o5qfyCyiJvQ1W5j6FUDUndjYiGqqU1LWfsLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+vmSup0lo3ltlSRzpbidpFnNCNCZi0XSxdwlbeXZYM=;
 b=dqyxFVd3k9Y5DKoJdHhikOLxzPjsA7IvbGHjc/Z1gAlAYuoIAtC+OHkB1+LB4PucVe9CqXoB9gD261mkBCMCg4EY9SYhrKyRqFQs9ZsWIxDKW/feU9b8ZuLcVURAQmAwHWHPlvFONREf5NVXUU+wdZMaXBWXys4BJ3X0FHHex/o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Wed, 10 Nov
 2021 03:06:22 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 03:06:22 +0000
Subject: Re: [PATCH] drm/amdgpu: Pin MMIO/DOORBELL BO's in GTT domain
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211109191250.20157-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <a9f2b1e4-34b2-c86e-af75-eb5126b63866@amd.com>
Date: Tue, 9 Nov 2021 22:06:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211109191250.20157-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PAZP264CA0092.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::22) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 PAZP264CA0092.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 03:06:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d391a2f-1333-447d-c7e3-08d9a3f71305
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5080DBFDD66C2EE1F5AEC98592939@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRrpzwQXwOEr6/lL9SXKkwIABnS0L1j0Qj6PThzohV83u4UX4Jsw/yp9iZn8yNzvLPu7nCW0qHcmlgMpp3APwdhcWM8FpKFpriVAa6lWNiMl1QpERaQNu9ZKb9nafS4nL4FtEubANkXXDkkzLW/LWrqQw/63HI3LPB1rcE5fpMqsVRxwNlXidEhPMWt/L2fGo/4JDJg9WGVVqY+d47/KbrqqOep9vehIYeHFcjxB2T6aay1gZbxcdAG70eevqTe3YlREcCiYt8mEQq14LPBN1iv/p5lTCAsjLEsJ1JxrjFVjqQKkwLOUCwqRdozJvxjsi6SmfHRgO3AR1g5RlolUoalN4qB+ik+1AcByFlQebTNcuzHmyfmMYRhdsBy+ZiP1TRI/6Ic8SamXnLgERuj0beU302j/RGjRAYwfOxz/Qq/vFFgDva8vFp82kF/UXLAL/yTskDa1McYw9fCVJRRyf+PvsLcixrcqo8v4OsVwtxqg1BI6kge9klE8dav6tndODtbt6X80znF03SXVEByFR1wC6vgCHiRTykovWOvsALBGayGikE2cHckUOn5CJ3PZEfV98LL/VRgqgA3uneC3DqkQZLt1aRrgTm7a3YCjtEw9yz8zm6ECDDi65iRG9Sst6pH4x2i5qGD2/ML+tFS2nvx83I2VfDaOD4xXPZX6ZD8RPFYAfrCEAyVZq6km0uhcPcuwhkaUwZBEqsRBgT8QUfX3aR5aA8UtIfBPbpKyHZZhXPfwmyVirhrt7HPMUC0f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(8676002)(316002)(66946007)(66556008)(66476007)(508600001)(86362001)(6486002)(36756003)(31686004)(2616005)(83380400001)(186003)(31696002)(26005)(44832011)(36916002)(956004)(2906002)(5660300002)(53546011)(8936002)(16576012)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFl2QzdZQkdJUWlmbDJmS0VuU2hqOGNPbklkM3Z6cG9vOEtUZW9OaUNCRkJR?=
 =?utf-8?B?cUJsN1FrVzRJNy9qNnNBV0hnZzVLVFRBSERBTnIrcjdRUTV2cGsvbEZoM1Jw?=
 =?utf-8?B?YXFGcWdhaGFFYXllelBZa1V1d0cxNGYzMEJxRHR6dE50RzZiZ0pjdTRNNVRT?=
 =?utf-8?B?dUMyZHl6Qnc5UVUwNkVzenBKdWVneVhFTlFoMXJwdTNlZVJzRXpNQngzN1F6?=
 =?utf-8?B?N2tJZ3pmRUtxMXZ4L0pKV1cyN1VuYWdOczJXRWJZay9EdU1xMlpFWW5LTjdo?=
 =?utf-8?B?dEMxbFF4Q29CZHpxSzQwd2NJU1o4cS9PajFuTGZBQSsrZjZiQnVLN0RQT0RB?=
 =?utf-8?B?bVlNaDNPbE1id1J0NU5BdGNnYmg1VDNSMGtYVmhDZko4a1hNam5xRllKOHFu?=
 =?utf-8?B?d3RQUUwvcmcyK1p0SUtzc002U1JpaEF1czZZZGw1NEhVS29lZE5LdTlvV09B?=
 =?utf-8?B?bVFsVENRc3NiSmJmVzRsY01VZjFpNnU4WW5NRWlkMUNsOHJSaGhRUFUvL0Rx?=
 =?utf-8?B?Qk5jRmFPY2RaRng4N3Axd04zK1duZ1FJQmp5bjA3SGFYdElTcVZHSC9kSmw2?=
 =?utf-8?B?M3B6MW02M3ovdVdZemRPMy92SGNNYnB2aTJkU3Q5L1V6N2N3UFJUdS95KzF3?=
 =?utf-8?B?VjBCdmd6bWZqcHJIUCtpeFZib3BBdGRreVFaQTcxSy84WVV0WFBYd3M2eUgy?=
 =?utf-8?B?cmxrcUFjT0pZOGVxUzBCS3YxSkRmRFpjckg2dml1SlBKUWJmL3o2cUdGNzYy?=
 =?utf-8?B?RUZkQ0ZXTnJUTWpVd0RuK1NzWkliNC9vOWRrNE9MM2txK3NIN25ZY1pYVGlV?=
 =?utf-8?B?c1ptSjBIMGxQczlCb3dBUzYrVE9ob0dzbHFsUmR0RzRzaXlZRld0elVRWTV0?=
 =?utf-8?B?SlVLWWtzd3EwMnJpeTFXenlkU0w1RUVrNmd1YkgzRS8zZ1BJdFVId3RObGhY?=
 =?utf-8?B?ZGVmTWI3anNlK28yckJLSTdxV0hVUHlPY05MWGpEanhjSCtFMnJ2Rlo4ZDRq?=
 =?utf-8?B?b2wwMG5RdythNDZzeGt1dUNnZ1VHcDd2dXBEN3c1K0ZoL05vVHAzL1lSdzJC?=
 =?utf-8?B?TmxFRHNrSlhWR3ZZYW4wNWVueHNuOURkL1dNRktYWVRYNkQrUlVzSHJ2aTNa?=
 =?utf-8?B?Y1Y5TG9mWmZpZTYyNDQvL096eE15dEpMdWcxYUE2NHAvTkQ1NmRJMGpwTVJo?=
 =?utf-8?B?eUZlNnNYSnN2QlA4ODJYN3lYVzBHaXd4aFQ1d3FXTnczN0ZnSU9LWmJmNHd6?=
 =?utf-8?B?MXZFMU9RMlBsenRXTzRiUzVhOThQcGN5WGJhUEFSUmIrdVVnMVBlS0pRNlFn?=
 =?utf-8?B?VHVaNGNtVkw5TW1SbzVaUDdjTWUyY1lyaXlHMG9kZGRGc1dHblRNc1VpWm9t?=
 =?utf-8?B?YjN5V0lEdjUwSGNKM3o2WDQ4ZjVOZGlwQXplK1RxMFdHZzRCWmlWTEtleHBk?=
 =?utf-8?B?b0tlcHlIZXZKcHdjT3h2NlN2ZHJIM0kwTTRvZzNIc1k3dmNxaFdxcUJOc3hS?=
 =?utf-8?B?a0FVVEZjdjl0am1VTkJGWUtJYW5jNmM3UjUybitIQ0xYNStWU3FSTEw1TW8w?=
 =?utf-8?B?dmtYRDVrczlHWEhPcy9SSXc2SGQ3WXFBZDNlQ1JnMDBLMnZpemlKN2lRdzRp?=
 =?utf-8?B?dG1tRnN4TnllSUg3NmZkRVdrTTBTdUtYTkNHVEFOcm8wdkQwdWFEOGwwOWxF?=
 =?utf-8?B?WDZBekxMZEFlRTdDdHNTRHN4VDF6Zm1yWDFzNzQwQUQrUU9Tc29vS3J4elpI?=
 =?utf-8?B?eGpwM3NVZVcwNkRqajQza2JQU2FGMTV1YWJvQ2M4bWJaOUpiVWkzZTZVMDJU?=
 =?utf-8?B?NC9aSS9FUnh3c2h3aGx0akxDanNsaGk1ZHVLbW9aQWFsL1hJZGFjUVl1eGtr?=
 =?utf-8?B?TmR5dUR5eDJWQktudEFEVU5sdW5XVGwvRktLTFl6RGdZVFhCMi8xVmZJakN2?=
 =?utf-8?B?cy9vY2ZYTytyVm5GR3NFSlFWWFBTSGVrelArRHgzYnFpNUFUMEZyb0VqN1FB?=
 =?utf-8?B?YjdyTld1UmdwTGNTTTQyNjBWbjhRUExvZFNIdjZ3U0NLeWlzUFZIeWt3MUlV?=
 =?utf-8?B?LzZzMkx6OW5peDh0TFNkZW9mRjg1bUdHMUlOeGYrRmF2OFozQ0E1RTlMbzdo?=
 =?utf-8?B?Y0xjc3UxclNmQm8zMEk0czFwSUlPSUJsOFcwU2hQWjNuaTVaRFZFZWJ5RGx3?=
 =?utf-8?Q?lQBwM/Cq0wPm+n2jRj5VbI0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d391a2f-1333-447d-c7e3-08d9a3f71305
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 03:06:22.4187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuE6rcrxBhNLy6Uxe3JXVXniCcSVKG0dMMR5Y47HM2m6y4DgUkdRSxJDzUeyVNP87Wd54kr8HdqTxABm9In2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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

On 2021-11-09 2:12 p.m., Ramesh Errabolu wrote:
> MMIO/DOORBELL BOs encode control data and should be pinned in GTT
> domain before enabling PCIe connected peer devices in accessing it
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 70 +++++++++++++++++++
>   1 file changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 08675f89bfb2..5e063fac0250 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1297,6 +1297,56 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void **process_info,
>   	return ret;
>   }
>   
> +/**
> + * amdgpu_amdkfd_gpuvm_pin_bo() - Pins a BO using following criteria
> + * @bo: Handle of buffer object being pinned
> + * @domain: Domain into which BO should be pinned
> + *
> + *   - USERPTR BOs are UNPINNABLE and will return error
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count incremented. It is valid to PIN a BO multiple times
> + *
> + * Return: ZERO if successful in pinning, Non-Zero in case of error.
> + * Will return -EINVAL if input BO parameter is a USERPTR type.
> + */
> +static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return ret;
> +
> +	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
> +	if (ret)
> +		pr_err("Error in Pinning BO to domain: %d\n", domain);
> +
> +	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
> +	amdgpu_bo_unreserve(bo);
> +
> +	return ret;
> +}
> +
> +/**
> + * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following criteria
> + * @bo: Handle of buffer object being unpinned
> + *
> + *   - Is a illegal request for USERPTR BOs and is ignored
> + *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have their
> + *     PIN count decremented. Calls to UNPIN must balance calls to PIN
> + */
> +void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
> +{
> +	int ret = 0;
> +
> +	ret = amdgpu_bo_reserve(bo, false);
> +	if (unlikely(ret))
> +		return;
> +
> +	amdgpu_bo_unpin(bo);
> +	amdgpu_bo_unreserve(bo);
> +}
> +
>   int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
>   					   struct file *filp, u32 pasid,
>   					   void **process_info,
> @@ -1523,10 +1573,22 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>   	if (offset)
>   		*offset = amdgpu_bo_mmap_offset(bo);
>   
> +	if (flags & (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +			KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		ret = amdgpu_amdkfd_gpuvm_pin_bo(bo, AMDGPU_GEM_DOMAIN_GTT);
> +		if (ret) {
> +			pr_err("Pinning MMIO/DOORBELL BO during ALLOC FAILED\n");
> +			goto err_pin_bo;
> +		}
> +		bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
> +		bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
> +	}
> +
>   	return 0;
>   
>   allocate_init_user_pages_failed:
>   	remove_kgd_mem_from_kfd_bo_list(*mem, avm->process_info);
> +err_pin_bo:
>   	drm_vma_node_revoke(&gobj->vma_node, drm_priv);
>   err_node_allow:
>   	drm_gem_object_put(gobj);
> @@ -1559,6 +1621,14 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>   	bool is_imported = false;
>   
>   	mutex_lock(&mem->lock);
> +
> +	/* Unpin MMIO/DOORBELL BO's that were pinnned during allocation */
> +	if (mem->alloc_flags &
> +	    (KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL |
> +	     KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP)) {
> +		amdgpu_amdkfd_gpuvm_unpin_bo(mem->bo);
> +	}
> +
>   	mapped_to_gpu_memory = mem->mapped_to_gpu_memory;
>   	is_imported = mem->is_imported;
>   	mutex_unlock(&mem->lock);
