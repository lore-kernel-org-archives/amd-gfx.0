Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F83D12D71
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 05:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5421810E116;
	Mon, 11 Nov 2024 05:58:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VD9wMWjS";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328BB10E116
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 05:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKPK0xzX+6Y9iHUNdM6FqUNPsVZcU035rjjrNdC8LVhvz1OA9F3ha/p9UvL4WmTsAuldhPrXcmlJgiilKDHBVdRk6RvnuhI24ZqAulV8zR9fLUDiekD1MpHwetLFFakVV4mJs7ZF2snomx8eHm2XheRV8r1AanQ1pQhWfjEYTIN69GERXL/kWFEQq6h2w8SKd1AcfQyULDfhxQDk6M4iZrIvKey2A9Y5aSB15pGRnbblnFZulLG0QRPvvqmFM0MqJM1T4nMiQtntXUcN+rYpTOqTarAIQqAQRkzR0L+xsGUJCvuFYv3aWxAjkcdcAc+UdnoH1AEUrpx41w0rl0nj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vJP1wJq54nXZUm/jpPmzCLTxdSCVh65XPLc/vfYg2A=;
 b=HeQumOs3ftjVVRhMn9JT01hECliPlp/rj8CrE1C8vMnKCEZYafaBSETAVFlq30O1Fb5vt8vuuKdG80Uz0NbJAzYL2uwGw12KpYzxA78a5qrQJDelWVcFhrqVBzavD9Fu5/y+WJsIlD/Ov1P/cVfyfjv2Go/y7R8oEH01Sv3TJ5It0rWfIjYQPFTmZDnfYKafO5sPX2xAv3seQDW+z+wXpkpuCQS3fiS5pyh6B9/2t/u8gowTbYZQyo9uhRbOWKbsbFXJMI97WKXbq3F7uK171pumWmYdqHingmUMjaNKQkwnu8XKT9kZRBagMk4Ryt5TQzofJj3QL/afbnuarO3kdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vJP1wJq54nXZUm/jpPmzCLTxdSCVh65XPLc/vfYg2A=;
 b=VD9wMWjSSj5I7aHq5V4S4W5xG+lf8N4yUXK/mI1E8DX8DNgFoex9AxlEeO/0Y0HoTk+LIl5J3SK2WjM5igyr0lK8X66o8XQXRorB3P5tmnpgt6kBpnRYNRf5SY//skTVT4GkQvYFwyZNZIKffH2N6I9SrahhpImfLQQ+EZltiMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Mon, 11 Nov 2024 05:58:55 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 05:58:48 +0000
