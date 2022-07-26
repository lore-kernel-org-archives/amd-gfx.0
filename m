Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2387BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 00:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120A410E653;
	Tue, 26 Jul 2022 00:32:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E8E10EF59
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 00:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfzsHjyMPrzT2HwaxNPEcLqDoObZ1rz2JnmbUGkZrxx9Uo7Ow+QAT8mZNieXlBaV0z7QvuvwphKaY92nK8WB1S2q/CcogQIdRARsXOge3Qqq794WyDS9bycUFbXvrUjx/Xs2t2ZUGi1IYX243wxsu4f3Ya5ePB2c0F9Dumwn9QspqBftLXysWa+t0ledZ7kVgGbzrmoM0q9NYbItESckK3dI3FKZ+fIzKhoiz8Ug32uzPOmsSrKMG+e+jERy2ClaoIu6PKrJcPWJv1OuGSJI8scJdY8615YNLiQd3hFUbZI7sUMwmo/USeAEkYt3Be4DLlSiT03mWVcSwzb4/uKg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AE1uR6A+Pl0/S9w5fGpdPq9bymKoNfO6niKXKR80AmU=;
 b=EUvzCr8+CQrFzYpk35XOuvAcf96zK1aAhFAEWAPlq17M5hbZuASUyDXsS6vt8kl+sUcxd7bfUGs8MBUfZAchqW0OfPg0HxbAoHl5sBobBdO0x1jQ6109sJC53v6PenpPlYCqWf7HbmAWqROpSyQqlqDLctTSH2jxMTTdsSIgJsKdflhoIYL3pfvLa3liAdx+KSeVUwOnz7HwybWKVJfAwhd6zd5xMlyfQT/PLS4omd3YNmpQln75A0RAt4EKRGZGbI4NrXWcUH/Nkn7rSRkol9sQFsNonB/1CmJDxdJWPNYvE5WNvByQWEeEpsLJ9rHgVuMJFYqumYYZG7wBprxEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AE1uR6A+Pl0/S9w5fGpdPq9bymKoNfO6niKXKR80AmU=;
 b=tWD/IUBX+8dCepolW95MRHOc1Uq+eX1BleQuT61nZz5oiV1gJB0Ac1rUwT/SShudCFc2hPtSk8Php9g+EQdl7OX4T3Xcmn5A7hzaWiPKj8EOerLlqc9ZVTkY0FzGzVg2y6FYrROCzixrpbYFG3BKEkY5b4H5wlbSRwszmAKftxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3886.namprd12.prod.outlook.com (2603:10b6:208:16a::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Tue, 26 Jul
 2022 00:32:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 00:32:17 +0000
Message-ID: <9548e049-8567-7479-7939-4cd12e856153@amd.com>
Date: Mon, 25 Jul 2022 20:32:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] drm/amdkfd: refine the gfx BO based dmabuf handling
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-2-Lang.Yu@amd.com>
 <3ea7d3b9-266f-d9b1-f6d5-d998a5e6e2c9@amd.com>
 <Yt8yHSREAp6sRK+K@lang-desktop>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <Yt8yHSREAp6sRK+K@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::36) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaf708bc-25bf-4dc1-e496-08da6e9e4b02
