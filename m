Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABBC3CE7A81
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 21:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06CC10E13F;
	Fri, 22 Sep 2023 21:09:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C8B10E13F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 21:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKMcbK5jMCPlD2ww9UaZ8Jm+5gli7oBNkp7B6vVHN7II3rzXGqgGimkkNGOiNMNVlPZrZL2PiImBmGdMvdRtQioldAHRBiQf4IHpDWNaNfM7D0Hp3/WCI5wizle/8mRiVzovE5y9uxF03VgZ67t5MmAl7BYBmUHS/FX94epBgQi8kVt11rpkWt2Q+Cf/wm+KFSn8wdJ1Qn8kvNouupDkcLGNE9WtbbN7k2UcfDkLUE9iriVjpD62EXEekI7cbHNodjJgwbPsGzU60lCGjr5zvdpD7TySnwqsHlr2+WQGFA/ywe5Q6AamCHPDX8eIHGnwQDGrmGu7PLii945b0pMCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x4bxyRAfhRA8iNj8MZ0QER+IEjbWx+41pqsJTmfE+Y=;
 b=XExNpkOZEez81aAhioJKUu13uVHU9yjYz/yxr9YjTwtJ611TpqJVLTG6S0ehtF9jyI397qVvw2r5Y5CMhqzr0rGZCdq9yng2kTHoJUgjJTMn1kT98hBGe52VC5LCgCRmFqEgN1mp2BFn7CThPaoFn6kr7k3gGa4DRkFNr6nZ/1EErlpK/JgCw3BJPBs+VJwxLw/A/bO/cizULy/Q7uZbF94cbfTzB6HWGbwOgKGLniWSbcKS2sIMio+rYSD5nHs/QYEb4YpWOpF4K5TsyJzZk3OhCPsb1zxQn/s5e5SMytqGewgCXxTIREejUNmY8N35YF4uf5JNViHZsjUJJue/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x4bxyRAfhRA8iNj8MZ0QER+IEjbWx+41pqsJTmfE+Y=;
 b=h8WRIg+Yln7M/aYmhcFqi8O7uZNWPJTXuljXbYs8/o1ucXSmeC+BSchF3Rjfux24udjHjzWq+BIUz58ntG5UtlKfIyJZiJuqdvZ4u9WpcFEt8Q9gg6uLpcruhOcuHEROBKAQnF2fH07w6TpxlTxsR39rp+f+HSSzlt9OGsMUfgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.30; Fri, 22 Sep 2023 21:09:50 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87%3]) with mapi id 15.20.6768.029; Fri, 22 Sep 2023
 21:09:49 +0000
Message-ID: <2c1a087e-d79a-4ce0-bc9f-43915b4510da@amd.com>
Date: Fri, 22 Sep 2023 17:09:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.2.3
Subject: Re: [PATCH] drm/amdgpu: fix memory leak in
 amdgpu_fru_get_product_info()
