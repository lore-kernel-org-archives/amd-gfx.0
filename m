Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED074C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 15:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF1310E239;
	Fri, 11 Mar 2022 15:41:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 516E610E1F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 15:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfQc9fXqCrkbTa5O719bNB99+ebDWhh9B+XzaiSi1P6os0qq/RqfgciZo0DVLLVkHvg/Bgvy5F2QPNq0T7/O9u9Lr0hkI9e0P5anQfcsylOkjfSweRKMTqj7KZ5uN9bIkxlnduyPRV1GJeMmG0oJgzOqDD7ZMDdQ/0MmlatiPMhiv8NpZixVbaDjIRzkrfE75mV+wi4zNlhe7FfGxIRBu41gbec7gemjGzJTvs68HbRb2XkpBO1oeg8VE5fxZWJ44WaEtS6+ntI0yxeZvmHtQ6vLiLZBapUws8mF8ydIyJutguHIpo+R/fMTcaFz5iTr9VRdyMDfn4dQq7zWsxeC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgJu0hDvibmFreme8N8NpOr5H9az7fPNimkR5pz/mmA=;
 b=e1IY3SCX0yWr6V12lUk4eaTAb3Qwcgk8xSoD8b+916I30wj2GUbKnv7dCxKywApXj4ytnbc6D5C3rpToFG8GVprLKIZnqGsEI2jbNu2UWwQcdHvj83bhK8+363TVv8y2fQbQjseaHZK8w5H1nPqv68bSB3cENCU1P/b+TApalHyANi/5LUKLq0hor5LSbVTh1jdsZBlcs6rHFgBKhONwIuzSyArpasRD5d1Y68RFymador+SZa6RoAFaBWNJUpRbll/dSmUeOkpKmUH8OOskr52lCZ7twSchPp85jqVzjGW4gnx6fgBlm33sBT51IM3dXqYJDSFnrngXCDqUHGiqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgJu0hDvibmFreme8N8NpOr5H9az7fPNimkR5pz/mmA=;
 b=oF8S8CTD/shyGXklZpcqkFC4UmEi/ceAg1tFe5auHSzNyH9e/kUVWrvdSsN9i5o4UmcXPjLPim3JOBzoxT4i8qTfY93oi5jrGB6wYlK/YYbq8KGhcjVES5/mFLDa7rj8FM0bEgKLgs0Ulj6hip0txiGybNHOGg6BZG+Wl2EEysg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 15:41:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%5]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 15:41:15 +0000
