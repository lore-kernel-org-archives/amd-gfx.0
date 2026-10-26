Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E967E606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ww00hyP4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B6110EC96;
	Mon, 26 Oct 2026 08:43:36 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6CA10EC15
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 08:03:27 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1100605f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 01:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793001806; x=1793606606; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oue2gY3N148Z5QjebnGzECChsQECIfu8P/sF36ovlgA=;
 b=Ww00hyP4q6cCB020hECdbIGhq3pKARobVYkwcfxjinSX3RPa59vG6sCopEVWoqEG2g
 dpbd49Y+IeqwYml43JQbYPBCxzQGxAmo+6s0BxNCBWS+rhWMzYQnAdTTQjPVTkFUn0F/
 Lozka5lzT3hwbc0PxmoyMuGZxlHaZMUyBCCzOCaKU+k5bd6YEaztmhmeu9nqz2ZrO8Fr
 gwJ2lvvHnNLP/wHGUGvs3lLMQ7QnJYtv+2gqRti1C54/bq+fTeb0FrM5a9ZH82Avy8Sm
 VebkDUzaZnusp8NEJsQvVNbWzAm7nJWuVZQG79RfWA0NZdMeHUDQsJ6XyepoXJwzazBl
 pq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793001806; x=1793606606;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oue2gY3N148Z5QjebnGzECChsQECIfu8P/sF36ovlgA=;
 b=PpXm+gMnC4+yr32KJDWW+b6pPurgNMlmA2UcN7aKMnnJAS6+3gggGSGHZl58qTeMrj
 IPI/04eijkTWPYERt4hfUgP56oW7p6tUG6NIL07mH3y4n41JiOB8cLuOP93RipZJYpM0
 WKJQmVYxnfpSCWEmIv4+ACsyvvbZT4GEuA6sB80cC8oNJ2cb6KItL63nEwfQ5L3tvkrg
 Z3Hz1E2wdfa3qZNIG1xlG1TtZR1cyu1Ohv2CJdHjONtYyX40QgYlsJd6iesKLbY8yG7S
 jWlF0BcHdzBL4Rb8ubah9daDIfEAlla0u59ip2NWwZmGvoeK1epNw0ZxLPwB1qHUP8w+
 bBxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7SjCo/6wHCqygV+MK3HA5xXxsIDsROIHwM4iTBZTYU+ARpEIy3t2yztTgVJ++atow0iYCCzHw@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLrkfJw/u5YBld6IZ+HM13K3aFzC/BQcIXjwXxg1g6sF4Z/X/St
 fP6ZAS9VCLyd9As1ZVraqTHaW5KLXUTXFGIFdI9ny6G9gqJSRbRSVWif
X-Gm-Gg: AYBFou0abXcFkf/w2M0DW53v/O1FswxFI9rMz0wP0PIBX2rRh/WVXnnJFy1DRoIvZcY
 oRcklRhxmnfjthR65+7VeMz0sk88C2t7mGCnsv8+H5BbfGmU7nxVAJGPxYIViBl/TfHdRthetkb
 IJRV8wid2cYwhvPmMqDa4irhnP8xjZdHd4gTg3i/wQGMxk6VCmdt6HgbE7OOXVbkxOp+dLmg8DE
 4qFEKh7rWtaKMM9/UuWL9vJ+c/jTVuYZQbMfGY5v1pp5KZty0t85bV74jr7NWb8SZcBYM6Zj3gF
 zFCD9ZMUf3bg+tsm0PNkYTwqNkGh7OC0p2HAhL1Vl8sGkdLp8oVJR9piGwAe8yVKwnivI3Aa2QM
 FsiwRjCb6U0np07Y/x9q0ggg728fB7Tcd8wB5bcnKaDJDHagp2z2XEQgBnU8rno4uk5TReGvTLs
 1vKAvvuCK2L2huhne02c4K5tQHC1wVX04z65ph9CzQGoYd7l9OrJi187dSff/uWSGrBxnmtws+8
 4iLU9SFcUBZVj9O21+tVYRX5S/sMgzYRfwaPTKgrxKmkSkQ7ZZSctuEgs6OGIDXAqBdisDFXPUO
 /hvnDLA/5Ss4GOeVnXxXTo2OJzI5ryiZgr56ifE46F70j3OrD/3sfb85IDNK0mZ2JISvgwA7W9Z
 cCUYPvo2xDmLV6ir6tRaZs1881b2M+OFTdL7OSZ3n0mgC/71W7DBgtEYJUIRHNQ==
X-Received: by 2002:a05:600c:3f12:b0:4a4:7a8d:c436 with SMTP id
 5b1f17b1804b1-4a47a8dc6e6mr85645335e9.11.1793001805868; 
 Mon, 26 Oct 2026 01:03:25 -0700 (PDT)
Received: from unknown748F3CBA5068
 (dynamic-2a02-3100-b1a4-1201-5c78-89f4-99d8-70d7.310.pool.telefonica.de.
 [2a02:3100:b1a4:1201:5c78:89f4:99d8:70d7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm473163315e9.1.2026.10.26.01.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 01:03:25 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:03:22 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, christian.koenig@amd.com, 
 sumit.semwal@linaro.org, jgg@nvidia.com, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Leon Romanovsky <leonro@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>, zhipingz@meta.com, 
 treding@nvidia.com, jhubbard@nvidia.com
Subject: Re: [PATCH 05/26] dma-buf: Let the exporter select mapping type at
 pin/map
Message-ID: <at8IQZ34wkHQ_5PL@gmail.com>
References: <20261026053623.202642-1-apopple@nvidia.com>
 <20261026053623.202642-6-apopple@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026053623.202642-6-apopple@nvidia.com>
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 04:35:56PM +0100, Alistair Popple wrote:
> +struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
> +					enum dma_data_direction direction)
> +{
> +	struct sg_table *sg_table;
> +	int ret;
> +
> +	might_sleep();
> +
> +	if (WARN_ON(!attach || !attach->dmabuf))
> +		return ERR_PTR(-EINVAL);
> +
> +	dma_resv_assert_held(attach->dmabuf->resv);
> +
> +	ret = dma_buf_mapping_select(attach);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	sg_table = __dma_buf_sgt_map_attachment(attach, direction);
> +	if (IS_ERR(sg_table))
> +		/* Nothing was established, so the choice may be made afresh */
> +		attach->selected = false;
> +
> +	return sg_table;
> +}

The map-failure report from Sashiko [1] reproduces with a KUnit test
against the full series:

  pin selects B -> map returns -EIO -> selected is cleared
                -> retry selects A, with the original pin still held

The exporter pin count stays at 1. Preserving selected when it was true
on entry makes the test pass. Patch 7 needs the same fix.

Could dma_buf_mapping_select() report whether it made a new selection?
Then the error path could undo only that choice, without dropping one
established by an earlier pin or map.

On the Sashiko failed-pin report:
("Because the attachment is not pinned, the exporter may migrate the
buffer elsewhere without invalidating it")

I don't think this follows from the documented contract.
select_mapping() requires the exporter to keep the recorded type
servable and invalidate before an incompatible move. That obligation
still applies if ops->pin() fails.

Is retaining the selection after a failed pin intentional? If so, this
can be added as a test documenting that alongside the map-failure
regression test.

Thanks,
Karl
