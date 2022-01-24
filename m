Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF04C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F0610EB70;
	Mon, 24 Jan 2022 07:18:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9E0B10EB70
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7wSAFpVis7QszsscD8kxLn1e0KHLPL3/OH6w86sBfANg4rqAKAkBeALptxTYeoLlHP1uMXRf7NzywgHIooM4UsAPUnrTO9qfGnf5gG93sY3MHcc6G2k/qmxuwczJZVWc/URguA1DNH6/DRxLBeV5AgSEPYfDqfTbC5j2ZwUnkLg+SGpIER9+UZdYGU5C0hI7vV+RR4Ja0w2Rr3b17qKUGi5C3kI/tOC16c+1om4buPsb2/Hm5GthXc1tcAdsnTRJsOseHEiZZA6IVXtmizhfyxo/mJnsNFiaDhmjpsHfDZdZZwNw9JoMadUX2e9ot7zKSTz8v0d1kMWMMRVZTyGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr1vbJ9fTnOHFAGgpFIopUrgqfbfoPsKMLxPQ7mLFLY=;
 b=ZEYz7HG0BMMjY91DWdqAiB+njBJVP8jqTzgE2a7lzkTJndTUArA88MZwICzMZBIBzQ8y5XbXw9DhqyD5EGj3ZwhlxddH3IlnVuf70Qvzxe/bXI/4h+NWpYIcfSDAUaGmkb391NHhPqqlnkaHHDy8/8VU0OnPV0SzlTBImfxgHuZ3Lni579mSC3Abn5lbchr1MxDd/rNv4QhDH9gTNHuWHuyOV0+1xdFGR2L0C9uT3CwlI4vy9vLOHYcCSBfejURHe+bjAEE3qzZ/jqd/AoJozo/ggjNXDeldYvuuwCTviX+7q7JfZ7RUFBA/avFlFoKVqks3js/wFzniLOI6rUkjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr1vbJ9fTnOHFAGgpFIopUrgqfbfoPsKMLxPQ7mLFLY=;
 b=APosXGlBWjt4u/OCmmtsGwyPPSJkfg75Bxd2HtMIvz9AlLk/NTPHv7T5JoiH5UC3p34od0vsNUPblSaqmA6r/tyD79R1RRqDtNwIGnQEwQZ4SSSPulwtxAxBsLifSU4NfI2TkOUBLKVKbIXKNh9FWer8zqPEU+dGhLPATr+culQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 07:18:09 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d8e7:e6b0:d63c:4a21%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:18:09 +0000
Subject: Re: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <b951f172-45f4-c88d-6655-8eec715c038c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5d71f21b-39fb-90f6-226b-fd5dd46ce010@amd.com>
Date: Mon, 24 Jan 2022 08:17:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <b951f172-45f4-c88d-6655-8eec715c038c@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:207::32)
 To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31abc07b-2382-4e88-cc6c-08d9df09ac68
