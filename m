Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 436BAC3ABAC
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 16:14:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64C810E065;
	Fri,  2 May 2025 16:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4w8qsTG/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68AF410E944
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 16:14:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWl6s/GrZzk4SzyqdwMQalmvNXNksBsnaNtABWmW7twj4srA7sIQp6gBGTI76ikzxhR2eyE1Hzznqqi3bdj30HoxfflPl3XvstRwVUSOt3RIwsrywup/79UmbkzNuqlRkZe+4QU69fUXyVmvektFwIPZYktslc8YK7T67m25Zd5iJhRU1fp5tnF79A0e8DzeacwWmF/5CzsMj/RV7RLBWF8YteSGMv3wXT6/NH1EdPSJONQxyjlXT4AvCnVL4I7YPShdwr0lyLjd4zh6+qMqISUcGw0yRAHNvb6b9CRVimLfjGHzoIz6hCW4JUKigKjpighZHRcHDu3WyRCJm3axlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eethlVDyjuaCjz/vwNwVzE47SFXURWmolFz5fPKgDJk=;
 b=jkvHDK+GB4aJFvXiTl/Z8xZK3Fh1oGqxLCsbpjSxc5rdop+V0qQhYmgZznNrX3ABAGWurxfFsk2RjHO1p2TPhDpX8BSSpl7pv/UfsI6jRA5Xbi0Q1zkTbuUqaRopnkkv8vxrlpkuoOQcSd63CqON50lJX0a4+IHFfA/rJsHcbzo3X3PL6CUmcdKW05ZwYTNurFXyY+rCz+kGSGu5rPxXjZ/9d0cQRK3m+fXPRlUgrksdmvMOCyhVl5ffttJV0vBEK7ZhP2eH7B8PpO/ONXxXQAww5sUB54HkkRfWi8TkJLIgXx2jS37s9nUi8DnW2d3oXzQMwr+Ne60/hZXFmxRYCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eethlVDyjuaCjz/vwNwVzE47SFXURWmolFz5fPKgDJk=;
 b=4w8qsTG/1cod7pBG58AHOJ395bUr9qgNZMWLSSf9BsiwkfL2rC3h557LQ4aKHbRnRwJkXbvttJedKZkWvD0WhmMsNEIdjNfOuX/pUYlSZYoOFmrCyqo9W1u/nBZdRsaPNGt6baHxNQQT78o5RXlPGFUUvHR0v/sAzv95HjSN1HU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 16:13:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 16:13:56 +0000
