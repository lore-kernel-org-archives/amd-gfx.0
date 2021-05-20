Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E84C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 04:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D24E0610CC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 04:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D24E0610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1C489932;
	Thu, 20 May 2021 04:33:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0706389186
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 04:33:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5gooe1A2bBfi2UAN28hItXbR5zZESrSadKmFyypwZ6jV2qf1+irvoKUuAIU/630ENYvr+qntf5nsdwktI3hfLYngPwtvt1hpfJi8Zou6pZ+aM0R+NjhnmOn3UQ6KKFQ322ZimrWcv72u21W3F/F3y26htVOjC12TOgLRN8oA9y+Xx0MDnip6wPHOcBiY/5R7L/dre2RuNChsu0dkJDwVnTr2GTitjpdJGoNG717FxAsy9gxKzHuZVRT1mnXO96zZI7cYEjKsWF40LIZtqmoPzk4n1oii1JCXvnNpdusFr/Ng/KSVToiOmfUGpMaxpqEH+S5Aq3wPIcG8755nhia9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WALLsOguHsBY2rZsSh4yw7vN7BuXt13Dbm7oVNxwKk=;
 b=KIN9FuZ/OqppolJma9DETS4DtIn4WRWcTMaENhtRDbQ4rnL7mQbVC4ihZhMhGPtBVLZYDFBs1eQ/bOHANGtxcJeYPR/ZfHu+1B5EsgCYQiZpjfxzxd4oV7yTl/mJ0q6UZsRJA3FTHqRMxL9lBEFkCquuBM6biT/+IeEPNbQfzxjCll/VJoCEBIlC/FgpJKjbCMVEmD8+nDTfTk64GRkhI1G7/FGcBr3fj8HiO2Kj4fxnptZXiCoOoENygymehDhKb+oc/AJhhcjy9j7ynK85od3ZIB+0edqoaz1oQQViKxki+jOyLgB1uM0a2qyXD4pL66IZ9fy8+Q6GatUA0BNMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WALLsOguHsBY2rZsSh4yw7vN7BuXt13Dbm7oVNxwKk=;
 b=rNEuXV/idZcwskJPs3qDVYBHTShTVlgQPAAvwLZw5D2YgQXkBXOm5aO1paGqU+Yf4L9+UxJ8fA0UVxivuNDqAxBgaDHSNmL7f7V3a6q4kVHmwFTORhPpf2yhkvcz/GXLWCZXfoJHLEwl2Kr/JkzKSTeR4m2Nbk6R4htZuH9R73w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 04:33:14 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 04:33:14 +0000
Subject: Re: [PATCH v5 03/10] drm/amdgpu: Modify GC register access from MMIO
 to RLCG in file kfd_v10*
To: Peng Ju Zhou <PengJu.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-3-PengJu.Zhou@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c28125c5-fc0d-4abd-a43e-52b38a1d26bd@amd.com>
Date: Thu, 20 May 2021 00:33:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210517143910.2125-3-PengJu.Zhou@amd.com>
Content-Language: en-US
X-Originating-IP: [142.186.56.206]
X-ClientProxiedBy: YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.56.206) by
 YT1PR01CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Thu, 20 May 2021 04:33:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15def9a4-827d-4d1b-5a8f-08d91b4861a6
