Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E78C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 13:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A98EE10EE2F;
	Thu, 30 Mar 2023 13:42:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2423110EE40
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 13:42:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAanU26n5hgUzA5hs4S9IelebXX4jLxdO9nTyDxW5kcFh3fDQ3P0ElhkfNFj4lZmZ9vfeobHLQdbh4hI+YipRa/wZ6wCcvb82KMYpOLLhpA4Qm/zkXNRBG5okeKvN5S39mbGOUMJp91DtDrRkZtCD1O3DVlh3SyXOmS2reoggVp6HzICQ4lvAYRzRUwV1PpO60WNLn8fk40g7qGkQMXf+tBHGQJJR5ksHfvtR0eLIgejQNwxDAjpfNBPgmHgkAAoChPV51nHambfBeqzn2aDD+8KU4Gx9urSnj0apHd2FXZf/ehsCD5+ELagpkO2XSHLdUVN2fY9tn5+RgQDb+qSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bF7nLiyQLw4rwQ9eGD0k9AyuNBYZTQihmLGsBdXcVdU=;
 b=CiZtPY12PNKYNEcJCDnTP37MHGI2OPsRMTIhjsg4ynC1yukFXFoI2nJOkdW3riDAa4Wi9+qckdSriw+UROOsuCtE2UZKGHk3pK01+JiO1Lz5dnEtASRcuW2P8Udi7xCt3/AcyByVPiG3H6KsAvzel0g8/kCfBsoidFwSBkllC2YOHkiJ1GGLGkr8q5U8L9q5Tlx0mqAgghL+j6e+o9lEVTiq57/pe3DKI2mAyY25LIzxl8s8IKqfx2PgGxABDGimpWWrLQOKOnLXYfzFp9eGJJ0x0/36Oa+IzRFd7uYZogIO97BRy7dqAfToadEyOu3W6O4GRnnQbZPtXl4lGTgtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bF7nLiyQLw4rwQ9eGD0k9AyuNBYZTQihmLGsBdXcVdU=;
 b=yku/Jg8SBjA0EncXwI99r8foXJDr/0/PWYM9NCI+QRh9n8wDKDhF+YDSyqQ4MFpDatoRhXF3wdqSSLh6z2uW4TNeAUkjgsIDYJPzTVyD9CbXPbUFKAqP6S2jUlMX4kV13pTumRSdWBHJc7NhWfvI93K4hKRCTwDmt8enEUgnT7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 13:42:37 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 13:42:37 +0000
