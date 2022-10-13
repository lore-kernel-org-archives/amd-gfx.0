Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B24C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 21:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3545010E96C;
	Thu, 13 Oct 2022 21:35:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A633B10E3BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 21:35:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdDi3h/6qq1ovx92WA4vAdlXjbUqMxj3WAUoKQCCD8aA1C2JcG4rVYOs8S5M6RfTHfemb9gUswwnh/vKr55BIBe61qCeM1GwmOL1BvnEAdJAMjJ9ZqIU75nnX8mg8vfRd9JXjtBsc8M/nJgkrLMd5w2lLLBULmMFlDgwKbhQqCHbtJHgjHIM4Mm6fC2dUfncE7VOuR4qF9Hykn1QQs49qdrmHzF0rqDWZVwoPtEdMIF4qKX19OjfvAXdwc++BVRvZzSMS4SsIkCmpSbuHc6ReZK7EBGE5WsALOXqa/JzQhUDhA471PXmK2oODp4Tacs3ZJyMNDSLs7Zeowm880UYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dULI3P9vPJ6dvc4j0Tl/ZZGGXl+Su+cmkh0PmbY8cGc=;
 b=Mxqe23qTNBrzeubbQqUYG5Gg4oo469KmOyyGXuiHtI+1ktg+BStRuvRGbKvX8zpRBiWFrR7g7CcJGE96c6iGDAL4TG0EMWlLRX9DtSBX/dcM7VvEuN7QjiHpuJ2aCDmQvYvm1JK6hN0xh49mBc4lTRXzVRwxM35o1TwioSoSBvUq4l5rrdiaf9An9qOoP4G6p38XmGAh16WOQzWaoUbRZ764fL2EDWpAPZLmfzyBnV4Ih9hE4y3f9BiCAo2iwNgciBRIUMCKL08oGvEmdE5BXlC0Wmvo2E7zSQd6QdTy/VwODtiKLd1VwcSR2MqErOsncVCmrM+eJP5+YN8++8BCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dULI3P9vPJ6dvc4j0Tl/ZZGGXl+Su+cmkh0PmbY8cGc=;
 b=bcezXsqNp/c95SD7kSyOXDbtjL8LEaAc/UhyktWXOtjbjwwuI7WFnbBIuQVExcveTlNz6sclwft/tmF+e0BRNK6P04WCJ75699l79nAAbYXoO269S/43KM3N9Vy8RiJXxmOwHEv4CwQBjeGwXjgXdSX06qY8oBqPN3Ok9x4A5NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 21:35:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Thu, 13 Oct 2022
 21:35:32 +0000
