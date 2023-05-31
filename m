Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D29AC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 06:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2CAC10E1B3;
	Wed, 31 May 2023 06:39:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95FD10E1B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 06:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5YyJJ0KDxuwm1MduYrN5bH5XfHdP+niv1awPqjNiAvBCcE4+2c+6i55HYCj2mUyYgaHM0fGrIWu5h0FykZKBG9WPnYmCnwexU8yOHrMUYI+6KeITl50NqBa+XkclGpHo0/tmNm6Yc4aOe6zgPLUl9bR0nUXoZ54BWgXjx0u9HMPrhLBE1sfDShXTgzsgbzyUNhw1dwkVV/UUiTxPSeniBZcfOEDSuCJ9dcS2DE41KApFNWNNNqz50VBUulQLvjfv0SC391hJRvkx7j/4gvDdEtphaWS0awsdTP6f1wb1DKj8NhTNo115QgOcS8f6iehHWF3TIAqgxBURHtW3OEbyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5UMa5iCCi1eCMACiFPcrfcEna1fWxDTULVJjCwZD7uo=;
 b=G2cObVFFyo5f2/TOMgj4XufF1LN3cCPusa7EO4T6RAu+40k6GlbdExLTy+7n5zQRHOORFAkUomuLQ1s3r+ZQlizvNqCB+pvRNNQ59mC/9WjtrrsDNcL1AALlgYjDrT7QpaSIjcIv6CelXsaom2ERsE4H4qd6Hf6Rk32Cv6lhTB5X6PtdcJ+du98WczBpdv9uyngk0pnPeHBC6qXRbfYbVmem7zkLDKlegb9jR+9oTvHxjRQ+pcXXNpTuU5umykNX84YHfhe+f0oHR57n3nMh0InOhG1wA+Tnoml0Q8BPkwr0qWLhrbkn3Pxgzud900c7LKNydcKAULbWHA9xYoN4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5UMa5iCCi1eCMACiFPcrfcEna1fWxDTULVJjCwZD7uo=;
 b=KPQfvn5EHT++db6B4TLFumoz3SLWqyO7HXMSNUHkM7Vwi22aU277ECqX+2ogmQIsZ0YjLrILWdvOnhRaUccWdN0vJEm+YmDFejvpiR3BZERpffsygv7jcQPSuJu14PxAfP9LCBZnefgT7A760o5lSOJOxXdiEEspg6p3xVBPQEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:39:14 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::1693:e671:ec37:5a10]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::1693:e671:ec37:5a10%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:39:14 +0000
