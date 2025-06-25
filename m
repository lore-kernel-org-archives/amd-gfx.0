Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC7CC7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 16:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16B010E235;
	Wed, 25 Jun 2025 16:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3OfdGMB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0B410E235
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 16:26:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQJqH8nj9FUcf807nrRpN7I29LKJE4tDBvXZRTP6vzPZ94NRJfLJff/GqbazBEUri2D57d8gWD3AKS23qdlET5H/LsZKFFGd5d44fP+NK6yAhp6hXK8IeyYsTVJpqlk01UbYLX5B8kej/sGOmW7/KrfI3byvllQdbqwglo55DVDyIreGsFJkk6Gt6FrQM8bLdy0RA/wOehqi4gNtuD4j3T7Efv7GeDIVwslZITpRVBotWXdZgaT/VIdLFN64ApGeAgJXqTnOCCBrRDyxPL5u66EdBelFanx725cb/qe0lCbC2HCMn1AD16mZtQfjjbv3hVc4q+shByhfmnBHszd7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88I2Y11ZfazvQ3ByuD3SC9HyNLBA+zrC5HEHGJftYcI=;
 b=nEPUO2bo3YFP6sCUHPRCC5N3kgSPnViOw8HNgIdU2b5cXtu2pIptSQ6qxBoeqr/ykazXf69azBWwg/zmrIBXN/alN9OTZKVOj0jqkgizVTDpj4UMF6F1vjHDCK1MQVmdIn8+YbjVwhGq6p0OISuyjfo+KpymZ97asqQXVHNlXqibVNMSjVleMzx4ax3LiwCjNrBseqLtDoyJgAp8M3+6Q0zq1nxhlGMlw7JjTC28QO6GRmgmY0/t9jSb47T77ihbSWgO9YomR6Zj7g8KL+hmTJTt0Kjo3v8lUL6GaiVuehMQ2yiTLV0XtbOUSY9ylwidBigJ3vcl/2+DVBul2NeNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88I2Y11ZfazvQ3ByuD3SC9HyNLBA+zrC5HEHGJftYcI=;
 b=D3OfdGMBkpWQL3sI5Xg7W0e6WSBbyy/odltVnTO11vrCmrL1DrTEDsfajrk1MZMZPqax5RrFjsJf7U1GyvXAAhZozxEkFGxsqYfhqz3Ye8Xtfe1QeqfsLwzdXkivBRQ6/1Xgiz1+ZlB3tYT6VMIkIF6Z1Hlbxkfw9Ctgaj204j4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 16:25:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%7]) with mapi id 15.20.8857.016; Wed, 25 Jun 2025
 16:25:55 +0000
Message-ID: <f8690c23-549e-4fa0-969c-00420fb24103@amd.com>
Date: Wed, 25 Jun 2025 12:25:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: rework gmc_v9_0_get_coherence_flags
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, rajneesh.bhardwaj@amd.com,
 david.francis@amd.com
