Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73050C7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 12:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB65C10E046;
	Mon, 27 Feb 2023 12:59:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69B810E046
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 12:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PptF4pH9S2C9DVikWgp0Y41HD+2YGi9VzSGxVv4LzPe2Y+AiJvHVXbvYVBG4KjktG5qu9kQ2G5Wyi7hiEF5FhPabS84GSop7kcD8DpwI3vUq5bPgw7WmJjV6tEuPPZ8Z8AlBQi6JgjcslUkP9hXWMCGmuvtv9WV4gBLPmTxjQWTPmc8ELlw+rpw2fRZ9p5HuQgcNoYICqajakErFM5kts9LeBYMoFu/ZmoX0PaArqQ5dlA7nHqfxiX7d2Ur6QuuMhvWtGXqCi2Usn4Jv/FOwkzngZY3H5GHYjo7fJ8rB/fNoa5obghkO8ERWCYQCSqrtCDrZZyVBAZGB2OcHl38Zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y3vtIljE5tvXKbuRTUaR3wXzkhZGyF+vXySxuS3JPg=;
 b=OlgFEBRrMvPJi+EjMIdfIDNgdqomNIAwRcL8qa8ecFB3dZmubLin0CkDEpM4TIpyOECmtFADhcdE3d6VygkvdW3JnoJizvpxeqFQm8fuLkI6H18Dg27xVg0rohyDDh2JC6CxTO/RiuI0h/5Fkx9hjJCe41O8rDgiLg3pcLio+txp6w+QEOeMxBJtNBV6AJxea8HwAN/l+SxnbbQKcKi3/wjmMM5QjDGJBfhGafRvjm6LHHbmYKRAuqoR2v4YwihL60GrEgzQS/CDBfbXb6dlX6SH3cfGVJfvwgBP0K2q92yhOpLtMkvr084yyrTEkCUghF5HjChiv5W+E1VxHf4B5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y3vtIljE5tvXKbuRTUaR3wXzkhZGyF+vXySxuS3JPg=;
 b=PH11hJfgZVMfAzUCl+7hQbFTre0/1LCvDH6SwrRqkw+BjnsTIahpGUb1XxVDkKneQDT/sTteDEQGHwMa2oWyLcLj5tcP/irAM8Fk2b30OYFN6t6QdzeEbk+o2lu7oUOf0Jf1pmJO9GeK60vUtbFNjf7QaMcjw38tsAbXBpqXDpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 12:59:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 12:59:52 +0000
