Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AEBC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 21:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2876A10EB35;
	Fri, 21 Feb 2025 21:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUjE9hU1";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82AB310EB35
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 21:14:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oajPaAV8260ORhhjkfpTigSXSCP13OH0bTWeh7uF/4D9d5XnEKJMemwwnvfFLUi87eGSkIDSq94i8Tb5fUQnGIZltozr2xdfZ95Oxr1M95wbK3CNvuFznCUDp4fjFmZBIuHHwZIyJKSuX7LrWCU9fTJ6IZuBL+fXEvAybni9plwXlNUzCnIiBl25yYkrvu3Fwym2LWhu6I+W8UqCqIgdcbINs/y3sNfjGErvvhp6afErEFyF+DqFwIKa97vUgm+PxEViyn0Dsh1QvWUVRdA8XEhqipjxr+JOIiic75u6GwyWI5IDG6KT+tcT5QXkl96YmvtqEyrdE1ZKtJu99c2cxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSsy9dEpFBZUlhq5BsSAbSCFusxL97Pdwmcfh8XL3VM=;
 b=G/VUdkbWKH3VBHQyEoVNMFaCepe4rSmV07GOvAu7nXlSoX2KL7EN5aGaMiK2Q9hdPAvErMnGbgTBnH9hJBSKWnT8n52K0XwgRK9YJN9/69Rx8VKLpi6Mng8tSn+PgbpZlq9m2tDiPc+/TrIRYrft67Cjn5OxaRo+sLbHPqaKznHYdZu8f/Z0DHErTWzwjhtmbBADvr8yBs6iUoPQWAg8XgHtc2o9Gba8ekviCZuJdO6KgrWtKRF151J1rnMQVSHzeLFU5V0aR0bYkN4o+r+6SsGNdhx1uECzhnfxfC3Lnk+TO98xjb+pVa1j6+0xv69duA+sConMTIoMcG4wViih5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSsy9dEpFBZUlhq5BsSAbSCFusxL97Pdwmcfh8XL3VM=;
 b=DUjE9hU1BQIrhM9rrs0xuuqKFGHs8vJ98Ay/rxWouO/weCn2fMAql2HkSWZLpUWt4wxLmiGpEU8ITUlNaBaBjjDNVomjuaYfb7BewzpGxdz7S170p0mybOL8EubqxLUjTVyORCiK8MNeDjzZnfSBALzyYBOCVOgC2HLZx1B0dX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 21:14:51 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 21:14:51 +0000
