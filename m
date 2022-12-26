Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362DFC3DA79
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Dec 2022 10:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB6B10E056;
	Mon, 26 Dec 2022 10:41:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A599810E056
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Dec 2022 10:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra4aphs+Aylnq6kfP994LK0nd9UR9YWFQwVAhx8BuDTVOXC1UeAcUGgS5WTMRS3c+Tn975Uvq7n+4ZpqBtf67Smln2WP9IOwLu1/3fKsVVj5IHZBHl0v8z//g1Rj/8GQh4Hgm86YdJQwtnxNTGUeK7tdhuDigaeuTBHCbm9SWWJRj/U6F3rf7hhmIzGCT8j4x8bShf+nEfPQSouLFR8TU08O9qb2Ozrz+WxTkKQc5crLyN9ZDHkQXGujZDY67hyDBq4VBT7kmHrbPWV6uUE5GZ3si6BF9oAcdw8CQVrYvO9PlAVBreIl7iZ0cNc6sz8q1xAGxe+i8nGUHpGz1blsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccQQ+rnV+KqiC4a3ybojDXeN90bxHpG73BfgMUGbA9s=;
 b=i5xjUpjeYCaV7OYGJ3xELWgBQWiL4PebspyqdqUvB/1fXZnykozJQ2uDar+H6CyW6ivqRpXk1/VqDIWtoorOLxxKtCqDJmgclnw1Te5bBLgqz6BBN+AnBGZUSfrurZppMhCvEV8C4yDUkS7wh41dewGHxvngVHqCcPn99z63vP5PcwFGxqPmuhBYHwReqDbWuMDbu5Zv85Cqd7ei2cv3ffwlQnQCy/nRPOE+fjpcbv3R+zllaZkx2PsIb6OiL1K8+1S7SFqumN4La4NFyS2UAqy9ZFvJopClSbb6Kwb07UqExqpiSttPfGTn6Z5jpP+YMbQfOqPZfyi1B/CwbXvoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccQQ+rnV+KqiC4a3ybojDXeN90bxHpG73BfgMUGbA9s=;
 b=ANSJ5mnP2fBOM74rM9MG3lnjE6KDU9H7ldglLBunhmFkKEy7mJASnT3ysJwIKknQLqUG6gpEyvoIaGYYMc3b+6Tr6kwkYnyHDGS20jdZqQdmOxe5kGe9xIOZUx5J/yBk9cuvdL797R/pckLd/rty8feb2TFd4BkddWV1Jdw3hOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.14; Mon, 26 Dec
 2022 10:41:29 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.012; Mon, 26 Dec 2022
 10:41:28 +0000
