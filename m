Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EEFC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 15:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA5F10E63C;
	Thu, 20 Mar 2025 15:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PPc88O46";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC60610E63C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 15:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F91FxtOT6cPkLZJhSK4cTSL+QPjlk35svGzcvNI1fA1MnKmI9HdPtVnREun5rpY47dwkoyfrOkcTbKp5qfu9Hq02AME6XNpgSCH5dFeSA+dHL198ewPdviRVtYt1AB9EStHFbcJT06O/Jl6IqH4l09qUonrJyO5PyZTnVaKyv4FKUU4NYjoEap51JvO8JPTBGGhf2UJkTflsVbYftLfTI5c12MUZtbcrbpUAC0hsVWmB9x3UlsHI//yD2NVXOCNd7sMk8sCpd+5I/7ljEts9zKGgNnXihHQdxkweR7Kx0Wztsz67Q9evJwU32zzYdVKrLrPt5vpw6zlrXMLjG8HAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KwAjXLSpXKDWKK10K+65tvmBhYBDXlEWgKCUxwFiE8=;
 b=waKPQuotvg2JVleVnsCRuKBsx1+yZ6fpTbpWjYRs025YHFrq2l5JG2oPpTLApTfBrqoUgADJrjvY+XL5LrAw4PIlD3n9JJmOeEJeS6wzsB2ragbbRsUnDvw3YJj6O9v1sJBAQBQ8itSQ4q9Dr1whCEjHY/xypRiwfp0PwgBFjI2lRTJ6OmWPTE+NqxTlNzOFJ+Oj0YtHrhUE3O/uIGoBMYrhRBr9yaaWQdaHi4T/8a83+l+H/sRiQHQDwxysb/ItBEp/z+W0p32FpxQQkIwX3GRCJAJ+3qRAyqs/gRbR35Se5nX3ySksJRnLYlZzU+wlyJiInywDFQs+Z5XCqzPDqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KwAjXLSpXKDWKK10K+65tvmBhYBDXlEWgKCUxwFiE8=;
 b=PPc88O46BgvlI3za6X9YjyFLwJmDHFO58Z7+hbvhbgls9DehE18gHZsUNo8cXw/HYZyU+kn3KY1E7HN0VnSwMfIi+jQczgo+zIZu2n58NpL9qGUQPEQ8q4x6Tl868fazUMvGYs+tjXkd3GDpxZA6Z1BlidcgnJqNR8Y3vahuICk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 15:06:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 15:06:22 +0000
