Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAB8104BEC9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 16:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BF6210E2BE;
	Wed, 11 Mar 2026 16:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cgl9EO2y";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A0910E908
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 16:47:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ32UHomNBrD/k3/55IfWg3AOSKKEsk8V9iTIOTvPOVCaFKEqkVaLpYbhOJ4Yfr3Om3aPUAeAPS8SjVPPz1CRSrRFtPJY/53bxhLRcfMfqkQGf78abFqWAVEA8MiyG8/HXKwo7KezkFLdWpEEe/znoHu/xNRi09dYA9XIJOWt0VTnTTzoFxVT48uZjxGuTWsfg815ykHSvldmi954DHO4CgR7GqL/LSFMad/TfxxBPlJuG3OdcUaL7mvKcMmwSOL1Uqk27I0O7TzvCV4M0gg62f69BmPPksl1cgPXdsQznwPEKpwevOB24oZmixdCD/Qw/GhH1M5crqOKMyzcwGAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LX4VyDWOh9WIg+tPCbqxW6zzs7HH/SkHm1WduCT4iXM=;
 b=twCmBGZdixTX85PwuvhEDzDnK6kaLVNB2k6Igdnr0R08R59dDu0qxniQzarhL1+O9IKvrT0AuxpWFSgGRjSsJBruTfEo/iMFF0D8WTEguPu6FqOZ7YYzGuIMgh7mOHO8jMVTRsvbk8thbVODhuzscwwN0hAy/00SWgfdtC/Q+Oq++fBq0Zw+b18/2IljNCTr22s2vbCj+cev4Jk/Nq/3rR5xAc/4RY31BmoRknHdzi+WI/+c0sKM5JpGjI22FhaFJjmJ/zkSP69aMBSIXtHYDFHauJO0MPkFv9rGAnBMQm/LHfjIsakWmBWwZMcifLPE3BzqQ98nQmP3MBPdEvdCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX4VyDWOh9WIg+tPCbqxW6zzs7HH/SkHm1WduCT4iXM=;
 b=cgl9EO2yc13jJS7vP/fWfCutFrME8/CyU232tzRxR0GNVZuLftQZt6SqOX3Z/yJ+BSDlUpvapmW6v1C0oJXh9Fa4KXbVwIIaMK2qqFsQXkyrJNNQdwig20RxpxfuRivno4lXQdxl8idR9s3aMaTETJpiF8RLqmTVrUwRZ9FmI1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 16:47:24 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9723.000; Wed, 11 Mar 2026
 16:47:24 +0000
Message-ID: <6f7c5cc5-7aab-42b9-b9ae-5312f3da4e3a@amd.com>
Date: Wed, 11 Mar 2026 11:47:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Fix ISP segfault in kernel v7.0
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org, 
 mlimonci@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: rafael.j.wysocki@intel.com, benjamin.chan@amd.com, bin.du@amd.com,
 king.li@amd.com
