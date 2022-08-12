Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC39C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 13:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E90DB4654;
	Fri, 12 Aug 2022 13:55:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E56AB45B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 13:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2XdU6IaNySvtfT2vriq+Y3cRxMkxqHZRFgl8zUllSrrCQ5gdz3OG3bn+UcYAxWarPkUPCM5al+IsIiBISMiPMLmwxWP7MTwXh3KhHikHuYKusmPU1h+vhwSozJLs2L+hfrTHZD54wVdkp1NmkrRl/s4lFTB9JV9/Mw7+47smVn3I9o5OogGfWK9F42encstge2EGW62c0UAbI96Ti/L/SnBcH4R/w5aLTFHm4DJD1qpfXgTmgNysm9qMjTwWSwLM82/tiXQmYGou0HsinE6kEo/rLZ+izkHesOp6fwkKJjRY14eRSMy3mX2Cef4MrBqHvnXzo7SZRra3SOyTOC9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHWOEQ4Jb8gsFSsuOVkJVg7elMD0UvRfOE33aD08nEs=;
 b=McwSWtckU8R5x3TJdESZH6GTqQxPLR7YjeiaqE56u7V4HACpS+Q6YtFh+zOQYzXJMMaZ1DCm/Q5oGhDxy8Rx9ncPK05cHWsd2/UQqljn0oVXyAUoUfuHebialBXdShKYmIqLhhp4Z8sL9Qh4/UNjeayBx7HUwC/T397DTKtmnjs0uPru1qxsSFFXftLID7J41WRdqW6zDmtpQO0Qy+kEcHp4Rm0ll6WohqJj6FhZ/FET3yJv4xiNOMOQ6bvDVcWPRZWdrXcK87ASVrZImWvjmnRnJjrta6dLWgRyX3hcBz8i174Hwy3rM30oPANmEwPu8kJI8I773Y9PEaAj3YdZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHWOEQ4Jb8gsFSsuOVkJVg7elMD0UvRfOE33aD08nEs=;
 b=GmNw2FZorHRuX06/RnMAZnootbU0E+KN5XEfEPv6GXNYxIYMPYLwvrUTq3aM6XdpxVSE6szJRWiBMAzl5S4Wt4MDnT4uYYBzjxfqPauJxoxNAasZhxc//9XN0Rr2bMb7Aps7SPRZSSRblbz3b0WOmyeJgZSomYn+QpthGUWmkak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH2PR12MB4023.namprd12.prod.outlook.com (2603:10b6:610:14::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 13:55:11 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::252e:b6db:2d4b:b922]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::252e:b6db:2d4b:b922%8]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 13:55:11 +0000
