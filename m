Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761C0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31B666120D
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 12:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31B666120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C14E56E3E5;
	Tue,  5 Oct 2021 12:20:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4E96E3E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 12:20:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNdOUl9QGZdCLRnHL9JFardYAqTLuDpY8UoMVoqoFdCbjSGPXEEHM8G9j7v9sEfN1GtelrJ97k9zEEjQWzanD3G32kzWr+v+u5rYh3fif/P77XS91BqV/OPU32Fb/g3lrhHmHysT+VufFV1Zo/yUn1JbHg4XwTqDULaO+iFB1og9Sp/a6pUEOq8J+a0muF0zCPVpY7aeCJJo9AQrIIJA3T8Fw3qHYWws24ZX8ZH9xIhn8AkrEcfNJVpzWpkzL4P5NJJ3/HcV6J4I9FK77hKITUBg821Hu1oIW+wgV0BLXgcisRXpXXBNbn4wGwE1KteZNRjMifKreG3uISQiSaassw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQuAsiJo2tQdPm7/duQnBsVjcnMsCL91T4CCIddrhhU=;
 b=EVDsoZUcZDhx3zI0WQXO6s1+eYmonjaYKithBUZed4h/Jxx9sN7pXOd8BBJVm/GEi5/ra096nN9Des2XQiYxxMKBorZRjN+jq2K24VF7cQSnoQ1fyknPNRu5GYSrB9qzUnswEwE0TWDXvqVqZLuoMVZ+FvjR841hdDFRjOTIKUnpnOTv5JDCwgBlcJZ13i7tk4Jhmj/V94Eka/Q6Zrlutl9qrx3rApu4fuKLK+jU64NJH7Dhv5XE3zwr6H068wvnY/aF5XPwoFcKmgWNrpLdsaqNgflI+sDBGHsAPT/D1cyunL1Bc8Xt7FUxHENFBZlnoXQEL1+i3OicMWu/mfMumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQuAsiJo2tQdPm7/duQnBsVjcnMsCL91T4CCIddrhhU=;
 b=Lsc+pPsg6b8vKbywmXE3qhSk+npWfpR+F93UeJtuh5Lj8/ENCng1Uspa+l1eiT1KmUun6bQ+smUosPs6y9hfPy9zKpjtakFtKD3o/N1cCufHlgDSuoqjHkVvxQZvadX3FyrqbFjZRVG7PopjTGLyz4eD7AeczhgL54CRVMQ8TTs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 12:20:47 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 12:20:47 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: init debugfs drm driver callback
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, shashank.sharma@amd.com
References: <20211005115856.59649-1-nirmoy.das@amd.com>
 <015bf2cf-f085-0d55-17e2-f9583e0533ec@gmail.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <0e7ba8b4-9a66-6664-83af-839072458d7a@amd.com>
