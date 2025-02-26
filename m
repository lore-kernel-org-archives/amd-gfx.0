Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D7FC021A4
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 04:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7808110E209;
	Wed, 26 Feb 2025 04:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NHm+0azD";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ABF10E1B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 04:59:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O51FGGfebcm2GFl80vYudxeEk+8G5+AjYAw1usBLae2Hh6VWtzsVxWhxHQ0ik0tcU88EQIzRCl0L2O+auTYJL51YHR3FaN8gCVmK4fH1fRGjDA0RIPTGjvM89rGBXF824wvfR11/prc/lDcv9KZZF0xNpgz77QLS9z94/PT63aqqqF55JPPjj3G+qAfyJ7hkpkLfU13SPgSt68GxHBE/qHA+w4qEInuYYAXz8dbB6URLHACWjs+hVrgR/xgRQ4zEx1pFv8wMeGZ9q9D937iSSpYlQKcoJszq2xlDVWeNDnRBYwx/fBvPU0HczNwMnR5TrqTWlnuWohBKMTRjhjZpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4w8GSnYOe5orPYAirMMem+Z0sUkT0UL+sdVwZ2IMzg=;
 b=yOPCGwFrlVK7uWwy2Shc4/DBhT8l8EH1+LMaEDFv3u8yES+vudg5B4f5F2aJ9jPByljLhOuf8q0Jad8fyxajtOcSBnKQGW+Pw8V/WwjaXTNsoBYEqyjlNkhQYNNLKeM1gyAeBVaJfXSe0XVq1RWRVtyHLRSECLYQlyO/aJha9HtCkWnfq3ZHDo2yRynJ4faGTROhG2U3ARDPPMhzhhfDx5aagINVETlHZfe2nzVBL5mEdO9M/diEGYoDajooed74uaqcNiW/uggDglQgq/58u/tYmy8Jk1xw0YCj3J9L5VTivi3+C5fM7hg74l1+vyq7UdpPDHM06AaOOyK5kSNNGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4w8GSnYOe5orPYAirMMem+Z0sUkT0UL+sdVwZ2IMzg=;
 b=NHm+0azDt2ccqIbPquCEHeQ0y1krjNFUniu5sk9hW2eYui2x/Vfif/ZkD76wKIKxiHF5NAsj2iDa/jbkgYTCnx8/ywzQPH4t7S2MtdX6tlGrUWqpG88j/NnKsWDAutvqnsYEVv6w7R04g6cTm8aNrKpsmRgJ3ABSs2nD2FEdK4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 04:59:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 04:59:38 +0000
Message-ID: <552c45a8-9a55-4384-903f-7446561cc482@amd.com>
Date: Tue, 25 Feb 2025 23:59:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdkfd: Fix Circular Locking Dependency in
 'svm_range_cpu_invalidate_pagetables'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jesse Zhang <jesse.zhang@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, Alex Sierra <alex.sierra@amd.com>
