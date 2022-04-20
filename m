Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C304C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 21:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 039F510E535;
	Wed, 20 Apr 2022 21:06:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C950C10E535
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 21:06:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHcNBZTOdmFnhC+FRvX1PlvugytjWBx3v/VI9aCs7/FVEmNR6dS29wFtTjyFmqUQjERCRN/Y7XE2JSAEWhH0a2wIs1XL+imNStjgqVFTzUw3zKhU5grs/wPamC12Em5kC22cEqc1vuweLT5kMZsefv2/zCXwhsNk7ytyF5jShIC4spxEYZ83jZOY68Lsw9kfvuCwPGzg4Q0xDnpZob2i0W4GUfTsixto8zMmpuq6lJF16cGTSgHL+S6/6ZXqc2dPdDNVQLorZC8/r3z5HhbBkRkgHLKuYVT/LeaqfgJcaDODae1H3sObr7VV5v42PrrNddoEOJO0/omCWexpeFiWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FksSrN/5znbMVqMos0DL2eMq9CGTqfTRpudC4eLtnww=;
 b=oTpmLhdH0/lexQXBM65ni++OqRhhs+V4T9rvruxPlvoqShpLgX7FhzZfyqFrgGLuNZ7IP7+bWmw1Ws9yW1IWeJt//nvZd6MG6QvlqBytzrXDvtc5Xv0f7aWpfrKO9aJ4+JLAk9df8+3z7KerLESYPPK4RogCdwr/z0868QHz0pB6eZIpoRgGKeCp3Axz714gZn4HRrv9JlgnzobXNe6IBtMH+wubWLbsKxUyjTplAzN5+R5kQpURLnJ1eRPjDXQpGZwvpJmTx9TzxaP17nCzx9xbitZ97RwNWa1okn5fpByq0jydGXQDwDEXAus/FY5HV8UEhDdLTPQJrLCXYNtcjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FksSrN/5znbMVqMos0DL2eMq9CGTqfTRpudC4eLtnww=;
 b=u6vmH0wgyvea2h3jcdtxYbBMhNB2v1pbacOVDfLJTbBTWr3E9Np4NOjDp4wWXBMLs+pgH1vLn7nqzH24VYfKDBhzE7lFmZIGAVM7zhbONi0F+l+TnTYT8M6i6BHA0D4zrxEfvRleaVZRGkk6GvuNeJ072JTW05pM69OuFCpqTeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4376.namprd12.prod.outlook.com (2603:10b6:208:26c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 21:06:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 21:06:49 +0000
Message-ID: <36459762-ca2c-1fbf-35bc-54bc7cb71dda@amd.com>
Date: Wed, 20 Apr 2022 17:06:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Felix Kuehling <felix.kuehling@amd.com>
Subject: Circular lock dependency chain between pm.mutex and topology_lock
Organization: AMD Inc.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:610:b1::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0a0bfb5-840a-4cfc-a161-08da2311af76
X-MS-TrafficTypeDiagnostic: MN2PR12MB4376:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4376B20D38E2B33F015DB5C392F59@MN2PR12MB4376.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CV+yKyZa/1YlwMgccu5n7OdOUTxZKtP4jZVQpWovYPp9iWsUMyNxFPGvWrFMqXE6diAcit4yWNAPzR5FYKleG4ZeKsNgiqzoJsS5LHbqRGQt3HkCHXT0WBTrpZcFLAZ/8QY75ckB6+3zesYUN56z9PxF8QnUuKo8khbrHeawZPwBOywIky5bFjgudcfKdOAwY4KL+lmPGVXCvxKi810FWNSKgdpfCLbvCr9uRkFG/0074Mv0XgdQzEHmSb5CDGKQ+0UPy4hp3yYyzM8bBsKlYrNR/okGa3ZOK9V6asZU/88stjLO3ISnx3eLHgXvyq5m2uHIn+6Ddyc6TN9g1FqXpu13ZYtZkpH3+hNLDh69BWF4e3vl0rYrCUhOegQxhGKj8TWKSzg1c17h0WX3+UWea0P46U8up4zzrozYi3gO4i2peIq3AHlJuKxbm62Jj/3EFyLQsQPYnvn6kn5xyn3EllTL+ePZslVJbwUPGTIY2ic82+L7ZUqDR7QwnCKm3t6a0ycHNvmsYBUDlYDOOuY4KWTOP0aSTS8wWjYkTlzh8v2wXlP/kW+Zfn/Sy99PgXoH3Jb87v1D9sjjGbIb2zbvshW2tpXcKUXbXz1THaY61maxI2JKJLTrSCRP9TF1Ooa5ilUgSJd8Sh2wbeUQ7NVkxxgl5x8R1SGgMXFJqUByw5Tfu4KwZ4v93/15gHqVa1fXqyG9owgkwLvme5HE867R+8UkHQASScT/NjNqApNsHtb1TUeEFNl/DLG88j5IiJi2a8a5Nyg0eTO4GPLbAYZK2KaWUAEoO38YBRfL+biX4jGyUMpnGJVX7e4NnvY6Q/XS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36916002)(6512007)(26005)(6486002)(186003)(6506007)(31686004)(38100700002)(2616005)(83380400001)(110136005)(316002)(40140700001)(36756003)(508600001)(5660300002)(8936002)(86362001)(84970400001)(66946007)(66476007)(44832011)(31696002)(66556008)(2906002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2J5elo1SHV6QU9uN1hGZEZMYTh3YUt0dE1oU1c1SUZwM2FyVExWc3N5eDJE?=
 =?utf-8?B?bHBTVGIvQy83cVNwbmlXeDFFTnRJNHJmNmFhSC8va1pLMmhpNjRZdXcxa0xM?=
 =?utf-8?B?SisrUWxmZFJXdDZkYUJ5Z29EclM1YVJ6bnJKWUdjd010eTU5ZDdUN21ZYlV3?=
 =?utf-8?B?YzJDUi8yTlpQYmtRWm5CVG1NdjdPL2x2c1NUV1Q4SXNZa1duVnp3ZC9lN2pR?=
 =?utf-8?B?TExYVXdjbUlQUDdqWjRSYitxNWx2dzAzUGUyUHpmdjhjaVpNekVaelUrMzZ2?=
 =?utf-8?B?aXR5NTJSbzdBWnpXTFRmREtWZHRGb1JBdnFSMzZ1aEh6aHRscFpLZE1Jdllt?=
 =?utf-8?B?N2VldUtqZndaZ0hWQVJqOHRBUnZmd2Z3WUlHM2h1TGJMaVhTMVhrNG94bVgw?=
 =?utf-8?B?QkpPSjR3MldkQ1JYa0Q1TW5aSGFtbmU3b0NVU0QyYTVZTDhCY2p1aGwzbm95?=
 =?utf-8?B?Umtia3k4KytQeEVnMXdES0RXT2NBVlduN05pblVpdSt1WmhGUUdSY0RuekF3?=
 =?utf-8?B?ZThUWFNxQWJ5QUM3dnIvYnhaTWJlemFpMDVzM2JMalZYZ0s2ZGcyM29nU21C?=
 =?utf-8?B?eFh5emdISnBBQWpUODlla3VPUUdtWnYyZFBkYVdxTFZUVDJ4UGcva3drenZY?=
 =?utf-8?B?eXFVcWpCRGNyUGlQSUo3SHJoVkZYVzJSajQzV2FScTlWV2FRY29OclhkUnBW?=
 =?utf-8?B?ZFduUDE4VFpDWGEzWUpHbVhBMHIvb3FVbVo0cUl3dUtJcVdpcEJYbERoSUdX?=
 =?utf-8?B?czBxaWxqMHVXeHZ3Q1h3MXRWaElzL1ovSmVjRXNZMXFFNFhxelRGUzh1Tlly?=
 =?utf-8?B?OU1ETkMreGhsck14ZEFMMytvaEltaXhrWGlFclVvZU5QZEdQNjNBYjBJdnhX?=
 =?utf-8?B?MndjNEkza05qUFBGbkU0MHFYVUZ4MjNJY0pCTWhpcnYyTDRhaUx5MFhDaUx4?=
 =?utf-8?B?WTNqNitrS3pCVjR3dW5pcTZMUDJTMXoycHJMcjNJUG90cmg5Rys3ZTFFT3hE?=
 =?utf-8?B?bHdQZGxqWDI3VitnVzRtMnZudXd3SEIrc0R4Unkvb1ZTMGtDTEgzdWpaNmpI?=
 =?utf-8?B?eU5LcCtyR2E5TXZlenVNUzFqV3lsejYrem4wZDF1NUs5VGNWNzQ0UEg5cXZn?=
 =?utf-8?B?YmpONTBkc05lWFBmZkJJdHY0eW5MRmRlemV3b21VcXZObytnc3R5VzdMWStn?=
 =?utf-8?B?QTZzamtFRTNjYk1oN2x4U3RPR2FXVmN2cXRBRDZ5Vm5MMzVUQldGVTNhbGYv?=
 =?utf-8?B?N2Z0VlVMU0dodURBcnBIS2VGNmxTYzdSeHg4aXFMWEdwZU9sREp2U3J2cW5Q?=
 =?utf-8?B?dGNmNjFLZk1jZzExUmdUTnVDOE9mSzZibkk4VFhCUHFHQzNxRUQrQ2JMZVYr?=
 =?utf-8?B?Sys5YkpNTnlFRnlZYW8wU2FBelR1MVVSQ3VGM3JvVGF4dmhndWFZNnA5dERl?=
 =?utf-8?B?NEY4TjVOcWZnRDNoRlhOU3ptUENRN29OYzVxT1BHVHNxM3lUZitDUFhXS0JL?=
 =?utf-8?B?R1FPYm0rSy9aMWJIS3JHZ3lzME5pTmpvdVBReTBZdzRLZFoxeXpCS21qcFZR?=
 =?utf-8?B?d01tR3IwQkZOY2ZhWUZ0V3htbmpub2VKdTNlM3VlVVBtUUN5c29Odml2bEQ4?=
 =?utf-8?B?WXZoeGVQSkxYWjM3eW5FQk1KTmwzaUNSaElEZzBhN2MxNHBnVTNhVWJJdWxo?=
 =?utf-8?B?UmhOS0RhZEpmc3ZFek1qNDZkOUQyYVVPVlNwS2l2V1kwWkhOOVJ5MUVtQjhS?=
 =?utf-8?B?cVJPcFRVckR1M2pwbVl6emNmTEVmU1N3bWc2Rm5VbCtDYmkrQm9nZC85SytP?=
 =?utf-8?B?anBSMXhwUnEzdGc5cUw1WEU2MUZuZ0dJcGlhYlpiR0ZZT1VkbGZBelI2UVNw?=
 =?utf-8?B?TlZ1MHpNWEx2eWxHeGhHbHZ0a0x6aVRCdllCZStkK3NaaDlnRlFnbU5yQkU4?=
 =?utf-8?B?SlI0RGdLakw5ekVGQmFTUk5WK1Fwak9TQjkvMHo1cHlseURadnFnZFByRk94?=
 =?utf-8?B?UzJoN29VdnJQNm9RczM0ZXhiZXIwcmpuVjVNSE5kMjV3T2tWWWVtd0ZuV3Zw?=
 =?utf-8?B?UUJrT2hHQldhUjF1cVY2Z1UwTE1xS2hRMEFmb0VUY1A2cGc2blI3cDhETnhN?=
 =?utf-8?B?dWlyQWxQOUxUOXdhR29xM0psalhETER1ZEdKKzdlK05aZ3JGS2hqbE41b1Av?=
 =?utf-8?B?YnJWSWVjM0ZMbTZiT3lsR1ZqS1g3UDJIbFIxd0ptQVhwS3lCQ1lKcXVqTnFy?=
 =?utf-8?B?UXZoYS9NNldLNXdyL1lJeG5oU2JmTkgveE02Z3lha2hYOWJwY29RWmYzeSta?=
 =?utf-8?B?UW9wODB0V1lMcXQrREFzR01qZUZ5aVUyOVFqb0JObVpqQ1krb0Z2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a0bfb5-840a-4cfc-a161-08da2311af76
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 21:06:49.3581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBDzaTD7PTXWIB9Ms2zQ/xsdordjqJ0pr5TLvD53TBKtddjJ/1SfXRmKyPXshlbafFFkoi3gzjXvChpJc9EMOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4376
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

Hi Evan and Mukul,

You both made changes recently involving the pm.mutex and the 
topology_lock respectively. I'm now seeing a circular lock dependency 
between those locks (see below) that could potentially lead to a 
deadlock. This cycle also involves the mmap_lock and some file-system 
related code through the SMU firmware loading. A summary of the dump 
below is:

  * Thread A can take mmap_lock while holding i_mutex_dir_key
  * Thread B can take i_mutex_dir_key while holding the pm.mutex
  * Thread C can take pm.mutex while holding topology_lock
  * Thread D can take topology_lock while holding mmap_lock

The backtraces below illustrate each of these scenarios. If four such 
threads run concurrently and try to enter these critical sections around 
the same time, you may get a deadlock between them. I see two potential 
ways to break this cycle within our driver:

 1. Avoid holding the pm.mutex while loading SMU firmware
 2. Avoid holding the topology lock while getting mem-info in the KFD
    topology code

Can you determine, which one of those is the better/easier solution and 
implement a fix?

Thank you,
   Felix


[  168.544078] ======================================================
[  168.550309] WARNING: possible circular locking dependency detected
[  168.556523] 5.16.0-kfd-fkuehlin #148 Tainted: G            E
[  168.562558] ------------------------------------------------------
[  168.568764] kfdtest/3479 is trying to acquire lock:
[  168.573672] ffffffffc0927a70 (&topology_lock){++++}-{3:3}, at: kfd_topology_device_by_id+0x16/0x60 [amdgpu]
[  168.583663]
                but task is already holding lock:
[  168.589529] ffff97d303dee668 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0xa9/0x180
[  168.597755]
                which lock already depends on the new lock.

[  168.605970]
                the existing dependency chain (in reverse order) is:
[  168.613487]
                -> #3 (&mm->mmap_lock#2){++++}-{3:3}:
[  168.619700]        lock_acquire+0xca/0x2e0
[  168.623814]        down_read+0x3e/0x140
[  168.627676]        do_user_addr_fault+0x40d/0x690
[  168.632399]        exc_page_fault+0x6f/0x270
[  168.636692]        asm_exc_page_fault+0x1e/0x30
[  168.641249]        filldir64+0xc8/0x1e0
[  168.645115]        call_filldir+0x7c/0x110
[  168.649238]        ext4_readdir+0x58e/0x940
[  168.653442]        iterate_dir+0x16a/0x1b0
[  168.657558]        __x64_sys_getdents64+0x83/0x140
[  168.662375]        do_syscall_64+0x35/0x80
[  168.666492]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  168.672095]
                -> #2 (&type->i_mutex_dir_key#6){++++}-{3:3}:
[  168.679008]        lock_acquire+0xca/0x2e0
[  168.683122]        down_read+0x3e/0x140
[  168.686982]        path_openat+0x5b2/0xa50
[  168.691095]        do_file_open_root+0xfc/0x190
[  168.695652]        file_open_root+0xd8/0x1b0
[  168.702010]        kernel_read_file_from_path_initns+0xc4/0x140
[  168.709542]        _request_firmware+0x2e9/0x5e0
[  168.715741]        request_firmware+0x32/0x50
[  168.721667]        amdgpu_cgs_get_firmware_info+0x370/0xdd0 [amdgpu]
[  168.730060]        smu7_upload_smu_firmware_image+0x53/0x190 [amdgpu]
[  168.738414]        fiji_start_smu+0xcf/0x4e0 [amdgpu]
[  168.745539]        pp_dpm_load_fw+0x21/0x30 [amdgpu]
[  168.752503]        amdgpu_pm_load_smu_firmware+0x4b/0x80 [amdgpu]
[  168.760698]        amdgpu_device_fw_loading+0xb8/0x140 [amdgpu]
[  168.768412]        amdgpu_device_init.cold+0xdf6/0x1716 [amdgpu]
[  168.776285]        amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
[  168.784034]        amdgpu_pci_probe+0x19b/0x3a0 [amdgpu]
[  168.791161]        local_pci_probe+0x40/0x80
[  168.797027]        work_for_cpu_fn+0x10/0x20
[  168.802839]        process_one_work+0x273/0x5b0
[  168.808903]        worker_thread+0x20f/0x3d0
[  168.814700]        kthread+0x176/0x1a0
[  168.819968]        ret_from_fork+0x1f/0x30
[  168.825563]
                -> #1 (&adev->pm.mutex){+.+.}-{3:3}:
