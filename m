Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F8DC25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 09:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F4710E32C;
	Tue, 14 May 2024 09:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f85mhBac";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A272410E504
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 09:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX54AGgMWeKY47GhNy/U2ojguXAkFaBoFzqlAce6sjefP7RSr5aZ/0tofpKAB3YQMhelUh0FM98BwvKGI8g59Y+LvqUHMWRNOCJ1I8tbBjszYETJ/7bV9P8kry4EuwovuaWpNYk7zWEKVDSosr9W+L4ZiuAAn2DM+TaWhFg9X7gRKRqHTkfNCIoV+/d9UN4/JfwubqwpK3dihFJciOFoetdfpf0Rl2Cu+hkz/sg9c7NwshMtFjtaphapUUqUsRjTkuQf+oKga96RBfUHG5jGrew8u2mOThxkZ/8mpmwLDas5lhYB5To+eUmWepICw1grInpi7U/xPXdsh/giQ4gKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOKEe0+RZiVr2YCxGI19RjKfH4cHuvBGQvVPElsqYSk=;
 b=Hg/VTRtc/Ser9TSfjcCZsFL844oYhgGd37evEc3W6do5ikyfvmkrrExLBwZTdGP4JvVwBP1TTLWidmoC8VXSA1ePi6zjTRR3X4a9EKhELu72O0i1vNsidx0n/La1g66O1AIYcWbB7KK+eNjoMJ5DhM4OKAYg6VoVtfqNyRLlhIEtO+RxRFjmz4dPXmg74qAWcYHd1NDFHQY3YSV3BkhcIEwJ5+4W9eP5pc/PbUlwkvAgXHmYsbE0pYpVD+eZ35Pkqy0Nogn5tiLv1xUqR4hpAmcfpcvfMlrrJ4nz5vNvbNrstyTf2UFXWBRdhyeaOto/6CQZzA1Zj9nPJHIQdw/++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOKEe0+RZiVr2YCxGI19RjKfH4cHuvBGQvVPElsqYSk=;
 b=f85mhBacFq6HqBcxzudNfMrrxrMzJ6olffyEY3bd8Lbt4XFk86htR7zz2wWbB5Hnebo5yJqbKSoU50nThGlwLAINxvOXK37Glu0B3tSLSBsK67wYemM5zYWoX479F0OkMrOkhjwsuHoVcqQFyG2Vwj5Tc89P2Kx53Mnfi5dt4uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8995.namprd12.prod.outlook.com (2603:10b6:610:17e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 09:04:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 09:04:19 +0000
Message-ID: <d7ac2ca8-8f1f-43d3-86a2-881469cceaa1@amd.com>
Date: Tue, 14 May 2024 11:04:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Use the slab allocator to reduce job
 allocation fragmentation
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240510081145.4081645-1-Prike.Liang@amd.com>
 <fe0c458c-7c1e-481a-acda-6a58dc49319b@amd.com>
 <DS7PR12MB60058CA25A0C67B2AC809C33FBE32@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB60058CA25A0C67B2AC809C33FBE32@DS7PR12MB6005.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0168.eurprd09.prod.outlook.com
 (2603:10a6:800:120::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eebda68-315e-4fbd-b6ce-08dc73f4d6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0VLbUxvUkNTdWNEY0N0Z2o5ZU1TeUJzK3BCT1lrMzBieGZJOXhUbTh4T0RC?=
 =?utf-8?B?blNOdFhrdjVHbS9kTmRGSmlWeVgySFdJQ1ZjRWltbHZSWXpaK1BWakpRbDRS?=
 =?utf-8?B?Y2lVYVlqejdEaHZtT2s1aFJCL2JwMmM2N25qWVhiTzlxRVdXbm9TMHBTNDV0?=
 =?utf-8?B?RCtzNGNyRjhCcUxNNmJoS2pHNXNDSlo3TERrK1FMcmg5eUY3OU9IL2wycGxJ?=
 =?utf-8?B?VEJkbU1uSXBLSUJHVnY0YlQ4MkFNS3JkMmxBUCs1RVgzT2tGd2VQVEJjQXd3?=
 =?utf-8?B?eVhwSk9GUkFVb28wTVBKVmNLcU1PQm1VUllaZFRWWGFoTk1NMlVQZ1NzWlZU?=
 =?utf-8?B?TmIvMk9mMFZZRi9Cek5jbjFlZW9pdzcvWGpjSzVFWUNWU1B3YjlCaWNEQjlI?=
 =?utf-8?B?UWd1RG1NcEFTWE5iOHVSZ0YzbkpqVCtpbXAzK3lYRklqWVd3bHNFdFBZcit4?=
 =?utf-8?B?NTNnZlF2aG1qMFM4OW52ZE5YZEdrUVgyZEVsNjNSZURmQVdDVEV5em5POE85?=
 =?utf-8?B?VnRJb2tCdWV5dmZlTnRoM210a1NLVy91cXIzMTRFVDRFMlBQdHZZb29PYlVp?=
 =?utf-8?B?Z0xmU3hrSE04MHFaeFhwRmY2STlKbm4ydmdXNEI0MDNGRjc4cm9PZDNCMndO?=
 =?utf-8?B?dzdYN3kzL0EwcFhTbjJoZGh6VXpkeHpiTm1idEo2bktxS2ZOejZFUGJoQ3RC?=
 =?utf-8?B?RlJqVTFlOW5kbXV6NjhrVEZ5ZFI3Q0VWOXpSa1BwZjB6SVZxNVkwMHk1dlVy?=
 =?utf-8?B?TDBmaXE5OVhrUSs0Q2kreWNLN1lzZjdTZkpwSHY2MHM4Y0lRWlhmcWlKU28x?=
 =?utf-8?B?NkRzMDNtSHpuLzdFWnZpUmRta2IvQUc0Q0ptL0wrK2o5bnY0eVVsS0VIK0px?=
 =?utf-8?B?MW9SRGprR2ZPS3V1NlNKMXlBL0oxWFhnU2k2NTRlbVRsUTZabzYrdlVNLzFw?=
 =?utf-8?B?NFdacDZFZ1dUOVpnekdDZXRNc2x1MU5EQ0xDbHIvcWxmWjQ3VzB2SzZLdXdq?=
 =?utf-8?B?dHFZRzJuditXMDJZZEhPWmJJejR6WVBVSkdlYlM0cDlXS1FFOG1XNDBUeFhm?=
 =?utf-8?B?SHhaSUkzN3lvY2RZeUU4YmU1d3ZOZURQcyt2WTlUUXVlWk8yQ1JvNVJPUDJQ?=
 =?utf-8?B?N0Z2V2JkZGUzK0IzckdNb0tlM2tzdmE1RUhQTVhsQWZSYU54Q04wYk11UHJl?=
 =?utf-8?B?dXVVdnJYY1VXY3NpemxvRWN4WkFaMjdObnNNK1FMTjkyMU5xTkt3WEc0eEJZ?=
 =?utf-8?B?MmJ5Q09pSGpuSDBOaFI3RWg0WlVkbzdTai9pdC9aYU8wT051N1RhRTZBcndO?=
 =?utf-8?B?UUxrckVIRkVJeFZvbEZET3ZnQUtkWVpPR2syS0tVeEhzUkdCR3FLTkxWcGpD?=
 =?utf-8?B?SGpuZWF0YW9hRnlMTUl3NllydmFUTUVDdVV0bnBXcmx4U3hHcnJpZFIyaEFT?=
 =?utf-8?B?TkVoTXltNkgwRnQwcVY1MEhxR3gvdEo4cnV4UGEzZkpyNTZha1BKYkNlbzBr?=
 =?utf-8?B?KzVXbXgyaHlEOENzdEpjRjA5c2FBOFREQjdwWGZHQkJiakc3SkFsOFR1QnB1?=
 =?utf-8?B?Y1BEajhGWkJ2aXF2cWFhSjJScjl1NVluT2tJVzEyaWZNeW56RUF2SEJ2SU5D?=
 =?utf-8?B?Sjh2M3NvL3lBZzZXdzFsdWhRUS9QMys3am5zVGR6UUFrdUM2ak9BMHQxUitx?=
 =?utf-8?B?RzV2QmtxTEV4NmFTL2FSNDVTRS92dVFtZkRPUXZDcWxFdTdxL0ZXMzRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3RHZkthdE1RajRPQnlBZDlBS1JYYUJLY1BsclFLMmx4WWllNlVONUNvQWEx?=
 =?utf-8?B?UU91NWtjdFloclhBbTVhellRaFlaTjFDUEJkaWpFbWJmMzd1THJjQXZmODZ2?=
 =?utf-8?B?RzlSUlp2WTYxWWNCWkE3REx4VkRhZE0rNFhIUXBycHpBaVJoTkttQ2FURyts?=
 =?utf-8?B?MnlQMnJkWFR4WnY0QTZxL1RTQk9idGJNTHJLUXliaWlPL1YrOWxDQWhDOUVl?=
 =?utf-8?B?bU11MDRxSWtpK3JQQnRMSzVCUTBvdEgrVGIxekM4MlNTbEtwVHJUTCtFY2R6?=
 =?utf-8?B?Z2VQWWZNVmJ3UWlDQzZ1TUF0NngxeWcvaHEycDFlTllkZ0RjZFRsY0YzS2o3?=
 =?utf-8?B?bVJRbi94aW9YTDllUm5UODVGb0l6R1J6U1hqVExNeEpCdU13d05nbi9qSEho?=
 =?utf-8?B?WXNoeWpTN3hhL3ZZSWFyMnFGSkwxRTRFK0g2bnplVjdseHo3eWRWSnU5ZVEy?=
 =?utf-8?B?VHMxTlJSYU5pQnhEbUUyN3BZeWhFQjFjVW41SFF4YzRmNmFxVEttemNIeVIv?=
 =?utf-8?B?bks3UTcxRkM4RkFIcFBPQXdtOWU1S3BkUThZOVJaZDNaWGpRV1pDZHk5SWlE?=
 =?utf-8?B?TDBaUEpmRGtIUzZVQTMwM0FjKzM5UW5tcHJHNnJ1RnhMRUY1eE9KT0RJbWJr?=
 =?utf-8?B?TkovcjZtWkJWbHlmVHdsb3BFaitzNlBGOWY1a2RsRlA2K3FOMVBqN2JoMlZq?=
 =?utf-8?B?SWZyR3BNcHFaYXh6NUE0VEpjK2dibVRPQ3VnUFdYYWFkZUkvL1dhTU4wVmRV?=
 =?utf-8?B?cExiOHRBMmFYblNKS1hiQkZFWlNPSG9NZG0yOWl0azZ5eXdhZkVDWW4wNXl5?=
 =?utf-8?B?Sy9kL2ljWDc4OCtDSjRSWEZMczYwQXBUd0tiUWtDUWZTRGtRU0Vkb1JuNVVo?=
 =?utf-8?B?QXptT2tLSW9LWlMxWUNWdnJpT1ZHaHVSc2M4RVRadzl5dGF4Z2pDOTlaSDBr?=
 =?utf-8?B?N3dTVlRYSzMxZ1oxK2xxWVNtK29HNnF4anJYT0hoVjg3eWhBWlZwNnI3RDAw?=
 =?utf-8?B?dWVWYXpUVnAwR1FnU240aHhSTXFqTVA0UkN3NWd2d0hVYlp5WXlKNUJDSjR3?=
 =?utf-8?B?Um5JZWFJeU5CQ3M3Nmlsd3pWa1o0M0NINXVYZUhHRTJxM3k3S1Y2SlQxMVB3?=
 =?utf-8?B?R2s4bVc2bHF2SnQyOGRLdEV3Rlh1Qkxqdit5NW9lYTBlVWdmQnFTZ2JqQUc0?=
 =?utf-8?B?L0E3b21WcUJpZTBLVGEwMkRzQ0Q1MEFFVDhEQ2FEWmk3UWR0UC9NLzBXSXUx?=
 =?utf-8?B?OVljYlpsWkxrWVZkSU5TZjZJWlhrTVUvME1GM1l2MXI2eWIxM1dTbXdpdnFh?=
 =?utf-8?B?ODVkQkNLUEhYWnNxdUl4aXNvNHVOcWFrUEZpcWc4YUtVUjlmdS9zYlRTUTk0?=
 =?utf-8?B?R01jWjBKR05KMUsveHdUTjBzK0J2aUVCZ0Q3U0pnZmU4V2tXWFpQMlVGcTlS?=
 =?utf-8?B?Z01pellON1pDL21tYnhHeFVKakdvK3FTQVlFVnRZMmo4TGgwdnNOeE9hR3BG?=
 =?utf-8?B?RDRZSDY0Y20wRmNTcWJKNjNMUDRRQ3dBU0tJM3FONXZmZkJGaVBBaWxOeVNJ?=
 =?utf-8?B?UzRZM25yaXYvaDFPMndCOG10dnlrL0F2Y0RWeURRYlBQRG92ajhwelZDT1lI?=
 =?utf-8?B?TlRTVU5wK1B5TThsZlMyVUs2OEZscUxDQlFWWFF2T1JpbTBrWHY0T2J3WmJP?=
 =?utf-8?B?VE10QURzSlZodDNjSitmOU15WWd6NURnZmpnWjEwNVJuZ1kyd0p5R0ltY0Fp?=
 =?utf-8?B?SkF4OXgvUFdBTEgyNWZLNC9HRVl4a1RaOWZYemozbVhXQkJWVE9NZDhjbTZL?=
 =?utf-8?B?NzZCYWVPbnFUU3lXNUV6WFhmU3l4djI3dlZrbEhCRzk1NzJsdlRWZ0QzTmJ2?=
 =?utf-8?B?UXFFZWE4TWJwamhEQUdDRG55MXl4VzlYc0ZZTllnYUEvWlZpK1BNQkxaTnJj?=
 =?utf-8?B?b1VWTVZHNFh1UVYwQTdXUGZlSVlNcW12VjcrcmpoUEpsY01XQ2xDaTZMeUlI?=
 =?utf-8?B?Z1RLcklsSkhHcUJTb1g1UWN3MEowSzloVU96SXJSaXVFbjFDeGJLWkgvcjdk?=
 =?utf-8?B?Z1dUU2FaL1ZVUWJmZEgvREs1ZDZ3SXVFb0JJU0k2ZGs4elpJWmo4RlEwL3J5?=
 =?utf-8?Q?vq0g3JNbkDA0brJveJgobpDcE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eebda68-315e-4fbd-b6ce-08dc73f4d6e8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 09:04:19.7091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNwOG1qWnJm7wwcaHRWdkUl82w455FbM9oAfCEUCZggz75V+3xWsmDf1nV0NQFt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8995
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

Am 14.05.24 um 10:13 schrieb Liang, Prike:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, May 10, 2024 5:31 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: Use the slab allocator to reduce job
>> allocation fragmentation
>>
>> Am 10.05.24 um 10:11 schrieb Prike Liang:
>>> Using kzalloc() results in about 50% memory fragmentation, therefore
>>> use the slab allocator to reproduce memory fragmentation.
>>>
>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26
>> ++++++++++++++++++++-----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>>>    3 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index ea14f1c8f430..3de1b42291b6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -3040,6 +3040,7 @@ static void __exit amdgpu_exit(void)
>>>      amdgpu_fence_slab_fini();
>>>      mmu_notifier_synchronize();
>>>      amdgpu_xcp_drv_release();
>>> +   amdgpue_job_slab_fini();
>>>    }
>>>
>>>    module_init(amdgpu_init);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index e4742b65032d..8327bf017a0e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -31,6 +31,8 @@
>>>    #include "amdgpu_trace.h"
>>>    #include "amdgpu_reset.h"
>>>
>>> +static struct kmem_cache *amdgpu_job_slab;
>>> +
>>>    static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
>> drm_sched_job *s_job)
>>>    {
>>>      struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched); @@ -
>> 101,10
>>> +103,19 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, struct
>> amdgpu_vm *vm,
>>>      if (num_ibs == 0)
>>>              return -EINVAL;
>>>
>>> -   *job = kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
>>> -   if (!*job)
>>> +   amdgpu_job_slab = kmem_cache_create("amdgpu_job",
>>> +                           struct_size(*job, ibs, num_ibs), 0,
>>> +                           SLAB_HWCACHE_ALIGN, NULL);
>> Well you are declaring a global slab cache for a dynamic job size, then try to
>> set it up in the job allocation function which can be called concurrently with
>> different number of IBs.
>>
>> To sum it up  this is completely racy and will go boom immediately in testing.
>> As far as I can see this suggestion is just utterly nonsense.
>>
>> Regards,
>> Christian.
>>
> Hi, Christian
>
> The num_ibs is calculated as 1 in amdgpu_cs_p1_ib() and from amdgpu_cs_pass1(), the num_ibs will be set to 1 as an input parameter at amdgpu_job_alloc(). Moreover, the num_ibs is only set from amdgpu_cs_p1_ib() and shouldn't have a chance to be overwritten from the user space driver side. Also, I checked a few GL and Vulkan applications and didn't find multiple IBs within one amdgpu job submission.

