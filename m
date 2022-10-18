Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEC7C43217
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 19:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 969DF10EBA3;
	Tue, 18 Oct 2022 19:16:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F0810E935
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 19:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOiooRMBtPF53havOD7IZ7u2BcoERCF+ora6fLGk0NLV4EsDAblYL0SbHo7dF3IG9UnQPaKmdS0/qdv8dtAkFCU8PotTRxkb+mxAMGN9JtySjqQ+3eG1EkNFlC2m6VFJNezWY1+rdbmQ7xMHQsm4Ycoero2JUdoarZpOVRg02Duf2LK6a2UUStEAFbLY9+40O153MGJkBifdIKu+3E1LlP5z4E4jW2y+lcJzp9gNiNuVqwS5w0Rw/UZBz57atkG5Ob/MGCASCiHEG6dBwRkMjSVq/7aMgibI7qdsypLA3uCrJaxNLg6x8Qv5w0tmC2WqypbNs+i1F2zhg1VWUKISUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHnmXsjmLZBwbjiaUCzswLwyBME2tZko+YKTGAEPn8U=;
 b=gHSbJpH7nF6PBhoJZ5WeFFvkxxDMZWEhfNWPnF4LkZwuwRCbMSntP1C4bUPSbQ3OS2l98tTCaX31XgojORUZfqUlC4WR0Rrc7Z2S4NtsxU2DLZD0YFDRSJQBAd1IVP2XDfa05OE42+rmQi6//kP7L7dfFIN4sy48yig+CZ0s6kzGFldcJ6xsS2eESKTLKafLHn1qko/sPlpnI/n3CAS9WX4Qjcp3zTyUn1b7nEEhxvb+dcOIXDg5Gi9yQ0issry+OQe9G55lH1b72bBAN0HGy18X/jw02rVSWjXJdFVJhn1W2t9WgHnbm2Lq5dRgS/Iv9N2k2bKYzk4cu6fjV2awGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHnmXsjmLZBwbjiaUCzswLwyBME2tZko+YKTGAEPn8U=;
 b=jt9CI63wnKTC7oyzqxxSvVyT0JLPqN86yk/Ab2GOb9Hm49E9MnBeyAV1pI2pNIWe5bzZUF/M9OR1wULME6pQSZFWUoj36A/8drglqIQ9CuAZnmsiBgETzcr58CZBYkUQefjf4jgvKhuJdSBpBXVKVTQojCBeKBjUoehIvC7f0Fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Tue, 18 Oct
 2022 19:16:06 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 19:16:06 +0000
