Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9328EC001B0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 20:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3479810E6FA;
	Fri, 11 Aug 2023 20:50:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7AA910E6FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 20:50:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKJtIyN6JHQMFboMhU4Bv5M56A480eZUsUvk2CL9maZNChRh9b9j18PFnYWodflOEkIU8r2/2au13Jy12Q47n2RB6SkdUJHKsSibdGyBkPrXh5aA1xwLiG0a4yQX1J/Nh4+MG42UZ4Z51ZbDF7QeFnzUsbOxgS1fT+j59EDSGHN3FwR1kdHYXkmrGLC0z+qJKfpSsjAh1kDNNrkBmmJGmce1juUT2PWzEKc0vr25Dg8Qm0GxOVMPCFwb6OoyFWASiapvQ1MS66K7AOv6F3UlvyRIt/39MdQ7DUJc//4Ut45e1sLv082ZDv3gthYx/nJ/YTkVZIgn2/e+WxPU2Qpt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R66yLP2y6rbWRG0mPmD5C40cQcZ3vWfq6rCyvELdY5g=;
 b=isUHrtF7YCNrUus7bG+Ki57Gge/C0KJnJXpmm2ujVfVlrYAYyPUvJfc8lD4JerLKUHOjBi+VrOs1+lhuwh1awfzLzREOMTJDQHn6KZZ03xProUNUc8o6oDKUNAI1U0+82B9EYinpZZCeq3ZXbVr3Gt4TXcR0C8Q10UzJwlsoTWQLInHAIENuPPdRCr6sMTj5KhLRuIBpwFE1Xysnu5UCTyuQRJktDoBQQoH44b2CetrIMFLQ4KC5geopuQspFD0PFYNyBfworuXsYaBo/8oA7YnQG4rtaBiuS9BvMQ0olV1EdtkiNZjdCZDUS/NWP3UTxecBrU42QDAe50t5XrXLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R66yLP2y6rbWRG0mPmD5C40cQcZ3vWfq6rCyvELdY5g=;
 b=32Z88KRO4Vmagm5fLhdrKl0Enq8ITSq2dhO2H3AD4qPthzKtzhOk7jzpu2LH+fILbgeSweByCm1pHiIDDMi5sW+fm9p1HWcATjau+HD7fG+6W5FoFZ+jL0LopxNoxsvIe3+BznZtWEhsDfjIFs0zHdHE/BzynAoZ/GoPIt9JRSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 20:50:24 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::6b2:a798:b3f7:66f5%5]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 20:50:24 +0000
