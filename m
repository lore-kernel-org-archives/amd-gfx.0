Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6332DCD4853
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 15:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B5810E0CE;
	Wed,  4 Sep 2024 15:03:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l0aV/PpB";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54C8D10E0CE
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 15:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRkdaL+uXjUufhKvb/odRGFW+eOTTfa1AWirx72F2LMMBFutW54fWxV93BgcWxK4omyBNrrxorLetoGl3GOGAp+5S6kLDqLInlmUsBkNuOwO61VKNM5Vfql6dcf5NWg6HTKwwe7iYE14vFH4gVFOx7YQici+/quErAgefeQFfsvbxuZsl++FFwA7K8he83kmECFMqcqEy/GVvhgAzyS+r8U+KCoEyR1GyYmCeNwkNDd1WMj6BJPYXgogKxX341faCsWj4D5cBzIHTlt18LxDHU7vWuoh4wfuPyT8JEsmB1/GmZ4u7LqTsbOzXUqFpzScenskROdp04vQA9C3BW0X3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTzw0CHp1wuRwNHKmjwPKEaoN3tjenToTMcPXjtjBus=;
 b=f0HzIs4Q3DqmJ5PukZd544JLeO2SjExjVCOsE5LuqrA3IHLgeTwK7opcVZOF1WTlCCtMrnoQIct1bnEq9qobje9ADrBNu83vbRUKE0EXPG/0KHQcPyn6BCCdgspPUjbgUd15z6riN5wOvD0xnUol4cbITdJYolGyRsOEpBMFAnFIjhQuXemRTVfsHq95+Zg4ldJ9zqnQ/Lg+5pdZwS37tLSWyPr4VNLubmmgq5yQjnhHI63f+AGiY7KOiBDjJu7ms8LIU00dfYeZTrPjUvgwGF088n9McpVCWsXiXDC59l4f+1AkcHXJwJzGDOl9plrciD8VJy7XajFkBYswBr5sGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTzw0CHp1wuRwNHKmjwPKEaoN3tjenToTMcPXjtjBus=;
 b=l0aV/PpBKXALjY8OcdfNKO6pTB/zdZLH89bjgdI3esG/9m1R1dRUgTB4P8fFP6ZNE+OpGOpV0MavLr1hHpFz4WzDQs4ARr4WWC38h4BTamHoNVz9+w8eqyddmyl2Gkmy341JIhr/9P3W0zjr2/sLu1HJ9BB1zleJcO8kANA5uqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:03:36 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:03:35 +0000
