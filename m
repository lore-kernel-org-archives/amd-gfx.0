Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1916FC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 03:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBAD065165
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 03:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAD065165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C30CC89885;
	Tue,  9 Mar 2021 03:32:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2006D6E44B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 03:32:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNAsE2cKgqxOZS8i1r8fX1SnJVNX0lEN5Cwg5hwvEmooC7XV8JRginio8smwLSvD4U4EdOpX1UG9gtfZcad+J9RfNrUXRdEkhfcmuw0rRYakGV9Vp3Q35D1261imhNLX731x2LqZMQy1s9OejTfV+c74yUpm/KRHDkju+xJ6z7sVanSi+dRZd4TXVgud6Cm6QEzH2mfdbaQ14WWs3O8B4OaXbQn9YL/Vof/Qr8gcubtZ/wvIHp+lTc7HHpfksgRqpEUC069ugAycrkDv2NyoeDexa/O5424OHEZUnor2kf5Yz9J3kXQXOcHvpDcJhfCuv77+w1KA82kehvu/pAFtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFGq29805X5tbN3xL17UwzR1wtXe0VAGvdefZOxxR/8=;
 b=kWWts08xmEOrqhbnbZDmsUaEMlc2K1tI/ZijHFjFjhHA6qaDRXClm8rsJrRB/QvPo5uyuWpTnaWqJTG3c1pG/TrVbeeW4i9XEdwMZ97uoV43BZJIfZq6LOTb/0jDg0ukT5oN2D3/9NBVz8E8F/JkP8JjqwIZh2MZKHeNxQPN1qUixtdUl6OS4CkyKR6ryXotDkw7mn0W3FRIwLgEygac5QlqzP/92Zuvu/Vx0s9emWiC3B2gh5u/ViGAFwgJPcxGpi/nbGXjWbt+JFMkgFnR3f6JPHVabxpywA/PctWIDNs9c9C40oxyovwwNNTU6kkTpBWs3N6s4aEbDfK/i2pl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFGq29805X5tbN3xL17UwzR1wtXe0VAGvdefZOxxR/8=;
 b=zdLpNXdVIHG7wDc8Cq3WA3QyBRNz3luY+DuE3RNp6I+szflftf8uy0z0znJzccq71h4ECBy5VVlHDJvT3jij7EPAyKjWmZD2ZCiup45Gc+qKG1bcyCDqIC5mRp8K13x+YgC7I4F+A+7ywA9mMdzit054LG2cClCa8d9VIG06R8c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 03:32:12 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Tue, 9 Mar 2021
 03:32:12 +0000
Subject: Re: [PATCH 5/5] drm/amdgpu: use metadata members of struct
 amdgpu_bo_user
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210305150617.20144-1-nirmoy.das@amd.com>
 <20210305150617.20144-5-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <e6976fe1-849f-a6e4-e858-d9e4a700cfee@amd.com>
