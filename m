Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0765C47254
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF82206B9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 14:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XCPXTDJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF82206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC5B6E5CC;
	Tue,  5 May 2020 14:58:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E15B6E5CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 14:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cghw1WcKjt8obJlfSwNKpeRYsF1MbQnGsy8rz32oSa+RorASp2b5vcalP+g8aJcSjlYxf9CUQca/ZytvOUxMmtQSIUxnKBsJnRxcD5kdKWBPU/TdMvf/rut+WAFgQikJMiVg/d3YhRbhgeyqq/PqWOVMJkdjqDdmNUtLLsyW17ZT7JOwNphE5McfViCeQ+U0yo+ZZzhGETkoqytvJhzNCYDdWkG9DIr8xbCSHn420KDs4cygfyERnvqqdoxt8+RyfDLbGUOCwqrvDqJWquZIGEmupPX13IewjTw3+sBoai2keIiOZC5MBzp7fPrXwBx7Gz6zxhOJXWemfV5ZD6+Lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEhfsTlyb7DGXUqAeM7UWxQWDbA7QaM8o1/6vecbrdg=;
 b=jOWe0Jj7lNZCcSQ8VJes3RDf5AEN263x7pjn5v1gxXqFa+0wa5F8iWDGitM3YWvHhWEx6g5t3T4/uHVK3FveAVG2w41UrwURbGaAzJBdNmcj2jH/RPrgaslEYUDq3Or2X1t6gDO5yy6hVPDXX/69NLWVchSi5YXCqIh/M8nH60agXBTeTKOSh5AqWjUcvKSDgcDvtCgFgHfiATuHlLX6RrjsaIrHNoeqUFKTIkAxTYAjIbvfMl5DGp8qm3NzqXnotxEu+miVr1/evFZREBN7/QKRfmuN+VYY72icxktH/Chho+VHepcTizd9GjdxwxNHmepz/WenB6g1wOQNY/gBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEhfsTlyb7DGXUqAeM7UWxQWDbA7QaM8o1/6vecbrdg=;
 b=XCPXTDJ5KE6MDZcZOu7zor4ALsZM/7M9tkVF1F8qV93G4xgxW0okIRIeOr8aKq+MAlZN7WCsSrBWn5mxbZwDlGcr5A5SA2I3jSbKRnJoXNvdqPRGbqn0LbxnUemBVW1DnVFfiteBvaKwtBvwTVBkg7xkKkx3XCd1+DX9X10j/a4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 14:58:04 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 14:58:04 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Take a reference to an exported BO
To: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20200501142127.14202-1-Felix.Kuehling@amd.com>
 <70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com>
 <551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com>
 <6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <170627d3-b5f8-edf5-d809-dd197c4e2018@amd.com>
