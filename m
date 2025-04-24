Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D3EC369D5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Apr 2025 20:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD41910E0B6;
	Thu, 24 Apr 2025 20:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYxQYf6F";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5E510E0E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Apr 2025 20:55:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfJZ0YJFChuNxaZmoJ2n6gVAPqj4ejUfRBTtJ6BnpY1M5jRERikjAb5i4iH6ZoNeMB1mg+OLKr/qA7cb/gZwBd0PbzzBIpN271+q07R17gCH5LFH1Z5jLQ3YjG6Dwhv1dt9xJxsHSCDOsmG7NpRbnxGnJ6maP0lwTjBFSu+wN6Z0/hiQBJnCUJzBmqr120ZfhTsLY+Chr2Xe8DeUlUI6G0HbtBrlLBlx4EaSK7Y93Cr6az25dkPllYg7dXL6ZWjMaBipDe5TEsBd/lYWfD9xpfIdOQOTZEdY+7ZZOfGPM08uhkpeHBnlnyUsMdW9ppOLrmxhr/kXpmVpkSe0poCuMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rc+WNo6pkqiTKuvN86AA93mzjXn4jw6BQaXjb/LP89k=;
 b=wuimjcbEfr/Vo1bxLz1qqTXijogSPAB51BS4mnkWrgTzuMaXsQFTkuREo3B3iQgzA2ekVVwPUJ5afCG7+wcmr1n0hlbhBgZYvWsrnX1Pw1H9a//4dc3gY7iF2OK3L2fiVB2oq4TVkkUhjIZH0ltZgnv4QLTH5LRsaOVKjb23gdEoOh19WFjGYfUJRYOfQG1xvpnpqtDCd3IgrgjoDfV8VYrXy2zi3HzyZ7s8GMyoDxTlYWDBR7/1Fu8bsA3rVWjzh9lk6AxLloDuNuibTtp1vt1yug+QXECW5sfJ6iIhHvV+ARPYETaFjfw1VgvB59OMAo+yTQ4V6o5qr6F8JrcmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rc+WNo6pkqiTKuvN86AA93mzjXn4jw6BQaXjb/LP89k=;
 b=aYxQYf6FOhsZlVXuKUvU4cT2tOOWeiHrtgH5d5W1e6tlG9+W80QlYQAUDE89V4Zo7wbrA1ecd6zcl5sTSP1I3GPqpZiM1sLKIb3igsObCFVOpk4120aIu6cI7C5EyLHSSMX8U9BFs5425+56o57SnLyOXVdbFFaKuC9j4/yaexc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DM4PR12MB7670.namprd12.prod.outlook.com (2603:10b6:8:105::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Thu, 24 Apr 2025 20:55:22 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%5]) with mapi id 15.20.8678.023; Thu, 24 Apr 2025
 20:55:22 +0000
