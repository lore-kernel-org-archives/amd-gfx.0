Return-Path: <SRS0=mBQi=NO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC79C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 17:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4192961371
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Aug 2021 17:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4192961371
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD3589CDE;
	Mon, 23 Aug 2021 17:04:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C19189CDE
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Aug 2021 17:04:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7WgN/sB7WS408w12XsJV/7jvAEQfdmWJTnb9orFD4Tf5392Vk8/TxQ3v2MOlvZDFZVVqZMjIqtk1Uue7+78N/qVQKWEHJqaqpw6WFb95dDOFvtLhgwtVpurIfO6/ebNmbbc6LroCe3s2EmZIhI51xZYuQrfc6eq2f5fxciamimJO/hu1ynepwOzqQ/2cCeHwJN7QlksXgCbmjssoV8pU4hgX1JdqKrib1ZrkgjjmoT2pDcbFRDvnVDYn8imlg9o3h0xfp3LQZzg1AoiBYEFjCnXgZnZD+m6iewEVdE7uU+mMfkDfIdY3TdB/ouDX+QRdrjOXVSMeAxFJsOVWsJLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVezbs5mgj8I1tNvIiYPrmHNBeJ0pis0L6wtiZYoQew=;
 b=IflZYmSAJidf0xpaLHRC3/lG2PisArFR/cG+KVw3OxkSPy5getKcxb70chkclNGo0hkNw3sAMkKEKHg0JpNNB44QD65lIICHtQytJUJJ4OVwxpxjemU1zou0dsp/KGJBSeJ8o2QyrLpaDbo1UvLghNK7+roVXuZt3P5W8hL4Dz/yJeBgvoh/am2+Nxp2Z/P6fXqfmXU/b0EDeqWiVQfnDqB0rF/pbPxaGkI9mqMqUd15iuxs5CiSny7P7NL/Dk9j3bZGUz4ecUW6qKsM7szLBOM/XBW0LBCqVzXtwagBiCirIY/gpxJOXv03hfUgjidLE+q5VrHWyTvu97abnpBp2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVezbs5mgj8I1tNvIiYPrmHNBeJ0pis0L6wtiZYoQew=;
 b=gNLNqCfcDMzS5u31SMH67agvNuMXRHEQdZMo8NTX08tOJeJ/TOswyydCpCPei9kP+va5U4wG2arjoGj2v9ae2vI/QlZFVp/8JXKMbw1BQD8BW/POW+9xOdzdwlN8Cx3aumV/2MdpXO7gfNlwEM3YDXaTorylNxjz3DPHpNwQoT8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Mon, 23 Aug
 2021 17:04:10 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 17:04:10 +0000
Subject: Re: [PATCH 1/3] drm/amdkfd: Allocate SDMA engines more fairly
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Joseph Greathouse <Joseph.Greathouse@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210820053245.340945-1-Joseph.Greathouse@amd.com>
 <6f77bb91-4ee1-3aaf-3ed8-cbccfdbcc0e5@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <6ef290ca-e79f-c2a2-539e-b5d2a5eb9b02@amd.com>