References: <20250606125723.7822-1-christian.koenig@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250606125723.7822-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0087.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: c1cb301e-f53f-41ac-2f41-08ddb404f582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cDlnVjJIS3VuSmdZRWd0dndrSWw0YlNpY0hCdkVqK2hvcm9ZMUFHdEhDZS9R?=
 =?utf-8?B?T2EzZjJ2akNyeXFwSkdlaFJJYkJackVoMTU0eVJtbFFIWEJ2UDFyc1ZuaDZT?=
 =?utf-8?B?WnlrZm5WUGxxQ2pQb0NvRWxiTWhHZm0rNEVpN3BlUG1tenFaeWNoRDMydnV1?=
 =?utf-8?B?U2xqcFJqYWswZDZQaE9CL2RJbkxlSUxpL0VZcUpONktuT3A0cmF0c0ZKYk55?=
 =?utf-8?B?NDBMTG1mbHhGNWlZY0xjUmVMKzRpK2R1ekpXY2d3TzR6SU9wS2pUQk5na3JW?=
 =?utf-8?B?cUJGQ3BnTyttRmZiODY3aGpnMUx3c2xOcUgzWjBoT3dwN25EODhRTW1aN3NX?=
 =?utf-8?B?UVVjakNwdmFobUthdkEvU2FPeG5zOGFUY0djU3VoMWNNUG5zSmFpdXVqekhN?=
 =?utf-8?B?Y1R6MDVic201VzFOMkozU1FJeDB1ais5TXRUVWVhS0ZiRFRIajBtTmhuZ1Bn?=
 =?utf-8?B?d1Jwb1dDMzdVaVBFTkNTZHNyMm1LSDlTaXlvcTQ1TjBVQ3BiSmd5bUNlT3pv?=
 =?utf-8?B?TitOOXJ2bk1iUk5JWExIRUpHZmF5NXVhQVRFemJqbjcrQVNjZlJheGlzaEE2?=
 =?utf-8?B?NE5xNDVwV3VhTE1VdEh4em5BSDBYYmcvRllhWURzMUczZjBmVzRXQjdiVVdY?=
 =?utf-8?B?d2orbGV5V3BWQ3pHUzVIbW5KSkYzRFdYcnJneXpPYklxeDNoOWpIUFpjRWFG?=
 =?utf-8?B?SzlTZkZqUHJaRkErZnc2aFBqV05PeUZLbGM0Z21IZC9uVU5tcjc3a0FxbW84?=
 =?utf-8?B?K3E4S284dWZEQXdOSzFBbWsyWE5PYWkzYitvNDNrOGxuUWFHRDd6bjNUWXFK?=
 =?utf-8?B?S0RsUUhmVVNSZjZ5TWNFZ3JzQW5QMGt4K2MweU9Jbit4dktkOG1lT0RBUmFG?=
 =?utf-8?B?dWloMEN4VGNtUXl4RjFXejkzWXJXNVl4U0dkbCtDU00zOVBPMnFJMVZZQzJa?=
 =?utf-8?B?T01HV1A5Nmd6TlhVLzAvSHlGcEM0K1ZkbEdaUEdJemtMS3dXSUovU0FxUGJ0?=
 =?utf-8?B?MUNHTjNuQVdMNWkzQ1M4K2dUVjcvb3RKOCtDaXNMSFRHb0swc25IZElUTzkx?=
 =?utf-8?B?eS9YNE1LWThyVlF0TVpXK1d5T0xrZktPczVhQmRIQmlGZmMweWJQUlZ2YTRy?=
 =?utf-8?B?ZklyeEE4aWk5M2IvWk5UaWI3THh2eTFqVlI0M1ZjZDg5NllqU0p5alpIS3l3?=
 =?utf-8?B?bVJvTWVuY0NQbm5PaUlkbmJYaGNybGNzYnd6SmVnbzZpUDRGUW01eXJNOGZ1?=
 =?utf-8?B?L01hUW5ncWZ0QXdidU1TV1pCcUxrTTNmdWxUd20xT0ZpWUpBNkVVNk9yejVo?=
 =?utf-8?B?KzBTd1pXR1I2VWRQaU5QZjhJQlRqbVJXV2IxejhsRWV3OUFNdmZyU3pWYS9w?=
 =?utf-8?B?N0xWYXpGbVBtUDBESE1oSmUwVDJIVW5wSEtKc29KSXZkNUd4UVgyNmk4N2c1?=
 =?utf-8?B?Wk10L0JGSU4vWVIxc2gvTVNlbjdOcFk1YlpWVjdZbkFJbW1oZno1N1hxeEZi?=
 =?utf-8?B?Q1kwQ2M5VXdxcGZEd2F4MWU2V3Q0alJUakI1cjUvRytocHJQMHhvaW1hU3c1?=
 =?utf-8?B?ZEowSFpzOWh6aWwyTFlzTmwwRUdVNGtjYmVVZGN1cittZUxhdGFWdFdVUE1q?=
 =?utf-8?B?NC93L0JTczAwbSsvQ0t5QTR5eCttanZkWVRjY2d5K2hZVmVSeldZRS9aNnBS?=
 =?utf-8?B?bVhoMGlsbUFyWnM5dUNKb1pjOUc1aGQ2SVRkaElNeEg2MDdaN1VNeHdjSko3?=
 =?utf-8?B?Q0F6dCtUQ1o4SDJOd09kZnVCNDFWamozTEtYNDJud1c0SXhCMmRiam1qL2Za?=
 =?utf-8?B?M2hNOTdmYVdYRndQVUdDM0s5QjF0WEJVOUpsM004ZVdJck1ZSGovaUpaWVlB?=
 =?utf-8?B?dHMyMEZHNmtaQU4vL2NzU3VWbDlkR1hZREEwcVRaMUxYMGNHeE9GVXVtOXNG?=
 =?utf-8?Q?0MdJshRJvtA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnJNblJEZ2g5Y2hjK1h3dEY1QWVMeUwvbVNjUFROUUY5VzZxL1VOc2FHeXlT?=
 =?utf-8?B?MjNNbTNkRXBIOGpPUEo2ODMva0Q5TE9mMG01blZ0S2d5d2ZIMzZhZ2NhcGQz?=
 =?utf-8?B?TEY4N1A1MlRpYURCZFlDZHBQS2gvZDZBbUVjd1BSRXdDVFlScVJYVVdTTDZE?=
 =?utf-8?B?UzZSL3crZDFlZ0lYRFM0dkhvb3IzMHFpa29mMy9VY3M3cGZHVjJwWGU4bWVQ?=
 =?utf-8?B?eWlGSVhHcVc4M3BrYWVNUGozZ0V1cStuRXdvdGo1MncrbklYV3NadG1HSTNa?=
 =?utf-8?B?ZFdxSEd4bWdxc1luT1ovcVdudHROU0diRXpjbTNSMDhPTERteHZ1UTgySlph?=
 =?utf-8?B?blBIN3RWRkdxbXFQRkJwcTRTaDlZSVgvcmUwMDhaOEk1THlQVVl4OGFTZ0xU?=
 =?utf-8?B?WThKM1UzTzIvbmNRUEhNT2lmNlMzVEpnUkE0RFJnQm5BZkM2bHE0Ui9KZHAz?=
 =?utf-8?B?LzJlQytRYmtVTnFXNzIrKytWYmYvcDFDS1E5d0EyblRJZ3dMUW5PVU5MTHdM?=
 =?utf-8?B?OVhQTVJ4cmdvdGs3QXJrdlZuLzA3TmZ2dFFaRE43dVh3d29POHpGNzNReVFu?=
 =?utf-8?B?S2JJU2NydFplTnBWcUdMU0RtcWhzbTR1ZHZxQXByL01VbEpFSk1uOUdCN1M4?=
 =?utf-8?B?d2xiWjRYSGx4TlpZWmpGaUFDWjlONUJtMDRFc2hudjdHb1A1bFh4N2lYdnQz?=
 =?utf-8?B?eWpmRGxMbDNTRnQ3NHk1NTl6YlA2RXVodUhtejI4R3htMXdqL1UyKzZQa3Ey?=
 =?utf-8?B?S01LMGdHWGY5ek0yN2NxTFZjOUM3NFZHajUzSEJyYVpHK3VIQTZQOGMwSHhR?=
 =?utf-8?B?M1ZibVluL3A3SEF6bmlwQ0laNjJIUjBpbkV3UksyNGFFbTg2d1pXU0hkc01N?=
 =?utf-8?B?SmhaakQ2ZjNKdEFJdW5NOEc5ZVZ0UGhkVVdMRElQMFVkZVFlUWVHVVB5MlNZ?=
 =?utf-8?B?eFNsWEozTDlMMDBZMGdQTTBXS29qczVQY1Y0aTgzOXJIQ0UwanVxbGoyVEtH?=
 =?utf-8?B?R2U4alFuVFdETk5vRFM3Tjg4bXR6cFVCcHc0ZnRTcjdwR0VyZHpmeDBGN1JQ?=
 =?utf-8?B?dDdrUDBORzh6OG8wV1BPaThNcjEwVXFFNjhFeXVwcFlyQjJvcFNxYjVMK21v?=
 =?utf-8?B?eWFsNzBqK0Q2WnZUY3F0bWJSTlo4ZXZyTktJd3RKOTlIZlNlbUdDWkt6L2RH?=
 =?utf-8?B?TTRKV1F2ZXEzeTVNTW51VEluaVVuZ2hOYnNidXlYSUY5Ujl2Lzd5QmZMVURH?=
 =?utf-8?B?ZTUwZmlDL3AwbUNjWEVtZG9GYnY1VGQ4dGdPUjlLRFlWc25VRmFYU05JbzQx?=
 =?utf-8?B?c2hrdGV5eFYxajBVTXN1ZEhiblJUQm4xQUtBZDdGRzRlVklYQzJXL3pPblVs?=
 =?utf-8?B?YnRCR3pVUm41WTNwZXlSUERjWXJYdUFYT2liYUI3U2drU3ZZdUJMRVlzZ2g1?=
 =?utf-8?B?QlRsR0NxdFRqWVBkaVBFWm9vZEJ2TlM1TnJvWVc2MGRwS0RRU1J0ekh1TGVm?=
 =?utf-8?B?UTFLSVBUUENzK3M0aTY4WXd0SVJkYjU4clJlWjZzWWVFeVJIbzhxc0tFY2k5?=
 =?utf-8?B?REQrUS9wK040MWRhbmU2a2dvQ2k0cTRXNVhISVFYYkppV0kxN0RTRlVoMUNz?=
 =?utf-8?B?RU5xRTdJNGtOUjVEZjNaWC80K3ZESlZqNHlLUVgzOVRYSEhrT0ZaQnZ0TXUz?=
 =?utf-8?B?NlBBY2FqRFIvUnFZWnIwRzFkak1mMDZIaXFlTDJ0b2w0NVh1OUFPdUpreU8z?=
 =?utf-8?B?WEI1OWZVUnZJV1lzRXRFdW1VVkZvbTNHcWZkUURPVWQwelZYQjdCYlNUUFZl?=
 =?utf-8?B?aFBFcWhDemZid05YRTk5dE5BazVBN1JjSS9INEJRaTdWUUkwbG5wUmFmdGNH?=
 =?utf-8?B?djZGdTdCZTZpd3FWZzFMSGlyTmpHT1I5bFY0Ullpa0VXbEF2Ky93QXlIUHJF?=
 =?utf-8?B?QjJOVlFBVUxmQTFwazhrL0FSYWcyVHFzc1BGMW15UDdvWnVwRzV5MkMwSjk3?=
 =?utf-8?B?VDJNYjJFdyt1bEMzZC8xbXY5SHFJSUJrVWtNaTZhTStGdDFFb3pUaWY5MzBH?=
 =?utf-8?B?eXZlYjNkZ3prbHlQVWtpRW8yc21IekVFbkN3OWpETytNN3crRG1hR1pBdkpp?=
 =?utf-8?Q?8TYCSM8oUOIpmoxzLVetne0bG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cb301e-f53f-41ac-2f41-08ddb404f582
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:25:54.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNx0WQNeMA2W9Loj37c/0gUrJHYW94ZQlOKBivIFHy8oqAcZWgDyBpj8eBskR5yuu9f+I8i4ybnEKgCgqQfagQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865
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


