Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F0ACCA470
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 12:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9096310E563;
	Tue, 30 Sep 2025 12:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbtwj8b0";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A5610E563
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 12:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyCjsblUQDG9WRkxQSSk/iC1vZ4OVA0qMfJ720nER9JGkxGa2CIwD7hCJ0ocfy39283BGEdy42/yd8XMm67zxdDUsYtUg6yCT9zLXqbizCv1u9iZ/VC+TTpEf+n02RxcVqdGSW7k6HCM+Icus/N+IK0dNySlpwus2RKbrddAjF7vcfr26tzkVfD093UlOb26YXfWSZsp6oyvBOP/J2n58cqN/rzu4KJdRX6GxXp+QI72RmIk8Cw5RJh65oDHkKtHxy2fzHOp7z8pwxXmRcaGlhIFQjCfWbOuLeY3qpYfe0w7g60WpWq0iSwwd9aPXVMBotQR10eSDQaHifEE+XFH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtjxIGBriO5VFHyDAiH3r8Zn/G1GmJiIx/CDFfBZsiM=;
 b=M669lgTckG9t1VpIN1ZMcTmD3/ZySe2XsFVAk6lDVpkFLHkPtK3m858s9SkX4yXAe5/JXLTWz+8Fq911lP4BsAH4r+Nu49RaqpNgM5gdB19s7TyJ6tLvH0uu503+dD7UZpeUUHQZQM0D0K9dmhd+cV5aJGQbib/GAqQb00vMukvvn/4tm/qIMxo+q8uq5TWktmfF59XOeS9nh2BTutFlXRCrRiLiNAsmLDCzpyUmVHrGCNpq7OHXeTHxJ21okSnj4hDmkF/nl3w7vpCF8kWZFFlOCThk9wBIolhb2nQPsPmlztOpLVMYvDGNH4vp1sQAWtg8r04rPrudA4ZE/8Nqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtjxIGBriO5VFHyDAiH3r8Zn/G1GmJiIx/CDFfBZsiM=;
 b=wbtwj8b0+zMt+GNZA8cgtGobYYVm1WDeqwxz1twofGS2GLhfIcs4cnqD+l9zi+Adxf1gYnujLY4HQVVVNnxftiR1ar4iR1SpOVDcZ4E1O47UrhJc8WzvR25rCjKVPiE7O647TEdqLiNGrmMeRwgIeppld/R02GaSCQzsisUsKnU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA3PR12MB7998.namprd12.prod.outlook.com (2603:10b6:806:320::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Tue, 30 Sep
 2025 12:03:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 12:03:05 +0000
Message-ID: <593f5887-f791-4c5f-ac91-b96a95c94a79@amd.com>
Date: Tue, 30 Sep 2025 14:03:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v1] drm/amdgpu: clean up amdgpu hmm range functions
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250930082711.1278523-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250930082711.1278523-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA3PR12MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: db8bbdda-b3da-43de-b10c-08de00194fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak1zWDZ0Y1dzcFdyRGtvNG1DVk5WNlU0NmRRK0h5enZ5VGV2VWQrelZsV3A1?=
 =?utf-8?B?WTV2NXByU0NSRUxadUxraG1nd2U5V1AwYVRzMU91VHY2c1FyY0ZsOElxSE9q?=
 =?utf-8?B?MVFOejk1OVo3ZzMzdkJtcDhJUm40RitMOTVqeERlMmxPbkFnVlJhRlNmYzNC?=
 =?utf-8?B?bmNzbEtKK3hMY2Y3V0NtczBFVmRqZXZpNVBJT2F1TDhOenBlZzF4WERTcXE2?=
 =?utf-8?B?VEI2M0hnRHJ5V3E5aWlMT0hObThpM1VYK0t0anVWQUtqRUMxZzg3dndWVk9E?=
 =?utf-8?B?UVpNc0E2Y21ldzg1ODd0dk55TmJWN2RTeExoSDJVaTZNQm82MlA5Sm44NjVS?=
 =?utf-8?B?Z2VjTUpCWGM3Y1J5dTR1Zmk0YzMwYlJ6bHVIZUlYMVlCR2k5QXhUZDZzbUlq?=
 =?utf-8?B?NGNXUElXWHQ5Vy9Wb05IelpBa3EzL2diaHQ1WlNnaWZUZDF1Kzd3YjJYQjNp?=
 =?utf-8?B?d2RMaTh2M1AxanhpMThBSDFxQjFHNEp5TU9XY1JOVUNyWVJCc0gzMkpoSzh1?=
 =?utf-8?B?U1pmYmtSeS9xSFFqWUIrNS9OVFI1QjFuMExTdmk1YklPT3c1QjR5Mi9XZTlU?=
 =?utf-8?B?TjA0cWVuUDV1eS9vbGNsUW9ia2VXZzZ0VFhOY3h2eld4cERFbW1lbWFqcG9N?=
 =?utf-8?B?dm4rL0dsYW9zT3Z6UTlISTNYbmY2UTB3VEp1Vyt1eGxlc1N0MUpTUCtpTU9n?=
 =?utf-8?B?bnNacFh1Yys3Um1VSXNIZGxnaE4vbVVXay92ejU0U01LbnQvOXJ1VnloM0I5?=
 =?utf-8?B?a2NkMWc2OVpVQ09FWkFoL2pZZ1JWMGNhSlRpM2lubk5UTVc0K1gwd2JEWlpo?=
 =?utf-8?B?dTIvdjhvRFR2Y2txTXFLVitsRXpHK1NhcUpwTFFDYUM3TlZFaEJteSthUVRU?=
 =?utf-8?B?ZHVETlp1Q2F1YWZscHE0UlFobjkwMmROcXNmd0tlWnNXMmJ4WHNaOGVRNlVx?=
 =?utf-8?B?Tk5kRm9OazROUkt0SUZINmJRL29mSnJJMUoxRkNMbHM3clZlZUc0YTFpMVRl?=
 =?utf-8?B?K28xVjNFalBJbVdXYXpxOWVtb1F2Tm1xaEEzL2RsRnR1bmpZeTUzRGl6TExr?=
 =?utf-8?B?akxQUFlpbDJSVWFTNVN2S2tSOHg4bjFKNG5wRXUvUEFpeEtBSWRjTjVqMENE?=
 =?utf-8?B?UGVTTlp1NWRnOEFjbkp2ZXpmK25ORmtUNVBBeG43Tzd2dU9yV3VOTE4raVpw?=
 =?utf-8?B?OXJ0YlNLbXI4cjdXVkFweUhJTTg1RTF3VkZmdU1SOVVSTmc4Ylg1eVJkaS9s?=
 =?utf-8?B?Z1haNmlsU01yVDZaN2p5bFF5S2hKZnJWblI3VWpWTXIwK2JSZXB1UDMycFJt?=
 =?utf-8?B?TUtZZjQrTHgwdkxneVpkQkJmTHJoY096bS9ocVpsVjBybDF6ZmZqRnB3ZUxx?=
 =?utf-8?B?UVR2WWNaYXM0ZFQ5bDA0L0dhT2lnL0E3Y1FOWHFLRzZhY094OFZrWGZHVHVi?=
 =?utf-8?B?NmsyRmtKbE5lbXhXOWVYSE9FT2pKR0YwU2VaS1FtVExISDZOZzFaalVMQ3h0?=
 =?utf-8?B?RWZxYjIyZ2NkT1VyR2ovci9KNlozbFl0R3J6cnRSLzZmSHRGbkV0OU5iMHcv?=
 =?utf-8?B?bVIyS1ZIZFNCb1JwRmxJRHgrUjBCUjJBb3JxTXVMM3BvaHVUQXBiTEdScjlQ?=
 =?utf-8?B?bXNXVGtJRHNoMWd0NVZaZnJuSjNPOHBlZFk1Wk45cnk5NFlGUy8zM3VWcEVO?=
 =?utf-8?B?NEpFSnd4VGZmUWI4N1dENTcvdElUNWVCcHU5b3RjWlo3OWhQWjZJWkFETHRy?=
 =?utf-8?B?cXFrZlFLcCtxekJPdUtEN1F3YVZXaGY3Ym0yMk5lMklzcWxJeDMwa1U2YWZM?=
 =?utf-8?B?YWloTGVLVHArMlV4N1FSUGhNY1pyUkJVQmRqakk0NEZxZHRMbjBneWpMU1Z1?=
 =?utf-8?B?RXVuVTZDQVk3R0l1aVZYZHdCMG1GemxsSGhmL1pGOEc4UFgzU0Vhck1LcXZu?=
 =?utf-8?Q?s3w06a6oGG8do56oCiovy6ibQiLkkbvm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1NNFJhNlVtODI5Q1BsT2szYU1DR0xFSEZ2UmtZWnBKZkwzdlZIM3o0WnJR?=
 =?utf-8?B?NzFraDljRCtUNVBId0M1aU0zOGgrZGpza2pmK2U4Nkg2dHg3eFN3VzFwcjc0?=
 =?utf-8?B?ZVo4bHVBMzBuMjlxZnVCQzV3eWJqNkc5U28wbW4rcmQ2VnB0RFUyUFdqU09i?=
 =?utf-8?B?RGxRQ2VzYTd4RCttb2R5N0JXbXRZNjd4Rjl1T0g2MGcrVURKVjVPMmF5V09l?=
 =?utf-8?B?K0txUkNrUEMxbk9hS2RINS9aclBkMnVqSXhhT3cvMTVtYVM0a1pqMWROUlAv?=
 =?utf-8?B?M2hoRTdmMktaY28yaEMrTFBsNzBoNGdWUHA5dGEva04xOXUxekx0ZXdNcFBR?=
 =?utf-8?B?aFdGWEEyLzRMTDR2QTdwOVRGRlFPa2hkajY1RFVNVWhiYk1yVDdLWnlUUC9l?=
 =?utf-8?B?SmtiUHd1OGN5eU1OMUpHckpWQm1uZjNJUkxPSkE4YTg5dXFBTnNDT3JraHBJ?=
 =?utf-8?B?NWtUWC9HVnVPaFp2UVA3VEgzY21wZUJTak5oM2ZUK09yQ09ISmlQMFA5eldr?=
 =?utf-8?B?WHdpN0duR1JSTjBhd0FXRGVuMkxUSHJjUjAxcjBlL1M3cWZlOUgwbDNJcWRC?=
 =?utf-8?B?ZEgvVG5LR0lIZmpvRVpvWld2UXJwNTRYdmhCb3lXK3pENW1ybEtzbjhzNThv?=
 =?utf-8?B?OTA4aEtiWldlNWFwaEtiaG5STmpFVGtMMzRmK1IxQU54U0Y0YTl0WXFKeVdE?=
 =?utf-8?B?dTNmbG5Qc1YxcmthdDlhS0tja0VGRXpmazJ5OGtwalBWQVZXbFN1Wms1eWZt?=
 =?utf-8?B?UnNLbTlkQXhWNE9hMS9keWVXM0ltTDdxZjFoWjhEeUhocURjQ1FmNDhqR3Ri?=
 =?utf-8?B?bnAzR3lhWWhxN0NWOWlJdXpkUjNOUUhGbHpURG5yNjVhQ1J6ZGNPWUo5SCtN?=
 =?utf-8?B?NytSMVBpNktsK05NcmtXVVF1QWxUaXBFdDZFUXNyeVVZMGVHbTFMWGowQ0dB?=
 =?utf-8?B?UVdBVGRZdkNiTzJwRk9lTXllK3E0UEpaRU56UWtpTkdDR3FoMTROaG5ZNHh3?=
 =?utf-8?B?S2hzMlh4L2pjMm5rTXRMVnFmeFB4Y1NhUHhNbUxZUzloY1cvaGVUSVNzQ1Q5?=
 =?utf-8?B?QVB6QklZUldpN1Ryekd3VXpDTXRUbGZkMzRpUGt4aVdnbzVTeFFjZHduTVVQ?=
 =?utf-8?B?ZndFbG51SkR6SkdqNHBtQ2N6L3J6bFVlMXdWUURmWWNUWUZVV3pWQ1JnbkJH?=
 =?utf-8?B?UDhZVHdTYVhKSW10SWRRY2p4Nkg3cTlrSG14M0JvK3ZHU1dINzhGWU5GVGNO?=
 =?utf-8?B?NVRyQTJFSFZGcGVoeDRQd1VKM21qejY0eWxZYkgrUDNpbVpMZUdTMEZveUUr?=
 =?utf-8?B?Z3hmNUpZaWsyY3ZQNTVDdXYxU0NyRWhjQTJjbjBUWkdMdmNTTXQ2V0w2QklL?=
 =?utf-8?B?Z2hBbGk0b0NEMzdHd3pUNmN1M3JvL0I3VW95eUo4WUFpR0dqUWJZamhsSCtm?=
 =?utf-8?B?dXdUWkQ3R3drMDRHQlZEZXVYeERRRTFMbXpzMEdvVjlKeE5mQUtmVWZYK2xS?=
 =?utf-8?B?N0F2M2loR25CdXU2dXhKNGl4dFhuOU9aVC80WUdNY3hDVlZXS2U4dlZMMm1W?=
 =?utf-8?B?azU0M3ZNR0ZiRmpFem5hYjdlQWExLzBjUy91YzZQODE3SE5kK2RYTzVOWGRE?=
 =?utf-8?B?NGdiRENjZGJyM3BtVUpkekhnVG44M3lpaHpwYThDaEhmNDIxMmorWFdsd1Fx?=
 =?utf-8?B?QU9iL0FQcVAyMFFvUTBlSmsvU0xaMlFHMEJxNUd4TDBEOGY4cm9GMXdSVXVS?=
 =?utf-8?B?ZjVYTk9Jck9ZV3VValJCclNETEozZU5wekVEU3JtMnVKK1VtRy9UdU5JaFJw?=
 =?utf-8?B?RGFjNzdoTjlCV3ZPNXlVYVZNWnI4WTltamswYllkeWZpbnVKVXpaVHA2TkdP?=
 =?utf-8?B?VFdsQmhCbUV0MjI2WHF6NVhHc0EyOFljRTJDUnNYNzBjK200NEhkYklHaUV5?=
 =?utf-8?B?MFczelRWREJRSEhwalpZbXIrSHRRcU9JbURzNUNINWQwR3d5cUJPSUJUenh6?=
 =?utf-8?B?UVY5R0dVUXJ0RHAxbmpNc0hNVkNqNlZNQ09KOUYrWFQ2eDN3cjdnenNPbldU?=
 =?utf-8?B?aUhnbXQ2eWdhN3IyTEN1VUlTRDdNWEQ2MTE0U3I4eHhIcGRUYTNlOXZTbno2?=
 =?utf-8?Q?P3hI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8bbdda-b3da-43de-b10c-08de00194fd3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 12:03:05.0129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhXL3AygBC7ogQb8o6tmfzfsKT3JZxEe5PUAqGoc6kL/ng7Pmuk8wA+AR/z7P/n3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7998
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



