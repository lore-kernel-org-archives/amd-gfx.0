Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77994C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 19:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7D3113607;
	Thu, 14 Jul 2022 19:10:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03DE5113607
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 19:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgKVVfFw68p4vB5ywCbt+quF5YT2G+BBdJZbJ5UpiAeBE8F4dZKfV1x++eQZk2HHUIh8SASw6rr7s9rO/rDG0DHSMsuVakSoUxqXyDzMsAbjyeua1xl9bMU3F8twVlSMRZEVLJB8pn2FHs9bNs2f3dt0n68xrqo2IaMFY01wUPOEQNGJg7STrqv6BAohTRR5/L7UV4WNVQUbkavjr4l64STNKJc+qXJ5SMgVPudAjX9Q5Ntwu4FehWmI4JwW52H+S48bqkqm6GDWGdUKAKeF95MJQF0THjAQj0em7AXPfML3+U/LB5ZtIYskV9KeWt3JcY5JNwCgQiB9eyo0SMmTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E+9whv7Rynue7KGC+RbFjiLPc3HHRoYUN65VGYVpAZ8=;
 b=Nz2a4BtsYAMOCrdSqRxGO7n5DGV3qBXykpqzEe1CxzizacFf4IStkehSp7GKubzWoCaQb3nYOTHiXNK2teaDatYPUDLgDwhSJOc5vxoLK/Bd+6ZRkvUJUdg8jaq78PIy6+9/MSoqsfO5ZCnlb3GTe9cXVPNrkcqludstP03gtvYcgVCdwwog5Xd3s9CbaEomE1sXqNmojk8Eqdfv/qwoL30dwZbbivICXC7T1AHzbqg18l6nrozuWZZYgP1yE0hkGdgQXoXYrllq0C4UAEb3TUsXAcGHjFk5ycKulRAjf+v005QQmCrSm+8KQtfEicJZiIaEObpQgVwJPkB8lpdZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+9whv7Rynue7KGC+RbFjiLPc3HHRoYUN65VGYVpAZ8=;
 b=K7VSzSM6XUsSLT6Nxct62cwgO8RMYQY/TmxEhLf2TyKneUvqhzAcB+jlFH1F7yNRPXU7SpFDpU2PN1XkqEq7oU2dnynOGNDeowb12gTq2iHkRT/RCPLEjkYnDQd6SBwF3uZZY4FBpHuaRsoMhUMebzqnH8CgxRfP/qSI8NAVB4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BY5PR12MB4004.namprd12.prod.outlook.com (2603:10b6:a03:1a8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 19:10:13 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::40e5:7df9:d8d9:4eb1%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 19:10:13 +0000
Message-ID: <531241cd-27c2-b3a7-c601-782a7098f694@amd.com>
Date: Thu, 14 Jul 2022 15:10:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH 02/10] drm/amdgpu: Protect the amdgpu_bo_list list with a
 mutex v2
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com, timur.kristof@gmail.com,
 andrey.grodzovsky@amd.com, Yogesh.Mohanmarimuthu@amd.com
References: <20220714103902.7084-1-christian.koenig@amd.com>
 <20220714103902.7084-3-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220714103902.7084-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef8cbe3b-562d-4d09-bce0-08da65cc7a64
