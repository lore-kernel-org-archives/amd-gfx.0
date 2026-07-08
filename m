Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58B8C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 09:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 574A010E5AA;
	Wed,  8 Jul 2026 09:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m4vGlB2o";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D94110E5AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 09:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCKHL50tdCn+XPevX/XTTmw+Jqenc+kJtL9XO79miuZs/IZop1ZU8l69AasdvFvJecv4dGFg2I0j/qHFd06UnF1/ElOL0mm99NJ0z7OG3QImpPwROukespnY67O3lKoNZAZSOWFD7gwhB9axhMN1qV6YE49Hd9hLf7NuhIJDWUSZE7UJQIteCDOMFXUs+dsNcHJ2JED38O0hscAw8lYrlv1nMG573AVOdOvu4lTKBtw95ik07NDTT0R7y8b6xmxMRJ0C7lloiA591CsRqMd/GqKvsKfaXl0mYcs3+dr6JDLaNMLj0w9AmeOiyf0HBTbbS0Q54mP9xxNMCXaZRiYDFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UM4Tq5Tb4T4c1QX/fUXXpNCQw1lA8Gd0w20zOeTuCQ=;
 b=wrTcMkf41Ma1bIf4puSQVvTJSyOswGcKs5aeldKrJ4LEI49xMQdGL19GCjW9OPt6Qc71mX5dc/OvKhU66K2g9yTRjW0qzNIYse8c++Bee9JxQa3E0/v8AP5b6Ud48vFAXxb5ejhFw0KXh+Q61xX3ACIt9ECUnoIWz3+tfiCo7TwydbymO6x7uucOePwWMKzILs54HupJk6MPzdsdrFyJ3/rpxgvp7N7miV8Oju9Cjdy45cVD6v6cRWmJZR/yVOJTSTfiQiUSorLsq7yhO1dB2/lUPpSRyxdxiU9hNxUgHoyCZbiYw7xleS9g6YP70HiBAA1kPgfgR6PqPTh+EN0Chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UM4Tq5Tb4T4c1QX/fUXXpNCQw1lA8Gd0w20zOeTuCQ=;
 b=m4vGlB2oECdjy/VBS8bN/6I/1GWgnf436pQxefBjaqhyCaMrNJy2WczUDSRhJZwOZMOg+bmo7bDg1tAS5f8WZUHNSUT9lx3Kg/Sa7gtAJgDAN/LBNlDCzg3wYqkRhExBlIzZCpl5gHOO56lD/R5zhq/RH1gRQWoL/bHhz0Qxc4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 09:05:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 09:05:20 +0000
Message-ID: <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
Date: Wed, 8 Jul 2026 11:05:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Emily.Deng@amd.com, HaiJun.Chang@amd.com, Victor.Skvortsov@amd.com,
 Lijo.Lazar@amd.com, Cursor <cursoragent@cursor.com>
