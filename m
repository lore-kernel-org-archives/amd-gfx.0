Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6119AC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 04:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F8210E3E9;
	Tue, 31 Oct 2023 04:01:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB88410E3E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 04:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DID32LPBXOJULPxg2TzHcYlz3Ui68LLAg6t61o7vqOyCvJfyJkHc2Tbs+XwDN4aRdiHi7uE5A9CyBWvWU+KcWMKFe6/MELBLgLFmS2/cld5XbMmrwfmGVubREQNSGnJLLfuA23hcXH5/86OwVBehaNO+YRSFgQjuRHescWK6FRHJ5CWWxYOTZbxXnsVIBM5pIOwcDW6IoznkRLKovegcIQ5dfrM9vxUzD3UeRSY6blVBafcup02spvGlEZ4jyZ9kOsrU+KCjD+usqUF0Pv+98/gt4JvguSZOFxU+FVZEs9JL870eJDeES0YwSqdJuYAY1ccuG4+AMaWohROqSV4u+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZXMF5/0IhnrfqX7xponN8DFwVEN4in1ZlVGKgRJcOM=;
 b=DePejuAaA++9W7X9kTUE5XZN/9LHOhL525THflvuiHK/fbZXgWQe368uEIOGGIMDRylCiBs+YAF4ClFG+Ys6hpo/KNdcgpwaFUrzCkvMtbzdYMS29UnjSTGxCnVIO824cmIGMroUCLYjgSGiSNxJH4rev7d9nV/B9RZRZ8kYGSQSuW3JdvM/ii/bATMFpQhqE14ONEyx7GeK14MxzveO0u2cgF/LgYE0YbHDmDkX7bmqluFNIx6wZ5wVdGYbwO2MrvgEYcnz2M7MCg1PcTdaFNelBIuJJcCsBjRc6pzDiyS5MkBjHxyWhCGj22vWO9zCP1FSJ5m+5hyqony6KIIdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZXMF5/0IhnrfqX7xponN8DFwVEN4in1ZlVGKgRJcOM=;
 b=muyLHTFgXPKlj4fA164eqzRN8pAWyrP/oaTj4r1ZpZUlVLljh/Y1G2NVGGs35f0k9oc6CmxD/yqxhvop1A6+Kb4KNu8YRhtg2IQWSdHnTPnkRobls/ZSVrOFGEVKMjVwX4ZgqUSlNkwCPskL5wArTT13enklIjDNYchmh3Xu/7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BL0PR12MB4964.namprd12.prod.outlook.com (2603:10b6:208:1c7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 04:01:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::8b0b:3c38:b988:ca27%3]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 04:01:44 +0000
Message-ID: <86c0e3d3-cb89-b45b-f75f-2396277a9ab8@amd.com>
Date: Tue, 31 Oct 2023 09:31:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Add xcc_inst param to
 amdgpu_virt_kiq_reg_write_reg_wait (v3)
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231025205242.40490-4-victorchengchi.lu@amd.com>
 <20231027201122.2344-1-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231027201122.2344-1-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|BL0PR12MB4964:EE_
