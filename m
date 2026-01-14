Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0656BD29FE8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 10:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DFCA10E244;
	Wed, 14 Jan 2026 10:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kLD5zOMb";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12BEB10E5A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:55:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELMFYMKuWpT3TT6TsYK/BbMeaFtQHSkSNWHYX7JuVqD7wOx4k/u2frAXR0I+DwqmOzYkGv1Lcq2kEVwFrUqxR7jVHdgsE/GfvXZII7shGMaPMxa63f2Z3+Rvc/RuQcGZ/ANGAVXB8NaQkTzFZP5PH3sYWTygqdvWzGsl467HUhY4H5epbe6CZ4AcLDnweMsrLAfDIpboYld/ksM36CpWzyTwqhpvHNzZ/z2xSqlijUJelZ3ZEMpGoC8Xjh8Frjx/FbWQ+k5NPkAvjARz8kgdDHnrmVJTXojJNqm9xxdwewfYtbW3u4O/X3+ys4djgPGzxKOAIsr4p1CFe+uX7ykpDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZulBODt0WNVAo+jLfG2CIPV7aUeHjK68OXJ2vVBMnk=;
 b=I0+Z7mjtEN1j1zELEICi0c9uYFbPyB9IHH9FZFmEbJcTcaYJLCL4AtMi6ebuu0vfcpU6drLRG5MdVzGhc1tMcZygZv1x4kKVWAyoW7o5xuLLXqE00qPXyOGws6m2UhSOql1mDgq+e7JXDR7EPPVyRrchnqoKSztSpSVHO9nzfJWDJTu2B+xGIX6JiK92/fXXvl8xm9GTTfotRioCJ6TlQHNIv5oQAj+0QlZ97pBCp/SmzmrMzDtHTNA2Nefwac2MXsDWrCqF3RBViSGBH/v0FHLT+P7RVBkN/+XfdF9AcO1VBk8ySd315CqkdOyMQdQMZxVmDpDT8MSxOGLBzB8a6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZulBODt0WNVAo+jLfG2CIPV7aUeHjK68OXJ2vVBMnk=;
 b=kLD5zOMb0TGR8imxGkgKUDjfK6OE9dCxENr/QPcLuvy2/otIwK8B3E8W9ms927vwkK/KjtS5QIy5xj/boXspoJzg1lkWJfAhzn1ObyYxpDT4u/KQuKlMW53FqsLMQfT8HMpCAJGw2HcTNxT26WWbcrhnrsKiE1CtvoK9/iSOiHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:55:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:55:51 +0000
