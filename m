Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4BBCA5FA1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 05:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B213910E4DE;
	Tue, 29 Sep 2026 05:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GsrFF2sQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04CC10E4DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 05:23:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWFfs5NR4oeMjdmVSDurf9ywrha3mwSVi9rrzWXmP1URRZNT3I8AdoyW5DpaYpNiCCthsBR7FMYkcY/VaDuRmWyYq2H10lwn5hYNr/8TW96tKlvXa3VmzpTwR7ZaL6WxoAzilCNqTzAROwZbcRqYR7dZYGXCo/wOto8TbO2sPIAEC/qxxfBFupEZiRJKy3fhFHjOePRGvp+mJNn3sKwXReAlomVBoR5T5IGg7igmILhVnYAXlyV3sACyM62iEpR6HZPyvUAeX29G6lCwJD0pV1uTqd696yrNrsBOb03pzXHd5OGFu9rnvXB3QL1ZivDLpOmUESjJF3aarlBRY/uOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/q1A1ecd1pSSH8zFYm7+C8j7XmirWhI7aY9VKgE/vU=;
 b=kOxLnygLaxCxbyUWhqOj4gJEjGd3/I23MCSgylmCvpNquaq1c4IHUtEbu7kAfHJE9tSJUpZVsspBYlRfJuZtc5HWHFYMklyDZAsTZVvL4e2GVW++Lg+Ia9tpXLZgNdqEc20Ak7BOzWGyPs2aBrtfhA3AAlZw33Zdrb8w7j0nU8ixTW3PMOwMikknyy1to1GADU2BRAva9PhEOPBovHPNYdb/t2azsuNHGocD8i6Ng5dUg/KfiL9iqrh6q1J9EyZAZM057t7N2IuMYWLAyBxBrouI0D8cjE2d2mvx/N2f7wqsxpF3lbl71fg2H/s5Mqm6CwbOf3k1XNAMbUX1zpjRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/q1A1ecd1pSSH8zFYm7+C8j7XmirWhI7aY9VKgE/vU=;
 b=GsrFF2sQOPutarHmG7uGdLs8rgBusi8V86XzGPVscyQpFkn/F6sH/WYHxiPem+NST/hgpcdZS09IiLhOucx3a9KdrAFtUmVvEJwy7Rw0fdvA1MBo3s4Zyh68SKnI9rklOJXEraTKfsUGYZNVcKutQ4JuwLxRyM/fyGjTh/AADEk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 05:23:06 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 05:23:05 +0000
Message-ID: <dddb6124-51e3-4ed1-a845-9f4501198ca7@amd.com>
Date: Tue, 29 Sep 2026 10:52:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix VFI XCC addressing for gmc v12_1 VM
 invalidation
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com,
 Jane Jian <Jane.Jian@amd.com>