Well this is just bluntly incorrect. I have no idea were you looked to 
come to this conclusion.

Basically UMDs are allowed to submit multiple IBs with each job, so 
assuming that it's always 1 just because we use 1 as a simple case 
doesn't change that in any way.

See function amdgpu_ring_max_ibs() for the in kernel limit on how many 
IBs can be used for each ring type:

/**
  * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.
  *
  * @type: ring type for which to return the limit.
  */
unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
{
         switch (type) {
         case AMDGPU_RING_TYPE_GFX:
                 /* Need to keep at least 192 on GFX7+ for old radv. */
                 return 192;
         case AMDGPU_RING_TYPE_COMPUTE:
                 return 125;
         case AMDGPU_RING_TYPE_VCN_JPEG:
                 return 16;
         default:
                 return 49;
         }
}

> If there are still concerns about the IB array size on the amdgpu_job object allocated, we can remove the IBs member and decompose the IB with the job object. Then, we can export and access the IBs as a parameter from a new interface like amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p, struct amdgpu_job *job, struct amdgpu_ib *ib).

And how should that help? Then we have to allocate the IBs separately 
which adds even more overhead.

> Regarding this patch, using kmem_cache_zalloc() instead of kzalloc() can save about 448 bytes of memory space for each amdgpu_job object allocated. Meanwhile, the job object allocation takes almost the same time, so it should have no side effect on the performance. If the idea is sensible, I will rework the patch by creating the job slab during the driver probe period.

