Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0B5D12671
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 09:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCFC810E285;
	Tue,  5 Nov 2024 09:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NtViW4n";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8346310E285
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 09:44:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFYVLp2tC3CD+jG9JyW8dkkZTIFoI2CCExq7OoKumYohqbrGuHoGRebknhb5ANsN7ElDsqwtCXyBAGphWqMC1lbbs2EXaXUXsVL0Fsh3hF4AREhW0ctxb/r0ntryAfqm8UtQDq7qMzprpyiDZZkK4ZTBK+tHHS+xQNaIIZ5KjK3dane/zsBcwqM7KWQ0Zze8BmO1yLbe9dA06MxSxExvkjbwqBpA5UVGMRpM7HLl6lcRRkQAqCGHcEhZlD7B4SAYUVSOhUcTYlbduLcMhoeIUlUI5FJXEVDj4Va9he5QvfyVjBBl0xivPRCRyDlZJmNoF9t0NuOAawYJcmNBQwLJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b9KIrWvjCGOw7J4y9B0+8+lVjg/Dw2RgdlxPZHtVKY=;
 b=AJ8Ja16GuXK6fahTJYzKIQAUWdAxRfn6cZyLijaD5t/c+9HpKslsl9oJLzfPibH3RVselesi2QYGXxFUjbubi8i66yqvoFZpTsRa8jfJ/ekGnvKm+fuHujmbFE3qxGm5q1sfMx3otPnMxSsw7yTIi5k2bShVZ9O1BPyMFI22k4QpIFGnG9tHj0/LxyetB9y5m/g82kog6EGw6RvTB5rKSn7Ag7kDs290BsFIqswnustcvtSKR+NDvouQR6n2MBVDoMmrD31IwYl5e2ZfFLgSvS5ErzLzkwBojDjE6gGjIc5utKBKGSHhd9vra8Nnjjf+f/FG0El19wwdsiQkh+G1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b9KIrWvjCGOw7J4y9B0+8+lVjg/Dw2RgdlxPZHtVKY=;
 b=3NtViW4nkThfw9266Mz03TTQ3mSmbtyhk58DSRzQGoc/naU0Su2qAgL1D2VLsgKqT7ToDZqrljCfHjIU2uUlNdhObtYGOK0eSZRVRFGfN7pe/Sx3Kj0y5yZf2nr6ShEoJw+nF+ZlnGCqMgQPFxIWZIaz23S2UV+E14844IXRRvg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 09:44:21 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 09:44:21 +0000
Message-ID: <60a32e4a-b6af-49b1-b70e-a538ff0c3d86@amd.com>
Date: Tue, 5 Nov 2024 17:44:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] amdkfd: always include uapi header in priv.h
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20241031104701.248234-1-lingshan.zhu@amd.com>
 <19443a63-e82b-444b-9f28-ff0b66929393@amd.com>
 <5072b301-2e9e-48c5-8404-cdea976c3182@amd.com>
 <e5bfe061-bd1e-4ce1-8c5d-a0de372ed75c@amd.com>