Message-ID: <be8d8d16-8f2b-36f4-b09e-96bc560157e4@amd.com>
Date: Wed, 31 May 2023 08:39:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/amdgpu/sdma: set sched.ready status after ring/IB
 test in sdma
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Guchun Chen <guchun.chen@amd.com>
References: <20230518070215.3556653-1-guchun.chen@amd.com>
 <20230518070215.3556653-2-guchun.chen@amd.com>
 <CADnq5_Mp4k+0rjsAP2Fe75MFkf8HzThrHsqdHxWpqBVStSot1w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Mp4k+0rjsAP2Fe75MFkf8HzThrHsqdHxWpqBVStSot1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 988625f0-8a74-47c1-a2d3-08db61a1bfcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ZU8ZtRmQeVsmxHyySh5XrIxO9+QW2U1DBS+CkTjgHjfnAPaeUMgf9IwPRjt9fsnlxtru97z0QdO3p/za9moRpSMzQMrGs92oM0Dkxjj9NxCJohp5eyiVjdPx7D3j4gKsM/f3Xa+eHFzv+QL75ev7zY0C1jiYBE/PI5wQeHDQ0YgWbw29jhg54I+a3rG6QZGnBBgaFhJpbD1D9PFk1NQIqDl2rHFwu/NqiTxGNX5rm1cRGMlc72Yf0IdmsLQwerPk6Rlv/Dcj41o3fWxkAtz6pB2Rl2TFBnYjCd5RfQ8uIzqBXnaF588xxUytXFgy135fSnKX4nwDgC9bhQ8F1cl6guS2KCw32epkP5DwrMxeve6VXtcA9NpK4Dj1s6M2WBJi3bdhQwvlm8oB5wIJqNardvcC5DsiM71Dr2emm1fzHSeHe0PrHNXidH4iBxLsROqZm0IKSU3+qytCW148LrkAY7Wzo64YwuB6V2qE9VcBL9BbR3JT+u+nCMyjfH4aZDtkeeVmdOMX9WUGQN8mrogzo0LUvlAB7/o3O7rVW9E8FooVlK3ynePW5AG7E2kY6eRr4aRExxjhsUs96i9Yru7mT2BmX+fRGJ0OsRdOzDY3NiQ1RrjPve6PhktrRK3m6v53zNPDS6TVpxHK41q0ZGftQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(6486002)(6506007)(53546011)(6512007)(6666004)(478600001)(110136005)(4326008)(66476007)(66946007)(66556008)(6636002)(316002)(31696002)(8936002)(5660300002)(8676002)(2906002)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djVYaXQrMVNiRDkrektKMnk1RXN6TS9jTjVkMVozMVdQbnZRVGpKUnJrbmNZ?=
 =?utf-8?B?blpBSDd3dWMxUGxPRS96dDMwZUZOZ3A2UWtlaDNZckZMRi8wcXJvWEFnRnlo?=
 =?utf-8?B?cmptdElvbGx1Z25RNU1NeUpsSVdUcGNhb1d5c3kzOWZtbDJMc0cxcUlrQ1cr?=
 =?utf-8?B?ZW9GN2U2YjRMRlMvSUxDVFd0bjlmcnBQRXY4VnNsMHFKV1pWbTVnMDZOTS9L?=
 =?utf-8?B?WUFxWTcyUzcvTDF3akdMZ3lreUNoK29XRFg3a0I4N3JkRzhsSUZhcXBTaUtZ?=
 =?utf-8?B?UDVFbWJ3ZWpEb1Z5WTJqNWs1bDZkNUx1ZmhSYVB6dEhXbnVWMjZ3cWdYRkNt?=
 =?utf-8?B?ZW02bm4rb0t6Y0FxbE9XM1Z3b29lNG9UWFU0Z0tPZ1paZWhGZ2RYd3E3Rnp0?=
 =?utf-8?B?NkhtN1VjWXlQU2VQY2hudmxMSFpHTVk2aDgreFNQU05mOU5KRVdkOHdUbGpW?=
 =?utf-8?B?Z1d3UWcxb0ZSd1JMQWp4blhLRW5tWGNLTHJlWFVOa2g2NGJzcnQvNlJSRW51?=
 =?utf-8?B?UkJCYzROS2RqcUc2R3lCa3NFczFERzVqQjBzdnBtZlVwNC83Vlo5RWhkdUhy?=
 =?utf-8?B?VUk5dzVHdXB0Tjh5dkNlREU4c3kvZjlqeEttSy9wMmRlbzMrYzhTRWFNc1dz?=
 =?utf-8?B?ZDBnYkVkL0g1TVo1TTh2M2hwOU94U3gxVm5FWG9SaFB3eGx2aFhDelh1QjJm?=
 =?utf-8?B?WHlOcHBNM1RlVWx1ZmNxTUk1eFdCN01IUTFvMFduWFVtQlpDa2ZFVStsK3Zu?=
 =?utf-8?B?bXA2MXZmU1FIL1Q0c3dDd2d2OEdJSzBQU1E3ZUhFL2pSSTYwbGRVbFJUSWtJ?=
 =?utf-8?B?N21HNzRkdmVBRU5UZ0I1cXZQTU5iWVBiSGZpQVZHRFp0eWs3Qm44b0RDUTkx?=
 =?utf-8?B?THZkL29ISEtLMWlNRTdiU2l4WXRFU3lNTnlaSnVOU2RrbU1PbVVuNjQzTURl?=
 =?utf-8?B?RXQxcVBIamk1YXMzLzJsYzJNeUNnMTNvR0s3OW5EcTFvUmJsa2FHdjJ2eU45?=
 =?utf-8?B?UjZkK3ZlZDFDUTQ4TVp5ck5EZDl2cDdpZ1M0T3NxU3hlQkFpZFVQc1VrbnRC?=
 =?utf-8?B?VFFXd1M2ZHoyVGhZM0F5alBRcTBpa2k1WG1PSjVaOXlSdnJCTzF1VXpkNC92?=
 =?utf-8?B?THBYNmV1OXhkT0VQMzh1cGhIZlVKeXVNNSt2TWpYb3EwYWhDdGI5bDd5VjB3?=
 =?utf-8?B?eDk2QlpySkoybEpBMTYwbWJ2anJBdHAyQk55TjdKYnluNTMxcG5lZG4yTnJo?=
 =?utf-8?B?RjVubzVKb1hPNDd2WExsaTcvOTVhclJBOVFtVXVRWFlVek5rWHQzWitwK0pv?=
 =?utf-8?B?VldHVjJuMUxxeXFvOGNldjhNOHpDUVkyaFgyV2REQVRXM2xhRmxyd21RTmxu?=
 =?utf-8?B?MFZ5UVd1TXVCS3NrWWJuc3ZVQVJhYkhzSHlLYjFOYzczVUZnQVlFd1E1YVFl?=
 =?utf-8?B?TEJDNmdIZ1BSVVVERjliYTlMNHVKOGd6VjlHOVJsL0xERjNBQi9wWkhKSGNj?=
 =?utf-8?B?TTRLcmg5Mm5ndGxsVHhRdkcwaE9yRzhuR1A0cUpLaXI3ZUNIY0ZsU25OU2do?=
 =?utf-8?B?RE9HWjd6bXluS3ZEZnQvS3VJVStYN0V6Y0ZtWWFWTy9takZYdXZMaHNPZVdW?=
 =?utf-8?B?RkhJdys1U1p5bmF1b3JaMXhmdTZPRUFSb2FXbU1lQnhyUEdwUDAwRktrTk55?=
 =?utf-8?B?QUFOalJVa2swRjlvekM4aUUzblVkOGJyajBrOE0zWTduUGJnVUpKVEMzb3NB?=
 =?utf-8?B?V0hXM3ZvQjlVdWoxbDJJdlA1TExnY0ZTdTNjQmIvM2doQ0c5K096d2VYWTBv?=
 =?utf-8?B?SDlJeUZyYUgrUlBKT1pJbEJCdVZ0bGNqNFpWNmdEb3pFMjdCVlZRQnBRRzJG?=
 =?utf-8?B?RDlmVlpBMENSYzlmcVRaak41YTQvWHdKa2VIS0xEOHFRNkdoQ0YrdnlvRGVx?=
 =?utf-8?B?aHorYVhHRVplQnVNNjZSSFNPaUY5QTlTUkczVFFCUis2OHBzV01oZ3J3cHVN?=
 =?utf-8?B?RWpyR2JsaVB2Yi9LelFUcnVra24wT0FKbHdyZTFEL1ZqYTB0Z2krMEtZUHM3?=
 =?utf-8?B?VERpVjVySDljY0xLRUd6cHdlSzZCQnJHTklOWWJwWnQ2SlFFaHJUK29MUXI1?=
 =?utf-8?B?eXU0aCtEOTBPNkN2eEZDK1RyQzVYVW9ueTVXWFFkcWN2UWIwdk8yVjRwYjNG?=
 =?utf-8?Q?sgCLNscewAEK5qQuwwzTKtG8PeO1PNx4sBh/DdAjGD7a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988625f0-8a74-47c1-a2d3-08db61a1bfcf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:39:14.3290 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeKbNJmnuRMEJuMRDscKYbsGOlYUI3lz1RZ9M+RMU+mpYd3iyfkyfiE3FIjqvXeN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
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
Cc: alexander.deucher@amd.com, xinhui.pan@amd.com,
 amd-gfx@lists.freedesktop.org, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If you haven't already pushed it: Reviewed-by: Christian König 