X-MS-TrafficTypeDiagnostic: MN2PR12MB3886:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHpF6UvbfaY8fHLmM0gGaHFVHo0elflrctHGOp529f6vm9NHFlDVtnEx0V3mJ4Z6bDjUCRoiOvQ511Cfgn/hYd0IcmIhJyTbnwiL6ikYo6a85/2QvGQ5WAQ4r6/B3WmbFZmPrSxXevJIrj9FFC2kDl4qPH/jkaAtCVNewdqi77y2ssBQjbtrKyv1FxTXDOq8caTyJFDEswvreaJwlh6n44vtXSW7a1yOG/r1Z0E3CPweFsaNmXRyGijNSl1AsDxH9YXQL0krr12KLcUG4xkpnj78CC9raWdvT1GtFpP4WfWLbWQb5mIpidXvZbrw1blF7bpygfIE0ZZys0NTuvpFISmX9O6H5H1omUYFyBHN2gWPDTbk6Tu0OvJXWgcE7nCwqwSgdFKvgdaSqSUzETT/zoo7se57y7+UCn94WpzJTfK3tgrho1oNjckzQsYwH03N9Z4/qUql4gzYHMzdljfzGGQVkoYN4XpKf/O8T7HZ4AYGxNIOsWED3R8lFgX7ihXV4oeyuIb33OrXnHBZ2PNDsjDyJqg5xqkXi04+f7AIk4aVT6B01J0BTqT/oXVY9iCKJqpbGfy/RnQ8s9m9x0hJPBeYoUGN+53R71zLAVgOLtfuSWQqoBxUmIcyoejoiqHF40O2KHzPic2hDFgHkaXm+tdj0ifI9ln/uG2fj/13vGncKYhY/X7DITTfEeOEcobpUXxmhG0ocQzJQ1/qOM0GJpIZgTcpddeTA0RNvChEDvyNWBtXDkRhJUxZABeftDXwRMp1z2nbW0G1Irv25BECik5Z98YNugHta7JRaz3RA/QY2RBL0Z+6Gkbsu84lThzupYKrHrFuJL2z0CTS1DVKDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(66946007)(8676002)(37006003)(66556008)(66476007)(38100700002)(54906003)(4326008)(6636002)(6486002)(6512007)(478600001)(26005)(316002)(31696002)(41300700001)(2906002)(86362001)(6666004)(6506007)(83380400001)(8936002)(6862004)(44832011)(36756003)(2616005)(31686004)(5660300002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTd4UjlRWURscCtBSEhOSmVGRXpFeit6d2w2L242ZVpCRjZoWkQwMHdSNXlG?=
 =?utf-8?B?elNyQUVVUWJackJDZDByM2hrK3Zsd3FWaE50SlM5YWhTL3FNQWQ4aFFXUjM4?=
 =?utf-8?B?dTZjcWVXcGJRSGVaclNHYVhvZ2o4S1VsWTJVT0FrejBtcjRZUjZ2bFJwSUpO?=
 =?utf-8?B?WU9pNFI5cFVNMVhvNzJHa1c1bThxcURTSEwzd3hFUjlwV3cwd3BjMXRIeFhr?=
 =?utf-8?B?QkphNzlZSUJLRjRiNTdXUHM0V2lsZndMNWhuaGVmTUVEQmRrVU50TUJ4RXVR?=
 =?utf-8?B?YVZrc0xzSTc1UnZVTXlidHNoWGYybG96ZmJFaHg5NTFpR1dlSHcrL29sYXdy?=
 =?utf-8?B?cmxPcjlWQ1d1NXBPVzFpY1c4NkJaUFc2bUJTbDJYb3pFTFFRS2xUUS9RV21a?=
 =?utf-8?B?d0d4eGM3YmNrVEJQRWEzaGtiSFVTcVN0Rys4TFVZSzUxMUF5SEVEM0lnbTRP?=
 =?utf-8?B?a04yVUVoTkdoakVGdG1HRm0ydTdUUXhhRnlSNk9mVElpaUNuNDM5TEYyekZl?=
 =?utf-8?B?amFLWXBVU1REZ3h1RmxEaGVzWVg0SWpiekM1YitaTzNBMndIcWRTb0p4TTFG?=
 =?utf-8?B?VGY2V0JpTlAxa2NKK2dyZXVGai9BMjhxWlZaTnRsYmlRc3RVM014M29oa0hw?=
 =?utf-8?B?VFpCeTRZQWk3WGZSenNPU0prOTBVdFBxeS9tUUNiWmhlUUgxWWFqdU9qRitL?=
 =?utf-8?B?eGlGT05MSXl1djVkTWNBSUFoL2hZb3BOeXlwdWxQZkRyaUlTalJESmlPc29R?=
 =?utf-8?B?dUNqZUNvZnFHQ2dod0QvVUNzc2ZLTWlOTFhwU0pXVUt5OFFCcW5PaWRlTDRi?=
 =?utf-8?B?V2tBZk5zNXExK0I1ZmZxNEc4UzNzQ3dtOWxXUFF2cnZTaHNhdGtLNTVQMnE5?=
 =?utf-8?B?Q0Y5alVlSzlPU010NExMYVlPeEpWU1dHVXBjOWQzVGxHRHZkSTJLWFQwNHl2?=
 =?utf-8?B?b3hDT2plVjhkV01KZGJiUURPQW1seXFZb3B4c01NL3FYbUhnODdleDhzSHU4?=
 =?utf-8?B?OWhlazRjK3pxSTdyMW1iZnNSWktwaFA5OURmbWhmUE44QitvNmlPcXBiRVQ3?=
 =?utf-8?B?SlcxTzd6YXBlWUNXQllzMGlBQkVGSzRuZzVIYlJNVVNMN3NOK2dXYVRFUlFr?=
 =?utf-8?B?ODRKNFNlYnBEbnY3TnFTa0UybU8wa1VtNUp3SHhWMEFIbXZEcTZNZXNoTHQw?=
 =?utf-8?B?TVdIeGhjSUZheE9YTU1vUTNIcnF6VmU2enVkcjY3REhaRUwyNWlLMUs3NENa?=
 =?utf-8?B?YmNubHZBb1c4OTBDWHdOSmhqTXhQWU9SckRpaldNUlF4U055dU82ZEpJUENJ?=
 =?utf-8?B?YVBLMUR2bFdkcEJ2di9Ic2lUUEVrVmRLNi9QVit5eVVzallsdTkrS1Fha05P?=
 =?utf-8?B?dnA0VkZFNFNzc0QwQWJpVnFLY3JscTV3RVRvZG5kUVU4NXZwRXZpSlBsZzdO?=
 =?utf-8?B?TzltS2ZaNjZyQ2dRSktBV0JWcEtYNS9Kc0FySjdub1FRUktRVi9ncmx3Q09W?=
 =?utf-8?B?Nk5uQ2o4NHZ2OXRzWnZGVGcxSE1maWVCak9uM1hQNVR5bHQwRTFwbUpSOGVh?=
 =?utf-8?B?VGtXeU1YbUQ3aVZVR1FOYjM0dktHZkluWnNDTzBXNFIvZUZPSVAvY1dRTWJV?=
 =?utf-8?B?TXkxR0lkSzJFc1BjQ1pHWUh1djZ4cGlJWDJFZDB3akI0akpscjExSDhRZUha?=
 =?utf-8?B?aDFjNDB3WXBLdGhXQ0lkcy9maWdIZUpkeksrOE1qa054bHZPSjFSWEplTTBQ?=
 =?utf-8?B?dlZIak5sM0c1Rjl1OGs2NlBSTDJaNFRFeklRWkZyemk2TnNjTE8zUkRWbCtI?=
 =?utf-8?B?S3dnUlBlRVVIaW9CWDhQZHRCbWRIb1dsSVFIc0cwY0UwUmVtMkUzWnk0YzZx?=
 =?utf-8?B?ZW5RU3FqVkhRb2FxTFRuR1NtSDV1REQwZ3FnQ1RIU1FsWlRMWmlKZjNNdXRy?=
 =?utf-8?B?Y2VRR1RmSnh3Qkpzb3paTXJSZWZkZk8ybFkvSG5yNkJWTUJBemVveStFMDdo?=
 =?utf-8?B?UmF1anRUdStCWWFJMXBaeHlETG5yZHRiVlAwdG05S1REcXBYSWphRVF5ODQz?=
 =?utf-8?B?MXYrblhjQmp0Z1FRUnkrZ0hHYUdvN1RLUS83eDBvK1RqQWQ3Wk5FaDl6Qitn?=
 =?utf-8?Q?PSl9ixRfhmjwLT7y9dTGF4kxc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf708bc-25bf-4dc1-e496-08da6e9e4b02
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2022 00:32:17.0433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNGKiWhEkG7U4FSl8rUTCnFORiUdQqzLwEHfXZ9eNL7ovqzxSYARPenAO+ixM3Nw/qcetboKmTdVC2Lf7q0Qhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3886
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-07-25 um 20:15 schrieb Lang Yu:
> On 07/25/ , Felix Kuehling wrote:
>> Am 2022-07-25 um 06:32 schrieb Lang Yu:
>>> We have memory leak issue in current implenmention, i.e.,
>>> the allocated struct kgd_mem memory is not handled properly.
>>>
>>> The idea is always creating a buffer object when importing
>>> a gfx BO based dmabuf.
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 99 +++++++++++++------
>>>    1 file changed, 70 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index b3806ebe5ef7..c1855b72a3f0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -225,7 +225,8 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
>>>    	u32 alloc_flags = bo->kfd_bo->alloc_flags;
>>>    	u64 size = amdgpu_bo_size(bo);
>>> -	unreserve_mem_limit(adev, size, alloc_flags);
>>> +	if (!bo->kfd_bo->is_imported)
>>> +		unreserve_mem_limit(adev, size, alloc_flags);
>>>    	kfree(bo->kfd_bo);
>>>    }
>>> @@ -784,6 +785,24 @@ kfd_mem_dmaunmap_attachment(struct kgd_mem *mem,
>>>    	}
>>>    }
>>> +static struct drm_gem_object*
>>> +amdgpu_amdkfd_import(struct drm_device *dev, struct dma_buf *dma_buf)
>>> +{
>>> +	struct drm_gem_object *gobj;
>>> +	struct amdgpu_bo *abo;
>>> +
>>> +	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
>> I'd rather remove this limitation. We should be able to use any DMABuf with
>> KFD. This check was added when we basically sidestepped all the dmabuf
>> attachment code and just extracted the amdgpu_bo ourselves. I don't think we
>> want to keep doing that.
> This limitation here is to just reference the gobj if it is an amdgpu bo
> and from same device instead of creating a gobj when importing a dmabuf.
>
>> Please see my patch "[PATCH v2 1/2] drm/amdgpu: Generalize KFD dmabuf
>> import" sent to amd-gfx on March 16. I'm about to send an updated version of
>> this as part of upstream RDMA support soon.
> The "drm/amdgpu: Generalize KFD dmabuf import" doesn't handle the struct kgd_mem
> memory leak issue. Looking forward to the updated version. Thanks!

Maybe we're trying to fix different problems. Can you give a more 
detailed explanation of the memory leak you're seeing? It's not obvious 
to me.

The problem I'm trying to solve is, to ensure that each exported BO only 
has a single dmabuf because we run into problems with GEM if we have 
multiple dmabufs pointing to the same GEM object. That also enables 
re-exporting dmabufs of imported BOs. At the same time I'm removing any 
limitations of the types of BOs we can import, and trying to eliminate 
any custom dmabuf handling in KFD.

Regards,
   Felix


>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>> +		gobj = dma_buf->priv;
>>> +		abo = gem_to_amdgpu_bo(gobj);
>>> +		if (gobj->dev == dev && abo->kfd_bo) {
>>> +			drm_gem_object_get(gobj);
>>> +			return gobj;
>>> +		}
>>> +	}
>>> +
>>> +	return amdgpu_dma_buf_create_obj_and_attach(dev, dma_buf);
>>> +}
>>> +
>>>    static int
>>>    kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>>    		      struct amdgpu_bo **bo)
>>> @@ -802,7 +821,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>>>    		}
>>>    	}
>>> -	gobj = amdgpu_gem_prime_import(adev_to_drm(adev), mem->dmabuf);
>>> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), mem->dmabuf);
>>>    	if (IS_ERR(gobj))
>>>    		return PTR_ERR(gobj);
>>> @@ -1805,12 +1824,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>    {
>>>    	struct amdkfd_process_info *process_info = mem->process_info;
>>>    	unsigned long bo_size = mem->bo->tbo.base.size;
>>> +	bool is_imported = false;
>>> +	struct drm_gem_object *imported_gobj;
>>>    	struct kfd_mem_attachment *entry, *tmp;
>>>    	struct bo_vm_reservation_context ctx;
>>>    	struct ttm_validate_buffer *bo_list_entry;
>>>    	unsigned int mapped_to_gpu_memory;
>>>    	int ret;
>>> -	bool is_imported = false;
>>>    	mutex_lock(&mem->lock);
>>> @@ -1885,7 +1905,13 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>>>    	}
>>>    	/* Free the BO*/
>>> -	drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>>> +	if (!is_imported) {
>>> +		drm_vma_node_revoke(&mem->bo->tbo.base.vma_node, drm_priv);
>>> +	} else {
>>> +		imported_gobj = mem->dmabuf->priv;
>>> +		drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
>>> +	}
>>> +
>>>    	if (mem->dmabuf)
>>>    		dma_buf_put(mem->dmabuf);
>>>    	mutex_destroy(&mem->lock);
>>> @@ -2249,62 +2275,77 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>>>    				      uint64_t *mmap_offset)
>>>    {
>>>    	struct amdgpu_vm *avm = drm_priv_to_vm(drm_priv);
>>> -	struct drm_gem_object *obj;
>>> -	struct amdgpu_bo *bo;
>>> +	struct drm_gem_object *imported_gobj, *gobj;
>>> +	struct amdgpu_bo *imported_bo, *bo;
>>>    	int ret;
>>> -	if (dma_buf->ops != &amdgpu_dmabuf_ops)
>>> -		/* Can't handle non-graphics buffers */
>>> +	/*
>>> +	 * Can't handle non-graphics buffers and
>>> +	 * buffers from other devices
>>> +	 */
>>> +	imported_gobj = dma_buf->priv;
>>> +	if (dma_buf->ops != &amdgpu_dmabuf_ops ||
>>> +	    drm_to_adev(imported_gobj->dev) != adev)
>>>    		return -EINVAL;
>>> -	obj = dma_buf->priv;
>>> -	if (drm_to_adev(obj->dev) != adev)
>>> -		/* Can't handle buffers from other devices */
>>> +	/* Only VRAM and GTT BOs are supported */
>>> +	imported_bo = gem_to_amdgpu_bo(imported_gobj);
>>> +	if (!(imported_bo->preferred_domains &
>>> +	    (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)))
>>>    		return -EINVAL;
>>> -	bo = gem_to_amdgpu_bo(obj);
>>> -	if (!(bo->preferred_domains & (AMDGPU_GEM_DOMAIN_VRAM |
>>> -				    AMDGPU_GEM_DOMAIN_GTT)))
>>> -		/* Only VRAM and GTT BOs are supported */
>>> -		return -EINVAL;
>>> +	ret = drm_vma_node_allow(&imported_gobj->vma_node, drm_priv);
>>> +	if (ret)
>>> +		return ret;
>>> -	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>> -	if (!*mem)
>>> -		return -ENOMEM;
>>> +	gobj = amdgpu_amdkfd_import(adev_to_drm(adev), dma_buf);
>>> +	if (IS_ERR(gobj)) {
>>> +		ret = PTR_ERR(gobj);
>>> +		goto err_import;
>>> +	}
>>> -	ret = drm_vma_node_allow(&obj->vma_node, drm_priv);
>>> -	if (ret) {
>>> -		kfree(mem);
>>> -		return ret;
>>> +	bo = gem_to_amdgpu_bo(gobj);
>>> +	bo->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
>>> +
>>> +	*mem = kzalloc(sizeof(struct kgd_mem), GFP_KERNEL);
>>> +	if (!*mem) {
>>> +		ret = -ENOMEM;
>>> +		goto err_alloc_mem;
>>>    	}
>>>    	if (size)
>>> -		*size = amdgpu_bo_size(bo);
>>> +		*size = amdgpu_bo_size(imported_bo);
>>>    	if (mmap_offset)
>>> -		*mmap_offset = amdgpu_bo_mmap_offset(bo);
>>> +		*mmap_offset = amdgpu_bo_mmap_offset(imported_bo);
>>>    	INIT_LIST_HEAD(&(*mem)->attachments);
>>>    	mutex_init(&(*mem)->lock);
>>>    	(*mem)->alloc_flags =
>>> -		((bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>> +		((imported_bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>>    		KFD_IOC_ALLOC_MEM_FLAGS_VRAM : KFD_IOC_ALLOC_MEM_FLAGS_GTT)
>>>    		| KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE
>>>    		| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
>>> -	drm_gem_object_get(&bo->tbo.base);
>>> +	get_dma_buf(dma_buf);
>>> +	(*mem)->dmabuf = dma_buf;
>>>    	(*mem)->bo = bo;
>>>    	(*mem)->va = va;
>>> -	(*mem)->domain = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
>>> -		AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT;
>>> +	(*mem)->domain = AMDGPU_GEM_DOMAIN_GTT;
>>>    	(*mem)->mapped_to_gpu_memory = 0;
>>>    	(*mem)->process_info = avm->process_info;
>>>    	add_kgd_mem_to_kfd_bo_list(*mem, avm->process_info, false);
>>>    	amdgpu_sync_create(&(*mem)->sync);
>>>    	(*mem)->is_imported = true;
>>> +	bo->kfd_bo = *mem;
>>>    	return 0;
>>> +err_import:
>>> +	drm_vma_node_revoke(&imported_gobj->vma_node, drm_priv);
>>> +err_alloc_mem:
>>> +	drm_gem_object_put(gobj);
>>> +	return ret;
>>>    }
>>>    /* Evict a userptr BO by stopping the queues if necessary
