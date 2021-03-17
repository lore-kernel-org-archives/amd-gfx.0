Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8259C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D92664F7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D92664F7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D146E4E6;
	Wed, 17 Mar 2021 08:06:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AA0E6E4E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI6cH6yomkwoips5qWK5rgDdoPnfJBwwyt7R8k3pJaGyKuS8pU8y6PJlQf3g/nKc1A/jRssxfX243OFp/EYnRhhhYGAJMl/dBSTs6KCIz97+ilM8l7ujCU8yfZWlXW1mt0bSVAZKiN2Uuawtjl/BlpsAJj/V+dpOXH3mnNzhXXNO3uwddBjGxeIv8qyHwT2ire5vH1RaTkq4UZc0F68w/6NGwJ+ScqO024Cpgt2DzvsP4afhNu68ccUHr4vG+5wpdfU2y5eDsnC1bxNABOrDCzBvS1RSf8wuwWgmdTFrR6HVuI8eV+VhtZookMLb77A6qdh8oQjVsUqtWwdCUDD77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0vxAlXPrc4tkq+c4hsH4uZSdsS3dIl5thPensNJKVY=;
 b=N43UqFX3HPbrYzRJ0kOO1ZvxJm6FO+0E2QAGZoYSjXmU7wtYs0fSNxDzPT9gLP3B937MIn3kyovldxl8BfMeoJkU2Ncn+TwmYHUyTKQn9JwANnkV+JvUlqIB6lMzOR+tr+TvfG25+rEGDeFjUJ3ZmWKrhWavr7PKfcOkyoKQOTBmNb+shRTmRoACOOsn+cF47nBEdc2m+Hlo1WUqTsrUSPsdamQVIWkRX2BUh0JbE3ePGpvxIFt34nSzvjzRkYBoKlUbgHKJCi2iHYK/7YDa/ULZ2WvJq4nPNdpAaumW7eAkjtRgIDxq6bxnMR8CNuVBtc3OkBiTNrb4Wym73p+QUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0vxAlXPrc4tkq+c4hsH4uZSdsS3dIl5thPensNJKVY=;
 b=M92xgEnolv1Kyo87KQRuZ4r2LcLaXSMBPGHE3GUBW8X1UMZmkZV2Eri9tpbQovoNEV7/nUijauuJd4aZT6Oi7o+hCQv+CHRe5EYHaNM2xXqiesa7YmldRSja/sFO6738LZOtXVQeEiCF9Ia1Gafqvxeo4CKr85UjAtn98dIfU6A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 08:06:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 08:06:19 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu: use amdgpu_bo_dmabuf for shared prime
 count
To: Nirmoy Das <nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
 <20210317074716.5547-4-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c5931d1c-a535-b253-52d5-2fa069b7554d@amd.com>
Date: Wed, 17 Mar 2021 09:06:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210317074716.5547-4-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
X-ClientProxiedBy: AM0PR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::48) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5]
 (2a02:908:1252:fb60:ccdd:b6ca:11e:5cc5) by
 AM0PR01CA0107.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 08:06:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90a5024b-b301-49ef-8241-08d8e91b8bcc
