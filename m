Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67560C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 12:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5989238E4
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 12:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5989238E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401BF6E82E;
	Fri,  8 Jan 2021 12:20:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC576E82C
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 12:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoUi/mRT0A3Jo7XHRZy/J49CBhn0iBKW+fh/6uebvZEVyFMss7CM+Awo5RIzm6qxU/Nv9o5AxhbqpcL3aApZlw1Sj9lNBjMx6VwEStnTe48mUMSc8Gx5kQzBd15mh3RKu4afFScsK0AlVuFMRyuZ+PRy4NEo1me3Hj4bm66AufEFzP6xOsQXPbjsPddsRASsVcgEArfBUV9Dhw5Aeramuvb3e7YnfGEiPqvksise9MXRgLHcMN8YQGv+APWVhI5iTZDryflV1GSO2/E7on9T7AMiulf2wnYQ/92HfLLrckKK00mymIUOOHOnXJ7rrXN5ADwN6WrStDthITbLAkXr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo6aLeVNhQp4QhLENoIqSd1uAEqUZKXPFcA9AaTFOjQ=;
 b=ObGkXudDDaFEFe6qKapdcUd7uinGg63nP6MQnpHHwqlr8vcm+ZsEpy2MbxuNzWtlNWVpby4YKd04HX7SBBNtCYX+HTESj+ggXg6w/q2BR9Ukp7VT2/q/mV9v63n+z9e7Figf2ntdtch8sv0Kilfu24oWd+O6wQfT5KYixNLk0qyBM59/kLlsNsBtIUTSb5jtAuI6W/v1iPdD/e5kemo4EMGXpPGM2NEJi4sKb8GQHf8gPzefKyh3rjOuNrvZUzjXjVyRQpsNM+d6ELtH/ye4A95ZINeMx1atoVdqYP/GRqo9FZa8agPLAIAt3xz8e6vgrdFIZae4Dx5axgd905TFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo6aLeVNhQp4QhLENoIqSd1uAEqUZKXPFcA9AaTFOjQ=;
 b=IUf9/OuhZb/mkI82oPkjr+cPLVYnj1VKAZyHR0StImEUC5eSmA3qlTNK2UQg6mSZekbwPOOxLzl9ZDlCh/2TNzPJyQirBkdgWh1DpxXuM2atCZdML6jrudv7HtEq06gZA20jiGo1zmtav117bNV60tcAWJwFzFUohzNTI39hV8A=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1129.namprd12.prod.outlook.com (2603:10b6:3:7a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Fri, 8 Jan 2021 12:20:47 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::f872:3677:28c3:660b%5]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 12:20:47 +0000
Subject: Re: [PATCH v2 1/1] drm/amdgpu: cleanup vce,vcn,uvd ring selftests
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <6ef74186-56a2-6f38-b73b-b618fd1b5db0@amd.com>
 <20201218144024.4994-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <261fd056-4d89-b4aa-1e60-c659054f53db@amd.com>
Date: Fri, 8 Jan 2021 13:20:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201218144024.4994-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [93.229.47.23]
X-ClientProxiedBy: AM0PR01CA0163.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::32) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (93.229.47.23) by
 AM0PR01CA0163.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 12:20:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f65ebf9f-0414-4efc-ff60-08d8b3cfd473
