Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5B9CA5FFC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 21:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8317510E16A;
	Tue,  6 Oct 2026 21:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="keyPE659";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4E510E16A
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 21:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPomwO/B2qsXxyHkOiBBgGfYWcKviSx+S14Sb/6CXUVTUUU2gEjm7gphH7UyRETeRhWruDJoLIbnsAQwjOBRU8uUE73rjx+oEB1qa5i+Tb8VfDis8xy+4QATwKnaeyK+33/LfI0Zd+yOwnL7U/0IFQLQyGKguTvq4VwGJ5edp5Bfxnp+9rdmLRVsXA3KV1IH7HmbJCCdfXwyoT3vRAHrX4vh/frr8+ob6A2kK8otTBT7/6izqd8AfuXcUqPXZjnIAoHkc4DVezBiEsnhuXMRmMDwysDkqWAx2lN7sU3oM5PC8SnOVVzxg0fK3XwnyY157e9fF9CbhQxOtlucxlEHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm9+OyynoSQpSRnuB1SUdYhx2OlmU1H7MLg+jt3g0wQ=;
 b=YbXXD1o6cIj/cOm1FMKoeFTkYpUHMXYNaUqe17+qaQUW+IEo7lZqj1JE8ZPciW5dDrLQnEGN4pk8VeMx7brWOA5vhJi4AzdiyIxwjejc31EviK9AvJ9FqNxFmArJtbdGGc2G1cxp2H+npg88uwhIHO2fxYF+nkHUP1ZUtX5ztHlEJwxLvc08pY2+D8SxdObJJWH7XUHEncew1tqnkCKAyLQtPFM0yUZABac/+jKXUXvO8N7eIzQQc7vMGcpQA/qJQmcsZxg8boMb/DgXFNXHpCz4svljzYuUfMGC4HOUfOLKDy4EneCX3RUPW0TP2RcosukZE751PV8Kef/0WVnuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm9+OyynoSQpSRnuB1SUdYhx2OlmU1H7MLg+jt3g0wQ=;
 b=keyPE659N6DjVL3TmqwWTKbad7r01CmAMfXBo4a6/DQ8oYuoPiJRUzOQIHi8hF1R47NViCyRYqGJSkptE24WDaIZH8JcI+YxbrH+pmaaC2rs3Oc0xC2QPIrb+K7rgQa8ChCJunSQpoPp9yFbE2DLm2KJvV8PMQXquEECbPqRdPg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by SJ1PR12MB6025.namprd12.prod.outlook.com
 (2603:10b6:a03:48c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 21:43:55 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 21:43:55 +0000
Message-ID: <528f1f07-cece-4bec-96e2-7c43e335bbd3@amd.com>
Date: Tue, 6 Oct 2026 17:43:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amdkfd: Change migration size in CPU/GPU page
 fault handler to THP size
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260904195421.42919-1-xiaogang.chen@amd.com>
 <20260904195421.42919-3-xiaogang.chen@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260904195421.42919-3-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::24) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 724df1cf-2820-4df8-4aba-08df23f2eb90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|22082099003|10067099003|11063799006|56012099006|6133799003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: 463e3We0XxCjm5lVykFai0Lh/vXbuOEs/H8O+X0mXE+AlNR/rc4gYK5ABmCKV2t4tFqUZjlr2JMpM4fQ9TB/sbNkAQGYAu5CkN74I5vqJJC8/aDOaWN6l34S9EpLzsF+/h4HqHXkvhDkVyvvcrEFH2PRjB8PZmSU4SF4Y/nQVrrmPIcme8ENyAW2DjXIZFrUk3DhXqeabzWGuMh/giIHOC9JR+r+O/ifnEt3POs09Q7NaksliHgES24jgwgi3vlyvES7QBo51pS8O6PPX9YYD9ErLyP3fvm4Q8hU97WEGUdtzWcYDrJ+ypE813qFF8VgDGTC30+gFLjz48/PxIgZAGVH4h3WXJTDVxBVtwN6dNY+ITjt5EQH/YJ5kEsYgw3cJCCy6ZRrWIInLNUgef3E841mUs3/8ma+8MWqZWjph2hYY/UvhT+9OlR3S9m4/jA4EslBSJh+leeCjGvGlyGMDTYaKd5z3fHOH2heWfUeZnR+Pg6uEiXMukzaARoHkc0l2lz3ec8/ZYzvUpCSg0fufJTN5XHgYslnRNAxo11Api/qoANuunCY1ymESVQVOWkd7AunD1EJhEynEsqAXstC2KgeQFruu0/xJkFivBDxGFZUeErBYORxuy55qKV+6JH9c4zghshbVwAdRMzOqQSmVcRskeVKewqgRpn0U9waJKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(10067099003)(11063799006)(56012099006)(6133799003)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1RIQkt1QnhTYUxBVE80VHlzOUpqTjlMUHhsSE0ydWFQK1lXWlMydkhWRGRE?=
 =?utf-8?B?VnBpOEhUTFk0S3JQdHBrNmh6T0tXM01hcUZwY1ZVL3YxMWFnM1dkNCsvMXo3?=
 =?utf-8?B?Qm9EVFYwaWRxNlJDZmVqdnZ5SHhwM204RW1idmszQmZKL3hzZERKcTZpZ3dT?=
 =?utf-8?B?aXJBUXJIUk11c2hTakZZcytjU0ZhcEdlc1l6OURiREpnYklYZERwM3FaYmRS?=
 =?utf-8?B?U1V6RWxnKzNqc3JxZUR2SEwxZ1lBbDV0YUp4TTlZUGJUKzJaNHdCRG1RdFBS?=
 =?utf-8?B?UjI0OS9PalVlbVF5YitpWGJMVUhyeTd0VXFKaEhKWnRYVFJqZVh3eEx0Zlg2?=
 =?utf-8?B?eUovcEwwUExNRlpXVXpoelcwYkNCZzV3K3AwdHhJbUUrZ0MxS0NnQVhmR0xV?=
 =?utf-8?B?ZER4L0d2THR5NGhYRWZIQ1c1bU1KNUNET3Z4ckpCdWxzc08zQUE2d3hiQ3Fo?=
 =?utf-8?B?bVBQbDZXbVFDc2QyMFdHaDhOVS9VanU2YUpQSmkwVU96WFVJaThCQ3MzSjZZ?=
 =?utf-8?B?S1RXL3BpOGJnZ0tXNk1MVlY4RmYzU1F2RnI4elZza09CcUIybGlGaFpXQ3B3?=
 =?utf-8?B?OXJUY0xheG1BalFZODFURk5PSWhyL0hoS1pDc1ZZK3hVRDlHN2w0czBBWXR1?=
 =?utf-8?B?R2xzTVhpaXVId3I3b2RtRnhoMTZoUmtZM0RyaGg3MmZIMXl6QnRBa1M3bzhp?=
 =?utf-8?B?a2ppS2syTTlab2Z6dm9tRW1teVM0UnFKRDEvemVvaGE2aXo1eFVXWFkxQ2RI?=
 =?utf-8?B?ZlNvR1NIcmtoTjFBclpQSkpzb2hzR05xd2IwR0xmL1IzN3dhQWI4WjJFbmlz?=
 =?utf-8?B?WllDalVCcWhaN0JuckdYK2hFeHQzY2FQeUY2dC9QSG9hYmw4dDRHYkR4OXJm?=
 =?utf-8?B?d3lFbWRHcmx0Q2pTeUp2TkRubjVwN3dPNVh4MUZLb0Z5WlZYZEVQRytvOWNk?=
 =?utf-8?B?QzV4MGhKbzB3bXBsd2REWE5QSEV3cS9hWDNhaVk3WGpaVG1SRDNIaDJkTDdY?=
 =?utf-8?B?T1RTUTN3eGh0TWpWR0tSeHhFZWhuSUVsM3YzS0lJSUtaQUJMb3lSenAydEZR?=
 =?utf-8?B?NVJTN3JzS1JNN2JNQjkzL3NoZE1tOUFXeGFzWm9YaDJDVldwVTVDbjl2OUtS?=
 =?utf-8?B?bkxqSEo0VDZwc0Nqa0ZkVTlaZ285c2F4L0JYczA2QlVDREx6blk3d1ozeDlt?=
 =?utf-8?B?Mk9ST0VkYlVrMzNKY2JhSGM3N3N3bFRxY3IwVVl1WlVjU1cvWnk3V2lhKzBS?=
 =?utf-8?B?dEtRZFVnMWErSnNWOWZ5TEVFM2hJN0ZrY213RXN5eEpaNUdneEx0clN0NGVD?=
 =?utf-8?B?dXVPYTBxbFZJWnFyK05zTVlEekhld1dqN2JMN0RaaHp4eVkvWEVpRGg0bk9n?=
 =?utf-8?B?Rk4xTXdoR1BpMSttVml2Tm0vQVh2aTNjMnNlSVhmalBieWMwUG1GelIrS2Vl?=
 =?utf-8?B?UkNDKzlKY0RIQnZ4ZVpIWFVrbnBkU1A3Zk9PVjN1L09DbEh2N0NxQmIweG56?=
 =?utf-8?B?WDJ2MWZOUzZrQ0lHZmxaZ2dzY0Q1WEVVWlQ4R1NFZm0zcVhtNDR0elZiaHpX?=
 =?utf-8?B?cElnZGtnMVV5ZWhOejVnS2lLZ0g5eWNrVEUzR3JiMHBVcE9nd3d6bTJ6d3F3?=
 =?utf-8?B?Qk9JNXowUGFNWGJoWUQ2ckNoMHBxMWRmc1N6b3dCOHBBc0c5WUtaZFVxejBy?=
 =?utf-8?B?TjVYWmJkL3dMTitmQ3lRc3djWWZ3ZGtOK2pBYVlYOHorU1VzeHRtY2luQ0Uz?=
 =?utf-8?B?Z2ZuL2g0eTJxRS9XUzhzZm16c3p3MEIyNmJ1UHErY2N2cy9JMDRRZUU4bHYr?=
 =?utf-8?B?V05GOTFPV2RQd2N2TmZDamNMRDRHNEFhR0hHcEZHbGh5KzRic3dwSnY0eGhp?=
 =?utf-8?B?cnR2UW04VGg5bU1FSCthd3lZQSt1a2pDR2NCczNKdTlzVCswUmRKVzExWUFk?=
 =?utf-8?B?UFFoT2lHMUxRMmlLWWgrZ0Q3OTlRZ1BhY09Ob3JQRDIvNlp0K0NkT3dNd3Rh?=
 =?utf-8?B?YmttMmJBL3M0VkZFeGpMckk1M1kwVGJEb3dWdDhnT0ROM1dLV0ZUcFBCTnpZ?=
 =?utf-8?B?aThTU2xwWmE0TnF1cVB2OHN5bFJvTHFmclJzZHBqYlFiS0h0ekRVY0tGSFhY?=
 =?utf-8?B?Rkp3SFNHTndZNHZDOXVwcWd1TCtkZjN6MGp5MlpUT3o0emhjNjNaZWNxU29u?=
 =?utf-8?B?akNPMEpFVlhIZjRYdnowdTVmOWR0WmJxM0NMN29xMTlEZk5INjgwa001cmlq?=
 =?utf-8?B?UjVsTGlqcnFzQWtSdS9Ib1JZcVBaZERwTzZhNFI0M0RYZENKQTIwM000ZzIw?=
 =?utf-8?B?eHVCTUtWSHUwSVZkNjFGN3VnUWRtZEVQTnAwUXJ1NTZ0ZzdjeHdoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724df1cf-2820-4df8-4aba-08df23f2eb90
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 21:43:55.3205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UW8uiS8pWcv0JgEb2xMvJ2j5hGSDd6B1DEo2D8vcm0HDz3rGMWtAgRWA/ninAjsZyHI6URxLNGlFcALauWWhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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

