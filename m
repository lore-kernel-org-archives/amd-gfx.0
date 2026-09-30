Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860CDCA5FC4
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 16:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19A4610E0F8;
	Wed, 30 Sep 2026 16:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CPk8QFLD";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744A510E0F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 16:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukFZQQaNv7A5gofO8+b5amm7YbyJpTV2rud0VtLaTsNphtMq9lWSGqZzDqsMVKr5E79DVBKLUTQRMsZurHk3fQFy0bmGdoJHOy/D26FhgZfnjwit92R8pT/UgF0Lp3mYy3+SNsFP3zVI5hzJutrYSX5SO+RguO1Z1a6Le4sR3bAsoO6S6S1x+65yrRjkW5iM5bNwLCa12SDzwirOMQyw7v7yy4DsH3FucJA2r3gE7KpiG8otVQvZILYjxU/vFQ3XzRBZa+pijrWKJcNL2LHhzlZuH1zD9ZZQuzX2K207NSs0xLFYIypfrjQ2DWGHfdU4mfn56faZyDkMqH+R6MRHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMrCIXjK6eCG40BjkqG/OToN+u6UZvz87x5W/R3qlfI=;
 b=sVIXyd9MoW6wGhRNlrfE7s/3oMOf5ciVS3PHJnoJ2vGR8E/koidrW/0DlaqSYAgmRwWoBlbaWv7DITvazZsRnCBH2Qab5FLWe4ceVd/a86tIV7/l1F67mI1U9gB589U0zNVSVJI4+vLkGYVphYfUV3u6YYEw/lIdTIztUTlMJ2e6jmMSmBEFPM5eEDICRHdygdvmvUMAV7KoKIVV5JwE2HYWlUzh+AS6c274wBZNt1+OpenDkrqyyUvLffcwYqF8ANbs1A7qyS0AehwwypnvNoo4/9BirGmhVz/A6pof80LKKFVMvW60rp61Gry78HyRjXFJdEEv2mbP4MqyT3yG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMrCIXjK6eCG40BjkqG/OToN+u6UZvz87x5W/R3qlfI=;
 b=CPk8QFLDLfk7mN141cD/Jx1WjrmdOI9Xdf3jJqnMgK49wCTP9U7hPd87MZ753xrWV1hi97Vzd9KbFt/9sm+UGnactqELAag1wO7TOBB5xpri+8Z1UTsCiRGX9iTK/JgcOzmJITG72reeK1NJ4bureyLIbCaJLrJajil5Ckh7as8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::668) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 16:30:56 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 16:30:56 +0000
