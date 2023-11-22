Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9F2C61D97
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EF3D10E6AB;
	Wed, 22 Nov 2023 22:40:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7B010E6AB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 22:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4nMnjqHFp6cOIt5Da+6NI9oFtudH6WcUIHKGkvMPRxcEtFWKHwss1jmEtElrcpksBEyDLl9TaHlqUZborF7OQFQ6/wBlqg6lt2JqE+x0C68J0X17rsCwXKRgCE0KAF3T1zs1sEmlEMClTpyaMXvhHPgk1lVfK9Ds1biVyobr2mjlDtBYxRLgCMla7uXWeqYweKjG8GUaXclO+Xb2oP98uFr0+W5XosmHSu5g54xAU/dhHh4vgHWyLI5TVX2hMu4YfPJ0Hm+A3HMXLFFsWzLT3yhWUhEGgsHpobG7TGZu0g4alyhVzDgo0VL/cHz18ovFaeA0a3oBsnhP41scMtdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VGWtG0PYw+55UYLozFdO6HSor3aZO5GeWk3x1030Wyo=;
 b=cS+CFCtEZrf3m0Qgt1cXfS6miCqsm1mNi4rXFpJVHqVRHRKUbPyhsf9bI32brM9Q0j5+8FynN4vQv0YdElbZ6tkesru6pnXfKiBzupdgC/3syPS6MWs3eFvu0QN2kVgfVq8CS2EvSvrCKqFxBH0q/Xuzo1g8tLWUG0yV5T1iNYYyI2pXPIWtZqXQ2UprJzoBBnUPdMlfApuUfm/Nia4W9tJfFxjoDuBxDLh11x9ar9oIU7DRPYdJjf7YHpWD+hesKYNcqLHWtU8XyWo5I58ima32DdT1JrwK0z4AgaYCIQAn4JDZ5edWIonBjlb/tk0Prwr1N1XKyzWV8F4ytV5iVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VGWtG0PYw+55UYLozFdO6HSor3aZO5GeWk3x1030Wyo=;
 b=DBy5gW3oi4bkRqvQr3r8M9ZNOsdWyN6x/0JYYuEIZGASjzTiMIT7QBuoykWlZKWUbRw+mAYrKzaPx/9ZsArEfSoZcCnT8vYA4GpJCyzByCpbxAirXJ1il9hSycKKgNQDIqYwXrrd0EtDve/nFjjh5hPyotmIyttHIqaExWX9dV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 22:40:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%5]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 22:40:08 +0000
