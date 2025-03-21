Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F22C36000
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 20:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79DEE10E831;
	Fri, 21 Mar 2025 20:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G1pkC+jv";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2643210E831
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 20:02:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGMjNpbPgauKtO+ejMdh7CXjdy0RqzzwKx6cdphn0zJPbbZn1JeXr+KlLC33oW/ImNSYSOXN4at63j7JaGQixUITvAuN4SZi3P3+TpwVmn2eO+RLXjlaQjBjMe9vwv1niINXftmBgx4gENll5U7KDWDVELrlOKRe8rbbeWMI7ZUK7KfpfiLGc9P/BgXyYk7l9aB5pGpOsGAU+T9iWU0eXe5oNZqV1exSYPyt3VkEE62lmmk8WeOwTwQJTD+K65pC46ChX9DpUOYCmadPVlrM0LIBHJjp/f231KjHujqvvcPM7sMB1vPF07E7YzJ9e+Iin1nanvoHcKierhENecXBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWvNuOAZRgv0K1u0qRVDQ+V8LVl1UHm+XnWxERhtfk4=;
 b=oLyd5buowm6ZZz5gRaqa1j0zbJPz1r1c+O26LlSsGy4fPy8bNoflEX976CdOK6VEu88vpaNM687htRcvoeDTk7zsLrrf9H/cr4MdSMtzkO4EgT/yE//NhIHXb+tZNA9i/mXWaY+wLwEC/p/fIihp5GMakq1lF8Ur2523hvfOaKU5JSjfttdm5CTqfefSbtf1vp9NVKtEG8in7YH8G4OpdF7ujUe+V1vmMwWe7HqTVJKU/5dWBsSA6iSXttNesU5Cys67N88gxe+DvZ+1dQhFN33vl2Oo0vq+r1Y8D8rbeIRVUA2H6u0yaBFNKnA7D6St2A7s+wBhY1LQlVu8XP65mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWvNuOAZRgv0K1u0qRVDQ+V8LVl1UHm+XnWxERhtfk4=;
 b=G1pkC+jvLdEUIZ4QcxVIBIxAmLaOD2AA5xy40t3K9dC9lm2A0+2lzJlQgAEoFFHK00RAUBCYEwOOibw1bexBnJp2SqHn5ITzUl3zS99qDG2wJ7hyegg/YpBYHql2yOFHKgal/20TMZOCirRhCq8oHV+90MG+Mml946vPsd/GXZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 20:02:37 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%7]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 20:02:37 +0000
