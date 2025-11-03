Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13483CCFA05
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 10:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C6F10E00F;
	Mon,  3 Nov 2025 10:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mkycz3F9";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E116210E00F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 10:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELT8bFh/qEPE3kNu4lAtBcAiIm5uBtBV6mP/0KmYOZ6iqXQQLMfZvfqxlU2jBN3p6GD2bN2pIcw+TX6r4jyLBYUUzDchm2bUZ/8ZTi6vk1UjNZA67Nn1BCuADR9ZRpToMIxQfM2dY6xxFd3XWJOpEmkdg72I1PIVIns6WlvBQ+2v5DwVVx+WJJUwmSpDbhWbEHtwH0D7vohT3xv5HtBW2tdrzbkc0mqvPJt1gQo4b5wQwfTTOjYfpRzHbeIOkccr0ZuiPSZ9hOMlb0UXYbaIHcGUgSX3cPTh7e8o4CIx5zOjsi+kXAeeWwk+yb4pYVsOqu98efrzxbkGIHPqiQQB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLCuAbPOU2dCr/3LW/yUkgUyLxIetbx5WUwjqM/S4WM=;
 b=eGxoefa1sB/aP+we8yQl6Q4oQhdikku73IoPUCBr0iQN5+q16wfI/UA0QwztTVAffS83BmGFbQJ0eiyriQhLRvyqyNEdlCN3xcWtSp2oSzRSCFo2otQm22rsXiyU9+xCi6vXu3x9xQjlFQWOEhtkcdjb0r6lXEKydxneEEpegw2imzC3/0aeBak8Xlis4k+Hsl8I05urYXn0K3BcALAMAZAwwNx5Pr9qlUlRBwTcqKUIKNkVIDEn1wGdj3bz6GU/XaKemNzRrYsKYh/Poqk/K2y7BzKjweSj9DyeEg7x7MWfldtQz1qtoChyYwlx3NttJ1XJ2I984n7vzMifNN5RJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLCuAbPOU2dCr/3LW/yUkgUyLxIetbx5WUwjqM/S4WM=;
 b=Mkycz3F9P9Cn4s2f7WP0W4ythV8LTBuwOYKCryOiXubSLUKza1m4W7Uu7ygjKq2oSfeqJ4ZcTpDt5DX7sMAk3mHF7f3mQwNVcZV7jhACodA6+8qT3VagNOpu8nWGpuLeFiRXo/fTpNoP9jHe3nEIT2m5PhQ1ZPPP/632hij+lk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8693.namprd12.prod.outlook.com (2603:10b6:208:48e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 10:51:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 10:51:51 +0000
Message-ID: <eaefde24-1b5d-4cbd-b23e-6a5a608493fa@amd.com>
Date: Mon, 3 Nov 2025 11:51:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix possible fence leaks from job structure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Jesse Zhang <Jesse.Zhang@amd.com>
References: <20251027220255.507105-1-alexander.deucher@amd.com>
 <20b7418c-c091-4e4f-aa40-556dd68605ee@amd.com>
 <CADnq5_P0fT6PFDOz1Fn7mWz4Q=aC1G8vX-D3XbPmSx1dc9KLJg@mail.gmail.com>
 <c4b73b23-441e-46c0-a752-3fe30d1bd9a0@amd.com>
 <CADnq5_NT-P-izFo-hWi7dpfDtU8WZitEw4xaKOjczRmgzwH5SQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NT-P-izFo-hWi7dpfDtU8WZitEw4xaKOjczRmgzwH5SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0223.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5cea4d-e941-4496-94c5-08de1ac6fe8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWFUSkFjZVJQSHBmaUF1OExGVmFWVnBpT3RNRmIrTlhKZmFGc1Jadkx0cGdx?=
 =?utf-8?B?Yk93eFAxT3I3SDM5REg5ZlJiUngvSjNTdkJrclRSeWZ1Q3ZIWVgveUdiMElR?=
 =?utf-8?B?bEl6dkJ5ZmZ6U2FEOHZrdVdkaFBpL0hqL2FiaytwT0VXMlgzU3BxNmkrWDVy?=
 =?utf-8?B?ajU5T3Ard1RUcks4bHMwQTM0Ujdjb3ptWm8rdlZIUnJaRjNvMXZhcWl4NU1B?=
 =?utf-8?B?T1ByY3kvUFhNNkt2eWRFL0VvQWRaekNJa2ZYa3F4TE1QZ29NVlo4VzhSZ2Fj?=
 =?utf-8?B?OVd5K2lzWmY5WEVUR2djOWJwemxubEpOL3J4ZDBiWUlmWHVxTGw0RzhRelpF?=
 =?utf-8?B?NWZTb1c3VldzdUVWeXFobkNnN0luRTBjZnZJeTJBdmRsaURTNWpmSFdYWmhi?=
 =?utf-8?B?Z1lqTUoyemFwaXpRcFEzYklMZ09icnFnSGpGcjZtdjBhNUgxNFNWZlloYmY0?=
 =?utf-8?B?V3dWeDV4cm1XZlR3NFRDdnBhdWRSa010YkRZUWRHWG1jUllvczQ0LzlYWUFk?=
 =?utf-8?B?aG5zTXVBeXdhcVowa1FZcmNPN01UOUdRSnNxV0FLbEplMkt5YmxQL0VZays1?=
 =?utf-8?B?YXZBM090ZncvM240WlR3bWRiTFl0YWh6dC84LzVaMk1DY0toTGRCeDNMYlRW?=
 =?utf-8?B?RzhoZ2I1ODAvbkJ6R2x5eWFqTklDTTNlMlRZZ01NZm1iMTJieXF2MHhrRGxY?=
 =?utf-8?B?dmRSVU5nTnlSbnhRUFI0M1EvWUtUbUNQMHRWL3VTRXpLYW0rYjExdk9CTjVY?=
 =?utf-8?B?dEhNKzlVQlUwaWhFeUM0bWJQR3hYbFNyYjZ1cWkwWktVRmUwVU82ODFoRlll?=
 =?utf-8?B?djRnb1BGVDQrb29IeC9DaTBNM0loTjljUkQyQzAxUnhLYkV4OHNoUkRYOWhC?=
 =?utf-8?B?SDhKSjlobmxOb2dwc0FrTUVjK2FXN0lyTWVFYitnRm9QcjhacWFCYTlyaEs2?=
 =?utf-8?B?azNGWlhvSVMxWHQ0bTl1QWF4THFTU2MwamlDS0hwdWtMWW00YkNIK3F3a3hL?=
 =?utf-8?B?UmYwYmZXZ1ZjSkp0UUJqREoxbGZFeEhPRGdJZjNlRkZ6Q0tiYXE3UDZqbmdj?=
 =?utf-8?B?dXdUSWZrTXhEN0tpeXduSDlDODVjS0RPck8rU0ZUQ2VTa1R4Sk4zNCtLUjI4?=
 =?utf-8?B?RUV2SHN3bG11U1czWm5PeWFUenZ3VEVDSG55OEVlbHVudWZWcWcwaVNpUlpG?=
 =?utf-8?B?REdvT1JVK3g4bjZ0SkFMOWx0UjR2OFZCVjdIbXVad3hySW80b2ZQR3ViczN6?=
 =?utf-8?B?enlTMTZlc24yL2dPc0pUV1RmbmZRaFpjeXp1QmlmNFprMzZyeGlWZHkvZ0NX?=
 =?utf-8?B?cTFxZVVmZHJsQVVLV3RvS2lzQjBYWC84RTRjcWJWTmtFejNtZTErbW9MZHh2?=
 =?utf-8?B?cEJaTWV6RnMyNjF5dEpxek5DNUdzT1BQMnJwVnNYMlBDVkN4aWJmNWRDQU1P?=
 =?utf-8?B?QmlnaVVmTU9vTXBubHhXd09FeHYrdUdHd1pvSXFnSEZDN1daeW4vem4xRzRh?=
 =?utf-8?B?VVNMZEd1Y3l5MUZ3SkxYeHpiQWt0NERZRTE4bmVLWjFuaDZaMUg2RGVhT3Bk?=
 =?utf-8?B?bjZyV1hPQUQ2dktObHYxRnpwK1RnR3pwWjJHajR1Y3AwSXBJNGNFL2Q2WE5u?=
 =?utf-8?B?bE9FZ3ovQjNoUFVjbVliR1ZSNHRCekNlRGxmVElVUWFtSFROU01xTEV0WXh3?=
 =?utf-8?B?VmRsUXNNbWd2MGJOc0VxdkVicmxnblFhY2poRWVQdXB4bXBRS3lVTWpRdk82?=
 =?utf-8?B?UVVGZTRnU01jWENHUlZFRncrSUI0bkppTlo5VFR5M1M1SmM2UUp6djlCVHE3?=
 =?utf-8?B?Z1BDMElaL01Ka0JCVkRhOFFiVHhvZmtPNGN3cDhkN3VXU1NVbC9EdU9uS2Zx?=
 =?utf-8?B?YXpSdjQ5YmhET0xRc2NFdnJFdEFDUGRNZXhzcGpzaUNxZE1LSEkxaEN1T0tP?=
 =?utf-8?Q?SmiDUCDmwhEGkoWDhDZjy6dhMwmB5EvN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGIrQjMvOVZiRW02Y3BpZ2VlbEF1a2ZLR2h6dCtvbGh4RzFUNTV0dzJyemtp?=
 =?utf-8?B?dTZqS2t3ZUhCaW5Ld3FFU1ZlRjdVKytkR3pNR2t1bm9pdUEzQ2JpL0preUZt?=
 =?utf-8?B?ZXdZaXR4SkM4ZXgvbFAzaDd2VStXRjJKZTRNR1N2S2xWb01BQm1XQ2xVOG93?=
 =?utf-8?B?aVFrazMyZWZkUmk3cTJKTG1uc2xHQzM3K2NISmQ5NUNsRVYzTGc5dU1Eekxt?=
 =?utf-8?B?MGIrN3N1ZE5ka2JRNHNMR0NOcmlIMzVYZjEyMy9YWEVBRHJydVRnUTJsbjR1?=
 =?utf-8?B?OW42SEZoWlR0cjIwdll0TjhxZjlUNWVjVkVUeDkrRkhmcUhlN2lVejlRUWQ0?=
 =?utf-8?B?VDhIdTFUdWNKd2MxdWNnTElDRy9mUDZacGlHRjZXVVIxdTUyS3NCNitBNXFO?=
 =?utf-8?B?bVMvemgyRkZrNFpxUEJMZHovWmUzcUdxei9aZ0tPdnNaR3BiZzFwWXZDeW1l?=
 =?utf-8?B?SStHZHNhckY1ME9Lbnh4VGRqb25WVE94dkJrU25XSlJLTXZSaHVHMUJqenlO?=
 =?utf-8?B?TXIrL2lRU2ZwZGxFRjEzcEhJMWN1dlpPaks0aFF6SUZuL0JOMDlKZEQ5MnVD?=
 =?utf-8?B?c1lsMk8xSU5hK0J6dUZVQzJuektZc0tscmlPQW5pZVpJZGNML1d5U1RteStx?=
 =?utf-8?B?Q3o4bktUa1FUbXUyQVJ5OFNNSUlPNDNIZVEzSUFGL0d0S2NmNXZCYlBtL2Jo?=
 =?utf-8?B?TUUwZUtzZWJHSjk3T3JmbkU3a09PVlFSdEhMcnlZZy9KMmlHUVhSRURiUHl6?=
 =?utf-8?B?YnkxT1lqbWE2TDlWeVZ6ZmF0eExLSEF0ZmkzejhqRlhIT3FObmVvbHRSeklz?=
 =?utf-8?B?Q2VsZFJwNWJCcStMOEtBdC81RXh0S0tqVlROQnZmWDVVRE5qL2Y3enFzZ3hP?=
 =?utf-8?B?UDJOMm9IRkdSSmNYdkRPZXJmM1JZaHBLRnlTWmFVcmpsYUx2cUpaLzd6eG1t?=
 =?utf-8?B?RzVVeDRvbHYzWTY5M3JwSjh0VGo1cHRsYkM4Y21KcXZFWks3aHBraGUzUHFM?=
 =?utf-8?B?bjJrajZTK3ZjZ2w2UHZPOVJMSWZ4enZYbUFaQlMzdE5kWmE3cnRSR2xGMTlR?=
 =?utf-8?B?d1FlVzJsY2JiUDBNQ09halZMYWhmTDF4clNPVTJFY2M3MDlsWnNtVURGN0Q1?=
 =?utf-8?B?c3pubitYd3B6WkxPUEtJWndBb0RBeUtNN1JpZ2NIVzRlTWp5ZDhLV2NMR2k1?=
 =?utf-8?B?cENkRVZuR3luVTFKR3laSDZLaElhdEwxSWtXVStFMnY2L0h4LzBZRkxrU1Vm?=
 =?utf-8?B?RHpab3AvbTI5YnFjbG13a2FzcG9oQnpvaGJSNjN1N2tTM0pkRnJBOWhzN2xO?=
 =?utf-8?B?SDlsNUZNNFVSNHc1RFkveitwK0k4VmNrSnFxK1J4bTNyeXNyMTJ1U3ZMeTQr?=
 =?utf-8?B?bEkxanVNaTJMTFhKWGgxOGF2K2VSTU5kU0RaT1RyNzJNdXdUejYrQ05pUDFX?=
 =?utf-8?B?QkFJZ0FSRTVUZTdYcHV5TVpBWGJpSVZ2eUhJbk40WFRyeW14NjNLRWtnR3Nk?=
 =?utf-8?B?Qyt4VldUYWp4aGY2b0tLeW1wTS9xc0Fid1RqeURGNWhycTFYTUFrTTlXTjls?=
 =?utf-8?B?Zjk5djcxbWs5UlJ4Z29hclZGbG1uVXBWcG5NMTNQT0JYRkNrYW44YmxFdzRz?=
 =?utf-8?B?WVR5OXBnNmFBK2wwYXV3VHlqZE10d0N6UUJ5NFFhN2hXYndRZXdoMVhuOTlW?=
 =?utf-8?B?UVk0M3R1WU8wK0gxV0lQWEl6U1dyd3Y4N2poL1lTL2dFL2dJQ1l5cyszL2dl?=
 =?utf-8?B?d29tV2x2OUpndE5mYVJUNS9OVXdQNTdmekQyaWpya3dzUTcwSW9WOEVoc2ZU?=
 =?utf-8?B?bkMydDJ0VDlpYm5EL1g2eW9GZkw3SXZwaTg3VFJLc0xaK0dxYWdXcjQ4M2c2?=
 =?utf-8?B?NDlDVU5pZThkc3V5cmFwRTJEOC9ydTd4YVdmc3lySFNMUGJNQm5LSEp0TzZL?=
 =?utf-8?B?VkVpRm1janhLNXN5WUJXZTNkV2VScjNLMGZuaUFiWmV0UDZpeHduWjZvRFUw?=
 =?utf-8?B?ZjZtSDRhenpIdlZrZnB3SnhJM1dTbFBESEhhNklQZ0duNTBPZFFPMU1MemRa?=
 =?utf-8?B?UzVyakpRZW9oV0NzT3FIbDN3bWVxSmcvdFpCVnEzNEpiYmVzMUhFL2dqeVNv?=
 =?utf-8?Q?Rs0Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5cea4d-e941-4496-94c5-08de1ac6fe8d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 10:51:51.1664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY0rZvPaJjtTZ9tZa02rIwmhNOoLUrtjHrW8zDnMYWnVFLJSbKMowWFLFgYd/kow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8693
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

On 10/31/25 16:28, Alex Deucher wrote:
> On Fri, Oct 31, 2025 at 10:01 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 10/31/25 14:53, Alex Deucher wrote:
>>> On Fri, Oct 31, 2025 at 4:40 AM Christian König
>>> <christian.koenig@amd.com> wrote:
>>>>
>>>> On 10/27/25 23:02, Alex Deucher wrote:
>>>>> If we don't end up initializing the fences, free them when
>>>>> we free the job.
>>>>>
>>>>> v2: take a reference to the fences if we emit them
>>>>>
>>>>> Fixes: db36632ea51e ("drm/amdgpu: clean up and unify hw fence handling")
>>>>> Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com> (v1)
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  2 ++
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 18 ++++++++++++++++++
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  |  2 ++
>>>>>  3 files changed, 22 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> index 39229ece83f83..0596114377600 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>>>> @@ -302,6 +302,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>>>               return r;
>>>>>       }
>>>>>       *f = &af->base;
>>>>> +     /* get a ref for the job */
>>>>> +     dma_fence_get(*f);
>>>>
>>>> I think it would be better to set the fence inside the job to NULL as soon as it is consumed/initialized.
>>>
>>> We need the pointer for the job timed out handling.
>>
>> I don't think that is true. During a timeout we should have job->s_fence->parent for the HW fence.
> 
> We also need to keep it around for job_submit_direct() so we can free
> the IBs used for that.

