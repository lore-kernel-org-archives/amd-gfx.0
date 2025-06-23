Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2811DC7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 22:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7E6910E472;
	Mon, 23 Jun 2025 22:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXBoNa/v";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B081110E472
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 22:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO+hWLqO6w7QVaARppfLepofgRStj9ZA33BEaFVist3K0N0yYW0p42F3tBaDTESYSQyZxqiO9pTkg7pjx8zQDAvOEk6zbW3zCVQSPjvDwRQEE31/E56Q9XobltPjOaiY/1gYv000vMjjRLnXFZRVSDVnaSmFUvK4A9Tymq5WsREkWBcUcmiijX1yc9pINlHHR7W5qCmVdoeVBZm7T+9+j4GY3SwCO7MljT4KTKtGTEAqpQbtjr4SitEAy64aC6fBU1tUwKw52RbYodp1sHPPVM7Q3KjjPqda9fwMJSuvslZz0OMZwhzxzVKCut332Osldy991xRbjHQJvfV6b8z65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wTkiE3+6COCcLcwPK1oihVqB2KaPkP0BYORafuO6g8=;
 b=KLdAKc6KLveX6J8sm8A9/b9AFwkUMWuiL1PcnfkkhPpg+rAgzXkLRrDXNZUTxFnMW71ajwsy96qLTtUs3HwkKXfY/0MbKBv/YBWaPmYU9x6xqZIunq34qoELg/ZYXb4dBT/TfzXTR7SFzP6wnbz0CIet7xVpajL6p7yVF/zeG0yPm+3FiHBQmql88D4vha0jS2LeksVARfzh0uutJ+RayQw+AEd4uAtVu+GVORq4mFI335qu/+stPL4dYhGTEuGvRXEN92WsEu+wavnC7Re5lRXv3sJwT4uhD0sT9c/NWpnVki7mgbIAn11HQa6I36mjnNPMpPhVJfK7tyE93cgERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wTkiE3+6COCcLcwPK1oihVqB2KaPkP0BYORafuO6g8=;
 b=LXBoNa/vk4EK7+jS8rfhKZVRFoqqJsfA21mSvSzXYhHH1Pe9wub+2hoRmzyfpp2cDfansuZE9LIKVTRlbvH20URrFdRBhBOO9xMlWg7wo7D3+lZbGCQEMogb7n91WfnLnzP1vh62RykkOPPF5VMdbD+l/TRWeZM6ykFwUt5c82U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Mon, 23 Jun
 2025 22:18:58 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 22:18:58 +0000
Content-Type: multipart/alternative;
 boundary="------------fw6wPXSx3P8dRsHuGfYKcF0C"