References: <20260708083035.186400-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260708083035.186400-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:408:ff::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 483c831f-cda1-43fa-210e-08dedcd00906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y+u/ZfzRGeFq0qh8BfgIosf6AopJzljjLh5qfUuvtXAroI10spHtcp6GIMFtkyjbdesEFynF0QRmkHHArULmwz1SeH7EAgpWICGigSZeBgtNuFU4Zd56q/QT9cpvywhWpKfjOjBvR3dL51k2KhB5oTeOmLQDAZ6B2Tx6PMakpmMo0BPU9KYLhf3LDzxp1tkSOvCUbdY3two1/L5r01ozbr1Y9mVD8FxtrUhyuZajvEXIfE06JgvNb0BxYjlWAjpvt4wiNd9bz1XqbG35wdGJUOmF2Vpd9Xg/y0hlgJldJ9v36RempFdV8Ixa2KvrYpNyrGV8JZreIua5gHZzgoUApC58Ppr+Gv1ycERUFdKwh9XImWJSuDQaST5jdEMbU38sOAD6+tE58xeOMZNRYDXh6a9oR9nZ8Y0xhhrwjxd7gR614cNcMbSoR+QR4AIY/vAjSbsV31E4s4FFYQBQ6mqqGNM1O+3+KBFCpl+O6ROKRM7AnhtwxfZh701FuuGMIfXntyjhAZyhWs1PeZFv6QAWV52e700rOvg6nQmCY+D8X/AdehYqvv3ABg1sbCOUkn+aDyHaynP71DbxrugZH7/jr1zSXzzXWiCqeF8OsPQEu532t/UnNIIQoyQ6UIkP4Nog1ATs5/PSpEghafwoqgWm1x96WJdYGotU+rLZpekzJhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnA1N0hKZWg2OHAwQUtDOTVISitMQzBxMnNLbjBUNHRzQ1RrZktUVzhvcG5O?=
 =?utf-8?B?K0lqWkdaK3FRc0xmQWp2K1NFMmVsVFF2NnBjU0l4dldjRGF5TWxTYVhaQmll?=
 =?utf-8?B?UFNWRnpDSXZ4cDBMa3JkVHFVemFqMDZwSkpoWXR6dVpTOHU1NU1HSHZ5T2Vm?=
 =?utf-8?B?eWsrYmY2SWpWVW5Oc0FRbmxZUEtnWlVDK20raDhOV3ZLVWRlM1BVY1RhRThq?=
 =?utf-8?B?Y1dRMDFCNzUwMGx0RldQS3Bhb1Aweng2T1RqbmxHMUovdWVLZmY2Z0dRaDVY?=
 =?utf-8?B?VmUrTUdydnV3ekEvVTJ1ODBicUJGQit5WlVKOWw1RCtFSFRYN2tKa1lZRU9r?=
 =?utf-8?B?WTBYN05HTjhqRVRjZGhYK3JLVmFSQXp4Y1ZNVnhhYlkrZWpqY2FHTE9VVHNi?=
 =?utf-8?B?WmFhODlza0tnY1lGRWFGTnZqc2cwTzdsWTYyVDByZHVHRm1HdDFZZnBqV255?=
 =?utf-8?B?ZmlUc0tFQWQ3eXZCUUo4YVFxTVZsSWpCZDdESGwzSnVnOFpQbG9EUWVydlg1?=
 =?utf-8?B?bFgzY3JuR2NzaDVlQ1djNDMzYlBVTnUzN3ArdkJnQUpsNTFwM2tVMlVFT1Ur?=
 =?utf-8?B?aVN4WDJzMlpqaE41MGtjbGZaRlA0Vktyckc0b3Rqd3k4bEVtQ2RKNWw2WVhI?=
 =?utf-8?B?OWdGamhVakFhL2pMM3hMY1hMbUk4MnZxYi9CLzBHb3ZPY21Ld3RuL1RleFZj?=
 =?utf-8?B?YW51RHpTYXNXRzVqWS8raXQ5ZERhR0Y0ZDVZTHorN3hNL1ZodUIvcjk0eGkw?=
 =?utf-8?B?VEhqWjZTY3JzTVF4REZHNjZOZCt3bXZuQTU1UjRpWW1lTm95WE0rSUlaeHJo?=
 =?utf-8?B?ak1ya2xOWE14TmRGTjVxM1l4UVZJWUVVSFZUMFl1UlNRZ2tIMTRtWXVHdTBn?=
 =?utf-8?B?MWI3d0ZXMGxvcHVUREtWbG15MWhzbDdxZzBJZGMyNjg1NGVyVlVMaDNJQ09V?=
 =?utf-8?B?cE1IRkc2NGdPdDF1YjZUd2h6Y2xRVXp4QkM4dWZXSkRITVBmaGRYQXRWb1lz?=
 =?utf-8?B?T0o2MDZFYzU5dzJuWTNtVEhVVjNmU0hnN1BsK3VqdGYvUDJpMU4xNE9JdG91?=
 =?utf-8?B?OXE0cE1haThLRnp0anhiVDk1cnlyUWVQT0JuMFkwUkh6WDhKL3N4VHVJU0Zw?=
 =?utf-8?B?UTg3aTJyNXhxcDFjbXRhektRQzJPN004ZTZEdnRVK2N6bVRRVnBndVJoQ2Fu?=
 =?utf-8?B?dm1WM2lmWlRydmM2MGE5T2V2QWlBTzREc09hWHhWcTlYNVRoWXJ5YVVINGpr?=
 =?utf-8?B?NUN1bTRQbDh3b08xOHBKem1IS3dxSjNBZkdOZGF1NXRNT0NMVkZHbitQVGlj?=
 =?utf-8?B?cW80bHRabkJiemN3Rk5sR2hFOVhqMDlyNGhhYndHS2xYQUgveWhROW5lYnJy?=
 =?utf-8?B?clRGWnc3RVpSN2NtWi9wTDRRWGxtY2tBeGxWTVB2eFhnUTNEem5sb0MxVzRl?=
 =?utf-8?B?Z09ZSHdOR2VCMVVNdVFUN1JNMEV5elRSOEJkVEgvSEtJdlc5QnZqc0N5ZjNC?=
 =?utf-8?B?elpFV1c3Um16QnhlTGF5c2J5OUpxU1JTVG9ZUVlkQk96eWc1QnRGWDZZVHJi?=
 =?utf-8?B?VDZSdTYyb2p0VFNqblI5RWJWZHZiOWVqUWRnRnFWRHZ2SHdiWHY5bHFFV2s1?=
 =?utf-8?B?aDZKc3p6ZlMrcmI4K21hOStNenMyRlN5ck83WUkxZ0VHY3ZLeHQxWHUrWTVi?=
 =?utf-8?B?SzhVOEpMOUVlL2U3Yy9MMmVNQXdnWTZmVHE5a2xBTW00emF0L1BDRXlFaEx1?=
 =?utf-8?B?cW95RW1rU1g5eldxY1N2ak9GWGdMUVpUY1hraGFJckwzdUpORXNrRG1iMnBq?=
 =?utf-8?B?YW55aW5XK3ROcjlZRFNvT3hqdUJIdDZpWU1MSVJoOHNWSGZnMlh4WERHTTU2?=
 =?utf-8?B?cVZxOEpTUFU4RFR3NlpxZ3N1V2dxRFRHVVBQandFN1l0V0N2alI4YUp3Q0pV?=
 =?utf-8?B?SXN0SWg2OWZBUmhJalFqMWliNm9TbDNERTdwYlNYcVhodm51SnV5QlR2MnJD?=
 =?utf-8?B?alNIdUZYcFQzdloxZTVoQVJUZVRSbVg1VzlMaDFvVmZaekZqLzV1aGVDUGRw?=
 =?utf-8?B?c2syaWM3WEhMMVQzd2dsL3I0dllDZ0NFQnQ4WTJXVWdBL2dYeVZ6L25uVDdo?=
 =?utf-8?B?TkthSXB4bSsxdUxrNGV3Wis1bE9NVHdPMy81SVBTVTRMMHQrdVVSWVNZL2NJ?=
 =?utf-8?B?ckFHclpnNXNweUtCdnptREd2UHlDVUp2NWNUVmM1aVkraGVwZS9hMnlnYXIv?=
 =?utf-8?B?aHlXYWY0WlZDWXJwS2FNak9UdE1aQ1l6K01xVTBtekNKR1lZR1kxaHpqbTha?=
 =?utf-8?Q?QQD1BJljLb4nF96gXS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483c831f-cda1-43fa-210e-08dedcd00906
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:05:19.9235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKTQ5+N1W2Jsf1HOnO5XctvNZAnaxMyLc1hEqvRQjjxIyxNAtXyCYmLaBDStKbrh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875
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