Message-ID: <b93161c3-3f90-d6b0-6c89-2cbd8e2e75f8@amd.com>
Date: Fri, 11 Aug 2023 16:50:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: add schedule to remove RCU stall on CPU
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230811191108.1808648-1-James.Zhu@amd.com>
 <41b68fb8-378d-6f6d-c653-d6c2b106d8d3@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <41b68fb8-378d-6f6d-c653-d6c2b106d8d3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0150.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::9) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d66c2d-3e67-4886-31b0-08db9aac95a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAP6dDe1g8t1P0ghFSIylk+amEP5TeFHELGpCbShyfz1MPrbnh00U9SzIbWgvjDpT81NNEunTiBeGZw4tZ/pKx9YaVYUKBIPq/HaM7RMQK8gLA3C04yinn2A4zIBthWTGEXbO+E2VbzCXapmt9yXtnD2TmOnBD1cJpvPGKY7ZAhMQPQ0Te+RTH7KAog+IgATCk0y38xjK1QY9Niw6nudwGs4yOIe+Di0SuKB5jCJA/z824LRXTMoaEcWNOvJOfMlVcZYvcfRejZvG+yNiyQP85pkGATsE4vJ8AZL8usEW5d2DwLnR1uVPVNR88YM9dJb18V9UaVkcOGWMZAu6zKfr3N391fYAyvmbxcBNOaK/hI52nkRx+W17aalKySU5FJi8kEW6CpOFNGC0q8Qu1TC6zxQc2HMHrYsWIOS9NXYpv6w5k+1iAc3pjJ/iY4eX5ufYXmBKKHE8QalhrAwlAkgQa5d+PcQdF37EvWsbRUCVx6Mx8Q+7H8bab+YInNw9my7My6aDWJn1VjJDsu1PjZZSEuXsURxYbhpubGOh+qK/ND9wSiZb/+J4yLFhWz12O9qe70Bsdlf749R44yGt1xE1qv7kzGH+W9603PgNH7yGVbrCMszjrzWh4wvRH0JtWqNakri08pOdjv2V7FGnANVFuTWRKcsv48volmcdtZee7DqaltjWA4bWGV0rcN6tbx1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(1800799006)(186006)(41300700001)(66556008)(316002)(31696002)(66946007)(8676002)(8936002)(4326008)(66476007)(5660300002)(2906002)(26005)(6506007)(53546011)(36916002)(6512007)(36756003)(2616005)(31686004)(83380400001)(478600001)(38100700002)(110136005)(6486002)(6666004)(45980500001)(43740500002)(460985005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3Awb0dublh5OFdJQ25GanZBQkdQU0JUYTJNWnZiSHZPQjJZbVFmSHhNYUhI?=
 =?utf-8?B?cUU2YlZMZVRuWnFjMEIza0M4V25uMkRxYXNaSDgwcFV5SVA3SEwwa0ZtbU5N?=
 =?utf-8?B?d2VrUG9NOWlpcTduNmk0QVlNSzc1eFlCR1RjRTFxMEpKYXlWRk1rZGRudjRZ?=
 =?utf-8?B?ZEV5Qm9ySW1BUlZZblRyTXcwK0tsR3ZlbFBISUFVTXJSWjk4SHZubS9ueVQ3?=
 =?utf-8?B?RVFNY0VobmFOL1NNNEZWRTBFQi8xRDhEdFJXT1kxNE9FTnZLM3dCeEw5TC9D?=
 =?utf-8?B?ZnhGWDBKVXk4WU9zbzlHWGFLemhlT2xpSGJobW1iYmFDSk1INmRaS24wekw2?=
 =?utf-8?B?L2NjS2htNWRLSFpwSWhrN296ejE5ZzdDUnkwa3h6dXh5bUhVbldUaHR0Wnk1?=
 =?utf-8?B?TzJVMlU3d1F5UUkyNFdodmdxZTBzemlyZW5xc3gwYVArWk1zZXpsMmIzbmta?=
 =?utf-8?B?UG45YkRCRkpvdm1KVGFId2ZMbzVQdDRUdkpycHU0WUxTSm5QQkNRWU5hYlFG?=
 =?utf-8?B?aEZEc21aYUhQcHRxZlJUcGYzUDJoTGNFZmxpNmd5WlkwMlFCanU4THlKdElv?=
 =?utf-8?B?Z1pOcllnOGZ1SllJd04rMEZ2WStPMmZOQ2liN0NmWnRvL0UrZEVWMDV1MEtE?=
 =?utf-8?B?NEdNS2xGQ213Qm1sV2E1M0ljZVpXU3JRZ1M3UitQaVhqaEVTVzBxaTluYzlw?=
 =?utf-8?B?Wjk5WXpsdzhGa0hzQVUrSTFOeVRRMUVNeEFCdDl2VmMxQWY2RFNLbVdzZXA5?=
 =?utf-8?B?Z1lQOUxhZFlWMTFyNGU5RGJIaGpCMUtUNGMyUktQWVpFVEEzcHh6eDdTZVFQ?=
 =?utf-8?B?TjdEbUlvSERHZ2pFdWxOREhsaXVSRXpmTHVEN2lqODVFR3c1T2VWWWhuS0Y0?=
 =?utf-8?B?VENFcmlSaFNGc2pBRG16WXhDcXU1emF0OXE1M3NzRHB3MXRhNjNkU0ZEWTls?=
 =?utf-8?B?Y0wwSkY2WkFRdEpBK2FYT0VFRS9DaUFqV3RQdWFMZlpmMDBzYkViNGlSSVN3?=
 =?utf-8?B?MDZFUEdUT1UwV2JJTTkxVDdmTm5lYkhiZkpidHV4QUtycUQxNXRvWDhZcExG?=
 =?utf-8?B?b3lvQ25HalFOcVo2VzZMSkh1cHhzK0grUTJ4VTZRNTN4N2VycFZGdWUyanky?=
 =?utf-8?B?NytCS3VBeldadkNKOHVCTnZLYU8xdkJkQWs3U291ak5ZTnRxa1lhZ25iZTJa?=
 =?utf-8?B?bWFyM3gxVEcxNGhYMnV4ajMxdTVxTjZXZVp2WDdUbVBRdmZqTGJjN2FpU2hJ?=
 =?utf-8?B?SmRyRmJnU0J6dk01NXpMbVhXVUhaWTNGUHFWK3drT3hPVGVPU3kwT250em8x?=
 =?utf-8?B?eUs5dWFYdUVuQTNSVDhDU0h3Um1qZ05rTlBITkNRL2JUbWYwYjJZMDNaVEZs?=
 =?utf-8?B?OFE5TDRWSWM3cU9PbCt1ekxxR01YQjRxaWQvR3BnSU1QemFud2tJMm9kZnh4?=
 =?utf-8?B?VWc3b3RYZU05aXBBbjlVNjBDV3dyNG5pMFZScE1FSkx2T201cnZmVjE4eVJL?=
 =?utf-8?B?ZkVCNmtocnpFbkN3TjdUc001cWFxNW13QXRQZWdWMHM4YkdnaVZld0E3Zm91?=
 =?utf-8?B?dFJPRFF6RE9Fb1lwcnppZWR6V2NRMk1oY0N0TzZNRmJFWWk2bnhMWm52N1A2?=
 =?utf-8?B?VjRQejJPT1NDRll2WjZPajRHZ1I0dUMvNUk1ZUZxdm1GT0JMTFdpSkEvWWxo?=
 =?utf-8?B?cDVWamJEbkVYUXM5djl0aE54K0QzRVZoREJLdllVUlBCQUJPTUYrRVNEZm52?=
 =?utf-8?B?K0g0b0FCOVl5MTF0RW9QQnZsdU9VUFVFcndiTG85VnAyaVJMenY1alNDT20x?=
 =?utf-8?B?YUlGbVBqOWl5UGprRzJ2dU0wWWtRUDhYZnlQV0VGdjdKT1ZqMnZIcHIwRUQx?=
 =?utf-8?B?RkoxTFcvc2dlSDBRSjRnT2VKeUlFakF0a3Arck4vZ0lRNks1akZHUXlyNWNa?=
 =?utf-8?B?bUk5MDc3eHZJL1d1Q1cyZVVQTUViNjVCeUE2QThkSXprUW5aZmJLTXhRK0dU?=
 =?utf-8?B?UENDYmlCbEM4R0UrWDVBVWV2WHBzS08yRkdMRUNXdkdFWEhnZ0FnN0tCb0ha?=
 =?utf-8?B?VG9jOEgyY1N0MytNQTBEaUJUc1c3Z3hXbWI1Z3liNkF1OGxXamJ4bmdaMTlK?=
 =?utf-8?Q?TnpLpDK3vEs6zlS2nosLEA7vZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d66c2d-3e67-4886-31b0-08db9aac95a1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 20:50:24.0078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDto705eFytyww5h8hIUujCdGMdPLkMqV/iu6ujIhmQlpDQVd2euAyre8P8Mtp2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414
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


On 2023-08-11 16:06, Felix Kuehling wrote:
>
> On 2023-08-11 15:11, James Zhu wrote:
>> update_list could be big in list_for_each_entry(prange, &update_list, 
>> update_list),
>> mmap_read_lock(mm) is kept hold all the time, adding schedule() can 
>> remove
>> RCU stall on CPU for this case.
>>
>> RIP: 0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
>
> You're just showing the backtrace here, but not what the problem is. 
> Can you include more context, e.g. the message that says something 
> about a stall?

[JZ] I attached more log here, and update in patch later.

2023-07-20T14:15:39-04:00 frontier06693 kernel: rcu: INFO: rcu_sched 
self-detected stall on CPU
2023-07-20T14:15:39-04:00 frontier06693 kernel: rcu: #01134-....: (59947 
ticks this GP) idle=7f6/1/0x4000000000000000 softirq=1735/1735 fqs=29977
2023-07-20T14:15:39-04:00 frontier06693 kernel: #011(t=60006 jiffies 
g=3265905 q=15150)
2023-07-20T14:15:39-04:00 frontier06693 kernel: rcu: CPU 34: RCU dump 
cpu stacks:
2023-07-20T14:15:39-04:00 frontier06693 kernel: NMI backtrace for cpu 34
2023-07-20T14:15:39-04:00 frontier06693 kernel: CPU: 34 PID: 72044 Comm: 
ncsd-it-hip.exe Kdump: loaded Tainted: G           OE 
5.14.21-150400.24.46_12.0.83-cray_shasta_c #1 SLE15-SP4 (unreleased)
2023-07-20T14:15:39-04:00 frontier06693 kernel: Hardware name: HPE 
HPE_CRAY_EX235A/HPE CRAY EX235A, BIOS 1.6.2 03-22-2023
2023-07-20T14:15:39-04:00 frontier06693 kernel: Call Trace:
2023-07-20T14:15:39-04:00 frontier06693 kernel: <IRQ>
2023-07-20T14:15:39-04:00 frontier06693 kernel: dump_stack_lvl+0x44/0x5b
2023-07-20T14:15:39-04:00 frontier06693 kernel: nmi_cpu_backtrace+0xdd/0xe0
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
lapic_can_unplug_cpu+0xa0/0xa0
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
nmi_trigger_cpumask_backtrace+0xfd/0x130
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
rcu_dump_cpu_stacks+0x13b/0x180
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
rcu_sched_clock_irq+0x6cb/0x930
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
trigger_load_balance+0x158/0x390
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? scheduler_tick+0xe1/0x290
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
update_process_times+0x8c/0xb0
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
tick_sched_handle.isra.21+0x1d/0x60
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
tick_sched_handle.isra.21+0x60/0x60
2023-07-20T14:15:39-04:00 frontier06693 kernel: tick_sched_timer+0x67/0x80
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
tick_sched_handle.isra.21+0x60/0x60
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
__hrtimer_run_queues+0xa0/0x2b0
2023-07-20T14:15:39-04:00 frontier06693 kernel: hrtimer_interrupt+0xe5/0x250
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
__sysvec_apic_timer_interrupt+0x62/0x100
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
sysvec_apic_timer_interrupt+0x4b/0x90
2023-07-20T14:15:39-04:00 frontier06693 kernel: </IRQ>
2023-07-20T14:15:39-04:00 frontier06693 kernel: <TASK>
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
asm_sysvec_apic_timer_interrupt+0x12/0x20
2023-07-20T14:15:39-04:00 frontier06693 kernel: RIP: 
0010:svm_range_cpu_invalidate_pagetables+0x317/0x610 [amdgpu]
2023-07-20T14:15:39-04:00 frontier06693 kernel: Code: 00 00 00 bf 00 02 
00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 48 8b 14 25 00 bd 01 00 8b 
42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 42 2c e8 51 dd 2d e1 48 8b 7b 
38 e8 98 29 b7 e0 48 83 c4 30 b8
2023-07-20T14:15:39-04:00 frontier06693 kernel: RSP: 
0018:ffffc9000ffd7b10 EFLAGS: 00000206
2023-07-20T14:15:39-04:00 frontier06693 kernel: RAX: 0000000000000100 
RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
2023-07-20T14:15:39-04:00 frontier06693 kernel: RDX: ffff88e18ef1ec80 
RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
2023-07-20T14:15:39-04:00 frontier06693 kernel: RBP: 000000000003062e 
R08: 000000003042f000 R09: 000000003062efff
2023-07-20T14:15:39-04:00 frontier06693 kernel: R10: 0000000000001000 
R11: ffff88c1ad255000 R12: 000000000003042f
2023-07-20T14:15:39-04:00 frontier06693 kernel: R13: ffff88c493968c00 
R14: ffffc9000ffd7be0 R15: ffff88c493968c00
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
__mmu_notifier_invalidate_range_start+0x132/0x1d0
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
migrate_vma_setup+0x6c7/0x8f0
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
svm_range_set_attr+0xe34/0x11a0 [amdgpu]
2023-07-20T14:15:39-04:00 frontier06693 kernel: kfd_ioctl+0x271/0x4e0 
[amdgpu]
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
2023-07-20T14:15:39-04:00 frontier06693 kernel: __x64_sys_ioctl+0x92/0xd0
2023-07-20T14:15:39-04:00 frontier06693 kernel: ? 
trace_hardirqs_on+0x2a/0xc0
2023-07-20T14:15:39-04:00 frontier06693 kernel: do_syscall_64+0x42/0xc0
2023-07-20T14:15:39-04:00 frontier06693 kernel: 
entry_SYSCALL_64_after_hwframe+0x61/0xcb

