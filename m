Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E6BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 21:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E276E029;
	Fri, 19 Nov 2021 21:20:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032546E029
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 21:20:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzsK+BujcRZ+Tjeaq+Ct7LM6/Qd9cpMJR40J8Js3jbpA9ObcEpCMtgk2heTJSin7hB5NNokz0rCGJLhEl4fOlct3gp0MLbbFrpOqi3FXqRhCDEQ0UoNY9HVx99NuCnqO3aUTGjgOl6F4BMt9xzGzI+ki3T34GKJqtFvm5VfSnIFkNyzApxcGJ+n/s8iVgtfdOL8Js6uVp3JYhabEA9Kcbe0u5ddkbyhn/WjbYICY3t4kmJRssR8iUrXM+01kRI3SzcK470mYdkXYPQpmx32rTEQaGcT+Nh8l/bkMdjfxIXuvVX5ZNna88dj0C1HPMQh19IbIfvBxAnHxqiw4xneQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thl3sr/nWM0v8H7hdi35XKVxyX4k+d/WyYo35QhkAP8=;
 b=inCON8csYq0kz7TKDVYPkDL1aRiWcHvigab3eO19MFvQG3/XON02Vl9HqP/yXe+pxaNE0BNZKPhbn6TzEDUDRR+e/1JqHouR5p1CX7JdxD94SITz5AiOFu4ZgzTQwCEn2OojoW00yw2ptDfCHn/+C9LyToD+p5eRyynxaCXN2FZH5nQwZsIOZVGYv3/PxyhLyV0vvbEJq+syMfnN4Dnep1hZGXSv3QLaU3isUs7jKNwoLGsGUw0ye3VY2ICdoSdXCAfVBZLXTNkHSlmzjNqKuOGlgUzni29Q/2nMvo8mQAygxZIe/62deAm/N0ZuM62fS6OIvKqdmEBAZEV11/5MZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thl3sr/nWM0v8H7hdi35XKVxyX4k+d/WyYo35QhkAP8=;
 b=0jOBJ7J+MGrAShQOpk0AdnS3+EA1X2UPT3NKouGIpRWmY08Tt0Kz0oJ/0futo16dGvq+dY0UwruRLkehlER/19iU2Hm0NJRTZTHtlmCMCKR5vJj2mYXNLUGP9nhNweXt0sRu55Qj6UvJqM8s3lMnD1noSFLAFWpTDogmrQTUIfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 21:19:58 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 21:19:58 +0000
Subject: Re: [PATCH v2 2/4] drm/amdkfd: add kfd_device_info_init function
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119195258.2173551-1-Graham.Sider@amd.com>
 <20211119195258.2173551-2-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <7a682c56-817b-2658-b370-19875e3fe06e@amd.com>