Content-Language: en-CA, en-US
To: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230922052753.1922483-1-kevinyang.wang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <20230922052753.1922483-1-kevinyang.wang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::30) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: b316a73e-f31a-4dba-f259-08dbbbb041c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3gzN+sN8LsnpT592OybamiiJwKCvYNqxaJRxK1nskJHT/razw3YLokRwRZjd4U3wN48Pn6W7IE5D7R4W5pprLUq8HvWRy0L9X/VErCBuWRWK79YSk3i44GpZX/Qarafhb5O6+eSfngZNFWasxvs2nqwLk26g8DEtIhFxAzLLfiFxRgXdWFFOM6vm7+Oee/I3rfVN8+RbwwDaNDmYfbhIVlac0if531eG1+aGsRbl32RQ3wiOA+hCFcNWG5+DGi2d+cq6pSgkwgDcXYKTEfdAGvF9LUUE74CoosXGanYFt26Y+KpQUrZN707arhZ3jBLQIacZ1b3YxasGdKWuHBr2nvbqxmc9t7naIIs8vuo3mY0kYx2kZeOcXMyN3DzPKsyjXYeus4YwTvCo+Qfa404ey0nGcRtVkmVka4/0m6nrSlc8Y+FXbNUzx+vRhAIgWxeecQvelcVDeY8SfA1m1q8yd6rSgqXXlWEt8G3V96ekTa61GlPVdGvxKXrhLbJGqwHhMdbF/KeQn7CYJWp0KJRLkAwM3E58OlUA7jutIps7zCAncmS/FrJsAPvj7Rzz7HFyvqhglIrkEL7BjN3jacYs7PeM3iN9MF+80sGLqVlnHBFrmHXmH+1UN07Uccq2s9fMqg1KwBFohuqwLi2x7PEmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199024)(186009)(1800799009)(8936002)(66556008)(66476007)(316002)(8676002)(44832011)(53546011)(6506007)(31696002)(6512007)(5660300002)(86362001)(31686004)(66946007)(83380400001)(26005)(2616005)(41300700001)(36756003)(38100700002)(2906002)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUR5enpMNU4vYjlDMG5xQUV0Smw0UG5ZOXp5cWhlSXZBRVN2dWNuZEc0VEt6?=
 =?utf-8?B?RGF6clM2S1VVOFk0TzNHbnpGMW8wTytuTEhtUDYycW5qK01IcDRyc1NLYmQ2?=
 =?utf-8?B?bHBEUlh3RWNUTEFPNmlZOE5pcjEzRlhJTjVIZzZlK04yc2hiSUdWMkozU0dF?=
 =?utf-8?B?ZGxrV0ZhYkdpZVdjRjVCYWJPL2VPc2toOVRSd2ZhS0xBdDBXQmpod0d4aTBm?=
 =?utf-8?B?a0RyeVNJcmtGWU9KWUpxUmhycjRPdHBaVGFMZCtQVitDZmlFTEwwekZYK1NF?=
 =?utf-8?B?ZnlDWWhUUGlaT0EyNG1Nbmd3SXRwU2F2MzFXc1RNT3l5Y1ZrcGxJWE9HOFdp?=
 =?utf-8?B?Z0gybHpNeFdtZk5YYm16WExWWmNpYkkwb1RxMDVrWFJINHVnYWlhU2RQUXV4?=
 =?utf-8?B?T1oxVXE0ZWRpM0xXQythR2YyZ3ZmS0NLMVdrRXExSllCUjhQM3dnZ0JUSGRr?=
 =?utf-8?B?NU0zc2hxcTBxME00UTB1WXRuZGRsSjB4R3hIL1lBTEIrSEpvbE5DeXRuMjJU?=
 =?utf-8?B?ZHhUbVo1UjdKYUFUVnZJZXpoWnA2aElHVmVzbCtTVnBUeldqN2F3YS92ckRN?=
 =?utf-8?B?T1dHT1JRK0hQWUJKMTBLdEd4Ui9yb3QvajZnaXFzTEN3UXRlOHJicWhRVW55?=
 =?utf-8?B?QnJnRVRyNnJvNHBFMDNkN0lPZnF1YzZCRTZ6WUtQOTV4ZFVrUXhjR29YeUJM?=
 =?utf-8?B?ekZLU0oxWWYyYWJiWjRTTXVIOWZjSzBwVW4reWRpVmc3Y1psaDRoMDJmQm1M?=
 =?utf-8?B?TFNkOGMxanZMTGxRbEZIWTU4V0NuNTlBN3VMeC9hZWVIQ2V0Q3BjK1NQeW82?=
 =?utf-8?B?K3dWK0ZwQ2dtdWQvQTJRejhZVWNWZ0ZNbEYwODJMWU9MMzl0VXg1VlZpVTJz?=
 =?utf-8?B?ZmwyRDlmSHB1QzFrTHcxdms3SE1ZM2xBT215aDZKUVUwdmxUUzhWNHNKdTNX?=
 =?utf-8?B?d3BRSGZ5K2UydlpIQTFsY3Y4Z08vK1dyZmgzQ1F0aXYyUU84WWJhUmFPQXp5?=
 =?utf-8?B?b2lGRkNTMHdaSGlUY21WdG5tYi9xZUlFQlpRSmhLUG5adFNBdEhoVzViTTYz?=
 =?utf-8?B?dFZKSVFnZm9ZQnBIYllTb29JMzJYMWE4Z2xUYXFUYVRyRjYzY2UySWVJRkl2?=
 =?utf-8?B?OGtKTU5Ycys0VUtyM3pOckRiTHl3TWFURHZlRm5lRmxIRVI5NjJKazgrZXRw?=
 =?utf-8?B?cGw5NklJMldEeFQrYkJTTnU3cDZ6TFRzemwrRHRqb28zUnpvVXRXL1hYcmRC?=
 =?utf-8?B?dzR6VkZaQU9HN1FTSnRkcm9rUXZ5Y01PUFpndzBtL1BrRVNlV25BVGhnem9C?=
 =?utf-8?B?THBsVHYvZ2IxMFNBZC9KYzdMblF0czRML2J1N0xVeWJ4Y29wM0NlWmROSndE?=
 =?utf-8?B?R2xia0NXZ3ZHL2hWQTErNHdiWnJNaTBvY08yeE9GZ3BFQ2ZjK2wwc2w3b3BW?=
 =?utf-8?B?OUJzVDBkNDRobVBIUzBKZmdLT3dJdm14a254OHRRVHNJWForcGRNeE9RU0M1?=
 =?utf-8?B?QUxXSFFIdjFqSmN1bVpaMEJuNHNuNGw2TFhtNndTNm5YWDkvNkQ1WDVWOFhV?=
 =?utf-8?B?YmpXR0d2QkxYUGhoZDJkOXVsenJDMVhOdjhPeDcrNHptVEhkNUFRRVpOSUhC?=
 =?utf-8?B?MVdhQTRuZlh3eVVqci92QVNrQTdESWxkSDVaTFpuS1UvQVRKWEg4MTJpUU1D?=
 =?utf-8?B?YUxxOFJwbzY4RHVxNm1qNWNaK0tNUENpaWZNMGh5VUhDODFLb2x3M2ZHaWVl?=
 =?utf-8?B?Q2pwWTdxcENJK0REYVo0WStnSVBZcWdPZHdNRU8wZnpydVIxekQydjlSeldz?=
 =?utf-8?B?VTl6SXVhcmN2cDZ1S1hGWGpNTCsyNDJmTUl0US9VWDk0ZFBVL0tNNnZKSXJI?=
 =?utf-8?B?ZU5lUEJ0eEZUS3h4aXRtYThlb0t2UlU3M1RWNEc4N1hHazEyenUrS0dmOGJi?=
 =?utf-8?B?NEE2NWE0bXZVWSs0VXdCMjFIbGFBVmEwdkkrTE95VUsyaU5mb1dlb2VZd0Iv?=
 =?utf-8?B?cXZGZkNsOWpJUnpvSisxS1JpMnVQdUdTV3ZaSnlvRU1lSU5ZQmNseU9Dd0JP?=
 =?utf-8?B?eTMyaU90REZReXYvcnRDdXQxSTdnQzZPTzA5OERjQTJZSkorMWJIUVErZ05V?=
 =?utf-8?Q?1SdUgq8us9ezoxWkI78EEH8Tx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b316a73e-f31a-4dba-f259-08dbbbb041c0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 21:09:49.6425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKz9xOGModZ9oIjbAlT7khqD8DYvaCqylxSWiL/Qutz7/RdQjCRen4AEGKUdUkKf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
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