Message-ID: <6e613903-55be-96f7-88bb-7cc0cdd8b22a@amd.com>
Date: Wed, 4 Sep 2024 11:03:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5] drm/amdgpu: Surface svm_default_granularity, a RW
 module parameter
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240903232447.389164-1-Ramesh.Errabolu@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240903232447.389164-1-Ramesh.Errabolu@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0301.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbf5283-31bb-4424-7781-08dcccf2c00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clRoRjNCOUhsUTM5Vys3RDhMbmwwRWVwclY5bStVd3gwdFhuQWl3T2lJR0pu?=
 =?utf-8?B?dk9EVXVhU1hEQ09IblE3bXFnb2pSYWs1RTR5TVFkOUMzamR6RmNYcXVwU3Rr?=
 =?utf-8?B?UXF5QWxNSm5DTUJ1NEU1OU9oVEh5M0t6eUFWUTFLZWYxYS9lS0IrQ0RCYTlp?=
 =?utf-8?B?SVpIL1IrNTR6RlhCd0ZrTnUrdklnMG8xOWxjUitjbHpjNXpiZ0x5b0pSdm00?=
 =?utf-8?B?M2M3Wm1uY0wxOUY3c1hYM3hBOEw4cUozOVBsUlJlVWd1SUVSaytscXBRQ3oz?=
 =?utf-8?B?NVgzQ0FBQ3RuY1JIYkxwbGlqMnpEWmNFOXF0UTNVS01aYnM2djREbk53STVF?=
 =?utf-8?B?b1g1ZXhFbEtOMTlPYVdSUy9LMFBiQkt1a1N6WTV6RXF1bS9Yajl3MDdFWVdX?=
 =?utf-8?B?M3NWZW93R2wyUGhEblZpWU5DSE14ekovYVIvaVlXUUd4TnNSbm9sdENORldn?=
 =?utf-8?B?WjNGWGxCR1crVTRSVDVqc0Y5aWlUMjlUZHh3V2NNSmVmVjdQYW44WGsxVWlC?=
 =?utf-8?B?Y01NcitkQmpwZGhrYXNPZFFtNkNsbVZnekFxZEhUQ2JBVE9vL29FUHVldmp6?=
 =?utf-8?B?a3RqZitnYndEZG5WSU1kRDQxUTZyVzlUSkx5b09iZVFlbVd2YWVtdGxjeFFp?=
 =?utf-8?B?aTA2UXJtNDJFTzhxVEpYWGxMS244RU85bmYzQ1NFMkJxNCt6UTBid1duYVY2?=
 =?utf-8?B?YnNoVm51a3I5MEpBeWZzTm02MXFKNlFsb05MM3pkbnhacXlxVlFFeG9NMzFl?=
 =?utf-8?B?Nk16SjJmRGpQWGZFMzN4a0N0dkNZSUFCbG91VHZLdFdMN0VuOEZsWjFRVUFH?=
 =?utf-8?B?byt6K01SemNwSnloaWlMOXBnRlJ3c29sWDVmVVVDK1lDY0IyQjAvZUxCUFda?=
 =?utf-8?B?eGFCTlRvNnRkQXN6YmNoSDdBM0RBVE9GT0s3Vk5YRTN4TVdwVkwyejIyZmpp?=
 =?utf-8?B?M2VuTzI1NWE4bENQTGFOS2dDVVJGaFFobE1QUXpYcEl0UWY1WDJManVIaUc5?=
 =?utf-8?B?bjhxcHdCWjc5L3h1bWdUY2QxUXkvOVkvT2NBV1Y5ZXJxRzhydG1BK2UvWGox?=
 =?utf-8?B?QU9BL2svUnhkZDdTUFpJZzdPdEpHSFEvUU9IUzJMbDhnU1dDVGREVDk3Z3FK?=
 =?utf-8?B?ZE16RWdYdUdrZFIrWmx5U0RSYjFBQ3ZxRnhLVTV4RThXSkwycGZzUm9tV1c5?=
 =?utf-8?B?SnBxczNFUlV1UmQzNjRzRUVUSGRObEVwcGgyYlZlMTA0WGx5cEtuaFhTcSty?=
 =?utf-8?B?SFI5VEVzaHV0cWFvNEl2Ryt1MmwzQmJTQmhnYURzL2F5K09JSWh0dzVtZnh3?=
 =?utf-8?B?THR4VFNVbTFXWFZqUXpZOGhFVFg5TkR1Z2Fybkp4eE1ubmIzc2hYT2ppYTJx?=
 =?utf-8?B?OGNPdS9pODdZL09aQXl2aitBQnhTUjFMeE05WWhqRmc4ZkRQcCtJWmJlS0ll?=
 =?utf-8?B?VkQzNmIrc3ZzaHVDeGpkbGZ2ZU1xb2VUc1pJMGh2TVZYRG82NDFYVDRhUTZh?=
 =?utf-8?B?ZXZ2dGtpblBJdGZvZ0R3eUZSdnVKd0ZsdGkzU05jeWJicXZUOHdBNzgxcGJh?=
 =?utf-8?B?a2E4RitkeFpIZUhBL2JyTkZBbHJ4ZVk4dUN3Sy9aWW9McVh6azRYaU4wZGhY?=
 =?utf-8?B?ZVcrSnVLNXdNS2JsaUN5L2VsdEhyT2R4d3YrMndXZDRHQ3g2TEJ0Z3V6eW1p?=
 =?utf-8?B?elVTUTc4QWlwMHNPMG5LSGtvYmNyZFJQaWhqeVo2cE5YWWxnRzRKZWxteVV4?=
 =?utf-8?B?RjI3bEFRQ0Rsb1hmVWhGakxhWlcyYjgyVS9FNUlaTksxQjk0OTBCaGwxUnk5?=
 =?utf-8?B?eU02L3JqZ2tCNWxSZU5sUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzY4SVNhMXVSeCszTXV6SnMvaTdPd2FmTEtYNmVwM0U0eklVNE50Y3pFVzIx?=
 =?utf-8?B?dW5rVnMrZ1Rpc2FrUjRod1B5OUE4WTcvSFlyM0d3UUZoUG5MY0xGb2lFcWF2?=
 =?utf-8?B?OVNmMENLOG5oaUlKamlTM3dzblNGdnl3dmtkRWFsUTMrb3Q4NWV6NXJ6OGh0?=
 =?utf-8?B?M2V6Z1I5UVMrTDEzdlZtZmowVVM4U0ROZWJKYVAwVnNuZmFNZno5dU1lcklS?=
 =?utf-8?B?a1Q2bzliMkhiZG9tNm5lc1FLTlNBKy83em1hMzZQSDVxR1dja0RjU2lCUGNG?=
 =?utf-8?B?MGFQMHNEUlVNN2RwdkJlQlFtMFh4cVdJZExFM1lNMWJEcjdlV3ladmIxYlNX?=
 =?utf-8?B?V2JlN24xUGE3OG42T2VGNVhLOEEzYnN1Y0FvM3NHZnAxS1N6VjdWcC9BNzJL?=
 =?utf-8?B?VHVMdEtyNE50aTFTa3pQTGRDOGZ0SVc4U2JESkpnNUhtRGxTZENDK05NYVA1?=
 =?utf-8?B?VDE0cXk5dmNPSTUvOWpwZlVXLzVzVUQveiswTWJ3VUUya3dkZzhEZGV2NDg4?=
 =?utf-8?B?a0dBbHdUWVEvSDJIYVphdnJvWUxYQm9yOGxCUU9JWXA2WTlORFc2ZkQ4THdo?=
 =?utf-8?B?TXNxTGFNMkN5Ni8ydW02cWZUOTdseC9OV3BRanhGbXEwNksxdldLOWNxMUVq?=
 =?utf-8?B?cTJ1UFJ6THhqRnVvaXlqcGNla3kvNGZ1S1o2aHk0YmwrM2d3NGRjekJqVUNQ?=
 =?utf-8?B?U0dOMUh4Zmg1UGFrNlRiMWlHVXlNZ0RjelVBdXEyNmRQZGRMcDNzRzBxMDVj?=
 =?utf-8?B?NjZFN1lXQ1o5U0c1RjVOMHN4RmxCTWxpNHowWXN4L2NLR2ZmMXRiTnNEbFdP?=
 =?utf-8?B?SXBNWGtvUHdWMnI1WVJhd2V5WkE4WmdoZGtlY2tJRWtpaVlGa3lUbHpLMkgw?=
 =?utf-8?B?UE9nMHFxd29lbVNubUx1ZG9hRFdOY0NhS09CUCtPVXFRYjF5eXFVc1VESWs1?=
 =?utf-8?B?aE9aQXF0ODdlUk5weGYwY21NWVdQNDJBRDRGaUpiRnE0WHp2RU9iOENrSG1l?=
 =?utf-8?B?eG9QS0lpVDlpVUx1Y2s4aWhGMk9ubHloWWlOZnhjbjg2RTdZN3dBOVcva0pK?=
 =?utf-8?B?TjRjYy90bElTaWN4L3h1RGJzb2VpWkNvZDNJbkpDSFdmVHFFUE14VDQzaHla?=
 =?utf-8?B?THlRcFc0dllYUTJHZnhIRWc5VWZld2VXTE91dk9ieDRjdUVLUnVvRlFkbTdE?=
 =?utf-8?B?bm9xOUM2WG02b0FOeTJ6VnhpcUlHazRTdHRnOXZzOS9zWUV0eGUxQlVIQ0Q0?=
 =?utf-8?B?KzFSWTVPdmNvSlhQdndISnhXWHIyYklWbkRZdmVUdWttUm9hWUpoOWpPVmNC?=
 =?utf-8?B?UXFYaEVIZW1xMjFEaXQzQllUNUEzUjZSUENuekNpd2VaMTFqcG50bVdBbk9t?=
 =?utf-8?B?Wm9La2oxWkdCSUVORWpFTTRIZkFXRG1ReHhjbTRFM3RteTlnVURqQytPSXNo?=
 =?utf-8?B?aFRiL0Y3WnB2QWU5ZXN5NG4wRFJaTHl6V0ljQ1FnNEZGRGJFbm9tSnFtMWtJ?=
 =?utf-8?B?SnFMd0RET2w2TkFyY1NPcFZjd2Q2S2s2OHdjN1lnV2dIaFNsTVZ3elg0N3VE?=
 =?utf-8?B?THM1QkhvVkNmWnJHWG5LTW5Dd3B5QjEvVi9GK0UzMHEvVTVCcFE2RjlScWgw?=
 =?utf-8?B?ZHRxYmxXbEk0VC9oVThnc29UN0F6OXFISFBZTDVXd0tMdlEyK0FzaVdPeTZl?=
 =?utf-8?B?VTJ1cHlCRU5CL3ZIVmZQK0ozSE1ObTlPbVF4WUdaMmRrM0dGZTBZWS8xcEZZ?=
 =?utf-8?B?N2ZYUnkrMnRtYlJCMG15MXNIclRBOTRNM2tEaVhaWmVpQ0ZZRllFWDMzdmxE?=
 =?utf-8?B?Tmh6YVUwZ2grZnQyMTRXS3Q4ZDVZUGFjVTZnb1hHajRlWVFscXBxcXE0bFla?=
 =?utf-8?B?U3ZWQjdmODRvVlpsVVR3TTV0dGlXaGV5c0RUeG9vbWRCM3FuTUVISGQzSjRq?=
 =?utf-8?B?OUpob0Q1ZVdaSzJQZDdOcmJtYkp6SFFsREkvYTAwZzAycHZrek9ScGNTTTF5?=
 =?utf-8?B?MHl0QWtadHRyQzZiYXloOHVLVU8vcGJRYmZMSkRJM1BEai9YNUdCTzFFamk0?=
 =?utf-8?B?ZHpzYlpRemNqTlJhNURWQk4zODRtMVJoN3VUZ1o1ZTFSU1BUM0N3aUsyWHE4?=
 =?utf-8?Q?7krtiG9HRknirtsSQWly8oQ+P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbf5283-31bb-4424-7781-08dcccf2c00f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:03:35.8040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZekhPYOYK4w/Cc8jXMkcnYQJc3iDHcSKy5IVY3SUR7j35wnDF1UYs8MEXRS7585
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-09-03 19:24, Ramesh Errabolu
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240903232447.389164-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">Enables users to update SVM's default granularity, used in
buffer migration and handling of recoverable page faults.
Param value is set in terms of log(numPages(buffer)),
e.g. 9 for a 2 MIB buffer

