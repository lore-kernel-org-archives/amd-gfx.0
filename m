Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7CDCEE34C
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 21:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC4910E80F;
	Wed,  9 Oct 2024 21:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zsADQhFc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7FE10E80F
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 21:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST3+Or5kxGzPg7icXNJRYL8U28V1a7Ea9mer2dubgVz99RvNTaR3Vp92OMb+Z6YFi7rsqfXuPv/WFrrN9kgQ5L9P6Rt4akdueKDCRVw3zGRM3EOYj+7TXN/RoyzDZv8ZPHVfm/AI7cqzdhMga0nC0F7gkXjJBmF8CixvkdhbCxd8xHY74eOofxXmnC6wV5c8Sl+JCl3eGJ5suSvxTZ2dcrwRUQe/fY0VpxxmLaTQ8e2HDyY3510xs69vJFUlM5EmsSfKtlTEPqIuQUfLQeKdvhE5xVbLMtDOVOj2es3+r5T+yeXFMOkxHhindCa9C34LpnaZDYH21AC+2MKqn3ccgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVRVUcoaFW0PNQVFtML4Btumzfh3GynHun+zQzTsgd0=;
 b=WVeL51s87mBw8IROlFir9brwvZywBjj3QYX4D67NPuO+YSEG9hsoe6IH6Rykc8KuifWolqIpqRTfQRxjQshVZtC7GSSi97yvbARx5ooeAUzs1gV+h8gRCa3qNViooFV67tH4hnhijmBE0ojDIHoGkSmc+eZPz7/aihnS4eH7YOc7BEmCsYncGKpLcCwJLjZE6Il90jXE1RApdEXkKIICmJTeGksZNIIG0HAVgI2mVv+MWsQHZLX6fNgWfxhbjS3Oc+S99Wx9kXOjAAEugNSmEwGq4UiVH4KrdnuOOE1sqIVcPZozZXL59JLm7gHfoVNHQFoiVi0W2bDjSw6etEFNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVRVUcoaFW0PNQVFtML4Btumzfh3GynHun+zQzTsgd0=;
 b=zsADQhFcosetRkDZCcsKp1cAEVanyqnWbGOqUq594WyTrV9arb/UcgEAJ/sl8CQ9dVLl6JMkP0+fI0VwyzGCv0yfzpZ8LifN9Npf/wPqVLCQHyqEGx3SxkZx4I2QDvEvNezY3MpBxBgUeMSIDqEwdRNVNDtEuAF++ouEeeCqM00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 21:02:46 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 21:02:46 +0000
