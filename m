Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7ADC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 17:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E673F10F297;
	Fri,  6 May 2022 17:12:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4293910F297
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 17:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSZhjSPwbQ3WKJdi1Yf7BDGIzqYnYhIQ6QG4C9Dg5TWwF4/4lqWZ2f8iP4C6cdtbVwQxZeYWLpv/j3QKKNGwXpBVp2kPa7xlQCWeds2syZsumB/Jk6zr8tqvvF2406L6OTK1wZEeT/+xqkYqy3I3mjodsqsjApfi0qJm2HBRA4HIn3z/XhRJ6BEy6y1f0njOjWmhYm92Cva3uWRDG+Mo38UGNx6U+OaemCFsd7BTfL9Eo2vZaUCytIuEdyoDE3RK0EBaJhhnHAR586vzLUEgwXK/8Xl7yq+6RjUkA8C3rYdlC4ETR7W9Hya4MkvX+nYTZzIAkR8sA65HzXcdM2KpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHB1YDfpi82JJnBiin9dvm5BEEqpgMtjAbibUuoXa+I=;
 b=b6Ulnos5UBgHodi/cdeyvhrlVLvdRfJFdeos1X6Ws0x/EpH5q9bdbIzMPvot7wcL3oUbGXTWpVRx+2bTMiO9Wl33sTgvw7IbpCcyHdUmvE/MLTE709e3AVg/xcyqj6y1UsHY7jSH1D6L213L+Ugsb0uItHQ60AhDsjSqxOzfM3dl+Y4wgiF+h3jaioGlshC4vxLtR5hqeAkvWL9t+/F1JrxltNa8kOpPLP3rEuGm3ofgMk+DwOdAiGFosDqmANVzxp3MCTKkPj337Wfw9C84jXbxP/EupfCi8v7asKg2OeQuXb4LbxVbaiekglFzHnlogiREYK29jqBOX19mmaPaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHB1YDfpi82JJnBiin9dvm5BEEqpgMtjAbibUuoXa+I=;
 b=XvPlLVia/SiL7lT1tqBBjdKoO+HteP126+R6j0pTnYHV0JsrP4hmiQ2EYP1/WR5CRzNoJO34J2/6csYVF+mmxBj7ngUPOgdnfrvh4+anB9mesWWPBpuiiaxX/h06SQtlpgNqF8sTRUSdfkaA0Guzt/YpMD69ZKfJQfzaUlQFNgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BYAPR12MB2920.namprd12.prod.outlook.com (2603:10b6:a03:139::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Fri, 6 May
 2022 17:12:40 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::2140:f05:1314:30b6]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::2140:f05:1314:30b6%6]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 17:12:39 +0000
Message-ID: <465aa9b5-a16f-e067-953c-1155c8d48ba8@amd.com>
Date: Fri, 6 May 2022 13:12:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 07/15] drm/amd/display: remove redundant
 CONFIG_DRM_AMD_DC_DCN in dc
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Stylon Wang <stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
 <20220506154214.3438665-8-stylon.wang@amd.com>
 <CADnq5_M_VZY-QVTEwr9MQhpRF8t=6kr-g97KnvHrETExQe1vHA@mail.gmail.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <CADnq5_M_VZY-QVTEwr9MQhpRF8t=6kr-g97KnvHrETExQe1vHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0131.namprd02.prod.outlook.com
 (2603:10b6:208:35::36) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8f7b603-61b7-433f-5880-08da2f839f88
