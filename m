Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB30C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 10:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B389310E3CF;
	Thu,  4 Jan 2024 10:10:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2069.outbound.protection.outlook.com [40.107.101.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9544B10E3CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 10:10:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czQc3omzxezfmCgQTsqpesM6NK108RZXVHOUnkZG7vPYR6vKXb4R2k1SIdhrCaCJjso37AveOOoLTf0rpxrQfRMl3gsqe1rx0w12WbKnoJzfbGHPW8Xx/ZVAAUjJW0xQKUoKmeH4vAKsyG2Ne4ypziph36WDC8qcHQEUZseoLyCefrysGVbct5KbZcC7idX4tVq/b5YRFobVkdTPjdiK24jAg1frbAvFCb0joy3vLAXJ7W0NcINdQ1sT8KwI2fvv+PgBkNa9r6SagzVoBYMiaqO5jpxCn8gZkXR+HDFhwxdsZAyz4kR5JrdSDVH3CQxwyL4m4Kr9zPRkI9TWZq9gyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itrza0j4Fx2gJ1egdeEDIGt5l0n+AvI3lkCmmbDBUg4=;
 b=BnUNKECcA7/Fnn5Ww34KTesTcSdt5eY3p3xg7NtePXIGhA7L64gYqB7WsQmfxpAvhweyYbVnGDkGf1fzlogLRmMZjOk2IOTl6X7n460PGPTi+mUp5X2bQIkhSATEO2RGnCPi6K0NpfWcqjMvd5UzewInRJ50Mpk0nUbzr1yonUF55gVgL9FzrCCn/q+Ofhk0OohonLMMJNb+yxyEId4mjtoL5Er8jHArKOkSPlkEgBt0id5T5wCFxGQ3R0534uSTLKF7VBx3ibRkXTH9Dn92hz6RRrRzckEm59BsiQCjg1lWW/It0iOYNgIUWaIEG2hpmOxeGXPJ/ckIMiAUj/Enog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itrza0j4Fx2gJ1egdeEDIGt5l0n+AvI3lkCmmbDBUg4=;
 b=HkBD9kAmcOXDSLAefC6Hz6kHq2Lp8JQYqoRKZDquT4nGl2pe5z7SAWpA+vXPeayK1LUlrMRwhglNNY8sCLInUez/PSJuf4FwzfN+Epdrxtm+9mJHtm1kWKPb9z/GgsD6QKBLpozE+FrxQkp3EhOcbNS9/7yXlTL8x7aYW+uKKJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 10:10:30 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 10:10:30 +0000
Message-ID: <896efcf9-6fe5-4490-afb4-f237fd0cac85@amd.com>
Date: Thu, 4 Jan 2024 11:10:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix with right return code '-EIO' in
 'amdgpu_gmc_vram_checking()'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240104100438.2363885-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240104100438.2363885-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ac2e74-5378-4f84-61e9-08dc0d0d614e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8s8ZyruKfv2yEs+Y06q1inLZTcBiB5eVfQ3q0XPL5CWOQgjuZzmoBdVhR7H60wGmYsHdWbCX5XWddPL/Is2l0OBvVjEpDYrUaED/CQmGHqLH2uDUNz4J8vnOM+FbemZIo6SGAx2vr4eD8zFF1kawgvwTCxdA750alBNcO2zbmFqTGnHkuJS4ADqlv7zn3AJ8ra6J1YWExm3+QeyteWSuskU9kVNe9wZiD5SMMGxDcdJ9Gmyxo8YYKnhqNPuiB5s8vBN6+sSJs35q7BbrfGWRrCaYvtkQQoKDTQP/iosv9XT7KubgL5lfzH9AOe0Gd/XTXpZrbRfyJ7KbNWPqZis8d06eLiFAhuNWdJecDdcDWPjnBFO4LEGdeM8EJ8sCXdWAVOloETeAlv+kKo0m7sk7N7h19Jk4D6kyaFMIn6/PkXoGduDmQqNDj0QG00Ya4M20x2d7GkZDyY2YTVdciyvK2rJWiytOVvPf2iPK6t9SrB9XKLNtg04tikmmAWxpqu7nSl0zMYq12eesLUu9ckcsAFZMIAs7c27r6xZe12Ud8Haj4u6ny5l2WI8Uspb7UUnRkPrAht8DosJH+soZbnw162D9cYo6OM5UVONx1GVV0NfgR2O/+/RTQ0KlkjVRvDYd51sqKoNXAneH9DpCJTbEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(5660300002)(8936002)(4326008)(36756003)(8676002)(2906002)(41300700001)(86362001)(2616005)(6506007)(6512007)(31686004)(6666004)(31696002)(478600001)(83380400001)(38100700002)(26005)(66574015)(6636002)(66946007)(66476007)(66556008)(54906003)(110136005)(6486002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHY3R3R5VSs5WmxLc29GOHNwbWZET3kwU2IzVHdubUZWTW5Ta2tWWmtkSkw3?=
 =?utf-8?B?cENNRUptMlMzaGNPYTRNV21ITWp2RTFMNVRSclZaNzhENnVkVW5SN3o0eGc4?=
 =?utf-8?B?c1huOFoxY21NMm5pK2lpYlJCU1lHcFU3WDMzTXg2R2xmeDJ0d3R2TVZRMTk3?=
 =?utf-8?B?c1FLWldvWnBIVXBYREhUanlKdWprOFNjK3VXUklOdDlESzhaQmtybHlER0VG?=
 =?utf-8?B?TVl1b0ZlWFlFdlMrY09rM1R0d1ZTYUJlU3VSMWJuQXRqTkVYVjc5ODJRaVNu?=
 =?utf-8?B?WEY3ekxmLzNJRWRNekFDQTd4cSs0K3dZUitJbWRVd2hPN2poejVyZUNQVlhl?=
 =?utf-8?B?WWROUm04amNSRnpPYVlvSDl6V0xyTkFYTHhEbUVDOEtsdktZL01BN2VDY0Q5?=
 =?utf-8?B?M2hCaTdsdjRlNFRZZGRmMzQ0c3VwcEZQRHhOQlI4RndkOHRoamZVYXUweG9a?=
 =?utf-8?B?Slk3OGp0Mk01VHQyQ3FQQjUrOCtTNGxjSStscEQxYlNtSUVsQU9pWmNFMktR?=
 =?utf-8?B?U2s4dmphdURFNXlpZDhleHlVUWQ2d0ZiV0gzdjFHWThTVHBzWkFXL2FmK3dB?=
 =?utf-8?B?N1B0aW5Na1U0SUUrSmJXZ0I3NkNtK0o0YXMrZm9VSzltQjRrYWZSQTF4N3di?=
 =?utf-8?B?a0RTNDFuMSt3d3hmbDl6VlFNRXdHcERlNEhIMXUxUm9Fb3huSWRiV1F3NEFP?=
 =?utf-8?B?VUN6Z1R1RHd2SWxhMFE4bkVsNnVURzRNbFBRUEtxSWh0cGZmWEpocXhWamhk?=
 =?utf-8?B?bFRhQjJmZVFoeVZDSzBLcmdmbGl3WEhSVUlCM3crd256Rkl1WUpuYlcxdFMx?=
 =?utf-8?B?UVN6UVNia3AwalhzekNrbDJmS3U1Nmc3YUU5aHRuZUZYOE9qYkFKNlNnR0g5?=
 =?utf-8?B?aVlCcmYwd3pkWjNiajFDMEtNcnZROWZSMFRPRGYwelBnbzNwQVh3Um1KNyt3?=
 =?utf-8?B?SytETVAyOVFJVWNrcWZoQlhzbzJLTSsrWEtpWURuTUhZSDdRY25vcDdJZDM3?=
 =?utf-8?B?SlBCVER3dDZqZ2liREZ0NlVWR1Rtdm85UDdYTDljZEVyZkRmY1hzRjlOc0xx?=
 =?utf-8?B?OEY1NXZoV2g4ZlhTcmdVWE0zMmNJd0UrdHRKbk50NDZ5T2tTUGxLcHZyL3RE?=
 =?utf-8?B?Q0doUDVMNjlUWnNIUyt5MEJIbzZIRldidzlsUEViZTE4T1paMkd3WmVkY2lp?=
 =?utf-8?B?UXRNeTEvV2NxS3RVaDRWazFhZTl3bVdwSVhLejh0WVVrWmFtL1JsbGhGMHVt?=
 =?utf-8?B?RUkxZGI5bENrMDVWZGtNcHRENkdJdzNaaXZqT241QUpuNWE4QzZIOHREN1Q5?=
 =?utf-8?B?YWVYTko3Zk0ySGxkT0hkTkg3WkI5MDlNNmpJbDVjUWdIWWdWbTVzNVhIYS9V?=
 =?utf-8?B?RVpmN3daTjNKNUhFSTlPV0E4ZVN1dTlCUThKaUxxVWtOa1Bzenh0SEJOQldt?=
 =?utf-8?B?SWhQOHMxNFlLT3loS0VFUjh0cnNVSi9ZUnFtVjRpZTA3NUdaTkluZGJuelk0?=
 =?utf-8?B?VVY1ams3NGl3cXMwSHQ2MVd2MW9ucXNCTHhzZVJldzZWTFMwR09vaDlCdVdk?=
 =?utf-8?B?WDdROHFSZ0wrQTJRODZmZ3UrQXdZalNnTVExb29qMDhveXhmN1F4TkR3OGxB?=
 =?utf-8?B?K0YrY0U2dSs3RitYMFlTSjVlejN6RFdwTWNFeFJod2FpcFU2UjhxWUtPWGpN?=
 =?utf-8?B?dmtTdCtDUDd4cXFMendYVGQ4dmh3eDIvRTJZdlFHa1JpdkwrWWlNeXh0d0c2?=
 =?utf-8?B?WlBHbG9ON1crZEUrT1NLQUxwWlk5aDRJcmdVTXo4cVVzdGdPcExXM2dnU2s3?=
 =?utf-8?B?bE1QRFd3aTc0YjdDbm0weFFNUVdWVFVTWmxPSDhaU0dqMmR5U0VVL3VTdGd6?=
 =?utf-8?B?UzlENFptcE9MeFY1M0t6L3JXdHZJa25xUTFKSXV0QWhlU2Q2V2h6MFhoV2tR?=
 =?utf-8?B?UWduL1dKRk9GdHpJR0JBdXhZQkJhWHpZWGg0Q2lBQXErSURWS21WT2Y1aEQ2?=
 =?utf-8?B?b0JhT1FxZmJKYWIzcEZFUXM2MjBsTTUvTmhrZmRJQmlmZ0JjMlA4djVlMUxI?=
 =?utf-8?B?SHp6Z0lERE92bFJRL1JoTmNhMG9uZldCU0p2RytNZjVnWjRxY1FwUE9pc1p1?=
 =?utf-8?Q?00MSEedAYLK8LI/6LSg8U69vG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ac2e74-5378-4f84-61e9-08dc0d0d614e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 10:10:30.5766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5cY3Ly4fD3GrPnBMo3xPHmOi9SYzsYcu6tLZjvUCbvRDx37lybpQYf/krqahIP6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.01.24 um 11:04 schrieb Srinivasan Shanmugam:
> The amdgpu_gmc_vram_checking() function in emulation checks whether
> all of the memory range of shared system memory could be accessed by
> GPU, from this aspect, -EIO is returned for error scenarios.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:919 gmc_v6_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1103 gmc_v7_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1223 gmc_v8_0_hw_init() warn: missing error code? 'r'
> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:2344 gmc_v9_0_hw_init() warn: missing error code? 'r'
>
> Cc: Xiaojian Du <Xiaojian.Du@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index d2f273d77e59..de9576b243aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1046,15 +1046,15 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>   	 */
>   	ret = memcmp(vram_ptr, cptr, 10);
>   	if (ret)
> -		return ret;
> +		return -EIO;
>   
>   	ret = memcmp(vram_ptr + (size / 2), cptr, 10);
>   	if (ret)
> -		return ret;
> +		return -EIO;
>   
>   	ret = memcmp(vram_ptr + size - 10, cptr, 10);
>   	if (ret)
> -		return ret;
> +		return -EIO;

Not a fault of this patch, but the error handling here is broken as well.

In other words when memcmp() fails we don't release the temporary buffer.

Probably a good idea to fix that as well while at it.

Regards,
Christian.

>   
>   	amdgpu_bo_free_kernel(&vram_bo, &vram_gpu,
>   			&vram_ptr);

