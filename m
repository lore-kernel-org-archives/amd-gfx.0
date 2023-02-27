Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA22CC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 12:53:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B74E10E3FE;
	Mon, 27 Feb 2023 12:53:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 537BD10E3FE
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Feb 2023 12:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT/H91AKYA1WLRUv1uFo2bJXfZZT7cDgTYAZc+kYWPpU6Oku7sKBfsiGuBisxaLsSC6tDP96XRy/OcbhGbgmxTE8kZYqqfd6JiCMNUsJvomZ6e2/jfMp1zLP/5Xdrfxjlh0drlFbKdLnbrPJzaVG7PFPCmpC3GmUgHt+1nEFpUWMYWEeb569Ejigpa0a6zbNJO74NgOvt6vz+OtNBFwo7ydcNaME5bmzTPcdiEu4wyRLUMQVSwXqKTY4n3gfRI1NDh+KrEqyUsDzMTX4axcUdOeQ92MRlXmV9QtTBmm12bO2NCxfGDo0EMAf7i5FfubGudze4N/ZLGeEFN6NnZtrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ6SGKZhVOoJhErkmYgjI0yMJQoO8p2F75Ch4qZg9xs=;
 b=OoWrftSg/RydhZKwAaYo3cvHbhu0imJ0tz2kzNr27NrgsKfWPkE7jDHQjFNfnjNsMByJnSc+PQCJ4Ko6t0TJ7w7oiKzkeovbAuUZKG1ZmFnfP4BFuzsVkq8LCS9KTIz5Vv6TtS8eZA7DKwWVuyXuXF4SZbEmxHpvKAGLjmmlCIP8YlUd+MpLq/rejBN5yPwQ5Y2dRnKbM/hBDGS9b3lCs3OR1xAH7XVKwxb11+7Qzu68N+guKZ9wKvkisIlpklr4EBtxBg/pyGJh9fIR3ofUUdY2qRLtl9b1aaqibvmIN0SUyIAvcj2gtnWkKnYT6z148YYjI1sFE1jOXS8S4RQpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ6SGKZhVOoJhErkmYgjI0yMJQoO8p2F75Ch4qZg9xs=;
 b=r5ORqpExehKoDU7NWr0WknswkZaeZdi/sykmSj0bcmVo3j7hRtmoguG8AvXvAM6cUzPgdSKwYGkfeG7BUFWh05nlgQwyO2cml3BIHBXUul1YaHITTx3GVQKb8UOtHdb3mKRufGGNX9rkuS2rJDopa4InJp+uy9tRP4UEKe0S7Kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 12:52:58 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 12:52:58 +0000
