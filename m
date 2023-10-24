Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB950C07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 21:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5956C10E4DD;
	Tue, 24 Oct 2023 21:03:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20EA10E4DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 21:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in8zmz3WwmhZh37QoV3FwHFBmrHgCcq1rSDnH8zMUXJq7eKe3I+TbpORcsWdehVdAwidhV4LEjbVy7TEDtBXPqss8QqtCzTsnU9E0+hR5rNEGQB7/EkzDmjnkI/eA8Vuh4E3GOpt/Y1YYHMwQjUHIFyUYZixfEzIgi5IEDSXlQet3/xCoVzd+daUn1XNBPLS5RcxGyptoOWrfNM01SfUZIRLBX4x43efwWrP/J0GqGdpOMr5nvY+Paaaw0k1l9aE6fQTLzvcqTmm4ER3Jc0w0hTO9VS8CE+ioX8BqCj0kUbUfNnZ4BFC6vu3uNqk3642Yn6rct8Szq+VFlz5ov2g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErIzwnWnrBJVe6vZkebHG/6jSw7952b1wZgnB/yq86U=;
 b=obgcypw/+mb/7MFMRkNnqzHKf34QJ8ds53OXtwnB6vVaROh0sqBZTWRHJs7s+dgj6QWGbPPNG6+/464EFWMUoi/2WGfsfow0mTM9MR25wsJwA1qiRkn5oSdx64Ue0bj6JYCIow4pdZ4tjgSiX8Q98zb32Ou9VHC+o8kKgd/4CZ3SlgOgPCkpZChLrTJFDimhOuz5zOHJsTgY0RII4/DLXbqccPFdNBHfzc76Y05uPC4CqFnfT7HjJljPnYd4lFFh2CrnzWpryI9kmqsCM5BQw6j2L0tWHzY4eQgP4M2oD7Ou8RrWmwteqT0TKXgsmhXBmP19oooqEQJ9uVMIYhzD0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErIzwnWnrBJVe6vZkebHG/6jSw7952b1wZgnB/yq86U=;
 b=QpYIIxXXGntFL3atofJHjY13l6/Nsmp9WEIdAqnFhluCv0WTlfpLBNfbudmIYz4CXLC5QjBRY4UypnQXR7f3L40WHBYzhQKC4jj0gCF63+zE8eE3S2clcR6DBDPQAzkxHIvsEeRcpD7aGwzDY+G73pIw360wQ9vupeONU5KX/ro=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 21:03:48 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 21:03:48 +0000
Message-ID: <21298fa3-6f64-4b4f-85dc-e13c68acc809@amd.com>
Date: Tue, 24 Oct 2023 17:03:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Permit PCIe transfer over links with
 XGMI
