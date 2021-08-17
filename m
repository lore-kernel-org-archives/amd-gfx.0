Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D8C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 01:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7302C60ED5
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 01:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7302C60ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0316E09C;
	Tue, 17 Aug 2021 01:15:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9CE6E09C
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 01:15:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiykw+7nC0HWcqw6sL5Ds9tlJYMbQFPoxF6gLetAibOmPYDIxGJzEKs/61ZJoQkIBxim3wzqWD5AtsH+3YH55m75Z0q3NufizTp5xtoHpP0lxtRsmy5gJL9bLiDW6P9cOHC7phoPVcRqxFVBvkjTzO1IK2SWJocPVy5b4x7GQpYBu8mRvaqhd9PbHLBEASDJAkKxJ5CcL8KQ/XS69KayYmqtTsGP4hSewMJxfkum8UdYcuaCZQPScYeZe2amW+nxfUAD2sY2JPZFSN4VcSDmWkqRHT0uPv21smy4nIfBqOnsVX8r+4M4AW7nlYoG1kZykFv03wg/87mcQAd7nay2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+jyCu189qsYRLrPYrlVGY/vazP43ZkvQfkywnL0I3Y=;
 b=gAwVuD52pETuOrswD0c5VL8HiuSwTNHq5zPSFIS+HXmnWyIyJeZIqC+xqlGnDkvd6uXMZLkjuKZfY37teqxqmc3CZxVzraW1x7dfCe7qI0ts7h7ObFbtJacOrMe6VoOf/he1HVJiBkCMBubuY8mbpv1GsYQIYU0V5mYkVnAQnnFAIgbM5i6kK2tpno6bnVuTOnBO/p2sITBVd5QzKYYKg0gQYwJ/JWJ/rhQgtCn6AU/kEbm20Ot9EH4JM/GU2u/1Q+aguYl2S1qE6woy4Nv8vB5MsATwpxwkIeGnStA/ZPyv3W7F/al6VGjCLlP73u7KFJmj/+2H/bJk36cIZNzsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+jyCu189qsYRLrPYrlVGY/vazP43ZkvQfkywnL0I3Y=;
 b=1j8/DloQbpwIys/bOWUL+j+IUhS5cELN0j8DZR7oADAHloumaJ/DW5WZ5vhoIZ3Lp/x+tcFAhJzELRRHkIJDZtgOqbLO3xFsDHEDaIZXeOU7by9VzwqWf6OnqpsSIzg7vV6LuQQqARwzXt1BHvHnoqCGz2ZhzMc+U2pgY3e0wMw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5258.namprd12.prod.outlook.com (2603:10b6:408:11f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Tue, 17 Aug
 2021 01:15:48 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 01:15:48 +0000
Subject: Re: [PATCH] drm/amdkfd: fix KFDSVMRangeTest.PartialUnmapSysMemTest
 fails
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210814101213.3936141-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <8595f09a-48b2-7f8c-037c-91c9d74cc271@amd.com>
Date: Mon, 16 Aug 2021 21:15:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210814101213.3936141-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::28) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT3PR01CA0063.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 01:15:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 660e09fa-dcab-4333-2164-08d9611c8bcc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5258C1116865D622FCC4B25492FE9@BN9PR12MB5258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LCLyO1vuo6UGG/BKlDPR4MmH1zNxhwpFu9ZQ2aOQMcr3Gxo1UGDPCa4cuLEtGdOb9vzp4gKh/cOeQSDy2jab7Kh8hdGJ5ehvBqHAl1rCALDETyd5g6+HA81CIlEQ6U/JEDkc+FXUKmNj/cAY/vUmjfwHhhG6r+mny8NyOrtzztGG1NpsVwezAA465QyoXWemjgT35ghNEijbrdJ87jYkNftqtktQcrmVZgEeP7qx2a/7S51Rhcs4TOVJmXplfVK3xjhx0YO2qkksk/2ucCrC78tReXNmz49x8+EImoqKnhU+xAJOobhxaRTCknUtVr3kpWGFBi3ue06bViUS3Cei80KqyyfcQeamV8xw3inS/5Z3yCptc2zbLY+RBW0Bz6pq8VAsdfPw/e+WrS+MWm0PlD8IdbTGYOm11jX4lLWtiQmoWRQ88O4sVfNmXzUuyZQ3CrQkVNkJo1ycrQat0euH5TQo4SXVN7lbIi9MfNVBS/B2FlsqDbf5M3v7ljjbeWhNkVmGhDt8zcfUCWP6cLoNZVn0GVzKETkXWTTRYcdDP4ue7zMpMGAxbDaJJGtlX1MQZxG8Omd0iPF9QonThIBIfLIBOg+Ouoyp360iwRGkkL6aOMUtBERyxmnfOxS1qJby+xeQiSr5IHYrDVvuvZCZkaT220XIFNX5S6dArhpZzwPEYuw1wg6567naWFojs9rSy0h8fdki+xsZt3dN4lKPCXE6EJWnzGttYU5m0YcIn5hJDFEX5/YF3j6ILI+gd0Xybh3F6Hiy7wj1vSfq+AvBhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(31686004)(956004)(2616005)(6486002)(38100700002)(44832011)(36756003)(66556008)(2906002)(86362001)(8936002)(26005)(16576012)(66946007)(5660300002)(508600001)(8676002)(186003)(31696002)(316002)(66476007)(213903007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SThJQ3RoZ04yK2pnZjZXaDlFdTFTRm1wMGU3dC9uYStac2lNYUpJSW44RGN5?=
 =?utf-8?B?U2d3UkdacFZXdGp4NER6T0MvTFcyUm1FajVyRkJDdEZ4WmN5R015anVua1Bu?=
 =?utf-8?B?M0pXcEFxaFBlS3pmKzZIbkoyb2U3KzF6RmlWS0o4dFc4Z20ydFZKV1pkL2xG?=
 =?utf-8?B?TFdVQ2JMNXc3azVLR21ESHFNUHlXbHlXdlF6SDM1QXBxeWNtaGNuMkxGMzB6?=
 =?utf-8?B?eDVOWHpTMjNvNW9wZ0c2RWpqTG1vQnNQdm9qUkQreUZTM2lEVlFoNldETmJP?=
 =?utf-8?B?VHE1UHRHRmRScG9nYmlGRklsVEdTcE9zTGJqMXpiRmlVeHAyZ2wzRnZTeGdS?=
 =?utf-8?B?ODF4eHVsR0J3K1VIMml2aHBJV01BV1o3bm53dHU4VlFFSDBpVlRNVURyWVpu?=
 =?utf-8?B?eDNZOHdtRS9pV0RGU1VySGtoM3VZQ3AzTGpkODNSek13NDM2VzNjR0JXSnd0?=
 =?utf-8?B?bVJOYnM0dlJMQUNnZGVlR1l4RHIxUmFSd29QSEl2eDU2SVhuMTdIc3JQV1BQ?=
 =?utf-8?B?SGM5TmFxQlRxZWFJM25ORFljYmZLY05XTWxOVlBoVTgzcEx4MmhiaWhENDcr?=
 =?utf-8?B?bHk4UnRZbnlQSGwxY21XVHBuM2UvVll1a0VLOG1nZTFHVFVYNGpFcUtjU09T?=
 =?utf-8?B?c283bWNoVkxnSmRYZWg2L0JDNlFpTEhPUG9JSXUrSHAwNkZGSDY4WGVQV3ZO?=
 =?utf-8?B?dHlyMXhCVUY2cTkrQWNDMGluTWdtNmJaOS9hVUtrQTN0dm93WEdZdDRtK1JM?=
 =?utf-8?B?M1VZVDUxZXptZEkxcG1KZzVmN2l2M1g5MVhGTzNSSk5PMi9VNTZ1aWVBb2h5?=
 =?utf-8?B?U29kcjVpOFl1ajl5TS9BYkI4MnZ2K0tJNDdvbnlqcWtrVVcrUFJ3SzBmcnZF?=
 =?utf-8?B?WVhJdStQZ1d2bVN1WW0yTGYzQ2NsYWNGUVAvbmkvbDZzSFM5Nk4zcW85czdB?=
 =?utf-8?B?N3QwcjVsWFVucTdtWUwwQUVaZ0Q3TFpadE0xRnBHNndpN3ROQ0VOQmhCSXpB?=
 =?utf-8?B?b3FSYW5MVktYZ3FpT0pMV2g2a3R2RU0raGYvQURVUE92ZlFXNldlaGpSVXJV?=
 =?utf-8?B?UzdBbEtVeWJLUjdsMlltQ0FTdUNlV21qdm9OY2RTTkV2dU9SZDZZdFNSUk9m?=
 =?utf-8?B?K3BDNVU3S0tyMVRBWFRRU3pETFBlQ3h6bURHOW1rYzlpZ1VDb2xnb01QQmYz?=
 =?utf-8?B?MU1FNWtyaVVld0NkNm1HaVpVeTREYWpWT1ZhMDdHUEtrZWl0dmEwZXk1R0pO?=
 =?utf-8?B?blRvb2pFRUp6OWVCekpTSnV1ZENJSUkrZmxNTi83TUJnMms3cVpZV2N3K0Qv?=
 =?utf-8?B?OWRCSjBMK1VCRnNzelp4ZzRzZGVtNUc4SGZ3MHdUYStmMkpqOVR5STB2YzV4?=
 =?utf-8?B?U0QrT1VDa3czTjQxa0V1N1I3SE13WmhUNEYrM3JCRFEvejFTMDRCWlF3VXVB?=
 =?utf-8?B?WmJ2YTlxangxT3BNNHljOEM5VzZXZlVZMi8rb0pSS1RSWnlEVytmZjhqSVlP?=
 =?utf-8?B?cDVvSEJNajd0YWtINDIvd3ZBZGljOStnV3VuOGQxU0FoakxGeDVsOTF4K2Jz?=
 =?utf-8?B?bEl3cHpFRTV3dFl3YTRlVUxyV1pqcEUwc3NMeHNJM053dFYwUWkySVRXOXJD?=
 =?utf-8?B?aFVHU0tHNG9renVGOCtBNnMxV2lYWDZkYlE5cXgrWUZ2TU53blJDU2xlR3Rs?=
 =?utf-8?B?bll0MEZzV0ZEL0lsMmZESU9FSE16c1NzSXdmekF4ZjlNZVhNZktnNEN2TmFK?=
 =?utf-8?Q?9TxkgxndH0775FkrhcB0q3i9sMhCBBGsBxqtS+9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660e09fa-dcab-4333-2164-08d9611c8bcc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 01:15:48.3130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1HntqBd5pqRnwieFtINEU2G657n1YBT4rnA6Oo4aDXJ+qg8hI6CPQ62dcVhf3/twPIxVipe26zlcMtEKZqGaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5258
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


Am 2021-08-14 um 6:12 a.m. schrieb Yifan Zhang:
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
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3177c4a0e753..982bf538dc3d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1261,6 +1261,13 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  		return -EINVAL;
>  
>  #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +	/* Flush pending deferred work to avoid racing with deferred actions from
> +	 * previous memory map changes (e.g. munmap). Concurrent memory map changes
> +	 * can still race with get_attr because we don't hold the mmap lock. But that

This comment would need to be updated. This is not get_attr. Whether or
not undefined behaviour is acceptable in this case is a different
question from get_attr. In the get_attr case, a race is caused by a
broken application and causes potentially incorrect results being
reported to user mode. Garbage-in ==> garbage-out. No problem.

In the case of this race here, the cause is still a broken application.
But this check is here to catch broken applications and prevent them
from mapping the same virtual address range with two different
allocators. So I'd argue that the race condition is not acceptable here
because it has consequences for VM mappings managed by the kernel mode
driver.


> +	 * would be a race condition in the application anyway, and undefined
> +	 * behaviour is acceptable in that case.
> +	 */
> +	flush_work(&svms->deferred_list_work);
>  	mutex_lock(&svms->lock);

This still leaves a brief race. There is an easy way to fix that: Use
svm_range_list_lock_and_flush_work like this:

	svm_range_list_lock_and_flush_work(svms, current->mm);
	mutex_lock(&svms->lock);
	mmap_write_unlock(current->mm);
	...

Regards,
  Felix


>  	if (interval_tree_iter_first(&svms->objects,
>  				     args->va_addr >> PAGE_SHIFT,