Date: Mon, 8 Mar 2021 22:32:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210305150617.20144-5-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::11) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Tue, 9 Mar 2021 03:32:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f2bac2e-5d75-45db-1460-08d8e2abed43
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4360CF108058D449BAFEE2E692929@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lhFgvFOwolx8Q50ftnt65dy7F2rlNVIR/MnVuo20DDd6zf0R75rUmsRn+31pii/Id6kF4HLxD9tAkN5dSuvOO3O17yBF8bnsfQRM2mnN3BuSUl3EdnS2bVFoCVLi3q9QKiELlUj5Q+NM2BeS1OKq70iZEREI1+hCC6FK4XlhPTqyUfrBnO0ONqdMQAPtpqH23lqdGOE3hPOrNDEBFpk57ZupyoVsdCi+6sinma5wO2o7EnsdrmWwap4kc263ff6lNkGLjrFV4pyYiW2jqCjha4tALd9Bzn39HIrMA+RcNtfwdrKxtCBFA8w6FCRs5DGA245G78fuMWugmDG+24abDeUXdaSkTWCCT7/WBadQAMJLNbxf4UN7UKVkDnFYzL5RXSy5Awey+6bg2LOFUYt50ETNGfZobRVl6hComtBI8mcBEgv1Gb/HcV5SiMNQPoJDdo58rEWl8Ba2/dJj3DCXSSPWDLv6S7OErDTZzRG1wNHUZJLIq6mEiFNzHKZsMvry7y6aOerKt8q6mz1faPupklyelpo3KStquvPQO0IIGQR+lj08ZKCjVWR9RDEtvJqxnx/sONB5AR034fpopdAVxAVGhPZgBLqjNh/fFnCROY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(36756003)(83380400001)(26005)(31686004)(16526019)(186003)(44832011)(31696002)(316002)(6486002)(8676002)(2616005)(478600001)(956004)(66946007)(4326008)(66556008)(5660300002)(86362001)(66476007)(2906002)(52116002)(8936002)(16576012)(6636002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnBHb1hmREtJdXE4dzQ5VHpkYnFEMnZLTlk0S0Jlc2RhN0JoUS9IUnZTZFFh?=
 =?utf-8?B?a29PNStSNVc0NkZuRjdWa0RvMVdNK3VZb0dmZVorb3RFdWRqVkFUbERQQTFW?=
 =?utf-8?B?L0NGTCtrMDh5Z09RQkxxMDJuUDBKbmVxYVhsNkhGSFZoOVBQazlGQUt1UXhY?=
 =?utf-8?B?bXRTRUduOE9wMU5NcEJNZVVxYnZlU2luTWV6YldKS2pIaU1ET0QxcE81Qnhy?=
 =?utf-8?B?cXlOYkVBc29TQ1FJZEtxdm5JL3FDV2x1OGhxVXlvVUJTZlpoRnRYaENzMjVT?=
 =?utf-8?B?bkhSUExVTDFsUmt5NmFhMS9ON3ZFWTVmUUwyQmJxYkh2N0VIeS9tOXl5bG5T?=
 =?utf-8?B?YVhRZWZ4Z1F0RGhmcnp3MmE4SXNSb3ZBMXhQTEl4d0R3Tmt4WWx3Q0RZNFlX?=
 =?utf-8?B?SEZJbUw1VTJZNkdQTk1VWDJ3clBRNjF3c1BreEZEY0RFTk1FRjUxRE91cUQ1?=
 =?utf-8?B?cHNWR2ZFekpxSVQ5eEI5SGxwNXJwSkw2WWRHWWkxZnk2aDl3a1BOR3dVc29a?=
 =?utf-8?B?M2VCY0V3QU9BNVBJeEE1OEVSS1p5cjR2YXduQnJCY05BOTZrUUdvTW93d1ph?=
 =?utf-8?B?YStPV3hSajVNaklSMU52bDJFWERXdFcvSG12UnA1d0lCTEVnMWZvaWkyblBC?=
 =?utf-8?B?Z2FRc0pDWS8xb2VQYllIT3E5OGNIdzcxMGFQbHdjZ2hiUW00dGdpT3NtTWFR?=
 =?utf-8?B?OThYZUtGbUVPdStEbVpHT0RnQ29zenhEbTJTOVVOWEZSV2p3UVd1Rmt1MmJK?=
 =?utf-8?B?YmVEcWZoVmxvTHpwUEdRQitzSGd1RWFnQ2ZRL1J5dnl0MkpOdjlQMjVSbTYw?=
 =?utf-8?B?YzZwNzFDbURYMW9BTWt6ZHlFU3huK1NLb1JmbXNkVFdCYlJnMWpMOVM0UENR?=
 =?utf-8?B?SUJSZDVTOTNZVklQUVJaQjlYejZzTzBRZXFuZE4rN1NjUXAxWVRZNGd6TExk?=
 =?utf-8?B?K2p1Q1hPTGgvSTI0Zk1vdmlqMlVzNlFpekNVWCt4eVI1VHZwYVBZVDJVbmE4?=
 =?utf-8?B?NlhDMGZSMDV2SWkySDJBNjBIYW4xc0UyTk9JQ3h3VU1VQUFOc1EveUZqMnB0?=
 =?utf-8?B?VEc5QkcrUU5CQXlDZlVYOXkzSURvQlkvUkRHWkZENlpMYk9uS3pSbDMwcEg5?=
 =?utf-8?B?Snhwc1FwY1pMZmkzT0dJZVZsM3BiVmVMWDJ0TmpTZlVhZHZmeThPSEx6SllQ?=
 =?utf-8?B?RWo1Qkg3bUVvRUFxUVk1QVZxZkd5MHlkRWxFYklHSndJQzVmVEhpRlUzd254?=
 =?utf-8?B?WC8zNDNhVXorNHo5ZWZNb3grZEtCOGl0UzJpdlJib2Q2ai95VWkyMmZvZHNB?=
 =?utf-8?B?eEthNnZENWpiWEFJMXpGY1pOMFYwazlXc3AzTE9WTThhT0N5Q3dPR1ZKZDlu?=
 =?utf-8?B?NDNxOU5TVVozZnpqQzhKMVVMVzZxMVp0dlN6NnR1M01qbHZ2Y20wUFBwMjky?=
 =?utf-8?B?MEtMTVAwRExub2w1T2daYjN6c2VmbmZ5aUxRMVJTRG1DRlFVb1pOWWh2cVJP?=
 =?utf-8?B?Z3NEMjhaK1hQUnNxS1AwWGs2RVk1U05PaXNMbXphR3NxZU1WT29IL01WdTAv?=
 =?utf-8?B?bHFrbVgyOHdFcDg1SElYNHJjMVJtTCsvdi9yakxnQzVOMzVNWXB2YzNFdWVJ?=
 =?utf-8?B?c1NCNi9oR1BZTEN0Z2oweUo4S0hMV0paSlJaMmNCN1U5SXFMc0d1anJFWjI2?=
 =?utf-8?B?REZlSDNlaUV1a2dGV09MekZVazNWWVpmTldFOEZVQUpyWXN4NXRzOUVWcUta?=
 =?utf-8?B?T3hqZEtNakFveVo0SHF0UVJOWFRKc1dMUDR4NEo4UjVxTkkzNWF2N3M1TFRz?=
 =?utf-8?B?ZEFmMnhYNW9vU3k2STVRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2bac2e-5d75-45db-1460-08d8e2abed43
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 03:32:12.1802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IrhmZshQlTX+hjzLVAy3uByeqzH62KZv/OvnznZM8LjluQFCbBRDF/3JhaLvCwYkMwx0FSeDQW1EEZKi37eqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-03-05 um 10:06 a.m. schrieb Nirmoy Das:
> These members are only needed for BOs created by
> amdgpu_gem_object_create(), so we can remove these from the
> base class.
>
> CC: felix.kuehling@amd.com
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 48 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 --
>  3 files changed, 34 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index c5343a5eecbe..f8c8cbd8ab59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -494,8 +494,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
>  		*dma_buf_kgd = (struct kgd_dev *)adev;
>  	if (bo_size)
>  		*bo_size = amdgpu_bo_size(bo);
> -	if (metadata_size)
> -		*metadata_size = bo->metadata_size;
>  	if (metadata_buffer)
>  		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
>  					   metadata_size, &metadata_flags);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ca60943312dc..7c744d90ed34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -77,6 +77,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>  	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +	struct amdgpu_bo_user *ubo;
>  
>  	if (bo->pin_count > 0)
>  		amdgpu_bo_subtract_pin_size(bo);
> @@ -94,7 +95,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>  	}
>  	amdgpu_bo_unref(&bo->parent);
>  
> -	kfree(bo->metadata);
> +	if (bo->tbo.type == ttm_bo_type_device) {
> +		ubo = container_of((bo), struct amdgpu_bo_user, bo);
> +		kfree(ubo->metadata);
> +	}
> +
>  	kfree(bo);
>  }
>  
> @@ -1236,13 +1241,20 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>  int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
>  			    uint32_t metadata_size, uint64_t flags)
>  {
> +	struct amdgpu_bo_user *ubo;
>  	void *buffer;
>  
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not set metadata for a non-amdgpu_bo_user type BO\n");
> +		return -EINVAL;
> +	}
> +
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
>  	if (!metadata_size) {
> -		if (bo->metadata_size) {
> -			kfree(bo->metadata);
> -			bo->metadata = NULL;
> -			bo->metadata_size = 0;
> +		if (ubo->metadata_size) {
> +			kfree(ubo->metadata);
> +			ubo->metadata = NULL;
> +			ubo->metadata_size = 0;
>  		}
>  		return 0;
>  	}
> @@ -1254,10 +1266,10 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
>  	if (buffer == NULL)
>  		return -ENOMEM;
>  
> -	kfree(bo->metadata);
> -	bo->metadata_flags = flags;
> -	bo->metadata = buffer;
> -	bo->metadata_size = metadata_size;
> +	kfree(ubo->metadata);
> +	ubo->metadata_flags = flags;
> +	ubo->metadata = buffer;
> +	ubo->metadata_size = metadata_size;
>  
>  	return 0;
>  }
> @@ -1281,21 +1293,29 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
>  			   size_t buffer_size, uint32_t *metadata_size,
>  			   uint64_t *flags)
>  {
> +	struct amdgpu_bo_user *ubo;
> +
>  	if (!buffer && !metadata_size)
>  		return -EINVAL;
>  
> +	if (bo->tbo.type != ttm_bo_type_device) {
> +		DRM_ERROR("can not get metadata for a non-amdgpu_bo_user type BO\n");
> +		return -EINVAL;
> +	}
> +
> +	ubo = container_of((bo), struct amdgpu_bo_user, bo);
>  	if (buffer) {
> -		if (buffer_size < bo->metadata_size)
> +		if (buffer_size < ubo->metadata_size)
>  			return -EINVAL;
>  
> -		if (bo->metadata_size)
> -			memcpy(buffer, bo->metadata, bo->metadata_size);
> +		if (ubo->metadata_size)
> +			memcpy(buffer, ubo->metadata, ubo->metadata_size);
>  	}
>  
>  	if (metadata_size)
> -		*metadata_size = bo->metadata_size;
> +		*metadata_size = ubo->metadata_size;
>  	if (flags)
> -		*flags = bo->metadata_flags;
> +		*flags = ubo->metadata_flags;
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 67c1634fa8bd..5005bb4480e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -91,9 +91,6 @@ struct amdgpu_bo {
>  	struct ttm_bo_kmap_obj		kmap;
>  	u64				flags;
>  	unsigned			pin_count;
> -	u64				metadata_flags;
> -	void				*metadata;
> -	u32				metadata_size;
>  	unsigned			prime_shared_count;
>  	/* per VM structure for page tables and with virtual addresses */
>  	struct amdgpu_vm_bo_base	*vm_bo;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
