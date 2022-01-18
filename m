Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD49C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 18:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60AE810E11C;
	Tue, 18 Jan 2022 18:37:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9EE10E11C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 18:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb2HFZiXWN2dhFlHczIRWNt0PajB9XWy6WRGcq9JL4FT5ZLA7sMr3KMYLW1enWgVGFzPOXFU3LQT+MfzG1xmSWMwgNj2bA8iihUPhjRGkxpCZJHKgpJQ24tEXKQAsxnlnR3rOodmAtmpn+qQZAZjxn26TPthWofMtCSr4v9XwmV3oCEVriHdG+1MCfLgXR0+7imEqPpZg3gA0H0ftRKKEbMmwYnkqrG1fgsozd3lynUsx42LN5UmzS3VKTjySW/3RvNDFkor2TQpkfZXrK+RVxt5hXZxVMHn6nZrYIkAWFxS4PEDcUts1z+IBwfxk9X9KTQAjbs1KAHMDiY6gr2Qig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+KK36YtxAW/3BpIVzhauYDhKN0qy8aNhU4IzbmaNxQ=;
 b=X0bLV0cL9KU3CvDaCu4/4ysA1C272e8bde2xOVgztNVrGj/7WeFjQwQWBsVyKKzNJpOp6tNPW+tPa1QBajz41u8+jAY9ZoezmCfecBvXQq9g3CpJx0D+dNUJTTePvN6hN/PkNapKU1aC2f/F2q0/RhtNwoEIl69p1yof3Wxc84C/Qkg8s92w1xsIS+6M5BQ7suG46XM0Ib4Ht+/cNstrwfgnZ4nwsP+WbpmCq6wmRzhp8vlGxw4kH4tHXa31eNLhGPXjdvafj7gt3zLC5uGhbTqmgc8MxiwJO2zc+4cHVESbb4Ua0CJFQVNBg3Az299GlA/Zv7e6enhTOQbMJJMFCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+KK36YtxAW/3BpIVzhauYDhKN0qy8aNhU4IzbmaNxQ=;
 b=aakIPmLykiVd7Wk8lzfipXUd42C45E3CSn04O3jFGd2oYx1p3FCy22rTHj7im6IftinAfVHKAh4kNjE7yip0uUtmhz7gMguCUAf1oUmDB0yyHRRtSmdcCMHrD57aBUYOX40RIHa/4pNX3zb7k3Uil+30NPoEdF3gD3XN+93Ryjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2896.namprd12.prod.outlook.com (2603:10b6:208:ab::22)
 by SN6PR12MB2637.namprd12.prod.outlook.com (2603:10b6:805:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Tue, 18 Jan
 2022 18:37:56 +0000
Received: from MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3]) by MN2PR12MB2896.namprd12.prod.outlook.com
 ([fe80::44f7:66fe:4419:d8d3%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 18:37:56 +0000
Subject: Re: [PATCH v3] drm/amd/display: move calcs folder into DML
To: Isabella Basso <isabbasso@riseup.net>, alexander.deucher@amd.com,
 christian.koenig@amd.com, daniel@ffwll.ch, harry.wentland@amd.com,
 Rodrigo.Siqueira@amd.com, sunpeng.li@amd.com, Xinhui.Pan@amd.com,
 qingqing.zhuo@amd.com, jasdeep.dhillon@amd.com, mwen@igalia.com
References: <20220107213336.2116825-1-isabbasso@riseup.net>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <f254b19d-7433-6344-469c-7067671df7e4@amd.com>
Date: Tue, 18 Jan 2022 13:37:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220107213336.2116825-1-isabbasso@riseup.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0031.namprd18.prod.outlook.com
 (2603:10b6:610:55::11) To MN2PR12MB2896.namprd12.prod.outlook.com
 (2603:10b6:208:ab::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e20f58a-9ffc-424c-da56-08d9dab1a4a0
X-MS-TrafficTypeDiagnostic: SN6PR12MB2637:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26377E7A623E316AB4C95E8898589@SN6PR12MB2637.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fcxn66oIW4yc2praPV9hf18TtSixgnpwvNTFI9h6Lsgh0Ri6Qm9Ypqv6nKxvt5fq78f7vZ1mPm1uaYSWEmGpTSLZl+dB83yS5FVoNyR8ADlNxGpnPW9GXhfX/k8v1C/f3HokDS+/a0ztpSVzm78aqNc63Tw8S0la//mFkuXr2ZdSpjlREuoezEqArpeu7HbRM2ywZe4M9epQfbXXz/KqjwPZ/8+uWLHXWkwcSxvXtfUGGrAZFwX9rcDgjAgOj8Y0hQlgjyGkt5SvY/2LCxS2zRzc9waEXByEQajMV9p7rCie69g9lM2YSbn4QHGxjUe5JvZ59f4xRwNopO4QrINZZHxf222IlfC1vThlXOrLssA0id9D7qtT8ozZT2iASDvd1YMEetBtWxBmCfJq1dqbWZDfuVzkT8jcg+sxBGBWrEt1SVWaBMiH+xhLyguQ3bNr+lGhSw+OX9Ty83VDW7guqizNQN6LRy/sDaotzRAQzDj1dUYUMhHv0GifQmupHxQVIShy3834yjNaG/5e+6n2zLX/jJAVOO3WshLYQBMrOhH8caspCS39mSuqkE/j12lH5toh1x2r0IpjNycZAXXEF6GNCVhCqgoUzfplOBixeTbzZ/FAurDyb3hde85LXSnEcsB7aF2lTX4uje/QsloyNAKADOIFrMClsoFgL5Tx4D4odoWf5VtP3RGh3pxOE8nf0kTP8cQYNLFlaMPvhzpNuCwC/MoxF/NZDC42snYxHAZVp9HTjbYfD8eEUK7ZsNdJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2896.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66556008)(30864003)(66476007)(38100700002)(6666004)(66946007)(6486002)(921005)(316002)(186003)(8936002)(6512007)(53546011)(508600001)(36756003)(2906002)(31696002)(4326008)(83380400001)(2616005)(8676002)(6506007)(31686004)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVNzS2dOWmk3MUJkSEJibjVPODR6MHZDKzdKeGc3WENiTThIbGxlRVBhRG0y?=
 =?utf-8?B?ZW9tQmN3Rllkb3ZYelRMWXpaODVYK21EYy8ySklOVzBHTmJyazBiYmhHdlZ3?=
 =?utf-8?B?WFJFQzEzYWprQjJkckZvZUNoS2I5ZjhaUXM2YVdqbzBDRjJNMmJteFB2V09E?=
 =?utf-8?B?OEVXcEtEeFNMSmFnaXR4b3pkQTBHaGhzNVRoQktMZkZBTU1VNjV0QmhpTk9I?=
 =?utf-8?B?cUp6aStuS3FqWFJvMnZEWlRUR1NYRmw1SFZwUXVGWHlPZ0JNNDRHdmdGR2Qz?=
 =?utf-8?B?S3E2bWFrdjV0cENGWVhEUTdaSlZ3U2NieTJkVlQ3bnc2SUJGNW5PNXo3MWFo?=
 =?utf-8?B?alp2OE9qRzl6L05ZSkQ3L1U4T3lwUUtaeWlJc2NpaUJrZmhJbExnSGlURGNI?=
 =?utf-8?B?cERlbzB0TXU4MytiZVVmZWxHSkFZWTlFYTRaVTlScGszVDk0QnY2R0UyVXRj?=
 =?utf-8?B?VUxJQk4xdWxNWmNoakhHd3VxZUxEcGxyek9aWEJPZk9YQ245dXZtSEM3K2J0?=
 =?utf-8?B?cjdCaGhMSk9YZ3FSaGgzNHV3aDcydWh1WHM4OWZUUEJDVXB2THhmVVBsUE8w?=
 =?utf-8?B?TGt4NTNTWnl4LzNSbWwzWlZNRHN5bTF4TWZ2K05ubkVvT20wVjg4clhqYWJY?=
 =?utf-8?B?aENlMHZUVkVJUHA1UFM2K3FPYUZJS0dDdjVFbGljUFlObThyZTVReldOQlFG?=
 =?utf-8?B?Q3FNVkVrVXN1RjhRWmFnUGI4azJ3MCtadUpPM1YvUjh5OWtBc2JPM2gwTFNq?=
 =?utf-8?B?S0hrNFJDSDBrS3lmQXlXTHBSWTV4dFpUYmxtQ0R0d3VWSEh4YzhCQUFEK05u?=
 =?utf-8?B?QlJyT1FmdUlXSzd6a09RdHVYTkZ0WTZObGlWWnA1M2FOeWhvRmtGQVVCRXFu?=
 =?utf-8?B?RnczS3IyVml0M0pPM1AvSEkxRnFNUUpWY0lwMnlNWHlaUno5QlRaZWJIMm9Y?=
 =?utf-8?B?aUF5WFU4ZEUvRXlBeGxVSDREQUdxditudEJxdFZqWktoMy9jUHJISldYNlMr?=
 =?utf-8?B?L0Z5WjZ5MGZHSm0xQjUxRG1RYnFIWjFNZzc0bjI1aW9GazhvWnJvdGVFWlVs?=
 =?utf-8?B?alF0UkxPcXk3YitNN0VOemVwdVkwd2d0NFhvOFZCZE1OMzVkUW9RRlhSYUpp?=
 =?utf-8?B?WVRkRklyU0JkQUQ3YjNuU0s5Z08rcml6WXhSMkY0eU5JMWc0aklaOUJhaHBX?=
 =?utf-8?B?ZmlXRTVDT29NTEdzNmM2OTlWT2t5WEs2MDBRWU5jUUFab2JZVFBhaUV2K3c2?=
 =?utf-8?B?WklZb2d5cFVWcDMxNjB0TzkwVWxhSEtxQXROZTdnVCsrSUNpZ21wNm9NOGxU?=
 =?utf-8?B?bGpwU21zN1JwZkppM1hOOWZHZnpxb0NNRXVrWGtnTWQveU9wTXZLQ3IxNzRF?=
 =?utf-8?B?a25XbG1GMFhWTGlmTXkrcCszZTlqTFZLUUVNRVhaQnVTc3JTM2hMWmsvcWsy?=
 =?utf-8?B?Mk1QQ1NTN3QxZm1HMzZLRTdyV1pJam9wK2E2VGhWaHQ2YmIrVzhXV0RnWGx3?=
 =?utf-8?B?VHpXM1JwY3ZkbGFpd2FNcTd6MjI2TWZ6bm1aYW9saCtMY3NTVktEYXNkb3pV?=
 =?utf-8?B?cTBRb2dtQmxIQnJnRXBtd2E5QWtZd3cvRU9JUEIvaUYrNjh5eWt0OGV4TzJC?=
 =?utf-8?B?QzNPdmFPUjFhZTBGZFlmNGVCUjZHVEVmOEFsSk9zOFVwNXpUZkZaZUsyTTZ3?=
 =?utf-8?B?aVc1L0lvQnJTSUhkRWU3OW9FQ202SnhjMzM0UmZlY2FrcFRkaXVqL3VWeksr?=
 =?utf-8?B?TFJ6cm5pYXNwa2ZqczZpVGp0VlJGM1laOXdSbjJ1ck5VeUtpOW4wU1g1NTFo?=
 =?utf-8?B?S0J1Vi9mbGhYZ1RncUtHLzMwdnV6dEdjTEZxZGJja3pQZG1LSlJHUnAyYVpP?=
 =?utf-8?B?azg5QllJdG05R3RISjlEOVo5blVRRGh1WE5icVpWdUI2d0UrTW1zRTRIMmV6?=
 =?utf-8?B?ckVOcEh6a0JaQURPYTVVT3VBMm5teG1kNnJNcCtNSzkyZ0ZTK1JTUnFraGtK?=
 =?utf-8?B?cmFVSUcxbW44VFM3d0JvWmZ3a1VLQXNxdW9hcUtwSFB4R0lKT3EyakVhckJE?=
 =?utf-8?B?dDNVMjRWSk1rekZ5QXlTbnoxZFlCb1orOFoydEJURHpPK1ZvK1hYY3FiVUFu?=
 =?utf-8?B?b2NCd3ludnBzc2oyV0FDaWVIeG5NenBpdjA3TmVHTjdlTXlpMElwYWFEMlRI?=
 =?utf-8?B?bklMU0hHZHduTWMwUDUvNit1TWF4dWpwYTlMM2hsNTRXRUVTaCsyMm9jNktw?=
 =?utf-8?Q?goDiuvexH2pzXKTInv+rtxKS4138A1paFXY18HFv10=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e20f58a-9ffc-424c-da56-08d9dab1a4a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2896.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 18:37:55.9745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYP2BMs6y1FOjBNS73OikIOzZS5bCY9UoSmL1tUq00EVHmwBawYP70Unhe4EPhvXABR2Tkbqd3KlQhz6G2pEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2637
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
Cc: ~lkcamp/patches@lists.sr.ht, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-01-07 4:33 p.m., Isabella Basso wrote:
> The calcs folder has FPU code on it, which should be isolated inside the
> DML folder as per https://patchwork.freedesktop.org/series/93042/.
> 
> This commit aims single-handedly to correct the location of such FPU
> code and does not refactor any functions.
> 
> Changes since v2:
> - Corrected problems to compile when DCN was disabled.
> 
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>   drivers/gpu/drm/amd/display/dc/Makefile       |  4 +-
>   drivers/gpu/drm/amd/display/dc/calcs/Makefile | 68 -------------------
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   | 10 ++-
>   .../amd/display/dc/{ => dml}/calcs/bw_fixed.c |  0
>   .../display/dc/{ => dml}/calcs/calcs_logger.h |  0
>   .../display/dc/{ => dml}/calcs/custom_float.c |  0
>   .../display/dc/{ => dml}/calcs/dce_calcs.c    |  0
>   .../dc/{ => dml}/calcs/dcn_calc_auto.c        |  0
>   .../dc/{ => dml}/calcs/dcn_calc_auto.h        |  0
>   .../dc/{ => dml}/calcs/dcn_calc_math.c        |  0
>   .../display/dc/{ => dml}/calcs/dcn_calcs.c    |  0
>   11 files changed, 11 insertions(+), 71 deletions(-)
>   delete mode 100644 drivers/gpu/drm/amd/display/dc/calcs/Makefile
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/bw_fixed.c (100%)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/calcs_logger.h (100%)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/custom_float.c (100%)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dce_calcs.c (100%)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_auto.c (100%)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_auto.h (100%)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calc_math.c (100%)
>   rename drivers/gpu/drm/amd/display/dc/{ => dml}/calcs/dcn_calcs.c (100%)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
> index b1f0d6260226..a4ef8f314307 100644
> --- a/drivers/gpu/drm/amd/display/dc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/Makefile
> @@ -23,12 +23,12 @@
>   # Makefile for Display Core (dc) component.
>   #
>   
> -DC_LIBS = basics bios calcs clk_mgr dce gpio irq virtual
> +DC_LIBS = basics bios clk_mgr dce dml gpio irq virtual
>   
>   ifdef CONFIG_DRM_AMD_DC_DCN
>   DC_LIBS += dcn20
>   DC_LIBS += dsc
> -DC_LIBS += dcn10 dml
> +DC_LIBS += dcn10
>   DC_LIBS += dcn21
>   DC_LIBS += dcn201
>   DC_LIBS += dcn30
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> deleted file mode 100644
> index f3c00f479e1c..000000000000
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ /dev/null
> @@ -1,68 +0,0 @@
> -#
> -# Copyright 2017 Advanced Micro Devices, Inc.
> -# Copyright 2019 Raptor Engineering, LLC
> -#
> -# Permission is hereby granted, free of charge, to any person obtaining a
> -# copy of this software and associated documentation files (the "Software"),
> -# to deal in the Software without restriction, including without limitation
> -# the rights to use, copy, modify, merge, publish, distribute, sublicense,
> -# and/or sell copies of the Software, and to permit persons to whom the
> -# Software is furnished to do so, subject to the following conditions:
> -#
> -# The above copyright notice and this permission notice shall be included in
> -# all copies or substantial portions of the Software.
> -#
> -# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> -# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> -# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> -# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> -# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> -# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> -# OTHER DEALINGS IN THE SOFTWARE.
> -#
> -#
> -# Makefile for the 'calcs' sub-component of DAL.
> -# It calculates Bandwidth and Watermarks values for HW programming
> -#
> -
> -ifdef CONFIG_X86
> -calcs_ccflags := -mhard-float -msse
> -endif
> -
> -ifdef CONFIG_PPC64
> -calcs_ccflags := -mhard-float -maltivec
> -endif
> -
> -ifdef CONFIG_CC_IS_GCC
> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> -IS_OLD_GCC = 1
> -endif
> -endif
> -
> -ifdef CONFIG_X86
> -ifdef IS_OLD_GCC
> -# Stack alignment mismatch, proceed with caution.
> -# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> -# (8B stack alignment).
> -calcs_ccflags += -mpreferred-stack-boundary=4
> -else
> -calcs_ccflags += -msse2
> -endif
> -endif
> -
> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_ccflags)
> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_ccflags)
> -CFLAGS_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calcs.o := $(calcs_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_auto.o := $(calcs_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/calcs/dcn_calc_math.o := $(calcs_rcflags)
> -
> -BW_CALCS = dce_calcs.o bw_fixed.o custom_float.o
> -
> -ifdef CONFIG_DRM_AMD_DC_DCN
> -BW_CALCS += dcn_calcs.o dcn_calc_math.o dcn_calc_auto.o
> -endif
> -
> -AMD_DAL_BW_CALCS = $(addprefix $(AMDDALPATH)/dc/calcs/,$(BW_CALCS))
> -
> -AMD_DISPLAY_FILES += $(AMD_DAL_BW_CALCS)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index eee6672bd32d..2ca43e654243 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -73,6 +73,9 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
> @@ -93,10 +96,14 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
>   
> -DML = display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o \
> +DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
>   
>   ifdef CONFIG_DRM_AMD_DC_DCN
> +DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
>   DML += dcn20/dcn20_fpu.o
>   DML += display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_mode_vba_20.o
>   DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
> @@ -105,6 +112,7 @@ DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
>   DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
>   DML += dcn301/dcn301_fpu.o
>   DML += dsc/rc_calc_fpu.o
> +DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
>   endif
>   
>   AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/bw_fixed.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/bw_fixed.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/calcs_logger.h
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/calcs_logger.h
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/custom_float.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/custom_float.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/custom_float.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dce_calcs.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_auto.h
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_auto.h
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calc_math.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calc_math.c
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> similarity index 100%
> rename from drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
> rename to drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> 

Hi Isabella,

Thanks a lot for your patch.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

and applied to amd-staging-drm-next.

Thanks.
Siqueira


