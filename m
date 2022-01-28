Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C1EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 08:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9830011229C;
	Fri, 28 Jan 2022 08:31:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092B711229B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 08:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld2it5B8723kFNbTz5VWdTmblYqqdpR80X8eQ7/+FvxjvHQ8zbiEV2JsicewVkeBKlfQf0HfkK7FtYHX3gt2xMSSPP28VIoQQLYNkv1l+Ix/fV3oa4rlTAWxBpOAaRkHIdZB/J8yMVhNPmXsr+DA/vqLDj1OasM21VJ6wxKxAe72cM6wpCppMvc9LC7Uxa++k18MkkfPhhxwjWrME0otEdYf2vJaJLbWyx2qL6zNH+RLUoz+7HPBU6awN2xUFPzhDf8xccc/7L2nov7cfe/tdqlUDTQ0ZaJEaIvpgBnC7jj5KFwx99wzXHx2POX4SISw7Wwta4fXldmMo7ow87qUkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiK82jmcyu5hEmrpmhn99gZDWvpmz/21n+2XQHwPGQA=;
 b=J9HcgJbGBNomfZmNzCxzyYWKrTy2FXB6RUeK9dpf67Oh1u6+blGgHIgQEq5QJ4//yM+UDoxe5+Lm63De16S09Y8bO0f9vyZEsxSr/jdXrxyiHq0nzXBgOh6biLzvYkHMXWFKwJWMYadXDjy/Jp6xngJPcNnVIcqTFom9zMPgG6zfvcRaYY5TD9MSGR/Hug5M3/gDMqKTDSVV+YsyJ5jFc7vPoThb/q3clbE1OzQobwllg7piQ8d6OqkqKTgAewFXJddPOf9sDwuUuSl4q1Ry0kS81BW5g1YKrVlEWMufM7POFx/dIo4ukfw3OHfiuy8yv1MjwmDonbPRT4+j5BB/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiK82jmcyu5hEmrpmhn99gZDWvpmz/21n+2XQHwPGQA=;
 b=i+/lMHcqJqIgd35TwULSHFGhC9h1QRHlyOk43n/Fg4fe6sOUmvvRbYjpWEl4AQuJTHw0kvJwEhdah7Qg/aHto6gUTmJAQtm/iRdi2bFp383WdVTW6f0NKQK56QpaKiQM6OXnmEegwUfLa/IhO2FN4aJ9Iq/aiJLGIp63MXEchvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB3415.namprd12.prod.outlook.com (2603:10b6:a03:d5::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 08:31:32 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 08:31:32 +0000
Message-ID: <d8bf41f2-6aa8-8af5-c5a7-ba0750549a82@amd.com>
Date: Fri, 28 Jan 2022 14:01:18 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amdgpu: add safeguards for querying GMC CG state
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220128065409.1479854-1-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220128065409.1479854-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::32) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98e2202e-9eba-4795-0b29-08d9e238963d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3415:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3415BF3694468C7E5DC778FA97229@BYAPR12MB3415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkb95kx/9hz21F+CRSlhslWeT4OVwhHAEWnH7txvWB8yKWkTQ8ahfvhrYgvp+wu2D+eyH910iMd3AD6OgfFCycv9+1mK5wcHGhWQPjfIp3/F8cZTHzXBnHHD2FD2Vz9wYJSX1wlG0dKA0NqBbY9A03+V5XcGSHAJKVC5jLuhPLo+Sb37stZpO3+LBfTUXir9kLE2ulmSiPDA8n5f3ZEWlEfAS6tNSIw+omDgm2eF/HmG9l2MWB5OFemO4MrZ8i6RS9sHJszoXMCt16Cc5/4Wl+ePxpVum4VI01HucpUtOc6suUzjJe5VPyCJKil9Y8Zurkv0Tq+ZhdeTE+gN9kYs1nibdRwzgv5BKpBDtqWqjXULz6YAZl8pfkiUlXaGdIZKwfIMQ9aqwGSnWFBZArk8UYGvBpntmvxnM4wtIfcFD3FpErW++IcJQ581DCgaXmLMRLvsJdO3Bzf+P52RGjfIF4AlUzh7+HrtGsQfbIV710Rj4lULyU8AC1qcYIXEG63K6mn8O2y6H0eJN89sxum01qKGHbDOr6vIMLybZzAVL69mWGYFVuxrfTS8z8f50/luex5zssPtjuuMEM/QUtgxsIvdtdwCE9/+Kw8/HozUpGHFK5myqwktVxNRcEhMui2Q/k6+wM3FQ0dzMWQNLE3o4OF+ftZKWWlMP6B+/q/0NBC5840JDt+jegwWQY5t+YvLvlzzTh6eqxdsfvs9UIEps2jNKACFfWY+D4WdwMphFY3Hh/FYOkK4eX5NoJ7pnG6w
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66556008)(5660300002)(66476007)(8676002)(31686004)(53546011)(6512007)(4326008)(8936002)(38100700002)(316002)(83380400001)(36756003)(54906003)(186003)(26005)(508600001)(2616005)(2906002)(86362001)(6486002)(31696002)(6666004)(6506007)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWUyQmFXVXBMcDhod2h5d2krcE9TVnFXZFlDdnVwZFFWa3VUMER5UDBaVTk4?=
 =?utf-8?B?REdRT3BmSUc1dDVqeDZjdkY0RUtNUDZyNTB6MVMvczBWS1dyZXdNN3NRUzZv?=
 =?utf-8?B?c1hXYW9VK0dScFc4UTZxWmhrck13dGUwekRKSXEzSm5mRjloWm1kVmlSL2gv?=
 =?utf-8?B?SDV2blRoRHNVdk9MUHJWUjgrUkJzQWVkdHpQTjErM1FMSCtrVkhnZ2oyc0pl?=
 =?utf-8?B?ZG1aVm9CZ3h0ckdNd3k5V3A0bU51U0dJUVkwZXEySEgxY284S2hpZ0VKdU9J?=
 =?utf-8?B?WE9KQUkzeUl3L1VLTk41SFl6OFlnOTMwOERZa2htOTh6Ry9wUkZCZVVid0d4?=
 =?utf-8?B?WHF0d2ZSUEE1YnljdVRtVURpOVZIU1M3MmxZdUk1Z0tSM0k3ckZEYjhwWDg5?=
 =?utf-8?B?YmpNbjJnNEJ6TW9kVk1lK2IzMjUzcXFPWFhtTWVWMVlUdVpRN0hDSjN2VWh6?=
 =?utf-8?B?VDFpWDQ4UHZNRnY0eDRGTjM2RUVEMmdPdzc1Y2ZHemJiTWN1UjU2UXZPOXFt?=
 =?utf-8?B?NGJibklHT3RpellXRWttemdlY0wvcHhkY2hLbDZQTnFuZzFHQ1dIVHFiTTZ2?=
 =?utf-8?B?dGQ0R1l3aUdOVHZFTDdLOUt5aFVzeXg5aFNSQk16c3RkdFFNYVE5L0FYVmVJ?=
 =?utf-8?B?QnQrYWtUYUFndWhYejRrd1dhWlFKd254cDNqazhVaFcwUCtON0xjY0ZJYnRu?=
 =?utf-8?B?RTduNjhNWXFTd01aYVkrbklzQk1Dak9EOGwyTmJZRGUvOVpYeHNjbG91U0dJ?=
 =?utf-8?B?YVRJbk90WnhmeHp3cGVidWp3T1dzeXZiTTdwOU5PcWlZMVczd1pKZjlUMlZT?=
 =?utf-8?B?SlZVWFBLd3VweGt5UzZLRWlSWkZLRTU2ejNpSWh4YTBjUHZtYk1wZXg1ZFE5?=
 =?utf-8?B?Tm1qMThwdEZFSW9tTjd4OVcrSmlFdDk0blJxZklXM1F5WEFYaTc1cCtaeE9B?=
 =?utf-8?B?OERrYVVKdlBEQkRWYmFsaWxTTHFWTmZpZ3h1YkhDa3RrTzZKOHU4dWJuVWYz?=
 =?utf-8?B?K1pwNWFORGlSVHRyM2dsTFR5WmFVN0pwczBUV0VmODR2eVhmTHB0NUZpeWZk?=
 =?utf-8?B?ajdXQXFoVnp6MWZNY1l5ZTJ1U0NNOFppVmZ0cDlFZmNOMUVvOHBsZU5ISEl2?=
 =?utf-8?B?cHgzdEpETS9nWUVwUWlJVGVXMTFvK2FINER2RnJoNC9CeUhTeW9xZHd5OS9p?=
 =?utf-8?B?aG1aQ1IwWDNvWDVDU2ZGT3dWVWwwazN6N0xub1d1THVydkNqMzRybkVaaXAx?=
 =?utf-8?B?RE42ZDZ1ekhLSHpCL2thT1lRd2QvV3FSSm1hb2N4VHhrMnVJNFZDVEFuVmQ1?=
 =?utf-8?B?cWx3V0M3Nm41Q3BlMzUxR21FK3QvUXNkMTNsUVJDd2ZQdW1JMmE5SmRMWTl0?=
 =?utf-8?B?SVg5aG5uaWsvNGM2QnRna0wwaC9SSGc5L3RTVS82UDgxWGR2bFNNMkpRUjg4?=
 =?utf-8?B?TlRJMWRWM1g1WVAzWmtzL043TDBsdUE3d1lUY0xXTmVZM0JiQnJ6YnVqemFM?=
 =?utf-8?B?Nit1WXNGQVRubzhKRHF2MHhJSk5PaFIwdlhEc1VrcU5jd1BaWmFhNWxQOGFy?=
 =?utf-8?B?TmtqbXc4bVl1MUx4Zk0rcENBcVN0ZkxtRnJLYmtwYUJiVEpsUkREdHROSXEz?=
 =?utf-8?B?bENackcrRTZOckl1ZzF4OHlsSGdueGtQUnQ2c2lGbmtETFYrRTN6Mm1OWGFh?=
 =?utf-8?B?dFBUK3VzY1E1VENvNmhmUnJybXR6cUhZOHlqTFNnVWY4TkFoQWlIRTZtazRt?=
 =?utf-8?B?VG1HUlh3b0h2T2E2OXdvcnlHVnM4L2VzVGtzRjBCaDFlOUtldTd3U2J6NkM5?=
 =?utf-8?B?L1loMncwNkJocGI0Y29adHV5MnRXeFcyS25FTzhDTmtIMkNMbHNjc2J3dGdu?=
 =?utf-8?B?N09pUEdoZ0dZZFhQc2E0YmpWMmpPdEo3SE5WMTBMbUovZWdzMzlTSEhDdlBE?=
 =?utf-8?B?VDhSa1M4Nms0SnhvTHVkREVRRVIwTVR2cDc0RVluVWNCTDlhLzdCYzVVSVd4?=
 =?utf-8?B?L1V5dFFkZDFoTXhZUWFzdU4rYkdyZXUwcDYrZjR5YlJIY2srYnN3SGpBTjFD?=
 =?utf-8?B?SGY2ZndDeTg0Nk9jY3Y1MmQxci8zdG56Wk9FWjlNb0F4WjYxMG01TWNkNGJV?=
 =?utf-8?Q?s+aY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e2202e-9eba-4795-0b29-08d9e238963d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 08:31:32.1264 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiq6siYE77SrgQdh40FCbhIHKD4fri1fpi9rWSQ+ST1w++PHKY+uoYpsxaKf7SLw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3415
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/28/2022 12:24 PM, Lang Yu wrote:
> We observed a GPU hang when querying GMC CG state(i.e.,
> cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
> skillfish doesn't support any CG features.
> 
> Only allow ASICs which support GMC CG features accessing
> related registers. As some ASICs support GMC CG but cg_flags
> are not set. Use GC IP version instead of cg_flags to
> determine whether GMC CG is supported or not.
> 
> v2:
>   - Use a function to encapsulate more functionality.(Christian)
>   - Use IP verion to determine whether CG is supported or not.(Lijo)
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +++
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 +++
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
>   5 files changed, 20 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d426de48d299..be1f03b02af6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -876,3 +876,13 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>   
>   	return 0;
>   }
> +
> +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev)
> +{
> +	switch (adev->ip_versions[GC_HWIP][0]) {
> +	case IP_VERSION(10, 1, 3):
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 93505bb0a36c..b916e73c7de1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -338,4 +338,5 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
>   uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
> +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 73ab0eebe4e2..4e46f618d6c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (!amdgpu_gmc_cg_enabled(adev))
> +		return;
> +

I think Christian suggested amdgpu_gmc_cg_enabled function assuming it's 
a common logic for all ASICs based on flags. Now that assumption has 
changed. Now the logic is a specific IP version doesn't enable CG which 
is known beforehand. So we could maintain the check in the specific IP 
version block itself (gmc 10 in this example). No need to call another 
common function which checks IP version again.

Thanks,
Lijo

>   	adev->mmhub.funcs->get_clockgating(adev, flags);
>   
>   	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index ca9841d5669f..ff9dff2a6cf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -1695,6 +1695,9 @@ static void gmc_v8_0_get_clockgating_state(void *handle, u32 *flags)
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	int data;
>   
> +	if (!amdgpu_gmc_cg_enabled(adev))
> +		return;
> +
>   	if (amdgpu_sriov_vf(adev))
>   		*flags = 0;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4595027a8c63..faf017609dfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1952,6 +1952,9 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u32 *flags)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (!amdgpu_gmc_cg_enabled(adev))
> +		return;
> +
>   	adev->mmhub.funcs->get_clockgating(adev, flags);
>   
>   	athub_v1_0_get_clockgating(adev, flags);
> 
