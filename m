Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB8FC19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 22:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0620491568;
	Thu, 11 Aug 2022 22:38:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A99A9157C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 22:38:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqy2b/agDWiPiXTymG0UiHNqON2A6IxoO2+iQROr4/pWdjWju/IImQ1Fz89W8+rnQ/r+lVa3GcbMKp4k5efYnkmddOG65/iILvitxIILBruLDRDSo9pS7ARo4Dt0UVMq6KYDSvXn6CtDOuIyviaxyUCsorM5Tox23wSCWYEK4zutkPlYgpmEP7MQp0nzb0M04LO1pt365zOuny5QZG8UJwqfL5RXYozvoivAny7Idt06KX5jZVeF49Ds8AmF4RM32uRoHWLgwBYG7xMf/YIib4tdiAwSKruu0e6LiFC7EMLpNaQTsF0tp553USBqdckSMjEtT9XKyoIgzH5I9DeIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pBmVURldxwHwXM7fHFm+NYlbpS84j54CJA75iYkAg8=;
 b=BxTpy1NuSU3RChoUmdtqicTOtUheXIbMu3V0/WII50v+B7zrOVvi9BXKRSHUXMv5MQBc1EgOj5DEcIwFFEGUZ6iC14GERwqhdsPJUNgJWQGunRfWZZ/RTD2skIjc9ZOEY7iDGwDCYdBnsTj74fcDvFJcDw/vJlKaOAr12+Xf08QGgWZxfJ+ugRQOrW93VRi7vZL2rU0nUBKkaz6j5OzYyfJG3n6QFgiMx3Ygg7Dwx/X1lrUpDVQX87Ca43SGDCkMjkezkW4d6h4AEkzlqWhHco4wNu1bWKWF+Ygz+XNl1QUYO1RvrfcpOcmfj54g+ZcMpNVUthbYkUZi/bdCZtu7Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pBmVURldxwHwXM7fHFm+NYlbpS84j54CJA75iYkAg8=;
 b=HYBG6kCAyW8sx61FBm19LzRO3+/JpDXp7/J6uPcrUFNPzRQ8OHwS6wyNZgys+ARyZZazy8jba6PY0wqGZQR3vzhZg4vFwIUIVwiTm0JyV+fv4DF2pofkwqg7vYnc5RmyhHK1Tbzlvg9cCkT9BfMRjr8ZAxZGnSk4oT5eFqI8b0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 11 Aug
 2022 22:38:18 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::399e:2e9f:fff3:38d]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::399e:2e9f:fff3:38d%4]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 22:38:18 +0000
Message-ID: <4f4d3b12-1013-00d5-31ea-1c9629f14e65@amd.com>
Date: Thu, 11 Aug 2022 18:38:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] drm/amd/display: Fix a compilation failure on PowerPC
 caused by FPU code
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220811195619.4155393-1-Rodrigo.Siqueira@amd.com>
 <CADnq5_PazqPD=EAE48DSfHR5G=ihz6CvDTvRZRJVDSvbpuAHTg@mail.gmail.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <CADnq5_PazqPD=EAE48DSfHR5G=ihz6CvDTvRZRJVDSvbpuAHTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:610:53::37) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f3e0628-4ae5-4a02-65e1-08da7bea2fbc
