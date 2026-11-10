Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67550606A325
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 01:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L9bDBjjW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB9C10E320;
	Tue, 10 Nov 2026 01:55:00 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660A010E320
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 01:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdJNY6AqZRb1k/AWWqQmoxynkeoO8sFXANGsF6zqOTMgzJ4i/KTQGFu+ClJK00BTNn3rC+atd2CkRPqXITmOkuOGm0eJqf7+yMrL+IM1gCp1RihFyBc3drgsFxKOBxhJfnu6ibRbkJgwR38Fp5MssZrh+gkzjB9DeQmBrxIBf1HUVP8k4QYZou4rDZ3InRtuEnohvcxZs/OiZSb4vwbRATbkPAL5ykXqu09gekVqTCowqRKAo66GuWbQ30B7BP/Njy0TKk0QdU1s3+yvF3Fwi9jA+yx87btXWAiK1GL89Ed/zNsI84dfWZDz2bYgizkOKyMQrY1pSIaioVIJhHBEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VK685nbalzcrT7wWP+AcpkwF97GbuWeikSQmm3V9bUU=;
 b=CAndSo55yqEPNyx6QCldTE4N9Lbh2dbvjj2bpWrg5/hLaLKvcYOPbcXG8YE7nhipHS29rOFiBbNUQ67s4O5D8wvyqeVSCTux6GqsIoyqlhMDUFvixpub5nd18Ng5LzEvBrlMXzuw51/Z+L3nM9tgY0rqM830nUYVCOgBC+4Qv7XLgFH1PcdErCfA6fwFnIyumHPjoYIKIju8yYQyXOzP0TpBS7pucCoY8ATE5KHhKcCAElBc2Z3pzUzqzwin8Dy1g/W8DMFpFmrmpyxcpxIZnCI3yu+RwWYxPTrkGcD01a0BQ4SxH6v+WemqYq/71/NitftY9a378SKeaJouKPKYOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VK685nbalzcrT7wWP+AcpkwF97GbuWeikSQmm3V9bUU=;
 b=L9bDBjjWD18SEdRO0gwNezfZY6BKDGia0GqLnzMNe3yGLxe/34Z9Fb30pAxqaD0oAhN6N0FCQGRqwG96Qik0QqToa7vCr1rM6ceiCyoRj4rgKAc+9t+UPgy1qqBiKpcEAdRLpa7CkpMgsIb8GL0rl+pCEM/KOj7rr0TFATUX2+Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 01:54:38 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 01:54:38 +0000
Message-ID: <e5799308-be29-4152-869b-33a3bed89c8a@amd.com>
Date: Tue, 10 Nov 2026 09:54:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 2/3] drm/amd/display: Drop the unused min argument of
 convert_custom_brightness()
To: Hugo Sales <hugo@hsal.es>, alexander.deucher@amd.com,
 siqueira@igalia.com, harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com
References: <20261103-amdgpu-aux-curve-min-v1-0-62119efdcc6d@hsal.es>
 <20261103-amdgpu-aux-curve-min-v1-2-62119efdcc6d@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261103-amdgpu-aux-curve-min-v1-2-62119efdcc6d@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0007.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::12) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7a9582-3823-4f84-43e5-08df3ecd93d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|3023799007|10067099003|11063799006|261102123227099003|261022075727099003|56012099006|261021121427099003|261021123027099003|4143699003|261009223027099003;
