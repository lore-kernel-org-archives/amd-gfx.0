Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88635C3DA7F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 04:52:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CAE10E09D;
	Mon, 12 Aug 2024 04:52:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vfwyFlQI";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC4B10E09D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 04:52:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+xlsFPGlTLFPAqZ/dcQx+k+bauEJUgE98ZDcPTg0i0IhzaQBkWGuzUBOWmzD/dMDjzYZhdRFYM8hHqfyetylCBYHfy4hRrZ599lKGW9Bq7TSF61GcuzLhnYygbbh0zfSniPhUBTBky4V/QiJ+qDctRIZXjjEnciAWAwOifGLSK7Fxl1ddttHYodPkQoVdTwz/a/3fwnCJq0vCQP1AX+tvYDJglW8d1SYfMgpRo49Urh2y/gu4PPdRohKxQt/n+b39GoGwMyeXU7gVrBuu9eGgoWJr9kdHb+J8pX5GnaQR5YVABLBmDEP9jWIu1BT8nq2H/1RT2nil19S00UBdartw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUFi5c0Nj08wPAmtpyzWcji2Fcj5dm+UvOHC+1evp1I=;
 b=CHhkrld1QiYGbyRxqBcALxLM2Yw/hQyWypJLMCoJFcYbRfTxL7KUnqaEg3XJXCJ99JWtFkIYm1rQ3RHsNFNijc90kKlSiTQkQMx9syenkZMcbyMWMVHQjssJYEYgAY4ISjPPF0EgbzUSV7HuI3cdKvKnt8XpH7caJ8tmO+KZBvgtLMcqVtJQxYRdpgnaGxk5+Sx0rjkxCM7Tx5DdGSfYLNdyvhnjYJEBlS2HPL2z7hlvvsCnEtKozSZujpNFkRPrfnx+BMP6YjnCqSMiXWsZ2wTp6cu0MQRuUXNAw+Sr+i7teqUs2YOnM92QJw2mrKzh94ItSt/PfVIdlH1PC2BrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUFi5c0Nj08wPAmtpyzWcji2Fcj5dm+UvOHC+1evp1I=;
 b=vfwyFlQIHduHydT55tJrjqXPSyka+BZHBzLR69hF5IDxWe/ouSdZJN4D+Q6iZ3CNnDnMx1l1ZijHpIepX6dbQMD+DpF/Ofuj5bt/mMnGfWtB6/94NthuqM11oavKLSiugc29zhRu2BnG/ZFflcvtetNCKqU2yxLhKaT+RV4cAus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 04:52:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 04:52:34 +0000