On 2023-09-22 01:27, Yang Wang wrote:
> fix a memory leak that occurs when csum is 0,
> the origin function will return directly and forgets to free 'pia' resource.
> 
> Fixes: 0dbf2c562625 ("drm/amdgpu: Interpret IPMI data for product information (v2)")
> 
> CC: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 401651f28ba2..50b6eb447726 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -111,7 +111,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  {
>  	unsigned char buf[8], *pia;
>  	u32 addr, fru_addr;
> -	int size, len;
> +	int size, len, ret = 0;
>  	u8 csum;
>  
>  	if (!is_fru_eeprom_supported(adev, &fru_addr))
> @@ -171,16 +171,17 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  	/* Read the whole PIA. */
>  	len = amdgpu_eeprom_read(adev->pm.fru_eeprom_i2c_bus, addr, pia, size);
>  	if (len != size) {
> -		kfree(pia);
>  		DRM_ERROR("Couldn't read the Product Info Area: %d", len);
> -		return len < 0 ? len : -EIO;
> +		ret = len < 0 ? len : -EIO;
> +		goto Out;
>  	}
>  
>  	for (csum = 0; size > 0; size--)
>  		csum += pia[size - 1];
>  	if (csum) {
>  		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
> -		return -EIO;
> +		ret = -EIO;

Actually the memory leak is ONLY here.

I wonder if you could've simply added a

		kfree(pia);

> +		goto Out;
>  	}

before the goto Out; which would result in a one-line change.

Yeah, please do that instead.

So, don't add "ret" and what not. Just add the one liner "kfree(pia);" before
the "goto Out;" and make it a SINGLE-LINE change to fix this memory leak.

You don't need so many (formulaic) changes of adding "ret" and what not.
Just a one-liner change, please.

>  
>  	/* Now extract useful information from the PIA.
> @@ -220,7 +221,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
>  	adev->serial[sizeof(adev->serial) - 1] = '\0';
>  Out:
>  	kfree(pia);
> -	return 0;
> +	return ret;
>  }
>  
>  /**

-- 
Regards,
Luben

