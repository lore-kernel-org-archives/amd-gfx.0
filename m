Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F6AC0032E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 18:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAC9A10E5DC;
	Fri, 20 Oct 2023 18:54:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16AC810E5DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 18:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBC+9F+7ngLAAmubVBTGO7eIGIwQmvVL/GW0xoodN6VHp6Esbp7d4CqTP9S0kHtHDU9ZP4ta0A4YGuDyJ+SEarM9q7CLA2STzMYIT1w9z16qRsnn5kApxSAGvVyzFkLt2e11KPk8yV4yvcrjxzmBIlph10H5XB3M67I8v23/F/oxiucdSXsNLRjm/ybbSizijDPC8z1vnWLmeiSmknNPH6zJhvDf+73poXo07O1qSlCQjFEPMcw9U6SFfGhu34LB/ep0r+qiocprhhePpevQSQwY3PE5BOKDgBxIBvgPikYNKtCLHWWDaL8nfoN0aaQfu0lJlb7Cb7g1yWdgFXxTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXq/7AQGwIyGdlkns89vukeXp9jMJXUPWiHiNw0mtlo=;
 b=VXXNUbCOzVva5MwKHfaOcywDBOGqtoCkQgSLbZeLMjC3jvWKS830Gt+eXTU9KZKj8siqVsdcAUGKGMQ85j3cNdoC0fGLX2QL5J7t7FkAG2Qc3+WyKnsZu2JEo5OQ0HwUWqm59c3ZpzgX/qncXfK+iP8pmV/EKYRu4DjDjRI65wmPaPZL4FtG/2h8tGt8CMpWlRKsabe8FH5I4Mrxrm5Ib2AUR0HEsTUM0jYdYFxvlBEshonyBAY4o8ZTcPv+GIxtZMdz2PWEROZRNU4S+2dh9WMyDBjroiM/tCYRT3uTk31+il6cnhmJL0BJSZ/6pMOzPaQiHHUrVRGQnM6Dt7XTVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXq/7AQGwIyGdlkns89vukeXp9jMJXUPWiHiNw0mtlo=;
 b=0fleIjWEAN/45C3/7n4TLyViw6XJPABQD8JESdXq4L2XfpNIUEGCM5PUiv7z/wZ9HZtSRU7I/EqQKn2siwbNvyikAECiWOyGBDph0AI/pWyrha5jusgP20YNKXJx94iDIQwwx+9Mg2Q5boqKgBOGWVHxw4v+ckz1fEbe+9h3LYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 18:54:47 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::121e:5e68:c78a:1f2f%3]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 18:54:47 +0000
