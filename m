Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45596C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 18:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE04210E013;
	Tue, 14 Feb 2023 18:24:36 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A57010E013
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 18:24:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZGkxgLiL5tqLS1xzU71nixoxZGix74hOJ8Z32T487kXVDkthnwWj5O+l28BkIiNG2NyHMqkH3qyLs6wlHt5+reRc4cxgoLnR+9AQW0dJmFmU3mQrGD4/k5h2H1HtOT2wsxUzfiiqEHd/RwRFrnoRB+2v8HVHFodIBvY2lxksmgoqiJ6+YURWEQzbuUGPNslvSalx7BOsPz1uK+0n1/usNmCBItMIXlr1PuntLzH0sNEnp0yOQ5BFq6jMo5P9NNCRyFW3zr8v55XhNCeIv++wBeX+wbpGGtdoLvBjHDrhcylGtgHsTZLt92sqvwYCYfYzYID9UCZ8JIZ7nubh7FtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnSVgEN9gkSrZHqq+vImiz38CKVbmlV1AX4oOMmJ6Cw=;
 b=niTgdFDspRzaKbcONZ86SfW/EsR/1kG9NlDRKsybyR57ov3Tg+hYUkUqigx3VfquRb9FyiRenEm3aoAhijkMDXMl1A1nxcmWV9CnK9rFJ3LNOw8yfm3wXHnND6c4HMETQOL5Y1kF3NKlcxKElUuTYQCQenr1Hsl2dBYjDqgt2dZ/bTDV0v3ejr6rqm+scbcIMbsZlqTBDs/O7Uui3daEjTfmuFxY2n0lS8BJA16NoXgILL+8N0rB4lkm96zvjqUtFX8rkBiSQgG3zVAbAVMCLpy4vBsjFZU5AK+Drjc/8LonzXHslkl4GSllphIKxUVrTw1yL998jETAPI7hY7txwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnSVgEN9gkSrZHqq+vImiz38CKVbmlV1AX4oOMmJ6Cw=;
 b=w1g5/ClUv9leZmI41MOTMNHWQ5eVCuA1Ffk/ceioxQ2agFXOEn9kgtXjtnYyfZGBcfIKg3pyWUnFOx/8riEcS34s3vOLRrN24P+O+j0HvB10hrIY2w1OpfeAk3dMTEX5zYmPFwJCoLr9rI2xO7KWz0v9sICFooDYcHh+0jslAxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 18:24:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 18:24:33 +0000
