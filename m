Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB8CC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Apr 2024 17:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C330D10F0D8;
	Fri, 12 Apr 2024 17:05:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xhgod0S2";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD82210F0A4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Apr 2024 17:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5IaS7vBT+oANedbD5E6Uc57vDGMbyKxEFYNwUrmsovZWr8DdrZOUYDOgUIuGusIrCY/hXrc02MpHIR6jAXxEzcLB90PA/E1TzXMaZRDuKWf9gTO1qjIT/lnj9Y7GonJddVSJRfZX6lbU2mhSamR8DzccQSolGMbdz9HNvVzaTlHmoJb5bdw2vac1Zll+34lGWQ03uBQFu0h3DFMArTbK7EfL+mxKrIdC+arhoybcG+czxT3RmlSeA9PFnf+cd3M4AKiz1EAlGwcKiCSqRBqVuANmV9OliIYxZRvPHAbThtYAwfYo9+7VunmXo/hicYKi7u4uORlQPbs8NDgSY1wqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4a81MGKk8wWY48sX0OKK/i6Sw68uTBnYhtyOMR5sA8=;
 b=G0USKVgvtiDjPkFj38LrF08ZGdMC2w7+6ncP/r3YGOxCLBKqsxpqj9W2QFD3KHAjMBBdrklkAfyK4O3cZXTMJ335LAdIJ8dCJwsrUC8UtNEXWkos4M+mb22RP21TB0U9xPsftgmrXu+UdCLwRCyBcj7epnBiTVcpr0d1pzCot5K7qZL6VZKGr6uG6wDgRMUjyJJ1XmdEDi5aQjpPmf68NthD+m/0RcOhskormuz/oksBQB2iYbB/vlKklohtbX9lF5mKPzR7LNXtNODTAezKEcVU2WAQnkTSwzTk5SFcNlXGUq7YdUOVJGjlrOldrUXqPQUkeIKX1Evos6i07gBd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4a81MGKk8wWY48sX0OKK/i6Sw68uTBnYhtyOMR5sA8=;
 b=xhgod0S2wvDkW1zmq/q2niwwRw0C/vINVKYp6DN/gQt2x5gyMXps/I5FJ9OsprsM+locbh3nmbLkK2wePaC2UpPSUWWtacWaOTQU1bya4Ik4mtqqZUQVzyajcZQj+nr+cx5xO3FQiVmVHeGnCyNmn1PkXJbYsoW/2ns7TSiX0oE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by SJ2PR12MB8808.namprd12.prod.outlook.com (2603:10b6:a03:4d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 17:05:04 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 17:05:04 +0000
Message-ID: <f7e75379-34eb-4733-b489-c76a2fb8f26e@amd.com>
Date: Fri, 12 Apr 2024 22:34:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add support of gfx10 register dump
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240412140034.65565-1-sunil.khatri@amd.com>
 <20240412140034.65565-2-sunil.khatri@amd.com>
 <CADnq5_OY3Kkad2JQz99qRVX3Xh4tk4CBvGPC2FYu4RmQ9yXORg@mail.gmail.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <CADnq5_OY3Kkad2JQz99qRVX3Xh4tk4CBvGPC2FYu4RmQ9yXORg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN0PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::22) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|SJ2PR12MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 14eae61f-43a9-459a-8f6c-08dc5b12b23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hugTUoiO7kNpT7PKrtbJxbKQgGudur2DUUllS+QMpUNo+HCgbfULcODPixG20EuakMc9bbrlfEIe6B0XAKh1DOvevGe1Cvwl21qDhlKqOjqcwCQE3ZTfLxQ5bOysKqI5uiPuH63K9uN0YKOLlzgbIUQw8V/MQlR//tu4rtiDR1r/gP9i+s8b3GTtXCKz11QcGiztWtxgeP4XQqb55BKGEhphNv5Uj2GGTFCy9Eb3YahaLtixBos2gmpihw2GkuM77aGYgNLz3wg+A0E+y8F+JcDyKdm6qjuY0ow0K0djWMVJeR6Pq+ciPak7+rOvggqOQlLEGxlEx2m4+ulB9KGSPAoTh6FBYGzoQOe3dvYAVQgy8T4sAUHAPm01Z2AAmRIpeYk7EnH2Vj9XOnQlondvimsYEwVEMSevrw/cdkkOrS2hvmM56rX/eomCqsmgtLjJiBRF2SXsvSN6AEhLcEiypchbCtH61p6jRpwFeLZi2QXClxrI/H75yxj12yrj/3/kf82dk59nJscLZps7mtWOSqXVwn1jZghvxkvyoTi/9roRk6u6jHfdLEO0LW50W+xr6mB6Ka1vHQZpgmwwZHc6pSkQrTlIzH1/K+8Pg2mmD/+tKCTs3fGeeu/8VH5Iu0/XUKOPhW0sq3SGvj9TvY2LSM+1t9uTJVIGcabwB+AXDkM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi83NWVjR3JNSllxZzBNZ25VQ0xaMktNTkYwUUdVaHpWejFWd3ZybGM0OW40?=
 =?utf-8?B?c0xnejRBSEhiTjhGMENKK2c4MDFLd1YzVFEwZ0VuejAySjFrOFVyeHZkdkMr?=
 =?utf-8?B?UjVpNW1Id0N0UFYzUDV1d0xIVUFPNmNLNUI4WVRlT29ydFloeU10OWZhTHBG?=
 =?utf-8?B?RkNPVjVqcDhrVTQ4c0ZPZWRDellTd0hLdVJaWE1oT0hLRW9sZlBpU3djWndl?=
 =?utf-8?B?SkFCMTJCQm9DWE1vWlh2dlRhOHFoK0Y4eU8vM0dtaEt4V3E1NnVkY2xrV2Ev?=
 =?utf-8?B?SHg4YitsQmFWY01RSlpWbFBoR2JqUzFXWGNieFMzWlQyUVIvRngvNzAxbkdV?=
 =?utf-8?B?ZFNreWN2S2IwbGtPbytXdEdKZEtxSjZJWTRPWkt2RVoyL1JrTkw5aVpmUTNY?=
 =?utf-8?B?SjNSRUhkcDAzWWxMUm9iVWw1ZDJLa0x5d29BMXk4cnMrRnVzSDM1Mjc5U2Zw?=
 =?utf-8?B?WEo0S1RuRW5aYVlHb0E4cVdFa1g3VnF0MFpTTnE4OWJHdHBVQ3hRNVBoYlNr?=
 =?utf-8?B?VWVFNjN5RTJjU0pEQlAzQUlHa1BrZ3c4RHR1c2dmS08vcWJVSEhRQzVvUkxU?=
 =?utf-8?B?RmF4S3dyV2dRUEw1akhIZVJPWWRrWnZYRG1odGNTaW9UQmJ0Y0RoUzdaR1ls?=
 =?utf-8?B?K0o1Z0VhNTNaOXpTdDVBQXUvUVcyYXQ1RUF2MklkZGhYNWNJOGppanhjcC8z?=
 =?utf-8?B?UnVkaW9VM1Y0dEphU3lOQSswUG9sVjJYeFpSbndRL2JISjEzbFltcSs3TEx3?=
 =?utf-8?B?djVaVFdySW1uNE9rUlFIV09UaVMzY2d0emlsYTRiWndYSmN2a2xib2t6NWg4?=
 =?utf-8?B?ZDhEV3NaSVlTZEJWckoxUE9xeHJVNnMxcWhkbmZSbkJlbWJITVVMbm4wbHZ5?=
 =?utf-8?B?Z3cvcUpRcFc2ZmxMM2cvQjN2T28vcklRckVDazZEMS9EQ1lmTG1LcGpkMVU0?=
 =?utf-8?B?QUYrZUtDdktXMlIxR21pTWcwL3pjWHZuem8rS1VJQ2ZNcVMySHJ2Z3I3YWRY?=
 =?utf-8?B?UmF5UTY5aXB3eXQxdEhINUk5Wmc0UUlPQnRHV2doem1tOVk3LzduYk1FblpQ?=
 =?utf-8?B?UjRjbGNnbVNVOVRjYW5pUFg5cEpSVnpjSmljZXJGdURmVHZ0UGp5MWQ3czA0?=
 =?utf-8?B?VCtGdU0vSHc0NGNIbE1GTGY4OGNXTTNiZXF4eWhRQ1RhY1JkOWpUdTM0QnNq?=
 =?utf-8?B?R1JxcTd2SWs3S3ZqYmFmOTZqZGYyZmVxc1RSVC9UMGlJMGhIaC9qalhFRWJY?=
 =?utf-8?B?OFVNNllISmY1YnhqUGNiS3RZUHdLYWVrSFMwaVRMMUgxditqVmVUTTV3Mkpr?=
 =?utf-8?B?QTZ6ZmM3NnMya0l2alFmWjdMcDJoT1ZvWUVIckNvZXhablZvdHlHTHZmM1lo?=
 =?utf-8?B?U1BsVFBKTkhZVE1YRm93a3I3OEUxbDY3ZlBxaXNoQUwvc1BYQkFzMjJCUFdN?=
 =?utf-8?B?ZWk4T2dUbmJzZ3RxWWQ1MllXYWZ5dWthc29VSHRGSUJPajI1L3hKSHp4dkp0?=
 =?utf-8?B?dUdkYjNsTjlVWUYxNThGTTJJend6VHliMXdGcGpWcG9aTlovOHg0SFZkTkxT?=
 =?utf-8?B?RVdqNFhKc1N3cmk5ZStaWnpDTksyRk50U20vcm5aWHdkYnlLekl5WWtsa285?=
 =?utf-8?B?aEZ5RWtZQytUNncvSnAvYUxpMXpWa05HZmJEbGNSQXd5VHJDd1JIY2FPcVEr?=
 =?utf-8?B?REpPSDhVaTBHK2h5Y0JmR1B0S2xkQVVXcDUxaXVwbnFhWjFpWVFaUldQeFRn?=
 =?utf-8?B?YTE0bzFRUjlGc3d0dnRjalZDaEFXTmNCTDB0YkVnUm9YVCtiMHMzRGdBWnZY?=
 =?utf-8?B?eE16VDl2c3FSL3piZFpYOEViSGJuSW1meTZkZHlMNEF1MVUySXRPSUNITkJX?=
 =?utf-8?B?ZGxsdU1LMTR6NXd4dlloMC91MTNmSmNOczU4WHN3NHFwem9Jem01aHFTQjBD?=
 =?utf-8?B?NnpGSXBNSFdMS2E5Z2dZODVIcWUrSWN0Sm8zQ2FidFJMdFQzVVNOUnVLU0Np?=
 =?utf-8?B?MjZSSXJRR2xxMG5HaTIvdmI0eW8rems1Rms4ODUrL3VMTzJnS2kyTDgwTXpp?=
 =?utf-8?B?WW9wcEtUeTk3K2pJcEVHY01aU2E3UGRWRnIza0FjSWU4MFpOY01IOC9tSDl6?=
 =?utf-8?Q?XkBwPWJOr8at648vmiglUncXN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14eae61f-43a9-459a-8f6c-08dc5b12b23e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:05:03.9252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tjy5CXPexDGmUDA31oC9VxNEgBGd3Je9xh1owEqeIC4VKJJuOjdXkkcUKVID3QeA4t3Nf+Z1bgi71lA1UF1HhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8808
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


