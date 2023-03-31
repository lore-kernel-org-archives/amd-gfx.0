Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE42BC6FD18
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649CF10E32D;
	Fri, 31 Mar 2023 08:42:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44AEF10F125
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:42:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu/SJ4Gn4grXMx6UjiVh6prOCBtU1HqjVlj7/+FlHbmA9YwD+i2IjXfLWHYcvAJzk/5eYXMiB/Lzgs5BkRybHSuBicIEKaZBIV6D8ItIuoVKHXxgvkxwzs0yAsaNl/abDxpEhDQ6xdR0zw8gQsIo8E+1+xWiVXCrtIRdpD6wfeB4904Uif/TMdHVYIsSurf3xb6E1xNwM/QC6apGujKDMqfykKH21oP05y30xRb5FdMqJjt8ZHVPFJxKeKsA1iabmPGGAJWTkruThidv0DtvoktqnpLjy8TkUMXdigE939WKMWQZYbQFyzm2nYhPMFp39V5LtjxaT7lqx0jxyupjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWRtMYbgsK5Feo4dHa5zV3Hc7TgZ7dz5nYfCxQLS+lw=;
 b=QynW77kCilvhnTFFvpC9V/SEt90UUtjyd9rvSYrXEMz0aLN9G0X0raBjslBjwDoOk9O06OBJSOIhZAWQJhx/yj4KXHlmOxD98U/VBMxxkxBEXo3+ASWr2scLmfR1Fjy2GzhpCcgLQeoawkLtSJf50Au+YweNQ/g7y4xXUUn8CiDP9lULnuAk4ew0aRPDluadS5rT91xOAJH7MO7Ounzm3EbrUR5FzQiEkuKc4fZOuX/CCPGb9xt4iJV2AeGOMVQb4/LPewjKDrdRS1VXHHT0H+IzbP9RFTfPplsyDCYwS9LbG14D+eHDKhqlAAtS5/rfC09sbzK3njJOS/35vbr+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWRtMYbgsK5Feo4dHa5zV3Hc7TgZ7dz5nYfCxQLS+lw=;
 b=bHbIOqOcpPbfV71a3Em8nFQpub+P9Tifh8IOKVC9KLNA0FllKFpC2yCS6CsGWW2RJGnOdR46vxMFL1GamZ1BLLQ94MGc5+SWGDz455U3o9H1EbUjqInbHonoUqg8BQ2WYKySK+W5bRNw3pfftddQtgkAuZGU4e5lxWYCjGrHAEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.23; Fri, 31 Mar
 2023 08:42:34 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:42:34 +0000
