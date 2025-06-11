Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47515C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 09:57:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C590110E5F7;
	Wed, 11 Jun 2025 09:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DeyJvyh4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B7510E2F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 09:57:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZF+Xp/YbluDjYlh098TY95QJV1HE9Be/nrPjyuZ+re1niQVlJl1J3hP9JhJpEQlu/B6nHSRwMIS1xSrh0ipNog7aErDJe2gzNgmN3GqTSGoIekeHxIz7Hk+Qs31bA6eh8FV5j/Gw3k91c6rQTWu1kEkclC4cPtTmCgiYmuOdXV4vIl1ktRmy5SfwLJbFt+Kqgnhobt+BcIZ084l7I89Obd4gitnjYzz2vXBKmMA44OpvW1Kk1I5io5Eh9gxUaDLNPEyf470uU/GjaOBYx9X30YGnFto/xAA9+WQKu51QiP1EL9mhfcXEe1WsrD3xbLlyX+t9bqKjenGuA9rVsMXOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yg8skCW7jsbTa9H5l9EghaeROl35nUYs6iUd7/hh6s=;
 b=KSnASy43Tja8l6O4Y2azArYZqvq4zyoHwALufRIUpaMnUIJz8SHjN+xK/X6Xynmifbx8nkWPvchshs6+mJVCHyzrwP/cS5hUR9gCX1bk+LYPsQTcuTK5uSa7ceF6qGXEY+OXfKBna8oMbITzl7Hlq2o8oyDgZuh3Q+V05jF0WMiD1PW98oqgcV2Jd8NsSjqIySUe+BbO7ZJ0CpCtRygFT1784PUOLEV3YGxgSSiT/7fDe7x74AGO9bcamnyVdL0CEeKEf/vrPSCMjRRvEPH7YQoNF5bLDPSm96iy0s/RorbX2Rt/1dYyjiUVsTrUo60BZKR6cHWYZmgxDJJCYMbLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yg8skCW7jsbTa9H5l9EghaeROl35nUYs6iUd7/hh6s=;
 b=DeyJvyh4r8RPK18c40PlVb7au3uje2U5pZVqvLWLTa+s71FC34+2xt9J9bf8+KCJxBLfCKEvLQYtUX7UPXLLRPbvcPZ9PkKPDVlA78fJtoobQ17xB3xp8V8caVJd2BOv1WRbaHu26a9yG/VjtSyoY57LZTIqn/IpKQyspWxaHJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Wed, 11 Jun
 2025 09:57:13 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8792.033; Wed, 11 Jun 2025
 09:57:13 +0000
