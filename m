Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BA2CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 12:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE7E10EE76;
	Tue, 29 Sep 2026 12:04:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PMg4KOwH";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50B010EE75
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 12:04:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhydPEVxMdh4Fw+ZAJuVqWuMwKzqGpwWWVnB1VadW7QwyaH47nQnPvMkPm5lOmeRbInw+H9wECJZ+RMSwOjEXDxxaqBJzJ30aqT2AGNbDr/W5yr5ky3+Ji2TLyuTr6IgWBBiFIv08NR4IOvJoyqH0skogy4vyQkFnfvnMzJp4B/wjWrCHSpZDEGRv4AnWbpOdd6fQ24LzOHiPe4C9AGf4YZxn9mipP6eLkAPV+bNymtsvNZvVpePfr7tN7iZIlc+R9IV9xixSHLb/Wy4JOJ/7M1AYGuIEkw/OXkgr4crFpqIMV2XLmXL8jNzYnXTVFBou14/BGaRGuWaDK67RJzroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDsZxQBYDie8xyGzKA8vVwUQepY7rfQQ+pfI+3JvFd8=;
 b=LFtYDnoDCg+8El1LhePbS1TrNMZJK65zb2KfEB0vgmPHpjfEdmBHWbp5dR2wPIYKDy/RYgY0r3eNpczekfoj9N8ATMpeQ3onF8E3C/dsJtU44qBVa4B5iT86hHtKtMGwsJGKkPFc1zxvJeOpWSENmoz6L1qvOwrthT870/c6lFgjoGS5SQXdkUCjrE8jiZ5wnrVie2FQs2FSntW+WGE3IsqaXSpcRcqpNshuI/hG/xRhxQ3Vm5IvkQyvRNzH7sZ0wwp9SW6eEgrmMJJ/EPFk8MWVKxlbG7VzBGJWVwrijsxD1WccbYGLHDCKs9L6xrUoaKt9LG84zk7Zwn3uiYFdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDsZxQBYDie8xyGzKA8vVwUQepY7rfQQ+pfI+3JvFd8=;
 b=PMg4KOwHWfEDNoGoprJMdef32KKqBBBG7cVbUzVNb43yR7MDZSJt/EgyxLR9FNZ7qxWz+ztYF5JUqzssfM3yJ3EkfcIDwj5Ic1j9TcZs3ApcC4jcB1Y6Cqwt+45SMVNjl/+0QqltAoG71MkVnHm1SvFtif5o1LJnS35nsuu1MWo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:04:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 12:04:07 +0000
Message-ID: <fb63b082-0430-4711-b68e-d2eac63db26c@amd.com>
Date: Tue, 29 Sep 2026 14:04:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] drm/amdgpu: use spm_vmid for the default RLC SPM
 VMID
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Zhu James <James.Zhu@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Ma Bing <Bing.Ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260928185756.2382322-1-sunil.khatri@amd.com>
 <20260928185756.2382322-9-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260928185756.2382322-9-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: a84f36ac-7c40-4881-2df5-08df1e21c3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|11063799006|18002099003|4143699003|22082099003;