Message-ID: <569ecf0d-59b5-b209-ccf0-2d3f648c9bf3@amd.com>
Date: Mon, 26 Dec 2022 11:41:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
 <fedb614a-6fcb-e2ff-0d79-1c15f18b92d1@gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <fedb614a-6fcb-e2ff-0d79-1c15f18b92d1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf1bb68-5ed9-482f-bb3b-08dae72dbe8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +o6osMSO74bRElS9N15LkhZuDGceOTZ8VcWLStu+BQRVIAvOGXmCEb1qMwMWe07wJ8PnGNyDFe3+z+fnuVfONE2v2BYQL2pzeJb5QH0F14kfScBzCC/jvgO5Ut7JVNTA1Au9UjtrD7258k/xoGTT6Ujisa568/93AS3rgUhtQVq3n7PqRg938A3N51PFb7ywfFG1HpR2Kkw126qQ+PPiW9srCzhw8kOrr4Pmy94x14/Noi3cydQJ/c/xOopMesBnMyVKeHlNia1+9KVwVqfAKlSCpOFDjxA10IYfz0H0fvzB1/tSb3oVkVMy1ca4G2nRxZyOifeqwxy68Hl8+wDUv5je6kuLCu02zq8k8sDCNGlmhbT2bfT+YGKNqbUfCL5nhEv96mrJgWDNAwe8oe9YPTwxvlb8Fx4DXVuDyDCaUyju0PUdF5JmFfilYksZptyV1OcfWl0RhZL4Yguedyt/7NGFW1JXbqq6iWaGt3V2GUCxQRHyuxiHYfqnJBQAPOiDgU7oAJOJMQuwfGL00b8yaQ00PGqVttCOiZNrqazTqFHCUOKBlOAwLcu0aEnoVhBRfT+R439zNEpkWnkBF5HM3s+QYuSoPIDFPEr/4vrF+Gtzr5L2iDUp74YVfwctAlKD6DCFYYlmmFuPik4+5YwRcNR/hEYlEGCExM+4WdcsKl4R/vW/M68yRsF0x947Q09y15bL3FrtFvSF1YtKYl68605wy+QlE9kLOsMQ9BGb5CY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(451199015)(83380400001)(54906003)(2906002)(30864003)(316002)(36756003)(44832011)(2616005)(6486002)(478600001)(6512007)(186003)(26005)(38100700002)(53546011)(6506007)(6666004)(66574015)(86362001)(4326008)(8676002)(66556008)(66946007)(41300700001)(31686004)(66476007)(66899015)(8936002)(31696002)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHIwK1RaUzgrQ3Z1M0ltakFGWjhxemZXWEIzeS9BVk9TWk9BWjZUb3AwS0ZZ?=
 =?utf-8?B?NjNtdDRubDQwaG4zV2w5NzFRWGNJY0ZtODBYcm53UHJIbmo5YkxacGFkZzVk?=
 =?utf-8?B?OFovQmEydzkyVGM5V29ia0NrY0k1WkE2TUFTZ3Q1ZHJoZ1ErVFdlaXFBVUlO?=
 =?utf-8?B?RkFtVUtTSVFibStHTUppdnpjV2hRSDJPSXNubHVudnhWRWN5dXJqYnh2Wmlt?=
 =?utf-8?B?em04RFREM3IwbTV2aWh4TldrcmIxYklDQktuOG42aXczMHMrN1M0RG4xNFVs?=
 =?utf-8?B?MVJ3SXNVdDdYSXczU3hFRkRvMlZRNUtEdTVLY3R3VTk1WStiZlNGRlI2b3Bt?=
 =?utf-8?B?TXo3VmUrNDRQQVBqRS9wbGgyRnlGcGU1Yk43S3grNGM3QWpjeFFNNm1TYnZy?=
 =?utf-8?B?RklmSGt4M2RLd3RCSXNTKzBNNGZqeVcrOTA5TDRKVCtZWU5HSVM4cTNZeVQ1?=
 =?utf-8?B?VWtqelhHMGszK2w3V2gzMTZpR04rK00yak1wbzVuNHIrbnZ5eXVjMDJZRVFX?=
 =?utf-8?B?RVFpOWVWckFldWU4eVQwbURxZm9zRzBudHpxd0V6SG13My9QZ2tVK0tSYXpj?=
 =?utf-8?B?MXBrRWtlT0kwY2J5OVQ0TGlJZkRXSXVwWmNCWVd6dTdZNUE1VGxlSmJRcC9n?=
 =?utf-8?B?a3N4WUpKaWZvcmpvOGlpb2FNVk1WNGliS1hiZ1dqM2l2YXBrdnk0T29tM3J5?=
 =?utf-8?B?aDdTTXE1ZEUzbFpBYzRiWTMyUUQ4Y0R3dmxXeDYvR1gxdTJEc3g0Y3FFaWRw?=
 =?utf-8?B?cVFTNGpDeGYyVG1XRWwrQ1UxQ21YeGpvZXFZOUtoampkQkhLTDFSRmFTblNk?=
 =?utf-8?B?MkZqZ2ZnS090cTIyTDdTMStRaWRDR0VqMThka09tWjJxZ3o1MFNZNTljZzZ1?=
 =?utf-8?B?MFNJRjJSYThSK2FyeldjbVpGWUcrZ1J1TS9uQkhmZndxOUZOVG1WYnpxcGNl?=
 =?utf-8?B?cHJFRHNSUmJjT0RSbzkvemt4Q1dCNlJoUE9FUUsvc2VSRXIyL09BZkE0ZFlh?=
 =?utf-8?B?NkZXNHlKNEY5cVJ2dTk4N2JhN3FhejdhQ1JVUU9KWE5UY2R3ODJWeGdYWlBa?=
 =?utf-8?B?bktLZXE2emZ6Yk5LZVQ0cUtlcFlhT2ZFRVhZRzN2YWJWTThPOFVKZGQrR3V4?=
 =?utf-8?B?Y2lBeUlFTjU5Smh3SE1DVHNORHRVbUVZZnMvMHBUVlFzbGFnaTBsNWMvUU5t?=
 =?utf-8?B?MlNPTHB1QXpzNmJFZUFldm50Y2lVUnJRb2xaWE9tMHVVTjFhN2ZyZkF5TVUx?=
 =?utf-8?B?Z05udE04T1RVZlptRS9FMmlpSXMwUGpJL3Z2ampxSmNZNzNIR2d0TnN6REh1?=
 =?utf-8?B?YkZFNEpQcVVSbG0rY2xGbG5qcEtSSGFnSWJycXg5R1NtRC9oWExzajBUWCs5?=
 =?utf-8?B?TTlxV0w1ZkRSemZ5d0FSbmJBeUhSK2JEclNxZlZpMGRONTZzV3R2WU5KMjJk?=
 =?utf-8?B?WnBZNUtsZVJvVXFoeXZPM1NPeHlzVGpoUFc3dTJRd0RqczFYbDRzQWNxNW1I?=
 =?utf-8?B?NnpNQUY5bW50TUZiTUlhR2JQckxIYjdFMFZWY3ozNDNNMDI1bXUveER4T0di?=
 =?utf-8?B?blF4OFdqOTlkUmxpTDlHaFZwTVRGRXozZUJpOWczL0YwRHFiNDBwNEpaaXY1?=
 =?utf-8?B?ZHl4VVhBMUQ5MDIvcjdRUmV3cnhIdG0ydUUvd0NDQmdkcHVrUkhTa2pGdGE1?=
 =?utf-8?B?Q1ZPZ3R4TWpZV0Q2ZE5MSW94U1NaV2U0QlBidVB1T3ZEbU5HekprajA2NnNa?=
 =?utf-8?B?eDZPNE5UanNYaTZuVGFaSFk2ZkhpL0IyTEpiS2tDc3RpeWxWYldxRjlUQjV4?=
 =?utf-8?B?V3VseEZ0SXVjYjQyMFZQYzREc0ZYY0trWnVKbGQwYkM5MWNaSmM2Z0dDdFkz?=
 =?utf-8?B?ekxMTFNDVVJQbmVhZ004VFJHUG04TjNBZUV0K3N3cnphM1M1VW1ITGtORytz?=
 =?utf-8?B?UGx1TlMwNGxGcGhuMEtuN2NzaEkwS0NnVVBEdnRVMWhUR0Z5a3Z0eTY1dUcz?=
 =?utf-8?B?czZ1ck1xclgyYWdTRVN3NE11YXRUVXN0ZFBTODJRK2tGaUlCYUxlejJFcFZk?=
 =?utf-8?B?S2x2S1BsamdKS21VUyt1OGpKSDZrOWF6aEVnY2xpMGxVS0UrK29PRlhDc3Uw?=
 =?utf-8?Q?5TpynBJpuWOR7+lUp29UMug8d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf1bb68-5ed9-482f-bb3b-08dae72dbe8a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2022 10:41:28.4216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yP5zeLVqMMlNknD/OwLIN5LzfEHJDhhG5E1xD+XvcGAtJw8mnZGUIEPf4EezBf1MfAYCigeP90tDXau+p1HhLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Christian,

