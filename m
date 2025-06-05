Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F2EC5B543
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 13:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EC7910E9B6;
	Thu,  5 Jun 2025 13:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fB0HJsdv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17DC210E9BE
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 13:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IGndN1bkQf6ovalBQUydv7rMwHXhH/GfrcDR9f+pt0O/lKvHUR4Vn1YEXraJcU+PpM3kpeF9cejHoMnGuWNYMrYD7MXtoWDpNWgDz7VSyqotsHc4f8J8tQOSCTbKnvBpvO6vv+BbFrBRezfnLfWrHHsjZcZ67o2BvlOqToR4eONDSUuMTm3dqsDgQsk8mDczFyIMuEhiIEpYZHVdRm0kaTaqqp/w+X3PW0DpfhEBGsBs87HwQxhQMPIBz2eEJ4nfqpfQIurEdSbq3mPkDDsan3/LN6zxVCPQpq8Lo1pAFh8mCgVwE3afDSTH5bDWEtsCpL/veQKUButIk01CeapRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhIurKhC0RceWHMl15Z1baHd9UxjxnY2YniL11/fptA=;
 b=eU8IkvriTYyoo+ea3/nOiFfZRCM6ltgLL1Daq7m0rCKo4JJpBuVm0D8hGcBi6sVKBhmn9OouoZ86HpmiTv1UFzXkQTx86F23zjNhy8aOHMlQ5bdFH45w7rVJ5PaC59eUroLvlhTrDiWS/jstoRgm7rJ3RiSstAHAmjvRjcNhmx8r2BuyHqxaD8bKOXO6Rxp+us2/rvZQQqiZxFpKsr9NVkbf1SrD985Ttv4OwBn1hh11avq6M3pqMbGojUPR/01RBKABRHQnLcHOJ6MMyQfwgkb1G2O/XOuB4iZci7T9NtJMldGQUB317h5q3DNfq20GJFzrSLTZSsJMA0gcEbygXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhIurKhC0RceWHMl15Z1baHd9UxjxnY2YniL11/fptA=;
 b=fB0HJsdv3ZHJnRZ8THVvCANZyn20LNdE49nN6n/F4YRdw5hsgCpPS/xiKr4/072DVRu4MqlvtC5ZjNtOxcSFarGGhwui9q0HW+NTiT297FIsjs0utrweRKz8temui/CxX74FV9MWQXQgfBSvmsAV+i8g6Yt16mz8dLvLTrXYI6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 13:50:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Thu, 5 Jun 2025
 13:50:18 +0000