Message-ID: <b5f538e1-6263-2802-7e8b-f7986e2e5447@amd.com>
Date: Tue, 14 Feb 2023 19:24:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 2/8] drm/amdgpu: replace aper_base_kaddr with
 vram_aper_base_kaddr
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-3-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214161510.2153-3-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7236560a-dccb-4131-8f0a-08db0eb8b836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YB8SajmYWlQiH9d5kqXy/WSiBFVH4sRqP+6ha7miO0eGqyErjS9IAz3qUThxUXpO1PQLrgYrXn7DaYgjCnJP/6J7pEYlngSO9lIG49d/88iQr+rtL6Q6QIlcq3lxmLtUvOcYS6q+0X3RxxEJvNKAP73rwd1awFKKVkYOEeV0tU8S2BxmY581CYB4a6Bm+2/RwKsnxgoQvwAj5A8Uz7TheH5Xtha9T5lrC5f08b148Qo8O2x1WSNz9fIXFbk7DEvYQcTTsYrZUKLgWtEv9+VjKPFX6DTQBqN6671szKONUh7i+YkyeD/FU2pI6owlHG8+ikAad6iSB2YCZK5qDIdbHEuENeZg/qcKb3Sa8+/b0g2jvHKhXpIiz37sGbTXHuXbaackl2z9N9gcfnaUS9rV5bn0heqH4LEPRMcuFDpdj3wZpclcx+4m/bDiigkeXTuetrUFdIyu2ZtJH0538J000KuAP6ILo4tuBo7PcDiiI+1nxFfZVUBR9OJtOxZD8Ib1oLPwDBmPijmZPkM+uIrfGNP/xpfd48JGi1L6gymTyBJBtAsW8GCX9T+AoWWg+X9OP9gfQeYYhssK0Fh/znywZISpyY5sM61JVk1VZp3NvUiM4Wau24E1xomJ6YqKVZ8tB53jOT8rpJlf519GhkdWhVBpKc8LQTvkhE/gBd40IVI76tawNP8focoQ07Mx+RGK3mDKBzvM3od0n2G7Qpy90sXCkCdqs34EaN7JNwPoKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(2616005)(31686004)(6486002)(66946007)(66556008)(8676002)(316002)(4326008)(66476007)(478600001)(186003)(6506007)(41300700001)(6512007)(6666004)(5660300002)(8936002)(36756003)(83380400001)(2906002)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWo2R2toYm9PbjhoTHNHMGl2cTROWUlLSitvSG16T1E3QnlVSm41dGxUWEFW?=
 =?utf-8?B?VUQ2aVhEVU53OFp0NlptN1UxelRWanVybVI1b1cyaDV2R093SlB6RFZLRzFr?=
 =?utf-8?B?S3pCSzl5NURhZDdPRDBVaTRzVXliTEpGdkxkY2sxMThYMmlHZFJ2Y1A3Uzg5?=
 =?utf-8?B?YTFhdVl3cW5aVm1hK1V5SG5lRnpsZlBxN29mYmJBU1lpVThqbEpRbDF4dUV5?=
 =?utf-8?B?cWxLYmw2M29FanhPN2Vha2laMmZHVXZ2NXY3RTlGRitEbjQ5SWx4ZisrL05I?=
 =?utf-8?B?T3hqbkdhVitpTzlQTVNQak1sYUJ4OHlSOTJZV1VaNk8zVHVuNlE2MUF6M2x1?=
 =?utf-8?B?aDdHZlRTaW1zYy9jZHpxbzhTMjBITklSbjVKZld2S2l1TkJ4M0RHZjI5RkdS?=
 =?utf-8?B?b1pIcWtuVnFwME9PRWJ0VURBbWtJVXFRYzJBdDVpVkhRdkNpbDN3dysxZ2Iw?=
 =?utf-8?B?ODBISXpvQU91b09obmphTTdiQjVyeU93VWhnb0ZmQ0NzYUJ6SUFvY0tiTmlB?=
 =?utf-8?B?RWxxdml5OWpHeWNHQXQ4ajh4Y0tUaFFLWE9RNjJ1Wm01Q0FhNmNqYTJLMWtH?=
 =?utf-8?B?c2VkQ0M1T0owTUhCQ3hmMUJZR1pvWnZMK1UwejRhZmNJWjhhQWFUejRUU1Jv?=
 =?utf-8?B?RWR0MEx4dDlOVHlGajNRc3h3cEorKzJOK3R5d3RDUVE0TDNnaTZTL1hpVEw4?=
 =?utf-8?B?bE9NZzYxdmIwQTQrTVl3SURPczMyMkc4dVBoZERtSklIWGlIQXVoSm9DckZa?=
 =?utf-8?B?TmhKUUFyNUE2eFZWbUdtYUEvOE5OZzJiWTFlditieWJjUldvczNHczF4bG5v?=
 =?utf-8?B?SkVjYlJtSjF5QmxLYXBZUm9LMHpwRytTRSs5dU55QTRCWkJPNGFJT1F1WGcy?=
 =?utf-8?B?bTJ6OGJNMnp0SjU5dmdsc2Fra0FzdTlSZmFaS0l3dDNTL1Nva3drUUY5UEZK?=
 =?utf-8?B?UlJWbnJGcjRHRFowMk52QVBPVEVva2t4V3ZjRGl0dUFyMnkvSnhUWTBDN3Er?=
 =?utf-8?B?ZzUyaXJ4dVlxY0NrZHNINk5yRjcwNVU5VUpZWTFMZXZHNis4QkRIZ0pVM3I2?=
 =?utf-8?B?WTNNa29RMTJoUCtEcElZN1dHNWY5MzJKWUp1MkxWQjNpVmFzUXlqV2o5b014?=
 =?utf-8?B?Z3U2N3NWNUhza3BBR1dLak80Y2ZDajlDSzdSbVorU2NmeThuMUtOSGdFTUpD?=
 =?utf-8?B?M2M1bjVGN3Fpd1NWQ3pwbkFPMXVyL2dDd0tVQ0s5a082TmFqN1VjSmlzanpW?=
 =?utf-8?B?L2VnSURyYlZmeGRlV0ljT0xQUm5SNDdpODdCR3ZPTEFNZG1aVUJFVm1UTWZl?=
 =?utf-8?B?ZzUyWWNVRkFKbG51SllTUERmTW05RlZ4TDZ0ZktqL2IxeDZlNnRuYTlLcVVC?=
 =?utf-8?B?ZHFFc2doQmRKTzdRaEh1OHdhZVczQVVqU2tBMWY2YmRFYjBsWEZqV1kyODl5?=
 =?utf-8?B?SW1qU1RDMVIzTnZqV2lCWlJPbWdtdncrMWdpSFZsL083bmV4WDF6NS9NWnk1?=
 =?utf-8?B?Q2NIbk9LSnBDTHV5UHFsS2I3QStHL3ZyOW1kcWlRbEhwaDdVV3JrY0txbTdN?=
 =?utf-8?B?QjltdUlNaUU2WjlNYVZ2aWN0N0k0elJtOThRWWlPbS9qRUtWeFFoWTBEQXk0?=
 =?utf-8?B?cXNMSG91QXkrcDBCNWVwd1I4Vy9KY1lZQnVUaXRPNk1pKzN1L3NYYkdLNlVO?=
 =?utf-8?B?bi9xZFRUM2JnV0k4ckdxeWl0eU9RSEZCVG90d0QrUHE3K1FuNmgyMHp6WnBa?=
 =?utf-8?B?b3luSytLZVZwVklwU3VsTHB1clhHV0NiNnM2NlM0UlgvU3dsL0hyaTQ5dHA3?=
 =?utf-8?B?WmNYbzlDaUJRd1ppMDE1OFEzZDZNSkdmcWp5TWlETjUwMUo4ckcrUm5yTlpY?=
 =?utf-8?B?L0N3RWoxdU55V1NsRmdKbkZLOWpPcGRLcGhIY0NnYWFzdy9taDJWUXpZc2pm?=
 =?utf-8?B?QyszeFJzZG5MMmNtMTlQaEdzY0JtNlBVK2c4Q09FWFNsZ2NwdkNFL0o4UDdI?=
 =?utf-8?B?bUFnZ3hydGpuRzVIdS9nRFlzMWJIUlpPN1BNVC94ejVNN2pQRjJqczlkQmk4?=
 =?utf-8?B?cy9vbDVTSmR0K1FiZ1orZ21icEpwMS8rdEF5Nmw3OXpxZG44ckZEd3YrZExm?=
 =?utf-8?B?aFE2YUVpazlDZm9zRzVnYnZ1NWwxN0FSbWlaWGtvczJ2VWticUozTmVBdE9S?=
 =?utf-8?Q?I9uoDKMNEmcdY9awPeiyHsl4GtxyZSK1lbgcSLY0acNU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7236560a-dccb-4131-8f0a-08db0eb8b836
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:24:33.2130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /44G/mtnpW+QeyjuM0Sg2QfwFEfeTP+PE/C/iWTbMROUmv4bN4uBTaa+5UaUumfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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
Cc: alexander.deucher@amd.com, Arvind.Yadav@amd.com,
 Christian Koenig <christian.koenig@amid.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 17:15 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> To differentiate it from the doorbell BAR.

