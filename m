Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3C1C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 21:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFA410E11E;
	Fri, 11 Aug 2023 21:13:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E6310E11E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 21:13:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCP3fjGTIFtHG1ZIOybGKooIrtGLc41Q6+oQVS0ieL2YZOYCEOUCBLyLq4YalVjYVusL9KG0CNppQHTSrbr/H9ZGFTbVdXZ3iEI8wtVwEpFL49hun5kEDnhfhlgWOF1t2Woe+4xhbxq0BEPnG63ycm1MjYmN3+jYL8csQuDNra4lIdEiiY+sRqUx9qbWBW0dUgmvlwWKC5P9bj+7IRGFP1i+vRDJwYU9DS3tx8CoFK59TBb3RRMEjdLt7b7Z6hfDBHKw3MMJ66cuzZYmdDnc9xgcQ9aa5d5uoDrFEH6kAwL3jRER1wsTsnAT/RtwP37iEsysHi4B7iEYjwS50ryTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVfUYIQo9S7Tact3DtvzQVktZurXPiGOHMfzfZNoSHU=;
 b=VAkQFB2FdRK4Kk9drAjzoWAtuhfBPZ8fZXrtspyb6tiQXsyWAx7z5RvrrmhyUOKWS4v27FijipBgnQxGYgStpjJsh0ZdCntH1uEAmHHdolQnRj0TmRnjnOEUUf27mdDCClmXIiCs4i+pyELqvM2ChKf/o0DqHi5KYz7CV4m5LxyHQliBLQY8hzqXRXQ0itxdkFMIvwjqZpCvtTRKbcSV3q1Vmro9YBA4I/a9g45O5mbD+sskH4WBEFg/vlwhhRvU6iP//3ZUXr+6p5SqiZFOevACLC0+mK8k2hlItizgxT4237kETLEKhruvsPAq5DB7JqdUmodgibIf8mz2S6+4bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVfUYIQo9S7Tact3DtvzQVktZurXPiGOHMfzfZNoSHU=;
 b=wuB0zc7Mk3SOpXcKlG7hr+/cC2RdGq9UIRUYuLIq9j6WBc1R0lwubSShupBsfjFtCKLXQ8qexuxckXPiem/49bR2cz47ZBfiFRi+a9mVLptqdD/99M+t7GgcssBgw2+814YcDgI6Sq7L5YVVd9CQNgBNVLl9AfLueIuChIc3dmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 21:13:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 21:13:53 +0000
