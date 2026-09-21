Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B53C982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9907410EAC6;
	Mon, 21 Sep 2026 20:39:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KaFNMSg2";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5443D10E9E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:39:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJOp9GWUmXrYc/qteXNUKskuKM1PsPGZo2E2uRS93ItnoPTcF9Wafn8DJSsVzu/nHFoVZ+bB3O5JxYYm25syiDg0F5oVKyuAY6T6FMNKoSnqexDJQaLLRDotfq2RDrM0Nf6hAozmwh9e1hC6VtCFK1P19WJYPGqKJMwVBN/BkJX8/SlE2wSJ+SwwfVZYtaS7QPk/E/QLqPIiBJ1xLPXJS7zlFY5rRT5SzbjFTYrdZm3sbqPDLZcUrDctJFdIQBVGnmtsZrJZs4WgZO3ylftPjhj6wf+oH3K2qeWiHRzvDCQuPOWIoozIjQjcc1giBPRJfNkBK7jX8GE5vo/KHWmFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3nmfcwL4u+XZUsBBRUwrMfCR6BbCGLv+RwfXLteKnI=;
 b=v3UdFoqSyWjw6NGjf74txqcvSRwW0TqqBZnYo6dmpcwNJN7lRdItH3UU6ghGuJjBeFKu4erc+FYllgueKM6V7qCX2oR5yfc0tAytfpBGUctmaS/8lbB8x3rQoMLUB0dBd/AB2Uko1Pe5jCct7bNVHLaHEAamVMN9ZAdD1OsFedSCo3hkwPSt2GL/hn5n8iEWbkcyeO0HVDRwOGvVM9oSjn/hDtoyAVdCBt/2QAllnmlFspZ9jaaI/W3sGAwCg9k4ptNGFRXLDisbxijkVV8ao/iv86uzO++0ZfPs2JfcHYB1nptJFc02bUoifrmFzUT4rTnSxCLC9bdrXKq2heS8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3nmfcwL4u+XZUsBBRUwrMfCR6BbCGLv+RwfXLteKnI=;
 b=KaFNMSg2u2XOVzaAd3V42WOcbUmLEHpIPFtb7wp4FUONwhM+7yLbkdqlOTNopLg23vo6j60Shu5BDlELjgJ8eROifB3pXfyJtKmgSZmYMvXgqiLaQas8ttPON0bSVNydr9rXOBozyg63C/VciPnWNEGH0n1q75ul4s2kSqN5rOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 20:39:16 +0000