On 2026-09-04 15:54, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When use HPAGE_PMD_SIZE based device private pages during migration core HMM
> treats device private memory in HPAGE_PMD_SIZE compound folio if possible.
> Current kfd driver uses prange->granularity that can be changed by user. Need
> have migration size in CPU and GPU page fault handler in HPAGE_PMD_SIZE based.
>
> For AMD GPU that exposes private device memory choose HPAGE_PMD_SIZE as
> minimums migration size in CPU and GPU page fault handler. For x86 it is
> same as default prange->granularity.

As we discussed before, this breaks the API semantics. The default 
setting is fine for allowing THP. But we want applications to be able to 
use smaller granularity for use cases that access or distribute data 
between multiple devices at finer granularity. In those cases, the 
additional memory management and TLB overhead is offset by reduced 
migrations or thrashing.

Please just drop this patch.

Regards,
   Felix


>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c |  6 ++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 13 +++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     | 12 ++++++++++++
>   3 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 813f3c1d29dc..bbf0fefd5722 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1026,8 +1026,10 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   	if (!prange->actual_loc)
>   		goto out_unlock_prange;
>   
> -	/* Align migration range start and size to granularity size */
> -	size = 1UL << prange->granularity;
> +	/* Align migration range start and size to max of
> +	 * THP with HPAGE_PMD_ORDER and granularity size
> +	 */
> +	size = 1UL << max(prange->granularity, HPAGE_PMD_ORDER);
>   	start = max(ALIGN_DOWN(addr, size), prange->start);
>   	last = min(ALIGN(addr + 1, size) - 1, prange->last);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 6b783d12bce4..482cd4e7eee5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3071,6 +3071,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	struct kfd_node *node;
>   	int32_t best_loc;
>   	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
> +	bool is_private_device = false;
>   	bool write_locked = false;
>   	struct vm_area_struct *vma;
>   	bool migration = false;
> @@ -3087,6 +3088,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		return 0;
>   	}
>   	svms = &p->svms;
> +	is_private_device = svm_is_private_zone(adev);
>   
>   	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
>   
> @@ -3224,8 +3226,15 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	kfd_smi_event_page_fault_start(node, p->lead_thread, addr,
>   				       write_fault, timestamp);
>   
> -	/* Align migration range start and size to granularity size */
> -	size = 1UL << prange->granularity;
> +	if (is_private_device)
> +		/* Align migration range start and size to max of
> +		 * THP and granularity size
> +		 */
> +		size = 1UL << max(prange->granularity, HPAGE_PMD_ORDER);
> +	else
> +		/* Align migration range start and size to granularity size */
> +		size = 1UL << prange->granularity;
> +
>   	start = max_t(unsigned long, ALIGN_DOWN(addr, size), prange->start);
>   	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
>   	if (prange->actual_loc != 0 || best_loc != 0) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index f2b3a05cd8cf..e78ee94ba33c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -215,6 +215,13 @@ void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   void svm_range_set_max_pages(struct amdgpu_device *adev);
>   int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
>   
> +/* check adev has device private zone memory */
> +static inline bool svm_is_private_zone(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_kfd_dev *kfddev = &adev->kfd;
> +	return (kfddev->pgmap.type == MEMORY_DEVICE_PRIVATE);
> +}
> +
>   #else
>   
>   struct kfd_process;
> @@ -277,6 +284,11 @@ static inline void svm_range_set_max_pages(struct amdgpu_device *adev)
>   {
>   }
>   
> +static inline bool svm_is_private_zone(struct amdgpu_device *adev)
> +{
> +	return false;
> +}
> +
>   #define KFD_IS_SVM_API_SUPPORTED(dev) false
>   
>   #endif /* IS_ENABLED(CONFIG_HSA_AMD_SVM) */
