Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B88BC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Nov 2022 17:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F7A10E860;
	Mon,  7 Nov 2022 17:48:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9941410E856
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Nov 2022 17:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1t10Zzf8TXvSz5TFNZIBjtn9oLU9Auz1ItjBod2iarG2837C8vPPbKy4FzpAwkxj9chmkXZ9Zt3cGizFhVPT7c3IfKryquEeJcbYBzvTj2iuDKMYN4Gv0KCM0OTohhd20HPkjibFHd420wgAIMaDTVxjqBnS/uri0N+lo2ajNQPZxBAk+45VzNZk52zZzKY/EVADHdcHfaS2FBing23Jqr7vgVGiK94k/107S+Pza9BoHsOWbkL+NqLWzrNy2vKwoF1hmMXi2LLzB138QX33UaxwDpDEesX8d+eIjFzEMeNbxSyUDndJ9gRCg//vzTdwMB0QcN5W04/QWl9v1hZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPIFgZlDxlwfIBGkFF5liwOFNUTXbXv/PL+mvrJL+BM=;
 b=iiwt3/IfMtxHMpf4zHT0oD0uMEYf//7LiPxOanGRfa6FmbYMp7R05IdW9iWlLvzEZ6OtJZV6gvtES+H06iMZk/SZ6hKgi5eXYNvVjrJCuRKQCGjes1FF7hS2ZJn5zmVs9MYqNrPhAPuvSNzOAbEeFgpnuBiKGxBkX7qFQibLjyPpIwzoWvgJEbj74s6Yg6c3SVpvG3UCm9i2K3HbuJP/3c+nxhmzGGSanGkz0O/5nrHachcUL1C0W0RbjhrGLap8PDk+1EizYeLzC9wgL9IidbSDSoMKqndKnteBBkApKsbzWX5LEzW2tcxIvwqm6rNqT9EqQ4r1FN2c2bNR1RTxOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPIFgZlDxlwfIBGkFF5liwOFNUTXbXv/PL+mvrJL+BM=;
 b=eHTWUiUO/sooDeMjiAbW01lssLNkV+46yKu2I7lljPDM+EL/yvYDAE8gl4StrjPuH9dj5O4YDeoCrHJoQR9WuIX70VJ1SbQlcaqQ6E5PNGIS2EkOU1M31l9Ly0MYb5palFVCbz4750mI2Nrn0XL/ZoApVZjrLHCRwCVjuXPrYmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Mon, 7 Nov 2022 17:47:54 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:47:54 +0000
