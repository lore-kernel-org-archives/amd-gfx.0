Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6B5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 18:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48AD910EA18;
	Thu, 28 Apr 2022 18:53:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 656B510EA18
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 18:53:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StfL6MuqmuyAWHC8P2MhkwK7xCIwm8I7ceMSqjeS3f++6fIOcKpvSI2KBIRDv+4t5dcfO4WLvcqR7j9WpMH+kD1Cf2VyNUGiM2eZeSVdckBrlFxG1vsIolhhGXW4X+J5mAZbDHUKhNkhcBPgYP69icOLxmZ9Qx6G6EEBB9J6ce7JL1JOp118/U1bBjVQ2TknMdfA+2bCA9rm+hQP66hxRfhw1JmuF9rnP2uCT3QiOc+s/975YBUaELD3nRf9NVzWnnDqyl0netUe1j+O0PMkW7rB+v3SmfXmW/jqsBePeZgMQCoMJofTYJrA3d0TYNi1DunjEmuT6kpz40GkgaTcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I8U3VDjz6MojOgCNXl6mzEq9/3+2ybTTH+oeWj6GYY=;
 b=BB3eAS3dzt/n97aYzjA34wwBEy22jkoiX3eO4tlzl7GxaDE4Z702pHehM+qCjqKpn3UK6igeOr9R7NAy6A9DLRHafY/2xg0mcBV2CHskqeFcEvwSV80Tn3vMr1cAFnH1LlZpuSLHEE78+2p7fCGGUsnDUZUkjWVouzWALprU1VYvMu2BdPT0pXIL2El86bCoQFE3vt6p6v7pWN+lB26bRliNySo7W7yIQ2A2XvC29GIO7pZEVqqSbKS7rubQmpmuV2KTS6vNCM62J1uoQYTXpI2tijxFdmtFUsFtmgIyQ5k92IpDQZ7P65QJ5ntiTa3Xe7xlD6x6gsBJOWB1RzoXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I8U3VDjz6MojOgCNXl6mzEq9/3+2ybTTH+oeWj6GYY=;
 b=QvuwvXKlllynRorxyHgFF10A8AKGykbNSYUNEuBnlZ1miB3Cbf4kUFNULhc2dLv3yn3M6FfSMlweHPmoDSulcYdVc3hAnNswCAWPxkof/WL+ya0jti+jJPm+hMEF8f1NXZsxeAauopYhTUsdy75M++FqH0Be90VAYl7xlM8U2go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 28 Apr
 2022 18:53:01 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:53:01 +0000
