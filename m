Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51525C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 18:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C914810E9A6;
	Wed, 26 Jun 2024 18:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qZyXPGNY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A6310E9A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 18:59:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWIs30xZYMW0W2SDEb7qffNCIwf2CIMpyHOIDlUVKIFRoScMNbnKQPAA9uIn4IfxLWiLnukTRjUpgh/UdCct8h0XnBHuckx4A0xcOiDNyHFpw7zAY8aHbH0cm714+snSstylXJ1rpKYYH8HI/MiOHrcbMpt1LhAMN3stbwtkPRYOwS2V/ZUEFj4QuGjkv4wSymjIEhDcQpwNBpHBq6BD2H8R3rTNPoXbv8w+H8HO7jPf128T7lPbD5j3k6KvEU5VgCy4sJ3M6lsqqEOmBMhhMAE5PuJTQe8ktGNSNxKyB2t6EjGnieKc3aFS7eCAEuv2mV2MLJqwkgA++VnCwRXljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj4NwGphCTttHeZV8gtYjuRkLK36EMFMW9XFbbni/pY=;
 b=N7vd+SMNUWWgtUNzZSGKb7FcIcAQROkVPyezFR0xOwSF/JmIW8SP9U68Nfa1nQ9QlZGKJpeCwU7bm+Z0ZyEXMYLMRq/81OPl0yQeVEcevpbfwRVKVX5/C3oUYffStIDaGOqCuXijyuD7TyWTwhg7Qk9/ayXgmwPmdG3dOk3VNQBSWqh8wFJ16ipPZ5TS+MA3XuJhCfYobzw4ikCq906ft2Wznb2z2gpmplXSU8RcKJukZI2VhDRBg69GULZtEB2n+m7qocdMMU2ZH9qTbngFuFI9TfuhK+MFl4BATRczt3gEscLEInxM/oo2i/xMmznDrTp/YZXRb2g4sV23spyZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj4NwGphCTttHeZV8gtYjuRkLK36EMFMW9XFbbni/pY=;
 b=qZyXPGNYeL4VQiCE35PymJoslTOCZTlzowXEsKHfIXyrb8pyJ2NagloQ1GRE2Rsb8WNJn9JW5/bzj2nOLm7pZQ5gOi0fu8Xma3rhCd8dbMPVjtN/w8gYjr93wQNHj7DgOwdKWtyJWNTvpg/Y1eOnc4yaXC7SGDyHJmbTOXJg/2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 18:59:08 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%7]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:59:07 +0000