X-MS-TrafficTypeDiagnostic: DM5PR12MB1129:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1129EB9BD01CF9483D524C768BAE0@DM5PR12MB1129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1HOajwmok51ImAVG400pmLOM+iJb5fWDUgP7gJ3h7nZh9e85otmmmxzErY0sQgyD0WcpWbDV6/qpqGJCroVGfgckdMlZiL4pq41DQbGjBecrRG8nq0YDhwvff5HgMXWyqBq7/fjU8z7KDMxMbjOZroD3Oy6yvLvvOqXsn6o/GVZrFGPw2NNOrjPKcHeUCu6P6zPdCVxecN9vPIrmYSKRAAJfxVLhYhs4tVazjZlm9zQcsxMM5omUuLtTCHVLXa7helnywDVXZ82lOkqEGBhJEunNXWOSgY9/OEyugj6Fdk0ZqZ6vC0LC2EbDfH+8EG+ufAxW4JN0+Sb8oiqiN81ZnmJ/d8iSKoECW1uS6I0eie2eJEhMxNa5rEoqCWFBrQfRs91eNmJW2dY+TGHl9Ipw4dF2AHzqTUV3cHXhvIGtYSufem3tpZh7gm2YrvKJs6P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(52116002)(8676002)(316002)(8936002)(53546011)(4326008)(6506007)(66946007)(6486002)(66476007)(36756003)(6666004)(66556008)(5660300002)(186003)(31686004)(83380400001)(16526019)(26005)(30864003)(31696002)(956004)(478600001)(2906002)(6512007)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SDNlVUVMS01VaHU4K3ZOZHgzalBFM0tjTGZoUXhtRnlIOTdNN1hGb2dyaGRH?=
 =?utf-8?B?MmVlWFdrY1gyd1h0azNlQ3NKa1dxVHVZSy8rZmlpV2JXcnp1azRDbkd6TTl0?=
 =?utf-8?B?TmJ0Y0w4S0pCNGprcElQb3htamFSTC9lNXBzOGdHQXVVVTlaMTE1NW5TMFZh?=
 =?utf-8?B?YXR4dHhWblRGK3kzYkowV1R3RUNydEpEOGY2aWdUV3F3Y3lsZXpYQXp1cVJF?=
 =?utf-8?B?SlhTUXBtVEEwVlBid0pjVUpuS3FUNmtoL3diQkxQQ0ZhKzJaNVc5T3NIYXFl?=
 =?utf-8?B?MlU1TTdWRXVhUEs1UmtaTTlsa1g2ODdPa2lTdEp3SjRVOFZZM3ZqOGlGaSsw?=
 =?utf-8?B?WE9QU3RrVzhhNDFLS0phLzcxU2NRRVNsbkcza2F1UGpvRDF5bURTb3JEd0RZ?=
 =?utf-8?B?T1VZWjJXbm5iNWcyNGhTZTFNKzRhUVlxUEtETTYwTWRrRVNBMy96SGwrUm1p?=
 =?utf-8?B?RWlNUnVEYnpQRlNYdklNZnp5dkhnZWRpeHo2T1hucDZZZXZkdjR0R0RFTENH?=
 =?utf-8?B?NVR4SmFRdUlzMUZ5YnRiZnptU244enNSTGhpVTFTOE82TnRubzNjNEFnaFBn?=
 =?utf-8?B?NHhlU0JHYnZxajdUYms2QzdobWF0MlhBMTZDVmN1NVV2MlhwY3E4Wkx3V09q?=
 =?utf-8?B?dHFTU25JN0N4R0EySzhtT0lZZkNpOXBDLzlCb0U1cHhJZDd6OTE2WFBnNHQ5?=
 =?utf-8?B?NitDa3JGSVFsUG4yOWxieDNyWXdOcGs0YjE3K3FHSHRkSkhrVmRFTEFIYkVO?=
 =?utf-8?B?cGRvTnI1Y2h2aHJ2YnpsU2VpOVFqWHMvTkFkRHpCVVYrRUw2b2RxR0JhaWIy?=
 =?utf-8?B?R25sRnFsOFhWejJEVHRzWGVvVGRqVnh3eHF3UE5kMVBvVDVCaXZROE1aMXZk?=
 =?utf-8?B?V1pNZFpKdk1NcUdhQitLYmk4UU1BU2VBZHJuQ3MvVy9VNmtla0M3cU9kbExs?=
 =?utf-8?B?YktqaVg3TVJPWkFRZ2RVdGxnT1N4MitheTNtWHZWbjVXSUlQclVpMXBjd0d2?=
 =?utf-8?B?dHRFallqRC84RFBWMXhENzRiRzlka2RJa3FTQlJ2QndNWE1qYW5tNmJ1cHlK?=
 =?utf-8?B?bWU2NnR5WWt1U0thbkhRRFZoNWNycEhGc0MyZ1d0V2VtVEtBV252QWZNamJP?=
 =?utf-8?B?YTljRnlqQnpwV05Bak9xNUR5T0NFN0hxSVZFblI3MnVCWk5DdUFDZ01sYUVN?=
 =?utf-8?B?RlE5cDdiNG1hSmRLMG1JMzBva3JaMjFJY1REc2lVYUJVT21DWDlVS2xCSm9C?=
 =?utf-8?B?TlJ4WktxQWZQUFhpTGJxeUVvL3FlSnc0TUpodUE2RExqZHRiWDhmZEltMC9G?=
 =?utf-8?Q?qaDADaxOsLzFE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 12:20:47.5779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f65ebf9f-0414-4efc-ff60-08d8b3cfd473
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyh2cSGxWTODQWbPgV1o+UK3E0yjrFxQVaztXlJ7ohKh21irScnv3o+AgVt8enktqKfCSHpJf58/3vNFSWkkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1129
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping!

