Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D15C636CC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Feb 2023 11:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BBE10E314;
	Thu, 16 Feb 2023 11:10:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1F5B10E314
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 11:10:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxnX91B+mArR6lKuQYR1tguT9MEmXGkdVEMgcaD9dyZYmeu2Bf4mNw6Fh2t5LbwL4Jtg6iAGWOeal6uXf/O5Y7RNgr4ra51X1J1sU9x8Uimkbgs87m9n6W2f/ZoW/9BxXm62YMOvKxkdyqm5IAH7ClzdvE8Y9x15gxT/2DgL4Ub1sqqxYFFXeQ7dU+5r3QCVdxFGTIl1ImJplrSiPui4uVBRw2aBFr+136IzErrzd68pYJUSVi0iGxrQQwEj5CDIlsupqIWrouiYIMXL1LBKYDd0pkbC1uJ+PNf4DSPva4ylvcXkGtSgt8niWhfPpqx5rxsfZPVjkOK26NutQD+3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnXwWVs9dzEjOilUILj7xExINSs3ZNCUjaYy2Wet+qs=;
 b=Nyhz53WsYMareAwFZHNWOIPHd8hZCgQl9x2+uGayIuXkMgSP9iijBRRmUZHNdP1Fr6b540vsGFzR2CZgQOrq696tg/GNMzjanruWPSYU+pgX2dcPCbgr7IHtpJ0XrlrhSzUyYACJEUuec/0+rGqWStIdHb5YlYeH/gpwvBXeyfivtIfE+P6wHWWfGX4FaSOSimf/5wwGBt3EygqdAKkQg3hz0YIykAFGamW11bHgFn2fcIzjXZGSxnsmH6FaEdw/FwWs0bNqfZqgEQ6rlhT5oY9bJdBt023FUwvdShYi+AphasRLWmjYB8tHnhOJKQZAF7lwJkQnHxTgVz3EuW++Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnXwWVs9dzEjOilUILj7xExINSs3ZNCUjaYy2Wet+qs=;
 b=j8tF+I7wLXin/ZYmwYCriXRxqXuWqBpCOO9opAt8aJB2iAL26lSDGKNjrU+1NpsO8DqvUg7pRgWVv4hZZB272o0cCghsc/cw8wzoWz7hffa5QPDpmPQisGJUjS8MCAqTN6infvdW7S6G4MxpUsPzRsI6vg4HxoCgX/QSZ9+tiik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 11:10:05 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6c1f:b156:aec5:de5a]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6c1f:b156:aec5:de5a%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 11:10:04 +0000
