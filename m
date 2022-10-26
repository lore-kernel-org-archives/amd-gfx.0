Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B5BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 16:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 067FA10E59D;
	Wed, 26 Oct 2022 16:12:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F7910E59D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 16:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP2VaODTasUzgwjW457enF+0UBo0Z7lhkOs6pXkJcQA9Du0XrATeCmaIvIE5qfKPqx9sWmLQKrrQ4nT2l7YhYtOY44dVLzswrmYecBC4Td8yKI3gaavlWAPFX0K9Gl0yn6wen5X/cc2tYSvNJwxFnK+TqUNW10Zp1hZQJYesOrKatUQFlh4tDAdaz1Fjdb/htW3bau0+9zuDZUCh+35IeDmoCXkrkzW05VV3QqTacYWxcIyiZJXs36r+w9tdbMQmDrPlgkcObFun/QCgLGUql5rcGvKDJP+bOH8nuouzlNDoVczdYG/fV/Z28bW/75Zyc+pQpo2PkOPrq3YW1qAJYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PIkC4TKuXvPueXpdXjWEH2xEDLSgtsxNAOdF58TnYA=;
 b=B7ida7gLIonn86j+LAFeJiPYuUkCepcL6M3QYKvBm+qOyOiPmbXTEVcjhBJ8R5wFWK5lc87O4FwzrnNzUNmd0YBUOTH3gTGdqVGJkyiStVq6jxpEAWUdI5DIRa91tQZubJKTXmEYWU58BsNSXgjPj+BKbZHH/UmlgMphXto6suxHX2GlgmG7NClwryIEOYAbRMtPMlp7ymkgR5YK5RSRp10WeWDBVe/xUC1dAHCbq9Mqfi0UheDAybvX6vNZqAM40EFcKHewSxkkeOx0YOk/MtKV/3Ps6z1KH7uNVDRbeZQhHq+rdilsn9kdewYfs6jwXv2dhxZaFD1LvWMr+4957g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PIkC4TKuXvPueXpdXjWEH2xEDLSgtsxNAOdF58TnYA=;
 b=SC4MJl0slof4UzrgbiLusO9wMV1j9U3s5r3UgKWWsxS1OtWcFSXV81OYD/SupcHeZ7fBxanrhuG4y3JOV+9GGr5k1YT6P9G2D0wB9yzOlAcwGe3y8s27UNMKFtsC4SNz+CY17HztppXE4TnjCHvOpCxnnpdc/eXz6mwxW41F1xs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 16:12:11 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5746.028; Wed, 26 Oct 2022
 16:12:09 +0000
Message-ID: <d9de68d8-1c9e-7cef-cd82-ad0a6de59817@amd.com>
Date: Wed, 26 Oct 2022 12:12:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 2/2] drm/amd/display: move remaining FPU code to dml
 folder
To: Ao Zhong <hacc1225@gmail.com>
References: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
 <20221026111258.25000-2-hacc1225@gmail.com>