Message-ID: <a3186b41-d400-41de-9edb-4922d9ab0035@amd.com>
Date: Wed, 26 Jun 2024 14:59:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/jpeg5: Add support for DPG mode
To: amd-gfx@lists.freedesktop.org
References: <20240624175820.1508394-1-sonny.jiang@amd.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <20240624175820.1508394-1-sonny.jiang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::27) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8b3062-e758-40f0-3b75-08dc96120e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|1800799022|366014|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHU5Y1JadnQ3Q2lqVitlR2dNUlJmazl1dW1MRHBuRWowTm9KVlZuTm9FU09r?=
 =?utf-8?B?ZUpES2NBZTMzSXlPN2hpanAwZ3BuVGFhblMrUnBnazNnVUphYmoxazBYMFB6?=
 =?utf-8?B?UkdlOTZnbUxLdmk5UWtCVVBhM1RCZkR6Q2xhY2tHaXNJVU1xMmdxWUdTbHNi?=
 =?utf-8?B?SmJWSVNNOUZKcnlyZmc0MXZTOTZHVkJQOUdjT2xENmtrQkV0Sk5wMzFOMmJr?=
 =?utf-8?B?NUVUcDNPbU1MaEdRVHhuLzdiSEZtYVhaekd5RGdxbUk0SlJESFZRSS9LWEw5?=
 =?utf-8?B?c2RJSmMxV1J0RmZHdFpmTThFSHU0RlJGS0ZabkJpR2FSS3R1MFErZWd6Nm5s?=
 =?utf-8?B?OWg1V2ZxS0h5K01YTUVWODd3MUJRdHV5M1JiZXRlWDhuUUQ1UWdjV01FWUpp?=
 =?utf-8?B?UlkvQ0lNTGFUT0lsTkxWMXF0ZWlYUFFzOU9aMHFTYUlBRVRxQURUZE4yWk5a?=
 =?utf-8?B?MCtvZ1V1WFBOTWJ0S1FXUWlienF2ZjhKcEQxbXhldytxeE42bHlkV2VqRWFQ?=
 =?utf-8?B?QVo2bXhHeHUrTTU1SFZKWjl1MW9WMTV5ekFQMkFuWmYrUHVLSktJL21WNWw5?=
 =?utf-8?B?NkgrR0JRV2tQVnBQYno5ckpiYkRiTW5MMDRTSEZlcEczVUhNM1Z6S2loclFx?=
 =?utf-8?B?VXR4K0VraUJrYVZINXlRRUs0dDBldU4rL2V0d3NBa3kwZnhnYzN2WlFRTnFC?=
 =?utf-8?B?RUQxRUhvWWZuQmVIaEZyMTZqN3A0RCtKYzJYTFRpdE5GRC9QMDRMb290Ymcy?=
 =?utf-8?B?emFXaTRQYUJGREJUc2NVUk1RS0N2Yi9mamhlV3NqY1laRjdvVFN4ZFJKcTUx?=
 =?utf-8?B?ZmpkU3ArQWQweklCVXRYM1ZWdTFKRGpUUXRwdHVRa0NzWE5IZEFoc1Mrem5x?=
 =?utf-8?B?bGtJLzR0bWN1UlpudG1sUXIxbkprejY0OHU4aW5SU25qZGgxUjM0eFIvNDE1?=
 =?utf-8?B?M2p0WnFJbUdUd3BZMTBYRVIzckdBSjhDdkY3TEVHYzAyVlR3NnVCQTlQZW9H?=
 =?utf-8?B?aU1GVFJvZjVzMEdYc0VxdlV1aFpKcENKNDJ2RGJzbGV3NE5YTHgwVzVGSmV5?=
 =?utf-8?B?M3FIK2ZFZlNQZm4xd2F4RFdWMFZGTUhJVTVVOW4raTJ1NXpWUVdBSjNWOGRJ?=
 =?utf-8?B?bzhvNzA4N1NrNDk4STA4QktLbHUzTXJQd3RuRlh2Tk8va0ZiRWQyUHp1UzJp?=
 =?utf-8?B?Y0s4Z1dkdW1wbEFTeDQzTXB6bEpMT0tMNlArRmFTbTdvSlo1WHhYc1pobG5H?=
 =?utf-8?B?V3ZnZkJHRTgrcm1RdmVVQ0Z0Sm9IODVJenM1WG5ENFdvMkxEZzNrVW1Uclh2?=
 =?utf-8?B?ckNibzNzMGJwVVBJZUYwQjdRa0U3K0dzeHZzQU4vRURCenVjVmlZWnJpRytJ?=
 =?utf-8?B?bC9iRHZBQlhPbzBiZTFXbkFnYWF6RmNpL2p5cjZteVJoYm55RXhSb0hhUktD?=
 =?utf-8?B?U1ZFU3B5RFVYVzZtQVdPTUJPMFl4MU4zOUFnY0VFU24zd0kwcnZhb0duY1FV?=
 =?utf-8?B?QjdndTBCNDY4RVJPazMxZVZmYzVJc3IwNFBGSHF4cVZGL3ZYbXU3SmhXRjNN?=
 =?utf-8?B?RXlySzBNQkxtcEszcnFLc2ZwbTNvbUhORHI2UklDSGJSTVFEYnZYdGVDRTJP?=
 =?utf-8?B?d2tXYlJ4RlpqRWxSeE1lZDBBWDh5WWdJM1dXYytLMGt1bFlxTm8yemE3Q3pI?=
 =?utf-8?B?YTJjeVkxOUtYR1djSmhqU3JWSFZEaDFZUm9ZeXczMXoyZCtmWXU2Y0NhOUhv?=
 =?utf-8?Q?fSElR0vl6TRQq/wQcU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(1800799022)(366014)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0FWWGgzdCtKMzBZbWFNTVF6STJMWW96RGwvcE9RY3FHbkNXaDdsQ3B1WU9U?=
 =?utf-8?B?YVNYWGFBZWw1TEJnNEVNdzh1bmE5QW9RQ2NNWnlYM3lUQUFuVWQxc2NUZVhL?=
 =?utf-8?B?T1ZJSTA2Sjg5aUVBdkFpcGQzbXBMelFTWnlFekM5VWJnTHB3RUdNUGtLMitM?=
 =?utf-8?B?bzY1djV3cTVRakUyTnpXT2RyQ055RHdSQzQ0blVpT3EycERnME9CbVJEWFNQ?=
 =?utf-8?B?TTU5TkFBRFpuNVVkcVFoc0t3ZWl0VC9Md2VUclRQdStjc005WHFOK1d1WW4z?=
 =?utf-8?B?M0hQL3VkbHpISm5SN0ZibFMrU2RxdjRzT2xqTW5yb3Z0QVB6RDdhamZWbVJo?=
 =?utf-8?B?Uzc2dnUrSzY2Qi9PanBqOWYrOHY0YWFUVTROczVwZi9NUi9nQ2IrZldIY04v?=
 =?utf-8?B?TG5HSG0yZXB4bEI0Y2pJc24zcTI4MlAzWUdVV3NGbEtGV1lQR1lySys4NFV0?=
 =?utf-8?B?cnRPK1Z4K0ZPUm1QRjRCRnJMOGw1OU80QmJGbVhoeGVtNFhrRFFubTdmeXZT?=
 =?utf-8?B?ditaM0Jxa04wSk9VRjBkNWpBMjlPUGVYUDc1b0JhOFFyRm4ySGVkVWxDanRD?=
 =?utf-8?B?UkphaU94RG5jKzBwSFdTY0pjTndrZ3pNbjhQY2ZsUGhRU2JsUmdDOTAyNTZL?=
 =?utf-8?B?NlJOeXVPaituWkp6eTVDeHlaUjRnNVkvbCtzVGJxSk9yOENpb1psUWJ1LzVs?=
 =?utf-8?B?dDJwNU90M3hMeXlTNFRtT0ZUTGYrUW5oZzkvdkFZUGZzMjBpZUJoaXdMbm12?=
 =?utf-8?B?OXFaMEVrNUpmUWdKMGtTMVdjZGpDMnZ4Zm9BcXZ6NkxSQ2ZSZmo2MXFHWWRP?=
 =?utf-8?B?NEhSSlBNWVFhaFN3V2NkVHd4ZHRlait2SkVvM0dJSlBIU01BcUFzelBqcU1X?=
 =?utf-8?B?OUJCMDhTd1BMbGRtSmdOR0lldWVQSFFMRG1BMytta2x0c3B1TGQwcG5NZVlX?=
 =?utf-8?B?eXdpZVp6NGFXcHZ2QmVEdGwzSk5ZVVVTb1JCemIrcjg4MnBGRGYwNWg3ZFN6?=
 =?utf-8?B?S21tdDlUaVdRVTczT1pIL3dpVU5xUTFEUGZCdGFPK3liVHNtS0NPZXd0ZU1s?=
 =?utf-8?B?L2dRU0Y1aXFaQ2NqZ0JITnNHYkFtR2lnRFQzcUt4bFVZZThIRG55akV4dG80?=
 =?utf-8?B?cXM2d0VFd1ZoRnJvVlhTRmZHTC8yclZRTHpDL1dJd2lISWNNZVZqaFg4eHFt?=
 =?utf-8?B?NitqK01CWTlsZUlNT1l2NE4wZHN4c0FYZTZJZ2dhUWs1Q1FxU09PZlJOTDhJ?=
 =?utf-8?B?cmlkMTNGVkQ5NmRIV0x4TTBFRlNaOWs0RFhXdkYrL3hxajJSZkhINGJLVWJr?=
 =?utf-8?B?aHVlclZYUWdTOFA2YWRIQjY0bXFKVU94V3ZzbTZjODlxWXFHc2xjT0lrMzFw?=
 =?utf-8?B?MGtsSW1ESWtBa2hYWmh2MUdEdmdaZXZ4c2NNZXZlRHVsajZ0Zko1c0ZzQ2xS?=
 =?utf-8?B?NzZHUDVSY2hkVmdMOGptZHlvWkoraVNXdlBOS29jb1FBWUlRYU5IdXNIZG1Z?=
 =?utf-8?B?anFiZlBPakJ2MG0vSmhvNEswdHplb2o2eFlJN0FlZTc1Q3cwMHpweTl0YzlW?=
 =?utf-8?B?UGk4S0srVWZxTzNqbE04SFYwUEpPbnE4NGQ1SFAxQ3VNQW4xMm5sNFQ2aHlN?=
 =?utf-8?B?Z29KUWF5Z1drT0lUNmp4M0kyMFBCaTV3R3NxeTU0TlZCT3d2dmoyWXZnRzB5?=
 =?utf-8?B?YXBBNWRrN3U1aXVkeXFFZ1JnbjRuVjlFd2hnUUthODl4eWZZRS9tR1gzWVVv?=
 =?utf-8?B?V3lNKy9tNXdwT2w3bHplT09iUGsyaVRHWlFJT2JWdTNndFl3dWZFeEh4anlm?=
 =?utf-8?B?dnE2VHRnOHJoOStJRFJGYTNUZmdBWU10TVVCS0JzWmRSeUp6VHFNbmhmaGVB?=
 =?utf-8?B?ZDc0MjZvOHloaFpNTThFTHVHUStzK3l0M1RSNU4rS0Q1TVNoQzZNSDZNSlBH?=
 =?utf-8?B?NGRNNldTYVd3dVNUTUZydTZPNE5QY2FKcXNZaytEajZCVXNuQ2pTWjJrRG1i?=
 =?utf-8?B?L0lCVEZJcWtJME5rZVNIVGNDUEtPTElic0RJOW5LT1AvRUI0Zyt5Szg4WHQ5?=
 =?utf-8?B?N0F4aS8vZVZLTzhOUVg2eEltdGV5Q1M2bUJBakpIemdoaW9vYUJMVTBZYWRk?=
 =?utf-8?Q?IOpdr/GmPXEQuVvo70iJYB9O6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8b3062-e758-40f0-3b75-08dc96120e7b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:59:07.8325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrZz8JL+t+b/6d7aVTRZQAoIMVJcr/tmAfmFy3Z/3oqADivnu4PohniG+VMcySZAMZbpNT9/83ExPE8rM1ghtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
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


