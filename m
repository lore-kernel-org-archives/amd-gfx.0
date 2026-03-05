Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D57EEF305
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 06:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69BC310EB13;
	Thu,  5 Mar 2026 06:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lDh8313h";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC7B10E200
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 06:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCkjyZrYY9zUaWUn+Z7aBMf1vfx1RQwnGjrcBoUXpquR/oe7VKGBIe8nVNYO9uzf2jxdbxhiJdWDCrd8oLSaU+9JpFopjB1jUZo0cjBwH7wTFqXNgqVuGIROSh07PKDdQ+W39MvBeH1lf2dimJXmeSTlMrL95Gnd6BkwwGeSZBf0WTu/l5VqYGdwi7b+q0vyPCrxzrX5oXTNc9rpfirjt8QXJafwq8bup6Zu7CC7yVseW2sGS9ptzmciCd4YTMYgofq8a5DjcoE/wuXp1KxqODY+DQYMR++KhpA8wRepZORGYOf3tXP9lHbpCsUA6OGkDgWLkBWHjyknp/meRd0jZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKiyVSB54Qj/ntQXiADJ+BAcE8dDMXcuvDSJMLCm+eg=;
 b=Hz726DQTGLyVrrg1tC0hMQsloSTgyMhlqs9SCzVtMz9Fzq/6D8I86jsh1pQrfuSnKjH/Z+3LycbthKKp1sTmo495or3OALVEgHFW2B5jWXQVEhxynS81QBk2jZZUeCqYFC1RLrxJ/4IvEetHLBdIPPXUrmaTzdjn5WkOxUQ1pSxFN3F3MKS890KmZ39q2+seF4mZdfjZFW5uHiwVs3RAxGeYdHycAXfgLTLo3UtUzQRXqMLuLngR4KzeS79pYfbnbJawAXtTk4YypdmFqQA/g7vcHga3B4QA0UlzPt0GlPSFMJLCVR5Qzp5/MwRcoj5HibS6OK2Cbe+esLBP1AFAKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKiyVSB54Qj/ntQXiADJ+BAcE8dDMXcuvDSJMLCm+eg=;
 b=lDh8313hfH/IWL18yXUgFmtBQqRoIDOttiuJysBUkqZLzXM9eAirXKOdOAW5U2gYnkeISVBPEso2ld5WdiISmEyg/8T9Fxd0rasUWvdvPewCnDnXOFWovnlmYZmj5jbMF1T+8P7T2Zb0eNY82foIkdx8T6/nObTpbh4tzYparA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB7679.namprd12.prod.outlook.com (2603:10b6:8:134::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 06:02:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 06:02:47 +0000
Message-ID: <a220307b-3cac-4c7c-85ee-0627d8cbe4d1@amd.com>
Date: Thu, 5 Mar 2026 11:32:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx12.1: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260304151302.62594-1-alexander.deucher@amd.com>
 <20260304151302.62594-2-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260304151302.62594-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ee2b53-7b25-40b6-88b4-08de7a7cd34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: SiAXmB4zSOAiDS2Z3/d4tSmTgQKXF9WT9uX9cqAHnkYy4gN+Q/WOlVPo3e1pHgj5JSUTyMgo7E1eKsUU5mOmCOYtI4nk+kGEJbMeNacSnJVuBw1bnYYcBaPkxIL9S08P/b+U2V5RJdJXOR2PQfCwAO2p0jkBOFuIWBoNMa6t2Ve3RE4eTdxpAOSIssxXvG4edTL05N+nBPgdtNW7iWpHco3+BGZPYOQTkC09EtpatRIk8SWRtZGoIEucGZEmAoGesar81sMzGfZ94xC9tbCRxCFcVsvptiC1c4FxvqGD4UR21e7Dr9sv+yjF5rrandFa0Ab2v6gbay9SCzFKfh1Hc1mwUc19bafC/qSCBI+PS6qLRwAJSmpeAAgvyX5CDQqBarMSujI5eAulrnFTOshvwMhRPWRjI8qF6/YNXy4kJ4vu5D1nwvK2zPXdevFkWKDOEDordCrIPxOjIYs+qh4AlMzCPMNB8ruy0rg9eQv6fx11r9Gc1KOYeYFvS1bj9r5rB9ypXebiHP08flPeKGiHNMMxXJ+dytJiWRRR5TJSJ9gWTHWIPrLuUCMv6Pl4iGCgH2RdIkh3vmFbg9XPxao1DW8Tj+54Nu3VGrFF8tYWrOtpr4QY75AOnQSRvUMr0dREW9/V3i7oA5mdRNyOCFvAQwvQtlWHcArPxdO/KTcrmUOVhBsRG2+bt1T8Lq5o1Hil8FLj6Rz2s7lNfUdFFq2Ag43FYDcb3gwLrq4NeY1XFcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXpzenJHblFJZTBFc3pncHB0MGVKTVcyZFpVcVRCRWJ1QStvYnFXMTNFY3pG?=
 =?utf-8?B?M2krQXVRNlhBV0JTN3gwOHVsdmJwTHhtR21ZWk96dHpTV3pFQ0NzdTNSbk5E?=
 =?utf-8?B?bklNTURlNk5uRlNKUHlvQ09FVmk4T1doWmx0bzkzM05IMTNDZ2dITVd2SFFG?=
 =?utf-8?B?d1dVaGdTYzBTMmJwcWw5aExhemRZYnZ2bTFmRnk1TmVLNlltYTAvdFdDVXdy?=
 =?utf-8?B?MFlRQTlQN01UMThUS1FLZlJJNFVzN0kydXVhQ3J4NG9Zam05WFdCaEM0QVlN?=
 =?utf-8?B?bE1Sc25waWJsZ09sZE9mTmg4cWdrQllleUdjMzcvMURCclZBL2t5UFpuZWxE?=
 =?utf-8?B?SExKenRnM1phZittRUtwcTF5QzlTVkU4ekNJSVZmN2RPNG9KTllscGNhMUFI?=
 =?utf-8?B?VGRpK0ZrYzEwQ29HdVdwbEc4VFhneWJPOHY0L04vREtzTzk0WHp5WjMzVGM4?=
 =?utf-8?B?TCtGSlZMU0JJVzFjV0FNL2NqQXRrQjdrQzBOQWpZeUQ1RTZyVUZraDA3RWxG?=
 =?utf-8?B?ZXFQRm1YbFh0c2Y5RE9iYndWZFd1cm04MG1KZU05SWg3bzl3RGxLZFhlUGl3?=
 =?utf-8?B?aFVWUDZobklZaU0xZTgrUTJtQUNYMFJacExoVzVSWXVQemRXVlUwZzk0b29r?=
 =?utf-8?B?akhNYitvNWt4b1o0aWU0V3FSZ0dBT3R1b0NRQjRscXFvSFdxcjlWcHFXWTBs?=
 =?utf-8?B?RDFvYXZaV0VrcUd3NFlGK3ptVzAyYU1yMTJOMi9kTmZpcWR5VDk0NThXb0M3?=
 =?utf-8?B?ZFR0YjZNR1FKY2hQd3hzQjFLdnh1aVd4dVdGUDQ3a01jaE0yVU41a2ZleHpm?=
 =?utf-8?B?bUhRa1BxWnVTNCtURXlkQ3JjTnozTWllOGxMWTBUenVwbkhISVZ6dTZzM1ZC?=
 =?utf-8?B?dit6bTdUUW9hVnNYQVRRazJ3ZVpFa2VOYjFDQTRoREFpTk5SQ2dudFI2WVEv?=
 =?utf-8?B?NFVzYS9udnluRDdEL2YxZGFBTEhjRDhMMEhoQ3Q5TUNhK2kwaGh5K0FTSFJH?=
 =?utf-8?B?bXlPRTNUcjBXenVTb3I4ZG5IMm5BM0M4VXhobmhuby9KRzE0RzFBZWJ2N3lG?=
 =?utf-8?B?blhXdy9FWGVzZFJLYjlVaGlJeFJrY0tMKzNjLzVMSEx6d29BS3QxWld0dW8r?=
 =?utf-8?B?dXVndnBER3p4c0kwbHFEa2Q2eEk3MlB3UHVBS3ZUdFA0bzVSYXpBaXY2dEZW?=
 =?utf-8?B?VDlNMU0vc3dkZHVlTFBablE1U0VUYklNWi9QNDZFT1JZdzNNNys5SGtuejhH?=
 =?utf-8?B?Ty9hRG1OQko1cGJ6M1NBeGVlLzI0eGh5eVF5VytBaUJNSVhxcHlhY2RtTXpG?=
 =?utf-8?B?NTB5emQvVDRnYVZ5WnY3Ym5uY3ZGVGlMd0IxMmFBZlpHVEFNSXVjZTRVZW9t?=
 =?utf-8?B?RG0yN3hOTm1Xd2E5Tit4eUw1Lzd0STE5eXhxdTRCaUVVSUpCZVQ4ZHVrVVgz?=
 =?utf-8?B?N3RoRnU0S0hDby91eG93cC93N0NrQXc1bDhZTFRpL2tCTHE0ZDFhZE43TnRx?=
 =?utf-8?B?TUhNYjN0K1Iwb2N3cUk5cFJOSUpKbVc1Tjh2RTR1ZTlNOTI1cmc2TTUza0dC?=
 =?utf-8?B?NHZWa3kvL2diOTF5UkJmVTZ3ZlEzS2twbC9BMVFOcmlnSmViQmtUVWJMNk9N?=
 =?utf-8?B?RnhlL2tQV0xTd0t1bDA5dmsydW8ySVFiOHZjQW1sU3U5cDdMT2pZZFRsZTI0?=
 =?utf-8?B?S2x1NUFvaUZoaTJRTzVTcTNkTlFEUVJLbUx6eHZxRXBCc2hqdU9YTHkxRUNt?=
 =?utf-8?B?UlhBRHdhQ3VmbytybXpRQUpWejdGaTZLMDB4d3ZwWWdMLzd6VmdTazhyVmRX?=
 =?utf-8?B?TVFPQjhuUHYyVXVLQTIzNWZnRDZqSFYxWmJ3a3BVT3AvS1BqYStJeS9lOEVj?=
 =?utf-8?B?M0xaMHJHNFEyVTZrNzNOcUpGWTFFMmdrSm5WUDlXcEZpYys3TkRFTFhsWFpQ?=
 =?utf-8?B?dmRlT2x0OEcrSFZoOWV0SzNWSDhNVmpnS2hHQXlKRys5Smt1b0pPL1dLZHVO?=
 =?utf-8?B?cmd3a3lUOWFCY0s0NFltaERTN0RXWWpKeS82MmFlVzg2dkJuRktFV0RWcHIr?=
 =?utf-8?B?SGUwd0N6QWdrR1dkV1dRMmh0TE1lMCtrUlRzZWdXcW1DVjQxZEFKbmluK3RU?=
 =?utf-8?B?TFhKZEZJVnlDTmlYbk9HcjN6dEhETGJiMVdCMzZydDc4bkxVWlN3SEpBMDgr?=
 =?utf-8?B?TmxYT1VTODZyZFBRaFlPN0VxeVFjRUhxenI4KzUreFRMd2NXd3U4VzRINDNz?=
 =?utf-8?B?ZTVNaTVTbUJGZkJMLzlBU3B0N05PQUw2M2huYjdIVHFteS9ZTm1VNW92Umpl?=
 =?utf-8?B?RzYrdFlnUlFseWhVR1g5QWVobDdTanBMV1NkY3h0dCtDdzRKUHI3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ee2b53-7b25-40b6-88b4-08de7a7cd34c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 06:02:47.6144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08k/wSMmIdLO62tgbsF/j9p00pWDQFo7iXA+1QxNwOUFttMX2WHTi0QwKLnWqk45
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7679
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



On 04-Mar-26 8:43 PM, Alex Deucher wrote:
> Plumb in support for disabling kernel queues and make it
> the default.  For testing, kernel queues can be re-enabled
> by setting amdgpu.user_queue=0
> 
> v2: integrate feedback from Lijo
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

A couple of minor comments below unrelated to this patch -

Acked-by: Lijo Lazar <lijo.lazar@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 90 ++++++++++++++++++++------
>   1 file changed, 71 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index a0ec38f35c449..c5caed86f1ac9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>   		break;
>   	}
>   
> -	/* recalculate compute rings to use based on hardware configuration */
> -	num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
> -			     adev->gfx.mec.num_queue_per_pipe) / 2;
> -	adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
> -					  num_compute_rings);
> +	if (adev->gfx.num_compute_rings) {
> +		/* recalculate compute rings to use based on hardware configuration */
> +		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
> +				     adev->gfx.mec.num_queue_per_pipe) / 2;
> +		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
> +						  num_compute_rings);
> +	}