Date: Mon, 23 Aug 2021 13:04:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <6f77bb91-4ee1-3aaf-3ed8-cbccfdbcc0e5@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::12) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0071.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 17:04:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd41ee41-ce83-4669-c49c-08d96658063a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5305BBCCD678443D9AD16D9692C49@BN9PR12MB5305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: omZTuT3M+LpHhRY/Xefs9BW+kIkeJQ02vj3OZE5ECFCpvHKAhYivBgGODipMW5LLC1YbQliNw4AAVJQn/ZzsLETVrLqd8hiqYtjh9sxoxBVEYSNfh742X3hT5Pkh7aoBP3TXmXhw+Qxx6ZEh3qFmso4p/NF+4MNV2z7E6GDi8RkRMIgwSXtX/qaJeQqJhlDQpCG79/oVqlpvNp25dc9kMP8z0L/KcbQJbNf6N4U5b4+DgacuqeeDDb3GdeY3mSc5opKRiKm7RsYLhA+1cZGIyc80bg5HuWIPbm5wDyHR9M/T7o+alM4rkMkK5dCa+7jKAeIZ5VTLLIv/kdieV2bY+gDLKsli8B3SHjGnLeZHHES9pUV6QsOHMxOgTgmJPGGFuMW0gVR798imN0GHEKRlU2EoGGeVLhJzCDM87SpFFwEgZEythwx+GyiLXtjmanQeOr8RIKahSXbgdvxTsCAUmjY3bCjH9BQ/m9M1I//dzrmjMLMEEPizFn/0W/hDEQTKqK5MtD1U/7ZLzqiO9UtHdtm0kokVTs34VskunjF6OabE1Gf+mbwftiC7/rki1UARlsGC2CsTbXOj08tiqRLkXMAwqppiiDD2IZRmORpgBgKmZeTqQR5cu4WQqxWCpPHBsCf1NeiX4YO3hN/9WsEejn4DJJuCnfCR3fZ5ZZYKhGSQOfmZanzUjzd4I0V1slWlHuUTRzn+H+WxJjvjJ2zcH1w9dhkKt2bT+HLc6VUXuQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(956004)(83380400001)(2616005)(26005)(53546011)(186003)(2906002)(36756003)(30864003)(6486002)(16576012)(316002)(110136005)(66476007)(66556008)(478600001)(66946007)(44832011)(31696002)(5660300002)(8936002)(8676002)(31686004)(38100700002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Skx6NGhDVllHTitxNHlPS25uNElqcE5Vd1E2NTZ6ZjIrczAwb2F1Y2orVmxC?=
 =?utf-8?B?RlBET2VIQmNuNVN0d2M0RHlWMXFSd21nTVJhOXVIMWtiYkVUbXF6T0hIZDY0?=
 =?utf-8?B?dHlmNnNaWVAxcldRZlBXcDRvdkUxVUJRUmFRUU1wM000RWluc2dVeDBiTjIz?=
 =?utf-8?B?eGljNm1iOHJobUN2NmN3ZDdMK1dpTXo2a3NKOWJjVUxHQVFvWEl3cjBXZVlO?=
 =?utf-8?B?OWpCR3ZzNGhHMWJGRWNnOW92Q0NYTVRMVEZFajVwT1lGdEZQVCtBRnBwNHlC?=
 =?utf-8?B?RlI1OVpMYVZLWm1iSFJHZkhnZjI0cHpKSWJ3d0YvdlFNbGcxcUVqbVhtcDZl?=
 =?utf-8?B?Zk1TOUZ2Zm83VC9YTmZiZTN3TmxWUDU0blB0NjNvNmFNa25vbkY4aFdTZS9C?=
 =?utf-8?B?ekdZYVlZNjJQRng1MjM3Rlo0Z1hUOUNrR200b3FGM1F6S3lvbjlaVjF4Lytl?=
 =?utf-8?B?dUl4djlHNURHemMwSUIzYkgwSGcwSUlJZlJnUS9pYVY0QllLaWJWU2h1a1Ey?=
 =?utf-8?B?NGRSZkROUTg1Ukp4NS9sMVVkeGlvWG95UEVrRjdYeHF2eEdKVTF5M2d6U09H?=
 =?utf-8?B?c2x6Z1VkOVVoMmJMRlIzWEJoNUpFaUowTkJwUzNiRjloWmt5bUxtSkRkcmlz?=
 =?utf-8?B?MGpqc0VjTXFQZy9XcWVTaHk5TGRNMDJQOXhnOTZGUmpDMmlIS1FRd1EwM2hP?=
 =?utf-8?B?MG1COE9xSUZRQTJKRXg0YjNRb3lpSUViYkI1QXZQRndxN2hQTjJjdTlVWDAr?=
 =?utf-8?B?SGVkY2tXbFl0YkUzZENVelArWnVjTDViNXJXOEliS2pJeUJ5SWo0RU1ISzFX?=
 =?utf-8?B?Z2NtY1BZR0pCNDE4MWdic1RxTURDNkN3NlBONXVpalVBQVN1Um44QU5ZL2Ju?=
 =?utf-8?B?WVJlanZSQlNxS1lFOTZiNDMyRFFjeDkxNStsU282NUNpTUVlUndTL0dVUzZF?=
 =?utf-8?B?SmJGY1JxTXNUM3FlcCtsUUFPZTdDNzVtcE51ZTNIN1BkdGVyVHc5OHUyQWp4?=
 =?utf-8?B?aFFjV1FWaDF2Z0hyeDhwaXdFREREZUxqcURXenFIRXh6UkZTdUZFZFlLYVBu?=
 =?utf-8?B?Q2V4UzgyYUJkNDVHWnVRSlVyVjN4N0NJTmU1YWU2SzlIam5TcENocmdRYUhF?=
 =?utf-8?B?bGlYWGkwSUZUVWFvZXRNTTV5Mk5RcC9LemZuaWxWTzcvTEJsV3N3eTF2SEdY?=
 =?utf-8?B?MkZhN3lFVGZVeTZubmZGejVreVJ1ZHFJQ3Rzckt0eUJjdTQva3habnIrK0lk?=
 =?utf-8?B?SG9EdnRXYm5Vd2s2SkNFR3BpKzFMc0JuY043WmhFNGp6alJHTkNPRzF2VUxE?=
 =?utf-8?B?aFFRTGcvWWhKb1JwV2JZWVFBN0pvL3c0SXR3dUFQaUtESFAydWduUDBONjcz?=
 =?utf-8?B?eFoybjJJUWlXRFgrejFxTi9TRE5Wc2pMM0ErOHBucGpzK216YjRwZ3RUcnhW?=
 =?utf-8?B?TmNtNDJ0aGpBSG5leGVHK3p1VlRTMzdUN1Y1Z05ESTdCdmJIK0l2dUhZTWVX?=
 =?utf-8?B?bmFkWUU2ay9ibzdia21IV3dLVDY3VUp3T1NjMVVNN241M3Y5RC9UQVlqU093?=
 =?utf-8?B?RnZuVXM4OUdQanJpaUtCZVhmZk9QakxrNHlwNTFaTjlEaEl5R05iUnBqQ3ZM?=
 =?utf-8?B?SS94dDJTUmh2Z1RJdkNhMzZRcUx2cm1obU53Y2ZCTnMwaitBSUZRTy9jUjhk?=
 =?utf-8?B?MUZjRDgvbmFvNk44NVo3ekJqbGVMWUZ4MzZxdmZBd2ErL1BiRmpxcVN6Vk9Z?=
 =?utf-8?Q?6EHeiaRlRue0NQZB8lsew3VMNuU+Ov44nCHzRL1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd41ee41-ce83-4669-c49c-08d96658063a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 17:04:09.9516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q20RpCWXsB6H7741Q1fC1NRpviZyg4KPy5ID8fYaV8VWF46OOXvAEBprfAur1/sKD487jGG8lVTMXKAR7mpEgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
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