On 4/12/2024 8:50 PM, Alex Deucher wrote:
> On Fri, Apr 12, 2024 at 10:00 AM Sunil Khatri <sunil.khatri@amd.com> wrote:
>> Adding initial set of registers for ipdump during
>> devcoredump starting with gfx10 gc registers.
>>
>> ip dump is triggered when gpu reset happens via
>> devcoredump and the memory is allocated by each
>> ip and is freed once the dump is complete by
>> devcoredump.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  16 +++
>>   .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  22 +++
> I would split this into two patches, one to add the core
> infrastructure in devcoredump and one to add gfx10 support.  The core
> support could be squashed into patch 1 as well.
Sure
>
>
>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 127 +++++++++++++++++-
>>   .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>>   4 files changed, 176 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 65c17c59c152..e173ad86a241 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -139,6 +139,18 @@ enum amdgpu_ss {
>>          AMDGPU_SS_DRV_UNLOAD
>>   };
>>
>> +struct hwip_reg_entry {
>> +       u32     hwip;
>> +       u32     inst;
>> +       u32     seg;
>> +       u32     reg_offset;
>> +};
>> +
>> +struct reg_pair {
>> +       u32     offset;
>> +       u32     value;
>> +};
>> +
>>   struct amdgpu_watchdog_timer {
>>          bool timeout_fatal_disable;
>>          uint32_t period; /* maxCycles = (1 << period), the number of cycles before a timeout */
>> @@ -1152,6 +1164,10 @@ struct amdgpu_device {
>>          bool                            debug_largebar;
>>          bool                            debug_disable_soft_recovery;
>>          bool                            debug_use_vram_fw_buf;
>> +
>> +       /* IP register dump */
>> +       struct reg_pair                 *ip_dump;
>> +       uint32_t                        num_regs;
>>   };
>>
>>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> index 1129e5e5fb42..2079f67c9fac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> @@ -261,6 +261,18 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>>          drm_printf(&p, "Faulty page starting at address: 0x%016llx\n", fault_info->addr);
>>          drm_printf(&p, "Protection fault status register: 0x%x\n\n", fault_info->status);
>>
>> +       /* Add IP dump for each ip */
>> +       if (coredump->adev->ip_dump != NULL) {
>> +               struct reg_pair *pair;
>> +
>> +               pair = (struct reg_pair *)coredump->adev->ip_dump;
>> +               drm_printf(&p, "IP register dump\n");
>> +               drm_printf(&p, "Offset \t Value\n");
>> +               for (int i = 0; i < coredump->adev->num_regs; i++)
>> +                       drm_printf(&p, "0x%04x \t 0x%08x\n", pair[i].offset, pair[i].value);
>> +               drm_printf(&p, "\n");
>> +       }
>> +
>>          /* Add ring buffer information */
>>          drm_printf(&p, "Ring buffer information\n");
>>          for (int i = 0; i < coredump->adev->num_rings; i++) {
>> @@ -299,6 +311,11 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
>>
>>   static void amdgpu_devcoredump_free(void *data)
>>   {
>> +       struct amdgpu_coredump_info *temp = data;
>> +
>> +       kfree(temp->adev->ip_dump);
>> +       temp->adev->ip_dump = NULL;
>> +       temp->adev->num_regs = 0;
>>          kfree(data);
>>   }
>>
>> @@ -337,6 +354,11 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>>
>>          coredump->adev = adev;
>>
>> +       /* Trigger ip dump here to capture the value of registers */
>> +       for (int i = 0; i < adev->num_ip_blocks; i++)
>> +               if (adev->ip_blocks[i].version->funcs->dump_ip_state)
>> +                       adev->ip_blocks[i].version->funcs->dump_ip_state((void *)adev);
>> +
> This seems too complicated. I think it would be easier to
This is how all other per IP functions are called. What do you suggest ?
>
>>          ktime_get_ts64(&coredump->reset_time);
>>
>>          dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index a0bc4196ff8b..66e2915a8b4d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>>   MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>>
>> +static const struct hwip_reg_entry gc_reg_list_10_1[] = {
>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
>> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
>> +};
>> +
>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00400014),
>>          SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0xf8000100),
>> @@ -9154,6 +9247,38 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_ring *ring)
>>          amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>>   }
>>
>> +static void gfx_v10_ip_dump(void *handle)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> +       uint32_t reg_count = ARRAY_SIZE(gc_reg_list_10_1);
>> +       struct reg_pair *ptr, *gfx10_pair;
>> +       uint32_t new_count;
>> +
>> +       /*
>> +        * Allocate memory based on the no of registers for each block.
>> +        * Since adev->ip_dump is common pointer and we add more
>> +        * memory to it as we move through different IP's of the ASIC.
>> +        *
>> +        * This memory needs to be freed after gpu reset once the ip
>> +        * dump is done in the devcoredump.
>> +        */
>> +       new_count = adev->num_regs + reg_count;
>> +       ptr = krealloc_array(adev->ip_dump, new_count, sizeof(struct reg_pair), GFP_KERNEL);
>> +       if (ptr) {
>> +               adev->ip_dump = ptr;
>> +               gfx10_pair = &ptr[adev->num_regs];
>> +               adev->num_regs = new_count;
>> +       } else {
>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
>> +               return;
>> +       }
>> +
>> +       for (uint32_t i = 0; i < reg_count; i++) {
> Some compilers don't like variables defined within code.

Sure


>
>> +               gfx10_pair[i].offset = gc_reg_list_10_1[i].reg_offset;
>> +               gfx10_pair[i].value = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
>> +       }
>> +}
> This seems too complicated.  Just pass drm_printer to the ip_dump
> callbacks and let each IP dump their state directly.  E.g.,
>
>         for (i = 0; i < adev->num_ip_blocks; i++) {
>                 if (adev->ip_blocks[i].version->funcs->dump_ip_state) {
>                         drm_printf(&p, "$s IP state\n",
> adev->ip_blocks[i].version->funcs->name);
>
> adev->ip_blocks[i].version->funcs->dump_ip_state((void *)adev, &p);
>                }
>         }

