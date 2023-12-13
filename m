Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09EF6C4167D
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 15:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 977B610E7BE;
	Wed, 13 Dec 2023 15:24:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7077B10E7BE
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 15:24:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFvTsLjatY7ZjHiag4jVGOW5CPpZ5bkJs+EuB+K+Ij8+MrhEGdD9cQI6Fbng6KTUzbsSwmNupEp4Uogyk6jiXW5YcZpBtLFjopE3d8HukihhNPst4IsFmYZ2AGLxyvvwUVpfn3xZXlPY/tB3IrFB+9PKMYHFWzv+4htt7arYgc6HYm6xAFDPgJyV1EZUzmTuE9oR+tV++cjmEiBBTeQ6xZesjtXp/x4zoOgq1T9QkPPqMOVLODKP2l5S8Tl8zCnPwC3ddguC/J8z5pLqkb7kchO5sXil3pdaYxGpkbYMO7CnUD3HZ6C50MNkJk61x2Lj00uOBAySVJ2hYnxJMO2Tlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQj9QU6gx6jhQla2oXC9E4E1n+Tvz+VvtfBe4BE2aSA=;
 b=nDt4A3eMlzQaQe5WazzulkBdotgIk7l+VUNLZr6ZVIrV0K/z3dGzNNJOLV9/sj0DmwEBs7wgyzgN1iLNPcgyT8HFzzSu4IAcls1hO1DUg2+J9Dm8VD4ILSk6ykxR8kYOYXVMA4eMG/FOFG3n74oc3Ngw7oVrMUtQurDyA7Jjrl8DHy06jk1JjALL0PlLonzB+bVxCSQjCgar2yRgGuGV/3eWm1tLaSp/JgRr1RakY/wyQ/PtIQGmO9YWDvSPDhfyu2PA5Xhb8LM5WrhL6f1BBgNtz7Dg7VV7j45SyYYoX/ERsMdEG/hkEzKJ/aV16sAtK32YddQNUk9eqDhqCeuwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQj9QU6gx6jhQla2oXC9E4E1n+Tvz+VvtfBe4BE2aSA=;
 b=QhdiR0uElKM/z9OENHX7dpW7oTLD6PjyaxK4EHjjkI8vskr2kDvTxNcC6doZ10qELw3IzMuLACMcaXEkEZlbYoSzJFrTnwDfAIWkgSXTqOhvBzrB8JMA03zFgEpyXxGoHTlNiLaHwuMOeiJwYj4IaJcIfb12z9RCRjXZTqfqCo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:24:45 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::ae50:7a3a:dad3:1d04%7]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 15:24:45 +0000
