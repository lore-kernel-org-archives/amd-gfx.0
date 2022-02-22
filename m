Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9AAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 17:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B1D10EBE0;
	Tue, 22 Feb 2022 17:28:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9DE10EBDF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 17:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJPieUHTQwEwfBDl7HealW+cdtyox5ETPXiBZ4YZGGz9ivW9f+x3aoVxBkKowqoLTWx3TeIsoWQSJM3RY4b12RZrHA5irduRByTm66HUwy3YqDYMdL9ypRR91lukBQ6MPzdp150Y9pxadAS7cNMvULVikT61LlatuBe2Q8/WouVh5i+M3MJZmBlGrYdi7GR1EwOi4XhncoQqBetFkQTV0GElfkFUejqeu8VyponGk8CCc2uxFc9SutXVW+aW4BMYfWWfkhAjjjpKju2zIIhavbCpdgxWcuZ/Q1Qy3009wvLJPq7/8vrV+8PX3Xyzn8wi5J4L4zE8qg/qZPRaP8n7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC1VWXXCMl/sJZWu49YqGSqMwtNInxuRe8XesJ9t2HM=;
 b=cU0TOrl65uYOE2/mMwDWcS4BjxzwOVcEOQV2u8mo5NyWCN6p98nrmu4R4Ui94vDiwNBAXjOO+uUFypOKrqf/8bQ4LuzBP4TnTTwRFEtacIRss81RDsYzGC4xySGUhQEEbxRx8Eza9LChJgqDg2ZhE92cvwRo5owkK6RwLHN/hQ0aiEM5xJf32qDQVJsCgGQ6ZOEqaSTU7jgguujyVjtTv8oK4/4my+Txi2fMm+5srjPkocjFRbfUiqMmwhMjT6OaUg/p4B2f5zkHThUxJdPNQAl+so22DVs4dCgXx5GRlffacg6CdldklcGkDNKnObOxjOWxs6alYxBCbmTjENPl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC1VWXXCMl/sJZWu49YqGSqMwtNInxuRe8XesJ9t2HM=;
 b=GmpFuxirxTk4hFIiFTaUG+vt3om2SIjWFklbDy5PoAsURgBwQZiKrP6cHsEAItyj0FMRbsO2HrXMG+fLEY/NsEDJZjN1m1iv8aH1VTKMIvOiBE4olhBetKsvsYLFPZXlZSDUIuMrgChjUfGdRqiZ3IYuaGeYBzUokBZi1E9j6XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 17:28:50 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 17:28:50 +0000
Message-ID: <b608a68f-1f64-5c4c-32f9-38cfadf63620@amd.com>
Date: Tue, 22 Feb 2022 12:28:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 2/2] drm/amdgpu: add reset register dump trace on GPU
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220222143742.2575-1-Amaranath.Somalapuram@amd.com>
 <20220222143742.2575-2-Amaranath.Somalapuram@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220222143742.2575-2-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 203735a1-5fbb-4699-189e-08d9f628c9fc
