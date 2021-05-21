Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B34C47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 15:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B539613CB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 15:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B539613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780A16E15E;
	Fri, 21 May 2021 15:19:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90F116E15E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 15:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4Ot26368KcPiEgbaV1Wladqumafw4eYgJCXaYnaOQv5q5VCP3UBJZhROJ/2R6xIWwBa6G3v5FZnNN5oHkyhMZpiXsyi7c9wMzj2sC+tXXgGdXLauTYOdA9UZXZt9hFdLW/QI32jAAZ1bclkY5AhABvdfvaozOmdayN8RpLTGy846jCjkXhkxzWymJn8uGyosJ3pZkvbyVlUc5ZQMYQC5X74+bmKjdNpb2ePygqXz0NNfFyBuO64rSPRdWUH5YJOwcJtVEpzb2KCou5D5zXoqLL3OCSVngqEdYyiCZJ8P70TB+jUPpgTp6ThB77FuFRA4lY3f6tw98earuNBEp1giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyeJOhwsQbjJ5u0SAWYQT+mixvSh8kY8bnzrpbaeE0c=;
 b=i+NL+o6mirXRPap3+Aa+ml72nu389UKh806xRw3aWUxMQpBe/AQucGuGeGmzaoz/NdATo/fqod+aUCkZ321aVKOMoxhEppqmUMouSsNCa9dh8boY+7nKrI4t1UO0GMcrQwkZaO9+z3HV7/8WIgw3srGXv+92zqkT5zsmNAfS4fX37q/Aw2n1xIUNVsZ6Ip9L8E2V0WikI/9XqyVm3AymeITZGqF0gDRUF0iDbU2jbiXZgTycscffjxreF/DCSYc5Lm7ilFBVCeMQ/4MiAacifySlsUzTTFGA0qdzd4TwiDJynxQqhBvan0+sCr7VZx8MMVGA0XTbHTz2SOoxEFlj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyeJOhwsQbjJ5u0SAWYQT+mixvSh8kY8bnzrpbaeE0c=;
 b=WdQKSzK5XJ5pUegv93rL11SDQet8ksPBDKp5s03cydfiU9HeuQTmNKwQW9XFr1uHgPeExCeSaryX/7VeFitZldna6USh3HlBHjJxjwV4qcQEt+Uf9+bApAkhcygFQwPaPV0PJV5b2dFZGQd5hi0J39C2fFIKDKUqkxWGePh+zE8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5213.namprd12.prod.outlook.com (2603:10b6:5:394::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 15:19:13 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 15:19:13 +0000
Subject: Re: [PATCH 1/7] drm/amdgpu: add amdgpu_bo_vm bo type
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.das@amd.com>
References: <20210521124533.4380-1-nirmoy.das@amd.com>
 <CADnq5_O=eQqiaGdPNjh8Juc7L3D0_kDJW+BTWAp04nQpQVVSFg@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <68c3e308-9796-51d0-d2cb-d994cb1a584b@amd.com>
Date: Fri, 21 May 2021 17:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <CADnq5_O=eQqiaGdPNjh8Juc7L3D0_kDJW+BTWAp04nQpQVVSFg@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [217.86.105.51]
X-ClientProxiedBy: AM0PR10CA0132.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::49) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.105.51) by
 AM0PR10CA0132.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 15:19:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08e45324-8622-455a-bb32-08d91c6bca97
