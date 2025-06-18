Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9444DC7115B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 06:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD3210E725;
	Wed, 18 Jun 2025 06:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iyWCr8to";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A03010E3FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 06:08:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7NDfjkiWALH0YX8eHaVJ0gKZndzmt445QevfVFq49BAMJg9R3Ks/m4ILEFBXjZlrXjOYa1tv9EH/qFAiyMT36vfXHlMXURDFDrCF6/Lo9aT7sGBWtGyi1bPvHdL2tFoLJ81jULT7tM6c7tulxFItEqqNge6mFEXqqTHudN4USqtgNMCmCg7Y0nWN7TLazhKw1jP/FRANg7p7pnitP+5vD5PbHB38zgoXxDan/U9/yIowQqVZbZ8uKvaQ99mzgEh6RO4XZnxy5EUZXDu/7EsnvKmWmyzfSlJ3j1SE/uaAkWYVZHNvRJ24IPRmQwtRjAqIJeIlXfQxxdSJLeJAy9D9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCYgTv9ooZgnuzD5BfRcsCmtvXHvaKx5xrD9QjvypNs=;
 b=KvarSM3/3OyBgVQLcAVieU2tJJU++Cn7O5jqGRLZ3P0awa0Jt8Xf00Ua5Q1IW2cz1MEr3kTBxd5kKgAgOTacCh+Y6RTRKGB9PXY2PIZU9qwTaQoBjZFAAvnWg8MdeT2m7XXPQXykBJuRDTmGhHlOCJoZOBlctEmvBkfJ/xiPIDctkQoh5Uetup2hyaTpqDFsZvJ8HW8ofm4xlZz2cjI2rJiULWz7SWIMZDFMG5dEO3qh0F18zlyZlk51hWUWOgTLliwUdCiJy1gPcbzFtdJJxUEqfixbFQcyTtW5OKXf+/TGAyDY+jH+4cJWiDf0WaWL8WJNhhccyJ7VwlIBhNZ7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCYgTv9ooZgnuzD5BfRcsCmtvXHvaKx5xrD9QjvypNs=;
 b=iyWCr8toQdg+PhAblOr65GvbxQTyn1NJxtRzNew5GJrBIEYCHmp7uESHWUJAeXeO+f+C0YqW5gR0iIPaNW7lfYVKCBDIq7GJldJ/a/iKMaEsuTf312M1t6LgvTPYpfXd433G0CV1WOKBoQiLp8iEawRET+J7Ea51HIEl7NuCUyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 06:08:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 06:08:31 +0000
