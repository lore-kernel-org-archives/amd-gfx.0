Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724BAC25B08
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 04:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15158ACD35;
	Tue, 23 Aug 2022 04:38:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D92FBACD1B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 04:38:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDkLIevAGhuw/FmK/LMyV+hud6RQ8YA42XIuATk5UOUAl+b+hh4Tz3BKwU3wDtzFVBq3lGVbIOunUr4qAiamyx4EbKvg0gOIs+OZzoVsI8B6mAqW5kQi7hBSl+XSL7u/8RahctOcCBDtxGkqE7XK4cGa7PRbpogNMSwyymFwVOXYrGFi6BB+o20gVNdvpsyUd+nCUNGtqjXEVmpx+WouJxGao3CPJWyopYgkuEZIB6tgLYV0r6yN/EFSAs+FZjSHJ+hxSqeOvf4D8tGsj7l3/cRMoi1VkuS9RwxGMyM5hiD+4WAB7Ew4ByANY1ytp1F+xVMpzXStiUonf9gG/AXaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGCd6pRRAD2p8aljlioHelbbUHExltDejRkOEC3sg20=;
 b=iVuXF1/Aci2ZrYsY7B+AwktZqn/Zx62pOM+Ico/i3mXX/U1EVVMZ3xz+/1gmXIHx0mR+/j5BR4GqZdGwHBroMvteAKuDdGNJgYqa94/+wk58pof2dFyAeF9PZaP+vf9z45DVymURH0oVypHMsrmbKxkx3nFU6xpeFjntcsjArJMVyjGQYPFYwEINyKotk/QNKNVOfLe7ND1o1As/JB1z1uWNmr3BTRtJTnEmVzUllTsYdtzPz0be1R4t8kMg2Kj9BR0ATSvzNSucdxg3d8i++3mWzT3KdPkYKP4ZuXDRZ1wvqstQffjr6ZhOqB/15HnxJNyq2LwsDpSTzi/vPuy6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGCd6pRRAD2p8aljlioHelbbUHExltDejRkOEC3sg20=;
 b=1MVKa7b8bI7PQrdrX5c7PeloniSBswxMrW0xE/cAUTPykXLqDkkorskpCowkjRUkGRd4luRHchN5XomFsoiUr5x5CkKcTraS7z1hk/73BhOKz5RDTOVVgKkq+vvIKdepei7df3iJGpOSebMu2BSCLmv7krI31+H3QkWOEXR2o8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10)
 by BN6PR1201MB0178.namprd12.prod.outlook.com (2603:10b6:405:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 04:38:05 +0000
Received: from SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::dd3b:49e5:229b:e6a3]) by SN6PR12MB4621.namprd12.prod.outlook.com
 ([fe80::dd3b:49e5:229b:e6a3%4]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 04:38:05 +0000
Message-ID: <95347ce5-e74e-2055-a90c-ced9811654d9@amd.com>
Date: Tue, 23 Aug 2022 10:07:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: improve BAMACO code for smu_v13_0
Content-Language: en-US
To: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220823020247.2545671-1-kenneth.feng@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220823020247.2545671-1-kenneth.feng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::22) To SN6PR12MB4621.namprd12.prod.outlook.com
 (2603:10b6:805:e4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71014bf0-d40b-4292-5924-08da84c144ec
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0178:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfq+/yDPomQaL23Hq+hFe10ows1VsFxz3SE6UP2QQ9vZnyHcaRVL4kYHA249VKoEJMxug1FRcDe7+MBZBb2GABEvO5R8/Ito6yfJa2HE4kZxz0ph3qexQdyWxVqyOevJu4kWpd1m1TxuYH0gQVxP63e70M7WMlrpL+QAthxkj6tSWgLq1lOa1MxPoTut3Ui6ctW1qpJ6J512Js+WrokuhrH4stRpdLreRb7wUXYr7a5g7XvmbOrejlRGsWpmOaLrEG+zMnsnW9rorAdcm8F+YGRIeiDLMEle0ExumTlwqGO3AoZxo1sEY21vF08DJKjdQZ+5sM4AZViK1HsBaORdz18QNTI5kLRPKkrQcdOQ5dpgxj8p1wtFzj5XqpxMiF/2iO9QE8zw8qPdO9CJ0u1Iu7XwJNWYH1sY8hq5EiQB4daOcYjaEYTzYn741Gnyu+frns1AX0xQrPrCpE49tP7stR/dTxtwOFcrnwbjRoH1yFWvavsBDfCSnMHkFyx6wbPFXw1sFw7/wOGB+jBrXllMdPFa68IOD9A7k+jLP6+mKIZZ2DTGeg0mbS32V9TgD0sRwN51jifCmnOmo8HrLgho1Tn96r/bZ0t0Y6GUvGHNRXIKf+WB3DEV7WE6RffMd6T2aJAGSbLaz/nR6Qmtm7kU0yNhLiJuV2zGE+x9CrvmrlGJmBDplNOwl/4uAFJz2urslS83jmqYm/rnq8LftNuFzf+2ccOha7YeORprRql4va0P8GLlEG4U+6vFG375NuyvxUnPV4x9gUPnJKIE5vUwys81an3iPz1gDVCt8FdNeJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4621.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(186003)(66476007)(2616005)(83380400001)(86362001)(31696002)(38100700002)(66946007)(2906002)(8676002)(66556008)(31686004)(6512007)(8936002)(30864003)(36756003)(41300700001)(5660300002)(478600001)(6486002)(316002)(6666004)(26005)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBwdXFwb3diYm5Fd1M1Q1duZnlJRHQrWTBBajZHblNzcmpiM0U4cUEzK2tn?=
 =?utf-8?B?amFJZit6V0xFR0NLTytyeWt1S3UzWFpYcVh1T2tEUzRVM05LVCtnYjBjWTZr?=
 =?utf-8?B?czF4UDFSdDZCYVRlTXU4K3UrbUx5OGExYUZPVGRvSmJrYzZJanVTZmdwVjZh?=
 =?utf-8?B?V283SDVZNnFGeU9yaEgwbHNNano4cFhmNDJQd3R3YzhPRHpZWUVKVlZwKzNU?=
 =?utf-8?B?eVk4a0lNbFFvWTdPb0EvNmlTZnJoQi9zR0NmR3lsOU5sNEh4cFA0dXg3dHRx?=
 =?utf-8?B?T3ptUVp3TmtFaU5SdVF0OUJDSUhubzl6TVljU21vQllMTXNRbnFtWW43U2V0?=
 =?utf-8?B?YzFGWGIvbWZUOWhWV2JmYy9NQzBrZ2pWY2FDYnNIYlpudUd3bVA5am9lWm1H?=
 =?utf-8?B?RUUrTWcvTmlIdHFpaDlHc2lKNkIxaUdoUHhENWFsQkNidkFsTlI3bENWRUlo?=
 =?utf-8?B?MXk4UlRMWlhZS2NRRlA3T3Y1ZVZVT0dxYWxZMVF1d0MzVk9iY21oT2N1bkEx?=
 =?utf-8?B?TmFiY0VPRENGbWdCZmVoRlhuSWN4R0F5bU1odGI4TUcxUmdLS0xFTjVlL0o4?=
 =?utf-8?B?RXVhaFUzWG1McXpkZmZ5b3ZNMHJNSm9PWkdBSDhXa0pRc05ISGdTcStHWllz?=
 =?utf-8?B?dWdtWHNkaDBEc2hPRWpsbVF5ZFhzQXJkMTQ4d2VWWUwwbTNkS3pKalZBbmor?=
 =?utf-8?B?OE5OMUk5aE12ZlEwSHZSVXpPUFJmSDFJVDVOekxaRnI1WXl5RjZxQm55ZXdw?=
 =?utf-8?B?eERkNkt3czNIUlJkN2VxNHM5VmlIOVNsRWdQNFUwU25OM0xZa0UrWHQ4WEpo?=
 =?utf-8?B?QjFnSDFSOEZramVNUk9iYitMVUdKNGU1VElrZDZvdnJDeUk1Q2NCNC9IcWg1?=
 =?utf-8?B?UWp2ek0vQWZmb1hGYTRVRmlrOTZreUxiUi9FMjI1TWg2V3NhUUpFWFQvTGhE?=
 =?utf-8?B?QTlGL1ZWV0tRazFxNGc2UXc1T2drS3Y5KzlDczBwWDBSRkJ0YnJQV2g4QUdO?=
 =?utf-8?B?VytVVE1pcDVPSExKSTlyUW5hSHVGVTlKeGhUb0VUT3g3M0hRZmNPQTAwVEYx?=
 =?utf-8?B?TjBDcW81Sm1PM1hKUS9sWlp5N3ZUbnFiMHBFL1BmMkJNYWRzS1J4Y0R1cldZ?=
 =?utf-8?B?dng4WnA4OHRjanhvS0J2dVpSd29mTWYxelFMd0pxcG0rZmR6OG96OU40eGZJ?=
 =?utf-8?B?cFB1ZzIwdGNlQXorUlVYZ2NaVStGZEk2ZmI1SUVjUGFlWGFuT0QwVlhNTTFY?=
 =?utf-8?B?eGtDTGhFNHJReU9USE9mdUNKNWNSY2hMNVVKOWl1UVZ5dzM4YlhWMldIdTZU?=
 =?utf-8?B?UzYxN2UwU1pNU2syM0lva3hDUk9sd2dabVRKWFNkbzlaeVlEQkxKSVlsK1Zw?=
 =?utf-8?B?OHJDMkxub2ZRN1FNaG1qdnBYV1lSNDVuV2NzS1VIQ2UwcTFSZUlGYmRyQ2Fi?=
 =?utf-8?B?VGxiQlVXbnhLVGZXUlFhMFlwMkRkOUVRL2dxRmpjekdaWXhORFFzYlBScVAy?=
 =?utf-8?B?RnZ6NjNaNEJhUFhPWlN0SmZqYkhYcDA3WVhFQVU3TDd1cEM5M3pHYVNVZnhM?=
 =?utf-8?B?WjJIUGV6YWtaMkhic2N6ejhXVkNmaXZoc1ovZFB6Rk5FTXFZUTFPay9pZlBM?=
 =?utf-8?B?eW9ZRkM1MEMxV3V4d1RSVFo5Mk1OY0hkcGUyVlZwWEVDbFBGS3RLb1FBWHpp?=
 =?utf-8?B?anhQd241aXBoVm5yVGdxZ0tURTZCb1hHWi9BY09uUlFQUXlwQklyWkxyZENz?=
 =?utf-8?B?eUdIRStYa01lWi84UE55bkdCVHFEc3lZblBrZkpSWWYvZXZhZEphaVRXRTBu?=
 =?utf-8?B?Nk9BOWQyVmYzQkp5R2lkR1N1QWFjUGZnQVc3YXZkcGhjd0xvMTkzOUVNRExH?=
 =?utf-8?B?Zjc4VUJRSDNLVEFqTW9zOXFMbExSS3hoNytQYk0vTmhkWDNjdGN2TUhsL2dB?=
 =?utf-8?B?OUk5MVJYZk9NQWxpN1RTVU1sc0VNbUFjazBiTmdWRW1Gd3RQZWlaaFR4VTlr?=
 =?utf-8?B?VTFsd1BrS1htYVlCc05QL2thUCsxMmQ0YzZ2VzNrM3B3dUJNRFdUVWN4bVBS?=
 =?utf-8?B?bmdIRG1RY0QvUjlFTjlPT1lGYXlsVVI5L1U3Rm04dXVjU2FtckxQT2pla21r?=
 =?utf-8?Q?HVE1oIYKfPlKSK+gzPdbzt1gG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71014bf0-d40b-4292-5924-08da84c144ec
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4621.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 04:38:04.9990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VI0XJonYrRzNfXpYc97CJQt8Kj4tOk5O7mbFEFhWTY+nMcxX2BKZXl/pNZ8RJoyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0178
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



On 8/23/2022 7:32 AM, Kenneth Feng wrote:
> For runtime pm case:
> 1. prompt in dmesg for BAMACO feature test
> 2. set BACO by defatul and the user can select BAMACO
> 
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  3 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  7 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/soc21.c            |  1 +
>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 23 +++++++++++++++++++
>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 +++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  1 +
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 17 +++++++++++++-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  1 +
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
>   14 files changed, 83 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 1372e2b47541..104bb62db830 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -598,6 +598,7 @@ struct amdgpu_asic_funcs {
>   	uint64_t (*get_pcie_replay_count)(struct amdgpu_device *adev);
>   	/* device supports BACO */
>   	bool (*supports_baco)(struct amdgpu_device *adev);
> +	bool (*supports_maco)(struct amdgpu_device *adev);
>   	/* pre asic_init quirks */
>   	void (*pre_asic_init)(struct amdgpu_device *adev);
>   	/* enter/exit umd stable pstate */
> @@ -1289,6 +1290,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>   #define amdgpu_asic_need_reset_on_init(adev) (adev)->asic_funcs->need_reset_on_init((adev))
>   #define amdgpu_asic_get_pcie_replay_count(adev) ((adev)->asic_funcs->get_pcie_replay_count((adev)))
>   #define amdgpu_asic_supports_baco(adev) (adev)->asic_funcs->supports_baco((adev))
> +#define amdgpu_asic_supports_maco(adev) (adev)->asic_funcs->supports_maco((adev))
>   #define amdgpu_asic_pre_asic_init(adev) (adev)->asic_funcs->pre_asic_init((adev))
>   #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
>   	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
> @@ -1329,6 +1331,7 @@ bool amdgpu_device_supports_px(struct drm_device *dev);
>   bool amdgpu_device_supports_boco(struct drm_device *dev);
>   bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
>   bool amdgpu_device_supports_baco(struct drm_device *dev);
> +bool amdgpu_device_supports_maco(struct drm_device *dev);
>   bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   				      struct amdgpu_device *peer_adev);
>   int amdgpu_device_baco_enter(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ebb722811dcf..a034295fae71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -272,6 +272,13 @@ bool amdgpu_device_supports_baco(struct drm_device *dev)
>   	return amdgpu_asic_supports_baco(adev);
>   }
>   
> +bool amdgpu_device_supports_maco(struct drm_device *dev)
> +{
> +	struct amdgpu_device *adev = drm_to_adev(dev);
> +
> +	return amdgpu_asic_supports_maco(adev);
> +}
> +
>   /**
>    * amdgpu_device_supports_smart_shift - Is the device dGPU with
>    * smart shift support
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 95bce47943bb..4c022785ded1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -171,13 +171,19 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>   				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>   			break;
>   		default:
> -			/* enable BACO as runpm mode on CI+ */
> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			/* enable BACO/BAMACO as runpm mode on CI+ */
> +			if (amdgpu_runtime_pm == 2 && amdgpu_device_supports_maco(dev))
> +				adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +			else
> +				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>   			break;
>   		}
>   
>   		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>   			dev_info(adev->dev, "Using BACO for runtime pm\n");

