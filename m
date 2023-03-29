Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9047FC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 19:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179F510E1B0;
	Wed, 29 Mar 2023 19:21:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 294C810E1A9
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 19:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE63H7gw0IK0mLrpomhFp9vnKtS5U7eTj1noyX0QtlAvoqnpsl2r4+NLjlHKaYFChrawTebCbvGTSXPI+LVWmHtWLE+AjrQ+jjyJJZIxWl3nEywiqjXRQIjHzwwQCdijmliGAgVmo2HzK+cUVBXxW2xgHQeJZ6BOCnWzk69pgZY61OhaKIYJQYQGGhUKsb0d/TrHFlgoMHHtt0GXpCiiVh7izrlp6MCkt9u2uuktYy1ai9BP9RdhUW5skbpRtR69HkLRToSGif4UfFjVmnPnrnPsH7A5SW8Vphm6p3PCYuc7/wJ+N/NlW3FAxSeitvnYO94OsqaCVejdpXS6MNEvhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0HRHFqGvaFD8o/+v+cX6bwm3RUjBQgmEYGn+HJdhps=;
 b=E875vj7utUyRtKpz9an9aJOkzSMeUR8LJNoDjyvbuXMyD3qNODIl3R7cidNztzIJPN7kPovTDxZpik8sLxWYNAol0ZG1Zfvv+StJgM+Y1Yqtx1eEDZuhw30yvmvKQL/Z64IuDytDJWKxcg+IwHdy+Wth4Du0zflfdigc+tPn4ohfElwfDmQhVfEIsJskevwQqBJ5X2hnICNd4jrSLsjAn9WXyHYsLyocdeC1xf7a+TLN7KeIhUYTkUhndDgAqteaQ0gZCYlNW5R+oHBpo7PfIT/SKuDTW+5zHph7yx0mlKoKJxFP1u+ooytmVxzreW1d95esvc5rZVczC6ka5rXDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0HRHFqGvaFD8o/+v+cX6bwm3RUjBQgmEYGn+HJdhps=;
 b=RFSqyBhSiuPSRqyTIImaq+lh4pTxAlC78KDioMwtm7tV19JFZLU6tGNVqfHtAZNQsJzdax02JHze2xngUxP1ugfsR4ypmQuPo7x+xgc6WgeTwGPIIzKDQIWT13P3VKXjiW6SCyMQPyOK0L0JMUGRSYhj/5yQb0H51Z9D/Tr8Rzs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 19:21:35 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 19:21:35 +0000