Message-ID: <77dbf577-d767-48e6-b087-61dfcc478c22@amd.com>
Date: Mon, 23 Jun 2025 17:18:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Don't call mmput from MMU notifier callback
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250623165936.6178-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250623165936.6178-1-Philip.Yang@amd.com>
X-ClientProxiedBy: CY5P221CA0114.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::34) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: cc817a7f-e022-4cf0-b3cf-08ddb2a3f2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlE5alMxRjVRUlM0YWdMU0NON204SlcyVlRDR2xaSFBmZm1wak1WT1A5UWNK?=
 =?utf-8?B?Q1VGYk9hdEROSUhsTXlaQmJoOG1TRFRMR2F4SlNZRDVLVktnK0IySmNGWjRn?=
 =?utf-8?B?TWFsL3QrLzFvcXlRRXBmaW9FMkkzcGg5d2Q5QW4rRXRlUldwKzBEdXg2ZEpC?=
 =?utf-8?B?OXY4eXBPbWl0T2Q5UDVWRWhhVWdPWmVBY0VOSldNb25PcmwvWHV3bFY2MDRS?=
 =?utf-8?B?VkF1V3NQREJEc1Q4S0FxTG1Yc0t6dEk0UEU3MmVXM3krN1poSFNkSmtxbVNW?=
 =?utf-8?B?VDlCRnBMV2ZRdXB6OXoxTkRQemVjRHFYWExsNHJ0MGRld0pGZWxLbjc0YTRr?=
 =?utf-8?B?ZXFKeDdJVmllUDlhV0RyQ3JtM2ppajA0a3VucDBvVEp3YiswK0hZd0dKME1B?=
 =?utf-8?B?UXk1Vm5hNTNBczEzejJkMlRrQzExN2FSbEJOWXY1NTBoK1dEMTlrdDUyZmk1?=
 =?utf-8?B?cEsvZzJHbk1wbDhubGxKb2EySEtydlFKZ0hzNWFBZFN0ZWp1OUdmaS9RRFVv?=
 =?utf-8?B?dFdTUmJNUG9QOEdnY1dXU3JQaE1OQkdDT2lZeXJaMGs0UXNtVTZINjJKT0Qv?=
 =?utf-8?B?aW80NG1vZ3dDZG1QcjdrWStiQnd3RFRHOU93bHNoc2pxNDEzUlYzU20xcGRy?=
 =?utf-8?B?eTA1alFXaEpGUnByM1NwQUtLaXp2bDYxaWJFeU43MGNUdTU4Qk1sdndjV0ox?=
 =?utf-8?B?VUNmTjNqT0tvRHlJVmtUZGtWMVpqblVWeGJ2ZElESjBXK01IMzdlRGtIRWNT?=
 =?utf-8?B?dHZxU2MvKys4YWtZTVpKWitOVkJxTHVlRTBvUGtTQ0MwSDFRM2F0Y2Y0TTR0?=
 =?utf-8?B?ZDRWZFV6REZFd1hnUWNSb21TQUVjS0FHeVZ1dk9FRHQwaWg4UXhLVHBsOTQx?=
 =?utf-8?B?d2VnVlh5eloyaTNmNW5YMkU3TUtuK3prQlVub2o5WUczcXFLV1A0MTJYU2FT?=
 =?utf-8?B?RWVWT0tFM1MzZXhJd3VVdW5RS2tEMGgwNCtOZXh4OGs5SmlSZ0o4OGNTb2RN?=
 =?utf-8?B?cWpuSFB0UVVwSG5aODN3bzJaakNNVEZyWUNMckpFZ0hocVhaTXl0T1RDakln?=
 =?utf-8?B?NE51RStWNDNBMlJHNkJsL3hQQ2tsYmMvWUxBVFB3RmNJdHczbUtUM2lhZXRy?=
 =?utf-8?B?SXYzWnBnUGNlRkQ3ME5UT2RLZmtFVHlYZWpTWTBHS0xYODJNZnMxY1RxYy92?=
 =?utf-8?B?SjNTVTgzZzFNWHNFVFd5V1ZJOEw0OWRTd3daanZaYVdGMGJDa3ZsNVNEcm84?=
 =?utf-8?B?ZEhtSFgyeUpOQ2VQdWNva1VMYkQ1RUlwSy91VEk2SS9SYnBqT1FyTWJVRW91?=
 =?utf-8?B?bmU2UzJiRUovK1dFdW80ekswMGRlVll5ZTVLSXNKY2ZSTnhRMzNTMzEweWhB?=
 =?utf-8?B?Q0NVc3hSSWplR2wrMGxoYUZoaEhPdWZqeUIxd290MGJ2YU85M3hINisrYzND?=
 =?utf-8?B?bE15UDNEVkxQZy9YdE1RTVZRUFp5UkZYU1ByVUNGQU5CMDRoKzdDdTdrL0p1?=
 =?utf-8?B?b2pVaC9BTTVMN3R2b040eXg5V0ZGUS9paHVBQ0dMaC9MTTNFNjBOazU5N3dp?=
 =?utf-8?B?eDZTYlFwbi9IdHRvYVJLN2lUYVFTazNocmVaMEIyQk1weUN1M0VrRkhGTjB3?=
 =?utf-8?B?TTFrSTMweDhVMVo5YUsvQUVpY1Q1OHlIcVovYnZBcXU0KzdoM2RlL0lDbGlB?=
 =?utf-8?B?RFBxaldabDVKTlhQbEFFcHJaWEJ5N2hwY3drelZ6TTM0dmF0UXVVdDIyNUMy?=
 =?utf-8?B?aEZlSndNMTJqV2x6WEJCaTExVmg2Z1lWUGRVMGgwY2lWWDBrckFRS3pDek9L?=
 =?utf-8?B?MCtDancxUExwakM4dVA0UE92NlNuSFRPSEU3cFdKd3UwU2FjY2gyUEJRcVI3?=
 =?utf-8?B?dm11OWZYTXBnNDBpM09id1hGL1QzLzg2TXBhZG92WEtyVHRWdkhhZVhZMlBs?=
 =?utf-8?Q?xot8cMvpglU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0Z4Syt4ZFRraXl5dW9NbHFGcktLdGFvVERJR0s4OERXS0NidnFHdXYxa3cr?=
 =?utf-8?B?OUJiUTJaZkdwcVRFVUhZdmhpcnJHOUNoRndRbEtUYlJzbEVEdmdQR05EUXZj?=
 =?utf-8?B?dEtWU25MMmxMeEV1ckZyclhiWENxdEhscTVJVmdVWTVJd3NMMFRHdE5rWlBY?=
 =?utf-8?B?UHJuN3k2d0JrZTY4WjUyUWhUbVNmenlzckFLUEtqTGl2SklPT0YrdkhZaVhZ?=
 =?utf-8?B?MVpiSExHN3RDaVkwd2FPT0x1anlieStTeFo4UURvVXIrdnNvK1BtZ3hvSThV?=
 =?utf-8?B?Sld2QVFLWnByMlZ4NW1SZnF1SVdlTk80bVFtbHJoSnFaM2xEZkV4QXdUSFBy?=
 =?utf-8?B?M3FUcFlxRFlSNTgwc1BvallFd0FHMnF4QlBJOW9MQ3FxSVl1ZDB3dGNtZjJv?=
 =?utf-8?B?UEU1aEFZY3phRTN2YzRuOHlpNG9ENkM2ZDJXVlpmalpxZDhvWUhrcyt2UDAx?=
 =?utf-8?B?bThsOXh3OTBTNWczMExQUVZycHpaMFpYUVo0QXEwVU14UUhuYmk0bktLNzJ5?=
 =?utf-8?B?ZHI4dGd5aTdSVzBUZW9NUEdLNi9qRVJPZG4wNHVydmtBU1lwTTR1ckh0OXdy?=
 =?utf-8?B?bkVXb2RHNzMzQVk2QlY4dnkyZDRTdHljT1VOK2xYWUtnYWk0K2RNb3ErL05T?=
 =?utf-8?B?U3VCL0c4SysvU2xlaWNsQkhqVDQxb0hrVExMWDgyMnVRN2o3a3oxaTU1Q1pt?=
 =?utf-8?B?L3lJeTBsekthakpZVVM5REcyVmxScXJTTlVKNEhrUUkva2txdVF0Q3c5NThx?=
 =?utf-8?B?TmlNNGoydmV6ZExJcWdveGc0dlFqU0RSU1pIS1I0NkNNWDE2UFhKOFZ3UzNS?=
 =?utf-8?B?YSt3MEJZQ2VmeVVUWXBuVE45cVlDUE9EZDdqODcycnVCUnUrZGVPeWxua2p5?=
 =?utf-8?B?Vi9uRTlyWVB4Y0luREh1aVgwVVpQQmE2K0hqTE9rREUxZ08yRnJxMHAzb0dD?=
 =?utf-8?B?MCtKT1V0WXFJTEh3QkhoakdoVlNTbmZIV3ZVeUJhMHBibktaa0RPR3crMlZN?=
 =?utf-8?B?a1RYMjQ4T0hZbHZiK0pJaktsRW1QcmNvZ0JoWmFxRC9ZbnhWU25KU01ROTVU?=
 =?utf-8?B?UFhpMUk5bG5wV1BQNzZoeFF0UjFMUTBFeTJpdUxUYmdUL2NpdEwyVUxseDNX?=
 =?utf-8?B?cSt1U1FHcUQ4K1NjSlpDdW5vS0RwVnJUbndBcXFsUDlkSTZsWmFEMVVYWktC?=
 =?utf-8?B?NytteFdHdldPK1ErcHRxY0V3NTVGMk41cHhmVnF4MmlrVVMyY1dBRG5TaXpL?=
 =?utf-8?B?OWdXTDlmbEZYZEVrUGR5QUpiNktKNTEwMkdzRVJGNWhkTk01UGxlRTNZblZ4?=
 =?utf-8?B?Wmp1d0d1WGJwNXVvRjVwY3JNRDJpZ3h4NmM1QytNM1F1Rys3OVpNRXU2ZHFy?=
 =?utf-8?B?WlpGMXVsMjlLMnZ4ZGJZcXRMSm9ROUxNQzFJSlhmUThWNzJXZnpPaC9Zc0Iw?=
 =?utf-8?B?V3RJL1FjcXRYQ2grRXp6MkdOWnUrZDZCYzkrY0VtRE45ODBodUZpQy9JZkF1?=
 =?utf-8?B?MDRwTGxBdU93c0J6bGZRb1ZiSk5GL2tESlg3VnZEbDQ1UGZIT2FlVU12a1Ey?=
 =?utf-8?B?cllTaEhpQXQ1bExSdnFVWkRXRmx2OVpWeDQzcTlEMGZNZktDb1ZuODVRK3B2?=
 =?utf-8?B?ZTNPbUVJZnhhRmx1Q085eUVPMk9ZSkNQekZ3S1lXUFJYMUxQZW81d0tYa3gr?=
 =?utf-8?B?ZC84WkxkbTJ2UW1EZnRNc3didCt0WGJaenhTVzdGRzhUdTBNQVF4Sys5QXQ0?=
 =?utf-8?B?RjNYMExSM0xkWW9XcDNVdjhPa2swY0Z4YnhYRmdlR1VjQzJmdytQQW9MTFJ4?=
 =?utf-8?B?c0o1dE8yTWtlbEt0V2pmZmlPZVdxV2I1YnZQU1huWHRuZVBLRjlKN1NGRzdR?=
 =?utf-8?B?ZzZ2bTk2UnBibERHN3ZMZFE3cXd6WkNwMnQ4MzkrNUZJd2Fiemt0Mi9qbnFm?=
 =?utf-8?B?S1M0L21rT0VIM2hPelhoem5QYmhjNGMwUGJyS1dSQkdBbzFCMXcwTVpPbW9X?=
 =?utf-8?B?d2FNWDdnN1pUbk9wNVc5TG55bG5aQ2dwZ01XT2NVSDF2cVpoMkZBclUwT0VS?=
 =?utf-8?B?ajdLSXlvMHRKQnlNT2YwL1R5SnhhZmpHSVBWZlcyRXZtVEJTWWlWMVptd0N4?=
 =?utf-8?Q?dXqo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc817a7f-e022-4cf0-b3cf-08ddb2a3f2d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 22:18:58.2033 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQEDJpF836hhFGk0SwhfzX9hTEk6y805KuQAAEFh9g+wj38AJt4KExaSJcAf/L1m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
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