Message-ID: <6950b5e1-c283-4029-84e8-7dcc42b16912@amd.com>
Date: Mon, 11 Nov 2024 11:28:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20241106063322.2443403-1-Victor.Zhao@amd.com>
 <20241106063322.2443403-2-Victor.Zhao@amd.com>
 <CADnq5_NDDBsWrZvxQrCk8-qXfk-xBUBTM62SNawC__BANtpjOQ@mail.gmail.com>
 <6dc831bf-f7d8-4e9d-98c8-8204b330e466@amd.com>
 <7c8e9102-0d4f-405c-8749-1653118400f1@amd.com>
 <BL1PR12MB5269C32C36AEBAE40FBC131A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <BL1PR12MB52690F8688563810F74A261A845D2@BL1PR12MB5269.namprd12.prod.outlook.com>
 <7c0bc3a5-756d-4c60-b459-73a2ee910ce7@amd.com>
 <BL1PR12MB5269AC1E12A48107FA87A03084582@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BL1PR12MB5269AC1E12A48107FA87A03084582@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067EE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2a) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a2c3039-710b-4f08-154b-08dd0215e916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TExRK2NpMlNhTzBwbU8rcUZHbVdZWC9JbXdsb1dFc2NXMkJoZ2ZsczBUMGRv?=
 =?utf-8?B?T2lOOUxkRE1aQVN2eHBtSGRjY1FnNUxIWExId3ZkQVA4eXZVTmt1RFdXWU15?=
 =?utf-8?B?U0grTm1Ibytuc2l4NWF3SktIOHk5N3licE54ekVTUldXNC9WdmRibVR2cVJz?=
 =?utf-8?B?MTZSdDRxYkRRQ0dsRlpJbzBoK29CdHRsUVdqUXBzQmsvZmUxN2ZPaTRJQ0xr?=
 =?utf-8?B?UU0xckxqcU4vSENKYmhPczJmWVhqb0gvUHR0amRKMmtaUGVVRzBNY2t1eEsv?=
 =?utf-8?B?OHk2Rk5hTkZTanczWW5oZ08rQXJSSGdGRE52dVY3TUNzZkdOSG4xUDl1ZFd4?=
 =?utf-8?B?WndxMlp1Um9qSjdTU3YyRk9pMXR5a3ZhQm9Uc3NJNS9WZzZDWmEzbXBQWUd6?=
 =?utf-8?B?d1BMRWtlWUNIVHBzNi9KWjFGYTJNeFg0SmRQR3lTSWs3cUlLR0czZG56em4r?=
 =?utf-8?B?NmJ1Y3l1S3Z2eC9xdUFsZE4rNVRTUzk5S1ZKOHQ0MFNwYS9JY3NmMTh4SHU2?=
 =?utf-8?B?REZDTDlPcnI5eFRwd2dtR0grYmk3eXZhNFZ3VW9FT2NDUDFMME5RWUJhZHZu?=
 =?utf-8?B?TnV3eUFrUVZDY25hT2dpc0tvTjVMVDl6YVQ1L2lXYXA3YmptbTN0a2w4eDA3?=
 =?utf-8?B?QUNHaVRYQ2RhYTkrcnVjRjkvMTc5ZmFOT1hvVVlzMjVtUXhSdldXNlpxMHd6?=
 =?utf-8?B?aHFmRzRyaDFRN3ZUVE43QU9JZlIyWkJBRmlUejI0QmdiMG0xdkRlSkVmUnZx?=
 =?utf-8?B?OWQ1OEhjMTlybmdsS1RTZW9mVnh5TFpjNStSV1dVaHpId0phY2RVdkZNalNx?=
 =?utf-8?B?TGpleUJCdW91cjBnVTM4RVh1M3VwbHNOT0dzMlk5eko3TllRVll5Q3Nvc0Nq?=
 =?utf-8?B?a0xCTWNFeXBNeCtWd0hOVFk0T0c5QjR5dHVXaTBmbW5Gb2ZDdEF0aVlrSWgw?=
 =?utf-8?B?NEgxVmpibGRxSFNRblJucHFtdklDWGJCcnZxeW9QYWMxVU1XbUM4bkpNc3FB?=
 =?utf-8?B?OEVhdjk2UDY0c0FsdE9xQ0JsNVJEV1AzM3dXR2NlbkQ3WFFVTFB5UDRhZTNH?=
 =?utf-8?B?TXk5eGVxSEozQStHSkhHSkRiMUd1M1NPUkxqUUQ3RDNMclJxTEdlRWF6ZmZI?=
 =?utf-8?B?bDVHbHZwdHpxZUdjQ2YwWHIrOUljZmtoNWZpNC93K1NyeTNmdm96dHNtOG5u?=
 =?utf-8?B?MXJyK1Vpc1lCSjJSS04yZHlRRGxFa216WmUydzhvYWowY2dmaTVKSGxaRTlU?=
 =?utf-8?B?a3FCQkN0YTdDV0U5VkFGUkE4Yk0zWkg0L3FnWWZrekJKUUliNXpvWkxIczdt?=
 =?utf-8?B?QXJmT0JtdWFRam9kaksySGVZazJYZVdxYmt1KzdBYlZ5bytORHBOd0pmMElt?=
 =?utf-8?B?KzVWdm5ibHBiOTRBQzF5YUpzMFhXL2hwQnFvQkJDL1JtZW1GTzY4ZDBWUlh5?=
 =?utf-8?B?NTRpcEdrN1BEd0Y2YzUzT1A0b1lzMklPL1ZQUGxLak1OSlhpMmJScUtvTXMr?=
 =?utf-8?B?dXA1WDNwL0libmlOZldDMjI0cE1tZDhNZTZYa1cvSWpTNkpRMTRoNWtQZzlV?=
 =?utf-8?B?b0p1bWEzYnZwYzgrZzlyUXF1MCt3cnNjOElnT0RTeGJWUFh0M1dmbGlxYWhH?=
 =?utf-8?B?NmVHdXpHWjV5WHF3d1AvSGZXVnlaNm1OZVhIZEh5ZnFma1J5Wk5aSElncGVF?=
 =?utf-8?B?TjFnbXY1KytqRVJvUGg0N3lobTVzTUtXc0RjcTRNQ2dleENsTVRrUkwzdlNt?=
 =?utf-8?Q?GT24sdsPRXmm18VkKy7ZIbojuyv9XvBFGSJXbSP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnhDS3AwUzRJYk1iTzIvbmJ0dEh1elpnYSt3L1I4M2wrdjYzdWNwdHV1Z05o?=
 =?utf-8?B?bkZ2cU14NVc1R09zcXJZbURQWCtOU0o4RHEwMjVTaUVBa0FxS3BxdUtnaXY2?=
 =?utf-8?B?TDhPNFZuNkM2dm1tbFJnV2c2c1ptNWpidHZDdkNsVm9Pb1ZsS1pDYm5TOFZ2?=
 =?utf-8?B?UlNpL2N6aDJ5WW1FT2RBdFV0R0hvSzluT0dZYTZGVVp4UFQyZEFNVEFaWVpJ?=
 =?utf-8?B?bHMrOXBCU2VFZkRQbTJkZ2w2VGlBV0pJcTRJOXFpbkZ4bXQ0SzRuKzg5VGJF?=
 =?utf-8?B?QXAzQXRnQUdiQjB2M3hJTStLdW9zdW1SMEFkZlVZQm1aNlUrR3RIbTRBWTY1?=
 =?utf-8?B?cUNqSkpZbmd0SXdnVUw1K0YwOXR0Z3RScW0yd1NrR3M4VUZObS9jLzdNYkF2?=
 =?utf-8?B?T3pja3BlbDBsZmltVVFCY1daTTBFOXZJbER1Y01SU2s2aGdBTFQ1RysxeVJK?=
 =?utf-8?B?WVhKbEdjelFZLzZzSGZkakRjZUtGTWoxTThpWkVJK0l4dEhSQjlIdDZxNGpx?=
 =?utf-8?B?T2tGbnJFK2xFMitrdW1Pd2JyRFIvTVVqcmI3RnpCTnJrTFhnOC9IMjA0RWJp?=
 =?utf-8?B?eTBjdk4zYUlkc3pnRjl4OUg5QWx5ZnFRN0NEalNCQVJHV0VWUEhOU1Q0RVlH?=
 =?utf-8?B?RmpPOWNOVyt3SVcyUlV1dDdiSHAzQ2lKYXE1QVdwQm94c2VLSjBHL0NSU0Iy?=
 =?utf-8?B?N1huRjFVZlUyeVhOMU9DajNUM1c4WURsMDVLZno1TDJrclJCemhNZlg4M0cx?=
 =?utf-8?B?RG5QMUF3cHFDbFRxVVlUMXladU1VSm5MQWZEVjJmR0t0cGlBYzd4S1dZaGNE?=
 =?utf-8?B?bGJ2QnluYzZDQ3dwQmt0aFFyRFVVcklwZHNNM1A0djNlM2pyWFBxYUZiZ01G?=
 =?utf-8?B?alhGR0w3c2dWVytSZ1VXUCs5ajlRdHJhMDFZbk5yMEg5SWF0cm9KbkdVSlg5?=
 =?utf-8?B?eDZoK0RxVDJiREdqcVV5Zk5Ub2J4WVFETWVCRnV6Y0h4clNUL0FNaG1oRXV3?=
 =?utf-8?B?dGowUWRIS0c3bzVoU0hMSERGM3RVSFd1Q1oreXV2UVVVenFYeWZCcUxyUkJI?=
 =?utf-8?B?UDhNenFrZDBKS0U4WGJyRWRTdWdBcVlQeDA5TnNJRm4zSTZGcHJHd0NzSlZF?=
 =?utf-8?B?RUErdjRFbjdMZi9wcjFCc2cvdmx4SG5uelRJTFMyRGlZNmNaWnhDN29Rd0VZ?=
 =?utf-8?B?ZWIxWGUzSHNIMU5hTUNLekw0cmV3VkpuUU9UQ3pDMjVCTEl2U3lZTWZHdDh6?=
 =?utf-8?B?SFpTYUZ5NG9XRWdpSnk3Vmp4ODBKSFdpbWw5T0R5dlRBekhWMnord2l6TXdz?=
 =?utf-8?B?ZDh0VElpVEtLeU1aMUJpKytNSWtQazNhZHF5VVpvUkhzS09oOTZhenpFYU9s?=
 =?utf-8?B?NlFjKy9DenhON1dpdXIyeC9vYVM1ay9JODZVa2FJOW1JNlp2VnlyTFVHd1Ix?=
 =?utf-8?B?dUsvcmh3TEtiRmtSVFdXZTFobjJPcWVQYld3cHRhTzBlNng2d2MvZldoN3ZD?=
 =?utf-8?B?cXlrYk40WXdXVS9ac3ZPWVQ0bzhvQmprcmQxdDRnazFueTZ4b1ZiVFRJSVp3?=
 =?utf-8?B?WlZYL0FWYUdxbXIxTmlZUkNKZzVLNFF6Y2NCbEJXY3lwNXFVSzhHdWw1MHVQ?=
 =?utf-8?B?dXVwRGJuSlRTVWEreGJyUjBJODBITlhwUXorN0E1WWE1YXNkY3RyV21mRlZI?=
 =?utf-8?B?cngvajR4M0pkRGlENFBzQXZoeStBMkFSM0pKSFVLcmNQQUVKb3JpbjZPOG5M?=
 =?utf-8?B?WHdUZ2lTb05EOUJ2UVlpaUpUL0lTT3p5QlUyUGlBZjhRaXZXdEl4Tm1DdkNs?=
 =?utf-8?B?aEdueGVhMnNVYjVYSnJBS08wMDltNmJQOVI5alA5TDUvK0F1RWdRNDRzSzRt?=
 =?utf-8?B?TTFsdGNtNkgzcFRTOEI5TURoTkw0YzF4eUdKcFdTemhsL0FBTWc3VVpNSlBr?=
 =?utf-8?B?dERJMGhKM0xKTDhHWUhRdU5YVFpXdG1rN3pUdmdhOEdQL0FmKzBSc0Z0Nkly?=
 =?utf-8?B?T09NTktjak1INW1DemdnNCtHellrTEd2ZGVnLzhkYXVheU5nSjNXSnhDT05u?=
 =?utf-8?B?ZUtzRWt2aHhDV3p2MERhaVZSREN2WE9EVHBicnQza3czTjdqSnd5YUJlNzJt?=
 =?utf-8?Q?OCj3Vq6IheomX0wBsKoM5bznF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2c3039-710b-4f08-154b-08dd0215e916
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 05:58:48.8098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6POVFxQeDtRiN/k0hfGipxt3WPwUYMbuV01eQVacQdAOvAvi/ZaKpKescjW1WT2K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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



