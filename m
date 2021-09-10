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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40089610C7
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 19:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40089610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F756EA89;
	Fri, 10 Sep 2021 19:28:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C12B6EA89
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 19:28:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ask8voJpcKwScPFxAu3BEyr3ylm3/4PYHBgbMRHuxjoDUhOBzlKAbJ04l+nxDOugQ93zRozrn4i3BeYDzzwhiOVqNK/Uixo/cp/Z64qqKSokvBulOw3BUpscsIHNhPw+C8y3mhTNOizt3MShPJpWy7vDRJ4PknKGzjDMbpy3+TRZWX1eRZW+9OkVznX2pz47AwuQa5QUXfilMv2m0J9g0BmjZQDPa3QGk5yfgZjXk/LIOswEJcFChmcjyawyx6NMsQgojLC1ovwuUFNpbnQ/Dz/OvuW8skP48jOtDS+4lZPUCSpKbpo3TQOvDA+3X3SoBzvIEDY89tCFJiTGK72IUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=sc6D1HqmwkGUKvlPUKBRiCgs0ZKzBAgEWTCAM9TD/WY=;
 b=cMt/SCHPYbV7EGkFfC7S1MvB5GbQoGtINlSRjtP/HI+BVFt5sXXmhIJbgh2KF98CBinN4WXTaE1Ax2zDtV1zdvb69ZkCf9X+68hnSrpYSpPkHIBA6TsKRHEjNbi7nilXxHau4N7nF/7S/QZnmgNcdqxvimTd25J4R1bmAuhxb0aQeuEcwG/RO2Y4Ix1q9nfT0Ew6t2XN9d9BIhOsQtndhIDkuKsFS63lJrDUYDiYqTTbwQtLqp58gLzOI0x7ZV+MHaj+FR6U2NmLxbqAX+gGleSAL9z+EPZQEcBmvBdodYMqalTVIkY34/fWovAtwTugHSZryOQcOtfPUpuMNRtp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc6D1HqmwkGUKvlPUKBRiCgs0ZKzBAgEWTCAM9TD/WY=;
 b=H5STqN97BYni4NdgkGC1onpNUMjhS4fazREtL0LGDIdYJYoDfL4WNd1INuV2KG5ZY9Pph4T90Stoccn0uIvOycMi84JD7v+rHpD6fHDfE04Uvqs50GzZiMRMLyKFczokhctX6LK5TF7MLkUtdVrrMDxuZzlyifN5+23KeNMCCXw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Fri, 10 Sep
 2021 19:28:03 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 19:28:03 +0000
