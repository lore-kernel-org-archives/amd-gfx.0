Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AAFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 21:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DD7A60F6F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 21:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1DD7A60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9991F8999E;
	Tue, 26 Oct 2021 21:23:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B119E8999E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 21:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAR6SQwhOG5urpUVhjIqB5bJPPu6hxVrWU6/GZqsTzhUntA2KBpSKk4eU3CoEN83NdjnEPK2pk79IKkIrWZsPa0GbKabeUR6XKtjwR7r+CCv3yLbbjHFSD8AJ3HmLh4spl0uhu7qhYUhV0KcZpH0hm0/7BJZXl1+puzJgH94J7c9Ns2kr34VRP8X+aJ+fbLzPY2fSRLxFidLS9Mjlb3dG4UWvsm+bND4GeXO3NIu3ugPlvKj2dYvTWaCWWNmkoK3s9WZh/I5c8MRYXrGavO+2K+FkWM29jbJa7YhlNT6oj6pLhph/fixVwUtce2tTrIpbeQZx3caeR/LJjlPEYjqJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NDxcu3zt1hFmSoqQ7/VTKOrkkMD+4fX0pleZHmXRFM=;
 b=HMF36HFRbVeVbKmTptzN1bjY95JWw6gk1DUBAOh+MdBVJw9s/GCojEemJmeC4hzzwuCcv0Pk3DflVozyuO43lAdKZ94ai89hrlvDJRaqqjNgeTn6/QfyefaaGtNaqjOU+be21zMhOG0lWSSFqelD19ltvYOFJ7Dx6yYuJen+ySRq+T2cj1Mo6uCZASJfKgnoWZcU4+rld6latupCOLcfXPw/uCZi6s2rtA6GnWYvptDB/lfEBSYMyDpH++Ssws5V7lenFblBDIFPzjkpCLmosbIDflL4528lhJbS63+RBEVpyiQNzMcnndhD5YEvZF+6Gd7Dt/5Gx8klYwGvehdtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NDxcu3zt1hFmSoqQ7/VTKOrkkMD+4fX0pleZHmXRFM=;
 b=1ox7d5P/CRL4JUXf+i7oJpVT/6JPTaMd46tlBM3tj2bH6pk0iFhLPYXjsQUyJPqCdoiewdzJXPwMHbcskR8NgnlE/4Cgert8RJosEue29aCkoSug5tuJua+PH+YGuC8UzSlgyV7aumXSnSDO/OE010btsfyuhuhwx6bfoK3Rdwo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Tue, 26 Oct 2021 21:23:38 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 21:23:38 +0000
Subject: Re: [PATCH 10/13] drm/amdkfd: replace kgd_dev in get amdgpu_amdkfd
 funcs
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
Cc: mukul.joshi@amd.com
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
 <20211019211334.1552825-10-Graham.Sider@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ec346f3b-9c3f-a7bd-de9b-35b56070ff01@amd.com>