Well that initializing global variables from a function which can be 
called from multiple threads at the same time without a lock is 
completely racy should be obvious and not something I explicitly need to 
point out.

Then this patch doesn't even bother to check if the slab was already 
allocated before, but instead just calls kmem_cache_create() multiple 
times. This only works because kmem_cache objects internally optimizes 
duplicates with the same parameters away. But since you completely 
messed up the reference count this will leak the slab object after 
driver unload.

Finally using kzalloc() instead of a slab is completely intentionally 
since the allocated object is dynamic in size. This will waste a bit of 
memory for allocations where the structure size doesn't end up as power 
of two, but that is obvious.

I'm sorry to say that but this patch looks like you doesn't even 
understand the basics of what the driver and the code you try to modify 
is doing. So I have to completely reject the whole idea.

Regards,
Christian.

>
> Thanks,
> Prike
>>> +   if (!amdgpu_job_slab) {
>>> +           DRM_ERROR("create amdgpu_job cache failed\n");
>>>              return -ENOMEM;
>>> +   }
>>>
>>> +   *job = kmem_cache_zalloc(amdgpu_job_slab, GFP_KERNEL);
>>> +   if (!*job) {
>>> +           kmem_cache_destroy(amdgpu_job_slab);
>>> +           return -ENOMEM;
>>> +   }
>>>      /*
>>>       * Initialize the scheduler to at least some ring so that we always
>>>       * have a pointer to adev.
>>> @@ -138,7 +149,7 @@ int amdgpu_job_alloc_with_ib(struct
>> amdgpu_device *adev,
>>>      if (r) {
>>>              if (entity)
>>>                      drm_sched_job_cleanup(&(*job)->base);
>>> -           kfree(*job);
>>> +           kmem_cache_free(amdgpu_job_slab, job);
>>>      }
>>>
>>>      return r;
>>> @@ -179,6 +190,11 @@ void amdgpu_job_free_resources(struct
>> amdgpu_job *job)
>>>              amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>>>    }
>>>
>>> +void amdgpue_job_slab_fini(void)
>>> +{
>>> +   kmem_cache_destroy(amdgpu_job_slab);
>>> +}
>>> +
>>>    static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>    {
>>>      struct amdgpu_job *job = to_amdgpu_job(s_job); @@ -189,7 +205,7
>> @@
>>> static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>
>>>      /* only put the hw fence if has embedded fence */
>>>      if (!job->hw_fence.ops)
>>> -           kfree(job);
>>> +           kmem_cache_free(amdgpu_job_slab, job);
>>>      else
>>>              dma_fence_put(&job->hw_fence);
>>>    }
>>> @@ -221,7 +237,7 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>              dma_fence_put(job->gang_submit);
>>>
>>>      if (!job->hw_fence.ops)
>>> -           kfree(job);
>>> +           kmem_cache_free(amdgpu_job_slab, job);
>>>      else
>>>              dma_fence_put(&job->hw_fence);
>>>    }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index a963a25ddd62..4491d5f9c74d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -103,5 +103,6 @@ int amdgpu_job_submit_direct(struct amdgpu_job
>> *job, struct amdgpu_ring *ring,
>>>                           struct dma_fence **fence);
>>>
>>>    void amdgpu_job_stop_all_jobs_on_sched(struct drm_gpu_scheduler
>>> *sched);
>>> +void amdgpue_job_slab_fini(void);
>>>
>>>    #endif