Signed-off-by: Ramesh Errabolu <a class="moz-txt-link-rfc2396E" href="mailto:Ramesh.Errabolu@amd.com">&lt;Ramesh.Errabolu@amd.com&gt;</a></pre>
    </blockquote>
    <p>With 2 below nitpicks fixed, this patch is</p>
    <p>Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a></p>
    <p>change subject to &quot;drm/amdkfd: Add svm_default_granularity module
      parameter&quot;<br>
    </p>
    <blockquote type="cite" cite="mid:20240903232447.389164-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 23 +++++++++++++++--------
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e8c284aea1f2..8eb934af02f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -237,6 +237,7 @@ extern int sched_policy;
 extern bool debug_evictions;
 extern bool no_system_mem_limit;
 extern int halt_if_hws_hang;
+extern uint amdgpu_svm_default_granularity;
 #else
 static const int __maybe_unused sched_policy = KFD_SCHED_POLICY_HWS;
 static const bool __maybe_unused debug_evictions; /* = false */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b2..442039436cb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -169,6 +169,16 @@ uint amdgpu_sdma_phase_quantum = 32;
 char *amdgpu_disable_cu;
 char *amdgpu_virtual_display;
 bool enforce_isolation;
+
+/* Specifies the default granularity for SVM, used in buffer
+ * migration and restoration of backing memory when handling
+ * recoverable page faults.
+ *
+ * The value is given as log(numPages(buffer)); for a 2 MiB
+ * buffer it computes to be 9
+ */
+uint amdgpu_svm_default_granularity = 9;
+
 /*
  * OverDrive(bit 14) disabled by default
  * GFX DCS(bit 19) disabled by default
@@ -320,6 +330,13 @@ module_param_named(pcie_gen2, amdgpu_pcie_gen2, int, 0444);
 MODULE_PARM_DESC(msi, &quot;MSI support (1 = enable, 0 = disable, -1 = auto)&quot;);
 module_param_named(msi, amdgpu_msi, int, 0444);
 
+/**
+ * DOC: svm_default_granularity (uint)
+ * Used in buffer migration and handling of recoverable page faults
+ */
+MODULE_PARM_DESC(svm_default_granularity, &quot;SVM's default granularity in log(2^Pages), default 9 = 2^9 = 2 MiB&quot;);
+module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint, 0644);
+
 /**
  * DOC: lockup_timeout (string)
  * Set GPU scheduler timeout value in ms.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9ae9abc6eb43..d6530febabad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -868,6 +868,12 @@ struct svm_range_list {
 	struct task_struct		*faulting_task;
 	/* check point ts decides if page fault recovery need be dropped */
 	uint64_t			checkpoint_ts[MAX_GPU_INSTANCE];
