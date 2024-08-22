Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F4CC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 14:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EE410EAFC;
	Thu, 22 Aug 2024 14:35:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U8TlH4xs";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 419DD10EAF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 14:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zee7BnmUg9ZyS4veh1ll+5DcYc/l7mGxrLCteD1Q8VWjd/gOUXG9rEMh3EIuM9bp8rQRUVQfBUa+BlDu4+QvUMUlIpo04+27mXjmUkZkVEQOIXEnic77UekNPa/kE3R7tNc18Q/tYSo00+qRwU9iIqUMyCJCuRW3XPYsCEOGkoU+x3jAUzqLb93vqOSCAII1s8czCtjCon5MKi6gsbt0HT1mGUAWytP/n754qOLzgXyAORmbLkkQoqGg14wKAnBAxvDmKZhi4lPCmqDZTOtpaolX8HoqFFfy8mt7bBdTcGsOd/GVz8lctDIW11Ub2RYTYV2W/FjrnGaZwa//xlzQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzBLxZjDWIv/pp4rJhsKDIkcUlNL7BF7xeUQwfoujRE=;
 b=VN8SZ+OASUGrVkdZEPiQBhyRtUTMUCrqld6bLM7QZQIJRnzkxIZq15Yx2e65CvY1FXjUa4l6YvIW39ThJGvkgaE05e/6q/jU9eVWhlu8K/Vqp3kJ6qjxnvdghzzioLH78U86PBpGxaoxhAv6ZpXnjMte4QfPccAYMQtPrznp/HSysqEo4l/j5O8AKkCDkEWo3+aKTRkY6/MDo227xWjtU0Sc1fbY9HrnmbNcizYZRNDnPf0X0L873mUBZpIotuzhW79kgUg3SEmbXrcZ/Qa3sGD4P/My1t+TBwD9ys9q7nKYxGDgd5vxNSsDkorulaQH3eJQFLiRUYZUr5EQTpN8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzBLxZjDWIv/pp4rJhsKDIkcUlNL7BF7xeUQwfoujRE=;
 b=U8TlH4xsbMxE4Hl3cexj3JGQzU/WlV2DHPP6onXLHew+0K9ldUV45ktznj9XDUqkh3sfNTf7umNZlo4IKDy76pELBkBKYbYh6bwWnRMhBthY4O88jjIrR4GkhLh0ICqIwSYWukNc2b0GUw7VeiRr6KU98Ke0zTobzqOZ+8aeRxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 14:35:19 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 14:35:19 +0000
