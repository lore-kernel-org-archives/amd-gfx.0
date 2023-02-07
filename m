Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564EAC636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 07:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E541D10E457;
	Tue,  7 Feb 2023 07:52:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101F410E457
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 07:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwk08IoTZc8B/jZ533algKZXgZrTB5S59Jbf0N41R3DhRU8d4Xjxg98YmchU/uh+Hl1OXXlZswIGoCF1Gq8zJRiJAe1tx7OGH9LMKh8EMNatoyKVPo/BvJ3wFpVNPrXV68+AtxJH1MYf4bcBXIdP4DsYihK4eS6UYkfUBv7uJ9/ktt8Y7olEFvd1gZZZNd3VHn/enLAZZl4A9TLmGgETSn6dgteJA8f8ZM43xXAEvghStbNfX8jrq1NqrRGAPk9TDEpQ043wfUTzkKqim0XIS7uahwYNlvP/oWmx6bslcrUmvyeqYPR1b6WS7WMUkreSjrIdFag0yb7s04G8Ftb42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJlLbXOnx7IkIpJbPgh7KthKKGLbD2tRNqEwY7Cbrs4=;
 b=RWGesP2kSZaTeqoPzqvi3zD71nXM4OOrcFp6WtASF7C5VgTzUXQ8AUoXTRUnzgK0m74RCTiFUPNs1pAoLHdfwbm0qWZJ88hfqH2gyObq2yrZYqzlEau+rzzXgF1HI+XoIYcqyJwzxMWaKHYP+jIChEltZ1of0eWaOea8jxt6uVxu04vsantIf5FaQujFSEe+VarojxREKGdfV7ENMwYPn1xYXdCqbY4j+W1g+3papbEQTYK91TItvkA9ZASuI0IqPWM2i9zBqNOd658xgNL12E/kiB2wmLN8tKbUzToqIxTdylxG8/ZBhu4J69cIfRl4L1vt73mfcHHKI7Ub4QMsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJlLbXOnx7IkIpJbPgh7KthKKGLbD2tRNqEwY7Cbrs4=;
 b=5Jk8HiD28yCreSZh807vajX33dwzzDgF5RlhbzLvMj6F+qyEh0Cjjg5hkgGypq8uCOz7T7tNgtZjbw4HLaZpOGU8eqr4N6JB//fI1NsSHH4UuIWCaaf+VJmXvNOsNLZlpAlQrhFQp8BDqm4T3F3cTXWlXMa+yHolHisqB+VxxGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Tue, 7 Feb
 2023 07:51:55 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6064.034; Tue, 7 Feb 2023
 07:51:55 +0000
