Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84080C982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2471F10ED7A;
	Tue, 22 Sep 2026 15:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8EqCtdB";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF7610ED7A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvURwMCyyN5yHZ47mbgmnbGg9RKicQZI/p2CXGoHg4wXiXG2dWzGJF3DquEPrkLpV0HSQabp+fLfSpwxYLzNK0bvUzBPbOLTl1rLJbhuREgvkSks2hh8JNeOEBjlOuBPtMxmloZfVk6Lm4xv1ITwUwbaROfZ5K+zJtp2YNqZoz69njA+YODmXTZKjpd5pcsZzj/MdouzrqnXXtpIAM2VNVgPkxyJQv/E+GsOtCg7cEB/ydbAxgooWtpPUyEop7N6Z+Vs30ioWlZIU+M3dhsDGXXFptvv2HAx1M+XEVdFW6y8FXNlfI1l9u1Z7kr49JIZKWQ9gZVX0XEsx4o/Qv/thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkYEjqIlL5rKLNagrTyaeqGmAOy06bsxMAeBL61hXFI=;
 b=hn69S8kA6r2H1MQjD2RdEIJgd+44m3TpJZEZbFRU75sruvfDYJaz3nV1aJP5LKw03g28DqQY03Aq64hZ8iAWagcPqcrEx+a6z9CRGlG+XzJqrz2vRWc/ye/jiAOl17OWi1QTtIkFLWfPDUiA0IVQkxE0b6OYDgKXTT1/LX9FQyyRV5Zt6ytHJylgtVlZ/CsH0yLGVo+zKcn4ho3eQrSW34ihCxRsOwb0CrR7DBBHhHjFh9Fb5LwLJpUDeaqVoxRmqWb83Bp6gDx9eELmYL3ET1nR6khyt7UhEE5GiFqF2XUbA+HY8A+Hv/WCPyeJbMv2i+9mFNeVY9jEN91g8XcyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkYEjqIlL5rKLNagrTyaeqGmAOy06bsxMAeBL61hXFI=;
 b=G8EqCtdBFqaQ/Rq7GXXH5Jl8g4DXizebGNWGaPup0XN9bUQC1PeWS2xM26aCT6r3lZ0wrVFwunSdIfNmyt2O9UIoPrl9SMr1xeO8rMjOcjoyK+ZdsCh9nzRqyuOBTw3WjkvIkvgSimyWkBqYKjtZkuceSiYl+kt7W1m3V7FVjk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 15:20:46 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 15:20:42 +0000
Content-Type: multipart/alternative;
 boundary="------------o0lC0xv79kIWRr0RGuGsh8HI"
