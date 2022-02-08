Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEDFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 810778909F;
	Tue,  8 Feb 2022 08:26:45 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F1110E342
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:09:40 +0000 (UTC)
Received: by mail-yb1-xb36.google.com with SMTP id v47so22605471ybi.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DC5h5QPa2MMSD8jMuUZaOZTMv0rKCEv7tr+WwakctiM=;
 b=UKt/5gqtEQEDR+I4jR//5bWv57hPVaW9KmAr8xHRshFW+V9PDSWkFrBE8Hyb8wlSkA
 QQKQ+stzgyEgp5J4DyVY4bvPNBtHP4wSzJ6uJck+8cplu8GPkuIVWQ+Y8zm1xv27s0Zu
 cR2ljgqob8w9EmBGVw0EdJVkId5N+xNPUHeADg5epuSLdcXTrW9Tqo5OcA22EaRu8U3K
 l3cuLzKBbOc9GbQXk+h497gXyT6KtsqpW966ysKE5jotsGOXr7l3B+dKnggATk5GoyUy
 KJOt1xwxzqYiEqEVIBRmXg0oLWnTj4m1q1+iR+FtOucXjtQu9GfhLJMBe3O/kYgazNfR
 tnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DC5h5QPa2MMSD8jMuUZaOZTMv0rKCEv7tr+WwakctiM=;
 b=cvmMu932hc9WUmfNa8q0DQ/1REpAEQNcbl3g3AIC+cYVMhsRbFIjPU0pjbsJ9TBdUD
 +2HGk0R/UFuU/1Nt/Ake+CAjvrou9/3c79FrVJVwWfwiPUlgoIJcPnVFA6i5bXU6WWXN
 p792g0ZXD3/fd9oDtIQLFCVp77Dl0S3FC9qdnU1eyHHA7sDHdPAq053m+h/jXsRcozAj
 zrJS8AUMI2iGfAfGxYMqtHxSk5mXx9O73+TCRyaMTVGRKEnnrgBmEn4pA8fVort6zMuZ
 Yzh9/eBmclPbxThx5sUG0LRF/USXTq4YJYZ7V7jDY6OcDv3nxU796TCn7G9w14+i5Kcw
 sL0Q==
X-Gm-Message-State: AOAM531yV/5YZPsvJInaX3slhkPwwXnT0nRcKN7LsPPhM0EvgfRaxKKK
 Q4E+x+juIELVhNS+5pCuvD4armtwDRNBVJ57grLgqA==
X-Google-Smtp-Source: ABdhPJyFSmuR7M4HIJ31YSJoOUpobAKTBK69kzVotLKdLdB2NRipgBTZ2XLKWECEqSNiqnwAnFetqc4Ion8CCMp0OGY=
X-Received: by 2002:a81:ad46:: with SMTP id l6mr3668263ywk.31.1644307779769;
 Tue, 08 Feb 2022 00:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-5-hch@lst.de>
In-Reply-To: <20220207063249.1833066-5-hch@lst.de>
From: Muchun Song <songmuchun@bytedance.com>
Date: Tue, 8 Feb 2022 16:09:03 +0800
Message-ID: <CAMZfGtUqbU9VpCOA-9bdU6d1CoQ7n8D+26v4j79uLcH1uc5Q2w@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm: move free_devmap_managed_page to memremap.c
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 08 Feb 2022 08:26:44 +0000
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
Cc: nvdimm@lists.linux.dev, Ralph Campbell <rcampbell@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 Karol Herbst <kherbst@redhat.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 nouveau@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Ben Skeggs <bskeggs@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Dan Williams <dan.j.williams@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 7, 2022 at 2:42 PM Christoph Hellwig <hch@lst.de> wrote:
>
> free_devmap_managed_page has nothing to do with the code in swap.c,
> move it to live with the rest of the code for devmap handling.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
