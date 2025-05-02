Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B99C3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 20:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD9A10E1C7;
	Fri,  2 May 2025 20:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WqqIRpi8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B0C110E1C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 20:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9eeyX1MsJkj6Tz5+2Tg7SKlxrMbHThTC/2vUj7K5YbgmZK/RinA1+AvuO95vOPGyUWD0vEAwh/uQcznN9JJcZckYk40tmiibNI8F6XjHz12PZehe/5QApPUN15zeYNQ2KeUvEUzTBJ5lnJzXItM4c9Lyl1NjRXLK56UHs2Y+p75PM99ERkx+aYOFtRfHkXRmxGAr+aw4VCTO4V0WkrS9DcBli39vvKF7cMUqZd/k/uHpi0v2QZQSgkGf4kxo3sFMPijKSZzJUoj0GlywNwym1vnrDnHoHJq4PtV+ttiGsyRz+e3tnd3pzEJnuYjDLYTFJfbIdV/HvtU6tMsHiwhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEa/Ujb4vaX3fTnoYVkrWHb30AY8xyZWRdbvjD5pVh0=;
 b=NSkxFY/qTTATK/HtLLAkv563+CMJaZPP3zJedf9wuF7eNMMYDHwsuJDgUDtX2S0y5A00kclcFNp+ZpNxpUuvS3Eb/TmY75U6RiJrq2I0Eml4CLhOkKBIRQhOWGJ+QgZ53ci47BwqiIkCguwttZB2VxgJWq6FuD50TEeztFkVnYfYJ2NWvfZugc4z/HHbDsancOtqh4AfK0aMZ2MnuwUjJ5hCl6wGsKLER1MVcx6ektHPckrDUDpKlQWyhpRIyydeiHlLNw4xaEkLWj9bjs6YIzZDiyr3Q1Q42EEpfmrD9frEdgRRRHKen3dovmyjr2ZXAKViSgJylDgNd7csjf1P6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEa/Ujb4vaX3fTnoYVkrWHb30AY8xyZWRdbvjD5pVh0=;
 b=WqqIRpi8E/AWpaN6Z/eKCE0hDYyBvTBQ3kKjGLZBBRY6ECX3EDLD95BLd9yKNkYRVALdvNHv3FpivHHwh5R16LZMCkA4sUL0OkHA3J4adOZxj8unK2I6WHnbreeVfPlnPanA6cEJ1Su8wfX5hK0yRrFQU7dJ2GMqyh5+/CPIA98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 20:37:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 20:37:08 +0000
Message-ID: <f806df53-1d2a-445c-81d4-0331194c4e29@amd.com>
Date: Fri, 2 May 2025 15:37:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
 <b9884f1d-91fd-4b0c-9a81-acc5bd53c891@amd.com>
 <CADnq5_P2GgCTWihgCQp=tKiatRqe-VY5acKgcVRMYiYdvwnVdQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_P2GgCTWihgCQp=tKiatRqe-VY5acKgcVRMYiYdvwnVdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYXPR12MB9320:EE_
