Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF933C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 14:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4167810F120;
	Tue, 16 Apr 2024 14:39:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/eTrtwQ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B232C10F120
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 14:39:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3rzDXRZVjy0XDFxuPAYF3Swh96h2a7x2jgEyVsva+hUYUw9/hIE1fqOV7EvbqPabov0bWpREiyuqewN3zaKXH4ilcAdtAzA51Xike6n2uyC/sxTaY0HVHplXQklMLwpKkWLK4unT0JNGeSYA41tSIVe8gZfg8dIB2VcGEdMIxsqtZQouYNFFrzrHTokRzfVEkw/ylMOUDja7fzDBgyaaxiX0KBg1AEJ0ZD+Rf+/qx9WC79tJj1bfV3MDecEfirOr2hT6Lku6Z3IfpsYnQMSBLsTtFl1144UCh/PVnv2kB9aLsYW5klGATt9OmUbpjbbOpgGoDmqWDoM3Xy/DenFTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jT3LIoWt70OAJbCLqrbkpPOqMAiwZG7qaUC3KEzObho=;
 b=lXI7sjvaOs91G5WE4qscx1gGZeE+BiILMW4G3PPbdMcF6R1j3oKSKs2kocJqf+hZXp4qLr//XZlUA7xS6DUUMl91pSUGpQTb0oaJ0EOKwQ1b7ccKNP0M9t01kYWOLIMToaYv2Za2M3zGk2kpWdjcTLh9eVL1gmk8LYjV8CnEjQe7OOKAKtBBEyxZNuh0KoGuD+EV+CRucDKIcQLfrsYEt/QICcxeYBM6QkMWtyyGbCpNBrE94sz30qZTqhLSGrcskZQGwdp9mC3Nel2LEnxCpSyVdnGgXw6JR36K/H1K+0LjYxxNsYhTSby8sbxhDXv5Bpk6cjKOWgChRQTLf0xFUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jT3LIoWt70OAJbCLqrbkpPOqMAiwZG7qaUC3KEzObho=;
 b=m/eTrtwQ3X3C124TIHWJ6W6mTKk3KR8HWrstctsl2JK05jolwXcvmMqZ032a4CQbFz22QWB7KYYY2QiQ1T++LaksqCJDq7a/CCdWiu4d2k2f8O9sew0dEawM1VB7uFzHG1wtOCuFsAlx4ZHAJpqfEPl1QBUkNMqBAG9+HgMBlD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ0PR12MB6808.namprd12.prod.outlook.com (2603:10b6:a03:47a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:39:12 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:39:11 +0000
Message-ID: <c4227d0e-aa7e-6a15-61cc-7a37eccedc47@amd.com>
Date: Tue, 16 Apr 2024 10:39:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] drm/amdgpu: Support contiguous VRAM allocation
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240412201301.14154-1-Philip.Yang@amd.com>
 <20240412201301.14154-2-Philip.Yang@amd.com>
 <05f277d3-f1b1-4a3e-b364-37f18cffcb2d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <05f277d3-f1b1-4a3e-b364-37f18cffcb2d@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ0PR12MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f66df7-c68a-4aaf-63e6-08dc5e22fb4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYCYWvco++vxVN9td+XQG6ax3sNuA/TXHqr8Zh1J72C1czZ7Y2ycQHzH3T9P6ElOcg+yJGVjg8cRlCc1WH0eP61gsZ5QaT5H1HaZRqAx+K11c+p/DwyD/nWuBhoWnbo1dndc5u+1m4G8lWMGZR8396ThGPTyauwTFreh8UXyRtBaiVoFvo2cTb58Dbmg5W4bbkWeN3dbPwQykuOYcZhwT6XS0GEGNWnE4lbRtWH14TrPh8+u1lSwLiYu/cjsTJ87/18UeqgVuzmqh2syrukMpd/6qeOoOHmPWAnKG2pj2d7CL2N2Rb1rJBh0A7AtUdvO3eE9Fu+uZmnZuk1zHbpKcKH8xDtNvF+TGogYsqqphhGivllpqN9z9BjZV44PTs+0ijGEwI1XEXB+xFweM7TY62JwmKWJJBBSzncgAPOXY8pHXXy7zUeHb1TqhdgGN0vhGjygS/dL2uabldnW7tpLb6Ft9muGaBygMxv7U7iBdfIk4U1SowCPeruvqj9TQNAUmB+3hADzfO7lbKivI8K4G/eXgf09NOwPnDd9v0IOUj3NcZfQIMKCHmM9Rwi1lqwTt25txrbdUWsAU1jE+NswUHgyvpU/JwXZwaahoTaegdY/r7yFP6SMruBdrusB6a7o/SAXHa5RT3Yp86ByCGS9dnxMYt9lu3YDyNDnsz5n9nQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG1XY1laZTRkQkdaOUdPcEcrRm9IL2dUUlpTUWtSdXBHdkcyYk9Gc25VWlZN?=
 =?utf-8?B?T1c2ZUNDQ2RWZjluYloxSFFCbWNjT1JKcXpKUUJWdXJ1U015Y0NpUG4vY2dk?=
 =?utf-8?B?RUZoSjNIRGkxcDVjQ25KMG4xbWNFK0xxNDZtb3FNbkpNMGRUYUR1ZlM2K2Fk?=
 =?utf-8?B?NHp5SjBvS3hmaHQvbThBcWFoTklCNHBPZGZ2TEZTNDJoS1k5Nk9GVWxmeGwy?=
 =?utf-8?B?Yml0STlqdGgyL3ZPemRjOVZMN1pKNGczd09GTzFldXp6d0plVlN5K1NteHZW?=
 =?utf-8?B?djEzcVRFM2NUVHJwRUMzcVh1STludEIrSHlWYTRxWFpWRHN3TUR5RWhjVzZt?=
 =?utf-8?B?VkJKT2Q2NEkwTjJFTVVGWk1TbFdrekMzSXg3UUtEQlBYSTNNWGdkUHBQdkVY?=
 =?utf-8?B?bUpPdmkrWTZGM1pCQUdZajRVZThxN1lVQVhoUWkrQ2REajVuTVdOcFNqaTMy?=
 =?utf-8?B?cUQ3UXZjNjI3TmNtcWZkZHMzUWJSV0NESlhDS0JZR1BYQTVoa2YyT2xpVmc5?=
 =?utf-8?B?U0htdmcyOEl3V2dZTjdYRVdVeXFTcnVWQWl6eEZFbGZmRkpMK2I4ZHdoNGt5?=
 =?utf-8?B?TGNFbFNmVW9NbUl0NmlEdW5XSVp2VDFqNG9zaVBvb3RWOThTR3NsSVgrdis1?=
 =?utf-8?B?aCsySzAwaDZ1anRmd3Z4aVdlTStNTEtIY1FSOWkxNFc0NDI3UURhdFVZSXdV?=
 =?utf-8?B?UXQxQk0rZWNRTGszWDZhWVRDR1BObTNPMFcycnBUd0d4TFlhSUFIbVhaZStl?=
 =?utf-8?B?Sm1ZYzFFRXdLRy9SKytVbXdjbzNPUkNWNU9kdGpwS283MW1zci85ZGY0bFNh?=
 =?utf-8?B?Z3Fjb1Nub0pzY2RDV1VPSTdaMUp1TjJ1S3pObE9QMVBMZ2NXc3lqNjhFV1E1?=
 =?utf-8?B?SjFsUzVCenNRRkEzSEUwSURNUm1XTnVaS3g3MW42QWxzMXp1SnBjTlFzbzZ2?=
 =?utf-8?B?eHRDN1lzMlY4anRUVWIvdzl1by9iQ0RHaFcvdk1uY1AyQUVOOEdiV2Z0Qlpr?=
 =?utf-8?B?L1dvYlM1MWpoRHU0NFRWcnBZc2RXaElnWVAySldLYVlCaFo4VmhnUTN0QnFp?=
 =?utf-8?B?K1l2VjJ2YUp2N2JxbFZ4ZFU5ZjFicXNxYkZmZUl6QnRsSkF2dzNLeGthQnVw?=
 =?utf-8?B?ZzJrbGpTTDB3UWVjdkIzdWpsNmFJaXRvWDNLWExRQ3ltZWVSWXIvNGN3UGxY?=
 =?utf-8?B?ZGl6c0lRZHgxZ1R1OW10UHpKcUhCWVNkb1dUTEZwZE1VSFFubWtWWkNXaVBn?=
 =?utf-8?B?Q0RIeU9HeE9kemhrWFYxV01peFRSSldUemI5RmhGTkF6Y3RGSUxHMWthSzNP?=
 =?utf-8?B?YSs0cDFvcmpZN1hVZnkrODh6RzJHQWxqbFN5K2xMc0F6d25xVFBvWnUzQSti?=
 =?utf-8?B?RS9IMFlJTzVjUVk3TXZtNHVCelpoT1hIWUFpOXgrc0dqQTF3RmZwMlRQRitL?=
 =?utf-8?B?WWZCS04xRkhLdGpTU3pLTktiRW03eGtRYjVQNDZ2WWhnVE9QTUNocFE1dUxr?=
 =?utf-8?B?Z0FJTmZ5ck80ZWcraW5ENmVIUGJCTk5NQWl4NlpMK005a29XREFGWGY1R1Q4?=
 =?utf-8?B?cm9YS2MwZThacjFuUkt4RENRcVgyU015RjhiRU9pQktxUis3RW8rWit3RVo0?=
 =?utf-8?B?UFZrZkVqcDNBcXB0VWtuS01HZy9IS2N5K0hURXRlSUs0dXNnR3hlc1VQb0ha?=
 =?utf-8?B?UURlemE3R0hFNkR6NUxRdmduaE5CSWR4dXFwZTdIbnRjMTMxN01tcjRqaHZQ?=
 =?utf-8?B?WXM0WUEzZkEyc1o5TXY1TlVlMi9iUDJONGV2bTdNcnJFRHVJSzZHUy8wTHdP?=
 =?utf-8?B?LzhXVko1WTdMeE9JY0JQVFUxT0xUcEZxZ0tNVXByS1hocVpFdVNhTUVSSlkv?=
 =?utf-8?B?SlN1S2tGNDZRYlVyMjA1TGlwQk0xUCtJVmlpcGJJb3FQcHFLbTRGYU1VZ1lo?=
 =?utf-8?B?RDNHakNSNFd4dHRsQWduS3VRQ2xDYlF3aUN5MUdWZkVOZ05CQ2xacFB6SkR5?=
 =?utf-8?B?SkhSeVNQN09KOUpXY3ZGYVk4MXQzcjJoMVRtNFo0a091aUtPT3JCbHh4R1dO?=
 =?utf-8?B?Q01YR1Vnb2E3WkpNYU1jZ0lZTW13U0kvZTk4a3Q3dmc2MWNSL0ZaeTFXZCsv?=
 =?utf-8?Q?nbA+2UboStqmtL2klWgSc7qcC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f66df7-c68a-4aaf-63e6-08dc5e22fb4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:39:11.9051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSXHP6/dqnreu4PrOWVmktDGqB5Qj5Lh0PNb1AUloWZe4fTFzQlMcN9aS4wAdFym
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6808
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-15 08:02, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:05f277d3-f1b1-4a3e-b364-37f18cffcb2d@amd.com">Am
      12.04.24 um 22:12 schrieb Philip Yang:
      <br>
      <blockquote type="cite">RDMA device with limited scatter-gather
        capability requires physical
        <br>
        address contiguous VRAM buffer for RDMA peer direct access.
        <br>
        <br>
        Add a new KFD alloc memory flag and store as new GEM bo alloc
        flag. When
        <br>
        pin this buffer object to export for RDMA peerdirect access, set
        <br>
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag, and then vram_mgr will
        set
        <br>
        TTM_PL_FLAG_CONTIFUOUS flag to ask VRAM buddy allocator to get
        <br>
        contiguous VRAM.
        <br>
        <br>
        Remove the 2GB max memory block size limit for contiguous
        allocation.
        <br>
      </blockquote>
      <br>
      I'm going to sync up with Arun on this once more, but I think we
      won't even need the new flag.
      <br>
      <br>
      We will just downgrade the existing flag to be a best effort
      allocation for contiguous buffers and only use the TTM flag
      internally to signal that we need to alter it while pinning.
      <br>
    </blockquote>
    <p>sure, I will rebase this patch series to &quot;[PATCH] drm/amdgpu:
      Modify the contiguous flags behaviour&quot;, this will remove the new
      flag.<br>
    </p>
    <p>Will send v2 patch series after Arun's v2 patch.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:05f277d3-f1b1-4a3e-b364-37f18cffcb2d@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 +++++++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c&nbsp;&nbsp;&nbsp;&nbsp; | 9 +++++++--
        <br>
        &nbsp; include/uapi/drm/amdgpu_drm.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 5 +++++
        <br>
        &nbsp; include/uapi/linux/kfd_ioctl.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 +
        <br>
        &nbsp; 4 files changed, 20 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        index 0ae9fd844623..3523b91f8add 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
        <br>
        @@ -1470,6 +1470,9 @@ static int
        amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(ret))
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (bo-&gt;flags &amp;
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Error in Pinning BO to domain: %d\n&quot;, domain);
        <br>
        @@ -1712,6 +1715,10 @@ int
        amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags =
        AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags |= (flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For contiguous VRAM allocation */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp;
        KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_flags |=
        AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xcp_id = fpriv-&gt;xcp_id == AMDGPU_XCP_NO_PARTITION ?
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 : fpriv-&gt;xcp_id;
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        index 8db880244324..1d6e45e238e1 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        @@ -516,8 +516,13 @@ static int amdgpu_vram_mgr_new(struct
        ttm_resource_manager *man,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(min_block_size &lt; mm-&gt;chunk_size);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit maximum size to 2GiB due to SG table
        limitations */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = min(remaining_size, 2ULL &lt;&lt; 30);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = remaining_size;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit maximum size to 2GiB due to SG table
        limitations
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for no contiguous allocation.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = min(remaining_size, 2ULL &lt;&lt; 30);
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((size &gt;= (u64)pages_per_block &lt;&lt;
        PAGE_SHIFT) &amp;&amp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(size &amp; (((u64)pages_per_block &lt;&lt;
        PAGE_SHIFT) - 1)))
        <br>
        diff --git a/include/uapi/drm/amdgpu_drm.h
        b/include/uapi/drm/amdgpu_drm.h
        <br>
        index ad21c613fec8..13645abb8e46 100644
        <br>
        --- a/include/uapi/drm/amdgpu_drm.h
        <br>
        +++ b/include/uapi/drm/amdgpu_drm.h
        <br>
        @@ -171,6 +171,11 @@ extern &quot;C&quot; {
        <br>
        &nbsp;&nbsp; * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
        <br>
        &nbsp;&nbsp; */
        <br>
        &nbsp; #define AMDGPU_GEM_CREATE_EXT_COHERENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 15)
        <br>
        +/* Flag that allocating the BO with best effort for contiguous
        VRAM.
        <br>
        + * If no contiguous VRAM, fallback to scattered allocation.
        <br>
        + * Pin the BO for peerdirect RDMA trigger VRAM defragmentation.
        <br>
        + */
        <br>
        +#define AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS_BEST_EFFORT&nbsp;&nbsp;&nbsp; (1
        &lt;&lt; 16)
        <br>
        &nbsp; &nbsp; struct drm_amdgpu_gem_create_in&nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** the requested memory size */
        <br>
        diff --git a/include/uapi/linux/kfd_ioctl.h
        b/include/uapi/linux/kfd_ioctl.h
        <br>
        index 2040a470ddb4..c1394c162d4e 100644
        <br>
        --- a/include/uapi/linux/kfd_ioctl.h
        <br>
        +++ b/include/uapi/linux/kfd_ioctl.h
        <br>
        @@ -407,6 +407,7 @@ struct kfd_ioctl_acquire_vm_args {
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 26)
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED&nbsp;&nbsp;&nbsp; (1 &lt;&lt; 25)
        <br>
        &nbsp; #define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT&nbsp;&nbsp;&nbsp; (1 &lt;&lt;
        24)
        <br>
        +#define KFD_IOC_ALLOC_MEM_FLAGS_CONTIGUOUS_BEST_EFFORT&nbsp;&nbsp;&nbsp; (1
        &lt;&lt; 23)
        <br>
        &nbsp; &nbsp; /* Allocate memory for later SVM (shared virtual memory)
        mapping.
        <br>
        &nbsp;&nbsp; *
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
