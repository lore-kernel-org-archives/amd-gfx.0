Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF69C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 09:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED3210E160;
	Wed, 15 Jul 2026 09:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="azfjZGsg";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F5710E160
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 09:50:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBr74Gn8dhITDnC1j5bEAbt3vbuoL8La1PgsYUCJ7EX9AU6/+VeK5gOw/7lu0BslDZOXyzeEUQm/ay58su6fMCGS3yAFyHUaUsUKcY20qGaKhZxaTEPSVy0yFHH51Al+K9hPic8NH3gzOoZNFI+O8qJ3TX+oaYzsA7oMB+I6bhScnG2G2InyBMQAfcwXI6eYm+O1wk1sn2K2gDFWlhfatcrb70igGkBI8MR0VDo7ydzIr8ZW6lE7Pi+UwwwKELPMX1/veMZraVAh0pgoOF4FVba0ZeI3Y4tIpC+jx1PRlhW+ObZW32UbyrGhjcV5Z81yVVgajUlmBxrG2Wb8q2LYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE3tFb6yw1HrVr5aE25z5Bwe9aw9yQx69d0zzmTs8hA=;
 b=VUsZf1WelXuCYzlG3Cjlh1XM1YoiQXxkCPpZfYOdb/O1Nohwa61hideKnwC4EYhwYJU9OIMRis8AENHAIAXMcjNYcYt/V+622wbrTe4YrzCQwA+gZrqTxqgKu3BBORi5icky5hjF4Ly+O1a8Lnx2e7otGrThcxeFzlOlD0Tic0y+HZDW8nHljXDDmdsa8G9qvsW3Urhy765aIGDwUaE9fQS0L73bcTnoy0vuG2UhHbnlR5Berlij2LfmIw/GkyiUY3NHwzIfQxUh/v65U0Ue5dwGswqX757sNqXRrJI4xm2SWm/p3/DNLBI8ByEaREMGZt36f8re72s8tsTXnPVJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE3tFb6yw1HrVr5aE25z5Bwe9aw9yQx69d0zzmTs8hA=;
 b=azfjZGsgtpKrTFfCanuWFvfwKzpdQDSxzybqsT7fi4LgR8bqrt683lDeWpTutdXtGdT4lBpjxrzw7xqK3a+E1UpFqgpfqiwqtOHneZFtBs4ys3RJ1QR2sskK15CXET95zUPnaqp5TihmUOAa2OIxfCZLQt4ivhJjDzVN7DXLQrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 09:50:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:50:35 +0000
