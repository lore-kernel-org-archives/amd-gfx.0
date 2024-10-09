Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FA6CF0435
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 03:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9679B10E632;
	Wed,  9 Oct 2024 03:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nJV7SafR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDB710E632
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 03:43:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6uw2V95pfn/IVpNHPV0SrTf9Y7mmTzgBqPyuaz/GTrQwW+MVgPcY1XKIZTDuSCXmthz8KurseWIfG4qiEu2Atkxw02gKgUNCsDAiZYpZDRj7HW8vNfbKMGtRkNHPlvmKvd5hBI3v3wW8gn/sIbqxwX4MR68T440UEqZ9r/AH9TWPGpKmMViXC4Ude+zBGbbLea6VVkTpeMn/IPEiHL0fRHQCkx4J6EBflyUiUjtOmNHWmkzLvlxyf9odikT9Idt5TkllwDlpmnP7OE+GWTNmuGonmWgDcBZSbY7GZXF5qo23zWEMEDHfMj62nSHUHhFPstMy7jMB6ZfPkd/48d0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvX4fakz0KTMLfTj1sxo9/vQ+Oa5QNG/39+5npEtcjs=;
 b=PBwmvqp0tM1uZLuoPYODgzzwX1eFfG/b+3eiC59NaH3yy/Jl0RUKfZf+MgK8hsvUpeD1b5MUc2SaVPJTqaytEwTBaik4Gm8PedYQXoyl6PM7rIe0LPYsAASj6xuhqomQKdrzhvHlShcP0kxXfThCanQUqtnk2JnS6ZKH+EfGIkIp61Szo6TY1Q7tWqQanSuh7/q6Eglnc1qAkYCih6ZL+5vB6tUOzfuKcpmLb/WAitUIFhHo1dMSpDeb2e+vR3o/Hzt7tsYNC//B/b7L3dmmNsNjLtDsD4QWYv6sdyxcX9t9ox7gaq7qnEKb9aLjVpqA9kOqe4AAnZrppE1qU/HtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvX4fakz0KTMLfTj1sxo9/vQ+Oa5QNG/39+5npEtcjs=;
 b=nJV7SafRRBoScq8OgU5q+eGjcxN9AGQxsIsxUk50bMYdVhCNSGryjIETxC9anxJrQ0M844iP4ocL/UUM9qfKAKf26YqfsHdX/7Jp9AS8TGilEoyScxZPsN9kN/ew6l3lj85qf7BH4GBsPMcqvQVEgcD4tH4AYhhinPqpfoOzj1U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB9191.namprd12.prod.outlook.com (2603:10b6:a03:55a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Wed, 9 Oct 2024 03:43:08 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 03:43:08 +0000
Message-ID: <24b64e37-bd47-4f12-8ebb-93fc8e8a0a17@amd.com>
Date: Wed, 9 Oct 2024 09:13:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] drm/amdgpu: power vcn 2_5 by instance
To: Boyuan Zhang <Boyuan.Zhang@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-12-boyuan.zhang@amd.com>
 <4a7b5736-f60b-433b-a021-fef2cf4f2338@amd.com>
 <2d260d2c-d052-4b07-9cbf-0e5fc4199f98@amd.com>
 <5f4babf7-f8b9-4a93-8858-849b8b32c3b9@amd.com>
 <CADnq5_NK2fQMo=N=KEnnw3Not9PnWAw4nBK4+JUfY-Km7dX1Aw@mail.gmail.com>
 <7d48c870-2313-4af8-baea-6b0c423406ba@amd.com>
 <CADnq5_NWsADDzLhQbN2xVdiskX7Bm7abg2NSmP-iWXN===OORA@mail.gmail.com>
 <a4b3d506-1bcd-438e-a264-983c175c71cb@amd.com>
 <44276ef5-3d8d-42f9-a24f-f3f9093df2a2@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <44276ef5-3d8d-42f9-a24f-f3f9093df2a2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 278d57c8-b18d-4828-1377-08dce8147d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejlONXhHWVF5eUNMSEtCRVY5R0RDRHYyZFJqY081Tjd6WjJvQURBUUJpeUd5?=
 =?utf-8?B?SUx2QjZrZ0Jac282OEpZYzUzbzg5elBiZUY2R1lGbm1qYVpKYnN6Mzc5bzlR?=
 =?utf-8?B?a3JyT2hBYkJNK2h3MkM0WThCMDJqdEE3WEFKNjgzanZpaVZ0NThCQXZPWGFX?=
 =?utf-8?B?OGNiSS9kc1EwMk9Qd0ZJYkhmazY2YitEamQyS0FoeXFTSFAvYTh4Z1YxUEFD?=
 =?utf-8?B?VFFObWVsT21ieUJ1aC9MZHRhNE94ZXJnN0tLSzJKM3Z4cEhlUDdaTlhzTnpq?=
 =?utf-8?B?OE0wQTd0OS9LajdzTFQ5UXdyZzFRZjEwRUoxSTdWZUR2VWlVVVJCbVl4MDYx?=
 =?utf-8?B?dHdiYU1TQTRGMjBIZWtCdDhVVVhTd3BDTHNKR0EyTENvTnpwaGFzejNyL3Qz?=
 =?utf-8?B?d0VjQW5WdnBURGZ0UmxpRS9MZkxGYzdFSUtoS09pb0JaVHBQSkRCVXBwK1dp?=
 =?utf-8?B?THA3OGkzVHR6L3k0YTZBZy94ZkovN0hrdFY1cWlZZC85N0RTeU5Bd0owZm85?=
 =?utf-8?B?YlBGYU02dzh6bnoyQWt3ZHJLWXNDVk1OV1BNZUl3UGZidmcweUEvYVdiTFhq?=
 =?utf-8?B?bDFRaDRGR01Zb25CQ1NYT0hQZHhtTmM4U2RPU1BkUlkxaEplaGNrc1pqSFRJ?=
 =?utf-8?B?YVg5b2R2MWY2aUJrb1ZJaFRFb0ZORnoxWGNLWHB0bVNmYUdJMlF2VEZLMVk5?=
 =?utf-8?B?YWFmRVVFNkpMLzhIbE5ERE8xVFNBTEJQWWY1bHpJenY2bXlhV2d2cmJKZnAz?=
 =?utf-8?B?KzJwaE1HcXo1Z2ZPcXVSVm4wR0gzQ3F4bmpjclJ6SnExOW9TR1BieDhEWi92?=
 =?utf-8?B?QVJhWDdwOFhWSmlNeTZRZEZDajNWYkZsaXNOeEkrWW54ZVJZRDhwK0FXRlBm?=
 =?utf-8?B?UGlrVXp3dEo4bldVSHhEOWkrSTlJckVhcHh4cG9EYkRMZE1nTEpRZEZCOUVv?=
 =?utf-8?B?RmZnMUdubG5OK1hKMHM2cnJ6aUIzT2JpTDZVU3ovL1VnNGJaWWw5ZVNxZysv?=
 =?utf-8?B?VU9lUXVpWnlEWFV4TkZKSmREOHFLUkhyQ0tjTEZSa0EzZVM1eEFLNlZIZ1Ax?=
 =?utf-8?B?VkNlU1hoY1NkQjlIeUdCSG9laFMyRUNVS0VLRHc4U2U1ODQzenRFcGhpanAz?=
 =?utf-8?B?b3pJQTRUbW0zTlJWczJPcm9ySnJiWmZGUTdMK0ptYVZ1bVc0OFE4RjBySEY5?=
 =?utf-8?B?MDRpWVI5c21jU1NkQzdaSEpFdVo1VEpxODI5bVN4MDhVUGJPUlR5SFU3QUJk?=
 =?utf-8?B?Y2kvQ0ZEciswRjA3VHV6Y2N1cTVUbitQZHhxanFJRE9xb3pGN2Zzd2JqUVdk?=
 =?utf-8?B?SVY3T0dLdi83QkJzeWNQdWIzTHhaODhramE3UExZRXlqSlpnWEREQi9xWmdk?=
 =?utf-8?B?N21WR1MydjM2NVdaMlI4QVdFZWNmSkZxOXk5elBsbG9MTTRkTmc5K0ZweW0w?=
 =?utf-8?B?RTJrTXJ3NmxzQ083QW5ZdUdxSW9DbERBcXQzL1R0dnFQYXg5VStVWVRTK01o?=
 =?utf-8?B?SnA1a29nTDFhRW5lMDlwUXYxWGhOT09nTXZIWldlQjM4aHhNV1VoYmR3T0k2?=
 =?utf-8?B?OHBneitEb3ZDaTV6b21qL2IxZGowVGhMNTYvaXE3aHlRQVhRMTR5azhpa2Vt?=
 =?utf-8?B?RERGeXUxSTRoa0NwTjF2bFpzaDJtQldJNmZtU1phYW0wR3BrQU9GT1NFaVQv?=
 =?utf-8?B?NW5JSEVmRHpPaENNYTJJek51aTNkVHlRcEcyWHBTMEFGOVhIZkJPTURBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmkwN0F1MU92OGJsWkRoaGpGVW54UytWQ0Z4RVprc3VqbzdYZDVLbG1DUlF2?=
 =?utf-8?B?ZWJqOURkOHFkT1pjNFVmZVhTaUVBbS9KUDkyaWRUWDNON2hlaERWMzZtMmts?=
 =?utf-8?B?cm81NUIvM1E0K1V3ZXpielVLNktQUVcxd0wzRERHZEtNdm1pcTVjYnBySGxm?=
 =?utf-8?B?K3dVNUtyZE1IMGE5Z04yR1Rza2ZkWnI4WitON2NkQ2JyYkZreWZQV0VSaTJy?=
 =?utf-8?B?amFXTkFJYVowVjFFZEs0OTNJR1hEODZadjMwRTRVNmR6MHpvOHhMcXZDckJj?=
 =?utf-8?B?TFlpQi9jRXE3ZTVPOHpHOFVhemI1YTFkSnRmWmxqQ1lBNEc1MEhIUG5paE5X?=
 =?utf-8?B?em9TdEY4MG14YVkweDh4cnV4eTNpVnd3YU53WmFOckJNUXovelZqcVpMeUVm?=
 =?utf-8?B?QTRCc1VhN2tYT2ZZczUvVDVWN0FSaU5xQWhNMHYvSi9vRUs3Uk01cGwvS2JS?=
 =?utf-8?B?TnppUUkyb3ZodUxUOXp4WDlKY1RjWHBUSXN2M29VdFdPM2QvZTBXMmVuUC9H?=
 =?utf-8?B?UFlEUlBFb3pleXFMU09ldWdiYUNRL0JqSDR1OXVpYytqZWdTTXhUdUVBeUpU?=
 =?utf-8?B?SlE0dFVha3YzTzc4S2VjL3RIdDcyMFVqbHZMTlVOTVNXN0MzbTcwWitLUVdp?=
 =?utf-8?B?MUxUdjk3bzRKN04wbVViSzVIWGtwQmFZZytDQ0krVlVaMGQxaHhJYy9XYTU1?=
 =?utf-8?B?cU9XSUZyanhwWjNoOEt2Y3VqOVFoa3BRbHNUMXVxY0FTVkVlSTVuaFBWejM4?=
 =?utf-8?B?TWNrTDgzdFN5YTFjaHdrekplcDREZ0p6eUlncXVQNVdqNms2VHhVK2daWjg3?=
 =?utf-8?B?ak1mTE0zMnRZTGlBdmZjemgvUnVVT3dQbFhlM3BtWm9SNkgvNlFqbCtkS3U3?=
 =?utf-8?B?Q0hPSXZ5WFNWZnBacFZiZ2ZDT0NNQWJxcEFYVkU5ajVPUzFpQkpYYmd1eXND?=
 =?utf-8?B?VVM0NlFVTmlQRTVFRWZaVFUrbDVVUThJU2lna0cvdTA2WG5ZcDhDdlRXM05G?=
 =?utf-8?B?OHZCOVJZeVhVNjlDVUUwV0lOTFhHdjR6RHJOQTRxZXJ1SDNRVTJLTFM3aGVx?=
 =?utf-8?B?c2JQbGJMTU9MdXhYaEFMVWlmaHpvaDZrRGlZaDd6RitLYmxOT0dldTJCbmJo?=
 =?utf-8?B?Q2M3L2N6YVZOSU5XWUFHZUJaWHBwVnlLWmdEVk92cjB6UVU0OHRpUXNGeG1W?=
 =?utf-8?B?UWxaSWNTMUJkVkxXa0ova2plWDFpQWhZa3FoczNtZ1F5bzY0TUlDcEFHeFlh?=
 =?utf-8?B?b293WGJEdy9ocHRVTGlqMmZNT1JFTHZ2dElqc0kzMXMwa0lRdFpsbjNyaEps?=
 =?utf-8?B?K1VxSHlHQTg0K1ZhcGUwS2RCb2J5eXAwZmFxMVord1N3RmZCRXhKd0MvZEZZ?=
 =?utf-8?B?bFNLYUw3aHFTekFCYTh3WkVvbkh3eXBjb0gvNjdWZFhtQ0hsRlF3cEQ4UkZp?=
 =?utf-8?B?dDlxS1E3aUE4MG1QRzNMLzJkVnh3RVF3b1VkWERsRGhZaVlJMlpNM3FscCtx?=
 =?utf-8?B?aDcxM0xHVGp4U3JNd0JaVTBoNjZURTM3RjdZOHE0UmlhcFN3TVBNS2llSW05?=
 =?utf-8?B?QU9tSmFqaHJsSS9ZRDJxcEw5cmVicTg1MlN6MmlsVm15RVVSUmxqZTlCV3dZ?=
 =?utf-8?B?RDNWLzExRUpmOCtKQlQxY3BBSjd2TFZ2NDFidExvUUM1WHRTYVc4SjhyV2Zo?=
 =?utf-8?B?UlBYYmtabyt1MWs0bGd2cEtJWk5xYlJqTTN4MW1GcDNNenBNZjFyUkZKcGtp?=
 =?utf-8?B?dTAwaXJ3dzBaSXREWGcvRmV3T3ErM1FzS2dXeVc0TzlIZXlkMWs0L051MXhS?=
 =?utf-8?B?L1ZHZVpaSENGay80OTFHTDFGQTBUa2NQWjRSKy9LQWszWExkekE1YkE3SnRB?=
 =?utf-8?B?ZFpOSEZ2WVlmNi9KVThOSmpSUTJUWm9mRDU4N0ZINU1XWS9HU2pCeHhnVUhi?=
 =?utf-8?B?QVlFbzVnQlZOYTlZQ2p2TUdiU3gyNDZkcHN5b3ZKVHhtdnZsc29qTStJdXBQ?=
 =?utf-8?B?dUQxVUQ1SFU1a25KQ0c2cGMxdnQwUGhQTWMzZGhtUlRCMElzYWl5SDVONGZY?=
 =?utf-8?B?dzdHeWhYeWlCQVUvMm1lRk1tMU5WbDZwc3VRQnV3eDNnK2M3Ky8rL1NDTmxo?=
 =?utf-8?Q?kmgxGEeOKQW3NwbUFIa0/Rh1v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278d57c8-b18d-4828-1377-08dce8147d96
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 03:43:08.7068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: //vNDWgyknjkUgXkxqdPC95CAA6Ku+Cb1qmETv4zsZ24QNI+QIskCPA1oG7jima7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9191
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