References: <20260311161937.3089824-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260311161937.3089824-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0097.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::24) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 951495dc-cb0c-4533-b32c-08de7f8ddf39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: y1x3e/xc8GGVapxhv7B8uqOtjB67mz9TgBosVPDInrJfvsvvvEgYrgrvsXko2cQQxpgc7uRmAmuu+bL/u8jG9y7cNiNUSREroBB3aRQ8t7oPlw2FQoQZ8SvV/npKzHqZPqQA2SM2eGVDwMuo4i3xAzU0EpDIv/oMtzGnjRXoTegWgXOEnnfA3j0XnujLSuZmQPw1j7kPMZMXxgzN9mj7d73nk3iZL3XB58qtvExvaFm+31XyZ9KA4DEjsjNevT1GjHTMKbYn4PTc8EV40XRp+P2iDNTI2R7shvo29FoGbSB/PGh5OekEdz8jm5xMYSExwHqeCuMr9kC5KbrAgsl6cF9lpnnuup56fWsTCK3qNqJCvQRq4eB/yM8+4bGFi1+Ft24pudZ/oc9y0wmDT3l0x6kjboub1RYbqHY8jNcSSW4Mh6Y42cPmT/e4+4pRU9/1+513PNGtgtqKoMDf9lFQ/iWyU8fCj0K3fXne9hqKU6heAi44L97fE/VgUP/yQ17OAH8UQ0ulWt7N1Nn/NVlAhh1627tPJg33lmZqObvyNvGW4Fj/y5E+8W+ZVg195+CVyQtMerQJ6aZEqycHS4ohRtxPbX7IyhJT5ilW8VBfnS3zzIj+sWgO78Dbf7NQyev+9+Yvjo8lKcKZcWvpsRDeT/Oo/hzYmMKYr+A6H+Qa2x+3OLWfaSyuUs/wu4hyFsYKEfDnXuYnxdzVT+vAWnvcLFLChqPLWnKOG8s4yXkqJxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmVXVDZVSXhpdzJOMHA0SlNKSFFDSlJlODA4WkdWQ1RsSThGSkFJUEU4RXh2?=
 =?utf-8?B?bTBrei9aYnhoZWxjM0hyUkVUSVF3ZTJPNStwVzFIVmxOYzhtczNnM1hIM09S?=
 =?utf-8?B?dkV1STlxcjRsS1BobHVseEYxSkNVQVVZaE4vOCtIMUZHVGJqY3k0OTg3MHh4?=
 =?utf-8?B?T2wyNFdJNEYyMTJEbGhlUmNGaVRYYmhYL2k3MnhidTZNczVOeTRxQkRVQnFK?=
 =?utf-8?B?THdSdE1qMzJGN2RIUVRqNktEQWpaZVdCdU9YWlZrdnFsWDBXMWtqT2YwVWxP?=
 =?utf-8?B?OCtENFR2TE1yK2w5Y3kxWmhtaUh3ZHdFSWxiRXp3aUtSRlpCb2h0TE5CdnZK?=
 =?utf-8?B?R3NsTGxjOFg5YnBpRU15Q2RsSFZkK1M0VnpUVSs1RTVsbjBMQThRK1hZcHdm?=
 =?utf-8?B?RDA5L2VlblZxaS9iVzMyR210ZU94NHp3dnliM1JyNERUMjJsMnV2ejJBUnM5?=
 =?utf-8?B?STRoVVd6S2MrTHpCV1VRWWZmb3l5UWJJU0FnRHZJdEdVWDBmOFhyNlVjbXNT?=
 =?utf-8?B?VmkzN0l1VzMzcitBVnBjWHp3aXp2b2FWemliZ3MrZFNkSGlzcEU5QUVlc3N6?=
 =?utf-8?B?VDJyVGxhbXNQOG92REo2VVpMbkZrVHN2VzFUcENzZGNIOTV1OVIxL0NBOFhu?=
 =?utf-8?B?WWxzZlJ0R0JXUUViVEJGVEozVUhQV21nUTNieXNha3hpaUZVbDg1ZXFWNDMz?=
 =?utf-8?B?azNIVTNKTVBFMzV5TDZBWE1nQStsQURoWnhlSmxqTnkzYk0rbko2cllLalRY?=
 =?utf-8?B?Q0Q5Rk0wTmRzajUrRC9DUFBUWG9yQkNqdkNDS3RMS3BMTkVqS01vamdraEhh?=
 =?utf-8?B?UURxQ2hTakdmRU8yWUc5a3N0NEJ0L2ZLQXpKMTZaNjdiNWY1SFNETEtCbEVI?=
 =?utf-8?B?eXVFZnFhNE9uQ2lFbnFTbk1nenNGaTYyR2ZMaWUrQ2lpbSsvL1YzY2ZKQ2Ni?=
 =?utf-8?B?UU03NXpBck5YYjh6N0VDaFVTblRvRDNBWGFneWw5cXlsL2xmS0taWVN3MXdh?=
 =?utf-8?B?NnByWlhLQVNvTzhhNDZSSmRldWE5UjF3bm1ocWZ4YnRacCtFNUZFNmdJM2FH?=
 =?utf-8?B?WXJzUE02NnB4K1BLUDRxYi9vNWlXQVc5eElpVmVjZ1NFUzRWU3dNVFUvNlNK?=
 =?utf-8?B?V0NadDJVUGdIZDJRaVM0d0thUVBMYXlYaHVMNUdwZHhROCtzYVkwaWlsbFF3?=
 =?utf-8?B?dUhjTktGdDA1djBDNi8vY2NuLzhFSVpybk95VXdhSDJRVkRMTHArRjZIVUN2?=
 =?utf-8?B?NmRlRFlQcHk0WnlHSmNuYW15eVV0dG5Talp6UXpkR3lPRW9CWlc4ZVl4V3l6?=
 =?utf-8?B?SGQ0UkxrRUc4Nk8rL2VEQ25XZ0tIWTRHRzBaR0RkNThUb0RpT1MzMlhwQlM4?=
 =?utf-8?B?QWZ2OUlwY2l6dlpFQ3lCdEZGWFhTakJOQ0hCb3ZYQmt4SUNWWEpVTVJLbkhm?=
 =?utf-8?B?bFRTSmhrN3ltcUhnaE9RbHZCaGVzYytkdklxNkd3Zk8wbGs1cHM0UXhlQTho?=
 =?utf-8?B?Q0Y5UGFTSHpRZlluSjh2dThneEprdzZwaDRPTUhDb28vUkpEOE53MHA4MjJn?=
 =?utf-8?B?SXlDOTRnQm9nUEh5VitzYXpkRktJM2NBdHJmS3ZWVFVCWDdpeXBVdVdSaEk4?=
 =?utf-8?B?NzN3WEJ5UGRmdWhrRldBY01pTDFEdEU4UHJLaDlRYng2S3o4bE9rck9SekV3?=
 =?utf-8?B?T0FmcTBXei9UUSt3VDdvclpGZ0NteVVlTWdmczF5WEgwaDJFUk5saHB5M1hs?=
 =?utf-8?B?Zy9tT2QvVTNQTUpRNmtnV2tpL09xbWo2VzZMclY5UnhjRlVUWnQzNUJSWXZq?=
 =?utf-8?B?ZHFLUDVCLzlhS1JYU2V0Tmp6eTliYjQwQXYwZUZWOHlER2tDWUdOcTcxR1Zw?=
 =?utf-8?B?RmtRS0M1Z25YcEJnaDNWRDFNYTlBTFM1M1BHeVVVWFdlYkVnb1czZitJaW1N?=
 =?utf-8?B?cG1Tczlzb21uSmVnL2xMaHRuaVhnNXcvVnZHQVRTRG5Vam9URmgvNG5mN1R5?=
 =?utf-8?B?R0J4ajJZYkkrZlFJNCtMdDRzRFprMEM2UmMrWTMwbUczVDFxT2VaYUM3bUpY?=
 =?utf-8?B?dzdLM0lqZU5OWXkvbkR5dzdtS0Jnd1dlS0NwYU5xUFJ3U1JqRFZCWGJuWUJh?=
 =?utf-8?B?bi82Vk5GUDJBalNCK1VSbDBDZTBWMkNkYkIrbVo5Z253NzBrTzRLeWpBVGRS?=
 =?utf-8?B?Y3VOK0kvRXpQOTk0Qk9FOUlMbkVQdUNCY1kyVitwUzlia2JLazRxY0c1VFJp?=
 =?utf-8?B?TkJxZ3dTcFYyenNlOElxZG5kZkFrd2QrY3Z6TSs3QjBwdHAyWlVOeFRPVko1?=
 =?utf-8?B?dDMrNCtqZDRMZ3ZpaExCaVBUam5Pd1AzQnU4dnBGbEM1ejBpRDZuUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951495dc-cb0c-4533-b32c-08de7f8ddf39
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:47:24.6595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC4qosh8XCwGRo+azkEYm8t5+d/yWoykP7YgQus8kGKWZjISotSxG8hKbBabbxe01qtj3rJpzC4oO5dIQMYzIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
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



