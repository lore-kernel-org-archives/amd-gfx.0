Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3D2C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 15:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90DE10E418;
	Wed, 28 Sep 2022 15:55:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B7D110E418
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 15:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eo5mqXPTgq7NpX6GZV5nCLGbHRXXaZhu/IMRzwAo2x0cYEl6UVI9bXh3O9IXlR3lI6E5n5UIKCCwjE0Z2MVrLD+Lokn/jJzcova9SGYwArtLh3g7T4NdXTBn5wdNuOBqmLzvI7Qc0BjYj9vhYlaZMKRzqNwA6z6lhZfBEks0LpyU+vkR10EkHQ1+evif0lEJJ125Bui0gwyi40hpWhZ8sMjxIzN/TMjyK4ytaruwIV/Mpwo4v83m5b+Q0FbhPy57IPAC7p88eVRkwmTMZoX234QZ+s/yOVwxITEdVKzOUIXlFb/L/+7LBKsmTPKHX4opXV9I4vRJ20jhQysBTLPz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVTfo3pkyCXlT+M4MpP8whN0YkysfO6yxOKVErHNius=;
 b=UCEvWRC45I/HsPx8djFNvledmezBg+vMsrDTgQtEqEyiqymv4j68le+j1gbvhojAVILzHbhNsmWP0qog64C8eSB2DzowYz/+LTUA1t4QKpRaMi2ZZk5AzFPwntb6NFW9VT+Zw2x8lFMWnb+5IANK2ZH121pOlUssR8xSMQWtYzmJr/Vrg8zUQ2ov1WOyqnHphNNWthOvYTwDuzPYY1nF4YBjQAE4VtWzWFKUx64xPaaUVu5thQc0DBU2uQcgaqdy7e51FfplTJzmoVncn3DdfjvnMdKxI+2YLtngXNABQwJg/XmvM87JBw2+ZmM5DCEgHo5hC9MAz3/JhtgflIuLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVTfo3pkyCXlT+M4MpP8whN0YkysfO6yxOKVErHNius=;
 b=uN7hcJNhw2iTa/WV6GELZ5hmGHDo1FAwSknjsLIT3cW5vlZ6Nbms8dEDoli2vVVkoLvKf5alioSu6o3k+Rj4y9V9qtba/ezveSBQ8s+KoHkYsrGYxtF1w0ctjfVBPGXTy3nRpqEoZbTOkQW3/Vqx3jUgYUBvkmN8Dia84/GM6x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM4PR12MB6447.namprd12.prod.outlook.com (2603:10b6:8:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Wed, 28 Sep
 2022 15:55:45 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::3a6:8841:66ca:7d8d]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::3a6:8841:66ca:7d8d%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 15:55:45 +0000
