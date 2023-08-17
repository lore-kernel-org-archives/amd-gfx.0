Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C8EC5479A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 20:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB37310E08E;
	Thu, 17 Aug 2023 20:05:42 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147AF10E08E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 20:05:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KztidVaS5+lgK273UgZdfTs4EPr2qccJhvSORfpmthSX4ABdrkrmlM1PISHLkr9gGgB9w1U//4rk+ACK6U+JsEkMlV2gG8e0KyGY4uQ86ZQ3hE8NfvmZdGtOzaCSTpBpyuCJUYMNW3QIVGoDRpkFX/Ri8aC1bQP3688xwZkQZPMT+KcMEMAH5TSyXOkQmANpd5L58EAsWAE+zvCDM2WlCu0xJIHbJxCwC38bvsslADE9JYXv6PrDGGRtSpY0Kn5e56rhoD6tP5J4ruQiUoMp4z0qzj3zZeumlANiH/zbpOw83JU2lzCBtC/LqfLrKMWOs1QbMgrwr2e+fd8R8/4ZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rm91NByxCH2XKBxJJle/jPAFPRsaKjXmBZWLUDKkjw=;
 b=lyTixt0bNjfnuoUpQY51VOVikf88JpWRBT+lx9uskZvs2l3vxaK89HQeb2/H4rgvNI17Xmd3kpxgVCMIWrpNalG1oFj4cPY40ji6s71CgayKqSUSTp5PJ6XJPGqGtmvH7VVVUIMYW02G/C9UJdR6YeAOcf2lsOManI+A6bH4WbGXoFUgTZCiuWOFNwQWJSGsTBTPqHNoEdtrPDNeFbIQAlf5jnCkZ2s69DKV69oTEB41tb7NOR9t690SPIwHeMTJ5Q8BJOGJ8VYJPVerPvqxx1Nji4O3j69HaRoeN1oCasV34ngFImnhk2XLrSJmmtD9e4xrxKC5eZD2qVjYJb0QXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rm91NByxCH2XKBxJJle/jPAFPRsaKjXmBZWLUDKkjw=;
 b=wu4Or20JSAYo/4f0nVWoGf3HFs9PRQWt4BOsnA8HRMgVaXEh+tB0cYDoUWqyY3qdV5L1htL/mnxyCoDZujBWPA0WQqoz1x+XULNXzqrTxdfh4D9WybNPfOsEpOfwQXSThGDFsKAvyYH6eYePt0mehA02PGCXClPWskJHBA8ycus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Thu, 17 Aug
 2023 20:05:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 20:05:38 +0000
