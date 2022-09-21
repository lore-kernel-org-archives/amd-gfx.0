Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C33C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 12:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E7610E404;
	Wed, 21 Sep 2022 12:35:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C6610E404
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 12:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiuL2G4LisM6DD/TuEl5VLrYxsEJHaUzjqUENhxXu2fz6MaaUepqW87c4fMtVL8Bh4VUTIAC0F/T3yQpLXiNZO1c39hkKtyMoqaq4DKIiWMdeMc+WpYQVZF+DUP5hF2Nx44Q7waCLmXXzmNC+IHV+97qRsKTdTJ/2rJMxFLglK8Su3m9iQuLemtGZAqsyrG3HCJvzc6ihpLklR6jrDZvulf9O+YD8xt46YrJu945d8uf3MOBpm8Np/RnD9/jLkYIFzowW4RjlMvigFUarROBNUctYeGBwTsbP65UC35cTfIdG01PvKQh/R9DaYp1c1tWu8JdCfcPlPu6pHI6s20iqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7UBRt4deMvNi20E05N9pheBYHJQXUtBiMQimk9WKwE=;
 b=PTkN5sXQR6DouIIekhKbd4z5XmRQwSw70Ea+smJn/ly2uc0JGtF5bYQBaxRW96RLiPueyrF8lokpdYeTSw+LRt0zygBmGMUtYAXE1mr50kD0mPRet4FjZeSNgbVx3CS8fE5WtvtBtLYwVCmeWeECUv/ThBRstOiMuB9/iBuu3D43JGfIECgNbFXzV6v8Gbk7xaktkxvRlj3VGESL7qSMlgICTfIDH0Je0HAgbAm/TrM1it/yNgL/hf6c/SxLtpB7gwYVuTYvdK1cO5x3zp8BuHfVVamZnlc/+OOe2C5wMRUyHJyaRpyXQ8jSXKRDKRF3uDSIahSJiL7ywMkm4cme+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7UBRt4deMvNi20E05N9pheBYHJQXUtBiMQimk9WKwE=;
 b=wgKIA/d+y/DjvH0i+wO147Yt5bdZYp6pQDb74a6zXRAgiE5T7TBzWHDQoA1XpnYV0QO+hXNVrlRns3y/LnWNHlGSZ4O+AiogEue5+B65YmKQAieUknSi34I2U6fkisf0O6/aFmZuWc7SPfvgS6gJgTn5ZIk1tbmK2ELX9YTWGb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Wed, 21 Sep
 2022 12:35:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 12:35:32 +0000