On 11/11/2024 7:00 AM, Liu, Monk wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Lijo
> 
> This is the patch we verified before:
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> index 4843dcb9a5f7..39553c7648eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -308,10 +308,12 @@ int kq_submit_packet(struct kernel_queue *kq)
> 
>         if (kq->dev->kfd->device_info.doorbell_size == 8) {
>                 *kq->wptr64_kernel = kq->pending_wptr64;
> +               mb();
>                 write_kernel_doorbell64(kq->queue->properties.doorbell_ptr,
>                                         kq->pending_wptr64);
>         } else {
>                 *kq->wptr_kernel = kq->pending_wptr;
> +               mb();
>                 write_kernel_doorbell(kq->queue->properties.doorbell_ptr,
>                                         kq->pending_wptr);
>         }
> 
> 
> This mb() doesn't resolve the problem during customer's testing, I also thought of MB() first in beginning like you and Christian ...
> The mb() here shall resolve the re-ordering between WPTR and doorbell kicking so GPU won't fetch stalled data from WPTR polling once it receives notification from doorbell kicking.
> (in SR-IOV we set doorbell mode to force GPU still fetch from WPTR polling area, doorbell kicking is just to notify GPU)
> 
> And by your theory: mb() shall flush the WC storage buffer to memory, thus, this mb() shall also make sure that the ring buffer is not holding stalled data anymore, right ?

