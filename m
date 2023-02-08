Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5A9C636D3
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Feb 2023 20:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4B310E877;
	Wed,  8 Feb 2023 20:55:12 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D468C10E877
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Feb 2023 20:55:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bctVLve4Mvv8lRZSZl8Fha9uG6HUMP83NGnGDwVRh6m3wkVyIdAgwc8GdtsHiPwsyfjmd5p1mPddBeLdZp4n8c0fGerp74ymcAROGtf2GN+naRWCP5av91VC7NBFM1/edwt7noT12MthZkiyZJIdAlLpTKpC3PAuUFbIeSuTLIdsJ/5vd2fJqEaA8CCEX8qgo0JtFoUs/p6Q15iBPOGw8DWkr7okkrHYdb9auv5f32RYnoGdVOGCo1CGa84wtjVFafLVs45Iu0YnTF7r75B6sj9Ez/tvE9Fmflxy90NLZoLp+M3l9bnuy+WDmEPTVU7I4RxRMWF6l6akO4C5CZQubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2D/Nd6jqhkz29FDLxRk65kSRAMbKY59HGkUGUt8o5Zs=;
 b=oAKxYE7LuMz/OHf5pkCLGujSJVBSzLGc31Db9QEqteOdAAPG33Y2QujHWM79DdJKMflCqGf/O1ltTdbVSSHTFSSFtBjsbyw+UjOpDNrvuybc3hg0IGcKeKeEtPXWBRWhqCV9cDyqvw6PsO1/RIs5kU5hqbp3HKyW2TBkKzJnoUar+6//YGa7eCLXpluh8U5+xw0Wv86BEHDBDsL9n1lDB5QuI7o2YmB21+wTEZJiqq+Z4NwQJlfhMTB5kGTZfd6HSdTzcMvR4P68cUjPVDqYguGXrIVXw/tZzukJgzJVFeED18g0w8ZdH/t9UPIendsUDF78cLRq0ppw46JnjxtY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D/Nd6jqhkz29FDLxRk65kSRAMbKY59HGkUGUt8o5Zs=;
 b=AhjTg2d0SdkBOKyBR6sZDQM7Kbrx3oWezzWP0Kqg3Kz9ZLqc7/fqkXmxroHYy9qPyeOHJF/fwQ/1eiRjfkuJwXTSDiKEb82nw8hTx8swGnxZHm1hthM/E1g7iJxHVFjr91w3OrjxoWBC8+Uu4NBMoUeBqgjDO0h2T1wYkFG7Vuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 20:55:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%5]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 20:55:07 +0000