Message-ID: <7d5af5b8-131d-4365-b4fb-35567bdae33f@amd.com>
Date: Fri, 20 Oct 2023 14:54:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3]Reduce code delta with copyright notice
Content-Language: en-US
To: Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231020180734.559121-1-stylon.wang@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20231020180734.559121-1-stylon.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: c37d0c5b-5c1a-4185-dcca-08dbd19e0806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egQ/YkI3bkXZuH2fSRUT4SBKMnk0ENZbcOBKdiZUcuV8QU4gT+JiHBK/CiwcP1oeSPrWt+toWuSWs/PXSdkFZ2SqjqbGWP823WrT6HJRy2cc8NVfMQqY6tdUtWHK8u082Pqwz8jCmEW00sL+SqMspqZyIoyjwCEOSBfrediAZV4JdRuosAP26hlAG9bE5JtAUvSXnvwo+YseUuF9YbIbFyNHLP6NValynsbgt07oIGeXKAHsK5tjgHFAdGZJtHMLIHgyw6nYubSnOR1v5PmmG/Mt0y7LKzxN97xyBU4UM1DTUW63O/j+L2WzKqcDvHmlwrlxCeVdstKevZi9xEmTa1m6rZY+htzNJfGKc2A3Y8barOvcQjEL4h2i599NLZQbkeCiRGxQvbGXBHPuuQXSlzBn5wjCPMzAc/cno67mgzMYhaYePpe4t97lDjlpm1W9idq7w0d48shyv1GD4c5anHFtbVy6mGC9bf8dLewbi99Dm2uvKe4Cw8/2I9l1YjvErlm3H5nFo1ESMcK6jpy7QyGkxwVJf/9q7DiU6LP27YnhYs/L9V+5k/AKneYN5FF0M//ezY5ch7pN9xy3p5fhRxAvDW83kks0A3ozyRQeDgc7cO9wZqpTZp/BETo8/zapAH7N5+eQpy05ibycAnX9cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(6506007)(6512007)(6666004)(316002)(6486002)(66946007)(66476007)(66556008)(478600001)(83380400001)(2616005)(53546011)(2906002)(4001150100001)(5660300002)(41300700001)(15650500001)(4326008)(8936002)(8676002)(44832011)(31696002)(86362001)(38100700002)(31686004)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2wzM2gxL3lVdGRTY21oOVJYT254UTQzZTlNNk5IV3lWQmp5LzNGRVFBbk5o?=
 =?utf-8?B?VmJJWlFHcWlHb1lneGgwNFZsa1JqTHg2eEJETWxlZmkwbGtCRk9TUFY5TWlx?=
 =?utf-8?B?a0wvbnNZRlI2QlZRKzlxaVo1eVV2Q3hoSmw3Si92S3g4a3g1QlgwUlptTnlQ?=
 =?utf-8?B?V2djbEtrWjd4ZTVHV2tRcjFFQnFHcmV5RkVNcGtGbWJrWnVCTnBEV2tWTTZM?=
 =?utf-8?B?Sm53dWJuazRjUktmazFIN2V0enRZbmx1QjhXblBTc3lpY2gxV2JreXJxSEZQ?=
 =?utf-8?B?bjdvbHJGMTl1K0hlKzhFSnk0NCtEcWphWEppcUdWbXVINzdyT0dISk1yRmlm?=
 =?utf-8?B?elJoQ0FNNVJxMVVkcFI4a1hxUnNaRDcweEpSS2NPVmVsZ1ZyL0VaSVZDTTFz?=
 =?utf-8?B?ais4MVJ2am5PZEFoaExZNmxUQ3VxRjdZSzM5cm5wS2IvN1JhenhuYUxucHhV?=
 =?utf-8?B?c2RZRUtBZ0FMRG9xYlhZTjc4RnY1VUZBWmtpYko5VnpjRWc1VHFBbUhOWFdj?=
 =?utf-8?B?eUh4NXZ0aStZM092eGx0RlBjY0NtbEFOV1EwZXR1NVNvemViSmx2endTcGJl?=
 =?utf-8?B?TDYrWktKcXpVY0VPS1hzYkhBUjB1UFZaeWFDWXN6UlpRVXVJYVBMU282QkIr?=
 =?utf-8?B?MlV3dVRyUEZBSVVKZVNpVldHTkIzSThIZEtvVFV6U1FNWmNGZGcvbnRGRnh3?=
 =?utf-8?B?bk5wMS94bHNMLzlDa01xQmExM2EvcklUODQ5RW9XNzlNL1h5bXZvWE9mTk5o?=
 =?utf-8?B?ZXh4QzdsTTZNbHdKY2Z0dmwrUm1CTVNOOXZrN3k0cVc2eWJMMlpRaXIvOElo?=
 =?utf-8?B?cWRDYXlvSWZHeWJ6d01IV1YrbldCZUtaYmV0S1ZhWGc2ODNOeUx1bXVJTkdK?=
 =?utf-8?B?OFpYamlVSXZPdmFNZVJJNGQ1YUw2MkozKzV2eUsrdDQwai9FOU1nbnE0RStB?=
 =?utf-8?B?VHFoTmFyL00wa0gzZ0gxV3FtY1N3WFI2T0U0MDM3VEdhSjViUjk5a1Vudzkw?=
 =?utf-8?B?MEJHVG9RY1lQU2JsMndJcDJlbXVIR2VlVktwZ2Yxcjg5U0VMSk5HekZRYnNj?=
 =?utf-8?B?bXQ4RVYzY1phQ1BrdFRMakNWbjVqL1phNXdieXJVZnNvaUxtY2VtTW1aNEJi?=
 =?utf-8?B?MzhPYWV6TDRhTmVvdXJYTnBtRnRTdGoxUm5VRnZkSS83Q04yQWxtUjJvKzhT?=
 =?utf-8?B?RmJEeXd4VkFlZGVlWERjcjE0K3YvYU1NaWR4cDVLY1k4RUswSFphNzd3aWVn?=
 =?utf-8?B?VkZuNXNlMktDQi9jbEoyN0dtLzBxZlkvRkdxZEpTZGRqdGV2Q1NwMWFySnhu?=
 =?utf-8?B?SXpDOXp2T2ROK0tUTzRta0p2TXY3RTR1ZElpelcvYStQN3lDVUdJOEkvYndj?=
 =?utf-8?B?UDZXL0xrVVdmekJjMkpEcWtMREV3enlqVXkzai9RbS9KMUFLaW5LODM3Umhz?=
 =?utf-8?B?cFp1SU9HemJHVkZXdzVqUWw3NG9aOU1VQzN3Yk1rdjI2ZFNXc1paZitraG1C?=
 =?utf-8?B?K21qalQyWSs5Y296R2g1aUFhTWtxTnlvWVBQaFJZSlZ5WmpGZkg5OHRaZnAz?=
 =?utf-8?B?cW1yK3F4NE90N2FnK0h6Z01lajFuZE1yWmNlSCtTQ3R3aW5DVndzbURqU1lV?=
 =?utf-8?B?NFUwenp6VGcySFAvN3hIbXdvL0lpVFFURncxS2xYb1ZHaVJKRitRYzhOWWFT?=
 =?utf-8?B?VlMrWUpxSTNma2hTWlJ0dWFhTFhhWURRaktOV3UvOXRLU3NJQTFSTU04Rld4?=
 =?utf-8?B?eFV4NGZRZVUxQTZldWloa3ozaHZLWjZ2eG9RRzlrRUJFdlA5YWxmVEFtbmRB?=
 =?utf-8?B?VG50bDdTZjI5YWhyczE3ZS91OWNvUjBoUWt1UHc5eTZRcU0xM2orckVBMXgx?=
 =?utf-8?B?WGNvUU9VS1MyYUxubEpYZTEzYmIwYzA5N3lZc085MWgxeGtGTUtHWG80cWt0?=
 =?utf-8?B?UkY2UFQrRG5mdXBFSXQ5b00wL2FVQXFZVUxzNEZhc05keDA4aENRU0RZSWln?=
 =?utf-8?B?am9ZdVBkYWM1VVQ2cGE4cTFPUHM1MWxJWTIwWVZaWStRcEo0UXlab2kyaCtU?=
 =?utf-8?B?WFZzcnNNb0FSTUpsSVBmZUJuUVpXOHpxeEZrdzVSZjhaQ2tiaXJhQzJuWEp1?=
 =?utf-8?Q?0WMyBhth+kdvLKITK6Ls9uHLD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37d0c5b-5c1a-4185-dcca-08dbd19e0806
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 18:54:47.4890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRzV52e87OfHzRb/WcDLq1CWCjH3G5vt1W89ASRmJCPOBpuRxYWc83R1bR4sQ8gtX2RjH8I9IZgBh3NASbXAlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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
Cc: chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2023-10-20 14:06, Stylon Wang wrote:
> Many of the DC files have either incomplete or incorrect copyright
> notice. This patchset aims to address this and also make lives
> less difficult for those doing backport/upstream activities.
> 

