Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53935C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Apr 2022 04:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D51CC10F09D;
	Wed, 20 Apr 2022 04:10:10 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B45B10E124
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Apr 2022 04:10:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kg3RF4oVZWm86nrsmmmvQl7gXok7PaNfakS/CBYD0bByqfBbFv6kyh5RuRQHmcD6xD3FZAP9OfPpUTRtAa1ZYVWb4aqWoC5r/wtokPbTKo82J10hKckL5Ir2hfsXUiuvo02uympzXg6t7pGuRVlPdCZx85NL0EU3ihF/4b/ABS2rc3Ih5a4OUH0oUawQ+2jVIutrV31yNheRHYGG//Qg6ZSQ402PP+i4O7C49UNDONRFqFld4DsItcTYuN7JyI2mvdVZlThpyXwPnOKHFfl/wPoz18Y6E6dcl2esGPoYoyJWY4z80g4UapCLiMMNChSDDoFmxb3mw3GZk+ajGFp3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygtZvdhWeJqmZkqw2JKlAE6zvO4rMskhaB9VHkKKzjs=;
 b=fX/AXoyip0ubBuB7UEGgkalR368lBe2eWUXETPDS4xpTzvnZcFaUEMiuMuxYXjLybF9xVJ34tOY8cdzwa6kNTKvFhkg4GoBOSVFodTbPlltQpClT5Lc9y+qAv3ftHbbP91DDFhW3EyExiW6B7fV7e6VnSfcGbOmpLuTjYjRYfCCBquaylGgDMqaxuvyuSXi2Q5ylC7KNVRECl7kbEnifDCq18l3KJQjyjyX4KGLrgY2+H/+pE1fPxuezNA5yg1QDEDxLCjKgKoJnNSfVrzM1ADXnF8xN5Z1poxD9HDo0tXRHum4Br1Y+0eI2Y7Tivi5w+7BUXtNWN8ol/fArYQkj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygtZvdhWeJqmZkqw2JKlAE6zvO4rMskhaB9VHkKKzjs=;
 b=GYiDUFgzlTr/TKnTGNh6txjBM70D/IHX2j10emHJTPykpv8XeuLuoOCuMgKrH5GUUvFRogFCiulvXVENxAtHSiBFPIh5Tx7RY5S3CD4+X/RAMkXxX5NsPJdXqkAZUha9huskOQnFJsJvHSEty/oPHsgAf0hYPu2COopPTuZsAd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB5535.namprd12.prod.outlook.com (2603:10b6:5:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 04:10:06 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::88f5:b843:e848:fcf%3]) with mapi id 15.20.5186.013; Wed, 20 Apr 2022
 04:10:06 +0000
Message-ID: <4d7f8be2-dffb-1fb1-1feb-576e0ebb6f4f@amd.com>
Date: Wed, 20 Apr 2022 09:39:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] drm/amdgpu: implement RAS interrupt handler for
 poison creation
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, Mohammadzafar.Ziya@amd.com,
 YiPeng.Chai@amd.com
