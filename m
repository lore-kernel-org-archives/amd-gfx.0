Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C75606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=K1UJIVak
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECFD10E2B0;
	Fri, 30 Oct 2026 14:28:00 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE8910E2B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxBfgzXHjH/tvLSGOFO1omF9TXtPgQExj+WqhtuoNyKFRzdswpPcn1DTPztEBJBltPBHN//Xk/3IAynFVqdMhF3Mi9M8SMqdXop97q+UOnWXFHT3c/K/+JPyh7iaQte+bHgzQ3YzbcZoLeO30gnLHQfBdiZY8suYjFlQyiOzrPkPs0oygsReStuAlDKTObstp1YcoW/A67DqGGtxU9u23bBXAJi2PQwu3zKBjWZkwDh+bZyQF144JAooRHNlhlnlcPLsnLOKlSp2laZCHLnfwsNjB31R/UZXfb4JceMUDBLinyQfyjbrzQ0KwyUXZZAdKim97PR7Ce7PEDX4HCgMDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSCZEG6sYdF/g9IufWh5ofZpFH06AWYVjwKVhdnEHf4=;
 b=Y1CTm8LqhG6Zi04oun4Z72pWJ1SThrtf4uLuqmPvkgKskGPeQD03Jm5nxNPaYvp+xoZfGlYIBQBaW4tWkN+HLazIldIkUCyyHpcHn8wbZQV16FdxXIT+lSqVBBYBJF9u1hMi0gmF/q8FdGKxH8SKKw32satcpajpK7tQQeqdKKtXE2QoVniKIo8QPfaCRJ73GvKCGMEVEStJt0YnYps2cfikhKzMRytv9gUbbFmvxtVF53R7qdGMVcDoR6O7RafzvS+Jf+IzrQw2NSGZmhJ0EyOnPscQgv9CZcLtSWbgWCbo5t8qTD2Sg60Ob/6KXg8O5Er1C2jS3Q3Xjrc7VJdhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSCZEG6sYdF/g9IufWh5ofZpFH06AWYVjwKVhdnEHf4=;
 b=K1UJIVakF93noXVqlOLAfhPpwLOsnRnA2UBSEBcc86lt281NpMl8dlGSTIHSufxOYmRsu4YphneUjA1I6EHX2HFn3jVXVJBvKLZDzKSta78duLaZQmtSm7n1pTHEXAvN36YOqXR+cOgChKVV1r8iPMSMFuNAjo/4fQ9MCdMDc8Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:27:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Fri, 30 Oct 2026
 14:27:46 +0000