Message-ID: <1e86259e-f394-47b7-b9b1-95dd914c95b1@amd.com>
Date: Thu, 20 Mar 2025 20:36:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/mes: warn on unexpected pipe numbers
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250320142306.1135063-1-alexander.deucher@amd.com>
 <20250320142306.1135063-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250320142306.1135063-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 56344ffe-b4c1-4ccf-d81f-08dd67c0c66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1lIZE9KSE5zNjlGUEpRR2ZSU0NBdHNCSWxpWTRWbHc0M1Bpa085QnFXWUU2?=
 =?utf-8?B?bFdRMjhLQ1AxTkxhQmJqcFlqakVVYXAyUXdNZzA0UjJ3T2R2b2dqNkRZM1hu?=
 =?utf-8?B?dE9SY1krY3pJVk42cm5vdVFNWW9QTGt2b0VZcklFeGtNeURzUVlSSjVyb1dj?=
 =?utf-8?B?bEdPaDY2NnJIQjdUektzOHhFZUtVOVErVCtXbFlTK3A2ZW44V0xLSjFDODJu?=
 =?utf-8?B?blpoVWdoektUcmp2a1JkREZ3eURsN0FFVEpoY1FBQUx1QTBEOGppWGtiaWI3?=
 =?utf-8?B?cWZxankvSGwxK2E5TnY0bEdqMzcrZ1FkMHlYYUVMTjVycmhDT1JjU0tzVWxR?=
 =?utf-8?B?M3V6WXZhM0c5T3VucnBYYXRxMExlNHlpZTJ3TzFCaTlXUUlUek5kNU1KVC93?=
 =?utf-8?B?bzFGM2M3QWRwSG5xUmdhMXpOd053L1FSVnhKa2JHQmF2Um9IT3JUTzlRaThI?=
 =?utf-8?B?QkRHU0Z4U0Q2ZHo0cCtHUkRDTWNaTmV2SFp3bnQ3Sy9uQVMyUDJDaHNSMGpC?=
 =?utf-8?B?L3JtSk90WlpRWUtPOEpuWUxMZFlseCtyWWtMREdZcGhyNmFLV1BSM1FBNllI?=
 =?utf-8?B?QVA0Y01ZcUgzTFZXMWhiVmtpVFdOcUVlMXpLb1gvWWtSbzJFeHA4bXJNQWlF?=
 =?utf-8?B?UjRXaGp4aDlMNCsvQ056ZS9nenl5OHlQczRRRlRDZHFERENZbXNkV2Z5cGtx?=
 =?utf-8?B?eEpTVU1mSzlDSVJHYlZDRno2THRQZWsrVWpPdHZHekRXUzVCM2toM3JIVGRt?=
 =?utf-8?B?eG5aeFIzWWtSYWg1dUlINlNIRE8xWVBMWitTamFDZkp1QnRnRHg4d3h1cFBi?=
 =?utf-8?B?ZGdtdUY2NnZkRmprYU9OejMwaVRXN1pXOWVDbWgvaTM1UlEwNjZIOHcwcFI3?=
 =?utf-8?B?ZHUrMjRxSmI4OEI5L1lWL2F1ckFjczBKNUhqeFRrSnNNdUZWNFJXK25pejFQ?=
 =?utf-8?B?YStIMHhoTWk5TGNnbXpTblYzZXVGT1ZmZTAreHFmTVczTTJmS01DQjdvcngy?=
 =?utf-8?B?dGJXTVNVSm5hNTlBelZNN2N4YlFkd0JaVm5HSGhsZkg0ZUt4NnRiOW95NlVq?=
 =?utf-8?B?WEM4WndHTjNyMDVORnVieFVCRnFBamFVSmFYWXZVYi9tK3VYOE1CYllJNWpm?=
 =?utf-8?B?Y3l2aUJkall2eUdqem9JUFd5ajhDZzlDL3FIdzdXdjlPMXoxTCtvNjVoZ2xj?=
 =?utf-8?B?SDlCT0hwYUUyQ1dJNkFkTXRuQ2J0RzI0Q3FJcXhTcmlTU0tzb2MvQlBMa2pR?=
 =?utf-8?B?N3lWaFR5RGNJZjRaUHJWYlZQT2tseVRnTlpZejZWaFdXRG4xSjNnN2lDa3Ar?=
 =?utf-8?B?SGRnck9DVkd6NWtweE1IVW9DUjF0clMrbWIzQjhyUmlGZnJkazRpVENEUUJ4?=
 =?utf-8?B?U2dJbE9OZ2E5TEk3QUxybldEQUY3VjhXTWlEejlFL3FVVTE0Q2hUMVdpaHNm?=
 =?utf-8?B?K0FPbTRzZ0x0VWRSTmw0czQzQ3E3YUhjYW83SzV4N2JwY01MK0VlSHpXN2g5?=
 =?utf-8?B?ekdnMGJ5TUROWWFLZXZneGYvOUNJbFIrS3VBQW80ckRySlBpaERCeENJOWFZ?=
 =?utf-8?B?T01JZkFwSnFKekNVajd1Mjg1cEdHeXVJVlJMRHkxZnRPOFhLMStHMUR2bnFX?=
 =?utf-8?B?Y1JXTFZzVVZ6YURsMUp3VTZqZEJXeEtUaERVdm95dHcrTzZzOE9wMnlvMnR0?=
 =?utf-8?B?NDRKN0ZJbjY2RllSdTBwZERYanVSUTZXSmRHS0NOdVdzeDhWdEVFZTRjNFlD?=
 =?utf-8?B?aGc5Q0RCTVBza2YrSEJDL2VwSjZPYlp0cUU5QS9BZTNxVzFhSVpxTTFjR1Jk?=
 =?utf-8?B?WlRCOHEvWERZUWo3dDc0eFV2RVhGWEFkcFJXSGdFNktQRVRVWXFUZlRCeDJy?=
 =?utf-8?Q?C62QE1OwFFf6m?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVQzSXg5VmkvRWhFU29qSmEwS3ZOZnozOVA4VGp4RklwUlRxcDJwOFM4OEt4?=
 =?utf-8?B?QU5NUEdmZVI3NThIV0JDVVZnWEtIU2VxYUZ1YndWRnlObmc1eWpIcC9rV01T?=
 =?utf-8?B?UFlkZUlSdVZJSHFxU1krSTdTdjBNbFZzdTRaMTRDWmFDNHNCa0xSeW5TUTZJ?=
 =?utf-8?B?dVRiOEZrMGxLMU1SckdaRjFRUnhjcmhBSFZTYWs0NHpFbE93Nk5TWERGdTdq?=
 =?utf-8?B?SVhxMFB5TC81SkZ5ZzV6WW1lWVBJK0R4NklMRjQ3VEExY25HcjZjc3F3SEhp?=
 =?utf-8?B?MjZSRy9ZaWhOT041Uk9JM3ZJODlDR1VFelpMTVp2dUpWZGNvS3poc1ZCeFhB?=
 =?utf-8?B?S0VZWnlmdkFtYVVDT3FWV01peXgvMGdoSmJIK08vclJoaEQ3Q1d1cURESDdN?=
 =?utf-8?B?TTcxVDVYVEhYY1lMVzBiOTFmcERSQU9nRzBYU1FpL2FEaU10TEtlSXNBNExu?=
 =?utf-8?B?cnAyekR2QlNUT0tPajcxRExCMkJmLy85cEZOTVFvc09zQjhMYVdXYzNUZ3Zn?=
 =?utf-8?B?ZlBseXJhRzdKZW14R1d5TWJwb0tkZmMwSGFaay9GTjJGUHlxWXRZNmltczJp?=
 =?utf-8?B?TUtOc1RtM0NjVXVtditIRDh0R2JPZGNNSHNMSkVHaGkxb0o0OWR3UE94S2dS?=
 =?utf-8?B?NWFSRHdQRmNNVU1SWmpOZFU2ZUVRak1adnRiSi9yYVhpazd0Ni9qZEZYdXJn?=
 =?utf-8?B?MFgzSVpkR25uT0U2QUUxSUIwWjQ2b2V2M0ErMFZSZWlLazNhNVpwMEVSdWtz?=
 =?utf-8?B?UG1Jd0d5T1RGLzdTZUlWaWdzS3VMUjFoZUVCbks4MmJnbmttR3NLUnlrYkJs?=
 =?utf-8?B?ZTlxMk5ObnlIbTRMMzhEck00ZjVvN0VVVEZrOXFMeTZ5MXR1R2F5TlNpdzMv?=
 =?utf-8?B?RDh6QzUyNWVyRXUyTnpxTkpoOHNhN3RFbllQNWhiR2NpRXZES3BvRzllYkph?=
 =?utf-8?B?MUE0T1VOZ2JveDllL0ZsZElxeUdHTFNSUXdMUVdSbXZWUWFoVVVkSDREQTdZ?=
 =?utf-8?B?bkExTVNmSDJXZmFkSHUydFZ6eXhBdGRDVURJSmVKcEtMTjlsVHQ3ZFdIWnRo?=
 =?utf-8?B?VGVxMk85N0tnUnVHRUp0VzlLekdsWENZUnFFaHgrc2NaSi9uQjNwMVlUZERi?=
 =?utf-8?B?Nms1RFRFNUVJUDY2dHFuWFdoTWN6OS9Ba1N0SzA0Z3F4TjF0eGVqMHNHaTNm?=
 =?utf-8?B?VCs2VE92SGx5VStXUzcrdEtIRHBheExqb3NhY3piWjlqTDRpZ3RWWWZkMmlq?=
 =?utf-8?B?Ykc3Q01UVExTbU1QTmN5Mk5FdEJzVnBUYmIvcmsrektiUUQ5QTFwQmJsMll6?=
 =?utf-8?B?V2V5bzNiaVJFRjJuU0FMY3Z0ZFpHbDgvVlA4dFBjcll3UTRBVVh4d2NCcnhh?=
 =?utf-8?B?S1BsTXNiNnFBY2pCQzkyVUY5YU9RcE9kSmVwNGJScmZyTTR4TzR6VFlyMk9D?=
 =?utf-8?B?TTd4WkRBYkhZZTk3ekpUQjV5czF6ZlZhc0grdnIxY3VYNlZDMHpXL3Nsd283?=
 =?utf-8?B?VXgrSE5ZN0JFaytlRUMvemtFMlNmZDJtb2ExTmdIYUh1b3RFZXhGOVB0SVc2?=
 =?utf-8?B?RmJSWWtFU2RzREFuQkhTYTBKaFZRZUZKdVRvT0M1RFBhV0tiRDRqMkNUbHBI?=
 =?utf-8?B?bFA4Q3MrK2FkRUFxK0NyUUdCck1HS2ZoUW51TFpJSEZlclJFM25EeFExMk9S?=
 =?utf-8?B?V252NzJYSng3NThvcEVYZ0xPNVQ3aU53NDdaQVJIUzV0c2FBdUJFcng3T2cx?=
 =?utf-8?B?c2ZNTXBZY0dPcGo1M2tYRjIrc21MU3BNS0psTFZjbnJJd1ZaU2xFdENoNTVU?=
 =?utf-8?B?bHYrNGN6d1poWk9xNUNoYytjVUpQTDFNR2J5SWljM0Z3bFZWajROZmlWL1Nl?=
 =?utf-8?B?Q3J0OGcwalk0WUR2NGhsTEYyR1dpUysvWnorekJRSlhsNmJTL0RsVFJUdENs?=
 =?utf-8?B?a0pWTHI3ZWxFYXJRRnZzaVFvVVlwN2ZUTVNqd0U1cG02MUNFVlR2Uy81aUVi?=
 =?utf-8?B?N0lqekF5cXZDNkdNaUJNaHNaT2FpNmkvMGFaUXlIR0FoVFZGZng5ZitnZzJh?=
 =?utf-8?B?bXplNDd1R0pDV2VBdlpTeisxdDFLa2ZjczM1NWV5U0JFZmZmaTRZSkp3TzZL?=
 =?utf-8?Q?tDyswVXI33ec8gCA+u8+7NRl3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56344ffe-b4c1-4ccf-d81f-08dd67c0c66f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 15:06:22.0564 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6psBU+uAos25DX+3RHKRSkaAVa6QQNB3S7mfcIZXWzAmSUDPCaAbSXBbO+ApEY3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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