References: <20220420035317.4008-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220420035317.4008-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0078.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c735eb6a-e6d4-44d3-6bf5-08da2283a694
X-MS-TrafficTypeDiagnostic: DM6PR12MB5535:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55354EB53E3B982B782C1D2097F59@DM6PR12MB5535.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNnDt+KPi69QRuaRRkzmDJZOceZa4vwJR+bsFgfdBS5m83duInKuUqVi8aXbiZeIUJAeR4F2cwypqBmsOM9mYw71MqfMKotwIfv8ZUhh4qJcvbRL95WoTVaCKCCST3RsUhM+f7Z5+tzzHjUJaJcSCH2OUE+zeSN5NTk6iw9AnbItr2I2DxXAlTcU0oRonzCXoxC5vBu1yH3dR1t1qOPUPQ0E1wQ3dUh6nOoaxDNESZHkJWvJdL7YM6Vcp4qHpchSekSdX3mw1dE4PquMHLwLwEPOyJgNxlrnUI6RxomDLGWJBqvAf4UtREhM6kylFyZRHVKDfxjTZ8SPQ3ntkCOT5BZ9nDadMFPdM+MjkHc1NAur81jZcHLG4zEorJVi8phnIROiQgQYbVdVz1YdhE0NxG8gIbrYsDH2vipeta4Tm3hY7gsJx1b8RUh/vrgfY6s8rxcQndt1WgFsq/7r1iwnXM/jeoJjJ8vTDFbdEEShj5DzL3ZRT5UI2mCjqWVFcNeihni57/MqwG2Y8dh2zfivwWE6GHvi5LF44ycWUlA2RZHRK5mgOcFHh/GlxeMpuja12bn0ZbdZjZdY37WudLCi9aMDO85hMDV8Av6B+bxgWvuVRBReOgy3AGRXCizK7O8N4xypGZtI3CKhAIjD7KyUgKiS3UTFnaGgbwyjaNTLTyrJ4RTFmmST7e/3/zpMwBrM7xH/6OeHVdeNktq69kyJnNzdQ4NP2IbIiEily0R7HYvFzp1ZPSaBHzp0RKTXlwoE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(6486002)(26005)(186003)(6512007)(2616005)(508600001)(86362001)(6666004)(83380400001)(2906002)(53546011)(6506007)(31696002)(5660300002)(31686004)(316002)(36756003)(66556008)(66946007)(66476007)(8676002)(38100700002)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHhqR2NyTGtRRWhIa2dURm9ERk8ya2JWR2d1TFhHcVp0R3ZhV0lUMHgyZzdS?=
 =?utf-8?B?R2ZveFdSTk83cTczQXQ1OTgwc0RWRkhWQ3BYWER3akVCTkhaWUdjSFJKYWIw?=
 =?utf-8?B?TUJOdUZaZkhwSEhmSUs2SVdpcjU5ZUZQM2hnOGJIMEJEL1NTclg1STRKSk0w?=
 =?utf-8?B?SGt2K0tvalJVNTJKbUZCQmF4OTVxQTFZeWhBU0t4RjQvOGFFd1g3VTA0djBm?=
 =?utf-8?B?eExpdGExQmVLcFFjRTRXQmpYM1FUQ1BvMW5OMEdNUXBKWmRnOThGd3daOCt3?=
 =?utf-8?B?SGh1b2JxdDI0Z29FWUhRYmJmd1ZDRTk2d3B0WUpsV3g5WDk2V3IreGhkTHhW?=
 =?utf-8?B?eXFRYUtsS1J0Y3hhRFR3dnhWZ0kwc1NoNHJkbzhFYjEzcHlZUnFpcVVhTXAr?=
 =?utf-8?B?RHJGR1BNd1gzaGRPWUxsMWdyNVQ4cEIwWm51dEtQMGwycU50YU9JcFRsdlI0?=
 =?utf-8?B?R283RkNYK0ZYL1ZTc1VKZ3FNZXh4b0locVFqVDhLRjVSUUZEL2JBSHNUcXJy?=
 =?utf-8?B?MDVtb2w0VG9XRnBHYS9RZm1uSmJNak5PVklnRUVpeWpzbXF6NGdueDlRVURN?=
 =?utf-8?B?NCtSYThjRldoVkRBcUFDemtxeFNsOHJKcFd2elJTRDdtekl0UUJHcEhaUzFF?=
 =?utf-8?B?VWdMMzdQVytPY01FZnhndlRvTWJudnoxYi9wVDcxOUgrSHlPL2tyTFFBcElk?=
 =?utf-8?B?SVVKeFFpYTNkeHlBK1lYd0JEY0dEVVUvUTAraVBYc2syMzZQbmczQ2xwODAx?=
 =?utf-8?B?TzB3VnEySFlDL212Z013SUdLSjRLekFWTk1EK0R1Q0lWbU1hNmZ5bjBLS1ho?=
 =?utf-8?B?UlN0aXRoQTJiTFd2c0E5YTFucEZhTGVvQ0dON0F0R2FDNjg1K2xQS3hzRzFC?=
 =?utf-8?B?alcwNXFQUTQxdzhEcWJVTGhQWlRDVlptTTg2S21zTDlma0t1eDU5bDVsZW1V?=
 =?utf-8?B?bUYzR1hCOUFrUFhVRzRhQ0tUS0NWOWVGcjFYelMzdEdwcWpucVFPMCtKU1dv?=
 =?utf-8?B?d1hURXh3OHBZcm9wN1NGVjhNT3dPZW1OMjBTem8zbzQ5Y2RXRENXMDhCVW50?=
 =?utf-8?B?NkNzdnlxTDVySy81MnZXaWVUeWxmeDNzRjhTRUI3UVMzcXZpU09iTjBvNVkx?=
 =?utf-8?B?L1dhSWRNNUNRLzMxam5RaDFEdVNvVk1HajNXZC9aVkVkd3ZuRWJHRzZXUklh?=
 =?utf-8?B?NWVjbGZrVW9uZXBld0pnTzlkL1FjYURYbDhpY2k4VkQwV0ZxN1lObDlqWUtj?=
 =?utf-8?B?cDhmbnRqb2FQMm92Vi9UeXNFRGhMcHkrWGRKdlUwSFYwM1BNanZhMlRRYUdU?=
 =?utf-8?B?VUFQZEpyYzZjaFYxa0NnV3piUXRDQWh3Yy9TODZMT3FVMmVLQ0NWK1lSR1pi?=
 =?utf-8?B?clVrMGN1M1orWG8yQTVOZlpuOVNaY3ZLdStSazFmK0ZpVG50RUc5aHNiMmNH?=
 =?utf-8?B?bEdWVGpxMzEvQVlFYmo2QkV5VFljUmJmWDlZMFhRTFp3R0tZS1N1Y01wRWhr?=
 =?utf-8?B?VG1KZExjOThSNGErbmNORGNKQjhaTmtKUzNnZEM3SWsyejh2UldFV2hTYXhI?=
 =?utf-8?B?SnBZNVZMd2wrL3ZsczBtRnNTUG5OdGZPTnVMdzRTR29TVGYrOUFoVXB5RDM3?=
 =?utf-8?B?M3o5ZXJTR0lqRTNEVDRsK2lkSnNBQTVwVjJld2pLU21Sb0JVUkp4TEdJM2Vv?=
 =?utf-8?B?NkRRMHJxK1RoTHcwc0Jkcy83VFFXOGlmOEtMMmpWV2hzK2FSTitMVHM4WEZF?=
 =?utf-8?B?clVBMTdUZ3pUeG9VQVNOTC80SHF6OXdNSVRKUE1NSytxSVpuMG1mNXVvejFY?=
 =?utf-8?B?QmpoN2RyK3Y4anhkVnZWclFSa3U5T2ZMM1Qwdno0U1JMUzZseFBqbFBVVWlT?=
 =?utf-8?B?QUFPWHl5TTQrZ1BqRXY2MUFZV2xWT2hxZ09meFJCb0gzUWs4bGJ0b3lmNW1X?=
 =?utf-8?B?ZHJieWwvQ0dLNzl6RUk0aVQrUU5HQWE4eE82dnhjN2I2dUZFVnE5b3MxQVBt?=
 =?utf-8?B?MWpuNEk0aS9ON0JpWHUxdnlXNG9aYlJndkVQaHF3ZE5qaGFyMHhKYlF0SEV5?=
 =?utf-8?B?RWt3UHYwWVRuaC9CSHN3OFNYTFh3S25oSE9TSXBUSld4VFd6UDBTRzVXSUZI?=
 =?utf-8?B?VUI3Q2Q3WTd3QjJTZURWUTVCQlRsUEoyNDZuT2VRdFR2azN4NTRpdmNQbHVT?=
 =?utf-8?B?a091b2thdWI5NStRaU1QZUdHc01mOU05Z0tnR0V3M2ZqeThSMW05NG94eFFm?=
 =?utf-8?B?RkNPa1BRd2F5WkRCUlJSK2tUYUFzMVVMcTg5M3FnOW02QThNQTVWU0ZrSUJQ?=
 =?utf-8?B?UnpzWWJ5b0JlZ0pWL0Fsc1V3NFdrdFB5bDYyOVRHNm5nSlhQc1NCQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c735eb6a-e6d4-44d3-6bf5-08da2283a694
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:10:06.0432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZR3H/rmUZAeHlhtMwt9ywaRWzR3uRqyRVDTt23ZGj1fkZaMnAaVwUo2lZMpavyP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5535
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



