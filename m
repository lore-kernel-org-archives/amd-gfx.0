Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7722C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 15:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52BA710E393;
	Tue,  4 Jan 2022 15:40:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CE810E393
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 15:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK0wxXKVtONLffLVOyba/oAyH4nMrH7VFVPfo5kyRSg9tuBiANBQqHBqGVip1kFFhaD1BX0pdZ6KobKsK5PHNHJCiaFXypdHkqWGbV+Tq5pqmkq+lqmY2M9agWQwOq4n4bolXJD8KuM8hmrPQf8s5XUJkTvRaYnqHIpX5A+VBsTgdIl1Yl6je5fIFaRByAZXg+cRo7ke2xBzP5dbaYrY5moMpbkD9RJ2MxNzS+VFnF1wn2ejFifvTa3N1+dSh+ZJZcdTjnOsu1QpokPqA0sJNvNl2CoEiK3GbKYs6U/CRVG0KibXlUjli1qyhqS7JxdvwTJZpv3Iv86RRETLTKJ9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZwG0kkJr+BgGVI+za4ROwpcXUaszqlrfOk9E3rAgJU=;
 b=XVmmYDHDcWgHbg7HuUhg4vU1wxdFteN2RHe5fbdULptUJ0xX+gA9Nh8MbA6cg364aIycKIf7iJHV5LhLQ44REeU5FMSBxRnj8eNAfnhiPpy/rgTeav1CrnZQfHe3vXeYYCDN1/KdYPHJaZPRp0Dbe4oOHq6WNOAgZDllZwMINeFjSlrN+Y4wkUm7a8Dpsp/c5FVHB1oFay9KNHETCSlyzx3tuZOA0Vt8d8DoCbPp7QIUL8Log+VyJjkhC9nIS9MG6MT0/XkEcVCqwPJ3VAmSyKewwmkGmHsvajX46DSTNbdOB4ty3BV/+L1up/dYlOLq1HFXNuUs26Yy3UyJt8P+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZwG0kkJr+BgGVI+za4ROwpcXUaszqlrfOk9E3rAgJU=;
 b=Ukrj+wqKFqagbyXJiDN0EXy280+kQdVNwXYEEwWWMSUBZhsu/RYAudYIeg2PuBuzvU84aodx2Mfk7o84G0D9Flg9TvCfRLvt2pK2yEADGJViyqduPJsdaFblDtMb/Zgr6BxSCGI2UcdwmZaIm9F/h5s4kz5xwcioMiz5iytp+as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB3563.namprd12.prod.outlook.com (2603:10b6:5:11a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 4 Jan
 2022 15:40:03 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::5573:3d0a:9cfd:f13c%7]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 15:40:03 +0000
Subject: Re: [PATCH] drm/amdgpu: Delay unmapping MMIO VRAM to
 amdgpu_ttm_fini() in GPU initialization failure
