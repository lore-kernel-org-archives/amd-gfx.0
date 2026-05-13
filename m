Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA25CD37B6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 04:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59AA110E0C3;
	Wed, 13 May 2026 04:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1xlyfXTo";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CC7110E0C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 04:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3K6yDhCYr/9T3IrQyU/4X7UXO0B0JfYIul8Mau0iBPXy2PQa9yn2oXkY/7bWeNT1Ekalmg3ICVmUx3NmmoIr24GhTpFhfJLZyKC9r1zJXbh4P1FHgjY7aKBKNxyrS7A3xt1ZZnzSCc1542XES3MRWI/K78nILR/jvIz+ZzIrfrvAjUuiD/ZaffxDxYaEGmxy6iOG3lrYnXiioJqdPvvgyykV2XI5M4vDYqopBakr7h8QtSonsx3ecXoIo09oC/fcRL1feep6tTfb54coNjdUn46zZNSikJoLMFD32uC1ZxcDxSnZuy0HdlpZMcQZgFQW+OJvPQ8e4nK+77UyRVA2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFuJgfWnlGV0Mln1e7ybdPFcxBnXIuYyQolv6K8fIBU=;
 b=b0fI0k+tISShmsRjGg25bK/cQPhjVlSktm3p2YAM2ZMyX82GoJBD7XgbaiwSx2dLD/0xvxdYymIF3LAxMDK4nWggpDgPa3S0nLFOjTFRhUrGmnHEePMKOXrgWTSg8HVran3nVINTE1U0xcCIq3gLyJUhq39AmSB3WtDpOjvwSc2x9JG4NwdI4Qw1ESWl7O4hmsFCIGwqB/7zdsjYkazZJ97W3ROpcptwJtxxOczvbOemG8syNe+iynn7bo63A+Dh7m/yG7ehihL8Bv42AcPi6wmHUwR4bsjdyLnpexhVaoc1pUact1kBEZtM4xD6EGy3YPH1rM9NhYNyiR5HwV9g6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFuJgfWnlGV0Mln1e7ybdPFcxBnXIuYyQolv6K8fIBU=;
 b=1xlyfXToMOuK74P21gB8o3tMkL7mVkXisaThsBy9ZWIkhmfqO6if3LJp976rbICtw9MPKT4x09EdXQFU7U97XXPVvQu4xjd3/1VYCDS8v/F3LWNkmmKODSgu7DmpSwSPlrMxfRMG9amW8VJkXNoEkUOvcly7PZOHYmfAdQc1Gnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PPFC855560D7.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 13 May
 2026 04:23:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%3]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 04:23:03 +0000
Message-ID: <b665fe8a-f593-4e66-8636-af147c6d6e38@amd.com>
Date: Wed, 13 May 2026 09:52:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix discovery offset check under VF
To: "Pan, Ellen" <Yunru.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260512150924.206200-1-lijo.lazar@amd.com>
 <SA0PR12MB7462E672680A19283688D1D8E9392@SA0PR12MB7462.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <SA0PR12MB7462E672680A19283688D1D8E9392@SA0PR12MB7462.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:275::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PPFC855560D7:EE_