X-MS-TrafficTypeDiagnostic: BY5PR12MB4004:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m2U46B9K+2o+IaltDbYfcIaZJfQv6i666/Zn+jo9kPZP5wpBO+ux0PGEGtPOP1MUXvJWfOsrhX3T4xeVZbHW1M6BDH4LZYnOI+5beWOnfjdgqYx6YD1lN+T5WRi12kzAo01SaXXJhud4aocrfp8kgglBOqpdoatnt/xfL1nKPfmf++mF0w3DS6UL/AHY/2n8RPJOGUaDPGZKoiLowxgr0GyyZVg4N1Wz14B4xIHiqpOzw5o6rTZCNMoldnGIAKbcmjmfWepd0Mx6rvSxvMRvFHOkWCnyGoVypE4r1J8b/P8JOw04U4KDJsHcW8a1056ttaEcH+tn4K+s4WAWcwmD5MY5mFmSxgmxnUoE1+Ulnzu2X0QjTHUkD0ff0mAzOczi9znIrzW6STp6ihhNK/uG9I14x/dw5cWI7sYTZVpdRFIg0lwSAzaT1KaJOcckD0/m/WqhHDuvTd+kg0DzuMXxNTK5LAbo+ASjuw6WQXiA2LyGC1J8AM9XYGwoqJRfmC7xi3InaUTmZOU/tdxOCCB7L9OChJxfDFNNo69jVAHFDy1nZPT1b1jlyYR3ZcYGfGLQ74ULlVm7qh4tqq3OIXRV7YHWaLgUWyVGbL0ZVwJpOKd7vLGX/b5H02egZr5bLR40ApG/lreXo2kPXJHHNf4Q0sIRPFk3xp6IOskXVT5Qw/Yh90Lfzsyk2RRh3PdqtMc7Q6F/OP5Frefw5wuQRXhdjGgLnSIQy7adJoiZuX6BEmjDDWA0uMbn/nx18KRTrLfAFWD8TPqr/8BiSUengMiJpn9PVlZhHqVQAjAo/1wS6os=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(66476007)(6636002)(86362001)(5660300002)(66946007)(8936002)(8676002)(4326008)(66556008)(316002)(186003)(38100700002)(54906003)(6666004)(6512007)(26005)(6506007)(2616005)(45080400002)(53546011)(31696002)(966005)(2906002)(478600001)(66574015)(44832011)(6486002)(41300700001)(31686004)(36756003)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzV5bjBnenJHVURsazd1c1pDbld1bW5uSnpCUnFHRFV3TUloZGpzYlFoVEw5?=
 =?utf-8?B?UGJ4bDcwbFh4ZHNqTHFrbmpyVTl3d0JWMS9GMko3NFZUN2FqZXVhSDZqTTdG?=
 =?utf-8?B?VzFBV1E2MmlyZ2E5aFZvY2RsQ21kSXAwRFZpc0ZMNzdESThBZElkNlRGQnV3?=
 =?utf-8?B?cE4xeFB2Tk9jaFpVYVQvV0tRU3hQYkplQWdxOUNqWFJuQVJyYVFvMENEMmoz?=
 =?utf-8?B?dGtBSmwwb3RSK0NuVUF0S2dJYmhnRzNZaWNCaHhUZTZ0ejVURS9kZ0tuOGh4?=
 =?utf-8?B?V2ZmU2R2b0xSM2xxVi9sVFJiZG1oaDZKMGI3YnA1RlN4ZDV4cWM2SkZhMGhk?=
 =?utf-8?B?MGwveGxlN01kRi9UNU9EWHJsWWVpVUZNbFlaKzFzZnkyTFN1c0hoUVQzQ3I1?=
 =?utf-8?B?NjZoS3JjbWIxTHlZMjZXMmpxTUlpb1diWWlmTmlvQkd0NVc5LzVNbVZ0ajNH?=
 =?utf-8?B?ZGdVUUdGWTVOTEljTStpNUNRc0tFcnRXVDJ3azhMOHB3cE05NTh1OStkZDR1?=
 =?utf-8?B?R3VKNFRYdEM3aHErSG52OHBHdGo5SjVmTEE4K2JNbjZRdWhERlpnU09MaEtH?=
 =?utf-8?B?RWxJcWZHdEdRbFp1bExubStkblZzRjhQT0xvSGZTeG9oWWxaUXR0UFdyWHg4?=
 =?utf-8?B?Q0Z2UEx3Wm1aVms0V09Lb2hhQlVWejZNRTNhVGM1Um1jTHVSdzROdTRuZHdm?=
 =?utf-8?B?MWRXM0Qvdk5pZ2Q2ci9KVFZBWHlEWVZPL2JVT3VDSUFKdTA0eGFGV2NJbjRQ?=
 =?utf-8?B?QXRKNGZpT1FDVnFvN0Q4NFJIMm5VZDZlZWFlWHlnb1hOcFZycmE3cUQxR0ow?=
 =?utf-8?B?TmlHc2ZhR2pPcUt4MkhWNm9lL2lqQjRRRE9LcS9zY1diaWRwU0RlTXRTL01w?=
 =?utf-8?B?WHJSRk4xRFRoVEYyMFl4TTllb0g1YkRGVTZVL1U3V2hHRDNVRjgvd1dlY2Rv?=
 =?utf-8?B?d2piRGI0em96NkdrWGIxK1V0cEZvSkh1bXljUXJ5b3QxUnI5RTU1Nlp6emYw?=
 =?utf-8?B?UUphTDkzZ3hjb3Fyc0dzOXpvWUNlL2tYSFFMTzZOOEtLNXNjZ2cvRTVsU0l6?=
 =?utf-8?B?TDlKc0NjdmplYmtGYSs0VGsybHV6YUJRdzRNSTRnRFRHYnFuUnhvY1h5bFJU?=
 =?utf-8?B?WEkraGJUWXlYY3I5eFZyRmtlUVhwSDNkcm80clZBTlpHQmp4cW42U3VIQkZm?=
 =?utf-8?B?UUYrUHJmM2VPS3RoS3BCbkNaZm1yMHVydDZraWpmSUIrK3doRFZHek85MUc5?=
 =?utf-8?B?emNsOExLSUpPVC9KeU1Xd0l0MkdxNHpRa0JTalJNR1Z4dTZwVjhIVUJvTkEz?=
 =?utf-8?B?RlNJZWdYMStkYkpTNGYyeGdLcCtoTU5zRFpDOWo5T1pDUWVpc21WaGdVQjJN?=
 =?utf-8?B?a2Q4eDlSZ255U3VUNUczczB0UlQxdzNwSmYwMGRmakdIVVJHRGJibEtzMFg5?=
 =?utf-8?B?QUJWdTExTzV5RldOckVJNENIUTZhTFlXalpwTURPdWJRZHRzVCtpcjg5OE01?=
 =?utf-8?B?MGxNYWJNTk0rZWJEbk51NDZxckYrQUU0VVV3NktVSkQxOFVWVHZxRzY2d0I5?=
 =?utf-8?B?TEpQcTdGb3ZmTFNiSGY0SWhXd1p3TmdsSXgyT0VTaWhLZWFJQ1RIYXNzUFc2?=
 =?utf-8?B?STJobldxVFZZNkFmN2hHbmtydms3bGw5OUtnS2xBa3NsYi9TcS9IY0hvdElB?=
 =?utf-8?B?TWl1UktQSzNrOFFwbnlxZm83c3ZOWmxON1IrSUs0dDVSelNWdkdqTmp3bFlY?=
 =?utf-8?B?WTVtVnVBb3Fab0JTOEdRU2IzMHl3T2xvd1cxYi81ak1LMElnZ01ieVN5WmJE?=
 =?utf-8?B?aVpwc2FKTmk3ZEx3ODZMdk1IQkhaTlBMa2Q1RlNhbmVDS0gxVFpBcDNVcDM5?=
 =?utf-8?B?MUpkQUNPcEdwNE15amlnLzIxdXhjb2M5V3ZiOVQ3UU5qRmxXSjMwZyt0TUhX?=
 =?utf-8?B?cFVyUEtGb1R1NGtFZUlPcmpMNWxrM1RzbnFBTnkzcHhBUE51RUd5WFo1aWtR?=
 =?utf-8?B?T3JOZVgrd05GVWlJcUN4bkFDVUxHM0htT1hvV3ZabEE1RTE0emZ6bHFvc1Nv?=
 =?utf-8?B?aUpucjZ6d1duRE5weWhNNk9xV1lxWXVQOUxoeWZjREVIc0JLeUFubEpaVmJv?=
 =?utf-8?Q?uvG46CnP03xEfXr4bdXLw1pmM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8cbe3b-562d-4d09-bce0-08da65cc7a64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 19:10:13.1408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3fWQtspe4B4Hedhe55qWyjf/JSLwk96+7yqLuWvtaTifa4xcSqVA6SB6CSGE+/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4004
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tested-by: Luben Tuikov <luben.tuikov@amd.com>

