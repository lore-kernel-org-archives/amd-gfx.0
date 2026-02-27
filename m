Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089FCFEFB42
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 12:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2C110EB24;
	Fri, 27 Feb 2026 12:18:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHrBGBk9";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C7710EB24
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 12:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Czi8EedFhmRhdX7ycUtqAeweEvt8Pm0WtnQKSK5Ra5kyjccCCgHn/rOfgRpag5LiEoQrAZs3tGtfMPaupzUXIGD5aTVFbcfH+U+mLB0wvkPi+yFRxSJ0zc7o5cRXoqyhxZ9Qc4NGsa89VwYM6jz7zV0QlOAaiIn6Anohn799ebNtBvnS3Ixgb6bcC1F7db9D+9ba2jSbpW2fOooEU9MzX/TOgy3hgqOZo5N0DyvxFYglO3y1t9oBiCwsGGWjLqFwGm6ktFO5c9Wl8y/fKqHksQxOZAua4fD9vdqtflZE12yJBjXAipMSAcWoBvy0s154xcUHCNrXelHYgYRPQgCtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APiJDF3xwmkPXW2Yp8xPo5mMTNDOgtHdm9Hu4Vc7oZs=;
 b=k65SJ7fDRYxyP32DQ/meRCxqXNJyMaTdiBcLlmvko6zu9HasMlNsTbi36pZMw0TZUemGb5WOiHR9mUI3jllqlfEf5kXFbNj9aH+3SgVraLXMLxRDgfs5pTFOuYlLWwWt1gfHgzluUkbKNYMTtzSGS8VlO9LrDAw3490hK+Fd147Chd1czfyTNwl9+rt1ktiA4eCi8dIIZdqBLVRvk5KqEcDgEAx585zDI5ATAzx1ToXHTbQVNT3YmzR9M9g++wN2nb2I0qeosMrPGAJvJHc2p4PIgRGV3YKROQgguDWfCrsbOifI3sN3Pxp9q+zK54o8SXI7kgXiMO2hWPd8MqrpYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APiJDF3xwmkPXW2Yp8xPo5mMTNDOgtHdm9Hu4Vc7oZs=;
 b=pHrBGBk94XuxFf3J2IbtxWhsgehBEDZHIL4DBWylplFG42l5VeXl7XcM8hT4+Pwgiz6bbIJsCpvK4Ibuu6vqcEF2eDGyYHmiU/PMDQ+4kLOIKgq5nFexOvYAdmZ9FC4xPCP+FxgrVY00jGHcedT2OYMXjdapGbLC7uKLoQA2Gbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 12:18:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 12:18:28 +0000
