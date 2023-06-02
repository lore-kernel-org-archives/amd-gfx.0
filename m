Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE78C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 13:57:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289F410E67B;
	Fri,  2 Jun 2023 13:57:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E1910E67B
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 13:57:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUZ17zAqZDLFmDi0aA6Ai0zq2oMEFLrz/kFjho2MlZ077pF6OBBSi4uVPNhj9GQkaZO+J4WYe3OXhqVZQd29Bo0B1ELHeCc6WUd1QAcOiiST1heaqDBzLI2SRku3S1aldCTEo3xtBv718WgB6Y1AJG6EBfxevgfkpFHzuRHcw5YIL7zK7t6+niLtuiCdvg+jOlxjaAm7VHhlboM17i635Nqd7A0wBGfOV0pJbyfwqGSQ/VWL2f+eJL9Dhxvxh++Otz4ucDZ6Iq139E6HQyO3yF23e7g14U0dljOXrEDEn75YspsHQ7MlXcNZD6R5f221LINmWJuuahMpaGmiVShOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MnU0r4eIbtxgOnXUtw/q+pQ/8Tz0aP9DmNVm1AOx5c=;
 b=MCiMVARVnP6aLy/gVr1nPAideid1tQoWywr64D6cgMnns/LQjpDctF3pdoe6P2yrkw2Owi474tEqP5x4YIG1FFaU3Xcz4DZNy7Sb5XQgpdgdPU0ZRZ74J0E9qkpzT8ciVu6Du+YjTlxlyS+ti72am+l0D5aqERyGAGr7vU24whvf+2pHC/FAK5UH2XT62r0K350DON8ga7xqlrIJxFugepnJuegZ1TeM+/YqbudAj46iSBW9eve96hvrrslT63eV/DGFCX1baDhTBO6nhHtjrnFnv9mdrd/3h9YPAxhHSSYgYgVZmAO+DIp6kG+nO8P7Qdu9p8gnpth1GEOjlWSa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MnU0r4eIbtxgOnXUtw/q+pQ/8Tz0aP9DmNVm1AOx5c=;
 b=nzE+PtzVn+rpzSYA2MwV3bGUYNbJ+e0dlTDCAoaeKvHYGvHOSS3GWrqfvvObM+h/Z5pcqkmYD9I+O+OzVYiL9np2nVht9/O3O+0jKcP7y+wEhfVUuygEVzKKp0ZIGAQ3aHY9vok6SS23VJD3hG8xlUxDnJtV3Ff+CctE0COr7aY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SN7PR12MB7348.namprd12.prod.outlook.com (2603:10b6:806:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 13:57:38 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::eeaf:2747:9c3b:cabb]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::eeaf:2747:9c3b:cabb%3]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 13:57:38 +0000
Message-ID: <99dd7e0a-567a-cd80-abb1-04513e84d7b9@amd.com>
Date: Fri, 2 Jun 2023 09:57:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/display: Program OTG vtotal min/max selectors
 unconditionally for DCN1+
To: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
References: <20230601170944.1770501-1-aurabindo.pillai@amd.com>
 <b354bd1e-cc68-ebe1-c9d2-14dbc63eacea@amd.com>
