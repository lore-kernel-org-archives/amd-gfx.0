Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F8CC1975A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 13:25:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64BD2078A
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 13:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MF9KDpmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64BD2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779C96E0A2;
	Wed, 25 Mar 2020 13:25:28 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690061.outbound.protection.outlook.com [40.107.69.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A0A46E0A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 13:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IH5Fsm43+t4iFqPCYSYmrS2D012TwGLaYjorEiGLKWEgbp2dtkfp48A2oldEkBGrM3hhmRD+TxgXgBZOsI6bl099txkaE+0LyfklltlDgD7j35fh6Q71HvokE1v0g4sA4q2Ts/FsGYBcZE92Bw96NUrJyFIsSN/fAnTADAfhXeSGzKiK216haVg0qkmDQyCvjoRY5M3v/MDAVOAxYLIFe+mMcKz9a8sF/Q7OjqgfO/VHVHcUt8N2/dknCYL/nCiBrjExTnxSBDjcWh6GarCYzs2BeZSoNcOq9N6qW2+gy45Qb5AND0huEiuYiLMileBG0Vn1T3xxElzJ5j2e8WG+tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4K7UvOwL7zDX10612XbQ/Ie3xQzrwZWl9Ltly10y5Q=;
 b=I/Q4h6LVhBiqKakF9YmqDI5qBNntqNGpW6HMKpC0yMoLSUsSXeS7VW2APYUnxmdjC3pXHCBZN9I1G5SF9wzx6inTL5e9ENmefPqzTRxzGC31L1e2Joy9mrv5Hf0Qg7u7PHi+KjBLIGPngxI3dW736CW2AuQ/GGePpQc5PsuAPGTo2zs+TqHbEGRgQ5g87+YPh/Y4ohIKiwSRX7ab0a46T5oPFpP5RyiAe6L76r4/iq0G+0Z0oTwiO2Sps9q0DO3pBRuHa4bXZbF3c8EJWwF38WI0E4mmM0XQt5DmMJ8jxas+RDT3TPDhr9iRg0BFRD/5SJehHIkQ/jdpXqJGmdQPtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4K7UvOwL7zDX10612XbQ/Ie3xQzrwZWl9Ltly10y5Q=;
 b=MF9KDpmi+knvmRjO8uvGVXE45gx+7LmyQo1AGNtqIuuAovhnWK5oOfdcIioMvxASEwxwYRl+ia/cxqcx/5Nx2jV/GKJuVkj9yd2OqhAjmArSMKh6ticeVIKgoy5UlGf5+xPJZrpVy4IiKpHa0JcvhEbCAdpXsA2JwBlt2wUcjU4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3133.namprd12.prod.outlook.com (2603:10b6:208:c7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 13:25:25 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 13:25:25 +0000
Date: Wed, 25 Mar 2020 21:25:16 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: add full TMZ support into
 amdgpu_ttm_map_buffer v2
Message-ID: <20200325132515.GA4743@jenkins-Celadon-RN>
References: <20200322154835.2702-1-christian.koenig@amd.com>
 <20200322154835.2702-2-christian.koenig@amd.com>
 <20200323082903.GB25240@jenkins-Celadon-RN>
 <ea8d4b27-4228-c8ab-a95d-1706d99f79a9@gmail.com>
Content-Disposition: inline
In-Reply-To: <ea8d4b27-4228-c8ab-a95d-1706d99f79a9@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR03CA0043.apcprd03.prod.outlook.com (2603:1096:202:17::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.12 via Frontend Transport; Wed, 25 Mar 2020 13:25:23 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd927142-e081-4b0b-a68e-08d7d0bff9f3
X-MS-TrafficTypeDiagnostic: MN2PR12MB3133:|MN2PR12MB3133:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3133C36CF9651E56E8BF9B4AECCE0@MN2PR12MB3133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(81156014)(6666004)(2906002)(9686003)(52116002)(55016002)(8936002)(6496006)(81166006)(54906003)(86362001)(6862004)(8676002)(1076003)(26005)(478600001)(956004)(66476007)(186003)(966005)(316002)(66556008)(5660300002)(33716001)(4326008)(16526019)(33656002)(45080400002)(66946007)(6636002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3133;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4srBo0pqTZJfFy7FDTW19gx9+upvSaMstJrB94T5qQhzC7kwvc9WhGR+X/OdvHBWd2ilvjVWK6kk0lKvEDT6YJ71vGTsFb5LJSCMcHLrLMCDsOH55i5Rc9QhBHRjEI7Z0foCDlYoGbQUVYcVIGMO9ol2NYtSMedKEiKwkpE/dmJgGTUigEYVr4BajQR6S3WM8Fk9TpRtJWkWKQKG1Sx/vzjBnZ+3ZmcvM74QAWwpG3e42+xnGWwRzUvfT8OHR0fJHS5mglp83Ny43rWWMlsiHIND0pFvxG2hA7gbc6yzIqZhlNOHWaLI7chTodcDwYqLml7YCBxXZhsMWmoagY5M8u+1fe+eOLhIjNp3Voc/ZqDLFsPFE9cJdTKV4Q4MobRtKzX3tKWap2bArv0gkoGdj7EGTDZaCaOzM/fKE/C4xGkJa6gAPKkfTTGJPuwCCaoqOAyW3oaEHcXGw3iNWzxbCaclz8YYUpnmMQHrXvk++ck=
X-MS-Exchange-AntiSpam-MessageData: jn3zL4EWvtpc7r8GUy+zurxK1GFdCyy3jnrBHV9hiYQs4T9QehqEqMjn3Yih0ggWyk/Le4wCS1c+Gk8e62NdHBjufwmxzJt47bUw3hmWJgAgd7bNpX2BkBJztZfc5Sc+9kfFu3HRxyNs+Pv2sxrPhg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd927142-e081-4b0b-a68e-08d7d0bff9f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 13:25:25.1747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BY/yMrAQlLDdw25rDVXShy8F4zruwYpe/t+qUur6gr/KwYD74/uvBPayJGpHBcHOP59+DUUZuiCdZz6WorsnkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3133
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 23, 2020 at 08:24:03PM +0800, Christian K=F6nig wrote:
> Am 23.03.20 um 09:29 schrieb Huang Rui:
> > On Sun, Mar 22, 2020 at 04:48:35PM +0100, Christian K=F6nig wrote:
> >> This should allow us to also support VRAM->GTT moves.
> >>
> >> v2: fix missing vram_base_adjustment
> >>
> >> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 38 +++++++++++++++++++++++=
+++-------
> >>   1 file changed, 30 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c
> >> index 53de99dbaead..e15a343a944b 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> @@ -309,21 +309,21 @@ static int amdgpu_ttm_map_buffer(struct ttm_buff=
er_object *bo,
> >>   				 unsigned window, struct amdgpu_ring *ring,
> >>   				 bool tmz, uint64_t *addr)
> >>   {
> >> -	struct ttm_dma_tt *dma =3D container_of(bo->ttm, struct ttm_dma_tt, =
ttm);
> >>   	struct amdgpu_device *adev =3D ring->adev;
> >>   	struct amdgpu_job *job;
> >>   	unsigned num_dw, num_bytes;
> >> -	dma_addr_t *dma_address;
> >>   	struct dma_fence *fence;
> >>   	uint64_t src_addr, dst_addr;
> >> +	void *cpu_addr;
> >>   	uint64_t flags;
> >> +	unsigned int i;
> >>   	int r;
> >>   =

> >>   	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
> >>   	       AMDGPU_GTT_MAX_TRANSFER_SIZE * 8);
> >>   =

> >>   	/* Map only what can't be accessed directly */
> >> -	if (mem->start !=3D AMDGPU_BO_INVALID_OFFSET) {
> >> +	if (!tmz && mem->start !=3D AMDGPU_BO_INVALID_OFFSET) {
> >>   		*addr =3D amdgpu_mm_node_addr(bo, mm_node, mem) + offset;
> >>   		return 0;
> >>   	}
> >> @@ -351,15 +351,37 @@ static int amdgpu_ttm_map_buffer(struct ttm_buff=
er_object *bo,
> >>   	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> >>   	WARN_ON(job->ibs[0].length_dw > num_dw);
> >>   =

> >> -	dma_address =3D &dma->dma_address[offset >> PAGE_SHIFT];
> >>   	flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->ttm, mem);
> >>   	if (tmz)
> >>   		flags |=3D AMDGPU_PTE_TMZ;
> >>   =

> >> -	r =3D amdgpu_gart_map(adev, 0, num_pages, dma_address, flags,
> >> -			    &job->ibs[0].ptr[num_dw]);
> >> -	if (r)
> >> -		goto error_free;
> >> +	cpu_addr =3D &job->ibs[0].ptr[num_dw];
> >> +
> >> +	if (mem->mem_type =3D=3D TTM_PL_TT) {
> >> +		struct ttm_dma_tt *dma;
> >> +		dma_addr_t *dma_address;
> >> +
> >> +		dma =3D container_of(bo->ttm, struct ttm_dma_tt, ttm);
> >> +		dma_address =3D &dma->dma_address[offset >> PAGE_SHIFT];
> >> +		r =3D amdgpu_gart_map(adev, 0, num_pages, dma_address, flags,
> >> +				    cpu_addr);
> >> +		if (r)
> >> +			goto error_free;
> >> +	} else {
> >> +		dma_addr_t dma_address;
> >> +
> >> +		dma_address =3D (mm_node->start << PAGE_SHIFT) + offset;
> >> +		dma_address +=3D adev->vm_manager.vram_base_offset;
> >> +
> >> +		for (i =3D 0; i < num_pages; ++i) {
> >> +			r =3D amdgpu_gart_map(adev, i << PAGE_SHIFT, 1,
> >> +					    &dma_address, flags, cpu_addr);
> > May I know why do we need map the page one by one here? Is it because if
> > not PL_TT, the buffer might not be continuous?
> =

> The problem is actually the other way around.
> =

> amdgpu_gart_map() expects an array with not continuous addresses for =

> PL_TT, but we have an continuous address here we want to map.
> =

> At some point we should probably switch that to using sg_tables or some =

> other better structure, but for now this should be sufficient.
> =


Got it, that makes sense, it should be vram in this path with continuous
address. Thanks!

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> Regards,
> Christian.
> =

> >
> > Thanks,
> > Ray
> >
> >> +			if (r)
> >> +				goto error_free;
> >> +
> >> +			dma_address +=3D PAGE_SIZE;
> >> +		}
> >> +	}
> >>   =

> >>   	r =3D amdgpu_job_submit(job, &adev->mman.entity,
> >>   			      AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> >> -- =

> >> 2.14.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cray=
.huang%40amd.com%7C98ca56599adf4bdc84f808d7cf2514af%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637205630497521290&amp;sdata=3DnDt56svLaMkectwRV4TdJ8=
pilHycs3wGPIPCnHvCUx4%3D&amp;reserved=3D0
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