This passes all IGT amd_cs_nop tests.

Regards,
Luben

On 2022-07-14 06:38, Christian König wrote:
> From: Luben Tuikov <luben.tuikov@amd.com>
> 
> Protect the struct amdgpu_bo_list with a mutex. This is used during command
> submission in order to avoid buffer object corruption as recorded in
> the link below.
> 
> v2 (chk): Keep the mutex looked for the whole CS to avoid using the
> 	  list from multiple CS threads at the same time.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F2048&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7C13c905354c8b49ca582c08da658514fe%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637933919507590618%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=CIO%2B%2BfexpAQFjyyy%2B6ZeTXQEEyrR9RIei3wEFq4OIaI%3D&amp;reserved=0
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 +++++++++++++---
>  3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 714178f1b6c6..2168163aad2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -40,7 +40,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
>  {
>  	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
>  						   rhead);
> -
> +	mutex_destroy(&list->bo_list_mutex);
>  	kvfree(list);
>  }
>  
> @@ -136,6 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
>  
>  	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
>  
> +	mutex_init(&list->bo_list_mutex);
>  	*result = list;
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 529d52a204cf..9caea1688fc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -47,6 +47,10 @@ struct amdgpu_bo_list {
>  	struct amdgpu_bo *oa_obj;
>  	unsigned first_userptr;
>  	unsigned num_entries;
> +
> +	/* Protect access during command submission.
> +	 */
> +	struct mutex bo_list_mutex;
>  };
>  
>  int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b28af04b0c3e..d8f1335bc68f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -519,6 +519,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  			return r;
>  	}
>  
> +	mutex_lock(&p->bo_list->bo_list_mutex);
> +
>  	/* One for TTM and one for the CS job */
>  	amdgpu_bo_list_for_each_entry(e, p->bo_list)
>  		e->tv.num_shared = 2;
> @@ -651,6 +653,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  			kvfree(e->user_pages);
>  			e->user_pages = NULL;
>  		}
> +		mutex_unlock(&p->bo_list->bo_list_mutex);
>  	}
>  	return r;
>  }
> @@ -690,9 +693,11 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
>  {
>  	unsigned i;
>  
> -	if (error && backoff)
> +	if (error && backoff) {
>  		ttm_eu_backoff_reservation(&parser->ticket,
>  					   &parser->validated);
> +		mutex_unlock(&parser->bo_list->bo_list_mutex);
> +	}
>  
>  	for (i = 0; i < parser->num_post_deps; i++) {
>  		drm_syncobj_put(parser->post_deps[i].syncobj);
> @@ -832,12 +837,16 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>  			continue;
>  
>  		r = amdgpu_vm_bo_update(adev, bo_va, false);
> -		if (r)
> +		if (r) {
> +			mutex_unlock(&p->bo_list->bo_list_mutex);
>  			return r;
> +		}
>  
>  		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
> -		if (r)
> +		if (r) {
> +			mutex_unlock(&p->bo_list->bo_list_mutex);
>  			return r;
> +		}
>  	}
>  
>  	r = amdgpu_vm_handle_moved(adev, vm);
> @@ -1278,6 +1287,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>  
>  	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
>  	mutex_unlock(&p->adev->notifier_lock);
> +	mutex_unlock(&p->bo_list->bo_list_mutex);
>  
>  	return 0;
>  

Regards,
-- 
Luben
