Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3681DC432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 04:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD4961053
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 04:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EDD4961053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B383B6E3A0;
	Wed, 18 Aug 2021 04:35:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62A266E3AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 04:34:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWbrcFCFV0Kv8baE73IVo2ZaZJLBVVsqE7MxXVNSRH6biR4u/Yi/EMIwpL3nO9mbBo++pCV1svao8NJ/H2iFwljcbzaxl3zaMgNgJp6cuAs9Alb/abR4Hp4tt9p007uiviaBXCaJpebfIhFRO/mxGzhI2cHYYSGZ7v6AYztLJ4TTK7Eidx4ArrFdz9NLYZSI2zp4gD1pTeitodKZKSpDk/eWZTt3lny+9FeGeGbDQXrofrIcxZlDYPqWObQgbGVH9Es+2QUfO92P1hcbxxrzbPt4sYz4AlJ4+Z4yxhqjrYMk7U7lebXTo8jJlKTGk8hAkuhOHVQC1upi4ahNB9gYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD8d2CVtPqOYpnrdSHN/8FySJk/0mQTYQv6QBoFaspQ=;
 b=fLFbqbkhqAqCkDgLjkKgBhygWa9QL+Y6e7Yl6ktqydPS+9GaLKJ5lV/KeEHUKyhlOYvTOe/zgYNcexDFArNgvEF3xwCSTyMSnomLQI/3Gl63Ujdc/KCi4ru3nqjmbSGPVyZHA9KOIxrDvKgUWjO5bI2gOzUrd6+Fq1mWWF1r+iNAa7yIoXRu5udtQovBizNseqETUyEv4PnITNXvgrp3Cb306tj5zPrd3M4Cn3YlRPeYRK9hazMVh03FfFayQ70E9N91ME9efhzJuZywM3MmUZVxJLRXu0brYC9oDck/DBcSyFTDNW/Kz3mIuULlaPYd8XuyZ+yvFs3tX9ba6BvRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KD8d2CVtPqOYpnrdSHN/8FySJk/0mQTYQv6QBoFaspQ=;
 b=QP4YAYAW6w2MDkj/ww3sjX4ENzZ2ZxRyey6lMmhhGbYxKpYd5LDcYBYl44Pc1ITWuMD9jR6EVO38CtXmbi7blRCaQnnoeJlWLs/yAiPZPOW2tnSaXbc4oZZNrHWHw03ROs8F9PpkxACWqOFeUYYq5P0LwEqQuL0oNCt0HfCEjQ0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5241.namprd12.prod.outlook.com (2603:10b6:408:11e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 04:34:32 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.023; Wed, 18 Aug 2021
 04:34:32 +0000
Subject: Re: [PATCH v3 2/2] drm/amdkfd: fix
 KFDSVMRangeTest.PartialUnmapSysMemTest fails
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210818031202.7025-1-yifan1.zhang@amd.com>
 <20210818031202.7025-2-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c55b4c04-9ff2-9230-2e32-b875093b9dd9@amd.com>
Date: Wed, 18 Aug 2021 00:34:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210818031202.7025-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15)
 To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Wed, 18 Aug 2021 04:34:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73b6a68f-94b8-4b6d-3de4-08d962017986