Message-ID: <0b094720-8c17-db60-bccf-7cdb4ecf6dee@amd.com>
Date: Fri, 11 Mar 2022 10:41:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] amd/display: set backlight only if required
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Bhawanpreet.Lakha@amd.com
References: <20220311153320.101332-1-shirish.s@amd.com>
From: Harry Wentland <hwentlan@amd.com>
In-Reply-To: <20220311153320.101332-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b2c0950-e7b2-47bf-7ebb-08da0375937c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB45101C11CE419332B7CE48908C0C9@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmLdqF1TMJTBz6kzwNRltlnnlZgIUlfK372+Im8+oyP5RiIzPW3QbC0o2ETxSkdhnx+xBYX/AFzbsFyPZPipbYSl/nNRopuFNkKFkBZCZDLKemIpyhDCYNV5EEXmdg51GKFAQZnUgb+bX45okM227TxRmDIly477EvGT04wj6NN1Q8znqsx1S4lJL7J4QAdrAw6YoOAG2f44RUmWqUJtgQRf4JzL84PssEIk0QOtL6NbT9P/xp9g/FlhS/V49k1ZwQy/3WlYU6nkamnd6tTOYNDDz1gvg7NoL+1rFr1LO9Fq0HviICT+ubpDm5aNmojHEtotprgjIbEjVW7gi+zZPFRRqpEq+EEVfCuKBVv3usimnMJlK3nkL9FjPZfdzEvZjCVb0DrpuG0CWRpWt28ZfZ8R3XXHxyAYEvK+M4sFrlkO94uGWyMmdB2US8p5twL2pU4a/Cr4ub17y6jbnug1HhEKFUrH6pKUY/lPtByrJAV8kwED7pIQma8wafyhL8cMGOV+GFP5TO5tr1zFothR0ydeem+OUFEd75gRM4yNc/iaJ0EX4y71z/4eU4DVwXfE2BQ1t3MDSTRVWpTBgNbibBpMNRJrjTX4gvbHV4x7+HD0MI60Pwj8rhe2g8bAB2wovdV09HSrdBnYamC0Fb82DJZi27maIC3T6XSnGkUeLXzifCXz4ld0beqktEf2sV0aRFFtdyCPFkxTWjmcu/jvqlqz7I4YoIYJRScZrFcxYmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(31696002)(6512007)(53546011)(6636002)(6506007)(83380400001)(508600001)(2906002)(31686004)(38100700002)(110136005)(316002)(8936002)(186003)(26005)(2616005)(6486002)(6666004)(66556008)(8676002)(66476007)(4326008)(66946007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhEeTlyN2pkNlRpRC9RUXpNODBKcTREcUJwNVppL3IxYXRjWVFrMVN3aGFD?=
 =?utf-8?B?Q0JnU3JOdHJwVkZHK2hYVVlrTE1pMWE1Y2NYcmdScFRicUxHVXF4YnRLRmNJ?=
 =?utf-8?B?bmlqTkhOZWVGd2JtM1U2QkJCWDhHNjQ1WkcrMFF4OE9FMjZIR1lYU2hnZ0Vx?=
 =?utf-8?B?Q2dGQXp6L0ZWR2tSb0lsaXppYU5vSGJ6RTdlTFh2THpZUUppZzdmbkduQ2dh?=
 =?utf-8?B?eXJwWnBHeTlrUFRiaTJlaGEwd0g4U3FQc2NyeENHR3F2VXg2VUdVZkx5dG9G?=
 =?utf-8?B?VDRvUzZ5Z3lrSGk3N1pTYk54c0FYUzRCd2FIVllUWUJkaTZqWktVL2syNFFw?=
 =?utf-8?B?bVozWFFNN04vOWttN0VuR0doREh0SkJoNnNiN1BkY0RJa091cGFpUGVnVGNI?=
 =?utf-8?B?MVV6dlJzMS9CWXlVWTNIMFlYaUtaTFZXdk11amd5NVg2Y1o0aUNWcUtVQ25U?=
 =?utf-8?B?bkVYQnZ4Vy9NVU9Vc0JJOUQ5UXpJUmpqN2lhS1JiQUowRzhhZjBpcEJUeHdr?=
 =?utf-8?B?VjU2VDF0MVlqUUlFZFlYV3RvMGdFS0ZCMS9ESzhhZnQyT3Z6SkxSUEdlUW5y?=
 =?utf-8?B?azdzQmszVVM5K1phZ05Wa1JHRCtrL3gwd3UzWGJrNGR0RDNuNGVuZlRLVUdh?=
 =?utf-8?B?Vk9PNWVNcTcyZ0pDdkNEdXRXOXpON2pHdFhydXplQnJMRTBvOTYxMFdwSFZ2?=
 =?utf-8?B?K25RbXB3TkV3QWZ3NjZKZnBCTnFsajF1MnNKdzlNSTloN0F1MFJpTGdzakU2?=
 =?utf-8?B?Z3dxd0VSNjRaMFR0bHQ5MU5BaGh1WVZYMVBWREZweFhjWGFXRENibXRLZ1Qz?=
 =?utf-8?B?b2I2RmJKZFpUVkVKT1dvU084TnMxVm1qSEhtZDJSTXZqWE9saUZuZkhnWUp1?=
 =?utf-8?B?bG94QTJVWlM1cnJPQXZoaS9adFU2b1d5Vy9RcVZPenI5S1JGanVqcVdDREhp?=
 =?utf-8?B?a1kzMWcyaXI1czlSd1NkZ0RWekpTY05HT1NUek5taEo4WWN3VG1oVnB3YmJ0?=
 =?utf-8?B?Z0prNWhHQlRuQjJ1MzNpcjhMblBobHdmSU9BaGVwTnRKVkcxT0RycU8vczUv?=
 =?utf-8?B?d0FqVWU5L1NPc0gwMWZud3UveXg1Q1cyNnpkMTRRVFBKZXJUV1dJOVFKR1J0?=
 =?utf-8?B?Z2c5akJ3ekxRMVhKQmRaUzFoSWdWKytnOHhwWXNURkpEWEdaTjh6VnNLYlFz?=
 =?utf-8?B?eUxqdEZXK0FBV3lEKzZZZnNtOE1aUmR5WmhMOFZySEg1ekQybm1yUldoYUZk?=
 =?utf-8?B?K0VsTjdKOHg3Um1tdjFSWVNTYkdEL1VydXhrUFczbjVhemdIMzNjbVp1THlp?=
 =?utf-8?B?eWJIOEZucWFCVGpzdzYxbmh2MDk3MlR6ZHVIRnpoTUxlc1ByRTdWcjJISXla?=
 =?utf-8?B?Z1BGYklVL0xvdm13clUyV1Y4cE9oRCtOaGZacHFLcm45bDlDVlpJd29xWFlq?=
 =?utf-8?B?dWNzaFpNd25kNVNPWVZaV1NVTFpXT0gvaXZjbVc4SjVKbFcwVGVRTGQwdS9H?=
 =?utf-8?B?VmZMd29TL2VFdTFiWVlEY1pZK2Z1MDVlSGdhQ1lBYVd3TFBZdE1UN2lRU3NY?=
 =?utf-8?B?aFIrUDFMV09GVGZKZm94aDdscC9CbVMxQ2VYNU1DNmd4dWxGMkVlTWRmV1FK?=
 =?utf-8?B?YytNcFJkNUVWMDY4SnJ5Q1prdk9PcDRuNkNqTHkrSDY2c05YTTNJY0J6U1NE?=
 =?utf-8?B?UHZUM2tqWWZKOVJFQThDYklqM2lGaG45WlZiSml6cmRFRnpRZ0I3WUZ6TExU?=
 =?utf-8?B?V3pHOUxlMHUyV1FMeW93aytFb0VZcjFyWGVDTjg4eTVWRTdiRHo0ck43VnZE?=
 =?utf-8?B?NlNZRUltc3lVUTZqOUxQcHd4c2JWRmdyUlVMZXIzd1F4RWIvc3VndDhHWlpl?=
 =?utf-8?B?SS9pQXJUSXkzWnExbFAzbWdlNVZJUkVKY0FMRnNNaWNJSFVWM2VscWR2U3Fs?=
 =?utf-8?B?d3pRSkNUNUc2SXNLa1FISjBiMnpGbDR6aS9XeXk0ZWtZRVJXZENrR01rZGlm?=
 =?utf-8?B?VVJUaUY2cGVVeUhCZExGbUtmcFhXZTdYSHIvaHFPaVBPU3h0OGR0azgwazBZ?=
 =?utf-8?B?Q1FrcHpxOG14cFZOTzV3Rkl2K3h2ZWFnQ0M1NkxiNDUxbUF3V1FySHRFa3ln?=
 =?utf-8?B?MlptcXFjbUgvWmZ0Q3BGU2kzRTdZK0dIK3VRL1NzRjZTOWMwRGNsNG4zR2J4?=
 =?utf-8?Q?z0gAMI3DeEXnL/myI6rSvGQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2c0950-e7b2-47bf-7ebb-08da0375937c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 15:41:15.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugtFx3jq7a9zloCgKh6/1U4TD86Z6HQiH1KopZE93f4S0bj9S4Am28wlT6kjt72ZiRwgkzsTVKjwbeuGsQM4Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/11/22 10:33, Shirish S wrote:
> [Why]
> comparing pwm bl values (coverted) with user brightness(converted)
> levels in commit_tail leads to continuous setting of backlight via dmub
> as they don't to match.

Why do the values not match? It looks like the value mismatch
is our root cause. I remember a while back looking at an issue
where we the readback was from DMCU while we were setting BL
directly via PWM. I wonder if the opposite is happening now.

See this for the previous fix:
2bf3d62dabcc drm/amd/display: Get backlight from PWM if DMCU is not initialized   


> This leads overdrive in queuing of commands to DMCU that sometimes lead
> to depending on load on DMCU fw:
> 
> "[drm:dc_dmub_srv_wait_idle] *ERROR* Error waiting for DMUB idle: status=3"
> 
> [How]
> Store last successfully set backlight value and compare with it instead
> of pwm reads which is not what we should compare with.
> 

Does BL work reliably after S3 or S4 with your change? I wonder if
there are use-cases that might break because we're no longer comparing
against the actual BL value but against a stored variable.

> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 ++++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index df0980ff9a63..2b8337e47861 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3972,7 +3972,7 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
>  				 max - min);
>  }
>  
> -static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
> +static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>  					 int bl_idx,
>  					 u32 user_brightness)
>  {
> @@ -4003,7 +4003,8 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>  			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
>  	}
>  
> -	return rc ? 0 : 1;
> +	if (rc)
> +		dm->actual_brightness[bl_idx] = user_brightness;
>  }
>  
>  static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> @@ -9944,7 +9945,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  	/* restore the backlight level */
>  	for (i = 0; i < dm->num_of_edps; i++) {
>  		if (dm->backlight_dev[i] &&
> -		    (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
> +		    (dm->actual_brightness[i] != dm->brightness[i]))
>  			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>  	}
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 372f9adf091a..321279bc877b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -540,6 +540,12 @@ struct amdgpu_display_manager {
>  	 * cached backlight values.
>  	 */
>  	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
> +	/**
> +	 * @actual_brightness:

"actual" seems misleading here. We might want to call this
"last" or something along those lines.

But let's first see if we can fix the mismatch of BL reads
and writes.

Harry

> +	 *
> +	 * last successfully applied backlight values.
> +	 */
> +	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>  };
>  
>  enum dsc_clock_force_state {