Message-ID: <d955f3a3-2f90-4e6a-bc9f-579df06e6402@amd.com>
Date: Tue, 22 Sep 2026 11:20:41 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
Cc: James Zhu <James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
X-ClientProxiedBy: YT1PR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::19) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 8118d198-f5b1-4e42-b6b3-08df18bd1101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10067099003|3023799007|6133799003|56012099006|22082099003|18002099003|11063799006|4143699003|8096899003;
X-Microsoft-Antispam-Message-Info: 4Oh+cocpnfQ6uCa/4+oy7LOPKtgmwLUeWltTNIHEB/79xbe+CcVB+2idV3NNYstqZZwD4rxxRoSRPTq7QxxbRd2nN6CEnG+KGoYOPhUwf4l7mzcm5Vftt6gQMVqZqV5Dn7i/Sf8Qe18MSnX2Twy8OuElt4aBdLp853cKkmfPNBw9VlMhTDbl/X8jOajEU80QHKewKRPxGhEjzMIJW5uYI3isG8l7UNwEqyeldIFJct3GmdxOFMXemG3RV6Nx2/CV3QI3n0CnT6Hi8akyMjJb9+1y62SLKu1sUgTXOaMzYbYcHw8VAHweSnGOGke5QVftT+kbgXnt/66cbM5ZviY+6A/hSH0NpdDekqbZJ4uER56Kq6oEMtwfZ3p/HKQvl76RDNhY+fZZryHxCGyoV3xzhAuG8hWGyHBKpFIt/BQiB77yv9ZgizXN0972qQCXPnI+d3ByLxF2sqiN2An7U5kPKZLL/wPAN0QtNS48TZfNAyWWn4AJKiHqvi61sUcMSaW2/pNktFKpmZSyPt76gmYxCqPzskHxrNIA1gkPMtJ2N6JSBniL7nkaK+nAFAqM7wtqqwx3UcME/aKMwAsB3du0xa9EaWMPtfr6hDZOAu7XokLLorrKuQE2cr5dP7tcWLeL4drSfi/FbaXeIioVNTIjtp6IwzS9TQoOLfoOvseYrIo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K28xR09RYW1EdndGaVVDOStBSDgzZGFYV2R5c3JVZm1ZT3BkT1A0Y0I4aG5V?=
 =?utf-8?B?dVJOR3B2ZFJrMUc2cmpQamc3T3d0TitHSy9tWmwyVGx4YmtJQ20xM0M0R3E1?=
 =?utf-8?B?bjJKWHFac3FzMG02U3pNUTloVU9zaHVLYVpxVW5YOUErSUNyVmIrMFlDWFpq?=
 =?utf-8?B?aTI5MGtXV3dEelFMeG1oMG1YQ044MVNaUUVlMUt6YThUd1NTdjY1RElVb3dM?=
 =?utf-8?B?bkNQMDZRcDBueFBod3hWalEzWEZicFNhOGFNbTVxOStlY1l3VDlPOWRJV05l?=
 =?utf-8?B?ZUU2WnRqYlZZUm5kSGYwMVdmZ295c0RrQ2FHZjliblV2UUgwQ1V2OGlwK2lt?=
 =?utf-8?B?NGhET2lJdldZTVBWUXRuaG9tTUQ1Q2M5VzFqanpnN3FZcUJKNWlqVElUaTl3?=
 =?utf-8?B?ZUkvRzRPV3JOTUJiSEtZeDlMd0xyMEtrcEZ2UkMvQUtqeFR4dzJMYXNyRGZr?=
 =?utf-8?B?ektHK0RYZ1pQZXVBSENHU1dYb1JCYlhsbVZIaXZ2UHgvemNkOVpDeGVwMzBr?=
 =?utf-8?B?ZTZDTlcrM0ZIMW41UVJLT21USWdMT2hESkQxcUQ4TERhYjdockxaSlV4RFNN?=
 =?utf-8?B?Y2F1c0JtdktETlFMUjVISjlHWnR2Ty8zV3hkU2RTek8waUx3OEI5c3h0TGZn?=
 =?utf-8?B?ZnovUmx1Um1sNzdOWGIwei8xTTI4TUdyOUxZLzZWYTU4SUROSmNGNC9vQ1Ir?=
 =?utf-8?B?N0hTRmFYaTQ3U09sa3Uwb3hncjhuVGM5SFA3WExKSmxkYWV4Uy9nekhYYkZT?=
 =?utf-8?B?bllqeWRtS1IxZ1BZMnM0bzJXNXJSUk5ZTmtSN3VaU25uSHBsUUdwV3ZzSnQ4?=
 =?utf-8?B?djA2UWdURjZNKzhXeERGY1JTOGxHWndlL1BPSlRSTnVoc0hRNnRUVitNZk5s?=
 =?utf-8?B?TDRuM0Rqc29jVkVqaUkxY1paZG5WNXNnTnFZMDN6OFR5Ky9sVGk4T0c1V1hr?=
 =?utf-8?B?SHVId25pZ3loQVZsK0RrcmpuZ3oxMkIxanJiUythcnBMUWVrcnNjUnZyMlJo?=
 =?utf-8?B?azF1eGpBaVB0RHhRL2xDbVFJNEZiY2xFNUpCVm5xNkdiV2pwbkd0MCsvbXdE?=
 =?utf-8?B?bG5HM3VBNG1xbnNLVEhrN05WN29ld0hRMlBxeUwraXBMQm5YbFRIc2htT2JP?=
 =?utf-8?B?aXpWZ2NjK0R3am9ITXpLSzJDV0x1WmFxeDNwZFN3RGhWTlB5czZCTkZyMzZ4?=
 =?utf-8?B?U25xdnoxNERkcXhIamdGN0k0SXlONk1NQjVQdkR3K25OVlhvOHZjUkNMa3lo?=
 =?utf-8?B?YUdQa3lpSk9CbGN0OHhwS3VNOUI0THVHRWtRTnZBbUQ0bCtpTkQzN1ZmaFF2?=
 =?utf-8?B?bG1IbGIra29ncWRVR3V5aThNR3p5TFlTbzdkaERYbEhYWjdoMEw1ZUZ3elU2?=
 =?utf-8?B?VUZpY0hUYzVqdGpKUTh2eTNKaDFVUXh4TzlwR2F6b3lBMlE3UzNxUUd5Rm1C?=
 =?utf-8?B?VVpIUmNzRFdRR3FrVHVSd2xrYXMrMFRpNEZycFA0TnY5TCtCSEZTUi9iNFUw?=
 =?utf-8?B?b3JsZkN0NWZZQk9JOVBiU2lTK2o1TVFBTFFseVVoTGRZdWNMT0IwNHpSVDNp?=
 =?utf-8?B?VjhENEN1bEJHUFFxYXE1amx3U3hlTjFoVzJHVFl1eVJIbWZBWmpYeTgzcFU2?=
 =?utf-8?B?VU5hS29ZSkh6WUY4dmhXcUFPbFVBaDNLeUgxb1lheHBxeGpja2NaSVUvcEVu?=
 =?utf-8?B?Vmk0Mkw4UDFWMXZpSVpLU1BvOWVzWmxNeDdxSnRqRkR4TGJnTVRNSVZDS1dH?=
 =?utf-8?B?aUg1WHNsTU5TVXdSV0VCQU9SU0dhOFRPVmh6SHQvOVBqTSsxZ0JWRFpGUnpR?=
 =?utf-8?B?L3d6VXpZTzg0NFlNVkY2UCs3WVhjbC9manZ4VlZWSGZLRmZQanhGU2t5bUM3?=
 =?utf-8?B?MWczV2thRUZUNGMySnBaTTdwMFd2bldteW83M0d2VG5zVEt2c0ZrSlJrVGNS?=
 =?utf-8?B?T1ZOaVg4eVI1alJhS3ZIeVByM3IxR0NHb2E0ZzJGRWsveXdnTzN5d2pwY1lK?=
 =?utf-8?B?Ti84Y0pSdFhUV3RqdUhXMy9VMjA5MjN5VW5PMWZseDVuV3RyVnpUajdaU3h1?=
 =?utf-8?B?VVZXbzJJQ3RSaVk3a2lkSURKaXMxMkMxM0hFWm0zRjdjTmE0bEI1eWp1VXdw?=
 =?utf-8?B?aGNZTVZHcEdtakRaYjlpdEs3ZTloanJjMmIzT0YzaVlLdnR6RWp2S0pnN0RR?=
 =?utf-8?B?TWlEZWR0aVpVdzFyOVRuam84Q1Q4TmxsTk5JNHZqdnhOQkZuYW9YK1AzRXNY?=
 =?utf-8?B?N0Nud1h0b3ZZaWNxZllyTTV4azJtZGRseDJiWi9UYXBESVdkOWxDdEd0alpS?=
 =?utf-8?Q?q9uOaEkMqUZ8rI5gGx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8118d198-f5b1-4e42-b6b3-08df18bd1101
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:20:42.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IhnT6KMPqSFngkaDRfTegp3f1pKwm1IJHzffQDG8gwYQL2ORt8onlmwyeZnfR8pD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
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