X-MS-TrafficTypeDiagnostic: BN9PR12MB5241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5241A8B3C9F7B56E676DD59792FF9@BN9PR12MB5241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piKJF9P5xB039MD9+IgImOSzVfbA71P5YQBzVrRYylMuzKGoBzryl8TMNh8nFRaAUHNgRunxpAzPD42CRkI3AKsvDL6zpIjWjzr4fsK1HwNAFtVwth0gO4/tZuDVMyh1pp4za3HOl61qs3V9Ub1PHj4w4JOJU57oqLehnFLmQghgob6BVMwr2iDV3hqyi5JUx+KRGDne5k92zXhq7wu8xZZV95ccom8fmpe+RNfDegJTTrVN3SRj6tgVXlIGtje3Jp/ntPS2kfln+BlV2drDVRW9A/nNxo/W74iknsA8wyrM9GFJZeUubKFWwN3AkMiMF19oln9EcqhlfoHaVtkzB6hNAWFbzSlfXJPbrWlaFViIy6EtFfnTNVXqwYM9LkVPvlQE+i3BXHaAPN8X7C4Qer4bkE467huX3UPhkn55mt0ZDnQ6EvAOxx3s4/3Y+k7RA5uQV2NYJblYG9sdtmyN07YduygROXTayWBFfD38HWjVlRCdaVe0zdc27qiK8yxrmqyfnk/8cbytxg3EUxT+farKyGenivWF4nC5n6Bu65Jd02T1wZ+Du2j7cmByA6EdlCocL67NxWv2tA6HHU+sw0OWRYJw6eVsV3EtDLlcFp35UC+mVztg/YYwThnO7QQ/Qn2DBc0eJT0VsnwaQB8s5wEl7f/4/3ngsibw5ZIr++WK1+/zaly0uwmJXy/zJ0gle/3zvR07zfClQpPYU46kXWxsAKnkx0q1ur96gANwoCW3mBEYrVcBCnaU8EDqvqCq3dJD2GkG7mMtd3SoIfYD+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(508600001)(66476007)(26005)(66946007)(186003)(8676002)(2906002)(36756003)(16576012)(8936002)(316002)(6486002)(5660300002)(83380400001)(38100700002)(44832011)(31696002)(31686004)(2616005)(956004)(86362001)(213903007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkMzVjdGZzBWUUYya04rU1kvcDdPSXQ5eW56VWZEeGhkVllDSXUzYmF0b3or?=
 =?utf-8?B?TDVsZTd3eEFkZXJONTFva2ZFQlN6VGh3L2E4cGFwQm9oM3hIN1FkVWFPbFcx?=
 =?utf-8?B?N01hOEUzY3liaEZyV2RERmhIOWNoQWdtNFY1TlNiRFVvRVRkRkRtZDJaazM5?=
 =?utf-8?B?RzZkb214SEtHM1VNMTFaRitJcFJzZm1icEIvM3RnMlFjMSsxNCsrZlBLdHY2?=
 =?utf-8?B?Um9lMm9TVXIwb0FUMzd1a2ZIb21YemhuM2lsQlZUUG5nVjBVRHRLRWo0aFVy?=
 =?utf-8?B?cHRaQktwbUJyUlF3VmpjWHVDZnFPR2N2c2JmaGJwcksrWEdtNWVkeUlRTy9S?=
 =?utf-8?B?QUd4d3ozWFFZeHhKMW1aNUZQSHlYb1V1djJrKy9YU1c4OVhDTkJaK0RMYmpM?=
 =?utf-8?B?VUg5QXZ1bkFHWjBNQVdNOWpWUGs1dERQbkFMTGcvOWNOZXl1Qzg3OFcrMXJE?=
 =?utf-8?B?aWREVjlLNnZXTzNtWjVOWGZTMU9UeGRYdjhOV1NLd2Z5VVZTaTFUNHQ1a3Qz?=
 =?utf-8?B?ZVNJYkJnZjBnVUJURTRtcys4ZFVpMTdNTzh4d2lvbmszV254T2orN0tFUmhZ?=
 =?utf-8?B?U1l4WlRaRFd0enZBYkREM08yYW1KMUNkeGJiTXU0QlhpT1B3Y1luT1F2Z09S?=
 =?utf-8?B?TlRsK1R5bzVJZmlyeTkxYmVBYVBXM1UvRi9IQ3FMVEVjNGtUbldmNE5FK1RT?=
 =?utf-8?B?OFE3MXQxR1E1b1h2eEJxeWtuMzVnOXBZZ0JzTy9Da0t3OVE0TmJRNWl6b2Ja?=
 =?utf-8?B?enJ6ajV0azZoZ01wSVFkNXY0VkJqY3hRUXlsNEdQQitmSnFHeVFIbGlBZG9O?=
 =?utf-8?B?VjdrK2EvdlZJUlhWZnNnNStXU3pPc3Iwd0xVQzhvUzlkNHNOaHUyeUR2VWJp?=
 =?utf-8?B?VnNNcW9tNVhyNytBVkg0blFadFc1QjJoOFBkeWdtT2M5dnBtTE5ZS08ycXcv?=
 =?utf-8?B?Vks1NVNvUjEyenFZc3E5SkJqVGZ5SUU2akdvYkdLOHhUeVV2bkw3QTlXWHM1?=
 =?utf-8?B?WDlWdWs4S3hFT1ZZemg2Si9mcnd2NGI2Uk5CT1pQd3I5bWZ1TmN2YnArUjFR?=
 =?utf-8?B?aCtxUkZwMHZHM2d0eE9VemcrTXBlNWZZZXYwb0RZY1k3MGI5TTJrK0c4UFVD?=
 =?utf-8?B?Z3BzR0Z1c05WSWhTaFczaXFsdHpGcXV5c3F4TjBDY2tXY0lhOWZKZlRCQ1hL?=
 =?utf-8?B?MmRFRGtQVUlNYUQ5SiszNXhTNGhJdTZiR0tIN1gyaGJ4R09mKzR6TEVVbjJF?=
 =?utf-8?B?N3dOTUh0NTFVRGdoRUhrWE1pNjNiTE0vbStENFFlKzBGQzQ1TGtGRUJJRWJ1?=
 =?utf-8?B?R1A5MnRrQWEzbzdaaC85WmhsN1RoU3VYcWJJajlUcndmQlNwOU5QeEZsWUdZ?=
 =?utf-8?B?NFNTKzhsR0NVOWhEYWR3bFBFZHpLSUFjQzRTZXV5bWtMZzRRRW42OVNmelB5?=
 =?utf-8?B?eWZqKzhKeENVQ3NsTXFmak1yNWRqSlRKMG1CSGh5d3hNRFc3RGtKc2J3c2Ex?=
 =?utf-8?B?Ui9YT3hJdElYVXdjaU5kR2RyZytSbFkzR0p3a28wNGhZbVRvZFBaTGJsUWtN?=
 =?utf-8?B?TXVwRTBSemZVYmZTUHdYUmNVa0hJTG5UODg2Ym9Ibmpnd00ySGN2azh2dFZt?=
 =?utf-8?B?V0JSUnQ0RGZheldWYW41ZFdlVXlSbGNqS1I4YXZLMC9URDU2UFZqSlFOYnla?=
 =?utf-8?B?TTNvK3dwd3ZUTEVLYjFmZkUzVHQ4a0plYWR6TG1xQzZBcXdycGliVkgxUVdO?=
 =?utf-8?Q?j53GjgOxgiKw/6vgbyvbo0by1tAEZFEWCGFkXRh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b6a68f-94b8-4b6d-3de4-08d962017986
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 04:34:32.3692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCBHekEQPAZNj8DNnxtCe9GwUSJV1GhWWrv54a32Ye03FJpo3GwFKXy0YeFcdxosmSzvB87/9TlfvSrjdEw9Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5241
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

Am 2021-08-17 um 11:12 p.m. schrieb Yifan Zhang:
> [ RUN      ] KFDSVMRangeTest.PartialUnmapSysMemTest
> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:245: Failure
> Value of: (hsaKmtAllocMemory(m_Node, m_Size, m_Flags, &m_pBuf))
>   Actual: 1
> Expected: HSAKMT_STATUS_SUCCESS
> Which is: 0
> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:248: Failure
> Value of: (hsaKmtMapMemoryToGPUNodes(m_pBuf, m_Size, __null, mapFlags, 1, &m_Node))
>   Actual: 1
> Expected: HSAKMT_STATUS_SUCCESS
> Which is: 0
> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:306: Failure
> Expected: ((void *)__null) != (ptr), actual: NULL vs NULL
> Segmentation fault (core dumped)
> [          ] Profile: Full Test
> [          ] HW capabilities: 0x9
>
> kernel log:
>
> [  102.029150]  ret_from_fork+0x22/0x30
> [  102.029158] ---[ end trace 15c34e782714f9a3 ]---
> [ 3613.603598] amdgpu: Address: 0x7f7149ccc000 already allocated by SVM
> [ 3613.610620] show_signal_msg: 27 callbacks suppressed
>
> These is race with deferred actions from previous memory map
> changes (e.g. munmap).Flush pending deffered work to avoid such case.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3177c4a0e753..4de907f3e66a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1261,7 +1261,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  		return -EINVAL;
>  
>  #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +	/* Flush pending deferred work to avoid racing with deferred actions
> +	 * from previous memory map changes (e.g. munmap).
> +	 */
> +	svm_range_list_lock_and_flush_work(svms, current->mm);
>  	mutex_lock(&svms->lock);
> +	mmap_write_unlock(current->mm);
>  	if (interval_tree_iter_first(&svms->objects,
>  				     args->va_addr >> PAGE_SHIFT,
>  				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
