Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57789CA5FB1
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 08:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDA6110F24B;
	Wed, 30 Sep 2026 08:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IWgOM3Q6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C94D10F24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 08:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1fSbe3FDJihw5Goyl9cdGBFvEb/1Cw9Rk/uO2tp4S1L4GKmvwOa+bbYgzfpsVBgg6PRVgZhGu2BzhxEttki/zzyvo+Ez+foyoP/63hhsFcQC+knqvVkuii+etUm3uAmsKdsKT2SkmKzpVL0D684ToQn5VMdSSZWTJR3JNBoMY3QdzIInYSMD8wM1CTdW6B6pB2rw6PvvLoDhEikKYMc5LYtIXJNAD3g1plwFwCQsxrZjIDMvEgq6JRL5J5anvnN29iovlOlJXHsyegw7G/PzHFa5hmVqKh3hapGjwMlRtP4UzV8Z7UpjIrKN5xOZK+9HF2+qrI1R1sC/XizxKHZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlaVd939VCo+CB4JgkCUCc3f4K2nNhL9VLN4Qka4rXE=;
 b=Bgl0mrvhawGmtOgZ2EH/6dgXVVHjM/TrBBERCK3FIAmFXMZOnUBLJP8B9sNzfmuzd0R6fPAmYhqqmIQCUMSK9jW3TjdWwwmH54ZjChBXiZneS10Kp59tz9sKgFhI1SFKDg9zw7UGwynfJefSJb7m7Uz4NMI7subru6JmJWj8xCHVHhPl3GXe3+PTb6figgxponIEJwwQIJ1SrNRWhjmZGeVJl+WXmX6FdJ4B2Q63n1VHcyGFAKesOvnQ+zs8eBdw5UB1Rc2Pv8ssacmwXrQoAVt7nLyg+QL/fdUqDXUg1HHkPcZXIiNkTxnQsi5hBdMRQCGkQWaCU6prYsIcksRCVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlaVd939VCo+CB4JgkCUCc3f4K2nNhL9VLN4Qka4rXE=;
 b=IWgOM3Q6WVTj6jLZuOx/5gXsg/Q1xhgmDlrz9W2pcC4850COwaqzgzG8XbfmKsYS16Jbv6d4PS0CiKGWUEpRUYtBLgbIomZBrKqWdhIRMGFHFT3ViF46qeLwkTQnLBllEOVDmLvI0EI578xiLma5GPcGwCBevKQhgt+rAwlVfZM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 08:41:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 08:41:39 +0000
