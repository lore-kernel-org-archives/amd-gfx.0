Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB92D2A520
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 19:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D57310E0A1;
	Thu,  4 Dec 2025 19:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MkmeKAw4";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB12810E0A1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 19:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgsBD2tGDdUe9hIXeSiH5JKuaJQblfAQHYF2Le7IenBP0WqeVTZFK3ulV2uEZlkyRKHq+87Gq43m3O44MUHeeCsUsBseEU9Yd84j9ZTVjo3AOX4E98Zd+QZOPZlHISgjSipQLPVSfd6PeZp1ptY2tJ+/prnEQ43vCTRu0aqdbz3ASQ2Apjzr9R22cdLJQVfu/qTaeD6zWmDySE+TRXM/nlW2174DB9Xz4LH2HH1yX54xgQM/9VSK7nYwtlC8pgnI4BRPYZeMlVKNnLlAUnUoFt2zg21yrrRS8dk8Hvfl4UESgp9Lzegvnqi+8ZMrC8zAMY/miUrISXMHj0mO+EffLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmQ98LdIUb8iEDPMbtXn2dMGhDMJPX5hNgzBZriLL48=;
 b=mAIUwWL+wFsnvGgkXuQADx+dIwcVF/mv6TGYAJMQwAt53WQ7G3v1b6kQOQPMQ0XpZLNDVroVYPkaYxrOOIk7RLct0yBxHC3CZG2/gNBYS3XvoTmN9qKMTJGnADPoR8pg2cGxuibyYYpnaWVWVxqNBQW3ld4F0zmWGVrInkjbVotr4Jj/+VYzKpbBwkB/t+TP5WsjYkeeCEIU046N2O0FOUIUbnoE+R2A2RgR6gSP9lNzihGj2L+8mLTrb5C8vIOmU8RIvtoRHKR+0nBvPJxSvTcHYhLy4FrgyQOkYQdZHejOYFZ2AZGchyRjRhSONYBx1L+fMidyCpNYIYpU25YDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmQ98LdIUb8iEDPMbtXn2dMGhDMJPX5hNgzBZriLL48=;
 b=MkmeKAw4WR9hNrkuTckZGn/ECW9JUZhSEgCVBvGps4unKRyMA6+pq2Y/KCOAcO8LTrhBDTGvCFQ2TaD3tOOF28xL8PmtK3NuijxRdUL3v0++QtZ+w6gWwO1nNyDa0S6XalY1o6UmHptvRZq8VXcn0sr/ZaIZ6dhw24ET9OQxtiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 19:28:44 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 19:28:44 +0000