Message-ID: <b9dbba18-9996-4378-8f13-e5497bcb973f@amd.com>
Date: Wed, 11 Jun 2025 15:27:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 3/3] drm/amdgpu: Add soft reset callback to SDMA v4.4.x
To: Jesse Zhang <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 jonathan.kim@amd.com, jiadong.zhu@amd.com
References: <20250611094220.3376420-1-jesse.zhang@amd.com>
 <20250611094220.3376420-3-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250611094220.3376420-3-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::7) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd99085-69b7-4cbc-5332-08dda8ce56a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTcvdDlaalNPL0l6ZWsxbVU1c0ZMY3hLS3lQY2p0Q3B3WVFsMmVjd2ZCcHox?=
 =?utf-8?B?WllZNXZrdmlSWm9SZHpYeHo0UWI0YTk1ZnFUVXZqVmFjWHQwVit6TW5aMFJQ?=
 =?utf-8?B?T0IzQWQ4QlBweEx5RnhBNUFCUFFIVVpIN3J6WmRwYzVDajJVcHBOci9hdU0w?=
 =?utf-8?B?eG45VnIvY1llbjZRekxIaTNRNStkT1BmcFRwVHZ5R1A0a0VUbHUzVFZtcHJR?=
 =?utf-8?B?K3B6Q1loYzM3Unc2MkdGdWdOR0Z1QTZ3UHl4RStIZlNrSjEyQnlTTEVvNTZj?=
 =?utf-8?B?YW1vNVVzL04vaE5ZWHVjVEVHc2YyN3E1cHZ6U2VmZXQraFY3SExKd2hzOTBj?=
 =?utf-8?B?QStubWxVMEpkTWNqMEtUalVNWDR3VWxKdnNzb01wUm16SGdlbk1iUFc1dzdi?=
 =?utf-8?B?bmYwY1ovZWlmQ1g2amN4aVRGcnpkOGNNcFNxZkIzVSt2MUtISjNYS2Q0dm9Y?=
 =?utf-8?B?SmFFeXRSWW1DTG0zWEVsNzhqTnZIR2w5WTl0WXBGNXJvbUQ1N0J3d2V5U2lU?=
 =?utf-8?B?QmNOajhRM2U4OHZHQUE4QVFxa1FQbGNDUWcrMVJYY2FFdWFPRDJTSHZDNjdn?=
 =?utf-8?B?MnlUenhoVWFJczVuTDlPRVJPUU9VMjRpN0NwRHA1cDdyb0ZScnlQM3lNeXZs?=
 =?utf-8?B?Uml2WHVML2VuUCtDVitvckFDaTh2N3pKNUNVZllETEJqTjN0dE1iK1ZLcExk?=
 =?utf-8?B?Rnp1VXU2RE80Ny9hUW5DbldVWUNlR2MyT3lRVWlVbVZzdVNiNVNNUU4xM05a?=
 =?utf-8?B?Z1FJOGdzWnBjeEJyVVNyZFRXdThDWU1qWHdWRDhDSzIrMm9iS0dJNTZzYTF6?=
 =?utf-8?B?YU9mb3pqbzVObEFBcE5MRFlnQmdJaWg3K0pmMmxYR1ptS0ZmUXRtcHh2SFgr?=
 =?utf-8?B?YVViUHJZaEtQNDcyQzBTeUo2ckFrQ2ErZ3NOazZ2VlM2QmlkWDVwUXJ2TW41?=
 =?utf-8?B?bzVEMUZKSHBjZkk0ZXpSYmo1QVJGNjhFdlo2Y1gxSnd5MG1FQ0ZzQjVKQlBJ?=
 =?utf-8?B?ZXh4WnlpY1NvLzh5WnErL2RZYktHZUZCZUYzbVY0bUxrS0RFMzZ5ZUhvWHBF?=
 =?utf-8?B?d0ZWbUhLL3V3blpJOTZjVk1GN0JKQ0VTN0t1cnNBMGU5T1MvVUg0anVOMWdt?=
 =?utf-8?B?Sm56ZFFqS0VkajAyWXRvNVB5cW4vMkpjOU5VT2hNLzR2b1g0QVpNT3ZhamND?=
 =?utf-8?B?VURNSWUyU3ZENEx3MndxV1o2ZjVzUDR6K0RWWXgyT0lrVEU5RnByang3RHlP?=
 =?utf-8?B?dHJZVno5eWI0MktHbGhpK3FEVlMxbzlmY1ZPQkRtSlp4ODRPaGFzblZJQlo2?=
 =?utf-8?B?ZTFhOEd1aE54bkNZN0NuMDBNMnNFZEtaTE9icjViU1ZqT1BQMTNpSCsxQ29D?=
 =?utf-8?B?NHd5V1RMTno1SjdmRmZlRUxxY2NFZEsvaEJ4ZGVKRVdSYzFkTmdrSWdlUm8v?=
 =?utf-8?B?dWorQUlDZ1BDWXl6Y3pPWW9YcGV0cGd4Yjd6VFU2VVZpWjRmM2RVSEFYM3Fn?=
 =?utf-8?B?K3JvTEEybDVCTzNLaXBUVjdQMEpuVFJzcCtYTTcveVI2VDhJTzJReTJPY1Rk?=
 =?utf-8?B?OXJEQ0NNUFMySkJ5TG5IVmVYaDJNUEk4SVNqZlVMcjU2aTZvN0tETktYUkpx?=
 =?utf-8?B?NVBadDZYbXBRZ29UdTR1MmpQVmtPL0hsWC8zNk5vRVJwYUNxdm9BN3hTakRK?=
 =?utf-8?B?bG9Pd0UyTFg2ZzlPSGV6ZDk3cHBlUUt3eW9YR3F1bm9TVjR3ZWpjODFSc09a?=
 =?utf-8?B?MjNLQ0gxWk54R01jL2wraC8relhNcnlKNXRnTjQ1a1VmR2Y5UGYyZTBVb1lz?=
 =?utf-8?B?Ukd5bWtjeTllUnJXTkNCYyt5dU5Nckl2VXN4Z3RpQVRXZm9MaE1MMUNxMHI0?=
 =?utf-8?B?d3R3THdCeVhuTXM1NUJTRktpMHgxQVZhNHMxNXJ0alVWSStpSlgxb3Azbit4?=
 =?utf-8?Q?zrgA2aZ8bKM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHQxN0c2V1NiYmx3QjZFWHhEMjBYWUtZeHFUR2JhSGlnaXIxMk5hTHNoNTJ0?=
 =?utf-8?B?NnlWenZNNUhTUGNhWFJva1FkU3JBTktQanhnbUVrNDRDV0JLUnh3d0lDcCtp?=
 =?utf-8?B?NnYvWGVvZ1dvMXp3ZGpMM0pQcDFJSTlpZklkRVc0RUd5ZkNacWdTZmdhb2JM?=
 =?utf-8?B?VW82YzRMd0JBK3JZanlQUkFDamZKcXRwZTFkYVdYSks0N1prT2o3SzJtRzNE?=
 =?utf-8?B?U1NTc280QlVjWEhUa0EzRkM4SFQzNk9ScmJ1aFhZa2xzL3ZTRVhkeDc4WVdZ?=
 =?utf-8?B?VS84TG5GODNacGQzNHRocnUwVlFQZnIwUGZuZEEzUUY4YWtRRjRzZWN5Kzhh?=
 =?utf-8?B?WHVQU1NLU2s4MUc4cHJ3QVBiKzBxZ29uMlpKWTZYWDMxa1ZsOFlvenNEdFBa?=
 =?utf-8?B?VXNiTlIwMVpVNmovNXFjbmYyUEJXZVVtakNVcS9FR21OR1YzYlREelNELzNz?=
 =?utf-8?B?T0JiV0tqNXFSMjEyUUhIZWNUY2hjRWtvVkZJMzRleEdlbCtrbWdIbENOcWY0?=
 =?utf-8?B?S0hrSnlPR3V0ZmNnZURxbHhCYjhIL0xCN3dxbm9YcmRZc3dLQUlhbllDQ0Nl?=
 =?utf-8?B?dEdTajl3K2RFK09GRjF2TmFQMk4rTG1nTys0T1ZXb1dkNCtaL3ZFSFFIcXBT?=
 =?utf-8?B?OHh4S3g2UkM3bmNvTk0xQ1h3RVNHN3hGYjd6MndCajVqUHdkVnpzWTBUN2dn?=
 =?utf-8?B?UUIwT29TUGNMcE0rdFduL09LRE5IWms1UzlabkdNVC91ekN0Q3ZPbzdHcWZB?=
 =?utf-8?B?RzF4Z2xGVnkyQUM2WEd4Tk1nU2lVVTl4cHoydGRvcGl1NHBQazhXSXM2M0Jx?=
 =?utf-8?B?S3FqNFlsU2o4cU5oTDdFUVVjemsycC92VU9yVVVjTG1xa2piUjJIQ0RzMWJP?=
 =?utf-8?B?U2t3dG1IWCtVWTJ6YURkdkxLb1Vla0d6ViswdjBFNkRiOEQ5Znk3WmVwaUdZ?=
 =?utf-8?B?TnZ2OGdzSkIxYmNwL1J3N2FZVnNBdWUzOHVCUzcraGVqeGgrMnpnTW90VnpL?=
 =?utf-8?B?R3NSYlNPU05FdFpDbGhLSkpGVTRIWGZrUFhzUTc5Yi9xb2hEdGY5eXVJWitr?=
 =?utf-8?B?dkp0Q1RJcThBUERZYzRyU3lLVEd1Q1VSSGtlOGMwN1ZhaENJTnRFYkJkSG94?=
 =?utf-8?B?OExjY2hxRzdhYU5mbjlRbW9sYUxkNFRkOG5RY0J1b2poN2VmOWE3QldOR0dJ?=
 =?utf-8?B?YXh6dTVSZ0hiSEZzU1JCeWZEOEFDS0JISmdYaDVPbkFRd0thcFo2R3JsbE4z?=
 =?utf-8?B?MmxXY3d4VHVzZ1VWUEQyL0c4Y0JJc0lHUGxmMlhDYmxQenB3cTBaS0Y4U3Fk?=
 =?utf-8?B?MEV0UFdhdEJZOTAwektJdHRvazlrODRNN0YvcldDK0ovTlNBclhLUUpUWmZH?=
 =?utf-8?B?aHhnOVJOSkFndWxrK09DbTBzSU0yYjg1RVE3TUJsU2FLWGpkeW9vMGNVUHZv?=
 =?utf-8?B?NlNuTVB6VVVKRXRVM2lLWjNkY29ab01IVGkxR05XNkhmZ3dCeTcxTjhsRjNz?=
 =?utf-8?B?dGhnSUtObmNtS0c2V3dvamRVRStpcjVtZlg5UTk0RUJMWFZPbHVYT251VUpV?=
 =?utf-8?B?Lzc0aVpEYTlpeTJ2SXJRc3dOUWVBb21qTWFuTlpvZ05LbVNLSVJIcDRmbGFB?=
 =?utf-8?B?SWRYS1dSYW9FVTBDTjBLc2RxWmFSd0Ewc3Z3c1dIamJvVUZGWXpHMVRadXVn?=
 =?utf-8?B?M3g1TVo0bUpQNzcwN09KZ1NHcjhZdHdvQWFNR0pEY1BPMUx6cDFOYzU0dmF4?=
 =?utf-8?B?dU9HTXE3QWpHeXo1M1J0UzJtNDJFSDZncC93LzZiYTZZUG5hNHZ0WmRQSU92?=
 =?utf-8?B?U2MranpZMWRVMUNxVmFuVkg1Ui9INFZxZVR5Tk1oTnUwdDM0aWxhNld1OHBs?=
 =?utf-8?B?VXBmdG1EMWtZUHpJdEdrQ0diNEh3RVRLVWFjU1VSemF2MTRDeENFMGczQzJC?=
 =?utf-8?B?T3diNmZjNmZsSHJQS3RSSWQ5WkpMMy8yK0Ixcm1WYnhwb3c1bDdDNUVTRWZs?=
 =?utf-8?B?OG05dUlobm85aTk4SVpFTnRZSGZzK0Jaejlmb0xvWGpjdi9uWGxJb2d5cDc0?=
 =?utf-8?B?bm1RWmtQOXhwOW95ZUdpRVFxVWpRWFgvNVN4R1JIMzZzOCtJTXRockhuN1Jq?=
 =?utf-8?Q?UOmbvJqY5VonbA6zU/fS48JFf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd99085-69b7-4cbc-5332-08dda8ce56a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:57:12.8449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeU7gOOigtw8fVAWBMB0eQ0eXaXd1G0kQeDT1IRJ3BV7hnNMrUCNA+wcWGa5IwMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
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



