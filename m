Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A3AC64EC7
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 18:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B349310E268;
	Tue, 14 Feb 2023 18:25:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D57FA10E268
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 18:25:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfJp0zwnf0yNbS7zpTjiAar3/QyPaWe8HAqZ9cX8ZxR+ryK7BBE/40zGmCEhEDxGaDmdSU4rF2FUqBh3fqkWoBgpvK9+K5zr2AQeVq6ac6ffszOXADP3pMrqzVdkDc37410w1eIUmc3PNcXaG18za8un61S4R253tgyXuHM4BD5G6jQWfZq7Plt1QsX7Te0t2KhOkFK4fiLatgELtT+693lgFcL4LVeBCQEmTN+BsF0WI7kGnK4iOmPGRunqk8HWTOVw4L0B1xX7HhVE2DzKt4XFh7x3O+2aAjf6NYl5jn7EU3NZlUrUI8sEhjC3qnyrpbLMILjvNzvkT96PYlKjxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23joKXcjRHVBgQ4N7tmZnQXhdzJejDy40Vt4hmpfkSQ=;
 b=QPCjkbJ5Ruh6WZFc7qbdWrf5dPFgj/x3qZL5463bFW+zJq4j7a3JR6GgrjXyxIzUE3jdR+sYtsuH/E6UNcpUdYzCreczV392x2Y5hMMfQoXQQeZn1eS/PFm25T/1VGewyq6PUWdzqvJc5d+BCC4HRZhTK0GeMx27HPDtmr6HnFiTp0ZprM3XIUwAFXiL4zjyXp37piaSj9IftJAia70Eo3FhhOkEKs6jmzMcdUF/Ti6U0B+bjuIg3mK4UP5qnrsqf9tX/5Ozu1zwQGq2yDseSuHS2L05KBRxVIlKTLG2KZ00vYS7HFrcD1R3v03aYVs7C29VfJAFkOF0kwcr8GTiFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23joKXcjRHVBgQ4N7tmZnQXhdzJejDy40Vt4hmpfkSQ=;
 b=mk4WswkziA7UnZbS/dwTJXZZCx4hZUcobX9ryeJcivyB20OdaotPUvSRD5mXI4q0whIlgL5iApCJrJTekOqbYTINoTUozim19vy0Ad19RhPtYqsgrczAAaGNREggDSaJManuYdgKHWxFM2rfDAO6jSCtpCFn4za+hxuG3zQx9vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 18:25:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 18:25:48 +0000
