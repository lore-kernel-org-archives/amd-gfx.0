Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B19C761AF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E2610ED2B;
	Thu, 30 Mar 2023 08:15:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DDB710ED2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghxVqLl0xuVx5NXzQEIV5wa0iKU8GJNwHKJWPe4J4b3+CLFKm074c2WYdyazx/vKd9L8C+nnsNWK3x6cJCvP8Keag5twzBdjRBESL+zmBbHfGW2I7MAuJED2pesKbE3Vv/yHFYXl6h6f4GPcaHBLWKNWtUMfw5t5ahgarCcc8XcKvDs9X+eddHbIk6XqSaceLuNbPAhHXfrB4MAzGfK93V03q+Sxo66EF1TPxSoVh/jlh+yBFOOOhnKq7+l13DBUQijxWY2Wd4/GOPch1ErGe/9pGugBiE7hvheu10dWhzQuIBPPIiLSFWk/h4nLCKTeWFjjXjgxNhJr6PX/nXUavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIsdqOcOn79fKGMmBz6+xFe5JN+c32KFuG9wKEvcaU0=;
 b=gU+2xWa2ahpp+G53m0hHjGfwuoASDjWfkfI7XlaVZXb+5Svq4A9ieRpge/nVUqNnpc6CMWgU7SOeMynx4yKfh6w503BH5qwU0N66L87V/PWYcUwOP3SS+Tjj8PNnYIC+1cP003vdTJC/mZt6HyNpbkVVAfwd7kD0mGg2JOYWfK3dW/FfKyjHYgmZ+oQBhl8kKbP/iAs1xg/Sd4pc/WixKyFi2sPSY6yVbkSrRO5PCNC0ErI1lE8FMyMKWQoywGmJpNGD+jIMkEEq7joH6vJThY8xpJNhJ/Kwnjoo2jLZAoyDN/44a77L+iZE7mrankLKrdBjPjalcJHXwx4r/GfAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIsdqOcOn79fKGMmBz6+xFe5JN+c32KFuG9wKEvcaU0=;
 b=aNvloEL0atZZHktq9pDjxWSRWfuEkNF4LBVHDhWgn9IknSZPgddW0FVu2og/qLY0frvF1IN1BnDHf0Jkuf+HPTDLo0YAt/0pegHK4/Hwg9hrk3NOm2PGRcDzdg/hTHj6PS6zOWsXM4TP6XRP7WkOqhZi4E63eICtB4LRQz1TDNU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB4309.namprd12.prod.outlook.com (2603:10b6:610:a4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 08:15:24 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 08:15:24 +0000
Message-ID: <48c60002-7f75-b0d0-fb7d-44b87d9cdedd@amd.com>
Date: Thu, 30 Mar 2023 10:15:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
 <71fc098c-c0cb-3097-4e11-c2d9bd9b4783@damsy.net>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <71fc098c-c0cb-3097-4e11-c2d9bd9b4783@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH2PR12MB4309:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b66c92b-2c3a-4c21-cee6-08db30f6e95a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZYB7HK9/m9pxEfkYHENzRWlcq3wf0W4TDZoFo/oanGR5POPJ1qxHeWvqtvsszNONIZLKpWy/XIz1BX9lwX7PBrHHiFgS9guXrrbeCN1h4cgwpFvTwflxCPJcJiKcA5JqoX9zu783SlwrCQHHmR8YZWSDOIhLiB+wC2nT7mVEfRSNPFrrwWP2hvMJmxe2r423dME8jYOC2lqyggK4hosMAZlyoOkm7bZ0/WsjqMRz87fGR4JHUoJcLh2ByUMkeYjnogrYpJG4FZ0zqRlliRMVZ2v33hGB6La2DB+06NqguGjNb0LPVChKhcns+YgYcJpt0p9Z6TwmF5Fnkq3QlPzeEIT3uM283i/0gODiYJeXFlCZlmMyW1t+iTf+7znXTsRyivhYP4PUT4GY0S8uzk1WPAzt92PGuy+7xsOLjV21RafjW9OlIzEbWUX6XcWXVow1u8Bvrva3PC4N3PS7aoJ0lBi1YQBL4wrMseN9kKBwwoe/IihtSsrrguPmz0YE3TCvAsMPZ8u62A5e8mg45kZOamsotcpBV6feMU+L6qx2JoARty1bOLnHJq1RqdOEs9EJkYxder0cJS1QnXxma1Yndhh+/1ui4BNDKwZZLfTrgkU37sLkSGDxj64VBc7ZJSIbpDLn+mTUnsdkbp5Gl1VJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(31686004)(83380400001)(53546011)(26005)(31696002)(6666004)(66556008)(478600001)(316002)(66946007)(54906003)(36756003)(66476007)(41300700001)(4326008)(86362001)(6506007)(8676002)(2616005)(6512007)(186003)(6486002)(38100700002)(8936002)(5660300002)(2906002)(44832011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2pJNlBHbldIRlp6cExtYnEycTEwdWxOc0hYaFpDRlFsaXBYajFhWXNqeUV4?=
 =?utf-8?B?OGVjNThEeENOOFcyTFRobk4xZzNNRStZUUpGaEcyTHpqSnJMS0hHQWxHRGhs?=
 =?utf-8?B?cDhFNnRyREdJa1pzVTRqMTlwSmVOaDJRc1gyNUwrOGxTbWlGRnV3OEh3YS9q?=
 =?utf-8?B?emk5U0lYRjhFbG5SSFVXOGFMbHg0N0swVVNGYnFyM05FalVoMUxBNzZDdDJs?=
 =?utf-8?B?aDV5YnB1THluYjArVHJhQUcvUWdzMGpwb2VSTWN0OFpuRkVsZmNIYU9FK0Y5?=
 =?utf-8?B?eDd0Nml3T0tNMC9iWm1uRWdRUlJiODBUZ3VQMXduMVFDWWI2dW1uLzZOL2VO?=
 =?utf-8?B?NFV1ZWxHWVRGMWVFdkY2eHZLNUtiZlZPNkNQWjdVdCtWT3V6VWxoY1dOQm1U?=
 =?utf-8?B?NUsrMUxUbEVLUVExWnZzdmJEekNmM1VCT09kSnB4QWVMNkg4ZHVzZ0M3aFZ6?=
 =?utf-8?B?Q0JrV0h4d2k1MHpveWxlclJSN1RKTWhwTGJkYy9CWThvbXlGcVYxMHcyVUdM?=
 =?utf-8?B?Z2lDUnp6N2FTY0lYZEloc1JJSkxPWVhSOHRMLzIycEZLT0FkcFZuZC9WTmRD?=
 =?utf-8?B?T0hMQlRkbDZaKzBtR2ZBOWFxNk9kNFRDeURJTGo1QW9ZZUVzVTlTSytTa2FW?=
 =?utf-8?B?azFheFRYUGl1dmZLV01MYklYSWJHdUN4djZzbGtGN0xSNHhWbkd0UkJYTnlF?=
 =?utf-8?B?QzM3ejV4dm1YVXVrdytSTGM4RXJBcnoyWGxNWGlCcDdlendJL2ZMTHJOcjVB?=
 =?utf-8?B?R3pTem91SkZmYlRXQ2hFMlp3Y0tOVnFiUWtWVnhTdE5qZFFqZVd5WktPTXYr?=
 =?utf-8?B?RVJBc1hNMXlRRDBLRDR1UGtlUDJONmdzQndvd05NTE1HZ1k1MDJncVVQMTBN?=
 =?utf-8?B?SnhsQ25ScUwxUnVaQW1iYUVLemhqYzl3RnkvOXNZUnFzSTZlR0E5cXhRajIy?=
 =?utf-8?B?ZDhLMWc1aVdVQk04NE1UcS8wS3FZRk1RQ2h2bUtncUNMK2lrdHNSTTVJVndD?=
 =?utf-8?B?TWJXQmFZK2JLdk9iRVVRd1lQUEFDWUExYmlmSHNVRGx3Vm9xRGJoN2w5bnht?=
 =?utf-8?B?bkdSV01OMGdEWGNrVkxqMHA5akwvcnhVTEdwamphZmZOQkpkdjg1YTdJNzRU?=
 =?utf-8?B?N2ptbVpNK1pmdDBVSXV4TStUN3d5b25FQncreTJwWmVsajlyRFNuZnNyRWFR?=
 =?utf-8?B?cEcwVU45STZNSlZjNW83ZldzbW0vcFJ5dGMzZFlGM0t5cjQwdkdMZzZwK3Zn?=
 =?utf-8?B?Rmx1Ym9CWWJPbHlJZnN1QU9VRlA1SjR2Q2s3eGNVVE4vZTFvSExzZFN4d1dn?=
 =?utf-8?B?MUZkVnhRVi81ejBkeVBxYXc5Yk5wR25QZGNwaEU2bWlRMVZqYjc0UFBnWUNU?=
 =?utf-8?B?SDhKcmM3a3hLWVpqOS9ZTHgzdE4yR0puVmtOZXk1eTN4ZERaa3RDV0EvdVN6?=
 =?utf-8?B?QmkrWTVCWTFveStqZldjMis1czdUREVDMFNwKytib3FVa2x2NXM0SHgxRzBs?=
 =?utf-8?B?N0s3a0JIR3AySTZXbXBBTG9XSWxxL3E0Z1Joa2oySTZSdkJESW90NFJ4blFt?=
 =?utf-8?B?blN2R0lqSXk4eGhGUnB1SnJsWUUzQWVkazNHaXFCNmp4UXdlalFFTzFHRTFG?=
 =?utf-8?B?eHM1RE1sU3VraUprWk9WLzVsM0loU1lrWU1Vc21ycUtOSXBzMWF4Z3BlWWlV?=
 =?utf-8?B?aGZpSkhwMlRWeXRxeHJ6V1F5aEg2akZLUjMxUVVqeGhWWjdNcWc0dGpRUk5O?=
 =?utf-8?B?UFhHT1FpaUZpZ3JERE1UWnBZcG9oSTAwSGpjUjNER3pwZklPVmRRRmdCVlNU?=
 =?utf-8?B?VlhqOU9oRTl0RmtQdzVIRy9QMlJzSm11OXEyMVNRLzlLWkpSVC9ibVBWY3By?=
 =?utf-8?B?OWUwUXVxSTJQYjRFeXhkTWhXZWdRQ0hvM1EwQkpERmpvdm5IeWxERlo3c2FO?=
 =?utf-8?B?MnZFWGZkRWt6VXhGOFRBRGNyTHB6aXRPK2h4a3dOanlibjVweEszbVBlTjl4?=
 =?utf-8?B?VTRXcDh2cklZM2laQXVDL3dkcWQwOG5JMmViV3JpV1dBQXYvdmlrWWxldDVO?=
 =?utf-8?B?MjRJTDAvMDFQR25pNzJtTnFBd29FZW15YjNQWkNqZTFhN0VvMFBHN2J5VkR5?=
 =?utf-8?Q?Xe5JR8lDnR4TUgzsGHWPOlQ4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b66c92b-2c3a-4c21-cee6-08db30f6e95a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 08:15:24.0785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq7mX/GCPUxGvTlycmlg9eYsYrrjy1WzNycylsCjt7vmjtC/Xgh5uthcj3EPq7RrNvbAUsimWrkn71g8sZmiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4309
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
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Pierre-Eric,

Thanks for your review, my comments inline.


On 30/03/2023 10:02, Pierre-Eric Pelloux-Prayer wrote:
> Hi Shashank,
>
> On 29/03/2023 18:04, Shashank Sharma wrote:
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
>>      - Make the doorbell offset's comment clearer
>>      - Change the output parameter name to queue_id
>> V3: Integration with doorbell manager
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h 
>> b/include/uapi/drm/amdgpu_drm.h
>> index cc5d551abda5..e4943099b9d2 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -54,6 +54,7 @@ extern "C" {
>>   #define DRM_AMDGPU_VM            0x13
>>   #define DRM_AMDGPU_FENCE_TO_HANDLE    0x14
>>   #define DRM_AMDGPU_SCHED        0x15
>> +#define DRM_AMDGPU_USERQ        0x16
>>     #define DRM_IOCTL_AMDGPU_GEM_CREATE DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>>   #define DRM_IOCTL_AMDGPU_GEM_MMAP    DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
>> @@ -71,6 +72,7 @@ extern "C" {
>>   #define DRM_IOCTL_AMDGPU_VM        DRM_IOWR(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_VM, union drm_amdgpu_vm)
>>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE 
>> + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>>   #define DRM_IOCTL_AMDGPU_SCHED        DRM_IOW(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>> +#define DRM_IOCTL_AMDGPU_USERQ        DRM_IOW(DRM_COMMAND_BASE + 
>> DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>>     /**
>>    * DOC: memory domains
>> @@ -307,6 +309,59 @@ union drm_amdgpu_ctx {
>>       union drm_amdgpu_ctx_out out;
>>   };
>>   +/* user queue IOCTL */
>> +#define AMDGPU_USERQ_OP_CREATE    1
>> +#define AMDGPU_USERQ_OP_FREE    2
>> +
>> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE    (1 << 0)
>> +#define AMDGPU_USERQ_MQD_FLAGS_AQL    (1 << 1)
>
> What is the purpose of these flags?
> Could you add some documentation?
Noted,
>
>> +
>> +struct drm_amdgpu_userq_mqd {
>> +    /** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
>> +    __u32    flags;
>> +    /** IP type: AMDGPU_HW_IP_* */
>> +    __u32    ip_type;
>> +    /** GEM object handle */
>> +    __u32   doorbell_handle;
>> +    /** Doorbell's offset in the doorbell bo */
>> +    __u32   doorbell_offset;
>> +    /** GPU virtual address of the queue */
>> +    __u64   queue_va;
>> +    /** Size of the queue in bytes */
>> +    __u64   queue_size;
>> +    /** GPU virtual address of the rptr */
>> +    __u64   rptr_va;
>> +    /** GPU virtual address of the wptr */
>> +    __u64   wptr_va;
>> +    /** GPU virtual address of the shadow context space */
>> +    __u64    shadow_va;
>> +};
>
> The comments inside drm_amdgpu_userq_mqd could be improved.
> Here are some questions I have looking at the API:
> * what is a doorbell in this context?
> * what's the purpose of the doorbell offset?
> * how UMD should size each buffer? I assume doorbell, rptr, wptr
>   have min size requirements?
We are planning to add all these in a detailed doc in form of 
cover-letter/text comment in the follow-up libDRM UAPI version, as 
discussed internally.
>
> I'm also wondering why the doorbell needs a handle+offset but
> other buffers are passed in as virtual addresses?
>
As you know, doorbell offset here will be an relative offset in this 
doorbell page, but the MQD needs the absolute offset on the doorbell PCI 
BAR.

So kernel needs both the object as well as relative offset to calculate 
absolute offset.

something like: absolute offset = base offset of this doorbell page + 
relative offset of this doorbell.

>> +
>> +struct drm_amdgpu_userq_in {
>> +    /** AMDGPU_USERQ_OP_* */
>> +    __u32    op;
>> +    /** Flags */
>> +    __u32    flags;
>
> What are these flags?

We have kept these flags to indicate special conditions like secure 
display, encryption etc. We will start utilizing these once we have the

base code (this series) merged up.

>
>> +    /** Queue handle to associate the queue free call with,
>> +     * unused for queue create calls */
>> +    __u32    queue_id;
>> +    __u32    pad;
>> +    /** Queue descriptor */
>> +    struct drm_amdgpu_userq_mqd mqd;
>> +};
>
> I'm not familiar with ioctl design but would a union work to
> identify the parameters of each operation?
>
> union {
>    struct {
>       struct drm_amdgpu_userq_mqd mqd;
>    } create;
>    struct {
>       __u32 queue_id;
>       __u32 pad;
>    } free;
> };


I think it might work. I can check this out.

>
>> +
>> +struct drm_amdgpu_userq_out {
>> +    /** Queue handle */
>> +    __u32    queue_id;
>> +    /** Flags */
>> +    __u32    flags;
>
> What are these flags?
>
These are not utilized yet. We have kept these flags to indicate special 
out conditions like over subscription/failure due to no more queue slot 
etc.

Noted to be covered in the doc as well.

- Shashank


> Thanks,
> Pierre-Eric
>
>> +};
>> +
>> +union drm_amdgpu_userq {
>> +    struct drm_amdgpu_userq_in in;
>> +    struct drm_amdgpu_userq_out out;
>> +};
>> +
>>   /* vm ioctl */
>>   #define AMDGPU_VM_OP_RESERVE_VMID    1
>>   #define AMDGPU_VM_OP_UNRESERVE_VMID    2