Date: Tue, 26 Oct 2021 17:23:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019211334.1552825-10-Graham.Sider@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::9) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YQBPR0101CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Tue, 26 Oct 2021 21:23:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee4efdf-395d-4451-f925-08d998c6e068
X-MS-TrafficTypeDiagnostic: DM5PR12MB1436:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1436988B07A7E0474C8CF64C92849@DM5PR12MB1436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gvds9QOpgzyyGnXBnbAV62lnZ5C7iWHqEQbqMjz2jEMNdEtU9ZFLfC1N06LGqs5OdW4EpV7QHqgaKPQ4C+YUTgOh5oPCyYSjCgr/aLcWsbbCYRdUDIQ2HKKUEHEA8yOaB84YGStaE0ZX4hGi5DmTS76a/tgnjczEA34XA09CH78IIt+af/LmaQq4K9fOIc6GJPIf5+nZ3Adu5IyHDms4Ws7TZFaEbTDu0zqdjC1gjJJSrP/CgSIkl+QHXqZhErqv1SexgAP7K1AebJ6Vjv+fTAWJOXO5q5kmEUXSVMGtsUO5OqmzlK1XZeDETfNwL9IZPMQRUTcl9cTG4btIjLDgj7lGpGwO5ZH6tYxbOG8vPkT92jKDiFLSBOPZxu+v8DnXMm27j/JoZy4VbeuL/LbbzdIlaEEZo+yVEj+43IZw2YwvTLbE75yNRWNhz91fbQXzWJnHnWBxcD4I51vgVaoWJbKvUsXvxzAdLngHAd++ke/KL+RIMfGJHMtvrBjDamBQ+zbIqCVbbBdXMV6xCNQSfp7rNukZsRiEus5eb+SYM86LhDs8Kdza0Xz9yRbQN2ylMhapvrA8GDWkpowjWRS1Ib9ATzaHOnmCATf9/C7ZFOZku5RqtNj1Gas1S9YrPBCirs9lduTrBoLBxW9ftgmwbhV8Fa6Uxed757RQRV13c1aA2pidxuabuCDnGfGDG/fqLhbhZMS5JMQQebxCXhvHf09n1dDzuDZdCYArVl0KynJa+sdk22nqPXCgKIdqwQTC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(38100700002)(66946007)(2906002)(316002)(66476007)(44832011)(8676002)(5660300002)(508600001)(4001150100001)(66556008)(4326008)(31686004)(36756003)(16576012)(83380400001)(86362001)(186003)(30864003)(26005)(31696002)(2616005)(956004)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUZMbGcyQld4RGhueFhpNEVML0xrN2JLRkJ5V2xvQlJOVTYzNGgydVA4Q0Vr?=
 =?utf-8?B?cSt5Zk5LeVl6UmNiWXlmWUdMcUQxUHUvU3RJYmNLMmpucnFvVzlQQ3AxNTJr?=
 =?utf-8?B?Sk5tQU8vQWpjTFFTdUM2bk9jTVcyWUFFT2cvNEZvTU9rWkNxckZRQ3NxQUdG?=
 =?utf-8?B?a0FtckpvbjV0cXF3ZVZWZ3hwQVBabGsxQnFwS2QwT2JIK2V6YW9heDdyNUhK?=
 =?utf-8?B?SDdQSytDQkVjOHhrT29XR3dCZGV6cXZISW04aXE1MGkxWEFUdHR3MWNmcDdD?=
 =?utf-8?B?eU9hNmhMY0lLNW1KZE5jNnNRL2cwU1FiVWw2bWNQK1ludWJBOEszVVE1N01O?=
 =?utf-8?B?U1RDa2RHY25HOXRsNzZFNENKdzR2NUovSjd3V3J6RitIR1RPT1lmS3NOSzdq?=
 =?utf-8?B?eHFsTXNFTVNOWmluelpuUlNoWmJJZjFEbkRINTJMOUdIbEJZb1BtQzdqbVJJ?=
 =?utf-8?B?Zmxua3pGaVVHWjdJVU1nUFgvV1VGNy94QzdaVWowTzhYbDZ0cUJVY3dMaUhL?=
 =?utf-8?B?Z3RwUlA0My9jck1PK1o2OTNLVnNLSEx5NlNzUjZmdUQ2U25FREhPdGhZMUVN?=
 =?utf-8?B?a2E2aFVUTzZEelJlK084dUJqTWNlUWNsM1NLL0hacEVEUDhmdzlaZmF5YTA1?=
 =?utf-8?B?Z1Bkc2J2cWJXR3oxR0VLNGJUcVRRRU1rcTViTDdIVkF6MWlSVXB3TFlPZE50?=
 =?utf-8?B?WDdlWmhzczBKYU12eE05Wkl6ZEIwUXBHcDdEbTZXQktRbkljWENhRUtoRkl3?=
 =?utf-8?B?WDhadzE5VTcybG5GNWFadVdmK0xWRkpPemxjRmhsWUY0RUM3c1NRa0RJNFB5?=
 =?utf-8?B?SEpSYTZYSUZud0FyUlo0UzkyMmxaeXN6T2ZLRC9UelVySGo5dDViWWdMMUZF?=
 =?utf-8?B?b0dwL296ZXAwRmNobDdxak5HT0orZWRJbnh0SnV1R0pKN09razZJYjB3UkRV?=
 =?utf-8?B?dy9yeG02UHhyd0luTXR5aG9zbXBqVXN6b1V2dWdrZHM0SStKeDlQdXByb3N0?=
 =?utf-8?B?SW5KS00xa1JUVWNpME9idUxIbXprNGtweFFZU1o3RFdkaU13NjJsb2ZVMEVn?=
 =?utf-8?B?R0luMEdPQ1Q3Z0tJQ3k1MmhhbGYrNU0zcHpsY08xSkdRd0V5N1NjemdhYVln?=
 =?utf-8?B?R2ZTL3haVTg3YThRRXNoSExKYWt0VitzcU5ua1MyVTlSTlFHMWErbmhvMnlT?=
 =?utf-8?B?OE1RSVcxY3FLOHVwYWEwNVAvT3g5Zlc3SlZZR3NpVjRaVXVMVEJ3NmVRNWUr?=
 =?utf-8?B?QjV6cmhKRUF4dlV6U2JNbDF2WnByaXpmUHJVS014VTN5b2RaTGZpSlN1TVZY?=
 =?utf-8?B?YStCWStxdHUvbG94WjZ1UDJnb2Z2MzVOOEFnQXZlVmVUSTVCR29LM3pKRkpN?=
 =?utf-8?B?dmZzMW5EZUxGOWVJYmNLbDNubWJEdDV2RWR2eXd6VU5iUnJ0YUpidnVOeFVJ?=
 =?utf-8?B?WStaM2RXdWdsODRmYnovN3F6TUNTYy9nV3dna1l4TzlEbzdvS3Vzc1Vla1JI?=
 =?utf-8?B?SG1WcmQrd0VNU0FIQXpEYnpVZmdnNVVEWmZYSGJqUmw5b3ppUS9FanNEbGtK?=
 =?utf-8?B?VFFXM0tTNzRYM280K1JmU01rdDNMTEttSk1UR1R5Y3hTb0h3UjRkNEdzNnUr?=
 =?utf-8?B?WFdjMWJRVlZ1SjZrZGE2eWswWWlFdlVYTVRoYldtd0pFd2lzK1ZycGxLTHcr?=
 =?utf-8?B?NFQxaGp5dnd5cWhQcExBdm93WVFEWGtCRDlUK00wTzhBSFRKNElENXpzOHQ1?=
 =?utf-8?B?b1U3MTFWNjdkSlNBeDNkWGs2N1czTzJXUE9KOURKeHdvMWd3c1MwZFY3dDgx?=
 =?utf-8?B?VTJlYnhveERSUktwMTRpaUorUWhRZ0YyQlRFUlREeVR3ZDFIQW5YVG1uRklV?=
 =?utf-8?B?andhVzJrOXpNUG1MV1g3b2JpbW5LNjBzY2pXSzI4R1dLUUlmK1p3OFp2OG0v?=
 =?utf-8?B?QVoxZ3lCUXlFVVFrdDRRdzFTT3ZqK3AyV3JRRVJ2WGVxRlBsdkRrNDRNTFRy?=
 =?utf-8?B?Yko1VkhrVXI0Qm40ay9TSnlGdkk1K2lOTGhnOSt3aVY5UlovdG1uanB5Qmxj?=
 =?utf-8?B?WC9MbGVoazNidVpScW4ydi9PblRSUkVVbmhyOGoyVUJ3ZE5WYWN3b09Pb1hY?=
 =?utf-8?B?S2FqVHZkeCszUGZJOVJXZFU2NXJxSFcraHQremhFOGU0ckdDRWh4cnRVRG1J?=
 =?utf-8?Q?88rRTr/2SYFGqNy55LjXe8o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee4efdf-395d-4451-f925-08d998c6e068
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 21:23:38.7217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mCaZ2SHxzeApgO47KwXuTqfrwCvo5hVtYBvFfL4i9FJOhhKPHcyExCRirDO8eebBRINiYew8nn6Al0iwFWlCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
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