X-MS-TrafficTypeDiagnostic: DS7PR12MB5719:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Le5f/5DuZjLjfQoydbooG0skjFWtOYUTKPmklKWJ3jOwYepZx7mDFuIXmYeGjmfsRWZZkZ4JG+EJxMZR5sV1KQqxjDYvWoySIeuNeDNxeCui3lwKmGiFWhCknFnoXSP3NR+v1eoHEMh7E/KdG+U3VUTGGBWC2XZSq6opl1VXz7mHkD0SlOIVrXcINxDYu1YvmZr0EXMG7lo0HUXAboIywRaxcJCBwvds1f1bo9GFIKs3Go/FFpuma68edxYQXX+EsByhc7dU36yZeT+YZ2XwPrzBPYiDYHLuDcvOzCyhmJpejUDhD0bSJlbo2InlVxrsL2TaxiQYsFBXEQY0DefHh+O7VweHLhvJtsk/LNjKn8OCK5Rv2Q2c32aWI8qVpp7kCuQazkYliBZKwvwKz2JC2/sjnMaLcxDP+p6N7HFrDizGEDwaMqxGSeVFtUTfF235vik0ApIqltvlvRwCUYBH3wjltSbhObFXYrEgCl1mwNf8xGZssYU/t9IEL1cLT00aQ7ZuDK/FS2fIRo+pYldYQkTTd3mTb6jN/0GzlL1DVa1CZs8ttOJwx6nRAO+h8+rsJswl2tAletTUcLw/gZk3LcW91QJxbHUzhQ/Ndrwffm9RXoYYAsfwQUQgHwIo8uwVStOhmMnrgLb2VOxsRudqW1tlaSr1HUEgI2yiOK1ZXfmv3+sj1/Hvn4gLhpMwL3CGyyLb6mOYL0MrLhxp5UJd8BvbUtEvxgZGtwjyJQv5VFutRDto00rahJVfrUGCjjLGdW/JvUK5GRqrXywlNRceMiXCEuKIA6QXiTJiDxLOWUoTQsrlKK6/XhWeInoONCRB/JbXqHJp39uzanfVsJWFJAMFwiE+9uUWfz/+5k+flJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(36756003)(31696002)(86362001)(31686004)(6666004)(6512007)(53546011)(6506007)(26005)(83380400001)(2616005)(186003)(66574015)(4326008)(41300700001)(54906003)(966005)(6916009)(316002)(6486002)(478600001)(66946007)(66476007)(38100700002)(66556008)(8676002)(8936002)(5660300002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGcyR1JWTlM0WEVmbkMyUnNwWksybzhRU2x4N3A2eTBaTGt5SFozU0J3MWtH?=
 =?utf-8?B?QVliaG1YaTZvdzJLWnlDZUhXWm9vci9PVVFjeS9MOVhJVXVzV0ZYb0J0UXRh?=
 =?utf-8?B?SFVtYTJnUGVUaXVBb2FiM1UyUGUrTEJmcFFXQXZWOURQN0ZZZWxMVHVKdDQz?=
 =?utf-8?B?ZG1ubmVZK1ZyRVJsazRsUksyZmZEWDIrd2owMGMvdGlCSlpKZXlTbzcvaVY3?=
 =?utf-8?B?bVc1Z0ZOZWVnRk9FWVFRcTFpOGh2U2JneUFqdDVoMXdJM05GNG9NMUFWaEJ0?=
 =?utf-8?B?UDl0NkFkUGJEU2RaVjU5Z3ZUc2hHNDlzczFHdEtmdjl3VUJsS3hENGNYQUdW?=
 =?utf-8?B?NFE2N2lQdmpsRjh2ZzkyR3FsYjc0engyZzBQZTZEOWRjOE5sKzlJN2d6YkFw?=
 =?utf-8?B?TkZrTEIwRVFZaSsyOE0ySU5PZzZVWUN5K2cyK3BMQ2RIdG9xaUd5anlIM1Yr?=
 =?utf-8?B?QkNYWWdmNDhaa0RQeThQT1JMZ0xoamNiTHQ0OC9yOG5Db1ZxRDRFWGlIRGZU?=
 =?utf-8?B?OEJaekIxY3piL2k1VHBDWmd3ZDlaUXZ1b3BtVzdwcUpDcWx1dXA5Rm5tckxk?=
 =?utf-8?B?MHovTTBrYUEvbzFEaFpIZGovLzFBOS9GQUZGVlVmS0tSOVNNS0c2ZURrZ0R0?=
 =?utf-8?B?THBXNmtrZEVoSzNJNGdQTWJ5eloyNTNHMGRxWVV2SDRFWDg5T3pNRkVZTWd0?=
 =?utf-8?B?NW91bWxRdzdIdS9Xd1dyYmpZZTdhZkZOTnZTYnFKR29ISHVBQ0JGUWpxTGVP?=
 =?utf-8?B?T3RWcFFPa3ZpeWUvMXlUQUJIVndra2hiN0w2TUZSZU9kWG9WMUNnUldqRFk2?=
 =?utf-8?B?QkNrS2lPN2pINzVHMEd4a0xuRlZuZEFZalY2eTl2TVM5OUJCYkhnOFdobVlt?=
 =?utf-8?B?VGZxZ0wyOFNZbTJVV3ljWlV2WmJpQUtYbFFyV3J0NkUzT0daVTBLNU5pSy9U?=
 =?utf-8?B?WDdSUUtFL2FNY1NPV0FxemE3aVFWdGdRRkhtdVByZENsY2ZvOFE1eGxubVJY?=
 =?utf-8?B?clZhbmdWdjVySVJjbXBCazhObkwwcWpGT21NRk85NEJZamQ0ejgwZTVNL1dB?=
 =?utf-8?B?Q2VBNDNHZEJ5SmE0RWRtdDhJRE5XUkN2ZWNrWGpoLzRWTVR1SzdZOG52emgv?=
 =?utf-8?B?SnFaUTlGK05FUnZ5bjRKUysrcEQ3VllEY2FIa0tmQmIxOGpOVDZ2Y2xUWmhz?=
 =?utf-8?B?NnM4d1AveDdjMUFxclh0RGN2NTlSdDFxeWh2MVRwSThqdW9xVjZReG1MR25h?=
 =?utf-8?B?cTc4VDNRQm1LS284UFV0Y3RyQkxHSFZpOFBmM0dud3NobldIOVk3dkMweTVr?=
 =?utf-8?B?bUttQk5oakMwc1J4QkwwU1VXYjBCRjNWQzUzK25LMllzb0prVUswd3lqVTF6?=
 =?utf-8?B?Wloxc1ZHdHJiRnMvL01xcFBxRmp2a0Nac2ZiZ085RlBsK2w1T1VEY1lIUysw?=
 =?utf-8?B?SW5BQmErZHEzVWhnK08wZHdGc3F2RUNVRU9lWlFaaVJGTGxzeWkzK0x6TmY3?=
 =?utf-8?B?a2lZZjBnY0xYT3BRdkZKSzRHTE9tU0lPTC9pZVdYeFBsUzdIeEJGOG82ajhF?=
 =?utf-8?B?SnRiUEF1ZzZYVTVSd2ltYVVlOG1jVGdVSHQ2OXNyWWgvU0pVMmtVZWhGM1V6?=
 =?utf-8?B?OGVwSDFlYlgwd1pGT0FmT3F1dklEQmtKTUpvL0pyRDAwcTM4K002Yk5QTjNw?=
 =?utf-8?B?SWNFcHR5MFRNUU4waW84aUYzRVNmREpsRGRlY3dNcWlTUW5BV2NRYSttSmxo?=
 =?utf-8?B?MDhZMG5BOWlTYkhWUTJjS2JTdlFEcnVFb0E0MmhjajJ2ZTNmWGdMSlZEZEtm?=
 =?utf-8?B?RnZjVXdEaUhxNEZNNlBCUEZVM0dLN3M3bkE4QUk3MWxRbkNPc1BpWVhYY0E3?=
 =?utf-8?B?R2FEdnNiVEt1OU81eDYxQlEzQXZWSDZzYy82WkVLMlFtN00vOWVtaTdSRHU1?=
 =?utf-8?B?V2IvOXhJK0d2SmhERDZQeVMzUE14RHRxVzFDQUt3Nng2RXVqUXVjUVRmelNa?=
 =?utf-8?B?dEIrbnU3V1p1Rkg5OVRvNnFrckVwd1A4NG0xMTIzR1M1Zmc2cmhqZ05xUUFG?=
 =?utf-8?B?QkNtem1nSkxHSzl5TnpSaHpHUGgwQytGWS90V0pFblNNWGhEVDhwTDZTQzJQ?=
 =?utf-8?Q?gXNB8XXPQwT4VZ1TN6PeKxBTf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3e0628-4ae5-4a02-65e1-08da7bea2fbc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 22:38:18.1973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWe8aNM7dVM3OeCsNTqBDDEMS3nP+YKMlRCbTywKhgs1WrOf/DxioKiQt7H7WOGfL1/iw1tikZMni1cyjp9S8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>, amd-gfx@lists.freedesktop.org,
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-08-11 17:49, Alex Deucher wrote:
> On Thu, Aug 11, 2022 at 3:56 PM Rodrigo Siqueira
> <Rodrigo.Siqueira@amd.com> wrote:
>>
>> We got a report from Stephen/Michael that the PowerPC build was failing
>> with the following error:
>>
>> ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard float, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
>> ld: failed to merge target specific data of file drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o
>>
>> This error happened because of the function optc3_set_vrr_m_const. This
>> function expects a double as a parameter in a code that is not allowed
>> to have FPU operations. After further investigation, it became clear
>> that optc3_set_vrr_m_const was never invoked, so we can safely drop this
>> function and fix the ld issue.
>>
>> Changes since V1:
>>   - Drop optc3_fpu_set_vrr_m_const since it is unused.
> 
> FWIW, I upstreamed v1 already.  Can you rebase your v2 changes on that?

Hi Alex,

I guess the v1 was not merged into the amd-staging-drm-next. I just 
applied the v1 there (waiting for CI result).

I also sent this patch:

https://lore.kernel.org/amd-gfx/CADnq5_OiqWc7REg8CJ_S6UKHoBV0ZgE-+9WO1CexOjk+7ZWeNg@mail.gmail.com/T/#t

Thanks
Siqueira

> 
> Alex
> 
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Maíra Canal <mairacanal@riseup.net>
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  8 --
>>   .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  3 -
>>   .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |  1 -
>>   .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 77 -------------------
>>   .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  3 -
>>   .../amd/display/dc/inc/hw/timing_generator.h  |  2 -
>>   6 files changed, 94 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
>> index d072997477dd..1782b9c26cf4 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
>> @@ -184,14 +184,6 @@ void optc3_set_dsc_config(struct timing_generator *optc,
>>          REG_UPDATE(OTG_V_SYNC_A_CNTL, OTG_V_SYNC_MODE, 0);
>>   }
>>
>> -void optc3_set_vrr_m_const(struct timing_generator *optc,
>> -               double vtotal_avg)
>> -{
>> -       DC_FP_START();
>> -       optc3_fpu_set_vrr_m_const(optc, vtotal_avg);
>> -       DC_FP_END();
>> -}
>> -
>>   void optc3_set_odm_bypass(struct timing_generator *optc,
>>                  const struct dc_crtc_timing *dc_crtc_timing)
>>   {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
>> index 33bd12f5dc17..dd45a5499b07 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
>> @@ -329,9 +329,6 @@ void optc3_lock_doublebuffer_enable(struct timing_generator *optc);
>>
>>   void optc3_lock_doublebuffer_disable(struct timing_generator *optc);
>>
>> -void optc3_set_vrr_m_const(struct timing_generator *optc,
>> -               double vtotal_avg);
>> -
>>   void optc3_set_drr_trigger_window(struct timing_generator *optc,
>>                  uint32_t window_start, uint32_t window_end);
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
>> index 9861be1dc063..1fad7b48bd5b 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c
>> @@ -281,7 +281,6 @@ static struct timing_generator_funcs dcn32_tg_funcs = {
>>                  .lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
>>                  .lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
>>                  .enable_optc_clock = optc1_enable_optc_clock,
>> -               .set_vrr_m_const = optc3_set_vrr_m_const,
>>                  .set_drr = optc32_set_drr,
>>                  .get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
>>                  .set_vtotal_min_max = optc3_set_vtotal_min_max,
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
>> index e1e92daba668..814374b1016c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
>> @@ -177,83 +177,6 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
>>          .urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
>>   };
>>
>> -
>> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
>> -               double vtotal_avg)
>> -{
>> -       struct optc *optc1 = DCN10TG_FROM_TG(optc);
>> -       double vtotal_min, vtotal_max;
>> -       double ratio, modulo, phase;
>> -       uint32_t vblank_start;
>> -       uint32_t v_total_mask_value = 0;
>> -
>> -       dc_assert_fp_enabled();
>> -
>> -       /* Compute VTOTAL_MIN and VTOTAL_MAX, so that
>> -        * VOTAL_MAX - VTOTAL_MIN = 1
>> -        */
>> -       v_total_mask_value = 16;
>> -       vtotal_min = dcn_bw_floor(vtotal_avg);
>> -       vtotal_max = dcn_bw_ceil(vtotal_avg);
>> -
>> -       /* Check that bottom VBLANK is at least 2 lines tall when running with
>> -        * VTOTAL_MIN. Note that VTOTAL registers are defined as 'total number
>> -        * of lines in a frame - 1'.
>> -        */
>> -       REG_GET(OTG_V_BLANK_START_END, OTG_V_BLANK_START,
>> -               &vblank_start);
>> -       ASSERT(vtotal_min >= vblank_start + 1);
>> -
>> -       /* Special case where the average frame rate can be achieved
>> -        * without using the DTO
>> -        */
>> -       if (vtotal_min == vtotal_max) {
>> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
>> -
>> -               optc->funcs->set_vtotal_min_max(optc, 0, 0);
>> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
>> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
>> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
>> -                       OTG_V_TOTAL_MIN_SEL, 0,
>> -                       OTG_V_TOTAL_MAX_SEL, 0,
>> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
>> -               return;
>> -       }
>> -
>> -       ratio = vtotal_max - vtotal_avg;
>> -       modulo = 65536.0 * 65536.0 - 1.0; /* 2^32 - 1 */
>> -       phase = ratio * modulo;
>> -
>> -       /* Special cases where the DTO phase gets rounded to 0 or
>> -        * to DTO modulo
>> -        */
>> -       if (phase <= 0 || phase >= modulo) {
>> -               REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL,
>> -                       phase <= 0 ?
>> -                               (uint32_t)vtotal_max : (uint32_t)vtotal_min);
>> -               REG_SET(OTG_V_TOTAL_MIN, 0, OTG_V_TOTAL_MIN, 0);
>> -               REG_SET(OTG_V_TOTAL_MAX, 0, OTG_V_TOTAL_MAX, 0);
>> -               REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, 0);
>> -               REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, 0);
>> -               REG_UPDATE_3(OTG_V_TOTAL_CONTROL,
>> -                       OTG_V_TOTAL_MIN_SEL, 0,
>> -                       OTG_V_TOTAL_MAX_SEL, 0,
>> -                       OTG_SET_V_TOTAL_MIN_MASK_EN, 0);
>> -               return;
>> -       }
>> -       REG_UPDATE_6(OTG_V_TOTAL_CONTROL,
>> -               OTG_V_TOTAL_MIN_SEL, 1,
>> -               OTG_V_TOTAL_MAX_SEL, 1,
>> -               OTG_SET_V_TOTAL_MIN_MASK_EN, 1,
>> -               OTG_SET_V_TOTAL_MIN_MASK, v_total_mask_value,
>> -               OTG_VTOTAL_MID_REPLACING_MIN_EN, 0,
>> -               OTG_VTOTAL_MID_REPLACING_MAX_EN, 0);
>> -       REG_SET(OTG_V_TOTAL, 0, OTG_V_TOTAL, (uint32_t)vtotal_min);
>> -       optc->funcs->set_vtotal_min_max(optc, vtotal_min, vtotal_max);
>> -       REG_SET(OTG_M_CONST_DTO0, 0, OTG_M_CONST_DTO_PHASE, (uint32_t)phase);
>> -       REG_SET(OTG_M_CONST_DTO1, 0, OTG_M_CONST_DTO_MODULO, (uint32_t)modulo);
>> -}
>> -
>>   void dcn30_fpu_populate_dml_writeback_from_context(
>>                  struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
>>   {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
>> index cab864095ce7..e3b6ad6a8784 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h
>> @@ -29,9 +29,6 @@
>>   #include "core_types.h"
>>   #include "dcn20/dcn20_optc.h"
>>
>> -void optc3_fpu_set_vrr_m_const(struct timing_generator *optc,
>> -               double vtotal_avg);
>> -
>>   void dcn30_fpu_populate_dml_writeback_from_context(
>>                  struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
>> index 828e5c6ad1cf..72eef7a5ed83 100644
>> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
>> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
>> @@ -310,8 +310,6 @@ struct timing_generator_funcs {
>>                          int group_idx,
>>                          uint32_t gsl_ready_signal);
>>          void (*set_out_mux)(struct timing_generator *tg, enum otg_out_mux_dest dest);
>> -       void (*set_vrr_m_const)(struct timing_generator *optc,
>> -                       double vtotal_avg);
>>          void (*set_drr_trigger_window)(struct timing_generator *optc,
>>                          uint32_t window_start, uint32_t window_end);
>>          void (*set_vtotal_change_limit)(struct timing_generator *optc,
>> --
>> 2.35.1
>>