Message-ID: <bc0fee8f-9e10-406a-a001-d4bd37c42c43@amd.com>
Date: Wed, 13 Dec 2023 10:24:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: increase hmm range get pages timeout
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231208230105.733781-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20231208230105.733781-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: de67c6d4-4e1c-495b-952b-08dbfbefa2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nWEFd3l6rCruD2dovtQolk8VVegxz0mjHX40CRm0jmVcWoq185o0tLEqBMQ4BN3/r1xStcPwX7cbQ6tejpHeNS9/eYDP8rLTkWr61lpyHtA+qqH5rzbpIFBXvoZITLB2usTfcPFX531yHY7Z7UpPH8rJGRduzPYxEb01i2eO7a5BgndPaZMwNxvqMH2SYI+xqHK262dOj+/uB/ck8Wh1vQDMFwaXdSfcMrdX9x4Jb5XgZHIju9MHTVCqnhMFjRw6jSiM5GOdZM/47x8b3OMORDpCQXSi0w+kZPCaPW54AvQpTqAWReWvLp3HIGOo76yulPH7CFr+hlCuMovny19TId2UbnYSU3nL3axDiW1Ar0hBzRMz3Qt7P+bbaD10KOCpXcHjRL8AyUvFU8O0x45kwRrKSv8BnPZKYg7QFG9TEAN8jUScLThNpR+W6/twe95HkumVJK+wUop8p5Lx2BBLYKQyi0rigQTpD/YtJREtcReGcssX32LEcq3UMttGAnz8EpHfpXVEzYlTJI87MAnVhQZPVr7C/oUzs68ODP8RQw5jTWvfWN2NnspSb+nc7ebimjfjtw7kHdzo8Hg8s6rzeECNhah4nioersgElvkE3BJ3HpgYe/keGRYUnBNrWjhBfVqr/MEIKvVnHgQEKlK5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(26005)(6666004)(36916002)(478600001)(6486002)(6512007)(2616005)(6506007)(53546011)(4326008)(41300700001)(8936002)(8676002)(38100700002)(5660300002)(31686004)(36756003)(2906002)(66476007)(66556008)(31696002)(66946007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndCMktFaHRHOFAvcGJpYjF0NGlkN0h1V1hGSkx6UjJhbWsvZGVuNEdVdFM0?=
 =?utf-8?B?M0J4NXBlM0pSTlNvNXkvcmNiVkVIbzN4bXdUZ1RGWTl1dk1peVRQdlhkQkNG?=
 =?utf-8?B?Ly8vUjNkOFRlblg4bEJGS3VuZDA5bnRjazd3R09BQ0RDd05RYXdjM0NEbHh6?=
 =?utf-8?B?eTNsSDMzVWEyakorVXhLcXpja3NHRjVFNUxJU2JvWTJyeXEvRGEvQXdrV1BB?=
 =?utf-8?B?c3d2S05YbmMzMUlxUzBGRklwUzNmZ2s3VVZJNVY0dHVKSENCK1pYdnNFa1U2?=
 =?utf-8?B?NzZ4WGxwVHVFd2lrU243OGVNc2xTTUN4SnhUQXFnZndFaGpJalczUzJLbkFy?=
 =?utf-8?B?NUFHRVBoNkRXQWFHajg5djNyUW9KKzN3dW45alRPdnd1YXhnVmFaUFFmcHM2?=
 =?utf-8?B?UlNpcGI2cVNRUTVyWnltaWVGdTRjM2h3VlhVRm1KN2VKamdBUllyblZFVkVI?=
 =?utf-8?B?R2J5dDU5b0NLQ1FMb0did29kY091OTIxeFNTeVVnSk9BQ3hWOEladDc5dWIz?=
 =?utf-8?B?SkJ5RjQrZVFSZ3kwRjlQbndmZzBpS1hYa3ovRmdVS0x0VWZZNldiTTM4bCtD?=
 =?utf-8?B?bGxYd1ZqdTV1d3Z0Y0FURjdUc1dXSjd6YlpmcTc1UU9BdmQwQkFkMTZLalcy?=
 =?utf-8?B?eDhRb0hOTFFnZjNpSjJ1VmZLNnc5Mzl1UjErOU1NQVRScWtROHFrMFVRSG1w?=
 =?utf-8?B?amlWaWhUYUt5VzVUUTFDL3hxL3laQzlwUHhQWUVVNEwyRGxiZ2FCbGRRUGFJ?=
 =?utf-8?B?Qm1VUFIvbnpRWnczK2tPZjNBVTVYV1JHMGpBYVhUUjFKWHl4NllWdTdOWHhx?=
 =?utf-8?B?NW4zbjIwdGVjRnU5WHFTN0F4U2JpSE1MWXJjNVVhaVgzUWhINFZzbXhXZDJs?=
 =?utf-8?B?ZXlDTFNNSlRIVGwzY012VzRlZVdHSWdJS1czeHpzUGxaSU45SXUrUDlyV1Zi?=
 =?utf-8?B?ZnJzcmc3UjR1aXBteURpc0g0M1ArdDZXRG92aVlVc1h1Sk9hdDR1SGVlWURC?=
 =?utf-8?B?RnVkcEl4TnZ3ajBuNGVqVEZWRnZCemV0b1RkWjJNUXI1RERTbE9tMUxyTnZ3?=
 =?utf-8?B?WE9sSm5vMjJZVytQL0ovMnphVVJudWFOa05laUtlSHhBcGp3dDBpalI2TEdm?=
 =?utf-8?B?Rk5EQ2hyV3I5KzJFdFFUVHdLdzcxYkZJUkVpanFTMUJFZ2RQSHJIZEQrc2k3?=
 =?utf-8?B?d2IyZ1hTZ0tWeXMyalJlVFFlK3NoR2l3Q0JKc3Q4WHVyaUttbm1zYW1uYllH?=
 =?utf-8?B?dWJNZDNCK0F3UlpITmRqUnZUcTNCdEY3UG9RWERpdHl0ZnNlZU5BRkIyWlVK?=
 =?utf-8?B?ZVNGaWZITUxqdlFrRWVIanBDd2RUNnpHZFNYZFVTZHVuS1VZaVdCc05oZWEy?=
 =?utf-8?B?Ym82ZU8wMXpDMkh6eU42WWt3cUE4eDdmdHB2UVBOamlwUW1ZREJzODgzRHUw?=
 =?utf-8?B?WnVOdlRIY2tPN3VLc0RFZnVFdDJBOGF5cUVnMW94NCtCTkZQZjBZRXVtZEhm?=
 =?utf-8?B?bldsbThxazRtdFVNNkhpMHh4WkVTbnAxQ2JsQ2p4L2pIV1h4aFhEVFRBSytk?=
 =?utf-8?B?Zk9GSFU0aEpCMHEza2hwd2lsZm96RkxjblM5Ri9mc2VHbnZQbUFQdkpVSXBj?=
 =?utf-8?B?T1NjKzV3V0JKTHI4K0xOblYycjM4cStZcFMzMWhOUE9Qb0tpZlJianBsMVls?=
 =?utf-8?B?bTRtVHBYSHBBYzFsN2ZEU2hqZ3B5VTVLV2NvaURCY1AvVjZzWkQ2TCt4Snh4?=
 =?utf-8?B?blFlQTNVUUw1SFp1dUtocUF4endjVEtEMHc3aHpEZUNOb2RXazk1L2hqMnEr?=
 =?utf-8?B?Nmt6b1YrVzBSTTJYMWlMRmpUZWxmSkZVdjgwZE80b3JaRnhLN3M1S0x5YUJz?=
 =?utf-8?B?SFRtek5RRWNlZ282SU1Wcm5ZK0NaRlNPdStrdnUxN3lsN3F5UmluUDM1NGxa?=
 =?utf-8?B?TlFaOGp6TUN5T1FhaTR3eVlwSWlJeTQ5R2JjcmUxbG9rV1VFTmliNk5Hd1NT?=
 =?utf-8?B?NVBqa21QZWxMbmc1YjNYTTFueGR3Vkphd3B2citKdzZ2OWNBeXorYWNoTC9j?=
 =?utf-8?B?YmE1YVZmSThRbDN5QlZUYktna2pKb3pXelE3Qkc0ZUZwNU9EYmswWVVZVVFn?=
 =?utf-8?Q?GJrKdK/XMQDGPfL9oVokwbeoF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de67c6d4-4e1c-495b-952b-08dbfbefa2cd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:24:45.2437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuYiVw/OEDv+tSP3q1VwXasUyTuvmFWFgZ9BQWZbkLT31+fcb3QS/QAbjTBqwjxU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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
Cc: Philip.Yang@amd.com, Felix.kuehling@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping ...

On 2023-12-08 18:01, James Zhu wrote:
> When application tries to allocate all system memory and cause memory
> to swap out. Needs more time for hmm_range_fault to validate the
> remaining page for allocation. To be safe, increase timeout value to
> 1 second for 64MB range.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 081267161d40..b24eb5821fd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>   			hmm_range->start, hmm_range->end);
>   
> -		/* Assuming 128MB takes maximum 1 second to fault page address */
> -		timeout = max((hmm_range->end - hmm_range->start) >> 27, 1UL);
> +		/* Assuming 64MB takes maximum 1 second to fault page address */
> +		timeout = max((hmm_range->end - hmm_range->start) >> 26, 1UL);
>   		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
>   		timeout = jiffies + msecs_to_jiffies(timeout);
>   