Message-ID: <a2efc2bd-59e9-2e15-40bc-4c0faadc9b01@amd.com>
Date: Wed, 28 Sep 2022 11:55:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 1/1] drm/amdkfd: Track unified memory when switching
 xnack mode
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220927154348.20274-1-Philip.Yang@amd.com>
 <b3ad27b5-c101-3e73-cc30-fcb095587c62@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <b3ad27b5-c101-3e73-cc30-fcb095587c62@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:610:77::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM4PR12MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: 93472515-5abe-41d7-52af-08daa169e778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDBRgsLYqLmqACBITCqKSm8LDhWjKd73ZLyAcRI7Egf4lPCMBcRXcrlIGaVR1JsTSvLNGbHaei9svA9QRP/ZRMRr7xoX7f/w/ejfYgmh0IdALdrVSaVel8ObCMdFw/7z/5kN8FkWH1jS8+paLxCvheL9k66D5mJHi/N+hSH0jXMursRnWlwb+jkGXpk+VZ5eKXgHxtqrYuW4xCG0s71pxEuO9Fyd5e6gz/SI9thShGnHDcp45sB8sIjBIp7dXOQ/3H287fABrC9eJkSkOG6yLfY8LScRfsOLdAFbjS6qW6I0yvk4oH46AQvqzeP+LITmrtwLplk5Q1YVQQ7rNq/JaKTn1d7M4WdZju+gn++YsN2Vy8TdpXQ7FL5l9W65MR+y3iu7gvELJOwzZ2Hv5yxGzRtIRBWbn3WTNjvuQ69gAo5A1Npfd+sjEe5andm7TtjSFeZmENw+boi+Ml4UtsqkCZEQExAUpnGxtoxRt20y0dROIhncNChBNG16dVgU8QRIpmT+mS9NGK67ueJWN+NLri+2oth2F8ANJkTCvrG/1epjCL5ATkkqD0k16xL+5EDAAEAcGFwObtXLkgkAWtuvJ/idjprhz7HMJ3ywHaGIPyM9FkcuoOzP6jHCNG0Fgv7Z82zaz0dMTwFzsnkfDgK7DjSwJ3Rk9fz0oybU+LItnravFXE0dDidakuiYogf4Qne9tovzLAJgWF0a1bldDgwMalLqGZQ8i0qfo8dEKwcociMzlkVkBSaqjoD3nim+cXmfUe+NkNy7aENv+oiil22L3wv4TUcZL2LyTXhh1Nj5GE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(316002)(110136005)(2906002)(36756003)(66556008)(5660300002)(8936002)(31696002)(8676002)(66946007)(2616005)(53546011)(26005)(478600001)(186003)(66476007)(6506007)(83380400001)(6486002)(38100700002)(6512007)(41300700001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFhUMUYweDUxZ0hLK1NqaU92OE9qNXVIL3hxL0NlT3ZLU2VLcm9tZG9PTitZ?=
 =?utf-8?B?QnZEeGxScWFHYVVyNFZJbFR0TzJRZXVPM3hJN1lwTG92UERvTEgxL29QSDZq?=
 =?utf-8?B?Z2ljYXVCaEFOMWtsQytsempmeWxjTGs0a2hQZWdjbXdYSFE3K3VraS9LY2R2?=
 =?utf-8?B?Q1BlbUoxcnEyNXdHV0kxQlZ6N0FUbWVZSnQ2ZDVVWEluc0JnU3BIQUN2STEy?=
 =?utf-8?B?NHpjbzdhMUZsckFXdmtScEJwYTBFQlQvT2V3bmFCb3RRbFR2SHQzMlZjZTNo?=
 =?utf-8?B?TUtsZktGTDFISDA5bTN3Z3REZDU4d0NSdkVzdjl6dGU5NlQwUnkrR2dXT3R2?=
 =?utf-8?B?QldBQ1ZDcjBDMEVsK3V6L0UwMit1WldybUtVbDlITU52STV0LzhhY0tpRU1H?=
 =?utf-8?B?MDJrb1BJK2dINXpvUlpRckpId2c1b2VGL3ljVVZkMmY4RGJFbUNyMGUxQ3Js?=
 =?utf-8?B?L2hwK2FMOVliRkFMYnlqbzRJMGlLZ1c1ck1WWnhySkxWSEdUZWM0dlJlS2pS?=
 =?utf-8?B?V0FJUHZSSjByTEttRGxwb2JNR09LcDNtelpaT0Q4R09mamFDSHMzZ0FBVHBh?=
 =?utf-8?B?NGw3Qk9ZcDV3VjNxVUxldFVoa0JuMU5qcmdGbnZWYUYxS2M1US84Ymw3R3ZR?=
 =?utf-8?B?VzYvamkwZldtWEk2ZWJ5NTY3K2J5czJwSDcybXg4ZUZGVisrdFpQTWlmZFZO?=
 =?utf-8?B?elk1SlVIWnVCL2JDU2pFRDdpSG1ONEhQUnB0azh4K2JSWFJjOSs0TE1KcTR0?=
 =?utf-8?B?d00xcjEzL1p4TTNNaW1tVXpaTFJ3cEF1RmpiZlYwUGFrNnlUOXlHWExZUk9p?=
 =?utf-8?B?ZW5rQWIwZW9Dc256bE5xV3IxelhqUWlLNW54OWNHMDc1Z2htVzVlSW9jWEcy?=
 =?utf-8?B?dVBiamZWMDhLaS91ZHp1QWoyOHlMVisvWncwYzg4aUN5NVRETzJ4Zi9tcjRC?=
 =?utf-8?B?cmh5TTVLRnNxNjJsRU9wUUhyU2NHS1lSNUlwVlRORWVxb01IL28vUTVUbjZB?=
 =?utf-8?B?RzJ0SjVvRTZvbmJndzdkNWJQamppczB3cnZhcjF4REFSR3Via044bEJBUEt0?=
 =?utf-8?B?ek5ET1VWMHY5UFhyOHpUNHB3bzlzN0NQbU1kYVFvY3hvYm5FVEFZaTN0QmQ2?=
 =?utf-8?B?T3pPWkFwVkNDSlJJME5TT29rS1Ftd042WkU4T1UxR1JlOHhRTkpoN0Z4Qjcv?=
 =?utf-8?B?OG9jOTdYMzFRdGZvV1Z0L3p0VnRlTU9RVkV2a0U3U2taQ3lTVGExSFM2eXFW?=
 =?utf-8?B?RnB1ZzZ3ZEh0QTd4Qm95SGZJK2tGM1ZETUNua3RldGpOc3pZZUN3M3hJN1Av?=
 =?utf-8?B?TmtGeFRheHdqVU01UW0wZXNCeUl3OSs0UWZQU0ZkODhyNC9iZFlJZEVhZzBy?=
 =?utf-8?B?NkQzRWtSaFFCdGRPOWlWTzdzOTNpdUpmUkJaSFMxckZKU2tlaC9uNCtLNjRY?=
 =?utf-8?B?RVlmcWtjb3l1bmg1RmtKRVlLaWt4dmdpbE1ERFpicEp2dWx0SDFjajBYL3Br?=
 =?utf-8?B?VXJ0cUJrK2laMFk1MjBMQi8xdWh3RndNSFJvRFNENkFPY21KQ2FYWGpBcHp5?=
 =?utf-8?B?aWQrOW15SGMxMEJ6Y1pwSTZWQzQ5MkZoMDBtZTdRbk1KMTRTSDExUElIOWdi?=
 =?utf-8?B?N0w1K3duOVN2T0pTbmgwUTdKN09lYW5LemhMN0JNcDlYUGdPSEkwR2tzaCtD?=
 =?utf-8?B?Z1lUc1ltblZZZHhUYm56OVJ6VVZ4V0dFejFZai9qcWtpZm9oZktvTWtDbUJQ?=
 =?utf-8?B?d0kvMlQrRVYrK0JCeFdCcEhFSVAyS3VpTFA4SDZUUytHYU5vS05nSEFROG1I?=
 =?utf-8?B?QlUwVFZvZkluamNGdTZ5eXVYenpDOUthN2VOYXVhY1U3MjNHczZxcmdNM2tF?=
 =?utf-8?B?YUgzQzZhcGhhNlpNTktxVnNJZUhpSHBXSkZ1cVdOUlFya2NkRVNWclNiZ08y?=
 =?utf-8?B?T1pkRVZCNUlKOVBZY0JRUFYzVTFFRjFhNUVvUXRyN3JrNEhuaU96WC9xVXhM?=
 =?utf-8?B?b0Y0TkhZV21Zbk5hSFltdVhSbVN5RlRxZmJ3d2pQd2YrZ3RYYmxFQThhUW9L?=
 =?utf-8?B?L0hsc0lFYnZ4UW1tWVNNV1F2K24rdWlSSzVoZlRXWElmWm5PSklWRmZ5cW9h?=
 =?utf-8?Q?eCZQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93472515-5abe-41d7-52af-08daa169e778
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:55:45.5593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zvf1xFbep3ugiI1nWSEslogUu4YGpKJCCFub4U4o/FF88+kJwleFXqNRHoYr/ecM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6447
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


On 2022-09-27 14:58, Felix Kuehling wrote:
> Am 2022-09-27 um 11:43 schrieb Philip Yang:
>> Unified memory usage with xnack off is tracked to avoid oversubscribe
>> system memory, with xnack on, we don't track unified memory usage to
>> allow memory oversubscribe. When switching xnack mode from off to on,
>> subsequent free ranges allocated with xnack off will not unreserve
>> memory. When switching xnack mode from on to off, subsequent free ranges
>> allocated with xnack on will unreserve memory. Both cases cause memory
>> accounting unbalanced.
>>
>> When switching xnack mode from on to off, need reserve already allocated
>> svm range memory. When switching xnack mode from off to on, need
>> unreserve already allocated svm range memory.
>>
>> v4: Handle reservation memory failure
>> v3: Handle switching xnack mode race with svm_range_deferred_list_work
>> v2: Handle both switching xnack from on to off and from off to on cases
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++++----
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 44 +++++++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
>>   3 files changed, 64 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 56f7307c21d2..5feaba6a77de 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file 
>> *filep,
>>       return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>>   }
>>   +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>> +
>>   static int kfd_ioctl_set_xnack_mode(struct file *filep,
>>                       struct kfd_process *p, void *data)
>>   {
>> @@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct 
>> file *filep,
>>       if (args->xnack_enabled >= 0) {
>>           if (!list_empty(&p->pqm.queues)) {
>>               pr_debug("Process has user queues running\n");
>> -            mutex_unlock(&p->mutex);
>> -            return -EBUSY;
>> +            r = -EBUSY;
>> +            goto out_unlock;
>>           }
>> -        if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
>> +
>> +        if (p->xnack_enabled == args->xnack_enabled)
>> +            goto out_unlock;
>> +
>> +        if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
>>               r = -EPERM;
>> -        else
>> -            p->xnack_enabled = args->xnack_enabled;
>> +            goto out_unlock;
>> +        }
>> +
>> +        r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
>>       } else {
>>           args->xnack_enabled = p->xnack_enabled;
>>       }
>> +
>> +out_unlock:
>>       mutex_unlock(&p->mutex);
>>         return r;
>>   }
>>   -#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, 
>> void *data)
>>   {
>>       struct kfd_ioctl_svm_args *args = data;
>> @@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, 
>> struct kfd_process *p, void *data)
>>       return r;
>>   }
>>   #else
>> +static int kfd_ioctl_set_xnack_mode(struct file *filep,
>> +                    struct kfd_process *p, void *data)
>> +{
>> +    return -EPERM;
>> +}
>>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, 
>> void *data)
>>   {
>>       return -EPERM;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index cf5b4005534c..13d2867faa0c 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range 
>> *prange, bool update_mem_usage)
>>       svm_range_free_dma_mappings(prange);
>>         if (update_mem_usage && !p->xnack_enabled) {
>> -        pr_debug("unreserve mem limit: %lld\n", size);
>> +        pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>>           amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>>                       KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>>       }
>> @@ -2956,6 +2956,48 @@ svm_range_restore_pages(struct amdgpu_device 
>> *adev, unsigned int pasid,
>>       return r;
>>   }
>>   +int
>> +svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool 
>> xnack_enabled)
>> +{
>> +    struct svm_range *prange;
>> +    uint64_t reserved_size = 0;
>> +    uint64_t size;
>> +    int r = 0;
>> +
>> +    pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, 
>> xnack_enabled);
>> +
>> +    mutex_lock(&p->svms.lock);
>> +
>> +    /* Change xnack mode must be inside svms lock, to avoid race with
>> +     * svm_range_deferred_list_work unreserve memory in parallel.
>> +     */
>> +    p->xnack_enabled = xnack_enabled;
>
> This should only be set on a successful return.
>
>
>> +
>> +    list_for_each_entry(prange, &p->svms.list, list) {
>> +        size = (prange->last - prange->start + 1) << PAGE_SHIFT;
>> +        pr_debug("svms 0x%p %s prange 0x%p size 0x%llx\n", &p->svms,
>> +             xnack_enabled ? "unreserve" : "reserve", prange, size);
>> +
>> +        if (xnack_enabled) {
>> +            amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +        } else {
>> +            r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +            if (r)
>> +                break;
>> +            reserved_size += size;
>> +        }
>> +    }
>> +
>> +    if (r)
>> +        amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
>> +                        KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>> +
>> +    mutex_unlock(&p->svms.lock);
>> +    return r;
>> +}
>> +
>>   void svm_range_list_fini(struct kfd_process *p)
>>   {
>>       struct svm_range *prange;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> index 012c53729516..e58690376e17 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
>> @@ -203,11 +203,11 @@ void svm_range_list_lock_and_flush_work(struct 
>> svm_range_list *svms, struct mm_s
>>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>>     void svm_range_set_max_pages(struct amdgpu_device *adev);
>> +int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool 
>> xnack_enabled);
>>     #else
>>     struct kfd_process;
>> -
> Unrelated whitespace change.
>
> With these two issues fixed, this patch is

Thanks for the review. I realize we should handle prange->child_list 
when switching xnack mode and reserve memory too, as there is a small 
change in sys/kernel/debug/kfd/mem_limit after overnight test. I will 
fix this and the two issues you pointed out, then push the patch.

Regards,

Philip

>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
>
>>   static inline int svm_range_list_init(struct kfd_process *p)
>>   {
>>       return 0;
>