Message-ID: <1781445f-bb33-449c-b3ea-fc07f4260e09@amd.com>
Date: Thu, 4 Dec 2025 14:28:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/amdkfd: Move gfx9 MQD to VRAM domain
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, david.yatsin@amd.com
References: <20251201142838.1516452-1-Philip.Yang@amd.com>
 <20251201142838.1516452-4-Philip.Yang@amd.com>
 <98c9d511-e590-4a70-9b41-d42196b812bb@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <98c9d511-e590-4a70-9b41-d42196b812bb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0030.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::16) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: f67b7f91-6470-434c-6077-08de336b568c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L24zM0RXT3Rjam41T0lvNWNIbmxqanJuY2Y3MWtXY2x2QmRTVlI3d1pJVjFv?=
 =?utf-8?B?b1B5SFVDWTlZeEJKbDkrR24wa2lLWU4xWC9WM0NTRGNzcnZFMmM0RzBMeWVi?=
 =?utf-8?B?aktnQlhrbE5UU3MwVXdyYmxIWlQ2Q0NjbWZJZ3F2Z25SWEZaUy9ZRUF0cDhh?=
 =?utf-8?B?dlYxeGxubTEySVBucVVUbVRSc3gvenl0bG85dnZaT2pydDJVd2o0aWlHcjRn?=
 =?utf-8?B?ZEljc2VRZVZkQUVIWDQzUklQaFVsejBFWG1lU3RWQ3ZqUEdINCszWThraTZN?=
 =?utf-8?B?L2s2RVhmc3I2bko1RjdROU9pQ2pTdVB0SFEyNlpOTjdwRkZVb1FKenNNbmU3?=
 =?utf-8?B?Q0EwaUg2bUJyK0dtN1R2aTFGN3B3ZUt4YVd3QWlselpsUlhHa21EMDZ1b2h1?=
 =?utf-8?B?SHRuRXhCbURYMHNUQXRhMFJrK21TQ2pJdmtCWnBINjVidVB3WWlEem1lWm9h?=
 =?utf-8?B?enA3N3oyZGc0YkE3NzN2SjRxcnluY091V1ZvYlFZTGh4MVdwYVZZRkNFU0RE?=
 =?utf-8?B?QXNGMTlPUGwyWTNRUjFESE9BMkZySFNheXdFRFdnWTUwK2JSaUhPajlzR0hS?=
 =?utf-8?B?MG1JekNvWlFMdkhjbEtOMm96OUwrck55RVZMcTBORkpFcndRbXZxMDZnSG5O?=
 =?utf-8?B?alFhWWg4WmtUME14dGUwaUdZYjdWZjB6em02aW1SYTY4dVZRS2lJZFQrTEZY?=
 =?utf-8?B?V21yTzRtUHRldVFvVytZcHJsYm9uQWZZa3VEdFMva3lHZUJkR2pacDFHZFFQ?=
 =?utf-8?B?dHMzWkNadldmU2xXQWVESWsxYTBiS3dMdlQyeEljc2dJVWxaQUNSWDd6bFFT?=
 =?utf-8?B?emRLdUJwSytiODM5WUQ5cVhGcEV1VWZ2MjZxekwvbngvYWZGRE90eGJKd0h3?=
 =?utf-8?B?b1R2VFVLUHYxSURuaURLWDZvbHZob3dZN3hWZ3BDcEEvNkZNaGt0RTNnSm1r?=
 =?utf-8?B?OGdFbmtQNldUVEk3YmhJRjJ2ZGx2eU51K1RwUDJDN0FYRSszcGhsVjI4NnZr?=
 =?utf-8?B?cFVFSEdocGdLSERYVmVXRWtVV0dVM2NTM3JQLzAyTnAzd2ZHeFUvOHJBN2gw?=
 =?utf-8?B?Y04rd3RMYVVoSlRWZ0kwZkJUTGpDZXdaMHBWWUdwSXNJMEdpbGpDS3kxVGk1?=
 =?utf-8?B?K2FKb3luRW1QblR5MVRlK3VFbjFCbk1MM0JDb3JYc2NOQUJCRXpnMXo3ODBO?=
 =?utf-8?B?WS9ka1VMY2N2b0JaVWdXK2Z0cCtzbVEzTVhPUllvR28zbjZ1eEhoUnY3Vnpq?=
 =?utf-8?B?Y2Q1ajJ3VUpHU2ZPckw1N0J4dWp0a1NuMEw2K0lwdWJQM0srYzdUMG5hRnV0?=
 =?utf-8?B?QU5nQ2IzQ1pWYUlmL0xySlNDaFppUFNjMURnRFVHU0dNQkx0V0FUQTdKbE9h?=
 =?utf-8?B?bXdTYXhUaE1SalY3OVZQOGlSK09BTUhPNHVnbEVBbWozTmxYUXNwOGdJNGtY?=
 =?utf-8?B?VGw0Z0xTOEgwN092ZFdTRW5qSnBJYjBUVFJMQWl0S0RzSmN3TWJKM1RvYXdX?=
 =?utf-8?B?bExWekV3bkVhWnkyYUJ6OUtlNWVrR1g0MmhQUVFxWjlpeGl4Rm9ya1B4OXZW?=
 =?utf-8?B?SzFodlQ3L096RlVuV2VxMDRtbkFEVGsyVGxLOVpLdEl5MzFHUEJHNkNLcE1o?=
 =?utf-8?B?R1F5MUVHaGJ1M2tSQUdzNUNDZDdtdHNNODhaeGhqeDIyc1pxTCtTZ1hSOTJK?=
 =?utf-8?B?dEhCdW0wd3NTcHBETnAreEduN09kT2RoT2lEdFgySWdaZGtZajNxY2VaU05h?=
 =?utf-8?B?ODk1VXhZTkcyU2ZlQS9LeGFCSkdjVW03Nk92UFNsNUNzL2hPOFFMcTBmZ2pS?=
 =?utf-8?B?WUpYTDl5Z2o1NU5VVU14UHJQTlVqeEVzVWxnRHJ4SHhMU2lrL3cxTHM2REUy?=
 =?utf-8?B?SWFBcGhPNlBIS2hHNkl3ZVFrSDN4ZUVoUVJRdVFlcHF6SmNpSE1iNjNCaEhx?=
 =?utf-8?Q?ALR1L/yIkooZeISvnqP/8KBXQoAmwYhR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURNandzQTV2a3hyUUVmL1BqWmNFZ2xYREs0NWZ0Y2R1MURONkZISndJbThO?=
 =?utf-8?B?dmdxUE9lcUwzdDFZQ1A4Nk1jdHRieVdKelJUVCtFcnNjRjRSRXFtMTh2ellq?=
 =?utf-8?B?YnJobnFPOGlqY3NaMVRLcXRJZ3U4b2kwaU1QYmxFMHBmMWtmcG5PRzF3ODdJ?=
 =?utf-8?B?OHVqYnF2K0t0cFpBSWROTVpHN1IrTlgyaU5PcUFtSzEzUGcwRlg1RzUveVlV?=
 =?utf-8?B?ZFRLVEdyR0M2YkluZFlCb0JMU3BJWitTUVQ0VmkzS1RldG9TSG9BZzVWc2VL?=
 =?utf-8?B?VGdqTzhrWjlEZ3BjOXZSQ2gxT3puYVU3aG9wSXZOcVRxSnl3WTBiV0w2bit5?=
 =?utf-8?B?T0g3ZlJMZHRWb0NnWDdjVldZRTFEcEtQaVFsa1dJckw3WG5uSHo4VnowTUgv?=
 =?utf-8?B?ckFrcE9SM1FDaDUyZGNraU9GclNPbmlGQjJEeC9EOC9yaENINDhkWjBEaW1K?=
 =?utf-8?B?Ym5id1pGbWxNSkdNWHJ4MmQ5RW9ORDQ2b2JleFZSQ1loYy9YNlJCd0FpS3Ix?=
 =?utf-8?B?ZUphWUI4VjF3dGVuS0ZhV3Fpd3NBRVhZbWtDZCtjRTZQMC83Z1MzR2VUdDk2?=
 =?utf-8?B?WWhCUEVvUkhqRUI0SXcwV2Vna0c5SmIzUlpJQWNJc3lQNUY1TlRaVkVRQWov?=
 =?utf-8?B?SU50M0lDekdpRnBzUDJPRzVqeXhLS3MxVFYrWTBpeUZmdW4rY1lETXhaQjZW?=
 =?utf-8?B?cWV0UmFuODhNZjdGVEZKdThZNllTeHZreXExanlQSW1nL3lKNlBMbzZWb040?=
 =?utf-8?B?WWFhZm5RWjROUSs1dEs0SE1Jb2dnaEdoR2hpOHhjdGE5cm5KUXUvSnN4akdC?=
 =?utf-8?B?ZVYvQzYrTm9nUmV3VnhoMXQ5NWY2K21sY3F1dVRYRjZtVDkrVStERlRub3ZX?=
 =?utf-8?B?VnEydjVSM0FRUSs4M1V1QThxWnZWRXk0Y1VnWGR4SVRBdzNHSk14cjdxOHEx?=
 =?utf-8?B?WUlrM3ZxeFhnYTRadSt4WUE2c3RSRmQ3eFllRCt3a3BsS3pjbkdFY1ZBVVJZ?=
 =?utf-8?B?VlkwUGRCN3VyYVNGMFJXcVhWUUE5NkgveEJZdGp4WmhRSmpsa25YZXMvNDUr?=
 =?utf-8?B?d2JQS1pmNHFSOWs1TGkyQ3JNUlppdjNpSlZuSzY5RE9QaU1HU09LbGtGWEhI?=
 =?utf-8?B?YzBqTWlTQzhDcjJQa3BQTmI4NXdpeUlhWUM1cXc5d3dZeWltRmV3cExvb0Nm?=
 =?utf-8?B?N2FScWhGRU1lL3dENXg3MjBKdko4bWZNK05paW5YQkdIRmpqN04rUHZFNk8r?=
 =?utf-8?B?L2FoVjV4TVBYTkViTVRzWGxwTGZ1ck1qUFVUM0IwcGxPMUM1Mm8yTUhUeGVz?=
 =?utf-8?B?NGlRai9nNndKbUxVZ1pwVFJnQUtOY3Vndm1EWFVzYVBaa2M4QTZ0UFZaSnk4?=
 =?utf-8?B?cmRiRnVUdHRkcEg1UERjc1RjbUpGbEY5Vy82dElnSGg0QkFFNXlzYlFienB5?=
 =?utf-8?B?NjVzQVhGRE9ZMSs4SHRWK1RybFUwL0hSYWh5bSsrWkYyQ09FOVFPUUp4V1Jm?=
 =?utf-8?B?R3RjbS9MM2pqeEt4R0lZNWpUWi9uSTF4MTJVTloycGJHSGYrRDZFT0NnMEh5?=
 =?utf-8?B?b242WCs2cmptejVGTHdmZExKRXRUOHpBMldncGl0b00wSTI2Q3NkU2IxMUY0?=
 =?utf-8?B?bGFkNVhzNFR1ZVEraEpPbFRmSWcybkdhZDZ1OGYzczltWlhoQ0NGQ0RPWlBa?=
 =?utf-8?B?ZVlPMVcxQkhQZ2dTbnZ4aEx2Q0JGU2lObHJ2aWFCS2JtR3I0RXJuQmN5eWts?=
 =?utf-8?B?WmNQYjV0RnhvTDFnNWY2T3FMZVIyRWZGR1R4djVKT1BtNjNHODV0TXd3Q1BT?=
 =?utf-8?B?ampKVzJ4ekU1VHFCbklORlJmTEFlNldsbjdzMkIrNnZ5OGw1NG1VV2FXUGtn?=
 =?utf-8?B?R3lsbC9tWCtNTkQ5MGE1ZHQwRC81NTZiWjg5QUdkNm5TWXBSQ0xRQXYreVVY?=
 =?utf-8?B?Z0VtMjBaUllhdVFSbUZIZ3FmSzZ1YXl6eXVaWFdJUjRKR2t2Uy8xZG51cldu?=
 =?utf-8?B?elhXdHphaUk4K2xUM2ZWWnlqVUgweWxEWXFycXZDbjdJNFlIdHh5RkpOczBV?=
 =?utf-8?B?cTlSeHA3d2RQUTl1bG14cjErNmMrWVVJbXJ5NWY0QzE1MmNzUmI4ME9VbGhu?=
 =?utf-8?Q?cG2Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67b7f91-6470-434c-6077-08de336b568c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:28:44.2289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwJXxPEIxieBHwoAYebKwUi4Sn7mKE83gorleLAjoS+FOePs/4IITMscsOQA+6O4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731
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



