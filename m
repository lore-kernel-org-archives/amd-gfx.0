Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173B4C7618E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Apr 2023 12:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0CB10E0BE;
	Fri, 21 Apr 2023 12:25:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FB2310E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Apr 2023 12:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuAneFFvHv+7ZUzCdDv8YIstlPZ56Ljcbrzt7jBkkg016Nfx7Jgt/xjRW2VZuJ6fjPGm4QnrhlmcU3J29QvgU8OoJLjteHjettmiFFeY75IMYD/b/FeYxALbJQ/4BGBX8BnueTHhisreOpIpvW9R1ingRa5N7iHNjsOVvN86o2U0/Jj0DpU0keaUvKMW1YJ10YQ/MCTVf0hchZftmVD7YEiUxvkUVVfUaMzHyA84vi3Pi8mqOI0cIEsgHRh52I4mG6HbYpIrmCteRuYoT3ib1pvQDwPkiLthrOAaF4zm19VgxdoVDlMM79Cuo8GKKTW4VGo/7LVFD9tUJioulHAPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTQGJ/ZnSC6TO+5Oty9hAfbdQ5u9aT0WgU411EN5b+s=;
 b=LVcqSuKXmsXJXV3Qsc+eX7oWm9LtShhb22MVbRZGqH7dbp1XGYQxAe7qshA7kTEgty6QTMwngI3OfV6IE/aoRjE+6QFIA7RWDLuKk6XeF5jQBuAAdhy4bQlSNX/ZHtBt/s9MUvzb9xK5ncGaMf0DhMTFcXNB7vKvu6oMZKQBATEx0Xn2dYjJlSGDCuVKnfUR4rKKKq319eNAXRjrGHj/7doM/2rOWmpyRIu81GwWlwRMaSWZrp2RRzdp9ZvPzhPmSLjcuGaxQJ8/kw9WJJeWjhGXM7ubL9OQ57DbB95/CfRr9BJQd2YsfrqraTAxVwiGgKVFggCaQKC6Z4MfhdOcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTQGJ/ZnSC6TO+5Oty9hAfbdQ5u9aT0WgU411EN5b+s=;
 b=Djn8X+XJ9TjevWqVDt0Yy+ZXWz9uoVgS3evhO7+kpE+i4DN9EQsZ+LufaZ3tPCk2mMXA6sTsEPKNMoxLpCDZEMOdRtGWXODQyFVIuJv1nlpX9Z1R7Mgi6HBS+ovhAhpKRO9F/xpOJT2I7D21JK9VBWOOY25XV/Sx542bRTjEApI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 12:24:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 12:24:59 +0000
