Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D42C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 08:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63214891B3;
	Tue,  8 Feb 2022 08:26:47 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAFA910E284
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 08:07:07 +0000 (UTC)
Received: by mail-yb1-xb34.google.com with SMTP id 192so21375669ybd.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 00:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lrJ/uUGCKgoKFH52TnhTE0iJcbWnNbC2//ZX4wls2Dw=;
 b=kNP/DVt8Qf+7bUY3UT5ZfqP8u/Zt0jSOyRJstDT02WFgtxz0uQpIo4XqdFFTnYfT/M
 F2Df9FQ1s1DpZs0sKfObwDOAAXfKQ7/T2yeAjlKR3i/reWmzZVjWKP3xdxDfOd3jfA7b
 tz5+cjBNS6/V6VXodt+MN/KM9Uxi0esuP7iu1e3jkfmQt4QdsMTpVKtJq5SLYiKaO6wV
 GdLTObr64l6FVPZjPzvdKBJR2Rjj+n9hO45a68l8DCZafC6+U2M4uJdIA6MbLvDKJRJZ
 DYHtfhyDzmb+GdSk9jY5Magnd6SN2eMgQm2n0M1xh1E5HMRa0EDjVN/rUBMFIXJjqzfO
 gYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lrJ/uUGCKgoKFH52TnhTE0iJcbWnNbC2//ZX4wls2Dw=;
 b=5504/0qXx81AJWy7Tu8vQnFob0Wn5FdS30N8PSnTM2q+9gttaLq+7KONhriBY51DEd
 pqH20gDPcXcxO0isBiDU0HPJY5Uoc6NvTZJRDbHXxK4Rfy8Q6vfVWyJNZEDJw7AUaqUL
 sjg3474L19dIPKf9YzS4AhKKZpNKD+XSq8zhU2DE/mbVdFVF5eHnIyBmICz5geBs3dk/
 05NsFih27fM/Pjf6xHYYWc17vjXdizxLT0lw3+Msvn0NVxOgjnT9rfGYAqKRrm7ep7lv
 UjL5LG6RmJC5lm3vuRITcsM3VT2+NYDMO+EdVEOfh5BxV8FCoMKt3rpRFbXjh6ZLhzhK
 aLAQ==
X-Gm-Message-State: AOAM533rx5rtIbj/WP0Qvvo290chuJ6OqdNCkqDDLoIpS/XK14mO8/vo
 Og45+J+6lbZcpfRbxKrgZ7bPmuhevJKj3aWyc5tv4w==
X-Google-Smtp-Source: ABdhPJyc0mkGJILuXoiCncxc7dUnInOYzU71tTwuAgOjc/Gz6ioJ07N3R1Qa59huN3y/0lYz2j4xsFCGHPxb7jwVlxY=
X-Received: by 2002:a25:e406:: with SMTP id b6mr3405161ybh.703.1644307626738; 
 Tue, 08 Feb 2022 00:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-2-hch@lst.de>
In-Reply-To: <20220207063249.1833066-2-hch@lst.de>
From: Muchun Song <songmuchun@bytedance.com>
Date: Tue, 8 Feb 2022 16:06:30 +0800
Message-ID: <CAMZfGtUfqoaJ7L7rLP2Vdfy_nvr30qppRX-RfTFUh8TeO3ZznA@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: remove a pointless CONFIG_ZONE_DEVICE check in
 memremap_pages
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

On Mon, Feb 7, 2022 at 2:36 PM Christoph Hellwig <hch@lst.de> wrote:
>
> memremap.c is only built when CONFIG_ZONE_DEVICE is set, so remove
> the superflous extra check.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