Content-Language: en-US
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221026111258.25000-2-hacc1225@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:610:b0::31) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 18be4295-b90b-4821-b246-08dab76cd588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: johqP5ODKapztB0p6YHi14XArej/VSFSJecNQP9Pl60ggJr7S0fsPqVqPMjQJizF+P4tSO3WUCAg1z9Oph7Rz28epBRYUIWLfZbqpLnQAlsRhbrUh4j5GPoYK3k1PKoL7yUXVwnqcR293Orj+GkSHOK7Hbz/J+oIay478SMDUAF9go/6dRHGHHAPTca/qkig1bGOG48uaObPqDIKXnOed9Sx/aH29KwdSr2tFX7gY2Y1ta97eZDoS4k4iQPtoExcPo7cOfXfFLBWAWFZjwpMJh2uOgIEAAcxZCq569lYO5W2xQb8AOTfzwaXwR2d8PPQYoasFBG9l7V9hwtYE67EKbEBix2rhJLFfTpzIJV9VxBZoiPFFJDi51EsLFkPnuEJv34gLG5ATF+oenmkE48qVBTthpz5eGBzY+z+/fLGArsj7XNQsounsk7LZvNMYWxlsgqUwyMu+9YyUMYG4Zf+huFCupNJq4KEhwimd1Uw/1+FbeKbV3cM9MdhJcOD+y+D+CD2gFQQGIgcNI0wSC6ovGKAclboBTu4R/WHwYm9giQWWb6h88IYXe8CJkrPyDfKjI9lScOdR0gsLnnnTEmJQylZD9Dr9nCEPPRCZPEc2ye8fWxt9ySoAzIUUy1+Gn7eH9XSA0wThNHVEkaWTmO/wPFTGKc/HPZeIEKMj8z0Q+8j6po2K6IOvSN4xJwDsXXdGpaWU/NGY7p4MBykMWpgTF9VJW/Qfhtuf86/vQKcF7FfxFZvS2taAb1VR8zzDkoA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(478600001)(36756003)(31686004)(6512007)(66556008)(66476007)(38100700002)(66946007)(8936002)(5660300002)(66574015)(83380400001)(86362001)(6916009)(54906003)(41300700001)(2616005)(966005)(2906002)(186003)(316002)(31696002)(53546011)(6486002)(4326008)(8676002)(6666004)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eklEM3NVdXNHcDQyeHN4U2l3aVgxMTFaWWtmMVVmNzVKOGVFd2dZd29wMG9v?=
 =?utf-8?B?Q21JKy83eUFCb3J5Y2FpUFhXZkNVMVE0L3dhaHdiaFJ2Q2wwdCtiZFpHYTA1?=
 =?utf-8?B?Ukx0cFROUXhlVWs5b0xkRGk0dmxxclpUOFRldElPR3lYb1NvMW80MFJSdEtR?=
 =?utf-8?B?dmhDL1l1V0owb2lSbDdQeWNMeWFTdHkrZkJBKzVDZUZPZm5HWXlqZmRMSEdS?=
 =?utf-8?B?aW4rTWdWc1BmdTN3REZuVUtIMXJEdVpQa0txMURKcFlKSnlBM2w3L3A2OUs2?=
 =?utf-8?B?Z0tJK3NKT0ZsRnBBdHl0b214bHdqSTVBRkNSbitlTjFNNm15RUFueWIrY3Aw?=
 =?utf-8?B?dFQwZ3BnTmpoNDR4ZC82bWlwYkpQQWtONlBZQ0Rkc0NYbjJiNlNiUlI5b2RK?=
 =?utf-8?B?SGM1TFYrdWpVbkpRVUxiL2wrd2VGTlBTKzgvVENrbko1emJyRGFkc3pEaGVh?=
 =?utf-8?B?K1RSQjY3bWhiNWtaa0p4bmorNHd2bndFbjA2MXdHMlF3amtRYXlOZkNwNHMz?=
 =?utf-8?B?YnllRXZZTENhYTIrak9sSnUzOWlLQlhoTkx6K0dSUlZadVNBNk5FR3dXc2o4?=
 =?utf-8?B?a3JpVi9qMVBMV0taNGlpeEJYeThLNHJzTzE4WWtkUWtEUTlZSXFobUMrNWIr?=
 =?utf-8?B?LzFOdVZhc09IeWZGQ2pra29RRHBNVThqVW90QWh1d1dTd0xnY2Q4RlVVaVhp?=
 =?utf-8?B?M2ZWQ1RlOXVYZjAxWlFCMUp3cVhFRHVUYk1lN2NPb1dyUlZGSVl2bEJ4TDBT?=
 =?utf-8?B?aThDUHhZTTNvWXJQQ2IycTBIRGlNZnVFTng0TmVKTDJGNnFPUXFmcFJsODli?=
 =?utf-8?B?TzlyV2M0M3htOUlqa2Fia1JoNFZ2U3JRUEYySjhSYmxuRDJPM25kU1Vka0dP?=
 =?utf-8?B?NWRIMlhMd3drdk16eUVXRU1Yc0IwSWFRNUFLUU1RWG14UjZkZ0VUd00veGJK?=
 =?utf-8?B?UW1pQ2VQQjdOMjR2eUNPUFNvellkdWNld1VRd1YxSmRFb1RHMUsyZWpDUTFJ?=
 =?utf-8?B?TVB3L3F4RHh3b1JkUTFOQWtKaE5yNHNnc2ZNUUdVNzJtdG9QMi93RG5FeFFJ?=
 =?utf-8?B?RnNvQWdLNXJ3WGF0QVpQR3NSblJ1Q01Oay9GZGpiNXkzR1QwSnZ3WFFNNC9X?=
 =?utf-8?B?SUFlZDdWeEx2bTNtQlNvckpRUjRlTE5kMzVKNndYakVRSXNKbFlhZW4yWEp2?=
 =?utf-8?B?Uy92U1FQN0ZLeVcxNGJVb1IrbXR0MGNzSUMxR2lXbVB2Y01seEFOM3VIQzIw?=
 =?utf-8?B?cHlNTGFUK25zRC9XK3dDU0p1WGtNcE5UdTdmazZlc0ZKdDkzb0tCbG1hOVhq?=
 =?utf-8?B?RXlUSGlxR3lFUERxczU4TUJDUjI4VFJTNE9HeGltSjV4N2NLWlF6WVJad0s2?=
 =?utf-8?B?dGJROUQrM3pQRXdIR0pjZk1nOFE3UGlERlFxNmUvMy90VkhBcEpNREkrYjRt?=
 =?utf-8?B?RC9HTGg3cWdwMHJpbDh1d092NzU3N0l4S3dqS0Z5ZHZxVDJHbjd4SHNsbWdZ?=
 =?utf-8?B?TkZTbDloNG5tMEN5cjBRME9LazVtV2M1ZmljWHhPekhkelhoYXF3SFk4N0xx?=
 =?utf-8?B?RVZUVVdvdjNEdW1FbDUyeUY0YmkvZDBIY2N1QVBWR2gybk9rU0JNWHVpOEt2?=
 =?utf-8?B?S3U3ZFRTaDc4ZnVFdUpXNFhFa0I1QTJhM3JwZHFRS3N0emRaNVJmQ1RPbmN1?=
 =?utf-8?B?SVU2VzN0VEZjeWgrVmlCUU5STnBBSi81QzJ5U1NKTTE5OGc2LzJIQ1FObkhJ?=
 =?utf-8?B?a3RQZ05PSDdGQ2lXUm53TE1mem9HWXBQbWZpYm5EWkMwQmwrc2ZIMjhyT2Jq?=
 =?utf-8?B?c3lmTHg3T0EvcFBkRWZhZXpaa2JDcmNWbFhKRTlqQlJwd0NOUmdRNno0bDhR?=
 =?utf-8?B?MWdYN3pGMXpldnF5SXFPNHBiK1I0SGdBb2ZBNldMQ2dvNjBkNXg2U2ZIQ1pn?=
 =?utf-8?B?ZFVEYVB6dytoTUxmZ0xKeE1COTVNWVFRMVRTdkVoYXZkYXlFY3RERWh4a0FS?=
 =?utf-8?B?aHpVTE9TeXRPZHFobXRoUExpYVNLcW1oajdPL1k1WDVoR3RIb1lGVEVyT3I5?=
 =?utf-8?B?R1YrREpUOElxVlpVVitzaDh1ajdVSU5NUEZCVTRuYkptbVErMFNBakV3aVor?=
 =?utf-8?B?dVBGMnhDVVZEUk5SMW92cDlUbW1QRzdKMzFpS3plckh6eTk4Z05tbkZqL2gr?=
 =?utf-8?B?Z3c9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18be4295-b90b-4821-b246-08dab76cd588
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 16:12:09.4921 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Kfobmjb0MxdqrQVG0gWUrR+gc+E3s/LXmHxW6Xdcd40UoAZSI3S+ncY40gqbIV0GHuxdtpE2gcs7uIpfghQmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/26/22 07:13, Ao Zhong wrote:
> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
> these two operations in dcn32/dcn32_resource.c still need to use FPU,
> This will cause compilation to fail on ARM64 platforms because
> -mgeneral-regs-only is enabled by default to disable the hardware FPU.
> Therefore, imitate the dcn31_zero_pipe_dcc_fraction function in
> dml/dcn31/dcn31_fpu.c, declare the dcn32_zero_pipe_dcc_fraction function
> in dcn32_fpu.c, and move above two operations into this function.
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 5 +++--
>   drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 8 ++++++++
>   drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  | 3 +++
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index a88dd7b3d1c1..287b7fa9bf41 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
>   		timing = &pipe->stream->timing;
>   
>   		pipes[pipe_cnt].pipe.src.gpuvm = true;
> -		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
> -		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
> +		DC_FP_START();
> +		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
> +		DC_FP_END();
>   		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
>   		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
>   		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 819de0f11012..58772fce6437 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
>   	}
>   }
>   
> +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
> +				  int pipe_cnt)
> +{
> +	dc_assert_fp_enabled();
> +
> +	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
> +	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> index 3a3dc2ce4c73..ab010e7e840b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> @@ -73,4 +73,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
>   
>   void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
>   
> +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
> +				  int pipe_cnt);
> +
>   #endif

Hi Ao,

First of all, thanks a lot for your patchset.

For both patches:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

And I also applied them to amd-staging-drm-next.

Btw, if you are using git-send-email for sending patches, I recommend 
the following options:

git send-email --annotate --cover-letter --thread --no-chain-reply-to 
--to="EMAILS" --cc="mailing@list.com" <SHA>

Always add a cover letter, it makes it easier to follow the patchset, 
and you can also describe each change in the cover letter.

When you send that other patch enabling ARM64, please add as many 
details as possible in the cover letter. Keep in mind that we have been 
working for isolating those FPU codes in a way that we do not regress 
any of our ASICs, which means that every change was well-tested on 
multiple devices. Anyway, maybe you can refer to this cover letter to 
write down the commit message:

https://patchwork.freedesktop.org/series/93042/

Finally, do you have a use case for this change? I mean, ARM64 + AMD dGPU.

Thanks again!
Siqueira

