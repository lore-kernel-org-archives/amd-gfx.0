Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02018606A324
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 06:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Cvv1/+0X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78CE810E9D7;
	Wed, 11 Nov 2026 06:35:18 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011034.outbound.protection.outlook.com [52.101.52.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2829D10E0B6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 06:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIezB5gwt4Wqgo0Tl3Z2zYwZrqpScD/dDMsqSOoRHJgoHTs6bg0nSo/2HoMI5PWFkCCoWxWCJjjouE1eEFVD3fEHq7lgGcUZh0CI4FkvoU6W3NpmV4NDZiJZVAmjH36aG0UUvhwkVE0M4JJYKke3JEF14SMyi8LdTtNdiDOP+Zixg6U1yOc/qW6agVYcT9q4KbPcKv+JGjt5z72Vg1CyPpd03jDKT2ZHwicvBRAzLxTdL33afl2aqEC+J+YLoLD2IZZi2zYqP8XwfyWtIn1Zr7XGdrNlCqoISOVd/lFI8XTw/f3v75K4hbWM656lKugY8Prx5QCMNKiuLj2mpF7oBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNyi8tcF1Y/CXdOq2dcVPDrOAUu/WxX1IyvMsdb+byU=;
 b=jFyBYlvCHYnClhciYHrdsASKpy5Zcq6QgW0glW136Q1Hnwe6ThVK4m6tlBE71jqvvp+2m56tb+09sALl5i7tSWXGsJ2iUTMVxGUyeyJy9K6dM64/uSH3ycdIUgsluWMsLQ0BkbtvO03jtY5Q2KPwmlMBaVBOwrgTQVlKPBoira+UNuUGiCo5m0pau8bUlC/gJ9R+PdeKk5XbAVqLv4+oatOVGFuThJ4/4pj/RwKiOcnmu1I+QjdeAf+1h6SZPmo68KjgWWWjJLtJtryRiXl5qFpG1iNEc39/ikUG2ZRCze4ssqB/JJqRG7o6hRI2hGz2KWPHWFPdOE48Tn8CmWfeXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNyi8tcF1Y/CXdOq2dcVPDrOAUu/WxX1IyvMsdb+byU=;
 b=Cvv1/+0X9I6EDgDpOFNgZ5MJdI998HSLEExLQ95cemGvOHw/wP81tEjSeKdiOIU4z+Ojbn9Oa+PeDOU6uZA3zD0lmnzMXyO4rwOWuDw/595y9LTzlraSsyyG1MiYh3dAEmb1HGD7btn92bRNiLzblvcurDRYaxCHi945MnCrwzg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW6PR12MB8900.namprd12.prod.outlook.com (2603:10b6:303:244::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 06:35:06 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 06:35:06 +0000
Message-ID: <e825ccbd-8c50-4508-a0ab-9db97ac055fe@amd.com>
Date: Wed, 11 Nov 2026 12:05:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd: Select the firmware signing scheme the PSP
 reports
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20261109165009.763473-1-mario.limonciello@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261109165009.763473-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0176.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW6PR12MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f13a4e-396d-45f0-d402-08df3fbdec6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|5023799004|261022105027099003|11063799006|261026140227099003|261021121427099003|261028144727099003|261009223027099003|261022075727099003|261026121527099003|261102123227099003|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 36IN2f6D9g+91AdNVFgyA5uzhh4x2tds/mH0bRjYdMmFRytqwyz6UUYqgmzDp4Oe/LHa58OUM2bNu3WZU19Td4mrR/Bpg6vZf+y/J0/Q9yvI/iFEGBQJu/KjEamnFdMyflW7PCMFtkDjdvdtbZ26CczenZkU5uNFgXk3dxLtT1HRSn8B5y+TBoZwByolrqbjpaFXGNyLGhBq94vc1Nr0e804RUiCRZHM5waSfa5eXMt/aaSWYVXe/iX/oOzi813mzsTVwQqB8diAVXPxG3A8VU3f92HPl/fj+Z3t9LRJGXv+camL1uG9UbvRCJ0S4L//z96eykA+b4ZnUQ0W7cK5ppk/FoTiM/oEwicgkXSNtJ/brv2koDc7E0BqYtaEM25uaaQtF39Nv+2tr0xZpiaJK/a4XlAGkHFUt7KxrITth/APUkkFv+uDSzHkFrifgdNg6wcG6y3CpGQRcEuTfSktwmjA4AYae+VqLr7Nk9scM+FMjAO/2sB74vbUQfxGmLTsgF+4LMCUia0f91ioOfY50mmN0DPX10M2SGANP/rmWRsoXYI1qxsf4LtoDcpl3A+HHiSLE0QR0HJsvJcsK0jbG2mW/uy1m11+gYp4uE+h2FENsAAbvP0N+NKtXneO1dwVCQ4alk4eo6C763QGUH0NVdiITVfjou6QZ4j4nK+4KcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(5023799004)(261022105027099003)(11063799006)(261026140227099003)(261021121427099003)(261028144727099003)(261009223027099003)(261022075727099003)(261026121527099003)(261102123227099003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anNHNVk3eCtoSzVQeFUzZzFXdWpoN2piMXBKTHloWmJ4VFdaa0JkNFBLRXlw?=
 =?utf-8?B?MTlPUCt3V0lHaVVWOTlvKytEcDk5bHh6Nmw4T01sTmIvSnFoUUxNaHZkUzdj?=
 =?utf-8?B?eDBQcVp6amRTU0srOVBpbmxVOXVOTHpYTnl2RmtGQXA1VFFVUXlPS1QydHVD?=
 =?utf-8?B?eTFoRGw2NjEyWHA3WnQ2cXV4RGg1bk9Sdm9ZbWkrL1RJMGVFZngzR0tZT0V4?=
 =?utf-8?B?YzlEOFZRQ3dSV2VVV3R2RXJjLzZzc3VBL0U0enBzRDBJWGU5U0JVWGI4Y1Mv?=
 =?utf-8?B?QnU2ZmFwbC9Fc2VKMk9rRTZ5V1JIU055cWUyL1pXRkJldDk3RlNXQUNZV3F1?=
 =?utf-8?B?OEFXQVpGSkVNMTU2T0JOU3lFNlZVcFNYYTNMdGNZWkV0TEdZQ3YxRFJDUDZz?=
 =?utf-8?B?WDk1VDY0WlZabWNCdXZGaGIzNUNlckpjYUVFT0hYaHJnZTloUWZyTnZiM0Er?=
 =?utf-8?B?NWorbDdxQnlCMUx0MG5QSlhPWGQ3SGh1U0p2d2tMa2R2Vy90Y0llMXA5TWto?=
 =?utf-8?B?d05ub2FxMEd3QTVpMXl0eEFiSUxBMHFNaXl0UVUrYllleW96L2RoYUVaSVN6?=
 =?utf-8?B?S21PS0FETkhCNEFyVkFJSEFPcU1mSEdIUWY3VEdDaXZid0NqdDZORWFGVVhI?=
 =?utf-8?B?RklxaHpLZlczRzk4YkxZMHMyWDRmRDl2bUNuK0pWcHM4ZG9lNEdrSHNYNmVD?=
 =?utf-8?B?OGRqNmhQMjhiZkdpNWo5M25YdzdETWwrNHF0elBzRmc3ZENPWTJDY0JmSS9C?=
 =?utf-8?B?Q0VtM3hFYWNTNzQwMlRoendjd3RmS3VUVEM4RVpOdmRJM1NxWXNaWEZFQTZj?=
 =?utf-8?B?Ny9uajkwSVpuRDh1clBUT2xIc0NWSHhrTjhHSkNWQXlGbmxBeE9iOEVTWTg4?=
 =?utf-8?B?WjJpdnNuaHRrYW52bjE5azBPdEJmby9lNE5OTitMNjBONTdIZ0NTVmRsMFYx?=
 =?utf-8?B?aFBwZ0pIYkNLNTdQdU1HYWNNZWNpMDEwVXdGbWwzekxpV2lLb2Jkbjg4T0lw?=
 =?utf-8?B?N09tcm01QnRDcjJNR2dDN2tlQkF2TFFYV2UyV051UmEweU5NMEQxUTFVc0N1?=
 =?utf-8?B?NzBRT0k0VzcyMjRKTk1aMmd2R0RpSFVtYjUxNDZuUFR3d1FFWFFTY1BLNXNC?=
 =?utf-8?B?amMwNTRvT0tHcWxoQ0NZeW0zTFZya21SeSt1Q2h4NHpSNlJKSkkwQWNxamVa?=
 =?utf-8?B?QWJPRU1LYlo3d3k0R2RXb3FhZGl4aUVCNDB3bFF5Sks2Qno2NE9XNG9pYWoz?=
 =?utf-8?B?bEhuRUZlcE5NZ2pEc0NzMGNjU2djcjhvYUNjUERxVnRFYUpzdkFQVGVnR1lG?=
 =?utf-8?B?K3VZeCtDc0oxUTJEZ1dRNHllaUV3TzlPNFlQZ3IrT3BTbWJqMllzVDZZOElO?=
 =?utf-8?B?dmpsNTNvMmhCeHhXb255ektzVzFlS1JWYmZudFFkMXgvSENPYk9nKzdlTkRq?=
 =?utf-8?B?SUhnSko1VmZ2Y2tuMDJUc3FGWDBQbk5TU0cvTDUxcTdlTnFSVEFML0pRNnBz?=
 =?utf-8?B?Y3RjUWgyQkJvTmlSUStJQU14cTJheUIrN2ZmUGZ4NDdaSnl5VkZqQm10Mnoy?=
 =?utf-8?B?ZUUwQmVTUytJU0V4MmlHZTJ5Smw3bUd4WGhkOXRlQmVPWnBFMytKVXdFdUUv?=
 =?utf-8?B?R2RTSythSlpJS3Vla01xK3hRU3Ria0h1S2t5OEdaSDY5OUgycVIrUjJySHht?=
 =?utf-8?B?RFhMSGdBdFdRaTU4U2Q0TkNlV2hTaTdGZTRMR2FiTmF0MjNlbmFzMmdLbGpY?=
 =?utf-8?B?QUZidnkrOUU3WEp2R1lnd2N4cHNiT2xORzhpTloySXlEVnRNK3ZmL21DZUFo?=
 =?utf-8?B?TlhhcmRyUnhENm00OGovMWpVSE5NZHpHZ1krUFhoc3NsYjJldWJCc2wwWEZh?=
 =?utf-8?B?TnZraVBCeEpQNzd6K0xZM2wyZWREUXlBdncwdHVMNmpBbEE4QlNnaTdXM0hT?=
 =?utf-8?B?WVUwVDBaeXFsY21PSS9QYnZMOVd4cVZmQ1dTRDZTd3Fmdmt3Sm5yUXV4ZHJn?=
 =?utf-8?B?VjN4MG93ODhIT0pHNDBTT29wdmQwVzNMV1Z0UUI1VEdWVmZkMnNjbDh5SVpL?=
 =?utf-8?B?YmQ2RmhQa3lUNGRtQk1DRVFyZ3gwSitXc3MwZjkvM3cvc1VjR0RDUi9nV2NN?=
 =?utf-8?B?Y2lFZDhhUGVCQ0x3bGxsZHdxNDBnSXlDSGdHdmsvUFdQU1NLRC9DRVRJSEtI?=
 =?utf-8?B?Ti9LY29obFlNaXdPeXcvT3I2TG1DY1pNamdIbGl2c1Y0ZXRRakNXTTh5RExq?=
 =?utf-8?B?UFRwSTBWZERaVzdIcjl3bXFIVGNjeW52NHVxVCsrbHA2bGxuYStCeDlNU0Zu?=
 =?utf-8?Q?4pa68dh3sR2fVANrlw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f13a4e-396d-45f0-d402-08df3fbdec6d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 06:35:06.0827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4JYZyIw11DmjIZ2ixkOrxjYdjGTO4m6G5WI/9VDzjzPtebJeIoNZ4IgGHWQ+R86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8900
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 09-Nov-26 10:20 PM, Mario Limonciello wrote:
> Some platforms ship BIOS with either a default or an alternative trust
> authority, so firmware for every IP must be signed with the matching
> scheme.
> The PSP advertises which one is in use in bit 6 of C2PMSG_63, and in bit 28
> whether this is a preproduction part, which needs firmware of its own.
> 
> Add amdgpu_psp_init_fw_variant() which reads those bits through amdgpu's
> own MMIO, and keep the result in adev->firmware.sign_type and
> adev->firmware.preprod next to load_type. It is initialized once, after IP
> discovery has populated the register bases and only when firmware is loaded
> through the front door (the PSP). Only MP0 15.0.0 reports it. For all other
> ASICs, SR-IOV VFs and an inaccessible register (all ones) the defaults are
> kept: AMDGPU_FW_SIGN_DEFAULT and not preproduction. A preproduction part
> that also reports the alternative scheme is not expected, so warn about it
> and use the default firmware.
> 
> Firmware for preproduction parts is named with a "_p" suffix before the
> extension and firmware for the alternative scheme with an "_l" suffix (e.g.
> "foo.bin" becomes "foo_p.bin" or "foo_l.bin"). Production parts on the
> default scheme use the plain names. Do the substitution centrally in
> amdgpu_ucode_request() so it covers every IP that loads firmware through it
> (PSP, SMU, DMUB, GC, IMU, MES, SDMA, VCN, VPE, ...) without each loader
> having to care. There is no fallback to the default file: it would be
> rejected anyway. Declare the variants of the Medusa IPs with
> MODULE_FIRMWARE() so that initramfs generators include them.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Cover PSP 15.0.9 too.
>   * Cover MODULE_FIRMWARE declarations for more files.
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 32 ++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     | 25 +++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |  7 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  4 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        | 16 ++++++++
>   drivers/gpu/drm/amd/amdgpu/imu_v11_0.c        |  4 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  4 ++
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 37 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |  2 +
>   drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c         |  2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  2 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  2 +
>   15 files changed, 143 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index c170bf3b61281..799a76e1cfe77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2098,6 +2098,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>   			amdgpu_ip_version((adev), GC_HWIP, 0) == IP_VERSION(9, 4, 4);
>   	}
>   
> +	/* Needs the register bases, and must be known before requesting firmware */
> +	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
> +		amdgpu_psp_init_fw_variant(adev);
> +
>   	total = true;
>   	for (i = 0; i < adev->num_ip_blocks; i++) {
>   		ip_block = &adev->ip_blocks[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c0ed3e24b6840..4f060666f12a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -403,6 +403,38 @@ static uint64_t psp_get_runtime_db_header_pos(struct amdgpu_device *adev)
>   	return pos;
>   }
>   
> +/*
> + * Which firmware the platform needs, as reported by the PSP in C2PMSG_63: the
> + * signing scheme and whether this is a preproduction part. The defaults are kept if
> + * the ASIC doesn't report it or it can't be read.
> + */
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev)
> +{
> +	bool alt, preprod;
> +
> +	if (amdgpu_sriov_vf(adev))
> +		return;
> +
> +	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
> +	case IP_VERSION(15, 0, 0):
> +	case IP_VERSION(15, 0, 9):
> +		if (psp_v15_0_0_get_fw_variant(adev, &alt, &preprod))
> +			return;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	if (alt && preprod) {
> +		drm_warn(adev_to_drm(adev),
> +			 "Preproduction part with alternative signing, using default firmware\n");
> +		return;
> +	}
> +
> +	adev->firmware.sign_type = alt ? AMDGPU_FW_SIGN_ALT : AMDGPU_FW_SIGN_DEFAULT;
> +	adev->firmware.preprod = preprod;
> +}
> +
>   /*
>    * Helper funciton to query psp runtime database entry
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 975d123593588..9b04e51f589ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -631,6 +631,7 @@ int psp_ta_invoke(struct psp_context *psp,
>   
>   int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
>   bool psp_is_xgmi_ta_supported(struct psp_context *psp);
> +void amdgpu_psp_init_fw_variant(struct amdgpu_device *adev);
>   int psp_xgmi_terminate(struct psp_context *psp);
>   int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
>   int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index d2ce526dd95cc..eeb056dcad2c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1527,6 +1527,27 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
>   }
>   
> +/* Add the suffix of the firmware variant before the extension: foo.bin -> foo_l.bin */
> +static int amdgpu_ucode_set_suffix(struct amdgpu_device *adev, char *fname, size_t size)
> +{
> +	const char *suffix = ".bin";

May keep it as empty string.

> +	size_t len = strlen(fname), base;
> +
> +	if (adev->firmware.preprod)
> +		suffix = "_p.bin";
> +	else if (adev->firmware.sign_type == AMDGPU_FW_SIGN_ALT)
> +		suffix = "_l.bin";

This doesn't distinguish a prepod firmware signed with alternate 
signature. Is there a case like that?

> +
> +	if (len < strlen(".bin") || strcmp(fname + len - strlen(".bin"), ".bin"))
> +		return 0;

Consider using strends(). Also if 'no different suffix' (empty string), 
copy can be skipped.

Thanks,
Lijo

> +
> +	base = len - strlen(".bin");
> +	if (strscpy(fname + base, suffix, size - base) < 0)
> +		return -EOVERFLOW;
> +
> +	return 0;
> +}
> +
>   /*
>    * amdgpu_ucode_request - Fetch and validate amdgpu microcode
>    *
> @@ -1555,6 +1576,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
>   		return -EOVERFLOW;
>   	}
>   
> +	r = amdgpu_ucode_set_suffix(adev, fname, sizeof(fname));
> +	if (r)
> +		return r;
> +
>   	if (required == AMDGPU_UCODE_REQUIRED)
>   		r = request_firmware(fw, fname, adev->dev);
>   	else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 7c809692807fc..a77758c07be23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -571,6 +571,11 @@ enum amdgpu_firmware_load_type {
>   	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
>   };
>   
> +enum amdgpu_firmware_sign_type {
> +	AMDGPU_FW_SIGN_DEFAULT = 0,
> +	AMDGPU_FW_SIGN_ALT,
> +};
> +
>   enum amdgpu_ucode_required {
>   	AMDGPU_UCODE_OPTIONAL,
>   	AMDGPU_UCODE_REQUIRED,
> @@ -606,6 +611,8 @@ struct amdgpu_firmware_info {
>   struct amdgpu_firmware {
>   	struct amdgpu_firmware_info ucode[AMDGPU_UCODE_ID_MAXIMUM];
>   	enum amdgpu_firmware_load_type load_type;
> +	enum amdgpu_firmware_sign_type sign_type;
> +	bool preprod;
>   	struct amdgpu_bo *fw_buf;
>   	unsigned int fw_size;
>   	unsigned int max_ucodes;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6c12d8aa3c769..1df2725d31e0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -66,6 +66,8 @@
>   #define FIRMWARE_VCN5_0_1		"amdgpu/vcn_5_0_1.bin"
>   #define FIRMWARE_VCN5_0_2		"amdgpu/vcn_5_0_2.bin"
>   #define FIRMWARE_VCN5_3_0		"amdgpu/vcn_5_3_0.bin"
> +#define FIRMWARE_VCN5_3_0_ALT		"amdgpu/vcn_5_3_0_l.bin"
> +#define FIRMWARE_VCN5_3_0_PREPROD	"amdgpu/vcn_5_3_0_p.bin"
>   
>   MODULE_FIRMWARE(FIRMWARE_RAVEN);
>   MODULE_FIRMWARE(FIRMWARE_PICASSO);
> @@ -95,6 +97,8 @@ MODULE_FIRMWARE(FIRMWARE_VCN5_0_0);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_1);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_0_2);
>   MODULE_FIRMWARE(FIRMWARE_VCN5_3_0);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_ALT);
> +MODULE_FIRMWARE(FIRMWARE_VCN5_3_0_PREPROD);
>   
>   static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>   static void amdgpu_vcn_reg_dump_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72c..3d82cfbd14f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -134,13 +134,29 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_6_me.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mec.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_rlc.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_pfp_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_me_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mec_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_rlc_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_pfp_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_me.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_me_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_mec_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_rlc_p.bin");
>   
>   static const struct amdgpu_hwip_reg_entry gc_reg_list_11_0[] = {
>   	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> index 09dc01a425d13..a409911939d38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -44,7 +44,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_3_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_4_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_imu.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_imu_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_1_imu_p.bin");
>   
>   static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 60b27278a598b..e9778f950738a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -61,7 +61,11 @@ MODULE_FIRMWARE("amdgpu/gc_11_5_4_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_5_6_mes1.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes_2_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_l.bin");
> +MODULE_FIRMWARE("amdgpu/gc_11_7_0_mes1_p.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes_2.bin");
>   MODULE_FIRMWARE("amdgpu/gc_11_7_1_mes1.bin");
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> index abaa40b6def90..148d62e68225b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
> @@ -32,11 +32,19 @@
>   #include "mp/mp_15_0_0_sh_mask.h"
>   
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_toc.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_5_ta.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_toc_p.bin");
>   MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_l.bin");
> +MODULE_FIRMWARE("amdgpu/psp_15_0_9_ta_p.bin");
>   
>   #define regMPASP_PCRU0_MPASP_C2PMSG_64                                         0x4280
>   #define regMPASP_PCRU0_MPASP_C2PMSG_64_BASE_IDX                                2
> @@ -108,6 +116,35 @@ static int psp_v15_0_0_ring_stop(struct psp_context *psp,
>   	return ret;
>   }
>   
> +/*
> + * C2PMSG_63 bit 6: 0 = default firmware signing, 1 = alternative
> + * C2PMSG_63 bit 28: 0 = production part, 1 = preproduction part
> + */
> +#define PSP_V15_0_0_FW_SIGN_ALT		BIT(6)
> +#define PSP_V15_0_0_FW_PREPROD		BIT(28)
> +
> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bool *preprod)
> +{
> +	u32 val;
> +
> +	if (!adev->reg_offset[MP0_HWIP][0])
> +		return -ENODEV;
> +
> +	val = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_63);
> +	if (val == 0xffffffff) {
> +		drm_warn(adev_to_drm(adev), "Unable to access regMPASP_SMN_C2PMSG_63\n");
> +		return -EIO;
> +	}
> +
> +	*alt = !!(val & PSP_V15_0_0_FW_SIGN_ALT);
> +	*preprod = !!(val & PSP_V15_0_0_FW_PREPROD);
> +	dev_info(adev->dev, "PSP firmware: %s signing, %s part (C2PMSG_63=0x%08x)\n",
> +		 *alt ? "alternative" : "default",
> +		 *preprod ? "preproduction" : "production", val);
> +
> +	return 0;
> +}
> +
>   static int psp_v15_0_0_ring_create(struct psp_context *psp,
>   				 enum psp_ring_type ring_type)
>   {
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> index ebd612103526f..2915ddcfff312 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
> @@ -26,5 +26,6 @@
>   #include "amdgpu_psp.h"
>   
>   void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
> +int psp_v15_0_0_get_fw_variant(struct amdgpu_device *adev, bool *alt, bool *preprod);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 4845588c4c247..2586d49f1e940 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -56,6 +56,8 @@ MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_3.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_1_4.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_l.bin");
> +MODULE_FIRMWARE("amdgpu/sdma_6_1_4_p.bin");
>   MODULE_FIRMWARE("amdgpu/sdma_6_4_0.bin");
>   
>   #define SDMA1_REG_OFFSET 0x600
> diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> index c92c5fc59aeb9..cefb8d739faf8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vpe_v2_0.c
> @@ -31,6 +31,8 @@
>   #include "vpe/vpe_2_0_0_sh_mask.h"
>   
>   MODULE_FIRMWARE("amdgpu/vpe_2_0_0.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_l.bin");
> +MODULE_FIRMWARE("amdgpu/vpe_2_0_0_p.bin");
>   MODULE_FIRMWARE("amdgpu/vpe_2_2_0.bin");
>   
>   #define VPE_THREAD1_UCODE_OFFSET	0x8000
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> index 0ea8f9a582ccc..b28d67b4e70aa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
> @@ -62,6 +62,8 @@ MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_ALT);
> +MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB_PREPROD);
>   MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
>   MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> index df3e776c1ad14..219e9c0427441 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
> @@ -61,6 +61,8 @@ int dm_init_microcode(struct amdgpu_device *adev);
>   #define FIRMWARE_DCN_36_DMUB		"amdgpu/dcn_3_6_dmcub.bin"
>   #define FIRMWARE_DCN_401_DMUB		"amdgpu/dcn_4_0_1_dmcub.bin"
>   #define FIRMWARE_DCN_42_DMUB		"amdgpu/dcn_4_2_dmcub.bin"
> +#define FIRMWARE_DCN_42_DMUB_ALT	"amdgpu/dcn_4_2_dmcub_l.bin"
> +#define FIRMWARE_DCN_42_DMUB_PREPROD	"amdgpu/dcn_4_2_dmcub_p.bin"
>   #define FIRMWARE_DCN_42B_DMUB		"amdgpu/dcn_4_2_1_dmcub.bin"
>   #define FIRMWARE_DCN_60_DMUB		"amdgpu/dcn_6_0_0_dmcub.bin"
>   #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"

