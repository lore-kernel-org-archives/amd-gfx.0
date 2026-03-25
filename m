Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D331103A99C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 02:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDA710E68A;
	Wed, 25 Mar 2026 02:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EV7gS3Qy";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A51F410E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 02:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWpAGjMm7j8ZcMjkGnr76iR+KC2AwLysUF84enEF61oBC/7QzJqdeQ5+F3pTyM5acNXJL+6RPKXfcn64VWS0R3zxIeUJyf9+Gma8FstlDDVCYN384cwt5DjK/+J5Nfg/rpwJukCnUhvOydNTWp6H11nXYuSuxo2+VngVQ/Q1CW7ea2U56TJHPJcNCPoSc6u3K2LI1/1iDFoCA5b3zyPXVrTbMV2lr+PM4Yd1WA3T4fd2eyAor5WbOSWGMI3Q+kr/eCPn+4f9Q0FYBmd461wnc9UWq8E49O3O/HpHFWGGIRpm+948VfTh1dhcCx/GcVGrBqfSHS4jKxfZklSlFZmo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HK+tlhYrLR+mXvOK4+vH3jKzHeeXawRKlzEhMZ1l87Q=;
 b=Hzgx5SBuoWq3cSahSwT7o1vX+WrTIfPutlD6ioxdsOecUEfA4G4DbtQSc31OR3v0O/RkwATHx9gmGI7vue6Aj0J2cHM5NRXSUTCiIwrGmPn2w0coxraii4q3grPPaQPGajADNGR5mfhiH1sQDe0iBbyIpaMhXGA/t7cPSO+hdsX1Y1ITZq8DwvcfMRDt4LirohT60v7gdNcC6QcGg81ANJ2ZK2eSWhFOOorr+rtgo4WcFMLaMlquOF8KIvKM+1G2DQlRLxTqME2l+uOkIYTG5wlRvv10isUC4rHsk04zgpJfqMyKa72POOLmT4gpeVJhlw4nNNusARMXdae8MTMFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HK+tlhYrLR+mXvOK4+vH3jKzHeeXawRKlzEhMZ1l87Q=;
 b=EV7gS3QyUhuDsoDQuKteAumz7ko3G0dC3m5fGCRYRnpMst8I/fZ5F3HRY8WQCLFgkfQ/Q376JX06AaORYhRGjVaMxDvodLlbV/lhodb6PDqhgZjYxd6QbBBkEImQVt0A92l3n4aZsN1WAS+ZWA0uBKc2y6BK4I4vp6OaTqB6AOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 02:27:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 02:27:10 +0000
Content-Type: multipart/alternative;
 boundary="------------lw6HGxrccAKo9E0EBNy1IO0d"
Message-ID: <ff78dfa4-f16b-4313-af73-1e63db67ddca@amd.com>
Date: Tue, 24 Mar 2026 22:27:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 0/6] drm/amd: Add support for non-4K page
 size systems
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com,
 Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
