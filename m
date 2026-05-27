Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE52CD5BDE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 07:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0706710E175;
	Wed, 27 May 2026 07:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IjSGs0CG";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464FA10E175
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 07:11:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zK66i66EmwZUeKNOuB1EZsxKKRf6mTkHNhT4p2Ah5rffCf9IaoA0huKEI6sTiVQAOcjhXTwMGAQKuySIxW4FtiAz04eaj5aysvikojh3rCt9XD/ap4ue9b5nBZFoPhdO4wbik5elfvlJzre8YZVjN0+KEP571fC7mkWUnfoy0IuKRB+qdi6ijj/F5K2K8JMjM6Zb2y4otkpq+OOroLCDGP3CsugdNYmD9yzk3nvpYYQ7QXxbk70/1xMlz263+GowxWqFQ0iaYuFDyToBnMor6HoJ4cIMpHQxj/qEWYABs74rSl5hV94fEPNUnm6JC/qxklg+iu7pphe2J24BvKDFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beQqeZuIaoVj5x1t1wtVyabiYbYP1BgH0IqwPyXOMQc=;
 b=OUJxYLNHOrFtkoihqCI6hkNQAd5StagvzZeLNJhM3FA1I0rSFvotxuYf3ve7juIR7ZN8FsS3ru2T7Pmw9SbAkU/mulSB5ycGq2rSR9ycj2dD0MnwWwS/vMkY+/wkHe7x9RySyx7xZjdwJzNbuwOngN/myYIiSdaOpaSRDTbddXNYX1+fYfDY6iigktWPIAakVpAz7pxNyJC2eZV8Ht5BX/83xuyhKG66AvymvPoNwddqL7Z79U3fLEXlQylbW76gVAA5xYyiyW3+teGkT5vFd9MenhtHGv4cuWU+hZFRpAMDMfFzDGSyWJkOedw/lcerFf3p0I90m4FCznoZgLuiXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beQqeZuIaoVj5x1t1wtVyabiYbYP1BgH0IqwPyXOMQc=;
 b=IjSGs0CGIQzxfKCXYOAGubcw3q5OArizahXD0rTpOGnE/BZ/mxO9AgOajwCN0wB9GBZQrudJ8uhaGOO763yUgBW/1fD/oyt1NuQ49Zd2SvgsyliUIoLDUlkMUfYZbLtee4VlbwOJDfm3gqX98R18Fxk7ZOTcWjhiIh+ZLf/NXM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 07:11:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:11:46 +0000
