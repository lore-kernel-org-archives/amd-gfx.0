Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEB4CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE6310F599;
	Wed,  7 Oct 2026 13:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QrgKV9H+";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE3610F599
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsxFEe7VijJG//fNDbVAA1ofnAgAuCr2/L4oajaQLAzIjd6mgE1iL2CTJOnCI8ENNkux9xyto0KRoDx3uzYAQPBeeFUNblkqQXEtLUJlHSXy2zclKaUUvlvgo534rwKvtGrAu8pGEwrjES0r0u1AyLEB7i/fULjCREjd6jVJsGJl49ydcrnbqdJGUpBPt8MEmJXlCjHYOzrUR91VnqsFiDWrvyL2iGjM9ukVRAyUianFi2lHe6zetrxG+AqCYbzc9051k3XWPi8cDKo3Srv6lD7qTAd3RjMYs91WiN4QbNGhfGpcf/U4tCD34wHd8MA81gZIr6sG1lv+b/k94d4Y1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzfoMMOzR9qJffppO2tPHhdQk6dyJ4MqtnufZEzfdpw=;
 b=D5Dl2ZSzV+puj0Opbc2rjQhjWbig9LKATUwf+KK92zO53wZcBfWS6eAF7ue4I49ODzwKw59Ort09KAD7T1JSvfWgKZ/14wJVdyfu3kY+CbVNoH3Fie1y3J6+2zYOAKEUdPM09a2dq9e1kfRb3TblLMHbzl55N+3eqdfJuFkjVOjQQU/YRluvhvhfNkQO8N8rLoRfuDjMu7VmCK5H/+/GUDmMxYRGrQulDJgqzFP0ISEmNCTSoMQub2UIpv1GL1Vsp/mWsAyfyYDO64FRZLmZUK5uECIBxO26VwU0pmptK2WU7AUjnI5fPdylhzK4LIyXVJNyr9IVYrdGKn18V85g3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzfoMMOzR9qJffppO2tPHhdQk6dyJ4MqtnufZEzfdpw=;
 b=QrgKV9H+V618QvIvy0rkeNFrrIeaMPpZ4BsSbY7pmTZ7sFtVJbehGpCDodPRtoy2mTP62Q+ht4s5YTG1HTzN1LDhvxekQMlpSywzI117jXOTwwxALKD6F4Oq8Xn2VqAq1goWJHcl4hZVkIeAiXjEIGDJSUuihj/ZWdLoZrCnjTo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:18:45 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Wed, 7 Oct 2026
 13:18:45 +0000
Message-ID: <df801ff6-8289-4e24-a1c0-3b5d4841554b@amd.com>
Date: Wed, 7 Oct 2026 18:48:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] drm/amd/pm: report the default performance level
 after a reset