Am 2021-10-19 um 5:13 p.m. schrieb Graham Sider:
> Modified definitions:
>
> - amdgpu_amdkfd_get_fw_version
> - amdgpu_amdkfd_get_local_mem_info
> - amdgpu_amdkfd_get_gpu_clock_counter
> - amdgpu_amdkfd_get_max_engine_clock_in_mhz
> - amdgpu_amdkfd_get_cu_info
> - amdgpu_amdkfd_get_dmabuf_info
> - amdgpu_amdkfd_get_vram_usage
> - amdgpu_amdkfd_get_hive_id
> - amdgpu_amdkfd_get_unique_id
> - amdgpu_amdkfd_get_mmio_remap_phys_addr
> - amdgpu_amdkfd_get_num_gws
> - amdgpu_amdkfd_get_asic_rev_id
> - amdgpu_amdkfd_get_noretry
> - amdgpu_amdkfd_get_xgmi_hops_count
> - amdgpu_amdkfd_get_xgmi_bandwidth_mbytes
> - amdgpu_amdkfd_get_pcie_bandwidth_mbytes
>
> Also replaces kfd_device_by_kgd with kfd_device_by_adev, now
> searching via adev rather than kgd.

Some of these functions are so trivial, they could probably be replaced
with direct accesses to the respective fields in adev from KFD:

  * amdgpu_amdkfd_get_hive_id
  * amdgpu_amdkfd_get_unique_id
  * amdgpu_amdkfd_get_mmio_remap_phys_addr
  * amdgpu_amdkfd_get_num_gws
  * amdgpu_amdkfd_get_asic_rev_id
  * amdgpu_amdkfd_get_noretry