Subject: Re: [PATCH] drm/amdgpu: Get atomicOps info from Host for sriov setup
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210910151513.3490-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <c412d0e0-046c-389d-5719-84bf369cfd7b@amd.com>
Date: Fri, 10 Sep 2021 15:28:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210910151513.3490-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::9) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT2PR01CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 19:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abb6b860-7cd4-4113-b3ac-08d974911b81
X-MS-TrafficTypeDiagnostic: BN9PR12MB5129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5129D7C1AC67F02F535FD59F92D69@BN9PR12MB5129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LEQG6yS2vCplK9SQr4bz2bq+ejsAvmCgvIhzSDCWJ+5n0V2vDWHtuxP5tYKxs7XpvCFgwGF2PMHlgDTGeS8Lek+ldJJjlQCy1xnz0Hf8rBFoPSyunBYi5WdV26azz57SSGz2giCbufTkbu3lOl4T0mBc5jec89ccuvibqueELXIqLNW32cEKCKRxmej0+VzGfbzejIfsvQkz0Pj2Zp+27CW6n0xLrlWFQxQChkjuFpT0O9Pul9myM3OGOXNdcgxvDNOkO1EZxS4rIWqgVf8ci5qbDunRleLkUp/Gllwu2sOMMHErOm2EQZjVBu8Z/6pvfA572JVff/3SLrsAPr77NcM4lQ7y1l82X2gPvE0jT84pouyu0kmG9z8mG6rlZxecQ3ITgj40dmY/XiNOj/em5CVTsQ3yN0f3tjZPNNKnzET+c4moV6FZu4Segepur1vUXXRiD5RAfjsmtIT/xAWjPNryIRh/EoYVI0DlFcQPqb7snInT/w1PRPgeHw+8DsrZy6AbWagtpLl4J/sB+grqvXURe5991eYtovwEViNEdpjYL6Q7wwr3+RWny1pamDnays9dXByEiubbFOJZ3VeWMwQB4ZpgBAfrSLXjLuv7xb33FUVTVnWXb31gcqHwqC8o1sXZy8q9BdVTJv9JZJwZw8QmStchfdtn04jz36E9zSlODOMfpjYqhrf1mZ7ezxU44wuVFK+2Wr+p1kktEXegyk3v6BFhG7XzcnLPV8y0AE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(2906002)(5660300002)(8676002)(36756003)(53546011)(86362001)(26005)(478600001)(83380400001)(2616005)(956004)(66946007)(186003)(36916002)(44832011)(38100700002)(6486002)(16576012)(316002)(66476007)(66556008)(8936002)(31686004)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1A4eGhWamQ3QUxSUmRLR0hJK3lWTFhzMHhmY084YzhoNTVpSVpLci9VY2tn?=
 =?utf-8?B?QzZHN0d0UEZQcWVPd3NVYWJEUGVyUGNKSHZ4UitRdGRUVkVkQTk4L2Q4S1FI?=
 =?utf-8?B?cDYwRVRXSmlQdkw5aHd6WERHeFpQSjl5OVpwam9GK09Gb2d3Tms4dXZ0WEZ3?=
 =?utf-8?B?bU9sWHFFem1TV05YcHlIR3d0WlkxWENHaFhIY1E3M2pLaVJjVkZDNFQ0TWFG?=
 =?utf-8?B?OHc3aU5NL0ZSWXphWExHZE92NUtrVTFTVURPdG5ZdjR1RGpEb3g3MmFCRWVK?=
 =?utf-8?B?V3VqOWRGeG1SM1g2dmRxV3dGSjZpa2hhWVk1UzZYVFQzK0VsUEtEUGZwUWtX?=
 =?utf-8?B?RjE1WFNPemxCa3pGUzRxYW1nR3NWQTlLc0dLQjAyS3NKaDFCeTVodmhrUWk2?=
 =?utf-8?B?ZDJZT21ZN3ZvTkdSOUdqT0xoc252NkxkRmlpUmU4SFdCMXNXRGpZak9GaXlO?=
 =?utf-8?B?U0hTZGJnV2FvcVQrakxkU2g2WDRGTmtwbmRXNlgyM0JlMGh4dEhvQlZHSVE1?=
 =?utf-8?B?a25iMFQrZ1Q0eU1CbkZvaGFNVklHZ2l2bGlJZi9HaVJaU2U0a2VsaisxQU1L?=
 =?utf-8?B?b1gwKy9odUtwUkpuSU9GOHo2ZlpiZDBQZi9UY2tvekxoM09KZFR2UExHUFVP?=
 =?utf-8?B?VVpITDhMUkRRejRCUEFmR1BCUHlJTmVuL004WktIMDM3bGpiQXpQOER6TDkw?=
 =?utf-8?B?b1pZTHp3SlF1SmhEQ0s3YTE4Sy90RHdOZUY2NWxHTVdaS28yTHlTQmVEQ1F6?=
 =?utf-8?B?ZjlZMzRWOTVCZ2J3K0ZLT2JQeFhYbG1xdUZ1ZVltZG0wSjhhdnVHKzlOQ3dk?=
 =?utf-8?B?d0RZdlo3SDYzeU1ialQrdkhZSFZmbCtmM010amtqd250UEF2cnNJNTBBZFk3?=
 =?utf-8?B?elV0cjdrUXhzR1BlU3hweUJ4MDZ3RUtBTlBTYUQ2Tm5LRTU3dURBRjJLTG01?=
 =?utf-8?B?WHc2RGFERlVua0VqU2VsZXlvM1NUKzYya1hMdG9HbWk1M1V2RXZ2M1VzZjZ6?=
 =?utf-8?B?YU8yUVRsR2xJbFBneEIrc3czdVRnQzBML3I3bGhkdGN2MDJrZXpMVmdtN0Fi?=
 =?utf-8?B?Vi9tbXcxNUlmVWNtTklnMk1OdlJRcVNZdTlZQjl6THVaajFQTm5HRUVNcHNU?=
 =?utf-8?B?QXVKc0RITHRmZGdmQmp4TGlDY1hCeDlLQzZHSXhUVG9EVE9xcXdZdU10RVF1?=
 =?utf-8?B?R0NWRnhKcVRsSDkwR0hlTDFmTUxhVjJkTlRnc09KMmNEZG16dnFOU0NDNy9X?=
 =?utf-8?B?bUgyNGdFaFdoSXlvbmhoMTAvRW1KaXV6TzNnejV2UUNCL0NMcjNHTHVHVDkz?=
 =?utf-8?B?MUd3TVVZK1hFQmRranpOT1FLbm1ZMm9lM2I3ck5temsyTDJSZXhvNENCT2g3?=
 =?utf-8?B?d2twUEhBbk1ycXIyUzNuN054VjdwTHNsa0xtUmFZWVlsUHNKMWhMVGNIRVpq?=
 =?utf-8?B?Q2JLbUxDZThDV09obXg5ZXJrWnJBVzd4VW13bUJwN0tUYmlNUmdRY2dzR3pN?=
 =?utf-8?B?VGpPdWROYzFFVzRWUzMyL1IxUWc2Q1VWQnBLUlJLWERHTmtSWnR1SmVtU3Q0?=
 =?utf-8?B?TTVLdjVyYS82U3ZyYWNiVWZKeEZHelRQcnd3cHNXcE9MQ1draE1vZ0o5Q1h5?=
 =?utf-8?B?WFU3ZC9Cclk5d0lWOVh0Nlp0UUNSR3gzS3I0UGFXcGl2UFpFcDNkTUpKSk11?=
 =?utf-8?B?dnZabnZvd2dRbm1leEYyY1FUaGpzZE1WRVRKNzZiVVIvbE0wMm1rOWcxaFJO?=
 =?utf-8?Q?qSHCkOb0UnsjyyCrasyID9O5/AVpdGcaX5Zns5z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb6b860-7cd4-4113-b3ac-08d974911b81
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 19:28:03.2291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ka7tp7cG19QTajbUXbtF7VqU/aJWcXUlNSZRfl7KRWwnHcRV2F8VK2U5/ZG9zfMQ2/2FtiZTlnpgC1k+bLEL3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5129
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

