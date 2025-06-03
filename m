Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FB1C5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 15:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE75B10E60A;
	Tue,  3 Jun 2025 15:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eXBkwusm";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16EF910E60A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 15:01:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOBKvx9NC6o6Zk1pI7tnLU8Fv5c9cFg7sS4WfJUZrP/uH7Ne+i+iKiY5nSIlRe+A67boO/w7ELC/mqimhWcJLQnemijLFqo1CmEsker8tgobK9dqFI1GHNlxnG7JIhS01LmcKdcuE+tK/XGh6IH6FFhE6bfJTJJasW3Rdhlig2ckhZQ8tyBKPasxhc6nmpKdtAN8BcxjHDqcPZxtZxW5tvbuVMMjF+w2lrUm525oFDri2wDmPTJBbcZoTrp9cblrXgSCtPS7ynRLO8cfjKGBB2T1YDekRYzemUVziSST/cmH1oWkAPuV11CQKdBL69hKAEpW+fn+lmxH6wbFj2Oz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fh0CcNJbsdFiHvxHdNjgFLSSjhJwjp72S7frAoyd8sY=;
 b=FldNtWhwRYl2VzX7Gi8QKIoXHq2I8HTnsdllTAaI+tix2WwsSJSg3CE29Jeq+d1De/bsuKtmwTbiUak9MzCQTYEQvBjtBxX7VI2dsze9lRhCYWVeKlyO0B6MWDfakjI4vUZlnRGBz0AVFQqIjGf2qYMjnpPEb02w0WnZM9jk6C9FIIOg9nFzaMm2Km+NWb5d8baYOvuAl85g+zraq0wyNPZXBwGRwT4Qm91JKEIGCYBQxJkOrsnBU/kuWZkg4mODmpgCywWgwyY5ptkv819Q3wfkYFVbjcPvd2h/d8Vz7SuYlRWkO8AdWUopID0No9765d6zNFjAyqm47MPuTm/8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh0CcNJbsdFiHvxHdNjgFLSSjhJwjp72S7frAoyd8sY=;
 b=eXBkwusmEhJWq1691sJDCPsITeANoRX8Pgpz2TD98UbVhuH2bafulxhE+OXSjUmqqrEgVZtTE1c75NvymWB7d9gJHbmqajwwW0VMYIgYA0ZNhl45Y0jmJgo69g66yNavDYU3g4C2yyqQ089W33LOd7YGzO0+80beHjCkJkaDokU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.31; Tue, 3 Jun 2025 15:01:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 3 Jun 2025
 15:01:09 +0000