--------------fw6wPXSx3P8dRsHuGfYKcF0C
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/23/2025 11:59 AM, Philip Yang wrote:
> If the process is exiting, the mmput inside mmu notifier callback from
> compactd or fork or numa balancing could release the last reference
> of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
> with below backtrace.
>
> The deadlock will leak kfd process as mmu notifier release is not called
> and cause VRAM leaking.
>
> The fix is to take mm reference mmget_non_zero when adding prange to the
> deferred list to pair with mmput in deferred list work.
>
> The backtrace of hung task:
>
>   INFO: task python:348105 blocked for more than 64512 seconds.
>   Call Trace:
>    __schedule+0x1c3/0x550
>    schedule+0x46/0xb0
>    rwsem_down_write_slowpath+0x24b/0x4c0
>    unlink_anon_vmas+0xb1/0x1c0
>    free_pgtables+0xa9/0x130
>    exit_mmap+0xbc/0x1a0
>    mmput+0x5a/0x140
>    svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
>    mn_itree_invalidate+0x72/0xc0
>    __mmu_notifier_invalidate_range_start+0x48/0x60
>    try_to_unmap_one+0x10fa/0x1400
>    rmap_walk_anon+0x196/0x460
>    try_to_unmap+0xbb/0x210
>    migrate_page_unmap+0x54d/0x7e0
>    migrate_pages_batch+0x1c3/0xae0
>    migrate_pages_sync+0x98/0x240
>    migrate_pages+0x25c/0x520
>    compact_zone+0x29d/0x590
>    compact_zone_order+0xb6/0xf0
>    try_to_compact_pages+0xbe/0x220
>    __alloc_pages_direct_compact+0x96/0x1a0
>    __alloc_pages_slowpath+0x410/0x930
>    __alloc_pages_nodemask+0x3a9/0x3e0
>    do_huge_pmd_anonymous_page+0xd7/0x3e0
>    __handle_mm_fault+0x5e3/0x5f0
>    handle_mm_fault+0xf7/0x2e0
>    hmm_vma_fault.isra.0+0x4d/0xa0
>    walk_pmd_range.isra.0+0xa8/0x310
>    walk_pud_range+0x167/0x240
>    walk_pgd_range+0x55/0x100
>    __walk_page_range+0x87/0x90
>    walk_page_range+0xf6/0x160
>    hmm_range_fault+0x4f/0x90
>    amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
>    amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
>    init_user_pages+0xb1/0x2a0 [amdgpu]
>    amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
>    kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
>    kfd_ioctl+0x29d/0x500 [amdgpu]
>
> Fixes: fa582c6f3684 ("drm/amdkfd: Use mmget_not_zero in MMU notifier")
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 10d1276f8e1c..5fe92f9a1ce1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2392,15 +2392,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
>   		    prange->work_item.op != SVM_OP_UNMAP_RANGE)
>   			prange->work_item.op = op;
>   	} else {
> -		prange->work_item.op = op;
> -
> -		/* Pairs with mmput in deferred_list_work */
> -		mmget(mm);
> -		prange->work_item.mm = mm;
> -		list_add_tail(&prange->deferred_list,
> -			      &prange->svms->deferred_range_list);
> -		pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
> -			 prange, prange->start, prange->last, op);
> +		/* Pairs with mmput in deferred_list_work.
> +		 * If process is exiting and mm is gone, don't update mmu notifier.
> +		 */
> +		if (mmget_not_zero(mm)) {
If process is exiting we not need do schedule_deferred_list_work 
neither. I think this part code need be reorganized with 
mmget_not_zero(mm) check.
> +			prange->work_item.mm = mm;
> +			prange->work_item.op = op;
> +			list_add_tail(&prange->deferred_list,
> +				      &prange->svms->deferred_range_list);
> +			pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
> +				 prange, prange->start, prange->last, op);
> +		}
>   	}
>   	spin_unlock(&svms->deferred_list_lock);
>   }
> @@ -2568,8 +2570,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   
>   	if (range->event == MMU_NOTIFY_RELEASE)
>   		return true;
> -	if (!mmget_not_zero(mni->mm))
> -		return true;

