Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B57DC64ED8
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 13:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E65810E208;
	Mon, 27 Feb 2023 13:24:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E89510E208
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 13:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRuF33RQ7FZqAQnRBFNZQVZBIq/3Ux2n9+3we/gLmUKn5Uq/Hjc9GIzF8TI+ZhzWqOmTfA6kfH7Oif8KnwulRNjColCk2+VhpD/gQ+DvYL86lABAyvOIHMTFTqbUoNzPslBAeEzaeFC2v8Cubr5RP/TV1zvPSYvXAIKEOA5g3EvreV9QxI0wK69vg87KI2XxBjMbZvoBHx5VEQspSFd+LE596LWICtvg8O1LJ31Zli6x74vhvALALq12rtETOHGHXfi2JeaLR84zFI2s5EUomfXXivx4FX5V9P+GTS561ehsjTVlY9OP4cCJRoguwgI/2v1jD9palLkgKcQyvi9BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97i4Sm5kGPo1nH0fayVC/vRV4dyMVdPtQo78wyhQO7g=;
 b=FPpsFQS0Wf0zf0UbX5uHgh39cHgTUudnN+LKInbfR8ANOPIqIhh9Xs+IGLvY9J7PjNYDHHqDW1bsY8K9dIliSyTo9DiE+sYv6amCa9cgc0tEWdAnh8Kppfj+0ewzYPukbbP1Zn+vpZaH94iMPjruMNGo3sBCVJcaPvYaZq+pvOwlIfLVSNDKkkREUE1y0RNq/glnYRNTCFIShcqazCFfP/cDewv6Bn1UOkk2E/N1GORoeJ4Kh8e0OmV8giV1ADs5HbjJFgtbZJsledfl3nffXxdsG19ArWkxNHZ+u8LSBCKN36LBH0AAJyIDXDBBNZbtQ6ksyjqYoOR+U83tb0jc/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97i4Sm5kGPo1nH0fayVC/vRV4dyMVdPtQo78wyhQO7g=;
 b=4obdqrojfl5Tf3QPsvq6gcFS/SAAySkldZvvG7dedvZtbpcbCoPgDpTDcpLjAR28ylRXutv2LZb88mbmjXA6AmGEqNjtisYVcJGvCnZQxXYxxAKhPK2SK5Q9G+ez9JgG+gUqlv4hiWXWV9qXCAw5BKJAzC+/JJZaogA2K/dpOQ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Mon, 27 Feb
 2023 13:24:00 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 13:24:00 +0000
