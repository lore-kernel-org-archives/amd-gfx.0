Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A8AF532D4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 04:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CC710E0C2;
	Tue, 24 Mar 2026 04:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xEcG4cqQ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80CA210E0C2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 04:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKxhEqIqd7/z8gDFptAwU4FAvtHLW+v/TcbgY/cp1DZLKOEhbG/mfpI2vIMZn0si6YanaLw+R5xy2uhWrFu+7OvHCE4tZPejF7W4YdyWIW9n1+2b+VmV21KP9I2mrx3KOAMDjtzaEpP0w5AxTtF5kILzsbWZfV0I7oFauM1urapZdxldvqo00kl49QpfcMfHuDEdc0PBOqNcdXW9Sw+BPTcK/qlkQKg9vSF/ssz4X3Di7NjtOAcY7ikZJq2ZN8wAWItVtWDn1Hu/tjF0JlrAYaZ24RAZLxQ5a3qjvWki7I8dcccynzbJXuC/0B/yYLFuldtuawx362HhCeejhNzZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laAVEuNvGOo7Xx3SlINWULk8b7kavaEkjlzG1WckHEU=;
 b=Duja/Q2rqhLoWZ2A8ST6C9YzR0tO8soX8tpBEmsyrMM9DHh4UmJzZa0tkh8QwqVlUzIl9e7EjEBd8iRX9XfQZQU8IRoC72ZihHvIHI7tHKtvmKDAV6IMT+cIPW1SsxqctlzfdJbOyao2YAU06K2fInH+1C/Pid/1j2GzeaA2Ie9yR49kOTBpXldaPt/mjbfjc58NM91X3qa2oTO2j5TfJsBW++xI7R84ty74t7BaZdI4gmOQRRIisAHfOkbD/A8hAZkCZrHx5YIRNVLMPbGaYbI5eSHhu7tJ8MF4fh8WftsOOQ0zeAg3eszdUrlbD64mxuWFdMhhJJql9UMgU87qIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laAVEuNvGOo7Xx3SlINWULk8b7kavaEkjlzG1WckHEU=;
 b=xEcG4cqQXflUfQhGjww6WjjC89Bb6XRUd4/dKe7PSBs8nn/iuAB2ZUkIyG1bI4ib14HkeyVT6OYiIVNNSOgiWf4oJ+0Qf9Y0mXuywceZl5nZkhtP9Ps504Qhkvu3MYCNUZvCor+xw/5s9J/2E9VoUO/J/6fGko3yTU+Y4+5IqOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 04:19:20 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 04:19:20 +0000