Message-ID: <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
Date: Wed, 9 Oct 2024 16:02:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
Content-Language: en-CA
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <56b95963-f617-4578-a660-37eb471edd68@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::34) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c93d75-0df4-4d78-1e37-08dce8a5b968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUlUemhKVFdWTnZYbjZiVUlPRTZYM2FrRjF1NWlyb2tFR2s5aWQxck1rb3Iz?=
 =?utf-8?B?NUdlcklTR05ISkt4clJmYVF3T0Z2Nk13N00yNG5ITFUwMGE4UUVQekcxdDZj?=
 =?utf-8?B?RW1QbXQvL1hpaDYxVVJJejAwQnFpWHJMcEZxcjUwbEhKY3hNTkcyeXUwWmNa?=
 =?utf-8?B?bWxHV2ZtWGczbXJEM2pJWHZodllGVWIzZGJLQ3N3R3pId1RTb01kbW1lSkFy?=
 =?utf-8?B?c3dZWDhYSHk2TElxOWh5T0lQTk8zWHVsVVdHU3krNHlxcVZsM1hZUEdIbm14?=
 =?utf-8?B?ODNyM0NBU2ZTS1ZldVJTbnJvSlJURHpKb2xQekNqNnd6bTlHN2NrTHYvWGwz?=
 =?utf-8?B?Q1RtUTZGMWZKMkxRd0RZR21VbjJKamZVaWZFQisxRGpMMld5QnMrVENneEM2?=
 =?utf-8?B?QlZoUFgyMCs4OTVJQjRXaTk5RTZTaW1GTjBYR1Y2NFVJRmR1UnQxaEdIQ1hS?=
 =?utf-8?B?YlZDZ2lGSnNUUWtjdEI5Y2I2WG5PZ3JaSmROeEhQT1ZEd3ZMK253Undrc2hn?=
 =?utf-8?B?Ti92TzYxK2lPMWV2ajFsdm9LcWcrclFHM3I3a2t6NTljcVErdEk2Nytnb0NY?=
 =?utf-8?B?dTJEaGNJUnEyUHZOdkRSRnEvclhoaG5UeFV6L21oaC9MNzBRd2ordm5PNjE4?=
 =?utf-8?B?Q3FRRUpjdVJzOWFOQTdOWVU1WGFndlVzK0s2QkVQdXFRYmQvUXExNHNjRU1K?=
 =?utf-8?B?YzJRQ1Y1VDFUNHNuRXJPMFBrQnVxSEJ3ZDhwWFZXaU10dkt6NU10aFpHSmpj?=
 =?utf-8?B?VHErby9vaUtJMk5ORE45WVpFN05QUlR1TXdLQVR5cmZ0RHZhOGNmTXlSTFVP?=
 =?utf-8?B?VzVtaGtaVkk1dm1lYzFjTGlKcFpWY1JaVXFIYUg1bXlFdERtVjlKWGphcHEr?=
 =?utf-8?B?elA1OXM3YWRrMEY4UlovTGtLd09pWVNIWEJ1ZllUd252bGdldjBLb0NFZXAv?=
 =?utf-8?B?SS9yZ1ZuNG5sUUZVdGQ5VDRBMTh0QTU0TTZaZ3pzbklKNlRQNmdJd1M5eS9X?=
 =?utf-8?B?dW9jdFI4ZC9ZZk4xWEpkdnltZGVIeElwV0ZwZHNxNG9KRFZ2QUI0QW1jSHVN?=
 =?utf-8?B?QnZHL0tzNHIrSDN4aTFMa3BxRStaOWxOS1BrMC9tSEM5ZUhlZUhuVjgvc0FV?=
 =?utf-8?B?NUJQUzZYa1M4dWlCaElSK0dsa2I2SjBHTzRvektrWTlaUHE3dkYzTWprdnVs?=
 =?utf-8?B?MlZadUdMK01YSCt0dDZ3OWUranNuZ1F3dmwrUVNjWmI4aXRmSXphWkcvN1lL?=
 =?utf-8?B?TWxnMkFnc0VxTnBNMVJzd0hQRHZ6RW1DcVNUcVhvWGdyRXI4WElCR2h2Qzda?=
 =?utf-8?B?eHRHT0hMdXUvSW9KcjB3dkV5TXBiaW9XSFVJUWRSZUJ2V0hNUlBocldEV0Nl?=
 =?utf-8?B?ejUzYnhoQ2xldDhRSndTMEtPa2ZHSUtHUUFHMGJGc3FNZEtnNStJNWZ2MjNx?=
 =?utf-8?B?SlpQcHowZW8rZW9wemJHQUZwS0xyREJCeUdoNjZhd3EydkJGSlZWM1RHc0h5?=
 =?utf-8?B?ZUVaUXRpWkhlVWJYcUFranJnVUVSOUgvTjMvOWEvRlc3KzJNSnJaTkxwREM4?=
 =?utf-8?B?NXc2bEhsWDYrY21GdTdFSVdDOGZXa0xGajhBbHM0QmtkdmMzK1BJZkhId254?=
 =?utf-8?B?Z2I1algxMXhHMUJoamFZSEJCS0cyVFZLT2ZxbnJvNUFTNWU3aWFMMVZSQURG?=
 =?utf-8?B?VW9rNHBQL01WMWlGYjhTU3BsYTRsS0ZLc29Ja3JNL1l6ZFlXc1I3b3B3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFdpUTVHTm9aaGZqRTFaNG5ualI3TkIwTDhveVB4Z28yeFFOaklZc3NJY2ky?=
 =?utf-8?B?R3NmVDdrdWhNQ2dqZUl3ZDN3ekNxVE5pRFJwMTM2NjJ6akVsZW16cERSZE1V?=
 =?utf-8?B?eStnMGpFTnVjLzBzYkxxZ1V1elg5dnBwUHpOMnprQUR3bzROcHRWd0F6b0o2?=
 =?utf-8?B?VWRDODNES1ZpQllpaGR2d3p1K3N6ZUVROEFMMjN6eldDUnN2VzBIcUVkdFor?=
 =?utf-8?B?L2I2Qm1YMXVSMHdVVVFjYytlcGJ4ejkxM215ckQzMUlHRDhLbGI0dmdVVGF0?=
 =?utf-8?B?RlZVMEJ2RDdKRGpkUDN4VW5iSkJqT0ExMTRSQUM0QTVkaXVmb0VHUHpEdEkz?=
 =?utf-8?B?bS9zaGp5N2w3NW83bkhOVHFIemFIL3ZLbEJzcTNOYU1SbUFaOEc4dWJRZkFi?=
 =?utf-8?B?ZFhhcFdhSmpHNy84T1VFM3V2cHpoOXdlU0Q2R0RnSFE4RFZWVU42ZUlZYTFn?=
 =?utf-8?B?OWJhaThUK3ZFYzh2Wi9ReFR2dWpnSzFtRGVvVFRLVVhaNnlTbDIycWx1NTRo?=
 =?utf-8?B?cEFSRWV6QU1vaUlCdXRXdHlRSWRwbDN6L0lTS3NUVE1ZU0RINXNhK0paMVdN?=
 =?utf-8?B?S3RYL2w0RFU4NjZuV0RDYjd4U09ra2xjenRXWlpyalBOWldidzQ4QWZUVjF5?=
 =?utf-8?B?Yk9XMkZ4dmJ2dmVqQ1BBeU9GMzYvSTB4RndvdjdIYVAwd0lVYUxqRnA1bDBS?=
 =?utf-8?B?VUNhRmxIci9vdTBXVFRPRGlzWHk4Ukdtb3lUQkJJQUxHK1VqTi9Oc0p3TFZq?=
 =?utf-8?B?Tm12K2VHYy8xd0FSYWJkSlJzR2w5dTZEaHJnd1BNNVgzMWtjMlZtSUpyMFpq?=
 =?utf-8?B?NFZ1aXNaOUI5d0hobC9jMmVGL0pWN3JvOWhNcWIxVGpCbVQ1eE8zODVPQVpE?=
 =?utf-8?B?ZGFML01rY3orSlN3VXovY1Y3VmFLb0hVK2pHa2JMdnFvVUJuQVN5MmVKNHJ0?=
 =?utf-8?B?c3krcUhDQmdOZjZaTFF3UTJQcld2YWIrTWRJWUlDelAzOUNDTERHQ0RPcWk2?=
 =?utf-8?B?aG82S1M2dDRvRHdiWG1XMkRwdEJzSVhsaGNqK1JKcDdKMjh0RjFEUVRaVitP?=
 =?utf-8?B?cXBRcXFoVS92N2lUOXc3YlJubjBNWEI5N0Y5TlYwcDZmWkRrOHNxSUVDeWUr?=
 =?utf-8?B?NURqYnZSZFN4Uld4bSt4U05xNEFMa29xbmY1L3NlVmtnOGtNS3RmZE01R3Ry?=
 =?utf-8?B?Sno5T0FGSnVROFBuQWI1UmhxMllFWnNXdE1UbnNhcDF4aTAwUFpNcW9UQXh1?=
 =?utf-8?B?ZkJBdXEwNGQwZUVFUDdVQ2hIZ3A2WnFla2V5bWtzbjhQQ2tYQ0g2c2phbW5j?=
 =?utf-8?B?aGYxaTVsNmoxTVp5aVg0Q2NrNVRKSHRVenQ3cjlwanJMLytVRnVhWUtpUXlJ?=
 =?utf-8?B?OFlFUnd4ZHZQNlNkcFVWMVVUVE15Z1VNN3VDSzRnZ0grZnVpZGFyMGtEYzY4?=
 =?utf-8?B?VHNSdGl6NXdMZjl0Snl4anhjeEc2elZSUGlkd0l3cS85SkxMMDZUZGpPaEtC?=
 =?utf-8?B?VlVlNDdBSEtHLzNrYk5OblU5V0xobTlQVzJkaDBvYWJBZVVsQzVqcDh6RFFz?=
 =?utf-8?B?M09vRk5TQng3ck14RDJsVEZ3bkFqUU1NQkp6UjZjcWJSZStzNmNCZlIrbWVH?=
 =?utf-8?B?Y01HdWx2d2VRVVMzaFlSbWZFS01xdU5abFc0WFpacGkyakFwOE05UXBBK1JT?=
 =?utf-8?B?MXYyZEhRaGVIblI3SUU5bS9pMW5DNVYwMmFiNGRCSkp0MjRSeEJ1dW1BbHVF?=
 =?utf-8?B?dExyQUpreUFvV0tBdTBjSnJIMkdRWXZyQStXc20yampKN0JpVGJsZnJNQ2pB?=
 =?utf-8?B?ZzczeGI5bVRwVVFHVm1jNXJsVVkzMm5BTURRUURpSzEwMWFIQ0VwRmdnVHUy?=
 =?utf-8?B?WS9xZzJmSWcwd0Zyb1R3MG5JcHZ5alVBSC95aWNPM1ZzeDR5Tml0dDBOOXNZ?=
 =?utf-8?B?cit1VUNiOGJtZDgzOGI2bWs2aWFGbjJ1Y3FvWmF4d1RXNFNGWThZTGtBWCtB?=
 =?utf-8?B?a2p2aGQvdkFaQURWVzRJYnNyS0tZNEtJMG95ZE45RjErblc3SVV5ZFV5eDFo?=
 =?utf-8?B?OVBDb2oyeDZiUGs2UGdWeUNIMUlwelF3REtHTUE5a3lySjdQY0RZdDAwNzR5?=
 =?utf-8?Q?wDqk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c93d75-0df4-4d78-1e37-08dce8a5b968
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 21:02:45.9519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4xQK526mvlO0ZnFIgn3UVqySs/Sa5t/dWd+i1A4FNyPTOl0P8Bb6E72E/INTIhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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