X-MS-TrafficTypeDiagnostic: BL0PR12MB4932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49320C72C921556E94A78C15836A9@BL0PR12MB4932.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LVY++dG24jUddPhpXaMMZscAjJQouJDtcRDZQ2Ew8zZ2Lwa6iE5QsDfz5RyHoNhTgK+/Ja7KC9tIo6HhoKR/XlePVrzT4XOaWLCukVYSDo/RTu+EWNoasD2J3d72R43X4TDjMZeCn09VwFgJYNlQY5tejl6G5gUQwGWoCQYAUp7k5z1Xvj9OvjFezV7lYcaRp2ntOOzXvsN0H8jwTdygZj3tmTlVXPa1TfEqmPjiwDrehIkYMxMhfa95kxZ1Tk4VvAxduThMwMsqMBL3f5PyJKv8+cnmT8pNauGn0e8BILxjrrRsBJXwlZbk1WZV020JFm7mpco4AVviq5go4StDKpLEOLoCdRVvDcZLIdFFGEHhlPZpaq88K8OBjHjt2bs9710PqeYGyD7xTOJ6H90x1Hv8aC4ES0DD2uardXSPh/bbcdgb/f2ve6ADitIa1crIHdXnQIdsMFtzHV5N7aGof0Pt/fwsqfugwZq3340jmHaWmytCGWsf/XnjIslBc5b9+9ZCVz28pnfMAvIXu6c0SqjL7E8Mbbv+TaEouHBtiCmwKOsgxnJeDIdKpfA4IePXVmrrtDhcvpgK6BLbz5QR/l2Moi4V0YDJ7qS0sf8oHrX+7bHsHBLv4YYiSUxQKOL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(6666004)(37006003)(186003)(83380400001)(6862004)(5660300002)(6636002)(316002)(8676002)(52116002)(2616005)(16526019)(478600001)(2906002)(36756003)(66556008)(31696002)(8936002)(86362001)(31686004)(66476007)(66946007)(6486002)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bG9WR3pVbHliSjJtZDJqL2ZLaDRReVNIaDVkcWJkT01nL2NQemdxL0t2djdJ?=
 =?utf-8?B?azdHbDlxaHkyNlpOZDNacml4WXF4UkZIQk84SGM3Y29nWkpZTWFnME5hcHdr?=
 =?utf-8?B?NU9CdElWeDBFMGJMbzRaakhGakdnMFNxSnUwWStoVWlNd3dGOFFSdGliQjhP?=
 =?utf-8?B?ZTRwRGl4OXgwMXpaSDlEQWlUNFJGRjl0aEtHQ3Vkd2RKbDhLeDNFWmlsR3Fw?=
 =?utf-8?B?d3liZWFyM3V3Z3NuTHQvWTRRVmFkd24rMDlVVlBZNmdTTWswL3Q0SG9LeFo3?=
 =?utf-8?B?U3JJRW9Zdm9rQVNzWVF5U0cyRU96cTFoQVBUNmlVVlN5RzNMaVQ2cE1BUVE1?=
 =?utf-8?B?R3I3S2h2QVhvWGZrQTUrQi80SXJrT0VJL2VXNlk5VVBWY0crc0pnU2lPUWIr?=
 =?utf-8?B?ZG5ZMFZGNlUwN2JJYXhESmdIMEdMWTFNMXVYVjJNYlJnY2tRY2o3dkNBK2lx?=
 =?utf-8?B?WTZKY2duYmQ0WWc1b3lZWUxvZWltV0tDRm03alZ4MzI0RzcvSHZvTnZzR1NR?=
 =?utf-8?B?b2RhZmFRNjZPbjJyQXU3eDIzNCtlVkVib3BVakc0aWxKTGg3azRxdHJKR3Ny?=
 =?utf-8?B?WGJKYThycmhEajhjTjRxY2FjdGdqQjdQZVpEUWZGb0h2dEY3cUNyTXg5ZlJm?=
 =?utf-8?B?a2VRRW1pYTFsRzFKTUNUMEtPYlhtREl0eTdUSEpuR0xIL1NsamJSc00zT1h4?=
 =?utf-8?B?d0s4LzhKYXVMazNxelJIVzl4TTJRSkFPREpSMmd0UFZFeHNCaWFxVEo0TTRi?=
 =?utf-8?B?YnNYcHVqa2FVeTk0TUd0USt3L0hYK210NWFmbWtYZG9MOXJrU01mQklhdXNG?=
 =?utf-8?B?WHFoT3VqKytVTTAyb1F5WEt5M0RDendQYzFnVnFoUzZhb1JsY2JsdWF6YndW?=
 =?utf-8?B?VzJPZTQ3eDFERVFRaDVIb255MHVqT2t0eWJ0UWdybVhHTXc3NFBKcjFRZm5I?=
 =?utf-8?B?Rm5vdFA2d3JCVEdrSUlNaitSdHQ3czR3TTJIZzUvN3pKejFCbThucm9xNklp?=
 =?utf-8?B?RHVIdG1BYWprWWdDQVMydkFRUUZOTWZDMmU5OFZKMkNOdnk4NExBcWR3WFhW?=
 =?utf-8?B?ZXBOYWd4SHRhcStVUHI5M3p6UFF1bmZEZHUvam91NmtSQTV6S0QxckdzM0hs?=
 =?utf-8?B?bWttVFF0Yi9GUk1uOVUxWkQrbWdFVzlhVTVvdGRHVk1sdUVnY3JSQjBhQjU4?=
 =?utf-8?B?YllBd3htVld6UW1EK2YvSnNkL2I1WC9SeGlWUkQwMGo4ZEM5eGtKOHZKTDRh?=
 =?utf-8?B?NE9Ya082QXNTVEdZMTlEZm9IRTZzUys3dVZUelVodGxSRkY4RkkwZ1p4ZjN0?=
 =?utf-8?B?RHNjaDRkL3FyNGp3T0lSbVQ4M2ZYVE03ck4vQmVBQTNrV1ZVUmU2aG91UkZP?=
 =?utf-8?B?YnNBZzYyUW5FTHJDYzJFd0dSNjV3WWVSQXk0Z3JIaEZEaU5tVWdnTVJST2FD?=
 =?utf-8?B?MXJBdHF2aXlMcE1xUWNvY3M5K01BTUlDMmhSVU95akcvVkZEdmQwZnU5Z3FZ?=
 =?utf-8?B?RVhrQnpZTm9XbXduUmlYTHRqSGE3dGlkcDEyald5RWpnMFNFcVRjWjBNTW9J?=
 =?utf-8?B?VS93Qi9NK2hPYzcyVGlPUjQ0amJybHliZzJyTGowSUtyZTlsVk9ZcjZDd3Ar?=
 =?utf-8?B?djVFLy9GMUQ2Y242SFVJSGh3RFhsckpWYkkzWEF4R2RvN0RqQkNrS3dLTjB1?=
 =?utf-8?B?OFMrVzhRZ3I2aVJFMmN1NWdhb1k4bGQ0bncyNjFyQ0dSMWYrVmkwMnFQanpG?=
 =?utf-8?B?SkRINWdMdVFoL2kyYXJmQ1J4cVVuNnFPT2xycHZNKzFtblZHYldQRjlFRUVl?=
 =?utf-8?B?UjRpeVZJMGNFelVDLzdSR3czRVpsSEo3dUZJR0VwbHQzL1U1VnRRYVdUZ2gv?=
 =?utf-8?Q?EGcITcxRTVquB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a5024b-b301-49ef-8241-08d8e91b8bcc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 08:06:19.5667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNu4a+TFQIdPPH7H+uZ1/ng8NjHyomtNcRdf/Ju/oW1Fms10DAY3ZPahUmmFCmtl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