Message-ID: <151ad3b4-c455-4109-b687-f4220453281b@amd.com>
Date: Tue, 24 Mar 2026 09:49:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: add support to query vram info from
 firmware
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, tao.zhou1@amd.com
References: <20260324041123.1882318-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260324041123.1882318-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0066.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::11) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 204c520a-b057-4fda-d116-08de895c854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: VJzihc8fP6zWBynR5idpxMgFlL4Y1hz1YwwGpN6/MZK8mqIDF/fpePcjcxAKrovDHcSwGdCDG3v4oyWI9SJKgA203gc4rWMcXCDtsufqANunQz/ggNMcsizJho9CWggUDP90BhMy9kQfegpb8OBxSGG6uAk+agKOfyO2oK9JPYhK6SrP8kQb1LxxVrN+bRg5HNEaTOlEIghw+ZtUTmX3sXbI0IXaaCi8792meCAoHWKviS215gMDS8KWbFcd/FGnJeRxuyTn5kDAUU3iVjrKEhm5bFFvMaom7WyN7guahj69niX7yxOgDlkAWCWxWlYcKh1QakCy/q67JGNcN7b9h6QF9gwDPGM3NeAb4TYMwv7jVpNhQLZNWHpe08AhPq3peoRwBmSzafyPqM8pb6xZd/b1KcOAy5Qp5v0gZTEuzNBWWPUy7D7foay1/kMLH9Fhq3vygW4yLIeVDeildNEmRbRZUMQHLJBZJNWSrwJA3VaMRcsA4s5M1KvS45e/XhmknpaXzP7OpgyQymrwks1VE7l9BQiCdNXDC+r3wfGU59MaP1x0JnEAxogdaAbHru821JLjXNiDmARAiNDEpVIPVjT8/SctXydEeklXyhVf3Kdftg3kRrSVd8U5mMtiIlCVi6tV25aH41yn2evgB8V+2lTZbnHKZN0BOiwSZESm8Jcgg+res/4iSu0MU22P2vpFZp6eC95gpr1cMNK15MulSmeKRG1QDLIBzU6f2bS0/1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZRd2FtZ1dWVThVVE52bWQvbzJXYU93ZlYya0FtKzhyYzdaZG8wWG9xZWxD?=
 =?utf-8?B?cUFGV0xTZXBZNmYxYWVpUWxxT1JpdGQ0dEUzUnZkZEVUeXRVVzBTK3dlaDRU?=
 =?utf-8?B?RFJUb2tDa08wbFlNK2FpRThOWEFFc3J6Qi85OUxneG16S1ZsMVM0cU8yU1V0?=
 =?utf-8?B?SUp2bmNRM0JBdXk4MmhuVTd2c2VaN1lrbTFTbEVQcHpyT3RXeWVmNlZianU2?=
 =?utf-8?B?Z2NoTkY4R0EvaERYUERZeUJ1RXZjajlHRVgyT1doTjRVU3A5WThNT044RU5P?=
 =?utf-8?B?NkZtaEx1SDZ6c2VITXJKOWNqWE92bHlFMUNVZnhQZGIyUTFFUysyeGswcXl6?=
 =?utf-8?B?UGlQVXprZElzam5DeVdGZGp1RVJrbHZMdmh3Zm1RUHdCSjU1S01lUUlPU2ZC?=
 =?utf-8?B?cDNLdWpVbS9JeGJBeXJXUlVmdUJudFVLcU9IRmpxNFFTTnVOdDhCcFNXZVBq?=
 =?utf-8?B?QXhnWGIwdHRqRlI5bTA0ckxya0RZN3BBMDJBd1lqTWhxU0lZci96SGZGU1NC?=
 =?utf-8?B?MEt0VUVteFZCKzRraXk3N3pZN2IycGtuQTQ2ODdoYTFkMm1UUHlYU3BFaUc1?=
 =?utf-8?B?bTNuc05oZHFJZTI1UkZxeTdGR1ZVSkdpZGdoZHJVcy9XZkN4djNpZTVlTkRE?=
 =?utf-8?B?ZUhVY1cwNTFtN3VFOVJNbmU5RW91Q2pCZWpMWEpoN0tZOG1qR2FXWFZCby9O?=
 =?utf-8?B?UmVSeE04OVdiNkZ4WlphV0dTVTdkU2wrajRnMkoxd3QybW41dE1DeUR5WFF2?=
 =?utf-8?B?T2ZsZFptV2g5Z25FS2xwNlFPYWR1Z2gvblZXaEFQL0ljR214TVFwTVUrUmFZ?=
 =?utf-8?B?em81eVI2TVhPL255TTlrVDNnTnU0M3ZFLzFjYW9Nc20wUTVsQVdxTjIrY2Jn?=
 =?utf-8?B?UlREVmk0YnpySU1uajdFdGo3TjJzRFpoVUdxa1pZb2U1UlNRMGk3L1lobldo?=
 =?utf-8?B?bmJ3ZlF0Z2QybWFQRUZNL0t5Y2tJSnRuK3QzYkFtUThCNklHVjF2b0tMVGhi?=
 =?utf-8?B?UmdkU2xFU1l2UVJpanVBR240OGRjVWxjRlQwSzYvclBPU0h6a0lkOXRRejVw?=
 =?utf-8?B?TUMyaEVjaEwwdElNdzRtaTFPTktJMzBZNTh6R1NwRXpwNGpvTmNZckZ2NVdS?=
 =?utf-8?B?UkFXRHA5TmtnWVdQREszZVRtaC80Q3hZVnZDWU9SSU5xaDk5dWVkY1E3U2Ju?=
 =?utf-8?B?aVdFZ2RWNThGeFoxQ2tnMGVyNy9oanQ4Q2JFN3V0bkZGQ2EyNTk3a05UK0dv?=
 =?utf-8?B?ai9xMHB1eWRYNkxBQU9UakNjNWpQZU9yR2JEQ1BRY2M3SzZZQTk3MVJFRS9E?=
 =?utf-8?B?Sk5QMUtrSm41NjVDWm4reG9PSnltZ0ZESFk0VWpmUlAyajhocURpL1ducTZ4?=
 =?utf-8?B?RjErbnE4Zi96RjUvRXJ3M1l5bEl3UDJGMTFMRSs2RHpGdWpzLzBsUTJxS1Az?=
 =?utf-8?B?bjlxNGk4akpJY1lLWFpkK2xoaENmNDJEbDlHSFBBU2ZkNWlVWVQwbkk2bmFi?=
 =?utf-8?B?UWhxam1UZWVxMGRTUUE4T1ZOSjhSODZxRWErc2x2N09JTSt2aG5XeEtBa2ZY?=
 =?utf-8?B?UkMybC9GNkkwTmVRdEtyejM3QnIxWHIyQm1aYXpNeXhZU01zRFAzVkFrUXl0?=
 =?utf-8?B?SWlPa1JFY3NIa0c2TmcxcCt0emVPWkVJSm84NTFJVzJsTGFFYXVub2J2Q0Rq?=
 =?utf-8?B?ZHFQQm9vRGliVmZ5cTM3aVkyUU00M0JGa3dnbHUxTDFGYzNscm1WV01BV1ZU?=
 =?utf-8?B?ZWlJSVZwMS9SRDc1cWJCbUxDQmFRL2JJZmdDSXNFRk5nWWY3bHhVci9yV0RN?=
 =?utf-8?B?R2UzUnlKSnQrUkZGN0FMQTlVeWJDUkxudXd6SnVrYUU2bVB4M2hpUW1YbjZt?=
 =?utf-8?B?WEZNZmVEQzcrc3VmRjlaUGo3c2hIQSs1djBva2laenYxVkFlNENmd1dVdERj?=
 =?utf-8?B?eC9wbVZDRkJ6dzRGQ1QwelVXOUVJcmJVODdsNU9ML2lhY2FKVkZyN1NOczBD?=
 =?utf-8?B?RVRhZFZ4QnI4MUZaRytuQ1VVZHFCbndIMXRvd0k1RTBLUER2ZE50ZmxCOENF?=
 =?utf-8?B?WENwak5Jd1RrUGRveThzc003c3B6c291SWlYWTFlWW90TGFTc3Y2OTg3K0p3?=
 =?utf-8?B?Sk9jK05yQVBRL1lWejVYalNwMTZIdTIyRzdTUmhVU0ozcmpJY3RmVmY0eko1?=
 =?utf-8?B?TXdyVUs5WkVMczZzMng3ZzkwWE1XbE43cS9wQUFuMklaRzlUSXFKWExwa2dM?=
 =?utf-8?B?ZlR6elFaZndsRkp3NmZLNFlHNE8zYVU0OS9maC96MmRTSWdha0RDeEZjeVZH?=
 =?utf-8?B?bnZoYTkxZTJZeW5NcXN2VWt5a2hrZWtLQml6TFprWWhEZW9QUWs0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204c520a-b057-4fda-d116-08de895c854d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 04:19:20.0813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWX1fha9lndtvU/bKRPJZqKZOpa8oOZFkw8ENQ6xx5IGMM/aeu4y26FWQMGsZXH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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



