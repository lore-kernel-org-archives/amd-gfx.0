Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57683C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFB4310FDFB;
	Thu,  2 Jun 2022 16:15:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CCB10FDC9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anm0hU1Cf0Q4vI1MWQBwR/2q1BBbDOV4e5jqw/pvpdTtAyQyOoyWr9F5XdKRT7cnw8RHEYL+1xmxVlhKFhuXdx+Ms9k5/bOCHmH/MCZAf4d+xaXs0J1+XEgFqj/nE4hCDY5SerSld+4/9krkH+O53D1aLC+w6t3+2OlhhLqXAaAjZFrmmkrZpgm3fcbhIj6Pe9+E01RNOfZVA5TBhPVdJom0DI5hmC8EPND35CwablRnP+1ksSOlUPvsxiPpp8QDV8Z03LaYsk9dpv1gwxjyquZh/sBWxRRcoiqnh/nQjejYdOcG3HyVa54Fv9tBzhZf59tb299JNbrGSDPdSJ2RMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjYXS24Ojk6yePNWTu+D09HykbjUPSTwdUFkDAW2RQE=;
 b=ln/G2AdZn373RuSzFliGYeRu3EXOLMxCvaYk63scJTfOL9hIuXlaMtwZqfX0QIMhezxUgjpiCKkwLqLFkdiKZHoS4NenyMcTLed0Hun7tMVLSWMmbJYOHNmqbD2WEVHKG5vIF8IcDsmEGZRZLfk0iCs0x7+9XlhNxjlD9hZ/PPkHBSYsxBZflTUYz/6VnLC4wawn36HSxks5q7Taug6w8NXbuce/vmCq9/jTtYXVfFJEByKML5tQNRnM83Us2XT0GaO348GskrDlA3zOwk/n4pfvz1Cw32eX6y+Gw+p0fhLwxd07VtxCsF4tkxpw4IoN3mjlpti67ESLm/jTvl6viw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjYXS24Ojk6yePNWTu+D09HykbjUPSTwdUFkDAW2RQE=;
 b=HGmCt7GnLi9JOfjvMLg3TtpJtB2w93Ui43gEoyla3pHmp+3lfpRvuR80D0PEngAdZBduesWasV6GZk+dw2vCSwlPvf+9rs8w+vEOaV4gYjTt8Xpu5PaqUr2E+LvZ9DUQwajuC3Y6Dl/tL0Tevxf9r5GC40D3VtZxgrMP2WkfkCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BN6PR12MB1396.namprd12.prod.outlook.com (2603:10b6:404:1b::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Thu, 2 Jun 2022 16:15:20 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::f85e:63df:8fde:b620]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::f85e:63df:8fde:b620%5]) with mapi id 15.20.5314.012; Thu, 2 Jun 2022
 16:15:20 +0000