References: <cover.1774239489.git.donettom@linux.ibm.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <cover.1774239489.git.donettom@linux.ibm.com>
X-ClientProxiedBy: YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: efe6f270-13d0-40d8-bd26-08de8a1604ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|8096899003|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DIIs3gAF8lzlfbna7ic7DMIgzke8dGAMrsZSZOmfW6cWZTEp6ZsqrizxkaNZJZT/r05wY6jmx2FKrvy03SaJr8767yHheyzasgT1Rlz8N1UfKfz5qu2+VWlD0UBXWEHGIiPrns+04Iu8hAV3aSK7kOnxIias1ELlWXjD+rUWFQ5vGfNxY4BaG37uKdt13u/n8PPt+hIlouwwZQyMy1hxMmihk+pKgDKYsBecFhWq5u9XD/KmQpcnm9UobPzcrKudq1Ar7YgyY5gRH0JQOHIbBHA7wB9c4OcJIQkIo+2ggWanFUqrN9ypyhfbsHTnTNkp4nG3VYqLpYWGjAIFZomQmYcBGzTclLhV0iKQCktFT1tq47TecMsQfzdJkiiMXY9MyQbRcax3+pPD6ii92OOmVxcmlmsjXDJjy/KZye2h0JnOHXLnc4d78Oxj7mESSZ1/HwO1HDt7iDlI5/frj2LuqRd2ZvRHQLcGKPvyOrS0cJGdKevE4zS3ppIxb0S4SrA6sGxPKAFfdQwXih9v+zEJHzUR5MDlw9b86Zi9CvvXPKFzoe9CYlvJmIrNL8TuB8V2xnVQ/l3TtlxP0P5y1gXY3Ttah6VWFpheClSCXL0AprrPVCwT2eN1HrdaeP3AbMoeeOXOO4XBnYyMtxh5D4dixtCv7L22wkmr8tt2IsGxQHriO5x1Q4ZT6mvKZzk752kVvkRAI0zogB5pw40EktwwqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDNpRDR5eFRmL1dOQXZJbmVqYXdDMlN0SmQ1c0NwQ205aVdoclBkUEdZZS9S?=
 =?utf-8?B?WlVRZ2NrQkVkTHJ5OXJ4Q25UQ3BmakhEVGRsNXBxaCtoVDhBczQrQXd1cFFN?=
 =?utf-8?B?U0RGTmJzNDN5Y2JGNitmUGQ3LzRZMUs3d2V2NzJwbHRuVHFYTVFVMHM5YlY3?=
 =?utf-8?B?U3hVbkRnSk8rN1dpaEx6b1Fack1HOTE2M0hZR2xSV1IvZzQvbzcxaWtUNjZD?=
 =?utf-8?B?K0p3SHpKZVVKbThFWUhXdkFvMDRta0JoRDJhSUhnMERIYnEvWld3RnJMd2dw?=
 =?utf-8?B?anRNL2YyYU5QZWlSVlFJMTRMUURta0pMU3BzRVNYb0VXMFVnQ0pqTTl6SWpO?=
 =?utf-8?B?NUtTRDV4UEFiRE91eUFIbUk1ZTN6SG96OWg4T3liOWRqZXFUWUJ4UE1JN3J1?=
 =?utf-8?B?VlZOTGUwK1BTV1d4OXF1UXg5UThwRGJBWU1qS2hWL3licHpqY2lyZTBvRXIz?=
 =?utf-8?B?WmxEQXZpcWNONEtvL0xQYWh2MUhRV09vWDhaSys3YmkvY1BUbnByRXdvdE9u?=
 =?utf-8?B?SGJpcDlWMFl2MmdQeGhLbG56eHJ5QmxUOURYK0diaWdXYTVCNTFKMjJkMU1l?=
 =?utf-8?B?RWZ5b0NZcGVoU3pNMlFDeGZOZTltWHhvK2IxMkI3S0lLV1dIdTRNaTRzN3Jz?=
 =?utf-8?B?TkVYZFJYZlFKYjRjSWQzbitqR1JhK0o5MGY1SDhxZXRxdVpla0RzdFE5SGRk?=
 =?utf-8?B?UUVPdTBnSGVpZG1kOFV1ZDdDZFFtWEJnL24zbkhqNjMzQnJ2YzlZSm1ZVDMz?=
 =?utf-8?B?NXg4Wkkrb3NvSUpObGR2Y0d1MVd2SFg5WVlpYUlHVWk4T0RoOG1WOTEvS2Jp?=
 =?utf-8?B?Wlg2SmdWVHNheFpTcHhQRCtxb2YyNjlKbWJzdlpwZHVoNU5HTUF4a21oeGg4?=
 =?utf-8?B?NkNudzEwRVlBMXgvYURYTWVYYTlOeE5tN28zaWwyeERSeGp2VFQrOEhXOHpa?=
 =?utf-8?B?ZUxsdE5OOGJzc0xXRjVwY2JsMUhjS29PWE0yRk42YkdZODJxMmVNSlBBcFYz?=
 =?utf-8?B?M3BsMDRRNk5SbkVSR3lSQ0o3M0RGQU9aUzI0UEllZ08yUWFnZ2VqNmZRZ2VC?=
 =?utf-8?B?QVNPNGRyZ25uazdYNHFOUEVtZG5Wa1U1dVMwdURwVUw5TzFsSjBSZUdDd21x?=
 =?utf-8?B?bzRUc3kwU2owU3Vma3F1Z3BHbEFFbTF3anZ2SzlyY3Y5REtPR3k0OGNwV0F5?=
 =?utf-8?B?ZFVlT0gxeWtjekZFZGo4R1p1TjhCdE5seStqb3pVTll5UHJFNFRiWDhlYnFO?=
 =?utf-8?B?K01ZSkNXZ2MyQ0E3L2s4SEpFd1BycWh4bEJCR3JaaFBpaDZCcnRWeTRKUFVZ?=
 =?utf-8?B?RlR3eWwxdGw3WUFrUlBRUXEySm9KODZWUWZVblowQlNQV0FrNmUwc0UzbnNu?=
 =?utf-8?B?bktGNkErcUNWL1FNQUZRMFBVTGptU3FRNjk1ejBOcUZNSVJmQWREQ0duQUNz?=
 =?utf-8?B?YmFkU0toWnpxNzdxOHN2NS9xNlA4cW5mRGtOekQyeGdkVW81Z2lwaTFQNVBi?=
 =?utf-8?B?MjZpbzNJTWVoRHh5NVhVaDYxWVZtUkJHbXZsNlNhOWhkNUE5T1h3dkY3d3JH?=
 =?utf-8?B?KzhLMDlwS1lJdTBSaEd6dG1XbVhybWE0TWx6eFU2Z25GMXNNWnNJMmlUemxo?=
 =?utf-8?B?TG8rNW5HdGJjUE10RzRodnRXYU90SHM2Q205VGxwdElWV09NclhyVHVheFJq?=
 =?utf-8?B?OFpnQ1VZam1xU016bkQyb1R1YW1HbklnbkdnQVdXVDhDMGZZOGMzUUlxZ1l5?=
 =?utf-8?B?TkVaYWdUMll3UkQ1bllmK2NCNHN5dTl3eFFSNXlndHloYUtFa3kybjBwVVJV?=
 =?utf-8?B?MmZuV0VyQ1MrNmdaQmNWeTk5Z2xSNU5IdDhFVU84Zjh0MVZZWHFTdnNWdGNp?=
 =?utf-8?B?WCtEcWZZVWVNeEFtVHRjVkRTWUsvQ2FsT3BwRlBxTE51VE9qZWh6NWVabHla?=
 =?utf-8?B?QUg0MlhOR2ZFOVpqV09NLzdXN1pFNWs0MENNaklQZUlQSk42WERVOXA2WjRv?=
 =?utf-8?B?TFRBditMMUFGSHk2aXJ2S1RldXJncng2cVRVM2MrbWtYR3ZPK3hpRlpSczFS?=
 =?utf-8?B?Q2FpTnMyVDJXWGVtWGEvenZkZ1Q0Z1k0U2xNbk1hb1lqNUxjM3NSZm5XVTNW?=
 =?utf-8?B?Z1U4N09xdDJZbWlsWkF0L2pSL0RjSFlUQWlycGZOMzFjT0loei9Od0hESFFS?=
 =?utf-8?B?SVI3c21CR1FFZktFYVI3Tlp5ekxWejM2YTR3M2VONWd5b3NZbXpZNFBDdmlI?=
 =?utf-8?B?REF1Y0g0eFVXbnZEdVRhcDBYazJHeU1jTFQ5RmowUmJPMmRXeDZqdWtIMTc1?=
 =?utf-8?B?Z2N6OFYzU0lFNmZBaHJ1YU5NQ3dPSFJmSklCYnFqS3RwLzM0dnkrQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe6f270-13d0-40d8-bd26-08de8a1604ad
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 02:27:10.6856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTCgb6dKUz8xxEyWKyDBt2LYogBn/LaIJVwKT3CeGaxpQN2Gd9Jm7fDErkwmmeShn5zBPzNHx/tJXR0gXJYsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

