Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Oct 2022 16:43:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB72F10E6E2;
	Wed,  5 Oct 2022 16:43:35 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2B310E6E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Oct 2022 16:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJac/vrROTkj37hgHrErJOO7rnTGe+ZZGh0mVaOJJTeoKzi5cz/eNPAsFM69OajD6mlF+toVnPoIgqtqc7pyS0ER7q5oVcKkGNKa3rNgYqpVr2IN4kRp0LxykmH2x3XNjcc6jUABXkxwqGv1U/30vYpW8FvkObEh+yz6hgDORtyuSI+ROeMdiBc4dbC0TX2Q5ebdbiOeNOLXIV7yV/viNFRKmmmpjAqtKF6dHDinJ9YuWUa7ld6AeqSf/QWsYm3tBofjLIypp0I/nrjGYPmHvSYYnBUKfaItDyUAEBcbtnbCKuHfpG3D8PpBLrztLynIv4LVAZ7y8PcEHoTBEF3a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+Pnrrj6BNl2bl4Y/TW/CNqU4sW47rVTrLmY+7pRsak=;
 b=gR/ctP0iwxai4eLktAgcMtR5pIrOktOWN3vdFWIGcyi4x3J9iHL4rN7V+IMO4adUsTpTug841KCP3/P1LycRAJzbmBN0hpuhCVIB48FS/aWv3ot6E1xa5OWiTswztFKgz64F/2jiWCzIGyfjpOKYiWs0RQ6xPZA0KZEtd3JC9iFxhghFKh/U3PH9XAeOaJ0juuCPNAExY1lLydc2fQPmRWEwW5IDvQAy5+zxtKLimBsLGrIccvVJbrKTTMCf7KYptUcedKIpztNX5ONjoUARHvWODRw98hyPbxdm2XCxRuiHkgP9dr19a5FLyhbzUJC7KdmYuaJRDScxzC74EqmUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+Pnrrj6BNl2bl4Y/TW/CNqU4sW47rVTrLmY+7pRsak=;
 b=d3zu4jLuz6jMICp6Pk6yRT3ByvRYI8GqSUcmXxCw4HetkN12JPj2d9lSXB42r9YtJlmlAhc35LRT4FAGJQ06ne4wEhge2kK9aOviW4YFX5kumZ1qNV4fCzFIZYdBgyi2cdojc09+M+ymtHDu12uFksnAUp0cKPGLyOo/CCJ/ewA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5653.namprd12.prod.outlook.com (2603:10b6:510:132::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 16:43:28 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.032; Wed, 5 Oct 2022
 16:43:28 +0000
Message-ID: <97a4e0df-bd79-8c1d-c3b1-af88850e8d3e@amd.com>
Date: Wed, 5 Oct 2022 12:43:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] drm/amdgpu: set vm_update_mode=0 as default for Sienna
 Cichlid in SRIOV case