Message-ID: <31e5b5f4-c6f4-4bd6-9d49-c3dbfba59f70@amd.com>
Date: Wed, 30 Sep 2026 10:41:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/userq: return the memdup_user() error for
 the user MQD
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, prike.liang@amd.com, sukhatri@amd.com
References: <20260930083148.151311-1-Jesse.Zhang@amd.com>
 <20260930083148.151311-3-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260930083148.151311-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: IA1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: d906465b-ba06-4075-bdcc-08df1ecea4cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Xhp29shUPbBRkbJrp9X4q1YEbKvbj4FUeGPh2QgVrscjQUokOb+4QFSbw/etN9zZwtmwowZ6EvG38RuUSkwgAi7V6P1yK8MhPTtdo1Jf0wwRj2+ChBO82r9FaP7nnZhzgYYuBnSh4+JZqyH/NaRqDr47ogyNNNH3L4pVT5WxRYDYK29UcUp1A4Nvy4HHM1DrboQHB02T8xdCBJXwJioMoL0SPgqVTBsag+WmllGHBEQ7eekeVJkhZPxVrm4MKcZKJuRMCYT7fNlt22eVqxGp2IMWsONAsax4uu+R7FjHEir2rIn+eVm2EKtwEX/qEUPuB1XxuKBJaJo+YXr0I7nXKiNolWT3x5Y8hTgFq83Cf6dEvBJU4oZiY6MFraoz6UEQPzFAzvRNbALbbdRXrg3RXAdCcyDzulFiAFPzVFd9mjD6O7cJBSVkEDpl7niE4Q91+Ku+oVL4jCWhh/dfv51kCY72COYeC0B7Q/9v0737q+/1+8aZ2vlfCSkyf7rvzbp3GffP9+gGreTokD1nRlO43oYUTskgCxIx5CNRIg8/7Z8zs8JFz9I+KB70rtB5HUfEJKejpu5hbTi+16lRG4BHkDU8k3Wzl/uYpctMfE3aYmLuv7Cv9L/bYEmAG6myofsA26AH2subfx0CVh3vvGUlU3DKqeG5NDsbuim+Rs4O0aE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVNbFVLUWVOajArRVFMd1QrbEpSZmVZRy9rNXd3S2pLaHllK0Y0OW1Mc3FC?=
 =?utf-8?B?b0hlY1FQQVh3dENnSmZNdUtCbmV1eEJ2MCtxQ0U4c0lhWXkxcWNMLy9vWEhB?=
 =?utf-8?B?MkszOGt5SElMYVllUVgvcnRUNDk2eUtqczZhMlloSDg1eU1qdGpJejJrejJp?=
 =?utf-8?B?alk0MVo0QmpyRnhISmdVdVJiOU4xRFNWZnJPbHBpL21jcTdITS9Sd3pvSXFq?=
 =?utf-8?B?VTZTQThoSmtjZkc1Tk9oUVZwZXBaVmdSeDhFMitWNkJyQ2FncXVsdW9jNW5v?=
 =?utf-8?B?dHp3OE5VSmpBUUZUSlhOSEhYMUF6a2JyK043UTQ1aFBmZ242RHZ6Zks2TW5I?=
 =?utf-8?B?QXZxWmU2Q0dWYU5IS0d4bmpOUE9oNFFkOXFXZEFTTG90dUVqQWphQmVzaURF?=
 =?utf-8?B?aFVUQjFRQlREM0pwNHdjcDFRTzdzTE1CdXNvbjNaNXFoY0NBallJZ1h5L0g3?=
 =?utf-8?B?S2VTQWJqeG96UUFMR0pNRkFRbjl2QkJMQllIdmFTSVkwQk51NER2d1lDbStC?=
 =?utf-8?B?Z3l2SHZsSytia250bFhsNHpEZUpCQWt1bFJmaU41VGxnczNET0ZvV3lqeUNr?=
 =?utf-8?B?Z2pNNjZnVXg3ZU1LeVZFZ3cxUGJtNXBLVkpuVWFaNVVwUVBheUcwRjlDa1Zh?=
 =?utf-8?B?Mjh3eC9UakVYbDg2UXl1MURYMXJHVDNsSzN3aSt6Nnk1ZGtXTzkvNGdGTWxK?=
 =?utf-8?B?QnpzWVdGbDFzQTNVTXUzQ2JsWWkvaG1FSEZaQzU2ZFFMWHdIZ0Myc1UzZkkx?=
 =?utf-8?B?eDAvKytCT2k3T0pPUWJ0cmtIUE1tdHBCbGo2bjlMNHJaUUtGaENFQndyN3ow?=
 =?utf-8?B?VG9IQXNUa3orUHVJOEp5Mm83Nzd2Ui85VU1VNTIxWU5JVHpYYllmTFptZXJk?=
 =?utf-8?B?VmV2aFpIdTVuREpYY1R1dlp5R09TVWpXanRDekN2N2RyTVZhRTVmdUg0djdw?=
 =?utf-8?B?cDdudWlRbElGV1BHa1FDLzd3QXoxN2tFQjQ5Z2RQeThud3JSbTlFbXZQbmdU?=
 =?utf-8?B?aU9nenMvZ0lueWpZNmxDWlA1bFViOVdoYzVMYitscVN5QngzWVNkbVpoU1hJ?=
 =?utf-8?B?VGpqalpIQUFCdDY5cldna1NPeHorZDM0V0JsQ2VIRy9SWXlBQW4vbXV3RklH?=
 =?utf-8?B?L0NPSCtIUlRZTVlDTVZVWHhoZlUxMlZOeWxwWWlhR3Z0eHV5UjRkMHRtYnBR?=
 =?utf-8?B?dUR5OG5wUDBvZUVVMXh4RTNoSENYY2FBdWVzRmVhSy9CM3phTTRoaHRTb3Zu?=
 =?utf-8?B?VVNjS2FKd2Q0a2VnVWoyUEt2MFpjQ2pwcXBZUFJTZDlHOTlLNEdiYUhxc2dU?=
 =?utf-8?B?bkJBalRUYmxqcTR1eUhyQTNzaTVxajV2L3FHUmNNSHZSeHQ5WVd3dmV5S0sr?=
 =?utf-8?B?T1VLL1ZaWUllRnIwNW9xZHA0blZTbndzMTQ1VVZ2WWxGWkVLYVBYZWVJRXJx?=
 =?utf-8?B?WlR6SStYRlRBTU1ISFZmejBNeGdWL3B4VkowNnN4SzlycitoSWI0ZDFwanNu?=
 =?utf-8?B?MzJ4QWN6RzRST2pZSy9nZXNNSXZ1T0ZvM1lHNEowTDhnNWo5Rlp2SjRHM0tv?=
 =?utf-8?B?ZkFMN2ZpWjZqL081dElieXRiVS82TXRnNklEbUw4UXlaamw0VWhMN0ZsK1B5?=
 =?utf-8?B?RGlyL3dlbXBURkJCei9XU3Q2TUNVTnhtWVdTQy9GZFhxQmJMOStCNHhlYlJk?=
 =?utf-8?B?RUFVOGhMVXBCRmNzdXJFOFhQWWhQUUc2MlRJd0FITHdOT0ZiSmdvMUVYSDhC?=
 =?utf-8?B?SWpZbm5XZWFRdW1oK3RnRkVLU204VVJIeTM4UU10SEZBM01RVUtwM1B0NjFG?=
 =?utf-8?B?di9DUjB6MnY3bWwvN1k1V1pLcXZ0OHg1aE1ITlRQYXBoRU4vMXAvQlJzMG5j?=
 =?utf-8?B?ellYNTBVYm1xN2pndFpDTW1WU0J2YkRqZHFodytGeEVaejJMWnhqMVBHZDV4?=
 =?utf-8?B?V1lVQTBmM1BFU3hLd2xxekpJZWJ6a3dXOHNBa1RGK3RnTmRYenJMK1VmWGFk?=
 =?utf-8?B?QWgzZFNCQU9ZS21Tc25vSWE1ZmFoSDcxUFRubmFBM3ljK2xFSlRORXlGWGhC?=
 =?utf-8?B?QWw2WjNpRzVkT0lJbEJIL1FqSjZUSEF6Z1JabjZWM0s0YitucjI3TTNPdmNz?=
 =?utf-8?B?OWZxS1FlQ05OVmIxcURaejNzd2Z0MFh4N0tGUGN0TTd6YVNUR0hBZGszMC91?=
 =?utf-8?B?aEJMdmlwN1NHM2c2M1JRaHJzaHpDL21lMTl5WjM5Y3JiL283NFFmQmU2THg2?=
 =?utf-8?B?REYrWUFSNjFGLzRBNWpYTzRRbWVPdkMwQ2VrNkdlMzZUMlczTjhIeDVqSUZD?=
 =?utf-8?Q?N0yRuHHQerPhhJ7SQl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d906465b-ba06-4075-bdcc-08df1ecea4cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 08:41:38.9339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtEdNC/PagvUDoFQnlnQs5+wFnGZxC9dQRoeEZRDPHbFeyTBvK2zPGvVe+OZroPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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



