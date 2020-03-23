Return-Path: <SRS0=zf+m=5I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419BC4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 08:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C448120409
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2020 08:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K5usqmPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C448120409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3357B89E05;
	Mon, 23 Mar 2020 08:29:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB1489E05
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 08:29:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7lP4MC142RbrWmi2b4kytDJ3QzVViYTwCZQArmvvrYi/j3anvlYsfmFWlIt2QmQAEZzxFfLZqlw8jiCTqM3TCIT29WEo+lV/oRGrY+cZvn9iqHRvZHYOd/olEeiIb888cPrC95tigH6GCR2TWVQlD9P8J3rf8grx83t98rfVUSv3Yi8bIdXGgk1aqI2lIUHfaBmOysCTt2tNluai7C7CkeMyfE0+4qZEjRjzsWyv3qGddUEnnMICneENjv14Hk3528ZKE65XYWOofeUpXVr/Qwn83gnDBGUe+reshVb2tendGqhrVQmV0H72Af5RuKqdtw5tMjsDyCI27lPkyz4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wclzLWj0tuMSbRP4IT2Qqg2HTgbA5pByinDO76+Ois=;
 b=FhyA5P5AuorUchRC/AIr1Uqpvp6KSEFdKau7XieGU/ic9ABWbWtrZGxmaX1PXeYY9CEUUBPJhXLIqKSuWOrIZ3Lr2wdSiDMNG6DpyNUOOyGmcu/Frvd63tzwmPRBDfJ1knm8DmWOtcmrh8dKFT617hmnO0yKNPdulJjpqRU3N/8cV3tZtUZ2JM1Hh7FF66R0IPmnmeRCc3Kn6oGdN6rPl/6F8jAKw+wxApJHZc2DSzsJztof17TaAUPzOT3AY6XQRbzDAknW2B5zMb5u8tRNNe/Mq3s3fmeWzJ+6ETvyclQ9pnUmgg6X2/N7kIhZDVcva2H+Wa5U08h835bP9Na4vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wclzLWj0tuMSbRP4IT2Qqg2HTgbA5pByinDO76+Ois=;
 b=K5usqmPIlrf3bPymh9l0fRNRlSrheO5Wqkve5NJ9urkcJtxAqCdXQvhMnVFVkbOSgmH1u+vEs8kTZdnF6/lOAdnto+QtmcbNx1nNZsZHsqgZJFfEeIbZNKgWQgoJsXygOOCvbQvGSpBSOyFRyp6mvKwV8f3Ry3byqcnlnIdfI88=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB2862.namprd12.prod.outlook.com (2603:10b6:208:a9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Mon, 23 Mar
 2020 08:29:14 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2814.027; Mon, 23 Mar 2020
 08:29:14 +0000
Date: Mon, 23 Mar 2020 16:29:04 +0800
From: Huang Rui <ray.huang@amd.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add full TMZ support into
 amdgpu_ttm_map_buffer v2
Message-ID: <20200323082903.GB25240@jenkins-Celadon-RN>
References: <20200322154835.2702-1-christian.koenig@amd.com>
 <20200322154835.2702-2-christian.koenig@amd.com>
Content-Disposition: inline
In-Reply-To: <20200322154835.2702-2-christian.koenig@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.9 via Frontend Transport; Mon, 23 Mar 2020 08:29:12 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bb2c1289-198a-44a1-4d74-08d7cf0444b0
X-MS-TrafficTypeDiagnostic: MN2PR12MB2862:|MN2PR12MB2862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2862B5AED30A1BBF5AAF83A0ECF00@MN2PR12MB2862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(8936002)(6916009)(186003)(16526019)(316002)(86362001)(966005)(26005)(33656002)(45080400002)(9686003)(55016002)(478600001)(8676002)(4326008)(66556008)(66476007)(66946007)(33716001)(2906002)(81166006)(81156014)(956004)(1076003)(5660300002)(52116002)(6496006)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB2862;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ibne9tqrtXmcyWe8DnxD31ylM6Jc8BbQpGd7+H3JyrTkihKi83ngrar2Mx3b9kizJo96rGS+iq12443eSp/880QNDSpkNUXAQnReREE2DEJphxNMWpZQ78X06EJ6Z3gLOjbb9LMapFAkEXxd5dE32+0KEFvt/EGHt4K9LXrHiBMR3spyxXIHsTOe9IL7a5b7EdB5RiqO5dYRdvBw84yHCqkJSFseLELeSIexalzNxXuT+qRP6Ru82/L827UyUzo0mG/kvQDNIjL/iC5WYpQE+dbPxaSNHbSpzgrD/dsBzG8GxvFWR2dEOfe9ujsDKDFrt4GT4Tbyt+VhRtogNPuAULfBb1d2EklkVuu8K/CEk3piZqB5qZWsYs/jrdDmH8Ok74MrebtwFT5goPwugbhGN+jPAiJFY5Md4p5F7SqO5n86eCI0wjfGSDSOW5R/z7R7xuGHPnJW+yRpJS9/YeSiMyQt0NRvJGFpOninoUl1ElM=
X-MS-Exchange-AntiSpam-MessageData: nBKWTMyHixC39QgCjuytgkTh7Xy7suavq8iZuw6OXCI69eNwUS09Kb3TFWqQ411lbVCyeitNyl+pglt74zTdvcKgZbLMtBi2gE7f1LG/sPipZflk1ratEJJqG1T1sZsKTCNsgu+n3p/EalqQtyh0pg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2c1289-198a-44a1-4d74-08d7cf0444b0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 08:29:14.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fi99LVjqDqfPrHzdyAWzR+WKviRTK8iEY70Hza5+Y2Nbk8MovgMvZU3bjZ0K9X1nWyOt6T2Acbt/6nBfpr0HCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2862
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
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Mar 22, 2020 at 04:48:35PM +0100, Christian K=F6nig wrote:
> This should allow us to also support VRAM->GTT moves.
> =

> v2: fix missing vram_base_adjustment
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 38 ++++++++++++++++++++++++++-=
------
>  1 file changed, 30 insertions(+), 8 deletions(-)
> =

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 53de99dbaead..e15a343a944b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -309,21 +309,21 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_=
object *bo,
>  				 unsigned window, struct amdgpu_ring *ring,
>  				 bool tmz, uint64_t *addr)
>  {
> -	struct ttm_dma_tt *dma =3D container_of(bo->ttm, struct ttm_dma_tt, ttm=
);
>  	struct amdgpu_device *adev =3D ring->adev;
>  	struct amdgpu_job *job;
>  	unsigned num_dw, num_bytes;
> -	dma_addr_t *dma_address;
>  	struct dma_fence *fence;
>  	uint64_t src_addr, dst_addr;
> +	void *cpu_addr;
>  	uint64_t flags;
> +	unsigned int i;
>  	int r;
>  =

>  	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
>  	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
>  =

>  	/* Map only what can't be accessed directly */
> -	if (mem->start !=3D AMDGPU_BO_INVALID_OFFSET) {
> +	if (!tmz && mem->start !=3D AMDGPU_BO_INVALID_OFFSET) {
>  		*addr =3D amdgpu_mm_node_addr(bo, mm_node, mem) + offset;
>  		return 0;
>  	}
> @@ -351,15 +351,37 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_=
object *bo,
>  	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
>  	WARN_ON(job->ibs[0].length_dw > num_dw);
>  =

> -	dma_address =3D &dma->dma_address[offset >> PAGE_SHIFT];
>  	flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->ttm, mem);
>  	if (tmz)
>  		flags |=3D AMDGPU_PTE_TMZ;
>  =

> -	r =3D amdgpu_gart_map(adev, 0, num_pages, dma_address, flags,
> -			    &job->ibs[0].ptr[num_dw]);
> -	if (r)
> -		goto error_free;
> +	cpu_addr =3D &job->ibs[0].ptr[num_dw];
> +
> +	if (mem->mem_type =3D=3D TTM_PL_TT) {
> +		struct ttm_dma_tt *dma;
> +		dma_addr_t *dma_address;
> +
> +		dma =3D container_of(bo->ttm, struct ttm_dma_tt, ttm);
> +		dma_address =3D &dma->dma_address[offset >> PAGE_SHIFT];
> +		r =3D amdgpu_gart_map(adev, 0, num_pages, dma_address, flags,
> +				    cpu_addr);
> +		if (r)
> +			goto error_free;
> +	} else {
> +		dma_addr_t dma_address;
> +
> +		dma_address =3D (mm_node->start << PAGE_SHIFT) + offset;
> +		dma_address +=3D adev->vm_manager.vram_base_offset;
> +
> +		for (i =3D 0; i < num_pages; ++i) {
> +			r =3D amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
> +					    &dma_address, flags, cpu_addr);

May I know why do we need map the page one by one here? Is it because if
not PL_TT, the buffer might not be continuous?

Thanks,
Ray

> +			if (r)
> +				goto error_free;
> +
> +			dma_address +=3D PAGE_SIZE;
> +		}
> +	}
>  =

>  	r =3D amdgpu_job_submit(job, &adev->mman.entity,
>  			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> -- =

> 2.14.1
> =

> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cray.hu=
ang%40amd.com%7C456a9e561ae44b6bb94508d7ce787f99%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637204889263466725&amp;sdata=3DzoVAOn4UX4Y3voMhyI4OwEKte=
7TgzGLC5ZmAj9TkW%2FU%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