That whole approach won't work :)

The prime_shared_count is on the exported BO and not on the imported one.

So any user BO can be exported.

Regards,
Christian.

Am 17.03.21 um 08:47 schrieb Nirmoy Das:
> Remove prime_shared_count from base class and use that
> the subclass, amdgpu_bo_dmabuf.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 12 ++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
>   5 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b5c766998045..04994757cc9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -618,7 +618,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>   
>   		/* Make sure we use the exclusive slot for shared BOs */
> -		if (bo->prime_shared_count)
> +		if (is_amdgpu_bo_dmabuf(bo))
>   			e->tv.num_shared = 0;
>   		e->bo_va = amdgpu_vm_bo_find(vm, bo);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e0c4f7c7f1b9..3cf57ea56499 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -143,6 +143,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>   {
>   	struct drm_gem_object *obj = dmabuf->priv;
>   	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +	struct amdgpu_bo_dmabuf *dbo = to_amdgpu_bo_dmabuf(bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	int r;
>   
> @@ -172,7 +173,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>   	if (r)
>   		goto out;
>   
> -	bo->prime_shared_count++;
> +	dbo->prime_shared_count++;
>   	amdgpu_bo_unreserve(bo);
>   	return 0;
>   
> @@ -194,10 +195,11 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
>   {
>   	struct drm_gem_object *obj = dmabuf->priv;
>   	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +	struct amdgpu_bo_dmabuf *dbo = to_amdgpu_bo_dmabuf(bo);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   
> -	if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
> -		bo->prime_shared_count--;
> +	if (attach->dev->driver != adev->dev->driver && dbo->prime_shared_count)
> +		dbo->prime_shared_count--;
>   
>   	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>   	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -431,6 +433,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct drm_gem_object *gobj;
>   	struct amdgpu_bo *bo;
> +	struct amdgpu_bo_dmabuf *dbo;
>   	uint64_t flags = 0;
>   	int ret;
>   
> @@ -449,10 +452,11 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
>   		goto error;
>   
>   	bo = gem_to_amdgpu_bo(gobj);
> +	dbo = to_amdgpu_bo_dmabuf(bo);
>   	bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
>   	bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
>   	if (dma_buf->ops != &amdgpu_dmabuf_ops)
> -		bo->prime_shared_count = 1;
> +		dbo->prime_shared_count = 1;
>   
>   	dma_resv_unlock(resv);
>   	return gobj;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 5366a806be2b..7cce8aa29fd7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -783,7 +783,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
>   		break;
>   	}
>   	case AMDGPU_GEM_OP_SET_PLACEMENT:
> -		if (robj->prime_shared_count && (args->value & AMDGPU_GEM_DOMAIN_VRAM)) {
> +		if (is_amdgpu_bo_dmabuf(robj) && (args->value & AMDGPU_GEM_DOMAIN_VRAM)) {
>   			r = -EINVAL;
>   			amdgpu_bo_unreserve(robj);
>   			break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ad615eec1e8c..435bf85991e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -965,7 +965,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   		return -EINVAL;
>   
>   	/* A shared bo cannot be migrated to VRAM */
> -	if (bo->prime_shared_count || bo->tbo.base.import_attach) {
> +	if (is_amdgpu_bo_dmabuf(bo) || bo->tbo.base.import_attach) {
>   		if (domain & AMDGPU_GEM_DOMAIN_GTT)
>   			domain = AMDGPU_GEM_DOMAIN_GTT;
>   		else
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 3d23ad247b1b..2f1abcc4e1e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -93,7 +93,6 @@ struct amdgpu_bo {
>   	struct ttm_buffer_object	tbo;
>   	struct ttm_bo_kmap_obj		kmap;
>   	u64				flags;
> -	unsigned			prime_shared_count;
>   	/* per VM structure for page tables and with virtual addresses */
>   	struct amdgpu_vm_bo_base	*vm_bo;
>   	/* Constant after initialization */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