On 2021-09-10 11:15 a.m., shaoyunl wrote:
> The AtomicOp Requester Enable bit is reserved in VFs and the PF value applies to all
> associated VFs. so guest driver can not directly enable the atomicOps for VF, it
> depends on PF to enable it. In current design, amdgpu driver  will get the enabled
> atomicOps bits through private pf2vf data
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 +++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  4 +++-
>   2 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 653bd8fdaa33..3ae1721ca859 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3529,17 +3529,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
>   	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
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
>   	amdgpu_device_get_pcie_info(adev);
>   
>   	if (amdgpu_mcbp)
> @@ -3562,6 +3551,19 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> +	/* enable PCIE atomic ops */
> +	if (amdgpu_sriov_vf(adev))
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
>   	/* doorbell bar mapping and doorbell index init*/
>   	amdgpu_device_doorbell_init(adev);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index a434c71fde8e..995899191288 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -204,8 +204,10 @@ struct amd_sriov_msg_pf2vf_info {
>   	} mm_bw_management[AMD_SRIOV_MSG_RESERVE_VCN_INST];
>   	/* UUID info */
>   	struct amd_sriov_msg_uuid_info uuid_info;
> +	/* pcie atomic Ops info */
> +	uint32_t pcie_atomic_ops_enabled_flags;
>   	/* reserved */
> -	uint32_t reserved[256 - 47];
> +	uint32_t reserved[256 - 48];
>   };
>   
>   struct amd_sriov_msg_vf2pf_info_header {