X-MS-Office365-Filtering-Correlation-Id: f85c181e-594a-40c2-0e3a-08dd89b91b7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEovbDdpSW1qK202bTJyNkUxd3R2U1QvdjFkZDgwZEFwS2oxYXpSc0dOQ1hC?=
 =?utf-8?B?Wlhkdy9kdjNHR01sNEE1d01YRW1OL25qRWhRei9qbTUzVFB0Q3FQaWZLbk9Q?=
 =?utf-8?B?aGoxaXQzMTloVThvSFZNYXNTYi80TE50dWYwSEs1UnR0N2RNcnpNdHBFZldY?=
 =?utf-8?B?T2o4S1lydlJSYmVGNUYvVkhNYnQyVnJhdTNMYVhrLzZFV0N5NjM2eFE2TUl4?=
 =?utf-8?B?VlNmRFJpZ3hwcDQ0ZW5pS2hSb01Ga3B6d0UvRXl1VldZUHl6SEZ4T3lYVlZT?=
 =?utf-8?B?UWF6RGNXQkFBSzlaMG5CN1Ztek9OdFVvMWVDV0xpdGdvRVNIOEk2ejB0cVJV?=
 =?utf-8?B?eU1iSnpTcWttWlZGcWQwRFpaMGQxbnRlMHMxUzhZcXVrQW0zTHIwekk2TjRT?=
 =?utf-8?B?OWdPYlhnSlZoL3V0SHlxUTZIS0l0ODhXaC9uYktSSHcweE1LUkV3Mm41aHRP?=
 =?utf-8?B?RUJ0dkFZVUpxUWxEb3U3bzhTVHZ5YysvMDZJb1BzVnF5aDBxODh3Z3ZnOWdZ?=
 =?utf-8?B?dExMR0wzSGZndURBZjJRemcvL3VqVWc4ZXVmdDlCL1YzTm9UUlpzQWs3SzJw?=
 =?utf-8?B?L1lERjZScW9rVEZEZXY4d1JGSWlTYnJyaWFzWGhkdXkzVE9scUJlYzFJR2hn?=
 =?utf-8?B?TzZUczJLMnh0OGRxeEVKTFNaUW91UEhpSyt3ZDZ3S0lENTFyeFhSbFhNMWtS?=
 =?utf-8?B?MUd5TnpDdlVNYUdoK2puckl1aUJCSFJudVA5dWtEdHB2MkkrQkFBRU1HaDVw?=
 =?utf-8?B?enJaM3pPY0U5YlNKbXB3eXVuWFNOUlRPYitBekVRMiszd0RaVFVqMm5EYTcx?=
 =?utf-8?B?bU9EY1Q0Q2VESEk5MjBwV1M5SjZJRWo1UU1sM1FYdDZhem16Q0YxaWtvaXVD?=
 =?utf-8?B?dkhkRHZlVDM0VVU3eC80ajVjNHo0WDFkTDRVRmdHeENtNGtZUjNKcUUvTnlF?=
 =?utf-8?B?TG9GWEk0RUQ4RldiVGY3UzhZKytJdzlPbHdSWG13QjNuY0p1bHBBNm8yYUlW?=
 =?utf-8?B?T3BDenMrQjRuVXZUTGFhejNoYWtycWh2U3VrbGZxZkhJUjZTdDZSL2x6NEFq?=
 =?utf-8?B?aGo2d2tSclBtcms4Mk5obXNOVXBKaVlYSlZGSXR2bldQaENNNGoySkVqMGlw?=
 =?utf-8?B?dGJUbWNLaW1vQkU1cXhtSTB5aXZaUlRtRkdYcDM2WklTRU9mTDc3QUl5Q2pi?=
 =?utf-8?B?clZJRTNQQ3lIdjVJTmZtK2Fmd1M1NTJqb0xrQkNFczhVZmc1QWM5VFJkVGhp?=
 =?utf-8?B?cXd2SHVaNFkxdXcvWW43Y3hCeTRQU0ZhbDRRd0RaZDBITEhKYkRwSWg4Rmdn?=
 =?utf-8?B?Qm5pTnRaZm1ScUhpZXU0YnE4d3Ryc2h5Mkp6bnN1a0Jzc0NVdjJNSGQ1dEpi?=
 =?utf-8?B?enVVa29TZktiZkJoeXZCWGhyeG9tdmZlUkd6RHBrTWVXWTV0Um4rS3Y3bHlq?=
 =?utf-8?B?VDZZdzVIdk9ydG41TzcyUS95dmw0MUV5M2dtbjdGaEEvdDF3K0kzY25raGo2?=
 =?utf-8?B?SWlVZGNNa2s2ckw3TU9zVDFpWGJ1eWlLTE42aEpYcDZLR0x3b1RlT0hxUW85?=
 =?utf-8?B?bWRXSUR3bHBWem1mQW5Ram42OCtLY25vREFVV3lMRHA3a21VT0JUekh3b0RR?=
 =?utf-8?B?ZkYvMXJjQ1FjUG1wNEtiWUovU3hBVWk4RDhNbnZWVnZGWjhOaTVXdUhFM1Bw?=
 =?utf-8?B?c0VITEZSdUVFNnlNYVZXYTRVaTd5YXNva2dKVHMwMlFYaWU3VXZ4cXhJQ0o0?=
 =?utf-8?B?YU0wTDhQQlY0cU1QVy9TeFgwczlXV2EydmQ3dFpyaDVMc2NmQ2kwSDIwKzA1?=
 =?utf-8?Q?0OqwB7uMU5TEzKQc+nmdIR0eP80qC+f8YluLI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjc0dyt1bDVOd3ZVMktwWkRmZTZxNmtTQlRXRUxNV3hWeTFwTTRhUkgvUHZD?=
 =?utf-8?B?MlpXMVg3Y2FrNTJOQVE3S3pnK0pyZERhd2RTTFp1UXpOMm44OTd1Rnpna1pl?=
 =?utf-8?B?VWdIZkZrdkVZb053cUg1ZnJhOWdQNmt5RWpiSUhmSW1oZGNJWmxKYmdFRUFy?=
 =?utf-8?B?dGxQc1hhcmU5aVk3SXJrWkVoWlpXSFBRR010bG9YVHkxSUY4ell4WWRSTWZi?=
 =?utf-8?B?VkVhc0NkeEdHVVVSRWwxaCtUdm1OWUorTUEvT3pTMjNUcUdBRmQ5cDF5emJF?=
 =?utf-8?B?U2xJUy8wMUo4RzM2Vlo1bXE1aXNpUUhjUFJXM0lMUHNSc0drMXh0VlRoZFdJ?=
 =?utf-8?B?azFwRzR0OWRBV2NPVGNlY2hidUxBcDNSMmdKbm5xMTd6M3o1eGNmM1lPWGdm?=
 =?utf-8?B?MDNPTjU0OHhFaW5TOVhZMG03OEhSN251Wmd0ZmFOaXZBMzRyMVhvYzlweGRk?=
 =?utf-8?B?L0lrNWFpbG1IN1h0cXVLcVlCdDl6akxEeUYxQlJRWnBnUzFkQzU3THdITlRt?=
 =?utf-8?B?QStXamZXQVdReG4wK2xicHhxZ3hBL2dmWWt6TTNUVXpUUkl5V1NKRStUVHBu?=
 =?utf-8?B?S25qbGN4OFpHZldmSTRzT1ZPNUJUS0NjTzVDWElVeU1EQ2JxbWExdWpuc1Ix?=
 =?utf-8?B?dVlDQXIrRVBPeEVuRVZpYW1LWDFjcVI0bHNQbFg4TjdWeURhSFRzQUt3Mjd6?=
 =?utf-8?B?M0hRV0RNUG44NGtScDZCK2dMa1haRkFGcm1hbmpzTE1pMGJoMk5WOFg0MmFy?=
 =?utf-8?B?dmg1VHlRcUJ2ZlBvLzc4VzVyVFZrb0hQQlUxSXJDamMxOXdUdmFpb3JaMExp?=
 =?utf-8?B?VDJDNG5QZlBhb3JYZHdoUkhCemxaSXdTR2lrRTVDMTZ6Mm02b1NEUDJXTDNE?=
 =?utf-8?B?UVViTHVmbkRnV0tMTXdVSHdpdExZMFpsMXhTWWdIMnE4ejVZUEZkVndleVlY?=
 =?utf-8?B?Skt2dks2OC82UG1ZeDJUK2tiVldyM1JyVVVsZ2xEd2tJWG0rUGFjdTkvUFVX?=
 =?utf-8?B?bHkwb1RGUDNQSTJRUzFJSDBhOUs3UXV3VVZmOUU4cDNtM2lqK0kwR1puNUNk?=
 =?utf-8?B?UVU4QzlGYUtjQklpd1EyMlRKbDE0Nm4vVkVWblFZYjR2b2c5Um5PMHdac08w?=
 =?utf-8?B?NGxnYlJSdk1SbmJ2eHdLMjUrdEVMMldlb00zS1lDOUF2czBUcjBGL0R0NDAw?=
 =?utf-8?B?QmVHdkczOVlRaVFrVThibElwRjVURmYxNVdobkdiM0lZSlpja29jZndZeTFL?=
 =?utf-8?B?S0tnWmttQ09KbmUzdVFoMHpoTVlxMUZrbjZPTWtPM1c2V1lQMGVGOVdHOXJu?=
 =?utf-8?B?TXdsOVFzOGlvVDdjQjBvV2pqTUxldXBWOFpFeFJaWGlHY1Q1UUYzOGNRL3FB?=
 =?utf-8?B?Z3FBK3FIdE53WldoSVVlN29BaUZGYUpLQmlOUUFvV3NDK21HaDMwSi8wdkpm?=
 =?utf-8?B?c2o3NUZEbHdCSjdMaER5U1M1WEw1d2pwZlpxb1Bib2dzUFdTTnQycmFCOUFN?=
 =?utf-8?B?ZThteTFnTEZsNnFOZndNU0VQM0t5dTFMM1NBSm14S1dTTWJoMHVueEtFejJl?=
 =?utf-8?B?elJZRDJMTE1CYVV2M3JEYSt1RGk4TVl6TWpOQi9TVVNNZllCZWpQd1RVZnhE?=
 =?utf-8?B?dmo1bTAwZnJlTGFyYmh2MUUzWWlmb1dWZXV5MjFNbDZ1K3lwVVRmN0ZpZ3Ju?=
 =?utf-8?B?VitQUTdnT240UjhpNGJsdGRxdzBaQzh5NnZ1WFVyUEhvUlhteitpR1RTaDJ4?=
 =?utf-8?B?Q1lLSGoxRXVEZGh2elliWHlhcFNQWXh5aUNRNXpVY3BxNHZpanNic2dZa2hD?=
 =?utf-8?B?TUpQUXFyMDFSZjdIaEN5UDVOYWgxU2pFcGpPMjZvNU92bTUvSTd2KzhYMHZo?=
 =?utf-8?B?NlJwVkZFSGhNajVSbjM4SitjNEk4blRFMXJYVUFpYjduVDhkSWw1Q1M2aE5P?=
 =?utf-8?B?aTVvME9uQ2FVeTkyaUFLQk5rb0VhSlB4dmJhTmRPVkxwV212dFRtZHBJSEoy?=
 =?utf-8?B?SThoWlAzdkcxbEh3OW54czhsQ2duWnR3ejZKVWpGSmRqOUZDQnhVbDN6a0xk?=
 =?utf-8?B?YVh3bjhvZGF1Z2Q2a2ZDbkoxbWFzRVdhWkp0czhBZ2ErK3FWUnh0cVdDT2Z2?=
 =?utf-8?Q?OknbIfwgfAYOY74+xGQKnLqzc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85c181e-594a-40c2-0e3a-08dd89b91b7d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 20:37:08.1070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPpwBo/MYZ/goF+MJAQSWDm7+vqRpxNnasMm2LPPiLTZB7zeBVRup6Yozu/u/PCGxMB9YL+W0gS0a0TS2P9Fjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9320
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

