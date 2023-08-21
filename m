Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D87EE49AA
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Aug 2023 11:23:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A2210E04C;
	Mon, 21 Aug 2023 11:23:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E2F710E04C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Aug 2023 11:23:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ8dp9F170i3Z3SNh60AAQhD9qrmo3EZSUrhBWiAV8EKLZaCMd+ZyClOHr8sm/GAihfrA7Jy/qjhu1JRSREO0EHzkdBjxFpBJYo6AWHmkZw3+d/u9fNQbCXkxa81IYHrR2Wmn4nMxIuv4SgeGtUZ5be5O+77C9T0iciRJgu1jpw6OvP2SifCajDDLxa3wfkc1h4myhxUASubGiCAkPFL15k+MRr6zkh+hDLf5b4fokxWL5xfKBkrNnswnOBzms/B1dJm6kXSvWxivsnYiXxJ7yNHITh1udXya4xpTNVrkPB+E4Z7cxizLZjBqlRPsolv6MFvr3Y5buq2vA4UHDsS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8PU+TEyAQkNfGhB2MuWPrkGcsp1IuCcabZ1vr12I68=;
 b=agb97V9awKaXuIOlqLP1Iju39u1sxaXSeGv3cyOUPAF5EmzsH7Kwiqw+9ZWFz8oXoORLhcIDPEW0jjtPvViiiPJvCUZwKsQ2lYAllbYeUu+wwjuYyzpEVr0a1O2eHSomzYD74otHpWCfErV1mBSl5d/32IekzEmyYk1ZeZkO1slEbB8q8BVOG4G11iAz463qxojf4iW/VlZCdoAyY/hRMT0Z3H9AesuBw1XNNAdWrtrdfgvXxacGxryswZLhiQPEervWxCrgyJlI7Yx23GgvragoJH1O2EQzWOFtnEuPFlutVYpvP3BKwZPCLtqAQoFy2B2GEqN8CHJgaKZB0LqH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8PU+TEyAQkNfGhB2MuWPrkGcsp1IuCcabZ1vr12I68=;
 b=zbCyzCuJzihO29+D/qMbo+g7mGN3pt0pB/hmyiJYrBnWN3imWZTXKGuN6dcODc/FYM0JGFlP5FQXKXv1FAY8qgikWvz+beJvGCLNUh1e57pHegB0L7pfOuT5IX1/tB6M0QFjiv91tCPsvKvFE7I1WeGz/ueTRgIdaa/yasopCjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:23:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::3d:c14:667a:1c81%4]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 11:23:43 +0000
