Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 08:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE5710F653;
	Fri, 17 Dec 2021 08:49:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136A110F653
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 08:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxmneRe8YXV/4FTqtbSApmZ9aX8OvE115Uxg+F9Qy7HwSFDaSQVGcZ2DpNCxyJ4wcPWrnRqN9peBxjVyH7Fsu5ChFCBhX+fCU1wAJaxVMrxHClJdP117ydFJj0MV3iRepco3MbPF/qmYv6BUHdtbYpj4zdn+R2OLkjG8siVIm30Jt3vNHsMV0N2BaJDStudbwggwYPXSfZOgozRg1SXJ6uY2/iU9dx5uiueJCIZpAix9IYeruGp+f93xfVgd7rORqZUcTGZsiGqyH5FeDFX1Z9Au4bHwHL4l0SYHZV7YBIuGwd7EPqkcVUoX+Rq5wlSRWqIkfbANnqNuzhK5++5oYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiqQDad446/3s7uIld0rrKny6lb3PgJS8U5hCAI2jSE=;
 b=krQo/p1bln6brt4eSVBYl7wXDkPxhkoxSpEEENguC+6Ojp2pWSG5foG7mLYlpaCwvysX/r9a8V70qsdyo6AQpwZKYPp74/0sSCp8ymTqnNk/SykBIleCYp+Bsb0R9zWlorTUC3EETNjTGrVEQ27qTz3qbpylax/LwcqV7AMigrFz6PpDm3qXEmhhaSntRSQjZEsB2T3OOs7w1fOCGaI4tNDAlG3egM1gEiGiKlu1dctgy+x5EcKcG7UaSK9BLMdOV8YXpQTKptUGnrMvxFRfbAG7BB5ZR3v5Vuqe3NVM/lBBkvK3S3NbVA8d6T/y4Armzas9YV0MFcvf3879iHtN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiqQDad446/3s7uIld0rrKny6lb3PgJS8U5hCAI2jSE=;
 b=oPWspJ6MfY4MnfzeHNPrpt6qLlSJwmxeWiL97wpoFLmLIg+Lp06D0MhP2VgFkTlnaTeDjN9YoutIwKUHwO1VCqEWG2LHpkqtJ0AQlxm+Ij1uvOcKSolXPBbFgKr2+zyb1Q9PUr6qI+0XxFgPWZ+NBgS1EtZVyl+FwDnKQol0Bis=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4410.namprd12.prod.outlook.com
 (2603:10b6:303:5b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 08:49:18 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::d16c:a6d5:5d2e:f9d4%12]) with mapi id 15.20.4801.016; Fri, 17 Dec
 2021 08:49:18 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Call amdgpu_device_unmap_mmio() if device
 is unplugged to prevent crash in GPU initialization failure
To: Leslie Shi <Yuliang.Shi@amd.com>, andrey.grodzovsky@amd.com,
 xinhui.pan@amd.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20211217022601.2995743-1-Yuliang.Shi@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b5b1e8f6-c7c6-b465-6d4b-75e7a709f4dd@amd.com>
