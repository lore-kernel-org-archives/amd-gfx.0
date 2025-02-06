Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D01FC02199
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 13:47:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB12310E841;
	Thu,  6 Feb 2025 13:47:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s7OlbDlH";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2050.outbound.protection.outlook.com [40.107.100.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09F4210E83D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 13:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPAyrFTMs/vth0niwWTGvbcCiUBiRdqLGLgqUf0XIV+9+iOiSxHVnHp6zGYVU43wKzq7mUGmVbsbkpC6oPLGA/VQM3lVtiezT+/HvW1bcxHliOQ/I4E/6Euk2rERQlH5D24kKSMZAg3c2OXa4JD2qY2kyd/2qMbjmVj82kGkLVtAUxn/UykTDd/13oTz9K56G/6H3pcnrWmiLrfxwI6/HWiVRGkKdHGrZBVlN8LkBBU4ALsCr8ZQ5qYb4bb2l/zJASBXstzHDED65SFFBZMrwsf2TzlhzoW9iZcGfBiZf/gBV1FTJAtYwSV1xqVn8BKQ1NV8NlWt5XZ6JeGnneWqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LDN7AlFhq55RVgovNo91H8SZFwXsnKyD1qd1ryIZ2w=;
 b=GTzFVQ92ZV3qpnk46CIHBxG+OHNCQyUnyxfGrORZYm4fWXypfA16cDiJ3CRSdh13gocxGhMJnQWU95Sv48yrjITYz3pQXg+Vd7RLNcFghp6tgrk42Q/oIO7YY25jX9vsMTGILHEFyauiCHLvMAr8ANsYvEov4CGjpXNacYFKpK20CfAP1qvGS0Ck+kiCIsWHtBl3GAeTwSYiPSxiTFlFACf1VaCAgtVUk5jft3OwbVRzcJ1DKUNAGkX6MABeSwxUJGjW9nOJpoMyYhUPhiM5Aha10g1hNY1ttMPnLHJPLC/Ub+6f3ptFsgXp+y9beQ7ZikwjFHlJXXvqZp2nH7FKyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LDN7AlFhq55RVgovNo91H8SZFwXsnKyD1qd1ryIZ2w=;
 b=s7OlbDlH2cfADd7Bw/ZsLHR25B0y8WRH6LwkNQzkEE6NtEZVi2m6NNcIQAQaF88rq85U9PjZ5gts3TSxe627g3OvlBdgO5mdkULX5NH39IIbqESf+Vt+cQylAlXEyxzrS8qTAkNtgQRBbcTEsKWpWS/S4I5au9mt8sKqQKlzwuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 13:46:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 13:46:46 +0000