Good point, but that handling here is really not straight forward.

Anyway feel free to add my rb for now, but we need to re-visite that at some point.

Regards,
Christian.

> 
> Alex
> 
>>
>> But even when we go down that route here, you only grab a reference to the hw_fence but not the hw_vm_fence.
>>
>> That looks broken to me.
>>
>> Christian.
>>
>>>
>>> Alex
>>>
>>>>
>>>>>
>>>>>       if (ring->funcs->insert_end)
>>>>>               ring->funcs->insert_end(ring);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> index 55c7e104d5ca0..dc970f5fe601b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> @@ -295,6 +295,15 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>>>
>>>>>       amdgpu_sync_free(&job->explicit_sync);
>>>>>
>>>>> +     if (job->hw_fence->base.ops)
>>>>> +             dma_fence_put(&job->hw_fence->base);
>>>>> +     else
>>>>> +             kfree(job->hw_fence);
>>>>> +     if (job->hw_vm_fence->base.ops)
>>>>> +             dma_fence_put(&job->hw_vm_fence->base);
>>>>> +     else
>>>>> +             kfree(job->hw_vm_fence);
>>>>> +
>>>>
>>>> This way that here can just be a kfree(..).
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>>       kfree(job);
>>>>>  }
>>>>>
>>>>> @@ -324,6 +333,15 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>>>       if (job->gang_submit != &job->base.s_fence->scheduled)
>>>>>               dma_fence_put(job->gang_submit);
>>>>>
>>>>> +     if (job->hw_fence->base.ops)
>>>>> +             dma_fence_put(&job->hw_fence->base);
>>>>> +     else
>>>>> +             kfree(job->hw_fence);
>>>>> +     if (job->hw_vm_fence->base.ops)
>>>>> +             dma_fence_put(&job->hw_vm_fence->base);
>>>>> +     else
>>>>> +             kfree(job->hw_vm_fence);
>>>>> +
>>>>>       kfree(job);
>>>>>  }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> index db66b4232de02..f8c67840f446f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>>>> @@ -845,6 +845,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>>>               if (r)
>>>>>                       return r;
>>>>>               fence = &job->hw_vm_fence->base;
>>>>> +             /* get a ref for the job */
>>>>> +             dma_fence_get(fence);
>>>>>       }
>>>>>
>>>>>       if (vm_flush_needed) {
>>>>
>>