Message-ID: <dac747df-e23b-47f8-8b02-8c745ad3837b@amd.com>
Date: Fri, 27 Feb 2026 13:18:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] drm/amdgpu/uapi: Add EVENTFD bind/unbind ioctls
 for render node
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260216154943.1582412-1-srinivasan.shanmugam@amd.com>
 <20260216154943.1582412-2-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260216154943.1582412-2-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 751e2916-d89a-4ba6-4113-08de75fa5005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: yzHUw+EAkLMhN/rwVHR//Dk/FzBGwXsaRmOkKPkdLV+htGUBe2EV/HnGPy2U8tdukUPTzgegwgKov3W3ZxqxJuq6WHp23zSX0RsRTwzT99OZLDjz30KRr/w64MUfOLPZQ5zFfLBxP1ODcTrW6lAz3s6RKNAdPvzdwSJV0ksalBDn4tiej2XVLy91+lW9c7S0NkcvV7/z+2PMxUcQYUG8z9xLxl7e62uvfrXsBYAaW2Wjq7CcUeuq7gpg9eKlgy+vMN1vhqpSbDHvDgOeGSnt8YO4BiaMTE8D5lvep0lqy79KxuEMlUgW7ynaazCLe53vgJqXyScwRAr/sO6KlssHJNRUuG2w/QE4H8OS+2304m5BGqsqp8pATDxz6QbQMbNkb1CGOuJKGhzOzVc8vzcSJi/OAlEXEmL07QpSf9cLlWPrNlNfe3SMJ5Knfc12fJXTpuM61RY13TjiaN2oTa57T+/NUY3s+R/hXaNPnZGHb+cIBbtYMFfE8MkIFSYx5wzFNLqOfoHh3L8QS9Bjzi4vcNLNUIEG9K5LJ7siD0JeGVvnkEq8nc6/yW+V7Dw7C9QXmSnyL8yekQ1kyl3m6MorlZ5UJgYUZwlXjM/VdaQE+/WWY1GVmJfJRxwxQ64oSLKT0qPngmjBOiYIL9NZo3dDqJvAVQIdGYoMIC3kDtd8F5qFr6TX0eVLMpq7oU3tjMGI9qnu2hsQUnIAvB5VlHN1noVfuh4vTyUF1RCSTzDFQ5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFN6cmprNS8zaGhlcTdmRmU2VmRTN3NEdjZMQnZ4dGRTSHRHMVVZenlSamJK?=
 =?utf-8?B?V1pGbTJYcGZ0Yk1ndjNkaHVPZDRrQXJWN1R4WmRhWDdxUEJGNGtVOGgyQy9W?=
 =?utf-8?B?K25hOTJZNktwSFk4czZMVjdDOE80N3RvU1hIcVlQWEZJVVJ0a2dBZ2VmcFpZ?=
 =?utf-8?B?bi9jQ2VTMzZXLzNRd1lqTHdRdjR2ZzExckZGTFl3MHJISmtsMTR0VTZLSE9T?=
 =?utf-8?B?cDkyaVlsamx4VkR1ZUVzSlNmenZISTlodHQyR2pzMnBiU3l6RnlMVVA3MzlL?=
 =?utf-8?B?WDFJL1lWS0VDYnc0T09hQ01ackZNQ1l2R2tRN25FZUFOaGRvTHJmNm5CV0R0?=
 =?utf-8?B?Nm10ZURzVWdOeVNGYU1aWjBjQmVOQVlPQVFoRzdKNmx3ME5XdGd0c3RlWUd5?=
 =?utf-8?B?THVLbE94L0RNdjl2U3R5eFN1eEhPRFdER1VQM1poSkN0UlU1NlNTc0tLSkcw?=
 =?utf-8?B?bjk4Z3loTjl0ZVdLdERuSlhFUDFITGJ6MEdYRWNVY0l0N2VkU1hMY0k4Tzdy?=
 =?utf-8?B?ckVXOXJIZ1VPUTNMK202WjdLKzBjbFJ6aE41b083WnAzNjNtZGY1RitkOVVB?=
 =?utf-8?B?UUtjRHVMMFpZbGxxdjltbVh2ZmdUcGlUTlJySXFzSVVCOGFlVHRMU2dvcDRW?=
 =?utf-8?B?eUxkdWtUR3EvZGZ5WjJPdHJRWnhTcmpnVG9qYVNvM1dkSFB0UWNlUjRGUXVn?=
 =?utf-8?B?eE5kSkdzUWFhVVU3YXd0SGpPWmljU3h4SjdIM212TTZhdlJ6TCtPMW1sdURs?=
 =?utf-8?B?Ty9LZmhWaDNRTDk2ZVBNajc5VjRTdWlUc2NseFZ1bm1LRlUrUmpwTGRWRGNY?=
 =?utf-8?B?aFNZNUQzUHN2eEF1WEFjek4xZ0x5M2ZwOUlMZGxmQk11UUlPWG9oWkNlRkhJ?=
 =?utf-8?B?clVlSlJwdjhaWVF6ZDViMHM3L2kvL0c1UFZZNzVjbU5pZmZhY1QrUWFWSTg0?=
 =?utf-8?B?dWNPZVBYc2wzSC9BcWlhTm5hQnlzQnpZcVVJVzRWRnk1TW5UaFZWbnFhYVFp?=
 =?utf-8?B?Z1k2ZllvdE9iaVkvN1dtL1JkVm5kNWduUFVwbTVqTFI4K3lGQitSc2wwRENO?=
 =?utf-8?B?b0hWZ3RqZk8yVkdwOExUZXd2VzEyQlZrVkZUWDBjKzlDa2dRZEVzZnVqSkFv?=
 =?utf-8?B?S2FZekNUZXQwWFBMbGdnakxTNWFHR1ViVTJWV1pQcHJaRVVraHFPV3l0cUs1?=
 =?utf-8?B?RGVCUTFJaS8zK2VZSGVBZkJqR3BmTVlRelpYeEFiRHBaNUlHeHp6b3VKc1dh?=
 =?utf-8?B?djBJQUFEODF6RUFwblFDNklkYld3Q2E0alYzYzR1UkpRaTN1dTVzby8ySGNk?=
 =?utf-8?B?eWJCLzVSQmZUSUtNdGpnNjdHWWFQVGFSbzdwdmlHeWo0YWFveGJ6VWlOKzVK?=
 =?utf-8?B?WDdpUWkwalh5YzdYb3ZHcWhZS1N1bHdOeHM5TGlxN0Z1clpkZGw5ZzlXdWRB?=
 =?utf-8?B?TXpweFVQZG1zQXFia0JrbG1WVEErbFpyNFpjUnNyZGpHNEV4clNtWkZrUVBK?=
 =?utf-8?B?dnRONEsxQ29BMFR3OStjSm5zdHorUVJXeFRsM0FxZWdrQS82b09CVkxtSVR2?=
 =?utf-8?B?aDE2Q3QvV2FTTWlaZG5wc1N0Q1FveHgwSlhwVjFVRXZkd1JIUFp1dXIrajZM?=
 =?utf-8?B?UlJpb1ByRDY5RlgxK3VxK05SaEZmM1dZME1GU3IxQjVEaGRPMmx1cFBDYnR2?=
 =?utf-8?B?N1JvVXhCdTFMVkhlVXJCNjJWMGVKYmtaMmxVNEtuekRqT0plOE9LOW5qM09v?=
 =?utf-8?B?VkRibU83Z1RybEYwbmVGNFdNR0dFbVRYLzBpN3M0TXNxMVF3bTgyNHZEQUVm?=
 =?utf-8?B?VUtHU05OVHN0K1hZY01HZTdVR2NFaldyVm93bmRTNmh4Ry81YndKZENkL3Bx?=
 =?utf-8?B?aXc0UmJDcGxEVGRkdS9FL1FxcS9CL1k0eGdZemc1ZDRPUjU4REV4R3ZualRJ?=
 =?utf-8?B?WVRoZzNSdHdBdFpLemUvMm5wZTV3ZTU3WWlBSGFPQjZkODlrbG02VnhVRTV2?=
 =?utf-8?B?L05TZlYyVFE0TloyTW1VT2xUTU5LcWM1NS9mazZxT3BMYU1rN1ZucHJ3YmR2?=
 =?utf-8?B?djdxelFDV0ZhWitOYnpucmlmc1RkbWg5VVRFQ1cxR25IVmxaN3lNME5Jc2NN?=
 =?utf-8?B?SksyeHVBQ011NUJkbmpuT3pDOU9iTFpEQVcwUnNMekhDMDFIckw3dE9EcWVn?=
 =?utf-8?B?Mzc2cUJRanlkSzk4RWREa3J3eWJVblZqUi9pWHZsY1pjUDJONzBMQU52Y1li?=
 =?utf-8?B?VGhZdEZIQTVMaFJ0WVVUN21uTnVacjJkL0hUTlN3Tkp5ZzlVa2hGeHpRVzVP?=
 =?utf-8?Q?W6G9jAwscA73nOAm5Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751e2916-d89a-4ba6-4113-08de75fa5005
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:18:28.1274 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yv2ge5SWR0nE9rf/3kIbFyN1ME5V09YqZnBdGF9OrHjYccXq12yrqP+zUl1A9Jf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058
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