Received: from CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa]) by CY3PR12MB9629.namprd12.prod.outlook.com
 ([fe80::3d72:a3a9:e4ab:4afa%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:39:16 +0000
Message-ID: <fdaad408-b50b-4d3c-9a02-d4d9c4aed06b@amd.com>
Date: Mon, 21 Sep 2026 15:39:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix TCP XNACK scoreboard reset race on MI300
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kent.Russell@amd.com
References: <20260921192623.437256-1-Gang.Ba@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20260921192623.437256-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:806:f3::7) To CY3PR12MB9629.namprd12.prod.outlook.com
 (2603:10b6:930:101::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9629:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dffc9db-7d39-4d13-80e0-08df18206756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|3023799007|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 3JNT0RlE9vEJYMYbJL3gxZ+sV/3IhBJAh8j/G7GBy3VNmCM8HBw+qFc3ZvQLfTXeLGkSFnY+s+gfyh9JoB+lruG+F1G3Mh6tWLB2C4+gPWuMZcjqeGFp9Qi5KYrE4H9Wf2WbAqQaAIx5H/PVwaG2lKrsjSaKPI9Iim3DaR8eF9TnHHwJsy06vq1UjeE3UVN2spWie6fm/4w+R7nLgAxQhNTM0e71OhnRewSDdtATJfcCULBMX82akQIL7qc2Dp7rehiCuRbtf2Vb/UimN2CqVgp7echGgX4PNQifOE77fO3rlkMQ5LjHHJG1e3aWQ4LDX26Qc778x7JSIRhfxSd3IIddSrO/iWbY39RcVR0xlIJHPPPGSIPaLvH9+LowfRUyXaMcl4ZwbS1XGC9hvAu4Li6SNxW/nqes4EJgHmmbTJq0mHz7uW2o1Zxo+6cdyBwUju/dR+81aegDTIQeVBsSkRm+1vJ+UzX6zO/nzTIgIp0JViK3ds7O5ye3OK4XkTK+g2HKKAroCU0pP+NKx+CxjUv7XzdOxmfIfM3MO3TmUok+43w/5Cw4JqspNgG0cwesnaKzkmrvlS4460vZcruRJBK8aEqEjLJbav1xThlIV7HI3RR1NCCvSbN749hX1kRzlEUyDr3NlkvmA7FoZ5Cnnf0RZtWHd7PahLQnQbV9CtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(3023799007)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdnRWdUSWdnc1BYb3FCMXpCMFUxUHM0UFNJbEpPU1V4NnUrMEgrQXZMSGxI?=
 =?utf-8?B?c1lEV21mdWlpUEhEU2xjQmsrVCtEdXM0NWd1K2VPT1JBNlVrTU5QcnYvMFJt?=
 =?utf-8?B?UGpSUUQxK0tUTXRCajhuUnp6TmhidDF4VDkxdUJ5Vnd5TC8wY0M4QytsNVFp?=
 =?utf-8?B?Yk9zYTN0WnowYXpkdWVxZXQyRkRZYUlMc2lHa0cvWU1mcitpQ21hcVNEVHVM?=
 =?utf-8?B?TXpLa0NpSHRnUEF6SUpjYm13aCtrQlMzNVFid3N6WmtuZ1YvNG4vbzRDbVQv?=
 =?utf-8?B?NDM3amdkZjJrZzBlNTFPMHc3ZlNnZWkvZmkvVDN5OEZpemtuVEpKYzJBaDlh?=
 =?utf-8?B?eWJudmtmYWtNdEhRRTFyQ0J4RVBPcU5UVEtNVHJaVFEwQWt2MXVMZlBjU01T?=
 =?utf-8?B?MlBqQjdEOHhib3ZEQ09Tc2g2L2lhVjdrRnc0OHAvMzcyUWIyU0lScHNkQVNl?=
 =?utf-8?B?ZGY1a1R3aG0rcWVlcFU4WmhsZkNubDYzamNZSFJvdGdFUEM0cHBnQUdqYXA4?=
 =?utf-8?B?WWdydTBFVENtampsd0doTXRzMHplaFdDdC8wU3pPQ2FxYmJSTXlvQmYxRzJz?=
 =?utf-8?B?K0RscDkvM2xlakwwdS9DR2FoRmQ3dTZsUVBhZmdJS1M2WWdwWXB6SDRqTkRq?=
 =?utf-8?B?bEE3WGlJU3Q0SDJKeDI4eXZwUktleGd2SGVGQzF3TzJqWnBwcmJVbzI1UlFz?=
 =?utf-8?B?T0tsMkE4aERBSVVGeTlIa1d6U3c2dlF5UGZqaU9zcE9hV0p6R0ZMTGZBd25H?=
 =?utf-8?B?TkJjUDdjMGhsY0MzaU51VVpmUDBRaHkyOHRQUUlEeGVURThzUnVyblFmSG53?=
 =?utf-8?B?YmJqZ0Z6b2owTFlUTUJOcUJwYkxPRVFyWXdTcTVYWW5WOHlzU0NWcmxsTGl3?=
 =?utf-8?B?SHV3enhQa1JoSkE0N2FmRXlrTUMrcTRBVHovcDB5dkFFaFJiTkpmYlBSUkNs?=
 =?utf-8?B?VFRJbWNCQUxVM1F0ZUt0QldsaTNiYWVscG4yemtpM1hNdGhpNXU5b2Z4blNP?=
 =?utf-8?B?RjdpWEdLbmQ1aFVockNRNSsxYnVGa1Y2UCsvSngyN2YrOFpneGhSYmJYS2pF?=
 =?utf-8?B?WHJrVXlOektPMjNGaURtNWUxdit2QmR4anhKWmM0RzY4WVRmT1FhVnpVcEsr?=
 =?utf-8?B?VktDd1gzcXFFd1k2VGdyUlo4SlFLeUttZUUxY0E2M1IwODhiNG9ycEJLZXBo?=
 =?utf-8?B?c1pLeTR2elc1bHFjeFdsUXk3Ly9qcHZCMUcreFpqY20wNk1YK1M2K2RCVHFM?=
 =?utf-8?B?T2htZkVUT2cyOEhxZ0FBS0JCWUhTK0RXZzFsTzhhSmhsTTFyOFFsQ053bjZh?=
 =?utf-8?B?b3ZhQUluWHhGcGhFUlk5WEpxdEdpWDBmNTZqejMxSzhhT3RZZVBqT2tldi9R?=
 =?utf-8?B?THlXUGtMbFVtNnBWb1pHd1lwaTY0M1dyVWJrMEp0Z0xIa3lqWnliUENja3A3?=
 =?utf-8?B?dXB2VklMKytVZ1hleDFLZzZONll3U3dibmRDWTFmQkp2YWJ1M3hlM1JzM2px?=
 =?utf-8?B?OTEvOFk1SzB0clo3VzkxN3J5TDlvYmZQTGI0a21XaXF6OW80azFGUjYrQ2hI?=
 =?utf-8?B?RTFOeEpvalI0Nms0WnNqUEYxUGloMHRJZE94N0drZEgya0Q3ZC9ZZ3NSMktj?=
 =?utf-8?B?RW4wdklGQlZ6cnFZVnBCN0dRUW9vS09UcnllcWpsNnhZTVV1UUZOS1htRFpn?=
 =?utf-8?B?OTZqSS9GVUtZNlVodWlud1hqYUdOMnZRcVlxVk9xWllTRUlYQ3p1cUw2RTJC?=
 =?utf-8?B?dUNJbURUY1pxVkpReW5GR0twbnQ5K1lpd01DeWExQ09kNUZHUjZEaXNxaEYr?=
 =?utf-8?B?WkZFZ2hVVFdZNzJTUHduam9RalhOaDR3RFVrbjd2K3F4RkJQd2RpWnk5T1hL?=
 =?utf-8?B?K1R4V0d0VW9RUWVPQUYxQlpMMEZaeGZ2ckJ6eTM2TXMrVmw5clFVVHZMNmtK?=
 =?utf-8?B?NGJpSExXOCtSTjQ1bzNWQzBJa0dDeExsb2VTRVp1STk0TTlmSkN5dktGS3pn?=
 =?utf-8?B?emNiRkdDdVBzY3lQVVRLS2o1Q29qSnBLak9wZWMxK0UrUEVqV1hTSEFDRTQ4?=
 =?utf-8?B?a0RIZkQ1MngwVk03aXVOMUcxelZuOENpWUI2akdyUnNmRENHVkxoajJ3bEtY?=
 =?utf-8?B?VHA0eW9ycVZPVUVLR3pkTmEzWENWZlJ0MVRrZ3ZHYzZyRjRmbTdUUENQdHZU?=
 =?utf-8?B?WGJNenpoQ05OeDhmUlBHb0F4VGFTM1F3MTQ3cEMxSTc0UldxZkpOckJVRCty?=
 =?utf-8?B?cDBvSlhFeWxrQTNPTjNOYWpkeTZPaG1GU2ZoU1VoUmdwZG5XZU1Zb2tkL0dG?=
 =?utf-8?B?amQwdlV3REszblZoVHFldWQwZmNsdjYvMjZkSkpZSDNKUEM2YmdUQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dffc9db-7d39-4d13-80e0-08df18206756
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:39:16.4958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1xe/Bn67N+7aKtJLMf7OJll/Ruvk8G32muo54gNPSHKCPH3ALfsMGmesLX0U6PNeASKVUmQiGaJPOAA8ZZTPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478
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

On 9/21/2026 14:26, Gang Ba wrote:

> Fix a hardware RTL bug in the TCP XNACK scoreboard reset path on MI300,
> where a wave receiving a no-retry FAULT from UTC and subsequently
> terminating may leave its scoreboard entry uncleared when reset events
> arrive back-to-back.
> 
> This can cause a later, unrelated wave using the same scoreboard slot
> to incorrectly inherit the XNACK error state, resulting in its VMEM
> operations being dropped even though the wave never faulted.
> 
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>

Reviewed-by: Jay Cornwall <jay.cornwall@amd.com>

