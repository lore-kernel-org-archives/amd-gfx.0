Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DF5C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3DE64F61
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 18:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3DE64F61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAEF489D87;
	Wed,  3 Feb 2021 18:51:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C3E899C4
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 18:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4MuiFJafaklgi5L8/2vjuk0EcxbfGsLYu6HSza9pVG5a0tQpXT6u0vnJYcEtM9DmTFTtHLRwTyuj4SW+3NybxN3+lehzFGebcV10lodrI/Wnd7YPaNajHG0i2wet+RDfF7RbRKbqsNHz7ugs+20eIn7qyEwA6LDtS2YcGF54vd2x4XsR/k8Tf1RuxWspHOcMseoPmQZnJB5XF5KmntghetNIHHxB3vFHLBQGgVd5DeKWd7Kx6XndoYZxqf7DK2VPJ6SV2tR4PHV0KiOONi6WWWwGVmHb4JNpNVNNMJIfRHoTMqDS4Z5Y13X7dhsfTzYhG7CUgmnxSO9JWbMClK6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnap0nnToJ58CxdTedwAwuFxHvcCeNQGsjTI0ktDaCw=;
 b=AnoSretsVnfowHGNYS7DJHVMjDdLtv4mNJTAg0uH6Cxv7YuWqPg8q+NfeZIyAIhXhU893JM37sWtFJNidYJmp9lh+C+hPGNFjMjm46ErFZCdGUVIkGAXsZE42QdA+cq4yvaOkPhF2MAwxE2+D9C9tbGuMSie4p+Lr8PyP3LE+SOh05TrSVou7bQwGceZdkGPtmyPwXXBoUYRfCER/x+ePgc+1/Q/UiZ50Bh+S7Izv/emQQCfwYRapd7+Y3RVk8F8WvqpI2sAuZCL0sq2gaNGGKUNzD6FwBUp5mnPT/EhJpVr9ugOFg58FzGHQQ4ly5Y5LTI7he8KT11u51oj1z8uiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnap0nnToJ58CxdTedwAwuFxHvcCeNQGsjTI0ktDaCw=;
 b=i4TW60KnQr0QJQpv6VNiZjDMaOyjhpM8qdITREM7oLKgcJfesMVixgnKw/0P2lTy6GtkGMf/YV1X+IlnhlTT74Wcs4OMy2tgw5U1RwljUdjK4qK3APb/JFVu7llfNExxpLHyFrttUKXCZbc367rmEbB8wcsPZw+nyIxPd4ODDsY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB4962.namprd12.prod.outlook.com (2603:10b6:208:17e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Wed, 3 Feb
 2021 18:51:55 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.022; Wed, 3 Feb 2021
 18:51:55 +0000
Subject: Re: [PATCH] drm/amdkfd: Get unique_id dynamically v2
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210203184704.25079-1-kent.russell@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <38794fac-3093-8d23-1d42-f2d7e29d1127@amd.com>
Date: Wed, 3 Feb 2021 13:51:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210203184704.25079-1-kent.russell@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.19 via Frontend Transport; Wed, 3 Feb 2021 18:51:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: db991097-99c8-43c9-3de9-08d8c874c6ea
X-MS-TrafficTypeDiagnostic: BL0PR12MB4962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4962ADB638A060BFDFCEC59B92B49@BL0PR12MB4962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ml/IvfIYhwbSwiw2ERrElXC84ZSmWe5hn3yIZDDWy+WWQFdCB5Ml74gsZQEOO9aXVCy+Gfgx1Nocbcsv2lqjw3YVSW+Y/zNV4K7fvwvVL9KAejaGdGqmXb9fuI8F7v/OPwVOW92NxERsfJmchT1QuEboPEeFPy3XVFissU8CdGavG7vEs86AkYRSiw1Qtg+0CzPP/3npMSM7BqUm5TLVVkgQ2FM+EiJz5Gq+GVN5NlMp/FLoCLRNsexq/hPpQKV0EmZlytOvhqlvtFhl0rIHhH4dr2uhDzuKXg9VnmBJDPUrqZ9yatcG36QUneIp316+Ftr4PCWEGlhWu/xt+MfQLNQEwfgK4Ec6dvSpdzu0RrcZPEPKdOk9VKIzi1vONbDe8GzlJxnuCcZ4Xu/xb6pyBqk0/E74ASVh7/yTt+LTilgaiHlCh1JIeJBqGRS8pExpYwkJ9XhBhYDsNTppCH3DRc4QNuCISjv55S4b9UB8NFChCPLQy8TIS8+FdJ/qGfH3VOP6e8QmlMarIo/B9BZIvIAvrjZyi2ZZnDZwQIuoJY8jGSAsQNyS55OrSnIBXV2ygnypJG16/zSq36q6tFxMCj+GSd1u58r/DIwjh8ruPnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(36756003)(44832011)(6486002)(66556008)(66476007)(52116002)(8936002)(26005)(2906002)(8676002)(186003)(31686004)(5660300002)(2616005)(956004)(83380400001)(16576012)(478600001)(66946007)(316002)(31696002)(86362001)(16526019)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SWhSdzBBVVhuR3F5TC8wY1gwY2RTMzl3dFJqTVNFMm43RzJnSXZNa1ZjYmRv?=
 =?utf-8?B?VklUUnVubVEzRWlSMzA5R2JYUHdJRFNZcHo5UWlXZUlJV0piTGNLY1pReWJx?=
 =?utf-8?B?ZTZMeTZDZ2p5eGRWaXh3a2k2Nks0MnY5K2p4cmxqMUwvTjJWWkdMOHFKQXZo?=
 =?utf-8?B?Yng5eTh6akZhSnBEYUxpb1FnMmFxZDkzM1hWTDRMeUs1cjBhMlo0UURwV3Nu?=
 =?utf-8?B?V3BxK0Q3bWZxaFcydTB4bisvdW41QXhBTTg0Z01IbytxTU5HUE1EZG0vZng2?=
 =?utf-8?B?bXQ0SFZIam9oL2FmalJCSVRkMFFzdnI2Yk1rbU5QcHJPZWd0R0N0c3NBWHFW?=
 =?utf-8?B?QWNFb2w5WGJRRXVpcHlXaHh1elpGUFJ4eExzcXB6ZTVYcUY3eTBlUU01TVh2?=
 =?utf-8?B?T1MyMFhPaVVGTEtPUFEzUDBJRXg2enVBS0YxSFdkUzNFMnNlYzRPWnNpMC9W?=
 =?utf-8?B?aGlzUUhmWGpFUVR0c2hyVzE5c1VTZi8yQkdYN1llSjNVNFgxTnA5bWJhUnQ1?=
 =?utf-8?B?TXQxVytMTGhjamNsS2JhSy9SRHhvbHduOGFuRG1Sbm5va1hJMStBRDRraTRq?=
 =?utf-8?B?L0dLYWNqRVhHRVlyWUU1elBNOG9LMGlZQjMxQjJweC93T1N5OHAydVlQT2hO?=
 =?utf-8?B?cXVvelAyWGp0NHJ1aDQyV282bHBvdTZVdE1hNEkzZS9NRlp6RjlrSkJtM2sv?=
 =?utf-8?B?dDJrUFkzcWVuZWM0MWQwckFIMlYybUxFK3MzaDRPMjBkT0JDM3JwbkhwU1pJ?=
 =?utf-8?B?SnFVcmRlNzRicDhudy9nbFhvT25uRnd2UnprMERzNXl1MFozRk0vdlRuUlBP?=
 =?utf-8?B?Y0xwNE0wWVcyMm1NRFVlK0tvclY1Z2Q0NVcwcWlMN3JISkpvc1FaREJpNks3?=
 =?utf-8?B?eUc2M2VYMjZoNk1EMFI0S1cvaVJ4aWlqU2N4QjNKVWNSK1JSeEpMZlBQWFNm?=
 =?utf-8?B?K3dkc0ZHRzQ1dmQzWnpXTEZXZEhBWWdSSVdxQ0pXdjBScWNYV3JOZGVNVGxD?=
 =?utf-8?B?YTlhY3VrdER5TnJNNkZ2K3dWcXBtRDVsTEZGakNxOXkwTU1xdG5SSTd0MFdH?=
 =?utf-8?B?bEJpZmNORUZ5MGpqa0Z4Z2tNQVNFc3g2STdRYUZsRGl0VW50MEtpUG03bFQv?=
 =?utf-8?B?ek05dXlJTStxQXJrblBiVjZibDgwRkl6UnVJMzRza1Z2N2w5TTdUdW9nU1hn?=
 =?utf-8?B?azZRZzRlVzN4MTdDWm1sWWhxYktyZ3JOS2VHYWp6c2V0VGlJTlgyRzMxWHZ2?=
 =?utf-8?B?U0ZObFpEbHdXN1lVdXBqaWtqTkJBTkJhYlBNWmk4KzBVdU1rcTN0WmRPZS9h?=
 =?utf-8?B?VHZwOU8rWkpJZFlKdjlBd3BUbTNGOUNmb2FwQk0wZ3RVRUJlQXJiRTRGc2Vp?=
 =?utf-8?B?UVpYMFNoaWFkWVhaU0wwcDQ1eTRsWlZ5NVYrYW9uWDVDK3A0a0ZLYjBmUktt?=
 =?utf-8?B?R25BTjlSdXJlRjBaSHJFaEFvLzN6NFZuRTVlOXk3MHNMVFB0OWpUdjZMdFBh?=
 =?utf-8?B?aGFmM1ZEai8vNWF0QVNnQ2pvZ0hHS0ZJV2dwSUZQYys2dWRHcXBRaHJwNW9V?=
 =?utf-8?B?MGZUV0poU0JqN0lTNWlObm9kQkZ2cnZweHZwdnVDT1daa0NSb1JkWGRPcnNv?=
 =?utf-8?B?T0hKTWhsc0dMWHlXVGVRSGR1aW5KOUd5VTJFWU0xdzBJTUVqSFBPMjNqT0pl?=
 =?utf-8?B?NUxkdGpnOWlhR2ZHOTZtSEMxbkxsYVFuWVcySCthWHZlSEduQW1JTGhLdEd1?=
 =?utf-8?B?Rjd5MUJnSkIrQlJFSmJoVDFrazBYVUlVZ3Nyak1xQUZyL0RRQnNNY1pBRFQ1?=
 =?utf-8?B?dU5VMmVqd01UVHgrMUlTdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db991097-99c8-43c9-3de9-08d8c874c6ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 18:51:55.3430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTszBqQ1nAZTMx6BTOH4EPujilePzgNhokbfBRDw5/chFvOx0ZSt89O4Q7QRKLdn4O3+UKPEdibzu7shjaFDAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4962
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-02-03 um 1:47 p.m. schrieb Kent Russell:
> Instead of caching the value during amdgpu_device_init, just call the
> function directly. This avoids issues where the unique_id hasn't been
> saved by the time that KFD's topology snapshot is done (e.g. Arcturus).
>
> KFD's topology information from the amdgpu_device was initially cached
> at KFD initialization due to amdkfd and amdgpu being separate modules.
> Now that they are combined together, we can directly call the functions
> that we need and avoid this unnecessary duplication and complexity.
>
> As a side-effect of this change, we also remove unique_id=0 for CPUs,
> which is obviously not unique.
>
> v2: Drop previous patch printing unique_id in hex
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 6 +++---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index a3fc23873819..0be72789ccbc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -497,8 +497,6 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  			      dev->node_props.num_sdma_queues_per_engine);
>  	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
>  			      dev->node_props.num_cp_queues);
> -	sysfs_show_64bit_prop(buffer, offs, "unique_id",
> -			      dev->node_props.unique_id);
>  
>  	if (dev->gpu) {
>  		log_max_watch_addr =
> @@ -529,6 +527,9 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>  				      dev->node_props.capability);
>  		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
>  				      dev->gpu->sdma_fw_version);
> +		sysfs_show_64bit_prop(buffer, offs, "unique_id",
> +				      amdgpu_amdkfd_get_unique_id(dev->gpu->kgd));
> +
>  	}
>  
>  	return sysfs_show_32bit_prop(buffer, offs, "max_engine_clk_ccompute",
> @@ -1340,7 +1341,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>  		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
>  		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
>  	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
> -	dev->node_props.unique_id = amdgpu_amdkfd_get_unique_id(dev->gpu->kgd);
>  
>  	kfd_fill_mem_clk_max_info(dev);
>  	kfd_fill_iolink_non_crat_info(dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 326d9b26b7aa..416fd910e12e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -57,7 +57,6 @@
>  
>  struct kfd_node_properties {
>  	uint64_t hive_id;
> -	uint64_t unique_id;
>  	uint32_t cpu_cores_count;
>  	uint32_t simd_count;
>  	uint32_t mem_banks_count;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
