Return-Path: <SRS0=G5aM=P6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4827FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 07:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FFB6124C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Nov 2021 07:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 04FFB6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73BA76E93F;
	Thu, 11 Nov 2021 07:22:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EA196E93F
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Nov 2021 07:22:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQguD+hcSW1jggKMQj+/YT25hdyFltbJNU5cq53IECGaIsZ0uPFasGVbdYCrvhltuSF2yg6Qf9Ij0Uyn5pyQ7/nruNzZFy5Eh7q3r0K51boAwLhvQFAsAfHigJBhALMAZQQ9ml+fcwjNhiakSDIl7CeZG/ElGOA20xnX0gQd/8B4SPhC/Re8ToUTalWFG1KG0lywXJVOjFZGYBY/v8RH1j9e3eE+wzsuxLEeA4g5hI92zlyZwZQtNjWRmH1ud/18ivXrfZHUPdBMRlMPxBY2JFefLxUrg9dakbA65yKNLLPI3Li69YG7EE6AxaHL9E7te/Ula1Zzwo8OsoNtxQ5+zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31GWEWirgXIhGrh74+7KzkOe539iZzkES3r/lfIiJM8=;
 b=eGOTnijxFjyDu5ti+suyyl9qezLoeORcGgeD31ox0CDXCKUOWVAnVd5N8hUCclZphNklB8bq4sxSlJpC8m8N8AB92Oh/NMTzW3hddB7u/W4ypHrSo1cXIpyMtuB1CWexeQFCzIYzNK8jjL8GLvwubDJgYdeDtEW1MgL2yGl3N8fSRmMwqeK+VoXODxzC6f1lJyXp57xVYVnrsB06PUGfO529dO3AP1g6VsJuiiy/6D/EzpUVEYMnWwqmn5wTqR+5UZfELFUQtYHKyrmRsOl0QMlZOhvCtLcx0GnlAJCIToo65bKd5Yj75ZcDuUT8oWthoVGY5GBShybkGnGe0dxzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31GWEWirgXIhGrh74+7KzkOe539iZzkES3r/lfIiJM8=;
 b=uV4XFS+C0FnkJ6tup9+6Zty5+BZ5EodUXyB8DloQPaSarzQaYgyF958hQXuWySIaBVpAfRTQQNTHjuIlK3tJkSV6H2RD5lq5mvjN/QX440QWf9HZcWPAvXDWJCC1OvDKShUotxy4ZpfMWJW8Nrda2pfrKi8ec+RfRjJgJH6kY08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 11 Nov
 2021 07:22:02 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 07:22:01 +0000
