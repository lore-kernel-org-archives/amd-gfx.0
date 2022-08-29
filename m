Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D710ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 15:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07B110F3F3;
	Mon, 29 Aug 2022 15:26:04 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CF7110F3F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 15:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz0NP/sQljWTt0bWTWDlbApJF5LE8Sn7QQS1ST0uXzgPod5vyYFkL8vvqhSM8LY1HtYF+Jvt0Gh1nwaZWB9fQLXA8JCkQr/nY+i80ITR6bjjvw6kEFoMLP6Co3gVdULGx6x37Af17YpYrT6sfeCyW/QJBTfUJoC+T6v1FuE9kPL9kE64swgDg+xsaRjAaa29X5i5f8kRKtT+pY36psHcCVKMB1QzZ/9DXSuFZZADZ7xmeGDDIZ8Pv6V8iyCmGzApdEpWQh1qfCb3KwBe1V2pjh/b8RnToocOT8s4soIfFsXDvp290eiloJS/9ZTT+e425MGAuhk2G8M70Hzw4T9kGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mnrxRf7u/xzx95sB2H5y11A5CMdkEv7e7ZJIkWZyAQ=;
 b=fyz1SLZN26Eyzy6w6G3uo0iRSfN74CUVd1Zddjd+byPm0FSV9ZyzuOYVaL9JarVhNRPNj2vCCZciYkmxkBWpSAhOYNxgpZsTQ0Kqp03yk2EwQ2OispuD8XPGPkjvtSSVHYAEO8m+p/28BJkBSMAaTj/WymaRBnh0iJXK3tgOqBD6kX08ovsGC9l0xUgDNONmupahPVgWoGih91uYmc2RXmuu3MXuZ8lPabXEt7M2uzQgz5yYAo/51E6MATkAw2l+j/KLiDfM9qGfKmhctc5ad2eq9YBKFJdfdlHubg59da8ElW6Gds1NGjVYUNrm2R53espa92d/tLMVO+zrl84+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mnrxRf7u/xzx95sB2H5y11A5CMdkEv7e7ZJIkWZyAQ=;
 b=OzYulHdB80WFDhH1uRZ3Uybr+H3H0Edvd/wYmJ3QXwTWvwJbdf60cFszXtC/zYyqlHA+KtAYXrstXfGDnr+kfta6TVp6+zBLPCqW0Bc67Thw1ITxv8pk9hUcWd+9FPCCMxPfloU1Inrs7YgfGCSNaSHtu1YrJCr8syI2ZXfBcQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6118.namprd12.prod.outlook.com (2603:10b6:8:9a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.21; Mon, 29 Aug 2022 15:26:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 15:26:01 +0000
Message-ID: <e24e5663-bdba-d80e-07aa-270b074c7b5b@amd.com>
Date: Mon, 29 Aug 2022 11:25:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: ensure no PCIe peer access for CPU XGMI
 iolinks
Content-Language: en-US
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220829150052.5913-1-alex.sierra@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220829150052.5913-1-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434947bf-5a13-43b0-a1d2-08da89d2c76f
X-MS-TrafficTypeDiagnostic: DS7PR12MB6118:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVkU6vNMY4qq5AG8TbBL9DmoVyU0MIsFq+9ushkezVbVbOG0TRO6WlqegFCOihYrayhvMRUS0Tlc9XRlroM7p9mK2bPnhCocqdgqtCMeW36jfb7Z/hxzlIgWYa3zwXGjgWW8fRs2rBzvqDsBxlHetqVDE2V7MzLXrv0TV3I5MKHFHdAmtrwlX9AV2Y0bMjzMPh1vAoJmr++pHSParY12G+4IQfXrDjfDRUGSnSxkcdGTqFJB9AzVyWtvSggsPl2z0ODkyrJJTNFBKJGo5Lwya6pYxBQ1CNwnQBSlLEnUdx1aaIqYFpaGVonkT5YhFZjUua+DYufB2wFwq2C0g7Y8q225j60Xc4WWFdSE6mr8Mnvq7+EGpMe6KJugssacM/pxGyIw3Cpc0BTmSCf6pZNv/8jl2FCkkPbD98yRKo1Ij5FN7eO7giJ6cuS3YRHAhsSNt9inxC4818ONcxarW4fuZskOEcYUYR8QteOhhmym/j9/dgeZIvaT8cm3CdwP1HdX80ni9tvMgbqXKp9E2KvA8E9ajXu+TyJwGh1PXaBCDG+0VrA1QQrRWGfgJr9+v5djn1X1ufMu90jSutimN6+h7FBp5rpzmF9c/tQJgRMD76jtTVxvrmrCBRhuVTWuh6odwYkSDeTGqVp8ZGt1cB+36hdQNtzTiQXyJybuSHCTCOpoOp1pXrp7hcoJ6Xao9tOce5XggDVvuDFhz251QZPlRU2KwqDSr+z/ukzHMGkWcrIBic36u5ntT0tTYbYu4aljTfenXJ6i9Xo+D8VvwLmW8RvRV3KV7BgG6hWjIzZPfog=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(26005)(6512007)(38100700002)(478600001)(5660300002)(44832011)(6666004)(86362001)(31696002)(8936002)(41300700001)(8676002)(4326008)(2906002)(66476007)(6486002)(6506007)(66946007)(66556008)(2616005)(31686004)(186003)(36756003)(83380400001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2wxWVFpcFRBa1Rhb0YzMVE4cHhvaG5TWStjVzR6SU16SUxUQ2F1aVpJZ2hs?=
 =?utf-8?B?MEJvSkpROG94ZHVYQ1dFUW1GRVlFZWxKV1g1US9yQnE3SlBvTmw5VHUvNzRw?=
 =?utf-8?B?OXNMcWdET2MrWEo2bGhraG9XVkNJMVF0V0Zud0g5WCs1d0VGdkhnbUpRWFJF?=
 =?utf-8?B?SE9peXNFbzdmaTBDanozQU45YTFYN3lxN2U5c3NlNU1WMzdIWG52VEwrYi8v?=
 =?utf-8?B?WG1HbzRCQzRUUGlPbHhGRkF5T3JVeWFsQkxTaFZHRVQyRFd4SFZOTHRRa1dQ?=
 =?utf-8?B?MlU1U094L0kzUEhGTGk3cm1kcnd3YVVTOHlzSmJ1c0dIdXcyMDZFeVZEMVR0?=
 =?utf-8?B?cC9GbjhhSm9Ic3NRREJ0bGlMeG12VWF1U2U4cUNVRlZuQ1R5TVRSOHMxNnNw?=
 =?utf-8?B?bzFLakZaRDBRblVmUDcrVFA3NXhNT09pNk5TUlRrb2wvcmhtUzhnRE1yZGZs?=
 =?utf-8?B?RmZkU1RoZk5rY21pZmRXb0xWV2QzMHBRN0JSb1NLY3ZhRzBGZTVyZ0NKN242?=
 =?utf-8?B?RmZjVGdHZEVDZVk4b2o5MFVZcjh5ejRuM21DZjNNR01XNkFFbENCUjlmbDJk?=
 =?utf-8?B?NVROWG01SjhLMHovY005T2hpRWpXVWNJZVVOVGxUVE5KdVZVc1Y2UlFWVEM1?=
 =?utf-8?B?bU9KVCtTMXlkbGp0aGpqUVF1N0wzVjc3Z0gwenNNUlNqc256OGRCYWp3Q2wz?=
 =?utf-8?B?VFN6WTIvMlFvQWFBOXZSeE93SmE4ZVZ1NUFUL1VGRHRZcHg4eHpQYy9MSGVN?=
 =?utf-8?B?NVlOYVNsVm50V1ZNUG5UWWhWNndYdFBrc3ltZ3p5SDdVL2VYaXhSK3RoSFd3?=
 =?utf-8?B?UXBLQjRwYnJZWVRGRVJCYWU4Z0FsZ1lIMjRwaGxZZFFiR1dWWnk0UVdLUW9O?=
 =?utf-8?B?TWJwYWRiejJtekV6VTFrdnhNNXZ0UVUrVUlRRlZSMktISjVvRk1Nb2duTlNV?=
 =?utf-8?B?TEtZSnJsZnVRWHRHSFdOVTRvYVMwZkloVlhRc1NNYWVzYjF6THIwOUtOS29p?=
 =?utf-8?B?YkcxRDFJSUQrMVB2TUJhd3ZHTkZNOXo2Tmt1YUhRTEU5L08ybTJ1MzZEc1RK?=
 =?utf-8?B?KzBzRTlUNXFiOUdmVFdWYUZzWnFVaHpSeFR0dFdIMGJ6eGFlWUpSZGdnK2pv?=
 =?utf-8?B?THRvMGttL0hxQkdIRTNISittallYL3FYMTBRSW5ta0hCMHNGM1VKbFVzT3dK?=
 =?utf-8?B?U1pqc2tCR0U5Vno2cDRrSXMrdXlIWC9KeVRJaXhWdVc4VlRneVVwS2tvVWpB?=
 =?utf-8?B?RkFWZHdadzE4di9hakY5ZXhua0VxcHdtZnhuZXZsMXE5c0RSVFAvdTNKY281?=
 =?utf-8?B?bDEyZmNpVmllRk9nRjJNTlR4VzZSdXQ3U05NU0Y2bEsvbjlYLzNCTE4zd3pJ?=
 =?utf-8?B?QVo0a3F5bngwOGg3Ym01ekFqSVlnN0tWRlY4TVRpOTRHcmhqQTZSRXk4eTNz?=
 =?utf-8?B?cWFaU0FSWW5kbERmMkcxMkF2bExtZDIzY0Znd0lCcjFZb1RIYlpqNTdkU3NQ?=
 =?utf-8?B?aSt6d2IxUjRjbFNvREV2ZTFvZ21IMVd3VG1wRXNVekdYOWY3by9BTHF3V1Vj?=
 =?utf-8?B?TFVST0p2SlZwTGpjYzRkcmdBT2RVUmVkY2Q1bnhqUGY5VkdBUkdZNGtWNGd6?=
 =?utf-8?B?bW1ZbGRqczIvYmRPUFJyL2ZrV254bXExMzVrL1BOMWc2MjFXejRoUkd2RWVS?=
 =?utf-8?B?dFlJMHlhSnNOeXlHMGdaUzJER0dsMkhsMklPSFBGU1NVUmhrMDZrRHRFb0ll?=
 =?utf-8?B?Nnh6K3ZjTituR1pVZmh0R0NRY1dvVkNoVWttK1NRV2VLOHhkWnplVmhJOE9F?=
 =?utf-8?B?ZWpwci84SnFrTVgrZ3ppQk1DMFJNeWdaekEyaG5yQUpMd3pzdlgwRTREbSsv?=
 =?utf-8?B?UFpSY053SDZ4dXdKZFI1aCtpbTljdGtHVWxRaDVkWXI2byt6cy9WSVpKaHlL?=
 =?utf-8?B?THUrN2JvcXdUNnpQLys1Y3dmbldMck9FelRObnpmZVFEcWt4amZQa1ZwWHdu?=
 =?utf-8?B?U1RHRkNMR01zOTV5L25KTEh4R0hqODJxTlllaWhDYmFhREV0SExsZHhQd3BP?=
 =?utf-8?B?MW1HZk5lbzVSdmhOZnpQSVFlQ3o1VkIwN3huZ2JDdmc2aVhHbHZGeWZxZ2l0?=
 =?utf-8?Q?nbwKrGsY9s2l6Jgn2EZXO/etu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434947bf-5a13-43b0-a1d2-08da89d2c76f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 15:26:00.9715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1d0vYZyGl/gCP2QVj9nvSjdMt1Een/xIk928QQu7S+h42OTws4T2IlKx/tZLJoI2JwRCmLEP5U2JgN8LRzX7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6118
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-08-29 um 11:00 schrieb Alex Sierra:
> [Why] Devices with CPU XGMI iolink do not support PCIe peer access.
>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ce7d117efdb5..afaa1056e039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5532,7 +5532,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>   	resource_size_t aper_limit =
>   		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> -	bool p2p_access = !(pci_p2pdma_distance_many(adev->pdev,
> +	bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
> +			  !(pci_p2pdma_distance_many(adev->pdev,
>   					&peer_adev->dev, 1, true) < 0);
>   
>   	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