Message-ID: <487bdf03-4e27-4231-9ae9-58a41a8b8571@amd.com>
Date: Fri, 30 Oct 2026 15:27:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: avoid blocking reset lock during
 eviction
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
References: <20261030032818.136872-1-vitaly.prosyak@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261030032818.136872-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: b95719a5-3015-420a-410e-08df3691f7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: yZITFolV++hXfZywE3eRc79HuGG4Gq9/NwHknLMBtxUWIS/zSqH9pDnojptOqpA9NbZjp3g7HYnUn95+SfEDpgMKwnP16viAp5Y/faiQv8GKYvyo0fQXaOf6itpXkcYcHSY2joHcHcLI/JiOmK3cl/B/mc5LFA1ABhZ6P3Q7kiTYzBMSBfwj/zFJUnTaxm5rg4b33UvEVFDoq/qUqO0YManyOgnhwFTymYF/Eek93XvTvrPjXAN/Kt7GKlt89I6R3YM52TdDVDLwIbys07rAHTYmrz6ctzeztof10z8jTTrMTr/0ar9YhqngcFBF012O5bSwZQnZOb2Zt26US/LSFv2YoQr4RQNB6aHyyw8rrjs2Zikdrq0LO+khNmTRSwgxVLQvThLoqwKNIRM2mEQ9Z1Xhav2mpMUQxC4GEZtoTsvIU2t501glxAWzlutMaHlEZNTsZiNV5FgwEaJlykA8DH3P3m29FKRtIllaw28FT85MJVz5eLyYzHb4i4U5ESOPG4V31nHG4QaA+nyvXnA7K1L21Qjeg/1ukFXcrmiHoJA5SA1+d0fNFAziwXfazFk/4iQHpuTVnchbIgnqDiBO65UZkyYCWcv4xCIhrtND2yeKNwh9KAZru8zgeJ9r/Z0JtglykbfSjsNbtkM2VLl9ZqNjoKTcaArEaSIMrNoiMko=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVRCUHlmSzNwK2FTdkUyM0RlcVJ6NzNLZWZ6SUtpYUk4MHpJZEUvaWlCZW8x?=
 =?utf-8?B?Y05hM1d6b3lUVjc5WVJ6M0pvc3NFTXM4QUlGb2hzbVZmMElWOEJhZVhJSVdo?=
 =?utf-8?B?cXFDVjdjcXJJVTdVaUlrRkNBT0U2VGtnbXp0N0x5OXkreWVybVRZY1ZlSkxh?=
 =?utf-8?B?cENLY0dQSy9UdWZYZDlXYXZ0emV6Mk9Ham5xS2dwK0Vxa1ZROVY5aUVaTmlO?=
 =?utf-8?B?aUdjWDEvYko0UEdVWXVDa0RETjJxdlc5K2RYcVJvVnc4RkJFdXh3N0RteUdz?=
 =?utf-8?B?dHJFUlY0MTBGWDRsdCtqV3ZsUnJpMmVLdmhRNVJEZFUxeWdpaEFtam5tTUtG?=
 =?utf-8?B?emN0YWFiY1Y3elZWdHpvbDR4dVJtc2pxWnNvT0JKRytuZEI5eG5QYzRjSG12?=
 =?utf-8?B?WlpLYWdwV3Z5RHBna3Z5WDQ3VVlRMmw4OFd2eDlGVzAvOHhvZXBmcEVOaC9C?=
 =?utf-8?B?ZHFreHdtMWtNUGl1RDYrRUl2dzN3Zy9WNTJlTFVEcURUOVVla09ucWxoZS9u?=
 =?utf-8?B?NEJFKzdtVC9TRzNuRzQ3SW5ldDIxdEE4S3Z1VSt6eTNUNmZ3TjZuQ1ZsK05C?=
 =?utf-8?B?WWZsMmJ4UEpMQnZ3MXJFVXlzcFVZUGs5dHRRamRBRE9QakNQcXBGQVZwRjFa?=
 =?utf-8?B?a1lLSzU1ZFIydkM5azY2bkxnUSttSXVCNHZHNEZNR2ZIZmpjcHJZZFVPelBB?=
 =?utf-8?B?eDN4ZzZid1NPWUdzTGhpMlZDbHNmaU9LeTRkSk0zUm01d2VZbWl6eEM1SVVT?=
 =?utf-8?B?ZVlmOWdvWFdENmdXVHFGNWVSRjQ4VTJkNzZBZWRvc1hLUnRuam9rejBPdnI1?=
 =?utf-8?B?Vi93QWhqRHhPMXBERnVmeVNoY2NpTlYrVU5WbXJHQm0rZkRBbnR6UEpDcUZF?=
 =?utf-8?B?WDQrL0Z3VUZGaUxHNUJzR21wY2FteFBobzNPdFFEVHZqbGVPU0ZJNWRpalpS?=
 =?utf-8?B?NU9UbURCSjRHaHUrQXQvWktJbGRuV1BiSHBwWWJOUGMxZkdERS81eFNrL0JM?=
 =?utf-8?B?U2V4UnZaZGMvSHVGT2IybHVKYmtMWVVvODlPK0YyY0pYcWgxUm43NVpHSkJv?=
 =?utf-8?B?RzlaVVZJZXZ2bjlycXZtRHNPbmFKT1IyeGlJYzF6dDlsSXJrR3VFbVlQYTJE?=
 =?utf-8?B?Z0gvNThFMy9ObFcvMHpwdy95OEZ1cEpkQjF3L1JDVXc4bzFrMFp2UTFFQVc4?=
 =?utf-8?B?ZGtTcmdlejB3bFc3QklrZ0RnYTFoU0VkcTZoaks1VmpJc1Bxb05uSFhLNGJS?=
 =?utf-8?B?ZkVUS3RKNFlJYUVQWEloK1FtczJHMGNWU3dCVGM1QWRJRXNoSjZXVTRvS0ls?=
 =?utf-8?B?V3JvYWdCZFhObUZwZ2h4UzVLaWZ3ZWJKUnRxMkpzZjh5ZDZiNm9ESzFETXBM?=
 =?utf-8?B?c2ZsVnJmakU4ZXdLc2FuOWl3T2JhOFRDTlJIait6WlEveitaNzRkR1l6MVJJ?=
 =?utf-8?B?elNYdW1rTWVWQTk3SE5CNDBFVlpGMjFVRkNlamNyRk9POUgybVlDRkExWjNu?=
 =?utf-8?B?VExUcUpqMFlIWjdiNE5Wd2R5emdFUGNDSDMrZWk1cG9XZ3AxaEhyWFo5TzlO?=
 =?utf-8?B?K2ozSzJqNW9RMGRWRkhCbFJvc01rbTQ4ajg4VnVGWG5DTmEzMXNPeEs2SHpX?=
 =?utf-8?B?Qlltb2RSS01SNTFJZ0dBTkFDdFI2c0VJc2NSL0FtRlY1WTYrWnBSYno1ZEFN?=
 =?utf-8?B?cERYSzlXSXpDdzNVZkhQUStOZm5GK3BYdE5DWUJQYzhjQk1GakJWM2Y3OGRF?=
 =?utf-8?B?WDYydFM5QW5oc3JNbzVvbjJrbGduWWl4QVhYcnlZMzNqVkgzaG5XWVFXY1pk?=
 =?utf-8?B?U1FvSldLZ3VFYWtBWmpqalNKNmtsNUkvelRZb1BkTkJsMFlwVWlEaGdleSth?=
 =?utf-8?B?cGNrWXA2YVBaWHRNOEo5dEJEbmxSVEsveG1jc1Jkc0QyTFl1V0hvWGFHamg4?=
 =?utf-8?B?YTlZaW01K2R4bllJOHJzTm9lVEZYbWcxUnp1a2dYeG9GSjhIQU5HdnFLa0da?=
 =?utf-8?B?dHpVZW5hV3Myd3hWbGNEMG42ZGxVc0NxejAvK2JzSlBHdmgvMXhzR2JWWjcx?=
 =?utf-8?B?WFBFTTIzNTM3SkZYQy94T2lqOUxTWTJrRWZHTVhLck5IQ1VYZWxFN0NzSHB3?=
 =?utf-8?B?ZlJGYUxBdVVCZ1lZS20rZEprdlZXV3lRdTIzSXl6dXJ3bENmWEZURk00RmRU?=
 =?utf-8?B?VzlUK0w2TjRlTE40VUliSmR5dHR3K1ptdFBzK0x0a0VrdGRMY1hwRHNVaTNO?=
 =?utf-8?B?WmdWZ1lJRy9MZGxVaHVQOURxOU8yMjZMSXloZzZrS2lNejdaUHlJazZmcklq?=
 =?utf-8?Q?Lvy12TP4eQkHz/6m1m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95719a5-3015-420a-410e-08df3691f7c3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:27:46.6662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZ0a5CbdPNS/sAhwnjjkY6uby/j1l7KSWE0iTBwD6wkuGGxHyl5Jdsg/sAvEoNM4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 04:27, vitaly.prosyak@amd.com wrote:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> The eviction-fence worker runs inside a DMA-fence signalling section.