Message-ID: <32353932-35b8-4ca1-7d9f-cc81bd26d090@amd.com>
Date: Thu, 28 Apr 2022 14:52:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amd/display: Avoid reading audio pattern past
 AUDIO_CHANNELS_COUNT
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20220428174118.131226-1-harry.wentland@amd.com>
 <CADnq5_PuvUcUUUXs80x8A87pkVV718U-mYbHnkuOTaNXs40Edw@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_PuvUcUUUXs80x8A87pkVV718U-mYbHnkuOTaNXs40Edw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:610:20::37) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0528f6b-41a2-4348-b483-08da29485180
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB133849AD64272748F9EDC6A68CFD9@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UhiDZ0s+QhttkNar3/hddYXRQ0BivW0ZZu5aBQdueAsO9BJmEpf7cJ4vxh9SibABP26naTh+YxdB27C3DZsKBX9agHab/OP5afz3dy5GLdq2axjAOHTHDfikxcrknEczqMJrfXd7Udb0B3yp0ByR47Z4zFAySVlTlqrlfdzkXvEsXDF4QMoYmi0Q4LTMTNDeY9duy3xlbcVbLk7jDraLIQZa9wOFCbxnZVOic071h0KRlLl1wHluzpsUbixTJDMSo8SYI+qD26ZV9k+gXDFDw3TPjwvoPvjB8vSSv4cohR75TwdZ9lckDbB+UTYGQh+0qvIDKaG5F5L5L3QRvujK74GACKuiCxYe6nlqZ3KYQ0Zjwi89ZTjLtQElCBfEaJwyhCDdC9OuY3vstP4jpaVdasJDe6+Z5EBnVNY2Bj6NuiYZwzRujmLx4m8T+99EcN6W6MG9jLdpSM+Xbas0pM1uXS1pBD9dT2CmKBxXsDTbq8j562Txws1o4Jb1DSgWPkTpDEqogZ+R19vPrb9qBs9WYx5BmP+/98jPh3LTK5FKwdb4NC992eTE4EwNfGbKl0Va2znXqYPld43wJ+G7tMn+42Mw/qhwa/sBrUJTB8B1KC0HX1Nlz2JWWeDPM+wZljC0ba6ZjAi8SqXHMXuqD+iryFe+gmf68zOfGxt3qcU59MKuTIL53VheYDQfpgk5sH7+tQGLWd94HHJz35QOPyjB1HEsU5ojwzflFKSPmsJnrTM3/WcZ0OwnZzwBouMpgxD9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(38100700002)(53546011)(4326008)(8676002)(86362001)(316002)(6512007)(186003)(6506007)(31686004)(2906002)(8936002)(2616005)(6486002)(44832011)(5660300002)(36756003)(83380400001)(66476007)(31696002)(26005)(508600001)(6916009)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WC9ncDlYOEROUjFsVkFRcXo2R1NFUlNPOTFJZDlQR3luMUc4ZmdDOHgvMndC?=
 =?utf-8?B?NzE0Y2xvQys0QXI2RkZqazM4NVRUczhFWUJhTkVvbmczcXRUeEhUK2lGUFEv?=
 =?utf-8?B?MjlES09zcUxtQUducXI3amR6OUdRSWtaejczZDdRRHYwSG9hejNheVFaUzRH?=
 =?utf-8?B?elBLODFXcmwwNW1UbXN3c2VJaW5udXo0d2JrS0I0VStHeFdxanRIbENWSTVF?=
 =?utf-8?B?SFE4ZHNkb09wUEk4SVMrdVcwUDl0ejd3a21DL3g1UGUvSHVqWGtFcWpUS09K?=
 =?utf-8?B?OC9FMEFsaVRjdURFWEZjYUJzZExOQUh3eWZ5VUpFT281elZrVDR2QTVQWWk2?=
 =?utf-8?B?QkxjSFNQVnV4RVlycENDemlSSEo1enBTMnU2MHJNVUprck9Lcml6bUlBb0ZW?=
 =?utf-8?B?L1NVdEJXUmoxa0toODhYVnVpeFpsbVJBT292ZVY4Ymo0ZU5GOXNramhSNEth?=
 =?utf-8?B?eGVSMmZ2d1JlWmtmUW16V0ZlL3pGM1huSU1yQXJhV2ttSTR4d2tHdFA0UnBS?=
 =?utf-8?B?WkVocVh1MzAyNTdWMnE2eEpEeHAyblRUOWJzQm1IT2lZY2ExMHZGOFRWVTF5?=
 =?utf-8?B?blZzNXdweHBUU1c0dzI4azhVM1p6MWpCSFkxZWk2QnZmRGNlTzNEckp4c0Jp?=
 =?utf-8?B?TGNpa0RPMDdMYWJPTG5HQ281MUE0UE1qWlJhTW5UMk5Jd2k0bElBNXdsVk1H?=
 =?utf-8?B?QnVmVE5qWEo4RjZCQWZuQmNTVzJXUEgyNCt1WjdVdkNaUHVqcEdjMUprNEww?=
 =?utf-8?B?TXVUNjBQWlNqQmpRZ3V1aEFVaXVjbCtmMk9POWkrRkZCUGxQd1kzcGphWkZi?=
 =?utf-8?B?TG83a3RtWEdtaTVZU2ZrUnFuamszYXlRbUJSY2pTc3hMZU5HMWo2RDM5cGJJ?=
 =?utf-8?B?anFTM1l3RUtLQ2tJbjVyTEczS1hNblR1d1ZJLzNEbHdHRU1qMmtHSGVFdHBV?=
 =?utf-8?B?SndhYk55VHlsVy9mRVJkeTVTVFNQVU9FVXlOUGlDUFFNdDdTM2NLanhldkhx?=
 =?utf-8?B?SzI0ZFVTQnM3aU5rSWxWdHFWVVlDZGRvOSt4dVJSWVY3V0JPUmI1SDFGa1Js?=
 =?utf-8?B?MThaYzJmeUxMZCtVNWxDeW4rcXdoUVNDMEt4dWt4emw5SEx0MGdoekR6VEpP?=
 =?utf-8?B?NXRVWGx1Y0txMklIYTN0MktQMy9MOFEvdWpSL1U0eDV0cUpFNFFFQzVkaS9y?=
 =?utf-8?B?WGV1TDhTalZOSGF1REpkUWx2SE5KdkwxK2IwazlkZDhSSWtMZnJ3cjUzWWZ2?=
 =?utf-8?B?NGMrcVgvSzdrbHVqSGNjK05YWkYxNDVsNVRhSEZ6MEdEdUxlVnk5bTJoVHJQ?=
 =?utf-8?B?alpPRWVpUDBKTWRITHBETDJEOXN4YlVoaGgwRDN2djJnVFlia281bGxwYkx0?=
 =?utf-8?B?bXc5ZnhZdnBGSE1MSXFmSW10UmpaVjJxYjBJZG9rQjgyUkU1eGN5VWQvVWQ5?=
 =?utf-8?B?WTh3RW12bTJzSmJDbkQ3bjVLb2RrLzRhMTRpREJua0MreERJNEtScWtFdlMy?=
 =?utf-8?B?cVhmNjlVRHNNZ0ZBeGl6RVNneTY0TWQ5VG1GK1JzRjZjcCtQUnc0K3hqNm5Z?=
 =?utf-8?B?WVVhajhPZC9zU0swaENFVk84RDB5cXVyeGNGTEdjWU5OTlcxT0xjdjVKV1JU?=
 =?utf-8?B?UzVjNVRIOGhiTFFzUDllRGMwbEdqSlBjVVlIYTkxR0s3TXpDWjFES28zU0tS?=
 =?utf-8?B?cVpET2I0VWtEb2pLbE9KQWlOK3hTWFY3TDk4blRJTDJyek14OEZLMEd4cm1Y?=
 =?utf-8?B?WlZBNTQ2bW1OQVZGcXFFVlZYSm5rT1lHLzAvUDdTUjNjT1dSWDdYdjNPRGZv?=
 =?utf-8?B?eEVNTXZOSlZ2ODYxMHJIcmt1d0sxRWc3RmU3WlpUanViaUlEWTdJcHo5RTY4?=
 =?utf-8?B?ZmZ2UXhDV0Jjdkc5Y1BqbkZFNSswaXdsT1pXRjNuYjJrUmNHSmt3QTMzYTZh?=
 =?utf-8?B?and5d0xWNGxQODBsSGN4enk4STBTcFI0bktNeW81bXhiTncvN2pnYlN3dWlp?=
 =?utf-8?B?Yzk5TXpXWU1sKzMwOU5LS1o2cUVqQlFZN2NYbHJvcWI4L2VjTHlZMnAzVDJa?=
 =?utf-8?B?NEx1NTQ2SkRJMXpaRlhaUElPSXE0OU9lUW1CSTlSUXM4eGtwZk1uTEp4Um83?=
 =?utf-8?B?ckFJV0RLRVEyZkV2bTMzN0J3WkdQczV3TUFQbFNUc1dYRFU2dXg2MUswVHIy?=
 =?utf-8?B?M0c3ZGdTVzhpVm5PZUpCUTMzRTNsQnp4Y214RS93ZkYrc0ZsdmVjUDh0NGdk?=
 =?utf-8?B?aksrZ3dvdDBvL1NhTmJUR3VoeG5hQ2lGL3o0SHlXZmVQRHJJSVUzVHMyRFNZ?=
 =?utf-8?B?bmdFSHJkOXdZWm9PYXRld05UMWoram1CWDdYR2tadlNvQXFCRXRwZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0528f6b-41a2-4348-b483-08da29485180
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:53:00.9994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6iy5hnjWFSNLvkNnDQvhO2ARa4/BxYSzu8pN63O9Rb5egXJqrUL6979h5trvIv5e4p0mLJmlluhME1zx0IWdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-04-28 13:44, Alex Deucher wrote:
> On Thu, Apr 28, 2022 at 1:41 PM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> A faulty receiver might report an erroneous channel count. We
>> should guard against reading beyond AUDIO_CHANNELS_COUNT as
>> that would overflow the dpcd_pattern_period array.
>>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks. Merged.

Harry

> 
>> ---
>>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> index c15c46b81111..55a5a6a49fe2 100644
>> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
>> @@ -4464,7 +4464,7 @@ static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video
>>                 &dpcd_pattern_type.value,
>>                 sizeof(dpcd_pattern_type));
>>
>> -       channel_count = dpcd_test_mode.bits.channel_count + 1;
>> +       channel_count = min(dpcd_test_mode.bits.channel_count + 1, AUDIO_CHANNELS_COUNT);
>>
>>         // read pattern periods for requested channels when sawTooth pattern is requested
>>         if (dpcd_pattern_type.value == AUDIO_TEST_PATTERN_SAWTOOTH ||
>> --
>> 2.35.1
>>