Series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Stylon Wang (3):
>   drm/amd/display: Add missing copyright notice in DMUB
>   drm/amd/display: Fix copyright notice in DML2 code
>   drm/amd/display: Fix copyright notice in DC code
> 
>  .../drm/amd/display/dc/dcn303/dcn303_dccg.h   | 18 ++++++++++++++++++
>  .../drm/amd/display/dc/dcn303/dcn303_init.c   | 18 ++++++++++++++++++
>  .../drm/amd/display/dc/dcn303/dcn303_init.h   | 18 ++++++++++++++++++
>  .../amd/display/dc/dcn303/dcn303_resource.c   | 18 ++++++++++++++++++
>  .../amd/display/dc/dcn303/dcn303_resource.h   | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dcn31/Makefile |  2 +-
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.c  |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dpp.h  |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.c  |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dsc.h  |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_dwb.h  |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.c |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_init.h |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.c |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_mmhubbub.h |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.c  |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_opp.h  |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.c |  2 ++
>  .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.h  |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_resource.c |  2 ++
>  .../drm/amd/display/dc/dcn35/dcn35_resource.h |  2 ++
>  drivers/gpu/drm/amd/display/dc/dml2/Makefile  |  4 +++-
>  .../gpu/drm/amd/display/dc/dml2/cmntypes.h    |  2 ++
>  .../amd/display/dc/dml2/display_mode_core.c   |  2 ++
>  .../dc/dml2/display_mode_core_structs.h       |  2 ++
>  .../dc/dml2/display_mode_lib_defines.h        |  2 ++
>  .../amd/display/dc/dml2/display_mode_util.c   |  2 ++
>  .../amd/display/dc/dml2/display_mode_util.h   |  2 ++
>  .../display/dc/dml2/dml2_dc_resource_mgmt.c   |  2 ++
>  .../display/dc/dml2/dml2_dc_resource_mgmt.h   |  2 ++
>  .../drm/amd/display/dc/dml2/dml2_dc_types.h   |  2 ++
>  .../amd/display/dc/dml2/dml2_internal_types.h |  2 ++
>  .../amd/display/dc/dml2/dml2_mall_phantom.c   |  2 ++
>  .../amd/display/dc/dml2/dml2_mall_phantom.h   |  2 ++
>  .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |  2 ++
>  .../display/dc/dml2/dml2_translation_helper.c |  2 ++
>  .../display/dc/dml2/dml2_translation_helper.h |  2 ++
>  .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |  2 ++
>  .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 ++
>  .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 ++
>  .../gpu/drm/amd/display/dc/dml2/dml_assert.h  |  2 ++
>  .../drm/amd/display/dc/dml2/dml_depedencies.h |  2 ++
>  .../gpu/drm/amd/display/dc/dml2/dml_logging.h |  2 ++
>  drivers/gpu/drm/amd/display/dc/hdcp/Makefile  |  2 +-
>  .../amd/display/dc/hwss/dcn303/dcn303_hwseq.c | 19 +++++++++++++++++++
>  .../amd/display/dc/hwss/dcn303/dcn303_hwseq.h | 19 +++++++++++++++++++
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 ++
>  .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 ++
>  .../dc/irq/dcn201/irq_service_dcn201.c        |  2 +-
>  .../dc/irq/dcn303/irq_service_dcn303.c        | 19 +++++++++++++++++++
>  .../dc/irq/dcn303/irq_service_dcn303.h        | 19 +++++++++++++++++++
>  .../drm/amd/display/dmub/src/dmub_dcn303.c    | 19 +++++++++++++++++++
>  .../drm/amd/display/dmub/src/dmub_dcn303.h    | 19 +++++++++++++++++++
>  59 files changed, 298 insertions(+), 4 deletions(-)
> 

