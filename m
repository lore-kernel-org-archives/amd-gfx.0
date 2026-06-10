Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A78CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 14:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7E410E4C1;
	Wed, 10 Jun 2026 14:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ldEZwrKo";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7ABE10E4C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 14:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qeBcOWpPKbfd7LiYx7p1BzhQbAsZoUwwRsK7mKdUDJqEEYlJTPMeO7gmCckVyW4VRz0Y+DbMg/SXHBkK/llv1xkXLTi05vzL7i1Kx5gZ+QvNQunwCVGoLDg/dx6JF0vsZF0krQJhcHDMBTdE7dheCNqsAw9SZxV5DSbRxW0B0sMF0Cbsuz6RkqLtsFrx713gtPsZp+C9i8x/D9iCy+Q7QRY1ChJ4Zz2Kn6bJOAPJR/n+9QiN0UMkgtl/jUTDx59O/bkzYMn6FvPEmD0rtXLVYzwqOXUnmkqJfWqKHXSVygJi88Eey7vPl/vb0jlCBqlBg58BI/sI98mWezaOrMU5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUEuHQMIr4OWBArxH3XHwqidljqu6ZP0/f9WX+NTgJI=;
 b=StcFTtVQteSeP4PPA5Yt5hrwfjAV0ktq1/Qn2kIbwbp8991aeVwl1SCbn/GrTRopNvoRAGbiEv8GlcEtNqTrkBvOyBMqN04Rg6kjrLhstxexzwUBmrbWW80wfkxXZEvmEHKnqUfa9ZDh9C1zFkFDUkXcbozBQhncAR8GT674ssB3f5Z/6yCca5hEtac2nIA7WE8D1oGiHKn815NPjuNgmst28KW4YQTJTu8Qqv3tydUK+HIDRV+D8tlqdV+1bWXskPrcvptG4EJ4+8mDF6Pq2Q6PD09wqsdWIdrD74yrJNZrQ3707OaNpezwfok5Ggjbll+GsqcEpN2KelCEzYTkjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUEuHQMIr4OWBArxH3XHwqidljqu6ZP0/f9WX+NTgJI=;
 b=ldEZwrKoHhlknuYrD8/LzXQ3+PmC680L9qGwKyeeDRqivmsjx2tOdXz15cMLCVbJ6ftQQkx2ZrVUtXAty5XbuVBEOumeLHFclRRs1sXNxHTsUl8tihGegMec1e9FlHqurM8ygRB4WxFHDO+yRRTWZyRjr3dxqLty340f8rDlDGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 14:46:59 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::576a:69b5:929c:8640%4]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 14:46:57 +0000
Message-ID: <0d02050a-4d03-4faf-871e-269a15008215@amd.com>
Date: Wed, 10 Jun 2026 10:46:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: add sdma queue counter for gfxv9.4.3
To: amd-gfx@lists.freedesktop.org
References: <20260610143639.59426-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <20260610143639.59426-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:610::38)
 To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: c267e88c-827c-4297-0e93-08dec6ff1f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|6133799003|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: 3oRYUgackcByzJ59b1cwWdwD9bEoea+LAQYw0bAvjP2FVARyj62Oor8aBl0cmYrJGSLFaiP1NN9ouao8O/aCD8Ga50SRfulpi4gm57wQpXXiAEYUTv+z5E1YRVrpnSV7e2gjmTUXlUIJBaSPVeyL2Zju0M9VPExVC9LKB4ZfiUcOvHGLYH3bJhCmOBEuCy3Q2g6jji+AYVUeHcRhQVvAGgcIkaLqWFv6gNpyO9RD3xrvSX5jlwFgmirFfK68SA35jM75QOVih1FnwkEgxcVTqlSn6+r0kdzE7j0Y55FkNY1f2tG1NnwcBcxnzk3QS4GYYcni/JAA3fF6SdPS14HfdQs9cxejXIvW7B55IoPgJchsYPRv+cUQ11AJkamMxLJOjRw24WycT/8/bgTr4Fh4Gwtp3Ja9s1BS8eK8WUXmCAkDuvy5Uy6Q308zYVsMDbFJRf1rIn9PM72P+EB1dhPbAmvXtASOOfmhdOjibPoc5eWE8x4x34QQ3GGyIKwRsS2N4ygtUSCdXU5R5WIy7J5DMGMnfp165fNdYNrj5EqfnTvhVpXekz2HE+FFqUbg0A+Kwn/k35LfPYSNyVUDlMYokr9UNNlK5hXEsKpGgfrhT1m3b0Ycd3SlYy3RYPJemFyaD35ee4YFYpNTsuXgX0tns64iDgsClOjwuxxdHhabCpYiVxYiigqt1gvJgIqpvx3t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(6133799003)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1hqYTBIOUdJTFNvYW52eHVjYjdlU2xoQUVPWG1YK3NaZSsyYVl2cllMOFla?=
 =?utf-8?B?Ni9PbXpmMU9VNjdrL3p6NERxcERsTGZtQWV3ZUJHSjJsTzd1dkhXK3NGU0RM?=
 =?utf-8?B?ZlAvSU5hZ0dReXlKbXZhYXdlZG1EYTlhVGJPMFBMeGs3UXUrQjNnUVNUZWRY?=
 =?utf-8?B?YVRKbDZHbU9YQkRTV2pmUzNkZm5aYmZaKzhQdWl1dzFTSXFSNzFFKzlqc2hG?=
 =?utf-8?B?eTZSajBYMXlWRUhiSXFIcFA4SWtkNllmdE1PV2hxYm9hRUVWVC9wOVN3dGhh?=
 =?utf-8?B?bGczMUlLbEplSThrbis5OEN4MWtPZVRZUFFzbm0rKzRPNitBTlhzZGwrT0JM?=
 =?utf-8?B?Z1VUbU00RnNMUWVCV21zdkQzM04wS2lTUWE2WGg3SFhhT0gxUUNRblF1cW03?=
 =?utf-8?B?azhBRVUyYndGeTZhcVhQQ0hvaDVyNHNhMUxuUkNTSTBRTjdURStUUDRPbDRO?=
 =?utf-8?B?OG1YYzIrUjF5NFVQR0xpbjNVcXVPLzM3am1iQVlLczdiV3NFR0s4QWQ4Y2FN?=
 =?utf-8?B?ZHRtRjk3VENqSWphUzlKbC9IRVdYL25HTENvM0RLenVlZExLQzRhdnFOdU9x?=
 =?utf-8?B?cmlGSkNWRkpFKzY1SGhYTkpDQ0lTUStBaEw4ZzQ0UEp4MXhGeXpFVC9MaVhK?=
 =?utf-8?B?d2thRVNpNzRLckZYZ0xFRFBJMjdqQ3o5Z1hWQ1lIVk9nUUtmNU9OYllwZlNY?=
 =?utf-8?B?bE5IVnRGOFpiVmh2SGp6eFlBa3ZPeU5WLzY0Uzd3MWgrUG1uRXdLL08zMDFW?=
 =?utf-8?B?ZUFvVzZXdnprRjZSODBtNUM5SVQ5eTZBZnlOMzF5aUJGKzNVSVVCYzR3VWhZ?=
 =?utf-8?B?WTlScFJXaU1jNGtQUk04L1UraURZTlF1V3dNOUN2Q1hiMGJyYk9PSGwvUldK?=
 =?utf-8?B?MU1KWEgydWthUDMvV2pZOXg1c2sxcWx2RU9ZRGh5RmorVnV2aUNvT0wyVEp5?=
 =?utf-8?B?NmxIeE1vYWhKT0pYWHl0cTVZUWk3L0lRUXo3WU9MLzY0T2dVYW50RjdsN3kr?=
 =?utf-8?B?Vi94bHhsZ0krNE9aZ0NBQnNXb0JIQVQrUkhYanF0OGRxYkozL1JsNmU5dERC?=
 =?utf-8?B?djBQOCtuZGlTTGNUVmRIbHd4a3AwdytkUFFxbWtwdi9ra084bU5IeTlFQnZL?=
 =?utf-8?B?WlFOSXJvTzhqNHQ5aEhuRDZsbzRrM2w5ZWM2TWV3RkQwbFB1TU8raFUzTzZp?=
 =?utf-8?B?ZWFDdllsYmxPNDJYSmR5U2pSQmRLWVNYbnNXWlBBR1NjNTdycThEem4xc2t6?=
 =?utf-8?B?SHd5VDYzMDNFMmZOYmdIZ2hsRkRVazg5SGQydEMxOFVjWTVtYkliUE9VSS8y?=
 =?utf-8?B?WnZnUWlsSVM2VjBuYUM1OW1hL0ZtVkx6YzBWcEpWODdjaVlBL25QT0J1cGJK?=
 =?utf-8?B?alYzZ2EwOXZ1Qkk0aTZqZ2RLUEhhUXVZdThxNTNjNGtOdlZ0N2pvWUVZNEx3?=
 =?utf-8?B?U0d6ZXVLMlZzV2RFTlIwNmttc2dvR1pJcU5OTWVYWUxzcndlZC8xZVZHY1Bp?=
 =?utf-8?B?MlNCSFVnL2dSUTllOEJrYXpHSXN5dEJsRVFWaGlDWlJDNm1UWmIvS0F5TkhP?=
 =?utf-8?B?eFVuNWQySThPSEtJTkFwVitCY3RiMUlobTBGUGdXb2RkTGc3SWpNVjFKREFL?=
 =?utf-8?B?c0oyMk5sa2FaeUFvQWIzZVRxdWM3ZGp0a3k0cDVSRVZKWWQ5cGNvN2t6YmV6?=
 =?utf-8?B?RkpzZDVxbVhEbSs4TVJYNEsvNklvcFBPOHlDWC95akRYZVlpNTRTcityMFBq?=
 =?utf-8?B?a3RCYjZKbitqK3FnZm12cXo4NTc5S0ltNDRDQWxoWUd6UXFqNWk3NXA5UXlU?=
 =?utf-8?B?Z213RUxJU3hreG9QN2ZRMW92ZnNaMGJ4ZlZaSmhsSnphMlMvQjBXMFo3UFlW?=
 =?utf-8?B?cmkwTHpyUmFQTkh3R2NVaFF4MDhRUDJrQTNCVTJ6S0dHZzV2MEU1YnQ4bi9t?=
 =?utf-8?B?b0tERFJsdjI3VExCL1phRnRXZE9Iek9STDRKaVdJdk9YYkxVV1lsOUNndUVZ?=
 =?utf-8?B?bisvS0tUbUxZNGg5aVA0NlNKRDFpUjRwS2RZZXRkcXR4N0IyNjNrRWFyYW00?=
 =?utf-8?B?eDR0ZXhSbndvektwdkxhNmNmbm50aENvMWI0MDM2N2xCbFM4UG1Yd3NoT05W?=
 =?utf-8?B?N08waTc5N2VKMVFuZnRFdDl5THFjenFmc3UrQWY4ZWRrODM1RFh4bGFlUi8z?=
 =?utf-8?B?UGd3Q3o5UjIvanRBMExTT2kzdnFKa0pyNEJqNGlIcHRZRnhtZllyQm9DcTlz?=
 =?utf-8?B?VFFLaVNnL0dwZFhpcnF2UDN3a3IxK05TMUFRNngxNmFwc0pWWC9aVk10Uy9Q?=
 =?utf-8?Q?hQqtOq0VgStYRQbLIs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c267e88c-827c-4297-0e93-08dec6ff1f05
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:46:57.3613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2BsLwFzA4HjHiWNC7XnEEs5j80cnxYUSM27eOeXdTAuJgP9plaRN4KNQdlcG9DmU+IrK0Ug1lBqZzjtIYzOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