Message-ID: <3cbff564-5e1f-4d82-bc34-285671e43072@amd.com>
Date: Wed, 14 Jan 2026 11:55:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: Fix fence reference leak on queue
 teardown
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260114104820.122612-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260114104820.122612-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 921d17ee-3289-468b-2e02-08de535b7b8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlM5NmJaOW9BMnR2WDV3cExqOXlERk82RzB3NWtKK1QwUXdoam90UkJDZkxa?=
 =?utf-8?B?ZWFRc1pPQzAvZktmeENKOURxVEc5MmxqUEhqTURvWk9KUGs0a1ZVY0tWaGtw?=
 =?utf-8?B?WW8wek5kZ2tONGNZeENYNm13S1oxTFRVY2xOZUFjd1IwOENMMzJIVTd2aXJT?=
 =?utf-8?B?d1dqSDNtVEhaQ2doV2pCQmx5ODlsUmFiVjNBY1dxUkNuQnZOYk9jN1ZEcGN3?=
 =?utf-8?B?cExJcDJRSUFucG1tYnAybStNcy84VGYxdGlGN04xMjJrUEo4VitkSmk1TzV1?=
 =?utf-8?B?Y3U2a1MwT2s4YmFVMkQrQVV3aDM0MWZOa2JGZkp1eGZMUUFjSnBicmN0b2hn?=
 =?utf-8?B?eGNKdG9QbVlYSDlRcnl5ZjlRMDJueG91eG55L1lybEN3VHRmTGJhQjVqclpm?=
 =?utf-8?B?WXBraU1pUEZKWkFFOWgzYlRraXhudW9ocXFyM3BWUStieWdKWUNZb0thMHhD?=
 =?utf-8?B?OVk1QVI0bzRUaDN1SUp1ZGFodlZKL21hd2pjc21ERm5vWDcwNkVucFVkZjZT?=
 =?utf-8?B?TWlsT05HOUpURWdTNFJFcUxuV3RrYnIyMHIxY0EyWVRGRUpzUXhHbTg3OE5Z?=
 =?utf-8?B?bUJrNDZxT01lSUZtZmF6Ulh2WmU4U3NMQU9UQWQyWDVBLzBzMlAwa2RoRHl1?=
 =?utf-8?B?TWpTSXpNL21oL3JQb2ZvQ3o2OXdKMis2WTl2T2lDMFpubGhicVQ2dEN4czZ4?=
 =?utf-8?B?YzA4SG9BMGVheWlsSThJMC9EcU9pM0hWTXFFSUkxeEhxUkYzTFhxaER6ZXQ3?=
 =?utf-8?B?dG5UK01ZTHZwRFRCZy9QNFJCUGxTeC8zM0Q0dHlLZVZZNE9XcTFkeHcrRjFw?=
 =?utf-8?B?Tm5DWEJQeXFRcU94cS91bWJ4U0hxOHNFSzEvR1N2MG9HWnZBeTkvMzV4R2or?=
 =?utf-8?B?TU1CYnRtcWYvcTBMUzM2YkhyV01JNTBlOC9CRUxoY2RvV2s3MGh4d3lkekw0?=
 =?utf-8?B?c01PQzZjV3VLdmZIYkVncm4wLyszR21HOWttcEVsTXdZVFhraXRMaDY0aHBs?=
 =?utf-8?B?NDZ6bU5Vd2lGZnhCMEVjQjVHdGZMNkNHT3lGamdHWXYyM3dpd1QvWnlHUTNI?=
 =?utf-8?B?NVZodVVvQnU4REROc1IxRjg1dFloaVVLeFVZRlJrU3F1Zm5mcVF1OXV4WW9K?=
 =?utf-8?B?SFhVVU5BWkJKSEJkeVJsb0JwbzhwUStFVG5lMlp2cGxwNU9MWEk4OEN2YlpX?=
 =?utf-8?B?cHhHVHJ2c0QxekFGaVNPQVNMM1BqWXFmY0Rvb3FCRWNzS0hpSkhlRHdXT0RX?=
 =?utf-8?B?UlpPMit5bFlYdVFrVTNHMHNQTDNoZXZLNUJvZDFVNW9EcHRRRit4OTlYMHNu?=
 =?utf-8?B?VzdnQkJxK1NyQW1NWFlqa1NIQ29QcnM4WE1CZzJsOXlCWDFJclBPZUY5UXpS?=
 =?utf-8?B?c3ZUQWNjVDJoQmpaNkhoRHlTOTBobThseVpqNUpoQ0R3RVpVdjdnV3I5K2Vz?=
 =?utf-8?B?NWRpcjl5WlMyc2VZUXB3UlQvRXFYQjBjQ0FxL05aclc0TTdSdkI4cEhrY3Bu?=
 =?utf-8?B?RUlRNXJQOFYyNkQwM1VJM0dPOFEvSzJUdWtmK0YyZWpmY2g5YUpVZlpLcFd2?=
 =?utf-8?B?ZUJKV2prT2hLaU5UN3NUK0N6RG9nTDR3cEdMa0RIWEUvdE0zbVJ3QmlBNjR0?=
 =?utf-8?B?OWlkQVBDMlFTRUd1K1R6S0NZVk9BVTEyd1hYeUJza2g2aXU4ZFYzd0RER3FY?=
 =?utf-8?B?UERPNEhxYlAvdllpU0wxTk1zb2tmcWtTNFJQWmhMU1JZekZZMnYyTlNwYlFs?=
 =?utf-8?B?dXJjNHo0RGxNMm1oYnB4YTJpdWh2OStscVo0VmRwU2N1VkV2bjdWL0VGY1dX?=
 =?utf-8?B?ck1xb2NEMjNBcEFod2dnTm16aWhSMThSeDQ2N2FRUXhCdk9keVJIZVhCZFg1?=
 =?utf-8?B?Y2E0dEh5eWZldjBZT0lkYVkyTTRoTVZOR2xGNUd2Z3RXV2dZaDJPU0IrdlZx?=
 =?utf-8?B?S0FDeVNzTC9rMHltanlIM3IzdHFDZVZIY1IvVHZRenhMbTRmdmM4Y2RvUzQy?=
 =?utf-8?B?UzcwNDMxdkdCS1dEamhkLzhybVR6TkJPWkIxTHJEa0dxVjdCYWphOUhGRzQ0?=
 =?utf-8?B?eUJaVEwwcUIzdFpBRUROcE10UzMySDVrSERseWhKQkxHaW15WGtLbzBhYjNF?=
 =?utf-8?Q?MNQA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2JxVTZIaUlXeno4Z2FDM3NtOXVIVC90bmlTZVVLeStwKzVVTE9UTmtMSGJv?=
 =?utf-8?B?bUFRT21JUkRZTW5aU3RPRCtiOWlRdTBrSFlISEx6dGJIYmdvL2NlOEFVZUZU?=
 =?utf-8?B?ZWpYNXJoZFErWWRKTmpnUmhDb3BlbkszQkY1NDk0eS9PZlZRcE5BcEYxMnVj?=
 =?utf-8?B?a3BwOVBud1FpSHdwblYwU0ZjR1REM0F0R2FreGpzVUVUNjBvTng5QVdCcyt3?=
 =?utf-8?B?TEZjcVJFcUVmR0dJQmlMNEkrVjF2QTBYMjE3L3MvNk9uL0l1TDh4SHlpU1Jq?=
 =?utf-8?B?YXVjZDBSZVJ6dTZiaHlzNzlCRkthSHF6WncyWDhPaWQzMm43czllK2tzWDl2?=
 =?utf-8?B?bXRLeXArdTdUcEt1aEMyNUxBRkdmUmpObnFGa29rVlFndHgvWFU3UE9Fb2tK?=
 =?utf-8?B?YWgvOE1laFR6UHZBSE9QQ2tqZWQ5VXh2WkZIbzRSTmxIWGNKQzFLZ3luUEhk?=
 =?utf-8?B?OFphOHllS2F6NURlcXNsZHF2blJXVFg5NXNvYlM3TWRFdHViZzErSWM3NXcy?=
 =?utf-8?B?QmwzVzAzakFQbEova0ppOUZlU1YxQnZKNWNvTTQ1Ulh0OHVHS3ZKUDg1b3Av?=
 =?utf-8?B?bmhhLytYUGJ0UThsLzNlelNzY2FBbEJwZ0NKekkxdzllSW5tZ3NubEN4WEFF?=
 =?utf-8?B?WGdEMGo5NmxpUnVRaVk0Rld6SmtsMDdkVk1XS0xzMkpXMC9jRGpYTlN5Vndq?=
 =?utf-8?B?cnZVeEh6VVQ2anJuT01uK1FwczhYS0JidkJZczFJMkJKODlqVHNCaXVaTXNx?=
 =?utf-8?B?U0xLdDBjZU1VbWxhOE5CVStYUzJTU29QMGE5Q1JLQytGeWhKczdjZVp0WkdV?=
 =?utf-8?B?UllQUVo5bGhEQldzMGhldVVKalBDZjhPcmp5VzdRakpqbVArZ2ZmQXRpbXhF?=
 =?utf-8?B?djFZZ0RWU1BiNXRBUmxsa0M3TUYvRU00Qkl6QlArcUxZOXpWRzk3V0pHSkdW?=
 =?utf-8?B?TEJxZ3VlbFdTenA5Sm0xTHYyZmlHNUQ2Z0xDK01zRXRkejRJamVsRmQ5WTRH?=
 =?utf-8?B?c0lGeWZzdW9DeEhvRjhjL1NRQ0NBNEhPaEN4c3lNcmtlZ2hEVDNSWjhiUnFl?=
 =?utf-8?B?OGxuU0lVUEF6M05xUkl1blRESDRjRnJkTnA3dVFuNXZERGEvRnNPcHc2dnVK?=
 =?utf-8?B?NjdRUU43MW1yc1M3OHlYNkNyWG5rNml4M0E0TjFwb3orVFR0cGN0cG9oMWJF?=
 =?utf-8?B?Q0g4N0x1QWplWG9mb0ZpN2lVMmxKZzlLb25LU1ZVWUFvNitkbmpYQzQ3eEtl?=
 =?utf-8?B?UnFzcjlxNEFhYWVUSE83WDZadmxIVHhlMytBSzYzRk5SRFpsRUhFclZzZE9s?=
 =?utf-8?B?VVdZcUdyTHp0NlBNOUYwU1BvbGNCZStuaTViMWZrWi9pU1VrbEFiR0RaOXZE?=
 =?utf-8?B?eFhzZGI5cHJMZ3k1WjB5YTdCRytYYUVjU2JnZjhrek1LWURRSnNpQXprLzEr?=
 =?utf-8?B?alVBeWJVV0pqSEtvckZ3VzJEMVc1ZUtqc3ovYnZzd2NhY1lhZ2xlWXVOS2hS?=
 =?utf-8?B?VnVWWmhCNFVheTZKQjdWVlpGS29KQXRqUE5KTGx5eWVUei9URVhSR1dYSjB6?=
 =?utf-8?B?K09UWkxGWEFlNGxlSHlDY2dyajl0ajJUcWlEOEF3ZGNkaW5LZGFLbDlJYWZh?=
 =?utf-8?B?WWZ5K2JZaGE3bjFmR0FDUFYzMWRtanZ2KzVnUExYUXVCeFIrQWx3ZXBRaXJV?=
 =?utf-8?B?WG1nZGV2ckRrdndFWW1mb1BDVG9weXV6Mkk0aHdkcENxMTZZZ1hVK0VXdkE0?=
 =?utf-8?B?Yk55UzJMam4yanE0NGkrS2xDaGxIaGtUQldYcUkydGFNNlpjWlhXTmZzVTlV?=
 =?utf-8?B?ZGRkbGhqWm1jaHNJcnllMHZjMkhzK0hWNS9oVEJ5ck5uWTR3UkFHc3M3amdF?=
 =?utf-8?B?S2dKazU1TUVreGF2Z20vU1RQenlkMnhUbEZUbVhQMXBmNFk0VkJxUWhyT2Va?=
 =?utf-8?B?RVh5TXZTelJXZlZrRVd3TWwvK1ZqQWs5Z2lUMDJqTUZTdGg1VEZiUjdhUkln?=
 =?utf-8?B?OEs1RnptVFV1T3IvSWkraHVFMzkyc0NMS3U3c1lzOXdsaVN4anFSRnhEekFo?=
 =?utf-8?B?bE1KQXVsaFkyTkk2eVY3Q1JGT1NYT0tSaE5FeEk1TEtSbTg1eGtOSUo2U3lu?=
 =?utf-8?B?eTI5WThjTnVocENCV1RXMkY5RFR1UEhRak9IZDI3UXZYQmRtT0J5ME05aHJv?=
 =?utf-8?B?VG01c1ZXM0k2d1M4R3dsK3NIWGJVZjZDSnp1SHJmQzNsOFByU2FyRlBsRWRM?=
 =?utf-8?B?eFNLK1U0T2FJb2JpaU1YUnFlYTE2dU93MG5WUkxYd0FwSHp2T3JuMy9aZ096?=
 =?utf-8?B?MWdyenl2bExlNnBJUVR4L0F3aERQSVZKMWVDN2VXMm5tWlh4cmpGQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d17ee-3289-468b-2e02-08de535b7b8e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:55:51.4377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyS5ag+eM2OLcHy8d4MUT5Y2LR7VkUoxjs1b+5+84LuBput3T9PD2+UWLoPRfdsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280
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

