Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192DACDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Oct 2023 20:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4786810E031;
	Wed, 11 Oct 2023 20:50:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2100710E031
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Oct 2023 20:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yar5OJRfaHEAGuNxWUQ6hrDdOUv6dOgTryQxGA9Two8CkhHyGEXSF8UWkkWpVOQqIu/z5n5J6u35UyKqKJdf0VVgZT30BhWgc5p3GX+okraVCU6RlKkYZ6YUJcwvbs38H3mObe/RfN8r66+QUXpJGa/KF/j3NQcZSBFnr4qmujZnASLlylvxzmc9eAPCUo1OmG8DOcOAUzoTDRgDL6BiU6PNZFmRM4nChtgobfPLDNI3qmuddcfqz4H/XyEfMUYjfEsw7IqAIvLy7jlOmN596kA+i1ZMFUkfyzk8Ev0VU9lxxP0GKO9PMlmrVGKIX5gP4sA1RqvyK34qf56w/K/FtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE6JheN6A+sqMESRECAcHtEY62J7rhsHMyjgYY7x3T8=;
 b=T+GuVezDE0v02MzVgO13++NXdDyxWwM64zk5Q0FwWYItEu+D+UWcZ1zVbsSChOm5vDuGG05beX71a4S+NsJ3k/6UJ8YH53OzF5ynrG6ztozUAEymPhc9v9gwGpbBbM2MJtdZyxg3l5VcmjENOh6pghJarBhmwwXzhHg+aJ1c4XC/xRZ1FSYCpqXANlCzwQsc1RjTI8uOUAQ0v9/P7sCUru164BMI+8V41dE7SFZx+EV/Fx5bfwfHx7+fEo3I0rx4nmKHnBf0nrmMxP2/t2s63+QqDlFdnlTUqhYrqhUCcOQnTbwALBc/NHTiPLz/8Yv2CWX4atUu3SA99xOqRQFJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE6JheN6A+sqMESRECAcHtEY62J7rhsHMyjgYY7x3T8=;
 b=QMiLAwHPsr+v0XUvzVTeQ1coM2ziz7hUXotsUlUgXGReNUaNKRg11ztbcU0jPE3Ni8HzuvIfwN0+FqSunf0Au7fzfZZBZeHtgRm6qguUHIztwzrb6O1xgx1RWV7jY+pjm6WoP5cTGf1qkc/idStjHWza3i0cJX2qKN2SBvJiAgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.43; Wed, 11 Oct
 2023 20:50:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 20:50:33 +0000
