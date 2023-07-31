Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7679C001E0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 18:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBB010E2DE;
	Mon, 31 Jul 2023 18:06:48 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2048.outbound.protection.outlook.com [40.107.95.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B607110E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 18:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgUBoigchML61FgTISEl6/3216Q2Wga+jaTPUdYaqmzp9W/9nIK/996mNH6a/y0FNufTX3Ji9tf/kIGolQ3dK6Uyd93e4echDg/sTOf/4/d6s8y3T36+iLQW2107VV9PMNZ5oLPtH0DBhgEkCfVvXDAg+sDG1JS9k284ZDf3Hb2mkFkXew/ckBsEpa0JXXhmDCQMKKdchSJZwZjzm/f0AsGKtv99Jmb+iMFsFxzsp4SLpdIMv2wDDs+FlWgFmeXJuGn8LWljg8jX9iwKVuRHob6+85sRfGCtVqrIi3jptCw6dbfZ2I82cwOysWnRroyvJHMLlw6W0XJLOGOfc5iuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ApFH1hvYJ1CB4ePlEzZba57zHsFr+D1VYapK+tWl8Q=;
 b=JU4i6YK1o57zGwppOx7Lp+FqqXP1X6NWmw2Om3GD8Pzq4jbk5GUPZJ9gP6nNWSolhsYWtfA2q+zFhOzIvAJa1u46hr/71RwVLB9yrVve/mx2IC0N4VLxbRcLggnCS+PmHkfBxasFvOE+yMP6KbPbxZ8xtm3XXYOvS1v0esgZfCA3QPtnmED7nZ/D61FYe06X2l1BI2LH6c2dv2OLcu7OC1bbriD47iA4z+cHUQiD2z8amo4fD8oU+LV15A+MoyA55PtQQeRYtdHbb5hYC1N9+0ZGIyr6cEqO5XJO2jLcjXWj3hbc5nSSx9Op7CQQ+UxwZDsNKBkBaQqGYjTtOzgyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ApFH1hvYJ1CB4ePlEzZba57zHsFr+D1VYapK+tWl8Q=;
 b=l2ao4rgD6Os04Pe+x0M1bE1BuGNl+7BIPA+xAei+ApDsuvAQe9eIYdphSWkq1CNTdpxvy8CBQZJbZMadZqDvccsWr84PIGtYTHF8YP9uiVUUfpfPb2AXq6UWmUSI1Hi0yhmV7J7JlHtyCS/PsnFS8sw7wZ88Q1jWyti7W4Wznyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 18:06:43 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:06:43 +0000
Message-ID: <8718cf98-e0c0-5154-9fe8-824c7c4293ef@amd.com>
Date: Mon, 31 Jul 2023 14:06:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Prefer pr_err/_info over printk in
 amdgpu_atpx_handler.c
Content-Language: en-CA, en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>
References: <20230731121815.2852832-1-srinivasan.shanmugam@amd.com>
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
In-Reply-To: <20230731121815.2852832-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ecb128-0909-4c4b-d945-08db91f0e56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rKdpKhLc6E84FX+Zl7PgfyLV56ZcbmRe3vEqofbgWrjJBx0/qFiRS9EmQY/NsM4pXwFqKmzQdjNMjfey+R9390UX1aHuXHQQwXyexDzCZerdE8Qlr9LCXhaLzrndXKo9sn7/npfJVZOxM02O1IMT1dCJx7/mMf9pqnbnrGZNgXukneo8ZUYML4MroQ8oxqRIvIgL5rxG1EQY0MRBc8OcJGMfBbhVzqXasECAB26Ozx/tfuR4e8h1TPgo9KEQiaI1X5xn1EEYikPzN5xqwppDmRnF5DZ+jm5j/4nrS4mESuyafifG5dNgOKKoMZQo5MC/j/RtkyQmeV9RbFJuz4JyX9twkreSc4UVR9W4j42Cr87JrslcaxyOiHfgDl/rEXDxhh9dte/6p+rJXql3c6eFMYlr+GVqQiq2Zto3GuoubHKBkNVHsXgms7wvbY+7f4c9WNPmC238hHq1SrWV68DYtBC4c5dLOHCIQCRrBPEU6ExqUWhott/qewxJF5Aeb5r4qCNEuTWmJZ9kdA+tniXwYEXojB9xeAAdIJ9Bu8YlTlOriTGRwPTywTrHPvMwqWccSS7RUkrK98SxF0zzsezS5mSJc3pA7Yluv4ZfAkMUYymZCrGPH3TZABazjqPB/ceFcLy+71ISmkqmmq/uDoZsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199021)(86362001)(316002)(2906002)(8936002)(8676002)(44832011)(41300700001)(5660300002)(36756003)(31696002)(6486002)(478600001)(66574015)(26005)(6506007)(53546011)(186003)(110136005)(31686004)(2616005)(66556008)(66946007)(83380400001)(6512007)(6636002)(38100700002)(66476007)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JtUks2Ni9zTkE2MUhjQ1g4WFE0TmZGSnRLL0xZSldpbEtzWks2TG1VVGow?=
 =?utf-8?B?ZzVMT2NFTFdIcnIxQU1HUkxLVVR6aWI2RE1TUWdtaVRxRk50L0toVTlwZC9t?=
 =?utf-8?B?cGVxVjdDck1FcHozRHphTHBpZlZhanBOMi9YU1ZJSVQ1YmZvMFR3d0dZWExL?=
 =?utf-8?B?MlVKbHNuOXZFMTZvdDVEV1kvYWZQY3ZJMm5SU1RLOHpoeGZIS0lQYTRRcUJ2?=
 =?utf-8?B?Q29MSjV1c3puTWVsaCt5ZzQyQ1RYcW9sTDZNMm1FU3hYUHB3NVRtK2FuVXU1?=
 =?utf-8?B?RndSdDVyRXhPNWNxZ0lBM0JNTDhyYjRLNlpOTmRnZS9EU1Z1MGlybk5acVFv?=
 =?utf-8?B?dWhSYUxvdWVIRk1xNjRBY0YvaVBlWWU4MUpNKy9LUHU5bXNOYnovTERnS2Vu?=
 =?utf-8?B?NDJUZksxcTJrYVh2UzQ4QWdoaE1adGtWcmdzbjFCcG83cTdrTzZ1Sk5uVmYz?=
 =?utf-8?B?aGVXNFo2RUFrS21OR1oxMjJzTTF4bXRhMU5lNEZzaGRwVk10elQ1MWMxcGF6?=
 =?utf-8?B?YWtjVFBaMHUwNUR6V29IZWZCcGVzMDZHVC9WMHZDNzhrT3c1OHdPOWxMVG91?=
 =?utf-8?B?Q0QwbFE5RjA2cjNOdUZaZFc4WExRV2FEUUthdzZEdGlXY1o4RnFNQWpFa1hC?=
 =?utf-8?B?enNFdmpGbnJ4dVF3eXMyVmRtTW5sc0VRNlNKQnUzWXpVOXkzZ3g0amJVV3Vo?=
 =?utf-8?B?citiT2x1L1Bhc0lvZVJjSnNVbFZSS3VybTdqWmxsOHBwNmFyb0J3aW54aFZO?=
 =?utf-8?B?UmhIbEJlZXlacTIzYTNOWFp3d1JZNTlKM2ZOU2JlMit4aE8vdXNzcVN6THl2?=
 =?utf-8?B?c1QvbzFsdW1YU3duYVlWRFBGMUlMRDZ2UGJvZjY2bTlNWENhblQxTTY5ZjND?=
 =?utf-8?B?MjY5N3R3OTdpZCtDRitCeXBobURhRDU5WFUyRjZ6TzNBT1RBam5LQ240alFQ?=
 =?utf-8?B?eXhrNWxxbjkwSXpVcUNGMVdjYWtteE9ITktmVVpnUzA1Ymp0c2tpdXlPd2FC?=
 =?utf-8?B?RE5YTEJwdURMRDhVNmxxeFBiNzZ4UGhoMmlCZFhGbGw4ZGk0VGhWelFJaXc2?=
 =?utf-8?B?cnpLVXFiL2l3OU9UY3dFN3U0RkFYUXkwZHh6UlRTU3VMcjhXZU5mV25hbWdL?=
 =?utf-8?B?bEQ1VEZyRzBOUVNvOVRIcklNZEhoL3IwRFpKNCtBSi9wWEJtcm96Szd2elVl?=
 =?utf-8?B?OTNrSkhvcXYyVVdHd3NIVmZTMDEzQW1SUkN1NklFbEJYS1YzNVNWVFB6M0gr?=
 =?utf-8?B?RVRCbHcyRFMyL3lkc1lXQUxxY2VaclBrZ1huTllPQUFINDF5VytLZENIbjF1?=
 =?utf-8?B?Y28vYk56cXFmQ3I0dWthSjBucThQTEVGeFZjN09ya2dLSkdPT01QZC84RE9r?=
 =?utf-8?B?Z3RrZ0RFUlFLTC9hM3RYWWVuQzg4SGt6UU0vaytGQ1FYOEVVZjVpbnpuWWtl?=
 =?utf-8?B?Snp4UVR6K3NtUFdSa2hHNjMySUkrWkdrMWcyUW9MQmNkVWNTQjRvSmdrNUlE?=
 =?utf-8?B?Z2FZZklPdXFGMW81Z1h4SVRFdU5JUE1ReVF2T2xBUnl0VEx3RXF5TVpyK2FS?=
 =?utf-8?B?ZmpFN3dyQ3B1M0IyQndrWWg5ODlaazBRNjlxc21odytPRlF2YzVYTzBWWDdZ?=
 =?utf-8?B?dTlmTThGbG9zdEZ1aGoxYkpWTG5CRUUvUGFoc3Zjb3haeWVSQjRXNXhnS2pX?=
 =?utf-8?B?WHkvamxJUnhSbUR6NHBENUkvckJpRjhVWTNBaWNRbFhKQkpwVHVYeG1kRGVr?=
 =?utf-8?B?TU5HSUs2VWtsOUtSb1hNL0JTT0pmNWpGdmRQd0pscW5CdlVoZVVxdHR2U0pP?=
 =?utf-8?B?TlhKcE1DQll0eWxJU1k5WGErOWNxZUN5YjRROE5jcWwyeTVrK21OdjRBTnll?=
 =?utf-8?B?OHRtUkwxeWtCMjdvVjRQelhKOUVzcElRSEtCZ3Y2LzYvcXc1LzZnM2Z2NWls?=
 =?utf-8?B?cDZUdDBqdTVPdXNBOVplaTVNM1hKY1d1QnZYdllIS2o4S0dWU3k2SURWeGpC?=
 =?utf-8?B?KzJaT0Rja2lWa0s0VUVmSEtTUFhGTVFBTklPbTNScllJSVFPbUhDbTFOZG1J?=
 =?utf-8?B?NWljRHZVbk5FTDRLVUgxWEtReFgwbnRpTTZleVBGc1dRdlBza3hLQTgvTTRI?=
 =?utf-8?Q?zARifFhNnx7plvv3HOYV4N6k2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ecb128-0909-4c4b-d945-08db91f0e56d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:06:43.1445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K62RLtjEGXqaX2eC0SVU9RffVB/I0Y3nTztcR9GDANrDS+LVsGgWBTsZ55z4Tx1p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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

