Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF1AD116F3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Nov 2025 14:08:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D88B10E8EF;
	Fri, 28 Nov 2025 14:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pUHTvprL";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012064.outbound.protection.outlook.com
 [40.107.200.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E8E10E900
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 14:08:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGa1sloRIaZwwKpVO+n7PHeS5Lmf17wEEht1/LKJarFYBjM2O41UvIO0coLxXP0im2Cd7/L/XlA84JUAtCi0FO5DI4EhYyfcI790iWGuat+9bvRHgUUmzBeKx2nZMZydnsoHFWCuhB8J3b5TAzE3elUcj2WhpuSXssgXDP8gVHgGRPKmvxEF6G6k/GJyIuY2LNPhP3wHyG+SN5v7ah1wg90Mea6jETSeDISPNBSfM1cO94V7zRoNpQqqfItWldaNrV01lnBY+2E3S1xvAedjk0YGDzjeHjqjVp7CnGzq/vCa/GY8rMOy0mY1P3MaETyfbbmYkQv3cTL3VHejkl5jsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8efCqG9UtI8d97tK/qMqPBmG0HLrXFs8TfW3MXRKDXA=;
 b=t1ROPw2pVNKImqnNpS59FxdOYIP18N7kE9PhPBoSB5L9VsCFnRdP+tuPLoUiaHCOnGfhe/eK/9z+Ao1d48TmDZuBJsUlaaebnMhUlt4kBOF0E1QcfuZQ6uT++LirwU3k4o/laFToRvI1iHRjq009Vdh9qC7BlMrI/oGgmlewRPTzhXqTpWLdFY1fjlclkTRYyQNzoBYV1E2qWlzqbXxcjel0qIpT805CpfEZZEdTTJ5LROb8n+KSHfVYA159lq6ZdNS69VVL044OTxPxlQNfC4POZ4hI8h4Vuo3bhPJcvB3BnSQUYorwQ6C4qH1mHbS4vvWmvBLaH7Vo4I4uiqeMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8efCqG9UtI8d97tK/qMqPBmG0HLrXFs8TfW3MXRKDXA=;
 b=pUHTvprLVCFaFIKqNK4S330eF9Cf6KZMv7bNChkcDCgwinWAHd2pXIRZqxOFxQlXkC+Q3c6gJy3eJq3RuQfsaIQ9NqkZCnWsV+hCnsLQXSyduNyvUAB3EkmoRq4nXBaDRGaBrv8g4BZu/NkW2xhDkkjrq9rfMfADbUqS5WLMfb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 14:08:45 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 14:08:45 +0000
Message-ID: <7a685006-e9f8-4579-94f0-b6f3484b6d24@amd.com>
Date: Fri, 28 Nov 2025 19:38:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc11: add amdgpu_vm_handle_fault()
 handling
To: Alex Deucher <alexdeucher@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251118220637.3594610-1-alexander.deucher@amd.com>
 <264534d7-86cc-4964-8225-07a32e2373cd@damsy.net>
 <CADnq5_PZr7Ce4weM1zc+CnwREM6A2=e57QBKBsbkm0s4theseg@mail.gmail.com>
 <CADnq5_N9rcs9F-V=BYWUaVDLnN7Lcqh7XOFjmfx0u6BuSruHMg@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_N9rcs9F-V=BYWUaVDLnN7Lcqh7XOFjmfx0u6BuSruHMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: ab36cb27-9914-49a7-9375-08de2e87a464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1Rpb0FML3p2elQxZnhtczFLelBKRFdybCtpWVRMQzhzWjl1Vk5CcjlrSENn?=
 =?utf-8?B?WFdXa0dOUXlPZis5K3lZYjR5WkpMSU5sWTVITkdIS0d5aHVFWGJ4QnJ3SCtY?=
 =?utf-8?B?OWdlaTViUkdsd01jbGVsSGxoVGZqVS82NllvRStIcjBHQ1I0N0U2cmp5bHRt?=
 =?utf-8?B?YUw0NUFWemg1VkxqL1JDL0lTVXJsZHlQNFozMlpZM1k5QnFlblJIT0JNcW5G?=
 =?utf-8?B?UmdRaGFjZFo2dHR5bkplQ29CUzBmcDJsbEdxanBsSFhuY3VFTm1sWVl3RzRP?=
 =?utf-8?B?Wk5FcEYwVHNzUXBXY00vQTFMV2VHL2YyTFAyUU43NTJYRG5NRXNKMW9wZGxG?=
 =?utf-8?B?NXFZbkE3d243U0xVNHNBZU5nSHVGTjErTUNZelB5TXlhWXV0dzRPT3lqN1NI?=
 =?utf-8?B?L2NqclY4ei9TRTBESm5kQkEvM3NZZUJrVVBySWFmc2NlbS9pQzlGT1drVmh5?=
 =?utf-8?B?Y1dTZ0hNYUlKTExVVW13emgzR09KbjNtM0VIU1FGYi8zUnJCV1E2ejdOeHY0?=
 =?utf-8?B?L3lpZ05xK0NVYXV5NVNSTXFqb1VFc3lVVzh0OC9mckY1OHZaa3BLV1E2ZU9i?=
 =?utf-8?B?bWt1SGRwdENZNTlUTFBpaldIajQ3Z2NIWjcyVnJkejdadStLZGQzaHpKR01a?=
 =?utf-8?B?ZFhWYjhUQlh4TjV3NnVOdXNiQktrSWZ0d3Z0L0lsTUtiRmZkQWtWTUVvaG5y?=
 =?utf-8?B?cllId1o1TU9CekhnQUtQOEYramk3WVI0KzB3WmVHbENraUNZLzR0d0laR212?=
 =?utf-8?B?THRpQ1NKOGNCR3VidU1hbG1RUHpUaEF2ZWdXaHhhVWtBRndIUHNYTXlQbXlk?=
 =?utf-8?B?emU3REk4TVlJZzVJTW0zUzdYQ284NVB5MThDaU5weXM1U2RlUDFIVFpqeGNH?=
 =?utf-8?B?S1VLNmFUbjRkTjgwTG5TMGxZaW0wNWFkaTA0anRPS0tZT3NwN1l0Uzk4OWlz?=
 =?utf-8?B?QUVFTkdVWGdjTWZjSGlKdFFnRzJhdkZIc3BsME1HNUdQaHVtTGM5a09ta1My?=
 =?utf-8?B?dXhmSWRXMTZoMm5Cbk0yeW1DanRQZ1VxN0NMUHdDT3RBeVRRMEdUOC9hOUZi?=
 =?utf-8?B?WGVEdSt2bWs2dzA5dzZNOTJhNG4wRmtkd3JEQTFzWWpjR1VmMTA5akRRcFcz?=
 =?utf-8?B?TkN0RGdzMVJvY0tkN1J5YVFxcWlkZHF3K1YxTHAvQlRRaXlOTXlVYnRIS1gx?=
 =?utf-8?B?WlB5ZmFGaCtmK2U5YXRSYWtyUSs4aEpSQkZaMFBqQmVuRWNvdkwvWDZveThz?=
 =?utf-8?B?WHVYRitLMVpRWkRpdlB3SXFIbkxkM3ZZRTdOSVZpUkVFZW5DZGwwMzhZWldL?=
 =?utf-8?B?d0F2bHdUeVd4dnNjelQvdUVMNmVCdHFidkQrd2tmeVB0QnZwZTFSMXdTRmdS?=
 =?utf-8?B?dUUrUjhRZ0s2WUlCdmI0S2xPdklaZ3VDczUrOThBK0c5eU1GMFNVQnA3NjFR?=
 =?utf-8?B?aFdWdUU3TjNiMDZFSDU1THV1WTVielZGSmJIZFdFQXdvS0U4QWs5eldTRHhO?=
 =?utf-8?B?Z2tucGVOUWVzRUMwbUdPVXpxQjJUOVVwQ29vVWRHdTk1bFdXTnNNcTA1dTlu?=
 =?utf-8?B?TXZGT01UeTJ0Uk9nNjBndVBJd2lvazJHdStXbUxQalNHVGN1RlZDL1R5azFv?=
 =?utf-8?B?WXJuWmpCSnFBWllQd3VOK3JreVhTQkpNUDVNVFg3aFFXRytBcENBVmRRb2lG?=
 =?utf-8?B?bWVYQ1JBT1FodTUwZDFhQjdtZXZ0ZGY0ejVOTDEwYVV3YXYwdEw5VzhGWlVH?=
 =?utf-8?B?MzZCSXJsVjI2TTlIQXFkS0pLN1dJK1VhaWpkam10ZTB4MG5JZGRIWkFkSEJE?=
 =?utf-8?B?Yk1UUWU0TTdGcnZKU2dWSHlmbDEwQ1dDd25NTVNUa3pQNGxzaW53NVF6a0RR?=
 =?utf-8?B?L0JYTmJaZ0MvNUl0UDd2WmlIYmlZL2ZlVkZFNFJGZXZCellLZ2JjdXVUejI4?=
 =?utf-8?Q?gLXYEEWQQVt+h77ZpcsBtpI5KMUCTcBy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkxlRVdGR3BOakJITEpNeGV0ZWE4aTRZeWZLTHlkOHZjWWRiM1hsV3RDclk3?=
 =?utf-8?B?enhKZHBHTW9qVzhjMDhIMW9XTFphNC9hUHNLT00vYUdBMG1iRXZqYURiczdU?=
 =?utf-8?B?Rk41elVGVDlMQk5qTTVZOTJLM2EzdkRYcXdtcWJEU3YwVmhIMU4wMHlqYmV4?=
 =?utf-8?B?N2tDdnJrVG9oWnZmbDJXOHA0c1FYOWVMcTFrcm5rYnZJc0p4Vm1OOFVnZUN0?=
 =?utf-8?B?TFFjUUdyMW1vSlgvam5XQjUyT3R3NEtBNXlYWWg0cU5oMTVYNCtrdUNxWDJq?=
 =?utf-8?B?dEFaL0ZsK2dGd2d3SUtDY0R2eWM1bHkvY1MwOXJBbTNmUy9pL3BIbkdZYkxS?=
 =?utf-8?B?T3dybzhuaGl6Y2JCdFZ2Z0xvNDlkbkZ5RmdVSytQaW1lcllmbHF6bmI1OHFo?=
 =?utf-8?B?aXhGTSt5K1RBeElQK050L0grYkxKMGJaNjltQUpIZ0tZWi82WitPbDZ3aG0y?=
 =?utf-8?B?V2lydXVLMmRIRWtLZzdaN2NISElQWHVNSlQ2c0JzeUQ4bjBWbER6UVFNUHBw?=
 =?utf-8?B?ZFJWUFoyQmJhVC8zdEYzcE9acDZaVVZKZHZERjdzSTloM05QZWtZN1dHWCtG?=
 =?utf-8?B?dkx4ZlJtaUN0MWR1emY3L2VKMWVWdW1idWwxMzlWaU4vYldoc1JHZTh6U0d3?=
 =?utf-8?B?SW5IdWNjV0FUNjFUamVMM0xUN1lUV3pKRnBmMFJSWjVqNjduVEJ5aW92dFlz?=
 =?utf-8?B?a0ZMZnBJdWxha21CdlJjdHhWWmJJc3pkNDkrclFCSytEdUI3Q2Yrc2F3K3pW?=
 =?utf-8?B?L1loUUpwbkVkSmx3UjJpQVZEL2ZCbHFNUU9wL3d0aUhhY1Fzd1hVY2tXQnRt?=
 =?utf-8?B?RHBjOTYvdGVTbmR0YVAvditUdnA0Rm1wZVFZbkhrZ1Bnc1E1UzFlR2h6R3kw?=
 =?utf-8?B?eXJFTFY4NDJPQWo2a04wV29ha3pTLytUV0J5dmMwdXRjcElicm5DaExuQVRD?=
 =?utf-8?B?YWxzZE44aHRydDlOU3ZIOXN6SjlNY0xsL01ZRXEyRFhXTHo4cW5qemZiZm9I?=
 =?utf-8?B?YkI5S211WGpYUDgwSExEVXZLTDhjdFBGZkR3NzlTSThJSDZCczZYNHlMZXBC?=
 =?utf-8?B?dUFtMjh6TWR2WVRHRjY5NFVxVXBUWXhFN1d0Ym02emVSSXlGUnFaMnliOERP?=
 =?utf-8?B?MWd2U3RtVll3K21CQXJ5Y0d4MTNMak40cEFOY1pDVTRNTSszazg4Q2E4eWlt?=
 =?utf-8?B?K0lKZUx3LzdjczlqK3haZ0VQUGcrbGRuQXdKQlNHRUNidmpoZFU0KzhrdkEz?=
 =?utf-8?B?WW5HSU91Wkl4V2hQV2p3SHNWSHlsd0pnMmdqVHQ5WTRsY3JiSm5XN2lvWHRo?=
 =?utf-8?B?b0tPSHhxc01uajZqdmtITThLcnNPT0Y1WlREcGd0cHZ1UWV3bUxkZ2JNeTVy?=
 =?utf-8?B?Q2RXUGFTN2F6T1VYaUdtMzRKWnJpYWpSblVPTFVVQllKMlVoUklYQUNNVmRW?=
 =?utf-8?B?R1VBZ1YvM1EvaTNmYUlRVHg5S21US2tXbDA5Z0IzbDR1QUhtV2swMCthVktS?=
 =?utf-8?B?Z3VncTdZRGdlRzV3SmY2TDFyWVp6M3pYdTdmdVhzVXNmTEUxR2RYWFBndi9K?=
 =?utf-8?B?RDRmaVBWMXdqSjhtYVlLODc0WmZXZGVXSVJiK1phZGxGdkpBeVFYQmg2ZU1X?=
 =?utf-8?B?Ny9YYXVlR09WZ3J6ZlNFZlhST1FmdHZJOFQzTUREaEpPUEVtNU1Pb3FvQ1Fj?=
 =?utf-8?B?eWtLb1ZOMjVNQXk1QmpzUmgzZ084Ujg3bGF4MTdYMmp6SUpXcWZzL2d6eGtk?=
 =?utf-8?B?b01neEliOXhvbkdJSGtOaDBlN2JNczZJYzV0V3QvY2NySnYrSkpFVW8xWDVU?=
 =?utf-8?B?MHhBYkxOTmlQTVRlNDYxZm1FTktSVS9YSGR1MXFJRDZ3RGJUajFCcWtGelB3?=
 =?utf-8?B?NjVkZHNpeGcwSDc4WUZIR2JYV2pxdkxoVklvdWNVSzJJMTMxSTNCSk1MczRr?=
 =?utf-8?B?dzRuUk5iTHRUQlJHNlNtZkdjM1pyeDZ6UlBrT1RDaDhlTzVGTTk0RmcweDRR?=
 =?utf-8?B?U1l3Q0U3QWQ4aFJmOVYxNjY2RFdUZkEzV1JBMjA5aE5JT0lUeTFTNEhYTmps?=
 =?utf-8?B?aXJJUXpocHFHWnNzeHJNZ0FwOFhKTXRvb0Y4eWNPVU5MS1hrOG1YSVYyMjdW?=
 =?utf-8?Q?9RbJ3W5yvtfzg9CtzwwcMrUbZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab36cb27-9914-49a7-9375-08de2e87a464
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 14:08:45.0699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Yodj0zHQJaANtuebAMHA0/V8pmYfTtincK+M8deJzvRKMjRlevGp9E1P6tJQe62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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



On 11/26/2025 7:42 PM, Alex Deucher wrote:
> Ping on this series?
> 

It looks like the same generic logic in different IP versions. Would it 
make sense to have amdgpu_gmc_handle_retry_fault() and call it.

Thanks,
Lijo

> On Wed, Nov 19, 2025 at 10:16 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Wed, Nov 19, 2025 at 3:14 AM Pierre-Eric Pelloux-Prayer
>> <pierre-eric@damsy.net> wrote:
>>>
>>>
>>>
>>> Le 18/11/2025 à 23:06, Alex Deucher a écrit :
>>>> We need to call amdgpu_vm_handle_fault() on page fault
>>>> on all gfx9 and newer parts to properly update the
>>>> page tables, not just for recoverable page faults.
>>>>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 27 ++++++++++++++++++++++++++
>>>>    1 file changed, 27 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> index 7bc389d9f5c48..25cdcb850416c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>>> @@ -103,12 +103,39 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>>>>        uint32_t vmhub_index = entry->client_id == SOC21_IH_CLIENTID_VMC ?
>>>>                               AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
>>>>        struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>>>> +     bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>> +     bool write_fault = !!(entry->src_data[1] & 0x20);
>>>>        uint32_t status = 0;
>>>>        u64 addr;
>>>>
>>>>        addr = (u64)entry->src_data[0] << 12;
>>>>        addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>>
>>>> +     if (retry_fault) {
>>>> +             /* Returning 1 here also prevents sending the IV to the KFD */
>>>> +
>>>> +             /* Process it onyl if it's the first fault for this address */
>>>
>>> typo: onyl -> only (same for patch 2/3)
>>
>> Fixed locally.  thanks!
>>
>> Alex
>>
>>>
>>> Pierre-Eric
>>>
>>>
>>>
>>>> +             if (entry->ih != &adev->irq.ih_soft &&
>>>> +                 amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>>>> +                                          entry->timestamp))
>>>> +                     return 1;
>>>> +
>>>> +             /* Delegate it to a different ring if the hardware hasn't
>>>> +              * already done it.
>>>> +              */
>>>> +             if (entry->ih == &adev->irq.ih) {
>>>> +                     amdgpu_irq_delegate(adev, entry, 8);
>>>> +                     return 1;
>>>> +             }
>>>> +
>>>> +             /* Try to handle the recoverable page faults by filling page
>>>> +              * tables
>>>> +              */
>>>> +             if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
>>>> +                                        entry->timestamp, write_fault))
>>>> +                     return 1;
>>>> +     }
>>>> +
>>>>        if (!amdgpu_sriov_vf(adev)) {
>>>>                /*
>>>>                 * Issue a dummy read to wait for the status register to

