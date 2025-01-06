Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35B6E77199
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 23:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245DC10EA3A;
	Mon,  6 Jan 2025 23:51:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="18IX4yRX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1A0010EA3A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 23:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdHuNak3EhO3nKUOfzckqCxoO90pZSiPSuGvIf8Od8IeHZ4PZecOnXldpe5tHm8vDukO0o39JdLMP12/VLoRVHtRSpRfoxonqd7vC8IpGSSX1VDsUKKy+uGs5P8Qckkf8S6uBxlNGOwWJz/AbM+ozACiVIpmWnPjp3/kgrHYnm1eHlesIt8/FAxeUhz2IasJpf/K1K3xnX51SbJ7BJSyRPNL7vkxxKCPXwLqKGuQtGsnDBUQTYuqJYSGzZiUnyFc6s/r9mXqiNtwvVw0SUSdS0X97cdFySeuUpHHX3OTGFHtGi6zesHJ78TGHA4vBM/CPwORBvmKBzHXZz08fXp7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM6VCk9Ygv0KAKgOSIIl4h1RzLQpQsgHT2MndV+6PZQ=;
 b=QCRqFBHQU86susUJGJbfUJRj2r0iMjgxVD/YmxSDLxcLORPw/LzyZZBS/QPmX7p/FvFhieFaGrVwd0qfoT9P1NLLLDxewVdxvPCT24WNbBj47J6kMMNu6pJhU/Upeo6F9v7wkfyCYuLA0SGyaE3Rgvd7xe1oM+3rgqzNUW2C2PqUqWmjKKNiby4R+KAyIuLhxgf0JD9Kq7zFHYaCmiduPwzS4rnfZXSaR1/X2eiWr4PqEickgprB9dF7jJVPD1punPiq388gcUBVInaULuyzLrKQfwsrK2pLVPrYYZCz8sFhZqguwCgsXD40NhCwYDYLPPdcISnv6Tn/TX3w1V7o2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM6VCk9Ygv0KAKgOSIIl4h1RzLQpQsgHT2MndV+6PZQ=;
 b=18IX4yRXImm1prZiPveOi4PyjMSp/dzjFL/oK0c0Sfk8aqbu6u0XEM9KtUzAj5YNv5cvfpH4GkONEKD5vRIueweNP0h1MU5ssawNlhfAM4L00MZ7VW10NDxvO7MA5riEi3BI3MtJDW7wx5RNv8MFt0GYeckqq19I7oiP0NK0r1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 23:51:00 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 23:51:00 +0000