Message-ID: <6b30cfac-6dcb-2b7f-7455-04ba3c0b194f@amd.com>
Date: Tue, 18 Oct 2022 15:16:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 07/12] drm/amd/display: Add function for validate and
 update new stream
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
 <20221018122826.1790114-8-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221018122826.1790114-8-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ede130f-4a54-46f1-0ab1-08dab13d34ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yogEMSmNjSCOYfpiJwAPIkcLppeEJZFuN64rnigp+TQNtMQTtfUl/0L7g+HqCBZgVyFs14t2IcV8dpxjSzLsHN/jZEeGAw3cphgnI5GQIMbHQZNXm76ncpj0I0x3goMaGApriEuduqSkc7ejUgNyP3nnLmDdTdHCHjFcr+jHun29f16ISLJ/dGluoyvKUMHZFU1lkzE+upsjbR/GoUuRwfA99s5WsVmlDqNhayYEpCtQz2LhL86MaOLbeLR3HGpy3BaWSiGiCna+iulk2WEFJTjrUvsU5DFTPr6Vt9TlcDoDwbLKt7P3pxGRkPi/tfRrHXw/DPXOt4Pv1faHTu+B27c/WC+LP6JwEBbSYhNccdms7sRM/G7LQA4YCqBpFyNqz/znA4+acoy8FiCSUXa8AX91ZIUq+FtQwTB7p/CHS5eqpXQmgdS4jftifzsgj55IVDjv0lT+vH4Y+xD9xC5KsMx8U+qc+MTM2u8o9cuMIuIqalyWTB1KxygMllRjsXsY61EVfByTf/8K4qHzW38O549uJIRQ3LoAwdv6fbwc75IJ7On5fzild3X3o5hZzfzJsgNtAqNCYkAJLm4k8+WOhWOYA2KQ9GaAJ5NoIfbRHsUwW9Kd+ihqNZQE47uGYO9dgzgmlpVwMAln7LCLnybJ4prHqCOermLX7WVr33or3vOtFKMUVwjAPVtZaHQcyxGEig7tXpcq8fziWd+55yAJQHBI8Mz5GYimAJ3gQOv32Nc8kTCThhrmWvsBgVZrF6MCcOTZVvUI7kMq/PeOhN1J5rrX0dli85aGwRSLaQi4+I8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199015)(316002)(83380400001)(86362001)(31696002)(38100700002)(30864003)(44832011)(54906003)(2906002)(4001150100001)(66556008)(66946007)(4326008)(66476007)(8936002)(41300700001)(5660300002)(6486002)(6512007)(186003)(26005)(478600001)(2616005)(6506007)(53546011)(8676002)(15650500001)(36756003)(6666004)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlMweDRnSzBoMUlHd1FBNGpnN1cwaE1sM0oySHRkV3MzR3pYaVRjR1hWZHZO?=
 =?utf-8?B?NC9JSUVKR3c2SitKdkROWFJrcE5PaCtsVXphdzFtMlVhR1RVU2lmZGtyQWZl?=
 =?utf-8?B?cVBRL3lMOXdTeXBlT0hFNVJENVdOdU5QMUVaOWx4aUFQN0ZUcmlYYjJsRi9o?=
 =?utf-8?B?TmU5TlF0NXJtOTJFWTBpQVkvbFFsaVJ0UGUzdkZPT1BtSm1GOVBhaHNySUhZ?=
 =?utf-8?B?VEFxRkVFaEIxVzJlbmdEVjFNTi9xZGZWdnYvRSs2WVhWRUlnZzBQMGJOR0E2?=
 =?utf-8?B?dFBoZmFSTkp3NjR0Q1NEMDdDZXdKc0hXNCtPVXF3b2UwRHAvQjVwYldjWjRz?=
 =?utf-8?B?QmFOUUxBT2ZxaHVUSG9CNUF1VkhzdExKSitkSXNndjFVT3U3ZFlUa3NMYTk5?=
 =?utf-8?B?Q0RVOGpDbjQvT1RXVEZqSjJnMks4Rm1iaHZqcmtTMzNycDU2QzZXVEZscWZ0?=
 =?utf-8?B?b3Z4RzczUmhDN0FtSUk3OHRQYmdsVGFZOEZncDRMcmQwZzZ3U0ZKQzZhTkhr?=
 =?utf-8?B?Wm16RWFENUNqbC9HQVpKZnI4Q3Q0dTIwZEM2bG1yY2E5bWN1M2FYbEJOb01v?=
 =?utf-8?B?UFFoYkYrUVN3QndLVERGdm5ZOFdvaHNJN2QxaW1VUHFxVnJJcEljVjVKcXBp?=
 =?utf-8?B?aDNwTVRqYXJSaHVzQXpKcTlvZnpzQkVycFEvbDQzN2hhdGV4WTFzeVd1SFFQ?=
 =?utf-8?B?cmVEZ3RhRFpnMHJuQVB0QWFUQ2d4WXpxdmRiL1dxZlBHOHIwU1ZsUUJiL2ZX?=
 =?utf-8?B?MDdnaFhvejBXc3AzR3RJSlF2YVV2K3F2VmNseERnRkNjc21mbnplT1U1SkVI?=
 =?utf-8?B?Z3pYS3FYcTJ2QWhjWFU5dHp1NGI5K0RuZDdUbllLWFNxRkRFei9PbVFseG1l?=
 =?utf-8?B?UlhXWGUzck9HUlpQVlo3OFgyY25FSk9Na3IzdmM2WkRNaXV3bDE3L2did3VZ?=
 =?utf-8?B?Z2RTdWFnM1dsbm5FcTFGdkY0WW1GK1B3U054NWdsUzF3b2RGWkpsd0pyU3hN?=
 =?utf-8?B?eVRFSXV2bFAyb281UDB0UG5PWnNIOUR1VUtlSzBFQU5WNDh4OVlDRE9mUDVB?=
 =?utf-8?B?WW9xeE1LNVJldjltWVdiUFdSMEpKQ2lMTGo4VVhDQStndEhHTk5uSVc1UnhI?=
 =?utf-8?B?ME1YSkRUNG9mZXdMZ0lNY2J2Z2lPTEs2VDdiZi9PTjhPVHZOQUE5N3FTbTZN?=
 =?utf-8?B?T0NsWUU3SHdiR09LTzV3R09jUFpmNUtRY3ZnOHJaaWhCRDdMVmN2akZZb0JX?=
 =?utf-8?B?bHZzSFcwVGpPdzljeG9oYTVzaFV2WS9KSVF4V3NncVhjZTBtdmpOanlSK0sy?=
 =?utf-8?B?d2IyL2ZYVDJVNWJMNFA2Qk5JY0N0SUtvdHMrYkYzWkJEQWxXa3EzV1RLMkQ4?=
 =?utf-8?B?UFcyMTVFN2N0em50TE1hZ2x1L2x4cHJCbVVGR3UwR1lIejhhMzRVMlBKMDhz?=
 =?utf-8?B?UHAxMUFNcm5HTzVvQWFXZ3RWdlM3NW41RFNXZFdSdW5WTG5sN2JxNzQ5ZEdh?=
 =?utf-8?B?U2JRcWNMb1diTUVzL081eCtjUHNDUlRqcjhJQjVtYnM2Sy9HdHpyRTdBZk1R?=
 =?utf-8?B?cnk5UkN6R2FOMSt5RVQwMGpWYU1vRXd4Z3FWQUI1QkJ1QmpTUEJJODg1TEps?=
 =?utf-8?B?YkxHNWlvODF3cWpqckpoWXhhcjNNN1pzdHRGL3lJZllMMkZtSFNnZDd5U2d2?=
 =?utf-8?B?UGl5ZEhvdFdqT1RGaGdreXpjdGJ1U1FlMEhYdXRUQ0M1U2pKNEJ3SGtjMU1q?=
 =?utf-8?B?VXNnd1FSdTBRZ2hFd3Erb3I1aUFWSUxzN01kakV5VTR3ZkZTRTlhWk9CRGE0?=
 =?utf-8?B?ZDZNZ2dxWjBJeklXNGtueUc0LzV0WEw3QjEwWXBrYWlSd2NVQ0owSkE3NXpL?=
 =?utf-8?B?Rm9KeHZpeDhpZDJvZGRyQ2U2STVHeWtoMG5UZmsxTzZxTWZLRGdJY2l5NWNK?=
 =?utf-8?B?MDJFZzVibi9leW41aHErOVhoeGFISVdlRDcveE5kWFFKNWdGckxxc2lLY1J6?=
 =?utf-8?B?cE8veVZqVFVKcEsrMWQ2SHR6NndWbmpSd1c2RjFDL1djRjY5TTcrSjd3eE5j?=
 =?utf-8?B?ZTVrZENZcjR2WmdLUUN3emFGT1JFUmt0Y0JkQXZWQ2ZaY0U1WkV5bnFadHR6?=
 =?utf-8?Q?CRufcujC+zDxGOId+C99UB4hg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ede130f-4a54-46f1-0ab1-08dab13d34ce
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 19:16:06.5263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IDDHRb0iSukdy9llnN/vm3rkwXIj5I5nojvE8tOfQ9oRARPnqSLadnzXkQlPshyOxtmzlNSxQDu6HCYk/Hduw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-10-18 08:28, Rodrigo Siqueira wrote:
> DC stream can be seen as a representation of the DCN backend or the data
> struct that represents the center of the display pipeline. The front end
> (i.e., planes) is connected to the DC stream, and in its turn, streams
> are connected to the DC link. Due to this dynamic, DC must handle the
> following scenarios:
> 
> 1. A stream is removed;
> 2. A new stream is created;
> 3. An unchanged stream had some updates on its planes.
> 
> These combinations require that the new stream data struct become
> updated and has a valid global state. For handling multiple corner cases
> associated with stream operations, this commit introduces a function
> dedicated to manipulating stream changes and invokes the state
> validation function after that.
> 
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 219 +++++++++++++++++-
>  drivers/gpu/drm/amd/display/dc/dc.h           |   6 +
>  3 files changed, 227 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 61b574b9e736..d568387c4bda 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -1941,21 +1941,17 @@ enum dc_status dc_commit_streams(struct dc *dc,
>  
>  	dc_resource_state_copy_construct_current(dc, context);
>  
> -	/*
> -	 * Previous validation was perfomred with fast_validation = true and
> -	 * the full DML state required for hardware programming was skipped.
> -	 *
> -	 * Re-validate here to calculate these parameters / watermarks.
> -	 */
> -	res = dc_validate_global_state(dc, context, false);
> +	res = dc_validate_with_context(dc, set, stream_count, context, false);
>  	if (res != DC_OK) {
> -		DC_LOG_ERROR("DC commit global validation failure: %s (%d)",
> -			     dc_status_to_str(res), res);
> -		return res;
> +		BREAK_TO_DEBUGGER();
> +		goto fail;
>  	}
>  
>  	res = dc_commit_state_no_check(dc, context);
>  
> +fail:
> +	dc_release_state(context);
> +
>  context_alloc_fail:
>  
>  	DC_LOG_DC("%s Finished.\n", __func__);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index fd8db482e56f..e001b138b2ac 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -2593,15 +2593,226 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
>  	return dc->res_pool->res_cap->num_dsc > 0;
>  }
>  
> +static bool planes_changed_for_existing_stream(struct dc_state *context,
> +					       struct dc_stream_state *stream,
> +					       const struct dc_validation_set set[],
> +					       int set_count)
> +{
> +	int i, j;
> +	struct dc_stream_status *stream_status = NULL;
> +
> +	for (i = 0; i < context->stream_count; i++) {
> +		if (context->streams[i] == stream) {
> +			stream_status = &context->stream_status[i];
> +			break;
> +		}
> +	}
> +
> +	if (!stream_status)
> +		ASSERT(0);
> +
> +	for (i = 0; i < set_count; i++)
> +		if (set[i].stream == stream)
> +			break;
> +
> +	if (i == set_count)
> +		ASSERT(0);
> +
> +	if (set[i].plane_count != stream_status->plane_count)
> +		return true;
> +
> +	for (j = 0; j < set[i].plane_count; j++)
> +		if (set[i].plane_states[j] != stream_status->plane_states[j])
> +			return true;
> +
> +	return false;
> +}
> +
> +/**
> + * dc_validate_with_context - Validate and update the potential new stream in the context object
> + *
> + * @dc: Used to get the current state status
> + * @set: An array of dc_validation_set with all the current streams reference
> + * @set_count: Total of streams
> + * @context: New context
> + * @fast_validate: Enable or disable fast validation
> + *
> + * This function updates the potential new stream in the context object. It
> + * creates multiple lists for the add, remove, and unchanged streams. In
> + * particular, if the unchanged streams have a plane that changed, it is
> + * necessary to remove all planes from the unchanged streams. In summary, this
> + * function is responsible for validating the new context.
> + *
> + * Return:
> + * In case of success, return DC_OK (1), otherwise, return a DC error.
> + */
> +enum dc_status dc_validate_with_context(struct dc *dc,
> +					const struct dc_validation_set set[],
> +					int set_count,
> +					struct dc_state *context,
> +					bool fast_validate)
> +{
> +	struct dc_stream_state *unchanged_streams[MAX_PIPES] = { 0 };
> +	struct dc_stream_state *del_streams[MAX_PIPES] = { 0 };
> +	struct dc_stream_state *add_streams[MAX_PIPES] = { 0 };
> +	int old_stream_count = context->stream_count;
> +	enum dc_status res = DC_ERROR_UNEXPECTED;
> +	int unchanged_streams_count = 0;
> +	int del_streams_count = 0;
> +	int add_streams_count = 0;
> +	bool found = false;
> +	int i, j, k;
> +
> +	DC_LOGGER_INIT(dc->ctx->logger);
> +
> +	/* First build a list of streams to be remove from current context */
> +	for (i = 0; i < old_stream_count; i++) {
> +		struct dc_stream_state *stream = context->streams[i];
> +
> +		for (j = 0; j < set_count; j++) {
> +			if (stream == set[j].stream) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)
> +			del_streams[del_streams_count++] = stream;
> +
> +		found = false;
> +	}
> +
> +	/* Second, build a list of new streams */
> +	for (i = 0; i < set_count; i++) {
> +		struct dc_stream_state *stream = set[i].stream;
> +
> +		for (j = 0; j < old_stream_count; j++) {
> +			if (stream == context->streams[j]) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found)
> +			add_streams[add_streams_count++] = stream;
> +
> +		found = false;
> +	}
> +
> +	/* Build a list of unchanged streams which is necessary for handling
> +	 * planes change such as added, removed, and updated.
> +	 */
> +	for (i = 0; i < set_count; i++) {
> +		/* Check if stream is part of the delete list */
> +		for (j = 0; j < del_streams_count; j++) {
> +			if (set[i].stream == del_streams[j]) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			/* Check if stream is part of the add list */
> +			for (j = 0; j < add_streams_count; j++) {
> +				if (set[i].stream == add_streams[j]) {
> +					found = true;
> +					break;
> +				}
> +			}
> +		}
> +
> +		if (!found)
> +			unchanged_streams[unchanged_streams_count++] = set[i].stream;
> +
> +		found = false;
> +	}
> +
> +	/* Remove all planes for unchanged streams if planes changed */
> +	for (i = 0; i < unchanged_streams_count; i++) {
> +		if (planes_changed_for_existing_stream(context,
> +						       unchanged_streams[i],
> +						       set,
> +						       set_count)) {
> +			if (!dc_rem_all_planes_for_stream(dc,
> +							  unchanged_streams[i],
> +							  context)) {
> +				res = DC_FAIL_DETACH_SURFACES;
> +				goto fail;
> +			}
> +		}
> +	}
> +
> +	/* Remove all planes for removed streams and then remove the streams */
> +	for (i = 0; i < del_streams_count; i++) {
> +		/* Need to cpy the dwb data from the old stream in order to efc to work */
> +		if (del_streams[i]->num_wb_info > 0) {
> +			for (j = 0; j < add_streams_count; j++) {
> +				if (del_streams[i]->sink == add_streams[j]->sink) {
> +					add_streams[j]->num_wb_info = del_streams[i]->num_wb_info;
> +					for (k = 0; k < del_streams[i]->num_wb_info; k++)
> +						add_streams[j]->writeback_info[k] = del_streams[i]->writeback_info[k];
> +				}
> +			}
> +		}
> +
> +		if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
> +			res = DC_FAIL_DETACH_SURFACES;
> +			goto fail;
> +		}
> +
> +		res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
> +		if (res != DC_OK)
> +			goto fail;
> +	}
> +
> +	/* Add new streams and then add all planes for the new stream */
> +	for (i = 0; i < add_streams_count; i++) {
> +		calculate_phy_pix_clks(add_streams[i]);
> +		res = dc_add_stream_to_ctx(dc, context, add_streams[i]);
> +		if (res != DC_OK)
> +			goto fail;
> +
> +		if (!add_all_planes_for_stream(dc, add_streams[i], set, set_count, context)) {
> +			res = DC_FAIL_ATTACH_SURFACES;
> +			goto fail;
> +		}
> +	}
> +
> +	/* Add all planes for unchanged streams if planes changed */
> +	for (i = 0; i < unchanged_streams_count; i++) {
> +		if (planes_changed_for_existing_stream(context,
> +						       unchanged_streams[i],
> +						       set,
> +						       set_count)) {
> +			if (!add_all_planes_for_stream(dc, unchanged_streams[i], set, set_count, context)) {
> +				res = DC_FAIL_ATTACH_SURFACES;
> +				goto fail;
> +			}
> +		}
> +	}

