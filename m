Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEC5EB64D9
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 07:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B068E10E534;
	Fri,  7 Jul 2023 07:40:20 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526F210E52C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 07:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV1Sbt6zUk3G4RetMMSIsaPK/lHHi/JmKLZjYVxCWE7oAzr/1juEkEJRijidGn99MAMOb6NkOd2RvrrBtLO/Qaqu7KgcMZwp9dEk3NQK/zO7BWYn6E4pecE7VMWGAyoSt0Xv07dUWK0Z74aX7n3rbA96EEGYINtv1I522dSqv/v53iFWmun3nMvLKdo936Epd27GSi1tFIXHNyWbHfa3FwjMkdG+K3gjKEAleSH/vcl/O3kI+q7Z3NMd519gpTGsN3pGhRQIyDhVEhUkNEtSGr8VxqQN6T38zqqrCkYmsDCcu49SRKPwfR0SRvZNeyLXzjuC6Fuo0XuB2uN5kxN2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQkq6e6F97tjpbPq/QxqwWLYEWnkZbm5RL9TmGQr6pM=;
 b=OCyINBQuLnQG4Xii7UcQ2qgVgpEcQg6u2nSFea659oyG3JEF1S+xb44w5tWIdUuaHZFczj7jVFwsM85E3cV3QcAbEFwN/LLHXraAf+09LH7xKVfLgAzBcmlcPl20Rfypc/7ilVtnm/XEXyFDY+9rqd4TQ6bqhnzil0a4xNq3v8wx4OUlOfSMu4JliR4hzR784a48DCNE7B8NAZb9g+W3Zh9hPlvnt7ZFNqS6T+RVIJShmq6YH/q+7feNkuJZk3blyHKNh3Wbe/StqeHTDuj7rXx4plqqQUk1EauJUY77vZGzfikWk28FVeq/6j2rC4v+madmLt+MhV9sr1AkQf+wbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQkq6e6F97tjpbPq/QxqwWLYEWnkZbm5RL9TmGQr6pM=;
 b=0uy3c4GODiJrS10xhMviiY0O/DaAPSsRY+tmbNoxamo5WamoS6GIf2O/6k0QNFFgApk/vlLNu4M55FAbydHHYrgBK9neEMILyRJtdnvyY0EJ4jkPDnaEI8KUz43mqxi1JKuxxqtt/hjz7NnxOYJtIFI+dKxRPBqoQ5gXi5l5sgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:40:15 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 07:40:15 +0000