Message-ID: <1dd4060e-456c-4fd9-8e12-4b8eaf2e3bda@amd.com>
Date: Fri, 2 May 2025 11:13:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix pm notifier handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250501200931.358989-1-alexander.deucher@amd.com>
 <20250501200931.358989-2-alexander.deucher@amd.com>
 <591ce362-8150-4c81-a9b0-2752e0f27d15@amd.com>
 <CADnq5_M8KQyCPZ5iXJBqmHyuzHOomXWNfDvxwJnmXZ45a=T-6g@mail.gmail.com>
 <CADnq5_MhNS1Mff2JZqtzuqYg=xmpM_vDtRwka6NcTU1aUvixiw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_MhNS1Mff2JZqtzuqYg=xmpM_vDtRwka6NcTU1aUvixiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c572013-2f5a-48f3-c592-08dd89945705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkdaWUZocVluOTJNMkY5NVQzdzNTdTQrVSthRjhGRlllWm5oM0U2bzc0dmxW?=
 =?utf-8?B?WWxQSERpajNiRndDQUpGM00xa0hWMlZ2MFM3SzBFS1pvUFFqVVN1dFlnQm1J?=
 =?utf-8?B?S2hDbEpYalJic1lmdDZuMERFcGZ1L3lvTTVMc25VQmp1VVllZ0FndFNkd0o3?=
 =?utf-8?B?SzBTT0xBZmJkOU1EVkZLQkExRmdXMW5DcldMay9XdUY2U1dQOGRqREVJL3FX?=
 =?utf-8?B?WFpLcDR2QkRVeDIvTFl5c1YvRGlEa2JTMy9uY1I0Z0hqN0J5dHhrQnJQbnNi?=
 =?utf-8?B?Q0ppOGpzRytDZDdSaGUwZnZ6UmJBRmcxVXFqM0Vvc2VNaGpEckZER3R4enBO?=
 =?utf-8?B?bXcxbnVxcmdmcVk1RENnU0NDc3Y2R2kwYm90UXpxRmVDaWJPdmdvS0VMamgr?=
 =?utf-8?B?Y0lGZ094OXRrbzEwbW52UjUzaUszRHl5WTVXRVhvTkNLUk9abDFQZmNRU0tS?=
 =?utf-8?B?WUtOTkFiM0s5Uk9USnB4U3NNb3V0MXRLam5wZ2pwVytMNjJCbU5QT0RtekZh?=
 =?utf-8?B?QzI1UHEralBqWk9WaVJxNEZqTEU4ODJPRVpucTFsSmpKUU1UaFRLUUt5S29N?=
 =?utf-8?B?Z0F2RTZ3b29sYm1LclpoZTBtUjNDTUhlOVNKellKN09UNXVic215TndUT3hT?=
 =?utf-8?B?cGlKa0g5TmlrcGZDaEUrbEpFc0ZYSEdSS1dPM0Q5SlNCenAvMS9RVktjaVU3?=
 =?utf-8?B?VlZNS3FWeFlnQnZLeUFFVUI4ZXViUkpwQmxYS3ZJemxXTVZnVDFyUVBmUjFk?=
 =?utf-8?B?djVKMGt6L0J1VzdIUnpvWjZ5c2pDYzdGdk9jcFgyYVEzTEY1K1B4Y1A3SmV3?=
 =?utf-8?B?V0dPR0hST2VpN0xXSUpkSjl6ZmE4TlhOYlphSWkzanBZcnRJWXVzaGhFTW4w?=
 =?utf-8?B?a3Fac3JqU3hIdjFsVXpDK05nWlBYazVYamxHRDc1a3VzQklva2xPbm82bVNG?=
 =?utf-8?B?K2laZDFHS0xqTGorSWVXd0h5ZDQ0bEJHV1B1RWJ4M2VIcG5GS0NRTDZkSDFV?=
 =?utf-8?B?ZGpuM1BDb0x1Z3d0SHFQRHM4YUZJUDA4K0Rod0I1bjk5RTFQSHA4cmhta2Nv?=
 =?utf-8?B?YVJaMVVFc2dFWkFscjMyeEExZnpQSk1xMWJudUR1S2NIbzlRVXdiSysydkdX?=
 =?utf-8?B?RzY3L0JhQ0RRZUhuclQwUGwwSDZqSmljQjJSZXo0cEhIZ1NmVjhpV0dYd3ly?=
 =?utf-8?B?VjhEaEdhWi9lQkJVem9RSlBwZ2Q3azBRbjRrKzFocDJjU3VVWkEySldPSHU2?=
 =?utf-8?B?d21EVEt6OGhLQmFSLzZ3T3BYQUQzaEdpc1ZFWjJkaitxZUk4TEhwYUxHU0p1?=
 =?utf-8?B?WWFUNHhUbVNSejFFOHlTaXN1RjUrbGVwNkdUamJVNjJhUXFmWktSRFZ6Znhl?=
 =?utf-8?B?L2hZZlprSkx1RTUvQjNPSDN0WVlmMFVhN0dMeHV0OGRKSGxQVFBJVEptNnc3?=
 =?utf-8?B?c3l2MVc4a25zK0NkY0UxdW1DZG92dll3bSthY2dLUml0VFF4azlWMCtmb0Fk?=
 =?utf-8?B?UklFVHQzRFExZTFyZE5nUnhEQzlpRFk0ODVVN0RtMmorczU0dDFpby9TRnNX?=
 =?utf-8?B?WmJxcks3bUZpZjE4dmV0NU1Ma1lqNC9hRTB4ak44UE9RVFZPYWUzeEI2c1VJ?=
 =?utf-8?B?L21vbHJpbVpOeVB1VTlxVmpZWkU4Y0Ezc2JSQUJqRzJQbks0aE9DaUUxbUlM?=
 =?utf-8?B?b0pYanAvYytFNnc3Q3JPbXhLWGx5UmxDa1lGUEdEYmgraUducGhuWWRQZkNl?=
 =?utf-8?B?TmVsRmNhaVpkRm54NGx5ZTdaRkV2YzZtdnhhN2o4Q291emtVR1d2a1llaXgv?=
 =?utf-8?Q?uSjhUhNeDawMn9XSZQeEOVHbKdX6mzBPcBi+o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azVNd3dIa0QvWHdIbzRwVFY5UDZxakttNUNxRkhJSUFYcWZOUFM4WUlHZCtT?=
 =?utf-8?B?UXM5QUV6dWRWTXFCdVI1aHpYcnU3cVdFSHY4SGhIeEF6Y0FEOWhsenV6N0lX?=
 =?utf-8?B?bzd1YU5YYjZVbm9hTytWUjVNNmlaU3BEMlZ0QXdnTUNPS0RzUHN6eXY4ZGhT?=
 =?utf-8?B?bzE0NXFJbDNyZkk4NExac1c1N3FWVm8wb1k0bmtSUWFET3YyRjI5NXJCNFl3?=
 =?utf-8?B?MUhkbDhwcmxuK09lRTFwajhFRnQ4ckZLQUZZM2JXWUlNNkp6STVaVmVuZGJF?=
 =?utf-8?B?d2lCWkkxc1h4ZXVOdlFYWmMza0hlVHpFV2tseDh2MTJwR2RDaWVWajFrdUdl?=
 =?utf-8?B?YzRsRkN1Q25jekZEMHhYb0EyVGRkMmFQMTk2YXZISDNnbjVhazlwNEJNbHFq?=
 =?utf-8?B?aFFVZkVFUmgvdmtxcC9FQWNSd0VEdW85V0VuODFJakViOENRWWZVVEw0aUNj?=
 =?utf-8?B?VUYxV0pFSmZTRm5NQVo1VEFDNkwxOTlESjVGZlI5SDhRTXh2V1ZJd2toMnBp?=
 =?utf-8?B?aUNmUGF0TitXb0VydHNlSzlTUWh6aWwwai9FVXBJMkl5VW5QOE1PYVRueDln?=
 =?utf-8?B?dDhkNUhHc0Vrc0xoNDRMeHNpb09iWE1kU0hMNkNzamhhWExleDcwNjBKWkJx?=
 =?utf-8?B?VVM0ZkdyaDA4SSt1Vm9GQU9QWDFjNDJzUllyQkFacHNzWEFmQUtHQ0RIYUw2?=
 =?utf-8?B?SnRlMlUrUndOMks2LzQzV0ppVmVMQjgyOXJmUi8xZlhYZUhJZjN1Q1FvVU0z?=
 =?utf-8?B?K3lwMWF1MEVrbUlrWnpOcEdzSk9pYVBUQjVVa3A5U0FlUG1TVHVNUVlsSzBH?=
 =?utf-8?B?dGJqQ0NLU3NkSVh6ckpCa2pvM01mWHhaWUxSd3FqK3d6em9Zd1V2QWdjK0hC?=
 =?utf-8?B?SmVSeW55c0RqdkEzVkc1MVlISHd4VjY1VzhaSlNmTTZMVmZWMjc1aGpET3Qy?=
 =?utf-8?B?QkJKcUd4cUErNCtxV2cvZ1ZIZ3FHemtOYTRCZU9Va3NBVEdWSWwvQ2luZkVa?=
 =?utf-8?B?cDV1Q1k3WTZqcEpSYzhzbmR2aU8wdE1WL1JENmo4SitObStGWUxQVml1QlQz?=
 =?utf-8?B?OGVxb2NxN2JiT1JPZ013d0p3dVlxNU4wSmIzejJZY1hHd1VDTG1hUTFhSHhs?=
 =?utf-8?B?dWNMTEx1V25hcDJaN08yMytNT0FiVUxuTXRHNUxmRVJSN2dYelgwdS9DaWQy?=
 =?utf-8?B?L0FaZWVTRWIxcTlyTndTU3Uyb3ZLck9JSFhKcXYrWHh5dVBhL0tRSXpWRjRz?=
 =?utf-8?B?dGYyRUFiV0VrejQySWwzdzhpOUF5SUwwK3FjRS85dlZhZUU0V21vTDZGdzcw?=
 =?utf-8?B?UDViRFVDV214RkM5aDJGaGtoMmhKc05tMVc4bmJWSHo0WGVYYU5GZDZJOE81?=
 =?utf-8?B?SFdJQ1hYY215NFZDU2p2dHNvTVhNNno3SlJuZEZUTVl6YU1mVFlVSVpYYnlR?=
 =?utf-8?B?U29VUy81MG92MTNuQ2dDNjgzSFkyTG5VY0FYaXJJQVNEcXJra044VkNJdmFI?=
 =?utf-8?B?S3JLRHp3NUFpbEhEbFVWS1pwN2hiZlp0SExQdHR5cEZVM3B0YzZrakNxY1Ew?=
 =?utf-8?B?UVRXdkJ0RzlpdTBUV0xYTUVqc2l0cWV1amFONEVCbmZlSVREdlo4RlRFSkJX?=
 =?utf-8?B?Q3FSMDZ1dEY3cFE2ekxEMzlOT1Q2ZzFveWUxOENNNlRYV3BuaC9nWEFCbHFy?=
 =?utf-8?B?dlMzNzRmbkFjZ0lSclltaDlrUytnUktEeHVtRUlnSzdoZ3BUc3oxZXNuc0hQ?=
 =?utf-8?B?ai94d0xxcFF4cWliTW91VWZrZ3pDcGd1ZWZTRTJnWTlIZ2RndUg0Q2hzRUtx?=
 =?utf-8?B?cE13U3BIb0tyTnZkc2xESzJtSFNqQ1lFbHFTaXQ0YU1Nc0wwM0xxN096Q0xB?=
 =?utf-8?B?R0YrS3lra0VBVGl6Q0UySFU5YVZtcU9JS1dTc25rRDRWMlFuRUErMWZHTW15?=
 =?utf-8?B?cE5nTkEzTDBWOWNFTlZWaFNDSllkQkYzSkdEb3VMTTRsNnV6am1JL29UdUFG?=
 =?utf-8?B?THRzajM2Tzh5Z3A2Q1Z3OG5aY3gwWnFmSDlwMW9qQ1pRTDhSRzhwaFF1V1Z6?=
 =?utf-8?B?NkU0ODc4V1N5Zjl6NGFyWFl1NE9zOHlPL0ZyQngvQVpBWHhmUmROWGNGL2dD?=
 =?utf-8?Q?zzvUoK0k7XLk8o2CHsrEBHPXw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c572013-2f5a-48f3-c592-08dd89945705
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 16:13:56.6907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJaVI+SoqDeIojrJI2Zl9c7ossaPyy1fRoQnwE1p/BPNneKg8lFKpUcgEl0IgKYSe3ACo9KSgCH9al8nOkFPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887
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

