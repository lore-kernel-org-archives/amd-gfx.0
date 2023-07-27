Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE93C001E0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 08:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D3010E509;
	Thu, 27 Jul 2023 08:01:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC0A10E508
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 08:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBdFy+UCphl2WkHs6xSLuSpjOVBvQiJAwJipSme3r3H6OgC7wF+njlK3t2u8gevlK9flJFrqpF3BtCVKGQB9UikIIRbedYZaRTW0IrYHWwcMjSACnpHM83ih2a3xrxkXrWs6S5g5WGjgI+v5NseIfHP1Z8OvfolWauewwUhy01/N1UgICF+/664GuP5lSFPGyvSHSwsZy4z0PLsPh2pSKgUn6vFpkWa+DhZcdQER+jVMJV6fmz73kinqfHGrREDMUA5fgEnN4x0rBWOeSI+YcMPZegUJ/XFdLXISDb9HaOgvytvi6/g0/jrzewe+Q0lfRmv54LFs3Uy9gntTDecJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMOUCF7lYsyIIcNFk8BcVzjG48Ui2yLTbTHX3M01QKQ=;
 b=VXy7Fd0N4oRS45QMgiFWYAPMCDwOvrEeShLQrPBXZ8UzRvlNMqLwSMM3x26UsvItojajmzKY9r1MBdZR1FnlVTrxnfzWyM4mHj1ZNPwXPGj0GxH8VAH3uzNn0lEyQR3Xy8aGx74Qrf8XKr4u05HBDD67KfWX1+VnKUl/jahzGXKHr5usC1YBd2fmM9DwO2lwv0sxvx7kiHMlgRp1RrOjos0EBYbR+EMxljmC33CUBdXI25qkatmO1b3AoLWdFCOV/9QTk3Rty47L3HrTxwlSGR85Nm6jywXk8Xx21Ns3A4Y/Ccnr5KDpgwkzRgge5GgMWXS+wKkUbWb8iWIFS0XegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMOUCF7lYsyIIcNFk8BcVzjG48Ui2yLTbTHX3M01QKQ=;
 b=Xo1Ay+W4heroSFipIKBnNSh0uQNwxtVr35WdCr/UloVgHc/XP88URxxtPUERJpVKAjFF4LwEYr3qDhDIOedng0V6axsLOFC0uNfeFw8DS/4mcutk+iWrUW8npNf32O2XjmFwtN8S/FzK+vVCAjgNBiDRh4NPT7OaBCoIFnY2C+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 08:01:52 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 08:01:52 +0000