References: <20250224135619.2319500-1-srinivasan.shanmugam@amd.com>
 <20250224140831.2319762-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20250224140831.2319762-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0314.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e94ed20-7cde-4ea4-0076-08dd56225f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mnl0RVBZQWdZeDJsNXFKVUZsSlVSMWJ1eTdwRFR1SWxKZGIxRjVweGlaaUJh?=
 =?utf-8?B?N0F2ZHRmZVpQWHZqaHh4SkxDa0tpcXJXdEx0cDAvZGNGZVdlTzVCN3JrdU1K?=
 =?utf-8?B?V0wyd1lzQzJIWUJZaFhyQ0RVODVyTHJINklCQlpoZ1dTWS9oVWkzOW1HL213?=
 =?utf-8?B?eXBXZllVRnlWNkdaeHlwQkVGMFZZS3N2eW1Odm1FeEsrazl2K2lmUmgxSGZ6?=
 =?utf-8?B?MEpaQ3lVdkp3OEU4cm9WbHhiZVpzNlBzTjRRM2p6dWNhZ1lnc2xrVjB4TWRS?=
 =?utf-8?B?RG1XL0RVeW94L05yNUZNcnVGQUg3VzA1U2I0eUJ2Z2lUbkJaTk0xblJ0Q2tt?=
 =?utf-8?B?RDh3bmx1ZFZQbk84eTZFNEJHbUdyUGw3TFNBaEtJM1RkN0w1VEhKdndhQzhG?=
 =?utf-8?B?MWFrRjJ1azlCaTVOMlZld000Qlh0aVFRcktob3pteTNXS1huUWRBMW5zckNU?=
 =?utf-8?B?d3lQNkVDdFlVaDFmMFJ2dXhLWmlpa29IVDJFamRwV0t5UHl6bzhMY1BXTEhF?=
 =?utf-8?B?TGhKUlkxVmkxaW5GNE5CaDAzK3lhL3FDMmp5RHJmdTZIbHRaaU96V0JwNXlH?=
 =?utf-8?B?MjVTQ2FvRWN2TUcraXVMR200WUdDdklQZFYxM25wcVRtbHRrcE91TVRqSkZF?=
 =?utf-8?B?TkMrRnVOL21Ebzcvak1qQjROSGt1cmhLakRhZUxsd0tVa1U2RWxoTld2VkpV?=
 =?utf-8?B?alRpdGcxNmxQZk1TOHE1MlArc2dkbDE1UzFUN0doVE5scURrREZvWUVvWmhV?=
 =?utf-8?B?M1Uydk1ENDdjdng1K3VrUTJBOVQxM015MkNoUjU2UWFlT1loMHdwaDBUSjJh?=
 =?utf-8?B?clc0SmxMN3pwbXBlSHRxTW1lcEg2alFLN1ZRcWRUWE52ZmhpVjg0b1owVTJh?=
 =?utf-8?B?SDlsVkVoS3h3RnNUVVFRczByQ2ZKTDlNNHB6ZEVLcko1a3kvK3czRWtlWUtl?=
 =?utf-8?B?TWNiSnpBSTNnVmNhaTBkTDRsYUhST0w0NDUvOGU4eU1XUGYzb0psamd5SXM2?=
 =?utf-8?B?NW5WNFoyNnVwcFlROStHbHVlSWJzVWVMaWRka1M5eFdsL3VzcmlwMjZRQWg1?=
 =?utf-8?B?eDY2VkVmb2dLdEdRRGJ0SCtZUGpYeXc5RmRGa2lFUE4yS0JOUUZESVhuNUkz?=
 =?utf-8?B?OTFIM2VkNkY0UkVST1ZXQVExWGFaWDdhSTRHbVUyRUV2MnczVEpGWG9FWllG?=
 =?utf-8?B?cWJTUEwyLzZGdnl0OWZwandPZmVlVUw0WENoeTZOaEw1NithM0JtK3d4UnFs?=
 =?utf-8?B?dlVId1dQSzczV203bG03dG41YWQrQWF6ZytwNnlSZFlURitjQ2dLU3RuOFpp?=
 =?utf-8?B?N1B3QWlnV1ZUak90bTU3RHVHQzlXMlVxY2pSRUlxam1NWjRnUjhlaktiUGg3?=
 =?utf-8?B?QzJNeTZkVGRFZFNoU0VNMVlCOFBuVWFzbkhnTDNIZ3YyNnBIa0VHQ0I0QzJF?=
 =?utf-8?B?NkdNT2hZcE1xQ0dRalB3eFYveENLYjF4UTdZTG1hSENjQnFQclVXTWE2bUFl?=
 =?utf-8?B?VVJpaUdEcDVocmNKOWJIUGlQR2JOelh5Y2tQc25YVnpJWjlvR3JFUXlLbXVN?=
 =?utf-8?B?ZzcraWpOWEpFNDdrYU5MVm9sTzJnN3BXTjI3SmFGMCthandYWlh6aHNrWFJo?=
 =?utf-8?B?WWNlRGRqYWF6b3FCY1NNQnY1a3RTaWp1cHE2K3FMQTVoNjZkdTNnYVpsVXR2?=
 =?utf-8?B?TzMrZjZiQjVPbkQxNDVWaHI5aGVrZkx1a2pLODV3ZlJGZzhkbDFnakxSYU5m?=
 =?utf-8?B?d2xRSXdTUEVGRFgreGpSbEpOTEp1bXhHWkM3K2YwYkdUZWFOekdqcVM0Uito?=
 =?utf-8?B?OFQvcVVvTVkxYngyUlZKeDUyS1ZUWG9NaVdxWmNnZXQ0YWV1Mmt5NUdGcjYw?=
 =?utf-8?Q?Xm/SOOr0YmZy4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGhyb29PQVFkNkFobWNpaXh1eDdxUFpLbjUzVFAwbGdMNG5BOGEybUFzRVZm?=
 =?utf-8?B?TTlDMFNxM3lPMEIyNHllUlBBVmFwbnlHUzZzTmFPcC85aUd1dG1oMm5ueFBz?=
 =?utf-8?B?c0FLaEYyQ3NnaTNjZVUzMDV0SzUzeDZFT3pncDY5R0F4VHk0cjZkTW1sOXh5?=
 =?utf-8?B?VUlnVU95ektCS0o5S3BPOVF5ZDJRL3ZVYUZFY29MNGIya2pSOVgwS1cxQjR6?=
 =?utf-8?B?VTdNSVRrVFppRVlYU05zTUpRekhlZkhMYU1INW5jSTJrTzFqRUdVYUxnUmNT?=
 =?utf-8?B?QVZFeXErRVl1Vi94bWcydFdyam05REpuc3RCU3EvN0pJUFJrSlBEdEk0Y084?=
 =?utf-8?B?SUJsY3prSU8zZFQyZ0NzTS85UVExNUVUZFJQd3doMDJ4UFkzVkxDNExiTFNa?=
 =?utf-8?B?bHhRckNGSVBDT0ZiYjNNVUU2VXN6dWdES0h1MndGZG9pMWRCbUpMYXJjR3dl?=
 =?utf-8?B?N29vTThYSmM3MStybnk4L09yUk5PODE5ek5jdHBja0IxYkVmSU9nQkwzczFI?=
 =?utf-8?B?UTBDaTd5TXduZW93SFNNUkFlTm5SV2dZOXZ1UXdaUDh0RnZXVUl6ZU1hbmo3?=
 =?utf-8?B?QjhLcDRHWkdQcitOT3czSDJpZU9kRUdZNXJaTGNyam5kcGJzOXJRNVRuYTRj?=
 =?utf-8?B?OXdrKzdxTEJvSzBmWWFxN3cya2VwMzZkWWgxMUVTeXkxUko2MFE1ditYR1ht?=
 =?utf-8?B?YVdsOFFXMWdobXBKaXBITzE4RE9WcU5OZDI2MzdCVnkrZTJ3VnhSVVE3QytR?=
 =?utf-8?B?MVd0eFZHdVNPS0I5RHVScWpvTlRSemRLaVMzRHJYcUhOSWw3RGZXdHprYWNq?=
 =?utf-8?B?d2gwOEZJODhIT2ZpeDJYV2w0V1NUYTJ4MS9qRm5uRUtSK0RqbHZyWDQ5OVJO?=
 =?utf-8?B?ZDc5WDByM25CYTFFSS91SWZ2aE5JTVVkOXJKTFhKRHlOcHl6YTNsZ1F5M25y?=
 =?utf-8?B?QUFtZEUvM3hMY3VjSHJ0WGk0eXlia2JBZkoycFQyakZWRFEzdzlPLzdJM1FV?=
 =?utf-8?B?UEUvOXI1TnlCM3pScFYzczFWMDBBK0pLNkZER1F1OTY5cytwaWp2SGJieTlu?=
 =?utf-8?B?dW5KV3dQOWtxRFRwZXprQmxBanpNbUMxVEpXRHVsRHo4N211OTN6VEFEcFBm?=
 =?utf-8?B?dkFORjFwdDMyOVFhaEZvbVQzblNKdGJLOFhoTG5EZWZWQVZkK2tRc29IdFNK?=
 =?utf-8?B?VkdmeHMrMmhYQ044VkwyckVmS1Fpa2RkZzBDZ0RrVGlwK2ZQMXE0d0pjN01D?=
 =?utf-8?B?L1lrZXN2eWE4eUVXRWFnaUEvSXJqcXNvVDV2a0RPWTQ1NHFnOU55MzRiemZM?=
 =?utf-8?B?S2hkWHVHdytnMjRFaGtwSGw3NVJVdk1qR1p2NkQzaTluczFRTm80WXcwK2xm?=
 =?utf-8?B?cjBVcng2TkVtcFh0VG9KRkxqWmFPZjdpQ05meXFjWHB4RmRnTjM0YWRSSjI2?=
 =?utf-8?B?WVBobi85WVI4dUovTXhVMklzVEk2clVoM3dYaW50ODZ1TWFuY0Y5QVVZTXZX?=
 =?utf-8?B?RGpOTmNEVURtRWFXeUp5OVNXZW1sQ2RCRThKcUQ3RnNlcnJXRXJ3MUsxY2k0?=
 =?utf-8?B?UWEvVUh4ZzVJeVhZendQc2w3QXpyRWdjNCs1ampURnFlT25OYWF6WG1CSUlZ?=
 =?utf-8?B?K1NLWXNBdXdSVkpENzZxbVZtRXBrdm5nMUFtNkdpb0lIaEtiWjFKcGs1Yndi?=
 =?utf-8?B?K0pqUjRVbitrbXprb1B2bk40UTd4dDM1NGZhM0V4QWsxVlVsSFlXdXROcUl2?=
 =?utf-8?B?bGdmWEtpSkdGMXlTeTNhektLQUhOelA3UjhrYnJKNEU2c3FxdGZFeTIyM1NS?=
 =?utf-8?B?Q3ZYNGo3cWcxbTNGRkdWZkQ0Q3lIRHlFeVVEUlhDa21ESXVtUE9DazRlNFQv?=
 =?utf-8?B?SGx6dEQxNDIrdzZINHVWS2pMbVBmUHNEanJOUkNhNkhnUlk5K0N1Vzd5R0d5?=
 =?utf-8?B?eGk3Um9jU0xVZi9jTGVLWHAxTHJjYkVEaVBZcUhWSWNQc3V4NGt6ZC9sWmZq?=
 =?utf-8?B?TStKR0pKRUxXL1R2ZzREMnNCdkpFNlpQZEhOWWZlWnd6SzZuOFhvK3F0azZ0?=
 =?utf-8?B?a0NITjhDVEdDK0E4WkdyMFJORDZ2aHF1TjZyakI2YjVIaVpyVFkvN2U2NVFq?=
 =?utf-8?Q?9CLiOSSjdFVYwVfa0pSitDdFq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e94ed20-7cde-4ea4-0076-08dd56225f14
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 04:59:38.2273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gErQgSjUN9LVT6EAatE+rXHXScRs9UzidQG3ioeG/HlbfsT4YDULwKazn32/Vi5GYrdoEoJAKHqrbb4OLV1IFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

