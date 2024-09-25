Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F0BC369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 09:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C9B10E2DE;
	Wed, 25 Sep 2024 09:15:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UWMM+f1r";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F3810E094
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 09:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2UOBK6Z0AvVX/GUN7zjyWKHaYnyLHf+OU6cE5PBQDV8lEw3y3CN9RveEh1LFkcezVZY/pkbWMFmyBdsrBESRZLax+yJLqcTx7lfY79146KIPqvJtLHvg2ltnYCVJd9RPDBrCc3a07fOtZosZcjTVX8f0v3bX1MEWMqbZLejfOFr8jmWhL6Vs/3N2fYieuVFQU+XkN0JzocrpfBJYt0+AOgMvLAsBxeMI1rJD19x6Vj8aPNELMtdB65VZW/TkoxdmnLGrhxZY1zgfaB5ANgH6uD5CK6bwafsY/gXLCRD7igt243wNo4kbLM2Osoh1fy4YB0j9okHow3rY4eSFCKinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itzHFnslrXAkPPRzoClMlcmeWpbH7Dl+2LIgnvf1+1w=;
 b=WDJqbsNb1NPz9tpupTzAasOrfUpMl3MDWVwF6k2O4jTNm1OO17v1Jvv6y+kaXAaGFqQ0MOURjfvBBSrM2I+oD125jAX/tzP7glyI5YQ0vuj9IyayuBHlARHGvDwxNuGwAjE+sXvYhc2Q7WVKcWFcG/UWBvmDNcLYMwoJoB4I0Yj2PBXGNqHCTdVThPxIbfFzEulFsuLN56CQLHzztI6QQlwqjJeUsMPKv53qAxAgy3Z//EhObNh7jw1V9Ekm24fn58IiO7T8zvziJ1DQnq0ZyVPCl8rOmLbHjuG4WCcW5gWYHrNxoUh0bwgxaQPBfX0JU6+aA75e8nhLhNjZQYqQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itzHFnslrXAkPPRzoClMlcmeWpbH7Dl+2LIgnvf1+1w=;
 b=UWMM+f1rBEiHNpmTHFr4iJtd0w9psrJCz64sRyEfRk44tPKAAmkjnp0Ez+uCCy2GbN+PnOZ5T3tTUrdspxqykjM8TfuzDmSCkP+idBJm+gNCkbsy7+PbtqsGrxICqx73+t0QqzUMQa0iq4/r3V9xo4AYlaWp0ayX+yrI0Zlbulw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 09:14:59 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.7982.016; Wed, 25 Sep 2024
 09:14:58 +0000
