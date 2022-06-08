Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C352C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 19:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC77C1134C8;
	Wed,  8 Jun 2022 19:40:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5E61134C7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 19:40:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxpfVkJQiEQ2qar1p7oRdxef3+hEm3S71s7keP+RjLvewwuPuP8AO4ktQCw5WojPSrn1W8oN6ETIRxOAAqglodhh6iJcDxtFL2qPDl16ETDpCaJYR7Beu9wYKYDbxfXPez7pmc98OGHi0v9U5DtSB8byz4dhhN00j42sm9ta3uXzX/YlbmqXDH9yjilJzbXnxemqkgaL0TEdDao1i/04Yf0ctBtrvR9T8+wb5hfPiW/NQgdxa3gibAL3/w2sTO4ID7/xk+CumT5Ii+bky9NHgmLks3jGkQUzxqRgvi2t7iu/5tuzimaeFB+kqunWRWrPxfghe+xjCAaqBVwUJbM3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzjXpciGIp+eMNXsRwIbSNynuIOkaqv4DCYpshabnJU=;
 b=Ub3Kl1oCMFqyQeVrPl1sJyoAHJc1PJkl5xEbmLyNMp0a1+fIgD1UnC6L0YFXb+RQ3sQFbHomFVGgRGy1iBvH9QNofvrI00i6MkAte0bKIbLGmn1QQcOcsYF3kYZnnzQQEZCZ47b43bvzSP1viYVQc+UBFXQls3BeuL3mJfIQj4GKOi8kRMABaZs1MAe6ohvbDEJi9Bnkp5Nc8xFdh3ZcTPK+2EYjrDpgBgG1IA76YbDPnUOLfoqHO0KQ69JX7c+Vw9n0pPfUBT+uStxoJpWtH9z5SvjcLGusjC2wbM45ScSxGD8722XxdMd9JRnTwGg8yzcgFsIhcb2Mj9iBNa1DGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzjXpciGIp+eMNXsRwIbSNynuIOkaqv4DCYpshabnJU=;
 b=4HIpDAHaU91LhurhcH5vxTRDuC6XixtZhb70TN7KFrrT42AR9VCA+/Lovzu6bbC3ovnz7qPZalKC6tLcsLoBPNj5AhEfOu2ofXwm5CPJvky7knHM6pTkIxw5Fb5xFgmOGw+sh4A2E3Nvojt3geVWdDm5PpKIbSo2KQ9XHlz/6PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Wed, 8 Jun
 2022 19:40:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::1cf6:2a9d:41d6:e8c3%4]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 19:40:04 +0000
Message-ID: <8408f1eb-034a-7600-a62d-90a4f5b103ff@amd.com>
Date: Wed, 8 Jun 2022 15:40:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: Remove field io_link_count from struct
 kfd_topology_device
