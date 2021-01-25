Return-Path: <SRS0=8/fv=G4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62285C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 15:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1430B23142
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jan 2021 15:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1430B23142
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90616E1F5;
	Mon, 25 Jan 2021 15:29:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3BA89DB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jan 2021 15:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAOvldU8Gw/3E5FNFnoQnNSBqnEF6QPWHi7T34a5R+fkuU5OJjz2Ty6oYuGiBPv/t+t8DE59AdLC2UHFezGXrTHA/5dUIJGU5W49fE4JqwlRIpOtHN0EHoK07VCdvcK1MtgxHFaBb9F7mHYZ111+8jMBT3PmWMNaY1e6nar5owAIVdhHWumH7IoJ/u9VdcLbrRbk8jIJ7eSMSJTlvznpw5s/z5mGCXSvunc5dUfYGKt2/2ccTNmQGRWzZzXlPBsbtQ/dSIuafcpWu2DTRw94KDoL8o8oJxKrdxal0+Jq0ffwXu32NLE7TE3DIszHVpdHgwhfJi59I/ZaKkIwL3XO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Umuz1FhPaxIGKWQsKr4CakSeJPpL6TVGncaPI7W2k0=;
 b=kc1pIbr9TVtcBROb4i7krIU8lZeuvHbdbT0D6i+FREG+CywccpiBNrbtTHJYANwykppz8j3KClxR1331NxdHhECBz3bLrliiEKlFBUfD4ESopxcYOLP4gNJLlT0nW4t6OPFbOfBc2/XygqYC43GZIKRPUE3IIo0q7xnoplaEevXLkjnueTqcjmWElEUF1EKdGYjsXOgtRndSu+bhIo0tgGPKX6Ppqs3LmGZyuz3MEDfSTw6pbT1nEceMuMqER55K8BmClE/IQcQN92EDVD5BXaNyGzhDnaAOkECawSaBXMAgXM9hQMo0N9e50at+6t09BsKBkD/RvX0m0hgsEwp4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Umuz1FhPaxIGKWQsKr4CakSeJPpL6TVGncaPI7W2k0=;
 b=TpDLZo7CSYkXrpyAg8VcgbRh8CHNWtIX+lU/VTlKhJOMetOrgUw8P/BtquJOxsyvt/pzZhIz6uCu6r3V9zCNIucbCoAVRo03USDq5DMrzWc+LK/E9whE2i6SzceNDBrybqDBMZ5AP87Y+ODC+HdTbH+VcPZf6UIIfz13+rbfhCs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4867.namprd12.prod.outlook.com (2603:10b6:208:17e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 15:29:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3784.019; Mon, 25 Jan 2021
 15:29:39 +0000
Subject: Re: [RFC 0/7] Proposal for isolating FPU operation
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ba098912-77a3-601c-1e2d-65204ffb76bd@amd.com>
Date: Mon, 25 Jan 2021 16:29:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210125134313.305184-1-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM9P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM9P191CA0023.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21c::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.12 via Frontend Transport; Mon, 25 Jan 2021 15:29:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9bb8b577-ddaa-4656-7527-08d8c14606f0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4867:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48673D651252A71B4D77878883BD9@BL0PR12MB4867.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1GGSdnEMjOpNNuRaJTAyesXmdiGSruNoyns98/36utQ43r6tbEpaSw9+8j/7b3zK0dGzg3ff4UPmJqRWFoGoEfxPJRpWxViBw8CVOOhd5TuDBs5zABO+ajSjVDOl/jKG0qWPaIQ/4V/PFKMWlCPJHoB7wMNzdQ/3IF4pNXxZpLT3OYsDlwGJ38HHTeosmQ79R2ehsGoN96sVMm4gVi08FLSkcXzAL1Ir+m6XU2/A1+bmztnox8hbQnOqMaieBX7r6hNSwK8TOIj8Tdpefk7iehXE1qgGDer+MlExOPc7dcR021TvOkql2/uLZBzGF6v6n26kOEl+Mkea7l82PwNMiD+w5lOEwBuKXRCN+Olu+tKKvWHlqxOa3bTLDS9KLYCEwqDWkXloalZiFLe4MsT3qPaECUwOXRp6tTrjdDm/gPYKSIYT0Rm6+MnNz6QtYP7PLIrFx68ffsG5JzD/r5HPbkjjJyDMMqkxsLnwg97y7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(31696002)(6486002)(86362001)(8676002)(4326008)(83380400001)(36756003)(8936002)(186003)(6666004)(2616005)(66556008)(66476007)(478600001)(31686004)(5660300002)(52116002)(16526019)(66946007)(2906002)(316002)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDhCM3FiWTEyOWNyQVdYT1FqMU1nZGlPZ1gxM3hOQ1dEVWFDQWVVeXV1UmJn?=
 =?utf-8?B?Nlp1VEZYL1hBcDNTUk5sMFVBT2pSTzU3S0gwYU5VV1NVZnBvK0YzTDE4bVJR?=
 =?utf-8?B?R29rU0lvZWw4WVNCN1JWVFFXWmthWWxxSGNVRjhmNlJGakVkWldZbWN3cHdt?=
 =?utf-8?B?VXlMVkxZV0lPN0NrdGpMT2ZzWkd3U3pHbmNmRFF5cjFiK0U0UUdZeGFRR2pY?=
 =?utf-8?B?c0RUTG5JTEVIV1l1R2hKZ2VWNlpYUmNMTzVaZE5FY0tPbmtYM3BEeThDeHRu?=
 =?utf-8?B?bjhPbW9nVG5VNDAxRXM4Y3JKL253dDZ6TWFZK05VQWpCalFIU1NvK3E0YWF6?=
 =?utf-8?B?eDhyR3piNFpVeWtMMlJsQWlPT05FYnBBZlAzajhOaU1nQWtkYVNwZzBIVEZC?=
 =?utf-8?B?S1RqeXh1Rm9tV0U2b0hQUkdvTTRXU3FCcjhSQzhGNndFTWd1WWlRdjRudjc2?=
 =?utf-8?B?WEZoSVNhdWFvUDA5Sjc1U2NvWXd5UEhMZzZqNnFKQ2Y1clk1bVp5THIwa1FN?=
 =?utf-8?B?VlNJazU3YW1PcG1lTnEraTYvUk1GTjJPamxrUURpeVdQZW02dDBleXZjUFVw?=
 =?utf-8?B?TGRnVXdKK0hjYU50akcvbVlqT1EyeVJ3OXhmUDFKZEFIOWI0WGJqa0tEOGFV?=
 =?utf-8?B?U1lCVkxRWW12KzNyeStVNWM4dGlFYmZYTVpoelhXY1haejFpVDM0Mkt3dDdt?=
 =?utf-8?B?dlNNSldPZGgvWkw1WmhFTndJNmJFR0dodTlMMkVIbWNhNVp6MXhNaGRjRVIv?=
 =?utf-8?B?QTBPZ29qSStwYUtWQVk3d1ZHSUhISWs5SmJ4OHpFQmZhTXlPeGFWQ3k4KytI?=
 =?utf-8?B?NVNoSlU3RmRDaE4rU1dlbmUyVnZCazVVR1duT1RrWnYxdjloMkRPUTRreWdF?=
 =?utf-8?B?bDlPNWhScXFaNjltMzBXZlJPY2wwY1FMRkRvOVZadk0wMTVUUWI4UUd2VUtI?=
 =?utf-8?B?dGpjaitObmVPbEs5M3k2bWJwZlJRTis1ejUwOGxRMzAwWGFGZHlDVDM4TC9Y?=
 =?utf-8?B?YkQ3NW9UYkdNSzA5dlErSzN1Unk5OHE0TUVWVUVsem5GUEtabW9qbG5sNE5h?=
 =?utf-8?B?NVpxQ3BWb1VIay9CMEhMdmwya0FVM1EvWkhYNllSN3FYSklOSitVcmYvaWhq?=
 =?utf-8?B?ZitUd1NvWGxqUmpVdS92dy80ZERSSTlsejRXVUtoVVk4V3lrOWtjdVpsTjFG?=
 =?utf-8?B?KzV5Z212YkFHczdSQzQwcUM3ei9JV0NZTFUyWUNaMU9rN29PYWw3d2tDaFhx?=
 =?utf-8?B?MlZpSkRnYWMwMUMzdURUZnJjc0RCZjE3bFN5U3pySXRCL3B4Zkd4d3ZPc2tV?=
 =?utf-8?B?a2M4Zk9xSXhVOE9jRnlTQmVWMHBrbWlmb3czN2hYelZ0azdZSGNja09LbmZz?=
 =?utf-8?B?VjArMTJIQkVERXVRQythUkJOVlAxYXkzNlgwUjUzbW05S2o1bGZXNTVPeUpX?=
 =?utf-8?B?bWxlL2wzaG1TSmpybFZvMFJQaDVvb0Zac05mcG9BN3dRV3FTc2hCNHJjbi9j?=
 =?utf-8?Q?PomWCeDgtOXO6qOIZW07Ezj4K9y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb8b577-ddaa-4656-7527-08d8c14606f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 15:29:39.0123 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJq11c5ZrmaGYBP11Na8+Cvl6ILdP/U9LW/RkXTJQTh2QiSJQ1NeK5CLiXAsfro3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4867
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
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo,

good to see this finally be tackled. The whole approach looks solid to 
me, just one things I've noted.

> +void dcn3x_populate_dml_writeback_from_context(struct dc *dc,
> +	struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
> +{
> +	DC_FP_START();
> +	_dcn3x_populate_dml_writeback_from_context(dc, res_ctx, pipes);
> +	DC_FP_END();
> +}

The calls to DC_FP_START()/DC_FP_END() must be outside of the 
fpu_operation directory.

The problem is that even before the call to DC_FP_START() the compiler 
might think it is a good idea to use FP registers for spilling on some 
architectures.

So my understanding is that all calls of functions declared inside the 
fpu_operation directory must be made with DC_FP_START()/DC_FP_END() in 
the calleing and not the called function.

Regards,
Christian.

Am 25.01.21 um 14:43 schrieb Rodrigo Siqueira:
> Hi,
>
> In the display core, we utilize floats and doubles units for calculating
> modesetting parameters. One side effect of our approach to use double-precision
> is the fact that we spread multiple FPU access across our driver, which means
> that we can accidentally clobber user space FPU state. As an attempt to fix
> this problem, we have the following proposal:
>
> 1. We first need to move functions that deal with FPU to a single place in
>     order to make things more manageable;
> 2. After we isolate these function in a single place, we want to remove any
>     compilation flag that deals with FPU from other files and centralize it only
>     in the files that need it;
> 3. We need to implement an interface for safely calling those FPU functions.
>     The idea is to add a thin function layer where FPU functions are invoked
>     under the protection of kernel_fpu_begin/end.
>
> One of the challenges from the above steps is identifying which function uses
> FPU registers; fortunately, Peter Zijlstra wrote a patch a couple of months ago
> where he introduced an FPU check for objtool. I used the following command for
> identifying the potential FPU usage:
>
>   ./tools/objtool/objtool check -Ffa "drivers/gpu/drm/amd/display/dc/ANY_FILE.o"
>
> Based on the above command output and the step-by-step approach that we want to
> adopt, I decided to start this work focusing on DCN3 and DCN302. I believe that
> the best way to see this RFC is:
>
> 1. The first patch introduces an FPU folder inside display/dc, intending to
>     centralize functions that deal with FPU. Note that I introduced two new C
>     files named dcn3x_commons inside a new folder called fpu_operation; I used
>     the name dcn3x because some of the functions inside this folder are shared
>     with DCN301 and DCN302. In other words, all FPU function which is shared
>     across DCN3x will be placed in that file.
> 2. The next set of patches, start to move some of the function that requires
>     FPU access to the file dcn3x_commons. I did it in a small chunk to make it
>     easy to bisect in case of regressions.
> 3. Note that one of the patch touch DCN2, the reason for that is the fact that
>     the function dcn20_calculate_dlg_params is shared from DCN2 to DCN3. Because
>     of that, I create a new file named fpu_commons for keeping functions that
>     are shared across multiple ASICs.
> 4. When we move some of the functions, notice that I also add an API for
>     accessing it via fpu_kernel_begin/end.
> 5. At the end of the series, I dropped the FPU flags from the files that I
>     initialize refactored.
>
> We are also working on test stress for validating this change from the user
> space and kernel perspective.
>
> Keep in mind that this series is not done yet. I'm looking for feedback about
> this approach because we have plans to use it for trying to fix our FPU
> problems for the next couple of weeks. Finally, we want to do this work
> step-by-step because it is easy to introduce regression when dealing with these
> FPU problems.
>
> Best Regards
>
> Rodrigo Siqueira (7):
>    drm/amd/display: Introduce FPU directory inside DC
>    drm/amd/display: Moves dcn30_set_mcif_arb_params to FPU folder
>    drm/amd/display: Add FPU file for functions shared across ASICs
>    drm/amd/display: Move calculate_wm_and_dlg to FPU folder
>    drm/amd/display: Move patch bounding box to FPU folder
>    drm/amd/display: Move bounding box functions to FPU folder
>    drm/amd/display: Drop float flages from DCN30 files
>
>   drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
>   .../drm/amd/display/dc/dcn20/dcn20_resource.c | 106 +--
>   .../drm/amd/display/dc/dcn20/dcn20_resource.h |   8 -
>   .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +
>   drivers/gpu/drm/amd/display/dc/dcn30/Makefile |  30 -
>   .../drm/amd/display/dc/dcn30/dcn30_resource.c | 683 +---------------
>   .../drm/amd/display/dc/dcn30/dcn30_resource.h |  20 -
>   .../amd/display/dc/dcn301/dcn301_resource.c   |  10 +-
>   .../gpu/drm/amd/display/dc/dcn302/Makefile    |  25 -
>   .../amd/display/dc/dcn302/dcn302_resource.c   |  10 +-
>   .../drm/amd/display/dc/fpu_operation/Makefile |  58 ++
>   .../display/dc/fpu_operation/dcn3x_commons.c  | 743 ++++++++++++++++++
>   .../display/dc/fpu_operation/dcn3x_commons.h  |  44 ++
>   .../display/dc/fpu_operation/fpu_commons.c    | 145 ++++
>   .../display/dc/fpu_operation/fpu_commons.h    |  37 +
>   15 files changed, 1051 insertions(+), 871 deletions(-)
>   create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/Makefile
>   create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/dcn3x_commons.h
>   create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.c
>   create mode 100644 drivers/gpu/drm/amd/display/dc/fpu_operation/fpu_commons.h
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