Message-ID: <aba93171-1e17-537c-178b-ad1f512157d3@amd.com>
Date: Wed, 8 Feb 2023 15:55:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] drm/amdkfd: Prevent user space using both svm and kfd
 api to register same user buffer
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230208195747.1269250-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230208195747.1269250-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7fef27-435c-45ef-5e16-08db0a16c283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8Ci+xvwR44AOo7XwqvHZjylkaxHVizbYiifUQclfyVHGusV8tonwi8oSb7ZQW3V3xAUPjpTXAKcd88psmsiFOyIBmThR2ajYmaenAsryCKrt7hMlTiKyTrQ+vBOQATgxZxJvATfq6j7zpKjcNYyJetVOE75kdeF45oU4+EscA+RXSnVo3LPT7iJ+huCMufFQ+Me2ZrrK8zImyKkjjQ9oXYMvSxZNoeXqKryiUFomoFoC5c7/nGm1k0T4gRIfZazSJ16E97zhfqK1v2517pW/Sh48PCH2KbJmySKx9Btomn9Ug7xqfopEuPqtn4U/XjQ+Xfmd5nzyNLCzq+SZSEOZ7+1cBqUwbN7ChgwUpnOBPEfq41E3Oh6YXQqK8y2obdKh9cISq3tUfkfiYXLyaLupf8PhClKjYPvd2cAb9wGp7Vlllhs8UO7npI0ZYu1lNE/PahVwhO15vf1YClFEy+oHuoMpaKOzQEEayUNYtSulUJB6aopGfVQD+29stUdtBQ8+fgulPH+HzJOjV87h/XhZxm8SOovY1hLHRo5dY8eTaWDJtNELaxmfXZkv6oEXz30pSzSlZAPtGxrFmLvNMX19Y/rZ+Rt4fc2g+cLD6dwCxdmpnHNyRl7EmKXZrUyildS6N9OolB481a4X4TyUvrZq6m5P6aNwxa3sqmLuY8YbJ75s3GBR08xqYdCrps3q/RMxjdZ0EqLaRBwImCiwuFZAB5C6v8+EfKdMzxRLuENLC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(5660300002)(36756003)(2906002)(44832011)(83380400001)(2616005)(38100700002)(8676002)(66946007)(66476007)(8936002)(26005)(66556008)(41300700001)(186003)(6512007)(31696002)(6506007)(316002)(478600001)(86362001)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZQU0N1bjVyN2xlQlIyYmRaWldqVjBXVUJldXNYUWM5dUI4ZkgwVDQ1dGtw?=
 =?utf-8?B?N2xEN2k1SUV6L0Y1UGlkWmxhci9mUTlGQnZsek9RK3FoTU5TSjdPVXZtT0V4?=
 =?utf-8?B?dXU3dHM3bGtCVXI5Q05xV045Q0xCdm9uUmJ1eGhoKytxczlmRGFpVVNOOTBm?=
 =?utf-8?B?MzMwdlZpODFlZm5wU2t3dzRqcGxBY2U2YVZZeFRtam95eU1YTDdrcnp6cVl0?=
 =?utf-8?B?STcvMDZkNFdZMG5ZQlFENWF2UWlGRkhFTjdCVkgvTHRQMEJyYnN3dlYvdVNz?=
 =?utf-8?B?cG9nY3RWbHVPcGpEbkh4N1F2WDZzWUJ2NjI5dy92cnloWGtFcUhRcWpJVWR4?=
 =?utf-8?B?djJUOFlKVGpyakc1bE8yNHVYMFRLMEJNOGZ5Wm9kTG8zUnc0My9DaDJPNHhJ?=
 =?utf-8?B?VnUwUW9HOHAzWVdKTzhSa2VvcFhiWDVsVnk2SS9pQUk5dzZXZTZxZDh3ZGpT?=
 =?utf-8?B?YmFrcG8yczRaUTh5NXpkMXd1UkdmVEVKd3ZGc2JPQjArZVM0NHFqZnFwODQ1?=
 =?utf-8?B?TFpqM0RDNVJCb2VsdlVXSDhlVU9kRC8xZ2V5a1NsYkJYZmUvL2FYSWRVaGJM?=
 =?utf-8?B?NUNKeG1QT0VLdUlPQlc4VFpwUVBZakJ6NWR0NE1yazZCeDR0ak45ZCtJYmFk?=
 =?utf-8?B?WjFGSE9ybGRQMTlzalpoZWVoUVR1OHp3RjRLdUFoVzlnU24vNEJlenBKZVRQ?=
 =?utf-8?B?Z0NMRnhVdjY3Y3RFVldRT0lzZ2ltdXdET3Ava3VtWm1GMGxUeWF0M29KOVU0?=
 =?utf-8?B?dzk2bThWQk16T1VhVkhZd2lqWVIrT3ppVi9ZSUZMRkpHNFNkOEVocWptQytn?=
 =?utf-8?B?alVKK2VNZjVOWGtBZHZWRU1kVkR4aDh4TFM4RS9GUWRjQisvOXBDWDZVZjlw?=
 =?utf-8?B?UzBwZDJaZ0wyQWtRV3lqazN6aEZ2N0lJUWxjaUs4emxxYkhqeGRaa1pVOVBo?=
 =?utf-8?B?WW9wcjhaSXFoMVBqVUxDMVFRcmhBS253ZDlUYUticnpXYWl1ZWRUNEt1ak5t?=
 =?utf-8?B?b2JNcFcwOWRpcHg4VWd0VDl2bTViUzJzTE13b21NTHdXMmdGQWhhSGs5TStZ?=
 =?utf-8?B?OUZ1blUraWcydjRZTzI4b21tL2l2Ly93WWlsMElPN1RjNVZoamd1L2VHWTdM?=
 =?utf-8?B?dnRUWkhFSmVpRmlRTjV6N1lrdC9iZzJHdFJPeTRQOXlGVWhyZGZ2WFlacVRP?=
 =?utf-8?B?ZW1Ga2VwRHJHaE9TOVBIK2djVnRNRTgydVRydm5SQzhDVWFwWEd5WSs5RThM?=
 =?utf-8?B?N3FZTlh3RmVQWHJxR3AzRWxTTDh0bVJ4TXVjaFFTaGlnaGwxN0ZOY0RHVDJB?=
 =?utf-8?B?VjlhWGZqSyt5ZlRHczJpZUVjRVZvaGt6QURkazVkWjRMVUl4VitrRFVoMmxM?=
 =?utf-8?B?VWVaZWlDcGRHclRUUTZRaEpuZlZkcWVzZ2lXWnpFT3lXNHoxTnA0ZjVFSFNF?=
 =?utf-8?B?ay9WQkk4QjFiOFBSVXpvLzdZajNDaHdxRDdhR0VnQnVTbU9tTnJSK0xYNysz?=
 =?utf-8?B?Rnl3VHB4QUZtZ20zeEZ5ZERaTm04a3NOb0lDVVNUdVA2Tk1wYkU1TXMzUjcz?=
 =?utf-8?B?Q01Idk9xZ3ZWaGpLYkk5SERJUkw2SFNraGorcTdvQU41bWxUT1RqU2xaMFVP?=
 =?utf-8?B?cDFLeEF4clQrRDF0UXRrUUpha2dTS3p1SWZqVUhWZVRTYWJYd1RPcVFDTWVn?=
 =?utf-8?B?VnVBZmZEOHpxYSsyZEVqYThLaE95aFJtdjd0WXdTeGV6OU5RbHNZRW0yaUdq?=
 =?utf-8?B?dU5uT0lmTGhPb3pCczFGd2ZZcWIyZVhRTExKTkhPdG1aNGJaTXNxUjNQTDhB?=
 =?utf-8?B?VSs4bzhXeEdMWk92QUw5TG9PT2lDZEYxVTBqWDUwNDJKenl4WS8xNzYzellm?=
 =?utf-8?B?cURYRHB6Ujd4R284a1RtUFBOUGRHNUtpak8zN093Z1ZqdjNWdnU2cTRDOWx1?=
 =?utf-8?B?VmVqY2Z2aTdkSjgvRjcyVkFlRThkSk00YTNHQUtUcXhVLzMvR2IrZklvcnh4?=
 =?utf-8?B?S1pXVTZnaWxtSmEvbnpnMUhBVDhSS0l2VFA2eFg4dnIxSFYyeHBLMFd2cXg3?=
 =?utf-8?B?WC9NTUhJcFUyb1VEYmt2MjF4MzU2a2xneVFSZGgxUDU5RTRJTnlKL3NBZC9F?=
 =?utf-8?Q?v6J9reSu2rUzsSAr3p/vxKygZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7fef27-435c-45ef-5e16-08db0a16c283
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 20:55:07.3160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gmakjimb+y+pzcIRc87/BubjqBzXIspDZ7ysKlLhjlPpdYLYT25UOdfg4dHewXFvrEZEPAgde8YM/NQjUnyWBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
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