Message-ID: <f58f8c06-ff76-4d85-9116-6f63f22c29e5@amd.com>
Date: Wed, 22 Nov 2023 17:40:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] drm/amdkfd: add pc sampling capability check
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231103131139.766920-1-James.Zhu@amd.com>
 <20231103131139.766920-24-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231103131139.766920-24-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::28)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff48e7d-334e-46d1-0898-08dbebabfb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gv9XOK0uJ6pLziyLoaPK+x/WMzujvqIqqSfu2pOjl6r5oWiVxaJ36xVTFUhwCRI+R6Nf8R89DLqVZsEIevtdD6wZUdQ+UXwqzAYwqXJpeSamZ91QksAHt6S7iWPM+An7Vxd3n+olnLIXBkEzApB3LZFb/w+mMlqcjdjqQ73qDr/Rk+BBF7frVzG0Aw9q+Xszie9+8spc1gJXs1rM6R8m8hDjFf82py3SNnsikv/6uHfpBIp08QgoXYV3VU5dJR495rixWEaMcalZargsxlJbMZLFOJkz/s7vdDXpFZRfvMRdGuBtlItakfmSDdwjVUGn12UBLBhQsuOd3Yat/QlSHaswRsJNOcEQ2Lnw1slsfvnbh8xOT1Lq7CgT1bOiUpCXp14gXxDKWKlGhPnfPN3adGalkPm5lS/zsp+wgtv/TlxEP1unAfDewXN5XIytzcIZuIto9PSmZZX5iRZyffnW3aJTH6sgWDxEPMPi0VQDzi+jvYKjSKU7XkGkyCowZRMGt+WkE64eg/I519QUsA0msmZ5fcaVbpTggsOowiYzId8pY0BBzLPy870F8YRTVhX2ccdbfa4yve4M2Sb1zTQFiMonxfecBjp4e2kCLG2U/FjEFl7lvAWRvgXFZd+LERUaeT4B7zhTOtlzyms74jMvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(6486002)(83380400001)(38100700002)(2616005)(26005)(31696002)(8936002)(8676002)(4326008)(44832011)(36916002)(53546011)(6512007)(6506007)(31686004)(478600001)(316002)(66476007)(66556008)(66946007)(41300700001)(36756003)(2906002)(86362001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBZSDlDdWV5QW94NHkrckdGMUJhT0VSb1dzRGVDN1FKenkxK1I5YnV3a0Zw?=
 =?utf-8?B?WjlldFRmSnNreWkwR3JWMnJHQXhDdlp5ZUg0d1FucjVwUHc4Z0Voek1GZHoz?=
 =?utf-8?B?K1E4ZjJ5Qk9HSmJRME1mOUhxYnpDQmlDZ3hvdUN1K2VwMXV1L0U1SjN1alRT?=
 =?utf-8?B?SFM4NXNjODkvRDY2a2hQL1FFOWJRMzBDWlU5TjBLUnp3SURNbThlYk9KUitM?=
 =?utf-8?B?alFQdWJPbzV1QTVtMjhhWkxkNmRTWjNLeFpnWDRacGxzcks2NzdBVWVuajA5?=
 =?utf-8?B?bm43WVh1V0YyUWhlNERjZlk4RkFsYjhuVTNZTVNRS2l5UFpHU2hhaGJMNDlB?=
 =?utf-8?B?UlVMY2RNMTRXU2crSGNTaU5qKzZ0Z2N3VjU5eEFrOHRTVlRQRWpXOVBQRVNn?=
 =?utf-8?B?alloYnF2MitxdWxDOXQxUG9KbkI3d04vdVhuZXhOdkxIREFlcnRFd3RLZTdK?=
 =?utf-8?B?NmR5V0FtUSs4RWFpMnJWdEx6UXBQR1BFNU8vN1pmM05WcjNYVEVZZndCSEdJ?=
 =?utf-8?B?MWFzNFZES1NWWEc4UXRJWjhVN1VvMjdJZGJBV0ZqSjk3dTJ6Um9PSGFZdjRy?=
 =?utf-8?B?dk5LSWhuSlpuc05pOTRzbEJUMEtYVm12alBwN0lxTkZqL1ZJTjBabUJyQUwz?=
 =?utf-8?B?WjlCU2lkNVRLTVVIMENXdVdieFQxUXJ0MDI5Z2pndmRVVWcrSCtNUHd3MmdD?=
 =?utf-8?B?N1FrOFk0VytmSE5Mc3g4SERscVdkZ3JuQTM1VFcySDdLOVZnTllhaFlVMnZm?=
 =?utf-8?B?RFVSRHVRMTVZMGduZEtkKzljMFFUaDJxczF0Wm00UTFMbFRBbTkzUU1HSmMr?=
 =?utf-8?B?eHlDdjVUeXFVRk1Lalh1eTNCRjA3enVJL1o4Um9DRlZIRkZubytNV2hJdnRS?=
 =?utf-8?B?WVduWG9uS2pIcFk4UnhMWFB6cFpUWUI3bWtnbWdHL1E2d0k5aVB6VEsxa2FE?=
 =?utf-8?B?ZlQyUGpMOGVNakRXcGJLMFlNRlN1VSsvNVA4UlRGNGxSMXMwekw1SjdaVk4r?=
 =?utf-8?B?cEJ2c2VOYXpqWlJLT1FWazRrMVBEcnJXS3JmdlJuSVNsbUpKOW1YTFNtWnYw?=
 =?utf-8?B?MXN4Tm5FYkU0ajl3ejhaVFZTamR4b3FCSGZ0M3NEWG9LVUZUSWM0eVNLV1lz?=
 =?utf-8?B?RWpPZkt0UTk2L1ZzUmgvVVZicnlVQkYvdU84YXl0MVQ4RzVKT2tmcnpDRE03?=
 =?utf-8?B?Nk5YUmpMN0RkZ21ZMlR2ajYrbUVCWld4Q3JuM0x0U2MxMkxIdG92UDd0UWxz?=
 =?utf-8?B?Z0FlN0tEUGZGemhub2VGNk9zbXhrNE9vcmFEdW1TYmRScWtEcU5LT0ZJRUtp?=
 =?utf-8?B?WHhXd2JLeU1TQzBGU3BDM2E3RDQwdDh0RkpVSWNhMXV6OWtrdDE4azN0STdO?=
 =?utf-8?B?d3picVNrUG93QndBeDFmQktvMEQrL3dXVUZEK2NmQmhyOTF6a0pBRW5iZmZG?=
 =?utf-8?B?em9WanZXeHljSjNCR3JxTzNyUjBRbHE3OGFiQmlHR0JERVBBeTZ5VkFnUlQ2?=
 =?utf-8?B?YTZ1Y295cVV0dUpadEZySlRqL0h6VXlJQTdIbmZwTXNRWnJCRHNUVUp1SzBH?=
 =?utf-8?B?LzFvSmdYZHpBMU9vTjR5cnUxdzdxQUkwb0EzSjZiOURUVlFTOW5qVEpRb01O?=
 =?utf-8?B?UEk4MXo0OHVBcytFOE9SNWJSRFlUUFNIdmd2bXl3NDgzZkRSdDVxTmFFQ25O?=
 =?utf-8?B?VkNSaFNTTk95ZElDSFQ2M05RN292OERuRldseUEzWG4vUXNQZ2tGcWxlNTZz?=
 =?utf-8?B?TThkRkJSeEo4dmlESXB1MHBiUFFwck8wb3ExNVRBSDljbjNDYmtjdFFQTUlp?=
 =?utf-8?B?WUJYRE5QY2ZodW9LT2FMYWNWcUZBNFZtYWNKeVhCYWJtaHVscWlJSHd5S2NH?=
 =?utf-8?B?bXh6cldtVm9LSUlwYkg0Z3p5c0puMHoyY1pqenJreFMxL1JLajU4WjFYK3Y5?=
 =?utf-8?B?L1NsOVhPSm9mTTRkZFFmVEw0N21tVUZyVWpQVjdxZmRyWUpuZXlRNTVDV0Jv?=
 =?utf-8?B?a1ZvVWYzMnFjbTBRZ1hSeXVlZ2c1S2ZrVXdhd2p2dm53NUdiTjhMZm1pL3JD?=
 =?utf-8?B?ZzNJOGgrbS9hZE1LaGZ2ZUVESjZ6QkR0ZVEvSlRGdDI0V2NLN2taV3pWV3NG?=
 =?utf-8?Q?IvxXPAtqCyouJ2C+1CkElWNNR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff48e7d-334e-46d1-0898-08dbebabfb0c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 22:40:08.8438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d69xIn5n455CLi5N8U/CYzSlT2pTT/M0YXGELfPFhTwIEt+LlWiHaonO2bPl0+AQpv0DkrrDn3GPpbqpwU7xrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8476
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
Cc: joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-11-03 09:11, James Zhu wrote:
> From: David Yat Sin <david.yatsin@amd.com>
>
> Add pc sampling capability check.

This should be squashed into patch 2. Or if you want to keep it 
separate, put this patch before patch 2 and define AMDKFD_IOC_PC_SAMPLE 
with KFD_IOC_FLAG_PERFMON from the beginning.

Regards,
   Felix


>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 10 +++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 13 +++++++++++++
>   2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b00390e451bf..5e47e374d824 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -3259,7 +3259,7 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   			kfd_ioctl_set_debug_trap, 0),
>   
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_PC_SAMPLE,
> -			kfd_ioctl_pc_sample, 0),
> +			kfd_ioctl_pc_sample, KFD_IOC_FLAG_PERFMON),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> @@ -3336,6 +3336,14 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
>   		}
>   	}
>   
> +	/* PC Sampling Monitor */
> +	if (unlikely(ioctl->flags & KFD_IOC_FLAG_PERFMON)) {
> +		if (!capable(CAP_PERFMON) && !capable(CAP_SYS_ADMIN)) {
> +			retcode = -EACCES;
> +			goto err_i1;
> +		}
> +	}
> +
>   	if (cmd & (IOC_IN | IOC_OUT)) {
>   		if (asize <= sizeof(stack_kdata)) {
>   			kdata = stack_kdata;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b7062033fda4..236d3de85153 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -144,6 +144,19 @@ enum kfd_ioctl_flags {
>   	 * we also allow ioctls with SYS_ADMIN capability.
>   	 */
>   	KFD_IOC_FLAG_CHECKPOINT_RESTORE = BIT(0),
> +
> +	/*
> +	 * @KFD_IOC_FLAG_PERFMON:
> +	 * Performance monitoring feature, GPU performance monitoring can allow users
> +	 * to gather some information about other processes. PC sampling can allow
> +	 * users to infer information about wavefronts from other processes that are
> +	 * running on the same CUs, such as which execution units they are using. As
> +	 * such, this type of performance monitoring should be protected and only
> +	 * available to users with sufficient capabilities: either CAP_PERFMON, or,
> +	 * for backwards compatibility, CAP_SYS_ADMIN.
> +	 */
> +
> +	KFD_IOC_FLAG_PERFMON = BIT(1),
>   };
>   /*
>    * Kernel module parameter to specify maximum number of supported queues per
