Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD05CD4F24
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 18:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FC410E255;
	Tue, 12 May 2026 18:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oAfJ0ugw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6467C10E032
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 18:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VolptjHosEpnmh0smb/o0wZcKsiZV5Z4/TcEFzOldMnP2GwOLSRZ0lGrgQTr+GCigC4jfTHePtswZWIWxQaangjoSPMGHSbb8mJO+zgzoTjPQJrYnfFuKLF8buadAIAMoaUJVMECln5A5IKpshf8yVLwLgbHKSEun7iW/SlJt7SoVZLXuSqVmFX0PgJX22WOmooapzNV599ojXdif7hJtTX7aaEIc40MJJeBB+eVQkttyc/L/gDMrs/cBWggjWZY5amACGPGa/l7mRyMJD0UKg4bd/ciXXEYLXyby03DkBJ5tOtGsXl5bEw+1Ok1P9zgDMXwK6QbZGMzr/4X+llziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0o1ncRXpulYzRwxe1e6AU2dEzpZqgS1V9zktM6Of+o=;
 b=lwd7H0Z0x/i4z59+iqgwRHYU+t5aDW2Nh89Dm98yVCzmBSpbNkmM+yKhUfyNv5A03XNbDyU3rIFsV8qCyvZG0Mays42qhiiSZ3mIY3bpFgHyjBypzjCHfUdRBpuk/qMT79dcSGd13RJJMXSeZeg4j0tO4+jv+IE3aO2JHizHlkqoK1nh/TxO8qo52hcjYzTv4nshQVz+Az0P7/AKwhqK+MfJiSm0IyIGWFTlntFQRg+yAK5bSVS2+nASeQ+A9ZZtYTUOd2KmeilFpK63B6kVn5KSaWawlKpTaYBrLfETJCzS/cudpEIJ89ESQbHI2IzelnCVIYvsqIOLGJzxY/0D3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0o1ncRXpulYzRwxe1e6AU2dEzpZqgS1V9zktM6Of+o=;
 b=oAfJ0ugwHWASeu0dsAIG7Np6p1K8k5Zkr8KcelTtI5bBHcOXdfyQIkZV42GQ1Oyb1IncZ6cgHVnoBxRLb5oRFh9GtGBSrdUMQwsEm3wpab3pwN/q/FljmBMdqm5X/oupNBBfz1Ah/iQeaJjDDS+Gm2vrca7P49nCHiDBpalokqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 18:26:25 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::715:65fb:c3fa:9c26%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 18:26:25 +0000
Content-Type: multipart/alternative;
 boundary="------------Or0F5jfjjP0sTN91ZZJ8rsUX"