Content-Language: en-US
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231024192043.400319-1-David.Francis@amd.com>
 <20231024192043.400319-2-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231024192043.400319-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6fc4f0-cfad-47ea-c87e-08dbd4d4b7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpXv9byJjOfNRb++zIudiYsf9Ju/6+YmdRg7QGEJ5BVnahW/OLZmmvy/sG4i/OWGEh2OsaQ/RA75j1fOEDU0hJ9uUAXxW57rzKK9oFPNhxIh9BBngnB7F4YPVJdHGMoRWSkqT59kqCwRHqGMy4lCPhl+EW9SzXYsUpjSoO7nZKQRo13fJZnnrxCNb1EaFxBbWbZdWIALDwwd4S91CXc4zro4c1FX00LYjnrn03Vpt2RpxSwr3f63vsXpUZjR2cMDy0rf8nhN1I/YXkmUjXSvlV9ASgc9BdQs45wYyinYNcbRYHjlHu/9HSoA/Kh3P9wgK4y7W/R/sfgbZp8gKHtr+OmvQCI8Se5ltAvelp+UYdBuKxqM3fRc1JUAkhw7KWrRqKzLqJV0delVOU3Z9vn25fWI/uzmQStf+3aF2OuxZzTRaKLsChBQYwc5rJbIzEmPbWkBk9QyDZv/p5n6NozvupzmvoHs2Ih6FGifjt5u6mZl+hU3THOQVNMXC/UxWo51dNDUGFcLt4XLK4uQPXsC5arpTyDhQYh/dkcwo5/QUP6k9L4fXDD0GocuXeRj32zuWcz0L0arT3gtB4d7/Eju6cR2JDKt5dqKL6iVc8xWYe5zK3pcwvulGTO/UUyAAPtvuCKmkFuxZonH6Beu6Wg4Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(4001150100001)(5660300002)(66476007)(66946007)(86362001)(41300700001)(66556008)(6506007)(31696002)(316002)(36916002)(6486002)(478600001)(6512007)(44832011)(36756003)(8676002)(2906002)(38100700002)(2616005)(8936002)(26005)(53546011)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHFnY01xK044NVZ3b1p4YW8weVFlK0g4ZUFXTzVZUTdHSExiR252akVRNzR1?=
 =?utf-8?B?Mmdjam1vQkxJdmRqeVNNNXJ2ZHF6Z0NIOU9XZFp1VTJWYy9hdGNUZ1dNRkpT?=
 =?utf-8?B?MnlYS0xXeW9CTElLbE1jSkVIVklDRmJ5enh5MWw4VUdLTndmQVlNKzBTRCt4?=
 =?utf-8?B?UmdLS2xmV0dSMWJrQ2xjRTdST0pTVXphV0kvVFE5Q1lTWnBYRm1qdkd3cWVz?=
 =?utf-8?B?NTRaelVVNllTYlFNOWplZU5VNU50bDd1bjBWVzFqaDVwb0RLVElLZkZvbyt1?=
 =?utf-8?B?Y0c1WXRWRXdTakNaL1FQcU5QVHZwbWQyYnhVclc4QlBIM051MDRZMmlGRzFv?=
 =?utf-8?B?SFg1UGxXR3dNUXN2OGRna1BYZGxtSlc2ZnVXR2g1YmxuaVU4WVFyNWY2TVdK?=
 =?utf-8?B?cDFoRGpFR0pDNXh2S2NTeUcwMWFQaVpzVitEaDJDMlVJZ0hWNDYyY25RV3ZV?=
 =?utf-8?B?b0M5RlRxUURCVE9Da01VeHVzbk9XVU1vM3k3WGE0QXRycGJlZ0JiNFVBK0ts?=
 =?utf-8?B?bHBBQXVnWVpZc3FqUjRiMVErL0lWb3RLR0M4V2FmVXFNMDVRUXlWUi9Ed0tF?=
 =?utf-8?B?R2trN3U2WXVpT1oyRU10ZnZXTmVxemhkVnB1Rk0vZFNKSWcyK0Z5NU44YnIz?=
 =?utf-8?B?TTc4RWRQY3h4UXEvR3MvU3J3Nlo1clJxa3JGendKVEFLUW1XTFIwajFEYzhn?=
 =?utf-8?B?ZXF1bm5hVHVDZW9NaEhDMUJiamlPaDVzckpJZDZ5MThKYTRDVTJCRTA3MjJ1?=
 =?utf-8?B?ZC9pK2xxY1NXczBDK2JmVURLaFVQS2Z2U29YUzAxTncvL0xyZXlCeG5Wdy95?=
 =?utf-8?B?ZVJHVndubWNRVG5rcXpXU29xRDNlRGZCaU9HVkdDbXV2YlR6VGFtcmw0M1Z6?=
 =?utf-8?B?UHBMdDlWYXJTUzdHZlJMblVYVC9NR3Y0aXRGUlFxZWFhaXY1eXJQZGErMXdO?=
 =?utf-8?B?ZU8yVTN0eVlUUjYrTEJHQUt1R2t4aXVEWUljUTEzeC9EcWhJNGJHWUlQS29E?=
 =?utf-8?B?T0xoWGxiUUNHTDRCY25Rb3lwQWdHR2ZxY3pHbzR1Q3J4Tmc2TXY3Q0hBOG5B?=
 =?utf-8?B?ZWcwVG5KRjJIaWoxOTIrRTQrYVF0bVhxSXphQWhVWGJON0FpQmJhclV3MGI1?=
 =?utf-8?B?TzQzZDJQU3FzaWNkT0F5S01qbm5hdVRDV2RwOE5vRDB0enRFQ2Q3cmk3S3hn?=
 =?utf-8?B?UVEvN1g2M2V2SG8yOWhHQzkyeGhwUXcrVTV2U29kempmdXNha2VndWdLc3J6?=
 =?utf-8?B?T3ZoUGpkdHk0VkxMTHNXZktLcmZraXJYRk5GRlJaZERLS2dZUjlaU1ZlVVhZ?=
 =?utf-8?B?U3V4QjRaZ2ROS0xISjBpSkZKcG1oOEJPYXhTKzVKNjFvZVhmMnMzcCtWMHlW?=
 =?utf-8?B?MHB2WmlwQkJxaVhhTkZydncvRTAvNll0V2EzaVBkeGdzZjYxQVFneDl3NzdN?=
 =?utf-8?B?TThpNjQydkNHU1UrVjhGL3UyYnVZdG1ycDlSSUhRVFVvckNsb1htWTNoa1N2?=
 =?utf-8?B?ZGY4eWt3enBTNWZXaGZwTGQvNDhKUS82SHRZRmpiRlpOUXNna1dGOWlPd3pO?=
 =?utf-8?B?TGhyTWJQTEV3WjQ0MCtYZFMydi9kVGE1emsvRFNUSjZwNmFzQ0pTYnNYWHJS?=
 =?utf-8?B?ZmRKVTNLWnNmM0tEaitIdXg4STFweFRjc3M2dG1ubCtPWEZjUURVSU9SNmZK?=
 =?utf-8?B?b2E1VzB1bkNCZmxJMXg1a3h6NzVoRUF5eWtwUHV2RFptK2RjbDE1WXBkM0lU?=
 =?utf-8?B?SFVNVUlEQ0tZaGFSQmdjbkc1UFIxdDhmaHBxekozZFZQOWR6QWlSSFFrNU1K?=
 =?utf-8?B?d29xRG51WFNBM3lCQVdsUk9NY0Rud0IwTjFSV0UyMXZhbDltZ005TkRWQTU2?=
 =?utf-8?B?V3hxLzR0UXBSNjVLdTMvUXA2QnZiMXhFSCtRM3ljREYxUTJjM0g3ZU5HZUNy?=
 =?utf-8?B?Z0ZVZEkyckNJZmoxRjZCc0JtUmpwMGhFM2dUaWpOdnNQL0Z6cm9YVWwvV2Fn?=
 =?utf-8?B?VHE4WDBlM21McEtFZm03ME9FOG9jTmhVWExZcGtDeUJIbnJ4QTAzRHhxcDky?=
 =?utf-8?B?eVVCQi8xUllzZ09UT1RIZEpFemJ4MzdHNHB4ajBuTmVzdkt6TnVMSDJVOU1i?=
 =?utf-8?Q?blok9V43ZZfzQ6paMv8yx6TBi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6fc4f0-cfad-47ea-c87e-08dbd4d4b7c7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 21:03:48.5979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAjyeBVdEkZ9i3kphC7M6KE2qvmC2geY6eUPW3usUCSGRnNuH/6/o8MjZUNj06CNP5WHWKfWRlC44MZn5k3I1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
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


