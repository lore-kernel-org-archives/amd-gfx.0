Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CDBC982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C018310EDA1;
	Tue, 22 Sep 2026 15:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lgc1tBPr";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A0410EDA1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MafAXc80Nv0BsCGj9u254G+NrpP1lRMHnzqf6YbhRMbV4/Cd9hqBkVFRNw3KSbUsiWsLDJpE9hymW2HQ82Acgi2Vx6MGZDAIBeCu1xSQZOOzCY8aZGNzAavtkhQg7vA6a8uM4Kw3Gy1sQRTqqgTXQXje0p92WxqaE5GU+yyO2lQDH4H/hDLK9X3Q7+u8Np6Amm3PKdh5dGnTbjDc/zBXjosU6mAp+ievOt0IIn8bnkljp9LEbCajaFhQaZfaN3zyr2iOuAUtZTm66C3mWXH5fKwOzBU2BX7yogn/I9DbQ722qJxpgWP+6ExBQtZ+JSXyEFozOY33KY2msdiWLM55nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA1tgnKoTPKThdFgytrJxudWwPhZPFJXZeQVdrKYHKw=;
 b=S3/xVs3dFOTp1Qf4imkynwUgYo9DUy8ImrJtYoGlaNo1TYaQ3OMZD7ATwb47+1HaetvY+YEF9H001FaP2W5xoI7TIYk5k/nrWcKlHZXkp3B2B97JmAUFby9kLvRAX5kmpejqk7yPgE+zsUVotGy+E+t8vyjYYGus792+gQ7CVTibOnhIMaqWuv0Kf8l82AxXIDdtSWq+epGRFtJcUQ9vM+PswsuyeVmrKX8wksYRmDtZfQRYtX33OjPbxDIUXNAhr+EjDorgRBXy1tv5wj4OQzOGSsJIRNBZKNT7qKL9sbzkp4+yTiSe9EsTHBtbiqA2mITX3UKfukGkrDA8EE0AOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA1tgnKoTPKThdFgytrJxudWwPhZPFJXZeQVdrKYHKw=;
 b=Lgc1tBPrwCwL7sSEJbmnHD7caW7Nrg1jDv16zcnk6GszakxaepMYgb5aDO/K4TLuuzQSx35L2ifLDz6JgZ0VT5q04VXS8Lorl5ncsFATwnHpB9miSZAoFILPhXtUFTYMCvUIsa1ylIUtUEw90kCIZPrKxYLuGBvSlQ8vFoYSAto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 15:32:14 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::1b2b:b6fc:16eb:2422%3]) with mapi id 15.21.0406.007; Tue, 22 Sep 2026
 15:32:14 +0000