Message-ID: <1baa9f2c-e282-4617-9c47-61c3f7fa40e0@amd.com>
Date: Tue, 12 May 2026 14:26:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: fix amdgpu_hmm_range_get_pages
To: christian.koenig@amd.com, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20260512162711.51118-1-christian.koenig@amd.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20260512162711.51118-1-christian.koenig@amd.com>
X-ClientProxiedBy: YQBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::10)
 To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: b685879c-2350-4a0f-0550-08deb053f9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799003|56012099003|8096899003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1XCwWqCZjFeANRJaCqwT5xuT2dKr0xvd2yEtc8SHHAiIyFpYZtlJnBUC/VD55obG5CZeHGNh91JO4agSckEsWfkq84g5dJpTEKz42fyfy29kQkEWcEXaNX6zBRq6W1jrCbXZN54u5HLSdLgZYfz/omiulCaQpTrB/r/+4qsvbfHnZpJMVuMuGK9AQVNaXmQXNHBTIOkJ2/Fd6pRuuCWQ6cL6vFvat8rDEwyhYCxlDE3bMSsDbB4Oq1rl9e1IZxE9i2f1t6vEoTdXZK9X0mgOh9mndWsgXeYOamDjlG5zBVdZcLExJi8RWk5pMz56GnpJGvUjqu8Cjc1stqz4JsnIpBduQD6NzUNYZneBT96lK2WXPOV1g0GSC/1gM0FVP+Qg89vhTudwi1XWMyf2Y5RjSkmg3F5RyFZc0BSzwDwQkZSMFdrMjEmv7G/ZP+KexQqanKXYmq1nmalcQS/NPQ9dniZKQ41kegMfAJpOxUP9GniLS3sgta2WZnF3lsSCYSNyHxq9IwdUOqMgoLYvuh9ajaqrpLGVFgvFoQBcrJswnr6rUlozYtNL1lSlmDXIXc2h2LSpScNDuPc/Tg3mdc4CT+NIA2gBDF8l//zG4d9mA4/ltG6TI5TlewPcm5j/r+MQWzBHKSbWQ/BPH4JfmIIybbhhHwMqKiGvnHl7juLZPJfgan4aBIsxUHFviWWTZnSa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(56012099003)(8096899003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWdheVJ1OFI3VVZYdlZBNFVUSUtOdTBsbWYybEtES09SeExXR3JKcGd3cFRX?=
 =?utf-8?B?QWd3bmpFR21UZWJPV3p3a05vZlVBVFYxTFJDWjRLY0VBVEZORFMyanFRZ3RY?=
 =?utf-8?B?RVFwc1lCMms5cm8xTitZZFptRkdkWlFJemVDNm5hdDlVRTJmTDd5Z2N6Z2Fi?=
 =?utf-8?B?UnBSV253WDF5K1RQS0IwQ2loM29UTTBicnFNR25ydEtCTW1GR1g2TTdQdUV2?=
 =?utf-8?B?aEc5SUNBRlA2TGdFOEY3dStDbDZwUE5CN0Njay9rQ29LaU0rZmVadnQvTEt0?=
 =?utf-8?B?cGNkVmo3OU9ndUxmSWRPMXZmaENIRkhvRUxPRmtHVjVtSzl3eUM0TUpKdkNk?=
 =?utf-8?B?MUJjdDZhNEZKcEtqb3JHMEdJUXN5ZE12dFhLRk9ac2lIR2xVZHpvRlFNaGM4?=
 =?utf-8?B?bU4xVjVGeUJOd2EyS0FsTjFJZTBQczNGb0dRM0xqcVBOM2p3NHA3MEVWcE8y?=
 =?utf-8?B?Y0o1Zm9zcjVLZkhZbFZDL095WUJ1VmdqL3hQalhaT3VmWHhiY21JTVJvNXNZ?=
 =?utf-8?B?bUwycHR5TVNpbkIzdGZTcmorazZ0M0dVa0R5QU8zeWd2WlBPamFjNmVoNnlk?=
 =?utf-8?B?OTk5cnZkdU93L3dGdWVMcnBWc1lEczlLQjFvVzVFUk12ZjNaSTh5MEQxSFVH?=
 =?utf-8?B?MmNZQm1hKzRMenJ5bVVRQUJRUCtNUG9uU2orSDdoUDFQN1dKYitjS3lGeGF1?=
 =?utf-8?B?QmJyRjhGQy9vU0dxdWhzamxQbEFFMXhZcmlRWWtKRWNRNmQ5Z3B3c3V3T2Q3?=
 =?utf-8?B?TVBUUWRoeDNiWVEwc2tPNnpuMkRrVFlMVkpVcy9aaVE1TVJSbHp0MVZzMXVm?=
 =?utf-8?B?M0h0NXRMV3l0T2NvbTlqNkJNR0hkaVovUGV1SlAycXVZY1pXVGZ4Y1RnNk9R?=
 =?utf-8?B?QmtFWm9zT1VWbm5taVpzQzVxSVIvMXVHaWxYd0VvL3EveldaenpBMTl5Y256?=
 =?utf-8?B?Y1JjRXJDNFJ3ZUg4VllxZHdmRm4xNHJ5VUhUS25oeTcvUGtZdEZyblNlM3Vw?=
 =?utf-8?B?aTU0dW5NODJVSkkxMG1rS3NzcmFDSStZRjF2RVExbE9sOTBiZThjZ2lBVitn?=
 =?utf-8?B?N1ZJaGN6UXdFcm9vMUQxVjFRMDcwcGNOZ3JzWGFCSFdTTUVLUHQyamxueXA0?=
 =?utf-8?B?RWVmdkM2MmtqMFFxWVRmTnZuV09RcndnRmdBQUN0QWVGcWJQN3lHbUl5bHcx?=
 =?utf-8?B?OWFSbGhrdGo5V0R4cnVoRW95UGpLYWo1K2gwbVA1M2hMUVZ0NFh5bnVvbys0?=
 =?utf-8?B?clp5Ky9GdkR6UU93V0s3UmgvbWcxOVdUek92ZkxLdnFQdFEvNmYyM1NFaTFM?=
 =?utf-8?B?Y3RkRFB5Tkw0NWUyV1VML2JtOFpZZHhpN2laT2xmU0x0ZXhJMTRBRVBrdERm?=
 =?utf-8?B?MG9KZzFaeDhvTytlL0hUNDc4SktyTjRrMTE4TWlXbHE0NHNoQ2pMNEUyc2Ir?=
 =?utf-8?B?SDYwSDZrbnc1Wk1VUmZjUldBWlpnb2d5NHVQM1V0UWVBK29XNVlRLzhUMXZh?=
 =?utf-8?B?RTdpZmZWd0t2NUF4bVJtV0RucXZGeXBKQ0RzMVZTQnU1ZWtTa2M2WWUzNGxJ?=
 =?utf-8?B?c3FJY0t6MGJnOHBTYTh0VXpQeVJOL1VwSHNFWUhuMng1WlFpaE9WN1NNalFx?=
 =?utf-8?B?NHZHbFg0RTkrS25PUEFuUXp2OVBJVGUzemlKL2U5NFZsdEJEbG1LWUhTTUN1?=
 =?utf-8?B?ZFFURCtkZEpDdmdHMlJhV3JmTTF2YS9HQkNiNTJxS1V3Q0RyL3YrUDVwSzUr?=
 =?utf-8?B?LzNBTkZwVFB3UXUzVXNuY0ZVaUdNOVM4TmI0ZWgvak1LcnphdmpFMDNHMXJ0?=
 =?utf-8?B?cDhiWWtoUHJiTkNzV2J0VXRHN3FFdGN0V0pKWWVMSjBBL1NpNWV2aXJZTGtw?=
 =?utf-8?B?Q3hiUzlKaEdiT3lLZ25NV2pKc1FoaU80cWViUE5VZ05ydFA5aTFMSTl6bis0?=
 =?utf-8?B?RWdmZDF6WkVxU1JRcWJSd0MxaUZtbkUxNzFURk5FU3VFSy9YemFONUYzUlgx?=
 =?utf-8?B?cHYrYWQ1TDVQZEJPS2RRWnErcDlEUnM3ald1bjZKdWo1bEpkd1dNWStWMFU4?=
 =?utf-8?B?WHBsQ2RGUStIc1pOSkJFVzVzeDRiUm1lSmxMMFV4SnpPMDAwT2RrVXNFdDZI?=
 =?utf-8?B?NVozd2RIRUs4cjVadklyZGVuNUlWN3RlV0RQWUpVb3dMSlcySWFaUGl5Vlpj?=
 =?utf-8?B?MDhwVnZVLzN0alBvNmhvR3R3NFp0QkVoK1k4R1Nrd0NXNzJQTlhjOEl4MDRx?=
 =?utf-8?B?WTcxZzBJekhFT0Y3V3RWbVYrc1BTZ0YwT05rcWk2cnI3L1NyZTBwelRNV3V2?=
 =?utf-8?B?ZU94T044ck1lT1pGbzVTc0k4MmcrMzF4a2dmbC9BbWpCZFhRbmhIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b685879c-2350-4a0f-0550-08deb053f9c0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 18:26:25.4206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6Xx2Z/xasieuUAWFlvNR8s4jvT8e2XRJ5aUxyvFHzQLahTsSF7cvjg2Zc4Hd1KC/vjmyZCQUwPOhQBSFG9ubw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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