Message-ID: <4db6b354-56e6-3d2e-0da9-bfd1943320af@amd.com>
Date: Mon, 6 Jan 2025 18:50:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250103000644.1398643-1-Emily.Deng@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b495581-a053-495d-bdd5-08dd2eacf8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2Y2NTZMVmpzMEJYQkJYRXFtSkU3cWlIUS96cW1IRE41ZzBaWXhteG9saEVO?=
 =?utf-8?B?S1luY0lJdDRJTXpGUUwra0xFM01RdTJ5SEdvZFZBQVFHRmFRRjlXOE9qNVIz?=
 =?utf-8?B?dTdrMmsveU1kemNBVzhBZGVVbCtraGlCVDd0d1pmR2dkV3Q0d0VncTF4SDM4?=
 =?utf-8?B?SkNVVU42ZTl0d3JWcWVDYWVUcUVFZXYvSDMwQ3MrTnk0aXcrYXlkSyszUFk4?=
 =?utf-8?B?RmNqRkhwalZOeklvS3V2dEJGcTZVU25GZkZTMjRxbXdiVk9SOUxpRXI3RDN5?=
 =?utf-8?B?dVI2Q0kyaHQxMWQ5RUpweW90SlJvdFREZzhjQnFBSkZnRVlrNjdqa1ZWM1Bu?=
 =?utf-8?B?N1A2Zm5hSmpaZi8veUt5ZGl4VzNGV2kySUpRbzNhOE9kd2pXNHlLMGpYLzJr?=
 =?utf-8?B?c2VHWmlZdGF5dGVIUzNtQStaY2lOS2tXaFFOUHgreWlHUmdKQWh3U1QvSE9R?=
 =?utf-8?B?T3BCUWJvcWRRWlNBakpPMmFvOEh0cXhKSmhHSEJtWjE2RjVFRzFBSUttWmxO?=
 =?utf-8?B?S1dNQm44RitsT0ZaSXZpbzdvRmdRZXdNS21GRUJraytMKzJtb1M1ZzUzWTNj?=
 =?utf-8?B?TDhicDBhT1QyMGZzNzgwdTYxcm5mRE84eVk2VVE4VGJDL0tadWoyNzVUWEdY?=
 =?utf-8?B?UjQzNDc1U0dydElnN0hzY1NHRUJIeWRWRmFLMnFDaU1Qbmk2MzB3N0VyNlg3?=
 =?utf-8?B?a2VzMzZ1MHUwKzNVOHBORHFyZndweE5BTGdQeXZKTGJGZ0EvQy9Gc3Qya3J4?=
 =?utf-8?B?V05MTXlqUG1zYjFOcW9tN2VVTXNnZnRpYzVFbjdDRFBodVAzaUVwNHl4VVRE?=
 =?utf-8?B?K1FOa2hybFh3NS9nYkVxdjRnR04zSTBEUE5va083SUxxRjhUSVh1VHhEbnVV?=
 =?utf-8?B?V0c2R0FGUUNMNEZjM0pVZjBwVE1uMFNUd1F5Mk9BY1Z6dEJiWHZoaWxMVVhP?=
 =?utf-8?B?R2ZUbk0wWEkwZmZicENhYVBoQllEbDNmdlYzWHVLQTVyNzRESW5wNXhvVXR5?=
 =?utf-8?B?Y0hKdW5pYU1MS3NMUDZjSVZLUk51UUJsZVZ3TktYQ29aVFcwR2Y1QWNlMTZU?=
 =?utf-8?B?OEV5WVNGam9WSTlSRXJCN3J3L1Z4YzZGZHRzM2VibXI2eE9HdUZyaSt3ZFJB?=
 =?utf-8?B?TEdSUk9aRU42RUs5c1ZTRXNyalhvMXF1RHVHZmlxMktzUlpjN01BTk9Zb05W?=
 =?utf-8?B?R3Npa0VrVFZVWG1xS0FPVDBoSlpOS3I1ekEwcUV6Mmh1d0tJTnZJRzB6bVQ4?=
 =?utf-8?B?a0Q4Z3hBUWE2aG1mck1CUkxTb0RBSXZuQTM1OG9WS0NEZjBKQTNqdm5FWk9G?=
 =?utf-8?B?dUNCYlBoRVdLM05YZXpsWkZxR29rTlpZYlg4YzNtdG9hMU5QNm5sR0ptV3R5?=
 =?utf-8?B?ODBObkZ2cFRpNUwvZWJ2TnVRUElKQWJ3bktVeFJ3TEE1SThWQk1SRnBUTXB5?=
 =?utf-8?B?eVZNWlB3TFdDakkrUkhKSTRyWXBLOUx6WXF6c1NYelVGU2hSNTdya01PVThF?=
 =?utf-8?B?MWZpL2doVUdCVUg0dEI4REdtNmxLajdJY3JOUzhzdUVXMmR6VnIyOFc3WW5p?=
 =?utf-8?B?SEM0MEJtTzlZaXZENS9GWFR1UDRUNG9wUEZiem5JNTdSNFB0YkRWMHJHYU1C?=
 =?utf-8?B?VzBqOEJYMXo4dU8xWFpKOWFpcUFZbTBBcVplQUR1ZExUeFdVaDcwSUQ4am03?=
 =?utf-8?B?YnNqeXllNkR4dU9KZGxNYVJmZ0tlUi9zV0ZkbVkxNHRVVUFIVTdlNElBdFVM?=
 =?utf-8?B?R3kzYk9xaUltNnREWmxnT1g4N3dDOWNWYkhidVVMb2JpUTVoQVAvZlFuQzlT?=
 =?utf-8?B?MU8rVVpYeUFmRHJTa3pSb25yRSsxc3dkSzVZSFJMNkhobHRBSytLNVM0K0dh?=
 =?utf-8?Q?zLHp4y0htBqL2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW9EN1MxUXlNd2M3aFpRS0VFb0UvRmhkTXFmZ1ROdkhSL01BUGJOdjZ0c3py?=
 =?utf-8?B?TVI1c09qVy9SNTdESUxaQXpvZjVwdGo4R05GRHZDSEhpS2I5eks3dFRWSjZC?=
 =?utf-8?B?TzQvdUlXL1JIVEJ2UXRKYUIweE1Ob2huVVJ5TVJQSXhHQnpWalhXZ28yV3Vs?=
 =?utf-8?B?N0FoUjIrbFhSZ2luY3g3TWk5ZUNPaklPbTZ6YTBScktFV1R0aWFQZS9hR3JS?=
 =?utf-8?B?MjFSTTdDQVJMMmxyL29ZYytqcXg5dEtOYVNFQkZyUWY4Wld1Rkc4dEQ4N0E4?=
 =?utf-8?B?TWVBUUhLYURPMEgxOUpzdXFpT3RNYm9adGwrU2dPTnQya3IxWUw2TU43anIx?=
 =?utf-8?B?U2RodCtEem5DeFdNNE5FUVZIdkIzTllFT01TR01WZitwUFpCanZmeVgzaHI1?=
 =?utf-8?B?bXg0cE8yeE9JRHA5OVo5MmRTYk1XbHVpZVluRFExMTdMOCtFVXViWFZ4RWht?=
 =?utf-8?B?Zlo4Q2oyTE92dWVjSndYMllHTC9qL0NNR0FBTkp6QjRDY1lhdkVWOEpaMkw1?=
 =?utf-8?B?eStVazJRd1RNR1R5VTZhWkkvV0RIY0pwZzI3dzVBQW1MZG91L0dBU1BCUDRl?=
 =?utf-8?B?WW9BOGhpR20wN1JHdmp6WjZZc0NkVFBURVdiTEJlY3kzZXdiT0xMN2w0S0pk?=
 =?utf-8?B?Y3NLQU1BRXlzbHlqckRGL0ErVWpzQXY5YytkdHJORUxzdy85NUpoREZ6TVhQ?=
 =?utf-8?B?U3pkelQvaUNWcEV6Y1dPZDlCdk44MTZiRTRFWFlTVmhPQkRjU1lmckdqWjNr?=
 =?utf-8?B?VnordXZKNDJNTUJ6NEw5azcxeXdkSGduSWRGRFhMS1lvWmFHNE44WUpPUGNr?=
 =?utf-8?B?bnVJanRYblRIY2lpYXFrTWR6V0JsZERlTytsYVp5YVJrLy8zak1HanBqRU5T?=
 =?utf-8?B?QjQvTVpST1JjREJtcmJXbUFmWDlqT2xQcUVJZUVFNGZYY3NCN0ErcXZTWXN3?=
 =?utf-8?B?VElrcURXN2RseFdKNnNoQ1pobEl3S1RhblJPd042T1JYZHlCR2tKN1IzdStC?=
 =?utf-8?B?Rnp2OS9yanVFc1JWU0Y2UWZSUmREVzlKS1B3L3hrOGl3VUY5dlhXOFd4SS9Z?=
 =?utf-8?B?Wk1GVWRGYkNtS3BGdWdnWWRDLzdVQjdjWjdFL05vQTIxaS9ZN3dJM0kxMVNx?=
 =?utf-8?B?bnh4REVOWXV5TWhOZE85OXFDVGFoNzhoTi9ySklvNTdaMzRyR0toS1Bpa1VM?=
 =?utf-8?B?RTE2Wks1SzlQWnp1R2gwS3dkNUpuWUZxN2VmWEFJZU1STU4veGt0bnZtYTdr?=
 =?utf-8?B?NTRScHpOTitobmRocWV0WGh3ZEI5RUdDaUM3dGc0SWRIcE9jb2dRb3dOT3hl?=
 =?utf-8?B?OWQzTFg0OEJjVjF4UC9EcWxObU1YdndOa25qd0hXYTZ4MUxHSHRZYzFCTjNi?=
 =?utf-8?B?QjF4MGlZUW05SlBzaFlMZ0VsTUdnS0ZzWmRLU1hiK254Tzd1UTIwWllsNEh4?=
 =?utf-8?B?NFpXWHdKMVJLbDFUN29sMjFGMU5MZnc1YVRhSldhSGE0VHlha2NJVldMUlhE?=
 =?utf-8?B?TTdjNVFISFV4a3dJQW4yVzhSR3VzeGtneFNtRlhmNmEweUlKQ2NGYlRPOFRJ?=
 =?utf-8?B?cjBlU0ZtUE1qMGhwUXVNMWtXNEprbjlxQXpoQThFN0ZQUzJVVXl1QTA0Z2xz?=
 =?utf-8?B?aEJ1ZGNzMWFzUmNiN0M3ZmFrQjZwa0FLNjNDUDVNMEJEYUx5WUNsa3Vvb3Nn?=
 =?utf-8?B?dm1uOG5sQzZLcWloSG5UNm9IVFN4QVQ2YmpXYW1XZ0ErTXlENVNyQ0h4c1FI?=
 =?utf-8?B?bHNKVTl6RVIrZmpVYXByV3hoY082ei90Y2wxY1RZTUl3cTljNnhncks3Ynlu?=
 =?utf-8?B?QWpwNW9wRDNJNEt6Sk1USk95VW5TaTBOWG5mZkUyY0YySW9hK1RDcXNnTWhP?=
 =?utf-8?B?dVF3WFZhV1pUQVVmRHR1bWlWYTJGWXNiUW1vYVZ0SnhCSy80eXhrQUROTThi?=
 =?utf-8?B?bERpNXFweUpiT3dIb0hydEIwaFJCaVlaNVN5OWhiR0lsaXh1QVplbzVjb21X?=
 =?utf-8?B?Zkgxb2VKZ3RlOVd6TkxiRjdSRTVKb3RTNGpaR29tVnZHSEhRYTNxMlBNVEdz?=
 =?utf-8?B?Qk1Lc0lZT1REUFJOK1M1WGdrRzB1YjFXT2FrSHJKNTRRMmFyeDF3SFQxWkFO?=
 =?utf-8?Q?izxeKBYdvCLNpyL+tX8R4lPTO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b495581-a053-495d-bdd5-08dd2eacf8dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 23:51:00.2473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+i4OB3qcO0FGa6tqFKg6Oliy/aeShI763Stmsxw/GHnnjkad0Qz2PXFF/qrIBPD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-02 19:06, Emily Deng wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">For partial migrate from ram to vram, the migrate-&gt;cpages is not
equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate-&gt;dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 4b275937d05e..5c96c2d425e3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate-&gt;cpages;
+	uint64_t npages = migrate-&gt;npages;</pre>
    </blockquote>
    <p>As partial migration size is based on prange granularity, by
      default 2MB, maybe always migrate-&gt;cpages equal to
      migrate-&gt;npages, that's why we didn't trigger this bug.
      Wondering how do you catch this bug? This bug will leak svm_bo
      too, as svm_migrate_get_vram_page reference counter is incorrect.<br>
    </p>
    <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	struct amdgpu_device *adev = node-&gt;adev;
 	struct device *dev = adev-&gt;dev;
 	struct amdgpu_res_cursor cursor;
@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		struct page *spage;
 
 		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
-		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {
@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 		} else {
 			j++;
 		}
+		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);</pre>
    </blockquote>
    <p>This should move forward, to handle the corner case to migrate 1
      page to the last page of VRAM res cursor.</p>
    <p>Please check this change, to add mpages accounting to break the
      loop earlier. <br>
    </p>
    <p>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mpages = 0;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t *src;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t *dst;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t i, j;<br>
      @@ -295,14 +296,9 @@ svm_migrate_copy_to_vram(struct kfd_node
      *node, struct svm_range *prange,<br>
      &nbsp;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; npages &lt;&lt; PAGE_SHIFT, &amp;cursor);<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages; i++) {<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = j = 0; i &lt; npages &amp;&amp; mpages &lt;
      migrate-&gt;cpages; i++) {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<br>
      &nbsp;<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev,
      dst[i]);<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
      migrate-&gt;dst[i]);<br>
      -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
      migrate_pfn(migrate-&gt;dst[i]);<br>
      -<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp; !is_zone_device_page(spage))
      {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] = dma_map_page(dev, spage, 0,
      PAGE_SIZE,<br>
      @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node
      *node, struct svm_range *prange,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j +
      1) &lt;&lt; PAGE_SHIFT);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
      @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct kfd_node
      *node, struct svm_range *prange,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to 0x%llx,
      pfn 0x%lx\n&quot;,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt; PAGE_SHIFT,
      page_to_pfn(spage));<br>
      &nbsp;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev,
      dst[i]);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
      migrate-&gt;dst[i]);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
      migrate_pfn(migrate-&gt;dst[i]);<br>
      +<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1
      &amp;&amp; i &lt; npages - 1) {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src
      + i - j,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst + i -
      j, j + 1,<br>
      @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node
      *node, struct svm_range *prange,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j + 1) *
      PAGE_SIZE);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
      (END)<br>
      @@ -322,6 +318,7 @@ svm_migrate_copy_to_vram(struct kfd_node
      *node, struct svm_range *prange,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j +
      1) &lt;&lt; PAGE_SHIFT);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
      @@ -333,6 +330,11 @@ svm_migrate_copy_to_vram(struct kfd_node
      *node, struct svm_range *prange,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug_ratelimited(&quot;dma mapping src to 0x%llx,
      pfn 0x%lx\n&quot;,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; src[i] &gt;&gt; PAGE_SHIFT,
      page_to_pfn(spage));<br>
      &nbsp;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev,
      dst[i]);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_migrate_get_vram_page(prange,
      migrate-&gt;dst[i]);<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] =
      migrate_pfn(migrate-&gt;dst[i]);<br>
      +<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (j &gt;= (cursor.size &gt;&gt; PAGE_SHIFT) - 1
      &amp;&amp; i &lt; npages - 1) {<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src
      + i - j,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst + i -
      j, j + 1,<br>
      @@ -340,6 +342,7 @@ svm_migrate_copy_to_vram(struct kfd_node
      *node, struct svm_range *prange,<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mfence);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out_free_vram_pages;<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mpages += j + 1;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, (j + 1) *
      PAGE_SIZE);<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = 0;<br>
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:20250103000644.1398643-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	}
 
 	r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,
</pre>
    </blockquote>
  </body>
</html>