Content-Language: en-US
From: Zhu Lingshan <lingshan.zhu@amd.com>
In-Reply-To: <e5bfe061-bd1e-4ce1-8c5d-a0de372ed75c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: cd6ee865-449b-4545-0e6d-08dcfd7e6cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2VKeUlqSExhQ0o4VkNxbUp5VHp3WE5qVXh0N2k5TGtyWTIzY0w0WHpreVZD?=
 =?utf-8?B?VXdlbUJUY0N4Y0R2ODN4ak1NSjhEeUxWdzRCY1ZaeEJieVNHZFlZVWdXS1dS?=
 =?utf-8?B?TVhvTnJWZWpIRDd0VVpadlU2V1phUEdvN2U4SFg0eXFTV0N3TnhkTjd5ekFS?=
 =?utf-8?B?RWtpdUs3TmxHTUpVelNONDJxb2g3czhGd014NUpQQmo2SlN1eWtQUFllaVJk?=
 =?utf-8?B?YmRMM2s1Q3BqT0VFSDFxLzh6enk3NVFoL1ptMkRxdlNkZ0FZTVZkNU9FeGpE?=
 =?utf-8?B?Z2l1OE9jZmx6NFB6RVgxWDNnRWhQSW5zQmgvR1RuTTlmQnZUeXlUSkFDaTJp?=
 =?utf-8?B?a3ZUWHQ1dWhmK0pEZzNSYUVhMkV0VmI3NzZ2dU9PVEJWem9RdTUxSjZZRjZj?=
 =?utf-8?B?MVo3UXV0NTRhcXN0TjlqUExFT2p5Z2IwZU95Q09BRmNHeXU4YUc1ZkovckFn?=
 =?utf-8?B?cGt6aE13OXUwV0JKZkRrcVFTZ1M2TElJODFwdDN4Q3ZiWUJHam5QTEk5bkgv?=
 =?utf-8?B?bHpFd3F1VHpYOU1Sc2JvVnVOeDErb1R6UEhOd3QzQjdWZGJIdWtTVlhVTTE4?=
 =?utf-8?B?NS9aOTlXV1B0MmsxUUExWXYxa2s1Zjk4cHB3bS9nMm5kUGRDVkIwR00zNUdu?=
 =?utf-8?B?Mno2UmdrcmY4alJ1OXcxZ1MxYkIxWVdRUmNvaUVSRjlOYXdFcVFVSzJPOXJ4?=
 =?utf-8?B?WVpWckw3MTZaOGl2NU85RzByU09UZFdYanl0ZnhWTi9TZFZvZlUyTjVhTDMx?=
 =?utf-8?B?OExoSCtUK1ZpTEVhMDFVN2FoVnYwWXdOOURuRUZ3c0ZMMnhZQVdRaHFWbTVQ?=
 =?utf-8?B?MzhZRHhTckF6VFU0K3hxRUluTmt4REFaNUREN2lIRmVXdVJGcDh6aGJKWjI0?=
 =?utf-8?B?RkN5NFZMYTF6ZE40QXJuS0lyaGY1ZnlBU0QwOThWV3dyTFAyQk1YRWl6NUpZ?=
 =?utf-8?B?eGU2U3hOaWNlZWJHYVptSksvMVg4ZEd0cHdaMjI1Nm51aitIZ05ZRzhkM091?=
 =?utf-8?B?YXBwWnJTUnViOFZEM24rQ00zYnJWMlM0UU0zV3ZBTmtXWlJYbVVFdmwrWTJI?=
 =?utf-8?B?SDhSQUYvaFl2UE90RW5Dd0dadDB1ZmEyRE94czBwRk0rdm1DVG5xM1Fnalhp?=
 =?utf-8?B?M016dk01dmpLNmJBMnB0WTBPOWVWL1Z3ZG4yQU5MZUpXaFN0RWR3RW83Um5X?=
 =?utf-8?B?eTV4cG15eldBVkYwQjB5Wml5NzdFeXc0aEpRYVJPSDhlNVlFaU43ckZRazNh?=
 =?utf-8?B?Z2FadTlXNnU1S2ozNEoyRzhqQmxUeVdkQ2M4bHl6NlltcGJ6UUlqN1pRMzN3?=
 =?utf-8?B?NHdJbzF0RVJuaExhY255UFVqcGp6bzl6ZDdVQXBuUllKU1NOKzdSQzgxNEVt?=
 =?utf-8?B?cFNYTE9CbWVWNlJ6a1BHTnZQRFBlbGMrbGxaU2RpZzFsL1BzejdHVi9Jc2cw?=
 =?utf-8?B?SHRidkRWNnBlU1lSSmYzbnhsRHU3OWRQeis3d3J6K1hGRGhWZ1dxRitOSnF3?=
 =?utf-8?B?cW9PYVJIdE9aVHZvTmdLVGduMlR3UHM2bi9BQkdMczFIeFRLcHFUTHJsc2dV?=
 =?utf-8?B?VnJaK0dpTlUzWHdMZDJwYVJYMk9vM3dSTUVIa29HTDVLam5ac2h1a016S1N0?=
 =?utf-8?B?UkM5M2djbUJXblF4V2RTMS9KL0VpRzczMlVib3FVbmxwK3lSWkRoSk5CdEhD?=
 =?utf-8?Q?XZzdx+AP6EPftJnhwVj/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0xXS2UvcHEvbGpLNnRyTFNzYmV2azg2d0I3ZnJCdHkrazlvZURFT0RCMnUr?=
 =?utf-8?B?Zk1vbnNycDdtWGdWZlZDdHBHWHVtUU1TeFk3RVBjSk9TSUJkbzBRaU5vTVY0?=
 =?utf-8?B?NUpCUWVhMHN0bTE0Z0ppNnlzQkVsTnNXM0hDaGkwMDBPbk9nRitUZ3JLbTYv?=
 =?utf-8?B?TG1WSmVTcXdLQkdwVlV2ZVpkVERQS1hNRzJmVE9pWkJJOElDQVZISmJqWnZG?=
 =?utf-8?B?bkN0UTdGT2JUNWVKN2xEc3ZIQXAvYk5FZE5tUjJYMkxodDVNbElOeC81MkIw?=
 =?utf-8?B?bUhlb2JvY2w4L245U3NpSmk3NlFKUWM4Y2xXQlU3Z0RkdDlNamZmbTkvbVZO?=
 =?utf-8?B?c1FnblFJREZWbWMvWk5vNkhjQk5qWWdmd29IYzl0dTBIYVU2d0RJRVRjRjBB?=
 =?utf-8?B?ZkYxeWxhL0dyeUFtNDBpY3VKRzY2bW15YlJRQ2ZsZEtVaUxxd2Eyc2E4L1Fh?=
 =?utf-8?B?UkJjQzlrYjhPbHgzdUs0Y0tid01EUnBmWmdJN3FpR1J2eEpOaCtwbk5mKy91?=
 =?utf-8?B?dE84NEdHOWgveUdCTGs2cmk1NW5WQVdybUVhRzBYdi9TQU51dTdvNlFVYk5j?=
 =?utf-8?B?RGhXOGR0dmMzT0llb3UrUk95WWMydTJ3bDJXL0hSREFnZTNYd1prUWxvbENP?=
 =?utf-8?B?enhJdE5jL2JMWEJyakZRLzEzdHZrWDNjOFlOcWJkZjdXYnd3MDhsZDdRWXRM?=
 =?utf-8?B?WUk4SlQvZElXVnlJOXYrQ2xQQmJIWGxLM1dUNlRVZHJtdkxEWWxnWmhMcGF2?=
 =?utf-8?B?dE15SThvUW9VRUFTYW9TOTJUV3hjR1RJUk9sdkc3TkxHRGtQTmd6NkMrKyt0?=
 =?utf-8?B?KzNkVjQ1YU1RUFJtVFFSUFVjYU1WUnR6T1p6Y2NkSVRkT254R0Z4cjI3b3NF?=
 =?utf-8?B?Slk2dUgyQkZ0U09jbk9zNllyVkgvWmxKdFY0Z3hJeEVLckdFVVQ3MHVnT0NU?=
 =?utf-8?B?ZjBWcHBaTTk4K1laQ091OEVvdTVBL1dDek5zSExHWm5xdURtSHpoSzZNMVhu?=
 =?utf-8?B?YWx0a2tEUFlsWWlBL2lhaURTanVicldMYjRBYy90K2lPVXBlWTJpdm15d0NU?=
 =?utf-8?B?dG53VDFQaXAzU2xBUDRHN1l3NkN1THYzUFhWWkNLTEVNSlBRc0ZmQmJlOGs4?=
 =?utf-8?B?S0ZSZ2prenNOZUxYYitYNkJnMzJpVXFtUVZLZE53ZmtseFZkejFjQTgvclVX?=
 =?utf-8?B?MnlDMGNCaFNMTk16cGp4eWIweDRZSlIwUXl1Zm4xckYxa2VXaHlZU1dDMWhT?=
 =?utf-8?B?TSs3S1lOeXJaL3BHcnV0L1UwM3h0Y00wbmVwenk1WWZOWVc3cjZOZkJ2am5p?=
 =?utf-8?B?dmxISXFGR3ljUU9tUWZ0SWRmOXdaSXZIZ09VNlk0UXZ6RUtBZDBNd0xyUjdz?=
 =?utf-8?B?UGZQb1RFRlNyN3hWYUNGdEx4QlZCcXlQb1B3M3FVYzFvclNucTdPUlBxTG1w?=
 =?utf-8?B?dU5sVnQzNXd4bHgyUk1uVkpGT2hpQ05IZHBTSDNRSVdIalY3SkoxV2hrWG5L?=
 =?utf-8?B?VDZtWElzRFEwb1FScUx4MWJhYUFyMnpUQkF3d3ZGbCtGSkh2RWd5S0FGWHZ3?=
 =?utf-8?B?VEh3cW1taUhtcWpWclFEMUNSTXM0cXZGUmJ2a1BrTjFxbTdvWisvdnBkdnFX?=
 =?utf-8?B?ekE1WXRoTzRYVFZWUnYwenFZaTRCYzAvbEZqVm9lRDduTVM0aGJxTjJhTG5J?=
 =?utf-8?B?UkJUdVd4KzR2MVJNNk1zTTJrcnJOelYxcUpXNnZvaWR0N3hjcTgvSXB5cTVJ?=
 =?utf-8?B?ZE9zaDJGYW9Va0drYnozSjBvRXVNM0J1MXZwVk5tZzlWa3cwWVV2YXppeDRk?=
 =?utf-8?B?QmowWmE0aUhCNWFYTG9oY09RY29iRHEzV1l2cHVuanBzYytlNFJXbkkrOWV6?=
 =?utf-8?B?bUtUYTRKOEs4dTd0QjlVQVFlQ1A3Q1JianlzVHlrcXFzMmEvVnVjVWczTlFU?=
 =?utf-8?B?cDlnMVpOUzZCWXhsUkppRWkxaFZvMkdBTFlORnlGcnlBQzh3b0FmUWk0Z3lP?=
 =?utf-8?B?c2lRQUNhRHlmOE5zTW1IanArLzNEcjhUb3N5Vi83Z1J1STl1T055aWNlUDdz?=
 =?utf-8?B?Yk5oaUk5WGpSMHNkOGRMR1d2NUNaTmJFb0cwSVVRcFY1SWwxWXpYcEptNnlL?=
 =?utf-8?Q?cVMz2ZwxjjKTU2yD+VM7ZwwOd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6ee865-449b-4545-0e6d-08dcfd7e6cb7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 09:44:21.4006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XiHWokxxCWeGX39/vUk/xWArn1lt5XgIwysc2NMkHmceAYLHnGr6gUfF6FJ+PL/oZDH1anjshBLd+uic98MuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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