X-MS-TrafficTypeDiagnostic: BYAPR12MB2920:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29200BFA4FFC6CB4E531A07B98C59@BYAPR12MB2920.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNIr5xLjzmzcomrxj3vmBZJ4Mwpj570C+V0aA/uj1aP3TsP5yicERL8+iKmgnNWJDk0jSIKk6VrrXcnfWoM95JHX8sqDqtLbtoIyM728OlGpv2is4OO27M2zuxDjDg1boJ1zQfULvUjyMHfDGSRaOeKJ75mWc1ybRWTbEJo8FS6ZRarlnbCfp+fODXS5zoqAvobI5YeekZL4bSEuRaW+zHVz0POasfkoNRjI5OJ3Lo9H+efE43p2wMPjN3YpXLIBplQFCcWcQToCNUm5I2qEzoEEQnCzeuMIATawXYxe6t/wuDFT0/VaZQ2kM7hYxi3oEfCS2rkSSazK1YMAVB4VsGbRmbesFJq+kALqfy3r85scXt5sbgHUdTX0kGCbTRjZMU1mBnnfIkUC34WMsF0+vrYueiSDlSjn5N24N1VuYspwmTZ5YNZ7RCQbcxju7sjJird/gO7tD0BUUsxO+x6u21/iOcqU7QqVqvsOJp+viF3w/LXKEcFJLyUYwig1eWpmdT7xJp5FeJCn65w7rLAxi5pF76s6is460F4q7iv4R9UDCY+UG/XCDUXlauMY7IDKpXWaBYa9PO9/bOXloRcPvdJauJouQbzGs2xWERVr8C5e20XrgzZkAvmx07W+Y6OHNWrtIVaT4+KZHOrDaMmY3BpJbf20tT/RGuiKXJ94ywkqnAyEzTRLVwnIfGBeaKXh4yFO29i6c6JeOdYKZ1r7b6wMH4aPBT82SVhkJ/c5SzY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(36756003)(316002)(2616005)(30864003)(6486002)(38100700002)(8936002)(54906003)(110136005)(6636002)(5660300002)(508600001)(66476007)(8676002)(26005)(31686004)(66946007)(66556008)(4326008)(6506007)(53546011)(86362001)(186003)(6666004)(83380400001)(6512007)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUZBOHA1UU8xbTRTb1l4d0RMNFlvRjdHM21RMnRJK1QrV3BqVXpDbUpkN2Jt?=
 =?utf-8?B?TGUrZ05MNk9XNWs1K2tsT2pzN1dlMk5RR3FVZXRTMExXOHNZd212VSs3aWFh?=
 =?utf-8?B?R1FIZzl5eDQ5NWdaVnZxdUpHNXlKeFJJVWMwelJyT2tSK0xWWVRWem10UTZo?=
 =?utf-8?B?cTFjalZTeU54UFczYWxLeHhBQVU1Q0xjSUdjU0NSWGt2enNnM1cxaUFJQ0F5?=
 =?utf-8?B?UFI0ZVhETWVQL2IvY0ljaDgzc0tHWlNlOFRVRS9ZbmMzSUlPbmMvWTZPSVpE?=
 =?utf-8?B?bE84WHdLZDJsV1oyTTcybi8yQXhHb050OVZHNjlKSSsxNWxRTEhvU0tWVHdE?=
 =?utf-8?B?YjZMMGJnKzZBVVBsUllObi8xSm5Ic2tORElkMENxZUlHaUZaeExDOEFqNTJS?=
 =?utf-8?B?eSt1aitHUDdzR1dVTmZ2c2RXYzBQem9UTDJvMHhncCtEUW1Qc3pnTGZIRFVF?=
 =?utf-8?B?LytCNzUvSVFLQkU5Q1hoWVorcTFSTXo4ajhWTndReUN6VHVvbmovaFpQZmNz?=
 =?utf-8?B?MnF2UDB0ZFVOTGIrUmtLN2ZNOE1tWUVHYlh1K1NsMCtKOG1sbDBUdWQra3FS?=
 =?utf-8?B?SVgrQlNQZm91aHJ2MFk4T2YrdEgwOWdkUWJlV3Y5dGxEc0RkNG9LUUpka2Ez?=
 =?utf-8?B?N0ViRXoyNHJVSGhBQU8vT1lkOGtqME8yZUw1L3pFTDREWUZTWXpDTGRueVBW?=
 =?utf-8?B?UHFwZHpncXk0L2Q2UGNGUFc0R1hsY3g2VGo4ejVqWnAxYjBvTjFXY0gzdnp4?=
 =?utf-8?B?TFJHWTNnV3lLTlBSRkk4MFVIaTZYZnNZd25KWFhCQ3EzSlhXRm9WMjR4TGZX?=
 =?utf-8?B?TWdwaG9rNC9ManllUjF6WkRGVGlKUHZtZWlmWEM4QlQ1NzB2YWtRdVlPN1dI?=
 =?utf-8?B?LzJUZ0NNcE9GZDdYSUZ3Y2VJZmhHV3JNb1RRUk40MzdkRHJFVlYyL3RmazVT?=
 =?utf-8?B?TERDd05Ick5tQXhTc29hYloydnJCL3Nja0hNczdxRG92eWtCNnZCdHZHU2Zz?=
 =?utf-8?B?aEV5YndDK3dmc2tZV0QzdkRmT0FMWFlUbnJPWGpVVEhrUjh0dy9wMjZ5WWRY?=
 =?utf-8?B?TktibXNjYlV1bFloQlV6ekpxdkVxRnFZUE9ZcHFWaldKcitVNzlLNlRKSmlh?=
 =?utf-8?B?U1RWcVEvVHYwdVJBcUxhSzRIL3lsakJqWCtLU3hmUXFBL2FEcTlvVGZVR1NT?=
 =?utf-8?B?MW9hcGFpT0g2VG40QnQ0c1hSN05WaDZIVVNpaUt6NExJTW5JRDY1UkFHSEx2?=
 =?utf-8?B?bkIvRGxPRE1Uam5lbGlEL3pZSjUrZktwV1M5bGFrZzQ1ZnBBTVVwN0psMjJE?=
 =?utf-8?B?UkFqOWRjdmpaUHlqTFl0RC9ka21LRWszcitwSlF3ZExadzJrdUgzV2lTWWpp?=
 =?utf-8?B?NWVHZHJVSVdtOWVhV2hwUk1Hc3pHOWQ0alB6WEFpcEdLZFBkdDljbFdJd3dz?=
 =?utf-8?B?Z0t3WHFaVExIWE1TSkhtM0R0U0szRlJyRDFXM1NjMW5uTXhPTkUvL01GOElO?=
 =?utf-8?B?YmlrdE5CSXBGREdBNkhMRnJyQlpZWWFjY0NwenFKUVdkMldSdEI1N3hPWXN1?=
 =?utf-8?B?SHk5V0I5WjBzV0RyUU5FQmxIdEpOZFArRnVwTDMwTkVYMUpvbEZSQk9HOWZu?=
 =?utf-8?B?UnorcE4wZ0VHVk1mOXdmZ1BoMG5HSUx0elp3QVlYQW1FanFXZE93RWVIMTVW?=
 =?utf-8?B?UXZsOFM4RFg4RFdCcVVHQng1dUFMY1c3TlBhcTdldGhqRkRWcEk4QlRzaHUr?=
 =?utf-8?B?UVFMcmpQdXc4OHplQTRnRFgzNXRaYzljZ2pEcDdiRm0vYjYzdWVGY3V6aURB?=
 =?utf-8?B?TGM5Z0FpWEtXOERabE1jY0VBbUNOQzFsM3MrQUdoWFFtZTR4MEsrUXZtcXZU?=
 =?utf-8?B?TkI2cVRTa21SQk9NRkVhUTlFUVYvTndQcU9jbzRFcDZnRHR3Z1Z2c0dqb3Zo?=
 =?utf-8?B?eUFDRVZmd2FaYS9nbDExb25DOFdNeHFUelFybmhXL3FGc3FlMGhzeEVIOG9S?=
 =?utf-8?B?KytnL1Vlak1wQ2lKUXV1RnIzc2ZXaEU1S2lXZ0R1TVJJOVQzL0pkTVpPamh0?=
 =?utf-8?B?RFNQbksyWHAzb2dpek5tSGl0UzUyb2NObUtHSUd2eFNBMnVIRjFuZkJFbDFF?=
 =?utf-8?B?TG9rb212dTBrOFdGSzJ3RXVhT2dTUG9wZEM3b0c3OFRDT0VpcFpQMktaQVBV?=
 =?utf-8?B?MDJscmRiK0tuZ2FXc1JLRmhxeUVyLytQbG5Senh6eUExQkJJMnRWOGQ0WVBM?=
 =?utf-8?B?Z1ovQlh0OHB0a0QvNFFjNnY5OHNjTy9GczZ3eEIrNHEzUlJmMVZIUTdFYVgr?=
 =?utf-8?B?ZmhZaWtEeUR3NkRpTEMxNTFMQXRQRFpuYlJ6cGlveUZlMDQ1VUEyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f7b603-61b7-433f-5880-08da2f839f88
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 17:12:39.3049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr4DC7LBkHLtsMenKgSiz3qJbOHfVKDa/Avtp+ieEwZkE8ZpUBGNtj1H/sppVE6FtQmuADhMC+2ewkXksl1DrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2920
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
Cc: "Leo \(Sunpeng\) Li" <Sunpeng.Li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Roman Li <roman.li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Solomon Chiu <solomon.chiu@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <agustin.gutierrez@amd.com>, "Kotarac, Pavle" <pavle.kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-05-06 11:56, Alex Deucher wrote:
> On Fri, May 6, 2022 at 11:43 AM Stylon Wang <stylon.wang@amd.com> wrote:
>>
>> From: Alex Hung <alex.hung@amd.com>
>>
>> [Why & How]
>> CONFIG_DRM_AMD_DC_DCN is used by pass the compilation failures, but DC
>> code should be OS-agnostic.
>>
>> This patch fixes it by removing unnecessasry CONFIG_DRM_AMD_DC_DCN
>> in dc and dc/core directories.
>>
>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Acked-by: Stylon Wang <stylon.wang@amd.com>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
> 
> I presume the driver still builds properly on configs where
> CONFIG_DRM_AMD_DC_DCN is not set?  E.g., platforms without floating
> point for example?
> 