Message-ID: <e77e8645-5ca4-fb8a-edfb-90697c708673@amd.com>
Date: Thu, 11 Nov 2021 12:51:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: add error print when failing to add IP
 block(v2)
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com, xinhui.pan@amd.com
References: <20211111041128.8043-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211111041128.8043-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::10) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN2PR01CA0125.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 07:21:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1f79040-a46e-4baf-a1f5-08d9a4e3f468
X-MS-TrafficTypeDiagnostic: DM6PR12MB3116:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31164511101608A5BAFEB64E97949@DM6PR12MB3116.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKstWxO7R4d1ssU+bM/6MfzQiKQkDNFJ+JlZf089zDEzOabuSna5JzAfHCQpJXR9nySCIeaMvRB0est6Dmt+PL7r+1xEZ0gZWOtyJJ5yDZEohSRrnqqgFXI8PoX2DnShJFTUZ6U4AYMmkKAF0dcZjaOew4yIoI9okCj959cvPnnBFLdquvytvZ3GuTYZ4NvENyBYKmh6bD8fLClvabEY67LS94zD3s8ONn8RQI/o1wvb8BEx6m3/Slo4Plp9j3ZJAE78EBNJyCitZA3SnFeWv6LHwFsX/b08gnoJuyvuEVIh7FLixW/lI7hx/77OmSt0YQzEjWSkU+8ICti/cT5cAr+Tf8WJPYnOQvEBRkaetMQMMH6R7hyWNsgHVSk3/DR03L21ROQ6pHRRE939scFyFQ1dsmzYckgBTEeYSuq2IL4oVv6lFRo7bqkEP1llNlZz3ouXCRTX2LHjq5F2UimNW5eRb4NQGUquRfSZyqclU7fWYDoXxh3zdnFYJroLFQtj0nG+TQqka0R57lsRpj2tH97g8O0oYkmsZVsBecsyPpIS7ndAa2rVcvaTk4XdG0yBwXkqDSh+NmJAQkQ/qJABX6Ty0t5ZvgAPDcOqOX7WbkunncFcmtLcPvT/PdL8CYTg/cn4YpIDYO5We0pEJurqjVorWBq4QySXXBaax4tKxV+8YEmWdqGl07zyLMHav6xo/YhTBXguNfzgAkaJbC1BlJR02nvIofdnurcRrWwT8T0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(31686004)(2906002)(86362001)(8676002)(8936002)(66556008)(66476007)(6486002)(53546011)(38100700002)(6666004)(36756003)(31696002)(316002)(16576012)(5660300002)(6636002)(2616005)(956004)(186003)(83380400001)(26005)(508600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1d0NFM3SjR5OXdya3ljNUYzWUxVZFh5Vnh5cnNqT1NTdlBIdFgzNERpYTJW?=
 =?utf-8?B?TmE3V2YxOUJ6b05NOEsrRjdzbDdDS05TNFBVTUJYOUhkb0Uvdm9UWEhSRWVm?=
 =?utf-8?B?RDhmTENHWHcwQWJOaUhaZW1vbmRBVnNGQVdLRFRReWNoWC9ibXhhbHJCazRP?=
 =?utf-8?B?RU0zdHR6YktrT1JXL256cUpGNTQ0aGZXL0ZyaVZpZ1ZJcnNkdTNOM2d1RDdK?=
 =?utf-8?B?aHAzWTVEYnN3VU5CMzVsSXd4SDZCTVN5MDZZOHcvbGIwdE02SUozVlh0cWF5?=
 =?utf-8?B?eUdNbmtNWVhsSUtLNG1UczJEZTg5cXY4WlNLOEtuRWMxY0ZhQ1AzeUdUOGFE?=
 =?utf-8?B?ZW9uZnVjTXg5Z0FHQzF5SlJQZEdlTFRhYWZ4ampIVEdrYWVMK1JwZzMwNXls?=
 =?utf-8?B?L1R4S0ZXcjB4M0FZNVpKZVBRTlNxSkZVMXlLNDh2eVk1bVNIRFNRQzBDOVVK?=
 =?utf-8?B?ZC9aRDlaR3JhdXUrNTlSaUk0RDlueDRjTUc0ZVhxUXlqekNGaDJQdjNXNjhs?=
 =?utf-8?B?U1c4RmRhSExZR3FuUXkycTNlL1N6YTFRSGdsdWh3dTZzcndjZ2JLZ0UzOFZh?=
 =?utf-8?B?MnJKRDRXTGk5dnFwdDIvakRWNlFxSFg3c3AxZmxHeWdvbnFvUEZldnBnZmpZ?=
 =?utf-8?B?aVl2NFNUK3FOdGVHRWJtWDB4WWY5dVBmQUorV1VHNUh3eHVGU3NVbnE3bldD?=
 =?utf-8?B?VHNSY2VoSkFCNjluWW1nYXFHeFF0L1djcEc4TWhLTHJBSWZ0NGlvS2FFbVZi?=
 =?utf-8?B?WFc1SGV0d2VOaENkSkluZWl4UXdFTzRrTXQ2TXN1Y2MySTJJUkViMDBKUEFZ?=
 =?utf-8?B?dzBkWWIxSFdWcWgvUWFQamJoT24xbjhpQURlaXRHQUNRQTJubGliQUxpdHU0?=
 =?utf-8?B?RG5jNVJIbUtqdHVjVHRNYWk1UFByVjZmS0ZnbTlRMU95YTA5WEUvb1F2TnFl?=
 =?utf-8?B?SGZHb0s4VzdkeFhDWjNCUjlvYVZrSEpYanR2cjYxNGpHYXIyL3pSSmlnZU8v?=
 =?utf-8?B?Sy9mM3FWVEtmVExVbjlxN1YyTGxSbFNxeDhaVVduamhBV2JwNnRDTmU5YURz?=
 =?utf-8?B?c2RmWmNudzVzUCsxNXZHckwvZHJPTUJHVXNwTWFCSTFUV1NvdmJWVjhqZVR5?=
 =?utf-8?B?Q1VTU1d2bGFVcVA3MnNJY3E5M0dzR094K2RVU2tCL0xTK1F3bnF3bUFERzZV?=
 =?utf-8?B?ZkZWTkdOemlLMkNJS0pDeVNzdkZaRHhuYmxlNGJFZElvemc2V1Z6M2JGNVBN?=
 =?utf-8?B?a2RoMnZkUkUrRUF6RVkyUEx3ZDhIbUVhUDQxQ0MyR3hwemd6OTlLOFZnd2dB?=
 =?utf-8?B?b0UzbSt6TGRXSWozZmRjcW9NSFBLd0ZlaG5pNk5BSlhqdWVaeDdjT1k2MlZs?=
 =?utf-8?B?TVBnSnV6a2NXclRRZnlLUGpTVGJweHptRUxyQldHN0dMQTdQWWpENkRGWGhy?=
 =?utf-8?B?bG1SMlB0U0J5RXhqUHhWNUNVWHVMYU1zSnhtZnNvRmorNkhzQXZkT1gwdFND?=
 =?utf-8?B?S0ViYjlHc3I1eW5rd00zR2k1a3E5Q3o4MkZZdVVlYkxaSCt2ZklwQk4yZU80?=
 =?utf-8?B?ZC9FeUw4L0h6VW1xZkViWWtBazJFVnZxZHZEcW9oZ1k1SEk3WTBOS3BlaFNU?=
 =?utf-8?B?WDZMVkRYajlhd0hlaCt6THZvODZiL0wydlFWZVNWbHF1eDRWcjY0cUxUV1Fo?=
 =?utf-8?B?Y05Bd3JoZDBFVlZ3QmFOOUF3ODNEVGFvNHJ3ZmF5NVFpVkVJSlBQdFQyWTdQ?=
 =?utf-8?B?Z2pITmNWdFIySWQ4OEd5Y1ZSeGJNVjkwcTk4Mko0cWNVekNIZDA4Zm9wYTMy?=
 =?utf-8?B?bkRoVTBQREw3QUp4amtWK3VtWDFzVmxEczRZS2pXMExqMC9INWNOUXplYUUy?=
 =?utf-8?B?aUNuRlZORjZKSXpPZloyUXlMeWFpZEowaG5rU1FDcFRyQmlPMCtRN1MweWll?=
 =?utf-8?B?SnErRXh1dTU2MVVGMVVmUU1WMmVDM2NJRGdmWUU5WlJPOVNJalRkV1NVNmsz?=
 =?utf-8?B?dFVHR2R3TVBJWjUyWGVHbzBGSkZjQTBjcytXeEYzUHg2M0tUS0d4TkdlUThJ?=
 =?utf-8?B?ZTJzcVhJZHhlQWhEd0o1ZEVLbitVZ2lhTW5Pa25FVDRBQmFTOWJIR21LODBs?=
 =?utf-8?Q?kp3Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f79040-a46e-4baf-a1f5-08d9a4e3f468
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 07:22:01.7823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBd6rKRSbsy/hiQaRHJbnBCtLdGgURawQkr/Czb/yZR2C4wpMU83pDSyLYoeaAL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3116
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



On 11/11/2021 9:41 AM, Guchun Chen wrote:
> Driver initialization is driven by IP version from IP
> discovery table. So add error print when failing to add
> ip block during driver initialization, this will be more
> friendly to user to know which IP version is not correct.
> 
> [   40.467361] [drm] host supports REQ_INIT_DATA handshake
> [   40.474076] [drm] add ip block number 0 <nv_common>
> [   40.474090] [drm] add ip block number 1 <gmc_v10_0>
> [   40.474101] [drm] add ip block number 2 <psp>
> [   40.474103] [drm] add ip block number 3 <navi10_ih>
> [   40.474114] [drm] add ip block number 4 <smu>
> [   40.474119] [drm] add ip block number 5 <amdgpu_vkms>
> [   40.474134] [drm] add ip block number 6 <gfx_v10_0>
> [   40.474143] [drm] add ip block number 7 <sdma_v5_2>
> [   40.474147] amdgpu 0000:00:08.0: amdgpu: Fatal error during GPU init
> [   40.474545] amdgpu 0000:00:08.0: amdgpu: amdgpu: finishing device.
> 
> v2: use dev_err to multi-GPU system
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index ff70bc233489..4e3669407518 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -587,6 +587,9 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add common ip block(GC_HWIP:0x%x)\n",
> +			adev->ip_versions[GC_HWIP][0]);