On 1/14/26 11:48, Srinivasan Shanmugam wrote:
> The user mode queue keeps a pointer to the most recent fence in
> userq->last_fence. This pointer holds an extra dma_fence reference.
> 
> When the queue is destroyed, we free the fence driver and its xarray,
> but we forgot to drop the last_fence reference.
> 
> Because of the missing dma_fence_put(), the last fence object can stay
> alive when the driver unloads. This leaves an allocated object in the
> amdgpu_userq_fence slab cache and triggers
> 
> This is visible during driver unload as:
> 
>   BUG amdgpu_userq_fence: Objects remaining on __kmem_cache_shutdown()
>   kmem_cache_destroy amdgpu_userq_fence: Slab cache still has objects
>   Call Trace:
>     kmem_cache_destroy
>     amdgpu_userq_fence_slab_fini
>     amdgpu_exit
>     __do_sys_delete_module
> 
> Fix this by putting userq->last_fence and clearing the pointer during
> amdgpu_userq_fence_driver_free().
> 
> This makes sure the fence reference is released and the slab cache is
> empty when the module exits.
> 
> Fixes: edc762a51c71 ("drm/amdgpu/userq: move some code around")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 3c6bd5531627..b13cf5114121 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -50,8 +50,12 @@ int amdgpu_userq_fence_slab_init(void)
>  
>  void amdgpu_userq_fence_slab_fini(void)
>  {
> +	if (!amdgpu_userq_fence_slab)
> +		return;
> +
>  	rcu_barrier();
>  	kmem_cache_destroy(amdgpu_userq_fence_slab);
> +	amdgpu_userq_fence_slab = NULL;

Please completely drop that change. When amdgpu_userq_fence_slab_fini() is called multiple times we have a major problem at hand that we shouldn't hide.

>  }
>  
>  static inline struct amdgpu_userq_fence *to_amdgpu_userq_fence(struct dma_fence *f)
> @@ -141,6 +145,12 @@ static void amdgpu_userq_walk_and_drop_fence_drv(struct xarray *xa)
>  void
>  amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq)
>  {
> +	/* Drop the last fence reference held by the queue */
> +	if (userq->last_fence) {

Drop the if check and the comment, dma_fence_put() is NULL safe.

> +		dma_fence_put(userq->last_fence);
> +		userq->last_fence = NULL;

We kfree() the structure a few more lines down, don't we?

If that's true then please drop setting the member to NULL as well, otherwise keep it.

Regards,
Christian.

> +	}
> +
>  	amdgpu_userq_walk_and_drop_fence_drv(&userq->fence_drv_xa);
>  	xa_destroy(&userq->fence_drv_xa);
>  	/* Drop the fence_drv reference held by user queue */

