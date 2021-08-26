Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8218C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74DB3610C8
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 11:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74DB3610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2412C6E7E6;
	Thu, 26 Aug 2021 11:40:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E3A6E7E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 11:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKtHN9fax9qx6HpERUK1+odfknGzSh1/CA3UnjfSp9U30KxKXmhaotHhx7GUUM49Reucnkd2tc1tfEbsd+klfaYVqT3ZcQKX2Pp+BNP1x2++e7QohN4Y+qkLQQxcr6+NbtiF0AANv3wQH2aJwGHNHaPISnPdYobwfx2ozjXykeOI8aAJl/ZNwrNozDJte0KWM6IhslrEn+bvGLL721y5OUxB3XEtwXRjOOSHEi3sVdOsXu37j6cRPIkJ8lqoLdpTrwjkLI/8+6gSw9TS87eqMRHRA5D0nGJotrqZYKR0FlUP7wlE/9IY6G776lGU7ewlw5NgAL4BWPGit5aNpNgCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDGqeR52MsmSkmP36LmKLJLYU8G2JeK2JwfIXALSPqQ=;
 b=R11HstCb9kB7oLya4wR+Bkry0qwh3v6HoGaDTifiRQniSW23s0zcshTYq1AjWU4GJWqo2bGIU4LWrp2Cx5GwxCG4uaEpQs8E96DnNFp4JOATyFKZWS+jOCntIJNd4+jlEIpMudXEsEhjH1QoyAOhx32bI9Fj96LF8AygMPjVhf+C7crFITAdVmTLgBsTVInC8glJ5o4ymy74PImmx4O3BGycuHcav/eENwFRlQ36FhfJ3JsZ5NImQRU3zHVYznGc/sBhBjvFOhBcbnDeXzzQV670PUbO1AFZsDb3b8T+uXcLtMDPvB2qf5r0R7t8wv+NqGHMG4gR2jlwsyeHpD2fiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDGqeR52MsmSkmP36LmKLJLYU8G2JeK2JwfIXALSPqQ=;
 b=HVtS5/Z4iUblTJBrKQ1ajvLZu0yxJWQowybQbZjtwNbs/TIlgDmoRbh8K7wNZ2tIUJSIQCmuXBxtUdutWSOLV7zRzT7TKh92RTe+ZUw7yl/uYtigd56OCEbVn7sLixf7hHqu4bwI7tjK0iyMFf94No93uBDmsVi5WUgjiPtSXis=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:e0::24)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 11:40:35 +0000
Received: from CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b]) by CH0PR12MB5025.namprd12.prod.outlook.com
 ([fe80::4193:5457:4a18:780b%8]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 11:40:35 +0000
Subject: Re: [PATCH 4/5] drm/amdgpu/vcn:set ring priorities
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
 <20210826071307.136010-4-satyajit.sahu@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <f246499e-9cfe-24eb-e6f1-9395d10ad0cd@amd.com>
Date: Thu, 26 Aug 2021 17:10:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210826071307.136010-4-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::30) To CH0PR12MB5025.namprd12.prod.outlook.com
 (2603:10b6:610:e0::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.104] (106.51.20.251) by
 MA1PR01CA0136.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 11:40:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9914719b-1031-41b2-842f-08d96886517e
