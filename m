Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C67C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:44:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EDD60FD7
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 17:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14EDD60FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3BE6E215;
	Tue, 17 Aug 2021 17:44:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA17E6E215
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 17:44:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdIr22Y+27u7K1ES9CXVm4AY4Bg3EPu1zjK1kT/hZrCxd3PHsr3sK2680ibCyLtSkELezadYoCWLSGjQ9lBGfujLEbXYX1ewIccZZ1QUXQ/d1UsKGCNjUakJROieZo4aP5h/DIJW5Z0cvZujAgu7hxdfSVV6n0kI+dM88f7LeRzrJkk8vR6/PlsbBresaAkTpwk6ck99O+gqH0vydUFTFCDJJxXsPeI/hLOM2GhJ7P/UUxshutICNNcFV/bfpkUzrH4QesAm9JNlxcrN2tN9Ek1HAfcix21znXfECdWFiQpE2EOpZOh/lh3xhiccGlzUbYf3bdMM5AjbjgeKn0In4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCtoucE7pxG3gSWI8/0KL71Y83UTGHZvAWs2W925AmY=;
 b=bCF4+mE7oo3OzHLp1iYAgnaYyRPYdCgcnfdsfR5OLWJKQCfNE82oMFk1LuJ62Hkm5soSOZ6Us1OO8uTBbKFgWM1sLp4C22xTlWXI0neumrEF3xCh1o/6O6Lcx6idc1uwvBq9f66+EPsuf4JTWh5VIdjvywFCdbn9V7DZZCQ7STm7YVsVnoPm0Q89ZTRMf3pdGhWrRzDExpDC2k1MWje3kFsKgBo3qeGMVteSxpWQK+JWYbKr0mmZbN/+c1l7kVHPOGDFsZVQ74BnaxzHn0zB/A/gcw1AI7WjzHcjy8DHxE5r1r6ud707o/AiITlR/LzmOMiJmOnXIV5gISUgSksnWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCtoucE7pxG3gSWI8/0KL71Y83UTGHZvAWs2W925AmY=;
 b=OqflqSjV+nGYOvBfnyPStlJwWi58yu3WIYOt0uMajGu2PxyiZPvdfBYky3ox34r90qoRb2Rugmd8YzuzuXBFsU5+2LaTKYUaNDO/BTRr8mr6zeEAXtmRNVu/xKSC7dukQHCxHG22Xq3mFeLBJZf3FexiHMa3lJnpqTsfmW6qjRg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 17:44:24 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 17:44:24 +0000
Subject: Re: [PATCH 2/2] drm/amdkfd: fix
 KFDSVMRangeTest.PartialUnmapSysMemTest fails
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210817091740.4031348-1-yifan1.zhang@amd.com>
 <20210817091740.4031348-2-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b936175b-1a6d-f1f0-9f94-a1a02d4832a3@amd.com>
