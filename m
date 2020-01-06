Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C68C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8FE2072E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z6nNWI4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8FE2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BC689CD9;
	Mon,  6 Jan 2020 19:17:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C1889CD9
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 19:16:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3YBYugSei/RKwpjdEVeEm2qxu+p9DrZmGKH8QR/yPU5NA3I9f8GOj7sda5LXZ4TdtkWsyCM5mniRQv6XPzO4iKr7JP4LOcPz7QZqjhQgvF+AzcU7h2xFHO67ZgW1T43lVqP2KsmOiCFlM9G2Xk1MS4Geq8OEvrEqHDc6fIDFzJ5jazn4+y3AF9JSTKyPeXEaW9W9Sk83AkmrFgtlKVGKhF55Wym/my1SKyCPBW8k4Lg3/DoSgQk2ZH+dxazEQAmC7HO2wnHDPL1ON+Zl7F/KcUkU6Iz149kUSfdEQ5owxxX4vzKaWlGKA59Acf4fjjndMHZmBkBIT6P4eqlTZ7Qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kc3QVD3WgC+R0+dIhbgCpV0JPzcKE+lQuywmhi1AnM=;
 b=HVoms7kIv2/FhFXjlm0oxMHJh3sc2el90a+FbpvjhqWT06lE/0GeV+VwR99Y3ic6rJVSPNrGC+UDX3xBclYvo/Sf2XNljeEDB4g6i5JM1hi0KUzkNmmWN8Iby3F5N85BV0lKp0RB6Lvcosrl+e/Vk90p4nwTh7EV6IAJz9MLgXkRZCnnNMP0UWGtf5FBcOdSyO3UAjJmLkfegcC7Z4M3rnTIJdss76cv9+IGU/q09a0ROz1zae2DOLX0XqLsC9t25xFOkKiU/0QvrYmYOoe/F2UuvmdD023ORNLsL0uuT+EmH+wJO0LlLC4k71wjprpX5nTLdfp4VzhWGFdYyiYreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kc3QVD3WgC+R0+dIhbgCpV0JPzcKE+lQuywmhi1AnM=;
 b=Z6nNWI4bp303xN7U6LnoFwHijRzKFfDj+W9ggfh5uyRpdXDudhbEAYuSAgbk38A9WPPafTRg9km9gn0VbEbPoA9i7xWYVhxo0cb9Mijxx/55w7HAQ/IXnvABym35G60W86yKqqwwUzmXlWgJDAikmuQYijkdk5OBzxXrR6zLfQ4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0025.namprd12.prod.outlook.com (10.174.105.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Mon, 6 Jan 2020 19:16:57 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 19:16:57 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc: move invaliation bitmap setup to
 common code
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200106183506.692030-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5407de4e-4c87-4026-5c81-91a42d8ff700@amd.com>
Date: Mon, 6 Jan 2020 14:16:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200106183506.692030-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48)
 To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 19:16:57 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad5402c8-4508-441f-ab07-08d792dcffb3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0025:|DM5PR1201MB0025:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0025A9B66D73F85F095C72B7923C0@DM5PR1201MB0025.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(8676002)(6486002)(81166006)(81156014)(8936002)(2906002)(2616005)(66556008)(66946007)(956004)(5660300002)(66476007)(31686004)(16526019)(36756003)(16576012)(4326008)(316002)(36916002)(86362001)(31696002)(52116002)(44832011)(53546011)(26005)(186003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0025;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqmijJiIO4ZMyw8QiSVtlC6/K9wpHLWWoxwPPrMKOPFptpy807DXLrBntdzavcQeGJSLLWuEVbxw/MQhVOKQkpYNuTvBOZU5kzGaSWM/trCMPM1oiv2YOSV0c2ODR8lTMXCaEff+yYqBxLlTjPNIp/EDEnnaUKZnlO3CPvpp0s0syFmbAK25jDi0p+JjOzJcsUSAycHn4wQHAWHb0Q7l/NsLKl930SH0oD+hQDtSqqO8j5CaQxMei6uu3MCEPKYPuViQjM2na68OYpyHvDVfGH17kZmiWyf+5P6Vj4yKHvql9OckaWFMWn1Y7x5Hbc25MZhUTbLN4y7EmC/2BXAm1V9T1MdesGQi/jRVJ5jK7+/e0POuR3BUiFVHaVCCKLvx19T5tID3Fle7/HDHIQbVu5SMRI/AzUQQRZV2n3QG5eQIhvvFvkQqz7y5QYaqnFfZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5402c8-4508-441f-ab07-08d792dcffb3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 19:16:57.8159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8sHBIK0glRn0XgDvqTfDuKtSYBmR686W9t0ZW/d9bFQPuld90SO87UgswGCeQvEUtNBgPk5Ui4FZuGBAua87nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0025
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-06 1:35 p.m., Alex Deucher wrote:
> So it can be shared with newer GMC versions.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 40 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 32 +-------------------
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h   | 10 -------
>   4 files changed, 42 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index bbcd11ac5bbb..d6901b274790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -333,3 +333,43 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
>   	amdgpu_mmhub_ras_fini(adev);
>   	amdgpu_xgmi_ras_fini(adev);
>   }
> +
> +	/*
> +	 * The latest engine allocation on gfx9 is:
> +	 * Engine 2, 3: firmware
> +	 * Engine 0, 1, 4~16: amdgpu ring,
> +	 *                    subject to change when ring number changes
> +	 * Engine 17: Gart flushes
> +	 */
> +#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
> +#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
> +
> +int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *ring;
> +	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
> +		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP,
> +		GFXHUB_FREE_VM_INV_ENGS_BITMAP};
> +	unsigned i;
> +	unsigned vmhub, inv_eng;
> +
> +	for (i = 0; i < adev->num_rings; ++i) {
> +		ring = adev->rings[i];
> +		vmhub = ring->funcs->vmhub;
> +
> +		inv_eng = ffs(vm_inv_engs[vmhub]);
> +		if (!inv_eng) {
> +			dev_err(adev->dev, "no VM inv eng for ring %s\n",
> +				ring->name);
> +			return -EINVAL;
> +		}
> +
> +		ring->vm_inv_eng = inv_eng - 1;
> +		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> +
> +		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
> +			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index b499a3de8bb6..c91dd602d5f1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -267,5 +267,6 @@ bool amdgpu_gmc_filter_faults(struct amdgpu_device *adev, uint64_t addr,
>   			      uint16_t pasid, uint64_t timestamp);
>   int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>   void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
> +int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 68f9a1fa6dc1..e3bbeab28152 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -795,36 +795,6 @@ static bool gmc_v9_0_keep_stolen_memory(struct amdgpu_device *adev)
>   	}
>   }
>   
> -static int gmc_v9_0_allocate_vm_inv_eng(struct amdgpu_device *adev)
> -{
> -	struct amdgpu_ring *ring;
> -	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
> -		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP,
> -		GFXHUB_FREE_VM_INV_ENGS_BITMAP};
> -	unsigned i;
> -	unsigned vmhub, inv_eng;
> -
> -	for (i = 0; i < adev->num_rings; ++i) {
> -		ring = adev->rings[i];
> -		vmhub = ring->funcs->vmhub;
> -
> -		inv_eng = ffs(vm_inv_engs[vmhub]);
> -		if (!inv_eng) {
> -			dev_err(adev->dev, "no VM inv eng for ring %s\n",
> -				ring->name);
> -			return -EINVAL;
> -		}
> -
> -		ring->vm_inv_eng = inv_eng - 1;
> -		vm_inv_engs[vmhub] &= ~(1 << ring->vm_inv_eng);
> -
> -		dev_info(adev->dev, "ring %s uses VM inv eng %u on hub %u\n",
> -			 ring->name, ring->vm_inv_eng, ring->funcs->vmhub);
> -	}
> -
> -	return 0;
> -}
> -
>   static int gmc_v9_0_late_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -833,7 +803,7 @@ static int gmc_v9_0_late_init(void *handle)
>   	if (!gmc_v9_0_keep_stolen_memory(adev))
>   		amdgpu_bo_late_init(adev);
>   
> -	r = gmc_v9_0_allocate_vm_inv_eng(adev);
> +	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
>   	if (r)
>   		return r;
>   	/* Check if ecc is available */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
> index 49e8be761214..e0585e8c6c1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
> @@ -24,16 +24,6 @@
>   #ifndef __GMC_V9_0_H__
>   #define __GMC_V9_0_H__
>   
> -	/*
> -	 * The latest engine allocation on gfx9 is:
> -	 * Engine 2, 3: firmware
> -	 * Engine 0, 1, 4~16: amdgpu ring,
> -	 *                    subject to change when ring number changes
> -	 * Engine 17: Gart flushes
> -	 */
> -#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
> -#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
> -
>   extern const struct amd_ip_funcs gmc_v9_0_ip_funcs;
>   extern const struct amdgpu_ip_block_version gmc_v9_0_ip_block;
>   #endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
