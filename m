Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804CCC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 14:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB06F9AF73;
	Wed, 13 Jul 2022 14:16:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0379E9AF72
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPAUiUnBwrCZees3ILdnqZwfHRdR9iaUVxDnOvpXwRQzwpvRJqEppt2B+rk0Z5/gUuGrU3iUbyyFNGYyM8ojr6wwySGrngOJMeeX2L6Y4Ja3/xEkfiosYsh5O4ij2IHQSxzUL80I7RNegSO2CUW9KO4glNFq0m6en0zfWkgimPE+yRQ02D6FBYPQMgPW8jCUdhIxzKTBYX2LSyY6WK6MUw1g2Ahp4CNu5at0YwNU7WHKYGy+s4rc6r9mIcoRwytmMiUUkbR6piG+OBBURbNgSsdcBEBS1UAPncVyd+aYHlu9MLNt4Wl9Q9DbPqaokdkgYXpH7QA8Ri9ikEd6b1ZSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUoKdU7PNfijg401uQ7CQpTNXPilOZP/fDa9AaHk+1A=;
 b=oRNS1ZYSy0bGFI459hyfZ8OTAaf4iJrTtKojWUqfRztIOPF/THf65lwPt+N58QKBR0fwgC16Z6vFqVz7UhyAnVu8wXxn8cGrLx1nNGMfir1hGakfeXFITkHfq43Rb6N0XPWTamRd3hR6MMm8darzCbLwvfB5rTLZKNy6H8lJDhAbfC3oeMSIZZNXA8TiPEkFJu5WLp2ve4u7fj2mvb8r4fsATpUHTLYUpI0KABy+qpfJ4re3Ey9NL2cXPqzEv4xA9nV3OePboNHfc11NKq6I+8xlgYYMPPKBbUUJFD5Zxj+RsB/0RL+9OI4dV+LpiPoG2GQGU1KhoCAf8RwYhztypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUoKdU7PNfijg401uQ7CQpTNXPilOZP/fDa9AaHk+1A=;
 b=FSTk7TZMTWcmxqGl5VJ9GMxqWLkxC32F7TOy4r7rmu1TrBLHav7RJqxVBJMrM64iy/6CXqMwfEMLKBojFTiPQj1Ct40qrdJrlwSrgMCgVQb8MCE2YWoTyRBZv/EmTsNAPXgv0pSfU7MFZSmx+AumWzA5ZgDHRhfnbRv8G8g6Yp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB3101.namprd12.prod.outlook.com (2603:10b6:208:c4::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 14:16:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b096:31c:bfb7:fa0a%3]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 14:16:51 +0000
Message-ID: <d329ff9e-b5ea-1d35-a600-1322a9136cfb@amd.com>
Date: Wed, 13 Jul 2022 10:16:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Remove Align VRAM allocations to 1MB on APU
 ASIC