Date: Tue, 5 May 2020 10:58:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com>
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::49) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YQBPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 14:58:04 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93f9bc57-311d-44ff-7038-08d7f104b6ca
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:|SN1PR12MB2509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2509B90E1CD18FFB43858A0992A70@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0bV0lk/4zLoIPuaKi/yWKtH2Pg+54doujEi4gaRhZFm07pPW8HQ3I3iyUC/LEqrweP0Kew7oj6NExQ/gxMfGEIJ4SaGksg6EgB4mbMiFwXNUHPE+8HPoq17Sulqem3DYB559NAOobnGPd5jyKhJuS1lZLaLqIuEuQLmOvsJBjAsVacuzDTqFxUPZsPOuU71wgoNqT//41GQNZMg8a4ztaI2BfamlKFdPjTlC/qjiJSzeqIzg3xRdg3iVvkRL9q4GxVG5GqMeRHggM1HTTSBVyC9/rflKLEHzgseV1EkVh+lr+DujlE4WQo+s0fPkAfsU/bYJb1CMH6g634WDEn0/0EauQi9xuEiqIqSHpIPMlLqf5nfCsSIYWJm1PSKebrSLPkjDIwdh2g2MzJQqIZrYIbKyjPE6nbuJkvbR53OuUSedzhkSgCqv3Hllp0O4xBWWHKUUhInmYXrofhkfcwgSF8M990X8ILSiZoABoEXWYYRZM6nmCZ03q4GbUL/seVEs8NC8H9xiKZe1v/nX2wvlI4BKtpTA1zS6IvJmqn1RPgIsbhxNnQW7QNTeB8Zk/Qd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(33430700001)(6486002)(52116002)(5660300002)(16526019)(186003)(26005)(30864003)(2906002)(33964004)(33440700001)(966005)(8936002)(66946007)(31696002)(16576012)(44832011)(316002)(956004)(2616005)(8676002)(86362001)(31686004)(66476007)(478600001)(36756003)(66574012)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ty6+pbyBW/3JsLhKTQfAya8CtlA4kbT2edJgGoJE3iZGIwKyciIcHP+MPWMfO5xJWMfAvS7TPptFqdmmYC4iqUSANx8UtAnjcmLrfrtY8yF/H9aRZsWQdi2qdMGjNpFBvve6+67fKqEnMF+dMaPZw8iFfpxBvnX8kv7Do/Z039spnA7Y83M4CLWlxUz4XtWU9/nfx5wMWgQZk8UkooBxOgynyCLD4rWcttU9SwZA3jZ0RzwHtn45uHkUWYCBB/9TrYLHJ+zdaZMBudBZtOT8a4o+4xOW5LZleo8SJdjxj7dRk0Oyegu61GShZB46DSSgdsSUO7EQk3GX8dcrn3VZ+dG4eh74gVeSz4t87g3piAFD+hBgrSA2rFCGcjnW8iteyn9BLEh7Od0jyHWTatWWe8vPNDRLedLaXe4VLpB0S1YPPautG+q057ddOgN/qHwNuBKVg/0PmLvwXDDhxP4YTNc464tBccyRiX48yU0V1MN79jewKjJDf6eLb4U+cSKCgBB49Af4iNnBHDARR9p1YIWBox8VXxvCVf42Hx6WAFgrag9YVsRAuh5FdRoTARUMd2dOB0L+wFqxSM/FAvsgv3ehNOUhXTFkCOZ0KL4qIa0kTpFCX7KSwZ6jcuhDaklKIhjceIBY3wP8f4KLg+Cjwmt7l+pTc64npsefJzRVKK880JBuJGzf47UwYRv6tRa6/pBZvAMaw8LhYEpjQx/L9xyUKjzGXcciZ1H0nDQHdEL1pRbShyXZkYD6yVMuksuuq8HymjW+gtACGf0wYhi9gfopfRwAJqe1K8Z1/yC2vCs=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f9bc57-311d-44ff-7038-08d7f104b6ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 14:58:04.6257 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvQhKtq5HNZnuXFr6La/LDn+aOaMKRMwiLRUUcHxMVmS7rzM/ovXwvEC+xLTeNIPfqZ9TPDQ6KJBmFLiZQNIoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
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
Content-Type: multipart/mixed; boundary="===============1247937646=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1247937646==
Content-Type: multipart/alternative;
 boundary="------------31210615F2564D2FFD3ED500"
Content-Language: en-US

--------------31210615F2564D2FFD3ED500
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Am 2020-05-05 um 3:47 a.m. schrieb Christian König:
> Just to reply here once more, this patch is a clear NAK.

Agreed. But see below. I don't think all is well.


>
> The references are grabbed in the call path of drm_gem_prime_export()
> and dropped again in drm_gem_dmabuf_release().
>
> So they are perfectly balanced as far as I can see.

That is true for the GEM object references. But I believe there is still
a problem with the TTM BO references.

As far as I can tell amdgpu_bo_unref can free the TTM BO while there are
still references to the GEM object from DMA buf exports. I think that's
a fundamental problem with how we have two reference counts for the same
physical object (TTM BO and the embedded GEM BO).

