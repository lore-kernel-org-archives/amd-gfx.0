Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC24C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5106023D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5106023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFAA89FDB;
	Wed, 26 May 2021 10:50:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A7F06EC73
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:49:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3nf+CYf86JaTIy2WQeDhjxetg5XErroeo3rbtauKRlzguvV/igziT53KAmK4UG58jZcm0gH74UZP6ZXiajIhz+0s+ngmjvmTCrzizCd/RuQPzePX0zP/tEKXEgzNLeDzeqPB73wDzQXlrKI8LcFImiH5VrBXaESBRb6pC/U60zwlZ/0rCrYWX3w1G3mkRwIlV6bhcB6lnF8dZ9g3YDotpDVOgkSgSBOYz0+dF3HsmB6/ozRSHHGYZWNca5V8XXCBAR4JAZNathcW4GSdPoTTmN3IpK3Vimd9FfOSEc1EYRlTXi7Y8CWolQDYhKBkj1bsQGoFZRKbtTtldglNdfqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeyNKwcASSpkIjfChDXYzM0/ghqcIfgOZ1v05pHPsKE=;
 b=lsJx8+wq6YWMrlnS6y1mBQWUrONWqW6OUxxDBgQe70O8+vZxnfx+ftckaD86SUH0sYko0GTuC8OIdt0j5QbdOuLPYXpj9gyfbTJQutHUXinS6nRlnE0sklBCTN70aOiKBQPvopCws3tHoDtJ4TH4T1GUMWRePUupDEE2YcOBpfq5cWOhIMsiroiAp3MQ9PMgvoGJ4DfSJRlCtTSKXMB3nUnz5rEwOc+RJqkakbXiOTs2wWeQt75YPH9KhegJiD/8MP4IAUoocn8bPfMIe4uwM0ehW2+3sfC6qSNv4frNI4ualHMni6bwlmCO45oJONFc8DcJM1OxJf9hHZMZ2k9pAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeyNKwcASSpkIjfChDXYzM0/ghqcIfgOZ1v05pHPsKE=;
 b=EYlpnjYCQ2GBesg1O38FGDHTFVszcX8SFTFwPcgZ16HGHJx2bZ/mnM+lVWmUtP5No1gKf13oqDXhkzqRxycCxHZDFxW3/0E4Vf9YkxIhGLkJY73xvQkMOPJKivZBC2vVOYC9fmEK3bXzH8A+2O1L1zGM4y65LjcM1RaMBw7Afss=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 10:49:57 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:49:57 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
To: "Li, Xin (Justin)" <xin2.li@amd.com>, amd-gfx@lists.freedesktop.org,
 "Liu, Leo" <Leo.Liu@amd.com>
References: <20210526101310.1872892-1-xin2.li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <dfab1180-2ee9-7d41-8a12-0a7e86dca9d4@amd.com>
Date: Wed, 26 May 2021 12:49:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210526101310.1872892-1-xin2.li@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7216:94bf:3812:bd88]
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7216:94bf:3812:bd88]
 (2a02:908:1252:fb60:7216:94bf:3812:bd88) by
 FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:15::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.11 via Frontend Transport; Wed, 26 May 2021 10:49:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad8f390a-1fd2-4fec-6fd9-08d9203400d6
