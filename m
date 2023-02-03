Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE14C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 22:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B27DF10E11B;
	Fri,  3 Feb 2023 22:26:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4DF10E11B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 22:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jc3nmykD+A2HMHsMSb9RR5MG01riGyaSf3LamJ8aTiBIStIGQ8/InZaZDfGSimm3S45qy/cE2bYC8zca8Sbn12uImVN9BHLpqh2UgO3bb2627BYZ0ZkevHb8MGz78lzCFDZdYb/7UB12h3MpudbMudjI+dp1OVq9JxGlZGRLBU/Iub/DLGu0odoDA9UA+4LUnIWovL485upOmPcnU0gN5cfXXwUH9Uwf9oxZ1hk+EGZ99KV6zwA84IJhtPTj+VgxjqZvCOeKPRjdpUjfawk6CXW1ib/WbyFL4q+L3u0Z8CA72u21UDgSKCKx4l4KvFQQFgxbQIvqaGZJn+xydRFmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHdkU4OfI8b2wbNX7nGD6KoTlTkbZbBboZ/QaAtpSgQ=;
 b=ECQM10j3Tune4y6VxAuwNb8oGj2Ax1Pf3eB3kmvewy45MaSQLnp+jKCqw6rxHjI57ugtF1VqC4a2m3nN0E33jp9NYc07x3cy5daPmI4VLTQrrIuoNxhBck8zHYWcW6Vlw+TUkaQJwhQOvwvaDspUnUFFU2aLZ38ApjgX/sF2dKFnovCrkil967oxINwcvGw4J6NpEPGohBaghFGNihqsWF+OkJDIszwR4rbtdrAJCeoq3ZFVIduok5fLDu8r03ws4sl38MPWXNhT2Ckifjmg8Uahh/W1zyxh7w3+SXFSknKDh6/0/Efiysdbifmz9RN9+UrtT2MiMbkgSOpsNWnSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHdkU4OfI8b2wbNX7nGD6KoTlTkbZbBboZ/QaAtpSgQ=;
 b=sbOwNbcV9o0lVebcWi6M/EqFJQk2zMi+nB9HntKjNRlLg9u9zXbHm7aMZY7Dax0nEYkyAFecgPamRH3MzY8VJnxF1wWjwYrK+7EJvycmiBaOmfAvbDXOltnmdXbqOGPeSPvSZtNkGPC18okPvnlQ+ye/WQjssHwFJ/JhsK3Q3o4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by IA1PR12MB7493.namprd12.prod.outlook.com (2603:10b6:208:41b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Fri, 3 Feb
 2023 22:26:48 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%7]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 22:26:47 +0000
