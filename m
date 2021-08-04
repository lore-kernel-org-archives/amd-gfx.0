Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0D7C4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E7D60F14
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 15:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70E7D60F14
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE7E6EAC1;
	Wed,  4 Aug 2021 15:47:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C678A6EAC7
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 15:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM0OQr8dnxqyHVYvmVKxtpk0OAHJFeyaUpMWHJ1W4BdIrBAjEH0PyI5ahqZEEZ5I9NCPs/imVEdeJlQLEj17BVy4y8t6W6zQCUBmmOrRgzQJ4TZ3Uc60JJigYo8rcSVDPSDiYJH2KTXlOPoOJtDQPJHb1Fy/o++hRUR8NZIDJJPgXYnBEJEfegD7uXZkN9ZziVUuxd36Aaab800sFURXUpVe8j3JacTrNGke3ueGlOs+dOR88PxIyhW/KUvWnrjtsu7KKUuNqMATd747/UG/oZNv2dxukRZi8i1zNAxcLQ/RtB5xCIrJ0iFonQry95cDw4rMn56lfSFrwjSUR1N+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjpMr6tK11p6SWM2Wk042Rr4tmoR5c0qE5jrjVFA7rY=;
 b=Cjt0R+jkb1yHmteB0L+SH8J6rl8+dKLPBOdXNxZ88njw0G36KGyhTJt0Oz6VkrAGsLJBBlCzeHIldAldn6ckW9PUJZM2EzB26qMCbL/r13MOXA7J9Kred9MwK6v8OCov9m/oNc3irQ7+1Td4aycC8yy7S6FduCLRUK0mDTvcsb468RlhAyyTMRf+8yX33JYvl5t7VPvyLfzGRlSC9j6MajWH0SSLxPIrBXHc+h2JKHZQpzBSJSvBvQcOGnxtMkMbt+5Xnlz4p9y3FQ3c+rxkON4fdsYm3PrWej8SVbx+uh0PVB86DvO5ykMJv3mH/p/gKQ93YqZLd7m5NgU/V6421Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjpMr6tK11p6SWM2Wk042Rr4tmoR5c0qE5jrjVFA7rY=;
 b=KLVT8QrSw77GIx5hTdT9wpG5zGeRV+e38oFhYNuzcOSXZ5yVNLxFcEn5OOj1x21fgeny7+ORjNs8AcqguuhgSNdtZQESmSdxiZLeFlh+43KktR7fKU6mSDjw6sLQO2ngKYEX1HNeGcvgS3PVjSUXkj07sN1aH6Hp3Kky7KkJGHg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 15:47:08 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%3]) with mapi id 15.20.4352.033; Wed, 4 Aug 2021
 15:47:08 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix vm free pts race when process exiting
To: amd-gfx@lists.freedesktop.org
References: <20210802223308.13076-1-Philip.Yang@amd.com>
 <920b7b04-8f8d-a57a-724e-811a4c7e581c@gmail.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <351c02cc-4b76-85d8-a64f-e87182cac19d@amd.com>