X-MS-TrafficTypeDiagnostic: BL0PR12MB4898:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48987D274973E6B0754E8FD883249@BL0PR12MB4898.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06MoJidsZ2fOnLVGDRJD3KtfNJZg5sw99gGjM1rNM4eB9lVBS0OPI2eIe7TMGNu2qNkF/Twxhx91NMo5PzOVdGiNmkIl8sGML+yGRut19dU8ZWchnsJqx71UxQnJKTxqTX9uXXh1VEjzz9t0HQsP9x80ui4liqsoUQ5uAujLU6Yc5Fe/w0KJ8GOdENFrTyLPKZT5Z+MjsEJfRkEr/x2bPakfi3g5+H85hYLDLFGb/avX+MJkVnVZXkci4/t12j+xXBRrUTrFhAtZuQbtI5wIl2oE+vbFMvpfbvcTwQOYmFCSTDSZf7F90cu1X5qvVcxbjHCzS/3HHYgt/syPl+iAqtN83+KDGrBd7VB8s4pVIsQ/iTLk127khNea3Z7qtSNzp7oWVIVEL3U/xu7hLYv8/ZYaoISAP+u+HGxilAVy8SOSUXLIq7s39K8fKAAMd7UHL4VsmFu6XzyYuVkrE8UZM70sR3GnMpRmQ3I0eHLgwjgRuRSTcMqvQ9jGzwx9NPTVK4bKVM4qspggBV05aePnW5ZIYH/lUmwGXQoLV5Nh4m7dFZrY9+hfNMWl2B6rHPHBBxWJw8R0wkVQu3UCIV1EtU09BBCvdOYjw270R/+SdsVjyV8W3hAFKBKZDavB6A6SA+xZ+Gf44noJQEjRl6mIgDPJkfxk05QxfTLdtZL2udyPvl9lMU8hZnPfWhlPLqZA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(6666004)(5660300002)(478600001)(6486002)(8676002)(36756003)(31696002)(66476007)(31686004)(2906002)(8936002)(86362001)(66556008)(6636002)(66946007)(52116002)(38100700002)(316002)(16526019)(186003)(4326008)(83380400001)(54906003)(110136005)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Um9lUjlUUitVSU8ySWhIOVY1SjZMTHpNV3lsaEFJMEZveWl2Qm9wNWh6L0pt?=
 =?utf-8?B?aEJVd0ZUdHdzdUgxYjRjeDQvSTJpcHJEcHNuOUowcEpMRm9yOXlHTE9PQmxX?=
 =?utf-8?B?alNrK0p2dGhsUjFSK2F3bGoreXNjdlppQVBuL2diVkRzbkxYYU5pUGhhRFhk?=
 =?utf-8?B?ckdORFFXSUFxZ0hpR0NEQWpKcVdOeGRuOVN4cGtZTlAvTlRNZlVYcWZXY1cy?=
 =?utf-8?B?MXNNdzRsNGdEdGxVZERxdW1kMk5TVTRhemJBMVo5dUVHV29Xdm9VZnBlWDBG?=
 =?utf-8?B?Mit5UW0zUmhCei9uU2x3UGhJQnFmTVBxT3ZDeXhTVk5FSDh2TGtUaUo4enJu?=
 =?utf-8?B?akRDMFg3UDZHTVlnUVV1b1RDdkRNcTJzaytkTTJrSEF3Wi9wZHFxYjJEeDBX?=
 =?utf-8?B?Z1d5cGpnMVh0cmROMFgxa1kxR09MaTFwWU4rR3JjbWExUzFyVk1uQVd6TEVn?=
 =?utf-8?B?cHJ0OVJNS1NURDZ4dnhJejkzS3NockVlNDVRODZJRTFodHI0c085TjBNVUJ3?=
 =?utf-8?B?eEhEK0ZkcStQTVBqL1lKSlFlMnZUMHJFT3FJRm15UDE4V08yUUVQUGtON040?=
 =?utf-8?B?ZDc4cWZWOGc2VnhqZGRYeHpYSURCVTB4dnRkQmRtZ0dQVnRLTnZmUUExRHdT?=
 =?utf-8?B?YTg0Q3hDLzYzOHBsUGVhSDQvT2RUVm5pcmttVW1CcU1ncmNuN1lNNlJKMVNS?=
 =?utf-8?B?N3puRmNGVFk2SE9EczA0UHh4T2FVNkxPL0hEN1JPaGNUc0RyVW9kcFowTzNN?=
 =?utf-8?B?WlNVZWhEWXFFNnpBd2g0d0RmTDB6MWFsUXFrd0dTWmljZXJMQzdXZEhYeTBr?=
 =?utf-8?B?S1p1d3JIeW5NdXp1RS9jYWlvMzc4S01lbzFlY1dRNG5qY2JTbVI1ZzZkUFU1?=
 =?utf-8?B?ZDhxL0MvN1RGQlppMHFtTGJkNGJnUm1wNkxhOWJHMnVhdEFDT1Byby9rZ3lG?=
 =?utf-8?B?UjhHVi82bk50Wjl3ZzdiNG5kMCtPaWZ5eldJQ0NDMSsxUzlBOExsTDBHNmZj?=
 =?utf-8?B?UDBHTWJRaCtMZVkzTzE0bVhFeTFWYVJYMEdGeTFONzU1bkFtYlRGMkpRRTdz?=
 =?utf-8?B?L1IrVG4rTXNsakdYSEp4MU0vQkI1WWw2ZnFHYjhtTjZidEREOTBJQlRiQ1Jv?=
 =?utf-8?B?SUZSZGpSV2d3V0laa0RnSExqWjlXSXlIc0dQUDBJL1NUVEw1eWZJWEhWYzZS?=
 =?utf-8?B?enJ1cXR5d0hpeUVuS083YUlBbVVUdlE2enJDMmhpOGNNWlJKWUE1VEZZL0lo?=
 =?utf-8?B?TjFBVzR3a25vN0t0b0pEcFJKNzJjRDVod05INE51ZmFVeEFQYXE3TXB4OEkz?=
 =?utf-8?B?OXVuTlQrQWh6U3pXQ2NhY01DOGFxRzFLVGdsVVJXWFQ5WWlpU3lSTkFQZnJq?=
 =?utf-8?B?M1I2OXU5V3cxc3Baa0Iyei94UmhORmM4dDVsT3lkcG00RnlzemFuanc2aUlR?=
 =?utf-8?B?YlAvZHQ4VG9sTGx0YXdya05jMFBGMVMzbkEyNjMzRWN4NjFyN1hkdS9rY04v?=
 =?utf-8?B?TXNGcXByTU8wMmtwWmNvbTdEcEpIVFN6a29kaTFzWDFZY1FiTkNMUEtCdTFH?=
 =?utf-8?B?NmVsNlBreGs2bG80emNqMGR3YktUU3FJc1kvaXM5OTVQUXlQWkdtOTVtRS9s?=
 =?utf-8?B?a2sxMHp0bm9ndW9pUm4ySEJBcktUR01KMlB1Ynh2ZFJSd0ZDOElnSEE1MkJm?=
 =?utf-8?B?dnVTaVVTMWRHdWFkNVYyRHFjVy8veDJVcFI3ZjVvVjRnTDhwNGtpeTlZK3hB?=
 =?utf-8?B?c3ErS3BsTnN1QnZlb05DeDEwZklYeDJ5emd2UzNVcVBOR0tGeGMvWFNtUVZO?=
 =?utf-8?B?OXMwOFdTdXNzNWtqRXpzL2FicnpyMnRwem1kaDQ5Z1JKa0VCVVFjd1ZzOGxQ?=
 =?utf-8?Q?jptZa+5ptkGHd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8f390a-1fd2-4fec-6fd9-08d9203400d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:49:57.6156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyDN+KqBCiQtvMQ5BXk/el45SRtn/c+az2E9ljIVR8gKDTgYpV0Fdy7DyIA+nl36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898
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
Cc: "Alex . Deucher" <alexander.deucher@amd.com>,
 "Frank . Min" <Frank.Min@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.05.21 um 12:13 schrieb Li, Xin (Justin):
