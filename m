Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA84606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oeE8AgCk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17E6A10E10A;
	Thu, 19 Nov 2026 13:23:24 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0511710E10A
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iU5YiSpaIYATFvWZXSSlgKnevWXXhRn+EIX1u93x/LPRX46COFUKWleapqbR3pkJB8cvQw5QHOrK3Xa+1UZIcc4ZEldNX7v2CsrnRyAGPsd1zfAsE/bZU0+Dvqy8zvoMkNtIcmzvvDGjhOO7VingWVep0expybTFsGMtmIG1zGoJv7jxtjlHZSeSp5TQXDc4kHTZZvwdyEqIx1RyBh4xSYAuzX5pvQAaf5o2H0sVIqIasUz2RkaBsYiw5SEGQm8Qk9O8KpsI4g/S1v1r7i/nMxMk8zax6haMx8tEVF9QOzR5bVchp2O8BBrApjOY/NhNlwrJvVpROi9wEgLUWOISJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJOIM4EWcbediyKumhrM0A4gqO44GOIxFU4LXJJ8RWs=;
 b=zVEJ2ybH0Ni8EGWiH7Bk2VYxQ3dbrsfJtF8A6DyQqR4uTgPlm/1AtrQ6G+0WmK/kQf4cIGsJLlUab8HIaeit9uyfFWKlaNAi0Vc9V80439ExRpYE4rsRZvfxV5euyemII/xd1aFnhw25aR0rZ/RKubz4W9JiE/6tknrduA2Fwp5f4UDXKNrtsGSjllqUcuHCdcOddqoqyZ22jQI70hFqeNd0ItloQYP/YgaXw5c+/uLrl/JdYESwQEXxvtja8oJaVJR9QSa8wj595HPUbc+WP9aEw2rxBJYKvFT9YxtWsOzzlwKKlsJWZHtub9ishKpnpVgDvoargev2eDDbWtfB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJOIM4EWcbediyKumhrM0A4gqO44GOIxFU4LXJJ8RWs=;
 b=oeE8AgCkGBbCeFAJOXZxSSAlEPw+NK5wSRcm1NOvXHElQOV6sSLiQj6pWZ8HjIE7OCBywp/eMqWdSFgrULoQcvlqXAu4t2v9cyYqIuUL03b0wE6axE9Y8k7SnZyNSS96wZY7Z4O2hB+PxWAkvHtTlFAndbWd1w1ZPA5OUflc5Vo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.10; Thu, 19 Nov 2026 13:23:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:23:12 +0000
