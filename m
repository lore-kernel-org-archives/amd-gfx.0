Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7093EC43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 20:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092F010EBB0;
	Mon,  6 Jun 2022 20:22:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCFF10EBB0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 20:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFiTqYMBohbmJD4pu6TxVMvMXBru7+6jFrmE+AfBP2wdi4VMUShNOu1JUXWpXkTcmL9zWzlY+cCYH7E/i9ysJvhLIin4BC8TDVOON2XAx7AVShrPiwcp5szW8+XR8Fz8mWOyvSrLvnrtzxpv50tJ8IwUSaZTfW5ObYtKSE17J6HhL5eRepPsN6r4gUjQlW4THRuZGin87he3WzfGUSxpNe+AXpZpQlPfifdiZMT4mTndPdWrbgPowF1rtSTG4cOaJaUgibAV0v52f2KTo1/0kemokznuu0Tltc/fss7FrVFCfNOxouXnX77yh1QeIcNQxn7Cbqr+hNjzBLbnJFje0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR2GklQNokPDNlSKhnxZ0t3O8fMWhAdBI3bWv4DQwkQ=;
 b=IbJvGjTXZRmHhsD3Q1VdNJtK4RETWgDoRZHN8qmvNkO8GXIFybYtrg9q4me2iUEgKoKpfEzbGOL8BQrD9pVLcFozSuB6UStxK8hlnjvsC8V4JF0pqhtYHKfCc1cYDlOFAsdDLU96wmi0hwxtKFzpOLs+yy7O1k1y++SzR197vhKacgM0//ja+LeK9WFA6IntmEmKmqR2ffkKsxBRsBS95cgQxffYAVevQIR/y0PGnoQveZBouxQYeOyblXZLoHmr1H/wyKoXwZGpii9skF9IEUpL22hluF9lxDphpvQgrJqIhhZdgHeMlHjQdTMd34f9BvMwJ4UK79mmfJf57OZLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR2GklQNokPDNlSKhnxZ0t3O8fMWhAdBI3bWv4DQwkQ=;
 b=oAWFxl9E3LsAHDWfsNYA2IPOAW3LM/xx0BawxZxhgDDJi0RsrWATxbFFF2gWq7d7S6IHkmhdd1xT7QenmgJDpGT2kATGWeIdoNSkb7xj8l9gummqzhMVj7XDV8rMoj5t23xFa8bs6eFBzaMzp+GmlpqVqcwXlQLeRAUWqmiDB8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 20:22:53 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 20:22:52 +0000
Message-ID: <700776c9-4ed2-9ac4-50c0-1f261a6a7678@amd.com>
Date: Mon, 6 Jun 2022 16:22:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] drm/amdgpu: Add peer-to-peer support among PCIe
 connected AMD GPUs
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220606180742.3313561-1-Ramesh.Errabolu@amd.com>
 <650bb659-e29c-d0af-b104-5897d6c3ac03@amd.com>