Message-ID: <69c5664e-6b70-4f69-98bd-b10403b52691@amd.com>
Date: Wed, 25 Sep 2024 11:14:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/28] AMDGPU usermode queues
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <CADnq5_OzaOWZ4tvN=13oXHc091kFUdtkhz9=R8-eknD1PMhYkw@mail.gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OzaOWZ4tvN=13oXHc091kFUdtkhz9=R8-eknD1PMhYkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a46f11-00d4-4f80-2795-08dcdd428739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1NPcXVIR29WR2czcVhuN3JuSHlGakczK0xMV1QrUzFvT1p3bVZzbXh6aTFr?=
 =?utf-8?B?N1hXYjlaRFFjK0lmTkxHVldVQlRyRE5hbFU3OEZNbys4T2lSSlpWT3dmMm51?=
 =?utf-8?B?NjFPamR6YzN5bjJ0My9NZmFEaDFDaFJHYjhZcXlQQW1PVDZ5cnEzYVhJYUlW?=
 =?utf-8?B?TXJwUlBwQ0hDQ0U3OE4yMUYwUVdtYzd6M1BGZkVNV0NRakpLTnZKeFNkWjJo?=
 =?utf-8?B?WVllb3ZxSzZuWk84d05ObE9hU2R5c0NlSkNzdzJwOVJQT3lQOWJsK2k5NGxp?=
 =?utf-8?B?YjBYT0RzSGFVM1VXYVc3TFVLOHJybHc3VlZvNFhxUWwxYytOZk4rRkpEWlJy?=
 =?utf-8?B?NlJ5NGhBbnhrN3M3cGtDZS9qQXBSSEhlNGZZL3FLQXhRQzVxRW9sWmRtK3dR?=
 =?utf-8?B?aUxjSVRhV0FUNlBaMXBSTlMxWFRiSjQwWWU5U0NqeERzV1Q4MklqSFlBOWVI?=
 =?utf-8?B?MW5yN3FQMFpGOGloMGlaSnYrQkUvYWQ1QVNhR2xyTmJrWEc2WWF5cVh0UEM3?=
 =?utf-8?B?VWFLenRuNVVLRVlQc0YvUC9zTytZVkRUZVdkQnhKaXF5VFA3TFRyRWxxWEhs?=
 =?utf-8?B?YzFHcDNKVUtaVWhmL2Fkdm5aQVpvU2p0V3MwUnkvWXJKZHNNOFBaUXl3TnpW?=
 =?utf-8?B?ci9UelkyaFVlWXBteHNuelZtcmVXRlRBUU11Wk5aejdkaisyelBVM3duTlUx?=
 =?utf-8?B?LzVGZkd3d3NVMnNvU3J6R3JOTndhU09ybW9xQ09udGY5MUc3TXVFSmFudjRD?=
 =?utf-8?B?Mlh0VVpvU3k1Rnh0Q1M4MWttcUdtVDlxeFRtLzR4V25CNHgrdlZJc2xJSWNY?=
 =?utf-8?B?Rm5ZaUdSNUdHTmF5OXYxNEE5SWhmdFlSQUZVR2ZxOEpJdFRsUTI0aHMrMWNC?=
 =?utf-8?B?QWFvQzBKRHZHZittL3V2bUdYdjVCeHVFTVBHSmxLR3RRZTFSdi9sS2NiZ0Ix?=
 =?utf-8?B?Ym9VbW1lUWJZYXErM25rNWxmR2k4eW1SMzErWEtGaEd2b1ROdFppVlVLeFhr?=
 =?utf-8?B?RE1SUGlSY1ZMMngrN1VNTEpqWWgvOHB1WmJXd1JlUTVQdlZBcDJ6N05zajc0?=
 =?utf-8?B?a0tJRENsNm5NaEprdEF2b3p3aVd5VEphaE5qRUFzYmtzSHRtbldDeWlyVndC?=
 =?utf-8?B?NXdZTncwaVhuWVFBL1lhQWZST0tSTG5kcWlUQ3ZIZElSdzZhU2VtMENHakpU?=
 =?utf-8?B?Ynp0MWxmcG1XTi92Sm5YbHY2VFJNN3pGN1FnTVNKN25KQkFsUmNUZ1JrTnpk?=
 =?utf-8?B?TTlZS2RsUTZQZ1grRUk5MGFzRTRQRjNpVWZvMjUzNTI0ekZEOHFGTk1xbFl1?=
 =?utf-8?B?RGZWbURHbHFFZ24rL21zeVhFT0IrT2FJMTd3ZC9rM044SzF2MWJMTzd2Wi9N?=
 =?utf-8?B?cjlSbnI2dXA1a09CS2p1dzJsUmRqcDdsTWRxYUNqWUtwVzJ5YW9pVWtLQW93?=
 =?utf-8?B?VzBDRHhHT1daYTF6eGloUTF5cW02SXZ0RytDaEZ2OWxvWVc4UnhMOVNaR2d6?=
 =?utf-8?B?TEpvVzJ2NDhBb0I0SHByMHE2QnlWVmVTbHVGMGpiZkVETkR5WFo0cGwrZEZ1?=
 =?utf-8?B?cXpoZzhPYm5LUC9ZN3k2NFJDRzlTZ3lCOGREVGc2b2poTmlxVjNud3F1Y0Mz?=
 =?utf-8?Q?7DWwQbEvMeoXO6I4SU7ll7A4h4V3Fvq6pAaDQaWYdeyM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlN0Z3AycWJSUlNCQVhMWXg0NGlxcExyRVhGenBicEdTT2dPK0E3L0NsM2hR?=
 =?utf-8?B?bzlqL3Y3N2ZxSnFKVEY4MTlIc1FiaDJCUHpKQ3oxeW1iTzNFaTl4VGJ6ZmFx?=
 =?utf-8?B?WjdmMnp1MGhtVzRJS1cvTVpqc0xwS1FhQXVqTjVoaWljRUdMUVNRajNkLzdK?=
 =?utf-8?B?MHEyTC9kak1KQUdYVkIweTZ2WGpUN21Bd0ZMS3BtUXY3QVRCNEtDdlo0VFgy?=
 =?utf-8?B?N3JrbXlvc2ZJcEpFS2lTeXMxVWZPNXh6bDhhUFgrRzRNQ2RpOHVLclJSMmZL?=
 =?utf-8?B?NU5CL2wwYXdMb3ZqSjJkVEpHb3pPYVc3a3dEZVRpMTA5eUpKVUsxd1o0VW90?=
 =?utf-8?B?T05XRS83Vk8vMFIvNHhVcjdLYU1kUW56b2hoUi8vYmtmakRLaCtSenpQV0da?=
 =?utf-8?B?SXFXUjV1OTE2SWhXTHdTM3BUQ0lJRjhDdDZ1UVBqYWV2cDlKeEpZWThXVm52?=
 =?utf-8?B?S0tWK3U0VzFSWWVQbHhqQ3Y0bUZ6TkVTTnBRdGs0ME5qRlMweTRjbG51a3k3?=
 =?utf-8?B?SUtvSWtCelNaME1rVHA0L2JIc0pLSzBTclRqOUZpR1dLT1VocExCelFNbXdm?=
 =?utf-8?B?cFk5Z1R6L1ZqSE9jOFVES1JiMDI2eXpaSEdJNnU3ZmpuMmdyZGthUjJObFJZ?=
 =?utf-8?B?RGpnbGJYRm9NQW93clp6TVdreC9LOFBwSWk2T0hXbUhEdUZYQmYwOG9rcVFk?=
 =?utf-8?B?dWVkcDhXeUM2RnhLOC90dlBKY0VNZmpOaGdENWF5UU9MV2VKR05mZ3VsTjFV?=
 =?utf-8?B?ZnZVeFRCZElxemhJQS83azZxRGFQS3J1RllwdEQzdDFjWEYxK3JNMGZCZGdD?=
 =?utf-8?B?VnZVVHFGYWRRc2s3SGpvL2NRaTFwUVZ6M2JwMUdRcTRHWm8zVGxDV2hyS0I1?=
 =?utf-8?B?Z1dhY1VyMHZjMEJkNDZqeTNSWHFkRndyVDZrbnIwd3FvOXFWZWlYdXAyem5a?=
 =?utf-8?B?YmR2UTRLa0hkZldJRHJJYnc4a0VVTU43VGNSS3ZFd1RURWxrNWNWalVISzBv?=
 =?utf-8?B?b1VsaUsxbmlrN2lWTlQ5SjBqeGRSUi96bTBrbllSTVVicVBBZ2VLZSs2OWE2?=
 =?utf-8?B?akp2c2llM2tzYnppUWY0bUNCLzhJcHNmYjh2M2cwOS9Xb3FXN2phOEdJS3pa?=
 =?utf-8?B?YjBKNzgxOGcycHpIdVgvNW9kQlRhbWcwL1FFMXRpbHFkWElIYkJhWTNmUkk5?=
 =?utf-8?B?THNjRjYzSFlqVy94SGFDdVlveGM2QUNxSGdoRlNqRGM4NnNRVVRReFU2UEs4?=
 =?utf-8?B?a2JEMStFeHh0VDZQS0p5OWdnWUF3OHlBQTVYWGFmdEl0Uit3dHRKWHNoaHk3?=
 =?utf-8?B?NFNGOFNrRzcvUWV6aHdZRTRMd09WQnZUMFFMNlRuaEhYM0wvRzdtOWx1a1dK?=
 =?utf-8?B?N3dHbWFuNHQ1VzUzbEltdHdidDBVQ2gzK0kxN0VwTjFkSXpEeXNRQW9wVktZ?=
 =?utf-8?B?aHdPSmlRL3pNMTc0R1BueFNydDZuUStLeEFLaWZna0hOMVQ0NVRHUUZGcHk4?=
 =?utf-8?B?bnlCVUQ5aFF3VUJreWwxOUJyTHg3a3lETnA0SUJ4WENRSFBiOXgzOGNPTzVu?=
 =?utf-8?B?Yittb1lvSlh3azl2elVuUnJZUzNZK2JOVit0RGpaSk1qOW9mV2xZN3dodHJJ?=
 =?utf-8?B?VFJPZENBRWIxZ3BRS1JvUTl2bkhqUkdkb2U5aEN2a1ZUTWw5YU01eXhQelJL?=
 =?utf-8?B?MjVOMW11U0wxb29VN1dGZnZOeFF6QTU3NTl5YkNZZWM2SDhDTDQyZVlnNWlm?=
 =?utf-8?B?ejA5eHBtUU14Wm8zSTdSQ2V6UGlJc1RCVk1idkFoTnFSRDFjbmVwTFFxa2ND?=
 =?utf-8?B?eXVmbjlHNXFPdzNWQlRoUHlUVjBIbldlWm1jaFBGV2FuODhMeEhza1VaOVJx?=
 =?utf-8?B?VENJNWlHaGZpUE5HLzBaeUJDcVdJaGlhd1d1UGtEWi9PeE1tYUhCV3RSczQz?=
 =?utf-8?B?ODFzRHZiZFpSQkQzRUVHMFlBeUIxMmRrRnpoZmZpenErSm1saStuTGNEamRV?=
 =?utf-8?B?RzhFOGFjRm9PUjlpNWpIS3JPTHpISll2WXZHZTM5ampxTjlFNXZMOURyTWg2?=
 =?utf-8?B?d2w1UWY1dW9tZ0d1VlVGd3gvS21NVlhFUm8zL3J4RktWd1NJWUVUTjE2RGkz?=
 =?utf-8?Q?ObTOiB28BIwL0jBSJxv5B8fSo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a46f11-00d4-4f80-2795-08dcdd428739
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:14:58.8330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKiGlMXlJ2F/G5sgydv09Khqkb9Dv1JJhfTrz9pJo/MOMUnIbMaIXP4OZ9ei2AQPXPvgC7ChBje/dwBSHmkF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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