To: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Felix.Kuehling@amd.com
Cc: Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
References: <20261007122103.4019578-1-Priya.Hosur@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261007122103.4019578-1-Priya.Hosur@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fce3e8-1980-4d72-f002-08df247583df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|11063799006|260925021911599003|10067099003|56012099006|260925021311599003|260925022911599003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: zLIthvMg6dyKZv6+bGyQmN5BHJccDkgO+tUwFZXo9bj2ZNbPvwV3vvHvhyyPsx0LxwLoxc0U8n3wT9JkNpZeLf0E5S6/47XlFTZfs7yhR5Vm/8/omhB3oJMr43gjqVt5Ph/PsvT/UkIe7jCtoq0VydfimSzp62h1IS80RiajbEBDrQHXbqtw3t6lMfvGnwblA8GSsfl7aEIC9u1pFXgdHfwLHP0rwPL/zxMTSjgME3pm+lFyMbml7uQrx0cQB1xpiLMgjku+7WI1bbppqE7Rz81ew/u0aFQ7ugYYgJmAJMh7NzQDczANkPAQvsyhfv6zEvUABsP+JrmavrlIVzl0c9yKoa+TUbyyiLyLf8kZXN4XdK+fQIzS6MNdJrkcM8iyG9dSEcKN1sIKxde0eX/2k5prrLZ215APHgH1uKmXwhXZ80wMH9q8hmxk3n3Cs9U4CiHikhv/oYgvSBpn2WS+GjbXkWKlr6+ByDLYrIPHOWnoM/+2OfyaFtdEmRvXsdtvuxvlbCN0YAX6vTVYdoExZc0V+SL24o8LMxzMxk0aEAZmB2Cwf7FBRAkgLdWldA6oj2T1TQ/3g5cmjPKS4sP68xgr5hlpjxJFoWSXo+LL8mEKsDAONazQMLwiatfyRhSRdhT2BWcy+80eyog4DApdp6yQACWn/TH4YZupQ4eCr/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(11063799006)(260925021911599003)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpZT1h5amtob1BSNURpcnEwNkcrR1hhMm1TekRvK3JxU0lqYlE5QmFYTFlF?=
 =?utf-8?B?bXhOSFVVei9QbnBLRjZwQUJHNHdOK204bFhmR3hIRG4rLzd0TnppY3BFTVFz?=
 =?utf-8?B?OEpRNDNoTGpPbDdjVGNWUjIvRndEOGVGazNUdDdvSmd2dDBhaEFURmgwb0lE?=
 =?utf-8?B?MmJrUCtyb0pla3lZbTBFQnpMREt3akZMaFRRaTM5SjFZNkx0a0plS0hFUllQ?=
 =?utf-8?B?NVJWNnhnbTBwQ2ViRWtESllJTEVRaHRLL3pYcU0xZTlMNlVFcmdxWWRFREoy?=
 =?utf-8?B?bUw5UkVWWllYNU9Dblg5aDlJeDM5S3JnakxFaTZoek1qbWE5SnFXb1VxV2d1?=
 =?utf-8?B?TDBmOTQyT2ZpZnVHL0Jhck5YUDc4dkIvRzQ3amU3eTRLTzh4N0FHZG9SL2dC?=
 =?utf-8?B?RVl3OWtueEZ1enc1MTF0RkJiZWh4OXZKNUZ6QjBTNkdhMktpbkdjV2FXTVdr?=
 =?utf-8?B?eDlXQ1puNUNaMCtZOE8yRC91SG5DV0NaMlB3RUJIODd1SWJzS2NrdXRpRnFS?=
 =?utf-8?B?R0Q1UDBmU2JlWWxLVGlFZ3JPNnl4d0ZURndnNmltMmhObEorUUtmbVFjbUpz?=
 =?utf-8?B?c3JlWEpzaUhJeTkwTUR3aDEwYmFDY0NzT2FHUURwaDhHMFdhRm9FUTFyNy9U?=
 =?utf-8?B?RVk3UVFYelBzOFgxSjlnQmRhcFpwaVFYdWVVSG4yamxTNHlzMTRZcjJTa2FR?=
 =?utf-8?B?VTFRcVpMZXpFR3ZES0RXckU2anl3WEl1MVhEZHlQci9MOTZJa21PS0ZxRjFB?=
 =?utf-8?B?V3UrWS92UjFKd0NobkhsQ0tXbHpWaTZ2N01KZjBWZDJFbkcveXBCNURQTTJk?=
 =?utf-8?B?ZUlyWTBKZXI5aFp6L3dHNHZqcWcwR29vYTlZcmxuTG1jNzRXMDNxL25EVDZO?=
 =?utf-8?B?K0pSYVVKTTdZU1RicEZqN28yV0Fpb1ZaTVBVUC94VTZyQ0M4V093TkZYUzR6?=
 =?utf-8?B?SDRNRUw3MGxwOEh0bm4veE82ZGU4U2VTdXhhb3IxTFc4b0xLYWh5MVphV0Nu?=
 =?utf-8?B?OGdLWS85KzBtUlhuN0RjSlEzUWdZMkhJL0QzSFVmUjQ4VlFWZDhheDg1Wlgr?=
 =?utf-8?B?NmdmaFJackVFT2crMjRWQVQrTkFHN3c5OGR2TXdCcVpOTW9vMmdWWG9QcXMw?=
 =?utf-8?B?RjhYR01yNEdnMGl4SWtHK3pWRGNZcU9VQ1d4TGh6S25aWFVyVm0zOElxa2sx?=
 =?utf-8?B?QmFIaHZvNWNpckloZ2NKWmh4VXhuR2xIQ29ZY3VjOUpNdVFRL2FZbFhPam5Q?=
 =?utf-8?B?dnQrQWNQd1E1Zm1KcU1MYUpNTkJLUElCLzY0V0o5Z1ByUW9oK3hVdDVqQStO?=
 =?utf-8?B?QW1qS2lyWG9talhMWUF0MVNpTnovbDJXVHh5ODg4c0NKdGNKV2EvdVNIVTl6?=
 =?utf-8?B?cDdQSnp1eFhIaXJka0pOTER1QmJSVzc2cXJXYUlpdDZIRGp0SEF2OFRDc3lX?=
 =?utf-8?B?bW1kTkl3VEs0eHE0VFo5elI3ZHhhbnBKNDRMQk42dVAyTTkzLzB1NytvMTFE?=
 =?utf-8?B?d0lzdFoyeUFzeW80ZE9PeXpsUGFuZENrdU1aWUQ4OWszOTYvZUcxcFM5RzZ0?=
 =?utf-8?B?VXZyT2llOXVLeS8wZjRVK1VqME5YT3llYlJKMlhrVStkeEUzSGtaN1E5TVJy?=
 =?utf-8?B?cjlCem1xcmtEYk9EcmoyRXYzb090K3FvalVlakFiM1FPNGUyM3R0K0JPM1lU?=
 =?utf-8?B?MXlTQittYVV3ZXl4S0hwL3djSHFSMHNXYXM3YkJVdjJ6L3ZDSG1YcTJ6ZDF6?=
 =?utf-8?B?TXZucTlwdllBR2YwcHJ0WmE4M0c4Tys2bVpIbURpR01iQmxoenltUGJ0Z0NP?=
 =?utf-8?B?QnJoVTF0dFkvejQ1aUthVUV2cHlyVTIwMURBcnBUQVdtaVBraGF4Ky9XR1FT?=
 =?utf-8?B?VE1oWWcyZEQ5alZDL1FyWjR6MVpNamFWZUZaZ2tZZ0ppbXlwK0cwdkJwQUpR?=
 =?utf-8?B?VnZMYndOakVCOGsyNWFEYUJZenJKaXA5V0IvRCtBbXBCdVpkUGtSd241WklZ?=
 =?utf-8?B?Z1NQc2wxSlBnNU1tTEZ0bHUvODJ5M3g1S2NMY2VMSGJZaHd2ZXVtRUJ2OXBm?=
 =?utf-8?B?bVVzYW5CN3cvczAySmxUUmlOdm9PMnRHNTUzU2RkOWthbGxNMXVJNUpUUFI4?=
 =?utf-8?B?K0EzUTVYVUxOYlBxY25ZRHRZUTUxclZjME5ZYlJPcGQ1TXM5RzJRMU1SaDV3?=
 =?utf-8?B?YnhOemxHeE1MRmk3Q3RTbUFXaG5MdkdKTHJKazBveExzZ282Y0lRcXVTYTAx?=
 =?utf-8?B?Q0lMejRjdkNsU0s1dCt3ejhmMmp6TnluR3hDTkN2ZEMwOHJ1RVE2UTMxVHBP?=
 =?utf-8?Q?hOdFJTIsYyFCbm0TSt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fce3e8-1980-4d72-f002-08df247583df
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:18:45.3884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4o55Z21SCRJcnhtRBIhsgD1yab82QSDB7JDjVHkSMqEqZ9XjZ3wYUtrySO+cyMp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
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



