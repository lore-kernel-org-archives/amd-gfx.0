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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C86C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54EC61262
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 06:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B54EC61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1EB89DD2;
	Tue, 24 Aug 2021 06:10:02 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAEE89DD5
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:10:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOOLJLc7Br53KciWAKE6nST6lmmFIr9mfISI7qLgghk6nq2Us1XUS81s2fb9T829sTHwkzvg0e1db5aTLbUr1VQqhWuSVaKkYFszi4L82HbS90OVMFdXCa7E3SJL+dM7z7JQcdEW4b6CprkkEx1hGPb0Qq0sKSwczcz1W8LIfSIkAhueTSbwlIPFabR3KViVamex2HJGgz63Z6JY3d5GdVftu392HIjxKaKO48d+GgGJSyzv1w6Ng2d4mP1V/nABCJR/FJN06le2YN1b/mGasRZbpNSm43iRlorb/N1Wn7fP3CAZVazQkHOldekHpslpmp/XB/uzg1Nj6GzjETGQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8l34huu9wTt7yl2PlyjUHW4mS0sxk6U5BJh8/JvA2s=;
 b=PaRQDmLIbty4dVvUnbkbwIEdNjyaG8Gc/hSnBOeQdy/7NwjZ0NXPbH3sMX/RY6nKXMi8t8s4Gpfypz1Tj3/aoBFpkq01qbKsEylpMjmiWtahGvxqSdPObRMvglbgygKpHtqRVoIqFC4nBWYhsPn5R7pf9BCnuvpXp56zNtjFnCuRxH93UShCJtjvcG4c+VwmIVefvzc7vbPjsJQt1vr6boTk128vbpAULdEqhzQ471FB4S2VIe/f8hxBF7dOk28crSPfTpXdyuPOYxpzbxtmOoRme2+uOxNGXpxqW9UYYAz57AbNn01z19W5M6RCNl8M78rHmML8iVlob9PJkgXXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8l34huu9wTt7yl2PlyjUHW4mS0sxk6U5BJh8/JvA2s=;
 b=NK7ihz8EtQvkaquUR2i8YQpZi9z9yvOyHj8u3zJ8asjnKuXIW9xpRrT34KeiHFGXyZM6DU5PUq5epLeEWvAYChrRCVL9byIBbx4gaMyOYkJdwomduqYjQTypgqiswB987S4xOQK+Cr6xA0L5LtNoyzfvQxO7Kn2AhAhY6JnYbT4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 06:09:59 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 06:09:59 +0000
Subject: Re: [PATCH 3/5] drm/amdgpu/vce:set vce ring priority level
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210824055510.1189185-1-satyajit.sahu@amd.com>
 <20210824055510.1189185-3-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d011b9a8-d5bb-a349-dfc7-22941999c2d0@amd.com>