Hi Alex,

This is part of our effort to isolate FPU code inside DML (right now, we 
are only missing DCN30); since we are really close to that, many of 
these guards become useless. All of these patches were tested in our CI 
against:

1. x86 with DCN
2. x86 without DCN
3. Clang
4. make allmodconfig

Additionally, I think that Alex Hung also checked the compilation with 
PowerPC.

Thanks
Siqueira


> Alex
> 
>> ---
>>   drivers/gpu/drm/amd/display/dc/Makefile       |  2 -
>>   .../display/dc/bios/command_table_helper2.c   |  3 +-
>>   drivers/gpu/drm/amd/display/dc/core/dc.c      | 31 ++--------------
>>   .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 -
>>   drivers/gpu/drm/amd/display/dc/core/dc_link.c |  2 -
>>   .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  4 --
>>   .../drm/amd/display/dc/core/dc_link_dpia.c    |  2 -
>>   .../gpu/drm/amd/display/dc/core/dc_resource.c | 21 ++---------
>>   .../gpu/drm/amd/display/dc/core/dc_stream.c   |  8 ----
>>   drivers/gpu/drm/amd/display/dc/dc.h           | 37 -------------------
>>   drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 -
>>   .../gpu/drm/amd/display/dc/inc/core_types.h   | 17 ++-------
>>   12 files changed, 10 insertions(+), 121 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
>> index f05ab2bf20c5..b4eca0236435 100644
>> --- a/drivers/gpu/drm/amd/display/dc/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
>> @@ -63,9 +63,7 @@ DISPLAY_CORE = dc.o  dc_stat.o dc_link.o dc_resource.o dc_hw_sequencer.o dc_sink
>>   dc_surface.o dc_link_dp.o dc_link_ddc.o dc_debug.o dc_stream.o \
>>   dc_link_enc_cfg.o dc_link_dpia.o dc_link_dpcd.o
>>
>> -ifdef CONFIG_DRM_AMD_DC_DCN
>>   DISPLAY_CORE += dc_vm_helper.o
>> -endif
>>
>>   AMD_DISPLAY_CORE = $(addprefix $(AMDDALPATH)/dc/core/,$(DISPLAY_CORE))
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
>> index dd9704ef4ccc..f3792286f571 100644
>> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
>> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
>> @@ -65,7 +65,6 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
>>          case DCE_VERSION_12_1:
>>                  *h = dal_cmd_tbl_helper_dce112_get_table2();
>>                  return true;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          case DCN_VERSION_1_0:
>>          case DCN_VERSION_1_01:
>>          case DCN_VERSION_2_0:
>> @@ -80,7 +79,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
>>          case DCN_VERSION_3_16:
>>                  *h = dal_cmd_tbl_helper_dce112_get_table2();
>>                  return true;
>> -#endif
>> +
>>          default:
>>                  /* Unsupported DCE */
>>                  BREAK_TO_DEBUGGER();
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> index c2fcd67bcc4d..1eeea7c184ae 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>> @@ -829,14 +829,12 @@ static void dc_destruct(struct dc *dc)
>>          kfree(dc->bw_dceip);
>>          dc->bw_dceip = NULL;
>>
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          kfree(dc->dcn_soc);
>>          dc->dcn_soc = NULL;
>>
>>          kfree(dc->dcn_ip);
>>          dc->dcn_ip = NULL;
>>
>> -#endif
>>          kfree(dc->vm_helper);
>>          dc->vm_helper = NULL;
>>
>> @@ -882,10 +880,8 @@ static bool dc_construct(struct dc *dc,
>>          struct dc_context *dc_ctx;
>>          struct bw_calcs_dceip *dc_dceip;
>>          struct bw_calcs_vbios *dc_vbios;
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          struct dcn_soc_bounding_box *dcn_soc;
>>          struct dcn_ip_params *dcn_ip;
>> -#endif
>>
>>          dc->config = init_params->flags;
>>
>> @@ -913,7 +909,6 @@ static bool dc_construct(struct dc *dc,
>>          }
>>
>>          dc->bw_vbios = dc_vbios;
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          dcn_soc = kzalloc(sizeof(*dcn_soc), GFP_KERNEL);
>>          if (!dcn_soc) {
>>                  dm_error("%s: failed to create dcn_soc\n", __func__);
>> @@ -929,7 +924,6 @@ static bool dc_construct(struct dc *dc,
>>          }
>>
>>          dc->dcn_ip = dcn_ip;
>> -#endif
>>
>>          if (!dc_construct_ctx(dc, init_params)) {
>>                  dm_error("%s: failed to create ctx\n", __func__);
>> @@ -1868,7 +1862,6 @@ bool dc_commit_state(struct dc *dc, struct dc_state *context)
>>          return (result == DC_OK);
>>   }
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   bool dc_acquire_release_mpc_3dlut(
>>                  struct dc *dc, bool acquire,
>>                  struct dc_stream_state *stream,
>> @@ -1904,7 +1897,7 @@ bool dc_acquire_release_mpc_3dlut(
>>          }
>>          return ret;
>>   }
>> -#endif
>> +
>>   static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
>>   {
>>          int i;
>> @@ -1925,7 +1918,6 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
>>          return false;
>>   }
>>
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>   /* Perform updates here which need to be deferred until next vupdate
>>    *
>>    * i.e. blnd lut, 3dlut, and shaper lut bypass regs are double buffered
>> @@ -1944,7 +1936,6 @@ static void process_deferred_updates(struct dc *dc)
>>                                  dc->res_pool->dpps[i]->funcs->dpp_deferred_update(dc->res_pool->dpps[i]);
>>          }
>>   }
>> -#endif /* CONFIG_DRM_AMD_DC_DCN */
>>
>>   void dc_post_update_surfaces_to_stream(struct dc *dc)
>>   {
>> @@ -1971,9 +1962,7 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
>>                          dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
>>                  }
>>
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          process_deferred_updates(dc);
>> -#endif
>>
>>          dc->hwss.optimize_bandwidth(dc, context);
>>
>> @@ -1987,9 +1976,7 @@ static void init_state(struct dc *dc, struct dc_state *context)
>>           * initialize and obtain IP and SOC the base DML instance from DC is
>>           * initially copied into every context
>>           */
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          memcpy(&context->bw_ctx.dml, &dc->dml, sizeof(struct display_mode_lib));
>> -#endif
>>   }
>>
>>   struct dc_state *dc_create_state(struct dc *dc)
>> @@ -2361,11 +2348,9 @@ static enum surface_update_type check_update_surfaces_for_stream(
>>          int i;
>>          enum surface_update_type overall_type = UPDATE_TYPE_FAST;
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          if (dc->idle_optimizations_allowed)
>>                  overall_type = UPDATE_TYPE_FULL;
>>
>> -#endif
>>          if (stream_status == NULL || stream_status->plane_count != surface_count)
>>                  overall_type = UPDATE_TYPE_FULL;
>>
>> @@ -2874,10 +2859,8 @@ static void commit_planes_for_stream(struct dc *dc,
>>          }
>>
>>          if (update_type == UPDATE_TYPE_FULL) {
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>                  dc_allow_idle_optimizations(dc, false);
>>
>> -#endif
>>                  if (get_seamless_boot_stream_count(context) == 0)
>>                          dc->hwss.prepare_bandwidth(dc, context);
>>
>> @@ -2895,7 +2878,6 @@ static void commit_planes_for_stream(struct dc *dc,
>>                  }
>>          }
>>
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
>>                  struct pipe_ctx *mpcc_pipe;
>>                  struct pipe_ctx *odm_pipe;
>> @@ -2904,7 +2886,6 @@ static void commit_planes_for_stream(struct dc *dc,
>>                          for (odm_pipe = mpcc_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
>>                                  odm_pipe->ttu_regs.min_ttu_vblank = MAX_TTU;
>>          }
>> -#endif
>>
>>          if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
>>                  if (top_pipe_to_program &&
>> @@ -3014,7 +2995,6 @@ static void commit_planes_for_stream(struct dc *dc,
>>          }
>>          if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
>>                  dc->hwss.program_front_end_for_ctx(dc, context);
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>                  if (dc->debug.validate_dml_output) {
>>                          for (i = 0; i < dc->res_pool->pipe_count; i++) {
>>                                  struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
>> @@ -3028,7 +3008,6 @@ static void commit_planes_for_stream(struct dc *dc,
>>                                                  &context->res_ctx.pipe_ctx[i].ttu_regs);
>>                          }
>>                  }
>> -#endif
>>          }
>>
>>          // Update Type FAST, Surface updates
>> @@ -3583,8 +3562,6 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
>>          return true;
>>   }
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>> -
>>   void dc_allow_idle_optimizations(struct dc *dc, bool allow)
>>   {
>>          if (dc->debug.disable_idle_power_optimizations)
>> @@ -3740,7 +3717,6 @@ void dc_hardware_release(struct dc *dc)
>>          if (dc->hwss.hardware_release)
>>                  dc->hwss.hardware_release(dc);
>>   }
>> -#endif
>>
>>   /*
>>    *****************************************************************************
>> @@ -3760,13 +3736,12 @@ void dc_hardware_release(struct dc *dc)
>>    */
>>   bool dc_is_dmub_outbox_supported(struct dc *dc)
>>   {
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>> -       /* YELLOW_CARP B0 USB4 DPIA needs dmub notifications for interrupts */
>> +       /* DCN31 B0 USB4 DPIA needs dmub notifications for interrupts */
>>          if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
>>              dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
>>              !dc->debug.dpia_debug.bits.disable_dpia)
>>                  return true;
>> -#endif
>> +
>>          /* dmub aux needs dmub notifications to be enabled */
>>          return dc->debug.enable_dmub_aux_for_legacy_ddc;
>>   }
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
>> index 643762542e4d..72376075db0c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
>> @@ -345,7 +345,6 @@ void context_clock_trace(
>>                  struct dc *dc,
>>                  struct dc_state *context)
>>   {
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          DC_LOGGER_INIT(dc->ctx->logger);
>>          CLOCK_TRACE("Current: dispclk_khz:%d  max_dppclk_khz:%d  dcfclk_khz:%d\n"
>>                          "dcfclk_deep_sleep_khz:%d  fclk_khz:%d  socclk_khz:%d\n",
>> @@ -363,7 +362,6 @@ void context_clock_trace(
>>                          context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz,
>>                          context->bw_ctx.bw.dcn.clk.fclk_khz,
>>                          context->bw_ctx.bw.dcn.clk.socclk_khz);
>> -#endif
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> index 07f154fc4e56..9529b924742e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
>> @@ -804,7 +804,6 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
>>
>>   static void apply_dpia_mst_dsc_always_on_wa(struct dc_link *link)
>>   {
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          /* Apply work around for tunneled MST on certain USB4 docks. Always use DSC if dock
>>           * reports DSC support.
>>           */
>> @@ -815,7 +814,6 @@ static void apply_dpia_mst_dsc_always_on_wa(struct dc_link *link)
>>                          link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
>>                          !link->dc->debug.dpia_debug.bits.disable_mst_dsc_work_around)
>>                  link->wa_flags.dpia_mst_dsc_always_on = true;
>> -#endif
>>   }
>>
>>   static void revert_dpia_mst_dsc_always_on_wa(struct dc_link *link)
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> index 5e49e346aa06..975d631534b5 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> @@ -5127,12 +5127,10 @@ void dp_retrieve_lttpr_cap(struct dc_link *link)
>>          else
>>                  link->lttpr_support = LTTPR_CHECK_EXT_SUPPORT;
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          /* Check DP tunnel LTTPR mode debug option. */
>>          if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
>>              link->dc->debug.dpia_debug.bits.force_non_lttpr)
>>                  link->lttpr_support = LTTPR_UNSUPPORTED;
>> -#endif
>>
>>          if (link->lttpr_support > LTTPR_UNSUPPORTED) {
>>                  /* By reading LTTPR capability, RX assumes that we will enable
>> @@ -5626,9 +5624,7 @@ static bool retrieve_link_cap(struct dc_link *link)
>>                   * only if required.
>>                   */
>>                  if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>                                  !link->dc->debug.dpia_debug.bits.disable_force_tbt3_work_around &&
>> -#endif
>>                                  link->dpcd_caps.is_branch_dev &&
>>                                  link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
>>                                  link->dpcd_caps.branch_hw_revision == DP_BRANCH_HW_REV_10 &&
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>> index 0e95bc5df4e7..a5765f36d86f 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
>> @@ -547,11 +547,9 @@ static uint32_t dpia_get_eq_aux_rd_interval(const struct dc_link *link,
>>                                  dp_translate_training_aux_read_interval(
>>                                          link->dpcd_caps.lttpr_caps.aux_rd_interval[hop - 1]);
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          /* Check debug option for extending aux read interval. */
>>          if (link->dc->debug.dpia_debug.bits.extend_aux_rd_interval)
>>                  wait_time_microsec = DPIA_DEBUG_EXTENDED_AUX_RD_INTERVAL_US;
>> -#endif
>>
>>          return wait_time_microsec;
>>   }
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> index 147c6a3c6312..f702919a2279 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
>> @@ -56,7 +56,6 @@
>>   #include "dce110/dce110_resource.h"
>>   #include "dce112/dce112_resource.h"
>>   #include "dce120/dce120_resource.h"
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   #include "dcn10/dcn10_resource.h"
>>   #include "dcn20/dcn20_resource.h"
>>   #include "dcn21/dcn21_resource.h"
>> @@ -68,7 +67,6 @@
>>   #include "dcn31/dcn31_resource.h"
>>   #include "dcn315/dcn315_resource.h"
>>   #include "dcn316/dcn316_resource.h"
>> -#endif
>>
>>   #define DC_LOGGER_INIT(logger)
>>
>> @@ -124,7 +122,6 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>>                  else
>>                          dc_version = DCE_VERSION_12_0;
>>                  break;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          case FAMILY_RV:
>>                  dc_version = DCN_VERSION_1_0;
>>                  if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev))
>> @@ -165,7 +162,6 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
>>                  if (ASICREV_IS_GC_10_3_7(asic_id.hw_internal_rev))
>>                          dc_version = DCN_VERSION_3_16;
>>                  break;
>> -#endif
>>
>>          default:
>>                  dc_version = DCE_VERSION_UNKNOWN;
>> @@ -397,7 +393,6 @@ bool resource_construct(
>>                  }
>>          }
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          for (i = 0; i < caps->num_mpc_3dlut; i++) {
>>                  pool->mpc_lut[i] = dc_create_3dlut_func();
>>                  if (pool->mpc_lut[i] == NULL)
>> @@ -406,7 +401,7 @@ bool resource_construct(
>>                  if (pool->mpc_shaper[i] == NULL)
>>                          DC_ERR("DC: failed to create MPC shaper!\n");
>>          }
>> -#endif
>> +
>>          dc->caps.dynamic_audio = false;
>>          if (pool->audio_count < pool->stream_enc_count) {
>>                  dc->caps.dynamic_audio = true;
>> @@ -1369,7 +1364,6 @@ static struct pipe_ctx *acquire_free_pipe_for_head(
>>          return pool->funcs->acquire_idle_pipe_for_layer(context, pool, head_pipe->stream);
>>   }
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   static int acquire_first_split_pipe(
>>                  struct resource_context *res_ctx,
>>                  const struct resource_pool *pool,
>> @@ -1404,7 +1398,6 @@ static int acquire_first_split_pipe(
>>          }
>>          return -1;
>>   }
>> -#endif
>>
>>   bool dc_add_plane_to_context(
>>                  const struct dc *dc,
>> @@ -1447,13 +1440,12 @@ bool dc_add_plane_to_context(
>>          while (head_pipe) {
>>                  free_pipe = acquire_free_pipe_for_head(context, pool, head_pipe);
>>
>> -       #if defined(CONFIG_DRM_AMD_DC_DCN)
>>                  if (!free_pipe) {
>>                          int pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
>>                          if (pipe_idx >= 0)
>>                                  free_pipe = &context->res_ctx.pipe_ctx[pipe_idx];
>>                  }
>> -       #endif
>> +
>>                  if (!free_pipe) {
>>                          dc_plane_state_release(plane_state);
>>                          return false;
>> @@ -2259,10 +2251,8 @@ enum dc_status resource_map_pool_resources(
>>                  /* acquire new resources */
>>                  pipe_idx = acquire_first_free_pipe(&context->res_ctx, pool, stream);
>>
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          if (pipe_idx < 0)
>>                  pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
>> -#endif
>>
>>          if (pipe_idx < 0 || context->res_ctx.pipe_ctx[pipe_idx].stream_res.tg == NULL)
>>                  return DC_NO_CONTROLLER_RESOURCE;
>> @@ -2453,7 +2443,6 @@ enum dc_status dc_validate_global_state(
>>                  if (!dc->res_pool->funcs->validate_bandwidth(dc, new_ctx, fast_validate))
>>                          result = DC_FAIL_BANDWIDTH_VALIDATE;
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          /*
>>           * Only update link encoder to stream assignment after bandwidth validation passed.
>>           * TODO: Split out assignment and validation.
>> @@ -2461,7 +2450,6 @@ enum dc_status dc_validate_global_state(
>>          if (result == DC_OK && dc->res_pool->funcs->link_encs_assign && fast_validate == false)
>>                  dc->res_pool->funcs->link_encs_assign(
>>                          dc, new_ctx, new_ctx->streams, new_ctx->stream_count);
>> -#endif
>>
>>          return result;
>>   }
>> @@ -3189,10 +3177,8 @@ unsigned int resource_pixel_format_to_bpp(enum surface_pixel_format format)
>>          case SURFACE_PIXEL_FORMAT_GRPH_ARGB2101010:
>>          case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010:
>>          case SURFACE_PIXEL_FORMAT_GRPH_ABGR2101010_XR_BIAS:
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          case SURFACE_PIXEL_FORMAT_GRPH_RGBE:
>>          case SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA:
>> -#endif
>>                  return 32;
>>          case SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616:
>>          case SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616:
>> @@ -3345,7 +3331,6 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
>>          /* TODO - get transmitter to phy idx mapping from DMUB */
>>          uint8_t phy_idx = transmitter - TRANSMITTER_UNIPHY_A;
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          if (dc->ctx->dce_version == DCN_VERSION_3_1 &&
>>                          dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
>>                  switch (transmitter) {
>> @@ -3369,7 +3354,7 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
>>                          break;
>>                  }
>>          }
>> -#endif
>> +
>>          return phy_idx;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
>> index c4e871f358ab..acca35d86c10 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
>> @@ -314,9 +314,7 @@ bool dc_stream_set_cursor_attributes(
>>          const struct dc_cursor_attributes *attributes)
>>   {
>>          struct dc  *dc;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool reset_idle_optimizations = false;
>> -#endif
>>
>>          if (NULL == stream) {
>>                  dm_error("DC: dc_stream is NULL!\n");
>> @@ -346,12 +344,10 @@ bool dc_stream_set_cursor_attributes(
>>   #endif
>>          program_cursor_attributes(dc, stream, attributes);
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          /* re-enable idle optimizations if necessary */
>>          if (reset_idle_optimizations)
>>                  dc_allow_idle_optimizations(dc, true);
>>
>> -#endif
>>          return true;
>>   }
>>
>> @@ -396,9 +392,7 @@ bool dc_stream_set_cursor_position(
>>          const struct dc_cursor_position *position)
>>   {
>>          struct dc  *dc;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool reset_idle_optimizations = false;
>> -#endif
>>
>>          if (NULL == stream) {
>>                  dm_error("DC: dc_stream is NULL!\n");
>> @@ -424,12 +418,10 @@ bool dc_stream_set_cursor_position(
>>          stream->cursor_position = *position;
>>
>>          program_cursor_position(dc, stream, position);
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          /* re-enable idle optimizations if necessary */
>>          if (reset_idle_optimizations)
>>                  dc_allow_idle_optimizations(dc, true);
>>
>> -#endif
>>          return true;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
>> index e37d9c19f089..0f86bb809e04 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dc.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
>> @@ -222,7 +222,6 @@ struct dc_dcc_setting {
>>          unsigned int max_compressed_blk_size;
>>          unsigned int max_uncompressed_blk_size;
>>          bool independent_64b_blks;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          //These bitfields to be used starting with DCN
>>          struct {
>>                  uint32_t dcc_256_64_64 : 1;//available in ASICs before DCN (the worst compression case)
>> @@ -230,7 +229,6 @@ struct dc_dcc_setting {
>>                  uint32_t dcc_256_128_128 : 1;           //available starting with DCN
>>                  uint32_t dcc_256_256_unconstrained : 1;  //available in ASICs before DCN (the best compression case)
>>          } dcc_controls;
>> -#endif
>>   };
>>
>>   struct dc_surface_dcc_cap {
>> @@ -332,9 +330,7 @@ struct dc_config {
>>          bool enable_4to1MPC;
>>          bool enable_windowed_mpo_odm;
>>          bool allow_edp_hotplug_detection;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool clamp_min_dcfclk;
>> -#endif
>>          uint64_t vblank_alignment_dto_params;
>>          uint8_t  vblank_alignment_max_frame_time_diff;
>>          bool is_asymmetric_memory;
>> @@ -395,14 +391,12 @@ enum dcn_pwr_state {
>>          DCN_PWR_STATE_LOW_POWER = 3,
>>   };
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   enum dcn_zstate_support_state {
>>          DCN_ZSTATE_SUPPORT_UNKNOWN,
>>          DCN_ZSTATE_SUPPORT_ALLOW,
>>          DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY,
>>          DCN_ZSTATE_SUPPORT_DISALLOW,
>>   };
>> -#endif
>>   /*
>>    * For any clocks that may differ per pipe
>>    * only the max is stored in this structure
>> @@ -420,10 +414,8 @@ struct dc_clocks {
>>          int phyclk_khz;
>>          int dramclk_khz;
>>          bool p_state_change_support;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          enum dcn_zstate_support_state zstate_support;
>>          bool dtbclk_en;
>> -#endif
>>          enum dcn_pwr_state pwr_state;
>>          /*
>>           * Elements below are not compared for the purposes of
>> @@ -653,9 +645,7 @@ struct dc_debug_options {
>>          bool disable_pplib_clock_request;
>>          bool disable_clock_gate;
>>          bool disable_mem_low_power;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool pstate_enabled;
>> -#endif
>>          bool disable_dmcu;
>>          bool disable_psr;
>>          bool force_abm_enable;
>> @@ -673,20 +663,16 @@ struct dc_debug_options {
>>          bool remove_disconnect_edp;
>>          unsigned int force_odm_combine; //bit vector based on otg inst
>>          unsigned int seamless_boot_odm_combine;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          unsigned int force_odm_combine_4to1; //bit vector based on otg inst
>>          bool disable_z9_mpc;
>> -#endif
>>          unsigned int force_fclk_khz;
>>          bool enable_tri_buf;
>>          bool dmub_offload_enabled;
>>          bool dmcub_emulation;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool disable_idle_power_optimizations;
>>          unsigned int mall_size_override;
>>          unsigned int mall_additional_timer_percent;
>>          bool mall_error_as_fatal;
>> -#endif
>>          bool dmub_command_table; /* for testing only */
>>          struct dc_bw_validation_profile bw_val_profile;
>>          bool disable_fec;
>> @@ -695,9 +681,7 @@ struct dc_debug_options {
>>           * watermarks are not affected.
>>           */
>>          unsigned int force_min_dcfclk_mhz;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          int dwb_fi_phase;
>> -#endif
>>          bool disable_timing_sync;
>>          bool cm_in_bypass;
>>          int force_clock_mode;/*every mode change.*/
>> @@ -729,11 +713,9 @@ struct dc_debug_options {
>>          enum det_size crb_alloc_policy;
>>          int crb_alloc_policy_min_disp_count;
>>          bool disable_z10;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool enable_z9_disable_interface;
>>          bool enable_sw_cntl_psr;
>>          union dpia_debug_options dpia_debug;
>> -#endif
>>          bool apply_vendor_specific_lttpr_wa;
>>          bool extended_blank_optimization;
>>          union aux_wake_wa_options aux_wake_wa;
>> @@ -767,11 +749,9 @@ struct dc {
>>          /* Inputs into BW and WM calculations. */
>>          struct bw_calcs_dceip *bw_dceip;
>>          struct bw_calcs_vbios *bw_vbios;
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          struct dcn_soc_bounding_box *dcn_soc;
>>          struct dcn_ip_params *dcn_ip;
>>          struct display_mode_lib dml;
>> -#endif
>>
>>          /* HW functions */
>>          struct hw_sequencer_funcs hwss;
>> @@ -780,12 +760,8 @@ struct dc {
>>          /* Require to optimize clocks and bandwidth for added/removed planes */
>>          bool optimized_required;
>>          bool wm_optimized_required;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool idle_optimizations_allowed;
>> -#endif
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool enable_c20_dtm_b0;
>> -#endif
>>
>>          /* Require to maintain clocks and bandwidth for UEFI enabled HW */
>>
>> @@ -835,9 +811,7 @@ struct dc_init_data {
>>          uint64_t log_mask;
>>
>>          struct dpcd_vendor_signature vendor_signature;
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool force_smu_not_present;
>> -#endif
>>   };
>>
>>   struct dc_callback_init {
>> @@ -1030,9 +1004,7 @@ struct dc_plane_state {
>>          struct dc_transfer_func *in_shaper_func;
>>          struct dc_transfer_func *blend_tf;
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          struct dc_transfer_func *gamcor_tf;
>> -#endif
>>          enum surface_pixel_format format;
>>          enum dc_rotation_angle rotation;
>>          enum plane_stereo_format stereo_format;
>> @@ -1169,13 +1141,11 @@ void dc_resource_state_construct(
>>                  const struct dc *dc,
>>                  struct dc_state *dst_ctx);
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   bool dc_acquire_release_mpc_3dlut(
>>                  struct dc *dc, bool acquire,
>>                  struct dc_stream_state *stream,
>>                  struct dc_3dlut **lut,
>>                  struct dc_transfer_func **shaper);
>> -#endif
>>
>>   void dc_resource_state_copy_construct(
>>                  const struct dc_state *src_ctx,
>> @@ -1306,10 +1276,8 @@ struct hdcp_caps {
>>
>>   #include "dc_link.h"
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   uint32_t dc_get_opp_for_plane(struct dc *dc, struct dc_plane_state *plane);
>>
>> -#endif
>>   /*******************************************************************************
>>    * Sink Interfaces - A sink corresponds to a display output device
>>    ******************************************************************************/
>> @@ -1433,7 +1401,6 @@ bool dc_is_dmcu_initialized(struct dc *dc);
>>
>>   enum dc_status dc_set_clock(struct dc *dc, enum dc_clock_type clock_type, uint32_t clk_khz, uint32_t stepping);
>>   void dc_get_clock(struct dc *dc, enum dc_clock_type clock_type, struct dc_clock_config *clock_cfg);
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>
>>   bool dc_is_plane_eligible_for_idle_optimizations(struct dc *dc, struct dc_plane_state *plane,
>>                                  struct dc_cursor_attributes *cursor_attr);
>> @@ -1458,13 +1425,9 @@ void dc_enable_dcmode_clk_limit(struct dc *dc, bool enable);
>>   /* cleanup on driver unload */
>>   void dc_hardware_release(struct dc *dc);
>>
>> -#endif
>> -
>>   bool dc_set_psr_allow_active(struct dc *dc, bool enable);
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   void dc_z10_restore(const struct dc *dc);
>>   void dc_z10_save_init(struct dc *dc);
>> -#endif
>>
>>   bool dc_is_dmub_outbox_supported(struct dc *dc);
>>   bool dc_enable_dmub_notifications(struct dc *dc);
>> diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
>> index 31109db02e93..fb6a2d7b6470 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
>> @@ -160,9 +160,7 @@ void dm_set_dcn_clocks(
>>                  struct dc_context *ctx,
>>                  struct dc_clocks *clks);
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   void dm_helpers_enable_periodic_detection(struct dc_context *ctx, bool enable);
>> -#endif
>>
>>   void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz);
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
>> index 951c9b60917d..26f3a55c35d7 100644
>> --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
>> +++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
>> @@ -33,9 +33,7 @@
>>   #include "dc_bios_types.h"
>>   #include "mem_input.h"
>>   #include "hubp.h"
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>   #include "mpc.h"
>> -#endif
>>   #include "dwb.h"
>>   #include "mcif_wb.h"
>>   #include "panel_cntl.h"
>> @@ -181,7 +179,6 @@ struct resource_funcs {
>>          void (*update_bw_bounding_box)(
>>                          struct dc *dc,
>>                          struct clk_bw_params *bw_params);
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool (*acquire_post_bldn_3dlut)(
>>                          struct resource_context *res_ctx,
>>                          const struct resource_pool *pool,
>> @@ -194,7 +191,7 @@ struct resource_funcs {
>>                          const struct resource_pool *pool,
>>                          struct dc_3dlut **lut,
>>                          struct dc_transfer_func **shaper);
>> -#endif
>> +
>>          enum dc_status (*add_dsc_to_stream_resource)(
>>                          struct dc *dc, struct dc_state *state,
>>                          struct dc_stream_state *stream);
>> @@ -254,10 +251,9 @@ struct resource_pool {
>>          struct hpo_dp_stream_encoder *hpo_dp_stream_enc[MAX_HPO_DP2_ENCODERS];
>>          unsigned int hpo_dp_link_enc_count;
>>          struct hpo_dp_link_encoder *hpo_dp_link_enc[MAX_HPO_DP2_LINK_ENCODERS];
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          struct dc_3dlut *mpc_lut[MAX_PIPES];
>>          struct dc_transfer_func *mpc_shaper[MAX_PIPES];
>> -#endif
>> +
>>          struct {
>>                  unsigned int xtalin_clock_inKhz;
>>                  unsigned int dccg_ref_clock_inKhz;
>> @@ -286,9 +282,7 @@ struct resource_pool {
>>          struct dmcu *dmcu;
>>          struct dmub_psr *psr;
>>
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          struct abm *multiple_abms[MAX_PIPES];
>> -#endif
>>
>>          const struct resource_funcs *funcs;
>>          const struct resource_caps *res_cap;
>> @@ -380,7 +374,6 @@ struct pipe_ctx {
>>          struct pipe_ctx *next_odm_pipe;
>>          struct pipe_ctx *prev_odm_pipe;
>>
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          struct _vcs_dpi_display_dlg_regs_st dlg_regs;
>>          struct _vcs_dpi_display_ttu_regs_st ttu_regs;
>>          struct _vcs_dpi_display_rq_regs_st rq_regs;
>> @@ -390,7 +383,7 @@ struct pipe_ctx {
>>          struct _vcs_dpi_display_e2e_pipe_params_st dml_input;
>>          int det_buffer_size_kb;
>>          bool unbounded_req;
>> -#endif
>> +
>>          union pipe_update_flags update_flags;
>>          struct dwbc *dwbc;
>>          struct mcif_wb *mcif_wb;
>> @@ -419,9 +412,7 @@ struct resource_context {
>>          bool is_hpo_dp_stream_enc_acquired[MAX_HPO_DP2_ENCODERS];
>>          unsigned int hpo_dp_link_enc_to_link_idx[MAX_HPO_DP2_LINK_ENCODERS];
>>          int hpo_dp_link_enc_ref_cnts[MAX_HPO_DP2_LINK_ENCODERS];
>> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>>          bool is_mpc_3dlut_acquired[MAX_PIPES];
>> -#endif
>>   };
>>
>>   struct dce_bw_output {
>> @@ -484,9 +475,7 @@ struct dc_state {
>>
>>          /* Note: these are big structures, do *not* put on stack! */
>>          struct dm_pp_display_configuration pp_display_cfg;
>> -#ifdef CONFIG_DRM_AMD_DC_DCN
>>          struct dcn_bw_internal_vars dcn_bw_vars;
>> -#endif
>>
>>          struct clk_mgr *clk_mgr;
>>
>> --
>> 2.35.1
>>