Message-ID: <f5fe0da2-18af-40ae-bf30-f4865495abc6@amd.com>
Date: Wed, 18 Jun 2025 11:38:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
To: Meng Li <li.meng@amd.com>, amd-gfx <amd-gfx@lists.freedesktop.org>
Cc: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
References: <20250618055243.1128889-1-li.meng@amd.com>
 <20250618055243.1128889-2-li.meng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250618055243.1128889-2-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c8676d-b70e-4726-e092-08ddae2e8ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW1VZzQ3TGxpUG1ITFFFK09RbUJPWlZuUmNZaTVvOGpBcy9PRmIrZkIyb0s4?=
 =?utf-8?B?L0F1S2kvaWd3V2RXTnA2dlBjcGNEcFk3VENsbjJzaWJiT0lFa2JaMGNJWGtS?=
 =?utf-8?B?UWp2VGl0QTZ5UFRBaUJPc1FlOVNMenJzWTMwNzBaV1ByVzI4VG5RRThBV1lv?=
 =?utf-8?B?K0NvN3l2bHA2S3p4cm56ZnViWlNxVWFUM20wUXJ6RGhlcWQzRktLeTlHUGhw?=
 =?utf-8?B?bnBaMzdta2l2dW9BMGNYekdWWEx1UWloeEZGd1ZDaGdBSWM3SzFreitTWDI4?=
 =?utf-8?B?M2o2M2pxcFVJYWZ1cXhSNkplaUZzbytTVHREMzNrU2NNcG5vcVNVbkV0Y2RO?=
 =?utf-8?B?eHA0ZDlGOHRFaGp3ckJDaGE4WUV3cVBnK2w0cU5BTVRhZ3pYbmVYNGw2Vzdj?=
 =?utf-8?B?c211MjJMSTZxQzgvdzk4cU12b1daQkdoTUVVekZEcTJBeTVLS2RmV3ZhZXlw?=
 =?utf-8?B?WUVLSk5yL1JYUk1URVkyc2JxbWtXY1dETWc1aUIweTdTNXJyZi9WMU9sMzlN?=
 =?utf-8?B?ancyZUV2UTlCaGYxS1JqUm9qeGNYMTVXa1JoRytGWWJUZjk1Z3hQdUNiUURQ?=
 =?utf-8?B?RkNrN1dsVXkyVFE4RmlwUVpRY05EUlZLU2M5ay9QTlBtS3hyTldXYjRLdUhW?=
 =?utf-8?B?RmdLUEFqUWtUeGx1L2x4SFpvc2R0R0lRb0JSK29MRlAyVlFzQUpHSTAzMXFT?=
 =?utf-8?B?WmlqTDV5L1BCWmxnNUUyaE1qMXpVSnRNSEhFaHAva25zNlZYT1M2Uy9UWG4r?=
 =?utf-8?B?aUo5RFBxZGRiaHFnazVRc245N3NGQitjbHlTc3IwSUh2RHdjL29aaVpmZmZE?=
 =?utf-8?B?ejR3Z1ZvMjU2cjV0Z00xWlVFV0RKWFhxR1BGRy9McWxid1AyN294VVJ2MjhD?=
 =?utf-8?B?QjlRcW1hUFJsNC8xSEdzNFRJSkVlWXRobEZESTREWENsS21wTGluL3Z3Rms5?=
 =?utf-8?B?UmxNWGFrN2pQSGMvaDdqNlE1VTdtOTJoR3E4R0pQUk1BSWFpT001WkJ1OVcr?=
 =?utf-8?B?aURvbTVjdHJqeVRCNEh3R29nSXpiZW5TVjlVcW1LUWZOcktObGMxbzJsS3FG?=
 =?utf-8?B?aWo1Slc5R1l0SWZlRUIybWYwMWRXOHk5VmtxK0J2dWxlZldEajdDY0hQRGJr?=
 =?utf-8?B?dWgyN2NkU2NzcEZWRDY5Qkp4alZzTGpjTmFnYi9EODZ4VHpsNWxVajZvTmE0?=
 =?utf-8?B?aGVWbHBZdGRnV1lldVBKTnJPTUk3dGFhNlRYN0dkWHlKa1pyTk9IM3NhdXJT?=
 =?utf-8?B?ekZ0VVBCMmhGTmkvczdJQk1VUG5VaDlBbHNpazk1MSthZnZKbXc5akxrMlRx?=
 =?utf-8?B?ZnFUdVV3OEFCSmRUWkhkSVZ6K3NGTWxSQU4vRGJwdlRWRTk4U2RubUNoWVJ1?=
 =?utf-8?B?V1pPZGZvaGl5UEZnUnpkMnlYNThSNjJyZCtoY0hCNkJVMm5KU1Y5RHprUXEv?=
 =?utf-8?B?cFhOb3p1NW92eGxVSE5hK3ZzVXVZeUJDeHVSczVtT3UyM09ITEY1WndqWGNC?=
 =?utf-8?B?ak9WR1BhK2YzbjI1eUVQKzB4eEhpejZsVnI0Ni9SZ1pOWGNGMHdwQWhNaGlw?=
 =?utf-8?B?eHIyR1Z4NmJ4UXp2Qk9Ud1RKOEJHSWtFTk80WFZscmwvWm1xeSttQkY1c0s4?=
 =?utf-8?B?MmZ0M2RvZ2YzdjF2enRtTVgwZEtTQjgzZnBvRTVlOC9ZMjBXdngwclFmQ1Np?=
 =?utf-8?B?dXdqMmp3VE9CdUhQYVk0VnJGMWt4djRXTDNGRUVTc1dHWGZiYjhxendQajN3?=
 =?utf-8?B?SjkxWTgrS2lTL04xWnU1MmpFYWhCN1c0ZDdjb1dDRUNydEJTdHY0V0dQSXNZ?=
 =?utf-8?Q?IsosVy7em4/utVv8rmARFxu71n5vF2RuIRAEc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFFZkx3ZkVxSnZkc3ViOXFaSmZPUHV4NWFERVJjK1RGYWw2L3FLY0NaVUha?=
 =?utf-8?B?UEprb01YNUtBb0tkR2xRYVFXK1dZSU0yd01ad1RLOXZUVUVWdmFtSWovazlr?=
 =?utf-8?B?RGprZ1JMVFN5eU9sT0xQTkN4MFdKSFd4Z0poL2tZNkN5STJVM2plWFNtMklV?=
 =?utf-8?B?SWhvSTNUemxMRG9UVGFqdm5Yd2Z4YURHeFVHZVUrbEMzeEUrbWdBZ3Bhbkh4?=
 =?utf-8?B?RmpHNU05L21aYi9ZUHhjUUJCZ0hIYkgwUG9FeStFZE00ZUdicWZWUitvbzBq?=
 =?utf-8?B?R2tXZG5MdndXa0x0aWVDNzF2R0NEUW9lTlZQSHVPeU93YURTUVdiUXJReVBQ?=
 =?utf-8?B?Z09NQTJSbXp1RzZCMmNCUGp6aDFtYzFadmNnOWNKVEFkTmZzcTV4emJ1d1FP?=
 =?utf-8?B?dnFoVlpTUGhMU3psUEJKUDZXZzI5WkkxaEFMUmJuZ3Qwc2IyQWtlZnVyeUhJ?=
 =?utf-8?B?MjFaSysxeHNBa1RFQTVPNjNJL3lKOFh1TG4za2F0NnVIZ21WMnU2RS9jaEJY?=
 =?utf-8?B?ZGxaa2ZNaTRmOFhHbVVuWWk2U3hrWFZibi9mSFZIM1FoT2ltMWpUcGZ4RHJn?=
 =?utf-8?B?N0R5MU1vMnhadmlwemJSOTNRU0x1cEZrUWtIZlBiNnR5THJmcVFSZ1ZLTlFE?=
 =?utf-8?B?dTFGNjZHNU83V05hUi90UzhubE5OQzJRMGV4SnV5UWcvSHYvR05xMVAwUkQx?=
 =?utf-8?B?V2pncFpiRjRZOXUzUktGckFVSXAyRTVJcXMyZ0Q2R3pyQnluanE1b3NaNHF0?=
 =?utf-8?B?cG4xSUdJQitla3ROVXBDck1keThnSWRkNkxOMDJSaTNwMGN0TDB6MG1rQ2Ji?=
 =?utf-8?B?UXhOM1NmNFlDUzVVUVZjbkltc1V4a3dPRXh0cFJNbmdkYVM2UTZjVWo1VlRk?=
 =?utf-8?B?akhOdXNqcmlHcDRiUkZoaVlsVmttWmhOTnRWcGUydkV3VDdmZFBlbFdpTWZH?=
 =?utf-8?B?eFR5Q3V3ZXZlUEVtbTNjY2tCanVTd0Q3dFlRSzFFbnErOFpHeDcyUURTOSt2?=
 =?utf-8?B?NnFIUWd0WXpVU0FuOWZTOEhLVTB2VnhIbjhvbWxpeE1MZDI0VzJUc2ZjdkVI?=
 =?utf-8?B?ZDFpRnZjbU8rV1NVckhGaTlBaDJORXNLcCtRVU5vZVErNzRKanhOT0Zodkgv?=
 =?utf-8?B?VzluK2xqbnpPd3FzMEliTDZHNFJCa3Y3NVg0WVdrVGxXVThKR3RZc2g5SXRo?=
 =?utf-8?B?cE5wWjRDbDNnNU9PUmRWTnR2ZGdPUmFPR0xvMStORzFCc01QeHJtbEt5aTEv?=
 =?utf-8?B?ZUtvb1h0TEdiRTJmQjJGbDliOXMraHRvblRweFZMY3cybm0zOWRkZGdncndL?=
 =?utf-8?B?QnBzbEhBSk5tM0VCQWdpcXh4ZFY5REY0YlJHbTE0L1dkVjYxY3c2L2RzNUFj?=
 =?utf-8?B?YWM3czdMSXFtR1lidkExOHBOZExWZURrWmFQSUYyQjgyT0xweG9HNmd6ZWVP?=
 =?utf-8?B?ZmdDV1RmKzBnZFBTYUIzN0FvUG5WeThKaGw2SllaNDVyaisvT0s3S3BGV2Rm?=
 =?utf-8?B?UDZLWHY5aVpnOWpBak1zU1VWTU1VRytnbW9xcEhlejFRWkxhTGRwOU5tWXc3?=
 =?utf-8?B?VjIvbGZyM3pIOHpyd0NnV1ptVUFmTk5tVEFBalVvUXNrVFlKNjcvVE5KdzRZ?=
 =?utf-8?B?MjZCNVhCdHQyMTkvNzMrc2NLRWtxQlhMZGR5aTZGaVlVWkpkMW1UVFBlMloz?=
 =?utf-8?B?WVlKVFpzMDdvZjlNQk1mbFU5MDNHc1MrRjlVKyt4T0tESnUrd0t6ei9sWitS?=
 =?utf-8?B?SXpUR0hUdDhpaGNldWQ2RzhKMzA1V3R1VXJ6eXpzbFJFSTJneVpIVkgrcXZ1?=
 =?utf-8?B?NkRDQlg5WDVVRW5RYkFvWTYxeDlzQkRmbmxJVFM3eTluRTg4a1lGdkYvbmlV?=
 =?utf-8?B?TkJ4azZwa3VJZk4vbHY1TFg5K1VDWTJXek0zb2JLOC9YaG8vTmw2aUVEQ1Nq?=
 =?utf-8?B?ckZmcGJLY3lNSjZsK3ZaTVI2bE1qblFCMDJ2ZEh5bjlHNlJrTlZZU3RySm9k?=
 =?utf-8?B?dHJQYVU2SjZqd1hXei9lV3JEaklXaGxVcTEwdmVxM1Evd0cyc095Y052ZUlC?=
 =?utf-8?B?c25Bc1VxYk9FbUpsSDBicFVYUmxiUkt6cExpN0pCZnk0ZGJqVVd0cTZQQThX?=
 =?utf-8?Q?nqw2XPQHL1LjOIzO6s1hygqQW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c8676d-b70e-4726-e092-08ddae2e8ce9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 06:08:31.7032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxtDOin/vk4gNL9JoEjL2uPf6kDwuGmxb0jKfyskjJw1cjkWB60+VYFA2yL4az05
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
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



