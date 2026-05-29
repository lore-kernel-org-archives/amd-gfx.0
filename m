Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F76CD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 18:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B80D01123C2;
	Fri, 29 May 2026 18:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bU6BrsYJ";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F031123C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 18:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/XQTSoq7cE2yi7hA1zEWoxXY0tNGQrC7w/P7mvUPcxNRxKrMBIzLfouUaXXFrXp+Z7grsLXJAAwinpdtjWR/xPt6umJQPbZ/Y0aO2pnf08AUz9WjCsXZsxeCMJbSZJB3wOxZacA/u872f0RGOJnX0LApknA1uZ8qrdH2XgK+jNmor/uQJSyc8H18GU8EsHXDKRSOsjB9fR+Hsj1HLYwDT197rjxSYAiRNZX+pbjb9mLxJf+NZI5SH23CNTgWqdVUMmG2GSngT2SB/uD4h2zQqua2qjUPt/G0K6KF8eeuRnj1XWl4Mmv5+8nU/nFkIk+8HLUaIeFZ4j3Izf/U1wgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aPu5NJhrwCCGdcJGz15tj4Jat29BfHrZNRebIS9dRk=;
 b=LHLyyruu3f1WSJucxs26RU3CO5FrTJE86bWc+HoYrS0pOfZro8MVBa05FRExP6LLR4c/s8t0fLeUqU5pcjTxeWlBechnrduDBgihohld4eRCts5p2QdRUdQbPOGs5zXNIO6NgasWGPawcQ6eo00i89VS/cH7MuDA/3/M79pRuHecGKqJArv44rRF9zx0CYImjmaatZdfUAPeWzWbG+hwVFXDQI8aLCTukOgd9iN/em+C9lTJsg7U1THPslHwjGpQPkgkb0LRj/4M2TrsOWQL4Bll2mQgv6KgzHsMx1nUVO+4IzHE1EqIxIi8h73e5YqTT+88VnUdstmNXt/WevXXtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aPu5NJhrwCCGdcJGz15tj4Jat29BfHrZNRebIS9dRk=;
 b=bU6BrsYJB37zy8XkRD1koTsUIUmVlzrEBGIgqXDpEOKe2NSoEA8mCp+rA0L2wOU43lgq1gf60PIVY7OVSDUi0zAaoeUAb0MGNEZaHuGDahsKFi1ZmCLFlv82IOvuhmRe2lmy+/A3/BL4MyJpGw+yqrkgBTi7excMjWY5t2eUxLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 18:35:04 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 18:35:04 +0000
Content-Type: multipart/alternative;
 boundary="------------iphHFqxhXdN2foDb0byplmb0"
Message-ID: <5296dedf-df7f-43ca-9987-6e314fd90073@amd.com>
Date: Fri, 29 May 2026 13:35:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
To: Honglei Huang <honghuan@amd.com>, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Vitaly.Prosyak@amd.com,
 Jenny-Jing.Liu@amd.com