To: amd-gfx@lists.freedesktop.org, "Slivka, Danijel" <Danijel.Slivka@amd.com>
References: <20221005110325.31871-1-danijel.slivka@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221005110325.31871-1-danijel.slivka@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e35c08-de38-461c-cee5-08daa6f0bab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbDxWYJaR9RiYZVlpeHW1RswdJRpe9S/En2UY6IXJYByIAvA4h26k110jfOk2hT+pq8R6MYOC9IYhDbTY1Z5wjBgQm0rQADxFKm8q6mDLuBwi8qr3ECgvctWy8KgMl4/CgS450J40bbDbpw+xmOvXaFGboIsst6IYepIjSQZ2rMEaif5awhWQqXeamVte+Mywg30ijnmWgJkBgZLlh2TD4jt7rkfNopjUfaifKudZfHU+F+KC1Vj/K+apkg2A7DwMZs8P33cBWEaoqLJw5FPxCCqp0yGce9PNDvzkqWzGmbnYeTMLqn9ggbsBuih48+vB7VQ9IZF9uAZXTzdLtajZMVEw9aehAPV7Ehb+yS7m8HMisZ5vnXeN2IczQn07AaXgU7FVylFkRot6s81IGMazDH+E1rj/tG3e65Fe9TZe56w/3N3VLlKZJo6NUIx7vwiy4RasaVkFIhN4GDodHQF3dmRzHq+S/sMjLEJkpyfebt/5fqbU5q3YaUBtZ7QkrjHN1fvia8erdmPj7BF0uDXMIXUkncruBgLjT+aLwYlg5Ul0nzP1uq20jZ34ejwomW7lQg4UnB8Wud9AwFd4bXHgq/UZRSPvz6gMiGAasz9C9dCiJ04IpXW/9G7FXtgR/Depyh/Ibuaw8jCKUBRmam0Z3s78Ls40mnR3dVxNZKp+chdq8rGDgBLUoXkXFAU6PwFwFYJ7MvlELjYpXkqb0goAyUOuveFoUXBR+rdgeUaWsys+ghDSN6U44CB23swdRt/ZA8Aw7hxawsfuoJmUYhFOr4Qjlg4sswlvTpsq0YOj6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(2906002)(31686004)(36756003)(66556008)(8936002)(66476007)(66946007)(6486002)(6862004)(31696002)(6636002)(37006003)(5660300002)(41300700001)(8676002)(86362001)(6506007)(83380400001)(44832011)(478600001)(6512007)(2616005)(26005)(316002)(186003)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFNbmFqVmo5K2VKZzBMTEdtRWNBOFZpVGY1MHJCanNQVy9yRzh6WnUwZlRI?=
 =?utf-8?B?WTJSUHZLQzVuZWhhZGZNV3VlaEhjVmo1TFpMWnNwbG4xbW1ra21zSXVDejB1?=
 =?utf-8?B?OWpJOExjQjU2Q0ZCUDRGaWRQTzh6b3BkeDRmTERIZkxPK2t3eTBkZ1g3Qlp4?=
 =?utf-8?B?RldoRUUxY2thOXQyM2N0N25PSmdTTjZBTXBEdnh0ZHN3S2o2TGdnU0EzaGlo?=
 =?utf-8?B?MWNXWlp1YmM0bytCSGd2TjZPTmJDV1VDQVU3RVZ4akJMM1hqdGNYMENPK3ZE?=
 =?utf-8?B?QXh1ZEpPd3JOUktLZmphNkx2czEwZTg2endCbUZ0RGpXcnp5VlUyOHRCMWRo?=
 =?utf-8?B?bytBaE1MVm1lVllxZEFvOG9zRE9sZ3lncDhINXN3cTRjenZlQSs2bTBySzlo?=
 =?utf-8?B?eGZITHdBUitxY2c3MlpxZ3loT0FBekMxYStXdEdMcnVWNnFpSmVXNndTYTVG?=
 =?utf-8?B?TUswU2NNeHI0UkFjUzJlWXk3ZDQyRnN5OHhuNkY4MTN3MkdHYlpPcm1NUTVk?=
 =?utf-8?B?TXBHb2ZWaXVhdTUyS1NES3IyRWdxNzhJVTEydHFWR0FtRHk4dGEvOVUxWWM5?=
 =?utf-8?B?aTVFZGFqbWVnNjRtVUlHb0RscHVJd2xYMGNXUzJzZk5wUnMyL2N2aW5vOHNY?=
 =?utf-8?B?VEVDUmFHYTdlNjJWS3huNUUyRUNVbWJjZmdic0VXSGRYSHcxbFRwWThXSXJR?=
 =?utf-8?B?MC9MaC9CZG1aSFpnVGUzakNTdWZucnc0UWNmcTJlMFFvK3VyMTl4TWRpMDhN?=
 =?utf-8?B?bmt5RktjK3Q1SVV1c1dNM20ySWpBaGVRWURpK050OVFPM1pudnV4cUpYNER2?=
 =?utf-8?B?WHQzd1Y0bmdhakpqRkRlU2t4MlZLeXJ5aUhweTRkUE1CN0llTVVyQTN4NHdB?=
 =?utf-8?B?ZDBsWm5ZdTBLbE5sRkF1RnBqL04rZ2VCWGNJQzkvWjJXSHF1MW5ZMC92Q3NE?=
 =?utf-8?B?MnR6RSs4QnQyeVlOaFpyVnZ0Y0VQVmtwYldVdklxS0pXbXg3NTBhZGkvSHNS?=
 =?utf-8?B?NGRnMEF1YmUzUFNuUjBPRFJEL3hsMmVWQXN0VVJRTjVIaVZZakpLMzRRaW5k?=
 =?utf-8?B?WWRqNWdvdlJycVp5V1RxZzJCbGdhd041SGpCUjNNTlRua3dOM01hRzk5c1Z5?=
 =?utf-8?B?SVQwWEhEU092VG42cHBPZFJNUGZlVWNzbXQ5aklCVEp4aWNvd05mV3g2VGlj?=
 =?utf-8?B?QUJMT2ZlcktSd05oaE1KRjVYK1R3ZkpXb0VwdHpxWFIrOXRNL3RHSzlPNkRn?=
 =?utf-8?B?TllmejF1dWRZdlBVVHkvcmZlOURITUkyNG9ubWhpdCtnU0FhVFJWYjg5NFU1?=
 =?utf-8?B?VXppVVVoSWladUpTL2RhWjlCeG5IQ3pRU0dUV2VNbmRGQlF2a2NTWi9HVGIv?=
 =?utf-8?B?Ui92cUJDcUpia3pNVHZCNjZ1djZvd0duNHNoNFR3eWlmeVJRYmUrQVJGcUJv?=
 =?utf-8?B?SHVuTDJrMDN6VG1XL1FvY1JIdk95VlZDcUVaK3JYSXl4NWliaGliTlptaXlt?=
 =?utf-8?B?NE9ZUFh6cSt5d3pUK29KRWxKdUxwR01VTnhSNXdGVjlXQ0VrK3pMbk1seGY0?=
 =?utf-8?B?eDIvOHMrVWdYQnM0RlNTd0IzQ3dMZzdCR3N4VHUwY3QvaGtyenp5d0tJQkRL?=
 =?utf-8?B?WGlhMDVLQmZMYllXeWN6WENuVkRjcHkzbXltdFVPdEZ2bVRtM2VjRHJ0OFYv?=
 =?utf-8?B?U0VwUjVyc0J2YWt5N3BtQ2RTcHRNNkdSRStDbzJuUHIrOVZINXd5Qi9hbVZH?=
 =?utf-8?B?Rnh6T2lZRjE4a1ZGTEd4S0ZaWG5oMjNST0VtV0ZBdHhOUDR5Znl6ZlpiVjlT?=
 =?utf-8?B?dnZGSHZJdU85UUp4MG9LbXFpNS8vM29ScFAwcUpoRWZ2Rmp2QTNpMTZRbGF0?=
 =?utf-8?B?L0Nxckl4WlluVjc5czRKcXBFUUpxYUk1UGdNaVFpNGV6NVJ1d01VVXc5Z1dJ?=
 =?utf-8?B?MTN0SEw1UWNndlIxWHgyVVlWOGxxOXZFU3RNZHFSUVZuZVFCNTY3WFIrWTBN?=
 =?utf-8?B?eU1SVUtnNzFKTmkxU1NVcFcvdUw3MUxiUTliTU1EaGF5OVY2VkIvOEVXYi9G?=
 =?utf-8?B?NkNPZTlPekRuNSs5OS9DWkVvWE4vTEkxbEZuTWMxY2F1ZHRVZ0tLVnlnRWhT?=
 =?utf-8?Q?55GN9ZuZoSrZz9Kzp0ztnRSh1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e35c08-de38-461c-cee5-08daa6f0bab5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 16:43:28.2591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wOY0MMTPM7FxECjEk6aTjYF65lUbkEN39yKbNmErC84x/pUmEYmMLknhetRLZp6okOk5CqRcqj65K570ANz7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
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

