Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98824C19F2B
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jul 2022 16:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB57B251D;
	Wed, 27 Jul 2022 16:27:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8919372A
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jul 2022 16:27:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4439Q1GIVZf32FAR4q66tp7ubftR61dH0DtKWap0wSZRIqgsfuOYJFlKx213llYqh8z8EvSMB6U55pXVizzqAeYiFVvESytg2OiK5Qdw/qA7CMxbwNTWb14nBmVExmNAxRyJbmgvq5QduOiQ9ntrtYIDjT2apUVKQdr2kaY1VsQjU/uurCYc9GlkZ8nP4fupFvndp/xjW6Ms5UDD21qs9XWXVFz9BmWCKXD8hVwTBcBQkWNxjh3W2Dh/dTgdcDYH5rVX9HE1z5MJl15xtUEVFMxGBEB6NZVed2tagEgG4b4IfniquwoTD/U1stZHRlrgQEWseOqZmTAcNDiHxrBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ST4Aoc9ogd4BSSsNwuLu097fSz01kHjXwl9t7PuMqX8=;
 b=n0xSNHQHKBWzC27iZOgb3Ob2TzaAbTAxSAnpGwvLv1vbsRyTrXXbaiL1s4JBOcDboeeLS2yPBAWRBQ8VVr8I13OmzPzXs9E/BOV7v7GJ0fdL1N2p5pVKI7EOb6gv3+VpNt9f3FEo2pMZl5RbQLJXAvT/8xafnVTWVNZODGFZ4+j5+FoLEy1a2qxIn6BEstRamWwDQbZ4NhwSCryUe9U6iuMCJrxBe28vv4W12aESo92e4DMFo9hmb4LE5gc4YgKmr5brGpMyjPjrWuYAv2F0rH4ApO/Tq3oU1SB6Cw7U9DgBV3xrdHEZNFh9koZCHZqjFcneoSfaPJjcSWwLQUPUsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ST4Aoc9ogd4BSSsNwuLu097fSz01kHjXwl9t7PuMqX8=;
 b=RLcPvmJFYHCSlHFzJkd4IXGgFnob30eawU+RMpiPhL8blra+LVC93sPQxbRDd5OTlG6lvTzTB7zJjwHR4uC437w+nwQ0r9aPsInQaMN7o1LC9hBEsLApCt/A+7HBKGaF5GbTrtxISk5fvZ7SEcTRGPOtXA6q/5YZ+oI/thatk9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 27 Jul
 2022 16:27:05 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5458.024; Wed, 27 Jul 2022
 16:27:05 +0000
Message-ID: <f35f5743-bf62-cc82-3623-b1b09b940cca@amd.com>
Date: Wed, 27 Jul 2022 12:27:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/amd/display: Reduce stack size in the mode support
 function