Am 2021-08-23 um 3:08 a.m. schrieb Lazar, Lijo:
>
>
> On 8/20/2021 11:02 AM, Joseph Greathouse wrote:
>> Give every process at most one queue from each SDMA engine.
>> Previously, we allocated all SDMA engines and queues on a first-
>> come-first-serve basis. This meant that it was possible for two
>> processes racing on their allocation requests to each end up with
>> two queues on the same SDMA engine. That could serialize the
>> performance of commands to different queues.
>>
>> This new mechanism allows each process at most a single queue
>> on each SDMA engine. Processes will check for queue availability on
>> SDMA engine 0, then 1, then 2, etc. and only allocate on that
>> engine if there is an available queue slot. If there are no
>> queue slots available (or if this process has already allocated
>> a queue on this engine), it moves on and tries the next engine.
>>
>> The Aldebaran chip has a small quirk that SDMA0 should only be
>> used by the very first allocation from each process. It is OK to
>> use any other SDMA engine at any time, but after the first SDMA
>> allocation request from a process, the resulting engine must
>> be from SDMA1 or above. This patch handles this case as well.
>>
>> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
>> ---
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 135 +++++++++++++-----
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   3 +
>>   3 files changed, 107 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index f8fce9d05f50..86bdb765f350 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -52,12 +52,14 @@ static int unmap_queues_cpsch(struct
>> device_queue_manager *dqm,
>>   static int map_queues_cpsch(struct device_queue_manager *dqm);
>>     static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>> +                struct qcm_process_device *qpd,
>>                   struct queue *q);
>>     static inline void deallocate_hqd(struct device_queue_manager *dqm,
>>                   struct queue *q);
>>   static int allocate_hqd(struct device_queue_manager *dqm, struct
>> queue *q);
>>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
>> +                struct qcm_process_device *qpd,
>>                   struct queue *q);
>>   static void kfd_process_hw_exception(struct work_struct *work);
>>   @@ -349,7 +351,7 @@ static int create_queue_nocpsch(struct
>> device_queue_manager *dqm,
>>               q->pipe, q->queue);
>>       } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>           q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>> -        retval = allocate_sdma_queue(dqm, q);
>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>           if (retval)
>>               goto deallocate_vmid;
>>           dqm->asic_ops.init_sdma_vm(dqm, q, qpd);
>> @@ -410,7 +412,7 @@ static int create_queue_nocpsch(struct
>> device_queue_manager *dqm,
>>           deallocate_hqd(dqm, q);
>>       else if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>           q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>> -        deallocate_sdma_queue(dqm, q);
>> +        deallocate_sdma_queue(dqm, qpd, q);
>>   deallocate_vmid:
>>       if (list_empty(&qpd->queues_list))
>>           deallocate_vmid(dqm, qpd, q);
>> @@ -475,9 +477,9 @@ static int destroy_queue_nocpsch_locked(struct
>> device_queue_manager *dqm,
>>       if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>           deallocate_hqd(dqm, q);
>>       else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>> -        deallocate_sdma_queue(dqm, q);
>> +        deallocate_sdma_queue(dqm, qpd, q);
>>       else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>> -        deallocate_sdma_queue(dqm, q);
>> +        deallocate_sdma_queue(dqm, qpd, q);
>>       else {
>>           pr_debug("q->properties.type %d is invalid\n",
>>                   q->properties.type);
>> @@ -1039,42 +1041,93 @@ static void pre_reset(struct
>> device_queue_manager *dqm)
>>       dqm_unlock(dqm);
>>   }
>>   +static uint64_t sdma_engine_mask(int engine, int num_engines)
>
> Looks more like the queue mask for an engine, the name doesn't make it
> clear.
>
>> +{
>> +    uint64_t mask = 0;
>> +
>> +    engine %= num_engines;
>> +    while (engine < (sizeof(uint64_t)*8)) {
>> +        mask |= 1ULL << engine;
>> +        engine += num_engines;
>> +    }
>> +    return mask;
>> +}
>> +
>>   static int allocate_sdma_queue(struct device_queue_manager *dqm,
>> +                struct qcm_process_device *qpd,
>>                   struct queue *q)
>>   {
>> -    int bit;
>> +    uint64_t available_queue_bitmap;
>> +    unsigned int bit, engine, num_engines;
>> +    bool found_sdma = false;
>>         if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>> -        if (dqm->sdma_bitmap == 0) {
>
> This is still a valid optimization and no need to loop through if
> nothing is available anyway. Valid for XGMI loop also.
>
>> +        num_engines = get_num_sdma_engines(dqm);
>> +        for_each_set_bit(engine, &(qpd->sdma_engine_bitmap),
>> num_engines) {
>
> Probably a naive question -
>
> Theoretically there are 8 queues per engine as per the mask code. In
> the below code, there is an assumption that a process will use at best
> number of queues=max num of sdma engines or xgmi engines
> simultaneously. Is that true always? For ex: there are 2 sdma engines
> and 4 queues per engine. Can't multiple threads of a process initiate
> multiple sdma transactions > number of sdma engines available? This
> code limits that, but I don't know if that is a possible case.

When you use multiple SDMA queues on the same engine, the work from the
queues gets serialized. You can either let the SDMA engine serialize
work from multiple queues, or let ROCr serialize work from multiple
threads on the same SDMA queue. There is no obvious benefit to let the
SDMA engine do it. But there is a drawback: Fewer processes get to use SDMA.

Regards,
  Felix


>
> Thanks,
> Lijo
>
>> +            /* Do not reuse SDMA0 for any subsequent SDMA queue
>> +             * requests on Aldebaran. If SDMA0's queues are all
>> +             * full, then this process should never use SDMA0
>> +             * for any further requests
>> +             */
>> +            if (dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>> +                    engine == 0)
>> +                qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>> +
>> +            available_queue_bitmap = sdma_engine_mask(engine,
>> num_engines);
>> +            available_queue_bitmap &= dqm->sdma_bitmap;
>> +
>> +            if (!available_queue_bitmap)
>> +                continue;
>> +            /* Take the selected engine off the list so we will not
>> +             * allocate two queues onto the same engine
>> +             */
>> +            qpd->sdma_engine_bitmap &= ~(1ULL << engine);
>> +            found_sdma = true;
>> +
>> +            bit = __ffs64(available_queue_bitmap);
>> +            dqm->sdma_bitmap &= ~(1ULL << bit);
>> +            q->sdma_id = bit;
>> +            q->properties.sdma_engine_id = q->sdma_id % num_engines;
>> +            q->properties.sdma_queue_id = q->sdma_id / num_engines;
>> +            break;
>> +        }
>> +        if (!found_sdma) {
>>               pr_err("No more SDMA queue to allocate\n");
>>               return -ENOMEM;
>>           }
>> -
>> -        bit = __ffs64(dqm->sdma_bitmap);
>> -        dqm->sdma_bitmap &= ~(1ULL << bit);
>> -        q->sdma_id = bit;
>> -        q->properties.sdma_engine_id = q->sdma_id %
>> -                get_num_sdma_engines(dqm);
>> -        q->properties.sdma_queue_id = q->sdma_id /
>> -                get_num_sdma_engines(dqm);
>>       } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>> -        if (dqm->xgmi_sdma_bitmap == 0) {
>> +        num_engines = get_num_xgmi_sdma_engines(dqm);
>> +        for_each_set_bit(engine, &(qpd->xgmi_sdma_engine_bitmap),
>> num_engines) {
>> +            available_queue_bitmap = sdma_engine_mask(engine,
>> num_engines);
>> +            available_queue_bitmap &= dqm->xgmi_sdma_bitmap;
>> +
>> +            if (!available_queue_bitmap)
>> +                continue;
>> +            /* Take the selected engine off the list so we will not
>> +             * allocate two queues onto the same engine
>> +             */
>> +            qpd->xgmi_sdma_engine_bitmap &= ~(1ULL << engine);
>> +            found_sdma = true;
>> +
>> +            bit = __ffs64(available_queue_bitmap);
>> +            dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>> +            q->sdma_id = bit;
>> +            /* sdma_engine_id is sdma id including
>> +             * both PCIe-optimized SDMAs and XGMI-
>> +             * optimized SDMAs. The calculation below
>> +             * assumes the first N engines are always
>> +             * PCIe-optimized ones
>> +             */
>> +            q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>> +                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>> +            q->properties.sdma_queue_id = q->sdma_id /
>> +                get_num_xgmi_sdma_engines(dqm);
>> +            break;
>> +        }
>> +        if (!found_sdma) {
>>               pr_err("No more XGMI SDMA queue to allocate\n");
>>               return -ENOMEM;
>>           }
>> -        bit = __ffs64(dqm->xgmi_sdma_bitmap);
>> -        dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
>> -        q->sdma_id = bit;
>> -        /* sdma_engine_id is sdma id including
>> -         * both PCIe-optimized SDMAs and XGMI-
>> -         * optimized SDMAs. The calculation below
>> -         * assumes the first N engines are always
>> -         * PCIe-optimized ones
>> -         */
>> -        q->properties.sdma_engine_id = get_num_sdma_engines(dqm) +
>> -                q->sdma_id % get_num_xgmi_sdma_engines(dqm);
>> -        q->properties.sdma_queue_id = q->sdma_id /
>> -                get_num_xgmi_sdma_engines(dqm);
>>       }
>>         pr_debug("SDMA engine id: %d\n", q->properties.sdma_engine_id);
>> @@ -1084,16 +1137,32 @@ static int allocate_sdma_queue(struct
>> device_queue_manager *dqm,
>>   }
>>     static void deallocate_sdma_queue(struct device_queue_manager *dqm,
>> +                struct qcm_process_device *qpd,
>>                   struct queue *q)
>>   {
>> +    uint32_t engine = q->properties.sdma_engine_id;
>> +
>>       if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
>>           if (q->sdma_id >= get_num_sdma_queues(dqm))
>>               return;
>>           dqm->sdma_bitmap |= (1ULL << q->sdma_id);
>> +        /* Don't give SDMA0 back to be reallocated on Aldebaran.
>> +         * It is only OK to use this engine from the first allocation
>> +         * within a process.
>> +         */
>> +        if (!(dqm->dev->device_info->asic_family == CHIP_ALDEBARAN &&
>> +                    engine == 0))
>> +            qpd->sdma_engine_bitmap |= (1ULL << engine);
>> +
>>       } else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>           if (q->sdma_id >= get_num_xgmi_sdma_queues(dqm))
>>               return;
>>           dqm->xgmi_sdma_bitmap |= (1ULL << q->sdma_id);
>> +        /* engine ID in the queue properties is the global engine ID.
>> +         * The XGMI engine bitmap ignores the PCIe-optimized engines.
>> +         */
>> +        engine -= get_num_sdma_engines(dqm);
>> +        qpd->xgmi_sdma_engine_bitmap |= (1ULL << engine);
>>       }
>>   }
>>   @@ -1303,7 +1372,7 @@ static int create_queue_cpsch(struct
>> device_queue_manager *dqm, struct queue *q,
>>       if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>           q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>           dqm_lock(dqm);
>> -        retval = allocate_sdma_queue(dqm, q);
>> +        retval = allocate_sdma_queue(dqm, qpd, q);
>>           dqm_unlock(dqm);
>>           if (retval)
>>               goto out;
>> @@ -1365,7 +1434,7 @@ static int create_queue_cpsch(struct
>> device_queue_manager *dqm, struct queue *q,
>>       if (q->properties.type == KFD_QUEUE_TYPE_SDMA ||
>>           q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
>>           dqm_lock(dqm);
>> -        deallocate_sdma_queue(dqm, q);
>> +        deallocate_sdma_queue(dqm, qpd, q);
>>           dqm_unlock(dqm);
>>       }
>>   out:
>> @@ -1536,7 +1605,7 @@ static int destroy_queue_cpsch(struct
>> device_queue_manager *dqm,
>>         if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
>>           (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
>> -        deallocate_sdma_queue(dqm, q);
>> +        deallocate_sdma_queue(dqm, qpd, q);
>>           pdd->sdma_past_activity_counter += sdma_val;
>>       }
>>   @@ -1751,9 +1820,9 @@ static int process_termination_cpsch(struct
>> device_queue_manager *dqm,
>>       /* Clear all user mode queues */
>>       list_for_each_entry(q, &qpd->queues_list, list) {
>>           if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
>> -            deallocate_sdma_queue(dqm, q);
>> +            deallocate_sdma_queue(dqm, qpd, q);
>>           else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>> -            deallocate_sdma_queue(dqm, q);
>> +            deallocate_sdma_queue(dqm, qpd, q);
>>             if (q->properties.is_active) {
>>               decrement_queue_count(dqm, q->properties.type);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index ab83b0de6b22..c38eebc9db4d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -576,6 +576,8 @@ struct qcm_process_device {
>>       struct list_head priv_queue_list;
>>         unsigned int queue_count;
>> +    unsigned long sdma_engine_bitmap;
>> +    unsigned long xgmi_sdma_engine_bitmap;
>>       unsigned int vmid;
>>       bool is_debug;
>>       unsigned int evicted; /* eviction counter, 0=active */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 21ec8a18cad2..13c85624bf7d 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1422,6 +1422,7 @@ struct kfd_process_device
>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>                               struct kfd_process *p)
>>   {
>>       struct kfd_process_device *pdd = NULL;
>> +    const struct kfd_device_info *dev_info =
>> dev->dqm->dev->device_info;
>>         if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
>>           return NULL;
>> @@ -1446,6 +1447,8 @@ struct kfd_process_device
>> *kfd_create_process_device_data(struct kfd_dev *dev,
>>       pdd->qpd.pqm = &p->pqm;
>>       pdd->qpd.evicted = 0;
>>       pdd->qpd.mapped_gws_queue = false;
>> +    pdd->qpd.sdma_engine_bitmap =
>> BIT_ULL(dev_info->num_sdma_engines) - 1;
>> +    pdd->qpd.xgmi_sdma_engine_bitmap =
>> BIT_ULL(dev_info->num_xgmi_sdma_engines) - 1;
>>       pdd->process = p;
>>       pdd->bound = PDD_UNBOUND;
>>       pdd->already_dequeued = false;
>>
