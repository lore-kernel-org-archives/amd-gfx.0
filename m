Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CEFC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 13:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADE18D0D4;
	Mon, 22 Aug 2022 13:31:49 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60DA8D0DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 13:31:41 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id u14so12198269oie.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=6WVjOrRJCECWMxjcl8nSD1ItRBPOEa+Itaj/XCvb2go=;
 b=oAGzPeSTZ0vxyJxjypstEFq2wlDSFbqy4W20nT26f4IonPW2btsHWwoI6TFovQKtPH
 OVt0yKLAzY8ARGBubtDDx784QNp0bnfaQ5A7omPby/nVq0RAYC4O2m6qo+sNnDzyV/EF
 ZbMR5HZWcC5IxJ/NHIOlo55BXThBNYjTLXxUuDXCLVm2KCd2vmcIML7uF2CuwVqvMpx5
 PGWBdLdq95Y+GINSqToObZG5MY9yQv9MidDw4sH88GN1vK1y8Mr1pH+EyASoC6hGi6fm
 CkGXP7qMVDbz+MA5+Dt2pVfOiYYxaA6k3Mi6ex+jHIBZeCR9E5Jl7AHHkVhXYpNpVNGB
 nXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=6WVjOrRJCECWMxjcl8nSD1ItRBPOEa+Itaj/XCvb2go=;
 b=mRgD92cupCHCkS9bBcTWb5GyO3MBxkrtvjwdYddq+KbhRdYTwjQizaPU0fQDdIqTev
 3IE7qgCYnhzXxyJQHjvmNRfFcqFeyzq5ykg8p8vu+Bm9q3nqkvAyBrx19EOEXM7/SxqD
 APDmMB3Yk3eMpnWsL8B7ZnaxJF/t2DIAJjtG/yVZFMF3Rd37CiOsL0ZFsmZNNcJxEvmt
 y9W+NEZIN3EimXE4k1FYN9pNxO0P+YmRq1txBl76dy+q1fhJ+lAcNC0wrnV+3/fUyUPx
 cPnUZYJDkhw9oWn3l9m+C2o9ffW+Q688qi4121eL2JZ93L0Kf4o7iWidEQXjyavwyOrE
 D7Kg==
X-Gm-Message-State: ACgBeo27lnU9k4ykPtY+MMoIpmh5vqv4iAfCi/WxfROS5Tyen/5P0UJ6
 dXPTAYMXokiASMdeILaiip+To7bZqXsBf4SA+SxZu0Ar
X-Google-Smtp-Source: AA6agR6Cwk55gcuoQgIgnKhgffJRYAliThwIfgR7aCZCIUD7OUGPbbQunhOd6bmeVuKzHCAom2dWtNzACZFk33vO/JA=
X-Received: by 2002:a05:6808:ecb:b0:33a:3b54:37f9 with SMTP id
 q11-20020a0568080ecb00b0033a3b5437f9mr8913358oiv.33.1661175101159; Mon, 22
 Aug 2022 06:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220819210112.7924-1-rdunlap@infradead.org>
 <87o7wdkkt4.fsf@mpe.ellerman.id.au>
 <YwNovfuf3pDBh2Zk@infradead.org>
In-Reply-To: <YwNovfuf3pDBh2Zk@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Aug 2022 09:31:30 -0400
Message-ID: <CADnq5_NOedr2TGH0W9wVAPkrJyyJ_+eAkEUORbYvShY4UW90sw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: export cpu_smallcore_map for modules
To: Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Randy Dunlap <rdunlap@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Nicholas Piggin <npiggin@gmail.com>, Tejun Heo <tj@kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Aug 22, 2022 at 9:16 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Aug 22, 2022 at 01:40:23PM +1000, Michael Ellerman wrote:
> > Randy Dunlap <rdunlap@infradead.org> writes:
> > > drivers/gpu/drm/amd/amdkfd/kfd_device.c calls cpu_smt_mask().
> > > This is an inline function on powerpc which references
> > > cpu_smallcore_map.
> > >
> > > Fixes: 425752c63b6f ("powerpc: Detect the presence of big-cores via "ibm, thread-groups"")
> > > Fixes: 7bc913085765 ("drm/amdkfd: Try to schedule bottom half on same core")
> >
> > That 2nd commit is not in mainline, only linux-next.
> >
> > I don't mind merging this fix preemptively, but is that SHA stable?
>
> I really do not think this has any business being exported at all.
>
> kfd_queue_work is not something that should be done in a driver.
> Something like this belongs into the workqueue core, not in an
> underdocumented helper in a random driver.
>
> Drm guys:  once again, please please work with the maintainers instead
> of just making up random stuff in the drivers.

Discussions are already ongoing with the workqueue folks.  I'll drop
this for now.

Alex