Message-ID: <39c70207-82b9-93e2-d1f2-bcfee06c3683@amd.com>
Date: Mon, 7 Nov 2022 18:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221107033251.734764-1-Tong.Liu01@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221107033251.734764-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR07CA0032.eurprd07.prod.outlook.com
 (2603:10a6:20b:459::6) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: d943c0d5-b46b-488e-9157-08dac0e832ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbzvPg8wh0WpeBrILxONZ/OLYT2CtHSQxKS5b3x+0UuQp5U1nQbsCoJ10mo7j/q2IEPog9FEteEJluJNgqVeeMVSN4k2Ffn4dbijAPUmSNOM/gUlbADCFURnBWUwuBXk2okTdtQAQAUxkjVNuOw7Avt4WUSQm+j7YARVOVA6RIg99iCCu8Ye7ytt3vhJ2qs5nUFOnOiNBGQvCiTJH6XVAR0U9CAm/SaUhCLGiqa+wntL4uNVSU5RsiodTJWD4yYV6apstkwXrKuRK2qtYXB/TyqfLUXGK/aaMZwONYe3fT04gMLfghKusT6O2aovCr82MOAEAXe48RuyhFslmmzc6VONDvjlxy5WbMh9GFny73cbUO4CbPCcMvmUwC2UksGfyCUNxDYq6K4ZB4oo0wD2NXWY7JTkt0R1CNKl0bIQbhnypnFMEUnKTFVg8+RBiIyCD8InUDSxcqFkZjBnj2gAoJpIOdsYi9I2dGyzIwrSJVzVq0a0t9WLWDfHOA0U6AQUISbkr62RLGDYeAqE/yoJgijNywCLNL9ggJJUBqRhA5+j/3EgQI3EdeC2MBzF1UCywxdiQw9skqRNm1svAICbOcxIX4Ec6lDKbvQ+FhVdSCFA/fXryb1ydH15/5BZqmzPO8juBvpd6IFKWx2VFsPKbmw9frCO+OHEYhnhiTyyX+3525Aa7rhUNHh6kK9qviL2Edvgsxbj6vX1e2GUDolfFaedJDDujcSg+u40aNJI9gVIxhPtg53CGTNT0DZEul+LE52DKoE8LJwB5nED32fki9vh7lqaI+LMtrhYu34do6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(83380400001)(186003)(38100700002)(6512007)(6506007)(2616005)(5660300002)(2906002)(30864003)(8936002)(6486002)(54906003)(6666004)(478600001)(41300700001)(66946007)(316002)(66476007)(66556008)(4326008)(8676002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlkrQkR6SituRWpPTmViT3pJWnIwYjE3bVdWeHp0elBPY1VwM1lYejlGd0d0?=
 =?utf-8?B?SU1vWWo1bXM5N0pYMnBFUVdnK3phTDZaWVJTVmswakJZeWNxNVZHM21yQ2p4?=
 =?utf-8?B?aktlZHVzb3JHMjBRTXhKelUyZGlTRGtITllsSjd4cERqenIyU053TzRnTm5Z?=
 =?utf-8?B?Q3p0enFwa00vMUZZeElSek5uVEU0K2M5WVlGTjN3WkhkMFJhYzNmZ1FYNDRq?=
 =?utf-8?B?VE5WS1FlUVYvbUlpT1J1TDZsUGU2eUI0a25YaEROekFVUmdwbVBJR0dkSjZK?=
 =?utf-8?B?THFoWkU5aWRvUDlWcDF5VVNvdVp5KzY5aGpJUDdVdmVwNVg4T1FiNnRtWHZG?=
 =?utf-8?B?RHQ2dVgvdGdKQ2dmU3l6SmtmR3VtWFl1OWdQSnNNbzJZbXFWdDlWd1JDVUdB?=
 =?utf-8?B?amVPelIvazhLc1pPZ3RWVWxyUlBabVRBZG1uQkJjVUc3Y1g5VEIzTExTbG5N?=
 =?utf-8?B?SXlPMEVmM05LVEszRXQ3Y21HdmZXaE1aUE4yVzFPblJ2TjZuUUhHMXoza2U4?=
 =?utf-8?B?c1RnbW96REdJajk3NzV1dXNhR283a1pLTm9FSTJpNElUUlF1cFZoM0ZPMUZu?=
 =?utf-8?B?Y1Zhd1lnMmF5Ymd3VEk2UWRqWG00YUE0cXp1ZFU3NkpkdkNkZUMwVXNNUEly?=
 =?utf-8?B?YmJndGZuUytYOERuUkJhaTdRYnhwR0dwRFVjSUtqdS9DQjFqMFBFMUpNMEJW?=
 =?utf-8?B?NStuck1TZGgzMGlYcGVMb0pySyt5c2oyTjNQcHVXa1B5SG85U3RkbUpFcnZr?=
 =?utf-8?B?TVFJUTZXeFI0ajR3WFgyRTVGYmdCUzFtelJ1a0dEbndDQnc2TGRzZ0M2blZw?=
 =?utf-8?B?WU1NZks5TmRJSE5jc0dmSy9YeFZsMFlDRjYrQjhrR0pPaGJBckw0cFZqOTVj?=
 =?utf-8?B?a1ZJYUhSSnVId1lwU3RXVVozdWc2ZGI2MGtNaEkyTnV5TVNLVDNtWDAvLzI0?=
 =?utf-8?B?THN1WnNkcmpTU3I1SHI5eVlrbGFIVXc2RUZlZEZUZ3FId0FDWTdzVHdIZVpE?=
 =?utf-8?B?YWRNKzl1ejNiU1R6OTBHNS82ZWFDTk9UWFhwa25pWkRydUoyaE9TZE9ycUFF?=
 =?utf-8?B?WDB1SW5zZkErM0dBLzgyYzNmakZrYUdaNThEdTRZeVZwSXVWSlZsK1ZoNDVX?=
 =?utf-8?B?WG93SzJ0WnlUQVhDenlOSGJ6YnN4ZGovSFJtRkxSUGRCNTU4bkFTK2ppVitN?=
 =?utf-8?B?UzFtK29aTmtwMTc5Q3pwSmtZL2lMQ0hCd0JsNkptakl2bmFyQVErbW5vNGlp?=
 =?utf-8?B?TG0xSU85Rjd3b0NwUzBtS09UaU1Pd3F6aGRlNVJ2WEhwamNLQ3UrRWlyU3Ri?=
 =?utf-8?B?WXVWSmlMN0s1ejRnM2FJa0dieFlnYS9jeDdnK3BJenBlWVpNMDdQeVJzNGJC?=
 =?utf-8?B?MHJpOFlMRTdJQWswN1Y3dGRkYnF5dElaVFJ6eHNKUEZqcEZBVkJENk12U1ps?=
 =?utf-8?B?VXBXc0tjdTF2WERrQStuRW9DbFhCY2Z3M2VtSmI1c1ZYS0RJQklwM0kxaDhU?=
 =?utf-8?B?YnZ6TnBKUUtOQnhEQ01CU0lHZll0Nm1GQzlDWUR0RUQ4MlY1U21hWnRwUXUy?=
 =?utf-8?B?RUJNNlV0RTA0R3d1bHBGcWwzUEtHVWdndFBYYWxYUUhoZ25vUUsyVTZiVUFT?=
 =?utf-8?B?Y1o3ZzNPejU2MndyU3RJMVc4RkFpNncrUE92cDVjdVhUY1VEN2lpSWVya1lx?=
 =?utf-8?B?akN4WHhpbFhyenF6U3BJaWRFWHlLcjVSdEpHWUlxQnNUbEsybTVIOXEvMFZi?=
 =?utf-8?B?RXRXR24raE1aSzR2NDFwd2YzOWxkZENsYmlJekVEdEt3ZFZORnE4WjhiUy9J?=
 =?utf-8?B?SExHNXJYeTNROG1pOG5TUjVVdGdBTXRaQUliSXRkOTJDcFJFZHpXN1RsSC80?=
 =?utf-8?B?UXljeVFxalR5RjBEc01xaWlmaDlKTW1NYmN1M2FnUFU5UUYyMGgydTl3T1dC?=
 =?utf-8?B?ZmlQQWxONjJjTTRVdTVQSzY0dDZwMnp2bzVjak4wekRUY3VHTDBEbVhRei9u?=
 =?utf-8?B?b1hILytCQ1hXTmQ2RVlBRUoycU83VHJkZUQ0VkdnclpQdE94MkgvWTV2T1M0?=
 =?utf-8?B?Wk03Zk5ibkdsK1JtYXMrS2dPK0tMSCtheWc5bzA3ZExjclY3K05VV05WQm9E?=
 =?utf-8?B?dStacDhpdnBYSUFtL3RTbTZYWmdLaU5OeitpbFgwQnpVc2VFUUplTlFzN0p2?=
 =?utf-8?Q?IokrsgMl4rMnxfsZ/oOfSv+7ImCOKVkF7oG7bCRzDJKJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d943c0d5-b46b-488e-9157-08dac0e832ba
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:47:54.3942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QdA72quI5ZpYX3lR7qWilO4IZ/Pz0nwml+JlNS7GkNqFMi50KKBZ+f4J8iWVzR5V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.11.22 um 04:32 schrieb Tong Liu01:
> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve TMR region
> firstly to make sure TMR can be allocated at 2MB

At few coding style things below, but looks good to me from the 
technically side.

Please use the checkpatch.pl script, it should point out a couple of issues.

>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  51 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>   drivers/gpu/drm/amd/include/atomfirmware.h    |  56 ++++++++-
>   4 files changed, 190 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index b81b77a9efa6..239c621feb0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
> +		int *usage_bytes)