> Userq eviction can block on reset_domain->sem while GPU recovery holds
> that semaphore and invalidates mappings. Lockdep reports the resulting
> dependency cycle through dma_fence_map.
> 
> [  +0.000295] amdgpu 0000:03:00.0: GPU reset begin!. Source:  5
> 
> [  +0.000233] ======================================================
> [  +0.000001] WARNING: possible circular locking dependency detected
> [  +0.000000] 7.2.0+ #97 Tainted: G        W
> [  +0.000001] ------------------------------------------------------
> [  +0.000001] kworker/u128:1/238 is trying to acquire lock:
> [  +0.000001] ffff897b4fcc2eb8 (&mapping->i_mmap_rwsem){++++}-{4:4}, at: unmap_mapping_pages+0x6a/0xd0
> [  +0.000005]
>               but task is already holding lock:
> [  +0.000001] ffff897b0fd60ec0 (&reset_domain->sem){++++}-{4:4}, at: amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
> [  +0.000294]
>               which lock already depends on the new lock.
> 
> [  +0.000000]
>               the existing dependency chain (in reverse order) is:
> [  +0.000001]
>               -> #3 (&reset_domain->sem){++++}-{4:4}:
> [  +0.000002]        down_read+0x30/0x180
> [  +0.000004]        amdgpu_userq_unmap_helper+0x46/0x290 [amdgpu]
> [  +0.000212]        amdgpu_userq_evict+0x4e/0xf0 [amdgpu]
> [  +0.000198]        amdgpu_eviction_fence_suspend_worker+0x51/0xf0 [amdgpu]
> [  +0.000176]        process_one_work+0x22e/0x760
> [  +0.000003]        worker_thread+0x1db/0x3d0
> [  +0.000001]        kthread+0xfe/0x140
> [  +0.000001]        ret_from_fork+0x3bd/0x470
> [  +0.000002]        ret_from_fork_asm+0x1a/0x30
> [  +0.000002]
>               -> #2 (dma_fence_map){++++}-{0:0}:
> [  +0.000003]        __dma_fence_might_wait+0x42/0xf0
> [  +0.000002]        dma_resv_lockdep+0x26d/0x3b0
> [  +0.000002]        do_one_initcall+0x74/0x3e0
> [  +0.000002]        kernel_init_freeable+0x3f8/0x6d0
> [  +0.000002]        kernel_init+0x1b/0x200
> [  +0.000002]        ret_from_fork+0x3bd/0x470
> [  +0.000001]        ret_from_fork_asm+0x1a/0x30
> [  +0.000002]
>               -> #1 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
> [  +0.000002]        __split_huge_pmd+0x86/0x190
> [  +0.000002]        vma_adjust_trans_huge+0x12b/0x1c0
> [  +0.000002]        __split_vma+0x236/0x370
> [  +0.000002]        vms_gather_munmap_vmas+0xe8/0x360
> [  +0.000001]        __mmap_region+0x2ab/0x1060
> [  +0.000001]        mmap_region+0xc4/0x180
> [  +0.000001]        do_mmap+0x48b/0x660
> [  +0.000002]        vm_mmap_pgoff+0x129/0x230
> [  +0.000002]        ksys_mmap_pgoff+0x1a2/0x270
> [  +0.000001]        __x64_sys_mmap+0x33/0x70
> [  +0.000002]        x64_sys_call+0x2194/0x26e0
> [  +0.000001]        do_syscall_64+0x103/0x6d0
> [  +0.000001]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  +0.000002]
>               -> #0 (&mapping->i_mmap_rwsem){++++}-{4:4}:
> [  +0.000002]        __lock_acquire+0x15aa/0x2740
> [  +0.000001]        lock_acquire+0xc4/0x2f0
> [  +0.000002]        down_read+0x30/0x180
> [  +0.000001]        unmap_mapping_pages+0x6a/0xd0
> [  +0.000001]        unmap_mapping_range+0x25/0x40
> [  +0.000002]        amdgpu_device_gpu_recover+0x17a/0x400 [amdgpu]
> [  +0.000168]        amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
> [  +0.000167]        process_one_work+0x22e/0x760
> [  +0.000002]        worker_thread+0x1db/0x3d0
> [  +0.000001]        kthread+0xfe/0x140
> [  +0.000001]        ret_from_fork+0x3bd/0x470
> [  +0.000001]        ret_from_fork_asm+0x1a/0x30
> [  +0.000002]
>               other info that might help us debug this:
> 
> [  +0.000000] Chain exists of:
>                 &mapping->i_mmap_rwsem --> dma_fence_map --> &reset_domain->sem
> 
> [  +0.000003]  Possible unsafe locking scenario:
> 
> [  +0.000000]        CPU0                    CPU1
> [  +0.000001]        ----                    ----
> [  +0.000001]   lock(&reset_domain->sem);
> [  +0.000001]                                lock(dma_fence_map);
> [  +0.000001]                                lock(&reset_domain->sem);
> [  +0.000001]   rlock(&mapping->i_mmap_rwsem);
> [  +0.000001]
>                *** DEADLOCK ***
> 
> [  +0.000000] 3 locks held by kworker/u128:1/238:
> [  +0.000001]  #0: ffff897b50d5f940 ((wq_completion)amdgpu-reset-dev){+.+.}-{0:0}, at: process_one_work+0x4a8/0x760
> [  +0.000003]  #1: ffffce9fc0a13e30 ((work_completion)(&adev->reset_work)){+.+.}-{0:0}, at: process_one_work+0x1ee/0x760
> [  +0.000003]  #2: ffff897b0fd60ec0 (&reset_domain->sem){++++}-{4:4}, at: amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
> [  +0.000201]
>               stack backtrace:
> [  +0.000001] CPU: 8 UID: 0 PID: 238 Comm: kworker/u128:1 Tainted: G        W           7.2.0+ #97 PREEMPT(full)
> [  +0.000002] Tainted: [W]=WARN
> [  +0.000000] Hardware name: ASUS System Product Name/ROG MAXIMUS Z790 HERO, BIOS 2703 10/17/2024
> [  +0.000001] Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
> [  +0.000165] Call Trace:
> [  +0.000000]  <TASK>
> [  +0.000001]  dump_stack_lvl+0xa5/0x110
> [  +0.000002]  dump_stack+0x10/0x20
> [  +0.000001]  print_circular_bug+0x285/0x360
> [  +0.000001]  check_noncircular+0x14c/0x170
> [  +0.000002]  __lock_acquire+0x15aa/0x2740
> [  +0.000001]  ? add_lock_to_list+0x35/0x130
> [  +0.000002]  lock_acquire+0xc4/0x2f0
> [  +0.000001]  ? unmap_mapping_pages+0x6a/0xd0
> [  +0.000002]  ? lock_acquire+0xc4/0x2f0
> [  +0.000001]  ? amdgpu_device_lock_reset_domain+0x1c/0x30 [amdgpu]
> [  +0.000196]  down_read+0x30/0x180
> [  +0.000001]  ? unmap_mapping_pages+0x6a/0xd0
> [  +0.000002]  unmap_mapping_pages+0x6a/0xd0
> [  +0.000002]  unmap_mapping_range+0x25/0x40
> [  +0.000001]  amdgpu_device_gpu_recover+0x17a/0x400 [amdgpu]
> [  +0.000163]  amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
> [  +0.000169]  process_one_work+0x22e/0x760
> [  +0.000003]  worker_thread+0x1db/0x3d0
> [  +0.000000]  ? __pfx_worker_thread+0x10/0x10
> [  +0.000001]  kthread+0xfe/0x140
> [  +0.000001]  ? __pfx_kthread+0x10/0x10
> [  +0.000001]  ret_from_fork+0x3bd/0x470
> [  +0.000001]  ? __pfx_kthread+0x10/0x10
> [  +0.000001]  ret_from_fork_asm+0x1a/0x30
> [  +0.000002]  </TASK>
> 
> Use a try-read-lock for eviction unmaps. If reset owns the semaphore,
> leave the eviction fence unsignaled and retry the worker after a short
> delay. Keep blocking read-locking for other userq unmap paths, which
> must remain serialized with reset.
> 
> Convert suspend_work to delayed work so retries can be scheduled and
> flushed during teardown.

