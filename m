Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9DFC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 18:44:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C933D10F9C4;
	Mon,  7 Feb 2022 18:44:18 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922A610E3A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 18:08:12 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id w20so2490309plq.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Feb 2022 10:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nxHF7bigQnfZfNGCQpq6EtXcG8/j6GHHAEIHGHy2fyU=;
 b=W2DDXQJis+1qeQfXY6E/rxnSkSH+QKQccGw4pZqh3cKQQ7Ll28D21ZTANWBpjdTXkB
 +oBg0dRp7zXiF2K9fvNxjOnqLQ0NU4tSCX/uoDUgYXiPcW3lrnrEZ8WrBiPWSBgY4/tx
 9wQBgc3U+/16XX6zr1IGWZp+OTMhC+7AmHWl4HQOtmJdf1TDvqV9PwZseP44xIAvTKTJ
 lY9+rCsDVlGtJn+K+JfRbJQJUoxEyKL8bHmbimQ1ptdoTfcpwUfxMxs8lIMS2tr1n+Up
 0WNvMspuYRbKnLIowW6FPQwT66Mrqlup7UTEmGoUmJqEmINAArubT4xrd5hjAe0QVo24
 gEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nxHF7bigQnfZfNGCQpq6EtXcG8/j6GHHAEIHGHy2fyU=;
 b=o2bmUVocrcKZPtAfQXXReuT/iNoH746MyP8ZjKrHahPvKBdaAJTh5+1gJMxVRMLjjn
 KvHsKto5gqv7ePbO2LL2D85RV8+ZOl39yDu/U5MGVpsQurCT0bldPD6rdETqUWDZgGPX
 e+S03kgr8LwpkkK46PcHIokNU5HYm6He6d/oEAt1IByUq585LxVpRTSxw5TVZROWaknL
 cgRIBB/uYLSl8+FW7EJY+TeKA3TjhNyAjkiLWFK4RS+0iT+rKN54Yu3ffNagvGHhrKha
 iYe0lBbv9lQz9R+1KsYKh2nd3DWNp041aInWGSxPF0tt+1KTNu10T+vRelzvICfpGUIH
 FhYQ==
X-Gm-Message-State: AOAM530ZZtAbK8JSxFGoDfIuxE3DAi8+ex2qoop9IQY93lZbO+ttEEAj
 L/7AR4TP5bzjjW7F3ziREECXdSLkAV6OsLpf/GrIHQ==
X-Google-Smtp-Source: ABdhPJxbjfLp1vymzfVN/rUSu7NFfwM27TjFOxcEJErT+R82ivD+XXC3ZWylDTpvE/Ebzm6hUwz4bOsdTAqXcC6BA2A=
X-Received: by 2002:a17:902:ccce:: with SMTP id
 z14mr815477ple.34.1644257292200; 
 Mon, 07 Feb 2022 10:08:12 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-2-hch@lst.de>
In-Reply-To: <20220207063249.1833066-2-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 7 Feb 2022 10:08:01 -0800
Message-ID: <CAPcyv4iKLXJftFL+jdAXFXt6-fjwSdK9D2un9PywfXDT0W7HzQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: remove a pointless CONFIG_ZONE_DEVICE check in
 memremap_pages
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 07 Feb 2022 18:44:17 +0000
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
> memremap.c is only built when CONFIG_ZONE_DEVICE is set, so remove
> the superflous extra check.

Looks good to me.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