Message-ID: <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
Date: Thu, 30 Mar 2023 09:42:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
In-Reply-To: <20230329154753.1261-8-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0217.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::22) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa824b1-b5fd-4a77-fde9-08db31249ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wztsfBUZr6RbXU2mRmYopbcqGusSLsAzAi3BQtlV9i0QA4X0ICfW5MM+ZKEVhHOBFXGCs3GWt41+90I7zyhmnL5HuKcPpgeGrZLB89/UvewmKi+F7n+wNb89YsAZC1XCs3gOzMF5FCmCqZj3XI37Bz6oQtmG7EmIndUB2h5U6xyBmCclIExU3h4qSUacnZWF8/Sa2AK5Xr94OToCMEGjhUg14NqkBT0ShkCkZFvZOUEAt4plUthGrJ3xUUIp/ZbY/kvpBPPIl5yMHw5q8OysbPl3mlccHLyOeaJLfTcPjzcVeZsdL/SX0ot3dO9egP28PeiFxYip67Lu/iI6soxko+G+MkvywZDgVx2qA25lTfhBgp2Tnjrm9sR+q1NhWu4/UiHGPLZ5CbfN0yNyaXu7b+fyQ2YPTk0QhpSZAYS9VMnYZ5CeqX+CI1hjBw/JLSTUBet0Bnqhv3qFsc6MvpiQA6hvMH4tOzC7NtKTIev7ZsW61m4ctnZygrQlJsgRnJAydwdchPYxhvKnLTMITqnvROGMxqMdlNNO4m2q4CtTyNU60XkTh07z2ezrxOElVznNrJUGZloVdZ01gjdL26pJJonj66jCN5RpQIHygO5ZCN0VmJcUX9URzaTnolNeZmgbkEiM3Ts4p/wH2ypgPrNPUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199021)(2616005)(6486002)(316002)(478600001)(186003)(6506007)(6666004)(26005)(6512007)(54906003)(53546011)(2906002)(5660300002)(44832011)(8936002)(36756003)(4326008)(38100700002)(66476007)(8676002)(31696002)(41300700001)(66556008)(86362001)(66946007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2JRMzF2UXkwVFdKUWNMR0lsalRvTUlIa1RCZWhLTHhIdlI2bUJYemhjeGh0?=
 =?utf-8?B?eVdWYWRZZVJqK3ZYSHdkcG9kNDUzVGhkUTdHUnA4cStvU0ZMT21LekpmOVFn?=
 =?utf-8?B?VE11ZGk0OHh2UklOY2h4YzNab0VXTGN5UThhcnNaTWZ1SG83MjUvdlhsQ2tp?=
 =?utf-8?B?YkdiMUlkNXV6aWRDSmFNbW4vZmVaeFdHV0ZWUFlMUWo5Z05iOWcybXBnUzdE?=
 =?utf-8?B?QzUrS0lsbHFBelpyc1hnSlp5NXc5bUhTdzFDREJlWGROSU4vN3YweWxPc2l2?=
 =?utf-8?B?K3NuYURvWXlqTW5tdGgwcTBVMlVDVGpyTmZtTVgvbmh2N2FscFYybHVINldD?=
 =?utf-8?B?VzZuZmhwRDI0RVl4OUZFMGJLTE5Jdnd1RmlhVDNIQkYwck9iU0h2TW5hUTZP?=
 =?utf-8?B?cDU4OU8yMS9UTmM0NXZUelk0bWFmT20xOWVmKzVDRHBQVFRaWFJZK2plRHN3?=
 =?utf-8?B?Z1ZLWTU0RUl5U21zR2NoanhpVHVBMHNsamZXa3NEa0lHWTl4NWJmcWZ0OHZ2?=
 =?utf-8?B?MnNwbmFsRnU2Q2pnVTZqTm81djlZY3NHK0x4Slh3bHVQMVYzd0tGVUhmMGJT?=
 =?utf-8?B?ODlRcVVwanFUTkxoTGR1cFh1K0NoUHI4RGxaTXdlSER3YmJoV29ldlo5SEJq?=
 =?utf-8?B?RGE4VnRoMUI0amZLQ2Q2UDZZT2k4L2d2Q3A2cEt2eldXd1F3R1p3bERMV1l5?=
 =?utf-8?B?V3E3dXpNWnh3dXh0YXhxajEzTWFyakQ3VThrdHdSYzZOSUxqWk5QWXlzdGZw?=
 =?utf-8?B?U3BQYWNyeHpYVEUxS3ZWK3dJdVZlQTd0OHhwYiszU2lOekFZM0oySFFld2tj?=
 =?utf-8?B?QU9lZGFKQis2RE8xR2xvTStOL3BNYlZGZ2pvZWNYRGovMDVIWE5sbGNrcXd3?=
 =?utf-8?B?QUYyQzRoVG5PWDNrVnYrSFVEMXZ1Qyt3Yy9PTVBiYzlMZVNMaWFxVVBUcnZo?=
 =?utf-8?B?ek90bXFKWTNjdzFxYmYxQXdSQlBOWnRKSklHVWxhN2d1RFJiL2ZIczlDWVBZ?=
 =?utf-8?B?MzUvVVY3SUFkOWtFK3BVdHBOSWZPdE9kdFIrUUo1MTh3WW9qbFVYWWhodTlE?=
 =?utf-8?B?b2c4Qis1TEVKZ3QwNFlTTTFUdGh3b1loYlA1eWtKWDFKYXdHdmx6TGx5NEtG?=
 =?utf-8?B?Snc1YlpXL2wrRXcyUi8zQVJXNkcvYk9jNVZqZjhFdk9zcDdWRmFWdTI1U2to?=
 =?utf-8?B?TTRlWXROM2tOblE2aUFRRDBjNWpDVXZobjl1ckRTZHpFL3dmRmZVVFYyY0NF?=
 =?utf-8?B?SU4yLytrKzJpYVFXWEdERFh6Q1RBL1N1bXNrTVM3TlRSUEtsQzcxUU1oYkVw?=
 =?utf-8?B?cEdMem9zQW1MQkNNSlp1SmxFRHFFcmpFMHhTdkVWeUpqd3lTb1d1RFJFR0Vy?=
 =?utf-8?B?d0pvZTk4Ly80bHMvNnR4OG9CeFVlMTArRVVVVWFKZTNmbVJidE5FZ2JQb1VR?=
 =?utf-8?B?ZTQrRnE4L09kL0l1UjZqcWM5YjB0TkFUMjRkazBwY3B4K3VpSWl6L051OGN4?=
 =?utf-8?B?MUlBTjBuSWt6WTBkTkMreHNBUE11WjFPR3dJVzRoR2VCdlJDMWZDZ1puc2Rm?=
 =?utf-8?B?QXNIR3BCZDhHMWd1VE00a0k5dnpxYmJuaHpIUmtIVjRJa3U5dU90TnRVWE95?=
 =?utf-8?B?TitKc2F3Q3JJalduTWtWdFBNMk96Rm5MTnprMnZOVFVCR1BvWkNVSXBDTC9B?=
 =?utf-8?B?bFUrd0ErMUJIeWJOd0hzaGRZUnB6SVl4QWVUbWtnU3A0SU1iTGxsTWlVUzN5?=
 =?utf-8?B?a1M5RHppSFhGQ1pNYlMxem1BUWdyNFUzMDMza3dVQlFFaW91cFpxdjhxNkkw?=
 =?utf-8?B?dTg3ekdRcnl6aGhoQVozMzMxN3FldTJINEM0Ty9JR3ZSaXlzZDRHMm1xUk5j?=
 =?utf-8?B?MlBPZHlDWlkvcHFvVnAxUERRUDhCRHdkRW41bVhYdklMRFZhaGNJMEZPVTE1?=
 =?utf-8?B?ZUNheWxZbGZRenlMTFFrNzhyVTFKMUV2cXVNVElpUk1FVnkwUWpUY2dzVXJx?=
 =?utf-8?B?bFRpczVYKzQwTUFaN1I1ZlgvZnc0RGEraFdqYUJTRkxvTko3QUp1ZkxjZXRp?=
 =?utf-8?B?VVBxTkpUQXk1dk1oai9XL1hoRFVrR0JtR3JMSmZkelI5SkNhVktkM2poTzdm?=
 =?utf-8?Q?QqB7yLYf/FNjYVTRDLbwQ2QC3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa824b1-b5fd-4a77-fde9-08db31249ff9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 13:42:37.7518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbwL37kpfehwM63lYgy5i9YpwMmFnd7tyzqOCkZ74nKp8bL4XGTKIupmrLbVnUoF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-03-29 11:47, Shashank Sharma wrote:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
> 
> This patch adds helper functions to create and free doorbell
> pages for kernel objects.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index f9c3b77bf65d..6581b78fe438 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -27,6 +27,24 @@
>  /*
>   * GPU doorbell structures, functions & helpers
>   */
> +
> +/* Structure to hold doorbell pages from PCI doorbell BAR */
> +struct amdgpu_doorbell_obj {

In the comment you say "Structure to hold ...";
it is a C structure, but then in the name of a function we see "obj".
(Object is something which is defined like in memory, i.e. it exists, not
something which is only declared.)
This is just a declaration of a structure, not an object per se.
I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".

Then in the definition, you can call it an object/objects, if you'd like,
like "struct amdgpu_doorbell *doorb_object[];" then you can say
"db = doorb_object[i]";

Regards,
Luben

> +	struct amdgpu_bo *bo;
> +	uint64_t gpu_addr;
> +	uint32_t *cpu_addr;
> +	uint32_t size;
> +
> +	/* First index in this object */
> +	uint32_t start;
> +
> +	/* Last index in this object */
> +	uint32_t end;
> +
> +	/* bitmap for dynamic doorbell allocation from this object */
> +	unsigned long *doorbell_bitmap;
> +};
> +
>  struct amdgpu_doorbell {
>  	/* doorbell mmio */
>  	resource_size_t		base;
> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>   */
>  void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>  
> +/**
> + * amdgpu_doorbell_free_page - Free a doorbell page
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: previously allocated doobell page details
> + *
> + */
> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> +				struct amdgpu_doorbell_obj *db_obj);
> +
> +/**
> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: doobell page structure to fill details with
> + *
> + * returns 0 on success, else error number
> + */
> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> +				struct amdgpu_doorbell_obj *db_obj);
> +
>  #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>  #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>  #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> index 1aea92363fd3..8be15b82b545 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>  	}
>  }
>  
> +/**
> + * amdgpu_doorbell_free_page - Free a doorbell page
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: previously allocated doobell page details
> + *
> + */
> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
> +					struct amdgpu_doorbell_obj *db_obj)
> +{
> +	amdgpu_bo_free_kernel(&db_obj->bo,
> +			      &db_obj->gpu_addr,
> +			      (void **)&db_obj->cpu_addr);
> +
> +}
> +
> +/**
> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * @db_age: doobell page structure to fill details with
> + *
> + * returns 0 on success, else error number
> + */
> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
> +				struct amdgpu_doorbell_obj *db_obj)
> +{
> +	int r;
> +
> +	db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
> +
> +	r = amdgpu_bo_create_kernel(adev,
> +				    db_obj->size,
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &db_obj->bo,
> +				    &db_obj->gpu_addr,
> +				    (void **)&db_obj->cpu_addr);
> +
> +	if (r) {
> +		DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * GPU doorbell aperture helpers function.
>   */

