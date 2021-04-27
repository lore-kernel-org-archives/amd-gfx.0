Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3ADC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 18:21:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A549561001
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 18:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A549561001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4938B6E595;
	Tue, 27 Apr 2021 18:21:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C7C96E595
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 18:21:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy/Xk7TYKNhj0KtPR/RDHGCV1dfs9k0UFs7WfcyZ9Lgid5r2uLOMnvadzH0L1RZVgjrMOJOnIhKkZKwABy1eB+pGprPuDPkbOrh0u0MQhTwZR0YyMsjbBqK4JPncMW6ye8+Mu/nYiuKICNFwl/WFtqSXqUWRSMnbR57um2nwujMqED2MReVhgbCs5T003nr0A/yGaR5LYgrO0ui13rGmRYMbO/Dg8HRxKExGW/wotw0ZvePQwdnsd4Lhq/QSB178n8K+tIzvO3ZZhG4rkEW7LWGeTGDgjvfyt4KR9F+VNRCJxHH5m/CvgeCdSNAPal7no3a+OVU8e7UQdZdyXsEpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RrYv2XHEbQIYwJ6JcbVgPFPHjVTRmHXh3OX3nbWNTI=;
 b=GHVCyzXBxcel2IgtlABZuyaKpolO3iVMl0W++CBUw9wbvcw7WydCA6NS5Elzg/qdVDP/UZsPMZZ1QIcDiJV11DhT7fFKjQa52LS4Q0PKvBkf5ijxqKd0mjIShuowU7aphjQIv+prgsY9EqzokSQK27jrxQqI0TePngtWUKEL91WpY8H/TfIamIRPNqlPRApRMZeHKpAOJ1bgt2W5Wnf8U+2Df1yp50wCc1kPG9seJM8s4G+Dtj4tc0GqS71IPYf+8CbrPjd+sDtVBax3/fuJlacOOU4tffHrDTnu93YXfPbcShGmtOUysoGo7V+r7e5w2ZvqByhon9TZYLMQ65O+Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RrYv2XHEbQIYwJ6JcbVgPFPHjVTRmHXh3OX3nbWNTI=;
 b=cEOZKmTXp4TRvELUc40sz+GULdQ1ZdtepGfFDAQkXDNvIpUU6j0G0OE9vTZTe8RF4b5nRYoZ6wHObNOTd0QlW5c2BYdhxGADc7eCErVEv1qQiRNmJrzCbcb6ECAWSB3G+2XUkT3OZKd1pBxSDkR+4U11YVjNTzgxqdEoKZapYXs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2419.namprd12.prod.outlook.com (2603:10b6:207:44::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 27 Apr
 2021 18:21:48 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Tue, 27 Apr 2021
 18:21:48 +0000
Subject: Re: [PATCH v5 4/5] drm/amdgpu: address remove from fault filter
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210423153550.25188-1-Philip.Yang@amd.com>
 <20210427145119.670-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <3c65430a-1bdb-27cb-6573-dfc9e4035e8c@amd.com>
Date: Tue, 27 Apr 2021 14:21:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210427145119.670-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24 via Frontend
 Transport; Tue, 27 Apr 2021 18:21:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9dd20c5-e818-4c99-52ad-08d909a9525e
X-MS-TrafficTypeDiagnostic: BL0PR12MB2419:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2419A9A68BDD73B252BFC21192419@BL0PR12MB2419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3POOyFHujq0Hbf4xbG9nXwfIPvmk+udF02vbLM1MxQ2RxayDEC3o+4kumZFa/fNML/V5NOo07Jghcy2eDZiabVNYTTCiMqBEGJeyYS4sVXLPTZLqUR/g0smkpdw07CYO+hw7YDoPHegpuVYDMqzKmPL11DldgJbeISmPMTFxTS13QNu5kXB0fweJ5Aca2bTyDIL/F8DcSOcQypuXadWRwLOECAmFpStpR/A65EHmT+7ZaauYmYkyY5/eXLLwfaDwZ/g5IeFOxxLLb+3aeVjw05ZJs3rpz+vx7DlK8BAWKRwcbWh/AE2+QK8ghUP816wkmAKG7iEDbjrEOgsoohsPH9xjcunHMj7IPHXFsYA0kYf1qzYLJU/xoNd3y55VSrPE/cctfOf5EVxQoZPPOFLm1NVKpXFZBRa7lHwmF1LjRjlgXVxePzBcQUKsQ1BCZQxNn7QNn1Yau/tW1Z/QFSNB4BDYEoMVRSre1So5DO7/5GLsITJvmkEqwtWn+5av7ozJ9oglsUcOTnDvcijS62EU3mzMHfwHhVREco+nQIUpaS3qgLchpeUiG38jpm/NVhzpFAWT5U12Emom1BewbCeSyENchpwA6PmZ0ZpNO3rPCuzo3vNP0NY7m+fiWtZBJE5q0QH4hrDcOMIZYsDw6nHcZ5H90EgSjehmIOGoQ2XZ5Kxor0xIX6RivMYqB0Cs6NBDSlxNj0oN2YfSgCehxvgxiPvEsWbT2RiuKrqTFuKA5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(36916002)(8936002)(53546011)(316002)(26005)(52116002)(16526019)(38350700002)(5660300002)(31696002)(16576012)(38100700002)(186003)(478600001)(6486002)(8676002)(31686004)(66476007)(66556008)(66946007)(44832011)(2616005)(956004)(36756003)(86362001)(2906002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y3NEZTlvdTVzUUJaR3ZjMElHdDVPS0xTcnNyTFAwVTExYmNlM0RyYVRUcXV2?=
 =?utf-8?B?ZHFHQkltK1ExM2UyR2N2NVNlRDF6Ky8zTmxxR2R6RjNKTzNSa2YxNmI4aVZa?=
 =?utf-8?B?UStTUWM5WHBFbTYwT3RHM1dLaG8yS0lydGUyY3BaZ243OFRyUHFMMHlIck5k?=
 =?utf-8?B?ZnlLTXd6WmZCLy96VGVLY3dQYWJRdUVMeHNoRC9jUTRxM2hueDErb0U2UElW?=
 =?utf-8?B?ZzNINWlFWFdQcmJqSC9iZmIvMWtzMkhvWVczamx3eEt1MCtib2U5RFhBQnZs?=
 =?utf-8?B?Q2ZOeE0vc3k1WDlWWFhwTGhOZVZiSVhCYk8ySS9nVCtUNDhXM0Mybm1hNzVQ?=
 =?utf-8?B?bGNLcHloN0QzTWJpQ2d0aW40YWxjLys3ZTdaZEVaOTU4UlBWY1duc01LdVk3?=
 =?utf-8?B?QnJjcnJoNUxib0VyYmVxUCs5MmxBTklYR2dzNTNISFE5WW9WRGdGdzNaeFRM?=
 =?utf-8?B?aGlWWlorMjliTngxcUlSOVNGeTlkWUNKcm52Q2dVdERxL2d0ZkoyUW5IV3lm?=
 =?utf-8?B?Zm5yZmlqaGx5bmo3eFpxV041K1ZKYXJQQ2tEbXhKdUFrYWc4T3dxWU5EUDJh?=
 =?utf-8?B?MVdJdG9TYnNYcHdrbml1VEcyMWd0NmlFNEFqNEkyTzNadWUzaUR5UDJPQ2pV?=
 =?utf-8?B?VEJkMEhkd2lucWlROTFzUVhPNVVlSit2RkFpODYwaFlzT1NDYjg3d2hoSUg2?=
 =?utf-8?B?R1k4WDJKT2tMNzlIMDhZcWZXTlpXYzJXTW1sbGN1R0VOUEk4YWZxaUszUFdn?=
 =?utf-8?B?Y0JKQ1dieFRzNDhtb2s4dGthMlRndjFocVpLQm1aNjRlQ3lER0NuamQ3NDhr?=
 =?utf-8?B?UTRlckFhMzJpdlhNZmNRMVMwSEgvVExxVFFxM0FMQy82UnU2dFZXaHFnbkNK?=
 =?utf-8?B?bWh2T1NtcVQ4SUlnRS93NUxocmwybHU1RktSaW14VjJZbTBWQXBjOHZEYXBy?=
 =?utf-8?B?aTBnM1hGeUMrRjRQM2ZUOG02NWc2OU5hOWh1S2kwZWZhK3cyMytWOGRqY2Y1?=
 =?utf-8?B?ZU4rRmpJK3hHS0FsSnFVc005R3FDV2MvUDBoL2MxQ0Y3bHNzbnhCY0ZHdkU4?=
 =?utf-8?B?anhObGllbW9kdmo0RHo0c0ZMOFpaK1NpYlJRVldPRFYybjlQWkg2QjVZd0dN?=
 =?utf-8?B?V29GV1JHR3pOS1FmTzRMWFhsd1ppT2ovRjRIMGZ1emYrZEJrbUpsY1ZRYUZV?=
 =?utf-8?B?bVdpWmcyZGlMZjB3Mnp1TEdWQkg2d00xdU1vaXVvRi9DRjZ1K3M0cUdSUisv?=
 =?utf-8?B?c2pLYTd4RzUyb1Z4MlU4aHl4OE1UT3cxbTZuMUEwWUpuSWtOVm1PaTlvRFN6?=
 =?utf-8?B?R1NUZGNKZnBsS2FxZ3RvN00vbW9aczlvYnMyR0xXR05UME53MDFmUmhpcjVo?=
 =?utf-8?B?OTE5RDNUWk1zYzRIMG5KSFU2YmF3eUJRclF6NjhpMmJxZE9hbVdMZ0ZmN1FU?=
 =?utf-8?B?dFBhR1FLNWhteUJwRTZTdE0rNHUxUTN4Sk9pQU03YjlFNkZBQTRhTnJnZWVa?=
 =?utf-8?B?eXZVSE9BY3AvVm9rRVJpQldFMlp3ODF3S2FTTVBmN1BySjNxNHZ1YkV2NUpp?=
 =?utf-8?B?cjZMY3Z4R2sxbHJGZ1oyc0VYTjdPQmxRajJMY0pEUEZDRXRWSXdFSGNQTndn?=
 =?utf-8?B?dWE2NFp1Q2d4QXRMRHJBZXVkRFNTUVIwSkh1NllrWjVsOCtGZUFxaXBIWEFi?=
 =?utf-8?B?MVk0cVZWVXpyK0hHV3F5MCtKR3U0YlNyenl3WkxEMFBqZ3F6N284WFVRcHlx?=
 =?utf-8?Q?RdJHm1QL53lgLb0LRGGiG2/XWGioMwCLFXrkzxr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9dd20c5-e818-4c99-52ad-08d909a9525e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 18:21:48.6787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrfWqT4ZbY/Y/N9YHncrbk0EbhsQ/9/FVZJ2LpdnywEJ3OR4AIWO/yxGw4XdkxrTwvkegaxxei2vBtF0UpceQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2419
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

On 2021-04-27 10:51 a.m., Philip Yang wrote:
> Add interface to remove address from fault filter ring by resetting
> fault ring entry key, then future vm fault on the address will be
> processed to recover.
>
> Define fault key as atomic64_t type to use atomic read/set/cmpxchg key
> to protect fault ring access by interrupt handler and interrupt deferred
> work for vg20. Change fault->timestamp to 48-bit to share same uint64_t
> with 8-bit fault->next, it is enough for 48bit IH timestamp.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 48 ++++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++--
>   2 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index c39ed9eb0987..a2e81e913abb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -332,6 +332,17 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
>   			mc->agp_size >> 20, mc->agp_start, mc->agp_end);
>   }
>   
> +/**
> + * amdgpu_gmc_fault_key - get hask key from vm fault address and pasid
> + *
> + * @addr: 48bit physical address
> + * @pasid: 4 bit

This comment is misleading. The PASID is not 4-bit. It's 16-bit. But 
shifting the address by 4 bit is sufficient because the address is 
page-aligned, which means the low 12 bits are 0. So this would be more 
accurate:

@addr: 48 bit physical address, page aligned (36 significant bits)
@pasid: 16 bit process address space identifier

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> + */
> +static inline uint64_t amdgpu_gmc_fault_key(uint64_t addr, uint16_t pasid)
> +{
> +	return addr << 4 | pasid;
> +}
> +
>   /**
>    * amdgpu_gmc_filter_faults - filter VM faults
>    *
> @@ -348,8 +359,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   			      uint16_t pasid, uint64_t timestamp)
>   {
>   	struct amdgpu_gmc *gmc = &adev->gmc;
> -
> -	uint64_t stamp, key = addr << 4 | pasid;
> +	uint64_t stamp, key = amdgpu_gmc_fault_key(addr, pasid);
>   	struct amdgpu_gmc_fault *fault;
>   	uint32_t hash;
>   
> @@ -365,7 +375,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   	while (fault->timestamp >= stamp) {
>   		uint64_t tmp;
>   
> -		if (fault->key == key)
> +		if (atomic64_read(&fault->key) == key)
>   			return true;
>   
>   		tmp = fault->timestamp;
> @@ -378,7 +388,7 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   
>   	/* Add the fault to the ring */
>   	fault = &gmc->fault_ring[gmc->last_fault];
> -	fault->key = key;
> +	atomic64_set(&fault->key, key);
>   	fault->timestamp = timestamp;
>   
>   	/* And update the hash */
> @@ -387,6 +397,36 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   	return false;
>   }
>   
> +/**
> + * amdgpu_gmc_filter_faults_remove - remove address from VM faults filter
> + *
> + * @adev: amdgpu device structure
> + * @addr: address of the VM fault
> + * @pasid: PASID of the process causing the fault
> + *
> + * Remove the address from fault filter, then future vm fault on this address
> + * will pass to retry fault handler to recover.
> + */
> +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
> +				     uint16_t pasid)
> +{
> +	struct amdgpu_gmc *gmc = &adev->gmc;
> +	uint64_t key = amdgpu_gmc_fault_key(addr, pasid);
> +	struct amdgpu_gmc_fault *fault;
> +	uint32_t hash;
> +	uint64_t tmp;
> +
> +	hash = hash_64(key, AMDGPU_GMC_FAULT_HASH_ORDER);
> +	fault = &gmc->fault_ring[gmc->fault_hash[hash].idx];
> +	do {
> +		if (atomic64_cmpxchg(&fault->key, key, 0) == key)
> +			break;
> +
> +		tmp = fault->timestamp;
> +		fault = &gmc->fault_ring[fault->next];
> +	} while (fault->timestamp < tmp);
> +}
> +
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 9d11c02a3938..6aa1d52d3aee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -66,9 +66,9 @@ struct firmware;
>    * GMC page fault information
>    */
>   struct amdgpu_gmc_fault {
> -	uint64_t	timestamp;
> +	uint64_t	timestamp:48;
>   	uint64_t	next:AMDGPU_GMC_FAULT_RING_ORDER;
> -	uint64_t	key:52;
> +	atomic64_t	key;
>   };
>   
>   /*
> @@ -318,6 +318,8 @@ void amdgpu_gmc_agp_location(struct amdgpu_device *adev,
>   			     struct amdgpu_gmc *mc);
>   bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   			      uint16_t pasid, uint64_t timestamp);
> +void amdgpu_gmc_filter_faults_remove(struct amdgpu_device *adev, uint64_t addr,
> +				     uint16_t pasid);
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>   int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