On 19/09/2024 18:59, Alex Deucher wrote:
> On Mon, Sep 9, 2024 at 4:07 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch series introduces base code of AMDGPU usermode queues for gfx
>> workloads. Usermode queues is a method of GPU workload submission into the
>> graphics hardware without any interaction with kernel/DRM schedulers. In
>> this method, a userspace graphics application can create its own workqueue
>> and submit it directly in the GPU HW.
>>
>> The general idea of how Userqueues are supposed to work:
>> - The application creates the following GPU objetcs:
>>    - A queue object to hold the workload packets.
>>    - A read pointer object.
>>    - A write pointer object.
>>    - A doorbell page.
>>    - Other supporting buffer objects as per target IP engine (shadow, GDS
>>      etc, information available with AMDGPU_INFO_IOCTL)
> the queue, rptr, wptr, and metadata buffers don't have to be separate
> buffers.  Userspace could suballocate them out of the same buffer.  We
> just need the virtual addresses.  However, we need to keep track of
> the GPU virtual addresses used by the user queue for these buffers and
> prevent them from being unmapped until the queue is destroyed, similar
> to what we do on the KFD side.  Otherwise, the user could unmap one of
> the buffers and submit work to the user queue which could cause it to
> hang.
Noted, thanks Alex.
> Alex
>
>> - The application picks a 32-bit offset in the doorbell page for this
>>    queue.
>> - The application uses the usermode_queue_create IOCTL introduced in
>>    this patch, by passing the GPU addresses of these objects (read ptr,
>>    write ptr, queue base address, shadow, gds) with doorbell object and
>>    32-bit doorbell offset in the doorbell page.
>> - The kernel creates the queue and maps it in the HW.
>> - The application maps the GPU buffers in process address space.
>> - The application can start submitting the data in the queue as soon as
>>    the kernel IOCTL returns.
>> - After filling the workload data in the queue, the app must write the
>>    number of dwords added in the queue into the doorbell offset and the
>>    WPTR buffer. The GPU will start fetching the data as soon as its done.
>> - This series adds usermode queue support for all three MES based IPs
>>    (GFX, SDMA and Compute).
>> - This series also adds eviction fences to handle migration of the
>>    userqueue mapped buffers by TTM.
>> - For synchronization of userqueues, we have added a secure semaphores
>>    IOCTL which is getting reviewed separately here:
>>    https://patchwork.freedesktop.org/patch/611971/
>>
>> libDRM UAPI changes for this series can be found here:
>> (This also contains an example test utility which demonstrates
>> the usage of userqueue UAPI)
>> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>>
>> MESA changes consuming this series can be seen in the MR here:
>> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29010
>>
>> Alex Deucher (1):
>>    drm/amdgpu: UAPI for user queue management
>>
>> Arvind Yadav (4):
>>    drm/amdgpu: enable SDMA usermode queues
>>    drm/amdgpu: Add input fence to sync bo unmap
>>    drm/amdgpu: fix MES GFX mask
>>    Revert "drm/amdgpu: don't allow userspace to create a doorbell BO"
>>
>> Shashank Sharma (18):
>>    drm/amdgpu: add usermode queue base code
>>    drm/amdgpu: add new IOCTL for usermode queue
>>    drm/amdgpu: add helpers to create userqueue object
>>    drm/amdgpu: create MES-V11 usermode queue for GFX
>>    drm/amdgpu: create context space for usermode queue
>>    drm/amdgpu: map usermode queue into MES
>>    drm/amdgpu: map wptr BO into GART
>>    drm/amdgpu: generate doorbell index for userqueue
>>    drm/amdgpu: cleanup leftover queues
>>    drm/amdgpu: enable GFX-V11 userqueue support
>>    drm/amdgpu: enable compute/gfx usermode queue
>>    drm/amdgpu: update userqueue BOs and PDs
>>    drm/amdgpu: add kernel config for gfx-userqueue
>>    drm/amdgpu: add gfx eviction fence helpers
>>    drm/amdgpu: add userqueue suspend/resume functions
>>    drm/amdgpu: suspend gfx userqueues
>>    drm/amdgpu: resume gfx userqueues
>>    Revert "drm/amdgpu/gfx11: only enable CP GFX shadowing on SR-IOV"
>>
>>   drivers/gpu/drm/amd/amdgpu/Kconfig            |   8 +
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  10 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  11 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   5 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 297 ++++++++
>>   .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  67 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  68 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  11 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   3 -
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   2 +-
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 713 ++++++++++++++++++
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  74 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 644 ++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  42 +-
>>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  16 +-
>>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 395 ++++++++++
>>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h  |  30 +
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   5 +
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    | 100 +++
>>   drivers/gpu/drm/amd/include/v11_structs.h     |   4 +-
>>   include/uapi/drm/amdgpu_drm.h                 | 252 +++++++
>>   22 files changed, 2722 insertions(+), 45 deletions(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
>>   create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>>
>> --
>> 2.45.1
>>