Date: Wed, 4 Aug 2021 11:47:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <920b7b04-8f8d-a57a-724e-811a4c7e581c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 15:47:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96abb0f7-1422-443e-b657-08d9575f1d9d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5146:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5146597F6904C4082C8E59BC92F19@BN9PR12MB5146.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDVLR4KtaJA4ALQKLeiiuxp5KaztAP2t+VKRgGfNNp+9tHu4okOprlwdyO0xhLZpI6u+msp1wQ6hg4FyABNXe/CUx62IoRUX2FXp0dtMNF3LMLf/hopPFkRiLI7FvcsUDiw/g3XiwYdk6+rarSCNy8ew6+Lnxy2kT0XG2TayKN10QMfXRBBkC4q0Iwt9N2LlqGzkr+rVK7VrXTmN8uSr4xpHmN5NJZsvIfov39A7NyTbbWrktTwS3MDSa+n5Fvd0WkaMh0EYk83JOPHeOGAiWe/3jC4D3R1VM41gPTHA5WbHjXfi+Taxy+87qneJgmAMaR0KPXoAWjGhfgN/M4IWbEJjqQq6dQY4PRY2dJbSI552gfYlPOzcRM1h2d1/q2Ng6RAvHYT9UN3nAaZAHK04mvXH18BvX2yyI+Tx34METjTM1Usfi4zUI2N+0vjwc4mnwsFzssnH/89mjN6IqnlWX/LCSm32HF0Yh0XNfkhJEPwf1NulPpwTuPyaEG8GuVjPWHhyhDkKgrLWDrja6N2YbdDeDFWEs29zjHf9PC4eDg9ULHOU9E83VVfAVR9X/C5IIheTNeq6ntn7YwZFC8lG5EluqJWRuY4Dyjj82u3jC6imuNlf9nMuwjdlXn5Yo8J0joyFA4UNANBYh//SABTieuMNqc0bFw3unoupW1tjmR7giVcVnMvTQWnQIXwImNkkkeDfNseAF1XYwuPsItnxlfWLK5HGCXbU0fAOFEzrjUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(66574015)(956004)(8676002)(478600001)(8936002)(2616005)(6486002)(5660300002)(2906002)(66946007)(36756003)(44832011)(83380400001)(38100700002)(31686004)(26005)(86362001)(316002)(31696002)(66476007)(6916009)(186003)(66556008)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3dlRXlWVHI1TEthWlZkSjFWbVRQbk03THBmU3ZVRUl4c01aeVl2NVZwa0Rv?=
 =?utf-8?B?c0JuSndoRFJCQ1VoemI2TFdBN3RlR1JMWE1hUHVMSWF3aTRVTjMxWWZsQmZ5?=
 =?utf-8?B?dEFCSFFDV0NRa2pqNTZBaHAwdDlLY2wzZ2plVzhSMXMwZnVkanF2YTFtOFhR?=
 =?utf-8?B?VDRTbmxoeHFaemlQT2VPSGpqc1dSd1VCdEMxd2lXc1JxWGJwQ016Q2txZ2Fu?=
 =?utf-8?B?TzVKM2FRVTZEaHEvZ1hTR2t4TnQyUmpFaVdSbUFrQlk1Y3dMSm9ydTZOL3ow?=
 =?utf-8?B?Y3dXaE1aeXJteG5KUkt4TVdYMlYrWEo5bkJNTUFUbTdDc1Irb3hmY3grblFt?=
 =?utf-8?B?NzhGTUVNd1V6NmdJRUJST1NwbFQvN3lsRllEZnA1MExLYXd1VUNQNzgzMEpY?=
 =?utf-8?B?Y2QxUUdUQk9XdDQvMHNRb2p4eUpOR1QzSXdlV25NSlYzbER5SVVUdHB2MU1J?=
 =?utf-8?B?WUhxenhwMzFNc24wWFhTK1A1eUZlZHc5RzhTNTRNNGxmNndrV3M4MUgrZ0o4?=
 =?utf-8?B?YlJrWHZ1U2VYT0Nva3JFa0RuZU1qblcxYWxxWi9XSHNYZW9aTXBrVGg5Z0ti?=
 =?utf-8?B?OTFOODN0Ulk5Ry96Wk5ZK1lwYkRveXFaeDRQbjcvaFVmVzdweFVlekk3Ryth?=
 =?utf-8?B?Y3VpdUxJUkphVWUzZmw3MlgrUVZKWlFnd3VVRWhnSTA3L1p3QkdKSThEdjJo?=
 =?utf-8?B?RTBxQnFFekMrNnBlVWd5QlRLLzZDU0VBU3FueXp1UCt3QmlvUlgwM08vWWJa?=
 =?utf-8?B?S2RLUGIyWVpwZ0FqRHFyYk5ZWkVUYTRJQnVCS3AzM1FJbkE1K0pWaWZ6M2Fh?=
 =?utf-8?B?WlpsdXdsWWNRZ25RV1JrbjRtMXczL29wREwyUi9oLzh2Szg3VWxBbVhHYzRZ?=
 =?utf-8?B?MCt1TC90Rm41WEkzTHpCbEpWWHZIa1NIM0g0eUdtU3ZUTUFlREdFT0xCZ0Jw?=
 =?utf-8?B?Z2tzbGZpUU1hdEVHeHM3S2IyRmVBV0loSWpiZ1k1RldMU2FyTytXendCWHdo?=
 =?utf-8?B?b0NaVHlOTDBwSEFROFcvYldHV3g2WVNhN2srRFpqOWIySlNlc3BhOUs5YWlJ?=
 =?utf-8?B?emZGTFZxdTVQU0c4TWtUNDVpTWdVcFlyVktwNmJlanV3WDFjYWRPNkhrdkxQ?=
 =?utf-8?B?em5PRklWRWorZElZYkNwQTRaQW1JSW42SjNWUDVKUUJSenhJYUQ4dVhBQlAy?=
 =?utf-8?B?TnpzdkVFcHF2YWZzMThEcEhCUHVWZmMwRkxuVHZFeXFEcmtHV1RoK2RLcE41?=
 =?utf-8?B?eFBVeHB3QjVNS09YTWR5NEMzYUpqUUlsNVFNWFM1d0x3bHdxUEVOVUExWWR3?=
 =?utf-8?B?c1M1R2FZT2NwU041KzB6SWV4U3F3cUZTU25MMDJPa3pDTkpYM0hxZ1FkYUFv?=
 =?utf-8?B?UWppcnBYYWh4YWU0UkpGZllVeFdVdnVWNi9rTHUrYU1vV3J3Yms3R0JXZXMr?=
 =?utf-8?B?QlhrQzdUdCtDSFJZL0d3aG5UcUJNNGxWcDZZeDVJYStrSTJwK1BmZUxxbDFv?=
 =?utf-8?B?Mi9TMkVjYmEwQktPSUpGMlVscHl4VWhacWhneUFuNmlLNTJzZnRJZHJtZTd2?=
 =?utf-8?B?Nkc4UEhrWnRFL3BENnh2VjNPd1BySDM2M2NQeVZjcGR1TnozWnZncWg3NXVZ?=
 =?utf-8?B?Y0NtVFpobzlVZ2x1TnZhMzFXMXE2Q0NVSjRBdDg0c01KQk0vdWJRY2IyLzdZ?=
 =?utf-8?B?M1BUaGJRVzg5SitNWFFGc2ZFeGJoVzNaRnZ6NG5RdXMwcDBZaGNVZzcvNzZF?=
 =?utf-8?Q?J6pf2NmumdEnw4/aiDpi8xLHxraOe8abpewwTbg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96abb0f7-1422-443e-b657-08d9575f1d9d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 15:47:08.0896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/Dzv62mBURbFWKIwD7It0US8b9e72jhQERS/S/WpHpOd1ZP5uHxPKYtwZN13/aHV+7zfihMFBxr5hNP3wlaUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5146
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

