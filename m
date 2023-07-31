Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E3FC001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 18:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C1510E2DC;
	Mon, 31 Jul 2023 18:02:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B75E10E2DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 18:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na4073pcBGKL62BPoBrJct8YmtH6FcigjHED/ZyxfqQ6ePZQNLcLOaxhZeB3L3oulE+j4Hg4uiOsI75GvEAUFUvvA7J18gTMeJJaa4I6yB95YUvZajg8+TkxDZ96I27UPR5O5oaNVpambEaXSBRI0MKles/OzyqD7vOSMU7EtKSLNa3CFzEcMI9WoUZlq910Kfk0RabmLcPd40LrECXEv4vyLuBstrviBoP/JfRmWgq18AjACkqqj6Gf6mzjH0s5UvY8tq1DP7F7ASd3jQCkLSHhrPzPPM7yvPCR446C1+pyaNIsVNHDRQkYsHTbs+dcnKRMtiaettiuC+ABixnkIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o4frQCDA0MjbejiINb3Z49w1rQVv76PtQ8QPAk1s7A=;
 b=Kqwu4817iTlWQcSDJ7gql7lTb6QfTsPm6j0E/S7lFmkQePno/CHnfQk+IgjGuTlerHKbfi8ctz7fKFTbWqvhF5GqhzX3GU+n4pEJtfHn6hpFSwrPyFO5RyrSqMO2yP8YsTlzC8XoBze3BDhEzvHttyZUa0L1aWhfjva2nP9hr4Dzl16semt9Ymvk4JvP5zGpLmu/74arWWPlrZL4RLL1qm4SumphaBJFBWj6ZvD4dq/+p4j7w8zXV0uaKQLUPMADSS0QmuRf8EHR3sbSBIIaisCgvwJF/VqWYe96pH6OwhJFYbYxz1GspIxXRuiMs2V2KD4z4UA2zM5g7zI/Z3w4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o4frQCDA0MjbejiINb3Z49w1rQVv76PtQ8QPAk1s7A=;
 b=PBZOtMS8uxwl18FjkSxRQR0lX/j/SwCEt0iFkBrra8HYUIOkibtl6v2qPyXRN8/8qJEkXipQEndzA4ThC2UccvEQgJXLdpG+W0BEbgDI8WZzqZqq0PUO1qcLo52ZVsENvFMXhlaE49FRT3Svg2gzAtC5Xst9NceDUYtiowBUhNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH0PR12MB8031.namprd12.prod.outlook.com (2603:10b6:510:28e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Mon, 31 Jul 2023 18:02:36 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:02:36 +0000
Message-ID: <90282859-6439-9a83-0bcd-b1cc1e5be8ba@amd.com>
Date: Mon, 31 Jul 2023 14:02:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/radeon: Prefer dev_* variant over printk"
Content-Language: en-CA, en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
References: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <20230731120416.2850594-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::25) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH0PR12MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ac2bca-ffe8-4fef-9ebb-08db91f05245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6t1BwqKwtXT+QhHu9p08vSw/8sL/agUVYTDgme3KOTuf2p+FFYx9Gz5vW4il0hEiQtwW2bo049QaGBbCJJg5uflEtfAGdE8QJkV/kgaO1P8oY6G/cmcmMdeZgbAI3XwAKPIPZntp689NYKedrLe/pPUOvmfTuMNNIyHZIKKRTirI9GMz4atHYMrllF1UDSglQO5+3gL4MJkKrkYf5DJO2w1ggQRV5vviSMUErAG2PChBbbLr3UF/xH7ecQojH5bGz2bQtsVPI1zfs+4ZJ1E2uUqo7Pqq4c+A41/7DUD8u41ollGbrr771+yfKB5nW6ktLu4a5aaK2QSMPh2eWjEeLiRNYb8TDeGBGhIhISWqRrS0Si7mdPsIlpPaqlg+9Vr97J9F+T/fT3ITbN5dZEsYEq2z11YSQ+MH1/ZmF/K+2afDOLLeGYYqiKl1TD9L/0lm1DKknagWBRokpoRauovWbDw9ekWScbqQG+5cLl8h4s1gQ6/WI0JnSQ9UHVd1Rb8g4j1WLKINI98RlwwfLqh9I3eYIzbNx7cCpmfZ84K9ALO/5r7PuDRZWO+r9m1Gg74eUkSoJzsItGUzMT9ehpV/OoIq4mP/t3Z81hyNgouZgFHCeAT6Z4XnEMG0aTzRycSXs1K+8/YesJTcUZqzp+t62iYtOos9vWL4L8TYkqKJbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(38100700002)(66476007)(86362001)(31696002)(8676002)(31686004)(8936002)(316002)(5660300002)(6636002)(4326008)(41300700001)(66556008)(66946007)(110136005)(478600001)(2906002)(6666004)(36756003)(44832011)(966005)(6512007)(6486002)(6506007)(26005)(83380400001)(66574015)(186003)(53546011)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0FmUmRDcnkyOE8ybXNOMkV0a0h5UG8vcU9DVUVML1NFZ2VydTN5U24vRVAx?=
 =?utf-8?B?OFZxSXpWNFgyS2dIVWJ5VzVTdjZNRFVvL1JkVGdrZnBhUHdYaW5BM2RZMVlJ?=
 =?utf-8?B?c3NhVUQ5dUtPZkNVSnppSzNvcXlSSk40MTR5MkpTQ1JoalJpdFo4R3M5NGNJ?=
 =?utf-8?B?R2Y1eHVnTjNkaXpPdTRHOVB1NzFDVmtIZUdXWThRcmpCTGtRWUhKS3RvUXlH?=
 =?utf-8?B?THdwakJoTlZybWcwOUdEQzhpOGZDZ2FGQVk5YjNzU1g4SmVzT2FSMVFLLzlJ?=
 =?utf-8?B?Q1k3NEJmZ0QyYkVaRXgxdDM2SFpVWThHVGdQVjJUOXNlYkRNaWQ0NzU4YmVu?=
 =?utf-8?B?aFpTWTlBV1E5VkF2UG9rc0Y1QlZsNEhlbk4xRU9wU05IbC9hekNSckhvZE5u?=
 =?utf-8?B?Z25QMVo3MEFvL2pRb0pycUJBYUN3WlBLSkM4VCtlMlF3Rk5nRUNtZEpwdWw0?=
 =?utf-8?B?OWhNSEltMUxydUoxWEloWFNZNUVjcnJvK3YrYWZYTlltUVpmVzZJYmRvVk04?=
 =?utf-8?B?eVdtWEFjeXQvMGw1L1IzMW1vTkhmQ3ZEd0FpMVRtbWRLZTE2c0g2TlYvTzds?=
 =?utf-8?B?aGhyYzJxR0VQZWxYMHNHRFBCUjlWRHM5QmF5aDBoVmhqMkdrQmdTLzRtTVlB?=
 =?utf-8?B?QjlNWUg4K3FUVUh6Qm5rUTRyd2RaNDdNR2g4T2FnTXhMQTFHWjRhR1JCTFNo?=
 =?utf-8?B?Rk1aa0xXYjgrZjhRSU51OFU2UzAzNWtwbmlCUHhsMlJPNUdjL3RuMW5Lb3VD?=
 =?utf-8?B?WDR5bFh6WFhkOVVBbWQxb0NnaVlZWWl5ZTAvWVA4cVdEbzVkZGFGWXNiQkVP?=
 =?utf-8?B?RFZxMDRYc1YrbXVBQTY0MFkrQmxIUWk3ZXVIUmIxU096SEhma2xkMU9heFJD?=
 =?utf-8?B?ZGllaXczVDZQYUtxZWEreUhUWkhxcithNnp3THIxM3oxNThIRFZ0RnV6dWxP?=
 =?utf-8?B?dTkxRGF0VnVzWVI3TzQwdWRib2FjVm8xaEVFUGNNckZZejRaWEw4ZXF6elFW?=
 =?utf-8?B?L1QrRHEvUjEwQTAwWWNYUzFGeUE3aFNFWEpwSWIwWHJwVHQ5RWNBdFdqSEZj?=
 =?utf-8?B?dWhwd2lYQkxlRUxvOFJXQ0pXL1I3UUR1TUxaOHEwdGhPT0cvb3VVcGdVTDF2?=
 =?utf-8?B?b01QSDRJZjZvWkhsZ05lQ1d0T3VHOUFCeHQ0VEMyV1Y1c3pjbElIbTJwc1Fx?=
 =?utf-8?B?T0wzRXdhRFlnZExkZzl4V0YxQkhQUnR5OSt3cCtTY2tHU1lXdndRV01naTdt?=
 =?utf-8?B?ZmthNmVwOEJ2Z05nZHhqSTZUcHZPOGdNa2NRTkRqNEZTVXpoQTRYczRqZHhT?=
 =?utf-8?B?SEVKRUZ6TXN5dmlMZERqUTluUUc5MGptMXJrWmpCcndpckpoRXpXQjArVTM4?=
 =?utf-8?B?cTRKK1VWMERJUTBLbk9kWVhRNHZPWjBXc0JCS2JjeEF2bWREQ09rZzVZZWF4?=
 =?utf-8?B?cmJlTlY1Tkg1MXIrTHEvd3Jwbnl6MWRCMXBFTXZIYVd5ZUo5Y2tQeXdEYm9C?=
 =?utf-8?B?MjY5cGYxeGdGRXorTjFXdTBtZWl2TDBWamJGVG83QmkwVGZnYjFFemkvRVN5?=
 =?utf-8?B?T0RVWG5IRHh6U3FRcDd1cmRYYmo5K2sydmpnNFlKTWM1L0FWaXNLMzJkUGNK?=
 =?utf-8?B?YU82Sng5UzFZUjRGQ2NGY3Rwb2RvRjZ1MmxmR2hTQU5TV3V1STRjWEpDMENI?=
 =?utf-8?B?TXFUbG9vdW1tOWg1MzZoTG1jT09VMVhWNC9NZDhOcCtCcEhucWYrV1ZMbEY0?=
 =?utf-8?B?d2c5cXlaaXdrMHdyZVZYbXVwLzRCRUYzTkZWcHMvcmxFT09XYkI3bnBaNEQ1?=
 =?utf-8?B?N0tUTjQ2ajcwVjBsZ0tkYUR6ZUtxTlFkVHh1cnNYN0pCNzJaRExydFhTRUJl?=
 =?utf-8?B?amNzYk4rMW1KSjlBaG1DSUtiUHp1QjlnZzgrNVVZczB4MUNTdktJODRsWU5r?=
 =?utf-8?B?M1BOa0VmeTBXOUlzcVI0YUprUW9CZnhKL2Z4cmZZcHd1RzExdFIyQWdHZDVV?=
 =?utf-8?B?cmtFdUkxTjIwUFpNQmsrVTdWUFJSaFI5Um1tZlZjMW84NHE0L2VqM24wdUdY?=
 =?utf-8?B?S0VrSXlHcy9XeW5UenFoak1Gd0VOKzk3U0NZL3k2dnkyS09TdU5OU2E0eHZT?=
 =?utf-8?Q?QknQWfwngrx17eYmDRQ0Nbny5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ac2bca-ffe8-4fef-9ebb-08db91f05245
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:02:36.2812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw3ZxmJ+VMQHp+Hu6bHYS2+Qsnftlr5euBjrMTcUyA0K/9Amp0NWEzPyU/mxBP5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8031
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
Cc: Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-07-31 08:04, Srinivasan Shanmugam wrote:
> Usage of container_of is wrong here.
> struct acpi_device *adev = container_of(handle, struct acpi_device, handle)
> 
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/2744
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Why are there two reverts?
Which commit is _this_ patch reverting?