Message-ID: <f786e262-4d64-2274-c740-8a69cc7b8ea7@amd.com>
Date: Thu, 27 Jul 2023 10:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] drm/amdgpu: use amdgpu_bo_create_kernel_at() to
 create large TMR for APU
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230727075620.728235-1-Lang.Yu@amd.com>
 <20230727075620.728235-2-Lang.Yu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230727075620.728235-2-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: f92a2786-916d-40de-3b39-08db8e77bce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpwfCZEJ7FZWp21MGzYRQQ9EKBppsnkgewp10Oo7QJWGtl09fumfLPf7fVsnW/qiGTA65SL3PPPd53e5T/lqlCXhKlrx5NonYVt5zbzcAioiyVFQjohT47Vj4mf1v9JWEX61i/DlKJGHnV7zx4VdCzQxYekIl6O0X2DfB0uEh/TuVi0CP7YSdINAWyTMp4PrN6GTcwk8OSUOHRhv5N5pLmghlB/I90swQ2qLQg2AuQNLaoF+UJjW5W1Vf99ixtzgLwIWvShqXxHfqY2FYVDtZp9DErki7mt7KsqAGfnjpjW7vRMLQnbOFYN7d4oZVyZ+6Q7NGtRrb7imctRTYJB7VDzMF6XtSEcaqXWd23Xw/aKf1c2swKRFQh/zceSBCb2qIUSNlv+ioud+VM3sLvUg62zGyzm8D6Z8XEAQOkedqxKmQnnQFtajKlgNb55+yXCaiZablp4dsGZm66+ie6/bU5/FhZDYgoIWzhyDjy8AxF3dYXuEl5Mx2RjVQ6H9m4kf6cyz1JEOyTPfPxRZvRqJvCV4dWhQ9ZRif62OFqhnz2c4OMDBIOAt7DtbnLL/bbSR62A3Nhc3fcBwPZNwSQfbmZ93iQ9/SZrcdFjvMddq77OFcMjlNp8CIKuQj66nz76NTi30F2Hye7CQkilNqVUonQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(451199021)(316002)(41300700001)(8676002)(8936002)(6506007)(54906003)(66946007)(478600001)(66476007)(6512007)(66556008)(4326008)(6666004)(6486002)(38100700002)(36756003)(2616005)(2906002)(83380400001)(86362001)(31686004)(31696002)(186003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHMrWFJhKzRlZzVvUkRoS1JjVUd6eVh6cVlvbmFlSVo5S2FlSXUzVEd0bXRG?=
 =?utf-8?B?K29JVkQ0RG5kbWh6c2xXbnhBQXo4dHIzcWpXZkhkNFg5aUo3dlZpOVNiV1ll?=
 =?utf-8?B?RDJQbWhhcTZicHpaRFhsOU9NbUI2RnpoNUs5NjZ0eHJyVGVEK2xWQU1xaXdI?=
 =?utf-8?B?b0FsTVJxNmZ3Yk1CNktkQVM1KzhkY29wbHZlT0hVK3pCRDlnZXRpSkNxWlVL?=
 =?utf-8?B?M0ZtYzVQeURja2lSdExGWU9QSEs4RGtZTy9DdmlDVFZoOXlvUUF4Ty9Qc0ZW?=
 =?utf-8?B?b0tVUWJ1cTdQZVlITjlMS1BsYms5TzRodm9GWitmYko5d1dEYWhLQ0V4WGVR?=
 =?utf-8?B?dE9aaHp1VDJlVVN4bmMzUFVzTzFZRUY0YzBpYVFuNXVWbGlVUDUzMm5KWStz?=
 =?utf-8?B?TVdnQzdJaWYvazVaUStjeHBvaUxQdERhUzJlVVV0WDhMcUhGa0RUODJQN0Jt?=
 =?utf-8?B?bUdpS3RWMzBSU2dJVSs4RWlrdGlEVlJ3bEJJQ1Q3bWRPd09XMXpPZnFHQkpx?=
 =?utf-8?B?VnB0WnU5R09MZ0Z2V2lXTTdlNndMWE9SYmZDTlVWRXdXZkNCSUdHV2JJRnpr?=
 =?utf-8?B?bDFMWTFNVHRQVldtOWx4SCsvSVFtNW85UDJraU9IYTR4T0taeGtORkxsR0lG?=
 =?utf-8?B?OWtBVFp6UUJwdDFzUzEvZFFYaUxmOFlWbnh1MWViUW11QjRuVWM4NUplakNJ?=
 =?utf-8?B?b01EeURlTVJjbDY1aXV6QmtBa2wwZkpQY1F6RU1lOXE5aTR4QnZhTVhCb3Nz?=
 =?utf-8?B?UWNIVklaZlVjazJvME14S1h6TGNZOVQ1U01pMFBBQy9va2lNYVhGbEMxbkgy?=
 =?utf-8?B?VjVXQjJPdHYwUm5BYVJnbWJxR3hrMnpuejBqUzZpR2NKWG05L3U3T25MWXI2?=
 =?utf-8?B?S0xva3BKUzlsY3VxVVNuVCszanU5aEFOOWoxUEU5L2V2T2gzVTNVV3h2OEt4?=
 =?utf-8?B?enZWN1J1ZnhaVitLMGNPdktnZVJvV3RLVXgrYi8xd3hsNElRYkFqQ1ROUFFt?=
 =?utf-8?B?YzNxTCtjN1h2dFZ0OXhaaG0weWw3dHBBWU9VdlZmcVAyNWRTRVorNjF0ckdz?=
 =?utf-8?B?MjlwQVlCaGc3dkRQQllDcEloU0R4U0NweUdIRGtVL1gxU0EwUTdYUk84U2Nn?=
 =?utf-8?B?bFlkam9uWlU5SVJPVUR3K1lBZHRCVlN3eTdnN3RtbTFnVUZtMmlaM0tlZnp6?=
 =?utf-8?B?NHFzQU5HbzlGeEE3aXgrbVVsMzVxYmkwL2dBQWF6aWhuKzNVM05wQ0djUWRX?=
 =?utf-8?B?ZnQxMUJ2V2JCRjh0VU13K0IwaG5aczFyU1cvSUdKc3krQUpTcW5ucmg4dXZ2?=
 =?utf-8?B?ay91QnQ5cEFlZmM4a2NyRUh1Q3ZhdXFEWHR1YWZqNDBPRjFCR0hLWDR1bEVO?=
 =?utf-8?B?SC9JQzdkN2x3cFJJS2taT0dLc0lTM3A5ZWpJMnRETjlDVUszYnIzR3JZQThR?=
 =?utf-8?B?aG1CcW9lSGJ5QUJvQVBOUmdyMEplV3pJNjYySkZWc05xYWt1a1dRczlkWnV1?=
 =?utf-8?B?U3d0Y251Tm9BSUxUT0VRSUlKRlBIZ3JNMldMZE9yaERuczZiV2xLK0JoU2Rx?=
 =?utf-8?B?RWlrWmRPcTA0OFBTc0Y2ZEFLNTZXUFdMMVRZVFNUaHBpMHRoeXZ2ZTZlR3N0?=
 =?utf-8?B?NW9WZkpwSlFrdWVkcUF4SXFlZUhYMTdoQk5SSFVJdlA4blVSMHNCRGkxT3kx?=
 =?utf-8?B?NjNqcHFUSytYLzZuRng4TDkycWFqdGNrTEIrckxzRjdTSWtocDFvYW5WOEw1?=
 =?utf-8?B?OTBPQjRyMGV2TzZJUzJpMmdJZFN6cHlvWklHOUc0WDJiRzVnRlNDQ2hpNE1l?=
 =?utf-8?B?MC93bk9pVlZJbm9lZmZCK3ppMHVqdHNLN0pkZ3Vla0NLemYwWnAvTGQvZGpH?=
 =?utf-8?B?UCs3WmR3N2p3R2R2M3FwZmpkbjV0TUtkUi9xNWFuNEhtcjFFSDMxeWhjcFVy?=
 =?utf-8?B?TGh6ejlKcnhwd3hUdmtRWFFCWGdvZm03UDNXb0V5dFlGRVJicTMwNFcvTVpq?=
 =?utf-8?B?aDcxZTF0Z0lzZWRjSjZUTjQyb0d4aEZDOVBzNzFqK2tXTENQazRCUVRsN05Q?=
 =?utf-8?B?NnhBaEkwbEZZWFlpQmZ4UnBCY0FhTFJJSmVZVlhqQjFNZFRXcEtVNS84amhV?=
 =?utf-8?B?b0p3WjFBS2dGLzRaU0xWQnlWYzFHREdDU05Xc24vV0RRRmhtWDVrYVF2ZDlu?=
 =?utf-8?Q?yrFAY5X+hWXFeOmMxj8/NQvUSjzWjYrqLUpFOHALAi9X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92a2786-916d-40de-3b39-08db8e77bce6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 08:01:52.6900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbVu6sJnwAprZh0A9WDJypPmvtMrV0Mi0fx57LFNqgToN0A251kBHZ5rriti5pAV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.07.23 um 09:56 schrieb Lang Yu:
> TMR requires physical contiguous memory, amdgpu_bo_create_kernel()
> can't satisfy large(>128MB) physical contiguous memory allocation
> request with default 512MB VRAM on APU.
>
> When requested TMR size > 128MB, use amdgpu_bo_create_kernel_at()
> to create the TMR BO at offset 64MB.

Well complete NAK, you have misunderstood what 
amdgpu_bo_create_kernel_at() is doing.

Regards,
Christian.

>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 42 ++++++++++++++++---------
>   1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 15217e33b51d..2eac82113d34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -783,13 +783,38 @@ static bool psp_boottime_tmr(struct psp_context *psp)
>   	}
>   }
>   
> +static inline int psp_create_tmr_bo(struct psp_context *psp, int tmr_size)
> +{
> +	void *tmr_buf;
> +	void **pptr;
> +	int ret;
> +
> +	if (psp->tmr_bo)
> +		return 0;
> +
> +	pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> +
> +	if (psp->adev->flags & AMD_IS_APU && tmr_size > 0x8000000)
> +		ret = amdgpu_bo_create_kernel_at(psp->adev, 0x4000000, tmr_size,
> +						 &psp->tmr_bo, &psp->tmr_mc_addr,
> +						 pptr);
> +	else
> +		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
> +					      PSP_TMR_ALIGNMENT,
> +					      AMDGPU_HAS_VRAM(psp->adev) ?
> +					      AMDGPU_GEM_DOMAIN_VRAM :
> +					      AMDGPU_GEM_DOMAIN_GTT,
> +					      &psp->tmr_bo, &psp->tmr_mc_addr,
> +					      pptr);
> +
> +	return ret;
> +}
> +
>   /* Set up Trusted Memory Region */
>   static int psp_tmr_init(struct psp_context *psp)
>   {
>   	int ret = 0;
>   	int tmr_size;
> -	void *tmr_buf;
> -	void **pptr;
>   
>   	/*
>   	 * According to HW engineer, they prefer the TMR address be "naturally
> @@ -813,18 +838,7 @@ static int psp_tmr_init(struct psp_context *psp)
>   		}
>   	}
>   
> -	if (!psp->tmr_bo) {
> -		pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> -		ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
> -					      PSP_TMR_ALIGNMENT,
> -					      AMDGPU_HAS_VRAM(psp->adev) ?
> -					      AMDGPU_GEM_DOMAIN_VRAM :
> -					      AMDGPU_GEM_DOMAIN_GTT,
> -					      &psp->tmr_bo, &psp->tmr_mc_addr,
> -					      pptr);
> -	}
> -
> -	return ret;
> +	return psp_create_tmr_bo(psp, tmr_size);
>   }
>   
>   static bool psp_skip_tmr(struct psp_context *psp)

