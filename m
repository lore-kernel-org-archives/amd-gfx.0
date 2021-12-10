Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32EF3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE9810E1E2;
	Fri, 10 Dec 2021 16:18:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DCF10E1E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:18:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpd/GyYqonKhRflSoN7GGr4ltbRvaVtsjSqMhUR3LatOUgo+dn+73r3JKekwVZuUc2RoejLmLKzCk4Xduutx/a/uvMmmnll+1oz3j8qITtpJy8Wp0VhXyKOx6A5KnP0F2ZIcQbyj7D0+Vw+Vj0Lr/rUuphFhWikA19BL70MWX7GZ8jqIv/C4euYJLjj5+Q1McrlX86vF0M9s5Z4JGYdSNCbvt1mdQSHZWmU1Ci1/YyqQSTammfYfRsVWOkURnHQ3YLeW8w/tD79v0dB2VjMcGzJqOnLau9aenlgHu57pSFxCptNh12v5ICfyBptJWjFrITf6Y1jB+SD1A+Yd9/aDjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JeDPnANzqZej0/ICXXDmF1XMqdLekC7pkE4KwONLWI=;
 b=FNYuJUVeJm+fQXA5wODOfhfRWyUpdHAOsZF5HeihAcpt1Ee7NbybWLYGTycTPiH8ZX+ZY+1NYe5yZKy+VS7T5RSm8PB6BwWvkGCrMYRucWkSGRmfUt5baS0pYG25J3VUlz5C5h5tSFMKYum64GF5YMiz8b9bYkLFxqjb49hFkP39ZO+JeFAfWyz11XDmPoUmXryNew1PU7+B8amPYi07R4SiWtUWu9TmfPYzz2LoNJEnA5oxW0+liYJUVe58thiDyObTPAWq/zCrYgc/1+0rbWd+QFn8ToEMuoZKdPeG++gNGXOMiGmuoU56WPxVPfGq3d+4wn8WaYHkIJmCyWD0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JeDPnANzqZej0/ICXXDmF1XMqdLekC7pkE4KwONLWI=;
 b=qEgbeWwzLMsvE0OLoiOjHfSKBZBQ6td7325gGr2CDWC7CGZPgFJsIRu2E21ySOrWehzfDzJZVc4u56U6sF5CQNhghTglWSh08/T1NgPkhHPXgh0+pfCY0ixiuEknAonDe/iHOfDftQ8qIGsvXO/VzMH6Zy4kZWH47FGAzg0swZQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MWHPR12MB1775.namprd12.prod.outlook.com
 (2603:10b6:300:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Fri, 10 Dec
 2021 16:18:46 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4755.027; Fri, 10 Dec
 2021 16:18:46 +0000
Subject: Re: [PATCH 2/2] drm/amd: move variable to local scope
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211210155415.11867-1-mario.limonciello@amd.com>
 <20211210155415.11867-2-mario.limonciello@amd.com>
 <05231ce9-0c8d-509c-f5dc-27a972739501@amd.com>
 <SA0PR12MB45107A250FB6E68EAAE81428E2719@SA0PR12MB4510.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <85062ed3-5cdb-5d15-9026-9b95c8baeb73@amd.com>
Date: Fri, 10 Dec 2021 17:18:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <SA0PR12MB45107A250FB6E68EAAE81428E2719@SA0PR12MB4510.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AS8P189CA0020.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::8) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:9f71:eea0:f459:9080]
 (2a02:908:1252:fb60:9f71:eea0:f459:9080) by
 AS8P189CA0020.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 10 Dec 2021 16:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73231ab3-9fbc-4314-0481-08d9bbf8be1e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1775:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17757790DF7F920E38352E1D83719@MWHPR12MB1775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6jxaPuNK7R7ZSuaAnNjMZMDSOxPiWrjde9ZZBM9s04QgHus52vp/BTWVNqWm+zuZbQLRhi5sI5YsuKLr+jSVL1i1lbn57CeChGz29qT2YnS1+XVXGFCtvj2FgI3xfOLYpxnh8oQqWhXcDnGnCgtBdcilTv0aVJ5yITs+dgfbKgO173yO9k+AKGkaT3haU+mgRX3NK26e68mO5kdIk1PK5UBYm1q4z6yfnkXz0bg7TIOQVH2m9DmrVdRAdyFLY/06QHwv0MvpeZD0+Bu3c3qnAxs2+Scu/JXAxN+94Y08mDaQ4m+DSaGRrJ8yHLaHfR75qrwI5i37fM0Yp51q58scf8F1N4drUf2kSzF5w1PZCCu7PYtaFZyjPAKGeqrkUw46QVGy6Xj2PgJ9VS/kNBidbjsq2/FejXYHKhfsetaBYh4xJvL8HUfprpf0TJGd/slbcwpHYAZHB45GAcsydd08NDH+HUETEftKYz0+3fcWaRmAUfkYx0FkFZYM/sfz4hHzBlA4VNrA1LaxX1EDRRWaJRNKQcQUcccCYtdziXTJL3iJHEORsPdWF9iR/mBl5nYBq33WUxsktE0AsTzDqvH2bbjrdYlDkXKtvldgOoOE0SrXj0m7+xTOQ+6GYzrQF1wBit3JCrQ3YLNdAY5nNkcL6hqY+aEi19jCsiFNOf1MVbGzF7MB4cbymVOsrjhqjaYIUglfrf/Qmc755dgIhoFFm5fWKefowyTpBeOoxRzFjVLbU/RrvMCQsI3iNg589sO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(508600001)(5660300002)(53546011)(66556008)(8676002)(66476007)(2906002)(86362001)(31686004)(110136005)(36756003)(66946007)(8936002)(38100700002)(186003)(6486002)(2616005)(6666004)(31696002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VTSE45bTh2T2pNQzBFRjNHeUtsQ2U4QnM1S1ZXYUVxWWtydEJNT28zN3F1?=
 =?utf-8?B?RHZEN1NtMkNpRkdFQUxRN2dJcGtva2JydzZpNEp5WkJQb3J2NmZ0d3licVRr?=
 =?utf-8?B?dFROWW4ydFJJWnFNQlBCY1oydzV1aGNTVFdyb0xtRVMxSzYvUTB0Y3cxN1hW?=
 =?utf-8?B?N3pQSDU2M3kzUllkVkNFdFJSOFIvL0RGNEEvTTM1c3d1QlYrUTlRUE55M3JT?=
 =?utf-8?B?UGY5dmtDWmtYc2RXNnpWM3phU2c0VkdZc01TeS9peThNR1dyYy8yUUVYWFpG?=
 =?utf-8?B?cXkwL2JRSUUvOWc4ZzNnaEVWckMwWllJalc4SjZ6dVYrRk5waUZVUWNoQzdR?=
 =?utf-8?B?ZGFsUnNJdHlKRGZaa2ZULy9JRzNTRW4xSVNjR29PaHRCeUQ2bVRWS2lYdkVG?=
 =?utf-8?B?bSsxc3BsREh3VnNYTnZyRUtQMGZ2ZGxPT3lvZGNVb083cWhrZFl4V0ptMzAr?=
 =?utf-8?B?bEgweW56c2kzNTg5dytQT29VSWFBQ1dNdFBaeGI5OTh2VlVnZk1jdURyYnFM?=
 =?utf-8?B?V0luS3c2RE1RWlF1ck1yWmdzaGNzRTNmSktKQ3I3ZGZCMUJCVUplVlNDOFR4?=
 =?utf-8?B?dVNLM3VtdC9VVzN4WjRGeStXeFNiNXc2ME1tMnBuYi9oNWFmRHRDTHZ2RUUr?=
 =?utf-8?B?Rk51cGJ6bHR2N1NHT3RRMTJDVDM1MlcxOWtYZ1pqaHJQU0IwVEt3bmpuQXk1?=
 =?utf-8?B?Y0wwOXlhdEdSMUkxRTNzMUVYd1JGR1M5ZDF0MjlVYjZkYzc4cDF2OGtMdUxC?=
 =?utf-8?B?ajJYY3llWGt0ck1pQ0tTR2NWQTZ5ZDJoR3o4WjF5dlJ3TDNiT3hkZFJnVFpQ?=
 =?utf-8?B?aXhFUU1ZTkhIaXBwSHpTY0xaWWJPUFpwTkw5eCt4RXl0Nmh0a2RnVHdZSFg0?=
 =?utf-8?B?MlRNSmxYYnY2OU84TFZXS1N1MGxsM0RvazlLVkphMDRpbXp4NG9QWjlld0No?=
 =?utf-8?B?L2p3ZnFhazhkUjRzVm9OVXk3aGxHcFp5UksyWGJIZjl4T3JyeGVud2dCYUg5?=
 =?utf-8?B?aUM5NDdSVE1ZTXByeTdhTzhqNUFnMVpWOFE2dDNqVnFFeWp5eXF3NDRSRllK?=
 =?utf-8?B?WlZsVS9KUjkzUWhscmxvK0kwUjVMY3IycW83SnR4UUcrTXd5bFdqNmVBVVli?=
 =?utf-8?B?RzNUdVcwdWhkdVowVFg2cmV6ZEozb2NFMVpJSXJzZ1hlT3owdDE1ai9sTDFp?=
 =?utf-8?B?YWQxUG9tSlIyK2djWE1OelBUN0pWN1ZmcVB0aEZZL3lIenE5ZlgyR25EaUo0?=
 =?utf-8?B?b2FSalJSWEM5WW5URyt6QmR2clhCSHlxeWVreDBQVEVRM3A5MEZyMTRGYVR0?=
 =?utf-8?B?c09sYUZOZVJWcVNUTjI3QkUyb0locjlyelI5eDZ4dlZWTXUvdzBmck1TUVE1?=
 =?utf-8?B?YWt5VVZjNnpHQkNFL2F0ZDhlUDFDYStLTm9kQm54b3hhTkhibzVyYnRQUmVa?=
 =?utf-8?B?Nm8rb3JlU2JSQXdPMW9xUm9sTldSRFY3Zzc4V2wrUUVOeWZ5SmNBTE1mYUZI?=
 =?utf-8?B?dFVtZHVBVWI5L1Mrd0xwdEZVTXZMeGVYZUJmcWNHOThjelBBTEY1bTd5bGcr?=
 =?utf-8?B?QlM2ajBFOUF1TnJRSXp6UUVXazQxdVlESVI4VEVIRXN4dXZObndObU5rRGRl?=
 =?utf-8?B?cTMyR042OTFmSXlyQ2cwcmprMWw1T1JyajV2dnRtaVd3Y3VUVkM2V3lNYVpj?=
 =?utf-8?B?d0FSWmdNcElKQTFieWtqMlFlVkpObktoOFQ5aTBCVHJrK1lvbkdFOTBWT0Vl?=
 =?utf-8?B?WEpKdmZqbEE1THM5UUM5KzFoOXRELzNuRGdEdW5USitpLzFTWWMzbHRpQVVR?=
 =?utf-8?B?U1BJdnhjYTlOL1hjQ2phUGtuSzBRL1l5YWpCUzk1THFJZ0d0YUNWUTgyNUkz?=
 =?utf-8?B?dkJwZ2lvMHlOTEh4OGZ0SlFLK0taZnZVaUg2M1Z4dFJMeDQ2THNYeFBtS3k5?=
 =?utf-8?B?NEx3MmNpYi9CUlZCZFQ2cStPYXBEZVFrSDQwVkJUNmY3UGkwVW5aZGdJQ0M0?=
 =?utf-8?B?SkticUZBbE9OTkpyeFlCL1NxNkwvYmRlQXluTGJ1OC9lVlJRenpOMjR0clRz?=
 =?utf-8?B?bzJoRW1wdi9heUEybmZpU2t4Qmx6aDVWWFozb1pUQjJ4SmYwY3R5Qml5a2x0?=
 =?utf-8?B?Q1kwYjc2ajEzaTMya3BGbWdPVkJIelExbURESVFIN3ROMnVFeXNZTit6aW5i?=
 =?utf-8?Q?hJu/qtJDgvsNk932DBZY/10=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73231ab3-9fbc-4314-0481-08d9bbf8be1e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 16:18:46.7676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCgY4mRXdy7NcGG383b3GZXx9eJactQFsY3Qiv5KpH03P3O00ssiVKE+WP+olJtX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1775
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

Am 10.12.21 um 17:12 schrieb Limonciello, Mario:
> [AMD Official Use Only]
>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Friday, December 10, 2021 10:07
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 2/2] drm/amd: move variable to local scope
>>
>>
>>
>> Am 10.12.21 um 16:54 schrieb Mario Limonciello:
>>> `edp_stream` is only used when backend is enabled on eDP, don't
>>> declare the variable outside that scope.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>> index 0d6dc329dddb..fb578b311b98 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>> @@ -1798,7 +1798,6 @@ void dce110_enable_accelerated_mode(struct dc
>> *dc, struct dc_state *context)
>>>    	struct dc_stream_state *edp_streams[MAX_NUM_EDP];
>>>    	struct dc_link *edp_link_with_sink = NULL;
>>>    	struct dc_link *edp_link = NULL;
>>> -	struct dc_stream_state *edp_stream = NULL;
>>>    	struct dce_hwseq *hws = dc->hwseq;
>>>    	int edp_with_sink_num;
>>>    	int edp_num;
>>> @@ -1830,7 +1829,7 @@ void dce110_enable_accelerated_mode(struct dc
>> *dc, struct dc_state *context)
>>>    			if (edp_link->link_enc->funcs->is_dig_enabled &&
>>>    			    edp_link->link_enc->funcs->is_dig_enabled(edp_link-
>>> link_enc) &&
>>>    			    edp_link->link_status.link_active) {
>>> -				edp_stream = edp_streams[0];
>>> +				struct dc_stream_state *edp_stream =
>> edp_streams[0];
>>>    				can_apply_edp_fast_boot =
>> !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
>>
>> While you are at it, there should always be an empty line between
>> declaration and code.
> Very well, will fix it.  Can I have a tag with assumption that fix in place, or
> should I re-send?

Just fix inline, it's not a major issue anyway.

>
>> Running your patches through checkpatch.pl helps spotting such stuff.
>>
> Actually checkpatch didn't catch that.
>
> $ ./scripts/checkpatch.pl 0002-drm-amd-move-variable-to-local-scope.patch
> total: 0 errors, 0 warnings, 15 lines checked
>
> 0002-drm-amd-move-variable-to-local-scope.patch has no obvious style problems and is ready for submission.

Mhm, something is going wrong here. checkpatch.pl is complaining quite 
badly for that patch:

ERROR: DOS line endings
#169: FILE: 
drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c:1832:
+^I^I^I^Istruct dc_stream_state *edp_stream = edp_streams[0];^M$

Especially the DOS line ending is not something we can push like this, 
but could be that the AMD mail servers are messing up things once more.

Christian.

>
>> Christian.
>>
>>>    				edp_stream-
>>> apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
>>>    				if (can_apply_edp_fast_boot)