Message-ID: <51c3c0a8-6729-3841-d2a2-f3002ac6d515@amd.com>
Date: Thu, 13 Oct 2022 16:35:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [1/2] drm/amd/pm: update SMU IP v13.0.4 driver interface version
Content-Language: en-US
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221013054619.3979464-1-tim.huang@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221013054619.3979464-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0253.namprd03.prod.outlook.com
 (2603:10b6:610:e5::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 74da2d2d-e742-4adb-203a-08daad62daf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+9b4XOOsXQDqgHGYKxef+dPiYMqoQsn2Mocag5UOiiEzwr9XzZ6osVKdIuwCKCjqtyMg3yKMbxTqEdiIoY+FPmZ0GDKMdUZpRdEn37bC3LlRb7QbBpt6AswdJ4Qfsxe8ZAoVsqyXNLcZ6N4dKheWAd9y2KoXLKwso6ZyC5fWAMFxD80ewxP1/8tmV0u0GPLVEHDU/E6INLs5ehWHEcXz2nwAqKfY7jAMNeuGTj/W7ZiXVe2HQhbm2UYyjzsWZnViPKt+ecs9L3IcNiG89qIl1Gp8gOk9hF9mevXj67UqmX/8VUG8WvrSanhfXYn4iFZL/tAkWhGDVUuDrNc3l7m9f5WHvFgsjzlrPlMg/+UkgRtAWgpyILbVMGKz13FgV8RdobVDOUtLXwCBwobyggkqE8O7UkvNehOx6tY4E8iZYe//DhL86+TNPE15rfEXGcBJht7fXKNJ5NweCdiWz0c+QBerLd9bAqq5faLXLLyrfGZEJLQOnOqzgTIT/S96i2LE30EH8p9aAtSnb5sF/TzvPXhSRgkeHImLrIrmbKIXq4bYmeUPuRGzsf0NuecbASRNwtYJPnlBzP1cQcE/wN2W+DLB13cHSuzBp+OnWF0UVMNOpTaxSFzj7zQRiAQlqaDIhcnL8xtxhiIbTH7KDbjLDcX5I7DQOfj3eQK4Z4KVcSJDBWqlV8NSNk93CmorKFB0HADQ3voNLc0pO6GqSCp4XWPWPWySa/308zrN79uhvZQn3talzIunMLb2lHH7OTr0CMUiZLoKW4siLLZs5q5uJ2/qix5K1qD1OoN+vfSWAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(186003)(31696002)(5660300002)(86362001)(6512007)(83380400001)(66476007)(26005)(66946007)(66556008)(8676002)(2616005)(8936002)(4326008)(38100700002)(6666004)(41300700001)(15650500001)(6486002)(53546011)(6506007)(2906002)(478600001)(31686004)(316002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdOVW5oWlgwWUZDUDVyUXVhTXpqdGtKK0xKNkdGczFvenZuekpOY1VOdmJy?=
 =?utf-8?B?Y0w5bnFJSStnZW1tZkJLQjhPYmduTmVzRlhCQTdaTTVOVzVsT01SOHZIdmtu?=
 =?utf-8?B?N0kybGttTmxmbi9HU09URnJNTzFxb01QaUhSMG1FazdqUTRUSm0vcGt1T2Fn?=
 =?utf-8?B?cjN6LytUbThSaytFM0xNUjJHOXJidmluakNaQXI4alg5UGpjOXo2VFVQa3lr?=
 =?utf-8?B?Z0IyVVN4WVhXL2l2RjlKd3RnNFdSYTRyeXNqQVBrNDcwWnc1L3M3VnRqRlRZ?=
 =?utf-8?B?Nm9kU25VUGhydFRDaTRyUU9YaGc5TUFhcFYyYk5JSDV2T2VxMUQ1UllEbldv?=
 =?utf-8?B?UEZuRGorc1dvblM3VGl0Yi9MVDJrNXdmVEszRzhvSFVWVEh1elhjT0F4eWhF?=
 =?utf-8?B?R2Y3WUZlUm5HcGVhRVUxYmR3ck9QRjBOeUVPcWQ3aFA2d290K1g0RFRGTDdB?=
 =?utf-8?B?REdQSVArWEp5NHc5RWpwWnNvSjk5aEpiZW5mMkdMYWpEOTMxdGRrM1BRRlI0?=
 =?utf-8?B?U25reXRqYTg0N0RrUEpIMWRzRGpLRDgxeStwOHYvcWdqOE9UVFZEQUpyWGhm?=
 =?utf-8?B?ZjFUOW1NYmM2TVg3Sk94R0FiN25tcDFEajlVcFhaYzJNME9MNjZpbXZaZll0?=
 =?utf-8?B?Skt2aUhZanZYZ3dhZVlUWmU2UGNJRWRPMy9kTUIxTEtTeGh4cVliY2p0RVMr?=
 =?utf-8?B?TEoyODNzZ0luZGJOb0JuME1rZGg5eUxaNHN1Tys3WWt4NmQybEdJM1ZwY0pI?=
 =?utf-8?B?YkxQdHFOOHJ1cC9ZcTVWZHlTMkIzSGczQW8yTTg0bmllNlJzeUphNkJxcG5w?=
 =?utf-8?B?ZUppalRURkh6SE9OemZtbHdkVU1WdTRPYllvUUsxQS9NemhuZFpyTHRhM2gx?=
 =?utf-8?B?YWpjQVlMZFdWS29JbzdLTmpUTnllTFFHbmRSVnArblcrbE9iMXNuKzFWRXRD?=
 =?utf-8?B?YWFoUnpBVzFUYVRDaW14elpMYlNqZVlEYnR4b0M0UEdBWDd0RnFzSUJSUzlR?=
 =?utf-8?B?YVBBbDZRWHYvM0xRdzlMemU4MlNpanMxQjVKbXl5azhvVmFqdDNKcURJMktS?=
 =?utf-8?B?TFkvRzB0MHJ6aTFzUER3RmhxVFRwV0oyaGJkWDA2U1ljeFRVNXdNTFptbVZs?=
 =?utf-8?B?ZjVEZy9JQ1VMTmdjcVd3ZTVJeW9wRXM3NkppYm5vdkNlNU85N3c0Y0FaWXVs?=
 =?utf-8?B?OERZQXZzMjFoVGs0c1dFUUh5c2d5Vi8vYXRyNjE1eldkS0puLzJ2L1N2WFpJ?=
 =?utf-8?B?WTh3Vk5kaUVBc2lIQXBCcDFtNWJ2Yms2YW1iOTdsOWJHVGs4REtGV1RVVDVh?=
 =?utf-8?B?MXVZUlkxNUFyT0hlMThTVUJNbSsyYjZBemJUY1A2N1o2d2RWek5ocnpRN21J?=
 =?utf-8?B?ZC9EZE9yS0dqc0k5eU93Q0lYb0RCa1ExSmYrRVcxTXM2dC9YanFMMUNRdEll?=
 =?utf-8?B?MTZVdnhlcll6djlmNEttM1NOTnBVbEhxN1AxQWo1bi9uSkQ5V2xxc0xvdWJQ?=
 =?utf-8?B?WTU4bFZkd0lCSG9HUlBoOFhZcDAzc2toVlJTbUVuUllKUEZEeFhxWDNhbnNY?=
 =?utf-8?B?R1kzYmNHQUxRYzJteDNETm5kTUZZUEF5MXJBMjBFOHNaTmE0a0Rab09mQzlX?=
 =?utf-8?B?Tm5Eb2c2R2RqQjJlL1N2V0gwRU1DcGF6bGRLUjIzQ0MxSm5OSmIxSiszQytU?=
 =?utf-8?B?UCtzWHZXZDZHTG1JSEZiRkVGdStobE9DWExNVGhqdWZNUjBSV3d4UmRlaFlY?=
 =?utf-8?B?K0FHODhyZXV5Z3NQS3NQbFpSU2tLM05zTHZRbkJUZlJtZ3lkSHord2VyWUNV?=
 =?utf-8?B?OHpncU5NZjhYVmRRUUZjTTFLRDVNUVFEc0g5dWVldTE1TUM1cEJtMmJGN2o4?=
 =?utf-8?B?OGNXclFyWFBIN0ZXL0tNYWkxSWpZYlAzUGVJSUFlemloV2tFWVE5V1VjR3Q5?=
 =?utf-8?B?Q2Iyajl4QVYxQ2IxWHhteVhHMm9Kb2JaVDlVTm9QTVJaa29ETzdOTVBzNzNn?=
 =?utf-8?B?Z1hGdm1nNWVTblJzeFVPM0RYQkNtbGpOSUtmaFFVY2lZV1h2QWJlN1ZEbVhQ?=
 =?utf-8?B?SmpMWnFoUDR4N05FNGthMjcxMC9UVkVzdzJDQURqMWFEUXRtQ01xTlNmNGYz?=
 =?utf-8?Q?nnEHiuh5dCsR0EFmCsfcFukZ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74da2d2d-e742-4adb-203a-08daad62daf7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 21:35:31.9781 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qGCMhsCtqkSKKfyHPeHCVF1ziu7J7ip5FZvOk7u1vGRlN9usDQya5UP1Rhw1glxod3lZxJY6Am55IcHtZax8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Richard Gong <richard.gong@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/13/2022 00:46, Tim Huang wrote:
> Update the SMU driver interface version to V7.
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>   .../swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
> index ae2d337158f3..f77401709d83 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
> @@ -27,7 +27,7 @@
>   // *** IMPORTANT ***
>   // SMU TEAM: Always increment the interface version if
>   // any structure is changed in this file
> -#define PMFW_DRIVER_IF_VERSION 5
> +#define PMFW_DRIVER_IF_VERSION 7
>   
>   typedef struct {
>     int32_t value;
> @@ -163,8 +163,8 @@ typedef struct {
>     uint16_t DclkFrequency;               //[MHz]
>     uint16_t MemclkFrequency;             //[MHz]
>     uint16_t spare;                       //[centi]
> -  uint16_t UvdActivity;                 //[centi]
>     uint16_t GfxActivity;                 //[centi]
> +  uint16_t UvdActivity;                 //[centi]

This is unfortunate, it means that these two flipped based on PMFW 
driver interface version!

With 13.0.4 in 6.0, this should probably come back.

Cc: stable@vger.kernel.org #6.0
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

>   
>     uint16_t Voltage[2];                  //[mV] indices: VDDCR_VDD, VDDCR_SOC
>     uint16_t Current[2];                  //[mA] indices: VDDCR_VDD, VDDCR_SOC
> @@ -199,6 +199,19 @@ typedef struct {
>     uint16_t DeviceState;
>     uint16_t CurTemp;                     //[centi-Celsius]
>     uint16_t spare2;
> +
> +  uint16_t AverageGfxclkFrequency;
> +  uint16_t AverageFclkFrequency;
> +  uint16_t AverageGfxActivity;
> +  uint16_t AverageSocclkFrequency;
> +  uint16_t AverageVclkFrequency;
> +  uint16_t AverageVcnActivity;
> +  uint16_t AverageDRAMReads;          //Filtered DF Bandwidth::DRAM Reads
> +  uint16_t AverageDRAMWrites;         //Filtered DF Bandwidth::DRAM Writes
> +  uint16_t AverageSocketPower;        //Filtered value of CurrentSocketPower
> +  uint16_t AverageCorePower;          //Filtered of [sum of CorePower[8]])
> +  uint16_t AverageCoreC0Residency[8]; //Filtered of [average C0 residency %  per core]
> +  uint32_t MetricsCounter;            //Counts the # of metrics table parameter reads per update to the metrics table, i.e. if the metrics table update happens every 1 second, this value could be up to 1000 if the smu collected metrics data every cycle, or as low as 0 if the smu was asleep the whole time. Reset to 0 after writing.
>   } SmuMetrics_t;
>   
>   typedef struct {

