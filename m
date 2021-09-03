Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EE7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F099960F91
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 08:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F099960F91
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 362266E851;
	Fri,  3 Sep 2021 08:09:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF026E851
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 08:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVxNmoA13ZUzJIpYhYcZdDWKGvWbzpK9Bz1Uy0Iuzn1a5FcT7R1wsB/44lChn+fVJTN/+xjC+D5q8Mr7no8msgG9VSOYeZfh1CIV7WKZDlP+vG8ZL8HKUL+u3nAKBGYMufmAzy0vm6a7SOomTKdHS18lhGY20GM5WLWr3d5Ah0g5ZPtFQV8zS6wn5xhg/aCrFE4R8pMkofVZaKZokha2qraK1g5Tx5WZ24ZWEI0MM4S07qwpEexBZxRdljAt+y5t8dXPcwzRhFdovOMSgZr5DYupmFct3Sv5g4zzQjnSJ8elfI5uS+XyymJ/YO40rdt9EDaC88VUTRm74mhGBa0B+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=qwFzVR6a+2DbbZN8cCemZcxhkSVwcD2O48ucenp40rw=;
 b=PcVHstasp4dGYPxAskpRsNYlf6630J6xrSQ2eeUcCqUprL0KYlrZt9Qo0WLXixZF568g7ZTzfv9FlwQwo1pTuEaIoNtzP53pPjrcp3ZOx9jNTMouLwaMgAkDhxvYuf95ygcd8ze6schg0+0CPfjRqaYJ+w0GxH1mIgRpqGDgK7mCXXc/OtcJShfpJXb0eNw8q2q+y2DA3OjTG/qRJNL3x/T0eePXSaOZptkWSMPX/GiqLksvAmQtVLK5IbJNboDHFHhFbcz0kDP8xwg1AO12ULsWX8VA317mWxxIkEpfUnesSmzE3+VXnBhgp5IMPz9nxIaYNZg4h3bA1wxwO4d9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwFzVR6a+2DbbZN8cCemZcxhkSVwcD2O48ucenp40rw=;
 b=4lRVXxz19aETFXnoN+tgR6/4tbTnX7EvkYYY8+F60AWfolELt5SkHD7+ezrF6rexQUAMG25c/frcdkOxXC+7qVfNzaUgLBA3cpWbxEOLsrCI9rJU8yV+DX5T6JLJM5cgwlPgGG6CysWnDa5q/bkmtyLq96lPmjn8QilsXzpW+PQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Fri, 3 Sep
 2021 08:09:56 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 08:09:56 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
 <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
