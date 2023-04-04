Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D4C6FD1D
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 16:37:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5190710E712;
	Tue,  4 Apr 2023 16:37:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449B210E713
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 16:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQuCDDJnMGnmh4ix5quDoL1jP2kP7YZ5rZ3Aft2rmcs8YoALCj3M8GJPCJ7aPSsq+TUDj9yey35Fkvuursx+/tMppo9ViAf67WuDfyBVYkqyiJKn3LAedWWawngdiXfdTbu2W8Jdy/Wl1xEHHISpZtP+HsTqOHDLoOdZoeMyBxx5RGOzUG3HoJiOXdkKmXz4Ak3Ng6DcvZE2k9rnjSSTdenO/1USyP2qvXCFG5DuMYA/cFIPCYZoqRgRI0wdJ1+5Ll+XosT8PqhMOzcHROiIsaEdq3Q1pK095tL+O448thGQHwKkS9yyP8V0Cd1dJ6LR3WxPv5KEcrrjOiI8tC4acQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rf5/84cXFnnxYazHW2uXAc8OVy5xGUOaOfo1Bf6JMrc=;
 b=dKWx5UDoPmdp1pHF8EHFYrvO/VZJcT3trrp0kOMEyHrmHHx2ZiJ7oVHlYF+sOYRvBErEN9NDbYWOwBCmIyJ0G1qQCuIcCC5sslnFRSRFCH8y3VXC6xbU3pBVppyrisufEDSAsvsMNwBVgqFS+zQJuLCYhzpHE9x37w8U/DdD5X8Jga1RyygOadGDVZOOELgZYBCstKODqXNy2qd/KvNi35v0MJI1QdCOyjbS/mN/LC5PHg+990sZJlV+T0wnqN9/mkMeS7l69rSejNniRUqcJZvESmsjf+Wt8ScYvz+7lcGiQnbMn+YBj134VjSz+3nSReU111pboXSnLoJF0+EC7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rf5/84cXFnnxYazHW2uXAc8OVy5xGUOaOfo1Bf6JMrc=;
 b=4DQzrqc/9k8enoZ3D/UnZLU7CZqW6qKlCTKZ10UhnRmBzWtrLFq/6qPB8g+ltEpQw+uT1sttrJFGTZVw7WEf1nrkI6w6mZ+0RN/iZZyE4lDNQN2wUljmg4AB0Ub79c5HV+9ufWnNqtJEXKMamgI6kHGR8KzomhjkE7u3UoF8KlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 16:37:24 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 16:37:24 +0000
