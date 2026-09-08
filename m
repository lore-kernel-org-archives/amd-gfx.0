Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC28C79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 13:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B4910E195;
	Tue,  8 Sep 2026 13:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0idYa/V1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011053.outbound.protection.outlook.com [52.101.62.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D31C10E195
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 13:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1SdLeQApodnLFRzEFRoUl39hG/QHGDNqQHlYzzJuNdireJcYLDN27QgDY9cpmqlWnmoOyPg9zi/ted/myWxrWQ53oycUCZLuYs3vIQxENn0m7qDxnS7jnSxkkhdhSf5/NBwGcejOzYbaVnTCYKL33p2duRqRGkjgOyZYAZVE5GZv6OrBJaANFvT8DDkXrNV7b8X+z/d9dfbUnz8AvABwmbVZ0I6O5DMMhm4qKw6wjkxlfealXVak1WZFJgVgGDxKBbYFBVTjrcA2zmNPCNREbE9uXkH93rTzxAD+tl/o+Ig+HgQ6E21ykriv90co1pKo9PdELROgOTzMqPM/DidIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UsDqrrLzD0ky/EKK7dXfVz+0/K8qOl7bh7ztCOk3M9M=;
 b=HJao8/1qWIuJosOvuRzNT0wncC1ZUItG2stfpZhTuQ25MLwPMKqPssSf3n4Hu5ud/yF7pZ6DjT62/3wv+vY9HH8ENjLjTxYzJKDokpj2uzXNbx4sEo2iO6bWzXhlCRClmT81RZPDsigyb5sPpQ0ogJO3EZluMRHPixrHppyqrFfBaD5dg0ZX41W9yKUL2xhlRUvef8XD49IKFJ/BwlwErUBaQgyRDsUPK1EWI/MQWMAgJhicZbPfIaR59b6+yB8nqe/AtppFB/1yA1k74A8/JRSOm7z6kGbpzcq8/bj4RQSfXGK8m6/XDegBp1odsecMzLlyT9EskCik+rxCkl7b4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsDqrrLzD0ky/EKK7dXfVz+0/K8qOl7bh7ztCOk3M9M=;
 b=0idYa/V1h+j2VyOlVAy16pkW6XEVezAnvJmR3kD49nRQoBjZj/XBQDN/n7XNVThVzUrIweOpEPn1jPcXSybpceWL6h2YzoMQjrK2IKKB7zau2f5wCPheFghK899JdiFzCAxALTFqM1KTiDKVpF2PRDy2B5rn5zwE27+jtjggZDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by IA0PR12MB9009.namprd12.prod.outlook.com (2603:10b6:208:48f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:17:18 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%4]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 13:17:15 +0000
Message-ID: <08079aaa-3dea-4214-a599-67e10f8a7274@amd.com>
Date: Tue, 8 Sep 2026 08:17:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix TCP XNACK scoreboard reset race
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent.Russell@amd.com
References: <20260903210825.839968-1-Gang.Ba@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20260903210825.839968-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS1PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:8:44d::18) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|IA0PR12MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: a9eeb475-8196-4299-bd16-08df0dab8005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mWPdR0jCLhdgqtidrGi41nYPHf/Cvhp38914AmjeVLP+QSqVSDEgr6EeowQu+ZNfGiST+gYTX6Bfimb2eT4plbauCfxDWHXRIOonySvzMl+n24ySGc/hC1CzWQyAiFMOaulrxgyxlXo1tuehyzowrgarFv9GlSWieaTPEtPiDrvthqvOPJjTktCI8ZAoCragzPtkcgRjb2tn0A8uEPILmnJqTu0JN/J8PTlBrPpR2syEiH2JStxxj/OggLbTBc+Adabl/R7c2+gTahvnNuxPks2JXO5eGUS+e7A1oqUXMkuS5oq0nXNdz07dMzunbYKwgPTgwEe96BfLnQycTPA++3q/0m9MzDIwwfqJrC8MwipHcvZFE3AE5Ay4n/HDiwrLwRF0w+mkfIznzzEeBxcpGA7HPdIf1v4+YIblEi0Qfr4KmVYxTiIspK27UoB1ILzrZpGkVz11lc+bol7LbqQPBDPDXLd3rvDI0LPauYR7Sd6oN8xNb0m9xawm+a7SQiLsLSSFf8n/PnqsQIoYjngicaYcxT1HhlxVmVTlwjzCxlAg+hNM2xn7c5YkPBa4OjY4wCA7IhPmnbFUD3fSAhTAeBrg7kaRXGwm73qeJUoEXeNr3ImjO/9TJqrss15rkMCaCZ0dGNIDukk4IkkhVna1wPmCZOqqH8kwZwu83fGicAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNIdS83dHRDNE00cStSRU5jRmcwaS9peTBJdWEvOVA5QmhIZ2Qrcm1CYWUr?=
 =?utf-8?B?TnBoMXR2Rk50bW9MdlNyRVdoZDZ6R0M2T2QxQnB2U0E2MnU0eXJjQ3FPRGtH?=
 =?utf-8?B?Vm1YU2lkMlV0TzZqbmNNVkRNWWRYYmFUMHlUcHR2MWpNMVpzSy9HOXdGakRs?=
 =?utf-8?B?WmhocWEwZHBsK2lNMHVENnZmc2U2SHkwaGV4MUZkZ3RJZXkyUk5uLy9EZ3F6?=
 =?utf-8?B?cUFCQUZ1ZkVJTjFFR2pnOE1wcld3bFdQZk5BV1dqSWZBaUpEWmdFYmRYZkFZ?=
 =?utf-8?B?dkpUN002bTQ3Nk1nYnRkZDYzSjM2NXZUVWlibm5XTnVaYTFMaW5yZE4xLzUr?=
 =?utf-8?B?MkRtcGQrdTJSRUZrMnFQMm1NZG16aFZ4MVdQY2JWWTVuOWRYMm9Vc0gxRVhw?=
 =?utf-8?B?ZE9Rd0c5RXFMWjZLdTk3U0NBQkRXYWI4UXZZQWlhVFRjcVplVlY5TW85NjFm?=
 =?utf-8?B?ZEY3R2tVMXN3a2pCM1ZyYXpRRlFPMzc3Nk9Mcjk3TkFwMzhKVE8rdGVWTjZS?=
 =?utf-8?B?clRiTHd2eFJ0RC9hT3VxYjhQNVpkOUErbDYrRjllWHRGa1lNOHdrd3lDbDJk?=
 =?utf-8?B?b0tZalRXVm5iQmZwWExsUjBqeStDR3dkVGk2N1ZzYmNpQVVJN2dFbmtxVkVh?=
 =?utf-8?B?TXRFd3RIbmlsU2FadUFCblBrVTFHTHd0REpsMDl3N0U5VGU0YUV2ODNNY1VJ?=
 =?utf-8?B?UWV2UzFvSkFGU0p6NUd4UFlZM1BTblh5RUl3Q012SkZtOUh5NkpIYjg1M085?=
 =?utf-8?B?dmZWdHVubGU4bGl3RElyN0h4UnhrRUtZVUdWR09LckNPY2psN1FGZUNoYTl4?=
 =?utf-8?B?ZWRERnlQbjhYakl4YlRsODlFbysvTmNSV1prUUdCTWNkcmNUVllPaWJsRGg2?=
 =?utf-8?B?bEw4ZElVMGFmNmJ3amlVZ2o4Rzh5UnRVY2hsU0FRQWZBYVhnNFdHKzFkTGR3?=
 =?utf-8?B?VTYzSGNESkJ6VFRQbkhXSlNMRFJhamFXb2dGa1lqVzM1bFIyLy9JYjJodThR?=
 =?utf-8?B?eXM0L01KdnkyNzNUVmh5R0Y4NEhZWmNsQVZpMnpJdUFKQk5XaU9XY1MxRUcr?=
 =?utf-8?B?WFhYTzZhWEpManVDV0tndTJ2Ukh5UlRVSE5GbDQxUGRlWC9rMU9jeCtWWjU4?=
 =?utf-8?B?RVJvOWNVelRvcExQd2I4cGxuSGJ3WmR1dWtFbkJVWFZ2aW1zUE8zUDBSMG5h?=
 =?utf-8?B?SkhiVXdUNXVvZVFtZ0pCTHg1bTJwOEptWlZjcFVZVGpWWjhzWlJhUWZZcVF4?=
 =?utf-8?B?dXlrc0lzVGhkeDVXNUx5Nk55TWxNOEt0WTAvWjk4R3paNG5TaGp4Sno4RFZ1?=
 =?utf-8?B?WE1LZG9VOURCQndwcjJ0RTNERkk4OVFxOEVWNjRoRTByRmVGTktCRXVPTFRk?=
 =?utf-8?B?cHVSL1NOMWFHKzNEZ0Vhd3hTWmh2T3F0dEFBMFRKYldqT21TMVdDUmNkWlZW?=
 =?utf-8?B?UnI4VGJKU1R6a2VVRWVJbmlpcVFSSStJSWlFTmdnMldFVUhPWllkZHB2U2Rh?=
 =?utf-8?B?Z3VwOWtISmtTTEErNng5TS91YlJTdGNBOHBnZjR6Rng5YWxzNGtVNzZJUmNM?=
 =?utf-8?B?OUh4K05oZ3FoclNGbzQwZnZkN2VrL3l1eUIrMGQrTXRJbkM5a2NmTWp5ZG9L?=
 =?utf-8?B?MW9LajJETWEveVd6aHM4OGMyK3Q4Q1M1VkU2aDA2TnpDU1RteWdibEo0TFZM?=
 =?utf-8?B?aXZ1eS9aaGZpWWt0WUdlK2M1SHpoMmV0UjBTVHczcEE5YXk0MmMvNFdLM1l0?=
 =?utf-8?B?Z0UveCs5S2FHMG5tUXhMTGRJQzJwODZJY2xMTEZGSU82bFF3RFdyZDd0Tzlu?=
 =?utf-8?B?OXlkNlpBc1JSOUVWYyt3NlhoTm9yQ245UmlEaWw5TGFhY0JOOHBpUmE4V0ox?=
 =?utf-8?B?K2VFdVJ5STBhcVJNUjVLZGF2dDlIKzVLbDFzZUFXM29SNlBBOWs3bDVKVzNX?=
 =?utf-8?B?QStkbGQzcmNEQWVkUjFVTjhIb1Rrak5EN3JLT0ZwVkxxdGN1RXJrSElBZmlG?=
 =?utf-8?B?VE50THl5MUg5c0xoWkVEU2RvTjZTOUdyMmlGSkU5UjJPN0NKSzdqM0xwVXRi?=
 =?utf-8?B?clFDY2JubDFNN1lPOFBsT1pSZ1RZQUdDSjl2bTNCQmF1ZlVnOVNPUk9ncFVy?=
 =?utf-8?B?TzBWelQ4MmtIdEZJZU1oL3k4TzNxQ3pLUElrdkx0ZGQ4U2o5RjdFRHlTc0t2?=
 =?utf-8?B?T0krVUx1bC85OTIrQ2tyMC81eGxVS3JIRUpJaXJXeWRWN3FsTllQVitsOGdl?=
 =?utf-8?B?emFmcW1nbHVHRU84QmQ1aWJjUkRta1hsblo4aEJtbG9PclpXVEhNZi84Q0ZO?=
 =?utf-8?Q?Y3noGHR8nw3BFhCqbJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9eeb475-8196-4299-bd16-08df0dab8005
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:17:15.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9m1YIZs6JnnEK0L0YGmSodTqTbPHzp6NYyx9uYqclu88f5ICVlqhQm66PN+QZlV8GxN6UNZN8UWBfh3p1hkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9009
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

On 9/3/2026 16:08, Gang Ba wrote:

> @@ -240,6 +254,11 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
>   			mutex_unlock(&p->mutex);
>   		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
>   			kfd_evict_process_device(pdd);
> +
> +			/* GPR cleaner shader for MI2XX */
> +			if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
> +				gfx942_clean_fault(pdd);
> +
>   			kfd_signal_vm_fault_event(pdd, NULL, exception_data);
>   
>   			signaled_to_debugger_or_runtime = true;

This code runs conditionally on:

if (!kfd_dbg_ev_raise(trap_mask, p, dev, doorbell_id, true,
                       exception_data, exception_data_size)) {

It returns true if the process or debugger (I'm unclear on the logic) 
receives the exception. This is not what we want: this code must run 
unconditionally.