Message-ID: <6d488337-65ac-4673-bf3f-cb72235e7f16@amd.com>
Date: Tue, 3 Jun 2025 17:01:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] drm/amdgpu: track ring state associated with a job
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250529200758.6326-1-alexander.deucher@amd.com>
 <20250529200758.6326-8-alexander.deucher@amd.com>
 <179a37aa-7e6b-4870-848f-c3ee3fd428d4@amd.com>
 <CADnq5_N_0Wzjm8vCoboqe-8EuMcpkBVwg_=BVy-V3XbM=rHqVQ@mail.gmail.com>
 <d44d1df2-bd9d-46c5-96a5-6694ae4ad0ea@amd.com>
 <CADnq5_NNYfG4cRm0t17yFz2vHdq=fj0=Kx2tReK0h4obp4G2Hw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NNYfG4cRm0t17yFz2vHdq=fj0=Kx2tReK0h4obp4G2Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0cc43c-e9e4-4ebb-cd5f-08dda2af78eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHUvNXIrem1sbWNKQzNtbENLYStPUkErTkMvQVRWajlnb2NhRTc5aXhIeGJJ?=
 =?utf-8?B?c1h6bDZtL0Y3YUZoQXdWKzE4UEUya2Nxc05YN1RVSm9vKzVOQzJZeEZENEw3?=
 =?utf-8?B?L1k3QjYrZVlnMzF5K1hMZmZHejdBeVh3VkQ2Yk9zZ3BDcURQTGtRV1J3T0V1?=
 =?utf-8?B?UEpnQVhFa1VhVEhyUFB5dmxrZXgveXgwclV6UENFMVR1WmhQL3lBc0pyL1hT?=
 =?utf-8?B?UnNyS2hRT3BLdldvZVl6ZTVmcnVicktveStmbHJkeGNCckhJL3lDV1g5T2tC?=
 =?utf-8?B?eGZlTDFMV0ZYMzVlUzVBTDlUMVB5NVFPZHgvMkJWSVFhOWRDRldnQ3Eyd2Zs?=
 =?utf-8?B?ZmFEaFl0UzZSMHJxUHR2bE9kWklxMWtKUzk0Q1JER3l5K1p5U1hBWGNUV1FQ?=
 =?utf-8?B?VVFQMGlTd2RXbHpzcW1EUGk2T2ZCTk9lZnBMUVpFdHF0bitLejZpK0RxMTZX?=
 =?utf-8?B?aGE1dVV2KzRlN25Bb2pJdDZ2MjZNSDRxbVN0c0kzRzlIVWdjU3RrOWN4TlBo?=
 =?utf-8?B?T0FlTjdKTkNYZ2NwREVQQWlmbUdHZGhNQWN2TWNFaC9Vd0sxM2Nqb3hpYWd6?=
 =?utf-8?B?Y3Y3YmVMVy9oUGsza0d1dW9SNUFwbVlqQkxlWmJrd0YxOHcvTzJ6TTExSWlB?=
 =?utf-8?B?anM0YVNWTjQ4THNmVktWbW5UZDJBTE9qWjJYTlhYSUhxMTN5ZkpLcXpCdDFI?=
 =?utf-8?B?dUdYZ3dEWFU4djB5ZkhGVUtGN2lSV1V3enBxRE9KNURsajFpVWVER1ZDclda?=
 =?utf-8?B?REM2TW10OVd1V0tMYVE4OUNvQW0rbEhDUEdpTTNnaSsxSTBnV3h4ekVmRXNo?=
 =?utf-8?B?QS9aUlpRdXlpUDVjdVNWc0E4NmhaRHVCeEJIME8yWDBJV0FycmZBQVRnZnVX?=
 =?utf-8?B?dElQWHVwMktpd3UwV2VHM2VRU0lCRGZyd09SWU15VnhDNmhWY2pwR0lHakJl?=
 =?utf-8?B?MHhyZXJITXV6QU5ZMms5Y0p5TDVXbG1VWTE5WWpDODlCejlKKy9XTlpMeW9B?=
 =?utf-8?B?ckgydEpkTjFFSCtBMFpINS9yVTJ4UEpTVjdmWUU3YnQ2TWFPT01PNVhoeUJu?=
 =?utf-8?B?Y29tTEJKbis1OUhiQUZhLzVtajJ2ZXFWZytRdThjdTRZbHZrWDlEeDV6NklJ?=
 =?utf-8?B?aTRTajBJMmpuNGlNMjlZY1FHR0J3V1A5MHdzUldtNm55cFJ6L3dCUHVqSUJq?=
 =?utf-8?B?OG1ZLzQ3WEtOdVVSMURLWHRMRkE2bVk0QlJUWU84dkYwQXAxL3Bvc1JMSnBV?=
 =?utf-8?B?QXpjZ2twNmF4bDJ5RW5pdTN4S1RqVVhnbit4aHovWTM0TkpHa2hPZkd1Vjdy?=
 =?utf-8?B?Qmg1WGdkMVdHbzRPMjh3cDRydEZMOGZiZVJzK2l0dzlGQ0hjNXVxSWFFSmp0?=
 =?utf-8?B?UXNOb01UZGh5K3NUVlN5K0tzTzJIaWt4emQrZlg2b0FCUTVFZExrbml3eFJP?=
 =?utf-8?B?OXl1NllVV2hXdjRsWU9qdi9MT05LNGJVUmdFbDNUSW00dk1jQnpNV0xJY1p2?=
 =?utf-8?B?aFFtTGx0QVdtQzU5WEowMko5UmNvSFBaa2NoZHFtdmNwcVl4cmlDMzNyVW5W?=
 =?utf-8?B?clZSUTI0aGViOFR4My9MQmJXaDlCdVhBUzZPckxGSkZOU3JEY3FUVDRlQTFt?=
 =?utf-8?B?RTdxVEdzRWtqaWFaTEpkYmU2MHVadW80OUVTWGxCd3RiZkR6MVFYZU9yTy9i?=
 =?utf-8?B?NVJUeVl3aVI2OS9mM0dvbFZjUXFHajNFT05LNy9SVEZkZU1ZMU9OcDdWUFBn?=
 =?utf-8?B?SVNXUEl3UkluV3RvTFlWT3pxSnlOTEsrUDY4NFNwZ3hYcHdwTWxmTWRqbEpU?=
 =?utf-8?B?NS8ya001aUM2cWhBaldDeWdTSFdLV2pNQU1EVVhtWm1Yb1RmTXFhQnZMaUg4?=
 =?utf-8?B?NEJnbEs4N2ZzN0lrUW5kUlJpSGtOSjBEdHRPNFZjTGo5aWttY1ZlbDBpMXUy?=
 =?utf-8?Q?oiD0b5xqppM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2piQmkzVUk4RktxdTZHM1NGR0dIWklVOGFNWHlmMjBLaTBZL2hUcURoWVUr?=
 =?utf-8?B?NUVjOE9WcHdxc091b2dUa001MkY5MjZVenFIZFlUak9XbHJubHYzM3M5VE8x?=
 =?utf-8?B?eU45dVZHbTJCM1RRaUNTL0t1QlNlSkRBUzg5dS9WRUFQeUFxR2lnNFY4Tmhh?=
 =?utf-8?B?ck5PQ2tvZi8zeFlGSU8yQmF5RWZuWGt4ZVZBSGRnSUhXVFNqY1JoQktDQXkz?=
 =?utf-8?B?RDdPOVBHR2txeFRpMHdxSURYRFA4N09mL0gxaFpuVEEzeHUxckVsU1RlUW5K?=
 =?utf-8?B?VzlCdldCOWpJRnlJbG80a1dTU3ZTdUpGS2IrcDNEcTdQOHJ6RFNPUTlxMEdt?=
 =?utf-8?B?L3ZpN2U3cEZZZm42a2hLUVByTWgzT2cxaUxQSEpvdlNaMmtUcS92SFo2SUNk?=
 =?utf-8?B?Z202S2liMXBUOHQ3dm16b3V6eFhGUlpRZUdWaUFHYjBWSEpXRVpCSm9wK0ps?=
 =?utf-8?B?UFY3a2NybmNETjhXUjdsdDJ5c1NGYy9aQklvWHAxL1ZmR3dJN1k4UHN1RXhL?=
 =?utf-8?B?MnNRbUpTTWlXS3lYYkJZSkFEZEtKallJcDhoVnJYTS9BYWVvUVQ1U0lVTzhx?=
 =?utf-8?B?alU5TG5PalhmMCtwUFY1M21uUDZuQm44SFlaMUorKzZjYnc3aE9ONjdQTlVm?=
 =?utf-8?B?U1hya3hpd1hhamlGN216SzNJc1RFMWhMeG9jWE9sU2FNSlYzVk9nU0VoRkRH?=
 =?utf-8?B?SmlGbFM1N1FYY1QzbjhoYnFrYkx1Zy8rNkNvNGsrcCs2RldUSitSamhNTDdx?=
 =?utf-8?B?NFFDTVVPVnFqeXRBVmh0byswUjExSXNzSzdrWFJ0bkMvNG9DUTVSZmowVzRK?=
 =?utf-8?B?a3B3Vklsb3BOa3EzRnE2YnYwMDNXcGtNblNrUGJxZEMwQ2p0alpIYzZOL1pq?=
 =?utf-8?B?UjRKaXE5NXYzR0ZSdFl0MVlnOUhTK1JBQndZQVFmNHdDQ3VOeG4zaUgwTlc5?=
 =?utf-8?B?aWF0a2VzQmZjVWRkNmZFRDl5ZjN3eFV2S1hYQ3RxSzJWVllDYWprVFFCclJ0?=
 =?utf-8?B?eVdjcEEwNm00NHpMRFpKYVhDbG5ZaGI0aDB3bEJOTkxZUHZHKzJJdGtLS2JH?=
 =?utf-8?B?SDdaaEIycTN2dHplejB5bTEvQURQVS9kamt2NnBJb2gwY2hvTWtLRWtScG5O?=
 =?utf-8?B?Rkp4R3VOT05najQ3ejhrMVo5T0VKcU44RW1FN0tURDRVeGdiRjAzTHdzWDZm?=
 =?utf-8?B?L3NNMVAraFNiREJXU2V6WE1yY1I5RTh2TGg3R2RDK0hVVG9HNUpQaHBsMmh2?=
 =?utf-8?B?TC9JK21jT3ZpQXpjZnhETlpzbkVyckw1OVVFUXlVM3lpc1JFQU54WjRTMnli?=
 =?utf-8?B?UmRqakRiUnlvVUlPckpyMmhQZzFvTTlES1VDSm9zT0tlU2k5SkRvbCtwM0F3?=
 =?utf-8?B?dHNGYUdtQ0JKWTRZWHlNWlI3R2FLNmJHTy9Fcm5HdDlSVGY2Z3ZkMmUydHVM?=
 =?utf-8?B?WjlqdlN3ajFBNVdYNkZoTjVpOGZvRmVEOENSTE5PS1ExbkhPVm01ZFMxRWcr?=
 =?utf-8?B?M0NncENsMmswSXFrR2g0RFFnSHBzb0VaWmpONzd1OE9zd2NLWm9GeXlMc1kz?=
 =?utf-8?B?ZEprOGt1UVFISWpId3dVYTRTdFB1STducXg4d3VETFlJMU1WWFNtanFCWXRP?=
 =?utf-8?B?TFc0U2hjUVc4RFJlRFRKYUl2WVE4SUhoL3M4QlMrZTRab2tpZ1NWSjN1UmM1?=
 =?utf-8?B?NUgxNFQ2QW1zUnhZb0RyUlgyU3p2WEpMRDdETE1PMi9LV2hrbUdvV1VGMm0w?=
 =?utf-8?B?bnpqWnV0WFdBU2JVaE9rSldsOWxjZTRZZkoyTGJlVy9ZNlZWYkJWMWdGWDFS?=
 =?utf-8?B?Z0ZCbEIzTXFUZzNhYjFkR0k3TUw2WWIwM24zd3ArankwUFU5aW9NVC9aSjhQ?=
 =?utf-8?B?RFAvSVoyTkdFeXFwTHBTNXNyMXpmeGNvMUsxcWRkb0RMTVk0a1JLQmVJZFVB?=
 =?utf-8?B?T0IyaFJWaUxvSkZsMTdlcC9RM29KTWNuQVNtN2lQZWloY0F4T0FXS0w4SUhP?=
 =?utf-8?B?UmdZaE0zeVptdUcxZGhsQmZNeXVIdDB1SE4vbVpaa0NtS2RIVDROVGF2V3pZ?=
 =?utf-8?B?NENzbTZBNWE4MENyVERZeDZpUU9xRWJYb0RJeGg5M1VJSkV0bVd2ZEtjaU0z?=
 =?utf-8?Q?MY4awp0uQT7xTUZjQ44rLNoQ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0cc43c-e9e4-4ebb-cd5f-08dda2af78eb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 15:01:09.3094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2tqujA5BtZRaXJ7/s0NyzBfSq0RtMJpzDcEQXaXEgxPcljwEtK83mlZdkXTKMqg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043
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