Message-ID: <43b5d57e-1b28-24f9-0f44-9afd2be21444@amd.com>
Date: Fri, 31 Mar 2023 10:42:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/9] drm/amdgpu: create context space for usermode queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-6-shashank.sharma@amd.com>
 <CADnq5_OiD5W5w7ZBBhrrGEU8wUvAoavYT2yk1amCYnNRXgA=dQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OiD5W5w7ZBBhrrGEU8wUvAoavYT2yk1amCYnNRXgA=dQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DM4PR12MB5040:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e1218b-b631-4d98-8c2a-08db31c3dfaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERgOkX45/QxmohhWkErcJpN7pGbqHQ4UrcWZqHXmVALQhNQUFP2HGOKWkXBeaiL03m6AWg8vWbnYhzaNZM1BjGkxv4rbHarNJVLaTNSjTr5jbKm1RDX7vDW3huB29D+WBWwgcK1X+qrM2FvrDIsX4c1N+l+5Wgu9062M1IC2MIN/NYu+QpvlAgmfz0KGVku5TaX47hDeKRUId2VMHHf1V9lSe6tLEbEDW+wKJNx/hEfrh4kMIvwhUeYTTYvw2SdEUaGp1YUOikp3G97B7Z4QcqBDDgcYkkQvPRhQLj/ghdlTMn50EaBLQ8qUVsB47mrjn/aC35ZvUzgK3pRdHXFfL5NlFm2ZHGRjXg5JlBd302d5Oe2WoZI0qYe/rumJ7CIGhjCJfqFDr6VcWX9oA7Brrg/ZKs1k8XiwrJkSwAw9DsLdrkE/HkZnJsExNvZVT2Yw9TvGFLQN8OlR4oJmN5BaZuY/o7+/4LzbJ1ijz5bs7QG0u6oCYDIK29BSTcLKWuldowlocXgopjxZgM7GFc9w7uuzNZi1HSVxJsYCAdoCGQNqVp/w5TSzsxWnM4ubKVNw60EWV10THE/ZQKbtcxdp8keWWG448mWSQvTEA/2rJTUPNAT8k2Q1DJQ6Ui0QywjTuBDY6n4/aJaJ348HeOmDqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(31686004)(186003)(6512007)(6506007)(6666004)(53546011)(8936002)(31696002)(86362001)(5660300002)(44832011)(66556008)(66476007)(478600001)(54906003)(41300700001)(316002)(66946007)(2616005)(83380400001)(26005)(2906002)(36756003)(4326008)(38100700002)(6916009)(8676002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJhWjdMVlcwZWNqUllhTnhTR0UvREFkdWpJTHZIc2E2Q2V1Y2IzRDNERlVZ?=
 =?utf-8?B?UmdOR2IvS1lhQXE5eXJmMUVBTHo1R1ExM0NLQ3N6eG1LUyt1dnc1dlRIOVN1?=
 =?utf-8?B?d0doNXJ6Ym5VTldTTEZsNWwxcVlESTYxQTNtMzVodE1leWdtY1BJdGVqK1FM?=
 =?utf-8?B?QTJ0YXFERFVkNzFaTG1IdXAzc0dCT2l0dFl4R1hnZUFMZW5KWm5VQlIveXBG?=
 =?utf-8?B?Z2ptRFlGNktNWEkxQVZ4THRHSzVCS2hFNERuY0plZU1WQnViNm9paFFmMjVI?=
 =?utf-8?B?YkNVaWZ0UFcreEJUdlp2K3RzeXZHRVFPZDVENjBXNS9JZ0hnaWJYalJNMGFI?=
 =?utf-8?B?c1JCRkNsd2lvMjhQWGRrYTRuNXZNUTVqS01scldySFJ6NENsSzIzRW5RcTd1?=
 =?utf-8?B?R0FaVEUzOGFpSlMxOHZZRmJjNStYT0RMb3FkS2VrZUw4eGttVEgrK0dxcHJ5?=
 =?utf-8?B?YXdvVGFBQ0hUdXZjVFpaY3ViOUlNb2x2MThST1A5TU5BVmsrNDVzT2tyMDNK?=
 =?utf-8?B?QTZ3UjAydTRBaTNwR2hLaFY3MWZDOHN3WXNwKzhEL0I5akhrMHVVQVQ0OHBj?=
 =?utf-8?B?cFQwb1diYWtxdFd4NWdPL01QUmhzNVRIVVlldjBsQ0dSWXE0U250K2x1WHJN?=
 =?utf-8?B?V1pDaGpwK0I0VkszZnU0clg0QlMzYVpUWjgrSElBaWN6NFBwc0FjaG9zNWRF?=
 =?utf-8?B?ejZnaGlVeXR0TWZwV3ZlYUhOVy9TbzlSdlJOMGU5NEQ0c2c4RjJ6MWdqdVFq?=
 =?utf-8?B?QVNJd2FMKzF4Z0lJWjVUcTVYMEJtY2lhZm01ZEkrRHR1VkZTZ1JDckpIMDNO?=
 =?utf-8?B?MGRRMmZua1laM0xiQ1g3R0pxZmpQQnRnWDVjUCtnem1WYVhYZTBPZTJaWUpT?=
 =?utf-8?B?Ry9QMkhrS3hJa3grWG9tb0VwUGpHZFBQVWVLK2xNd3c5RWQwa3NVQ25tQ0Y2?=
 =?utf-8?B?ZVFRL1RaczRVOTZMZUFBTzRpcVhXY1pQWlBSMlJRYzJvMHVyUlptUUVGb0Nt?=
 =?utf-8?B?dUMwRm5EWjRaMDA2L083dFhrMktZRStOcWc0TFZ0U1BXVWFwN3BCK3AvTzFn?=
 =?utf-8?B?WW5MaEhVS3FwTmJPbzJ4WDN1NTUzMnhhTVI2RE9EVHd2dzdxSHhLbTJqT3k4?=
 =?utf-8?B?Zk85TXR2d2NDWjR2SWtwd0gyYjIyTDJKRDFJT294OGZpb3lDaDR5blFXTkhn?=
 =?utf-8?B?ZGhpbGRPRmVqNDQvZnRxYXl1U20yNVhiVUlkS0hrc2NYZEVRV01UVkRQNENL?=
 =?utf-8?B?UEdtYW1ZQVpzcjVZUG5ZN0xuRWE2TXRjS0lsVENPako4VVhDK3NIaGI5b2RG?=
 =?utf-8?B?Qk9aOGZQR0orS0VKd3p5N3FxSThCSWM0NFphNk9UcjNiQ1ZXTDQ4RTd6OC9s?=
 =?utf-8?B?UjE5b2FZeVZwS0pPaVBRTFFMU2FZaktVbktGWlk1WFoyQ0d2anRhN240aXRh?=
 =?utf-8?B?bDVxYmpObTRUK1BHVDQwWDJQRWFFbTljYzRqVkVSRlZTRjd6Q1YvM2d0Z21K?=
 =?utf-8?B?am5Pa1o2UFA1V3RVY2pWN0pJNEZFN0crakdRUVlDNXNucHNpSzRmSzkxRTJi?=
 =?utf-8?B?b2RMQ3g3SnVTQnpGVk1wZWNzSFg3OHNQRVI4R1FLOTN5ODdYU0FOY1RDSmVm?=
 =?utf-8?B?R0JpZHBWRnpBNFpLTk8xUVByb2xiTDVJOFdYUEpyc2RUZFVWZ3J0YWhxd2VS?=
 =?utf-8?B?WDZZZU1BSnRON2JQR0hOVXlRQThUWEFzNjBlZDVtTTY0UkpsY1RtV1lHaGw3?=
 =?utf-8?B?amlKQ2w3YzJlUmhWenowRlBodW9mU0tMUWZzWXNVMXAxbWc4WDh1ckJTaFdB?=
 =?utf-8?B?Zk9mam96NlgxMGJnOS91MjNuQnBVSEYzaDE4Rmthb3B3OU5ORXE3MXlrZXFZ?=
 =?utf-8?B?TUh4VEtFTVR2Mkc4eTRHMkU5STd1WWN6Uk9OaVQzU2oyVXdvYWNiOTkrakpa?=
 =?utf-8?B?L1dMZVhkaVpabWJCQVJTVCtPRlhMSjA3Z2tCWnhDMFhKMEp2R0NOdVpSc3VX?=
 =?utf-8?B?ZDdkK3BhaWhZQVgzQWgxUUJURHVZbmxNVUhKbkhXcHhpYWRTNXlLTmhCYzBN?=
 =?utf-8?B?WWd1RkhzQjUyalNQa01PazFZWmVOUldBZU90azltN2k5bmRPNnJNODRwalhq?=
 =?utf-8?Q?B4WaoNEF6L6YsMjoZsRuXFCEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e1218b-b631-4d98-8c2a-08db31c3dfaf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:42:34.7071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxw1gOkvJBDeqgnBUfL4xMFk8hUNTX8xu29MTa/8o+Zb//CSaKLKz0o6VkS8/cM6p7JF6RXBUZndEaEMw3gOqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
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
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 23:23, Alex Deucher wrote:
> On Wed, Mar 29, 2023 at 12:05 PM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> The FW expects us to allocate atleast one page as context space to
>> process gang, process, shadow, GDS and FW  related work. This patch
>> creates a joint object for the same, and calculates GPU space offsets
>> for each of these spaces.
> The shadow bo, at least, should come from user space since userspace
> will want to mess with it to optimize it's register handling at least
> for gfx.  The gds and csa could also come from userspace.  That would
> simplify things.  The UMD would just specify them in the MQD
> descriptor for GFX in the IOCTL.  We could allocate them in the
> kernel, but then we'd need to make sure they were mapped into the
> GPUVM space for the UMD,  That could get pretty big if they have a lot
> of queues.

The shadow space is indeed getting created in userspace for the working 
solution,

I just forgot update the commit message here.  Should I move the GDS bo to

userspace as well ?

- Shashank

>
> Alex
>
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
>>                             &mqd->gpu_addr,
>> @@ -73,6 +128,7 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>   {
>>       struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>>
>> +    amdgpu_userq_gfx_v11_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_bo_free_kernel(&mqd->obj,
>>                             &mqd->gpu_addr,
>>                             &mqd->cpu_ptr);
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 2911c88d0fed..8b62ef77cd26 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -38,10 +38,17 @@ struct amdgpu_usermode_queue {
>>          int queue_type;
>>          uint64_t flags;
>>          uint64_t doorbell_handle;
>> +       uint64_t proc_ctx_gpu_addr;
>> +       uint64_t gang_ctx_gpu_addr;
>> +       uint64_t gds_ctx_gpu_addr;
>> +       uint64_t fw_ctx_gpu_addr;
>> +       uint64_t shadow_ctx_gpu_addr;
>> +
>>          struct amdgpu_vm *vm;
>>          struct amdgpu_userq_mgr *userq_mgr;
>>          struct amdgpu_mqd_prop userq_prop;
>>          struct amdgpu_userq_ctx_space mqd;
>> +       struct amdgpu_userq_ctx_space fw_space;
>>   };
>>
>>   struct amdgpu_userq_funcs {
>> --
>> 2.40.0
>>
