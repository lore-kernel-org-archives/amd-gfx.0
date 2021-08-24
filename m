Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C61C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 04:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6090F6103E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 04:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6090F6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A448189CF1;
	Tue, 24 Aug 2021 04:37:26 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07B389CF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 04:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj8Rm6LrMeJFQt/kz45Ywf17rDOUjhiPhB+zDv9C+6yDLj1v+aGycvWT54Fg0ogcu8iPZJeXr3utk64i+bXG3NMASVO2DNy03bl70O2tgiNKr31VEZdTLnaL8re7ugqRlkg0NfMw+uEvCtejR6hgJNkpo0Ou2dg8AAnm6+lx1DQgW7qG2dKGT7SSDvi09Xs6coeigh0nLoJXi8qXvH6Mk+rfqGoWCGANS/SzA2y679zY9UZWGKDNdnYJjsmmWwiddiNNpzY5qHLRCVYRf+KO4Pk9u4EbySUH/bzuMfOHDtHyGRExTeBkn2VmWfj+QnFDe4jwI92eENuJvafQZVw8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzSZYfCf3GQilEnd631vdCuNNbZRJ5ozADmzRlb+QQM=;
 b=OAcwefLWZF3GF69ALzSpuJ45MNLXEXz7QAO6c+i+sbo47J/0Nag9h98oGGPgW5Emks0kOQ8D7Kzx11plZwZzA6NUijPESOK+s2DaekTUwLFUYTlhppVbAtuvKUd1PoQmXH0ICqvepKns2NlaAiS3o6XgVZt/3/WlNwMMKgyJg7T1omZsyLPfXKcepFhONTbLoYeUkYtxSB/l0xkSx+52/fnyuskMdIgDEhmwJgHdC7gO9oFvnrpu1W5BbLoppr2OJD1VXQbVeWqBFIJO2k72TQKGgtRzBZKxVvQme5TWXH6MVVLMxTMTt29L1pu+B0mog5ap5c+9Cp/yHTKeHBeDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzSZYfCf3GQilEnd631vdCuNNbZRJ5ozADmzRlb+QQM=;
 b=l9hbOaHlhaMTzKstUszzWC0wphxNTS7govC3uXkItXlC4zuNIWyrnrbIMhyPdiI/R//jtYUxyCA+7HidaRvUPhXVICpU8JnhgJwFN0D28hf3vC24GEbvFJJiJ8zW0OWoN6jsHLLUHmqGX7ShIYr5wo8NREVPpvQ2JulskkLJjBQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5143.namprd12.prod.outlook.com (2603:10b6:208:31b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 04:37:22 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Tue, 24 Aug 2021
 04:37:21 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
To: Felix Kuehling <felix.kuehling@amd.com>,
 Joseph Greathouse <Joseph.Greathouse@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
 <6f77bb91-4ee1-3aaf-3ed8-cbccfdbcc0e5@amd.com>
 <6ef290ca-e79f-c2a2-539e-b5d2a5eb9b02@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <adff087c-ad28-b827-ad56-b1fb3b2dd50f@amd.com>