Message-ID: <8210ebe4-b637-5aaf-c548-b2a4be718f98@amd.com>
Date: Mon, 21 Aug 2023 13:23:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdgpu: Use READ_ONCE() when reading the values in
 'sdma_v4_4_2_ring_get_rptr'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230804054641.3250542-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230804054641.3250542-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL1PR12MB5128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8702bd92-6df8-41f3-7866-08dba239139c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs2FbQC+4Y8N52RSk08zKy84L31WGDcoBeLmLmWNZX/S7RklK/xXT/Qr+7mYZdNURCFtLxfCWwXLn+mOp5QhdvEUeTceclOlx1zpUai5UUa+vxez43ENwwfb9MFTHvSFARoxL2oYqmg42+YBCBJne1UH++R+i40B5x86qURKvhzfpfuP7wCsu+HqEMrtWTo5dZdclLFOAwvJCeF3XJiXUO/JdRd+FLxGWSxcFqJy9kopvi5RDRs4CGq+hkg25C36cOSdJUXI5wbcx0d5bFeKpAR+jH/Ra9mYyxk5EiWUhFIWQXV2ZMPBRefYF68NEZ09mEHwvn9zjUiC9gkrE5t7Z9d3y/RWAyb4hjlarvW1xdI7k/AXr6/9egbomyvpEmMb7y1VuyCubGAQHUi5FIWLWuxb601W569CrEGMLgzeToOBkQYH1POeSsKiKIgJLrQH8Xjd68fe4nKsowuliO32JUKCoTya9301kou1kKelRBgxU8rCyHQHDspjM4IMSG/GMHT/MW/dAzHwR/eati0+VbjMAQMjewm4mkjQkT8EjBV3zfQFHtE62OmwTAcoeab8OzGC5hs/EMS3EswNwRa7SDe41W5nOOZJoIPA4mXk+aGEicolljpYhG1gZQec6+/JDoxsW7I/ilPTcMZuoaUcGg1Q7pXlHEbz9bmW0o+DKWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(66574015)(2906002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(6636002)(66556008)(66476007)(110136005)(478600001)(6666004)(36756003)(41300700001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUY5SUpGNVBWYWUzdjBkYkFCbnNNTjFxU2JGcVM2Sm1YbjRjclI2Nk5BRjVL?=
 =?utf-8?B?MzkwTUJFcExmUk83ZmI4dVYyWmQyWG14eEZ5aW9KYjFQMzZJcXZLN1VIV1BL?=
 =?utf-8?B?L3ZBbzNKYVNTRlArbkc5Ty95RnNnRlVTelpTeFpBMzZQeVU4N3VZbEVzNFRK?=
 =?utf-8?B?bkV5Zzkxd1hrS1E2V3Z2YzJpUHBqaTJuNEVnUzV1M3BlNXJQVW9Ca0NJRk0z?=
 =?utf-8?B?RnJnT1UvdU5iZ3pHQ1N2ZlIwYngwZVBtdEhUNDZrbWErTEU5WnFhMVJLNFFp?=
 =?utf-8?B?a29DOTRXUzAya2ZNUzIyamg1bE9ZTDFpS2VwcFlVSnIvWXVvZ1RxR2IwWTdF?=
 =?utf-8?B?d3lYMTRjNVJ6UmtLUlN0cEVMZlVRbE9ocmNaWjh0VzROajRaenhkQkZtVjZN?=
 =?utf-8?B?M1V3Sm9BWkZiRVM5NFpWaC83cWE1MkhXY0I2NEJhdDd4Wnlma285eTNacDUz?=
 =?utf-8?B?N1BpOGdBdWdUZUI3R1g0RkRNVE5Wb2Z4bTN0TVRaU1NXNWxLMllHakNBekJi?=
 =?utf-8?B?UjJEdlNrazZ5VmZldjQ2RVd4bFpibkxhUitaVVhTU0pNWUc3OUM5NExKNG1S?=
 =?utf-8?B?RUlGOUtrVVpETHVZT2RjeE5aemttZ0puTys0UzJBK3pVd2JUNGZyM0tNMytn?=
 =?utf-8?B?SkYxT3FPL215UUJEZmRhcCtOeFRUVzhjWGFCUEREVGtnaHh1dUFmQW9jS0NT?=
 =?utf-8?B?dFVVcWdsNlVMMEo2WFJmczcrSFIyK0lhQkhadHBvWmZXUzZEL3hWNjRMR1lq?=
 =?utf-8?B?WWNaTFJXTFNQUmlPM0lnTVF1V0xEZmo3VlplWjdIL2ZSWnVIelBKSmx0L2ZU?=
 =?utf-8?B?WWduUXhRRUpRWDhseXUxU251THVsNFpiVURZRFBwZFhueS9sMFBZZ0NCN2d6?=
 =?utf-8?B?N0JiWjJWYXFrczJLeFdGQmthYWljZWR6dGlucmNYTi9iWmErUTd5S1hLaXJD?=
 =?utf-8?B?K2x3V2FudGdVbGFkazFQN3ZQWlpjcGRaME9jbTBpSlhvWldXL2s4cTNSSzh1?=
 =?utf-8?B?RWphcE1mMHNKTUNkZWtMaUdWdkt3azUyUGh4c1ZSYTJXeE15aG9QRVYzNk4y?=
 =?utf-8?B?bFQxTzM3dXdFZmlaaytJYnc2WnFQZHNzZ1d5bHVIMVlkdDRTb2RKME9rUmFU?=
 =?utf-8?B?MFBMMkw1Y0RGWDV5Tk5lWGFoR0VSbWhabGEwZUsrQURPWXphZXNOWUl5MitI?=
 =?utf-8?B?ZjRLUG9yM09lbkhndmZtTVFLRjV0bFJLNm1GY0Z4M2w1RlZhNFFiQ2ZaWE1I?=
 =?utf-8?B?MGJjVFJaMXRiUUswc2xlZzU3dVNsU2JDZ054N2V1R3RGWmpwKzZaQzhDdFNI?=
 =?utf-8?B?K0pkVkI2Q0pjWjM0MFdlTGplM2lLazZhLzVHNlRuZUJVWXB5QW8yZnkraWdH?=
 =?utf-8?B?SnRTUktSSGZ6ZCttSEtsbmNNVzZyVitkVkJ5QWxpNGdpdDdCQnU0djIvT21m?=
 =?utf-8?B?MWhJU1oybnIxTS9sTkJhZC9wRlNnSVVoVENzdVJMdWY1Ry9ERnJ6WG45OHUx?=
 =?utf-8?B?SnBMbHV1ODFDK0hIWDBzUnlCWEZKM2V4VkMvNC90TUtuSUgySTFUTHVnWUN6?=
 =?utf-8?B?cUc4akRJbmRxdlR3N09EbWVOelR0Wm5uSkVndnFrK0FXMldUTFIzemRVWWlK?=
 =?utf-8?B?eTNua0IxTkxxQ09wNGY0QS9DNnM4Rmtib05QRmk4aFBNQk9CRUo3Wm53c2VW?=
 =?utf-8?B?elVFS3g3bGVJcVIxTkRlTlB5VDBhUW5mYjJmRVQ4SUxzWk1MekRpc25BR1Vp?=
 =?utf-8?B?bFdLd3QyM3VhNXVTREdsUDVNeENDelNGOFF4OWVXa2M5K3o0Z3F3U1BLZk83?=
 =?utf-8?B?T3gxY3VFYlVGTzZZNGUxa1ZLWTRxRGpPRU1QUTM1dXVsMERDUHJCbjFUbm5R?=
 =?utf-8?B?cTN2VU5vVWVSSU1iOHJKR0NsVWlxdFltMENQc05GUVE3ZjEvbnA4bnF3aUZO?=
 =?utf-8?B?R09Gd21oV3Q3Nnc4bkplZGU0ZEVDQjNRMkhxaFlqNFVpaVhBWTYvMWd6N2xB?=
 =?utf-8?B?dHVzOFlsUkpsS2dLMFZQSGtWbnBLcjAwcmE2NUtyaHpoMTJ2RzBObENCYjh1?=
 =?utf-8?B?REdteXpGY1RGeVN4R1AwQjUxd09XZzJTeXJiemNveDdWTWo4TDdlSGlBVFBM?=
 =?utf-8?Q?f7Nrrbkaij7mgRQTzWStn9u87?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8702bd92-6df8-41f3-7866-08dba239139c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:23:43.0748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTSLYVmvToewz5JMlNjagjj9zsD5/YV6RPkIICAEFmbcMwCPmKfqV1qZUFlXO1vh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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
Cc: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.08.23 um 07:46 schrieb Srinivasan Shanmugam:
> Instead of declaring pointers use READ_ONCE(), when accessing those
> values to make sure that the compiler doesn't voilate any cache
> coherences

That commit message is a bit confusing and not 100% technically correct.

The compiler is not causing any cache coherency issues, but potentially 
re-ordering things or reading the value multiple times.

Just write something like "Use READ_ONCE() instead of declaring the 
pointer volatile.". The background explanation would exceed the 
information suitable for a commit message anyway.

Apart from that looks good to me,
Christian.

>
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Le Ma <le.ma@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index f413898dda37..267c1b7b8dcd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -154,13 +154,13 @@ static int sdma_v4_4_2_init_microcode(struct amdgpu_device *adev)
>    */
>   static uint64_t sdma_v4_4_2_ring_get_rptr(struct amdgpu_ring *ring)
>   {
> -	u64 *rptr;
> +	u64 rptr;
>   
>   	/* XXX check if swapping is necessary on BE */
> -	rptr = ((u64 *)&ring->adev->wb.wb[ring->rptr_offs]);
> +	rptr = READ_ONCE(*((u64 *)&ring->adev->wb.wb[ring->rptr_offs]));
>   
> -	DRM_DEBUG("rptr before shift == 0x%016llx\n", *rptr);
> -	return ((*rptr) >> 2);
> +	DRM_DEBUG("rptr before shift == 0x%016llx\n", rptr);
> +	return rptr >> 2;
>   }
>   
>   /**