On 9/30/26 10:30, Jesse Zhang wrote:
> mes_userq_mqd_create() returns -ENOMEM when copying the user MQD fails,
> even though memdup_user() returns -EFAULT for a bad pointer. Return
> PTR_ERR() instead.
> 
> Fixes: 2c695d7c0720 ("drm/amdgpu: enable compute/gfx usermode queue")
> Fixes: 543b61453774 ("drm/amdgpu: enable SDMA usermode queues")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index e6c167a39d44..fee00a8c08e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -408,7 +408,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
>  		if (IS_ERR(compute_mqd)) {
>  			DRM_ERROR("Failed to read user MQD\n");

While at it please drop all those error message.

First of all memdup_user() can be interrupted by a signal and that isn't really an error, it just aborts the operation.

And then second spamming the logs with error messages on invalid IOCTL parameters is usually seen as really bad idea.

Regards,
Christian.

> -			r = -ENOMEM;
> +			r = PTR_ERR(compute_mqd);
>  			goto free_mqd;
>  		}
>  
> @@ -453,7 +453,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
>  		if (IS_ERR(mqd_gfx_v11)) {
>  			DRM_ERROR("Failed to read user MQD\n");
> -			r = -ENOMEM;
> +			r = PTR_ERR(mqd_gfx_v11);
>  			goto free_mqd;
>  		}
>  
> @@ -498,7 +498,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
>  		if (IS_ERR(mqd_sdma_v11)) {
>  			DRM_ERROR("Failed to read sdma user MQD\n");
> -			r = -ENOMEM;
> +			r = PTR_ERR(mqd_sdma_v11);
>  			goto free_mqd;
>  		}
>  