X-MS-TrafficTypeDiagnostic: BN9PR12MB5340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5340CA91AADBB1AFE56EF0E4922A9@BN9PR12MB5340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jNw27Fdc58MCTBV2E1O2aCZMRoih86NWqtFiqRcELvrYyhy7rNu7B5/Hnd7vXWjhFXUBbjLVA8N9YkNhyl5ceVoRBh3SmACceTfrvwtM7ENcUXM7nvGJjzK7cbiaiVg1Op9OxRy0HbtHcYfknwfHI1yPh0qKEMScxB1FaNJP9iYoLTjtvtwde99ZVX/N/7xRB54R2zEM1ERn9ylaZW8kj+v5r+zRpnJUcESTiiqi/hI0qZlF4UvjODdcj3Jh29yP4UYnkJpOWEB701DhOL/H6KHOOUDPd2Pzl1nyBVWg2MFAvleodjSApeEeKt6C8RqmwXqzlEJnHPa531BmM5czrQJvszoMF63DFWyw/AMRUI7/LuQtB+bCZU4tuQ82QwdVkWPRwIM9C9zJgOHkRFPFSjIsgsJzZ0Ufly+DgEngmj+PoRM7CEKakPZu38IAO03DOMQn4GG6Vpx9FV9lMgsGhMU/TrybHlwIdmuC/CYXMk63hWw4ZLIGEkuvdrtK1HmFdl+ikJnROnk1tx/9/aotC87ZNYNZb+Qd0iimxp36tBYR0Uk4ANjh0Cro/1DCcc4k+41VeYKHzQE425tf1jCwyc6GvzDYfpDxn7hXfZ9Aj0nTH9ULHRSk1M/FaDgbyRJFLb7Gzolgl5mpFQIFdSBZyDKy+kPMXXCsms96++vZ6D2yNCVksY7DAmQsMnt4tUyu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(6486002)(86362001)(186003)(2906002)(44832011)(478600001)(31696002)(2616005)(31686004)(16576012)(316002)(83380400001)(956004)(66946007)(5660300002)(26005)(38100700002)(8676002)(66476007)(66556008)(36756003)(8936002)(16526019)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXMxbVdWeml0WFdBazQwZkhqRUlJSnhvZ201WFdsS3h1WWJVMDlidk9VVmRX?=
 =?utf-8?B?OGNPZElpcm5pQ1IrQmJlUkNZaHY3bGhGYXlQbmFmU0hQY3BBcG8wMGdPUlZl?=
 =?utf-8?B?cGF5N2NQMHlqYU8yTFYyRmdHa0xoMnEwOEVjN2lwU08yZGdXcCtOekE2SkdG?=
 =?utf-8?B?VjU0MmRuRHJWaVpybGxnTjRqSFhlTllPZEVyaWUySG5uMGxQdEd6NGlCUWtR?=
 =?utf-8?B?MFpFMHBleEdXYzNTcHJhZG9zM045dWQvNlFnUnFiRlFNRldsSmdqbDJ4Zi8w?=
 =?utf-8?B?bHR1aUU4MmtaNzNyLzgzbW94Ky94TVZVQkU5SlZLelEvYVNjSy9JdlhqWU1U?=
 =?utf-8?B?QjRNUWx6YVRwOEJRTDM3dEpXNURSVW0ycWNERkVnMHBvOHFFaCtCWCtaT1h6?=
 =?utf-8?B?K0NWeFNtbk5UUGpUNElWWSt0VFJKREZkaDRvYTM3WEtWM0NTRmtkZWpMVDh3?=
 =?utf-8?B?ZmU5bSt5RndRSi9DL0dXSk82bkxNUlhtYlU0U1pzT2taekhPeVBjck4vOXBW?=
 =?utf-8?B?YjR1WWJMMHpoWnkwSkFFRmorcGRyek9DNzNPN1FIeFFIbDhLTlhhTmh1OEpW?=
 =?utf-8?B?dFN5UDJMSS9rQ0ZWL1JsQW1pdnlyaVdwUGhPek1kbGhrOXlYNXoyQktGN3Nj?=
 =?utf-8?B?R3ZmT0R6N2luN0pVRDRXYUIyRlNyMW12NU1Yc2RlbFdLRkFDeG9RMnNNTFFq?=
 =?utf-8?B?WGdobmJwRkFIS1E3dmczMll6cUZKc3ovQ3kxbVRsMmdlM1JqaVFDMW9zcXd2?=
 =?utf-8?B?bnAxdDZEamlHVVJQT09OeWtDQnRPM0gwNFBMVDI1WTZTUjV5OWpwT28vbWlC?=
 =?utf-8?B?VmZqSlRwbnlDaSszTTN0aGRnUzdaZG5mOHNIRFBWWEFnNTR4WGRCc1huYXRq?=
 =?utf-8?B?aWtpMEl5Y2UvREJncm5aRFFpOCtCUzNCVGhWM3ZlWTZ5RVBrOFdJZ291ejlv?=
 =?utf-8?B?SldVU2g1VkRjelNQbThjS0ovZW51QzRKOXRvcmVFRGhrMVZQazJFeWNZakY5?=
 =?utf-8?B?eXNmeTNhc05qYlY3WU1kdlZoOEtzS1pER0FrUUZ4eExLOElpS3lKQm5MdFVW?=
 =?utf-8?B?bm5KOUVLR3NqbmtvUVpsVTFCSTZnVnFTYUVqNEtJL0tXdkFqcUlEZzEydjBy?=
 =?utf-8?B?alJ0Y3hDc2RzQXpIUENqWGRJZWZxalVhcmJzcWJUMWFmMk41RlhsTDU5bmh4?=
 =?utf-8?B?QmNEM2FoZVJmUFliU3U0SWl6WlQ3akVEenNCV2JxMFd4TDMwQlpIZ0ZEVWtM?=
 =?utf-8?B?SDVDa2NjaE1jM2tXWEZLbHlDekNaR0VaQzcxQm9jeWZpOWhQS2daU1AxU3d4?=
 =?utf-8?B?VU5rbVphTEQ4ejAzQmRZanNTcitxbWZhZC9keWRHUEZqbzc0NWJBVWVWV3JD?=
 =?utf-8?B?Wjkrc2EvVEJ1T3hJSnZieStTNWZUeDZ6UExQQzFHbzFrVi9GSkUvOW04cHRn?=
 =?utf-8?B?ckhTYUVmU041Tm5tMWpHb0pEbE1CTTd2Z0h2eHNua3FyNVlGWTNkeFo1bkpr?=
 =?utf-8?B?YlJxVGRsYWQxYUQ2LzRTU0o2a2JERlowN0c1eHc0RjN5ZVdaZjR1Y1Z2N0Zy?=
 =?utf-8?B?UEowY1hrbnZ4MmF4ckpZQld1NDJyNnQwNmZRbmRwRlp1MHZNZ2R2YjFVOXp5?=
 =?utf-8?B?Y3lnUjEzcG01eW0vYUVISjR6bUxTQjJFNE1keE9od0FSTUIzck42ZEFWOWg0?=
 =?utf-8?B?N2hVaGxtbDhNQXUzT2dpZ0VuaDFyMzFXOEJ3TmZTSVVqbVFTbkZKdXQyRlRw?=
 =?utf-8?Q?sBMwBMsoXIYuE5WVgcC+M4f61N2RMjIwwQvck3C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15def9a4-827d-4d1b-5a8f-08d91b4861a6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 04:33:14.1235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWPCvVQydryZXlOpShfQD3pz5UvBwuTdWBF0kCnZxzfXKWWXaVR1tIoeudK0Ycrh2zy/SsaAbjZAO/gL+luRiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-05-17 um 10:39 a.m. schrieb Peng Ju Zhou:
> In SRIOV environment, KMD should access GC registers
> with RLCG if GC indirect access flag enabled.
>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 42 +++++++++----------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 62aa1a6f64ed..491acdf92f73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -96,8 +96,8 @@ static void kgd_program_sh_mem_settings(struct kgd_dev *kgd, uint32_t vmid,
>  
>  	lock_srbm(kgd, 0, 0, 0, vmid);
>  
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG), sh_mem_config);
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmSH_MEM_BASES), sh_mem_bases);
> +	WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
> +	WREG32_SOC15(GC, 0, mmSH_MEM_BASES, sh_mem_bases);
>  	/* APE1 no longer exists on GFX9 */
>  
>  	unlock_srbm(kgd);
> @@ -161,7 +161,7 @@ static int kgd_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id)
>  
>  	lock_srbm(kgd, mec, pipe, 0, 0);
>  
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmCPC_INT_CNTL),
> +	WREG32_SOC15(GC, 0, mmCPC_INT_CNTL,
>  		CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
>  		CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
>  
> @@ -239,13 +239,13 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  
>  	for (reg = hqd_base;
>  	     reg <= SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI); reg++)
> -		WREG32(reg, mqd_hqd[reg - hqd_base]);
> +		WREG32_SOC15_IP(GC, reg, mqd_hqd[reg - hqd_base]);
>  
>  
>  	/* Activate doorbell logic before triggering WPTR poll. */
>  	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
>  			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL), data);
> +	WREG32_SOC15(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL, data);
>  
>  	if (wptr) {
>  		/* Don't read wptr with get_user because the user
> @@ -274,27 +274,27 @@ static int kgd_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id,
>  		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
>  		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
>  
> -		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_LO),
> +		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_LO,
>  		       lower_32_bits(guessed_wptr));
> -		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_HI),
> +		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_HI,
>  		       upper_32_bits(guessed_wptr));
> -		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
> +		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR,
>  		       lower_32_bits((uint64_t)wptr));
> -		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +		WREG32_SOC15(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
>  		       upper_32_bits((uint64_t)wptr));
>  		pr_debug("%s setting CP_PQ_WPTR_POLL_CNTL1 to %x\n", __func__,
>  			 (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
> -		WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1),
> +		WREG32_SOC15(GC, 0, mmCP_PQ_WPTR_POLL_CNTL1,
>  		       (uint32_t)get_queue_mask(adev, pipe_id, queue_id));
>  	}
>  
>  	/* Start the EOP fetcher */
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_EOP_RPTR),
> +	WREG32_SOC15(GC, 0, mmCP_HQD_EOP_RPTR,
>  	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
>  			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
>  
>  	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE), data);
> +	WREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE, data);
>  
>  	release_queue(kgd);
>  
> @@ -365,7 +365,7 @@ static int kgd_hqd_dump(struct kgd_dev *kgd,
>  		if (WARN_ON_ONCE(i >= HQD_N_REGS))	\
>  			break;				\
>  		(*dump)[i][0] = (addr) << 2;		\
> -		(*dump)[i++][1] = RREG32(addr);		\
> +		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
>  	} while (0)
>  
>  	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
> @@ -497,13 +497,13 @@ static bool kgd_hqd_is_occupied(struct kgd_dev *kgd, uint64_t queue_address,
>  	uint32_t low, high;
>  
>  	acquire_queue(kgd, pipe_id, queue_id);
> -	act = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
> +	act = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
>  	if (act) {
>  		low = lower_32_bits(queue_address >> 8);
>  		high = upper_32_bits(queue_address >> 8);
>  
> -		if (low == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE)) &&
> -		   high == RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_PQ_BASE_HI)))
> +		if (low == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE) &&
> +		   high == RREG32_SOC15(GC, 0, mmCP_HQD_PQ_BASE_HI))
>  			retval = true;
>  	}
>  	release_queue(kgd);
> @@ -621,11 +621,11 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
>  	preempt_enable();
>  #endif
>  
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_DEQUEUE_REQUEST), type);
> +	WREG32_SOC15(GC, 0, mmCP_HQD_DEQUEUE_REQUEST, type);
>  
>  	end_jiffies = (utimeout * HZ / 1000) + jiffies;
>  	while (true) {
> -		temp = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_HQD_ACTIVE));
> +		temp = RREG32_SOC15(GC, 0, mmCP_HQD_ACTIVE);
>  		if (!(temp & CP_HQD_ACTIVE__ACTIVE_MASK))
>  			break;
>  		if (time_after(jiffies, end_jiffies)) {
> @@ -716,8 +716,8 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
>  
>  	mutex_lock(&adev->grbm_idx_mutex);
>  
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), gfx_index_val);
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmSQ_CMD), sq_cmd);
> +	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, gfx_index_val);
> +	WREG32_SOC15(GC, 0, mmSQ_CMD, sq_cmd);
>  
>  	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
>  		INSTANCE_BROADCAST_WRITES, 1);
> @@ -726,7 +726,7 @@ static int kgd_wave_control_execute(struct kgd_dev *kgd,
>  	data = REG_SET_FIELD(data, GRBM_GFX_INDEX,
>  		SE_BROADCAST_WRITES, 1);
>  
> -	WREG32(SOC15_REG_OFFSET(GC, 0, mmGRBM_GFX_INDEX), data);
> +	WREG32_SOC15(GC, 0, mmGRBM_GFX_INDEX, data);
>  	mutex_unlock(&adev->grbm_idx_mutex);
>  
>  	return 0;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