+
+	/* Default granularity to use in buffer migration
+	 * and restoration of backing memory while handling
+	 * recoverable page faults
+	 */
+	uint8_t default_granularity;
 };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b44dec90969f..2bc2389cc7f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -309,12 +309,13 @@ static void svm_range_free(struct svm_range *prange, bool do_unmap)
 }
 
 static void
-svm_range_set_default_attributes(int32_t *location, int32_t *prefetch_loc,
-				 uint8_t *granularity, uint32_t *flags)
+svm_range_set_default_attributes(struct svm_range_list *svms, int32_t *location,
+				 int32_t *prefetch_loc, uint8_t *granularity,
+				 uint32_t *flags)
 {
 	*location = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
 	*prefetch_loc = KFD_IOCTL_SVM_LOCATION_UNDEFINED;
-	*granularity = 9;
+	*granularity = svms-&gt;default_granularity;
 	*flags =
 		KFD_IOCTL_SVM_FLAG_HOST_ACCESS | KFD_IOCTL_SVM_FLAG_COHERENT;
 }
@@ -358,9 +359,10 @@ svm_range *svm_range_new(struct svm_range_list *svms, uint64_t start,
 		bitmap_copy(prange-&gt;bitmap_access, svms-&gt;bitmap_supported,
 			    MAX_GPU_INSTANCE);
 
-	svm_range_set_default_attributes(&amp;prange-&gt;preferred_loc,
+	svm_range_set_default_attributes(svms, &amp;prange-&gt;preferred_loc,
 					 &amp;prange-&gt;prefetch_loc,
-					 &amp;prange-&gt;granularity, &amp;prange-&gt;flags);
+					 &amp;prange-&gt;granularity,
+					 &amp;prange-&gt;flags);</pre>
    </blockquote>
    unnecessary extra change.<br>
    <blockquote type="cite" cite="mid:20240903232447.389164-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 	pr_debug(&quot;svms 0x%p [0x%llx 0x%llx]\n&quot;, svms, start, last);
 
@@ -2694,9 +2696,10 @@ svm_range_get_range_boundaries(struct kfd_process *p, int64_t addr,
 	*is_heap_stack = vma_is_initial_heap(vma) || vma_is_initial_stack(vma);
 
 	start_limit = max(vma-&gt;vm_start &gt;&gt; PAGE_SHIFT,
-		      (unsigned long)ALIGN_DOWN(addr, 2UL &lt;&lt; 8));
+		      (unsigned long)ALIGN_DOWN(addr, 1UL &lt;&lt; p-&gt;svms.default_granularity));
 	end_limit = min(vma-&gt;vm_end &gt;&gt; PAGE_SHIFT,
-		    (unsigned long)ALIGN(addr + 1, 2UL &lt;&lt; 8));
+		    (unsigned long)ALIGN(addr + 1, 1UL &lt;&lt; p-&gt;svms.default_granularity));
+
 	/* First range that starts after the fault address */
 	node = interval_tree_iter_first(&amp;p-&gt;svms.objects, addr + 1, ULONG_MAX);
 	if (node) {
@@ -3240,6 +3243,10 @@ int svm_range_list_init(struct kfd_process *p)
 		if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
 			bitmap_set(svms-&gt;bitmap_supported, i, 1);
 
+	/* Update default granularity to one bound by user/driver */</pre>
    </blockquote>
    <p>This is more meaningful:<br>
    </p>
    <p>/* 0x1B is the largest number of pages supported with 4-level
      paging */</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240903232447.389164-1-Ramesh.Errabolu@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	svms-&gt;default_granularity = min_t(u8, amdgpu_svm_default_granularity, 0x1B);
+	pr_debug(&quot;Default SVM Granularity to use: %d\n&quot;, svms-&gt;default_granularity);
+
 	return 0;
 }
 
@@ -3767,7 +3774,7 @@ svm_range_get_attr(struct kfd_process *p, struct mm_struct *mm,
 	node = interval_tree_iter_first(&amp;svms-&gt;objects, start, last);
 	if (!node) {
 		pr_debug(&quot;range attrs not found return default values\n&quot;);
-		svm_range_set_default_attributes(&amp;location, &amp;prefetch_loc,
+		svm_range_set_default_attributes(svms, &amp;location, &amp;prefetch_loc,
 						 &amp;granularity, &amp;flags_and);
 		flags_or = flags_and;
 		if (p-&gt;xnack_enabled)
</pre>
    </blockquote>
  </body>
</html>