This is not my theory. All the quotes in my earlier mails are from
"Intel® 64 and IA-32 Architectures Software Developer’s Manual".

Yet another one -

<snip>

Writes may be delayed and combined in the write combining buffer (WC
buffer) to reduce memory accesses.

"If the WC buffer is partially filled, the writes may be delayed until
the next occurrence of a serializing event; such as an
SFENCE or MFENCE instruction, CPUID or other serializing instruction, a
read or write to uncached memory, an
interrupt occurrence, or an execution of a LOCK instruction (including
one with an XACQUIRE or XRELEASE
prefix)."

</snip>


> But we still hit hang and get stalled data from dump.
> 
> Maybe we need to put mb() in another place ? can you proposal if you insist the cache mapping is not acceptable to you and we can ask customer to verify again.
> 

There are a couple of things which are still working strangely, they
will need some explanation as well -

	Even though write pointer allocations are also to WC region, and are
correctly seen by CP every time. Since it needs to get wptr updates from
memory rather than doorbell value, don't know how your snooping theory
works for this. Also, it is weird that WC writes to those pass MQD
buffer writes even with fence.

	MQD allocation for user queues are still from USWC as per your latest
patch and they still work correctly.

For debug -
	Is the WPTR reg value correctly reflecting the memory value? Have you
