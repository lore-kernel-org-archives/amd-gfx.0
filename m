Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7ECC0219C
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 14:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185A910E87D;
	Thu,  6 Feb 2025 14:50:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AyKuaDxF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1127710E03C
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 14:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqmMICpyureA8ePRN6jlVlZQzcXFO8DT/qrLzze6fSCMxdgwxhaIbJKlZHEc24aS5Mio6KJp4fNwqpK1sT0frXEBXffkYXBsabkp1LoeVzdRvpJv2XzaOxNvUmOsCIvkh6M0Ii0e2ky6WCg4c7Po2zDxlgX9jox080xoO8QnA3o/hGtHUVMGiO6J7+z8bAqtNO+peeBJWO7dQ7kgHTYTYmJITaEoWR3NfD2XV5iaLEchvWETu3xQhlPH8TgpjhvUeTCUtIxmo6XF/uiqFrHPNCk1MjNcikr/OvbVwZwniWNZ5Kql2AHrw8wxsxu/APVhEIO5BG6nhsaVtQhIvr3V6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sz1P3rJokybNmbXaoqS1KOl/4+nzm2q3ltKKoGLTlCE=;
 b=MkM5GjigHoYTzaORHUIkGqd2uGoICgX/FYVazx8hv+rNAECyL1VtDAI+m+NPJfa+UMNiaSl5vAIYWaXtLnyWKQtj8lV9hmgiCIFnZdIbPHUb9zyQ4oi6jT4lG/FScpHy2xgwBxL7t569zT5YNxZd9NBQ4PAyQEz8lHH3MMxUB6qdgLkZOpJNM6TLD9XLXoPTz0XM5vQjzFf+T5Cj/f9PbrZBohFaJcZHB3brk8mqZcb83TQ1wh8VhcMxdjJzy3B3s9yP3MOk7Ry2/yenspAZX0Ohj9LfnBfys8hjQXJjgnEFsKnR2Vh3AzpKVBDuuU2Vgr4CN/QHv31ok3cUv0h0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz1P3rJokybNmbXaoqS1KOl/4+nzm2q3ltKKoGLTlCE=;
 b=AyKuaDxFWJmTVrK0/LeRpOmiVFlkXR41OJyhvRIvApl1G6CBKzeTSywV0Ei9+i8Y4JqabzN1BoW6hEsKPEa/u+AmKSAEK+VRjwonyMeUPq8BLVzrf/BFAoDyRrU9p/uCnuU8eaGjUqsSmjqDjpoeFrk3dcfcM+tzdec44I0SLS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5935.namprd12.prod.outlook.com (2603:10b6:8:7e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Thu, 6 Feb 2025 14:48:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 14:48:10 +0000
Message-ID: <5ef26fb2-f555-4245-ad14-c10f74eb2e48@amd.com>
Date: Thu, 6 Feb 2025 20:18:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] drm/amdgpu/gfx9: use
 amdgpu_gfx_off_ctrl_immediate() for PG
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
 <20250203214349.1400867-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250203214349.1400867-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: b864d7bf-d59f-4220-ec12-08dd46bd4691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1RYTFgwaTlMNXJYNStzbzFmc3lQNDR1bmcwZ0o4YTAydXZqZ0JpZ1JFd0VX?=
 =?utf-8?B?Umpla2xrZndNdjZ2Nm9SR2pVT3FVeU1YR2RBNGdpZ0tJYzlESFlqZmwyeFdW?=
 =?utf-8?B?SWJRb1V1T0V6YmFIdm9GckJVV0tpK3RKNTk2eTdhRmRYN0lHWVN2UURyWHJP?=
 =?utf-8?B?Nm44R2VlenJBRFJtdTBEZlhhWlhJeXkwM0ZnWXhVZ0ZEaGpkcXlzNnhURnA4?=
 =?utf-8?B?VTErbE9kWmNkZFZKOTlPL3d1R0lJQmNiOGx3VWVsaE4rZVRMZ2RDbys4Njdu?=
 =?utf-8?B?TkQvbHp0a3hkR3pqaVZPa3MvUFlmNnhJYTlwRWxJMll2TjIwazdTYlQvUkdh?=
 =?utf-8?B?dVNOaGxRYTFwSjhqZmZpK0FXZHE2cDI5ZTQxekFNVDlkWEhidFFOUHZ0eFQ1?=
 =?utf-8?B?VndpMVVhNkpvMUxROVVuK281cms5cWFUR3AxY1pGeFB3NisvSzgyZVdtK1FT?=
 =?utf-8?B?UEdGdG9oZFdZaURLT1NHZmgycVN1TjgyMC9IYW5UdkIvaUNDcXZ3UHBiWVJK?=
 =?utf-8?B?dGk3bmJMQ1U0eW5tNmFSVUdrbFQ2bDRvQkY0UkZJWkF2eUtJSkR4Z0RrRTVD?=
 =?utf-8?B?QWFFNlhEUWtZMUN0ZjRIMHYrOVM0NkZnRng1cFpnWU43WWNVSmF0U2tpVEpE?=
 =?utf-8?B?UHlTKzE1V2VpMm1kWXZWTldYQWh1blBXM283YjZCSTZSVDBKb05RNXZsRmhw?=
 =?utf-8?B?ZXgyYWRQNmxCR2s2TmRya2cxazNnamJIa3QrWW1Kdk1aVWZkVndiMDhQU3hn?=
 =?utf-8?B?NStjT0R5L1kzVGVuNVBHQ1ZxYU5Sbi8rak4wWkY2bGhzMit6dXd0YjFyZEND?=
 =?utf-8?B?dzFwUVNxZ2hVOUUrVkRxSXVHc0wvYlpQNEl3Z20vNWpvVkwxL2l1VElZejYw?=
 =?utf-8?B?NU9ERG1TczVnZUxZMG1NODNTWVVrRWx4dDI2ZE9tZ3lhenJPcDUzNUgweVJ0?=
 =?utf-8?B?UE4zNm0rSmI2Qk51R2FGSElkZTRUZU9BSGZkTVJzb1k4aHF4Z2xPWVBIdjZL?=
 =?utf-8?B?V0xlaHNsYmJ1bE14MmQvMHcvYW9BT25FUjl1Skl6aDlIUFNIWVRwQUM3S1Zh?=
 =?utf-8?B?SXkxKzJ6NUo2UlpBZ0hCS0I1SWpLcTI3SVFIcjdYWlJhYlo4RGlWcTRVZHhm?=
 =?utf-8?B?dXN5TDBWV0pHV0hOckdMLy8ySVQxanMxalVQa1FuSTFxOWlGU0FFeGdydzlN?=
 =?utf-8?B?R05yMTZjSTFubzErNWtnK1BJYndQTkc0a0RLdTBmNmw1RWtpS3ByWTlrb3BD?=
 =?utf-8?B?aTRHT2tuUCtwRDZPVlZTbzJnRk11akdCVnp2Z0RHRFNJVlFFN1BNVG5KdkJp?=
 =?utf-8?B?L3BkNFJsRjdPY2ZlK3RIWTdYYU03YmV1OXllQkQ3ZU1qZUFTdEczaitwaUpa?=
 =?utf-8?B?ZExqeWZ1eDhKSGxFUXZPcVoxOHhqSVk4eWdOOXJ3ZVNiWHRJMlpoZjhNaHBZ?=
 =?utf-8?B?d1dJQjBnbUhFL1pLcWh0emZUc3ZyQlFqcGN4cUFHcU4xbkw1K25CWS9KRTQw?=
 =?utf-8?B?MXUwaWxYN1ZXUVhhRzcvWkgzNDladEVLY1huOEdTVUt0bWZQMTUxTkN3SXpi?=
 =?utf-8?B?MEFEUzRpazdBeXJQZWE2bTFXaERCQzJ0aFByMGZhN2plVE5pN0lEUmlPaTh2?=
 =?utf-8?B?OThBWlhqRXd5em1FbFpBNUE2ZFpTNXdzOEM2Y0lucEdUcVNwQ1JjT1grUTE2?=
 =?utf-8?B?Y1Njb3QwTU83R3FLcUs2YnozYjBtc1J5aGJ5eHpYSkdhZVBwVytkY2pIMFBm?=
 =?utf-8?B?VnJUb28xdU5FNGVSakVXck9aUUZDT2JDakIzNDhoNkNJVWVHVEhLb2tHY0ZR?=
 =?utf-8?B?eFVtVmhUalFBNFphN2pLUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TytEQ20yNWQxRTBieWN3NHJOa3JjWTNNWUtNMEhKcXNzQytWMEFwWktQSmlt?=
 =?utf-8?B?ZmhyL2R6ZnB3NGpnSXRXNitkUER3VVdVT3pPUmx3VUsySjBSVDJIMUEydkU2?=
 =?utf-8?B?L1Y4am5QK29DSmJDNVNWTjFGNWhRRVNSMEw5RUwxVStpOE1tWjc3S3M0OFhD?=
 =?utf-8?B?a3hDL3pLM0JSanIvVWgwN2YydzNzSUZoK2pBUVY0Ymx2b2ZwVlc3Y2JjbllH?=
 =?utf-8?B?bjAreHc2Yit2eEE4OXdmMWdGalhVZzhLV2Fla0NUcjRuZVl0U050SzRhcER6?=
 =?utf-8?B?ZTkweWtlZnYvK3hhYW1EeXNvRTUrTmVHZHlHejZPeEw5WXp4MzJnM25jVERD?=
 =?utf-8?B?Y0xPdnJJM3FjT1FRc3g5TkcxRkllM0FvbUQ4K3dQbTcrZlRVOUdFZHQxajZV?=
 =?utf-8?B?eW9CblExZVY2QmVCUElPaEtUVStMK29mUCt1bUFkamM0TzJvczNoZy8wRG4x?=
 =?utf-8?B?YVQ0aE1oYzU0NGszbHJ1b2ZMWDVjKytVQ3c0aUJhcVRzTmZxVlNxTFAyTzZL?=
 =?utf-8?B?akVrZVZ1bU9wdXU2T1VDVkRLaFV1d3ZuRnc2WTJUN1RVelNkQWtYbzZRS0NL?=
 =?utf-8?B?Q0lvenJ4SEhlclRHdkEwbHFnc1ZrOU1Qdm9DbUwrQ2p5NTFxeVZTT01jOG5C?=
 =?utf-8?B?WWNzRHNiUDhlTkZyRGE0eEVtRW5BN0ZyMk1CS2JkbWhEaWlCMUxjS01ITXVY?=
 =?utf-8?B?RWdpWEUwUVF0WFRleHNDTWptNzlUSkJnZ2VVMjltYi9xUEFvalhmWjdmRmR5?=
 =?utf-8?B?aS9nN2RTWGRXazlTN2FxelUvWTd2WFZ1WFFUUHQ1WmZ5SVR3YTRSYjdTVjlQ?=
 =?utf-8?B?TmlXR3FVOE1YbjF3Wk5FYlBCMGZtaFVnM2hyaWszd1p6TlRiMVkzSUg3ZHlI?=
 =?utf-8?B?OEtLeGtVcUllSUtGR2lseUttSGFaL1orNUdTRXh5d2ZlakVscStjWTVFY1h4?=
 =?utf-8?B?bzk3YVcyVFlkZWQ3dEZ2ck1EUzR5Z3lCY01IWEs3RWphaFQ3aDBqUnRmRGQ4?=
 =?utf-8?B?UTdoMTZwUXJLSkc3R2FoMm5RN0tMaUZrT1NKUEFtbnlwYnlBVlBESjM4REd2?=
 =?utf-8?B?OENJOFJhTE40cHdaUXFVVlk5RGdhVGFCM0FrMmZKYm0rVEV1djU2RlYwTTdw?=
 =?utf-8?B?MWxUWndGVy9wZHQ3RHdtMjI1U3h1Mlo4YUtMUHhaK1lLeVNLYzg1QzVnbk8v?=
 =?utf-8?B?bU10SDNLRUhZa0kyYzRnMlZHeUJqSFpNc0RBV2lxSHdXTVlrc2hNWGhXcWp1?=
 =?utf-8?B?Q2VOWVJkbE1yN2c5S2EyWEV2MGIxSllxWlV6REdlUHQ1Qy8yOU1VQVBxMkJx?=
 =?utf-8?B?aTZNTGFUZ2FqaTJHVDdUZGJqWGdiVlY3V1o2SS9iR1JkYUtwaXFVMDQ0UUZV?=
 =?utf-8?B?NXMvT2diNGU3S1VrbGFMQzh3QWlLZlUwY3NhaHdJWlUyUXo0ekVIdFdpN2Zu?=
 =?utf-8?B?cUNjWW15N1AwdVlweDRhUDZ5bXVCY2Evb0lKMktTM0NBY01wU0dsMXBBREcv?=
 =?utf-8?B?M3pKS2FyQTV4ZWtlM1M5Y2NUOEtBSEhrempnTHFjdUkwc2lQV25Xd3k4NG0y?=
 =?utf-8?B?aVI5UWw5ckFVQXBtZEFCbGQ5ZFo2MEJmSDRKdklPMzd6NmJpa0pOSStOeFVN?=
 =?utf-8?B?dlppMm9tb2xMK3dERnJIVjBEUWtqRlhzaU9JbXZBb3BtVHBIamZoK2RuS1R1?=
 =?utf-8?B?dXljNzdvUHN3cUdRUXFoZm9CVjc4ODQrck1EYThjc1Ywcm5JUzJIOVh4clZQ?=
 =?utf-8?B?L3NOL3FlNEoreHJQMU5xMmJVUWJEMDRQS2NKVElKeGZWMVVwVGNPQ3AyMUdZ?=
 =?utf-8?B?ZVAwcGlLVllISGpMYXdMclVNcmpnSmxuQjdNcUpUSXVhVXdsUDcxZkdBVC9k?=
 =?utf-8?B?TEdsZVdCRlA2a1llRUhVODdGNnpzMThaZ3ExajVwK21ZMms3eEx1aDJ2cUYr?=
 =?utf-8?B?VVlhcGh5ZFl2Z1ZXWFp6WHNYamZMckNtaXVPVzFIaXYrdklpeDgwenZDZEZq?=
 =?utf-8?B?Q1h5OUlXbGlnZm8vSGFmbTVuWklHRHRVd25EZWRCbUkrNGRmTXo5RFozR2Yw?=
 =?utf-8?B?QXBlY1ByRHlzWEo2Zmhhbkx0dHE0Q0FQZTFWM1hZNmY4MHU5bnpyMVladStC?=
 =?utf-8?Q?58aRhLdSO4vs0Zj8SCZVFp5H/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b864d7bf-d59f-4220-ec12-08dd46bd4691
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 14:48:10.6687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UI4/WiA57EdTzPdNozIQ1L1gPiOR8rlu1TCSrwbB7pNWvT2IVr2kxkbUs+pZg3i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5935
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