On 10/9/2024 3:38 PM, Felix Kuehling wrote:
> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>
>> kfd process kref count(process->ref) is initialized to 1 by 
>> kref_init. After
>> it is created not need to increaes its kref. Instad add kfd process 
>> kref at kfd
>> process mmu notifier allocation since we decrease the ref at 
>> free_notifier of
>> mmu_notifier_ops, so pair them.
>
> That's not correct. kfd_create_process returns a struct kfd_process * 
> reference. That gets stored by the caller in filep->private_data. That 
> requires incrementing the reference count. You can have multiple 
> references to the same struct kfd_process if user mode opens /dev/kfd 
> multiple times. The reference is released in kfd_release. Your change 
> breaks that use case.
>
ok, if user mode open and close /dev/kfd multiple times(current Thunk 
only allows user process open the kfd node once)  the change will break 
this use case.
> The reference released in kfd_process_free_notifier is only one per 
> process and it's the reference created by kref_init.

I think we can increase kref if find_process return true(the user 
process already created kfd process). If find_process return false do 
not increase kref since kref_init has been set to 1.

Or change find_process(thread, false) to find_process(thread, true) that 
will increase kref if it finds kfd process has been created.

The idea is to pair kref update between alloc_notifier and free_notifier 
of mmu_notifier_ops for same process(mm). That would seem natural.

Regards

Xiaogang


>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index d07acf1b2f93..7c5471d7d743 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct 
>> task_struct *thread)
>>           init_waitqueue_head(&process->wait_irq_drain);
>>       }
>>   out:
>> -    if (!IS_ERR(process))
>> -        kref_get(&process->ref);
>>       mutex_unlock(&kfd_processes_mutex);
>>       mmput(thread->mm);
>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier 
>> *kfd_process_alloc_notifier(struct mm_struct *mm)
>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>> +    if (p) {
>> +        kref_get(&p->ref);
>> +        return &p->mmu_notifier;
>> +    }
>> +    return ERR_PTR(-ESRCH);
>>   }
>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
