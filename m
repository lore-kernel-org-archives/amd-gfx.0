Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34C3FD45EC
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 20:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE1310E82A;
	Wed, 25 Feb 2026 20:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GbmeYCue";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF71010E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 20:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVQNWR52eX3TDX5jGym/HfCy4QcliGfhBiic8lliDSg6z25j59vlZLhDRoJLj/0Me8VmuhCNo3reRTkToVSneqsV8vXm1bP2T1sY31EIRiK8zBZ7HNClSRJZpaaHjKhf19W26NWVUDPx7uz1asII8d/v8L7a+OjsfS0YpsXHSW3UvVrTR22GnuKWcJujSCU6LNL9JhANfpPv9u8xr19n05EA/0omILniyjzo/pNo+oe6mZTvFE7ezJKH2KjdU/xnH+e9s81fWjDd2RjjclRrWj/wmjJpb6527JOuy1Uwmx5X2QSBN1SX//wH8QYJwwFFT5mppqR/HUxI5SQ6ff+CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJFrP+ogTtqSKYkQtbVCR9IXOzingigpyYz2kOhAO0U=;
 b=phz6OuuoG5//tN3LiEGr/fJYp+RfK9ED+6uFbEKqFq8xElYzF3HQOLEwU3n6xVJTOu0iFau57bgXh03ERaJQ0EvrQkroyKq2E/+ODGHAPDA7lB9Ugv5G5K5N0ppkxmg++c1gxlV2D4WhW7FTo5fkuJIl9rgqHXobSWQmqoh0Z9gN2J+KpuEOLAqP7PmWpUcifsuUqoHBpjSSxRYwevkQtdLhPa9+PWbtUj4kq3rpV4K5aaXyylKQ18AZlFwymBiPLmnvbEWUzJN2bAZVGLDmTOWi2/nhofiInV8XogFK6uKj/ZQFWwg6gVyAcAs7bkgKtyukhv1lCaw5XcHd4rfwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJFrP+ogTtqSKYkQtbVCR9IXOzingigpyYz2kOhAO0U=;
 b=GbmeYCueP2st+bIwuGxUrJkZ1SO0HRgPvsG/cOJaVvmiXo9aLElcnw1LU4SwJ5drerj/U02LZvD/i5J8l6Dih7gZBQA0O7maa9cIoUaoECfmP6aBKM8qhR/mkQ8gqYWQhkKZin4SYizwqJ5bSkk0ZOIT26xVIlvuKwqIlLCyV50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS7PR12MB8371.namprd12.prod.outlook.com (2603:10b6:8:e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 20:42:59 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 20:42:58 +0000
Message-ID: <2dfc56e3-7e75-4f19-8e68-fc8c6a81d7ed@amd.com>
Date: Wed, 25 Feb 2026 15:42:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] drm/amdgpu: add UAPI to support profiler
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Cc: Bing.Ma@amd.com, "Liu, Jenny (Jing)" <jenny-jing.liu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0205.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::15) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS7PR12MB8371:EE_
X-MS-Office365-Filtering-Correlation-Id: b1549d31-6f08-4459-e1a7-08de74ae75f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: ccBhwIuMOYsY9IHZwcUFb/dcGNMzBPWT88A6kGssjcsvTvVifTLN/A+oBjgWrqPZxar7rvdWIoKaMLGTWYgqlpvhWZfZ0pM4Ej9q9O9mFAOTtVAy4CGJinAelctDGkIAngq9OtuTYOMx+ETvxIw8LuwdhCckppzX/oAKCrXghF+qKRzWdOvLFnURXphdgkkLjfpEGtr3vGzzMxDKicwDjOkCsIQj4FhJyaxG6qkko4u8SJGdTkaSYcuB5lIvBvUlIS8ofeVP1Bv0nbHw8PGHjNw3sNpZxGyAlxX2nSWT/dP4l/yTZkD/nfFlca9yHw9Gl4+nkdMRF10CRAUjhInwbwjwKZxZPE40FQq5sOgJEufQ/OvmN0Y4ktw6jtHd4B14BEoWW9bbATLWRxP+BjraQw3E5ZEzUXLsw194HTLg8D9ftZtIseYKwy2H4yEfY1B/chCFLAB5amDNZFYhpTsbSLlfnaQKZjkOgg659+f9MHZMdZr4JPepeQKl7MWwh34xs84Ua1wjrnEl5izn+GtIMxRIWhgN4WojIDk8xFvZj5Zj/sKcEKSK3Um2ZkNwwxrsXZY13n7DKPUbhjhnFao7096ExKGnKvZGfJVV0xoPkKcEBn4nUTjqbWhHE3pXdZmBAy9fICmoa0pDkfA26nhyrJ45Nx9Ty5QjpwcuBwJkxJSlTobBJhswrgoHMn8coI2KQMxt8XgM/yK2KX5fkitVSwb4j0u8AUzewSpSgpe+7y4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxpNHlPWmttSTRGdTMwa2JVZGphVCt5WnRwWGVNYTBzelYzUTEvcXBkdjRH?=
 =?utf-8?B?a1ZuUWtsRUFSOGRXaCtGVGprSEpYak5WZXJqb2w1dlRCeXF0NExsM29XYXIv?=
 =?utf-8?B?WnNSMmRrc1ZMN2Q5ckRrNlQ3U3d0ZXI1a3RZamYya0JSSk5pZW03YXltV3VE?=
 =?utf-8?B?RUpBTStqNzVDSnJOdjlycGtHajFpc0NSZkNTQTF5YkJJc0luTW5MZ3lXT2k0?=
 =?utf-8?B?N1Y4ZFM0TlB1N1RZK1U5YkdrblU4MnkrUnFYYkpQK0h0RnBBejFVRXR2QzV4?=
 =?utf-8?B?WFcycHB4REhzYzl5MzBOSmJPNTRleUlwY0tKUkhLUWFwalUwRTZSNVVQMW85?=
 =?utf-8?B?Y0FSL1Z0SHVxOUdYVytsQmoxQkgvbm9qRXJlaHlWdGhUYXZPUmhMUHp1SVB2?=
 =?utf-8?B?Y0FoaHg0eTBDcmJFTlcrZW93NUEwNzFieUFOQUIxWldCY05wRGJtS1Zmeksy?=
 =?utf-8?B?dW5GTjh2NXRQQmNYMXMzVXBLNnVWL3Zkb0l0WldEaVFRUncwVHRFelYwblJF?=
 =?utf-8?B?WEYySG40Nlh0VGlGQXVTbTdsQ1phTVZWeVBJaFdYUlFYUytSSlBpbGd6S0V4?=
 =?utf-8?B?dzFaY0VQZUJWd1hvYTZ4aEJidi84dmNZbjIzZEJpcTJMYTRqZVhIVjh4MzZZ?=
 =?utf-8?B?UEd2REoxYVV1TldIOW5LWjkrRzRPTGMvM2ZCLzlJYUhqM1pUOXhMT0VabHJB?=
 =?utf-8?B?dFBQejRBQXh6VDFwRURiOCt5WVk4TkVsS1BwNS9NOEtFRTErNjRwWjRyUUFh?=
 =?utf-8?B?TG9nQlhFL0FrTE53M0lTS05hcVRncHZzNG4welo2OFFWeVQwV2lJcHJPOXg1?=
 =?utf-8?B?cHB3YlpDSGtGTWRWMDZJYmZrK09uOHh2MiswQ3o0cHVKblVObG1uMzlrTEdI?=
 =?utf-8?B?RzMrNmdlVlMwYTZFSGpERjVvbWQyTnEzdDNhUUg3UHFNSU15U1ZiZkdhSlBa?=
 =?utf-8?B?bzh1dkNmazdPUUI5NkpLVDh5WjlxelI5a3JjeCtwVFRlRjk0cXRmbCtXQzBP?=
 =?utf-8?B?UkcxeXo2RTFuMzVhMDFEbDQ0dGxaYWNBS0paMVA4bVpFZmowMFdzRDZpSFhH?=
 =?utf-8?B?d3JmSU13MzlSYjRmY09RdmRvSTJxcDVyWUZWOEkxbHRkZCttOFdvSFNQUEpw?=
 =?utf-8?B?QmFIWEV3OUxEL0tXd29PUjFVVGFZdkVoV1VlSnFUcjRlaXNzSDNrK2NSQWo5?=
 =?utf-8?B?cm9URmF0UzBMVU4vbHBCajBoZnJtSlp0NkI1L3MwQ2NFYmpQa0xmY2U3Yzc5?=
 =?utf-8?B?UVlVM2VTSTQxUENvbi9UaW5GKzMxaitpNk1jVkpNRW5QQU00Vm9JMWoydUtB?=
 =?utf-8?B?cFdEZS9QNzcxMXFBSWN2ODVDZU9BTFNHaXFsV1liUDVHWGlQRCtFbmNFQkcx?=
 =?utf-8?B?WEFpSWJxY1VzSVNIM2QrSEt0cWY1OG5YRDdlN0xHM0lpQW5Rc2x2R3NzdUxQ?=
 =?utf-8?B?NjZEY21Ha0dXdW1xTWZLYjZuU2tybUNJdVZBSzFrdmo4NHlTMDlwV2YvZ3hI?=
 =?utf-8?B?UnZ6c2VhSGxVUUlTem1ET21GMXdQMUdiQkVzRDZ0VmZtR3M2YjRYTXo2SlVS?=
 =?utf-8?B?eG05cURhN2pXMk5PaTRXdXZuMkpQTTdBZGpzK0M0a0EyOFJ3OVVWN2NCV2pX?=
 =?utf-8?B?amsvNFhIN2hJQklaYjVMeTV3dmRGc3RxcnpRSWN1RCtRRnMxRWxkZzkyeWdx?=
 =?utf-8?B?MHVydWNseHlBTHhUeGNRVGVyWjlXSExqbW5MWVR5UTJuSE15YmF6MWVqVlds?=
 =?utf-8?B?VEY4OVJ3bXIyYjFIRHlBZndyRE9TaTR3aWdIM2IxSFZEV21WU3BqTUpnNTJS?=
 =?utf-8?B?VkMxQkV1cmxFTTQyYjFQQjBIUUpFOC9rdTh1c0ZFb3FNQzBWeGlodzVEUU1u?=
 =?utf-8?B?eUhKOXNONFo1RmRhTW1YQXZZcW1JOUF2YkphMXdwWjFib0YvOVFHbEo1QUdH?=
 =?utf-8?B?UU9nUllvOWJjU2wvYjZGMnBlMTZmTUo3K2RNaDk2ek1HdDFjK25RbG9jMW9X?=
 =?utf-8?B?UmVMbW9oMXVxYjl4VFZlL3NhaWRVUmhYYy9JaWI5Wk1rNXRoNjdETjlVNWxL?=
 =?utf-8?B?dlNPbHBwTUN5WFBsZmtsOUJHbnU4QWVkMUNBSUxHQXZTYXR2SjVSVC9RTm5s?=
 =?utf-8?B?eXFRdnRnbTk5RVdPKy9SRjVWKzkwRTFjd1hickFRSFJVenZ2SXVXU21KZjVq?=
 =?utf-8?B?R0o1UzEvRVFpVW5wZVZZMHlWd2l3NkFoN3IrTnQxWGQ2WWRNVFIvQWtkU0dr?=
 =?utf-8?B?a3ZvTkpPMXBHNW5jWWlwMGd2dG5MVzZabFpmT2hpR0RZRElnaXZtWDRFaW1i?=
 =?utf-8?Q?CfzjDQS+md93Hr/2SY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1549d31-6f08-4459-e1a7-08de74ae75f3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 20:42:58.7587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZ6Qrn16x5CT6S5mw9ghvUltMG1UJMB6shgObOL0dyPku8kgJi2/uK7t2rdlQgFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8371
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

Ping ...

Thanks!

James Zhu

On 2026-02-20 14:22, James Zhu wrote:
> which contains all profilers' kernel driver changes.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 1a961f62724e..dfc98d6d98a8 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>   #define DRM_AMDGPU_USERQ_SIGNAL		0x17
>   #define DRM_AMDGPU_USERQ_WAIT		0x18
>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
> +#define DRM_AMDGPU_PROFILER			0x20
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>   #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>   
>   /**
>    * DOC: memory domains
> @@ -1708,6 +1710,20 @@ struct drm_color_ctm_3x4 {
>   	__u64 matrix[12];
>   };
>   
> +/*
> + * Supported Profiler Operations
> + */
> +enum drm_amdgpu_profiler_ops {
> +	AMDGPU_PROFILER_VERSION = 0,
> +};
> +
> +struct drm_amdgpu_profiler_args {
> +	__u32 op;				/* amdgpu_profiler_op */
> +	union {
> +		__u32 version;		/* lower 16 bit: minor. higher 16 bit: major */
> +	};
> +};
> +
>   #if defined(__cplusplus)
>   }
>   #endif