Date: Tue, 24 Aug 2021 08:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210824055510.1189185-3-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR07CA0001.eurprd07.prod.outlook.com (2603:10a6:208:ac::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.14 via Frontend Transport; Tue, 24 Aug 2021 06:09:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c5a19c-192e-45cf-82b2-08d966c5cd40
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4913E8BE764F4FBE3769D93E83C59@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RHwj5bKdg7pzHDK27n32/jB6IdKARbUhfv4BgcQnjM0iSHpSVV+9go/YrXYiMdjEj7w7iAnAMH/VFNo5qeRysFz/jLuB/w1Csb7KFIByXfZuNGsLFNulQwFgP+gutm4SeIISI+2K9/Bn3JBpwSEISh5Nr+VhSyZEdF2uFr9djBOT00MpR8rbV452JMaKBHi/liZF7ZQgwdYK4B7LKUiWpAHxch9MLCIZR2nYayKNLtnQha6HN6dTGApvXqHtYiHamsqRbo29dBVkwpK5vt0vs8LV2a29Q40uU3IFlRjEA+n+qGsCE7DgMUwuVGtSUcgQnfFp4DBmyfNmCfT5MtDujIhI/3NoRrq3fe9+y1q0xpLdELo6j8L7FYKs5rtoeX2oueBB6Hh631ggsHBuyixYOnKy6h7nTNJ4azDG04+MOdSsSWihOThTTLNGo6bCCyPbmzaEyuYwn8NWtMABQhwmmytMaWqqSfbPLsMAZonJUJB5m1V54at6qqPjw7JrTiaHxj97Bce/lf1A2HV2J6kTweuyFTiyxytSPcNhbYzggWqx3gPDPAoxzr5+HW+Q5cuO2TF2aXUDzt8Yn7L3PLlIxRR3xWMSmKYL5RiohdYG3LT8Fv9K10Otms2SQ5nLzakLIK+gFFCL713UyTxCtnjGkkDZ3vdDKWBOLDfdU3H6pX1UcLatLDWwlnqzFHsaf+ZE1N5IDlqvkZG99Wc1hG/ku80YhERcte7R8Ys+VJFaAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(36756003)(31686004)(186003)(86362001)(6666004)(4326008)(16576012)(316002)(31696002)(508600001)(8676002)(5660300002)(38100700002)(6486002)(66946007)(66476007)(2906002)(66556008)(2616005)(956004)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzdCTGh6bitlUk05eUhaL0lrT3Z2UGZTcDRLT0ticFcvcDlXU2I4YjU2K05o?=
 =?utf-8?B?cDk4K09qNXp4SGFVamtMMzJnemVMek0ydlBSb0Mvekw2UXF0eCtRV2VQWUpC?=
 =?utf-8?B?c205eWVrdGlnak9XVldMV2ZIVzIrQzl4RUpoeGhLNUJXc2J1NDE5YnJ0U2hO?=
 =?utf-8?B?MkxkR3FZQkc0Q0JqTUdDTVpxNTNQenpEL2RpOGVWWXMzU2pkSm5BTTRCWlhB?=
 =?utf-8?B?YlhkS1IxWFFCN3N5TzFDOFVjZElXSnRVZDZhZXF3aFRnNG9GdjB5Sk1walBB?=
 =?utf-8?B?TzR6MlZacjdNMDA4WE1VQ01UdjA3NHlGcThxZWhTeHo1T3dlNUY0L3J0RTF0?=
 =?utf-8?B?emlKcDZmZ0VpTDZvSUNvRHZwam9VSWdMNzVkeXRiMC9VU0pycFJsSXM2VFdS?=
 =?utf-8?B?VHNwUnZvbkJ0V0F4YldScnlpQVdkSE53ajdWNVZaK1RVWnJZNjlVRGhmeDBH?=
 =?utf-8?B?R0tzb3JwY1BjVUtLaStUM0xWY3BWbGJUR2h2OUJJK3ZVTHZnWXEyOXFURGd3?=
 =?utf-8?B?WnZMV25OZzVFcWk5UmlGK1cvOXg5MjVQSFBSQ0RCbUdnS01BWGhtSHY4Z1l1?=
 =?utf-8?B?aEwyOEtQaWx0V2UrUWtGTjVUZWkzUUFMWjYyY05Ec29TUFZZd0lXbzN2MmF0?=
 =?utf-8?B?TE8xRkpPb2NvUkJkYzJpdmNXM2xXdWhHck9ocys2Nm5xdzBhTlQyc0cyL0hX?=
 =?utf-8?B?czAwZElvbWZDVG8rdUdKK1RSZjh0WStEWWhVZi93cE52czhUclN1dUljM29P?=
 =?utf-8?B?a2RwM1FZZmxHOFkwenY2ZS9uK2R2SW8rT2w2d2FVRlgwVUpJOUVsRUtDa0Rm?=
 =?utf-8?B?MUJlVElWVk4rYWllWEZ1NnFJTHdiekt6bkVlZkszd29aWEw3MTBuRjJ2WFN1?=
 =?utf-8?B?UG9wY05rVzJlWVJZWkd0OHFwMmVRQU1oSG1wZGdpSTBFdDAvcnFKMHpQTnc5?=
 =?utf-8?B?OTNORm1NNnNXZ0xWM0Nabk93QXk3VGJoalhDSWpuNllDUDI0d3pVanZrTkRV?=
 =?utf-8?B?L2tRTkIzMDRoeGVyZ1ZCZ0UzcGFqaXhtb1hKaGxpT0VaclNFZE5CdVhTMVBl?=
 =?utf-8?B?VE1yaHVuSC9mMnRwalU0YS9tem8wN1FUTzJ5L2ZheG4yd0VIUWI2T0FMZk5V?=
 =?utf-8?B?VGtWem5EeW1sdC9aQURzbnNMVGZOeGJnSzhMelFLZXErZ2pTdm83NTh3ODZ2?=
 =?utf-8?B?amVOZmRxcm5tTUhPK2tCbjU3QWFQQ01UczhBd1RYS3BQbVlLQnMrczR0UklL?=
 =?utf-8?B?ckVRRk1wSmhSNnpZWVJmdG9DQXZwTS9RVXFqbkVUTHRKRGdoNWhlNnFEUU5o?=
 =?utf-8?B?czAzVk1PZ2JHWTJ2RkxOT0hBY25obkdtVmROSmdPcXNSamJnc1JQYUFsczhO?=
 =?utf-8?B?aFJsRGZEMHBIOTBkUWZUOG52bFJzYk9wYXdtRVg1SEdiQjlUcGkvVnBSdThS?=
 =?utf-8?B?bFl2eG9JbS91aFdHbmZGREFqT2QvSExIR3AxOUgxRjN1amJBV3U3MlNOVUtT?=
 =?utf-8?B?RFc0bnhIVUdDK3pJNUd1NUhJa2ROUk9janY4ZTJkWUZOYUNGa1JsSzU2anRq?=
 =?utf-8?B?Zkl4eXVSTlJ2aU1zelBMMU0xcUd5aTFIUHJEYmFrTnAyTGxIbVB4dVdnUS9G?=
 =?utf-8?B?MG1CTFgxUjFEdVpRVlFqWWlIMU95cUhEMmFVamZmeUdoaWZzMzZURDM0c3Br?=
 =?utf-8?B?SGVySi9yRzlGTTlmSVc4L2MxWW9iV08zcnJHNDYvZDNMZ1RGM1pzUGYvMzdT?=
 =?utf-8?Q?+KMpaegcvHFRmpWVLzAXu2nAWgPgPhNmpSEJ+sb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c5a19c-192e-45cf-82b2-08d966c5cd40
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 06:09:58.9922 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfZk3okbxm4WTEPMeIsKLE5hSTCqmgrcusEcqwwhNUJhOjD25YkcyTB367TJLhU/
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
> There are multiple rings available in VCE. Map each ring
> to different priority.
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 15 +++++++++++++++
>   2 files changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1ae7f824adc7..379f27f14b39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
> +
> +enum vce_enc_ring_priority get_vce_ring_prio(int index)

Please name the function amdgpu_vce_...

Same for VCN as well.

Regards,
Christian.

> +{
> +	switch(index) {
> +	case AMDGPU_VCE_GENERAL_PURPOSE:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	case AMDGPU_VCE_LOW_LATENCY:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case AMDGPU_VCE_REALTIME:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index d6d83a3ec803..3cb34ee3e4b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -32,6 +32,19 @@
>   
>   #define AMDGPU_VCE_FW_53_45	((53 << 24) | (45 << 16))
>   
> +enum vce_enc_ring_priority {
> +	AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCE_ENC_PRIO_HIGH,
> +	AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
> +	AMDGPU_VCE_ENC_PRIO_MAX
> +};
> +
> +enum vce_enc_ring_type {
> +	AMDGPU_VCE_GENERAL_PURPOSE,
> +	AMDGPU_VCE_LOW_LATENCY,
> +	AMDGPU_VCE_REALTIME
> +};
> +
>   struct amdgpu_vce {
>   	struct amdgpu_bo	*vcpu_bo;
>   	uint64_t		gpu_addr;
> @@ -72,4 +85,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
>   
> +enum vce_enc_ring_priority get_vce_ring_prio(int index);
> +
>   #endif

