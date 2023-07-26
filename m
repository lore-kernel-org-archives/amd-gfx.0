Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C6BC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 03:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0C810E40C;
	Wed, 26 Jul 2023 03:51:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EF510E40C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 03:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGW/s1gxXkupFQDjd3agxzUZLE8IVjMIzxSAQ+0pBmEkV2rq2C0ZRwER+MFI+0xoiDN8zM8+C8UiO13uK6RRTNjevs7nSaLOdbMGY6+nknnkfBqX0xYz88cv00sT4mjwiMCXUGDg69DPLZS3shU4v2zzvpgPIN9jzkDHbfU+ds0qFx/THB5iRIo2q+2UXwqY7LGQCQBXK8A8Nk8rGs21xA8ZhVBWdrI8AK58rxiQeXzTsv++G7BTHxlTxm+X0ALdXkEJY0/3++/3kbuwrZslAwOOXfZDb/TKZ8nsiwmcJnnId+I6o7LgZWawmzlLGWGGFEHtR6mp18FeaPXIDpWsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqKGPE/7QjHzAxWcfjWmxHbGVCQkf+ArviKubDwSNhQ=;
 b=eoxMOvz3mWtmsfPpEDzH+beaYhublbmwCfPOrE4bCd9st3pa91r2XaSXNJU5lkOYlKhsGbCnvmIjEno2KQzv/gdRTAA2UsbYbbMZRM0kLRwUd2i/BBMIjYe8oQ0sAt89Gw4NFjdqwizJvLdAbHArtIZb0wkWeFtbsL8K+44OsforZ60PPWnfOrBauIJRL8nhRmk5bltNM9C2UxuV/EASsVdByYywNvpSmCldS6Y7gs5Hyi0WnCs5B7/4r6mRuKDsJ8KdAtPFAvkRmcA2GlzuN/QeCRLpfBkDg5xDEvZ8pPnjBpjIfU+uGpsi/LxPg+rNmA6WoWq2We7TZRDisrx2GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqKGPE/7QjHzAxWcfjWmxHbGVCQkf+ArviKubDwSNhQ=;
 b=KKqqkgMUj0B/EG6mVtAMZkh3xk6IA9gnGY98IqK9SD4J6YnA3jckgUQubgD3P8o2n/+j00x/DNnMkOScEn9JYLfYvxhkRoqb2aQMqlgsscEetkbcWYxLIbhrzI5jkxTpZMP5MmNOUpSK1fMSxiQU8WQWBvv+DjjJsvdLLX/INtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 03:51:37 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 03:51:37 +0000
Message-ID: <3a9b3071-5812-64bf-00b1-ddf047705dd2@amd.com>
Date: Wed, 26 Jul 2023 09:21:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] drm/amdgpu: Fix ENOSYS means 'invalid syscall nr' in
 amdgpu_device.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Kent Russell <kent.russell@amd.com>