On 2023-07-31 08:18, Srinivasan Shanmugam wrote:
> Fixes the following style issues:
> 
> ERROR: open brace '{' following function definitions go on the next line
> WARNING: printk() should include KERN_<LEVEL> facility level
> 
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index d6d986be906a..9ba49a1b7c34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -74,24 +74,29 @@ struct atpx_mux {
>  	u16 mux;
>  } __packed;
>  
> -bool amdgpu_has_atpx(void) {
> +bool amdgpu_has_atpx(void)
> +{
>  	return amdgpu_atpx_priv.atpx_detected;
>  }
>  
> -bool amdgpu_has_atpx_dgpu_power_cntl(void) {
> +bool amdgpu_has_atpx_dgpu_power_cntl(void)
> +{
>  	return amdgpu_atpx_priv.atpx.functions.power_cntl;
>  }
>  
> -bool amdgpu_is_atpx_hybrid(void) {
> +bool amdgpu_is_atpx_hybrid(void)
> +{
>  	return amdgpu_atpx_priv.atpx.is_hybrid;
>  }
>  
> -bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
> +bool amdgpu_atpx_dgpu_req_power_for_displays(void)
> +{
>  	return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
>  }
>  
>  #if defined(CONFIG_ACPI)
> -void *amdgpu_atpx_get_dhandle(void) {
> +void *amdgpu_atpx_get_dhandle(void)
> +{
>  	return amdgpu_atpx_priv.dhandle;
>  }
>  #endif
> @@ -134,7 +139,7 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
>  
>  	/* Fail only if calling the method fails and ATPX is supported */
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> -		printk("failed to evaluate ATPX got %s\n",
> +		pr_err("failed to evaluate ATPX got %s\n",
>  		       acpi_format_exception(status));
>  		kfree(buffer.pointer);
>  		return NULL;
> @@ -190,7 +195,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
>  
>  		size = *(u16 *) info->buffer.pointer;
>  		if (size < 10) {
> -			printk("ATPX buffer is too small: %zu\n", size);
> +			pr_err("ATPX buffer is too small: %zu\n", size);
>  			kfree(info);
>  			return -EINVAL;
>  		}
> @@ -223,11 +228,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
>  	atpx->is_hybrid = false;
>  	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
>  		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
> -			printk("ATPX Hybrid Graphics, forcing to ATPX\n");
> +			pr_info("ATPX Hybrid Graphics, forcing to ATPX\n");

This should be a pr_warn().

>  			atpx->functions.power_cntl = true;
>  			atpx->is_hybrid = false;
>  		} else {
> -			printk("ATPX Hybrid Graphics\n");
> +			pr_info("ATPX Hybrid Graphics\n");

I'd use pr_notice() here.

>  			/*
>  			 * Disable legacy PM methods only when pcie port PM is usable,
>  			 * otherwise the device might fail to power off or power on.
> @@ -269,7 +274,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
>  
>  	size = *(u16 *) info->buffer.pointer;
>  	if (size < 8) {
> -		printk("ATPX buffer is too small: %zu\n", size);
> +		pr_err("ATPX buffer is too small: %zu\n", size);
>  		err = -EINVAL;
>  		goto out;
>  	}
> @@ -278,8 +283,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
>  	memcpy(&output, info->buffer.pointer, size);
>  
>  	/* TODO: check version? */
> -	printk("ATPX version %u, functions 0x%08x\n",
> -	       output.version, output.function_bits);
> +	pr_info("ATPX version %u, functions 0x%08x\n",
> +		output.version, output.function_bits);

Probably pr_notice().

>  
>  	amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
>  

-- 
Regards,
Luben