tried initializing MQD to a known pattern (memset32/64) like a series of
0xcafedead and verified what is seen at the CP side?

Thanks,
Lijo

> Thanks
> 
> Monk Liu | Cloud GPU & Virtualization | AMD
> 
> 
> 
> 
> 
> 
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, November 8, 2024 7:26 PM
> To: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and wb pool
> 
> 
> 
> On 11/8/2024 4:29 PM, Liu, Monk wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> To be clear for the mb() approach: Even if we insert mb() in prior to amdgpu_ring_set_wptr(ring), GPU might still fetch stalled data from PQ due to USWC attributes.
>>
> Inserting an mb() doesn't cause WC buffer flush is a wrong assumption.
> 
> All prior loads/stores are supposed to be globally visible. Hence mb() followed by a write pointer update also should guarantee the same (From Arch manual).
> 
>         The MFENCE instruction establishes a memory fence for both loads and stores. The processor ensures that no load or store after MFENCE will become globally visible *until all loads and stores before MFENCE are globally visible.*
> 
> 
> Ignoring the amdgpu driver part of it - if mb() is not working as expected as you claim that means something is wrong with the system.
> 
> USWC or WB for ring type may still be a separate discussion.
> 
> Thanks,
> Lijo
> 
>> The issue here is not the re-ordering but the stalled PQ.
>>
>> Monk Liu | Cloud GPU & Virtualization | AMD
>>
>>
>>
>> -----Original Message-----
>> From: Liu, Monk
>> Sent: Friday, November 8, 2024 6:22 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
>> <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Zhao,
>> Victor <Victor.Zhao@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>;
>> Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: RE: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>> wb pool
>>
>> Christian/Lijo
>>
>> We verified all approaches, and we know what works and not works, obviously the mb() doesn't work.
>>
>> The way of mb() between set wptr_polling and kicking off doorbell is theoretically correct, and I'm not object to do so... but this won't resolve the issue we hit.
>> First of all, USWC will have some chance that the data is still in CPU's WC storage place and not flushed to the memory and even with MB() get rid of re-ordering GPU might still have a chance to read stalled data from ring buffer as long as it is mapped USWC.
>>
>> This is why only cache plus snoop memory can get rid of inconsistence issues.
>>
>> Besides, do you know what's the rational to keep all GFX KCQ cache+snoop but only HIQ/KIQ from KFD configured to USWC ?
>>
>> For performance concern that looks to me always the second priority compared to "correct" especially under the case HIQ contributes very little to ROCM performance when switching to cache mapping.
>>
>>
>> Monk Liu | Cloud GPU & Virtualization | AMD
>>
>>
>>
>>
>>
>>
>>
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Thursday, November 7, 2024 7:57 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher
>> <alexdeucher@gmail.com>; Zhao, Victor <Victor.Zhao@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Liu, Monk <Monk.Liu@amd.com>; Yang,
>> Philip <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH 2/2] drm/amdkfd: use cache GTT buffer for PQ and
>> wb pool
>>
>> Am 07.11.24 um 06:58 schrieb Lazar, Lijo:
>>> On 11/6/2024 8:42 PM, Alex Deucher wrote:
>>>> On Wed, Nov 6, 2024 at 1:49 AM Victor Zhao <Victor.Zhao@amd.com> wrote:
>>>>> From: Monk Liu <Monk.Liu@amd.com>
>>>>>
>>>>> As cache GTT buffer is snooped, this way the coherence between CPU
>>>>> write and GPU fetch is guaranteed, but original code uses WC +
>>>>> unsnooped for HIQ PQ(ring buffer) which introduces coherency issues:
>>>>> MEC fetches a stall data from PQ and leads to MEC hang.
>>>> Can you elaborate on this?  I can see CPU reads being slower because
>>>> the memory is uncached, but the ring buffer is mostly writes anyway.
>>>> IIRC, the driver uses USWC for most if not all of the other ring
>>>> buffers managed by the kernel.  Why aren't those a problem?
>>> We have this on other rings -
>>>          mb();
>>>          amdgpu_ring_set_wptr(ring);
>>>
>>> I think the solution should be to use barrier before write pointer
>>> updates rather than relying on PCIe snooping.
>>
>> Yeah, completely agree as well. The barrier also takes care of preventing the compiler from re-ordering writes.
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> Alex
>>>>
>>>>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> index 1f1d79ac5e6c..fb087a0ff5bc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -779,7 +779,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>>>>          if (amdgpu_amdkfd_alloc_gtt_mem(
>>>>>                          kfd->adev, size, &kfd->gtt_mem,
>>>>>                          &kfd->gtt_start_gpu_addr, &kfd->gtt_start_cpu_ptr,
>>>>> -                       false, true)) {
>>>>> +                       false, false)) {
>>>>>                  dev_err(kfd_device, "Could not allocate %d bytes\n", size);
>>>>>                  goto alloc_gtt_mem_failure;
>>>>>          }
>>>>> --
>>>>> 2.34.1
>>>>>
>>