amdgpu_dm_atomic_check also does a whole plane add/remove dance. I assume
that's needed for the validation call from atomic_check. I wonder how
much we're duplicating code there. I recommend we analyze this a bit as
duplicate code will lead to confusion and (eventually) to bugs.

Harry

> +
> +	res = dc_validate_global_state(dc, context, fast_validate);
> +
> +fail:
> +	if (res != DC_OK)
> +		DC_LOG_WARNING("%s:resource validation failed, dc_status:%d\n",
> +			       __func__,
> +			       res);
> +
> +	return res;
> +}
>  
>  /**
> - * dc_validate_global_state() - Determine if HW can support a given state
> - * Checks HW resource availability and bandwidth requirement.
> + * dc_validate_global_state() - Determine if hardware can support a given state
> + *
>   * @dc: dc struct for this driver
>   * @new_ctx: state to be validated
>   * @fast_validate: set to true if only yes/no to support matters
>   *
> - * Return: DC_OK if the result can be programmed.  Otherwise, an error code.
> + * Checks hardware resource availability and bandwidth requirement.
> + *
> + * Return:
> + * DC_OK if the result can be programmed. Otherwise, an error code.
>   */
>  enum dc_status dc_validate_global_state(
>  		struct dc *dc,
> @@ -3734,4 +3945,4 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
>  	}
>  
>  	return true;
> -}
> \ No newline at end of file
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index 2555623b07df..54d34017e329 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1297,6 +1297,12 @@ enum dc_status dc_validate_plane(struct dc *dc, const struct dc_plane_state *pla
>  
>  void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info);
>  
> +enum dc_status dc_validate_with_context(struct dc *dc,
> +					const struct dc_validation_set set[],
> +					int set_count,
> +					struct dc_state *context,
> +					bool fast_validate);
> +
>  bool dc_set_generic_gpio_for_stereo(bool enable,
>  		struct gpio_service *gpio_service);
>  