Message-ID: <dddb24b1-2ee5-4dc7-ac40-b66f08fec51c@amd.com>
Date: Wed, 15 Jul 2026 11:50:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] drm/amdgpu/gfx7: Return error code when compute ring
 tests fail
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <2c920253-9bbc-4057-b5e0-15414220a52b@ursulin.net>
 <CADnq5_M9hwLQw8YMqEebQ7q_kYLx2KKetZJFrszGOiOSYio_dQ@mail.gmail.com>
 <7296879.9J7NaK4W3v@timur-max>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7296879.9J7NaK4W3v@timur-max>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee21bf2-f129-41ef-f827-08dee256849b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 40uptUcD99sLEakT2Ra2gQcJAM+9hHFECkCIG+b2obLQYDO+W42Pr+HXDzSjWkA8n7kwwZzykEz82B2vOKIPV86IKUPcTcNqIXFVI03jsgoWqLPpBmhBoQ8rTgPafEIv9buklPFpkyjqPk6FI/g3hHPpxgkMLbxooZ8v0oeNPR5PR0kHiHNYyyA8s+nG62X44NuCFaPerCT81XUukHxVPuKya8hln8Lto6jL90+Ace0F6kEFhgqXnKgYZHxu5DpRwVW1MN0MGhjiu83KSvfPqFF5Gtm92FOqh9E4fnro0RET8g2y7lrECxoOUp9Cot8WoB04MP0giYJ8kvrgVIxxcPphvwKUL4AHoG0W5d5h0j+/v8pVpWf+DLcRjtcxzUO1jyAp9HCbDTmglQ+hsiiLIKYJUaYSwF5IusAozetEMhdlb9AYYPznnK0F5cJqn40MD03TKvzVZApeyFc59/Gy9QAHe6gKLerxMIl5sWz1deKbScr4LeDY8vv4IKR5uJJs0mT/DxsABj4pfPnGKEoH5WLqAiWe4zTY3WbVRsOStFhpRl/ddzQRZtXOO/JlkqKFcpg9WzWXiTtao3y+q4xcCMVnovkhFELWvq1dMr88ZaR7Jl2jFkS8jHssLNK3kGbkHnBEmc6QCIFuZB1UhfL5QFhLLsly9M5AkelPHeU3aHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTlWQzRaRnNIRDVnbElZazNGcGo1SU5UM0J5aWpvWVdGeHBOQ1BmZ0YveFV6?=
 =?utf-8?B?RVpXR042MHo0MDNZN0pMWjk4bkc1cy9JVzN2NmlNREd5QmhjdVNmUVBjSytY?=
 =?utf-8?B?Q2toQ0FYMWNxS2VrbjgvZGJnaXNESC9aeW1YdTQyN01IRUNkVEtmVmhCRDZG?=
 =?utf-8?B?VFNXOU5mYW0rTjVHMm5OUmRvLzZpNEZJYWJQUUhHM2oxSXllM0VSQjlJT01o?=
 =?utf-8?B?ZkVhaWZ6ZzdFdmRPY2lneUZoK1ExOGE5ell0azVTblZTbTJGRkt5cGxpNW80?=
 =?utf-8?B?MWxKMWxrZjVoU0V0Zm1KVjlZOXVzOWxHZVA5bkxPUjd2aFFjWVNXUTBLOVZo?=
 =?utf-8?B?UldaWmJueTNxbW5NQkJkMkZ2eFRtOC8wazNyeWttc0lzaklaUzFnZWk2c2cv?=
 =?utf-8?B?OG0xMVFJOFBLUERpWTN6QnczWkhSemRZU1lOem5sdmUxdm5HNWZwRWNRbGNs?=
 =?utf-8?B?M2dMWHFIZnZTcEFJbWh5MWhNYy9oMGdHdm9IU2w1QzZhOXJIa2lucDdzT3RQ?=
 =?utf-8?B?SGExTUIwdEUvN0RtaDhyR2RhSjhNU0lsNklrNXFHNGw4dk9DR0R2bERuaGxH?=
 =?utf-8?B?Z2pKU2R4R3BtQXlzRWU4M3hMcUgxcWtYemJNcFhkaFpOc01CU29jeG9BRVZI?=
 =?utf-8?B?SWt4STBMWmg3ZUp5Qm91RlBHcWZlUTFmejN4QWp4VGVRTVdpakdSRlhRbDY1?=
 =?utf-8?B?MWlMUUlkRXM1UXZtMWhrQ0NWUnhJNTJSYWJSRVlwVmVTYnhHSjdLZXFVVmNH?=
 =?utf-8?B?b2hMcUV5bW5wV1d1RE5KOFZFeDV3MFpaK1BIYXpkV0NMMjIzQWx2VlgzbE9n?=
 =?utf-8?B?YjVGZnUrOXVUV0Z6eUJ6TlpKRytNbVkwdE1zQWRxdUtSc0ppeUdnRnNMOFNi?=
 =?utf-8?B?MTYyODBSRXdSUng1aTFGR0tmS214RkR3NDhSVUl0enhqWXNScjZhNE1SQ2Fr?=
 =?utf-8?B?RjhnQUJ2MldwYlVNMzRuM1FzR1A0L251SG5raXlLVzZvbW9JVkZXV2dKMHlN?=
 =?utf-8?B?QkpERldya2FuMG0vU0RmYlkxMWxvZ3duMy9KSENhVjUwYVhiSFZ3ZWhCamps?=
 =?utf-8?B?NElUdTA3SlRYY3UzQ2FLa1Fic3JDT1JwTDgySU0yZC9aV0FkdGdzdUtPM2ov?=
 =?utf-8?B?M3B0Rms1SWtVRjZoWDc3YTdjTEs1aERNb2J6d0dQOVZDaDQ3WUtjZnpPY2k5?=
 =?utf-8?B?OHlFWU9lLzk3L1ZpZjE1WStyeEhjRFJJeDZiOEI0SVZiVXFRdEo3ZDlOZS96?=
 =?utf-8?B?RWtjZEUxOUMwSmI5NGhKT0M3Y2RRVk1EeFBvOFd4V2d3bTJ5b1hpNHhCQ2hy?=
 =?utf-8?B?T1JoWXNmOHUyZHNXb1pJOGI3bnltWE9obU9LSWZiV3FSc0NpNHhYRmZGM1NH?=
 =?utf-8?B?T3dsNXBnalV5YWRSOXpBM3diaUtUOS8zYUhLYVFYbjN4UE15TGJwMGxXRmxm?=
 =?utf-8?B?M0xBa2NVY0Z5aVBaM1d5RjI5ejJOMHAzdjF0NTV6ZTlFeTByNEs2YXIwQ3ds?=
 =?utf-8?B?R0k3TVVhRnUzN2lZRkhGZXQ1S3ZjaFlQWmNFUEJBVWEzeGk4WlBHZlUxOW8r?=
 =?utf-8?B?enJDNHUwYk1DYjBLZzh2ZFBseXFNbFZ0djVjK2VoZU1xUUtOb3BmY2kxcXQ2?=
 =?utf-8?B?bU1palVYNkNVOVlxWWYrditYY1BxUlpGRGIyelhSR0JCeXUyOGNibE1KSXpU?=
 =?utf-8?B?dkMzQWdJRDZ1d2ZxOHh0UzNqOFpiNHBONTI3UTM1cnV1RmtpV2g4K1M2cHdq?=
 =?utf-8?B?UnM2cUVhVDNQeHloa0VPVjBQZWh2ejlaYzFNKzI3SGxHd0s5L2xIZ0N0dnk2?=
 =?utf-8?B?NFFrTi9qNTlkaSt4OHVqeW9XVXlNTkYrTFY0R3Rub1RRMXloZGV0OHF1cyt2?=
 =?utf-8?B?K2JXaXk2UnpTK2F1UlJhbXEyZ3dEY1k3ZUtSR3dKazArSnMxM0FHOXRZTE4v?=
 =?utf-8?B?VC9OTk1yZGNiMmZRRG9OVjA4K3pyeVh4cGptcWpKYy9lOXpDaHVJNVg1Si9l?=
 =?utf-8?B?aWdlRmhvQlNuVnFMSmNSekd0S2dwQ3RndXpGRnVQQ3pDUTgzU1ZsbWg4ZER0?=
 =?utf-8?B?VnZaV1J1Ym5lZGlUYVJ4bmRBR1Q4ckxZK3R1RUY1dEdzLytJaGEwMU1CVVZt?=
 =?utf-8?B?a1V4YmVUSTV0UXNHODM5cEg1Ly91QXpXbGpibko5UWV6RWNXa3ZaMzNFbG9S?=
 =?utf-8?B?M0lmRGwxb0J3dThXU1BwZ24vV3JEYWRUOFh2NUNPQVVpZHFJQXRlMmE0aE5y?=
 =?utf-8?B?TEhhZW14a3BWbUFnVm96dURkbyt0b0huZFhXWnRMelFHQ1c3MjJQQlNka2lj?=
 =?utf-8?Q?tyIUATcbVwq20bRw8X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee21bf2-f129-41ef-f827-08dee256849b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:50:35.4382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulemf4hb3acJkuTz+or0B2AmShZ4FoJORAF4P5Bu9xJ8McLZIV3RSopOys+Xe0z8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
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