References: <20260924070139.2150654-1-YuBiao.Wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260924070139.2150654-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e91e41-7b56-41ca-0a68-08df1de9bd6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JeobWMzo5ReH/MAraEnFUBsjf62HmQwV5rdv6lRLgpzrxgZc6aXuTkP8ZTDYap5erf1JVT3/6f4Vm9SXtxC/gA/O8HU4zrSqQ8V1DhSUKszp4fOHEYdDZ5mKQD9uKeLBUcAHm4XUUR1hmYVBxNZ8dWFDvktKECTUqk0TP2suOG6vXOXcmf+W8YtET07ZnpRS8GBUuqfAmLp+hmFG9RUFKwNLmgMI++7e/6aa0gKNiLqX6zBAT+CtZn0uyzqPcOwdYIpKVi7oM0f0IJra65YCurze1iDGzI1cFXa3xBd/ew6x7xyaQHwmm8o7KUvvMfoERmsSOrvGjXBLRfdwz/ygewxmUdPOwq0aIerRDKQvDu9K2pp40WGNs+93WPWE2bZluy9aYzeDtqelNDoPj3UlwbuElf0Fw6nh3PpumOIHPBmXnzSVT2KssnlU0F/rqaLKnnv+qk8e4EA95ofyVyrojiOaIE6+g4gQ7jbWgBKH0nSPgoqNNJ6eK6h7CHIFqssG3g8yAeGi+A+YWtS6X85Y9yrrWBTTm3OgTYRce5FCDgDjHRPTMyk7EzQepQacIcCqekD30l3Xkc5ue+TlYtqzYyFRlaAdfYuAW2xwV64sltJSmTYa2DKakTob6P5joDzEay2/gc88+e7YsmxVktsK+oCgRMU1J/HMhjRgVAViSVg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a25YS0YwbWp6VjNWaFdvcVJmR1ZqVis3UFJBN0ZzRU9UaENmZVN3MGM0UzdT?=
 =?utf-8?B?ek5xWlF4bDNqSXNCT01OTHNjSE5Ic3QydzN5by90cjJ4ZEY5U1pjQ3pPNFlL?=
 =?utf-8?B?bXlqc1QwVGNnRjBVOHN4N055aHluWlp3NUhvSHpENkJVbS9jVHhodkFsWVhV?=
 =?utf-8?B?MXYzcDcySmVic1k4bDJXcUMvNDJzYjFzbFI2RjFlRXNiRW45MzFZaDJpZjhV?=
 =?utf-8?B?NUJHYk5MMDU1RHBHTFRYUk85dDBOTHVFUDFOaml6S0IwSjNzcEhLZW12SXVm?=
 =?utf-8?B?ZEpRNWEwYXhoMnN2MUpLbjZ0eFQrN0Jmb1ZLTzB1RmVCNytkd1B3b2RPc3pK?=
 =?utf-8?B?WGFnU1JiSHhXMTM3YUNzbEdyNy9IUFZwOWZiZFQ2WFJBRHlpR0V2OHYva3JF?=
 =?utf-8?B?RlVzeG9aT1p1ZDJrc1BXQVNsYU1SOGlmSFQ4dXJmU3pHNEp1cEpwd3VvQ2V0?=
 =?utf-8?B?d3FtNS9qbTlLUk9Fb1hIS2hWbjY0bzZTdEtyL0VrUXFZOFp3bkIyY2lpZXRU?=
 =?utf-8?B?MTZqbm8yS1JxM09nL29mSEdYeGRCNmVzbXk3Q1NTVmlpRDRnNTc0YlRuM2ty?=
 =?utf-8?B?dGF3WUpmY1JSOEM4dlJIQlg0bFRua1g2QjdOakRmOFBweFdnbXcvWmlmTXNL?=
 =?utf-8?B?bVM4cE5naThOZVppSEJyQ3Era0ZENnVrdGNyZDh0YWpXVzJFeGZYU1U0RGRy?=
 =?utf-8?B?RjZGOUtHd1FjWmk1dFA4ZGpGVUNzRjRtaEFia0VEd1NVY1NUcEpzZmVpR1Qr?=
 =?utf-8?B?Ukt5VXU5QUVYNGNkZ0xRVXBrVTBZNU4vOUNTdHZvcWhMRlVLdGl0Z0VPY2lw?=
 =?utf-8?B?ajh1cUh0SFNMckxNYlp3ZnhXVEVkMDdSVGRYeS9GYnZlTGxBTmJiWG44QW1F?=
 =?utf-8?B?V2Vkc2dORU9DeFE3dEVHU28vT0hIUk9DNkYvUUMxK2xQOUVpN1Vkb01vRjB6?=
 =?utf-8?B?SFAxcVUvTG56SmVGYUxKMjBrRGZoaXVjNHdUU3hEUkNEemEzMzFPWlEwZHFI?=
 =?utf-8?B?NWVsWk9IcjBhcVBuYXRVUHBwajF0SmU2N3NOSm1FUURYbGhlVktGcU15MGsr?=
 =?utf-8?B?dWQrUTFHcGYvWE9SOE1USDdFYmJQdmtFQWU1cFVwWjJhSnRSMFhyUzYrV3Fr?=
 =?utf-8?B?MkQxRlVsUS9BMVdOSlVNT0JiUmNyZTRFMVVUc3lDbHNFSmdzNlRjZUN4Nlhi?=
 =?utf-8?B?RWwyZ0NHZEdmQUpZTGcyQWI2engrTm1BaXJUWVR1eXNvWmloRkg3ZmJzcGk1?=
 =?utf-8?B?TTFRQTdTOVB6Mk5mdytIWXZMVXVQR0V3V3JVdm5qRHBwQnpyUGg0dWh5SStt?=
 =?utf-8?B?bStxZ0lUVDA5QVdtSG8vWkNaaG9laVp1S01FMnpiRGZjVWR0amQ0b0ZGd3Ry?=
 =?utf-8?B?ZCsrYmFzTFVrUW94RTJ3dUxwZlRiVjgyMUhvZGdIZVgxeXF5TERTTjVHNmZu?=
 =?utf-8?B?cDlCeEVyYWdMeEV2R0I3Wm5iTFMwaGd4NHV4S3VJcXJoQUg5OE9RY3VyeVFq?=
 =?utf-8?B?M0gxcStPOTlEMzdPdm5oTzVPV2pxVWtNNGpIMkxxbzltc2MvVzRuU1o4ZmdC?=
 =?utf-8?B?ckc5bDFCZ2JMZjNxSU9YS1ZScHdTSzdQaUo1U05Sa3JwNUplOWJET1JTUFZW?=
 =?utf-8?B?Ri9WeVBmb0lqakFWUi84amVDQ3pnY0lqQWlBNUZiUUZONkE1ZVJSNzNOK2Y0?=
 =?utf-8?B?TWNPa0hManpPYWpIL24vdGxIekdFMU5YamF4b2tPaU1hM2llNnllTXo5c3V5?=
 =?utf-8?B?SlVvbUNVdjRVcTdNSE5rcXpCcUt4Y3dLUlpxRHlmeVFSYm9zaHVQMnpEQ0da?=
 =?utf-8?B?d2ZncDVvcDhQK3Y2OUNVWmNRL2g1VHhQSGN2OGk4aGtBVk84bEZydTlycmxY?=
 =?utf-8?B?R09JWXNnRmRhVnRqY3doS0E0NXpQN0svRk1Bb2tCOG84SDgyTmFDTmJ6MHRR?=
 =?utf-8?B?VlRYbUVpeklra0hWQVBkL29hQW9vc0RCSzBVWURDOXQ0OGZjVGx2bFR3L000?=
 =?utf-8?B?VG9hSXMyQVc5a3dVT0pudk52Y2FBN0JldXo0aEFtaHNOeE1vam9GUDFGNEZM?=
 =?utf-8?B?NkRSeWlBekYxVUdkZk4vMWI0YWhwRS8yY2lrcU5FVGZsOVkwSWtLcGZrTnlY?=
 =?utf-8?B?M0ppWm9lN0VGNFU2WEtzWlVWaDZmckw4czQ3SnppcDdlUHhLUUdiK2l5Z254?=
 =?utf-8?B?eFIwZlgzTC82SlpxK3ZTQVpDaXJ3aUYwYXptVFh6NCtYTmphWURhdVp2Rzhj?=
 =?utf-8?B?Yk1MQWtleVQrMVJISzl1TTBMb29EOFBjYmtwbWhOQUlub3Z2Yld5amRpSWFB?=
 =?utf-8?Q?3iLS2h656tWHtd6foB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e91e41-7b56-41ca-0a68-08df1de9bd6b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 05:23:05.4616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfPjeqOtu2BogBcPq0klQ5naC1Dc3YuTcJP2WT3+v5gX2zuGmFHSZk7tN/Y2yc8m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
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



