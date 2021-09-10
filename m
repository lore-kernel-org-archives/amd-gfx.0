Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9483FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B9D61026
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 14:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 34B9D61026
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27636EA01;
	Fri, 10 Sep 2021 14:19:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935176EA02
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 14:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo0MXy8aOi5FCYXA/k0TaxJ5lOXAHyhLbX+f+2wB8LvImHAuOPC34YBHPUJmPLlXQKzEMS72r44MStJV+ES9uqEPPPfJMPN9SF9qFYfZSRKUhS4llzVCi85DapcZfjSbB1xTr+5F2Xj/hKaqoZdnWT6fKGOc0YMZ66ZJXDR6/dItWxSvkcc38JrFTkXh8s8gh5ce8V7aPuk4ynnAhQGpbetqtGrN9jfj9dY7fqRDwfNV5AgNqStTJHoIY+0oI9wMvAu7sn5Z/WuC+e0oEqHxuBqceYJFP22IfbH5FfI9/yUD6ZjLp3xeSV6jooKwhsEu5jkgIdG1vfkzhnM03J2HqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=aUhCfO8RGYiJHRiEnaysCcUJ+JTBcehS2R8+BXeHmXc=;
 b=kGckVi+k/uMzEO9KbuMuLu6GKr4BxNrce93+PvdymF32HdReluaIGZtNh/HK30Xh/qc5vcNigpj9DctWg2Ykflezvrc3bEX5s93hJa07wkyUQk54+VXJ2Mh2eKS/hToTK7CeIPqAWrxbWzDJwS266o+SRIrH5EqVlfRx6bVWcw66fHAiAIlVY5tW+/3R+WypS3fObFt2PR329tKiSVQZR08hcA9Nwg8n6nHf64m+u8wL+4J2mcRllVE/owYdv42yxvHz24nr9PziN7PJvnZWZT/nP/uZk6GIa3DlKSRUDI+1Abi/k8EEnQWrz3XgywC7dDUjhWhObxZK9ZaKsax0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUhCfO8RGYiJHRiEnaysCcUJ+JTBcehS2R8+BXeHmXc=;
 b=Bcbcb0M+lVLPxIvZMvkqE+0pxZm5r/kgVvypjGXJ8GlE9wict5Sjq2c6vF2bJGfih4pAQwJFpDE/qo6UyP4kxTCEeZ9tEKUX0VJEQzvQobb5Xsw4D2y0NPJw0fSbWNw2yYyyHb39EB+1lKQC2E7aXebTfaVElhxI5Nvnhg3ywT0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Fri, 10 Sep
 2021 14:19:07 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 14:19:07 +0000