On 30.09.25 10:27, Sunil Khatri wrote:
> Clean up the amdgpu hmm range functions for clearer
> definition of each.
> 
> a. Split amdgpu_ttm_tt_get_user_pages_done into two:
>    1. amdgpu_hmm_range_valid: To check if the user pages
>       are valid and update seq num

Good naming.

>    2. amdgpu_hmm_range_free: Clean up the hmm range
>       and pfn memory.
> 
> b. amdgpu_ttm_tt_get_user_pages_done and
>    amdgpu_ttm_tt_discard_user_pages are similar function so remove
>    discard and directly use amdgpu_hmm_range_free to clean up the
>    hmm range and pfn memory.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 12 +++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 11 ++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 23 +++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  5 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 32 -------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 13 --------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  9 ++++--
>  8 files changed, 49 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 4babd37712fb..e80a00d768cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  		return 0;
>  	}
>  
> -	range = kzalloc(sizeof(*range), GFP_KERNEL);
> +	range = amdgpu_hmm_range_alloc();
>  	if (unlikely(!range)) {
>  		ret = -ENOMEM;
>  		goto unregister_out;
> @@ -1097,7 +1097,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  
>  	ret = amdgpu_ttm_tt_get_user_pages(bo, range);
>  	if (ret) {
> -		kfree(range);
> +		amdgpu_hmm_range_free(range);
>  		if (ret == -EAGAIN)
>  			pr_debug("Failed to get user pages, try again\n");
>  		else
> @@ -1120,7 +1120,8 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  	amdgpu_bo_unreserve(bo);
>  
>  release_out:
> -	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
> +	amdgpu_hmm_range_valid(range);

Calling amdgpu_hmm_range_valid() is a no-op here, just drop that.

> +	amdgpu_hmm_range_free(range);
>  unregister_out:
>  	if (ret)
>  		amdgpu_hmm_unregister(bo);
> @@ -1923,7 +1924,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
>  	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
>  		amdgpu_hmm_unregister(mem->bo);
>  		mutex_lock(&process_info->notifier_lock);
> -		amdgpu_ttm_tt_discard_user_pages(mem->bo->tbo.ttm, mem->range);
> +		amdgpu_hmm_range_free(mem->range);
>  		mutex_unlock(&process_info->notifier_lock);
>  	}
>  
> @@ -2550,7 +2551,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  
>  		bo = mem->bo;
>  
> -		amdgpu_ttm_tt_discard_user_pages(bo->tbo.ttm, mem->range);
> +		amdgpu_hmm_range_free(mem->range);
>  		mem->range = NULL;
>  
>  		/* BO reservations and getting user pages (hmm_range_fault)
> @@ -2574,13 +2575,13 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			}
>  		}
>  
> -		mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
> +		mem->range = amdgpu_hmm_range_alloc();
>  		if (unlikely(!mem->range))
>  			return -ENOMEM;
>  		/* Get updated user pages */
>  		ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
>  		if (ret) {
> -			kfree(mem->range);
> +			amdgpu_hmm_range_free(mem->range);
>  			mem->range = NULL;
>  			pr_debug("Failed %d to get user pages\n", ret);
>  
> @@ -2749,8 +2750,8 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
>  			continue;
>  
>  		/* Only check mem with hmm range associated */
> -		valid = amdgpu_ttm_tt_get_user_pages_done(
> -					mem->bo->tbo.ttm, mem->range);
> +		valid = amdgpu_hmm_range_valid(mem->range);
> +		amdgpu_hmm_range_free(mem->range);
>  
>  		mem->range = NULL;
>  		if (!valid) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b75b53f21cbb..c4b2de1a1fab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -41,6 +41,7 @@
>  #include "amdgpu_gmc.h"
>  #include "amdgpu_gem.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_hmm.h"
>  
>  static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
>  				 struct amdgpu_device *adev,
> @@ -885,7 +886,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		bool userpage_invalidated = false;
>  		struct amdgpu_bo *bo = e->bo;
>  
> -		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
> +		e->range = amdgpu_hmm_range_alloc();
>  		if (unlikely(!e->range))
>  			return -ENOMEM;
>  
> @@ -988,9 +989,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  
>  out_free_user_pages:
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -		struct amdgpu_bo *bo = e->bo;
> -
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
> +		amdgpu_hmm_range_valid(e->range);
> +		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}
>  	mutex_unlock(&p->bo_list->bo_list_mutex);
> @@ -1321,8 +1321,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  	 */
>  	r = 0;
>  	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -		r |= !amdgpu_ttm_tt_get_user_pages_done(e->bo->tbo.ttm,
> -							e->range);
> +		r |= !amdgpu_hmm_range_valid(e->range);
> +		amdgpu_hmm_range_free(e->range);
>  		e->range = NULL;
>  	}
>  	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 12f0597a3659..cfd8ffe2da31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -571,12 +571,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		goto release_object;
>  
>  	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		range = kzalloc(sizeof(*range), GFP_KERNEL);
> +		range = amdgpu_hmm_range_alloc();
>  		if (unlikely(!range))
>  			return -ENOMEM;
>  		r = amdgpu_ttm_tt_get_user_pages(bo, range);
>  		if (r) {
> -			kfree(range);
> +			amdgpu_hmm_range_free(range);
>  			goto release_object;
>  		}
>  		r = amdgpu_bo_reserve(bo, true);
> @@ -599,9 +599,10 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  	args->handle = handle;
>  
>  user_pages_done:
> -	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
> -
> +	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> +		amdgpu_hmm_range_valid(range);