Message-ID: <478425e7-ce6b-4573-9119-c40b555bd6df@amd.com>
Date: Thu, 22 Aug 2024 10:34:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Increase SMI event fifo size
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20240730201547.13590-1-Philip.Yang@amd.com>
 <20240730201547.13590-4-Philip.Yang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20240730201547.13590-4-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::21) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: af9395ab-975a-4731-58b8-08dcc2b7a566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHBxS0RLTkhUR0hxZ0JRNm02eXVPTWRyZVFMYmRTU0ZweEZEbFJjZHBEODhE?=
 =?utf-8?B?akJZa3ZIQ0NtdlY0VlhYb3BjM1l3bkl4S0cxcmc5Y1JUVHo2QW5kUWgzdXFj?=
 =?utf-8?B?WWpsRGsxREd5a0kwc0JKamhwc2hoTEl6UkV2WXBZUEMxRTBscVhjcDNwNDVX?=
 =?utf-8?B?ZU5aK0t4eGxFZXNLTE5qU0IySHFqb0hPQnZrdlV3akE4clpLbTExaHZsb0VW?=
 =?utf-8?B?dGdGd2xLOTR2SkNBb2hPbCsrcnhmRHRDNmJCenVLQTJ6dDlaMjNnTG52UUJH?=
 =?utf-8?B?TW53azMrRzJZbHJxTHJuQmEyT2p3bE1Iamo0MEQvWW1NdWNKeGRkQmNhaVZ0?=
 =?utf-8?B?K2J1RVdPSG9zQkhBNzc2NUhPNWZkejJDcmN1K0pQelpxQVlJdUZ0YUZ2eFBy?=
 =?utf-8?B?d3NRTWRySC9Fb0lWd2NZeXB2UktIUWFoZnlLQmlwbVNuTkZGbFRwL2hxS1Ay?=
 =?utf-8?B?NFNrR2hxdnhLSUsxZUpNZERXWkcwSTZxMDViallnMlV2cmF6ZzJ0N3JKS0pF?=
 =?utf-8?B?QlgwMUw5TVF0YVBoOWRESExtODZvcGVBaUM0ampxUWg3MFNwRGJPb2djY0tr?=
 =?utf-8?B?RUZPT3hsWDUxK2MwSVhBN3QzUkphQ3lpazBFVnBNaEg2eXVwd0pVVDJ3SkxX?=
 =?utf-8?B?S2N5NWpnbzNZai9zVlZ6RXovZVZMMVk1UEpqbGxXMFVxWHB4NHNuU0JOWTJB?=
 =?utf-8?B?cUkzU0dBMFB3UDlxZnBHd3BzeDVpcnN5WEFKVUpPU3VIWGZicDRZMjdsT1hS?=
 =?utf-8?B?ajlzcE5SODViU1k1QTlpU0xqcFBCay9xbTl6aXpMZ0dpRCtDMzNJMVVqZzMz?=
 =?utf-8?B?aVlINk9zSnVBaGh1SlhxeU5XMk9kVHU4U3RWWGpKMTc0VCtxdkJwcUthY2g0?=
 =?utf-8?B?a0ZxYkovT2VVQ1E0U01aZDBVUjBKWmVkRnhOZ1llL2t2MVNzOWtuZ1htRUJl?=
 =?utf-8?B?RWFBM1pRSXNib2crQXd3VGoyS09jV0trNVlnRmtuMHQ2QUxFZkYzTlpDSTRx?=
 =?utf-8?B?emRUb2U3bFlSa25BSkQyU3NYREhyREZUbzZwRXpnTUZ5bzJZZWtYcUs0ZlpB?=
 =?utf-8?B?cmdxMlZua3FMeG5LbXRjMzFRcVViaEZWZ3h0enhwQUhYN2NFZGVKQ1hUU2VU?=
 =?utf-8?B?Qk1QeVYxbWlMMWozMURmdGxYN05iV3hGdksvNit5WWJ4UlFsR2pkUUVSb2Ir?=
 =?utf-8?B?elVsdnlUKzdOV25pQ295THpBT3QxTHg0Zkw1M2h4NUNLNWlFOGZPc3k5eTdK?=
 =?utf-8?B?NlptMzJaZFZ5Z1hma3hBR0oyUUlrUC9LS0RzWkNPcng5bW5jMmxhWnJadzlU?=
 =?utf-8?B?azFvTDN4VmJmYmFtanVZY241RzdYYVVscHdpNHVTc3ZjZDF3UjVoYjA5K2ov?=
 =?utf-8?B?WktpZGFMWlNUMHY2TURHemdNLzVWeXRQcXZJMzRUQlB0dmNxZ1laRjk4WnZC?=
 =?utf-8?B?NzdUYmVBT3R3d21rcHpGeWhFR1Yvd1c1eVg1enJnWG9yN3ZOVkN0bVFPWmYw?=
 =?utf-8?B?ZkFqbUpubDYzbFRvRWtSRnJwSTY2YW5HcVp4clRHRmJlMG9ESWt3VjltWnM4?=
 =?utf-8?B?bmk3dlRMcWxIdlBlL21LcWdCeG0rWXpUb1FEOUVWbnJHWldQZUlMbHBNTHhI?=
 =?utf-8?B?cE9heVF4NWVIcERDY3RWVXY4eVdWNE82UUxMQkxKWXpCalJWY2hTdlBhUHRy?=
 =?utf-8?B?N0ZSTzFrRHBTdXZETmo3OXlqMGxIQ2RPTWR2bHdQNnVySm04TTROM2xoWGJR?=
 =?utf-8?B?dHJHQWxpeGgxUlFZcFFxSmFZdW95bTNnRU5BKzZFY1hHUGRBeDhtY3BBNnVz?=
 =?utf-8?B?UFpGS3FvVzkwUEQyWFIzZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnZXa1d5dEE2ZFBCTlNBQzAyaENjMlNET3poK1BZVGs5RnV4bVBVZ3ZYRHE0?=
 =?utf-8?B?OEFkcWdOUnhiMFBaQ1lXblpuWVFuWUw0UVlzTkcvcWFxNEdVaHlwSm92ZHFM?=
 =?utf-8?B?aitENUhMdXVwemZPNTIrdkpQd0dwK09QL09DZXdVcXdHRTNNY2FkT0EvUEJC?=
 =?utf-8?B?S0NUMWM0ZzFUQ3BmN1BIa3NFZlpFRDdsUTRGdGdSRm41dmxRMDR0dHZwSFlQ?=
 =?utf-8?B?SzlBYXN0SkxMZ0lFNHMrMWxsdXdvR3Fma0NNT2FaYWd0Z3FuM1Q0Z3FkM0ky?=
 =?utf-8?B?SUM4dk02TmRmWjB0U3RFTUhOZlR3a1djcEt5dFhGRU5qWmxCdnpMbm9qYTU2?=
 =?utf-8?B?Z3BjbVNIVTl6eDJCWWNvemNvaVI5amNkaUdQTDQ5UE8xdUo0dldLdGFQdkIz?=
 =?utf-8?B?d3hMdGtFMW9vbXZKL1d2VnhXeXJOMk8wb1lEZGM0MFpaT0trelFqd1lFRnRO?=
 =?utf-8?B?dWdVNTZBeW1GRzN1aHU5QmRsMURLL1M2bkxIcnFhRmIwaWJpdnQ0RHFjMXNa?=
 =?utf-8?B?REJyaG1zRi80S1ZBRnJOOFc2QWcvZEZmbWJrUWtqY2FaU1lITkhWUlRxOVFF?=
 =?utf-8?B?WkYrTjdhTnNyL21Mc3dGQThjcVNhSFZKQTZsZFZiLzllYXhQZ0hQVG01Q0E3?=
 =?utf-8?B?NFRKV1dXa0RYOEREbFo0cXAwRDFGeUlyeXZ5WkRNMGlXdzN1YW1RNllRWkhD?=
 =?utf-8?B?cmNxckRXQnpTVWNaNnJPMC85bEpHbTB6clNjSWwzUzFZTHc5NWtva3Z6WmV5?=
 =?utf-8?B?a0FUaHJkcE00bk5hbEFZZHRnYXlOcmlqVnl3NEgrZWZJK012K04va1BKUDN6?=
 =?utf-8?B?eEd5aTgxQUhyc0RYMHJYVFVMaml3Tkl3WnJhanpUUmFhcVladTZKTnlJcmti?=
 =?utf-8?B?dGNoc1hZMXdPOFF1MUhOVlRFT2FROG5BZTJDRGZQOFd4U3VwMk1xblRwQ1ln?=
 =?utf-8?B?TnFRV0F2UTVBTTBRQWhlVHFKcklaS3ZYb1pzRnM4SFlxY0IyaERWUUNVMTlh?=
 =?utf-8?B?VUcycGc4ZmpxVVZFczZncUNPRlgwdG5Yc2xpTUwvNitiRXI2QTd5dU5qS3F4?=
 =?utf-8?B?VE83MEhMTjZCUlJ6TFdiUGx6b2ZrQUxYUVQzakQ1NkVmMkdEcUJLZWZvUXpy?=
 =?utf-8?B?K0ZsekJBN2xLQnBzaC8wSDFZZjVmL1JXcW1uTXFUaDI5dDkrQ1Q4OGNXNWdD?=
 =?utf-8?B?V0ZJcks5SFpWL3VzcExZcTNIY3llU3lsZ2czTFdCeU0zRWRrM3NTb3Q2bS95?=
 =?utf-8?B?d2VabXJSYURiYjlNYnVpVjJrb1BMdi94UW1HRW02Ulk0SlkzR0NqWXgyOU53?=
 =?utf-8?B?eHhvOEFYRTc3eWt1QmhYK2VidzNhTkRETHpBWEIxSDJPRW5uMUl5S1g3Z1dm?=
 =?utf-8?B?TUNVTmU0Y0ZrUDZkcERiZitqNjJXaXl2Sm9WeVlFUnVsMnpNTFVHRm5TNXFp?=
 =?utf-8?B?MkxaeXpUWGRneFpaQzQ5L05MbDIwUGFMLzJRZ1FBWHN2ZjFsVlFyVjNVNGFv?=
 =?utf-8?B?MUF4NGNURmdnRmZJZmhxdjhxS1gvcVZ3MFRPUFliOFBkdmdlV0czSXdyb01K?=
 =?utf-8?B?Vzl0RXNPWjM0eFV4VTVhUytVS1g1NDhrMlhGQzN5OWVUeGNJQXIycFZOcWJE?=
 =?utf-8?B?R3Y5YWJCVTJoQVhneFdFZ2EzRE5jem1vbVZxa2p0cGVNdlhrODdxbXJtMFBr?=
 =?utf-8?B?NmNqODZDMjhrb2lqV2U4SFZUWkUrZElsWEMySll6R0tlcUtPRUJWZ2x5d0tT?=
 =?utf-8?B?MkRjVW42WGdONVdCT2MydzgxckpPdmF6R2FTNm11QmtHa0xlVncrTGtQVUJi?=
 =?utf-8?B?VzVXKy8xNVY2T011UFpZczRjV0ZNc29Rek1OSm5LL3ZLN3lMVzhma1FHOEc3?=
 =?utf-8?B?b1VsZ05CdkpVZStJRWRRNFFSVExwSGZPdHBodE53S0NYczlNMElzejV2QktR?=
 =?utf-8?B?ajhrNE1NbXUwai95YUdEWnNKUWVRN1JqUVZUUWNXQ2VuVUxsRU5rWVdLVXFz?=
 =?utf-8?B?d2JaOHdpWTFSRUc0eStQckdnUE9EME52LzZkRko5SnhLWjNpZUlTaGFBd3hz?=
 =?utf-8?B?TjIrNUtaVjVoRHkvTUxaOFIxNWNsZGpYQUdRelBTZzY3N05ad2ZPNFVUZ3Jz?=
 =?utf-8?Q?KvP3WfpQWKfIEuzyYAHH/KvVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9395ab-975a-4731-58b8-08dcc2b7a566
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 14:35:19.1116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8zoiQ56DS7+scGknCdGKVcFGJArpdGn95rmsIy1DRAcd5tmSVtSwm91u4q1fnXG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
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