X-MS-TrafficTypeDiagnostic: DM4PR12MB5213:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5213F9F95E5028B85256C8068B299@DM4PR12MB5213.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLnjS+IAq+7AD6J0tW700zNTckx3Q0w57RwnOg3Bcj/D+q1B9/n21IQUrlGPUAjUEWwwhc0OnuuMwBLX3VYNkf+91DJdTaOqQnaU+d1F7MmD+IKMtninJofT+N/fJA6BorMuyVMffcwN1QXkgS5bWJuEqAMJXK/7hqu5A7/2lU5ufMi+I5vkmP6eFx4POZajzNttwdAs1D82Ow2nnjiXLiAbP874LuZ6IauP2XbgsFKxTCtHbZOwQBEG4b9Uam29yIo+nFNtgwxiJodiLZfJJ2xDtfO/2FWcGoylXHGsIeHHVcnvf9WTTgJTCI3mEDeFxPnNEp5F0Drr47h0jBK06ltjwzXJT6iDqAhBnA/qijgK9psKsXirjJuHWTtkg252mUe6Gl9bjE5iqyNbJ393CeVRFZ7CqOWBM0HEmSkvwqckbpml4/Mup40Udqk+OnwFk8qD7K04VC0nkMxngUh2X3RA9+hRxUvmWWWNAMUY3Aj+XeWBEIEUnNQMNd7BrsyXiFBu8OyX/1amot9IJrPPzeRV1qiTTSocT37eCSwgFBXW319IDn949owv6dwLvOoRJqLpXxOq5h3cr8NIaoCM9OhirjT4+SIMUXT+H8wlFPSa9V0b6MQOaircxDcaVVEq2MBEZG5iLQx54YuYLI+/EfSZ3r+4vcl0FlZ9O/lwpc8mu2tvQq6zYMZR2aOPmFaC6iZyOAnYrygaKcmYHNSz/c7xKDOluXwZof7x5O0Fo/Tn4p6CFIupG6o+lmjGXWO9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(478600001)(52116002)(38350700002)(38100700002)(6666004)(45080400002)(31696002)(6486002)(956004)(966005)(53546011)(26005)(5660300002)(2616005)(66946007)(36756003)(66476007)(16526019)(31686004)(54906003)(316002)(16576012)(6636002)(66556008)(2906002)(83380400001)(4326008)(8676002)(110136005)(8936002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y3KG0BLrEayUwhKlILoKdUTHAnlFbK/2Dh5bijoyzsrlO7xj6ll5SILHYb4A/WgRwT11+H2Nva9KhVRw6brWHNvtAVqEdl1HjN8nYdFW8QuNugeFhlaVR6iMxycQNyU696RRVIEJ4jocTkpEG+cMzSc8OTJY3Zx2XE1XkDEFLDXWHGwyjBkqIoMh29Xzv/a3YWbIy6XBp4OGK4z4xNZlj+K0caGLRdTT0O+LRMUoiEPooP9SJauQLYDCWmHNuYhdVb3yLLJVgXt9w7uRW/uc+ZIrnswvNsyaTy/DgBY9LK0wECML6dW0KztYcVRkFsk/e0r+1gLp5DDLOcWskPepBFgiNEQEhYE6cbqveOg4GYkVCpTP2UTpApfIv4HOZC5cXeSwhvfc5iinj4eC7fCTCiuGKNiG2RkormO7WNRR0t3PHLl7tbtMdBH8eOdtCJqpj6tl2FMbjxJGn2E7aojwwnZ/85gLaC9Obwa9056RJI0oGsKNI96W8vznQgL62R/AheOCCH1pwZvsRTZI4AFdUpPVqcjv0GDJxsfKmAXoQmXhImZWZ9h4ngR98DA7WYNUzTXZ5I7jO8ABnUGrKedpaT6IjWMIsDujEpzOdN0Zmanhex2zOitCirN7oGMcU5yaRQ3YSrSb+rrFTmHBARSF5HOKlhs6q+VQ5fxuZg9E+fVlkjunbEGGQLPBcHKevY4wzBL0PCZSq/xJ7p0wzGzIifM4hNPTIiLPRv11/cvYQ1LfDH3tavAGI3NA/OLdKdee
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e45324-8622-455a-bb32-08d91c6bca97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 15:19:13.7278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxKUf334aLfVdeVKFgq2/5jB3lyMtlQetgG70ILe5DcbSRGkcLVLcclRy8JAqzef4IXzGXXPN3dzKioXlc7Rsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5213
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/21/21 4:54 PM, Alex Deucher wrote:
> On Fri, May 21, 2021 at 8:46 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>> Add new BO subcalss that will be used by amdgpu vm code.
> s/subcalss/subclass/


Thanks, Alex!

>
> Alex
>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 32 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 10 +++++++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 745fcf3ea450..61b1edcb490a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -692,6 +692,38 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>>          *ubo_ptr = to_amdgpu_bo_user(bo_ptr);
>>          return r;
>>   }
>> +
>> +/**
>> + * amdgpu_bo_create_vm - create an &amdgpu_bo_vm buffer object
>> + * @adev: amdgpu device object
>> + * @bp: parameters to be used for the buffer object
>> + * @vmbo_ptr: pointer to the buffer object pointer
>> + *
>> + * Create a BO to be for GPUVM.
>> + *
>> + * Returns:
>> + * 0 for success or a negative error code on failure.
>> + */
>> +
>> +int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>> +                       struct amdgpu_bo_param *bp,
>> +                       struct amdgpu_bo_vm **vmbo_ptr)
>> +{
>> +       struct amdgpu_bo *bo_ptr;
>> +       int r;
>> +
>> +       /* bo_ptr_size will be determined by the caller and it depends on
>> +        * num of amdgpu_vm_pt entries.
>> +        */
>> +       BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
>> +       r = amdgpu_bo_create(adev, bp, &bo_ptr);
>> +       if (r)
>> +               return r;
>> +
>> +       *vmbo_ptr = to_amdgpu_bo_vm(bo_ptr);
>> +       return r;
>> +}
>> +
>>   /**
>>    * amdgpu_bo_validate - validate an &amdgpu_bo buffer object
>>    * @bo: pointer to the buffer object
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> index 11480c5a2716..a7fbf5f7051e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
>> @@ -44,6 +44,7 @@
>>   #define AMDGPU_AMDKFD_CREATE_SVM_BO    (1ULL << 62)
>>
>>   #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
>> +#define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
>>
>>   struct amdgpu_bo_param {
>>          unsigned long                   size;
>> @@ -125,6 +126,12 @@ struct amdgpu_bo_user {
>>
>>   };
>>
>> +struct amdgpu_bo_vm {
>> +       struct amdgpu_bo                bo;
>> +       struct amdgpu_bo                *shadow;
>> +       struct amdgpu_vm_pt             entries[];
>> +};
>> +
>>   static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
>>   {
>>          return container_of(tbo, struct amdgpu_bo, tbo);
>> @@ -272,6 +279,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
>>   int amdgpu_bo_create_user(struct amdgpu_device *adev,
>>                            struct amdgpu_bo_param *bp,
>>                            struct amdgpu_bo_user **ubo_ptr);
>> +int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>> +                       struct amdgpu_bo_param *bp,
>> +                       struct amdgpu_bo_vm **ubo_ptr);
>>   void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
>>                             void **cpu_addr);
>>   int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>> --
>> 2.31.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cnirmoy.das%40amd.com%7C87c7640809fa40c6156808d91c68614e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637572056899554154%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=57XL2ddPiPTzp1mM7xKi6o3vHzeDHB37vOjJyxL%2FD4s%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