On 2025-06-06 08:57, Christian König wrote:
> Avoid using the mapping here.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index e691cc61ef6e..cad014c3bbf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -30,6 +30,7 @@
>   #include "gmc_v9_0.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "amdgpu_gem.h"
> +#include "amdgpu_dma_buf.h"
>   
>   #include "gc/gc_9_0_sh_mask.h"
>   #include "dce/dce_12_0_offset.h"
> @@ -1131,8 +1132,8 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
>   }
>   
>   static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
> +					 struct amdgpu_vm *vm,
>   					 struct amdgpu_bo *bo,
> -					 struct amdgpu_bo_va_mapping *mapping,
>   					 uint64_t *flags)
>   {
>   	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -1142,7 +1143,6 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   				     AMDGPU_GEM_CREATE_EXT_COHERENT);
>   	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
>   	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
> -	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
>   	unsigned int mtype_local, mtype;
>   	uint32_t gc_ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
>   	bool snoop = false;
> @@ -1172,7 +1172,7 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   					mtype = MTYPE_UC;
>   				else
>   					mtype = MTYPE_NC;
> -				if (mapping->bo_va->is_xgmi)
> +				if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo))

A more straight-forward check would be amdgpu_xgmi_same_hive(adev, 
bo_adev). Then you also don't need to include amdgpu_dma_buf.h above.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>   					snoop = true;
>   			}
>   		} else {
> @@ -1264,7 +1264,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
>   	}
>   
>   	if ((*flags & AMDGPU_PTE_VALID) && bo)
> -		gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
> +		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.vm, bo,
> +					     flags);
>   }
>   
>   static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
