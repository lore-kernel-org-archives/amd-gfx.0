Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D527EE4981
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 09:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CCF10E978;
	Wed, 11 Sep 2024 09:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SjFG9r2S";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D7210E978
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 09:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXi7lcFWD4bR4vqHjRE+suiGOwAayfbUmY+cBuIfp6RvFhcHeWonJObHZXJpriFGECc9MERl3YD6acVUcorACBqal90RV1DbMXiKVRrYcjc1TWAsp1nVi7T9ftaFO4KNoK/2bqKMQxBbLQmO/ZcoB+HjWFar/0nrDQ9r6C5i+CoMt+ifY9yIuUSNl3WONEN6praPrWaiqBHW0KYv9SEuXqp5iilVKBlOKVxVkKnQ8mpU+Nq6j5YWdi6E06UFilni/S02NxmBCPN00s0UXQKtAhGwyG5nKzlEk3eqjj5duzDCnhP3zSgEh3NqFWhsrvQxCx2NfO9vJTwtapqzom/SDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6HyF0HvzgMc21XTYXW9yBWZztxfRZDe3406Kzo8mgY=;
 b=A5HA1zKbHU+mpRSFBNV+s2EOtAsj7hKvxoEXxCrgLbBJjy9mjrJ8l8QwHdD5yIsdCO7jOZWzD05ZG5QHTKLTE9BZ68HATbqRx22dbf1Dos5QvwRzsvMmk0LPAY7ZMsrHOqyAhUnGNIfZgnYGXVBGBZXz9wSd20ndEEcl5vpKNf5KtmFIhcQhfhPD9di7hqSIzqEnoktc8vIYIWplH0cDT8ivU3GuFuzEm/e3cm/mLsV+WhLDZzBw5xZvmJUp0aIFxmKkE2NfGWlnibwVAjBMTF1O3xp7WXegmj5q/st/WSM/PxpdtoAXkFHl6PpK38dhY8VSjKNxS73DFWETPq9R5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6HyF0HvzgMc21XTYXW9yBWZztxfRZDe3406Kzo8mgY=;
 b=SjFG9r2SwYx9Jq2aO2/z3UZPMPIsHxqGE0qM/NYqVBMQjw/FuTPfKcM2PTqAAeebveMlai6moAvUJRv1blwLnvDK/x36mceYi6rxXSTHi5A3n1N2NrGJYSZnpC6hzAh66UbRc4UYrutNg4n133iMGu+ai0QXo3rJehgLJA8laQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 11 Sep
 2024 09:20:22 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%4]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 09:20:22 +0000