On 07-Oct-26 5:51 PM, Priya Hosur wrote:
> After a GPU reset the level reported through
> power_dpm_force_performance_level no longer describes the hardware. The
> reset reinitialises PMFW, which comes back on its default curve, but
> smu_dpm.dpm_level still holds the level the user forced, and that cached
> value is what sysfs reports.
> 
> On an SMU 14.0.1 APU this shows up as gfxclk dropping from 2.8GHz to 600MHz
> while sysfs still reports high, with no thermal or power event involved:
> 
>    before  level: high   freq: 2799000000
>            amdgpu 0000:c5:00.0: MODE2 reset
>            amdgpu 0000:c5:00.0: SMU is resumed successfully!
>    after   level: high   freq:  600000000
> 
> The stale value also leaves the user with no way back. Writing the same
> level again is dropped by amdgpu_dpm_force_performance_level(), which
> returns early when the requested level matches the cached one, so only a
> genuine change of level reaches the hardware:
> 
>    after reset            : 600000000
>    re-write "high" (same) : 600000000
>    toggle auto -> high    : 2691000000
> 
> Since the reset often goes unnoticed, the machine quietly runs at a fraction
> of the requested clock with no indication to the user.
> 
> The patch resets the cached level once PMFW has been reinitialised, so that
> it describes the hardware and writing the level again takes effect. It is
> scoped to reset recovery only, as PMFW retains its state across s2idle and
> the forced level still applies on resume.
> 
> Tested on an SMU 14.0.1 APU. For each level: set it, trigger a reset
> through debugfs, then write the same level again.
> 
>    level          set        after reset    after writing it again
>    high           2691MHz    auto 600MHz    high 2691MHz
>    low             600MHz    auto 600MHz    low 600MHz
>    auto            600MHz    auto 600MHz    auto 600MHz
>    manual          600MHz    auto 600MHz    manual 600MHz
>    profile_peak   2081MHz    auto 600MHz    profile_peak 2201MHz
> 
> Every level reports auto after the reset, matching the hardware, and writing
> the level again takes effect in each case. profile_peak sets a ceiling
> rather than a floor, so its sampled clock varies with load.
> 
> Suspend/resume is unaffected: high at 2771MHz before suspend, still high at
> 2799MHz after resume.
> 
> This is the only configuration I have available to test. The change is in
> generic SMU code, so it applies to every ASIC going through smu_late_init().
> 

The expectation is driver to restore the level. User may not be 
monitoring resets.

Thanks,
Lijo

> Priya Hosur (1):
>    drm/amd/pm: report the default performance level after a reset
> 
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 

