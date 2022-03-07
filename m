Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53FDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 17:02:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F89610E098;
	Mon,  7 Mar 2022 17:02:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2073.outbound.protection.outlook.com [40.107.101.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C491A10E098
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 17:02:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWwu2EcdIfceOa56+E57lvUsU8Q3kqfpFY4gv0Jky8jiHjd2f7hiR/TBqdzoPKMEPuqLfnZbTjsOWHMTomRwHF1CHYxp4pQYTWNdbOoHsm7PrOdxMDvkayFILMqYOy/ZbpQbZCLiZsalgctQ5WyH5WW0+6PvXNnZXwYk2R7RVnIZUNigAFMpowZJO2myC4tAeK/Ukao7IsF6o0BSSO63EYJUz9yG9BD1iiYsP6FvXuLPHNpN4KhYELS8k01fsHVq2U4Po5zT7qliVt+DRPm/KiDc9yLi4AvL1MzKh2j6kMdSjdLeXU6RnP+sK0glq33la1W7o7/s5w3zzhh4dMPIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2LwXjjrCl9bV2asSwX4O9qapp/5nmrh2bqj/zZRJ5g=;
 b=H75991xAc76crdf7uMs9r6eKdx6fmdhO5/LQQ2hVuXx5Lccq0KsngpwNHb6A7pcOTDumixqDx7LYvEJLkBGeSlooMtpIMVmwzorbZuQ9o6nkJg++9m6wDBlfGDaM/fbJkuFMZ6Tc2p579ByjrD03lCZU8oUm7ifapBfFXKcMoZ4+i8cWI20Kv0uksI0+QDZu6Em0vkpkbZGa3683A4YAyykzGKbkiBXUjfbqjIUk2yZVHt907sgi0+QsYdiDeJ6CCmzh3tgG3JeqwJNkgNprCdNTOiKpV1lb1uDxNC4TB5M47xXmoFuqefCsv9H0Xqd35HXPTevs4UDfTXwlAvJG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2LwXjjrCl9bV2asSwX4O9qapp/5nmrh2bqj/zZRJ5g=;
 b=PsGPbSVXM73fjaIYkQAR3EFm3XA8WPZnqWkteX+r0XMUnuAXdqDVDKFQw0nArqR40695puNOnkN0N0tZ1AG8lbBL43MgYg+E8pF2gqwpH1ZUAMoz8WCr5p4eTwZq+l5LM5MTtgdLH4ZbtqWljiPnBuIcQNKlBoX6CS8oyJPsfk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1367.namprd12.prod.outlook.com (2603:10b6:903:3c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 17:02:34 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::90bd:5b12:918d:5703%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 17:02:34 +0000
Message-ID: <4b07ea41-05eb-8970-f954-0743cfea838c@amd.com>
Date: Mon, 7 Mar 2022 12:02:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 10/10] drm/amdgpu: add gang submit frontend
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <20220303082308.38217-11-christian.koenig@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220303082308.38217-11-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::31) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d5928b2-dee7-47e3-1368-08da005c45e5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1367:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13674156217549AE5C471653EA089@CY4PR12MB1367.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QQkcm4keOHhWHaF9xkcpckOzxTzqAWcqDNeQg5iH9HVQCagCA34ugXWnND/48KvfR+PGtcNYBsVQcxZFILIgzVX8y+/wO3h1pI/Fca9KC0n5jKYeQEplyZgkEy6RE3eB4R8a0/CzdxSv7CK2oKJONG0sDahV7+iDHxwejBoo31sdwQTRcXjbJShPGiOtOu169AhnOYag4ucFzwMx1Ou74bK5ol0y+6G4ut+upGqgTQWpyMdZmHa7+DioERMO+xfhAqU0cgqzysAPHpNEo7ZCT+8Q/MjCt9y+Im/OE+UpT+SgbHyNz0oCS+af5s3fcn626J57K4fBqm+1yUckdWkNXlacO56iAkDkg6T9XfL/R4zxxbEaHsZkCmpTzS9hYqLzFsTDFrO7UtWhq9gBjIAlfl6jD1NSK+M6+69XqJXgmQWBPD7jxXsLxXStM/LHjROnGdhVjypk9+xkgFxoJOFtKLDvhcOXnM/G+N+vk6k3l4lVwo+uZoAs0qp7yKvWuMEW2ybxTcYWDY/sp2Hi6fbT9jXJ89SlJF2firR+4sVxOj7pC1OLr25z3bQA7hdSGxxMqDv7i/YAmUXuzyYhX1or6IpQGJgtGvxextO9aqOwZ8IKroQ702qvfM7FfETB5ht9m+6dZArWKkPf82p/loTQl/DVqmDAgiZ+odWGnqBKOmc8QS6ZVRH5KRTW4hhqt73fwF9ci84g9s28ciHSF+HuS81c4rVzsTlEVSlMn2WvWYFCs9BWJHS/O9Ni+O/gr5l9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(5660300002)(86362001)(31686004)(31696002)(66946007)(44832011)(8676002)(508600001)(66476007)(66556008)(4326008)(6486002)(6506007)(6512007)(6666004)(8936002)(30864003)(6636002)(53546011)(83380400001)(66574015)(186003)(36756003)(2616005)(38100700002)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YllBejVFbDdhUlk1TVZQVTd5dnRONXZ2eW9WV2tIeG9RQnJOb1BVNmhUeEEx?=
 =?utf-8?B?RlRSOU1oTmFBUGl0Mk93QUNGaDN0NU5PZk9vQXFXYW9vYTRnZks1ZEMzNTNH?=
 =?utf-8?B?MlpYWXIvc1cyRjBIMEhPdHVzZExSbmV2SDNjSkZDNUIwMEdxZHBJaUZLVkYw?=
 =?utf-8?B?L0h3TXZRZS9nOElEMzBtTE1SWkVPTXdCMXRYU0dhV1FTejdkU3JQL0hsQjhG?=
 =?utf-8?B?L0JLM3hSZGl0SUw2SDh5QlhxSDBZajd2MDhrQ2o5M0dQZGhoTGtLWnZaRWVw?=
 =?utf-8?B?U2x6SG1qRkZtdzl6VjJZYTh1amp0TjJOTmpiUDNEYlJCVmpsVjhLREhob3ZD?=
 =?utf-8?B?VFB2WUw5Q1dIekF0Z3JKUFVFNDdIZjk5c0xkUVRaZmJOUnU1bnVUYWZUZVR3?=
 =?utf-8?B?cXVIL0I3MUFnY3RtSDBJai9KVFRYSHZ4YUQ4RC9zcDhTemh1QkJFclAwdWNP?=
 =?utf-8?B?YmlYRDZaRytRQXlDcEc2eTRvQmRIajZmeit6WmxqRTE4cE5Fc3ZIRUFGZzFa?=
 =?utf-8?B?RDFoVlc3UVZXSnVJZlNMQWF5SU9IS2tPRlZkeFZ5RHpRU2VzdDkyaGIrZEx0?=
 =?utf-8?B?YjNPUm5hKzA1R2dMNVZqbjJkWDUrWFBiOCtKdzJkdi9DU0QzeWZVR29hREN6?=
 =?utf-8?B?aGgwU1VpWWFXMTFzeiswL2JpT2drd0dPR3QxR3Bhd3pSNG1hc0pXT0o2eDJ3?=
 =?utf-8?B?bW9rMEZDK0ZZT3ovN0FLMDZ3YmF2dW5JWEJYd1RaeVM5VzZ6cjFwZW9HaHJ2?=
 =?utf-8?B?cXpsek5xTU13aUcrcmlzUWpUN3dUNFQvMk9menRtdVN6R29kUy91M0lqbW1K?=
 =?utf-8?B?UkRVN05PVDBQcytsSW1QUHVNd1dOYjlNdkRCQ01kajcwK0MzSmhMK0QyS0th?=
 =?utf-8?B?WVdlVWRXd2ZOSjkrWlJFeDJ0MG1BS3V5cnJiOGovVmJtamdybENHaGNUbnIz?=
 =?utf-8?B?UjYvd3hqSmZkblgvRXB5d1hFdThpSWI5YUVmd3BON1J1aHZNc2N1dXVSaUFk?=
 =?utf-8?B?NXRXN2FLakc0ZytzTmx6VUwvWTE2Z3VtZGpUUGJLd0RFUXA2M1RoTUk2dEdp?=
 =?utf-8?B?MzJtejBjK2VwM0FTTTBINGY5TXU3am5OTTZzNis1MyswQWF6Q3BSejRGN240?=
 =?utf-8?B?em0yQityL3hVTzdBNWg0SFJPdFdMTVR6OHZZU3ZaQkVPcW1WSGkyZGVGak85?=
 =?utf-8?B?WUdEZGpGa0xpRkVzb3VwUmcyN2U5ZnNsSm14blJHS0NXT3VtL3RUQThJUzRQ?=
 =?utf-8?B?eE14RUxvOG1ZUEtKcTd5a2hBTVp2bkJsVTNlc0FVZEZrcTk1Q3FINkphQjl0?=
 =?utf-8?B?MnpycFc4YnNUazBBeVZIdlJmRlVwbzVJMm9qVGRlV0hDNW5PU2czL1lCMUZC?=
 =?utf-8?B?OTJBeHVYa3IwL2xJU1FQSm9LM3U4cXhPQVlrbFZGQW5iUVJTWmhEQmpDYS83?=
 =?utf-8?B?MEd2c3dPdXkxUHhHWGE4Q3VUaEp6SGswS0ZPempBMlpRdTIwT1EzZFl0WG1J?=
 =?utf-8?B?VDZVc05mMVZPRUsrZVp3MXdSaHZlTS9sTnVUMDJYSG1NTjdjbml6TUQ5SUdn?=
 =?utf-8?B?bGdLanlNbWNpU1lWK2VTa28vMnpnaFFyVnFCMWhmMitsNW1vSVU1V0ljU3lP?=
 =?utf-8?B?WWFwZ2pjbnM5UmFYSm92S3RKa3JnYmsrbXdkTDdWeVJBZElMenJRajZqVjl5?=
 =?utf-8?B?Rk1wL01GS1cyZ1ZhMVJ3SjNrcnJoc2Q2VW9EY3lUSXpWWGhxdXBqN0EySXhB?=
 =?utf-8?B?VVIvRDBhd0NPOXpFSFAvTytiUGJNbWprdGY1aEljZHFjZE4yTlVGY1JuL1VZ?=
 =?utf-8?B?WlFCMGxET1VhRUJsbktxbUtEbE52V2FxRzBLVWZ2dFh3ci9aMVBIRFI4L3Mw?=
 =?utf-8?B?SWdFcm5LT01zQ2JlTFJ3enh0SDJvUksrWWdGUjdXMEtoUTJ1UUFKV1I5Qm5P?=
 =?utf-8?B?TEQ5YkNjOC9zL2Q5ckRCOSszY0pFRXluTzRyalZ3Skt2NmM1MkJ2NWtTUGor?=
 =?utf-8?B?ZUhjMnhNc0g1T2svZFEzYmFxY0ZYelkybW9vaUpQMTBxWXUwZk9LM29IWml1?=
 =?utf-8?B?Vm5ibnhVTkVWdHUvY3ZTbE9hYkxmNnhmamNBdE40My9CTHNJaHpONm9ULy9K?=
 =?utf-8?B?SVNXYkxFQ3VDdWxESnlnU0lxWFlVZlZqaXlOR1J4a0VqbzE0Tm9CK0VjSFZT?=
 =?utf-8?B?WjlCeE5uMDFZWkhLOVowMTFVQVN1dmd0SnFsZ1RDcFRVcVRNaS93TnVRN3Fu?=
 =?utf-8?Q?UoVP+hAS8hs9c0o+iuKNZW5r8nrQ3xWPzCTO86GDuM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5928b2-dee7-47e3-1368-08da005c45e5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 17:02:34.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upBG+IsEhnMw5jlR0Oz77NZYHymdjgQ4IlXdaaHPt+Le2XuvrwG/Vyx+IlZ4FOtZwd+ZHCCMyW3MLzBazXBVFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1367
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-03-03 03:23, Christian König wrote:
> Allows submitting jobs as gang which needs to run on multiple engines at the
> same time.
>
> All members of the gang get the same implicit, explicit and VM dependencies. So
> no gang member will start running until everything else is ready.
>
> The last job is considered the gang leader (usually a submission to the GFX
> ring) and used for signaling output dependencies.
>
> Each job is remembered individually as user of a buffer object, so there is no
> joining of work at the end.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    | 244 ++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h    |   9 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  12 +-
>   3 files changed, 173 insertions(+), 92 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index c6541f7b8f54..7429e64919fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -69,6 +69,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>   			   unsigned int *num_ibs)
>   {
>   	struct drm_sched_entity *entity;
> +	unsigned int i;
>   	int r;
>   
>   	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
> @@ -83,11 +84,19 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
>   		return -EINVAL;
>   
>   	/* Currently we don't support submitting to multiple entities */
> -	if (p->entity && p->entity != entity)
> +	for (i = 0; i < p->gang_size; ++i) {
> +		if (p->entities[i] == entity)
> +			goto found;
> +	}
> +
> +	if (i == AMDGPU_CS_GANG_SIZE)
>   		return -EINVAL;
>   
> -	p->entity = entity;
> -	++(*num_ibs);
> +	p->entities[i] = entity;
> +	p->gang_size = i + 1;
> +
> +found:
> +	++(num_ibs[i]);
>   	return 0;
>   }
>   
> @@ -161,11 +170,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   			   union drm_amdgpu_cs *cs)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	unsigned int num_ibs[AMDGPU_CS_GANG_SIZE] = { };
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	uint64_t *chunk_array_user;
>   	uint64_t *chunk_array;
> -	unsigned size, num_ibs = 0;
>   	uint32_t uf_offset = 0;
> +	unsigned int size;
>   	int ret;
>   	int i;
>   
> @@ -228,7 +238,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   			if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
>   				goto free_partial_kdata;
>   
> -			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &num_ibs);
> +			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, num_ibs);
>   			if (ret)
>   				goto free_partial_kdata;
>   			break;
> @@ -265,21 +275,27 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   		}
>   	}
>   
> -	ret = amdgpu_job_alloc(p->adev, num_ibs, &p->job, vm);
> -	if (ret)
> -		goto free_all_kdata;
> +	if (!p->gang_size)
> +		return -EINVAL;
>   
> -	ret = drm_sched_job_init(&p->job->base, p->entity, &fpriv->vm);
> -	if (ret)
> -		goto free_all_kdata;
> +	for (i = 0; i < p->gang_size; ++i) {
> +		ret = amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i], vm);
> +		if (ret)
> +			goto free_all_kdata;
> +
> +		ret = drm_sched_job_init(&p->jobs[i]->base, p->entities[i],
> +					 &fpriv->vm);
> +		if (ret)
> +			goto free_all_kdata;
> +	}
>   
> -	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
> +	if (p->ctx->vram_lost_counter != p->jobs[0]->vram_lost_counter) {
>   		ret = -ECANCELED;
>   		goto free_all_kdata;
>   	}
>   
>   	if (p->uf_entry.tv.bo)
> -		p->job->uf_addr = uf_offset;
> +		p->jobs[p->gang_size - 1]->uf_addr = uf_offset;