On 11/5/2024 4:43 AM, Felix Kuehling wrote:
> On 2024-10-31 22:15, Zhu Lingshan wrote:
>> On 10/31/2024 11:27 PM, Felix Kuehling wrote:
>>> On 2024-10-31 6:47, Zhu Lingshan wrote:
>>>> The header usr/linux/kfd_ioctl.h is a duplicate of uapi/linux/kfd_ioctl.h.
>>> I don't see usr/linux/kfd_ioctl.h. Which branch are you looking at?
>> The mainline master branch:
>> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_priv.h#L35
>> #include <linux/kfd_ioctl.h>
>>>> And it is actually not a file in the source code tree.
>>> If it's a file that only there on your local working tree, maybe just clean up your working tree.
>> Yes, this is a file on the local working tree, it is generated when build, it is  not in source code tree.
>> The is even no folder usr/include/linux before building.
>>
>> For a quick verify:
>> 1) it is not a source code file from mainline:
>> $git blame ./usr/include/linux/kfd_ioctl.h
>> fatal: no such path 'usr/include/linux/kfd_ioctl.h' in HEAD
>>
>> 2) it is generated when build:
>> remove usr/include/linux/kfd_ioctl.h, then build.
>> If we remove a required header, kfd would not
>> build and there will be error messages.
>>
>> but here we will see these lines:
>> HDRINST usr/include/linux/kfd_ioctl.h
>> HDRTEST usr/include/linux/kfd_ioctl.h,
>> no build errors, and usr/include/linux/kfd_ioctl.h is
>> generated by duplicating the uapi one.
>>
>>
>> 2) linux/kfd_ioctl.h is usr/include/linux/kfd_ioctl.h
>> add random characters in usr/include/linux/kfd_ioctl.h, then build
>> we will see errors like this:
>>
>> In file included from <command-line>:
>> ./usr/include/linux/kfd_ioctl.h:65:9: error: expected ‘;’ before ‘struct’
>>    65 | abcd1234
>>       |         ^
>>       |         ;
>>    66 |
>>    67 | struct kfd_ioctl_create_queue_args {
>>       | ~~~~~~
>>>> Ideally, the usr version should be updated whenever the source code is recompiled.
>>> If the usr version is not in the git repository, it doesn't need to be updated. I don't know where this is coming from on your local tree.
>> the usr one would be installed to the system when run make install or install_headers,
>> it is for user space, we should include the uapi one instead of usr one in our source code files
> I did not see the folder in my tree because I build with O=... so usr/include/linux/kfd_ioctl.h shows up in my build output tree.
exactly! usr/include/linux/kfd_ioctl.h is not shown until we build the kernel, it is a duplication of the uapi header generated by
kernel "make", that is why we did not see it until "make". If you run git blame usr/include/linux/kfd_ioctl.h,
git will tell us: fatal: no such path 'usr/include/linux/kfd_ioctl.h' in HEAD

In a fresh cloned kernel tree, without "make", in usr/include, try [lszhu@localhost include]$ find -name kfd_ioctl.h
shows nothing, usr/include/linux/kfd_ioct.h is not there until build the kernel.

Means 'usr/include/linux/kfd_ioctl.h' is not a source code file, thus we should include the original uapi one in our code.

>
> The extra copy of the user mode headers seems to be an artifact of the Linux kernel build system. The fact that the build picks up user mode headers from <OUT>/usr/include/... seems intentional. If your tree has an outdated version of kfd_ioctl.h there, it's probably something broken with your build tree. Maybe broken file timestamps. It should be easy to fix with a "make mrproper" to force it to update all the build artifacts.
the usr one is an extra copy, kernel build system copies headers from uapi folder to usr/include/linux, so the uapi headers are the original ones.

Thanks
Lingshan
>
> I still don't think we need to change the code to fix a problem specific to your build system.
>
> Regards,
>   Felix
>
>> Thanks
>> Lingshan
>>> Regards,
>>>   Felix
>>>
>>>> However, I have noticed a discrepancy between the two headers
>>>> even after rebuilding the kernel.
>>>>
>>>> This commit modifies kfd_priv.h to always include the header from uapi to ensure
>>>> the latest changes are reflected. We should always include the source
>>>> code header other than the duplication.
>>>>
>>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index 26e48fdc8728..78de7ac09e8a 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -32,7 +32,7 @@
>>>>  #include <linux/atomic.h>
>>>>  #include <linux/workqueue.h>
>>>>  #include <linux/spinlock.h>
>>>> -#include <linux/kfd_ioctl.h>
>>>> +#include <uapi/linux/kfd_ioctl.h>
>>>>  #include <linux/idr.h>
>>>>  #include <linux/kfifo.h>
>>>>  #include <linux/seq_file.h>