On 6/3/25 16:27, Alex Deucher wrote:
>>> I'm not quite sure I understand what you are proposing.  Is the idea
>>> to track all of the jobs associated with a particular process and then
>>> when we reset a queue, skip all of the ring contents associated with
>>> those jobs and signal and set the error on all of their job fences?
>>
>> More or less yes, I think that is what is needed here.
>>
>> A simple example: Unigine Heaven in window mode on an X server. Each frame usually results in 3 job submissions from unigine, plus one submission from X to copy the result it into the displayed frame.
>>
>> When we now assume that we can schedule 4 jobs at a time on the ring we get: U1, U2, U3, X1 | U4, U5, U6, X2 | U7, U8, U9, X3....
>>
>> Let's assume U4 hangs and we initiate a queue reset, in this case we definately need to skip U5 and U6 as well because they belonged to the same context and depend on each other. Only skipping U4 would certainly crash the GPU again.
> 
> In that case, we'd just reset the queue again, but I agree it would be
> a nicer experience to skip all of the jobs for that app.

Well, that is a must have I think. Otherwise problems only get worse and worse after a while and we can't let submissions run into timeouts over and over again. 

>>
>> X2 also dependet on U6, but that submission is from X and totally innocent and rendering garbage for the window content is probably ok considering that the application just crashed.
>>
>>> What about cross ring dependencies?
>>
>> For gang submission we would need to do a queue reset for both the gfx and compute queue to get out of this again. But that is probably ok since each queue can timeout on its own.
>>
>> We also don't need to track the jobs per process, just looking if job->base.sched_fence->finished.context changes should be sufficient.
> 
> Something like this?
> 
>         for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>                 ptr = &ring->fence_drv.fences[i];
>             old = rcu_dereference_protected(*ptr, 1);
>                 if (old && old->ops == &amdgpu_job_fence_ops) {
>                         struct amdgpu_job *other_job =
>                 container_of(old, struct amdgpu_job, hw_fence.base);
> 
>                         if (other_job->base.sched_fence->finished.context ==
>                             job->base.sched_fence->finished.context) {
>                                 struct amdgpu_fence *am_fence =
> &other_job->hw_fence;
>                                 // skip the ring contents associated
> with this context
>                         }
>                 }
>         }

