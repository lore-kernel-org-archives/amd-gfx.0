Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA510C369B0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 09:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7FF10E7DB;
	Wed, 25 Sep 2024 09:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XGLaJua9";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945D210E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 09:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaaW5/phJToPwWdr6v3objJPUchh3F2n0BL564nAe9LepJgF1xn5Ot+a8otMHs5RMre42XoyVQLcYhVIrfsr1dB4Qq7GUYEGp4IRIgxUsx2OaNmdw+QARbmLtctwTsPtALnRPF/HL0iu57ct7PyT2eF8Kl+Z0E83hzVyGIBtC1EQefBnZfu1TpMSAqBCik6vtPpS8HKxvWfvqOGRl3yUdjUClJjhgFCOgjKvzSsem/jW2HfcTj5mSmq551eTQIZsp4HqW+PkGyRpdhOcSKeSrjB8kCxIxVUUG6mw3SrNcH+TriWH4Bz6HdJNkf4ASP5ZdtTy+U4IlkzOQ9DQhGiwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjdnpPjgY3ODDtTRyr5WKwlqoZdJHhcL0x9lXwHa+zg=;
 b=qYHUpBvAb4DdjRy1QoC0EUrtNRifgbu1NB1tmmhp7dzzvdedsdQ5vvZhErIN5FR218Fo7qF45yJfcqG/T24TsGo0759WeRHeKzg30NELn8RAqyYqFtDa018XcHHDF14A1OESgTex3qFEwEy9Y6MOHFH5csWzA3PRcFOeJ6aR8wz7q7emVCVFSRhlLYzWJsIuAA3B6y7cpLPJOV8qYZ8efIvJJ6kdHaGjNWioIVOp67OrfHx1Hy9AHNrL292/zc9mUMZ5tTNS2+f9Sd9lcCLRBXNfpbO7O1wznbTNU3T+iWUp2DGy9TZz4GP98AhlG0DMjQUITzvZFVNM38nJRPoqZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjdnpPjgY3ODDtTRyr5WKwlqoZdJHhcL0x9lXwHa+zg=;
 b=XGLaJua9X+h2D9+AVUQ6TzMNY0D81MC+6aalb/rN73RiPbs96q0pxbJiGs4n2baDDI+im2Baspy+4SjhAQHaexuxv+nt/eS5mONhupPSv1f1wLVRBfAjkAIbqN0RPnokl8tK0uNxUglAnzJsCO1hQx1kSOSkw67FMcwja4vVyxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 09:15:55 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%7]) with mapi id 15.20.7982.016; Wed, 25 Sep 2024
 09:15:55 +0000
