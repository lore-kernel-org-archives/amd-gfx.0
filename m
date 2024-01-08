Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67C1C3DA6E
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 11:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E9910E224;
	Mon,  8 Jan 2024 11:09:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C36E10E224
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 11:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZH+oZTwGonplvppaSzT0BWEcOH75CFwRV5woLMVKmeAlTMnWVgUIB3o9INUpO0B+6g15rM9OzFc7AmG4qw7ClXTZ/suXvdAl4zHXVk2fFaq+dt9nEuPS50kROozgI7NnRZ5iHXcPX1IUCZEGhyhSFwl5XsXQQdgqRAJawxRGRLwaOZHhZIGCUUgfS/zBD0TZl/Ds6o3eq92OJgRc3peRYxSc4LABA/6lNRQQhQ36iQ4IZQQ21w5zzNGRwqoq5daUD/msRi+ikM/+alOPKmzO/8IJ5v0HjAaFuymNTADR2nB7iv0LByOh2WCmTm0F6jTE1huCzhCMd3TKL1HQuJIZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA5WL97NEnz7s10fogMr+SiiX85OYFl78NkiUSetpzk=;
 b=WFyTVxyFxYKvfXTF3aEh4abk+w/xO3adWMFFQkijXhgKkIjr1cqaHFRC52JBVikFIAMHdxfLoaBNGT4iCcvWXqvy6qD1ELIczI29Xn8WL5cmbdhi5CNqdi69VWeOTzLOowWzvqGqYcen+w/pFhglgPRBfGuCPeYcaNn4aHrhTrwpqwmzEyN3M5y5K5JF2WsivynuQ6z6tCnjx8eCr+cxcrVsPps12c9WzJXty0ivJVxA1jubEdOzDBJosobeozpLeLnBd5CIBYQxdQYubn2Sq2uxsAdCcVMwGmQRIWis6mDmr2l9hTsb1AO9jWcBan+77efqnCZ/1AbbtvUgjE/d2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA5WL97NEnz7s10fogMr+SiiX85OYFl78NkiUSetpzk=;
 b=3/oVZciCtvTUsas7ftmVjvbg9K807IIE+cHmY4LzxiuSeJdmzLHQ7fUXsTkyRkkzqw9J92wEh3pNLf3y+CRuuAUOuKvU5KV5CQCyIJtEzerMmej3HlY2AACZtSThSrwnvlkrmy3H7rGgT2QKIBk4AJ3/uo67XmL/xDap6Fex4EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 11:09:54 +0000