Message-ID: <8ea0e966-fd63-4411-a995-617375e62fdf@amd.com>
Date: Wed, 27 May 2026 09:11:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add lockdep annotations for lock ordering
 validation
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
References: <20260526171721.39484-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526171721.39484-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 319fdf15-13c1-4ae4-de98-08debbbf36ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 6/JdONenGbekDUdsyDRdlXKiHGHxIm9gwPADxfrAa4xO3lyp8oG5Og5Wf8okt9+TdH2eb6q3NPkdlc+T+RPPJFXVCsatVkof0t88NlNC+rR44KZSnhRETATbQOI+hhVcIDgD86y/uRt+XRsFGIi4debQhxslwr1KI/5cSqkcoxbkm46p7bS910tHNDCAKm6f8PGMRJDkjG4bBjRAPVS++XW/DQMflVSzdrdwGW+Q7ujUvhaRQEGwMAQ47DQV3SoqifD3RAlSi/bqNDHKpGvKBHEYmm0aA2rpC+qOV11vE7TcZwmvUgBor9/IF4wK3MF7vJitVD25EtkawLmkIoiiPZ4kVeT2osvkNQ6MSXjpd/vxRmpMeqkoI4c6jFj9DdvRaFp/T8p2O5Wx9od2yKCHZn6Up4nCR387DMCoLkEDiNAHiY6Q8Gpl6guCrZuOYH2JoSSt+CW9wO7wTSyTRMaoi+R92MdHlSOb4qmml8EeAJTWLH4rz6XZ05F83DXx2Z64/3CEdvy0cH0t+tT8043HDYhsGluXPnqawpSy/ic/gIHQFKNofNhxjPotVUG5io2FMdYwbLXtmtXXKTXsCC3hSPcfk/Mun5r4glDkahx+fLefo6PDHOwEIzwCAPlLU9X4I5Kv1fDASarvum+Yt+JclUdFfX0J8K1eYXEWTiY8ePJejNOMImEHdfjCAoEvoDxF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW1VcG5tcnY4LzdMMUhYRkVtYW1TVXMvNTdMbWwzWkJ2dml4RGpTc3NtTUgw?=
 =?utf-8?B?dlJDTmhMV0ZjamsvamV3UmxpRHZIVHF4U3VOU3dxQlFkY3lMZ291R2JLZEJO?=
 =?utf-8?B?U25CYnA5NTNzdmQ1bCtjM2dRNlhsWUo1YkN4TTdtSXVBK0ZQOTRjdmhId1dS?=
 =?utf-8?B?cWZ5blRCNloyV2hSMlN4Ulp5RVNnajRQejE5S0FFS24rdTN1VDFmMVJmUTRD?=
 =?utf-8?B?eEIzZ05mYUtTOHAvdGVqRlhGcmdCWmlKLzgrbExLUXhZQ25JTENaZDQ4ZTRQ?=
 =?utf-8?B?LzNNU0xVS3JFQnUrcG9mVkVZSTN3OHZXYnFEeHRRejZQSXdIODRmL290b041?=
 =?utf-8?B?d2RzS0p1QjQvUFFGdDY0cEZRT3k0dzVkeENwT1VQdW9UcVRZZWFsaW53Q1J1?=
 =?utf-8?B?K3pJK3dKV3dGQXcrU0tpQ0RKREI1ZkdKbHRyNm42Q29ERVJ2NHR3SjVBNHZp?=
 =?utf-8?B?ZHBaWTdtR2tlTy93NE5sNDdrZVRYb1lXQ0RTMDZVRkUvZUdyK1cyVTJYUnVq?=
 =?utf-8?B?cmhJaEQvZW5JMko2THlwTnlDanltTlJkbWl4aHE3cnNibWtidWRjYW4ySU4y?=
 =?utf-8?B?cXNQcXVUdmdocDhQYzVSN0ZWNjJLZ2NzaC8yS0ZrVCtxMTYrdDFYZ3NDWGNl?=
 =?utf-8?B?NEtvWVM4aFFaeWhDZi9KN3c1MlpnSGxyK1poM1JnMWdPWWZmWDB6MjlkQ0pH?=
 =?utf-8?B?R0VFU2VDbWZqRE5xd3JlM1BTZEU3c05jWWV2MzAzaUY5YnlmWmpTMm10cVNi?=
 =?utf-8?B?QUdsNXlVVENNQkhYRzA2Ymp5TU5PSTZPc1k1RmZCcDI4K1I3eFZqVzNxNTNu?=
 =?utf-8?B?MXpuSEFyNVdabzY4Rkl1a3ZWRG5vckV4UGgwdjNCejVnd2NJdEMwWmpySHBv?=
 =?utf-8?B?NE1EMFkyWHQxc3JoSzZncElFeERWdDFrT2JyQTRNMGVDblpoelNvbTJqK3Nh?=
 =?utf-8?B?NklJREcwMHhSVC9WOUc2Nk1YTkJUcnZRU2NWRGdaMVlJejFYM05iV1MyZlZQ?=
 =?utf-8?B?ZnNuZGdwSysxSlBrNENYQ3FXbWo1NGtCSkhUU0xxWml4OFpEYmp3Snh5bEFS?=
 =?utf-8?B?TXQ3ZHg1WmVnTFRtM2VPRnRxLzZ1Nk42SXdxeEFRQ01CaEhoeWlJbzh6STBZ?=
 =?utf-8?B?WEowb01zc21sUU1acUVFb2EwSmxMZVlxQnExZ01na2Qyd21sV000eW9pUjRZ?=
 =?utf-8?B?Qm00K21tdmMvcmxFdCs1eGJjcnhWU0wyWXd0MU1QcEN1QW54czd4ZWNpME5R?=
 =?utf-8?B?STY3WFZqTUx6S3FzdU5BUExvRjJQc0VhZFpGN3dVOHN6MWJVeCs1V282ZmR1?=
 =?utf-8?B?c2hMeG1HWFoxZnhUTzdrcFliOFNVbTMrWlFnUHVYMzg4a0ZBNGQ4NlVZMm5G?=
 =?utf-8?B?dG56UWY1L0RTQnlsS1AvNkJnNjlzL2hVbUhZZDd5anhpOFpHRDlmVWwyNnlY?=
 =?utf-8?B?bDdGZW90dkFWdVZGcGRyM1NHWWZ0R0VCTWVXcEVkQ3BpT3BkQUdZY1F5c1No?=
 =?utf-8?B?ejc2Y2xHb05sL2xnMjA4cVlzOFBiQzZ4T1hMU3UxWEhWRitrYytIcFR2dXhj?=
 =?utf-8?B?QWtvWWdnbW9PVnZweXRjalRTOU5kRzNNc3BBTDczaCs4QXc5VEVhY3lTL09k?=
 =?utf-8?B?TDlpLzNLaERCR1VlalM2aEt0ZUNma3NjbFlRNzRFaVJRTmY5bm5FamRKQWd3?=
 =?utf-8?B?UUYrNW01QXZmVHpUL0Z3WDhPZmpOYjFBaXJhQ3JWcGZlVWZXRVppaWdkZUpw?=
 =?utf-8?B?OFJrV2FNbzF3dW15R2ZJVUh6SlZvd3lVRURrVVVwOWZvTkx3S3AwQ2ltRGdG?=
 =?utf-8?B?RzVIR2xBdGh3M09YR0VMVDN2a3IzN3doOXExSCtMWWFYNG1vdnRHMkRWaDZz?=
 =?utf-8?B?NjU5Sm9PanpxM3hNY2lyOUJzTVIwN2JqZU8rMC9NU0F4Qkg3NFNQeXNDdmZH?=
 =?utf-8?B?UHJFN0w0NE5talhnQ210Q1lmQjhZejFwSXVMMFk0ZjVmNjFUN0ZidG1vTk1E?=
 =?utf-8?B?YmkvZHVEYnJzdDFFTHhNOXNxRGlmU0s4L2l4dE52c0F6UjBPRWdYUTR6UFFH?=
 =?utf-8?B?YTFJNGJIemFyaTNsMUZacENva3RKSDVLd0N5MWJORW52cmo1K3RlY2ZKdi9p?=
 =?utf-8?B?Y3Y3K2dIUlF3ei9xWHBDeGxiRzQ5RkpCQXpnMGJiWVczNXRnN2ZhNVQ3Tklh?=
 =?utf-8?B?MWN6aURRWkNnWEw5Q29zbTdTRW1tbHdFUG91Z2VmK0taa0luY0lvVkJYOXQ2?=
 =?utf-8?B?S2M5cUJJZzVHVWpSR1pWQkZYaWw5NCtTM1k5UFJpekdYV0NLZkNNTVA3THZ1?=
 =?utf-8?Q?e0JS3aHxas2pvZhj4p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319fdf15-13c1-4ae4-de98-08debbbf36ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:11:46.5135 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXdkvovi7mMCEOztPcIvOyMWTQ/u7XQtCoOL4KtRch6nPUCAoDbe6r/G+nJYK4eJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

