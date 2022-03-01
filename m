Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D53C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 20:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C6C10E12A;
	Tue,  1 Mar 2022 20:51:59 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0FF10E155
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 20:15:05 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id u7so23362490ljk.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4eHzcr1YBGh9o3F4BfOGRvjDUMT5g6q2aQ+3yXHWlOo=;
 b=IZ7/AMI7eJ+ZC/a6fwyXrw1yeswUH52MRpfmJL+44Eql30HG9WzC+yjvRBlCihk6qS
 EvBYRMpstobbwMQtFKPVT7whOd7g6EVNZ9/wh7HN9tT37SQk/kV5yveCnI1WKJxZgJfl
 u5hnXn2wSwbpo9fmHyh7tnjuQRET8kflkToPHzIjsE09X8R0kVDj2vdGuFiwf8ERMe6P
 ZUYFx2H+eXSISc3wqYR+rj1jGJiYrqhXhAk2plKyJAwvUaqs44FoSzMAFM70O9Zf7sm+
 roIZG0kJTwRPMpvGKMjoahCaVCHPIeV7xANIw5S+Q6dN5bwJxAjfKupRq3TdUUvC7rAX
 ewCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4eHzcr1YBGh9o3F4BfOGRvjDUMT5g6q2aQ+3yXHWlOo=;
 b=VPNgaC82ZoRUbNdxSJt6/ggO+AJP9Rut/WpTIPObi70Z6qDn/uhzntxSkG77OqCIo9
 ZGCyUm2O5iKdwqDNdk/Pp01DWYGYOkqgyzSmEX+64oFp3EHza/LXF1WhnmxPoaQ+cK4i
 IGbju8AAoEL5EzXJhVtjkxv8N4Bdpx0PhkqgCy8Xw/ajXHIMxKpUD11xv27wzn6SauQX
 irCbUAJDXj0lfvEMI5jIypjYoEBTOf94IY6WzJEoE9U104C1e4ChwlI+RoYBFFODXYIo
 ldLwVKYe8gz5eQWhhWnJhA8UHMlbYHek6dkrXPz+ctedCiZUccoG8pLtwSws9CxqTaa1
 DQSA==
X-Gm-Message-State: AOAM532xgYE/8fA8Gol/ib/90TL9m7YZDnxQgb7HYjarsjkmHL7oPaV1
 wMD4zsE1fQgOJnKckz/TaxWzSndXQz+1SHNj/+B4/w==
X-Google-Smtp-Source: ABdhPJzNPHP87nTATQhKnvYuvIArBZyNmAuESqaseKTw/6hflPbUYbtD2HuT0mMBWgoGoh8R52W1FO0GY7/eOoWfE0w=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr18945849ljw.408.1646165703196; Tue, 01
 Mar 2022 12:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20220217153842.3252424-1-trix@redhat.com>
 <51018469-3bab-e56d-7407-b16170b5d74c@amd.com>
 <CADnq5_OGEURo76mzc4Sb2Jar465Xt4vkSMECDi5jCMH332zUAg@mail.gmail.com>
 <CAKwvOdnYTC7mku1=eVaDLGQFHdoN3u8Afoo582OAQ+ApJmfhQQ@mail.gmail.com>
 <CADnq5_PniW+-8G5AhOSwuovESpfeMxL4r6P30b3F1coa_NmMEQ@mail.gmail.com>
 <CAOWid-cXYze56YmUACWP4emNeGHXMFf4q5aZfFGUwVXWNFAvSg@mail.gmail.com>
In-Reply-To: <CAOWid-cXYze56YmUACWP4emNeGHXMFf4q5aZfFGUwVXWNFAvSg@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 1 Mar 2022 12:14:51 -0800
Message-ID: <CAKwvOdn52Kn1dnmp9cCwJtv5kPwZfHgApzhzajsdkjOwF8XqVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_ras_block_late_init error handler
To: Kenny Ho <y2kenny@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Mar 2022 20:51:59 +0000
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
Cc: "Joshi, Mukul" <mukul.joshi@amd.com>, llvm@lists.linux.dev,
 Dennis Li <Dennis.Li@amd.com>, Dave Airlie <airlied@linux.ie>,
 Tom Rix <trix@redhat.com>, Tao Zhou <tao.zhou1@amd.com>,
 xinhui pan <Xinhui.Pan@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>, "Stanley.Yang" <Stanley.Yang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>,
 John Clements <john.clements@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 22, 2022 at 11:12 AM Kenny Ho <y2kenny@gmail.com> wrote:
>
> On Thu, Feb 17, 2022 at 2:06 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Feb 17, 2022 at 2:04 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > >
> > > Alex,
> > > Has AMD been able to set up clang builds, yet?
> >
> > No.  I think some individual teams do, but it's never been integrated
> > into our larger CI systems as of yet as far as I know.
>
> I have just added clang build to our CI last night so hopefully we
> should be catching these now.

Wonderful! ++beers_owed;
-- 
Thanks,
~Nick Desaulniers