Date: Tue, 5 Oct 2021 14:20:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <015bf2cf-f085-0d55-17e2-f9583e0533ec@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:20b:6e::39) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f22:7600:b5bd:631d:2ddc:3835]
 (2003:c5:8f22:7600:b5bd:631d:2ddc:3835) by
 AM6PR02CA0026.eurprd02.prod.outlook.com (2603:10a6:20b:6e::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.16 via Frontend Transport; Tue, 5 Oct 2021 12:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2335efc5-0fcf-46d9-b639-08d987fa8fdb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB531100AF63DFD85D38A04E348BAF9@DM4PR12MB5311.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:203;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fm1HAkv+srZKN85Ey/FHWAk6OVxEuPP+RUEaO1FPrB2QlhLiNrDbTFVOPsRIhd7A5vb+t1eHloAvurHd/3V82KL5nOPtEELV7BB7FsKzBW3sKQxTA3jMktV7Ulob7dc10gc6jaLrV/005LPccX+iGwvnV/B+V095QHi6GfUJaxst9WdbjpNOTAqfWfG4dd1QFltzhVsWAuW2onfDZtrM3IrzUjVcPMMqcEWVN88o6lbJ1Gt4OTXKkDjCV/M3CtKbRp6DEnl35lYpxKHib9Gn8Ze7gtTFR0e49sqeXr/vxP9en9hTHc1Gt4i6u/zNCdhpTyLk9S+4EK7kPw8arpWhhAWbC8lxb554nasAPU7q9qZTa4I5sSt4Jj0qrlhFBQN3bvRuswNpCPOe6V1pXCrVxfoyc5pwjDC+Jk3lWC7Ou6Ix0yADQgsyG7kFA0LpeFliDSfVf519v4LHOzYUKfsvWjqanD//6lrz76ePZsUHbSiTjo+6NPvmJmZAblHfekS1g7FAxEgg1X19nk+FCuK6Y2a0yZN2+lAxPwBlhheCTz1NReEOe73ivwCBpw44uv6I1uQ7kwRjmqposXYERuHfdVgT/kGElOkAoLj2gBdyrPRjY1A6N4APIHrsc3T6rgaYocRRaSJpSRz/5M3UIsXYoC0vDrGljdpNH2VvZoSeoZybL5ORqjJ4O6KXyVg/4wBTJeY5O8JjmJAO9tZfUM0pEIFx5bMhD6BfUoR0SAzPdeY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52116002)(36756003)(38100700002)(8676002)(186003)(2906002)(6666004)(86362001)(966005)(31696002)(31686004)(66556008)(53546011)(66946007)(66476007)(508600001)(4326008)(5660300002)(316002)(2616005)(83380400001)(66574015)(8936002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUhSTHM2NVptRG1qZ1NYcEltWW5pK3hvNWRQcmovbzNmTWdkNkZmYkEvaWNF?=
 =?utf-8?B?QlJOMitxczd4WEQ1OXJ5a09iR1ozMjRJQ3hkN0F2TXlvdDJPSERVOWY4SUJ4?=
 =?utf-8?B?OW5LUlpPMk0wSmdrWUVacVB3QTRJMGpFOHlFVk15enNpZ05BcFJ4YzRsOWJI?=
 =?utf-8?B?dENLMXFpZ1d0dGRlVlhZZm9EeHh5OENERURjdW1yWnhjL1liS0hEc0RLMitV?=
 =?utf-8?B?elgxcGJmMUFPcHJwMHcxSVBmaUtZMGZMWTFXQUoxWUJtZW0wUlV6WHpwQTFB?=
 =?utf-8?B?S0FNS2VBRjI0cjFDdGgydUpPMUlSdG02UURyYVl0bnJEOVpRQVJuZExIYmJ6?=
 =?utf-8?B?U0xZZ0FxUk9KSWY5bytrUkRwaUVkRWp5dEsveHRreHB5MlR2QUdkMzFYYUIw?=
 =?utf-8?B?TVM2ZWFKUEwwY0loWVBVME0vZU8waWovWFhLZWFFNDhKWlBXWWdyQzJFeGpk?=
 =?utf-8?B?Y1ZXcWhFQVdFczd0VjdiOXFvTjBGSU9YdGVOTG9tRS94RVNUMUFQN1dZK3l2?=
 =?utf-8?B?NTBaekRUdU84Z0FCNFE4NXl4OFUycmI4dWNVQi9PVkpOdzkrRmJPR0I4Zk9Y?=
 =?utf-8?B?M2FpTk9VZ0h2Si9rNjZSRGxEN1ZLNENTTFpvMGJvc205Wk8vdUJKcVE2TDlK?=
 =?utf-8?B?TFFYa1BxOUprTVNVTUJQQXdJam11ZGQyK0JlUjY3Ymdpc0cyRk4wdjhQNU51?=
 =?utf-8?B?YXBScEI0Qk1QeW9MYVJuaDNXUW4yQlM2RFM3cWtHSGNpdGhtMEFXNXdNT2da?=
 =?utf-8?B?NVR4QTFMaUJ2MjJhaGhWL1hYTGduZVg0T0tEUnZPSVFEZFhBR050eXJLdith?=
 =?utf-8?B?NS9WSVZnUFFSSmE5SFd0WG5PQXZFZmF6YStmV0lybnk5RXk4Rmd2bWtxZ0c3?=
 =?utf-8?B?VHNmMk5yeEpaVFdvTW5Yek5YWStWSytwZnRUOGc0OHA4VXdKRU5vb3J4RTJl?=
 =?utf-8?B?TExXT2RVK016RGplWmxFaHRxQ2FYN0tqQ1NqMnNBRXNxMWI2V25JYWZiemZw?=
 =?utf-8?B?eTA0bE1IZU51TVo3NHl0SEdGTEVXb1BPeGtub25vazhMdGwyaFVjUjFzVEU3?=
 =?utf-8?B?NTc0TDUvTmh2L3FSU1VmZHF3ZnhUdHQzVlFqMHNYTFVMenlOeG9WWUxyY2FS?=
 =?utf-8?B?WEVRVi9ZOVJ2aXUxN0hTdmJ5aFBCeWhIMkZEVmlXamFibWdYZUx5aXFXKzJa?=
 =?utf-8?B?djJFMDNqaTdma0VobUFITG5ZS0l2K2xSQUZyYzFIMitBRk5uaWs5UWN5L0kw?=
 =?utf-8?B?eThWSExBZFg5UnJWTHlya3p4ZlJNZDBtRUg4WWl4QUk4RmVFQzArNC9XM282?=
 =?utf-8?B?Q0hualdHaGpMMlNNRHo4UWVSbGExOVNYcmpDNjZUTFJ0alJDS1dMaFI2aEpw?=
 =?utf-8?B?MEl1N1l5YTdRVE1Mdk5kakhZMEZkZG0ydTlyYk9SRGJOeW9mMitib0ttRkdW?=
 =?utf-8?B?RnRQSVlkYTc5NkdYT2hWdExxNnFuNElWTUxkYmlIU1VJMjYwM1dDWGRaZnps?=
 =?utf-8?B?RnZmc1FKbmdZZkRoZG9zZm5kU0hQNis2M2xYS2p5M05SdDFvM0dZUWRBNUYy?=
 =?utf-8?B?V1ltMll1TkxJdnd0akdnaGtNdm1yYkQ2Qm5QUU1xemJCclArWmFGbkZwK29r?=
 =?utf-8?B?SW9EL0ZWQ0dHMy85dUVPSHRhMHJ3a01YOElrZk8rcmxjTVdudFJCMDZocXFs?=
 =?utf-8?B?enc0cmdCdjdyOVVlMlRBeU5WaWVTVktkc2J5K3hib3FhTkFBTTRiK01wZEh5?=
 =?utf-8?B?U3RlcjdyQkdaM3J2ZDBDRzhQWXdhWVE1a0NYYkNzMDN1NFhONmdta0pQeVRi?=
 =?utf-8?B?Y2JNUHAxRUpIbUhrLzNOL25rMnNUZi9aWVZxRlNHeSsyNTIxaC9BQ2w0UXU1?=
 =?utf-8?Q?bE06qZStPTzEH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2335efc5-0fcf-46d9-b639-08d987fa8fdb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 12:20:47.5855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44X76eXSGvDvcweXXS/PXg7w4QghUohQcoR41ONm7+zS3Cnx3JcwHOnPjNvKNdLSzxyzbzQ8GLPLCKgAe0OHZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311
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

Hi Christian,

On 10/5/2021 2:01 PM, Christian König wrote:
> Am 05.10.21 um 13:58 schrieb Nirmoy Das:
>> drm_dev_register() will try to init driver's debugfs using
>> drm_driver.debugfs_init call back function. Use that callback
>> also for amdgpu to intialize debugfs.
>
> Mhm, why is that useful? We rather wanted to get rid of all this DRM 
> midlayering.


Actually main issue I am trying to solve is:

When user disables debugfs with CONFIG_DEBUG_FS_ALLOW_NONE, amdgpu gets 
EPERM and throws a DRM_ERROR even though it is not an error as this is 
user controllable.

Shall I just make all debugfs error logs to DRM_WARN ?

ref: https://gitlab.freedesktop.org/drm/amd/-/issues/1686#note_1052168

Regards,

Nirmoy

>
> Christian.
>
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 +++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  7 +++----
>>   3 files changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 6611b3c7c149..3076742f8f85 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1611,8 +1611,9 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>>               amdgpu_debugfs_sclk_set, "%llu\n");
>>   -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>   {
>> +    struct amdgpu_device *adev = drm_to_adev(minor->dev);
>>       struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
>>       struct dentry *ent;
>>       int r, i;
>> @@ -1621,14 +1622,14 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>                     &fops_ib_preempt);
>>       if (IS_ERR(ent)) {
>>           DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs 
>> file\n");
>> -        return PTR_ERR(ent);
>> +        return;
>>       }
>>         ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
>>                     &fops_sclk_set);
>>       if (IS_ERR(ent)) {
>>           DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
>> -        return PTR_ERR(ent);
>> +        return;
>>       }
>>         /* Register debugfs entries for amdgpu_ttm */
>> @@ -1682,11 +1683,10 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       debugfs_create_blob("amdgpu_discovery", 0444, root,
>>                   &adev->debugfs_discovery_blob);
>>   -    return 0;
>>   }
>>     #else
>> -int amdgpu_debugfs_init(struct amdgpu_device *adev)
>> +void amdgpu_debugfs_init(struct drm_minor *minor)
>>   {
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> index 371a6f0deb29..06b68e16e35d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> @@ -27,7 +27,7 @@
>>    */
>>     int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
>> -int amdgpu_debugfs_init(struct amdgpu_device *adev);
>> +void amdgpu_debugfs_init(struct drm_minor *minor);
>>   void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
>>   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index df83b1f438b6..ceda650895db 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2012,10 +2012,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>               drm_fbdev_generic_setup(adev_to_drm(adev), 32);
>>       }
>>   -    ret = amdgpu_debugfs_init(adev);
>> -    if (ret)
>> -        DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
>> -
>>       return 0;
>>     err_pci:
>> @@ -2479,6 +2475,9 @@ static const struct drm_driver 
>> amdgpu_kms_driver = {
>>       .dumb_map_offset = amdgpu_mode_dumb_mmap,
>>       .fops = &amdgpu_driver_kms_fops,
>>       .release = &amdgpu_driver_release_kms,
>> +#if defined(CONFIG_DEBUG_FS)
>> +    .debugfs_init = amdgpu_debugfs_init,
>> +#endif
>>         .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>>       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>