Why remove mmget_not_zero(mni->mm) /mmput(mni->mm) here? I think they 
are for different purpose from mmget_not_zero(mm) at 
svm_range_add_list_work.

Regards

Xiaogang

>   
>   	start = mni->interval_tree.start;
>   	last = mni->interval_tree.last;
> @@ -2596,7 +2596,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>   	}
>   
>   	svm_range_unlock(prange);
> -	mmput(mni->mm);
>   
>   	return true;
>   }
--------------fw6wPXSx3P8dRsHuGfYKcF0C
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/23/2025 11:59 AM, Philip Yang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250623165936.6178-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">If the process is exiting, the mmput inside mmu notifier callback from
compactd or fork or numa balancing could release the last reference
of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
with below backtrace.

The deadlock will leak kfd process as mmu notifier release is not called
and cause VRAM leaking.

The fix is to take mm reference mmget_non_zero when adding prange to the
deferred list to pair with mmput in deferred list work.

The backtrace of hung task:

 INFO: task python:348105 blocked for more than 64512 seconds.
 Call Trace:
  __schedule+0x1c3/0x550
  schedule+0x46/0xb0
  rwsem_down_write_slowpath+0x24b/0x4c0
  unlink_anon_vmas+0xb1/0x1c0
  free_pgtables+0xa9/0x130
  exit_mmap+0xbc/0x1a0
  mmput+0x5a/0x140
  svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
  mn_itree_invalidate+0x72/0xc0
  __mmu_notifier_invalidate_range_start+0x48/0x60
  try_to_unmap_one+0x10fa/0x1400
  rmap_walk_anon+0x196/0x460
  try_to_unmap+0xbb/0x210
  migrate_page_unmap+0x54d/0x7e0
  migrate_pages_batch+0x1c3/0xae0
  migrate_pages_sync+0x98/0x240
  migrate_pages+0x25c/0x520
  compact_zone+0x29d/0x590
  compact_zone_order+0xb6/0xf0
  try_to_compact_pages+0xbe/0x220
  __alloc_pages_direct_compact+0x96/0x1a0
  __alloc_pages_slowpath+0x410/0x930
  __alloc_pages_nodemask+0x3a9/0x3e0
  do_huge_pmd_anonymous_page+0xd7/0x3e0
  __handle_mm_fault+0x5e3/0x5f0
  handle_mm_fault+0xf7/0x2e0
  hmm_vma_fault.isra.0+0x4d/0xa0
  walk_pmd_range.isra.0+0xa8/0x310
  walk_pud_range+0x167/0x240
  walk_pgd_range+0x55/0x100
  __walk_page_range+0x87/0x90
  walk_page_range+0xf6/0x160
  hmm_range_fault+0x4f/0x90
  amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
  amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
  init_user_pages+0xb1/0x2a0 [amdgpu]
  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
  kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
  kfd_ioctl+0x29d/0x500 [amdgpu]

