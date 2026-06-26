Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B8BC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 20:43:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A35710F70E;
	Fri, 26 Jun 2026 20:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CDSYhu8A";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 110E910F70E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 20:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPF7W7Mm1ISSL81p6dubauaH0VC1XQohOHfau6R0/sy2AQrPYTP0mhIEUzul2HOuNtuNenuvuoCtiagvEN8EwjJt58DtfSM141OPI0Sal63W6Ze1Y/Wcni8+L8YPlCCHB/LYNRhPtL0MLbgcT3h6SkmrP1sXF8/kmeLkMHOPsPLMyMbbFbnQm0aqEJwz+R8whzfLIqjByMdhFT8+dGszkcoMDcn5uiej7RTvrg5BQl4YRByHksU/g6p61RAQoOCtzt4Y4WO4OlaiwPcBj/5U34H6o/SdQ70SfwMh47JDNQzV27BCXfh0rwx6yP9ErJrrXxfD/I7Kcd1yhXZAgYXwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoVO8MjgQwuBnNkFLixwdVEDaY6WLKYLx6kqERzeX0g=;
 b=xneJQagh61UutEt46QcKrIET47EOsIFyYkDcIc8rz7tbwZVBh6VKGBOd1X19LmExm0cT879VHUej5dM83s1+Sa6RTXMx+Ji4SRewSF0u2kfN8EMcp0UH1VhEV5gyVUNzwjAvMbdskEGgx5ne6QoWTdnIF+KeMK38VTUe2knSmMfQwjO1xPA11HP3WsvXZKePY1lPtvi2HiU703srHPhVP21Y4wJxnNMWLgEp7Lw6OXi9dtYecxL1TXwZhqG4pM4D3FUpoQw1omzJxs93kGc8juP7A5O4XKIBRJ12653LRiHqY/D2i7EV/+FDBnsPECtLQLt1qk8gsF2tZs3uTXtDJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoVO8MjgQwuBnNkFLixwdVEDaY6WLKYLx6kqERzeX0g=;
 b=CDSYhu8AEN6tFvuLeC0ODZooeZn7X/X67OYc9sD9a1iu1sR3nsHiRqvgGzWC19F7RPCDyqLbgP+jZKaROzUhBg62gPT3BzmLKlveEGpGoO9mOQP2Azdw40BgDzr70AB9r5+vm+buE3EnCV1suIMm13CQQYVj2Syik8cjqwUMNnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 20:43:54 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::8218:248d:58ec:8c81%6]) with mapi id 15.21.0159.018; Fri, 26 Jun 2026
 20:43:53 +0000
Content-Type: multipart/alternative;
 boundary="------------VWc7aYy00n1qwLypqo2yP0Th"