Message-ID: <06d1de70-0b70-449e-b199-79fc245b2899@amd.com>
Date: Thu, 24 Apr 2025 15:55:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add pasid debugfs entries
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20250424200432.214419-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20250424200432.214419-1-jinhuieric.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0090.namprd12.prod.outlook.com
 (2603:10b6:802:21::25) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DM4PR12MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ea80ed-6c9f-40f3-d47a-08dd83725415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnMzRlhkUS9nWXpUeGtyT3c2LzRmSWdjckVRaHN3MS9UbHFLQStOMHFkQUp4?=
 =?utf-8?B?elkvMXNlRU45dFIwaVZGZ0JyRHlMdHNTTDdLRmw5MGhjZEYyUXVURExydG5z?=
 =?utf-8?B?dG5MN1dJeEZlQ29wTGRVQmhnS3VzU05Ya0hjODNHVFFqbThEYWUzTmNjSHp4?=
 =?utf-8?B?QzhyY2xKMzUyaWdjTEZkNS8xQ2lKK0MwNlEvOC84TWovdU5BdUNYL1dxM0g0?=
 =?utf-8?B?d2l2TTlqMkNLWnlCWlkvYVZ6eFFXUkk0QVpHTkdhSmxDZ2pZOGg4TVFXemlU?=
 =?utf-8?B?a1IyY1hXWDhjclRDazZIRVF1dGI3b2Y5ZFZvaU1nNlpGaGVEaTNackpLOW5D?=
 =?utf-8?B?OW9WbHpBazlFVS9IS3FydXBvWlk4TU9ObmdwejQ5bHp2aDluemRNdEUwSVFF?=
 =?utf-8?B?OExMdTJMNDFDZ0crR0dBKzVHMzdHbDJVdUI2YnJqcGVxSlA2aGVNTzhTR1VU?=
 =?utf-8?B?QXhLQTQvdjB4ei9STUN4bnhaUEtUV2dyb1NyTTUzc0RHUTNRMStSLzNsZzg3?=
 =?utf-8?B?TG5ybnNPS040Ukd4eUFDZUg1OUh4OEY4a3BPNEhIUDcwaGJDcERLUXBTKzVM?=
 =?utf-8?B?Wm1UZytkMmY0YlQ0QnIrc3FBVVh5Tk5HbnZhR0xBRWRaWDJad0Y5SnJWeEt5?=
 =?utf-8?B?bU93YTFEaVcxb2kvTXBVUEp6bzNqb0hJN0g5RTNUaGVDWU1hQWEwR3VOb3NE?=
 =?utf-8?B?K2xGRUNuNmY2MFhiWWh4T2JxMUhUSkZwMktNUUYzT2JZa0ZLbndVVVczbEpE?=
 =?utf-8?B?UHk4Wkg3SmJkbTZsZXlpcVdaaG9ja3VJUTJVbHRycEZuYXNXazRqODJPVWwx?=
 =?utf-8?B?bzdPcGx6UHc5OFZ5WjZLL2s0Ynd2SDJYanRhNVBTSE43eThUSzU3RUZVQVBB?=
 =?utf-8?B?WWI4SnU1MHA3Yko0U2dHK3p2L0hyR29Sd2tqYTZNcytDREoyNXpMblAwQUN4?=
 =?utf-8?B?YXJEditlaU9OQ211U3EvemloWGszUnB2VWkvTXpHL3p1OUFVb2lMMWs0RVdK?=
 =?utf-8?B?WHJSTWZIVzdKUnNVSCtBaTBJa2Q2S09qQld4czRxTTlEOE9VSVJUc1B0OVI1?=
 =?utf-8?B?MXVZVUl4ZTNGQlVpdFdqYVpRSGFVWlBGUHFBd0IxdVVGZ1hOczk1alZqNTZn?=
 =?utf-8?B?ZEkwbGNjL0l6YVcxaXhaRTJwNmVTL1F5UFhXemduYjRPcjF1Vzd3dlpnK0p2?=
 =?utf-8?B?dGlGU2R3WmorVE1sOG1Ea2FYOTYvV1hlMEYvUVRxdk5pdyszdkZGR29Ub1FU?=
 =?utf-8?B?NkJlTlJaN3RFT2ZKQjZwaG1pSmMrSlp3Qms2ejVjTUFSYUpQdGtnV2VKcTJV?=
 =?utf-8?B?TXNOZDk0SjdZSXVXS2w2NXgrSDhaUWR6S0hFOFFYeE9BTm5LZDJRN3UxdEJt?=
 =?utf-8?B?WFIvSVNkVlY3ZERvZUszN0NqdEVFOVpwVHJlNkdrdzlacUZGcGE2dFloNThq?=
 =?utf-8?B?UmVDbzZGZ1p1OUdJMXgwT2hTbzBSU2hYNXZjVUdoSWgwZVNUaDJPbmpGNlJB?=
 =?utf-8?B?VlFHcGdPTVJnTUtFUHcxOXdESkxseVhCSE9qd09hZEk2SmY3bHNzSk12REtE?=
 =?utf-8?B?UCttSE1nOTc3bEZEYnorQU1CTDFlOGY1SHBINE9URFY3cW1RYTE3bWhRSVlp?=
 =?utf-8?B?SVZscWFNVFlQWlM0dCt2VktqUTRCdjRsdFBvWk5tM2l4MmxRSUFnOEZZdDha?=
 =?utf-8?B?eUc2UlZJaTBES3pvcjhEZDF6eFRYM2N0TFg5aS9BaGNBT3BUanF3ZTd4Vm8r?=
 =?utf-8?B?VXJEbXhaUzFCR1hVV1l5UkRsK3hIaGY5RnY5eXhCVWhjWTVTak1EUHdUcjlX?=
 =?utf-8?B?RnFpdno1eXk0bWZJN1ZiekcvSHFnZjl5SzJGS2RyZjZYYm1icHAxSEd1MlI5?=
 =?utf-8?B?WnJhYnp6d3VkRE1Wd0JJc1kzTWs1L1I3bzc3TGtnQWNRc1N6UWl3cXdqMGpD?=
 =?utf-8?Q?2sqw8UWco+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUV0NUVrbzRoR1ZqOTlrQ3VwMXIxK2kyL1FqNjJwaTd6WUhjQm5CMHhKUVUr?=
 =?utf-8?B?Z0hwdzUwRk1YUmQ3WXBEbHhrdkpTSFVZZE95a283Y01VQlRETGNVcUxwRTFS?=
 =?utf-8?B?eHc1K2F5Nkp5TWx5Q1JaUXRkblFzQXhvUUdKNjdISUx1NUJJeFBXbUJVc2pW?=
 =?utf-8?B?UCtjNkxqaUloZk5XQmNUbUI3c1U3WlVXR1h6WWVZRUNabERGM1lFZVAwNm5C?=
 =?utf-8?B?NklFcVhYSGpWKzBUQ0NEZWY4TW1MdkdOMkl2a0xiU01JRmRKNGxUazVhRkdY?=
 =?utf-8?B?OEsxdklzeTFGZXlQbXdWK0I5U0kxVFBrOTlDeXVrVlhDNE9lUGdtcjFyd0Vl?=
 =?utf-8?B?bFdFb2RkMlRBNUxCRVR1RGJET1diQUdlYjZhR3NuRmJ0TEZ2ZERkU2t6UGVP?=
 =?utf-8?B?M2pEK2lRVXVFaWxoMmY3ZXozTWNXY2o4dmJsTS9xTnV6empIV2Y0dk94V3k1?=
 =?utf-8?B?bEgzZ2wvOFJpOVc1Uk9rWUdmWXBuT0VuNXhPeTNrL1o5RHJHSUd6RkRnK1BK?=
 =?utf-8?B?QkRlT1plOXYrTEdSbzJqTnVmbDB6UEtDVXc1TDN3Tk9xeE1XS2RRUWVBUDVE?=
 =?utf-8?B?T3ltbkNsam1nS1BSVHVNdWlQMXVhWEpIbWdCZGFmQjRTZVMrcEx1R3g0N1ZV?=
 =?utf-8?B?eHpycU5iNHVWZlVQWDNyYlR6blVMMEw4dFZ4cW5xSElBSzJZRDc5Z1hYM25L?=
 =?utf-8?B?cVlndHU5UVNoTCs4VUgrVk1KMHd0d3dQUllaL3B1WVZMTkY3QTBUcytDNTNO?=
 =?utf-8?B?QkZIeVk4bVNvSTFycnNIREN3K0RIMnpKQzBSQStQeGRDNGZrQjEwTmNaRzN2?=
 =?utf-8?B?TUpQaE0vM1haZjlLaHBmTURiSTNZVkx2c0NibE9tWmgxckpJOGFaVzkxTmxS?=
 =?utf-8?B?eVBIQ0NWUVZhcjV0RUZSZGE3RWVYcHZWWmM2T2xtVTZGcVV5MldkbmxkQlNF?=
 =?utf-8?B?NmtzYzdQYjhoc0NuWlB3OHh6QURhaVErbUxJVzNDNVJUeFduYndCUjhIR0Nh?=
 =?utf-8?B?U1NuV2J6eDRaemV4VnEvYXpsY2lEbGFSQ0ZEZDZNYjdTNElTSzcvU2FZUWt4?=
 =?utf-8?B?djk1V1l0WWpxanVjYWtydERTd0Q2bGJzaXVBTGxvdXRhYjhlV3c5VWJtbHdQ?=
 =?utf-8?B?eWhtWDA1TlFQSTd5Z1FhRExQZWNjS2tvTzlTd0dRaHJUeXBEYWIzTnpobCtU?=
 =?utf-8?B?WThqZzhjZWFMQUd1bHlTZzlSeE5yYURrWWZCVUJsZDBLdzZJYk9Uc1Z6Q0hR?=
 =?utf-8?B?ZGNwVm9JRnJteWEydkhYQXdHb2FJbkFsZ2V3R25UUUJUYnF3b0Fnakx6YkdK?=
 =?utf-8?B?OG9Ic3lybHd6ZzFTekxHZ2dlbUgwekxmbitKUFZxa2FBUlpKdjE2TG1sek5P?=
 =?utf-8?B?WVAwWStGa3haendzS3lJMCsrVDNEMjVpamJQTnFRVzhFMEtMSXJ6dEpnRXUv?=
 =?utf-8?B?SzN1WTRTanRIYXp2dDkxaVR6czVpTVcwL2hUWkUvbnZqdVVnN2xFMHZOcVg3?=
 =?utf-8?B?WVdUZjBxWmdTbEQ1YnlvdERybG9kTjZGWEhUcVVtaXBUOEx6S3lpbmJOTUQ4?=
 =?utf-8?B?ZDlzZVZpVXpDNXZqZEtLbklHWDdvUWNaN3l0QmNUY2Y5MnhTUDRmbGdhS2xw?=
 =?utf-8?B?YW1JYVBTcUprSVo4S0MrQmtOWXVCTzBWVk4vMUtwMVJqa2VadUs3amRTS21l?=
 =?utf-8?B?Rmt4L3RQSWpLRVJkc0VjWDNYdmZaN0oxMURrSDBhZ3pXRHJoOTFkSXBsRThk?=
 =?utf-8?B?OUVONndQQ2R2eU02NEsvbnJ2WjZRbzlHZlBDZHoyT1NlMHF3eDVmdzVCbWlm?=
 =?utf-8?B?eDM2S3ZVTjFhNk90N2FBWUlrSUY4a0g3c3haTitUQmRoc2ZSNWl4V0Y4cXZs?=
 =?utf-8?B?MG5SUTMvU2NaN25iNXZYYjBuNVJVUmNuR0l2K3JITUNZNFoya2hLem04MDR6?=
 =?utf-8?B?emJ1T3NIZVVQemo3WE9WVC85Z1lhclZQNytGYmViYk1tSURaYTNwMWxueFBw?=
 =?utf-8?B?bkxXOThaWnRKUWJ4eklqTmFTQzZvSlZuSjVzbXpkeVNtVUVGaVhobWRJbkVR?=
 =?utf-8?B?ZmxEbkI2TjlnQ0o4bUYzOVQ3U0tOc3lxT0hMUTBOdzYvZS9BMUVSc09BVE9Q?=
 =?utf-8?Q?9KEM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ea80ed-6c9f-40f3-d47a-08dd83725415
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 20:55:21.8505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKcYojAbIW74KwlgCj+gmAOm8i9B66TXEXtOMQJNU6VPaLqIla+WGuxbK55TQUt/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7670
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