Message-ID: <34b053df-a13c-4f6d-961d-48d67e8f1c86@amd.com>
Date: Thu, 17 Aug 2023 16:05:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: use correct method to get clock under SRIOV
Content-Language: en-US
To: Horace Chen <horace.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230817110816.2837-1-horace.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230817110816.2837-1-horace.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: b635d097-6df3-4f27-8806-08db9f5d5370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTvEEf9KmwGZ6ycs3pKUQ6WV/ZHGp11Gl36g/H4XzmXkRDvkaCSfzZj8xCE3f6sKwMu3LW6/1oOOdkUu0coDL1ck/8t6AG3kAyjngviOdQ+Wd1HY1E07lWXqbyrcGRQ76ee//KGznOZBz+SgWa4yRX2xq22IWBleJEWzGFXtocYj6elfUnbZ/mmMhScRKvY+CtWl79XH6qCF/JW3MUJfFgpKYamPITF314TCjsrimks5JupxBIY7/QHsALMHiEk1g4uB+17LmPR6l0pFpQMewJ6GZz7MzifsDndner1+THVFMMpVh6eFhajAe70QEDnaESE/L5QDctPf9QGZzLFdcQWttu0TGVXsqru7nssoetKky4a2ut2OfC4VJGc/kgSb0BDSnplQa6+sY0+Klv3WZFywLJ+m6XdFDY5Zq0B3vHkiso1eNv0VF9IiGNIk5K4eS/TnIcNvg6qcPOPZvqnccHZ1hxylCpBnmM1iw2V1Jfh0ITcDoi4W00YEyCGzLcVsOsDkYCTrss081GOQGxBYYxBMzD5yzfGpSgMkZtXlxtsnLBsOD7NcpyOehqjcv7zp3P/fiqBbpUoBBPsOLpHxOgnb2HBUHucVGaLLbxR5SoHmITjlAbgUEgwD92chguFmzyDhjo68zAXpffrqApQBLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(186009)(451199024)(1800799009)(36756003)(86362001)(31696002)(31686004)(8936002)(5660300002)(4326008)(8676002)(83380400001)(36916002)(2906002)(41300700001)(6666004)(6506007)(6486002)(53546011)(26005)(2616005)(44832011)(6512007)(66946007)(316002)(478600001)(54906003)(38100700002)(66476007)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lWcTBsT3JQdk5XYU1kU01XaEFZT2V4SzhuSDRFZ01XdWJ0Y3UzUlZDMDB4?=
 =?utf-8?B?WDdiVmhVeXNuQW5uZGhBMXlTUDZlOHQvWUtKM3M2OXJnOUtWSm9UN3pNVFRN?=
 =?utf-8?B?RFMwdWRIRDJHUG5vR0VDRjNhd3hYUURkcy8zcWhHSmFTbzlsOVJzUDZ1RjZn?=
 =?utf-8?B?OFpsOHFaNkNKMEtzZ0JSL0xzSXpuOE9VT3NZS2JPaEUzV3FLekR1YlRuMGZS?=
 =?utf-8?B?RjRZdkVaaWkvb2Z4WFV2VE5rOVJ0UEl4SlcrVEExbFJldGtOMzdmditTM2k0?=
 =?utf-8?B?ZWdLZWZ1MnBvYVpsWXJXTExtbFBQanljRHJXS2dmYmw2NDJhVm4xSkJMTkl1?=
 =?utf-8?B?S2hBY1BzOWRhRU11RFBLcWQxUU5SUVV5VEEvUStJRjJENExjNW94SU5KTTIw?=
 =?utf-8?B?V0VYVUpOWFlqaWl0bktvTzhrNG13UCtTSWhmYmZmeGRqUmJ6MnRiS3hRbmpQ?=
 =?utf-8?B?WVYzdUgxeTZkZ1lrNVo4UTNDcWhOYlh0c3NaRTdTM1haZTV2R1BHNklmSEZV?=
 =?utf-8?B?NHpTNk90bUhnL2hGMjhBY2lMeFhjZXFmRjlpdzBLOG1maGNjb0V3M0MyUTN0?=
 =?utf-8?B?RUtweW1kVmV0UW5HbklvTnZMcStaMjVRYURveDg5MjI2Qy9OZkpSVW5DRVQv?=
 =?utf-8?B?bnV6K1habHFzNWVJK3BFbEpmcEdVTjZ2cWdvc2U4NTkvSEtpTHBVSWJLa0pL?=
 =?utf-8?B?eWMrMHJRam03QmhSWVpFQTVJVFovSlZJWUpZVHQ2Zm4rb1ZpblRqOXloQUxT?=
 =?utf-8?B?ZmZmbVFheVhjaENaUEhtUDdhaUl0TDYvdFZ5ZmtwNVZ6WWR4MlViSnFLQ1Br?=
 =?utf-8?B?NGszMlZvTWlzSEwvczZlTG8wdG9hNmc1M0p3R2JBN2NrYTVRd1B1eUVUM1lk?=
 =?utf-8?B?TEpnK0huU0ZjWUl1NkZ0RExrWWVTOXVtdzJBeW9XNmhpZkppRmhlUU9tVXB5?=
 =?utf-8?B?ZXpFczl6b2xLYWM3TE92ZEp5d1V6UkhxQTRsODE4YThES1JOQmFjYlZtL2cy?=
 =?utf-8?B?KzQ1UkRTeTBvVmFFSTRPN2dJWTd0NU8xeEZxRzRucEFBV3hFR2hSdFNCNTZB?=
 =?utf-8?B?WVRKRUU3U0JkOGxYOEs2YVpRRERRNktnNVRqSXJoU3pYdW5pakZkek9OY2Vu?=
 =?utf-8?B?WC9DL0V5WldYdUxtL04vRWZtaWNWSkdWRWJUTE1ad3YrYkdKc05jZXhzd09z?=
 =?utf-8?B?TE1IRXN1dzdvTXVjaFV6UEpJZnRHQUY5S21UcVUveUhLSGxnVDF5KzFKY3gy?=
 =?utf-8?B?b0xITUV6VW95azF1UmRBVWFEQXduVHZwOHNLeVdYNW0yUEpReGUyc1VOOGl1?=
 =?utf-8?B?bXNmQXNUYjlVTVkxTGQ1OTFjYVB3K1dTbTZEdFpvUE85YWgwaFZUZklYUS9T?=
 =?utf-8?B?MmUzVHUzQS9BeTlHRnViMGZPYnRvOEtYUnJodkxrYmVLK2daTHUxTmdraFRu?=
 =?utf-8?B?S1FwdVNmcC9TcTF5NzMvMWtuZXRLRlR5bU52a2VNbXdiTXAxOFY1UEpSbEl6?=
 =?utf-8?B?cHZjQXZhZUxBTVRyQzM4QmI3WGRBK3FPN1VEUFhQWnRKMDl2dHkyQUsraXRP?=
 =?utf-8?B?RVNPa2hvTVp5K295QUtsT0hnVTY4dlRBeXRZSm54NFg4djU3aWxRQ3VXV1Iz?=
 =?utf-8?B?WjB2OGFlcUZhN2cxMnBYVC9yNWZmMUkrbkl0T2xQd29WNC93M2p4SGw2OGFq?=
 =?utf-8?B?NVlDWWM2Vyt5cVdWTFJ3RjVpMFNiSVMxdWZiNkd0TFFNYm05MkdQNEo3a3RP?=
 =?utf-8?B?TExJS3JFZXllR0toZm1WNzdISVpCNkp1a1c5cXBjd0hHOTRtbHg3NUY3T1V4?=
 =?utf-8?B?cDRPTnphejM5WUZNTk5SaSs2UXcwc2VDTVAxUFd3UzJ3QjN1bW5pcG1vcTd3?=
 =?utf-8?B?b3NTblBqNzR3RXptMnJkU09lRXl1aFQ3RC9ZeW1kd0Q4NmpOSTJ3YmpDY0Ev?=
 =?utf-8?B?TVdYcTlIVE9IZ0M3MEtBZW5HUWZPQ3NUY3M3ZUpFVnl1SWdIeXZzdC81VDQ0?=
 =?utf-8?B?Zm5iZmR4dTd6OVo4cUNNb3EzNjZZajNOQXZiUkZqQjBnemVnNVhNbG54ejBr?=
 =?utf-8?B?cjF1VlFQcC85SHp2SnFWUjJldldOajM2RTdWUE5VY1dHV0pwRzdzOW5pMFJa?=
 =?utf-8?Q?qUEHSm1yl1TpvAObTgV8H2KYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b635d097-6df3-4f27-8806-08db9f5d5370
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 20:05:38.5357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZoYjXcH29Oa37630OiTUaAteZklzQFs4Fq1y2eFJRbFzo/LiMJ91sHB6P86480nO+Z7h/Jp8GSRg3ZzIf/Zkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Leo Liu <leo.liiu@amd.com>, Haijun Chang <HaiJun.Chang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-17 07:08, Horace Chen wrote:
> [What]
> Current SRIOV still using adev->clock.default_XX which gets from
> atomfirmware. But these fields are abandoned in atomfirmware long ago.
> Which may cause function to return a 0 value.
>
> [How]
> We don't need to check whether SR-IOV. For SR-IOV one-vf-mode,
> pm is enabled and VF is able to read dpm clock
> from pmfw, so we can use dpm clock interface directly. For
> multi-VF mode, VF pm is disabled, so driver can just react as pm
> disabled. One-vf-mode is introduced from GFX9 so it shall not have
> any backward compatibility issue.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index df633e9ce920..cdf6087706aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -442,9 +442,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>   			mem_info->local_mem_size_public,
>   			mem_info->local_mem_size_private);
>   
> -	if (amdgpu_sriov_vf(adev))
> -		mem_info->mem_clk_max = adev->clock.default_mclk / 100;
> -	else if (adev->pm.dpm_enabled) {
> +	if (adev->pm.dpm_enabled) {
>   		if (amdgpu_emu_mode == 1)
>   			mem_info->mem_clk_max = 0;
>   		else
> @@ -463,9 +461,7 @@ uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev)
>   uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
>   {
>   	/* the sclk is in quantas of 10kHz */
> -	if (amdgpu_sriov_vf(adev))
> -		return adev->clock.default_sclk / 100;
> -	else if (adev->pm.dpm_enabled)
> +	if (adev->pm.dpm_enabled)
>   		return amdgpu_dpm_get_sclk(adev, false) / 100;
>   	else
>   		return 100;