Message-ID: <c10923c4-0fef-4664-b6bd-63967a1bc896@amd.com>
Date: Wed, 11 Oct 2023 16:50:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Permit PCIe transfer over links with XGMI
Content-Language: en-US
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231011182235.569096-1-David.Francis@amd.com>
 <20231011182235.569096-2-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20231011182235.569096-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:208:134::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b86a42b-4f2f-45e2-45f7-08dbca9bb687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utwesobcF6XjGBrPEmoFj7Wg/SXnMcmzmvwglH4UvLeEh/sEPsHVNs/1+Iq+uvmVDdS3lfjruiGuQJrX6EgHUoszlSTYVM4BjMr4mum915Z0lXsztW8qgo9HXgzugQjYCErFu2fHX/gm/8HarkQ6B6TqJ7U+WhZcUloJ1yK99vS0NxdIAWsTJPIbL52eSjg7Poxewgx06ioj+UtLyJJhMyDjFImk+NSvsq0oVUW+xAdYc5G/BUQjkMw/XneUbCTbWT0dgWt5I2vKoL8V9BR6cJu/ReNP36kZxNJqjI7k3p9dqbAw2CEEmVJE/JZI6UKTwAVn7S77HO8yGoJs/nwdk4voDzAoCDVXGeJGpfkYegaxaZNgtsiAgIOXOygoEilMlSH4wUyfEBBhdttCb5UmFwKXxye3ujr5UmBoojKBj5JgivZSxTY6Kyhbbp7fCjYOIVjSPl8en2fI37UVZ3HBk8FuxhFQTgJAnAIJqaN/cs8EgrPZLM4zTnbojSnQKfJZ19qR4lk+0OxDgIVLUonkEaE33DtNO1Y5YGRfCawIrou8mxN4QA/SokIyxspK4L4DBLp8cFasPci1thIcoZP/gF9yYWYSDcsvW6tG350UHiW8zwQFGxyZ9JRsDMEGRofa0HIBHZ5RrhE8NEKkX0/O2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(31696002)(26005)(86362001)(6512007)(36756003)(83380400001)(6506007)(53546011)(2616005)(31686004)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(316002)(44832011)(5660300002)(2906002)(4001150100001)(478600001)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZSTk5iaTNFT1hiaFk3ZlJhZlc4ZmswL1FWc1pSeU1ET1hVejJlRWlxS1Bh?=
 =?utf-8?B?WEMxS2xNOVc2aHJ0RkdpRG5waFFKZW12TlVtbjdGZTl2V09wM2tZKzdGMlRk?=
 =?utf-8?B?cmlrNWFrcmRiRDc0ZWZTMngzTllGa1l4bFFLY0YrVDFqYlc1bGIwdi91L1JX?=
 =?utf-8?B?Qk5SNmFQS0h3U09ET1pMNytmaHp4Z096RzNMUXNIYmtod1J6eU5UZDNqelZQ?=
 =?utf-8?B?M0Flb0VrZ1hlakUxeEZGZUFUUU8rMGlzVXRUVHkrbWE0U0lXNUlwQm13R2JI?=
 =?utf-8?B?dHI5L21SS3RaRlFTbldPakU5REdMY0JqMzZJNy9iMUs0L3hlVzlGdGRQemRO?=
 =?utf-8?B?Lzc4U291bllJUkh3QlJoT2ZYTG1CdEJDY2tMVzlLSnBuUlRzRXlXSFZYdW8y?=
 =?utf-8?B?QWRaQjduYTJ6K2RsT2c2Q3RtV05qTkx3VU1oSU0wTnRtUXM0dEtBTTdYWldi?=
 =?utf-8?B?RTNadXcwS1JPUEVoVTNJQXh2QnRYV1JzRjhPYXk1TDVzZk1vZHV0OE9IQUhU?=
 =?utf-8?B?NHZsOGdXU3AwWXhTdlZscC8zWHZPWmZlRjYrUXYwVGh0S1JyK3IvY0tab2lI?=
 =?utf-8?B?R2c2a1ZGb2hmUVpoNlVvTkJHYmRUanJ3cXhqNW40K2ZCa3N1a00ybjlFVXBV?=
 =?utf-8?B?V1o5SmJ2Qk9SKzAwL25MODBFMGwweldzQXJGOUQxYzYzSXR3eVg4VkpoeDNs?=
 =?utf-8?B?eXh6Wk9sYS9HZnFBWSsyYkU1WnQ5VWRyU2VQYUw3eGozeVE2TThxRVNvNXc3?=
 =?utf-8?B?Y3RuUWh5ZVlpSUxxOVhOamxKZUdLblZ5VjFmSkJ0R0gvazBFMUFVMVkxNjZj?=
 =?utf-8?B?VFV6emZZdmlmNXhFdlo0Qm9EWUdEaGFJMzNIY1VkdWpFUjQvc2UwNi9nc1Zw?=
 =?utf-8?B?MTY4dkNhYzVxOHZKRnQ5L2RvR0MrV3U1R3VmRjRMa0tRY2ZnRURrYXBXb3Zm?=
 =?utf-8?B?MXQxMUdSbm1VS2F1b2M0SEJ1TmQxNDdEQmc2cVBpbFZoY3hvYjVVM0d1TjdY?=
 =?utf-8?B?ZXIrUGNzMzVuM2tZSDltTVlDS3VuZFNGU01nV2JaK1JUZ3gvWTAxV203VjVR?=
 =?utf-8?B?RlFtNkVoTUNBQ283QXh2VmhBd1hkMElGUmlNK0RpSm9TbStCNk8xL3JTNVpF?=
 =?utf-8?B?eGhHOWFwNzNIVEpML1VjdzMwNS81MytjdThsSXJvNlJDU3FXaUp6RjE5Y0Zj?=
 =?utf-8?B?N1NCMkhuS2ZJV3hqWkVIeitmTmlQRzEzaS80T1VRQ1R6RWRobGF4MUN5K3Jm?=
 =?utf-8?B?MldKZWNiOXd3S1F0eCtPdTgzSHZxaWlid0RXK01KcFNQNGpLWllvQTBsbWlY?=
 =?utf-8?B?TEUxeHRWUU5ZREtrbjdILzd4MjRHdFBSQzBTMlNZbVpsaFFsTTM5ckZpWmZZ?=
 =?utf-8?B?N25xbVd2SjNQTElQQkJYdDdNSkxDR0RnWE9XRkNzcThIQVVia29sYjl2VUNu?=
 =?utf-8?B?NFFEWjNoV21kcEFkcjJFU1BEZUV5M0NueE95S0VKTGRCUnFSR0U2K1dGR2Yy?=
 =?utf-8?B?cnljeHhXbUwvU2xuZGNRQk1nQzBTWkhRTTV4UG54THBQcE8vN1QzRWNDT1B5?=
 =?utf-8?B?RElIZlQ4OWhoVVNiSXVONExqV2lZdi9Na1l0cHhoU3pjdzRHc1NDNUFDazgy?=
 =?utf-8?B?K2lvNlc2S0h4Y21BbldleXdtNEMvUVpkdmMrSTNjdCtRamtjaUhtSytjSFk3?=
 =?utf-8?B?RlpWR3BVcW4wWTJOdFltaWJFTW4wYXJ2WkVpNGlyWTltTzVhRjB3R1FqcUpq?=
 =?utf-8?B?NGVkMHJHYldiQ1lhTFEzR0h5eVJDNVI5SzU1UzNYbjZrSjRTV2dURHpFa00y?=
 =?utf-8?B?dWMva2dmRERvckk3bTlPVjQ2ZlcvSjhFblQwSVd4bktZQ0tMbkQ5dVJERHNa?=
 =?utf-8?B?T0RLWHRaRVg5OE5MTVlaMGJacWQ5aDZ2djc5THdkZnB2aG9VNVVlYUE3dkdM?=
 =?utf-8?B?RUpMUnRWSHduV0RvZmlNQUhTUFlBU3V4MU1uakFieVI2eUg5UFpmeUdUU0I2?=
 =?utf-8?B?TkZ6cTJ5b3hjTmUvMUg2b01kTlExY1AxYU9hOTdYSG5lNkdSd09BNDlUQUNo?=
 =?utf-8?B?TEF5RzZrbU9lR3JTd1g1V25JYXMvQmI4UXRWYm0yL3MreVZsSlV0QTJOUTkr?=
 =?utf-8?Q?oqs3aZyiUk1HblZbXum2+wPqH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b86a42b-4f2f-45e2-45f7-08dbca9bb687
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:50:33.4981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmP9rGWFefdRaHo2dULZWoqECsEWnbKwUHwFpe+ZrcEeSjefYjytYzAUjFkLAKU7Cx9Nw927zTE7Of20wIhj9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
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