On 6/11/2025 3:12 PM, Jesse Zhang wrote:
> Implement soft reset engine callback for SDMA 4.4.x IPs. This avoids IP
> version check in generic implementation.
> 
> V2: Correct physical instance ID calculation in soft_reset_engine (Jesse)
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 34 +++---------------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 10 +++++++
>  2 files changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 9b54a1ece447..a1e54bcef495 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -534,37 +534,11 @@ bool amdgpu_sdma_is_shared_inv_eng(struct amdgpu_device *adev, struct amdgpu_rin
>  static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
>  {
>  	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
> -	int r = -EOPNOTSUPP;
> -
> -	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> -	case IP_VERSION(4, 4, 2):
> -	case IP_VERSION(4, 4, 4):
> -	case IP_VERSION(4, 4, 5):
> -		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
> -		 * we need to convert the logical instance ID to physical instance ID before reset.
> -		 */
> -		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
> -		break;
> -	case IP_VERSION(5, 0, 0):
> -	case IP_VERSION(5, 0, 1):
> -	case IP_VERSION(5, 0, 2):
> -	case IP_VERSION(5, 0, 5):
> -	case IP_VERSION(5, 2, 0):
> -	case IP_VERSION(5, 2, 2):
> -	case IP_VERSION(5, 2, 4):
> -	case IP_VERSION(5, 2, 5):
> -	case IP_VERSION(5, 2, 6):
> -	case IP_VERSION(5, 2, 3):
> -	case IP_VERSION(5, 2, 1):
> -	case IP_VERSION(5, 2, 7):
> -		if (sdma_instance->funcs->soft_reset_kernel_queue)
> -			r = sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
> -		break;
> -	default:
> -		break;
> -	}
>  
> -	return r;
> +	if (sdma_instance->funcs->soft_reset_kernel_queue)
> +		return sdma_instance->funcs->soft_reset_kernel_queue(adev, instance_id);
> +
> +	return -EOPNOTSUPP;
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 3de125062ee3..ea0eabd9166e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -109,6 +109,8 @@ static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
>  static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
>  static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
> +static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
> +					 u32 instance_id);
>  
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>  		u32 instance, u32 offset)
> @@ -1337,6 +1339,7 @@ static bool sdma_v4_4_2_fw_support_paging_queue(struct amdgpu_device *adev)
>  static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs = {
>  	.stop_kernel_queue = &sdma_v4_4_2_stop_queue,
>  	.start_kernel_queue = &sdma_v4_4_2_restore_queue,
> +	.soft_reset_kernel_queue = &sdma_v4_4_2_soft_reset_engine,
>  };
>  
>  static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
> @@ -1745,6 +1748,13 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  	return sdma_v4_4_2_inst_start(adev, inst_mask, true);
>  }
>  
> +static int sdma_v4_4_2_soft_reset_engine(struct amdgpu_device *adev,
> +					 u32 instance_id)
> +{
> +	/* For SDMA 4.x, use the existing DPM interface for backward compatibility */

For clarity, you may keep your original comments here (for that alone a
v4 is not required).

"we need to convert the logical instance ID to physical instance ID
before reset"

Thanks,
Lijo

> +	return amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
> +}
> +
>  static int sdma_v4_4_2_set_trap_irq_state(struct amdgpu_device *adev,
>  					struct amdgpu_irq_src *source,
>  					unsigned type,