Better to use else to join these two
> +
> +		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
> +			dev_info(adev->dev, "Using BAMACO for runtime pm\n");
>   	}
>   
>   	/* Call ACPI methods: require modeset init
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index b067ce45d226..b363c729b9b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2374,7 +2374,8 @@ static int psp_load_smu_fw(struct psp_context *psp)
>   	 * Skip SMU FW reloading in case of using BACO for runpm only,
>   	 * as SMU is always alive.
>   	 */
> -	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
> +	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO ||
> +						   adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO))
>   		return 0;
>   
>   	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 1ff7fc7bb340..f21653fbe69c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -511,6 +511,7 @@ static const struct amdgpu_asic_funcs soc21_asic_funcs =
>   	.need_reset_on_init = &soc21_need_reset_on_init,
>   	.get_pcie_replay_count = &soc21_get_pcie_replay_count,
>   	.supports_baco = &amdgpu_dpm_is_baco_supported,
> +	.supports_maco = &amdgpu_dpm_is_maco_supported,
>   	.pre_asic_init = &soc21_pre_asic_init,
>   	.query_video_codecs = &soc21_query_video_codecs,
>   };
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 7e3231c2191c..43635d238451 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -389,6 +389,7 @@ struct amd_pm_funcs {
>   	int (*set_hard_min_fclk_by_freq)(void *handle, uint32_t clock);
>   	int (*set_min_deep_sleep_dcefclk)(void *handle, uint32_t clock);
>   	int (*get_asic_baco_capability)(void *handle, bool *cap);
> +	int (*get_asic_maco_capability)(void *handle, bool *cap);
>   	int (*get_asic_baco_state)(void *handle, int *state);
>   	int (*set_asic_baco_state)(void *handle, int state);
>   	int (*get_ppfeature_status)(void *handle, char *buf);
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 956b6ce81c84..b3e373046928 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -209,6 +209,29 @@ bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>   	return ret ? false : baco_cap;
>   }
>   
> +bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev)
> +{
> +	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> +	void *pp_handle = adev->powerplay.pp_handle;
> +	bool maco_cap;
> +	int ret = 0;
> +
> +	if (!pp_funcs || !pp_funcs->get_asic_maco_capability)
> +		return false;
> +
> +	if (adev->in_s3)
> +		return false;
> +
> +	mutex_lock(&adev->pm.mutex);
> +
> +	ret = pp_funcs->get_asic_maco_capability(pp_handle,
> +						 &maco_cap);
> +
> +	mutex_unlock(&adev->pm.mutex);
> +
> +	return ret ? false : maco_cap;
> +}
> +
>   int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev)
>   {
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 65624d091ed2..911a293d95b2 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -50,6 +50,7 @@ enum amdgpu_runpm_mode {
>   	AMDGPU_RUNPM_PX,
>   	AMDGPU_RUNPM_BOCO,
>   	AMDGPU_RUNPM_BACO,
> +	AMDGPU_RUNPM_BAMACO,
>   };
>   
>   struct amdgpu_ps {
> @@ -388,6 +389,7 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
>   int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
>   
>   bool amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev);
> +bool amdgpu_dpm_is_maco_supported(struct amdgpu_device *adev);
>   
>   bool amdgpu_dpm_is_mode1_reset_supported(struct amdgpu_device *adev);
>   int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 7510d470b864..11e611edb874 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2723,6 +2723,21 @@ static int smu_get_baco_capability(void *handle, bool *cap)
>   	return 0;
>   }
>   
> +static int smu_get_maco_capability(void *handle, bool *cap)
> +{
> +	struct smu_context *smu = handle;
> +
> +	*cap = false;
> +
> +	if (!smu->pm_enabled)
> +		return 0;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->maco_is_support)
> +		*cap = smu->ppt_funcs->maco_is_support(smu);
> +
> +	return 0;
> +}
> +
>   static int smu_baco_set_state(void *handle, int state)
>   {
>   	struct smu_context *smu = handle;
> @@ -2984,6 +2999,7 @@ static const struct amd_pm_funcs swsmu_pm_funcs = {
>   	.set_active_display_count         = smu_set_display_count,
>   	.set_min_deep_sleep_dcefclk       = smu_set_deep_sleep_dcefclk,
>   	.get_asic_baco_capability         = smu_get_baco_capability,
> +	.get_asic_maco_capability         = smu_get_maco_capability,
>   	.set_asic_baco_state              = smu_baco_set_state,
>   	.get_ppfeature_status             = smu_sys_get_pp_feature_mask,
>   	.set_ppfeature_status             = smu_sys_set_pp_feature_mask,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index b81c657c7386..6bd5777b8780 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -1134,6 +1134,7 @@ struct pptable_funcs {
>   	 * @baco_is_support: Check if GPU supports BACO (Bus Active, Chip Off).
>   	 */
>   	bool (*baco_is_support)(struct smu_context *smu);
> +	bool (*maco_is_support)(struct smu_context *smu);
>   
>   	/**
>   	 * @baco_get_state: Get the current BACO state.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 6fe2fe92ebd7..f2f76fac28ea 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -218,6 +218,7 @@ int smu_v13_0_get_max_sustainable_clocks_by_dc(struct smu_context *smu,
>   					       struct pp_smu_nv_clock_table *max_clocks);
>   
>   bool smu_v13_0_baco_is_support(struct smu_context *smu);
> +bool smu_v13_0_maco_is_support(struct smu_context *smu);
>   
>   enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu);
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 3651f6f75068..6db051eb6aa5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -2278,6 +2278,21 @@ bool smu_v13_0_baco_is_support(struct smu_context *smu)
>   	return true;
>   }
>   
> +bool smu_v13_0_maco_is_support(struct smu_context *smu)
> +{
> +	struct smu_baco_context *smu_baco = &smu->smu_baco;
> +
> +	if (amdgpu_sriov_vf(smu->adev) ||
> +	    !smu_baco->maco_support)
> +		return false;
> +
> +	if (smu_cmn_feature_is_supported(smu, SMU_FEATURE_BACO_BIT) &&
> +	    !smu_cmn_feature_is_enabled(smu, SMU_FEATURE_BACO_BIT))
> +		return false;
> +
> +	return true;
> +}
> +
>   enum smu_baco_state smu_v13_0_baco_get_state(struct smu_context *smu)
>   {
>   	struct smu_baco_context *smu_baco = &smu->smu_baco;
> @@ -2298,7 +2313,7 @@ int smu_v13_0_baco_set_state(struct smu_context *smu,
>   	if (state == SMU_BACO_STATE_ENTER) {
>   		ret = smu_cmn_send_smc_msg_with_param(smu,
>   						      SMU_MSG_EnterBaco,
> -						      smu_baco->maco_support ?
> +						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
>   						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,

If the intention is to use BAMACO only for run pm and use BACO for other 
cases like regular suspend/reset through BACO, this will need in_runpm 
check as well.

Thanks,
Lijo

>   						      NULL);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index df4a47acd724..28d54e671a1a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1845,6 +1845,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
>   	.deep_sleep_control = smu_v13_0_deep_sleep_control,
>   	.gfx_ulv_control = smu_v13_0_gfx_ulv_control,
>   	.baco_is_support = smu_v13_0_baco_is_support,
> +	.maco_is_support = smu_v13_0_maco_is_support,
>   	.baco_get_state = smu_v13_0_baco_get_state,
>   	.baco_set_state = smu_v13_0_baco_set_state,
>   	.baco_enter = smu_v13_0_baco_enter,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 1016d1c216d8..459a6096e552 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1632,6 +1632,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
>   	.baco_is_support = smu_v13_0_baco_is_support,
> +	.maco_is_support = smu_v13_0_maco_is_support,
>   	.baco_get_state = smu_v13_0_baco_get_state,
>   	.baco_set_state = smu_v13_0_baco_set_state,
>   	.baco_enter = smu_v13_0_baco_enter,
> 