Message-ID: <3553c2d2-ca84-4333-a3cf-e3c745eaad1f@amd.com>
Date: Tue, 22 Sep 2026 11:32:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
Cc: James Zhu <James.Zhu@amd.com>, Natalie Vock <nat@pixelcluster.dev>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
 <d955f3a3-2f90-4e6a-bc9f-579df06e6402@amd.com>
 <E26TqGhRRCmT_3vybr_f2w@gmail.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <E26TqGhRRCmT_3vybr_f2w@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::19) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 317725f1-ef7d-42f7-0ff0-08df18bead2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|3023799007|6133799003|11063799006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: UyISvZay/kzXXYLG+koTzCsyMKI4SOgZuw54xkNhTbeMQeWPtaNPs8DdOiJaEyKik4awuCYVNenUEN+wieWGFPwB43uNcOmTxN9FhPBk0YdVffBr8Nd3xjc0d/hDsEYcKw7QUiNvgBxOdOV5eFONf7iArfpJAq1pSMUEk95byqGe9F3jMbhjRVnpTtRaICf7hsHuf88xS507RG+jwuF07u6vsIpEc9UaJ07q0kOwOqBuJt27i/QZ/x1mSO2ryyliKxQaPBAM21+sM15UL1zn7FBGUanU1sJdMypXSRuI/EjTLVwlh0tjoZ06FUGxWH+CKGgt9r691lMoA2mrxFF4F867UHWJjm1OA/6rB21IlBc9uoyQ2CdUQyNQN2Fbr6Xrhmc3tN3T745Jdqt3gFynSfYTYfUsMPlE/Am9ZBEuvBspuf3k90NI4oe6uvT/U2T3//m9EGayFwkIQoOeBocHBHe0aFe0xU0XlnRNkchx6M+zyeGDVGIP3Ojt6V+RUPQDerKGQLNaAtFlBq51YE5+FwioOriuDo54WlrN2DkjTGIT5wrS68uD+PzAHbSDOOgal5c+2oHvTZjszTgJJRnmTS07H5Lh/P9SuUDWWPm8GHcUyLvvMLGi6w2PtmnsI313po86KPvxJZuXdfC6TmqO/KLvyH5sYFD7PD2eMSXDi3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8558.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09LWnMrdTg3NWdXVTdFSnlqMGYzbllhQVFaaDZ4bTdrRHp5TGJWV2l1a2VH?=
 =?utf-8?B?MmJ5RC9XRFIwU2tqVFVSdXlqd1RvMGNiWGZoVE9GS3R0MUZldlcxOFJOWWwv?=
 =?utf-8?B?R3BjWDRpc3VLYzR5c2ErZk55UDdJV1hGalh0NjZRU1RrQmRseGZNaWpUOEVw?=
 =?utf-8?B?Tld5MHJPVU1ieTFNRTNCeXhGNjEzQ0d2SjVtMlhWTGxIb0xPaUtuNFJmSzJZ?=
 =?utf-8?B?QXltTDQ4Qmx0bDdrQWh0NXhlUGpNbWp3WGZ2OWdWRFBDNi9VM3pUY0ZYWkxB?=
 =?utf-8?B?NHRFd3EvYkUrZGhaMFdINFVwM3FIUEV2S1V3MXdWRU80Y2hQdE1RYm1oU3hI?=
 =?utf-8?B?dFJSNmVta2o1dWpocllpQkV2a1N5amFtZWtNRnIyb3FFRGxNRmVSbzhTL2s1?=
 =?utf-8?B?ZldRZDh6VW1ZSUM2TkpQRmd2Z1g2NVR3TTVPYmRXMk9ldGpONVViSlYwMy9G?=
 =?utf-8?B?c2VtbjRaaXFUMWkvM05GaUpVbEdIMDdmZWJ4TjJJMGFBZDJ3V2xVRHNGWEg4?=
 =?utf-8?B?c1dHVVFWMkdVRUJRblZiVXRvT1R0Q2NKMUdGTmlZU1YwSVphUVVuRVB3VGJI?=
 =?utf-8?B?R0QrWjlaQ3RtbnBCNTJscGJhc2pUU3hCWnladlBSSDhZQVdxZmVYOU1wSFAy?=
 =?utf-8?B?TWNtRzk2SlAxUjhsRFpRellyMWllNEs3NndXZUdCaTdkWUFicGYyYS9vRjJs?=
 =?utf-8?B?SzN0WWp5eWxNYjZlTmVYb3RqZGlBN1A0T05NeXpsWTdRNEVMT2hxdHY2V1JC?=
 =?utf-8?B?R2hpRXJ5cGRPZnFKMnVLN1BwbGM5d2p2UjJkaVk1SmJmaHp6bFVrZUhSWkNj?=
 =?utf-8?B?Y3hNZytHLytVR1RPNFk5QkwxWmluZTJkWVRPWnIwRzl5T2o0TkV6U1pGa0lM?=
 =?utf-8?B?K0YyNjBBMC8yWmVXdWdNaFJlRXhPUjE0NU9rYXg0aTNGdlYvSzhobkprYWZh?=
 =?utf-8?B?cXdYYm14MWF4cHYybGdxdWhYQWJ6aVhIV2taOVBDQ2hNR0pReEMyNFZBd3JY?=
 =?utf-8?B?R0ZsSUlJVUxzSytxN3pPS0REVk5aK1pOU3RnNmMvYkZqWUlTb0hlMUlCZmo0?=
 =?utf-8?B?Z1JQR2Y1MDhJVEFlOWZ4ZDRvRHVHSXE0KzJlVXZJbS9rcnZ1emJ3ckJEdEpG?=
 =?utf-8?B?OEtmN1B3Ny9SZ3VUVnhIOTlrY3pIeS9XSlVXcTcyUnZTMTh0RGc4WDIrd1Az?=
 =?utf-8?B?eGVha01NVU5nTkN4a0xYN0dpN3dyNFNYaUtKcm1CZnBZZG92MnBYcHFYWVdG?=
 =?utf-8?B?dXlabytTZ0JkUDcrMm9MMWVZdVdYVnFSYW5wTllmd1hiRm5sSVJ4SkduY3d2?=
 =?utf-8?B?RitvRXFkeWdHcHBHQkNwalI3blZ3clZreTdzaTY3c0hKanVranZzc2dwOTMw?=
 =?utf-8?B?SThjN2V3aGxrN0pjRmFoVUNyNjF6SDRWcHV5ZUVIeDJVU1RNZ2FBTzB2YVpk?=
 =?utf-8?B?VEp3YU1YaldMYW5JV1JQMytrTFkxdGNPdUpoRk9zNDhueVAxbi8xSmFheEVN?=
 =?utf-8?B?MXlpV0Z4T2dtVlduQy91eWJmQXErUUtidnlpeFBiNTZIWXI1WFl5RTlCL05D?=
 =?utf-8?B?MHdRZllpQkh0Y2diL3N0VmE1N1V6bk5vWGNXTDF3aUhtQ2YxSXl5clp3YlBS?=
 =?utf-8?B?RHg2cmt1c3lVKzdXeUlPT29waEF4VFQyS25hZm9UWExwK2tVaVQ2RXAzTXBs?=
 =?utf-8?B?bnJTMm0rMldlSEU2Qjdub2ZGbFB4SUl1MGFKMXBpRzY4eHdBSW9IQk05ZVBI?=
 =?utf-8?B?TDlSd0MrVmhMdHl0Qm43MnJIL0JjOCtWUFFIdkVlNG1ZQ1pkekQzaGVnRnNY?=
 =?utf-8?B?V1pmc0dUYW5oMmpISmg0WkZzeTdTcFNmVzRJQUJwM2Z5bGhPcHRDaGZGNGNP?=
 =?utf-8?B?SG1ILy8xRysycU9GbUJ1Z2VKYWttUisxZEVtNGZqUEVzK3dwTnVkcW00dGN2?=
 =?utf-8?B?MW9qdTh1L0tqQVV0bk9VRjVLSHduMHJXYzVBWUtnV1lrcXAxbWhOOW5DeTV3?=
 =?utf-8?B?UVdHTlpVNGJpUE9FM2ZVb1hTeW9aK1J5NzN3dk42VDNReWY4azJTTE13TGgr?=
 =?utf-8?B?aHZGeTNIK0g3YzR4b0VHYU5qOXE1NDBqQXNkK0EybW00NG5QVi9OMGVjM0NB?=
 =?utf-8?B?czR2bCtUL3VydVVzVjUySjNrMU9PM3lNMlVYQWVRbkEvRTB6TkZtazNCd0Zq?=
 =?utf-8?B?RjJnU3UyUG05enlKUHo1QVlza3RiMUhHUmdkcS91YXVWZlJmbXI2RTlLelBt?=
 =?utf-8?B?ZWNMZGUvSzQ3WVo5dlFRRTJGVHRLUk90WTcvNkNUWXcyOUFEU1BOb3lMdDNT?=
 =?utf-8?Q?jEYVI7a903rgN/aqwc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317725f1-ef7d-42f7-0ff0-08df18bead2d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 15:32:14.0933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5XnL+DUg4e6j34dMJF9TuzMofA7YENEGLWfwQKXm2wb4ngD8ZvOffelacaL3TMw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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


