Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAD606A326
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rnKrNl+U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3B110E8B3;
	Thu, 19 Nov 2026 14:27:06 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010034.outbound.protection.outlook.com [52.101.56.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 974F610E8B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 14:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBtxUrCO6F+G5yJC7Y0mKbdc/VDGCFHfbkU189ceI7n+kucIzbvVpcRFTx6zoVoJHUZFDcUjdDK+0DDNzlDEVT0jAcpvEmOd6Ru6Qw8oQXh7uAMx7gRiGsz8egUkisjGx2qENEoreuuHEfQ0u56iq4PJJQncMqEjBRE8duX11Amb778GnDVj3dK8SqBLEjzjQdXdggcG2LKq9Dx0+/RDlO+Qpp6TCHlGnexRrs7y6r9J3WnLoynpbxVWZcA1WnTSUg8bD4GjzWc9C3RNTjj9RjmWqAtsQ7yt4HcT4dBW4hMgmgEEVMysWo5sEujCDa6nYi33AffECd9fHKKhFYtJFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5vvDhIG8EDDiXq/Noeq30pMXZxdvwed2eNprZli2xE=;
 b=dAO7sqDqn6Bk4lGawOlbiwn+5NADfXy37KZjN0wJI7OQH9rGW6aVAMz/46qg1GhhkCV8pkUeegvUGgQM0bIg5wjYRtJRjuuY/ne7ML4ZEmnUJzajrlC7XwS2Rmti4nmG71lOtlKzcQszacBK274n0rmWWYlUz1CUoU/LUeaH3SK4Qn1wtmZwKEd32MdCW36GjUpwhJE45QQzJBdGIk7AEShYkZs0o1fGf2dKJnv744y7tJfF/xciDsBvp7ZzialpzZE6O1eacsiRhQ5IVJpSc80KamMlk6a96AlNDDkr6JmTlQ/YdDobWO+KGLgfvIVCVcv3wgOWvtwUa1L5DHgpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5vvDhIG8EDDiXq/Noeq30pMXZxdvwed2eNprZli2xE=;
 b=rnKrNl+U5UQg1mLrrjffI0fGL45l/6ESUaDXucvjgZUzaBa+RAzWBz3vcJTqQbVJhZSMlMyL8VEK3PZc9/zhkLp5cnjUt9A7Be8/ACWS4trrC72PAzU/USW6dgorJcs+zKPAiwdczA6c3Xzx1aLZ/h6JDjlQRE05vEUPch70bhI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 14:26:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 14:26:55 +0000
Message-ID: <bb947411-4391-4d38-8200-41afe87d0d84@amd.com>
Date: Thu, 19 Nov 2026 15:26:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/amdkfd: don't stall other threads during large
 userptr registration
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, Felix.Kuehling@amd.com, philip.yang@amd.com
References: <cover.1795014593.git.William.Palacek@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cover.1795014593.git.William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: ee92d043-04ca-4012-6f3e-08df4649292e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|11063799006|10067099003|56012099006|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: /tf30VSqHJAurdGoyr0+HBJT4OhOxj6ee/Smq3ZOJ78Switjzh5PuXrsAjNkfsfihndz4jnesxjowpo+hKlUu+S6vtPQXxmW8SGCe/OIPsdLizkramVrj51trSOyRBxl4grhCshoBJFiH22LD06OybBYDKbpyIhvZabcydRfGZt14MLp3lcVpgGlW+uwqiVEFCIxypPG57MtRbWgBJzaU33acY9khSultQGLuIjUisMG5riEMOomTOTTV9akF6FAb1fVsJoqk1JzfqyKI03tLgNKGpsqlm+XF8FDdrMRp97yNr7Xcg+gXSixaRVMDbHrc28J/mvnRZ7xpWPeBqGHMGbFtyZbUpydPty17BHkiBTTlyqTJTPwNLT4bMbZTAjV8DLyYzp+QuV+1gCCqIgwNzzCqd/9crehB3RkbJFZMN9znVDlCoZdNn719GBOS5vdS6XjlT2R7zbjAGGP3fnQwmo76oy9/iCLPMfHqdR7JNCpJrp52pF4yX+QaaR/yoc8X2G3YdtDSjweMhMsf2m0xgaqjU3xV0rPb2PfK2lfBlwWYsGKEWEdaFIZgtolBr48iKoXUemZ+o/NG6Y352R9I5kyM6eF0zsAnHXjegjhfGOI2eciF4rlgmzz1Q8zTRSEymeAXSBisVab4kXcIDq5KGSJQ/oTFKB25vSeaXldBVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K29LRjNlMndmS1B1NTJ4dTJmMEMyTkpEc21xOElaRndvSVlxbDdlNnpWV2FO?=
 =?utf-8?B?S1kxZXZNRUdoQStYb3M1SFU2SnZRV1E4QmxNVlk2bUhuZ01aZFZiUGxmLzZZ?=
 =?utf-8?B?RzFsY0hrNGxmOFlqcS9xQnlIbUtoUnRLWk5VUUJyci80S2ZJamFGY1NWQUxV?=
 =?utf-8?B?VzlMZ21qV0p3WUp4Y1UyeGp6SW5KdlNWYW9nSGxLamNMUjN4VFhTcEZaaEQy?=
 =?utf-8?B?WExwaGxOWnJuQlZFc3BCQVFNNVVkTWJUVlhEVisvTmhwVWltODRlQWs4bFBh?=
 =?utf-8?B?KzhQc1kvQ254UDJZS2s0T1M4NEM1ZjFHeFZxck9DVmVsY1k5N0VuN0l5WUhZ?=
 =?utf-8?B?NDloM0JZY2FMRmgwVEhydnlGNVRSZ29BV3BHVFI4aXA3QmFrSFB6VnFYK1BM?=
 =?utf-8?B?aTlibnh4bmNIQmEwNmREUmpYR3JHTm96TmxOYkFDT09wUzd3Wjd6WFJXaUVN?=
 =?utf-8?B?MnJTMWJaT1JJdk1QMlI2QmJTZS84KzVyRzJIdHVreXZMbUtSaHVTbVhFTkdO?=
 =?utf-8?B?eWErVngzWDRESTU5MWpMRkw4VjNKbGg3NGUyZlU5WUNmclJkSUEvR2h0UW8y?=
 =?utf-8?B?RW9tVnNZS3F3ZS9lNUxpOW9JQjJ3dUdMdVZjNVRLdkx1S2R3TGlkWXpJNlVp?=
 =?utf-8?B?VFg3cUovL21EMWIwaTRJQmNwQ3AxNVB1RURRbTBQeU9DRGc0aDdUd0F1YUxG?=
 =?utf-8?B?UnVPL1VjaEVCMmlJMFNoTnI4WlZ3MXBvVzUxWkp0R01CTTFFdVVUc2FldmYw?=
 =?utf-8?B?T2VzMERVbEJDV2ZkQSs5YXdXT0ZlRmVOdXQ0ellXeFhlTEZMeEhUbEFnQlA3?=
 =?utf-8?B?Zk0xYm1kOWlnaTJ3RVhURzg3YnJYOEpIanBCZ2NmNjdaMmU4K0tUcVYybUY3?=
 =?utf-8?B?VUFDckdXZFFidHJRRHNSMll6NmRaQ2ZiY05Pak1WVFJ4RTJ5SENiS3dVNll6?=
 =?utf-8?B?Sld4VTZHREdvS2dwU3hzVlhRRkxqblhKemo2T0dVT1NNVDcyNDFIcVFYRGtS?=
 =?utf-8?B?R1NYcHBlRnU4V21IM0xzeTdqN1ZHWGFyckw0QVYxdmxaM2hPaVdZeTF2eWwy?=
 =?utf-8?B?K01DZ3c5VmQ4UUx6ek1jdEV4WDBQNEdNS0N2T1RMYW5kaUtnYjZlSEJBTUdt?=
 =?utf-8?B?b0N5SnFQWjNCVzRQY3RuejFVUkduQXpIVWdRNEdxdkF0Z1NrMTNJNk82ZUF5?=
 =?utf-8?B?OXFUOWFIeEpvSlpKQm5VUnd0VDFSQUF6VzBKTmp5eWZ4NWdjQUlQTm9ybHRl?=
 =?utf-8?B?dmZSalVFeDd1Q05tVVkyRDJteWlydWtCRXh6VkdDek5tVW1kU2hvOFpYVlhi?=
 =?utf-8?B?WmI1eVVLOWhJcitVQmZEcFRaVVpTNWJkcXJMemEzTUtOVGdKc2Z1YmtnSGY0?=
 =?utf-8?B?cno0ZTNsbFBFZ0oyTWVQWnlqbXNGaE92Z2hWcGpNcEVuVjBxdWU4VzZrZXAr?=
 =?utf-8?B?SU16NE9UVng0ejFRWEtpN3ZxWnJ0cnIrM0w2REliYkthZHBxa1dzcE1KMkxF?=
 =?utf-8?B?WVRNblkrQldQaDA2bEdwVkNuK29kTUNmQjBWZ3ZNNkFKUE01dUlpK3ExN09H?=
 =?utf-8?B?bHUrOFpaUU9XZnhXOTJYNjVIZUlrWlhjWng1S2RBOHIzQ3F3NjA5TG50Rk9G?=
 =?utf-8?B?RWJwRERTQm5TRTE5Z3Z6cE1yaVZjdThuM0x6R205a05kRVNZeHBVNnZQdlZQ?=
 =?utf-8?B?R3FnNEdrU1FqbGF2UGZNd09FVWFiTy9BQVZaYXZZdWtoSHUzNjhEQWlJOEkv?=
 =?utf-8?B?WEFYUzduMGRwcVlqNlBGN3BrL1JhSHBlOGtmcFhLWFRMK1lpU2ZCQkkyd0ph?=
 =?utf-8?B?bDJ0ZjgxYlhHaE1TQjV0dlgwK250WE96VTJ5eGdBNjF2c2FvSDVtWnIwczdP?=
 =?utf-8?B?RmJtVG1laUNEejJrc0RCN1FyQ1BIeUJVcmZwMkJXalk0ZVVNY3VkOVFERlRT?=
 =?utf-8?B?Z1ZuczIwVkNZc2lmL1l5REJWMjM3Y1YrUk5KbWVtaWoySUxGSmE3aDg3TFBq?=
 =?utf-8?B?QkhPN3I0VUQrU043a2lldHpCQmFaMjJzcGNBTmpCempBMW9RanNDSUJZcXd1?=
 =?utf-8?B?VG91cVB0NUhaRVhtby9MMUlvMXBRQzk0SDN6Uk9naHEzS1Z2eEMzZUhyUlVD?=
 =?utf-8?B?OTJhM2tYRnp3dGM0Ujk5akoxcmpjZUxsZHhKTTN5YitoUkNaak13L0V5aS92?=
 =?utf-8?B?WnpBZjVhOFl6dXp5dGczS2pDUEdHYUFSOGd3ZEFYNVVJdkp6R2YzV2tIUS9x?=
 =?utf-8?B?SUhBdWhnbnVvWWtVQUpkM3NhaFJRQzNLWXF0WVNaWHRGU0VROG1USDYxaFZz?=
 =?utf-8?Q?VGRtEeJQqYH1NQPsER?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee92d043-04ca-4012-6f3e-08df4649292e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:26:55.0117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfPKboEOPTkGjdi0E2dNS0WqzukMd4LiZ6bwo+fn3oY0YmNH0WUmHAJSrBjIsPu/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 16:10, William Palacek wrote:
> Registering a large userptr BO (hipHostMalloc) holds mmap_lock, p->mutex
> and process_info->lock while every page of the range is faulted in. For
> 32 GiB on MI300X that takes seconds, and every other thread of the
> process that submits GPU work waits behind it for the whole time.
> 
> Patch 1 limits userptr sg segments to half of sg->length. Larger
> physically contiguous segments can overflow the padded segment length in
> iommu_dma_map_sg(), and the pin fails. This already happens without the
> series; patch 3 makes the pages contiguous enough that it hits on a
> freshly booted system, so it goes first.
> 
> Patch 2 drops p->mutex from AMDKFD_IOC_GET_CLOCK_COUNTERS, which other
> threads call while submitting work.
> 
> Patch 3 drops mmap_lock between 2 MiB chunks while faulting userptr
> pages in.
> 
> Patch 4 faults in and validates userptr pages without p->mutex and
> process_info->lock, and adds the BO to the valid list only if no
> invalidation happened meanwhile.

Absolutely clear NAK to the whole approach! Userptrs are fragile enough without this.

That the performance of userptrs isn't the best is expected and won't be fixed.

Regards,
Christian.

> 
> Tested with two 32 GiB hipHostMalloc/hipHostFree cycles next to 4
> PyTorch streams on 2 GPUs, measuring the worst GPU submission latency
> of the other threads (limit 1 s), on the amdgpu 7.2 DKMS driver:
> 
>   MI300X, IOMMU DMA-FQ     unpatched    0/3 (6.1-6.2 s; on other boots
>                                          the 32 GiB pin itself fails)
>                            series       3/3 (0.80-0.95 s)
>   MI300X, IOMMU identity   unpatched    0/3 (9.6-10.1 s)
>                            patches 2-3  0/3 (10.5-11.0 s)
>                            patches 2-4  3/3 (0.81-0.93 s)
>   MI350X, IOMMU identity   unpatched    0/4 (4.55-4.84 s)
>                            series       7/7 (0.21-0.39 s)
> 
> kfdtest KFDMemoryTest.* and KFDEvictTest.* pass on both GPUs.
> 
> William Palacek (4):
>   drm/amdgpu: limit userptr sg segments to half of sg->length
>   drm/amdkfd: don't take p->mutex in AMDKFD_IOC_GET_CLOCK_COUNTERS
>   drm/amdgpu: drop mmap_lock between chunks when faulting userptr pages
>   drm/amdkfd: register userptr pages without holding KFD process locks
> 
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 53 +++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 14 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  9 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 10 +++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
>  7 files changed, 66 insertions(+), 31 deletions(-)
> 