<christian.koenig@amd.com> for the entire series.

Thanks for looking into that,
Christian.

Am 22.05.23 um 16:47 schrieb Alex Deucher:
> Series is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> On Thu, May 18, 2023 at 3:04 AM Guchun Chen <guchun.chen@amd.com> wrote:
>> sched.ready is nothing with ring initialization, it needs to set
>> to be true after ring/IB test in amdgpu_ring_test_helper to tell
>> the ring is ready for submission.
>>
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 2 --
>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 2 --
>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 2 --
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 ----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 ----
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 2 --
>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 6 +-----
>>   drivers/gpu/drm/amd/amdgpu/si_dma.c      | 2 --
>>   9 files changed, 3 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> index 67d16236b216..52598fbc9b39 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> @@ -489,8 +489,6 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
>>   #endif
>>                  /* enable DMA IBs */
>>                  WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
>> -
>> -               ring->sched.ready = true;
>>          }
>>
>>          cik_sdma_enable(adev, true);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> index fd2a7b66ac56..51afc92994a8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -466,8 +466,6 @@ static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
>>   #endif
>>                  /* enable DMA IBs */
>>                  WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
>> -
>> -               ring->sched.ready = true;
>>          }
>>
>>          sdma_v2_4_enable(adev, true);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index e572389089d2..344202870aeb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -734,8 +734,6 @@ static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
>>   #endif
>>                  /* enable DMA IBs */
>>                  WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
>> -
>> -               ring->sched.ready = true;
>>          }
>>
>>          /* unhalt the MEs */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 9295ac7edd56..e3581852ed9c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -1114,8 +1114,6 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>>   #endif
>>          /* enable DMA IBs */
>>          WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);
>> -
>> -       ring->sched.ready = true;
>>   }
>>
>>   /**
>> @@ -1202,8 +1200,6 @@ static void sdma_v4_0_page_resume(struct amdgpu_device *adev, unsigned int i)
>>   #endif
>>          /* enable DMA IBs */
>>          WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
>> -
>> -       ring->sched.ready = true;
>>   }
>>
>>   static void
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index 64dcaa2670dd..c3517d9fc38c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -659,8 +659,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
>>   #endif
>>          /* enable DMA IBs */
>>          WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
>> -
>> -       ring->sched.ready = true;
>>   }
>>
>>   /**
>> @@ -750,8 +748,6 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned int i)
>>   #endif
>>          /* enable DMA IBs */
>>          WREG32_SDMA(i, regSDMA_PAGE_IB_CNTL, ib_cntl);
>> -
>> -       ring->sched.ready = true;
>>   }
>>
>>   static void sdma_v4_4_2_init_pg(struct amdgpu_device *adev)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> index 92e1299be021..e2fe539ff3ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
>> @@ -819,8 +819,6 @@ static int sdma_v5_0_gfx_resume(struct amdgpu_device *adev)
>>                  /* enable DMA IBs */
>>                  WREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
>>
>> -               ring->sched.ready = true;
>> -
>>                  if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
>>                          sdma_v5_0_ctx_switch_enable(adev, true);
>>                          sdma_v5_0_enable(adev, true);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> index ca7e8757d78e..23667605c372 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
>> @@ -617,8 +617,6 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>>                  /* enable DMA IBs */
>>                  WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
>>
>> -               ring->sched.ready = true;
>> -
>>                  if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
>>                          sdma_v5_2_ctx_switch_enable(adev, true);
>>                          sdma_v5_2_enable(adev, true);
>> @@ -630,6 +628,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>>                          return r;
>>                  }
>>
>> +               ring->sched.ready = true;
>> +
>>                  if (adev->mman.buffer_funcs_ring == ring)
>>                          amdgpu_ttm_set_buffer_funcs_status(adev, true);
>>          }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> index 3d9a80511a45..280a878cad68 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
>> @@ -585,16 +585,12 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
>>                  /* enable DMA IBs */
>>                  WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL), ib_cntl);
>>
>> -               ring->sched.ready = true;
>> -
>>                  if (amdgpu_sriov_vf(adev))
>>                          sdma_v6_0_enable(adev, true);
>>
>>                  r = amdgpu_ring_test_helper(ring);
>> -               if (r) {
>> -                       ring->sched.ready = false;
>> +               if (r)
>>                          return r;
>> -               }
>>
>>                  if (adev->mman.buffer_funcs_ring == ring)
>>                          amdgpu_ttm_set_buffer_funcs_status(adev, true);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> index abca8b529721..42c4547f32ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
>> @@ -174,8 +174,6 @@ static int si_dma_start(struct amdgpu_device *adev)
>>                  WREG32(DMA_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
>>                  WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
>>
>> -               ring->sched.ready = true;
>> -
>>                  r = amdgpu_ring_test_helper(ring);
>>                  if (r)
>>                          return r;
>> --
>> 2.25.1
>>