Message-ID: <744abfb3-9edf-4ebb-b657-b811ef156001@amd.com>
Date: Thu, 6 Feb 2025 14:46:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/scheduler: Add drm_sched_cancel_all_jobs helper
To: phasta@kernel.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>
References: <20250205153332.14852-1-tvrtko.ursulin@igalia.com>
 <20250205153332.14852-2-tvrtko.ursulin@igalia.com>
 <67d2ebf31e78c7819fee6f8de917829957091a0d.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <67d2ebf31e78c7819fee6f8de917829957091a0d.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b601a46-cb74-4710-7a35-08dd46b4b2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW1oOGFxVTBLaTNSOVRSVXdnUzZwL1hpL2xCNXB5OXZtN3VEeDA4cVc2OGxF?=
 =?utf-8?B?VGpXbUF1dHNaZUJwUUNYZjBjNDlQUDVvUEkxNnBwUytZN2JBcHUwM3VSSjUv?=
 =?utf-8?B?OTBBcUdsZWJFcEdvWHBPTnFzSEJWOWxoY1ExWmZKME1kaTZPTVlCY0swNGJO?=
 =?utf-8?B?eDFNTnBHc3dCeUMwb3dCeE1NaGdRUlBuMlM4V3k3bzlNcEh6YVorbVRnRG94?=
 =?utf-8?B?cU5PbC8wM0xhbk13NFNXVXdyL0I0NmRxSEpveVZYSHAyUUFnV2Z6M3Vndnhj?=
 =?utf-8?B?VjJNeDRiWVV1Zm1Qc0JhWnpRRE1kY3Rxc2ZGWjNCeFdvNS9xQWRiUXVJc0lX?=
 =?utf-8?B?TU9weVBsRlpqR2dVWWU1S0lzb3ZyMjBGbDQ1OEJGb3B0QjVSdTBra1I2ME5U?=
 =?utf-8?B?K0VHK01MMHBaVGdVSzg4V2xFYkpkRjBNbGwrMFVseEZ4VWk0NlliZ3JHc3Vj?=
 =?utf-8?B?NkZVR1BteHA4eWlBQ082TWFmaDdLTUs5QWZIZkNBMzZRNFJ6c05zK2NqM1Jl?=
 =?utf-8?B?N3lBZXQ4RXRoOXdvcTBERHhQRDhsOXh6dnk5RmoybDlzTGlGRDlYTFZmN0Nu?=
 =?utf-8?B?M3pBRWtzMTZoWEpQZ3BGZXVHd2llVXZBZHVoMGtQNVQ4cVMvYk5ITUo4WFVD?=
 =?utf-8?B?MW9FNHdxUW91azRFRUoyZmNqUWptQ0MxSUtwbkNzZjdRY2hMRHlCT2gzMnlH?=
 =?utf-8?B?cFlhdktqdmtqOU15Nnc5MUxFcjJHT2hqMzF0YytsUU5PSCtLc3FmNEZoOTBS?=
 =?utf-8?B?VkFDazF3TysrNitMWkdCaXE5OFdCQlhNN2RYczJTZWVITjhrS2ZjcnB1ZGRG?=
 =?utf-8?B?RjZQbU5oSXYxcE1BcEF1TFphTS84RFo5aU5nTHdzTlJQVVlXa1dvaHpwYW03?=
 =?utf-8?B?b1BZYVZ5eXg0eU5ENTliRisreGM0V2gxQU9lTG51YUtpQXhiOHpLVzdqNHpQ?=
 =?utf-8?B?YXJMdjhCVnVHS053S2JSRHFHMldGN3FaR0U4eDJvMndoUjZLQ1dTaHc2TXBm?=
 =?utf-8?B?ZTdvci8vbVk3amczMFU0MVFLQlFNRU5YSi9EdTdqTEtzaWJjS1UxOXpYSWk3?=
 =?utf-8?B?MXh1eWZTWVlVS2FJL0dTaWJUNm1xcU05bnNEQTk2MjZBQUFrS1libXdrUmlB?=
 =?utf-8?B?TUZqc1ArY1VuQk5QNURxaUsyNlVETkZUVnh1MHQzTlY4bmd3aFhobm1oRW0w?=
 =?utf-8?B?dlozK1pORXRMaHl4Y1BQbFdVT3RNakpheHRsbmlQUUl6YkVYaWpkL2cvY05t?=
 =?utf-8?B?QSs1ZEJ1dFM4K1hHMS9heWZTL0srZHhPUlRPQmtGa0NmUTdjbDVMWlA5N1hH?=
 =?utf-8?B?VjdwVUpKQTg2cWRVemlxYUVLUk43dEp5OFp5Z3N4SHZyQ1haRktQMG5POTRO?=
 =?utf-8?B?SXhKS2V0QU1FN3lpL09UZWhJbGsvK0FJSXVBb2xiWGFLNndYNjdTRWYzYnFD?=
 =?utf-8?B?eUtwMUdxRjcxa3gyWDc3UkR4RittR2libzlWaEJtQU5qQ29hMnErRXZwZStL?=
 =?utf-8?B?MU1YWDFXNlNLSXBBWUlhKys0ZHpSUXN0Rk9SZ05rMWJMVW5aNU1qSVFMTjAz?=
 =?utf-8?B?V2VpbjZ2ZnMrZ25wWE82ZVN3b25hTDRqWDJRZDZMM3Q1cCt6T1FUc09zVjlx?=
 =?utf-8?B?ZnZIRURTSm9VL1hhRzBSNGJKUzJRTmxJUkJuZXZnc0Vzd21KcDlnZ3BSQi83?=
 =?utf-8?B?K2N2VDRvQmtyLzdtNThyaElBUGtJWnFQa1RTNk04YnAzVGp6cWE5TEE5R29q?=
 =?utf-8?B?Z3F6bkRhb2poL3FoRFJVZlVxbTJydEh6NWEvRmtoUXliNXVaYWx2dzBjclJS?=
 =?utf-8?B?RGpSQlRXczBaMmdrYm0zZnhmd2UzcDY2amxoWmNzcXBlTE9iK3Z6dUtpdnoz?=
 =?utf-8?Q?NUbpG8D9BITkC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBYT09xZFNqOE1SK3JQbVp4RFh2K3Bpa0JMcVFTZDZDVXZFVnZWTS82anVK?=
 =?utf-8?B?cHBWTWFPRjUrMDRYbzgrUkNwUGdoMmpsQ2QrMER2UHJqc3RuN1NGaGtyY0w3?=
 =?utf-8?B?aC9EZUZOcmxlZ24rWGhIUEI3QnJka3B0UmhrK2h6MXh0Qm0rQWdFdGd6UWtw?=
 =?utf-8?B?UHZxenE1RGpzV3ZZSnora2lZLzRMOTcya2V5elhNS0d4RVF6cDhnQ3JyMlU4?=
 =?utf-8?B?MitxTmZ2ZXFqVkFMVHRvaU8xNGJKZmJ2SUVWc3dITm9ueXJKeDU2WFlHN0k0?=
 =?utf-8?B?c2NSR1drdTI3MDZXUkFJaE5LaGR2YjNiMEhqMkQ5RVJzYWU4dTRSNDI0SU5k?=
 =?utf-8?B?d1dFSnFWUzF1cXQ4bDIrUXhnNmtZTk9LQjBKTDlXaG8zL0JOdFZENkpBSHlx?=
 =?utf-8?B?K00rdzdOSEd5T1RZbjdzajM4d050eXZzZG5RTjRMKy8vYVhQQ1AxbTMzVWVB?=
 =?utf-8?B?TDRxd05CWTJnb0FBVEpRUjJ1RlVES0UreURGa1Vrd3R1RVgzRGU1anM0VjNq?=
 =?utf-8?B?akcwQlo0UStNTDRvSmovRmF1dWsvNmJxbnN4K1htdllDclJqcFJrak56djk1?=
 =?utf-8?B?L2lVUHRPelpQMk5qUTAzWHFmYlF4enZKL3p3SnZhMFJvV2oyRDVDSjBrV3Jy?=
 =?utf-8?B?L0Q1N0E2NnpGYnZUUlV1eTR0RG9HNTZOa245QWQrS2dhS2FQeFlOejBTaEF6?=
 =?utf-8?B?a2ZKWnNpZUpoUjR6Mm5ld2Q4WEZTM0djQ0VQRndQZXN1dmlDMWhGdDdWVE5v?=
 =?utf-8?B?RFpFeFFBMEo3RkF0bzBlRVliWFhKRXJSU2NsRjMvd0JrbXIzUm5aeWdkVGZW?=
 =?utf-8?B?alZnRU1wT2xFeXlqbGZtSjBhaytKZFRGeHU0SjlzVHgvalRNVk5lVVVwZFpN?=
 =?utf-8?B?eWpNRG9GTTkyTmhhNGw4VUxYU1diMTJNNHZpcE4vRnFyNGs2NGJHa2FtYVRY?=
 =?utf-8?B?SFdwWVdzS3ltdkQwSzVuV01MRnBMOXhMeFlXcDdUM0YyZnhRQnZpV0lHWjBq?=
 =?utf-8?B?Q2NDY1pITlZMeUt1V1FMNFZoYkJHZHBpMFN1S2JnZkxTYjlBRzJWUUI3c2Ri?=
 =?utf-8?B?VkdQUm96alVJazNrZjN1T3A4b1pXU3ZWN3BRWDY0ZXVTcnB4WGR6WlVrZEh4?=
 =?utf-8?B?bFZKdFNsNDYra2k5RDZNaVVrOVc3ejRGS3oxUHFxa3VDazBlUHoxbVRKRDBk?=
 =?utf-8?B?WFo2aU9VNU5UWTVKTWwvaXI4LzNGVmNxWjYyaWJUcGY2UlAvSEpTTTBqUm5O?=
 =?utf-8?B?Y0ZOTkM5cHZPRk9zRXpsM1dRWDY0eUNCMjNiN3pQOCtCanNsQlkvZ1NRWkQx?=
 =?utf-8?B?Tml6am1DQXJ2b1BVMUg1ZmlYR2tzNEFwZzFiOFFkV3RoRGFlZ2VYSlN5MFRN?=
 =?utf-8?B?TWlPVTRiVmUyMXpSdFFDTGlFcVJ1b2hnbmtrSE94dFUrcnBpNEljZFY5M2Ix?=
 =?utf-8?B?MmYzNVYrcTd5SW5PVUUzNHlLVk5kaURWYnp5bE1velUvZVBGMU82YW4yd0Vj?=
 =?utf-8?B?aFVRcXU0MU13ZWtReDMyZ2tYb1pBRGRUY0FTRW4wL01hOXpVaUg1SGVmMWZo?=
 =?utf-8?B?STg3VHEwQU15MmlJRDNMZFdQSFRET1lFNjExVkl2YXU4UDVsUENQUWh6Ym40?=
 =?utf-8?B?NUFpUklDRTJWZVk0c1lzQTVZWUZRS1NmVzhtWDl3aUNwRFZROEJkYWZlWW01?=
 =?utf-8?B?UUlIcndJczNsSHhlTDZoZTY2ZS9ZUVF0YmZNRXBJeHAzRVVSMXFIVkJsak9U?=
 =?utf-8?B?S01tUXZzQlVjbXRSb2R2OEFVVm5wcGRRQ0dMNXpLcnNObVMwNjIwRzc0TXBX?=
 =?utf-8?B?OUVTUUxBRUQranEwVVptUTEwa004RHV3K3RsdUJCYVk0Njk1RTUyQUdiZ254?=
 =?utf-8?B?cmdmaXV0aWxjakdweHVRajZ6V0tQc3IyeHF3bW9JNENBMWFZazYxWlVDTlNT?=
 =?utf-8?B?QjVHaEU4cHRvd3Z1SVhNLzNrbHNCYXRBQkJSMi9aK21oQWtRVml2VEpIWjMy?=
 =?utf-8?B?UnFURzVUbHRYWmFHUzJqd1hZMFMrb3RIemVydDJZWWJ5enNTWkJKQW1tUEVp?=
 =?utf-8?B?U1VyYjR5RWxtdURYTW9MTlJQUDVub29tK2JSaXIrd1VGcnFzUk1xdnNlbkdr?=
 =?utf-8?Q?6WuUcVLnUNyiHmcg2OxVqHdR/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b601a46-cb74-4710-7a35-08dd46b4b2d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:46:46.7625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkiiFyTgUJ5OcbYa8xM4NhAcJJ8yv/RV9wNEnECiiCcwEuDcJCi/waRhim54MXuO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
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