Message-ID: <a3db32d2-4b51-2916-223b-ded823ac9ee7@amd.com>
Date: Tue, 14 Feb 2023 19:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/8] drm/amdgpu: rename gmc.aper_base/size
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-4-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214161510.2153-4-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: e47ba702-eac7-4708-9f69-08db0eb8e50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oT0zPptTXuSKjkdlwblAeOqo4UPzZ4yGnQKmfqcC2GO10mNAebKJbplSFmrhHLlc8pburDmjZXJjTDjaVIem/GDDrGXG/whlQnNMW2zzRhk14aW4XqGyMAGeiMQpBvwtkKIksBELuAHIq/CL7933ADCEyUUMFSSivx0B3TBUrETfSgWYA6Ef8ASZ9T9pGqMgMn30Uy0kdMt8qGunETzKLz0WoWG27YPL9a5zPHiNLmkCEWdtG8a5dKfu1APt4tQpa7ZVJ7+4mUzyEIaqhH2gXBYOl+Nj7xVbAgdHoDybS5jNg915IUEnOxBInmSaLk9oH6qtksg/e+eSy0Zb9GCfiy/uhmgox8WjCifO4GqTptzHAYdOYMeaFt3hnu/E1RuRm/RnfVd5iNHCA9plrGCF4/MzRTMtUJb9f4AvplfWTT6r83B8H7H08d5mK4uq4RGY388IarlRRs2+nO1PupJ0v62gkZbXEewmsJxSwConw87iqcXOGPyOR//Q/ZtCSOJeuqhuaq5QvtZHAaxBIsIATzAcFev4sQ3MtlrWPJ78jjDCm6FZ8TLfVvLXdyHTNdqFovCByqphJnb3R5+YgBY7a7LU/rO2vnGW0RMKFh+Vd+XZmTvxnySEUA9m5nwvfuaTT+NjIDRTt+4FBMKIAiXDl6Sr4EvIFmHNoY8qtP9PZJwKrg3ohq6TtUMBPZ1hiooDsh9zFTXocowy575Ri1+81Z4JkhGQwzc822i5VLcqo1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199018)(6512007)(66556008)(66476007)(4326008)(186003)(6486002)(478600001)(6666004)(2616005)(2906002)(31696002)(83380400001)(36756003)(66574015)(66946007)(38100700002)(316002)(5660300002)(31686004)(6506007)(41300700001)(30864003)(86362001)(8676002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZKN3pYbmFvWVF6M1FFVXRON0crTXE0R0NKdTFMaEFSemZrb3JiSFZCS3Zh?=
 =?utf-8?B?djFPMm1yOFE2YlVjNDFvY3Npa2RlU2JIOVNzdFNHUDR5bzNPM2tJUjFMV0pU?=
 =?utf-8?B?VTUvYVZkK01vcm04UW1WSWZnQjdydVhGekhkVkRvYzV4bHJ3RXdtY1VhdjZs?=
 =?utf-8?B?SzV0MEJmWm1DYkhlb2tlbG85alYzdkRGdThPNlI1U3BLODA4UCthdXFQMTVq?=
 =?utf-8?B?WVZhMkkwWXRIQ2ZKVGNlUUhMZ2hiblJROVNDbGJlL3orajczdGQ0Ty9ScG5u?=
 =?utf-8?B?cmtORGhIRlZYb0haNDU2QkdWMEcyNFNQbmYxV3NJU0J3azhVMXdqbmd6VG8y?=
 =?utf-8?B?YTlRT0F0ZWJMcVE3V3lNMHFPcUlDWVRxMXJ1cEhSQmNQTTNCS215SkZsb0ph?=
 =?utf-8?B?TXpQMnZ3RHZHTVMzK24wUVdPOWFRTHJjdUNCc3FINFV5Y1JBY3grS0g0WEdj?=
 =?utf-8?B?Y3NxNzhtTnVjSUFxZzVDMUUrTHhYaDVXYzZVZndNWDEvMEk3eWFzcjQ2WEJ2?=
 =?utf-8?B?WEtlSks3Z2prdVMzc3AzL1JSd3RtYnZtTWJNZEtvSjBRS3ZtYVIxU3duMFF4?=
 =?utf-8?B?T3hIeGozYkRrUDBSajhveVlLQnR6MlVzRDFSdkVyOG8wMmRKMmtjUkpEdHNp?=
 =?utf-8?B?L2pVN3RnUzNRcHEzSElxSFhCdElCbU1HMVpxTEZ0bDBFa08xeHZaVHNwRzJR?=
 =?utf-8?B?cjF2NkwrWHUrcUxTU01NTzVWRlRoVHlzY3dhdG9pcWNKUWMrenBYbGlRS096?=
 =?utf-8?B?WUdMWStTWUNlUkVsRXh4MzdJQURndVBySmJWRlFhSVAzQjBJWW5jSi9mSFE5?=
 =?utf-8?B?OXdTZGw5UDZNbzZEdEN4bGpFUU1aZDg5aFcxSTUzT1cxbzJ3YzIyQTkrekNl?=
 =?utf-8?B?Yy9OUVRjRU9VMWNndnoxeEdqL2hXMXBOWjdudHA4MUluMjUrcjZ3QXpLSlhF?=
 =?utf-8?B?N2VUVnk4aUpVRE1UaTdlRHVmOGJXZWxjd3JNTUNtQng0TllsamRUUVBIZWYx?=
 =?utf-8?B?ZDZwVEdpbHdZR1dvUnFKZ2Zhd0JydmN3N285NHRuQXlNTmFMNlUwV0llZU9G?=
 =?utf-8?B?L1UwZFE3R0s1M2RvVU43bTNnbkNxbGZVdTZWcVo5UUtxL1pzT2JKQUg2aGNt?=
 =?utf-8?B?MU9kSUhiY29aWVdvbU9aQ0hEVWRFMzdWN2t6cTlaMDd0OFpqaGdjU2lVcUxn?=
 =?utf-8?B?dmlxRnNPQXZkVlVYeGs3blU5YWJZU29rVTgyOGFmRVROK2E4THRudUpkRUVx?=
 =?utf-8?B?L01ZbzIvbUdjaGJUWnlZcnBKdG9RbkF3Y1IvekdYNFdrUXNpdkovY1ZDK1dw?=
 =?utf-8?B?VldxbHhzbzlWeXIwbEhIUEEwUHRlUHh6c3dkN241TWZXajROVEhtQWNBS1dT?=
 =?utf-8?B?d2k1Y1diZjlqbHdBNkl0a1RsbDVxV0t2bFdwOXByOEowVERVWG42ZWVHZE1n?=
 =?utf-8?B?KytkSWl3Y2NrTEFiMEFFNEhrMGxNTzZtamlpK002SWlqbmEzdmVEREU1MWpa?=
 =?utf-8?B?dS9jcUVzcWRidmpyQkcyTU14MVFXZ1RjSnNMZGN4NUFRaTRSelpFRjlIajRw?=
 =?utf-8?B?TTdndzlTeUtDTVg3cXJGZzVhTWNCUkNEczAzVm9FL3dQU3BsTm5zWnpUVDZV?=
 =?utf-8?B?NlowSERwYUtXbzRxZzY2ME1PY0lTU2N4VkgyWm9QT1h1S1UvWlFzbjdLcG56?=
 =?utf-8?B?U0dzUHVRckhiUldWNFJOOUMxKzhvWmY3TEREMG5NaWlrajRFMlJueDBjamlR?=
 =?utf-8?B?KzUxK0txOUpuRUFLUU4zaVdjUjdua0YvOUNBZlA4bzlzN3R5RlFHRlJLUlNq?=
 =?utf-8?B?SjJORmZpN3NtTUxKc0dmN3hwR29GTGJhMll0aE8vNlVEeVhCeExobG9Iei9R?=
 =?utf-8?B?THhEWVB4VGdVL2FuY1BRWWFJcGdKZ0E3bmxsbWZZZWRDckFERkpEdkZYMTlX?=
 =?utf-8?B?VHJ6SkJ6N282WkQyWWVLZmY2aHphSThUdlhuL1BqeEkvaytnQWxDLzBHK1RB?=
 =?utf-8?B?RTM0NE9lWGh6M2prTVBXYS96NDZZYTVwYmlEOHNzNFVudTh6SytBNUw1a2s0?=
 =?utf-8?B?TXNVU2dZRmVDM0xqL1l2UitPRTZLSnJpMDNlcGZQaGRHSmpqU2FKUVZ3VWUy?=
 =?utf-8?B?RFhDcjFUUUdNclV4WVlackx1OXA3RGZjd1ZtZnY3T2hvUkJpTndJRHdKM2Yx?=
 =?utf-8?Q?3g4CYDSw5VzlJNwdq1wm387RmL+86AL26Y+P8S8RnDYE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47ba702-eac7-4708-9f69-08db0eb8e50d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:25:48.4266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RZ5AadfBSotRySFqU9ijdaG18EKEhSI4v/GDAZ1JbKJfRAE1RDxzlKV19l9Fmftn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 17:15 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch renames aper_base and aper_size parameters (in adev->gmc),