Message-ID: <055a83bb-897c-4fdd-ac46-177980b4a95e@amd.com>
Date: Wed, 11 Sep 2024 11:20:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 27/28] Revert "drm/amdgpu/gfx11: only enable CP GFX
 shadowing on SR-IOV"
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Shashank Sharma <contactshashanksharma@gmail.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-23-shashank.sharma@amd.com>
 <CADnq5_Pwkn8SnJ75KsPQHTE4RhWtdP0=bQZD0u6HZSLXuMthEA@mail.gmail.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_Pwkn8SnJ75KsPQHTE4RhWtdP0=bQZD0u6HZSLXuMthEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: cfceded3-1a91-4d9b-4335-08dcd242f687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUx4WC9ndHcvemVKanFUWmdGSVZoaWtIb25ONGdxeUx2ZGZGakNBQXVNME1Z?=
 =?utf-8?B?WVlBUGZsRVdQNWV6Zi9rdmljd2ZpZzdweUNCYkxRaHg1Mm8wbktFVHpuOUE5?=
 =?utf-8?B?OUZubjNUckxmWG1YZjh4Z3NNKzVETEdqbVI2Y203ck91c25KM1VuT1MrZWRm?=
 =?utf-8?B?a3haRmN1cUQ2SHA1RlhCVUFnZExQMHVaNU5zQUhyOGdDL3NUNklYT0FTUzFu?=
 =?utf-8?B?VmNFSlE5UU1hUlhlbXo1cVArcEVQbG1SbFVIbEdOWllnTjlZaUFoazZLenJE?=
 =?utf-8?B?b094UXFoSkFZYkhjOXdKRWZiUyswNHhCejhiblRaTDhWamM1QzgzL1FvOVNF?=
 =?utf-8?B?YkVIM1paNUFiRzEwV2lVYUpYMXQ5dU5lQUVILzloTFRtb3g2TFJYOHZkVFll?=
 =?utf-8?B?TG5qSDdyaUlNWlBMSFRrclk1Myt1QU0xNUNuSGg1UU5aQWRxbVRuVUhEcnNF?=
 =?utf-8?B?YUMySy9qWHkrSnJybVU0Q3JPcVNLTDJkZGhZUlFwYmZyTUhUYUREUEpaUlVF?=
 =?utf-8?B?MTlHc2NZd2tMUlgzYU4wQ1l5U2pZUWZSM1NKaC9Vd0lKam01S1YzYTdUUkVk?=
 =?utf-8?B?M2JjNjRLNlRodVhvTEFFdDNRUmtqVFoxZUdjNnBXREgzRzQ1MmRiTUxwa29z?=
 =?utf-8?B?SEtaWVBtd0tFczVYN3h6ckRHVmZzVGdTa3pVSlY1MEtlQjVBdEdsSEFxSm10?=
 =?utf-8?B?UEU5dE9kM0xTNndHQWJGRERIa25yZ0ZsNlYvK1pKUGJwQkdmS1ZNV09IQTlL?=
 =?utf-8?B?TEhLS1hiUDhuUktWNU9ITVkvRUdnTkQwWm0zUFJ1WVdDQjVEc2l5Wnl0Q1Uw?=
 =?utf-8?B?WjhPb3lBTnBjblBTZ2FENWV1bSs4OVloLzFRRnpNcW5nSzdLUjl4RUJjVjhp?=
 =?utf-8?B?TU5IdEZWQzZ6aUs5UXBPa3BCTXRVc2p6emxaM05ITFVQaVNFS21sVDVOUmVI?=
 =?utf-8?B?cU9ZaUwyeHFPYTVaZGU0Tlk4MjBrK0l5K2cxYTFrNUduUEkzOTVmajB0VE5h?=
 =?utf-8?B?dU9Yd2plRGE2bStITWQvNFd2RUNZeUw2ZElCbUlHUTRXZDR2K0xuZXRVMzZE?=
 =?utf-8?B?eDZ3R1ZObkRJY2JuTU5sVFEwNTJpbnZpSlJVNiszZnhFTEVsRXNmZisrdDdB?=
 =?utf-8?B?YmFkQlErQ2RUMkNJaTR0MHg5VnY1dmVPS1M3V2hPenNKclBkYTZiTGt5bUxB?=
 =?utf-8?B?ekJlZ2xsQUoyUm4rNnoyOWNUWWNDbW8yYkVWOXZFYnBqUnZoSHF6VEhtQTMz?=
 =?utf-8?B?bk5xMHNzMUJCZ0VnR0I2TkdKYVZieHp6ZWRROElwcGZCQTgwTkorcTRuUnZS?=
 =?utf-8?B?MnQ0Q2c3V2hCeU5BVms2c0pBbXVBeFdYakRFc2ZHQWtWUmtxUEFVZVBkbUhY?=
 =?utf-8?B?YzQ0bDlmMGVDUXNMYVJoUXBGc2p4UHJNQTF6OXF5RFVqdkY3NWhsZ0FmMHZ6?=
 =?utf-8?B?WGZTTmVTdUdZM0lZNkdNamtVVmUveWh2VE56RTg3TDF0OERRVjJRa09zdlN6?=
 =?utf-8?B?THlwbnh5UFgxZmhDamlFN3RxNFJtaWovVUR2NzhmQmhuS3o0b08xZU5uOWU4?=
 =?utf-8?B?T21LNmVRWFlaK2tLWnZJamNoL2lWcmRFaTB5MGYzUVJzK0J3MDJ2dm5KQ2ZT?=
 =?utf-8?B?dkVCVEVLZmlmSUY4RDNYYXg2VktFM0dWNkpMeXNFbStnbU1aOW5adndVeSt4?=
 =?utf-8?B?ZEpqWkp3Qit0cUJyRmNzUkpORGZFTnVEeXQ0TVB3VlNUZjg5M1FIaTFoZG1a?=
 =?utf-8?B?QXpxcHFzRENoNkNUam5BSTBpOHRCdnVsRjJRRGJKai9WWXU5ZXpBZjVkL0My?=
 =?utf-8?B?RFFMYW03UUg1eTk3SFhGdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzR2bldLc0xjUTJaU3F5ZlptVmNKNkwrU0JzTEVZTzRRTmF6RzRvQ2NqUXQ1?=
 =?utf-8?B?VER6MnhMMkpGeE1hdkIrTzdOMjlIalBKZWRYc1FZQU5Od01ZaUpWWkV6R1NL?=
 =?utf-8?B?d1B0WjYvZ0VHemFvcXVTa2tkbWpJei9KYWlUVytHb3pxQTNEbHNqN2tRVE9a?=
 =?utf-8?B?YkFHU1dsanJJQ0FSQi9QSk1hUlRpejBTQ1BLRTE2T1VIczUxb1phckU2VVdo?=
 =?utf-8?B?ZlZpOGRkRytxQ2tCMjJXdjFSVS9wbzQ1MEVEZ2hldENSQjl5amp2TXJNMmdM?=
 =?utf-8?B?RTdRZHZCLzdTMlRVS29LZ0RLZE0zdHhvNFFSOEhMMTZVVERYZ2s3YjFuTmpN?=
 =?utf-8?B?UWZZdjYzS2wzWGdBSklqUE5vYTVwOFdzenU2Z08vZS9YRkN3Y0FkL3dLZ0t0?=
 =?utf-8?B?QlhsR01TNUVQbUY3bGxGYk8weUZyVDZpZkFJNkpOQUhaYk0rR283TEhtMWxo?=
 =?utf-8?B?bXRuNWVua2pxRHpOYWczRlVEWlJOZEduM2dnbnVISUpyQTN2UzVXWXg4b3FK?=
 =?utf-8?B?TFlWZzNDT09NSnF6UWpHZ2N1ZmUvRVUycmhlaVVUa1lRMDZmbmpTQWZMSGxn?=
 =?utf-8?B?QUxxcnFMUkk3bWdnWjVablhWOFIvVkJRSklTdFZRTmpKUmI0bFRNRllZQ21W?=
 =?utf-8?B?VysyNW14RWZOSlRtUkF6OS94bGNlaEZiNnowN2hWbWlHckg0dXI1TmlLQUtq?=
 =?utf-8?B?Vkw2RDR4YUVhdXFITE0wdWk5QnV4UFN4TWtRTzBXVzFFTHk2WFdVaTBBWUlV?=
 =?utf-8?B?L2FpdVpBVG5jZ2FWVGFZRXZBbElUZU95UnM1bWhIQ2h5SW5ydXhlZWpWSW9B?=
 =?utf-8?B?azMrYmRqUmkvdWlySkt1Yzc4QXVsQ1JvKzBIRmZ2VVhvMFZhRFNoK0tFdmp1?=
 =?utf-8?B?UWhwaXE2TFNxS0FMVmJncUk1OHJEWVpOYnZJK2xLcHVYV2M2d2RBOVRFRm55?=
 =?utf-8?B?d0NZNWZzMzVJdUpVUmdkeXR6QTJDVGk4Snhwc1RRWFptVlBSdFBuUjBkOXdt?=
 =?utf-8?B?LzlFd2RwRTdwemErWmFVKzBkY3FhZ1ZreVFVMmlTOHZDa1FScSt0Q0FHZkFa?=
 =?utf-8?B?NXR2NHV6SFQyb0ZKRlFVSUd0eTAvWXZkY1J1RXdWdytpN09qNXYxZVdrS0Vh?=
 =?utf-8?B?OWNVS1pDTi9XdEtmejkrb0dtK2JQWi9UM1EvbVZ2WTdra1RNeVdXS1haM2tS?=
 =?utf-8?B?eDJVOTgzbzd3ajZRR1pnOXZQWk8yYWtKVHpaL0tLTkJnWlUvcGpJeGJsSnFJ?=
 =?utf-8?B?MVNmb1ZycnZva1l3M2NTa1UwdDNhbFZFYmp3ZnUrRThYK1FDTWs5V0VXa1lC?=
 =?utf-8?B?clREODI1Nmt1elJ3eXUzL0lmWFU2YWovWE1KZ0NQaUdzdXJBWlFaWU1zWVNn?=
 =?utf-8?B?bUVWKys0R1VhM1RZb1pIN3JBbE02ai90NXpkQ3RSTlVGUlpSZGwzbnhzdlZm?=
 =?utf-8?B?YkNrMjM2dFVqNG1ETzhqT012Z2pCUGN5cWZXd2hsblZvTGg1RkM5cHBDUDNs?=
 =?utf-8?B?cVJZTVBXZ21PenhJNmVMbEI3QW16NjRrams3cXFkN0RrRDNneFBNQTRjZVpm?=
 =?utf-8?B?MXh4d0pDTzBVTDgvT3RpU05ueGVncUJjeGR5Ukx0ZGJLV1ZXZG1FOFBLZnFU?=
 =?utf-8?B?VVVNVEVjcEgzMXQ2TTFHV2I1cVIxVWJINnJIejVCTEJTemEzczhVSEdZNGt1?=
 =?utf-8?B?V2l4SG1uVERadSt6S3BwMGtnVk9WWno1RXRvQWVVOWRIMWdlaUF5dXMvNlRa?=
 =?utf-8?B?WWpZUk5oc0R2bllZSlhVdlpDam9lNVRjRkR5M3dnVTU0ZEFEaWxvczZYVlFh?=
 =?utf-8?B?ZzNPaUJNNkJiSSswdGNmSDhwZHNBbHVNRCtSNmhTdjFRK1duTXozRWhuYklj?=
 =?utf-8?B?NVgyMHcvVnEzQTNLK1EzRW1PSnd0Yk1ucnF1L1M2eEtCbXJ2WldCK2ZkQnpE?=
 =?utf-8?B?MzlEem5OeTFHZDRURXppYWQvUDZmd1ZnNW1GMzdQWC8xYkFqRytkVmMza1ZR?=
 =?utf-8?B?OWxrSXdZdmNrcmxSeExzcGdwdkc1UG42eTJTWG84V0pLbFpzNkdWOHlvdGdl?=
 =?utf-8?B?UU5TSURxdGhWcC9KSGVkNldUN3Y1ZitIdHZ3Zmp5SjdmOW5vTk9HbDByYWFp?=
 =?utf-8?Q?Mnk+dSvU3vk39Q6iPgIq7JVhA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfceded3-1a91-4d9b-4335-08dcd242f687
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:20:22.8162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqSxLOfmetvCXqkoH+BERFbieSS+TVMs7H5o2V65Qua+erev2B/rUFJ4S8i2PI56eybF1o0KJEYK8MLiVRHMlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789
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