Message-ID: <0b9952c1-c0fb-dfc3-7c92-5929d5553518@amd.com>
Date: Fri, 7 Jul 2023 09:40:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 09/10] drm/amdgpu: cleanup leftover queues
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-10-shashank.sharma@amd.com>
 <c64191ca-f17b-01f2-54df-63d4c3e4f890@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <c64191ca-f17b-01f2-54df-63d4c3e4f890@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::9) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: a308e0cb-3a0b-4406-65cd-08db7ebd6782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TUOQNqlJn6ZGA3p6iw+743mm3WyeDQ5TU5y2Bh/fogf652f8Qt7jO+khZC6GlZnV4/ob8l48LObcFgMRMudyilHbeWSH+DNFlyvIbquiILMxpt/D3jiOQLTy8QEaZLG5VO/UZj0abJgGECfeTKfwdUdZMH6wrEMSl47A2HbRXj/1iQEKN2YAImtFEvWbosv4832mpffzIZiE/GhMegraniHWn37j4/sVfYEEma04UPNGKRrw9dSoaKN/7nZILvRme8Fzh8SZraSC53M7kFp95SRFbsFvrxSHks1QjIRtvcxjBFKtOizBqO+OqWvFOzejJMLqQiuLw+wXrmP0wDTFYzxv7GuwiBTl4Ex3t02oBvo9giSUyiEtLwnwmod1dS3nvvaTDiZtwzVL61Po8Lb4Vi+9XIJz2S89IWArkW7QwRntzT97BT2B6e4yFX8pzZH6F1/uRVlJnBMZjEe/R0lBTA7hE7oMA/bos17T+UotaTptNLBv0UPJMFn/C8ruKt+kz3OLD8/QqFd0zXV03U7/J0ClNOrie9gYlsAqI99RbICW7TL8FDlnfgHeOCBT4hlIq9VioeUwRjtr3CicXIhBoKVdR8fYCDlCxvJSfyieFNPv2Ml4afWKa4oqaDZM4TdIwFZhRJvy5KF7WCK+kXBStA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199021)(2616005)(6666004)(478600001)(6486002)(54906003)(26005)(66946007)(186003)(6512007)(53546011)(2906002)(66556008)(66476007)(41300700001)(316002)(4326008)(44832011)(8936002)(8676002)(83380400001)(38100700002)(5660300002)(36756003)(31696002)(66574015)(86362001)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SExIWmRxSFRQdWNlQk9lZ3lGNkNGYjFBWFJKbysxVUZRR21vR3VNalNFeUho?=
 =?utf-8?B?YzIwdUpQMko1SWtvdGFmMmcxS2Z4Tnh3TDJZdjRrdyt3UkdPUjdWRERvWWVR?=
 =?utf-8?B?N05XU0xVdkdzbUJESG4yMERLZloxaVkvQ0VSRm56RlE0bE1Ga0dQVDJDemZT?=
 =?utf-8?B?Sm9nQlBvOFVtR0o4TDNhR1FQaWNWWG5rMW1uTW5HSnZPei83VGZaV2xXenhO?=
 =?utf-8?B?QWsxcERQdUdCSFhoTzFuWG0yR200d3E0aVhkc053c2MwRG9YS0VyQ0F2dUZl?=
 =?utf-8?B?Rm16OWY2TmQ4VmlibTVHbWxJTWtsNGw0MDhlZ1B3NkJSdUlZSWRsd0Q5dzJB?=
 =?utf-8?B?SFBOMGFZd2VXQmRHajQ3Y0JYcjBRMTFkR0NmRTRDV1ZJMmFScDl3NmU5Z3Vv?=
 =?utf-8?B?bW85MHYxWUlvRUZiVXRQdDBIM3MrZ2l2QzRBOCtZeWdpeWhManV4R0dhcUdC?=
 =?utf-8?B?dGVaWS9nYU5DOFd2VUV0NERPdms5OEh0bk93cS9qUXlsOVJXd0toZG9XSXB0?=
 =?utf-8?B?TmpJckx3MWN4UFYzY1RtMm5tOVAvaGZRclBJMWNqazh5WkZEdldIbXFjL09U?=
 =?utf-8?B?Wi9xTWtSQ0o3SGw1WjdrL29xWEF3UGdrMWFjODVnT2psNXhPOGE1Z2ZnWXdt?=
 =?utf-8?B?cDFiSWlWRTROZ2Q0TWNWbldMTkNyZlZjbEFLTGFNQ1lKcDMydXZEUERuRHZz?=
 =?utf-8?B?T1ZmTTd4M2N0bmxvZ3o3aXBiaExZUVFwbk1hTjViNXY2bHJHb3JINkprWFJk?=
 =?utf-8?B?Ny81SmhZbEhrcXM4NUVlT3pESFBPdkF3UGxhalhsU2JMenZoNTRhcy9KNlZF?=
 =?utf-8?B?Wm12TTR2dDE0aDJNaXZseHRZWkN6TGdPOUgzbzlRbTNKUTFZN3B3WCt6K0Qz?=
 =?utf-8?B?U2hJQkw3WTQ3T2JWQzQ5Zk9iT3h5T1E2L25WUXd0c05hQjRJQjMvcDlieU5t?=
 =?utf-8?B?eGpwRjZSMjN5Z2ZQb2dLU09uSGU1alpjQTI1dDZWc3BHVHdYbExjWkc4UGdn?=
 =?utf-8?B?bmNpWjIyRXlvUmFSR0g0U0ZMYVZ0SkY1VEREbUV3Lys4aU1xcWJ3RnVMandZ?=
 =?utf-8?B?WVoxVWJiM2JLVGJjN1NNV3EvMUpJL1cwaGlSZ0hSSFp5aGxvalgrRDdYVUd4?=
 =?utf-8?B?bUREUGFKdmlIU1QrREl6T3N3bHFIS05qR0RNWDhsa0FRbG43NFpFS3ZOK2FF?=
 =?utf-8?B?aEFSMHk0SXU0L0RhcFFTd0NRRi82VWpVMUF3bEt5OFJDU0RYaGpsQkdFVWxJ?=
 =?utf-8?B?TGxxOWxMczhLeDUxWFRIUDVFYysxTXRqL2lPejU1UUZBdlhPZDhjb3FyUlF0?=
 =?utf-8?B?K3E2OXBBcUhPYU5NMVFQOVdJbXlSeW4reTBqWkRwM1BheVBOb3dkVXJpRzF6?=
 =?utf-8?B?N2ZLMWpiUlJLM09WWkZWZzZqYmdQbnhSMU83TWd0Yy9JQzhJUFl6SVhNc0to?=
 =?utf-8?B?clBQVXBiWkFhYjNuWjJ2K1FuUFFDT0lXTU9xTTM5cGpNelYwQUU2WWNvKyt3?=
 =?utf-8?B?TUE3cTNseGVOZXdsVzV0NzUrV2M3d0J0YTBzK3JQbFBhNWp2NlhoakVjek1o?=
 =?utf-8?B?TGNuQzd3cjJWOGYvVG9sdDEwdmJjYVVCL2hibDJna0diYzJEZXVjajdqTE9V?=
 =?utf-8?B?Wmc5K3RTd00ra0NXc21EUENkSG5Uc0hZd2ZVMHVaWlV6bVA3ZktYR3RVQW9z?=
 =?utf-8?B?bDUwTkNkdUdpck1Td0toWHRSTHJ4eHhqQVBBUWRDamFlKy85alpKN2NCMVA0?=
 =?utf-8?B?cWp2ektoUFVkMjd1RVFadE5HaHBZRHY2UFc3dWYrR3F4WndYRVdIdVVSYkZH?=
 =?utf-8?B?Z1QvUXFhTXpITE1abk92eGRGSzFuc1F4YXhNNFB4UmdHYWl4SXBzemk1K21Q?=
 =?utf-8?B?YVl2VkpJUGNyTEtZZUo1RWR2SC8vNUw3VlNLMFFmMkUxRUZldFk2WjI4S3Rz?=
 =?utf-8?B?MVM5RmROczN0ZjdoUmdraHFWTStGMk1lRThPS2o3UVhDWFRsT3Zlc1ZFRXpT?=
 =?utf-8?B?RlFBZ0loV3ByZ0NCQ1B0Q3pKVnBJbWNGbjgyaVNhV2xLaHJkWFVldS8yTjFk?=
 =?utf-8?B?cjM4bElmSVVkLzZlQktEZ3I4WTZiemFqZG9TY2NjT0dYSnJtRzhFWEZ0VU82?=
 =?utf-8?Q?LFHgz2QOS6ywFjAI0l/KxqfIY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a308e0cb-3a0b-4406-65cd-08db7ebd6782
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 07:40:15.6002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxkDqyED8wJ5284nPjFzoxDHqo5eNYY45GQbTg0G7dc36QsZSCq9lzTq5gbKitbTvTHmMohKlDVXJ6MCc2/9Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 07/07/2023 09:17, Christian König wrote:
>
>
> Am 06.07.23 um 14:36 schrieb Shashank Sharma:
>> This patch adds code to cleanup any leftover userqueues which
>> a user might have missed to destroy due to a crash or any other
>> programming error.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 31 ++++++++++++++++---
>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 61064266c4f8..6e32e2854a58 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -57,12 +57,23 @@ amdgpu_userqueue_get_doorbell_index(struct 
>> amdgpu_userq_mgr *uq_mgr,
>>       return index;
>>   }
>>   +static void
>> +amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>> +             struct amdgpu_usermode_queue *queue,
>> +             int queue_id)
>> +{
>> +    const struct amdgpu_userq_funcs *uq_funcs = 
>> uq_mgr->userq_funcs[queue->queue_type];
>> +
>> +    uq_funcs->mqd_destroy(uq_mgr, queue);
>> +    idr_remove(&uq_mgr->userq_idr, queue_id);
>> +    kfree(queue);
>> +}
>> +
>>   static int
>>   amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
>>   {
>>       struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>       struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>> -    const struct amdgpu_userq_funcs *uq_funcs;
>>       struct amdgpu_usermode_queue *queue;
>>         mutex_lock(&uq_mgr->userq_mutex);
>> @@ -73,11 +84,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, 
>> int queue_id)
>>           mutex_unlock(&uq_mgr->userq_mutex);
>>           return -EINVAL;
>>       }
>> -    uq_funcs = uq_mgr->userq_funcs[queue->queue_type];
>> -    uq_funcs->mqd_destroy(uq_mgr, queue);
>> -    idr_remove(&uq_mgr->userq_idr, queue_id);
>> -    kfree(queue);
>>   +    amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>       return 0;
>>   }
>> @@ -193,8 +201,21 @@ int amdgpu_userq_mgr_init(struct 
>> amdgpu_userq_mgr *userq_mgr, struct amdgpu_devi
>>       return 0;
>>   }
>>   +static int amdgpu_userqueue_cleanup_residue(int queue_id, void 
>> *ptr, void *data)
>> +{
>> +    struct amdgpu_userq_mgr *uq_mgr = data;
>> +    struct amdgpu_usermode_queue *queue = ptr;
>> +
>> +    amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id);
>> +    return 0;
>> +}
>> +
>>   void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>   {
>> +    idr_for_each(&userq_mgr->userq_idr,
>> +             amdgpu_userqueue_cleanup_residue,
>> +             userq_mgr);
>> +
>
> Better use idr_for_each_entry() here which avoids the mid layer function.
>
> Apart from that it would be nice to have to merge this patch into the 
> original one adding the user queues, but really only nice to have.

Noted, will check that out.

- Shashank

>
> Christian.
>
>> idr_destroy(&userq_mgr->userq_idr);
>>       mutex_destroy(&userq_mgr->userq_mutex);
>>   }
>