On 12/18/20 3:40 PM, Nirmoy Das wrote:
> Use amdgpu_sa_bo instead of amdgpu_bo.
>
> v2:
> * do not initialize bo to get hint from compiler for -Wuninitialized
> * pass NULL fence to amdgpu_sa_bo_free if fence is undefined.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 56 +++++++------------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 17 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 47 ++++++++++-----------
>   3 files changed, 45 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> index 8b989670ed66..13450a3df044 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1057,7 +1057,7 @@ int amdgpu_uvd_ring_parse_cs(struct amdgpu_cs_parser *parser, uint32_t ib_idx)
>   	return 0;
>   }
>
> -static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
> +static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_sa_bo *bo,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> @@ -1071,19 +1071,6 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	unsigned offset_idx = 0;
>   	unsigned offset[3] = { UVD_BASE_SI, 0, 0 };
>
> -	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unpin(bo);
> -
> -	if (!ring->adev->uvd.address_64_bit) {
> -		struct ttm_operation_ctx ctx = { true, false };
> -
> -		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> -		amdgpu_uvd_force_into_uvd_segment(bo);
> -		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> -		if (r)
> -			goto err;
> -	}
> -
>   	r = amdgpu_job_alloc_with_ib(adev, 64, direct ? AMDGPU_IB_POOL_DIRECT :
>   				     AMDGPU_IB_POOL_DELAYED, &job);
>   	if (r)
> @@ -1101,7 +1088,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	data[3] = PACKET0(offset[offset_idx] + UVD_NO_OP, 0);
>
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
>   	ib->ptr[0] = data[0];
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = data[1];
> @@ -1115,33 +1102,17 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	ib->length_dw = 16;
>
>   	if (direct) {
> -		r = dma_resv_wait_timeout_rcu(bo->tbo.base.resv,
> -							true, false,
> -							msecs_to_jiffies(10));
> -		if (r == 0)
> -			r = -ETIMEDOUT;
> -		if (r < 0)
> -			goto err_free;
> -
>   		r = amdgpu_job_submit_direct(job, ring, &f);
>   		if (r)
>   			goto err_free;
>   	} else {
> -		r = amdgpu_sync_resv(adev, &job->sync, bo->tbo.base.resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> -		if (r)
> -			goto err_free;
> -
>   		r = amdgpu_job_submit(job, &adev->uvd.entity,
>   				      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>   		if (r)
>   			goto err_free;
>   	}
>
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -1153,8 +1124,7 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
>   	amdgpu_job_free(job);
>
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, NULL);
>   	return r;
>   }
>
> @@ -1165,16 +1135,17 @@ int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			      struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_sa_bo *bo;
>   	uint32_t *msg;
>   	int r, i;
>
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, (void **)&msg);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     &bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
>
> +	msg = amdgpu_sa_bo_cpu_addr(bo);
>   	/* stitch together an UVD create msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000000);
> @@ -1197,16 +1168,17 @@ int amdgpu_uvd_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   			       bool direct, struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_sa_bo *bo;
>   	uint32_t *msg;
>   	int r, i;
>
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, (void **)&msg);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     &bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
>
> +	msg = amdgpu_sa_bo_cpu_addr(bo);
>   	/* stitch together an UVD destroy msg */
>   	msg[0] = cpu_to_le32(0x00000de4);
>   	msg[1] = cpu_to_le32(0x00000002);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 0d5284b936e4..bce29d6975d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -81,7 +81,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA20);
>
>   static void amdgpu_vce_idle_work_handler(struct work_struct *work);
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
> +				     struct amdgpu_sa_bo *bo,
>   				     struct dma_fence **fence);
>   static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
>   				      bool direct, struct dma_fence **fence);
> @@ -437,7 +437,7 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>    * Open up a stream for HW test
>    */
>   static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -				     struct amdgpu_bo *bo,
> +				     struct amdgpu_sa_bo *bo,
>   				     struct dma_fence **fence)
>   {
>   	const unsigned ib_size_dw = 1024;
> @@ -454,7 +454,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
>
>   	ib = &job->ibs[0];
>
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
>
>   	/* stitch together an VCE create msg */
>   	ib->length_dw = 0;
> @@ -1130,16 +1130,16 @@ int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring)
>   int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo = NULL;
> +	struct amdgpu_sa_bo *bo = NULL;
> +	struct amdgpu_device *adev = ring->adev;
>   	long r;
>
>   	/* skip vce ring1/2 ib test for now, since it's not reliable */
>   	if (ring != &ring->adev->vce.ring[0])
>   		return 0;
>
> -	r = amdgpu_bo_create_reserved(ring->adev, 512, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      &bo, NULL, NULL);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     &bo, 512, PAGE_SIZE);
>   	if (r)
>   		return r;
>
> @@ -1158,8 +1158,7 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   		r = 0;
>
>   error:
> +	amdgpu_sa_bo_free(adev, &bo, fence);
>   	dma_fence_put(fence);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 4a77c7424dfc..1e46b2f895ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -488,7 +488,7 @@ int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
>   }
>
>   static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> +				   struct amdgpu_sa_bo *bo,
>   				   struct dma_fence **fence)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> @@ -504,7 +504,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
> +
>   	ib->ptr[0] = PACKET0(adev->vcn.internal.data0, 0);
>   	ib->ptr[1] = addr;
>   	ib->ptr[2] = PACKET0(adev->vcn.internal.data1, 0);
> @@ -521,9 +522,7 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -535,25 +534,27 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
>   	amdgpu_job_free(job);
>
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, NULL);
>   	return r;
>   }
>
>   static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					 struct amdgpu_bo **bo)
> +					 struct amdgpu_sa_bo **bo)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>
>   	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
>
> +	msg = amdgpu_sa_bo_cpu_addr(*bo);
> +
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000038);
>   	msg[2] = cpu_to_le32(0x00000001);
> @@ -575,18 +576,19 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
>   }
>
>   static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
> -					  struct amdgpu_bo **bo)
> +					  struct amdgpu_sa_bo **bo)
>   {
>   	struct amdgpu_device *adev = ring->adev;
>   	uint32_t *msg;
>   	int r, i;
>
>   	*bo = NULL;
> -	r = amdgpu_bo_create_reserved(adev, 1024, PAGE_SIZE,
> -				      AMDGPU_GEM_DOMAIN_VRAM,
> -				      bo, NULL, (void **)&msg);
> +	r = amdgpu_sa_bo_new(&adev->ib_pools[AMDGPU_IB_POOL_DIRECT],
> +			     bo, 1024, PAGE_SIZE);
> +
>   	if (r)
>   		return r;
> +	msg = amdgpu_sa_bo_cpu_addr(*bo);
>
>   	msg[0] = cpu_to_le32(0x00000028);
>   	msg[1] = cpu_to_le32(0x00000018);
> @@ -603,7 +605,7 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
>   int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_sa_bo *bo;
>   	long r;
>
>   	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> @@ -633,7 +635,7 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   }
>
>   static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
> -				   struct amdgpu_bo *bo,
> +				   struct amdgpu_sa_bo *bo,
>   				   struct dma_fence **fence)
>   {
>   	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
> @@ -651,7 +653,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   		goto err;
>
>   	ib = &job->ibs[0];
> -	addr = amdgpu_bo_gpu_offset(bo);
> +	addr = amdgpu_sa_bo_gpu_addr(bo);
>   	ib->length_dw = 0;
>
>   	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
> @@ -671,9 +673,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	if (r)
>   		goto err_free;
>
> -	amdgpu_bo_fence(bo, f, false);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, f);
>
>   	if (fence)
>   		*fence = dma_fence_get(f);
> @@ -685,15 +685,14 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
>   	amdgpu_job_free(job);
>
>   err:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> +	amdgpu_sa_bo_free(adev, &bo, NULL);
>   	return r;
>   }
>
>   int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   {
>   	struct dma_fence *fence = NULL;
> -	struct amdgpu_bo *bo;
> +	struct amdgpu_sa_bo *bo;
>   	long r;
>
>   	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
