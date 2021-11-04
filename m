Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF31C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 07:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F98611AE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 07:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F1F98611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E4CB6EA86;
	Thu,  4 Nov 2021 07:49:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51636EA86
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 07:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJvM3tTOxho+WS35dfKqFT1TwatQ09GCKUb30dra59qkhRnYiKp/xwLhbDPCOZHdJ+MqJsmgdhslAxPsi6A+rhZbqKmZ7imxzSF4PWcO3J/wanhf+WvXe9Bpmay8HNNny8aAKjuwndMeKQlc3OFzr0kg53jJxv7msIn2uhHRYB2QFWjFgWH3OC/M29+CaLCtkctqv7N+6Eb39UssicOfISrcabc/gHuSruY0YilZubrv/BB3wiqBnftU5dyqFiGxPlgzTlEiJJoljWq/oqOM3lWfZRkal3ZqXNELyHJfS0uapTOI3stJF5GkoCNGuIBHIpGmB/YbI4iUsjLa0uAqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETuZMd5bZnrWiEJhsRvL308LeauWXUObxUNYNf7tsM0=;
 b=FmnNfOprGndYK6eTvZUwcwOb7Q7Hj+8rfY3f7HdQmbr0VH6izg56VwlcznCBy3W7cGimFV8UNdNLGj/Ea774wofLBXFIXSfeEEJz8dIXNFeng6bUlu8MUOfRj5ra7A4pZkQm0TAr9qc12U3LJeo94+2K/9LZEYWGTGrA/xlenmulX6hinmgC+64bmXj80kumwtE6ymhtUwNtWTpaW3xTMu1WobaShP42mg/IEroPp6ghXPr22Qbhhu6VZTDxaEXDSvY2K5tpA4TjbzPpGfFhet9ZRowhuGCV0plbCeouLiSKv2+inOrQroSMn8q7vybkJxdtCDicFSzAgJPO/EplGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETuZMd5bZnrWiEJhsRvL308LeauWXUObxUNYNf7tsM0=;
 b=LqWohNFtjHGvgZEPPu961QF6vs3YqW7/9FmVQ7SGKOc4a5u74Kh0ZwLtPHzozYcLuQ2goje4dutpFzGVtt67o7/5Y0TlH9KM7DV/Gi4VcEUl1U8qdI0QL184WPboV0d4PLnvcevDbTw6+nYXtfnsb66NFG1cpK8Y4V9dXJtqG2g=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW2PR12MB2427.namprd12.prod.outlook.com
 (2603:10b6:907:a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Thu, 4 Nov
 2021 07:49:23 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 07:49:23 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Avoid writing GMC registers under sriov
 in gmc9
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211104025506.533625-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <50daadfb-cb9a-b4a1-3729-0dd241778e1c@amd.com>
Date: Thu, 4 Nov 2021 08:49:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211104025506.533625-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0148.eurprd05.prod.outlook.com
 (2603:10a6:207:3::26) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM3PR05CA0148.eurprd05.prod.outlook.com (2603:10a6:207:3::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 07:49:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 181ca2a0-1ae5-49c2-4156-08d99f679e14
X-MS-TrafficTypeDiagnostic: MW2PR12MB2427:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24271D9A2FF372E130DD6143838D9@MW2PR12MB2427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3P7b2yVl59zHSKPx/J4UKFejFGtGKu1/JD/Few2/ZCr3fA4XPE1CwVJwGGg6nTdqqRhY1dmdduXJb+xNRl/7+wURi/gT7QPAaVDZ0oAjZVQAGB9YkUTucgIfUTscykPQO41fhKEMKwjcS6isL0j3dM9sPDa4AZjz9eHGUP0fGz+ioU1xt4bRRMai2RSif9ZuSJEr5hj22VED5q7NNqRg2Bm3lAxEj7/zv5pMDqwXwQWQ9O20rUyi6+kN6bvFa5XBf3vjao6W9I+7qY6SBBtly2dvDzyI4XBA3z0TeoHng7HZS4y3gaykrPB7QZs84izLvFb4qNJuzaAq5PE2NKBodMZlRIIr2ExJIVzkugNNfqvnRZx38h5vjvEuBAJmCKLtyOV1Y2G3F6o/YnUjNW9Ou584YaTAt6QIt+ZOQV/uQAvyjGatpw3Ndtpjv1SDAdIIGI3eHBnVb/z/ohU1PkM2xodgUpJQNSqhSnMosNb5zXKzCe0SkjvcUQydq67NSsxYBHoRo56mmVt17sRikPrFOs19OMXVi0q5BmvDv2NGGNTYje1RVNVYsPl9x+CMI94O19ifQxeTfJos8oP0+kiSscwaboblfRAka3oZsSbrgxzfZC5PyPkYnZ67D2XCyKldSThnxEm8sRgAfnim1vjZJQtTHUi69UJ8W/l+orK+MN2Z90lfh+vwGozoKJnYqIWGMF+TO6fuwKH4GQq8LGpvkZY5cu/dbwCiYyNDmlqLMLrS7B15JPjlsF2bkikQAHf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(16576012)(54906003)(86362001)(31696002)(2906002)(6486002)(26005)(31686004)(38100700002)(186003)(2616005)(8676002)(5660300002)(956004)(8936002)(36756003)(66556008)(66476007)(4326008)(66946007)(6666004)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JUSFp2UkpKMWpMdFd1RTVMaXJudUt1TmZIUlEyR0RjL0dQZWRRZS83Q0NI?=
 =?utf-8?B?Y3FiS2YrN2E4MGFCazNXNzNzL0UxQnl6a1hVTEs1L25xYzN0cFRqQ0ZDajNS?=
 =?utf-8?B?aWdrdGlhelRETjV3VFYwSEZyZFhQQTN3b2lKeGtHdVlLdnJBRGc1QUZ2QWg4?=
 =?utf-8?B?SEdEMmZHdHZrR0kyMElnYnBZVGRpM2JBdldSNnpqUFFrYlhRczhFU3d4MVlX?=
 =?utf-8?B?NVNaZXdNTVBITnFOdDF0czRBaENzNTlIdzl2MTNTZys1b0lBR0hIOC84aDlJ?=
 =?utf-8?B?Nmp6N0F5NlF6MzExNGJYK1A1bmQzcWdpZVJ6SW9lcHlLMDBUVTZDblZVcFRu?=
 =?utf-8?B?Q3VvYmFqK1JlaHZCeVVFeDFnS1VUZktQVm1Rd1N1cm1zUUxXcVo5dURtU2Ft?=
 =?utf-8?B?NnU2TjZpOUdZdmxvRk1WZW95eStxVnFpcllQeFFnTm9LVHV1azV2QWlxZTRV?=
 =?utf-8?B?WGxuNGVhRG9MMnExclVNeENXeEZEQ2hsYzQ4TGozNnFLSG01Q3RENHJHRjVQ?=
 =?utf-8?B?aDFrL2d1Yjk4b3IvSzIyZzgxVVdpUFc4QUlJZUg1QnFTOHMzZm9VK2RxbnF4?=
 =?utf-8?B?T1ptenlxS0xYN0tWK2JQeHlmYU84NG92TGt5SkhpUDF0WlZRME5RenN4Vkhw?=
 =?utf-8?B?N2t0SExaODllQ2pjRWo4bnpFL3I3ZmtPWWp6dkVxY2ZqeGJFOE12N3RnWDVO?=
 =?utf-8?B?NzRtam1zQnN5cXYxRDZ0bllVdXoxL1VYQURjSFF1d0gzRXZ2ZGdtZ0JSSmdv?=
 =?utf-8?B?SThJTjF1UlZOeGhBZEZ3R0RFOUlkYmZ1RzVyRkFucUVBcHZvTFNIL1NFNm1w?=
 =?utf-8?B?MHRvblZjZytFTFB2TWhRNjE0WFI1QStTVTNzN3RIUHpRTWFFUS9VdHZWMzlB?=
 =?utf-8?B?VDdrVzR3dVFRMkdDVHNGRnQ5LzZWT2Q2dENyclBGOWZLTlVUUTMyZFRSZmFF?=
 =?utf-8?B?OEJYYXRKVW9hdGFQQWZRK0FFckdiVjN6bEZqVlpjSk5kOHVkY3BwcEZwL1RI?=
 =?utf-8?B?WG4zQmZWWk9YVW1nU2RmMGFFSEdQSnpmaDFBNFB6ZFd0WFNuSk1KVTEzS1lh?=
 =?utf-8?B?NVZ2eWdqUm5JL1ZKcDBqa1pMYW01UzYvVHdEd3NaaEw1MGtRRGJwcEZNSkhZ?=
 =?utf-8?B?RjlWZDZiWU5EeC80cnBVaVBBb0czWDUvbysvVEtCbkRiSVJPcHY4ZEpKd1l3?=
 =?utf-8?B?SndJK0owT2xldUFNakR5SUlJS0p3RVo5bW5Ua25uWGVtKzNMeHBEcHJOdkp2?=
 =?utf-8?B?MGQ5MFFXWTg0eGd6SXc1L1pmc2lpVG5EK1kzNFJ6d2RKSTJrbkxBYk9VK3hi?=
 =?utf-8?B?N1JLQkMrU2YyZTZ0RjkxUFkwS1ozU2YxZmRMamVrc2FOSU54U1NOUGovUFFG?=
 =?utf-8?B?ZGRGL2dUWit6VDB3QkhURnBBVElnZ09mdlV6RzZvaVAvZ210WEkwNE5rZElK?=
 =?utf-8?B?K1Zzd0lyK3c1YlFIbDNrbXM2NURsS2Fjckc0a2t2REZSVC9HTC9KeERoQVFO?=
 =?utf-8?B?MjkzWXZGd3RCU05yRkpLVFB2eEJGVExoUmh5YXI0eFZ6WEQyUG55ZG5jaGZm?=
 =?utf-8?B?YzNUZzV0SXZzVmNkNEtITHFvcHBvTHVIODk3RXkrdzRxOVJaSk9sT3duVjhR?=
 =?utf-8?B?MkdzTjVrdzFwS01KYVM2S3doL1B0RDZOYWtZQzJLZzhNTVVQdGJmYU5JWWY3?=
 =?utf-8?B?MU83Sm5wTFJnc0twVDUrU0tQV0dhMmoyVjVMejE5QXB4YkMrRVpyTmpWenB0?=
 =?utf-8?B?QWRCWEZlMXErckwwSlhyMlhlV0VTcGNDSmYxWnIwbEdhbDZIdVgvWjE5THFB?=
 =?utf-8?B?dXB5a0pLdEsvSGxRai80QU9TTjhkcWs2R1E2bFpEQjFXZy9RUkwzQ05wYTNZ?=
 =?utf-8?B?Y1hCSVpaSUdsZk1tcG9GOTVVVUp0b1NVU0R3ajBDblZDUUViMWNoNTlJRi9P?=
 =?utf-8?B?M1Y0TEVsTUtkd3JSVVlKZWlXZ01nRjVpWi9BNVBiSEJnVGQ3amphY1F2QnBz?=
 =?utf-8?B?NTkyQ01iV1duR2h2dU5adHlDQ1lxQmFqSTU3eUd5RlJIRVVsSUpMTTl4ZE5w?=
 =?utf-8?B?U0FvT2gzOUxVZzgyWkNPWCtSNloyZkw0Vkx4bHFGaTJ0NDZQY0N5ODU5U3ZR?=
 =?utf-8?Q?rEvA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ca2a0-1ae5-49c2-4156-08d99f679e14
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 07:49:23.4840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Boah/WbEls26PiN22if8wSLFkAIh/XnA4j3N8FkNPIotS00OvUscbythg/FSL039
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2427
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 04.11.21 um 03:55 schrieb YuBiao Wang:
> [Why]
> For Vega10, disabling gart of gfxhub and mmhub could mess up KIQ and PSP
> under sriov mode, and lead to DMAR on host side.
>
> [How]
> Skip writing GMC registers under sriov.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 26 +++++++++++++-----------
>   1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> index bda1542ef1dd..f9a7349eb601 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
> @@ -348,18 +348,20 @@ static void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
>   		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT0_CNTL,
>   				    i * hub->ctx_distance, 0);
>   
> -	/* Setup TLB control */
> -	tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
> -	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
> -	tmp = REG_SET_FIELD(tmp,
> -				MC_VM_MX_L1_TLB_CNTL,
> -				ENABLE_ADVANCED_DRIVER_MODEL,
> -				0);
> -	WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
> -
> -	/* Setup L2 cache */
> -	WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
> -	WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
> +	if (!amdgpu_sriov_vf(adev)) {

Maybe make that an "if (amdgpu_sriov_vf(adev)) return", but in general 
feel free to add an Acked-by: Christian König <christian.koenig@amd.com> 
to the patch.

Additional to that the patch should probably be send to the public 
mailing list instead.

Regards,
Christian.

> +		/* Setup TLB control */
> +		tmp = RREG32_SOC15(GC, 0, mmMC_VM_MX_L1_TLB_CNTL);
> +		tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ENABLE_L1_TLB, 0);
> +		tmp = REG_SET_FIELD(tmp,
> +					MC_VM_MX_L1_TLB_CNTL,
> +					ENABLE_ADVANCED_DRIVER_MODEL,
> +					0);
> +		WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
> +
> +		/* Setup L2 cache */
> +		WREG32_FIELD15(GC, 0, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
> +		WREG32_SOC15(GC, 0, mmVM_L2_CNTL3, 0);
> +	}
>   }
>   
>   /**

