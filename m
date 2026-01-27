Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98757D25931
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 15:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ED2610E590;
	Tue, 27 Jan 2026 15:16:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0cvFMEJS";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B3710E591
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 15:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEXmf2TKb8Hfwt3/Xt/yZODsrTWdW8kMU/yquTQ5aO/Uv7CBXzOL5UT1EE2CBr5Ygp2IMdPrqJYm6TKZ9x126E5CWXFJbaKFE4s0FvmHHCjDSyZ9a8YC6GWSUrqvWocN5QjOjvhzDnPmRhxQ/mUVBm1JUFphRtQGIpK3BkBpqZDBhIcMGkIVo6x19Y2kF0WVO6qJ9pjuJC2C2KI08Y5SqX0p6gn2vA4l0lgF/hXMEOzn1sqLICuA8AWhmttQ/AvDzcW0i8KsoSbY/fyBl+8HRT7/cDP0IVLZ94l6Mq84zrInc0Ddz0Z3lf4Uw8mQ4h/GQ7iPR+9cPgyRawYfc8T7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73CMLheEZfq1s4FmhK3y/nBtVHe/11uUmjC379YXWp8=;
 b=OpBzqyTC0TUKJoMLau5zQkhxTRP45i9zDxljS4T+cXnCNal+m6UD3yUH4CtwzQDgFinRwzNyf3/eqnejP+LtH5kwGl1vAwptFVn2LC/S24GM8iihxWPxprj3l4Aymk9n1C+QnHoz7B2S38RRGOloWcACzVZN0l++ALBywb4YyFTJfpBuTrC4u2rzFBRk3RhTC9HOYUOS15o82N+mdOX39ojMPJT3nzIGqwhhkgf5tpBC3gkKmFoc/msWvEEVhXrmzqZy98h7Kn/bdqI0+UEtXbqG/wNVcRrKkyF0kxRnG159sJ1do6kR1x4AE7p4ffH7GqnomZV0nPxd4ndoLXJENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73CMLheEZfq1s4FmhK3y/nBtVHe/11uUmjC379YXWp8=;
 b=0cvFMEJS+Tj+Qtfe1bhFmTuD9GFIPyq+figGwjRjLVNlklIJhlT2OGW9mCvpSmtJJhRZejHDWGpqUmtZyDx5Os3fu9+Xc3hczqhsIrmMUiNF8lK2IYEGMb3B8jmAghCl8yAya7RP9lwZXJqPvvtBFV/h9U4NHvemf5NHS1Ampls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 by DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 15:16:51 +0000
