Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30653C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 16:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21586146D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 16:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21586146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882096EA4F;
	Wed, 30 Jun 2021 16:52:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5AB6EA4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 16:52:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmWoD4tH+hrYQ50CS0foBu+ImPzPMbvmn4+txA8H7u1+g5rnBLn0qHvyelaNayzjua03VWsAQuvVMYGX+Ad1pDF1NnqOhUdmHfW87JE/CdoT/UmcScZLTOsuG1h/0bnUCSreFjlVKx35ktYFZMnIrpJ3g7RVQDe4MJU6MO2Tv44ouoLHvZisEQEaVY2bcoWxLEl9UKtJJshO6pJA31+lVWtzG2xA/m7ava4r/qwEF+nzTa6T2zQfs0X/fqWJJMVB4DTrys9BISFoLl2tWSAaShjHyP0vWN7x5RV+mSFTRbiM3bOzhmT1lnnzvEwtqIe4VxRZZU6jsdpb2ce3cJNG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpddpkJQ1g1bE1xDbSCq6tAp6xNC/W0Gxm90mSGQE7U=;
 b=l4B0aK0/hDRenp4dihaGCxTxNIq/pfGfzI6PB5MroFTfWGLIeANsfljT8LQpAdIa7bGKPMGZBxnOnbWK6dUH3EnNJ0SL+n3nDYL3t6ohZMjgMca4m8Z7ERuS1LM2hIKYeIwvdIdiOdJMSVNCXvlfFtVM2Ljs9CCWqMv/lVBZck/5MqNvBxOOiWJ21uOfnIHIweWhAA4tllnDN+3m7mqV1fNZ/mh7cO8Jq9MgEGPud9PEkmALmgJw+XzBtP/yYhib4xWTbi3x4wuX3oKZwxDcyj/kFuXpyNfTj4Autvelgy18weGzIfWYf/2u8DquORxRw1u2YYl70W7TG2Gs6v/Ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpddpkJQ1g1bE1xDbSCq6tAp6xNC/W0Gxm90mSGQE7U=;
 b=TLvlbuHi45uKiaV//2pnTIHXOgyuCUu4cN5UkBvxP3xuxgof2t/xBG2YxFG5UBc3+J3XG72hjy4GvdQKsYg7T/Or6hqRe5i2/akqoQQeANfpd3m4qJIjn7HVDi+oymdqOReXX1qiofVDzMuGzT9fczPn+V836jVBr6XK3y5eUKA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3369.namprd12.prod.outlook.com (2603:10b6:5:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Wed, 30 Jun
 2021 16:52:28 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Wed, 30 Jun 2021
 16:52:28 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay (v4)
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <ec72a9d4-8033-f3cf-903a-8cb0281aa103@amd.com>
Date: Wed, 30 Jun 2021 12:52:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210630101012.2006307-1-YuBiao.Wang@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 16:52:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14080d9c-93a1-4f92-b5f9-08d93be77194
X-MS-TrafficTypeDiagnostic: DM6PR12MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3369DCA55D9BADF8E0739E6199019@DM6PR12MB3369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6gnPn3k3tei5aoYe2c+40PBdaP+qRajVdA2R9OgYUdNP+rK+4Zx05zrx4WzMXpyJPOrLdbYzW2KSt9DWnG3QXLQj19nyeUvn6g4DVmSLd853krkO2dznRZynRnywaDR7t3M8qbBkdkqfWAVM55HzJwhEc34tNAYt1nALnSYbyyGJ5+jiUAKKxwmfiOm9hoThuL8jSecou11mDSR0DFV7yC8Af7TkyGbB+nMOPftrdzd76iyoyOgbr6jhH/BwNyZGyw5ndnEpYmDeZZnecViqY66K48fBHnGRh5dn3wq//aTiLl8BmpiwyXoelVB3gFW8PflGhAy1djpihJ2kHH3amvHLJpk94h0h78NQXix4YzIDc8PsbLcAQVWWpMBSqB03GrJfXFsAJGIq16GKSWVlyyXV5lyFZmwNeoZZzq5l83yhslg9yfdbQ8V3Wwdv8jF40VnE/79savZ+1nr3HRCvNi73mZHOV0DKcEUOHJuBH7imZ9WVot5MEQrTS4z1YSD1DAAQtXcAUiWhY3vWJwBDf2tUFjA/VW8Lja7qjeV4Eh7sTL3RdO/cLyjM2qvoYabyWvOoYgynLhRMP5MNsUIZBzY3lXTc0h/OFdOZ3A4+0CNpptbR3Vqm7pmeTW0K7NygLv25JEwwFhxsXl2idZh1+AQwyY65Qq3XeXXoY1XvXWbMwWJELQfKCOpAlk4bYIsxW1H9pxBPWoCYBD4sxXfX3vDivzDUr+88fdmNz6pxi4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(54906003)(956004)(83380400001)(2616005)(6512007)(55236004)(2906002)(16526019)(36756003)(44832011)(26005)(4326008)(186003)(31696002)(5660300002)(66476007)(66556008)(31686004)(478600001)(66946007)(6486002)(8936002)(38100700002)(8676002)(86362001)(316002)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2RIQnFEN0s2QkEvM2JhWEVoWlNqalE1UjZQalNCY05STnBicG4wdE92cklC?=
 =?utf-8?B?SFg4cFNUK0dHL005SnFjK2hzc2xGVjY0cGIyNjFCbjdEOXlOblk3MWJxQVJZ?=
 =?utf-8?B?L1VkRFBBVzF4c2hEYmRXN1d5cVJzOEgyVzkzYWp3TXZCa3VsaHM4OTlNakd0?=
 =?utf-8?B?bGxwYXBiTzlidWN6UTkyQUZlQ1JNNWdWZkVQK2Z5TW5vRDZjMCtYcGtqZFVZ?=
 =?utf-8?B?SjRFNXBoRFpvZ0VzZGdiY0NHbnMrWElIYmFOak94bW94TEtUVHlQZVNIRHdH?=
 =?utf-8?B?Q0kvZ2dkT05tY0VnOVE3ZHB0dDA4dmlCdmRXRHFBbnllYnlzbmhZZWpKQ3Z6?=
 =?utf-8?B?SHhCMjVyT2hYR0Nyb2hMNFF3TTFxbXg5WDFTTG4rdFo4aU9TazhtNWhYL1B2?=
 =?utf-8?B?RFZWMVc5c1MzNTNIODc1WjVFVFlSTFo3SU9wYkxLdzBoT0dSNDVjcGV2U2h4?=
 =?utf-8?B?V1BCQVV2SmRTT2NPUEhjM0xqNHZ6V2dZcGRDRmo5UVRNalNjQ3NzTkNhSmwx?=
 =?utf-8?B?S1JsVlJ5YmhMdFRncnMrUy9MZjIyWVZpUGFaUmRxalRKODRYbHBBWDZLUDd5?=
 =?utf-8?B?c2RsblRnQUYvdDdNMEloYldHZE0zYWJkTmF6bEFVZFlFSzNzaml0bXdzWG1u?=
 =?utf-8?B?S3hzRW1VNmNBTTNKN1dGNFd5MHltOWRvemtjazlubXYrTFJzc2UvejdualN1?=
 =?utf-8?B?YU00eGxvRkM0MG5aaWxOTzQ0UktnelFFWGk5dVpUN1loR3ZQd0J5MlQvT096?=
 =?utf-8?B?Y3NCNUt6bTlJR2RqV2wxOXNBWHpQeVk4WmNHTHFETE9qM1V0RzUza1B3K25C?=
 =?utf-8?B?RmVZZFJRMUNFdG5CbisvTVVNaXBhVFpSWXhudEVVNUZQeFJla3hsZUtxUVRK?=
 =?utf-8?B?WVRXUGVaRWIraWcydVdBZHFhVlozR3k5blJyNmdRcFhtRUR1MTRmcmFvemNF?=
 =?utf-8?B?WjBHbUw0d0RUemRBTHZ6M01ENURjR203VERjQkxGVk8vSSttSjBxbGhsQlJN?=
 =?utf-8?B?TW1UM090MnNmSWlSdm9LNEJDM2owREpkbWJnVzQ1d3p5NURKa2loWlBCcW1i?=
 =?utf-8?B?MzZ3bXhuaThPQ2hOdmNlR1grVXdodlJjZHF3QTM1dm9NSVhGNUpYSTNCQitZ?=
 =?utf-8?B?eVNPWjIvclZybDBtNXFRMmI2cldUWUt2a1FSaHd5TDZtSU1salJBY29QQVI3?=
 =?utf-8?B?Q2hLU2wvc1JCZ3VBcVJsdmowNFgxZFI5MmpHZ0tCTVoyMXJNb0NXU1hGZkY1?=
 =?utf-8?B?eE4ySXl5VnRXU2pEY3BkZjZiZW5PWmtoc3hrRDhpYjJ1cmk1eFdkUE1zaTRQ?=
 =?utf-8?B?Y0p4a211NWNmeGxxYWtxVm9JSUQyUE5lUWsxT3Q2SGFyWGtkM1NsV2JQNnJm?=
 =?utf-8?B?cUlXQXRvZGIyZ3BYZHZxbzZ0RWNJdHJFcXlJYzZHZU5uWlNyYW81bEFGODZP?=
 =?utf-8?B?TUtubHp6MmN0ci9QaHB2Ujg1T1FKb3Nvend6b1JMTEhpK2VQZnNzZGRPK09w?=
 =?utf-8?B?RytlaFNuRUtPRnFFMURpbTFhcHdXOUtPT0pReGZORXU5alRPUlpwZEQ3YzVx?=
 =?utf-8?B?anNvN2g0T1pNMEt0WS9rc0FpOEE2Q2xhb0IxaVUwOFYwVzVld1VDQ3MwTENV?=
 =?utf-8?B?WEtUall0WkxGRzlOK2VtUXhjNTcwZWNMQmZkZXNkTlNBaEpFc1ExcHU1YjV4?=
 =?utf-8?B?UjNlQmNYVVJMbHNlcXVJRWdSdGVwSUlNb0hOWlpaQW90djJZSURCS2ZqUktn?=
 =?utf-8?Q?GkXjmrA/axcBPJ1X+jkhbzujj63003bLfrVP2LT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14080d9c-93a1-4f92-b5f9-08d93be77194
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 16:52:27.9880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSSQ1LTfAelbuudBXfzU/T2mAx8Ivg+WpaifUKEGC5/50hY+E7qzf/KwyzTsMOSw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3369
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-30 6:10 a.m., YuBiao Wang wrote:
> [Why]
> GPU timing counters are read via KIQ under sriov, which will introduce
> a delay.
>
> [How]
> It could be directly read by MMIO.
>
> v2: Add additional check to prevent carryover issue.
> v3: Only check for carryover for once to prevent performance issue.
> v4: Add comments of the rough frequency where carryover happens.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> Acked-by: Horace Chen <horace.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index ff7e9f49040e..9355494002a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7609,7 +7609,7 @@ static int gfx_v10_0_soft_reset(void *handle)
>  
>  static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  {
> -	uint64_t clock;
> +	uint64_t clock, clock_lo, clock_hi, hi_check;
>  
>  	amdgpu_gfx_off_ctrl(adev, false);
>  	mutex_lock(&adev->gfx.gpu_clock_mutex);
> @@ -7620,8 +7620,15 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
>  		break;
>  	default:
> -		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
> -			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
> +		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
> +		/* Carryover happens every 4 Giga time cycles counts which is roughly 42 secs */

I'd rather have put the clock frequency here, rather than some interpretation thereof.
This would make this maintainable in the future should the clock frequency change.
"4 Giga time cycles" isn't a standard expression.

Something like:
"The GFX clock frequency is ..., which sets 32-bit carry over with frequency 42 seconds."

It'll also allow anyone to check the math.

Regards,
Luben

> +		if (hi_check != clock_hi) {
> +			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
> +			clock_hi = hi_check;
> +		}
> +		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
>  		break;
>  	}
>  	mutex_unlock(&adev->gfx.gpu_clock_mutex);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