On 24-Mar-26 9:41 AM, Gangliang Xie wrote:
> add support to query vram info from firmware
> 
> v2: change APU vram type, add multi-aid check
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 13 ++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 56 ++++++++++---------
>   2 files changed, 43 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 7f4751e5caaf..504b5f0a74ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -399,6 +399,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   		switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   		case IP_VERSION(12, 0, 0):
>   		case IP_VERSION(12, 0, 1):
> +		case IP_VERSION(9, 5, 0):
> +		case IP_VERSION(9, 4, 4):
> +		case IP_VERSION(9, 4, 3):
>   			index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1, umc_info);
>   			break;
>   		default:
> @@ -475,6 +478,9 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   			switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   			case IP_VERSION(12, 0, 0):
>   			case IP_VERSION(12, 0, 1):
> +			case IP_VERSION(9, 5, 0):
> +			case IP_VERSION(9, 4, 4):
> +			case IP_VERSION(9, 4, 3):
>   				umc_info = (union umc_info *)(mode_info->atom_context->bios + data_offset);
>   
>   				if (frev == 4) {
> @@ -488,8 +494,13 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
>   							*vram_vendor = mem_vendor;
>   						if (vram_type)
>   							*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
> -						if (vram_width)
> +						if (vram_width) {
>   							*vram_width = mem_channel_number * (1 << mem_channel_width);
> +							if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
> +							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
> +							    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3))
> +								*vram_width *= 4;