--------------o0lC0xv79kIWRr0RGuGsh8HI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-09-22 11:09, Timur Kristóf wrote:
> On Monday, September 21, 2026 10:03:02 PM Central European Summer Time James
> Zhu wrote:
>> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
>> UAPI for GPU performance monitoring features such as SPM (Stream
>> Performance Monitor).
>>
>> struct drm_amdgpu_profiler_args carries an operation selector and a union
>> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
>> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
>> destination buffer are described by struct drm_amdgpu_spm_args and
>> struct drm_amdgpu_spm_buffer_header.
>>
>> The ioctl number and struct layout are frozen here. The implementation
>> lands in the rest of this series and the ioctl is not registered in
>> amdgpu_ioctls_kms[] until then, so this header change alone does not make
>> the interface reachable.
>>
>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>> Reviewed-by: Bing Ma<bing.ma@amd.com>
> Hi,
>
> Can you guys please clarify why this is necessary and what the use case is?
>
> Are we sure we want a uAPI for this? RADV has been using SPM from userspace
> for many years now.

[JZ] current RADV SPM is for graphic engine. These patches are for 
compute engine SPM.

Thanks!

James

>
> Thanks & best regards,
> Timur
>
>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 124 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 9e5fa6f53e59..285949d63eb6 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -60,6 +60,7 @@ extern "C" {
>>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>>   #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>>   #define DRM_AMDGPU_TRAP			0x1B
>> +#define DRM_AMDGPU_PROFILER		0x1C
>>
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE +
>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
>> DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP,
>> union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE +
>> DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #define
>> DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE +
>> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
>> DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP,
> union
>> drm_amdgpu_trap) +#define
>> DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE +
> DRM_AMDGPU_PROFILER,
>> struct drm_amdgpu_profiler_args)
>>
>>   /**
>>    * DOC: memory domains
>> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
>>   	} kfd_sigbus_delay;
>>   };
>>
>> +/*
>> + * Supported SPM (Stream Performance Monitor) Operations
>> + */
>> +/**
>> + * drm_amdgpu_spm_op - SPM ioctl operations
>> + */
>> +enum drm_amdgpu_spm_op {
>> +	AMDGPU_SPM_OP_ACQUIRE = 1,
>> +	AMDGPU_SPM_OP_RELEASE,
>> +	AMDGPU_SPM_OP_SET_DEST_BUF
>> +};
>> +
>> +/**
>> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
>> + *
>> + * @dest_buf: [in] used for the address of the destination buffer
>> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
>> + * @buf_size: [in] size of the destination buffer
>> + * @op: [in] specifies the operation to perform
>> + * @timeout: [in/out] timeout in milliseconds (in), amount of time left
>> + *           in the timeout window (out)
>> + * @bytes_copied: [out] total amount of data that was copied to the
>> previous dest_buf + * @has_data_loss: [out] non-zero if data was lost (e.g.
>> due to ring buffer overflow), + *                 zero otherwise
>> + * @reserved: must be zero for forward compatibility
>> + *
>> + * This ioctl performs different functions depending on the @op parameter.
>> + *
>> + * AMDGPU_SPM_OP_ACQUIRE
>> + * ------------------------
>> + *
>> + * Acquires exclusive access of SPM on the specified XCP for the calling
>> process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
>> + *
>> + * AMDGPU_SPM_OP_RELEASE
>> + * ------------------------
>> + *
>> + * Releases exclusive access of SPM on the specified XCP for the calling
>> process, + * which allows another process to acquire it in the future.
>> + *
>> + * AMDGPU_SPM_OP_SET_DEST_BUF
>> + * -----------------------------
>> + *
>> + * If @dest_buf is NULL, the destination buffer address is unset and
>> copying of counters + * is stopped.
>> + *
>> + * If @dest_buf is not NULL, it specifies the pointer to a new destination
>> buffer. + * @buf_size specifies the size of the buffer.
>> + *
>> + * If @timeout is non-0, the call will wait for up to @timeout ms for the
>> previous + * buffer to be filled. If the previous buffer is filled before
>> the timeout, @timeout + * is updated with the time remaining. If the
>> timeout is exceeded, the function + * copies any partial data available
>> into the previous user buffer and returns success. + * The amount of valid
>> data in the previous user buffer is indicated by @bytes_copied. + *
>> + * If @timeout is 0, the function immediately replaces the previous
>> destination buffer + * without waiting for the previous buffer to be
>> filled. That means the previous buffer + * may only be partially filled,
>> and @bytes_copied will indicate how much data has been + * copied to it.
>> + *
>> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss
>> will be non-0. + *
>> + * Returns negative error code on failure, 0 on success.
>> + */
>> +struct drm_amdgpu_spm_args {
>> +	__u64 dest_buf;
>> +	__u32 buf_size;
>> +	__u32 op;
>> +	__u32 timeout;
>> +	__u32 bytes_copied;
>> +	__u32 has_data_loss;
>> +	__u32 reserved[9];	/* must be zero; pads this struct to 64
> bytes */
>> +};
>> +
>> +/**
>> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for
>> drm_amdgpu_spm_args->dest_buf + *
>> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
>> + * @bytes_copied:  [out] Amount of data copied for this sub-block
>> + * @has_data_loss: [out] Boolean indicating whether data was lost for this
>> sub-block + *                       (e.g. due to a ring-buffer overflow)
>> + * @reserved:      Reserved for future use, must be zero
>> + *
>> + * This header precedes the SPM data in the destination buffer. The
>> reserved + * field maintains 64-byte cache line alignment (32 bytes total).
>> + */
>> +struct drm_amdgpu_spm_buffer_header {
>> +	__u32 version; /* 0-23: minor, 24-31: major */
>> +	__u32 bytes_copied;
>> +	__u32 has_data_loss;
>> +	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
>> +};
>> +
>> +/* Supported Profiler Operation */
>> +#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI
> version */
>> +#define AMDGPU_PROFILER_OP_SPM			2
>> +
>> +/*
>> + * Profiler IOCTL
>> + */
>> +/**
>> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
>> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
>> + * @pad: Must be zero for input validation
>> + * @data: Operation-specific parameters (union)
>> + *
>> + * GET_VER operation:
>> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24) |
>> MINOR. + * Input: @data must be zero (reserved for forward compatibility).
>> + *
>> + * Design note: GET_VER is intentionally a parameter-free query returning
>> + * the global profiler UAPI version.
>> + */
>> +struct drm_amdgpu_profiler_args {
>> +	__u32 op;				/*
> AMDGPU_PROFILER_OP_* */
>> +	__u32 pad;				/* must be zero */
>> +	union {
>> +		__u32 version;		/* GET_VER: out
> (MAJOR<<24) | MINOR */
>> +		struct drm_amdgpu_spm_args spm;
>> +	} data;
>> +};
>> +
>>   #if defined(__cplusplus)
>>   }
>>   #endif
>
>
>
--------------o0lC0xv79kIWRr0RGuGsh8HI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-09-22 11:09, Timur Kristóf
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:_Vw-t4UsQJK0Ic5kimqXtw@gmail.com">
      <pre wrap="" class="moz-quote-pre">On Monday, September 21, 2026 10:03:02 PM Central European Summer Time James 
