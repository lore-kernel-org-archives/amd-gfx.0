Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD11C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 17:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57B3310EA21;
	Thu,  6 Mar 2025 17:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nUsB0PwJ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44F0A10EA21
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 17:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkMT07u1WCjfyqcb8dX3HwDVKQoDUIbzsAJhZUftqXa7mb/9ggkwDo0daMTkS77G9UDrVNrq/J8nHSWmg0omWqhITYAeFIsLpY7QrA5fckBcdIfcD6sbZ4cFzv6FjbILzBLCYclzPiVrhnsV9oYZHK2smTBTnkl46d8fWMHUfssbEKwaN3X6Oef3xFWceFcmdAEg16qShPkHnvCtwwOZ3rR6l39c1i5gZ315O4MBTVD/o9/r0iTCjm+bqCPV3Igs737JjxFphpUm2234Jcny0b5nRuTzvM5QApnM+3fg6i3FNKQOmH6JRXYBApXeJZeuem/pMQrJEH/NIdqEtgNjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZniLodZA7wbbTwqwUaHrY+REmqM8qyYGAFBdteo87M=;
 b=Ku3BHcwXeoC8p6q6K/AILmKZFcXoNYK/pKHu+k6zrope+5VRqCtLeGzpA8JKzornWw3nAGWwGr3Wyavi+H3cYcGgot/Zm1h3xirBcQfDK/4/wf+6a3kAGm1nyUzvRNJLZZK19Wav1k5Dz1kbcwUYIAKoSZrayReSa0xhdgeSnpxqxPYSZmCJ7E43yY8o8BrotVpdIXs+40QcgkGGE2jWG3JctChU1BEcyOuCYmUj1quZGwLFBSEEScNJ4WbhDoCAxShFk6RA61IzF++3+KFKg6slDRwKuZ3cOMd/OyZTeofQ8V3igN3ICJmp2MKeHl9giVrIkhEIcOwZ8Xqpx57mdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZniLodZA7wbbTwqwUaHrY+REmqM8qyYGAFBdteo87M=;
 b=nUsB0PwJ0K1en1zuaPKE0xhZ6jqEKavdoJ6S6JElR94wOhwXdkT3G75zieGelJZcf9AnQqZVtX04sYD6lSWAW6d4xScYn9dNQH1v31HeNWCTLnWlneiQ5nKwAMSUaAzkSvDiXFwDCvrddDDAjKKljWi+8emg43/USuOZeJJ9g3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 17:00:48 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%4]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 17:00:47 +0000
Content-Type: multipart/alternative;
 boundary="------------3nbD4aonlz0NAsxvR0i435Hj"