On 5/26/26 19:16, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> Add lockdep annotations to teach lockdep the correct lock hierarchy
> and catch ordering violations during development. This follows the
> pattern established by dma-resv in drivers/dma-buf/dma-resv.c.
> 
> Lock ordering hierarchy (outermost to innermost):
> 
> 1. userq_sch_mutex   - Global userq scheduler (enforce_isolation)
> 2. userq_mutex       - Per-context userq (held across queue create/destroy)
> 3. notifier_lock     - MMU notifier synchronization
> 4. vram_lock         - VRAM memory allocator
> 5. reset_domain->sem - GPU reset synchronization
> 6. reset_lock        - Reset control mutex
> 7. srbm_mutex        - SRBM register access
> 8. grbm_idx_mutex    - GRBM index register access
> 9. mmio_idx_lock     - MMIO index access (spinlock)
> 
> The implementation provides:
> - Lock ordering training at module init (amdgpu_lockdep_init)
> - Lock class association for real driver locks (amdgpu_lockdep_set_class)
> 
> Dummy locks are associated with the same class keys as real driver locks
> via lockdep_set_class(), ensuring lockdep connects the training ordering
> with actual runtime locks.
> 
> Testing:
>   Build the kernel with CONFIG_PROVE_LOCKING=y (enables CONFIG_LOCKDEP):
>     scripts/config --enable PROVE_LOCKING
>     scripts/config --enable DEBUG_LOCKDEP
> 
>   On boot, dmesg should show:
>     AMDGPU: Lockdep annotations initialized (9 lock levels)
> 
>   The companion IGT test (tests/amdgpu/amd_lockdep) exercises lock-heavy
>   GPU code paths concurrently to trigger lockdep warnings on violations:
>     sudo ./build/tests/amdgpu/amd_lockdep
>     sudo dmesg | grep -A 50 "circular locking dependency"
> 
>   IGT subtests:
>     concurrent-reset-and-submit  - reset_sem vs submission locks
>     concurrent-mmap-and-evict    - mmap_lock vs vram_lock
>     concurrent-userptr-and-reset - notifier_lock vs reset_sem
>     stress-all-paths             - all of the above simultaneously
> 
>   A clean dmesg (no "circular locking dependency" or "possible recursive
>   locking detected" messages) confirms no lock ordering violations.
> 
>   For CI integration, the test should be run on kernels compiled with
>   CONFIG_LOCKDEP=y; dmesg is scanned post-run for lockdep splats.
> 
> v2: (Christian)
> - Move notifier_lock and vram_lock before reset locks in hierarchy.
>   HMM invalidation holds notifier_lock and can wait for GPU reset
>   completion, so notifier_lock must be outer to reset_domain->sem.
> - Associate dummy locks with lock class keys via lockdep_set_class()
>   so lockdep connects training with real driver locks.
> - Update commit message to list all 9 lock levels.
> 
> Requires CONFIG_PROVE_LOCKING=y to activate.
> 
> Cc: Christian Konig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile         |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 195 ++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h |  39 ++++
>  6 files changed, 242 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ee3574797bc2..ba80542ead9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -69,7 +69,7 @@ amdgpu-y += amdgpu_device.o amdgpu_reg_access.o amdgpu_doorbell_mgr.o amdgpu_kms
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o amdgpu_lockdep.o \
>  	amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdgpu_dev_coredump.o \
>  	amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdgpu_ip.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..7b09410d6d8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -105,6 +105,7 @@
>  #include "amdgpu_mca.h"
>  #include "amdgpu_aca.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_lockdep.h"
>  #include "amdgpu_cper.h"
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_seq64.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5ff224163bab..10e485ff055c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3752,6 +3752,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->pm.stable_pstate_ctx_lock);
>  	mutex_init(&adev->benchmark_mutex);
>  	mutex_init(&adev->gfx.reset_sem_mutex);
> +
> +	/* Associate locks with lockdep classes for ordering validation */
> +	amdgpu_lockdep_set_class(adev);
>  	/* Initialize the mutex for cleaner shader isolation between GFX and compute processes */
>  	mutex_init(&adev->enforce_isolation_mutex);
>  	for (i = 0; i < MAX_XCP; ++i) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..bf4260269681 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3158,6 +3158,9 @@ static int __init amdgpu_init(void)
>  {
>  	int r;
>  
> +	/* Train lockdep on correct lock ordering */
> +	amdgpu_lockdep_init();
> +
>  	r = amdgpu_sync_init();
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> new file mode 100644
> index 000000000000..d5d71fd7c70d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Lockdep annotation for AMDGPU lock ordering
> + *
> + * This module teaches lockdep the correct lock ordering to catch
> + * potential deadlocks at development time rather than runtime.
> + *
> + * Based on dma-resv lockdep approach from:
> + * drivers/dma-buf/dma-resv.c:dma_resv_lockdep()
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_reset.h"
> +
> +#ifdef CONFIG_LOCKDEP
> +
> +/* Lock class keys for associating with real driver locks */
> +static struct lock_class_key amdgpu_userq_sch_mutex_key;
> +static struct lock_class_key amdgpu_userq_mutex_key;
> +static struct lock_class_key amdgpu_notifier_lock_key;
> +static struct lock_class_key amdgpu_vram_lock_key;
> +static struct lock_class_key amdgpu_reset_sem_key;
> +static struct lock_class_key amdgpu_reset_lock_key;
> +static struct lock_class_key amdgpu_srbm_lock_key;
> +static struct lock_class_key amdgpu_grbm_lock_key;
> +static struct lock_class_key amdgpu_mmio_lock_key;
> +
> +/**
> + * amdgpu_lockdep_set_class - Associate lock class keys with real locks
> + * @adev: AMDGPU device
> + *
> + * Call during device init to associate lock classes with actual locks
> + * so lockdep can track them properly.
> + */
> +void amdgpu_lockdep_set_class(struct amdgpu_device *adev)
> +{
> +	lockdep_set_class(&adev->gfx.userq_sch_mutex,
> +			  &amdgpu_userq_sch_mutex_key);
> +	lockdep_set_class(&adev->notifier_lock, &amdgpu_notifier_lock_key);
> +	lockdep_set_class(&adev->srbm_mutex, &amdgpu_srbm_lock_key);
> +	lockdep_set_class(&adev->grbm_idx_mutex, &amdgpu_grbm_lock_key);
> +	lockdep_set_class(&adev->mmio_idx_lock, &amdgpu_mmio_lock_key);
> +
> +	if (adev->reset_domain)
> +		lockdep_set_class(&adev->reset_domain->sem,
> +				  &amdgpu_reset_sem_key);
> +}
> +
> +/**
> + * amdgpu_lockdep_init - Teach lockdep the correct lock ordering
> + *
> + * Instantiates dummy objects and takes locks in the correct order to
> + * train lockdep. This helps catch lock ordering violations during
> + * development.
> + *
> + * Lock ordering hierarchy (outermost to innermost):
> + *
> + * 1. userq_sch_mutex     - Global userq scheduler (enforce_isolation)
> + * 2. userq_mutex         - Per-context userq (held across queue create/destroy)
> + * 3. notifier_lock       - MMU notifier lock
> + * 4. vram_lock           - VRAM allocator lock
> + * 5. reset_domain->sem   - GPU reset synchronization
> + * 6. reset_lock          - Reset control lock
> + * 7. srbm_mutex          - SRBM register access
> + * 8. grbm_idx_mutex      - GRBM index access
> + * 9. mmio_idx_lock       - MMIO index access (spinlock)
> + *
> + * Evidence:
> + * - userq_sch_mutex -> userq_mutex: amdgpu_gfx_kfd_sch_ctrl() calls
> + *   amdgpu_userq_stop_sched_for_enforce_isolation() which takes userq_mutex
> + * - userq_mutex -> notifier_lock: userq paths may trigger MMU notifier
> + *   invalidation which acquires notifier_lock
> + * - notifier_lock -> reset_domain->sem: HMM invalidation callback holds
> + *   notifier_lock and can wait for GPU reset completion, so notifier_lock
> + *   must be outer to reset_domain->sem
> + * - vram_lock -> reset_domain->sem: VRAM management paths may need to
> + *   wait for ongoing reset to complete
> + *
> + * Note: mmap_lock ordering relative to GPU locks is already taught
> + * by dma-resv (drivers/dma-buf/dma-resv.c).
> + */
> +int amdgpu_lockdep_init(void)
> +{
> +	struct amdgpu_reset_domain *reset_domain = NULL;
> +	struct amdgpu_reset_control reset_ctl;
> +	struct mutex userq_sch_mutex;
> +	struct mutex userq_mutex;
> +	struct mutex notifier_lock;
> +	struct mutex vram_lock;
> +	struct mutex srbm_mutex;
> +	struct mutex grbm_idx_mutex;
> +	spinlock_t mmio_idx_lock;
> +	unsigned long flags;
> +
> +	/*
> +	 * Initialize dummy reset domain
> +	 */
> +	reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE,
> +							"lockdep_test");
> +	if (!reset_domain)
> +		return -ENOMEM;
> +
> +	/* Initialize dummy locks */
> +	mutex_init(&userq_sch_mutex);
> +	mutex_init(&userq_mutex);
> +	mutex_init(&notifier_lock);
> +	mutex_init(&vram_lock);
> +	mutex_init(&reset_ctl.reset_lock);
> +	mutex_init(&srbm_mutex);
> +	mutex_init(&grbm_idx_mutex);
> +	spin_lock_init(&mmio_idx_lock);
> +
> +	/*
> +	 * Associate dummy locks with the same class keys used for real
> +	 * driver locks. This ensures lockdep connects the ordering learned
> +	 * here with the actual locks used at runtime.
> +	 */
> +	lockdep_set_class(&userq_sch_mutex, &amdgpu_userq_sch_mutex_key);
> +	lockdep_set_class(&userq_mutex, &amdgpu_userq_mutex_key);
> +	lockdep_set_class(&notifier_lock, &amdgpu_notifier_lock_key);
> +	lockdep_set_class(&vram_lock, &amdgpu_vram_lock_key);
> +	lockdep_set_class(&reset_domain->sem, &amdgpu_reset_sem_key);
> +	lockdep_set_class(&reset_ctl.reset_lock, &amdgpu_reset_lock_key);
> +	lockdep_set_class(&srbm_mutex, &amdgpu_srbm_lock_key);
> +	lockdep_set_class(&grbm_idx_mutex, &amdgpu_grbm_lock_key);
> +	lockdep_set_class(&mmio_idx_lock, &amdgpu_mmio_lock_key);
> +
> +	/*
> +	 * Take locks in the correct order to train lockdep.
> +	 * This establishes the dependency chain.
> +	 */
> +
> +	/* Level 1: Global userq scheduler mutex (outermost) */
> +	mutex_lock(&userq_sch_mutex);
> +
> +	/* Level 2: Per-context userq mutex */
> +	mutex_lock(&userq_mutex);
> +
> +	/* Level 3: MMU notifier lock */
> +	mutex_lock(&notifier_lock);
> +
> +	/* Level 4: VRAM allocator lock */
> +	mutex_lock(&vram_lock);
> +
> +	/* Level 5: Reset domain semaphore */
> +	down_read(&reset_domain->sem);
> +
> +	/* Level 6: Reset control lock */
> +	mutex_lock(&reset_ctl.reset_lock);
> +
> +	/*
> +	 * Mark potential memory reclaim boundary.
> +	 * GPU operations might trigger memory allocation/reclaim.
> +	 */
> +	fs_reclaim_acquire(GFP_KERNEL);
> +
> +	/* Level 7: SRBM register access */
> +	mutex_lock(&srbm_mutex);
> +
> +	/* Level 8: GRBM index access */
> +	mutex_lock(&grbm_idx_mutex);
> +
> +	/* Level 9: MMIO index access (innermost lock, spinlock) */
> +	spin_lock_irqsave(&mmio_idx_lock, flags);
> +
> +	/*
> +	 * All locks acquired in order.
> +	 * Lockdep has now learned the valid dependency chain.
> +	 */
> +
> +	/* Release in reverse order */
> +	spin_unlock_irqrestore(&mmio_idx_lock, flags);
> +	mutex_unlock(&grbm_idx_mutex);
> +	mutex_unlock(&srbm_mutex);
> +
> +	fs_reclaim_release(GFP_KERNEL);
> +
> +	mutex_unlock(&reset_ctl.reset_lock);
> +	up_read(&reset_domain->sem);
> +	mutex_unlock(&vram_lock);
> +	mutex_unlock(&notifier_lock);
> +	mutex_unlock(&userq_mutex);
> +	mutex_unlock(&userq_sch_mutex);
> +
> +	/* Cleanup */
> +	amdgpu_reset_put_reset_domain(reset_domain);
> +
> +	pr_info("AMDGPU: Lockdep annotations initialized (9 lock levels)\n");
> +
> +	return 0;
> +}
> +
> +#endif /* CONFIG_LOCKDEP */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> new file mode 100644
> index 000000000000..04adb58665bf
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2024 Advanced Micro Devices, Inc.
> + *
> + * Lockdep annotation interface for AMDGPU
> + */
> +
> +#ifndef __AMDGPU_LOCKDEP_H__
> +#define __AMDGPU_LOCKDEP_H__
> +
> +#include <linux/lockdep.h>
> +
> +struct amdgpu_device;
> +
> +#ifdef CONFIG_LOCKDEP
> +
> +/**
> + * amdgpu_lockdep_init - Train lockdep on correct lock ordering
> + *
> + * Call once during module init to establish the lock dependency chain.
> + */
> +int amdgpu_lockdep_init(void);
> +
> +/**
> + * amdgpu_lockdep_set_class - Associate lock class keys with real locks
> + * @adev: AMDGPU device
> + *
> + * Call during device init to associate lock classes with actual locks.
> + */
> +void amdgpu_lockdep_set_class(struct amdgpu_device *adev);
> +
> +#else /* !CONFIG_LOCKDEP */
> +
> +static inline int amdgpu_lockdep_init(void) { return 0; }
> +static inline void amdgpu_lockdep_set_class(struct amdgpu_device *adev) {}
> +
> +#endif /* CONFIG_LOCKDEP */
> +
> +#endif /* __AMDGPU_LOCKDEP_H__ */