Message-ID: <b410180d-64fc-5542-b869-33ac884def84@amd.com>
Date: Tue, 4 Apr 2023 18:37:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/9] drm/amdgpu: create context space for usermode queue
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-6-shashank.sharma@amd.com>
 <dcb79977-41ff-ab97-8194-1bb8ba22a315@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <dcb79977-41ff-ab97-8194-1bb8ba22a315@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d64f2bf-7018-4c2b-ed52-08db352ade8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VedVGBGxkBIOQJd5V0Jylw0u7M8miS+6wHnbyixinXAez/MjqP0W2SIkZ+Keeif3t6g/zOPINZ5Q0RoQ+NzHekp6MsMKdwlvjrbZ9C/1moOnI5+ZB3ZaeFv1mep8DP3vkdSZOlX7EUA9qvrTztjvapXCcKq5Gzz30T08G2AwDf65iCUe62o77xwRvVWlG5IJCYTbLVEDpKKH5RNadNBY7QUAMbBgDjwBoclDoyAEqExC7NcXn825M8kKq+sSx6FTcp/rfkyrHq7EsJbgbCs0fYOK50m9bwZPEQtuINA+b9MXQGpW/RtcmyrMnVf6MoZ6WMIyORbkXBkZsTXbukBjc86ifASYkjZRz7BrEpXPZYFdF3RxyezfBQ54SSkWorMXofkFB/LsASaF7euegkmKbsxJGgX5k+b6uTpWbuWxg782ITnYKOeWFI2AX0sg+kFwb02t3W07jpA1fHs9oXgZURBY4jtM4LW6c+JtEkDi45g808tl+96B/MJPTFJ7FaTDkWUeuJnwAeqnejW8mwkdcOoG2mWMqgryie4P2gcLhhVveV6e9+veVI60EgXggbAiYa62UghdAu1nm0JrRAegGx+vt7J/waIE/6KQvhk4tJeeLZ4nVkK8B8jdrwYufsaJ0JP0GzC8U6RDxzpZav7ZSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199021)(31686004)(2906002)(83380400001)(44832011)(6666004)(8676002)(478600001)(5660300002)(54906003)(66556008)(66476007)(6486002)(316002)(36756003)(8936002)(41300700001)(4326008)(38100700002)(186003)(66946007)(6506007)(26005)(2616005)(53546011)(6512007)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2p4ZnhHSlhxY0NreWVqSnJuV2ozNit2U1BTSlFwb3VjT3pmTG1TQ0xLOU1i?=
 =?utf-8?B?R2ZzVVZualA0Sjc0WERLSzdzQjF2ZjVEeWJOODNvVk1PMzFzZWF3MUhIb3Q0?=
 =?utf-8?B?SGFadVExOHFXVEg4LzBlYUk2dDliY0F6OE1rTVN2V0k1a1ltQktMeTNDM3hW?=
 =?utf-8?B?K2pjWFJtQUxYcEIxd1NwcVlnZ0JYTWhCaDRWcnlnL2k2M1VhaDBha1JHQmRD?=
 =?utf-8?B?S2xqTGh6QjRQUHd4YStWTWR3MXpjMjdTRWk1cWVhc25UdUlLMHZKSFFhbWpE?=
 =?utf-8?B?MEdUVmdZaytyOWdjRjRwKys5L1VJSGloY1VKMXpZTlBkSCs2M0xRUW1BcDlo?=
 =?utf-8?B?VFVLS2VmekZGMHNNaDlTNE01M25DazZ5eGx0UWZKSldDcnE0a1dXa3g5WkV0?=
 =?utf-8?B?N0Vxa0F6RXdHdE5iamw3MXUxNngyUGJhTkZjNVYyWFhITG1VdFRBd2xyTlBQ?=
 =?utf-8?B?RXlJY0RuVWdSWjdOeDJzZWZFVWptL24rVUs0bHZCRE5MTzI2ZzBzWXMybUts?=
 =?utf-8?B?dmpMajVxWDY4a0RzTHg0ZExwa2FocFNFQ1AzamMrcDA4S2VUTFAxYnd4T2k5?=
 =?utf-8?B?UE12T0xlS3NqblFTMXhUcTdMejFXWjZQY0lydEFYMDZPanljS05NWWdKRmlN?=
 =?utf-8?B?V0x3d1VnZE9iN3QxM3lhc2lybjZJb054RGRoUmE2MmVaSERWMlFvSmhKVkEv?=
 =?utf-8?B?TENKa2ZRLzk2bC9mVWxqbysrVkVmbmU2NmZ6YnhuWFpBQmZZZU5LNVkwMWs2?=
 =?utf-8?B?VEtqTVhBenV3YkQxSTRpYWs4dnJpdEFiOTFiMjdoRlhubkdoYnl0VWdVQnhM?=
 =?utf-8?B?TWVEVXRNTG1wcUVDY2dpVlBpZks0Z3NqYllsUG9uMk40MVM2SWVtK2srdENk?=
 =?utf-8?B?STJHYkw2UlZtN3FnT25RZjhGSUgxMU5RK2tJQmgzODU0L1Uwa29ROFFrTWsz?=
 =?utf-8?B?Zm5nQStraDB0U0NHeWpNTXROempyUDd1Ykd3V1N5VWxEV0xINVY4eXh3ekFL?=
 =?utf-8?B?K0NDQVN6VElMZDcvVUpkK1Y3TFc3SzhFdmlqeWZZdXVsU0ZUL3ZaMFRoWjM2?=
 =?utf-8?B?V1JsU3hsYTMzQjYrUFcyOFNGbjY1Q2JpZWJpYXJFcThEY1F3SklTanBvUHNh?=
 =?utf-8?B?alNyNmx1WnBESnpnbCt2TjYzMEI0cEpFN0Y5M3NHM05Ua1djWEJLQTcwV05J?=
 =?utf-8?B?Zks0WGxRMFl5cUtKNiszcTVIcjRRK2FBYm1GVnhvaXQxOFhsVUpuUk8wQjFE?=
 =?utf-8?B?VGhMZk9yUFRWR29NOGdzNlhpcW5KdytQemQxamQ4eVF6WXdPNG5DZWlLMGZZ?=
 =?utf-8?B?VFVlWFJZOEpQYytkM3BhZUlCa05DeTlsbXJIdHJsanBFNURkSkRjTlVZSnNU?=
 =?utf-8?B?emxOTFgrM3d1dVUvTXNxWGNYNVlEbEttQmVyMmJnWURuUUxjWUVjRTFNdHJG?=
 =?utf-8?B?cXArVWsrM0hKdU13allOdzRuTFVQdHdnOHVneVlrNzJ3OWszVHBMd25XWUtM?=
 =?utf-8?B?ZVVJcXdYdnpVREt6WkVybEpzRzFFQkc2c2EycnNxVFhNeE92U3RWUjhLWFUv?=
 =?utf-8?B?azJReXZmbkhyWmZVd213N1lENWRUWHc3WEV5MGJ4V1ZTSGcxS0ZDdHVpWTRw?=
 =?utf-8?B?dmROM3NkUVpIRVpEZ2xvK0VjVmVJbmpIOWVtM2pYemRGK2svWlZuS2NBaGFr?=
 =?utf-8?B?NW5BaStESE1ic1lhQzhINlc0cW92RTA5QlNjcTh3RmxSRHZMeWgrMXpkSGtB?=
 =?utf-8?B?RkdpOWJ6WTZldUxUUjNrOTlkZjhwMTFJb3U3TWJWc0RHeGk3L0IrNnlIaElO?=
 =?utf-8?B?bld4TDRZOTBCVDJSUmMva20yTkhBNXd1bm9WQlIyQXQ5b0pJL1VnR1M3QUU1?=
 =?utf-8?B?T28zTkNOQ0JDV2E4Z0x2WElYVEdqNFVFclQ1anNUMWdnL3NkRmtYamwxR3d3?=
 =?utf-8?B?eW9FVFNMdG9Ea3NaVHIzb1RUUldtSlZiQ2E2T09sUHZ5UzVFTGlMdXFua2hM?=
 =?utf-8?B?bVVrWFJkRTBUTFVHemJ2R0VQbnoxYzRGMmpqdEJyanloQlk5ZFlpZ1lzTjdC?=
 =?utf-8?B?LzgrN0FUSkVDSWlQenNvSG5VVlg4S0JaSjVodi9wWXJLMkk2aUhvRkhzRWxj?=
 =?utf-8?Q?J0KtLLy+psCxMWg6DM2uKbgKm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d64f2bf-7018-4c2b-ed52-08db352ade8b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 16:37:24.4409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqqA+Yo2Lbt4935msgKo8p0Xkfd+22QV8iBNUECynIl0pdXDj2yTnWlgjbWb7FqnYX9Uz+URDRmDzkdcCKSH3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 04/04/2023 18:24, Luben Tuikov wrote:
> On 2023-03-29 12:04, Shashank Sharma wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> The FW expects us to allocate atleast one page as context space to
>> process gang, process, shadow, GDS and FW  related work. This patch
>> creates a joint object for the same, and calculates GPU space offsets
>> for each of these spaces.
>>
>> V1: Addressed review comments on RFC patch:
>>      Alex: Make this function IP specific
>>
>> V2: Addressed review comments from Christian
>>      - Allocate only one object for total FW space, and calculate
>>        offsets for each of these objects.
>>
>> V3: Integration with doorbell manager
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  1 +
>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 60 ++++++++++++++++++-
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 +++
>>   3 files changed, 66 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 052c2c1e8aed..5672efcbcffc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -71,6 +71,7 @@ static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq
>>       queue->userq_prop.queue_size = mqd_in->queue_size;
>>   
>>       queue->doorbell_handle = mqd_in->doorbell_handle;
>> +    queue->shadow_ctx_gpu_addr = mqd_in->shadow_va;
>>       queue->queue_type = mqd_in->ip_type;
>>       queue->flags = mqd_in->flags;
>>       queue->vm = &fpriv->vm;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> index 12e1a785b65a..52de96727f98 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> @@ -23,6 +23,51 @@
>>   #include "amdgpu.h"
>>   #include "amdgpu_userqueue.h"
>>   
>> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>> +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>> +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>> +
> Leaving a single space after the macro name and its value
> makes it hard to read. Please align the value columns
> and leave at least 3 spaces--this would make it readable.
> For instance,
>
> #define AMDGPU_USERQ_PROC_CTX_SZ   PAGE_SIZE
> #define AMDGPU_USERQ_GANG_CTX_SZ   PAGE_SIZE
> #define AMDGPU_USERQ_FW_CTX_SZ     PAGE_SIZE
> #define AMDGPU_USERQ_GDS_CTX_SZ    PAGE_SIZE


