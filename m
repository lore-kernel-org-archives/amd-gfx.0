Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6660EE7716D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 03:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5CC10E06C;
	Thu,  5 Dec 2024 03:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="REFH9FYw";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2A110E06C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 03:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP9R3h3/pNjjWoR9L/+jPoytGpwEBpiHWOMJngA5aP69LaLKywRNdyFT0GNg/V+VVTQfeuYGvga8py0j4ysU3kD680LlzMkjqQFbqrAyYfi5KdCopMHDR7NKQoJZCucTHOv0rVQU1Iw9mW8nh8gNjOvEpLAHhFrvDL5iN/PyPc07k/Go6NhfEMH+/z02PT0Ju5c5+o19OZ3tnY9N0oknaN9Yfs1d45cx/E1vPAt19hE7pzeIZFSoe8hDhwn8vadfNzonVGdiM3pjH2qtbl0216Hta6AS7hIbpihTLyJTXKUYFsOfPJBzt5AEJtv3aeGab3KpcMCb/y0gnUGewtzOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMG752B1RmMGnqcWqLbFFx43CTtoQQZ+KQ3gRUKqIOQ=;
 b=FCeg4cZaplLhNf30FTSdmIXG+hdmwZ+pR/lB5wvkGVW3zJRtTXnUkIuqItrL8J7FFfsAJoENjf69/3QCvyHmD55R9g3N5yIuCtvhOk1v+iyxK9VJDQXxZJ2MRKQJV+9QMVKzJoGQhNwDyLhaDweNbn+cb07BvUWID7Y4Gq0HDe1rL91yeQWlE4PLM3S3yJU1TYjOPaC1ETofZkwCI3jI4Hss+BUTVm7/OLJXDFFdzjezojwogIbepJQx7PPGhsG6PVzMK6vJmVlXp4XILNH6PWfXYoQBJi/AF7xI3rX+OYRbTrWiYwK0Gg1MUn1L3jOaKT76StderRm5PGKcipcWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMG752B1RmMGnqcWqLbFFx43CTtoQQZ+KQ3gRUKqIOQ=;
 b=REFH9FYwwIjcrm1jGXqNXSP8TaayYCgNcP1MKGunmxkfgjUx/FyqaVElM4pBI4Pz4sdE5gaDpkdMiOEYioHZelrOfEbg+cwF7JPMY4UwFOEP+CPWP1oPX5VwrV0mH+Qpy7RjmRw4VCwvLR62y5Ah25e2oJVbD/adgeTs9g19FJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 03:59:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%7]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 03:59:37 +0000
