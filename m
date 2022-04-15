Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164D8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 05:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC99D10E704;
	Fri, 15 Apr 2022 05:38:35 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA0010E704
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 05:38:34 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id 141so6075210qkf.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 22:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S0JX2UJMXFJ7vWd7QOLm7QlLBIehu8n8ur6LpthHyuk=;
 b=PAWHnAqPsyCcG1qlrEVvUy3aN7mTVcpIwT8zBzAtZWADIgCqfMCsSmcpwkVfPFfbTP
 K4Wil+4b/vHH0BC5E4iKylZK/hGNX/SysArA0xP1rUCpnUK4F8khXcoe3x4x/FDjg3Ol
 fiTRMZEqPrlBPkmK186UYCp8oP9Y2k1mwwD9CfFU51neTTW8dYRWb9sJxYCLJ9EEPfQM
 eThs/azPCji4DbDre81oMTMsGnJ8hpNGuH0pL7XLr4j8ZHAUbGHxBqedFqoF0GUBeR1f
 mF5gq60UAyKLXxZ7PikygQv6v0YEJcFzANcqELnGDieirYX4K/eHDqur/iXL3giBcVzX
 awfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S0JX2UJMXFJ7vWd7QOLm7QlLBIehu8n8ur6LpthHyuk=;
 b=KH1P4Ez8bywKjmEKUkojfcXD/TcF7IIwL/bvSkgIpar+bxoi4UEqUEwX6OE1ud90VB
 BGG0ahkqvlA8MwS+bQErykFKNH0whWLq3d7fGfeBUy2Dddq1ok1Hs7j+9hpU8+IoHlSX
 1YN2tBo9btuXaF7gc0hTqqUDWf4LKqAI72/eWQoKzXOn68Ftp1PKf5cTxseSenC8Hnlj
 yGNO4AC+g64eJHsti+vd13oFCFdvfTAKxL5e8yrtF6e2F3QHWU56m7XqyYpN98zdizlQ
 IqROxiFfyu2KCfs/ZyOb32b9FDSFcfHl97Nz9Y9DM+o2Eq271u91gfhomDXe/lQyYkQF
 8WYA==
X-Gm-Message-State: AOAM532gnr2jlZMglaGQKBVStccCkUU2/LO1bBhYSBUSIx+jYl1WVKKy
 HlmZcgBnS0TsQFXyZ0z65/05fKt0qJjuERgiYEY=
X-Google-Smtp-Source: ABdhPJzhuudtkv6ny1zJHXnJ9IMTpvX7zf9wzg2zNTjJtCoOG/WGrnaXgSmsW6Oi3Nib0+NZePC7EHE946v0pbbduSk=
X-Received: by 2002:a05:620a:4491:b0:67d:9929:ddb6 with SMTP id
 x17-20020a05620a449100b0067d9929ddb6mr4425320qkp.47.1650001113554; Thu, 14
 Apr 2022 22:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
 <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
 <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
In-Reply-To: <4d0cbb79-4955-a3ed-4aa2-7f6cdaa00481@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 15 Apr 2022 10:38:22 +0500
Message-ID: <CABXGCsP19VFRgTx5yGn68iCK3NxPxi_b9MTq=AmHtFPv9xR5sA@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: thomas.hellstrom@linux.intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Ken.Xue@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Apr 9, 2022 at 7:27 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That's unfortunately not the end of the story.
>
> This is fixing your problem, but reintroducing the original problem that
> we call the syncobj with a lock held which can crash badly as well.
>
> Going to take a closer look on Monday. I hope you can test a few more
> patches to help narrow down what's actually going wrong here.
>
> Thanks,
> Christian.
>

Hi Christian.
I'm sorry to trouble you.
Have you forgotten about this issue?

--=20
Best Regards,
Mike Gavrilov.
