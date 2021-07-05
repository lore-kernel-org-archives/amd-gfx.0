Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AEC07E9C
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 07:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7338E6198E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 07:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7338E6198E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0BC89994;
	Tue,  6 Jul 2021 07:26:12 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 949F889998
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jul 2021 16:52:28 +0000 (UTC)
Received: by mail-qv1-xf33.google.com with SMTP id x6so8530558qvx.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jul 2021 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TRW2liv0KvxRpEn1sZgxByQ6WPmBTh1GhCnSHVjnwbg=;
 b=jBFIqWpkHJUwhFRIEXpavqYg2lOBnFUgtfMCAa51Keo5p1e7uaLLRwx5ShUDeIlhdM
 2If2zjmjcfC5T6RoGkkweicUk3Qsx+2vRdseYI/0mJ+ciw96iBmUkpkVkiJE+86t8cyr
 2oJc7CwvfA5oUIWZzMzGPAFug62Z67fj3p3Z3WgSBFHsqz4/BWGoOCucw+iLuagpvAH1
 PpbSwCitf8MOcMx6/0YLotNGXe8rFb+KOw2NMKF5n5y/HAuQN75chVqThR99yPOEQKYA
 xDWvGJSbbwBNR2Hg29azK+xEHKNYDfvZIIv02WRktmpruBPJPenBbq+963N6aPphnsv4
 Bn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TRW2liv0KvxRpEn1sZgxByQ6WPmBTh1GhCnSHVjnwbg=;
 b=seUHmBypU42FLNxNupC50hU6jp4QTzQYXaGHEF5y9NR74O8k4Nfo4hb/A3tMRTMkJt
 aJlOoJ2bCAD7IjvUElASd80DPU8DIJ66Th33VJNFrYVnSKF0xv1X9JpqgmBigATUNtJb
 zcOwEcyjsq3HxwB6EdTi/1YzeXcpF6UK4j1Ld1G1o6zu8IAYAkxcKy0Uh9SV/ObmpOQK
 gMyRAIoM9LuykY1b6s2JSEpp9vReFnUW/k+Ah4DNI2bvhvEkPBxCLn1XY//AQ0KT2qX2
 /0W6Y8MtUCt2kFAn9csOcLg3i9ZUBHGBIR0OoT6fZ+N4M4+FOjkEmAog8Ppx6k1CHFik
 Bt2g==
X-Gm-Message-State: AOAM530A1cuTqfMVWubS8cOeUTSIWk0odmyfBSQpLM+FY5IMCulZCWpB
 OQ9VeCU8nPY4sA9ndD5ZBRP2Wg==
X-Google-Smtp-Source: ABdhPJw/xzr3myWPCDkP4OYKH+JUqyzPcaaW7tJ0//CdDzso+M0bp2m0674/I/B/gC+TTQwFiqkSng==
X-Received: by 2002:a0c:ef51:: with SMTP id t17mr13560008qvs.14.1625503947734; 
 Mon, 05 Jul 2021 09:52:27 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [47.55.113.94])
 by smtp.gmail.com with ESMTPSA id 82sm5694070qke.63.2021.07.05.09.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 09:52:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1m0Rpa-003sCS-IC; Mon, 05 Jul 2021 13:52:26 -0300
Date: Mon, 5 Jul 2021 13:52:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <ogabbay@kernel.org>
Subject: Re: [PATCH v4 2/2] habanalabs: add support for dma-buf exporter
Message-ID: <20210705165226.GJ4604@ziepe.ca>
References: <20210705130314.11519-1-ogabbay@kernel.org>
 <20210705130314.11519-3-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705130314.11519-3-ogabbay@kernel.org>
X-Mailman-Approved-At: Tue, 06 Jul 2021 07:26:10 +0000
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
Cc: linux-rdma@vger.kernel.org, daniel.vetter@ffwll.ch, sleybo@amazon.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 galpress@amazon.com, linaro-mm-sig@lists.linaro.org, dledford@redhat.com,
 hch@lst.de, amd-gfx@lists.freedesktop.org, gregkh@linuxfoundation.org,
 alexander.deucher@amd.com, Tomer Tayar <ttayar@habana.ai>, airlied@gmail.com,
 sumit.semwal@linaro.org, christian.koenig@amd.com, leonro@nvidia.com,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 05, 2021 at 04:03:14PM +0300, Oded Gabbay wrote:

> +	rc = sg_alloc_table(*sgt, nents, GFP_KERNEL | __GFP_ZERO);
> +	if (rc)
> +		goto error_free;

If you are not going to include a CPU list then I suggest setting
sg_table->orig_nents == 0

And using only the nents which is the length of the DMA list.

At least it gives some hope that other parts of the system could
detect this.

> +
> +	/* Merge pages and put them into the scatterlist */
> +	cur_page = 0;
> +	for_each_sgtable_sg((*sgt), sg, i) {

for_each_sgtable_sg should never be used when working with
sg_dma_address() type stuff, here and everywhere else. The DMA list
should be iterated using the for_each_sgtable_dma_sg() macro.

> +	/* In case we got a large memory area to export, we need to divide it
> +	 * to smaller areas because each entry in the dmabuf sgt can only
> +	 * describe unsigned int.
> +	 */

Huh? This is forming a SGL, it should follow the SGL rules which means
you have to fragment based on the dma_get_max_seg_size() of the
importer device.

> +	hl_dmabuf->pages = kcalloc(hl_dmabuf->npages, sizeof(*hl_dmabuf->pages),
> +								GFP_KERNEL);
> +	if (!hl_dmabuf->pages) {
> +		rc = -ENOMEM;
> +		goto err_free_dmabuf_wrapper;
> +	}

Why not just create the SGL directly? Is there a reason it needs to
make a page list?

Jason
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