Fixes: fa582c6f3684 (&quot;drm/amdkfd: Use mmget_not_zero in MMU notifier&quot;)
Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 10d1276f8e1c..5fe92f9a1ce1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2392,15 +2392,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
 		    prange-&gt;work_item.op != SVM_OP_UNMAP_RANGE)
 			prange-&gt;work_item.op = op;
 	} else {
-		prange-&gt;work_item.op = op;
-
-		/* Pairs with mmput in deferred_list_work */
-		mmget(mm);
-		prange-&gt;work_item.mm = mm;
-		list_add_tail(&amp;prange-&gt;deferred_list,
-			      &amp;prange-&gt;svms-&gt;deferred_range_list);
-		pr_debug(&quot;add prange 0x%p [0x%lx 0x%lx] to work list op %d\n&quot;,
-			 prange, prange-&gt;start, prange-&gt;last, op);
+		/* Pairs with mmput in deferred_list_work.
+		 * If process is exiting and mm is gone, don't update mmu notifier.
+		 */
+		if (mmget_not_zero(mm)) {</pre>
    </blockquote>
    If process is exiting we not need do schedule_deferred_list_work
    neither. I think this part code need be reorganized with <span style="white-space: pre-wrap">mmget_not_zero(mm)</span> check.<br>
    <blockquote type="cite" cite="mid:20250623165936.6178-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">+			prange-&gt;work_item.mm = mm;
+			prange-&gt;work_item.op = op;
+			list_add_tail(&amp;prange-&gt;deferred_list,
+				      &amp;prange-&gt;svms-&gt;deferred_range_list);
+			pr_debug(&quot;add prange 0x%p [0x%lx 0x%lx] to work list op %d\n&quot;,
+				 prange, prange-&gt;start, prange-&gt;last, op);
+		}
 	}
 	spin_unlock(&amp;svms-&gt;deferred_list_lock);
 }
@@ -2568,8 +2570,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 
 	if (range-&gt;event == MMU_NOTIFY_RELEASE)
 		return true;
-	if (!mmget_not_zero(mni-&gt;mm))
-		return true;</pre>
    </blockquote>
    <p>Why remove <span style="white-space: pre-wrap">mmget_not_zero(mni-&gt;mm)</span>
      /<span style="white-space: pre-wrap">mmput(mni-&gt;mm) here? I think they are for different purpose from </span><span style="white-space: pre-wrap">mmget_not_zero(mm)</span> at <span style="white-space: pre-wrap">svm_range_add_list_work</span>.</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:20250623165936.6178-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 	start = mni-&gt;interval_tree.start;
 	last = mni-&gt;interval_tree.last;
@@ -2596,7 +2596,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
 	}
 
 	svm_range_unlock(prange);
-	mmput(mni-&gt;mm);
 
 	return true;
 }
</pre>
    </blockquote>
  </body>
</html>

--------------fw6wPXSx3P8dRsHuGfYKcF0C--