This is not the place to do this and this is not the way also. It should 
be based on total number of AIDs available.

Thanks,
Lijo
> +						}
>   						break;
>   					default:
>   						return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 1ca0202cfdea..285eecb65522 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1823,24 +1823,37 @@ static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
>   		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
>   }
>   
> -static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
> +static void gmc_v9_0_init_vram_info(struct amdgpu_device *adev)
>   {
>   	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
> +	int dev_var = adev->pdev->device & 0xF;
>   	u32 vram_info;
>   
> -	adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> -	adev->gmc.vram_width = 128 * 64;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> -		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> -
> -	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
> -		adev->rev_id == 0x3)
> -		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> -
> -	if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> -		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
> -		adev->gmc.vram_vendor = vram_info & 0xF;
> +	if (adev->gmc.is_app_apu) {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> +		adev->gmc.vram_width = 128 * 64;
> +	} else if (adev->flags & AMD_IS_APU) {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
> +		adev->gmc.vram_width = 64 * 64;
> +	} else if (amdgpu_is_multi_aid(adev)) {
> +		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> +		adev->gmc.vram_width = 128 * 64;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) &&
> +		    adev->rev_id == 0x3)
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
> +		    (dev_var == 0x5))
> +			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM3E;
> +
> +		if (!(adev->flags & AMD_IS_APU) && !amdgpu_sriov_vf(adev)) {
> +			vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
> +			adev->gmc.vram_vendor = vram_info & 0xF;
> +		}
>   	}
>   }
>   
> @@ -1856,19 +1869,11 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   
>   	spin_lock_init(&adev->gmc.invalidate_lock);
>   
> -	if (amdgpu_is_multi_aid(adev)) {
> -		gmc_v9_4_3_init_vram_info(adev);
> -	} else if (!adev->bios) {
> -		if (adev->flags & AMD_IS_APU) {
> -			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
> -			adev->gmc.vram_width = 64 * 64;
> -		} else {
> -			adev->gmc.vram_type = AMDGPU_VRAM_TYPE_HBM;
> -			adev->gmc.vram_width = 128 * 64;
> -		}
> +	if (!adev->bios) {
> +		gmc_v9_0_init_vram_info(adev);
>   	} else {
>   		r = amdgpu_atomfirmware_get_vram_info(adev,
> -			&vram_width, &vram_type, &vram_vendor);
> +				&vram_width, &vram_type, &vram_vendor);
>   		if (amdgpu_sriov_vf(adev))
>   			/* For Vega10 SR-IOV, vram_width can't be read from ATOM as RAVEN,
>   			 * and DF related registers is not readable, seems hardcord is the
> @@ -1896,6 +1901,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		adev->gmc.vram_type = vram_type;
>   		adev->gmc.vram_vendor = vram_vendor;
>   	}
> +
>   	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>   	case IP_VERSION(9, 1, 0):
>   	case IP_VERSION(9, 2, 2):