--------------lw6HGxrccAKo9E0EBNy1IO0d
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2026-03-23 00:28, Donet Tom wrote:
> This is v3 of the patch series enabling 64 KB system page size support
> in AMDGPU. v2, part 1 of this series [1] has already been merged
> upstream and provides the minimal infrastructure required for 64 KB
> page support.
>
> This series addresses additional issues uncovered in AMDGPU when
> running rccl unit tests and rocr-debug-agent tessts on 64KB page-size
> systems.
>
> With this series applied, all RCCL unit tests and rocr-debug-agent
> tests pass on systems using a 64 KB system page size, across
> multi-GPU configurations, with XNACK both enabled and disabled.
>
> Patch 1 in this series (drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE
> to 2 * PAGE_SIZE) fixes a kernel crash observed when running rocminfo
> on systems with a 64 KB page size. This patch is required to enable
> minimal support for 64 KB system page sizes.
>
> Since RFC v2, we observed AQL queue creation failures while running
> certain workloads on 64K page-size systems due to an expected queue size
> mismatch. This issue is addressed in patch 2 of this series.
>
> The questions we had in this seres are:
> =======================================
> 1 When the control stack size is aligned to 64 KB, we consistently
>    observe queue preemption or eviction failures on gfx9, on both
>    4 KB and 64 KB system page-size configurations.
>
>    The control stack size is calculated based on the number of CUs and
>    waves and is then aligned to PAGE_SIZE. On systems with a 64 KB
>    system page size, this alignment always results in a 64 KB-aligned
>    control stack size, after which queue preemption fails.
>
>    Is there any hardware-imposed limitation on gfx9 that prevents the
>    control stack size from being 64 KB? For gfx10, I see explicit
>    hardware limitations on the control stack size in the code [2].
>    Is there anything similar for gfx9?
>
>    What is the correct or recommended control stack size for gfx9?
>    With a 4 KB system page size, I observe a control stack size of
>    around 44 KB—can it grow beyond this? If the control stack size
>    is fixed for a given gfx version, do you see any issues with
>    aligning the control stack size to the GPU page size?