I would copy job->base.sched_fence->finished.context into the HW fence when it is created, but apart from that yes that is exactly what I had in mind.

Christian.


> 
> Thanks,
> 
> Alex
> 
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Alex
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> index a0fab947143b5..f0f752284b925 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>>> @@ -91,6 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>>>>>       struct amdgpu_task_info *ti;
>>>>>       struct amdgpu_device *adev = ring->adev;
>>>>> +     struct dma_fence *fence = &job->hw_fence;
>>>>>       int idx;
>>>>>       int r;
>>>>>
>>>>> @@ -154,8 +155,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>>               else
>>>>>                       is_guilty = true;
>>>>>
>>>>> -             if (is_guilty)
>>>>> +             if (is_guilty) {
>>>>> +                     amdgpu_ring_backup_unprocessed_jobs(ring, job->ring_wptr, fence->seqno);
>>>>>                       dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>>>> +             }
>>>>>
>>>>>               r = amdgpu_ring_reset(ring, job->vmid);
>>>>>               if (!r) {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> index f2c049129661f..c2ed0edb5179d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>>>> @@ -79,6 +79,8 @@ struct amdgpu_job {
>>>>>       /* enforce isolation */
>>>>>       bool                    enforce_isolation;
>>>>>       bool                    run_cleaner_shader;
>>>>> +     /* wptr for the job for resets */
>>>>> +     uint32_t                ring_wptr;
>>>>>
>>>>>       uint32_t                num_ibs;
>>>>>       struct amdgpu_ib        ibs[];
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> index 426834806fbf2..909b121d432cb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>>>> @@ -333,6 +333,12 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>>>       /*  Initialize cached_rptr to 0 */
>>>>>       ring->cached_rptr = 0;
>>>>>
>>>>> +     if (!ring->ring_backup) {
>>>>> +             ring->ring_backup = kvzalloc(ring->ring_size, GFP_KERNEL);
>>>>> +             if (!ring->ring_backup)
>>>>> +                     return -ENOMEM;
>>>>> +     }
>>>>> +
>>>>>       /* Allocate ring buffer */
>>>>>       if (ring->ring_obj == NULL) {
>>>>>               r = amdgpu_bo_create_kernel(adev, ring->ring_size + ring->funcs->extra_dw, PAGE_SIZE,
>>>>> @@ -342,6 +348,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>>>>>                                           (void **)&ring->ring);
>>>>>               if (r) {
>>>>>                       dev_err(adev->dev, "(%d) ring create failed\n", r);
>>>>> +                     kvfree(ring->ring_backup);
>>>>>                       return r;
>>>>>               }
>>>>>               amdgpu_ring_clear_ring(ring);
>>>>> @@ -385,6 +392,8 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>>>>>       amdgpu_bo_free_kernel(&ring->ring_obj,
>>>>>                             &ring->gpu_addr,
>>>>>                             (void **)&ring->ring);
>>>>> +     kvfree(ring->ring_backup);
>>>>> +     ring->ring_backup = NULL;
>>>>>
>>>>>       dma_fence_put(ring->vmid_wait);
>>>>>       ring->vmid_wait = NULL;
>>>>> @@ -753,3 +762,40 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
>>>>>
>>>>>       return true;
>>>>>  }
>>>>> +
>>>>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
>>>>> +                                      u64 bad_wptr, u32 bad_seq)
>>>>> +{
>>>>> +     unsigned int entries_to_copy = ring->wptr - bad_wptr;
>>>>> +     unsigned int idx, i;
>>>>> +
>>>>> +     for (i = 0; i < entries_to_copy; i++) {
>>>>> +             idx = (bad_wptr + i) & ring->buf_mask;
>>>>> +             ring->ring_backup[i] = ring->ring[idx];
>>>>> +     }
>>>>> +     ring->ring_backup_entries_to_copy = entries_to_copy;
>>>>> +     ring->ring_backup_seq = bad_seq;
>>>>> +}
>>>>> +
>>>>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring)
>>>>> +{
>>>>> +     unsigned int i;
>>>>> +     int r;
>>>>> +
>>>>> +     /* signal the fence of the bad job */
>>>>> +     amdgpu_fence_driver_seq_force_completion(ring, ring->ring_backup_seq);
>>>>> +     /* verify that the ring is functional */
>>>>> +     r = amdgpu_ring_test_ring(ring);
>>>>> +     if (r)
>>>>> +             return r;
>>>>> +     /* re-emit the unprocessed ring contents */
>>>>> +     if (ring->ring_backup_entries_to_copy) {
>>>>> +             if (amdgpu_ring_alloc(ring, ring->ring_backup_entries_to_copy))
>>>>> +                     return -ENOMEM;
>>>>> +             for (i = 0; i < ring->ring_backup_entries_to_copy; i++)
>>>>> +                     amdgpu_ring_write(ring, ring->ring_backup[i]);
>>>>> +             amdgpu_ring_commit(ring);
>>>>> +     }
>>>>> +
>>>>> +     return r;
>>>>> +}
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> index b95b471107692..fd08449eee33f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>>>> @@ -132,6 +132,8 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>>>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>>>>  void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
>>>>>  void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
>>>>> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring,
>>>>> +                                           u32 seq);
>>>>>
>>>>>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
>>>>>  int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>>>>> @@ -268,6 +270,9 @@ struct amdgpu_ring {
>>>>>
>>>>>       struct amdgpu_bo        *ring_obj;
>>>>>       uint32_t                *ring;
>>>>> +     uint32_t                *ring_backup;
>>>>> +     uint32_t                ring_backup_seq;
>>>>> +     unsigned int            ring_backup_entries_to_copy;
>>>>>       unsigned                rptr_offs;
>>>>>       u64                     rptr_gpu_addr;
>>>>>       volatile u32            *rptr_cpu_addr;
>>>>> @@ -534,4 +539,7 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>>>>>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
>>>>>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>>>>>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
>>>>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
>>>>> +                                      u64 bad_wptr, u32 bad_seq);
>>>>> +int amdgpu_ring_reemit_unprocessed_jobs(struct amdgpu_ring *ring);
>>>>>  #endif
>>>>
>>