On 2025-02-24 9:08, Srinivasan Shanmugam wrote:
> This commit addresses a circular locking dependency in the
> svm_range_cpu_invalidate_pagetables function. The function previously
> held a lock while determining whether to perform an unmap or eviction
> operation, which could lead to deadlocks.
>
> v2: To resolve this issue, the allocation of the process context buffer
> (`proc_ctx_bo`) has been moved from the `add_queue_mes` function to
> the `pqm_create_queue` function. This change ensures that the buffer
> is allocated only when the first queue for a process is created and
> only if the Micro Engine Scheduler (MES) is enabled. (Felix)
>
> Fixes the below:
>
> [  223.418794] ======================================================
> [  223.418820] WARNING: possible circular locking dependency detected
> [  223.418845] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
> [  223.418869] ------------------------------------------------------
> [  223.418889] kfdtest/3939 is trying to acquire lock:
> [  223.418906] ffff8957552eae38 (&dqm->lock_hidden){+.+.}-{3:3}, at: evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.419302]
>                but task is already holding lock:
> [  223.419303] ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
> [  223.419447] Console: switching to colour dummy device 80x25
> [  223.419477] [IGT] amd_basic: executing
> [  223.419599]
>                which lock already depends on the new lock.
>
> [  223.419611]
>                the existing dependency chain (in reverse order) is:
> [  223.419621]
>                -> #2 (&prange->lock){+.+.}-{3:3}:
> [  223.419636]        __mutex_lock+0x85/0xe20
> [  223.419647]        mutex_lock_nested+0x1b/0x30
> [  223.419656]        svm_range_validate_and_map+0x2f1/0x15b0 [amdgpu]
> [  223.419954]        svm_range_set_attr+0xe8c/0x1710 [amdgpu]
> [  223.420236]        svm_ioctl+0x46/0x50 [amdgpu]
> [  223.420503]        kfd_ioctl_svm+0x50/0x90 [amdgpu]
> [  223.420763]        kfd_ioctl+0x409/0x6d0 [amdgpu]
> [  223.421024]        __x64_sys_ioctl+0x95/0xd0
> [  223.421036]        x64_sys_call+0x1205/0x20d0
> [  223.421047]        do_syscall_64+0x87/0x140
> [  223.421056]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  223.421068]
>                -> #1 (reservation_ww_class_mutex){+.+.}-{3:3}:
> [  223.421084]        __ww_mutex_lock.constprop.0+0xab/0x1560
> [  223.421095]        ww_mutex_lock+0x2b/0x90
> [  223.421103]        amdgpu_amdkfd_alloc_gtt_mem+0xcc/0x2b0 [amdgpu]
> [  223.421361]        add_queue_mes+0x3bc/0x440 [amdgpu]
> [  223.421623]        unhalt_cpsch+0x1ae/0x240 [amdgpu]
> [  223.421888]        kgd2kfd_start_sched+0x5e/0xd0 [amdgpu]
> [  223.422148]        amdgpu_amdkfd_start_sched+0x3d/0x50 [amdgpu]
> [  223.422414]        amdgpu_gfx_enforce_isolation_handler+0x132/0x270 [amdgpu]
> [  223.422662]        process_one_work+0x21e/0x680
> [  223.422673]        worker_thread+0x190/0x330
> [  223.422682]        kthread+0xe7/0x120
> [  223.422690]        ret_from_fork+0x3c/0x60
> [  223.422699]        ret_from_fork_asm+0x1a/0x30
> [  223.422708]
>                -> #0 (&dqm->lock_hidden){+.+.}-{3:3}:
> [  223.422723]        __lock_acquire+0x16f4/0x2810
> [  223.422734]        lock_acquire+0xd1/0x300
> [  223.422742]        __mutex_lock+0x85/0xe20
> [  223.422751]        mutex_lock_nested+0x1b/0x30
> [  223.422760]        evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.423025]        kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
> [  223.423285]        kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
> [  223.423540]        svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
> [  223.423807]        __mmu_notifier_invalidate_range_start+0x1f5/0x250
> [  223.423819]        copy_page_range+0x1e94/0x1ea0
> [  223.423829]        copy_process+0x172f/0x2ad0
> [  223.423839]        kernel_clone+0x9c/0x3f0
> [  223.423847]        __do_sys_clone+0x66/0x90
> [  223.423856]        __x64_sys_clone+0x25/0x30
> [  223.423864]        x64_sys_call+0x1d7c/0x20d0
> [  223.423872]        do_syscall_64+0x87/0x140
> [  223.423880]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  223.423891]
>                other info that might help us debug this:
>
> [  223.423903] Chain exists of:
>                  &dqm->lock_hidden --> reservation_ww_class_mutex --> &prange->lock
>
> [  223.423926]  Possible unsafe locking scenario:
>
> [  223.423935]        CPU0                    CPU1
> [  223.423942]        ----                    ----
> [  223.423949]   lock(&prange->lock);
> [  223.423958]                                lock(reservation_ww_class_mutex);
> [  223.423970]                                lock(&prange->lock);
> [  223.423981]   lock(&dqm->lock_hidden);
> [  223.423990]
>                 *** DEADLOCK ***
>
> [  223.423999] 5 locks held by kfdtest/3939:
> [  223.424006]  #0: ffffffffb82b4fc0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_process+0x1387/0x2ad0
> [  223.424026]  #1: ffff89575eda81b0 (&mm->mmap_lock){++++}-{3:3}, at: copy_process+0x13a8/0x2ad0
> [  223.424046]  #2: ffff89575edaf3b0 (&mm->mmap_lock/1){+.+.}-{3:3}, at: copy_process+0x13e4/0x2ad0
> [  223.424066]  #3: ffffffffb82e76e0 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}, at: copy_page_range+0x1cea/0x1ea0
> [  223.424088]  #4: ffff8957556b83b0 (&prange->lock){+.+.}-{3:3}, at: svm_range_cpu_invalidate_pagetables+0x9d/0x850 [amdgpu]
> [  223.424365]
>                stack backtrace:
> [  223.424374] CPU: 0 UID: 0 PID: 3939 Comm: kfdtest Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
> [  223.424392] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  223.424401] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS PRO WIFI/X570 AORUS PRO WIFI, BIOS F36a 02/16/2022
> [  223.424416] Call Trace:
> [  223.424423]  <TASK>
> [  223.424430]  dump_stack_lvl+0x9b/0xf0
> [  223.424441]  dump_stack+0x10/0x20
> [  223.424449]  print_circular_bug+0x275/0x350
> [  223.424460]  check_noncircular+0x157/0x170
> [  223.424469]  ? __bfs+0xfd/0x2c0
> [  223.424481]  __lock_acquire+0x16f4/0x2810
> [  223.424490]  ? srso_return_thunk+0x5/0x5f
> [  223.424505]  lock_acquire+0xd1/0x300
> [  223.424514]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.424783]  __mutex_lock+0x85/0xe20
> [  223.424792]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.425058]  ? srso_return_thunk+0x5/0x5f
> [  223.425067]  ? mark_held_locks+0x54/0x90
> [  223.425076]  ? evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.425339]  ? srso_return_thunk+0x5/0x5f
> [  223.425350]  mutex_lock_nested+0x1b/0x30
> [  223.425358]  ? mutex_lock_nested+0x1b/0x30
> [  223.425367]  evict_process_queues_cpsch+0x43/0x210 [amdgpu]
> [  223.425631]  kfd_process_evict_queues+0x8a/0x1d0 [amdgpu]
> [  223.425893]  kgd2kfd_quiesce_mm+0x43/0x90 [amdgpu]
> [  223.426156]  svm_range_cpu_invalidate_pagetables+0x4a7/0x850 [amdgpu]
> [  223.426423]  ? srso_return_thunk+0x5/0x5f
> [  223.426436]  __mmu_notifier_invalidate_range_start+0x1f5/0x250
> [  223.426450]  copy_page_range+0x1e94/0x1ea0
> [  223.426461]  ? srso_return_thunk+0x5/0x5f
> [  223.426474]  ? srso_return_thunk+0x5/0x5f
> [  223.426484]  ? lock_acquire+0xd1/0x300
> [  223.426494]  ? copy_process+0x1718/0x2ad0
> [  223.426502]  ? srso_return_thunk+0x5/0x5f
> [  223.426510]  ? sched_clock_noinstr+0x9/0x10
> [  223.426519]  ? local_clock_noinstr+0xe/0xc0
> [  223.426528]  ? copy_process+0x1718/0x2ad0
> [  223.426537]  ? srso_return_thunk+0x5/0x5f
> [  223.426550]  copy_process+0x172f/0x2ad0
> [  223.426569]  kernel_clone+0x9c/0x3f0
> [  223.426577]  ? __schedule+0x4c9/0x1b00
> [  223.426586]  ? srso_return_thunk+0x5/0x5f
> [  223.426594]  ? sched_clock_noinstr+0x9/0x10
> [  223.426602]  ? srso_return_thunk+0x5/0x5f
> [  223.426610]  ? local_clock_noinstr+0xe/0xc0
> [  223.426619]  ? schedule+0x107/0x1a0
> [  223.426629]  __do_sys_clone+0x66/0x90
> [  223.426643]  __x64_sys_clone+0x25/0x30
> [  223.426652]  x64_sys_call+0x1d7c/0x20d0
> [  223.426661]  do_syscall_64+0x87/0x140
> [  223.426671]  ? srso_return_thunk+0x5/0x5f
> [  223.426679]  ? common_nsleep+0x44/0x50
> [  223.426690]  ? srso_return_thunk+0x5/0x5f
> [  223.426698]  ? trace_hardirqs_off+0x52/0xd0
> [  223.426709]  ? srso_return_thunk+0x5/0x5f
> [  223.426717]  ? syscall_exit_to_user_mode+0xcc/0x200
> [  223.426727]  ? srso_return_thunk+0x5/0x5f
> [  223.426736]  ? do_syscall_64+0x93/0x140
> [  223.426748]  ? srso_return_thunk+0x5/0x5f
> [  223.426756]  ? up_write+0x1c/0x1e0
> [  223.426765]  ? srso_return_thunk+0x5/0x5f
> [  223.426775]  ? srso_return_thunk+0x5/0x5f
> [  223.426783]  ? trace_hardirqs_off+0x52/0xd0
> [  223.426792]  ? srso_return_thunk+0x5/0x5f
> [  223.426800]  ? syscall_exit_to_user_mode+0xcc/0x200
> [  223.426810]  ? srso_return_thunk+0x5/0x5f
> [  223.426818]  ? do_syscall_64+0x93/0x140
> [  223.426826]  ? syscall_exit_to_user_mode+0xcc/0x200
> [  223.426836]  ? srso_return_thunk+0x5/0x5f
> [  223.426844]  ? do_syscall_64+0x93/0x140
> [  223.426853]  ? srso_return_thunk+0x5/0x5f
> [  223.426861]  ? irqentry_exit+0x6b/0x90
> [  223.426869]  ? srso_return_thunk+0x5/0x5f
> [  223.426877]  ? exc_page_fault+0xa7/0x2c0
> [  223.426888]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  223.426898] RIP: 0033:0x7f46758eab57
> [  223.426906] Code: ba 04 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 41 89 c0 85 c0 75 2c 64 48 8b 04 25 10 00
> [  223.426930] RSP: 002b:00007fff5c3e5188 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> [  223.426943] RAX: ffffffffffffffda RBX: 00007f4675f8c040 RCX: 00007f46758eab57
> [  223.426954] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
> [  223.426965] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [  223.426975] R10: 00007f4675e81a50 R11: 0000000000000246 R12: 0000000000000001
> [  223.426986] R13: 00007fff5c3e5470 R14: 00007fff5c3e53e0 R15: 00007fff5c3e5410
> [  223.427004]  </TASK>
>
> Fixes: 3e5199134e47 ("drm/amdkfd: pause autosuspend when creating pdd")
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Cc: Yunxiang Li <Yunxiang.Li@amd.com>
> Cc: Philip Yang <Philip.Yang@amd.com>
> Cc: Alex Sierra <alex.sierra@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
> v3: Fix typo s/Memory Execution Scheduler (MES)/Micro Engine Scheduler (Lijo).
> v4: Corrected Execution to Engine
> v5: Fix intendation in (pqm_create_queue)
>
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c    | 15 ---------------
>  .../drm/amd/amdkfd/kfd_process_queue_manager.c   | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 195085079eb2..94b1ac8a4735 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -207,21 +207,6 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>  	if (!down_read_trylock(&adev->reset_domain->sem))
>  		return -EIO;
>  
> -	if (!pdd->proc_ctx_cpu_ptr) {
> -		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
> -				AMDGPU_MES_PROC_CTX_SIZE,
> -				&pdd->proc_ctx_bo,
> -				&pdd->proc_ctx_gpu_addr,
> -				&pdd->proc_ctx_cpu_ptr,
> -				false);
> -		if (r) {
> -			dev_err(adev->dev,
> -				"failed to allocate process context bo\n");
> -			return r;
> -		}
> -		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
> -	}
> -
>  	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>  	queue_input.process_id = pdd->pasid;
>  	queue_input.page_table_base_addr =  qpd->page_table_base;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index d7947311cbbd..93647ee27325 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -363,10 +363,26 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  	if (retval != 0)
>  		return retval;
>  
> +	/* Register process if this is the first queue */
>  	if (list_empty(&pdd->qpd.queues_list) &&
>  	    list_empty(&pdd->qpd.priv_queue_list))
>  		dev->dqm->ops.register_process(dev->dqm, &pdd->qpd);
>  
> +	/* Allocate proc_ctx_bo only if MES is enabled and this is the first queue */
> +	if (!pdd->proc_ctx_cpu_ptr && dev->kfd->shared_resources.enable_mes) {
> +		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
> +						     AMDGPU_MES_PROC_CTX_SIZE,
> +						     &pdd->proc_ctx_bo,
> +						     &pdd->proc_ctx_gpu_addr,
> +						     &pdd->proc_ctx_cpu_ptr,
> +						     false);
> +		if (retval) {
> +			dev_err(dev->adev->dev, "failed to allocate process context bo\n");
> +			return retval;
> +		}
> +		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
> +	}
> +
>  	pqn = kzalloc(sizeof(*pqn), GFP_KERNEL);
>  	if (!pqn) {
>  		retval = -ENOMEM;