Message-ID: <f52b986e-7b95-493f-8bf1-56187d409913@amd.com>
Date: Thu, 19 Nov 2026 14:22:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] drm/amdgpu/dma_buf: reserve AMDGPU_VM_UPDATE_FENCES
 for move_notify
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-3-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-3-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: a363ec7a-935e-465c-53a4-08df464042fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|11063799006|4143699003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|56012099006|261022075727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: buaS8wqa0lBx6FWfsoymdtuoVrDofpqHsNucUmLCCTIHe34BYa6pDSHKokQrPpfHtXmjOdiuV1ML2sEVMs2pH4ngtaqQJseh/WqAvV46iJB6gWyh5boaFsW1A8xCyvkn74MvRtY7zXN7+FWAI1qIbNe580/nM8UlUutNkYH71Nf0C3LPJ5CPe9nbPA3W1QlOZi0OmXbYLohaB6Z4E9wczSA7l0jP1jr8IDTVA+s52M7c4JXgGjfZn0DJj/kjo/1qsFdlY9TAbTnsCc1il4LZ6IkqWcy3/GyUiRtsZLQ4IXc4CvPZuC9QgtXQoDczj0J1TTcQ6UOsAa1eB0nn0kJcxorLaQDWAaP9ohNgmRUB4dYFr8GU+uaOADl/9Jt9Q6v0OmfSAr+15QFjkBmZQJEf1VhLgOix9p5/M6tCncqVjvhVRzv3voTlXopJdtJnq/1Qep2g9tu0g3/1T+nDM/pXHOisSS+31Zcc0bX/dLCGnT2/ivTDN4S5xRFGfcpsDZ3ZiL7UcB51ToE9VOu920j1vmQ7PwZ8El+MwSQZME5ad4VKzXlPE0eqjzQlVThdPVAxg5pPGz6u5YF3eGg/XUy1GuTEjjIaMRX1PXtYDjx7/Gznq3qgo0TOBPunPLaOf8dJh9W/LKcnVNYZOAKSiw/XJDijWL1S1tN4lR3yqSg6stM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(56012099006)(261022075727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2xEZnI1YlpzdUdmdFpRUXFpMHRpQll2S3FJT1k2YUh2WXRWSU04Tk9JWTBy?=
 =?utf-8?B?c040V0NWTmQzdFJTbEQ4enpFQm1oSG0rYlNNVTdnYmxHZC8vVGQrQlZhK3RJ?=
 =?utf-8?B?WDczRW9tT056c0t5Tlk3Mndsa1VlcVVHNmx0M05LWVRwMmk4U056RXIxT2ZF?=
 =?utf-8?B?STRYMXRBQVRDT0E4WVpkTnVIZ0RkcHVnU1I4S2Q2VTBWcWhTMGlySzlnckRr?=
 =?utf-8?B?STV3VnRLSmhWRkZVRndHajVrbkF2cDZ5a3pjRUJkZTE3K0lvOWdIeHo0dFR6?=
 =?utf-8?B?eFl3ZFBKY2I5OE1NSFhRL3A5cmwxTWpHWnBlTkw0QlRLcFdVZTZCa1V2aXZQ?=
 =?utf-8?B?SEZGTEwxV2loTDNoeUc1RU9rakluN2pPVGN1TjJjUGZ4MTg1S1NVUXZuczZL?=
 =?utf-8?B?M3ZWL2NZUDlzbnVLT3g0SEl0UXZwZ20yTklJN1lwWkdEMWQ5RU4wdzNTQkY3?=
 =?utf-8?B?K2wzNGJTLzI1c0N1OGROUEF3VDdHaXE1Y2E5bDdURWFJL2pTV2YrR1JIOERz?=
 =?utf-8?B?QlJjM21rUzNJR2R0Z0pqL01GcW03T2ZCQVNwNzM4cFArQkJKUGRzbUJFcjVO?=
 =?utf-8?B?YTZzT2tqaDVRRk5jSVUzaHpnMTRWQUk2RzNSR2pDbE5rM0dUVlZFR3BoajM3?=
 =?utf-8?B?cUI0Y28xVllxWVNPUjgrdXRrdEluQ1RIVHBJSUlyYVAvUWRkMUFJQTNnV0pG?=
 =?utf-8?B?OS9JZWF6WkdpNUxheUJ4a3VCSys1VmxMdWhhbDdkK2gwejlJQWNZdXh3Qm5m?=
 =?utf-8?B?Q2kzclFCcDRURFNxN2hhM1gzdUZtMFJFSGlWa1ZJM2lmeXhnL21jeENsd0dZ?=
 =?utf-8?B?UnJrL2l1NHphMkxZOExCTHpTdUFNRkhuZHdLVkNUUHgrTk1TTTFTdkVwNnVT?=
 =?utf-8?B?YmM5RjVobGRGMERuODdhZG1jcTlzZGhGUWs4RXdLNVRtRmF6VkVLcXEzKzRr?=
 =?utf-8?B?eFVBQnMvNjlrWWNpOURoMGZZbmVGTXpPSG1uTHhZeUh2Q1hrNXQ5Q1plRDdk?=
 =?utf-8?B?V1RKZ1NTcmJJeFJOWldHeUJLZkJDZm8rYXNVRktuY1h2ck1pODQwQ1dvZ1U5?=
 =?utf-8?B?WlV5YUpWdXk3bGk5SGwvTEU2MHNUbEIwVW81VzNWSVRNaU1MaWFGR1V2cW84?=
 =?utf-8?B?RXhGVGNWdStOMXV3dDBacHJINDJhUzFEb2wrdXkrNFFKSHVvSkRVWm5VdFRs?=
 =?utf-8?B?VDhxTnF2SjhXN0hpbWlRTkVBdnhPaFZhZzFHbVJUeENWY1A1NHpEMG42dTZ5?=
 =?utf-8?B?TDc0ekt0azdUTi92VWZ6TVFla0NzZXVpbjVGeU5OUU1UdXN5SitQUko3UWh1?=
 =?utf-8?B?b21XM1p3aWx3U2RNcGwveUZhdlFzdmgxcm9CTzEvK2dMNjk4Z3VBa0JtVVlD?=
 =?utf-8?B?TFN0cWJHZFdCUUtMMGY5QWpBK1NnWWVqNHNyYzlFdHhPUWE3OStyUHZsYjRR?=
 =?utf-8?B?SHNMRzJrQnJFM2h2R1ZjTW9EYjN4NUN1bDRPb1dBYWg3clB2eVdzM2tEbXBn?=
 =?utf-8?B?elFOTUpjcERPWW51MmNzbDZYUmRRdzNnbnUvNEdib2xUc3o1T3FmZExmd1BT?=
 =?utf-8?B?WnpRcnhmMnlEMmRGQmw5QnBCd2F5ZHlxVUV1bWh1VXpQYW9CamRHVGh4aWRj?=
 =?utf-8?B?VXBJc0JCNXY1RW5ja1BGNkNIK2wzMWxnZW0xVFB4elY0Qmtwbm5rRW1uVXhY?=
 =?utf-8?B?RGFjTXVRcm9CTnMxRm9NR0dGelo4djJuaW9nTVcrbUhrK2lIbmZsZnJuR2pW?=
 =?utf-8?B?Q2JyQjlmVml0Ly9xQUJ3Y3lFUHYxNFBGWkkvTElCUHRldmp5d3c0ajRYcHNI?=
 =?utf-8?B?Vmc2TUdKZW9zQ01jS0FqTlZoQ0luL2NzZ3lPVnVFd3hDZ2ZGZFdMQ28wSm1u?=
 =?utf-8?B?Rk5FRGRUOXRWc0d2QVZIazZ2SXdEYXNqWjl3ZFUvYVB2aFpnTnRWUGxwQTIv?=
 =?utf-8?B?cVVqQS9aV3pyMCtDRTlTOGMrWGVHYmRobE5Za1ZieHBOWXZtZ0s0TXkwRnZl?=
 =?utf-8?B?Y3o0TVRZVVJMaGttMTVyL1NXdXRodmU1VXd2SVhKNGZkMnNVREt2a3hTc2Q4?=
 =?utf-8?B?eld5VkxYY1JUWTIzc1NzRFpuZ3JxdXMzVy8wRDhUSWdZTG1oWWVqMXhyc056?=
 =?utf-8?B?NXcxdFA5Mmc5b1pTT1Ara0tBS1dRVTVQRHFSazdqMzVjS3hjU3IrSnNMY2ZF?=
 =?utf-8?B?Y2paZlFlRFpxdmpGcWpiVWhhTEhXWTFhY0pkU3h1VjlmVkF3N2EwMHJ5bCtG?=
 =?utf-8?B?RytUOE13aU9vbUw0TnVQb3Vudi8wWEhZSHBMdkgzK3ZRQ0dKSGI2NEM1RC9R?=
 =?utf-8?Q?tfsoD7CrHM/b2w4OA9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a363ec7a-935e-465c-53a4-08df464042fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:23:12.8051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Poo8WCxY8Bt/A+8bilOQFuUzGZE/0O77OHBDZCIRIvYvg4DEoFwZKbKyWqENrXw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 19:52, Benjamin Cheng wrote:
> This is about to update the VM so we need to use the macro previously
> introduced to make sure there are enough fence slots.

The amdgpu_dma_buf_move_notify() path should use the unlocked approach I'm currently working on the KFD team and Timur.

So that here is unnecessary to begin with.

Regards,
Christian.

> 
> Fixes: d8a3f0a0348d ("drm/amdgpu: implement TLB flush fence")
> Fixes: 897ee11ec020 ("drm/amdgpu: create multiple clear/move ttm entities")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 7b85152d6872..d3a7cf9c274c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -562,7 +562,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
>  		}
>  
>  		/* Reserve fences for two SDMA page table updates */
> -		r = dma_resv_reserve_fences(resv, 2);
> +		r = dma_resv_reserve_fences(resv, AMDGPU_VM_UPDATE_FENCES);
>  		if (!r)
>  			r = amdgpu_vm_clear_freed(adev, vm, NULL);
>  

