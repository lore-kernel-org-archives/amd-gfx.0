Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41966F9936F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA3A310E029;
	Thu, 23 Apr 2026 11:12:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q3VqJRRp";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2667E10E029
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbZTEAZlHeH0xQW3NIuC8h5VEIiFHh5pM5/Kw5BiWjzmAQq8kOG8Fs+TzArdSidsTFplCgNfzDrgM/h+tjQjTFNo3jbeJMZbRAtnkxzTZj4/jPDDSxuwNtHhIg5xlJ0YrXw6dHATMUFtaijGbUq/VyrPRk4pXRbUq+31tXaOkRr4QBFjAKlOsVfOsshOVMDaMHT/R0iNCHFDs2sPEKcmihnmTF1x3imiVj0IIiJerqlwRlEszQiXLBFU5yG61fMdBsctFxrhXla7xaXYwXNojPBuNjlic1tc8BObzvAX3X2dInlyTBOSIWPFGj64xzpIQT70hgy1k2fALJL7i/UUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdU78eJHU11ojb/MvW9YFLftscIJZRYlnFIjH6JQvN0=;
 b=A+xYZ3vbdDabR+JWvIVN0aXlEYYAMvWyVDmmp+WcFoWzcOtbIH961chPQtA82N+JN+e8Lb1M8LdDuhAuYrk9cUmtqRtO4rOA1eMJPAM0Luj6NZ5ilJtsT3D/zlN40hN7JW9WVYwfaKpdqvHzguVWrHDAYQVWpiR0P7MEL9oXBWjraPtkRQ2o0VL4ryfzUgqFs0OuHzl2dIc8KqKq/pw/RHE9GpyNfA6Ju6bqaz2uklTI2vXSDpIqkutBaseFEiJJYjw3oxNFhXm6/oL4ZOt5yuQv/FGYUoR4iuSdUx3D3EVfqINPGOEODzxzIjIXTMvQAu4Aq7x8ju1bGEJoEcjaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdU78eJHU11ojb/MvW9YFLftscIJZRYlnFIjH6JQvN0=;
 b=Q3VqJRRp3GOTFFymZaEvfnaEHgVKi6widkX4LuGAKrA2PL/xijj2iQNL2nuFKkNnfOe+Kt8HI4FTzDG95+eqBHA0kF+epjKgyZhW13R//B/9z2bg8wzKuQcYuO80G7rlCiEawCmhYhiaX3qnWV7vF80lR61EVJGjm+clPCfkZIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 11:12:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:12:49 +0000
