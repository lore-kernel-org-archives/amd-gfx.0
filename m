Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0B2C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 15:42:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D71F610E15C;
	Fri, 15 Dec 2023 15:42:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E82210E15C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 15:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPMuF11k/VFj7d22HB9MJ8AUmnlBWQhagphj4RQ6fKjZW6wFaHEXOFNOLY0US/wh0GfCi21RtsgZ99QqylUqriBMiXGfNciPqcvXm1aLZ3G3AnY+gC/bqOWGcYhdz6A8wChnyQvOi3NHfLv+ruigCv1RrikvAuRl/XFtLczbuo2x0K5txe3W2If4wf4lWMSosRbQg4CKD6kGIhqn5HYeyj28/AZHL2/5gaBxc81yRJaov+nzU1fh1IgI7lxBAPgGegqGItUfOvoUtYgtaAgrr2R1PA7DKHxCo2lAX2IIQtyx1tMLdxIqVzRhtAC1tohfGqHL1Xt/UI1dTagaWbgmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Icoi8UWsDHaFcUCarkClG1ABw8T/gJrwxw3Cjd7j3ck=;
 b=DMp+HyQeDRmGFRPcT564ISPTy56knIkfMBVyt57inKBg0FAyRMcm8QZG+cQ2OKTTeqO3cumgHJoky+lVnpXBRYr0unJaeFtQ8+mZ3MgqtQV0U9BVLVejWE0fmmMim2coJm3rOW/fbQyt2oMJWb7+r2giv2eB2dC3E2W50niyL7snRWZYQn6GbYtV85VysnrrM12YjnHDHB4RNSNOe9NekoRRYTLB3rm5inLqFE6FuyMn5pwYHwugyrO8twWDnX8pB/nPZblfOebvUd5p30kj2M4cTB2YShCg8PW2dCMfyINDWMr2HJhk9TKXFSG7uZqqF32iblhEZ+GdB9rAdmo+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Icoi8UWsDHaFcUCarkClG1ABw8T/gJrwxw3Cjd7j3ck=;
 b=XIe6suLhuocO/krc71Arls3MLxNShLZW4YUbIpmZNsk/7rYS+RzB58MTZd3lcao6lakeBIIrFbOeEnqZmSfOFDpbznb1TStflxhCMqCSI4E5sSZTXTWhz8eDZUdmiyHE/NPElHmy/m8EPYYGB6VLsEfbUZw3348z2FCKNIIgBLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 15:42:08 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::3a35:139f:8361:ab66%7]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 15:42:08 +0000