Could be that this is just my mail client, but of hand this doesn't 
looks like normal kernel function style (but I might be wrong).

> +{
> +	uint32_t start_addr, size;
> +
> +	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
> +		le32_to_cpu(firmware_usage_v2_1->start_address_in_kb),
> +		le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb),
> +		le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb));
> +
> +	start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
> +	size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
> +
> +	if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> +		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {

Here again, this isn't normal kernel coding style.

> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = size << 10;
> +		/* Use the default scratch size */
> +		*usage_bytes = 0;
> +	} else {
> +		*usage_bytes =
> +			le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb) << 10;
> +	}
> +	return 0;
> +}
> +
> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
> +		int *usage_bytes)
> +{
> +	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> +
> +	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
> +		le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb),
> +		le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb),
> +		le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb),
> +		le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb));

While at it maybe convert this from le to cpu only once.

> +
> +	fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
> +	fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
> +
> +	drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
> +	drv_size = le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);

In other words use those local variable for printing.

> +
> +	if ((uint32_t)(fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = fw_size << 10;
> +	}
> +
> +	if ((uint32_t)(drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* driver request VRAM reservation for SR-IOV */
> +		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.drv_vram_usage_size = drv_size << 10;
> +	}
> +
> +	*usage_bytes = 0;
> +	return 0;
> +}
> +
>   int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>   {
>   	struct atom_context *ctx = adev->mode_info.atom_context;
>   	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>   						vram_usagebyfirmware);
> -	struct vram_usagebyfirmware_v2_1 *firmware_usage;
> -	uint32_t start_addr, size;
> +	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
> +	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>   	uint16_t data_offset;
> +	uint8_t frev, crev;
>   	int usage_bytes = 0;
>   
> -	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
> -		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> -		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
> -			  le32_to_cpu(firmware_usage->start_address_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
> -
> -		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
> -		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
> -
> -		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> -			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> -			/* Firmware request VRAM reservation for SR-IOV */
> -			adev->mman.fw_vram_usage_start_offset = (start_addr &
> -				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -			adev->mman.fw_vram_usage_size = size << 10;
> -			/* Use the default scratch size */
> -			usage_bytes = 0;
> -		} else {
> -			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
> +	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> +		if (frev == 2 && crev == 1) {
> +			firmware_usage_v2_1 =
> +				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> +					firmware_usage_v2_1,
> +					&usage_bytes);
> +		} else if (frev >= 2 && crev >= 2) {
> +			firmware_usage_v2_2 =
> +				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> +					firmware_usage_v2_2,
> +					&usage_bytes);
>   		}
>   	}
> +
>   	ctx->scratch_size_bytes = 0;
>   	if (usage_bytes == 0)
>   		usage_bytes = 20 * 1024;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 585460ab8dfd..b2779e68b734 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>   		NULL, &adev->mman.fw_vram_usage_va);
>   }
>   
> +/*
> + * Driver Reservation functions
> + */
> +/**
> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free drv reserved vram if it has been reserved.
> + */
> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
> +		NULL, NULL);
> +}
> +
>   /**
>    * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>    *
> @@ -1604,6 +1620,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   					  &adev->mman.fw_vram_usage_va);
>   }
>   
> +/**
> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation from drv.
> + */
> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> +{
> +	uint64_t vram_size = adev->gmc.visible_vram_size;
> +
> +	adev->mman.drv_vram_usage_reserved_bo = NULL;
> +
> +	if (adev->mman.drv_vram_usage_size == 0 ||
> +	    adev->mman.drv_vram_usage_size > vram_size)
> +		return 0;
> +
> +	return amdgpu_bo_create_kernel_at(adev,
> +					  adev->mman.drv_vram_usage_start_offset,
> +					  adev->mman.drv_vram_usage_size,
> +					  AMDGPU_GEM_DOMAIN_VRAM,
> +					  &adev->mman.drv_vram_usage_reserved_bo,
> +					  NULL);
> +}
> +
>   /*
>    * Memoy training reservation functions
>    */
> @@ -1771,6 +1812,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/*
> +	 *The reserved vram for driver must be pinned to the specified
> +	 *place on the VRAM, so reserve it early.
> +	 */
> +	r = amdgpu_ttm_drv_reserve_vram_init(adev);
> +	if (r) {
> +		return r;
> +	}