I did try this but there is a problem in that approach. drm_printer is 
created on the buffer which is provided by "amdgpu_devcoredump_read" and 
"amdgpu_devcoredump_read" is only called when the user opens the file

cat /sys/class/devcoredump/devcd1/data and by that time gpu is reset and 
registers dont hold the value of interest. I tried this approach first 
and got all FFFF or reset values of the registers.
We need to capture the values in "amdgpu_coredump" which is immediately 
called after GPU reset and values are what we need for debugging.

Crux is we need to capture data after gpu reset but read depends on when 
user open the file which is too late and hence we need to capture all 
the data in advance immediately after reset before recovery.

Regards

Sunil Khatri

>
> Alex
>
>> +
>>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>          .name = "gfx_v10_0",
>>          .early_init = gfx_v10_0_early_init,
>> @@ -9170,7 +9295,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>>          .set_clockgating_state = gfx_v10_0_set_clockgating_state,
>>          .set_powergating_state = gfx_v10_0_set_powergating_state,
>>          .get_clockgating_state = gfx_v10_0_get_clockgating_state,
>> -       .dump_ip_state = NULL,
>> +       .dump_ip_state = gfx_v10_ip_dump,
>>   };
>>
>>   static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
>> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> index 4908044f7409..4c8e7fdb6976 100644
>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
>> @@ -4830,6 +4830,8 @@
>>   #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                                                        0
>>   #define mmGB_EDC_MODE                                                                                  0x1e1e
>>   #define mmGB_EDC_MODE_BASE_IDX                                                                         0
>> +#define mmCP_DEBUG                                                                                     0x1e1f
>> +#define mmCP_DEBUG_BASE_IDX                                                                            0
>>   #define mmCP_FETCHER_SOURCE                                                                            0x1e22
>>   #define mmCP_FETCHER_SOURCE_BASE_IDX                                                                   0
>>   #define mmCP_PQ_WPTR_POLL_CNTL                                                                         0x1e23
>> @@ -7778,6 +7780,8 @@
>>   #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                                                            1
>>   #define mmCP_MES_DOORBELL_CONTROL6                                                                     0x2841
>>   #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                                                            1
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                            0x2842
>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                   1
>>   #define mmCP_MES_GP0_LO                                                                                0x2843
>>   #define mmCP_MES_GP0_LO_BASE_IDX                                                                       1
>>   #define mmCP_MES_GP0_HI                                                                                0x2844
>> @@ -9332,10 +9336,16 @@
>>   #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                                                  1
>>   #define mmRLC_LB_CNTR_1                                                                                0x4c1c
>>   #define mmRLC_LB_CNTR_1_BASE_IDX                                                                       1
>> +#define mmRLC_GPM_DEBUG_INST_ADDR                                                                      0x4c1d
>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                                                             1
>>   #define mmRLC_JUMP_TABLE_RESTORE                                                                       0x4c1e
>>   #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                                                              1
>>   #define mmRLC_PG_DELAY_2                                                                               0x4c1f
>>   #define mmRLC_PG_DELAY_2_BASE_IDX                                                                      1
>> +#define mmRLC_GPM_DEBUG_INST_A                                                                         0x4c22
>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                                                1
>> +#define mmRLC_GPM_DEBUG_INST_B                                                                         0x4c23
>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                                                1
>>   #define mmRLC_GPU_CLOCK_COUNT_LSB                                                                      0x4c24
>>   #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                                                             1
>>   #define mmRLC_GPU_CLOCK_COUNT_MSB                                                                      0x4c25
>> @@ -9720,6 +9730,8 @@
>>   #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                                                           1
>>   #define mmRLC_LB_CNTR_2                                                                                0x4de7
>>   #define mmRLC_LB_CNTR_2_BASE_IDX                                                                       1
>> +#define mmRLC_LX6_CORE_PDEBUG_INST                                                                     0x4deb
>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                                                            1
>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                                                  0x4df1
>>   #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                                                         1
>>   #define mmRLC_CPAXI_DOORBELL_MON_STAT                                                                  0x4df2
>> --
>> 2.34.1
>>