Message-ID: <1fd6e5e5-0277-7b59-7791-2677b6b79dcc@amd.com>
Date: Wed, 21 Sep 2022 14:35:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Disable verbose for p2p dist calc
Content-Language: en-US
To: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220921123027.2866204-1-lijo.lazar@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220921123027.2866204-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH0PR12MB5217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f40dbf5-339a-42db-cdc5-08da9bcdc60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SYR2S2EO/R4cdoyFvGv4dIIaoBclmPhjmzzIKDrqUWAQG31jjlTmqCglC5zqtlXskC07bBg+UwrkzG5Ck3qlsQjce2K5eMoXJfnGuBAPSxY1Ind8nBiDAu4gEeB5sqhSHbGP8FDsohSaF58do1hbOZNcgLaLkBkxJDV9dMhMZOcPVaLaRGUflYN77yfKn5kkqAUV88HAt4AGBJB75stJUHbZ0CV5B8c5MNKTsa+7wMz85XEUtZCXyeTzeIZtYe4H3TeZkpZOrlc9dix2nL9DwyCVYFZuOq2nXonMLoqPaLPB3FNILm7Bn5kWijLkvi/PPsWgjuYXW9zT15i9bdRLjNjWiSLcoeUM39hNM381JO0MavfKH+XmQtWsO/f+xoEEboLgrx78usbLIxVZg2GkjPS93D6scVrAtTyW3MHyz7vdskvB5OQGm/IFrrIcS7ikPHuF0nD0hayePCPwXrwk0hE3xotFvbaJ75kn0FVB2CRxrH3prsVPNbtuDwPwaeRCyRRUBKAKv/3K4GjuTE9HgzQpD4i0QaJFpq+od1EtcKFot0mxxbB3r8jUwXWmHd5vUWzTb7ufGZit/4n25+kXepkl1su2VzijuezpfZXJKbimvbB9tJpkCjP3aBsSlD2eX3xaAacW3I50+ZUKpaEjYx8Z2RsPUEgqJ4/Vx6TYj6qQMgsGFN2963huqg5J4IpoR9Is98MtfylUynhbwfNogSbsxTyIyQtHa45AM+vJaCZVpSyvcoE6hi+FcNIh/4eKlXW3YO6dEDnEU9aQwocOXwGaEWw4NJlIlUWPwN/A8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199015)(2906002)(5660300002)(186003)(2616005)(38100700002)(36756003)(66574015)(83380400001)(31696002)(86362001)(31686004)(316002)(6486002)(478600001)(41300700001)(6666004)(8676002)(4326008)(66476007)(66556008)(8936002)(66946007)(6506007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVNEbFRkQnBUZG9XUVpuOVZSb1RsTkJtNkx0MGpRNTdNT1piS0ljeGFGMmlT?=
 =?utf-8?B?WkIwSXZDbHlhenEwcXEvc0l0MzlHYTkvQm1WR0M0ZWEvMDN1R2JhL0M1YWFB?=
 =?utf-8?B?U3hMbzZtRy9yWnRqUUJHLzVWYXF2TkVMNGlnYXo2cDBxQWM2eTI5SGxPSkJM?=
 =?utf-8?B?VjdpMGdoSW4vRDlGbUZyQk5jR1ZkNDRtL1pCMjhRVHV0d0RwaFVJdHJvd3h6?=
 =?utf-8?B?VDlCS1dnbUtnbFhSZVloK1NPQkRicVdQa1BFdDNiVW9KL2hybGo0dWZDWnVX?=
 =?utf-8?B?aGM5Wmc5SE1NY3YrM2hnakszSUZOb0plQ2ZiMU1ucXFOZHhsSFFJOE5Db0t3?=
 =?utf-8?B?NEpQaENnVWhhV3VZU08wRS8yVlJEWndQUGJGRTJodm1SUjk3SlQvL2JWNlZT?=
 =?utf-8?B?NGRJekZ0NEtTSGV2R2ZNL3VNeU90b2J6dVgvcnVWOEFJVGQ3NFd5N2hsOVRE?=
 =?utf-8?B?d3pUZWVYUm05K3dldXc5U2tVeWRnVTdHR09ZT0RuZGR6b09QYVBvU0JzUmtT?=
 =?utf-8?B?SXVFdHJ5ZmhLbENpeHlPaW9KWGVYam5HKzBjVFRNeDNrTWRWZUFwVnhoOURG?=
 =?utf-8?B?Rjl0a3YyU3R1UFdNc1YxQmNPa1NYY01BQkpyQXF4MGxyWmxyRDN2MXl3TW9u?=
 =?utf-8?B?RlFyWVQvNC9WRHZUby9DYkNWZC9oQ0RPQi9BN29ndVFHTEloczBQRml5by9I?=
 =?utf-8?B?NFZPbHJqeWJIdk9mYlc3cTVHRzk5c2tJREwzV1dIMUFZcTFneTVZNFZtU2VQ?=
 =?utf-8?B?WDZ1QmpmMUFiR3Z3WndLV243azJlTHhEZ3kzQ3hyRWRGOXJoNTZkWGFPNU9m?=
 =?utf-8?B?eENPNFE3aGVkUjhrdVZub1RLRjd2SHg0eVZWVXFYZStYQkQ1eDkxNFdTdFhL?=
 =?utf-8?B?Z05FOGh6TXc2SFhPUFhYTEZxR2JFc242Sk9QTXpjU1NXTWthMXlZV2dJQVVX?=
 =?utf-8?B?Nzk1b0RHZm01dnREOTY3akxuZ1hjOVl6VDZZWXhpSzJrS1ZET0VsejFwQk1h?=
 =?utf-8?B?VWxIcVZnK003RTIyQS80cU15N0s0azFscGZzbjU0UUU5Y3NOR0N6RVVJYlhn?=
 =?utf-8?B?bDNXTjl0Nk12YXVGTGlzdGJ0cEdyLzBGd0JIK3F3b1docUE2Qm1icGZOQU1m?=
 =?utf-8?B?c1RLWEM5UFBFa3lGWkg5dk5VRWpUYXZ6OHN4MllTckVBZSs4TDhJV25PdkdR?=
 =?utf-8?B?V1IzNTNhR3B3akZoZDhCdVNzR0xqcWF4dDBEWUNyQzJzNmpxc1JFc0dCSEtY?=
 =?utf-8?B?OHNGbGZFS2pCTHNOS3hZYmh3VjFsVXR6cU9yaWZmNnYrWE1hcklrVW1keENp?=
 =?utf-8?B?T0N3ZzN2UW5QMXRFaVdYbkZxc3dwS1lHaFVjUGQ3UXJWMGZZaGZTa3dOLzFX?=
 =?utf-8?B?UnhrWnFhMzlicXhlQVdIUUhDTGhlQ3FnbXdoR3daL2FkbW83YU4vVVA2RExa?=
 =?utf-8?B?RHQydkt6MTlpM3k4OUxEeG1mWktRaDBBQUJiNTcrai83YXhqN2FaRWp4c1Bv?=
 =?utf-8?B?M3JiN0VrTnBFZHRBaFlRL21aNmFHMExpTHVnb29VeGlqZm1GK0ZkMVRiSVoz?=
 =?utf-8?B?QzF6M2lDUUQ3K0hqbUw2cnk5QnluMWFsdjNhNG5lckdtay9rVHhrb3FPZ3JP?=
 =?utf-8?B?clJNVnZodzNQUUd6Wkh2UnowUEhjZ1o3MXFoZEVJay9TS0IvRG9EaUxVN1Zp?=
 =?utf-8?B?cWhwV1NHcGRscUtiMFhiOTlYa2tkYnIrajduUVdISjhNYkpvNWhRellabHgw?=
 =?utf-8?B?MzNueno5S2I0Tkx6WlY1Yy90Tzg0M0p5cU1VMnBBOGc1N21kT21UL1NUbUY0?=
 =?utf-8?B?WFh5aXpLQzkraklCa0pkcVlMS1hCaVN6UDE4dnh3RHRTeWI2ci9zWkJTL3Iv?=
 =?utf-8?B?N0Y0Q2tUSzFQa2U5MGM3RDNXSmNxaXg2ek9Nak8wZzUxYm9mdGdmcVBESHFl?=
 =?utf-8?B?RXVEbVVsYXVqZDlTc2FPekFodEp2aTZ1RVNNbEx0N3RjRGNJV0ZJUnZDTkNo?=
 =?utf-8?B?ZUhxTS91UWU5ZnkxSHJ1TitPaFNhRUYxTitXS0w3SFZSK0Q1a3IxejRSVXZ4?=
 =?utf-8?B?dld0TGRiNXR0cEZkOThEaUd2Q0tEK2lGanc0NXkwS1RMc2FtVEt3NXF1ZENR?=
 =?utf-8?B?QkNtRzl6MmppcFE4eWJzbDE4K2p0Q0tTc3pSdE9DTFBRbUxMd0FVcVRYeGVk?=
 =?utf-8?Q?TmTSKkTz/quZZqypLYgDPBVY5bEcBnvhiR45K5YsIMxy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f40dbf5-339a-42db-cdc5-08da9bcdc60c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 12:35:32.1862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQThs5kYP/OUJD0ch6jsn/e57ykgzxTaBAbKCCsqfjIRe6DLdhIrKYscplHldjTg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
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
Cc: Alexander.Deucher@amd.com, zoy.bai@amd.com, Guchun.Chen@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.09.22 um 14:30 schrieb Lijo Lazar:
> Disable verbose while getting p2p distance. With verbose, it shows
> warning if ACS redirect is set between the devices. Adds noise
> to dmesg logs when a few GPU devices are on the same platform.
>
> Example log:
>
> amdgpu 0000:34:00.0: ACS redirect is set between the client and provider (0000:31:00.0)
> amdgpu 0000:34:00.0: to disable ACS redirect for this path, add the kernel parameter:
> 	pci=disable_acs_redir=0000:30:00.0;0000:2e:00.0;0000:33:00.0;0000:2e:10.0
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c04ea7f1e819..f600f3a3fe50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5578,7 +5578,7 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>   		adev->gmc.aper_base + adev->gmc.aper_size - 1;
>   	bool p2p_access = !adev->gmc.xgmi.connected_to_cpu &&
>   			  !(pci_p2pdma_distance_many(adev->pdev,
> -					&peer_adev->dev, 1, true) < 0);
> +					&peer_adev->dev, 1, false) < 0);
>   
>   	return pcie_p2p && p2p_access && (adev->gmc.visible_vram_size &&
>   		adev->gmc.real_vram_size == adev->gmc.visible_vram_size &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 782cbca37538..9e2a4c552a4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -58,7 +58,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	int r;
>   
> -	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, true) < 0)
> +	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, false) < 0)
>   		attach->peer2peer = false;
>   
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);