Date: Tue, 17 Aug 2021 13:44:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210817091740.4031348-2-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::17) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0078.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Tue, 17 Aug 2021 17:44:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46853016-97b9-40b3-5d7f-08d961a6a6c4
X-MS-TrafficTypeDiagnostic: BN9PR12MB5178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5178BFCB13C0CF1C14DFF37992FE9@BN9PR12MB5178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y/IcxHah25TfNGYTqSOham885/5CQ+CYai7H7LWWOdfVpXFlNN9yeEnjq5qk8y5z9LuvFntrLyJDps272apRbk0Nau8WRLyCrT1M91TW6gQNLYJePJBJr6EcX0TIF2wFHkbSpIImCujIz6K6byMXrAEQXK+8QnZpqRMjlwggJscyr4rCeZxTQrM8PEb2iSa4tJgKZBA3AXVsXrLvPGRKrkB48sHfyFKKWRXSjaOJFhaKNbRdPiGy1fKbaCv74bLfMCOChAb/pMtxI4xD2nukDlkGJEgMb0AfDNx5NbGhBq8QdbMNExY+DLPlTyk8MLInsjEC7NaPDhPysF96+NS/YYd2GdDlqVU77JJBJ6gugsXvxYOpgR9IDUcSe/pAujTAlNbq6J068WvvBfz30/iCJSp7fGptfMDQfmekC5Cz5LnCeGopzgTBghufGvdi/3jCd7JeuY77aZE8VSqOCsglZU7dWonzj/2LqUkE35W6/wwaiDgcMTvURzC0aOSa3ekMwuOLJg0WwSvQTk4SEFF2h7YXduUFaadYsW1WqYivD8Om2Vr09f6Mmdj5Bq66u0HamDnS3S5pm9Dr8VsmOhy17gH0230A+ReZEf40eoQyPqwLeSPg4e+O0JetZ/zWQIvbpL5XSm5w9gp8aaHP3PBQ1dG5uRE3ksfx9ZvPUmNM4MzKS+4iCPZ2l0L8TAVcSOkhS8jNyg8sCmbDYlpYGdezZIkFzyJdUDsVn3g5Wib1x5WxBi0JFWCQUZmF5y7JhMqB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(31686004)(6486002)(44832011)(83380400001)(38100700002)(2616005)(66556008)(66476007)(66946007)(186003)(26005)(31696002)(86362001)(36756003)(956004)(5660300002)(8936002)(2906002)(8676002)(316002)(16576012)(478600001)(213903007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWo3UnhycDFLcDRMVWpWaW9FSWZnQVhHSlJxTVFMVHNGU0V6cXdFOE1TZHlV?=
 =?utf-8?B?Z2ZMTUc4M3IybzlBSE96dWplK2dlRm0yMWgzcmhKWUxvdzdKSCtHZGozQUs5?=
 =?utf-8?B?enNOVjdZTStLS1N4YTJraEovVlBxWHVDem1qQVRQK2Yza3BSSHA0NllrMFo4?=
 =?utf-8?B?SHl1aFFZWmRWMFpFM1RGTkZ0cm5hamQ3aVFDdVNKR0d2TDU4Nmt4aXgrU1JQ?=
 =?utf-8?B?WWsvU0JsRXpvVVFrRXRFL0NEVWRzL1NpY1FqVDJSa0xiWm1kc3pqdnd6WjVJ?=
 =?utf-8?B?c1d2QkhHMkNteTRvTHVmRmJYY2xPV3VSUUtCV1dabFJEUjBpR1BRQk4yNERX?=
 =?utf-8?B?MkFsZlBZem9pY1M4eGpRcW9KOFhQb1dRWlNtY2RyTEZKRkt3dVJMN1ZWVkVu?=
 =?utf-8?B?LzJDM0hYMDA5QkN3RVhXcXZReW9KemRJcmcyMVhLNU54L3dtSURsckZXbkZy?=
 =?utf-8?B?d1VDUFZrU1pEVzBEa2dKdThnVjFDaE9lREJYVVFpWUo2QlZteEpqZSsvTnJY?=
 =?utf-8?B?aEQ1M3VPaHk2T292blVTUjB3U2FCOWJBeG9jbWd6a3kzM20xZjljM0QwOEpY?=
 =?utf-8?B?a050TGVJWWFOdTUzNjZXWnJFNGtnVlBHUnZacldkTmRvT2tFM1AxdUFocFA4?=
 =?utf-8?B?S1NlMVpIN0cvbk9RditRZUNsYjliL05TemJZbElabGxaRCtOQU55QlpEM2pV?=
 =?utf-8?B?bjlKakJIMkt2K1lFeGovMEU2TTJxUnBtUk5PNkYwb25zZEZucjRPSGIyUEJ0?=
 =?utf-8?B?TTJZbytzUnluWXJHbmVxbDU4YUd4bjVVYUxhUGZnWUdra3FpUDk1TVJ0TDdn?=
 =?utf-8?B?RndIa3hZQmNVOW5rd01USStoNTErb2FsSE9JU09aMUt3MW5Qc2hFMEh1Qjh4?=
 =?utf-8?B?QkZwSUtUQ2pOcnNKdi80Sm90cHFuNWY3QVd2MVpxTFE3cXY2WmUrTmhDd0lK?=
 =?utf-8?B?Yi96a3hyM2NseG5TTGJTN1prOWsrdzRwbjJHRitKbFAxUHVhZmQrdDlDdXFl?=
 =?utf-8?B?a1RIdmZtdE93cnZRZXZiNDNEQ1hxUC9GbEo4VVpIMGNaWjNOaW42bGZrMWJU?=
 =?utf-8?B?K0xQU3BrV2FOOGY0dEo1OTEwMFkrQml6UXhuZCtZQm9WalVoOU9JVHR0OGxh?=
 =?utf-8?B?MGJIRFJnSHJuSWFlVC9CWnNYMmp0MXBiWHB1TVdhWnlpK2J4bm9uRHRWMDZn?=
 =?utf-8?B?UjFJSVB5UVkzV1I3Tzh2T2VEQkpaZlU4aWRkU1lOQXM3Uk5yN01KdnNpbkNz?=
 =?utf-8?B?WXBRbndUU2VTNmhaMUR2K2I3dTdscXBSdFVRLzFoMWpjaXhjeVc1UnZXV1Rm?=
 =?utf-8?B?clBZMjZNcG9sNmtIa2g3MkVobDEveFJnR3RqOVgzZUx6TGY5OTRnaC9hUHBC?=
 =?utf-8?B?Y3dSeUdqRE56c2NYbWdLUUh0RWpLQ21NU1d2SVZ6TW40bHgrTGVEK0svRVZH?=
 =?utf-8?B?aEVFM3kyU21obUNyd21YQ05qMnhmOEZZYXl4RVFGZEZtSmM1NFNxOWsycjJw?=
 =?utf-8?B?QUpKWXR5NlJaVXREelNOYkdkUkl1QSs0d3hnRU8wSUVrM1F5Vm5lOEhSR3ZR?=
 =?utf-8?B?T3lDK0g0bEg0VW4wdUlpb1JqeVIzYVlBNUxkZkUxMktkOHYyQjRlRDhVbExQ?=
 =?utf-8?B?ajJpUHdFY1R2VlhIUXJhZm9EYXMrK3hGL0VRUU1qVzlTNXBvNTE5VGhCc1BI?=
 =?utf-8?B?RXFJV0l5QS9ER3p4QXB4dWprOVAzMUxFOHNwc3d4VmpXNjVzU1dIcWRKa2xj?=
 =?utf-8?Q?HsxerR6MLRjsM6EvO27GzUbmAuLGYguEbpj4sfh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46853016-97b9-40b3-5d7f-08d961a6a6c4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 17:44:24.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AC6jyJoUxFrnPdN082OOyqgqcZpManKOSlL7u9LQRMupJZzCY52hg/+wZDX9YWYJCYiQ5Yjpkhs2dcIkzGx50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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

Am 2021-08-17 um 5:17 a.m. schrieb Yifan Zhang:
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
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 3177c4a0e753..e1c4abb98b35 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1261,6 +1261,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  		return -EINVAL;
>  
>  #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +	/* Flush pending deferred work to avoid racing with deferred actions
> +	 * from previous memory map changes (e.g. munmap).
> +	 */
> +	svm_range_list_lock_and_flush_work(svms, current->mm);
>  	mutex_lock(&svms->lock);
>  	if (interval_tree_iter_first(&svms->objects,
>  				     args->va_addr >> PAGE_SHIFT,
> @@ -1271,6 +1275,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  		return -EADDRINUSE;
>  	}
>  	mutex_unlock(&svms->lock);
> +	mmap_write_unlock(current->mm);

I think you can probably drop the mmap_write_unlock just after the
mutex_lock above. There is no need to hold that lock any longer. And I
believe the locking doesn't need to be strictly nested either.

With that fixed, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>  #endif
>  	dev = kfd_device_by_id(args->gpu_id);
>  	if (!dev)
