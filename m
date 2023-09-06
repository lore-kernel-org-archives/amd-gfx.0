Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997D3EB8FAD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 07:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39BB210E587;
	Wed,  6 Sep 2023 07:23:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 616DD10E587
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 07:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBgftATGagm4XD8v+kEYcvH36pPGMFluQJuwFkn8QB6DBi65+0UiM7zZov7Gg4DUTzi8bx3sl1ofEUYOXln3nwTklZ8/bkZ2L/20zQqdhZwAXk/SGGUQlk139uOUm/C7Mp4k2OpXHeeOTXMptHzOZ2GmHNxcF6cpxWliOGaRcepuPiDbdDfxqkKFSHvHkA7BCtCUR9Wz+IwmypZC5R+swS4CMB32APjOXZtYd2M1LNTb2lmdXXXM2dDitw44r/p0mZSceDd5VU8CkcqP/m3lm1V41R+Cl5paAym6b1nD2XPqp+Zi30KriIhn5cuHvKfyGmwVtPT/jRflh6dCjDWaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+Xu4B5X1ri3yVsmFIHwiylp/HJa7PEOZG2BoyNPwj4=;
 b=fHNPsxYQl95i76FRo06LUZSZ/vosHlVTZi77MflS3Cj1fTyWBQW4ZYSgEJ6eMoqkibyO6ZhU6Xsygi+nc8UhOcYUIPXVgs4CdH91D0nmEdUFyxUTpnPiZWFY+KQVJBMS0HvNPbPTJwUuXYBt54dN3WYbvir+2ftqOZJlWyY6xPwCxZcCVf2VvcecOsUWHnM6YAkFLqpZTPanYmJM5HB5bsTtC0h+Gt6JfeEA4D93QZyqgwkvLpzPNu9HcsLScCpMKw2Bapr/xAHfAuKJQbwULLgJlnZck+CPbaD9f49iHZAdCOz3KprH9Gnt5v/oZF3xlemEGBu7Mj8AjWx5mnFISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+Xu4B5X1ri3yVsmFIHwiylp/HJa7PEOZG2BoyNPwj4=;
 b=vku3J5gIwZmzNsn1odPsALYuR6zlBDp+WxX10tdMB2M7R3T0eo8Hy3Desn9BXIfmFOxycy0tBUs3tSFpUtJS+zTKNlUXIHaB7hWKgu0pXo7EY3PDjfiX6jUZ7a68XPhzs7vfZynPUT71kr2rQv/ZHyB3DI0/lXBR74ZLTJvsNwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 07:23:24 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 07:23:24 +0000