On 6/18/2025 11:22 AM, Meng Li wrote:
> From: limeng12 <li.meng@amd.com>
> 
> Add a new API amdgpu_xcp_drm_dev_free().
> After unplug xcp device, need to release xcp drm memory etc.
> 
> Signed-off-by: Meng Li <li.meng@amd.com>

Suggest to keep Jiang Liu <gerry@linux.alibaba.com> as co-developer -
https://patchwork.freedesktop.org/patch/633450/

Also, please remove // comments.

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 63 ++++++++++++++++++---
>  drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
>  3 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> index 322816805bfb..70c44961af95 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -394,6 +394,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
>  		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
>  		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
>  		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
> +		amdgpu_xcp_drm_dev_free(p_ddev);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> index faed84172dd4..8714458878cf 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
> @@ -45,18 +45,30 @@ static const struct drm_driver amdgpu_xcp_driver = {
>  
>  static int8_t pdev_num;
>  static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
> +static DEFINE_MUTEX(xcp_mutex);
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  {
>  	struct platform_device *pdev;
>  	struct xcp_device *pxcp_dev;
>  	char dev_name[20];
> -	int ret;
> +	int ret, i;
> +
> +	guard(mutex)(&xcp_mutex);
>  
>  	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
>  		return -ENODEV;
>  
> -	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
> +	//find a unused xcp_dev[]
> +	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +		if (!xcp_dev[i])
> +			break;
> +	}
> +
> +	if (i >= MAX_XCP_PLATFORM_DEVICE)
> +		return -ENODEV;
> +
> +	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
>  	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
>  	if (IS_ERR(pdev))
>  		return PTR_ERR(pdev);
> @@ -72,8 +84,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  		goto out_devres;
>  	}
>  
> -	xcp_dev[pdev_num] = pxcp_dev;
> -	xcp_dev[pdev_num]->pdev = pdev;
> +	xcp_dev[i] = pxcp_dev;
> +	xcp_dev[i]->pdev = pdev;
>  	*ddev = &pxcp_dev->drm;
>  	pdev_num++;
>  
> @@ -88,16 +100,49 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
>  
> -void amdgpu_xcp_drv_release(void)
> +static void free_xcp_dev(int8_t index)
>  {
> -	for (--pdev_num; pdev_num >= 0; --pdev_num) {
> -		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
> +	if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
> +		struct platform_device *pdev = xcp_dev[index]->pdev;
>  
>  		devres_release_group(&pdev->dev, NULL);
>  		platform_device_unregister(pdev);
> -		xcp_dev[pdev_num] = NULL;
> +
> +		xcp_dev[index] = NULL;
> +		pdev_num--;
> +	}
> +}
> +
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
> +{
> +	int8_t i = MAX_XCP_PLATFORM_DEVICE;
> +
> +	guard(mutex)(&xcp_mutex);
> +
> +	//find the drm device
> +	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +		if ((xcp_dev[i]) && (&xcp_dev[i]->drm == ddev)) {
> +			//free
> +			free_xcp_dev(i);
> +			break;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
> +
> +void amdgpu_xcp_drv_release(void)
> +{
> +	int8_t i = 0;
> +
> +	guard(mutex)(&xcp_mutex);
> +
> +	if (pdev_num > 0) {
> +		for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
> +			free_xcp_dev(i);
> +			if (pdev_num == 0)
> +				break;
> +		}
>  	}
> -	pdev_num = 0;
>  }
>  EXPORT_SYMBOL(amdgpu_xcp_drv_release);
>  
> diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> index c1c4b679bf95..580a1602c8e3 100644
> --- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> +++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
> @@ -25,5 +25,6 @@
>  #define _AMDGPU_XCP_DRV_H_
>  
>  int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
> +void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
>  void amdgpu_xcp_drv_release(void);
>  #endif /* _AMDGPU_XCP_DRV_H_ */

