Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EEFC5475B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 05:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F0710E0EA;
	Mon, 11 Mar 2024 05:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j9qqecpE";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C8210E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 05:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4cQ0rRQqErHRz/Jzm+rT85xOpCGL6fCUiMxOnAqnZ4dGh7ZkvSwnsSVxi7B+CFEDl5DHMNOAFvEp6lLbWxKdakrLSTLrNsUYczyD4kjWeNV4ZxwoWpia/o0f822xsYYU4zOI0syms1fJAqa2Ochfkp8KT+nCPV2Lw3W4zgI41cfdonMx1WcKqz8ZmzTfFZwJxEvZ7SNWq1YkGoKwItDzWoboJvzPF2leBJY/THS1yzApYqrDhbxrQbSaCG7/6Fupl4mwtHoPUomWLWsQeb0ZxuS6Mdl9EXk3/HUw1YzjlsJ6EIJ2iNmFVGIfOeMhLwsyrMU/D0zVTi9Sip4Dvu49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTUFSc9fPz+oSfb95ZvqXdeNy7BrytWyIbQjjHVw8IA=;
 b=JNalMboW9G33/LNspSkO1CZOYUR1GR0XxNEWmHpbu5kX/yL5FSxTRGkOkxZycgtkvmjby0y8kr3vQTttZsfNg/OPyBxMLmhqfnt0yQnvFOLLX1oyQ/WpyluSisjOtT2Ri55oNGgECRjqAUETRLPJEJH0NeLEolV5qvOGMOYMen9DJOdYAf9tqV0BGeNk3PmeSmdRi1NTDYNtwppA+xBIIRwel8AdRvIS4ZUtDWxHu/eO/qis1DroNCJxsnXXTQIc8aXNuHW7jUl1PFUuaXtKcVtirbGKMEznA9zCgmPiIvMq5C0WYirbWtHKUJ7P8TIQeC9Bt7ZXxF59/XSKaZuJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTUFSc9fPz+oSfb95ZvqXdeNy7BrytWyIbQjjHVw8IA=;
 b=j9qqecpEvKxg20gklg8PfgipX1lCK/eTYI+lQPArd5vecK7uQSNNBWcAodKd6v8OCZVbfI/ZdFm3/LRHyE0hMc//BUEgKhMDEl+YpH96M8MdXKSCLKLrMqocBjzEDOXe1DUNWr3IoJ2dqR0YTVQsRaOhkQRSYZ8kEs6sZXX3Tts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 05:41:34 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::3f8e:6745:6de7:12b3]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::3f8e:6745:6de7:12b3%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:41:34 +0000