Message-ID: <826247a8-1e38-4e7d-9694-c359c8200beb@amd.com>
Date: Thu, 23 Apr 2026 13:12:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/amdgpu/vce1: Fix VCE 1 firmware size and offsets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-7-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260423011614.309180-7-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0261.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: f66b839b-0f9c-4c31-4fd3-08dea1294172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: XdCCpvh1qay72TSCHXqR2TsTFG3p74IMX1aWcLO2lg8Cn0SVdTDC0MXNi4df1FIJL5bj1EEHhT+kk7KLv9ClGhoSRfR+7pB687E3b82siXoQxkhe0AjgDPL6A8BqWzcSYoQTSLvmzGoxEGMbnaoD+uNMBGvigs3rrXIr8CbnrnkHE/WWH2AZT+Ju670/bAb2srAMVRRUznBZyXovAIRdnGQr788QUZIwhtaZZn/Fbd6NhifO6SC4LX6w/EEK51zXyb6QQD5Hr7HfF/rs9lm2Cjdmyt5gbcpFaIvbCnhv+0rSetwDLzrr1d0tfPcv49XKPPDMoZ2ROvBDuyivc0WAwwyUfZmnFm6IYYi00fl/8fi8TTQlxwAABTKaGsSNNxVDPj/Raomq8ThZBJeH3l6XQONe0GtuqGO0r8iEKz55XN8cMc9FuIercy3XbEyL6IoLOUyqDx+/LpGTW1HYS0izeHFaA28iofoDTpB/c8nEeLBUa4FE2xMnYl3yIs6ure6RK55wYRRtRq5pOBhDUApnOmyOhNOgE2cfzgQULcF35IJL/ZwOa1joa3vwYtY3K4YUyH+w79arDvc/T9ELCwZdCG6HfBD63UFRwttlZgF9ZC75S3zV+YGA7IGsn/PgYcX3OaYg5UTHBeZRTJOBgU4MKsos1A1gS1ayUDDUnv5uYo59oPG/nk1O770tHevd9XawzUJDvSeS8e0+t8Y0KC9rvgz8cjTVYwMKzCxsYdk+4OU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0lmcys2T1J0eGZiNFdYSWozUlRLdW1GbVMxanZQSmdka3Y2cjNxMW9kNitE?=
 =?utf-8?B?Wk10ZGw1MDZqL1V0S2tPaHVpVTdhSWowNlNUaDM4NVl3UXc3MzZYNVdGVDNZ?=
 =?utf-8?B?dDg2Y241MTF5QXJWdTdOL1ltZGZzNWpoWGhjRHdlKzQ2QkdCNk42aDVYNit0?=
 =?utf-8?B?bXlLa0x5N0dvOVZhR1VOWklGeHJXYWFxWDN2bFFmUnB1WnBOanRtcE16RWxa?=
 =?utf-8?B?UWlWdXpsNXR3b0xTVEZ5ckgvalFzY1h1TTNhdzR5b3ZESkJXcjNLWlM3SjBD?=
 =?utf-8?B?RnA0NGhuWjdWZWxQaEpWM08vNXpGRHhDU1Y2Zll3UjVid2xNc3EvRStFS1lH?=
 =?utf-8?B?UDh6SE9EQWpOcjBGMUQ2U0lHMkVRTXBMZ2c0MW9Sd3BkYTc2MnU5NktYdG1p?=
 =?utf-8?B?bkErM0FLMVhqdnRqSE8zbmVyRitJNUtHemMyS1lEb2NjaXJ5TG9lS0NCZ3RD?=
 =?utf-8?B?bzE1bjJhQkxINkNxSDhSY25UcUpvekxwdXlldTRTUm1TUVVPZHVNV2ZCT2pK?=
 =?utf-8?B?bzdxZitqUi9HY0RpUmRwYi9Lc0dwU25NcDBqZHd5NDJ0anVqRnAxM2VvSUdx?=
 =?utf-8?B?Q0VzV25RN1NraWpUeGtVUDNKTVVMSCswY2ZMNHRGdDBRcVZnY0Z1V3VUU0NF?=
 =?utf-8?B?NUhxZXl3NmxScnZNMElTQ2pVanRXNnEwb1QyQjJoWWNiaENHL3NBa21tZTBv?=
 =?utf-8?B?WkpadGl4ZjhvZW1SNXRQTjlyakV3VFRjemI0MzR6bzlyNXp0OUNKREJpMXFB?=
 =?utf-8?B?VmJVL2VxQnZSYzlZNUpCR1JoN0NuK0ZxZzlNSlJSNWJZaVBYdmxtWTl5dmN5?=
 =?utf-8?B?VW9yUTdGUFJBV1Z3dVkxSjBRU0tZM055SXA0WWhNMXVVTkwxZHcydDAydzlB?=
 =?utf-8?B?WE95YXhBTERpcDlDR1JMb1RrbXJQdEpmdWx0YVhibWZXNlR2aWJJL3hEZXZs?=
 =?utf-8?B?RmM1SFZEM01wRHZaR2xNM1ZXUWNCSEMxbFVmR2RQeFcwZkUreno4YjBDRWNM?=
 =?utf-8?B?aVFjckNzd3RZYWtBUnhsVTFyTEpTbHN1amRwaFlZUXFyQkVydEhHMDhxOVlB?=
 =?utf-8?B?L3M1VDFPdzdia3NJZ2l4ZmlVTUFGWEwzUUFjQ3EvOHJDTmpweWRUQUErODVw?=
 =?utf-8?B?OU8rSDc2TVhncEVadFZNMk55U0JUbmRMS3V2VGdLWnZaQjE1N1lTU1JvdVh3?=
 =?utf-8?B?dGRZMlh5SEczdE1nbjVRYkgzWG9JQ09DZGwyWTNNMDFobit5U1duOUVvVTlw?=
 =?utf-8?B?b254RzJFcDN0WmpCMHIzYVZma1drMzF5OW4vTFM2amptK2lZQS8vTkFjdzNv?=
 =?utf-8?B?WEc4WVRBK3pWT0x1SVdvTzRBam5taEdqYStXSGpXS2V1WXJ5SGVpLytUWVM1?=
 =?utf-8?B?bm9tUVJUWGdMenhnUjVzZlM1cTZSeUVkRDh3SXVGMG90d2MwcjhIdXZ1SDA5?=
 =?utf-8?B?VzN3V1E5NHN3amhsZXlTQ3FzN0tORFNtYzBYVjUrMGJaUEp1MTcwM29vQlJu?=
 =?utf-8?B?d3hHb3MwaXBVZFNnTmtLZ2toMnVNK2xYWGtoRGwvb0g1NHNJOFRjVGUwQmVS?=
 =?utf-8?B?OUVPRW5DRGIza2NuM2RLNDZ0aG92VkVYT1dlNE52OFdhTURpR0dUcDhFZkp1?=
 =?utf-8?B?KzJuVnhhUms3MXpSS1I0YTdaVUpjdHV3VW0vcjYzSXB6bHI3Y3QwbG9JeXdq?=
 =?utf-8?B?WDB2NHFMMHNFbjBHUFdZcG1hbnJGR0JvUnlYUC9BaG9YZkJoS29PR3NCZVdD?=
 =?utf-8?B?Mnd2dUNma2d3RlRSWmVPQnZHdnE2aVU0MFJKSWsya05VR1NRUXM5aXJ5ak9i?=
 =?utf-8?B?NWpBbVVlYldaVjBPK1hWTXJNRXVsYlFnd253Z3VHbzhkeWNpdy9la0hvanha?=
 =?utf-8?B?ZzBIaDdkOGNRLzdHckxDTExzM2dRay9RMDNRMmhZWkZmSm5iOTZhRm83b0hn?=
 =?utf-8?B?blNPWjNnUUxKdjBWUlZxR3hyRmRKQmw5QXFSUnBwQUhNdG9hY1JJNDZoeno1?=
 =?utf-8?B?RjJXb2pvNVZlWnVoc1crQ25mWnk5UldqVUsxTzJoeXE3WjE3OXJhRUZGTHkr?=
 =?utf-8?B?R2p2SlNXdVJZVWc1S2w4WXk2bEZ2SW9MVlc3b0w4TzYyczJRZUxtZ29aWmZm?=
 =?utf-8?B?MTIrblVpRnpNRGZYdVJjQVk4R3JwNnlnMnFERG9EbVJBOStqOStPZURLU3Va?=
 =?utf-8?B?bWNzNXRTcHY5eHE4QTliQk1lNlViRnBkK1EyV0pSKzVnd1Z3NVRxalNaMllk?=
 =?utf-8?B?NnhYT2NxWXh6MGZjTGpKSVphVXUyQWk4ZlY0cVBRNUUvNEkyMUpJRllPYTJa?=
 =?utf-8?Q?L6TWz1PmPdVe7s85bA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66b839b-0f9c-4c31-4fd3-08dea1294172
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:12:49.8486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PReYA7B36VdmYc6ReJAi5vjUideig0U3BzE2whKiU5LCn/yOr9I3SLTC8PU1rie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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