On 2023-10-11 14:22, David Francis wrote:
> When the CPU is XGMI connected, the PCIe links should
> not be enumerated for topology purposes. However, PCIe
> transfer should still be a valid option for memory attachment
> that requires it.

You could be more specific here. This is for remote doorbells and MMIO 
mappings.


>
> Move the XGMI connection check out of the shared helper
> function amdgpu_device_is_peer_accessible and into the
> topology path.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 3 +++
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bad2b5577e96..b47cb7f8cfbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5753,9 +5753,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   		~*peer_adev->dev->dma_mask : ~((1ULL << 32) - 1);
>   	resource_size_t aper_limit =
>   		adev->gmc.aper_base + adev->gmc.aper_size - 1;
> -	bool p2p_access =
> -		!adev->gmc.xgmi.connected_to_cpu &&
> -		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
> +	bool p2p_access = !(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
>   
>   	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>   		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 4e530791507e..f0cff5072736 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1423,6 +1423,9 @@ static int kfd_add_peer_prop(struct kfd_topology_device *kdev,
>   				peer->gpu->adev))
>   		return ret;
>   
> +	if (kdev->gpu->adev->gmc.xgmi.connected_to_cpu)
> +		return ret;
> +

I believe this is only needed for the case that XGMI is disabled via the 
module param. When XGMI is enabled, you shouldn't get here because 
kfd_dev_create_p2p_links doesn't call kfd_add_peer_prop if the GPUs are 
themselves in an XGMI hive. In fact, it may be clearer to move this 
condition into kfd_dev_create_p2p_links.

Regards,
   Felix


>   	iolink1 = list_first_entry(&kdev->io_link_props,
>   							struct kfd_iolink_properties, list);
>   	if (!iolink1)
