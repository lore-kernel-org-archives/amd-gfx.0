Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E435BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 14:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D54F10E8E6;
	Thu, 10 Feb 2022 14:11:37 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B53610E7B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 09:40:11 +0000 (UTC)
Received: by mail-yb1-xb29.google.com with SMTP id p19so13671130ybc.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Feb 2022 01:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vwSyjkWA8Xtx6McE/937H/83En/EAsN4/n12OaGn97U=;
 b=Q9U5MhFM50SJ6zKg3p/BHPAbW/1PqWiV8IwLRh7eYuvqYsefXz7JVtkApiN0D5tJs9
 NjgtZ08Kif7nIin7P9Lj3k6IR7GOTseT9s5laCSNNmTWHD2uCXfrqGfuutVuti7FabYq
 BBBAb4MnvkLH4UJThCTrI8+/mOnZaltJr+bpG6t9FkMSJZxm2G82RI22ShxjcihlxEsi
 Y82w37OnLpB5Xi9WU56u6QA7+3qLoNq0E7XxjqXpD9HrhneWbPs+sNufIntIIK3bmpgw
 cO6+9m8+iutxaFYcQMGptKVxtMwZN8MAWIOLV4hGp2W+29wbPx10LCsVwxL/brPe2+Mu
 8Ffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vwSyjkWA8Xtx6McE/937H/83En/EAsN4/n12OaGn97U=;
 b=abyVzPYa7a5KWiLG0EwIl8uKcXMLCF48UFcgQetHmvJKjfD1ocE6qqgfmnmbWU5uFU
 2ym0GPpyZAClKqIJ7vJertoOvX2Yt7Nf/Y5BcKPeFvpf33zUBDXv42qDybwsJDLdc3XK
 Tn16csSZ+xzHhbzF7RYt0YDUV9o5N51PPYOSp8j01QvHBPSdgUvfM7swHKlD3vuAxJfN
 AxFC293lQM9JqPlcCqCAPYBpGsL/N0s10Ec2USvVTJ0tDcGEDmdJ8vjYKa27TPnli/vu
 bZU2jUz7ga+mRwEqVHyxb/ehvE4TVGkbseRCa9CDdmb+c4KYfsMtez4Cwi084vAsut8r
 mXOQ==
X-Gm-Message-State: AOAM530ngN76F+nZZdd9CrC+GnvtkKqGFZnlRFR7fxlDnrGzSA/wBM3Y
 L02+ktkDR7j1/EVe3sAikjD0HAfMhMd/EMqp9KD4vg==
X-Google-Smtp-Source: ABdhPJyMOovS5IpsBIbmJvgp0LJOskYVPag8axtaKArSDLNMC4EYiKcUxfRUU3qBQ8ccmcQ6MqVRs4tbRTDCogGg4e4=
X-Received: by 2002:a25:4742:: with SMTP id u63mr6032141yba.523.1644486011092; 
 Thu, 10 Feb 2022 01:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20220210072828.2930359-1-hch@lst.de>
 <20220210072828.2930359-4-hch@lst.de>
In-Reply-To: <20220210072828.2930359-4-hch@lst.de>
From: Muchun Song <songmuchun@bytedance.com>
Date: Thu, 10 Feb 2022 17:39:34 +0800
Message-ID: <CAMZfGtWb9a8gN7DjaJngYi4aJLVHL74eKnXmctXC27QyarHsDQ@mail.gmail.com>
Subject: Re: [PATCH 03/27] mm: remove pointless includes from <linux/hmm.h>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 10 Feb 2022 14:11:33 +0000
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
 Jason Gunthorpe <jgg@nvidia.com>, Alex Deucher <alexander.deucher@amd.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Logan Gunthorpe <logang@deltatee.com>, Dan Williams <dan.j.williams@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 10, 2022 at 3:28 PM Christoph Hellwig <hch@lst.de> wrote:
>
> hmm.h pulls in the world for no good reason at all.  Remove the
> includes and push a few ones into the users instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