I'd do that with a separate follow-up patch, though.

Regards,
  Felix


>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 73 +++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 38 +++++-----
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 16 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 16 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 14 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
>  .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 18 ++---
>  9 files changed, 82 insertions(+), 99 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 69fc8f0d9c45..79a2e37baa59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -358,11 +358,9 @@ void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj)
>  	amdgpu_bo_unref(&bo);
>  }
>  
> -uint32_t amdgpu_amdkfd_get_fw_version(struct kgd_dev *kgd,
> +uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>  				      enum kgd_engine_type type)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	switch (type) {
>  	case KGD_ENGINE_PFP:
>  		return adev->gfx.pfp_fw_version;
> @@ -395,11 +393,9 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct kgd_dev *kgd,
>  	return 0;
>  }
>  
> -void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
> +void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>  				      struct kfd_local_mem_info *mem_info)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	memset(mem_info, 0, sizeof(*mem_info));
>  
>  	mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
> @@ -424,19 +420,15 @@ void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
>  		mem_info->mem_clk_max = 100;
>  }
>  
> -uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd)
> +uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	if (adev->gfx.funcs->get_gpu_clock_counter)
>  		return adev->gfx.funcs->get_gpu_clock_counter(adev);
>  	return 0;
>  }
>  
> -uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
> +uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	/* the sclk is in quantas of 10kHz */
>  	if (amdgpu_sriov_vf(adev))
>  		return adev->clock.default_sclk / 100;
> @@ -446,9 +438,8 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
>  		return 100;
>  }
>  
> -void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)
> +void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev, struct kfd_cu_info *cu_info)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>  	struct amdgpu_cu_info acu_info = adev->gfx.cu_info;
>  
>  	memset(cu_info, 0, sizeof(*cu_info));
> @@ -469,13 +460,12 @@ void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)
>  	cu_info->lds_size = acu_info.lds_size;
>  }
>  
> -int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
> -				  struct kgd_dev **dma_buf_kgd,
> +int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
> +				  struct amdgpu_device **dmabuf_adev,
>  				  uint64_t *bo_size, void *metadata_buffer,
>  				  size_t buffer_size, uint32_t *metadata_size,
>  				  uint32_t *flags)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>  	struct dma_buf *dma_buf;
>  	struct drm_gem_object *obj;
>  	struct amdgpu_bo *bo;
> @@ -503,8 +493,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>  		goto out_put;
>  
>  	r = 0;
> -	if (dma_buf_kgd)
> -		*dma_buf_kgd = (struct kgd_dev *)adev;
> +	if (dmabuf_adev)
> +		*dmabuf_adev = adev;
>  	if (bo_size)
>  		*bo_size = amdgpu_bo_size(bo);
>  	if (metadata_buffer)
> @@ -524,32 +514,28 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>  	return r;
>  }
>  
> -uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd)
> +uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
>  	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>  
>  	return amdgpu_vram_mgr_usage(vram_man);
>  }
>  
> -uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd)
> +uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	return adev->gmc.xgmi.hive_id;
>  }
>  
> -uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd)
> +uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	return adev->unique_id;
>  }
>  
> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src)
> +uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> +					  struct amdgpu_device *src)
>  {
> -	struct amdgpu_device *peer_adev = (struct amdgpu_device *)src;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)dst;
> +	struct amdgpu_device *peer_adev = src;
> +	struct amdgpu_device *adev = dst;
>  	int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
>  
>  	if (ret < 0) {
> @@ -561,16 +547,18 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
>  	return  (uint8_t)ret;
>  }
>  
> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min)
> +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> +					    struct amdgpu_device *src,
> +					    bool is_min)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)dst, *peer_adev;
> +	struct amdgpu_device *adev = dst, *peer_adev;
>  	int num_links;
>  
>  	if (adev->asic_type != CHIP_ALDEBARAN)
>  		return 0;
>  
>  	if (src)
> -		peer_adev = (struct amdgpu_device *)src;
> +		peer_adev = src;
>  
>  	/* num links returns 0 for indirect peers since indirect route is unknown. */
>  	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
> @@ -585,9 +573,8 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev
>  	return (num_links * 16 * 25000)/BITS_PER_BYTE;
>  }
>  
> -int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min)
> +int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)dev;
>  	int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
>  							fls(adev->pm.pcie_mlw_mask)) - 1;
>  	int gen_speed_shift = (is_min ? ffs(adev->pm.pcie_gen_mask &
> @@ -643,31 +630,23 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min)
>  	return (num_lanes_factor * gen_speed_mbits_factor)/BITS_PER_BYTE;
>  }
>  
> -uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
> +uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	return adev->rmmio_remap.bus_addr;
>  }
>  
> -uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd)
> +uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	return adev->gds.gws_size;
>  }
>  
> -uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd)
> +uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	return adev->rev_id;
>  }
>  
> -int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd)
> +int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev)
>  {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
> -
>  	return adev->gmc.noretry;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 8d5c18953723..7e3697a7a5cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -209,29 +209,33 @@ int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
>  void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
>  int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
>  int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
> -uint32_t amdgpu_amdkfd_get_fw_version(struct kgd_dev *kgd,
> +uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
>  				      enum kgd_engine_type type);
> -void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
> +void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
>  				      struct kfd_local_mem_info *mem_info);
> -uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd);
> +uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
>  
> -uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd);
> -void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info);
> -int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
> -				  struct kgd_dev **dmabuf_kgd,
> +uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
> +void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev,
> +			       struct kfd_cu_info *cu_info);
> +int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
> +				  struct amdgpu_device **dmabuf_adev,
>  				  uint64_t *bo_size, void *metadata_buffer,
>  				  size_t buffer_size, uint32_t *metadata_size,
>  				  uint32_t *flags);
> -uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd);
> -uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd);
> -uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd);
> -uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd);
> -uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
> -uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
> -int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
> -uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
> -int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min);
> -int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min);
> +uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev);
> +uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev);
> +uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev);
> +uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev);
> +uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev);
> +uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev);
> +int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev);
> +uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
> +					  struct amdgpu_device *src);
> +int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
> +					    struct amdgpu_device *src,
> +					    bool is_min);
> +int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
>  
>  /* Read user wptr from a specified user address space with page fault
>   * disabled. The memory must be pinned and mapped to the hardware when
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 7c4f14410a74..47acfef1aebd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -850,7 +850,7 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
>  	dev = kfd_device_by_id(args->gpu_id);
>  	if (dev)
>  		/* Reading GPU clock counter from KGD */
> -		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(dev->kgd);
> +		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(dev->adev);
>  	else
>  		/* Node without GPU resource */
>  		args->gpu_clock_counter = 0;
> @@ -1237,7 +1237,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>  	if (dev->use_iommu_v2)
>  		return false;
>  
> -	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
> +	amdgpu_amdkfd_get_local_mem_info(dev->adev, &mem_info);
>  	if (mem_info.local_mem_size_private == 0 &&
>  			mem_info.local_mem_size_public > 0)
>  		return true;
> @@ -1306,7 +1306,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>  			err = -EINVAL;
>  			goto err_unlock;
>  		}
> -		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
> +		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
>  		if (!offset) {
>  			err = -ENOMEM;
>  			goto err_unlock;
> @@ -1664,7 +1664,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>  {
>  	struct kfd_ioctl_get_dmabuf_info_args *args = data;
>  	struct kfd_dev *dev = NULL;
> -	struct kgd_dev *dma_buf_kgd;
> +	struct amdgpu_device *dmabuf_adev;
>  	void *metadata_buffer = NULL;
>  	uint32_t flags;
>  	unsigned int i;
> @@ -1684,15 +1684,15 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
>  	}
>  
>  	/* Get dmabuf info from KGD */
> -	r = amdgpu_amdkfd_get_dmabuf_info(dev->kgd, args->dmabuf_fd,
> -					  &dma_buf_kgd, &args->size,
> +	r = amdgpu_amdkfd_get_dmabuf_info(dev->adev, args->dmabuf_fd,
> +					  &dmabuf_adev, &args->size,
>  					  metadata_buffer, args->metadata_size,
>  					  &args->metadata_size, &flags);
>  	if (r)
>  		goto exit;
>  
>  	/* Reverse-lookup gpu_id from kgd pointer */
> -	dev = kfd_device_by_kgd(dma_buf_kgd);
> +	dev = kfd_device_by_adev(dmabuf_adev);
>  	if (!dev) {
>  		r = -EINVAL;
>  		goto exit;
> @@ -2050,7 +2050,7 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
>  	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
>  		return -EINVAL;
>  
> -	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
> +	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
>  
>  	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
>  				VM_DONTDUMP | VM_PFNMAP;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index cfedfb1e8596..7143550becb0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1993,16 +1993,16 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
>  		if (adev->asic_type == CHIP_ALDEBARAN) {
>  			sub_type_hdr->minimum_bandwidth_mbs =
>  					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
> -							kdev->kgd, NULL, true);
> +							kdev->adev, NULL, true);
>  			sub_type_hdr->maximum_bandwidth_mbs =
>  					sub_type_hdr->minimum_bandwidth_mbs;
>  		}
>  	} else {
>  		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
>  		sub_type_hdr->minimum_bandwidth_mbs =
> -				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, true);
> +				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->adev, true);
>  		sub_type_hdr->maximum_bandwidth_mbs =
> -				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, false);
> +				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->adev, false);
>  	}
>  
>  	sub_type_hdr->proximity_domain_from = proximity_domain;
> @@ -2044,11 +2044,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
>  	sub_type_hdr->proximity_domain_from = proximity_domain_from;
>  	sub_type_hdr->proximity_domain_to = proximity_domain_to;
>  	sub_type_hdr->num_hops_xgmi =
> -		amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd, peer_kdev->kgd);
> +		amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
>  	sub_type_hdr->maximum_bandwidth_mbs =
> -		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, peer_kdev->kgd, false);
> +		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, peer_kdev->adev, false);
>  	sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
> -		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, NULL, true) : 0;
> +		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
>  
>  	return 0;
>  }
> @@ -2114,7 +2114,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>  	cu->flags |= CRAT_CU_FLAGS_GPU_PRESENT;
>  	cu->proximity_domain = proximity_domain;
>  
> -	amdgpu_amdkfd_get_cu_info(kdev->kgd, &cu_info);
> +	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
>  	cu->num_simd_per_cu = cu_info.simd_per_cu;
>  	cu->num_simd_cores = cu_info.simd_per_cu * cu_info.cu_active_number;
>  	cu->max_waves_simd = cu_info.max_waves_per_simd;
> @@ -2145,7 +2145,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>  	 * report the total FB size (public+private) as a single
>  	 * private heap.
>  	 */
> -	amdgpu_amdkfd_get_local_mem_info(kdev->kgd, &local_mem_info);
> +	amdgpu_amdkfd_get_local_mem_info(kdev->adev, &local_mem_info);
>  	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
>  			sub_type_hdr->length);
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index a90ec8de213b..00c726123207 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -894,7 +894,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>  		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
>  			&& kfd->mec2_fw_version >= 0x28))
>  		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
> -				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
> +				amdgpu_amdkfd_get_num_gws(kfd->adev), &kfd->gws);
>  
>  	return ret;
>  }
> @@ -911,11 +911,11 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	unsigned int size, map_process_packet_size;
>  
>  	kfd->ddev = ddev;
> -	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
> +	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
>  			KGD_ENGINE_MEC1);
> -	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
> +	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
>  			KGD_ENGINE_MEC2);
> -	kfd->sdma_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
> +	kfd->sdma_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
>  			KGD_ENGINE_SDMA1);
>  	kfd->shared_resources = *gpu_resources;
>  
> @@ -996,9 +996,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  		goto kfd_doorbell_error;
>  	}
>  
> -	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->kgd);
> +	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->adev);
>  
> -	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->kgd);
> +	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->adev);
>  
>  	if (kfd_interrupt_init(kfd)) {
>  		dev_err(kfd_device, "Error initializing interrupts\n");
> @@ -1016,7 +1016,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>  	 */
>  	if (kfd_gws_init(kfd)) {
>  		dev_err(kfd_device, "Could not allocate %d gws\n",
> -			amdgpu_amdkfd_get_num_gws(kfd->kgd));
> +			amdgpu_amdkfd_get_num_gws(kfd->adev));
>  		goto gws_error;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index c021519af810..7b4118915bf6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -100,7 +100,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>  	struct kfd_cu_info cu_info;
>  	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
>  	int i, se, sh, cu;
> -	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
> +	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
>  
>  	if (cu_mask_count > cu_info.cu_active_number)
>  		cu_mask_count = cu_info.cu_active_number;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index c8bd062fb954..499db2099775 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -969,7 +969,7 @@ struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
>  struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
>  struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
>  struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
> -struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd);
> +struct kfd_dev *kfd_device_by_adev(const struct amdgpu_device *adev);
>  int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_dev **kdev);
>  int kfd_numa_node_to_apic_id(int numa_node_id);
>  void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 243dd1efcdbf..d8462bd3b4a6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -118,7 +118,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>  		return ret;
>  
>  	pqn->q->gws = mem;
> -	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->kgd) : 0;
> +	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->adev) : 0;
>  
>  	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>  							pqn->q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index dd593ad0614a..31610b4a3e2e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -113,7 +113,7 @@ struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev)
>  	return device;
>  }
>  
> -struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd)
> +struct kfd_dev *kfd_device_by_adev(const struct amdgpu_device *adev)
>  {
>  	struct kfd_topology_device *top_dev;
>  	struct kfd_dev *device = NULL;
> @@ -121,7 +121,7 @@ struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd)
>  	down_read(&topology_lock);
>  
>  	list_for_each_entry(top_dev, &topology_device_list, list)
> -		if (top_dev->gpu && top_dev->gpu->kgd == kgd) {
> +		if (top_dev->gpu && top_dev->gpu->adev == adev) {
>  			device = top_dev->gpu;
>  			break;
>  		}
> @@ -531,7 +531,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
>  				      dev->gpu->sdma_fw_version);
>  		sysfs_show_64bit_prop(buffer, offs, "unique_id",
> -				      amdgpu_amdkfd_get_unique_id(dev->gpu->kgd));
> +				      amdgpu_amdkfd_get_unique_id(dev->gpu->adev));
>  
>  	}
>  
> @@ -1106,7 +1106,7 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
>  	if (!gpu)
>  		return 0;
>  
> -	amdgpu_amdkfd_get_local_mem_info(gpu->kgd, &local_mem_info);
> +	amdgpu_amdkfd_get_local_mem_info(gpu->adev, &local_mem_info);
>  
>  	local_mem_size = local_mem_info.local_mem_size_private +
>  			local_mem_info.local_mem_size_public;
> @@ -1189,7 +1189,7 @@ static void kfd_fill_mem_clk_max_info(struct kfd_topology_device *dev)
>  	 * for APUs - If CRAT from ACPI reports more than one bank, then
>  	 *	all the banks will report the same mem_clk_max information
>  	 */
> -	amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd, &local_mem_info);
> +	amdgpu_amdkfd_get_local_mem_info(dev->gpu->adev, &local_mem_info);
>  
>  	list_for_each_entry(mem, &dev->mem_props, list)
>  		mem->mem_clk_max = local_mem_info.mem_clk_max;
> @@ -1372,7 +1372,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	 * needed for the topology
>  	 */
>  
> -	amdgpu_amdkfd_get_cu_info(dev->gpu->kgd, &cu_info);
> +	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
>  
>  	strncpy(dev->node_props.name, gpu->device_info->asic_name,
>  			KFD_TOPOLOGY_PUBLIC_NAME_SIZE);
> @@ -1384,13 +1384,13 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  	dev->node_props.vendor_id = gpu->pdev->vendor;
>  	dev->node_props.device_id = gpu->pdev->device;
>  	dev->node_props.capability |=
> -		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->kgd) <<
> +		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->adev) <<
>  			HSA_CAP_ASIC_REVISION_SHIFT) &
>  			HSA_CAP_ASIC_REVISION_MASK);
>  	dev->node_props.location_id = pci_dev_id(gpu->pdev);
>  	dev->node_props.domain = pci_domain_nr(gpu->pdev->bus);
>  	dev->node_props.max_engine_clk_fcompute =
> -		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
> +		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->adev);
>  	dev->node_props.max_engine_clk_ccompute =
>  		cpufreq_quick_get_max(0) / 1000;
>  	dev->node_props.drm_render_minor =
> @@ -1404,7 +1404,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  				gpu->device_info->num_sdma_queues_per_engine;
>  	dev->node_props.num_gws = (dev->gpu->gws &&
>  		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
> -		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
> +		amdgpu_amdkfd_get_num_gws(dev->gpu->adev) : 0;
>  	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
>  
>  	kfd_fill_mem_clk_max_info(dev);