Since we removed the manual ioremap() for the doorbell BAR today we 
don't really need that patch any more, don't we?

On the other hand renaming the field still makes a lot of sense for 
better documenting what it's good for.

Christian.

>
> V2: Added Christian's A-B
>
> Acked-by: Christian Koenig <christian.koenig@amid.com>
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 14 +++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/psp_v11_0.c     | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/psp_v13_0.c     | 10 +++++-----
>   5 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2f28a8c02f64..0b6a394e109b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -354,12 +354,12 @@ size_t amdgpu_device_aper_access(struct amdgpu_device *adev, loff_t pos,
>   	size_t count = 0;
>   	uint64_t last;
>   
> -	if (!adev->mman.aper_base_kaddr)
> +	if (!adev->mman.vram_aper_base_kaddr)
>   		return 0;
>   
>   	last = min(pos + size, adev->gmc.visible_vram_size);
>   	if (last > pos) {
> -		addr = adev->mman.aper_base_kaddr + pos;
> +		addr = adev->mman.vram_aper_base_kaddr + pos;
>   		count = last - pos;
>   
>   		if (write) {
> @@ -3954,9 +3954,9 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   
>   	iounmap(adev->rmmio);
>   	adev->rmmio = NULL;
> -	if (adev->mman.aper_base_kaddr)
> -		iounmap(adev->mman.aper_base_kaddr);
> -	adev->mman.aper_base_kaddr = NULL;
> +	if (adev->mman.vram_aper_base_kaddr)
> +		iounmap(adev->mman.vram_aper_base_kaddr);
> +	adev->mman.vram_aper_base_kaddr = NULL;
>   
>   	/* Memory manager related */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 55e0284b2bdd..73b831b47892 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -578,9 +578,9 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   		if ((mem->bus.offset + bus_size) > adev->gmc.visible_vram_size)
>   			return -EINVAL;
>   
> -		if (adev->mman.aper_base_kaddr &&
> +		if (adev->mman.vram_aper_base_kaddr &&
>   		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)
> -			mem->bus.addr = (u8 *)adev->mman.aper_base_kaddr +
> +			mem->bus.addr = (u8 *)adev->mman.vram_aper_base_kaddr +
>   					mem->bus.offset;
>   
>   		mem->bus.offset += adev->gmc.aper_base;
> @@ -1752,12 +1752,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   #ifdef CONFIG_64BIT
>   #ifdef CONFIG_X86
>   	if (adev->gmc.xgmi.connected_to_cpu)
> -		adev->mman.aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_cache(adev->gmc.aper_base,
>   				adev->gmc.visible_vram_size);
>   
>   	else
>   #endif
> -		adev->mman.aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
> +		adev->mman.vram_aper_base_kaddr = ioremap_wc(adev->gmc.aper_base,
>   				adev->gmc.visible_vram_size);
>   #endif
>   
> @@ -1904,9 +1904,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   
> -		if (adev->mman.aper_base_kaddr)
> -			iounmap(adev->mman.aper_base_kaddr);
> -		adev->mman.aper_base_kaddr = NULL;
> +		if (adev->mman.vram_aper_base_kaddr)
> +			iounmap(adev->mman.vram_aper_base_kaddr);
> +		adev->mman.vram_aper_base_kaddr = NULL;
>   
>   		drm_dev_exit(idx);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index e2cd5894afc9..929bc8abac28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -50,7 +50,7 @@ struct amdgpu_gtt_mgr {
>   struct amdgpu_mman {
>   	struct ttm_device		bdev;
>   	bool				initialized;
> -	void __iomem			*aper_base_kaddr;
> +	void __iomem			*vram_aper_base_kaddr;
>   
>   	/* buffer handling */
>   	const struct amdgpu_buffer_funcs	*buffer_funcs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index bd3e3e23a939..f39d4f593a2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -611,10 +611,10 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		 */
>   		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
>   
> -		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
> -			DRM_ERROR("visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
> +		if (adev->gmc.visible_vram_size < sz || !adev->mman.vram_aper_base_kaddr) {
> +			DRM_ERROR("visible_vram_size %llx or vram_aper_base_kaddr %p is not initialized.\n",
>   				  adev->gmc.visible_vram_size,
> -				  adev->mman.aper_base_kaddr);
> +				  adev->mman.vram_aper_base_kaddr);
>   			return -EINVAL;
>   		}
>   
> @@ -625,7 +625,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		}
>   
>   		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> +			memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
>   			ret = psp_v11_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>   			if (ret) {
>   				DRM_ERROR("Send long training msg failed.\n");
> @@ -634,7 +634,7 @@ static int psp_v11_0_memory_training(struct psp_context *psp, uint32_t ops)
>   				return ret;
>   			}
>   
> -			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> +			memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
>   			adev->hdp.funcs->flush_hdp(adev, NULL);
>   			vfree(buf);
>   			drm_dev_exit(idx);
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index e6a26a7e5e5e..9605c0971c11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -510,10 +510,10 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		 */
>   		sz = GDDR6_MEM_TRAINING_ENCROACHED_SIZE;
>   
> -		if (adev->gmc.visible_vram_size < sz || !adev->mman.aper_base_kaddr) {
> -			dev_err(adev->dev, "visible_vram_size %llx or aper_base_kaddr %p is not initialized.\n",
> +		if (adev->gmc.visible_vram_size < sz || !adev->mman.vram_aper_base_kaddr) {
> +			dev_err(adev->dev, "visible_vram_size %llx or vram_aper_base_kaddr %p is not initialized.\n",
>   				  adev->gmc.visible_vram_size,
> -				  adev->mman.aper_base_kaddr);
> +				  adev->mman.vram_aper_base_kaddr);
>   			return -EINVAL;
>   		}
>   
> @@ -524,7 +524,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
>   		}
>   
>   		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -			memcpy_fromio(buf, adev->mman.aper_base_kaddr, sz);
> +			memcpy_fromio(buf, adev->mman.vram_aper_base_kaddr, sz);
>   			ret = psp_v13_0_memory_training_send_msg(psp, PSP_BL__DRAM_LONG_TRAIN);
>   			if (ret) {
>   				DRM_ERROR("Send long training msg failed.\n");
> @@ -533,7 +533,7 @@ static int psp_v13_0_memory_training(struct psp_context *psp, uint32_t ops)
>   				return ret;
>   			}
>   
> -			memcpy_toio(adev->mman.aper_base_kaddr, buf, sz);
> +			memcpy_toio(adev->mman.vram_aper_base_kaddr, buf, sz);
>   			adev->hdp.funcs->flush_hdp(adev, NULL);
>   			vfree(buf);
>   			drm_dev_exit(idx);