Content-Language: en-US, en-CA
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <b354bd1e-cc68-ebe1-c9d2-14dbc63eacea@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::29) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SN7PR12MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7bd10e-dbb3-4459-c665-08db63715324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPo/unGii8RmlTzwa/fXhcyGHp9HaiL+inh/EeF6ejct4SHt9bt8nnUpZFd+vPSD/ep2D8SA7hyqPV+R7tZ9QuWaaJgHvYkOp698QODxNnyWow32SIAhNC/3R3spWlcQJoicyhUu8ODxiObQwnsL5iiRFfynu77uCxVKVdinkJR+aBJgOQqSyUwdIkVB/wr/MRJ+f1E4yzMKb9FoLlMrr6XrkB9+XJeEQqhsmU4rl/JKoDN/FBV2eI8LfBBfTcAtkk6jlfwDsicFbIO1nEDn9o6RMoSyQbgfx+1BJHqdDUv08w04B1tKARRdPZEqVhn4kUZeRYTkeZy1DeX7gexzRhuMPFHJkmOCHz73yKcR/bD6Z4gCr2kZNKYfzYRBPr4vXXhMeyTnTZlw8u2ajh8OLqHb+9Oob8G2HPVCcTjZwno27JswHikax8NXRWyxvqPE+yrMHd9J5gLSNlAST4n1Kzoy+rA5omtvBHuxxddQMpTKgLMOuee7XMfi+KQ3RggAYJu+lx6fg59w28X4P8BxUMxXvJN6uVRXondEV+wY6OJxdBcK+L1jzzk7AG4lvUIIxhF7HVq4e2j/cH+D+QhdW4bFCZivRP+TVNRPeFbg077TdaUHENeQk8cxGwOK05uanYPMEs1JsQNzNG1/dSy54g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(316002)(186003)(6486002)(31696002)(41300700001)(6512007)(4326008)(6636002)(86362001)(2616005)(53546011)(66476007)(6506007)(36756003)(66946007)(83380400001)(31686004)(66556008)(2906002)(478600001)(37006003)(44832011)(66899021)(26005)(5660300002)(8936002)(6862004)(8676002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzF0bkRPV2xSSkNZQ1BUOHB4NlpjeERjNWNFVmRGeVlLU2lYd0RVUmQ1UFdt?=
 =?utf-8?B?VHJXekViVmJPQ09ta21SZVdRY1NSS2Z3NHBjb1Rka2JhSG1DbXowL2F6cHky?=
 =?utf-8?B?NjlBRUx6d0hpRjZ3Z0RJS0IvT3BmZkhhTm05VUg0Qk95K2VwOTltN0M1NE9s?=
 =?utf-8?B?K09QQWFmZDkrTmFBbElYTjM0VGdZcHlnUmJDMzlMOFJ1TEtMZUNhaVg2bldN?=
 =?utf-8?B?WkdUd2ZBaVlvbGtoZGFjYmhtbWp0RmxUakwyOHFkc2lkemJCek92eUVJejZ1?=
 =?utf-8?B?KzVKTUV2SlBaR2l5Z3k2dWp0dXJyaWwzSDJBUzA1cnRFK01tMS9OY1Z4N3pH?=
 =?utf-8?B?R084ZndUTFd3cnpjdjJCd0JHZkQ0TEQ3SlhySGgzVHZPUTYweklmWTFmKzFq?=
 =?utf-8?B?MXYwakFZOFc5RHFGQTdBa1hYeFFrQVRmSFJpaGgxRnN0YkFWNVp3UURXRTZD?=
 =?utf-8?B?M1lTOFY1aE1VdFlOeC9GMGJYN1kvYXBXWE1nQUxuNnpYMzZHYzFqalBqV1Ir?=
 =?utf-8?B?Qk9YSkExZExxeWlNYjVsSzJqWngwb0U2UGdrbDdRdjl6WFI5eEdDVzgyNUhx?=
 =?utf-8?B?YjhRSjY1Y0RrYXdxVlIvUEhBOFVuUVdER0daaWIreFkwSmEvU0NQem56YUM4?=
 =?utf-8?B?SVhRdXNOQ3FLRHVWbkFqTGpOdno4S3BlU1cxZkczeWhEdE1mYVdjQ0hGZGFk?=
 =?utf-8?B?dGp4b2NMbVozdE1xbUdKem53Q25PdFRIM3FYZnozT21uL3pOVzJlUlphbVZR?=
 =?utf-8?B?ckRkdzdRU3dNL0tEZ05Zdi9CR2ZFYWRYdklJaVhMWkc3TEM5SVVPNGhHbWJo?=
 =?utf-8?B?eDNLOFA4YWxXS0Fyb2txb1ZUdmlZMW92bjBiLzNGYmVyc3FXSHNOd3VhTy8w?=
 =?utf-8?B?VUhHcEhxK2VDYzJPWnFZbzAvd2llcVNWVXNQSDZCQVM1Z0xKNjRISDg3Y3g2?=
 =?utf-8?B?TXA5TytQRy9IYnlvK0Q0L2lUYU5jU3JZQnpiVXBZMmlPR0NQYk92Z1QvZE5M?=
 =?utf-8?B?RHVjOXlra0JYT1pLVExsNjRxZjNOT2V5R05UT3Y4QU1KYzBEdXd6TGNDK1JQ?=
 =?utf-8?B?b0ZqNy9tanltbVZ2ZzAzaUMrUGczeVdJMUFoN3hXNVNSMjdnQ21ESlpVcUFl?=
 =?utf-8?B?NmRFd01TeURJNTB2aG9rdEw1YmZVWWEzSGFrNnRPOHZPdVRoUDFKaXRTUDZy?=
 =?utf-8?B?dzRIb2liRjRFd3BYQjhpT2gzbjdSZm93WEt5dUV0djBEVTh4RFdtSHFjNWho?=
 =?utf-8?B?cVFQeGxvT3NUb2lZZko4aUdRbjR0L0k0alpEVHJOTlFDV0duaXZ3c1pKZGhL?=
 =?utf-8?B?cWo0M2JTZDV5WnJQMTcwWDRNT295Uk5QU3FmT1lFZEtBd1JSakNYNVlXQjl2?=
 =?utf-8?B?U0F5ZklNZm95ZXN4ck9YcE5qK2MrQlkvY0p5bXJHNnJ2MExpeXZHcTNhY0JR?=
 =?utf-8?B?eTB3REdSWEttbkQ2VWllVlBFMUV5SVp4aWpYZ1pGR080NEk2WnV3cktxcGJE?=
 =?utf-8?B?R1lBL2hyWndRa1pGWlBOMDZtQnA1N1l0WHlrVnlpMTZraXYvL2RrR2J0SVRm?=
 =?utf-8?B?akRZOVFMVUNleWVpbE9KL3h6MEVVRk1pZ0ZpdTZEek9UbGtHZ1prL28zMEF1?=
 =?utf-8?B?d1FSZ0JRcHR1Wng3NCtKbDNmY2srV2ZVU0Z5Z1ZzZEwvMWp2djlSWk1WV3pD?=
 =?utf-8?B?azg2UlJ5dTRSZ1l0enpsWTY1N0d3ait6Yy9nOE1LMUxSbXYxOVp3cjRBa1dY?=
 =?utf-8?B?U1g4UHh3VDRpdGYyNkdnRTlFV0NoSzY4SittQWRubmNwWjFFem5wQW5uWGN5?=
 =?utf-8?B?bGNTWStXSncwdFNpblRHeWhwSklpejAwSG53amhjR3VTeFlHZ1ZNcjU2dHl0?=
 =?utf-8?B?eGlQanhkV1cyWGFiTTc2Q2JYSllhcUpDL2J6Sm9HRGdVQTVIZDk1VzRZYzY1?=
 =?utf-8?B?QjY2TmZKRXIrOFNva1R4UzBXeStQeDQwc3lNRm5PQlN5K0NkWWtvNnlQeEFo?=
 =?utf-8?B?VU9kSlZNL2o5NUt5SEFXM3VzK0VlbnFoS08vZkkyeEZTaVcvZHdNaW11T2Vu?=
 =?utf-8?B?aUNwQ0lETXAvOFhXZFFyTnZ0WFhxNmhkR2p0UWlPSThVK00zZnFFeXgyWFVn?=
 =?utf-8?Q?wqB1lFaABgQGoz1h79e9yquu8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7bd10e-dbb3-4459-c665-08db63715324
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 13:57:38.2129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7S6TiODz85Yw3TbVmXoIeRbS1io6TKNJwHDVOGQQdGOxH6CwDKo/xMPhioIk5XvGqJeAMarR+VKKGp0eldfN7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7348
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
Cc: harry.wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 6/1/23 18:49, Rodrigo Siqueira Jordao wrote:
> Hi Jay,
> 
> On 6/1/23 11:09, Aurabindo Pillai wrote:
>> Due to FPO, firmware will try to change OTG timings, which would only
>> latch if min/max selectors for vtotal are written by the driver.
> 
> Could you elaborate a little bit more about this issue? Right now, do we 
> have some sort of race between firmware and driver? Is this situation 
> causing some problems that we can reproduce? If so, could you also 
> describe it?

Sure. Its not a race condition, but a programming sequence issue. For FPO/FAMS, DMCUB will try to change the output timings by writing to the OTG registers. However, the timings written directly to the OTG registers will not be honoured unless VMIN/VMAX selector registers are programmed with the right bits and trigger source is selected correctly. Its easier to do this from driver since putting the fix into DMCUB firmware will require additional state tracking on when to write these registers and when not to. Although this is the ideal solution, we would like a software solution that is simpler and faster to deploy to the end users. Once the proper solution is made, this workaround can be removed. I will add this to the commit description for v2.
> 
>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 15 +++------------
>>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |  6 ++++++
>>   2 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
>> index e1975991e075..633989fd2514 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
>> @@ -930,19 +930,10 @@ void optc1_set_drr(
>>   				OTG_FORCE_LOCK_ON_EVENT, 0,
>>   				OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
>>   				OTG_SET_V_TOTAL_MIN_MASK, 0);
>> -
>> -		// Setup manual flow control for EOF via TRIG_A
>> -		optc->funcs->setup_manual_trigger(optc);
>> -
>> -	} else {
>> -		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
>> -				OTG_SET_V_TOTAL_MIN_MASK, 0,
>> -				OTG_V_TOTAL_MIN_SEL, 0,
>> -				OTG_V_TOTAL_MAX_SEL, 0,
>> -				OTG_FORCE_LOCK_ON_EVENT, 0);
>> -
>> -		optc->funcs->set_vtotal_min_max(optc, 0, 0);
>>   	}
>> +
>> +	// Setup manual flow control for EOF via TRIG_A
>> +	optc->funcs->setup_manual_trigger(optc);
>>   }
>>   
>>   void optc1_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
>> index e0edc163d767..042ce082965f 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
>> @@ -455,6 +455,12 @@ void optc2_setup_manual_trigger(struct timing_generator *optc)
>>   {
>>   	struct optc *optc1 = DCN10TG_FROM_TG(optc);
>>   
>> +	REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
> 
> Could you align the below registers right after the open parenthesis?

Will do
> 
>> +                                OTG_V_TOTAL_MIN_SEL, 1,
>> +                                OTG_V_TOTAL_MAX_SEL, 1,
>> +                                OTG_FORCE_LOCK_ON_EVENT, 0,
> 
> Could you add a comment that describes why we want to set the above values?

This comes from hardware documentation. Inorder to change the output timings, these bits need to be set.
> 
>> +                                OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
> 
> Why do you use (1 << 1)? Why not set the value directly here? Also, in 
> the comment, I guess it should be TRIG_A.

Merely for readability. It conveys that we're setting Trigger source A, which is bit 1 of the field OTG_FORCE_LOCK_ON_EVENT.
> 
>> +
>>   	REG_SET_8(OTG_TRIGA_CNTL, 0,
>>   			OTG_TRIGA_SOURCE_SELECT, 21,
>>   			OTG_TRIGA_SOURCE_PIPE_SELECT, optc->inst,
> 
