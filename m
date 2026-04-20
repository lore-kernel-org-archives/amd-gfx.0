Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458AFF588C2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E601910E57A;
	Mon, 20 Apr 2026 12:23:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXkdQTCE";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9856D10E57A
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:23:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uw8z9jWmdbRK16pyGGRsmxO/eagELsZd1lhe7+VHTqdbgZTw5c5R5GOnmAdcVC1ne00p3zj3MTE9ZTgm/BVsWMAUZra+R8oMaThXdRVGhPomvA51WbSWHfnSDV3o8BJdVDuPhUfODYzhraJDDthTsrKHtldr7c+yOzlKLN1n4+R0c1iCBCwQ7qw5VIcXTc6DdetDcQTO/USFs3YYweDPI6x3WWjcAZegab5CzwxNMSfUpXuV/yXHsO9JENNAnAw0AG+KLLXxkNaqmOytd5qcX27X9cI/0sMfqLD+DhC3ctlNBznnvmPSLVDOV4GzxhBekQCxIqW6LTeaa8CDOYOANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt3MJjVm2Zqq/0IfNc3g+eFOaOeUzPTt0KOwztsimuQ=;
 b=qsSGV4Fff/ogD8XgLLgWkOCW3Po8REFPURPTL68FjFADwfctt7YI92VOD7t0PU+s/BfhikKDmIPuMo9Wtfh3GQV5dMnCu3UnQTpQXfKzlDlYHs1qPMWhTNldUqnMyb9bBIKy/HCk9Q+df4x5rJYm3NqU9MnzfopM3jPFjp7HJgHM0sL1/1+TJ2dOLFzdiasXfaOeltQ0aB+e0BT1Y4pqlP3N2nuwgw3E6zHkrOd6PaalAz/6zFBO7xhARyUt2x4VrcAMfeR5cGQ5ArXmV2l+2TmcP5UhtcowCH53779hToe+fvMHFbRGVNZ+6QHrV3Z/3U6Tik24ydxt7A9Gmvjwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt3MJjVm2Zqq/0IfNc3g+eFOaOeUzPTt0KOwztsimuQ=;
 b=pXkdQTCEZrUsvBkaVH3Ab480lkK9ykaqMXU6g0v/XBRam9GR5Rr2d+19NNxpXBd232OmzE+6wWcuBnTzJ0Zt+BDxgP3+UsT1ziH0Y4VaIYOJNce4W9RYQAaRp7UU/Ucx89rDz+jTFIMWYi7g2T9VZQLDOwtWevpJAd1zZUrrBhY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Mon, 20 Apr
 2026 12:23:24 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 12:23:24 +0000