On 2/4/2025 3:13 AM, Alex Deucher wrote:
> Use amdgpu_gfx_off_ctrl_immediate() when powergating.
> There's no need for the delay in gfx off allow.  The
> powergating is dynamically disabled/enabled as for
> RV/PCO on compute queues and allowing gfx off again as
> soon the job is submitted improves power savings.
> 
> Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Patches 1-4 are

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

with a special note that the CGCG and PG settings may be compared with
Windows source later. Skimming over, noticed one change.

Thanks,
Lijo
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index a666832ecefea..dbb9df7913316 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5241,7 +5241,7 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  	case IP_VERSION(9, 1, 0):
>  	case IP_VERSION(9, 3, 0):
>  		if (!enable)
> -			amdgpu_gfx_off_ctrl(adev, false);
> +			amdgpu_gfx_off_ctrl_immediate(adev, false);
>  
>  		if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
>  			gfx_v9_0_enable_sck_slow_down_on_power_up(adev, true);
> @@ -5263,10 +5263,10 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>  		gfx_v9_0_update_gfx_mg_power_gating(adev, enable);
>  
>  		if (enable)
> -			amdgpu_gfx_off_ctrl(adev, true);
> +			amdgpu_gfx_off_ctrl_immediate(adev, true);
>  		break;
>  	case IP_VERSION(9, 2, 1):
> -		amdgpu_gfx_off_ctrl(adev, enable);
> +		amdgpu_gfx_off_ctrl_immediate(adev, enable);
>  		break;
>  	default:
>  		break;