X-MS-TrafficTypeDiagnostic: CH0PR12MB5107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5107668452722C5B9E74033DF2C79@CH0PR12MB5107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /tyGWYofjG1Ggm8oimX+0RwIx+WQKtz9Z3Zh0KTM3+B+1mriFdRiC8pmIf3Za7maf5WoS9CvcuvgGzuVleqcoVIHkmDclRE7ZGlYZnY5XcGUHqey3Zhf6+3thJjeaM/dMfYHK5ifOEjipYIWEcQ7e8tUZvaubjCWokMQOdHmvR57M2Xtos8Ey/Nuiar6eXsr1k9iuEPIh7iT0FY8K+1g06aOZxcKcscjltdjQ0TdH65W+ufFwd8lWmo6smlbpUoSc2FDmYSrwlFrddtIzArvNySV28KIAP0LwgdtYGuOgh6tWYN9ib2LGTiWx0n0BW5BuGhoTBNT6dPInTl5qj97EqJQMcRUq8bQNX+8OJn6iTbRRvfoE7bYAvHtoEsGHFuo9O5zTEPRNpGwxQazthz+9Q5DyzOM6spoSPzZF9Vvmb1DKWKb0VJNxm8CHYNbPY0oxwXyfZL/GSEfkGQmh6o+zejFrqrOk85uVuDbsxwncgYOd7QPkmYS9BmEWVV9WplExeQRddpGn5a2GO5KEkYr8e7fVTHxnWFBi/vNaeQ+nwo9pNICrmrQbqH//qcaxdkFJNfsGhRRMTM70ohV/vFZemkFhUWg+f/WMPXXkP8+5HqxGh4sgwnjm6Xz3Ams4dhu2VbuJfQktXXP94+AIWxUDEzOTAJXQgN3Y8IH/1D52vQIZAvIczT80ZK+W98xHVgJfPfyaQY9DALD9f4CpgVQd75FN3g+ZD8sFQTV2ueXIkEpml86mALwe4hgElOu04+F
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(16576012)(316002)(8936002)(66946007)(66556008)(66476007)(5660300002)(55236004)(956004)(36756003)(2616005)(8676002)(53546011)(31686004)(4326008)(2906002)(26005)(86362001)(186003)(6486002)(31696002)(478600001)(83380400001)(6666004)(1006002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZ6TWNiL0lqZ1dteVBDY0hhQmxCMFpCNTBUL1d0UXdWMitPNVJZdFVtUCto?=
 =?utf-8?B?U0h1ZytlQlUrQWZFMXBGSUU4ZFRXYnFRRDhNVm9UN3hHOElvdlVUcnVwNHdq?=
 =?utf-8?B?bXVkTW9uK0s3V0lRRFQzSHFLdWh6a3FzLytDS29uMVJ5WDhFVlJ1OWF1K1g2?=
 =?utf-8?B?eHlqNWt2d2F5QlNqcFZiOUhTVEpGaFVOaHBSeVhTMnFtSk01VnZwK3crK2Jz?=
 =?utf-8?B?NTc4U3E2TklMaGtLMlF3OGwxN3pxWlZqVlFUczIvTGJHWEhUcWtnMnE4eVVL?=
 =?utf-8?B?MC9kcldOSDlDS25VSU1xYU9uR3FUa2lOOWErSjVEenBySERkeCtDMUY5VndX?=
 =?utf-8?B?NGxteTA1L2VFWStRWXZZZ0FvTmpJVEh6T29TU2NNNHd6M29SeXhLQmdoeVNO?=
 =?utf-8?B?WmtrZEdFcTRrTGtMaHVNQU01aHUwMTlKM1FpN0ZSWHFHai80QVBLS3lEQkYz?=
 =?utf-8?B?T09mUEV6Skk5UWxmWGk0cXptRnVZZkJDM0VHZmx5a0hvaDVMVEVmdkNJQzFw?=
 =?utf-8?B?N3QvYUwreWZVZE1RTFNwTTlsR2lENTIxY2lTK3E5QXdEQkFPZVdBV0RvaEJU?=
 =?utf-8?B?cXhsU2h0U3ZpZHRWaHpHZXJ3cDhwMkJyQWs5cVZsU0l2SnNFZjlORlIzQ0No?=
 =?utf-8?B?UnBEMHVoc04wT2ZSSTJ0RnR1UGlpTkZaaXcwUHJGcDYrYW9SREFEbXpCOHNG?=
 =?utf-8?B?UWNCSWdCSWdmUUNhZUp1anJrb0MxRys1WXhtZjBDV2o0dE85NUxVVzFMa2pp?=
 =?utf-8?B?THo0M1AwOUl2NVpiQmZob21tRW9SM0dLNExLaGRKZWJYcTBjZ2M4Q0NoOFVv?=
 =?utf-8?B?SGZiOThBdU1aRHRZWnF1aTM4UGx0d09mTWxUcGJSbW9acUhXN2FIdE56VVhN?=
 =?utf-8?B?Y2U5QWh6YmVmT081cCtlVWl6V09HZ084M3N0b3BZbnViN3lScXRuM1RrSEJY?=
 =?utf-8?B?THZlL1pLdTdwYmEwUVp0dGptcTQwWkd5OTBocys5ZHhlamNQVjdQeG9tNzFy?=
 =?utf-8?B?U00xYVdhMDVZTkdoaGcxOXdGY1VxSGwzOXZYVDZRZDBzWkticFFmZlhiRysz?=
 =?utf-8?B?cGREcWlZanhJV0pVZW0vREgvcngxbmtUcVFhdmtnOXNIUnI5Z2lVUXJPM204?=
 =?utf-8?B?TjhmK3ppN2FqWXRHVUxMUi84Q1dia2ZXV3hKN1AxVEZSeW4wSEwwdjJ3VThR?=
 =?utf-8?B?U3BNcjdJNnN4Nkh3UHl0cFV3RlQ3cHVqQnVWZUFTcVg4YzRZVTUwd3grcHg3?=
 =?utf-8?B?WDVWRm9MY29wZ01Ieis4U2lTRW1uaGJzdENvZHVlZER6N2pxTlZFMkdTK0R2?=
 =?utf-8?B?Y2c3QmlJZFhidzJHdmFLSG1WbkRvT2ZtMDlzZkw4NjIrT1IyVllSY2tqcXlS?=
 =?utf-8?B?MFNTNVhyeDdtWDJmU3FqWitWUFF2OGMya0ZWdG5sSGdtN0ViM3IzNlhEdkdG?=
 =?utf-8?B?Q0lLVnlLM1R0QVNQUjNoR1RneXpDcW1RMkJWZlNPbmV0TXhEVHJ6cnh5dFVF?=
 =?utf-8?B?aU03M2IzcmUzWllxUUcwVnY2N1ZXd2RTT2ZYSWhiZUZkRFlxTW5yWU5jdU8v?=
 =?utf-8?B?alRWN2Q2YkozVmN0WEFMQVBJdjYwUGR2YmhYRnRSeER6SFhYa1VmMUZpcTRa?=
 =?utf-8?B?cFZxY2hIaHBheUs3Z28zQUMxQm1MTGRDY09KVCtweGtuZkI5d2FZRHNabEth?=
 =?utf-8?B?M1BuM3FNUTRuckxVQ0ZPR2RSdzdOeTJjYnArOG9FNlJIcmJ2U1ZDOXhqUVYz?=
 =?utf-8?Q?QPsfNbMoIA9ygi/Z6ZBJPe8ANV7z3icn+EdMmEc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9914719b-1031-41b2-842f-08d96886517e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 11:40:35.2893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/7+xcVpTXWonfH5LfibTq5FFQPtfBHk4W1ORPIHgFG/flPANbsML3tqtCe9BFmYaWk24VdKANxzhWW1foXzOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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


On 8/26/2021 12:43 PM, Satyajit Sahu wrote:
> Set proper ring priority while initializing the ring.
> 
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 +++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 5 +++--
>   4 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 284bb42d6c86..51c46c9e7e0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
> +
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		sprintf(ring->name, "vcn_enc%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c546db..720a69322f7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
>   	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
> +
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		ring->use_doorbell = true;
>   		if (!amdgpu_sriov_vf(adev))
> @@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>   		sprintf(ring->name, "vcn_enc%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 888b17d84691..6837f5fc729e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
>   			return r;
>   
>   		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(i);
> +
>   			ring = &adev->vcn.inst[j].ring_enc[i];
>   			ring->use_doorbell = true;
>   
> @@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
>   			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>   			r = amdgpu_ring_init(adev, ring, 512,
>   					     &adev->vcn.inst[j].irq, 0,
> -					     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +					     hw_prio, NULL);
>   			if (r)
>   				return r;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 47d4f04cbd69..e6e5d476ae9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -227,6 +227,8 @@ static int vcn_v3_0_sw_init(void *handle)
>   			return r;
>   
>   		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			unsigned int hw_prio = amdgpu_vcn_get_enc_ring_prio(j);
> +
>   			/* VCN ENC TRAP */
>   			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
>   				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
> @@ -242,8 +244,7 @@ static int vcn_v3_0_sw_init(void *handle)
>   			}
>   			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
>   			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> -					     AMDGPU_RING_PRIO_DEFAULT,
> -					     &adev->vcn.inst[i].sched_score);
> +					     hw_prio, &adev->vcn.inst[i].sched_score);
>   			if (r)
>   				return r;
>   		}
> 

Please feel free to use:
Reviewed-by: Shashank Sharma <shashank.sharma@amd.com>

- Shashank