> since vcn decoding ring is not required, so just disable it.
>
> Cc: Alex.Deucher <alexander.deucher@amd.com>
> Cc: Christian.Konig <christian.koenig@amd.com>
> Signed-off-by: Li.Xin.Justin <xin2.li@amd.com>
> Signed-off-by: Frank.Min <Frank.Min@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 25 ++++++++++++++-----------
>   2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 524e4fe5efe8..614e6b06e94e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>   			if (adev->uvd.harvest_config & (1 << i))
>   				continue;
>   
> -			if (adev->vcn.inst[i].ring_dec.sched.ready)
> +			if (adev->vcn.inst[i].ring_dec.sched.ready ||
> +				(adev->asic_type == CHIP_NAVI12 &&
> +				amdgpu_sriov_vf(adev)))

Leo needs to take a closer look, but that looks fishy to me.

Why should the ring be available if it is disabled? That doesn't make sense.

Christian.

>   				++num_rings;
>   		}
>   		ib_start_alignment = 16;
> @@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
>   		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
>   			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
> -		if (amdgpu_is_tmz(adev))
> -			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
>   
>   		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
>   		vm_size -= AMDGPU_VA_RESERVED_SIZE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c546db..dc8a36766c4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
> -	int i, r;
> +	int i, r = -1;
>   
>   	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>   					     ring->doorbell_index, 0);
>   
> -	if (amdgpu_sriov_vf(adev))
> +	if (amdgpu_sriov_vf(adev)) {
>   		vcn_v2_0_start_sriov(adev);
> -
> -	r = amdgpu_ring_test_helper(ring);
> -	if (r)
> -		goto done;
> +		if (adev->asic_type == CHIP_NAVI12)
> +			ring->sched.ready = false;
> +	} else {
> +		r = amdgpu_ring_test_helper(ring);
> +		if (r)
> +			goto done;
> +	}
>   
>   	//Disable vcn decode for sriov
>   	if (amdgpu_sriov_vf(adev))
> @@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)
>   
>   done:
>   	if (!r)
> -		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
> -			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> +		DRM_INFO("VCN %s encode initialized successfully(under %s).\n",
> +			(adev->asic_type == CHIP_NAVI12 &&
> +				amdgpu_sriov_vf(adev))?"":"decode and",
> +			(adev->pg_flags &
> +				AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
>   
>   	return r;
>   }
> @@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
>   	unsigned i;
>   	int r;
>   
> -	if (amdgpu_sriov_vf(adev))
> -		return 0;
> -
>   	WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
>   	r = amdgpu_ring_alloc(ring, 4);
>   	if (r)

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