Message-ID: <fafdfdbf-bb51-54ad-7412-5c689ff5c4ce@amd.com>
Date: Wed, 29 Mar 2023 21:21:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
 <CADnq5_PL8sVkpmEff2P03s0PRHsfsqWh1z6GtKZJCR0EDwzdjQ@mail.gmail.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_PL8sVkpmEff2P03s0PRHsfsqWh1z6GtKZJCR0EDwzdjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f96ee0e-b5d4-433b-b918-08db308acf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vd19mhqDyJT4crccn8JbqbDaA9bWN0Yq58gggFMDpx5ePWeN/c5DsJLPZsJIGJwRDfgKZSkE5jXhidep6AJ66SS9WoEWv7PtGUmQGu9ONYqME//YES62d47JTiLWP8pPb5xrMIOZoiSe2Y54GsfNGAkg/xM9iOJUFEx+sQijN0lJ7E+su7W7LJngx8ha2O+J/n5EUNAmtg94Ks4fBr61Y6ESO9KCtgzwv/IUx1QZPKbl2LmxRi4YmAnpa1Yxw4o9Nx+sXxhzkSIrvVnDCaakjtgqpmyVICMS2E5RgXa26PnSB9rAGg4UjmXeXOHxB+xcM0mo9f2vgB+M/uQTHXuYHNskIyHHm27iQpZzj2cxpMQa7imYGuzQA4ZxZp6cE7NHgR6YvqTNXXYDnwpMUab+pkYF8rq4xxnUuzNk5XQR5eiM+Ec1QP5/wZMzS7RbtLoBZZ2YC4159eYcUUHjbOoLx+lK1+iBHrNdFayqZ9X31Ihh/oaGIiDEGQBf2iJQbOqXxAE/zMyOkF1deo1W0Fpi4cd6iQ2SBR8M4JuSim7ItNyBK5P33m0uVNNicuqaNuGfJPAbs37w5/DgG9nDG/ZTGLy1rlLRzXTMt5RSDcfVjNgGcIvjgZCMQeDRo4KZ5XYKqdsV0gUWJ5bu3I3paW6++Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(316002)(478600001)(54906003)(31696002)(86362001)(8936002)(36756003)(5660300002)(66556008)(44832011)(38100700002)(66476007)(4326008)(8676002)(2906002)(66946007)(6916009)(6506007)(41300700001)(186003)(6666004)(53546011)(6512007)(26005)(2616005)(83380400001)(31686004)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smtvd3NWbFZwclZNZHN4MzdUSXZ5cE5pMzg1L2E2UjZXZUMwMHNzRFd2enhj?=
 =?utf-8?B?b2NmMlU4dnVJZjg2VnhHZnIxeEwydnNISWl6b0VZNGpMZWM5ODhpck10ekxF?=
 =?utf-8?B?cXJwazhUYzViKzVHVVRLcW90Ty9xMUI3cTNYekNad1A3RldTMUh2VHNVNzFY?=
 =?utf-8?B?R0djcVo2UnIyWUxTclNzSm5WNUIxSnYvOTRpdGthd1NCK3R0YXROckFaekR1?=
 =?utf-8?B?L0taZXRudUJrcnJEYllTb05QbnVCQjVQd0RNeVhMYzdoWXkxS0F3d0lGdDhh?=
 =?utf-8?B?UThreTF6S1E4Qk5GaC9SN0orc3g5cTRMLzJXT0ZKYWUrcHY5NWpDZ0gxWFVj?=
 =?utf-8?B?QXJXOVp5UGJyem5wUks4SElWS2dSK1VyV3h5VjlmOXRoWVZDRXJUYy95UTha?=
 =?utf-8?B?K2xKK00zKzZKOEdBR05WV05NSmx5ekMvOU1GREg5WkptWjUvTlR3RFVOWnNL?=
 =?utf-8?B?UlBhWGhZRWQ0QjNUTGoremxqN1ZxK01wbTI2WmtrNzlFL1JQdlFTSXpkTWxQ?=
 =?utf-8?B?aVN0VzhIMXhkRDJFQTRRQ3dEcUE1ZmF3ZEpqUHZBTVZnMkZ0TVlkSkdZZE1Q?=
 =?utf-8?B?VzdvaXVvZ0hBVVlWelIvZzMzMFJjNHg1SHpGbEg1OUQvMzh4N3diSzE1cFdi?=
 =?utf-8?B?NmR3dFJVRkE3czJMdnF5SHkwbUYxZGtidzVVaHV2SHY4Z2dZc1pubjVlTjE4?=
 =?utf-8?B?cHVUbkVmSTVoeHZzeHQ1WjVxT3kzYjhlbm1TNHNBdS9kQVJyL2x5OXZ2M1Zo?=
 =?utf-8?B?YTVuTS93QmxFeXVUY3o5VU52YnkzYjRJamEyRmVSaWFGMHR1MndjZVBsR0py?=
 =?utf-8?B?dnVwOWYwYnZadWlRUzhqRXZmV1hzMTB0dGE1d3pTdmphRmVVaXZOWjlacDY5?=
 =?utf-8?B?enhSZEdSbUJKN0ZXbFhGRzhXbm1SVTlIY0RJdi9KMVlPWkdIeHRMdGNnbFFB?=
 =?utf-8?B?UVVxQ24zMlRQRi9kcUtVTEhFL2pQRkpiV05BOFFnN0JwYlZxRjd5RElRRTc1?=
 =?utf-8?B?OE9yV2ZJaldpR1JuZTV3bmRhSFJCYitBSnJHQ3FHZ2pQUWFxUWJsd0twK0FU?=
 =?utf-8?B?TU4rRkYrYk9pTEFWa3pTWkd2dU9lUlZHV0ZRZ0tCamt3dVNISS9rSlh6UUkw?=
 =?utf-8?B?SUlHckdsVW44TGR5OGtwSkhhVmZaakFvVXVIM0k4L1dWWkRTMVJEN3hXYk5T?=
 =?utf-8?B?ZkF1VlFSQmgwUTZJL1o0VzdpMHNhSkpiY1haeTVXdHNrTTZibEloYis4OHl6?=
 =?utf-8?B?aEQvOWxldEdqeSs0ZFZGc2ZsUzEyZ2JNQzJCaGhkZStBT2FqcFBjcXcvOGtP?=
 =?utf-8?B?Zk9lelJmVEFvVHVtNVVPbE5ObnVxV1dIZWI2RUg3R2xJQ2NiQ0doSE10ZGVj?=
 =?utf-8?B?TFQvcWdSeUFzQW9BM2hBODFmUmJMeVZWRzRZZnFkSnVQOUJQWlZJQU8vb2Ju?=
 =?utf-8?B?VTN3WEVXcTNBOG5rWjlSNHY0YmR5WER0YkMzSThQUWdXZCtyQXgzT3ppbDQw?=
 =?utf-8?B?TUJYQXpMRnpTZkNiN2FmSFh4ZnlKUjZCT3h3R2xKc0czY2lEMTY1bXlhSjFD?=
 =?utf-8?B?anV5c1JleE5CUWJ1eFdyd3VSNElUN0t3elFqbm0rS3d0cHNqcWFJYU9XeUNq?=
 =?utf-8?B?cTJFQzNqSjNoZjNyelRxTW1TSWRpOTM3b05EdkRqOXNIeExCL1pJcmxLZVBp?=
 =?utf-8?B?d09LZVpHUkl2UFMxcU44UDRibDNhbE1kcnJaMnpWNXF4ZlY2T3hkNm5EOGQ0?=
 =?utf-8?B?bFNSMGpCSEt4cmZYZjl5RTlVT0w5bGs0ZHJZY3RqM2h3bWw4TDZXWWp1K1gy?=
 =?utf-8?B?VWJmNDRrRFBLY3c2R2NWeUJaT25jUUlqT3NwdWJuQW1nUnpTdlk5MGpvdm54?=
 =?utf-8?B?Wk1seEJxa2dMRUFCQWkxTDhtZDE1QkIrNXk2NytUUDFPVXcydXV1RU9Lc25v?=
 =?utf-8?B?Yld6emY1c3NWQ3VpV2s4eU9ndnRZT0d1ZlFha1hHelhxSXg0WlBLOTJsV3RR?=
 =?utf-8?B?Z0wxWHlLM1hWNVRhZmFQbWh3M2JRd0tCOURvdEJGWVZORlFDV1pOOThRUHRy?=
 =?utf-8?B?K3I2WjJHM0FJWE9ZSU45YUFlT1lMRFVwLzVJLytFakdueE9QeUR4K2FEM1pL?=
 =?utf-8?Q?E3U5cG7+y8iQ9ExJcC2fhAxwS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f96ee0e-b5d4-433b-b918-08db308acf81
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 19:21:35.5448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tK0iZSZM1I40V3L5SVisWZjZSxEl71Ngcebw3fRWhpZKE42KZzx46mpKDY0y+bwODnxzXxioXtNHaEKWklYzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750
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