That is definately a good catch, but at least of hand it looks like the wrong approach to solving this.

That the eviction fence worker blocks for the reset to finish is correct and should happen like this.

The problem looks more like we are trying to unmap something from the reset and that is clearly not allowed when it needs to acquire the mmap semaphore.

Regards,
Christian.

> 
> Fixes: aebf196c550e ("drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues")
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 22 ++++++++++----
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 30 ++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
>  4 files changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index a0802012de49..fe45fa164e79 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -44,7 +44,7 @@ static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
>  {
>  	struct amdgpu_eviction_fence *ev_fence = to_ev_fence(f);
>  
> -	schedule_work(&ev_fence->evf_mgr->suspend_work);
> +	schedule_delayed_work(&ev_fence->evf_mgr->suspend_work, 0);
>  	return true;
>  }
>  
> @@ -58,13 +58,15 @@ static void
>  amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  {
>  	struct amdgpu_eviction_fence_mgr *evf_mgr =
> -		container_of(work, struct amdgpu_eviction_fence_mgr,
> +		container_of(to_delayed_work(work),
> +			     struct amdgpu_eviction_fence_mgr,
>  			     suspend_work);
>  	struct amdgpu_fpriv *fpriv =
>  		container_of(evf_mgr, struct amdgpu_fpriv, evf_mgr);
>  	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
>  	struct dma_fence *ev_fence;
>  	bool cookie;
> +	int ret;
>  
>  	mutex_lock(&uq_mgr->userq_mutex);
>  
> @@ -79,7 +81,14 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
>  	cookie = dma_fence_begin_signalling();
>  
>  	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
> -	amdgpu_userq_evict(uq_mgr);
> +	ret = amdgpu_userq_evict(uq_mgr);
> +	if (ret == -EAGAIN) {
> +		dma_fence_end_signalling(cookie);
> +		dma_fence_put(ev_fence);
> +		schedule_delayed_work(&evf_mgr->suspend_work, 1);
> +		mutex_unlock(&uq_mgr->userq_mutex);
> +		return;
> +	}
>  
>  	/*
>  	 * Signaling the eviction fence must be done while holding the
> @@ -167,14 +176,15 @@ void amdgpu_evf_mgr_init(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  	evf_mgr->ev_fence_ctx = dma_fence_context_alloc(1);
>  	evf_mgr->ev_fence = dma_fence_get_stub();
>  
> -	INIT_WORK(&evf_mgr->suspend_work, amdgpu_eviction_fence_suspend_worker);
> +	INIT_DELAYED_WORK(&evf_mgr->suspend_work,
> +		  amdgpu_eviction_fence_suspend_worker);
>  }
>  
>  void amdgpu_evf_mgr_shutdown(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  {
>  	evf_mgr->shutdown = true;
>  	/* Make sure that the shutdown is visible to the suspend work */
> -	flush_work(&evf_mgr->suspend_work);
> +	flush_delayed_work(&evf_mgr->suspend_work);
>  }
>  
>  void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr)
> @@ -182,7 +192,7 @@ void amdgpu_evf_mgr_flush_suspend(struct amdgpu_eviction_fence_mgr *evf_mgr)
>  	dma_fence_wait(rcu_dereference_protected(evf_mgr->ev_fence, true),
>  		       false);
>  	/* Make sure that we are done with the last suspend work */
> -	flush_work(&evf_mgr->suspend_work);
> +	flush_delayed_work(&evf_mgr->suspend_work);
>  }
>  
>  void amdgpu_evf_mgr_fini(struct amdgpu_eviction_fence_mgr *evf_mgr)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> index 2a750add4e7b..d3c3d0769864 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
> @@ -43,7 +43,7 @@ struct amdgpu_eviction_fence_mgr {
>  	 * Only signaled while holding the userq mutex.
>  	 */
>  	struct dma_fence __rcu	*ev_fence;
> -	struct work_struct	suspend_work;
> +	struct delayed_work	suspend_work;
>  	bool			shutdown;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index ccf0ff490ac2..d652a3a7a2da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -351,16 +351,22 @@ static int amdgpu_userq_restore_helper(struct amdgpu_usermode_queue *queue)
>  	return r;
>  }
>  
> -static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
> +static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue,
> +				     bool trylock)
>  {
>  	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>  	struct amdgpu_device *adev = uq_mgr->adev;
>  	const struct amdgpu_userq_funcs *userq_funcs =
>  		adev->userq_funcs[queue->queue_type];
> -	int r;
> +	int r = 0;
>  
>  	/* The reset changes the queue state and the MES is unusable meanwhile */
> -	guard(rwsem_read)(&adev->reset_domain->sem);
> +	if (trylock) {
> +		if (!down_read_trylock(&adev->reset_domain->sem))
> +			return -EAGAIN;
> +	} else {
> +		down_read(&adev->reset_domain->sem);
> +	}
>  	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
>  	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
>  		trace_amdgpu_userq_state_start(queue);
> @@ -369,14 +375,16 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
>  		if (r) {
>  			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
>  			queue->state = AMDGPU_USERQ_STATE_HUNG;
> -			return r;
> +			goto unlock;
>  		} else {
>  			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
>  			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
>  		}
>  	}
>  
> -	return 0;
> +unlock:
> +	up_read(&adev->reset_domain->sem);
> +	return r;
>  }
>  
>  static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
> @@ -563,7 +571,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  #if defined(CONFIG_DEBUG_FS)
>  	debugfs_remove_recursive(queue->debugfs_queue);
>  #endif
> -	r = amdgpu_userq_unmap_helper(queue);
> +	r = amdgpu_userq_unmap_helper(queue, false);
>  	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  	amdgpu_userq_fence_driver_free(queue);
>  	queue->fence_drv = NULL;
> @@ -1296,7 +1304,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
>  
>  	/* Try to unmap all the queues in this process ctx */
>  	xa_for_each(&uq_mgr->userq_xa, queue_id, queue) {
> -		r = amdgpu_userq_unmap_helper(queue);
> +		r = amdgpu_userq_unmap_helper(queue, true);
> +		if (r == -EAGAIN)
> +			return r;
>  		if (r)
>  			ret = r;
>  	}
> @@ -1327,10 +1337,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  	}
>  }
>  
> -void
> +int
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
>  {
> -	amdgpu_userq_evict_all(uq_mgr);
> +	return amdgpu_userq_evict_all(uq_mgr);
>  }
>  
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
> @@ -1422,7 +1432,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>  		if (adev->in_s0ix)
>  			r = amdgpu_userq_preempt_helper(queue);
>  		else
> -			r = amdgpu_userq_unmap_helper(queue);
> +			r = amdgpu_userq_unmap_helper(queue, false);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 488dc21d7c81..4dcf6151de6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -163,7 +163,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
>  
>  void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
> -void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
> +int amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>  				  struct amdgpu_eviction_fence_mgr *evf_mgr);