I think there is a bug in user mode that uses its own calculation of the 
ctl_stack_size to calculate the total context save area size. If kernel 
mode increases the ctl_stack_size, the context save are allocated by 
user mode will be too small.

This is in 
https://github.com/ROCm/rocm-systems/blob/3a8bafb6a60f4cfa1047a5516fa7212beef4c98f/projects/rocr-runtime/libhsakmt/src/queues.c#L349

                 /* Keep calculating it in case we are using an older kernel, but if we have
                  * the CtlStackSize and CwsrSize from KFD, use that as the definitive value
                  */
                 q->ctx_save_restore_size = node.CwsrSize > 0 ? node.CwsrSize :
                                            q->ctl_stack_size + PAGE_ALIGN_UP(wg_data_size);
                 q->ctl_stack_size = node.CtlStackSize > 0 ? node.CtlStackSize : q->ctl_stack_size;

ctx_save_restore_size should be calculated after correcting 
ctl_stack_size with the one from the kernel mode driver.

Regards,
   Felix

>
> This series has 5 patches
> =========================
> 1. AMDGPU_VA_RESERVED_TRAP_SIZE was hard-coded to 8 KB while
>     KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE, which matches on
>     4 KB page-size systems but results in a size mismatch on 64 KB
>     systems, leading to kernel crashes when running rocminfo or RCCL
>     unit tests.
>     This patch updates AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE so
>     that the reserved trap area matches the allocation size across all
>     system page sizes. This is a must needed patch to enable minimal
>     support for 64 KB system page sizes.
>
> 2. Aligned expected_queue_size to PAGE_SIZE to fix AQL queue creation
>     failure.
>
> 3. Fix amdgpu page fault handler (for xnack) to pass the corresponding
>     system pfn (instead of gpu pfn) for restoring SVM range mapping.
>
> 4. Updated AMDGPU_GTT_MAX_TRANSFER_SIZE to always match the PMD size
>     across all page sizes.
>
> 5. On systems where the CPU page size is larger than the GPU’s 4 KB page
>     size, the MQD and control stack were aligned to the CPU PAGE_SIZE,
>     causing multiple GPU pages to incorrectly inherit the UC attribute.
>     This change aligns both regions to the GPU page size, ensuring that
>     the MQD is mapped as UC and the control stack as NC, restoring the
>     correct behavior.
>
> 6. Queue preemption fails when the control stack size is aligned to
>     64 KB. This patch fixes this issue by aligning the control stack
>     size to gpu page size.
>
> Setup details:
> ============
> System details: Power10 LPAR using 64K pagesize.
> AMD GPU:
> Name:                    gfx90a
> Marketing Name:          AMD Instinct MI210
>
> [1]https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
> [2]https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_queue.c#L457
>
> RFC V3 -https://lore.kernel.org/all/cover.1771656655.git.donettom@linux.ibm.com/
> RFC V2 -https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.ibm.com/
> RFC V1 -https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/
>
>
> Donet Tom (6):
>    drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
>    drm/amdkfd: Align expected_queue_size to PAGE_SIZE
>    drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
>    drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
>    drm/amd: Fix MQD and control stack alignment for non-4K
>    drm/amdkfd: Fix queue preemption/eviction failures by aligning control
>      stack size to GPU page size
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 24 ++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  3 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
>   drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 11 ++---
>   9 files changed, 82 insertions(+), 35 deletions(-)
>
--------------lw6HGxrccAKo9E0EBNy1IO0d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2026-03-23 00:28, Donet Tom wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:cover.1774239489.git.donettom@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">This is v3 of the patch series enabling 64 KB system page size support
in AMDGPU. v2, part 1 of this series [1] has already been merged
upstream and provides the minimal infrastructure required for 64 KB
page support.