Message-ID: <b6163e9d-f23f-4742-b684-d613dfa03ffb@amd.com>
Date: Thu, 5 Jun 2025 15:50:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/31] drm/amdgpu: track ring state associated with a job
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250605014602.5915-1-alexander.deucher@amd.com>
 <20250605014602.5915-9-alexander.deucher@amd.com>
 <85f49273-1525-4504-9fc2-e06cefd96b98@amd.com>
 <CADnq5_NqXpm1edeNeFEyGfDyKK52b-PqEpsiS4BS-2dUL7s5bA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_NqXpm1edeNeFEyGfDyKK52b-PqEpsiS4BS-2dUL7s5bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:208:e8::23) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 3618547c-97b6-4e10-06a1-08dda437e839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlFKbWNQTFc4ajZsNXRmVFk0bFY3cmhxQ0NzbE5MZXFCdUtKSzBZd2JLRFg1?=
 =?utf-8?B?TlhCbnBRV0ZmRmNNWjlUNjFvQ1RPSno5UVpGU0pRYW5TVDR4WEU0V293cDl0?=
 =?utf-8?B?cElhMWtyL21tb0dpYi95UW03V3YreFVVUktBUVhrV0JVUklmM0tESDZpSFRT?=
 =?utf-8?B?ZktXdk1qKzBRREtDMXQ2UW4wYVZsenhqZkdzeldNSWpJYzluUDk4NGwzS3I1?=
 =?utf-8?B?bE5lQUVBdEQzL0Q2KzdYbWthUTQ3T1MyUXhSdXpHc0ovV2V0cUUyRWMvbnJs?=
 =?utf-8?B?bUpjL1d2UHRPVC83MzZOKzFSZEM0dFRmY1ZiK0VzNzlxVTd4M3B1bjJMZ0l1?=
 =?utf-8?B?WVpPRmZRbE5oeDFteTdrWW5pcVlRNnNUZkdVZERSVVhIQ2ljZ2pJbjJUVEkv?=
 =?utf-8?B?WVNKWnAyeUR0VzhZZ2NucnV1K3VibkR6SFJleUFQNUZPRnF5UkF3NGlNVVV4?=
 =?utf-8?B?QmVhODFuOWRHSVRrSElEdDltTThMTENyWVFQL09icXZpc3p0c1dqZC9ZZ2dP?=
 =?utf-8?B?R1JSK3NFS1Z3ZzJxOERIYmFLcVR6NXdjVWNlT0pScmZibWVRRlU1UW5UMFdh?=
 =?utf-8?B?eERKS3ZzemJKbUhETzA4blJBWUhqajdISC9Nc01EUnk1K0VrSTJONHVCNDgx?=
 =?utf-8?B?VkR1Q3JGM2F6RSs5MnRmZFJMT0ZIekxzVkNnZWN1eWgvSUNBS0krRDdYcFZT?=
 =?utf-8?B?TGF0d05PcmcyQ1ExNkZwN2JsT3QrTWNkOWRXTGJqQWIvcFJjMDNiTmlka0cz?=
 =?utf-8?B?SVQvVnJqMmxFVDRCR2JYQ2ZYeVRSY1IxclJoN2U4czMzVnFZdGwxSldyZU9D?=
 =?utf-8?B?Q3dFaDNMY25Uc0pCRXVYSGJEVkpKRFIxMzBuanlnZUd4QUI4WTdHYVVCWU03?=
 =?utf-8?B?NHFaNVdXbTlFZnhPbmJzK3FaWkl2ZEVhU0o1Tms2d1JUd0YxOXVOSHAycEV4?=
 =?utf-8?B?ZDFxSG00bVo4ZE9IK1MrSVAzMzNqdG5Sdy8wN2lTRG04UHRBTnNqOWxYZUlF?=
 =?utf-8?B?b2xUUVZ2L0FxVjJhN1NjQ2NlTE5sNFZwSW4rU1UwZTNFdTd1eWQwWjhOK01z?=
 =?utf-8?B?VkZXNytaSGpSQ0VjSys1VmVmWDNKa211QzZCUEIvNTQ5ZmUxWDM3aFFQZEJq?=
 =?utf-8?B?QXVrMTZ1ckt3ZnR2bDhkR2w4VFB6Z084aWJ0Tm1oNFhVSWxHb0dIeVNjcktM?=
 =?utf-8?B?SlMrN0laUjNjZVRHak05b0UrQ2hJZURTQmZvRGdyQUFBbEF5UVVVV3kzRGdY?=
 =?utf-8?B?bzZKMURZekxQMm53VmxYNGxqS3Y4VWxpVTc2K2J4a1drZFdRMXNQV3U5dU0y?=
 =?utf-8?B?N0xHM3huTTVYWkVEbmZMWkpzVDFma3A1cUtseXgxcEN5Ni9MaDdxQUM5T3FP?=
 =?utf-8?B?SXJsUUlDb3FGbURyN0N2cnBOaWxtQmlEaHhwaUswblVxV25TOWVLMnpaWHd2?=
 =?utf-8?B?RFh3eEEyK3NIaUo5bXQva3k1bFJvYWt4WW1tekdjSnV2VkUybDNVM1dRcWxI?=
 =?utf-8?B?T3g2YkozNzRUQTNLY2JhQnlaYmVNVkRWaTRUMHVOc1lpOTlHM1FOWGVlZ0Mx?=
 =?utf-8?B?ckdUSU5Ca3lheHhaZ3JVYjRHeldNNC9ZeDF2b255R3BBMVdiUjlvVThEZUUw?=
 =?utf-8?B?YmpuaStSTFYrT09lRFFMd2dpU2hxTlIxVTdtTVJ6Sm1adjFXaUNFMXFRWUxv?=
 =?utf-8?B?cTlYY0RCQTFiRVpHaVlOcXg3ZUI1SWZUazU2Tm4zU0lMVlNqVmQ5MWV6UVhQ?=
 =?utf-8?B?cmFHM3ZQNVV1dFFBdHZoSEkzS2JRdm9XdGJGcGt0KzVnZUxUd2dRZmV2T05X?=
 =?utf-8?B?RFJtYTJLUUVVOEdSek9hcTVEaEplbmRpTVBHN1NHZTVsY2lvK1d5YXJrYWxR?=
 =?utf-8?B?THRMMnlPVTd2ZnBYSFJjUDQwbytQYjBsZUlDVXEzeTdCeG51UXFTMWFES1Ux?=
 =?utf-8?Q?0IbyQ88Y9SM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjhuY3NLT0ZaR3JMeXU3N2h1K3E5MDRQRHlaaVZtM09YZjBkVDVjajI0T29m?=
 =?utf-8?B?MTBlaTgxSGsrMGgxb1V5a2w3M3RLTFZTb2RnbDRjM21Zc1MzMUlrVVhtWmFo?=
 =?utf-8?B?dEdpUHZUMVZJMzdvNVU3em9SZTV3bjMra2ZYU2poK1UvRDF5Y0MralhQM0Vp?=
 =?utf-8?B?a21FTFQ2YjVpRFh5VkJOOUd1L2RVa3hpbms4SGZ5c0tYeXZCMlFWaXR5NDll?=
 =?utf-8?B?N3lheWl2bzJTcFZOUkVxa05YbkZNYXRzWWE0NlE2TkkzU0x3VlQ1SXRXbTAw?=
 =?utf-8?B?M1BFK2IvR09nNVp5TXFwU1hxT1RIK0xMbUtMYkpSRjI4Y1FCcFNYdGlpd0FZ?=
 =?utf-8?B?UGdzdmpMTEZ4dS8rTzJLK3JpS21FMzlwTzB6d3IvNk9FWVNGK3lIQXdGZ1ZQ?=
 =?utf-8?B?ay9zb0licmxFN0VyQVRlODdSZ2Y2MkRoR1JYOVFQeWQ0RDB6cmV6OU9DZVZz?=
 =?utf-8?B?ZGxZM1pZSDdJOStHMDdvNG1pYmh4TUxVUHoreG9wU2hYRUFsU1FsYVVIU20r?=
 =?utf-8?B?eGorRXVZbERVYjRtTFluSlZlRENJSWw3ZnJvRFRtd2hhaWw4eVY1NjFMMUl3?=
 =?utf-8?B?NU5HYUM5QVp4NUxOUEF5WVQySVZIUUY4Q2l2TzNsM3BWclBReWZDMGNHNGJE?=
 =?utf-8?B?KzgwUWxZMHFhQ3RMeWREN1p0RmpBNFQ0c2FpUGhvZE5tYmg3OFVMK0Y4UFZP?=
 =?utf-8?B?SkdLNWhVRmRhcjVwU2dtYmhiV1RyeGMwSFl5R3ljL0hpbmdPQVUvL2Y1NzJZ?=
 =?utf-8?B?NFNlMlZPUDhYcWZiOVlTK0t3TnZCcVp0Z0FNb1Z3aXAxT0RrbWVmT1ZjOFdX?=
 =?utf-8?B?bXpXcXBKYkU4WnJ3bXhva0JzdVQzblZDdDFjQmMrUllYSkQyakFXazJrUVBy?=
 =?utf-8?B?WDBka1p5QzZ4ZnNPNFNFVWJRcE5RN3hxTFM1QS8yZ0FScE80cFhoQTVyUWJw?=
 =?utf-8?B?YVpKcG4xUkhaNnpCWGt3R3R0cG9SaDcrcC9VZEtYT2F5VG9kMXBaaGNDaWhX?=
 =?utf-8?B?WmsvUG0yMXFXSmw1VEthQ1VjWEc4UW5JRzA3WTJBQ0NTbXVSK3BxT2VQRTd2?=
 =?utf-8?B?RHhKQW1WUnV5b1B5cTkwWC84VHNCSkdoYXB4ZUVWMWV5V2J4R1lvbVJBOElm?=
 =?utf-8?B?b3NSSHZPK0tqV2xxTHdQWkJkd3EvQmpZdWp6UHNTSkZsempMVkxDbkxNWWp6?=
 =?utf-8?B?alh1OXBBY3JwdmViRnlKRXFwNWg0Z3lJQTNwR3ljSzAxMmo5U2JrcFE3YlFK?=
 =?utf-8?B?NHBNNlR3SzRvb0hETjNmVnpFelVRYkk1ZmhwYzNmcUp1Z3VCY1RMdTZpTEds?=
 =?utf-8?B?VGFoTHFtbS9yOVV0STViZGE2ZitSL0U1clZZbWZGcXZ5d1A4eHE4T3ByNG14?=
 =?utf-8?B?M0RZWHJnc2YvcVVneWpGYy91aU5GcVRaZm51TVozL2FYd1FRS1BLZWNlb1Js?=
 =?utf-8?B?b2V3WVBqZEZXMXNUYXJTOWs2ZDNJUmZsTnlIblU4cXRmcXBZUlBQVmVndVZp?=
 =?utf-8?B?N2RkOCthb0ZuMDduVGlUckNEaHZhNzBDOSthVVg5Y2FRU0ZiY0hHQjd6dG1N?=
 =?utf-8?B?SnhtQ25jc21UQzBGL0owSmtiSUZwYmYydHZUcjNENEEvNjVCQU9SbnZDdU5M?=
 =?utf-8?B?bVRTNzA2c1hBekNMYkFrUk1Ec3d0eUtmSlR0d2JDTjc4VWZsNCsxSnRZa0U1?=
 =?utf-8?B?TXhoa2NJamNQMVRkV1JTbU5HTlhXM3FJQ1pRZ1ZPWitNWFdabldzMGk0Qjlr?=
 =?utf-8?B?WnBtRUtuMktoY1d6VVYvQUc0KzVOMG5NNkw4VjdCK0VQc2hqMHBsWWRMV0NZ?=
 =?utf-8?B?ckxrQjBXQy9oL1Zuakx3SGROUzlkajF0cTdFTGtzUVNKUC9acm5PcGQxRnE3?=
 =?utf-8?B?eHhhempoRVVWRFhObWlwamFIRkRPS3RPWGI5ak5aTEpnRVdJR09YeWxXei9j?=
 =?utf-8?B?czYzYzBjbjdVT25wUE1yOGdlT3VCemU2Uy9kcGtHViswWFVBVHFpdEtUcE1v?=
 =?utf-8?B?QnVlcEY4b1hvNUMxVm1vbll6V0pBMTJzWnhhSS85S0t5THkrOVRNbFQzSUhX?=
 =?utf-8?B?QXlXeW5hK0JqTllsYjk3VXdaNmw0eXByYjVVUGY4ekMyMWI1cDFSQ0F3QlVR?=
 =?utf-8?Q?BnMn7XjAWh1UnCvosvCvqrdSO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3618547c-97b6-4e10-06a1-08dda437e839
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:50:18.4116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+qYSKGEqD3iOirXkf6Bwoc4V04gs3XZetsvyGB2OsB8s4kH3/J0TTiuXuXGoP1s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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