--------------Or0F5jfjjP0sTN91ZZJ8rsUX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Series is:
Reviewed-by: Vitaly Prosyak vitaly.prosyak@amd.com
Tested-by: Vitaly Prosyak vitaly.prosyak@amd.com

On 2026-05-12 12:27, Christian König wrote:
> The notifier sequence must only be read once or otherwise we could work
> with invalid pages.
>
> While at it also fix the coding style, e.g. drop the pre-initialized
> return value and use the common define for 2G range.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 90d26d820bac..eb470e252399 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -51,8 +51,6 @@
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_hmm.h"
>  
> -#define MAX_WALK_BYTE	(2UL << 30)
> -
>  /**
>   * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
>   *
> @@ -170,11 +168,13 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       void *owner,
>  			       struct amdgpu_hmm_range *range)
>  {
> -	unsigned long end;
> +	const u64 max_bytes = SZ_2G;
> +
> +	struct hmm_range *hmm_range = &range->hmm_range;
>  	unsigned long timeout;
>  	unsigned long *pfns;
> -	int r = 0;
> -	struct hmm_range *hmm_range = &range->hmm_range;
> +	unsigned long end;
> +	int r;
>  
>  	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>  	if (unlikely(!pfns)) {
> @@ -191,8 +191,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	end = start + npages * PAGE_SIZE;
>  	hmm_range->dev_private_owner = owner;
>  
> +	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>  	do {
> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
> +		hmm_range->end = min(hmm_range->start + max_bytes, end);
>  
>  		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>  			hmm_range->start, hmm_range->end);
> @@ -200,7 +201,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>  
>  retry:
> -		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
>  		r = hmm_range_fault(hmm_range);
>  		if (unlikely(r)) {
>  			if (r == -EBUSY && !time_after(jiffies, timeout))
> @@ -210,7 +210,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  
>  		if (hmm_range->end == end)
>  			break;
> -		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
> +		hmm_range->hmm_pfns += max_bytes >> PAGE_SHIFT;
>  		hmm_range->start = hmm_range->end;
>  	} while (hmm_range->end < end);
>  
--------------Or0F5jfjjP0sTN91ZZJ8rsUX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Series is:<br data-sfc-root="c" data-sfc-pl="|[]" data-sfc-cb="" data-complete="true" data-copy-service-computed-style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);" style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);">
      Reviewed-by: Vitaly Prosyak <span class="T286Pc" data-sfc-cp="" data-sfc-root="c" data-sfc-cb="" data-complete="true" data-copy-service-computed-style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);" style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);"><a class="moz-txt-link-abbreviated" href="mailto:vitaly.prosyak@amd.com">vitaly.prosyak@amd.com</a></span><br data-sfc-root="c" data-sfc-pl="|[]" data-sfc-cb="" data-complete="true" data-copy-service-computed-style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);" style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);
 ">
      Tested-by: Vitaly Prosyak <span class="T286Pc" data-sfc-cp="" data-sfc-root="c" data-sfc-cb="" data-complete="true" data-copy-service-computed-style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);" style="font-family: Google Sans, Arial, sans-serif; font-size: 16px; font-weight: 400; margin: 0px; text-decoration: none; border-bottom: 0px rgb(10, 10, 10);"><a class="moz-txt-link-abbreviated" href="mailto:vitaly.prosyak@amd.com">vitaly.prosyak@amd.com</a></span><span></span></p>
    <div class="moz-cite-prefix">On 2026-05-12 12:27, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260512162711.51118-1-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">The notifier sequence must only be read once or otherwise we could work
with invalid pages.

While at it also fix the coding style, e.g. drop the pre-initialized
return value and use the common define for 2G range.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 90d26d820bac..eb470e252399 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -51,8 +51,6 @@
 #include &quot;amdgpu_amdkfd.h&quot;
 #include &quot;amdgpu_hmm.h&quot;
 
-#define MAX_WALK_BYTE	(2UL &lt;&lt; 30)
-
 /**
  * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
  *
@@ -170,11 +168,13 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       void *owner,
 			       struct amdgpu_hmm_range *range)
 {
-	unsigned long end;
+	const u64 max_bytes = SZ_2G;
+
+	struct hmm_range *hmm_range = &amp;range-&gt;hmm_range;
 	unsigned long timeout;
 	unsigned long *pfns;
-	int r = 0;
-	struct hmm_range *hmm_range = &amp;range-&gt;hmm_range;
+	unsigned long end;
+	int r;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
 	if (unlikely(!pfns)) {
@@ -191,8 +191,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	end = start + npages * PAGE_SIZE;
 	hmm_range-&gt;dev_private_owner = owner;
 
+	hmm_range-&gt;notifier_seq = mmu_interval_read_begin(notifier);
 	do {
-		hmm_range-&gt;end = min(hmm_range-&gt;start + MAX_WALK_BYTE, end);
+		hmm_range-&gt;end = min(hmm_range-&gt;start + max_bytes, end);
 
 		pr_debug(&quot;hmm range: start = 0x%lx, end = 0x%lx&quot;,
 			hmm_range-&gt;start, hmm_range-&gt;end);
@@ -200,7 +201,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 
 retry:
-		hmm_range-&gt;notifier_seq = mmu_interval_read_begin(notifier);
 		r = hmm_range_fault(hmm_range);
 		if (unlikely(r)) {
 			if (r == -EBUSY &amp;&amp; !time_after(jiffies, timeout))
@@ -210,7 +210,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 
 		if (hmm_range-&gt;end == end)
 			break;
-		hmm_range-&gt;hmm_pfns += MAX_WALK_BYTE &gt;&gt; PAGE_SHIFT;
+		hmm_range-&gt;hmm_pfns += max_bytes &gt;&gt; PAGE_SHIFT;
 		hmm_range-&gt;start = hmm_range-&gt;end;
 	} while (hmm_range-&gt;end &lt; end);
 
</pre>
    </blockquote>
  </body>
</html>

--------------Or0F5jfjjP0sTN91ZZJ8rsUX--