Message-ID: <5b332d54-e6ce-41fd-8283-f81d7f6b65f4@amd.com>
Date: Thu, 16 Feb 2023 12:09:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/9] drm/amdgpu: create GFX-gen11 MQD for userqueue
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230215184356.2205-1-shashank.sharma@amd.com>
 <20230215184356.2205-5-shashank.sharma@amd.com>
 <6f116e7d-55fa-a17d-f9ce-93bb18a8a3b6@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <6f116e7d-55fa-a17d-f9ce-93bb18a8a3b6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::17) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e5ea523-00b2-4114-ec1d-08db100e5aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OazToXBner8oju5ockgFjeiRxDeqKRczYODrBl24edlpTKe9RVMbLlUp3PxfyFS63u75Zptyjyj6D1sfZYSljB/GwjcBN8OEmU9D572lTY82wvd3llDLMTpAnmleMopdl7BcajwJn/YAWlI76K8sYJkEMlPv/bcjLm/GIahaZHtKecCF0ilvjw/+LoinxyjlYxyd6ITge5xgXHmENJ4M7kbVb/f4dP0LSI+mZdb8/txFrGtDzqY3Co/qE0ddNbb2c1JF6UyeZb6ycWBI7wvtKEz/1sxtQQx9PWn/7XrLF8Mfe9LFDd53F03pCLcrRm/cmwowv5TPBdo5nbFrFpFMcsuNzDcUk1mUzrcQGE/tgbMfLX0ixBoIHsdt2ArFCg4iRlKuDjF1e77XXBxe5bUWEHLJv3LdwtJPZHLpfBqhbSMJt2qtkochxMYH0JqRl1UWeUqst/sux3qUfPBayxG9eDeeA6ERljqF3a+JPPpNw65Ol47a+DkOkKBwHYmevSX4YuRa1hE4DtcJSpGgmF9GXAIeUTLFCdRqZX18E00UAO0+cE3cH3Tk4G4CLCr08XGsY6cEHjq3dInv4DlzCjrrnm/TaHXnESuE8eCF6yBtuiuJ0sOs7ZW9msI789r8VShWENfvAB42sIh8gwJIUq8CdbOTSMPXkCqChcM0SpxCorCxDKC7S9QP9FboYQdFtU/wI3CsL5EK/dAsDwPbNjUmIPA9/J2gzoPix/zqi+pGc1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199018)(5660300002)(31686004)(44832011)(66899018)(41300700001)(2906002)(4326008)(316002)(54906003)(66556008)(66476007)(66946007)(8676002)(66574015)(478600001)(6486002)(36756003)(2616005)(53546011)(6506007)(6512007)(186003)(26005)(8936002)(6666004)(31696002)(86362001)(83380400001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUJ6cHpERUlIMlNkRU5HNlp0T3Q0ZWV4a29aY1ZISUt3b0NGMWFLRUtXRkxi?=
 =?utf-8?B?MFpLQk9BeFhGS09nSjZtazBxYU5aTno1QmZrdG0xdjlmU3lTZ1ZPMWNMalJN?=
 =?utf-8?B?L2VXMDJnOXFBK3dvVGRhSTVJWTlKaXRDZXVQL3RWcnRYZ0orNzBtNjFadXJR?=
 =?utf-8?B?THo3Rm05Y215RW1HQ01RSW5ac01CcUhXbDh5WHA5YVptTE5YSGxVbFl6WStT?=
 =?utf-8?B?OXFSNHhtRHhHTDJWWS9jaGsvVllLWGpjVERQdjhDTGMwOXBCTXFZd2dmTXBW?=
 =?utf-8?B?R0lKcjhIQlZ5YzhtbU9Ha2dSRlZLVGVVMkFiN2RXay9aZWRQNE1kcEswd3l2?=
 =?utf-8?B?eUxWVCtlWjcwTzg1UlQ5ZVBPT0U0ZFliaWtyWUFTS3FCdXNxZkNXaXdoUGN0?=
 =?utf-8?B?NnRsQkhlSlVrekhEcjgvSklJU0tLd2J6dDdNWmVRNWhUVmhXdnZPeXVhM29D?=
 =?utf-8?B?NkJXYkt3UjJHKzlMNTIvNEJLQ1A5U20wd0xFT291RmRpNmxxcU9acDJEZnpq?=
 =?utf-8?B?Rlk5eE4xUFgzUUU2cDAzb0VGbC9ZWkVjR3FQenljY2FhdFBjNDVyVzllb3N5?=
 =?utf-8?B?M0pSNEZyRUwvb0pxbVJ6UENETjBkckt4QXVHYlE3bG1zMnVObk51UTdEc0Iv?=
 =?utf-8?B?YTIyTE1SU1NGMEVaSlFMVDhiTUtvS0R1UlFxR0xkT1dWS2h6SnFpVDVONjJC?=
 =?utf-8?B?dnRpV0ZnaE5IdHBEWHRrTjFZOGdBenVYOTk3ZWorTFdyWVNIMTdQVnFvU2tQ?=
 =?utf-8?B?UFhDN3VsZy82ZGhmNGNjcGN5WndKQ1p0cHV3ZkdjNm5oTnE0MjVPSzRaaWJn?=
 =?utf-8?B?OVphOXlwVWc3N2xpNU15c3FSc3dOU25BUC9haVhqcjN4SDJLOHNHQVM3TER5?=
 =?utf-8?B?M2krNDRJaXpEQTFNRWREa0EyNEdGVkxlcElLRXBNTG9aVnRQNzBlYkZqY0s5?=
 =?utf-8?B?QWh0OXFEV2p2bWtpcGxqbUtrcnVBZmNjdW0vUmcyNGU1a2IrSVZwU3VjQ2Ji?=
 =?utf-8?B?UGtINzV2eVpYTy9aZ1VCK25CRU5TSnFyV0VlYURob2hKbGFMbVF2dHFOMW1v?=
 =?utf-8?B?MXFNMis4YUJEOGE5L3pKVXJtWFk1endmNG0vYzltVXFVOVI3TWpjUFpxeG5H?=
 =?utf-8?B?bElqQk1pQ0RPSFMyK2I0RTZ0S3BkTzV4QWtTa3AyejRoYXFTNDJwOHpaWnA1?=
 =?utf-8?B?NFF6SFVkY3pOdjdqRmpyeFhIL09rMlZ4Ry9IZkR5RDh2WVc0Z0lGZHhnNjlP?=
 =?utf-8?B?ZWRCL1pjK2NncGh4dGdSdkpHMDBnUHJDQVdxa3NNU0ZxUXU4ZFRuZjJ2bGds?=
 =?utf-8?B?cnFRWmsrSWNFUllJN0hWM25jTTV4UEMvQU5WNGMvbjh2S0o0VURKS1lyc01G?=
 =?utf-8?B?QlJJNWZaNERRdTk2L2FkU044ak03bjNOYzhNQ0E0OStGdDhWMGxIbkxuM004?=
 =?utf-8?B?dUhaTElwK2UyMDhxa25iejZrV1RDSkFLS2x1VjB3bXcxRFpXOGpiUnl3YnI1?=
 =?utf-8?B?Z0doTFBTY1V2VWJFcVVldXlhbTR2VEo0bW5NSnN4NzJTbmh5MVdELzBURFNI?=
 =?utf-8?B?eHI3TWxjbmt1S1dmL290VkpBSTAvcmt5ZFYvSHhGL0hoT0NqUDBORDEyZlZE?=
 =?utf-8?B?MkQybUJSU1FBVm5lTzQzOFpwSXNtMkFKcmc2QjdranhiTU42NmtKSXJsTnI5?=
 =?utf-8?B?QmUwZzN3TlNONEZhcS80ZHA3bG42Z2pMZGRObWN3WFh5TUZuOUZ4bkZPNkxF?=
 =?utf-8?B?bGV6WXIxdVMydmlZSytwa0FQU0cxOEQ4d3Zuc2JhYkcxSXk5eTRSMThXTzZi?=
 =?utf-8?B?YURDancvazN6UnpjbGlrV0IwU1pxbmFZRUMxUGFEcG1WZHFQMENRdEhqVTZi?=
 =?utf-8?B?NHBMVTlvcTEveTFZclpvd3gwVDJCZ0FZSWhjWk1kamZZUmtOc1ppKzZTSHZH?=
 =?utf-8?B?UGp5YUREbm5VdjFSSUVJVU9wTDFIVkpPUTVBb1BFbmY5K2U2WnVSYTZOblJ4?=
 =?utf-8?B?dVBxNzltSWVHS0JFMGd1RkVVT1dHOWdiSU12MVppc1ZVbGJ0eFh4WU5rMWIx?=
 =?utf-8?B?NlJHNzQ0NDZ6R0x1WitPb2tEb25RSlBSR1hPZVc2UURYWW03NDFITmRtNFdG?=
 =?utf-8?Q?UTHuzkFOzk46eFw/6W2oUYTOC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5ea523-00b2-4114-ec1d-08db100e5aa7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 11:10:04.2254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHAEw22Z2p7c35rtKdMBN3bRhT+pJQeQQcv3RSHRDRA0LCo3R1wtAtHPqlL56yN2JQ8bf8L3vcaXBrzN2oLb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 16/02/2023 08:31, Christian König wrote:
> Am 15.02.23 um 19:43 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> A Memory queue descriptor (MQD) of a userqueue defines it in the 
>> harware's
>> context. As MQD format can vary between different graphics IPs, we 
>> need gfx
>> GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Introduces MQD hander functions for the usermode queues.
>> - Adds new functions to create and destroy MQD for GFX-GEN-11-IP
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 21 +++++
>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 84 +++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  7 ++
>>   4 files changed, 113 insertions(+)
>>   create mode 100644 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 764801cc8203..0c825bdf12d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -212,6 +212,7 @@ amdgpu-y += amdgpu_amdkfd.o
>>     # add usermode queue
>>   amdgpu-y += amdgpu_userqueue.o
>> +amdgpu-y += amdgpu_userqueue_gfx_v11.o
>>     ifneq ($(CONFIG_HSA_AMD),)
>>   AMDKFD_PATH := ../amdkfd
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index ecf31d86f3de..963e38f654a2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -82,6 +82,12 @@ static int amdgpu_userqueue_create(struct drm_file 
>> *filp, union drm_amdgpu_userq
>>           goto free_queue;
>>       }
>>   +    r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, 
>> queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create/map userqueue MQD\n");
>> +        goto free_queue;
>> +    }
>> +
>>       args->out.queue_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&uq_mgr->userq_mutex);
>> @@ -106,6 +112,7 @@ static void amdgpu_userqueue_destroy(struct 
>> drm_file *filp, int queue_id)
>>       }
>>         mutex_lock(&uq_mgr->userq_mutex);
>> + uq_mgr->userq_funcs[queue->queue_type]->mqd_destroy(uq_mgr, queue);
>>       amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       kfree(queue);
>> @@ -136,6 +143,19 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data,
>>       return r;
>>   }
>>   +extern const struct amdgpu_userq_funcs userq_gfx_v11_funcs;
>> +
>> +static void
>> +amdgpu_userqueue_setup_ip_funcs(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    int maj;
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    uint32_t version = adev->ip_versions[GC_HWIP][0];
>> +
>> +    maj = IP_VERSION_MAJ(version);
>> +    if (maj == 11)
>> +        uq_mgr->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_gfx_v11_funcs;
>> +}
>>     int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, 
>> struct amdgpu_device *adev)
>>   {
>> @@ -143,6 +163,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr 
>> *userq_mgr, struct amdgpu_devi
>>       idr_init_base(&userq_mgr->userq_idr, 1);
>>       userq_mgr->adev = adev;
>>   +    amdgpu_userqueue_setup_ip_funcs(userq_mgr);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> new file mode 100644
>> index 000000000000..12e1a785b65a
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>> @@ -0,0 +1,84 @@
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
>> +#include "amdgpu.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static int
>> +amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, 
>> struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +    struct amdgpu_mqd *gfx_v11_mqd = &adev->mqds[queue->queue_type];
>> +    int size = gfx_v11_mqd->mqd_size;
>> +    int r;
>> +
>> +    r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
>> +                                AMDGPU_GEM_DOMAIN_GTT,
>> +                                &mqd->obj,
>> +                                &mqd->gpu_addr,
>> +                                &mqd->cpu_ptr);
>
> Don't use amdgpu_bo_create_kernel() for any memory allocation in your 
> patches. This allocation is on behalves of userspace and can't use 
> this function.
>
> What we need is an eviction fence similar to what the KFD has 
> implemented.