In-Reply-To: <650bb659-e29c-d0af-b104-5897d6c3ac03@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6806486-e89a-4fcc-3939-08da47fa54dc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4289:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4289A338681864046E73997592A29@BY5PR12MB4289.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6uVLn6SeMLucfWFVLpzrATab44AJjYJCIaA8OleAzVXR+ifZI5lsR4HBhG3icBlFY92kLPZEtrDyrvquWl47Htm4EfjgbbHJWspL2BnKqVJByPVdX1HGYAw++NYFzKFx6nWTS1H2I0p5BUI5Z5zTrcT4xZ1vgIiP3nIoslzaPJehNjq+Qc9sbaVuJLwnzGJDCA2UbYrp6z/oDfhmGBnb/uGag1lisjVLrUJswekQzt2HuDMu/BSY00T7f4q++cFXO7enebUNw6Dgu4YLBrudeUAMyItSEei0LOPb1UXbW3RChqfpbzyqFBozLBHPusSoUlynVHVQspZi7tIyBRdMAQ4Cw6IjliTrZLmxorYjhKU1l8FBnoOYeTLg+O7wRxyYlhFqpZvtyw5J5S6qp1CHcK/HWV+5veKbCUGHxggq1kNSqy6Cdm4+OICk8fupP6CKG+6BJp1Q6eT4Mm5b/8G0znfozZiG9lASops6dNX/qAAvnpizBLjdAStZoKodOX8l5RWxM0lNgoCVOfMpqY3e5bdf25/v8OsMJY1XkoNUJzn/YUbmTJ4VD/MjD4WkT9H023NFejpnDWxhuDL095+b26MoUQe2tfFKp3VoqOXlMY4COqpPMnrr+p62T/LJMG405QdbHG4rLjW7O+Ms6qPATA7ePo53l7B/SbeRqKVpEDnQ/dpi4nlABFhV+ZPxxXMMDqRCdyLqeRLwEBQnUVhki0P/9fGYOteJMz7lD3lB5XBCJ3RNxbsGhCSBiB+4shOu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(38100700002)(31686004)(31696002)(66946007)(8676002)(36756003)(2906002)(5660300002)(44832011)(508600001)(26005)(8936002)(6486002)(2616005)(316002)(83380400001)(6506007)(6512007)(86362001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRFUWdmN0Z3QUo4S3hDaWFzVmxkSzVVVkFSOTMvYXQ1OEplby9LRkNGc0th?=
 =?utf-8?B?L1lmdGc4aFRmaHlZVUNJRndEYkQxWU1ueUZ1YXdKSE1oOGtxeTRjYnduWlBT?=
 =?utf-8?B?RWNoVGFYYkZjMEM2dEFVNUx3ZUJsOFh4YnNKdC9mWnFDciszVnRJVlY2K2dM?=
 =?utf-8?B?anlldEJ5ZkRrOXhxSGR1VjlJeENQMUttOTJHL2sydjFzcEVsSTBjZzFNSXpy?=
 =?utf-8?B?ancreVc0Z256L05YMlNnN2JCWTJVOTlrL2lGdnl2amVOT25KbGRWZHU0WGwr?=
 =?utf-8?B?dnkraldnZ2p3QzNrRzBoTjBHYzlVRnJjRDd2VGpjVHR5YVVDOTN4dGlVbWhP?=
 =?utf-8?B?RC96d1RXcG1RSWpsMDJFRkhRTkpCZHM3RThYUzdSeExpdS9nSXlySHF2Z1dY?=
 =?utf-8?B?dklFcEowdXc4V1k1UGQ5MDhIM3RyWkxjTFJqdktyME1vdEl0cG8wSFZwcVBv?=
 =?utf-8?B?ZDhMaVE3eFFTS3dWcGpMMFVRZ3BSclBqQ1BQY2pMQ015TTdubmFDQ1JMb1lu?=
 =?utf-8?B?MTI3UE85bGt1S2FSTkZ5eW1pUkhnU3E2dWtaaTIvVitBODh4MVc3QmpaMGNN?=
 =?utf-8?B?NncwR1pEbFp1cGNZSXpmdVVtR3d2TjBORU9NWjlndUU0dGVhellvekpDYVZR?=
 =?utf-8?B?TGIvbGpveGNWdi9TY3BDNXdMbWVjZWtyRCtmb3VYMHgvZWJ4MGt5QzBad2Zv?=
 =?utf-8?B?MmU2cXRvV2ljY3pETUV4UzdTeWxMYUIxMEZyRmN4LzR1Uk8ycXUwTVAzMTRU?=
 =?utf-8?B?NDBKRDhOTFF6akRrN2lLYk9PZ3ZDTGxSSmpyRWFja3F4UWdKcXZVT3BLMlBw?=
 =?utf-8?B?TCtkWWMzTjBMQlFTdVJIc3F3cEgyZCszTmFXajRtZC9QL0lnVkliY05ydyt0?=
 =?utf-8?B?V2s0b2dhaUZGaWJXVlNuN3pOMjNTNmdZWHdjZ3JiSUFOcVdhY2IyN25NaFJI?=
 =?utf-8?B?TU1aaDNkdUc3MzZsdEs2RGRzblptVFkzWnFLTDJmcjZiMHpoa3FncitXSnFS?=
 =?utf-8?B?M2RhNnJuOTEySWFUV2h2S3dCendVK3dsUWU0UmNKbkJoMUhKYUliOFlEV1Vq?=
 =?utf-8?B?MzMrbitGMUJIcUVVdDA0Y2NHMEFMUnJ4c3RadDZLekNPQjJtdVpUaG53V3A5?=
 =?utf-8?B?NDdYSmNlOExwL0dyR2E3b2gvdmZteThRc1pNZTlFVGpZRmN3SmFzUUVnQ1Iz?=
 =?utf-8?B?MkkrUCtVaCtPTkxoQTBFME9rYjVxQ0FpM0hvYjdBWE9IMmVPYkdCajRKZlFP?=
 =?utf-8?B?UTZCcVJaRUlFRXF1cG1vcDNNc0VWYTVFVWVnSW1EWUZZdlR2TkhZVTFaS2Nh?=
 =?utf-8?B?KzJzMW1RNjE5UHFHYmJQYllad3RITDdMa0FGRnRpZXFzQ2t1UTdQajFQTWJZ?=
 =?utf-8?B?a253V1pzd2haWmhsUUMwcVBCRWc2elNnVUFtb1dGb1VpUXRKWGdmOGt5eTF0?=
 =?utf-8?B?TGtZWlJyV2lNcW1pUG05OTRrRHN5cjR3V3BkVHB2UGZxcVBDcWRKYUZ6cnIy?=
 =?utf-8?B?dWpmR2U0RHVoYzlzSFNDN28zUVZvb3NDMDQ2VnRtdVRtZWxhcFlxTnNmaXJq?=
 =?utf-8?B?b1B2ZTE0TGwwTDUvUXZqOUpzN2tmdVNuWFlUM1hrWEpycTJ2RUdCMzRqNXRQ?=
 =?utf-8?B?d1RKK1ZqMi9Tbkl5eW1nTG54Ui9wbmRGRE9sU2hkQVBITnRnTkszcFFvZFh1?=
 =?utf-8?B?c1RSRlBvbStiUVB5MmhXd0lZUXgrWHVoZ3orNXlkRkpCUUxXK3Rjci9qdEtv?=
 =?utf-8?B?MERMb0JPaWRvTStRMld4dTI3c0huUnc0czNleldsRXA2bDNvY0RWZ01LR0tw?=
 =?utf-8?B?WldhNmZwekdCZjVPMXUxZTdvQzVFYWRvM1JxMGRNeFNzdVpBeTVqWlk3VDlO?=
 =?utf-8?B?YnpabmExb1VMMVF6WWtRd2JCNWhDdzVmTDBodnpGbE5rNUNaSThKYlNzVnVV?=
 =?utf-8?B?NDBoZzFxRXROYmhaU3RvWm5TclJBWUpSek1uR2NBb2dQU04rbWdoRXJ2UDY3?=
 =?utf-8?B?d0pmUHlybjZoKytOZlhETlI5c1BkN1F1dlFMbjQ0a2xqWm9KempaL3pHbkl0?=
 =?utf-8?B?MEs0SC9QNm9lNG54dkRNeWVaNVFVeHVQZUZNaVNFaXA4MjdmdXJSemtRa0pZ?=
 =?utf-8?B?M1k5MDRIOURvN2ZnR1F1QWoxNTdpRlo0M2RRMGMyemV2aCtKTlJnS3dHck93?=
 =?utf-8?B?TWcrRHBrdEhsNERTZ2RNckZDam96TnU2QmIzbHNtRmNOWWdEbXk3SWRyMEVs?=
 =?utf-8?B?VThoblR2SW51dSszNVMvZ1VUd3JNQjVVMEkrcDRCYlhsMUZDTFhUUWtOVjBR?=
 =?utf-8?B?ZnZWeEN1aEdqWmZReitRZTRRQjBXdGdiMmExMm50QnhxdXN4ampGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6806486-e89a-4fcc-3939-08da47fa54dc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:22:51.9023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea3QuIX1YM8HDAVhE7xOLtCmlB3o+unnUciRau8+BaPr1XyYRL+ZSJbtJRIoYLLBN1a/DWjCZCk0aqwhGiSnqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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


Am 2022-06-06 um 16:04 schrieb Felix Kuehling:
> Am 2022-06-06 um 14:07 schrieb Ramesh Errabolu:
>> Add support for peer-to-peer communication among AMD GPUs over PCIe
>> bus. Support REQUIRES enablement of config HSA_AMD_P2P.
>>
>> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
>
> Sorry, one more nit-pick inline. With that fixed, the patch is
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Really inline now ...


>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index be0baacc5942..8e88e7c88d26 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -34,6 +34,7 @@
>>   #include <linux/pci.h>
>>   #include <linux/devcoredump.h>
>>   #include <generated/utsrelease.h>
>> +#include <linux/pci-p2pdma.h>
>>     #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_probe_helper.h>
>> @@ -129,6 +130,8 @@ const char *amdgpu_asic_name[] = {
>>       "LAST",
>>   };
>>   +extern bool pcie_p2p;
>> +

This should be declared in amdgpu.h along with other module parameters.


>>   /**
>>    * DOC: pcie_replay_count
>>    *
>> @@ -5498,6 +5501,36 @@ static void amdgpu_device_get_pcie_info(struct 
>> amdgpu_device *adev)
>>       }
>>   }
>>   +/**
>> + * amdgpu_device_is_peer_accessible - Check peer access through PCIe 
>> BAR
>> + *
>> + * @adev: amdgpu_device pointer
>> + * @peer_adev: amdgpu_device pointer for peer device trying to 
>> access @adev
>> + *
>> + * Return true if @peer_adev can access (DMA) @adev through the PCIe
>> + * BAR, i.e. @adev is "large BAR" and the BAR matches the DMA mask of
>> + * @peer_adev.
>> + */
>> +bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>> +                      struct amdgpu_device *peer_adev)
>> +{
>> +#ifdef CONFIG_HSA_AMD_P2P
>> +    uint64_t address_mask = peer_adev->dev->dma_mask ?
>> +        ~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>> +    resource_size_t aper_limit =
>> +        adev->gmc.aper_base + adev->gmc.aper_size - 1;
>> +    bool p2p_access = !(pci_p2pdma_distance_many(adev->pdev,
>> +                    &peer_adev->dev, 1, true) < 0);
>> +
>> +    return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>> +        adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
>> +        !(adev->gmc.aper_base & address_mask ||
>> +          aper_limit & address_mask));
>> +#else
>> +    return false;
>> +#endif
>> +}
>> +
>>   int amdgpu_device_baco_enter(struct drm_device *dev)
>>   {
>>       struct amdgpu_device *adev = drm_to_adev(dev);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index bed4ed88951f..d1c82a9e8569 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -802,6 +802,14 @@ MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, 
>> "No queue eviction on VM fault (
>>   module_param_named(no_queue_eviction_on_vm_fault, 
>> amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
>>   #endif
>>   +/**
>> + * DOC: pcie_p2p (bool)
>> + * Enable PCIe P2P (requires large-BAR). Default value: true (on)
>> + */
>> +bool pcie_p2p = true;
>> +module_param(pcie_p2p, bool, 0444);
>> +MODULE_PARM_DESC(pcie_p2p, "Enable PCIe P2P (requires large-BAR). (N 
>> = off, Y = on(default))");
>> +
>>   /**
>>    * DOC: dcfeaturemask (uint)
>>    * Override display features enabled. See enum DC_FEATURE_MASK in 
>> drivers/gpu/drm/amd/include/amd_shared.h.