IP version is known during early init. Ideally, this calculation could 
be done in early_init itself, not required to be scattered across.

>   
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>   
> @@ -2794,6 +2796,33 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_device *adev,
>   	gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
>   }
>   
> +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *adev,
> +					      bool enable)
> +{
> +	unsigned int irq_type;
> +	int m, p, r;
> +
> +	if (adev->gfx.disable_kq) {
> +		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
> +			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
> +				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> +					+ (m * adev->gfx.mec.num_pipe_per_mec)
> +					+ p;
> +				if (enable)
> +					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				else
> +					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq,
> +							   irq_type);
> +				if (r)
> +					return r;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> @@ -2801,6 +2830,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>   	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +	gfx_v12_1_set_userq_eop_interrupts(adev, false);
>   
>   	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
>   	for (i = 0; i < num_xcc; i++) {
> @@ -2868,10 +2898,26 @@ static int gfx_v12_1_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +
> +	switch (amdgpu_user_queue) {
> +	case -1:
> +	default:
> +		adev->gfx.disable_kq = true;
> +		adev->gfx.disable_uq = true;
> +		break;
> +	case 0:
> +		adev->gfx.disable_kq = false;
> +		adev->gfx.disable_uq = true;
> +		break;
> +	}
> +
>   	adev->gfx.funcs = &gfx_v12_1_gfx_funcs;
>   
> -	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> -					  AMDGPU_MAX_COMPUTE_RINGS);
> +	if (adev->gfx.disable_kq)
> +		adev->gfx.num_compute_rings = 0;
> +	else
> +		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
> +						  AMDGPU_MAX_COMPUTE_RINGS);
>   
>   	gfx_v12_1_set_kiq_pm4_funcs(adev);
>   	gfx_v12_1_set_ring_funcs(adev);
> @@ -2898,6 +2944,10 @@ static int gfx_v12_1_late_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	r = gfx_v12_1_set_userq_eop_interrupts(adev, true);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
>   
> @@ -3715,21 +3765,23 @@ static void gfx_v12_1_handle_priv_fault(struct amdgpu_device *adev,
>   	if (xcc_id == -EINVAL)
>   		return;
>   
> -	switch (me_id) {
> -	case 1:
> -	case 2:
> -		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -			ring = &adev->gfx.compute_ring
> +	if (!adev->gfx.disable_kq) {
> +		switch (me_id) {
> +		case 1:
> +		case 2:
> +			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +				ring = &adev->gfx.compute_ring
>   					[i +
>   					 xcc_id * adev->gfx.num_compute_rings];
> -			if (ring->me == me_id && ring->pipe == pipe_id &&
> -			    ring->queue == queue_id)
> -				drm_sched_fault(&ring->sched);
> +				if (ring->me == me_id && ring->pipe == pipe_id &&
> +				    ring->queue == queue_id)
> +					drm_sched_fault(&ring->sched);
> +			}
> +			break;
> +		default:
> +			BUG();

It's not required to crash the kernel.

Thanks,
Lijo
> +			break;
>   		}
> -		break;
> -	default:
> -		BUG();
> -		break;
>   	}
>   }
>   

