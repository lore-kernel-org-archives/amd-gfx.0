Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C868CCA47C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED9210F385;
	Tue,  7 Jun 2022 17:58:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3B510F385
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:58:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxIeos49+UmTZzBqD3/5W2e/+PK5uLYjLjNYDPqVw/xdpaFtvKCg9B15D8wOF8LUQ9Fzc5PpAW1zAxf1Srshaip9QGD5d/7U0eRsja6QWrgvbhGRmV1Qd+VhLR0yu4dY7gozHGXcRt/rk4nvA+dbjOcIVhyURx1PkZ0Thf4xfqXT41QsYEFskXFSQxRa1zLjPzbjRyJq6P9cst0OGcp2SrHFMXkp0QEvToi7cw7viyOVRnCBJ78q9i+skfS1lS91XYkhIftcHb6SmeVGyBgJdc8HJ93AJHCZsYLqu38eKee8r8+yBv7Ect/mUXlylEfkjX4JYN9ymG54+FlrhFMYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVoq3Eu9sn473zGx5LOoBTr85QP/zJxGLpZwf98ZU/M=;
 b=jChPEXr0Eq850T40Nw0wsTQwODZDsQfyOrV0BWkd/CNySovF2iLvD8EzMfZJLZ8+vHTOav5IF06gw2mNR17NMASxoYXoDSS4TFhM+63Isp1pgjxcstfHTY3kWUZ4nUY3AwRoo227WDs9RUC1o8jw8hlww5zMd2KFNp1CPYKvcI0T1MsbxXsPBiqfR6EN3f93BTyBxtFcDJLNB2d5h/In7TWESv7f/ZEIYyPywV+kjmmdWZeHRJSsg82efW0BJIeegPEfyF4SYUPchE1gq8OqeWv3etz1+//4xwoqvhv58YydUEH0SCYjMpIBRV3Ed9ClySejSzx27mDLgFfmUrvj/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVoq3Eu9sn473zGx5LOoBTr85QP/zJxGLpZwf98ZU/M=;
 b=GzvoXuyVmr0cXECjCq/49rjNG03J5X/FAcFLeJR3vCr0VCVAMNdXZkv6B8IwDTSBpqbqj9TT5yEp+wd2td93Jjkz4hHvx5z6v0kXQOhKL3rm/Ay+HlHRYzx3amjiZRifu3cXXi2ovgjCaLPjzidyd6KxTemywMOg1q067RW8Gh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 17:58:09 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94%9]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 17:58:08 +0000
Message-ID: <4d10989e-337e-e906-bfde-7065fe8ca0ec@amd.com>
Date: Tue, 7 Jun 2022 13:58:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/amdgpu/display: Remove unnecessary typecasts and fix
 build issues