Message-ID: <d9110bdb-06f5-4951-b09a-2fbdd6d7f516@amd.com>
Date: Wed, 25 Sep 2024 11:15:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 24/28] drm/amdgpu: resume gfx userqueues
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-20-shashank.sharma@amd.com>
 <8a6fc562-277b-4162-ad0d-3ee0f42a55c4@gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <8a6fc562-277b-4162-ad0d-3ee0f42a55c4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd1e9b6-1cd8-4b03-0537-08dcdd42a92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ei9UVFdTbDlNU0Y5YU0zNk4wSFZWTDJkci9lVCtqekliTWxuV0dFMnROZUJa?=
 =?utf-8?B?MTF2VG96Q1VzamM4bVltWjVVWEtsYkkvL2g3dEEvNmZqZiszOVI1UjBaaVVq?=
 =?utf-8?B?TnpHdzFrUlgySVZaOHNrK3JnWnpWa3F3U1VZNk1mUDl4S3UyVVNZMElMSUVX?=
 =?utf-8?B?clVUeGE0VEZDTFNHaUtScVlUaTdaMWtLNU1Gc0RnSW9BMkFZa0JPbndzQWpq?=
 =?utf-8?B?SktRd0xJbEhMeGI2K3FwWE0rRVJWT2JoUmI3aXhqQ2FKMlZLMExTR3lYeCt1?=
 =?utf-8?B?cDVTQUVsSncvZ1VrMGRvcXRFUTlDcW05cTdqMS9wZC9oYklhUWRsemIzKzZ2?=
 =?utf-8?B?ZFpKdHlzajh2WnRTZHl1SG5QWW1aZHNZVEkzUGd4MTdRdW5IT2JyQ0tlSUw2?=
 =?utf-8?B?dEZWaWxESWZ2VDJKd0JrZ2luQmdCSEdjdWdHc3ZwZnBGaU1hSUtXWHc5VmFB?=
 =?utf-8?B?OUszWDZpSUJGK243WEkrN05icloxMG1Ed2t5YjhyL0hQaXA2N0hwZ0VLWXor?=
 =?utf-8?B?S256c3ZmbWRNTmJyczEvOGJkaGxzNTJCUDVMRlZ5VFdBZCtROFJwa1FsZHNw?=
 =?utf-8?B?N2VDS1ZCVldHRjRlWVFHZmozdnU0UnNpc01yZks4bXpFdUs1NFh4OHppR1A0?=
 =?utf-8?B?TnFGYzFBVmpzUHVnQVhaYzJpUDZUcFloUEJhMDlNVnpkaWlncmVLL2ZaSHF3?=
 =?utf-8?B?QlhhSlRzUEY5NWRJZ1RxazhlR1dqRjh3cmtjTkNmZHlVYStDODNpclhrMEpp?=
 =?utf-8?B?ckJRanI3SjdHWG9jb2tEdkNvUGgyUjlodmVVY2Jkd293OXNHbVFvdElZbmhW?=
 =?utf-8?B?VFJ0YzRsNE1LMGVBbmJmZmswTUpOaXVlWU8zakNqQ3E2WjVIMGdTRkxIdmVn?=
 =?utf-8?B?WHFVOUVsTFdyZHluWGt4TUNjdUFHZ29DRlNkUzQxTWNramRDMGFrTm5oeFNZ?=
 =?utf-8?B?RU14dDVjT2VkYktLU1M2SHRLQlc2WkxmYXNJWXBYQ1VDS3hrTnlxWFZzQjVx?=
 =?utf-8?B?d3NGVnpyZzBVbXVxMW14U29kUnNyRXBCZ0ozRFpabUdSbjZrWk0xYWpyZkRt?=
 =?utf-8?B?OGRENW9KT2pxOExJdGZCcVMxRDdWdERHV1ZYcXg5RDdBbGIySFQyQURjdVlh?=
 =?utf-8?B?b3ovcTVUQkloRHBNQy9wRzZkNWtVWDZtejk2eUlLT01jT1hmaTRaS3Jocjhs?=
 =?utf-8?B?bnMwaktFNUNXR2VuZzlJMk1QbzdPQko2dk1YUUpOb2tuVGtHd0hCV1lEVmcr?=
 =?utf-8?B?VzNRT2d3WDBLZmJXZEQrc29JZ2JhZDdERkVqQ1JJUWsvSFBTQlFPZzZod2VR?=
 =?utf-8?B?TzZlR25VRm1iYVBzYzRQV09neWRIQUVoMkIwZ3QweGdUOXUvbjNTS04razVZ?=
 =?utf-8?B?TjRPWVJ3VS9UWFFjcXNJSzdqZFNEUEdRTGFiY3NIYXE1UjN5WExiKzhJOWp1?=
 =?utf-8?B?NFdGVGxIMzlHUzFWSFcvMnp0K0lSUzBwdTk4dTg5VTFIUzJrLzZ5dzVMcGEw?=
 =?utf-8?B?VmNteTUzdXpzRjkzQXJVbldxN0k2TExMYlpPYU4wTGpoaDlleWRXeDJOK2Fy?=
 =?utf-8?B?d042dldGRUpjVXVjVFdLRUhaaTNMUW02WWR4SWNVckdsVnlRZDhwTjJMSm9u?=
 =?utf-8?B?ZmxOVC9QaEhQdDBwV1hxK2IrTzBCV2lCRTZkS2FOMEo0T3N6YzZFRGN5dGo0?=
 =?utf-8?B?emE4SnUrc2laS3YwTmRRTjZWd29RUXNqc2FtbzBiTkFRb213bzhFZXJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNOeTRwdDk4RjA4c3FvbWMwdzJKaS9NVXljZ0ZzTWI3bG9RL0IrUmZOZDQw?=
 =?utf-8?B?UE0wa2xhRW5XcHNnT1NQbVFWUnBWS01NNW1hbkZUS2dBZFhTdlFnR1NnMGV3?=
 =?utf-8?B?clBkVXh2dmkzWng5NDE4b0xzT0hxc0luWVhpR3hUNTNyajZGeExvS1YzVnZy?=
 =?utf-8?B?M2dKQkRzT2NTNEdIZlh4d2NGSDJEWUFPM2hNazVTM2piYzVVZ0Z3bjIrUGc4?=
 =?utf-8?B?anRJaEQ4YVhJcTBwKzhocitGUlBxVVBNaHZpYllyNWZMaEdybmltbTVGMjdV?=
 =?utf-8?B?MEZIMFFFcUFQZjV0dTAzbi9UUHZ0MGhJeERRWVh6c3NYUU5tV0RqMFJreWJv?=
 =?utf-8?B?M3NuaWp2SnNGK2ZtTncrVEtreWZOckRJTUxqL3g0a1pTYmlLeFZ4Unluaytj?=
 =?utf-8?B?N2xMNThNTklqNjNBQ0Q0c0NhNURPU0p6dGJ5VWgxTVBOWlF0NmVPV2tXeEhM?=
 =?utf-8?B?c1VWdUExT3k2bTRpeFYxcHE1bXc4YXhSMU5mU0RzOGVyNUJ4cE1kb2NIcUZh?=
 =?utf-8?B?Tlhja3JFNG1CaVFrNXBtVXUyK2ZwM05Ed2JpaUN0WGRDK0RvL3MrWFZhcnhV?=
 =?utf-8?B?VDROKyt6aDJtWnlJUE4rSHlBcnk1RnRyZEVUb2pmY1hHWFY3UUduNVhzTmtj?=
 =?utf-8?B?Qm5PY0t4aGxWU1QyOHY5bFlhNmxyaExnVlpCQ3VReXVGM0N4QnVLendMVDUx?=
 =?utf-8?B?aFdQZVE3WGdVNkJCNWtiWTNlb1dRRkdyTlFxaVFaOTQwbk1GVytuTm1qWjht?=
 =?utf-8?B?NnNiNW9HSW4wQ0cxSWhLVlBHUmZteVduV0F4NFQwVnF1dHNnV0wxb0NCRTRK?=
 =?utf-8?B?ZmQ2a3J4NlcwOEMvYkUyVnZNRCtuaFlHa3dkSXBJK1lXa1JMVGtOR285Nk5m?=
 =?utf-8?B?Q05CY3lITmw2cDBQdUl2U2lBQ0x2clVJeTNzaG5wU3JwRXFNdDh1Vks5cjho?=
 =?utf-8?B?Z1RBU2dOeHk1R3UzT0s1enZZdW10T09YbC9pMnpBYWgwSFVmTDVhV2NUQTM2?=
 =?utf-8?B?VUJ2RjJwcHFzWVllc0NIZHdlcGV3WUp1S2MvQ3JScUF4Smx5VFJPaG1rekd3?=
 =?utf-8?B?WXc0MXJSUlhnMTlPMGlQclpIRmxkOW5nMWJwREpiSzFNcnU5SXUrZEwwZ3FX?=
 =?utf-8?B?eWlYSmVkeWoxa1Z1ejJRU0NvOTEzcytqSkcvR0NuS1FMQ3hXM2htRDVJaWd5?=
 =?utf-8?B?VjkyMytnR1htTDRaSjA2VjVnR2tnNGFEK2NYa3hzU1BTS1hjcHFEcmc4SkFp?=
 =?utf-8?B?MzFwQWVXUXg4bHpFN1JCYW1CYTdJdm5GRENCakNQZFFWeVg0aFFQMDFmZWVG?=
 =?utf-8?B?SjBpTklnVDBmVUgrb3dVT1RQK1dzWlpFYUhWWEZsZUNJV2hTamJIUDV0Y1RD?=
 =?utf-8?B?WXA4cDNCVXlhcmN4d3doak9DMmsveTRZamJhYnFQRGYxNzl4NUpZeFcvZzRE?=
 =?utf-8?B?ZENFYkpMWEc5U2dYVmtBK0szaFhhVzBXRUE1UjBPRTc5cTZ3UlFZY0pZSmx1?=
 =?utf-8?B?dURvdjZ5NEVkMjZLODZOMlpGWTR6ZUFqUlRWejlKWXp1b2pId1VoVWRZenVB?=
 =?utf-8?B?Z3YwdEJYcWZoME85M1hPbXpnWHdHTGhLeVNINUFHOUpxWkJRcGp3US9zYWwx?=
 =?utf-8?B?Zzh6dm9JMk1UM3hMVDBkMjk1bHRTbE96THViTU9icUIzejA0ZlJ4OUdyQkxU?=
 =?utf-8?B?N3Z4K2dxbHlCa0FodnFHdkswTlNRM1ZCaDhNQjJ4eUc2VWRzR2RaNEl2R0hW?=
 =?utf-8?B?VUdxa1RoZ1VHa0swcHdJOTc1UGZ2cGFlMS80cXRQVW9QU2pTZ3JTWDYzYzFZ?=
 =?utf-8?B?eG5oT2xhbGFjRnlaT3JHTUU3bHVWbmduTmhiWkNkL0N3Q0ZQY0pkTnBBb0xJ?=
 =?utf-8?B?WmNzMW94TVRFUE9yU1J0VDVoYjF2eHNxSVFNSS9kWmNmUWorWTF6akdoMzBV?=
 =?utf-8?B?QnpwNHB4bkdZRFBCakZEY2dqUnkrbWc5YVhHT0hLUHFDMU15T1ZRaFFsV0tE?=
 =?utf-8?B?Y2krNHRVd2VBeGs4Z2FpaXIwWHZIOE1DcW5jamsxdmR0WXFqV3lJalFSMXZy?=
 =?utf-8?B?NFNETm9icjR0SFR0RWdEZVFCQmJxUHZLVFhxdzNVVVNoeVBHbVRxRE9Ebzg3?=
 =?utf-8?Q?klTsLm+COMu9qW1cHlBPB70F1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd1e9b6-1cd8-4b03-0537-08dcdd42a92e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 09:15:55.8047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL0PdsAKlYKpGjlYacQ+lQIb5mmEuKDg1afTLoHMd3uKvyR1dqp0TbFKxH+to17jqUX4rNKQUQUspsEjG2enBw==
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