[  168.834721]        lock_acquire+0xca/0x2e0
[  168.840364]        __mutex_lock+0xa2/0x930
[  168.846020]        amdgpu_dpm_get_mclk+0x37/0x60 [amdgpu]
[  168.853257]        amdgpu_amdkfd_get_local_mem_info+0xba/0xe0 [amdgpu]
[  168.861547]        kfd_create_vcrat_image_gpu+0x1b1/0xbb0 [amdgpu]
[  168.869478]        kfd_create_crat_image_virtual+0x447/0x510 [amdgpu]
[  168.877884]        kfd_topology_add_device+0x5c8/0x6f0 [amdgpu]
[  168.885556]        kgd2kfd_device_init.cold+0x385/0x4c5 [amdgpu]
[  168.893347]        amdgpu_amdkfd_device_init+0x138/0x180 [amdgpu]
[  168.901177]        amdgpu_device_init.cold+0x141b/0x1716 [amdgpu]
[  168.909025]        amdgpu_driver_load_kms+0x15/0x120 [amdgpu]
[  168.916458]        amdgpu_pci_probe+0x19b/0x3a0 [amdgpu]
[  168.923442]        local_pci_probe+0x40/0x80
[  168.929249]        work_for_cpu_fn+0x10/0x20
[  168.935008]        process_one_work+0x273/0x5b0
[  168.940944]        worker_thread+0x20f/0x3d0
[  168.946623]        kthread+0x176/0x1a0
[  168.951765]        ret_from_fork+0x1f/0x30
[  168.957277]
                -> #0 (&topology_lock){++++}-{3:3}:
[  168.965993]        check_prev_add+0x8f/0xbf0
[  168.971613]        __lock_acquire+0x1299/0x1ca0
[  168.977485]        lock_acquire+0xca/0x2e0
[  168.982877]        down_read+0x3e/0x140
[  168.987975]        kfd_topology_device_by_id+0x16/0x60 [amdgpu]
[  168.995583]        kfd_device_by_id+0xa/0x20 [amdgpu]
[  169.002180]        kfd_mmap+0x95/0x200 [amdgpu]
[  169.008293]        mmap_region+0x337/0x5a0
[  169.013679]        do_mmap+0x3aa/0x540
[  169.018678]        vm_mmap_pgoff+0xdc/0x180
[  169.024095]        ksys_mmap_pgoff+0x186/0x1f0
[  169.029734]        do_syscall_64+0x35/0x80
[  169.035005]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[  169.041754]
                other info that might help us debug this:

[  169.053276] Chain exists of:
                  &topology_lock --> &type->i_mutex_dir_key#6 --> &mm->mmap_lock#2

[  169.068389]  Possible unsafe locking scenario:

[  169.076661]        CPU0                    CPU1
[  169.082383]        ----                    ----
[  169.088087]   lock(&mm->mmap_lock#2);
[  169.092922]                                lock(&type->i_mutex_dir_key#6);
[  169.100975]                                lock(&mm->mmap_lock#2);
[  169.108320]   lock(&topology_lock);
[  169.112957]
                 *** DEADLOCK ***

[  169.122265] 1 lock held by kfdtest/3479:
[  169.127286]  #0: ffff97d303dee668 (&mm->mmap_lock#2){++++}-{3:3}, at: vm_mmap_pgoff+0xa9/0x180
[  169.137033]
                stack backtrace:
[  169.143579] CPU: 18 PID: 3479 Comm: kfdtest Tainted: G            E     5.16.0-kfd-fkuehlin #148
[  169.153480] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./EPYCD8-2T, BIOS P2.60 04/10/2020
[  169.164175] Call Trace:
[  169.167761]  <TASK>
[  169.170988]  dump_stack_lvl+0x45/0x59
[  169.175795]  check_noncircular+0xfe/0x110
[  169.180947]  check_prev_add+0x8f/0xbf0
[  169.185828]  __lock_acquire+0x1299/0x1ca0
[  169.190966]  lock_acquire+0xca/0x2e0
[  169.195677]  ? kfd_topology_device_by_id+0x16/0x60 [amdgpu]
[  169.202808]  down_read+0x3e/0x140
[  169.207333]  ? kfd_topology_device_by_id+0x16/0x60 [amdgpu]
[  169.214332]  kfd_topology_device_by_id+0x16/0x60 [amdgpu]
[  169.221123]  kfd_device_by_id+0xa/0x20 [amdgpu]
[  169.227071]  kfd_mmap+0x95/0x200 [amdgpu]
[  169.232521]  mmap_region+0x337/0x5a0
[  169.237305]  do_mmap+0x3aa/0x540
[  169.241713]  vm_mmap_pgoff+0xdc/0x180
[  169.246529]  ksys_mmap_pgoff+0x186/0x1f0
[  169.251603]  do_syscall_64+0x35/0x80
[  169.256335]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  169.262536] RIP: 0033:0x7f828e0d1916
[  169.267261] Code: 00 00 00 00 f3 0f 1e fa 41 f7 c1 ff 0f 00 00 75 2b 55 48 89 fd 53 89 cb 48 85 ff 74 37 41 89 da 48 89 ef b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 62 5b 5d c3 0f 1f 80 00 00 00 00 48 8b 05 41
[  169.288448] RSP: 002b:00007ffe9bc5e7c8 EFLAGS: 00000206 ORIG_RAX: 0000000000000009
[  169.297252] RAX: ffffffffffffffda RBX: 0000000000000011 RCX: 00007f828e0d1916
[  169.305628] RDX: 0000000000000003 RSI: 0000000000001000 RDI: 0000000000201000
[  169.313993] RBP: 0000000000201000 R08: 0000000000000003 R09: 04b4000000000000
[  169.322358] R10: 0000000000000011 R11: 0000000000000206 R12: 000055571c9c5a40
[  169.330733] R13: 0000000000000000 R14: 0000000000000011 R15: 0000000000000000
[  169.339097]  </TASK>


-- 
F e l i x   K u e h l i n g
PMTS Software Development Engineer | Linux Compute Kernel
1 Commerce Valley Dr. East, Markham, ON L3T 7X6 Canada
(O) +1(289)695-1597
     _     _   _   _____   _____
    / \   | \ / | |  _  \  \ _  |
   / A \  | \M/ | | |D) )  /|_| |
  /_/ \_\ |_| |_| |_____/ |__/ \|   facebook.com/AMD | amd.com