Message-ID: <176abc17-3f0e-4b9d-8043-0674a9cb6f7a@amd.com>
Date: Thu, 5 Dec 2024 09:29:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
 <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
 <2062652c-16f6-4e06-b3d7-73ef6a684aaa@amd.com>
 <CADnq5_MD0wexpOc+mGoXkHMHDv5BxybR+tyowedwxg7vvp6mQg@mail.gmail.com>
 <9f85de41-5574-4e83-b5ed-1640e45e90e9@amd.com>
 <CADnq5_PvErRnCQp-oTR1Qw46H6vo9BuWzH76ERqQ5XDzA1dkoQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_PvErRnCQp-oTR1Qw46H6vo9BuWzH76ERqQ5XDzA1dkoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e6d9090-d541-482c-e21c-08dd14e13ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MytBZzBmaUl5aHdHZlMzSzFPNmdSTHlhbUFIa210WGw3T281cHZKaFRZYkRx?=
 =?utf-8?B?YzFNRkR6MlFvOVpHeVNtTHBZam1jOUg2Z1dlSlh0NXdNZzE4M2dxemhHdUdu?=
 =?utf-8?B?WkFPMFJ6QVV2SDNlMS9uRk11N29YN1pWUTBLckVVQ2cxZFpZM0RYeC9td0lN?=
 =?utf-8?B?WlVXU3E3WGhOMkhDRldkNkp4TUdQd3UrY29leTYwU0hFNm1yUWFFellZK1hr?=
 =?utf-8?B?WlBDMlQ3YnlQS0tMcVdrQXBTRW1jYkNPVUMxeEVzZHVrekhZR0NrcjlNZE9n?=
 =?utf-8?B?alVQUHpIUXRPcENtOXBTSWpyb2xyWmNxbXpDR1VRQk9SQmlnSXROdXE4Uzlq?=
 =?utf-8?B?ODUxSkkwMUpHMGtDbDNOZWtVUkY4QnB6bnhZci9kMGZNcDU1d2tldlB6WmJM?=
 =?utf-8?B?WWVEWkVETFZLakZxQnRtNm8raTl5R0tGNVpHRWF0Wkx3d0ZYTVV4MFdXMDBq?=
 =?utf-8?B?QU1KaVZLYW9CZnFMWjlSMnhLckp6bHBYRU1Rd3dkZXFNQkk2S3o2ZUNrdk92?=
 =?utf-8?B?cVNtMTFnK0k0dWVFMkdrVXdtaTBwSS9UMDhDQ3BBRXB5VGdiRVR6cVVtYVdr?=
 =?utf-8?B?QzE3SkpZaFdoMUhKTFZLZ2VaaTJRZkUvNElnMXlQYnRvbEJnd0VaQjRqTVd3?=
 =?utf-8?B?N3o5ZjVrQk1PN25QbnQzdExycTd3OXl4aGo3VkdSU1htQzhDTHVFdXBiSC9h?=
 =?utf-8?B?TFgrRkh4YjRIU0V5VDkwckRPK0RuOUhxUUxJaGsyOXJ5cnFlRklkNFg3WXR0?=
 =?utf-8?B?b01RMFcvNkp0K2xrRkx0OWFYeDlNZHI0a3ZqVVFSUmpvNFg1d1doTVk5NHFt?=
 =?utf-8?B?Y0hqc0QxWWUydjlqQzFzenRJdzBWazdtUERrT2x5TmNMYUh3QzczY09zS0Fa?=
 =?utf-8?B?TlNiazRNVFZGa2k1MWovczVHRFJIeFlJQm01a3VhOGVmb1hHTGxMQmQrL2pN?=
 =?utf-8?B?TDh0OXFxREVjbmN1WitKdHhEbEtGbXo4K2lDK2FnSi9xcDdIMDZDQzFiUllm?=
 =?utf-8?B?eExVaU9jZTN5OGVZU2NSSHJ2LzloVTlWeG5zR3VJckFtajRNb0diOFBYSVhN?=
 =?utf-8?B?VUtVV1dJYkp6bm5Vb1ZsdmhzbWNjT0lxUXErU0luUFRJY1dmVHVaOE5OYlhy?=
 =?utf-8?B?RGZDVnVwVWtwSitGQVNtZytyZGdJbVJIeVRxTFk0ZEVOS3JhcGFOR0RJdld3?=
 =?utf-8?B?NHNjTHhSY081dmFpZ0JpUG0zMXZhd2hmRmFYTXBienN2bkdiUjRjNXRDR1Vl?=
 =?utf-8?B?OTljVkFZZjU0bDFlYkNiS25QSzdzc0pBNVlCSVJhdFFzOUJkdXJEU2E0YzA4?=
 =?utf-8?B?SkZQdkpSUXVIMUFJbHZwWTl0dU9Qdm5VRUkwNTdYWHlrWFhvZUVTOXMwRlNQ?=
 =?utf-8?B?RHpUOWk0TzNSbHFyR1IrUE9QN2VTZzc3dHFpMmc3YkFpSTBTNkVJSVpkWkZs?=
 =?utf-8?B?MjVjMnRjdUNqOEgyMGVhWXluTzBlNHRnQU80WXF1ZzYwQUlvUk9XTHhEelNF?=
 =?utf-8?B?VzVDYkNQVkNOUUluQXkwaktlWkpRSlJiNDBrRU85WUpCcnYwWlMyN2JlTHRv?=
 =?utf-8?B?dGViMFJUTEhFVWJxZ1QyVHZRbW9POWRNc2x3dklpMWM2RHF6bDF6MktvL0lQ?=
 =?utf-8?B?T0NUWjd1NEtoWStPZ216ZCtrSUFkWmk3Smo5ZVl4b01Semw4cmMyUkJiWjJD?=
 =?utf-8?B?cUFTOUlqd1Q5L1FRNEk4TFR0alhTOVpKTjY4d1JSRHRRd1E5MHY2UFY2REN2?=
 =?utf-8?B?Nll0QVNmdFFqTkpFZkdPTXQ0M3JIbzBmRElKcjlxMGU4UEo0ZVlGRnU0TkZr?=
 =?utf-8?B?ODVGcHdsa2ZQVWsreDdPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVB4bmdlcUxRbWJXREViNkxXYkE2NG4xdVQzMUFWb0UwVGFyT3dBeHRHamVG?=
 =?utf-8?B?bDFoSFZ6QmV0THV2OG5uaGk1Q1UvTUlBdytMZmJ5WGVIQVRsTjhLSWtqSGk0?=
 =?utf-8?B?cStkK01qUUVTSFBTYndCcEtCeG4yQ1U1bjNhYlV5VGxrUkVnWFVLOGxXYzBq?=
 =?utf-8?B?aXRWYWx3bFBqVUVEMVd2NUNpZWQ1VjJzT3NyUStDMm5Qb0hKYUxkc1hBQTNW?=
 =?utf-8?B?M0xQSFlWRjRrSXNjQTNhd01YS0hGclJ3VHZyY2hnYWxzeXFZaEtVVlcvZENX?=
 =?utf-8?B?MXJ2OU1uV21xeElDQ0l6ZGxEeTJVT2JHTS9VenJENlZnZy9IL0FYUXk1cll1?=
 =?utf-8?B?cEMrMDE0d0tJcFdqZnI1WWdXZ3BoZjVrMkFLK3lpYkdoSDVIaVJJbVJYUkFV?=
 =?utf-8?B?dGN6UlorSStoa29kQVFqYmFHdm5NOWV1UHF4SlVxTzNRNzFocG1KTnU5aEZM?=
 =?utf-8?B?Q1YzbCtDSytlR3JpMXJjWDdJNi93VXFpZ0RGVmx4TW5OcHV5MmtNQ1ErTi9y?=
 =?utf-8?B?aUpGU0xEOTdYYWk3RHRaK0N1NllGNEFhN0t2aU84SWxlRmJBMTZ2WXpKdkJF?=
 =?utf-8?B?bWRvWHRSYlRuSXhrUm9maGMveVhxWmdnNGZLTWQ0NjRta1BaVEJPcnp4bktV?=
 =?utf-8?B?UnI0TmFmT1hmSy9ETmJEZEJaemxMNERRcTk1T0VmQ21aSjhPQ3QwNVNqZE4y?=
 =?utf-8?B?R2pybVBaUHpxMmxzTkhlaG1yMWxBZGFPeXFvVmk3OEU0SXJHRXF0dmxUWjZr?=
 =?utf-8?B?RGNJS0Y4c3hSeS9Bdm1FQjc2SzVOOE1WaEI3Ri9Nc01vZnhtVGhuNTFmelg4?=
 =?utf-8?B?NUdrakpEMkhMTWVsNlZxMXlGM1ZmOGhIY2ovSC9LcWUzWHlmYWZDSGJZVUVr?=
 =?utf-8?B?azY2ZkloMWc4M3NmRmZ1azZkMkQ5blhCNWJBQm9xZW5LRVdzYTFJUFRTRFFq?=
 =?utf-8?B?ZFpNN3BJb3lRRHJyOFV0eDR4aFhwMHNxcjBWZ0d4QjNuR3orajlQZ2huNVVl?=
 =?utf-8?B?VTl0a0lYMzlOVHhkVjVab0JJR0NvTFhtUTZucFlHcjM3bXN3bjg2NjJXWnNV?=
 =?utf-8?B?T2FyZ3RmcWh1bFlsK0dZSkpJOWxlaUh0aGk3cUtlOUYxZmM5UElMTFhucWQ1?=
 =?utf-8?B?TXpUdFhTWDNzSytnSnFsTUJiOGNidkdPWnNteVQrM0ZtaHp3WE03dVF0eU9Y?=
 =?utf-8?B?TVA2V0VSNjZGclo2Nk1sYlZXdzg3WkdwdWJTOW84aVFrUGVmbEZHQkhyYUNo?=
 =?utf-8?B?MExDWnBDZ3cxdkMveDM1cGRQc3RWRkNPYjFoSEdqelRzMnFnOTZWUDBoS1I5?=
 =?utf-8?B?RWpyVTc2dkRzSE5uNnVkeFlaUFpSeGwvVGZUTjhnSTNqTWtKWEllcTFjamdI?=
 =?utf-8?B?YTBRNTExYWZKOTBBRXQ0aW1ob3kydlBFeUZqbWpDRGZqcWhESHVYakwrbE1M?=
 =?utf-8?B?V0N2YzZ5TmJ2OGZ6WWpsSVhYYk1yMXdNNHdBVUl1TmQxNWlBN2F0R09UNlFp?=
 =?utf-8?B?WExuTEFIQ29NR0MyN24veFZuSXM5TUlSKzE0K0VUbC9LSVdSNnFpZ3d5UGNN?=
 =?utf-8?B?U1JpaWtENkFaRUpkQ1phVlZzRkdxbUt6VXlIZktuNjQ0cVFIWTh5YThEb0FH?=
 =?utf-8?B?YWNQS0J6K04yOFRJT0NjR2EvekVqUjd6YzY3MUczTmhSVzRwQVEwVEJOTFhk?=
 =?utf-8?B?NytpWGQ0SkZEMmVCNnFIY0JIUk5PVDR6bXRFSmxxMEVyb0NvalNQOFJtNVRC?=
 =?utf-8?B?UGQxUmtEUG12U0F4eEZvdi9XcWN3YzFES1JNaFpCY0pZa1FIcDZiTjRzdlBz?=
 =?utf-8?B?bWlIWHpWVHdMTWMvZjQ3ZnR0ZzcvendmdEh1QURhamJQVjNUUEFVTHhENjNW?=
 =?utf-8?B?RTQ2V3ZZMGN0SVpoTmc0U3VOcTJuMTFwcjFHcy9ZT3lTajVIR0oyOGZEeFlV?=
 =?utf-8?B?cnBCdkZqODRIZ1lHcVZPU3BpSXlIdlBQSUJob1NSdUZ4N09jRGJjYnlZeXg5?=
 =?utf-8?B?d3J4UC9sYVpHS3VuTEU4VjRnRGw3MGdqeU9WUGlwUStZSFZUZ0xnOG1TWmdQ?=
 =?utf-8?B?dnd2MDFBeEo2RWpqd0FwL0Z6WmE1WUthbUVkeUhVYmtrVC9zamhOcTgyMCtS?=
 =?utf-8?Q?ZkFH+NtNuZ84uMcEcPgOxl3JL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6d9090-d541-482c-e21c-08dd14e13ca8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 03:59:37.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtMYTbLa5cvym2/GgnG76L4YJV1Znj5AX+XmGWGnklp+CCu0sW9zGMGVM/W/zSoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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