References: <20230723061549.2017184-1-srinivasan.shanmugam@amd.com>
 <20230726024711.2386407-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230726024711.2386407-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0155.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e1c598-244e-47ab-0a67-08db8d8b9c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdKevcm7EKOGiln2GZYXCWsSgwLAlVCiIzWvCzjv0WA8AQqOl108qFZBXrN3A8wkqWWLTo/ErX9azCmIBp+rmwoHz1sqNmgAZcX3MsIcS8aeFYZq5EwdVss3Bds+mNjqOXmNcwknEjmgMD+l2R7OmyQWeL11CyjOuXjPTVb71FNetMKG3GOLjikVTK1MB4nhJcysUQ4FOZeC4TTmL9Wfsgs9T2pcQJtViL6bbdLts9jivg1MoDj4RR0UjA9Pwly1uM8LywBLVWA2Am+T0DISjfUPQ16WAWoS8kCJlPFi4m4IScfnuuGrgNTn8rgiv9axyQMLYFs7ezy9WzcF9VyKfXajjghwTCQOFpiJy96vbackp8iKlBsN8woB6RupPaptWZmK08ZertCsHGz/Iy/x/imAvvO5icXH6WaMkBjkIMliiIvh1XFZMSU3RbASzvnrfcHPcK6GG6RCuotMVmvP3sf6W/r1oH7hoQxClYhKy21Eq5qMDcjpogYNtTlZuAUrc1EfLs1OItqOO/PoRYlcnH4GxtD/gzjYJe/t2c2KtDIE9Q3Is2JIlGhO6tVe+VV7Q2Caw0LqqDLLq76Auqs5XQYyx9ViiVHNjuISBQTqJ52/hm3XEeeYIp00ictEF5M1UeI8y3ShCebqMY3p1gjf9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(41300700001)(53546011)(6506007)(26005)(186003)(5660300002)(8936002)(8676002)(86362001)(31696002)(6666004)(478600001)(31686004)(38100700002)(6512007)(110136005)(316002)(66946007)(6636002)(66476007)(66556008)(4326008)(36756003)(83380400001)(66574015)(2906002)(6486002)(30864003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9wZTEvd3k2a2NuOGRwNTVreTQ1KzkwcmREUWhvQUphWHR0ZnJiNzg4RTVn?=
 =?utf-8?B?Y2F0dzdIdGJvUSt2Sy9Fck9lbjdBd2dEQU1zU1FmdE1lVWdxcGFBaGlKeDZQ?=
 =?utf-8?B?dUtJdkNMNWQ4MXQzaUI0Z3lQSGlRYXV1RUdIa281VUM4bndqd1Z6NlVEazI4?=
 =?utf-8?B?cEsyNEhKeEN3cGVlYWs3aTRDTjc2TUJ4RE4rd2FkYjdxUDBlR0g1dmFSV1dm?=
 =?utf-8?B?RFpieDdVV2VlQnpFRFRuOTVxVnlFTytGOHpuWXdJY01CK3VmRUtFRkhHRnRG?=
 =?utf-8?B?M0xIRUtjbXEvQ3JPSGZCcC95ZWdrVndZNndLUjUrYkJHeHQ2UUkvRFZqOUd2?=
 =?utf-8?B?OEJCUERuNkt6ZTVoNlFOOVl2djZ5SUNNY3h5VHZNRHJjNXFtWHdUVDBFQVRT?=
 =?utf-8?B?NGZ3OGNMQXVwT3JoQzc5R3k1SkxubnUxcmFaMForSCsyVUZXdTk2M1BNYUxV?=
 =?utf-8?B?SThtV1RxNWVzQ255Rlh3ditudGtGVFNUSEJjYXlhY3JvcjhJQ28xVStjWkF2?=
 =?utf-8?B?eUZVbVJMdGJWRWtrZUVNZ0E0NkV0M1pOT2Y4V2JGQVhmL09IaUFaaCtickhH?=
 =?utf-8?B?RkV4T0Z5eVFQNFFDTVpCSngxSW9tS2w2UGI0U3NmMldRQktzdmRpYk85a2FR?=
 =?utf-8?B?Z3VTK25LdU5oeitkcVhXWU5XY1NvM3drZDFmbVVDa014TFo4eFRyd1M0aHdl?=
 =?utf-8?B?NmdXQUsxOTJYVnpGYjRUQldKUWtpLzBPWWRzeEF1Y1NOeEZVNWFLZVE3US9G?=
 =?utf-8?B?NTNlQTRDbThudVE1MHJWYzNpK1MxbXZIa2Y0QzZBRjNvV1BZT2dhbXNxb3BS?=
 =?utf-8?B?Y1gwcjhpUGtzOHl3YUt5TkJHRis2MXh4Q2hRM1BIQng3bWNMdmMrWDNaRllX?=
 =?utf-8?B?cDJRVVVxREVtVnlPWEJBZEJCVWZkaGg0VkJOQmEvZlF4ZUIxMTc2aElpUkdI?=
 =?utf-8?B?T0JkZ0FNVTlNRmpiMit3dlFtOWxlc2hxZm1UUUZDbzlpNGQ5QVAwWmgvbVNS?=
 =?utf-8?B?eXJqNnQrbkh6aWRZRWJKR2IrYkx2Vyt4N3A3ejAyRXhaOFEvaGZ0V0YrTERF?=
 =?utf-8?B?RnpZYVNHUEprOHNpZ1BFSXFxdm5tVjQzSWNUaGx3MGN0K3BWYmxNYm1vRmN1?=
 =?utf-8?B?UEI2S2sxeVZjS1JZdDBXc2JNNjNlUnpJV1I4WjFDcDZCK3o1dXhkVS9CZ2ZE?=
 =?utf-8?B?eS9BM0pVOG9tY3llcldSSGREcVN5bHc3ZmZ3SjZSNUVRSUFrc3Z6ZDA0aXE4?=
 =?utf-8?B?U1R0dVp2MXBuMjdoREZIN0J1algxVHJad1gyNmJJZW10Z2NXSXlHbU9vOHBN?=
 =?utf-8?B?QjErTDR1WU1iMzA0TGhvaTdObjlESlcySkVVRDZZYzlNVHdjQkZkUDhJMHd3?=
 =?utf-8?B?bTEwTW0wYmwwU3F5ZU9GUkdTK0tQZFVTTWFLeDM1ZDZhc1htQ0xiY2RVaHpl?=
 =?utf-8?B?SFFObTJzKzYyU3NGa2dBN2ZxS2t4ZDY5bjE4SUltMG9xV1pIRWVKazNTSE1l?=
 =?utf-8?B?STk3TUZmNDhTaWU2d3BHakQ0a0FPdG96ZjRSYXluSUFTSkx4Z2hkakZLbkVG?=
 =?utf-8?B?bElqQTE2djdsZDlGTHArWjJzZjJlNVcyWDR3K2lCWW9vTCswSXVsTm1QNVF3?=
 =?utf-8?B?OTNRUnZDVWRQUFdySFB2ZjJpdGg2TDNVSVhoYjBPd2dMTFBkeDh1RTRrS0Vt?=
 =?utf-8?B?YkdCMEk0VHZVVTRnQUNDS29IRUR3STFaZ2c5dmxrRWw2cmJ0c04wdmdYdm9l?=
 =?utf-8?B?aUxsQ1A1MHA4MzNKemtZaHYvTHdSbDNmNUxyd2VHUU0raHZibVowUUdrRWZw?=
 =?utf-8?B?bGVwazNKMTVFSkUzSUxQdDRYV0tGMDBteG9ObmdIQ0hWWlAyR1dNUWx6bjRv?=
 =?utf-8?B?OUU5UjNDNzVBU0R6ZHJXSUQvMW5ZRTVudHlWTHlqb0dWM04xbnA5b3JsMVdL?=
 =?utf-8?B?MnlvcGFDVXJGSWUxNDJGMzd1Ullwdm9ydExPVXZIaDI0UlZ1cFI5UDBLNElE?=
 =?utf-8?B?SmMrbzJEYmtnQlB2UHUzenZlNGVrQUsrWTdKdEg5SFpPWWFaMyt3cnRBeTFm?=
 =?utf-8?B?WHlTYldYZUQzRDlzUzN4UGp5ZVVuOFlTcHJ5RGVmbnJZRW43OFVpWjVyclNP?=
 =?utf-8?Q?1dxQ8k2gV9MS5PeBxpU29TPKr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e1c598-244e-47ab-0a67-08db8d8b9c78
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 03:51:37.2000 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCJuvbif8ofI91aMDm03DIai64iBJsjd7lj1cp17KAYgCP+A6vBidki/tEpE9VMx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
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
Cc: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 7/26/2023 8:17 AM, Srinivasan Shanmugam wrote:
> ENOSYS should be used for nonexistent syscalls only, replace ENOSYS with
> ENOTSUPP
> 
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> +       if (r == -ENOSYS)
> 
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> +       if (r == -ENOSYS)
> 
> And other following style fixes in amdgpu_device.c:
> 
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> WARNING: Block comments should align the * on each line
> WARNING: Missing a blank line after declarations
> WARNING: braces {} are not necessary for single statement blocks
> 
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
> ---
> v2:
> 
> * Updated the following in the commit message (Kent)
> 
> 	WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> 	WARNING: Block comments should align the * on each line
> 	WARNING: Missing a blank line after declarations
> 	WARNING: braces {} are not necessary for single statement blocks
> 
> * s/EINVAL/ENOTSUPP (Lijo)
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  4 +-
>   2 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1c786190a84e..bfc54ba0e1c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -159,7 +159,7 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
>   	return sysfs_emit(buf, "%llu\n", cnt);
>   }
>   
> -static DEVICE_ATTR(pcie_replay_count, S_IRUGO,
> +static DEVICE_ATTR(pcie_replay_count, 0444,
>   		amdgpu_device_get_pcie_replay_count, NULL);
>   
>   static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
> @@ -183,7 +183,7 @@ static ssize_t amdgpu_device_get_product_name(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", adev->product_name);
>   }
>   
> -static DEVICE_ATTR(product_name, S_IRUGO,
> +static DEVICE_ATTR(product_name, 0444,
>   		amdgpu_device_get_product_name, NULL);
>   
>   /**
> @@ -205,7 +205,7 @@ static ssize_t amdgpu_device_get_product_number(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", adev->product_number);
>   }
>   
> -static DEVICE_ATTR(product_number, S_IRUGO,
> +static DEVICE_ATTR(product_number, 0444,
>   		amdgpu_device_get_product_number, NULL);
>   
>   /**
> @@ -227,7 +227,7 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", adev->serial);
>   }
>   
> -static DEVICE_ATTR(serial_number, S_IRUGO,
> +static DEVICE_ATTR(serial_number, 0444,
>   		amdgpu_device_get_serial_number, NULL);
>   
>   /**
> @@ -481,8 +481,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   /*
>    * MMIO register read with bytes helper functions
>    * @offset:bytes offset from MMIO start
> - *
> -*/
> + */
>   
>   /**
>    * amdgpu_mm_rreg8 - read a memory mapped IO register
> @@ -506,8 +505,8 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>    * MMIO register write with bytes helper functions
>    * @offset:bytes offset from MMIO start
>    * @value: the value want to be written to the register
> - *
> -*/
> + */
> +
>   /**
>    * amdgpu_mm_wreg8 - read a memory mapped IO register
>    *
> @@ -991,7 +990,7 @@ static void amdgpu_device_mem_scratch_fini(struct amdgpu_device *adev)
>    * @registers: pointer to the register array
>    * @array_size: size of the register array
>    *
> - * Programs an array or registers with and and or masks.
> + * Programs an array or registers with and or masks.
>    * This is a helper for setting golden registers.
>    */
>   void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
> @@ -1157,7 +1156,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
>   	struct pci_bus *root;
>   	struct resource *res;
> -	unsigned i;
> +	unsigned int i;
>   	u16 cmd;
>   	int r;
>   
> @@ -1226,9 +1225,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
>   {
> -	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU)) {
> +	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
>   		return false;
> -	}
>   
>   	return true;
>   }
> @@ -1264,6 +1262,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   		if (adev->asic_type == CHIP_FIJI) {
>   			int err;
>   			uint32_t fw_ver;
> +
>   			err = request_firmware(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
>   			/* force vPost if error occured */
>   			if (err)
> @@ -1366,6 +1365,7 @@ static unsigned int amdgpu_device_vga_set_decode(struct pci_dev *pdev,
>   		bool state)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(pci_get_drvdata(pdev));
> +
>   	amdgpu_asic_set_vga_state(adev, state);
>   	if (state)
>   		return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> @@ -1388,7 +1388,8 @@ static void amdgpu_device_check_block_size(struct amdgpu_device *adev)
>   {
>   	/* defines number of bits in page table versus page directory,
>   	 * a page is 4KB so we have 12 bits offset, minimum 9 bits in the
> -	 * page table and the remaining bits are in the page directory */
> +	 * page table and the remaining bits are in the page directory
> +	 */
>   	if (amdgpu_vm_block_size == -1)
>   		return;
>   
> @@ -1620,7 +1621,7 @@ static bool amdgpu_switcheroo_can_switch(struct pci_dev *pdev)
>   {
>   	struct drm_device *dev = pci_get_drvdata(pdev);
>   
> -	/*
> +       /*
>   	* FIXME: open_count is protected by drm_global_mutex but that would lead to
>   	* locking inversion with the driver load path. And the access here is
>   	* completely racy anyway. So don't bother with locking for now.
> @@ -3265,7 +3266,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>    *
>    * Main resume function for hardware IPs.  The hardware IPs
>    * are split into two resume functions because they are
> - * are also used in in recovering from a GPU reset and some additional
> + * also used in recovering from a GPU reset and some additional
>    * steps need to be take between them.  In this case (S3/S4) they are
>    * run sequentially.
>    * Returns 0 on success, negative error code on failure.
> @@ -3367,8 +3368,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>   #else
>   	default:
>   		if (amdgpu_dc > 0)
> -			DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
> -					 "but isn't supported by ASIC, ignoring\n");
> +			DRM_INFO_ONCE("Display Core has been requested via kernel parameter but isn't supported by ASIC, ignoring\n");
>   		return false;
>   #endif
>   	}
> @@ -3616,7 +3616,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
>   
>   	/* mutex initialization are all done here so we
> -	 * can recall function without having locking issues */
> +	 * can recall function without having locking issues
> +	 */
>   	mutex_init(&adev->firmware.mutex);
>   	mutex_init(&adev->pm.mutex);
>   	mutex_init(&adev->gfx.gpu_clock_mutex);
> @@ -3693,11 +3694,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
>   
>   	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
> -	if (adev->rmmio == NULL) {
> +	if (!adev->rmmio)
>   		return -ENOMEM;
> -	}
> +
>   	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
> -	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
> +	DRM_INFO("register mmio size: %u\n", (unsigned int)adev->rmmio_size);
>   
>   	/*
>   	 * Reset domain needs to be present early, before XGMI hive discovered
> @@ -3951,7 +3952,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
>   	/* this will fail for cards that aren't VGA class devices, just
> -	 * ignore it */
> +	 * ignore it
> +	 */
>   	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>   		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
>   
> @@ -4034,7 +4036,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   	/* make sure IB test finished before entering exclusive mode
>   	 * to avoid preemption on IB test
> -	 * */
> +	 */
>   	if (amdgpu_sriov_vf(adev)) {
>   		amdgpu_virt_request_full_gpu(adev, false);
>   		amdgpu_virt_fini_data_exchange(adev);
> @@ -4771,8 +4773,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!ring || !ring->sched.thread)
>   			continue;
>   
> -		/*clear job fence from fence drv to avoid force_completion
> -		 *leave NULL and vm flush fence in fence drv */
> +		/* Clear job fence from fence drv to avoid force_completion
> +		 * leave NULL and vm flush fence in fence drv
> +		 */
>   		amdgpu_fence_driver_clear_job_fences(ring);
>   
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
> @@ -4786,7 +4789,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   
>   	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
>   	/* If reset handler not implemented, continue; otherwise return */
> -	if (r == -ENOSYS)
> +	if (r == -ENOTSUPP)
>   		r = 0;
>   	else
>   		return r;
> @@ -4904,7 +4907,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   	reset_context->reset_device_list = device_list_handle;
>   	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>   	/* If reset handler not implemented, continue; otherwise return */
> -	if (r == -ENOSYS)
> +	if (r == -ENOTSUPP)
>   		r = 0;
>   	else
>   		return r;
> @@ -5393,9 +5396,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		if (adev->enable_mes && adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3))
>   			amdgpu_mes_self_test(tmp_adev);
>   
> -		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
> +		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
>   			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
> -		}
>   
>   		if (tmp_adev->asic_reset_res)
>   			r = tmp_adev->asic_reset_res;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index eec41ad30406..0f4808dcdb2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -87,7 +87,7 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
>   		reset_handler = adev->reset_cntl->get_reset_handler(
>   			adev->reset_cntl, reset_context);
>   	if (!reset_handler)
> -		return -ENOSYS;
> +		return -ENOTSUPP;
>   
>   	return reset_handler->prepare_hwcontext(adev->reset_cntl,
>   						reset_context);
> @@ -103,7 +103,7 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>   		reset_handler = adev->reset_cntl->get_reset_handler(
>   			adev->reset_cntl, reset_context);
>   	if (!reset_handler)
> -		return -ENOSYS;
> +		return -ENOTSUPP;
>   
>   	ret = reset_handler->perform_reset(adev->reset_cntl, reset_context);
>   	if (ret)