Message-ID: <95ac9ea3-47c8-744c-7fd7-ddc54b19926f@amd.com>
Date: Fri, 3 Feb 2023 23:26:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] drm/amdgpu: UAPI for user queue management
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-2-shashank.sharma@amd.com>
 <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_MSMivTzo0k+wJj+bGpsQZ3HEDVt5XqzjGdBiv08fFWCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|IA1PR12MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b89ff9d-4715-4654-58e4-08db0635bc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1ECR3p493s9eCeRcSFXtjqnXd3Pbar30EywJKAFNWaTWUm5WachVZnae4OMU7W8MqWi8P6PGfnb5QH3mnh1Hmm7W4X7uSHpkktbFIsMmy6T3mD9eJxNDMtXu7Fe9F+vdAWhQ98K1MCdVe3ych4hH/ogxlQ/nhg0oopRb7WIEC1saV62fZaFXgWOslH8zNf0/4in4kEhnIhb3mmR11Dp/8yHFo/wVtnyrvTuroC9F8EABwaCPs0h0pHWTy9O5ifI5LsrLZVqUliTc9xk5NSto8moYEjm3e0gqq/8SaZbAjIIul/+HhVT+Y8dg+d0U6vq5ia13ZGybsfqrZlTG8UELbwxYuOQ0qF8w5SBQtRKoSSxx/V58yEWd/1CsNB8u213zCo5vzIhi8j3bFPOdzr5mloTdOCulTosrq/dMR0LafQxLBEMy6n1NxxEvyxM8mxi5x00zR1vkcYDLR3DsPxYDIMhwnhdwVsAqYhNS/pqTCUgr+Cycg56KI2YO6D2F5VGNAAQfgrK5goox+CczyWBFL6JDG3eRA/j1XzYoarb+8aH2v0ILgaYTXfij88hbqdpN0HMaOEk3+nS44tpP5x1VFP1vVw6a8g/PgQk46h733ggnEd3x65I9+7+GN/IaknL67ZmnR5MZnBuBsmAsHoPuMbC53QcazcgMO1bWLSOt/n0ylg6uhEAuzrKP5qTMCvcTVQpP5F1s0FrLTh1qhJKplGYtyy6KURdqMU2tEADOHco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199018)(4326008)(44832011)(6666004)(2616005)(316002)(6506007)(66946007)(66556008)(31696002)(53546011)(86362001)(2906002)(83380400001)(38100700002)(8676002)(5660300002)(66476007)(41300700001)(478600001)(8936002)(36756003)(186003)(6512007)(26005)(6916009)(31686004)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNMOGNkVmtJemsvWnUwdFB4Z0R5KzdsaDBzaUNFa0JnZFhvMzFKcGZmYkl1?=
 =?utf-8?B?dXZORkRmdERocXNxc3I4SU93ZitNckJzY2FpMWF1d3I3d2sybGlBVXA1VGdZ?=
 =?utf-8?B?R2ZGenhOZmg1dE5rZHkxOUd0STBvc1dQampBUU80SThBaTBST0NwTEJFVVBO?=
 =?utf-8?B?NmhwMWdiSmNIek5rbzc3MDRZSjF2NnNDNmZoN1QvNzV2SlF0Smt1bHg3cmY3?=
 =?utf-8?B?bUpzQUlBbmVvNXNKemFSb2gwTTZZcVVYWEFIZm92NjVwd0ZMM1pEbXB4L3NK?=
 =?utf-8?B?QUl3ejljK0ZYblZZWmpvSTFyNzNCREJ4WmRUTU9lMWRNVzBNcXNDM1paSXRr?=
 =?utf-8?B?V3hETk9EbVpWbTFIK1cyT3RyUWxLbzRHNGx1Z1dnUDJzS0NhRnBRdVhId0ZC?=
 =?utf-8?B?MFY0YUZ2OVdQYVRub3dlOWIyWEpPZnAwTFc5cExJWjJ3VkZPUHFvR1E5bGh4?=
 =?utf-8?B?SDZobWZlTWZYWWI2NExXSTA3UWNiRDFzSUpGR1NNb1NPZU5xUHBjYSt3UWVq?=
 =?utf-8?B?Q25wb1Vkb2RLTy9qOE9xZmo4L0h6YndHUE1OVis0SHN3Rm5OZGM3Yk0ySTAz?=
 =?utf-8?B?dE5IaFVIRThSZkJzNUY4WmNJTk02RDhvdFBLOUhJd2FHeHpCOW5YNW5pVG5K?=
 =?utf-8?B?RTk2Z3NmdjVTMmd0ZjQyUXZ0WUJKOHU2T2JMTGVZdDVOYnp0UUtpV21PRnNm?=
 =?utf-8?B?QVVqcFNnUHJ5UDRoUzMrSkx1L1hxTDNFd2FrL2tjcjd4V2wweWwyNVM0OGUy?=
 =?utf-8?B?eUk5MVhScU02MENJQVQ2MjRObzFBeXl4Y2w5OXFSdmFKSCtvbmxFdU13YjBw?=
 =?utf-8?B?U2NlVk11WU1xemJnaDRMaUZ0Q2srQ3B4SksyNWF0dU5KM3cyVEpaUTA3WnBC?=
 =?utf-8?B?djdqVjJOeWNyWS8zalpNdnhhUEgyaDdVTXJkVFlvc1JqVCtrVWx0T2VzKzM3?=
 =?utf-8?B?ZUZCUlNxaTBFbFpGSkc1d1VET2ttMjBQUW4xdXBObkhCSmZjRnFSTkRNbEVZ?=
 =?utf-8?B?Y3JJN2dxS1EzTjY0Y1RIREowVnliMC94a082bnNEMndmcmRrNWd5d3FKbm9B?=
 =?utf-8?B?MGJubmxxTUl6OGZ0NWFXOG1XOUhtUUxUVDNycnRMTlhBWGIwYkh4YUtCUExR?=
 =?utf-8?B?TWhNZjcwZXI0TEpmcDNCN2tmQ0ZVL054SGtrQ25NMVZSakRqRG85Rmg4enZJ?=
 =?utf-8?B?SDcwV0tYK0dPRDZTQ25sUENMNnJVOWdKdjZTTzMySVQ4TjNYbmFBU0FNNkhl?=
 =?utf-8?B?ckxOVlhLWEZwQ1dVbURnYzNuVW9YU0YxY1l0bTRDbEhEM1ZoSGxWL3k5YnMr?=
 =?utf-8?B?MFJidkpDUFFkUDRhSUQrNUVlbXdROHp5aFI5WVkyNnhxc0VXNnluZzZFVlln?=
 =?utf-8?B?aEpEZGtOeWN4VnRrUUtXYzFBWm44NzhWT0xXc2JBM21BZkhmcndQWkg0VW1L?=
 =?utf-8?B?MFZXTDFKUlhvdHV3YUtzRStwOTMyTlRwaWV6STNmWkZTeDJrM0IvN0ZIQ200?=
 =?utf-8?B?eCsxNExEZVlwSUdReDExUmxDeTRyeG1RV2wwTDR4YXpqbTF4Znp2UUpkZW5P?=
 =?utf-8?B?Q3FnelZRVzVGb3dQQzZDM3pQSDlKWnltNUJkbld0UXhRSHRVbWhVVzk4NUg0?=
 =?utf-8?B?QVl2dXFTRWNhdjlEZnlWUnlkRkN2VitiZzMveERxZFk3ZjNUQnNvdHNZN0RD?=
 =?utf-8?B?ZStaQld4VHBXVG9JSm9tK2NVMFM1QUtNMEltMXdnNWV1SjdVTW1nc3c3elB2?=
 =?utf-8?B?RElhTmJtNVVROHp2K0JtbktKd2xCMklrK0dLdGJFZWNxOFNtT0o4VXQzS2RQ?=
 =?utf-8?B?YkVsOE5VQ3pJbklobmFzR0Fmc2c1OURhWTBiVDdackRSWUNBZGsyZVNSd2xy?=
 =?utf-8?B?TlpaT1VzRk5uUERRTk9mRVBkVklNM1B3TWh3REJIcFFJR1VMdDJjWWV0WkJi?=
 =?utf-8?B?b0FYdDFCcVBUTnVMY3Z1TXA3MnNSdHVxeC9ySTR5MUV5cVBwNDZVdlV2WmJr?=
 =?utf-8?B?Rk8wODZTOFRST1pHMUpRa1I1NHNiQUt3STE0bWtKR3MxZENGREhsZ0UzTTlI?=
 =?utf-8?B?VjJVdE5tczJWdCtGaklwdzVFOXFWZVZEeWxtc1lCWE1RN29DU2VrVXN3SnEy?=
 =?utf-8?Q?vfqgfMFsSD/R/S92xy0lx1IcI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b89ff9d-4715-4654-58e4-08db0635bc86
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 22:26:47.1823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jf0ZaO36IpJJPOjwG0GEWOaxpudfsZVm0cdprEGMy6vDNbWmyqc0bViqWgUruAx+KA7Ti8F5Sz+d6lcrx1ptWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7493
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Alex,