X-MS-Office365-Filtering-Correlation-Id: d5e9ac7d-de23-4bcf-11a0-08deb0a75330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: JAs/WJSd8ynyuFQmJgtBP5DyDxz7mlFdbNg5hpqnKf5p2COf03nq6VFyuLHS0agGej4ZM4dlZfajF/LdL0RRxvJCn2fuAIH5VD2eDDLAdbq4PecvQDToaTDnb7IMy2fmqCSGtbfzLDKy5n4MqeRWKmYeUZgpb7/JOC9TGFdDk1qkfktOG/dCYODY4ThT4Ei7IE5E2WQO/aoS9CpTVowTATqx3Sf0828lCqPTffMWRQOMG/JVulueiC6pBUWp4PWn1upTy0fLngFg5tl/WleDraVTfjqtFcYtDs2nG9RFSpjt0+cEXNuFwdNj0mlDgmFnov1q7EQyhgfrWtUgiGEFDpHIcMDZVimqpriEuRcJVf9KimYmMYXqFx+W+8EZlHfIw9kYL98HHcZHBTY0GK2+uBybwxhLSFk0Jvqug8j6eqZhrLYT2cScrHoRSB41kqnm+uOC/fVoOaajUg+j5nI4+ELtJFCT7dBgvsK0Jp+koqtD8nGRxn3kRexXWAMRQWZkDlYAvYkvXIugt/1LnOM6irnDPIF1+NO1AdmizZPU1J/kYDXVP3J+Ti49aH6sgoSvXvlwJNmciK7VsEXcASe3VKhW9XxvuEYFdUbPgunaRGcXL7QsRC7VbnqAn/ou5DLJ0JZQNPKhsw/NnP2Dpp416F+thEw7qDbh0ryeySY73DNl0HzEODGjSSqwrt7Yq3BQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUV0c3BaTmQ3dHFlaVF3MEdFQi84dEJDS3NjbkxTeUd5MnNiNUlBYzFLSTFV?=
 =?utf-8?B?SUYxTnBwZjl5SGJsbzZDVVl3QmZ0b1R1UEk2L2p2eHZBNWpKWDFVaVJGVWsv?=
 =?utf-8?B?bTZoZUVpb2xON3NRQUpzQmg1WlIwU1Z3ZjBZbFpPbGpZNCtRM0RpQ0RWMEZC?=
 =?utf-8?B?WnRJRHhBNnFjSStqemZ1STlzSnc0LzRjaDJNS2xBZkxrTldJbjJzcUFsVmdG?=
 =?utf-8?B?WHRPOENTS3BaOFl1RG4vWW9aTm54TlROVUZXK0ZmYTZaR0RXQThoNEMwV2xE?=
 =?utf-8?B?MUt2SHhxM0dhUldiR1FjamtCb1Y0aVlvUlJzbm1qaTVxazlieWIrcGlaSTdm?=
 =?utf-8?B?WUVYK1I3SHdsbC8wdlhNS0lZWG8ra3c5ZkdsWm9hSHNlY0d5ZkNuV2Z1UnVI?=
 =?utf-8?B?cDJHM0YrSVNscHoycE53T0hDQVREcmhnTUpXMDRxSGQ3SGpjaTFNSnlUcGhy?=
 =?utf-8?B?V2x2OGZ3UHB5dzVHRi9LQytWSUt2K2s1dGxXVTNRSUxsR1JUcTFqdVhMcWxn?=
 =?utf-8?B?bDAwLzJnZ1ZtUWwyVGhYemZQZXFnU2hsTVVTWWFSRXFoMGNDS1lyTXBYVG45?=
 =?utf-8?B?enRTOTdNMllTL0grVVE2NlVNWUpicTlJTmJ1NGpwTmxqemdkM1N4RnJJQTVj?=
 =?utf-8?B?TDRRQ3pBek5MWkVLWVpyRlptZmZlaHdqWEdRN0FDeXc3dWZDMnN3UXBrKytr?=
 =?utf-8?B?VU5FNGRrNG5ONHlTWVR1eTBwTzJRUk1SbElTenZ2NjBKMXhCU2NaaDZRb1gz?=
 =?utf-8?B?cDhXQ2RaMStQU3F1Y2QxQXRhakhLVFpValhuNFVDNGNZTGZpbFFBa0Z5bWtV?=
 =?utf-8?B?alAvd1I2OG9WL29lWTZIWWliVlZDSGFHVk5xemdiNkx1N2lxenhzNGM3cTVl?=
 =?utf-8?B?VXBhK0h6MHc0YmlxMUNOemtnaE5YZGJYSzhodmZIakJ1cFp5eDdmb3dJWG1l?=
 =?utf-8?B?dU9qQm1RMkg5UEFyZS9iMjZ4cStSRWYzWU13TW5mYlVROWRZbVBCSUE1NkFD?=
 =?utf-8?B?SEJCZHowa3d5OXdqdjZEWjZzK0tXNVNvcXgrNFdHd3NTL3drdnJ1Q2FDMHY3?=
 =?utf-8?B?aWEyTlI2clJ1Mm5SZ2RRRkNRQW93bkxkMXF3SUNNV0dhMjlyQ2JCZFd0d2Zt?=
 =?utf-8?B?YVIyRjBsc0pwaS8vYTRGQ2NIU3NZZmg3aXMrMUFmbTdVZkRPVmxhbER5bWZN?=
 =?utf-8?B?NHZiZVB5cUtvWHh0NmpYcUE3VHhHd0h0MitGTFlvdndQTmdid2Y1NmwvV1Yz?=
 =?utf-8?B?TFpxcFFLK0NPQWpISWZzUEI2NklKenhJWjd2eFlTWXBxdHFZbWx2TmZYZGk3?=
 =?utf-8?B?TGh1TjFPdVpWaXc0SjhHaEl2UWlSOFNkYTB4enRuL25tV09UbHBpNEx1TmVn?=
 =?utf-8?B?T0dTd3J6bGt0Q0U4QVdKTlhFMXY5VkhpT055YWk4QWRCQzhyS3o1ekF0ZDlu?=
 =?utf-8?B?eFhxMGpNVm1WaVhESEx5RlhEZ1diWFhEM2REclp6S1crekUvYmRhOFBiMHdx?=
 =?utf-8?B?V3FBYnY1NzkvNnVPYkFDZ3ZrNmVhOS9OMXdoQktzOEFqa3NNOGtVcVU0Zmg1?=
 =?utf-8?B?Mm1uM2IyTkU1NVdmdFJUQ2tOc2E4bUpGUFZpbVQvMHBxWkhYK0xXRTQ1elYw?=
 =?utf-8?B?TFNsZE1za2FVazVGRUpnY1Vjd3ptVmg5WUR4N25tM0pnMlYvZlBZYWthcHJM?=
 =?utf-8?B?K1VjTHJjdnpzOExIRDBGNXFkRGU3UkZoTWxucWpmQUo1bnV0bnBnaUJ6anZG?=
 =?utf-8?B?VE5YWlp1K2VHSm5sQnNJclRqMW5OL2h6aXpSaEI2d1o0VDYxSElOa204QTdt?=
 =?utf-8?B?VjhaQm13MGJqeFhGMTl3bllNandSTjNHSmNQTys2SnVaNldNVm1vTENSU1ZH?=
 =?utf-8?B?UjNhbTNZSzZRNTQyNmdnbmk4Qy9PWHN0bmhvM0tFN2NBZkN0UHRZeWZpbjlT?=
 =?utf-8?B?ZUViSFFSN0tqU01IT2s1VFI3ODhXSmd2NFBtY3VCNGVPUmtFQnNRNElqbS9h?=
 =?utf-8?B?c1UzNFFUOGlLTnpCd0EvVERhaGx3NEVKR1ErVXVzR1BvM2ZTeWhONi9pdHha?=
 =?utf-8?B?aFJ5R1g2Yi9GMnFnSEpTVVo5Y2J6S29nbEFVank4V1oxWTd4cE00VllxR1o3?=
 =?utf-8?B?QXNQZnRVd3d2aFZpTFNGWnFUT0d4ZTBsM1U2SFNmdDF5Um9IbHNNWWJza1FJ?=
 =?utf-8?B?RitvRXFtRGVlbzdaQXkrMnVNNFh4YkJMejR6MlFreFByblJMdEQvd1dGUnM5?=
 =?utf-8?B?WlpubDg0VXRFV0xZMFJXbFFaQUJFQWxHVCtFbUhPRjdLMmFiMGgvbnR0MHdo?=
 =?utf-8?Q?p1GWfX61RniMHyImq+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e9ac7d-de23-4bcf-11a0-08deb0a75330
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 04:23:03.8541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTUTNONps8F17JJVQthe6+qHiuVN8QNl/K3fktetNOhWuY+atx9zNg68SK08P1kt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
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



On 12-May-26 9:17 PM, Pan, Ellen wrote:
> AMD General
> 
> Reviewed-by:  Ellen Pan <yunru.pan@amd.com>
> 

Thanks for the review.

On a second check, the original issue was introduced with

7055e5157742 ("drm/amdgpu: New interface to get IP discovery binary v3")

Will update the tag before committing the change.

Thanks,
Lijo

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, May 12, 2026 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
> Subject: [PATCH] drm/amdgpu: Fix discovery offset check under VF
> 
> Discovery table may be kept at offset 0 by host driver. Remove the validation check.
> 
> Fixes: b69911681fd5 ("drm/amdgpu: fallback to default discovery offset/size in sriov guest")
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index bbb807a16a50..8e3b6a4050e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -305,7 +305,7 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
>                                  adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
>                          adev->discovery.size =
>                                  adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
> -                       if (!adev->discovery.offset || !adev->discovery.size)
> +                       if (!adev->discovery.size)
>                                  return -EINVAL;
>                  } else {
>                          goto out;
> --
> 2.49.0
> 

