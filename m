Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361DAD3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 04:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACA210E5BB;
	Wed, 10 Dec 2025 04:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="imoPfHHV";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012047.outbound.protection.outlook.com
 [40.93.195.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F69A10E5BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 04:58:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=javiLgd6kqCLLRG+wvekKNqsYDzIxLIvAwdVAOKm6vCVJT8SoiaEWjWara2+w3QSmBvsw12QvQ1m3rwCzVjGPpyBYYnNSadCR/eSTzE9nVMmV/kt3VAeFuVWJbjhoJ2q0G2S07I07y+S4u9gnBE1pRLjhulmMn+RfK07VpbAyB0KXhl7YuvIb18iqImGtNPIDGb2EclHiy6cZVxofwgNafrYFioFz3luRXpgHqzBBkieaNuV1SS2aZr7QVPGh5I9lV7RFYizi9UbASq0MzroWk4Lor+o7xILxr65uIunyZdft+l2It80HZNaZ7HDo7QGDQrf1L6zAErMKF8jYuPetQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8XRtfbARg5RaHvs/UvBikkgkYHElBzRzqpmzMGpmoY=;
 b=EhiKe/vjFxP3JpQekTmcfPsMD9V/Jbdbmq14RwGrTHeHSCXw0Dpg+ybq7b8Zhm66rb5XQfE2ILKvyJiLzu439np5WuwJgqS33QsbAOyRxUGm+x434E63wO+k5JOwafXz0iEW4pG3/JVSTXE8YrU19CIzT/a0dBB8oPX52fcpu13XqRLLoc2ZCd4Iqv1m0++v3AMD8qp+U3ytlY6jkcaE7gywIQuymZ3lhko+yap3NLQs24atbzRjj/OohUz05vGiK6CM1TbOzTS6fKyut8HayYe9/fixRbPlmx2Hoefx8PZf8XvnCE6X03WvWmg3fWDaGYFQo6tlnsGBjgf/Hw3SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8XRtfbARg5RaHvs/UvBikkgkYHElBzRzqpmzMGpmoY=;
 b=imoPfHHVvliMFegc0Y4RIqGm8OTNYdnpjl09m3F1U9mLMLVb3O44DIkr71qE0sJdnR5wQkYVWfmyqIcJ6XAfS0yR7v0AON0D4drlW7ajb22Qc4HRdu7cPYKDILrP6g/V2QdwVceYypuRRXpGE8cmEAZ6Q6RouIvfVUXJEb7npHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.7; Wed, 10 Dec 2025 04:58:20 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 04:58:20 +0000
Message-ID: <3558bb90-aa6d-4167-8198-1a81fc067696@amd.com>
Date: Wed, 10 Dec 2025 10:28:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Move ip block related functions
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com
References: <20251208073336.1381340-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20251208073336.1381340-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0131.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d2::19) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 96793d67-9800-45c6-d595-08de37a8bd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bS9HNzlYN1FiZUZSSi9QOUxSeFNOQjJSQWdLZnRCUExJMCtUY3Z2d2ZvQVBO?=
 =?utf-8?B?UlVRT210M1IwVTlmZ2ttcTVTZ2tGM1VoT0JFakhsSFZCcnJlVnlHL3lERUxY?=
 =?utf-8?B?NUNLUjMyV0xqQnl0azNScVU3bElWTFQ2djlLcDcrTWlOUE1ZOXFoVXhLeHNH?=
 =?utf-8?B?cENDQmlzdCtnN1hKekx6OFRFakxsSmpPb29oU2RxWUorVVN2RTJFQnBpNHJ6?=
 =?utf-8?B?S3BWN3hvZjd0cEVDVU1ueE10MnJRQzQzZjVwK2lpYnd2MHdPSWhWSGJtOTB4?=
 =?utf-8?B?Q2RuRnhSKy9kOEZ5dDZTc3VaZkxOeWZrM3pGYzUveGlSWE45bDFObTMyL1VD?=
 =?utf-8?B?OHBVZnU0TWlRVDRlMDIrbkc2RUJsUlhBMVBNUnlpby9Hd1lPSEExQzVnZHFs?=
 =?utf-8?B?MzZOYnZFeUNBVnpMVEZwekNZUWtFRTY5T0hkdmhLTnlGYjkyWkxiaHI5SUxm?=
 =?utf-8?B?VEUzZ3ByT1pTSmYwREphZXExTnYyUFYxOGJJN1ZZWjVZcFBwK0RXUGZscDNx?=
 =?utf-8?B?WlU1V3Y2S0JUb3pnS0dNL1lEcFJjNGxpN3R3MnRvZEdNdHVRRUwrNHl2Y01Z?=
 =?utf-8?B?RnpLRjFuWWdhMi9CelNiajA0TEhSUDRjSEFnQ0k0anJlUXVrRnJuZlJ5bVc5?=
 =?utf-8?B?UlhxWkFJNXpGbWorQmNBTFRjZW1XNmhmd0EwTmd6eVZMeWRNNDFwVHFEem9I?=
 =?utf-8?B?VU9LZkZPbEx3dGNNS0F2RFQwaHNHaEJwVU1YMUZ0MDZrWDNHVGJlYStHZDBC?=
 =?utf-8?B?U1NKcHJmWmpPY2lTYWxUU2NIT2dza3JGcUU1MVRPZjFFbnlYR2xiRVRCMVRr?=
 =?utf-8?B?UllFMEVRaGZPYkF1TGptUmJzdUVqaUlMeGQxZDN2dnRBYUk2Q012QzQ1dTA4?=
 =?utf-8?B?UlVaQnY2akordlA5bnVwQjlwb1o5YUhCTExQNWR5eWswSVlBQ3p0R2srZHky?=
 =?utf-8?B?OXEwQnl3SjZ3K28rbzQrcnNJUzQvUlIzQjV5TGhtY3F2QzBRbDM0enpsOWZK?=
 =?utf-8?B?U2VXa3BuRVdaU2lNalI1SElXRjBtUDBjSnJRRFRxd2VwWmZRVWx3Mjl5NTl4?=
 =?utf-8?B?cnFTRlRsSUVMMWVoL0NWR1Z4ZklMTWxJVGZraE5UaU9md1RDVzErZ0FPeHg5?=
 =?utf-8?B?eWJNdVFCdkRoVzF2NlRjdy9oZGZKTyt4aTBkSXYzQ041a0FuSXBrL1piNFlW?=
 =?utf-8?B?NVpSV3lJa0RoUk1QZUZ0cEJybzcxYjd1aXJlcGRIdFZMZlY3enBXMUhSN3cz?=
 =?utf-8?B?NzAweE5OdlhHN3FkNW43VytSY2huMER3NVE5bUxqKzUzKzVaUk1sMm5KM3hS?=
 =?utf-8?B?NXc5TEU4QjQrWEZ6Z3MxL1FEM3p0UjJJeXptcXpsaTU0VnFkeWFQeE11L1Ay?=
 =?utf-8?B?WWVHMUg5YmJjSDJXZE5FYmxXU28rS29WTUNmNXYzQVo3THFTKzZhaS9GQ2ky?=
 =?utf-8?B?aVd6Ti91R056dEZ6OTJqSXczKzVaK3JpZ1AvRmU1amVYNWs4R0g3TlhXMUJK?=
 =?utf-8?B?U0lMelFvTzFDdFdmb1dnTDNDcWlMREdjeXZTeUpMMFlkOU0wMld5aVpQRzhk?=
 =?utf-8?B?YTR3eXlXaGlwR2tYZHNaMlJQQkM3ZFNyOEhNRmRTZ0VkbE9nQjdhazI5ZHRr?=
 =?utf-8?B?QzI2ZnhQSkp0UUNLdUptSFBOdm9hKyt4VXN4dGRzREIrYzhocWhMZ0NqQVhK?=
 =?utf-8?B?Y1cvbXQxbXlVNW12ME9YMnZJdmo5UWZIN1Z3ZGpXYjRQM24wVHEyLzdrcGd0?=
 =?utf-8?B?RkozbGhBUlpOd29mMW9LVzZFYVZVbGpQY3MrMmliWFJvazdZUUN2NGF5bXhX?=
 =?utf-8?B?b29zUjdZc2Q3SGt3RitZNjJoUDJMWUFYckdkeTZ6V21udGNvSkFyZWdRVFR5?=
 =?utf-8?B?YjBBTkU2Q0wzcmpsa2swY0w5dmoxV0pyUDQzUkZXWlZ1NWdtYVFmSTRYRGg0?=
 =?utf-8?Q?WOrhF6p/YwGjf4kVCJ3j4qRvJR+VX+x9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjJjSmhOeUpIK0RlNk9sZlgrYmp1ZEgxSUlUV2JYcGxvQkcrWkc4ZXJtWVJi?=
 =?utf-8?B?L0ZXaXk1VHZBelM1bi9WV0ZsbnUycjg3T3lqRTBGcDlwVkpKR0xHNUczbUdp?=
 =?utf-8?B?US81T1kxL1hBdmZVcGRxTnd4YWR1K2ZOSGpva3ladVhKR2c0YVlBVE45WFYv?=
 =?utf-8?B?VDZQUUJmVFpLWWhHL2tENU9RY0hSbmoxQmRReXM4UzZhUGozSDQ5c1d5RHRM?=
 =?utf-8?B?em5aTDNNbEk2K3ZhZERNRWJiaGNaTEhpcUhtMTJ3V1hHcm9tMGlYVmF4eDJ2?=
 =?utf-8?B?VFk0bkFId0pvNU43b1NoRHZtN2VTK0VnSGpzL1A4OGlkY3ltbHNURW5XejJQ?=
 =?utf-8?B?a0ptMnVpWTlwZXhJQVZiZ09YaVRMaFJrNk5zUUo0Mi9QMWg1a1hyODY2d0l3?=
 =?utf-8?B?d1g0NVZDNTdXZ0h1SGVFbnBOLzJPbkE5SG8xcUdHdW41bVRhb1p3cTU4WkY5?=
 =?utf-8?B?Y2loZktST1NERFFMVXRBZUpvcllGTnlDZzNQRE1Qc0hsQkUzTEV3QmF3UGRR?=
 =?utf-8?B?UUJ6eUdrQkRxUTdNeXhLeWlqOVZYdE4xdDJ4M1RNZjVQMHllVll6a2hMbEJB?=
 =?utf-8?B?eldUb2xNNVZlZDdyRmJTMjMveW9pS1hhQm5yV3crbVk3c3M0RkRHM2h3Smhr?=
 =?utf-8?B?T2VwZFpWQXVKY1d3UEh4RDNCRnJHeE54ZnRuS2tkT3E1WHNVc0EzQ3MyMHc5?=
 =?utf-8?B?bElldCsxaGdwdTZRUVYrYXJ4bUltUWRmS2Z3NkhucDJ1SHhmQzl5enhBanND?=
 =?utf-8?B?ZGtiN01aY2gwVGROVUxsNFQvMG5yRVpIaTJybmxZaVVHRkcvOTZvd1pVdWQ5?=
 =?utf-8?B?UVliV3NqeHczTGtqMHd5ak1IODFBNkVIZGFFeGdTbEJkUXFubjVNVXVpZWJP?=
 =?utf-8?B?d1Nldnl5VzMrYzlNczEzZ3MxcVlMMFM4SHQ5SGZBYzh2MGdIUWVWczA5bjNl?=
 =?utf-8?B?aGlPOFZjQkg4c0tFTUlXSm53QkFFRmdiRmRJSWQxTzNTUXZYUVpoTmdvMVlx?=
 =?utf-8?B?OGdpcGk0SGRhTnZFK1lXTEh6bVVsNnhZRnRtKytkM0F5TWs0WC81ZVZ5K05X?=
 =?utf-8?B?cUdMUkdQKzBWTWR1L2dkOGdLTDY4UjhTdmRxYXlqbkJWRGtsc3BQYU85R1FX?=
 =?utf-8?B?ZzRhR1hsZ1IrY1ZJTGpKa0VkU3lrN1Y0RllYdEwrMTJXYnUyeWV5Ykhuczd2?=
 =?utf-8?B?UE5OT0FDTmVFdHZrclRxR2Z2RlJoV05WWVRFeXIzeGNHMVhodnhJSmk5Q3VP?=
 =?utf-8?B?TUlnREMwak5DY2RBU3lpV3ZUM3JxN0UwNGl5U0QvWm1RS25HVTZsTnl2Yk5Z?=
 =?utf-8?B?WFV5Y1MzU2xlR1M5elpKaEZXaG1ZQnMvMGNxZDEzVUZzNmNCRFNjK3hVUjFJ?=
 =?utf-8?B?N2ppb3J5QUEzY1dFbHZ3K0ZtbzNENEJWQ09XOGlHc2lzZXdXeVlVLytkdFFs?=
 =?utf-8?B?TE80b3dyaXQ0M0IySkpGNFJmTlZDZlFBakxlWmJvbXRITnZhTXJ1S1ZoN3BS?=
 =?utf-8?B?OW93RU5pRmtaNlp1SDk3N3lDS2pEYy95Y3FRMTFmdW81c0Y0WVZmTi8xRnZ4?=
 =?utf-8?B?UnlzczBJM1ZxWTUxdHY0OVVrbytBVlAxRHVRMzlVM25TZWxpV2FzV2RUZTFi?=
 =?utf-8?B?a1NBcDdmWWl5a0YwWmk5dHBVeEQ4cnpNRzcvYmIxTlFLdW5sVExONWcwbExK?=
 =?utf-8?B?VDAycHdYbmc0cVo0QmdJa1BCOWlhZ3Vla2dZcXpsTWlCNG04Sm1sQ3UvSW5x?=
 =?utf-8?B?THNleDRGU2hBcTc3NEZadVNCcjhxdTBOc1lJcmRzdlJTbTRPaGJHc3JvdHhS?=
 =?utf-8?B?Q2VIS3hVazFvRUE1Znl6eEtES090UnNpeU1sSlZ1UHhiYjVod2RnWVRaVHNy?=
 =?utf-8?B?VnJqN0QzeDJVQ0Y3S0JrK3RBc2dycXc0NTdLQ0hwbGlxdFZFMnV3ZmQxNEVz?=
 =?utf-8?B?dDR3L1Vhd282K3h5WkliZTBSeVlqL2tQK3ZlWWFmTkdEU05FRTFweVhESi9W?=
 =?utf-8?B?TkM2cHgvNnU0a3ppVk9maFJVaFpRNGtSc3dvTHFxK1pVeU0vcjA5OEczd2E4?=
 =?utf-8?B?M2ZOSHBzaTNodWJxMUhFa0h0VU5lS1JGS1M3VS9WSDk3Ym5qNk9BMGY1MzVF?=
 =?utf-8?Q?Tmg4hZrJxPv82ERmCoVuIOSb7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96793d67-9800-45c6-d595-08de37a8bd0d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 04:58:20.2488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW8SsZNB6IKqsYslJ6O44BOxdqrSIkUIdwl+mZY3FhYEJlaRF4G7CS9vdozlXDPb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
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