Content-Language: en-US
To: Leo <sunpeng.li@amd.com>,
 Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220607094004.946093-1-chandan.vurdigerenataraj@amd.com>
 <639ad722-f32b-0d50-4244-ae6bb0b15f23@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <639ad722-f32b-0d50-4244-ae6bb0b15f23@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:610:75::23) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc5e7801-9c46-4901-29a1-08da48af47a4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4304:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB430485B94EAA9F87F5352AD28BA59@MN2PR12MB4304.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbRvqfDRXd/Nptqhfz4WRT5UfDbJx8jxF9rnMikIqKbIomj4Az1+SCMnjcGl9atly3TlEbohWJ6UFB7U6/5tTQEuO2RCIc2SF+cEa2ZaHqRNcqC+0c1ka4CBFbU+aedV990UCJ4uwTgz0BiqOOKvVEFQC20NEP1HV5+haQbP3KFxsZRTTuzwe2yEJiKnY/v6o7pjCeFwVB1mOCzXseqt3pSk9QZ/ZEm/cNGCQ1m9qhPYou2FUtTXvbjE5byNUEjlEHWUNmhj4Qwd2rw34fbDeWwh/Bbr0zIEUWXWEcE5MUeePWMLG0JnYVvy/9msyCbp+83jRLi1yif37e2RMjwVMJ5S9m6FrhiT1+AU4764YxZEI0ehz68DCTAKB/wN5Ov31fcoqAZcDrtMmCPRnNrIneXOmTQ0UR66WBn9ML98ALJApN5jd8ECNvjR6mo0rOV6zzaioeyCTMqm8GRd/zGE8xfeHkVFygWkK/8VAqHFwW1FCW7RkJFU5JZYEbvnQVwi8FFLvk+UDmflrTeXrb5fn7dNwiZTpBYFcQE9EG0rg+17YRJLSPGly1C4e5mo4KS2DoQQOafHiaZttOqSurn4+r/RAhK7F8bYHzbbHkegZ/nWM2E188gucx6lkCZHNnu4W272YLmkDU+/U6Lw+z3W9Sq/mkW8CC7i/TFk5e10+BR0RqcGt0UqFJRfZB3QxqkXJ+6y7tnN+GBNrUm07spxjVlj1xuNLNG0O4zdUIVSXYw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(6666004)(6486002)(6512007)(316002)(6636002)(110136005)(4326008)(31686004)(8676002)(66946007)(36756003)(66476007)(66556008)(38100700002)(8936002)(44832011)(5660300002)(2906002)(2616005)(31696002)(86362001)(53546011)(83380400001)(6506007)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFLK3R1cUhGaUp2eTZNK1ErUWl5cFR2TTc3OW40WDhhb2pLL2NlUjBacUFI?=
 =?utf-8?B?b2ZVR3h1RG8yV0NteGN2WTIyTzM5bnUzQzhiYzlrbzFxdnZwSW1HTWJ0Q3pR?=
 =?utf-8?B?cXRtemZjSlRqL0xvWk1kWThTaTVqUzlkMDNyRHp0N3F5ZTJYa0NPY0luVlU1?=
 =?utf-8?B?dDZvZWE0TmpwemdQZnZZQlo2aE80UWJ6U3lZQXFTL0pRQ3lUSEMxSjc4ZS80?=
 =?utf-8?B?TXlYaXU3ekQ2YVE0alNMRmVmSEJqVzlGZnlFTDlQMGtxcDY5RUM0SHlMZjJq?=
 =?utf-8?B?ZE4wUktZWHp5akdZc0Z0S3ZNdWZ6ZU9VbC9KemU5Z0JNeitzTXF3U1R4cGtE?=
 =?utf-8?B?WERHa0N3RXdVOFFhRDJSLzdlaHlkd3pBQ3hhYytBMmZOTkUycFB5Wm1YWmFQ?=
 =?utf-8?B?VE5uUzNrWUJjRlNOYU1uaHpBQ2cxL2puVU5HQWdlMG1TVUtJOGJIZXlkVW84?=
 =?utf-8?B?b2UzN002RW9oTVlmK0NJc3VFekFlZm9pakFVc0lTVzNKd3RsSXdQcTRsWjc5?=
 =?utf-8?B?VnFUMjJOUlVGdUZXOFRsNnNPMWdOSDhLZkgwWWh0TjRlTjU5aEhicWl3QjdF?=
 =?utf-8?B?eUFINkF2QmhBaTlIdTZWdHFFRzNQZkJoaU9FR0ZQdXIybWlSbUl4TTdDNlpO?=
 =?utf-8?B?WjFxTWw1c1NvOURIS1lMUXVWNXpvNHNOaVIwdnoyRU9qUmR0ZERURlFieXJq?=
 =?utf-8?B?QVZhcHBGV0I2MTlLV1NWeVA2c05Tcy84ODIvbE44K0ZzT1lIcCtEaWZ5Zzd5?=
 =?utf-8?B?aWYxaVlaTXFvQ2xOUmV5d2gxOUxsdEpjOFA4bU16K1BqeElBdWRmVWdqRFZI?=
 =?utf-8?B?cXlNZzJhdGczaEpjOHFnNUFWczZKdnArUTlzQ2dnT0c4VmhsckJsZGlmSTVE?=
 =?utf-8?B?RmtGZzNOeUdMeWRlbWIwci95TmtaVWhoU0V3a2lUQ1ZDaU9lUGM1eGVSMWwy?=
 =?utf-8?B?ejJXdXhpSTZVckd5U0tYMVFZWklwaEVuZHUvYXc1b3lHSGJFL1ZKYVJyMklr?=
 =?utf-8?B?RzJEMzZuaWI0QXRPSWxyd2tyb1NZdkhiM3ZGYndLVGNqeGEyMUprT3RWeFh2?=
 =?utf-8?B?aUIzNDJBMWVQMnFNT2FLV1RFckRYMFpYYzZYZUJhUGJUNm9GcWl5bC90eGpJ?=
 =?utf-8?B?eDJ6Y3FWODBpcFdBMUlUMTdTZUJkWlp6aWlZMDdzSjRqa2xobHhsQWlhQStQ?=
 =?utf-8?B?R2hSMktaQW9GeXVmNXZVeHE3Yi9pNHdRd1JWWWc2bE92UitpRmV4TzZ4Y2wz?=
 =?utf-8?B?VGt2cHZwaXBGRkJHblcxb01LczNZejJ5bFdUb3Flb29IKzErSmhnakVJcTFP?=
 =?utf-8?B?OUdwTEdDbll2c3RyU1JIcW04aVJnZkZFYXlkOS9CM3pRQkxsOThkR2lCZ1p4?=
 =?utf-8?B?MzdMcWxobGhEQ0FXSE9acXFjYXMrS3IySlUyaTk3MkNjdlZVaUZ6blYvZGFO?=
 =?utf-8?B?d2UwTFhObDRJNGhEdHZrcllvdS9RemhmZmEzOWtnMmRkTlc0MGRkbzFHV2Uv?=
 =?utf-8?B?OW5mNXZITHFFVzM0V0tGQk5hSTQyU3pHMnMwemFZNFF4UmYrWnJUZVVubHBL?=
 =?utf-8?B?S0R0TDJhS0ZZb0tna3djREI4VnR5clpIRllpbytMcWZra25Jd1ovUmdUTDRM?=
 =?utf-8?B?LzQ0OGVqWlZxbjFBQVErMFZWdHJBZHlqNWpVQnpoVVVxQzhkUUpoeVlXakZR?=
 =?utf-8?B?OUJ6Y3JJNXhZUWh4WG1WOXpEOThUNU8wbFVoc3RDR1dyVVhnT1BYV0ZTOWpD?=
 =?utf-8?B?OU5oeUZjcXljclk3Vmw2WVpCdk1zY2hqM3FUMC84RytVb0prb1BoZ0pGQVNJ?=
 =?utf-8?B?ZWV6V2Q0S0RGS244NnFwUmlmWDZUUXVNMHVDQ3g4d3FSeGdzdVFabEZ3TDU1?=
 =?utf-8?B?ditoRTFCa0J5LzlzY1JJVlQxdzh4WE1NREs4NzQycWZLSGNNV0toN3BuT1FN?=
 =?utf-8?B?N2JBeXNUOWk4YmRzUk80YVpNaWpxN1ZMMVowMERwL2c3NnJHd0dUTmNRWUdF?=
 =?utf-8?B?THBQcEV5MnpQZHhjWE5zYmdKbHVGMVBRWUFrcjZXM3FDS25XV0NHQjJYWEs5?=
 =?utf-8?B?QTZZNUVUeWM4WTI2VFVkVmpyQ2xRbWhPclhpaGpDNGl1WWJ1NllhUE16WFVI?=
 =?utf-8?B?dXhvUk9tZG5sTXNreHJ4VUQ1ZWozVWxtazYvbjZXblo1Qll1cUxCZFRwVDNJ?=
 =?utf-8?B?RDFocTZnR2NZdXFocExzbmJSTEdjcHVHRE4zMHY5eGE0blFlQnA4TDdITU5t?=
 =?utf-8?B?RFNJUUVYQVRTNkR6NkZLMWg3R1dOdWgrQXk1Mjl4MU84RDF6YVo4S1lLSXVZ?=
 =?utf-8?B?Sm1QYlFvWkE2TUtxZ2t1ck1TZGR2S3RzbnRnRkFVZTQ1SkVRUElhdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5e7801-9c46-4901-29a1-08da48af47a4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 17:58:08.7263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaX0IIxwiipxVDb6+TQLxO78oYf4iRisly5I9IkKSCoav8libUDaXqhiD48bUqM+7arDT6Ci7jJl/c94XAfm4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-07 11:34, Leo wrote:
> 
> 
> On 2022-06-07 05:40, Chandan Vurdigere Nataraj wrote:
>> [Why]
>> Getting below errors:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1414:5: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
>>                                  mode_lib->vba.SourceScan[k],
>>                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1744:22: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
>>                          && (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
>>                                 ~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 2 errors generated.
>>
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5484:18: error: implicit conversion from enumeration type 'RequestType' to different enumeration type 'enum RequestType' [-Werror,-Wenum-conversion]
>>                          RequestLuma = REQ_256Bytes;
>>                                      ~ ^~~~~~~~~~~~
>> 18 errors of similar kind
>>
>> [How]
>> 1. Add typecast at relevant places
>> 2. Move the enum RequestType definition ahead of declarations
>>
>> Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>> index b77a1ae792d1..5828e60f291d 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
>> @@ -1411,7 +1411,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
>>   				v->BytePerPixelC[k],
>>   				v->BytePerPixelDETY[k],
>>   				v->BytePerPixelDETC[k],
>> -				mode_lib->vba.SourceScan[k],
>> +				(enum dm_rotation_angle) mode_lib->vba.SourceScan[k],
> 
> Hi Jay,
> 
> This seems fishy, dm_rotation_angle and scan_dirrection_class are very different enums.
> Comparing dml32_CalculateDCCConfiguration() with CalculateDCCConfiguration(), it seems dm_rotation_angle is new for DCN32. Is passing vba.SourceScan correct here?

I agree. It should be typecast to scan_direction_class
> 
> One more comment below.
> 
>>   				/* Output */
>>   				&v->DCCYMaxUncompressedBlock[k],
>>   				&v->DCCCMaxUncompressedBlock[k],
>> @@ -1741,7 +1741,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>>   	mode_lib->vba.SourceFormatPixelAndScanSupport = true;
>>   	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
>>   		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
>> -			&& (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
>> +			&& (!(!IsVertical((enum dm_rotation_angle) mode_lib->vba.SourceScan[k]))
>> +				|| mode_lib->vba.DCCEnable[k] == true)) {
>>   			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>>   		}
>>   	}
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> index 6509a84eeb64..07f3a85f8edf 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
>> @@ -5314,9 +5314,15 @@ void dml32_CalculateDCCConfiguration(
>>   		unsigned int        *IndependentBlockLuma,
>>   		unsigned int        *IndependentBlockChroma)
>>   {
>> +	typedef enum {
>> +		REQ_256Bytes,
>> +		REQ_128BytesNonContiguous,
>> +		REQ_128BytesContiguous,
>> +		REQ_NA
>> +	} RequestType;
>>   
>> -	enum RequestType   RequestLuma;
>> -	enum RequestType   RequestChroma;
>> +	RequestType   RequestLuma;
>> +	RequestType   RequestChroma;
> 
> This might need a wider cleanup, enum RequestType is defined in display_mode_enums.h and is already included in all the display_mode_vba*.c files I've come across. Unless I'm missing something, we shouldn't need to redefine RequestType.
> 
> That said, there doesn't seem to be any functional change, and it fixes a build error. So

I'm unable to repro this error. Are you using clang? If so, which version ?

> Acked-by: Leo Li <sunpeng.li@amd.com>
> 
> Thanks,
> Leo
> 
>>   
>>   	unsigned int   segment_order_horz_contiguous_luma;
>>   	unsigned int   segment_order_horz_contiguous_chroma;
>> @@ -5350,13 +5356,6 @@ void dml32_CalculateDCCConfiguration(
>>   	double   detile_buf_vp_horz_limit;
>>   	double   detile_buf_vp_vert_limit;
>>   
>> -	typedef enum {
>> -		REQ_256Bytes,
>> -		REQ_128BytesNonContiguous,
>> -		REQ_128BytesContiguous,
>> -		REQ_NA
>> -	} RequestType;
>> -
>>   	yuv420 = ((SourcePixelFormat == dm_420_8 || SourcePixelFormat == dm_420_10 ||
>>   			SourcePixelFormat == dm_420_12) ? 1 : 0);
>>   	horz_div_l = 1;
>> @@ -5527,11 +5526,11 @@ void dml32_CalculateDCCConfiguration(
>>   			RequestChroma = REQ_128BytesContiguous;
>>   	}
>>   
>> -	if (RequestLuma == (enum RequestType) REQ_256Bytes) {
>> +	if (RequestLuma == REQ_256Bytes) {
>>   		*MaxUncompressedBlockLuma = 256;
>>   		*MaxCompressedBlockLuma = 256;
>>   		*IndependentBlockLuma = 0;
>> -	} else if (RequestLuma == (enum RequestType) REQ_128BytesContiguous) {
>> +	} else if (RequestLuma == REQ_128BytesContiguous) {
>>   		*MaxUncompressedBlockLuma = 256;
>>   		*MaxCompressedBlockLuma = 128;
>>   		*IndependentBlockLuma = 128;
>> @@ -5541,11 +5540,11 @@ void dml32_CalculateDCCConfiguration(
>>   		*IndependentBlockLuma = 64;
>>   	}
>>   
>> -	if (RequestChroma == (enum RequestType) REQ_256Bytes) {
>> +	if (RequestChroma == REQ_256Bytes) {
>>   		*MaxUncompressedBlockChroma = 256;
>>   		*MaxCompressedBlockChroma = 256;
>>   		*IndependentBlockChroma = 0;
>> -	} else if (RequestChroma == (enum RequestType) REQ_128BytesContiguous) {
>> +	} else if (RequestChroma == REQ_128BytesContiguous) {
>>   		*MaxUncompressedBlockChroma = 256;
>>   		*MaxCompressedBlockChroma = 128;
>>   		*IndependentBlockChroma = 128;
> 
