Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE4FC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9216124B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC9216124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B6089EF7;
	Tue, 24 Aug 2021 06:14:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C52489EF7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFYYDgp+qWJmiZlxw1SS9pP3qLJZg2FIOAKud4jzRgjgkkaM1p9E7iuwZyVfAGcr5RmDHR//lmH4W10g3oEZD7Y6rhCVOjjcnGdnUYnynwlCBPHCNbI0lvEeKNXzXA/Q8gnZPNCa3z/UXGCAuaChChwhXzf/uDgRMoPK6G2JooRm2h57WKhJJF0NoKqtXEnqNssvWrdUSJ0sOcp9rtsYDnKXtgiLj8FnHKA1inXzySqoU8mIp5uN1T7Jg2damFivETV44O3LvezNNqsfKS5MvgxJfn19kbLbXGDskSPrVKTZNM7tUq08+dZqR2gwSH2g0PJwFuCHrd/7lcsKhF9q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDuSDGG2EDKn5zQLMTDGcb8AuF5YZdnqhBHaRLQT+DM=;
 b=g/bOCfOOqP/iCQKm4Dp07jaHGvn0n+0C+PUnhCanYGiqwoB4ECdbkCXRA+1DcSD491/POEbCg07/CKM2ENM4nKpGO3QgDFP5thMXfQWNpN9CRg6aOUSQ7mor94ZknuTdN2Tng9omOBL5e0thlX37ywNShJsW7NvIi7M7Bsk7zd50LPXxqG3A9eAEohaTGkhzFzB3tIcFl8Qh7CTPsG6cvO9YKzw9S9VqaGT0s5YdMr1rNdvsJA1knZeHsmMdb57MvIEH9Q52JWiVlRnjHRYx7OlI+KRohGjIe+2VI4SMcKw3lDE6PNbcxaep1OyfCxtLbekBDE6yWj/qvBlGTq8pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDuSDGG2EDKn5zQLMTDGcb8AuF5YZdnqhBHaRLQT+DM=;
 b=1TwQSJyAH7aJKiJa8/TCMpIlULaQyuUePhSZFDTywpz7Ab9/fNVT++w0uJ9eaneXKgtAa/YAB9L7AgWNhIZqwMtn5Zk+laH6rzUvu8oiyiaNim8AYKRuAlZACecT3f9IftqDP+BS93fGOLDKe1Ml+vSqmbhdys64ImyEJ6yqB5I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 06:14:13 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 06:14:13 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu/vcn/vce:schedule encode job based on
 priorrity
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <20210824055510.1189185-5-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e55e35da-d513-b8c7-95f2-49edd9026fe8@amd.com>
Date: Tue, 24 Aug 2021 08:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210824055510.1189185-5-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0157.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::24) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR02CA0157.eurprd02.prod.outlook.com (2603:10a6:20b:28d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Tue, 24 Aug 2021 06:14:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f53b92-165b-4a6e-b0c6-08d966c664cc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4913A31D4FDEB939A5ECFA2E83C59@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MpxKri0PxThG4fVDzPVlEX7ii6RNahtfaRasraDiVrLAx7e8iUgoac9qTeDuDyI+alNNwdw3XmYfxZokazi+fEepLKGByUo9We0/cOBr3GJBV0nsyoIEcHeH6YcqrS3amGvwxsMkeZknt6cxr/w06F9xOEU5xbyKuB639zKIAbvOGAeQI+ppfaEj5rl2AtdwK227Tvwx6+PZ0TfE0+u54KCL9W/FsiTuxbej36HTDp9vqVqakQM68gc2MQD86igorXg/LT1KShYHqmPL3NFlgke+VFDzKKyGcsiyfy3gF6xhGr6HxZW8ZT45QEd21fiRQUFOQhEAlRocMKmSg/LXBDMjnd1rXfDOxpq3tRawI5eRWszWb2LwqWJyuG6zpsXjqk5bGWa5xoyaRPGJxEi7nP3Yo9etLGjS0zR2EZImNYOhBpTXocybU5G+TV/zUn1kEmpGtoWh44DD4o4NBglNNmN5MHCDw9P49H99yo+y8Y4pOO9tyH4nwi7WBwwDtkmZHnSr9pDjMPAX7C0CuEjbgJvEoeFNvq96l78HvZwAl3gPlNm4KeuBZKutf29eOWQyRdG51ggp5aahRAtVWgaX8avpsMI/dQqlKRmU2CeknlgXWFplgb4PhrpzCr4eEWlY/qSqpzj0tcCt0wWNNHgmiu+pBLFlgwTq9hbaeCeIrhh+pJQXjtbweg7qU55sDoVmzk0QXkz9PPcl3TtSoBkSRu30lyrwP6Luo70/9zGFryz7C3clAfZuf5g4bCfxjZh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(36756003)(31686004)(186003)(86362001)(6666004)(4326008)(16576012)(316002)(31696002)(508600001)(8676002)(5660300002)(38100700002)(6486002)(66946007)(66476007)(2906002)(66556008)(2616005)(956004)(8936002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2ZtekJXYnAyNkVLRkY3RUUySjNaODVaR251OXhNMUlPOGdFczRaM1NIc1BG?=
 =?utf-8?B?SmM5aDZhRVM3eDJxbW9kWGZOWmxrR1pGY1l0clVicFJUVk13ekZqRVg5VW1j?=
 =?utf-8?B?THJBV1R3TXVra293bDhjb1lNVG9lK0c2VGJSR28vbnpFaWJxMDEvNmtoSDdj?=
 =?utf-8?B?ckRrc3oxQ2hvRlhRUk4wRzl4bkpISHI1NkRGTTdlTUh6dDY1TmpvWjgrWnV5?=
 =?utf-8?B?c3BhQXE0Y0xLSTZqT2dCbDJ3VTZMTGl3VHhYM0plbDFMTHZRRDlxSkV3WFlJ?=
 =?utf-8?B?TzdMb1YxR1hCRFd4RkZaWlpkY1lRZzg2RVFJcEZzMVVpZW5pSW5DZnc5aVhO?=
 =?utf-8?B?RzlObzBpamdFQmsvdWF2azJFL0xwRk1henhLRnhLQlVUL0lJbExVdXhUUmoz?=
 =?utf-8?B?RXNoVVc5SG5RbUNjNk9wSWZIMElxaWpIQTUvcllkOG45VU1Qbmp5WW8vcHBV?=
 =?utf-8?B?NXdYRlZsQXE2TnRZRGVQZ1ZITEpQajdpZ21GUGZCczhkUHkrYSs2S2dRdkVl?=
 =?utf-8?B?RzdKSHgwK1J5TkI2RUZiaURFL2psMTJGYlBhVVBLZGdPS1BlTFRGeXZFc2ZH?=
 =?utf-8?B?UTZXelBVTkhMS01VaE5oNkUxMENMWFNuaVYrb1pFMXhQRk5CcUc2ckFLYXc2?=
 =?utf-8?B?NHZ2cHNUM083R3dZVldqN0hhSk1rUksxRFZ4UUdFVml2TW9HOXh0NjB1bTRQ?=
 =?utf-8?B?SWd4MEJQeHpDcVdKNElGcnRzekN6Z004YzZkSGwxcmtCWnJBZ3VkMVRpQXFt?=
 =?utf-8?B?TlRaSCtySHRCVEkya0hmZlZBNUovZUhMQlV4a0NXWUl0ZkdQdWZlZytadWw3?=
 =?utf-8?B?bEtzRnpLZmFLUWcwQU1mbTlDY1lYcnN2cmgrSmFRUENwdTlhdHpISUxDYmRq?=
 =?utf-8?B?aW1KRHczZG5LMUJDL0paTVNURllkZWYrdjNRSG5ZOG9zVEx0b2d4YTFzQzJn?=
 =?utf-8?B?NEgvdVBRWWJCVDhXeXBBMThoVWZkam9IVGtFYVFJYjhQWURyeitybzIrYTA1?=
 =?utf-8?B?NERUd0NHYm5DNDJEWDc0SURWTDdLbm9ZN0NJUXZ6SjVHUTZWazZua1JYbTM3?=
 =?utf-8?B?UGs5bWlua1k3dDRuaDJybFJZbWJGckorR3BtVVVTd2lramJMN29ZalhvUndw?=
 =?utf-8?B?eXhmOUZaZXJDWFpYSm80akgzRm1XbUgzM0lhUWVGSm9INnJ6elYvTUozMmY0?=
 =?utf-8?B?amVxRkVrY3FFckticW4yeTZqT3pVVVNoSTloOFpWaEJ5MVVYcEJCQktXTGlJ?=
 =?utf-8?B?U1VWcElLUmRQWmNvQ1c4NUxVcHRZZXcxc2lpMlMyeUE5N1dXaGhRdkZDT0Mw?=
 =?utf-8?B?TUQ0a0NKMUhkcDNPK1R4V1BRbm53VzNDOTh0ODgyMVN4eURaOGpyWHhaV1or?=
 =?utf-8?B?cWhZRGI0TGgyb01ueFdPZ1ZhV09UNjR3bzdYVVQ2MFNmY1hhOGczMUlndTZt?=
 =?utf-8?B?c29hc2NEQ0paOEUvMFloVjVacmtGTjlzakVlWVh4UmovYm1GRmhtbmtacFNQ?=
 =?utf-8?B?SzVqcFpCUkpQRjNTWEx6cG9DeTFmbm03dmhJbHpMZEkzWFQrNHFnTVlZTS80?=
 =?utf-8?B?K3JJSkFWT0pzY29wNXJOcU0wd25pcG84WVFxQXRjRHFoT21SSFM0QU9HeGQw?=
 =?utf-8?B?eFJHWmpTOWtxdXFmWDdCVHBOb3hOOFpqaXFBbFBUM29DVXJNYnBrQmJ2VDUy?=
 =?utf-8?B?VXhUQm02VnlqTit3UUUrR05MQVdlVWIrQVdpWTJJVWVwMjRDak1QR3V6UEpV?=
 =?utf-8?Q?qax1WmC+YPbZiGlJpwME3n/WMJ2hOoLpc/REbzb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f53b92-165b-4a6e-b0c6-08d966c664cc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 06:14:13.2398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8gKmLf+Uc+c4GgRMy1+xWr2BIYdMvUo0LGwavlqQQ0F3py1xikwPJMMdbZi5xgS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
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



Am 24.08.21 um 07:55 schrieb Satyajit Sahu:
> Schedule the encode job properly in the VCE/VCN encode
> rings based on the priority set by UMD.
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 40 +++++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c   |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c   |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c   |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  5 ++--
>   8 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index e7a010b7ca1f..adc11bb81787 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -73,15 +73,49 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>   	}
>   }
>   
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
> +{
> +	switch (prio) {
> +	case DRM_SCHED_PRIORITY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case DRM_SCHED_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> +
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(enum drm_sched_priority prio)
> +{
> +	switch (prio) {
> +	case DRM_SCHED_PRIORITY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case DRM_SCHED_PRIORITY_VERY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> +
>   static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>   						 enum drm_sched_priority prio,
>   						 u32 hw_ip)
>   {
>   	unsigned int hw_prio;
>   
> -	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
> -			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
> -			AMDGPU_RING_PRIO_DEFAULT;
> +	switch(hw_ip) {
> +	case AMDGPU_HW_IP_COMPUTE:
> +		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
> +		break;
> +	case AMDGPU_HW_IP_VCN_ENC:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
> +		break;
> +	case AMDGPU_HW_IP_VCE:
> +		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
> +		break;
> +	default:
> +		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +	}

Ok now I see where your confusion is coming from. Those functions here 
should not work with the scheduler priority to begin with.

>   	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>   	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;

The rest of the changes starting from here should not be part of this 
patch, but rather of the respectively VCN/VCE changes.

Regards,
Christian.

> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index c7d28c169be5..2b6b7f1a77b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 3b82fb289ef6..5ce182a837f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 90910d19db12..c085defaabfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>   	}
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		if (amdgpu_sriov_vf(adev)) {
> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>   				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>   		}
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 284bb42d6c86..a41b2c40487e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
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
> index 8af567c546db..9729a383786b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
>   	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
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
> index 888b17d84691..9eca70d3ff30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
>   			return r;
>   
>   		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			unsigned int hw_prio = get_vcn_enc_ring_prio(i);
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
> index 47d4f04cbd69..926c9f4bfc21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -227,6 +227,8 @@ static int vcn_v3_0_sw_init(void *handle)
>   			return r;
>   
>   		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			unsigned int hw_prio = get_vcn_enc_ring_prio(j);
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