On 3/20/2025 7:53 PM, Alex Deucher wrote:
> Warn if the number of pipes exceeds what the MES supports.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Patches 1,2
	Acked-by: Lijo Lazar <lijo.lazar@amd.com>

Patch 3
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 016af4e9c35fa..c52071841226f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -90,7 +90,7 @@ static void amdgpu_mes_doorbell_free(struct amdgpu_device *adev)
>  
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
> -	int i, r;
> +	int i, r, num_pipes;
>  
>  	adev->mes.adev = adev;
>  
> @@ -108,8 +108,13 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  	adev->mes.vmid_mask_mmhub = 0xffffff00;
>  	adev->mes.vmid_mask_gfxhub = 0xffffff00;
>  
> +	num_pipes = adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me;
> +	if (num_pipes > AMDGPU_MES_MAX_GFX_PIPES)
> +		dev_warn(adev->dev, "more gfx pipes than supported by MES! (%d vs %d)\n",
> +			 num_pipes, AMDGPU_MES_MAX_GFX_PIPES);
> +
>  	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
> -		if (i >= adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_me)
> +		if (i >= num_pipes)
>  			break;
>  		if (amdgpu_ip_version(adev, GC_HWIP, 0) >=
>  		    IP_VERSION(12, 0, 0))
> @@ -129,14 +134,24 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  			adev->mes.gfx_hqd_mask[i] = 0x2;
>  	}
>  
> +	num_pipes = adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec;
> +	if (num_pipes > AMDGPU_MES_MAX_COMPUTE_PIPES)
> +		dev_warn(adev->dev, "more compute pipes than supported by MES! (%d vs %d)\n",
> +			 num_pipes, AMDGPU_MES_MAX_COMPUTE_PIPES);
> +
>  	for (i = 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> -		if (i >= (adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec))
> +		if (i >= num_pipes)
>  			break;
>  		adev->mes.compute_hqd_mask[i] = 0xc;
>  	}
>  
> +	num_pipes = adev->sdma.num_instances;
> +	if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
> +		dev_warn(adev->dev, "more SDMA pipes than supported by MES! (%d vs %d)\n",
> +			 num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
> +
>  	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
> -		if (i >= adev->sdma.num_instances)
> +		if (i >= num_pipes)
>  			break;
>  		adev->mes.sdma_hqd_mask[i] = 0xfc;
>  	}