Message-ID: <62177dac-97b0-2d85-fdff-92b7f1851ac8@amd.com>
Date: Mon, 27 Feb 2023 13:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
 functions
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
 <20230226165435.41641-6-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230226165435.41641-6-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 581a7ddc-3db1-4bad-f569-08db18c28412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOHcJbpNN28gw8FYzweCqKIM5WvKlNAAY4l6zOO+T1fGwdXemUjbhxsO4r0N4U29ZjCjj70vj7ZWoyrW9rElBUg8tQQmuWBJHUpCPZk1E/ZRORxKwS2zj7A1xsOZU1myEZ3o2RClsqCZBwdyH8Q3FEDSTCNrPBsffbD1kpLszEBYn9Aqc8tDsatiSmr7+0+wrNv8U+R+ZbDhiwu8yP6rU2h3JY4v5wMk//DK0gduvB7YtpP2fX8DybGTRXD2C6Rqzvtn06UG61lnsn68lqwPYbuY5bRQFhtTX45OZVVQKsaTfjYAx1OqwzwLP6L04isLXM6tXvJaZO0wubiTcviUQQXCpyZ9L2Amjz9IfuNmqnq2/p8fgwfKQ/RNROg8W3PWTd8JpM7UYudeTiGWHe9aauudUUizFHV7cWVZ9C/Bt/LtuvTDYK3EKXi1u1cRLzeA/Se0pOE58PtFnvrd6SD+uFRQt5rBP+bvt+U4K0TAdEu1Q3gNAnofNhMJsYdzMR/Rmp17BMw7G3hw05QEB8MGpKtSdSNrXdzte0DuLgzY4m4LMnlEstEXylBBcwPC27/bxqHbwfEt0U5PPXv5uXQsWsAsrHHE1pUmK5wXpSZbG2KUcEXqU3/jxAgZJZaqJHb2BFnszxH8lLa38C/FUM5GbsFECt7T37m00S1WuCKS2KPbX3LSnqoeVSQkDUMl5s0A3sngkvQbCICudnVZUX6/Ml2TOzr8+REvjFGqqeVDFxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199018)(316002)(2906002)(31686004)(31696002)(30864003)(5660300002)(36756003)(8936002)(86362001)(6506007)(66946007)(26005)(186003)(4326008)(38100700002)(66556008)(8676002)(66476007)(41300700001)(6512007)(2616005)(478600001)(83380400001)(6486002)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmlPMi9EN3o2T2FsM0Jkdnh0Y1BYQ1JnODdPck9XNnpvaTY4MnlUYk1aeWs5?=
 =?utf-8?B?RnM0cGI0MFh6VTlFOUNwQ2loOVhSaTE5Skk5RUdXZ2pMNmhXMzI3WGVUVUht?=
 =?utf-8?B?dzV5V3Zsd3N6bmFxYUZIc1ZhTlQ4YWxQVkNrcWgrcWV3RWpPOTdUTlJ5Q0w2?=
 =?utf-8?B?ckZDK1F5eVREV2tnakZXRjJCNWg5TjNHKy90MU9jclloMkFyTTM4WWMvL1Ev?=
 =?utf-8?B?UWFqTk5PM3U1Zy9jV3hoQWZ6UVlYTjB2VlU2bWxuODd1aTZxZlFqdTRidElX?=
 =?utf-8?B?R0dWei9TZDh4U2Z5UEo4VkQxL0s4cmZJcGJXUEZHeHZzdzlTWGJwWmlJN2xU?=
 =?utf-8?B?NEh6eFMxU0tiWHZaNWlHbTZCS3d4VXY3L2NvaVVjelFFN0dMRjFoQUE4SDVp?=
 =?utf-8?B?MzIrdlNqaXQ1MUFLZ3dROTI0Lzl0NG9zS01tUjFYaWpIVGRBa0psZGR1TUFy?=
 =?utf-8?B?V2VCaHRSRGdoNzYrRlBrRDRBT3VqWlk5dFhtYkkwMWhwdG5tU2hXRTBsZE8z?=
 =?utf-8?B?OHVsZEpUcHhUaWYxc1Y2SEwxekUzMEZQd2FkcktmdEt2L2xuMzMvMHMyaWRL?=
 =?utf-8?B?b1hMQWR1OU82MkZOWVM2NUhFWkZzRzJjYjhQRE9MNU5EalJWV3BxVnBJS1Rz?=
 =?utf-8?B?cHROdlNuZjBDTHViNFYwNkRiWExMa3pnaDhVN3dHKzVFbnE3RUhObzBzMzA1?=
 =?utf-8?B?UXFQRm1hbExBQlRUVE15elpZYXhtdlB3UlNVSTg3bVk1bTVzaUdFN0hWWG05?=
 =?utf-8?B?TmhXVWp6djBaYThSdklCd1JEbzNvQ1JNcm9acE9aV1JxYUF2ckV0Zmlsek5N?=
 =?utf-8?B?SURiblF4NE03N3lMM01FcURkUmVCOEZGT3ZqYkdtcTZmVWVpckJuZjJkd3RF?=
 =?utf-8?B?VEp3QVlsQXRzLzBwZzBTNXdvME1aM3N3aVdEOHFYZW5DY2cybXVscW1mU29n?=
 =?utf-8?B?U0tieWNJUklKM2o4anhJTThQSDBRK1dPcWJPaVR0VHhNZEpJUWl2bWc5aEFa?=
 =?utf-8?B?ako3em1ZMlFNSVZvcktHRHdSR3AyWllDS3J3YktnNitrRnJCbkxhK1d0MXNW?=
 =?utf-8?B?R0kybk11dml3MytJRlptVHprM3h4WlVHY056TlNHTFpwanlUYjJFQVloY0x1?=
 =?utf-8?B?RlkzME9NT2xJNVNETE9CekU4Z1huWUljbC9pckVGcTVPc3N0OWVkT3c3SXJT?=
 =?utf-8?B?c1RZY0VvdUVueC9KdmZ4dE45Y3JrSDZ4OUVacGdrOVpVN2trVjhxRWgrQW04?=
 =?utf-8?B?aWFzQmJHcGUwbGIveVQxcUs2WUZzZDdJRGJDcUZpbEtEbVVZeTJGN2hTdWR6?=
 =?utf-8?B?b1dGc3o1eEYyMG02MVA5R2N3SlJ5VndYN2hLdGVSazVGZlhPdkdkUmlOS2JQ?=
 =?utf-8?B?K1lJdEV1NHlpSS84WW90aDJLUUJkR1JRTDJsZGMyeU5lYWs4Mll0dTNRUE55?=
 =?utf-8?B?dUZGc2haL3NON1R1Mk5EUG4rQXg0SlRYWmxrK3hYQ1ZXTlJBcUxWTFk1bnU2?=
 =?utf-8?B?dU5lOEc0WWs3SExZTHBTeUd2MmRRWXBLNnZXbVp2aXlJOEFaWUxFMEMyTDVx?=
 =?utf-8?B?YVlFSTI3Wk94WUpmb1Flc2krWjJQYnNXVDlSVmtVNU5NekFtOVZ6aWsvTFRM?=
 =?utf-8?B?Q09CUDRBc2JtUjdMUzZlWnhDZHljeldnNzM4M0E1YzRHRTBuTTJUNnNzcTZK?=
 =?utf-8?B?WlhnR2s0WGhEckhhbjNVKzJlWGtRRGtsK3hnZFIwblpQRVRzL2ZRYkhJQzls?=
 =?utf-8?B?WjVCRlZvK1BXWEt1ZVBoYSt5MDRXaEgvQVhPWFpINXVzMXRNRTN2bnBNeGhB?=
 =?utf-8?B?U0lVb0lKbHNrbXFjUWpXNG01eDJzR1BkVjg3OE5aSUcrb2d5eVpBRGxKZWhI?=
 =?utf-8?B?d3hmRHBXekVVV29tclU1UTBTS1orRUZVYUQzVHB5a21NaG5iN2MyV2FIaGhl?=
 =?utf-8?B?WHdGWW5UR3ZhNEVrZ3FUKy94Q1l5OXYwMHdQTDZQaEhpUXpPckVzK2lmUXVm?=
 =?utf-8?B?dXJUL2h4WmlCeGtRT0xIVTllTEF6T3hQUlU1NU9Gb2wwMlRWMytNakk1MDZt?=
 =?utf-8?B?Z2U2SkttS0w5T296SGwrbzlYMnRlNTRBMUs0ZHdacnpIVWIrQXg5RXZBbTUr?=
 =?utf-8?Q?TLzf/ZRRQ1A/n+vqmomV8I2l4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581a7ddc-3db1-4bad-f569-08db18c28412
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:59:52.2864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQWYfp/Z63a6/zay+xam5SkST7nyVvnS6YoHmyoWq0ZvfYb6kmt7USknGUTNCWSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.02.23 um 17:54 schrieb Arunpravin Paneer Selvam:
> This patch introduces new IOCTL for userqueue secure semaphore.
>
> The signal IOCTL called from userspace application creates a drm
> syncobj and array of bo GEM handles and passed in as parameter to
> the driver to install the fence into it.
>
> The wait IOCTL gets an array of drm syncobjs, finds the fences
> attached to the drm syncobjs and obtain the array of
> memory_address/fence_value combintion which are returned to
> userspace.
>
> v2: Worked on review comments from Christian for the following
>      modifications
>
>      - Install fence into GEM BO object.
>      - Lock all BO's using the dma resv subsystem
>      - Reorder the sequence in signal IOCTL function.
>      - Get write pointer from the shadow wptr
>      - use userq_fence to fetch the va/value in wait IOCTL.
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 258 ++++++++++++++++++
>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   1 +
>   5 files changed, 270 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1c3eba2d0390..255d73795493 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -964,6 +964,8 @@ struct amdgpu_device {
>   	struct amdgpu_mes               mes;
>   	struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>   
> +	struct amdgpu_userq_mgr         *userq_mgr;
> +
>   	/* df */
>   	struct amdgpu_df                df;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6b7ac1ebd04c..66a7304fabe3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2752,6 +2752,9 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>   	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>   	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_DOORBELL_RING, amdgpu_userq_doorbell_ring_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +
>   };
>   
>   static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 609a7328e9a6..26fd1d4f758a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -249,3 +249,261 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
>   	.signaled = amdgpu_userq_fence_signaled,
>   	.release = amdgpu_userq_fence_release,
>   };
> +
> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
> +					struct amdgpu_usermode_queue *queue,
> +					u64 *wptr)
> +{
> +	struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +	struct amdgpu_bo_va_mapping *mapping;
> +	struct amdgpu_vm *vm = &fpriv->vm;
> +	struct amdgpu_bo *bo;
> +	u64 *ptr;
> +	int r;
> +
> +	mapping = amdgpu_vm_bo_lookup_mapping(vm, queue->wptr_gpu_addr >> PAGE_SHIFT);
> +	if (!mapping)
> +		return -EINVAL;
> +
> +	bo = mapping->bo_va->base.bo;
> +	r = amdgpu_bo_kmap(bo, (void **)&ptr);

Oh, that's not something you can do that easily.

The BO must be reserved (locked) first if you want to call 
amdgpu_bo_kmap() on it.

> +	if (r) {
> +		DRM_ERROR("Failed mapping the userqueue wptr bo");
> +		return r;
> +	}
> +
> +	*wptr = le64_to_cpu(*ptr);
> +
> +	return 0;
> +}
> +
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp)
> +{
> +	struct drm_amdgpu_userq_signal *args = data;
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +	struct amdgpu_userq_mgr *userq_mgr = adev->userq_mgr;
> +	struct amdgpu_usermode_queue *queue;
> +	struct drm_syncobj *syncobj = NULL;
> +	struct drm_gem_object **gobj;
> +	u64 num_bo_handles, wptr;
> +	struct dma_fence *fence;
> +	u32 *bo_handles;
> +	bool shared;
> +	int r, i;
> +
> +	/* Retrieve the user queue */
> +	queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
> +	if (!queue)
> +		return -ENOENT;
> +
> +	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
> +	if (r)
> +		return -EINVAL;
> +
> +	/* Find Syncobj if any */
> +	syncobj = drm_syncobj_find(filp, args->handle);
> +
> +	/* Array of bo handles */
> +	num_bo_handles = args->num_bo_handles;
> +	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
> +	if (bo_handles == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(bo_handles, u64_to_user_ptr(args->bo_handles_array),
> +			   sizeof(u32) * num_bo_handles)) {
> +		r = -EFAULT;
> +		goto err_free_handles;
> +	}
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (gobj == NULL) {
> +		r = -ENOMEM;
> +		goto err_free_handles;
> +	}
> +
> +	for (i = 0; i < num_bo_handles; i++) {
> +		/* Retrieve GEM object */
> +		gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
> +		if (!gobj[i]) {
> +			r = -ENOENT;
> +			goto err_put_gobj;
> +		}
> +
> +		dma_resv_lock(gobj[i]->resv, NULL);
> +		r = dma_resv_reserve_fences(gobj[i]->resv, 1);
> +		if (r) {
> +			dma_resv_unlock(gobj[i]->resv);
> +			goto err_put_gobj;
> +		}
> +		dma_resv_unlock(gobj[i]->resv);
> +	}
> +
> +	/* Create a new fence */
> +	r = amdgpu_userq_fence_create(queue, wptr, &fence);
> +	if (!fence)
> +		goto err_put_gobj;
> +
> +	/* Add the created fence to syncobj/BO's */
> +	if (syncobj)
> +		drm_syncobj_replace_fence(syncobj, fence);
> +
> +	shared = args->bo_flags & AMDGPU_USERQ_BO_READ;
> +	for (i = 0; i < num_bo_handles; i++) {
> +		dma_resv_lock(gobj[i]->resv, NULL);
> +		dma_resv_add_fence(gobj[i]->resv, fence, shared ?
> +				   DMA_RESV_USAGE_READ :
> +				   DMA_RESV_USAGE_WRITE);
> +		dma_resv_unlock(gobj[i]->resv);
> +	}

That will still not work correctly. You've forgotten to call 
dma_resv_reserve_fences().

The tricky part is that you need to do this for all BOs at the same time.

I will work on my drm_exec() patch set once more. That one should make 
this job much easier.

Similar applies to the _wait function, but let's get _signal working first.

Regards,
Christian.

> +
> +	for (i = 0; i < num_bo_handles; i++)
> +		drm_gem_object_put(gobj[i]);
> +
> +	dma_fence_put(fence);
> +
> +	/* Free all handles */
> +	kfree(bo_handles);
> +	kfree(gobj);
> +
> +	return 0;
> +
> +err_put_gobj:
> +	while (i-- > 0)
> +		drm_gem_object_put(gobj[i]);
> +	kfree(gobj);
> +err_free_handles:
> +	kfree(bo_handles);
> +
> +	return r;
> +}
> +
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp)
> +{
> +	struct drm_amdgpu_userq_fence_info *fence_info = NULL;
> +	struct drm_amdgpu_userq_wait *args = data;
> +	struct amdgpu_userq_fence *userq_fence;
> +	u32 *syncobj_handles, *bo_handles;
> +	u64 num_syncobj, num_bo_handles;
> +	struct drm_gem_object **gobj;
> +	struct dma_fence *fence;
> +	bool wait_flag;
> +	int r, i, tmp;
> +
> +	/* Array of Syncobj handles */
> +	num_syncobj = args->count_handles;
> +	syncobj_handles = kmalloc_array(num_syncobj, sizeof(*syncobj_handles), GFP_KERNEL);
> +	if (!syncobj_handles)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(syncobj_handles, u64_to_user_ptr(args->handles),
> +			   sizeof(u32) * num_syncobj)) {
> +		r = -EFAULT;
> +		goto err_free_syncobj_handles;
> +	}
> +
> +	/* Array of bo handles */
> +	num_bo_handles = args->num_bo_handles;
> +	bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), GFP_KERNEL);
> +	if (!bo_handles)
> +		goto err_free_syncobj_handles;
> +
> +	if (copy_from_user(bo_handles, u64_to_user_ptr(args->bo_handles_array),
> +			   sizeof(u32) * num_bo_handles)) {
> +		r = -EFAULT;
> +		goto err_free_bo_handles;
> +	}
> +
> +	/* Array of fence gpu address */
> +	fence_info = kmalloc_array(num_syncobj + num_bo_handles, sizeof(*fence_info), GFP_KERNEL);
> +	if (!fence_info) {
> +		r = -ENOMEM;
> +		goto err_free_bo_handles;
> +	}
> +
> +	/* Retrieve syncobj's fence */
> +	for (i = 0; i < num_syncobj; i++) {
> +		r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0, 0, &fence);
> +		if (r) {
> +			DRM_ERROR("syncobj %u failed to find the fence!\n", syncobj_handles[i]);
> +			r = -ENOENT;
> +			goto err_free_fence_info;
> +		}
> +
> +		/* Store drm syncobj's gpu va address and value */
> +		userq_fence = to_amdgpu_userq_fence(fence);
> +		fence_info[i].va = userq_fence->fence_drv->gpu_addr;
> +		fence_info[i].value = fence->seqno;
> +		dma_fence_put(fence);
> +	}
> +
> +	tmp = i;
> +
> +	/* Array of GEM object handles */
> +	gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
> +	if (gobj == NULL) {
> +		r = -ENOMEM;
> +		goto err_free_fence_info;
> +	}
> +
> +	/* Retrieve GEM objects's fence */
> +	wait_flag = args->bo_wait_flags & AMDGPU_USERQ_BO_READ;
> +	for (i = 0; i < num_bo_handles; i++, tmp++) {
> +		struct dma_fence *bo_fence;
> +
> +		gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
> +		if (!gobj[i]) {
> +			r = -ENOENT;
> +			goto err_put_gobj;
> +		}
> +
> +		dma_resv_lock(gobj[i]->resv, NULL);
> +		r = dma_resv_get_singleton(gobj[i]->resv,
> +					   wait_flag ?
> +					   DMA_RESV_USAGE_READ :
> +					   DMA_RESV_USAGE_WRITE,
> +					   &bo_fence);
> +		if (r) {
> +			dma_resv_unlock(gobj[i]->resv);
> +			goto err_put_gobj;
> +		}
> +		dma_resv_unlock(gobj[i]->resv);
> +		drm_gem_object_put(gobj[i]);
> +
> +		/* Store GEM objects's gpu va address and value */
> +		userq_fence = to_amdgpu_userq_fence(bo_fence);
> +		fence_info[tmp].va = userq_fence->fence_drv->gpu_addr;
> +		fence_info[tmp].value = bo_fence->seqno;
> +		dma_fence_put(bo_fence);
> +	}
> +
> +	if (copy_to_user(u64_to_user_ptr(args->userq_fence_info),
> +	    fence_info, sizeof(fence_info))) {
> +		r = -EFAULT;
> +		goto err_free_gobj;
> +	}
> +
> +	/* Free all handles */
> +	kfree(syncobj_handles);
> +	kfree(bo_handles);
> +	kfree(fence_info);
> +	kfree(gobj);
> +
> +	return 0;
> +
> +err_put_gobj:
> +	while (i-- > 0)
> +		drm_gem_object_put(gobj[i]);
> +err_free_gobj:
> +	kfree(gobj);
> +err_free_fence_info:
> +	kfree(fence_info);
> +err_free_bo_handles:
> +	kfree(bo_handles);
> +err_free_syncobj_handles:
> +	kfree(syncobj_handles);
> +
> +	return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> index 230dd54b4cd3..999d1e2baff5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
> @@ -27,6 +27,8 @@
>   
>   #include <linux/types.h>
>   
> +#define AMDGPU_USERQ_BO_READ	0x1
> +
>   struct amdgpu_userq_fence {
>   	struct dma_fence base;
>   	/* userq fence lock */
> @@ -57,5 +59,9 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>   			      u64 seq, struct dma_fence **f);
>   bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver *fence_drv);
>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> +			      struct drm_file *filp);
> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> +			    struct drm_file *filp);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index d4317b0f6487..4d3d6777a178 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -457,6 +457,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>       idr_init_base(&userq_mgr->userq_idr, 1);
>       INIT_LIST_HEAD(&userq_mgr->userq_list);
>       userq_mgr->adev = adev;
> +    adev->userq_mgr = userq_mgr;
>   
>       r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>       if (r) {