<ping>

On 12/8/2025 1:03 PM, Lijo Lazar wrote:
> Move ip block related functions to amdgpu_ip.c. No functional change
> intended.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 121 +-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 323 --------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c     | 324 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h     | 125 ++++++++
>   4 files changed, 450 insertions(+), 443 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index fa71df36f4b3..de8fb746daf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -116,6 +116,7 @@
>   #include "amdgpu_reg_state.h"
>   #include "amdgpu_userq.h"
>   #include "amdgpu_eviction_fence.h"
> +#include "amdgpu_ip.h"
>   #if defined(CONFIG_DRM_AMD_ISP)
>   #include "amdgpu_isp.h"
>   #endif
> @@ -362,59 +363,6 @@ enum amdgpu_kiq_irq {
>   #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>   #define MAX_KIQ_REG_TRY 1000
>   
> -int amdgpu_device_ip_set_clockgating_state(void *dev,
> -					   enum amd_ip_block_type block_type,
> -					   enum amd_clockgating_state state);
> -int amdgpu_device_ip_set_powergating_state(void *dev,
> -					   enum amd_ip_block_type block_type,
> -					   enum amd_powergating_state state);
> -void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
> -					    u64 *flags);
> -int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> -				   enum amd_ip_block_type block_type);
> -bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
> -			    enum amd_ip_block_type block_type);
> -bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
> -			      enum amd_ip_block_type block_type);
> -int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
> -
> -int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
> -
> -#define AMDGPU_MAX_IP_NUM AMD_IP_BLOCK_TYPE_NUM
> -
> -struct amdgpu_ip_block_status {
> -	bool valid;
> -	bool sw;
> -	bool hw;
> -	bool late_initialized;
> -	bool hang;
> -};
> -
> -struct amdgpu_ip_block_version {
> -	const enum amd_ip_block_type type;
> -	const u32 major;
> -	const u32 minor;
> -	const u32 rev;
> -	const struct amd_ip_funcs *funcs;
> -};
> -
> -struct amdgpu_ip_block {
> -	struct amdgpu_ip_block_status status;
> -	const struct amdgpu_ip_block_version *version;
> -	struct amdgpu_device *adev;
> -};
> -
> -int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> -				       enum amd_ip_block_type type,
> -				       u32 major, u32 minor);
> -
> -struct amdgpu_ip_block *
> -amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
> -			      enum amd_ip_block_type type);
> -
> -int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
> -			       const struct amdgpu_ip_block_version *ip_block_version);
> -
>   /*
>    * BIOS.
>    */
> @@ -757,73 +705,6 @@ struct amdgpu_mmio_remap {
>   	struct amdgpu_bo *bo;
>   };
>   
> -/* Define the HW IP blocks will be used in driver , add more if necessary */
> -enum amd_hw_ip_block_type {
> -	GC_HWIP = 1,
> -	HDP_HWIP,
> -	SDMA0_HWIP,
> -	SDMA1_HWIP,
> -	SDMA2_HWIP,
> -	SDMA3_HWIP,
> -	SDMA4_HWIP,
> -	SDMA5_HWIP,
> -	SDMA6_HWIP,
> -	SDMA7_HWIP,
> -	LSDMA_HWIP,
> -	MMHUB_HWIP,
> -	ATHUB_HWIP,
> -	NBIO_HWIP,
> -	MP0_HWIP,
> -	MP1_HWIP,
> -	UVD_HWIP,
> -	VCN_HWIP = UVD_HWIP,
> -	JPEG_HWIP = VCN_HWIP,
> -	VCN1_HWIP,
> -	VCE_HWIP,
> -	VPE_HWIP,
> -	DF_HWIP,
> -	DCE_HWIP,
> -	OSSSYS_HWIP,
> -	SMUIO_HWIP,
> -	PWR_HWIP,
> -	NBIF_HWIP,
> -	THM_HWIP,
> -	CLK_HWIP,
> -	UMC_HWIP,
> -	RSMU_HWIP,
> -	XGMI_HWIP,
> -	DCI_HWIP,
> -	PCIE_HWIP,
> -	ISP_HWIP,
> -	ATU_HWIP,
> -	AIGC_HWIP,
> -	MAX_HWIP
> -};
> -
> -#define HWIP_MAX_INSTANCE	48
> -
> -#define HW_ID_MAX		300
> -#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
> -	(((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev))
> -#define IP_VERSION(mj, mn, rv)		IP_VERSION_FULL(mj, mn, rv, 0, 0)
> -#define IP_VERSION_MAJ(ver)		((ver) >> 24)
> -#define IP_VERSION_MIN(ver)		(((ver) >> 16) & 0xFF)
> -#define IP_VERSION_REV(ver)		(((ver) >> 8) & 0xFF)
> -#define IP_VERSION_VARIANT(ver)		(((ver) >> 4) & 0xF)
> -#define IP_VERSION_SUBREV(ver)		((ver) & 0xF)
> -#define IP_VERSION_MAJ_MIN_REV(ver)	((ver) >> 8)
> -
> -struct amdgpu_ip_map_info {
> -	/* Map of logical to actual dev instances/mask */
> -	uint32_t 		dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
> -	int8_t (*logical_to_dev_inst)(struct amdgpu_device *adev,
> -				      enum amd_hw_ip_block_type block,
> -				      int8_t inst);
> -	uint32_t (*logical_to_dev_mask)(struct amdgpu_device *adev,
> -					enum amd_hw_ip_block_type block,
> -					uint32_t mask);
> -};
> -
>   enum amdgpu_uid_type {
>   	AMDGPU_UID_TYPE_XCD,
>   	AMDGPU_UID_TYPE_AID,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7a0213a07023..d93453c3b07c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -313,42 +313,6 @@ void amdgpu_reg_state_sysfs_fini(struct amdgpu_device *adev)
>   	sysfs_remove_bin_file(&adev->dev->kobj, &bin_attr_reg_state);
>   }
>   
> -int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
> -{
> -	int r;
> -
> -	if (ip_block->version->funcs->suspend) {
> -		r = ip_block->version->funcs->suspend(ip_block);
> -		if (r) {
> -			dev_err(ip_block->adev->dev,
> -				"suspend of IP block <%s> failed %d\n",
> -				ip_block->version->funcs->name, r);
> -			return r;
> -		}
> -	}
> -
> -	ip_block->status.hw = false;
> -	return 0;
> -}
> -
> -int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
> -{
> -	int r;
> -
> -	if (ip_block->version->funcs->resume) {
> -		r = ip_block->version->funcs->resume(ip_block);
> -		if (r) {
> -			dev_err(ip_block->adev->dev,
> -				"resume of IP block <%s> failed %d\n",
> -				ip_block->version->funcs->name, r);
> -			return r;
> -		}
> -	}
> -
> -	ip_block->status.hw = true;
> -	return 0;
> -}
> -
>   /**
>    * DOC: board_info
>    *
> @@ -2265,293 +2229,6 @@ static const struct vga_switcheroo_client_ops amdgpu_switcheroo_ops = {
>   	.can_switch = amdgpu_switcheroo_can_switch,
>   };
>   
> -/**
> - * amdgpu_device_ip_set_clockgating_state - set the CG state
> - *
> - * @dev: amdgpu_device pointer
> - * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - * @state: clockgating state (gate or ungate)
> - *
> - * Sets the requested clockgating state for all instances of
> - * the hardware IP specified.
> - * Returns the error code from the last instance.
> - */
> -int amdgpu_device_ip_set_clockgating_state(void *dev,
> -					   enum amd_ip_block_type block_type,
> -					   enum amd_clockgating_state state)
> -{
> -	struct amdgpu_device *adev = dev;
> -	int i, r = 0;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].version->type != block_type)
> -			continue;
> -		if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
> -			continue;
> -		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
> -			&adev->ip_blocks[i], state);
> -		if (r)
> -			dev_err(adev->dev,
> -				"set_clockgating_state of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -	}
> -	return r;
> -}
> -
> -/**
> - * amdgpu_device_ip_set_powergating_state - set the PG state
> - *
> - * @dev: amdgpu_device pointer
> - * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - * @state: powergating state (gate or ungate)
> - *
> - * Sets the requested powergating state for all instances of
> - * the hardware IP specified.
> - * Returns the error code from the last instance.
> - */
> -int amdgpu_device_ip_set_powergating_state(void *dev,
> -					   enum amd_ip_block_type block_type,
> -					   enum amd_powergating_state state)
> -{
> -	struct amdgpu_device *adev = dev;
> -	int i, r = 0;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].version->type != block_type)
> -			continue;
> -		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
> -			continue;
> -		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
> -			&adev->ip_blocks[i], state);
> -		if (r)
> -			dev_err(adev->dev,
> -				"set_powergating_state of IP block <%s> failed %d\n",
> -				adev->ip_blocks[i].version->funcs->name, r);
> -	}
> -	return r;
> -}
> -
> -/**
> - * amdgpu_device_ip_get_clockgating_state - get the CG state
> - *
> - * @adev: amdgpu_device pointer
> - * @flags: clockgating feature flags
> - *
> - * Walks the list of IPs on the device and updates the clockgating
> - * flags for each IP.
> - * Updates @flags with the feature flags for each hardware IP where
> - * clockgating is enabled.
> - */
> -void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
> -					    u64 *flags)
> -{
> -	int i;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].version->funcs->get_clockgating_state)
> -			adev->ip_blocks[i].version->funcs->get_clockgating_state(
> -				&adev->ip_blocks[i], flags);
> -	}
> -}
> -
> -/**
> - * amdgpu_device_ip_wait_for_idle - wait for idle
> - *
> - * @adev: amdgpu_device pointer
> - * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - *
> - * Waits for the request hardware IP to be idle.
> - * Returns 0 for success or a negative error code on failure.
> - */
> -int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> -				   enum amd_ip_block_type block_type)
> -{
> -	int i, r;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (!adev->ip_blocks[i].status.valid)
> -			continue;
> -		if (adev->ip_blocks[i].version->type == block_type) {
> -			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
> -				r = adev->ip_blocks[i].version->funcs->wait_for_idle(
> -								&adev->ip_blocks[i]);
> -				if (r)
> -					return r;
> -			}
> -			break;
> -		}
> -	}
> -	return 0;
> -
> -}
> -
> -/**
> - * amdgpu_device_ip_is_hw - is the hardware IP enabled
> - *
> - * @adev: amdgpu_device pointer
> - * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - *
> - * Check if the hardware IP is enable or not.
> - * Returns true if it the IP is enable, false if not.
> - */
> -bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
> -			    enum amd_ip_block_type block_type)
> -{
> -	int i;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (adev->ip_blocks[i].version->type == block_type)
> -			return adev->ip_blocks[i].status.hw;
> -	}
> -	return false;
> -}
> -
> -/**
> - * amdgpu_device_ip_is_valid - is the hardware IP valid
> - *
> - * @adev: amdgpu_device pointer
> - * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - *
> - * Check if the hardware IP is valid or not.
> - * Returns true if it the IP is valid, false if not.
> - */
> -bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
> -			       enum amd_ip_block_type block_type)
> -{
> -	int i;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++) {
> -		if (adev->ip_blocks[i].version->type == block_type)
> -			return adev->ip_blocks[i].status.valid;
> -	}
> -	return false;
> -
> -}
> -
> -/**
> - * amdgpu_device_ip_get_ip_block - get a hw IP pointer
> - *
> - * @adev: amdgpu_device pointer
> - * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
> - *
> - * Returns a pointer to the hardware IP block structure
> - * if it exists for the asic, otherwise NULL.
> - */
> -struct amdgpu_ip_block *
> -amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
> -			      enum amd_ip_block_type type)
> -{
> -	int i;
> -
> -	for (i = 0; i < adev->num_ip_blocks; i++)
> -		if (adev->ip_blocks[i].version->type == type)
> -			return &adev->ip_blocks[i];
> -
> -	return NULL;
> -}
> -
> -/**
> - * amdgpu_device_ip_block_version_cmp
> - *
> - * @adev: amdgpu_device pointer
> - * @type: enum amd_ip_block_type
> - * @major: major version
> - * @minor: minor version
> - *
> - * return 0 if equal or greater
> - * return 1 if smaller or the ip_block doesn't exist
> - */
> -int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> -				       enum amd_ip_block_type type,
> -				       u32 major, u32 minor)
> -{
> -	struct amdgpu_ip_block *ip_block = amdgpu_device_ip_get_ip_block(adev, type);
> -
> -	if (ip_block && ((ip_block->version->major > major) ||
> -			((ip_block->version->major == major) &&
> -			(ip_block->version->minor >= minor))))
> -		return 0;
> -
> -	return 1;
> -}
> -
> -static const char *ip_block_names[] = {
> -	[AMD_IP_BLOCK_TYPE_COMMON] = "common",
> -	[AMD_IP_BLOCK_TYPE_GMC] = "gmc",
> -	[AMD_IP_BLOCK_TYPE_IH] = "ih",
> -	[AMD_IP_BLOCK_TYPE_SMC] = "smu",
> -	[AMD_IP_BLOCK_TYPE_PSP] = "psp",
> -	[AMD_IP_BLOCK_TYPE_DCE] = "dce",
> -	[AMD_IP_BLOCK_TYPE_GFX] = "gfx",
> -	[AMD_IP_BLOCK_TYPE_SDMA] = "sdma",
> -	[AMD_IP_BLOCK_TYPE_UVD] = "uvd",
> -	[AMD_IP_BLOCK_TYPE_VCE] = "vce",
> -	[AMD_IP_BLOCK_TYPE_ACP] = "acp",
> -	[AMD_IP_BLOCK_TYPE_VCN] = "vcn",
> -	[AMD_IP_BLOCK_TYPE_MES] = "mes",
> -	[AMD_IP_BLOCK_TYPE_JPEG] = "jpeg",
> -	[AMD_IP_BLOCK_TYPE_VPE] = "vpe",
> -	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
> -	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
> -	[AMD_IP_BLOCK_TYPE_RAS] = "ras",
> -};
> -
> -static const char *ip_block_name(struct amdgpu_device *adev, enum amd_ip_block_type type)
> -{
> -	int idx = (int)type;
> -
> -	return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx] : "unknown";
> -}
> -
> -/**
> - * amdgpu_device_ip_block_add
> - *
> - * @adev: amdgpu_device pointer
> - * @ip_block_version: pointer to the IP to add
> - *
> - * Adds the IP block driver information to the collection of IPs
> - * on the asic.
> - */
> -int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
> -			       const struct amdgpu_ip_block_version *ip_block_version)
> -{
> -	if (!ip_block_version)
> -		return -EINVAL;
> -
> -	switch (ip_block_version->type) {
> -	case AMD_IP_BLOCK_TYPE_VCN:
> -		if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
> -			return 0;
> -		break;
> -	case AMD_IP_BLOCK_TYPE_JPEG:
> -		if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
> -			return 0;
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d> (%s)\n",
> -		 adev->num_ip_blocks,
> -		 ip_block_name(adev, ip_block_version->type),
> -		 ip_block_version->major,
> -		 ip_block_version->minor,
> -		 ip_block_version->rev,
> -		 ip_block_version->funcs->name);
> -
> -	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
> -
> -	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
> -
> -	return 0;
> -}
> -
>   /**
>    * amdgpu_device_enable_virtual_display - enable virtual display feature
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index 99e1cf4fc955..b5e6d9d6937a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -94,3 +94,327 @@ void amdgpu_ip_map_init(struct amdgpu_device *adev)
>   	adev->ip_map.logical_to_dev_inst = amdgpu_logical_to_dev_inst;
>   	adev->ip_map.logical_to_dev_mask = amdgpu_logical_to_dev_mask;
>   }
> +
> +int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block)
> +{
> +	int r;
> +
> +	if (ip_block->version->funcs->suspend) {
> +		r = ip_block->version->funcs->suspend(ip_block);
> +		if (r) {
> +			dev_err(ip_block->adev->dev,
> +				"suspend of IP block <%s> failed %d\n",
> +				ip_block->version->funcs->name, r);
> +			return r;
> +		}
> +	}
> +
> +	ip_block->status.hw = false;
> +	return 0;
> +}
> +
> +int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block)
> +{
> +	int r;
> +
> +	if (ip_block->version->funcs->resume) {
> +		r = ip_block->version->funcs->resume(ip_block);
> +		if (r) {
> +			dev_err(ip_block->adev->dev,
> +				"resume of IP block <%s> failed %d\n",
> +				ip_block->version->funcs->name, r);
> +			return r;
> +		}
> +	}
> +
> +	ip_block->status.hw = true;
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_device_ip_get_ip_block - get a hw IP pointer
> + *
> + * @adev: amdgpu_device pointer
> + * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + *
> + * Returns a pointer to the hardware IP block structure
> + * if it exists for the asic, otherwise NULL.
> + */
> +struct amdgpu_ip_block *
> +amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
> +			      enum amd_ip_block_type type)
> +{
> +	int i;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++)
> +		if (adev->ip_blocks[i].version->type == type)
> +			return &adev->ip_blocks[i];
> +
> +	return NULL;
> +}
> +
> +/**
> + * amdgpu_device_ip_block_version_cmp
> + *
> + * @adev: amdgpu_device pointer
> + * @type: enum amd_ip_block_type
> + * @major: major version
> + * @minor: minor version
> + *
> + * return 0 if equal or greater
> + * return 1 if smaller or the ip_block doesn't exist
> + */
> +int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> +				       enum amd_ip_block_type type, u32 major,
> +				       u32 minor)
> +{
> +	struct amdgpu_ip_block *ip_block =
> +		amdgpu_device_ip_get_ip_block(adev, type);
> +
> +	if (ip_block && ((ip_block->version->major > major) ||
> +			 ((ip_block->version->major == major) &&
> +			  (ip_block->version->minor >= minor))))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +static const char *const ip_block_names[] = {
> +	[AMD_IP_BLOCK_TYPE_COMMON] = "common",
> +	[AMD_IP_BLOCK_TYPE_GMC] = "gmc",
> +	[AMD_IP_BLOCK_TYPE_IH] = "ih",
> +	[AMD_IP_BLOCK_TYPE_SMC] = "smu",
> +	[AMD_IP_BLOCK_TYPE_PSP] = "psp",
> +	[AMD_IP_BLOCK_TYPE_DCE] = "dce",
> +	[AMD_IP_BLOCK_TYPE_GFX] = "gfx",
> +	[AMD_IP_BLOCK_TYPE_SDMA] = "sdma",
> +	[AMD_IP_BLOCK_TYPE_UVD] = "uvd",
> +	[AMD_IP_BLOCK_TYPE_VCE] = "vce",
> +	[AMD_IP_BLOCK_TYPE_ACP] = "acp",
> +	[AMD_IP_BLOCK_TYPE_VCN] = "vcn",
> +	[AMD_IP_BLOCK_TYPE_MES] = "mes",
> +	[AMD_IP_BLOCK_TYPE_JPEG] = "jpeg",
> +	[AMD_IP_BLOCK_TYPE_VPE] = "vpe",
> +	[AMD_IP_BLOCK_TYPE_UMSCH_MM] = "umsch_mm",
> +	[AMD_IP_BLOCK_TYPE_ISP] = "isp",
> +	[AMD_IP_BLOCK_TYPE_RAS] = "ras",
> +};
> +
> +static const char *ip_block_name(struct amdgpu_device *adev,
> +				 enum amd_ip_block_type type)
> +{
> +	int idx = (int)type;
> +
> +	return idx < ARRAY_SIZE(ip_block_names) ? ip_block_names[idx] :
> +						  "unknown";
> +}
> +
> +/**
> + * amdgpu_device_ip_block_add
> + *
> + * @adev: amdgpu_device pointer
> + * @ip_block_version: pointer to the IP to add
> + *
> + * Adds the IP block driver information to the collection of IPs
> + * on the asic.
> + */
> +int amdgpu_device_ip_block_add(
> +	struct amdgpu_device *adev,
> +	const struct amdgpu_ip_block_version *ip_block_version)
> +{
> +	if (!ip_block_version)
> +		return -EINVAL;
> +
> +	switch (ip_block_version->type) {
> +	case AMD_IP_BLOCK_TYPE_VCN:
> +		if (adev->harvest_ip_mask & AMD_HARVEST_IP_VCN_MASK)
> +			return 0;
> +		break;
> +	case AMD_IP_BLOCK_TYPE_JPEG:
> +		if (adev->harvest_ip_mask & AMD_HARVEST_IP_JPEG_MASK)
> +			return 0;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	dev_info(adev->dev, "detected ip block number %d <%s_v%d_%d_%d> (%s)\n",
> +		 adev->num_ip_blocks,
> +		 ip_block_name(adev, ip_block_version->type),
> +		 ip_block_version->major, ip_block_version->minor,
> +		 ip_block_version->rev, ip_block_version->funcs->name);
> +
> +	adev->ip_blocks[adev->num_ip_blocks].adev = adev;
> +
> +	adev->ip_blocks[adev->num_ip_blocks++].version = ip_block_version;
> +
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_device_ip_set_clockgating_state - set the CG state
> + *
> + * @dev: amdgpu_device pointer
> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + * @state: clockgating state (gate or ungate)
> + *
> + * Sets the requested clockgating state for all instances of
> + * the hardware IP specified.
> + * Returns the error code from the last instance.
> + */
> +int amdgpu_device_ip_set_clockgating_state(void *dev,
> +					   enum amd_ip_block_type block_type,
> +					   enum amd_clockgating_state state)
> +{
> +	struct amdgpu_device *adev = dev;
> +	int i, r = 0;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (adev->ip_blocks[i].version->type != block_type)
> +			continue;
> +		if (!adev->ip_blocks[i].version->funcs->set_clockgating_state)
> +			continue;
> +		r = adev->ip_blocks[i].version->funcs->set_clockgating_state(
> +			&adev->ip_blocks[i], state);
> +		if (r)
> +			dev_err(adev->dev,
> +				"set_clockgating_state of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +	}
> +	return r;
> +}
> +
> +/**
> + * amdgpu_device_ip_set_powergating_state - set the PG state
> + *
> + * @dev: amdgpu_device pointer
> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + * @state: powergating state (gate or ungate)
> + *
> + * Sets the requested powergating state for all instances of
> + * the hardware IP specified.
> + * Returns the error code from the last instance.
> + */
> +int amdgpu_device_ip_set_powergating_state(void *dev,
> +					   enum amd_ip_block_type block_type,
> +					   enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = dev;
> +	int i, r = 0;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (adev->ip_blocks[i].version->type != block_type)
> +			continue;
> +		if (!adev->ip_blocks[i].version->funcs->set_powergating_state)
> +			continue;
> +		r = adev->ip_blocks[i].version->funcs->set_powergating_state(
> +			&adev->ip_blocks[i], state);
> +		if (r)
> +			dev_err(adev->dev,
> +				"set_powergating_state of IP block <%s> failed %d\n",
> +				adev->ip_blocks[i].version->funcs->name, r);
> +	}
> +	return r;
> +}
> +
> +/**
> + * amdgpu_device_ip_get_clockgating_state - get the CG state
> + *
> + * @adev: amdgpu_device pointer
> + * @flags: clockgating feature flags
> + *
> + * Walks the list of IPs on the device and updates the clockgating
> + * flags for each IP.
> + * Updates @flags with the feature flags for each hardware IP where
> + * clockgating is enabled.
> + */
> +void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
> +					    u64 *flags)
> +{
> +	int i;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (adev->ip_blocks[i].version->funcs->get_clockgating_state)
> +			adev->ip_blocks[i].version->funcs->get_clockgating_state(
> +				&adev->ip_blocks[i], flags);
> +	}
> +}
> +
> +/**
> + * amdgpu_device_ip_wait_for_idle - wait for idle
> + *
> + * @adev: amdgpu_device pointer
> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + *
> + * Waits for the request hardware IP to be idle.
> + * Returns 0 for success or a negative error code on failure.
> + */
> +int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> +				   enum amd_ip_block_type block_type)
> +{
> +	int i, r;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (!adev->ip_blocks[i].status.valid)
> +			continue;
> +		if (adev->ip_blocks[i].version->type == block_type) {
> +			if (adev->ip_blocks[i].version->funcs->wait_for_idle) {
> +				r = adev->ip_blocks[i]
> +					    .version->funcs->wait_for_idle(
> +						    &adev->ip_blocks[i]);
> +				if (r)
> +					return r;
> +			}
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * amdgpu_device_ip_is_hw - is the hardware IP enabled
> + *
> + * @adev: amdgpu_device pointer
> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + *
> + * Check if the hardware IP is enable or not.
> + * Returns true if it the IP is enable, false if not.
> + */
> +bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
> +			    enum amd_ip_block_type block_type)
> +{
> +	int i;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (adev->ip_blocks[i].version->type == block_type)
> +			return adev->ip_blocks[i].status.hw;
> +	}
> +	return false;
> +}
> +
> +/**
> + * amdgpu_device_ip_is_valid - is the hardware IP valid
> + *
> + * @adev: amdgpu_device pointer
> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + *
> + * Check if the hardware IP is valid or not.
> + * Returns true if it the IP is valid, false if not.
> + */
> +bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
> +			       enum amd_ip_block_type block_type)
> +{
> +	int i;
> +
> +	for (i = 0; i < adev->num_ip_blocks; i++) {
> +		if (adev->ip_blocks[i].version->type == block_type)
> +			return adev->ip_blocks[i].status.valid;
> +	}
> +	return false;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> index 2490fd322aec..77d1c642953c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -24,6 +24,131 @@
>   #ifndef __AMDGPU_IP_H__
>   #define __AMDGPU_IP_H__
>   
> +#include "amd_shared.h"
> +
> +struct amdgpu_device;
> +
> +/* Define the HW IP blocks will be used in driver , add more if necessary */
> +enum amd_hw_ip_block_type {
> +	GC_HWIP = 1,
> +	HDP_HWIP,
> +	SDMA0_HWIP,
> +	SDMA1_HWIP,
> +	SDMA2_HWIP,
> +	SDMA3_HWIP,
> +	SDMA4_HWIP,
> +	SDMA5_HWIP,
> +	SDMA6_HWIP,
> +	SDMA7_HWIP,
> +	LSDMA_HWIP,
> +	MMHUB_HWIP,
> +	ATHUB_HWIP,
> +	NBIO_HWIP,
> +	MP0_HWIP,
> +	MP1_HWIP,
> +	UVD_HWIP,
> +	VCN_HWIP = UVD_HWIP,
> +	JPEG_HWIP = VCN_HWIP,
> +	VCN1_HWIP,
> +	VCE_HWIP,
> +	VPE_HWIP,
> +	DF_HWIP,
> +	DCE_HWIP,
> +	OSSSYS_HWIP,
> +	SMUIO_HWIP,
> +	PWR_HWIP,
> +	NBIF_HWIP,
> +	THM_HWIP,
> +	CLK_HWIP,
> +	UMC_HWIP,
> +	RSMU_HWIP,
> +	XGMI_HWIP,
> +	DCI_HWIP,
> +	PCIE_HWIP,
> +	ISP_HWIP,
> +	ATU_HWIP,
> +	AIGC_HWIP,
> +	MAX_HWIP
> +};
> +
> +#define HWIP_MAX_INSTANCE 48
> +
> +#define HW_ID_MAX 300
> +#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
> +	(((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev))
> +#define IP_VERSION(mj, mn, rv) IP_VERSION_FULL(mj, mn, rv, 0, 0)
> +#define IP_VERSION_MAJ(ver) ((ver) >> 24)
> +#define IP_VERSION_MIN(ver) (((ver) >> 16) & 0xFF)
> +#define IP_VERSION_REV(ver) (((ver) >> 8) & 0xFF)
> +#define IP_VERSION_VARIANT(ver) (((ver) >> 4) & 0xF)
> +#define IP_VERSION_SUBREV(ver) ((ver) & 0xF)
> +#define IP_VERSION_MAJ_MIN_REV(ver) ((ver) >> 8)
> +
> +struct amdgpu_ip_map_info {
> +	/* Map of logical to actual dev instances/mask */
> +	uint32_t dev_inst[MAX_HWIP][HWIP_MAX_INSTANCE];
> +	int8_t (*logical_to_dev_inst)(struct amdgpu_device *adev,
> +				      enum amd_hw_ip_block_type block,
> +				      int8_t inst);
> +	uint32_t (*logical_to_dev_mask)(struct amdgpu_device *adev,
> +					enum amd_hw_ip_block_type block,
> +					uint32_t mask);
> +};
> +
> +#define AMDGPU_MAX_IP_NUM AMD_IP_BLOCK_TYPE_NUM
> +
> +struct amdgpu_ip_block_status {
> +	bool valid;
> +	bool sw;
> +	bool hw;
> +	bool late_initialized;
> +	bool hang;
> +};
> +
> +struct amdgpu_ip_block_version {
> +	const enum amd_ip_block_type type;
> +	const u32 major;
> +	const u32 minor;
> +	const u32 rev;
> +	const struct amd_ip_funcs *funcs;
> +};
> +
> +struct amdgpu_ip_block {
> +	struct amdgpu_ip_block_status status;
> +	const struct amdgpu_ip_block_version *version;
> +	struct amdgpu_device *adev;
> +};
> +
>   void amdgpu_ip_map_init(struct amdgpu_device *adev);
>   
> +int amdgpu_ip_block_suspend(struct amdgpu_ip_block *ip_block);
> +int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
> +
> +struct amdgpu_ip_block *
> +amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
> +			      enum amd_ip_block_type type);
> +
> +int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> +				       enum amd_ip_block_type type, u32 major,
> +				       u32 minor);
> +
> +int amdgpu_device_ip_block_add(
> +	struct amdgpu_device *adev,
> +	const struct amdgpu_ip_block_version *ip_block_version);
> +
> +int amdgpu_device_ip_set_clockgating_state(void *dev,
> +					   enum amd_ip_block_type block_type,
> +					   enum amd_clockgating_state state);
> +int amdgpu_device_ip_set_powergating_state(void *dev,
> +					   enum amd_ip_block_type block_type,
> +					   enum amd_powergating_state state);
> +void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
> +					    u64 *flags);
> +int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> +				   enum amd_ip_block_type block_type);
> +bool amdgpu_device_ip_is_hw(struct amdgpu_device *adev,
> +			    enum amd_ip_block_type block_type);
> +bool amdgpu_device_ip_is_valid(struct amdgpu_device *adev,
> +			       enum amd_ip_block_type block_type);
> +
>   #endif /* __AMDGPU_IP_H__ */