Am 2023-02-08 um 14:57 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> When xnack is on user space can use svm page restore to set a vm range without
> setup it first, then use regular api to register. Currently kfd api and svm are
> not interoperable. We already have check on that, but for user buffer the mapping
> address is not same as buffer cpu virtual address. Add checking on that to
> avoid error propagate to hmm.
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index f79b8e964140..6d9cf860d2da 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1065,6 +1065,21 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   		mutex_unlock(&p->svms.lock);
>   		return -EADDRINUSE;
>   	}
> +
> +	/* When register user buffer check if it has been registered by svm by
> +	 * buffer cpu virtual address.
> +	 */
> +	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) &&
> +		interval_tree_iter_first(&p->svms.objects,
> +			args->mmap_offset >> PAGE_SHIFT,
> +			(args->mmap_offset  + args->size - 1) >> PAGE_SHIFT)) {

The indentation would be more readable if it was properly aligned with 
the opening (, both for the if statement and the 
interval_tree_iter_first call. Our coding style is not completely 
consistent in this, but the existing call of interval_tree_iter_first in 
this function uses that style for reference.

Regards,
   Felix


> +
> +		pr_err("User Buffer Address: 0x%llx already allocated by SVM\n",
> +			args->mmap_offset);
> +		mutex_unlock(&p->svms.lock);
> +		return -EADDRINUSE;
> +	}
> +
>   	mutex_unlock(&p->svms.lock);
>   #endif
>   	mutex_lock(&p->mutex);