On 4/20/2022 9:23 AM, Tao Zhou wrote:
> Prepare for the implementation of poison consumption handler.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 62 ++++++++++++++-----------
>   1 file changed, 35 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 4bbed76b79c8..2d066cff70ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1515,12 +1515,44 @@ static int amdgpu_ras_fs_fini(struct amdgpu_device *adev)
>   /* ras fs end */
>   
>   /* ih begin */
> +static void ras_interrupt_poison_creation_handler(struct ras_manager *obj,
> +				struct amdgpu_iv_entry *entry)
> +{
> +	struct ras_ih_data *data = &obj->ih_data;
> +	struct ras_err_data err_data = {0, 0, 0, NULL};
> +	int ret;
> +
> +	if (!data->cb)
> +		return;
> +
> +	if (amdgpu_ras_is_poison_mode_supported(obj->adev) &&
> +	    obj->head.block == AMDGPU_RAS_BLOCK__UMC)
> +		dev_info(obj->adev->dev,
> +			"Poison is created, no user action is needed.\n");
> +	else {

It is confusing to handle RAS interrupts under poison_creation_handler 
in non-poison mode.

Thanks,
Lijo

> +		/* Let IP handle its data, maybe we need get the output
> +		 * from the callback to update the error type/count, etc
> +		 */
> +		ret = data->cb(obj->adev, &err_data, entry);
> +		/* ue will trigger an interrupt, and in that case
> +		 * we need do a reset to recovery the whole system.
> +		 * But leave IP do that recovery, here we just dispatch
> +		 * the error.
> +		 */
> +		if (ret == AMDGPU_RAS_SUCCESS) {
> +			/* these counts could be left as 0 if
> +			 * some blocks do not count error number
> +			 */
> +			obj->err_data.ue_count += err_data.ue_count;
> +			obj->err_data.ce_count += err_data.ce_count;
> +		}
> +	}
> +}
> +
>   static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
>   {
>   	struct ras_ih_data *data = &obj->ih_data;
>   	struct amdgpu_iv_entry entry;
> -	int ret;
> -	struct ras_err_data err_data = {0, 0, 0, NULL};
>   
>   	while (data->rptr != data->wptr) {
>   		rmb();
> @@ -1531,31 +1563,7 @@ static void amdgpu_ras_interrupt_handler(struct ras_manager *obj)
>   		data->rptr = (data->aligned_element_size +
>   				data->rptr) % data->ring_size;
>   
> -		if (data->cb) {
> -			if (amdgpu_ras_is_poison_mode_supported(obj->adev) &&
> -			    obj->head.block == AMDGPU_RAS_BLOCK__UMC)
> -				dev_info(obj->adev->dev,
> -						"Poison is created, no user action is needed.\n");
> -			else {
> -				/* Let IP handle its data, maybe we need get the output
> -				 * from the callback to udpate the error type/count, etc
> -				 */
> -				memset(&err_data, 0, sizeof(err_data));
> -				ret = data->cb(obj->adev, &err_data, &entry);
> -				/* ue will trigger an interrupt, and in that case
> -				 * we need do a reset to recovery the whole system.
> -				 * But leave IP do that recovery, here we just dispatch
> -				 * the error.
> -				 */
> -				if (ret == AMDGPU_RAS_SUCCESS) {
> -					/* these counts could be left as 0 if
> -					 * some blocks do not count error number
> -					 */
> -					obj->err_data.ue_count += err_data.ue_count;
> -					obj->err_data.ce_count += err_data.ce_count;
> -				}
> -			}
> -		}
> +		ras_interrupt_poison_creation_handler(obj, &entry);
>   	}
>   }
>   
> 