To: Leslie Shi <Yuliang.Shi@amd.com>, lijo.lazar@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20220104023036.2114-1-Yuliang.Shi@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <e6ce7a07-9819-63d0-475a-388c099c906f@amd.com>
Date: Tue, 4 Jan 2022 10:40:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220104023036.2114-1-Yuliang.Shi@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: CH0PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:610:b0::33) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee536a20-52e7-4f1b-4aee-08d9cf9879d7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3563:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3563BE998E7A1EF197D77DFBEA4A9@DM6PR12MB3563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FI3CmWCY33lqvsRHWYRpUiTlb1TgM0tKnb1K554q8I9CeKKZ/Hyl1xtTLDHZAu0u96EtJ0MVUTsMJwS1WR9N2u7szrGxt/JMxU2jp+naXPcJC59v4XIwjCr0kz5iYdtQbwFe0XRqW1+FUYsUqV1Qckp4JcDAW9HBrRNg2K0/wQXTjsUhtiQ7s3FKTwiQ13k47VGwo1Cq0R+/vxENtC71HijyW9Li0X+tvewH86CAQ7fnlfzr2v3ywnd/bjuWGGO2ZjYuKPOXWRAVbGuholx1JvQsgSvxuQdc1zGUNvc8YFr3/MuDCdRuMnmxMTxC06eqYEwW5+SBNFKp3KNfXf5vkASmk8+pVWSxjZMHoq1ObfbP7h9b9dDVgeDAb/OXht4pA7ZjdvrKndEjKYcCPtUXlN5q8dQhaR5N9yDp8LP/x6N5f3FrnEFF7zG8/QmegPWvcOqCjhPJVDGPGQMlPHW4xhdEQkgw04YJR8ROPne2blW7GYyAj0bPmRzhyu3o8HtOp6RgpKqlrhf+P8FCxbm+46uuY67Lve7ReNDi1Qvefya/BKjihHsJo0VcMBo8UaYejZ7br6mCWBfnONijVreugqeo4kaa3WFLb5oFJ6sYvHixGH4uM8TS/oKJRLThyvBkX2AIpY2X9EDmC//GH3PgVfLKbURw/pqKK9AMmapMk4cFS+wPaJjOTzB9NkPYv6UBrU0l7v+w5kYZvn7J9gGNPRy92bz5nEqAFTfsPH2axwHGTycBRW6bT74zBsu1IwD7yHfQTXGD+QeAwg7mfVPh2B3JTQOkwWk5DQ+Ti2Mm+r+oi6WcUcrH9VxNfpTAASXl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(31696002)(36756003)(8936002)(508600001)(316002)(83380400001)(6512007)(966005)(31686004)(2906002)(38100700002)(2616005)(8676002)(86362001)(4326008)(6486002)(6506007)(66476007)(44832011)(53546011)(66556008)(66946007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejVldEtVRXJGYWZqQWhLWnQwa3dvcnk0dDB0cmx5LzlSb3lXMjhTb01TL05T?=
 =?utf-8?B?QUdUdERLUmVXZHhTMlYzZHpBMzFudjhPNktxR1NtdnFYajhYN3Y1WnZnZkNQ?=
 =?utf-8?B?V0wvS25DaGdoUG9qTjR5ckRibUtUc3Eya2Rxc1F3MDdLZG9nTlVmd2xtbmZD?=
 =?utf-8?B?U0huQmFjSC8vcnFxU1orNXVValhDVzkvK2ttRXZlYnJaSFNYQk4xZ01lU0cw?=
 =?utf-8?B?blRtZzhhKy9FODY2b0NMcDZ1Z082YUphRWZUdnZEVzhuZTR6cDAzTmIvOE91?=
 =?utf-8?B?QlhWS0wrb2hmL2pvdDRHUWx0QUlWWG5NdXQvZ3RURnJYcnJwWkxyMGJJUmN4?=
 =?utf-8?B?WnN5ZjlDVXNBcmtuWHdSZ09IK2Y1NXZoemlwTE94Q3hJSE1JVlRXdHRCdit3?=
 =?utf-8?B?eU1vNmFxNXJ2c1NhV3RnNnB2Mk5OQzlhMkl4MHdsdWdKekZqa1QydXpGNmpX?=
 =?utf-8?B?b3JHcHM5Y1V6ZEpyZVRraVBCcStTbVRjMWxQTTBwc3JiRHVGWUE4amdSNmFX?=
 =?utf-8?B?djFHdzF4dWxSTGZiU2RNOTVuamV6bm9zMGkzdXJrd1ladFBWNkNYV1hMd3Vt?=
 =?utf-8?B?c2RzQUM2aVU3M3o1VXBMV2dwbzVHWEZtK2FINjhpdktzSkN5aDdKL1l5YkU5?=
 =?utf-8?B?aW92N1hrUDM3VEpkQk9XQVZlQ0g2YktaWFBSZmVaNVF0UEg1Q3ZIcDB5aGxC?=
 =?utf-8?B?UC9ORUNPVGlhVzdVU3BCd2lvSFhSTjgwZWx6VEFpaFhlVzY4Qm55UXhQNXJC?=
 =?utf-8?B?SWVjNko0MHJ6aG1ZK2ozZE1DNWR0VlpoU0FSRnl3c0haTWJMcm9yNk5GdDBi?=
 =?utf-8?B?ZVRMQjg5Z29ZNm9XWFZaeThWMWI5bm9MZ2w1V1NRblllZkY0L3AvK3FLZDRV?=
 =?utf-8?B?SXRrQjFRMzVMaWZGTjh2Z3JQaUdvUVI4VW9qSEdZSmpjL0dVdS9EQzJUQjYy?=
 =?utf-8?B?aUlreEIyVXVFalBuZDdzbSs0aEJtTUY2amlLbExNeVJzeWhjYjhBMlA3dzVW?=
 =?utf-8?B?anVwNmxNNXI0QWx2eGNpT2xCaHRKUzRQMHJCM1M1MHlLUnlNYzJCSWR0cWRR?=
 =?utf-8?B?MW14YWl0Vi8vZHFPK0V4LzJaNjNtVjhOUGVhUFBUUHJlNFdWY2xRdlVtWC91?=
 =?utf-8?B?RjYzRWJwMnBWV3hvYjJkM0xlK210QlR1YU1hcnk2SkZPeUpmT3VPWENkbzlJ?=
 =?utf-8?B?YkRTUHhoNnEweFRlSko1MUJ5WUpXVUo1MUJtSWdrZGcyeU0zSkJ4VERlQVFP?=
 =?utf-8?B?YlBoWmVOTEpEQWlHV004dGFUcndtQTVNOE1LU3M5d2d4RXROaVIyYUlFR0xU?=
 =?utf-8?B?UDcxRHpUUkRJTjZVRjFvaklEakwwVnIzMCtaTW9oWkx6ZVo1a2tha05aRk5u?=
 =?utf-8?B?aUQyd1dyNEkwTFdsd2g3dkQrdjUvZXk3R2xMZW9TaExwWEs0ZnNEd1BRbXcz?=
 =?utf-8?B?a1AvMHg2RDA0TmZ1ZzlNN0s2Skc2QmcweWhVWDI4TWpUZFF3TWV6SlI0aCtF?=
 =?utf-8?B?SGo4TU4zcEtpRHAybi9MMWZ3SE4rMGlCRWVTSVhIQTZZdmhQeHY3UmtROTZ4?=
 =?utf-8?B?YzArdUIyNU5HQWlJZExXZlJEY0p3cXNGODNIOHRKeWNoZHhyam51YjIyY0tX?=
 =?utf-8?B?QXNIRml6Skw1V3VWUGJxd05qVHJoaXpUaHpnRnFBSmpOQ1JLZ2M4TzY1UGFU?=
 =?utf-8?B?ZjEvYU9Bakhna1N5Nm51L0VvRjN0eHNIM3NScFNlbittN0drWDRaWmwveVR4?=
 =?utf-8?B?T2MraGxkVEZaYnd3dXJWUzd1b1JvS2tock8vVFNRcWRhS01Cb2E3dmNDMllt?=
 =?utf-8?B?TXZzRUZkUnNxQitmSXhlei9kWkZvTkRiUzdOVHByblR0UDZiU3FVYVdwYlhs?=
 =?utf-8?B?b29lSEc3YlJ5c1U0ajBLeU8vcXVCQ3dsY0w0aGhLcXpSaVBBUGgyL0R6aDc0?=
 =?utf-8?B?aTZwN3dtUWJIOHRrSEptck5FazI1S1p2UVdSeXpTY1VaRUdSWk1PeUJZeVEx?=
 =?utf-8?B?YkZjTVJBeDFjN0N6c1E0d1ZKU1pPNTdNN0VPMEExL3UyRFNmZHY2L0syOVJy?=
 =?utf-8?B?WndNNDdZeVlOWEFWVmVEbkZLVVpFTlIrZlhZeHZxb0ZGTDMwUERkYUFIOHZB?=
 =?utf-8?B?dVJmYkw1VUxyNWYxU1lhSTdoZDlzSUtmc2xnVit1MnN5b0NJRzZFbHR3QnpS?=
 =?utf-8?B?V2FJSkR2K2RyYm50NUM4NW5FdjltT0VmOFMrSWpkdytHSnU0dkZiUTRMMWpz?=
 =?utf-8?Q?7SM9n2hchQlng42CHfk3QEu4uXsSc5Xuv6ontWbqf8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee536a20-52e7-4f1b-4aee-08d9cf9879d7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 15:40:03.7329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJ0Ir5Fc8J4U2QgFsiTqyHaYjsu1hWTekC6coiUzYmk93f6AcDrb82n5ci1kyw05g5enT6OAD/pWm3+Mtp0zVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3563
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-01-03 9:30 p.m., Leslie Shi wrote:
> If the driver loads failed during hw_init(), delay unmapping MMIO VRAM to amdgpu_ttm_fini().
> Its prevents accessing invalid memory address in vcn_v3_0_sw_fini().
>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 ++++
>   2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ce93a304292c..d6006de57af5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3830,7 +3830,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> -static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
> +static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev, bool unmap_mmio_vram)
>   {
>   	/* Clear all CPU mappings pointing to this device */
>   	unmap_mapping_range(adev->ddev.anon_inode->i_mapping, 0, 0, 1);
> @@ -3840,9 +3840,12 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>   
>   	iounmap(adev->rmmio);
>   	adev->rmmio = NULL;
> -	if (adev->mman.aper_base_kaddr)
> -		iounmap(adev->mman.aper_base_kaddr);
> -	adev->mman.aper_base_kaddr = NULL;


Why only VRAM ? Why not register BAR above ? In general I don't see why 
not just follow
what i suggested here https://www.spinics.net/lists/amd-gfx/msg72217.html

Andrey


> +
> +	if (unmap_mmio_vram) {
> +		if (adev->mman.aper_base_kaddr)
> +			iounmap(adev->mman.aper_base_kaddr);
> +		adev->mman.aper_base_kaddr = NULL;
> +	}
>   
>   	/* Memory manager related */
>   	if (!adev->gmc.xgmi.connected_to_cpu) {
> @@ -3905,8 +3908,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   	amdgpu_gart_dummy_page_fini(adev);
>   
> -	if (drm_dev_is_unplugged(adev_to_drm(adev)))
> -		amdgpu_device_unmap_mmio(adev);
> +	amdgpu_device_unmap_mmio(adev, drm_dev_is_unplugged(adev_to_drm(adev)));
>   
>   }
>   
> @@ -5727,7 +5729,7 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>   
>   	adev->no_hw_access = true;
>   
> -	amdgpu_device_unmap_mmio(adev);
> +	amdgpu_device_unmap_mmio(adev, true);
>   
>   	pci_disable_device(pdev);
>   	pci_wait_for_pending_transaction(pdev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 367abed1d6e6..67cd12caf019 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1815,6 +1815,10 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   				      NULL, NULL);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
>   
> +        if (adev->mman.aper_base_kaddr)
> +                iounmap(adev->mman.aper_base_kaddr);
> +        adev->mman.aper_base_kaddr = NULL;
> +
>   	amdgpu_vram_mgr_fini(adev);
>   	amdgpu_gtt_mgr_fini(adev);
>   	amdgpu_preempt_mgr_fini(adev);