On 4/23/26 03:16, Timur Kristóf wrote:
> The VCPU BO contains the actual FW at an offset, but
> it was not calculated into the VCPU BO size.
> Subtract this from the FW size to make sure there is
> no out of bounds access.
> 
> Make sure the stack and data offsets are aligned to
> the 32K TLB size.
> 
> Check that the FW microcode actually fits in the
> space that is reserved for it.
> 
> Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> index 92c3cf3fce4f0..c8e7297fd7ca3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -42,9 +42,10 @@
>  #include "oss/oss_1_0_d.h"
>  #include "oss/oss_1_0_sh_mask.h"
>  
> +#define VCE_V1_0_ALIGNMENT	(32 * 1024)
>  #define VCE_V1_0_FW_SIZE	(256 * 1024)
>  #define VCE_V1_0_STACK_SIZE	(64 * 1024)
> -#define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
> +#define VCE_V1_0_DATA_SIZE	(ALIGN(7808 * (AMDGPU_MAX_VCE_HANDLES + 1), VCE_V1_0_ALIGNMENT))
>  #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
>  
>  static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
> @@ -189,17 +190,22 @@ static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
>  {
>  	const struct common_firmware_header *hdr;
>  	struct vce_v1_0_fw_signature *sign;
> -	unsigned int ucode_offset;
> +	u32 ucode_offset;
> +	u32 ucode_size;
>  	uint32_t chip_id;
>  	u32 *cpu_addr;
>  	int i;
>  
>  	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
>  	ucode_offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> +	ucode_size = hdr->ucode_size_bytes - sizeof(struct vce_v1_0_fw_signature *);
>  	cpu_addr = adev->vce.cpu_addr;
>  
>  	sign = (void *)adev->vce.fw->data + ucode_offset;
>  
> +	if (ucode_size > VCE_V1_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET)
> +		return -EINVAL;
> +
>  	switch (adev->asic_type) {
>  	case CHIP_TAHITI:
>  		chip_id = 0x01000014;
> @@ -231,7 +237,7 @@ static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
>  	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
>  
>  	memset_io(&cpu_addr[5], 0, 44);
> -	memcpy_toio(&cpu_addr[16], &sign[1], hdr->ucode_size_bytes - sizeof(*sign));
> +	memcpy_toio(&cpu_addr[16], &sign[1], ucode_size);
>  
>  	cpu_addr += (le32_to_cpu(sign->length) + 64) / 4;
>  	memcpy_toio(&cpu_addr[0], &sign->val[i].sigval[0], 16);
> @@ -312,17 +318,22 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
>  	WREG32(mmVCE_VCPU_SCRATCH7, AMDGPU_MAX_VCE_HANDLES);
>  
>  	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
> -	size = VCE_V1_0_FW_SIZE;
> +	size = VCE_V1_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
>  	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
>  
>  	offset += size;
>  	size = VCE_V1_0_STACK_SIZE;
> +	WARN_ON(!IS_ALIGNED(offset, VCE_V1_0_ALIGNMENT));
> +	WARN_ON(!IS_ALIGNED(size, VCE_V1_0_ALIGNMENT));
>  	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
>  
>  	offset += size;
>  	size = VCE_V1_0_DATA_SIZE;
> +	WARN_ON(!IS_ALIGNED(offset, VCE_V1_0_ALIGNMENT));
> +	WARN_ON(!IS_ALIGNED(size, VCE_V1_0_ALIGNMENT));
> +	WARN_ON(offset + size > amdgpu_bo_size(adev->vce.vcpu_bo));
>  	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
>  