References: <20260529073544.614561-1-honghuan@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260529073544.614561-1-honghuan@amd.com>
X-ClientProxiedBy: CH0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:610:11a::25) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f6daa97-a1f8-49eb-2fa1-08debdb10016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|11063799006|56012099006|18002099003|8096899003|22082099003;
X-Microsoft-Antispam-Message-Info: OfkFH5m3ikFRXIdwtyD2lrnDQhxjkFHOoxwkRc0qRZpFEjdEycS/wx4IuLtFjPmPmcFSgi6MiOdiZLbxHrtDQGzYsjfnaTvTWiv7q9TC2ry+hzyTKEfAAAsJ1oH3x/oEs3VwZAnzOJ2cw+PQ9UAGQImvZdFZ9uZskewA7uyoCYXmqD0YJMMSVLUCKp/pb7eeE19JK9VCcvGOXU2io3mxLNhCqS0ojZvI0x/Td0hlJtIqf0KPImdn56lUdFpjKed+Mipwl48sncMsdUnog9SrimJldlhM5VZFPB3eJkPLJ7kKGCcyjOXhOItFrT+lb/kWWe0c8zd8E88srS5MzZrzITEDOzkcTreseD7Jl7xY93wtniKnN9LphPvIYc0gniiduNDhXklTRgFcw2cTuQRCKEcVC8lFdTaE8VPYgi6+uRGvn4sq4sSOR/sOeXJWuNs9QySpU2mD+6aDou1Y0WASvkXXVtHbMbCVNpn/DGJUFu+ep/jD2P8EQRmbMl7tXOe6kIG1FbbWhEJkAbJeELpf7wjzbKEMYN8lktgPG9ffeim8JYL5p0mYzOBVtRjzrRP9uHeSbS7A+tIfhKc7z5bPgUtLbzOvGHSRkhh6Mfe/cj5uqkDv6n/kD+gxMJpJl1YbB3uE71Fzfh4hjtF3mHZETBmyrxO9R1EtB5DVwLcd3+ei1NxaDKHSDZ9RkGqT7j5f/PumXG/agd8FDEp9ZmeTGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(56012099006)(18002099003)(8096899003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekxnOG00cWx3YUh5M1c0UEJ6NFZ5UDUxNTBzRVRvd0FpcStDUTArT01XSld3?=
 =?utf-8?B?RWxwZlViVUs0WkdWSk0zbUNPQm1Tc2dQYUsvMVQ2Y1NQVmpsYVk0SlZhbkhV?=
 =?utf-8?B?WEFyY2h2RGMxbGJhcnJrTlFNbWcvbnZ3WWZ6WWRMQklDSjZYeDd0VjNlTTdi?=
 =?utf-8?B?bi9XRUdwczk0SWpIOTNJTGVPZDQ1L0pvZEpDS2FoT1JBM1FOTzREdTJBNGdJ?=
 =?utf-8?B?TytBSmNNeHI1Vlhqc3habXl3MkoxaFNTcGNaU2pSVWVHdUI2bmppSmVUYk9Z?=
 =?utf-8?B?WXhFMUtEY1QybE5iMHVXSWdqYXhFbVFjeUwrdC9xKzBXMG4rUVNOOWFLRUZj?=
 =?utf-8?B?S1RoM1FhQVY4UjVDTkdpUUFBV2djdkIxSjBENVdiY3MyWlZFR1JoQ0JMOHVr?=
 =?utf-8?B?ZDFNL3RCdU9BSUQwS01BU0dBcGNIc3BBd0g2OEl0alBwRnl5TjFya0VmNWtm?=
 =?utf-8?B?U3VjY2VNdHBrcmQybTlGOXJyY01JVkFPTTFRTWhKZ0svS24wdWRmbW1mOXRN?=
 =?utf-8?B?SFRJK0p2bEpqUllvWFJSc1VmSktrSVhLRjUydi9BSlZEaGp6ZFJia3oveGhB?=
 =?utf-8?B?QXBweDJpS3RmbXZJb1JndE42OEI0bnNoYTg2R3RDanZ1dHk4OEpuYmVWbUhw?=
 =?utf-8?B?SDlSOTZ3ckJTZkI3VVlnc2dnZTRYR1lUZWVYVzc1L2xMTnhaT1RUWGNBekQw?=
 =?utf-8?B?L1pLWEF3bTEvZDk4RVdDTlpPSkE4STVWVVFTa1NaZG5nd2JkeWRQZzcxWmxs?=
 =?utf-8?B?dnZLR09uQnVTM216WGxGVitoT0JvSk0wWkdyN1N4T0ZPbDFXU1dEbTVKUytv?=
 =?utf-8?B?bjNKb2hJU3QyaWdGY0s1RVdJd0pqMkZycTF0ZGxxY2hvU3BuWFpqOGFDQnpK?=
 =?utf-8?B?ZzV1aGQ1UUNBTkVmYzRqQVgxbnFoQUM4RUJMRXpudFRzMGl6UlpKK1JmZStt?=
 =?utf-8?B?UmlFcU5zcEI1M0s3OGt2L2ljZEFlaHZyU1dHSjJxaTZnNFl0ZmQrRWpiSloy?=
 =?utf-8?B?S05uNVNiSUtSZDd0bHFRRlZ4aXVGM0ZhWklqK3dvZzJVYzlXeFFGNmFuejZq?=
 =?utf-8?B?YkNPQnFmSXp2M1JLMzV6ZnRtL3VuT3NnUW9Sb2FSd1drcnBsN0ZPendVamFY?=
 =?utf-8?B?aGNuaHFFMkt6cjByZUwxSXhteE5UQmhvVmtLa2tQOTd4QytPdmFDSkdRdjRy?=
 =?utf-8?B?NXZyN1BKWWRQYUVPck9UdjFNMGRQNGV3Q0V4UnJqWG04ZkwrUDlxdWJVNzFO?=
 =?utf-8?B?ZWM3NDdTMEprNTZCelFDdEJrZlZDRDJjVHhCd2VtK0FSYVphdnB2Z1B6NEJO?=
 =?utf-8?B?VlpIaXhDRUVPUUZhWDRUeVVvUENZdGdoMitDRTR1NXZ5WEl5bEZuSFhxYTY4?=
 =?utf-8?B?RXdKdkxFR1MrallhcEUwSURORUQxdDlIcmQvekdHRU1VQ0JneTZEb281TmVZ?=
 =?utf-8?B?TGVsdVVhbFg0MGFwaktudlFYNjA4UnVTMXpvN08yY25qb0N3VFF2WDR1aDU0?=
 =?utf-8?B?SEF0YlBNclZabDgySW9BYTg2cnN6UnUrZUFnMFZsTWoyOU93TVFEL1g0UCtE?=
 =?utf-8?B?UnVvcEJ6MFdZUSs5NE9FREFwZFltYm05NTVuVFBYb0oyTm13Slo2aEw4ekJ2?=
 =?utf-8?B?WkZGdmhOMzV5OUNRU2ZnSmtYNm5OckVSdGVaN0JWUW1PNHYybXYwUHplTmhz?=
 =?utf-8?B?cFpyZC84L2FaQ1BvYkpHSEpua0RSYlRpSWhNQmV2T1RjSjl6SUNjSHpKVVFE?=
 =?utf-8?B?OWJBNGdrbFBrcUI0M3BBWG1NNlhsRklFais1emRjRW5xeGcrSU5SYnpGaVUy?=
 =?utf-8?B?c1JjU2l6bnNxeVB5ZVVSM2tzbEVqUS9NZHQrOXVsVExHQlRER2hCY2JQSUlB?=
 =?utf-8?B?Z256U0xLd1d0RElrb3VoL2hGQnJ6Wjc1WWUyOE5YUUQrZG5XczhzVG4yUGQ2?=
 =?utf-8?B?cGVuSFVweDhPZGJSbGp5WUp6NFVzK0g0OElZV0tQSGpFN3RVYzhCcFZvam00?=
 =?utf-8?B?ZEVBYUhvSFFHcG9nWFhTUlRqdW9GSERVYlBtejg3THM5bTd1ZXFXL29oc1M4?=
 =?utf-8?B?WWxLZWxUeHoxQmFWdHAxZFMwRTJlV0hJR3Z5TktFNEE5M0dSYUh1ZGhGeTlt?=
 =?utf-8?B?WXFCNklNaUh1U2pzNHlpM2ZSN1d6QktMZ2ZaMTBYdlVUajg3bk92OTZYTzNo?=
 =?utf-8?B?OGF6TlNqdHJ3U1RYK0srd3Y5U0VlaDZKNHVCdSthR1JWTDFpOXBuNGJaWE0r?=
 =?utf-8?B?SCtoWjBvV3BzZ1p4WTM2VUNmL2hLMDQybXNhOHJ3WVdzYnU4L1NSRHJQQXpX?=
 =?utf-8?Q?VCYpcYKi4MPNI37UIX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f6daa97-a1f8-49eb-2fa1-08debdb10016
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 18:35:04.4750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTEvMCGllEezUjM5dI4QlVYPNJKJ7rhESrKVS80BGxOvQ3BSmRyGwIAgbVOk4fdL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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

--------------iphHFqxhXdN2foDb0byplmb0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/29/2026 2:35 AM, Honglei Huang wrote:
> Since commit 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
> moved mmu_interval_read_begin() out of the per-chunk loop, the
> captured notifier_seq is no longer refreshed across retries. As a
> result, the existing -EBUSY retry path can never make progress:
"retry" should come with mmu_interval_read_begin. The commit 
144ba981783f move mmu_interval_read_begin out of loop, then "retry" 
should also be moved out loop with mmu_interval_read_begin.
>    hmm_range_fault() returns -EBUSY only when
>    mmu_interval_check_retry(notifier, notifier_seq) reports that the
>    sequence is stale. Once the sequence has advanced, the stored seq
>    will never match again, so every subsequent call within the same
>    invocation returns -EBUSY immediately.
>
> The "goto retry" therefore degenerates into a busy spin that simply
> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
> finally bailing out with -EAGAIN. This is pure latency with no chance
> of recovery, and it actively hurts the KFD userptr stack: the caller
> ends up blocked for a second while holding mmap_lock, only to return
> -EAGAIN to the restore worker (or to userspace) which would have
> re-driven the operation immediately anyway.
>
> Drop the retry/timeout entirely and let -EBUSY propagate straight to
> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
> handled at a higher level: the KFD restore_userptr_worker reschedules
> itself, and the userptr ioctl path returns -EAGAIN to userspace.
>
> No functional regression: the previous behaviour on -EBUSY was already
> to fail with -EAGAIN after a 1s stall; we just skip the stall.
>
> Reviewed-by: Christian König<christian.koenig@amd.com>
> Signed-off-by: Honglei Huang<honghuan@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 5d72878c8..229c30867 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   	const u64 max_bytes = SZ_2G;
>   
>   	struct hmm_range *hmm_range = &range->hmm_range;
> -	unsigned long timeout;
>   	unsigned long *pfns;
>   	unsigned long end;
>   	int r;
> @@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>   			hmm_range->start, hmm_range->end);
>   
> -		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
> -
> -retry:
If you remove "retry" here the callers including user space need to redo 
the thing. This function's work is memory validation. It should do that 
in its best before return to caller.