Am 2022-10-05 um 07:03 schrieb Danijel Slivka:
> CPU pagetable updates have issues with HDP flush as VF MMIO access
> protection is not allowing write during sriov runtime to
> mmBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL
>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 83b0c5d86e48..32088ac0666c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2338,7 +2338,9 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
>   	 */
>   #ifdef CONFIG_X86_64
>   	if (amdgpu_vm_update_mode == -1) {
> -		if (amdgpu_gmc_vram_full_visible(&adev->gmc))
> +		if (amdgpu_gmc_vram_full_visible(&adev->gmc) &&
> +		    !(adev->asic_type == CHIP_SIENNA_CICHLID &&
> +		    amdgpu_sriov_vf(adev)))

This would need at least a code comment. But I'd prefer a more general 
solution that expresses that some ASICs don't allow any MMIO access 
under SRIOV.

I found that there is this function defined in amdgpu_virt.c/h: bool 
amdgpu_virt_mmio_blocked(struct amdgpu_device *adev). Would this return 
the correct result and could you use it here instead of a hard-coded 
asic_type?

Or maybe this could be added as a flag in (adev)->virt.caps and get 
initialized in some ASIC-specific code path.

Regards,
   Felix


>   			adev->vm_manager.vm_update_mode =
>   				AMDGPU_VM_USE_CPU_FOR_COMPUTE;
>   		else