Found a mistake, please ignore it.

On 2026-06-10 10:36, Eric Huang wrote:
> since gfx 9.4.3 HW is calculating accumulated activity counter
> per-queue in register sdmax_rlcx_utilization_hi/lo, CPFW adds it in
> sdma MQD for save/restore, KFD will read it from there. gfx 9.4.2
> will still keep the way to read from memory at rptr+8.
>
> v2: read dynamic counter directly from utilization register
> v3: add CPFW supported version check (Harish)
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 67 ++++++++++++++++++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 14 +++-
>   .../include/asic_reg/sdma/sdma_4_4_2_offset.h |  4 ++
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   |  3 +
>   drivers/gpu/drm/amd/include/v9_structs.h      |  4 +-
>   6 files changed, 111 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index f46c59118304..24caf6061efa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -584,6 +584,70 @@ static uint32_t kgd_v9_4_3_ptl_ctrl(struct amdgpu_device *adev,
>   			ptl_state, fmt1, fmt2);
>   }
>   
> +static int kgd_gfx_v9_4_3_hqd_sdma_get_counter(struct amdgpu_device *adev,
> +					void *mqd, uint32_t num_sdma_queues_per_eng,
> +					uint64_t *val)
> +{
> +	struct v9_sdma_mqd *m = get_sdma_mqd(mqd);
> +	uint32_t sdma_rlc_reg_offset;
> +	uint32_t sdma_rlc_rb_cntl;
> +	uint32_t engine_id, queue_id;
> +	uint32_t engines = adev->sdma.num_instances;
> +	uint32_t sdma_rlcx_rb_base, sdma_rlcx_rb_base_hi;
> +	bool found = false;
> +
> +	if (!m)
> +		return -EINVAL;
> +
> +	if ((amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
> +	     amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4)) &&
> +	    adev->gfx.mec_fw_version < 194) {
> +		pr_warn_once("MEC FW doesn't support SDMA counter!\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 5) &&
> +	    adev->gfx.mec_fw_version < 44) {
> +		pr_warn_once("MEC FW doesn't support SDMA counter!\n");
> +		return -ENOTSUPP;
> +	}
> +
> +	/* SDMA doesn't support over-subscription, there must be
> +	 * a HQD associated with a MQD, so found must be true in
> +	 * the finding loop.
> +	 */
> +	for (engine_id = 0; engine_id < engines && !found; engine_id++) {
> +		for (queue_id = 0; queue_id < num_sdma_queues_per_eng; queue_id++) {
> +			sdma_rlc_reg_offset = get_sdma_rlc_reg_offset(adev,
> +						engine_id, queue_id);
> +			sdma_rlcx_rb_base = RREG32(sdma_rlc_reg_offset +
> +						regSDMA_RLC0_RB_BASE);
> +			sdma_rlcx_rb_base_hi = RREG32(sdma_rlc_reg_offset +
> +						regSDMA_RLC0_RB_BASE_HI);
> +
> +			if (m->sdmax_rlcx_rb_base == sdma_rlcx_rb_base &&
> +			    m->sdmax_rlcx_rb_base_hi == sdma_rlcx_rb_base_hi) {
> +				found = true;
> +				break;
> +			}
> +		}
> +	}
> +
> +	sdma_rlc_rb_cntl = RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_RB_CNTL);
> +
> +	/* Read sdma activity counter from utilization register
> +	 * if hw queue is enabled, otherwise read from MQD.
> +	 */
> +	if (sdma_rlc_rb_cntl & SDMA_RLC0_RB_CNTL__RB_ENABLE_MASK)
> +		*val = (uint64_t)RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_HI) << 32 |
> +			RREG32(sdma_rlc_reg_offset + regSDMA_RLC0_UTILIZATION_LO);
> +	else
> +		*val = (uint64_t)m->sdmax_rlcx_utilization_hi << 32 |
> +			m->sdmax_rlcx_utilization_lo;
> +
> +	return 0;
> +}
> +
>   const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>   	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>   	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
> @@ -623,5 +687,6 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
>   	.trigger_pc_sample_trap = kgd_v9_4_3_trigger_pc_sample_trap,
>   	.override_core_cg = kgd_gfx_v9_4_3_override_core_cg,
>   	.setup_stoch_sampling = kgd_v9_4_3_setup_stoch_sampling,
> -	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl
> +	.ptl_ctrl = kgd_v9_4_3_ptl_ctrl,
> +	.hqd_sdma_get_counter = kgd_gfx_v9_4_3_hqd_sdma_get_counter
>   };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index b934863312d0..2b9177427058 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1067,8 +1067,17 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
> +			retval = read_sdma_queue_counter(
> +					(uint64_t __user *)q->properties.read_ptr,
> +					&sdma_val);
> +		else
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&sdma_val) :
> +				 -ENOTSUPP;
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
> @@ -2728,8 +2737,18 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	/* Get the SDMA queue stats */
>   	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>   	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
> -		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
> -							&sdma_val);
> +		if (KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2))
> +			retval = read_sdma_queue_counter(
> +					(uint64_t __user *)q->properties.read_ptr,
> +					&sdma_val);
> +		else
> +			retval = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +				 dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev, q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&sdma_val) :
> +				 -ENOTSUPP;
> +
>   		if (retval)
>   			dev_err(dev, "Failed to read SDMA queue counter for queue: %d\n",
>   				q->properties.queue_id);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0be2fd04e6d0..d17f064ea7b9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -95,6 +95,7 @@ struct kfd_sdma_activity_handler_workarea {
>   
>   struct temp_sdma_queue_list {
>   	uint64_t __user *rptr;
> +	void *mqd;
>   	uint64_t sdma_val;
>   	unsigned int queue_id;
>   	struct list_head list;
> @@ -165,6 +166,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   
>   		INIT_LIST_HEAD(&sdma_q->list);
>   		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
> +		sdma_q->mqd = q->mqd;
>   		sdma_q->queue_id = q->properties.queue_id;
>   		list_add_tail(&sdma_q->list, &sdma_q_list.list);
>   	}
> @@ -193,7 +195,17 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   
>   	list_for_each_entry(sdma_q, &sdma_q_list.list, list) {
>   		val = 0;
> -		ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +
> +		if ((KFD_GC_VERSION(dqm->dev) <= IP_VERSION(9, 4, 2)))
> +			ret = read_sdma_queue_counter(sdma_q->rptr, &val);
> +		else
> +			ret = dqm->dev->kfd2kgd->hqd_sdma_get_counter ?
> +			      dqm->dev->kfd2kgd->hqd_sdma_get_counter(
> +					dqm->dev->adev,	sdma_q->mqd,
> +					dqm->dev->kfd->device_info.num_sdma_queues_per_engine,
> +					&val) :
> +			      -ENOTSUPP;
> +
>   		if (ret) {
>   			pr_debug("Failed to read SDMA queue active counter for queue id: %d",
>   				 sdma_q->queue_id);
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> index ead81aeffd67..11c32e4274fa 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_2_offset.h
> @@ -493,6 +493,10 @@
>   #define regSDMA_RLC0_MIDCMD_DATA10_BASE_IDX                                                             0
>   #define regSDMA_RLC0_MIDCMD_CNTL                                                                        0x017b
>   #define regSDMA_RLC0_MIDCMD_CNTL_BASE_IDX                                                               0
> +#define regSDMA_RLC0_UTILIZATION_LO                                                                     0x017c
> +#define regSDMA_RLC0_UTILIZATION_LO_BASE_IDX                                                            0
> +#define regSDMA_RLC0_UTILIZATION_HI                                                                     0x017d
> +#define regSDMA_RLC0_UTILIZATION_HI_BASE_IDX                                                            0
>   #define regSDMA_RLC1_RB_CNTL                                                                            0x0188
>   #define regSDMA_RLC1_RB_CNTL_BASE_IDX                                                                   0
>   #define regSDMA_RLC1_RB_BASE                                                                            0x0189
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d34c869b182f..2c91242caadc 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -361,6 +361,9 @@ struct kfd2kgd_calls {
>   			     uint32_t *ptl_state,
>   			     enum amdgpu_ptl_fmt *fmt1,
>   			     enum amdgpu_ptl_fmt *fmt2);
> +	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
> +				    void *mqd, uint32_t num_sdma_queues_per_eng,
> +				    uint64_t *val);
>   };
>   
>   #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/include/v9_structs.h b/drivers/gpu/drm/amd/include/v9_structs.h
> index a2f81b9c38af..e0d387f08576 100644
> --- a/drivers/gpu/drm/amd/include/v9_structs.h
> +++ b/drivers/gpu/drm/amd/include/v9_structs.h
> @@ -69,8 +69,8 @@ struct v9_sdma_mqd {
>   	uint32_t sdmax_rlcx_midcmd_cntl;
>   	uint32_t reserved_42;
>   	uint32_t reserved_43;
> -	uint32_t reserved_44;
> -	uint32_t reserved_45;
> +	uint32_t sdmax_rlcx_utilization_lo;
> +	uint32_t sdmax_rlcx_utilization_hi;
>   	uint32_t reserved_46;
>   	uint32_t reserved_47;
>   	uint32_t reserved_48;