If user space is the caller there would be a lot of user space from/to 
kernel space context switches. That will make the procedure even slower.

I think we need keep "retry" inside this function, but move "retry" out 
of loop at mmu_interval_read_begin.

Regards
Xiaogang

>   		r = hmm_range_fault(hmm_range);
> -		if (unlikely(r)) {
> -			if (r == -EBUSY && !time_after(jiffies, timeout))
> -				goto retry;
> +		if (unlikely(r))
>   			goto out_free_pfns;
> -		}
>   
>   		if (hmm_range->end == end)
>   			break;
--------------iphHFqxhXdN2foDb0byplmb0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/29/2026 2:35 AM, Honglei Huang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260529073544.614561-1-honghuan@amd.com">
      <pre wrap="" class="moz-quote-pre">Since commit 144ba981783f (&quot;drm/amdgpu: fix amdgpu_hmm_range_get_pages&quot;)
moved mmu_interval_read_begin() out of the per-chunk loop, the
captured notifier_seq is no longer refreshed across retries. As a
result, the existing -EBUSY retry path can never make progress:
</pre>
    </blockquote>
    &quot;retry&quot; should come with mmu_interval_read_begin. The commit&nbsp;<span style="white-space: pre-wrap">144ba981783f </span>move&nbsp;<span style="white-space: pre-wrap">mmu_interval_read_begin  out of loop, then &quot;retry&quot; should also be moved out loop with mmu_interval_read_begin.</span>
    <blockquote type="cite" cite="mid:20260529073544.614561-1-honghuan@amd.com">
      <pre wrap="" class="moz-quote-pre">
  hmm_range_fault() returns -EBUSY only when
  mmu_interval_check_retry(notifier, notifier_seq) reports that the
  sequence is stale. Once the sequence has advanced, the stored seq
  will never match again, so every subsequent call within the same
  invocation returns -EBUSY immediately.

