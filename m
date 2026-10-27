Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB30606A31B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mZ9nhh/X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 863C010F523;
	Tue, 27 Oct 2026 13:31:42 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1973110F523
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:31:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJ0KuZMUqMCD8bzu5as6QsZGZx4C5K3jNDWxaO0dQ2Jzlsc7jYe5cW6AIt2K5JAkhIqJEhiyzXaSOEFZorwWJ/5zw8T5B6jy8pUEqTn5RtGfsGyghVWWQNjy6a1s/Rn2ZUGecDPMAev15LM/s0xHbpxBMgTyOSFALnb9ycYkA1ueefETGTihHGLWYhWNnxEEdkSxy+dTuUxly3lkjc0sd2U31+NzsYWYFN7qEvuXQ7G+F8PLD7EIj27BPTo0oDRNLt1vLrfs1TYodIy72aP0MPZyb4FRl3X7BDzo8d65jeBbgQQLyD+CbYTQpNnKiTRBN5xymkAF8a394nTQ4/k0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51xby2UhXsc8NNroIevbPYDcRDnGpUZGxrKSCxymOMY=;
 b=zEtzLUxp8yo9gXVM0xKvnmWATFxLHHph5tKtS5oiMq8WyHOr4mVmXh3/nWZeteJismLM1TO2d5HY3p/Gj1eqG4InBJ5UuqCtzF9dDQn9cHeSdkaZolopn5r1mEaAVnSf7cUaSXd2WmdsXG2L6X1fOWqeq39pnCbS5m+XFvNvhT9XRiIJeWNVrc3rVGsOVwbYCxWWJSlmP2i0soLf7QMGoKZMYujhF58ySuTDr1Tk399LXFOo6g04QenckEk2Wg4o9A9mjciyXo3y+aGWhOBngaXjLEYPYVsx1ms6x9bbYhjsYRkH1+9Ks4BtdQoNLRuhA1n0ygasOxoqyICz08ASBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51xby2UhXsc8NNroIevbPYDcRDnGpUZGxrKSCxymOMY=;
 b=mZ9nhh/XI+MJe0NXgI4o2RLENIm/cf74vojFeyaR2S0C1/2ipwJJkYP5Et+vY6yCBbHaKX2s5O1OZj9P+HPg/RNrULeN73cOInGgtB0ag8Qc0KLpkIL9BzxNO4iuA7gD4UQ+KL53TKs/rFBcEiq0IgLSZ/2YpBTqsWWf+yncCdA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB9221.namprd12.prod.outlook.com (2603:10b6:510:2e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:31:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:31:30 +0000
Message-ID: <0c87750a-87ce-4fca-b829-9c2948fb54bf@amd.com>
Date: Tue, 27 Oct 2026 14:31:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu: Bump the driver version for the new flag.
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, amd-gfx@lists.freedesktop.org
Cc: samuel.pitoiset@gmail.com, natalie.vock@gmx.de
References: <20261022003058.1723817-1-bas@basnieuwenhuizen.nl>
 <20261022003058.1723817-6-bas@basnieuwenhuizen.nl>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261022003058.1723817-6-bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB9221:EE_
X-MS-Office365-Filtering-Correlation-Id: d558bc48-d5ea-4f54-c299-08df342e9c5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|261026140227099003|4143699003|11063799006|10067099003|56012099006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ah3Y0F3Pb0ye4/0TDfpzURKgYDr3wveZz2DjsNB7HQ5l80dEjvSW7yUHR1WTSn21fGL67//c/De4lHCkAUlS0hYBxNljMaUA8SJZ+tirT1Owa3INc6XMIxCLYNGl3ucYL3ytldvM91/YiqGdS9EA9Ba325LNUQKDrGK+7nAjHS/gxOp4PiKVEcj03p60A4WhAUVYgOCJCsmrAq/fhHkM02A9hlLOGlt5TETi8g9xfjGtwQ8uLtUAGRFc5juXu3XNH/H/yeZz6kfcXAsOTu3asRmK0BEbW68O4y0qOO1ue6Q8chC41bGQ2ZZmpNOFjvnxUNJkiFYD/H4RKZQWsFUQmQvcO6u2TctQSxYGZLmilVEDz3JekafHBGCTo26csMTsMg+Q028cbRr4mZkQNp5R3AMkAO7sKtNy5OTpLRt8TeCWcPJ8ZFkPe6CdHI7vICqwqFpVxwRmsSJVJJkLL+CH0N8E5Xez+HVjw8O7nNBrcX4nN5Ir820DT/X9ZsSb4/a6U59EExVRlfYX8EHmN0JUD6y5ZaT6EzrDQkrxeb587LhEcsIMw7DV56MNL+QI2HPMEfgTWJZSKARTKvGS41o3lrsMAZEKYr/7LYLnM7bchLAWaK6e6wFzUmVKmD08I10b9SSb1ypjPReKM4ziHYLEB8C/CLVQD/XR33FAQABuedk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(261026140227099003)(4143699003)(11063799006)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z25TUU1VS3pKcUJGdzUvRHFYMTlsWUh4NVJ2VlVRek90U1ZkYjN3SVJ0RkMx?=
 =?utf-8?B?T1pUSWd4NWFRdi8raDRaWCt2U3RWenZFUTFLR1piZmdERHFKZ0FUSnVjZnln?=
 =?utf-8?B?UjJPODhuZWFGQzN3dkNJSkZabjBiNitmVzJER3o4eEVzSGVHYkZ1czhDbDFI?=
 =?utf-8?B?Z2NMbUllUmlhR3B6eVRUYUkzcXlGRGlsQXRCRUJHQmxJclJCZ2tMbFJtK3BL?=
 =?utf-8?B?Mzdrb2VCaEhLQjEyeXNKZVRwaDJMTUF2aWZPSkFTc1dRdFErazBMdFRxaDNi?=
 =?utf-8?B?OFgzTzgzZ0puYkc0NWkydTNvdCtSUS84eEdhQTNtbUo1Z1dyYWd6dGdxNWd0?=
 =?utf-8?B?bjROMzlYME5xRjhOZmRSSlptSG1LQnpFOEgvYjRWWlJkUjcvMFFLU1k4VnJn?=
 =?utf-8?B?L3AxZUdwc1JzWTVsd3d4Zk1hZWE4Y3VUWHk5R1YvZE5CMEZrOW9Ma2ZZR0dE?=
 =?utf-8?B?NHNPa3dta2U4S291TE5aR1ZUaCtuUFphc2tHS1V4TUowcEtYT3FBcGpHKzRN?=
 =?utf-8?B?L2d0UFZMNFJSZldEVFhzOGFLbHhhWjludDhFRWRTOWJmbTdHZENBb01iNXdD?=
 =?utf-8?B?Q0FUdDgxZjg4M3pkZFlGM2I0UW9CbU1adXpoYm9RZ05PcWZhK01pY1pSbXpv?=
 =?utf-8?B?amx3OWQ3WVBlUUFsUFhuK0JuSC9iUzZlK2o5NndBN1VXb3dMRUlKMTNFZm90?=
 =?utf-8?B?SUsxZHMrMlM5YkpmVE1Cd2M5d0JFVkkwcHJZL3JtWDJSR1ArL3NKeG1iR1do?=
 =?utf-8?B?SHYvNU5rRUNRU2F6Ky9qcFhMSS9hMUNOMStYRXVuZGpPR0V4NXVvR0E4Ykd6?=
 =?utf-8?B?bTg2L1dFSlpTN1laOC80dnNQZDlPNEhCclo2SytoNXFqODFRdHNIVVRPRTUz?=
 =?utf-8?B?Zjd4Zit4TmlCY0l3MThXdzIxS2o1RjMyQXl4KzAyUVdJL2N3cG5Ma2dGR0ZL?=
 =?utf-8?B?RlJsdlNvclZRWVcvU0FEVDJ5K2FaRkNGUktYTjJBS2xWb1YxWHhjR21wYUhl?=
 =?utf-8?B?SUc3YjhLc2FoYkMwWkhINmI1ZXkxL3lYYTdwQkt3bjV4OElLYkdvL1JQZUVv?=
 =?utf-8?B?dlAwYXdZbHdGQWIwYzJqQzVOQThpM3NOTURmMjZic1BNSWRuVHlpRUJaMHdW?=
 =?utf-8?B?L2p1R1JKdlFzT3Rkd0VrYXZpbi8rVGtkTnRuM1QwMVZMN1FlQUpIZ0dKQ2NX?=
 =?utf-8?B?c3owa2NrQVArM0didFZ2cWFzeEdqam5rS0M0bnRyaU1KaFZRNXNyTlVCMjBW?=
 =?utf-8?B?ZnN1QURWRVFQLzlIN2FLMWVvOWE4ZjdJVlpnb3dLVDg3SnBaSmhkbW9HbWcy?=
 =?utf-8?B?Z3Jud2RxbkN5ekdPSkMwaFF2NVdOMmRLbEtuWGJHalFvMTBrVjJUcVlIMXJK?=
 =?utf-8?B?MkVSV1I1eVQ2K0VxMVBxUTc1eCtpNXZnSTFTc0E3NnpRbGllaklFYXh6bGFM?=
 =?utf-8?B?dnBpREhGM3NiM3lEa3A3STVlcEJwM3cySS9kdzVsQUVSTkZQL3RDSUVZYzFW?=
 =?utf-8?B?NlJIQW9lc3U2MmFDOHZ5S2RYWUVNL3BqelFIdGV3SS8yVGw0VEk4UUJGM0dB?=
 =?utf-8?B?TUg2Z2hzcHVnTGVOUFZEOXY3TVhUNTFlTUtpT0ltMDN1eFYyRDdmWmp0YVRZ?=
 =?utf-8?B?TTE2cDBEWjV6SGV3MGFseC90YzhndERDWFl5ekFVRVpMc21nWUZKb1lLMXBi?=
 =?utf-8?B?dmRYVXFYYXVUUnFTOUJFQ09WKzR4QXlIVG9hNlJ4S1FYMytyWkVicmR5ZzlR?=
 =?utf-8?B?cDVwWEtrMldCV0J5S0NuME9JYmpkaFJkU1pJNUYzdnliem9EaEJVdmNpUTdt?=
 =?utf-8?B?aVVXUFE5SUQzVVFKejU2UVJ1SGU2SSt2Y0YwekdaR1JOV1lVUy84Z2Q1Z0I1?=
 =?utf-8?B?WTJCei93Z21YZWt2NVo0RFM0NXgzc1Bld05LOGhwbFhvWVdUNFpUUEdzOVdq?=
 =?utf-8?B?Z3R0WGljcGVHcEhYSXZBT1k4L3dLdTIxb1J6TDRSb0pRUEJVa2pQQ2FEQkJK?=
 =?utf-8?B?cTZhNUx5QUIxanhPNFdpdGJHODZoRFhFTmIyMlE4QmRFdllLMHA4OG5wVXRU?=
 =?utf-8?B?TjdxWjZWczV2elp6S0t0SVlOOXpkWVI2OVVWdnFxTCtmMHUyemFmT1VpL1pO?=
 =?utf-8?B?bXBaMlhacVlRaU1kTHFrV3BVaVArQmJyZjdtTVVneXQ3Z2lNZDViOXIwaEk0?=
 =?utf-8?B?NXFnaGkwVTdYMWRST1c0cEFZZlZ1LzZ3UmxJaUh3OWFGZkd3U3V1MFdkcCtj?=
 =?utf-8?B?dUNIVFRSWHRXMzR1aG9BclF3cktCYjNGQjhHZ3kvdTNQTmdrNnhVOVFKbjBD?=
 =?utf-8?Q?livde7kFEVkFeoD7Ht?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d558bc48-d5ea-4f54-c299-08df342e9c5a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:31:30.7687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPUuMVq7YWT1uGU12O7mwNswhFj2NLa5e00oR7wd2POinS5r9ttdoLLakQbjQiTR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9221
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 02:30, Bas Nieuwenhuizen wrote:
> For AMDGPU_CS_NO_IMPLICIT_SYNC.
> 
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 9c5e93cd3ee6..c154c4c9697e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -128,9 +128,10 @@
>   * - 3.63.0 - GFX12 display DCC supports 256B max compressed block size
>   * - 3.64.0 - Userq IP support query
>   * - 3.65.0 - Add userq syncobj timeline signaling support
> + * - 3.66.0 - Support AMDGPU_CS_NO_IMPLICIT_SYNC.
>   */
>  #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	65
> +#define KMS_DRIVER_MINOR	66
>  #define KMS_DRIVER_PATCHLEVEL	0
>  
>  /*