Message-ID: <1f01f30d-09a5-41b5-81b5-1a65f7b44b6e@amd.com>
Date: Fri, 26 Jun 2026 16:43:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: add sanity check in svm_range_is_valid
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260619154115.65247-1-jinhuieric.huang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20260619154115.65247-1-jinhuieric.huang@amd.com>
X-ClientProxiedBy: YT4P288CA0054.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::11) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 457ba916-3559-4130-141e-08ded3c3a2bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|22082099003|18002099003|56012099006|8096899003;
X-Microsoft-Antispam-Message-Info: NV7gkMFcginBtNgNdDBSLokWbAheBxnhs6SXrmFXNcCydJmExLU66rIfMhr0w2VC5oqK+cPvPiLPZvzPE75aeVfw3GTE+AjgAu+hM8/EDbPdB3X6zjPeCymRGMrjqrRhrCMdcO/ERpodtkWA+LbCyLSJXZ33DOuGIVsIFQ6ks4fOQ1Tkt9rVDWSZcojZws4he0WNsE3FkREG1h+rv++c3YrJyGr8xluuij+jQe1RsPtHqL3ieDGGBUN+z3Um/YIB/csPFceKV6CYNxgFY8sbFydhWpJGOz2FtFCI1/UGvqC5RseEWCBD8y4r45nS/ul8dB+sl5CBMhg5pY819IHpV+Bnmn9YSxRxIN5LUUAZPmnBa/eUsz+dLa3EEb8Sc/UZY1iamllISY0NW1Ju9wjAH2G1n792fP9yTofuQXf+0lytRo8iV+ktUkC9gv7TdQK9LijmgXanKbc0KlMgK/AWY6bnXumaSXyJPzH03DvEyNZeWaKIxzcnEFcMu1Qyib4tjaVUrTsFk4m1V8HuC1CRL/w1uxrVWKGjlqQDdtTjrijdanK8pQB6LhuN4wizdrh0KIyWQHamwg1OI67fZBxFs1GZWSLmJSx+NJH3yg+0xCFOW5dBlHdHqStjFy0yT+b9aRgM1pTTsuMIrGjLe8gMDLa1OCbMZuuvvekBd/nnMg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3djMnFSZFJUdGc2M3czTnNuT29vTzFsYUV4RDE5ZFpGbzd4ZVpnNHlDaWJP?=
 =?utf-8?B?VEJrcDdRVFAxV1d1N3FJSlFEcUJOWmVESWxJeGc0Mldhd0JCaTNkdXNKaG9N?=
 =?utf-8?B?Smd2a1Z3OVZyaEZsNy83QndORE15OFJvZGRoVjNwK2FFWXZUK1B1UkFzbkhK?=
 =?utf-8?B?cE0xQStVdTFZRDE4dzhXSlpHVSs1QjFzV2pOdUtkNVYxTGhrSllxYVJJdW5u?=
 =?utf-8?B?MEZyT0FDUldzZ0dReEtVM0V1czZWcklkenBxYkYrek5hc0VBUktEbTcwL2k2?=
 =?utf-8?B?d3JJbk1LYlNTN0FhelRuQWxOL0FJODhXeldiMndkREhFK3FKVEZ4ZUpYeW5U?=
 =?utf-8?B?d2RYWlR2dXh1SnUwdFdCYkFvVGhRYklsNHJtNVhyTDNxL2ZmTWs1eEtFVEF4?=
 =?utf-8?B?bVdzQWlPTkRld3VRZlhILzI4RXNuNDJiY2J1MUNLenRxTTRZczZISjQxaEs1?=
 =?utf-8?B?TVJoME01bzBqbTJ6ZWkvRlN6THQ3RWJVWEUvZVVnQnczcXc5WTVXRTR2V2Jt?=
 =?utf-8?B?QXg1M0twTHE1VHNydHZycXYvL0MwbmNKMDBIR0VPR2x3dDliTG50MTFMbHQ2?=
 =?utf-8?B?dlZTYTRWRk9hQ05RdmFIRnQvY01pTjZyQ2Z1R1hDZFFWZDAwUXlCUTR2VUdQ?=
 =?utf-8?B?Sm5LQ3pHK1I2RExKYzMwT0FtTTJuNXlmNUtDT1ExUkMzV1lrYWNNb3NJdnFr?=
 =?utf-8?B?cVYxZUw5NUlLSkVUVzJucitLdlhxbStlbUg2VmF3YUxlazR5Y3ZyaHRFLzBn?=
 =?utf-8?B?eEJLbTVOV2YxY0pGK3cvSTNxdkNqZ2ljQXpCWlBDaEQ5enV0R3d4Sy85VEV0?=
 =?utf-8?B?UmlaY3Q3R1RWNzNFVlBDcG9EOFptcnBXazU3c1k4eHltOXZyQXBxeVJFNnVH?=
 =?utf-8?B?dWp4OVFkbUVCT245MTZkemdRdWhrK2pTZ3Y1azhYTXFnMTY2aWpDZHZ0Y2dV?=
 =?utf-8?B?V2RaeERqalpvNVhKME8za00zT1ZQWW5DaHlLMzZUWDBhU2FGdm05Sko3Y3do?=
 =?utf-8?B?K3Z3cUROM2gxYVZ5M1VpcktpOFd0SVovc2QzaytnTyswQldnYWFJQTVNV0Ra?=
 =?utf-8?B?TGkvdkk5dW1veWlmeEtQS1BOWUtxL0VFdjB4dnpSOVByN2lidzMyaVZ4Tkph?=
 =?utf-8?B?RlNGZzBNaklkcFRvYkNtWC9iV1V2OXg2czNISFphUEo0b3BQM2pVNFVBaXd3?=
 =?utf-8?B?bTQ1OEV4alJydzZrcjlSdkpQMXNCNE1BbUxWcnQ2bWhUcFA3Zy9DTkFFSHJl?=
 =?utf-8?B?bjFmNERUNERjSU1HamljZUpUWEh6K1FHSmlMa2JRRVFVVEVSWFhZeXJvVjll?=
 =?utf-8?B?MlA4THhtYzdjT0F4eHI0N2cvNTZXdlFFaG41Y2tjR0pMVWZUNU91NVh2NEtQ?=
 =?utf-8?B?RXNEQ3lHc29qRGhuTFkrYnJqLzhOalBVV3FVTXBoZXh0UVdKZDNxbFNqRmp5?=
 =?utf-8?B?MGQxc2Q0cGI5SlYvb0hBcnVYcEFrRjZvaWdoclRBWTR5ay9LVWlsTlRhT09D?=
 =?utf-8?B?OTlyOHptMTVsRElQWWlPdUVweHJlekp6M3NGUS9YZStHY2dMaWJ5WnhQVHFP?=
 =?utf-8?B?MTVKRFdkeU9vZTh5eWhEdHFFU0JOa1ZPdHZxL1N0dHhmcEF3bGhoSHBlTHgv?=
 =?utf-8?B?NXhvUXdkNmU4TjdrUlFjRDgwM3lRNExhYnlRNkpNYyttVkxQSWYxYkdlV0wy?=
 =?utf-8?B?MG4vdmk5c3RPSG5IRmFLWjcvTzE0NE9Zd1pnQkpxTGV6bHdrRFVFcTFnK1c1?=
 =?utf-8?B?MzNnS2xYT25mLzJLMDMwRThaTDhrRWF4T2U5MnFSOUJMaFFxb0ZqbGdkUXo3?=
 =?utf-8?B?YzhqVXpKNmc0RGRsRjZRdWVsVDZ0Nzl4OGNrR21vL3Ric0JUQmliOCt6a2dk?=
 =?utf-8?B?TGVDRU45TThyYndHUWlQb3J5UFJJeTZOVTVBaDlVNFBRSmV6SnRYSStBVStQ?=
 =?utf-8?B?dEJ4VGk2bFBvVXF3RjRsTUNJKytzeUp4b09tVXM4aklMaHBITklZU1NCMlBp?=
 =?utf-8?B?MndzeGF0K3RnbXpLTjJFeG1qWE9XejJXSk9TWFJUcUFvNEdJUFcrT1JzaDhO?=
 =?utf-8?B?U1Jsc2VuY3RWaVh1eWZOYzVWREdKeGNSbEhYQUhIOFdudHpBQVF6dDJNaUh4?=
 =?utf-8?B?OHNoN3M4ZmUrVUdBMytWQUp2dFcxOVJpWG9NK2VJS0M1RHhid2VUVldlU1F6?=
 =?utf-8?B?aUF2bmpQV3RiUUdXdVE2Q1dSVk5zWmJGeDhLNnFRYmZBZ1RHM2JlVG5OYU5D?=
 =?utf-8?B?ZHNaOURBMDcyVHVIcW1HMjhsdVltZVhzSDdHdVlZdVY0endqc0ltWkFsdFlT?=
 =?utf-8?Q?N3Bt5oKOkp2H6OYBNW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457ba916-3559-4130-141e-08ded3c3a2bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 20:43:53.7375 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB9ZNOM4eoI0faY2LRurnyRyKg9Vl2ZUZNiJ9uxDUbD9Q6NWfhm3IqJcmGXdM2BC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439
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