The &quot;goto retry&quot; therefore degenerates into a busy spin that simply
burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
finally bailing out with -EAGAIN. This is pure latency with no chance
of recovery, and it actively hurts the KFD userptr stack: the caller
ends up blocked for a second while holding mmap_lock, only to return
-EAGAIN to the restore worker (or to userspace) which would have
re-driven the operation immediately anyway.

Drop the retry/timeout entirely and let -EBUSY propagate straight to
out_free_pfns, where it is already translated to -EAGAIN. Recovery is
handled at a higher level: the KFD restore_userptr_worker reschedules
itself, and the userptr ioctl path returns -EAGAIN to userspace.

No functional regression: the previous behaviour on -EBUSY was already
to fail with -EAGAIN after a 1s stall; we just skip the stall.

Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Signed-off-by: Honglei Huang <a class="moz-txt-link-rfc2396E" href="mailto:honghuan@amd.com">&lt;honghuan@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 5d72878c8..229c30867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	const u64 max_bytes = SZ_2G;
 
 	struct hmm_range *hmm_range = &amp;range-&gt;hmm_range;
-	unsigned long timeout;
 	unsigned long *pfns;
 	unsigned long end;
 	int r;
@@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		pr_debug(&quot;hmm range: start = 0x%lx, end = 0x%lx&quot;,
 			hmm_range-&gt;start, hmm_range-&gt;end);
 
-		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-
-retry:</pre>
    </blockquote>
    If you remove &quot;retry&quot; here the callers including user space need to
    redo the thing. This function's work is memory validation. It should
    do that in its best before return to caller.<br>
    <br>
    If user space is the caller there would be a lot of user space
    from/to kernel space context switches. That will make the procedure
    even slower.<br>
    <br>
    I think we need keep &quot;retry&quot; inside this function, but move &quot;retry&quot;
    out of loop at mmu_interval_read_begin.<br>
    <br>
    Regards<br>
    Xiaogang<br>
    <br>
    <blockquote type="cite" cite="mid:20260529073544.614561-1-honghuan@amd.com">
      <pre wrap="" class="moz-quote-pre">
 		r = hmm_range_fault(hmm_range);
-		if (unlikely(r)) {
-			if (r == -EBUSY &amp;&amp; !time_after(jiffies, timeout))
-				goto retry;
+		if (unlikely(r))
 			goto out_free_pfns;
-		}
 
 		if (hmm_range-&gt;end == end)
 			break;
</pre>
    </blockquote>
  </body>
</html>

--------------iphHFqxhXdN2foDb0byplmb0--