On 4/24/2025 3:04 PM, Eric Huang wrote:
> the entries will be appearing at
> /sys/kernel/debug/kfd/proc/<pid>/pasid_<gpuid>.

why need move pasid from sysfs to debugfs? debugfs is not always 
available and does not hide pasid from users either.

Regards

Xiaogang

>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 77 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  5 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  3 +
>   3 files changed, 85 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> index 4a5a0a4e00f2..14ab770fb877 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -27,6 +27,16 @@
>   #include "kfd_priv.h"
>   
>   static struct dentry *debugfs_root;
> +static struct dentry *debugfs_proc;
> +static struct list_head procs;
> +
> +struct debugfs_proc_entry {
> +	struct list_head list;
> +	struct dentry *proc_dentry;
> +	pid_t pid;
> +};
> +
> +#define MAX_DEBUGFS_FILENAME_LEN 32
>   
>   static int kfd_debugfs_open(struct inode *inode, struct file *file)
>   {
> @@ -92,6 +102,8 @@ static const struct file_operations kfd_debugfs_hang_hws_fops = {
>   void kfd_debugfs_init(void)
>   {
>   	debugfs_root = debugfs_create_dir("kfd", NULL);
> +	debugfs_proc = debugfs_create_dir("proc", debugfs_root);
> +	INIT_LIST_HEAD(&procs);
>   
>   	debugfs_create_file("mqds", S_IFREG | 0444, debugfs_root,
>   			    kfd_debugfs_mqds_by_process, &kfd_debugfs_fops);
> @@ -107,5 +119,70 @@ void kfd_debugfs_init(void)
>   
>   void kfd_debugfs_fini(void)
>   {
> +	debugfs_remove_recursive(debugfs_proc);
>   	debugfs_remove_recursive(debugfs_root);
>   }
> +
> +static ssize_t kfd_debugfs_pasid_read(struct file *file, char __user *buf,
> +				      size_t count, loff_t *ppos)
> +{
> +    struct kfd_process_device *pdd = file_inode(file)->i_private;
> +    char tmp[32];
> +    int len;
> +
> +    len = snprintf(tmp, sizeof(tmp), "%u\n", pdd->pasid);
> +
> +    return simple_read_from_buffer(buf, count, ppos, tmp, len);
> +}
> +
> +static const struct file_operations kfd_debugfs_pasid_fops = {
> +    .owner = THIS_MODULE,
> +    .read = kfd_debugfs_pasid_read,
> +};
> +
> +void kfd_debugfs_add_process(struct kfd_process *p)
> +{
> +	int i;
> +	char name[MAX_DEBUGFS_FILENAME_LEN];
> +	struct debugfs_proc_entry *entry;
> +
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return;
> +
> +	list_add(&entry->list, &procs);
> +	entry->pid = p->lead_thread->pid;
> +	snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "%d",
> +		 (int)entry->pid);
> +	entry->proc_dentry = debugfs_create_dir(name, debugfs_proc);
> +
> +	/* Create debugfs files for each GPU:
> +	 * - proc/<pid>/pasid_<gpuid>
> +	 */
> +	for (i = 0; i < p->n_pdds; i++) {
> +		struct kfd_process_device *pdd = p->pdds[i];
> +
> +		snprintf(name, MAX_DEBUGFS_FILENAME_LEN, "pasid_%u",
> +			 pdd->dev->id);
> +		debugfs_create_file((const char *)name, S_IFREG | 0444,
> +				    entry->proc_dentry,
> +				    pdd,
> +				    &kfd_debugfs_pasid_fops);
> +	}
> +}
> +
> +void kfd_debugfs_remove_process(struct kfd_process *p)
> +{
> +	struct debugfs_proc_entry *entry, *next;
> +
> +	mutex_lock(&kfd_processes_mutex);
> +	list_for_each_entry_safe(entry, next, &procs, list) {
> +		if (entry->pid != p->lead_thread->pid)
> +			continue;
> +
> +		debugfs_remove_recursive(entry->proc_dentry);
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
> +	mutex_unlock(&kfd_processes_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f6aedf69c644..0ae794539bb0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1581,10 +1581,15 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev);
>   int pm_debugfs_hang_hws(struct packet_manager *pm);
>   int dqm_debugfs_hang_hws(struct device_queue_manager *dqm);
>   
> +void kfd_debugfs_add_process(struct kfd_process *p);
> +void kfd_debugfs_remove_process(struct kfd_process *p);
> +
>   #else
>   
>   static inline void kfd_debugfs_init(void) {}
>   static inline void kfd_debugfs_fini(void) {}
> +static inline void kfd_debugfs_add_process(struct kfd_process *p) {}
> +static inline void kfd_debugfs_remove_process(struct kfd_process *p) {}
>   
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 41d7dc8c2850..722ac1662bdc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -900,6 +900,8 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>   		kfd_procfs_add_sysfs_files(process);
>   		kfd_procfs_add_sysfs_counters(process);
>   
> +		kfd_debugfs_add_process(process);
> +
>   		init_waitqueue_head(&process->wait_irq_drain);
>   	}
>   out:
> @@ -1176,6 +1178,7 @@ static void kfd_process_wq_release(struct work_struct *work)
>   		dma_fence_signal(ef);
>   
>   	kfd_process_remove_sysfs(p);
> +	kfd_debugfs_remove_process(p);
>   
>   	kfd_process_kunmap_signal_bo(p);
>   	kfd_process_free_outstanding_kfd_bos(p);
