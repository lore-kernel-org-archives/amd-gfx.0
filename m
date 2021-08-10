Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 15:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31ACA60ED8
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 15:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31ACA60ED8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7E0897DC;
	Tue, 10 Aug 2021 15:56:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D14897DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 15:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH1XZ58g3nUnENgxCdYz95KPrD9Kmhu3OIg0w358UQpKUO/YN4KEJIXgcIt79olH/+7HmYfpQijIhApmltDk3T5MLQUhA98PBxFBThv/7Ty0akgF9aVcBMz5blaawP1TOIW3BvY5xVOo4bpIBfdrydworfBYDy/8SlZZgoXl6t8ZZC3x+zUIjiIPK5iKxrJr7ThF02+PP5nPLV6QtsXw6otQJVwhuYyHOc5zZnMa0WH82TbhtwsulzjmfIIHc6TkT/Td/B1KZUwI2fYD6fdTQDKtWSuVglrIagDxWeNQs/NZCQG8oTzQzNYxIfWH1f3bSSfByAQAV8ZvPg5Qo12Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGy1ORdsPnySlxvk9mnyKiYL5ryyDVytSjuOoILI3s=;
 b=duqoPnY+qz+Ed+eN43Qwqs/OCmQ8k0EsNPzL/MknT6K9ZaCn6n3EqDH7KMcHlUzjoJpk3T5douwcexUaSi0q2Nn70FQ/fUuG0M06C/g5JMTrLdHO0U61xfuUuAr7xIwSxDb8BaPdp8OqVTAE2QBxXeoC801P01WIEbDUURdCuqX79Q8wbNindEfTAi6hVxQOLghrKBwdGtDYnT2wp2O/jgJpGeu7vEGB6t+ySD0o5aGYzBCMoky1GEZl9loHrCE576dn0VZcLsRjV7exp5+d0ntrEMy9CyzUW8jyA6VyJO4xCo/TxjD7KFZMOPEQ6hEE7R0qymz8H2QJv7TiDCGjJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGy1ORdsPnySlxvk9mnyKiYL5ryyDVytSjuOoILI3s=;
 b=VdZFbiIZRtofc0L6s30tiz5DoD+acVjZFf2L06lIg+RDziSRVGSmCbR83r9HtB1RvDrFDotAQT0MYYU34gCOMg8Qe3jhjSltmkv9NWVxp+xEbvxsJ+DbFAm2SOGF0oFAHRFRoB+aH4RPSz9uaq2EJJJbuBO6O6lboiI+QbvpUqA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Tue, 10 Aug
 2021 15:56:48 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 15:56:48 +0000