Noted,

Shashank

>
> Regards,
> Luben
>
>> +static int amdgpu_userq_gfx_v11_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                                 struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
>> +    int r, size;
>> +
>> +    /*
>> +     * The FW expects atleast one page space allocated for
>> +     * process ctx, gang ctx, gds ctx, fw ctx and shadow ctx each.
>> +     */
>> +    size = AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ +
>> +           AMDGPU_USERQ_FW_CTX_SZ + AMDGPU_USERQ_GDS_CTX_SZ;
>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_GTT,
>> +                                &ctx->obj,
>> +                                &ctx->gpu_addr,
>> +                                &ctx->cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate ctx space bo for userqueue, err:%d\n", r);
>> +        return r;
>> +    }
>> +
>> +    queue->proc_ctx_gpu_addr = ctx->gpu_addr;
>> +    queue->gang_ctx_gpu_addr = queue->proc_ctx_gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
>> +    queue->fw_ctx_gpu_addr = queue->gang_ctx_gpu_addr + AMDGPU_USERQ_GANG_CTX_SZ;
>> +    queue->gds_ctx_gpu_addr = queue->fw_ctx_gpu_addr + AMDGPU_USERQ_FW_CTX_SZ;
>> +    return 0;
>> +}
>> +
>> +static void amdgpu_userq_gfx_v11_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                                   struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_ctx_space *ctx = &queue->fw_space;
>> +
>> +    amdgpu_bo_free_kernel(&ctx->obj,
>> +                          &ctx->gpu_addr,
>> +                          &ctx->cpu_ptr);
>> +}
>> +
>>   static int
>>   amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -43,10 +88,17 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>       }
>>   
>>       memset(mqd->cpu_ptr, 0, size);
>> +
>> +    r = amdgpu_userq_gfx_v11_create_ctx_space(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create CTX space for userqueue (%d)\n", r);
>> +        goto free_mqd;
>> +    }
>> +
>>       r = amdgpu_bo_reserve(mqd->obj, false);
>>       if (unlikely(r != 0)) {
>>           DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> -        goto free_mqd;
>> +        goto free_ctx;
>>       }
>>   
>>       queue->userq_prop.use_doorbell = true;
>> @@ -55,12 +107,15 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
>>       amdgpu_bo_unreserve(mqd->obj);
>>       if (r) {
>>           DRM_ERROR("Failed to init MQD for queue\n");
>> -        goto free_mqd;
>> +        goto free_ctx;
>>       }
>>   
>>       DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>>       return 0;
>>   
>> +free_ctx:
>> +    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>> +
>>   free_mqd:
>>       amdgpu_bo_free_kernel(&mqd->obj,
>>   			   &mqd->gpu_addr,
>> @@ -73,6 +128,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>   {
>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>   
>> +    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_free_kernel(&mqd->obj,
>>   			   &mqd->gpu_addr,
>>   			   &mqd->cpu_ptr);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 2911c88d0fed..8b62ef77cd26 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -38,10 +38,17 @@ struct amdgpu_usermode_queue {
>>   	int queue_type;
>>   	uint64_t flags;
>>   	uint64_t doorbell_handle;
>> +	uint64_t proc_ctx_gpu_addr;
>> +	uint64_t gang_ctx_gpu_addr;
>> +	uint64_t gds_ctx_gpu_addr;
>> +	uint64_t fw_ctx_gpu_addr;
>> +	uint64_t shadow_ctx_gpu_addr;
>> +
>>   	struct amdgpu_vm *vm;
>>   	struct amdgpu_userq_mgr *userq_mgr;
>>   	struct amdgpu_mqd_prop userq_prop;
>>   	struct amdgpu_userq_ctx_space mqd;
>> +	struct amdgpu_userq_ctx_space fw_space;
>>   };
>>   
>>   struct amdgpu_userq_funcs {