Message-ID: <14b58bb8-e1bf-4b9d-9957-dbdc32144278@amd.com>
Date: Mon, 20 Apr 2026 14:23:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/amdgpu/vce1: Correct firmware offset mask
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20260420121044.155030-1-timur.kristof@gmail.com>
 <20260420121044.155030-4-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260420121044.155030-4-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f76039b-f8e9-44ea-6d43-08de9ed79e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 8Aq6YiHDAuSegerC6yC2MT5gEpnW+FvO7g3hSmKenQHpPkaiiCH6H0yB8NOgv7CAHd3S+90CSD5esZuQAgZdFigoVNyBxhij1BpjyKyj4MyUHaJnblJs78cskFXNWW2U6pDePOc2Al9s0iSClGg5/y2Me7m6RJZylOcMQjQM0cOFUTnrRpi1Eyv3gEpjUlGre7QGjfoxtO3SxslSKFWxTmtbmYiWW274mxkT0tmYnc+ZV/Ynoa2R+S5invKzD7aQ7TjhNw6EckhcsnaOsXI4f0Qo9CCa5Bw9WNr/9BeTezipt6CTC1XX8p7J9Pv9KcwJpNbUIyXZp/dQkrLauvLrSBhoTI6xx0UU7PYMy+veOGKSZ0XFyJe6wWIK8/M2dC1Y3CojXq77VKpwwYS23XWUTzb2Y8/MAwci+6wUev2oQz0F6k1LuiWS9ehV1T8EQPrIHo2Pk8Jszs9797LuoOYojnNFfn69YIVZHdovpIatBKaunmZR6ggJbtN3p8FrZaPIfgXv0wUrAeF2m3ABAKT5onaGRPETs86NuQ5TJ8u82/jJ27RVJkW4z6UT5IOkCpUBRxUfeAQDazKJsF4MpvUZyeyq8E9FlU9/y1d+IINu6KnvKvb3EmoL9vzRNZjSmr99JF81Y4YePnu8D8R9xTCisGH3M8iRQ0rupC/vk19jCAT7SCPiEYcS4kSC8nfAfFaqRzlsuz7QKDdbpFxlb+T1w3a/3iJwamL1sMERq5Kkx7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmFGcVNFRGVhUmpRNFJRb1Q4VEdsOU1zSFhjdFcxcVA2cW51clB2alJ2UWhM?=
 =?utf-8?B?cWZZTmNDblUvYnVxVi9jay9IT2RZcVdiSFMyNU9EVEJKZ0M5VGtDZGErRFlZ?=
 =?utf-8?B?L0dEakhVeEpKWEVhcmR4K0w3K242eG9aSmttNDVyekJYZU0yeCtuUnJyUER3?=
 =?utf-8?B?MjcrZVludU8vLzNXejd3d2FUR1QrYnpoMnZJOFNsVmhxK0wvdVdKUnMxWDlN?=
 =?utf-8?B?Rk5CclJpUzlMTFNQVG9RS0Z0ZVFkVHc5bTJzajlKcTI5TWRTU1BxTVNHKzJw?=
 =?utf-8?B?dWloUDhoSERESW5ZRVVkMFAwKzYwT2tpZGdaTUFEaGFEZUh5RkxITjFwaXM1?=
 =?utf-8?B?YlpUczU4SDJVdSs1QTcyenVqUXFVam5kN2NKQkNURVliWWNvbFFSNm9jdVFD?=
 =?utf-8?B?QnluMk9mZWpUVGNXTVF3NHBWbzFySkx4MHl6SjNxRm4vUUNMRnhVQjcvQkNz?=
 =?utf-8?B?VlRSQkplakY5clVvWTFlRXNqakM3dGk0L3ZyeURUNCtjUXd4LytRWHB1alc4?=
 =?utf-8?B?UlRaRVJmT2hiK0NxQUZNamVqbit1Zitid1hrRkd1ZjZJcGNrNkVEN2ZEdmo3?=
 =?utf-8?B?WW1vZVhja0tXSVZ1OGUyRFMrN1dtenV2MjFnWEwyT1VzbmFpSVc1ZjlRL3F3?=
 =?utf-8?B?OWp5ekcyY0djelJsMDZVdDlUZXNnYmpjWFFBZ0xOU3NLOHk0S1VtVXFzZW5S?=
 =?utf-8?B?ZmY5cDNiYXR2eXZUVko5STllSHp0WTB2eTJ1dmxJUDFXNUd6dTh1V3BXdFNI?=
 =?utf-8?B?WTI0WFZySW00NVFZVkJxRVJzWGhFNjRlK0ZieWxIWHkxWlM0eWE4cjAwOFgz?=
 =?utf-8?B?V1EvMjRJb1YvRDVRK2hBQndUS3l6dFZQS3NGVm1VSVZodXpXQzFLbE0zcGJz?=
 =?utf-8?B?cUFvc3lYTENEZjlabCtiVXNBdmdDUGFqVzNZWDgzU3ZSb21ZaGxFT2p5Tmlv?=
 =?utf-8?B?VEZGV3V2MjBmSlI4YlIxNnNwUkY1SUtkUjU5N21VK3U5cVZqU3lIOEU4V2Rz?=
 =?utf-8?B?R2FxMWlHbnl1L21oMnZoQTQydU9NMnpMVXI5blF4ODFUbWV0d1hNK2l5SkIw?=
 =?utf-8?B?cHZCRGhXeEFqNjFaanJ5aUlrMU5TK3M3cUZwRXFQUURUVE8rdTViNFZ6ejI1?=
 =?utf-8?B?cU5na0g0SEtoTnk0M3NvS09xNzBycWlsZW1yT2taa2RRMlpRYW50TCtPQVpv?=
 =?utf-8?B?RHNrdHQvV1p6ZDFOeGpEMDZ6bW5pNm1UM1oyaHpMVGFYSEZTMlRlV09rR0tX?=
 =?utf-8?B?QUxZWnhwb0wvRkZrNXc5YkxRL0pqa2NSNFZWQzVwdDZXdVZNb2Z4UTluS3dB?=
 =?utf-8?B?MjJmTi9BQllLMTU3VjZQdmxRd2F4ajBONTBZamM5eHZweCtlNGkvaXZZdGJC?=
 =?utf-8?B?UGxmUGQ2dksySS9JL1MrM2hwMDRpbFUvK0M5anJ5aHlJbzdPKy82WnUrMHgx?=
 =?utf-8?B?OTJMVlBBeXJVZ3RGUkJSVmdOOTFUT2JPenJVTXFzdE13cG5VbEF1R25HQ3dP?=
 =?utf-8?B?OGp4R0Q2UTNSVWkrdDM4aWlxeGVjckdSZ2MrV1JhZXNxMkNNQ1pheml0T0xy?=
 =?utf-8?B?MmR1ODdUU2JBY3dMYkpsQTh4cmZUVzh4Q0d4Zm1acXdOWWlBOUc4ZWt2NFEx?=
 =?utf-8?B?aUtYYWZqT1BTa0h4LzBOZHI4U2ZSVU9walN6d3MwUmQ1akRCQ2lsSjQyaUsr?=
 =?utf-8?B?QVlqZ1k0ZXpjTmUvRUFGTGNMdUR1bmw2OG1hYmtkeG5mOU9pODlTNHRidWtF?=
 =?utf-8?B?QmJCVkt1NWFqOEhsWW8vQm5JNXFXNjNLWnJncjdsSFYxVUU4amlkSnFwWlJo?=
 =?utf-8?B?ek43T1hRWFNVWjYzblF5cFVTWG9HZyt4SGhnUnYxQVA0MzA3SWswcGN0QXVQ?=
 =?utf-8?B?c2pIaSs4WVJXQ21lR1dkQ090VlAxMFhXTmxKK013aFBQWGZkTWRZSmxHNjdv?=
 =?utf-8?B?N1hiVzFLWEVlRktDaEFlb0daMkhVYnhrRkhTMDdic0NJSkdwRzhZMTI4VzN2?=
 =?utf-8?B?YmpWekNzL1BGT3BaWHVGeXBPSTd3MUhYMGJHb09tS1NaaGo0WmtpbG5YR0Vv?=
 =?utf-8?B?K1BTNHFLaW02ODI3TlBOc1JzNTRDSVVXYkRSaVFTWXp6NUswUHZVZytHVzND?=
 =?utf-8?B?cFZZbVNPRW1iSnd6akhHdjdUcnpMbGYyNHgvekEzWURRc1pDQVc2eWxtZnJo?=
 =?utf-8?B?d1loNkl0SWI4bFMyVUtYc2s0RXBKenlOeEllVmVRQkpCYlRmZ2YxOFdEMzlY?=
 =?utf-8?B?OGJGcmtaSUlyZ0swejRiT0VhQU9KT0dNZU1ySFFUWHBETWU0QUZJc3BPUW5w?=
 =?utf-8?Q?V0g3clY2Chq19TiD5/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f76039b-f8e9-44ea-6d43-08de9ed79e04
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 12:23:24.0391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmeJDVgpgssKAXEYAVyoTAn+upVB27LZzNOkyVo49caBvX+Wc1T/8j3oa/xJNosq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781
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

On 4/20/26 14:10, Timur Kristóf wrote:
> It's 0x0fffffff and not 0x7fffffff.
> 
> Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 2fe931366985a..ce993b57b0e9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -313,17 +313,17 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
>  
>  	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
>  	size = VCE_V1_0_FW_SIZE;
> -	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x0fffffff);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
>  
>  	offset += size;
>  	size = VCE_V1_0_STACK_SIZE;
> -	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x0fffffff);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
>  
>  	offset += size;
>  	size = VCE_V1_0_DATA_SIZE;
> -	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x0fffffff);

We actually have that as VCE_VCPU_CACHE_OFFSET*__OFFSET_MASK in the headers, would probably be a good idea to use that one instead.

Additional to that limiting the value actually doesn't make much sense, that just hides the problem when we really get an offset which is to large.

We should probably rather have a WARN_ON(offset & ~VCE_VCPU_CACHE_OFFSET2__OFFSET_MASK) directly above the register write.

Apart from that the patch looks good to me.

Regards,
Christian.

>  	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
>  
>  	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> @@ -531,7 +531,7 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
>  static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
>  {
>  	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
> -	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
> +	u64 max_vcpu_bo_addr = 0x0fffffff - bo_size;
>  	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
>  	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
>  	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;