On 2024-07-30 16:15, Philip Yang wrote:
> SMI event fifo size 1KB was enough to report GPU vm fault or reset
[JZ] There is a typo here. it should be NOT enough.
> event, increase it to 8KB to store about 100 migrate events, less chance
> to drop the migrate events if lots of migration happened in the short
> period of time. Add KFD prefix to the macro name.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 1d94b445a060..9b8169761ec5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -44,7 +44,7 @@ struct kfd_smi_client {
>   	bool suser;
>   };
>   
> -#define MAX_KFIFO_SIZE	1024
> +#define KFD_MAX_KFIFO_SIZE	8192
>   
>   static __poll_t kfd_smi_ev_poll(struct file *, struct poll_table_struct *);
>   static ssize_t kfd_smi_ev_read(struct file *, char __user *, size_t, loff_t *);
> @@ -86,7 +86,7 @@ static ssize_t kfd_smi_ev_read(struct file *filep, char __user *user,
>   	struct kfd_smi_client *client = filep->private_data;
>   	unsigned char *buf;
>   
> -	size = min_t(size_t, size, MAX_KFIFO_SIZE);
> +	size = min_t(size_t, size, KFD_MAX_KFIFO_SIZE);
>   	buf = kmalloc(size, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
> @@ -355,7 +355,7 @@ int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd)
>   		return -ENOMEM;
>   	INIT_LIST_HEAD(&client->list);
>   
> -	ret = kfifo_alloc(&client->fifo, MAX_KFIFO_SIZE, GFP_KERNEL);
> +	ret = kfifo_alloc(&client->fifo, KFD_MAX_KFIFO_SIZE, GFP_KERNEL);
>   	if (ret) {
>   		kfree(client);
>   		return ret;
