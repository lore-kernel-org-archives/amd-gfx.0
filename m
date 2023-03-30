Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A83C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 06:13:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B383810E163;
	Thu, 30 Mar 2023 06:13:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3021110E163
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 06:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enqbkI9JZiPzYRbrl0hSsm5efhNmSZS089Qn7OEFZRZPqV5GpKeQ3XeP8Z9woNMO2X9hQk0w6ueRqZIqV77NNO79jzj+gDC5iQGQnssDDv9+GtnVs01aMRLGuUafWX5B0w3vP0X+E2ySY/0c6FOVGzA+SRhuE9SLiLceHuo76jkuMg0vh8jboBBKjMUFQW749SzjKuuxTcr40Ll18nUsGyJrZiinvuEPBh+6tWq71rdZM2JK1BkD+eIkjZQaXuzbQjnR57DTuTunHajnEVAoMDR3EqWBTCORMXqTXuKJ/W539KfYAMfoFE8zpYExAmRFxVFQ8WvMnf33gdebjcoFhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mc5UIEzhx7triVuDsY8qsf6PejtMiaEM0UyLtvHTOE=;
 b=ZoApb6E4HWmQRJY4i2Mq4nwVU5NPzKhQ3oOhItstP4XWUIf+V6QHtxT5mQV4+mc68G2Zlm6gTu2ZkI96Xzj5WXB04Z0i4CEfF1nVm/69YMobrOrsNyapuj9nqGNAeYbV+Ao0IHdxqRM7ReTmGqQwPmSwTfLetGP97uHzFYYZvTaYrxc+V1wuON2KXwFYplG5oULqGDnrFBm7Ylp1lokkYelil7UgEwpTalNgnSxe3UW2TOsQyKNmCHXh6ps9mzQpTkCbH1dqLGVicjZCFlU4Dv+j0FJ1omWl7iFOJoBv3nih4f7AjoH2i4cWJH5KwZlbqtKl7WU7EBnYsiUUtBdH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mc5UIEzhx7triVuDsY8qsf6PejtMiaEM0UyLtvHTOE=;
 b=FA0Y7rXWQRT/fE/yzAwp278qcI/yS8t28zLYgHO4+C4CQJuLwQ/mEUgvaZpFFcg11tpFjVUS4EwbEgkwc/fluTDxCDaBrAJu2qui2Vsyt81iBc4V3Vx2oXZ21mLpsf0Mf59eE/sAlWfVRdZ+vIK8M9rDVbm4tROYHM72HKNoo4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH0PR12MB5329.namprd12.prod.outlook.com (2603:10b6:610:d4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 06:13:19 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 06:13:19 +0000
Message-ID: <438b86bb-c52f-b07e-81d3-9b012b3c0b20@amd.com>
Date: Thu, 30 Mar 2023 08:13:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
 <CADnq5_PL8sVkpmEff2P03s0PRHsfsqWh1z6GtKZJCR0EDwzdjQ@mail.gmail.com>
 <fafdfdbf-bb51-54ad-7412-5c689ff5c4ce@amd.com>
 <CADnq5_OjMFBDRo4hWPn-OiBH1Dj+YaEQ7RP1qBVktTo+Atrdnw@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OjMFBDRo4hWPn-OiBH1Dj+YaEQ7RP1qBVktTo+Atrdnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH0PR12MB5329:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e292e13-12b4-45f8-6fe8-08db30e5db22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvKQSIkz7zEPfF6xDS2vhgJ8Rp13L8w0t4F2KgDy/Xl/xDjY3LWIZkMPFG9E7336cEtDpWDu/2R4+LHVWhkUk6lU8aoTLRMhTn3jc3BMBfmEIrJRGiA0abmn/cl/ar97cvgM6VpQ11yJ3zDn0MQqfRfA+YZ7LUZ8edAidMvWpOs2wcwmY3q2yJj34tksfxyFzI85hEzaVhXwjeHmlLaRZ0DMrRr1/ekHWV7B4T6ylEtElLfuCSY+rBBtjXLR7ZJScffa5q8QToqyVgtvB+mLBVaFD/A2o/RL7eDddLLeNo2vcne8lelH6XFfyyXFjv+dkWqMqQy8+XvxKqQY7BTIMhAdf73RB7GPK+U7rFtx3rw93Dpv8o5I9QaYHMSfWhj/nOy56lYEI5PasG5xaVxM0LlO0aVIyKPfCGdFOEdQeaUTwVvEf2UH4zrvDF27IfMWtnT0CsM6IIZpY0T9NHJ5tj2kCEIEP4QQ5MS31bK67U870QczLuNvt/BPV4jqJ+iPWWmmoZwHkTdcBtLmaWwVnvaHUl2XCdERR/wL5j5EX07wW0r5HIcWYOY/8YQq6taYhCMpJ4CG3ADO4E9qbh8GNf4q8tW6+5unsUj4xtpJmhdLB7sTE4lX3gb/r4ydtPobR98jpcFeFvvIEUP09CPGHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199021)(2616005)(83380400001)(6506007)(53546011)(6512007)(41300700001)(478600001)(31686004)(6666004)(66556008)(66476007)(316002)(26005)(186003)(8676002)(54906003)(4326008)(66946007)(6916009)(2906002)(38100700002)(5660300002)(44832011)(36756003)(6486002)(86362001)(31696002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndrZUZZdGhJS2phY0gzVndac3hGU25GWS9MV0ZrSlVJN3FlQ3dRUlEvM2t0?=
 =?utf-8?B?WExFbTUva3BCNFFHZmVwbVN5T0NpWXdZZTFmd1daaUl6N05oYjZkaVRrZlk4?=
 =?utf-8?B?M1pxRktJNlhlOXRMcEVBeHorbWJYYU1hOTRlek9JL2RrWnFuZWhzV2FWQXhz?=
 =?utf-8?B?VENBM2Jkb0JvSTgvYm55V3ptM20yaFlKUjM4Sld4aXR4TGVyTjhib2I0Zlp6?=
 =?utf-8?B?NjcvTityd3lEeWZybWFBaExHWlAwV0hyMUlRaXFYMDhPV2VGbTVxNTk5NVZN?=
 =?utf-8?B?SmxmUzQ0bzJrK21rZFJqYlRqU0R1d2xmaDEySmhoZjc5K3c5c2I3Wm9MSURZ?=
 =?utf-8?B?QktEOVlhZFd3b2ZCaVNmalY3eUxDOHMyWGVWemJkdGp5dlB3ZWNQcUJIY3Jy?=
 =?utf-8?B?dDVqdXA3bFBscHU0c083ZDNZaHhybVhINXRhZ0RUWUFpTXBvK3FMbHRCTkp2?=
 =?utf-8?B?K2h5aFhuZjZ2TmR0K0dFTE93SFpseGdKYktGeHFFSE1jYjdwcTI5RC81WGJv?=
 =?utf-8?B?aWswbjFWVys3bkN3VzRTZ205NnlkcFY0SDFaWTNCVXE5Q2JnZ002NXhjOCtR?=
 =?utf-8?B?SGVMRGVva1BmeHp1RUMwWDFBL1RUOC9nblMrekwza3VEZVJoRTdNUUdhK3pl?=
 =?utf-8?B?TnJubFF5eXF0Y1QrbkdXZnlBK0F0ZlhkVE8yYnNiSzNOdks3bXlaaWNpVWR4?=
 =?utf-8?B?UVI5Vlc0M1FhcksyUjNrU1lOQ0hBSjZNQ3QzL1FVUzhab0NWSzVXbGhvejUz?=
 =?utf-8?B?enpSTTdrWjJxejNqbFg0MktxMlgyeDk5NzlGemo2UHlSajlrZXNFMEEzcGph?=
 =?utf-8?B?Z0k0SE5yQ1MwVzVPa3JYZkJUNndWazJBOW1DeXN0UURnNGpSVHJkcFI3OXQr?=
 =?utf-8?B?MjBxLzk1TkFTUUlsM2JWWXQ0bUZLY29NaUczV0kvYzFvaXl6bHU3SGo2N0xv?=
 =?utf-8?B?TjZXNXVMUlVyRmlIditYWkJUdnRRVEx3VStIQ0tYdFJRQ3Vxd1d1YlBQa3RQ?=
 =?utf-8?B?ZUw4MzY1QXZBTWJjMnRWdnpMQ1pyWkcyZ0RjM1RqVjl2QWlxWW05b0dDQTY0?=
 =?utf-8?B?dUVnanoydksrTnRaU2RYcU0xeDRVTEtaOE5NY1FEM2hEU2NpRTQ0VkoyS0JU?=
 =?utf-8?B?dUs5RG9SV1RNNkhZeTRzd2xhL1lQMkduNE9zOG5ZOEc0bW9kUmJiaE9aQ3ph?=
 =?utf-8?B?YlRaSUhZVHRUQld3WnFteWZrTHZGZ1U4clhkR2NZNjFqR0V5b1R3dXBGRTdC?=
 =?utf-8?B?THhQaUFVL08zTm5LYlA3QlNYN3FUYlhUZmVPT1RTTzduYXIvT1NlbEwwdFpq?=
 =?utf-8?B?SENuckh6VzhzV29BdjRxZlMwK3ZvSTlZdm93TXloMDFNNm93ZEhWcWlvUG1Y?=
 =?utf-8?B?Qk83eEkwaVZuc1Eya00zTVVBWVZvaXBOOUR0bHJDcEg1VWdPMGw5eXN3ZEVz?=
 =?utf-8?B?a2huejlSQysrZnNLZVNQWGludWF0WWovb3FsQ1c2UEQ2Ym5Ib0NpdE84R2th?=
 =?utf-8?B?RDAxWjRKRm8xTnNIWDZ1NUNSbUVnQVJxbFM4RERZSm9GN28wTnNURmZUY3pk?=
 =?utf-8?B?VFpyUXRjVkZ3Z1pzUitNclMrSEVaRGNaeHlNZmlUelNSR2VhcE90VXRTWEYw?=
 =?utf-8?B?L0FRNHRXY1BTYnlSR3h4V3ZpTjJzbkVXL3o3cW5OTkdlQXZSdXBOT1JXQWFP?=
 =?utf-8?B?RWl4clc0MU5iZnNXZ3MwOXNCMVVzQ0pIdGxxbUc0UC80dWN4Y1R3TUtaLzdo?=
 =?utf-8?B?UGhKRTY5b2E2QmVCTUJGcmRWNUwyQ0xuQkF6ZENoNENYc1pXRHZFSVViTGdw?=
 =?utf-8?B?Mktab3NLUmtmcGN2SmY3K1Z3SllMV3cxMmtqemxUUUVWcm9qTUtWYmw4dW5Y?=
 =?utf-8?B?c01aaXRTai85MnA0cGlOaHYra2V3d1ZJVWFCUCs3WExMa2tPZXpnOE5tMVo5?=
 =?utf-8?B?d24yRk9mNWlQNHd6YTNvRGRrMDc2R2RtdEpuSFRaaXZSa1lOQkVGczRIbGh0?=
 =?utf-8?B?NVV2UGhZSnR6SFBLT3hZWWVYVHFiaEtQY1NZQk1aK0NMS0ltSnFFNDBxWWpQ?=
 =?utf-8?B?SDNJR1FpdEw5NHdsZlVJU3E1Zmw2em4wWldpcDI2ZnQrdGlwS05DQ3BQVWhZ?=
 =?utf-8?Q?yNZ2ExkEAz+lmqjd3qnAGYm2x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e292e13-12b4-45f8-6fe8-08db30e5db22
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 06:13:18.8655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJSoCXVAvhFNBNbwgz6kGWZoeJootrI0D/1qouJpXSGZmEmhbJdx914HM+6tACbWWvrAeDvaknbN86jBfX1Qow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5329
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 29/03/2023 21:46, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 3:21 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> Hey Alex,
>>
>> On 29/03/2023 19:57, Alex Deucher wrote:
>>> On Wed, Mar 29, 2023 at 12:05 PM Shashank Sharma
>>> <shashank.sharma@amd.com> wrote:
>>>> From: Alex Deucher <alexander.deucher@amd.com>
>>>>
>>>> This patch intorduces new UAPI/IOCTL for usermode graphics
>>>> queue. The userspace app will fill this structure and request
>>>> the graphics driver to add a graphics work queue for it. The
>>>> output of this UAPI is a queue id.
>>>>
>>>> This UAPI maps the queue into GPU, so the graphics app can start
>>>> submitting work to the queue as soon as the call returns.
>>>>
>>>> V2: Addressed review comments from Alex and Christian
>>>>       - Make the doorbell offset's comment clearer
>>>>       - Change the output parameter name to queue_id
>>>> V3: Integration with doorbell manager
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 55 insertions(+)
>>>>
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>> index cc5d551abda5..e4943099b9d2 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -54,6 +54,7 @@ extern "C" {
>>>>    #define DRM_AMDGPU_VM                  0x13
>>>>    #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>>>    #define DRM_AMDGPU_SCHED               0x15
>>>> +#define DRM_AMDGPU_USERQ               0x16
>>>>
>>>>    #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>>>    #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>>>> @@ -71,6 +72,7 @@ extern "C" {
>>>>    #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>>>    #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>>>    #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>>>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>>>
>>>>    /**
>>>>     * DOC: memory domains
>>>> @@ -307,6 +309,59 @@ union drm_amdgpu_ctx {
>>>>           union drm_amdgpu_ctx_out out;
>>>>    };
>>>>
>>>> +/* user queue IOCTL */
>>>> +#define AMDGPU_USERQ_OP_CREATE 1
>>>> +#define AMDGPU_USERQ_OP_FREE   2
>>>> +
>>>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>>>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>>>> +
>>>> +struct drm_amdgpu_userq_mqd {
>>>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>>>> +       __u32   flags;
>>>> +       /** IP type: AMDGPU_HW_IP_* */
>>>> +       __u32   ip_type;
>>>> +       /** GEM object handle */
>>>> +       __u32   doorbell_handle;
>>>> +       /** Doorbell's offset in the doorbell bo */
>>>> +       __u32   doorbell_offset;
>>>> +       /** GPU virtual address of the queue */
>>>> +       __u64   queue_va;
>>>> +       /** Size of the queue in bytes */
>>>> +       __u64   queue_size;
>>>> +       /** GPU virtual address of the rptr */
>>>> +       __u64   rptr_va;
>>>> +       /** GPU virtual address of the wptr */
>>>> +       __u64   wptr_va;
>>>> +       /** GPU virtual address of the shadow context space */
>>>> +       __u64   shadow_va;
>>>> +};
>>> We may want to make the MQD engine specific.  E.g., shadow is gfx
>>> specific.  We also probably need the csa and gds buffers for gfx as
>>> well.  Other engines may have their own additional buffer
>>> requirements.
>>>
>>> Alex
>> Sure, we can call it drm_amdgpu_userq_mqd_gfx to clarify that this MQD
>> is specific to GFX engine.
> We can make it a union and then add additional entries for SDMA,
> compute, and VCN.  We should also move the IP type into struct
> drm_amdgpu_userq_in so we know how to interpret the union.

I was exactly thinking to do this :), it would be a small change.

Please have a look at rest of the series as well considering this done.

- Shashank

>    Or make it
> a u64 and handle it similarly to the chunks interface in
> drm_amdgpu_cs_chunk.
> Alex
>
>> - Shashank
>>
>>>
>>>> +
>>>> +struct drm_amdgpu_userq_in {
>>>> +       /** AMDGPU_USERQ_OP_* */
>>>> +       __u32   op;
>>>> +       /** Flags */
>>>> +       __u32   flags;
>>>> +       /** Queue handle to associate the queue free call with,
>>>> +        * unused for queue create calls */
>>>> +       __u32   queue_id;
>>>> +       __u32   pad;
>>>> +       /** Queue descriptor */
>>>> +       struct drm_amdgpu_userq_mqd mqd;
>>>> +};
>>>> +
>>>> +struct drm_amdgpu_userq_out {
>>>> +       /** Queue handle */
>>>> +       __u32   queue_id;
>>>> +       /** Flags */
>>>> +       __u32   flags;
>>>> +};
>>>> +
>>>> +union drm_amdgpu_userq {
>>>> +       struct drm_amdgpu_userq_in in;
>>>> +       struct drm_amdgpu_userq_out out;
>>>> +};
>>>> +
>>>>    /* vm ioctl */
>>>>    #define AMDGPU_VM_OP_RESERVE_VMID      1
>>>>    #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>>>> --
>>>> 2.40.0
>>>>