X-MS-TrafficTypeDiagnostic: MW3PR12MB4411:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4411793AC941797890CD46F7EA3B9@MW3PR12MB4411.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwlzsRUane+G3R0gCJS+Nx9X6+75lHkwgAgh9Cq35xHpx4aiq2ox1+e8oZvZUSlIqe9+zFw2dkyswOUGYmyVRLOnCzgPEpUwitJtVbSlBZl/VNra/a+vT459vZkSi8VVvAlI/osYq1b4vArtZEBFWZCqHvEm9jaCGqLhOi2iQBt5XxVHOqEuPJunLlwX4/9G3Cv5tv1CysFlzDjsa6Mjt+pX9WQkAgBgBqVagebqnliH26Y2Nmc9ws/0p28LCUl3VxHQK9QFW8RWtZORfW+5lzz8wd1emfwxgXURmI1JU2Z+960fmmFMPNSaTBCYiiNl13iUkusmnhB/IYiH55gf/RzgrfLNovAryubqgh8CNA52lYQAPKTp/XJcIu/idU1uhiSYRuqlEHn76Ucolp6NT/8awQU4x9kAYvFsXQAyY/GQ/bTE0SVidEfeRkkXKHa5yMROug5fmT5oPlDCvGecS21JuARCVrgPvQWZGZCLsHnpewKdjBRu52NeFvLsxzfV4x3a5/7Y9rzCEv4tsa1SZznUNIUA6eYAZuKQXJxaf0ZVC06UgfTNNfyyBvucjsj+4QNkr1VQbnY9eKlPkqXITblG7OJKz1fFW20PbnrfS7m430MBO9QWQLsgJYEc5XnGcCxuUkSc/jVK3peGT/rPcO38CvKoFdfcxnHXgn36cmGxEiuXwuuturLVzTE01dlscaHvCzO8VBqT6xrCuft+OeaM7vTrnfa/lYK/0eZ2n/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(6666004)(316002)(31686004)(8936002)(53546011)(508600001)(6506007)(36756003)(6486002)(6512007)(83380400001)(66476007)(86362001)(66556008)(8676002)(186003)(31696002)(66946007)(38100700002)(44832011)(4326008)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clZqbU52UkRvdWxsQWVUb2h1aTZMMHgwcUFTWTdKZDBlVlhTUHNSa1lSS2x3?=
 =?utf-8?B?QWlRV0dScis4azNnTFpZOTJhTUpDbkgvNjZwZ2xkZm10dWVsVGUxaDFtQVpD?=
 =?utf-8?B?RGZuWFlnN3Jrak9ScG50UEhLWHFhbUtUN2hXTzZHdEdmY1dDV1hZQ0lvRkc3?=
 =?utf-8?B?cGZjTThxQkZhTVY0UjJMeUtaT3FYZFNzMXJLL2xnUStmRDRlMnAxaUFsMU0x?=
 =?utf-8?B?SHVJbU96QWEvMnBEY0NpWlp5NmpBdUI5RTBWRjhGZ2MwbmM2bTdKSC84cDMw?=
 =?utf-8?B?UzNrN29rUE1WR1BIa2oycWpDOFQ4dnlGb0xDenZrY2RjZzhhdnBjaWZBRnVX?=
 =?utf-8?B?aDY2MUxWSmNscW9FT2VjM2hhMXhpcnRnelFkeTBMTFBXRFpkZFBZdHY4WEYv?=
 =?utf-8?B?NXpFUHVield1MFJIOXdkV3p0OENmT1V5SW1kVzMzc3V4WmJKQ1U0MVp1d2NM?=
 =?utf-8?B?Q2NnQk5jMGo4dnpnSS8yMkhpWHVTc1BWbXNzVGNEbHBFd3NEUWZnNTFlRW8w?=
 =?utf-8?B?K2pha1JEbWt0cjBmVlVjVXliVytXWDVlZTdpTXJBSzVnREoveVNKWVFoQlBO?=
 =?utf-8?B?QTYvMzR5SE52ZjNqM1czOWRleTc5Y0tLMjZ0QTllc0VyaUtWZUJUVzJLZWJr?=
 =?utf-8?B?WTg2NUlEdDV3R3Y3cUxHRFlGUlBDSGFodFR3QVZNc241eEEraFZJVk9wWVMy?=
 =?utf-8?B?cjBjRmdGNEdhaGdzV3BXN0FackoxMzBvSmVMRHBic0FEOURUS0swOTlud2Y4?=
 =?utf-8?B?WFc2alAyanJoMkxzbWNXRytLeDhNVVRDZ3A0NjM1VFFrQlZ5QTJIK0dyUzI1?=
 =?utf-8?B?aWxRejRDOHJyQ0xXVXZ5Z3pzckdhblFBZDFRNXFkT3JsK28rWE1jU1hURmFS?=
 =?utf-8?B?SkhFTlNTeFNEaWh5cEdHUWVTSm5DU0ZpV2cvelRTT01qeEhkZUVvUkl2ckxh?=
 =?utf-8?B?cmFUZ3NUcWN6Tzg4My8vSmVacldVVjBRa090SGkwN1Z5MFM5M3RDRnp3U0pF?=
 =?utf-8?B?ZjBKRlJrZVptak4vUEVmK1VrTUlDcFpvaDJwQkc5NkJQanduV3RJTFZqTmQy?=
 =?utf-8?B?K2ZaemREV2dFVUowRzEzZ1hBM25zRjRib2E1QVpTeW02cjhvdVI1ZDRtUVRM?=
 =?utf-8?B?d2o3dGxISms2bGsyWER4L3dwQlo2SHNCbWxCTHkzTno5R04ySXhEbFBIK28z?=
 =?utf-8?B?dDBJa1Fwa0VOcHN1a1FpK0xVSFZvbTRtZHIxRmtySmpNNmE5a2RxZ3BTMi8w?=
 =?utf-8?B?M3FKbHBETE1wbTVDQ3hEMGNWdCtCallhNFNHS3o0eWJ4eGwzNEZybFlxanFX?=
 =?utf-8?B?ZDlnU3VDRytod1hYTTF0aGxHMFJaRGRUejU3c2pQS1lxdmNkK1oyL0NZbE1H?=
 =?utf-8?B?ZlZseWtsZ0thbHdPdVAzdEtqTlhIUndnR3AwclZzWndqUlFQdFRoaURSNm1h?=
 =?utf-8?B?SitZR0U1MktRNWRwdEs1VGRWTkZ2TXoyVTJHb3FHTnFWQlo3RVRxQ2RUZ2hG?=
 =?utf-8?B?aTdjQy9xV2xXQldHYXNZSnhOeFFmdU1qOHZlTEg3QzNQZS9QMDZWRGpEQkVy?=
 =?utf-8?B?aGN3em5tRi9TVWVMOFo2eW1rdDRrNHJiU2RtemhjRTBONkJ3UVU5THFhT0Jy?=
 =?utf-8?B?dEp3SktLN1FjYWlPZm1OczJrbjV2SThsRlJLN3dGbVhJNGRSTVc3c2MzZFRI?=
 =?utf-8?B?cWdzQ2ZNVDlEOENpamhJWGVUR2EvY2REYjBmemJxQjhGSzNwN3gzekcxck04?=
 =?utf-8?B?aUxkeHF3U2QvM1U5T0VIK3lxaG1MWnhacExWS1lhOG90b1lBakExWkNGRG9i?=
 =?utf-8?B?SkFkRUZTdjhSS0VKMExHdXNRbjNJL2RNOHFuWG1mTlBlRmRNRFB3UTB5ZmFB?=
 =?utf-8?B?V2lFbDlUeVJuYlpXbGZ4aHlFKzVXRVRBd2RCdzlvZkpoL0poa2R1MHB6b1Q2?=
 =?utf-8?B?MnZZTmZYMzdyQUJRUjUxak9hT20rNERGamFuVmJkUWlZMlFpa3ozTGhhUHoy?=
 =?utf-8?B?WndWSnBWYUpvQzQrWG5GcVRFWEtWL0JaTkUzNVVQSHhmam5NN3V2U2FVc2Rr?=
 =?utf-8?B?TEg2anIxNHRlWkVwRDhtYmxPUkR1aTNWMHhsYnNxNmVWd0RRek40RXFVdTJS?=
 =?utf-8?B?S3Zjc1pOMmo1N1F6c3lYclNaMmdveWNUN3VRZ2tyZCtLbzRJM1ltUXFpekVS?=
 =?utf-8?B?RzFmajFTZ2xPYmF4SzFXbXR0b2RmTEhaTXBaelV3OFg5QzhKZzE2akhueVRn?=
 =?utf-8?Q?tUsJr2BDDCQNub4H5q7AoLiih2na5HQ26UfC5t0Q6o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203735a1-5fbb-4699-189e-08d9f628c9fc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:28:49.9689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uU5H/+w2ieWaMyvKijryv7VAugZP18SEeMsRpfqjtsNPjofbMGtdm32mlB7rMBtZcDvZD5hUCgJJdYhDt86YXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-02-22 09:37, Somalapuram Amaranath wrote:
> Dump the list of register values to trace event on GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
>   2 files changed, 33 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e651b959141..7c48fd716adb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4534,6 +4534,22 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> +{
> +	uint32_t reg_value;
> +	int i;
> +
> +	lockdep_assert_held(&adev->reset_sem);
> +	dump_stack();
> +
> +	for (i = 0; i < adev->num_regs; i++) {
> +		reg_value = RREG32(adev->reset_dump_reg_list[i]);
> +		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
> +	}
> +
> +	return 0;
> +}
> +
>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   			 struct amdgpu_reset_context *reset_context)
>   {
> @@ -4544,6 +4560,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   	/* Try reset handler method first */
>   	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>   				    reset_list);
> +	amdgpu_reset_reg_dumps(tmp_adev);
>   	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>   	/* If reset handler not implemented, continue; otherwise return */
>   	if (r == -ENOSYS)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d855cb53c7e0..b9637925e85c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>   		      __entry->seqno)
>   );
>   
> +TRACE_EVENT(amdgpu_reset_reg_dumps,
> +	    TP_PROTO(uint32_t address, uint32_t value),
> +	    TP_ARGS(address, value),
> +	    TP_STRUCT__entry(
> +			     __field(uint32_t, address)
> +			     __field(uint32_t, value)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->address = address;
> +			   __entry->value = value;
> +			   ),
> +	    TP_printk("amdgpu register dump 0x%x: 0x%x",
> +		      __entry->address,
> +		      __entry->value)
> +);
> +
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   
