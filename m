Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31E7CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 10:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7BA10EE05;
	Thu, 11 Jun 2026 10:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ydDJoS3X";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013039.outbound.protection.outlook.com
 [40.93.196.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1272510EE05
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 10:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2WoZj8qjIM1IO6FZ8aixlg7nyNi8EIQsZowscKDeYNLf+NVsJlMaKTvQ7nl6dYmOvccxUmqac2vFg/WVEnEpE31Kg7b4u7Vp3bDg74J+IZFZhIS+53NkhDHSq/MdCBGw9riMTi6wzsN96skfe6nM0d7Oe85aNPw7WZ+hAhwqP5065PCw5SFOAKmnYrqHOgmu6X+xa+Iv/qfVv2++ZqQkv6vBBKllwycn8vvQDG8XAa7wDKnkw9ZngiHDoYKbP7hb5eDKJzFOKISqpO4pDW1K+jt9o/yVhooA9253NLR4Ls4qDUmIaWbgONhOr722xabNtd04iPumEbBdcSSjzNWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsmz7+TepOqPEW426pxvR/JWXI3ySAmBtUwxgjf3snU=;
 b=IAbAgUleO0XIZQ14DpGDZrj7lHw3hOCCwxcpCaEjvAMxb5foLkpgna4m7bUF5yRWmTqWU1zeT9cV8hUGogm80KhwDdwBIKR3rA094kSRmojLR9/JvL6oa1LWzDZ4x8Qf6a8IzxcxVeSDIIDkKT74MO0jI5FbtUvKCmTW51xeDm23rqZNoCJ/yReAvRrS9OnE2YSgTrQTPCMG3FQo05l8XcVaJ7RpWYODOqkMHAX7vOwnw/OF5nRZNiYpoZzACaJMWAi9SPInse7zYQ+D8TbnixeXctyFZlvJ3fVx1mxLc7xFXC7gi2g1hvTY4WzLr8oIPw+8ebrpYx0WuCFjnj0euA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsmz7+TepOqPEW426pxvR/JWXI3ySAmBtUwxgjf3snU=;
 b=ydDJoS3XoEIXy+bXaIUM9gx2PdW+W/ZiPOh/cxBeXgimuh647KKREMY2fkmdxIrVxjidrH3itkAVFOFcMeZ/gek1GwNS+3bl0jaS2r85wa5E/jUVvPNBcTmi62mZZGzs9+jq3YJfC1iLV6xFtisS+E6N1O/llTyz8LSq73rQ4zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 10:12:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Thu, 11 Jun 2026
 10:12:51 +0000
Message-ID: <9e03a2bf-3860-402f-b220-9e6bbe19806c@amd.com>
Date: Thu, 11 Jun 2026 12:12:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260611072644.2856170-1-srinivasan.shanmugam@amd.com>
 <20260611072644.2856170-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260611072644.2856170-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: ad549f72-6f15-4129-0283-08dec7a1fed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zsGTRBe6SHTBrOwTFTCN95M9AvEXqpZxtP11Wmo3QSc6tyfpv1fq6EBoRYcRBy9OmsPKnJZ62zh22JCsZCaQKVIBwmBETr8eX1TqIvqs2ESKYANyaBN+oGl42JE0LRvjXWd3FNqbiv+yQsc6rnyvCN2QYVqf5Fycw68pgrbG3VJHE6xN5PC6QXx7zs/EM/X6Spoco9Yc2usKcvey/+Xmzv3QrqnU2dDk1d+u3ak6fs0gkzMW2b3P4SYpLarsiw5q61JpeiYRBdVsabUqyJjD9XCAjKm2mDGVEPhoBQkRQk40kQ4s8NFzIxlfFdPeygVR9XsFQtaxoG+xjW/a2Kj7cwMVS9qjMy7ebjoj7uftBuCGykTvAdWpTdCFFjshmOk6/SCaolzGnxWRuEyS0Hfsub2kOp0/AGwCrHgyBGiw6MbZdlk3SzOVA70GRLrl8wS+Qn2bcyFo0xaagAkffeqZXoul7K8ad9qN8n8GfoEe0mLmV+zQvjZwGjo/E32hI2wi4x9mG4FhpYgI3mtlsgtSahG+/CtPLV07xDGbETNp03ePgLJ5F2cTN5UWWXlBaAI5OeIXqUoW6nnV2dxp7tZZ0s1EkzBVuZYEkr+bUY8kPSajeZW2/I7P4mtXzw/CT0v5TV5wskURF85JfmsqmFgtLfh0SGtIullW06zG6knMX48g2yg8xYyq0DYcOs+UMeue
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1I5SWRlTkJmNDZOUGdiUmZLRS9JVWNjemdxcFl6clVNblJDY0ZRemEvbXh5?=
 =?utf-8?B?RmdrQVJpMFRDWEk3cVpiWFUycFNtK2FnTDFLZzhrU0pmL0VNKzcwMXNqV3ha?=
 =?utf-8?B?ckp2d3dBaThLUkRkd0ZDMndhdTgrNEYwUzR0VGlGeXRzUlJLL1BDdDVoZE9Y?=
 =?utf-8?B?M3BaY0ttY2Uwb2h6R0R2VzlCU1pkZ2JzeERjMmV2UFQ1OU5mRGphSFVPbGk4?=
 =?utf-8?B?dHYxVkJTM2hHM3h5NHArTU1tWUpicmhhVytpMDczTkl3YUJzNXZ5eWpabnYx?=
 =?utf-8?B?bTRzR3RrVXFQRlFWVUloYW5ueDRqMlB4UXliRlJqcnl6M0NTci9JMVZWVkw0?=
 =?utf-8?B?WHByQzBFemMzazVNVFpoRDhDc2MydU1JYnFNSG8zUHYzUUlwcTZsR1Vhb29O?=
 =?utf-8?B?MVRLZ0VyL1htZEpBTDQ3aFR4Q3lPSWJ4TXd0OUZTMG5NclNNdlFqWjVWVXMy?=
 =?utf-8?B?cXB0NVJQZjZnc1dNR3dOZ1ZrUFJnc0dJWFhVUkhpVUV1WjZxbWdHYUFqcExk?=
 =?utf-8?B?c1hmdFNoNHlCZFlpRmhCZ2EwU2ExQlNaSjNwMi9COTBmQVBqaDBSQ3ZScWFB?=
 =?utf-8?B?RU16ZHE3dk9qbVNjajUxR3ZqdllmVUNxaFNObWVXby9kK1d3Z0Fhd2pkR1BJ?=
 =?utf-8?B?VjhERVhQdSt5SUptdmUzT1VlZnlUYmVaYVd0TStIVG54ZnUvRWsvb01ybHpw?=
 =?utf-8?B?WWNyang0c3N5YmRFajlQNFRiWFN6bWphbVhBL1lwT3pybVNDbTdlUk1Gdkl0?=
 =?utf-8?B?WTI5aUFENGM3dGpPaHhXWUhrTlhGNGNEWDErdFNYUWptb3UvSy9IemUybHU5?=
 =?utf-8?B?Tlo0RHNBYW83QzJ6TFhsdGt5SVNORmdlQnNoeUgvVG1WL2liYVFORW83RDh6?=
 =?utf-8?B?a0tic056bjVWc1U2a0pYKzluZjJIT3hvU05aMnU1MkZVNGxWeXZFUXhVTG1P?=
 =?utf-8?B?QXRLUk8zbjJLTmdNdzZoV0s0cDFZL3FHYzAyVUN1eFhnUExyU1lQdyszdTBj?=
 =?utf-8?B?RWhPUU9iaERIZjVweXdHb0xUUkh4SkExSitZYndhRnBVWWdicHRMc3R5VFVB?=
 =?utf-8?B?QnhuRW5NeWdJTDFNcE83Zm9pN3VkWm9IRUZzaDZXNCtNN0MySE5JTHI2dC8w?=
 =?utf-8?B?NUdHMGRLeVByWHNlQndXWWxZYUo1ekM2RUgrL1pld0srNk5Md09NK3Bxc1Rn?=
 =?utf-8?B?bFRWaEFWMExCbFpuRTk4NDgrbHdlTi8rcDhGZ3M4NjZ3SE5mbnNNb2tQRjF1?=
 =?utf-8?B?ODN3NFhWdUFlWE1Zem9xc2kwK1Nic3hKKzBDeUNsU2cyRlFMVnE2c1lLcklB?=
 =?utf-8?B?Szd5eGpBeWwzUEpJY0NBS3ljOEV3SFV5dXlpZlVrT2FNYUN4YWJFSWFJYmQz?=
 =?utf-8?B?THdzcG5US3cwM0JVREVrM3NTVkNCYVpzTUkySEszdlI2d0laVTBIeEpjaEth?=
 =?utf-8?B?VVRONU1LalJ1VW5RQVlrSEo1eG9hU1dZdjhRWWE1YzVHcStXZFNpREpGMXFx?=
 =?utf-8?B?dmZucFZJZkNBVm9uakg5M0VTTEsrWFk5b0RHd0Fmc0ZuMHl0Yk14VGhUZE5C?=
 =?utf-8?B?SE1GYjBGSjZabWpmenVDb0hocFFPUVlHc2MvUGx0Zmd6VGk3WkVZeU9OdC9W?=
 =?utf-8?B?SmNIS2lFWE5WZ3kxYWtqdVlPMmtKQ1VDMmJoSzg1YUxxN2NYZ0JmSGkwUSt5?=
 =?utf-8?B?ZlEyeG1xV1lraEtHVDNka213WXpqYjhwVlpVZ2RQMjRNbzMweWhOYk9ZY3RS?=
 =?utf-8?B?T3F0bmVvZ2ZrTExudWJnUlFUNHhCWElJTXRLWlFsK3ZFVGVoUlltV1N5UWZ2?=
 =?utf-8?B?dExyVytKM1MyMUhFbzRyWWdmanQvN0xIbG5WZThTM3hTNlE3ZEh0aXhOaXVh?=
 =?utf-8?B?dXJhdDhJZzdyQnVRbjI0Q2IvcjQ1OTEyQ1gwNDhpRGxLaTFhVmVCYU16OUJh?=
 =?utf-8?B?M0hVRkdTM1VPd3ZLMkNmelN2aVJ1N2FNWGNjc2taa0ovTDF1Z3FGUDZVMTZE?=
 =?utf-8?B?T3kzd3I1YTk3cDlKalhRRTNUZ280aHNXczdRbndvSGdWcWlPQ3NnV1BOUnRH?=
 =?utf-8?B?elpnV1NOUUg4cFVSZC9kK0p4Ty95b3BaTDk4N1RUR3ZlNEVXMGxDSnpoei9H?=
 =?utf-8?B?c1lBdG5udk9ocnpLTEVnNGRBOEVNWTAyY1hmbkdmeXh0dHRENy9LemZLanpQ?=
 =?utf-8?B?cEJQRVQrV1BGeU9LZXNYbFNjS0RZcmo1QWdqem5yZGUvMi9GNGFSOFdnamNS?=
 =?utf-8?B?R1pqYTdKaTdja3JlZkJDU1NuSjFIZlRxNjdzZVBZSldvT3EyaGpnZzJOYW1J?=
 =?utf-8?Q?DHI4cqpQWxlVUDrQOY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad549f72-6f15-4129-0283-08dec7a1fed6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 10:12:51.3751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bcYxIPY/DxVMh9sBuxkJN9abPxvrxPsM7O+99St5myGJEm0+c/+p6Mik8Y6g0y0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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

On 6/11/26 09:26, Srinivasan Shanmugam wrote:
> The current EVENTFD UAPI uses a userspace-defined event identifier.
> 
> For render-node event notifications, userspace should subscribe to
> kernel-defined event types instead, allowing the kernel to define event
> semantics and signaling sources.
> 
> Add a shared AMDGPU EVENTFD event type enum and update the EVENTFD UAPI
> to use event_type instead of event_id.
> 
> Value 0 is reserved and rejected by the existing event_type validation.
> 
> queue_id remains part of the UAPI and is used to distinguish
> queue-scoped subscriptions from GPU/device-scoped subscriptions.
> 
> Eventfd signaling remains notification-only.
> 
> v10: (per Christian)
> - Add a comment clarifying that the flags field is currently unused,
>   reserved for future UAPI extensions, and must be zero.
> - Introduce event_type directly in the EVENTFD UAPI.
> - Remove the INVALID event type; value 0 remains rejected by validation.
> - Squash the event_id to event_type rename into the original UAPI patch.
> 
> v11: (per Christian)
> - Keep the event_id to event_type rename in this patch so that later
>   patches focus only on queue reference handling.
> - Move queue reference conversion and queue-scoped EVENTFD handling
>   into the subsequent patch to reduce noise in this change.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c | 107 +++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h |  17 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  37 +++++++
>  include/uapi/drm/amdgpu_drm.h               |  43 ++++++++
>  6 files changed, 145 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a75c68195df9..54bc31ee795a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -460,6 +460,11 @@ struct amdgpu_fpriv {
>  	struct amdgpu_eventfd_mgr	eventfd_mgr;
>  };
>  
> +struct drm_device;
> +struct drm_file;
> +
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..aaa4dd57099f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> index 4955ee942a1c..c777d563f1b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.c
> @@ -24,14 +24,10 @@
>  /*
>   * Render-node eventfd subscription infrastructure.
>   *
> - * This module provides a simple event notification mechanism for render-node
> - * clients using Linux eventfd objects.
> + * EVENTFD is notification-only. It wakes userspace when a GPU event happens.
> + * Event metadata/details are expected to be consumed separately through the
> + * corresponding wait/event path.
>   *
> - * Userspace can bind an eventfd to a userspace-defined event_id. When the
> - * driver signals that event_id, all eventfds bound to it are notified.
> - *
> - * This mechanism is intended to support lightweight GPU event notifications
> - * without polling from userspace.
>   */
>  
>  #include <linux/slab.h>
> @@ -42,19 +38,19 @@
>  #define AMDGPU_EVENTFD_MAX_BINDS 4096
>  
>  /**
> - * amdgpu_eventfd_id_alloc - allocate an event id container
> - * @event_id: userspace-defined event identifier
> + * amdgpu_eventfd_id_alloc - allocate an event type container
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * Each event_id represents a notification category. Multiple eventfds can
> - * be bound to the same event_id.
> + * Each event type represents a notification category. Multiple eventfds
> + * can be bound to the same event type.
>   *
>   * This function allocates the container which stores the list of eventfds
> - * associated with that event_id.
> + * associated with that event type.
>   *
>   * Return:
>   * Pointer to the newly allocated structure or NULL on failure.
>   */
> -static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
> +static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_type)
>  {
>  	struct amdgpu_eventfd_id *id;
>  
> @@ -62,43 +58,41 @@ static struct amdgpu_eventfd_id *amdgpu_eventfd_id_alloc(u32 event_id)
>  	if (!id)
>  		return NULL;
>  
> -	id->event_id = event_id;
> +	id->event_type = event_type;
>  	INIT_HLIST_HEAD(&id->entries);
>  	id->n_entries = 0;
> +
>  	return id;
>  }
>  
>  /**
> - * amdgpu_eventfd_id_get_or_create - find or create an event_id entry
> + * amdgpu_eventfd_id_get_or_create - lookup or create an event type
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> - *
> - * This helper returns the container associated with the given event_id.
> - * If it does not exist, it will create one.
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * The function is designed to be callable without holding any locks.
> - * Memory allocation is done outside the xarray lock to avoid blocking
> - * inside critical sections.
> + * Find the container associated with the specified event type. If none
> + * exists, allocate and insert a new one.
>   *
>   * Return:
> - * Pointer to the event_id structure or NULL on failure.
> + * Existing event type container or a newly allocated one.
>   */
>  static struct amdgpu_eventfd_id *
> -amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr,
> +				u32 event_type)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_id *new_id;
> -	XA_STATE(xas, &mgr->ids, event_id);
> +	XA_STATE(xas, &mgr->ids, event_type);
>  	unsigned long flags;
>  	int r;
>  
>  	xa_lock_irqsave(&mgr->ids, flags);
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, event_type);
>  	xa_unlock_irqrestore(&mgr->ids, flags);
>  	if (id)
>  		return id;
>  
> -	new_id = amdgpu_eventfd_id_alloc(event_id);
> +	new_id = amdgpu_eventfd_id_alloc(event_type);
>  	if (!new_id)
>  		return NULL;
>  
> @@ -140,7 +134,7 @@ amdgpu_eventfd_id_get_or_create(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
>   *
>   *   event_id -> list of eventfds
>   *
> - * The xarray provides efficient lookup of event_id containers.
> + * The xarray provides efficient lookup of event type containers.
>   */
>  void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr)
>  {
> @@ -186,23 +180,19 @@ void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr)
>  }
>  
>  /**
> - * amdgpu_eventfd_bind - bind eventfd to an event_id
> + * amdgpu_eventfd_bind - bind an eventfd to an event type
>   * @mgr: eventfd manager
> - * @event_id: userspace event identifier
> + * @event_type: kernel-defined AMDGPU event type
>   * @eventfd: eventfd file descriptor
>   *
> - * This function allows userspace to subscribe to notifications for a
> - * specific event_id.
> - *
> - * Multiple eventfds can be bound to the same event_id.
> - *
> - * Duplicate bindings of the same eventfd are treated as success and do
> - * not create additional entries.
> + * Register an eventfd subscription for the specified event type.
> + * Duplicate subscriptions are treated as success.
>   *
>   * Return:
> - * 0 on success, negative error code on failure.
> + * 0 on success or a negative error code.
>   */
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> +			u32 event_type, int eventfd)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e = NULL, *it;
> @@ -211,7 +201,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  	bool dup = false;
>  	int r = 0; /* duplicate binds are treated as success */
>  
> -	if (!mgr || !event_id || eventfd < 0)
> +	if (!mgr || !event_type || eventfd < 0)
>  		return -EINVAL;
>  
>  	/*
> @@ -229,7 +219,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  		return PTR_ERR(ctx);
>  	}
>  
> -	id = amdgpu_eventfd_id_get_or_create(mgr, event_id);
> +	id = amdgpu_eventfd_id_get_or_create(mgr, event_type);
>  	if (!id) {
>  		r = -ENOMEM;
>  		goto out_put_ctx;
> @@ -259,7 +249,7 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  
>  	/*
>  	 * Re-check duplicate under lock to close the race with another bind()
> -	 * for the same (event_id, ctx).
> +	 * for the same event_type and eventfd context.
>  	 */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  	hlist_for_each_entry(it, &id->entries, hnode) {
> @@ -291,17 +281,18 @@ int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventf
>  }
>  
>  /**
> - * amdgpu_eventfd_unbind - remove eventfd binding
> + * amdgpu_eventfd_unbind - remove an eventfd subscription
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @event_type: kernel-defined AMDGPU event type
>   * @eventfd: eventfd file descriptor
>   *
> - * Removes an existing binding between an event_id and an eventfd.
> + * Remove an existing subscription for the specified event type.
>   *
>   * Return:
> - * 0 if removed, -ENOENT if binding does not exist.
> + * 0 on success or a negative error code.
>   */
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd)
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> +			  u32 event_type, int eventfd)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e;
> @@ -310,7 +301,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
>  	unsigned long flags;
>  	bool removed = false;
>  
> -	if (!mgr || !event_id || eventfd < 0)
> +	if (!mgr || !event_type || eventfd < 0)
>  		return -EINVAL;
>  
>  	ctx = eventfd_ctx_fdget(eventfd);
> @@ -319,7 +310,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
>  
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, event_type);
>  	if (!id)
>  		goto out_unlock;
>  
> @@ -337,7 +328,7 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
>  		atomic_dec(&mgr->bind_count);
>  
>  		if (!id->n_entries) {
> -			__xa_erase(&mgr->ids, event_id);
> +			__xa_erase(&mgr->ids, event_type);
>  			kfree(id);
>  		}
>  
> @@ -352,22 +343,22 @@ int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int even
>  }
>  
>  /**
> - * amdgpu_eventfd_signal - notify all eventfds bound to event_id
> + * amdgpu_eventfd_signal - signal all eventfds bound to an event type
>   * @mgr: eventfd manager
> - * @event_id: event identifier
> + * @event_type: kernel-defined AMDGPU event type
>   *
> - * This function is typically called from interrupt context.
> + * Notify all subscribers associated with the specified event type.
>   *
> - * All eventfds registered for the given event_id will be signaled.
> - * Userspace processes waiting on those eventfds will wake up.
> + * Signaling is notification-only and does not carry additional payload.
>   */
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> +			   u32 event_type)
>  {
>  	struct amdgpu_eventfd_id *id;
>  	struct amdgpu_eventfd_entry *e;
>  	unsigned long flags;
>  
> -	if (!mgr || !event_id)
> +	if (!mgr || !event_type)
>  		return;
>  
>  	/*
> @@ -376,7 +367,7 @@ void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id)
>  	 */
>  	xa_lock_irqsave(&mgr->ids, flags);
>  
> -	id = xa_load(&mgr->ids, event_id);
> +	id = xa_load(&mgr->ids, event_type);
>  	if (id) {
>  		hlist_for_each_entry(e, &id->entries, hnode)
>  			eventfd_signal(e->ctx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> index 248afb1f2f14..e13b86240afc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eventfd.h
> @@ -28,9 +28,9 @@
>  #ifndef __AMDGPU_EVENTFD_H__
>  #define __AMDGPU_EVENTFD_H__
>  
> +#include <linux/atomic.h>
>  #include <linux/eventfd.h>
>  #include <linux/xarray.h>
> -#include <linux/atomic.h>
>  
>  struct amdgpu_eventfd_entry {
>  	struct eventfd_ctx *ctx;
> @@ -38,22 +38,25 @@ struct amdgpu_eventfd_entry {
>  };
>  
>  struct amdgpu_eventfd_id {
> -	u32 event_id;
> +	u32 event_type;
>  	struct hlist_head entries;
>  	u32 n_entries;
>  };
>  
>  struct amdgpu_eventfd_mgr {
> -	struct xarray ids;          /* event_id -> struct amdgpu_eventfd_id* */
> -	atomic_t bind_count;        /* total binds across all event_ids */
> +	struct xarray ids;	/* event_type -> struct amdgpu_eventfd_id* */
> +	atomic_t bind_count;	/* total binds across all event types */
>  };
>  
>  void amdgpu_eventfd_mgr_init(struct amdgpu_eventfd_mgr *mgr);
>  void amdgpu_eventfd_mgr_fini(struct amdgpu_eventfd_mgr *mgr);
>  
> -int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> -int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr, u32 event_id, int eventfd);
> +int amdgpu_eventfd_bind(struct amdgpu_eventfd_mgr *mgr,
> +			u32 event_type, int eventfd);
> +int amdgpu_eventfd_unbind(struct amdgpu_eventfd_mgr *mgr,
> +			  u32 event_type, int eventfd);
>  
> -void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr, u32 event_id);
> +void amdgpu_eventfd_signal(struct amdgpu_eventfd_mgr *mgr,
> +			   u32 event_type);
>  
>  #endif /* __AMDGPU_EVENTFD_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f5719500527f..7cc54b7e3b81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -634,6 +634,43 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *file_priv)
> +{
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_amdgpu_eventfd *args = data;
> +
> +	if (!fpriv)
> +		return -EINVAL;
> +
> +	/*
> +	 * flags are reserved for future UAPI extensions and must be zero.
> +	 */
> +	if (args->flags || !args->event_type || args->eventfd < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Queue-scoped subscriptions are enabled by the later
> +	 * queue-reference routing patch. Until then, keep
> +	 * queue_id zero.
> +	 */
> +	if (args->queue_id)
> +		return -EINVAL;
> +
> +	switch (args->op) {
> +	case DRM_AMDGPU_EVENTFD_OP_BIND:
> +		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> +					   args->event_type,
> +					   args->eventfd);
> +	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
> +		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> +					     args->event_type,
> +					     args->eventfd);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  /*
>   * Userspace get information ioctl
>   */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..bf4fc61cf0c7 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -39,6 +39,7 @@ extern "C" {
>  #endif
>  
>  #define DRM_AMDGPU_GEM_CREATE		0x00
> +#define DRM_AMDGPU_EVENTFD		0x1A
>  #define DRM_AMDGPU_GEM_MMAP		0x01
>  #define DRM_AMDGPU_CTX			0x02
>  #define DRM_AMDGPU_BO_LIST		0x03
> @@ -79,6 +80,8 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_EVENTFD \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
>  
>  /**
>   * DOC: memory domains
> @@ -204,6 +207,46 @@ union drm_amdgpu_gem_create {
>  	struct drm_amdgpu_gem_create_out	out;
>  };
>  
> +enum drm_amdgpu_event_type {
> +	DRM_AMDGPU_EVENT_TYPE_USERQ_EOP = 1,
> +	DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET = 2,
> +	DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION = 3,
> +	DRM_AMDGPU_EVENT_TYPE_SCRATCH = 4,
> +	DRM_AMDGPU_EVENT_TYPE_GPU_RESET = 5,
> +};
> +
> +enum drm_amdgpu_eventfd_op {
> +	DRM_AMDGPU_EVENTFD_OP_BIND = 0,
> +	DRM_AMDGPU_EVENTFD_OP_UNBIND = 1,
> +};
> +
> +/**
> + * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an AMDGPU event
> + * @op: operation type, see &enum drm_amdgpu_eventfd_op
> + * @event_type: kernel-defined AMDGPU event type
> + * @eventfd: eventfd file descriptor
> + * @queue_id: queue identifier for queue-scoped subscriptions, or 0 for
> + *	      device/GPU-scoped subscriptions
> + * @flags: must be 0
> + *
> + * This ioctl lets userspace register or unregister eventfd notifications
> + * for a render-node event.
> + *
> + * Eventfd signaling is notification-only.
> + *
> + * USERQ_EOP, QUEUE_RESET, and SCRATCH are queue-scoped events.
> + * Userspace specifies @queue_id when registering these subscriptions.
> + *
> + * MEMORY_EXCEPTION is currently GPU-scoped and requires @queue_id = 0.
> + */
> +struct drm_amdgpu_eventfd {
> +	__u32 op;
> +	__u32 event_type;
> +	__s32 eventfd;
> +	__u32 queue_id;
> +	__u32 flags;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE	0
>  /** Opcode to destroy previously created residency list */