On 6/5/25 15:21, Alex Deucher wrote:
>>> +     am_fence->start_ring_wptr = 0;
>>> +     am_fence->end_ring_wptr = 0;
>>
>> Why do we need the start here? I would just keep the end around and then jump from fence to fence while re-submitting them.
> 
> I need to know the start and end of the ring contents associated with
> each fence.  When I re-emit, I just copy over the ring contents for
> all fences that don't match the bad one.  Also we submit multiple
> fences per IB depending on whether we do a vm flush.  Those fences are
> internal to the IB frame so they don't really need a start and end,
> hence 0.


What I wanted to do is the following:

ptr = bad_fence->wend_ring_wptr;
for (i = (bad_fence->seq + 1) & fence_drv->mask; i != bad_fence_seq; ++i &= fence_drv->mask)
	fence = fence_drv->fences[i]
	if (dma_fence_is_signaled(fence))
		break;

	if (!fence->end_ring_wptr)
		continue;

	if (fence->context != bad_fence->context)
		backup(ptr, fence->end_ring_wptr);

	ptr = fence->end_ring_wptr;
}

But could be that it is better to backup start/end explicitly.

>>> +void amdgpu_fence_driver_seq_force_completion(struct amdgpu_ring *ring, u32 seq)
>>
>> Better give the full fence structure here.
> 
> You mean pass the fence directly?