X-Microsoft-Antispam-Message-Info: 6hpzr+HAjiGKumsMLdUqEWXZzia/T+kiogqIfR41nVNpXFPQ47h8EgDusCo8+lECAlD7qn6yNMlaqIbSvfdyWGSpkrmgh5eqdn2M6OqI2tYgeXGJU7NYyqJNEeJ/pRCuThvD8QQrIaf0M1NfDJunDKpNXN4I+Tyg0yA531GFRLKY+9+S34yk6i0Y8bPRWh0YlJOr4N1H+b9cfJZPd/fAjOj1LMlRLkdz0oFOifZfgPIUTfVZQct/nY4SoxHpvm+/KZSWhonaL4NA47W6u7YhJxS32QOwaMnPbwUdT/wfo7Ekd0fqZ93vC4ncvm4SZ+BuS2WqF3r1Yf3XRqKQv6YVmdpmgNGNSXaRwG2Y8Kcy1JDQmrzWE3+pqrj7CDzY28auUNftSMxdc9s2n3LqNqksfLjqdEMH/3kPhsDzsrI+zHGkF0nwbqT/cbXlDaMciOxgWZY4LZ1fSbg1zD+1nCjREvrmnaNxs7xysIAaqSjAocxvCyz7S5gP9UD+OxZUm2+bPV1GJ/ncBAMUbkCpvqNwWbY2AaWlOLj3kGZUbYAbOPaJbhYR0V0ZlMsQxxu9x6guGVZHwtT6iUN81Jw+zFp4RwCO5Qul28O7SuSwp2EO0PN7jZEnKKbXJTeENlRenS7/o/TRZY95BnPojemM7Th9DZgeINMBpXmfn0WugdBeWJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(18002099003)(4143699003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xvcktxMi9WemZVcmhFdlRyaHpGUklyYlNHUEd1Q1lQUlVZV0ZDY2Y5Qklp?=
 =?utf-8?B?NGxmdU9jMVNUZm56eXFGK0hoaEQ0UjEwd3lxUlorL0dDd2ZMVGVhcEVEbGFw?=
 =?utf-8?B?NjFmcEQ4TzlWNndFUDk1eWlVT05nQURXZUJRQVZlNmgyZlh6a05kS3pHei9x?=
 =?utf-8?B?dTByOEQwUEFtRk1YaUorZU1nckNQenF5RlpETCtoa1Y5VURadnZkVlBDU3Bw?=
 =?utf-8?B?NXdJZG1tVkRFMDJTQTh2a3JwUnMvNXlJMUdnd24zSDJKTDV6Y0tkcG5IQnp0?=
 =?utf-8?B?QzBzSWhQaWV3dThMUTgrb0cyL1VMWlBvQW1UN29SLzNIam1WUXc2aFZsZ29J?=
 =?utf-8?B?WXR4Z0xsdXpCK3I2SDJlY0UwL1Y0WEtmcytWMTZTSDNhSVhVOWZUb3VCeXpS?=
 =?utf-8?B?c3BOQkh6NStINFFVengyQkh0UDZFbWJRNUQxeVF2dVV1WnZpRnpMVjRyTFpB?=
 =?utf-8?B?Y2pXQ0g5RXE3c0RzRW5xU0c3RUZrc283bENZTUFYUVk5d1M1Y0VOVXVZV3ZY?=
 =?utf-8?B?S0J1c29ORXd1Qnhab2dmVHRiK0dIZ1dKK3pTVmZ1dkV3aWhNVjM4RkdaWFdl?=
 =?utf-8?B?R1hqY1VkMVJ6ZGNMY1Z0QUNGdDZqWG5UUEtFYkZSVXJrbVFOYVlnZlJDSFYw?=
 =?utf-8?B?KzcxUU5vTnZuWjU4dUR4WDJ0Z0szK3JSTjhyNkR2V2NwekV6SUZ1dDMxOEZE?=
 =?utf-8?B?UGtqZVBBNkVBVXhsL0NRYlczVHhveHJ6eTRGYUkzYXVpMjJiT2djakZPanVS?=
 =?utf-8?B?dXQ1TVpYUUdISlN3VW5lcVc1WGVWMWpzOTYzbi9Jak1KTDZabW9kc2pEbncr?=
 =?utf-8?B?MSszeXVpQkhRdWRzQ21TVjVGLy9BRmc2Nm04WmFWTy9QVjY5Mko2VVZjbnBw?=
 =?utf-8?B?Y0wrMEw2VC9Fck1HM3ZuNVIyc0dEYjE0U3pSdjlBVHBaYitBT3ZiZFZSdmtv?=
 =?utf-8?B?bXhaSG9Taks4NnJkWXNjb3NFVFB3akFLTGlNL250bmtpUmszSG95M2l6TGJk?=
 =?utf-8?B?WXV6eEZ5MTZCSVlZTVhNYmVJenN0cXozbWNqRTh5U1NzdG53TWxQWXpTWUJs?=
 =?utf-8?B?ajdCUXdmYW52ZFRCR01rR3lqenpYRkdEbjdGK1drSEZDRmYvczUyN2dNb1Iv?=
 =?utf-8?B?ZTBNUkxWZE9DV2lBSVJodkRwaXA4bFplMWdWelF4K0VTTEo0N3M2WUIyeTlH?=
 =?utf-8?B?VzFRVytRSTlHU21tMEFrVG9xVjBQb1VDNEJuUDVHR2lncXVrYnlQLzZqQy9J?=
 =?utf-8?B?Y21WcmNYaTMvblBqNGx3bVBlVTNsZE1GQmQ5VHdCQlhDY2swcExCZy9lRFBZ?=
 =?utf-8?B?WXAyTnhZQWx4UnFaMWp4TXRKZURJUTZrNW1QeW55WllkdmFFS0ZubEs1bk5m?=
 =?utf-8?B?V1krVGk5dUNQUnFUN0g4bE1ZY2tsQWxGQTJDeHZ5Q1RieEsycmpoc3ZNTmNw?=
 =?utf-8?B?QllhWnpteXAzT2NVU0tBMGhCRXlKOGszL1lnU2JLTytxbW9EMVdORlllU1Rp?=
 =?utf-8?B?QUtTVzg1bUVKOXQyRzFtbzlnR2ZBNTNIb0JnQUNtSXlFNzg0Z2xmaElaWDdt?=
 =?utf-8?B?N1QweS9ubVFCbXJzd1gyTjNKV3FNVGp5T3hSVkRQb1JvaDlua2t1Y1BDVzZB?=
 =?utf-8?B?NCtoZmQrV0dWbkpBdTBNYzNxUTBkd1BYRk5DMm0xZi9uRnZKMGo2WjV1eEQw?=
 =?utf-8?B?VjJJSEF4TzFtU1RMWGFUOG5KRE9xUUhIYkl5ak90WHBRanhuM1QrMFFzSEZp?=
 =?utf-8?B?WnVFc2l4aUJSNVBSR0pNeW1QS09wTUtWb1BNTlNHM0Q5amp5WU9CK1hkZmNC?=
 =?utf-8?B?Um1CeTk2TTBJcDNVdHJiRHhWbGZSR0puRFdDdnBBdk5DMWk1Umt2Q1lKbytD?=
 =?utf-8?B?d3dJbWJscXdLcE1PZ0RQSURGdmVya2R4RUtLY2tsMDNTNmtqMk40TzVwcWo2?=
 =?utf-8?B?QmpnWDJRTnhYV0lQYmpraUE5OUIrM2dCOGowaUU5UlM2YU10SG9kcDdiMDhj?=
 =?utf-8?B?NTl1T0lHS00rK1Z2UXJLZGdneUttTXREblo1T3Z4eDBNS1FRaGtiV1JEZFRN?=
 =?utf-8?B?ZDhGZlkrNWNLTzU1RWZ0WmdrQ1VDbkYrZ2xQZG03Tzd4QVdoWmhTOVNtMmIv?=
 =?utf-8?B?U2lzYlVqbzI0T2paSVpDQkwzRmNuVE5QT2N2c2F6bW80bUwwdjdjUHZhd2hQ?=
 =?utf-8?B?M0JOVnFsdlgrV2cxV21MY0hUL1cwdGZZVlFsTy9iaWxWNXNFcXNtaS9WOEdN?=
 =?utf-8?B?dXlFWndhRnp2N2NJY3AweDJIUzNDeHBGMC8yeTV6Z3ZDL2lrTkdhbEw2TC9k?=
 =?utf-8?Q?FWiTy59Fxm8Aa+QAAs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a84f36ac-7c40-4881-2df5-08df1e21c3c5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:04:07.8784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqaZ5TkYe7mid/lOcluu3rRbAa7RsCDtLJyGz7un7MZefqRVlf3pDbWng9I30xvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068
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

On 9/28/26 20:57, Sunil Khatri wrote:
> The RLC bring-up paths programmed the RLC_SPM_VMID field to a hardcoded
> 0xf as the idle default. Now that the dedicated SPM VMID is tracked in
> vm_manager.spm_vmid, use it directly so the idle default matches the
> VMID the reservation path hands out.
> 
> No functional change: spm_vmid is the top VMID (0xf) on all affected
> generations (gfx7 through gfx12).

You also need to remove all the calls to adev->gfx.rlc.funcs->update_spm_vmid from amdgpu_vm_flush() and amdgpu_ib_schedule().

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 33403e16df5ca..88f9f0b0bf524 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5583,7 +5583,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>  
>  		gfx_v10_0_init_csb(adev);
>  
> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>  
>  		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
>  			gfx_v10_0_rlc_enable_srm(adev);
> @@ -5615,7 +5615,7 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
>  
>  		gfx_v10_0_init_csb(adev);
>  
> -		gfx_v10_0_update_spm_vmid_internal(adev, 0xf);
> +		gfx_v10_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>  
>  		adev->gfx.rlc.funcs->start(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7bfc8cbdcad85..036d1b7ade4e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -944,7 +944,7 @@ static int gfx_v11_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index b75512e7b1db6..4caa43ff50a1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -773,7 +773,7 @@ static int gfx_v12_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 91764f2e5ad01..a3d72cbaa6cf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1848,7 +1848,7 @@ static int gfx_v12_1_xcc_rlc_resume(struct amdgpu_device *adev,
>  	int r;
>  
>  	/* init spm vmid with 0xf */
> -	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, 0xf);
> +	gfx_v12_1_update_spm_vmid(adev, xcc_id, NULL, adev->vm_manager.spm_vmid);
>  
>  	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>  		gfx_v12_1_xcc_init_csb(adev, xcc_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 549d1239e326b..04ee7e1725a94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3252,7 +3252,7 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index ab4123ddbb942..61ba71b57b8e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1274,7 +1274,7 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>  
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1678015ce5a97..4862d17a58237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3240,7 +3240,7 @@ static int gfx_v9_0_rlc_resume(struct amdgpu_device *adev)
>  		break;
>  	}
>  
> -	gfx_v9_0_update_spm_vmid_internal(adev, 0xf);
> +	gfx_v9_0_update_spm_vmid_internal(adev, adev->vm_manager.spm_vmid);
>  
>  	adev->gfx.rlc.funcs->start(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 01ed1701c781a..add8099cf8e05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1395,7 +1395,7 @@ static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
>  {
>  	/* init spm vmid with 0xf */
>  	if (adev->gfx.rlc.funcs->update_spm_vmid)
> -		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, 0xf);
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, NULL, adev->vm_manager.spm_vmid);
>  
>  	return 0;
>  }