Message-ID: <9c792b2e-5c2d-840c-e14c-b225880a0d65@amd.com>
Date: Wed, 6 Sep 2023 09:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] drm/amd: Fix the flag setting code for interrupt
 request
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230906065532.3340082-1-Jun.Ma2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230906065532.3340082-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0215.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL0PR12MB4849:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed321a8-55e3-45ae-cd45-08dbaeaa284a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbqWXTr7jUxfLiGjPjNGdiJvbyIFrWZ1yyYX+xLBN3c6f72s2NuItcI1TQpClYPxfPaDif08Bf3mU67fbsA6Yuwwj0SEhTQzcJjGowHhJ5a6Zt/zNHLujc/bvcoNlHb1aRZqYAK6OxlEIe/Vio6+Kf/H2gLkOHyOqzBNFncn2LPVR3cT9qrywgwWZxDvymEiMmDiktbZl3YSZ59RQa1rnyuQD6+hK6ggwjLiUTSP/A7Yoxh0pkp6Etvscr3cirdkgiHYp4e9Te6G8iaHRH3DGkRVKQVYZUOmPJSX6NCHVrPm62cM2/SFq7GIzujZFjS5mh9mFxgeI3VBGMjeUunXfP8MMi1oSnNmgzHnpR0mUDfaDwyhEV5JV+NxolQ00KRNwsz2JztXRxej18OMkgrOrDidCVU2d74+gakoQNyd3E3pnf4r3W3WezazmotRGDZ+EgE6x2O/A+DHCKxAgzkhVGg5fWY58Wt3RWfT/wQ3CJbtR9AeXjzre65F13iYlrPLIJ1sBwie6231tMk89QevZnNqjJO4rNZkqP6YAPcvp4xeF/tjGcj5r+dYUN4D/cyOB92dCnZD3AlTOEAYa++0fGgK/yVGC1KbJlQZ9Xu4ysp7geCFFvGuSdQv/GeOfwY13llgecJhoFod6lCNMomcMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(366004)(136003)(186009)(451199024)(1800799009)(8936002)(8676002)(31686004)(5660300002)(6636002)(316002)(2906002)(36756003)(66556008)(66946007)(66476007)(4326008)(6506007)(6486002)(6512007)(26005)(38100700002)(6666004)(478600001)(66574015)(83380400001)(2616005)(31696002)(41300700001)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXMxT2FWdTZ4UlpxSUFGWlpKT1hUZDlNSk5Db05zTU1HYkdwajNsa0ZtM2NV?=
 =?utf-8?B?UFJLWldZcjJ6cndHZDlLWjBQNXdRRHQremxTTFQvN3hRSWxJRC81ZWhWTlhR?=
 =?utf-8?B?Wi82bWlaNkpjdXZOR0FUbXY0MFFxRXdCc3VoQ3FRL3c2eGllZzVOeDNJSHp6?=
 =?utf-8?B?TWhrSTgrM2NYNmhZanVyblU2Z0o3dFRtSkdZeXc4ZnhjdjlsWUtUUzQ5Y2hS?=
 =?utf-8?B?WGRWVFcyd3JoN2lqYXhtMDlYUlY3L3BFZlZoQzk0QjZNTjlRK1BUdEhPL2Uz?=
 =?utf-8?B?dGpFOVZSeDVNR0hXU2d2NitnRFhiSzBvVTh3ZGVwbGRiYm1RL29TMm5kMmdY?=
 =?utf-8?B?Q0x6Y1hTUHNFT3ZnMHAxMCtyL3M1eDM5NzUxd2JaVVhBNXJuL3pkeTNRU0o3?=
 =?utf-8?B?cllvMzFOTzM0UFh1M2Y5dWd1MU84YUN6TDA0aTcyTFR0aXFHa2d0WFFBWWZT?=
 =?utf-8?B?Ky9BNStBN2xrdGI4bitaeVpNT3VPUXowRE56bkRYWnRvM0FrNjc3MDlmUmE2?=
 =?utf-8?B?K1Q0SkU2dUpvNDN1SVliK1QvZkZnRDJxbHlJNzV6NjZhMW9tcWdKY08zRUQw?=
 =?utf-8?B?UXNmREhvd0ZGT1BIc2tKekRRTHV5cUFKTXMxRTAzcmpDandxVDZjdmRlM2N2?=
 =?utf-8?B?OThHTWM2NDNzUVN2bFMzbEZqOXg2czdadEdxMDQzb1BSTUpXRlkxSnprTTQ5?=
 =?utf-8?B?VFRLNFZodTVLN25ScWthUDFEVVR1dlBzaUVaQkxObmpJQ29lbmc2U2lKb1ND?=
 =?utf-8?B?ZEQyVWgyQlA2THNSdTdCWHNhNSttRnhmWGZNRDRaTi9DTjh3MWtKcllrZm96?=
 =?utf-8?B?ZkNqNzFRTUF0ZTZldzZDSVdSYTlMZmpKcWlITVREOE4vcmt1K2d3Y25kZ3Ez?=
 =?utf-8?B?S1hJR3dJRUhhUWplQmlFaW9xdUgwOUc1WjY4ZkFpUWczaWNvR1FmYnpJeFQr?=
 =?utf-8?B?Qng2YUlOMGpVNkIvVlhpaGt1Y2F4cXJuNUJoTmJHVHl4VXhlTitwQTZSS0RW?=
 =?utf-8?B?VHAvMEZHYXBCOGJVMEZlSnlxVUVBem9kSUNuTEpRRlZEZko4NXF3ZXUwSytO?=
 =?utf-8?B?ZkVEbEdCNjNpaFpNM0g2VWJ1VkltZ3k0REVjWFBteVRIVXZjN0dtdmF3VGlD?=
 =?utf-8?B?UzNycE4vU203MVRIRy9TOHM2TzBxV2VYQk9FS3NxS2xJd2JTNGpNVUdGVzBt?=
 =?utf-8?B?ZWNhaTdMM3VUOGVFbjNSVmFnalhzditJTURZb1p5M2IzMVY2ckZWaksyYk1s?=
 =?utf-8?B?eVdkbkNVM1FXR01NWTlwbEk5ZUpSbDRSWTNyRmhsQ1FBc0VCd2Z1YW52YmhP?=
 =?utf-8?B?Ylk0eHIwYWdWanpyek5DbGttbGdnVUZuT1BTYlJwc3ZhQWlXb0N1M3k3b1lC?=
 =?utf-8?B?enBBbEFCVDZNOUZhV1crckp3UDVTT3NkTGNZZERpUEJQM21oSEU0S20vS0Zn?=
 =?utf-8?B?SGVLVTQwcU9Cbml5SDB5akdISWZDNzFTVGowZVFmZm5iSHg0c3NwOWRGT3M0?=
 =?utf-8?B?bVJRMm5BQkxPTzh3bE5JeUk2Qk5IdFpKSW11ekRYaFdqT0phcXpmT2dIL0Iv?=
 =?utf-8?B?OXVOdDlRaHl4MUdMYWtWSjg4L0hpYkNHMWFBcU9MMUlIL0xoaktJQVlCUlh4?=
 =?utf-8?B?aUNYT2dHQ3hIR2hnTVI1RndrS1ZTMlZ5QW5xSnhlOW5zcUNJZDY4Uk5VT0pF?=
 =?utf-8?B?TGZsMFd0VkRBN2w5L3V2OGIraWhqdmMzNGc0MGt4VWJJUFZueXJ2aDJ0OXhq?=
 =?utf-8?B?YVBzbk9MOFhpUnFYVmowVndKcnZDcW8rVElSZ0hJRGxzVFNISS9SSjBZWU1t?=
 =?utf-8?B?ZFc4d1FFb3Nvc1A4dGJueUxWQ0lDQmd1dmEwYUpNV2FIK1VPZExMRENHMStN?=
 =?utf-8?B?RHNvdGNlTVYzcEx2Q0xpa2JXbkFuM0F4cUE2d1IxeXV6Z0JPM3RpMkZWNVFH?=
 =?utf-8?B?Vnc3R0dCbTQ0RytnaGFlUVpxMG5WUDltUHpkazF6RE9JakZqWmk2WTVzaVp4?=
 =?utf-8?B?WWZpb3hJM0dNNm1KNlYvcldzbk5ZSWs5ZDE0TEQ2dUgwM0dtWmRmQVdacUxr?=
 =?utf-8?B?bEk3VFlQZ0pQSWNkSXdvNWlzY00zZ2NuQnFqdzR2OTN3YTRvdWxWTjBLNUk4?=
 =?utf-8?Q?SXAA1K1R6YBz5+t59mucpGzPa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed321a8-55e3-45ae-cd45-08dbaeaa284a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 07:23:24.8527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHX0egtnYmJFhQbTUwZWBUSjkbOVGM2BdOc/m+/VU29sErIREv3IDKqlh1GJe6YO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
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

