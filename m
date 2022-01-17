Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB5FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 11:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A3810E14D;
	Mon, 17 Jan 2022 11:54:52 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A1810E14D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 11:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYdrvtTVxNLhqqVDcz10+2gSuE3CIpnh8hjAtuThxB0gzk/DvhE+Jdh7GI3X2ooQdIueg14IMH/CZRbSgCmOxLkd9UHySFagRSj7K2I5VT2g7XT6rNbu98lhBsLSbtbV6O3+ZB1X6F1Zn6ZwE0PxVLFBhXf8Eo/aPXcXlbKer+85PpUvoy18doWDuDhKMztarJwZW3HOAXUYeSeAO6AmbxKzSTOc4+cAO0oMp5irDiSWFOXGMmRlEgN5/9WOq11XPjlVInfDeGwhlN0pqZilDwIMjOLkmOSw5RUSX8JaiVtErbsLULDklmLfZTQhrbXxDJZUcMbCtZgH2RlKcmb82A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YmuYCkmNp3e75XMcki89TjF037Q5wwNm9dRg7e4Jl4=;
 b=gp49CHxdyqFN2R7qFcxMDv1t8mOHd2V5Cd9IYRVyP2pDBs4g/b/THcF15UdX03kHuRvK9X7A7FU83fuODh0YGiFFNMIQFI3mBvVmXIlVRklxvC8C4Ye+7LIryLsGfXk9aswA4w5ZzDVcCyBlfDb1CwfQjJUAD0NykYjq91Zb1C+5yenvZJcMsG2GseVIOBdH846arQKtiRLIevwbiC91iakdPeF4+2qVdUevlw5hLcWIbMdLFJMC5W1kMdQHuKGNNHYurxBX2C/iAPxZRhZyVILX4KOxKkz6Y2wk1XBhTAFh/EeO76mVAEKWiKeHfktP/XUJxULps/JLDh2jAb3OUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YmuYCkmNp3e75XMcki89TjF037Q5wwNm9dRg7e4Jl4=;
 b=QdCP/m++rOXEzFpxkSB1+WHF4lB9+ZNEXV/mdA2sFUYyy9VIJSS6ROpDhmDE68J0xxUdNNUVPP+l7iKi/W2KBgkIzSdGyih8sPyvELQBz/rJXLQrhvTuMHV2kJ+h+Q/5f9l+lBxlwEsb5DqS2ehWoqmEUv1wzuGTmUAoypRBrZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BYAPR12MB3365.namprd12.prod.outlook.com (2603:10b6:a03:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Mon, 17 Jan
 2022 11:54:48 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 11:54:48 +0000
Message-ID: <cb191582-60bf-dc15-2e98-85a383f08d75@amd.com>
Date: Mon, 17 Jan 2022 17:24:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad1b73c3-df0d-4dde-3fc7-08d9d9b0294a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3365:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB336553083CB7D7AF6206338697579@BYAPR12MB3365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgutEv4O8BK4z/84K9Ar+zPOQswlLJHkHIjfBEAoY6XBjmwKDrbOck7vy6wyifp7iHms6k4YCH+x0z5K51kvc3trGy6WGsK67HGR2EGAbG8UftRKo5ZZ+vfg6LyxBcI74/nHYzkBBobHBhYglrKxpL8pAkTWLSsX5cSRB96A5QQbxgdvMjOt7eTMLPSUa1wcSlu+5sIyBmAwK205S02YedBNQ8MbutQBQNlumR44KKJ93N/3NEXy4XCIq51CcrGzZb60ov/7ED1fy5Vqjw79M0FG5OlfTXK0/vxjHdO070AEkM5eWLmsPSUCZmhzmuHxZOvu+01wjmL10643ghaRQUWY0Gu6TQSkYgnZf2cwUB8mUwIIRaXShByKnqBuTCLl3kTq7bsBCGnTbXwe37WjXlY7e74c42ycmWvjERv/7kXTqhk1g4xcK5z6YVLgi3S0PBhXTK9x9LJbZyuaCYsySZ7jAhbHM009rpOOsHEpY9kt8uNeuFQxRVtjrfhjiPq0jvk1ucvb89CWPeY2U5EhDTKCIDABHInK1+2i4BtMlWZzVzL/3y8sxZAdqLLBruniAl40em6cgE+dO6Xj+fsfoLNfRo6qr5hXQ+2DOfI/IgoE28rmzrDIxoWKxMIBNSohzLoymUxIR7YDY+OgfNMeUrkgmBJIVxnpAKfGz1EeiPvjVKtinQtVjTMrRlOSe2ENcNIDphJZyfAE6sC94KI1vlXdQTBF3Fwb0r1UpVrfeEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(31696002)(2616005)(26005)(186003)(86362001)(31686004)(53546011)(66476007)(66556008)(6506007)(8676002)(66946007)(8936002)(6666004)(6486002)(316002)(6512007)(36756003)(83380400001)(2906002)(508600001)(38100700002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QllrTkorVVY5a2Rhc1FnemdmNUtnMU12VjFDQ3RoUlNiclNLRER5RTBSek9i?=
 =?utf-8?B?U0xFYUVNOXBVcnhQckVOTnptR0grUXBsMkVIVk41VWliWGtHa3g4WndBSWQ3?=
 =?utf-8?B?aC9EdUpFUmRzYWF1YkZ4NDU2b3hVTHBSYloxTkl0a3k1R3duSXBMbkhsUVps?=
 =?utf-8?B?M1c3Y1pneThTVGtzcXU1L0lhTXlZTkpkTUVlYTNOSUJ1SnR4aVJVMVdvbTN0?=
 =?utf-8?B?SE1oWDBpYUprYis2bEFFRU5aZUhhMnZtbDBZcXo5cm5yVmF0blByYkZLbENS?=
 =?utf-8?B?VkpzR1RrdzZjV2RhZW0za29vZks4MUh2Y0pFeGNndklLZ1hLaDhPYXVmYWR0?=
 =?utf-8?B?a2dmVGliKy9ta1J0Ymw1RkVoNDZXOHJWTS9yQjJhRUxidkpjVnowYU9lOENX?=
 =?utf-8?B?OTBHRDBCY3podThzcGY1N2pCSENnOFdzV25VTjh2RGU1VDFjZ0ZYQTJrZCsw?=
 =?utf-8?B?aHBCbmxXWjZoOGI1R1RFZnA2bmVFbDVNN3VwN2dRczVRYm82K0M0S0d5TC9N?=
 =?utf-8?B?Mm01NFBTUTFWMzZ2a0RTSDB4YXZIYldaZm9uZ2FhWFFmUFpwbXg0UC9MakhF?=
 =?utf-8?B?ODg1NjJkNWZwVDNBcUxGajMwd3BtNElBVzNnZjFEdDlEMHhNUXJ0ODdmM3VL?=
 =?utf-8?B?SmFuWWhsTWV0cmVNYTR6UEgrVFB5Q2JOQU9IcmczQi91SkJtSEs5c2crdlpm?=
 =?utf-8?B?SXEvVG1NSFRkcWdoWTkvMUc5Nk1ZWVk2c2puRkRPdGJ6aWVIRU8rRVJJejAv?=
 =?utf-8?B?MllEV2hwWjhCMmgvcXhMNVp6Q0d1Z3RiREY2REc0N25ieDc4alhDeFl0alVY?=
 =?utf-8?B?a3JuWUhtSDU2bklZbkcvaVNZZUFYUDBXTWZGR0luTzVRa3paRm9rNEI1Y0NX?=
 =?utf-8?B?am1hRmt3SEFlSUVlQ2h2bm5Ma0dIS0g1VC9UTWtqWGt6a2JLT3ZJQndHblBC?=
 =?utf-8?B?UUVFRS9DYzAyR3hDVW9VRHhWQldtcXV4b3MxMXNXN3U2UnIwM0dEalpHUWxo?=
 =?utf-8?B?UnFxVkR1T0JZQ2hpNnZ3TldTeE5mQmtJOXNFUVNmN2p0N3JWSmRYV2tzUTIy?=
 =?utf-8?B?c1V1a05OQ0hZbG1vRHlHb2l0blBDbDd3bHVoWk94U3lxaWpHb0NLemtDdnl3?=
 =?utf-8?B?a2VRN1RhYjhJNGJ6RkR1K09WdElabm45bkR1dHlmKzFFRVZ2MXVWR1M0YTFh?=
 =?utf-8?B?VVdiNm8rQUYxdXJHZTRTdGR5dFNMMUNhMkNPem5admNPd0NjVXl0K0FRT1dD?=
 =?utf-8?B?R3pSZnE0K3JCWXprSllkV1pka1hhMzFmUVNQOUwyOFB3blVyelVvUzV6bStW?=
 =?utf-8?B?Mk84UDBqK3RYWXd3Y3ZVVS8rWlBaR3ZMZkV0alcreGxOTXhXMVF5UEZIVW83?=
 =?utf-8?B?cFczdlp0cm13TmNoWnJGelVOcERtYm9HVmhkcHJueVVMSHJqWG1iaFRVMTNp?=
 =?utf-8?B?SG5WM002OGg4Z0IvSTFpZ2l0c3BadXUvUzFKdkhRc0FpQi9nRXk1M1h5U2lW?=
 =?utf-8?B?bTlpbXA5Qk1lZjRVbXJMVjllbm4vOUFnWUQza3FiOTJ1aE5kN3ZkZWNlTkFV?=
 =?utf-8?B?aEVMeXVMcndvMVM2Qk42UDI3UnY2a0xQdXd0eCsxelQwbUh6anpKNW5pWTJ6?=
 =?utf-8?B?eUNmaDJtRGs4N1VCQTRrcDdPYzcvK3owK0Rhbmh6V2hLNW9leXVJTGIvVUdS?=
 =?utf-8?B?b09YT1Y0WU9nSzc0MmlybU5oUEZHcitXOWtrT0t0SUhaNTNGbm9KT01EcllD?=
 =?utf-8?B?bXRCNVFkdlJaM3Brc2JnVm85NWd0cEV5WldUWGtsRERGT1BaemM2M21EVm5v?=
 =?utf-8?B?R1BNWXRLQ0x6Z2g4RWtaWGxqd080R05lOUlnT1pvRmt0ejFmVlJjOGprb01P?=
 =?utf-8?B?NDJad3piWSt0TnZPK0RoT1NybzZVN1VrNjBVSlhOSUxDSmpTWkxpNWM3dkNC?=
 =?utf-8?B?OUExL0ZRSmUzOVp0QUhLcDVCWkQ4UzZPdVBTR1ZMN3VDUDVGb2tLdmY3NC8y?=
 =?utf-8?B?SlFGU0V1SzJ1ZCtrOXFqSW0vSmRjdFZHU28ydGlqc05Fd2V3Y2hsVTdSTmVk?=
 =?utf-8?B?TmtYeDlwdWwxOXdQWU9XMkVVM0ltc2FoUFFTUG5IMSt2cDF4aC9wWWxldFNa?=
 =?utf-8?Q?neVQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1b73c3-df0d-4dde-3fc7-08d9d9b0294a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 11:54:48.6088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXyB/JiAz3IBepRMQgVgqqWziQcDb/on2puL5JmBjH9K6ebzdbRnxd65sQo9pwla
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3365
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/17/2022 12:03 PM, Somalapuram Amaranath wrote:
> AMDGPURESET uevent added to notify userspace, collect dump_stack and trace
> 
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 45 +++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 2ec1ffb36b1f..b73147ae41fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -529,10 +529,55 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   	}
>   }
>   
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent
> + * @dev: DRM device
> + *
> + * Send a uevent for the DRM device specified by @dev.  Currently we only
> + * set AMDGPURESET=1 in the uevent environment, but this could be expanded to
> + * deal with other types of events.
> + *
> + * Any new uapi should be using the drm_sysfs_connector_status_event()
> + * for uevents on connector status change.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev)
> +{
> +	char *event_string = "AMDGPURESET=1";
> +	char *envp[2] = { event_string, NULL };
> +
> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +}
> +
> +void amdgpu_reset_dumps(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	int r = 0, i;
> +
> +	/* original raven doesn't have full asic reset */
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
> +		return;
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
> +			continue;
> +		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
> +
> +		if (r)
> +			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
> +					adev->ip_blocks[i].version->funcs->name, r);
> +	}
> +
> +	drm_sysfs_reset_event(ddev);
> +	dump_stack();
> +}
> +
>   static int nv_asic_reset(struct amdgpu_device *adev)
>   {
>   	int ret = 0;
>   
> +	amdgpu_reset_dumps(adev);

Alex recently added a patch to reset GPU on suspend. It doesn't make 
sense to send an event in such cases, guess the original intention is 
for gpu recovery related cases.

Thanks,
Lijo

>   	switch (nv_asic_reset_method(adev)) {
>   	case AMD_RESET_METHOD_PCI:
>   		dev_info(adev->dev, "PCI reset\n");
> 
