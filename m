Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334A2CA5FCB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 14:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2ECC10E047;
	Thu,  1 Oct 2026 14:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GgT33PsB";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A30C10E047
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 14:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ms2H2jrq8ia3EWmHQ6w9Ys6zyvgs7ehfJVOEt5lnWn/k9F5hm3zn91bb7tBEHM5jsmE2sN7eY/UG1N99hkA1TAEsqXnusnBeAmFPYaFuADddpA0mkQRTN6jDOyQLfGPli1BE88vwRJiRti4sefJA2l8CEHRdAz1m2+ra3uHKMhPFXxPdYk45FLE2yiKbhIOGPD75rnu8+1A4ee2uZ57cfmRuVrmdAeJ5y1UiSR6IIefwqsl8u1l1E36HYxgEoBoSy2gxOJS33TsES7OAMcpys4cBjGghElXsLGCfCdGpWVLM9RCU7+tFHXRRHP17i7uLa8tOrpH/zUpkAPJXYvRkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hE19lD0PkyVYstDtcWFNWXWFk6HJ5PRHtfqu3x/cBc=;
 b=fyLgsw+htnCyGSwBzHwOqcgNJmwDVshHT7FzpDj7noz/HRRqG7JIWEXkOa0f4SxOZSTOKn139e+ouZHdOmgVWHdhRplmt0EHqlwqgRVrymQSutmpE/0XMKMbRK1ZZf5EfAdtzHn27z9h2w8rmBp7VtPIZwnL+RDLzhO7rUAPGMCuWooncMNqZ+D4wCPiYRb1alKWZ/hnRvHM6G5w5uVM+bz0HWRL7UHPoYzNKZqUFmXRDX3Ga22ioGwS8sO6fqxOpYRHxNH2uf+GAlA5cGe+bXBdcfjVCdem8q+9lzcpha9Hhif1IYZSr8MKqZxv9B3IsYZmIdbiqmVJzqSNvuOrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hE19lD0PkyVYstDtcWFNWXWFk6HJ5PRHtfqu3x/cBc=;
 b=GgT33PsBSqdoo1Ruyj/73nku+0blD/uKunXKaa3idxRUDGQBxBzRWWd3glEo3YC9D+PPtNNtoLyblnTxpUCVNFI7nnKQlMhIYgtxZs1F+S9NBjzKWbsdCQ6O2Cdd0KMPU69ujdab1OVSWwadySkGGKaroKYlsGI/ZvgqqV0ZUhc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9624.namprd12.prod.outlook.com (2603:10b6:610:2b3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 14:46:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 14:46:12 +0000
Message-ID: <9fd8dc27-8047-4cea-8ca6-a941446f92db@amd.com>
Date: Thu, 1 Oct 2026 16:46:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
To: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260930154934.27981-1-mikhail.v.gavrilov@gmail.com>
 <957a0ec9-a772-400a-b633-ecf41d16a2b7@amd.com>
 <48abb339-31a7-4083-8775-722fa010f34b@amd.com>
 <DS0PR12MB79937883FC1952B821439A27F78A2@DS0PR12MB7993.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS0PR12MB79937883FC1952B821439A27F78A2@DS0PR12MB7993.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9624:EE_
X-MS-Office365-Filtering-Correlation-Id: d833c86b-6c10-4711-a842-08df1fcabc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: H20lS3jH8oluB98L0p8LaMs0w4sEF5Jr7ITbqMuMXZkmBSnUZ5EELQRBrKqWnyKOsIGH7TSpQSBjcixMM5sZJ6Bq8/+8RzzalbtTfMfx4HzSb5OzC42qBGN1I7VbYeB2qjzsrg2+XDNJ+Q8OpymNehWGYEFCEZW90Uc7Ovg+ldZMNZfSSqqNo6+O4mL0xA5sWDEV4q3d6pcoHNHkxNZIJ5rPvSq68aC/V0Xf+WgkH9oBPD2NndFTPFE8XaNImuDwBTDZ91oK12c8w5nFl3Kfz+UpT431XTXFCNkqitlbZ3z3BMmn7+dXja5uTgC3Ew1IZ1OWEHDd4r3hQIA+E3kEpwpwl+tz20saPIajTmgdwMLRsnHIPl+mc26saXybJln5icFjf53SWBLlB3guAnwphcp3v84mQcrOlLNZfvwBJBLQVxhurseqb+ZdQWfxyxAaTeM10Hj+rU9/jI58jZDwEsFm9YXd/ddiV/JNC94NdPCIEhqK/q73ip3pUFK47hkiD9DP/rjFAiEICnxUMm+kc7okwo3gGvaymvctv9tf0yE3OuDw1i1v3af8BB+Jlj4RVoN8pffsYuX1TgpdlaZ9nuOVyFlb7tAqovCP5Rpf2FN2qN3a26j0QfH8/hztcVOvkGP2p16JJ0t87fBzMbXZX+yXI2C2pbeJSw5j36HJ4jc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUM5ZnNFaUhSa0M4bTd2T1hrcWVqd3hwemVQQVF5ano5cEVmN29wWG1vNWty?=
 =?utf-8?B?dk5aelUzUXZPYysza2lYVDlkcTNZQ2EzM0RvU1BLcmFQSXhlYldnblpvdlp5?=
 =?utf-8?B?T3F4QjkxYWRWaDJkOWs2WHRBYk1SVm1wV2VERFo5UlhaMkFNYTcrOThUa0Fl?=
 =?utf-8?B?Z0FBQ0VXWXAwd3d3R3o0SHV2TjVsU3JBaUZVMm5pOEF5TjhSV0JPem93T0ta?=
 =?utf-8?B?Q3JUZ3FwOUw3Z1Y5WUxFRjVQTjZLWSs1ZzdqTWJ4aVZ2WFpRMnVuTWRZcTRu?=
 =?utf-8?B?L3Y0dThDaXg2bUhGTXdpaGhvenpnc1hETWorMHd0alVNYmZ5TG55WXR5Rkdt?=
 =?utf-8?B?a2srdXo0RDR3TFJ3VUtGRCthVmp4ZWVHc1QreGZpVDdmZWRoME5wUU4vcUdr?=
 =?utf-8?B?N1h4RFIxVkVSN21UNVNYVlE5RHZLR0NhWHFYbGc1RGFybXR5bWR2MFZ6NkZp?=
 =?utf-8?B?OVF5WEg1NjgzamtOL24yYWIzWjNpMGpUcEZib0tDUWs2VkFWeDRWRDhaZkRL?=
 =?utf-8?B?VXU1NTd5UXNZL3UycE5yUGk0Q29JaHlSVTg0bkVWTXBWeVJ1YUdwVzd4R3kv?=
 =?utf-8?B?MlZFcDdaZEJtQURQV1M2L3B3a090ZmpVNnNlSEVpbGd3K0dzWFVOb0YzQ3VM?=
 =?utf-8?B?dmhCSVdyQ3B1S2FsSU1zYjc3c1d2OC8yb05yekgrM1g0cGx1SXBnUEYwMnB1?=
 =?utf-8?B?S1BaMjFpTXIxanFYNGs2RnJCcGFGQk1ndXIvTjhmUGpWL1RNZGFLNEdkREhS?=
 =?utf-8?B?RVl0ZFJDd3lkdFVINXd5c0ltK0tjQ2xlKzA1Tm96Slo1ZkFEU3hoaWNrQjFw?=
 =?utf-8?B?U1UrNVVSRlVBdFp2cUFWOE5BTHhXSlVhc25mbXNkTDhRWDRPUzZ3NTU2cjFo?=
 =?utf-8?B?YVlTRk93Y2NObjNVOFlyQUg3NFNLaHpYVDJ2Wk1iZGRSTFlCam5ENGcvVEVH?=
 =?utf-8?B?THBaaFlLKzZwN1BTUHFqV3hXY3RBS3FpV3FWV0VHR0VRT0NzL01lSnFPSlBm?=
 =?utf-8?B?NWRYM2hpczJ6RU15djkybW16aUpLYlp6S3F3V09EZTVNNm1NREJpTjdKZksv?=
 =?utf-8?B?Ukl6UlZHbnVwRjQwNklwemJPR1pac3M4M0pHcHQvUFZsUWRiRG5nOEtLYzh6?=
 =?utf-8?B?dTgzU3ZlUzBNUHJYamZtb3JZMllJL0ZIa2J2V0dZQ3NDZzZmQmZBRkVWOVVJ?=
 =?utf-8?B?cWtnL0tLRnQ4djJVS3Vqa04zaHNUU3JNYnpHckgzalQwcjN3ZWZpLzV3Smp5?=
 =?utf-8?B?WGZualU2Skhid0FnTjBORUlHbXRXNlU1N0V5bkZiR1FBYnVyUUhpV1NHRzRw?=
 =?utf-8?B?c1RoR0wzT3IzMzZKREFYSlZlcGMwc3Jkd3ROa1NvZXlpQWlVaW53T3BWY0VS?=
 =?utf-8?B?WVR6Z1lqcnQvalRYL3F6bGVYMHZCbXlmc0ZNRFNyUXlsemMybjR2dXBzWlkw?=
 =?utf-8?B?VldvN2l6eHp2Wk9kOGYrS1RDTlJsR1g3OWREbzlJL1lpZU9Yc3Q4TlM2ZEdC?=
 =?utf-8?B?VFpkZmdRRW9EV1JUZnRvY0lvczRIem9TTmxQQWpxSXBNT0JzdHZPeUhTaHpC?=
 =?utf-8?B?UlY3UDQvVlpVcE45ZTVldE9kS0F3ODFjRlJFRmhHVUg5L3hSMk5FY0NYakhG?=
 =?utf-8?B?MzhCRkx2TDJQdmFncHpLdGlWVVBWZFMyVTFpTjk0UmFHeXJvWVgwMkxRVzJD?=
 =?utf-8?B?ZGJzQVYvRDB2K0hHZTBNTmFuOUZyWDZvNHZmZlFweXBFaDhZVC9CMkNQYVZ2?=
 =?utf-8?B?dFpsMEdyR2F0ZzI4MWttbGw1QTMxY0dTU2RlV1JYQXkyajdQMksxemcvQ2Jl?=
 =?utf-8?B?MWdzaEpGTVZtY1k5Rm90aWlsOFM5YzRzdkFPSWlzRDVWcHRhZ2wrckh3VktY?=
 =?utf-8?B?UlFuUFBVVDBBRTNETTZTd0lnRGhpcml2UkgvR2NLMTJIR3BFaDgrMmhYSFQ0?=
 =?utf-8?B?enFjMjJPbjd2MXpQaUNsRG95R3JZR21vYWJZQTR1Syt0OTBFd0MyVmd4U2F5?=
 =?utf-8?B?TndZdmpFK0ZISWcxZ2x0YWdKL3FsRDR6czBmcEVuS3p1dmJlNFFRSnpYV0tH?=
 =?utf-8?B?dTZvNXZWQmlXL3RYRWtPRFY5SCsrWThJZ1RmQnpXT0NuQ0Nzb0E2MGJBM1lw?=
 =?utf-8?B?dTFYQlVoelBkUWxSczJZUEl1VmplNDJvSWF4ZXBTM2hCYU5sTndGaWdsSTE5?=
 =?utf-8?B?c1VKWHY3L0FpRFZpRnNrVTVHNEJPVTUrK003VThtS0hva2lMTkMycS8yVStO?=
 =?utf-8?B?RUIxcWQzN3FtOEN2QzMrR29uZ1lxY0RTZzR5Y2hWN2JoTmFSS3pHUG03QWxJ?=
 =?utf-8?Q?AapG59cgQieZXdLjof?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d833c86b-6c10-4711-a842-08df1fcabc8d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:46:11.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KcEBEbP87diBblMYk/HmsXHdf/fEMWb/FbwQWMA9kUMVWJkGah14Pa0fKzTLRCr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9624
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

Limiting it to a PAGE_SIZE sounds reasonable to me as well.

BTW: kvmalloc() is only needed for much larger allocations (up to 2GiB), for a page kmalloc() should perfectly do it.

And I agree as well that this is probably needed for gprwave handling as well.

Christian.

On 10/1/26 16:25, StDenis, Tom wrote:
> There is minimal checking on top (e.g. size & 3 and offset & 3) which is required by both the hardware and umr.  I agree the PAGE_SIZE check is a good idea.
> 
> umr really should only be doing 4 byte accesses at a time which is how the inner library API is designed it's generally assumed registers aren't contiguous.
> 
> I wonder if a similar fix is needed for gprwave reads as well?
> 
> Tom
> 
> 
> ________________________________________
> From: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
> Sent: Thursday, October 1, 2026 10:00
> To: Koenig, Christian; Mikhail Gavrilov; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander; Prosyak, Vitaly; StDenis, Tom
> Subject: Re: [PATCH] drm/amdgpu: copy debugfs register data outside the GRBM/SRBM locks
> 
> Mikhail's proposed kvmalloc(size, GFP_KERNEL) correctly stages user data outside the GRBM/SRBM locks, avoiding a potential page fault while holding those locks.
> However, since size is derived directly from a userspace read or write request, we must validate it before allocating memory in both amdgpu_debugfs_process_reg_op() and amdgpu_debugfs_regs2_op().
> 
> Tom, do you agree with this? Will adding a restriction here break any UMR  requests?
> Please add a bounds check in each handler after the existing alignment/offset validation and immediately before kvmalloc():
> 
> if (size > PAGE_SIZE)
>     return -EINVAL;
> 
> data = kvmalloc(size, GFP_KERNEL);
> if (!data)
>     return -ENOMEM;
> 
> With that input validation addressed:
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> 
> 
> On 2026-10-01 02:12, Christian König wrote:
>> On 9/30/26 17:49, Mikhail Gavrilov wrote:
>>> Reading or writing a register through the amdgpu_regs2 debugfs file
>>> with GRBM bank selection, which umr does for every banked access (a
>>> single "umr -b x x x -r <reg>" is enough, as is the wave dump with
>>> "-O halt_waves"), makes lockdep report a circular locking dependency,
>>> after which lockdep stays off until reboot:
>>>
>>>   WARNING: possible circular locking dependency detected
>>>   umr/63306 is trying to acquire lock:
>>>   ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/0x140
>>>   but task is already holding lock:
>>>   ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debugfs_regs2_op.isra.0+0x20d/0xd00 [amdgpu]
>>>   ...
>>>   Chain exists of:
>>>     &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key
>>>   ...
>>>    __might_fault+0xc5/0x140
>>>    amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]
>>>    full_proxy_write+0x10e/0x1d0
>>>    vfs_write+0x1d0/0xf50
>>>    ksys_write+0x116/0x250
>>>
>>> amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call
>>> get_user()/put_user() for every dword while holding grbm_idx_mutex or
>>> srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock
>>> inside those locks. The lock hierarchy declared in amdgpu_lockdep.c since
>>> commit 1d0f5838b126
>>> ("drm/amdgpu: Add lockdep annotations for lock ordering validation") puts
>>> srbm_mutex and grbm_idx_mutex below notifier_lock, which
>>> amdgpu_cs_submit() takes with the BO reservations held, and
>>> dma_resv_lockdep() orders the reservations inside mmap_lock. So
>>> mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two
>>> debugfs paths nest it the other way round.
>>>
>>> Copy the user buffer in before any of the locks is taken and the result
>>> out after all of them are dropped, as amdgpu_debugfs_wave_read(),
>>> amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.
>>> A fault on the user buffer of a write now fails with -EFAULT before any
>>> register is written, instead of after a partial write.
>>>
>>> Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
>> Well that's not really correct since that patch only makes the problem visible and not introduce it :)
>>
>> But apart from that rather good catch, Vitalies work to add lockdep annotations pays of.
>>
>>> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>> I don't have time to review this in detail. Vitaly and Tom please take a look at this.
>>
>> But feel free to add Acked-by: Christian König <christian.koenig@amd.com>
>>
>> Thanks in advance,
>> Christian.
>>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 71 ++++++++++++---------
>>>  1 file changed, 40 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index aca1a8045afa..5618bd3e2610 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -121,6 +121,17 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>>>
>>>      *pos &= (1UL << 22) - 1;
>>>
>>> +    /*
>>> +     * Access the user buffer only while none of the locks below are held:
>>> +     * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
>>> +     * inside it.
>>> +     */
>>> +    u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
>>> +    if (!data)
>>> +            return -ENOMEM;
>>> +    if (!read && copy_from_user(data, buf, size))
>>> +            return -EFAULT;
>>> +
>>>      r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>      if (r < 0) {
>>>              pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -152,28 +163,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>>>              mutex_lock(&adev->pm.mutex);
>>>
>>>      while (size) {
>>> -            uint32_t value;
>>> -
>>> -            if (read) {
>>> -                    value = RREG32(*pos >> 2);
>>> -                    r = put_user(value, (uint32_t *)buf);
>>> -            } else {
>>> -                    r = get_user(value, (uint32_t *)buf);
>>> -                    if (!r)
>>> -                            amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
>>> -            }
>>> -            if (r) {
>>> -                    result = r;
>>> -                    goto end;
>>> -            }
>>> +            if (read)
>>> +                    data[result >> 2] = RREG32(*pos >> 2);
>>> +            else
>>> +                    amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2], 0);
>>>
>>>              result += 4;
>>> -            buf += 4;
>>>              *pos += 4;
>>>              size -= 4;
>>>      }
>>>
>>> -end:
>>>      if (use_bank) {
>>>              amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>>>              mutex_unlock(&adev->grbm_idx_mutex);
>>> @@ -188,6 +187,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>>>      pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>>      amdgpu_virt_disable_access_debugfs(adev);
>>> +
>>> +    if (read && copy_to_user(buf, data, result))
>>> +            return -EFAULT;
>>> +
>>>      return result;
>>>  }
>>>
>>> @@ -238,11 +241,21 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>>>      struct amdgpu_device *adev = rd->adev;
>>>      ssize_t result = 0;
>>>      int r;
>>> -    uint32_t value;
>>>
>>>      if (size & 0x3 || offset & 0x3)
>>>              return -EINVAL;
>>>
>>> +    /*
>>> +     * Access the user buffer only while none of the locks below are held:
>>> +     * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
>>> +     * inside it.
>>> +     */
>>> +    u32 *data __free(kvfree) = kvmalloc(size, GFP_KERNEL);
>>> +    if (!data)
>>> +            return -ENOMEM;
>>> +    if (write_en && copy_from_user(data, buf, size))
>>> +            return -EFAULT;
>>> +
>>>      r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>>      if (r < 0) {
>>>              pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> @@ -281,24 +294,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>>>              mutex_lock(&adev->pm.mutex);
>>>
>>>      while (size) {
>>> -            if (!write_en) {
>>> -                    value = RREG32(offset >> 2);
>>> -                    r = put_user(value, (uint32_t *)buf);
>>> -            } else {
>>> -                    r = get_user(value, (uint32_t *)buf);
>>> -                    if (!r)
>>> -                            amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value, rd->id.xcc_id);
>>> -            }
>>> -            if (r) {
>>> -                    result = r;
>>> -                    goto end;
>>> -            }
>>> +            if (!write_en)
>>> +                    data[result >> 2] = RREG32(offset >> 2);
>>> +            else
>>> +                    amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[result >> 2],
>>> +                                            rd->id.xcc_id);
>>>              offset += 4;
>>>              size -= 4;
>>>              result += 4;
>>> -            buf += 4;
>>>      }
>>> -end:
>>> +
>>>      if (rd->id.use_grbm) {
>>>              amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, rd->id.xcc_id);
>>>              mutex_unlock(&adev->grbm_idx_mutex);
>>> @@ -317,6 +322,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>>>      pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>>
>>>      amdgpu_virt_disable_access_debugfs(adev);
>>> +
>>> +    if (!write_en && copy_to_user(buf, data, result))
>>> +            return -EFAULT;
>>> +
>>>      return result;
>>>  }
>>>