Message-ID: <65743388-5a7f-4dda-afeb-f46b60ed14ff@amd.com>
Date: Wed, 30 Sep 2026 12:30:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] drm/amdgpu: split amdgpu_vm_update_range v3
To: christian.koenig@amd.com, natalie.vock@gmx.de, honghuan@amd.com,
 Alexander.Deucher@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-7-christian.koenig@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260928151041.1857-7-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c94a200-a678-400e-5263-08df1f1033fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|260925022911599003|260925021311599003|10067099003|260925021911599003|56012099006|6133799003|3023799007|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r989pjlyBWirmBKoSNdQ1wfnKeU+owBw1PBXPt9ZtY+TAdaWEzfwCImfEiA2I5Rxr56TytANCzUYFS7CT//+0seaeMsevYb5/OoVSRfchY1ORJxdZHqTXPlZRvgcW8OlZ1VNSKIUTsxulCe0/JHsOMzAtnwd64Uhgl4Qs5/xXLH2QRlrnb+yE0UJ9ffzYFqhgtPJqlo8CXnS9JoxoS6k6SRTonc2Myh7Pu/bUxv8TQrn7q3UO7aYse9rpSX3WngMnuKBRsmiwX8oLfm49A1xpJRyKdhGW7ZbBoqXJlmE7tOg7U+4WsRN0Z3XXUpDxsQmwuwvWjFyukivJvMgsG1HsbvC18VRbo9VhUsJCZ4Xxj/SXYNYVesH+WUlGbkikTOXi499QJosAiSp6qMRVf39PDs+Tudvl22XCD3+6+kEGjwLfzPabCctpY4QBEEynSBZsbxBwnj8tNCcyMkACKxyNIKlsjWRNvasUuOQh70EzdkgaHplxI948WJoamQhPH7IuA0dsIqoy/YNhapI4OaWKu/KoyV8SFZFUPwtP2hkdkEHt4OxfBNFE+hkudjUtPHt2kz7jNmIDiSuEqxd/F2pu56Yz+vXRnc/h+IrUERyAzpg+xrnUqWnehBN/tOfVodEr/+aBkIDWZrA64j5tzQtElzo4rHHmsVZj93n8wiKFIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(260925022911599003)(260925021311599003)(10067099003)(260925021911599003)(56012099006)(6133799003)(3023799007)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zi9QMFhTbEl6Z0RKZlk5NXlDaUhBYTlRcjNZY29kUUYyUUhhNm9RVHFIbUxU?=
 =?utf-8?B?eGlJV3BzU1djRFZheHNPVXhERDVBazhtbUxaRkU3TWowOE50ZzQrbEY3NWhO?=
 =?utf-8?B?ODhKSzZ2eHhmRk1nS0FBcllhYTFSRUtOVjJuTklYSWhFaUs0ZlF1NURmcmlk?=
 =?utf-8?B?bkZQYU9PWTlISzZGRU1Dbk4wWTZGYWVQeUxSMExaTHRHVEVieVVrZDVCWFRv?=
 =?utf-8?B?TU8vKzJZZmZOdWtMME1SeHc3YlRRVFZEOEZENVFGY3BGK2RIUWhlTjUwR1Rl?=
 =?utf-8?B?ZVA4VnhmWUhDRmxBcU5RVzdRKzdQODkrR0RMcjVteGRJU0xTbTBNUUoxeHh6?=
 =?utf-8?B?L0g0LzZXWTlnZ2RBUzlSSlFMNldPam5xMmx0bUdNNncxbVBUSXBGN0dFaGdO?=
 =?utf-8?B?bFFwQWJlOXV3YzIvRjJLNUY0OE9nTk1SKzRSU2dhZnBMUklMYWVuT2h4WHo3?=
 =?utf-8?B?T2hxUWlleTNEZ1ZYM1JlT1VOQ0I4YmN3Q2l0VGc2Y0FiSEJhYWtXNStiTkJy?=
 =?utf-8?B?cy9wMksrMlFhQUlLbllHL0hKU0hORkJWNytNOVV3WjNYRURZWmxqa0FwTUNT?=
 =?utf-8?B?TVdhQnJxdE96RlJROExHS2hMcHJNeVdHT01tUHBKNmJFVklkb05maWF4T1pN?=
 =?utf-8?B?SG9QcFZzYTRsT3Y0WkxmZzd5THIxR1RwVTNubHNIMnBCMVV5VnZ3Vm1oYmU3?=
 =?utf-8?B?Q25HUkhMNUd1bXVOZ25lZE9OQ0lBcTRDQVNhQVhrcU1qM1p1OWxSNHA0aUxx?=
 =?utf-8?B?S2ZtTEZ4R05OR3l2TktyV1lzZXRnTit5VmJycjU3TUhmZHdYQ3RuU3p2Q0Qv?=
 =?utf-8?B?T2dpRU9uN3hqRG1BNVdMczhSd2dsUGF1S25QNG1WYjlvUkhQTUJlQkFXbE5Z?=
 =?utf-8?B?d1hKZE85VzZrMDB2WFd0TFhKSFpvV3Y3TkhZd1FxVjNFYm1SUkFxYjRLekEx?=
 =?utf-8?B?ZitNblM2MndvcFlwRWVoeDBRRUltZDF5cDc1NWdWV0xTemV6WUNySFdFKzlx?=
 =?utf-8?B?OFd6RlFqUUpUajY4L3lXWUcreTIxZVhJZ3NPU1AzbWFVb1g5d0VFVG1XSDZY?=
 =?utf-8?B?ZVhScHc4bnY3SzU4SHhoTEtmUktwRCtOc00wUDljUTBJRGpRanhZT014RGlt?=
 =?utf-8?B?WVlSWnFxOVFaNUd5NGVDeVg4VTdxSHREOXlYV3A2TVhZcU9VTWQwanV0UGx1?=
 =?utf-8?B?N01MZVlpMCs4K3RONlg2VEQ2ak1Jd0VLWlVrVUZ1SHdNYXJkcGZHTkROOTE2?=
 =?utf-8?B?NVFzaHp6R2doVkd2NDEvMGJtRUtSRUNyaUIxbEVmMkNVQU5BWFBHRjluM2tr?=
 =?utf-8?B?RDJFVkVONlZJdm8zYTczWHpjbHFqOWlZbTluZ1ppNGkyK2FoRHpUU3Rxb0w0?=
 =?utf-8?B?RE56dTNYejhFVGlmRE4vVkVFandVaWF5dHh5MFJyNEZUT2dTQUdJc0g1RWNs?=
 =?utf-8?B?N3lSMWV5SmVOVjgwTHJyaWpRVFY1SjQ3VnhoQkEraGVuZHdhY2pCVm1HbVM4?=
 =?utf-8?B?eDBYdlNFV1Z1L1FFSEVoMEw1SHMwVEo2T3JITHpOL1BMbW9rZkw5TDZRdUNB?=
 =?utf-8?B?cjhZVHdhRWtjZS9wK1JFS1VOMmVsSnBYczhQc0R2Y25ueGtYRFhYQ2d3VUt4?=
 =?utf-8?B?Z2U4VnJJcmNWWFlKY0hoeG5JOHNEWEpRYU5TcE41Y0lJeUJCT3dYZmh0dWNm?=
 =?utf-8?B?L3hzOVVqMzVCazhhUXB1b0MzWWRUM0NKeFkwOFo4RG9GVDFNakdlNGFrLzl4?=
 =?utf-8?B?QnRKWG1hSU9ldVEvVXg4Z3BFWmQzL3pQZHpTOGs5b2NqeFJuSDljZVJmZmlu?=
 =?utf-8?B?R09heC9jOUFQb3NsWXpqMGRrTk5scUllKzFKc1VxREdLVGFoTkFMVlVFejlC?=
 =?utf-8?B?dzNmUm9wYjBNYkYvTzRxcTJOTmVTQ1BWU1kzSTJYSEhBdVBKM3JFeXI4OUti?=
 =?utf-8?B?SXgwWkd3anBDS05qSXI5d0hqTVpnNWg3cVh1b0JKZ0xSL3NITk1pUW9OWTRQ?=
 =?utf-8?B?N3puVDM1TE80TURGT0dYOEJTMjdVQXBlOVQ1ZFd6T0hlMTJPKzZDTXllL2ox?=
 =?utf-8?B?MUxHOG1kbStqTm9RczVHaUxReCt3MHNIOTlwbG1wTmJ6UjNkMzVJWXQzOXlp?=
 =?utf-8?B?VGQzQlFVWWwxSTNJTmlSOVIvR3htZXFQdVpEU3NETk5od0RTcnRkaStDdXBY?=
 =?utf-8?B?SDlKUVBMaWUxTnMrSDBwZ3VvdmRzYSt2RWNRRVhkY2R3amRQQWo5UnlJRkV5?=
 =?utf-8?B?NVBha1liMFIvbmwyeHZPMlZLU09uMlllTmh5cURTZ1Y1MVFFVVlWQW1CVWpa?=
 =?utf-8?Q?UJUq0ElyZO6oHbrTTI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c94a200-a678-400e-5263-08df1f1033fa
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:30:56.3269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ma4MCHorh835gCqFwFX3nMDHNUCR3G+E0f185iuXTfHDayThFwYB8JMJEDAX0EvRdAidiuHxPiTK/JaXzuu+uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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

