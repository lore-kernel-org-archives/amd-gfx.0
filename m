Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4C4CA0EED
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 08:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2815D10E352;
	Wed, 20 Aug 2025 08:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rXRy8ODW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984A510E352
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 08:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F28APQMSCBGRZAVTtueh8AG+FkyHM8rgxmJ3nszcXY3B5OEMk4OhZlu4s9j6DRuGHBeITqm6vr6jTWgfR8+bJRenwZCX0q+akNiiI1gZ/qrX5Pa6Hq2I+GE3vhyG0Si59QBiJfBH3a4oWXnvYxoYt8OmPG1CTCyqmlSnGGQZVT4SCb9S5ro7Z5AonyC+ilY0g1fjsynQ/smyzsExMKflheCT1KL8cwrYXbuz4rRAXedbneVp2pRGQYwuHVcQrJus7fiSa4Vs8kqiqJk/UPbiGFV8uq0KtlahcQPeYb8BSsTB4LMIb3X3DBZc/EcGWy1ytUHigaQoFX0bl0QKH9Wv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxnKJjycqdJHhrGYzTbpoRFaXQgIDnOYe90e9ildy98=;
 b=mJo3zBl4hgOkCM3YatADNkrGQXLTx1OPiMDLRvGs2iEv36a1DW+j7cMGEtXEBTFH4GWuH+tEbUQKyFB+PN6w2NmdZ+oDZExtl5vtUfM6FGGUqDk1icyao3M00rJdSQzrEMEupFjpCgAOsZlpzZPDTXTTjZhTiGSnkJwkETf1wnIL4B94b7llqLix52AY3+UrItX5kay7y61pGfafroPJQVkbNqRBtp0a1/NjS6HXm0wCeRQ5ysp7sxAjQagNM6lBSu0TaYvrteiqYjJh4EaIxmPXX48lD4t0nciONd5YZ2tmvLbl6mj4jZcP/Dh8whLWddU2IJyh0WSfW7jDa+ZYSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxnKJjycqdJHhrGYzTbpoRFaXQgIDnOYe90e9ildy98=;
 b=rXRy8ODWBb00WpycAe+UWMgZaG/nk1081Ial9ySBE8bOkvWp3ymZPb2aAnkzQmIeoB7fdLD5Mg3QZUs+ygnd2nL+ko5su5CvU05QUbafIop+8QCkFpMXhctBZ85z7yUbRFOdXQkfnmpQu7Iqzz0DwE8XO6KYTg0KKpZYj3hoh78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9355.namprd12.prod.outlook.com (2603:10b6:408:216::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:13:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 08:13:45 +0000
Message-ID: <274e7416-371f-464d-8d66-f9d81414bd4f@amd.com>
Date: Wed, 20 Aug 2025 10:13:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: replace AMDGPU_HAS_VRAM with is_app_apu
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250820073100.3500205-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250820073100.3500205-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae1b539-72f7-406a-1695-08dddfc17b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0xTTDU3TkwydHF2SWpOZDFkT01XaUVCYks0V2YrM3Z1dUpRTjZtM3dQMGQv?=
 =?utf-8?B?Qlp1MmhGdFdpbVRMRHJ5bms3eC84LzRVUnFRbWVSOGxPMEZETXVSKzdBK2ND?=
 =?utf-8?B?dVVyejRzMkxjWHVaTFFnbVYvUVpWMG5uam02MXlvTFlkU2FFU2hya2M5TEYz?=
 =?utf-8?B?NVRDWUp3VGJFS3l1ZVVWRjJDd2FyNjIxU0Z1R1BNYUlPa3B4MHlHN1hJSUxD?=
 =?utf-8?B?bHF4eXpKaFQvUStEUTFWcDkzcTIyRTFlZ2twb1JodlJTaTNXNk11VHhQMStz?=
 =?utf-8?B?L0hmZ2VwNjZqdXFscENpYkNYVHNmUVRrUThuWW81anFRdncwUHVmcEd3YnUr?=
 =?utf-8?B?MFRqYmtwN2VuamoyQ2tFN0ZWRXhHL25TZ3IwT2djckdQc0RVTytIdWdhOCtw?=
 =?utf-8?B?ODRJM21ha3k1K2RYUmJKdHluejlmTE9zcFgxcEsxU0oxWDBDWDdEUlg3NHVw?=
 =?utf-8?B?VkVCbTdFZUh5Z2VYdjRna1g0RkFpTkY1WU95a2tZcERoOUY4SHBaUTJCR2dG?=
 =?utf-8?B?NDdHOXNGTEtUNjBLUHJMSU1jTG5wOGwwcDgwNkxKMGZPNGpnV1ExMzJJRVNS?=
 =?utf-8?B?enp1dkpMVENFVjdRNDdZdkQrQXVLM3JaNWRxaUtBRDEvd0pQVEkzMXdmbE9u?=
 =?utf-8?B?RlVHcUI2bXNoK1JSMmVQNGQ5cWM3TkJCT2UySDZ3a3dXKzZGbzVqYW9BMDlv?=
 =?utf-8?B?SjhtQUcvZ2JQWDNwU2F3QjhoOXV1MzlWSUV1YVMwRStqK3p2OTdyTGN0SjV4?=
 =?utf-8?B?OUtnMzNDMEZTYXJYb05pT25tYUhibGtPNDduekZONi9zMndacE9PWll1NEMw?=
 =?utf-8?B?c0J6YWNiY2lyeElVYkZvdFhMODFTSDBqdDU0ajJCL2dzYWVha2RxVndGa2VY?=
 =?utf-8?B?VnRvRzlPdFRmaG9mRVBIbXkrbStCTTJlKzEwY0JqL0xudjhFZGdXQTRucXhk?=
 =?utf-8?B?OGh6cnFRWkZPMGtOUXl2NUtIN2hhRUxybmsvN2VGTGE0QWdNRUJycXJ3Ymtz?=
 =?utf-8?B?TXdoTExsWVZwQ2tSaitNb0htVU1ZaHJsczJ4SXBNNTRtL1NmK29kdmZJMGY5?=
 =?utf-8?B?aUpCaGpkWlZ2RzZwcW5teXdnZUFJZTNvNllPZGptQTZvTFBJeXpBdEVPL3BJ?=
 =?utf-8?B?eFp1Q3BEcDRMMVNSdnBCQ1llZk5ER0RidlFOWDZnQWJudHlUM1YzVFZDaExQ?=
 =?utf-8?B?ay9QdE0xSU1lZmlqc2R2Y1lRMDRzQ3dPRVlFR3NBSkVPUjBVdzcxYW1FOVdI?=
 =?utf-8?B?bWNOcy9BOFNaM2U4Y2w1Nm5DbTBVbTNSLzJkTDlEUWpJR0hzamI2d21UT0Jm?=
 =?utf-8?B?N0h1YzJvOWhnelBuVHhxMUozNldKU1VmTWtoZnFjSVJHZVpBdVo1czBKZUs0?=
 =?utf-8?B?TEdFbXZyQndrZUlWWkU3cFVpWkRIdGp2ampDaTh4N3BKZ2xMYzI2RXEwaTh4?=
 =?utf-8?B?ZEtCSFdQUjdTRnFza1ZBM2o0UjV6eWdicjhkb0tRWmxjS2RiVDdkbkoxOGNC?=
 =?utf-8?B?VVZ0UFFJS3doc2FOMUhMempTUWhaTVp2dlhBcXU4Q2tGRWVUVUszb1RPNTdE?=
 =?utf-8?B?TjhkcWZqeERQckVsYm1nazFxaFUxYzBWWlhaa2x4ajJ6alc4dGZCYzJySUR3?=
 =?utf-8?B?L0UraTQ5S3huM2hCY21MZEIraUN5WXhLMzJucnVseHkyc2JDcHI1Mmc5VzMx?=
 =?utf-8?B?enp4SFp6RlovZlBmV2Y4NlI5RWpuM0NLM3VoUWp4SjdGSjJtSDBIM1lvckkw?=
 =?utf-8?B?Y0ZvbEk1a3VvUUpNZXVYWWMybnh4cS9DSmNuSDQ4bDNGR3NaRnZENHJkNWsy?=
 =?utf-8?B?OWplRXVoSTV2dlJObnFOdDlocEE3ci9ncjljS29kZnNrdmsrcWxpcFQyU1ZJ?=
 =?utf-8?B?WkxLdXdqNUlGMEhPNkhXNTVBZlU0aVJFcWFJT1B1YTNpSklFV0EyZ29wb20x?=
 =?utf-8?Q?4vI0rm3ECiQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFlmL0xvdEtnb1JFOHpWemNMdFpxLzd1OVdVUlZoYzQ0SnZ3blF4NzE5aEQ2?=
 =?utf-8?B?SzE1d2VEaVhIb3ZKSkR1UjdOdzZVRTF0L3pvay9ablBEczNhaVZ0U0RwbTl2?=
 =?utf-8?B?UFVFT1BhVFRsSGlUYm9zYmF3MGlxc1NNd2daRkpXbEJFRVI5eGpLUEkxaGpB?=
 =?utf-8?B?VVBkNnVDRUhKZDBuMlR0VzZ6bDZBaWxsaVFRY1J3V0tuK0JVR2xFdHVWQUNk?=
 =?utf-8?B?ZVd4R1Bobzk2NDllRk9VZm05aGhjTmhYWVVET2VzRTFGN0JNeUxySzh4SWVi?=
 =?utf-8?B?ZFptYzFTUXZvR1c1RkZkN3ZEMHFrQ2FMMUo5K1ZsSmxKM0RxZ3ppeXdQT3ZT?=
 =?utf-8?B?MHZiNmlES0c4U2tjb3RMYUJzVnZjd0R2cHd6ZzgyN3EwamJCSWlPRFpFMlZQ?=
 =?utf-8?B?WUsvdDArR1hvNEhPMExZRVRXZ2tQMlA5dTlUd3JzZlk1UVBvOGpBRDRjbjd4?=
 =?utf-8?B?YjVXOHR6S05sMDNPOHZLQkI4cjA2RFI5U2FLVHpKT2d2SkNGSE56OEFFcS9Q?=
 =?utf-8?B?blFVWjNMdkRacm8wM1VURlVpdHdKNzhOaE50cE1uUWUrM1YvRWliQUluMUYx?=
 =?utf-8?B?ZXpHRU10ckxnYndRRG5YTVJpS3lQM1g2dWJhajBwT2NCUGlnNG5KSE4yRngy?=
 =?utf-8?B?VkRCUUhOTTFaMzN4TGhHSkduWWprVnJNSjFCd0lVK0x1MUJLV3p6Yjk0dHhu?=
 =?utf-8?B?TzhCTGxPQmxmM2FMMmFJN2VPWEFtSUM5ZHhpUmwvMEI3cE4zMXdoUUdTalFL?=
 =?utf-8?B?S2JIWFZjQWNuRlorK0E5VmtVSGw3OFpVVzNHcGxhazQ2YnMwSStDQ013UTBt?=
 =?utf-8?B?elJweXE0OUo3WkhVZGp1NE9TTzU3MmNZTDkwK25Cc25tZFB2RHRvVldxRXZL?=
 =?utf-8?B?U2JDZkpXRnhhc2tlK2RXOHlHM0NXUTZYT2dmVXFvRGlvNmxrVFpZYXNRRjVN?=
 =?utf-8?B?TEJ6OHlNb1pJVEhEMU1iZHFCM2plNkhtVnluSllhYlBEeEtwaHBQd0lsaWtT?=
 =?utf-8?B?ZHZxWCtkMDQzR3BMa2RnbnlkcUswcVJ5WEFiVGU0dFRCcXBZeUhFVjIyMkZk?=
 =?utf-8?B?SUdrYTBxd0xjR2ljZkJRakhnWUo2dktCalI4VjQ2T3BEL01MWkhldmpNRkJM?=
 =?utf-8?B?UGtkQlhma2F2dE5lYlRnaThScHNGcmZOc2pEdzcrSnkzZHJYWEQzUEQ0STBm?=
 =?utf-8?B?Mks4eHN4L3dKZWJHbmJvMFRQVnZHb2k0cWVZblFWYUVEY0haaVFJZ2F0R1B2?=
 =?utf-8?B?c1JUZVRqeXBtWFhhRUYzSTlOanJuUFJmTW9GaTNnMkg3MGpGczQ2ZVBtMDZI?=
 =?utf-8?B?N0FJUFZwYjd2QnhJcjFheXI1TkZ3ZDRsNHJOeGJYWXBRWTFMTS96SGREeHh0?=
 =?utf-8?B?Tm01bSt2eEJaTldaWVFxMEpJQyt0UU50MkFsZlViOGNnQ2EzQkFMVjRUN052?=
 =?utf-8?B?MEJjMmQ1OG1TeWNCY3FrMDZDKzVaSTVtcVV5UElHY200a0IrMi9kUThDeEFj?=
 =?utf-8?B?bG5CRHlUbVoyUiswTTVuSTIrYW1QUTNxeG5FRDJvTFJnM0lGZm1GeE5CbklE?=
 =?utf-8?B?VXBWNENITEFTbmc5RUtYRXFkM04xTXVNYlhmZ3NnaUFmSDF3TkwvcEpUWmpp?=
 =?utf-8?B?QWdiTFNYRXVGVzBWN0o0T3lNK1pzSGU4aFEwWmVnbFdKdHorb0t4YzZHS3hK?=
 =?utf-8?B?bmNzTElUNUxIVmc2M0R5eHJsVE1lSm5vSlgvbkpWV3h1LzVzYXErcnI4UDR1?=
 =?utf-8?B?OTc5MWZ5a0tMWVd3VkJJY1VlYmd6Znl5amlKUFpzVVNqZlR6RnB2Q3U1TEUv?=
 =?utf-8?B?bnoxaVVBaG5rRnVuazU4WXpSQ1F5Rlk1QUkyV0JSd1IvUHVXSktZYUZXQmtD?=
 =?utf-8?B?TmRlMW9GdDFlUDZ5SVFCSnM5L2lOUHJCellxQUV5bDYwRUJGV0pIaE5UVFJU?=
 =?utf-8?B?bVVjSmJlNk1ISytBUHEyNll2S1haa3J1VzVmdlFZVzN2YjhRV1ptSzdML3pl?=
 =?utf-8?B?aERXUnNHaXNjNDIwWmZJWjYwbVZBNG9ZSWFxQWpsTXpwU2x1WGk5OXZEOW1E?=
 =?utf-8?B?SjJ6dlRRNWhMb1ZNVUpUTm1OQUpqeUtiWEgxWTRCKzBOaDRnQ01LUEN0SURZ?=
 =?utf-8?Q?xmGbaTFsFEDyCRL6NIiFmOmYt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae1b539-72f7-406a-1695-08dddfc17b6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:13:45.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QU1VRE47zGjIFNArUnd6t5tCJttrp/l+AM3UJrcPzAT+vliE3KKZ6e4WgjZq2ODF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9355
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

On 20.08.25 09:31, Yifan Zhang wrote:
> AMDGPU_HAS_VRAM is redundant with is_app_apu, as both refer to
> APUs with no carve-out. Since AMDGPU_HAS_VRAM only occurs once,
> replace AMDGPU_HAS_VRAM with is_app_apu.
> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 6 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 +++---
>  2 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ddd472e56f69..01f53700694b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -946,12 +946,6 @@ enum amdgpu_enforce_isolation_mode {
>  	AMDGPU_ENFORCE_ISOLATION_NO_CLEANER_SHADER = 3,
>  };
>  
> -
> -/*
> - * Non-zero (true) if the GPU has VRAM. Zero (false) otherwise.
> - */
> -#define AMDGPU_HAS_VRAM(_adev) ((_adev)->gmc.real_vram_size)
> -
>  struct amdgpu_device {
>  	struct device			*dev;
>  	struct pci_dev			*pdev;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index fa3e55700ad6..4125e73a0647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -880,9 +880,9 @@ static int psp_tmr_init(struct psp_context *psp)
>  		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
>  		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
>  					      PSP_TMR_ALIGNMENT,
> -					      AMDGPU_HAS_VRAM(psp->adev) ?
> -					      AMDGPU_GEM_DOMAIN_VRAM :
> -					      AMDGPU_GEM_DOMAIN_GTT,
> +					      psp->adev->gmc.is_app_apu ?
> +					      AMDGPU_GEM_DOMAIN_GTT :
> +					      AMDGPU_GEM_DOMAIN_VRAM,

Mhm the logic here is actually completely unnecessary. You can just specify AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT and get VRAM if available and GTT otherwise.

The only reason I could come up with why we would need it is to have error handling if not enough VRAM is available for the TMR, but falling back to GTT is then probably still a good idea.

Regards,
Christian.


>  					      &psp->tmr_bo, &psp->tmr_mc_addr,
>  					      pptr);
>  	}

