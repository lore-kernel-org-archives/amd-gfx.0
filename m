Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DCDCDB465
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 22:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A45A410E22B;
	Mon, 16 Oct 2023 22:27:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A236110E22B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 22:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHdTrttgLP2hjCeiK+Re14PYTGAGG3OqeHgK1wIbXUhkbKPcAJlrhsVNa1qyhfEzXtZupiFzXIkEv6EGQp9RV9+CO7tar+u0dDoeokaFFYAkGMZuXEMdwBtGdl8o7fpGxngEDe4RyvNsCyHQfFlNAXorpmxQ4QDOLTUC2zw1NwIJw7NGvsO+1kDQSk54tTC66eOctopWPPcAlJ7sqD6JmYa9AnrtAoMEfk69VmrKUIEn0nxNU757SN2fSEIJP9TIjk6pHWl63uEXSYqt53YkwRHOMXjTRDG2tc2D9H2exJrvuDGsebM8eRGGZclN0Wtb7ra9YMtI8tOPhR7xzreFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd9TssATZt9BSrwXjMnTZC36+skLhA2Zq0aZlSF3gPo=;
 b=e2q8KPwUOq3p/fRKhSEyo34aOTy7D15kG0EUsGaNxPdT3veY1gEsjW/w8FSgSFTJl5Axk5ta6OU2FNMPyjDJ34yiLpMvCFaow8SB8v0B3D76fJaYhKp8Xc7Kcnse4UjTOyG+nXU+xr0ILGh1mcDx9zISUfLjGMGEfUPwKeiWiwiVxKVHaYs1Uyccm6B5p6Q5WSoqkQ96rYN1XSTEINJEPdvH2UHJ3kVYa9k+4ShDgEkTHKEBcoFgyD5oRjhvrqnuKF55d22/mzchcsgXJ1rrWAY4ZM7s2x2br8lM4cJmqA0YIVH/Ox9+x+Qhe00J8WLFlvmrU95KA5sJOHgfU/A6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd9TssATZt9BSrwXjMnTZC36+skLhA2Zq0aZlSF3gPo=;
 b=ws43fSzDMt8RV8trqohOAUqbnxPF5+bxu/9DvpalAvnFc/dW1k7Mnj2aL9HmyTlT7rs4yitYsrrju2ytPH8Nm+YQrVXlxPH+iUBBs5y9CCB8/jasnESTkmfxxvbiVSyJwFKqOlpgrzXL5ALgQS/LLOSzLkDW1HO8//fqZK2nysw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 22:27:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 22:27:40 +0000