On 2/16/26 16:49, Srinivasan Shanmugam wrote:
> Introduce two new UAPI ioctls to allow userspace to bind and unbind
> an eventfd to a userspace-defined event_id on the render node.
> 
>     DRM_AMDGPU_EVENTFD_BIND
>     DRM_AMDGPU_EVENTFD_UNBIND
> 
> The bind ioctl associates an eventfd file descriptor with an event_id
> within the context of a drm_file (i.e., per-process / per-PASID).
> When a matching interrupt or driver event occurs, the kernel can
> signal the corresponding eventfd, allowing userspace to use poll/epoll
> for event notification.
> 
> The unbind ioctl removes the association.

Please re-order the patches. This is the uAPI which finally enables the feature for userspace and should come last.

> 
> Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Change-Id: I02faa7404c10c40d74c9aa2d4a367c226b8b23fd
> ---
>  include/uapi/drm/amdgpu_drm.h | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 33e8738ce91f..4b367352bebb 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -39,6 +39,8 @@ extern "C" {
>  #endif
>  
>  #define DRM_AMDGPU_GEM_CREATE		0x00
> +#define DRM_AMDGPU_EVENTFD_BIND		0x1A   /* render-node eventfd bind */
> +#define DRM_AMDGPU_EVENTFD_UNBIND	0x1B   /* render-node eventfd unbind */

Please no comment behind defines, additional to that the comments don't seem to add new information.

>  #define DRM_AMDGPU_GEM_MMAP		0x01
>  #define DRM_AMDGPU_CTX			0x02
>  #define DRM_AMDGPU_BO_LIST		0x03
> @@ -79,7 +81,12 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> -
> +#define DRM_IOCTL_AMDGPU_EVENTFD_BIND \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_BIND, \
> +		struct drm_amdgpu_eventfd_bind)
> +#define DRM_IOCTL_AMDGPU_EVENTFD_UNBIND \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD_UNBIND, \
> +		struct drm_amdgpu_eventfd_unbind)
>  /**
>   * DOC: memory domains
>   *
> @@ -204,6 +211,32 @@ union drm_amdgpu_gem_create {
>  	struct drm_amdgpu_gem_create_out	out;
>  };
>  
> +/**
> + * struct drm_amdgpu_eventfd_bind - bind an eventfd to an event_id
> + * @event_id: userspace-defined event id (e.g., HSA signal event id)
> + * @eventfd:  userspace eventfd file descriptor to signal
> + * @flags:    reserved for future use, must be 0
> + *
> + * Semantics:
> + *  - bind is per drm_file (per process / per PASID context)
> + *  - multiple GPUs: userspace repeats bind on each render node
> + */
> +struct drm_amdgpu_eventfd_bind {
> +	__u32 event_id;
> +	__s32 eventfd;
> +	__u32 flags;
> +};
> +
> +/**
> + * struct drm_amdgpu_eventfd_unbind - unbind an eventfd from an event_id
> + * @event_id: event id to unbind
> + * @flags:    reserved for future use, must be 0
> + */
> +struct drm_amdgpu_eventfd_unbind {
> +	__u32 event_id;

Why no eventfd on unbind?

For the design generally leep in mind that we can have multiple eventfd bound to the same signal!

Regards,
Christian.

> +	__u32 flags;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE	0
>  /** Opcode to destroy previously created residency list */