Message-ID: <b6c5ca92-b76e-4565-b96b-eaea9c6296f6@amd.com>
Date: Thu, 6 Mar 2025 11:00:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Fix the race condition for draining retry
 fault
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250306060309.3222693-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250306060309.3222693-1-Emily.Deng@amd.com>
X-ClientProxiedBy: SA9PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:806:24::23) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2d61b6-212f-4b05-702d-08dd5cd0710e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFZjNHRxMlBjTkJiQlJEemlIa0VpWnFsMHhpL1lObmU5eVdFMk9kTDNlQXJ2?=
 =?utf-8?B?RFMrVnRDUi9sWkhjQmlveUtLNmd2VVdacjRrN0c5bllqTmhZU0FERXVZaGhW?=
 =?utf-8?B?emI4TVp5RXRsOWozSk5ic3dPcUtCK09ETHdUakp0cmtLZS9uQnh4RnNoSTBp?=
 =?utf-8?B?MWwvSWM3dElsZjZkQkNjYzJYa2hvVEIwZVhYME9SYmpJK1NuMldWUUcvRmFG?=
 =?utf-8?B?T1FrU3J2RzRaQ05VTUdVLzlmYzhNYWtzcWZkdWpDWUVqZ3IxVTN3N0FxMHZn?=
 =?utf-8?B?QlJkUHhnZlErV3hzVXhqYjR0WW94KzJ1Mk5FRExOM3k1NFU1TFcyUEZhT2NS?=
 =?utf-8?B?eTdHWE4wSm1MQk9pcWJGa2NMZ1ZKOHBOS0Y2MEdzb1ZWNFQvMEUyUk96UjZx?=
 =?utf-8?B?Y2FLRkZ3QWxPdm5RV3dTTTEyYktjSzNWeXVndzFTTG1VTTBnWUg1dnBQWXRj?=
 =?utf-8?B?MjNSMGpGQ0RPUVA4R1kyMzI4M1ZTeVhDU0lBdWJGVDRLb2MxaktBeUFrMUpi?=
 =?utf-8?B?RUlITmNtck45UTF3RE90MzNnalpGelJVUEpyb3gycjlWbTJrOGVZOFZ0VWRG?=
 =?utf-8?B?NnhoMHl0aXRGeVM3eHJzMVJtUWlmNjFOV25GaWQzVVJaS0Z1UkdlcXBpNnFn?=
 =?utf-8?B?K3JKQ2lHcDlqMmJYeWQvV2drSGpwN1dFOEc4MW5jMGZLMzNzOExZdDBhUHFm?=
 =?utf-8?B?MnpqVTNCc0NLSnRxQ3UwMjczbWRwTlhsaDV5eEwzSHhqTWJ4R2wwMGRrK041?=
 =?utf-8?B?dW53cGFQMS82V2ZjUThEWmozZ1ZrRk5zVG1FMTNoMStta2xqV0xsT24zUzdT?=
 =?utf-8?B?UW43alMxekxlVC93ZzdQcDd6QlF6R1E0Tk9PQldRVmhLbUxHTW1ONlBieUY0?=
 =?utf-8?B?UVFqQWV2VlNwc2N3aHBUNk9xaWpuSzd3a1BnNWFITWhBQWZVeEFPRXRhL0c1?=
 =?utf-8?B?YWdlK1lyakFjLzVQMXRLRmUwQ1dBcUQ2aHZETG16RXNnZ0lTenhBVk1zM0Ry?=
 =?utf-8?B?WXphQVJjTXloaVpETGRuVExkUjZPNFpGTXl2QVAyU3FBaXUzVE5ORkxNYU9s?=
 =?utf-8?B?VDdZSlVuUVJjeVl5OVUzZzlTbmttYVlrcEdjeEx1V05SWFNzc3psUjdQdlZn?=
 =?utf-8?B?NUkvdGlwb002QkErYXBYSTVnZUdjUmsvK1cyWXVNeWk0bzRzNEJuZXFGQ1g3?=
 =?utf-8?B?NHRuUklKYTcvWUNTSnkvRlFVYWxyVDd0WmxnR3dZMjRBLzhZZVhmRDRpeGs0?=
 =?utf-8?B?QVZycjhkMkxkYTFhK3QxdXdBMm1PcXNQQm9zYmhITmNzN0ZhUlR0ZUgyQ0tB?=
 =?utf-8?B?QnZtRDdMb2ZKNThxejlNalZjWDJWanE4Mkt2elgvNmJsNlhwQVN4OUQvTmd0?=
 =?utf-8?B?elhoSzFRZHJCeVhkYnAzUEpMNFJFQ3BBdlMxaTltZEh0b1R1R2g0SmROVXR3?=
 =?utf-8?B?R2FyRDJhd3ZXRlhYazBqdXRjTENzQndyY3FKemh2YlFBajJFNEZGTFA1Umpq?=
 =?utf-8?B?Y0JCNENtb0JhWEMvTnloYzhWNTgvT0JOeXIvRzlIaUV2S2xTMUxmYkVMci8z?=
 =?utf-8?B?VG56L0dNenFDS2VlVkJHR2sycFZPMWdhMzhUeVc0dWFzd0hwbUZzWjA1VS9m?=
 =?utf-8?B?czE4dW9OTE9BREJDRXZvZklnS3pGbGNWcDNUWk42Nll0aFNncTY0WTFNZm41?=
 =?utf-8?B?REhjQ2wzeHkyd0hPOHlCejBDa0JmOCtGYU5hT0hFSS8rVmRWc2VPUWxjYWNG?=
 =?utf-8?B?OWt0Q2ducURkSmZNRk81eHFzS28wYnlwYm1mZDRXR1M4SmNvZGZzZi9xZ0hO?=
 =?utf-8?B?ZDhJR01VSUlFRkttellrM1F2TWovclBIeHAvQzJRbWlnZHFxdERJMEUySG1o?=
 =?utf-8?Q?vkPP/fm9iZc5N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEp4TVlYR0k0MDRuR2dacHoyZTVESEZsdURpM3pGMFF3YkNwZVdrNHYxVkw5?=
 =?utf-8?B?cEtHeW5HL2p2NVdKVW82VUFqcEdvYlVDdnNhK2FvZFFOdzcvZ1FObGV3RzRN?=
 =?utf-8?B?U3JzN3NtdHU1TFgvQkcwcGNLSlZHdS8vWDNtcHdWVzFiMlluN21XK2RVV1NT?=
 =?utf-8?B?L3p6eWl4Q3dpM1BqZ0dmeW9MZ2NUNkhBb1pVaWQwRjVCTFlOLzNScmRVWHpD?=
 =?utf-8?B?RU83MXI1bkdzOGhwM3U1ZGM2SmZBVUg3emxPUmFncTBUdU5DWm80dlJsVEpr?=
 =?utf-8?B?NnJmTHl1T1NTRC92cFdMVGZmam5zZnZ1Q0thSTE1aHZ4ZHViNzNhUG5DN1JF?=
 =?utf-8?B?Tng3RHM1WVNuMW5oRmJIVUE2anVGWUJweGhHZ0FhWGowUzh0WXhoQjViSklF?=
 =?utf-8?B?Y0pnb1pLc0NNL0VrY1RnMkoyK1RPY0lReTRjRHBrMGVDUmNhR1lEbkhkaWdr?=
 =?utf-8?B?OTBHY1ZoSkhoTkRaK0xTblI0OWxpbE1YZTM0QitvWjZwQWcyalYveFlTSGQr?=
 =?utf-8?B?THFQQzhDWEJONVdxNHRtME03bTJabDdZUG0zcU1GemVCNW5oNlYrdnVKZGlp?=
 =?utf-8?B?MTRZQmVmZDRxcE9pQ3grUGlWMTlZOGMxNThFZkl0S0p5MDVyS3R3UW15RHZU?=
 =?utf-8?B?SWFXb1hqckROUkNxMks1OGczYnNxOEVHWWJYQUIxREoyL0ptdnBhM2RRN1My?=
 =?utf-8?B?Wmo5NStrOUtxc3Z6NkdsUTJla2FZTjdSaDh2dFA0NWp0RzB1ckUvMWRQeUM2?=
 =?utf-8?B?Zk5qMWM4QWRsMXJZN1Y3bERYT25zcmIva1hRZXpIMmxJYnNtWXJxbGNlSjJt?=
 =?utf-8?B?WFZiY3RHVUV1NUd6dHlPWDhiREF5NC9NOXRMcEZEUVVqRFRFeE0xOU1vdXRt?=
 =?utf-8?B?S1NiY3pkVVloTW1pYm5GbFZUWWpxc205dWF4SXZTSytWdVdEMUtxdEozZzQx?=
 =?utf-8?B?d1ZUQ044VmtMY09zRnRUWG1Qd2lSMHd1VEFHcE54MlpxU0dkVkdHcEE0aEI3?=
 =?utf-8?B?ZC9VUzRlSmJGTHM0Q3RBbHp5MnB3d0trMytUYjdtK1I2N3hZK3YxOWFwbFo2?=
 =?utf-8?B?NWlMQXkrbVEwbHBVaTNwVUFEUXBFOEVCbUErVDRYUzRFM0hwVEQyUHJ6cVFS?=
 =?utf-8?B?czduU01yRmhmMDdyVmI4bUFzUFlySFVBK0NQM0JJQmhLc0RRNUZZZGhrTEtK?=
 =?utf-8?B?ZG9oanJxSGUxeE1oa1p5L3gvSjhQUHNPcFZYZU4ybndySi9jMUFOV2gzZVU0?=
 =?utf-8?B?dExaTGlTTkQ1STA1Uk92cnZBYkgwWlZwZzkxNDJiOWt1R1R6TVBPOWJPeVVk?=
 =?utf-8?B?VURSNGMrOHpVTGc1SGRNS1pJK3R1QUNTMStadURBQVJWVEgzUXF0RFFnWU9L?=
 =?utf-8?B?MmxXYnlxcEF4azZCazEyTjYzRTE1OXJRR2ZVVVJoNGJjei91UFp2emJVWjUy?=
 =?utf-8?B?L2FBR0phMEp5cW5GaFRxWnhQbTkrVkFMWDk3OHJRYUpPaXBRdTZiZGhleVJ1?=
 =?utf-8?B?WXdPOU0rL2h1a3JiZ0RDUHVydHorbXJiY0QyS2xWcHUyRVR2NkxSWE1VLzhJ?=
 =?utf-8?B?aXJZY0lBRVFuMHZHRThMUExnUVZZV2NFMEZIL1V6Q3FSTVhSYUtnYzFvQUtj?=
 =?utf-8?B?a2R6Vy9ETnY2S2tOTno5TkZ2cDJRaDlrVHZqbjMrWWJSeGlFMGNpQjFBVzRR?=
 =?utf-8?B?MllMcFBsckRUR29nL2JCcXlVSCs1WmkxOEhnL1M2Yk5QZG9CZnJhQ0VaRC9G?=
 =?utf-8?B?QTBHNmpEdzlpSDVtbVVSclUzNVpVQUdkSWxrOXFvV1lNM0ZWQlhveFdBUmlT?=
 =?utf-8?B?OE1ab1gyNk0ySTFESUxhcXY2bDRiZUpwQXlEQTZ3Y2kxaDY0NEpJOFVhRUUz?=
 =?utf-8?B?T0NqQ0xCaTAxVVM1SXY5UW1EYWQ4eTNJZWZLd3liQVhCN2xWRFpUcmhEbVEz?=
 =?utf-8?B?dGg2Z0JiSHN4b1FJYWZJdVRML2Z0SzAzdDloTkN0ZEwzbXNPMVd1RDBqWDZr?=
 =?utf-8?B?U21FRXBEemZmMElqMDc3YlNWaHdXK0gyeDNabDB6TWFlM0dwUkdyNEhob0t2?=
 =?utf-8?B?anh1Mmttak03UitrSkdiMngzbXV6WWpVdjJJdFlvUEtoUEp2Vzl6MHFGcnpq?=
 =?utf-8?Q?KEo4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2d61b6-212f-4b05-702d-08dd5cd0710e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 17:00:47.8399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j496EB75SGBksu5OhDnF06D/MyGr2nnRkSaWNu4a9qfUCA2GnDAc6XOVJvFf9uee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
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