Content-Language: en-US
To: Stephen Rothwell <sfr@rothwell.id.au>, Alex Deucher <alexdeucher@gmail.com>
References: <20220722175617.2060949-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_MVQUK4cqD8mcOQTupfVR2c6siRyr87pb=BzRgvUG3sQw@mail.gmail.com>
 <20220725073646.068c9cb4@oak.ozlabs.ibm.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220725073646.068c9cb4@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR01CA0017.prod.exchangelabs.com (2603:10b6:208:71::30)
 To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68354aca-5cff-4548-6fb3-08da6fecd7df
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNgHA9nDAgFYklmoviP4/BAVY0euuUlMi0fX6JDQGvefd9dbTBlThURDHiY42EY/p5G4GhDws+LIIMgIGjqmM+SKIG1013lDuigq+oyKOuC1VNhwaBcuHNMaGCSxPDxcZ7nhdQ/i9sBxhpZnzmtnaJPuGRKMqn4nESHhTGk2IcCw+qv97pXq+N/hJ9S1i3coLzVKRrOupwJ0OAe2Kz++NbojUHxKrSWkwpm7oZDcZ+QRB5X8AQ1ExOM2CSWf+sJQaP2PdAd/+5dX0O4W4ta/MAbZdRfiCL5wFjN+N3VRPGW2AbCsbTNlBmKgYzoq4+FMJpvvrPTbbK6KLmGmsKSXJJIbLaAOVtsfXztfeZbDoOV8liRfEoMZfr/UBsp4CxBxcFc0eK4Wiser6sLwNARSbndNo9z0gCGXcqXCnkdTlbGAaWX4QgBek5hKBUyY9iPqZKjWXewSuD85eCr6jr1qWaOPplwhnJZUMpHU02aOL4kBpdtv4nhhk4cjqQhDCsZZUJBVNmirNFRJ5iHfKhgx0xr9fc7JzNJcIVHkn41vBUtfiAA75y0/SJRZsIDzdIZZs6yrESYV6sEKgTU6nAI2cJAFp1npHWpsNscMSfSyPCPhGf5WBK/CAH0Hh0nal5v3bqxD3x9yApH6Aa3zM8EMjgiO3Ian6nvg9Jf51XywFb0UW1ut8642Jn9HwKwneuyNvM60wKaylhjN2qSGU5gC6YnXoK4d2DKbIvW4y6bwTBQVw8wN9HQ4KQdXEl9VY9sRGVTGuMnQoeZ+ysJ8iX8zCi+yEjeypTLmX0z8/o7nbHSMcXijcH/1m271HMYmbilF65yHBdreEvDYMWZZjYpM/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(66476007)(8676002)(66556008)(66946007)(4326008)(83380400001)(19627235002)(2616005)(6486002)(2906002)(186003)(41300700001)(36756003)(6512007)(8936002)(26005)(478600001)(53546011)(86362001)(31686004)(110136005)(316002)(6506007)(38100700002)(5660300002)(31696002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhvRWw5ZFFnTXJuY2tubUxmRW9wSzFnYVBEbXdBUUE3bXZlS1hXbitlTG5J?=
 =?utf-8?B?Vi9WYjFtR2wxRVI0Z3JFS0hEMFhwR2UvTkNVT2ZLcFh2SUVzdThEN3FhRGNy?=
 =?utf-8?B?bTNjaEZ6ZGM0UmpwcThxRHZQMVFjUXNsZ0ZGOENFd3ZaVThmM1g5YkJKeGpm?=
 =?utf-8?B?V0xwVVFBT2FQaHBjS3JJS0NuUDRrMEc0YWVQdXpHVzV3UTVRbiszQ2xuaVpx?=
 =?utf-8?B?ZG9qaW92YTNiUnZISFVqcTNiTWt2V1lSTDJVZlNyRDlwblM5NnVRYXVBeVQy?=
 =?utf-8?B?eDFOQ1NmQzhkQUFjb1dPRGI2RlVXTEM0UHNDWWlCbG9XRzZvSnhOYjZMRllz?=
 =?utf-8?B?Q3NLRmg4TmNEdGUvZzhvUHIvRjIyekRERk81eHNzZXFhdkxSeXZVOFJsZnI4?=
 =?utf-8?B?ZzlXYUlVcEJqL2V2U3BFT3V5bkt5UHc3Y01hM2cxZDR3NUFLOTFGUjFnZkJz?=
 =?utf-8?B?RDRUY0IxZXpCeWh6UUZxZUp4WWUxR1NkZzJXVGZKRlBGUVlNSTB1RzY5R25w?=
 =?utf-8?B?K1pOSit6Z3owRUJrSUNmN1FYRHYvOENKWkxKWHJndWs5ZXY5K0N5Uk9iNUlE?=
 =?utf-8?B?T21LRTdxeVpySytYNVdSbEhFOGVnZFZleDcyYzJMaVdON3E2eG95V1BhTXhl?=
 =?utf-8?B?cVB0bDZMZG5SRy9vaUc5d2E2UW1XdTFIQzlBQzB4Q091aWc3T0Ira09XSGlU?=
 =?utf-8?B?Y3hyTlJLcENKcGJYUTFSbUZUSSs3Y29QdkszNHRocFBiS3orNU1GUzNsWjJ2?=
 =?utf-8?B?ZEoxY1ZXUG80YXZwMnZ1N0RkL2Q2dERQck9NSkg5WnpvSGZiRWI1YnF1QXNh?=
 =?utf-8?B?aFZjS0RTTzRWUFJySkFjQkJVWGNjZVdKNXVPbVR2QWNxSUhDaVdzTlZQQnYw?=
 =?utf-8?B?amJyOE9aZlFUUi80ZUowazltWkZGMU1QbVY1ZUhyZFdSaTVHQzZRZTZYRE8v?=
 =?utf-8?B?Um9GaWN3czEvbkp3TDBueDRMeTBSZXhxcjdLYzJpT1JjQk9YWklSbXlIQnV1?=
 =?utf-8?B?MHgxVkxrTndxY1BFWlhEbXZsK29UaVovNzh1V2V2bkxxWnVheUJsd1FSR1pF?=
 =?utf-8?B?R092MGNVVlkrcnBnNjZCY3JldTNRYlorMFVLb2xodkthSmRWbnEyTGU5SzF0?=
 =?utf-8?B?Sk91eTZYTytvN3JvS08ycHJyOEs2NTFiSTNaR1hUN2Nab0YxcVBTMkY1QmxG?=
 =?utf-8?B?ZVdnaHAxSWVrdGFDT2Fxa2dzKzZkYlVlNUJQb1lTcHQ2cS9WTDlWVnIydURF?=
 =?utf-8?B?MUNndVdLcFlBNFR5Zk5kdTFjSzN2cklaaFZjR2dGZnJoSHBndlZWLzB1dllj?=
 =?utf-8?B?dmw1QnpyMEc4M2ZiZW0zTGU4RUhwbnNxOU1CQklNMEtBSkpPRnZVWmZ6VHNF?=
 =?utf-8?B?NzJUWlAwU0NrZG00dmRMV1YxYzJJOXJncGQ4Si9oQVlxUXI5ZXJjdVZqdkNU?=
 =?utf-8?B?dUNpU2d4bENXZ1dJSkh1aWNocnM4cE5zT2t2MmwzMytxWkwrY2s5V2gzVTU3?=
 =?utf-8?B?U0g5WFFhL0k2enFON2pvd3R1bmMrZGlRcjdCRElBQjM1WThzRDRPMnNhWWlG?=
 =?utf-8?B?ZDZHNGprK3R1RVdLRkVhQmhrenRqRmt3NDV0M2x0VG5TNmJtcVo1VUR6aE5E?=
 =?utf-8?B?Q05CZi9IMytGdUsvS250QWFqcG53bWY4OTFxZkZKK2UwQS9Pc2V4Y1dQekFk?=
 =?utf-8?B?enpreTl1VGN2alZ3YUxzaWVOUmtqYVhrYk5TNFBvYXkzdm9MdCttWmZoM05l?=
 =?utf-8?B?UmNCZnZDaEU1ZzlieWlXTnN6clFUUGV4Qlh3RE1KNU9yRDg5d0tUYWtRMHJL?=
 =?utf-8?B?K21LekwwYzlPVmNvM0FYY1haWXRxNW54RjNFUzVIY2ZIa1o5dUxSeTNHcUFI?=
 =?utf-8?B?dlIrRU1QQjFnazV0ZXNBUnRIeXVMNmtmbjBMelY3TGFZMXVhTjNIRG1UUEFV?=
 =?utf-8?B?UjNyVUwzMXp6bUV0ekx5elBCK2pjaWZ5VE55NGcwOXRMN1FFWGJUd04wUTZQ?=
 =?utf-8?B?RGd3NTVwWGNFWFhIR3FzRHVRMzFhcjhiL3hIMnJRTHBTeGdlbFRVVHcvREMx?=
 =?utf-8?B?UDFld1lJdE02L29wY3AyVTZmRXpFL1pXQ3g4MDQxaThvVjVRdXg0Qzk3RkY5?=
 =?utf-8?Q?k7iNJP26gO5DbCAPOUNjaEB+/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68354aca-5cff-4548-6fb3-08da6fecd7df
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 16:27:05.3243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEeLnLRzZzp7mI2V0/a+yXbSWOGajLjWtuAirG+bhoq01HYO90DcJKnKV9r8JV1//kdmwTxM1SjmVJegr206Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-07-24 17:41, Stephen Rothwell wrote:
> Hi all,
> 
> On Fri, 22 Jul 2022 14:12:44 -0400 Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Fri, Jul 22, 2022 at 1:56 PM Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
>>>
>>> When we use the allmodconfig option we see the following error:
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
>>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
>>>    3799 | } // ModeSupportAndSystemConfigurationFull
>>>
>>> This commit fixes this issue by moving part of the mode support
>>> operation from ModeSupportAndSystemConfigurationFull to a dedicated
>>> function.
>>>
>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>
>> Thanks for sorting this out!
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
> Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Also, after applying the above patch, the following commits are no
> longer needed:
> 
> 987949933127 drm/amd/display: reduce stack for dml32_CalculatePrefetchSchedule
> 8f08cd32b767 drm/amd/display: reduce stack for dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport
> 5d526d124fe3 drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwath
> f6ceebcc7825 drm/amd/display: reduce stack for dml32_CalculateSwathAndDETConfiguration
> 
> and could be reverted (or removed).

Ohhh... that's nice!

Alex, if you don't mind, I would prefer to revert the above patches to 
keep things simpler. If it is ok for you, I can prepare the revert patches.

Thanks
Siqueira