Content-Language: en-US
To: shikai guo <shikai.guo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220713091426.938701-1-shikai.guo@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220713091426.938701-1-shikai.guo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a67e8e74-3a9d-4a27-ca88-08da64da545f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QQIdfHEWkUCdaEh/9ORTHgZyi+tHobrwLRKwG5m7XMgwmkTFtnsODQM9uVcq++UKq/Cv8pGBb0tGiGUT9R1C1nRUZROpTWJOysz+e+BJuxrFlPoj655n7fss3tPJFDQLRRgsWhmd8NPoPdQTJS71ZBn95FtVA4PXlo8XnFF0L38lo1kKLJI7Vg8S/h5S+Nhqah/U7c8mmywxSM0rj33UjxjBCzXE2G1Qe4T/1zYuPeN5UXEJ4IFXZO5PgPEhOKfXHT03kN8QAJ9/oROpVcqc3KC8b4gsTiv3cS9MNsWteDzdWzptMCA5ySZuu7+Z74TgfrnEvipzcay10KcKAM/JJLmFMXMJgnZhSvXY4cq0ita4NDN7uKPVcQvljDPU/nA6hdkW+b3vjp3dGibopQbAYMj+XZFFxbXteKSrdmOqKpIjOYM86rMb0r/eLxQ99Egwtsfza3BTGehRifJ1aTLesFJez3r72aXmDo1CY42lC2w98drDdDCykRb7Q6nmnUKB7pDL3pQ/tuf2x/uwkEHXO3jeOkrd7IMsncGd2DD9x/ILxR8CWR1qIK5rgANW+Uk0YiWphgjlGbSl1e43rZ3k3VdA456vGTYtKnD2bz04ChFhSSsHPoYNJsWfjsfi01JG3vweZB5nxzSzhMHkBN2LFEauxxbqk6nT4f8CTUzNn4iYoSFStjDJu9guVH5ocn/Z1zjv/XvJ9Pd3959EK5cpXJ6GlUSQ9o47IRIhM7NVkhXBU/Qg9iv9lInye7vQWeofpkHXBdQMMKjDQD7FxHM58S7fKnbPsL7s+nIRVTMaJqIEamYcLfQJwhELoQWzf4w1hpF8n3FWMf71RvI7QATpKWM52iP9wvnwF4TftO95vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(36756003)(5660300002)(2906002)(8936002)(66476007)(44832011)(6486002)(31686004)(316002)(8676002)(86362001)(66556008)(66946007)(4326008)(2616005)(6512007)(41300700001)(186003)(26005)(6506007)(6666004)(38100700002)(83380400001)(31696002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am0xQUhvQjUxaGZNRzdPZmtPK0dqa0txR1RtQkpIZExpVHBxeXc4b3o2bHVD?=
 =?utf-8?B?WGxqN2VjdzBFZy8vQXB1RUpBQk9HRzVPVFUzbFF2b29keWo1ZXNGbWZORzBY?=
 =?utf-8?B?ZU1MaWdBclVXNng2K25qNk84UUY4RFVPY0IrVU1Rb3h3Vk8wQTA2K1lackJ6?=
 =?utf-8?B?c215MTZIZUtObkxWbXVxQlR1eFNLYmMxc0VodVlpV2RBajh6aVd4bktKejlM?=
 =?utf-8?B?UFI1eDRtdk1UZHVNa0FJcmdaTFI3dkZMNlNCMW4rSmFsTllmcks1cWpFTmhU?=
 =?utf-8?B?M3ZHcmw0ZitlVlFraGpUcnFsWWt3NXAvVkVuVEtJR1JlcTFFSllSV0NTZWlJ?=
 =?utf-8?B?QTRhME9YVGIreE5DdmRlN2dVWE12WVVjRmlPOUFQL0JUVWltUWpMd0dLSy9z?=
 =?utf-8?B?Zlg3cFY1MDVnTTdZdjAwbndUZWpOOWJDTTd1MGVUR0ZSNlpLNVVXam9UMkR1?=
 =?utf-8?B?NytoY2pnNmU4cWROMDltdlllazdrWHFiSHFDVjhwbWd0dEQ1YnJ3c1ZUMCtr?=
 =?utf-8?B?Z0VFc3pvMVNlK3VpZ1dLckQrSWtMaWd2TUlFekx1V0dxWDQzbnBtd0gzakVa?=
 =?utf-8?B?dHl6YXkvdzBQZ2dDWXRRTVhiMldWcHZsZFltbEJnNEUyZUNRZzJOZTdaWlFm?=
 =?utf-8?B?QVhUOVIyZWd1aFk5ZFcrR3UwaWU1SzBNYk0yVUU4Rm1lNVhwWWg3Q09JbTZa?=
 =?utf-8?B?RERBdHBpTkE3WmZSTXRGQmRTWEhXdWxLTzNIUzB3V2NEWER1c01KRktWekFy?=
 =?utf-8?B?VE01NWRRRnJTSDlzTTRudmpqcXdxVDlvdU5OUUxUT1RHbSt5TlU1Zm9zbUw5?=
 =?utf-8?B?ZGhUekxlbkZxUHVnb2M1MGdKM3pmbEdhdkQ3MHRsK2lWUWNhTitRSTVQcGF1?=
 =?utf-8?B?ZnYxbWJIb2Q5Tk52TTNBOC9YRy9BTWwzUm1qV2ltRi9JRmZ5d3V3ZGZOOTR4?=
 =?utf-8?B?NGpRTmJhRE1FYlQ2UmtmR2ZnVTRsNEpibFNvbXJrK0lmWnNkck8rUlFmR3Rw?=
 =?utf-8?B?ZncvT08vbHA3YURBWWFmYUVhUEhJTmRjTnhtdUhsT2FVYmVmSmI1dGltYnVJ?=
 =?utf-8?B?MkNucE9LbzZlK3hlMFExbHI2YjduQUtxeVMzSVFUVUVBM0ZYek5nVjU2ZEZp?=
 =?utf-8?B?UW02NmNNSEp2UWlZVWdtNmNZL3BOcThFZlVOcGdrcmJxWi9QdmFMYUNvaVlK?=
 =?utf-8?B?WFJSd29kL2dtTFZYd2RRSHJvUkp3YTZWVHlKSUN2UDZ5eWdRTzV1Qlp5eTdi?=
 =?utf-8?B?eXpwTTdpbUJKNFErTVpManRVMlJZNWUwcW1DWFAxdUt3ZThURnh2bWo2T2pO?=
 =?utf-8?B?bmxTd21ZVGozVG41Q3ZWZzFMWHRxRE9SMENQRTZxaUJzeEVWVFU0R1dLaE9z?=
 =?utf-8?B?ZElPWWFlMWtvOWdCUlBrdFBCWHhyblZETnVXS0FMNElHUzV4R1lsa1k0dkxD?=
 =?utf-8?B?L0Q0YTNLMVE5V2R0NGVHSEFhdWQ0R2JuYTFJT0I1dTM5cUY1YVZkV0taVkpO?=
 =?utf-8?B?Qk9EWGxGMzF6NWpzWDlqVlBpaXV0VVE5SEtLQmUwbk5KajU4N09mOTl5MDkw?=
 =?utf-8?B?Y09IYXNUUXI0VFJxdHo5eFE5dzY1cm1ZT2FEVm1tRXZNV21rVGNTd3hxSFFL?=
 =?utf-8?B?NmtkalNtS2xoUDEvcW9GbzV0NFBGc0pSL1pMUkJqS1VlS05ybE9Xa2V4UWhK?=
 =?utf-8?B?QnJOYmNDbks3NnpnYlJDb000VzNsRFVnd1pMcExhcDZCekdUQ3JWL0JCemIy?=
 =?utf-8?B?WStjWXd3K1F3OTIrOUJUNlplQzJSM3NudjhLdmI5WEFldmVvNko3YzB5cTFh?=
 =?utf-8?B?bUJSUmk3K21YKzc3bHB4Nzh5ZEMwalJHSEVGb2Y4a1JrWmF3UlpSRU9MZUFp?=
 =?utf-8?B?cy9Sa2FLSUtTcDhTaDRab3g2cmNSRmNRWUwrd0ZQNDA1NEw3NHY3OFNFWkZl?=
 =?utf-8?B?YWRuZGU3TDhvdzB3b3E2VnlKTGNzM3FNbFBXS1VNeGE4anFLTUZZTTk4QTJx?=
 =?utf-8?B?WVo0QkxBaTZReUtlbWw3UHhTU241cVQ3QnFCdkk2Rm1wbFZtcmU3bVVLZWxU?=
 =?utf-8?B?NENoVll0K20raytZSDlqVzR2ZEJobktVcHlhazBseXhhS0dvRk9UT0ZYNEJl?=
 =?utf-8?Q?hiyXrIWXEVFkQm0nqLzLRVN2X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67e8e74-3a9d-4a27-ca88-08da64da545f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 14:16:50.9120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHrU7+R2+HwAYn9Up0w9VjGQ1A56nXTrij3gsKqdBxMN23OX38rTtKn7+4BtpwY7k1/6ISYtK+OXr3Z6urlHrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3101
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
Cc: daniel.phillips@amd.com, ruili.ji@amd.com, aaron.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-07-13 um 05:14 schrieb shikai guo:
> From: Shikai Guo <Shikai.Guo@amd.com>
>
> While executing KFDMemoryTest.MMBench, test case will allocate 4KB size memory 1000 times.
> Every time, user space will get 2M memory.APU VRAM is 512M, there is not enough memory to be allocated.
> So the 2M aligned feature is not suitable for APU.
NAK. We can try to make the estimate of available VRAM more accurate. 
But in the end, this comes down to limitations of the VRAM manager and 
how it handles memory fragmentation.

A large discrepancy between total VRAM and available VRAM can have a few 
reasons:

  * Big system memory means we need to reserve more space for page tables
  * Many small allocations causing lots of fragmentation. This may be
    the result of memory leaks in previous tests

This patch can "fix" a situation where a leak caused excessive 
fragmentation. But that just papers over the leak. And it will cause the 
opposite problem for the new AvailableMemory test that checks that we 
can really allocate as much memory as we promised.

Regards,
   Felix


>
> guoshikai@guoshikai-MayanKD-RMB:~/linth/libhsakmt/tests/kfdtest/build$ ./kfdtest --gtest_filter=KFDMemoryTest.MMBench
> [          ] Profile: Full Test
> [          ] HW capabilities: 0x9
> Note: Google Test filter = KFDMemoryTest.MMBench
> [==========] Running 1 test from 1 test case.
> [----------] Global test environment set-up.
> [----------] 1 test from KFDMemoryTest
> [ RUN      ] KFDMemoryTest.MMBench
> [          ] Found VRAM of 512MB.
> [          ] Available VRAM 328MB.
> [          ] Test (avg. ns)         alloc   mapOne  umapOne   mapAll  umapAll     free
> [          ] --------------------------------------------------------------------------
> [          ]   4K-SysMem-noSDMA     26561    10350     5212     3787     3981    12372
> [          ]  64K-SysMem-noSDMA     42864     6648     3973     5223     3843    15100
> [          ]   2M-SysMem-noSDMA    312906    12614     4390     6254     4790    70260
> [          ]  32M-SysMem-noSDMA   4417812   130437    21625    97687    18500   929562
> [          ]   1G-SysMem-noSDMA 132161000  2738000   583000  2181000   499000 39091000
> [          ] --------------------------------------------------------------------------
> /home/guoshikai/linth/libhsakmt/tests/kfdtest/src/KFDMemoryTest.cpp:922: Failure
> Value of: (hsaKmtAllocMemory(allocNode, bufSize, memFlags, &bufs[i]))
>    Actual: 6
> Expected: HSAKMT_STATUS_SUCCESS
> Which is: 0
> [  FAILED  ] KFDMemoryTest.MMBench (749 ms)
>
> fix this issue by adding different treatments for apu and dgpu
>
> Signed-off-by: ruili ji <ruili.ji@amd.com>
> Signed-off-by: shikai guo <shikai.guo@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d1657de5f875..2ad2cd5e3e8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -115,7 +115,9 @@ void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
>    * compromise that should work in most cases without reserving too
>    * much memory for page tables unnecessarily (factor 16K, >> 14).
>    */
> -#define ESTIMATE_PT_SIZE(mem_size) max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
> +
> +#define ESTIMATE_PT_SIZE(adev, mem_size)   (adev->flags & AMD_IS_APU) ? \
> +                (mem_size >> 14) : max(((mem_size) >> 14), AMDGPU_VM_RESERVED_VRAM)
>   
>   static size_t amdgpu_amdkfd_acc_size(uint64_t size)
>   {
> @@ -142,7 +144,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		uint64_t size, u32 alloc_flag)
>   {
>   	uint64_t reserved_for_pt =
> -		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +		ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
>   	size_t acc_size, system_mem_needed, ttm_mem_needed, vram_needed;
>   	int ret = 0;
>   
> @@ -156,12 +158,15 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
>   		system_mem_needed = acc_size;
>   		ttm_mem_needed = acc_size;
>   
> +		if (adev->flags & AMD_IS_APU)
> +			vram_needed = size;
> +		else
>   		/*
>   		 * Conservatively round up the allocation requirement to 2 MB
>   		 * to avoid fragmentation caused by 4K allocations in the tail
>   		 * 2M BO chunk.
>   		 */
> -		vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +			vram_needed = ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		system_mem_needed = acc_size + size;
>   		ttm_mem_needed = acc_size;
> @@ -220,7 +225,10 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		kfd_mem_limit.system_mem_used -= acc_size;
>   		kfd_mem_limit.ttm_mem_used -= acc_size;
> -		adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
> +		if (adev->flags & AMD_IS_APU)
> +			adev->kfd.vram_used -= size;
> +		else
> +			adev->kfd.vram_used -= ALIGN(size, VRAM_ALLOCATION_ALIGN);
>   	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
>   		kfd_mem_limit.system_mem_used -= (acc_size + size);
>   		kfd_mem_limit.ttm_mem_used -= acc_size;
> @@ -1666,7 +1674,7 @@ int amdgpu_amdkfd_criu_resume(void *p)
>   size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
>   {
>   	uint64_t reserved_for_pt =
> -		ESTIMATE_PT_SIZE(amdgpu_amdkfd_total_mem_size);
> +		ESTIMATE_PT_SIZE(adev, amdgpu_amdkfd_total_mem_size);
>   	size_t available;
>   
>   	spin_lock(&kfd_mem_limit.mem_limit_lock);