On 2025-12-03 12:55, Kuehling, Felix wrote:
> On 2025-12-01 09:28, Philip Yang wrote:
>> To reduce queue switch latency further, move MQD to VRAM domain, add
>> AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag to allocate contiguous pages
>> using one buddy block.
>
> Why does it need to be contiguous? In the next patch you're mapping it 
> in the GART anyway.
Because MQD and control stack uses different mtype, for multiple XCCs, 
it is complicated to update mapping using resource cursor with multiple 
buddy blocks which depends on size alignment. Yes, with GART mapping, we 
don't need contiguous pages, will remove this in next version.

Regards,
Philip
>
> Regards,
>   Felix
>
>
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c      | 3 ++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 9cd1660b8f60..c11e37915365 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -329,7 +329,8 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct 
>> amdgpu_device *adev, size_t size,
>>       bp.size = size;
>>       bp.byte_align = PAGE_SIZE;
>>       bp.domain = domain;
>> -    bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>> +    bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>> +           AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>>       bp.type = ttm_bo_type_kernel;
>>       bp.resv = NULL;
>>       bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> index a489d43d5f64..c6945c842267 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
>> @@ -139,7 +139,7 @@ static struct kfd_mem_obj *allocate_mqd(struct 
>> kfd_node *node,
>>               (ALIGN(q->ctl_stack_size, PAGE_SIZE) +
>>               ALIGN(sizeof(struct v9_mqd), PAGE_SIZE)) *
>>               NUM_XCC(node->xcc_mask),
>> -            AMDGPU_GEM_DOMAIN_GTT,
>> +            AMDGPU_GEM_DOMAIN_VRAM,
>>               &(mqd_mem_obj->gtt_mem),
>>               &(mqd_mem_obj->gpu_addr),
>>               (void *)&(mqd_mem_obj->cpu_ptr), true);