I would use some macro here for the index or maybe even a getter
function or a macro that explicitly shows you are retrieving the gang 
leader

Maybe also something for  the 'jobs[0]' above which as I understated 
just used
for retrieving data which is identical for each job in the gang - but 
why not just
use the leader then for all such retrievals ?

Andrey


>   	kvfree(chunk_array);
>   
>   	/* Use this opportunity to fill in task info for the vm */
> @@ -301,22 +317,18 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>   	return ret;
>   }
>   
> -static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
> -			   struct amdgpu_cs_chunk *chunk,
> -			   unsigned int *num_ibs,
> -			   unsigned int *ce_preempt,
> -			   unsigned int *de_preempt)
> +static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
> +			   struct amdgpu_ib *ib, struct amdgpu_cs_chunk *chunk,
> +			   unsigned int *ce_preempt, unsigned int *de_preempt)
>   {
> -	struct amdgpu_ring *ring = to_amdgpu_ring(p->job->base.sched);
> +	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -	struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	int r;
>   
> -
>   	/* MM engine doesn't support user fences */
> -	if (p->job->uf_addr && ring->funcs->no_user_fence)
> +	if (job->uf_addr && ring->funcs->no_user_fence)
>   		return -EINVAL;
>   
>   	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
> @@ -333,7 +345,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>   	}
>   
>   	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
> -		p->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
> +		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
>   
>   	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
>   			   chunk_ib->ib_bytes : 0,
> @@ -346,8 +358,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
>   	ib->gpu_addr = chunk_ib->va_start;
>   	ib->length_dw = chunk_ib->ib_bytes / 4;
>   	ib->flags = chunk_ib->flags;
> -
> -	(*num_ibs)++;
>   	return 0;
>   }
>   
> @@ -396,7 +406,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
>   			dma_fence_put(old);
>   		}
>   
> -		r = amdgpu_sync_fence(&p->job->sync, fence);
> +		r = amdgpu_sync_fence(&p->jobs[0]->sync, fence);
>   		dma_fence_put(fence);
>   		if (r)
>   			return r;
> @@ -418,7 +428,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
>   		return r;
>   	}
>   
> -	r = amdgpu_sync_fence(&p->job->sync, fence);
> +	r = amdgpu_sync_fence(&p->jobs[0]->sync, fence);
>   	dma_fence_put(fence);
>   
>   	return r;
> @@ -541,20 +551,30 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
>   
>   static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
>   {
> -	unsigned int num_ibs = 0, ce_preempt = 0, de_preempt = 0;
> +	unsigned int ce_preempt = 0, de_preempt = 0;
> +	unsigned int job_idx = 0, ib_idx = 0;
>   	int i, r;
>   
>   	for (i = 0; i < p->nchunks; ++i) {
>   		struct amdgpu_cs_chunk *chunk;
> +		struct amdgpu_job *job;
>   
>   		chunk = &p->chunks[i];
>   
>   		switch (chunk->chunk_id) {
>   		case AMDGPU_CHUNK_ID_IB:
> -			r = amdgpu_cs_p2_ib(p, chunk, &num_ibs,
> +			job = p->jobs[job_idx];
> +			r = amdgpu_cs_p2_ib(p, job, &job->ibs[ib_idx], chunk,
>   					    &ce_preempt, &de_preempt);
>   			if (r)
>   				return r;
> +
> +			if (++ib_idx == job->num_ibs) {
> +				++job_idx;
> +				ib_idx = 0;
> +				ce_preempt = 0;
> +				de_preempt = 0;
> +			}
>   			break;
>   		case AMDGPU_CHUNK_ID_DEPENDENCIES:
>   		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
> @@ -825,6 +845,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_list_entry *e;
>   	struct list_head duplicates;
> +	unsigned int i;
>   	int r;
>   
>   	INIT_LIST_HEAD(&p->validated);
> @@ -905,16 +926,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		e->bo_va = amdgpu_vm_bo_find(vm, bo);
>   	}
>   
> -	/* Move fence waiting after getting reservation lock of
> -	 * PD root. Then there is no need on a ctx mutex lock.
> -	 */
> -	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
> -	if (unlikely(r != 0)) {
> -		if (r != -ERESTARTSYS)
> -			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> -		goto error_validate;
> -	}
> -
>   	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
>   					  &p->bytes_moved_vis_threshold);
>   	p->bytes_moved = 0;
> @@ -938,14 +949,16 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
>   				     p->bytes_moved_vis);
>   
> -	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
> -				 p->bo_list->gws_obj, p->bo_list->oa_obj);
> +	for (i = 0; i < p->gang_size; ++i)
> +		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
> +					 p->bo_list->gws_obj,
> +					 p->bo_list->oa_obj);
>   
>   	if (!r && p->uf_entry.tv.bo) {
>   		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
>   
>   		r = amdgpu_ttm_alloc_gart(&uf->tbo);
> -		p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
> +		p->jobs[p->gang_size - 1]->uf_addr += amdgpu_bo_gpu_offset(uf);
>   	}
>   
>   error_validate:
> @@ -955,20 +968,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   	return r;
>   }
>   
> -static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
> +static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
>   {
> -	int i;
> +	int i, j;
>   
>   	if (!trace_amdgpu_cs_enabled())
>   		return;
>   
> -	for (i = 0; i < parser->job->num_ibs; i++)
> -		trace_amdgpu_cs(parser, i);
> +	for (i = 0; i < p->gang_size; ++i) {
> +		struct amdgpu_job *job = p->jobs[i];
> +
> +		for (j = 0; j < job->num_ibs; ++j)
> +			trace_amdgpu_cs(p, job, &job->ibs[j]);
> +	}
>   }
>   
> -static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
> +static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
> +			       struct amdgpu_job *job)
>   {
> -	struct amdgpu_job *job = p->job;
>   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	unsigned int i;
>   	int r;
> @@ -1007,14 +1024,13 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
>   			memcpy(ib->ptr, kptr, job->ibs[i].length_dw * 4);
>   			amdgpu_bo_kunmap(aobj);
>   
> -			r = amdgpu_ring_parse_cs(ring, p, p->job,
> -						 &p->job->ibs[i]);
> +			r = amdgpu_ring_parse_cs(ring, p, job, &job->ibs[i]);
>   			if (r)
>   				return r;
>   		} else {
>   			ib->ptr = (uint32_t *)kptr;
> -			r = amdgpu_ring_patch_cs_in_place(ring, p, p->job,
> -							  &p->job->ibs[i]);
> +			r = amdgpu_ring_patch_cs_in_place(ring, p, job,
> +							  &job->ibs[i]);
>   			amdgpu_bo_kunmap(aobj);
>   			if (r)
>   				return r;
> @@ -1024,14 +1040,29 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
>   	return 0;
>   }
>   
> +static int amdgpu_cs_patch_jobs(struct amdgpu_cs_parser *p)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	for (i = 0; i < p->gang_size; ++i) {
> +		r = amdgpu_cs_patch_ibs(p, p->jobs[i]);
> +		if (r)
> +			return r;
> +	}
> +	return 0;
> +}
> +
>   static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
>   	struct amdgpu_device *adev = p->adev;
> +	struct amdgpu_job *job = p->jobs[0];
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_list_entry *e;
>   	struct amdgpu_bo_va *bo_va;
>   	struct amdgpu_bo *bo;
> +	unsigned int i;
>   	int r;
>   
>   	r = amdgpu_vm_clear_freed(adev, vm, NULL);
> @@ -1042,7 +1073,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_sync_vm_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
> +	r = amdgpu_sync_vm_fence(&job->sync, fpriv->prt_va->last_pt_update);
>   	if (r)
>   		return r;
>   
> @@ -1052,7 +1083,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   		if (r)
>   			return r;
>   
> -		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
> +		r = amdgpu_sync_vm_fence(&job->sync, bo_va->last_pt_update);
>   		if (r)
>   			return r;
>   	}
> @@ -1071,7 +1102,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   		if (r)
>   			return r;
>   
> -		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
> +		r = amdgpu_sync_vm_fence(&job->sync, bo_va->last_pt_update);
>   		if (r)
>   			return r;
>   	}
> @@ -1084,11 +1115,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   	if (r)
>   		return r;
>   
> -	r = amdgpu_sync_vm_fence(&p->job->sync, vm->last_update);
> +	r = amdgpu_sync_vm_fence(&job->sync, vm->last_update);
>   	if (r)
>   		return r;
>   
> -	p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +	for (i = 0; i < p->gang_size; ++i) {
> +		job = p->jobs[i];
> +
> +		if (!job->vm)
> +			continue;
> +
> +		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
> +	}
>   
>   	if (amdgpu_vm_debug) {
>   		/* Invalidate all BOs to test for userspace bugs */
> @@ -1109,7 +1147,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
>   static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   {
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> +	struct amdgpu_job *job = p->jobs[0];
>   	struct amdgpu_bo_list_entry *e;
> +	unsigned int i;
>   	int r;
>   
>   	list_for_each_entry(e, &p->validated, tv.head) {
> @@ -1119,12 +1159,23 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
>   
>   		sync_mode = amdgpu_bo_explicit_sync(bo) ?
>   			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
> -		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
> +		r = amdgpu_sync_resv(p->adev, &job->sync, resv, sync_mode,
>   				     &fpriv->vm);
>   		if (r)
>   			return r;
>   	}
> -	return 0;
> +
> +	for (i = 1; i < p->gang_size; ++i) {
> +		r = amdgpu_sync_clone(&job->sync, &p->jobs[i]->sync);
> +		if (r)
> +			return r;
> +	}
> +
> +	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size - 1]);
> +	if (r && r != -ERESTARTSYS)
> +		DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
> +
> +	return r;
>   }
>   
>   static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
> @@ -1147,17 +1198,27 @@ static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
>   static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   			    union drm_amdgpu_cs *cs)
>   {
> +	struct amdgpu_job *last = p->jobs[p->gang_size - 1];
>   	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
> -	struct drm_sched_entity *entity = p->entity;
>   	struct amdgpu_bo_list_entry *e;
> -	struct amdgpu_job *job;
> +	unsigned int i;
>   	uint64_t seq;
>   	int r;
>   
> -	job = p->job;
> -	p->job = NULL;
> +	for (i = 0; i < p->gang_size; ++i)
> +		drm_sched_job_arm(&p->jobs[i]->base);
>   
> -	drm_sched_job_arm(&job->base);
> +	for (i = 0; i < (p->gang_size - 1); ++i) {
> +		struct dma_fence *fence;
> +
> +		fence = &p->jobs[i]->base.s_fence->scheduled;
> +		r = amdgpu_sync_fence(&last->sync, fence);
> +		if (r)
> +			goto error_cleanup;
> +	}
> +
> +	for (i = 0; i < p->gang_size; ++i)
> +		amdgpu_job_set_gang_leader(p->jobs[i], last);
>   
>   	/* No memory allocation is allowed while holding the notifier lock.
>   	 * The lock is held until amdgpu_cs_submit is finished and fence is
> @@ -1175,44 +1236,58 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	}
>   	if (r) {
>   		r = -EAGAIN;
> -		goto error_abort;
> +		goto error_unlock;
>   	}
>   
> -	p->fence = dma_fence_get(&job->base.s_fence->finished);
> +	p->fence = dma_fence_get(&last->base.s_fence->finished);
>   
> -	amdgpu_ctx_add_fence(p->ctx, entity, p->fence, &seq);
> +	amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1], p->fence,
> +			     &seq);
>   	amdgpu_cs_post_dependencies(p);
>   
> -	if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
> +	if ((last->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
>   	    !p->ctx->preamble_presented) {
> -		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
> +		last->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
>   		p->ctx->preamble_presented = true;
>   	}
>   
>   	cs->out.handle = seq;
> -	job->uf_sequence = seq;
> -
> -	amdgpu_job_free_resources(job);
> +	last->uf_sequence = seq;
>   
> -	trace_amdgpu_cs_ioctl(job);
>   	amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket);
> -	drm_sched_entity_push_job(&job->base);
> +	for (i = 0; i < p->gang_size; ++i) {
> +		amdgpu_job_free_resources(p->jobs[i]);
> +		trace_amdgpu_cs_ioctl(p->jobs[i]);
> +		drm_sched_entity_push_job(&p->jobs[i]->base);
> +		p->jobs[i] = NULL;
> +	}
>   
>   	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
>   
> -	/* Make sure all BOs are remembered as writers */
> -	amdgpu_bo_list_for_each_entry(e, p->bo_list)
> +	list_for_each_entry(e, &p->validated, tv.head) {
> +
> +		/* Everybody except for the gang leader uses BOOKKEEP */
> +		for (i = 0; i < (p->gang_size - 1); ++i) {
> +			dma_resv_add_fence(e->tv.bo->base.resv,
> +					   &p->jobs[i]->base.s_fence->finished,
> +					   DMA_RESV_USAGE_BOOKKEEP);
> +		}
> +
> +		/* The gang leader as remembered as writer */
>   		e->tv.num_shared = 0;
> +	}
>   
>   	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
>   	mutex_unlock(&p->adev->notifier_lock);
>   
>   	return 0;
>   
> -error_abort:
> -	drm_sched_job_cleanup(&job->base);
> +error_unlock:
>   	mutex_unlock(&p->adev->notifier_lock);
> -	amdgpu_job_free(job);
> +
> +error_cleanup:
> +	for (i = 0; i < p->gang_size; ++i)
> +		drm_sched_job_cleanup(&p->jobs[i]->base);
>   	return r;
>   }
>   
> @@ -1229,17 +1304,18 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
>   
>   	dma_fence_put(parser->fence);
>   
> -	if (parser->ctx) {
> +	if (parser->ctx)
>   		amdgpu_ctx_put(parser->ctx);
> -	}
>   	if (parser->bo_list)
>   		amdgpu_bo_list_put(parser->bo_list);
>   
>   	for (i = 0; i < parser->nchunks; i++)
>   		kvfree(parser->chunks[i].kdata);
>   	kvfree(parser->chunks);
> -	if (parser->job)
> -		amdgpu_job_free(parser->job);
> +	for (i = 0; i < parser->gang_size; ++i) {
> +		if (parser->jobs[i])
> +			amdgpu_job_free(parser->jobs[i]);
> +	}
>   	if (parser->uf_entry.tv.bo) {
>   		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
>   
> @@ -1283,7 +1359,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   		goto error_fini;
>   	}
>   
> -	r = amdgpu_cs_patch_ibs(&parser);
> +	r = amdgpu_cs_patch_jobs(&parser);
>   	if (r)
>   		goto error_backoff;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> index 652b5593499f..ba5860c08270 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
> @@ -27,6 +27,8 @@
>   #include "amdgpu_bo_list.h"
>   #include "amdgpu_ring.h"
>   
> +#define AMDGPU_CS_GANG_SIZE	4
> +
>   struct amdgpu_bo_va_mapping;
>   
>   struct amdgpu_cs_chunk {
> @@ -50,9 +52,10 @@ struct amdgpu_cs_parser {
>   	unsigned		nchunks;
>   	struct amdgpu_cs_chunk	*chunks;
>   
> -	/* scheduler job object */
> -	struct drm_sched_entity	*entity;
> -	struct amdgpu_job	*job;
> +	/* scheduler job objects */
> +	unsigned int		gang_size;
> +	struct drm_sched_entity	*entities[AMDGPU_CS_GANG_SIZE];
> +	struct amdgpu_job	*jobs[AMDGPU_CS_GANG_SIZE];
>   
>   	/* buffer objects */
>   	struct ww_acquire_ctx		ticket;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d855cb53c7e0..a5167cb91ba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -140,8 +140,10 @@ TRACE_EVENT(amdgpu_bo_create,
>   );
>   
>   TRACE_EVENT(amdgpu_cs,
> -	    TP_PROTO(struct amdgpu_cs_parser *p, int i),
> -	    TP_ARGS(p, i),
> +	    TP_PROTO(struct amdgpu_cs_parser *p,
> +		     struct amdgpu_job *job,
> +		     struct amdgpu_ib *ib),
> +	    TP_ARGS(p, job, ib),
>   	    TP_STRUCT__entry(
>   			     __field(struct amdgpu_bo_list *, bo_list)
>   			     __field(u32, ring)
> @@ -151,10 +153,10 @@ TRACE_EVENT(amdgpu_cs,
>   
>   	    TP_fast_assign(
>   			   __entry->bo_list = p->bo_list;
> -			   __entry->ring = to_amdgpu_ring(p->entity->rq->sched)->idx;
> -			   __entry->dw = p->job->ibs[i].length_dw;
> +			   __entry->ring = to_amdgpu_ring(job->base.sched)->idx;
> +			   __entry->dw = ib->length_dw;
>   			   __entry->fences = amdgpu_fence_count_emitted(
> -				to_amdgpu_ring(p->entity->rq->sched));
> +				to_amdgpu_ring(job->base.sched));
>   			   ),
>   	    TP_printk("bo_list=%p, ring=%u, dw=%u, fences=%u",
>   		      __entry->bo_list, __entry->ring, __entry->dw,
