From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add the checking to avoid NULL pointer
 dereference
Date: Tue, 27 Nov 2018 10:40:28 +0800
Message-ID: <174e311d-3214-1e70-c5d4-8b955b926a58@amd.com>
References: <20181122065523.5510-1-Deepak.Sharma@amd.com>
 <b8284caa-3f1d-5672-6317-36be83907e9d@gmail.com>
 <9350d13a-e745-f284-1c49-785fe523773d@amd.com>
 <eae25687-23ce-d686-f5f0-deeb7c3d2e1c@amd.com>
 <70a32625-7568-6253-6c5e-a72fe38f7986@amd.com>
 <138bad33-c604-c0c5-98cb-1ce71a432185@amd.com>
 <46007826-1a4a-40eb-5ee8-af2d0c93e04a@amd.com>
 <BY2PR12MB0694DBE621FC3BBC269E7D51E9D70@BY2PR12MB0694.namprd12.prod.outlook.com>
 <38725288-c15f-58be-7d1a-422abe503a04@gmail.com>
 <BY1PR12MB0502AC0F928B517E35C58751B4D70@BY1PR12MB0502.namprd12.prod.outlook.com>
 <9619e159-d47b-2078-974d-0d3b418f6d88@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1A7B2CB33F6CB8EDB07561A5"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <9619e159-d47b-2078-974d-0d3b418f6d88-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--------------1A7B2CB33F6CB8EDB07561A5
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Yeah, you need another drm patch as well when you apply my patch. Attached.

-David


On 2018年11月27日 08:40, Sharma, Deepak wrote:
>
> On 11/26/18 1:57 AM, Zhou, David(ChunMing) wrote:
>>
>>> -----Original Message-----
>>> From: Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Sent: Monday, November 26, 2018 5:23 PM
>>> To: Sharma, Deepak <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>; Zhou, David(ChunMing)
>>> <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>;
>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>> Subject: Re: [PATCH] drm/amdgpu: add the checking to avoid NULL pointer
>>> dereference
>>>
>>> Am 26.11.18 um 02:59 schrieb Sharma, Deepak:
>>>> 在 2018/11/24 2:10, Koenig, Christian 写道:
>>>>> Am 23.11.18 um 15:10 schrieb Zhou, David(ChunMing):
>>>>>> 在 2018/11/23 21:30, Koenig, Christian 写道:
>>>>>>> Am 23.11.18 um 14:27 schrieb Zhou, David(ChunMing):
>>>>>>>> 在 2018/11/22 19:25, Christian König 写道:
>>>>>>>>> Am 22.11.18 um 07:56 schrieb Sharma, Deepak:
>>>>>>>>>> when returned fence is not valid mostly due to userspace ignored
>>>>>>>>>> previous error causes NULL pointer dereference.
>>>>>>>>> Again, this is clearly incorrect. The my other mails on the
>>>>>>>>> earlier patch.
>>>>>>>> Sorry for I didn't get your history, but looks from the patch
>>>>>>>> itself, it is still a valid patch, isn't it?
>>>>>>> No, the semantic of amdgpu_ctx_get_fence() is that we return NULL
>>>>>>> when the fence is already signaled.
>>>>>>>
>>>>>>> So this patch could totally break userspace because it changes the
>>>>>>> behavior when we try to sync to an already signaled fence.
>>>>>> Ah, I got your meaning, how about attached patch?
>>>>> Yeah something like this, but I would just give the
>>>>> DRM_SYNCOBJ_CREATE_SIGNALED instead.
>>>>>
>>>>> I mean that's what this flag is good for isn't it?
>>>> Yeah, I give a flag initally when creating patch, but as you know, there is a
>>> swich case not be able to use that flag:
>>>>         case AMDGPU_FENCE_TO_HANDLE_GET_SYNC_FILE_FD:
>>>>             fd = get_unused_fd_flags(O_CLOEXEC);
>>>>             if (fd < 0) {
>>>>                 dma_fence_put(fence);
>>>>                 return fd;
>>>>             }
>>>>
>>>>             sync_file = sync_file_create(fence);
>>>>             dma_fence_put(fence);
>>>>             if (!sync_file) {
>>>>                 put_unused_fd(fd);
>>>>                 return -ENOMEM;
>>>>             }
>>>>
>>>>             fd_install(fd, sync_file->file);
>>>>             info->out.handle = fd;
>>>>             return 0;
>>>>
>>>> So I change to stub fence instead.
>>> Yeah, I've missed that case. Not sure if the sync_file can deal with a NULL
>>> fence.
>>>
>>> We should then probably move the stub fence function into
>>> dma_fence_stub.c under drivers/dma-buf to keep the stuff together.
>> Yes, you wrap it to review first with your stub fence, we can do it separately first.
>>
>> -David
>>>> -David
>>>>
>>>> I have not applied this patch.
>>>> The issue was trying to address is when amdgpu_cs_ioctl() failed due to
>>> low memory (ENOMEM) but userspace chose to proceed and called
>>> amdgpu_cs_fence_to_handle_ioctl().
>>>> In amdgpu_cs_fence_to_handle_ioctl(), fence is null and later causing
>>>> NULL pointer dereference, this patch was to avoid that and system panic
>>> But I understand now that its a valid case retuning NULL if fence was already
>>> signaled but need to handle case so avoid kernel panic. Seems David patch
>>> should fix this, I will test it tomorrow.
>>>
>>> Mhm, but don't we bail out with an error if we ask for a failed command
>>> submission? If not that sounds like a bug as well.
>>>
>>> Christian.
>>>
> Where do we do that?
> I see error
> [drm:amdgpu_cs_ioctl] *ERROR* amdgpu_cs_list_validate(validated) failed.
> [drm:amdgpu_cs_ioctl] *ERROR* Not enough memory for command submission!
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> Did some more debugging,dma_fence_is_array() is causing NULL pointer
> dereference call through sync_file_ioctl.
>
> Also I think changes in David patch cant be applied on
> amd-staging-drm-next, which all patches I should take to get it correctly?
>
>>>> -Deepak
>>>>> Christian.
>>>>>
>>>>>> -David
>>>>>>> If that patch was applied then please revert it immediately.
>>>>>>>
>>>>>>> Christian.
>>>>>>>
>>>>>>>> -David
>>>>>>>>> If you have already pushed the patch then please revert.
>>>>>>>>>
>>>>>>>>> Christian.
>>>>>>>>>
>>>>>>>>>> Signed-off-by: Deepak Sharma <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
>>>>>>>>>> ---
>>>>>>>>>>          drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 ++
>>>>>>>>>>          1 file changed, 2 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>>>>>>> index 024dfbd87f11..14166cd8a12f 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>>>>>>>>> @@ -1403,6 +1403,8 @@ static struct dma_fence
>>>>>>>>>> *amdgpu_cs_get_fence(struct amdgpu_device *adev,
>>>>>>>>>>                fence = amdgpu_ctx_get_fence(ctx, entity, user->seq_no);
>>>>>>>>>>              amdgpu_ctx_put(ctx);
>>>>>>>>>> +    if(!fence)
>>>>>>>>>> +        return ERR_PTR(-EINVAL);
>>>>>>>>>>                return fence;
>>>>>>>>>>          }
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------1A7B2CB33F6CB8EDB07561A5
Content-Type: text/x-patch;
	name="drm_syncobj: use only a single stub fence.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="drm_syncobj: use only a single stub fence.patch"