Content-Language: en-US
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220608115133.1807445-1-Ramesh.Errabolu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220608115133.1807445-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:208:23b::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ad05973-eec7-414a-2d19-08da4986af75
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2575F73F42CACB2F3A699AD792A49@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T/CpbuKzMRUaIhAYwNDHEhJFanI+V5Wo2OBkhLCHQmbyhtcmhdGqX0yoQvWw8LPn3gO5yTvhikDYzHu8D0xB1nWOQmcFLwp3jGXiwGt8EvowoSiE6ET5mToy+9MvnEu2FOosVajk7WpJ9ytH+vKJmhmWMUfdAbCcC3VKogO6x6vuj3xHCsoSG/eZUu8pwuUdb7D20lp3g51YeqdjwJglDbUk3y/Ob4n8naKt8Zx3riZoaQVGnW4zOBN2gMGtvzD9oS8dc/85/VxULaXjLKc/vQDFaj79Vvpi9JQyNTBWrqR8YwSvO0r/wYz/O4IkxJlp8IuDj7eipklOgkzIlxt2gBn40x/6xSMOyzNRkbwMDR0fw5rOtu8SshDMqT2+5rtKghOFLQ+737UzNV2xFd0Lb/AIxmOn5+pzSRUE8CYztiHtmqdYbRpSC7zo4AczcMqUSosI2gBkZv3JHcjFdSe0d+8M2ONClrXV2QF/GJwxk9ZUWAl8kZINxI4pGeoXWVDEsaVRgrdyb/h1fIo34W25CooOItDhYDmskDK/bV8p4RiKhlqsrCqLxYlHkH6Ypqoo9OdP11VfftNATqbjlh94zwFlQ1+cqI9AME5tqtIq8Zw9JPx8Vsn+4ZvHjAsLwElHiexVZRnTGpVGHMR5dwiRJFX/fdV4GxxRHv0VAV9X9cm7tP18+kyn+5tzgR2yXelF+DvZIac2PtCyxHI7BzmC9K9tH8ZxUPtdJY1f6yWh5ikNd4R1dMTQFDuHBMswKBSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(186003)(2906002)(36756003)(31696002)(86362001)(38100700002)(6512007)(26005)(6506007)(316002)(44832011)(66946007)(66476007)(2616005)(66556008)(8676002)(36916002)(5660300002)(53546011)(31686004)(83380400001)(508600001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hpR3g4cnFud2tQQlNLRGxrc2lZMVJ2VWxtUWU2OTBaYS9FSTAvZFNhUytq?=
 =?utf-8?B?d3o3VU9HY2huVEtEY2I2UUtnNFUycGhTTUhaRzJoRkNWNDRQMnUxNnd6TkEz?=
 =?utf-8?B?QTFodlY1YWpDT1Z4N0tXYTNCK08yWXVoS0YyLzA1elhYeW16a29iMlExaHdo?=
 =?utf-8?B?dGJIcnBFdVB0VkJvcm1ubFFOTUxtNHNudHQya3ZHRytXL0xIWFVGbDNiaHFv?=
 =?utf-8?B?R0dNNnhIUVoxYm16ZGdWUjI3M2pIa0Vsa2RjT2Jhbm1nVHN5UFNwZE5OK1RV?=
 =?utf-8?B?by91ODVZWEo4LzRmM3lNZCsrcGs4dkQxRnhHQklRdkQzUTJHZzN4L3grMy9l?=
 =?utf-8?B?eWhEZ2JxTW5McE9nelRyK0xLM0p0TDJzSXRQbXBXL3lqN1ptNVpYODBId010?=
 =?utf-8?B?UUpCUUFUMlpIUlVBRmkwSGFwVmhNcFRzNFc4cEpIaXh2QWRUeTlCRHRJZlh1?=
 =?utf-8?B?YlB3cUl1VllzM1ZXbXJIQ2ZlSjNLb3VidG4xeHQ4SUdyL0ova1MvaGNxSG5j?=
 =?utf-8?B?WW42TlFaY0k5aGE5VngrNlhnbVE1MXU0YmdRTGxiOVNyVVFLTkZNQTZORXZz?=
 =?utf-8?B?emhUb1NIekZ5c0dGNU1NcmJoSzlONlRGVWFQeUlwdXQ4cmx4YWwwa2U3ZFhE?=
 =?utf-8?B?T2lEVDZXWVk5ZjRtQU9nb0d4L1VWcXBVdVZQWC9VVE5WNjJUOEVkRXdQbXRn?=
 =?utf-8?B?MmNlbVVJcWlqR2duZGY4aXpMU0picUR1L0ZGdGdra2dIN0piVzg5NVI4dUdM?=
 =?utf-8?B?d0xNbUhETkxIM2t3elNwazNrSTJYSkhSR05jcnV2YVVtRTkvbmJKRTVBRVhK?=
 =?utf-8?B?ZG41c3lpVU5KSWc1aC83MDBMMGlQYmtyUkZWV0gwU3k2WnV1Q1VqREJCY2NI?=
 =?utf-8?B?MlBseTQrSmpaa2VkZ29KWU4rcHJKTzRyZHZnakIvNFJJWTdJS0JZeThOcysx?=
 =?utf-8?B?eGFXa3VFS1piWGV4Z1VRQzVaZTRNR2J3dTFCZlFuZ3VYSjdzV3h6OFZEWThR?=
 =?utf-8?B?RmE3S3BTY1J0eEYvcWxEc3BaWVNydXlMdzRDdzkrbjJMczA2RDNIUjB0bVln?=
 =?utf-8?B?blQxK0VKa05QVnB0QTE1aUh5V0o0djVVdm9HVUVhV1NGbGRVM04yU0VmWXNx?=
 =?utf-8?B?Vmg2aE51SVdXci8wZUZkNVVxSlFacks1bEZJOStEak1UUEpEU29KZERTQmha?=
 =?utf-8?B?YzBwdVFNcWxnV3FlTVdHTkxBSllSQmk5QURwQldTbDN3MC9zUVZESjdEMkI1?=
 =?utf-8?B?UFZ0U093Tk13ZGJiUUxSWmNORjNoRlRNbEdGMmIrWk9WMFpnOVI1THh1ODlK?=
 =?utf-8?B?S2pBZi81UTkxWllhTFFia1hQa2ZUVnVqN0lHdHBuWW5UR0RxZWNKa3pMT3lD?=
 =?utf-8?B?eDlMZDZEUnBsajJFUlc0Z0NWTmdNK1VZNVFtRlh0TkZraFRpRjRWeFpFR1dC?=
 =?utf-8?B?aEpFUEQ3amZVb0JrQzlYOXdwR0trMEo4bmJpakFoVkVqMGc3azNsTkc2MHg5?=
 =?utf-8?B?RHZSS3VYOTJaMnlJMXFBT0RINlZGVDlVV05aWVJMQ0ZBbkpQdjErWTZDK1hV?=
 =?utf-8?B?NFlhV2Vwb3JNYXgzVDlmY1htRzFYeHdZZkx2d09LQytmcWtCejcxSFV4blN5?=
 =?utf-8?B?aW1tQ04rdWhoaDlraEM0cVBoR0pjemdXNndZeEIydm5DVFN4dmdod3duanhB?=
 =?utf-8?B?MzQ2R2U2RnREeTlXWFhTaDIyeGttRzc4SXJHR0N6YnQ5eTVxRUs1ZzRWY2wz?=
 =?utf-8?B?TFVHcUU4TW9QbzJBb1Mxbm9jaVpOM1pxeFZaY2NOVEhsVko3UHdkdzFNUUtS?=
 =?utf-8?B?ejFGQXVXWVB6QjgwZVFaS3Z2anB5WElaNW4wc1U4T1U3OGtkcDhUZTVKb3Yr?=
 =?utf-8?B?RUJZbGl6azNmNmc1QzhMUUhidWlZNk1ObEZrOXpBU1BkZUNyV3gzV1paWnhG?=
 =?utf-8?B?cnZHWDZGbzhySHRGZVFwd3M1aXkzczl0VmdGbjZCZWhlMVJXNFJ0bHA2SjNa?=
 =?utf-8?B?aDNhR3dTa2d0OXVma0lrV0JOZW95VUJTeFZwLzE2SndhVDhJM1hIMXFOVTkv?=
 =?utf-8?B?MGlPYzNWSERweDFLYjJreXpvMGlSMlZqT0RLbk95eUxNZ3RVbC84bTBQTXRs?=
 =?utf-8?B?Q05BMHlLVkVCK0NZYjlDb0RIUlJzT1NyZnpIWmRIL0tUOWYyY2VGY3l6ZExq?=
 =?utf-8?B?R2Z6ckcwbHkxUjhIK25tUVRLMUJDSjgzdFJOaCtkeEJuUW02VnJFUi9uR0ZM?=
 =?utf-8?B?TVMvaktuckhaYzRrc1FLVnJoZ213bDlCR2xqaExvY2QrUHNQSEllZnovS09R?=
 =?utf-8?B?UDJiaXRDMk1yMFg0OWJxc1NpWklNeXgrWENhZVpzc2hUM1ljZ0wzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad05973-eec7-414a-2d19-08da4986af75
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 19:40:04.5108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAJsZuFGagJo9BgBBjbcETaOB/akE8P9Szm7YlBlTzeXIV0wMnD4MrRB8cXD/W1dRhLHeTbcKa26IdHHgCuQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
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

On 2022-06-08 07:51, Ramesh Errabolu wrote:
> The field is redundant and does not serve any functional role
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 2 --
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 -
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h | 1 -
>   3 files changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index cbfb32b3d235..a5409531a2fd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1040,7 +1040,6 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
>   			props->rec_transfer_size =
>   					iolink->recommended_transfer_size;
>   
> -			dev->io_link_count++;
>   			dev->node_props.io_links_count++;
>   			list_add_tail(&props->list, &dev->io_link_props);
>   			break;
> @@ -1067,7 +1066,6 @@ static int kfd_parse_subtype_iolink(struct crat_subtype_iolink *iolink,
>   		props2->node_from = id_to;
>   		props2->node_to = id_from;
>   		props2->kobj = NULL;
> -		to_dev->io_link_count++;
>   		to_dev->node_props.io_links_count++;
>   		list_add_tail(&props2->list, &to_dev->io_link_props);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3e240b22ec91..304322ac39e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1819,7 +1819,6 @@ static void kfd_topology_update_io_links(int proximity_domain)
>   			 */
>   			if (iolink->node_to == proximity_domain) {
>   				list_del(&iolink->list);
> -				dev->io_link_count--;
>   				dev->node_props.io_links_count--;
>   			} else {
>   				if (iolink->node_from > proximity_domain)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 2fb5664e1041..9f6c949186c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -130,7 +130,6 @@ struct kfd_topology_device {
>   	struct list_head		mem_props;
>   	uint32_t			cache_count;
>   	struct list_head		cache_props;
> -	uint32_t			io_link_count;
>   	struct list_head		io_link_props;
>   	struct list_head		p2p_link_props;
>   	struct list_head		perf_props;