Message-ID: <951b6dc0-8cf6-4b47-a16d-28e9d488348c@amd.com>
Date: Mon, 11 Mar 2024 13:41:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix potential index out of bounds in
 color transformation function
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Charlene Liu <Charlene.Liu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Roman Li <roman.li@amd.com>
References: <20240228091728.3237681-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240228091728.3237681-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: a52c27df-3394-47b8-018a-08dc418de916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcrw+W24RqUZ0pSd3wy39tecOzy5XH90gjybxdXMKsDEsTpl2zXm9UX71vDKUcjTa2m8r6qIyQAKY22qQVcgeqSIYbfjWbzZD/JlhR2fSH4Wh3OKxtzTDLm2QlcckD4U+hYlnaNZ1VaEHeZU6tK5HDxWOHA9DFOfQ9EAp+uHebY8DGyj2LQK9XSCQhHnBT8GH6UH4LAiA0QzhjqlkbZDjlCw3tBK11zrf527fdUyuQIMX1hCkRH/qYsTBd1hJ2aD/MmnLkSLCsouzVkx/R9xRuQQNZ1a+2nCHAnk/kfc5Hh0yBY4h2roBLK381eM2dejS3Xa5fvcs23AJ6O5r1P1aI4pggSTPUdSbsJQk/e+fQUSgaV1rdBrJBZSNTW3StKN0Y/epwujgb0YPW2anepumLfBz8OitmB/k7g1mESCAkk2s254+KJZGVNWEf0q+ItUcJfyXurWybwOelYjD/cpyGxDfDau3UbAYqXA0RjLCibgwLVFwKDwCxOrh420fOYKA8Lsh8/ZBz94fIspihttMfzciY3vwkMuk2UAqusqwNSlW39VTsVjoFyLUb63ZNfwWSMTr39BtadgeEJ06d9owwSzyUnGQGOjTbVDkxZJE6PaTxkPnbgfeP89zQ5ffBIZbHpNUAZWovvAdKVN7pSN8bhOVlyxNFaN9Z5omc9agAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXFkcFJibm9lRDBCeW9XVk94UFlwMUE5QVpJQzZuQ1RrbWhDY055OHVTY2py?=
 =?utf-8?B?S3RTaHVTUjU5eVFaWEt4azZqdlZrZjNsNmtKeWJDMHZoM0R0QjU2bzJKak9O?=
 =?utf-8?B?eklybmxxd2Uyem5ldWZieXE3U2dta3ZmRmJaVitieXdDRmVveGp0WnhBTmxK?=
 =?utf-8?B?OU1sRkV2cVZmL1ZhMEV1MHJSVkpKcTh6bkFOY092enZXeUUwMm0xY2tvU0R2?=
 =?utf-8?B?QVJJQ3h2WG1ib3VJSmdGTldmNkc4TVBXMmE0cEIxdEFaNjlaNG9XSVBFdlZq?=
 =?utf-8?B?bW1hN2tya3A0RmQrLy9IcXFBcDM0Q1BVSml2S3d6ektjRmdMWHZ6b2Z6aFAz?=
 =?utf-8?B?NGllZGVobmU2QUhSWXBtUnhNc2d1K2h5TTlsYVRtaFozcWFJc3MyTWVyYWhy?=
 =?utf-8?B?N1JqeG1tQ3VzUTVhcjFQT2tIb084R0NON09PNElqZllpekdVeXhqd0NMSjkr?=
 =?utf-8?B?ZFZMUjYvOStJRXN5cjNmTlJWb2Y0ZXc4ZVViczRQUTNOT1dHUlZyODNUSmRL?=
 =?utf-8?B?ZTJmSUhDOVEvdlI3RmFWUHZCNE5BZ0Q0RkFoWnl1YkZheDBEMHlreU13SUp6?=
 =?utf-8?B?T0diV2NzT2k3Ykl2bFlCci9qRy9hVXkzdnQxNzFna0ZwZC80NXBJN1Y0V0kz?=
 =?utf-8?B?NXFUK3dmNzNKSmQ1QVdLb0FvTVdSQm50bDNqc3dhNEhraWR6OStkeitjWWdn?=
 =?utf-8?B?REVmRkp3N2lRMWhDVS9KT1FKZWNTRHBpVUtDMWVjL3QwUXNvYUdJYldyaWli?=
 =?utf-8?B?VHdwOE1QWTJzVWV5RWRsa0R0TEsxMTF2K2xjWkpEeWlrWlN4eDJpQjVLWFVL?=
 =?utf-8?B?ZHBJUmVmaTdVMUtvcTRVQmwzZndtdWhhanZxQ1VQY21SS0QreUZXeTNPR2dO?=
 =?utf-8?B?UVdPTi9zdDdXM2xEd2dkYkZESm1hQXhlNktWbDVDRFBrTHo4UE9GVVhqRVl4?=
 =?utf-8?B?THZMamJwanZPanRnbzEvTURibCsxeGJpQjcyWm04SEt2Y1NDLytITC8vU3Zq?=
 =?utf-8?B?Q0YyL1VEN0VIVmFsWEFTN2oyM2pJdFFyYzF2OFErV1YvY09oSjhhanpjdWNX?=
 =?utf-8?B?YXp3TjJBeTgrWlp5T2J6RjZpbUtoVnRYemJVUWFhemFrMldyTDZNSEJrR1VZ?=
 =?utf-8?B?Z1JwRC9zeXpNRWhXUFZEZ1hTeUNSNmYwMHBmL2VMR1BSem83ejdlakwzaHl3?=
 =?utf-8?B?Q2N5b3h6QXFWaDNrblRVWUNRNTJNTGwyTFp3dUxlbDRDcTN6bmxKbTgvdXNl?=
 =?utf-8?B?SXNHT3ErRFhwdVpaTGRSa2hKS0t4Y25PY3FDc0UrcjhVMllDK1ZmRWZ4bHMr?=
 =?utf-8?B?ZUp0aHQ2TkV5elRkMmJETlhJRHN1aXhzWXNwRW5IY2x6SG1iOTlIbzEwb1Qy?=
 =?utf-8?B?M2tPbSs2U1pDTG1RTVFFWjhPZTlLdDJqVENGY2pQWWQ4Njh2NUtjeU5NQXVU?=
 =?utf-8?B?L1I1KzJ3V3g3dVJVczRZdW5SblF1TTFlQlFQeWFLK0NIdlovSXplMEd0T2J4?=
 =?utf-8?B?YmsrclRmZ2d3MUlSRElEcGxYVy9KM2w5VExzTjdhVmxnNlJzL2c1ckRhMFZR?=
 =?utf-8?B?ZmhJVXIvQjdBWDhVOU5OMmRPc0lza2JuWEFiTmYzS25nQlB0MFpvY2RKT0hL?=
 =?utf-8?B?a3dnUVpNWHNtaTlqTkpBbUpzZlNiaE5mblN2Q2p4alhYOXVpeFR3TWFmSEZs?=
 =?utf-8?B?YWFkU1VObzV0d3ZzekQzeGFPd0k4Y1g1Y3cwdXNDcDQ1Rm5HMFJnNk5uV2VO?=
 =?utf-8?B?bFZ5ZDlvREZFN0xwZk1nb1ZQc2xTK3Urd2srR0pKdGZDZG1PMWdKSkJiaWJ6?=
 =?utf-8?B?TFlhUkpYY0tQdENKenVOTW5uVDMzSjU0eXJ1UEo3d29iYkk2d1I5SlNIYU9O?=
 =?utf-8?B?OUpFcTk2S0M5WERjSEFVRXA3TFZlQThKeGlKVnN0Z1dOL0FObmpwdld2cW5T?=
 =?utf-8?B?dlpSd0s2Z2dKbUtmUXRpZmpFNzRsMXovellpVVhUZm56RzREMWxUSXllT0pN?=
 =?utf-8?B?cWd1VkN2WEVkRWNleG9OVldDWXJUV0llWldmRTVTOHBaeDJGYU1GRHd0eGd0?=
 =?utf-8?B?K2dMSi91WW9pdnhGU1Fjclk4TnBGOC9UYjN1WS8rSW5WT2d3WWhBUVUzWU43?=
 =?utf-8?Q?5R8zUnUf05zN5xpQ35BfNFBDj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52c27df-3394-47b8-018a-08dc418de916
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:41:33.9828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CvQTzdtGKkcdEyy/Ih8dd7ka9RSRdau2hn1VWjcwvvJZTMINKZLBkxL/5f6i6cRsnLb++t6GffDHpntSuH4JCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 2/28/2024 5:17 PM, Srinivasan Shanmugam wrote:
> Fixes index out of bounds issue in the color transformation function.
> The issue could occur when the index 'i' exceeds the number of transfer
> function points (TRANSFER_FUNC_POINTS).
>
> The fix adds a check to ensure 'i' is within bounds before accessing the
> transfer function points. If 'i' is out of bounds, an error message is
> logged and the function returns false to indicate an error.
>
> Reported by smatch:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:405 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.red' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:406 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.green' 1025 <= s32max
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_cm_common.c:407 cm_helper_translate_curve_to_hw_format() error: buffer overflow 'output_tf->tf_pts.blue' 1025 <= s32max
>
> Fixes: b629596072e5 ("drm/amd/display: Build unity lut for shaper")
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Cc: Charlene Liu <Charlene.Liu@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> index b7e57aa27361..b0d192c6e63e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> @@ -402,6 +402,11 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
>   				i += increment) {
>   			if (j == hw_points - 1)
>   				break;
> +			if (i >= TRANSFER_FUNC_POINTS) {
> +				DC_LOG_ERROR("Index out of bounds: i=%d, TRANSFER_FUNC_POINTS=%d\n",
> +					     i, TRANSFER_FUNC_POINTS);
> +				return false;
> +			}
>   			rgb_resulted[j].red = output_tf->tf_pts.red[i];
>   			rgb_resulted[j].green = output_tf->tf_pts.green[i];
>   			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