On 2023-10-24 15:20, David Francis wrote:
> When the CPU is XGMI connected, the PCIe links should
> not be enumerated for topology purposes. However, PCIe
> transfer should still be a valid option for remote
> doorbells and MMIO mappings.
>
> Move the XGMI connection check out of the shared helper
> function amdgpu_device_is_peer_accessible and into the
> topology path.
>
> Signed-off-by: David Francis <David.Francis@amd.com>

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 6 ++++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7ec32b44df05..a5c054f8a427 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5783,9 +5783,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
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
> index 4e530791507e..cb64c19482f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1514,11 +1514,13 @@ static int kfd_dev_create_p2p_links(void)
>   			goto next;
>   
>   		/* check if node(s) is/are peer accessible in one direction or bi-direction */
> -		ret = kfd_add_peer_prop(new_dev, dev, i, k);
> +		if (!new_dev->gpu->adev->gmc.xgmi.connected_to_cpu)
> +			ret = kfd_add_peer_prop(new_dev, dev, i, k);
>   		if (ret < 0)
>   			goto out;
>   
> -		ret = kfd_add_peer_prop(dev, new_dev, k, i);
> +		if (!dev->gpu->adev->gmc.xgmi.connected_to_cpu)
> +			ret = kfd_add_peer_prop(dev, new_dev, k, i);
>   		if (ret < 0)
>   			goto out;
>   next:
