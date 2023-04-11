Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08350C7619A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 08:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D3610E4DC;
	Tue, 11 Apr 2023 08:10:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EE3F10E4DC
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 08:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFuM82p0e9sr0ULBexR6H/V5DK/SV3G4tnrfzbSXJDu58hsrl+vKOw2LrxJPDz3C7RB+BojApzuzDUsSiVMcQw8rASFLkRRZ9aclAyINIhGIM1VaEqMcZuYopEpaMWk3iBArHGR3kRWBXLwQbbyKW2xmu3CSZYkPJ8qob1Z+d+fzfzjaQavUed5ZTk78/bCP1GucjQNSzCC0qRvwKJ52k0BHd0LjmrUMBisF36E5bgXRE7M7VhL0zMTMokKB5BNL+4uOYKPPS8GuzqMzLPTMtxRkcJ06vrXY37aMy5G3DBne1l6xVo/ZLKx+MX86esKo1Xedoi+WYdjfvC+bPDJx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1WRXRxr870QKPLQg5BY4jkbh1h7n5nNlfdFbevwp7g=;
 b=nFriNmwy5ClSGyvWhozqqTbD7zwd/mNP/VDIH/Ty010CT5YVIQ4TR3w8d//NcioK/PJNe+d1DGBpxIbPc2ET9pt+KBFhSeQQZTxyMvRYc57/JpFlnXcLjFIAEKHq1hD51c3RJRQOl+Z9gZ144VeTD5SR1Qpn02qSYoZo6mTMrg7NcRsVvmhbcTjH7X+I4ehEWNlZFQxh7/P7/AjK7z9G0NPj3R3obLSfTM2WHBKb144ZeAtYEN8WG6vfTWlQTkYH+b4R1qzYJKHVsI+0JdyT7CyGsk2B0M+7500iOKlHww22DAUzq1x8vQl8N/kp237C9PB04SRFJViBqntXs1bFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1WRXRxr870QKPLQg5BY4jkbh1h7n5nNlfdFbevwp7g=;
 b=ckc/NPvIohMShitaed2LkOzaPC6Bf2ynaaJDES218egEJ46qAq1lzyt4vD0UUgUqnMxnQbdB23twW2aBaxNtmGWiwxiQ/GLxZ+FX2kVmZj77jvvD/yE4ZodAd8So2Bw9r85CDGAPMjAMWb0SVID4APpj6HywXTePLQ0abyKqE0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 08:10:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 08:10:22 +0000
Message-ID: <698f4bbc-6253-2b61-ba82-68f6e7164ef6@amd.com>
Date: Tue, 11 Apr 2023 10:10:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v2)
Content-Language: en-US
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
References: <20230409185956.725016-1-bas@basnieuwenhuizen.nl>
 <20230409185956.725016-3-bas@basnieuwenhuizen.nl>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230409185956.725016-3-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d1e301-648a-4b19-ea15-08db3a643251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJLJ05cGLStXShRZOshgucUCByNsXCvG1zHTVMft1lG3f0zoYnlRuZeYbFExwGxU77Ot2ru5ax5CP/HGqaPC6egSHXNHEY8VONc6bmYTKXUNs+6LRchLIkfdDTa5BamQwawCIW27oxeoYw1XTFOm3p0z14Vq+HWMxUWZcGFVcdM9wOOh2jR5xwVIhP3JOb1whzFNjtEP1H8roFzwdqzcWOzBdfUBUQlSlwu57sDizsTP4vhSwgICwCnjlydthVlKbT0puSCB9Dx6XJCSRFvXoKqxiI/v6tf91yEzdLRwRegxqZ9MG1LFlaWen45a76cFM9M0Hazt0PiOQ3xuaFLkfIUBargzipI5GXIUKgNFq5LYX4LaTCxIsSRRuUXhUgq6Rv5Biubjt3biAtgOrF3Q4quotduCOvN3dJwJPDz5mi6B9hMA1d8EioDxcT0LqdNBNxBQfeqVzm14YTjEawxWyk/tV9hAEhjdcalZcQw5jox5HN9r+L4NQN8h7hQMxbxWq8ZO4V6HtNY1WzgUcTc13SpBEiqaHlhTb2pafc3JAYwdHpyLIkZIh/7b3sxjLakg+K2ZVfy1zVrmoxzVHREo5Cgr0vfX7qXT8DEZQ0qUsDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(451199021)(2616005)(478600001)(966005)(6512007)(6506007)(26005)(6486002)(6666004)(41300700001)(316002)(66556008)(66476007)(4326008)(186003)(66946007)(31686004)(83380400001)(38100700002)(2906002)(5660300002)(36756003)(31696002)(86362001)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE1HOENzNDYvZkNzSEFoR3Ayc0Jtb0hWZ2wwMUhOTE5GQ21Bb0NnVXVLN2Zn?=
 =?utf-8?B?TFRTSnR1ejMvem0vVnpJUjBkaWF4U0ZtOHFFSWtWd2ZIUHRLTWlLdzNDSEcx?=
 =?utf-8?B?aHRpbndETjlFQ1hJa2Z5clpOTWNPcVNZS3E2STNiY3BWa3NpaXljMFMzcVN1?=
 =?utf-8?B?UzV0Z0JtdEUyMEhHVVhkWXQvSzNXcENYNVVlN05IeFRpck5ReHdNTjZDLyt6?=
 =?utf-8?B?MDJGcVpYaEZOL05xeWlobDVXVVMwbTdLRS9yYmVwTVdjSUJLMHJvemdiUFJN?=
 =?utf-8?B?WC85bFUvRVp6T1I3ekEzdzhFY3NVUW1sNlRLbjdGR2ZMclEyMjB5amxvMHBH?=
 =?utf-8?B?cVJvMHZrZ3R2TzF5Sm9RSytkYkpWTG1UYTZqVkU2TlB4bFRWZVlUZlZ1OXRP?=
 =?utf-8?B?TXNSU0VUMnVXSUxMU0Q2ZW5TczZCWGxWMHAvdmo2c2U4S29rTENxSEQ2R2hl?=
 =?utf-8?B?WUJaZDBKRUhkOFg5K3BzTTNJb0JWby9GeUZrZGtlYk90U2VCLzh6VFoyRUZ6?=
 =?utf-8?B?am9hRGxHa2o5a1dOWDdldVRBTDY0LzhKM0I2eHF1UTFHWkIvT3VpaFk5YXl0?=
 =?utf-8?B?cnFtVGtzMWQvUmNRd01Uam5ac0Rnb2FOTHlvbWh5Z0F3YUN3cXlwWGZtU214?=
 =?utf-8?B?c0FPNjVSVHBtbS9QS2RtZ3pOWjNjdnZubElwMmgrVkVuUzlBTnVXamF4ekFO?=
 =?utf-8?B?NEE0R2xjTE9WZWZGOGZuVkYrZDU5NktDVFlhNm94bUpLbU5CTmpGUVliQksr?=
 =?utf-8?B?ZzJNVTZONjJWY01sTFo1K2cweHZKQkt5VG9EaWZNT0orSHhlZnEwRWFkc2I4?=
 =?utf-8?B?VlNpVWJISmlYc2xJamVSRjdxRWJvK0VIWUtiUXBBUVBjN3lVK0xOMVRHdVhs?=
 =?utf-8?B?RUhlOHJDM0ViSE5LejE5RFkvZExoNGxnV3prcVUySlNhWDJaeVJ5VXBDVEFF?=
 =?utf-8?B?UVRhMGZaVUp5SUdBY1JSUmJPanlCRUhBK2NUT2oxbG1FTi9PT1daeStqUGVJ?=
 =?utf-8?B?TFlQbUIvN2N5eG9KeGYvblA2cjMzdDVmSDRaazJRSHdMRTAwMm8xNDFNdEUv?=
 =?utf-8?B?S0tTenRhLzVydmViUmprL05oV25CdWhxamZHT2YwT0NQMlowS2lIMnAxTS93?=
 =?utf-8?B?OVdReWFjL0N3cWxjRUI1R0NOSURzU3RlRnROMUgwM0pyWlhxZ1ovODJMMnBP?=
 =?utf-8?B?SVdxOWVMZFJnRGxhOHQ3N3lFdDFjcjJ2M0U0aDdxUHF1OFA3RnJHSVNublhr?=
 =?utf-8?B?a3ZJYkloajZGRmU3Q3c4aWZkc3FsZTAvSVJ1c1lsQ2NIWHVVOGF5TjQ3b3Jk?=
 =?utf-8?B?VlgvK1lsbzVOQ24yVmh1UERkRUczSU1XNXVJenFIcU4ybUd1TjRKZjdoaDUx?=
 =?utf-8?B?TElmWUtJRWdNakE1UDNISlRnbWh4eU81VTN5R1hSTUg2RXltWmdPQXkrWGha?=
 =?utf-8?B?ZHZlQU5xbDlEME9aUHVYNjQ5TjR1TnVoNEJvQlE5TitBQmgxb2FjSnRadFJS?=
 =?utf-8?B?NE5RT1NPREk1aWhGYWMzQUdKUUEyZUtVenZvTUJsdmZWWDBoWHlKbkJFM1Vr?=
 =?utf-8?B?SzJsa2JSeU4vaDQ1UnlwbWlVQVllODZFZllkY1ltQlNsWE9qRFdVUS85LzRY?=
 =?utf-8?B?UEc3KzQ0QmQxRDkyeUgrdGtlR0RESHdmSlF4Q2YzdzR1TVl0SldBdW9WN1ln?=
 =?utf-8?B?V1ZDSWt0Smt5ZVpTVmt6Lzg2WmpZeDFhbzNZQi9BN2xMbllBc3FEOWVwaStP?=
 =?utf-8?B?ZWsyczkrcFJ6OTB2UTR3YVd5bkpQY1QweGduUXB6Z3lob0lJeXdsT1BHRU81?=
 =?utf-8?B?Skoza0xpTmNIc2Y4V0JsMFlqckFVWmlWMUdsV2VUU2xMNEtYdFhyNm1sc0xk?=
 =?utf-8?B?MS8yU20xVFBLMGFSRW5JOGgxL0oraGZsYnk1UEtyVGhnZmZ2S0ZTeFlKSmZz?=
 =?utf-8?B?ajZMZG5oeEM0cURNUHliMXp2a2wvczFwRDNVZDBpbitDbGp3OXlNbnE5Z1FH?=
 =?utf-8?B?dXpHZG5mS3lYbHhENkMvb0FaT25Pbks4YVNVK3dBMUp6RDNGOHdpdkF4ZlZn?=
 =?utf-8?B?V3h4U2ppOUgzVEhGSVhYNzg3VTYyU1hwKzhOelptUVB6Q0s4cHNhSlNjYU5P?=
 =?utf-8?Q?KtCLtvYK374F2dUV5ErkPRU4b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d1e301-648a-4b19-ea15-08db3a643251
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 08:10:22.0664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Dubcb8U0m1DZ/8duDfOusd2hPfFLN/lgS79hUyzdG1emTPPn0n4VvneYu/Qz/4G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151
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
Cc: alexander.deucher@amd.com, David Airlie <airlied@gmail.com>,
 maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.04.23 um 20:59 schrieb Bas Nieuwenhuizen:
> We need to introduce a new version of the info struct because
> libdrm_amdgpu forgot any versioning info in amdgpu_query_hw_ip_info
> so the mesa<->libdrm_amdgpu interface can't handle increasing the
> size.
>
> This info would be used by radv to figure out when we need to
> split a submission into multiple submissions. radv currently has
> a limit of 192 which seems to work for most gfx submissions, but
> is way too high for e.g. compute or sdma.

Why do you need so many IBs in the first place?

You can use sub-IBs since R600 and newer hw even supports a JUMP command 
to chain IBs together IIRC.

For the kernel UAPI you only need separate IBs if you have separate 
properties on them, E.g. preamble or submitting to a different engine.

Everything else just needs additional CPU overhead in the IOCTL.

Regards,
Christian.

>
> Because the kernel handling is just fine we can just use the v2
> everywhere and have the return_size do the versioning for us,
> with userspace interpreting 0 as unknown.
>
> Userspace implementation:
> https://gitlab.freedesktop.org/bnieuwenhuizen/drm/-/tree/ib-rejection
> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/tree/ib-rejection
>
> v2: Use base member in the new struct.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: David Airlie <airlied@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 31 ++++++++++++++-----------
>   include/uapi/drm/amdgpu_drm.h           | 14 +++++++++++
>   2 files changed, 31 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 89689b940493..5b575e1aef1a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -360,7 +360,7 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>   
>   static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			     struct drm_amdgpu_info *info,
> -			     struct drm_amdgpu_info_hw_ip *result)
> +			     struct drm_amdgpu_info_hw_ip2 *result)
>   {
>   	uint32_t ib_start_alignment = 0;
>   	uint32_t ib_size_alignment = 0;
> @@ -431,6 +431,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		return -EINVAL;
>   	}
>   
> +	result->max_ibs = UINT_MAX;
>   	for (i = 0; i < adev->num_rings; ++i) {
>   		/* Note that this uses that ring types alias the equivalent
>   		 * HW IP exposes to userspace.
> @@ -438,6 +439,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   		if (adev->rings[i]->funcs->type == info->query_hw_ip.type &&
>   		    adev->rings[i]->sched.ready) {
>   			++num_rings;
> +			result->max_ibs = min(result->max_ibs,
> +					      adev->rings[i]->max_ibs);
>   		}
>   	}
>   
> @@ -452,36 +455,36 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   	num_rings = min(amdgpu_ctx_num_entities[info->query_hw_ip.type],
>   			num_rings);
>   
> -	result->hw_ip_version_major = adev->ip_blocks[i].version->major;
> -	result->hw_ip_version_minor = adev->ip_blocks[i].version->minor;
> +	result->base.hw_ip_version_major = adev->ip_blocks[i].version->major;
> +	result->base.hw_ip_version_minor = adev->ip_blocks[i].version->minor;
>   
>   	if (adev->asic_type >= CHIP_VEGA10) {
>   		switch (type) {
>   		case AMD_IP_BLOCK_TYPE_GFX:
> -			result->ip_discovery_version = adev->ip_versions[GC_HWIP][0];
> +			result->base.ip_discovery_version = adev->ip_versions[GC_HWIP][0];
>   			break;
>   		case AMD_IP_BLOCK_TYPE_SDMA:
> -			result->ip_discovery_version = adev->ip_versions[SDMA0_HWIP][0];
> +			result->base.ip_discovery_version = adev->ip_versions[SDMA0_HWIP][0];
>   			break;
>   		case AMD_IP_BLOCK_TYPE_UVD:
>   		case AMD_IP_BLOCK_TYPE_VCN:
>   		case AMD_IP_BLOCK_TYPE_JPEG:
> -			result->ip_discovery_version = adev->ip_versions[UVD_HWIP][0];
> +			result->base.ip_discovery_version = adev->ip_versions[UVD_HWIP][0];
>   			break;
>   		case AMD_IP_BLOCK_TYPE_VCE:
> -			result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
> +			result->base.ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
>   			break;
>   		default:
> -			result->ip_discovery_version = 0;
> +			result->base.ip_discovery_version = 0;
>   			break;
>   		}
>   	} else {
> -		result->ip_discovery_version = 0;
> +		result->base.ip_discovery_version = 0;
>   	}
> -	result->capabilities_flags = 0;
> -	result->available_rings = (1 << num_rings) - 1;
> -	result->ib_start_alignment = ib_start_alignment;
> -	result->ib_size_alignment = ib_size_alignment;
> +	result->base.capabilities_flags = 0;
> +	result->base.available_rings = (1 << num_rings) - 1;
> +	result->base.ib_start_alignment = ib_start_alignment;
> +	result->base.ib_size_alignment = ib_size_alignment;
>   	return 0;
>   }
>   
> @@ -536,7 +539,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		}
>   		return copy_to_user(out, &ui32, min(size, 4u)) ? -EFAULT : 0;
>   	case AMDGPU_INFO_HW_IP_INFO: {
> -		struct drm_amdgpu_info_hw_ip ip = {};
> +		struct drm_amdgpu_info_hw_ip2 ip = {};
>   		int ret;
>   
>   		ret = amdgpu_hw_ip_info(adev, info, &ip);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index b6eb90df5d05..6b9e35b6f747 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1128,6 +1128,9 @@ struct drm_amdgpu_info_device {
>   	__u32 enabled_rb_pipes_mask_hi;
>   };
>   
> +/* The size of this struct cannot be increased for compatibility reasons, use
> + * struct drm_amdgpu_info_hw_ip2 instead.
> + */
>   struct drm_amdgpu_info_hw_ip {
>   	/** Version of h/w IP */
>   	__u32  hw_ip_version_major;
> @@ -1144,6 +1147,17 @@ struct drm_amdgpu_info_hw_ip {
>   	__u32  ip_discovery_version;
>   };
>   
> +struct drm_amdgpu_info_hw_ip2 {
> +	/** Previous version of the struct */
> +	struct drm_amdgpu_info_hw_ip  base;
> +	/** The maximum number of IBs one can submit in a single submission
> +	 * ioctl. (When using gang submit: this is per IP type)
> +	 */
> +	__u32  max_ibs;
> +	/** padding to 64bit for arch differences */
> +	__u32  pad;
> +};
> +
>   struct drm_amdgpu_info_num_handles {
>   	/** Max handles as supported by firmware for UVD */
>   	__u32  uvd_max_handles;