Zhu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
UAPI for GPU performance monitoring features such as SPM (Stream
Performance Monitor).

struct drm_amdgpu_profiler_args carries an operation selector and a union
of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
destination buffer are described by struct drm_amdgpu_spm_args and
struct drm_amdgpu_spm_buffer_header.

The ioctl number and struct layout are frozen here. The implementation
lands in the rest of this series and the ioctl is not registered in
amdgpu_ioctls_kms[] until then, so this header change alone does not make
the interface reachable.

Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>
Reviewed-by: Bing Ma <a class="moz-txt-link-rfc2396E" href="mailto:bing.ma@amd.com">&lt;bing.ma@amd.com&gt;</a>
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hi,

Can you guys please clarify why this is necessary and what the use case is?

Are we sure we want a uAPI for this? RADV has been using SPM from userspace 
for many years now.</pre>
    </blockquote>
    <p>[JZ] current&nbsp;<span style="white-space: pre-wrap">RADV</span>&nbsp;SPM
      is for graphic engine. These patches are for compute engine SPM.</p>
    <p>Thanks!</p>
    <p>James</p>
    <blockquote type="cite" cite="mid:_Vw-t4UsQJK0Ic5kimqXtw@gmail.com">
      <pre wrap="" class="moz-quote-pre">

Thanks &amp; best regards,
Timur


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">---
 include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 9e5fa6f53e59..285949d63eb6 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -60,6 +60,7 @@ extern &quot;C&quot; {
 #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
 #define DRM_AMDGPU_PROC_OPTIONS		0x1A
 #define DRM_AMDGPU_TRAP			0x1B
+#define DRM_AMDGPU_PROFILER		0x1C

 #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE +
DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP,
union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@ extern &quot;C&quot; {
 #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE +
DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #define
DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE +
DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">union
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">drm_amdgpu_trap) +#define
DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">DRM_AMDGPU_PROFILER,
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">struct drm_amdgpu_profiler_args)

 /**
  * DOC: memory domains
@@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
 	} kfd_sigbus_delay;
 };

+/*
+ * Supported SPM (Stream Performance Monitor) Operations
+ */
+/**
+ * drm_amdgpu_spm_op - SPM ioctl operations
+ */
+enum drm_amdgpu_spm_op {
+	AMDGPU_SPM_OP_ACQUIRE = 1,
+	AMDGPU_SPM_OP_RELEASE,
+	AMDGPU_SPM_OP_SET_DEST_BUF
+};
+
+/**
+ * drm_amdgpu_spm_args - Arguments for SPM ioctl
+ *
+ * @dest_buf: [in] used for the address of the destination buffer
+ *            in @AMDGPU_SPM_OP_SET_DEST_BUF
+ * @buf_size: [in] size of the destination buffer
+ * @op: [in] specifies the operation to perform
+ * @timeout: [in/out] timeout in milliseconds (in), amount of time left
+ *           in the timeout window (out)
+ * @bytes_copied: [out] total amount of data that was copied to the
previous dest_buf + * @has_data_loss: [out] non-zero if data was lost (e.g.
due to ring buffer overflow), + *                 zero otherwise
+ * @reserved: must be zero for forward compatibility
+ *
+ * This ioctl performs different functions depending on the @op parameter.
+ *
+ * AMDGPU_SPM_OP_ACQUIRE
+ * ------------------------
+ *
+ * Acquires exclusive access of SPM on the specified XCP for the calling
process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
+ *
+ * AMDGPU_SPM_OP_RELEASE
+ * ------------------------
+ *
+ * Releases exclusive access of SPM on the specified XCP for the calling
process, + * which allows another process to acquire it in the future.
+ *
+ * AMDGPU_SPM_OP_SET_DEST_BUF
+ * -----------------------------
+ *
+ * If @dest_buf is NULL, the destination buffer address is unset and
copying of counters + * is stopped.
+ *
+ * If @dest_buf is not NULL, it specifies the pointer to a new destination
buffer. + * @buf_size specifies the size of the buffer.
+ *
+ * If @timeout is non-0, the call will wait for up to @timeout ms for the
previous + * buffer to be filled. If the previous buffer is filled before
the timeout, @timeout + * is updated with the time remaining. If the
timeout is exceeded, the function + * copies any partial data available
into the previous user buffer and returns success. + * The amount of valid
data in the previous user buffer is indicated by @bytes_copied. + *
+ * If @timeout is 0, the function immediately replaces the previous
destination buffer + * without waiting for the previous buffer to be
filled. That means the previous buffer + * may only be partially filled,
and @bytes_copied will indicate how much data has been + * copied to it.
+ *
+ * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss
will be non-0. + *
+ * Returns negative error code on failure, 0 on success.
+ */
+struct drm_amdgpu_spm_args {
+	__u64 dest_buf;
+	__u32 buf_size;
+	__u32 op;
+	__u32 timeout;
+	__u32 bytes_copied;
+	__u32 has_data_loss;
+	__u32 reserved[9];	/* must be zero; pads this struct to 64 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">bytes */
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+};
+
+/**
+ * drm_amdgpu_spm_buffer_header - SPM Buffer header for
drm_amdgpu_spm_args-&gt;dest_buf + *
+ * @version:       [out] SPM version (0-23: minor, 24-31: major)
+ * @bytes_copied:  [out] Amount of data copied for this sub-block
+ * @has_data_loss: [out] Boolean indicating whether data was lost for this
sub-block + *                       (e.g. due to a ring-buffer overflow)
+ * @reserved:      Reserved for future use, must be zero
+ *
+ * This header precedes the SPM data in the destination buffer. The
reserved + * field maintains 64-byte cache line alignment (32 bytes total).
+ */
+struct drm_amdgpu_spm_buffer_header {
+	__u32 version; /* 0-23: minor, 24-31: major */
+	__u32 bytes_copied;
+	__u32 has_data_loss;
+	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
+};
+
+/* Supported Profiler Operation */
+#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">version */
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+#define AMDGPU_PROFILER_OP_SPM			2
+
+/*
+ * Profiler IOCTL
+ */
+/**
+ * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
+ * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
+ * @pad: Must be zero for input validation
+ * @data: Operation-specific parameters (union)
+ *
+ * GET_VER operation:
+ * Returns the profiler UAPI version in @data.version as (MAJOR&lt;&lt;24) |
MINOR. + * Input: @data must be zero (reserved for forward compatibility).
+ *
+ * Design note: GET_VER is intentionally a parameter-free query returning
+ * the global profiler UAPI version.
+ */
+struct drm_amdgpu_profiler_args {
+	__u32 op;				/* 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">AMDGPU_PROFILER_OP_* */
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	__u32 pad;				/* must be zero */
+	union {
+		__u32 version;		/* GET_VER: out 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">(MAJOR&lt;&lt;24) | MINOR */
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+		struct drm_amdgpu_spm_args spm;
+	} data;
+};
+
 #if defined(__cplusplus)
 }
 #endif
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">



</pre>
    </blockquote>
  </body>
</html>

--------------o0lC0xv79kIWRr0RGuGsh8HI--
