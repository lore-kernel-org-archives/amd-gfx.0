Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5287BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 16:16:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D30D10E277;
	Fri,  7 Oct 2022 16:16:40 +0000 (UTC)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADA210E8E4
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 23:54:08 +0000 (UTC)
Received: by mail-qt1-x82d.google.com with SMTP id g10so86451qtu.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Oct 2022 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pJMiQ46/KiBnfg6+facy6y32ur475qAL7V2FIVVnoOc=;
 b=H1uJFisEq86b1igTJeZ3icitP5usONcBgntp3Bmdfd7L7c+PbhZBFOBQP0sdQg07ow
 qxLoPLeON8LDcpeAyeJpP8HIJaym87ZqEiNnbYwcA07TYw/IVxsX/YQ5VYNjq29zKAWi
 PPHD1nPoH08WKswGp2QF09NZBEnNJqKOysIbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pJMiQ46/KiBnfg6+facy6y32ur475qAL7V2FIVVnoOc=;
 b=GiD5bCIA16WOh0fCFwxj7tGLvHLUamPBeiuwb5wKZUpfCrznjsdLSM7liby/udEElE
 z77wOGVNgPTEjbfct38XXbagMFo5djqnsN+cw4ZUy8jiYLnG+WAMiFAbMdLW+mAnMOpu
 HgfxRURaekh+roXBQqMcJxtrEjyCqa2GFnitk0Ir7kxxVWJ/BlINKhOItvJ4O2+dGO4O
 xvPnY2xy0Op0IAaaus3djS+GKwR5bqY4ONtDsSYNz1lv5AwxPA7N1tE5OoHmfRBUleeJ
 k/xSMMS1mLFJGSM62BXmFiwZVCKheJKXxHoN8k/Uv2lYe7EKRiUp2afKz9DXUMkMZniq
 c/Gw==
X-Gm-Message-State: ACrzQf1h/o55SUDhjUp2+y7GiNTpJ7uUPHEK5ThndqeX8o4BJ2dOk5sU
 SzzfzKOCCOiohwzROGbyAU/ZWJsownvCmA==
X-Google-Smtp-Source: AMsMyM4J5sB0P/5mQFZLvSDh9i6Kj2nvInV18HbmTAzJPaVTTyMCUcT5u62mEVtpvElvJUaC53qdag==
X-Received: by 2002:ac8:5f53:0:b0:35b:b155:1c1f with SMTP id
 y19-20020ac85f53000000b0035bb1551c1fmr2499084qta.148.1665100446693; 
 Thu, 06 Oct 2022 16:54:06 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com.
 [209.85.128.173]) by smtp.gmail.com with ESMTPSA id
 f11-20020a05620a280b00b006ce515196a7sm514447qkp.8.2022.10.06.16.54.06
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Oct 2022 16:54:06 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-35ad0584879so31492197b3.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Oct 2022 16:54:06 -0700 (PDT)
X-Received: by 2002:a05:6830:611:b0:65c:26ce:5dc with SMTP id
 w17-20020a056830061100b0065c26ce05dcmr1007394oti.176.1665100109301; Thu, 06
 Oct 2022 16:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6W+j+l0cJbr5dX@debian>
 <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
 <202210061328.37FCC30@keescook>
 <CADVatmMOEtX_vpR2iv9r7n5x76xjuyHwx6duERqjMutb=AKrhA@mail.gmail.com>
In-Reply-To: <CADVatmMOEtX_vpR2iv9r7n5x76xjuyHwx6duERqjMutb=AKrhA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Oct 2022 16:48:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2P3=W3iAsuhiMWMZSBPXQQJXudRAONp0xSuCQ218f_g@mail.gmail.com>
Message-ID: <CAHk-=wh2P3=W3iAsuhiMWMZSBPXQQJXudRAONp0xSuCQ218f_g@mail.gmail.com>
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display: fix
 array-bounds error in dc_stream_remove_writeback()")
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 07 Oct 2022 16:16:37 +0000
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
Cc: Kees Cook <keescook@chromium.org>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 6, 2022 at 1:50 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> > And it looks like Sudip's proposed fix for this particular code is
> > additionally fixing unsigned vs signed as well. I think -Warray-bounds
> > did its job (though, with quite a confusing index range in the report).
>
> Not my. Linus's. I just tested. :)

I suspect Kees meant Stephen's other patch that Hamza pointed at, and
that is perhaps the cleaner version.

That said, I hate how this forces us to write random code changes just
to make a compiler just randomly _happen_ to not complain about it.

                   Linus