> to vram_aper_base and vram_aper_size, to differentiate it from the
> doorbell BAR.
>
> V2: rebase
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h      |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c       | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c       | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c        |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c        | 12 ++++++------
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c        | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c        | 10 +++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c     |  4 ++--
>   14 files changed, 49 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index f99d4873bf22..58689b2a2d1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -438,7 +438,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>   	mem_info->vram_width = adev->gmc.vram_width;
>   
>   	pr_debug("Address base: %pap public 0x%llx private 0x%llx\n",
> -			&adev->gmc.aper_base,
> +			&adev->gmc.vram_aper_base,
>   			mem_info->local_mem_size_public,
>   			mem_info->local_mem_size_private);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0b6a394e109b..45588b7919fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3961,7 +3961,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   	/* Memory manager related */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
>   		arch_phys_wc_del(adev->gmc.vram_mtrr);
> -		arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
> +		arch_io_free_memtype_wc(adev->gmc.vram_aper_base, adev->gmc.vram_aper_size);
>   	}
>   }
>   
> @@ -5562,14 +5562,14 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   	uint64_t address_mask = peer_adev->dev->dma_mask ?
>   		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>   	resource_size_t aper_limit =
> -		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +		adev->gmc.vram_aper_base + adev->gmc.vram_aper_size - 1;
>   	bool p2p_access =
>   		!adev->gmc.xgmi.connected_to_cpu &&
>   		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
>   
>   	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>   		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
> -		!(adev->gmc.aper_base & address_mask ||
> +		!(adev->gmc.vram_aper_base & address_mask ||
>   		  aper_limit & address_mask));
>   #else
>   	return false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 02a4c93673ce..c7e64e234de6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -775,7 +775,7 @@ uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>    */
>   uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo)
>   {
> -	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.aper_base;
> +	return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gmc.vram_aper_base;
>   }
>   
>   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index 0305b660cd17..bb7076ecbf01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -167,8 +167,8 @@ struct amdgpu_gmc {
>   	 * gart/vram_start/end field as the later is from
>   	 * GPU's view and aper_base is from CPU's view.
>   	 */
> -	resource_size_t		aper_size;
> -	resource_size_t		aper_base;
> +	resource_size_t		vram_aper_size;
> +	resource_size_t		vram_aper_base;
>   	/* for some chips with <= 32MB we need to lie
>   	 * about vram size near mc fb location */
>   	u64			mc_vram_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 25a68d8888e0..b48c9fd60c43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1046,8 +1046,8 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>   	/* On A+A platform, VRAM can be mapped as WB */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
>   		/* reserve PAT memory space to WC for VRAM */
> -		int r = arch_io_reserve_memtype_wc(adev->gmc.aper_base,
> -				adev->gmc.aper_size);
> +		int r = arch_io_reserve_memtype_wc(adev->gmc.vram_aper_base,
> +				adev->gmc.vram_aper_size);
>   
>   		if (r) {
>   			DRM_ERROR("Unable to set WC memtype for the aperture base\n");
> @@ -1055,13 +1055,13 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
>   		}
>   
>   		/* Add an MTRR for the VRAM */
> -		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.aper_base,
> -				adev->gmc.aper_size);
> +		adev->gmc.vram_mtrr = arch_phys_wc_add(adev->gmc.vram_aper_base,
> +				adev->gmc.vram_aper_size);
>   	}
>   
>   	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
>   		 adev->gmc.mc_vram_size >> 20,
> -		 (unsigned long long)adev->gmc.aper_size >> 20);
> +		 (unsigned long long)adev->gmc.vram_aper_size >> 20);
>   	DRM_INFO("RAM width %dbits %s\n",
>   		 adev->gmc.vram_width, amdgpu_vram_names[adev->gmc.vram_type]);
>   	return amdgpu_ttm_init(adev);
> @@ -1083,7 +1083,7 @@ void amdgpu_bo_fini(struct amdgpu_device *adev)
>   
>   		if (!adev->gmc.xgmi.connected_to_cpu) {
>   			arch_phys_wc_del(adev->gmc.vram_mtrr);
> -			arch_io_free_memtype_wc(adev->gmc.aper_base, adev->gmc.aper_size);
> +			arch_io_free_memtype_wc(adev->gmc.vram_aper_base, adev->gmc.vram_aper_size);
>   		}
>   		drm_dev_exit(idx);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 73b831b47892..0e8f580769ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -583,7 +583,7 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   			mem->bus.addr = (u8 *)adev->mman.vram_aper_base_kaddr +
>   					mem->bus.offset;
>   
> -		mem->bus.offset += adev->gmc.aper_base;
> +		mem->bus.offset += adev->gmc.vram_aper_base;
>   		mem->bus.is_iomem = true;
>   		break;
>   	default:
> @@ -600,7 +600,7 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
>   
>   	amdgpu_res_first(bo->resource, (u64)page_offset << PAGE_SHIFT, 0,
>   			 &cursor);
> -	return (adev->gmc.aper_base + cursor.start) >> PAGE_SHIFT;
> +	return (adev->gmc.vram_aper_base + cursor.start) >> PAGE_SHIFT;
>   }
>   
>   /**
> @@ -1752,12 +1752,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   #ifdef CONFIG_64BIT
>   #ifdef CONFIG_X86
>   	if (adev->gmc.xgmi.connected_to_cpu)
> -		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.vram_aper_base,
>   				adev->gmc.visible_vram_size);
>   
>   	else
>   #endif
> -		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.vram_aper_base,
>   				adev->gmc.visible_vram_size);
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 9fa1d814508a..d66caad04c24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -649,7 +649,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	 */
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	for_each_sgtable_sg((*sgt), sg, i) {
> -		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
> +		phys_addr_t phys = cursor.start + adev->gmc.vram_aper_base;
>   		size_t size = cursor.size;
>   		dma_addr_t addr;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 21e46817d82d..b2e4f4f06bdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -825,18 +825,18 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = adev->gfxhub.funcs->get_mc_fb_offset(adev);
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 4326078689cd..f993ce264c3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -692,17 +692,17 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = adev->mmhub.funcs->get_mc_fb_offset(adev);
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> index ec291d28edff..cd159309e9e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> @@ -324,9 +324,9 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   
>   	/* set the gart size */
>   	if (amdgpu_gart_size == -1) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 979da6f510e8..8ee9731a0c8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -377,20 +377,20 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) &&
> -	    adev->gmc.real_vram_size > adev->gmc.aper_size &&
> +	    adev->gmc.real_vram_size > adev->gmc.vram_aper_size &&
>   	    !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 382dde1ce74c..259d797358f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -577,18 +577,18 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	if ((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) {
> -		adev->gmc.aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_base = ((u64)RREG32(mmMC_VM_FB_OFFSET)) << 22;
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   #endif
>   
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 08d6cf79fb15..a7074995d97e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1509,8 +1509,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   		if (r)
>   			return r;
>   	}
> -	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
> -	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
> +	adev->gmc.vram_aper_base = pci_resource_start(adev->pdev, 0);
> +	adev->gmc.vram_aper_size = pci_resource_len(adev->pdev, 0);
>   
>   #ifdef CONFIG_X86_64
>   	/*
> @@ -1528,16 +1528,16 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
>   	if (((adev->flags & AMD_IS_APU) && !amdgpu_passthrough(adev)) ||
>   	    (adev->gmc.xgmi.supported &&
>   	     adev->gmc.xgmi.connected_to_cpu)) {
> -		adev->gmc.aper_base =
> +		adev->gmc.vram_aper_base =
>   			adev->gfxhub.funcs->get_mc_fb_offset(adev) +
>   			adev->gmc.xgmi.physical_node_id *
>   			adev->gmc.xgmi.node_segment_size;
> -		adev->gmc.aper_size = adev->gmc.real_vram_size;
> +		adev->gmc.vram_aper_size = adev->gmc.real_vram_size;
>   	}
>   
>   #endif
>   	/* In case the PCI BAR is larger than the actual amount of vram */
> -	adev->gmc.visible_vram_size = adev->gmc.aper_size;
> +	adev->gmc.visible_vram_size = adev->gmc.vram_aper_size;
>   	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
>   		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 10048ce16aea..c86c6705b470 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -1002,8 +1002,8 @@ int svm_migrate_init(struct amdgpu_device *adev)
>   	 */
>   	size = ALIGN(adev->gmc.real_vram_size, 2ULL << 20);
>   	if (adev->gmc.xgmi.connected_to_cpu) {
> -		pgmap->range.start = adev->gmc.aper_base;
> -		pgmap->range.end = adev->gmc.aper_base + adev->gmc.aper_size - 1;
> +		pgmap->range.start = adev->gmc.vram_aper_base;
> +		pgmap->range.end = adev->gmc.vram_aper_base + adev->gmc.vram_aper_size - 1;
>   		pgmap->type = MEMORY_DEVICE_COHERENT;
>   	} else {
>   		res = devm_request_free_mem_region(adev->dev, &iomem_resource, size);