I think the correct solution is for amdgpu_bo_ref/unref to delegate its
reference counting to drm_gem_object_get/put instead of ttm_bo_get/put.
The amdgpu BO would hold one token reference to the TTM BO, which it can
drop when the GEM BO refcount drops to 0. Finally, the amdgpu BO should
only be freed once the TTM BO refcount also becomes 0.

Regards,
  Felix


>
> Regards,
> Christian.
>
> Am 01.05.20 um 16:44 schrieb Felix Kuehling:
>>
>> [dropping my gmail address]
>>
>> We saw this backtrace showing the call chain while investigating a
>> kernel oops caused by this issue on the DKMS branch with the KFD IPC
>> API. It happens after a dma-buf file is released with fput:
>>
>> [ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
>> [ 1255.049727] #PF: supervisor read access in kernel mode
>> [ 1255.050092] #PF: error_code(0x0000) - not-present page
>> [ 1255.050416] PGD 0 P4D 0
>> [ 1255.050736] Oops: 0000 [#1] SMP PTI
>> [ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
>> [ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
>> [ 1255.051752] Workqueue: events delayed_fput
>> [ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked+0x1c/0x70 [drm]
>> [ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 <48> 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
>> [ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
>> [ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
>> [ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
>> [ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
>> [ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
>> [ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
>> [ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
>> [ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
>> [ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> [ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> [ 1255.057763] PKRU: 55555554
>> [ 1255.058179] Call Trace:
>> [ 1255.058603]  drm_gem_dmabuf_release+0x1a/0x30 [drm]
>> [ 1255.059025]  dma_buf_release+0x56/0x130
>> [ 1255.059443]  __fput+0xc6/0x260
>> [ 1255.059856]  delayed_fput+0x20/0x30
>> [ 1255.060272]  process_one_work+0x1fd/0x3f0
>> [ 1255.060686]  worker_thread+0x34/0x410
>> [ 1255.061099]  kthread+0x121/0x140
>> [ 1255.061510]  ? process_one_work+0x3f0/0x3f0
>> [ 1255.061923]  ? kthread_park+0xb0/0xb0
>> [ 1255.062336]  ret_from_fork+0x35/0x40
>>
>> drm_gem_object_put_unlocked calls drm_gem_object_free when the
>> obj->refcount reaches 0. From there it calls
>> dev->driver->gem_free_object_unlocked, which is
>> amdgpu_gem_object_free in amdgpu.
>>
>> Regards,
>>   Felix
>>
>> Am 2020-05-01 um 10:29 a.m. schrieb Christian König:
>>> Am 01.05.20 um 16:21 schrieb Felix Kuehling:
>>>> From: Felix Kuehling <felix.kuehling@gmail.com>
>>>>
>>>> That reference gets dropped when the the dma-buf is freed. Not
>>>> incrementing
>>>> the refcount can lead to use-after-free errors.
>>>>
>>>> Signed-off-by: Felix Kuehling <felix.kuehling@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 ++++++++-
>>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> index ffeb20f11c07..a0f9b3ef4aad 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>>> @@ -398,8 +398,15 @@ struct dma_buf *amdgpu_gem_prime_export(struct
>>>> drm_gem_object *gobj,
>>>>           return ERR_PTR(-EPERM);
>>>>         buf = drm_gem_prime_export(gobj, flags);
>>>> -    if (!IS_ERR(buf))
>>>> +    if (!IS_ERR(buf)) {
>>>>           buf->ops = &amdgpu_dmabuf_ops;
>>>> +        /* GEM needs a reference to the underlying object
>>>> +         * that gets dropped when the dma-buf is released,
>>>> +         * through the amdgpu_gem_object_free callback
>>>> +         * from drm_gem_object_put_unlocked.
>>>> +         */
>>>> +        amdgpu_bo_ref(bo);
>>>> +    }
>>>
>>> Of hand that doesn't sounds correct to me. Why should the exported
>>> bo be closed through amdgpu_gem_object_free()?
>>>
>>> Regards,
>>> Christian.
>>>
>>>>         return buf;
>>>>   }
>>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--------------31210615F2564D2FFD3ED500
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 2020-05-05 um 3:47 a.m. schrieb
      Christian König:<br>
    </div>
    <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
      
      <div class="moz-cite-prefix">Just to reply here once more, this
        patch is a clear NAK.<br>
      </div>
    </blockquote>
    <p>Agreed. But see below. I don't think all is well.</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
      <div class="moz-cite-prefix"> <br>
        The references are grabbed in the call path of
        drm_gem_prime_export() and dropped again in
        drm_gem_dmabuf_release().<br>
        <br>
        So they are perfectly balanced as far as I can see.<br>
      </div>
    </blockquote>
    <p>That is true for the GEM object references. But I believe there
      is still a problem with the TTM BO references.</p>
    <p>As far as I can tell amdgpu_bo_unref can free the TTM BO while
      there are still references to the GEM object from DMA buf exports.
      I think that's a fundamental problem with how we have two
      reference counts for the same physical object (TTM BO and the
      embedded GEM BO).</p>
    <p>I think the correct solution is for amdgpu_bo_ref/unref to
      delegate its reference counting to drm_gem_object_get/put instead
      of ttm_bo_get/put. The amdgpu BO would hold one token reference to
      the TTM BO, which it can drop when the GEM BO refcount drops to 0.
      Finally, the amdgpu BO should only be freed once the TTM BO
      refcount also becomes 0.<br>
    </p>
    <p>Regards,<br>
      &nbsp; Felix<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
      <div class="moz-cite-prefix"> <br>
        Regards,<br>
        Christian.<br>
        <br>
        Am 01.05.20 um 16:44 schrieb Felix Kuehling:<br>
      </div>
    </blockquote>
    <blockquote type="cite" cite="mid:6c4b3eb0-40b5-8c3c-dc5e-38b622864e12@gmail.com">
      <blockquote type="cite" cite="mid:551849ec-bc90-0bd2-d46c-f6d8e5c0fee0@amd.com">
        <p>[dropping my gmail address]</p>
        <p>We saw this backtrace showing the call chain while
          investigating a kernel oops caused by this issue on the DKMS
          branch with the KFD IPC API. It happens after a dma-buf file
          is released with fput:</p>
        <pre>[ 1255.049330] BUG: kernel NULL pointer dereference, address: 000000000000051e
[ 1255.049727] #PF: supervisor read access in kernel mode
[ 1255.050092] #PF: error_code(0x0000) - not-present page
[ 1255.050416] PGD 0 P4D 0
[ 1255.050736] Oops: 0000 [#1] SMP PTI
[ 1255.051060] CPU: 27 PID: 2292 Comm: kworker/27:2 Tainted: G           OE     5.3.0-46-generic #38~18.04.1-Ubuntu
[ 1255.051400] Hardware name: Supermicro SYS-4029GP-TRT2/X11DPG-OT-CPU, BIOS 3.0a 02/26/2019
[ 1255.051752] Workqueue: events delayed_fput
[ 1255.052111] RIP: 0010:drm_gem_object_put_unlocked&#43;0x1c/0x70 [drm]
[ 1255.052465] Code: 4d 80 c8 ee 0f 0b eb d8 66 0f 1f 44 00 00 0f 1f 44 00 00 48 85 ff 74 34 55 48 89 e5 41 54 53 48 89 fb 48 8b 7f 08 48 8b 47 20 &lt;48&gt; 83 b8 a0 00 00 00 00 74 1a 4c 8d 67 68 48 89 df 4c 89 e6 e8 9b
[ 1255.053224] RSP: 0018:ffffb4b62035fdc8 EFLAGS: 00010286
[ 1255.053613] RAX: 000000000000047e RBX: ffff9f2add197850 RCX: 0000000000000000
[ 1255.054032] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9f2aa2548aa0
[ 1255.054440] RBP: ffffb4b62035fdd8 R08: 0000000000000000 R09: 0000000000000000
[ 1255.054860] R10: 0000000000000010 R11: ffff9f2a4b1cc310 R12: 0000000000080005
[ 1255.055268] R13: ffff9f2a4b1cc310 R14: ffff9f4e369161e0 R15: ffff9f2a1b2f9080
[ 1255.055674] FS:  0000000000000000(0000) GS:ffff9f4e3f740000(0000) knlGS:0000000000000000
[ 1255.056087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.056501] CR2: 000000000000051e CR3: 00000002df00a004 CR4: 00000000007606e0
[ 1255.056923] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1255.057345] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1255.057763] PKRU: 55555554
[ 1255.058179] Call Trace:
[ 1255.058603]  drm_gem_dmabuf_release&#43;0x1a/0x30 [drm]
[ 1255.059025]  dma_buf_release&#43;0x56/0x130
[ 1255.059443]  __fput&#43;0xc6/0x260
[ 1255.059856]  delayed_fput&#43;0x20/0x30
[ 1255.060272]  process_one_work&#43;0x1fd/0x3f0
[ 1255.060686]  worker_thread&#43;0x34/0x410
[ 1255.061099]  kthread&#43;0x121/0x140
[ 1255.061510]  ? process_one_work&#43;0x3f0/0x3f0
[ 1255.061923]  ? kthread_park&#43;0xb0/0xb0
[ 1255.062336]  ret_from_fork&#43;0x35/0x40
</pre>
        <p>drm_gem_object_put_unlocked calls drm_gem_object_free when
          the obj-&gt;refcount reaches 0. From there it calls
          dev-&gt;driver-&gt;gem_free_object_unlocked, which is
          amdgpu_gem_object_free in amdgpu.<br>
        </p>
        <p>Regards,<br>
          &nbsp; Felix<br>
        </p>
        <div class="moz-cite-prefix">Am 2020-05-01 um 10:29 a.m. schrieb
          Christian König:<br>
        </div>
        <blockquote type="cite" cite="mid:70e5d202-34ed-532f-e6b6-c195a3effad3@gmail.com">Am
          01.05.20 um 16:21 schrieb Felix Kuehling: <br>
          <blockquote type="cite">From: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@gmail.com" moz-do-not-send="true">&lt;felix.kuehling@gmail.com&gt;</a>
            <br>
            <br>
            That reference gets dropped when the the dma-buf is freed.
            Not incrementing <br>
            the refcount can lead to use-after-free errors. <br>
            <br>
            Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@gmail.com" moz-do-not-send="true">&lt;felix.kuehling@gmail.com&gt;</a>
            <br>
            --- <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 9 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-
            <br>
            &nbsp; 1 file changed, 8 insertions(&#43;), 1 deletion(-) <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
            index ffeb20f11c07..a0f9b3ef4aad 100644 <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
            &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c <br>
            @@ -398,8 &#43;398,15 @@ struct dma_buf
            *amdgpu_gem_prime_export(struct drm_gem_object *gobj, <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ERR_PTR(-EPERM); <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf = drm_gem_prime_export(gobj, flags); <br>
            -&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf)) <br>
            &#43;&nbsp;&nbsp;&nbsp; if (!IS_ERR(buf)) { <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf-&gt;ops = &amp;amdgpu_dmabuf_ops; <br>
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* GEM needs a reference to the underlying object <br>
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * that gets dropped when the dma-buf is released,
            <br>
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * through the amdgpu_gem_object_free callback <br>
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from drm_gem_object_put_unlocked. <br>
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
            &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_ref(bo); <br>
            &#43;&nbsp;&nbsp;&nbsp; } <br>
          </blockquote>
          <br>
          Of hand that doesn't sounds correct to me. Why should the
          exported bo be closed through amdgpu_gem_object_free()? <br>
          <br>
          Regards, <br>
          Christian. <br>
          <br>
          <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return buf; <br>
            &nbsp; } <br>
          </blockquote>
          <br>
        </blockquote>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------31210615F2564D2FFD3ED500--

--===============1247937646==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1247937646==--