Subject: Re: [PATCH] drm/amdkfd: fix random
 KFDSVMRangeTest.SetGetAttributesTest test failure
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210810044310.3805858-1-yifan1.zhang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <a07e70af-4ab8-a359-480b-d348755cbfd2@amd.com>
Date: Tue, 10 Aug 2021 11:56:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210810044310.3805858-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::14) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT1PR01CA0045.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Tue, 10 Aug 2021 15:56:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d43aee59-1e74-47f6-4590-08d95c1775c9
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5356A261CE426667A435021A92F79@BN9PR12MB5356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdSI1l+75xOyqHzjt6se0K07a9kd/rrmD0myExahYfOcwgOWUV4PvhU0upRhn2mmy8wUXK0Rqhdtlt01g7vFvWVKC5gvBQ5jE52IXRxKrfGsB3Kqo6UkYRC/lFrlMFlEW4Q4QYZxKyMuPgwUM+q6l3SazpE0didn4tEaxUcpTLMvEFwC+PMszdy3pgMIJLIujZeYBmdzY0dFhMuS/mA+D57VDhl1bUdTHhcBfOeC8baXtKE3xab9EeYUd/NoRXqBOkD9AgXD/TErUELv0Kzs2O99qHaT0pBsrtRXYmTqJLCd2Uo8QdJY/S/ewn6JxUz0jVYGJ4AKn+Cvz/On4uXK5sntKJGYomA4Toa5JjhrMi3WMZwc3AoM9Vh5DtwAfTPRY2/9UGijLKtki1zQQHuElqf+v2E3WQL9RfWLkDDx9y4sp/TUD4aqCg7hv6D7KMta8dqgMN/Vup8LfOtjWqxmL9/mIBPL94mLa7vyV59bSIDfj2jvdyIEwfOXJHS2miXlNLs1InvRgaN99/sKDWiBX4lNfAcgAkMn1U6Q4bq6oX6iirtV//MYnfQvCWEmDhergOimUza+wiGm6eBk44BRjMw+BDVjsWjjBGUypiTMhSiENvZ2y7DiD3rQs/7OX5eOy47TgWms/CIBfqGt98aUJVdKM9apqA0IXqPS56blK4OuLsfqU6I6OQZJVmviUZltZzkgqMi5wln1BPLRrIxODMrR9OELBnjymaKyycrv2+YMPHi94uarDdvidH99Bfyy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(26005)(5660300002)(66556008)(478600001)(38100700002)(8676002)(2906002)(66476007)(186003)(66946007)(8936002)(316002)(44832011)(31686004)(36756003)(86362001)(83380400001)(2616005)(956004)(6486002)(16576012)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk5jZVg1M3l3ckNNM2pNNHJiZStPZzJPcWFYMTN6d2d3VkpmM0pxRmw2RFJU?=
 =?utf-8?B?ZzBYdUF0Q2NVbUFXS1hua0dPRVNtTUpzV3hYU09KOUtjVlhnbk9EczFjRkVG?=
 =?utf-8?B?VnRHWU5Bc0U3eXE3TUtybEtPVFRUN2FKYnMwZkVWNUpUR2ROMHFGbTlqbFBP?=
 =?utf-8?B?d09MSjBkbEhjTkRPL1J2eEx5a2dOcUZiWHpWTzIrMS93UlplWFNZV1ZHcEpl?=
 =?utf-8?B?V1NhYkh4VzhJVkcyRTBEcU5LSzdqdUFWYkMxQzM5ckhvdHVWY1pGUzdDd0RJ?=
 =?utf-8?B?dEJKUTAzalNDVDRPb1dIVGdkcDdZTTZHVnoxdHo0a01tb3VubktTOGtCZkhT?=
 =?utf-8?B?amhhN1ZYYVFXT2hTcExaaTZYWlU0TVMxd0wvcXZML2l5MFB0bVo3Uzl6bUU4?=
 =?utf-8?B?ODBJSHNnckw0cWRyQ1owM2VjcEhxckVhSExFNTBhOFY4VEZVMEwxL0x4MFJN?=
 =?utf-8?B?Q1dpaTc5RG8xTkpRMFEwYjkyU1dUZTJ3YUE5a3lPZzlpbDg2Y3dNeG1WODhq?=
 =?utf-8?B?a0V1Uks1Q0lFNTNDUHZYRVc2cDRFcThJSFJMY01PeGFMM1NXdU9reHgrTllJ?=
 =?utf-8?B?UnJJUi9vV0FqVkdRNzB3V08zQkp4cEY4R0hIMFBFaG9vSzVkK2U5b1JSZHY1?=
 =?utf-8?B?cE5FN3VVb2I0Y3dGQTJsYW1rNXpoN0V5NzVCOUhUYVJKem5ybSt3WWJhQzNn?=
 =?utf-8?B?eVR5K1dGTFNMb0UxdTNlQWFBc0VqaStNUWxJc2cvVkZHb0swNUlTbnNVbk9m?=
 =?utf-8?B?dmxhQVV5OTBVOUhEaVJ1UHhWY3pENWt4aGtha0FuVDh2bVRvWkhPazNndHFT?=
 =?utf-8?B?S0Q0b0o5L1lGZkhTWUI2M3FhWE45S2hIc2RrRS91QWhheFFHTHFzTk5DNS9K?=
 =?utf-8?B?QmhndmdjQTJIeThxYitETWJ2ZC81MDdxS2pSM1Blbmd1UGtsVXNOK3cwY3dQ?=
 =?utf-8?B?QStGY1JoK2g1MGlXM0xscHlvNjh2Qis1V3lKOXRJdFdzVm96NDZWOTgwc0Rl?=
 =?utf-8?B?N2hzMUVDVG9XcjNmQ0ZqTC9wbFgwY2R6VElCN3QxSXdnTkhVbkhrQ1g2SWxO?=
 =?utf-8?B?MjNEWHBCWlhlemxQQm93bVc0RVNJZjhpWnRrY0dJTi9Ic2g1bERkeEhETUxN?=
 =?utf-8?B?eHVOTy9EaXFsU1hyOGhkRnRheTB3NUtLRVFXRFV3dXZ1VjRhamsrOU15bGNM?=
 =?utf-8?B?V3R5dHBIWm5NcEFMM2xxaFROY3lpSVhWTVIvUlpCVzdSeEE3VUZCazNIVzVr?=
 =?utf-8?B?WGFnYzBSc0VJUzhVRmtwRnY4NzY1VysxRlRxVXpMN3pRWThIQzZjQTUzWCs1?=
 =?utf-8?B?ekI2NEVuNmlSL3FXaVpVMXFScDRqbElYNkt6QkdmcklLY0VGZGcyUDZOMk82?=
 =?utf-8?B?TzhwbjlyZURpL0RIcE5QMzljMFhMam5WM3NaTWxCcklzd1gzRm5odDZoamxB?=
 =?utf-8?B?QzgxRmZGeDJEa216R0NRaHYxOWhZczJGSnk2YllCdkY0a2FGS0tId2VoY2FR?=
 =?utf-8?B?RllZajFGaHVYcFhkOGkrZTB6RFN3bC9tZ0dFaE5BVjdWYTdJUFVFVG12aXE4?=
 =?utf-8?B?bXFCdXg5Q1FqN0c5SFcvWXkvdVdaNmhQVVZEcElpdXM4VFFGNG9pMkxZZ2tK?=
 =?utf-8?B?a2pKbnlUaEVONkdOZ0JFV0MxNCtRVDJhb2Y5TThFbmlLcEd2K2ZqV3ZtU2FS?=
 =?utf-8?B?NmU2UG11NVhFNVRaVFJFOVdRczZlR2NKZHQ0eWVzMHFmOWxMWGdsZE9IUHl0?=
 =?utf-8?Q?Aa7Tl/1gZCHm81VBmCKiHTiNG/qsIX6NHcDaTHT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43aee59-1e74-47f6-4590-08d95c1775c9
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 15:56:48.1476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YG/tIByFyMKXqzeyK4a/dVkkFf6vQGIhrI2ZphTeN3/o18w6tP5Jzu9FFXsLrYZQs3UNTM9Y+6FmEgfWxySAjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
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