Received: from SN1PR12MB0509.namprd12.prod.outlook.com (2603:10b6:a02:a8::31)
 by BY1PR12MB0502.namprd12.prod.outlook.com with HTTPS via
 BYAPR03CA0018.NAMPRD03.PROD.OUTLOOK.COM; Thu, 15 Nov 2018 11:12:57 +0000
Received: from MWHPR12CA0057.namprd12.prod.outlook.com (2603:10b6:300:103::19)
 by SN1PR12MB0509.namprd12.prod.outlook.com (2a01:111:e400:5866::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.30; Thu, 15 Nov
 2018 11:12:55 +0000
Received: from BY2NAM03FT050.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::207) by MWHPR12CA0057.outlook.office365.com
 (2603:10b6:300:103::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.26 via Frontend
 Transport; Thu, 15 Nov 2018 11:12:55 +0000
Authentication-Results: spf=pass (sender IP is 209.85.128.65)
 smtp.mailfrom=gmail.com; amd.com; dkim=pass (signature was verified)
 header.d=gmail.com;amd.com; dmarc=pass action=none
 header.from=gmail.com;compauth=pass reason=100
Received-SPF: Pass (protection.outlook.com: domain of gmail.com designates
 209.85.128.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=209.85.128.65; helo=mail-wm1-f65.google.com;
Received: from mail-wm1-f65.google.com (209.85.128.65) by
 BY2NAM03FT050.mail.protection.outlook.com (10.152.85.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1339.10 via Frontend Transport; Thu, 15 Nov 2018 11:12:54 +0000
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so18383279wmb.2
        for <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; Thu, 15 Nov 2018 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZ6p6tJtd2xYUOdw9+8vYF7sv90wvnT6I3AGPXZMrqU=;
        b=A6PG5sRgKxj6Gmja+v6mmeraXrBO4FtkWgIw9EIO7Ha9AWGj6pLKPY9cH+CdQT/sV2
         ayhpxgtaoQsIDOuy+DeFTVusKjxUG5/DzYV/Sw4EfAJF2/4Ere/65s3P325pcx06m1Iq
         HASqSFxh6ZzfOfWC/0SUW0bbk01hytKj2MawFuJAy0Khk3UC+HNy1xbOmCxIrdWex5GM
         dxHmBIQHllde1+HKso4UFL/5nHQ8JgycwYuOX/FnAHm6kUGorAw96Y9CPHnZnpIcngHe
         JqDuE0dCbpF74fbolQFOlWtAayXhgYiUbuvjadyHzV6mkhbQTo9T8k743dIxdiKsgg2+
         OcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZ6p6tJtd2xYUOdw9+8vYF7sv90wvnT6I3AGPXZMrqU=;
        b=YkWxM644RKHsJHMUjEk1Cm85+T3r1PVeDjkbkziWSW9EmhYWP6vPEI2n8Rrg9Ae6pA
         2CGhTFfPEgeccrbRvGzO5FjTUWGILzCWVXOYOIZWasW4FAQBzAfjKsBtbzKlREaATgJ0
         hUHDocGPmJ0ug218dU46E3zAp9/zXcUP3NoxRZEnWmK/rG5h09IM0UQmiJTwW3V55tN2
         h9Tdw9+8DJCHY6Msrui2L3Wkh4/FWGz6+hZqahj5AvBhS6ulGmbW0z+eZm3pw10LL0si
         ulhu/tSgxZr8rpayMn74JRI+heJC2pPt0N3gO876YGvAziLY1QoCQgwCVRNHVrKXEroY
         Zwqw==
X-Gm-Message-State: AGRZ1gIs95+B9ZioOciQ/d8+4w/mpAf9p+TmRjU1W3P38ii5Vkmy4FP3
	JgBjvopgwu5stBPZdXaOThI=
X-Google-Smtp-Source: AJdET5cZxnF54rSC+TGsbDDyNh3dr69d/7VsdUw6jIC2SreyzuuIzf7VQTtx7Gr57NJXmrE8TktYWQ==
X-Received: by 2002:a1c:13d2:: with SMTP id 201-v6mr4734749wmt.58.1542280373550;
        Thu, 15 Nov 2018 03:12:53 -0800 (PST)
Return-Path: ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Received: from baker.fritz.box ([2a02:908:1257:4460:683c:8090:4142:4ae3])
        by smtp.gmail.com with ESMTPSA id s66sm4935428wmf.34.2018.11.15.03.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 03:12:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org,
	daniel.vetter-/w4YWyX8dFk@public.gmane.org,
	eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org,
	David1.Zhou-5C7GfCeVMHo@public.gmane.org
Subject: [PATCH 4/7] drm/syncobj: use only a single stub fence
Date: Thu, 15 Nov 2018 12:12:42 +0100
Message-Id: <20181115111245.30161-5-christian.koenig-5C7GfCeVMHo@public.gmane.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181115111245.30161-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
References: <20181115111245.30161-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-ExpirationStartTime: 15 Nov 2018 11:12:54.8996
 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 2:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id:
 87af999b-85f7-443c-c4ee-08d64aeb4a9b
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: 3dd8961f-e488-4e60-8e11-a82d994e183d:0
X-MS-Exchange-Organization-MessageDirectionality: Incoming
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report:
 CIP:209.85.128.65;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(8156002)(2980300002)(438002)(189003)(199004)(336012)(66574009)(6666004)(356004)(73392003)(83322999)(50226002)(1096003)(5660300001)(26005)(82202002)(59536001)(2870700001)(76482006)(1076002)(73972006)(2351001)(14444005)(4326008)(2361001)(95326003)(53416004)(106466001)(87572001)(60616004)(5820100001)(93516011)(76176011)(33896004)(47776003)(2160300002)(305945005)(7636002)(34206002)(23676004)(60626007)(34756004)(7596002)(86362001)(8676002)(106002)(246002)(50466002)(446003)(476003)(486006)(9686003)(426003)(126002)(36756003)(11346002)(16003);DIR:INB;SFP:;SCL:1;SRVR:SN1PR12MB0509;H:mail-wm1-f65.google.com;FPR:;SPF:Pass;LANG:en;PTR:mail-wm1-f65.google.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics:
 1;BY2NAM03FT050;1:1+TcSGNn67EepEIovtFbsVyy8YXJK2BaVZFlDwszS8R0ny8sv2gS8x97QUs+QmOQqh+2xU4DT2Kk1kzyvRd1YMME7PefuVMURpSuAeK1J19jF+BSoMdQ8yD0yqUnB3i/
X-MS-Exchange-Organization-AuthSource:
 BY2NAM03FT050.eop-NAM03.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87af999b-85f7-443c-c4ee-08d64aeb4a9b
X-Microsoft-Antispam:
 BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(5600074)(711020)(4605076)(4608076)(4614076)(1401272)(8001031)(1421009)(1402068)(71702078);SRVR:SN1PR12MB0509;
X-Microsoft-Exchange-Diagnostics:
 1;SN1PR12MB0509;3:xqFPVoPjIcuuAzsNe/O2gvPfGGIwAGboqqAVDOaNt2ufWwYzK4a2IC+gJqL8a/zgn+uWWC0BCqN3woltt08f3mgZ5C6yTzU0STbRNyDAQN7Cfg00KGzrPd3B2SLEpDlOeuHQ1jmVyntAkpoB+SA0jPqQVhYp9nfH3SNEe/5Rg8yiQEMYvt/JLfInTVlidlTWSEumM4H8o2UoPlZzQ5j6todxk2JvRtRDY3hP9XeLiU9hbKtMAVXWdmad89LQAJ/q+IlTUhhoblZM3W2BWH6Pd5sP54JySFAZRjWaMEjgkAfuiJ1Qfnwl3VjcyBmkNjRkDUDwJaIGeHcRLTLCissR45NipnXi98ZZ5idzLKUcGFc=;25:Hx1IYCh1SyP7ya5cNi/773pp+8dO3hl5nMUq6/AwefXCBVJV463RQA5B/vUzhYsV22anpXHLGE6F04Vk+EwBVJTpKB3yNxXcvrvpL4DgyGz1JYaYg9/xcTGZ0IbD1m6qtAbG6Whpf8mNb5+gqMoPmNa+uyPzOeub27vNd2G3h6IRs5nNLFmpClIX89TvIyWtIJAb5FncMOlzN7o3RMbk0Jzd+7vupevEEPb45QtXM7eQUK0TSqL6fHxXMGHZJ3QBfIJVvUHMyEf6Cva13D6kzymQTfxuVforKZlitYojlr8qB6EBtSuO8yAt2nYXFzE5dPDg5UT0SNrWq200rVs6oCaBG6QaJL00rHB/zP5/02g=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0509:
X-Microsoft-Exchange-Diagnostics:
 1;SN1PR12MB0509;31:9Vubw+JCtk/3yApdzJWHAC9mymdwNDbs1weUChZkNhRcx3K0XELy7/tbles71vMfOnlBGmqtMTZfALcK0NSqP3FIe1GO4SrxA/+DQZeeRAeMibzTrChV2612nXUa8DW/XoLzcuUb48CU1vynQyLcAZnj98h+mDCmjOMHLE6SWdkMoKPUWriFjAaUB+xM6K2WAtGq7lFpopGnnMvzBFc2dsBXz6LHDdEqUnrpmD5BLBY=;20:EiDTlzXvyXeDlc9VWHiWArvyzsCQJ+uCSa/acbYMKJOWhWyKzynw30VP2Ry59Lzo7/UjGT3xc9FXiDDojmatYZXnwzw5QRp3OtUFjIzaQjg9uMdZLIo1nvfy502PxUt473HFcQskXgGqDcDFIFXoYScpZ9q8miEGFC208y5IuianQyINEbOD1TTRN+rfuwzQb4Aldh/lrALfG3DceDADasgtxC7yT+ebWJfSGSX0thtI5v8wAm/Ldx8oI6YOn5QlZowBd9FAUd9jmTh2uiRVQOqGOSJSUmBfwiCCP3MaZiCVv8mtgccPwYslFi+ShSrwcjutDpgGZKx5raOcO0VciKzNVfiSufHYBzdFno2buSb6X0BUxMZ4pBzXrFcYz71O6c+qOyFKTYVJzSr3kApWhuIBhNvySnLFStbvlNB1uJP/8nLQ0GeChRI5quTGjN+svYUkK/GXDrjeBlg89LnksHkFoQHiBHuwZuRSk2tKggw+UYnych4hvdiR5NL99rW0
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test:
 BCL:0;PCL:0;RULEID:(8211001083)(2018062399030)(2018011200283)(2401047)(8121501046)(52410047)(2018011210174)(2018011211064)(2018011212028)(2018011213028)(2018011214028)(2018011215028)(2018011216028)(2018011217028)(2018011218028)(2018011219092)(2018011220252)(2018011221063)(2018011222027)(2018011223027)(2018011224027)(2018011225035)(2018011229035)(2018011232269)(2018011233052)(2018021202149)(98810176)(2018021203149)(98815176)(823300264)(823350442)(823411253)(9101536074)(10201501046)(3002001)(3231415)(901025)(902075)(913088)(7045084)(9312024)(9311024)(944501410)(9300000249)(9301004277)(52103095)(52102170)(52105112)(52106170)(52408095)(98821027)(98822027)(52401380)(52601095)(52505095)(52406095)(52305095)(52206095)(88860335)(1102011)(93006095)(93005095)(1610001)(8301001075)(8301003183)(148016)
 (201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0509;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0509;
X-Microsoft-Exchange-Diagnostics:
 1;SN1PR12MB0509;4:YdmWqLu05obWz6hGdCH/kNkxGHtt/ZzZQLFIL6VMeEE58iwgbSs9UMoN52amRpXam+wyEznGajuKBspp5K/EiWTHtLIDd9h3EEP0wSELw30QNdBPdtvgIjVl58OxFkrpUdVa57F6Bu31HDLZPis+fr1g1NVGmtSC/tLrNmZPMjDYExd894RucTOEdNpjEhGqwqs16ELXt9jxXiu06h+drbshanLg6wuz58E+IktHu4QqsYEENRdJOxRBBMuVhK0j4VNDfYzEEwjG0+3DHU+zTsjsdGyRe7CNasWvHb7zY6zOE4lbl0g6I5THpBS8WGBX
X-MS-Exchange-Organization-SCL: 1
X-Microsoft-Exchange-Diagnostics:
 =?utf-8?B?MTtTTjFQUjEyTUIwNTA5OzIzOjh5a29va2tBL2JJREhObjdTbm1wWExMYTZQ?=
 =?utf-8?B?VVJNU1hMQzh0bS9uSzhvOXFDdDY3d1AvYmVEdVVWQkZkVVBEUkZiZ21rdkpV?=
 =?utf-8?B?T3VlSkErWlZYbmxSbThKTHpuY2l5T2RZQkh4KzJKK29iYXhHeVYwMEo1U2VM?=
 =?utf-8?B?V2g5VmhFRlRZN05UbGZpQWpPQXdGZnQ4Q0JmOFZoWmhOWkV2R3I0dW5vS2h3?=
 =?utf-8?B?ckJhdTIxUHdMOWF3UmRObEd0MXM4N2dWeGE1Tkg4R3lENGZnSHJ4bHJjdnR4?=
 =?utf-8?B?eThVeWlES2FNWnhSZjlpYlpWUGNuNkxsV0FxZjFWQ0dsNDZySWw0ZkQvWmh4?=
 =?utf-8?B?TTFnZXNUNmM0d2FUZkdXL2J3R21BOThndXgzaDFUVk1VOS9KNGRFdCtmbDVk?=
 =?utf-8?B?UmY4YUhINjJRNFdUODE5Lzk0cm9zRE5ZbkNmK0d4ekptNWJ6U25RT0ZxeEVW?=
 =?utf-8?B?eGt1MDBrY3A5bzB2VDNSeXVWMHNoLzRKZ2lYTE1WZUh4NXQzeDZQN0lLLzNI?=
 =?utf-8?B?ejdibTVPTStFSk14akxwVTM1aEgxZ3kvQVNSQnVWVjlmTjVLTGdaZnZOYUgz?=
 =?utf-8?B?aFQ2MTZpV2p5QjV1L1V4TGVDTGNURU5XVWtTZGcyQ3VubHdHWnVEcHJCWTh3?=
 =?utf-8?B?N2xjNSsyckhkM0JNZkFrN2RDTW8wQS8yQ1FIZklWdittRmtSMVdwY0Zvbm1P?=
 =?utf-8?B?dy9xd3FFSWRBcHdUSVhyUFVPZTVBNXBLVHNkSHNERUVtOE9QV3dXK0kzUzBq?=
 =?utf-8?B?ZFFBZTczMlBTbytZa2hHMFpSOE5JRjFZVVlST0pISFI2QkdoQ1IrN3lENit6?=
 =?utf-8?B?dncrbGd0Y3dTMVZ2K0dWaTdqNDR4SVpvK2R5MzVFRDFYdk5meTBXemhhZk10?=
 =?utf-8?B?ZmladDF0cjhVSzNQYWpGN083K2ZRc3JEZU5wU1VrZGsxUExjeDN4UnA0ZVVE?=
 =?utf-8?B?dXF4dVlFMFlxcEtKQ2RuWDVkN01ubmlIM3VrVTd0Y2xWcHNIUmxZM1dHMUl6?=
 =?utf-8?B?TXJJRktKZVJ4ZjlveEFsbDc4OHA0Wk9DdC9UR3VXMkpuT0JmZS9IY3RiMzUy?=
 =?utf-8?B?aWRIVXRkS2JEQUpsaXBmVFlwUEo1SEh2SEo0V3d2OUk0Sks5c1hEcHU4a2Fw?=
 =?utf-8?B?MHBEb3htTmNhYW9MeExBdlk0NmZnYXJOc1JTRmVBMGp0RjkySHpwVmxwQ3Fx?=
 =?utf-8?B?VmszTjNNWVZrNkdoTi8rLzFWb2dUVmE3U25nTnJmNk52aHhHbE1GYkpKMCtm?=
 =?utf-8?B?TytkVFhnYzQzT2hMWTNXcERCcVg0Y0RBanZCU2pPeVFxSEw1RmdtT0c3ZklL?=
 =?utf-8?B?VkM4TVZucUtuM2k0MmxYNy80YU1VNS9mSGdkdzBHclNsTlNCQ2k2Zmh5NGti?=
 =?utf-8?B?dW5DRDRCa2VkVDhYTUdXRWFSUS9QTmVjSUNoWTFYTHZ1NlIxSGRZT3hrZ1Nz?=
 =?utf-8?B?RE45a1Qrblk0WHBYWkd3WUpxYlFXeEc3bGJvbGU3TFJiMk5DcXdtc1B0ckRT?=
 =?utf-8?B?b0dIN1VyYytsWDM5bU9ScS9HQjcrVmxOcWlETzE3T0VYOURrU256QUVmaEhU?=
 =?utf-8?B?NFRkd2pEZ29QdXNPWVhtOVMza1I4M0J6ckJneHFyN1pQYnhqTEhaQThoRUxu?=
 =?utf-8?B?Y08zUnlrTlp5SXJKMXh6QmVocnhrWkJMSFkrbHFGZ2xDaHFpNlZsNjJJbnF4?=
 =?utf-8?Q?gCAdBZ3dDm1uA+Px+Lm+3rpf+5PDj2tqSmk1MKA?=
X-Microsoft-Antispam-Message-Info:
 4efs+mDWTmS4jG83cAFmHfDfpvHRQ+MDbXrF9yHWq0iTHv3pj0vB0P99K7zT+d/z3thuoHpG3lwybQ7eAnY8CTu1Lfysglz1o5EPqk++AwoJ/18xWeyL0QvIPyc0IGnCz2DCW2tS2pwvDwMcG4vTKPNAgrNcdAEtg815QuhptoYuIaoXSzCb9TbpbU0V9OwPJCuGEEeplaP+sahZLPzueA7DsgRpf5FlFTaO9/WcEIWaKrP8eV0kVcuVPr9jiHs0vv3UKZ4IjAcU3HCMX291ItLSFqAqkG7f7pwmzGt4coUT3O9K+/NrjCNgOWTg7q3MCBm8j78Vk3Xuafot5gCjXKDA4ynsddczz4MsRIzeFV5TlE4mvwdbgc3M9529va1g3UYofzJiSmQZ6UiXctf4Za8fvFkt1BMV2/FnUCR1C5t2He+nCIM3rpVJyryxQEOnR47S0+g1qH5b4XtLVM58g8GAvk8afDfWaIXCgGKueYm64G2wt6h8R4CaIJHxwonCcntHycZSw1YsLQzuXDq7qcBj2iYgFZLdFepnm600UP64B/8f1h0U1v4ZtYpSfZTXQ6/iiQlxBhyc/wjn9+fW59O8a6xAQcigxQzOX9Vh2gGDnB/t9tZ+6Eoj7CC/zdUUZArDZZYsRwXBLHvfb4FMzLqPZA5bHg5q4EMy1dpAfivolF7qCoBUh2Ps4Kcts7SPAgs0ufnz44tbLAVqFvah5ERcLVs+7OR/ZiKpAMCs4+hvgVxLCB70t4J6x5J6VlWkhwTessjjq3TdJ+eYrPZN/g==
X-Microsoft-Exchange-Diagnostics:
 1;SN1PR12MB0509;6:7hZ/nwJxa9EwTcV7qn8L5XXEv1O3C+oqIGh/wv5HNiico7mIE2krvTOl3JrACheOfnaFKDUhVo6CdPaZHzfOVDZIAHxrmL0vJpR0Ky90dc6cgi3TEZmf0qlMU5SS2iBLnhrEc6ZimWmrCpbeYsoz4bEQW4QvY+8QKsP90DKevNquxdNS5qrHORfFAbNO/MyHWmVR+uyH4GmPdP3N/GTh5/WxaQ8Bdt/lpqcB8kewH7ZXIGoIzSsoQWe+21W7gJ8CsKq6WB9zWedJmt06G2OKQfUzNn19z8W5hi6M9KwZK2HiYI5C0bk6FnX4fm8V1Fbf5lU3+kn0tILyPRyp2Is+sGQIdZIXbmymjbr1a5jpeqQ5OmTYxSADw3Fybv4FL7LCtAozgEPf+Y8w1cJIZhNEzeLjQqcV52XQDuvLYQVHs8+fIYi9Ur1y+C1WuiVZqhNNK9mg+d5e1u7ufc6IdEMJNpeyiYmsK82GfIZ+uHm9mVY=;5:zJXkyjjW5eWN401pqKio7pmAk8zEA8hZUDvMLt1WOvf+xYJWRpE35mKU5yG+K9u3SeNwrDixfeS1r8urSI6isjpP7oFnApUMA1vF5jmKgdDoiye2KAoFI4e2ZsauxEgdN7ih3Q5uz0Z4T14hIDo60akSKFvieTNP+qIB8u62fNs=;7:75ZRC5ff5LRKAsLKNoUKJZPaQ3qISy8YRm2tDTc88NnV9u7I6I1l5ojxI5gvUpGTSUUNzbA6AbevJKSnXxm11aP/H7tln3YMjGXa458MwJkmzyj
 NhAXmxiw40ihVYTI5S8snpdTVjtwRDwsfNDhrDg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics:
 1;SN1PR12MB0509;20:c7sOrZuugwABGtzPGP5TPPmoqynZUm0bWLT1XjlPVZIrrxk3CWKsSowxWszp9rIlh7wAlbdXHUeiVMuWWN+7CVyAkbvvIOj8BBbJmgtZTEQ5NvUYtQrysc+VNWBspd1oIHq3GBosnhnjuEr3IzWiLqf0IaCoBh600DWimckScNSY6gHl6HOpKHjFtSNu17bhoFQN3TEfmT7CwubmJySkCiVuHCjINwLx25HdBmw/xqyVcbOowViLsKvWubHQCXb7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2018 11:12:54.8840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87af999b-85f7-443c-c4ee-08d64aeb4a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0509
X-MS-Exchange-Transport-EndToEndLatency: 00:00:02.5029573
X-MS-Exchange-Processed-By-BccFoldering: 15.20.1294.024
X-Microsoft-Exchange-Diagnostics:
	1;BY1PR12MB0502;27:4sSKTLKSPltGOEjGXjVa1ydopI3I+jKdU0VeDfAh3L2IGQICpmfpyFy1dcdsB5YrbiZG7gq7PKO6beXZUa2aHT6ErcOgGRBB4uwDNkKhIopTrqTMCiEK+bIU9D2zYQJDZwSbUxFUUKaT2c7eYZEX3oCDJZhUMnzh5dIEwA2W6QHpUukzH+rNF0a6nz6C2FctYJwp+O1AxZW1gm9mSMIASfnwgwuvG5t8CtbzxHwMrnHQ8oESfI7M5sGXHn599RdQ6lOUjhZarYIRSwvtttyQa5MmeM6biOk0Kt+P8mBJzgSfGwqaVMISW7yC/pkOuuePzwSn78LZgsFlDEUUdUNyfUpx+gCqIkqRzYV7UT91DlBtyd/r9iLQrIkLHw+mw4u90O1tEVe7ceC5Ccz4Ni8eOw==
X-Microsoft-Antispam-Mailbox-Delivery:
	ucf:0;jmr:0;ex:0;auth:0;dest:I;ENG:(20160514016)(750119)(520011016)(944506303)(944626516);
X-Microsoft-Antispam-Message-Info:
	Bn3vIf3ubgUZ61FidwuOD2dbJsVFctSUigGyLnKuT94MXC/3hc09VjpmpM7E3f5Fqj1GD/w9GllTnCDJVdRXe2PIiSQlEb/hItyJlCn7SdYavEqH8NuIX5cG5gpEybjkwJohxacLKdjW5I9KRbNGLsPQlQxA9OsltJ2ysebV1Z+KCGDnI3+A8qq9yi+gQAfnFn+5yNfjhifeu4LvKE8YBdgjHOeohH19fX/oY/aX4uJKhBdRVEBJd625Si0lQnK8dS4w6wpVi4jCD39bv5lLXsNiU2R3N3a01TJFZODVfry3AXf09JIE5vgrz2pZI94NJ8kIq7L9OscoxR/EwlCfR+fVbm1ZwjUa9b1X9K95Z/GBv17Vis4ZDJAkIm8+S5ijhB/ZDwylMkhN26uvi+rcyGpQG8UHfc4Yaql6KecZoYU7bfafHZ/+iFXNxwoFg34fBtFBIY5WurY/A/5sapdxoq0r/+nBkPP2nJr/v2KmJAch79XFHMvwGjjHSmcn2vo7Jxd7n/I8X5/WYrM8aij0BjxE+kw2J0w5pZVp10t2e7TLyx5fMbqIQDxrgOxOfw1+613Txwz1Hw1/N5eQYWznJHElpF97q1hrTj0Kgn+LKj33WoEk3JKLHPZi7Q8wENqttrIcuCTWw2WCC2wDC/6Wx4qSUfRxTmy2UkJL3ohZVRw047CKV/wIJtg4NOzY2ThRW0jGZmxq582aAzrlgOlpxJ1oiAMSxvoCRQ/ioOfYcnTPvVTPlFcINC25ZmmRsxCb0ctrF8mC8Wd+pmc+H2oemrSW0jHG2s7
 gaaCztjIRocRvZob4f2LT/Ti3TdvxoMGGbr3g9DnBx2aaoSOb8v3qxA==
MIME-Version: 1.0

Extract of useful code from the timeline work. Let's use just a single
stub fence instance instead of allocating a new one all the time.

Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/drm_syncobj.c | 67 ++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index f190414511ae..4c45acb326b9 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -56,10 +56,8 @@
 #include "drm_internal.h"
 #include <drm/drm_syncobj.h>
 
-struct drm_syncobj_stub_fence {
-	struct dma_fence base;
-	spinlock_t lock;
-};
+static DEFINE_SPINLOCK(stub_fence_lock);
+static struct dma_fence stub_fence;
 
 static const char *drm_syncobj_stub_fence_get_name(struct dma_fence *fence)
 {
@@ -71,6 +69,25 @@ static const struct dma_fence_ops drm_syncobj_stub_fence_ops = {
 	.get_timeline_name = drm_syncobj_stub_fence_get_name,
 };
 
+/**
+ * drm_syncobj_get_stub_fence - return a signaled fence
+ *
+ * Return a stub fence which is already signaled.
+ */
+static struct dma_fence *drm_syncobj_get_stub_fence(void)
+{
+	spin_lock(&stub_fence_lock);
+	if (!stub_fence.ops) {
+		dma_fence_init(&stub_fence,
+			       &drm_syncobj_stub_fence_ops,
+			       &stub_fence_lock,
+			       0, 0);
+		dma_fence_signal_locked(&stub_fence);
+	}
+	spin_unlock(&stub_fence_lock);
+
+	return dma_fence_get(&stub_fence);
+}
 
 /**
  * drm_syncobj_find - lookup and reference a sync object.
@@ -190,23 +207,18 @@ void drm_syncobj_replace_fence(struct drm_syncobj *syncobj,
 }
 EXPORT_SYMBOL(drm_syncobj_replace_fence);
 
-static int drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
+/**
+ * drm_syncobj_assign_null_handle - assign a stub fence to the sync object
+ * @syncobj: sync object to assign the fence on
+ *
+ * Assign a already signaled stub fence to the sync object.
+ */
+static void drm_syncobj_assign_null_handle(struct drm_syncobj *syncobj)
 {
-	struct drm_syncobj_stub_fence *fence;
-	fence = kzalloc(sizeof(*fence), GFP_KERNEL);
-	if (fence == NULL)
-		return -ENOMEM;
+	struct dma_fence *fence = drm_syncobj_get_stub_fence();
 
-	spin_lock_init(&fence->lock);
-	dma_fence_init(&fence->base, &drm_syncobj_stub_fence_ops,
-		       &fence->lock, 0, 0);
-	dma_fence_signal(&fence->base);
-
-	drm_syncobj_replace_fence(syncobj, &fence->base);
-
-	dma_fence_put(&fence->base);
-
-	return 0;
+	drm_syncobj_replace_fence(syncobj, fence);
+	dma_fence_put(fence);
 }
 
 /**
@@ -273,7 +285,6 @@ EXPORT_SYMBOL(drm_syncobj_free);
 int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 		       struct dma_fence *fence)
 {
-	int ret;
 	struct drm_syncobj *syncobj;
 
 	syncobj = kzalloc(sizeof(struct drm_syncobj), GFP_KERNEL);
@@ -284,13 +295,8 @@ int drm_syncobj_create(struct drm_syncobj **out_syncobj, uint32_t flags,
 	INIT_LIST_HEAD(&syncobj->cb_list);
 	spin_lock_init(&syncobj->lock);
 
-	if (flags & DRM_SYNCOBJ_CREATE_SIGNALED) {
-		ret = drm_syncobj_assign_null_handle(syncobj);
-		if (ret < 0) {
-			drm_syncobj_put(syncobj);
-			return ret;
-		}
-	}
+	if (flags & DRM_SYNCOBJ_CREATE_SIGNALED)
+		drm_syncobj_assign_null_handle(syncobj);
 
 	if (fence)
 		drm_syncobj_replace_fence(syncobj, fence);
@@ -984,11 +990,8 @@ drm_syncobj_signal_ioctl(struct drm_device *dev, void *data,
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < args->count_handles; i++) {
-		ret = drm_syncobj_assign_null_handle(syncobjs[i]);
-		if (ret < 0)
-			break;
-	}
+	for (i = 0; i < args->count_handles; i++)
+		drm_syncobj_assign_null_handle(syncobjs[i]);
 
 	drm_syncobj_array_free(syncobjs, args->count_handles);
 
-- 
2.14.1


--------------1A7B2CB33F6CB8EDB07561A5
Content-Type: text/x-patch;
	name="0001-drm-amdgpu-fix-signaled-fence-isn-t-handled.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-fix-signaled-fence-isn-t-handled.patch"

>From 3640a18c31e7b786129286615fcdf397e1142451 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 23 Nov 2018 22:05:19 +0800
Subject: [PATCH] drm/amdgpu: fix signaled fence isn't handled
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: Sharma, Deepak <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
CC: Christian König <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +++
 drivers/gpu/drm/drm_syncobj.c          | 1 +
 include/drm/drm_syncobj.h              | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 6a823b58b3b8..e960f9864e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1505,6 +1505,9 @@ int amdgpu_cs_fence_to_handle_ioctl(struct drm_device *dev, void *data,
 	if (IS_ERR(fence))
 		return PTR_ERR(fence);
 
+    /* that means fence was signaled */
+	if (!fence)
+		fence = drm_syncobj_get_stub_fence();
 	switch (info->in.what) {
 	case AMDGPU_FENCE_TO_HANDLE_GET_SYNCOBJ:
 		r = drm_syncobj_create(&syncobj, 0, fence);
diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 5f2df10e51c3..e5621f80d501 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -97,6 +97,7 @@ struct dma_fence *drm_syncobj_get_stub_fence(void)
 
 	return dma_fence_get(&signaled_fence);
 }
+EXPORT_SYMBOL(drm_syncobj_get_stub_fence);
 /**
  * drm_syncobj_find - lookup and reference a sync object.
  * @file_private: drm file private pointer
diff --git a/include/drm/drm_syncobj.h b/include/drm/drm_syncobj.h
index 29244cbcd05e..93e9e9b159ab 100644
--- a/include/drm/drm_syncobj.h
+++ b/include/drm/drm_syncobj.h
@@ -147,5 +147,6 @@ int drm_syncobj_get_handle(struct drm_file *file_private,
 int drm_syncobj_get_fd(struct drm_syncobj *syncobj, int *p_fd);
 int drm_syncobj_search_fence(struct drm_syncobj *syncobj, u64 point, u64 flags,
 			     struct dma_fence **fence);
+struct dma_fence *drm_syncobj_get_stub_fence(void);
 
 #endif
-- 
2.17.1


--------------1A7B2CB33F6CB8EDB07561A5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------1A7B2CB33F6CB8EDB07561A5--