On 25/12/2022 16:44, Christian König wrote:
> Am 23.12.22 um 20:36 schrieb Shashank Sharma:
>> This patch adds skeleton code for usermode queue creation. It
>> typically contains:
>> - A new structure to keep all the user queue data in one place.
>> - An IOCTL function to create/free a usermode queue.
>> - A function to generate unique index for the queue.
>> - A global ptr in amdgpu_dev
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 ++++++++++++++++++
>>   .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
>>   5 files changed, 246 insertions(+)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 6ad39cf71bdd..e2a34ee57bfb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -209,6 +209,8 @@ amdgpu-y += \
>>   # add amdkfd interfaces
>>   amdgpu-y += amdgpu_amdkfd.o
>>   +# add usermode queue
>> +amdgpu-y += amdgpu_userqueue.o
>>     ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 8639a4f9c6e8..4b566fcfca18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -749,6 +749,11 @@ struct amdgpu_mqd {
>>               struct amdgpu_mqd_prop *p);
>>   };
>>   +struct amdgpu_userq_globals {
>> +    struct ida ida;
>> +    struct mutex userq_mutex;
>> +};
>> +
>>   #define AMDGPU_RESET_MAGIC_NUM 64
>>   #define AMDGPU_MAX_DF_PERFMONS 4
>>   #define AMDGPU_PRODUCT_NAME_LEN 64
>> @@ -955,6 +960,7 @@ struct amdgpu_device {
>>       bool                            enable_mes_kiq;
>>       struct amdgpu_mes               mes;
>>       struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
>> +    struct amdgpu_userq_globals    userq;
>
> This is a pretty big NAK to this. User mode queues should absolutely 
> not be global!
>
> This must be per fpriv, see how amdgpu_ctx/amdgpu_ctx_mgr is designed.
Noted,
>
> Or is that for the interface with the MES? If yes than that should be 
> part of the MES code, not here.
This is actually to keep a mutex and keep an IDR object. I will first 
check how amdgpu_ctx handles it, as you suggested.
>
>>         /* df */
>>       struct amdgpu_df                df;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 0fa0e56daf67..f7413859b14f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>>       unsigned long            ras_counter_ce;
>>       unsigned long            ras_counter_ue;
>>       uint32_t            stable_pstate;
>> +    struct amdgpu_usermode_queue    *userq;
>
> Why should we have this in the ctx here???

We are allocating a few things dynamically for the queue, which would be 
valid until we destroy this queue. Also we need to save this queue

container at some place for the destroy function,  and I thought it 
would make sense to keep this with the context ptr, as this is how we are

identifying the incoming request.

- Shashank

>
> Regards,
> Christian.
>
>>   };
>>     struct amdgpu_ctx_mgr {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> new file mode 100644
>> index 000000000000..3b6e8f75495c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -0,0 +1,187 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include "amdgpu.h"
>> +#include "amdgpu_vm.h"
>> +#include "amdgpu_mes.h"
>> +#include "amdgpu_usermode_queue.h"
>> +#include "soc15_common.h"
>> +
>> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a, 
>> sizeof(__u64)))
>> +
>> +static int
>> +amdgpu_userqueue_index(struct amdgpu_device *adev)
>> +{
>> +    int index;
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, GFP_KERNEL);
>> +    return index;
>> +}
>> +
>> +static void
>> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    ida_simple_remove(&uqg->ida, queue->queue_id);
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct 
>> drm_amdgpu_userq_mqd *mqd_in)
>> +{
>> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || 
>> mqd_in->doorbell_offset == 0) {
>> +        DRM_ERROR("Invalid queue object address\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || 
>> mqd_in->wptr_va == 0) {
>> +        DRM_ERROR("Invalid queue object value\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= 
>> AMDGPU_HW_IP_NUM) {
>> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (!CHECK_ACCESS(mqd_in->queue_va) || 
>> !CHECK_ACCESS(mqd_in->rptr_va) ||
>> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
>> +            DRM_ERROR("Invalid mapping of queue ptrs, access error\n");
>> +            return -EINVAL;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
>> +    return 0;
>> +}
>> +
>> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct 
>> drm_file *filp,
>> +                            union drm_amdgpu_userq *args)
>> +{
>> +    int r, pasid;
>> +    struct amdgpu_usermode_queue *queue;
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
>> +
>> +    if (!ctx) {
>> +        DRM_ERROR("Invalid GPU context\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (vm->pasid < 0) {
>> +        DRM_WARN("No PASID info found\n");
>> +        pasid = 0;
>> +    }
>> +
>> +    mutex_lock(&adev->userq.userq_mutex);
>> +
>> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
>> +    if (!queue) {
>> +        DRM_ERROR("Failed to allocate memory for queue\n");
>> +        mutex_unlock(&adev->userq.userq_mutex);
>> +        return -ENOMEM;
>> +    }
>> +
>> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
>> +    if (r < 0) {
>> +        DRM_ERROR("Invalid input to create queue\n");
>> +        goto free_queue;
>> +    }
>> +
>> +    queue->vm = vm;
>> +    queue->pasid = pasid;
>> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
>> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
>> +    queue->queue_size = mqd_in->queue_size;
>> +    queue->queue_type = mqd_in->ip_type;
>> +    queue->paging = false;
>> +    queue->flags = mqd_in->flags;
>> +    queue->queue_id = amdgpu_userqueue_index(adev);
>> +
>> +    ctx->userq = queue;
>> +    args->out.q_id = queue->queue_id;
>> +    args->out.flags = 0;
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    return 0;
>> +
>> +free_queue:
>> +    amdgpu_userqueue_remove_index(adev, queue);
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    kfree(queue);
>> +    return r;
>> +}
>> +
>> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct 
>> drm_file *filp,
>> +                              union drm_amdgpu_userq *args)
>> +{
>> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
>> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
>> +    struct amdgpu_usermode_queue *queue = ctx->userq;
>> +
>> +    mutex_lock(&adev->userq.userq_mutex);
>> +    amdgpu_userqueue_remove_index(adev, queue);
>> +    ctx->userq = NULL;
>> +    mutex_unlock(&adev->userq.userq_mutex);
>> +    kfree(queue);
>> +}
>> +
>> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
>> +               struct drm_file *filp)
>> +{
>> +    union drm_amdgpu_userq *args = data;
>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>> +    int r = 0;
>> +
>> +    switch (args->in.op) {
>> +    case AMDGPU_USERQ_OP_CREATE:
>> +        r = amdgpu_userqueue_create(adev, filp, args);
>> +        if (r)
>> +            DRM_ERROR("Failed to create usermode queue\n");
>> +        break;
>> +
>> +    case AMDGPU_USERQ_OP_FREE:
>> +        amdgpu_userqueue_destroy(adev, filp, args);
>> +        break;
>> +
>> +    default:
>> +        DRM_ERROR("Invalid user queue op specified: %d\n", 
>> args->in.op);
>> +        return -EINVAL;
>> +    }
>> +
>> +    return r;
>> +}
>> +
>> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
>> +{
>> +    struct amdgpu_userq_globals *uqg = &adev->userq;
>> +
>> +    mutex_init(&uqg->userq_mutex);
>> +    return 0;
>> +}
>> +
>> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
>> +{
>> +
>> +}
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>> new file mode 100644
>> index 000000000000..c1fe39ffaf72
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>> @@ -0,0 +1,50 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef AMDGPU_USERMODE_QUEUE_H_
>> +#define AMDGPU_USERMODE_QUEUE_H_
>> +
>> +#define AMDGPU_MAX_USERQ 512
>> +
>> +struct amdgpu_usermode_queue {
>> +    int        queue_id;
>> +    int        queue_type;
>> +    int        queue_size;
>> +    int        paging;
>> +    int        pasid;
>> +    int        use_doorbell;
>> +    int        doorbell_index;
>> +
>> +    uint64_t    mqd_gpu_addr;
>> +    uint64_t    wptr_gpu_addr;
>> +    uint64_t    rptr_gpu_addr;
>> +    uint64_t    queue_gpu_addr;
>> +    uint64_t    flags;
>> +    void         *mqd_cpu_ptr;
>> +
>> +    struct amdgpu_bo    *mqd_obj;
>> +    struct amdgpu_vm        *vm;
>> +    struct list_head     list;
>> +};
>> +
>> +#endif
>