On 7/8/26 10:25, chong li wrote:
> v2:
> Some legacy ASICs do not send amdgpu_virt_request_init_data().
> Only keep the full GPU access request early when request_init_data is not sent.
> 
> v1:
> Move the initialization of non-GPU resources out of the full GPU access
> region during AMDGPU device initialization.
> 
> Background:
> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables VF_FB_EN
> and places early initialization data, such as IP discovery, VBIOS, and
> PF-VF exchange data, in the VF FB. The guest should then be able to read
> this data before requesting full GPU access.
> 
> Before this patch, the VF still requested full GPU access in
> amdgpu_device_ip_early_init(). At that point TTM is not initialized yet, so
> the normal VRAM aperture mapping is unavailable and the guest falls back to
> MM_INDEX/MM_DATA register access. That register path requires full GPU
> access.
> 
> Use the BAR0 framebuffer read path, amdgpu_device_read_fb_via_bar0(), for
> the early init-data copy instead of MM_INDEX/MM_DATA. This lets the driver
> delay the full GPU access request until after the early init data has been
> copied.

That looks like it goes into the right direction, but as far as I can see it is still an ESXi specific change.

So once more: We can't adjust the driver to the hypervisor!

Either this works on all hypervisors or I have to reject the change.

Regards,
Christian.

> 
> Signed-off-by: chong li <chongli2@amd.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 610d82b79de3..ac66796e8634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -38,6 +38,10 @@
>  #include <linux/apple-gmux.h>
>  #include <linux/nospec.h>
>  
> +#ifdef CONFIG_X86
> +#include <asm/hypervisor.h>
> +#endif
> +
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_client_event.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -1987,16 +1991,19 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_ip_block *ip_block;
>  	struct pci_dev *parent;
> -	bool total, skip_bios;
> +	bool total, skip_bios, early_full_gpu_access = false;
>  	uint32_t bios_flags;
>  	int i, r;
>  
>  	amdgpu_device_enable_virtual_display(adev);
>  
>  	if (amdgpu_sriov_vf(adev)) {
> -		r = amdgpu_virt_request_full_gpu(adev, true);
> -		if (r)
> -			return r;
> +		early_full_gpu_access = (adev->virt.req_init_data_ver == 0);
> +		if (early_full_gpu_access) {
> +			r = amdgpu_virt_request_full_gpu(adev, true);
> +			if (r)
> +				return r;
> +		}
>  
>  		r = amdgpu_virt_init_critical_region(adev);
>  		if (r)
> @@ -2159,6 +2166,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  	if (!total)
>  		return -ENODEV;
>  
> +	if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
> +		r = amdgpu_virt_request_full_gpu(adev, true);
> +		if (r)
> +			return r;
> +	}
> +
>  	if (adev->gmc.xgmi.supported)
>  		amdgpu_xgmi_early_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 9a40107a0869..340703d89d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu_device *adev,
>  	} else if (req == IDH_REQ_GPU_INIT_DATA){
>  		/* Dummy REQ_GPU_INIT_DATA handling */
>  		r = xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
> -		/* version set to 0 since dummy */
> -		adev->virt.req_init_data_ver = 0;	
> +		/* Version is set to 1 since GPU_CRIT_REGION_V1 */
> +		adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
>  	}
>  
>  	return 0;