No {} for single line statements after an if.

Christian.

> +
>   	/*
>   	 * only NAVI10 and onwards ASIC support for IP discovery.
>   	 * If IP discovery enabled, a block of memory should be
> @@ -1896,6 +1946,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
> +	amdgpu_ttm_drv_reserve_vram_fini(adev);
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9120ae80ef52..339838675b11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -92,6 +92,11 @@ struct amdgpu_mman {
>   	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>   	void		*fw_vram_usage_va;
>   
> +	/* driver VRAM reservation */
> +	u64		drv_vram_usage_start_offset;
> +	u64		drv_vram_usage_size;
> +	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
>   	void			*sdma_access_ptr;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index ff855cb21d3f..9f8761407099 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -705,10 +705,47 @@ struct atom_gpio_pin_lut_v2_1
>   };
>   
>   
> -/*
> -  ***************************************************************************
> -    Data Table vram_usagebyfirmware  structure
> -  ***************************************************************************
> +/*
> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
> +      driver can allocate driver reservation region under firmware reservation,
> +      used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
> +    Host driver would overwrite the table with the following
> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
> +    } else {
> +      there is no VBIOS reservation region
> +      driver must allocate driver reservation region at top of FB.
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    }
> +  } else { //( NV1X and after)
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
> +    }
> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
> +      driver can allocate driver reservation region under firmware reservation,
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    } else {
> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
> +      driver set used_by_driver_region0_in_kb = driver reservation size
> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
> +    }
> +  }
>   */
>   
>   struct vram_usagebyfirmware_v2_1
> @@ -716,9 +753,18 @@ struct vram_usagebyfirmware_v2_1
>     struct  atom_common_table_header  table_header;
>     uint32_t  start_address_in_kb;
>     uint16_t  used_by_firmware_in_kb;
> -  uint16_t  used_by_driver_in_kb;
> +  uint16_t  used_by_driver_in_kb;
>   };
>   
> +struct vram_usagebyfirmware_v2_2{
> +  struct  atom_common_table_header  table_header;
> +  uint32_t  fw_region_start_address_in_kb;
> +  uint16_t  used_by_firmware_in_kb;
> +  uint16_t  reserved;
> +  uint32_t  driver_region0_start_address_in_kb;
> +  uint32_t  used_by_driver_region0_in_kb;
> +  uint32_t  reserved32[7];
> +};
>   
>   /*
>     ***************************************************************************

