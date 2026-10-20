Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8188D606A319
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g/OcUwKR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2275110E3B0;
	Tue, 20 Oct 2026 18:00:45 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013060.outbound.protection.outlook.com
 [40.93.196.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB50810E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 18:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhlLnLXQ6MZw8kVDJqjyZoDW39LXgdIyR42wxxA6vxFZKsy2DnY//H2clfkPMiF5RabGXKXw42WDc6IKFBS7nc35xvttQcVsHrM+N0G1uQLzIxXQHag68y2RbJbFPSZpAh32+jV26NzMfWdqbER6bbVA5V3Y6Ec4z/z9HIxTjJbVAzD9Aq45pcvvV59WAD5Z+uzS//dXytpbZy6FmU+tbA9i45mrSRqbXHxoFRekXZrT6AmopT/o66FMBrx52TxK4Uj8DFzJIxCIzqLDnFNfKroc7MrQEY+Hhbv+L0RilGNHTiZWNWELaH08pA9OrsEGDBZwqi+whl9f8wchP/daVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsxPXC+TKKyat3ScEM00gByQh46oRZlzFCFskwIRsUE=;
 b=Zf28K280w0kvlu/tp6LfamU39x1OW+rRXTxTsKalCyGKiPTlfPVHNkNNivsA3BR/UGWdGAPrYLwfgCduBJ9tnDfUhUtw58WJykYNWp9n0txcXjqLnoFk5Gdy1wncyHsV8HsrMEZge7AujQYsVXJAjrcbGneGFomZLYirdkjgUnZwUPt8OfLUgHvfAi6g/MySdYA0ceVCT1NcLTIlLFCMuk+t6yP3p4h2SQDugJvJJOhLcz6OK1jRSqcMGVSWj4NJahLeZM0ANbZMw97YXeuUXm/8k4t8FO29alA9W6YTeBTawqrwGbEeAXtvN0NyLapYtZJvcXumKUwiWVmAIXazLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsxPXC+TKKyat3ScEM00gByQh46oRZlzFCFskwIRsUE=;
 b=g/OcUwKRMrrk36YV/CFNGPXH0FkIe2dEkshcfUG0X2oa4MeZ3MBdIL7FoCplTIcjZ6145BF7389zUVW+5JzGzM/zhtuWCWbZTmxk4yfrsqhWqiM6jAwhcaXyFlebMNHE98PJnuQHtR2rI+ZB/W/3xE8jd+WXXbLD+VJfbiW7Y04=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CY8PR12MB9033.namprd12.prod.outlook.com
 (2603:10b6:930:71::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 18:00:34 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 18:00:34 +0000
Message-ID: <c5778c29-2375-4f6d-ae05-4416097ef1b1@amd.com>
Date: Tue, 20 Oct 2026 14:00:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] drm/amdkfd: wait for a GPU reset before freeing a BO
To: Philip Yang <yangp@amd.com>, William Palacek <William.Palacek@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Kent.Russell@amd.com,
 Harish.Kasiviswanathan@amd.com
References: <20261016153236.1163913-1-William.Palacek@amd.com>
 <edbb95b8-e3c9-42f9-afb0-2525438d8789@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <edbb95b8-e3c9-42f9-afb0-2525438d8789@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0401.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::25) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd3cab8-55e7-4bcb-bae7-08df2ed409cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|56012099006|260925021911599003|4143699003|11063799006|5023799004|260925021311599003|260925022911599003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4rTdCOrOAjox5Eotf5HzfU9zMyPcAjjwsEtQlN6Cf/ReGLFf0yR0ijBXTX5kpRndYbEtDQ7U6zSb5ZLyXgDVwqDN4ZibVzV2URo+tomuWsHrySGfX2wBnI2cb23bmVAo94EhCOLFibBK6hxwBCnAKfWkw9ecjSxSiKQL5A4ClK2jfOnM3G2GUBYXdcwcL0x28pAidWR0+YC8U1NiTCLAzFCJ3D4CTNCBHJMx/w5eU5rttzfEIFPYZ/MRLd8uno5Ll5VwdTsM/Puwloq6+RNUAU6T2B0o0f9lom7ZrpW7OtFIR22FtPoEuY/aVx2NIcieDFTKuFpGgmjgxS/DL69GmJdm0x0j23kXr9i6JR2zk9KRixXFMK+LNtNzqMaLlGarxD/dOuz+gne7P8B/qvNty3Jqd+KTbh3Oe2qgrok8kGJa+jHHPU9fc756HoWFtlgSb5rRKuaIxmiN+WceWIyz4MvTrynJxZ2D+psFT8VU7SEmf/p1q130GD6vIbUVgT7fe8OmFEEpnx8f4KwDCw9txZ0aHVebGRp6nf+LKjmzzXM+MKQXu/18r5WcVykJcgvrK4zTNNzzKqGOlAbg0iCRkGclsu1oGIiX6SmYsGjotIwvs6zH5JVxTmMsfStVOr1vBS6EQtoCTUxuOGS/P9mLBxUeELL+Mn9dOQ1D3Emm5is=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(260925021911599003)(4143699003)(11063799006)(5023799004)(260925021311599003)(260925022911599003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZzQTVCOHZUMjFFb3Y3aDdmUFl5ZDlvS0ZnaW1SVzRUNERsNEpNWG9uYklW?=
 =?utf-8?B?Q09OVm9uUFUvNXlzUkRNWThmRDhzcHpjMmVwS3M0TXRBYytlTDJCZlFJVnJy?=
 =?utf-8?B?Qi80RFkveHJvK0FESUsxWVpWRHE3aitlWEhYZmt6Wk1GbWJ2RFR1cFpCQlU4?=
 =?utf-8?B?QWREWTdWUSsrL0FaNEt0WXl1ZHBkUGMvVlpobnZ6cDZtRGNvVU9MZnBNMTAx?=
 =?utf-8?B?RmlrNWdQR0RJYmlpcDVrY0lhQ1pHYmUxYTA3YTNFQlpvVUkrakJ6c25qekQ3?=
 =?utf-8?B?US9XdVRad1VSaFo3cGlPMjQ1RlNHdXVjYmhrK2dQeFIyR2pPQXJmZFZ3M1d0?=
 =?utf-8?B?QUppVm1WSXZmWllIcDkweFRZY0F2cTcveWRVbzd1UjZ3K0s5YWRnMmgrOTJv?=
 =?utf-8?B?WndkMmhYdCtXL3c4OW9EWFJBcjd3Sk4yUU1xQ01hTkVhZEplMm5YN2dvQkFx?=
 =?utf-8?B?WWQxYnUrZFRYS3BxaWsvS0NCNVVkVEwrVkNmK2U4TUEvNU1mU01kUE5RM0I5?=
 =?utf-8?B?YnhiMXd0NTN4MVppUTN3dVFKdEN1clFwWWtQS0tsd0ZnV1VONTVHeFdXcjlD?=
 =?utf-8?B?dml0NUxwdVJ5UlZlOFpNRisyWFFnaElkN0hEbUdvZFNlOC9lRGRTbDdteHJr?=
 =?utf-8?B?YVZranJ1S0VpSnFQTHRkeWRGZldiSnJMc2hqQnVoUHR3NVZWTXpUYjhRbW9h?=
 =?utf-8?B?Y1l4cDQwTW1FeGlhSkJ4VXNUbXMwVWtOUEhoeGRtTm8wbnBQcm1pV3hHenJC?=
 =?utf-8?B?aWdiOXJMQmEwaGFRNVE2Ynd1SlRKRTF0bi80VWpMUzZkV2hVektuMEVXU3BN?=
 =?utf-8?B?YXF2UkJURklMSUhlNUNhekJnSTB5RUNRYlg4OU1mNWhUbVVwUklCSXY4ZG14?=
 =?utf-8?B?U1JaWVFVT2preFl5dFY2ZXdXWVJVMklaK0Nwdy96TlhXSzFvMEllalNNaVpB?=
 =?utf-8?B?VGtZWHBHemZnY25qNFpjS3JLRXN1OXFDUmI4RVNwWnJCTFBuK3VSM3BvRTlS?=
 =?utf-8?B?M1A4bXFpSXRkV1lMNTZSOHc2Qm04bGtULzA0QU1DUzBhQm9QeUU3UWZ4OUhk?=
 =?utf-8?B?eEptUXlKSjl0cXVMUmxUN2RvcU80dENLbnJtNGVlUVl4QzVKY2NKVm5mWDFy?=
 =?utf-8?B?VDdvaVJVZXZ6UGp4dEx5cjQyYWJuREl2cG1zcnROVFoveDBJLzk4M25rdmZ3?=
 =?utf-8?B?WXFQT2grcFRpckNjcTBhRGQ2MzhTUHdLS21DQ1RMQXhZSm5rQVQ1YysvOFc1?=
 =?utf-8?B?cVA1S1M4dUpQaDZEOWxya0Z0YXgwRW1SY1ZyRzZScUY3RXZZTnlUT0dSQnkz?=
 =?utf-8?B?YUF0MEVNSHo1RzZJMXRPdDVxVGNCQXlmSDE2Z2hSZjBaUDlXbE9NeTFrekcy?=
 =?utf-8?B?TkZPcXJhbzRyWjQ2RHBycktvT3Eva2ZkS1JYbUN1V3ZUNDFtQmRFbkI4UTdr?=
 =?utf-8?B?UWM0anprS3doR3VvT0N1WUltdzJ0aFl4eVBiQkxzdzJkUzJReGp0K0lyR281?=
 =?utf-8?B?THBvdVFQeUpPY2wzQXQ0S25LZE9rcVZqT3V1Z3FubmI0dnhGcElpS2lQQmo1?=
 =?utf-8?B?Z1JaRm82QVBPNGZ6V2JBejNGV0hDMFJwZ0ZYR1B4VGU3N1BWakkwdjdXMmJ4?=
 =?utf-8?B?NGRCYVVHT1ZpYWRLOFZiaC9ESlZpQXE4L2EvNUVac1BXN3huOWJqMm1IdDBy?=
 =?utf-8?B?Slk4dUZJekZidkFidDhjbkV3bHZtMTRmTlAxTmJhZkxCcDdvVVcyUEx0VzVZ?=
 =?utf-8?B?eDB6dGpPUUhvYnBXOVVyZkhyUjBOTHk5WVNwTjFGb04rb1ZpRXhsL2ZHMkNK?=
 =?utf-8?B?MXV4aXU1Z255MlFoNXNhd2JCQmJubTQ5VHNvQnZiWWNGa2xGcXdsdjRyUXcy?=
 =?utf-8?B?UjdaVXdHUDhqTUxyaGhmUDRBWkRzdkZhR2E5c2lnLzRORmlLa0x4bXV0d0hO?=
 =?utf-8?B?YnJGM0pzSFp6SnhyajM0YnlMSW1BaG9GVFZJWm5YSjQyZlMzR0h0ekpwWkt4?=
 =?utf-8?B?OUJhM2xrd3VlbWtINW1aS09xUXFrM0VKK0tGMVNaVjZUb0dwMTZTdnNZMkpL?=
 =?utf-8?B?ZzdscFVKbHNRaWs5NnJzY2VpZDVKMXRyNytNR2ZmZTdNZDZaK0JiNnFRNVRs?=
 =?utf-8?B?VERJdEpVekhoVDlXdnF3ZzRYSE92WENyNDJvQ0RSU0lBSGE4dGRoRHJJdGg5?=
 =?utf-8?B?ZFczV29MZlA5a3VjTTlWOG8rWHBPWnVrbzZBdVdqWmZtRnV5NHJzU0pWR3dv?=
 =?utf-8?B?LzYvcHBhZmgxSkNlNktoTWl4YkwwVitzMmhGcTM0RHdpZ2NpeTZHNmJIWmVX?=
 =?utf-8?B?V1M2OXNwK3phUFpHdU1PZjhlQnIvUGZsazJpOXk2STg1Z2x1VHJjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd3cab8-55e7-4bcb-bae7-08df2ed409cb
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 18:00:34.4595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAgBTml5e7aBfi0jbZB9XZVsN7jZcurpEF/eKEgaA3xWxCdlRgq1tB+NaBCEMJ7ui6TvJcWlNDVZvcuXClbySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20 10:20, Philip Yang wrote:
>
>
> On 2026-10-16 11:32, William Palacek wrote:
>> When a GPU reset takes the reset domain, KFD eviction cannot unmap
>> user queues: execute_queues_cpsch() fails its trylock with -EIO, so
>> the queues keep running until the ASIC is reset. The TLB flush is also
>> skipped while the reset is in progress. If the process unmaps and frees
>> a BO in that window, its pages are released while a queue can still
>> access them through stale translations.
>>
>> On MI300X, munmap() then crashes in free_swap_cache() on a small bogus
>> page pointer in its mmu_gather batch page:
>>
>>    BUG: unable to handle page fault for address: 0000000000002900
>>    RIP: 0010:free_swap_cache+0x5/0xb0
>>    Call Trace:
>>     free_pages_and_swap_cache+0x3a/0x60
>>     tlb_batch_pages_flush+0x43/0x80
>>     tlb_flush_mmu+0x3d/0x110
>>     zap_pte_range+0x80d/0xcd0
>>     ...
>>     do_vmi_align_munmap+0x3e8/0x5b0
>>     do_vmi_munmap+0xdf/0x190
>>     __vm_munmap+0xad/0x180
>>     __x64_sys_munmap+0x1b/0x30
>>
>> In a traced crash the bogus pointer was the read pointer value of an SDMA
>> queue the process had just destroyed, at the read pointer's page offset:
>> the queue's writeback landed in its freed rptr page after the page was
>> reused as the batch page.
>>
>> commit f0b4440cdc18 ("drm/amdkfd: Fix mode1 reset crash issue") fixed
>> this race on process exit by waiting for the reset to complete before
>> freeing the process's BOs. Free through the ioctl has the same race.
>> Wait for the reset there too, using the same helper.
> On GPU reset, kgd2kfd_pre_reset() sends a reset event to all processes 
> and ROCr then aborts the process. This is unfortunately racy: the 
> process can still be calling ioctls into KFD while the GPU reset is in 
> progress. The expectation is that the process stops issuing ioctls and 
> exits, after which kfd_process_wq_release() cleans up the remaining 
> system/VRAM memory, queues and so on.
>
> Waiting for the GPU reset to complete inside the ioctl is not an 
> option. Once the thread blocks in the kernel on something like 
> flush_workqueue(), the wait is uninterruptible, so the pending 
> abort/exit cannot be delivered and the thread sits in D state until 
> the reset finishes. That defeats the whole point of aborting the process.

I disagree. Aborting the process is a consequence of losing GPU state. 
It's up to user mode when they abort after they receive the 
notification. The kernel mode driver cannot make any assumptions when 
that abort will happen, or whether it happens at all. The only thing 
that's guaranteed is, that the user mode queues of the process stay 
evicted (unmapped) permanently after the reset is completed, and any new 
queues will also not be mapped on the GPU.

A GPU reset is time-bounded. It may take a few seconds, but it will 
complete. After that, any process in D state will recover. I don't think 
this is a fundamental problem. If you want to be able to handle signals 
while waiting for a GPU reset in an ioctl, you could also use 
interruptible waiting.


>
> kgd2kfd_suspend_process() in the pre-reset path also sets the 
> kfd_locked flag, which is used to prevent a new KFD process from 
> opening the KFD node while a GPU reset is in progress.
>
> So I think we could check kfd_locked and return -EBUSY from the KFD 
> ioctls. The application retries, eventually gets aborted, and the KFD 
> cleanup worker frees the resources once the GPU reset has completed.

A GPU reset on one GPU should not affect a running process that's not 
using that GPU. Looking at kfd_locked doesn't give you enough 
information because it is global.

Regards,
   Felix


>
> Regards,
> Philip
>> Fixes: 9c33e5fd4fb6 ("drm/amdgpu: fix locking scope when flushing tlb")
>> Signed-off-by: William Palacek<William.Palacek@amd.com>
>> ---
>> Christian, Felix suggested asking you about a lower-level fix. In the
>> traces, the TLB flushes during the reset returned right away without
>> flushing, because amdgpu_gmc_flush_gpu_tlb_pasid_xccs() returns 0 when
>> it can't take the reset domain lock. So callers free memory the queue
>> can still access until the ASIC reset. The SVM munmap path goes through
>> the same flush. Felix thought a more general solution may be in
>> amdgpu_object.c or amdgpu_ttm.c. amdgpu_bo_release_notify() already adds
>> the wipe-on-release fence so TTM delays freeing the BO. Could a fence
>> that signals when the reset completes hold the pages the same way, or is
>> there a better place?
>>
>> v5: new approach, replaces "drm/amdkfd: discard interrupts during a GPU
>>      reset" (v4) and "drm/amdgpu: preempt KFD queues before taking the
>>      reset domain lock" (v1-v3)
>>      - v4 did not address the munmap Oops (Felix). Fix the cause instead:
>>        BOs freed during a reset while user queues still access them
>>      - Reuse kfd_process_wait_gpu_reset_complete() from commit
>>        f0b4440cdc18 in the free-memory ioctl; no queue unmap, nothing sent
>>        to the GPU during the reset (Christian)
>>      - Drop the interrupt discard from v4
>>
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 1 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>>   3 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index b3ebbee76088..0953d823c345 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1305,6 +1305,9 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>>   		goto err_unlock;
>>   	}
>>   
>> +	/* Queues a reset could not stop may still access the buffer */
>> +	kfd_process_wait_gpu_reset_complete(p);
>> +
>>   	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->adev,
>>   				(struct kgd_mem *)mem, pdd->drm_priv, &size);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 7a365fca68e4..25f57dd59bfd 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1126,6 +1126,7 @@ void kfd_unref_process(struct kfd_process *p);
>>   int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
>>   int kfd_process_restore_queues(struct kfd_process *p);
>>   void kfd_suspend_all_processes(void);
>> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p);
>>   int kfd_resume_all_processes(void);
>>   
>>   struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index e742ef206abd..7750741444ba 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -1291,7 +1291,7 @@ static void kfd_process_remove_sysfs(struct kfd_process *p)
>>   /*
>>    * If any GPU is ongoing reset, wait for reset complete.
>>    */
>> -static void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
>> +void kfd_process_wait_gpu_reset_complete(struct kfd_process *p)
>>   {
>>   	int i;
>>   
>