Received: from SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635]) by SA3PR12MB7808.namprd12.prod.outlook.com
 ([fe80::9ca0:c2c:c5b3:5635%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 11:09:54 +0000
Message-ID: <f567e4c3-5b25-4f67-b044-5afb45bc4c12@amd.com>
Date: Mon, 8 Jan 2024 16:39:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "drm/amdgpu: Update irq disable flow during unload"
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com
References: <20240108105752.482885-1-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240108105752.482885-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::6) To SA3PR12MB7808.namprd12.prod.outlook.com
 (2603:10b6:806:31b::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7808:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c66f44-54f2-481c-323d-08dc103a5717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2y297ufy3nXjGI+gw14gM7pyaTehlA0RBrDRGPh/lUoBiiPRhl/KDAKpql0meXovTEJk5B2VqFp9wv6QCFoypF7+0yA68YPNhsQKrQEIYONGTEqec80t63Dr+zyemjuc0x7fMhvbWU/s2OcBDBB1VZq/taRVyqeTfJmIcJvG6n8rg5BH256jlPMyAjYBOlKUPUaRT6fTPY45akgKWSiuf7DZXhHfR4JxKXANunXOzQVfSkmxhNQSRUmzGr+0hskz4KF5VARwaH/BO+aT2AAmUFP1dDJvO68vdLCerwulVm4OonHp9JGteTAApzcloUdJKXJ1rPHmgthOMFSjLHNjlbs1PFvzak1bvOyMqgMHuxHfItAR0U804xdurIXeTWLgCzqW0mnpuckQo5e4Waa7YbwJZO+p7CwA/RWfSvqmLApBJQvql6+bS9HltYXUOvlOgCWfjmcE60kZY/7KAHuZfsI3RrYl6ALOC8SoCmXIwGA2isOjkh13P/fX9RxxUGiLmeh9Tjn9eCz3s/RJ2XxGZdVUkDhjLQAnYJZ4iSZG53NLnd+wiaaQzOiE8dsMXtHbrvcEi3p3svYg0hVeyIa7u0I8c84dFX8NlVx+Ws/6JhtHkHszFvemYp+5UmUzs80J4EfBTfaOjqrid79u1xTlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7808.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(36756003)(8936002)(8676002)(6636002)(316002)(5660300002)(15650500001)(4326008)(83380400001)(478600001)(6506007)(53546011)(6512007)(26005)(66946007)(66556008)(66476007)(6486002)(2616005)(41300700001)(38100700002)(2906002)(31686004)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amVyRnB3ZlRWU3NhN3pzZjNaa1FzSldmZ2h5RENKNXJ0YVJqRXdvcHVwRHhi?=
 =?utf-8?B?R0NwMjhUOVNUMWF0QXhLaTlzMFNzTXQzTDN2c1U3Z3dXa250dVg3dWliNStu?=
 =?utf-8?B?L3dNQ1VXNEZnTjVzQU5mSVF6UFVmQXRML05aZTcvZGJHU0dJZmJteHg0Y2pG?=
 =?utf-8?B?SjNveGErOGptM2FjT1ltdjY1Z0ZBWi82bmppMG1ocFBhNlNLN2ZzL3g5RlZ3?=
 =?utf-8?B?TlM4U1pDM2NwSjkzdUZ2eUk5ZkM0ZDIxZmx4RmVwdE50bEFwTW1rMTJ0WDRC?=
 =?utf-8?B?QXdzQUNwMmZ3MEFzWjJEUElySVYrYzlBYnBHSC9QYy8yNGN2bkZTQlhBZ1Jy?=
 =?utf-8?B?K2pUWXJCRFlFd29nY29pUlcra1ZRbEdudzBEZFBIYnlHT1hVa2ZyWFRjTCtm?=
 =?utf-8?B?V2NCeG1QUlQ5M2JpVWVnN0Q5ZFNKVktvbXl5ZmxTamE3eUtRRGJFS0RzN25J?=
 =?utf-8?B?b2ZMOC9CZUZxciswUlRwQWgrTVRwU1ZzamlMUWsyOUdRUzFvWjBiRFFFZUVQ?=
 =?utf-8?B?aVRzc0Eya3BQZ21SZy9wSkhyNENFM3U1OHcydERpSm1RK3RtQ2tQaHo0alZj?=
 =?utf-8?B?bkpQWWl5R3RvN3c4SnFOOGF1ZG56VGZyL3dmQ1hIUlpNZDdLYnlGMnZ1SHpW?=
 =?utf-8?B?VVRURG50RFNCL0hVRXg2ZVpsOG04MXVYZ1JCUXpXZmhXZVJTQVJjTWNwejN5?=
 =?utf-8?B?K1kvelF2Ti9OdmpaSFJ5cVBFZGFQRG9CTjNGL3FacjVEUkNYQVJyc3ZiYlpn?=
 =?utf-8?B?VzZ1bDJzOE0yN3lCaGVWWlVvZzVRb3Iyc3JsamdkbmJHS2doTEFKd3F5K0o5?=
 =?utf-8?B?UERPMWNMdVdacTZSUlhYTVBkRTZycGJWT25hK0xheGs3N2l3UHlURUdoOGVH?=
 =?utf-8?B?UTJoUy9CQTREUno1QnZWMDJUUFhRemhhem5ZZ3dTVGRLU214RmpQU0Z5TlJT?=
 =?utf-8?B?Nm9SdEthclR0L1I5VHdETEZYWjdCN0ZtTXdvRmRwZmthU3MveGlGeFM3aTVi?=
 =?utf-8?B?ckRVNC9pdER2MXFoRkVlZ1p1K3h3ZzdJS0ZqeDBjK3UzT2pkOUVTUkNtQm9n?=
 =?utf-8?B?NXVGK3Y2MS9BMlpxWENEeXg5MzhCa3JxdjErM3NjSDh2REpQMjdSSzRnQi96?=
 =?utf-8?B?V0ttQm8raE5OY0lOOXN4OWUxRkUwT1Bwc0k5aWFwRFgwTUw1Tnc3NTBUV2Nz?=
 =?utf-8?B?Nkl1aDFtRHhzZFJrcmhMaG42Qm54UmJiaW1oaXdORFZRcVcrMFdYOU9UMzBp?=
 =?utf-8?B?amNQS1Voa2F3SVl5WnZIMnlrNkpJR2cxSzMrYndMaTFzUHRmUDBqbEF6YUN6?=
 =?utf-8?B?K0VXVXJHV0ozYW5NVUxvaHN3c21pME9UWjIvdUhZMU16V01xR200NWpZdnIy?=
 =?utf-8?B?VkpObDljM0VyczJnbUZ5ZkRJM3R1TUl6ZWM5R0V4VTJpK3VEVjNBK0tzQXBM?=
 =?utf-8?B?TmFTT29UMmxTMEs5RlVrTndsM01jR1oxQzBBazZVNGcvM2V1L0g2YXBDR0pM?=
 =?utf-8?B?M0RIWmlRY3JjUmNTWUVLdmN3ZHE3TzdGR3hEc1JWUE9MRG8yYmZ6WlY0UTZp?=
 =?utf-8?B?Q3Y2QVVDNzJyeTUyRzJadEN4R3M3cUJPOFlCaVdPZXdHam9LaCt3OEV6TmFR?=
 =?utf-8?B?R05VKy9MRFVvSmluWXgzSXZzd3VyMi9jNkFMM0h4UkMzeTRxSjEyWTYrelFD?=
 =?utf-8?B?T3JzZU9RZ3B3Zi9kelB1MzdBVzNRN1NCTCt0Qk56ZmdSWFpiSllMUkhlOGpW?=
 =?utf-8?B?OGRvaUg3eHRzbUV6dlFmQTNPcnd0YUNBcHNIbGRtR3hJaDR2VGtncUJuWTdW?=
 =?utf-8?B?ZmpFRlc4MVFVNE53MkN6OWxPZmlWL0wzR2FiK0EzclpybmNxRGJ6K3BsV3Bx?=
 =?utf-8?B?Y003Wm9JS1k2c0dkMXR4SGdid2c5N2dVN0VWSjN1RmpxOTA3V2pxY3IrR29V?=
 =?utf-8?B?UTQ2US9MNVZjbnFmSFR0bzlSYmltaHdPcGFqUS9NN0swODhUanJqZDJ1Wnlk?=
 =?utf-8?B?elNRV1k1SzI3K1dNMHFmYUxKeS9mT0JlM24yME50b014UGpxSlg3TWpEbXpF?=
 =?utf-8?B?U25YZ3MyWXU0Q3Y3MVd1b1FPREtTRlpHNGRKTXlhVGVOdWZqT3kyM3dWZmk0?=
 =?utf-8?Q?cBebnV15SwhahL70fDZLJC+hP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c66f44-54f2-481c-323d-08dc103a5717
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7808.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:09:53.9335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7eH7+4L0XiraDn+SB+ScLiKtv8KdsD15gdK2d+JFHS1jBzIRCEF6RmU09wvG9wU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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
Cc: le.ma@amd.com, shiwu.zhang@amd.com, ckoenig.leichtzumerken@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/8/2024 4:27 PM, Asad Kamal wrote:
> Re-evaluate the original workaround: commit f5c7e7797060 ("drm/amdgpu:
> Adjust removal control flow for smu v13_0_2")
> 
> This reverts commit 2e8e792e6a51e8cb7f5f96148146b6525dbb9cef.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

You may reword the commmit message as 'revert the commit and re-evaluate 
the original workaround'

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 12 ++----------
>   drivers/gpu/drm/amd/amdgpu/soc15.c    | 13 ++-----------
>   2 files changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index c8a3ef71d6ad..f9039d64ff2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -2361,7 +2361,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   static int gmc_v9_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	bool irq_release = true;
>   
>   	gmc_v9_0_gart_disable(adev);
>   
> @@ -2379,16 +2378,9 @@ static int gmc_v9_0_hw_fini(void *handle)
>   	if (adev->mmhub.funcs->update_power_gating)
>   		adev->mmhub.funcs->update_power_gating(adev, false);
>   
> -	if (adev->shutdown)
> -		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.vm_fault, 0);
> +	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
>   
> -	if (irq_release)
> -		amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
> -
> -	if (adev->shutdown)
> -		irq_release = amdgpu_irq_enabled(adev, &adev->gmc.ecc_irq, 0);
> -
> -	if (adev->gmc.ecc_irq.funcs && irq_release &&
> +	if (adev->gmc.ecc_irq.funcs &&
>   		amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__UMC))
>   		amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 7ee835049d57..15033efec2ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1266,7 +1266,6 @@ static int soc15_common_hw_init(void *handle)
>   static int soc15_common_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -	bool irq_release = true;
>   
>   	/* Disable the doorbell aperture and selfring doorbell aperture
>   	 * separately in hw_fini because soc15_enable_doorbell_aperture
> @@ -1281,18 +1280,10 @@ static int soc15_common_hw_fini(void *handle)
>   
>   	if (adev->nbio.ras_if &&
>   	    amdgpu_ras_is_supported(adev, adev->nbio.ras_if->block)) {
> -		if (adev->shutdown)
> -			irq_release = amdgpu_irq_enabled(adev, &adev->nbio.ras_controller_irq, 0);
> -
> -		if (adev->nbio.ras && irq_release &&
> +		if (adev->nbio.ras &&
>   		    adev->nbio.ras->init_ras_controller_interrupt)
>   			amdgpu_irq_put(adev, &adev->nbio.ras_controller_irq, 0);
> -
> -		if (adev->shutdown)
> -			irq_release = amdgpu_irq_enabled(adev,
> -					&adev->nbio.ras_err_event_athub_irq, 0);
> -
> -		if (adev->nbio.ras && irq_release &&
> +		if (adev->nbio.ras &&
>   		    adev->nbio.ras->init_ras_err_event_athub_interrupt)
>   			amdgpu_irq_put(adev, &adev->nbio.ras_err_event_athub_irq, 0);
>   	}