On 17/09/2024 14:30, Christian König wrote:
> Am 09.09.24 um 22:06 schrieb Shashank Sharma:
>> This patch adds support for userqueue resume. What it typically does is
>> this:
>> - adds a new delayed work for resuming all the queues.
>> - schedules this delayed work from the suspend work.
>> - validates the BOs and replaces the eviction fence before resuming all
>>    the queues running under this instance of userq manager.
>>
>> V2: Addressed Christian's review comments:
>>      - declare local variables like ret at the bottom.
>>      - lock all the object first, then start attaching the new fence.
>>      - dont replace old eviction fence, just attach new eviction fence.
>>      - no error logs for drm_exec_lock failures
>>      - no need to reserve bos after drm_exec_locked
>>      - schedule the resume worker immediately (not after 100 ms)
>>      - check for NULL BO (Arvind)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 120 ++++++++++++++++++
>>   .../gpu/drm/amd/include/amdgpu_userqueue.h    |   1 +
>>   2 files changed, 121 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index 979174f80993..e7f7354e0c0e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -405,6 +405,122 @@ int amdgpu_userq_ioctl(struct drm_device *dev, 
>> void *data,
>>       return r;
>>   }
>>   +static int
>> +amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    const struct amdgpu_userq_funcs *userq_funcs;
>> +    struct amdgpu_usermode_queue *queue;
>> +    int queue_id, ret;
>> +
>> +    userq_funcs = adev->userq_funcs[AMDGPU_HW_IP_GFX];
>> +
>> +    /* Resume all the queues for this process */
>> +    idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>> +        ret = userq_funcs->resume(uq_mgr, queue);
>> +        if (ret)
>> +            DRM_ERROR("Failed to resume queue %d\n", queue_id);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int
>> +amdgpu_userqueue_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
>> +{
>> +    struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
>> +    struct amdgpu_vm *vm = &fpriv->vm;
>> +    struct amdgpu_bo_va *bo_va, *tmp;
>> +    struct drm_exec exec;
>> +    struct amdgpu_bo *bo;
>> +    int ret;
>> +
>> +    drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>> +    drm_exec_until_all_locked(&exec) {
>> +        ret = amdgpu_vm_lock_pd(vm, &exec, 2);
>> +        drm_exec_retry_on_contention(&exec);
>> +        if (unlikely(ret)) {
>> +            DRM_ERROR("Failed to lock PD\n");
>
> I would drop those error messages in the low level function.
>
> The most likely cause (except for contention) why locking a BO fails 
> is because we were interrupted, and for that we actually don't want to 
> print anything.
>
> Apart from that I really need to wrap my head around the VM code once 
> more, but that here should probably work for now.

Noted, I will remove the error message.

- Shashank

>
> Regards,
> Christian.
>
>> +            goto unlock_all;
>> +        }
>> +
>> +        /* Lock the done list */
>> +        list_for_each_entry_safe(bo_va, tmp, &vm->done, 
>> base.vm_status) {
>> +            bo = bo_va->base.bo;
>> +            if (!bo)
>> +                continue;
>> +
>> +            ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
>> +            drm_exec_retry_on_contention(&exec);
>> +            if (unlikely(ret))
>> +                goto unlock_all;
>> +        }
>> +
>> +        /* Lock the invalidated list */
>> +        list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, 
>> base.vm_status) {
>> +            bo = bo_va->base.bo;
>> +            if (!bo)
>> +                continue;
>> +
>> +            ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
>> +            drm_exec_retry_on_contention(&exec);
>> +            if (unlikely(ret))
>> +                goto unlock_all;
>> +        }
>> +    }
>> +
>> +    /* Now validate BOs */
>> +    list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, 
>> base.vm_status) {
>> +        bo = bo_va->base.bo;
>> +        if (!bo)
>> +            continue;
>> +
>> +        ret = amdgpu_userqueue_validate_vm_bo(NULL, bo);
>> +        if (ret) {
>> +            DRM_ERROR("Failed to validate BO\n");
>> +            goto unlock_all;
>> +        }
>> +    }
>> +
>> +    /* Handle the moved BOs */
>> +    ret = amdgpu_vm_handle_moved(uq_mgr->adev, vm, &exec.ticket);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to handle moved BOs\n");
>> +        goto unlock_all;
>> +    }
>> +
>> +    ret = amdgpu_eviction_fence_replace_fence(fpriv);
>> +    if (ret)
>> +        DRM_ERROR("Failed to replace eviction fence\n");
>> +
>> +unlock_all:
>> +    drm_exec_fini(&exec);
>> +    return ret;
>> +}
>> +
>> +static void amdgpu_userqueue_resume_worker(struct work_struct *work)
>> +{
>> +    struct amdgpu_userq_mgr *uq_mgr = work_to_uq_mgr(work, 
>> resume_work.work);
>> +    int ret;
>> +
>> +    mutex_lock(&uq_mgr->userq_mutex);
>> +
>> +    ret = amdgpu_userqueue_validate_bos(uq_mgr);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to validate BOs to restore\n");
>> +        goto unlock;
>> +    }
>> +
>> +    ret = amdgpu_userqueue_resume_all(uq_mgr);
>> +    if (ret) {
>> +        DRM_ERROR("Failed to resume all queues\n");
>> +        goto unlock;
>> +    }
>> +
>> +unlock:
>> +    mutex_unlock(&uq_mgr->userq_mutex);
>> +}
>> +
>>   static int
>>   amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)
>>   {
>> @@ -486,6 +602,9 @@ amdgpu_userqueue_suspend_worker(struct 
>> work_struct *work)
>>       /* Cleanup old eviction fence entry */
>>       amdgpu_eviction_fence_destroy(evf_mgr);
>>   +    /* Schedule a work to restore userqueue */
>> +    schedule_delayed_work(&uq_mgr->resume_work, 0);
>> +
>>   unlock:
>>       mutex_unlock(&uq_mgr->userq_mutex);
>>   }
>> @@ -508,6 +627,7 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr 
>> *userq_mgr, struct amdgpu_devi
>>       /* This reference is required for suspend work */
>>       fpriv->evf_mgr.ev_fence->uq_mgr = userq_mgr;
>>       INIT_DELAYED_WORK(&userq_mgr->suspend_work, 
>> amdgpu_userqueue_suspend_worker);
>> +    INIT_DELAYED_WORK(&userq_mgr->resume_work, 
>> amdgpu_userqueue_resume_worker);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h 
>> b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> index 8b3b50fa8b5b..d035b5c2b14b 100644
>> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>> @@ -76,6 +76,7 @@ struct amdgpu_userq_mgr {
>>       struct amdgpu_device        *adev;
>>         struct delayed_work        suspend_work;
>> +    struct delayed_work        resume_work;
>>       int num_userqs;
>>   };
>