Message-ID: <12589748-95c7-42c4-9670-31cdf499a18a@amd.com>
Date: Mon, 12 Aug 2024 10:22:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Tao Zhou <Tao.Zhou1@amd.com>
References: <20240812032221.29060-1-Hawking.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240812032221.29060-1-Hawking.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: d498cdfc-83c6-43ec-ab37-08dcba8a94ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmRwWVY3L1Y5eTJLZWxyRlVjQ0dNTHZBNXVDbE9XVDN2UkJVZTRpRGlUamtL?=
 =?utf-8?B?MmhkTWxzVlRjbzg2SEZ5RTArbTNwZFE2Uk1XTFFvMzIyL3drWGVKVXNVRkhM?=
 =?utf-8?B?cGdRdExjYkNIcE8wYjNVVzNMNStDcWNKZ3g3cVJyOCtVd3AwaEJ4RWI0Sjgz?=
 =?utf-8?B?cXZrMjNaNjhPK1JSdkVlQjFxZmxhTGxPRjZKSDBxbW1WZE0zVURyQitGdmxq?=
 =?utf-8?B?NUp3MHJMZ0s1VUJ1MG9ja1FNMVVBNkVYU1hvWlpzUXZQM21BcURJY0ZEMkhn?=
 =?utf-8?B?Z0JLWDBZaVlLMGRQeHhWOEMzNVhhd01USE1yaTRweXdOWWRHcy84UHJRblNi?=
 =?utf-8?B?OURsaDJSSXJYelJQM01valJMZDJqNXBYc1VIZmtvbnJZRWNWdVRjMWpGYzZz?=
 =?utf-8?B?Y203MVRnczlPNmYwUWtZNURiOFEySytBVFdHR2hvcWR1cEtJamFmcWRyanJ6?=
 =?utf-8?B?SDUwSTB0R3duMHlYYU9sZzI3aTNDV1ZRKzNITEV6clNVcmxBa3orNFhqb1ZJ?=
 =?utf-8?B?U1RodUpoSHpvbG8xVWgxTlcyZmU3a1BuTGhWNkVLNmtadC9wYkJ2Mi82TFQx?=
 =?utf-8?B?TnY2eGhxMjY5UVFSNHlQSUdNZEo0UFZtaG41OGgwQTZMMGFZU1dpTjdRRXUy?=
 =?utf-8?B?bGsyUkJEajl4U2l1TzhDaTFiUXRYQXI3MkROQTlpN2NZL3NhUlpuMHVZMVN2?=
 =?utf-8?B?RWwwVXNOUTRsVEFueHI3bkhJUlplZmdjeWFpalBoWTBrNytPcks4bmZ2TEdU?=
 =?utf-8?B?QWlSTEp0and4aWRncjk3UjRBV3hLYlN2VkF6QWtXcWJFbGtkOUxOTGp1T3J5?=
 =?utf-8?B?TUtmWE5FSlh6S2h4U0FXUjI0VnpNUFVwQ1Ryd3dUeFhXbW1sMW9jOW9lUFpm?=
 =?utf-8?B?aDhzaTFPQkhPQ3dIM0lJNlphUXk1em5Jc0xiV3FXR1FhUk5jcTFGMmJwaGxE?=
 =?utf-8?B?OVlLRG0wcEZaVjQrME5XVXJxbHRvNWUrd0N0bW5xVkx5OUUxWVRVVTRucnlS?=
 =?utf-8?B?Y3lQNUpDUU9EL3Jtbzd3dTM0ekM5cVZaU0s4NXE0NkNYZmoveWkzMTVnbGli?=
 =?utf-8?B?U25hc2xpeDBEN2s5YmVjR3l2Y3pDK2dqa0tTa2VYV0JtMzdCeEovclIzcGN2?=
 =?utf-8?B?SlBrTVVaeEROcC9LMXBITloyUWQ2c2ZTVzVDRmV6Z1NlRFN2TThQSjlKRWxI?=
 =?utf-8?B?QVBLcUVRQmRFWlBLSkFuZlExNFE3OGs0d2VMT0hNZWVxSU1MVHFNaVlkc3VI?=
 =?utf-8?B?Z3E0RC9Mb243eityN2FHS25kdVRIUlB3UUJwank2bEZ5SWNWVEYyUllFUWNP?=
 =?utf-8?B?QXBkYzNXT2VGVVVvTG1yeUNFb2ZXYUU5L3htUHlZT3VaSFpWQzFTSk9yVjJ3?=
 =?utf-8?B?SVBPcVhYQ25lK0lxUkNrckRIQVRTc3FQU0RiT2tmSlNsQkNxZ2svcUp1NXF0?=
 =?utf-8?B?V3hpeDFadklYT0EwcHc3K28vYWtPNW9wT1BndHR0S2hQUDQvL1ljNWtQVm8x?=
 =?utf-8?B?N21YMlRmeUtMTkhwQ1RGbUJwZmRoZDFHcFl0TkpHY1pIZ2NSU1VuZFJHM3E0?=
 =?utf-8?B?eUlRK2hnZXNXYy9MaVV6Y2NXQjJUa3pQTmNoT1plTmthaXRxc3Z2eFBIeXZw?=
 =?utf-8?B?SnR4ZTBlYWNlcG4wR0hQb3hiNC9tUldqL1BvaXp6WHBqSFJWM2EvcUlzRHls?=
 =?utf-8?B?b1JMRjNyYUhIbGJVQ2lVRUVSUEsxRFQ4YjlRUnU1SERzZXloK1R2cmRJZnU1?=
 =?utf-8?B?dTlmK2o0WGpLRkpQTVEwejBYUXppbnA2UEQ1czIvU0lpbDExeWM1eE9hM296?=
 =?utf-8?B?YXN6eWgzRm12T1BBM20yQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHB6cG9pY1RZdzJqcnJqUVFOby90clBWOStxcGlydy9qYnd4ak9pTHh0Um1v?=
 =?utf-8?B?dkVUY3ZSK28rV2hPdnBaU3ZUeTJFd1BVY0NFVHQxSjlPdFliZlRPek9ZM1J1?=
 =?utf-8?B?YStLcFVkNnQzNldtV0Y5dzVuVFc3Y0V1YWVQRndYQXhVd0dSNG9ubFI5QnZL?=
 =?utf-8?B?UFBvdWxuNitVb3dHYm9TK3VQLzBlbXREZkovZCtSc1BqTFpERkVUbUZiTE1N?=
 =?utf-8?B?MERQQTdHR2hET2VOTHlnUXRtWGdsdWJCb0tBcWdlNUZ6Y3oySVdZNGNKTFJq?=
 =?utf-8?B?a3ZUS29Fa3RzTXBDbmJvU1hpQyt6MXUvWExCT0F3SU0xdEkyY3dOSE1MNXIr?=
 =?utf-8?B?cEFCVTcwYmJYM015SEV1V3JaN0lHT0ttMFljVTBOUG1FWmVmUkllSTdxOGJm?=
 =?utf-8?B?RXZZeHZGMFZMaGRlazVKV3pOTzdWUnpHTW52cUltQitzbWVvdE4rMzZpNGgx?=
 =?utf-8?B?SlloRUcyblM1RWtndTZyeUQyd2RpdWovRnlPR05RSHRtL0JPT0dXQ1hwL0FQ?=
 =?utf-8?B?N3ZOSFdlWUdoT1AxWURRMkVBZnVwT1FFdVY2U1FNWUt3TXNxWk16QTIyeGN2?=
 =?utf-8?B?VkcxaE9hN2RldFhIOVlkaTZoUXUyeUFqcmJnU1NTZmZzVjRsYjJjOEJjZU83?=
 =?utf-8?B?MGJZbjZLK3k2Snh2N1dWRlFlc1EvTDdXeU5NRWMvcTY1MmVwdjNUb0E4MEhR?=
 =?utf-8?B?TGdJYlVVNXhtc3JoQU1ZVCswb1pkS2I1NzZwNkg0NGRYdnhXQkVKcVQ1MEwv?=
 =?utf-8?B?UXIrMm15Y1JOMVBGQ0NJMGI1UDZ3STJ4TkZGSW93ekU2R2xJY0RRZmxqWWY0?=
 =?utf-8?B?TXptN1lib2RYcmxybE9PZFVadm95NVdSZUc4N0djSm1iM3diNUlWcVdyMXlX?=
 =?utf-8?B?ZU5mTFcxV21ZTU9Ra1R3ajFXVlQ3dXdJdUNzOTRLdEljNGNiamJ5YnlqNWc1?=
 =?utf-8?B?enJ5T0txSkZxVE9aOGt4U3RGTjQ3bmhnMWxZUVQ3S1hpclFvMEE0S0xjN3V0?=
 =?utf-8?B?eWpTUzdnSCtGUXBMUXBwbFM0T2lZUHFveCtCaWpObXBuZTFsOEVGdHVtNHFj?=
 =?utf-8?B?b3ZSVGNHUW0rSnNxcGt4QnhmSEpCdnR0Qys1NTg0T1QxNzVaUlRpb1MzZkVB?=
 =?utf-8?B?YUlQczRYcDR0a00ra2dTOEVkeTBHZEtVanVjWDB3cCtoeGlqekVWeXVLWWZW?=
 =?utf-8?B?YktRTkFCcWhoV0plL2oxS0w3YnVnc3BVSnRwVmxoVE95eWlZTUtUTEJYYnZ6?=
 =?utf-8?B?TlF0eENGcldVTUxoazRqWmhaVE5ZMHU5VTZZamNIRlhmM1pxcGZYVzJkM1FL?=
 =?utf-8?B?SFBPWTB1dHA0QnljSUo0Rzg4dEUwbnBFd2NlSHNrM3lCTkpWeE5OdEpWd0E1?=
 =?utf-8?B?K2tQbWRPSkhvNFpwNEYwcWp0cG9lZm9vdFpCOHV4dUtFTlFtSXF0MmxJV3Yw?=
 =?utf-8?B?N1hVNjQ4SUlLUlBjb1laT3lTeG9tMzRrWFFPZDg0dGhneXhTZEcrRzVFYUdj?=
 =?utf-8?B?QzF2UVNWRmgyVjJEcWdJLytCc1FjTnZUZG11RVFHbCtMSHVBY0lmbjhGd2F1?=
 =?utf-8?B?dHJ1VnRXWUVMd2ZKTmVIejJLa0t3dnNERlRUczBCMDA0ZXE5TEc2NklZbVl3?=
 =?utf-8?B?SlpqMUR5SmlkTnpSUWFWYm5vUE1udWlmZGJua1dCQzBBWExqcUFna1JJZHFz?=
 =?utf-8?B?Tmhjd2k5RHlqd011aGdYZmtBcGQvTXo4RjZjR0o3a0tuNDl2NGJjTWp4RWVr?=
 =?utf-8?B?SWJpVy9CSFdrUHIwWlo3TmwyVUc0ckhwdE53TW1nTEdjMDZwVHFMS0MzRDlo?=
 =?utf-8?B?bG5HNVVMZ1Q3L0hwc0tSclNqQzkzQmFrL1Yzbm1KdkxKemdMS2J1eURmbWRS?=
 =?utf-8?B?TDE4bnhOZVJKQWRiQ3E4NGdSRHdRSG9nMlhRc25idmhPeEVTalY1Y05RQ0ZM?=
 =?utf-8?B?MU5KK3RmSzdVTFBNY0wrbjZQS1BRVmI3S1J0WjJuS0xGT1gzTHN4REUxb2Vz?=
 =?utf-8?B?eEtYSVhhQ1VWNjJqOU9sVlM4Y0c0Q3NhY2tCQzZJSjQ5WUVUaXJpeEtHRmpI?=
 =?utf-8?B?cTRkRU5Kb09PSU9aMHdLd0lzVVUwYWk0bDFmR2RRUUlDLzM2T0tkQlRRNy9o?=
 =?utf-8?Q?wFeKhoxrdKCNg6U5J1+itz/nj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d498cdfc-83c6-43ec-ab37-08dcba8a94ac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 04:52:34.5508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8ypakNjUTlqcVe4bWQb467ExanIuhFt7ygSeJ+d9xk7q9zWYFojVVUB9juGaRXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130
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



On 8/12/2024 8:52 AM, Hawking Zhang wrote:
> TA should not be loaded from guest side.

Does this apply to XGMI TA?

Thanks,
Lijo

> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> Reviewed-by: Shiwu Zhang <shiwu.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 85ec9e35690a..749d8143b1e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -132,9 +132,11 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
>  		    (adev->emu_flags & AMDGPU_EMU_dGPU_SIDEWINDER))
>  			break;
>  		/* It's not necessary to load ras ta on Guest side */
> -		err = psp_init_ta_microcode(psp, ucode_prefix);
> -		if (err)
> -			return err;
> +		if (!amdgpu_sriov_vf(adev)) {
> +			err = psp_init_ta_microcode(psp, ucode_prefix);
> +			if (err)
> +				return err;
> +		}
>  		break;
>  	default:
>  		BUG();