Message-ID: <da05c04a-c484-e2a0-8019-27f415f0a726@amd.com>
Date: Fri, 12 Aug 2022 09:55:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Try to schedule bottom half on same core
Content-Language: en-CA
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220810234109.935228-1-Felix.Kuehling@amd.com>
 <20220811190433.1213179-1-Felix.Kuehling@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20220811190433.1213179-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:208:134::38) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa6b3d44-80fd-46ec-3380-08da7c6a462e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4023:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2F11kjUGNOzU6VZtNEfD6JXH3tmsoyi2+zDd/V72ItLfVvpOkTDhTs9EKiCXR8cytUTe6JL8etyekHmsLY4eP+93yMISl7vKmDxt9xwvftkhdxlDTYSqrRVpc8J8c32XJd78ZQT//97GfG5nzZMyfibV/SgcyWq3pL5LG+28fK+Mn6PELXgyFZRhG3fJ8DOCdQFR2MENgIfTvi0DnfomB7AWf/tYdfFjlqbpvRhF1PqF/RZ+6t9p6qw1v445YurPJ8nPgf1apTRMT4oqjqky9/Hs4/spI0RLXOntiZPQtP8vCEBqcJb5Yz68V2YB4DjSHDAAPNB2YsnPWXDyi2jXBt7d1sAHpZAcbuqloLTReQ7mbm+ijXQBwhBJBGcsSbXv2Gnw7jGjznzSiXX4DfVSEB+Tev0IKMxS62wzFTwZFxwp9VQtj92wp0TcJmKz6vbcQgK661MEmHjYzInTDHdLkuFWwLoIo2zqrT4ODNy+LHrOKZNzfmAlYuh50JStri25PY/RV8LbmJa+Xb8OFrFihWtLxxJPmvE+9r3FzJB///AmPKTu5UmER8r+3P5l/4WvSPsOJap1aue+LpVMsABpzKtSIcIB5dfmIjTll6qg8csXkzTkXKRg4dYTwxdjrNUIsvyV8tqe7vFCDW8NL2KCMB63haPNbTB4/phSsU0bmtuhkHgPI6LBvQU28IWzck06y2G0WRrfmyJ5tjVOkE9YQ5EOWnHW1CVTwaIc+Htdq9/UoZ0sqFlu8XpZ5iibgMhNDPW9pXCR/epS6jPxQCquRyJklH/pdVHJvnly0MXD70A544DwGgTtgOmeuMexeIzAeYjAQeZIAXnBiV/JcmWFKxnQ/HV32hSqJdV9zLORoI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(4326008)(31686004)(2616005)(36756003)(83380400001)(478600001)(66556008)(41300700001)(66946007)(8676002)(66476007)(6486002)(2906002)(316002)(186003)(26005)(6512007)(53546011)(6506007)(38100700002)(8936002)(5660300002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alhERW1acDhsVEF4MnNudHVwb3FhYW9LcmpLcGh0S2k5RlFpOEVBbnNONjN0?=
 =?utf-8?B?a0hSQmN3RWZTbTl3YVU0cHlEemNUd01ZR2JWYy9WeXdMVGtCR2hPbE9qUkt3?=
 =?utf-8?B?emUwb1lEZXBLWXEzd1R3Ni9CN1hhbzBBNEk0bGVOd0UwWmcrcmN3czVGM1By?=
 =?utf-8?B?dTdxcThEUlgwUXh4N0tGQlllUlpDM1I2SC94VzNselFJYTVEY3NuMDMwNmhB?=
 =?utf-8?B?MHFVRVJLWDM5dHpDOUlsWkZFNXREYitpOVBiSVk0RTRHR1M5cXh2T0gvamlj?=
 =?utf-8?B?OE5CQ3dRL3FYZitNTUxuK1BUOFhxcjdadkRib1ZMclF5OUtmclIrVUxSR2g4?=
 =?utf-8?B?bjE5cUZLUE0yLzVLc08wRlR2RnVwa2g5cm5MNlZqQTBJTTNVYncwbFQxRjlX?=
 =?utf-8?B?U1VUYlBBN3JSaGxqNkpkdEV6WTNrRzFkbW9ERHR6UDRDQXZ4L1pUUFllaWJE?=
 =?utf-8?B?UWN5QXd5N0NlVlpFSEh6V2VGZDl3MEVpL3RJQWtGT2pOc2NiRkxmYXdiN0xw?=
 =?utf-8?B?L0N3RU9tcDlzdkxVSklaNXFnMzFLV2lIZTlORHJUYXo5Q2lXM1RNRkw0TVNG?=
 =?utf-8?B?N09tSGUyWVhtYzQ1dm5oeXZXL2xGbE01WnpJS2U1cFMrcWwvbkxxMXV4TU1D?=
 =?utf-8?B?Z0ZtUDdNRVZtaWFGdFNaTHBUTFpPUXR4dTRyV09waFYwKzdxRE41bG1JNHRG?=
 =?utf-8?B?aDJTZ1B6YkRZOFIxYXhpeW5wMTZCclZtUXdUblBHMDNGN2hYZW9rWFhueFly?=
 =?utf-8?B?NlA4OTZDR2krS1dURzY0K2xOaStNdzg4TU5lQzVxSzlHRTFJNnpsTWw1c1VV?=
 =?utf-8?B?anJONytYRGFVa3BYdGZoTHM4MEp0SlhmRXlsWCtqT0xCMUlFODJyczVLdGUv?=
 =?utf-8?B?a3k2UEFsU3FxYXBOaXlrMVhhWkY2My92MlhVeVl2VnI1cXpLRXF0QkpUTEdM?=
 =?utf-8?B?N2VpczlWMXhSUStzZk81dk5BSFpFcEEvcktaNS9PZE9meGxOR2xqaDB3NkdR?=
 =?utf-8?B?NlJTRXRNRXBIWDlJaDBqR0NVT0kxZ1JnckxSQ01MTklDVk1ZV05jaHNnWGlS?=
 =?utf-8?B?QkFYK0NyR3lJd2FpdS9sbVZiR3RoK1pQbVBzeDhHZ2ZiWitsQzVhSXI4VG5s?=
 =?utf-8?B?cE1LczUzU0Q3S25KdEhYWnhXdXcvSXBkS0p2V28rcEJzZ0JRbnorNVlXU3pI?=
 =?utf-8?B?enVpNEUvVW93emtTR3hxL3dwMHNjcWFCemNqbVRqVTJQWDZLVzliRDN1cUtt?=
 =?utf-8?B?Q1RsUTRsZ0tPb29XN3ZQdW41L3RpbGRwMXFnZ0FyWXpEMmlpL3J6YUpIbmJN?=
 =?utf-8?B?YW9mbG83ZEFCcTZTbUQwbkNYbGE3bFNoc1daTFJ1ZmJ3YWsrNFN3c0x0Vzkw?=
 =?utf-8?B?SGhwdDFiVWNjU3lvcUJtRTk2ZmJQRFFaaS9leW5GbVA0aERRL09KZXJxVDlh?=
 =?utf-8?B?WDlleU1ESENBVzhFcTRnRWdOaHZJTi9lVFAvUVEyY3F6eUR5L1pDZEx2SENR?=
 =?utf-8?B?MGl5VE9HOXhyUzdZTS9yWHhQSE1FWmlmUS9zOExzNTBxeTB1SFZHK0ZWSUtX?=
 =?utf-8?B?UXVieGQ2cFRDWFRqYUhjS1htcVAzM1I5VlFWRkE2NTBkM05XY0pJNXh5M2JK?=
 =?utf-8?B?OXI5L3VTQmZqZWg3Uk5aU1ptMGs2ZkJOVVVuL2FhemdZdEpkajJGY0xLVjg2?=
 =?utf-8?B?d3F0M2xMek9qTTRHaXZaTFQ3NGxhaWQwRklmWCtFUVhSemFIaTJWSG1iWEtj?=
 =?utf-8?B?MG50dWY2aEdicU1GUmpKOXdVV0QxcTE3bW8xSlk0SFBZS2FSWG9veVlHeEZH?=
 =?utf-8?B?cUg0NzFIckt1N0ZYNFBNMVZMTURYZ1FjL1JiSUtQaGFlNWJralhCS0wzaVQ4?=
 =?utf-8?B?RkZNWEJmeGhENWxYcTE1bHYvRG1ObEdjN2hScEY0WC94Y2tWdHFqeFNGTXpt?=
 =?utf-8?B?YVlmM3cwMDdlSE4wend0S29VMDV4Q1NETlNzTksvRkFwMEM1UTcraVF0Yy9P?=
 =?utf-8?B?cjF0Tm5BV0VtUUF3QnhvQjZhYjRrWEsyd21ZdmVEVlFwOTdkbjlzQnE5UnlO?=
 =?utf-8?B?SklESGtrUjdFQmRlNlJnSkJTekNpWWptNlBPNGNDUUpaUFNzWXJNL2pVeVRO?=
 =?utf-8?Q?A4MU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6b3d44-80fd-46ec-3380-08da7c6a462e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 13:55:11.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMCFSe0V5j2HWZZtdyhdaqY76K4gYyxmtYzYmNq89+h353pDkwCkgtYtKp6xINRo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4023
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
Cc: nicholas.curtis@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-11 15:04, Felix Kuehling wrote:
> On systems that support SMT (hyperthreading) schedule the bottom half of
> the KFD interrupt handler on the same core. This makes it possible to
> reserve a core for interrupt handling and have the bottom half run on
> that same core.
>
> On systems without SMT, pick another core in the same NUMA node, as
> before.
>
> Use for_each_cpu_wrap instead of open-coding it.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>

