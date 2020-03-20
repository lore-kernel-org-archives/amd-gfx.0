Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2CAC4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 21:48:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E283820637
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 21:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bd/LYbF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E283820637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A137C89F07;
	Fri, 20 Mar 2020 21:48:05 +0000 (UTC)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60E889F07;
 Fri, 20 Mar 2020 21:48:04 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e753a070001>; Fri, 20 Mar 2020 14:47:51 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Fri, 20 Mar 2020 14:48:04 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Fri, 20 Mar 2020 14:48:04 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Fri, 20 Mar 2020 21:48:02 +0000
Subject: Re: [PATCH hmm 0/6] Small hmm_range_fault() cleanups
To: Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>,
 <Felix.Kuehling@amd.com>
References: <20200320164905.21722-1-jgg@ziepe.ca>
X-Nvconfidentiality: public
From: Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <70d2adde-4f70-de17-fccc-d422eb994d08@nvidia.com>
Date: Fri, 20 Mar 2020 14:47:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200320164905.21722-1-jgg@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1584740871; bh=PKGdsKNTkrFA0tPTeWZ+wBPsvoEb1fR+GjOQG6/RL7E=;
 h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=Bd/LYbF47QbOI1HqX00s4RZqs2tgtjKDUDamrYDvhrWMWTDXgiKFti2yiE6ODETPw
 Z7Ii+W6kMuOeZ2U3NPm2ks6k3q4sUj0RaPMxEGoEpDXFrrE7Qjslqn2W5oyN8SMAsS
 dtHpnaxUfTuhlQQsjIcIDWAy74TUH+H0pwxmrin3yFRCSf8r7maZRRXS1z8FtDJoTw
 xzeoIiUrnIwnboUjst6k8TFTYmnAlCnJkAN8XzaA4zEYfRXKTQ0GY8Kkgm5rBkEn3U
 7HNfPL9GwVjdJwDTKWQ3UNWXomUofIwHAEC+XA0tzzrO2EXCzbs/b5Q6mf3bWTEDLu
 jg1URNhwEnaew==
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
Cc: Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 3/20/20 9:48 AM, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> I've had these in my work queue for a bit, nothing profound here, just some
> small edits for clarity.
> 
> Ralph's hmm tester will need a small diff to work after this - which
> illustrates how setting default_flags == 0 is the same as what was called
> SNAPSHOT:
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 6ca953926dc13f..5f31f5b3e64cb9 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -300,7 +300,7 @@ static int dmirror_range_fault(struct dmirror *dmirror,
>   
>   		range->notifier_seq = mmu_interval_read_begin(range->notifier);
>   		down_read(&mm->mmap_sem);
> -		count = hmm_range_fault(range, 0);
> +		count = hmm_range_fault(range);
>   		up_read(&mm->mmap_sem);
>   		if (count <= 0) {
>   			if (count == 0 || count == -EBUSY)
> @@ -337,8 +337,7 @@ static int dmirror_fault(struct dmirror *dmirror, unsigned long start,
>   		.flags = dmirror_hmm_flags,
>   		.values = dmirror_hmm_values,
>   		.pfn_shift = DPT_SHIFT,
> -		.pfn_flags_mask = ~(dmirror_hmm_flags[HMM_PFN_VALID] |
> -				    dmirror_hmm_flags[HMM_PFN_WRITE]),
> +		.pfn_flags_mask = 0,
>   		.default_flags = dmirror_hmm_flags[HMM_PFN_VALID] |
>   				(write ? dmirror_hmm_flags[HMM_PFN_WRITE] : 0),
>   		.dev_private_owner = dmirror->mdevice,
> @@ -872,7 +871,7 @@ static int dmirror_range_snapshot(struct dmirror *dmirror,
>   		range->notifier_seq = mmu_interval_read_begin(range->notifier);
>   
>   		down_read(&mm->mmap_sem);
> -		count = hmm_range_fault(range, HMM_FAULT_SNAPSHOT);
> +		count = hmm_range_fault(range);
>   		up_read(&mm->mmap_sem);
>   		if (count <= 0) {
>   			if (count == 0 || count == -EBUSY)
> @@ -916,7 +915,7 @@ static int dmirror_snapshot(struct dmirror *dmirror,
>   		.flags = dmirror_hmm_flags,
>   		.values = dmirror_hmm_values,
>   		.pfn_shift = DPT_SHIFT,
> -		.pfn_flags_mask = ~0ULL,
> +		.pfn_flags_mask = 0,
>   		.dev_private_owner = dmirror->mdevice,
>   	};
>   	int ret = 0;
> 
> Jason Gunthorpe (6):
>    mm/hmm: remove pgmap checking for devmap pages
>    mm/hmm: return the fault type from hmm_pte_need_fault()
>    mm/hmm: remove unused code and tidy comments
>    mm/hmm: remove HMM_FAULT_SNAPSHOT
>    mm/hmm: remove the CONFIG_TRANSPARENT_HUGEPAGE #ifdef
>    mm/hmm: use device_private_entry_to_pfn()
> 
>   Documentation/vm/hmm.rst                |  12 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   2 +-
>   drivers/gpu/drm/nouveau/nouveau_svm.c   |   2 +-
>   include/linux/hmm.h                     |  55 +-----
>   mm/hmm.c                                | 238 +++++++++---------------
>   5 files changed, 98 insertions(+), 211 deletions(-)
> 
The series looks good to me so,
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