X-Microsoft-Antispam-Message-Info: hnui/kV+jr9aIruKlBqNeBnq4gsqc4wznsAzn62d23NXEFNOmCDkgGP2mkS41BKXB7w0R+xCznq60gUZ4x63XUARI9RyTgMhWwV492ySxIm9yu2u60Ghe+X4EqOgCKJm3WE51MorxdoDwtYqPCHWy+UfTCluwT4yrJ6mTcQAW2ogfD4Sluc5Fg+VPQmk/o6gytiqNptPFkL+e0r6ES14TwYopWKSxU8tUgavwLaYgMjp0HGFwX4EbKlIMWD2jm9w1IwzFL5EFEVK9vH/eh1qJwY947fkQBTsrdyQEtVT5NDkve8u98Dzj658KMZjn/aeWGjsht5RRHlmA+nyVwkHYTj/Ku/XuGlxW2rzD7v+S4+2bd9BweAP9JEzReuiDk/kFHEBDtV6Y3Yd2FQf32p4g2H6ju1H2W1syzkStXCY8PyQmjbrp9L/J9p0vJBbSHQKg0pJAJ4yROuXodOUIKFMdax//YI8E175d7oAY+U7c8+XYKMBYqM1vMEw/Wy/zVtC8vTewesB9v8gB5gLRh1cWyV1p22r8BgCwBhWKLKai1nOBnvUgSZ0bhxqlXsj/Z0Xj5vzgq+uLavxn2KwPs/Ht3D5hPPQDreuzpekuMZniAU6CDOVgsSD0aaiK5jsgfQylw4HES1fKEyRAXJUormu4Kb7Jfg9IYsDi7cQ/PhDcgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(261102123227099003)(261022075727099003)(56012099006)(261021121427099003)(261021123027099003)(4143699003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkZQRGY0Q3ZoN2NJWGJCTytRY2FkNXp3Q0VzZjhXS2tJKy8xeldwYVl2cWNF?=
 =?utf-8?B?SHNhclZmNnF4eFZ2bEI2VjhGZWIwQUZGdC9BL2VLZE1pZEp4MmRnSUFSQjJ6?=
 =?utf-8?B?ai9qdE0wR0JpeTJRMk92Ymw1b1gyTnpIM1ViOWR0QmdWMWdLZ21Ldkc5bjBz?=
 =?utf-8?B?OFBKbW9UWDR2ZXBMdkZiazdmV1E3U3BvTHVCd0NLUEpxcW9FVzdOQzhCT2gr?=
 =?utf-8?B?VWlJUW9CRjZ0UWtMcGhva0xwUTlOaXlKTmRVN2d4V0czVjRHam1NQWtGM3Rl?=
 =?utf-8?B?VXhES2cxQzVEa2RTenZpYkFNeU5XY2Y4Q2thNTFVSlJwcndmVzZ6VWR1WTFC?=
 =?utf-8?B?eTluR3VSWmVuN21mYngyZWRKcDdSWEZNakhNdHNnbm1UeVVWeXNWWmtQNXR4?=
 =?utf-8?B?V1pHTno3ak0xY0Rpd0FlMmFCYk1IQ0swd1VYMGFHcGpvZHlJRUpqQXZsZ2FE?=
 =?utf-8?B?V0RaY0tXK3YwZ2NwaXluNDFWT0RibDVuYWZ1SnlWSWJSWFIyVnZCMWxHdm9Q?=
 =?utf-8?B?Uk1Bc1orL2ZwOHFuT3NzdzBlaTB0YXE1SkVUNU9KTlM0elZVM09uSTFCSnpN?=
 =?utf-8?B?azVPU242ekVoQ1BpRFpxelNaR1pidjk0aGxqWFJDQUw3VitmVWI4OVJtZHFK?=
 =?utf-8?B?K0VVd0VXM1AyQjdSaTZmUUoxTGNSYldnZlVoUVZTcm9ZY3NYWFVRa09lZlJK?=
 =?utf-8?B?QUI0TXFMVjhYSDk3dUVKK3ZydFZlMk1mR3JJTFkvZnVVbFBCMktYeXJHWVdw?=
 =?utf-8?B?bUFueUE3dFpiS2lUd0NSNi9YeFVtUXF6Vk9HWTA1cnBpVkFSSTRtVDhXMUk2?=
 =?utf-8?B?TURrbUNJWTdYcmJ3Ni82OE1IazhmOHhrNUdnVFI0V3dpK2pPQ2M5MGJOQ2pL?=
 =?utf-8?B?RGZZaVZvTktwU1NnWTJ1a3EvZTIwUm1YSlBtWG9ML1h0SVVXS05KVzVKOU9x?=
 =?utf-8?B?bFFEVTFnNmRUVlZxcFNJM0xORFFSUVRadU53S3R2UncycHJueUF1dTJFbStL?=
 =?utf-8?B?T2FTaTNlaHhFS0QyYk5ySHoycWUvMUh3My9ua3l1cWt5bXVWTStFRlRYZ3Rn?=
 =?utf-8?B?VzRBQmlFOWFmLzJFaDZQbXR0bGRncjRWRUZGa0RYeXdpVWk5SXBPazZISmNh?=
 =?utf-8?B?TEJ4aVdGOVlRaUIzaC85ZWtNSDNxWUI0Ymw4R2J1aGlvZGNWaitoTG1LKzNQ?=
 =?utf-8?B?WnVSQVppUW96bm1IKzZJREtsa1VWK2t4UHJad0E2RysvU1ZocE1DK3cwTkF1?=
 =?utf-8?B?SWV2SEpVQVMrcGwyWUI2RGZMQi9IZlB4WnUvQmR5bjlkbklSZEpSRXVKK3hJ?=
 =?utf-8?B?YlgyaWorbkhDUHkvSnBCdEVKekhWSFZ5YjR0dTFHUjNPTm1Yc2NCbHRCYVRR?=
 =?utf-8?B?RElTeFBzbG5PS3lBM3hSZGVnNy9GSXpvNVhSQkVnTVQ5NmxpRWxaamxTNjVI?=
 =?utf-8?B?bHQ1alcwM1A3VkJUYzF1UUR1bVROa1cxWnpXaDlScE1adDY1bFczeHlFMzdP?=
 =?utf-8?B?YTh2VmlITGluMklUaEZYWWUydkJ2ZURLYjFyZFVTUjh2Nm5CUXlpY2dXMHJj?=
 =?utf-8?B?VEFSOVpLV3U1TXZBMjdySUl3MjFuSFh0a2Y0MEE5djEwYlh3RTBIS3c4NGFo?=
 =?utf-8?B?bnkwSWpteGI4U1lBT0hQVzB3Q1FJc2JVMENtUnRJRVFUdGpZbHVBUG40Z2p4?=
 =?utf-8?B?UHdyMGp0VHV3VHBlaUd5ZXRsV3FiNENsbFZYUU4xSE5xbEdjQkd6MnJLU2Nu?=
 =?utf-8?B?a3dXcGlycGdmR1FRYU1tanB5d0pFRk9JWGRKOGlKM1YvVkpQTlQwaXlMUHhu?=
 =?utf-8?B?UndyTUZPWnRWOFR4anZWUUl2eU1RM3V1aU1FVytVdEJqTlhwb25CV0dhQXBZ?=
 =?utf-8?B?TkpEUEFVYllEc3gwN003SUxldktrOWhja3h2UHBkczdRb3YyNlAvNjRpM2hZ?=
 =?utf-8?B?SDJWbUZMTzVObHo1d1ZBZ2dZdjNpZjkyOE5PRTB4bFhwUFhpblFOOXVxN0hq?=
 =?utf-8?B?VGNvN0E2SVhmcGVZVFNnOHU2ZmtkMUUwa3B3U3BQZUpEa1RiazNtQ1JVYWxz?=
 =?utf-8?B?eG1zWTRMVjkybDUxdXBxbmx4UGY2U0RFWGcwRjIrK0JvaTBSMnBsNTl5UWRH?=
 =?utf-8?B?ZjFRR3dnTFhqNGxrb3NiY2FPUmFtOWtyZkxxUDlwbmpjRHVDQWQyNFJoZnRs?=
 =?utf-8?B?L0dSOXNiRTIvUFhEUUR6NS90Nk9QOTRPSTBHditXY2pKTU5aUWlPK3AxMlZh?=
 =?utf-8?B?c213Tnh0RkVlbkZkYTdpRGZrYjIzQ2Nvc0lLQk5oNHZMeUFDOTZ3N3YxSFha?=
 =?utf-8?B?dlhibjR6OHlDd2YzTmY0MmtYZWt5d1BOenN5TEF6RzJmeE42MjF3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7a9582-3823-4f84-43e5-08df3ecd93d6
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 01:54:38.2194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUpSMTkNH1dtf+3Yt1VqWGgJwGZ/P75rPDfLCtNodhzWjGHXANqlf1WYgdsQD7ckJVjURv9YccxUiYAlIeX7WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/3/2026 9:15 PM, Hugo Sales wrote:
> convert_custom_brightness() rescales the curve's output to 0..max since
> the previous patch and no longer reads min
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c  |  5 ++---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h  |  3 +--
>   .../display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c   | 16 ++++++++--------
>   3 files changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 8b49cbcde91cd..cef2ad8fea74d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -192,8 +192,7 @@ static u32 convert_brightness_to_millipercent(const struct amdgpu_dm_backlight_c
>   
>   STATIC_IFN_KUNIT
>   void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			       unsigned int min, unsigned int max,
> -			       uint32_t *user_brightness)
> +			       unsigned int max, uint32_t *user_brightness)
>   {
>   	u32 brightness = scale_input_to_fw(max, *user_brightness);
>   	u8 lower_signal, upper_signal, upper_lum, lower_lum, lum;
> @@ -265,7 +264,7 @@ u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>   	if (!get_brightness_range(caps, &min, &max))
>   		return brightness;
>   
> -	convert_custom_brightness(caps, min, max, &brightness);
> +	convert_custom_brightness(caps, max, &brightness);
>   
>   	/* Rescale 0..max to min..max */
>   	return min + DIV_ROUND_CLOSEST_ULL((u64)(max - min) * brightness, max);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> index 9ad888d3ae7b2..32ba2f8efb33b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
> @@ -68,8 +68,7 @@ ssize_t panel_power_savings_store(struct device *device,
>   int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
>   			 unsigned int *min, unsigned int *max);
>   void convert_custom_brightness(const struct amdgpu_dm_backlight_caps *caps,
> -			       unsigned int min, unsigned int max,
> -			       uint32_t *user_brightness);
> +			       unsigned int max, uint32_t *user_brightness);
>   u32 convert_brightness_from_user(const struct amdgpu_dm_backlight_caps *caps,
>   				 uint32_t brightness);
>   u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *caps,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index 2d7a07d9ad874..f1a558516cd8b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -1054,7 +1054,7 @@ static void dm_test_custom_brightness_no_data_points(struct kunit *test)
>   
>   	caps.data_points = 0;
>   
> -	convert_custom_brightness(&caps, 3084, 65535, &brightness);
> +	convert_custom_brightness(&caps, 65535, &brightness);
>   
>   	/* No data points → no-op */
>   	KUNIT_EXPECT_EQ(test, brightness, saved);
> @@ -1078,7 +1078,7 @@ static void dm_test_custom_brightness_debug_mask_disables(struct kunit *test)
>   	/* Set the disable flag */
>   	amdgpu_dm_set_dc_debug_mask(amdgpu_dm_get_dc_debug_mask() | DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE);
>   
> -	convert_custom_brightness(&caps, 3084, 65535, &brightness);
> +	convert_custom_brightness(&caps, 65535, &brightness);
>   
>   	/* Should be no-op due to debug mask */
>   	KUNIT_EXPECT_EQ(test, brightness, saved);
> @@ -1121,7 +1121,7 @@ static void dm_test_custom_brightness_exact_match(struct kunit *test)
>   	 */
>   	brightness = 32896;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * Exact match: lum=50, brightness_scaled=128
> @@ -1167,7 +1167,7 @@ static void dm_test_custom_brightness_below_first(struct kunit *test)
>   	 */
>   	brightness = 12850;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * Below first data point: lum = DIV_ROUND_CLOSEST(40 * 50, 100) = 20
> @@ -1211,7 +1211,7 @@ static void dm_test_custom_brightness_interpolation(struct kunit *test)
>   	 */
>   	brightness = 32125;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/*
>   	 * The function should interpolate between data points and produce
> @@ -1254,7 +1254,7 @@ static void dm_test_custom_brightness_above_last(struct kunit *test)
>   	 */
>   	brightness = 56533;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/* Output should differ from input (remapped via curve) */
>   	KUNIT_EXPECT_TRUE(test, brightness != 56533);
> @@ -1292,7 +1292,7 @@ static void dm_test_custom_brightness_single_data_point(struct kunit *test)
>   	 */
>   	brightness = 16448;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	KUNIT_EXPECT_TRUE(test, brightness < 16448);
>   
> @@ -1330,7 +1330,7 @@ static void dm_test_custom_brightness_lower_lum_zero(struct kunit *test)
>   	 */
>   	brightness = 32125;
>   
> -	convert_custom_brightness(&caps, min, max, &brightness);
> +	convert_custom_brightness(&caps, max, &brightness);
>   
>   	/* Should remap; result should differ from input */
>   	KUNIT_EXPECT_TRUE(test, brightness != 32125);
  Reviewed-by: Ray Wu <ray.wu@amd.com>