>
>
>> Code: 00 00 00 bf 00 02 00 00 48 81 c2 90 00 00 00 e8 1f 6a b9 e0 65 
>> 48 8b 14 25 00 bd 01 00 8b 42 2c 48 8b 3c 24 80 e4 f7 0b 43 d8 <89> 
>> 42 2c e8 51 dd 2d e1 48 8b 7b 38 e8 98 29 b7 e0 48 83 c4 30 b8
>> RSP: 0018:ffffc9000ffd7b10 EFLAGS: 00000206
>> RAX: 0000000000000100 RBX: ffff88c493968d80 RCX: ffff88d1a6469b18
>> RDX: ffff88e18ef1ec80 RSI: ffffc9000ffd7be0 RDI: ffff88c493968d38
>> RBP: 000000000003062e R08: 000000003042f000 R09: 000000003062efff
>> R10: 0000000000001000 R11: ffff88c1ad255000 R12: 000000000003042f
>> R13: ffff88c493968c00 R14: ffffc9000ffd7be0 R15: ffff88c493968c00
>> __mmu_notifier_invalidate_range_start+0x132/0x1d0
>> ? amdgpu_vm_bo_update+0x3fd/0x520 [amdgpu]
>> migrate_vma_setup+0x6c7/0x8f0
>> ? kfd_smi_event_migration_start+0x5f/0x80 [amdgpu]
>> svm_migrate_ram_to_vram+0x14e/0x580 [amdgpu]
>> svm_range_set_attr+0xe34/0x11a0 [amdgpu]
>> kfd_ioctl+0x271/0x4e0 [amdgpu]
>> ? kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>> __x64_sys_ioctl+0x92/0xd0
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 113fd11aa96e..9f2d48ade7fa 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3573,6 +3573,7 @@ svm_range_set_attr(struct kfd_process *p, 
>> struct mm_struct *mm,
>>           r = svm_range_trigger_migration(mm, prange, &migrated);
>>           if (r)
>>               goto out_unlock_range;
>> +        schedule();
>
> I'm not sure that unconditionally scheduling here in every loop 
> iteration is a good solution. This could lead to performance 
> degradation when there are many small ranges. I think a better option 
> is to call cond_resched. That would only reschedule only "if 
> necessary", though I haven't quite figured out the criteria for 
> rescheduling being necessary.
[JZ] you are right, small range will sacrifice performance.  but 
cond_resched has no guarantee to remove RCU stall CPU completely. Maybe 
we add own condition check here based on accumulated prange which ls 
processed.
>
> Regards,
>   Felix
>
>
>>             if (migrated && (!p->xnack_enabled ||
>>               (prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)) &&