On 5/2/2025 3:32 PM, Alex Deucher wrote:
> On Fri, May 2, 2025 at 3:39 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 5/1/2025 3:09 PM, Alex Deucher wrote:
>>> Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
>>> the resource evictions properly in pm prepare based on whether
>>> we are suspending or hibernating.  Drop the eviction as processes
>>> are not frozen at this time, we we can end up getting stuck trying
>>> to evict VRAM while applications continue to submit work which
>>> causes the buffers to get pulled back into VRAM.
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
>>> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++-----------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++-----------------
>>>    2 files changed, 15 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 71d95f16067a4..d232e4a26d7bf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>>     * @data: data
>>>     *
>>>     * This function is called when the system is about to suspend or hibernate.
>>> - * It is used to evict resources from the device before the system goes to
>>> - * sleep while there is still access to swap.
>>> + * It is used to set the appropriate flags so that eviction can be optimized
>>> + * in the pm prepare callback.
>>>     */
>>>    static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>>>                                     void *data)
>>>    {
>>>        struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
>>> -     int r;
>>>
>>>        switch (mode) {
>>>        case PM_HIBERNATION_PREPARE:
>>>                adev->in_s4 = true;
>>> -             fallthrough;
>>> +             break;
>>> +     case PM_POST_HIBERNATION:
>>> +             adev->in_s4 = false;
>>> +             break;
>>>        case PM_SUSPEND_PREPARE:
>>> -             r = amdgpu_device_evict_resources(adev);
>>> -             /*
>>> -              * This is considered non-fatal at this time because
>>> -              * amdgpu_device_prepare() will also fatally evict resources.
>>> -              * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>> -              */
>>> -             if (r)
>>> -                     drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
>>> +             if (amdgpu_acpi_is_s0ix_active(adev))
>>
>> I don't believe this is valid "this early".
>>
>> pm_suspend()
>> ->enter_state()
>> ->->suspend_prepare()
>> ->->-> Call notification chains for PM_SUSPEND_PREPARE
>> ->->suspend_devices_and_enter()
>> ->->-> Set pm_suspend_target_state
> 
> hmmm.  Is there a way to determine whether we are going into hibernate
> vs. suspend in the pm prepare function?  I guess we could set
> adev->in_s4 here and then check if in_s4 is set in pm prepare, and if
> not, then call this logic to set the suspend flags in the prepare
> callback.
> 

Yeah; I think setting is_s4 here makes a lot of sense and then use that 
as a hint later in the sequence.