Hey Alex,

On 29/03/2023 19:57, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 12:05 PM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
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
>> V2: Addressed review comments from Alex and Christian
>>      - Make the doorbell offset's comment clearer
>>      - Change the output parameter name to queue_id
>> V3: Integration with doorbell manager
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index cc5d551abda5..e4943099b9d2 100644
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
>> @@ -307,6 +309,59 @@ union drm_amdgpu_ctx {
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
>> +       /** Doorbell's offset in the doorbell bo */
>> +       __u32   doorbell_offset;
>> +       /** GPU virtual address of the queue */
>> +       __u64   queue_va;
>> +       /** Size of the queue in bytes */
>> +       __u64   queue_size;
>> +       /** GPU virtual address of the rptr */
>> +       __u64   rptr_va;
>> +       /** GPU virtual address of the wptr */
>> +       __u64   wptr_va;
>> +       /** GPU virtual address of the shadow context space */
>> +       __u64   shadow_va;
>> +};
> We may want to make the MQD engine specific.  E.g., shadow is gfx
> specific.  We also probably need the csa and gds buffers for gfx as
> well.  Other engines may have their own additional buffer
> requirements.
>
> Alex

Sure, we can call it drm_amdgpu_userq_mqd_gfx to clarify that this MQD 
is specific to GFX engine.

- Shashank

>
>
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
>> +       __u32   queue_id;
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
>> 2.40.0
>>