Message-ID: <e5b462fa-bf1b-3b9e-f623-bb76df5fd2bf@amd.com>
Date: Fri, 21 Apr 2023 14:24:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/6] drm/amdgpu: Implement a new 64bit sequence memory
 driver
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230420144714.124377-1-Arunpravin.PaneerSelvam@amd.com>
 <20230420144714.124377-2-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230420144714.124377-2-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4609fd3f-b700-4ea8-2207-08db42636c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EuFvap93hmm8WYxaLa7w5oTYJWrbh4+FenQlzLY5iG0Cd4YuL0pPtaVvkPMORiNuvaifGY6jA/Wn+E0FDqKcWIk3jIypRHjvt6GSFjKmh52T4istWx6fBu0jzViWYqcVRmMQ2K+H3l2zj4UHSpUoJT8285JIXBab878H1C2IDuuLx9RsPbXvHvHWzG/t2XKrRKOmS9QFhQm1hvoeO29URhqFMO8D2r8GbPERUsxPOf0PTHSaXplDkAG1nSqMOHAo4xWVTR2C5aglKw9PJuqbIEsg5CR/om5barfPsw2uUWdp+Qadjd9ipNIUQBAsQySdzVq1t9N/Nf0pBZBWi3PWJkEKvdM9d0YU0znUpWowi8btc2RA99mnFZvClRFH3s8LrWMwoIXnO6cVHLu0ATj4AvotmUqel6wCGybUH3T1rHZAGjVV54EW3ZKeydO/4+hBj5C/boUZdon8v++ARoH+f4qXJsxeLsd4g4rl0mBGhEcF/5p8W5gh61XJEwLhuiyVU8RPerpntseLUxD6yAsRqw4aPFY3YeOhJW0I8KG8SpUCzRlr9fX4YBoe32Q/23oROsRXvnjLg5Q3K42F6jbZQq2Kn9wFS5J5B/Ef51KLNyG5kLtNXcw8/5jOEsPgH1wu69/d2Q6l3U5nQs3B/QoOCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(83380400001)(2616005)(478600001)(31686004)(6486002)(6506007)(6512007)(6666004)(316002)(66946007)(66556008)(4326008)(186003)(86362001)(66899021)(5660300002)(38100700002)(66476007)(8676002)(30864003)(8936002)(2906002)(41300700001)(31696002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emR0dWpPZFBLQ0hEWU5NSnZBVWY1dEh0RHZoRU5CRk5lVk91Tm5SbjVMbWZl?=
 =?utf-8?B?OHdrM3VzQTVoS1YzWUVaSWxDY0dQVFRGQmxyblI3cDFHV3dVc1lQckcrN2pN?=
 =?utf-8?B?ZlJwS1pJck1PaTNRalNiWTdMZVVNZVI5YUZLcVd0NzdJcGdROXhLQXh4SkR6?=
 =?utf-8?B?aFRDY0hnbGdTNVdRa2dha1NUcENrL0tHbW85MHJrTjY4WWw0M1kzVGRiem1h?=
 =?utf-8?B?bTB5ZXpRSzNCaVFjZEFSZmYzQlp2alJlL2ZuWjIzWjVrdlBUU2ZxSHlMN0Zh?=
 =?utf-8?B?MnZxWWwyaU1KUGJIelF4eitLQUVjVnVOWmllaG5ZMzBaYmdFM0NKM09naVFp?=
 =?utf-8?B?RDE1SGQ0TkduRnd1RXJack1RUjhCN1JWT2NVdDMrUmhZTXNVWTJQNmFhcm9M?=
 =?utf-8?B?NHJYTURkVUkxSDQ1cGllaGU1aE12QXd0NjBTblFETUFDQUpadXE4RlJ4d0xs?=
 =?utf-8?B?dXZoWDlJbEYwRDhYYkNpaHc5RkNvYzJTR2FRWlR6OU1nOTE4ekJ5V1QxNUFu?=
 =?utf-8?B?NG9WbDE0Q2RjajhGUzRUdWd2akhpTWFtR2MyMG1UUFNzaGNrTUdPMnJQVnd2?=
 =?utf-8?B?bWpoRWs4SFAzK2ZmNEVRbEp4VVhsaDRvbUdWZUVmZ3QrYURhWXovcCtRS1hH?=
 =?utf-8?B?SzJ5TFZmN0tSS0xCVlRHUDRFelVjemd6MnRFQzJ2dWdUbzNvSTBiYnA3bkMw?=
 =?utf-8?B?azJrcWdETWZvTThPbCtISURSbTlKVFhTdlpDWUJKbDd6WFEvM3FLcG5FQjEy?=
 =?utf-8?B?QXRXeXEzR3B4S2J2RGlySktaOXBxU2Y5amE2a1NDUGlpcE1LSnRVcUZQTmhv?=
 =?utf-8?B?c2ZHb2lxOXh3VWt4T0ZEUmN4QjhBN1M1elJXOWtNdmZ4VmlzUWNnaFhaWmRq?=
 =?utf-8?B?T1gzaVNzRTI2VlZ4UmV0QVk0VmdKRjQzUFVlUW1Ud01MZ2hHSEloaE5zUlZj?=
 =?utf-8?B?UGNsMmgyRVUxeElpWkhSNVVEVHB1V0x3N0MrMnQwYmlUZ2p1RlY0SXoxODBr?=
 =?utf-8?B?ZWpCWFhEY0FXWFBRNGJaSlVUWFR1QWp3L21aZWlzSnMzWTc5V1pGSFpQKzdX?=
 =?utf-8?B?Uzc5UXZxanZGMlBRRS82TWFvd2VzeUhHS3RXQXJnUHFCUzBNTENJZ1Q3R2Fm?=
 =?utf-8?B?VHlnclNyNlErS1pueFoxdithN1BmQ0tlU1puMllhcU1ZdnVyeDdRZ0VqS293?=
 =?utf-8?B?WlY0ekFBc2hESE54ZkdlOTlmSWJOQ2tFb29mbGpuaEp6OXM1QThmU20wazdr?=
 =?utf-8?B?ckp6K0sra2drQUNuVE5hV2dmcEhZbDFWb2MzMzdhVXhnR09HMkkxdmVtWWZr?=
 =?utf-8?B?WXVjekNVTWVUSmJPYUZaVVl1SEJTQnNBV2xWTXcvTktJVERSbVRrZ21SdnBU?=
 =?utf-8?B?OEhKR25KZy9IelJLMWZaQTZxQXRsclhjLytXSlZ1cEdtMnhWeGl5dTU3M2NO?=
 =?utf-8?B?TjU2d1FTWWpEelhCRk5zMWg4UFB4a25UUG9OOElJbjRlL3NRNnBOaitkZDlr?=
 =?utf-8?B?RXR0Q29PVUpxalpIM3ZQcmFFY04rVlZlYmxsR3hoY3VINHdhRWk4U1hqRVRy?=
 =?utf-8?B?c2RPYjB0V2pleVlRbHpMMkxZRmliYzl5T3JGWldqNzh4Nmh4WjVlMDZhMG1B?=
 =?utf-8?B?S2wyeVY1eDVRTytMajJHNjZXaDZJbktyOHlyNFh0TzZ4anY2WC9rUG5kOGRF?=
 =?utf-8?B?YmRmQzc3UE40OXFJbTVQc2ZYWWJjTWRnbnd0Y3l3cjZBK3ZqS245ekZLSFph?=
 =?utf-8?B?RFZnN0JnazJCa1R3TktxbFVQMGw5a0MwZnFndUJvMTBaVVVDWUNOQnRlR1hr?=
 =?utf-8?B?SnppV3JuZjdGYXRsMVNGWThBcnNNUjI1cjV5TmdHdjU0OXN3cm9CYUw3ZUtZ?=
 =?utf-8?B?MDlYRmpoa3FEMndXMnBobjhHUTlscVRiOVdBOU9BVm45aGI0UVQzY1VjeHha?=
 =?utf-8?B?QnliQnF6Vmx5a1FONFViQ2I1TW1wajQ4Y2Q0WTlWVVpDVlEwYytsK1lTYWVp?=
 =?utf-8?B?bmtkWkFCWG8yZEtxQ1VmK1kyKzBCaVVmNEltWTd2c3VBczE4dUJ3alYwYS9Y?=
 =?utf-8?B?VE5TeEZlb0FkcktMTzNPdjN0ZFVndllsR1NyRzFsV1ZERDczTDdmaS9wSis1?=
 =?utf-8?B?TDEzNUFVMjM0Qm9mWUY5aUloWE9SYjQzRWh1Z0RCL3JYTHEyQy8wd1dnTWgx?=
 =?utf-8?Q?t+kbSfRlHKM7biQudhF6WO9vQ9ROydiWxEPwQXbMw1C8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4609fd3f-b700-4ea8-2207-08db42636c94
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 12:24:59.7306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FKL8Fr5vZQo130PdGccUnr8t3UO0lARs+Iq4J2FaPSpTnZ97HW6HnrLRNf+ytm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.04.23 um 16:47 schrieb Arunpravin Paneer Selvam:
> Developed a new driver which allocates a 64bit memory on
> each request in sequence order. At the moment, user queue
> fence memory is the main consumer of this seq64 driver.
>
> v2: Worked on review comments from Christian for the following
>      modifications
>
>      - Move driver name from "semaphore" to "seq64"
>      - Remove unnecessary PT/PD mapping
>      - Move enable_mes check into init/fini functions.

Please just drop the enable_mes check. We need this functionality for 
the TLB counter as well and that is completely independent of MES.

One more technical comment below.

Apart from that looks good to me, but could use a little bit kerneldoc.

>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   7 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  13 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c  | 158 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h  |  48 +++++++
>   6 files changed, 232 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 2cc7897de7e6..d39504e65db1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_doorbell_mgr.o amdgpu_kms.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>   	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> -	amdgpu_ring_mux.o
> +	amdgpu_ring_mux.o amdgpu_seq64.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c5f9af0e74ee..3bc8a2d35bb3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -109,6 +109,7 @@
>   #include "amdgpu_fdinfo.h"
>   #include "amdgpu_mca.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_seq64.h"
>   
>   #define MAX_GPU_INSTANCE		16
>   
> @@ -486,6 +487,7 @@ struct amdgpu_fpriv {
>   	struct amdgpu_vm	vm;
>   	struct amdgpu_bo_va	*prt_va;
>   	struct amdgpu_bo_va	*csa_va;
> +	struct amdgpu_bo_va	*seq64_va;
>   	struct mutex		bo_list_lock;
>   	struct idr		bo_list_handles;
>   	struct amdgpu_ctx_mgr	ctx_mgr;
> @@ -950,6 +952,9 @@ struct amdgpu_device {
>   	/* GDS */
>   	struct amdgpu_gds		gds;
>   
> +	/* for userq and VM fences */
> +	struct amdgpu_seq64		seq64;
> +
>   	/* KFD */
>   	struct amdgpu_kfd_dev		kfd;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7f8fcac4f18b..828d0dd1455b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2253,6 +2253,12 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>   					goto init_failed;
>   				}
>   			}
> +
> +			r = amdgpu_seq64_init(adev);
> +			if (r) {
> +				DRM_ERROR("allocate seq64 failed %d\n", r);
> +				goto init_failed;
> +			}
>   		}
>   	}
>   
> @@ -2709,6 +2715,7 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   			amdgpu_device_wb_fini(adev);
>   			amdgpu_device_vram_scratch_fini(adev);
>   			amdgpu_ib_pool_fini(adev);
> +			amdgpu_seq64_fini(adev);
>   		}
>   
>   		r = adev->ip_blocks[i].version->funcs->sw_fini((void *)adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b16b8155a157..d89f321304df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1183,6 +1183,12 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   			goto error_vm;
>   	}
>   
> +	r = amdgpu_seq64_map(adev, &fpriv->vm, &fpriv->seq64_va,
> +			     AMDGPU_SEQ64_VADDR_START,
> +			     AMDGPU_SEQ64_SIZE);
> +	if (r)
> +		goto error_vm;
> +
>   	mutex_init(&fpriv->bo_list_lock);
>   	idr_init_base(&fpriv->bo_list_handles, 1);
>   
> @@ -1250,6 +1256,13 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   		amdgpu_bo_unreserve(adev->virt.csa_obj);
>   	}
>   
> +	if (fpriv->seq64_va) {
> +		WARN_ON(amdgpu_bo_reserve(adev->seq64.sbo, true));
> +		amdgpu_vm_bo_del(adev, fpriv->seq64_va);
> +		fpriv->seq64_va = NULL;
> +		amdgpu_bo_unreserve(adev->seq64.sbo);
> +	}
> +
>   	pasid = fpriv->vm.pasid;
>   	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
>   	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> new file mode 100644
> index 000000000000..bf43856cebbc
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -0,0 +1,158 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_seq64.h"
> +
> +void amdgpu_seq64_fini(struct amdgpu_device *adev)
> +{
> +	if (!adev->enable_mes)
> +		return;
> +
> +	amdgpu_bo_free_kernel(&adev->seq64.sbo,
> +			      NULL,
> +			      (void **)&adev->seq64.cpu_base_addr);
> +}
> +
> +int amdgpu_seq64_init(struct amdgpu_device *adev)
> +{
> +	int r;
> +
> +	if (!adev->enable_mes)
> +		return -EINVAL;
> +
> +	if (adev->seq64.sbo)
> +		return 0;
> +	
> +	/*
> +	 * AMDGPU_MAX_SEQ64_SLOTS * sizeof(u64) * 8 = AMDGPU_MAX_SEQ64_SLOTS
> +	 * 64bit slots
> +	 */
> +	r = amdgpu_bo_create_kernel(adev, AMDGPU_SEQ64_SIZE,
> +				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> +				    &adev->seq64.sbo, NULL,
> +				    (void **)&adev->seq64.cpu_base_addr);
> +	if (r) {
> +		dev_warn(adev->dev, "(%d) create seq64 failed\n", r);
> +		return r;
> +	}
> +	
> +	memset(adev->seq64.cpu_base_addr, 0, AMDGPU_SEQ64_SIZE);
> +	
> +	adev->seq64.num_sem = AMDGPU_MAX_SEQ64_SLOTS;
> +	memset(&adev->seq64.used, 0, sizeof(adev->seq64.used));
> +	
> +	return 0;
> +}
> +
> +int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		     struct amdgpu_bo_va **bo_va, u64 seq64_addr,
> +		     uint32_t size)
> +{
> +	struct ttm_validate_buffer seq64_tv;
> +	struct amdgpu_bo_list_entry pd;
> +	struct ww_acquire_ctx ticket;
> +	struct list_head list;
> +	struct amdgpu_bo *bo;
> +	int r;
> +
> +	bo = adev->seq64.sbo;
> +	if (!bo)
> +		return -EINVAL;
> +
> +	INIT_LIST_HEAD(&list);
> +	INIT_LIST_HEAD(&seq64_tv.head);
> +
> +	seq64_tv.bo = &bo->tbo;
> +	seq64_tv.num_shared = 1;
> +
> +	list_add(&seq64_tv.head, &list);
> +	amdgpu_vm_get_pd_bo(vm, &list, &pd);
> +
> +	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
> +	if (r)
> +		return r;
> +
> +	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
> +	if (!*bo_va) {
> +		r = -ENOMEM;
> +		goto error_vm;
> +	}
> +
> +	r = amdgpu_vm_bo_map(adev, *bo_va, seq64_addr, 0, size,
> +			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
> +			     AMDGPU_PTE_EXECUTABLE);
> +	if (r) {
> +		DRM_ERROR("failed to do bo_map on userq sem, err=%d\n", r);
> +		goto error_map;
> +	}
> +
> +	r = amdgpu_vm_bo_update(adev, *bo_va, false);
> +	if (r) {
> +		DRM_ERROR("failed to do vm_bo_update on userq sem\n");
> +		goto error_map;
> +	}
> +
> +	ttm_eu_backoff_reservation(&ticket, &list);
> +
> +	return 0;
> +
> +error_map:
> +	amdgpu_vm_bo_del(adev, *bo_va);
> +error_vm:
> +	ttm_eu_backoff_reservation(&ticket, &list);
> +	return r;
> +}
> +
> +int amdgpu_seq64_get(struct amdgpu_device *adev, u64 *gpu_addr,
> +		     u64 **cpu_addr)
> +{
> +	unsigned long bit_pos;
> +	u32 offset;
> +
> +	bit_pos = find_first_zero_bit(adev->seq64.used, adev->seq64.num_sem);
> +
> +	if (bit_pos < adev->seq64.num_sem) {
> +		__set_bit(bit_pos, adev->seq64.used);
> +		offset = bit_pos << 6; /* convert to qw offset */
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	*gpu_addr = offset + AMDGPU_SEQ64_VADDR_START;
> +	*cpu_addr = offset + adev->seq64.cpu_base_addr;
> +
> +	return 0;
> +}
> +
> +void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr)
> +{
> +	u32 offset;
> +
> +	offset = gpu_addr - AMDGPU_SEQ64_VADDR_START;
> +
> +	offset >>= 6;
> +	if (offset < adev->seq64.num_sem)
> +		__clear_bit(offset, adev->seq64.used);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> new file mode 100644
> index 000000000000..e9b0afa9c5aa
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_SEQ64_H__
> +#define __AMDGPU_SEQ64_H__
> +
> +#define AMDGPU_SEQ64_SIZE		(2ULL << 20)
> +#define AMDGPU_MAX_SEQ64_SLOTS		(AMDGPU_SEQ64_SIZE / (sizeof(u64) * 8))
> +#define AMDGPU_SEQ64_VADDR_OFFSET	0x50000
> +#define AMDGPU_SEQ64_VADDR_START	(AMDGPU_VA_RESERVED_SIZE + AMDGPU_SEQ64_VADDR_OFFSET)
> +
> +struct amdgpu_seq64 {
> +	struct amdgpu_bo *sbo;
> +	u32 num_sem;
> +	u64 *cpu_base_addr;
> +	unsigned long used[DIV_ROUND_UP(AMDGPU_MAX_SEQ64_SLOTS, BITS_PER_LONG)];

Please use DECLARE_BITMAP() instead of open coding this here.

Christian.

> +};
> +
> +void amdgpu_seq64_fini(struct amdgpu_device *adev);
> +int amdgpu_seq64_init(struct amdgpu_device *adev);
> +int amdgpu_seq64_get(struct amdgpu_device *adev, u64 *gpu_addr, u64 **cpu_addr);
> +void amdgpu_seq64_free(struct amdgpu_device *adev, u64 gpu_addr);
> +int amdgpu_seq64_map(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		     struct amdgpu_bo_va **bo_va, u64 seq64_addr, uint32_t size);
> +
> +#endif
> +