Message-ID: <e664b5f3-2641-4414-3256-2aa0b70d945c@amd.com>
Date: Thu, 2 Jun 2022 12:15:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/ttm: fix bulk move handling during resource init
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, Arunpravin.PaneerSelvam@amd.com
References: <20220602154734.7854-1-christian.koenig@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220602154734.7854-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::8) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6136e31-44a1-464a-0c56-08da44b316ef
X-MS-TrafficTypeDiagnostic: BN6PR12MB1396:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB139647B64EFE4F88C68554CB99DE9@BN6PR12MB1396.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxaQRRP0WDEA2HdufEtXvwelSjVDG8kZepB99xYz4/kkGpjSHfsJQFzF6diAnNawxrb6nrztK8HKZ7T4B5ThjIx8I2fGyEKJdPpj25Mrm7jcPvYQgRAKS1w5f6rm/F/u9ixmny8ai6CcKq2TcXZN1C10+dplohvgK7tOxl+JIE9qj9wAnPG5BzoRjZIu6FquykYWfdV4G4P27XO+nCpRusppNhJkOEirBUCJ97QzftTywe4b3sBVgRUZjtxriLJn7x1XADGaGvgSXpD2hHtdOQaahikTOjk/xijFakB+7FrTjxKwAvoutBf8ibWse/NtoG++SYT48cmPBWX3zqt4d33DIKY4ci73APKGEnjTDk92EsffFQtYREOodfXVDeyzC2K++hnjAyLL4d/E0eUZTCSzwi8n22e7M2xZRgRv7tIGGOuh85E232RjHYrXwjv3k5z82LL/BKd/vngjZ93r+79GTwMC3GGge/uN2S3wYbLERrcL6/hlIDUx+Xkp4939RMuDkxpJRgNkuj7iRYzB2yXVdOHmAsm54uz6qW5RwzEg3xv1rS0+aX6qTWL1HQfxQT16PpTaHwEqz7QdMiGqy+BeP7G1ZSz8hez/Q9KsrWuY8Dexfd8ovolCXT+GDGAdP4gMddEGYiwsLPN6HEyMWvvd3t9x+8DXu99NODE/3+3I9tyzfEYBDrF9jASkhHJMvdypUFNGpMsMo4gsWOkFFIAOhHeyeigwEP78zVTJPJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(5660300002)(6512007)(31696002)(508600001)(6506007)(53546011)(8936002)(6486002)(8676002)(2906002)(38100700002)(6666004)(44832011)(66476007)(66556008)(66946007)(86362001)(83380400001)(66574015)(6636002)(31686004)(2616005)(36756003)(316002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVNwZ0dHRVdsME5GM1F6YXV3SXVnV3lPaTl4cmRNYWY5NXRpOWtBdVZiZDh5?=
 =?utf-8?B?T1VmL2o0Q0RjVlgvSjR0SFkzaWpMakpTdENSc0o4NC84N1JiL3RqQjAxRXJU?=
 =?utf-8?B?aU8waXdLTnQwU0ZjTkxkWlNTdkM1MHhPSjJPRHVNeU9tUGhhenZaeFJ4d2RV?=
 =?utf-8?B?NEZ5ankxTFNMdzMraWZlaHhrbm9Ic2VDNUJpbjlnaUF4aEFiWjRLZTNLMENm?=
 =?utf-8?B?WDBjbk9wYUdoOUpJbVRyQWZwdFM1cE5hTkZaQzNvcG5zNGx2M3hlbmdYUWNx?=
 =?utf-8?B?aFhjY2FjMndnYUxMTmRSTDVLaXhEc1NlM0ZGVGVDdHJ4c2VNVUxxb2MwdUVJ?=
 =?utf-8?B?S3RSWWszZEtkTUIvTTZWZHdKTy9iSTNhaTZCMHdEM1NUejlCbUZuUm81UjVX?=
 =?utf-8?B?N1lFb2plN21UV3dZMW9YMGhoL1NEMC8ySnhadXRjUFVNNkZOVUNJSzBCdXM4?=
 =?utf-8?B?NDNZRGhkMEFWeHhYK0E0TTMzQWNoeHR2eDVJenI4K0VVMnEyZFJJRFd2ckgz?=
 =?utf-8?B?RSs4VkhpV1lLU09xcTZndnpTUjM0MkJRK3VZOWRZQzgxTmJvQVBVL2w5aHdr?=
 =?utf-8?B?RWJDRmxJWmdBcC9WRkU3NjJuKzBIRUVoT0RLQjVCT3N4MjNEd3pEbVpidWxl?=
 =?utf-8?B?a2t2UEh3aFN6ZFBETzNmU1JXWFZENjVMMi9EdWRKbU5DNUd0VXE2dURBVHJH?=
 =?utf-8?B?NTdtRFBzYnlFcXBKa3RNaXNBbng2ckZ5VXM1dVBhZjc3NXNtSERpYTE4Y0ZO?=
 =?utf-8?B?c0QzRmdLM1lPU2tuUzRZQ3NoN01lS0Mwd0xOTFNHalV0VzFSaHRtTmFvUTFE?=
 =?utf-8?B?NTlnMzhCa1BSUXpZMU9ISm4wdUh4NGQzUmdESE5hZFlRc0RkWlRhOG5hM3lw?=
 =?utf-8?B?bzcrTGIranpKVFM0NUVtdkV4UXBLZ3UreTdzb3VxMjZzUC9zU2lhUUhJb3Jv?=
 =?utf-8?B?NGxINHd6UzVrb203N01vZ2NSOTFjL2pSVWtNN2xtTGYySEtYaDBuVTdrd1FK?=
 =?utf-8?B?VzlZU1h1WEUvVXRYQllEUis2WDc2RndQVGtKRWN4MEg3MWhYY3FXUXVHR3FX?=
 =?utf-8?B?VUNVNHpLVkxOWWQzVmtDcTVtazg0MzUyc0hCMHNqUmZoWUx4eVcxb2V5SHRL?=
 =?utf-8?B?TXpvaG5yWmtmVEpYUW53NFNXOEdlRXZObXgxTUpYaFNwVk00UVNOU0RJenRK?=
 =?utf-8?B?N29EaTdTWS81dVN2dXVxdmNRb296SFNTbmdKV01maGJGVkhlM0MxdTk4WlVM?=
 =?utf-8?B?U2o5YTZSUGNteXpQVlRDRVpJZ09RckNBc2k0ZmI4WU1ubTc0aEd2cWdGY09s?=
 =?utf-8?B?bXRKaG8wRDhRS1lmcHFZa1BEUUZoSkhxZ21Dc1dvM1lkZXJCUzJvelhuWVBk?=
 =?utf-8?B?bUZTaWpzeSt0K3I3d2QvNjFMZHg4WmJsd1FYcEdabmdpZklWWUFRZjZzOTN6?=
 =?utf-8?B?eEYwOTd3QTdSeExRWUNWSzRSZ0IrTytrSGZ4TUIwTS82cnNpZjZVOHNBS1Vs?=
 =?utf-8?B?UFVLOVlJTzkxendyeW9ISy8yZ21TTTgzN2dOVWYzUTNsTnVOWHdtZ3Z4VHkr?=
 =?utf-8?B?NnBvTlFUM3IyeThBQjRReFh6SnJqaERLSWFiQURlajV2U3RsUTFLSWNTaTg5?=
 =?utf-8?B?alRDb21RdENBaHZIUzJ2MFdrYzBsYnUyY0gvZ0hsaWlJOFQvYi85TXU3SmNR?=
 =?utf-8?B?Wk03bnBGaExxRkNULzkrY2lMVC82RmhQSUlOWDlkclNVVXdjYk5BRlZpSjZJ?=
 =?utf-8?B?Rmdwb3cxWE1Fd3FaYnVCWjVhNWNDR2w1c3RGajBoRW9QekxsR0VVbndSbVZW?=
 =?utf-8?B?cGpXUHlPRTBjcFVrYzZIYk0xaDhXd3R6ODJScTFET1djTHVWNnJKamcyQmVE?=
 =?utf-8?B?OWQrWkNuL0VBb21OVEJlandob29wbis2WmV2UWRwUTVsL1JYc0pMMVlQTEFi?=
 =?utf-8?B?YmdhemNXUFJPbUsyK1Fpc0lZVzhTUXY0N1FiODBEamY2VTZIKzZYUTFEaGRH?=
 =?utf-8?B?K1I2VDlDT25uL3pTeVJFemZ6K0ZqSmpYWWp0cnVxT0RnTS9KQS93MkJNY2xV?=
 =?utf-8?B?NkdWRlp4eUtPWFMvV2h3TWxLU25TWWxEeHBVNzRoWXdJQy82NXUyVTlOQnZv?=
 =?utf-8?B?V2NIM3VLcmtQRkFxSUp4amkzTFdEZDVMWWx1cnp2TGsxVVhsbkpSOW1RVUcx?=
 =?utf-8?B?eGtqUFhYSjVKcm50Q1dyRElMbnFqVTlybTd1ODBwaDFnd2YxMlpPR1NCKy9q?=
 =?utf-8?B?WmV1KzZhelo5NURUUUpUTzJteDVPNEZweU9HWWlrNHJJajBDS25oalFNL2Mz?=
 =?utf-8?B?aVp5R2FrblRwNFlpUWl2ZktUVFRjQm8vVDE1OUpmVW9CL2hKcWFqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6136e31-44a1-464a-0c56-08da44b316ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:15:20.2508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJoApDy/iZYMYgcgau1gCoz3AMIiiHi9IUpuyb6yYNmnrrKsYvasOFxdin5Z/SMI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1396
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

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2022-06-02 11:47, Christian König wrote:
> The resource must be on the LRU before ttm_lru_bulk_move_add() is called.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_resource.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 65889b3caf50..928b9140f3c5 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -169,15 +169,17 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
>  	res->bus.is_iomem = false;
>  	res->bus.caching = ttm_cached;
>  	res->bo = bo;
> -	INIT_LIST_HEAD(&res->lru);
>  
>  	man = ttm_manager_type(bo->bdev, place->mem_type);
>  	spin_lock(&bo->bdev->lru_lock);
>  	man->usage += res->num_pages << PAGE_SHIFT;
> -	if (bo->bulk_move)
> +	if (bo->bulk_move) {
> +		list_add_tail(&res->lru, &man->lru[bo->priority]);
>  		ttm_lru_bulk_move_add(bo->bulk_move, res);
> -	else
> +	} else {
> +		INIT_LIST_HEAD(&res->lru);
>  		ttm_resource_move_to_lru_tail(res);
> +	}
>  	spin_unlock(&bo->bdev->lru_lock);
>  }
>  EXPORT_SYMBOL(ttm_resource_init);

Regards,
-- 
Luben