On 03/02/2023 23:07, Alex Deucher wrote:
> On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> This patch intorduces new UAPI/IOCTL for usermode graphics
>> queue. The userspace app will fill this structure and request
>> the graphics driver to add a graphics work queue for it. The
>> output of this UAPI is a queue id.
>>
>> This UAPI maps the queue into GPU, so the graphics app can start
>> submitting work to the queue as soon as the call returns.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 53 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index 4038abe8505a..6c5235d107b3 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -54,6 +54,7 @@ extern "C" {
>>   #define DRM_AMDGPU_VM                  0x13
>>   #define DRM_AMDGPU_FENCE_TO_HANDLE     0x14
>>   #define DRM_AMDGPU_SCHED               0x15
>> +#define DRM_AMDGPU_USERQ               0x16
>>
>>   #define DRM_IOCTL_AMDGPU_GEM_CREATE    DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -71,6 +72,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_VM            DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>   #define DRM_IOCTL_AMDGPU_SCHED         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>> +#define DRM_IOCTL_AMDGPU_USERQ         DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>
>>   /**
>>    * DOC: memory domains
>> @@ -302,6 +304,57 @@ union drm_amdgpu_ctx {
>>          union drm_amdgpu_ctx_out out;
>>   };
>>
>> +/* user queue IOCTL */
>> +#define AMDGPU_USERQ_OP_CREATE 1
>> +#define AMDGPU_USERQ_OP_FREE   2
>> +
>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE  (1 << 0)
>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL     (1 << 1)
>> +
>> +struct drm_amdgpu_userq_mqd {
>> +       /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>> +       __u32   flags;
>> +       /** IP type: AMDGPU_HW_IP_* */
>> +       __u32   ip_type;
>> +       /** GEM object handle */
>> +       __u32   doorbell_handle;
>> +       /** Doorbell offset in dwords */
>> +       __u32   doorbell_offset;
> Since doorbells are 64 bit, maybe this offset should be in qwords.

Can you please help to cross check this information ? All the existing 
kernel doorbell calculations are keeping doorbells size as sizeof(u32)

>
>> +       /** GPU virtual address of the queue */
>> +       __u64   queue_va;
>> +       /** Size of the queue in bytes */
>> +       __u64   queue_size;
>> +       /** GPU virtual address of the rptr */
>> +       __u64   rptr_va;
>> +       /** GPU virtual address of the wptr */
>> +       __u64   wptr_va;
>> +};
>> +
>> +struct drm_amdgpu_userq_in {
>> +       /** AMDGPU_USERQ_OP_* */
>> +       __u32   op;
>> +       /** Flags */
>> +       __u32   flags;
>> +       /** Queue handle to associate the queue free call with,
>> +        * unused for queue create calls */
>> +       __u32   queue_id;
>> +       __u32   pad;
>> +       /** Queue descriptor */
>> +       struct drm_amdgpu_userq_mqd mqd;
>> +};
>> +
>> +struct drm_amdgpu_userq_out {
>> +       /** Queue handle */
>> +       __u32   q_id;
> Maybe this should be queue_id to match the input.

Agree.

- Shashank

> Alex
>
>> +       /** Flags */
>> +       __u32   flags;
>> +};
>> +
>> +union drm_amdgpu_userq {
>> +       struct drm_amdgpu_userq_in in;
>> +       struct drm_amdgpu_userq_out out;
>> +};
>> +
>>   /* vm ioctl */
>>   #define AMDGPU_VM_OP_RESERVE_VMID      1
>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
>> --
>> 2.34.1
>>