Message-ID: <43c2b1eb-dd09-6a55-c252-b59176293b93@amd.com>
Date: Tue, 7 Feb 2023 08:51:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/8] drm/amdgpu: Create context for usermode queue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-6-shashank.sharma@amd.com>
 <240a5ab8-6743-4588-4a73-17f2ea894f1b@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <240a5ab8-6743-4588-4a73-17f2ea894f1b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa2ddd2-7202-4d00-5736-08db08e02ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NRjzQbUP2KoUbBtaDNHn9rfsw8t3DILc0UFMi2yfIBCLnTLjsE/yjgT2t/WoOk13iNRI48b/2CZctyMHUdxbOfwN1iXDNtgDHWU9p/XPPUC0NPPu412bRyNuZGcBFv5gpBR5xCdfmMZK4BMkMwtHnTBUVuKXPdqKL/9D22omoSpWyufy/6l+nQ6yo3qowblSHseC43cR2RAkpI2RoYR4ivyoxosuYNHdL9NsRrfCvq8lARmnswp041Hb63Dlkdd3hl5zcE16dLL61yArA6gkMDl4pmotBsY8MJuifB2PMkZWqgWpdn0vs15+9SoQrsFqxPbYxEFLtwJbN5MKQj1wGir1LNzdbhlb6JEM0+K7Zi/GOo6YxA6xQKta9Nwot1rNd0V7XUru1UoJtImh8VBFyWmf2A2HxPN5XmjtPifvZ+hI5vFz8VE82SBlYdqyw/th9IUj/cJcFZjhOwgiciFTP5fMmhKpySHH8TueonZToLW2tVD3BbuyX2Di/c7drSrw7I3aWaZvVn6oVGiEKyrQ6+H72PCA80o8OtVwCvmYqZj7V4sVcIIHt4hl3cXT/5nQCT1QQq1AAMxClcj4jOSJhCuum/kxgaZ9hOjg8BZ+F24URi75K0gjgslYOI70gy1iTlW0swqk0ooCSyhY+ldt/HTyJiRHZA88FWAJW4cumVTT0XfRPabIt7DHAdr3neLLSNDEwTXtvIi9tN3Aqz2ybN9MbxIS1jxNDUzEPXGyLCQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199018)(83380400001)(66946007)(66556008)(66476007)(41300700001)(31686004)(66574015)(36756003)(2616005)(38100700002)(8676002)(4326008)(53546011)(316002)(186003)(6512007)(2906002)(8936002)(26005)(44832011)(6666004)(6506007)(31696002)(478600001)(6486002)(5660300002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJiRkw1YzNjdnNIdUcxVzdXamt1OFJaMXZaU0wySzY3R0JIZys1TEhObFpm?=
 =?utf-8?B?ZnVUTjJzK2E4Vi95N1RNOGlqSnNQekIxUlZrRmljZ2FueWUzcE94WWQ5U3FK?=
 =?utf-8?B?OTZJb1EwVkdPcUVHUWNtUm5JZzYwZHRha0ZpV3NmeWtlckxmb0dJejNrQXpr?=
 =?utf-8?B?a1FndjNFR2duTU9hYWp0TlJGay9qbXg4UWJtampSMkVZNWJ4RVgxZGJmaHQx?=
 =?utf-8?B?NU9TV04wSHpzR1o1ZFpaMFRta0c3OUx2QXJCTnpOZUtLMjgzUTZDZ0JiR3BF?=
 =?utf-8?B?SkJwK0pqSkRpdlY4anZrMTFTbW1WZGdYMEtveFVPNmlPc0grc2x2eWdBR2Jz?=
 =?utf-8?B?ZlVkQ0FRZWxYdzNoeWJ6cjdxeW5RUnE0eHFTeDNpUnd2L2hHdTJxTHQxNnBQ?=
 =?utf-8?B?ZHVuMjZvYzZRV1J3OERicWJ6LzhXNzliaUZ0Wjh5dm9wbUxkK1Z6OFBmK2Fq?=
 =?utf-8?B?WVpBY1d2aDFCbEtudEsvbHZRWFZFaDJteXF1bk1xTmRLZjl6Z21OYWxCVzFU?=
 =?utf-8?B?bW1WMHBBVVJ0V040SHI5azg1R1ZmOUVZVEE0R0p3ME5CODI1OWMzV2ZiVjM0?=
 =?utf-8?B?OVp2aVVxQ1lrRnpiRmFwU2lGOHRrS2hPby8xcmQwd21oa0Z3QzcrbUZvdFVw?=
 =?utf-8?B?cC8wckU4amV1T1JHVVlrdFZObmcvQmduVkViSmFEdWdlVDNiZnhNNHZMQ2VL?=
 =?utf-8?B?OERyZ3pMYWRFOGVYUmdsTTRCZE1vbEloRWVCU1ZSUVhSWDBzd3NER1IrcW5H?=
 =?utf-8?B?Zyt0Q21aVjVSR1VhdHg3Nmx1LzVnVTdNV2Y0Qm1KSEllcU9UUHRJK1lJMzhx?=
 =?utf-8?B?ZitwTGJTaGRrNWMvQURaK1ZCR255MlRoMjFVWC9JRUplZm1sYUZVanQyTVpE?=
 =?utf-8?B?RzNDNW5VUjk1VFkrTEpwZlBHcHZpbUUvNlpNNTlyRE9RVmFMR0wvVnRyaDBV?=
 =?utf-8?B?cEQwZ25sRTRoUDJvRUF4N2VsUkovTDIzQVdsOVJuZTIreHVqOGZEclVuODdM?=
 =?utf-8?B?TlJKb01zeWorVWtpaFVtbTZmNEs0UEhOdEdNbHBCRkhQUWp4akFNNTNxSmRI?=
 =?utf-8?B?NFZMVjRIaWZkaml2d3h0NXZZaTVhN2hMTWpJMFdML05RdjFaYzcwUkRCTHpK?=
 =?utf-8?B?QVZSd3lpTnhsTjhlb1NKOW1vWUNnWitsVUNJSmo0Qll1R0xRT0p6TThndnB5?=
 =?utf-8?B?aFptZEY4WU5jUGUvOFIvT1dKU3AxYTkvOHVlaEtRUE1oS0poN2NLMFF2anNH?=
 =?utf-8?B?WC8yTjdqY3FobVdQekpMbjlmS0JLaEU2SjhaRTI5UnRBK0lwNnBwWTlCN3dp?=
 =?utf-8?B?Q2x2Q2NYTkNaMlJQVU1EK2NGZXk0WUpWWXdHdEFQMXRPZFVud3I3K3pORlMw?=
 =?utf-8?B?UC8weG5BajFjVld4aUJvc0Y5TWNGUUNLMlJKdWcyN0NWcFBPL2p5dkpYRm4x?=
 =?utf-8?B?R25QNk10dERyclprOG55ZnBHTUdVbkc4SFEzb1FYY1dBRG93bUFsMmJTU1FK?=
 =?utf-8?B?OUVLV3RIalRueGI2ZkJBWm9qZXh6TndUaS9ZL3F0VzN4MXJzMUw1OWxEK2My?=
 =?utf-8?B?aVRZTlRiZmR3YUZvZFJyV3VNcHV5WkEzcEhVUGVNV2VSUUFycDdtNmVHd2s1?=
 =?utf-8?B?SmZKbkF3SGZYL0dYWXpRQ2tXVDg2cVJldFEyaHNINndrZkZnMVVkODhoL3ln?=
 =?utf-8?B?UmU0dnFPdENZc0J4MjYybnN1SFdiem91R1I3dzI1cDJoYlZmb1pldEhsa3U0?=
 =?utf-8?B?ejVrNUVBdklkYnNWY2VNSU55ZEY5Rml0L2dERkhSbG1BMTR2K1JvL2lia0tB?=
 =?utf-8?B?ZFY5YTVva3QrRFRWU1N5NVdKRE1MUkx5TFlvbTNVcTU4aXBwTTVlemNEVkNt?=
 =?utf-8?B?NlR5d05yVnh2bTZCK3RjWFV1Tm5VR3RxK0JCVXZtK2xDQmVpNjlTMWw0V0Rz?=
 =?utf-8?B?eEJ0Kytpa3ZqNnpNZzd0TE8rTkN1ZDlXT1NUUG9qdExyQ0VnTzk5VXRWMmdB?=
 =?utf-8?B?RUNIOUN5Tkx6cFFlQnhTM0h1dXdQM25rNlZTUlJPdExFR3ZwR0lHT2w4SWJa?=
 =?utf-8?B?U1F5MEZoZW01cXgvcDRONDFMN0lROEM0OENXSTVBWXhaL0k2b3oyeVovSjJZ?=
 =?utf-8?Q?RF8+w2m5UHjCe/jGECIY/oWiC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa2ddd2-7202-4d00-5736-08db08e02ebb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 07:51:55.5585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Byun70W+NWwjNdKwBn1e3xFR/Q6xXBLVFJYzuHXeaGWlRNcNRImJph2BcTTbwxclWXywG/UX74ozDoDFUdIbIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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


On 07/02/2023 08:14, Christian König wrote:
> Am 03.02.23 um 22:54 schrieb Shashank Sharma:
>> The FW expects us to allocate atleast one page as context space to
>> process gang, process, shadow, GDS and FW_space related work. This
>> patch creates some object for the same, and adds an IP specific
>> functions to do this.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c |  32 +++++
>>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 121 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  18 +++
>>   3 files changed, 171 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 9f3490a91776..18281b3a51f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -42,6 +42,28 @@ static struct amdgpu_usermode_queue
>>       return idr_find(&uq_mgr->userq_idr, qid);
>>   }
>>   +static void
>> +amdgpu_userqueue_destroy_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                   struct amdgpu_usermode_queue *queue)
>> +{
>> +    uq_mgr->userq_mqd_funcs->ctx_destroy(uq_mgr, queue);
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>> +                                  struct amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +
>> +    r = uq_mgr->userq_mqd_funcs->ctx_create(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create context space for queue\n");
>> +        return r;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int
>>   amdgpu_userqueue_create_mqd(struct amdgpu_userq_mgr *uq_mgr, struct 
>> amdgpu_usermode_queue *queue)
>>   {
>> @@ -142,12 +164,21 @@ static int amdgpu_userqueue_create(struct 
>> drm_file *filp, union drm_amdgpu_userq
>>           goto free_qid;
>>       }
>>   +    r = amdgpu_userqueue_create_ctx_space(uq_mgr, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create context space\n");
>> +        goto free_mqd;
>> +    }
>> +
>>       list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
>>       args->out.q_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       return 0;
>>   +free_mqd:
>> +    amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>> +
>>   free_qid:
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>   @@ -170,6 +201,7 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>       }
>>         mutex_lock(&uq_mgr->userq_mutex);
>> +    amdgpu_userqueue_destroy_ctx_space(uq_mgr, queue);
>>       amdgpu_userqueue_destroy_mqd(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>       list_del(&queue->userq_node);
>> diff --git 
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> index 57889729d635..687f90a587e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
>> @@ -120,6 +120,125 @@ amdgpu_userq_gfx_v11_mqd_destroy(struct 
>> amdgpu_userq_mgr *uq_mgr, struct amdgpu_
>>     }
>>   +static int amdgpu_userq_gfx_v11_ctx_create(struct amdgpu_userq_mgr 
>> *uq_mgr,
>> +                                           struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
>> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
>> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
>> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
>> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
>> +
>> +    /*
>> +     * The FW expects atleast one page space allocated for
>> +     * process context related work, and one for gang context.
>> +     */
>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_PROC_CTX_SZ, 
>> PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>> +                                &pctx->obj,
>> +                                &pctx->gpu_addr,
>> +                                &pctx->cpu_ptr);
>
> Again, don't use amdgpu_bo_create_kernel() for any of this.
Noted,
>
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate proc bo for userqueue (%d)", r);
>> +        return r;
>> +    }
>> +
>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GANG_CTX_SZ, 
>> PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>> +                                &gctx->obj,
>> +                                &gctx->gpu_addr,
>> +                                &gctx->cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate gang bo for userqueue (%d)", r);
>> +        goto err_gangctx;
>> +    }
>> +
>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_GDS_CTX_SZ, 
>> PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>> +                                &gdsctx->obj,
>> +                                &gdsctx->gpu_addr,
>> +                                &gdsctx->cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate GDS bo for userqueue (%d)", r);
>> +        goto err_gdsctx;
>> +    }
>> +
>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, 
>> PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>> +                                &fwctx->obj,
>> +                                &fwctx->gpu_addr,
>> +                                &fwctx->cpu_ptr);
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate FW bo for userqueue (%d)", r);
>> +        goto err_fwctx;
>> +    }
>> +
>> +    r = amdgpu_bo_create_kernel(adev, AMDGPU_USERQ_FW_CTX_SZ, 
>> PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_VRAM,
>> +                                &sctx->obj,
>> +                                &sctx->gpu_addr,
>> +                                &sctx->cpu_ptr);
>
> Why the heck should we allocate so many different BOs for that? Can't 
> we put all of this into one?
If you mean why don't we create one object of 5 * PAGE_SIZE and give 
1-page spaced offsets for all of this, yes, that would further simplify 
things.