Date: Fri, 3 Sep 2021 10:09:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0135.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f20:4c00:bdd8:5b76:521a:8f56]
 (2003:c5:8f20:4c00:bdd8:5b76:521a:8f56) by
 AM0PR02CA0135.eurprd02.prod.outlook.com (2603:10a6:20b:28c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Fri, 3 Sep 2021 08:09:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 666e2620-fdae-43d9-a98d-08d96eb23722
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB523286FA401A68FCCB7193A78BCF9@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbX4PhUW0M+8zHPIaSX5WGlnOEwhuYpG9Tf0p663AR89pd1iHfwgmUbb/JEBsU49+B1LbYJ55gyK6d2iYFylsmdLEQW8MMQwsszNR54Sl+KG3ME/D3g7byg62K/crfVZ9DK04j808joSuuELl4rtWEpf3H48wLmYEi14SO+wHyisM73prVTAzMxuhOKiq33J2wUnmfw0J7FtxD0vq1lF9GMY7nY4AFkL0ZM8DeAKxzBeRHpCAR2PfbLOjZJkBnmhNl8yIOA9ZMH34n3/YC+M7Vwfhyeckr72H8DeRaeL3RI6LkzYk2cba4T2kkcJMvJT9GfAO2h4fhppubrOhEzOWRnKvPTbLEX9luZFz7evboVtWuOB3/KuZLlugPYPKgPaV3I6oyREGqkjtgFjvNvG57cSEmhimzj025HBu/zaiWVTdMoYu2bJw5xT3MvFKi5plXRZV+m6F9/AinDDivZIbFO8K475Qni23BpD8EbtlsW1QN6fR7nMzVQAkaO8VuE2CiQtaVpyK5rTFUZjr59f8uXSX2Ed47ohxo+FTkMK/f9lFSTbPWAws6+4rWPQxEvIdI0cTF7fC761AOF+6Dexgu2vWujaCUFi2j2xbqzQCj4vHY8rJUtZNNDdRh4crICjy9SMhD4dEIWg2v9rd2D3KyB2In8/wDI4/lx+ML16gOLzYmImVHi62NOG75mQmCry9RYCqc5NHnIBbwvkXZHxTGCwK9aMzr3IdKiWjxBjLcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(4326008)(53546011)(31696002)(6486002)(83380400001)(316002)(38100700002)(508600001)(5660300002)(2906002)(186003)(31686004)(8676002)(86362001)(2616005)(66476007)(66556008)(66946007)(8936002)(52116002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0N4T3JlR2Z1N2VxYXB3TUdPYWFpQXJCbnVxRnBOVy9vTnEyOURtcjlJRWlr?=
 =?utf-8?B?cnZjY3NxckJSSVErK3QzbDVVZ3l1QnBwQlBVUTIrOXpneVZpc1VEcjEvQjdq?=
 =?utf-8?B?OHZoUXIra1M1cjVzQnlQSjZhN3B2cW5ST3IwR3JnWEErajhMNFJFLzdLUVVr?=
 =?utf-8?B?LzFjU0d5ZHd3NFBGVXVUUC93M3NHdjJKNVpTU3hCSHpibkRPb2RTNUM3R1NP?=
 =?utf-8?B?RC9aWG5LMlE3TXVxQ1N6TGIvZkJRTG5nN1g0N2tqZGViYVBidjdDb3E1VDFl?=
 =?utf-8?B?OVQ5YmN2Vlo4UE5JZ09WK1kzZXJNS1RtcnlSSEwwbTZlNm9tcFhTWi9UZGhV?=
 =?utf-8?B?ZGVTS3AwVkJoMmNVbW81OTc2N0YzcnhIRm15bGhRb05YbjVnQzZ5SXVMZEhI?=
 =?utf-8?B?SWJUMDJVZXV0NnZRSXJ5d1NtWU5nZ09uQkZWNHJ1ZzgzR1RFdmNUanl5UXpx?=
 =?utf-8?B?cUd1UE84MmxLZzc3bmplZm1FWGF0TkFCNW9BNTRsOTd6VWJHUy9GRmFYdGZ1?=
 =?utf-8?B?ZmdleVQvQ3JLT2x4MU9qU05WNkpQdW40dXpOVHNLRXExMDRKcUdycEliVzNE?=
 =?utf-8?B?UmxRL0h1K0ZqdDl3UFo3b3Y0VFV0MlMwbVAzR3ZpZlpBeVFBc3AyZStKNXNv?=
 =?utf-8?B?anQ3aTRSWFE5VXdsUHU2emdnckJJSHZXV1FVUTJVdDdVemNCTElCL2NWU0lP?=
 =?utf-8?B?QVNmZFYrS0FUQmpTVHJZcmtHUHdlU0JaWkZ4SmY2c3RvZnBqdE1NZytVMVYv?=
 =?utf-8?B?WnlkK0U4R3dkVEpJZERwL2VraXRYKy84RHRpTFVXZnFMais3ekdJQVUrdGtY?=
 =?utf-8?B?dnpQeENMWWJZcnNqNGJmSGpGR3VIYU5yK3RFZkFyRG9CK3FCZ29PSEluY1BG?=
 =?utf-8?B?QUlPbTY1VGF4NWJzamtoTGpPTmVJbndKOWtkYjZQYjhtbHYzdm9qME1XVVpu?=
 =?utf-8?B?ZWNoOEZsOG9DOU45MHc3Yk5FOUhkcDYrWmZXbEkyRWJJbGVNUURNNytON3U3?=
 =?utf-8?B?eTR5YzYrZnRqLzZNMUNTNms5VHJsTWNRdzBPUDFBdEpqTU55cTZBL29iR2Vw?=
 =?utf-8?B?K3Rtc2lBZndNT3dsM1lFVXNRcEhXejNPbElXT05jTVNFZ0hDMzdSdWREZ2ll?=
 =?utf-8?B?d1RpZTBRN3lmTUZYc0NoVWkzRVRYdFZ2WUUxNnNXZ1lHdHNjYlRqUXdPT051?=
 =?utf-8?B?SHVDdG43UG5kOXpXK3RTejlOS3hQVGdueDFNY0wvc01pak5FWWRRRGJTQi93?=
 =?utf-8?B?NG41bE5YTW1FVmhnQ0NSWk5iNytkT0diS3NISDRkWXNSc3ZkU3hFWTFGMDZt?=
 =?utf-8?B?dldLVkFuUnZKc0lZcytNNldONWpxVHRsd0daQ28xcjczeC9Wc2VNYndPSzhj?=
 =?utf-8?B?Q25hc05zRmtFQmV4VnBJc3dUK2szKzdaWm11ZDBzbGNuWWJmNXFJL3JqVS9E?=
 =?utf-8?B?dW9OMzZkRzFSV1RuOGQ1NGJMVG5hU0loNGZSQVZVMkxXbkp4dVJSNE5XMHkx?=
 =?utf-8?B?NnVmTHc1RFdLOTZQSHpucWZhZmc0S1piOEhJRlpvZ28rd3J5RjBlZmpzZ2Ri?=
 =?utf-8?B?eWRhalFhWUJmRU13NjBvaUZuTVBOQThXMHhzNXlmV3dYVGp1SmxJcXF2RTMw?=
 =?utf-8?B?N0JoQXU3SGZONEpSYVBkUTBXU1lXbzN1YXgvOHA2TytiTzEvbTdueTB2dWRC?=
 =?utf-8?B?V2VGd0FvcG1mbWU2Z1IwbHpxQ2NjSXU4K01ucisxbDRTQ2hNa1JsSyswdTN1?=
 =?utf-8?B?bHdsRllRTEorV1ZrREFaeTltdkRVdm45akF4NWVzdkgvT09hQmpTS1c3ZFV3?=
 =?utf-8?B?OW9WQ3VpeERvenYxTFAxa3gvNnFjWlJvUE5EVmVjdGZzUWk0NTQ5UEtKcWtM?=
 =?utf-8?Q?Y/XfCWqPrE4UW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666e2620-fdae-43d9-a98d-08d96eb23722
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 08:09:55.9989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlTBsL/ewcHK7ALTw0YOLmSIKxDfvGj2o0PpXFVGxclbjkwPqZDLOc5KO7CFXOv/FBtnhAbbLLbNkm3EqsQ2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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


On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>
>
> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>> Use debugfs_create_file_size API for creating ring debugfs
>> file, also cleanup surrounding code.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 077f9baf74fe..dee56ab19a8f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>           if (!ring)
>>               continue;
>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>> -            DRM_ERROR("Failed to register debugfs file for rings !\n");
>> -        }
>> +        amdgpu_debugfs_ring_init(adev, ring);
>>       }
>>         amdgpu_ras_debugfs_create_all(adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> index f40753e1a60d..968521d80514 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>> @@ -415,26 +415,20 @@ static const struct file_operations 
>> amdgpu_debugfs_ring_fops = {
>>     #endif
>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>                    struct amdgpu_ring *ring)
>>   {
>>   #if defined(CONFIG_DEBUG_FS)
>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>> -    struct dentry *ent, *root = minor->debugfs_root;
>> +    struct dentry *root = minor->debugfs_root;
>>       char name[32];
>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>   -    ent = debugfs_create_file(name,
>> -                  S_IFREG | S_IRUGO, root,
>> -                  ring, &amdgpu_debugfs_ring_fops);
>> -    if (IS_ERR(ent))
>> -        return -ENOMEM;
>
> Why are we doing this ? Why to make it void from int ?


We tend to ignore debugfs return values as those are not serious errors. 
This to sync with rest of our

debugfs calls.


Regards,

Nirmoy

>
> - Shashank
>
>
>> -
>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>> -    ring->ent = ent;
>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>> +                 &amdgpu_debugfs_ring_fops,
>> +                 ring->ring_size + 12);
>>   #endif
>> -    return 0;
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 88d80eb3fea1..c29fbce0a5b4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>       bool            has_compute_vm_bug;
>>       bool            no_scheduler;
>>       int            hw_prio;
>> -
>> -#if defined(CONFIG_DEBUG_FS)
>> -    struct dentry *ent;
>> -#endif
>>   };
>>     #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), 
>> (ib)))
>> @@ -356,8 +352,6 @@ static inline void 
>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>                    struct amdgpu_ring *ring);
>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>> -
>>   #endif
>>