This series addresses additional issues uncovered in AMDGPU when
running rccl unit tests and rocr-debug-agent tessts on 64KB page-size
systems.

With this series applied, all RCCL unit tests and rocr-debug-agent
tests pass on systems using a 64 KB system page size, across
multi-GPU configurations, with XNACK both enabled and disabled.

Patch 1 in this series (drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE
to 2 * PAGE_SIZE) fixes a kernel crash observed when running rocminfo
on systems with a 64 KB page size. This patch is required to enable
minimal support for 64 KB system page sizes.

Since RFC v2, we observed AQL queue creation failures while running
certain workloads on 64K page-size systems due to an expected queue size
mismatch. This issue is addressed in patch 2 of this series.

The questions we had in this seres are:
=======================================
1 When the control stack size is aligned to 64 KB, we consistently
  observe queue preemption or eviction failures on gfx9, on both
  4 KB and 64 KB system page-size configurations.

  The control stack size is calculated based on the number of CUs and
  waves and is then aligned to PAGE_SIZE. On systems with a 64 KB
  system page size, this alignment always results in a 64 KB-aligned
  control stack size, after which queue preemption fails.

  Is there any hardware-imposed limitation on gfx9 that prevents the
  control stack size from being 64 KB? For gfx10, I see explicit
  hardware limitations on the control stack size in the code [2].
  Is there anything similar for gfx9?

  What is the correct or recommended control stack size for gfx9?
  With a 4 KB system page size, I observe a control stack size of
  around 44 KB—can it grow beyond this? If the control stack size
  is fixed for a given gfx version, do you see any issues with
  aligning the control stack size to the GPU page size?</pre>
    </blockquote>
    <p>I think there is a bug in user mode that uses its own calculation
      of the ctl_stack_size to calculate the total context save area
      size. If kernel mode increases the ctl_stack_size, the context
      save are allocated by user mode will be too small.</p>
    <p>This is in