Am 2021-08-10 um 12:43 a.m. schrieb Yifan Zhang:
> KFDSVMRangeTest.SetGetAttributesTest randomly fails in stress test.
>
> Note: Google Test filter = KFDSVMRangeTest.*
> [==========] Running 18 tests from 1 test case.
> [----------] Global test environment set-up.
> [----------] 18 tests from KFDSVMRangeTest
> [ RUN      ] KFDSVMRangeTest.BasicSystemMemTest
> [       OK ] KFDSVMRangeTest.BasicSystemMemTest (30 ms)
> [ RUN      ] KFDSVMRangeTest.SetGetAttributesTest
> [          ] Get default atrributes
> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:154: Failure
> Value of: expectedDefaultResults[i]
>   Actual: 4294967295
> Expected: outputAttributes[i].value
> Which is: 0
> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:154: Failure
> Value of: expectedDefaultResults[i]
>   Actual: 4294967295
> Expected: outputAttributes[i].value
> Which is: 0
> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:152: Failure
> Value of: expectedDefaultResults[i]
>   Actual: 4
> Expected: outputAttributes[i].type
> Which is: 2
> [          ] Setting/Getting atrributes
> [  FAILED  ]
>
> the root cause is that svm work queue has not finished when svm_range_get_attr is called, thus
> some garbage svm interval tree data make svm_range_get_attr get wrong result. Flush work queue before
> iterate svm interval tree.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f811a3a24cd2..192e9401bed5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3072,6 +3072,9 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
>  	pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", &p->svms, start,
>  		 start + size - 1, nattr);
>  
> +	/* flush pending deferred work */
> +	flush_work(&p->svms.deferred_list_work);
> +

There is still a race condition here. More work can be added to the
deferred_list_work after the flush call.

Work gets added to the deferred_list asynchronously, for example in MMU
notifiers. Trying to synchronize with asynchronous events is inherently
problematic. It appears that the test is making some assumptions about
things happening asynchronously (page faults or MMU notifiers) and
that's probably a problem with the test, not with the driver.

Alternatively, there may be a problem with a set-attribute call that
leaves some operations on the deferred list and results in unexpected
get-attribute results. If that's the problem, we may need to add a
flush-call to the end of the set-attributes function.

Can you provide more details about the exact sequence of set-attribute
and get-attribute calls that is causing the problem?

Regards,
  Felix


>  	mmap_read_lock(mm);
>  	r = svm_range_is_valid(p, start, size);
>  	mmap_read_unlock(mm);