Message-ID: <cbce7876-9e15-4f0a-b0d0-710853355886@amd.com>
Date: Fri, 21 Feb 2025 16:14:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update AMDGPU DML maintainers info
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, sunpeng.li@amd.com
References: <20250221192503.320868-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20250221192503.320868-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0442.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: d1477994-27a7-49a8-e089-08dd52bcc786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWJ1OGNVVU9penQvTUxydE5hdlBVWUt5ZTJpdWhtcHpkaHcvbStuOXdWWGl1?=
 =?utf-8?B?UmZCVkV4Y0pkbzlvakh4RVdqMTNOZWt0bUxJSUZvVFV3TjhybjIrcUUydEh2?=
 =?utf-8?B?Q0YrOTFiWmJXejJYVkNnb1dlZkd4UlFDL1IvcFRrK085YStqSG5nQkxMWFFy?=
 =?utf-8?B?RDZZYzZUUEZGYXdSM2hYWGREOUxNUDVHTlJJS1U0c0dnU1lyREo2TytZblJV?=
 =?utf-8?B?K2UwWCtxMWlweUIzWklOcnBhM2dBMXVwVVk3MHlHNnpMc2s0SHlTYnpSSlhF?=
 =?utf-8?B?WEh3ejZORWJ0ZFhmbERFUU85Y04vOHkzUlZ5TFBNMlc5OHFMWk54NVk0eXVp?=
 =?utf-8?B?WEtaVzl2Mndqb1RBK0oreUU5b1FCSW5GNERyZXpyeXdSMEhpbzBFTVNOQ1ly?=
 =?utf-8?B?N1Jmc0tPci95cmJkVGhIaS9IWERGU3RFM3NrRS8rdU50dmxxWlRnbS9FaXRy?=
 =?utf-8?B?YWsvSVNsNDI1UEdxZTk2Z21PRlZxOThhT2hDQ0R1R0w2NzQzK2pScWxMTUpH?=
 =?utf-8?B?MURabm12aENwNGlUbThydzNHV3dPZE43UWlpOFdqWWpiZGQ2a0l3cW44WU9K?=
 =?utf-8?B?aTMrcnBqQ2R1UVU1WVNZYVhUUkFzbFVCNU84bkhFOVN2djNibmROQlZ3TDAv?=
 =?utf-8?B?L1lPVkd5WVBTQVBObFVDRTY1aFd6ZTQ4ZW55dWkzUkNDbHg2OGRoZGEzMHNN?=
 =?utf-8?B?YzFvZ0NhQnhVWHZRR3lSc2hEbGtuenE5R1JyajB5Q1AzSXpDbzMzM0Q2TTVC?=
 =?utf-8?B?eGRkLzhrYktSd1hEbTJEbGY1R0sxS0ZyNm96VUl4RDNubWtZTDZvMGxLQ0tH?=
 =?utf-8?B?RlRQUUIvZmRUb2RnOHVrdjdSa25QZ1lobExjMjEwOGQ5eVkxMk9FWnBBMk55?=
 =?utf-8?B?b3JKSFF6TFArcVhkWWM0Q0ZyYUdERkFKT3RLdHN3SGY1WVhZSUg3TjJ6QXh5?=
 =?utf-8?B?NlZrSi9teTE1MlNpNC9FMXBqbHJsUFBWNGttcjFWTFlqRm16aTlNRDVKMS9r?=
 =?utf-8?B?M0xKVW5wcGd4MjZBWFc0R3Ftd1dkNEtwT2g3Rm5YZW5ONmdnM0cya2ptSG1v?=
 =?utf-8?B?L3hJZFZQc3BRR282MWJCSHczUmNJekRyTEg5WVNxU0RiM0d0VUZZZnhHMHdK?=
 =?utf-8?B?UDI0S0pFbTlBYmN6YzNJT21FQklYdkhORFFvTHlERWJXWWNFc1pnUEQ0cFRl?=
 =?utf-8?B?Y0NFL1hCRkd1ckVzQmdST2V3RE1hbkQ0NmUwcjBZOWdHZ1pMdWprVGlpOS9k?=
 =?utf-8?B?cm44Qmh3Z0VPbkE2OVFOYStranNmU050STdYS1RZOGVOTzdNREg3R3ZtblB0?=
 =?utf-8?B?NUJlcnlBS3VjUUZOUWhjS3liR0RLUTVsTlhBMDJVN0VMdEZPWmRyR0FEQzZs?=
 =?utf-8?B?STdiczROSnYvTVpFQm9NTWFpVkVLKytUMXZMMUtpY0hxeUovQk5Gd2tuM1ZV?=
 =?utf-8?B?eE4xK2o4QTh3dkZYTXVuMVZubXM3YXJ2ck0yQkRMYy9KSE01b2NBOXpwTkRP?=
 =?utf-8?B?NzNMa0dSeFdqTUF4MVZjcjduWEZxMnVmbzNiblZFcWZSV3dDemQ4M05rN0Zj?=
 =?utf-8?B?UGhmcU5ibkx3endEZVdQQnk0ZG55enQvOTh2bUkybC85bWZQOERaZ3lGMTN6?=
 =?utf-8?B?VWtieGdFYi9VU1Y5KzVCak1yejNCM1RzUGFnVjdXT3ZYaUhYQmpzUHRTQlV0?=
 =?utf-8?B?VHFyZVppZDRzd3hzc2hleHFCTlc2Mkd6c0pOOFpPaEV5ZTlVQ2tZZmNINGpR?=
 =?utf-8?B?MVVSb0NZSUE5YVRCWGFPQm01eFFqSTVycEtvNTY0ZzU1L2N4Z1RMNFRZSU5T?=
 =?utf-8?B?YXVBMHNUNjRSclNDcEV4Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmxhNUxNWEJjRExBd2RST2p0a3Z4QXNWbklRbGVNRXdUc2RteFQrVkoxVWh1?=
 =?utf-8?B?ME5CcVpVbkE0bEFoaUVOT2xDRm95RGRWUTNoK29yTzh3MndHWVRUSE5aL2NJ?=
 =?utf-8?B?ZC81SVZ1amVLdzkrVGJLMzViSkVPK2w5RWNZdjdtRHp2cVFmcUpQUExrMUk0?=
 =?utf-8?B?RjVGc1ZaUUt5dnZ3eHYyUVBqdDM4SXczTFJpeGhFcnlQbkVRSTlIUUlKbFE2?=
 =?utf-8?B?QzVvUThGb2J2b29GV1FTMzBoci9XN0xLZ1ozczJ3dkFiZTFzWS9XeXNHd3Z0?=
 =?utf-8?B?YmJITTdvRlhETEYvS29KZFIxNVRLK0RobjFJQXVkbmUxT21FeVVxbXFoelhN?=
 =?utf-8?B?b2Y3U1lXOFh3c0huQTdUL2dtWTgrbDhVUmhyQzJaTVlyRlBOanZ3dE02NXhn?=
 =?utf-8?B?cVR1Tm5nYnZTWGl2WG01YWRwWDY2OGFIS215SGFhWVJ4K01FcCtoRHBhN1JD?=
 =?utf-8?B?c3NCUVFQcHhCNUl1UnBBYVhxaTkrdWhTR2dFeWp2dWdkVnRoK3g1K0FYQWdu?=
 =?utf-8?B?YURkQUw5R2o5NUFTbmMwczQ5R3QwVXlxMk1GRWZrNGM2d1RsQUppVmdMSVBl?=
 =?utf-8?B?NmFiYVA0MFlPcmxiQ3VLLy9ZTWNzYytneEdsTmFXcjJGcG5Selg1aGFRU0N2?=
 =?utf-8?B?b2REbTVIemN5amRZNWF1MzIzVk9MenJ4TWhTUzJZZ2pXYUZScHlHM2tldEhE?=
 =?utf-8?B?UVRWZnRaQzJwd2JrcGJkZ0FieTd1U0tMa2czRjhPbFBOREhUVzV4WUplREZY?=
 =?utf-8?B?eXpPT0Y3TXV3TTNIb1lJNWhQbHFneTBUL2tFdjlYbUhUNEluTWM2WnBtenlP?=
 =?utf-8?B?TTJ3V3I3TEIweURiMVNpaWwvUUZCN3FoTXZhMlQ2c3o1TnhnaEQxNTQ0WTJG?=
 =?utf-8?B?UXNrNmczcEtwSGE1YlVzZUZCQ3BWcHRWK3hoZXNvcXQrN0p2QlNuVERsNnB4?=
 =?utf-8?B?VlBOYUR3bkV6QW1abFhRRDg0c2xrTWN1WUE2aHR3TCtVQVhYTjJkMUJqdndy?=
 =?utf-8?B?a3pyUnBJM3I3OXJ4cDQ2aXFtazBNWDBXeXlDVGZEbS8rZi9OZzhvYVlLWEVI?=
 =?utf-8?B?UUVHSXUybTJ6MG01NmNzL0Nwc0d0NHZwZ0JGOVIxY2ZpVmxsYmFsNG4ycGJK?=
 =?utf-8?B?bVpucHVNRmNJZ3lhazlwV1hjdDAyUmJXeGtUYVQzeFp3ZnM5S3l6dkI0UzU1?=
 =?utf-8?B?a3JpN1o3aFhkWlNXQ25ya1BPbG4walgrT0pFUzJTTXBOQUZHcTZ0b0dzbkk1?=
 =?utf-8?B?SWxUeGxzNnhpV2dBNkxCUWxJSXFmTVd3ZHRNT2czeVRTYzNDQTc4WkY3OTJw?=
 =?utf-8?B?VDRWbzdqVEh5OHFiWElrSTFUb1RHRG0zUmxqRk42Y3kvcHprR1h1cCtUaERB?=
 =?utf-8?B?enhMQ3h3V3p5M3kwcnlBaXZ5ano2ZHJ4ZDA0ckFEWU1yS0FqQ3ZvWExJT1li?=
 =?utf-8?B?NG9rby9HWHVjdHFmdmFhLzhIYWppYWtLMnh4ZXppQ0ZScm53dXIxNnY1TUZu?=
 =?utf-8?B?R2NRL3Y4SGVoRWRJNmJTSVoyV2xpQkNYeXI0Y0VBaVpsMHJnNXhCbjd1RHJq?=
 =?utf-8?B?SjJpMVJkNnJhaXh6QkcvNGZsM1AvM1Q1dmo3UkwwRnp1VDFreVBLUnJFN3Zv?=
 =?utf-8?B?Y0xlQW9sU296RVVsT0ZFT3RkaC8zTUNSWW5KQ0p4OVpCUUdNeUFrbG9BL3VG?=
 =?utf-8?B?K2N3dnNDNXhsNjBWbzE0Ykd6N2tXUEkvM2tRbzI1Nzl6Qk9jYUhURU90U2xt?=
 =?utf-8?B?SlV6SEVsTjhEbVFzcWZPR0lLdFBUUUg2Rzk0TkswNDlRMEg3c3NBTWhHZjdi?=
 =?utf-8?B?WERTV1ZZVE44R00zTitnUUg1Wk14REJDemcyYSthSExCM1FIZlpUOGlqZGZF?=
 =?utf-8?B?ZjRZRmtrSzE5QnhQV0JQb1hqT0sxTUYvUzFNekR6Q3dHekhScWdaWEN5aTBJ?=
 =?utf-8?B?by9mUS90MzNXdmM1WUxvdndPL096TDZhVjN5Wkg0azdpZXVrdDNaWWpuekRH?=
 =?utf-8?B?cHhFRTFtRHcySWdIWEhQbHgvWmFaS0k5U2FVNk1JRGJscXhrVmJLNm00b3Bw?=
 =?utf-8?B?VUZFMFBYeng3ZTBkMlp4VUdLcWJXaTc2OWNpOHc4emxITnZ3bjZCUmxoS2pG?=
 =?utf-8?Q?69FxyUb6Sa2ntWUOlAtLjM6Gn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1477994-27a7-49a8-e089-08dd52bcc786
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 21:14:51.3103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaHEnKCS7/UECe6fLrkJFYzUuk1Hm6rLgUXuCJiyTcum+ZJgP3Bo560GpT1hXUbYoRR+UIuO9H6W2mrP08D1yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231
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

On 2025-02-21 14:25, Aurabindo Pillai wrote:
> Chaitanya is no longer with AMD, and the responsibility has been
> taken over by Austin.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8b35ca294a0..d167946f88e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1031,7 +1031,7 @@ T:	git https://gitlab.freedesktop.org/agd5f/linux.git
>  F:	drivers/gpu/drm/amd/display/
>  
>  AMD DISPLAY CORE - DML
> -M:	Chaitanya Dhere <chaitanya.dhere@amd.com>
> +M:	Austin Zheng <austin.zheng@amd.com>
>  M:	Jun Lei <jun.lei@amd.com>
>  S:	Supported
>  F:	drivers/gpu/drm/amd/display/dc/dml/

