Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9D4C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 21:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92D86E245;
	Mon, 29 Nov 2021 21:46:53 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E57866E3C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 21:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc9u7e/D9+lQtqJ8R70kBG8i5xg9LM2Aq7h/oFgFqGk9NhIjguQ68E/kgUJEI7VUzq1hs1ZiDpjL4o4/BGtcmKmVo7s1mMPMJnYQGV9imu2ElAISxfXNMBIULsUjOzv2M57Bz7kvcjPAaR5WN3pfgDZYN31XM2totvr4179o+M1nNHOLUIEa1Zh/oLGDBs62IKP/EXciflsyact8eF4IeFQG/oI+2b+VGP0a70bgzmYiXkgWD57czXBIGjVC09NonN4DNK7lYGL1YMy++7ktL2tMdQfcPifzNZFiRxjM0/ghK0C1tYscdsmSbp2LodvEAySyetsF38vHpFwHYTH5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYoxFaXnxtmed2+1ImRk9nkq5GXJB6mf6tZhCXZa76w=;
 b=OHhEhxG+swAiVYBG1K4Mxtiq0kPUTsmGfA0gK+S26W4tZcTlgzNqhmAhd8ksvgmhmkRDyunRbENesHGgdfabTJOc2XIoWOEawQp/qY2AC0905v/IXjNX+LgeWt4YfoaM7sHYwk3fCX5acaeQHDSjknFL7iE0N6oaHjYEK7xKBSc3EcIqRL9qjbxF8ctHxVlEYlh82ESBNKyoMIqBKyuU5vlBVZHOMcCDei2jF0e27T0DcijnUE6KzXt+AS2jqwQtRNgW+3vy6B0sHKtgv7xAIbj+5g+svKH17aRb5dEjAyqPJvWAdcTaP7bEsEmPP7uwJt/MTTDxRZF/HZcJDfaJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYoxFaXnxtmed2+1ImRk9nkq5GXJB6mf6tZhCXZa76w=;
 b=VYWFlRuvjx+e7GX2X7qQenwMrziBpF3uHVdh+3h7cG6t3hQ804bHRlvflOzLCaV8XQ13nZVXEUqPaYkGyMnAvkH8nG6kssCCdAtmi/nTqDEuQOzY0hSLMxU1BvWxVYrNV5I9i7ahZMiTlowreM12o+bMeTO7c8lBHU75XF4X8Co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5099.namprd12.prod.outlook.com (2603:10b6:408:118::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 21:46:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 21:46:50 +0000
Subject: Re: [PATCH v3 2/3] drm/amdkfd: add kfd_device_info_init function
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211129145942.3542707-1-Graham.Sider@amd.com>
 <20211129145942.3542707-2-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <38a1bea5-7efd-bc91-4120-e8cc676caab4@amd.com>
Date: Mon, 29 Nov 2021 16:46:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211129145942.3542707-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT3PR01CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21 via Frontend Transport; Mon, 29 Nov 2021 21:46:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 603d4748-cb0e-4662-2deb-08d9b381bfcf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5099:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5099FF68F7AAF144174C109D92669@BN9PR12MB5099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEoYksglnEN0WO5MMnX3aTsw4UMM4WwSpbCATSrZ2GMuLs//gVs3iFQqbo/eoc2h9AuXh0ZUZtNNrhyCHXadOuxLgHEBe/750uUpLVmK8qgfsiMga5lUSaddpwjJYBMUqDzucEYOjqVbKVgZTf03zxWqKBydladRv5DijAyQkZ6Tz3FbXk6GxzN60SHrgZYMP3FRwPmiI4kNoro8ZoFIPZuZV56PRLcUlWeOeUiVVpHmS+AwDbsVO8bIfutz+YuaBry9j7siesOLks8joM4dUb5a4SJ0J1sgbsuR3gY8mxhcY8smXnZTQDogYCOjNjnVjFIPr3lh0w8vRZdC0MXxaKbaWccjK4FJTv0TXD7lfWCPOfowTj3FWEXtJ+0bemVp+Iz+jdzIfHDwJN4kn/ABQY19QzI6l+cK06zdnvDaoPdFQzXvHbyjCF2aDqDuHLJsSkQ9zDstbuFflhokaC7rupVrS5P8wmRYhtjEWf4LCDusWW9RBH+Faf+t2oAYYblN1UzltoAadWGdr8olt4n6sakKARD76YyGEfkeDsKGBTiZrzNm68f7F1raCASoqunp0sRbv8DA5NygMMAnzzwcOeQ/f4fpDeyZuT0JwLJ8RtvorUncO0wCbXt6PXTYPx6ZVQvwz3A0+qniuoDdtqNSjVueS4lVHC4BrPXbzlUalhdmjmWc0MhNhjojt6t2F9azbswDZHhwNKEG7tzJEgohvEvgZpEvGAi0GS+mZNcP+oHqsoNMbhKmXzdFn94z29Hx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(5660300002)(36756003)(2906002)(86362001)(31696002)(8676002)(66946007)(316002)(4001150100001)(186003)(508600001)(38100700002)(16576012)(2616005)(956004)(26005)(66556008)(66476007)(30864003)(8936002)(83380400001)(44832011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snp2UmhSQVBSQ3RLaFFqb1g2SklPUmhxL2JBak5CNEpGUWxTWVRodlFZQ0c5?=
 =?utf-8?B?RzYrbkVJT25NQVVJcFRhbFNxRmd3dlUybzI4TFBIOFlkZjJhRlppMDdoNmU5?=
 =?utf-8?B?ZTZPVG02cFdsaU1ROFo2SVhoakZwZUpwT3pQM3FNdUNYcnlqeENmNlhxV1Vh?=
 =?utf-8?B?S1RNKzl4ZTZ0bHRSVVFvV0ZWN0k0MUY3QW1WUThtd3RHRjJEdFRzeXh2cW1k?=
 =?utf-8?B?VFB0QkcwQVYzdkgwaFFIUG9QZlpRUllSZW5TOS9QLy80YWYxOUZTTUtGc0pn?=
 =?utf-8?B?U2YzbTAwQWM1ZUVzVXpDZ09tSnRFdkFwMit6N09SN3V5eWZJYVc5K3lUWWhZ?=
 =?utf-8?B?Z29DeEcybGtDanpUb0o0V3VCTU9HellyWjZSOFVQNWFXMkY4eVc4RnY1K3Ns?=
 =?utf-8?B?OXRjSDJNejhXWXNGemRuUzl5S2psdVVnZlhVM2dhNDFYUVZ0MnJNVnNtSVJZ?=
 =?utf-8?B?dDlKUnpsTzMrdzVoclI0MXVIb1pEL1ZEZXNtY2o4ak1yRGpvbmd5T1F6ZGZL?=
 =?utf-8?B?SmJkWkRleStENWttZk1YYUg5QmNwMUkxZXFXcnFhWmI2eVJaWjk5NkhLdUVj?=
 =?utf-8?B?M2lJelorNlBGSjJVRlFZTER0N09OdFVMVkpHaStkUkVJcUVrSXVxUG9LWkRr?=
 =?utf-8?B?Q01XNnlBeTF3cjArZ09lZ2tpUWs1TEpERkRsY0NnRTVVa0tYdWRVa1JOVyty?=
 =?utf-8?B?a1B2TjRjUUFrTklsQXVzZWx1OE40c0hnMzJMdWhqRWdLWE9Yd0ltZGNSRXhk?=
 =?utf-8?B?S0hKNjFSTWhSRFdxdGNJeU1HSk5JUDVydndEUjhjR04xV0NidEtwRWZyaVB1?=
 =?utf-8?B?bGp4V2lweDUxNFkvMEUrUFFTUnQ1TlJQRFFWajgrc2NvcW1OaEd3Z28rQmla?=
 =?utf-8?B?QUNGK3RpY3dDc1lBcG5oZTBSTjlXdFdDbXQvckR0TzlOeEpZM0lOWWh5TTR2?=
 =?utf-8?B?TWtXZFVBUVA2dmZEZUZZNGtnbGZTcDlmb0RKR2QvUXNWcURFbDBLaXFXM3Rs?=
 =?utf-8?B?RnR1YmU5VjNNb3pLaUVoVE5vSWgwbmZwVWMwSlNwNkUySWF6T29MNzY4czNW?=
 =?utf-8?B?SE9LQTFPcjlHRmxnYXZkQ2lmYUwrSlMwQ09YMTJHVFYzRzMvY1pMM3F5KzJO?=
 =?utf-8?B?MCtnVDg5M2JRQjRGNTA1YURtd2kwQjRvLzRTcGl1WXR2U2Rxdld1OTQwV0Mr?=
 =?utf-8?B?VU05RXRjODAzY1dIYWRUWkhIREYxQVpKUmtKUitLc0U1MGxiWFc1WGZlL0g5?=
 =?utf-8?B?YW14T1ByU0xSdkUwSzM1bW1iUGRkb0xLMzQ0SW1NYlljYnJqcmcrWTBmMmRv?=
 =?utf-8?B?UEY1b1hSeEhld0dKTi84K0JwbWFuY0dNbjhJK2t2RDBLYkErWnJ0bHpMeHNo?=
 =?utf-8?B?MkpBTFlpNzR2SlN1Q1pQengzTWoxTUpENE9aOS93T05EYWVaNVFER0lJenZn?=
 =?utf-8?B?R2dWaWZBbTBYSllMbGpVWnhGRytucEZMOXpXYUlsR3RrcklnZE1xaWh5Tkg2?=
 =?utf-8?B?MDl3b3RodmRPY2Q5MHFkUTRZVWZpVlkwNytUZ0MyajBsZ1pnRHo4T0FUa0Qz?=
 =?utf-8?B?azV0NlZCcXBMZ2RvL2E0VWRRV2taaHRDNkdpMkxFVE1NeFFHbnZyckpWWFdl?=
 =?utf-8?B?cFdoVEpuRGRiNDRKb2UybWgzTkp6MFNTU293NGwzVytQdHpkSzg3L2hOVURw?=
 =?utf-8?B?bW5aTXRxNDN6TkI4S1JEcWt5Rk53VXF0cCtOM0pIUFRySkVXL202Y2tkcUtU?=
 =?utf-8?B?YTB1blRRVWxqbGg3Tmk5ekNVTWcxMEE0TFNqNFp2SEx2ekU2cjZhRmRkMXFH?=
 =?utf-8?B?ZnlCSThNSXpYOU1mVGZsaHFXV3pyaDJUSksxdEtZZTE4T0xtekNNc2w3WmVO?=
 =?utf-8?B?UStldlkyQ0I2MlRHbXhaUWpscnpFako4MC9vK1RxdktiQ3ZKMlFKQlNGc25M?=
 =?utf-8?B?K25Ja1oyN1JRdWtURzBYVmFCdFArSWRVWGQ5Wmg1elFUM0NhVk16eGdwRzNz?=
 =?utf-8?B?SkxOR0FuSnBkbHh0ZHFtM1RXWnhmWHlDaVF1S2tmSW1hMVA3SHU5KysxcGdP?=
 =?utf-8?B?a1E3dkZHeDd4b01hVGN3ZWU3RjVhS3FLZlZKdDJ1bXFnbTRZNitWSU84cTBy?=
 =?utf-8?B?bmt5YUJKTkJCdTNXL3NndUZ6VFViTklTSTlhMEtzcnJMTjNlM3ZOQmVoN1RF?=
 =?utf-8?Q?mnEEGbpzW3jDR5t+k0SBZN8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603d4748-cb0e-4662-2deb-08d9b381bfcf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 21:46:50.1895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shUPFEIKs335WmS8wKVUxmENWP+KzUqiISWgsRcHDhFnlavUVFypZAZ0dANtwcLyYZTwJgrusHHuxBW487X+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5099
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


Am 2021-11-29 um 9:59 a.m. schrieb Graham Sider:
> Initializes kfd->device_info given either asic_type (enum) if GFX
> version is less than GFX9, or GC IP version if greater. Also takes in vf
> and the target compiler gfx version. Uses SDMA version to determine
> num_sdma_queues_per_engine.
>
> Convert device_info to a non-pointer member of kfd, change references
> accordingly.
>
> Change unsupported asic condition to only probe f2g, move device_info
> initialization post-switch.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

One minor nit-pick inline. Other than that the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 247 ++++++++++--------
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     |   8 +-
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c    |  18 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |   6 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   2 +-
>  .../amd/amdkfd/kfd_process_queue_manager.c    |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |   8 +-
>  11 files changed, 164 insertions(+), 141 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e11fc4e20c32..5e50667cb665 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -511,193 +511,215 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>  
>  static int kfd_resume(struct kfd_dev *kfd);
>  
> +static void kfd_device_info_init(struct kfd_dev *kfd,
> +				 bool vf, uint32_t gfx_target_version)
> +{
> +	uint32_t gc_version = KFD_GC_VERSION(kfd);
> +	uint32_t sdma_version = kfd->adev->ip_versions[SDMA0_HWIP][0];
> +	uint32_t asic_type = kfd->adev->asic_type;
> +
> +	kfd->device_info.max_pasid_bits = 16;
> +	kfd->device_info.max_no_of_hqd = 24;
> +	kfd->device_info.num_of_watch_points = 4;
> +	kfd->device_info.mqd_size_aligned = MQD_SIZE_ALIGNED;
> +	kfd->device_info.gfx_target_version = gfx_target_version;
> +
> +	if (KFD_IS_SOC15(kfd)) {
> +		kfd->device_info.doorbell_size = 8;
> +		kfd->device_info.ih_ring_entry_size = 8 * sizeof(uint32_t);
> +		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
> +		kfd->device_info.supports_cwsr = true;
> +
> +		if ((sdma_version >= IP_VERSION(4, 0, 0)  &&
> +		     sdma_version <= IP_VERSION(4, 2, 0)) ||
> +		     sdma_version == IP_VERSION(5, 2, 1)  ||
> +		     sdma_version == IP_VERSION(5, 2, 3))
> +			kfd->device_info.num_sdma_queues_per_engine = 2;
> +		else
> +			kfd->device_info.num_sdma_queues_per_engine = 8;
> +
> +		/* Raven */
> +		if (gc_version == IP_VERSION(9, 1, 0) ||
> +		    gc_version == IP_VERSION(9, 2, 2))
> +			kfd->device_info.needs_iommu_device = true;
> +
> +		if (gc_version < IP_VERSION(11, 0, 0)) {
> +			/* Navi2x+, Navi1x+ */
> +			if (gc_version >= IP_VERSION(10, 3, 0))
> +				kfd->device_info.no_atomic_fw_version = 145;
> +			else if (gc_version >= IP_VERSION(10, 1, 1))
> +				kfd->device_info.no_atomic_fw_version = 92;
> +
> +			/* Navi1x+ */
> +			if (gc_version >= IP_VERSION(10, 1, 1))
> +				kfd->device_info.needs_pci_atomics = true;
> +		}
> +	} else {
> +		kfd->device_info.doorbell_size = 4;
> +		kfd->device_info.ih_ring_entry_size = 4 * sizeof(uint32_t);
> +		kfd->device_info.event_interrupt_class = &event_interrupt_class_cik;
> +		kfd->device_info.num_sdma_queues_per_engine = 2;
> +
> +		if (asic_type != CHIP_KAVERI &&
> +		    asic_type != CHIP_HAWAII &&
> +		    asic_type != CHIP_TONGA)
> +			kfd->device_info.supports_cwsr = true;
> +
> +		if (asic_type == CHIP_KAVERI ||
> +		    asic_type == CHIP_CARRIZO)
> +			kfd->device_info.needs_iommu_device = true;
> +
> +		if (asic_type != CHIP_HAWAII && !vf)
> +			kfd->device_info.needs_pci_atomics = true;
> +	}
> +}
> +
>  struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>  {
> -	struct kfd_dev *kfd;
> -	const struct kfd_device_info *device_info;
> -	const struct kfd2kgd_calls *f2g;
> +	struct kfd_dev *kfd = NULL;
> +	const struct kfd2kgd_calls *f2g = NULL;
>  	struct pci_dev *pdev = adev->pdev;
> +	uint32_t gfx_target_version = 0;
>  
>  	switch (adev->asic_type) {
>  #ifdef KFD_SUPPORT_IOMMU_V2
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  	case CHIP_KAVERI:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &kaveri_device_info;
> -		f2g = &gfx_v7_kfd2kgd;
> +		gfx_target_version = 70000;
> +		if (!vf)
> +			f2g = &gfx_v7_kfd2kgd;
>  		break;
>  #endif
>  	case CHIP_CARRIZO:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &carrizo_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80001;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>  		break;
>  #endif
>  #ifdef CONFIG_DRM_AMDGPU_CIK
>  	case CHIP_HAWAII:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &hawaii_device_info;
> -		f2g = &gfx_v7_kfd2kgd;
> +		gfx_target_version = 70001;
> +		if (!vf)
> +			f2g = &gfx_v7_kfd2kgd;
>  		break;
>  #endif
>  	case CHIP_TONGA:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &tonga_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80002;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>  		break;
>  	case CHIP_FIJI:
> -		if (vf)
> -			device_info = &fiji_vf_device_info;
> -		else
> -			device_info = &fiji_device_info;
> +		gfx_target_version = 80003;
>  		f2g = &gfx_v8_kfd2kgd;
>  		break;
>  	case CHIP_POLARIS10:
> -		if (vf)
> -			device_info = &polaris10_vf_device_info;
> -		else
> -			device_info = &polaris10_device_info;
> +		gfx_target_version = 80003;
>  		f2g = &gfx_v8_kfd2kgd;
>  		break;
>  	case CHIP_POLARIS11:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &polaris11_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80003;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>  		break;
>  	case CHIP_POLARIS12:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &polaris12_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80003;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>  		break;
>  	case CHIP_VEGAM:
> -		if (vf)
> -			device_info = NULL;
> -		else
> -			device_info = &vegam_device_info;
> -		f2g = &gfx_v8_kfd2kgd;
> +		gfx_target_version = 80003;
> +		if (!vf)
> +			f2g = &gfx_v8_kfd2kgd;
>  		break;
>  	default:
>  		switch (adev->ip_versions[GC_HWIP][0]) {
>  		case IP_VERSION(9, 0, 1):
> -			if (vf)
> -				device_info = &vega10_vf_device_info;
> -			else
> -				device_info = &vega10_device_info;
> +			gfx_target_version = 90000;
>  			f2g = &gfx_v9_kfd2kgd;
>  			break;
>  #ifdef KFD_SUPPORT_IOMMU_V2
>  		case IP_VERSION(9, 1, 0):
>  		case IP_VERSION(9, 2, 2):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &raven_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90002;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>  			break;
>  #endif
>  		case IP_VERSION(9, 2, 1):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &vega12_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90004;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>  			break;
>  		case IP_VERSION(9, 3, 0):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &renoir_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90012;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>  			break;
>  		case IP_VERSION(9, 4, 0):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &vega20_device_info;
> -			f2g = &gfx_v9_kfd2kgd;
> +			gfx_target_version = 90006;
> +			if (!vf)
> +				f2g = &gfx_v9_kfd2kgd;
>  			break;
>  		case IP_VERSION(9, 4, 1):
> -			device_info = &arcturus_device_info;
> +			gfx_target_version = 90008;
>  			f2g = &arcturus_kfd2kgd;
>  			break;
>  		case IP_VERSION(9, 4, 2):
> -			device_info = &aldebaran_device_info;
> +			gfx_target_version = 90010;
>  			f2g = &aldebaran_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 1, 10):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &navi10_device_info;
> -			f2g = &gfx_v10_kfd2kgd;
> +			gfx_target_version = 100100;
> +			if (!vf)
> +				f2g = &gfx_v10_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 1, 2):
> -			device_info = &navi12_device_info;
> +			gfx_target_version = 100101;
>  			f2g = &gfx_v10_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 1, 1):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &navi14_device_info;
> -			f2g = &gfx_v10_kfd2kgd;
> +			gfx_target_version = 100102;
> +			if (!vf)
> +				f2g = &gfx_v10_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 1, 3):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &cyan_skillfish_device_info;
> -			f2g = &gfx_v10_kfd2kgd;
> +			gfx_target_version = 100103;
> +			if (!vf)
> +				f2g = &gfx_v10_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 3, 0):
> -			device_info = &sienna_cichlid_device_info;
> +			gfx_target_version = 100300;
>  			f2g = &gfx_v10_3_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 3, 2):
> -			device_info = &navy_flounder_device_info;
> +			gfx_target_version = 100301;
>  			f2g = &gfx_v10_3_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 3, 1):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &vangogh_device_info;
> -			f2g = &gfx_v10_3_kfd2kgd;
> +			gfx_target_version = 100303;
> +			if (!vf)
> +				f2g = &gfx_v10_3_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 3, 4):
> -			device_info = &dimgrey_cavefish_device_info;
> +			gfx_target_version = 100302;
>  			f2g = &gfx_v10_3_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 3, 5):
> -			device_info = &beige_goby_device_info;
> +			gfx_target_version = 100304;
>  			f2g = &gfx_v10_3_kfd2kgd;
>  			break;
>  		case IP_VERSION(10, 3, 3):
> -			if (vf)
> -				device_info = NULL;
> -			else
> -				device_info = &yellow_carp_device_info;
> -			f2g = &gfx_v10_3_kfd2kgd;
> +			gfx_target_version = 100305;
> +			if (!vf)
> +				f2g = &gfx_v10_3_kfd2kgd;
>  			break;
>  		default:
> -			return NULL;
> +			break;
>  		}
>  		break;
>  	}
>  
> -	if (!device_info || !f2g) {
> +	if (!f2g) {
>  		if (adev->ip_versions[GC_HWIP][0])
>  			dev_err(kfd_device, "GC IP %06x %s not supported in kfd\n",
>  				adev->ip_versions[GC_HWIP][0], vf ? "VF" : "");
> @@ -712,7 +734,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>  		return NULL;
>  
>  	kfd->adev = adev;
> -	kfd->device_info = device_info;
> +	kfd_device_info_init(kfd, vf, gfx_target_version);
>  	kfd->pdev = pdev;
>  	kfd->init_complete = false;
>  	kfd->kfd2kgd = f2g;
> @@ -731,7 +753,7 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>  
>  static void kfd_cwsr_init(struct kfd_dev *kfd)
>  {
> -	if (cwsr_enable && kfd->device_info->supports_cwsr) {
> +	if (cwsr_enable && kfd->device_info.supports_cwsr) {
>  		if (KFD_GC_VERSION(kfd) < IP_VERSION(9, 0, 1)) {
>  			BUILD_BUG_ON(sizeof(cwsr_trap_gfx8_hex) > PAGE_SIZE);
>  			kfd->cwsr_isa = cwsr_trap_gfx8_hex;
> @@ -815,14 +837,14 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	 */
>  	kfd->pci_atomic_requested = amdgpu_amdkfd_have_atomics_support(kfd->adev);
>  	if (!kfd->pci_atomic_requested &&
> -	    kfd->device_info->needs_pci_atomics &&
> -	    (!kfd->device_info->no_atomic_fw_version ||
> -	     kfd->mec_fw_version < kfd->device_info->no_atomic_fw_version)) {
> +	    kfd->device_info.needs_pci_atomics &&
> +	    (!kfd->device_info.no_atomic_fw_version ||
> +	     kfd->mec_fw_version < kfd->device_info.no_atomic_fw_version)) {
>  		dev_info(kfd_device,
>  			 "skipped device %x:%x, PCI rejects atomics %d<%d\n",
>  			 kfd->pdev->vendor, kfd->pdev->device,
>  			 kfd->mec_fw_version,
> -			 kfd->device_info->no_atomic_fw_version);
> +			 kfd->device_info.no_atomic_fw_version);
>  		return false;
>  	}
>  
> @@ -839,7 +861,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  
>  	/* calculate max size of mqds needed for queues */
>  	size = max_num_of_queues_per_device *
> -			kfd->device_info->mqd_size_aligned;
> +			kfd->device_info.mqd_size_aligned;
>  
>  	/*
>  	 * calculate max size of runlist packet.
> @@ -979,6 +1001,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>  	}
>  
>  	kfree(kfd);
> +	kfd = NULL;

This seems unrelated and also unnecessary. The "kfd" pointer variable is
about to go out of scope. So changing it to NULL is not going to make
any difference. It's also not going to affect the caller because they
have their own copy of the pointer.

Regards,
  Felix


>  }
>  
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> @@ -1114,7 +1137,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry)
>  	if (!kfd->init_complete)
>  		return;
>  
> -	if (kfd->device_info->ih_ring_entry_size > sizeof(patched_ihre)) {
> +	if (kfd->device_info.ih_ring_entry_size > sizeof(patched_ihre)) {
>  		dev_err_once(kfd_device, "Ring entry too small\n");
>  		return;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 2af2b3268171..dd0b952f0173 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -108,13 +108,13 @@ static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
>  unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
>  {
>  	return kfd_get_num_sdma_engines(dqm->dev) *
> -		dqm->dev->device_info->num_sdma_queues_per_engine;
> +		dqm->dev->device_info.num_sdma_queues_per_engine;
>  }
>  
>  unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm)
>  {
>  	return kfd_get_num_xgmi_sdma_engines(dqm->dev) *
> -		dqm->dev->device_info->num_sdma_queues_per_engine;
> +		dqm->dev->device_info.num_sdma_queues_per_engine;
>  }
>  
>  void program_sh_mem_settings(struct device_queue_manager *dqm,
> @@ -1838,7 +1838,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
>  	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
>  	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
>  		get_num_all_sdma_engines(dqm) *
> -		dev->device_info->num_sdma_queues_per_engine +
> +		dev->device_info.num_sdma_queues_per_engine +
>  		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
>  
>  	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev, size,
> @@ -2082,7 +2082,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
>  
>  	for (pipe = 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
>  		for (queue = 0;
> -		     queue < dqm->dev->device_info->num_sdma_queues_per_engine;
> +		     queue < dqm->dev->device_info.num_sdma_queues_per_engine;
>  		     queue++) {
>  			r = dqm->dev->kfd2kgd->hqd_sdma_dump(
>  				dqm->dev->adev, pipe, queue, &dump, &n_regs);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index 768d153acff4..0dbcf54657ed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -48,7 +48,7 @@
>  /* # of doorbell bytes allocated for each process. */
>  size_t kfd_doorbell_process_slice(struct kfd_dev *kfd)
>  {
> -	return roundup(kfd->device_info->doorbell_size *
> +	return roundup(kfd->device_info.doorbell_size *
>  			KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
>  			PAGE_SIZE);
>  }
> @@ -180,7 +180,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
>  	if (inx >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
>  		return NULL;
>  
> -	inx *= kfd->device_info->doorbell_size / sizeof(u32);
> +	inx *= kfd->device_info.doorbell_size / sizeof(u32);
>  
>  	/*
>  	 * Calculating the kernel doorbell offset using the first
> @@ -201,7 +201,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
>  	unsigned int inx;
>  
>  	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr)
> -		* sizeof(u32) / kfd->device_info->doorbell_size;
> +		* sizeof(u32) / kfd->device_info.doorbell_size;
>  
>  	mutex_lock(&kfd->doorbell_mutex);
>  	__clear_bit(inx, kfd->doorbell_available_index);
> @@ -239,7 +239,7 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
>  	return kfd->doorbell_base_dw_offset +
>  		pdd->doorbell_index
>  		* kfd_doorbell_process_slice(kfd) / sizeof(u32) +
> -		doorbell_id * kfd->device_info->doorbell_size / sizeof(u32);
> +		doorbell_id * kfd->device_info.doorbell_size / sizeof(u32);
>  }
>  
>  uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 20512a4e9a91..deb64168c9e8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -135,7 +135,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>  
>  		*patched_flag = true;
>  		memcpy(patched_ihre, ih_ring_entry,
> -				dev->device_info->ih_ring_entry_size);
> +				dev->device_info.ih_ring_entry_size);
>  
>  		pasid = dev->dqm->vmid_pasid[vmid];
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> index bc47f6a44456..81887c2013c9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
> @@ -54,7 +54,7 @@ int kfd_interrupt_init(struct kfd_dev *kfd)
>  	int r;
>  
>  	r = kfifo_alloc(&kfd->ih_fifo,
> -		KFD_IH_NUM_ENTRIES * kfd->device_info->ih_ring_entry_size,
> +		KFD_IH_NUM_ENTRIES * kfd->device_info.ih_ring_entry_size,
>  		GFP_KERNEL);
>  	if (r) {
>  		dev_err(kfd_chardev(), "Failed to allocate IH fifo\n");
> @@ -114,8 +114,8 @@ bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry)
>  	int count;
>  
>  	count = kfifo_in(&kfd->ih_fifo, ih_ring_entry,
> -				kfd->device_info->ih_ring_entry_size);
> -	if (count != kfd->device_info->ih_ring_entry_size) {
> +				kfd->device_info.ih_ring_entry_size);
> +	if (count != kfd->device_info.ih_ring_entry_size) {
>  		dev_err_ratelimited(kfd_chardev(),
>  			"Interrupt ring overflow, dropping interrupt %d\n",
>  			count);
> @@ -133,11 +133,11 @@ static bool dequeue_ih_ring_entry(struct kfd_dev *kfd, void *ih_ring_entry)
>  	int count;
>  
>  	count = kfifo_out(&kfd->ih_fifo, ih_ring_entry,
> -				kfd->device_info->ih_ring_entry_size);
> +				kfd->device_info.ih_ring_entry_size);
>  
> -	WARN_ON(count && count != kfd->device_info->ih_ring_entry_size);
> +	WARN_ON(count && count != kfd->device_info.ih_ring_entry_size);
>  
> -	return count == kfd->device_info->ih_ring_entry_size;
> +	return count == kfd->device_info.ih_ring_entry_size;
>  }
>  
>  static void interrupt_wq(struct work_struct *work)
> @@ -146,13 +146,13 @@ static void interrupt_wq(struct work_struct *work)
>  						interrupt_work);
>  	uint32_t ih_ring_entry[KFD_MAX_RING_ENTRY_SIZE];
>  
> -	if (dev->device_info->ih_ring_entry_size > sizeof(ih_ring_entry)) {
> +	if (dev->device_info.ih_ring_entry_size > sizeof(ih_ring_entry)) {
>  		dev_err_once(kfd_chardev(), "Ring entry too small\n");
>  		return;
>  	}
>  
>  	while (dequeue_ih_ring_entry(dev, ih_ring_entry))
> -		dev->device_info->event_interrupt_class->interrupt_wq(dev,
> +		dev->device_info.event_interrupt_class->interrupt_wq(dev,
>  								ih_ring_entry);
>  }
>  
> @@ -163,7 +163,7 @@ bool interrupt_is_wanted(struct kfd_dev *dev,
>  	/* integer and bitwise OR so there is no boolean short-circuiting */
>  	unsigned int wanted = 0;
>  
> -	wanted |= dev->device_info->event_interrupt_class->interrupt_isr(dev,
> +	wanted |= dev->device_info.event_interrupt_class->interrupt_isr(dev,
>  					 ih_ring_entry, patched_ihre, flag);
>  
>  	return wanted != 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index 73f2257acc23..66ad8d0b8f7f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -89,7 +89,7 @@ int kfd_iommu_device_init(struct kfd_dev *kfd)
>  	}
>  
>  	pasid_limit = min_t(unsigned int,
> -			(unsigned int)(1 << kfd->device_info->max_pasid_bits),
> +			(unsigned int)(1 << kfd->device_info.max_pasid_bits),
>  			iommu_info.max_pasids);
>  
>  	if (!kfd_set_pasid_limit(pasid_limit)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 406479a369a9..16f8bc4ca7f6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -111,7 +111,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_dev *dev,
>  	kq->rptr_kernel = kq->rptr_mem->cpu_ptr;
>  	kq->rptr_gpu_addr = kq->rptr_mem->gpu_addr;
>  
> -	retval = kfd_gtt_sa_allocate(dev, dev->device_info->doorbell_size,
> +	retval = kfd_gtt_sa_allocate(dev, dev->device_info.doorbell_size,
>  					&kq->wptr_mem);
>  
>  	if (retval != 0)
> @@ -297,7 +297,7 @@ void kq_submit_packet(struct kernel_queue *kq)
>  	}
>  	pr_debug("\n");
>  #endif
> -	if (kq->dev->device_info->doorbell_size == 8) {
> +	if (kq->dev->device_info.doorbell_size == 8) {
>  		*kq->wptr64_kernel = kq->pending_wptr64;
>  		write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>  					kq->pending_wptr64);
> @@ -310,7 +310,7 @@ void kq_submit_packet(struct kernel_queue *kq)
>  
>  void kq_rollback_packet(struct kernel_queue *kq)
>  {
> -	if (kq->dev->device_info->doorbell_size == 8) {
> +	if (kq->dev->device_info.doorbell_size == 8) {
>  		kq->pending_wptr64 = *kq->wptr64_kernel;
>  		kq->pending_wptr = *kq->wptr_kernel %
>  			(kq->queue->properties.queue_size / 4);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 7b4118915bf6..e2825ad4d699 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -71,7 +71,7 @@ struct kfd_mem_obj *allocate_sdma_mqd(struct kfd_dev *dev,
>  		return NULL;
>  
>  	offset = (q->sdma_engine_id *
> -		dev->device_info->num_sdma_queues_per_engine +
> +		dev->device_info.num_sdma_queues_per_engine +
>  		q->sdma_queue_id) *
>  		dev->dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 0d6d1fe1481b..0c3f911e3bf4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -230,7 +230,7 @@ struct kfd_vmid_info {
>  struct kfd_dev {
>  	struct amdgpu_device *adev;
>  
> -	const struct kfd_device_info *device_info;
> +	struct kfd_device_info device_info;
>  	struct pci_dev *pdev;
>  	struct drm_device *ddev;
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c5f5a25c6dcc..5e5c84a8e1ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -219,7 +219,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>  	 * Hence we also check the type as well
>  	 */
>  	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
> -		max_queues = dev->device_info->max_no_of_hqd/2;
> +		max_queues = dev->device_info.max_no_of_hqd/2;
>  
>  	if (pdd->qpd.queue_count >= max_queues)
>  		return -ENOSPC;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index d6aa27b1ae33..948fbb39336e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -503,7 +503,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  
>  	if (dev->gpu) {
>  		log_max_watch_addr =
> -			__ilog2_u32(dev->gpu->device_info->num_of_watch_points);
> +			__ilog2_u32(dev->gpu->device_info.num_of_watch_points);
>  
>  		if (log_max_watch_addr) {
>  			dev->node_props.capability |=
> @@ -1382,7 +1382,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	dev->node_props.simd_arrays_per_engine =
>  		cu_info.num_shader_arrays_per_engine;
>  
> -	dev->node_props.gfx_target_version = gpu->device_info->gfx_target_version;
> +	dev->node_props.gfx_target_version = gpu->device_info.gfx_target_version;
>  	dev->node_props.vendor_id = gpu->pdev->vendor;
>  	dev->node_props.device_id = gpu->pdev->device;
>  	dev->node_props.capability |=
> @@ -1402,7 +1402,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	dev->node_props.num_sdma_xgmi_engines =
>  					kfd_get_num_xgmi_sdma_engines(gpu);
>  	dev->node_props.num_sdma_queues_per_engine =
> -				gpu->device_info->num_sdma_queues_per_engine;
> +				gpu->device_info.num_sdma_queues_per_engine;
>  	dev->node_props.num_gws = (dev->gpu->gws &&
>  		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
>  		dev->gpu->adev->gds.gws_size : 0;
> @@ -1578,7 +1578,7 @@ void kfd_double_confirm_iommu_support(struct kfd_dev *gpu)
>  
>  	gpu->use_iommu_v2 = false;
>  
> -	if (!gpu->device_info->needs_iommu_device)
> +	if (!gpu->device_info.needs_iommu_device)
>  		return;
>  
>  	down_read(&topology_lock);