On 12/4/2024 10:15 PM, Alex Deucher wrote:
> On Wed, Dec 4, 2024 at 11:18 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 12/4/2024 9:30 PM, Alex Deucher wrote:
>>> On Wed, Dec 4, 2024 at 10:56 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/4/2024 7:51 PM, Alex Deucher wrote:
>>>>> On Wed, Dec 4, 2024 at 12:47 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
>>>>>>>
>>>>>>>>> +enum amdgpu_ucode_required {
>>>>>>>>> +    AMDGPU_UCODE_NOT_REQUIRED,
>>>>>>>>> +    AMDGPU_UCODE_REQUIRED,
>>>>>>>>
>>>>>>>> Couldn't this be handled in another API instead of having to flag every
>>>>>>>> load? By default, every ucode is required and if optional may be skipped
>>>>>>>> with amdgpu_ucode_request_optional() API?
>>>>>>>>
>>>>>>>
>>>>>>> I guess this would be a smaller patch, but 6 eggs one hand, half dozen
>>>>>>> in the other?
>>>>>>>
>>>>>>
>>>>>> I thought only ISP and gpu_info (no longer there for newer SOCs) fall
>>>>>> into the optional ones so far. The usage is rare, similar to the
>>>>>> nowarn() API usage.
>>>>>>
>>>>>> Also, as far as I know, the cap microcode is a must whenever used. That
>>>>>> is not optional.
>>>>>>
>>>>>
>>>>> The cap firmware is definitely optional.  Some customers use it, some don't.
>>>>>
>>>>
>>>> I thought optional is something that can be ignored even if FW is not
>>>> found and then driver load proceeds.
>>>>
>>>> What is the expected driver action if we classify cap firmware as
>>>> optional and then it fails on a customer system that expects it?
>>>
>>> I guess if the customer expects it, they can make sure it's there.
>>
>> I don't think customer really can do that without any diagnostic message
>> from the driver. Driver has to show the right message. If it passes that
>> silently and fails at some other point, it could be a totally different
>> signature.
> 
> yeah, I haven't seen any bug reports about the cap firmware so the
> current behavior seems to be fine.
> 

In this case, need to have a info level message when a firmware
classified as optional is not found. As it is only during driver load, I
don't think that message will be an annoyance. On the other hand, it
gives useful info if it runs into trouble at a later point during load.

Thanks,
Lijo

> Alex
> 
>>
>>> I'm not sure how you can have both without it being optional.  For
>>> customers that don't use it, requiring it would break them if it
>>> wasn't present.
>>>
>>
>> It's working so far. Having all is better as long as loading that is
>> harmless.
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>
>>>>> Alex
>>>>>
>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> Alex - what's your take?
>>>>>>
>>>>
>>