On 2026-09-28 11:10, Christian König wrote:
> Split amdgpu_vm_update_range into two functions.
>
> amdgpu_vm_map_range() is for mapping PTEs into a range and updates
> which can be done while holding the VM lock.
>
> amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
> lock in MMU notifiers.

The naming is a little misleading. As I understand it, 
amdgpu_vm_map_range still supports unmapping for the case that the page 
tables can be locked. In fact, this should be the preferred method for 
anything except MMU notifiers because amdgpu_vm_unmap_range cannot 
allocate or free page tables.

Regards,
   Felix


>
> v2: add unlocked parameter and drop flags
> v3: use correct clear flags
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  50 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 117 +++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  16 ++-
>   .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |  40 ++----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  17 ++-
>   7 files changed, 157 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index ae569b4497f6a..d4a4e51f3b1da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
>   /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
> -#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
>   #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
> @@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
>   #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
>   #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
>   #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
> +#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
>   
>   struct amdgpu_job {
>   	struct drm_sched_job    base;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 899153716b7ef..b7975c77b1fe2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -2056,9 +2056,9 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
>   		return r;
>   	}
>   
> -	r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL, npa_addr,
> -				   npa_addr + size - 1, pte_value, 0, 0, NULL,
> -				   NULL, &vm->last_update);
> +	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
> +				npa_addr + size - 1, pte_value, 0, 0, NULL,
> +				NULL, &vm->last_update);
>   	if (r) {
>   		dev_err(adev->dev,
>   			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
> @@ -2108,10 +2108,10 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
>   		return r;
>   	}
>   
> -	r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL, npa_addr,
> -				   npa_addr + size - 1, pte_flags, offset,
> -				   adev->vm_manager.vram_base_offset,
> -				   bo->tbo.resource, NULL, &vm->last_update);
> +	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
> +				npa_addr + size - 1, pte_flags, offset,
> +				adev->vm_manager.vram_base_offset,
> +				bo->tbo.resource, NULL, &vm->last_update);
>   	if (r) {
>   		dev_warn(adev->dev,
>   			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
> @@ -2645,12 +2645,12 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
>   			"RETRY-RPC: setting PTE.X=1 for NPA:%llx remote:%u pte:0x%llx\n",
>   			npa_addr, remote_acc_id, pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL,
> -					   npa_addr, npa_addr + size - 1,
> -					   pte_flags, 0,
> -					   adev->vm_manager.vram_base_offset,
> -					   bo->tbo.resource, NULL,
> -					   &vm->last_update);
> +		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
> +					npa_addr, npa_addr + size - 1,
> +					pte_flags, 0,
> +					adev->vm_manager.vram_base_offset,
> +					bo->tbo.resource, NULL,
> +					&vm->last_update);
>   
>   		if (r)
>   			dev_warn(adev->dev,
> @@ -2783,10 +2783,10 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
>   			npa_addr, exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
>   			remote_acc_id, pte_value);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL,
> -					   npa_addr, npa_addr + size - 1,
> -					   pte_value, 0, 0, NULL, NULL,
> -					   &vm->last_update);
> +		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
> +					npa_addr, npa_addr + size - 1,
> +					pte_value, 0, 0, NULL, NULL,
> +					&vm->last_update);
>   
>   		if (r)
>   			dev_err(adev->dev,
> @@ -4569,10 +4569,10 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
>   		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
>   		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
>   
> -	r = amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
> -				   npa_in_pages, npa_in_pages + size_in_pages - 1,
> -				   pte_flags, offset, adev->vm_manager.vram_base_offset,
> -				   bo->tbo.resource, NULL, &npa_vm->last_update);
> +	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
> +				npa_in_pages, npa_in_pages + size_in_pages - 1,
> +				pte_flags, offset, adev->vm_manager.vram_base_offset,
> +				bo->tbo.resource, NULL, &npa_vm->last_update);
>   	if (r)
>   		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA VM\n", r,
>   			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
> @@ -4603,10 +4603,10 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
>   		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
>   		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
>   
> -	r = amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
> -				   npa_in_pages, npa_in_pages + size_in_pages - 1,
> -				   pte_flags, offset, 0, bo->tbo.resource, NULL,
> -				   &npa_vm->last_update);
> +	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
> +				npa_in_pages, npa_in_pages + size_in_pages - 1,
> +				pte_flags, offset, 0, bo->tbo.resource, NULL,
> +				&npa_vm->last_update);
>   	if (r)
>   		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from NPA VM\n", r,
>   			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index cc6c419ff6fa2..77ddb7fa96fb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1101,11 +1101,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>   }
>   
>   /**
> - * amdgpu_vm_update_range - update a range in the vm page table
> + * amdgpu_vm_map_range - map something to a range in the vm page tables
>    *
>    * @adev: amdgpu_device pointer to use for commands
>    * @vm: the VM to update the range
> - * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
>    * @allow_override: change MTYPE for local NUMA nodes
>    * @sync: fences we need to sync to
> @@ -1118,23 +1117,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
>    * @pages_addr: DMA addresses to use for mapping
>    * @fence: optional resulting fence
>    *
> - * Fill in the page table entries between @start and @last.
> + * Fill in the page table entries between @start and @last. Allocate and free
> + * new page tables as needed. Can only be called while holding the VM lock.
>    *
>    * Returns:
>    * 0 for success, negative erro code for failure.
>    */
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence)
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence)
>   {
>   	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>   	struct amdgpu_vm_update_params params;
>   	struct amdgpu_res_cursor cursor;
>   	int r, idx;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
>   		return -ENODEV;
>   
> @@ -1159,7 +1161,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.adev = adev;
>   	params.vm = vm;
>   	params.pages_addr = pages_addr;
> -	params.unlocked = unlocked;
>   	params.needs_flush = flush_tlb;
>   	params.override_pte = allow_override && adev->gmc.override_pte;
>   	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> @@ -1168,7 +1169,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	if (r)
>   		goto error_free;
>   
> -	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> +	if (!dma_fence_is_signaled(vm->last_unlocked)) {
>   		struct dma_fence *tmp = dma_fence_get_stub();
>   
>   		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> @@ -1177,7 +1178,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	}
>   
>   	r = vm->update_funcs->prepare(&params, sync,
> -				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
> +				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
>   	if (r)
>   		goto error_free;
>   
> @@ -1255,6 +1256,82 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
> + *
> + * @adev: amdgpu_device pointer to use for commands
> + * @vm: the VM to update the range
> + * @unlocked: unlocked invalidation during MM callback
> + * @sync: fences we need to sync to
> + * @start: start of unmapped range
> + * @last: last unmapped entry
> + * @fence: optional resulting fence
> + *
> + * Fill in the page table entries between @start and @last with a fixed flags
> + * value without allocating or freeing page tables. Can be used without locking
> + * the VM.
> + *
> + * Returns:
> + * 0 for success, negative erro code for failure.
> + */
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			  bool unlocked, struct amdgpu_sync *sync,
> +			  uint64_t start, uint64_t last,
> +			  struct dma_fence **fence)
> +{
> +	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
> +	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> +	struct amdgpu_vm_update_params params;
> +	uint64_t flags[AMDGPU_VM_MAX_LEVEL];
> +	int r, idx;
> +
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> +		return -ENODEV;
> +
> +	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
> +	if (!tlb_cb) {
> +		drm_dev_exit(idx);
> +		return -ENOMEM;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev = adev;
> +	params.vm = vm;
> +	params.needs_flush = true;
> +	params.unlocked = unlocked;
> +	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
> +
> +	r = amdgpu_vm_begin_critical(&params);
> +	if (r)
> +		goto error_end_critical;
> +
> +	r = vm->update_funcs->prepare(&params, sync,
> +				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
> +	if (r)
> +		goto error_free;
> +
> +	for (int level = AMDGPU_VM_PTB; level != vm_mgr->root_level; level--)
> +		flags[level] = amdgpu_vm_pt_clear_flags(adev, vm, level);
> +
> +	amdgpu_vm_pt_leaves(&params, start, last + 1, NULL, flags);
> +
> +	r = vm->update_funcs->commit(&params, fence);
> +	if (r)
> +		goto error_free;
> +
> +	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> +	amdgpu_vm_pt_free_list(adev, &params);
> +	tlb_cb = NULL;
> +
> +error_free:
> +	kfree(tlb_cb);
> +
> +error_end_critical:
> +	amdgpu_vm_end_critical(&params);
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>   			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
>   {
> @@ -1383,11 +1460,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   
>   		trace_amdgpu_vm_bo_update(mapping);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
> -					   !uncached, &sync, mapping->start,
> -					   mapping->last, update_flags,
> -					   mapping->offset, vram_base, mem,
> -					   pages_addr, last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
> +					mapping->start, mapping->last,
> +					update_flags, mapping->offset,
> +					vram_base, mem, pages_addr,
> +					last_update);
>   		if (r)
>   			goto error_free;
>   	}
> @@ -1594,9 +1671,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va_mapping, list);
>   		list_del(&mapping->list);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, true, false,
> -					   &sync, mapping->start, mapping->last,
> -					   0, 0, 0, NULL, NULL, &f);
> +		r = amdgpu_vm_map_range(adev, vm, true, false,
> +					&sync, mapping->start, mapping->last,
> +					0, 0, 0, NULL, NULL, &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>   		if (r) {
>   			dma_fence_put(f);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index a3556cf6dd525..a6f6541758609 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -464,12 +464,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
>   				uint32_t xcc_mask);
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> -int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool unlocked, bool flush_tlb, bool allow_override,
> -			   struct amdgpu_sync *sync, uint64_t start,
> -			   uint64_t last, uint64_t flags, uint64_t offset,
> -			   uint64_t vram_base, struct ttm_resource *res,
> -			   dma_addr_t *pages_addr, struct dma_fence **fence);
> +int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			bool flush_tlb, bool allow_override,
> +			struct amdgpu_sync *sync, uint64_t start,
> +			uint64_t last, uint64_t flags, uint64_t offset,
> +			uint64_t vram_base, struct ttm_resource *res,
> +			dma_addr_t *pages_addr, struct dma_fence **fence);
> +int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +			  bool unlocked, struct amdgpu_sync *sync,
> +			  uint64_t start, uint64_t last,
> +			  struct dma_fence **fence);
>   int amdgpu_vm_bo_update(struct amdgpu_device *adev,
>   			struct amdgpu_bo_va *bo_va,
>   			bool clear);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 89fdeff0575ef..db748e8b3bf38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -115,6 +115,9 @@ struct amdgpu_vm_update_funcs {
>   		      struct dma_fence **fence);
>   };
>   
> +uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm,
> +				  unsigned int level);
>   int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct amdgpu_bo_vm *vmbo);
>   int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 50c41e39e2a2b..dea80796f1393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -347,9 +347,9 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
>   	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &(cursor)))
>   
>   /* Return the flags used for cleared PDEs/PTES */
> -static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> -					struct amdgpu_vm *vm,
> -					unsigned int level)
> +uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm,
> +				  unsigned int level)
>   {
>   	uint64_t flags;
>   
> @@ -590,7 +590,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   			    struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
> -	bool unlocked = params->unlocked;
>   
>   	if (list_empty(&params->tlb_flush_waitlist))
>   		return;
> @@ -598,7 +597,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>   	/*
>   	 * unlocked unmap clear page table leaves, warning to free the page entry.
>   	 */
> -	WARN_ON(unlocked);
> +	WARN_ON(params->unlocked);
>   
>   	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
>   		amdgpu_vm_pt_free(entry);
> @@ -830,23 +829,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		uint64_t incr, entry_end, pe_start;
>   		struct amdgpu_bo *pt;
>   
> -		if (!params->unlocked) {
> -			/* make sure that the page tables covering the
> -			 * address range are actually allocated
> -			 */
> -			r = amdgpu_vm_pt_alloc(params, &cursor);
> -			if (r)
> -				return r;
> -		}
> +		/* make sure that the page tables covering the
> +		 * address range are actually allocated
> +		 */
> +		r = amdgpu_vm_pt_alloc(params, &cursor);
> +		if (r)
> +			return r;
>   
>   		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
>   		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
> -		if (params->unlocked) {
> -			/* Unlocked updates are only allowed on the leaves */
> -			if (amdgpu_vm_pt_descendant(adev, &cursor))
> -				continue;
> -		} else if (adev->asic_type < CHIP_VEGA10 &&
> -			   (flags & AMDGPU_PTE_VALID)) {
> +		if (adev->asic_type < CHIP_VEGA10 &&
> +		    (flags & AMDGPU_PTE_VALID)) {
>   			/* No huge page support before GMC v9 */
>   			if (cursor.level != AMDGPU_VM_PTB) {
>   				if (!amdgpu_vm_pt_descendant(adev, &cursor))
> @@ -892,14 +885,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
>   		pe_start = ((cursor.pfn >> shift) & mask) * 8;
>   
> -		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
> -			/*
> -			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
> -			 * only clear one entry. Next entry search again for PDE or PTE leave.
> -			 */
> -			entry_end = 1ULL << shift;
> -		else
> -			entry_end = ((uint64_t)mask + 1) << shift;
> +		entry_end = ((uint64_t)mask + 1) << shift;
>   		entry_end += cursor.pfn & ~(entry_end - 1);
>   		entry_end = min(entry_end, end);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index af8d2ede183a1..263e68d29360d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1396,7 +1396,6 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			 uint64_t start, uint64_t last,
>   			 struct dma_fence **fence)
>   {
> -	uint64_t init_pte_value = adev->gmc.init_pte_flags;
>   	uint64_t gpu_start, gpu_end;
>   
>   	/* Convert CPU page range to GPU page range */
> @@ -1411,9 +1410,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		return -EINVAL;
>   	}
>   
> -	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
> -				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
> -				      fence);
> +	return amdgpu_vm_unmap_range(adev, vm, true, NULL, gpu_start, gpu_end,
> +				     fence);
>   }
>   
>   static int
> @@ -1523,12 +1521,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
>   			 pte_flags);
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
> -					   NULL, gpu_start, gpu_end,
> -					   pte_flags,
> -					   (last_start - prange->start) << PAGE_SHIFT,
> -					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> -					   NULL, dma_addr, &vm->last_update);
> +		r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
> +					gpu_start, gpu_end, pte_flags,
> +					(last_start - prange->start) << PAGE_SHIFT,
> +					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
> +					NULL, dma_addr, &vm->last_update);
>   
>   		for (j = last_start - prange->start; j <= i; j++)
>   			dma_addr[j] |= last_domain;