Am 06.02.25 um 14:35 schrieb Philipp Stanner:
> On Wed, 2025-02-05 at 15:33 +0000, Tvrtko Ursulin wrote:
>> The helper copies code from the existing
>> amdgpu_job_stop_all_jobs_on_sched
>> with the purpose of reducing the amount of driver code which directly
>> touch scheduler internals.
>>
>> If or when amdgpu manages to change the approach for handling the
>> permanently wedged state this helper can be removed.
> Have you checked how many other drivers might need such a helper?
>
> I have a bit mixed feelings about this, because, AFAICT, in the past
> helpers have been added for just 1 driver, such as
> drm_sched_wqueue_ready(), and then they have stayed for almost a
> decade.
>
> AFAIU this is just code move, and only really "decouples" amdgpu in the
> sense of having an official scheduler function that does what amdgpu
> used to do.
>
> So my tendency here would be to continue "allowing" amdgpu to touch the
> scheduler internals until amdgpu fixes this "permanently wedged
> state". And if that's too difficult, couldn't the helper reside in a
> amdgpu/sched_helpers.c or similar?
>
> I think that's better than adding 1 helper for just 1 driver and then
> supposedly removing it again in the future.

Yeah, agree to that general approach.

What amdgpu does here is kind of nasty and looks unnecessary, but 
changing it means we need time from Hawkings and his people involved on 
RAS for amdgpu.