Received: from CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::fe46:74fc:53c4:46ef]) by CH3PR12MB9395.namprd12.prod.outlook.com
 ([fe80::fe46:74fc:53c4:46ef%3]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 15:16:51 +0000
Message-ID: <2dd33e57-f96e-463f-99b3-bdfa0f2d38db@amd.com>
Date: Tue, 27 Jan 2026 10:16:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdkfd: Use AMDGPU_MQD_SIZE_ALIGN in gfx11+ kfd
 mqd manager
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
References: <20260126102514.273891-1-lang.yu@amd.com>
 <20260126102514.273891-4-lang.yu@amd.com>
Content-Language: en-CA
From: "Belanger, David" <david.belanger@amd.com>
In-Reply-To: <20260126102514.273891-4-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0209.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::34) To CH3PR12MB9395.namprd12.prod.outlook.com
 (2603:10b6:610:1ce::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9395:EE_|DM6PR12MB4121:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d0e1e9-158b-46ff-80fc-08de5db718f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dU1mUjFLYUsxbmZ4eUJKWTF0ODVYRGlmelQ1RFcwbm5wM1owbVJ5VWpLcjNy?=
 =?utf-8?B?RVdNNXFhWXBydm96OFRFcTVxMVNUcXc1YUxYQXRFbFFoL0lLK05GN3gxVkVN?=
 =?utf-8?B?MUlhdHNQWCtrcmE1UWkrNkl1RC9ZRTJoT3gvTmdpSTlHWkNMRHcvV3V3YlFO?=
 =?utf-8?B?dTVCVWY4U1lFVm1RL08wSXNZSndmL3p6LzZEVnhieC8rQ3JyT2E0bllJVENI?=
 =?utf-8?B?ajA1QTBkNzNibXRCZzNwQXJiMTJhN002OTVYeFF3bS9kS0M1a2x4TGNNNGsw?=
 =?utf-8?B?Si85TFcxUUtFcGRPS2lLT0ZrcDBFdVphcEkvdHR2YmlWT0UvVlZxa3RtQTdy?=
 =?utf-8?B?WjAwQlRhaWxuWThqeXR5OEJ5aXplSWpUWnhMd0FOa0ZZdjVjOGEyZDFZb2pq?=
 =?utf-8?B?S0w0a2Fjc0JRdjRvNnJlVTJUOXNIUXl1aDhybTY1YzRLdERkUXI4Ri9CMnAy?=
 =?utf-8?B?akRPeXhEL0hSS2MvU01iOHMvK3ZKTURuS0JTdmJHZ2ZoeFJtTHdmZDVnTmgr?=
 =?utf-8?B?YnFhbzY2ZUl5MW9keTBGL2FvMmsySjBPdGtPR2RGbWJFVEJHbjBwOXZJdlNM?=
 =?utf-8?B?MGJhRElqR3FtcC9CWnl2Vk11eW0wSjVVSndudExZTFY0ODlGTGR4ZGgwdjFD?=
 =?utf-8?B?K0psRExXU2EwQ0JKcGtYNC9sWUp6TytHMElkZDc1WjBZQzRqWVp0M0tDUDZ3?=
 =?utf-8?B?U08vUjF5U3lwSE9wT1ovOE1DZzNvSEczYXM5YjZDdGY3T2lDQkRyT2ZsSits?=
 =?utf-8?B?aER0eTJ6R2kweUVQL1NWNTBuWlNaZWxCRWNWcWtTT2pmMmN1ZnFFNWhZUDNB?=
 =?utf-8?B?WWVKNzRuSU1TbHZtQm1EK1l3YSt2VlRNZXI3VmNraFU0S3hqS1QvOEpZNy9q?=
 =?utf-8?B?VW5BWTFEc0JtQnZ6WGhZejNXS3ZHUHNIY1hVdHBGQ1c3Vjlnd0ZETTkxRXly?=
 =?utf-8?B?TUVzOVI1TFVuYzRmVk53T0lWZ1FaRXBOdkhxTTMyeTZ6Q2cyWEhvb2RJOHFv?=
 =?utf-8?B?Y1lRRVc2WXdNamRkQi8rTUk4VHB1anN2WlhidGdLc29JaGlaaUhyQ3lRYjl2?=
 =?utf-8?B?emppM1JxV1ZzSEVYN2hmQ3lyVjJSblE0N3NsRDFvSkJXR2tPS0E0SkUxMFpv?=
 =?utf-8?B?L2FWUU9HSWRtaWJUb3JiYWNsUFMxR3VUNXg3MXR6Q0ZMTVhnV21UMXlML2Fv?=
 =?utf-8?B?b2F2RERDQkt0SDVaaGdxOWljamxhbGNUVktzemc4N1pjNlZ0MldUR2owN1lX?=
 =?utf-8?B?YWNxUFR3OUNab0FteHdtcTBFMGVkYWtGWW1ScXAvbzFLcDFUSm1jZW01RzJ1?=
 =?utf-8?B?dXpKbTUyMFdqa25hNFpTWXNBb0NHaFF4VlNsdnYyR1ZBOW9qazV6T3hlODEz?=
 =?utf-8?B?cis3VGlBVzgxNEpoUk9pVnNOQWQrSElsRkNLdGdpQ1hjRUNvdVNXZkhWenpD?=
 =?utf-8?B?aExlK1d2V3JRdEI4MTB5UnU0YzVKY2dMcTJxT2gxbGNHY041eXRmcHA3Vkts?=
 =?utf-8?B?SlFHWmQrbUgvSE5lemF3SjB6NVBQbS8xa0o1TXo4TzZGcFB1Q3JPUWpvekNi?=
 =?utf-8?B?eithREU3ZTVVdnNKU0FPem85UXEyWVZTN0Fwd3owSXhEdmFzVUxYUTRXZzdu?=
 =?utf-8?B?U2RQMHhhdUZ5SmtlUWZCMC9NeTdvd1ZrOTVZNEJCcXh1RWRPemF4QVZLMGJt?=
 =?utf-8?B?aVNYV25kYTRsOVFZMk5tQTAvNHA0ZGZDZTROeXoxclc0U29zUVVJUE12bklT?=
 =?utf-8?B?eUNMcXFHUVQ0aSt3c3BWT045dUdGQ1B6TnQ0Skw4WG5JeUc4M0tSZWU0K0Nl?=
 =?utf-8?B?OHRYQ04wR2RYZWllVGY0QVB3MTZSbjY4cUZMMDd6YnovUTVaRlR3VEh4Z3pR?=
 =?utf-8?B?a3orSDNKNmZmMG02SCsrd3EyNmJnZFQwcUdtSVJOVlAwUDR1RzdNUUJaSlFr?=
 =?utf-8?B?T0NNdnVic0xvaTlSME9iVWw4RUF6OFhjQWZxWjMrTnV5ZThjQTc2WlEveHVs?=
 =?utf-8?B?WmJXWE83M1E2QVVIQVlWVmNsYThOYW56bTh5eGxoRjRlVU1iYXoxYzZLYTdC?=
 =?utf-8?B?MlJJRVpoSkNqQVZKNGhmOVpnWHRFOGVGSWNNd1Evcm5iZVkwNmVjSEhwNENm?=
 =?utf-8?Q?/Mgw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9395.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0tNY0RycUV4a0l0UVJXbXJwbm9kMVlKTFRpbkxDem53TVdDZ3RFOERXbWoy?=
 =?utf-8?B?NHZjbXhad1hndGpocHIvUWhHMllleWc3ci9xNE53ZHhsZ3FLVE5wQlQ1bmVq?=
 =?utf-8?B?eW5JRktlbUxGbjEzdkdhY09oV1FHZ1FoVEVBc1JXeUd3RTFaSkV5b2JyWUhr?=
 =?utf-8?B?cjYySDJrM1RBOUk4ZjgwQVlvaEwyMHgxbUFDKy9xNGdtck9WS0xBMEQ3cUs4?=
 =?utf-8?B?OVlXMmdBOFNUTkN4SHNYQVAvOHNXQXp5MUdFZW9ZTlA2SjJNL2dqbCtINUpD?=
 =?utf-8?B?R1hnS0FVNUdpUm9YY3pxQkhmZnJZZ21GVmdNRTlYZTIxOEh6WDhlM2xkSHRH?=
 =?utf-8?B?VHVDVDA2R29IbVY2eHJWYXU1Z3FYOUtqRldseitFeTdJL3dmdkIyeFM3emlG?=
 =?utf-8?B?cmowVkhWaWNMcnZKVkZ0d08zUDdKSzlDdHB6M3JXNTAvVmRla2F2cXBaRUFB?=
 =?utf-8?B?WVVGTTR4a05LV0YybGpWNkFiYU1zKzFCKzdEbFZVQy9HYVVnbDByOGpvUGI5?=
 =?utf-8?B?WkNuSmNhK1hoYlNES2RjWE12WjVhSWN1MEhxQjMyeHdKbkZVVi9IQWs5VGxs?=
 =?utf-8?B?bUh2d0pVZkszOFNoeFlodFZEa2dCVlZ3RlF5d29MamlDS0EwZWZuSzFtQzR6?=
 =?utf-8?B?NGtrSGM3VlFSekZicnc5d2JoLzhaYVpSSDBsOGo3NnJQOE5aSTJucXJNZU14?=
 =?utf-8?B?dldSRjlCbG9pTlN0eU5LaWtQRHNaT2tseUR1OXBMRjJaV2tsc1pKRU5vQjkz?=
 =?utf-8?B?cGNpclFweS8wWm9qMUNyVGl0Z2hGc1lDL2taWHVnVHY4TnpaSWFpSkhsdE4z?=
 =?utf-8?B?MlFBTXZ1cHdKMUI3MHhvekU2cFp6RUY2Q1orMWxrQlVzTzNiKzBCb0o1ajVi?=
 =?utf-8?B?ak05NTRWOUpoNUtaZUFUNnVBVVRqUjlUUjNhb2ZxbFYvN3lHNXhtOUthdEU5?=
 =?utf-8?B?dnJxZ0lEcG5UMDBvVzBWdDgvTUhhN1BuTy92S1IyRHBCWjkzZnVVMmFVQTNs?=
 =?utf-8?B?bnF6YXZEVmcxTFRuQVppVHd3YnVhc0hCMHIxdEsrbXVUbXIzc1h2WE5hWTNY?=
 =?utf-8?B?YWQ2TklWTExNRDJ5U1pyclFHeHBmMmlGSUdoMUVVOXBGZ1A4MlVqbTUrbjU4?=
 =?utf-8?B?S2FmV1dmQ2NWb1dZbm5zT1ZaRTU1WVJCUzJFOURBV1FNM3JCT2NxRjdhelY4?=
 =?utf-8?B?ZysyQ2gvUTBvdWZSdkJ5MExxd05MSTl2aW5wbk1RemQ4NGY1Q0JFVkRZdVFy?=
 =?utf-8?B?V1VaZTZaK0EvaE92STVCRytKdjFFWisvQUo4Y3pEM0pVMysxN3BHS0ZrYnB0?=
 =?utf-8?B?YU5EOHUxV04rdER5ckh0WElRTldWdGR2eGRtcktZQmVvb0xKTVJ3UWxrUGsz?=
 =?utf-8?B?TjJWZnNGUnZ4UE9UdHoxMk9waDdiUENSZXFSRDNzS1dMWEJmTUlmczFXZnpv?=
 =?utf-8?B?SVk0R1hCODJHVnd5RXJNV2oyVG1BYTk0akhOalRYekcxdCtVQklQanhRbktC?=
 =?utf-8?B?d2txelJhZWQwa2dNZllVb0Y3bUxHOFNVNFJtdmRnOU4rNzhNZDZpM0gwd1Qx?=
 =?utf-8?B?SHpxVjlVaVlCTVZDUHlma1dyU29xUzVpajE3QkZRVUFQd0ljR1hpTFZxa1h5?=
 =?utf-8?B?N3VpNmx5dXdVZFVYblBMd1UzeXJTanVQN3BPZEpYTmZJcm0xeElQZEt4V1Fv?=
 =?utf-8?B?dGdIS29rUzJyQlloS1V5ZmVLcXlUOTduY3d2L3BWME5wVXAwYUs5NktqdUJF?=
 =?utf-8?B?amVJaVRlZXZOUGYyU3VlV0t1aW5WSVNuWTRCV0R6emhmK2xaNGN2Y2VxWW53?=
 =?utf-8?B?SmdZUFRJcSsrQ2lmUVc2VmxPMjIvRCtpVklQOFdDb2RjQ0svV0hjSmJYaWRU?=
 =?utf-8?B?VEJMNlpENTg3eVFFd2xFWTJ0MVJHdGRVWkJWb25SQUNaZ3A4K0l5ZVV1cVJG?=
 =?utf-8?B?TGJsRTdoZjJLWVRid0Rxb1NOOG9rWEZMVmM4b01JL2dzcXloK0pKTW5zVkRV?=
 =?utf-8?B?MGh1TkVnUDhnTUJ3UmtSU0VlUktvcmpZeXdYVnpoaUJwMC9HelVuSnl0aGlL?=
 =?utf-8?B?Q3VURmQ3TXFyU0RYK3Z4WTRodTNGZVdhM2VUNFkwYWx2dFE5MEhEWmN6eGgv?=
 =?utf-8?B?ZGlrTGlpdFF3VW9scktIMUQwem9VckhUc21uS0tNY2FFTHl6T0NmSmFHZVAw?=
 =?utf-8?B?RklGclZQYjkzZytKdEtZTjEzMFRyZ0lQYVpGNEhSSGx3YVhoN1c4NmM4Ylpn?=
 =?utf-8?B?ODljNTdJeUpkMDhoc29HdzNESlBtZXV1SFUxQ3FwT05Xc2lMaUN3dzgvR3dW?=
 =?utf-8?Q?Etiw1MDmhGmyYJgLTO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d0e1e9-158b-46ff-80fc-08de5db718f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 15:16:51.4674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qV7o67dqHvTqisnLcQopovDgvEh7lod9P0Kl+Gp0rLv+6fnIScpdVO133PU/cze1oPbnKryGUUPPeDkSQhgu1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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


Full set reviewed.

Reviewed-by: David Belanger <david.belanger@amd.com>


On 1/26/2026 5:25 AM, Lang Yu wrote:
> MES is enabled by default from gfx11+.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  3 ++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 22 +++-----------
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  | 10 +++----
>  .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 29 ++++---------------
>  4 files changed, 17 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index ceb6566ff3e1..d88d0de58edd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -292,6 +292,9 @@ void kfd_get_hiq_xcc_mqd(struct kfd_node *dev, struct kfd_mem_obj *mqd_mem_obj,
>  uint64_t kfd_mqd_stride(struct mqd_manager *mm,
>  			struct queue_properties *q)
>  {
> +	if (KFD_GC_VERSION(mm->dev) >= IP_VERSION(11, 0, 0))
> +		return AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
> +
>  	return mm->mqd_size;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 5c44d0987737..7e5a7ab6d0c0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -102,20 +102,11 @@ static void set_priority(struct v11_compute_mqd *m, struct queue_properties *q)
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
>  		struct queue_properties *q)
>  {
> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>  	struct kfd_node *node = mm->dev;
>  	struct kfd_mem_obj *mqd_mem_obj;
> -	int size;
> -
> -	/*
> -	 * MES write to areas beyond MQD size. So allocate
> -	 * 1 PAGE_SIZE memory for MQD is MES is enabled.
> -	 */
> -	if (node->kfd->shared_resources.enable_mes)
> -		size = PAGE_SIZE;
> -	else
> -		size = sizeof(struct v11_compute_mqd);
>  
> -	if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
> +	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>  		return NULL;
>  
>  	return mqd_mem_obj;
> @@ -127,18 +118,13 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  {
>  	uint64_t addr;
>  	struct v11_compute_mqd *m;
> -	int size;
> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>  	uint32_t wa_mask = q->is_dbg_wa ? 0xffff : 0xffffffff;
>  
>  	m = (struct v11_compute_mqd *) mqd_mem_obj->cpu_ptr;
>  	addr = mqd_mem_obj->gpu_addr;
>  
> -	if (mm->dev->kfd->shared_resources.enable_mes)
> -		size = PAGE_SIZE;
> -	else
> -		size = sizeof(struct v11_compute_mqd);
> -
> -	memset(m, 0, size);
> +	memset(m, 0, mqd_size);
>  
>  	m->header = 0xC0310800;
>  	m->compute_pipelinestat_enable = 1;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index b7ac2dea8775..a51f217329db 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -83,14 +83,11 @@ static void set_priority(struct v12_compute_mqd *m, struct queue_properties *q)
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
>  		struct queue_properties *q)
>  {
> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>  	struct kfd_node *node = mm->dev;
>  	struct kfd_mem_obj *mqd_mem_obj;
>  
> -	/*
> -	 * Allocate one PAGE_SIZE memory for MQD as MES writes to areas beyond
> -	 * struct MQD size.
> -	 */
> -	if (kfd_gtt_sa_allocate(node, PAGE_SIZE, &mqd_mem_obj))
> +	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>  		return NULL;
>  
>  	return mqd_mem_obj;
> @@ -102,11 +99,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  {
>  	uint64_t addr;
>  	struct v12_compute_mqd *m;
> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>  
>  	m = (struct v12_compute_mqd *) mqd_mem_obj->cpu_ptr;
>  	addr = mqd_mem_obj->gpu_addr;
>  
> -	memset(m, 0, PAGE_SIZE);
> +	memset(m, 0, mqd_size);
>  
>  	m->header = 0xC0310800;
>  	m->compute_pipelinestat_enable = 1;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 0b0d802a0917..d0776ba2cc99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -32,17 +32,6 @@
>  #include "amdgpu_amdkfd.h"
>  #include "kfd_device_queue_manager.h"
>  
> -#define MQD_SIZE	(2 * PAGE_SIZE)
> -
> -static uint64_t mqd_stride_v12_1(struct mqd_manager *mm,
> -				struct queue_properties *q)
> -{
> -	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
> -		return MQD_SIZE;
> -	else
> -		return PAGE_SIZE;
> -}
> -
>  static inline struct v12_1_compute_mqd *get_mqd(void *mqd)
>  {
>  	return (struct v12_1_compute_mqd *)mqd;
> @@ -148,21 +137,14 @@ static void set_priority(struct v12_1_compute_mqd *m, struct queue_properties *q
>  static struct kfd_mem_obj *allocate_mqd(struct mqd_manager *mm,
>  		struct queue_properties *q)
>  {
> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>  	struct kfd_node *node = mm->dev;
>  	struct kfd_mem_obj *mqd_mem_obj;
> -	unsigned int size;
>  
> -	/*
> -	 * Allocate two PAGE_SIZE memory for Compute MQD as MES writes to areas beyond
> -	 * struct MQD size. Size of the Compute MQD is 1 PAGE_SIZE.
> -	 * For SDMA MQD, we allocate 1 Page_size.
> -	 */
>  	if (q->type == KFD_QUEUE_TYPE_COMPUTE)
> -		size = MQD_SIZE * NUM_XCC(node->xcc_mask);
> -	else
> -		size = PAGE_SIZE;
> +		mqd_size *= NUM_XCC(node->xcc_mask);
>  
> -	if (kfd_gtt_sa_allocate(node, size, &mqd_mem_obj))
> +	if (kfd_gtt_sa_allocate(node, mqd_size, &mqd_mem_obj))
>  		return NULL;
>  
>  	return mqd_mem_obj;
> @@ -174,11 +156,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>  {
>  	uint64_t addr;
>  	struct v12_1_compute_mqd *m;
> +	u32 mqd_size = AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size);
>  
>  	m = (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
>  	addr = mqd_mem_obj->gpu_addr;
>  
> -	memset(m, 0, MQD_SIZE);
> +	memset(m, 0, mqd_size);
>  
>  	m->header = 0xC0310800;
>  	m->compute_pipelinestat_enable = 1;
> @@ -681,7 +664,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
>  		mqd->is_occupied = kfd_is_occupied_cp;
>  		mqd->mqd_size = sizeof(struct v12_1_compute_mqd);
>  		mqd->get_wave_state = get_wave_state_v12_1;
> -		mqd->mqd_stride = mqd_stride_v12_1;
> +		mqd->mqd_stride = kfd_mqd_stride;
>  #if defined(CONFIG_DEBUG_FS)
>  		mqd->debugfs_show_mqd = debugfs_show_mqd;
>  #endif

