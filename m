Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF29C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C61610E5BE;
	Tue,  8 Feb 2022 08:27:01 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63CEF10E3B6
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:07:45 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id j2so47774361ybu.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 00:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PXxGXqL0fSEKZMDAAFA60E1Rbs/msz2tQymkFw5ax8o=;
 b=qlzWW2qtvfYAAanbEMYNLuRx8ZSraE6ZerXTO+z8zhvTvhhuYlpIgqjAKGiZyn03oe
 dobQls8uADFSdqKk74wWyKhvtGm+6ci7zMlOM/25PMWhbnesE0+5XQtQJ1DQ4BSmrIVR
 KXs5u2kjzPM5yfRm+Agx/SxngcjD9ixaxLZX1vw+RU3PzkOEaYN8IUkGN+VCPNNtWbRa
 OkYOtxUahGsG7+n6hO78zD3yqAbAhOS+2yz1YaW3MqVv7bTnB7WgJxSZvd7dRu/1CoqZ
 ioyre/8Cv4eirgKtPsl7phMdGqzPgirLv2toaU5HewuA29ykBKN/lcY8q2AtU/epI3VH
 FJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PXxGXqL0fSEKZMDAAFA60E1Rbs/msz2tQymkFw5ax8o=;
 b=jn/2Ho/x71H+lS6LfkOZ39TrSkHs5Oyjsa9blEJhqnGVy7fzop2b/FydhdMpto6OJw
 IHnyR+GtZp/6p0k6DhkdV2s0a0c8OXu9ithWZ71fKTRXT9KWvplULTutHYpNbbAfsS19
 1DymJ8ZimVishQDLam+F1w9BvqsPQBHpjw2ucrjnXiX0/nJx63N+jtZlyG4ZJRBAeUmJ
 VhWlw0ueidCuU2/Jwh7Rc7/wVlvMwRphNO85tKZYgrTgKcA0yIoilOCYdvmc7AcmXD08
 jAr2lvpOP3qy6CvV0o0V5/FBKtZdjW78XkbJOFu1LxTP/C9KvVf30MCoIknwA9/NrkwY
 Teiw==
X-Gm-Message-State: AOAM530ggf2VvTfgKs5gNsv+sPiqcsVTsCXSvDZbCMvVFrC1d4Gu7pHM
 zg+eGs6Z2+1Q/+AK7FyJ03of1FwlPSTlYuAdQF15uw==
X-Google-Smtp-Source: ABdhPJxrFiobqvBhVclJNZluCx9G58Pv+JirZ6BIfPGVufYPFT03Bj1OgbKZjqvNPQBBROocQXaDN+k+XywWU2el4os=
X-Received: by 2002:a25:4742:: with SMTP id u63mr3440116yba.523.1644307664507; 
 Tue, 08 Feb 2022 00:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-3-hch@lst.de>
In-Reply-To: <20220207063249.1833066-3-hch@lst.de>
From: Muchun Song <songmuchun@bytedance.com>
Date: Tue, 8 Feb 2022 16:07:07 +0800
Message-ID: <CAMZfGtWA3M+ck8WduwxyoDiXpjC1kXs=irVZ1m-SMSREJG17Mg@mail.gmail.com>
Subject: Re: [PATCH 2/8] mm: remove the __KERNEL__ guard from <linux/mm.h>
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
> __KERNEL__ ifdefs don't make sense outside of include/uapi/.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