Same here, amdgpu_hmm_range_valid() doesn't needs to be called.

> +		amdgpu_hmm_range_free(range);
> +	}
>  release_object:
>  	drm_gem_object_put(gobj);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 53d405a92a14..b582fd217bd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -226,14 +226,25 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	return r;
>  }
>  
> -bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
> +bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
>  {
> -	bool r;
> +	if (!hmm_range)
> +		return false;
> +
> +	return !mmu_interval_read_retry(hmm_range->notifier,
> +					hmm_range->notifier_seq);
> +}
> +
> +struct hmm_range *amdgpu_hmm_range_alloc(void)
> +{
> +	return kzalloc(sizeof(struct hmm_range), GFP_KERNEL);
> +}
> +
> +void amdgpu_hmm_range_free(struct hmm_range *hmm_range)
> +{
> +	if (!hmm_range)
> +		return;
>  
> -	r = mmu_interval_read_retry(hmm_range->notifier,
> -				    hmm_range->notifier_seq);
>  	kvfree(hmm_range->hmm_pfns);
>  	kfree(hmm_range);
> -
> -	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index c54e3c64251a..368dd58d13ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -35,7 +35,10 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
>  			       void *owner,
>  			       struct hmm_range *hmm_range);
> -bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
> +
> +bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range);
> +struct hmm_range *amdgpu_hmm_range_alloc(void);
> +void amdgpu_hmm_range_free(struct hmm_range *hmm_range);