If not submitted, a minor modification to message (if that sounds 
appropriate)- "Found unsupported IP version" or "IP version is not 
supported yet". No need for v3.

Thanks,
Lijo

>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -619,6 +622,9 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add gmc ip block(GC_HWIP:0x%x)\n",
> +			adev->ip_versions[GC_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -648,6 +654,9 @@ static int amdgpu_discovery_set_ih_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add ih ip block(OSSSYS_HWIP:0x%x)\n",
> +			adev->ip_versions[OSSSYS_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -688,6 +697,9 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add psp ip block(MP0_HWIP:0x%x)\n",
> +			adev->ip_versions[MP0_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -726,6 +738,9 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &smu_v13_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add smu ip block(MP1_HWIP:0x%x)\n",
> +			adev->ip_versions[MP1_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -753,6 +768,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   			amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
> +				adev->ip_versions[DCE_HWIP][0]);
>   			return -EINVAL;
>   		}
>   	} else if (adev->ip_versions[DCI_HWIP][0]) {
> @@ -763,6 +781,9 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
>   			amdgpu_device_ip_block_add(adev, &dm_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
> +				adev->ip_versions[DCI_HWIP][0]);
>   			return -EINVAL;
>   		}
>   #endif
> @@ -796,6 +817,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add gfx ip block(GC_HWIP:0x%x)\n",
> +			adev->ip_versions[GC_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -829,6 +853,9 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
>   		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
>   		break;
>   	default:
> +		dev_err(adev->dev,
> +			"Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
> +			adev->ip_versions[SDMA0_HWIP][0]);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -845,6 +872,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   				amdgpu_device_ip_block_add(adev, &uvd_v7_0_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add uvd v7 ip block(UVD_HWIP:0x%x)\n",
> +				adev->ip_versions[UVD_HWIP][0]);
>   			return -EINVAL;
>   		}
>   		switch (adev->ip_versions[VCE_HWIP][0]) {
> @@ -855,6 +885,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   				amdgpu_device_ip_block_add(adev, &vce_v4_0_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add VCE v4 ip block(VCE_HWIP:0x%x)\n",
> +				adev->ip_versions[VCE_HWIP][0]);
>   			return -EINVAL;
>   		}
>   	} else {
> @@ -893,6 +926,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>   			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
>   			break;
>   		default:
> +			dev_err(adev->dev,
> +				"Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
> +				adev->ip_versions[UVD_HWIP][0]);
>   			return -EINVAL;
>   		}
>   	}
> 