On 3/11/26 11:19, Pratap Nirujogi wrote:
> Add NULL pointer checks for dev->type before accessing
> dev->type->name in ISP genpd add/remove functions to
> prevent kernel crashes.
> 
> This regression was introduced in v7.0 as the wakeup sources
> are registered using physical device instead of ACPI device.
> This led to adding wakeup source device as the first child of
> AMDGPU device without initializing dev-type variable, and
> resulted in segfault when accessed it in the amdgpu isp driver.
> 
> Fixes: 057edc58aa59 ("ACPI: PM: Register wakeup sources under physical devices")
> Co-developed-by: Bin Du <Bin.Du@amd.com>

Did this pass checkpatch?  In order to use C-d-b this should have Bin's 
S-o-b I would expect too.  If it was just his original idea for the 
issue and you implemented it a better tag would be Suggested-by.

> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> index b3590b33cab9e..485ecdec96184 100644
> --- a/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c
> @@ -129,7 +129,7 @@ static int isp_genpd_add_device(struct device *dev, void *data)
>   	if (!pdev)
>   		return -EINVAL;
>   
> -	if (!dev->type->name) {
> +	if (!dev->type || !dev->type->name) {
>   		drm_dbg(&adev->ddev, "Invalid device type to add\n");
>   		goto exit;
>   	}
> @@ -165,7 +165,7 @@ static int isp_genpd_remove_device(struct device *dev, void *data)
>   	if (!pdev)
>   		return -EINVAL;
>   
> -	if (!dev->type->name) {
> +	if (!dev->type || !dev->type->name) {
>   		drm_dbg(&adev->ddev, "Invalid device type to remove\n");
>   		goto exit;
>   	}