Date: Fri, 19 Nov 2021 16:19:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119195258.2173551-2-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL1PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 BL1PR13CA0098.namprd13.prod.outlook.com (2603:10b6:208:2b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.12 via Frontend
 Transport; Fri, 19 Nov 2021 21:19:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a717afd4-f7d7-406d-ef0b-08d9aba25704
X-MS-TrafficTypeDiagnostic: BN9PR12MB5381:
X-Microsoft-Antispam-PRVS: <BN9PR12MB53815C4550E8640388B4B0CA929C9@BN9PR12MB5381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbLCoNF9IZgVMCbBV8dfsLVQHiuHDcHuWRN27+TOuzZFC5VM5dpadhw3iQNOxDIl6uldTqAU3V0bWAj2QP0JVf/1HFFIxPi7AcmK1ZrGyimczu8sA27RYqk11keXHb26+XXMH86M3hjH5dH4xdvSLbMHUlAoCNhOq8Owh1KW6F1UbzYnRFlhbLxGixGcOtlAurlPC2Lu7TXDV0uQqM11LKhGxdXVVPaCLk51mgZzeATdCE/BMJ3b+SQoaCB/s+L6886CNuiOcyG5ny5xdYTEUoe1czXMKO2hCLVnUEvZevbHhlraS8L7EZ5donh3McAC0/FKoEr2YkSpwcVFq22BkM1gJfhY61aWIRWQD0S7uJw73KTIo0LCpYk7LgEBuEBaz2eTKuQMLXNCqbD61PkMNLMhMnmGsOKwtabNfuiOQ0Wdabg3iyR3vlYxwGlu+7Mn0UHnaUrNgKSLs82lEpnvMowqhParUW9B7Hk9CmqJUGYYniXe3u71+qSO/dho960P5QxAocZrAr27rcmt4G+LM7Xa16pC2UM+kgijFyI2gLn2NqalayEhUKtd37UkpqoOVMj19Nc5oEGcNbxpx2wt8q//XxOqujZUYiEiaFy8zJxEKA3+QuPCEEDV6DYa7AJE1kWdbPs3S5F4a5tBO6vttzsesrcyod3QaRyDuQjVXxeYd+OW6TyvYemNAeX0x1nwfMcDy+Duwi2cUnRPMoKg1EkawNrIyQEOfDBHwmxnHyGm+pbg8L3mfcDngNU0cIIu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(26005)(86362001)(8676002)(36916002)(53546011)(44832011)(83380400001)(36756003)(4001150100001)(2616005)(2906002)(5660300002)(956004)(66946007)(66476007)(66556008)(16576012)(316002)(186003)(31686004)(508600001)(4326008)(6486002)(38100700002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGRXbjdjLzhXQUZpcnNmd3BxQkV1d2NkWFBpckgvZVBPWXY0OXZ6OHlFZHRz?=
 =?utf-8?B?OHUzbHYwemlGWFA3K2tyUlErNk1BbmdHTTBKOS9pYkQvUkxQdUlyd3RvbHRp?=
 =?utf-8?B?TC9CUTBRdFNDKzZsV1VQVkN2dHJBMXppZFk5MUJlY2RyK0lxL3JzblRWS3oz?=
 =?utf-8?B?eXZNQmlFYWpIcUErL08zNlorYUoxbUJGUmw5eEhEWGFVUjVad2pmVDNha0JT?=
 =?utf-8?B?aHJHSVRCTTNpczdMNy8ya29NQm5GTE9WcmZTS2pRbk5uT0pyS1JqbE1CZENE?=
 =?utf-8?B?MWZaYzJXclpta2M4Mlhsd1RaTU1iMDdiOGlxaXEyOGY0Q0haT1pleEhNa1o0?=
 =?utf-8?B?MnpoSmE4VmpjSFZIT1JHWnQwK0ZMeXNvLzBPbDBycFFJVXhrYjAva1lrVHpZ?=
 =?utf-8?B?blp1TWVERkhleDZ5Sy9YeGtBamNZOUx3eGF2UUxEbUFWbjNYV0hkekVmTUJE?=
 =?utf-8?B?SkpHOGpvUjFOSUZrN0FFZE5JV3Z2Njc4RlNPNVd5dHV6LzZkQlg4dWs3bk4w?=
 =?utf-8?B?aWhKdUNlTHE2TFkyMXd4ZzdNdkgzNXYxNWh4amZQZkpkZFN5Tk81dDV6VzZs?=
 =?utf-8?B?dzBzZVJvQWtyR2JwaGgwejY1UjB4dkgvbER3dHNyUkYyQlpnK0h4ZUh4MnF3?=
 =?utf-8?B?ZXM5cGd3MzNBdmpHQTZsZ3lZMUlDVzBTczFGZ2pjQnVjbEtWZjJnQXZpd3V5?=
 =?utf-8?B?Ris1R3JmZDYyWWp6c2k4a28xUEIxRmxkRWZhWTZYYzB4eG00WXhwM01aaEc3?=
 =?utf-8?B?dWxaZkV3bEI4aFdiVmdOTFl4U3h0NnJXMHcza1ZrZ3F0NXZEVi9KcDJHeVhL?=
 =?utf-8?B?M0VPRXo0amJyZllTOSt0T2N6endrRHJMdnhNUlJZSXMyYXJGWHc3dDlRK3Rz?=
 =?utf-8?B?UFFHSjhIdDI5aUtUREI4OHRBVnhUeXpSVTdvMWVWZ29WdEJYcDU3VTd4clZa?=
 =?utf-8?B?OStMK1hoalhqdWlkVlFkbHo3bC8rMnVqQ2R3WmRxL2xzMll0OXFqZnNXUWVG?=
 =?utf-8?B?V2c4OUtOdHpiQWNWUnRTZHJRYWN2QzBSekh2NWc0ejY0RWJtUS9aWU85Y3Iv?=
 =?utf-8?B?VXd0dzdEKzgyUGFaRUprem5yaXhWMHFVUktTcXVIL3hmWmh5aVN4ZHRIeHJR?=
 =?utf-8?B?VEZYQ05FdXkrenRZb0VxT2I5Z2daaVVwMEZDK3JiTXhOVVJOODZWTFlpKy9x?=
 =?utf-8?B?c1RuREdHQi9xZ1RSd0dyMGkxUkhELzYzUHFjTit4V1pVQ3k4Qzg1ZXZqWGVz?=
 =?utf-8?B?RUhhTFdiNWVjNjVCRElUTis0ZzYzZUJmd3I5S2ljS2VJR3Ixc2JnaVZsamFK?=
 =?utf-8?B?cHpSNllsSXhmbGVNamd2MU9WT1R4UzFQZUNtVlVEUUhrZWo1c2lFZ3hMZWlR?=
 =?utf-8?B?T3RjYW9JTVhxWXNPMXZob3JjVlFiYUNIQXdhektYSEdhT3FCNUwrREFNTFlX?=
 =?utf-8?B?cXYrNkV2dExGeVowbitaUnk0U3J2MVlWSTZGeENXbHM0V1RFZUd1YksrejBt?=
 =?utf-8?B?a3lFNTErL1FQQk1zMmlQb0Y0WDdMcEZUSGJ3T3pkYU9jSGw5SE9LZS9MbWpz?=
 =?utf-8?B?cUNwMFRQNEkrT05vM1hZNEU0TDFzYWpTczhZdzdXN1BtcE95eXBaeGZJVzZj?=
 =?utf-8?B?aER1V2VNcFkzSjluRWlVMUUrNE1GOHU1dmNIaUxNdmZKK09YVDljaDFpbHpV?=
 =?utf-8?B?QjNZK1krZTRuT0tVRGlLT3UxOEhsVDFnM2t4YnkyeFFhcmt0WlBzWFF1TlBi?=
 =?utf-8?B?bFljRHp4SVhPT0w3eTBtNjB1Skt6WEdrT3RBb0duSjhzNkMxSmRPUnNyK0xW?=
 =?utf-8?B?b1dKaFJUQ1NMYTJ0YmcvaDJiQlBwYmExTnQ0cytDMStxL2V5VXFUQXR0YkZw?=
 =?utf-8?B?eUIzdUtkdWZSM2wyKzdPdk1YYUJpM2pzYW1RZENGMy9wS25XM1JJTmI5MXQ3?=
 =?utf-8?B?ZlBIeGdkWnRFZjBIZUZpOFZpYytmZ1hZdmZtZHdoMVdBWFpSaFNlRisrNFVu?=
 =?utf-8?B?cW9Cb3BjV0ErVjQrdGNQVDdZS09xQWN5a1gwd0pjdHAxKytmOFN0Q3BDRjNL?=
 =?utf-8?B?UXRkcHR1N2d6K2RWN2FEZ3JUdnl4b3NmTGliV1Vic2JIcVpJTm1yQnIrNlkx?=
 =?utf-8?B?SmdUVTFXYWgyUEhlZk13K3RxY0xtTXYzZWZNcnVCOVZQSkEwblVRYlRzYWda?=
 =?utf-8?Q?7+sjWDgde0omasZRd00q5Xw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a717afd4-f7d7-406d-ef0b-08d9aba25704
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 21:19:58.5904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNzBb9F+FYaG8JoChdQraudr+PV9XETC/VWLI0zz/cWnAXXAgPHjBvJWy1hmuXMN6O3v82CVSA2pFJabDww4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5381
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-19 2:52 p.m., Graham Sider wrote:
> Initializes device_info structs given either asic_type (enum) if GFX
> version is less than GFX9, or GC IP version if greater. Also takes in vf
> and the target compiler gfx version.
>
> Inclusion/exclusion to certain conditions for certain GC IP versions may
> be necessary on npi bringup on a case-by-case basis, but for the most
> part should be minimal (e.g. adding one || asic_version == IP_VERSION(X ,X, X) case).
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 61 +++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index e11fc4e20c32..676cb9c3166c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -511,6 +511,67 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>   
>   static int kfd_resume(struct kfd_dev *kfd);
>   
> +static void kfd_device_info_init(struct kfd_dev *kfd,
> +				 struct kfd_device_info *device_info,
> +				 bool vf, uint32_t gfx_target_version)

This will give you a compile warning about an unused static function. 
Maybe squash this with the commit that actually starts using this function.


> +{
> +	uint32_t gc_version = KFD_GC_VERSION(kfd);
> +	uint32_t asic_type = kfd->adev->asic_type;
> +
> +	device_info->max_pasid_bits = 16;
> +	device_info->max_no_of_hqd = 24;
> +	device_info->num_of_watch_points = 4;
> +	device_info->mqd_size_aligned = MQD_SIZE_ALIGNED;
> +	device_info->gfx_target_version = gfx_target_version;
> +
> +	if (KFD_IS_SOC15(kfd)) {
> +		device_info->doorbell_size = 8;
> +		device_info->ih_ring_entry_size = 8 * sizeof(uint32_t);
> +		device_info->event_interrupt_class = &event_interrupt_class_v9;
> +		device_info->supports_cwsr = true;
> +
> +		if ((gc_version >= IP_VERSION(9, 0, 1)  &&
> +		     gc_version <= IP_VERSION(9, 3, 0)) ||
> +		     gc_version == IP_VERSION(10, 3, 1) ||
> +		     gc_version == IP_VERSION(10, 3, 3))
> +			device_info->num_sdma_queues_per_engine = 2;
> +		else
> +			device_info->num_sdma_queues_per_engine = 8;

I feel this should be based on the SDMA IP version, not the GC IP version.


> +
> +		/* Navi2x+, Navi1x+ */
> +		if (gc_version >= IP_VERSION(10, 3, 0))

There needs to be a maximum check here. This case should not 
automatically apply to future ASICs e.g. GFX11.


> +			device_info->no_atomic_fw_version = 145;
> +		else if (gc_version >= IP_VERSION(10, 1, 1))
> +			device_info->no_atomic_fw_version = 92;
> +
> +		/* Raven */
> +		if (gc_version == IP_VERSION(9, 1, 0) ||
> +		    gc_version == IP_VERSION(9, 2, 2))
> +			device_info->needs_iommu_device = true;
> +
> +		/* Navi1x+ */
> +		if (gc_version >= IP_VERSION(10, 1, 1))

There needs to be a maximum check here. On future ASICs (maybe GFX11) I 
would not expect atomics to be required.

Regards,
   Felix


> +			device_info->needs_pci_atomics = true;
> +	} else {
> +		device_info->doorbell_size = 4;
> +		device_info->ih_ring_entry_size = 4 * sizeof(uint32_t);
> +		device_info->event_interrupt_class = &event_interrupt_class_cik;
> +		device_info->num_sdma_queues_per_engine = 2;
> +
> +		if (asic_type != CHIP_KAVERI &&
> +		    asic_type != CHIP_HAWAII &&
> +		    asic_type != CHIP_TONGA)
> +			device_info->supports_cwsr = true;
> +
> +		if (asic_type == CHIP_KAVERI ||
> +		    asic_type == CHIP_CARRIZO)
> +			device_info->needs_iommu_device = true;
> +
> +		if (asic_type != CHIP_HAWAII && !vf)
> +			device_info->needs_pci_atomics = true;
> +	}
> +}
> +
>   struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
>   {
>   	struct kfd_dev *kfd;