On 7/15/26 10:02, Timur Kristóf wrote:
> On 2026. július 14., kedd 22:41:33 közép-európai nyári idő Alex Deucher wrote:
>> On Tue, Jul 14, 2026 at 4:14 PM Tvrtko Ursulin <tursulin@ursulin.net> wrote:
>>> On 13/07/2026 13:58, Timur Kristóf wrote:
...
>>>
>>> I actually might like this because maybe it gets us closer to removing
>>> the ring->sched.ready hack but what I am just not sure if the idea was
>>> to allow driver to function with some non-functional rings after resume.
>>> Under the premise that if they initialized during init, then after
>>> resume they must too, or if they don't, it is a transient glitch. I
>>> don't know.. I am being imaginative here thinking about silly driver
>>> workarounds for weird hardware glitches. It is much more likely this was
>>> just an oversight and it is completely fine to to error out.
>>>
>>> I have to defer to Alex and Christian on this one.
>>
>> The reason for not checking the errors was because compute queue
>> failure was not seen as fatal.  There are a lot of compute queues
>> (relative to other engines), so if something happened, it seemed
>> better to just continue in a degraded mode with fewer compute queues
>> than to fail to resume in general.
> 
> We had a conversation about a similar topic (it was about UVD), where Alex 
> said that in general we should prefer not to handle degraded functionality in 
> amdgpu. I think the same principle should apply here.

Yeah, well that's a rather problematic topic.

Ignore such errors leads to never fix them. But on the other hand if we handle that as fatal and UVD doesn't comes up after resume you end up with a black screen while otherwise UVD is just not working.

> 1. My main problem with handling degraded functionality here is that I have 
> never seen any issue where just some compute queues fail to initialize after 
> boot or after suspend/resume. That means we can't meaningfully test that 
> scenario, so we can't trust any code we write to handle that either.

We had a bunch of cases where some engine didn't worked in the past (UVD, VCE, Compute) either on initial load or after suspend/resume.

Especially there was a Compute issues that was really annoying because it only caused trouble after Mesa switched to using compute engines for VA-API. Before that we didn't even know that Compute rings sometimes don't properly come up again after a resume.

> 2. It would be very tedious to keep track of which queues didn't work in the 
> first place vs. which are those that don't work because of a bug in the soft 
> reset code. I consider the soft reset as failed if not all queues work 
> correctly.
> 
> Considering the above, I vote that we should just expect all queues to work 
> correctly at initialization and after a recovery. What do you guys think?

Well it's basically choosing what is the lesser evil.

Regards,
Christian.

> 
> Thanks & best regards,
> Timur
> 
> 
> 
> 
> 