Date: Tue, 24 Aug 2021 10:07:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <6ef290ca-e79f-c2a2-539e-b5d2a5eb9b02@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::25) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 BMXPR01CA0039.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 04:37:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe381456-48da-42d0-f5f2-08d966b8dccd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5143D8A2F06CB166B10D522F97C59@BL1PR12MB5143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odGAEfqAznQghfuW08mmIJ6YN6g9nbnxSPyxbcgsqT70Dx4cP4I9ooudIqYZWrTO2BmhwJao0A1FJ/QnoBMmyD1jQIkAGMsJ+qsEE+h6vS9+PNY6HyxK6ZiXYbs1dfUsqXbC2aFjtBsydEhrMQhozmRv6Ap7olHwkkPH7yYkkHO/CxcQ98GuMFBF26aZmUg6/qU9Z1XIzZeaZ5qfM6wErxXI2AIhfzmhGxOx2FDTaTi8tDk7ilegajshXkS2FLlRYAkRad81QuYiyx8y6ZgVfPppD8V+IvRMYIeLf1T1GwWq3Agg1BbxtFqvj3xI8Odnuv04dot6gjfoszfyiPbYQVrkEZ4WQZyw2+w9GIpCv5oo5BnWAv/7rv6d/2RaTqE/iIfJmudXYU6rBqa8zSx99cRgfN8bfXzQ1+8Ee/5+6WemJtC2e98damD6SQtY7zeBXDtiWL54DNAS7f+r7XIOZMLn+r8dMVVHjniEbpRB+Xy9HOU85XTP1rmOYitgxvFt6DYmrVNHzCfttbLO6+WXqV/Ux3ahIcjh1wiNVdIBcW/QS0R2aRsT6LGKWVxEknxyHjLbeKZW3QaGlecJLPxEEJe/N/HNTiBPAd/LNKVo7velNr2Wlbz4kMigmgWxGzvaVZsKfE9MsddUQeZxoZ1GHhPwNB2UWUxihhB1d+aM0F9oyQCE2L4WHbz0IQ6WfZZVm9nuqtXUajmUtJZvETqvNHNT1I3lX6RME+qqiiLdlCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(16576012)(316002)(5660300002)(83380400001)(110136005)(66476007)(53546011)(8676002)(26005)(186003)(2616005)(956004)(66556008)(8936002)(6486002)(2906002)(38100700002)(478600001)(31686004)(36756003)(31696002)(86362001)(30864003)(6666004)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDF0UXJXdjVjMG1tQnNsUXExVzROS1ZVQ0N1WnlvSzFibVRiYlgzUWNLbXpI?=
 =?utf-8?B?bHZ5Z2I1ajcxT2VET3JkODdWNUZQbW5TQUdONnpFSlhQOFUyTDJzZU9mTFZ3?=
 =?utf-8?B?U2h5MlhFcGIvaVlheXozT2d0Yi9DUzBSQ1dLYUhmNndrbEJ2eU16OWZKbHhC?=
 =?utf-8?B?SndOTjZuNGYrelJVMHk4WDhjbE9KMVdub0xXMmtjdHhWSU5zRFByS2tIazl1?=
 =?utf-8?B?cUdNSUM3cmU1TVBwUFBTYnllZDA0MmwyTk1mTUN0Ums0bTlmYlJPTWs3SW0x?=
 =?utf-8?B?ZHlUQXlRUXYrUUVnWkhwMmtXMGNOSjBwd3RqYjEwcE9GUGQzRUN2Q1pqQmxJ?=
 =?utf-8?B?M25qQkJOcUtxdWhkck8rUldpU2trOThNbGFNb1hHVmp2WCt6S3FpN1hENnBy?=
 =?utf-8?B?ZElQOUVpYXIxZElYbnROOHFmWmIzY1R5NHZtQlRzWkQzTGlEaTNJdU4zTWps?=
 =?utf-8?B?aWtmVE94TUZsK3B4QXV4bCtYblk1RHJPTGxZU2xYOWcvOGlRekdSck5ERW80?=
 =?utf-8?B?eW9TbEVIMjgrQ1FtT2hZSW5nanVWbmdid2lkVDJibEFtRmthdDdac3ZTbnh6?=
 =?utf-8?B?c25uT0YwMmdjWWt6RWx6S0haS3Nya1RBMmZNMGpZbHVYQlZoNDhXY1pWTEY3?=
 =?utf-8?B?UUphZkZDckhjaHhKTVIzSitXaHdpQXZmT0NxLzVoc3BMd0JldlQ5NklOc2NQ?=
 =?utf-8?B?OGpPWUR1dTFObkRCcmkzUG5SZ01CMllzbXphaDRkUTgxRHpQSEExVXhLY1VR?=
 =?utf-8?B?M2dGZksxOWFuUnJhOGQ4WTFlem9INnlicnhyWGpMUC95NW1COEwzWldHOEdI?=
 =?utf-8?B?K2VLNTE2bWgxOEtkdzVFQWhhTThiQk9YYTlkZ3J5aGZVdGVuYkovQlZ2clFS?=
 =?utf-8?B?NHJzbVhsSHluWFhHbkxHd3htaWdZVEpIQzVxTmVEbWhaYXVSQWpBem1HT1Bs?=
 =?utf-8?B?NlVjdnpBZ3VSYkRseks5ZHhCNlpwUW1lWnNSMXM2dHZ5YkdEdVZEbVFKQW05?=
 =?utf-8?B?cmNXK0ZzQTArdVR3TFltbTFVWGJWVGhPMlplK2NlTXVFY2Z1OXRDYTZ0SE9K?=
 =?utf-8?B?ck5KQ2VkZ3ltbnZCemZPMU5zV2FMcFFEeG41MVNHTkdXYTJBcGFKY0xyVXpU?=
 =?utf-8?B?V0xtYXhQYlNqMnQvQnBQalRmdXdSdmdJSWNISld3UlJzMkJiRnVGZXdGVzJG?=
 =?utf-8?B?VlFCdjcvV1V3UGRGZUtDMTN5aFFRM1JPZFJ2T1J5SlNabmJOSlZSNzkzQ3JN?=
 =?utf-8?B?WTgrYSs0d0dDMzJGUmdDK0FJTHJlZjNiNWxCKzlkc0JNTXRtcXBZMjQ4a0xk?=
 =?utf-8?B?OTgvY3JjWE5lN2Ftem1wVGl6dU13cy9FOUNiT05JejdSUlYvekRmSFh2Tml0?=
 =?utf-8?B?U1E3ZTFqR1JPQnFzU0ZsUUJsR3cvM1l1VUJRR3B5cEk0MHhLSFF1T3dFamF5?=
 =?utf-8?B?RXA4eUZ2U3R1QmZmaWRqU2MrMjRrTERYZzVQeTlKdHlueHZwMm03OXY5YkJs?=
 =?utf-8?B?OU9JL1k4TU8ycEQxbVpJWVEzUDZmRzVxeFJ1dURHTElObDBlS2lyU3NmeUIv?=
 =?utf-8?B?TXNKUGliVUFFb2pFUy9RdFFESHRvRFZSTkhEOHZyK24rZ0tLMm9aY3BDQXcy?=
 =?utf-8?B?S3RiY0tzNUhIKzZURENraVZhSTVObnVXZms4K0tLWlp6dCtHK3FBM3RVbGIv?=
 =?utf-8?B?ZFJMM1BxcDJpdThWQzh2WjlERWVUZTYyRGxmN0xzMlJQU3FBRDVlNFRZdUJs?=
 =?utf-8?Q?f/xJ9nf6L9o3zZFtAokB6ouFIpuUEmgNRiwNlaA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe381456-48da-42d0-f5f2-08d966b8dccd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 04:37:21.7900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bY+U/UZcEjj9FFDYcirU3V9hhcMAfMIhMH0QCVe2mpv46wOFV9VTukadMN39Fr4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5143
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