Am 06.09.23 um 08:55 schrieb Ma Jun:
> [1] Remove the irq flags setting code since pci_alloc_irq_vectors()
> handles these flags.
> [2] Free the msi vectors in case of error.
>
> v2:
> - Remove local variable initializing code (Christian)
> - Use PCI_IRQ_ALL_TYPES (Alex)
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 45 ++++++++++++++-----------
>   1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index fa6d0adcec20..64c245015e17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -270,29 +270,29 @@ static void amdgpu_restore_msix(struct amdgpu_device *adev)
>    */
>   int amdgpu_irq_init(struct amdgpu_device *adev)
>   {
> -	int r = 0;
> -	unsigned int irq;
> +	int r;
> +	unsigned int irq, flags;

It's also good style to define variables like "r" and "i" last. Some 
upstream maintainers even require reverse xmas tree style defines (e.g. 
longest first, shortest last).

With that changed the patch is Acked-by: Christian König 
<christian.koenig@amd.com>

Regards,
Christian.

>   
>   	spin_lock_init(&adev->irq.lock);
>   
>   	/* Enable MSI if not disabled by module parameter */
>   	adev->irq.msi_enabled = false;
>   
> +	if (!amdgpu_msi_ok(adev))
> +		flags = PCI_IRQ_LEGACY;
> +	else
> +		flags = PCI_IRQ_ALL_TYPES;
> +
> +	/* we only need one vector */
> +	r = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> +	if (r < 0) {
> +		dev_err(adev->dev, "Failed to alloc msi vectors\n");
> +		return r;
> +	}
> +
>   	if (amdgpu_msi_ok(adev)) {
> -		int nvec = pci_msix_vec_count(adev->pdev);
> -		unsigned int flags;
> -
> -		if (nvec <= 0)
> -			flags = PCI_IRQ_MSI;
> -		else
> -			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -
> -		/* we only need one vector */
> -		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
> -		if (nvec > 0) {
> -			adev->irq.msi_enabled = true;
> -			dev_dbg(adev->dev, "using MSI/MSI-X.\n");
> -		}
> +		adev->irq.msi_enabled = true;
> +		dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>   	}
>   
>   	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
> @@ -302,22 +302,29 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>   	/* Use vector 0 for MSI-X. */
>   	r = pci_irq_vector(adev->pdev, 0);
>   	if (r < 0)
> -		return r;
> +		goto free_vectors;
>   	irq = r;
>   
>   	/* PCI devices require shared interrupts. */
>   	r = request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_drm(adev)->driver->name,
>   			adev_to_drm(adev));
>   	if (r)
> -		return r;
> +		goto free_vectors;
> +
>   	adev->irq.installed = true;
>   	adev->irq.irq = irq;
>   	adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
>   
>   	DRM_DEBUG("amdgpu: irq initialized.\n");
>   	return 0;
> -}
>   
> +free_vectors:
> +	if (adev->irq.msi_enabled)
> +		pci_free_irq_vectors(adev->pdev);
> +
> +	adev->irq.msi_enabled = false;
> +	return r;
> +}
>   
>   void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>   {

