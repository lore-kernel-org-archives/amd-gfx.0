Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61174C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:26:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB90D10E541;
	Tue,  8 Feb 2022 08:26:46 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2512210E162
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 23:42:51 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id e6so15750119pfc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xL7zYBxlDA9OyfIUt1+hVo3jnzbaDpzhjP+X9npLjjg=;
 b=wphYccQt9nxerxeU/p5xPEp3OdfAMZRtra+QtigCBGV2rEpNVW9+U6vtvsejhTgn8e
 AjHdHHleGcguuyudfB/EYL8nXm+kpV8ZcSykDngC+byWUyRxqjSZ/RPjTH8AXc+RnLns
 uIgVupROuzl/7/rcKGowF45+b0zBguco1bdtkEO3QuTU6AEph9xDvvOseyxx2hOke+gU
 uNJF3+A19rkf9glt328qDrxjnlD9a+5MH5956bLQ7wt6C83PtpfdJpKPQIdDraMVj14L
 rYSrK3ggYTWNdNsRn2y7f5gnAE9dOOC2PJVNruXRQWVHXWccOP1/uFHHzbWsGMDwZaME
 cPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xL7zYBxlDA9OyfIUt1+hVo3jnzbaDpzhjP+X9npLjjg=;
 b=0PeOAbU3OjR9zNKxlg6cA/aGEo3RB2JV0nsg4lLsFkb5fparw5PXbiaj9FNQwGY3cA
 L2ManIGmdf1Em48egswgUoujD9cYSV0jJi4t1elV1iwDS4dhapN2+qCWXXL3FXE3dyNQ
 8sSnL2s5rH2nSb641iuXeIxE5yWAqJLGJwheJQKqO3HHl4leZbOF8n0lZiVpPq8LRKmH
 BTFjyLXzuZLUW6sWaOuGuJZ1bTWjOvD8S8qQlj1/N2AlJJekKAVnkYQDnjIywIjRpVP7
 rOxT97dJ4EGxslCOZ2d+jxdIF7DrZJrWWMo0VHdkPYvD5LRdPtZpVsHZsEK5X9eA8491
 hbNA==
X-Gm-Message-State: AOAM533ZSQQvGteozE4ExkdUpMYapdcSwKqDccwZbglNr/sy9QDUm7pb
 4QYY0v8TQDUNfibyCRWZJb9yKV9TrQ/owwSX5agt3w==
X-Google-Smtp-Source: ABdhPJwrqWzltx/fzSQ9DuX2BTfk2qmQ+rOek9DuscJqYjd5cc23devekMbaCYKV7qKyZJb3bcu/cjHgnw2J/KhyG60=
X-Received: by 2002:a65:484b:: with SMTP id i11mr1385516pgs.40.1644277370737; 
 Mon, 07 Feb 2022 15:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-6-hch@lst.de>
In-Reply-To: <20220207063249.1833066-6-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Feb 2022 15:42:39 -0800
Message-ID: <CAPcyv4iP=+jtVgdnuZjR3b-jM27zH5uk167HM=wz+=PBfvA49Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] mm: simplify freeing of devmap managed pages
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
>
> Make put_devmap_managed_page return if it took charge of the page
> or not and remove the separate page_is_devmap_managed helper.

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