Am 2021-08-04 um 5:01 a.m. schrieb Christian König:
> Am 03.08.21 um 00:33 schrieb Philip Yang:
>> Take vm->invalidated_lock spinlock to remove vm pd and pt bos, to avoid
>> link list corruption with crash backtrace:
>>
>> [ 2290.505111] list_del corruption. next->prev should be
>>   ffff9b2514ec0018, but was 4e03280211010f04
>> [ 2290.505154] kernel BUG at lib/list_debug.c:56!
>> [ 2290.505176] invalid opcode: 0000 [#1] SMP NOPTI
>> [ 2290.505254] Workqueue: events delayed_fput
>> [ 2290.505271] RIP: 0010:__list_del_entry_valid.cold.1+0x20/0x4c
>> [ 2290.505513] Call Trace:
>> [ 2290.505623]  amdgpu_vm_free_table+0x26/0x80 [amdgpu]
>> [ 2290.505705]  amdgpu_vm_free_pts+0x7a/0xf0 [amdgpu]
>> [ 2290.505786]  amdgpu_vm_fini+0x1f0/0x440 [amdgpu]
>> [ 2290.505864]  amdgpu_driver_postclose_kms+0x172/0x290 [amdgpu]
>> [ 2290.505893]  drm_file_free.part.10+0x1d4/0x270 [drm]
>> [ 2290.505916]  drm_release+0xa9/0xe0 [drm]
>> [ 2290.505930]  __fput+0xb7/0x230
>> [ 2290.505942]  delayed_fput+0x1c/0x30
>> [ 2290.505957]  process_one_work+0x1a7/0x360
>> [ 2290.505971]  worker_thread+0x30/0x390
>> [ 2290.505985]  ? create_worker+0x1a0/0x1a0
>> [ 2290.505999]  kthread+0x112/0x130
>> [ 2290.506011]  ? kthread_flush_work_fn+0x10/0x10
>> [ 2290.506027]  ret_from_fork+0x22/0x40
>
> Wow, well this is a big NAK.
>
> The page tables should never ever be on the invalidation list or
> otherwise we would try to point PTEs to them which is a huge security
> issue.

entry->vm_status is used on other lists as well, and I think page tables
can be added to those when they are evicted:

    static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
    {
            struct amdgpu_vm *vm = vm_bo->vm;
            struct amdgpu_bo *bo = vm_bo->bo;

            vm_bo->moved = true;
            if (bo->tbo.type == ttm_bo_type_kernel)
                    list_move(&vm_bo->vm_status, &vm->evicted);
            else
                    list_move_tail(&vm_bo->vm_status, &vm->evicted);
    }

But that never seems to involve the invalidated_lock. Maybe there is
some other lock we should be holding somewhere (not necessarily in
amdgpu_vm_free_table) to avoid this list corruption.

Regards,
  Felix


>
> Taking the lock just workaround that. Can you investigate how it
> happens that a page table ends up on that list?
>
> Thanks in advance,
> Christian.
>
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 2a88ed5d983b..5c4c355e7d6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1045,7 +1045,9 @@ static void amdgpu_vm_free_table(struct
>> amdgpu_vm_bo_base *entry)
>>           return;
>>       shadow = amdgpu_bo_shadowed(entry->bo);
>>       entry->bo->vm_bo = NULL;
>> +    spin_lock(&entry->vm->invalidated_lock);
>>       list_del(&entry->vm_status);
>> +    spin_unlock(&entry->vm->invalidated_lock);
>>       amdgpu_bo_unref(&shadow);
>>       amdgpu_bo_unref(&entry->bo);
>>   }
>