nit-pick below, looks better to use new_cpu as iterator, either way this is

Reviewed-by: Philip Yang <Philip.Yang@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index f5853835f03a..4d1284714e7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -24,6 +24,7 @@
>   #include <linux/bsearch.h>
>   #include <linux/pci.h>
>   #include <linux/slab.h>
> +#include <linux/topology.h>
>   #include "kfd_priv.h"
>   #include "kfd_device_queue_manager.h"
>   #include "kfd_pm4_headers_vi.h"
> @@ -801,13 +802,24 @@ static inline void kfd_queue_work(struct workqueue_struct *wq,
>   				  struct work_struct *work)
>   {
>   	int cpu, new_cpu;
> +	const struct cpumask *mask = NULL;
>   
>   	cpu = new_cpu = smp_processor_id();
> -	do {
> -		new_cpu = cpumask_next(new_cpu, cpu_online_mask) % nr_cpu_ids;
> -		if (cpu_to_node(new_cpu) == numa_node_id())
> +
> +#if defined(CONFIG_SCHED_SMT)
> +	/* CPU threads in the same core */
> +	mask = cpu_smt_mask(cpu);
> +#endif
> +	if (!mask || cpumask_weight(mask) <= 1)
> +		/* CPU threads in the same NUMA node */
> +		mask = cpu_cpu_mask(cpu);
> +	/* Pick the next online CPU thread in the same core or NUMA node */
> +	for_each_cpu_wrap(cpu, mask, cpu+1) {
> +		if (cpu != new_cpu && cpu_online(cpu)) {
> +			new_cpu = cpu;
>   			break;
> -	} while (cpu != new_cpu);
> +		}
> +	}
>   
>   	queue_work_on(new_cpu, wq, work);
>   }

	for_each_cpu_wrap(new_cpu, mask, cpu + 1) {
		if (cpu != new_cpu && cpu_online(new_cpu)) {
			cpu = new_cpu;
  			break;
		}
	}
	queue_work_on(cpu, wq, work);