On 8/23/2021 10:34 PM, Felix Kuehling wrote:
> Am 2021-08-23 um 3:08 a.m. schrieb Lazar, Lijo:
>>
>>
>> On 8/20/2021 11:02 AM, Joseph Greathouse wrote:
>>> Give every process at most one queue from each SDMA engine.
>>> Previously, we allocated all SDMA engines and queues on a first-
>>> come-first-serve basis. This meant that it was possible for two
>>> processes racing on their allocation requests to each end up with
>>> two queues on the same SDMA engine. That could serialize the
>>> performance of commands to different queues.
>>>
>>> This new mechanism allows each process at most a single queue
>>> on each SDMA engine. Processes will check for queue availability on
>>> SDMA engine 0, then 1, then 2, etc. and only allocate on that
>>> engine if there is an available queue slot. If there are no
>>> queue slots available (or if this process has already allocated
>>> a queue on this engine), it moves on and tries the next engine.
>>>
>>> The Aldebaran chip has a small quirk that SDMA0 should only be
>>> used by the very first allocation from each process. It is OK to
>>> use any other SDMA engine at any time, but after the first SDMA
>>> allocation request from a process, the resulting engine must
>>> be from SDMA1 or above. This patch handles this case as well.
>>>
>>> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>>> ---
>>>    .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 +++++++++++++-----
>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +
>>>    3 files changed, 107 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index f8fce9d05f50..86bdb765f350 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -52,12 +52,14 @@ static int unmap_queues_cpsch(struct
>>> device_queue_manager *dqm,
>>>    static int map_queues_cpsch(struct device_queue_manager *dqm);
>>>      static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>>> +                struct qcm_process_device *qpd,
>>>                    struct queue *q);
>>>      static inline void deallocate_hqd(struct device_queue_manager *dqm,
>>>                    struct queue *q);
>>>    static int allocate_hqd(struct device_queue_manager *dqm, struct
>>> queue *q);
>>>    static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>> +                struct qcm_process_device *qpd,
>>>                    struct queue *q);
>>>    static void kfd_process_hw_exception(struct work_struct *work);
>>>    @@ -349,7 +351,7 @@ static int create_queue_nocpsch(struct
>>> device_queue_manager *dqm,
>>>                q->pipe, q->queue);
>>>        } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>            q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>> -        retval = allocate_sdma_queue(dqm, q);
>>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>>            if (retval)
>>>                goto deallocate_vmid;
>>>            dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
>>> @@ -410,7 +412,7 @@ static int create_queue_nocpsch(struct
>>> device_queue_manager *dqm,
>>>            deallocate_hqd(dqm, q);
>>>        else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>            q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>> -        deallocate_sdma_queue(dqm, q);
>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>    deallocate_vmid:
>>>        if (list_empty(&qpd->queues_list))
>>>            deallocate_vmid(dqm, qpd, q);
>>> @@ -475,9 +477,9 @@ static int destroy_queue_nocpsch_locked(struct
>>> device_queue_manager *dqm,
>>>        if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>>            deallocate_hqd(dqm, q);
>>>        else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>>> -        deallocate_sdma_queue(dqm, q);
>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>        else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>> -        deallocate_sdma_queue(dqm, q);
>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>        else {
>>>            pr_debug("q->properties.type %d is invalid\n",
>>>                    q->properties.type);
>>> @@ -1039,42 +1041,93 @@ static void pre_reset(struct
>>> device_queue_manager *dqm)
>>>        dqm_unlock(dqm);
>>>    }
>>>    +static uint64_t sdma_engine_mask(int engine, int num_engines)
>>
>> Looks more like the queue mask for an engine, the name doesn't make it
>> clear.
>>
>>> +{
>>> +    uint64_t mask = 0;
>>> +
>>> +    engine %= num_engines;
>>> +    while (engine < (sizeof(uint64_t)*8)) {
>>> +        mask |= 1ULL << engine;
>>> +        engine += num_engines;
>>> +    }
>>> +    return mask;
>>> +}
>>> +
>>>    static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>> +                struct qcm_process_device *qpd,
>>>                    struct queue *q)
>>>    {
>>> -    int bit;
>>> +    uint64_t available_queue_bitmap;
>>> +    unsigned int bit, engine, num_engines;
>>> +    bool found_sdma = false;
>>>          if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>>> -        if (dqm->sdma_bitmap == 0) {
>>
>> This is still a valid optimization and no need to loop through if
>> nothing is available anyway. Valid for XGMI loop also.
>>
>>> +        num_engines = get_num_sdma_engines(dqm);
>>> +        for_each_set_bit(engine, &(qpd->sdma_engine_bitmap),
>>> num_engines) {
>>
>> Probably a naive question -
>>
>> Theoretically there are 8 queues per engine as per the mask code. In
>> the below code, there is an assumption that a process will use at best
>> number of queues=max num of sdma engines or xgmi engines
>> simultaneously. Is that true always? For ex: there are 2 sdma engines
>> and 4 queues per engine. Can't multiple threads of a process initiate
>> multiple sdma transactions > number of sdma engines available? This
>> code limits that, but I don't know if that is a possible case.
> 
> When you use multiple SDMA queues on the same engine, the work from the
> queues gets serialized. You can either let the SDMA engine serialize
> work from multiple queues, or let ROCr serialize work from multiple
> threads on the same SDMA queue. There is no obvious benefit to let the
> SDMA engine do it. But there is a drawback: Fewer processes get to use SDMA.
> 

The fact that there exists multiple queues and there is no such 
assumption made in existing logic (prior to the patch) tells that there 
is indeed some advantage of making use of hardware queues. For ex: 
switching to different ring buffer may not need context save/resubmission.

Just like different processes, different threads of same process may 
take advantage of multiple queues. More interested to see the impact in 
cases where the focus is on single process ex: impact on running some 
benchmarks or in HPC where entire hardware is dedicated for a specific 
compute purpose.

Thanks,
Lijo

> Regards,
>    Felix
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>> +            /* Do not reuse SDMA0 for any subsequent SDMA queue
>>> +             * requests on Aldebaran. If SDMA0's queues are all
>>> +             * full, then this process should never use SDMA0
>>> +             * for any further requests
>>> +             */
>>> +            if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>>> +                    engine == 0)
>>> +                qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>>> +
>>> +            available_queue_bitmap = sdma_engine_mask(engine,
>>> num_engines);
>>> +            available_queue_bitmap &= dqm->sdma_bitmap;
>>> +
>>> +            if (!available_queue_bitmap)
>>> +                continue;
>>> +            /* Take the selected engine off the list so we will not
>>> +             * allocate two queues onto the same engine
>>> +             */
>>> +            qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>>> +            found_sdma = true;
>>> +
>>> +            bit = __ffs64(available_queue_bitmap);
>>> +            dqm->sdma_bitmap &= ~(1ULL << bit);
>>> +            q->sdma_id = bit;
>>> +            q->properties.sdma_engine_id = q->sdma_id % num_engines;
>>> +            q->properties.sdma_queue_id = q->sdma_id / num_engines;
>>> +            break;
>>> +        }
>>> +        if (!found_sdma) {
>>>                pr_err("No more SDMA queue to allocate\n");
>>>                return -ENOMEM;
>>>            }
>>> -
>>> -        bit = __ffs64(dqm->sdma_bitmap);
>>> -        dqm->sdma_bitmap &= ~(1ULL << bit);
>>> -        q->sdma_id = bit;
>>> -        q->properties.sdma_engine_id = q->sdma_id %
>>> -                get_num_sdma_engines(dqm);
>>> -        q->properties.sdma_queue_id = q->sdma_id /
>>> -                get_num_sdma_engines(dqm);
>>>        } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>> -        if (dqm->xgmi_sdma_bitmap == 0) {
>>> +        num_engines = get_num_xgmi_sdma_engines(dqm);
>>> +        for_each_set_bit(engine, &(qpd->xgmi_sdma_engine_bitmap),
>>> num_engines) {
>>> +            available_queue_bitmap = sdma_engine_mask(engine,
>>> num_engines);
>>> +            available_queue_bitmap &= dqm->xgmi_sdma_bitmap;
>>> +
>>> +            if (!available_queue_bitmap)
>>> +                continue;
>>> +            /* Take the selected engine off the list so we will not
>>> +             * allocate two queues onto the same engine
>>> +             */
>>> +            qpd->xgmi_sdma_engine_bitmap &= ~(1ULL << engine);
>>> +            found_sdma = true;
>>> +
>>> +            bit = __ffs64(available_queue_bitmap);
>>> +            dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>>> +            q->sdma_id = bit;
>>> +            /* sdma_engine_id is sdma id including
>>> +             * both PCIe-optimized SDMAs and XGMI-
>>> +             * optimized SDMAs. The calculation below
>>> +             * assumes the first N engines are always
>>> +             * PCIe-optimized ones
>>> +             */
>>> +            q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>>> +                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>>> +            q->properties.sdma_queue_id = q->sdma_id /
>>> +                get_num_xgmi_sdma_engines(dqm);
>>> +            break;
>>> +        }
>>> +        if (!found_sdma) {
>>>                pr_err("No more XGMI SDMA queue to allocate\n");
>>>                return -ENOMEM;
>>>            }
>>> -        bit = __ffs64(dqm->xgmi_sdma_bitmap);
>>> -        dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>>> -        q->sdma_id = bit;
>>> -        /* sdma_engine_id is sdma id including
>>> -         * both PCIe-optimized SDMAs and XGMI-
>>> -         * optimized SDMAs. The calculation below
>>> -         * assumes the first N engines are always
>>> -         * PCIe-optimized ones
>>> -         */
>>> -        q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>>> -                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>>> -        q->properties.sdma_queue_id = q->sdma_id /
>>> -                get_num_xgmi_sdma_engines(dqm);
>>>        }
>>>          pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
>>> @@ -1084,16 +1137,32 @@ static int allocate_sdma_queue(struct
>>> device_queue_manager *dqm,
>>>    }
>>>      static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>>> +                struct qcm_process_device *qpd,
>>>                    struct queue *q)
>>>    {
>>> +    uint32_t engine = q->properties.sdma_engine_id;
>>> +
>>>        if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>>>            if (q->sdma_id >= get_num_sdma_queues(dqm))
>>>                return;
>>>            dqm->sdma_bitmap |= (1ULL << q->sdma_id);
>>> +        /* Don't give SDMA0 back to be reallocated on Aldebaran.
>>> +         * It is only OK to use this engine from the first allocation
>>> +         * within a process.
>>> +         */
>>> +        if (!(dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>>> +                    engine == 0))
>>> +            qpd->sdma_engine_bitmap |= (1ULL << engine);
>>> +
>>>        } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>            if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
>>>                return;
>>>            dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
>>> +        /* engine ID in the queue properties is the global engine ID.
>>> +         * The XGMI engine bitmap ignores the PCIe-optimized engines.
>>> +         */
>>> +        engine -= get_num_sdma_engines(dqm);
>>> +        qpd->xgmi_sdma_engine_bitmap |= (1ULL << engine);
>>>        }
>>>    }
>>>    @@ -1303,7 +1372,7 @@ static int create_queue_cpsch(struct
>>> device_queue_manager *dqm, struct queue *q,
>>>        if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>            q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>            dqm_lock(dqm);
>>> -        retval = allocate_sdma_queue(dqm, q);
>>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>>            dqm_unlock(dqm);
>>>            if (retval)
>>>                goto out;
>>> @@ -1365,7 +1434,7 @@ static int create_queue_cpsch(struct
>>> device_queue_manager *dqm, struct queue *q,
>>>        if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>>            q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>>            dqm_lock(dqm);
>>> -        deallocate_sdma_queue(dqm, q);
>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>            dqm_unlock(dqm);
>>>        }
>>>    out:
>>> @@ -1536,7 +1605,7 @@ static int destroy_queue_cpsch(struct
>>> device_queue_manager *dqm,
>>>          if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>>            (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>>> -        deallocate_sdma_queue(dqm, q);
>>> +        deallocate_sdma_queue(dqm, qpd, q);
>>>            pdd->sdma_past_activity_counter += sdma_val;
>>>        }
>>>    @@ -1751,9 +1820,9 @@ static int process_termination_cpsch(struct
>>> device_queue_manager *dqm,
>>>        /* Clear all user mode queues */
>>>        list_for_each_entry(q, &qpd->queues_list, list) {
>>>            if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>>> -            deallocate_sdma_queue(dqm, q);
>>> +            deallocate_sdma_queue(dqm, qpd, q);
>>>            else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>>> -            deallocate_sdma_queue(dqm, q);
>>> +            deallocate_sdma_queue(dqm, qpd, q);
>>>              if (q->properties.is_active) {
>>>                decrement_queue_count(dqm, q->properties.type);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index ab83b0de6b22..c38eebc9db4d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -576,6 +576,8 @@ struct qcm_process_device {
>>>        struct list_head priv_queue_list;
>>>          unsigned int queue_count;
>>> +    unsigned long sdma_engine_bitmap;
>>> +    unsigned long xgmi_sdma_engine_bitmap;
>>>        unsigned int vmid;
>>>        bool is_debug;
>>>        unsigned int evicted; /* eviction counter, 0=active */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> index 21ec8a18cad2..13c85624bf7d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>> @@ -1422,6 +1422,7 @@ struct kfd_process_device
>>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>>                                struct kfd_process *p)
>>>    {
>>>        struct kfd_process_device *pdd = NULL;
>>> +    const struct kfd_device_info *dev_info =
>>> dev->dqm->dev->device_info;
>>>          if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
>>>            return NULL;
>>> @@ -1446,6 +1447,8 @@ struct kfd_process_device
>>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>>        pdd->qpd.pqm = &p->pqm;
>>>        pdd->qpd.evicted = 0;
>>>        pdd->qpd.mapped_gws_queue = false;
>>> +    pdd->qpd.sdma_engine_bitmap =
>>> BIT_ULL(dev_info->num_sdma_engines) - 1;
>>> +    pdd->qpd.xgmi_sdma_engine_bitmap =
>>> BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
>>>        pdd->process = p;
>>>        pdd->bound = PDD_UNBOUND;
>>>        pdd->already_dequeued = false;
>>>