On 24-Sep-26 12:31 PM, YuBiao Wang wrote:
> The VM invalidation engine registers are always accessed with instance 0.
> Under SR-IOV the instance is forwarded to RLCG-VFI as the target XCC, so
> invalidating any GFXHUB other than the first one hits the registers of
> XCC 0.
> 
> Pass the GFXHUB index as the register instance, and print the XCC ID in
> the VFI access messages.
> 
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  8 ++--
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 49 +++++++++++++++++++-----
>   2 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 73d9072f0c6c..faf544ed4171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1561,12 +1561,12 @@ static u32 amdgpu_virt_rlcg_vfi_reg_rw(struct amdgpu_device *adev, u32 offset, u
>   	spin_unlock_irqrestore(&adev->virt.rlcg_reg_lock, flags);
>   
>   	if (is_err)
> -		dev_err(adev->dev, "VFi: [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
> -			grbm_cntl_data, grbm_idx_data,
> +		dev_err(adev->dev, "VFi: xcc%u [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
> +			xcc_id, grbm_cntl_data, grbm_idx_data,
>   			addr, addr * 4, data, cmd);
>   	else
> -		dev_dbg(adev->dev, "VFi: [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
> -			grbm_cntl_data, grbm_idx_data,
> +		dev_dbg(adev->dev, "VFi: xcc%u [grbm_cntl=0x%x grbm_idx=0x%x] addr=0x%x (byte addr 0x%x), data=0x%x, cmd=0x%x\n",
> +			xcc_id, grbm_cntl_data, grbm_idx_data,
>   			addr, addr * 4, data, cmd);
>   
>   	return data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> index cfc46f912d47..d12cdf23c836 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -292,17 +292,25 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   	/* Use register 17 for GART */
>   	const unsigned eng = 17;
>   	unsigned int i;
> -	unsigned char hub_ip = 0;
> +	u32 inst;
>   
> -	hub_ip = (AMDGPU_IS_GFXHUB(vmhub)) ?
> -		   GC_HWIP : MMHUB_HWIP;
> +	inst = AMDGPU_IS_GFXHUB(vmhub) ? vmhub - AMDGPU_GFXHUB_START : 0;
>   
>   	spin_lock(&adev->gmc.invalidate_lock);
>   
>   	if (use_semaphore) {
>   		for (i = 0; i < adev->usec_timeout; i++) {
>   			/* a read return value of 1 means semaphore acuqire */
> -			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, hub_ip);
> +			if (AMDGPU_IS_GFXHUB(vmhub))
> +				tmp = RREG32_SOC15_IP_NO_KIQ(GC,
> +							     hub->vm_inv_eng0_sem +
> +							     hub->eng_distance * eng,
> +							     inst);
> +			else
> +				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB,
> +							     hub->vm_inv_eng0_sem +
> +							     hub->eng_distance * eng,
> +							     inst);
>   			if (tmp & 0x1)
>   				break;
>   			udelay(1);
> @@ -312,12 +320,27 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
>   	}
>   
> -	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
> +	if (AMDGPU_IS_GFXHUB(vmhub))
> +		WREG32_SOC15_IP_NO_KIQ(GC,
> +				       hub->vm_inv_eng0_req + hub->eng_distance * eng,
> +				       inv_req, inst);
> +	else
> +		WREG32_SOC15_IP_NO_KIQ(MMHUB,
> +				       hub->vm_inv_eng0_req + hub->eng_distance * eng,
> +				       inv_req, inst);
>   
>   	/* Wait for ACK with a delay.*/
>   	for (i = 0; i < adev->usec_timeout; i++) {
> -		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
> -				    hub->eng_distance * eng, hub_ip);
> +		if (AMDGPU_IS_GFXHUB(vmhub))
> +			tmp = RREG32_SOC15_IP_NO_KIQ(GC,
> +						     hub->vm_inv_eng0_ack +
> +						     hub->eng_distance * eng,
> +						     inst);
> +		else
> +			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB,
> +						     hub->vm_inv_eng0_ack +
> +						     hub->eng_distance * eng,
> +						     inst);
>   		tmp &= 1 << vmid;
>   		if (tmp)
>   			break;
> @@ -325,8 +348,16 @@ static void gmc_v12_1_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>   		udelay(1);
>   	}
>   
> -	if (use_semaphore)
> -		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0, hub_ip);
> +	if (use_semaphore) {
> +		if (AMDGPU_IS_GFXHUB(vmhub))
> +			WREG32_SOC15_IP_NO_KIQ(GC,
> +					       hub->vm_inv_eng0_sem + hub->eng_distance * eng,
> +					       0, inst);
> +		else
> +			WREG32_SOC15_IP_NO_KIQ(MMHUB,
> +					       hub->vm_inv_eng0_sem + hub->eng_distance * eng,
> +					       0, inst);
> +	}
>   
>   	/* Issue additional private vm invalidation to MMHUB */
>   	if (!AMDGPU_IS_GFXHUB(vmhub) &&