Message-ID: <f4a2d704-5096-e03e-84eb-863956bcd963@amd.com>
Date: Mon, 27 Feb 2023 13:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/6] drm/amdgpu: UAPI headers for userqueue Secure
 semaphore
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
 <20230226165435.41641-5-Arunpravin.PaneerSelvam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230226165435.41641-5-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH2PR12MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b426f54-5e00-4db5-7318-08db18c18d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l8yzyItgbIUZcCWvJ0kkIrxafSrBpPi9kUQylY8AhkmMl77ITfwD5rUcRuP4jcjmHFsiBSy2ktWZA8xW2FYhrhGkPBDhT5aEKAZ99ykHE4ZJ7GOPOSibM4TJ0hlEWQkJmUyOtqClR6gZoEV5xb6sQqla9mHQz0VymEz9Ne8tJVAqtQzfDRU2nQye1dBxqvrDqIR0ew2Mf5RX/H+KSCDxVd3tyK+1inbwu6XcHLKVKS8p4Pljs6ZdQtrr6HXFjIi4s1d537h0VsdxNLMt8O6/aaL+ZzUuxezQ4k/5AV6+TAF2aFTk3i2jA0C7uorCWZWCLJxb9CGwJd7Y9v7RswhFmJFQyoXy6dpCQP2nt8zqiABSyGhR3GdesVTPAZi+IsBOxzVHVFUioqVqDzwLd8IklYfH0UGCTHBzbtSYpq15b9xSO2j2dKAa2JHZaRAQwklNlqxBjjRWWoc2UbDJieKGCZGZty9Kb0UH6OSsBHN3oZP8cDLPKI/rrA/tGyvGB8OsI+fn7CRtWgbTreuFv8ORV439pnF18kgr22BqHugJudvoRlLv0MCDMM7kHct2Bx3JarniHWjmYMyBHRHrNOUs7Gij5SGRr8Vvv+p4v46NfvIupqOa8YmOSc8+jZRNPaaiD+fuqqzni0wznZolBdiOzMs54vJSlk1ilAldRhhJCbs/9Tv2NuAeYizEh6ztmteMTyRCEdrATBVug7nd9YJFxeByHw+a37RwcWD/A+QEGIQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199018)(2906002)(31686004)(5660300002)(8936002)(36756003)(66476007)(41300700001)(66946007)(86362001)(31696002)(6486002)(66556008)(4326008)(8676002)(478600001)(6666004)(6512007)(38100700002)(316002)(6506007)(26005)(186003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXprWDJ2czhhbElmNlhrTnRJWkZlU21adHNob3NtVWNXMDlCRDJmS0xSbC9q?=
 =?utf-8?B?MVBQWU9mbUdNVVFWQUhlRG4zMGRCbi9kSXpidFZlZFZJTUZaTjFtWUxVdits?=
 =?utf-8?B?ZWRvNy9Bc1Y3dUVaYXlueGtobHl3RFdQVWRQRUludXMrRUhPUS9hUStYeStn?=
 =?utf-8?B?MWY2ZzIxcVVwRUYzUlFaMFhiYXVHellXRlo4N0JOcHdyODNjMGZoNmVodDY2?=
 =?utf-8?B?M0tJWGRiYmpCRU44NEFFclpGcnRxQkd3d21lZm54QmxzWlpKT0pmYXdYMWtD?=
 =?utf-8?B?Rk9scWlVeHVwVlV5U2ZRd0lsbzNmc0l1bnFSRkUzT0hJREs4ZGpCMm5OSG9O?=
 =?utf-8?B?bThnTkk5WkJEVnptMTZHOG1TaEYvQ0ZXVXcvVlE4Ni96eU5NSjR0SXhTRUhh?=
 =?utf-8?B?YjlINFhuaXZwMHZ6OW9qbE9uQWhzOU9aSXVqcG5kaXhoNXUxSTZoUHdYMTN1?=
 =?utf-8?B?MnFyMmRiRDNESlJsbEVRZTFCMHovMnBqcFMwSFh1RVBCWkxkRXRVYW5hSGh4?=
 =?utf-8?B?RWhQUzVxV29zaFlXSjY2OURhOTNVQ1huOFJCTENnTUZnd2dNdkU0ZGEvZHlp?=
 =?utf-8?B?aDIrVHpIN09EY3JaVUViMjduV1FTSzZwbExObXJiaXdDajdCbElUVVBXQ0xF?=
 =?utf-8?B?d0QxenZIbXIwRWE1NDhEZmhSeUNWUXhsSXRJdjJJcVg3WkpuRHFuWFdJaWhL?=
 =?utf-8?B?SmxocWJiSzRkc01IaDRzQlNyaVZBQlJnTU8wYVdIYWZWOHNYOE5WVndTRmxF?=
 =?utf-8?B?bHlTY1lMRUR3b2NRaVZPYkVocHhzbW1MNElSQ1h4bmlTclgyZ1JPNjJRenhY?=
 =?utf-8?B?VUs0Mk5XZGREa2JnSkF4a0cxK0FzdzMyT21tOStNWU14M2pSOUdrU0s4S0NV?=
 =?utf-8?B?TGI0THFnSjhLMnJ4cS9Gb0VwWWNOVFJTdWVGa2E5R0cyaG0wSk5qS0RYeDlJ?=
 =?utf-8?B?TzBxNWhabjhBclk0MlNUcTFEUEJSQTBGOW9nTWxmN2dUNUNJeHVYZ2JWQWdY?=
 =?utf-8?B?UjNFbDAycjFyUllmclJyTFBCZWhWTC9CdkVEdUJScE5ld2ZSZ05ML3pGaGVS?=
 =?utf-8?B?TktLcS9mQ0FVc0lMWHV1a2FCM0FhNm1BbDNNeWlQNmFjemRQcTJnRG1RRWd0?=
 =?utf-8?B?TG45VGhTbG9LTERzSTlDbEs1M1dxSlo0bWFZenRyVmEzSjNjdmpSbGExRm5s?=
 =?utf-8?B?MnpJakdjbVpIVWJLTWJHczVYQUhmWWdmVlUzWTBhUDk2MU1jWHZKRTQ4aTJI?=
 =?utf-8?B?K254TnF6U1cxMVoxbGF2QndxVC81dUpIVGF1ZUR3STY5R1U3aFVFOFFHY2Ro?=
 =?utf-8?B?SWtFQ3BRVDVReDRTak1rMWVNNHB0bWN2cVNoQUVwcGxWMkZWeTJhbThjRzZk?=
 =?utf-8?B?YmQ0bzBTbWFJMG53aUNxRFZzSjBFVGJuWDZNNEc2REZ5cElCV3NJRlI2dFhP?=
 =?utf-8?B?SW5QR05qMjdWWHFRaGplejZrZk44RDBlQUh3bDZEcTlNQkNXelo5eXVmeVk1?=
 =?utf-8?B?R0xwalI2VFVIT0pyV0M1eUFTS0Zsb2NQUGxtcVBIWitqSVNBRFBLTzk3aXRq?=
 =?utf-8?B?bXJiWGtSRGU2aEorRDAvU0N0RWV4TmtuMFZPYlIyRnZMSHVDWGYrRDFYak1u?=
 =?utf-8?B?VFFyaUEyT004U1hjVnFuRUJ2a3E2aTNDNHU2eTVBeDZmL21CRU1JTXVKcnZi?=
 =?utf-8?B?TmRxelB4SHpsTFNKS1dzN3luMGxGZ2ZWRDlMN2x5eE9CdmUzRWJ4bXhyR0Jl?=
 =?utf-8?B?MG1OL3JsK0FrNkx6RkpvZE1VbG1TQTE5QVFXemplZWRnbUhLcXlxRU1IaSth?=
 =?utf-8?B?aVhqa25PZjBkcFRhelY2N21xaFlPS0kxcU1IZ3p0RW5PVmNmelhCdXFkVStx?=
 =?utf-8?B?akZyZDFRakdWZGt0eUN3V0tySDBScUlaeG1XWm5KNEIyaUwzUGxra0RBdWJX?=
 =?utf-8?B?VFBXdGZCRXZ3Mlc0ZzR4WHBlUjgrOVZzbVJuYWY4MFRST2Q5b0pjb1loVDFN?=
 =?utf-8?B?dGx3YUZEVTJDZzhoMTVPaUxwMktUeFZvVTNHSGFwZXFrSW56cDZsb2h6OHcv?=
 =?utf-8?B?VzZ0ZmJTeE1PUHZCdmZjYlhBVy9WUFJlbEdzWlIxSW5kL2pteDRDV2FpMmpv?=
 =?utf-8?Q?OCugNbyCEFomxClPxS+yYoXMU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b426f54-5e00-4db5-7318-08db18c18d69
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 12:52:58.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3Oi8rJ0rrt8dDSvl6uVFN0qVsJ5aGCUTOTFbfdj74XZNaJPIWZnEAG/iLlE4J+y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
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

Am 26.02.23 um 17:54 schrieb Arunpravin Paneer Selvam:
>   - Add UAPI header support for userqueue Secure semaphore
>
>     v2: (Christian)
>       - Add bo handles,bo flags and padding fields.
>       - Include value/va in a combined array.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   .../amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c |  1 +
>   include/uapi/drm/amdgpu_drm.h                 | 46 +++++++++++++++++++
>   2 files changed, 47 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> index b8943e6aea22..5cb255a39732 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
> @@ -22,6 +22,7 @@
>    */
>   #include "amdgpu.h"
>   #include "amdgpu_userqueue.h"
> +#include "amdgpu_userq_fence.h"
>   #include "v11_structs.h"
>   #include "amdgpu_mes.h"
>   #include "mes_api_def.h"
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 2d94cca566e0..bd37c715f5a7 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -56,6 +56,8 @@ extern "C" {
>   #define DRM_AMDGPU_SCHED		0x15
>   #define DRM_AMDGPU_USERQ		0x16
>   #define DRM_AMDGPU_USERQ_DOORBELL_RING		0x17
> +#define DRM_AMDGPU_USERQ_SIGNAL		0x18
> +#define DRM_AMDGPU_USERQ_WAIT		0x19
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -75,6 +77,8 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
>   #define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>   #define DRM_IOCTL_AMDGPU_USERQ_DOORBELL_RING		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_DOORBELL_RING, struct drm_amdgpu_db_ring)
> +#define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
> +#define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>   
>   /**
>    * DOC: memory domains
> @@ -361,6 +365,48 @@ union drm_amdgpu_userq {
>   	struct drm_amdgpu_userq_out out;
>   };
>   
> +/* userq signal/wait ioctl */
> +struct drm_amdgpu_userq_signal {
> +	/** Queue ID */
> +	__u32	queue_id;
> +	/** Flags */
> +	__u32   flags;
> +	/** Sync obj handle */
> +	__u32   handle;

Maybe rename to obj_handle or even syncobj_handle.

> +	__u32	pad;
> +	/* Sync obj timeline */
> +	__u64	point;

Same prefix here, either obj_point or even better syncobj_point.

> +	/** number of BO handles */
> +	__u64   num_bo_handles;

This can be 32bit I think. And when you move the bo_flags after this 
field we don't even need a padding.

> +	/** array of BO handles */
> +	__u64   bo_handles_array;
> +	/** bo flags */
> +	__u32 bo_flags;
> +};
> +
> +struct drm_amdgpu_userq_fence_info {
> +	__u64	va;
> +	__u64	value;
> +};
> +
> +struct drm_amdgpu_userq_wait {
> +	/** Flags */
> +	__u32   flags;
> +	/** array of Sync obj handles */
> +	__u64   handles;
> +	__u32   pad;

That padding is misplaced as far as I can see.

> +	/** number of Sync obj handles */
> +	__u64	count_handles;

Better let's us use num_syncobj_handles here as well. And u32 should be 
sufficient.

If you re-arrange the fields you could also drop the padding.

> +	/** number of BO handles */
> +	__u64	num_bo_handles;

Again u32 is sufficient for the number of handles.

> +	/** array of BO handles */
> +	__u64   bo_handles_array;
> +	/** bo flags */
> +	__u32 	bo_wait_flags;
> +	/** array of addr/values */
> +	__u64	userq_fence_info;

We need a number for that as well. It can be that a BO is idle and has 
no fences and it can be that we have tons of fences on a single BO.

The usual semantics is that you call the kernel driver with the 
userq_fence_info==0 first to get how much space you need to reserve and 
then once more after you allocated enough.

See function sync_file_ioctl_fence_info() for a good example how to do this.

Regards,
Christian.


> +};
> +
>   /* vm ioctl */
>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2