Subject: Re: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
To: amd-gfx@lists.freedesktop.org, "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
References: <20210910140457.26887-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <86031b43-4b0a-08bd-cbde-e072ff499bc8@amd.com>
Date: Fri, 10 Sep 2021 10:19:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910140457.26887-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::14) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YT1PR01CA0075.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.15 via Frontend Transport; Fri, 10 Sep 2021 14:19:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fedb9af2-c041-4620-8258-08d97465f302
X-MS-TrafficTypeDiagnostic: BN9PR12MB5131:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB513165DA67F87AA6F1C0058C92D69@BN9PR12MB5131.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZVPvHs5NYM6ZV0flhaGR5X4ibZqWeHhIWaf6D2EgI3oAMef1dvwQEUVSk/Mv0N/56L7VU8IaLOh5E4X8MwnDmD8OKq7krLhKvN6kTCuxpcv4hRLmMhZBVuWsyKycWBmpzVM/utwhv1L8V5iyuxAOzd+nKTwVxNL2Af4BCFUGCrmzR4nkeyufhXoaaAJxNvWn7xg9y8iusjrTgluSCHqXGwqJ45ZCIuGXuFFCEx8OV9WyJwXo1lhQTV6zOW+KioqZUMMZIFubFsHxV+L9rO+NbYWsJD9IkRvusHZYVuF+ouEFOTMEOsA5lDd0wapcAPAG0mCDHpHgUXnsr4F3ok/TxvvDFtXJat7UXl+g4QBwM0XTZZJH+CN1cAyceg70dwcRCq2yppL2D5vfHKwEPSVzNlY74dIi0jdufRTEHb5/q5wPu4g2+25YFNu39a3V/LIutPU6DdjZQl1duBfy4zk1n0ttPY88eANQaOvv6zZcutfEBe7RVINa0Rq4TXJWU8zC50u8yFj4K6MiVumTKg9vzJUVyjSdGvQIQ4km695EYHwYzsk8sJ8e0mK6/x49UO17VNSE8hfnYyN/+3v9UnmB/lciXMEFYKuVtHgFctcp+YJXJPN83XC5P3jEQfFbsNFh00HvL/f6b/1x94k5TxTSd/M5SnSxfanW7E5usfO0lP4szTDZCQk0EM6XI7Nh0coeFiLoCiyBXHeNjNwiOJtEvJ2ho9s64RCkDcGPZNiRcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(16576012)(44832011)(316002)(37006003)(2906002)(31696002)(66476007)(83380400001)(66946007)(66556008)(8676002)(6486002)(8936002)(86362001)(36756003)(6862004)(31686004)(5660300002)(186003)(2616005)(956004)(6636002)(38100700002)(478600001)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SCs2OU9odWl2UTVyZmVpQUtqcjIyZlJWcG9nbG4wd3d0UzZ4K3JHRVh6bUs2?=
 =?utf-8?B?Wi8ybWFxejZQTWpDZ210a0ZvTEVMMVZpeXQrYWlocG10ampKVnVPRWRJQ1lm?=
 =?utf-8?B?c1Yvc0hjWnNQZmorY2lobzhyRnlpNW5KQ1ZkZkFBYzRld0d0THMxS0g3WGdy?=
 =?utf-8?B?YllwYVBjbk1RalFxdU9TS0NVY1o1ZEJGZVFPSVNYNWJ3elROU2FvVFFxbk5V?=
 =?utf-8?B?eHorRVhMdlM4dVNtVm1ZclRuVmVwUTRNbDRHVHpuejdmcWtLc1dUUEVvODhu?=
 =?utf-8?B?U0kvSzJXN3lNUkgxVE40dWI1dE10US92a2hjbG51T2VXaWFtMExMeE5VWFBt?=
 =?utf-8?B?OU94MS9sWW5RSE5tSkhzanZLVFpWQlovMGZwUjZXK0M0dFlOZHZWaXEwRVNn?=
 =?utf-8?B?YXBpVEFmK2xOWkZ0ZitnWjdvQ3pDblBza2pTMEVvU2RPeFFjUkJ4NEJNdFRV?=
 =?utf-8?B?NU43UDZlT2VKMGhhYVlJMEkyclJ3WkQyTVNDUmhRU1lEaUZ3TnllKzMvR0hX?=
 =?utf-8?B?eWoxUFRrMGNLenV2MzVna1pCSDhtcFgwbE15anJYOXRyamtvTEdzdlFEdFBh?=
 =?utf-8?B?TGZRS0lOSEd6TkxmYVZLUlRTT2RMOEVVMmtvcDVkQ3RpY1dhbWRwNzRONjRv?=
 =?utf-8?B?SUgxSDNoTjNhNE5SUmFqL0Jjb2piREdTQytkV2V5eXd3a1Rqb1JuZUwyWTdU?=
 =?utf-8?B?VkcxUmxWSitWUk1DNUNDN0VMdG5qamhnYmJKK3BMWjdiVEJsaG1HMGdLYkds?=
 =?utf-8?B?UkxTdWM0aGtxZWxCSFFzWGlDaTN0TFdWQW5lcEl4djRLQW96SzVJYWQ3c0Vw?=
 =?utf-8?B?RUp6aHllN2w3YXVUaERhMUtYbUwrOXVrMGRWZ1R2c2YxcVNKZVZMZTgvdmJo?=
 =?utf-8?B?WVBNY01KTlRHZzNicExma0Y2NlJvM0t2N3hKRTBac0VXcmwzei8yRDNGK3Vx?=
 =?utf-8?B?NC9RS21BRDl5bFp1NmgyWVZpSm1qbkdIUEF2VWduaWNsb3R2MU1IZEllOEFr?=
 =?utf-8?B?NHpWN29GYStzUGhHZmlBU3Fxc1o3N2VLa1hMNkZQT3RpMzRzTitDMlVDVFh2?=
 =?utf-8?B?NHByUHVMM01WUzNuN1NFcjBhTzhtREYvZUN5R3BQb0ZLMU1jWjNJYzdONm0y?=
 =?utf-8?B?Q1RKMjExVysyN0duM3RyS2N1b21xcHdycTdidWgvV0pOazRFWHkyUHZEald2?=
 =?utf-8?B?bnhONStXZ2o0ZmMzbUNGZlRYYk1PQko1d0dOaGl0YUFTQ0ZYcm9VOFdFaTRP?=
 =?utf-8?B?UW9iR0pyODR2VzcyQzRnSlVEOFJ4c1NJTVhKT3NQTGVwaUVnQmE4T3I1UzNL?=
 =?utf-8?B?YUdYQ05kaW9wV3NJNHhUOVRGS1RDc0VBbGdMaG1CUmsrNFR3YjdLRDFtSlVp?=
 =?utf-8?B?c2luNzJzMW45VldFYyt0SUZ6RVc1SFM3aHFUVWM4V1RCSGUzQTJSTW9BekNs?=
 =?utf-8?B?QTBIeEZ0WUU4bDRZZ3VRSWRhSG90UVFKZmlOQ3AzRm80OUM4d25JNlhxeHNW?=
 =?utf-8?B?UFFGRDVOaWRzdlA3THFoK21oY2tlSHZ3aVQ3YkV5RVdmQ25tc1VUTkhVUXdP?=
 =?utf-8?B?dTFuMlpCRGIwc0RjbElUTUhhSTBGTDU5MG1PWEJ1eHlTa29UM1pHSWdDUWMv?=
 =?utf-8?B?ZEVOSEFkeGQwcDZmVmd0ZXR4Uk1CekxhWjdzYlRGdTZRMzNMK0JYQW1qbzAz?=
 =?utf-8?B?OEtXT0ZPbTZNQXBCNnBSam9oLzB4WXpKSVJqR2ZSaXNDY05EcTk4SlZQOGx2?=
 =?utf-8?Q?IoEfpzfZHHT6YqFRRJuPiEE6z8ZwO0StsD59t2y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedb9af2-c041-4620-8258-08d97465f302
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 14:19:06.8188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQHPpklAo9bxk0aKFWdVz0r+aSCZqqaRwhRGzs8Yybf5x8f/ZbvfdYaamX38YBNss9bK45Zu92fNRQVB6JARRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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