On 2026-09-22 11:22, Timur Kristóf wrote:
> On Tuesday, September 22, 2026 5:20:41 PM Central European Summer Time James
> Zhu wrote:
>> On 2026-09-22 11:09, Timur Kristóf wrote:
>>> On Monday, September 21, 2026 10:03:02 PM Central European Summer Time
>>> James>
>>> Zhu wrote:
>>>> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
>>>> UAPI for GPU performance monitoring features such as SPM (Stream
>>>> Performance Monitor).
>>>>
>>>> struct drm_amdgpu_profiler_args carries an operation selector and a union
>>>> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
>>>> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
>>>> destination buffer are described by struct drm_amdgpu_spm_args and
>>>> struct drm_amdgpu_spm_buffer_header.
>>>>
>>>> The ioctl number and struct layout are frozen here. The implementation
>>>> lands in the rest of this series and the ioctl is not registered in
>>>> amdgpu_ioctls_kms[] until then, so this header change alone does not make
>>>> the interface reachable.
>>>>
>>>> Signed-off-by: James Zhu<James.Zhu@amd.com>
>>>> Reviewed-by: Bing Ma<bing.ma@amd.com>
>>> Hi,
>>>
>>> Can you guys please clarify why this is necessary and what the use case
>>> is?
>>>
>>> Are we sure we want a uAPI for this? RADV has been using SPM from
>>> userspace
>>> for many years now.
>> [JZ] current RADV SPM is for graphic engine. These patches are for
>> compute engine SPM.
>>
>> Thanks!
> Is there any reason why it can't be done in userspace for compute too?
[JZ] for compute engine, user space is using ROCM stack , not RADV.
>
>
>>>> ---
>>>>
>>>>    include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 124 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h
>>>> b/include/uapi/drm/amdgpu_drm.h
>>>> index 9e5fa6f53e59..285949d63eb6 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -60,6 +60,7 @@ extern "C" {
>>>>
>>>>    #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>>>>    #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>>>>    #define DRM_AMDGPU_TRAP			0x1B
>>>>
>>>> +#define DRM_AMDGPU_PROFILER		0x1C
>>>>
>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE +
>>>>
>>>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
>>>> DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE +
>>>> DRM_AMDGPU_GEM_MMAP,
>>>> union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@ extern "C" {
>>>>
>>>>    #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE +
>>>>
>>>> DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #define
>>>> DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE +
>>>> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
>>>> DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP,
>>> union
>>>
>>>> drm_amdgpu_trap) +#define
>>>> DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE +
>>> DRM_AMDGPU_PROFILER,
>>>
>>>> struct drm_amdgpu_profiler_args)
>>>>
>>>>    /**
>>>>    
>>>>     * DOC: memory domains
>>>>
>>>> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
>>>>
>>>>    	} kfd_sigbus_delay;
>>>>    
>>>>    };
>>>>
>>>> +/*
>>>> + * Supported SPM (Stream Performance Monitor) Operations
>>>> + */
>>>> +/**
>>>> + * drm_amdgpu_spm_op - SPM ioctl operations
>>>> + */
>>>> +enum drm_amdgpu_spm_op {
>>>> +	AMDGPU_SPM_OP_ACQUIRE = 1,
>>>> +	AMDGPU_SPM_OP_RELEASE,
>>>> +	AMDGPU_SPM_OP_SET_DEST_BUF
>>>> +};
>>>> +
>>>> +/**
>>>> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
>>>> + *
>>>> + * @dest_buf: [in] used for the address of the destination buffer
>>>> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
>>>> + * @buf_size: [in] size of the destination buffer
>>>> + * @op: [in] specifies the operation to perform
>>>> + * @timeout: [in/out] timeout in milliseconds (in), amount of time left
>>>> + *           in the timeout window (out)
>>>> + * @bytes_copied: [out] total amount of data that was copied to the
>>>> previous dest_buf + * @has_data_loss: [out] non-zero if data was lost
>>>> (e.g.
>>>> due to ring buffer overflow), + *                 zero otherwise
>>>> + * @reserved: must be zero for forward compatibility
>>>> + *
>>>> + * This ioctl performs different functions depending on the @op
>>>> parameter.
>>>> + *
>>>> + * AMDGPU_SPM_OP_ACQUIRE
>>>> + * ------------------------
>>>> + *
>>>> + * Acquires exclusive access of SPM on the specified XCP for the calling
>>>> process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
>>>> + *
>>>> + * AMDGPU_SPM_OP_RELEASE
>>>> + * ------------------------
>>>> + *
>>>> + * Releases exclusive access of SPM on the specified XCP for the calling
>>>> process, + * which allows another process to acquire it in the future.
>>>> + *
>>>> + * AMDGPU_SPM_OP_SET_DEST_BUF
>>>> + * -----------------------------
>>>> + *
>>>> + * If @dest_buf is NULL, the destination buffer address is unset and
>>>> copying of counters + * is stopped.
>>>> + *
>>>> + * If @dest_buf is not NULL, it specifies the pointer to a new
>>>> destination
>>>> buffer. + * @buf_size specifies the size of the buffer.
>>>> + *
>>>> + * If @timeout is non-0, the call will wait for up to @timeout ms for
>>>> the
>>>> previous + * buffer to be filled. If the previous buffer is filled before
>>>> the timeout, @timeout + * is updated with the time remaining. If the
>>>> timeout is exceeded, the function + * copies any partial data available
>>>> into the previous user buffer and returns success. + * The amount of
>>>> valid
>>>> data in the previous user buffer is indicated by @bytes_copied. + *
>>>> + * If @timeout is 0, the function immediately replaces the previous
>>>> destination buffer + * without waiting for the previous buffer to be
>>>> filled. That means the previous buffer + * may only be partially filled,
>>>> and @bytes_copied will indicate how much data has been + * copied to it.
>>>> + *
>>>> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss
>>>> will be non-0. + *
>>>> + * Returns negative error code on failure, 0 on success.
>>>> + */
>>>> +struct drm_amdgpu_spm_args {
>>>> +	__u64 dest_buf;
>>>> +	__u32 buf_size;
>>>> +	__u32 op;
>>>> +	__u32 timeout;
>>>> +	__u32 bytes_copied;
>>>> +	__u32 has_data_loss;
>>>> +	__u32 reserved[9];	/* must be zero; pads this struct to 64
>>> bytes */
>>>
>>>> +};
>>>> +
>>>> +/**
>>>> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for
>>>> drm_amdgpu_spm_args->dest_buf + *
>>>> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
>>>> + * @bytes_copied:  [out] Amount of data copied for this sub-block
>>>> + * @has_data_loss: [out] Boolean indicating whether data was lost for
>>>> this
>>>> sub-block + *                       (e.g. due to a ring-buffer overflow)
>>>> + * @reserved:      Reserved for future use, must be zero
>>>> + *
>>>> + * This header precedes the SPM data in the destination buffer. The
>>>> reserved + * field maintains 64-byte cache line alignment (32 bytes
>>>> total).
>>>> + */
>>>> +struct drm_amdgpu_spm_buffer_header {
>>>> +	__u32 version; /* 0-23: minor, 24-31: major */
>>>> +	__u32 bytes_copied;
>>>> +	__u32 has_data_loss;
>>>> +	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
>>>> +};
>>>> +
>>>> +/* Supported Profiler Operation */
>>>> +#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI
>>> version */
>>>
>>>> +#define AMDGPU_PROFILER_OP_SPM			2
>>>> +
>>>> +/*
>>>> + * Profiler IOCTL
>>>> + */
>>>> +/**
>>>> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
>>>> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
>>>> + * @pad: Must be zero for input validation
>>>> + * @data: Operation-specific parameters (union)
>>>> + *
>>>> + * GET_VER operation:
>>>> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24) |
>>>> MINOR. + * Input: @data must be zero (reserved for forward
>>>> compatibility).
>>>> + *
>>>> + * Design note: GET_VER is intentionally a parameter-free query
>>>> returning
>>>> + * the global profiler UAPI version.
>>>> + */
>>>> +struct drm_amdgpu_profiler_args {
>>>> +	__u32 op;				/*
>>> AMDGPU_PROFILER_OP_* */
>>>
>>>> +	__u32 pad;				/* must be zero */
>>>> +	union {
>>>> +		__u32 version;		/* GET_VER: out
>>> (MAJOR<<24) | MINOR */
>>>
>>>> +		struct drm_amdgpu_spm_args spm;
>>>> +	} data;
>>>> +};
>>>> +
>>>>
>>>>    #if defined(__cplusplus)
>>>>    }
>>>>    #endif
>
>
>
