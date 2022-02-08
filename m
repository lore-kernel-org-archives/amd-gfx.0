Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E36BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 09:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE85310E688;
	Wed,  9 Feb 2022 09:21:50 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6081910E36B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 23:53:26 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id e28so1219325pfj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Feb 2022 15:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9yllLJXxvJNbb7TJ6F8GXcTe3gXNYnW6vmBXP6xHdmQ=;
 b=1TP2oV0hvpTVvUc38sU25Nq8P8dLloqnVrR1dLnL0k00RIz6cxvWF4JovZ1JHdh+Iq
 QjJ5AHaidFx9YmqNTrZ5h5qyJPKM/tziAB9DhO4YFzjPd5bpNTRb+YsjUwlfA7jtVsFK
 U7OdrJqAvGZ07hdSarMyxYyjKgkfa4xWh2cbsWw1St7pAb9nNM89cLwW6fNieqLKy8A0
 lEy6S237O1zyS6B6nOobWB1RoW/2FsR/vn8FET1ptCNsh08iwgcstMONTlv3sghEwQq4
 uOxijQbfhnxc35FRPR6EYrfjLYHOlXzLa9Vs6xBYs94IsyLrdPrgdUt8qrZhQDjGtN/K
 zJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9yllLJXxvJNbb7TJ6F8GXcTe3gXNYnW6vmBXP6xHdmQ=;
 b=r5W/XBrFKfsJdUfazj42y4a3vZeyQ2TbyV1TTgVdvQe/FfVMIbNqc5vPJuC0gKi6Oa
 s4FeigvA7gN+i5i7nxCCHeXN8BK6i2+47w9R/lAmm5diDDNEzKhTknTbDsiJepMP9OxP
 O58UiyczYfVgE7NVCKtn/vwyZSESUHK9pJT4nEuE/ChYElZY9GX9UCHhFziLnjzMgHe+
 WIFEsMrCCLDSK3dbiVraEzA3BvjfrsPE4qjtJJcdznGdzbBFmvhbyexnuN2WOmaOBmpO
 wn6IHoK92Aecr2v8vgsMoVd4i0hMMpVL+FjdqbfLoeknwY89oKi0MG+gEqIUhMydCtvk
 GXXA==
X-Gm-Message-State: AOAM530A+C9Xa4s0ARrkWFTLX5owZqKQnl7TbpO0+NjI2foicVXAq6po
 ZQizojbulztGHLW5A3AfTtK5aPHeRY+pyVBxmuWskA==
X-Google-Smtp-Source: ABdhPJxeYY0PWIjCV0oL3qSXzPE/CqXZVnxQ/6hAd62TUxvblfYAlcQYEDEiHEyZHUJKW9dSv16xGL4Nt/VbJK9Vxe0=
X-Received: by 2002:a63:8849:: with SMTP id l70mr2640980pgd.437.1644364405842; 
 Tue, 08 Feb 2022 15:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20220207063249.1833066-1-hch@lst.de>
 <20220207063249.1833066-7-hch@lst.de>
 <CAPcyv4iYfnJN+5=0Gzw8gKpNCG3PJS1MEZxxoPwuojhU6XHNRA@mail.gmail.com>
In-Reply-To: <CAPcyv4iYfnJN+5=0Gzw8gKpNCG3PJS1MEZxxoPwuojhU6XHNRA@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 8 Feb 2022 15:53:14 -0800
Message-ID: <CAPcyv4jfNa2BBuE7E0+8LO5VT9APS1eF3c4Rw99oKY6y+1re9w@mail.gmail.com>
Subject: Re: [PATCH 6/8] mm: don't include <linux/memremap.h> in <linux/mm.h>
To: Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 7, 2022 at 3:49 PM Dan Williams <dan.j.williams@intel.com> wrot=
e:
>
> On Sun, Feb 6, 2022 at 10:33 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Move the check for the actual pgmap types that need the free at refcoun=
t
> > one behavior into the out of line helper, and thus avoid the need to
> > pull memremap.h into mm.h.
>
> Looks good to me assuming the compile bots agree.
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Yeah, same as Logan:

mm/memcontrol.c: In function =E2=80=98get_mctgt_type=E2=80=99:
mm/memcontrol.c:5724:29: error: implicit declaration of function
=E2=80=98is_device_private_page=E2=80=99; did you mean
=E2=80=98is_device_private_entry=E2=80=99? [-Werror=3Dimplicit-function-dec=
laration]
 5724 |                         if (is_device_private_page(page))
      |                             ^~~~~~~~~~~~~~~~~~~~~~
      |                             is_device_private_entry

...needs:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d1e97a54ae53..0ac7515c85f9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -62,6 +62,7 @@
 #include <linux/tracehook.h>
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
+#include <linux/memremap.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