Message-ID: <c240cec7-d391-60fb-1530-2f81089214d3@amd.com>
Date: Fri, 11 Aug 2023 17:13:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <41b68fb8-378d-6f6d-c653-d6c2b106d8d3@amd.com>
 <b93161c3-3f90-d6b0-6c89-2cbd8e2e75f8@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <b93161c3-3f90-d6b0-6c89-2cbd8e2e75f8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: c44e17e5-29c4-45cf-0b95-08db9aafdd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KV3PbWlgM40o8WFoA3ak2T525ezexSP1lrQ/xQThumLk0qwY7ZtevbId2yd6smRx4koTLlrjYwFSRB09o3jEwFVsnuqM+O+on7/KwtPIq2M9YjUb2x/nNHOYLkVPaU1ocr3oBWNZg8CVZ6diJEsX1LF/d1/X8bkUdHauk1RIPEb/3DyCKqYAqMzTXu3j6KQcpg2HLJSmMVQbG96BJqzOuV+FbmkTG92fn2LjwyqBp1a9u/RyisHU7Vx+0fjlsdv+zu++DiPq0Ho72QAEvd5kfdpEicv/JVtowb9rNWaS1FmE/qnEFsecnukpooKgw+pGphGhuR3uQuH8gD+qBhXafQ/qO93GPlWiqqf2Wop2r8mgEtd3doLb8dgLAQHRnOD55e32JUJE40qN6KY399Ye7FBVuaag22kSvOt7NdhQ/FEcGiTYDHqeaLmLguZ91zINIrxbrRmay8etQ8VsM7ZYIugUq8UGZmlptkIQENy+2K4t8Obe9QI3I7LPvWf2/mbnuTJkoz8yQx/04JvS7k2fXYOvh7HIHpnECENLr5XHFcvi9dOPCVzh3Sy6HeOptdzYd4jtpx/Ab7Ln9x0xfB1JFk8T0mMmbCJQn/vPF1qaAjax3dUH3V+GpMkliGPIZDJ/J6wAyELwQuXerwuho+WsYCkeLHJlqDqpOkDhmB9kfAJrvAOlw6nR3kqQ7fkiQzhd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(1800799006)(186006)(38100700002)(66556008)(66946007)(66476007)(83380400001)(36756003)(5660300002)(8676002)(110136005)(8936002)(316002)(4326008)(2906002)(6486002)(31696002)(41300700001)(44832011)(86362001)(36916002)(6506007)(53546011)(31686004)(6512007)(478600001)(26005)(2616005)(43740500002)(45980500001)(460985005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmlsY2dxbUYwMzBacXhzbzlUVnhwS0U0MjBYQjFnNytXdGFPWnFwR3VlRmow?=
 =?utf-8?B?UXJwVjNVMEliOTZmZ0sxMlI1alNqVVZSR3JLR3RKa2dDNWRIZmlpWEp4RWE1?=
 =?utf-8?B?cW9MVHZGcWFtOVZOS01SZGpjWjhCTll4VDdjaW5kM0JFZDRFWWFaUEVwdHcv?=
 =?utf-8?B?VmZGOE9hVFZLTEJ3Q1F4RWQzWE8yZ2llVFpuZ3VIajNEVCtPdFkrSGpBK1Rx?=
 =?utf-8?B?T1FuNUZUaHZ4Z3IvZWVPT3RjdGd0YzFPd3VIUElva2w5cXA5bnF6MlNCTkhH?=
 =?utf-8?B?cnd1ZzAxd1k1eWpaM0F3amMwZEEyZlgzcndVaHpEOWFDMWhIa3N1ZVNsMmJj?=
 =?utf-8?B?WHFiODcwd3oyL1dVTEswMVpjUWt0bWtROGpIb3V0WWRXb0NzYldrMVNQL0o4?=
 =?utf-8?B?T0EwN2Ztek92ck1SMTBSTVVPTGdwZVFqNm5vWkVjWVRTMUltOTNCZHJJMzhN?=
 =?utf-8?B?STNBbE5BOHI5SUtyV3ZLRnNKbSt3ejNJZ2k1SzBQb3hJaHlFTjM2ZVZYblhr?=
 =?utf-8?B?TmpNSFJLTDB4MytKZ3BYU0JIS2tGd3hZOUxibnV4bnJFZ1dOZThHakZTbDUv?=
 =?utf-8?B?Q3NlYStKNHR6ME5MaFdzazVSVnQwZHh6UTR1LzA5QWVJbVBWdFMrTUY4K2xQ?=
 =?utf-8?B?NDR3MjBlUlM0MllTbnhzNUdoTlQzVkorK0pabmdHaSsvdjdlUTRMT0NjTVg1?=
 =?utf-8?B?SHJmUkdmR1dEbWdodFdCcEJMbXNjdzB1cW1jcFMxVEpWUEhiWFFPc3d4YTZr?=
 =?utf-8?B?SGFtZVdHODJjOThQVUg4RDh5MitscFluRk9xYTBQQzFuWUJxWWpHem1HeDVY?=
 =?utf-8?B?UE1rNG9GN3J5UUErbys4Y25LMmpXMUdOMndmK2hPZnQ1YlJtNUtnZWhEN3RL?=
 =?utf-8?B?Q09kb1ZVVnA0VVFWZXB5MWo1algzdVg4YVF2eExwU1lvczloZkliSG1GTm9q?=
 =?utf-8?B?MU5ia21WK3dyY0FZdEY3R0Z2SHhHUUpnMEk3aUQ1ZXljeS9JSkRsMGFWdzN0?=
 =?utf-8?B?dVpZaDA4dzRJM29ubWVPaitGM2t0cmV4VVVSZjdNU2IwMjhIZVdhdldPVU5r?=
 =?utf-8?B?UUw2WE9RM2xuWXJvVXNVaHNwanRDSjhpMjFFVE9YT1BuVElzVXNpMDMySjAy?=
 =?utf-8?B?bVBXTzF4YWc5S0VZeHhVNFVCWFNPKzFqNUdZanROdjl5NlNWVWdiZ3V0Z2lr?=
 =?utf-8?B?UjgzNnpydjlRbXZtQ1B2RGZmYUxza3NGeEZnRnJxOXpIb1VuL3F6bHFpOTNH?=
 =?utf-8?B?N0ZsT2w5N2lVWVltamZRRzZhQTZ4VTVtQ0ZHcEpMZktBMHZSZDFmUnErOFk1?=
 =?utf-8?B?WEZ1TE1hT0Z6N1FGazkwVWliNk1maTBxOCt1YXlXeVFNMmx6MWVxcXI0NGtD?=
 =?utf-8?B?MDdGdVNSVWhZdE1uNGo0aDBHSldDdTFwOXpEbFVBdklMLzlKZnlNb0pxMXIx?=
 =?utf-8?B?anJkQUhGK1ErTi9jMmlwbXN4U1AvMnNFNjV0Qmg4aUxrK1hFSlIxUEh5ZG9G?=
 =?utf-8?B?Z0Q2M2VXZG55Qlk2c2RSNGNhT25QZndvUkZkQUZiN202WXZiR3FtZmlkb2tZ?=
 =?utf-8?B?WnFQbjZnQjdYYVBGTVIxTXcwejEwMU1NVlRsWmFOeDlxWGRvWEtDbUZWc1hv?=
 =?utf-8?B?N3JFUTJrOURVT3dWcHU1S3BhSU10ZURQK0JQaFZQOG1TTUw0MkZ0NXU2TmRu?=
 =?utf-8?B?MS9XaXJVc3RTWWIzUEdpTVJHTHA3VlVTNFlpc1lHY1NzMDFPMlByV3o1T01h?=
 =?utf-8?B?c0RFaDA3SmNBT0RRVVRRNWdGNGRSUTVpY2x1UGJySnBMTVJiZGZJaTVxKzY3?=
 =?utf-8?B?ZHVZZldqY0hGczcramtaYWhvNUNlYjYyZEp0Nkc0Vi9MNGtFQlRuUFRUOGtH?=
 =?utf-8?B?b0lNRldhQkdMNEM4TWl0aWJ0OXBrbnJudFcvYXZtVUdEVmtWeG0rSmxRbFFr?=
 =?utf-8?B?Y1NCMkxrUzZBRkZDbmIybnU0QUd5MWJtMzhWRmtEWkxvV05QamRRaWhPS2NE?=
 =?utf-8?B?VEZRd2V1dlhSVG9FK20zaFQzK2pSaXNleFRLL2RMUFJneUFudmtiK3I2aDFO?=
 =?utf-8?B?NjdlNm1LZmsrZnBzVnpVSWlaVTZZZnJJVkpYLzNNS0xzMmllSWR0akFVSEt4?=
 =?utf-8?Q?xRPIwW1uF4KGQddZZt9YCexnV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44e17e5-29c4-45cf-0b95-08db9aafdd9c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 21:13:53.2497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD/54gtMhop7nt58S+Y4oa08koEsdp9uy04hg+zIRGgvPkKvo1E29uTyQ8Nd5xlAw5H9tZqsL8rUl8GrsNYaBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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
Cc: Roger.Madrid@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I don't understand why this loop is causing a stall. These stall 
warnings indicate that there is an RCU grace period that's not making 
progress. That means there must be an RCU read critical section that's 
being blocked. But there is no RCU-read critical section in 
svm_range_set_attr function. You mentioned the mmap-read-lock. But why 
is that causing an issue? Does it trigger any of the conditions listed 
in kernel/Documentation/RCU/stallwarn.rst?

-       A CPU looping in an RCU read-side critical section.
-       A CPU looping with interrupts disabled.
-       A CPU looping with preemption disabled.
-       A CPU looping with bottom halves disabled.

Or is there another thread that has an mmap_write_lock inside an RCU 
read critical section that's getting stalled by the mmap_read_lock?

Regards,
   Felix


On 2023-08-11 16:50, James Zhu wrote:
>
> On 2023-08-11 16:06, Felix Kuehling wrote:
>>
>> On 2023-08-11 15:11, James Zhu wrote:
>>> update_list could be big in list_for_each_entry(prange, 
>>> &update_list, update_list),
>>> mmap_read_lock(mm) is kept hold all the time, adding schedule() can 
>>> remove
>>> RCU stall on CPU for this case.
>>>
>>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>>
>> You're just showing the backtrace here, but not what the problem is. 
>> Can you include more context, e.g. the message that says something 
>> about a stall?
>
> [JZ] I attached more log here, and update in patch later.
>
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: rcu: INFO: rcu_sched 
> self-detected stall on CPU
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: rcu: #01134-....: 
> (59947 ticks this GP) idle=7f6/1/0x4000000000000000 softirq=1735/1735 
> fqs=29977
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: #011(t=60006 jiffies 
> g=3265905 q=15150)
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: rcu: CPU 34: RCU dump 
> cpu stacks:
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: NMI backtrace for cpu 34
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: CPU: 34 PID: 72044 
> Comm: ncsd-it-hip.exe Kdump: loaded Tainted: G           OE 
> 5.14.21-150400.24.46_12.0.83-cray_shasta_c #1 SLE15-SP4 (unreleased)
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: Hardware name: HPE 
> HPE_CRAY_EX235A/HPE CRAY EX235A, BIOS 1.6.2 03-22-2023
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: Call Trace:
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: <IRQ>
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: dump_stack_lvl+0x44/0x5b
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> nmi_cpu_backtrace+0xdd/0xe0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> lapic_can_unplug_cpu+0xa0/0xa0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> nmi_trigger_cpumask_backtrace+0xfd/0x130
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> rcu_dump_cpu_stacks+0x13b/0x180
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> rcu_sched_clock_irq+0x6cb/0x930
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> trigger_load_balance+0x158/0x390
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> scheduler_tick+0xe1/0x290
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> update_process_times+0x8c/0xb0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> tick_sched_handle.isra.21+0x1d/0x60
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> tick_sched_handle.isra.21+0x60/0x60
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> tick_sched_timer+0x67/0x80
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> tick_sched_handle.isra.21+0x60/0x60
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> __hrtimer_run_queues+0xa0/0x2b0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> hrtimer_interrupt+0xe5/0x250
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> __sysvec_apic_timer_interrupt+0x62/0x100
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> sysvec_apic_timer_interrupt+0x4b/0x90
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: </IRQ>
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: <TASK>
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> asm_sysvec_apic_timer_interrupt+0x12/0x20
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: RIP: 
> 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: Code: 00 00 00 bf 00 
> 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 48 8b 14 25 00 bd 01 
> 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 42 2c e8 51 dd 2d e1 48 
> 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: RSP: 
> 0018:ffffc9000ffd7b10 EFLAGS: 00000206
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: RAX: 0000000000000100 
> RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: RDX: ffff88e18ef1ec80 
> RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: RBP: 000000000003062e 
> R08: 000000003042f000 R09: 000000003062efff
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: R10: 0000000000001000 
> R11: ffff88c1ad255000 R12: 000000000003042f
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: R13: ffff88c493968c00 
> R14: ffffc9000ffd7be0 R15: ffff88c493968c00
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> __mmu_notifier_invalidate_range_start+0x132/0x1d0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> migrate_vma_setup+0x6c7/0x8f0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: kfd_ioctl+0x271/0x4e0 
> [amdgpu]
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: __x64_sys_ioctl+0x92/0xd0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
> trace_hardirqs_on+0x2a/0xc0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: do_syscall_64+0x42/0xc0
> 2023-07-20T14:15:39-04:00 frontier06693 kernel: 
> entry_SYSCALL_64_after_hwframe+0x61/0xcb
>
>>
>>
>>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 
>>> 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 
>>> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>>> migrate_vma_setup+0x6c7/0x8f0
>>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>>> __x64_sys_ioctl+0x92/0xd0
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 113fd11aa96e..9f2d48ade7fa 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>>> struct mm_struct *mm,
>>>           r = svm_range_trigger_migration(mm, prange, &migrated);
>>>           if (r)
>>>               goto out_unlock_range;
>>> +        schedule();
>>
>> I'm not sure that unconditionally scheduling here in every loop 
>> iteration is a good solution. This could lead to performance 
>> degradation when there are many small ranges. I think a better option 
>> is to call cond_resched. That would only reschedule only "if 
>> necessary", though I haven't quite figured out the criteria for 
>> rescheduling being necessary.
> [JZ] you are right, small range will sacrifice performance.  but 
> cond_resched has no guarantee to remove RCU stall CPU completely. 
> Maybe we add own condition check here based on accumulated prange 
> which ls processed.
>>
>> Regards,
>>   Felix
>>
>>
>>>             if (migrated && (!p->xnack_enabled ||
>>>               (prange->flags & 
>>> KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