The reason why we kept it separate is that these objects could be of 
different sizes on different IPs/platforms, so we thought defining a 
separate

size macro and object for each of these will make it easier to 
understand how many FW page objects we are creating for this GEN IP. It 
can be

either ways.

- Shashank

>
> Christian.
>
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate shadow bo for userqueue (%d)", 
>> r);
>> +        goto err_sctx;
>> +    }
>> +
>> +    return 0;
>> +
>> +err_sctx:
>> +    amdgpu_bo_free_kernel(&fwctx->obj,
>> +                          &fwctx->gpu_addr,
>> +                          &fwctx->cpu_ptr);
>> +
>> +err_fwctx:
>> +    amdgpu_bo_free_kernel(&gdsctx->obj,
>> +                          &gdsctx->gpu_addr,
>> +                          &gdsctx->cpu_ptr);
>> +
>> +err_gdsctx:
>> +    amdgpu_bo_free_kernel(&gctx->obj,
>> +                          &gctx->gpu_addr,
>> +                          &gctx->cpu_ptr);
>> +
>> +err_gangctx:
>> +    amdgpu_bo_free_kernel(&pctx->obj,
>> +                          &pctx->gpu_addr,
>> +                          &pctx->cpu_ptr);
>> +    return r;
>> +}
>> +
>> +static void amdgpu_userq_gfx_v11_ctx_destroy(struct amdgpu_userq_mgr 
>> *uq_mgr,
>> +                                            struct 
>> amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_ctx *pctx = &queue->proc_ctx;
>> +    struct amdgpu_userq_ctx *gctx = &queue->gang_ctx;
>> +    struct amdgpu_userq_ctx *gdsctx = &queue->gds_ctx;
>> +    struct amdgpu_userq_ctx *fwctx = &queue->fw_ctx;
>> +    struct amdgpu_userq_ctx *sctx = &queue->shadow_ctx;
>> +
>> +    amdgpu_bo_free_kernel(&sctx->obj,
>> +                          &sctx->gpu_addr,
>> +                          &sctx->cpu_ptr);
>> +
>> +    amdgpu_bo_free_kernel(&fwctx->obj,
>> +                          &fwctx->gpu_addr,
>> +                          &fwctx->cpu_ptr);
>> +
>> +    amdgpu_bo_free_kernel(&gdsctx->obj,
>> +                          &gdsctx->gpu_addr,
>> +                          &gdsctx->cpu_ptr);
>> +
>> +    amdgpu_bo_free_kernel(&gctx->obj,
>> +                          &gctx->gpu_addr,
>> +                          &gctx->cpu_ptr);
>> +
>> +    amdgpu_bo_free_kernel(&pctx->obj,
>> +                          &pctx->gpu_addr,
>> +                          &pctx->cpu_ptr);
>> +}
>> +
>>   static int amdgpu_userq_gfx_v11_mqd_size(struct amdgpu_userq_mgr 
>> *uq_mgr)
>>   {
>>       return sizeof(struct v11_gfx_mqd);
>> @@ -129,4 +248,6 @@ const struct amdgpu_userq_mqd_funcs 
>> userq_gfx_v11_mqd_funcs = {
>>       .mqd_size = amdgpu_userq_gfx_v11_mqd_size,
>>       .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>>       .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>> +    .ctx_create = amdgpu_userq_gfx_v11_ctx_create,
>> +    .ctx_destroy = amdgpu_userq_gfx_v11_ctx_destroy,
>>   };
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index a6abdfd5cb74..3adcd31618f7 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -25,9 +25,19 @@
>>   #define AMDGPU_USERQUEUE_H_
>>     #define AMDGPU_MAX_USERQ 512
>> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>> +#define AMDGPU_USERQ_GDS_CTX_SZ PAGE_SIZE
>> +#define AMDGPU_USERQ_FW_CTX_SZ PAGE_SIZE
>>     struct amdgpu_userq_mqd_funcs;
>>   +struct amdgpu_userq_ctx {
>> +    struct amdgpu_bo *obj;
>> +    uint64_t gpu_addr;
>> +    void    *cpu_ptr;
>> +};
>> +
>>   struct amdgpu_userq_mgr {
>>       struct idr userq_idr;
>>       struct mutex userq_mutex;
>> @@ -52,6 +62,12 @@ struct amdgpu_usermode_queue {
>>       uint64_t    mqd_gpu_addr;
>>       void         *mqd_cpu_ptr;
>>   +    struct amdgpu_userq_ctx    proc_ctx;
>> +    struct amdgpu_userq_ctx    gang_ctx;
>> +    struct amdgpu_userq_ctx    gds_ctx;
>> +    struct amdgpu_userq_ctx    fw_ctx;
>> +    struct amdgpu_userq_ctx    shadow_ctx;
>> +
>>       struct amdgpu_bo    *mqd_obj;
>>       struct amdgpu_vm        *vm;
>>       struct amdgpu_userq_mgr *userq_mgr;
>> @@ -64,6 +80,8 @@ struct amdgpu_userq_mqd_funcs {
>>       int (*mqd_size)(struct amdgpu_userq_mgr *);
>>       int (*mqd_create)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>>       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>> +    int (*ctx_create)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>> +    void (*ctx_destroy)(struct amdgpu_userq_mgr *, struct 
>> amdgpu_usermode_queue *);
>>   };
>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev);
>