On 5/2/2025 8:13 AM, Alex Deucher wrote:
> On Fri, May 2, 2025 at 8:56 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> On Thu, May 1, 2025 at 5:19 PM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> On 5/1/2025 3:09 PM, Alex Deucher wrote:
>>>> Set the s3/s0ix and s4 flags in the pm notifier so that we can skip
>>>> the resource evictions properly in pm prepare based on whether
>>>> we are suspending or hibernating.  Drop the eviction as processes
>>>> are not frozen at this time, we we can end up getting stuck trying
>>>> to evict VRAM while applications continue to submit work which
>>>> causes the buffers to get pulled back into VRAM.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4178
>>>> Fixes: 2965e6355dcd ("drm/amd: Add Suspend/Hibernate notification callback support")
>>>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>
>>> Rather than removing the callbacks (and thus introducing the "other"
>>> bugs with memory pressure), I've sent an alternative series.  LMK what
>>> you think of this instead.
>>>
>>> https://lore.kernel.org/amd-gfx/20250501211734.2434369-1-superm1@kernel.org/T/#m6cdc075af911868667ea6fc849bcd196477d6c20
>>
>> Series looks good to me, but I think a variant of this patch (with the
>> evictions still in place) still makes sense so that we can properly
>> set the suspend and hibernate flags in amdgpu so that we can optimize
>> the evictions for suspend on APUs.  Will respin.
> 
> I think this set still makes sense for stable, but then if your patch
> series lands, we can apply the attached patch on top of that.

