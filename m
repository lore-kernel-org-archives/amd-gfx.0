Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533CACD4F52
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 08:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA6E910E0A1;
	Mon, 18 May 2026 08:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Iil93nCq";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CEA610E0A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 08:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8AZEY+/j8rz7NYDxsviPozezuQCjyhEowinlZrqL/CbKnoQHx4mdf3patO/mxfjqFkFnteu01On6xJJ+yL7X3YrPSKq1n29bw5HzJXuU9TSXZN35f/lBEPSbP6WIZNoQs67S+HP8aryNlAPh/l6Ua6slRda+VWr8dki/B63zfK2MSHjmjWSVCGnbjGcSUC6YHorlSQFlrqPXn7fcJWbHCgBbxMmfvKx+DU0Q7p+NFq6BtRxv4ZO8BNRnr8QNSSWhKUxW7gJTwMJ1HkRfXnyKr1SfRKfs3YPY25QXSJNDE4uIZ6Y+ubQRztYjhg8QLdzwIjpmwdGxzdvY/c9dmJdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf69RU1s8eu8TtfDg/7b4RSL8xMYaakZHzuKBfx1Hm8=;
 b=nnIqsOuy0fqAiIz/zudYtkjHWwXGgrBUvyMpKMXQRIFYE0VcJxcnfICW+obwYV9JllkCgRb1ymMihAVTRtbqllAHmtTEdiUge8eqD2QllQ3h9d8+pcne9djrucR/nTxFdTKMiUORXyVDh6AghTlVCZCLN3jLl399fKhpOxU/xDzm7tbg9HiG2R48C8ukthZm5wgx2NNrgPlc7rBVI+aNgCd8VA+72OxDntiUOjwzvg4c0M9SHyHzWDX3LviYdL9taBzi8EtoyvpFPZMvOlrLFYBFazjRyPVufzMVxiVXy3XsqhXDEiGR+9yEU2fgVcXNHNz3X73d2u9lcNygvJXX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf69RU1s8eu8TtfDg/7b4RSL8xMYaakZHzuKBfx1Hm8=;
 b=Iil93nCq42pZiElBmdCVYCpp/AMLnQs+JQmn/rx9TX2VCojmqYARr14n6aR99HJrxwJpX5P5PIb9wh5ZFEnRbPac48MXNNl4UyTovc9seydtaLHnpGyj0JPBQR4zLjeD7T2fTOwGK7nA8710wtANWUfXo6UyNqKmTnH0OqhVz6Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM3PR12MB9352.namprd12.prod.outlook.com (2603:10b6:0:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 08:50:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:50:33 +0000
Message-ID: <e37f8813-0253-4f3f-bf9d-8ae7708c5306@amd.com>
Date: Mon, 18 May 2026 10:50:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: Use atomic operation to achieve lockless
 serialization
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260514072701.2299075-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260514072701.2299075-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:207:3c::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM3PR12MB9352:EE_
X-MS-Office365-Filtering-Correlation-Id: 011ba1f0-57e8-4244-7c40-08deb4ba8576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 49Rt6uZ2yqjStD/8slQDepSZ1mkVDOzck6tKhOtdKwzzJossGRvsVzrGYd/+SQVIruBvMQnWxFgrJ6C4d+Cc6VOgvEfUnjOvW7CuddbxCkp4xaX2gsClMIJGIRy/ZhxLT+86wE+0wxvNVtDpT6EcMXWN/mt1HnxJL+3oZA7LAMpeppiZlnrMBnzycOAOQDc3LW2a8/pX+lqXoOGkSvTImi6TfZOoYTuu+Jxl7O8z3iLGh84QPaVMnaSu3mkvuQX/TwF2GZdKrLskrFbhNgvyYzw7giBn0GLOx71SueeUZeyiHJNmfOMOb/Yb9Qxrz/qJRh+6calNOJlz2NFkhSMJGatoAZpczBhIz+UPGnTUi/hn5zeN1ViUyRPMGNo4NXMLUHSshmp/2BVKx3AmgtMW69BiAJUuOIk5+5Ly7+PKfJiYc9s9lMV0ZZ+kAqCO9muIAjvuI3Xpf7MrjJNVkC9IjTpJ70SVp2OxuXIEHyZZL9QJvWC5IMEs9Bb1n82A0J8R+sN7UbbRselTSQAuJlKiyQDDHuKwKun/ksCPant1ZMAzIa25IH+PZxKmBOak9IvTDkXwrUh5y9+t3Hmo5Qg8w1awMn5Fs8jjRvD3zXKR9RaWubTpNQA8aQZLvNYRzXlaq5VJrNOS+CMSRqXxBT6sq57aWz/RH/7LgO14YDDYsUX/JLQI0/297ROp8LIkNXxo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm8vSTdzQUV4UGhFMmFEOGtURGI4Z1hTbm5Lc2NPV01mUUh0NUliY2V1Zmx1?=
 =?utf-8?B?R2E2NGlUVk9vamVQOHhNT0h6YWFHVktjUHV5RVhvR0c4SHlnbHRoSUd5RzF4?=
 =?utf-8?B?cmJUN1p0Q3lBMCtQQmFUN2JTNE1CLzBEc2RjZlA2WjhGY1lLbWpNeVNRWkFG?=
 =?utf-8?B?MEVSYy9ReEgyaTgwd1VPeGpnRmRXUzdsb1d5cFZ4bWoyRXJhNGNmVTNUTVR3?=
 =?utf-8?B?UllrSCtkY3FMY1BlbXZDOXl5VTJOR0lZeXNZZWU3NUdKaE4zQU80VTJkZGVs?=
 =?utf-8?B?VkhIai92cTdWMVg5a05wWnp2ajFUcGFlSy9JcTlXWE9SdG5xb1kycjZGVXlo?=
 =?utf-8?B?TTZZSk1OcTlzTGNQRkFDNFh1YTM5YW5WWjJndHk4K0JEWkEweExRYkVJZmNt?=
 =?utf-8?B?bnJ0aWYxS0tZSnhHSGNXSDBpQlRZMFVZOWxlWHU2aTlYeU54Rm9kUnJRb254?=
 =?utf-8?B?SzZpUTlJa0R6RUdGY2NCQUoyYkdXUERDMnVydkdRNTJ4Nkd3YmRuWmdJVTdp?=
 =?utf-8?B?cDlmQUNGaERmN0txYUtac2VsRVpUWE0xNzdSVEZSZ1lKYkQvZG9wRTdIWGp0?=
 =?utf-8?B?RFpSK3F6dXBXZnArRmV3eEVXbFpMdWpNVEsyckdxMzNwTzJKVFdCSENncDUr?=
 =?utf-8?B?M2tlSXV6TE9FdUFpMytoVVZ4OEhaOElvSjd0aGRtTUg5L2hhSm9KQTMwNDgw?=
 =?utf-8?B?SXpTTWIrd3JiSFRRTkc3bG1hVFFWd3ZaT1BVcFhkazZLN3FRVjhzWEMyMXBr?=
 =?utf-8?B?VHRJREx5MHIraDN3MTlJbTJHV3RneUM1bHpOUHlKaHFDa0QxVk4vT2I5alh6?=
 =?utf-8?B?KzBRQkREVU5kRk1LVm10MDIya3k3bjlXUFpncU9KZC90TWVzK3BjKzFpTFNR?=
 =?utf-8?B?dG5ibXZaUmFMMS94N282K2JXMXM1Yys0cUo1SyttUmI0YXV1TFNuY2pMbW03?=
 =?utf-8?B?VTUyR1pPMmhxc3pMVklnRjRBOU0wZnk3UHAwT3VORWdYelVNZW1sWTJBRjJZ?=
 =?utf-8?B?clZGclAzM3RtMDhSdTcyblpwa3R1MXFZdWhLQ09zSEwzVHJldkhjdk14Zzlk?=
 =?utf-8?B?UTV2YkFONjFmaWhua05EN1dnZkFsWXluRUNlRzFHRkN2WGJKekwyUTFUTjBB?=
 =?utf-8?B?RmdndTVXWUZJK1JzK3JEVjhJRUxGOWtOb25PS0tWdTRDajBqejBoTlRKNGEy?=
 =?utf-8?B?LzJPdVd3NzI1S2JSMFdUcWl2SVo5U29wSDA5OExLaGkwSHAvRVdmbU9xbklW?=
 =?utf-8?B?M1lLL2ZtYkdpVjJYeHlPZ0d4dW9Pa1BFb2NZT080RDIyR1ZRMVQ3c1JsY1Ix?=
 =?utf-8?B?VlBKejJNNVI3a084SExyeDlkbXZJV2lzZERzYit5R0Y3OHRsY2lvUFFKYjlr?=
 =?utf-8?B?ajFsNzVFY2xBQmJySEZvTXZjUndZSVJoU1VBc3hLcVZueGZJdDJXS0NoNXIz?=
 =?utf-8?B?U2pMc25ZbmZiM1Q4K1lLMEFhNFlYekRCamhMcmprdmd5Y09IWXYrY00yaEZy?=
 =?utf-8?B?aXhxUFQ5TkgvOGFXR2NhaXRaM0lhRWNqZ3BOUmRJYno2TkRqK2pxZzFmUUpW?=
 =?utf-8?B?d2JjMUM4TmNWb3BRNWc3eitCZ3JSYjdRNWVSNktFd1dZNWFua2p0UmZCK2ha?=
 =?utf-8?B?ZUdqb1lTT2lwN1VMdkx2YlhoTjJ1Z2phSzZONlRzOGkvdDdUQ0k1UzU5T3p1?=
 =?utf-8?B?NGRTZGlWK0lrWjBEUDBtQmwyUlNJelJObU51Z1dKb1ltR1o0a2RDT1hzSm9J?=
 =?utf-8?B?Z0g5NXdpQ0xYaUJEUzA4WEhReEVFZ0lXWTNScXNlQ0JOMWZ2Q2YxN0ZmWmpa?=
 =?utf-8?B?MlU4dlhRei8rVFpxOWFEWWovMUE1Ty9uYS9SVFlmZC82amUySTN6MXljcGtG?=
 =?utf-8?B?UlRsQlJNeXNSckE5REZvbXVwbFNldXZmakpxcGduVTlQY1drckVZdksraVVz?=
 =?utf-8?B?VmhOMHZ1aFdRLzJiSUJSRm83MUplc0tUWCt3aCtUWlh1L1lkdytKb1AxK2x1?=
 =?utf-8?B?SUcyaExwRURIb0NaWG5wVnRxc2UxTmxzMjZTQ3E2SG5lcTZzZlhkS3hlcHBJ?=
 =?utf-8?B?TmlmZGdSbEx4RWhOWWRzODREQXlGbnNQM1BIWHNLQm9DTmIvc285YnpTNTFp?=
 =?utf-8?B?dlViOWVodUZKMDNCZUEvcEdHaGZQQmltYjZhdEErbXRqSVkvaGdYVExkT3ps?=
 =?utf-8?B?eDh5R2pjTjU1Y0FFeEsycUoydVZFYUlUUFhqVDJGdmFJSU02Y3lQYVNzOVFx?=
 =?utf-8?B?OURuQXRXUXdPdCtJTHRDQ0N3ckxDTlcyS3FHL25xWUd5RjliQ0JxdWRvVUps?=
 =?utf-8?Q?7uD3M0yxYVnUxOD+3h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011ba1f0-57e8-4244-7c40-08deb4ba8576
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:50:33.0977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3mKF0lrGBP4vTd7rZnUeeMF4yKo+Qn0UxzKf5iIcVNzdGmCMnI3NWDQW108pB+F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9352
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

On 5/14/26 09:27, Sunil Khatri wrote:
> In amdgpu_seq64_alloc there is a possibility that two difference cores
> from two separate NODES can try to and could get the same free slot.
> So this fixes that race here using atomic test_and_set clear operations.

Mhm, that shouldn't be necessary. Why can those functions be called in concurrent from multiple threads?

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index a0b479d5fff1..f4be19223588 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -175,11 +175,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device *adev, u64 *va,
>  {
>  	unsigned long bit_pos;
>  
> -	bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
> -	if (bit_pos >= adev->seq64.num_sem)
> -		return -ENOSPC;
> +	for (;;) {
> +		bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
> +		if (bit_pos >= adev->seq64.num_sem)
> +			return -ENOSPC;
>  
> -	__set_bit(bit_pos, adev->seq64.used);
> +		if (!test_and_set_bit(bit_pos, adev->seq64.used))
> +			break;
> +	}
>  
>  	*va = bit_pos * sizeof(u64) + amdgpu_seq64_get_va_base(adev);
>  
> @@ -205,7 +208,7 @@ void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>  
>  	bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / sizeof(u64);
>  	if (bit_pos < adev->seq64.num_sem)
> -		__clear_bit(bit_pos, adev->seq64.used);
> +		clear_bit(bit_pos, adev->seq64.used);
>  }
>  
>  /**