When we move the code to the scheduler we make it official scheduler 
interface to others to replicate and that is exactly what we should try 
to avoid.

So my suggestion is to add a /* TODO: This is nasty and should be 
avoided */ to the amdgpu code instead.

Regards,
Christian.

>
> P.
>
>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Danilo Krummrich <dakr@kernel.org>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Philipp Stanner <phasta@kernel.org>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 44
>> ++++++++++++++++++++++++++
>>   include/drm/gpu_scheduler.h            |  1 +
>>   2 files changed, 45 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index a48be16ab84f..0363655db22d 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -703,6 +703,50 @@ void drm_sched_start(struct drm_gpu_scheduler
>> *sched, int errno)
>>   }
>>   EXPORT_SYMBOL(drm_sched_start);
>>   
>> +/**
>> + * drm_sched_cancel_all_jobs - Cancel all queued and scheduled jobs
>> + *
>> + * @sched: scheduler instance
>> + * @errno: error value to set on signaled fences
>> + *
>> + * Signal all queued and scheduled jobs and set them to error state.
>> + *
>> + * Scheduler must be stopped before calling this.
>> + */
>> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int
>> errno)
>> +{
>> +	struct drm_sched_entity *entity;
>> +	struct drm_sched_fence *s_fence;
>> +	struct drm_sched_job *job;
>> +	enum drm_sched_priority p;
>> +
>> +	drm_WARN_ON_ONCE(sched, !sched->pause_submit);
>> +
>> +	/* Signal all jobs not yet scheduled */
>> +	for (p = DRM_SCHED_PRIORITY_KERNEL; p < sched->num_rqs; p++)
>> {
>> +		struct drm_sched_rq *rq = sched->sched_rq[p];
>> +
>> +		spin_lock(&rq->lock);
>> +		list_for_each_entry(entity, &rq->entities, list) {
>> +			while ((job =
>> to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
>> +				s_fence = job->s_fence;
>> +				dma_fence_signal(&s_fence-
>>> scheduled);
>> +				dma_fence_set_error(&s_fence-
>>> finished, errno);
>> +				dma_fence_signal(&s_fence-
>>> finished);
>> +			}
>> +		}
>> +		spin_unlock(&rq->lock);
>> +	}
>> +
>> +	/* Signal all jobs already scheduled to HW */
>> +	list_for_each_entry(job, &sched->pending_list, list) {
>> +		s_fence = job->s_fence;
>> +		dma_fence_set_error(&s_fence->finished, errno);
>> +		dma_fence_signal(&s_fence->finished);
>> +	}
>> +}
>> +EXPORT_SYMBOL(drm_sched_cancel_all_jobs);
>> +
>>   /**
>>    * drm_sched_resubmit_jobs - Deprecated, don't use in new code!
>>    *
>> diff --git a/include/drm/gpu_scheduler.h
>> b/include/drm/gpu_scheduler.h
>> index a0ff08123f07..298513f8c327 100644
>> --- a/include/drm/gpu_scheduler.h
>> +++ b/include/drm/gpu_scheduler.h
>> @@ -579,6 +579,7 @@ void drm_sched_wqueue_stop(struct
>> drm_gpu_scheduler *sched);
>>   void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched);
>>   void drm_sched_stop(struct drm_gpu_scheduler *sched, struct
>> drm_sched_job *bad);
>>   void drm_sched_start(struct drm_gpu_scheduler *sched, int errno);
>> +void drm_sched_cancel_all_jobs(struct drm_gpu_scheduler *sched, int
>> errno);
>>   void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched);
>>   void drm_sched_increase_karma(struct drm_sched_job *bad);
>>   void drm_sched_reset_karma(struct drm_sched_job *bad);