Am 2021-09-10 um 10:04 a.m. schrieb shaoyunl:
> The AtomicOp Requester Enable bit is reserved in VFs and the PF value applies to all
> associated VFs. so guest driver can not directly enable the atomicOps for VF, it
> depends on PF to enable it. In current design, amdgpu driver  will get the enabled
> atomicOps bits through private pf2vf data
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> Change-Id: Ifdbcb4396d64e3f3cbf6bcbf7ab9c7b2cb061052

Please remove the Change-Id.

In general, the change looks good to me. One question and one more
nit-pick inline ...


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 25 ++++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
>  2 files changed, 17 insertions(+), 12 deletions(-)
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>  mode change 100644 => 100755 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> old mode 100644
> new mode 100755
> index 653bd8fdaa33..fc6a6491c1b6
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3529,17 +3529,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
>  	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
>  
> -	/* enable PCIE atomic ops */
> -	r = pci_enable_atomic_ops_to_root(adev->pdev,
> -					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> -					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> -	if (r) {
> -		adev->have_atomics_support = false;
> -		DRM_INFO("PCIE atomic ops is not supported\n");
> -	} else {
> -		adev->have_atomics_support = true;
> -	}
> -
>  	amdgpu_device_get_pcie_info(adev);
>  
>  	if (amdgpu_mcbp)
> @@ -3562,6 +3551,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	if (r)
>  		return r;
>  
> +	/* enable PCIE atomic ops */
> +	if (amdgpu_sriov_bios(adev))

Is this the correct condition? I think this would be true for the PF as
well. But on the PF we still need to call pci_enable_atomic_ops_to_root.
I would expect a condition that only applies to VFs.


> +		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
> +			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_enabled_flags ==
> +			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	else
> +		adev->have_atomics_support =
> +			!pci_enable_atomic_ops_to_root(adev->pdev,
> +					  PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +					  PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	if (!adev->have_atomics_support)
> +		dev_info(adev->dev, "PCIE atomic ops is not supported\n");
> +
> +

Double blank lines. One is enough.

Regards,
  Felix


>  	/* doorbell bar mapping and doorbell index init*/
>  	amdgpu_device_doorbell_init(adev);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> old mode 100644
> new mode 100755
> index a434c71fde8e..995899191288
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
>  	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>  	/* UUID info */
>  	struct amd_sriov_msg_uuid_info uuid_info;
> +	/* pcie atomic Ops info */
> +	uint32_t pcie_atomic_ops_enabled_flags;
>  	/* reserved */
> -	uint32_t reserved[256 - 47];
> +	uint32_t reserved[256 - 48];
>  };
>  
>  struct amd_sriov_msg_vf2pf_info_header {