On 10/9/2024 3:34 AM, Boyuan Zhang wrote:
> 
> On 2024-10-08 03:03, Lazar, Lijo wrote:
>>
>> On 10/7/2024 8:54 PM, Alex Deucher wrote:
>>> On Mon, Oct 7, 2024 at 10:32 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>> On 10/7/2024 7:47 PM, Alex Deucher wrote:
>>>>> On Mon, Oct 7, 2024 at 9:58 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 10/7/2024 7:03 PM, Boyuan Zhang wrote:
>>>>>>> On 2024-10-07 01:22, Lazar, Lijo wrote:
>>>>>>>> On 10/5/2024 12:14 AM, boyuan.zhang@amd.com wrote:
>>>>>>>>> From: Boyuan Zhang <boyuan.zhang@amd.com>
>>>>>>>>>
>>>>>>>>> For vcn 2_5, add ip_block for each vcn instance during
>>>>>>>>> discovery stage.
>>>>>>>>>
>>>>>>>>> And only powering on/off one of the vcn instance using the
>>>>>>>>> instance value stored in ip_block, instead of powering on/off all
>>>>>>>>> vcn instances. Modify the existing functions to use the
>>>>>>>>> instance value
>>>>>>>>> in ip_block, and remove the original for loop for all vcn
>>>>>>>>> instances.
>>>>>>>>>
>>>>>>>>> v2: rename "i"/"j" to "inst" for instance value.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
>>>>>>>>> ---
>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +-
>>>>>>>>>    drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 565
>>>>>>>>> +++++++++---------
>>>>>>>>>    2 files changed, 280 insertions(+), 289 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>>> index 9f9a1867da72..de1053cc2a2b 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>>>>>>>> @@ -2278,6 +2278,7 @@ static int
>>>>>>>>> amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>>>>>>>>>      static int amdgpu_discovery_set_mm_ip_blocks(struct
>>>>>>>>> amdgpu_device
>>>>>>>>> *adev)
>>>>>>>>>    {
>>>>>>>>> +    int i;
>>>>>>>>>        if (amdgpu_ip_version(adev, VCE_HWIP, 0)) {
>>>>>>>>>            switch (amdgpu_ip_version(adev, UVD_HWIP, 0)) {
>>>>>>>>>            case IP_VERSION(7, 0, 0):
>>>>>>>>> @@ -2321,7 +2322,8 @@ static int
>>>>>>>>> amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>>>>>>>>>            case IP_VERSION(2, 0, 3):
>>>>>>>>>                break;
>>>>>>>>>            case IP_VERSION(2, 5, 0):
>>>>>>>>> -            amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
>>>>>>>>> +            for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
>>>>>>>>> +                amdgpu_device_ip_block_add(adev,
>>>>>>>>> &vcn_v2_5_ip_block);
>>>>>>>> This introduces a totally confusing design now. At a higher
>>>>>>>> level an IP
>>>>>>>> block type manages multiple instances and their power states.
>>>>>>>> Now there
>>>>>>>> is a mix where no definition can be attributed to an IP block.
>>>>>>>> Or, if
>>>>>>>> this were to be done uniformly for other IPs, then for some SOCs
>>>>>>>> there
>>>>>>>> could be 16 SDMA blocks, 8 GFX blocks and so forth.
>>>>>>>>
>>>>>>>> What is the reason to do this way? Can't VCN IP block maintain
>>>>>>>> the state
>>>>>>>> of multiple instances within itself?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Lijo
>>>>>>> This is part of the fundamental design change for separating IP
>>>>>>> block
>>>>>>> per instance, in order to
>>>>>>> handle each instance separately within same IP block (e.g. separate
>>>>>>> power/clock management).
>>>>>>>
>>>>>>> Part 1, Change all adev ptr handle to amdgpu_ip_block ptr in all
>>>>>>> callbacks (hw_init/fini, sw_init/fini,
>>>>>>> suspend, etc...) for all IP blocks, so that each IP knows which
>>>>>>> IP_block
>>>>>>> (and which instance) the
>>>>>>> callback is for. Most parts of this changes have been submitted
>>>>>>> by Sunil.
>>>>>>>
>>>>>>> Part 2, Separate IP block per instance.
>>>>>>>
>>>>>>> Part 3, Since callbacks can pass in IP_block now after Part 1
>>>>>>> change and
>>>>>>> instance value can be
>>>>>>> obtained from each IP block in Part 2, IP can then choose to handle
>>>>>>> callbacks ONLY for the given
>>>>>>> instance of a given IP block (or still handling for all instances as
>>>>>>> before).
>>>>>>> For VCN, all callbacks will be handled only for the given one
>>>>>>> instance,
>>>>>>> instead of the original for-
>>>>>>> loop for all instance. As a result, each VCN instance can be
>>>>>>> start/stop/int/fini/suspend separately.
>>>>>>>
>>>>>>> Part 4, Change all VCN helper functions to handle only the given
>>>>>>> instance, instead of the original
>>>>>>> for-loop for all instance.
>>>>>>>
>>>>>>> Each instance can have its own states, so we think it makes more
>>>>>>> sense
>>>>>>> to separate them on IP
>>>>>>> block level to handle each of them separately.
>>>>>>
>>>>>> Such a change should not be done unless all IPs follow the same
>>>>>> design.
>>>>>> You didn't answer the question - what necessitates this change?
>>>>>> What is
>>>>>> special about VCN that it cannot manage the states of multiple
>>>>>> instances
>>>>>> within the IP block?
>>>>> We want to be able to manage the powergating independently for each
>>>>> VCN instance for both power management and VCN reset.  Right now power
>>>>> gating is handled at the IP level so it's not easy or clean to handle
>>>>> powergating of individual IP instances.
>>>>>
>>>> Still VCN block can manage the powergated instances (FWIW, it's just an
>>>> array in SMU block). Also vcn block gets to run the idle worker and
>>>> knows the rings (and corresponding VCN instances) that are idle.
>>>> Maintaining instance states in VCN block and modifying idle worker to
>>>> just idle that instance alone doesn't look like a complex change.
>>>
>>> We already went down that road and it's really ugly.  We end up
>>> duplicating a bunch of code paths for different driver flows because
>>> set_powergating_state() and set_clockgating_state are at the IP level
>>> and we want per instance gating.  We could add a num_instances member
>>> at the IP block level and then convert all of the high level code that
>>> calls the IP functions loop over the number of instances, but that
>>> seems like just as much work and it's not quite as clean IMHO.
>>>
>> Sorry, I'm not seeing much difference in this design. All it does is
>> just split instances to IP block at the same time it's going to keep an
>> instance parameter in IP block APIs.
>>
>>     amdgpu_device_ip_set_clockgating_state(blocktype, instance);
>>     amdgpu_device_ip_set_powergating_state(blocktype, instance);
>>
>> Also, VCN continues to maintain an array of amdgpu_vcn_inst. I think
>> it's easier manage this with changes to amdgpu_vcn_inst. Since it is
>> continued to be maintained, what about just moving the states and
>> idle_work inside amdgpu_vcn_inst.
>>     
>>     int inst;
>>     enum amd_powergating_state cur_pg_state;
>>     enum amd_clockgating_state state cur_cg_state;
>>     struct delayed_work     idle_work;
>>
>> At the end of ring usage of corresponding instance, just invoke the
>> corresponding instance's idle work.
>>
>> schedule_delayed_work(&ring->adev->vcn.inst[ring->me].idle_work,
>> idle_time_out);
> First of all, separating idle work and state is still needed in current
> design.
> Separating idle work by instance is already handled in patch 17/18.
> Separating power gating state is already handled in patch 10/18.
> 
> I agree that "adding instance variable" in amdgpu_vcn_inst requires
> much less effort, but as mentioned by Alex previously, we already
> went down that way to use "inst" variable in amdgou_vcn_inst as you
> listed above and track this instance value all the way from VCN to SMU.
> However, this is a no-go based on discussions with Christian and Alex.
> Since set_powergating_state() is at IP level, it will be clean to do
> per instance gating at IP level. With the change of passing ip_block to
> callback functions, all ip functions can now choose to handle only the
> given instance, which is a clean separation between multiple instance.
> 

I don't agree.

There is no clean separation here. What I see here is a mix where ip
block still remains a dummy.

	ipblock->inst => calls vcn.vcn_inst[i] that maintains the final state.

If the design is based only on ip block, you wouldn't have required to
maintain another vcn_inst. Everything would have been handled by
maintaining state in ip block itself.
> 
>>
>> I don't see any change in this series for other IP block APIs.
> Yes, currently we only do this per instance IP block for VCN. For long
> term,
> the plan is to change all other IP with multiple blocks into this design.
> 

This path itself is not a viable solution. We will have cases where a
group of ip blocks of the same type need to be handled together. At that
point you will need another central controller for ip blocks belonging
to a type. That will evenutally lead to another superblock being created.

Thanks,
Lijo

> Regards,
> Boyuan
> 
> 
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>> Moving to IP block per instance for VCN alone is not a change that
>>>> helps
>>>> to define an IP block. If that needs to be done for every other IP
>>>> type,
>>>> that's also a massive change.
>>>>
>>>> Also, then it's no longer possible to have something static like this -
>>>>          struct amdgpu_ip_block          ip_blocks[AMDGPU_MAX_IP_NUM];
>>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Alex
>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Thanks,
>>>>>>> Boyuan
>>>>>>>>>                amdgpu_device_ip_block_add(adev,
>>>>>>>>> &jpeg_v2_5_ip_block);
>>>>>>>>>                break;
>>>>>>>>>            case IP_VERSION(2, 6, 0):
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>>> index d00df51bc400..1f8738ae360a 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
>>>>>>>>> @@ -158,35 +158,34 @@ static int vcn_v2_5_early_init(struct
>>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>>    static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>>>>>    {
>>>>>>>>>        struct amdgpu_ring *ring;
>>>>>>>>> -    int i, j, r;
>>>>>>>>> +    int i, r;
>>>>>>>>>        uint32_t reg_count = ARRAY_SIZE(vcn_reg_list_2_5);
>>>>>>>>>        uint32_t *ptr;
>>>>>>>>>        struct amdgpu_device *adev = ip_block->adev;
>>>>>>>>> +    int inst = ip_block->instance;
>>>>>>>>>    -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>>>>>>>> -        if (adev->vcn.harvest_config & (1 << j))
>>>>>>>>> -            continue;
>>>>>>>>> -        /* VCN DEC TRAP */
>>>>>>>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>>>>>> -                VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>>>>>>>> &adev->vcn.inst[j].irq);
>>>>>>>>> -        if (r)
>>>>>>>>> -            return r;
>>>>>>>>> -
>>>>>>>>> -        /* VCN ENC TRAP */
>>>>>>>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>>> -            r = amdgpu_irq_add_id(adev,
>>>>>>>>> amdgpu_ih_clientid_vcns[j],
>>>>>>>>> -                i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>>>>>>> &adev->vcn.inst[j].irq);
>>>>>>>>> -            if (r)
>>>>>>>>> -                return r;
>>>>>>>>> -        }
>>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>>> +        goto sw_init;
>>>>>>>>> +    /* VCN DEC TRAP */
>>>>>>>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>>>>>> +            VCN_2_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT,
>>>>>>>>> &adev->vcn.inst[inst].irq);
>>>>>>>>> +    if (r)
>>>>>>>>> +        return r;
>>>>>>>>>    -        /* VCN POISON TRAP */
>>>>>>>>> -        r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[j],
>>>>>>>>> -            VCN_2_6__SRCID_UVD_POISON,
>>>>>>>>> &adev->vcn.inst[j].ras_poison_irq);
>>>>>>>>> +    /* VCN ENC TRAP */
>>>>>>>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>>> +        r = amdgpu_irq_add_id(adev,
>>>>>>>>> amdgpu_ih_clientid_vcns[inst],
>>>>>>>>> +            i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>>>>>>> &adev->vcn.inst[inst].irq);
>>>>>>>>>            if (r)
>>>>>>>>>                return r;
>>>>>>>>>        }
>>>>>>>>>    +    /* VCN POISON TRAP */
>>>>>>>>> +    r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>>>>>>> +        VCN_2_6__SRCID_UVD_POISON,
>>>>>>>>> &adev->vcn.inst[inst].ras_poison_irq);
>>>>>>>>> +    if (r)
>>>>>>>>> +        return r;
>>>>>>>>> +sw_init:
>>>>>>>>>        r = amdgpu_vcn_sw_init(adev);
>>>>>>>>>        if (r)
>>>>>>>>>            return r;
>>>>>>>>> @@ -197,76 +196,74 @@ static int vcn_v2_5_sw_init(struct
>>>>>>>>> amdgpu_ip_block *ip_block)
>>>>>>>>>        if (r)
>>>>>>>>>            return r;
>>>>>>>>>    -    for (j = 0; j < adev->vcn.num_vcn_inst; j++) {
>>>>>>>>> -        volatile struct amdgpu_fw_shared *fw_shared;
>>>>>>>>> +    volatile struct amdgpu_fw_shared *fw_shared;
>>>>>>>>>    -        if (adev->vcn.harvest_config & (1 << j))
>>>>>>>>> -            continue;
>>>>>>>>> -        adev->vcn.internal.context_id =
>>>>>>>>> mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.internal.ib_vmid =
>>>>>>>>> mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.internal.ib_bar_low =
>>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.internal.ib_bar_high =
>>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.internal.ib_size =
>>>>>>>>> mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.internal.gp_scratch8 =
>>>>>>>>> mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>>>>>>>> -
>>>>>>>>> -        adev->vcn.internal.scratch9 =
>>>>>>>>> mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.inst[j].external.scratch9 =
>>>>>>>>> SOC15_REG_OFFSET(VCN,
>>>>>>>>> j, mmUVD_SCRATCH9);
>>>>>>>>> -        adev->vcn.internal.data0 =
>>>>>>>>> mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.inst[j].external.data0 =
>>>>>>>>> SOC15_REG_OFFSET(VCN, j,
>>>>>>>>> mmUVD_GPCOM_VCPU_DATA0);
>>>>>>>>> -        adev->vcn.internal.data1 =
>>>>>>>>> mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.inst[j].external.data1 =
>>>>>>>>> SOC15_REG_OFFSET(VCN, j,
>>>>>>>>> mmUVD_GPCOM_VCPU_DATA1);
>>>>>>>>> -        adev->vcn.internal.cmd =
>>>>>>>>> mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j,
>>>>>>>>> mmUVD_GPCOM_VCPU_CMD);
>>>>>>>>> -        adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>>>>>>>> -        adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j,
>>>>>>>>> mmUVD_NO_OP);
>>>>>>>>> -
>>>>>>>>> -        ring = &adev->vcn.inst[j].ring_dec;
>>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>>> +        goto done;
>>>>>>>>> +    adev->vcn.internal.context_id =
>>>>>>>>> mmUVD_CONTEXT_ID_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.internal.ib_vmid =
>>>>>>>>> mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.internal.ib_bar_low =
>>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.internal.ib_bar_high =
>>>>>>>>> mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.internal.ib_size =
>>>>>>>>> mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.internal.gp_scratch8 =
>>>>>>>>> mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
>>>>>>>>> +
>>>>>>>>> +    adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.inst[inst].external.scratch9 =
>>>>>>>>> SOC15_REG_OFFSET(VCN,
>>>>>>>>> inst, mmUVD_SCRATCH9);
>>>>>>>>> +    adev->vcn.internal.data0 =
>>>>>>>>> mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.inst[inst].external.data0 = SOC15_REG_OFFSET(VCN,
>>>>>>>>> inst, mmUVD_GPCOM_VCPU_DATA0);
>>>>>>>>> +    adev->vcn.internal.data1 =
>>>>>>>>> mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.inst[inst].external.data1 = SOC15_REG_OFFSET(VCN,
>>>>>>>>> inst, mmUVD_GPCOM_VCPU_DATA1);
>>>>>>>>> +    adev->vcn.internal.cmd =
>>>>>>>>> mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.inst[inst].external.cmd = SOC15_REG_OFFSET(VCN,
>>>>>>>>> inst,
>>>>>>>>> mmUVD_GPCOM_VCPU_CMD);
>>>>>>>>> +    adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
>>>>>>>>> +    adev->vcn.inst[inst].external.nop = SOC15_REG_OFFSET(VCN,
>>>>>>>>> inst,
>>>>>>>>> mmUVD_NO_OP);
>>>>>>>>> +
>>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>>>>>>>> +    ring->use_doorbell = true;
>>>>>>>>> +
>>>>>>>>> +    ring->doorbell_index =
>>>>>>>>> (adev->doorbell_index.vcn.vcn_ring0_1 <<
>>>>>>>>> 1) +
>>>>>>>>> +            (amdgpu_sriov_vf(adev) ? 2*inst : 8*inst);
>>>>>>>>> +
>>>>>>>>> +    if (amdgpu_ip_version(adev, UVD_HWIP, 0) == IP_VERSION(2,
>>>>>>>>> 5, 0))
>>>>>>>>> +        ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>>>>>> +    else
>>>>>>>>> +        ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>>>>>> +
>>>>>>>>> +    sprintf(ring->name, "vcn_dec_%d", inst);
>>>>>>>>> +    r = amdgpu_ring_init(adev, ring, 512,
>>>>>>>>> &adev->vcn.inst[inst].irq,
>>>>>>>>> +                 0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>>>>>>> +    if (r)
>>>>>>>>> +        return r;
>>>>>>>>> +
>>>>>>>>> +    for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>>> +        enum amdgpu_ring_priority_level hw_prio =
>>>>>>>>> amdgpu_vcn_get_enc_ring_prio(i);
>>>>>>>>> +
>>>>>>>>> +        ring = &adev->vcn.inst[inst].ring_enc[i];
>>>>>>>>>            ring->use_doorbell = true;
>>>>>>>>>              ring->doorbell_index =
>>>>>>>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>>>>>>>> -                (amdgpu_sriov_vf(adev) ? 2*j : 8*j);
>>>>>>>>> +                (amdgpu_sriov_vf(adev) ? (1 + i + 2*inst) : (2
>>>>>>>>> + i +
>>>>>>>>> 8*inst));
>>>>>>>>>    -        if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>>>>>>>> IP_VERSION(2,
>>>>>>>>> 5, 0))
>>>>>>>>> +        if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>>>>>>>> +            IP_VERSION(2, 5, 0))
>>>>>>>>>                ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>>>>>>            else
>>>>>>>>>                ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>>>>>>    -        sprintf(ring->name, "vcn_dec_%d", j);
>>>>>>>>> -        r = amdgpu_ring_init(adev, ring, 512,
>>>>>>>>> &adev->vcn.inst[j].irq,
>>>>>>>>> -                     0, AMDGPU_RING_PRIO_DEFAULT, NULL);
>>>>>>>>> +        sprintf(ring->name, "vcn_enc_%d.%d", inst, i);
>>>>>>>>> +        r = amdgpu_ring_init(adev, ring, 512,
>>>>>>>>> +                     &adev->vcn.inst[inst].irq, 0,
>>>>>>>>> +                     hw_prio, NULL);
>>>>>>>>>            if (r)
>>>>>>>>>                return r;
>>>>>>>>> -
>>>>>>>>> -        for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
>>>>>>>>> -            enum amdgpu_ring_priority_level hw_prio =
>>>>>>>>> amdgpu_vcn_get_enc_ring_prio(i);
>>>>>>>>> -
>>>>>>>>> -            ring = &adev->vcn.inst[j].ring_enc[i];
>>>>>>>>> -            ring->use_doorbell = true;
>>>>>>>>> -
>>>>>>>>> -            ring->doorbell_index =
>>>>>>>>> (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>>>>>>>>> -                    (amdgpu_sriov_vf(adev) ? (1 + i + 2*j) :
>>>>>>>>> (2 + i
>>>>>>>>> + 8*j));
>>>>>>>>> -
>>>>>>>>> -            if (amdgpu_ip_version(adev, UVD_HWIP, 0) ==
>>>>>>>>> -                IP_VERSION(2, 5, 0))
>>>>>>>>> -                ring->vm_hub = AMDGPU_MMHUB1(0);
>>>>>>>>> -            else
>>>>>>>>> -                ring->vm_hub = AMDGPU_MMHUB0(0);
>>>>>>>>> -
>>>>>>>>> -            sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>>>>>>>>> -            r = amdgpu_ring_init(adev, ring, 512,
>>>>>>>>> -                         &adev->vcn.inst[j].irq, 0,
>>>>>>>>> -                         hw_prio, NULL);
>>>>>>>>> -            if (r)
>>>>>>>>> -                return r;
>>>>>>>>> -        }
>>>>>>>>> -
>>>>>>>>> -        fw_shared = adev->vcn.inst[j].fw_shared.cpu_addr;
>>>>>>>>> -        fw_shared->present_flag_0 =
>>>>>>>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>>>>>>>> -
>>>>>>>>> -        if (amdgpu_vcnfw_log)
>>>>>>>>> -            amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>>>>>>>>        }
>>>>>>>>>    +    fw_shared = adev->vcn.inst[inst].fw_shared.cpu_addr;
>>>>>>>>> +    fw_shared->present_flag_0 =
>>>>>>>>> cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
>>>>>>>>> +
>>>>>>>>> +    if (amdgpu_vcnfw_log)
>>>>>>>>> +        amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>>>>>>>>> +done:
>>>>>>>>>        if (amdgpu_sriov_vf(adev)) {
>>>>>>>>>            r = amdgpu_virt_alloc_mm_table(adev);
>>>>>>>>>            if (r)
>>>>>>>>> @@ -1005,197 +1002,192 @@ static int
>>>>>>>>> vcn_v2_5_start_dpg_mode(struct
>>>>>>>>> amdgpu_device *adev, int inst_idx, boo
>>>>>>>>>        return 0;
>>>>>>>>>    }
>>>>>>>>>    -static int vcn_v2_5_start(struct amdgpu_device *adev)
>>>>>>>>> +static int vcn_v2_5_start(struct amdgpu_device *adev, unsigned
>>>>>>>>> int
>>>>>>>>> inst)
>>>>>>>>>    {
>>>>>>>>>        struct amdgpu_ring *ring;
>>>>>>>>>        uint32_t rb_bufsz, tmp;
>>>>>>>>> -    int i, j, k, r;
>>>>>>>>> +    int j, k, r;
>>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>> -        if (adev->pm.dpm_enabled)
>>>>>>>>> -            amdgpu_dpm_enable_vcn(adev, true, i);
>>>>>>>>> -    }
>>>>>>>>> -
>>>>>>>>> -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>> -            continue;
>>>>>>>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>>> -            r = vcn_v2_5_start_dpg_mode(adev, i,
>>>>>>>>> adev->vcn.indirect_sram);
>>>>>>>>> -            continue;
>>>>>>>>> -        }
>>>>>>>>> +    if (adev->pm.dpm_enabled)
>>>>>>>>> +        amdgpu_dpm_enable_vcn(adev, true, inst);
>>>>>>>>>    -        /* disable register anti-hang mechanism */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
>>>>>>>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>>> +        return 0;
>>>>>>>>>    -        /* set uvd status busy */
>>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) |
>>>>>>>>> UVD_STATUS__UVD_BUSY;
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
>>>>>>>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>>> +        r = vcn_v2_5_start_dpg_mode(adev, inst,
>>>>>>>>> adev->vcn.indirect_sram);
>>>>>>>>> +        return r;
>>>>>>>>>        }
>>>>>>>>>    +    /* disable register anti-hang mechanism */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS), 0,
>>>>>>>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>>> +
>>>>>>>>> +    /* set uvd status busy */
>>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_STATUS) |
>>>>>>>>> UVD_STATUS__UVD_BUSY;
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, tmp);
>>>>>>>>> +
>>>>>>>>>        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
>>>>>>>>>            return 0;
>>>>>>>>>          /*SW clock gating */
>>>>>>>>>        vcn_v2_5_disable_clock_gating(adev);
>>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>> -            continue;
>>>>>>>>> -        /* enable VCPU clock */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>>>>>> -            UVD_VCPU_CNTL__CLK_EN_MASK,
>>>>>>>>> ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>>>>>>>> -
>>>>>>>>> -        /* disable master interrupt */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
>>>>>>>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>>> -
>>>>>>>>> -        /* setup mmUVD_LMI_CTRL */
>>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
>>>>>>>>> -        tmp &= ~0xff;
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
>>>>>>>>> -            UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>>>>>>>> -            UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>>>>>>>> -            UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>>>>>>>> -            UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>>>>>>>> -
>>>>>>>>> -        /* setup mmUVD_MPC_CNTL */
>>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
>>>>>>>>> -        tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>>>>>>>> -        tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
>>>>>>>>> -
>>>>>>>>> -        /* setup UVD_MPC_SET_MUXA0 */
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
>>>>>>>>> -            ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>>>>>>>> -            (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>>>>>>>> -            (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>>>>>>>> -            (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>>>>>>>> -
>>>>>>>>> -        /* setup UVD_MPC_SET_MUXB0 */
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
>>>>>>>>> -            ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>>>>>>>> -            (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>>>>>>>> -            (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>>>>>>>> -            (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>>>>>>>> -
>>>>>>>>> -        /* setup mmUVD_MPC_SET_MUX */
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
>>>>>>>>> -            ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>>>>>>>> -            (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>>>>>>>> -            (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>>>>>>>> -    }
>>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    /* enable VCPU clock */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>>>>>> +        UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
>>>>>>>>> +
>>>>>>>>> +    /* disable master interrupt */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN), 0,
>>>>>>>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>>> +
>>>>>>>>> +    /* setup mmUVD_LMI_CTRL */
>>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL);
>>>>>>>>> +    tmp &= ~0xff;
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL, tmp | 0x8|
>>>>>>>>> +        UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK    |
>>>>>>>>> +        UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
>>>>>>>>> +        UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
>>>>>>>>> +        UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
>>>>>>>>> +
>>>>>>>>> +    /* setup mmUVD_MPC_CNTL */
>>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL);
>>>>>>>>> +    tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
>>>>>>>>> +    tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_CNTL, tmp);
>>>>>>>>> +
>>>>>>>>> +    /* setup UVD_MPC_SET_MUXA0 */
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXA0,
>>>>>>>>> +        ((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
>>>>>>>>> +        (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
>>>>>>>>> +        (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
>>>>>>>>> +        (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
>>>>>>>>> +
>>>>>>>>> +    /* setup UVD_MPC_SET_MUXB0 */
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUXB0,
>>>>>>>>> +        ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
>>>>>>>>> +        (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
>>>>>>>>> +        (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
>>>>>>>>> +        (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
>>>>>>>>> +
>>>>>>>>> +    /* setup mmUVD_MPC_SET_MUX */
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_MPC_SET_MUX,
>>>>>>>>> +        ((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
>>>>>>>>> +        (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>>>>>>>>> +        (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>>>>>>>>>          vcn_v2_5_mc_resume(adev);
>>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>> -        volatile struct amdgpu_fw_shared *fw_shared =
>>>>>>>>> adev->vcn.inst[i].fw_shared.cpu_addr;
>>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>> -            continue;
>>>>>>>>> -        /* VCN global tiling registers */
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>>> -            adev->gfx.config.gb_addr_config);
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>>> -            adev->gfx.config.gb_addr_config);
>>>>>>>>> +    volatile struct amdgpu_fw_shared *fw_shared =
>>>>>>>>> adev->vcn.inst[inst].fw_shared.cpu_addr;
>>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>>> +        return 0;
>>>>>>>>> +
>>>>>>>>> +    /* VCN global tiling registers */
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>>> +        adev->gfx.config.gb_addr_config);
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_GFX8_ADDR_CONFIG,
>>>>>>>>> +        adev->gfx.config.gb_addr_config);
>>>>>>>>>    -        /* enable LMI MC and UMC channels */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
>>>>>>>>> -            ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>>>>>>>> +    /* enable LMI MC and UMC channels */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_LMI_CTRL2), 0,
>>>>>>>>> +        ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
>>>>>>>>>    -        /* unblock VCPU register access */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
>>>>>>>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>>> +    /* unblock VCPU register access */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL), 0,
>>>>>>>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>>>    -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>>>>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>>>>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>>    -        for (k = 0; k < 10; ++k) {
>>>>>>>>> -            uint32_t status;
>>>>>>>>> -
>>>>>>>>> -            for (j = 0; j < 100; ++j) {
>>>>>>>>> -                status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
>>>>>>>>> -                if (status & 2)
>>>>>>>>> -                    break;
>>>>>>>>> -                if (amdgpu_emu_mode == 1)
>>>>>>>>> -                    msleep(500);
>>>>>>>>> -                else
>>>>>>>>> -                    mdelay(10);
>>>>>>>>> -            }
>>>>>>>>> -            r = 0;
>>>>>>>>> +    for (k = 0; k < 10; ++k) {
>>>>>>>>> +        uint32_t status;
>>>>>>>>> +
>>>>>>>>> +        for (j = 0; j < 100; ++j) {
>>>>>>>>> +            status = RREG32_SOC15(VCN, inst, mmUVD_STATUS);
>>>>>>>>>                if (status & 2)
>>>>>>>>>                    break;
>>>>>>>>> +            if (amdgpu_emu_mode == 1)
>>>>>>>>> +                msleep(500);
>>>>>>>>> +            else
>>>>>>>>> +                mdelay(10);
>>>>>>>>> +        }
>>>>>>>>> +        r = 0;
>>>>>>>>> +        if (status & 2)
>>>>>>>>> +            break;
>>>>>>>>>    -            DRM_ERROR("VCN decode not responding, trying to
>>>>>>>>> reset
>>>>>>>>> the VCPU!!!\n");
>>>>>>>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>>>>>> -                UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>> -            mdelay(10);
>>>>>>>>> -            WREG32_P(SOC15_REG_OFFSET(VCN, i,
>>>>>>>>> mmUVD_VCPU_CNTL), 0,
>>>>>>>>> -                ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>> +        DRM_ERROR("VCN decode not responding, trying to reset the
>>>>>>>>> VCPU!!!\n");
>>>>>>>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>>>>>> +            UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>> +        mdelay(10);
>>>>>>>>> +        WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>>>>>> +            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>>    -            mdelay(10);
>>>>>>>>> -            r = -1;
>>>>>>>>> -        }
>>>>>>>>> +        mdelay(10);
>>>>>>>>> +        r = -1;
>>>>>>>>> +    }
>>>>>>>>>    -        if (r) {
>>>>>>>>> -            DRM_ERROR("VCN decode not responding, giving
>>>>>>>>> up!!!\n");
>>>>>>>>> -            return r;
>>>>>>>>> -        }
>>>>>>>>> +    if (r) {
>>>>>>>>> +        DRM_ERROR("VCN decode not responding, giving up!!!\n");
>>>>>>>>> +        return r;
>>>>>>>>> +    }
>>>>>>>>>    -        /* enable master interrupt */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
>>>>>>>>> -            UVD_MASTINT_EN__VCPU_EN_MASK,
>>>>>>>>> -            ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>>> +    /* enable master interrupt */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_MASTINT_EN),
>>>>>>>>> +        UVD_MASTINT_EN__VCPU_EN_MASK,
>>>>>>>>> +        ~UVD_MASTINT_EN__VCPU_EN_MASK);
>>>>>>>>>    -        /* clear the busy bit of VCN_STATUS */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
>>>>>>>>> -            ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>>>>>>>> +    /* clear the busy bit of VCN_STATUS */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_STATUS), 0,
>>>>>>>>> +        ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>>>>>>>>>    -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_VMID, 0);
>>>>>>>>>    -        ring = &adev->vcn.inst[i].ring_dec;
>>>>>>>>> -        /* force RBC into idle state */
>>>>>>>>> -        rb_bufsz = order_base_2(ring->ring_size);
>>>>>>>>> -        tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ,
>>>>>>>>> rb_bufsz);
>>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH,
>>>>>>>>> 1);
>>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL,
>>>>>>>>> RB_NO_UPDATE, 1);
>>>>>>>>> -        tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL,
>>>>>>>>> RB_RPTR_WR_EN, 1);
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
>>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_dec;
>>>>>>>>> +    /* force RBC into idle state */
>>>>>>>>> +    rb_bufsz = order_base_2(ring->ring_size);
>>>>>>>>> +    tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
>>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
>>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
>>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
>>>>>>>>> +    tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_CNTL, tmp);
>>>>>>>>>    -        fw_shared->multi_queue.decode_queue_mode |=
>>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>>> -        /* program the RB_BASE for ring buffer */
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>>>>>>>> -            lower_32_bits(ring->gpu_addr));
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>>>>>>>> -            upper_32_bits(ring->gpu_addr));
>>>>>>>>> +    fw_shared->multi_queue.decode_queue_mode |=
>>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>>> +    /* program the RB_BASE for ring buffer */
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
>>>>>>>>> +        lower_32_bits(ring->gpu_addr));
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
>>>>>>>>> +        upper_32_bits(ring->gpu_addr));
>>>>>>>>>    -        /* Initialize the ring buffer's read and write
>>>>>>>>> pointers */
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
>>>>>>>>> +    /* Initialize the ring buffer's read and write pointers */
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR, 0);
>>>>>>>>>    -        ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
>>>>>>>>> -                lower_32_bits(ring->wptr));
>>>>>>>>> -        fw_shared->multi_queue.decode_queue_mode &=
>>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>>> +    ring->wptr = RREG32_SOC15(VCN, inst, mmUVD_RBC_RB_RPTR);
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RBC_RB_WPTR,
>>>>>>>>> +            lower_32_bits(ring->wptr));
>>>>>>>>> +    fw_shared->multi_queue.decode_queue_mode &=
>>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>>>    -       
>>>>>>>>> fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>>> -        ring = &adev->vcn.inst[i].ring_enc[0];
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI,
>>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
>>>>>>>>> -       
>>>>>>>>> fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>>> -
>>>>>>>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>>> -        ring = &adev->vcn.inst[i].ring_enc[1];
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2,
>>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size /
>>>>>>>>> 4);
>>>>>>>>> -        fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>>> -    }
>>>>>>>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
>>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_enc[0];
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO, ring->gpu_addr);
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI,
>>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE, ring->ring_size / 4);
>>>>>>>>> +    fw_shared->multi_queue.encode_generalpurpose_queue_mode &=
>>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>>> +
>>>>>>>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode |=
>>>>>>>>> FW_QUEUE_RING_RESET;
>>>>>>>>> +    ring = &adev->vcn.inst[inst].ring_enc[1];
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_RPTR2,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_WPTR2,
>>>>>>>>> lower_32_bits(ring->wptr));
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_LO2, ring->gpu_addr);
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_BASE_HI2,
>>>>>>>>> upper_32_bits(ring->gpu_addr));
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_RB_SIZE2, ring->ring_size / 4);
>>>>>>>>> +    fw_shared->multi_queue.encode_lowlatency_queue_mode &=
>>>>>>>>> ~FW_QUEUE_RING_RESET;
>>>>>>>>>          return 0;
>>>>>>>>>    }
>>>>>>>>> @@ -1424,72 +1416,69 @@ static int vcn_v2_5_stop_dpg_mode(struct
>>>>>>>>> amdgpu_device *adev, int inst_idx)
>>>>>>>>>        return 0;
>>>>>>>>>    }
>>>>>>>>>    -static int vcn_v2_5_stop(struct amdgpu_device *adev)
>>>>>>>>> +static int vcn_v2_5_stop(struct amdgpu_device *adev, unsigned
>>>>>>>>> int inst)
>>>>>>>>>    {
>>>>>>>>>        uint32_t tmp;
>>>>>>>>> -    int i, r = 0;
>>>>>>>>> +    int r = 0;
>>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>> -        if (adev->vcn.harvest_config & (1 << i))
>>>>>>>>> -            continue;
>>>>>>>>> -        if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>>> -            r = vcn_v2_5_stop_dpg_mode(adev, i);
>>>>>>>>> -            continue;
>>>>>>>>> -        }
>>>>>>>>> +    if (adev->vcn.harvest_config & (1 << inst))
>>>>>>>>> +        goto done;
>>>>>>>>>    -        /* wait for vcn idle */
>>>>>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS,
>>>>>>>>> UVD_STATUS__IDLE, 0x7);
>>>>>>>>> -        if (r)
>>>>>>>>> -            return r;
>>>>>>>>> +    if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
>>>>>>>>> +        r = vcn_v2_5_stop_dpg_mode(adev, inst);
>>>>>>>>> +        goto done;
>>>>>>>>> +    }
>>>>>>>>>    -        tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>>>>>>>> -            UVD_LMI_STATUS__READ_CLEAN_MASK |
>>>>>>>>> -            UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>>>>>>>> -            UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>>>>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp,
>>>>>>>>> tmp);
>>>>>>>>> -        if (r)
>>>>>>>>> -            return r;
>>>>>>>>> +    /* wait for vcn idle */
>>>>>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_STATUS,
>>>>>>>>> UVD_STATUS__IDLE, 0x7);
>>>>>>>>> +    if (r)
>>>>>>>>> +        return r;
>>>>>>>>>    -        /* block LMI UMC channel */
>>>>>>>>> -        tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2);
>>>>>>>>> -        tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL2, tmp);
>>>>>>>>> +    tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
>>>>>>>>> +        UVD_LMI_STATUS__READ_CLEAN_MASK |
>>>>>>>>> +        UVD_LMI_STATUS__WRITE_CLEAN_MASK |
>>>>>>>>> +        UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
>>>>>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp,
>>>>>>>>> tmp);
>>>>>>>>> +    if (r)
>>>>>>>>> +        return r;
>>>>>>>>>    -        tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>>>>>>>> -            UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>>>>>>>> -        r = SOC15_WAIT_ON_RREG(VCN, i, mmUVD_LMI_STATUS, tmp,
>>>>>>>>> tmp);
>>>>>>>>> -        if (r)
>>>>>>>>> -            return r;
>>>>>>>>> +    /* block LMI UMC channel */
>>>>>>>>> +    tmp = RREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2);
>>>>>>>>> +    tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_LMI_CTRL2, tmp);
>>>>>>>>>    -        /* block VCPU register access */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
>>>>>>>>> -            UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>>>>>>>> -            ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>>> +    tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK|
>>>>>>>>> +        UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
>>>>>>>>> +    r = SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_LMI_STATUS, tmp,
>>>>>>>>> tmp);
>>>>>>>>> +    if (r)
>>>>>>>>> +        return r;
>>>>>>>>>    -        /* reset VCPU */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
>>>>>>>>> -            UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>>> -            ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>> +    /* block VCPU register access */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_RB_ARB_CTRL),
>>>>>>>>> +        UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
>>>>>>>>> +        ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>>>>>>>>>    -        /* disable VCPU clock */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
>>>>>>>>> -            ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>>>>>>>> +    /* reset VCPU */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL),
>>>>>>>>> +        UVD_VCPU_CNTL__BLK_RST_MASK,
>>>>>>>>> +        ~UVD_VCPU_CNTL__BLK_RST_MASK);
>>>>>>>>>    -        /* clear status */
>>>>>>>>> -        WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
>>>>>>>>> +    /* disable VCPU clock */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_VCPU_CNTL), 0,
>>>>>>>>> +        ~(UVD_VCPU_CNTL__CLK_EN_MASK));
>>>>>>>>>    -        vcn_v2_5_enable_clock_gating(adev);
>>>>>>>>> +    /* clear status */
>>>>>>>>> +    WREG32_SOC15(VCN, inst, mmUVD_STATUS, 0);
>>>>>>>>>    -        /* enable register anti-hang mechanism */
>>>>>>>>> -        WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
>>>>>>>>> -            UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>>>>>>>> -            ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>>> -    }
>>>>>>>>> +    vcn_v2_5_enable_clock_gating(adev);
>>>>>>>>>    -    for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>>>>>>>>> -        if (adev->pm.dpm_enabled)
>>>>>>>>> -            amdgpu_dpm_enable_vcn(adev, false, i);
>>>>>>>>> -    }
>>>>>>>>> +    /* enable register anti-hang mechanism */
>>>>>>>>> +    WREG32_P(SOC15_REG_OFFSET(VCN, inst, mmUVD_POWER_STATUS),
>>>>>>>>> +        UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
>>>>>>>>> +        ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
>>>>>>>>> +done:
>>>>>>>>> +    if (adev->pm.dpm_enabled)
>>>>>>>>> +        amdgpu_dpm_enable_vcn(adev, false, inst);
>>>>>>>>>          return 0;
>>>>>>>>>    }
>>>>>>>>> @@ -1838,9 +1827,9 @@ static int
>>>>>>>>> vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
>>>>>>>>>            return 0;
>>>>>>>>>          if (state == AMD_PG_STATE_GATE)
>>>>>>>>> -        ret = vcn_v2_5_stop(adev);
>>>>>>>>> +        ret = vcn_v2_5_stop(adev, inst);
>>>>>>>>>        else
>>>>>>>>> -        ret = vcn_v2_5_start(adev);
>>>>>>>>> +        ret = vcn_v2_5_start(adev, inst);
>>>>>>>>>          if (!ret)
>>>>>>>>>            adev->vcn.cur_state[inst] = state;