Message-ID: <c34225b0-75d4-4051-bc4c-319016f4aa9c@amd.com>
Date: Mon, 16 Oct 2023 18:27:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] drm/amdgpu: Permit PCIe transfer over links with
 XGMI
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, David Francis <David.Francis@amd.com>
References: <20231016144929.807268-1-David.Francis@amd.com>
 <20231016144929.807268-2-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231016144929.807268-2-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: e8772640-6e07-406f-cc9b-08dbce971bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USZwXVnN4kX173rOLBGPFxsHmXg0kQwRpRowWQ57OJxnCeFwhUEoNBc8pwW3ipwT+kFQgO5J3kWOPO8pm5VN8ITMOzLRfGSTiGUbhM/caa8DkDXVaWivhvQ/+mG8tiSkzcZn3VhxpohXgB8UbOSZpHTyjvYti1BmQj4YJkL/qzaHPGUlB3Q0JlVKDcWJwYcJ+zM8K4OMwqz9NGYy4ndPH3t2APRMsPeIdlxpy6Pc+yRsUNKhfFWTI2CQ9AvKN8KQJ3RR1yVbR6Qbd4tiC/WW6muUVjYTIvFTlXgOSQPGTfKYiSpEqnhGVjNXb3JnIAcCCBd+13IqWJxNp1SvQp9SqXEfrZqW0BEJbBkB33UQf1brp89AEPjA5nW/BWS1De5leDU3Ts9lxmcFp27ILsupWxard4ZV9y9Qcvyjn16Lk4iKiXZbb73oHkP0qFfgQsl33ZQ2iG4NBRFB5Cx9fA8ErR+UTmfFZwyAqsIeks+o3P2jbGMDKovndFtp76nOwlGG8uYfINKLVlJSLrrVqM911V78K9Gd2JTB9f07UO694TmolZc2omXQQy0OrwK5HKD6N1SA3IMkis3TwuCdiXpsmzKmug9Z0uHO4lhai57A/9f1+alzMZnapPkFYRM1ns/1/4bYWQl+LbpkvF08WKesiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(37006003)(38100700002)(478600001)(36916002)(2906002)(6486002)(4001150100001)(6506007)(6512007)(316002)(66946007)(66556008)(6636002)(66476007)(8936002)(5660300002)(6862004)(44832011)(8676002)(83380400001)(53546011)(26005)(2616005)(41300700001)(31686004)(36756003)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JWNlA0MjRoajg2d2dnOXM4cUFNMklIODJENTl4U1RLZFpIdmh2aFJza01S?=
 =?utf-8?B?ZFBvSW9ZYTJjRW8vUTNBaXdQcmxtc2dWYWNpTGRSaGFUUk0yZVM1cGN1Yzgw?=
 =?utf-8?B?THYrMGduU3cwRThOM1hFRVNFYUZRTkd5N011Vlc4VVhwUWszblkyaW5WbGJ3?=
 =?utf-8?B?NkEwaFZsQkIwaktjdDBnN0tqQVVacmRtejZWa3F1eTVEQUhqbEh4Z0paRklv?=
 =?utf-8?B?SXhIeFJjQ0hzMmNEUzVvUHFkWjVHRnBYZExvQjRDaXNMSk9kb0Z6NVV6eVB3?=
 =?utf-8?B?QzdoSCtYUE85Vm5ZN1lJRVFQZnRqaGhtOWtoUFN2K0VGLy8rb3Z4VElsdS96?=
 =?utf-8?B?ZGN3UDlHUHcvMTZWaFFPdVBXSWFrc3pEU0puL0FBaTFGUkd5dDgrekRlMFVH?=
 =?utf-8?B?SXh2WkRrUE1qcUZhQm94SytDV0UzUVJwM3RvZUZvc2VscUxWeFFOUXV5ejRK?=
 =?utf-8?B?MFd4cVZwTHB4ckM1eGRhb0VVRk9MbnJ3ZGxQNThtMXM5eGNCZC9vbGJjUXBN?=
 =?utf-8?B?V016eisxaDJqRnZLTU9CTTlMWkZaeGUrYmFRYXk3NFUzQVF3enduYW5XTE96?=
 =?utf-8?B?VkxFdmtacnhvN3hqQ1FYa3hSbkh2c25vSEw3Y2pROUZqekZRNEhNQ3lFdmNL?=
 =?utf-8?B?SmgycVoyV0RRSStENDZaSm4vZUpSeVN5bjl2Q0J4K3liOWNpeXVhZlVHcnI1?=
 =?utf-8?B?WjRaRDdmWVY0YlZydDlqbnpncDZJUGx0UE1kaW04cUY1MDMrL0N1RkpPNkZn?=
 =?utf-8?B?QWlaV3dodThZWndKSVFwSVFQZ0F5ckxEaXQycTJzTGhUcXZ5THhrUjNhNHZJ?=
 =?utf-8?B?VnRGOFdEbkdDd28zaENHWG1DYThtZCtPQnVnbDFZYWorZWU1TjBkdnYyci80?=
 =?utf-8?B?em4xak44VlQ5S3p0eG5HT0N1YmFDRTZ4TjY0SHlzb1JFUzFUcWo1UXhLNXQ1?=
 =?utf-8?B?SHA1SUhTL08xVUdla2FxcytPT1ZSVzlzdUtkbmhud00ya2RURjJabnk0eTB1?=
 =?utf-8?B?Y2JrOXNPTGdhbXZtQlVHTzgyVE4rNDZjVTNzaGg1S0NKaHBsWW1NK0lSZkRs?=
 =?utf-8?B?QmN5NkVqc1FXdit5K083elFURGJBN1JtczJpU3IvTkw0N25YTTRTUFpEVm5D?=
 =?utf-8?B?Q3VOYVdWRHZ3Q3RRQkw4S1A0WmhzT3VLQkVYbE95b0VOaTQwYnpOamtPTHVE?=
 =?utf-8?B?Y0d2QmZTRUdtRXhDWUVNMGxJcW1COVlPL2doMkhCekNza1hvbmlZVlBvamJn?=
 =?utf-8?B?eTZXSnpoWC8xTzJ6a2hEVVJKK21oZ2FBeithckh1UW5rTDYwL3l5OHdORnl1?=
 =?utf-8?B?MXlWd25PTDBjZkN2dXNJc0FocGRBcXk5M1Qxb21wQWN5THo1Q2hlNGUySzhO?=
 =?utf-8?B?bTA2S1Z6RnJLakJVK011T3hkdWkwSytPQWRyOENLSjRzdGlzeEd1L1hLSUNh?=
 =?utf-8?B?VUZ0VnB5UlhTSmdvSlMzUzRZWlNCQlAzL2c1OTNhWVNvKzFFcXp6SWNSbDdD?=
 =?utf-8?B?VmRPaSs5ZWpNSjFjZmdpSHhabjRUQlB5b0ZjWTMxZVp0eFFORXZvZVpEd3I5?=
 =?utf-8?B?M3p3NmFWVlgyeEx1QW5pV2lPOEFqRUR5MFJ2eTRWdDc5Ny91N0hEQUdtL2xr?=
 =?utf-8?B?TExkZ3c1d2tjSEMwRDNxWDNFcm5GRmU5V01kWkRRWlhwV29NUW5rZGVzRXRv?=
 =?utf-8?B?UFljWk5yVkp1dC8rR08vZG03QmVaTlJ2Nk90OTdmYURKOXRibHZGeTM4SEVV?=
 =?utf-8?B?VHh5WnBXRjhFWjdQZUMvM2RQdjZidzcwWllRWERsM1FtS3phN0hEQ092T1Zo?=
 =?utf-8?B?SzNpZUlJNzRIMmZ0ZzVoeWI4cFhCWHFxdFFFRjdaTmkrU1VVMjM0ZkNlaVVJ?=
 =?utf-8?B?M1R4bER1OHpmdjF4elJlUXpEVVBhUW9Lc0RmNU5UTS84ekc5R053RURUUGoz?=
 =?utf-8?B?cHB6M2RFWGs4TE05aFI1ZkJWZG9UdEp1bHkvTytmb0Rvb1AxWUVzdnFDeTBr?=
 =?utf-8?B?MjFPNEplVmR3WjFxSDdNclZxQlZ1VGJkSVNqbkF3SkdTNXlpUGlwanh5cE95?=
 =?utf-8?B?MXdHeG5paWZTeXZiY0lmSzN2Q3lVR3I1dkF5VitwNjhWTG95UzFBdlkydlJB?=
 =?utf-8?Q?tDdJUhwacB2XALkHYLHCWNb20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8772640-6e07-406f-cc9b-08dbce971bcb
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 22:27:40.5976 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grCAvWCWXn8ohwGK4ZhxDiZWxJfJ4+mPcUskzY/GQ7vK2v/uwzed4uKvnI7ncu0gFfnZ3UohYZGzI9Lq2bo8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
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


On 2023-10-16 10:49, David Francis wrote:
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
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 6 ++++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
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
> index 4e530791507e..cb64c19482f3 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1514,11 +1514,13 @@ static int kfd_dev_create_p2p_links(void)
>   			goto next;
>   
>   		/* check if node(s) is/are peer accessible in one direction or bi-direction */
> -		ret = kfd_add_peer_prop(new_dev, dev, i, k);
> +		if (!new_dev->gpu->adev->gmc.xgmi.connected_to_cpu)

Yikes. I was thinking this should be something like

	if (... xgmi.connected_to_cpu)
		goto next;

I didn't consider that the check needs to be separate for each GPU. I 
mean, it's not exactly the same thing, but would it make sense to have a 
check like this?

	if (new_dev->gpu->adev->gmc.xgmi.connected_to_cpu &&
	    dev->gpu->adev->gmc.xgmi.connected_to_cpu)
		goto next;

I don't see why this should depend on the direction of the link. We 
don't want to advertise PCI P2P links between pairs of GPUs that are 
both connected to the CPU via XGMI. We don't currently support mixed 
systems with both XGMI and PCIe connected GPUs. But if that ever 
existed, I think we would want to allow P2P links between those, 
regardless of the direction.

Regards,
   Felix


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
