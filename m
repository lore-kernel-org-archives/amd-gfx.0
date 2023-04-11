Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471B7C76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 16:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93E0710E37F;
	Tue, 11 Apr 2023 16:02:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8189510E0FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 16:02:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqN+4oPvGHN5stj1dyisrziFrUbGOLms8LrrZQxwJAZthXqJQaeZqjlC/76MI4uKIFmc5E19XA4hIMSDjSfcU5QjrG+ZPqOivI1FcC3tdDeBVOGUhLerb1tWolfCgw4D4m9NgilD30/giUhLyG6ml6aG0PPsMGkXGteD1SxlhbHzPwZzgQQpVcS5XZ11XRtxHwOTI2J48HrUenXCQ6m7rsTtwBaBcX8M2JqW4Vj5xKkL6bZWjG9ElFKp9scb2LnL5jTH/hOh1APNvDbxxpcksHNd4LEqkWSGkSlw5PkZLD7j3R+jI1Jvz/vlTcULHkRnh0PQk3Lna1pEdOZcguZztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIluTp8R56u4br9O9gUWNlT8vkSWhrA4T8PP/YSMHYE=;
 b=HLpFTrnsNZ4bQP/dH9jIbMcpU8ZzCgDNwLf8hwb4xNc1/IOHe1splJff4N2fKV3C2AJ0ATcBIqtn380ZXXoS9SVBljbrp9wMMiDQ+2klp4bfyz20mASm1NPtxAVbk1ss6PNLj4tP1XfxIj8mOSxGl1/ng0whetMa3iijvm98KErbBoNRKlv68gsT0ct6ooC7RsYe6r9OexA2tstVi/OYJxR5JfWMLOvBZtPCb67uh8vj1/rU2VAO5kwrpi2raktbgcpyttbU5nDcoIVFma5/Em25HmwK/v/jDXbyH/lCS/SlvXCfAa5sEPvbAn4S+FSsaf05CdfT85sIWrEqlEotYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIluTp8R56u4br9O9gUWNlT8vkSWhrA4T8PP/YSMHYE=;
 b=T7laoe9zK711P/23A/A3xgeMJ7188RZJwf5NJbb9kntrBD+hELYyQAOXWtu+z91R24aBs0Mkl4F7FQ5tzlj6K8A/+G8iIbz9KqMFyJ3SckTT4OR4eD69bGi/99Yy5pafs0K3Rmx8+lF7UFdv0rGTSeEEzif4vEcw+oPVpuFduTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:02:29 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 16:02:29 +0000
Message-ID: <e9b79c75-9d0d-c217-b671-2486e4ad9731@amd.com>
Date: Tue, 11 Apr 2023 18:02:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 8/9] drm/amdgpu: map wptr BO into GART
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-9-shashank.sharma@amd.com>
 <CAP+8YyEDqyJxUHP4xJ9zjJ5BcCKeF0bH8ibjh-y+hp8SyiVgzw@mail.gmail.com>
 <fdaccfa8-4849-2750-66da-5848e6ca20ab@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <fdaccfa8-4849-2750-66da-5848e6ca20ab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ca0a62-3d83-4363-6790-08db3aa62684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wc6eJCjvhKvzb5C2n94yqJEpVki2vwoIu+Egh8gEHVzi1NcK0kw6zbfpCxhm7O9f3JHyQuLlEQL5oEpmM1VnRrvkmoYlK90l+uick1CVpo5lDWgLFqRa1olpBH2jw88tYKez8fb8quCMRc2Go+4w5aRpcjvNOC5ZI5UgSw6rtkOCBQ/+O6uUTWPn3zvHb9idoFg3iAVonflKyPmoyLRY7X8rUoOBLByZvTo9XkOTa1K0yiYFK3RAj1WMizYu0Wo726VgEwgjsOPYnLMjIerA1R59j9leCqrlPwTsXnewoDUm+HwqLV5AWC6zRWgvTMYwjZLU9E+nqC7zf+NnxR++C1xXstnFNrcTT1+QJHf9KE5XmZN46VWiM4eoDejI0ix36lpWKOOeqD+kQjAzPxcKvWvsT2uEV9Zu45o7MQ8xFdk0UXSJ4pSXvNfGlBjDqiIOj3LtLnbNNsj68rZU9t06Xg/FvGFTIVdjlyoXtE1249A6zMVlRJoCvp0eNYWVErJOCsnbPYQKYb9wCwo8WScZGGyy0vhEBUQSP1EMdCUHfPxIqFOClg38YQyTfCx1L6+2yQX1PUNlU1pgsk02YUgnw/+YEZyEu7sZ7Y66Rqxpl+2zIpDDku+E2Bh1s+VO66b+pgEyoYg+c2G755dwAGhlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(54906003)(110136005)(2616005)(478600001)(6512007)(6506007)(26005)(6486002)(6666004)(41300700001)(316002)(66476007)(66556008)(4326008)(53546011)(66574015)(186003)(66946007)(31686004)(83380400001)(38100700002)(2906002)(5660300002)(44832011)(36756003)(31696002)(86362001)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhQdEZmcXo5WkJPZ3BtMTA5dlhVU21xWFg5RGhRejh3cHlqUU5jVUJCK1JS?=
 =?utf-8?B?Tk91TC84WDNJUndrZzV1MmgzdVNJaHExUmJKSXJtQlBtNkY2REtHQncycE1t?=
 =?utf-8?B?Sy9CM3k5d0dhandHbUl5V2EyZ28wYzNIaFJiRDVzbW15Q1NhU3QvMlI5MnBu?=
 =?utf-8?B?YTVydnc1QnZmUG5LeGxjTG9oQnc4SHF2bEp0M2FqZ0hEM3J4SlhzMGhrZkZI?=
 =?utf-8?B?NjI4UE04ZEY5bFZ6MGVMbVdaYkRidmYyWW9FQmN6ajVJcGVkQVFQbHRiMW9U?=
 =?utf-8?B?R2ZHQkdhWk5KaEk1OTVzNkN3RFRHNWNnOVJSRWhPUzRXeHVEcStsemk5amN6?=
 =?utf-8?B?YTJGV0tPOFJPL000dFhtMVpxWUdZSFZkSTU3NGxpeSs3QkZCVGg3cWRPZ0tP?=
 =?utf-8?B?UG41QWpzQXNaczcwODJKVzRRYTFuV3puMUU3eFpkNm1QaFJIQlkyRjltUTBu?=
 =?utf-8?B?eTdUMXoraEdMSG85dDRkUUp5L0E0Y3N4RVBqRWMvRjRVYlNCM2hsTkVQeTRU?=
 =?utf-8?B?Qk5BS3JQZkV2L3R5cW5CVzIvRFJ2cWRaVTJzNmt3SzlWcHoxVzVQWENvdTZz?=
 =?utf-8?B?SG5KRFFVYk1tdm5WQlNXREFtMExkVHhPN2JnM3JoVC9MM2ZFUXVnMzQ0M2VI?=
 =?utf-8?B?d1NPaFkxTjZGY2h0OW5jUWkvNEZEWGJ4SitFNW5qZ2NlUzdRNnV4bnpQaldr?=
 =?utf-8?B?eEtwUkdXdk12dmJ1LzlRTjJYOURvK0toakMxeFM5b0FIaHI1M0EzYUkrbHJJ?=
 =?utf-8?B?a2tHRXAvWHl1YjdXMUoza0NIQTlHdEpJMVdsV2hTMnNyT1VWY0pOK3YrdTF6?=
 =?utf-8?B?bHBUOGNBdnB6SUwzeHFVcjlhcDM0MklISVQrZ2R0cU00UTBYWk1vaU8vS2Ri?=
 =?utf-8?B?TFZSdUE4L0sxV3gvL09Cd1I4elY2bXdvMEFDekl5YjZtS0ZyTDNFRzROZ2oz?=
 =?utf-8?B?SDRjRGNMbVdaNDVVNTVaWDJNVzJpZ2o3dXNEcGowR3JkWVRacy9Yb2pnSlZK?=
 =?utf-8?B?dndNOFh2cnBsMDVRTmRlSEY2ZmlVUGFYTHNqcndxK2ZFWDh5NmxVS1F2UDJ1?=
 =?utf-8?B?SEsyd0IzdEQ5SEd4TU43bUdacDdyTE1EYUtiNjQzZGh4V2pxY291dEtDOVdt?=
 =?utf-8?B?Nk5KV29aTlp5cWFyWTI5UWxXeFQrSlkxM05VN2NzcXVDY0lwa0dPdCtpMWJa?=
 =?utf-8?B?QWp0VlN1S3ZPTFNYUmswSEYxRkI5eVRZQnZQdlVDZVM3ZUl3SDhWdkdHWEV2?=
 =?utf-8?B?Q2VESFIxK0l6Tm95VVozVjkxVG81QkNwcmZXNzJBNmRSK2haRGhXVUpaeGpv?=
 =?utf-8?B?RDZ1aDBsTG43N2p3U2hSNXoyNGN6L0VTUmt5Mis5VTBwM1dMOWZGSGtEY0Zw?=
 =?utf-8?B?d284eHFHMUo4ZkhvN0x1Y2xCanB2N0RyVEZBcjg5TkhVcFRYeVoyMXlQQWZU?=
 =?utf-8?B?dExEcGhTczQyRUpSdXJHUmJSZC9XL012L1QvSk9UUUpLaFdIWDJNVWtJU0dX?=
 =?utf-8?B?dDV0Y2lCbUNQekQ3UjJDVzRlUWQ4azk3Z1JISzlEd1dCOWNHQVREOVVmYWUy?=
 =?utf-8?B?bHdzRHhNRWVmVlBDaERqVFNFUzgyaWQ3SDdDUHlhUTBSVDhKeGpFTUd4YVR2?=
 =?utf-8?B?U0ZBYUdHKzBaUmRRK2pkSlFDS1BLQTM5QkRqVTR5c2JtZ3BNUW03THdJQzlY?=
 =?utf-8?B?VTdrYXFsTTVRcXVWT052TGlQU2tqUnVpQzBnUlBIWVdJSUpKVWpIZTVTNWlC?=
 =?utf-8?B?bjZTbm11TndFZUsyY2FBN0ttQ0tjZGhESSs3bERFVG45dGxaMEpWempxNUxZ?=
 =?utf-8?B?VFROdE9oL2JORFZTbmlqWm0xTGpZaU1aMTVMcThOS1U3eEQ5cDk2ai9uSEU1?=
 =?utf-8?B?UW1lNU9KNlhFdU12YkZjdm1sTkxaZzd0OW5hSE51V05tVHQyTElDRHovR0pK?=
 =?utf-8?B?SnIrTlJzUWxXZFZCWlVSR1lpdDRnR1NYc2ZWVE84Mkt6TjJzcTF6b0ZOcHFm?=
 =?utf-8?B?VkFhN1o0dURiNU51MmFaR2x2dG52ell2aFpsSTg4a21KbWcybUE3amFYT3BD?=
 =?utf-8?B?cVdkUFZXM2tWaU1VblZrdW42eEhhRHpTOFRia1hoUFFxalMxbFd4MVJ5WXB6?=
 =?utf-8?Q?8LBJXkyZAdEJTLC9In5ZlA9w6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ca0a62-3d83-4363-6790-08db3aa62684
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:02:29.2154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d8UCwnwMlRXcEcuTxvkQxMg6cpUsA5bh3SqnNB0J7VMVqoT2pSxZXoES6zzjw6gDJjK48Zz23qjrXxLn7RQt0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 11/04/2023 11:29, Christian König wrote:
> Am 10.04.23 um 02:00 schrieb Bas Nieuwenhuizen:
>> On Wed, Mar 29, 2023 at 6:05 PM Shashank Sharma 
>> <shashank.sharma@amd.com> wrote:
>>> From: Arvind Yadav <arvind.yadav@amd.com>
>>>
>>> To support oversubscription, MES expects WPTR BOs to be mapped
>>> to GART, before they are submitted to usermode queues.
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Shashank Sharma <shashank.sharma@amd.com>
>>> Signed-off-by: ￼Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 89 
>>> +++++++++++++++++++
>>>   .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c |  1 +
>>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>>>   3 files changed, 91 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> index 5672efcbcffc..7409a4ae55da 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>> @@ -43,6 +43,89 @@ amdgpu_userqueue_find(struct amdgpu_userq_mgr 
>>> *uq_mgr, int qid)
>>>       return idr_find(&uq_mgr->userq_idr, qid);
>>>   }
>>>
>>> +static int
>>> +amdgpu_userqueue_map_gtt_bo_to_gart(struct amdgpu_device *adev, 
>>> struct amdgpu_bo *bo)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = amdgpu_bo_reserve(bo, true);
>>> +    if (ret) {
>>> +        DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>>> +        goto err_reserve_bo_failed;
>>> +    }
>>> +
>>> +    ret = amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
>>> +    if (ret) {
>>> +        DRM_ERROR("Failed to pin bo. ret %d\n", ret);
>>> +        goto err_pin_bo_failed;
>>> +    }
>>> +
>>> +    ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>>> +    if (ret) {
>>> +        DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>>> +        goto err_map_bo_gart_failed;
>>> +    }
>>> +
>>> +
>>> +    amdgpu_bo_unreserve(bo);
>>> +    bo = amdgpu_bo_ref(bo);
>>> +
>>> +    return 0;
>>> +
>>> +err_map_bo_gart_failed:
>>> +    amdgpu_bo_unpin(bo);
>>> +err_pin_bo_failed:
>>> +    amdgpu_bo_unreserve(bo);
>>> +err_reserve_bo_failed:
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +
>>> +static int
>>> +amdgpu_userqueue_create_wptr_mapping(struct amdgpu_device *adev,
>>> +                                    struct drm_file *filp,
>>> +                                    struct amdgpu_usermode_queue 
>>> *queue)
>>> +{
>>> +    struct amdgpu_bo_va_mapping *wptr_mapping;
>>> +    struct amdgpu_vm *wptr_vm;
>>> +    struct amdgpu_bo *wptr_bo = NULL;
>>> +    uint64_t wptr = queue->userq_prop.wptr_gpu_addr;
>>> +    int ret;
>>> +
>>> +    wptr_vm = queue->vm;
>>> +    ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>>> +    if (ret)
>>> +        goto err_wptr_map_gart;
>>> +
>>> +    wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> 
>>> PAGE_SHIFT);
>>> +    amdgpu_bo_unreserve(wptr_vm->root.bo);
>>> +    if (!wptr_mapping) {
>>> +        DRM_ERROR("Failed to lookup wptr bo\n");
>>> +        ret = -EINVAL;
>>> +        goto err_wptr_map_gart;
>>> +    }
>> This triggers for wptr BOs mapped to the high half of address space,
>> may need some mangling wrt the top bits?
>
> Yeah, correct. Shashank this needs to apply the hole mask before 
> looking up the address.


Noted, will update that.

- Shashank

>
> Regards,
> Christian.
>
>>
>>> +
>>> +    wptr_bo = wptr_mapping->bo_va->base.bo;
>>> +    if (wptr_bo->tbo.base.size > PAGE_SIZE) {
>>> +        DRM_ERROR("Requested GART mapping for wptr bo larger than 
>>> one page\n");
>>> +        ret = -EINVAL;
>>> +        goto err_wptr_map_gart;
>>> +    }
>>> +
>>> +    ret = amdgpu_userqueue_map_gtt_bo_to_gart(adev, wptr_bo);
>>> +    if (ret) {
>>> +        DRM_ERROR("Failed to map wptr bo to GART\n");
>>> +        goto err_wptr_map_gart;
>>> +    }
>>> +
>>> +    queue->wptr_mc_addr = wptr_bo->tbo.resource->start << PAGE_SHIFT;
>>> +    return 0;
>>> +
>>> +err_wptr_map_gart:
>>> +    return ret;
>>> +}
>>> +
>>>   static int amdgpu_userqueue_create(struct drm_file *filp, union 
>>> drm_amdgpu_userq *args)
>>>   {
>>>       struct amdgpu_usermode_queue *queue;
>>> @@ -82,6 +165,12 @@ static int amdgpu_userqueue_create(struct 
>>> drm_file *filp, union drm_amdgpu_userq
>>>           goto free_queue;
>>>       }
>>>
>>> +    r = amdgpu_userqueue_create_wptr_mapping(uq_mgr->adev, filp, 
>>> queue);
>>> +    if (r) {
>>> +        DRM_ERROR("Failed to map WPTR (0x%llx) for userqueue\n", 
>>> queue->userq_prop.wptr_gpu_addr);
>>> +        goto free_queue;
>>> +    }
>>> +
>>>       r = uq_mgr->userq_funcs[queue->queue_type]->mqd_create(uq_mgr, 
>>> queue);
>>>       if (r) {
>>>           DRM_ERROR("Failed to create/map userqueue MQD\n");
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>> index 1627641a4a4e..274e78826334 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>>> @@ -58,6 +58,7 @@ amdgpu_userq_gfx_v11_map(struct amdgpu_userq_mgr 
>>> *uq_mgr,
>>>       queue_input.queue_size = queue->userq_prop.queue_size >> 2;
>>>       queue_input.doorbell_offset = queue->userq_prop.doorbell_index;
>>>       queue_input.page_table_base_addr = 
>>> amdgpu_gmc_pd_addr(queue->vm->root.bo);
>>> +    queue_input.wptr_mc_addr = queue->wptr_mc_addr;
>>>
>>>       amdgpu_mes_lock(&adev->mes);
>>>       r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> index 8b62ef77cd26..eaab7cf5fff6 100644
>>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>> @@ -38,6 +38,7 @@ struct amdgpu_usermode_queue {
>>>          int queue_type;
>>>          uint64_t flags;
>>>          uint64_t doorbell_handle;
>>> +       uint64_t wptr_mc_addr;
>>>          uint64_t proc_ctx_gpu_addr;
>>>          uint64_t gang_ctx_gpu_addr;
>>>          uint64_t gds_ctx_gpu_addr;
>>> -- 
>>> 2.40.0
>>>
>