X-MS-TrafficTypeDiagnostic: CH0PR12MB5156:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB515672F33FF579F3DE5904F0835E9@CH0PR12MB5156.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6G7cU6rtlCFV8+lsz1/PhShRCHY/eIwzQKnutFp22OLCDlM18pLzB93UMxsuyOZ5IOqL44TAvSf5B2BAZl3jeKVUHVNak3iFyOIH03rtODfg94lVQtjkHI6AoZqVwMWAdZYHHbPyd/GI9Vj6GmzN3IuCgp/qMuWn9QtDpgJoQBrsmhiboU4jiQscLZWUbFG9REas7hJwO5f/uatxUWPX6JyfYG3yKisYN0/No5p/199g4M+71rXpUDZxEdmVc88xRA71JUVnQXy++X4hev077xbrjuhhyFtLb5TZ5kxWVScWpq9moJI95O8wum8stAFUzqA0X0isvc6fQI3TaKZwQv5+XwBGcM+doqccWeiSQqzCDsgZf1Sjag2hiEUti1FBJoR7Q9OyRCMcMHYZiJWK8+OFbsbYJYr3+eg9px/SpQQ/ZOZC9ep4K2WAY5xC1C2/vcvYR/ZTPiKwm3R7teCzIYbhlczVqSxuMi+i2GgytvkDVd9FhT9acGSJ2U7s2X3GvKtnj8Kf8AmlON3jRcOI+CFUnORLayQTwAoIPA2WyLjITcIlhO+JydW6knKQ+6QWXUxcjsw41595G51zLNM788sU50cU1I1KdzP0RzTtBoPFISJHQe6FaopMBMeQDLTpPDasHUAvubuAWE8Ui0kjsLyZKBe0imihh1UIkq/YX7WkwLbxPhkVdeBDLdclHmW2IPlPPx/2FFdTwXJFae/QnAmfgze1YFFlW8854lNODfwRkTFEIMIZDWVEL/uBnGAM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(53546011)(6512007)(316002)(8936002)(6506007)(186003)(31696002)(26005)(31686004)(6486002)(4326008)(508600001)(5660300002)(66476007)(66556008)(110136005)(66946007)(86362001)(38100700002)(6666004)(2906002)(8676002)(2616005)(36756003)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzhXYUFkS25VZ2hYWmdqcmg3S1UyY3daUWxOaTVDa1NQcmhIQzhzWWZUTDVR?=
 =?utf-8?B?Q0s3bVN1SExtNHpzejVZVTdUVG80UjFkZWlWT0pqMXBpamRHZWJzcHZGYmQx?=
 =?utf-8?B?L3ZtMnVVRnN4aGkyWVdaRmVtZnNXbU56ZEpSdVYvMlVXREsvZzdrdmdkRGRP?=
 =?utf-8?B?czhCTHh4eUJMY0FWMWZvY3B5cFNHVjlYRU55am5BUW1lRE84bnViOVJaVXVP?=
 =?utf-8?B?dVk3bE0zNnFyaDhUeE9yWU1HV2k0YXpjMis2S1RndCtoZjgwbzEwM3F1emM3?=
 =?utf-8?B?aTh3bUVsbkphV3lBNHlFK01LY2R6QktGb2NLcXJqSTVYZkg5RjllL0tmdjVo?=
 =?utf-8?B?MUpUWUdQLzh6bnN2WnVyVXdSaU5BY1JwMWVrVW85aHF4aURsbUlBcTR5L1hs?=
 =?utf-8?B?NS9wRnJCeEh3dXM3aGdhZklPdXNHRE9aZTk2V1VFdTRyaFN4Qm5KSzRYOWJl?=
 =?utf-8?B?Qm5JUTZlSlA4UHlQRERxb1Z0RUh5bFdaNlYxVXNERjAyZjN4QnRuNDVTMkIr?=
 =?utf-8?B?RzZmNUxxVnFDTlBsL2xja1FMVSs3bTZSL3NUL0tWRFcwSVUzRDhsRUlHVGdS?=
 =?utf-8?B?QTRCWW14VHpUMTlSdEFRalJWaGdRNk5LR203WlVxeHNhb0NZdC9rMWFNUnRN?=
 =?utf-8?B?T3JhRFZjU1RTSmVCOUhFR05Cb1JYWUtkUVgxYWFKdUdqV016ZXl0Nzk3VFFr?=
 =?utf-8?B?WnN3S0ZXbjBHTlYvNE92R0ttWEh1WjE5QndSczh6SG1oSy9QT05xTXo1R01X?=
 =?utf-8?B?Yjc0NHFOSWxnMGFQKzBRbTNMcnVLNThZd3ZjRkNFQnNRRFBLT01kM1ptSVF5?=
 =?utf-8?B?TWhwNmllU1Y1L1NDd0laZDgwTkl4RUpTWndnMnFLS0ZEb1k3Um5SS0NMMHdM?=
 =?utf-8?B?cEpPK3Bub0FNMVZLT0srRG5hNGpmYzQvYmh4a1NuZXNTWWNyTnV4dnBwTnhJ?=
 =?utf-8?B?U3pCbkhWTUlWcDFHNWhEUjZPV1B1aVJ3YmVhYS94a0Vsd2dOQXpEUlNxNjJM?=
 =?utf-8?B?b1FhY2o2VGEraEo3WG41a1Q4WUxGdWFLdkRkZHN2dFJaamFyMDk0VlE4YlBw?=
 =?utf-8?B?VE45WE1aaW9SN0EwcnAyRVFqN3VTWUhiZ3ZSSElzWS85Ym5RS0I1cXVuQzVB?=
 =?utf-8?B?ZGZOUVdzbU01Ym14MlV5d1FjaURGcU5SUFN2d3pwZ0g1bXZMOGQyV1lUMHRs?=
 =?utf-8?B?YWxNdXFiY3NJYWNGaDJCY0I0QW9vcU5KUFkwZStOMW5vZEd3TXl0YmRKTHJC?=
 =?utf-8?B?Y0wvR1RXbFU0Sm1QclJDTCtyanZMSjB6OVZYZnIzd3FKYVY3d1pScmJleVdP?=
 =?utf-8?B?cXJzNDltQTN2VloxdnhVZTlkdXY0RGtEVkJQUmltKzZUU3ZLR1ozM1g1TmNq?=
 =?utf-8?B?a1hIWlIyZ0xucnEvVkZPMkVZaDY4dENVb3FvYjZGQkNxMVczZmRzdS9GYUpS?=
 =?utf-8?B?Ui9xbXRYc05EQ05iQXFua0szTkNHRmFQWVhNdDdEbGJnL1BHWlJSa3hKWThp?=
 =?utf-8?B?LzQ4UFMwMis3TDNVZ1Ayb0d1Z3hDdUNoMnJuOUxyRE9UVk5VcE1jMTNGTTZ4?=
 =?utf-8?B?c242eCtydU9pbEJpYnYvTmFVT0NrYklDWEovZlE2bjBIL0JmYjdDZTZDYmlH?=
 =?utf-8?B?VGFFV25GODV2UlBuN2F3UE43bEY5RVlTRlhyUHMxKytmR2NOTmErMTY1MW9t?=
 =?utf-8?B?bmNwR1hLQmJaam93dHFCMklnL1prdXk3V0poc1RMdklWSTVaS0hyMnVUdklB?=
 =?utf-8?B?NXFSZVdqOUpmQXBwOTMxU3pXUXZad3R5bmNRWlU1eUlGeDI4dVFRcEd1Ny82?=
 =?utf-8?B?T25LNkQwY3EzUDhvWmhFWm1GRXl2MkNtc1RmbFlPUC9oR01LQ0xWS3F6WXBw?=
 =?utf-8?B?VHhkUlZRMWtxYmZCcGlXMmlnMHZDOXd4M00yS2J3bkw0Zmlrcy93ZWZsYnZT?=
 =?utf-8?B?VG1YTGR5bVM5cWVoWjZGZmtuYnF6eTNCN0xVMXRPZWpDM0xUNzlTM1pzK09o?=
 =?utf-8?B?cEM2aEs2SnVzWWxXRG1ta1ZCZUVHWEgzc2k0WlFPQzBRRzdoN3NFL3lRWU1R?=
 =?utf-8?B?YzUxV0l3bHJtbVJFNUYwNmJjVHUzYmJkUlFUS2hpUmhzZ3h0K2lxaW1UNlFt?=
 =?utf-8?Q?eHRU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31abc07b-2382-4e88-cc6c-08d9df09ac68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:18:09.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQ3QgFNyf8jvEoUog+5RBmfnyUCFzai5COAg7DA93T3uWqxFIY+G1FT4i3sU7Pgw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.01.22 um 21:37 schrieb Sharma, Shashank:
> From c598dd586dd15fc5ae0a883a2e6f4094ec024085 Mon Sep 17 00:00:00 2001
> From: Shashank Sharma <shashank.sharma@amd.com>
> Date: Fri, 21 Jan 2022 17:33:10 +0100
> Subject: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
>
> This patch adds a new work function, which will get scheduled
> in event of a GPU reset, and will send a uevent to indicate the same.
> The userspace can do some post-processing work like collecting data
> from a trace event.
>
> Cc: Alexander Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 269437b01328..79192f43bb71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1057,6 +1057,8 @@ struct amdgpu_device {
>      struct work_struct        xgmi_reset_work;
>      struct list_head        reset_list;
>
> +    struct work_struct        gpu_reset_work;

This needs a different name. "gpu_reset_work" would indicate that it 
does the GPU reset, but this really only signals the reset to userspace.

Christian.

> +
>      long                gfx_timeout;
>      long                sdma_timeout;
>      long                video_timeout;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index af9bdf16eefd..e29e58240869 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -72,6 +72,7 @@
>  #include <linux/pm_runtime.h>
>
>  #include <drm/drm_drv.h>
> +#include <drm/drm_sysfs.h>
>
>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> @@ -3274,6 +3275,18 @@ bool amdgpu_device_has_dc_support(struct 
> amdgpu_device *adev)
>      return amdgpu_device_asic_has_dc_support(adev->asic_type);
>  }
>
> +static void amdgpu_device_gpu_reset_func(struct work_struct *__work)
> +{
> +    struct amdgpu_device *adev =
> +        container_of(__work, struct amdgpu_device, gpu_reset_work);
> +
> +    /*
> +     * Inform userspace that a GPU reset happened, and it should collect
> +     * data from the trace event.
> +     */
> +    drm_sysfs_gpu_reset_event(&adev->ddev);
> +}
> +
>  static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>  {
>      struct amdgpu_device *adev =
> @@ -3506,6 +3519,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                amdgpu_device_delay_enable_gfx_off);
>
>      INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +    INIT_WORK(&adev->gpu_reset_work, amdgpu_device_gpu_reset_func);
>
>      adev->gfx.gfx_off_req_count = 1;
>      adev->pm.ac_power = power_supply_is_system_supplied() > 0;