On 2024-06-24 13:58, Sonny Jiang wrote:
> From: Sonny Jiang <sonjiang@amd.com>
>
> Add DPG support for JPEG 5.0
>
> Signed-off-by: Sonny Jiang <sonjiang@amd.com>
Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

tested fine as well - thanks!

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  31 +++++
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 159 ++++++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |   6 +
>   drivers/gpu/drm/amd/amdgpu/soc24.c       |   1 +
>   4 files changed, 180 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index aea31d61d991..f9cdd873ac9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -60,6 +60,37 @@
>   		RREG32_SOC15(JPEG, inst_idx, mmUVD_DPG_LMA_DATA);				\
>   	})
>   
> +#define WREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, value, indirect)		\
> +	do {									\
> +		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
> +			     regUVD_DPG_LMA_DATA, value);			\
> +		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
> +			     regUVD_DPG_LMA_MASK, 0xFFFFFFFF);			\
> +		WREG32_SOC15(							\
> +			JPEG, GET_INST(JPEG, inst_idx),				\
> +			regUVD_DPG_LMA_CTL,					\
> +			(UVD_DPG_LMA_CTL__READ_WRITE_MASK |			\
> +			 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT |	\
> +			 indirect << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT));	\
> +	} while (0)
> +
> +#define RREG32_SOC24_JPEG_DPG_MODE(inst_idx, offset, mask_en)			\
> +	do {									\
> +		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
> +			regUVD_DPG_LMA_MASK, 0xFFFFFFFF);			\
> +		WREG32_SOC15(JPEG, GET_INST(JPEG, inst_idx),			\
> +			regUVD_DPG_LMA_CTL,					\
> +			(UVD_DPG_LMA_CTL__MASK_EN_MASK |			\
> +			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));	\
> +		RREG32_SOC15(JPEG, inst_idx, regUVD_DPG_LMA_DATA);		\
> +	} while (0)
> +
> +#define ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, offset, value, indirect)		\
> +	do {									\
> +		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = offset;	\
> +		*adev->jpeg.inst[inst_idx].dpg_sram_curr_addr++ = value;	\
> +	} while (0)
> +
>   struct amdgpu_jpeg_reg{
>   	unsigned jpeg_pitch[AMDGPU_MAX_JPEG_RINGS];
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index e766b9463759..d694a276498a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -31,6 +31,7 @@
>   #include "vcn/vcn_5_0_0_offset.h"
>   #include "vcn/vcn_5_0_0_sh_mask.h"
>   #include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
> +#include "jpeg_v5_0_0.h"
>   
>   static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void jpeg_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
> @@ -137,6 +138,10 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>   	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>   			(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
>   
> +	/* Skip ring test because pause DPG is not implemented. */
> +	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG)
> +		return 0;
> +
>   	r = amdgpu_ring_test_helper(ring);
>   	if (r)
>   		return r;
> @@ -235,7 +240,7 @@ static void jpeg_v5_0_0_enable_clock_gating(struct amdgpu_device *adev)
>   	WREG32_SOC15(JPEG, 0, regJPEG_CGC_GATE, data);
>   }
>   
> -static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
> +static int jpeg_v5_0_0_disable_power_gating(struct amdgpu_device *adev)
>   {
>   	uint32_t data = 0;
>   
> @@ -248,14 +253,10 @@ static int jpeg_v5_0_0_disable_static_power_gating(struct amdgpu_device *adev)
>   	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
>   		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
>   
> -	/* keep the JPEG in static PG mode */
> -	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS), 0,
> -		~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK);
> -
>   	return 0;
>   }
>   
> -static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
> +static int jpeg_v5_0_0_enable_power_gating(struct amdgpu_device *adev)
>   {
>   	/* enable anti hang mechanism */
>   	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_POWER_STATUS),
> @@ -273,6 +274,121 @@ static int jpeg_v5_0_0_enable_static_power_gating(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static void jpeg_engine_5_0_0_dpg_clock_gating_mode(struct amdgpu_device *adev,
> +	       int inst_idx, uint8_t indirect)
> +{
> +	uint32_t data = 0;
> +
> +	// JPEG disable CGC
> +	if (adev->cg_flags & AMD_CG_SUPPORT_JPEG_MGCG)
> +		data = 1 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +	else
> +		data = 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
> +
> +	data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
> +	data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
> +
> +	if (indirect) {
> +		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
> +
> +		// Turn on All JPEG clocks
> +		data = 0;
> +		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
> +	} else {
> +		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_CTRL, data, indirect);
> +
> +		// Turn on All JPEG clocks
> +		data = 0;
> +		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_CGC_GATE, data, indirect);
> +	}
> +}
> +
> +/**
> + * jpeg_v5_0_0_start_dpg_mode - Jpeg start with dpg mode
> + *
> + * @adev: amdgpu_device pointer
> + * @inst_idx: instance number index
> + * @indirect: indirectly write sram
> + *
> + * Start JPEG block with dpg mode
> + */
> +static int jpeg_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +{
> +	struct amdgpu_ring *ring = adev->jpeg.inst[inst_idx].ring_dec;
> +	uint32_t reg_data = 0;
> +
> +	jpeg_v5_0_0_enable_power_gating(adev);
> +
> +	// enable dynamic power gating mode
> +	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
> +	reg_data |= UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
> +
> +	if (indirect)
> +		adev->jpeg.inst[inst_idx].dpg_sram_curr_addr =
> +			(uint32_t *)adev->jpeg.inst[inst_idx].dpg_sram_cpu_addr;
> +
> +	jpeg_engine_5_0_0_dpg_clock_gating_mode(adev, inst_idx, indirect);
> +
> +	/* MJPEG global tiling registers */
> +	if (indirect)
> +		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
> +			adev->gfx.config.gb_addr_config, indirect);
> +	else
> +		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_DEC_GFX10_ADDR_CONFIG,
> +			adev->gfx.config.gb_addr_config, 1);
> +
> +	/* enable System Interrupt for JRBC */
> +	if (indirect)
> +		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipJPEG_SYS_INT_EN,
> +			JPEG_SYS_INT_EN__DJRBC0_MASK, indirect);
> +	else
> +		WREG32_SOC24_JPEG_DPG_MODE(inst_idx, vcnipJPEG_SYS_INT_EN,
> +			JPEG_SYS_INT_EN__DJRBC0_MASK, 1);
> +
> +	if (indirect) {
> +		/* add nop to workaround PSP size check */
> +		ADD_SOC24_JPEG_TO_DPG_SRAM(inst_idx, vcnipUVD_NO_OP, 0, indirect);
> +
> +		amdgpu_jpeg_psp_update_sram(adev, inst_idx, 0);
> +	}
> +
> +	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
> +		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> +		VCN_JPEG_DB_CTRL__EN_MASK);
> +
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_VMID, 0);
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
> +		lower_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
> +		upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_RPTR, 0);
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR, 0);
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_CNTL, 0x00000002L);
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_SIZE, ring->ring_size / 4);
> +	ring->wptr = RREG32_SOC15(JPEG, inst_idx, regUVD_JRBC_RB_WPTR);
> +
> +	return 0;
> +}
> +
> +/**
> + * jpeg_v5_0_0_stop_dpg_mode - Jpeg stop with dpg mode
> + *
> + * @adev: amdgpu_device pointer
> + * @inst_idx: instance number index
> + *
> + * Stop JPEG block with dpg mode
> + */
> +static void jpeg_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +{
> +	uint32_t reg_data = 0;
> +
> +	reg_data = RREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS);
> +	reg_data &= ~UVD_JPEG_POWER_STATUS__JPEG_PG_MODE_MASK;
> +	WREG32_SOC15(JPEG, inst_idx, regUVD_JPEG_POWER_STATUS, reg_data);
> +}
> +
>   /**
>    * jpeg_v5_0_0_start - start JPEG block
>    *
> @@ -288,8 +404,13 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_jpeg(adev, true);
>   
> +	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> +		r = jpeg_v5_0_0_start_dpg_mode(adev, 0, adev->jpeg.indirect_sram);
> +		return r;
> +	}
> +
>   	/* disable power gating */
> -	r = jpeg_v5_0_0_disable_static_power_gating(adev);
> +	r = jpeg_v5_0_0_disable_power_gating(adev);
>   	if (r)
>   		return r;
>   
> @@ -300,7 +421,6 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
>   	WREG32_SOC15(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG,
>   		adev->gfx.config.gb_addr_config);
>   
> -
>   	/* enable JMI channel */
>   	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL), 0,
>   		~UVD_JMI_CNTL__SOFT_RESET_MASK);
> @@ -340,17 +460,22 @@ static int jpeg_v5_0_0_stop(struct amdgpu_device *adev)
>   {
>   	int r;
>   
> -	/* reset JMI */
> -	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
> -		UVD_JMI_CNTL__SOFT_RESET_MASK,
> -		~UVD_JMI_CNTL__SOFT_RESET_MASK);
> +	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG_DPG) {
> +		jpeg_v5_0_0_stop_dpg_mode(adev, 0);
> +	} else {
>   
> -	jpeg_v5_0_0_enable_clock_gating(adev);
> +		/* reset JMI */
> +		WREG32_P(SOC15_REG_OFFSET(JPEG, 0, regUVD_JMI_CNTL),
> +			UVD_JMI_CNTL__SOFT_RESET_MASK,
> +			~UVD_JMI_CNTL__SOFT_RESET_MASK);
>   
> -	/* enable power gating */
> -	r = jpeg_v5_0_0_enable_static_power_gating(adev);
> -	if (r)
> -		return r;
> +		jpeg_v5_0_0_enable_clock_gating(adev);
> +
> +		/* enable power gating */
> +		r = jpeg_v5_0_0_enable_power_gating(adev);
> +		if (r)
> +			return r;
> +	}
>   
>   	if (adev->pm.dpm_enabled)
>   		amdgpu_dpm_enable_jpeg(adev, false);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> index bd348336b215..5abb96159814 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
> @@ -24,6 +24,12 @@
>   #ifndef __JPEG_V5_0_0_H__
>   #define __JPEG_V5_0_0_H__
>   
> +#define vcnipJPEG_CGC_GATE                                 0x4160
> +#define vcnipJPEG_CGC_CTRL                                 0x4161
> +#define vcnipJPEG_SYS_INT_EN                               0x4141
> +#define vcnipUVD_NO_OP                                     0x0029
> +#define vcnipJPEG_DEC_GFX10_ADDR_CONFIG                    0x404A
> +
>   extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;
>   
>   #endif /* __JPEG_V5_0_0_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
> index a15673e2dc99..d27fb4ea6612 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> @@ -428,6 +428,7 @@ static int soc24_common_early_init(void *handle)
>   
>   		adev->pg_flags = AMD_PG_SUPPORT_VCN |
>   			AMD_PG_SUPPORT_JPEG |
> +			AMD_PG_SUPPORT_JPEG_DPG |
>   			AMD_PG_SUPPORT_VCN_DPG;
>   		adev->external_rev_id = adev->rev_id + 0x50;
>   		break;