Hello Alex

On 09/09/2024 22:31, Alex Deucher wrote:
> On Mon, Sep 9, 2024 at 4:18 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This reverts commit 81af32520e7aaa337fe132f16c12ce54170187ea.
>>
>> This commit prevents a usermode queue client to get the shadow related
>> information.
>>
>> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index dbf3bcadee32..1f0f7ec0facc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -661,12 +661,8 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
>>          case IP_VERSION(11, 0, 3):
>>                  if ((adev->gfx.me_fw_version >= 1505) &&
>>                      (adev->gfx.pfp_fw_version >= 1600) &&
>> -                   (adev->gfx.mec_fw_version >= 512)) {
>> -                       if (amdgpu_sriov_vf(adev))
>> -                               adev->gfx.cp_gfx_shadow = true;
>> -                       else
>> -                               adev->gfx.cp_gfx_shadow = false;
>> -               }
>> +                   (adev->gfx.mec_fw_version >= 512))
>> +                       adev->gfx.cp_gfx_shadow = true;
> We need to be a bit more surgical about this.  Setting
> adev->gfx.cp_gfx_shadow = true, will also enable
> gfx_v11_0_ring_emit_gfx_shadow() to execute on kernel queues which we
> don't want.  We just want to enable the query for the shadow and csa
> sizes.  Probably easiest to just add a new INFO IOCTL query for that
> so we don't break the old query.  I.e., userspace looks for non-0
> shadow and csa sizes to determine whether or not to enable shadowing
> with kernel queues.

I agree, I will fine tune this approach instead of reverting the patch.

Shashank

> Alex
>
>>                  break;
>>          default:
>>                  adev->gfx.cp_gfx_shadow = false;
>> --
>> 2.45.1
>>