You should have a single revert commit for a single commit, like what you have
here:

https://lore.kernel.org/r/20230731115828.2850334-1-srinivasan.shanmugam@amd.com

Either this or that, but not both.

If you're reverting a commit, you should list the commit you're reverting,
and it is missing here in the description of this revert.

Regards,
Luben


> ---
>  drivers/gpu/drm/radeon/radeon_atpx_handler.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> index fb4d931fdf18..595354e3ce0b 100644
> --- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> +++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
> @@ -94,8 +94,6 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
>  	union acpi_object atpx_arg_elements[2];
>  	struct acpi_object_list atpx_arg;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> -	struct acpi_device *adev = container_of(handle, struct acpi_device, handle);
> -	struct device *dev = &adev->dev;
>  
>  	atpx_arg.count = 2;
>  	atpx_arg.pointer = &atpx_arg_elements[0];
> @@ -117,8 +115,8 @@ static union acpi_object *radeon_atpx_call(acpi_handle handle, int function,
>  
>  	/* Fail only if calling the method fails and ATPX is supported */
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> -		dev_err(dev, "failed to evaluate ATPX got %s\n",
> -			acpi_format_exception(status));
> +		pr_err("failed to evaluate ATPX got %s\n",
> +		       acpi_format_exception(status));
>  		kfree(buffer.pointer);
>  		return NULL;
>  	}
> @@ -159,8 +157,6 @@ static void radeon_atpx_parse_functions(struct radeon_atpx_functions *f, u32 mas
>  static int radeon_atpx_validate(struct radeon_atpx *atpx)
>  {
>  	u32 valid_bits = 0;
> -	struct acpi_device *adev = container_of(atpx->handle, struct acpi_device, handle);
> -	struct device *dev = &adev->dev;
>  
>  	if (atpx->functions.px_params) {
>  		union acpi_object *info;
> @@ -175,7 +171,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
>  
>  		size = *(u16 *) info->buffer.pointer;
>  		if (size < 10) {
> -			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
> +			pr_err("ATPX buffer is too small: %zu\n", size);
>  			kfree(info);
>  			return -EINVAL;
>  		}
> @@ -206,7 +202,7 @@ static int radeon_atpx_validate(struct radeon_atpx *atpx)
>  
>  	atpx->is_hybrid = false;
>  	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
> -		dev_info(dev, "ATPX Hybrid Graphics\n");
> +		pr_info("ATPX Hybrid Graphics\n");
>  		/*
>  		 * Disable legacy PM methods only when pcie port PM is usable,
>  		 * otherwise the device might fail to power off or power on.

-- 
Regards,
Luben