I want to discuss more on this, why are you considering this allocation 
on behalf of user-space ?

MQD will be accessed and used only by Kernel and FW, userspace just 
requests us to create and map

queues with some specifications, it doesn't know anything about MQD. All 
userspace accessible allocations

(Queue, WPTR and RPTR) are done in userspace.

- Shashank

>
> Regards,
> Christian.
>
>> +    if (r) {
>> +        DRM_ERROR("Failed to allocate bo for userqueue (%d)", r);
>> +        return r;
>> +    }
>> +
>> +    memset(mqd->cpu_ptr, 0, size);
>> +    r = amdgpu_bo_reserve(mqd->obj, false);
>> +    if (unlikely(r != 0)) {
>> +        DRM_ERROR("Failed to reserve mqd for userqueue (%d)", r);
>> +        goto free_mqd;
>> +    }
>> +
>> +    queue->userq_prop.use_doorbell = true;
>> +    queue->userq_prop.mqd_gpu_addr = mqd->gpu_addr;
>> +    r = gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, 
>> &queue->userq_prop);
>> +    amdgpu_bo_unreserve(mqd->obj);
>> +    if (r) {
>> +        DRM_ERROR("Failed to init MQD for queue\n");
>> +        goto free_mqd;
>> +    }
>> +
>> +    DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_bo_free_kernel(&mqd->obj,
>> +               &mqd->gpu_addr,
>> +               &mqd->cpu_ptr);
>> +   return r;
>> +}
>> +
>> +static void
>> +amdgpu_userq_gfx_v11_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr, 
>> struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_userq_ctx_space *mqd = &queue->mqd;
>> +
>> +    amdgpu_bo_free_kernel(&mqd->obj,
>> +               &mqd->gpu_addr,
>> +               &mqd->cpu_ptr);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_gfx_v11_funcs = {
>> +    .mqd_create = amdgpu_userq_gfx_v11_mqd_create,
>> +    .mqd_destroy = amdgpu_userq_gfx_v11_mqd_destroy,
>> +};
>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 7625a862b1fc..2911c88d0fed 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -27,6 +27,12 @@
>>   #include "amdgpu.h"
>>   #define AMDGPU_MAX_USERQ 512
>>   +struct amdgpu_userq_ctx_space {
>> +    struct amdgpu_bo *obj;
>> +    uint64_t gpu_addr;
>> +    void *cpu_ptr;
>> +};
>> +
>>   struct amdgpu_usermode_queue {
>>       int queue_id;
>>       int queue_type;
>> @@ -35,6 +41,7 @@ struct amdgpu_usermode_queue {
>>       struct amdgpu_vm *vm;
>>       struct amdgpu_userq_mgr *userq_mgr;
>>       struct amdgpu_mqd_prop userq_prop;
>> +    struct amdgpu_userq_ctx_space mqd;
>>   };
>>     struct amdgpu_userq_funcs {
>