--------------VWc7aYy00n1qwLypqo2yP0Th
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026-06-19 11:41, Eric Huang wrote:
> to prevent svm range to be overflow or underflow.
>
> Signed-off-by: Eric Huang<jinhuieric.huang@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index ffecd818e611..0df6851420e5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3473,7 +3473,13 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
>   	unsigned long start_unchg = start;
>   
>   	start <<= PAGE_SHIFT;
> -	end = start + (size << PAGE_SHIFT);
> +
> +	if (size == 0)
> +		return -EINVAL;
> +
> +	if (check_add_overflow(start, size << PAGE_SHIFT, &end))
> +		return -EOVERFLOW;
> +
>   	do {
>   		vma = vma_lookup(p->mm, start);
>   		if (!vma || (vma->vm_flags & device_vma))

--------------VWc7aYy00n1qwLypqo2yP0Th
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-06-19 11:41, Eric Huang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260619154115.65247-1-jinhuieric.huang@amd.com">
      <pre wrap="" class="moz-quote-pre">to prevent svm range to be overflow or underflow.

Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com">&lt;jinhuieric.huang@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a>
    <blockquote type="cite" cite="mid:20260619154115.65247-1-jinhuieric.huang@amd.com">
      <pre wrap="" class="moz-quote-pre">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ffecd818e611..0df6851420e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3473,7 +3473,13 @@ svm_range_is_valid(struct kfd_process *p, uint64_t start, uint64_t size)
 	unsigned long start_unchg = start;
 
 	start &lt;&lt;= PAGE_SHIFT;
-	end = start + (size &lt;&lt; PAGE_SHIFT);
+
+	if (size == 0)
+		return -EINVAL;
+
+	if (check_add_overflow(start, size &lt;&lt; PAGE_SHIFT, &amp;end))
+		return -EOVERFLOW;
+
 	do {
 		vma = vma_lookup(p-&gt;mm, start);
 		if (!vma || (vma-&gt;vm_flags &amp; device_vma))
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------VWc7aYy00n1qwLypqo2yP0Th--