OK.  Let me re-look through your series once more and I'll leave 
comments or a tag.

Regarding the patch to re-introduced it you attached, I suppose the 
drm_warn() message doesn't need to talk about freezing processes as a 
solution to eviction failure because freezing is implied with the new 
notifier in use.

> 
> Alex
> 
>>
>> Alex
>>
>>>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++-----------
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 22 ++-----------------
>>>>    2 files changed, 15 insertions(+), 32 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 71d95f16067a4..d232e4a26d7bf 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -4974,28 +4974,29 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>>>     * @data: data
>>>>     *
>>>>     * This function is called when the system is about to suspend or hibernate.
>>>> - * It is used to evict resources from the device before the system goes to
>>>> - * sleep while there is still access to swap.
>>>> + * It is used to set the appropriate flags so that eviction can be optimized
>>>> + * in the pm prepare callback.
>>>>     */
>>>>    static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
>>>>                                     void *data)
>>>>    {
>>>>        struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
>>>> -     int r;
>>>>
>>>>        switch (mode) {
>>>>        case PM_HIBERNATION_PREPARE:
>>>>                adev->in_s4 = true;
>>>> -             fallthrough;
>>>> +             break;
>>>> +     case PM_POST_HIBERNATION:
>>>> +             adev->in_s4 = false;
>>>> +             break;
>>>>        case PM_SUSPEND_PREPARE:
>>>> -             r = amdgpu_device_evict_resources(adev);
>>>> -             /*
>>>> -              * This is considered non-fatal at this time because
>>>> -              * amdgpu_device_prepare() will also fatally evict resources.
>>>> -              * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
>>>> -              */
>>>> -             if (r)
>>>> -                     drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur: %d\n", r);
>>>> +             if (amdgpu_acpi_is_s0ix_active(adev))
>>>> +                     adev->in_s0ix = true;
>>>> +             else if (amdgpu_acpi_is_s3_active(adev))
>>>> +                     adev->in_s3 = true;
>>>> +             break;
>>>> +     case PM_POST_SUSPEND:
>>>> +             adev->in_s0ix = adev->in_s3 = false;
>>>>                break;
>>>>        }
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index cec041a556013..6599fb6313220 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2572,10 +2572,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>        struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>>
>>>> -     if (amdgpu_acpi_is_s0ix_active(adev))
>>>> -             adev->in_s0ix = true;
>>>> -     else if (amdgpu_acpi_is_s3_active(adev))
>>>> -             adev->in_s3 = true;
>>>>        if (!adev->in_s0ix && !adev->in_s3) {
>>>>                /* don't allow going deep first time followed by s2idle the next time */
>>>>                if (adev->last_suspend_state != PM_SUSPEND_ON &&
>>>> @@ -2608,7 +2604,6 @@ static int amdgpu_pmops_resume(struct device *dev)
>>>>    {
>>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>>        struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> -     int r;
>>>>
>>>>        if (!adev->in_s0ix && !adev->in_s3)
>>>>                return 0;
>>>> @@ -2617,12 +2612,7 @@ static int amdgpu_pmops_resume(struct device *dev)
>>>>        if (!pci_device_is_present(adev->pdev))
>>>>                adev->no_hw_access = true;
>>>>
>>>> -     r = amdgpu_device_resume(drm_dev, true);
>>>> -     if (amdgpu_acpi_is_s0ix_active(adev))
>>>> -             adev->in_s0ix = false;
>>>> -     else
>>>> -             adev->in_s3 = false;
>>>> -     return r;
>>>> +     return amdgpu_device_resume(drm_dev, true);
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_freeze(struct device *dev)
>>>> @@ -2643,13 +2633,8 @@ static int amdgpu_pmops_freeze(struct device *dev)
>>>>    static int amdgpu_pmops_thaw(struct device *dev)
>>>>    {
>>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> -     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> -     int r;
>>>>
>>>> -     r = amdgpu_device_resume(drm_dev, true);
>>>> -     adev->in_s4 = false;
>>>> -
>>>> -     return r;
>>>> +     return amdgpu_device_resume(drm_dev, true);
>>>>    }
>>>>
>>>>    static int amdgpu_pmops_poweroff(struct device *dev)
>>>> @@ -2662,9 +2647,6 @@ static int amdgpu_pmops_poweroff(struct device *dev)
>>>>    static int amdgpu_pmops_restore(struct device *dev)
>>>>    {
>>>>        struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>> -     struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>>> -
>>>> -     adev->in_s4 = false;
>>>>
>>>>        return amdgpu_device_resume(drm_dev, true);
>>>>    }
>>>