Yes.

> 
>>
>>> +{
>>> +     amdgpu_fence_write(ring, seq);
>>> +     amdgpu_fence_process(ring);
>>> +}
>>> +
>>>  /*
>>>   * Common fence implementation
>>>   */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 802743efa3b39..636941697a740 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -126,7 +126,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>                      struct dma_fence **f)
>>>  {
>>>       struct amdgpu_device *adev = ring->adev;
>>> +     u64 start_ring_wptr, end_ring_wptr;
>>>       struct amdgpu_ib *ib = &ibs[0];
>>> +     struct amdgpu_fence *am_fence;
>>>       struct dma_fence *tmp = NULL;
>>>       bool need_ctx_switch;
>>>       struct amdgpu_vm *vm;
>>> @@ -138,7 +140,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>       int vmid = AMDGPU_JOB_GET_VMID(job);
>>>       bool need_pipe_sync = false;
>>>       unsigned int cond_exec;
>>> -
>>>       unsigned int i;
>>>       int r = 0;
>>>
>>> @@ -187,6 +188,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>               dev_err(adev->dev, "scheduling IB failed (%d).\n", r);
>>>               return r;
>>>       }
>>> +     start_ring_wptr = ring->wptr;
>>>
>>>       need_ctx_switch = ring->current_ctx != fence_ctx;
>>>       if (ring->funcs->emit_pipeline_sync && job &&
>>> @@ -306,6 +308,15 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>
>>>       amdgpu_ring_ib_end(ring);
>>>       amdgpu_ring_commit(ring);
>>> +     /* This must be last for resets to work properly
>>> +      * as we need to save the wptr associated with this
>>> +      * fence.
>>> +      */
>>> +     end_ring_wptr = ring->wptr;
>>> +     am_fence = container_of(*f, struct amdgpu_fence, base);
>>> +     am_fence->start_ring_wptr = start_ring_wptr;
>>> +     am_fence->end_ring_wptr = end_ring_wptr;
>>
>> The end_ring_wptr variable is superflous and I would put assigning that into a helper in amdgpu_fence.c
> 
> I'm not following. I need the start and end wptrs in order to know
> what ranges of the ring I need to save.

But you have 
	end_ring_wptr = ring->wptr;
...
	am_fence->end_ring_wptr = end_ring_wptr;

start_ring_wptr is available as ring->wptr_old btw.

>>> +void amdgpu_ring_backup_unprocessed_jobs(struct amdgpu_ring *ring,
>>> +                                      bool is_guilty,
>>> +                                      struct amdgpu_fence *bad_fence)
>>> +{
>>> +     struct amdgpu_fence *fence;
>>> +     struct dma_fence *old, **ptr;
>>> +     int i;
>>> +
>>> +     ring->ring_backup_entries_to_copy = 0;
>>> +     for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>>
>> That is the wrong order for the fences, you need to start/end at the last submitted one.
> 
> I'm not sure I follow.  When I backup the ring contents, I need to go
> from oldest to newest so the order is correct when I re-emit.

Yeah, but 0 is not the oldest. fence_drv->fences is a ring buffer!

You need to start with something like fence_drv->fences[bad_fence->seq & mask].

Christian.

> 
> Alex