Message-ID: <fbafc2d1-e722-4216-ab7d-379751b42657@amd.com>
Date: Fri, 15 Dec 2023 10:42:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add a new DC debug mask for PSR-SU
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231214211240.45719-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231214211240.45719-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0351.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::10) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e27e24a-ccd1-4d9f-147c-08dbfd846527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4yKdV360pxnGf3XlO+OA9cVAx7XBW/Y6YrxX7kJ2V8hqNWxvakEkK3itkVXSLI2meEr2ACSTrjzPjPmAY4XHdwWMgvF6UP1BHLeKCsFcFqtc06b7Za/+fjDAH6J3K7gse0xJVIaJRIUnAdZCc1Pc4dZOZHeslxEwSMKOjYUP2TDFu/nY8ZkAQWhmyrxbYMVgBKRZJxQcZnK+WrflK981xadJ1Ob/x7kTYWBFhjS9ZUfalFuIMdAh6U8iwuQ2ATp+mwuecZKLE6Iyf1QQD6H8IGSkfprGNZSXXd0jEQSO45Xpw3cFONetfvAIpJ0bu7KJI0w+W/QCor3LWHhUaLDREn22mTZ5LnPe1INX5Zbo5GAxH0ix1ky5X6P5tFI63QLQKsAsKSE50NwejQSefTHCcDSd1APgmC/euBZPT3wogY8DZhAWUhuZIsR1yofKo5O3igLQKSivVYYQweieeQCEwuRroUealnox1S11VsMaTDf76S1USKf0EhHKamGXfSUFpiO4bQ6OCI698TIytAs2n1gZ7Hq49F7LOLXfYObBkNMN12Uilsuz7xb6D7CisZnXxhmJwANPjGDtiM5mYOXKtjD3ujaX2dBsN+g/Yox7ktVshEm33oisxnJuQOp6cncJn0v0yDm1aTb6gb9VkP/7wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(2906002)(36756003)(5660300002)(4001150100001)(83380400001)(53546011)(6666004)(6506007)(38100700002)(26005)(2616005)(6512007)(478600001)(66476007)(66556008)(66946007)(6486002)(41300700001)(86362001)(8676002)(8936002)(31696002)(316002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBaekhibm9mMVVubVBVaUlUbWE5eVZDbnNPN0lMaDNyZUVCT2VUbkprT2NJ?=
 =?utf-8?B?MVlEdnFTYkdZeVFmdE93LzJZbjRHNXRIWThxanpOZVp0S1ZadVB4ZFI1eXh0?=
 =?utf-8?B?aVA1ejN4dlVNN3I1TThyN3RUNW9qV0c3RXhIanhxL3hIZHNHcDRFRUt1ZW43?=
 =?utf-8?B?aWpISnY3cXhpOUw2NGYxNWRUZmxUU2tDbFZvNDZBTEwycEdTcDhpb1MxVk1L?=
 =?utf-8?B?V0lRRDRSZTE2WDJsQnZ1bUZUS1Z5UndIMjZyUkwxdzN2M2d6ODRNaUMrZFQx?=
 =?utf-8?B?cGt0NGlIY25uNDRlV2NOZXpFY0VIOElLOFpVOThRR0FENmlYWHFNSzRxZFdx?=
 =?utf-8?B?RzJVUzJ2OWZyZ0U2bGpJZDRibkZSUjNxdVVYYndsNzUyUEhhQTNYUEUvdTJl?=
 =?utf-8?B?V1lDRGZKS3RqeG9XMDEzcFE2MDl2aytjdmpVdkk3ZUNuamNzTEFGUGl0cjhJ?=
 =?utf-8?B?Q1F4MFpmR0w0MW5WaEZjU3IxdGRxVlNWVHBGc0lzVHdYcHl5cSs1a2Vvdllm?=
 =?utf-8?B?THE3OGpZUmRKN3RFN3RzeG5INEwydnhxcnFleXRVMlFwbHFuMW1MdGovNUlV?=
 =?utf-8?B?clhGcDhNNE5FUjY3MCtvWXVMdm10MGJGQXhva2NDTUxWOWd0ZktKWGFSeVFE?=
 =?utf-8?B?M0UxYmVVZTNVOGRlVU0zV0pXWUdKZ3VtNUJ6SG82YnFrbWlDKzV6R0hQWnFn?=
 =?utf-8?B?REt0OVZBeWVzVmFyRHYrU1NUMVVQcDNsRGFkWEtMazRJSTUxTUh1THRsWjJ0?=
 =?utf-8?B?Zkp3TE1QSGUxWEYxK2Q3enRxRktNWlc3Z3J2Y3NiVGM1MzJJdzVaS05HQXZR?=
 =?utf-8?B?YU95ZmxDbzZKTEhMVEI4Z1cyNVR4b2hlZ1hlUHZSZjNVM2o5cm1LL2dhVitK?=
 =?utf-8?B?WmEwcWMxOUtKN2tVZ0NhdU1rN3RvNWJJVzdEL3M1dFJXL1Y5OFh3YjNFY0x6?=
 =?utf-8?B?VWtLYTNpVERKQUNJWmo2ZjkyU3lWYThFc2FyeG8xdnM4NjkxS2ZpSmZrTFhF?=
 =?utf-8?B?U25QZ2x2Y3RhQXIwV1o1Q2xSWmc4ZGpxSHNaeXVnM21zT0ZVUTdsS0pUeFlS?=
 =?utf-8?B?bFBreFhZL1JoUzdJMUpCSzdEeUo5Z1krdEFUL1FiOXVHSnJjNHU4cEcvaXlP?=
 =?utf-8?B?UDg2TmlmbmdYLzBlV0JwWHJLYXU5QjRIRTdMc2hiS0NkaERyaFhaSktnS0lO?=
 =?utf-8?B?TER1bUJOWFV3ZmNPdGlCaVp0eEsycCsvdnRya21tUU9ta2g5U0k0QTQ5SmN2?=
 =?utf-8?B?dmRsdWNPaVZRTXNqZXZVWTZYT0l5NTR5djZHdzFXdytORmptSFowUnZKd3ha?=
 =?utf-8?B?YXYrNWJ6VWJoa3Q0YmFwRkkrL3JKQ1BXS09qaXZ0RFBEU2RvbHpOYVFvOGcz?=
 =?utf-8?B?Nzh6SGc5dk1sTC9yeFdwRlJyUUN1eXlGQTJoV2dxRCs1aW9xUXZFYlk4RDc4?=
 =?utf-8?B?OXY1dXJ1OUE5VFFYeCtSQjV4aklUaTNUbTI1eStaN1REYjZCS3VBY3p5VjJ0?=
 =?utf-8?B?QVRMa3ovdTJCcXNiNytYUlE2ckhkWmkyZUpKcHFrQ3k4a0o4cXlPWGptWjNt?=
 =?utf-8?B?TzRrVmFPTXgrbVQ0TFJteDZ3aDd6QW5HeStTandsWHYvOGNLYWk2S0dFV21W?=
 =?utf-8?B?dXN4dzJpTlR0L1lpaytpazl3djVVSHp6YW9JdiszdmVQZUN5OThPeUlmdHJ0?=
 =?utf-8?B?V1ZiVloxeVpGRkR5aE1ucEp6ZjhLVVFycHBUQTJIOHJIRnNIK0JLMDZLNXdY?=
 =?utf-8?B?ampyNGxmait0RnlmMk1hMlgxdmdjTkQyT2ZSUjhqenllVzFYYWhpOEl2RW01?=
 =?utf-8?B?WlNwMGQvUUlKMEFpQVR4Uno4S3c2aHowTThFa250YnV3cWZJYVFtZ0l3cEJ2?=
 =?utf-8?B?SWNvbHNHTkJ5VGxIc003emowRmZyQjZYeG5CVlh5a0tUYXRGZHMvakI1OUhU?=
 =?utf-8?B?UzZKZjlnT0V6Z2JqTG11YlY5RS9SY1p6NVNWZlVTM0E5aStGWG51OUxjNjYz?=
 =?utf-8?B?SWdhVDhjR1d2OHJGQWRTanJUeTZpY2RXcGk4SnlIVTBSYzh1MnBEenA2d0pV?=
 =?utf-8?B?VC9tKzFaUGNzRXd5bmc0UjdrTXJpdmhXNnk4dnp3ZGQrSmJkUE1LeWYzMDBR?=
 =?utf-8?Q?KT5Gwi4bgReyt7/oS5M/jsrh+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e27e24a-ccd1-4d9f-147c-08dbfd846527
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 15:42:07.9364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GBX4ZH7HvhLnuFCVbMM1BqTkQqwRRVdlFBTmZxQeSYsvA5sFzX275JsCHkyNsq+VfTT0Wr+woHn13nBztyUnBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755
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

On 2023-12-14 16:12, Mario Limonciello wrote:
> Some issues have been raised that appear to be tied to PSR-SU.
> To allow users to confirm they're tied to PSR-SU without turning off
> PSR entirely introduce a new debug mask:
> 
> amdgpu.dcdebugmask=0x200
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 3 +++
>  drivers/gpu/drm/amd/include/amd_shared.h              | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index 08ce3bb8f640..1f08c6564c3b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -51,6 +51,9 @@ static bool link_supports_psrsu(struct dc_link *link)
>  	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
>  		return false;
>  
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_PSR_SU)
> +		return false;
> +
>  	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index ade68972ec28..5cad456f2e10 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -256,6 +256,7 @@ enum DC_DEBUG_MASK {
>  	DC_DISABLE_MPO = 0x40,
>  	DC_ENABLE_DPIA_TRACE = 0x80,
>  	DC_ENABLE_DML2 = 0x100,
> +	DC_DISABLE_PSR_SU = 0x200,
>  };
>  
>  enum amd_dpm_forced_level;

