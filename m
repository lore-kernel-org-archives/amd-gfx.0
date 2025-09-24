Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71918CAC5A7
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 08:31:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE0F10E6B0;
	Wed, 24 Sep 2025 08:31:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x0LdpeGH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 674B810E6B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 08:31:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8/LAwwJl2WjVHudPSr5TzU0uFb2cEl98h3HVR+nPv2bYZSdFQpfdu6QVGX9mrweh2B7Bqu3WONO1ztkTz+94UGxWUQ90dN2kLQmF45MhBgJ9WUHNXjCX/KhL9Iezh2gAQaGs7BWfHiTox8IyXFYcO+KnsE5ToIfAsDWFKcv1pEMEGXtqMi0rkESkF8bDT2Lm3WPK0dmwydm56R7Q0GW74GcdBL/ECrOp/pZfsqmR/dNV10iO9OnR79y71/J/wQ5VnV/aYyqhGx43zc5ZJCMOeSlKgJN24s4RQ0U5/kwDdAZ8BeiPOchvlxzQbwXifiJHinGqZvsJbEsWvHreMqYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Akqoy5gYVUM9cSSjnoEdaruwk/AmeFhSibPn9ks+Ak=;
 b=i2qxwgpkPpS0ERf9Gz6prsrX33LJFWU8ZxZFKRLMa+TdXdJJnyqjHWv3C3DbeXc88TPemnrDZXlymfJxYhHB0gN7NzMiXVTnsaj1KjZTg3uDXkt3ZK9Uz3EXkyVYMGu3IMJ/C/bEG2ebWXGfmxaRZ/SeLHptGso3Vi86+rrb0qnchOrhbr0Bpz2l0N2AC1+6vrQ7TOUP3o6Gir6lBJWvZcOISsWl8dFHd5JPcMzqJsi6tQTHZNf0R6rMztm2dpF/0CE2IicMIZsWvyAiM5eNqfpVmFb3OGkw36KhjQmNHt60f3YLV5hcUeYpjlafcSIuIMCy2xeJAfq8dvcz9jb1rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Akqoy5gYVUM9cSSjnoEdaruwk/AmeFhSibPn9ks+Ak=;
 b=x0LdpeGHkOHGYXsJr73BHz/hWOlO8Yn6l+LHVANZdkx5dvfJ2geBTAMQRU+83W7RNiLEBQvSANuX6tjyNtPIoVkOJ3LTVOiajE1GgtKx2yZVD6hhBSf56hOHkBua68TSZKlo1UpsxflxV8j6aLkUglv2+w0v3s3MrQYZIhK7vN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8002.namprd12.prod.outlook.com (2603:10b6:806:34b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:31:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 08:31:01 +0000
Message-ID: <48be4b23-23b1-46e3-b7aa-6b8e2c2c0f28@amd.com>
Date: Wed, 24 Sep 2025 10:30:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix fence signaling race condition in
 userqueue
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250924081230.2341706-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250924081230.2341706-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 471dba2b-0302-4e98-6cf4-08ddfb44b175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkFNdzBpLy9xSlZBUlJ0OVNXZjVPVVNRd0VDOXRRSVJNeTJOTUtQR1dPSi9p?=
 =?utf-8?B?Mk5lcXNSeDZ2Z0FWcklHS3V6RTM3ZE9Ra0orei80dCs0dG0xNHRaQWtLY0dM?=
 =?utf-8?B?WTlxdzBxREhvUFVvWTl3V28xS1NYMmswSDJYZXlCY0s5UlM0dlcrLzlnNXFX?=
 =?utf-8?B?R2Q5dmhPYXlXMG82dXhiZWdPK1p3eU1seVZFUFlwVlAxSGduZEJISzBUOU9n?=
 =?utf-8?B?TWFiRmVoUWNjdkdBaUVjb3ljS3U3WUNia0o0eE1FNFI5a0V2TFExQ28zRVVp?=
 =?utf-8?B?SVo2RitZTDRQUkh5TWNUUERlUE9naHpBV090eVZJU2c5MllZSldSdWtEcWl2?=
 =?utf-8?B?NUxNZEYyQkdZMDEybzNGVHJtMHkyVHZWMmdyZ2lVdE9CS2xWOFF6V0dvd2VS?=
 =?utf-8?B?MFVzcWQ1WG1DMjZTTGZhSE9GRzZJQk9oYmh2ZHJ2K0JTM1c1eUFQMkNPR3I5?=
 =?utf-8?B?VVBiVTZnTjdlOGlTN0hOMXpSeGZ1SjJDTFNNQ2Myem1jSXVBU1NaemUvZmk2?=
 =?utf-8?B?L3V2MzVjaXZYNTZUN3NYbW45alBDQlA1TEJMVFdMODFLNnMraVdLbUpMeHk1?=
 =?utf-8?B?bEkzUTFvUmd5eWhSN0g0Vi9HY3VYQ1pEbmVlTmhaS1JrUE8wQlZiS3NQSVdY?=
 =?utf-8?B?cUVtTCtEdVlrbngvSnc3RmhSQlA4VzlZZHpvemNEOStOS05VQ2ZrSFpIcVpi?=
 =?utf-8?B?dHVkb3lIQUx4RXJMekt4Z2xEVVFzNmJpUEdFdDlLZzFzR2NySlV3VFhaOC83?=
 =?utf-8?B?SXY1Q1RhY3dqY080dWwvVnVNS0VuQWVlWVNZNVRhTUxGNVdZWE91bzdmelUv?=
 =?utf-8?B?WldaVXdUbzIvTGtKNGZNdmxQdmdZRVZJaG9NMElBM1grSUxMUnNpV2FqTlhk?=
 =?utf-8?B?MHNVYy9HQ0JXakNqa08rZmttVEd4aFpDUVpER2hEZ2E3UndwQW5jTUZjcTRp?=
 =?utf-8?B?MUtUcU1GamloZlBmbzZwRTJGREtzL2wvS0wwems1N0hlbk9iWkRTaUp6L0F2?=
 =?utf-8?B?NzZHNEsvVmNqakU1akFmMWlGcUwxcitnMFJ0Z2RSaDF4a3ltd2M4Y3B5QlZP?=
 =?utf-8?B?SnFOY211NVA0dmhaU0xGckhwWVB3Z2hMREl4dFUvd1Jzd3NtUEU2UGZoejdU?=
 =?utf-8?B?dCtYVTJtTUJnUHVUcnBIdENBVjdadlZaUXZsK2hKa2VrL2k3T01hSW9uak84?=
 =?utf-8?B?NjRlMUQ5VlVOM0wxa0NVbHd4K0svN001L1NmUnJXQnc3MVdkdmtYb2cxT1pC?=
 =?utf-8?B?ZkpkMmlwRWZSVU1xeEZGNXhmMFlNSThyN21vYkNYMXRIUEtMdTc3LzBzdmMw?=
 =?utf-8?B?T2ovOTM1OU41NEo4Z2hyK2lxalp1YXR2ekZWQWNuSVNoeXBONUJLWVVmNmdO?=
 =?utf-8?B?VEpGenRBR1MzTU1LbkZWUUVESW1nOURtcjg1a1dsWHBNOFZMVjVObkFqcDJO?=
 =?utf-8?B?dVVRcXVjNG5aR1lOL2h3K2lIZHZGZkRKbjJPV3krbC9hbnNhSlJJdmp2NkQ1?=
 =?utf-8?B?WDd3WWVHOWs2T1p2Y1RaSktDWExsU0xmNlBzOXA0T01ZK3UxWVNYTSs4TWlU?=
 =?utf-8?B?ZE03MXp4c1ZjWEZjcU9aUE5YeWZiZXBZR2tkVFk2bXZTbjZNblJuRnljVVNI?=
 =?utf-8?B?V1FkdHJybE1LZm9aUTFkbGJxeDAyWFZxRkFXQ0EzekZiVE9zZjQweDRPY0V6?=
 =?utf-8?B?MDROYjhnakpJb1RWclFTL0xZZ3BZbUwrTUJEdWNabWpkaVNhUUpDemdlSG5I?=
 =?utf-8?B?Zys5Y281eGduSS90eWFZaFdZUlJ6eE1JTTJJcTI3SDZaMGZUdTNGZm4yU0dF?=
 =?utf-8?B?N1BMM2lESVROUTFmRzNjeEx0TVA1NHFXdXVZUjJqMGdTdmtGWCtFd1ozWTkw?=
 =?utf-8?B?NWVwOGVkRzBaZDJlVnhSWU5xLzZOb1BFeCt2Mmc0R0dJc3NaVjJNUW83TWli?=
 =?utf-8?Q?g94g1DlVC3M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGNySTUvNnN2RzlMYTNndzBXK05TM3JFMUp2eHVRYzVOZ084a3FLd1R3bWFF?=
 =?utf-8?B?SzZKMTNvUWdwcHRxa0Y1dGxsaktVVzFvbXVuWVErK2pJem83azZ6MmgxZFh0?=
 =?utf-8?B?UDh5cWtscEFGbDdNMjFuM1loV3FuN1RkUklMLzk5Sys5aUVMUi9QWTlobTRr?=
 =?utf-8?B?blNiei9lc3lUemdzMk4zajBlT1U3T2pYY09VQTdaQUUyL0VCanhtRDFmZSs5?=
 =?utf-8?B?anVnU1JZL0pCTlM5NGtYWVQzYzhqMmowaVVldVRHNTE1c2lIT2wzbVZOOWFE?=
 =?utf-8?B?SVlNZ0ovYWFNM2Q2clNvZlAvcmMvaXNhZDBUTlRCalJ1WDViamdVUGQvUDBq?=
 =?utf-8?B?R0VqMGM0d1ZhUDhpaXdQUzhLbWpsdEZ4amVCNlUydUFJaEtkOUhKUnhWbmE0?=
 =?utf-8?B?UUh0K1FQTjFYTm1vbUkvUlBOTTJZMWZMTE1oYVk0eUxvZnQ3S3BKSytwYTFM?=
 =?utf-8?B?Zll6TmVISXZ3VjlpN2tTaEsrVE1adUJmWDZHdk05QUZEV1RCUDc2WVRtdVpp?=
 =?utf-8?B?OUVBMzZMaytFL2taRDlsUzIwUXVRbit2Nm5KYWY0STFybjRiaVZyaEtnWHE1?=
 =?utf-8?B?ZXFlRW1vcHJoUnVqMHcrYU9yT3BXWU4ralFkZjIzOVowUXRNUTZiTitrZnhC?=
 =?utf-8?B?SU5ocnczYlV1SGxUNW5XbUVUZFRXS0FSU3kyNjlzZkQrcVg0QXNwWWwrQi9k?=
 =?utf-8?B?dkZpVlA1ZktZbStScFlTLzlhcDlYZFYrZlF5NHZ6dlViVC84N2sxY2xBb1Bu?=
 =?utf-8?B?RnY5cFJ2Rnd3TnBTY2J4YzR1S1lpZkJZVm1ybVpaUVpZbWJLQkVpRDRxOUhT?=
 =?utf-8?B?TjRnQU9pTE5vcXF4NjJzTUlFbmZwOXMwNGtoVGoyUUIrYWV3TGJhdlZFRkc4?=
 =?utf-8?B?SFpkd3pWdStpQ0thUGZNSnhOZkdIWHFwbUN4ZW91T2lQUDhMMFlCa1VGbkQ1?=
 =?utf-8?B?dDh0QWR6K2EzbDY3QzZmc0pvZGlEam1UZW5VcU1wQlN5eTVLZnpockpURHRs?=
 =?utf-8?B?UDRvb3RaUXZudXlyRXRPb0xjOUNrampyaFpxaFh1MXE0RWlLcktTKzNwTUdW?=
 =?utf-8?B?UmhEeTZuODYwU2dkRUxCVDBmT1UvQ0gwTExvZk1PUW9Ldzg5YTI3V2hTQzkv?=
 =?utf-8?B?MEZBNTV3OHFqbUFEbXg1eC9jRTJmMkZIU2pQNmlNOHRleGVUSEtIc0w4bkJs?=
 =?utf-8?B?R2JMT1hEOXEwM3F0enVHcFJxLzZPRHBhTnoyREFNVHAxczk4VlRHa0gxNFBF?=
 =?utf-8?B?aERheW1CT2haUmdmRUNaVjNXeDFadjVpWFBkYlVTcTV1Tit3ck9XOFVnejB3?=
 =?utf-8?B?OG1iNXUrN2hWbGR0YndPVG5KZFBZSWN0eTExTXhBRnlmNWFhRzFhbERoRjBU?=
 =?utf-8?B?WHBnK1F2QWRYbjlQdDYxS0psakR2Q1VacUhZdk1ONmUrUDNHR2RNNGpNQjZF?=
 =?utf-8?B?OUFpVFRBZjR6Mk13emdja0E1cUoyd09hdSt0RHpBaFliVXhKMTZhejJHcysv?=
 =?utf-8?B?RGQxa3F3WHp4dVpwQWtaQ2pLbDhIWmxFc0xHV01td21MOTEwUHJoVVdoOFkr?=
 =?utf-8?B?WlJ1LzZuenJDVXhLZk1IbEM3OVZNR2FCS3VVSmllTzZZN3NZQ3FrckllTHpT?=
 =?utf-8?B?Zm5wM2FlclpxN1lSM2V2dFBJWW5jbnVpbVhWSUpIRWY3dkR3Qk40SUJyUXNa?=
 =?utf-8?B?OUdRUVkrT0s5SDc0OWV5YUxjMGQrTUVsbkkwYU56U0I3MmdGVG9QQ0NTWFZl?=
 =?utf-8?B?WXkzalNBSWJxWnMybWlReWNROG9vWS9uZzlzZmEvSmhsaUt4TlFDQ2JhcHA5?=
 =?utf-8?B?K3NBNGxKeTdaSmcrbUNrcURDc0pmbi9OTCtJeU1sZTJOdU5nYU5IeTQ1UjFD?=
 =?utf-8?B?UmIrT04xVUZoTzFHZUI4bmFMZElpcklZMGhOdlpnYkVmVGlIaDJ0cmhKRUdx?=
 =?utf-8?B?cUoyYTFtM3krSUg0ajFTckpCOVBiUkdCajB2aXNIRmNyQWRQQnpNeENxS0Na?=
 =?utf-8?B?QUhTd0tyZm5jeVNaZENNdy9WVXUxN294K3JUTHZOUDhBZWpGVDFLNnloM21s?=
 =?utf-8?B?OFhLWURncURXSmo2eHRaSEpvcUx5aDF2VEVaeFlISWpvZ2NoTHB1ZWcvMWIw?=
 =?utf-8?Q?5ZR9yUw5t3uYp4qIVLvuEjuKL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471dba2b-0302-4e98-6cf4-08ddfb44b175
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 08:31:01.1843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8o40kqGxqvbZ3G0ts2tYhp5raFT7Nk0HPZ+U0gDQ/OwXYTrdGQkApSdeTNN7AZv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8002
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

On 24.09.25 10:11, Jesse.Zhang wrote:
> This commit fixes a potential race condition in the userqueue fence
> signaling mechanism by replacing dma_fence_is_signaled_locked() with
> dma_fence_is_signaled().
> 
> The issue occurred because:
> 1. dma_fence_is_signaled_locked() should only be used when holding
>    the fence's individual lock, not just the fence list lock
> 2. Using the locked variant without the proper fence lock could lead
>    to double-signaling scenarios:
>    - Hardware completion signals the fence
>    - Software path also tries to signal the same fence
> 
> By using dma_fence_is_signaled() instead, we properly handle the
> locking hierarchy and avoid the race condition while still maintaining
> the necessary synchronization through the fence_list_lock.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 59d0abbdfc2f..ac366e1bc9ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -289,7 +289,16 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
>  
>  	/* Check if hardware has already processed the job */
>  	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
> -	if (!dma_fence_is_signaled_locked(fence))
> +	/*
> +	 * Use dma_fence_is_signaled() instead of dma_fence_is_signaled_locked()
> +	 * because we only hold the fence_list_lock, not the individual fence lock.
> +	 * dma_fence_is_signaled_locked() should only be used when the fence's
> +	 * own lock is held, which isn't the case here. Using the locked variant
> +	 * can lead to race conditions where the fence gets signaled twice:
> +	 * 1. Hardware completion signals the fence
> +	 * 2. Software path also tries to signal the same fence
> +	*/

Please drop that comment since that is not really accurate. Apart from that looks good to me.

Regards,
Christian.

> +	if (!dma_fence_is_signaled(fence))
>  		list_add_tail(&userq_fence->link, &fence_drv->fences);
>  	else
>  		dma_fence_put(fence);

