Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2C4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 19:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AA710E3BF;
	Mon,  7 Feb 2022 19:16:10 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8473C10F857
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 19:07:03 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id n32so14609423pfv.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+WVqg4iM1IK5woHe616yKoTPDV85yaqed+lmC/0zx4Q=;
 b=E8Yv+tJ27QtdnqCiahy1ynDTxSrIHFQS9v3T6SGxOtbvrS4oJdOaAbBOu5WkKuOBfd
 YZVQDjXpyCcHf5TePEiE9WLubJVn7pkXJNntqfcUu0FB+cpVUKi2U/fVQ/r2P4FuKOGP
 rrsKex566q7w8weRBoU0ZAbtyAsexA2NArqSSGJ8aSE3asKbO/kySJdCGSVU84OEGUiB
 QCLOFQgtfcBKBXnXRpXprEE7iAtFckobPiWULixyKadweXpHSIl4fOM/cfTnhyD31lEn
 X5EcS76XqYpJKN3mK9thEa6gK63RHYW8pEdrhtUg2qPw6l/cPnln0K7VaxQOTiViReVV
 h7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+WVqg4iM1IK5woHe616yKoTPDV85yaqed+lmC/0zx4Q=;
 b=3LzEblYNoCRMWzJuMeHubU21wyLqweBvD0n/mM1KkfKjC7+1iNtxHKAYd7WexCKHsR
 d00kKG5c8YY9/wyIXxbdDcXKpeIdR1TXgX7B+rOyZ+AFaoQ7ji53dUkFz5B88sMT9nib
 hb6ozBR+q+pTv6hxA2WQe2s1yw1+atFGUC/JaacUkyZadFpEsNt22AnY1NFqYTeYKnol
 dhH9ulAuB1mYMEm6VyljpMuk0evOpWjRF7u01QFC34KkYtnMvsLbpYG5VdJ5Sq22SQ8F
 WlXQigl0uNE8OvHif86Bb6qDNEn402ihZdPM/P28iDi3aw1kUGTVXovPNlmPPkSRULEA
 qRLQ==
X-Gm-Message-State: AOAM5332H65OIW76THLt05/2C3FAwSxhZXpZEwB33e9gL4dCB+GyQWPh
 ROc0M8k9sxNLQemEcYoBOdxYiOej2Z8ofyQzpUZR+Q==
X-Google-Smtp-Source: ABdhPJx4gFwHpx6eXlK2M23aHGpthiH4fAIYOpnEcI58LRfZznkCnIjyKeDQJsC3Q3CmCC8lC+fdRuCFIdo+hfnPs1A=
X-Received: by 2002:a62:784b:: with SMTP id t72mr939106pfc.86.1644260822995;
 Mon, 07 Feb 2022 11:07:02 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-5-hch@lst.de>
In-Reply-To: <20220207063249.1833066-5-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Feb 2022 11:06:52 -0800
Message-ID: <CAPcyv4ipZUeCjf5teFQuJX5DEs7ViGHW_PKKfoJEK8chjJTZig@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm: move free_devmap_managed_page to memremap.c
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 07 Feb 2022 19:16:09 +0000
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
> free_devmap_managed_page has nothing to do with the code in swap.c,
> move it to live with the rest of the code for devmap handling.
>

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
