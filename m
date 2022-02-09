Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD05C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 09:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4448810E68D;
	Wed,  9 Feb 2022 09:21:51 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F07E10E426
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 03:30:22 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id n32so1920767pfv.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 19:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Je4ysSvm0qGToTfluoX75kuGzoNSHI2qP2Y0C0VNAg=;
 b=CACwA3iWs0mIexxr+JBAReAIEm1js+p8Gd1PctwBpcCRlFarncrQq8u4LV6np8g3is
 D/VOuIRXeoPfghb+/9LTlJtNpAvNKgMSy3Wr4lug4rsCM8eyWtwax7omfbUtcsy/9gV0
 7zKe0Yw5vrIzVjXV0RntPZ6HYUDb3Ci9Ac0MxBz7ePn0Cx3ZAESjOlA/plyTn3cK/JDB
 /4GywPgMyr1VKT1Ars0+RfQs5u2gxDhVAMm6XqUo1P+6wobSWI5xZqPyxvBbdotA9rpW
 M0SPWo6TnlLbTZEqquatVpsjK0f4E620XEFwl1wrQ1s/OMsFf6/RTMOBX8yu4cXgNOQf
 8MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Je4ysSvm0qGToTfluoX75kuGzoNSHI2qP2Y0C0VNAg=;
 b=3jpA0k+fJw2xxrGleoctFZwbshruRxo6sIvVNzn1wzFyDFkXxQYQjVAtpqZ8TSF2pj
 NmEbVLsMyrwin3DCKoLc2D/zk94L3sXOGJdcIFwNDU6G8rXqWlD5Ins2/5AMhvzcXl+G
 XmNhHy89yaxdvD+/yLpk6bEfEXumBYj5ZESb8MAse98gGkPIxhnf5Y8dBh8MkqXKCDrc
 BFQuS1pHpT/QNLUxosQ4Z0h5FAT2WKzySHJ2Lcc3vySILGXi20TZv8fyl2X223VYW53u
 3+8Cfalw5ZU2lC9SwRtBz6rtqkddba8XZCHqAHhBAqJXi2uoZL6bTKuIUhgRQp/vf0zC
 cT/w==
X-Gm-Message-State: AOAM531g4HDEZ26A8LVuS17EN3C0LOcCr6acZgKioA76QVhdabF+93YM
 Lr34cweY9477m/8Y2bVdTLhL5YgbSxJnR8YgfcZpng==
X-Google-Smtp-Source: ABdhPJxPkAe7JqNfPN0pMdUWTXV1LFyPzWR+xK9edhPa72Ip0qH/EBHDfJCzGhUn69nUH5cFutBmSs7V8IMhNpn2WjE=
X-Received: by 2002:a62:e907:: with SMTP id j7mr354037pfh.3.1644377421975;
 Tue, 08 Feb 2022 19:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-8-hch@lst.de>
In-Reply-To: <20220207063249.1833066-8-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 8 Feb 2022 19:30:11 -0800
Message-ID: <CAPcyv4h_axDTmkZ35KFfCdzMoOp8V3dc6btYGq6gCj1OmLXM=g@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: remove the extra ZONE_DEVICE struct page refcount
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Feb 2022 09:21:49 +0000
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
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 Ralph Campbell <rcampbell@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Karol Herbst <kherbst@redhat.com>, Linux MM <linux-mm@kvack.org>,
 nouveau@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Feb 6, 2022 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
[..]
> @@ -500,28 +482,27 @@ void free_devmap_managed_page(struct page *page)
>          */
>         page->mapping = NULL;
>         page->pgmap->ops->page_free(page);
> +
> +       /*
> +        * Reset the page count to 1 to prepare for handing out the page again.
> +        */
> +       set_page_count(page, 1);

Interesting. I had expected that to really fix the refcount problem
that fs/dax.c would need to start taking real page references as pages
were added to a mapping, just like page cache.

This looks ok to me, and passes my tests. So given I'm still working
my way back to fixing the references properly I'm ok for this hack to
replace the more broken hack that is there presently.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