We potentially can only use them when CONFIG_HMM_MIRROR is set.

So make sure that you have and #else branch with dummies.

Apart from that looks good to me.

Regards,
Christian.

>  
>  #if defined(CONFIG_HMM_MIRROR)
>  int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 046ff2346dab..96bd0185f936 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -753,38 +753,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  	return r;
>  }
>  
> -/* amdgpu_ttm_tt_discard_user_pages - Discard range and pfn array allocations
> - */
> -void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
> -				      struct hmm_range *range)
> -{
> -	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -
> -	if (gtt && gtt->userptr && range)
> -		amdgpu_hmm_range_get_pages_done(range);
> -}
> -
> -/*
> - * amdgpu_ttm_tt_get_user_pages_done - stop HMM track the CPU page table change
> - * Check if the pages backing this ttm range have been invalidated
> - *
> - * Returns: true if pages are still valid
> - */
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> -				       struct hmm_range *range)
> -{
> -	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> -
> -	if (!gtt || !gtt->userptr || !range)
> -		return false;
> -
> -	DRM_DEBUG_DRIVER("user_pages_done 0x%llx pages 0x%x\n",
> -		gtt->userptr, ttm->num_pages);
> -
> -	WARN_ONCE(!range->hmm_pfns, "No user pages to check\n");
> -
> -	return !amdgpu_hmm_range_get_pages_done(range);
> -}
>  #endif
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index a8379b925878..99c46821b961 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -192,25 +192,12 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  				 struct hmm_range *range);
> -void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
> -				      struct hmm_range *range);
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> -				       struct hmm_range *range);
>  #else
>  static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>  					       struct hmm_range *range)
>  {
>  	return -EPERM;
>  }
> -static inline void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
> -						    struct hmm_range *range)
> -{
> -}
> -static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> -						     struct hmm_range *range)
> -{
> -	return false;
> -}
>  #endif
>  
>  void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 9f0f14ea93e5..53e443a243ee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1737,13 +1737,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  			}
>  
>  			WRITE_ONCE(p->svms.faulting_task, current);
> -			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
> +			hmm_range = amdgpu_hmm_range_alloc();
>  			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>  						       readonly, owner,
>  						       hmm_range);
>  			WRITE_ONCE(p->svms.faulting_task, NULL);
>  			if (r) {
> -				kfree(hmm_range);
> +				amdgpu_hmm_range_free(hmm_range);
>  				pr_debug("failed %d to get svm range pages\n", r);
>  			}
>  		} else {
> @@ -1764,10 +1764,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  		 * Overrride return value to TRY AGAIN only if prior returns
>  		 * were successful
>  		 */
> -		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
> +		if (hmm_range && !amdgpu_hmm_range_valid(hmm_range) && !r) {
>  			pr_debug("hmm update the range, need validate again\n");
>  			r = -EAGAIN;
>  		}
> +		/* Free the hmm range */
> +		amdgpu_hmm_range_free(hmm_range);
> +
>  
>  		if (!r && !list_empty(&prange->child_list)) {
>  			pr_debug("range split by unmap in parallel, validate again\n");