X-MS-Office365-Filtering-Correlation-Id: f541c64b-c2aa-4bbc-80bf-08dbd9c61825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mmgCj1KEesETh0Jxl5xsxCtUW7WrGs5zWT5sp2NzdccT2zHtQmueUXz7lKbaiVltG0hhlOggBFgHSmhYUut0kfrqNU1mJSuCi5/DELrEuGBehPT/nrw3pXHuYR4xb2ljvxRdzQPgyb1L0yyNFV2yOt4c6VUGPDxZlM4xCMjPen3mkKD02YbxiB8EI2hCw3bHi1puGK+eo7ZKYHCqy3Bpfg9wiQFz2t6lNZNc1YslsXFH6EXUUtyOLKnExjtvpYOJr8rxWjJU9T+42QPrTGP7eeUKr7aY8YBvdiBOj96brvaUK/kBraG6ZNAQMuC7txMgMrqIBq0Du/TRURIWoz5jTLD2QkCFz5N4iMTFmp+EItKjDRnRElaRI4X+eAH5+jj3Ormi506PG8Bp69XaNoNfqwvzb1vSX9fxkILCfIJNr4+Oo/5EfRWBt4qg2Pu9OZj2H9/YQwmTtbHFLqUG0SM3MhA3MWGVMGzwIjDErmQKk9NO0k85iCXsmawumRwOsZ+6ET+rKS9wMPp73m/rVqa5xc4hGJ29JB2ZGixwEcUCLVCJFpQO96dpfzZ/dSewCRl+RH9IdljS4V8aLNKWwGbUGtISNz/HSfi72fEIUdFtCtOysdm8okDNPXn7eQ27vwXiHwjk3GcJSJ+o/EMxHPk4jQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(6512007)(26005)(2616005)(38100700002)(31696002)(86362001)(36756003)(2906002)(6486002)(83380400001)(6506007)(53546011)(478600001)(6666004)(8936002)(8676002)(4326008)(316002)(66476007)(5660300002)(66946007)(66556008)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUlvTjhJejJybDBwNnlvaUpVNVpIWVNOU0FMNkd4M0hHL3lzcm1yc0UrYytY?=
 =?utf-8?B?N3JScHl1T2JacHdrK2VtWVV6SVlCSDNXRVJxbnFJbGkrOVp5TFFrU3NQemhq?=
 =?utf-8?B?bTlWU05TdW1LQVBiVytNWTYwQmk5eEFRMnl5K1FIZ2I4cHVqWlNHaHg3Q0dD?=
 =?utf-8?B?ZnV1aE50R2EycWllc0k0R0pqK2EwdkRCNUFHNzdrU2VtYUgzQ2JJVGdXc3kr?=
 =?utf-8?B?MGRHdlFtNjlqMlJNZ2FrT0VOUUlTTjh0eEQ5M1ZNVllnVE54M2NQRVhzMGJK?=
 =?utf-8?B?RWF1TmdxTnRUOXFoM3kydDhDWDF5YjJzZXFBcUFKMm5GTGpMMkZRNXJTMDE5?=
 =?utf-8?B?Q1VSVGhSY05DT3VFSFVheUtldWNpMW5IdHAvNFc5UEthZlp6cERRMUVSZExq?=
 =?utf-8?B?OTMxZi92RlV1clBzNUhVMnJ6N3B6czVUL3NIclYxZWhxNHZ2OWJVRWVkRGlr?=
 =?utf-8?B?SFkxWHRtcmswWG5sRlV6THZ0V1lLVXI0Z0t3Qkk1MTl6R1d4QUtpai9vT0Vt?=
 =?utf-8?B?WFJndzJZWFBERVd6NU04TmY2UnNwanNKZytaa0l6V0V2a0ZBTHNyWU1vRkYx?=
 =?utf-8?B?blFqeXhSdlVxNW9Ud2g1WkFZQWZyVnkyUG9PdWtsMGp4dVRjRUJZR01TeEw3?=
 =?utf-8?B?R0g5ZG9yU0NhSWx0WkZyR0xaV1V3dFBUc2d5VE5QM3NWZVVWQkhWbGxRQTBV?=
 =?utf-8?B?NmNha09ucklhQnVqMU1OdEhERU9pcm9WTklpUzN1Y0NEeUJGTnZmY0cyYWFP?=
 =?utf-8?B?bWVrMTBRdk1RbFcwMUxkaFZMNGo1ajZrTlMrRitvYU9EY1V4UENMVTNlditK?=
 =?utf-8?B?L1EzMmNPd1NVQ3BMdmQxeUVuOWp1RS9FMFdmWDcwUWkwUWZNWmZVbithUitH?=
 =?utf-8?B?OG55eFVYbHo5cDc0VGpkUXUzYktScnA2a2YybWc1cngrOWpzU0tXMkFid3Nr?=
 =?utf-8?B?Nnd1ZzV5S2JWeXREdnFuTGVRWGJrbmdvUk14VEFHYUVvMStrM1ZhVnE3NDQ3?=
 =?utf-8?B?NmFjYjROVmlaRSt6SFlvRGJ1dVl3U2VhV3VBZFRHMjlnSEUxM1Q4cGZ2Um1C?=
 =?utf-8?B?T3FiRXNVSXhTdUVFK2phbmZMb2w3azVNNm1zd0c1aGZLQm9ER0RNWC9VaGdR?=
 =?utf-8?B?SC83SHRlNFRFRlFVeW1rV21HOStiSEFBakI0eEwyWGo0N3V5VXlNU2dUNmJk?=
 =?utf-8?B?V3drZzZra041dGxUTlJzT2dqclVWT2FCYmNHY2xZSkVTOWpLVjVaNmhOeHk5?=
 =?utf-8?B?QjlpMjVjSlZUdm9odUpUNTlEQytNeUlVWmx3QlJVc01MWC9lOHl5T1dxS3Ry?=
 =?utf-8?B?blVxS2w1aVVKZEpqL2NSQWJYaDhaQ0FKMUtTYUwxYllvQWdQeDJVOGl5c0FO?=
 =?utf-8?B?dUVVM1ZyYU96YUY5V1ZWWFg5YktjcXVHdFlpd2NHUVEwL1A1bkZLUWYxQ1ZP?=
 =?utf-8?B?bkMxb05mYXFKQWxzWFZYNEcybm91cnJDaHl2UlorVnhybTY4QUFiQ2xmRjlM?=
 =?utf-8?B?QTJzb3d1OUFEdkdDbWtBakJKYk5mcXk3YlVMU1hXZWwrci82QXNzZjRuY2Y4?=
 =?utf-8?B?b0ZjV0EzMW4zUlZxTEN0WWtNaTV4eHZhUzRLMWc5YVZyM05iSzR5SXcyb01O?=
 =?utf-8?B?cFpGeU9OMkxpVDNmSEJsdU1YN21qOTlXNmxEUUdhVTBRQnlkd2VZTkpFVVNR?=
 =?utf-8?B?Sml4bTFuc3lSUGpTc0w4dW00VnlFMUQ2Nml6RVJGcnl1TlJySHFMYjhtT2RD?=
 =?utf-8?B?d3orZlNnVnFiY0FHSUE0eUNXRTRaM3hkb0swaGFleHJBazlBV1gyczVpR2NK?=
 =?utf-8?B?UXBVM3hrVExEdDRuTkkxbklicmF4SDR5bEJ1Q2pxUjBXbGxLZVFCblZLZ3Ja?=
 =?utf-8?B?UmFqL1JIdXRTL1NWa21ZaUxZMjF2UWl4WmFIOXZXbmhOdUhvZWo2SVhaR0Uw?=
 =?utf-8?B?T1BpNWd5ME5UMVFSdWtyYm1MbFRSSWFVeHhJelZncEtja2dZSVd5L2dXT1Iw?=
 =?utf-8?B?a1Y1SytvRlpDWkRhMDFvU2tVK0VVOEdQZDJZNWVZS1NjU2VQcnRuZVp6M3FV?=
 =?utf-8?B?aWlxa25hcmRPZmw1TkVONGpiNy8xNmlzRS8zNjZGVXRpbjdtUjFMUit1OTF6?=
 =?utf-8?Q?qjFscv3CmKdmuIhgCjlCIwX5j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f541c64b-c2aa-4bbc-80bf-08dbd9c61825
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 04:01:43.8554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9btGcoAzLLZsZl8tSAObaQLYlRHX2JdJ7m+3I6BVCVRjJDGgqWlvCyV+1r/8dLhP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4964
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
Cc: davis.ming@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/28/2023 1:41 AM, Victor Lu wrote:
> amdgpu_virt_kiq_reg_write_reg_wait is hardcoded to use MEC engine 0.
> Add xcc_inst as a parameter to allow it to use different MEC engines.
> 
> v3: use first xcc for MMHUB in gmc_v9_0_flush_gpu_tlb
> 
> v2: rebase
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  5 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 26 ++++++++++++++----------
>   5 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 7a084fbfd33c..82762c61d3ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -73,9 +73,10 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
>   
>   void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>   					uint32_t reg0, uint32_t reg1,
> -					uint32_t ref, uint32_t mask)
> +					uint32_t ref, uint32_t mask,
> +					uint32_t xcc_inst)
>   {
> -	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_inst];
>   	struct amdgpu_ring *ring = &kiq->ring;
>   	signed long r, cnt = 0;
>   	unsigned long flags;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 03c0e38b8aea..5c64258eb728 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -334,7 +334,8 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
>   void amdgpu_virt_init_setting(struct amdgpu_device *adev);
>   void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
>   					uint32_t reg0, uint32_t rreg1,
> -					uint32_t ref, uint32_t mask);
> +					uint32_t ref, uint32_t mask,
> +					uint32_t xcc_id);
>   int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
>   int amdgpu_virt_reset_gpu(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index d8a4fddab9c1..173237e99882 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -268,7 +268,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> -				1 << vmid);
> +				1 << vmid, 0);
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 19eaada35ede..2e4abb356e38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -228,7 +228,7 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> -				1 << vmid);
> +				1 << vmid, 0);
>   		return;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 0ab9c554da78..32cc3645f02b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -817,7 +817,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   					uint32_t vmhub, uint32_t flush_type)
>   {
>   	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
> -	u32 j, inv_req, tmp, sem, req, ack;
> +	u32 j, inv_req, tmp, sem, req, ack, inst;
>   	const unsigned int eng = 17;
>   	struct amdgpu_vmhub *hub;
>   
> @@ -832,13 +832,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	/* This is necessary for a HW workaround under SRIOV as well
>   	 * as GFXOFF under bare metal
>   	 */
> -	if (adev->gfx.kiq[0].ring.sched.ready &&
> +	if (vmhub >= AMDGPU_MMHUB0(0))
> +		inst = 0;

Same GET_INST(GC, 0) comment here. Looks like this hunk can be combined 
with patch 1.

Thanks,
Lijo
> +	else
> +		inst = vmhub;
> +	if (adev->gfx.kiq[inst].ring.sched.ready &&
>   	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>   		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
>   		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>   
>   		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
> -						   1 << vmid);
> +						   1 << vmid, inst);
>   		return;
>   	}
>   
> @@ -856,9 +860,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		for (j = 0; j < adev->usec_timeout; j++) {
>   			/* a read return value of 1 means semaphore acquire */
>   			if (vmhub >= AMDGPU_MMHUB0(0))
> -				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem, inst);
>   			else
> -				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, vmhub);
> +				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem, inst);
>   			if (tmp & 0x1)
>   				break;
>   			udelay(1);
> @@ -869,9 +873,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   	}
>   
>   	if (vmhub >= AMDGPU_MMHUB0(0))
> -		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, 0);
> +		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req, inst);
>   	else
> -		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, vmhub);
> +		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req, inst);
>   
>   	/*
>   	 * Issue a dummy read to wait for the ACK register to
> @@ -884,9 +888,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   
>   	for (j = 0; j < adev->usec_timeout; j++) {
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, 0);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack, inst);
>   		else
> -			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, vmhub);
> +			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack, inst);
>   		if (tmp & (1 << vmid))
>   			break;
>   		udelay(1);
> @@ -899,9 +903,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>   		 * write with 0 means semaphore release
>   		 */
>   		if (vmhub >= AMDGPU_MMHUB0(0))
> -			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, 0);
> +			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0, inst);
>   		else
> -			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, vmhub);
> +			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0, inst);
>   	}
>   
>   	spin_unlock(&adev->gmc.invalidate_lock);