Message-ID: <900dc175-4f73-4288-98a2-5b7c18cde088@amd.com>
Date: Fri, 21 Mar 2025 15:02:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250321182658.22436-1-jay.cornwall@amd.com>
 <BL1PR12MB58984DC8346F9D80820501B985DB2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <BL1PR12MB58984DC8346F9D80820501B985DB2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0075.namprd11.prod.outlook.com
 (2603:10b6:806:d2::20) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd65ca6-dabc-41b7-8360-08dd68b353cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REFZRk5PbVMwVHgzTjg5V1gyVjEvRkkzLzJodjNETzJsMzZvWU9KeTR6NjAv?=
 =?utf-8?B?UzJUOFIvL0lRTkh3MlZNb0VGWlE1Q0JFbVJrQXdpZTk2YzhGUTl6Zm5NMUIz?=
 =?utf-8?B?RU9Jc0dxZUdCS0l6RFFDK3RwN2hENmJvWm9KQ1ZpZkxpVGl5SWdOcExRQVJS?=
 =?utf-8?B?a1dQTkJBSWM1NmNWSzhveHZIc0I3SmdVTnhvVVBkbTdGRFh2ejJtMUlSVnJn?=
 =?utf-8?B?Nk4xaDlBeTdlTWs4UDR4QTZEWFNIN2lWMnBWT00xOFVLUXlveXQ0bithOXdl?=
 =?utf-8?B?MkJ4NURTR1RHOVB3bmJDakwrZlY0VlhNNVRia2w2UCtDdWRNNjQxRHJUMk8v?=
 =?utf-8?B?NmpDK2x2ek4yZjE1ZVJQeTFLTGxONUpmUlUxaGJjVHZnNFJOMnpJMFB2NGtB?=
 =?utf-8?B?TlJzRXFMNXhHMXlzKzNHVzAxcXUxY1I2Ukk3dk9HamR2RzFCTzQreVpKeUZw?=
 =?utf-8?B?YVV4ekRtNWw5cDZBQkZwSUpWZE5ZKytuZHVmRi9rbjV2ejQ1WVp4NkZQNi91?=
 =?utf-8?B?K29uczhySXpHQW1tcm9mcFByRkViSzljN283YmdOZ2U5N2pUZmVMMEEwNXQ2?=
 =?utf-8?B?bS9EK0JibG5hNVhNVzFURjJUY0lYc0lXVHplWVRtVTc2WjJJNytQdzZ5ajlh?=
 =?utf-8?B?bWlZYlpWR0FNUmlPd0ZTSWNPcGJmUFZrcjYwSFQ5K1ArNEcxSU5HWGt0N1ZH?=
 =?utf-8?B?TExRdzZncU9YQXpqRlZCZGFScnM3L2xMa2pqdWxncVIyYWxKbUk5cTJNZXN6?=
 =?utf-8?B?OXJONTRaYVBCeGtDSldmN0pKaWsxV0wwTmJ0Y0dpVG1tbkg2NEo1Vy9BTThU?=
 =?utf-8?B?d1p4SXJCbi9odS9NYTlIdndlYjhNOEhUZ2FscFBlMGZ5cDVTVlRuOENjOG0x?=
 =?utf-8?B?Mk5wL0xWVHc3eWtwUHE3bmJmUExUMFJjc2F1SjZiNDlvdkFsMVc0TlROSDYz?=
 =?utf-8?B?SUpJMk90TXN0cTFkeXpDQTJGajBMWTArRXZ2N3Q3RDJNR0VnUk1nYTJ5cWZB?=
 =?utf-8?B?SFVPdi9nVkkrdU9YeWRGMlFLTW1uS0xuNzgycG5BN1A1ckdzTHZCa3JwbXcr?=
 =?utf-8?B?dTRBQkcwZVh2dW0vbHUrTnhFQzNDcXdjTkpJR01BME13eko2czZoQVMvOFFR?=
 =?utf-8?B?OW5jc2p1YnExWllLRXFjemlVQlg2Znk3ODY4cXVCTy81LzFqS2NKUlVpU3Av?=
 =?utf-8?B?UHlDMEZkemJEQmUwK0Y5UjQ4em5ZallCaFlBOFIwRFJ1NUJPTDNpZ3Q3eGpZ?=
 =?utf-8?B?OExvWVY5blpzd3p0dFpteWNiWVBEQ21ybFh0WVkxTEhnVE5wZUNnUlVKUlNS?=
 =?utf-8?B?My9zQVIxT1dLQmNhUjlFK3Q0MUFZMlJFWVdDMXBWWUJ1VlByQlpNY0FQY2VJ?=
 =?utf-8?B?Y1ZSekV5bUovQUo2OWs3UytpVTVEZHJGSkZJKzhTTldrR3J6Z3hMa09ERDRa?=
 =?utf-8?B?VVlibW11Vi8wdm9tRnk3UHM1bEV5NWU3K0JWbDJYQk95UVcwM1U3dkFrdFV1?=
 =?utf-8?B?ZnZOalZzWHcrc3lLaTZYV0RReENndGhQNk5IWWJQY2dWNm50QVFFbVFTV0ho?=
 =?utf-8?B?b0tOVllLZ0htaGtHUTZ1c0hmbXg3R0tHaDlyK3VtenE4NjVGMHRwblBJUjMv?=
 =?utf-8?B?L3hTUUxmK3NIRFNhanpaWHpaQ3hsZEVhUU1Oak5tU2QwTWF0c3BwUzEreUdM?=
 =?utf-8?B?SGErWDRkeDBVYmVQQzhvelhlV0VMSk5SVHNBL01kblphTUdZeG94YTJUOTN3?=
 =?utf-8?B?elNjdWgxQVdQL2lsYmx1OEJpQ1hvaUswdXgwNjlGM2tla0lVUXNjdXV4QXhx?=
 =?utf-8?B?Rnc0OFprQzlpQ1ZSOXh4bUtEeTZwRFU4OUp0bkpVLzcyTmJ4cTFNNnFaMUZ1?=
 =?utf-8?Q?Pln9D5SwkNZsP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmZmVDZCZW81K3ZuOGV4TGpLMnhhVWRPT0JqY0UzS3hObE5OQmN5YTE3Ujcy?=
 =?utf-8?B?Z0FUckdyUkd1SWM0QWwyN2pLZDNnbEhoMmhwYmlLeEpJUmp5c2M3N3pwUGgr?=
 =?utf-8?B?ZmFqT090dW1WUFIvM3E4NHByTkpJZTdwWUdUVUF0T2JoYXBaTnZVcDJzUFpS?=
 =?utf-8?B?aERNYzZCK3FybXpyMEowV0VKWTZYRFpPRXJlV1dhckNzM2xGRlowdnhza1dP?=
 =?utf-8?B?VmFQcm1aTlhwcmZnTnR4UlJ0OTA4UlZONE9SelM3NFFQOGIrMXVKeEw1SUc0?=
 =?utf-8?B?ZjNwNFQ0ZlNCbDRpbVdqcWhabGFJNlNSdFhBemwza0FMRWRoc25PdkVkNjBy?=
 =?utf-8?B?a09XZ0NZanEvQTZrbjRmTitBenRQbWFtai92b3h0NkszU0FDektVVndHSDIr?=
 =?utf-8?B?cnptUUhjNkgwQk1qSWRpOVNJdHlESGtiZEp0NC9hUnA4ZlJzSU9CdG90YWFo?=
 =?utf-8?B?Ym1BMDdOY2dhMWhGbFgvcGNVMnJ5emZSOWwwL2VJWVIwSzZaeUtRSFBmditE?=
 =?utf-8?B?MnlmeVRSbDM2bHVXK3VzVlhOaWszd3A3T0ZWU1VLVEcxZWlYUGN2bHBTZWNi?=
 =?utf-8?B?dHlRZTlvbFp1N2JMYnVsTUFMNVJSeS91bi9yNGEvS0NSMm94TncwYUYrNFhq?=
 =?utf-8?B?YWZyeGlLRjg0ZXNiVCtYbWJjK2NVRWhxcHVyTTRVb3lLeitpd2o4aDdYL3Ry?=
 =?utf-8?B?WWgzM3NPZWdZdWUrVFI2NDg4QnFzZTRMRjBuaXdIVStoV3Z4c0RLWm9JWDU0?=
 =?utf-8?B?akUreFc4aEU1ZElNMnhxemg2TjlDTnJzL3NMa1lmVTBBZXJJa2tFaHkwOXhr?=
 =?utf-8?B?K3ZkdGttMkNNN2dXZERhYlNUNWdDaVZvTkMxdFJiNnd6czJSU3VWYUNpUHcv?=
 =?utf-8?B?NlQvZlJ4WjNPelZMaEdZNC80U2xpZU1BUHZBdUxaZkVPVmZUNS8wZ1ArSFky?=
 =?utf-8?B?SWUrZ3R6Y1FMcjdKYzVCM0Z6empxZHpabFlMRmxKUTJFei9abElvallFWWJV?=
 =?utf-8?B?bStjSW8xUkpiVXo2alE0bkt4NVRMQjBGeWZzSjI5K3BpdXFxZUZRQ1ZmcGNn?=
 =?utf-8?B?UVBya2RpN1M0aGhPWjZXaXh5RjZLanR5MU1obXBRYVpaQ0dtbzVQM2s2R1Qr?=
 =?utf-8?B?NHJPeHhYSlp6RHMwRW0zUkw4SDJxdy80azdRalZDSG9OV1A1eHdJU3NFMkFa?=
 =?utf-8?B?M1ZPUlRTOXlLWTVON29lUWZiTE96Y2xSWitCdG5hNXViV1RLTEwzTE1YdXly?=
 =?utf-8?B?NTNmU3JRUk9McHZDZ1ZUKy8wSEtraVMrTXJzcWNhTUVOa082Uk02aXRVRWJ4?=
 =?utf-8?B?M2Zwd2h4Y05FMGNTcGVHbkNVT29NWGs1OTNUUkJ6cFRlSmhoUVJMV2hYTk1Q?=
 =?utf-8?B?VzNmcGpFT0VSV0MzS203OStSZmVrL05nSVl6cTlOeGhxQVNxYkdlNHFXamZu?=
 =?utf-8?B?Vk1MSDN6UGYzWGltN245UUVTRGJJVkxTZUxCV29iZ1RoRG5oQ096ZVMrQXJX?=
 =?utf-8?B?OG15Uk15YkZwaW9uaU5aNHNScjVsQjRCVXY4WG42aUZQOTk4MlRwSWhzbDNs?=
 =?utf-8?B?cklRVDM0VUFyRXltQjVtQ3Z3aXpJb0Q5ekhFbUhPdWtmZ1hvUjdCN2JtWEli?=
 =?utf-8?B?TFVsZGRaS1EvNk4vajQ1ZzkvUG9Od0dLckxZN3pqMndxSFdxR0RjNHJOcHBy?=
 =?utf-8?B?Y1I4UVhRQVhGejloblJYQTRlMkdWSDB5MEdvNnFpMVh2NUdrcWs2aDIwdGsv?=
 =?utf-8?B?eUVkZGVxcVUrOGFaa0duS1AzOXBKa25FTVArcy9SbXl6NXRBYlpUaHR2Znp5?=
 =?utf-8?B?b2UwenIxbHJaTHpBOEdJUFhaTEc0bVlnOXhVUnRZcW9IdkhZOVVFV3B1Q2c5?=
 =?utf-8?B?ZG4zK3F3ZmlWWWQzVU9hbWpiVEdTYUhGd282bzg3UGJUZldEZDdXdkppdk11?=
 =?utf-8?B?OExRUVdPQk5ITWZiNGdYaTJzVW55eFc4N3BEYm1iK1dXQXliVk9QVDc4OTNW?=
 =?utf-8?B?S0NWMzU0Z1g1M291bmtieDM2b2R1Vm9KdFJhQWVJazgrUTdPMUsyeU1hL3E2?=
 =?utf-8?B?S09NeXI5Qy9pMnhMZkljSTgrS3R0REc5MHZzVWlMTGZLelpTTktNVXYwVzNI?=
 =?utf-8?Q?PPxC1T4pLZE0exRn0xPjdVEmP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd65ca6-dabc-41b7-8360-08dd68b353cf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 20:02:37.3545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkYIt3Xxr/5Pu3Ci7jga/xCbZ7a6T9zU+ArGmcGzk/zG49s9cVLJ9tu5oSOalZr5f59gt51yVoqTGkZb9bRwew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
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

On 3/21/2025 14:36, Russell, Kent wrote:

> Do we want to actually do a fence_wait_polling before the loop begins like in all of the other functions? I know 5ms isn't a big deal, but the other ones we have are all after a single fence_wait_polling first.

I think the intent of that is to exit early when in an interrupt context 
(not the case here) and to check for GPU recovery (checked every loop 
iteration here).

Though I don't entirely understand how exiting early from an interrupt 
would work. A quick KIQ request can be stuck behind slow ones and 5ms is 
very short.