Message-ID: <cd379750-a977-4ecd-af47-8f72c40b44c1@amd.com>
Date: Mon, 27 Feb 2023 14:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/6] drm/amdgpu: Implement userqueue signal/wait IOCTL
 functions
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
 <20230226165435.41641-6-Arunpravin.PaneerSelvam@amd.com>
 <62177dac-97b0-2d85-fdff-92b7f1851ac8@amd.com>
 <4a76b004-6ce2-e540-8d14-cc0653cea421@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <4a76b004-6ce2-e540-8d14-cc0653cea421@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: fea791e9-fd94-4109-0c1a-08db18c5e312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rNgibVD8+WhyR5bV/mn7cQPb8ccskAs24abDJKbHs9yD2RbUHfHFdrrzWV0sDsbtbveADAryy6oEtZPRHuQirWAyoL7klw5Lea8GWofRpOtc7ZeQhiNXEuppoX9Q3fLvOZiK6zCMd/ChlAUu1jse6bBDctL+uLMCbrudwraJoDVVpb9EpGJcrZYCpPNplcHmhdJ6Nze20my+8f1whURlulN54+x0QjOVSwd9aXgdNEYJH0+eGDI0FLCEpQfNGb2Sn3WpzzUWkk+qhhv3FIdu0AKN7YFj6OscM3ojVT8GY+Sa0o5VKQaKjptadY5nK98PKiGSBfJMlUAzm6XXwaLgkKzqomKO7Ft8dJospm5tnYa80+y9H1ZZmi/28N0vAqOW1OCtD5cWen3a9B8dhcVevBPvh/hC0arVgcjvEXh6Uzf1wPq0RzB7HDgspMi+tiKRDSS9HYH/X0eEowBm32LJ8EYiyfNURGufnuNFr8t7ryk7zseCyspPhtmhm2ii/mN4sSg2H9GbjVk7FCzunl3p0f2NzrRUPLVl2bzgBjFkxczJAlk/LqkUqb6u2JDIlCQsUQk4hR+pRfWtNmYSmhtK6rgh66THpuUpP6sjyHb++qbBOApPJp5OmL5sQwm0LEXRUwovE7XWf58iyCxnAXSDd+PBn9kiQ0y4ppBYRMHPUge0J3oSWejxK9wGmT+HvQjAMAnb0nViMfblEkhHkoJFJquhelO4Z6SBSEAfT76BnWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(186003)(38100700002)(83380400001)(316002)(8936002)(8676002)(66946007)(4326008)(66476007)(2906002)(41300700001)(66556008)(53546011)(478600001)(6506007)(66574015)(6666004)(6512007)(26005)(2616005)(5660300002)(6486002)(36756003)(86362001)(31696002)(30864003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUoyamxSelJGRzZEOGtCbXZDbnNsemV4cnhUWlBHNHNXN0l0b1VCeE11Rmxy?=
 =?utf-8?B?cGlHUEtmazdEWlJNUEhVQ1R5Um42WURsWW8xSXVEV1pTdFkrTHQ3RmllWHdz?=
 =?utf-8?B?Z3RwZUt0RC9la2M5M3YyWXY3TlUvWVR0R05MQmdLcjFJZG9FbUx0ek9BTFhD?=
 =?utf-8?B?V0k2WlFQZjlNS1dTWEdZdk52N1ZsQVhlTHlvWmU1S1daaFZMNjdycVphYlpy?=
 =?utf-8?B?VVJreXdNcHBqVW81ZUFKN1pnZGlFc1plVStYTHo1TE9BNzFZSFZJVm1SeEQv?=
 =?utf-8?B?VE0xS0JaZkZnckZEM1g4amIwSzJzY2Nqa3R5bWI2ZVlLc3g1Y2E2aGRXNFg0?=
 =?utf-8?B?SFJNTm03aCtpa2tTMkJBdzNxRjJiMXBCY1RRQlpZQ3A2U2x3Tk1nd3B0eEp4?=
 =?utf-8?B?UEhLa0k5RjVQeXlGZzdPZlREcmxGSGlBOW9Bb1IwU1IxVDlBMVhzU2hNemh2?=
 =?utf-8?B?Qy9xUnE3OFFTS09mVHJOV0hUSjRaNmtRMm9OQjhuc3locFRvUUNpeDBYNFRY?=
 =?utf-8?B?YkVVc2hXa3R5anM0TmFTbWdYcUJhWlh5MURLZGJsL0d1UU9uU2U5dXJrVGo3?=
 =?utf-8?B?Wm9CMnVWK3hQRjg5MVZtWGtzVXpSSXZSRGJOWnE5N3VmcmJHNXZHMzJreTYz?=
 =?utf-8?B?a05GdTJXVk9UVHFpbnV0UCtRYnNSQUN0YUxtWC9uYmNTV2JNOGpQalJSSkJX?=
 =?utf-8?B?TGlmdHp2SUJ6QjQxU2FzNldieGY5eE9EU2VhS1A5UWtHVHhseGJYdk1CVDhH?=
 =?utf-8?B?VVQrY0ZVMXRHTzJKY3RWbnRkODIrSWhmUWtjTGgyL2UvYnV0aTJmaERJSmRR?=
 =?utf-8?B?YXJsd21lYXRoYVE0MG8vOU9SSlpsWVIraXA2bGphbEYrQzhKWXZxMzJIc0FB?=
 =?utf-8?B?Umo1KzVMMDIxUmRsb3JxcTBiQUdRbXB2MlBiTFFjU3ZSREd0V2c3Yk1XbS9w?=
 =?utf-8?B?ZTJuV3d2TUtuenIrckNDTklHOVpseUhpN0R2Nk5oWGlzc1duNkZmYmRFMFEz?=
 =?utf-8?B?NHNETFZMSnc0VE5xU2wzQmJpMFFsc1EyWENBaFJjdjg1OVVOTG1ZbmhxR1Q1?=
 =?utf-8?B?NEk2VThUcGNleDZhVjR4YXZPMS9NVDlNalNJdnZqRkJ5bzFFdm85NTFvVXcr?=
 =?utf-8?B?a1hoUUJ2MHRSeEkrdU5JUXlZU0JxQS9WSko5Yi94VTlXUEhwR05hVjE3blJu?=
 =?utf-8?B?Sk54Und3S1BsNEhxUUZJWDRlMlRtcDIwS2NFVUNZTFVqYUEvYkpQUVJpaUM2?=
 =?utf-8?B?em1DNStJNjZjc2NpVFZPWXNGT0xXRVBmSTBSMCsxREFtNm11QUE4RGZwQ1R1?=
 =?utf-8?B?TkF5MFdpNGdnSlM2d3pnbUxNaTVEeFQ4cERMd0lud3VIaG1IaEZrOW5NY3lN?=
 =?utf-8?B?cDhqOUVuQWx2M2liNG1PNDJqQ0FKMDF5c3drUzYyZmZJVElDUWNPVGN1cVRw?=
 =?utf-8?B?OGZrK1J3aFB1T1FvTUdsRGtxblI4eGZsZkN2N3o4ZFZuTE0vSHdXMlNTdDZR?=
 =?utf-8?B?NnZKME05M08zZVVvMG9ta0hwMjBxc1BEbWVsZnlxdjBxek1Pb3Q0Ymg2STRG?=
 =?utf-8?B?ekx3WUw0eG11RGlLSTUzTURHTUNwZEVnUGZJVTJkYXN1dmdoWjdRdEs3WDJI?=
 =?utf-8?B?cVhzNFNLVDZzT3MzdTIxMi9TTkNXK3g3SGRML0UvUWtwYUhjZmg1OWNUMW1t?=
 =?utf-8?B?bmhMSnJZMmJ3U1Qwa2hHTCtBTlRNUU9TRENwbU5QNnlJcVBzT1g3RWpsRGJt?=
 =?utf-8?B?amVVTTZzeTVtMW9kMVdFZklDWE9JN3E4L2dNYm9vYW1kck1zaWhuT2FkQVRr?=
 =?utf-8?B?K1MwNWkvcmxPQ1g3UFJxcWJXNENDOFkyOHBSRHcvM2lJUXE3Ymw0dUpORnJM?=
 =?utf-8?B?YjVpQTdSb1RhTlJGMzI1bEEyN214Zmc4ZkxvaElTWG0zY0ZiUW56cmR1UEQ3?=
 =?utf-8?B?RnFTL0psQ1lhc2ZYbU9GOHlGUjZPdjEvTG9yMWpHdnFBcjN0VGVEVm5rUFlQ?=
 =?utf-8?B?RzlQSnhJbGRjMkdZTmlVM3FBVWh5Vkd5bktoVU9ZYTlNRWhKUjZ5T1pUUUdL?=
 =?utf-8?B?OElxMkt4R01STnVnL2wzQnFPQkNFb3BZeDl1YXpEZlRDcWZVUUIxdHdGL1Uw?=
 =?utf-8?Q?n/Ag6QIU2+0HDd1S3V2dov4v4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea791e9-fd94-4109-0c1a-08db18c5e312
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 13:24:00.2166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvfO3dEmxW09NN49aTTiiZ1ddX1p2XF3Hd2ObcmwuPgHA9OJhwsCg/AtgTU8QA9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
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

Hi Arun,

Am 27.02.23 um 14:20 schrieb Arunpravin Paneer Selvam:
> Hi Christian,
>
>
> On 2/27/2023 6:29 PM, Christian König wrote:
>> Am 26.02.23 um 17:54 schrieb Arunpravin Paneer Selvam:
>>> This patch introduces new IOCTL for userqueue secure semaphore.
>>>
>>> The signal IOCTL called from userspace application creates a drm
>>> syncobj and array of bo GEM handles and passed in as parameter to
>>> the driver to install the fence into it.
>>>
>>> The wait IOCTL gets an array of drm syncobjs, finds the fences
>>> attached to the drm syncobjs and obtain the array of
>>> memory_address/fence_value combintion which are returned to
>>> userspace.
>>>
>>> v2: Worked on review comments from Christian for the following
>>>      modifications
>>>
>>>      - Install fence into GEM BO object.
>>>      - Lock all BO's using the dma resv subsystem
>>>      - Reorder the sequence in signal IOCTL function.
>>>      - Get write pointer from the shadow wptr
>>>      - use userq_fence to fetch the va/value in wait IOCTL.
>>>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   3 +
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 258 
>>> ++++++++++++++++++
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |   6 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |   1 +
>>>   5 files changed, 270 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 1c3eba2d0390..255d73795493 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -964,6 +964,8 @@ struct amdgpu_device {
>>>       struct amdgpu_mes               mes;
>>>       struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>>>   +    struct amdgpu_userq_mgr         *userq_mgr;
>>> +
>>>       /* df */
>>>       struct amdgpu_df                df;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 6b7ac1ebd04c..66a7304fabe3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2752,6 +2752,9 @@ const struct drm_ioctl_desc 
>>> amdgpu_ioctls_kms[] = {
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, 
>>> amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, 
>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>>       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_DOORBELL_RING, 
>>> amdgpu_userq_doorbell_ring_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, 
>>> amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>>> +    DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, 
>>> DRM_AUTH|DRM_RENDER_ALLOW),
>>> +
>>>   };
>>>     static const struct drm_driver amdgpu_kms_driver = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 609a7328e9a6..26fd1d4f758a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -249,3 +249,261 @@ static const struct dma_fence_ops 
>>> amdgpu_userq_fence_ops = {
>>>       .signaled = amdgpu_userq_fence_signaled,
>>>       .release = amdgpu_userq_fence_release,
>>>   };
>>> +
>>> +static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
>>> +                    struct amdgpu_usermode_queue *queue,
>>> +                    u64 *wptr)
>>> +{
>>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>> +    struct amdgpu_bo_va_mapping *mapping;
>>> +    struct amdgpu_vm *vm = &fpriv->vm;
>>> +    struct amdgpu_bo *bo;
>>> +    u64 *ptr;
>>> +    int r;
>>> +
>>> +    mapping = amdgpu_vm_bo_lookup_mapping(vm, queue->wptr_gpu_addr 
>>> >> PAGE_SHIFT);
>>> +    if (!mapping)
>>> +        return -EINVAL;
>>> +
>>> +    bo = mapping->bo_va->base.bo;
>>> +    r = amdgpu_bo_kmap(bo, (void **)&ptr);
>>
>> Oh, that's not something you can do that easily.
>>
>> The BO must be reserved (locked) first if you want to call 
>> amdgpu_bo_kmap() on it.
> sure, I will take care
>>
>>> +    if (r) {
>>> +        DRM_ERROR("Failed mapping the userqueue wptr bo");
>>> +        return r;
>>> +    }
>>> +
>>> +    *wptr = le64_to_cpu(*ptr);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>> +                  struct drm_file *filp)
>>> +{
>>> +    struct drm_amdgpu_userq_signal *args = data;
>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>> +    struct amdgpu_userq_mgr *userq_mgr = adev->userq_mgr;
>>> +    struct amdgpu_usermode_queue *queue;
>>> +    struct drm_syncobj *syncobj = NULL;
>>> +    struct drm_gem_object **gobj;
>>> +    u64 num_bo_handles, wptr;
>>> +    struct dma_fence *fence;
>>> +    u32 *bo_handles;
>>> +    bool shared;
>>> +    int r, i;
>>> +
>>> +    /* Retrieve the user queue */
>>> +    queue = idr_find(&userq_mgr->userq_idr, args->queue_id);
>>> +    if (!queue)
>>> +        return -ENOENT;
>>> +
>>> +    r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
>>> +    if (r)
>>> +        return -EINVAL;
>>> +
>>> +    /* Find Syncobj if any */
>>> +    syncobj = drm_syncobj_find(filp, args->handle);
>>> +
>>> +    /* Array of bo handles */
>>> +    num_bo_handles = args->num_bo_handles;
>>> +    bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), 
>>> GFP_KERNEL);
>>> +    if (bo_handles == NULL)
>>> +        return -ENOMEM;
>>> +
>>> +    if (copy_from_user(bo_handles, 
>>> u64_to_user_ptr(args->bo_handles_array),
>>> +               sizeof(u32) * num_bo_handles)) {
>>> +        r = -EFAULT;
>>> +        goto err_free_handles;
>>> +    }
>>> +
>>> +    /* Array of GEM object handles */
>>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>>> +    if (gobj == NULL) {
>>> +        r = -ENOMEM;
>>> +        goto err_free_handles;
>>> +    }
>>> +
>>> +    for (i = 0; i < num_bo_handles; i++) {
>>> +        /* Retrieve GEM object */
>>> +        gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
>>> +        if (!gobj[i]) {
>>> +            r = -ENOENT;
>>> +            goto err_put_gobj;
>>> +        }
>>> +
>>> +        dma_resv_lock(gobj[i]->resv, NULL);
>>> +        r = dma_resv_reserve_fences(gobj[i]->resv, 1);
> I am reserving place for each BO here, should we move this down?

See below.

>
> Thanks,
> Arun
>>> +        if (r) {
>>> +            dma_resv_unlock(gobj[i]->resv);
>>> +            goto err_put_gobj;
>>> +        }
>>> +        dma_resv_unlock(gobj[i]->resv);

The problem is here. You can't unlock the BO after you reserved the 
fence slot or the reservation is dropped again. What you need to do is 
to lock all BOs first and then reserve the fence slot.

I've coded together a drm_exec helper to make that simple a while ago, 
but never found the time to upstream it. Give me a day or so to rebase 
the code.

Regards,
Christian.

>>> +    }
>>> +
>>> +    /* Create a new fence */
>>> +    r = amdgpu_userq_fence_create(queue, wptr, &fence);
>>> +    if (!fence)
>>> +        goto err_put_gobj;
>>> +
>>> +    /* Add the created fence to syncobj/BO's */
>>> +    if (syncobj)
>>> +        drm_syncobj_replace_fence(syncobj, fence);
>>> +
>>> +    shared = args->bo_flags & AMDGPU_USERQ_BO_READ;
>>> +    for (i = 0; i < num_bo_handles; i++) {
>>> +        dma_resv_lock(gobj[i]->resv, NULL);
>>> +        dma_resv_add_fence(gobj[i]->resv, fence, shared ?
>>> +                   DMA_RESV_USAGE_READ :
>>> +                   DMA_RESV_USAGE_WRITE);
>>> +        dma_resv_unlock(gobj[i]->resv);
>>> +    }
>>
>> That will still not work correctly. You've forgotten to call 
>> dma_resv_reserve_fences().
>>
>> The tricky part is that you need to do this for all BOs at the same 
>> time.
>>
>> I will work on my drm_exec() patch set once more. That one should 
>> make this job much easier.
>>
>> Similar applies to the _wait function, but let's get _signal working 
>> first.
>>
>> Regards,
>> Christian.
>>
>>> +
>>> +    for (i = 0; i < num_bo_handles; i++)
>>> +        drm_gem_object_put(gobj[i]);
>>> +
>>> +    dma_fence_put(fence);
>>> +
>>> +    /* Free all handles */
>>> +    kfree(bo_handles);
>>> +    kfree(gobj);
>>> +
>>> +    return 0;
>>> +
>>> +err_put_gobj:
>>> +    while (i-- > 0)
>>> +        drm_gem_object_put(gobj[i]);
>>> +    kfree(gobj);
>>> +err_free_handles:
>>> +    kfree(bo_handles);
>>> +
>>> +    return r;
>>> +}
>>> +
>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>> +                struct drm_file *filp)
>>> +{
>>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>> +    struct drm_amdgpu_userq_wait *args = data;
>>> +    struct amdgpu_userq_fence *userq_fence;
>>> +    u32 *syncobj_handles, *bo_handles;
>>> +    u64 num_syncobj, num_bo_handles;
>>> +    struct drm_gem_object **gobj;
>>> +    struct dma_fence *fence;
>>> +    bool wait_flag;
>>> +    int r, i, tmp;
>>> +
>>> +    /* Array of Syncobj handles */
>>> +    num_syncobj = args->count_handles;
>>> +    syncobj_handles = kmalloc_array(num_syncobj, 
>>> sizeof(*syncobj_handles), GFP_KERNEL);
>>> +    if (!syncobj_handles)
>>> +        return -ENOMEM;
>>> +
>>> +    if (copy_from_user(syncobj_handles, 
>>> u64_to_user_ptr(args->handles),
>>> +               sizeof(u32) * num_syncobj)) {
>>> +        r = -EFAULT;
>>> +        goto err_free_syncobj_handles;
>>> +    }
>>> +
>>> +    /* Array of bo handles */
>>> +    num_bo_handles = args->num_bo_handles;
>>> +    bo_handles = kmalloc_array(num_bo_handles, sizeof(*bo_handles), 
>>> GFP_KERNEL);
>>> +    if (!bo_handles)
>>> +        goto err_free_syncobj_handles;
>>> +
>>> +    if (copy_from_user(bo_handles, 
>>> u64_to_user_ptr(args->bo_handles_array),
>>> +               sizeof(u32) * num_bo_handles)) {
>>> +        r = -EFAULT;
>>> +        goto err_free_bo_handles;
>>> +    }
>>> +
>>> +    /* Array of fence gpu address */
>>> +    fence_info = kmalloc_array(num_syncobj + num_bo_handles, 
>>> sizeof(*fence_info), GFP_KERNEL);
>>> +    if (!fence_info) {
>>> +        r = -ENOMEM;
>>> +        goto err_free_bo_handles;
>>> +    }
>>> +
>>> +    /* Retrieve syncobj's fence */
>>> +    for (i = 0; i < num_syncobj; i++) {
>>> +        r = drm_syncobj_find_fence(filp, syncobj_handles[i], 0, 0, 
>>> &fence);
>>> +        if (r) {
>>> +            DRM_ERROR("syncobj %u failed to find the fence!\n", 
>>> syncobj_handles[i]);
>>> +            r = -ENOENT;
>>> +            goto err_free_fence_info;
>>> +        }
>>> +
>>> +        /* Store drm syncobj's gpu va address and value */
>>> +        userq_fence = to_amdgpu_userq_fence(fence);
>>> +        fence_info[i].va = userq_fence->fence_drv->gpu_addr;
>>> +        fence_info[i].value = fence->seqno;
>>> +        dma_fence_put(fence);
>>> +    }
>>> +
>>> +    tmp = i;
>>> +
>>> +    /* Array of GEM object handles */
>>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>>> +    if (gobj == NULL) {
>>> +        r = -ENOMEM;
>>> +        goto err_free_fence_info;
>>> +    }
>>> +
>>> +    /* Retrieve GEM objects's fence */
>>> +    wait_flag = args->bo_wait_flags & AMDGPU_USERQ_BO_READ;
>>> +    for (i = 0; i < num_bo_handles; i++, tmp++) {
>>> +        struct dma_fence *bo_fence;
>>> +
>>> +        gobj[i] = drm_gem_object_lookup(filp, bo_handles[i]);
>>> +        if (!gobj[i]) {
>>> +            r = -ENOENT;
>>> +            goto err_put_gobj;
>>> +        }
>>> +
>>> +        dma_resv_lock(gobj[i]->resv, NULL);
>>> +        r = dma_resv_get_singleton(gobj[i]->resv,
>>> +                       wait_flag ?
>>> +                       DMA_RESV_USAGE_READ :
>>> +                       DMA_RESV_USAGE_WRITE,
>>> +                       &bo_fence);
>>> +        if (r) {
>>> +            dma_resv_unlock(gobj[i]->resv);
>>> +            goto err_put_gobj;
>>> +        }
>>> +        dma_resv_unlock(gobj[i]->resv);
>>> +        drm_gem_object_put(gobj[i]);
>>> +
>>> +        /* Store GEM objects's gpu va address and value */
>>> +        userq_fence = to_amdgpu_userq_fence(bo_fence);
>>> +        fence_info[tmp].va = userq_fence->fence_drv->gpu_addr;
>>> +        fence_info[tmp].value = bo_fence->seqno;
>>> +        dma_fence_put(bo_fence);
>>> +    }
>>> +
>>> +    if (copy_to_user(u64_to_user_ptr(args->userq_fence_info),
>>> +        fence_info, sizeof(fence_info))) {
>>> +        r = -EFAULT;
>>> +        goto err_free_gobj;
>>> +    }
>>> +
>>> +    /* Free all handles */
>>> +    kfree(syncobj_handles);
>>> +    kfree(bo_handles);
>>> +    kfree(fence_info);
>>> +    kfree(gobj);
>>> +
>>> +    return 0;
>>> +
>>> +err_put_gobj:
>>> +    while (i-- > 0)
>>> +        drm_gem_object_put(gobj[i]);
>>> +err_free_gobj:
>>> +    kfree(gobj);
>>> +err_free_fence_info:
>>> +    kfree(fence_info);
>>> +err_free_bo_handles:
>>> +    kfree(bo_handles);
>>> +err_free_syncobj_handles:
>>> +    kfree(syncobj_handles);
>>> +
>>> +    return r;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> index 230dd54b4cd3..999d1e2baff5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>> @@ -27,6 +27,8 @@
>>>     #include <linux/types.h>
>>>   +#define AMDGPU_USERQ_BO_READ    0x1
>>> +
>>>   struct amdgpu_userq_fence {
>>>       struct dma_fence base;
>>>       /* userq fence lock */
>>> @@ -57,5 +59,9 @@ int amdgpu_userq_fence_create(struct 
>>> amdgpu_usermode_queue *userq,
>>>                     u64 seq, struct dma_fence **f);
>>>   bool amdgpu_userq_fence_process(struct amdgpu_userq_fence_driver 
>>> *fence_drv);
>>>   void amdgpu_userq_fence_driver_destroy(struct kref *ref);
>>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>> +                  struct drm_file *filp);
>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>> +                struct drm_file *filp);
>>>     #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index d4317b0f6487..4d3d6777a178 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -457,6 +457,7 @@ int amdgpu_userq_mgr_init(struct 
>>> amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>>       INIT_LIST_HEAD(&userq_mgr->userq_list);
>>>       userq_mgr->adev = adev;
>>> +    adev->userq_mgr = userq_mgr;
>>>         r = amdgpu_userqueue_setup_mqd_funcs(userq_mgr);
>>>       if (r) {
>>
>