Date: Fri, 17 Dec 2021 09:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211217022601.2995743-1-Yuliang.Shi@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6P193CA0091.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::32) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57a924b-dabb-4680-6e45-08d9c13a1c7b
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4410A6C7ABB83EA2C2719CC183789@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xTOFhRuF26eGUYyu5LZ51oELYDm6yQG+aFlrTp6xlskhqx+WIeiONcbXrhzONe1AphZQtlI8pRfNc1S74X4xRHHxFc1X6f6mRI7VTRrPwRC9Y6KcfkQu5dA6U+AhjTmyGzPpqbhIj4OXp4xb3uYD457Z+blq3dQAowdipvcZwQmDPEs1RPficXjdMyQksvYLC6gxO1rjxigMsbRnEuhxVZOBt0ykICNlONWhQ/Jqg5RUsa/4P0i4Mx7axR20mdFGvsAFeI1r7I5ETRZYX1dPQzRFa1fQ+S6lZDtfuM5WklnMRjGH2Mhn/yh400Jcu6Stmy41V+OASU1MqgVyOXdV06FtHV+xjykReuljYXD2HiLNuqHf8bSIdHGFMtvuNXwQeJ8X/hsSi6lXBUJPGWZJru1rATSXWeeVBwUCrmk49B/iTBy98pJsLaXb03BofPj0yZRJjEe+HKoMEuUY/UQBI5HY96GBBxTVhGZR15GYOyJHxQhfi57SO52pnNiSRTwKacbqTk+kEjoSfhcyLOP09MKKyorAq3s4cGbwA7O+O13E0FcySv4uo4nKTqCHKq6b9UohebiG6xxLn92uYLRWnU2NuQ/qIuplI5mNrkasJ3n6TPydGhcYovDov1QVp/IGZFblljHjO5ThPpV6P5k7tzDux8/Phr3zIp4j+Y3DRWU2dGakNNQxtA8uN7yifhFxcAQNaNZcQglmkS2OznxlF7oRA2/XU/03A0k5dMuaTEuc8sUtQuXoxhUQ4fVwWKD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(2616005)(5660300002)(6486002)(66556008)(66476007)(316002)(6512007)(186003)(66946007)(86362001)(83380400001)(8936002)(31686004)(66574015)(8676002)(36756003)(508600001)(2906002)(4326008)(6666004)(31696002)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVdESkJFcGRROXd5TXJNMU9ydldyL3lMTEg1Q0NLdXVlRWo1aDlIUEMwZk9j?=
 =?utf-8?B?RXJBWnFCdzV3MUV2WFEwaHNFS1RJbFU5RGYvalZYdUNyV1c3ekVoUUp2N2t0?=
 =?utf-8?B?NGcwcFVpaTJzMC9zY2pUQTFXOWcwMVIwUTY0aDdpejAxdVdBRnhVR2RMaXZF?=
 =?utf-8?B?ZzBzRlgwN3RCUWFqTHc2eUFDcDRnN3l4Vkl1Z2kvR3VISkY5VFZqWXRNRHJB?=
 =?utf-8?B?NjZ1dHhPM3VxY3p2M3hUV254QVJVaU1tWGNoZnlJODFFV2FzODV4dkNTY25X?=
 =?utf-8?B?eDhBR1FDVzh1T09rM3RjOVBTKzRKMUlJTUJSU0labzcwTXpGd0wyQXNudXNZ?=
 =?utf-8?B?ZkpKVisvcXdoaDdhOEd2MndHUGlWK3BvSGthVzdKSEV5SnFMWW9zZElMaElt?=
 =?utf-8?B?cDREa0sra0hBL0tRZFJLcDA4STAzdk56TWdobEZLcThIK0tmMytuOGVYUi8r?=
 =?utf-8?B?RGljU2xXelkwN0ZlelNxd3lxZUNITjMyeFBmQlJkTDlndjNmVnZzR0UrR2tH?=
 =?utf-8?B?UHh0eC9YNnpQNWRTWVkzRUFXWE5UUXU2Rm5CVE54VThLbEQ0N0ROUWJPSllO?=
 =?utf-8?B?MmJpb09rL2w3YmRMOWF5WGwyK3RWTGdFNVlHSEtGUzAzQ3ZZZzVIMnJyWFZ6?=
 =?utf-8?B?VzVzZStId1N5SHFVTll0MFVXTVJINUpKSDEvTm5uK2NNTittWnEyVTFwYlZP?=
 =?utf-8?B?YklQYkh4UTBpNnJyR3FNRnNyQjdHREg1Y0dVZWN2NzlpajF4QjRrYjZVSGc2?=
 =?utf-8?B?Yk9rTDBUR01JRkhsaFRWOVZJS3FVNmJJTGxzaWhIY3BLSHo5YWVTRGgza3Iy?=
 =?utf-8?B?VEZkNTl4Tjl4Y0k0SWpBY3g4dEhRSksrRG1qZlVMSks4dVB5T3RJbGNhdkNJ?=
 =?utf-8?B?WjF2dGpTR0o4QlJGVzBpeTh6TmlKSzNDYy9mSnpIbUx2L3hmQzQybkRFb2VD?=
 =?utf-8?B?R0xBWm1zU285dkFoT0xXYVYvSG41anZJeWxRTncxY3g0WVZaekFuZEsxTkp2?=
 =?utf-8?B?YlMzM1ZKekUzOHZIUkhURGpnWVIrdW9kRkNDMzF6aU8wYlhHYmIzT0cyb29H?=
 =?utf-8?B?YXhhdWhkMnZ1YjNsQ2k3dzBtREZCcGxudnY2bGJjZzc2NUtQN3l2ZFJHQnBK?=
 =?utf-8?B?MkNVV3BkcmZZU3NLYWVDSGo5NzJGMk5maWZ3RENzSERRUGR0QUZ3emg1Qjhh?=
 =?utf-8?B?Q2UwOEpwWmhheVJGRnQ4ZXRQL0VKUktZRW9Ianhpdi9udkNnMytEODVUTlg0?=
 =?utf-8?B?N05KaWdydUMyL0ROQWwycG0wNEFpbnJneFBLSUpXY0VuQVFZVEJhQ0lkZEtT?=
 =?utf-8?B?QVc5eUN0SnlzQTEyN2Y2dVMvMi9BUmN3QnB5SjZLS2hES01XL2w2eksxTFdy?=
 =?utf-8?B?VkNtREJNRUZSa3Y1YUFFQmxtWlhRRUhhTHJiOUd3dlVwd3U1Z3pMMGo5ZXJr?=
 =?utf-8?B?QVpFUFh1SlNUK0R4elVhcTd0WVJZUkszVVdpYm5QUld4dWI2OGhFeHBjTk9y?=
 =?utf-8?B?V081cjZ6ZUJPK0ViVmJHUXdTTjNDUWxJdG9BRVRJbFRnVmh5OHFJR1RxNEpQ?=
 =?utf-8?B?bVJ4M2YybEptT1Q5RVpUa1l6QUJubU1MVkQ5cFR0UVNlQXdJWE5XMTRkVkN0?=
 =?utf-8?B?b3N0T05HL2orOW5JNTBhL3haVHdWSGJwamhJRFFZMTBXeTIyY0lJVnBoQ0R2?=
 =?utf-8?B?djVFUGMzTXRSbjBUQVZEV2N4NGNpQnpsekg1WmlLZm1qRzdBSGpDbUR2Ly92?=
 =?utf-8?B?QkRRUnVpcHZNN01XUDVxcDdVZzR4VEl4YnMwWjJTTEo0eGU4TEVRU3FBUDBw?=
 =?utf-8?B?VVA4TzlqWGY1ZUduUUV3VUpsTWNYb3V3U05UbENNYXlHMExMd3o1TGNibmdh?=
 =?utf-8?B?dWxVbFgvYkwyV1FDY283dVE5NUlhR2UxcEltMkZSVHBCK0taUmQrckRKNC90?=
 =?utf-8?B?R2JCcUFhNHdsUTA4WXhIbEtVTWVVWDVRMmFSQmhUQThPL0paMXV0TnIrYmdr?=
 =?utf-8?B?a0hyNWRWeG95ci95TTVvS2oxcDF5eml3WFFObDJwZVBBdHFmQ3Fka3d3Z2kz?=
 =?utf-8?B?OHk0MFJpV2RKMTJ4anRCSGVYcHBEdll2STNVNFlUVmg1US9rMXBaVGliYWdv?=
 =?utf-8?B?QitudHl1aVZCSndXclhWbG42QVpyYzVpLzUyZDd1dndpcjlqdTlXQWJCMXgx?=
 =?utf-8?Q?yjqST6XBzX1WrbOCAs72RfU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57a924b-dabb-4680-6e45-08d9c13a1c7b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 08:49:18.1270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mviWXLR3A2tM5X7WV/oOj72s1m4fjQKFyhcN7UXNo7RDbslVjQT9QRdOPg8eomao
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.12.21 um 03:26 schrieb Leslie Shi:
> [Why]
> In amdgpu_driver_load_kms, when amdgpu_device_init returns error during driver modprobe, it
> will start the error handle path immediately and call into amdgpu_device_unmap_mmio as well
> to release mapped VRAM. However, in the following release callback, driver stills visits the
> unmapped memory like vcn.inst[i].fw_shared_cpu_addr in vcn_v3_0_sw_fini. So a kernel crash occurs.
>
> [How]
> call amdgpu_device_unmap_mmio() if device is unplugged to prevent invalid memory address in
> vcn_v3_0_sw_fini() when GPU initialization failure.
>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>

Looks sane to me, but Andrey should probably nood as well.

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f31caec669e7..f6a47b927cfd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3899,7 +3899,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   	amdgpu_gart_dummy_page_fini(adev);
>   
> -	amdgpu_device_unmap_mmio(adev);
> +	if (drm_dev_is_unplugged(adev_to_drm(adev)))
> +		amdgpu_device_unmap_mmio(adev);
> +
>   }
>   
>   void amdgpu_device_fini_sw(struct amdgpu_device *adev)