<a class="moz-txt-link-freetext" href="https://github.com/ROCm/rocm-systems/blob/3a8bafb6a60f4cfa1047a5516fa7212beef4c98f/projects/rocr-runtime/libhsakmt/src/queues.c#L349">https://github.com/ROCm/rocm-systems/blob/3a8bafb6a60f4cfa1047a5516fa7212beef4c98f/projects/rocr-runtime/libhsakmt/src/queues.c#L349</a></p>
    <pre>                /* Keep calculating it in case we are using an older kernel, but if we have
                 * the CtlStackSize and CwsrSize from KFD, use that as the definitive value
                 */
                q-&gt;ctx_save_restore_size = node.CwsrSize &gt; 0 ? node.CwsrSize :
                                           q-&gt;ctl_stack_size + PAGE_ALIGN_UP(wg_data_size);
                q-&gt;ctl_stack_size = node.CtlStackSize &gt; 0 ? node.CtlStackSize : q-&gt;ctl_stack_size;</pre>
    <p>ctx_save_restore_size should be calculated after correcting
      ctl_stack_size with the one from the kernel mode driver.</p>
    <pre>Regards,
  Felix

</pre>
    <blockquote type="cite" cite="mid:cover.1774239489.git.donettom@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">

This series has 5 patches
=========================
1. AMDGPU_VA_RESERVED_TRAP_SIZE was hard-coded to 8 KB while
   KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE, which matches on
   4 KB page-size systems but results in a size mismatch on 64 KB
   systems, leading to kernel crashes when running rocminfo or RCCL
   unit tests.
   This patch updates AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE so
   that the reserved trap area matches the allocation size across all
   system page sizes. This is a must needed patch to enable minimal
   support for 64 KB system page sizes.

2. Aligned expected_queue_size to PAGE_SIZE to fix AQL queue creation
   failure.

3. Fix amdgpu page fault handler (for xnack) to pass the corresponding
   system pfn (instead of gpu pfn) for restoring SVM range mapping.

4. Updated AMDGPU_GTT_MAX_TRANSFER_SIZE to always match the PMD size
   across all page sizes.

5. On systems where the CPU page size is larger than the GPU’s 4 KB page
   size, the MQD and control stack were aligned to the CPU PAGE_SIZE,
   causing multiple GPU pages to incorrectly inherit the UC attribute.
   This change aligns both regions to the GPU page size, ensuring that
   the MQD is mapped as UC and the control stack as NC, restoring the
   correct behavior.

6. Queue preemption fails when the control stack size is aligned to
   64 KB. This patch fixes this issue by aligning the control stack
   size to gpu page size.

Setup details:
============
System details: Power10 LPAR using 64K pagesize.
AMD GPU:
Name:                    gfx90a
Marketing Name:          AMD Instinct MI210

[1] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/">https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/</a>
[2] <a class="moz-txt-link-freetext" href="https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_queue.c#L457">https://elixir.bootlin.com/linux/v6.19-rc5/source/drivers/gpu/drm/amd/amdkfd/kfd_queue.c#L457</a>

RFC V3 - <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/cover.1771656655.git.donettom@linux.ibm.com/">https://lore.kernel.org/all/cover.1771656655.git.donettom@linux.ibm.com/</a>
RFC V2 - <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.ibm.com/">https://lore.kernel.org/all/cover.1769612973.git.donettom@linux.ibm.com/</a>
RFC V1 - <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/">https://lore.kernel.org/all/cover.1765519875.git.donettom@linux.ibm.com/</a>


Donet Tom (6):
  drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
  drm/amdkfd: Align expected_queue_size to PAGE_SIZE
  drm/amdgpu: Handle GPU page faults correctly on non-4K page systems
  drm/amdgpu: Fix AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
  drm/amd: Fix MQD and control stack alignment for non-4K
  drm/amdkfd: Fix queue preemption/eviction failures by aligning control
    stack size to GPU page size

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 44 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h      |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 24 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c         |  3 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 23 ++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c        | 11 ++---
 9 files changed, 82 insertions(+), 35 deletions(-)

</pre>
    </blockquote>
  </body>
</html>

--------------lw6HGxrccAKo9E0EBNy1IO0d--