--------------3nbD4aonlz0NAsxvR0i435Hj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for catch up and fix this race condition. It looks good to me. 
One minor thing below:

On 3/6/2025 12:03 AM, Emily Deng wrote:
> Issue:
> In the scenario where svm_range_restore_pages is called, but svm->checkpoint_ts
>   has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
> is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
> continues execution and reaches svm_range_from_addr. This results in
> a "failed to find prange..." error, causing the page recovery to fail.
>
> How to fix:
> Move the timestamp check code under the protection of svm->lock.
>
> v2:
> Make sure all right locks are released before go out.
>
> v3:
> Directly goto out_unlock_svms, and return -EAGAIN.
>
> v4:
> Refine code.
>
> Signed-off-by: Emily Deng<Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index d04725583f19..83ac14bf7a7a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		goto out;
>   	}
>   
> -	/* check if this page fault time stamp is before svms->checkpoint_ts */
> -	if (svms->checkpoint_ts[gpuidx] != 0) {
> -		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> -			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> -			r = 0;
> -			goto out;
> -		} else
> -			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> -			 * to zero to avoid following ts wrap around give wrong comparing
> -			 */
> -			svms->checkpoint_ts[gpuidx] = 0;
> -	}
> -
>   	if (!p->xnack_enabled) {
>   		pr_debug("XNACK not enabled for pasid 0x%x\n", pasid);
>   		r = -EFAULT;
> @@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mmap_read_lock(mm);
>   retry_write_locked:
>   	mutex_lock(&svms->lock);
> +
> +	/* check if this page fault time stamp is before svms->checkpoint_ts */
> +	if (svms->checkpoint_ts[gpuidx] != 0) {
> +		if (amdgpu_ih_ts_after_or_equal(ts,  svms->checkpoint_ts[gpuidx])) {
> +			pr_debug("draining retry fault, drop fault 0x%llx\n", addr);
> +			r = -EAGAIN;

We drop page fault because it is stale, not mean to handle it again. if 
return -EAGAIN we do amdgpu_gmc_filter_faults_remove. If after unmap, 
user map same range again we should treat page fault happened at same 
range as new one.

Regards

Xiaogang

> +			goto out_unlock_svms;
> +		} else
> +			/* ts is after svms->checkpoint_ts now, reset svms->checkpoint_ts
> +			 * to zero to avoid following ts wrap around give wrong comparing
> +			 */
> +			svms->checkpoint_ts[gpuidx] = 0;
> +	}
> +
>   	prange = svm_range_from_addr(svms, addr, NULL);
>   	if (!prange) {
>   		pr_debug("failed to find prange svms 0x%p address [0x%llx]\n",
> @@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
>   
> -	svm_range_count_fault(node, p, gpuidx);
> +	if (r != -EAGAIN)
> +		svm_range_count_fault(node, p, gpuidx);
>   
>   	mmput(mm);
>   out:
--------------3nbD4aonlz0NAsxvR0i435Hj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Thanks for catch up and fix this race condition. It looks good to
      me. One minor thing below:<br>
    </p>
    <div class="moz-cite-prefix">On 3/6/2025 12:03 AM, Emily Deng wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250306060309.3222693-1-Emily.Deng@amd.com">
      <pre wrap="" class="moz-quote-pre">Issue:
In the scenario where svm_range_restore_pages is called, but svm-&gt;checkpoint_ts
 has not been set and the retry fault has not been drained, svm_range_unmap_from_cpu
is triggered and calls svm_range_free. Meanwhile, svm_range_restore_pages
continues execution and reaches svm_range_from_addr. This results in
a &quot;failed to find prange...&quot; error, causing the page recovery to fail.

How to fix:
Move the timestamp check code under the protection of svm-&gt;lock.

v2:
Make sure all right locks are released before go out.

v3:
Directly goto out_unlock_svms, and return -EAGAIN.

v4:
Refine code.

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 30 +++++++++++++++-------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d04725583f19..83ac14bf7a7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3008,19 +3008,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	/* check if this page fault time stamp is before svms-&gt;checkpoint_ts */
-	if (svms-&gt;checkpoint_ts[gpuidx] != 0) {
-		if (amdgpu_ih_ts_after_or_equal(ts,  svms-&gt;checkpoint_ts[gpuidx])) {
-			pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
-			r = 0;
-			goto out;
-		} else
-			/* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts
-			 * to zero to avoid following ts wrap around give wrong comparing
-			 */
-			svms-&gt;checkpoint_ts[gpuidx] = 0;
-	}
-
 	if (!p-&gt;xnack_enabled) {
 		pr_debug(&quot;XNACK not enabled for pasid 0x%x\n&quot;, pasid);
 		r = -EFAULT;
@@ -3040,6 +3027,20 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&amp;svms-&gt;lock);
+
+	/* check if this page fault time stamp is before svms-&gt;checkpoint_ts */
+	if (svms-&gt;checkpoint_ts[gpuidx] != 0) {
+		if (amdgpu_ih_ts_after_or_equal(ts,  svms-&gt;checkpoint_ts[gpuidx])) {
+			pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
+			r = -EAGAIN;</pre>
    </blockquote>
    <p>We drop page fault because it is stale, not mean to handle it
      again. if return <span style="white-space: pre-wrap">-EAGAIN</span>
      we do amdgpu_gmc_filter_faults_remove. If after unmap, user map
      same range again we should treat page fault happened at same range
      as new one.&nbsp;</p>
    <p>Regards</p>
    <p>Xiaogang<br>
    </p>
    <blockquote type="cite" cite="mid:20250306060309.3222693-1-Emily.Deng@amd.com">
      <pre wrap="" class="moz-quote-pre">
+			goto out_unlock_svms;
+		} else
+			/* ts is after svms-&gt;checkpoint_ts now, reset svms-&gt;checkpoint_ts
+			 * to zero to avoid following ts wrap around give wrong comparing
+			 */
+			svms-&gt;checkpoint_ts[gpuidx] = 0;
+	}
+
 	prange = svm_range_from_addr(svms, addr, NULL);
 	if (!prange) {
 		pr_debug(&quot;failed to find prange svms 0x%p address [0x%llx]\n&quot;,
@@ -3165,7 +3166,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	mutex_unlock(&amp;svms-&gt;lock);
 	mmap_read_unlock(mm);
 
-	svm_range_count_fault(node, p, gpuidx);
+	if (r != -EAGAIN)
+		svm_range_count_fault(node, p, gpuidx);
 
 	mmput(mm);
 out:
</pre>
    </blockquote>
  </body>
</html>

--------------3nbD4aonlz0NAsxvR0i435Hj--
