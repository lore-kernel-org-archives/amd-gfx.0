Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2787BC433FE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 20:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37ED510E674;
	Thu,  6 Oct 2022 20:44:57 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A30B10E674
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 20:37:18 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id bh13so2869913pgb.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Oct 2022 13:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=vUTyG6Np/u72Dz/dgBQ4qw28uB5CVEnf9ne0MjdRNXQ=;
 b=l4pzgbjCLfunsDmBM/oJsQgA/6oc2FTqn96xT9kDUHrLVbLcZSnT2054BUsF9BaE4N
 Vp2VyRDx9wEPFP/en9z5piVn4kS17i1eno1WqQYJzbR+iRHgHHWY82eSHog5/x3sSfDw
 wv2xe97OHgpkWIoe8EIm7Z+bM7mahJL49i8ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=vUTyG6Np/u72Dz/dgBQ4qw28uB5CVEnf9ne0MjdRNXQ=;
 b=hR60G4QWoeN0/HutbwAqEVdpq2mWmDz0LYf39nvQHXECN3aRKbTbMJ4SbsmlnkoyCU
 Or+BC1UZLF1aQPVmVB/uqCeDtWHj6lmKeOVSvzOBIa/2R6K6O/f0CBdvNQWTsvgoTwFK
 u1vLRQU1Yt7KiGhgXvKTnkl1havOKUF8JQOZzYTdhFEWIUpAr2sZxTYaxJ1DXdk5Rm1b
 4mOhaAW2DSxS8VE9sD+FCG53M3gfnAhtdvciMKLnUD58UE5/LtA+zX5jnUNms/JoHKrq
 +jPN0gBcGsDDq4d56/vY9ItEVi0CXAsM7fLQ5CNoQ2pinc/xprp/6Co/KIpQFAk4kcbe
 Zmnw==
X-Gm-Message-State: ACrzQf28LIDzbJEmLrejpS4s4q8RYOUI4+p+GwrBrzDYwKJg6nih+X0r
 XR5QUV8eRejSKzguX7GIQU181A==
X-Google-Smtp-Source: AMsMyM6tUrflXlcmIduh6tv4hATbfSVnVFeSJd3pPCVGqgQFpNV5ZCLn3XXM8SrarBxmq5FPsdAdow==
X-Received: by 2002:a05:6a00:230d:b0:53d:c198:6ad7 with SMTP id
 h13-20020a056a00230d00b0053dc1986ad7mr1277124pfh.67.1665088637855; 
 Thu, 06 Oct 2022 13:37:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 f33-20020a17090a702400b0020647f279fbsm3284227pjk.29.2022.10.06.13.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Oct 2022 13:37:17 -0700 (PDT)
Date: Thu, 6 Oct 2022 13:37:15 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display:
 fix array-bounds error in dc_stream_remove_writeback()")
Message-ID: <202210061328.37FCC30@keescook>
References: <Yz6W+j+l0cJbr5dX@debian>
 <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
X-Mailman-Approved-At: Thu, 06 Oct 2022 20:44:54 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Nathan Chancellor <nathan@kernel.org>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 "Sudip Mukherjee \(Codethink\)" <sudipm.mukherjee@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 06, 2022 at 12:39:40PM -0700, Linus Torvalds wrote:
> What confuses me is that error message ("array subscript [0, 0] is
> outside array bounds of 'struct dc_writeback_info[1]') which seems to
> be aware that the value is actually 0.

I've seen bugs in the tracker where the reporting is broken but the
range checker is working "correctly", which seems to be the case here.

> If somebody cannot come up with a fix, I suspect the solution is "gcc
> array bounds analysis is terminally buggy" and we just need to disable
> it for gcc-11 too.

It does continue to find bugs, so I'd rather keep it on. GCC has fixed
all the issues we've run into so far (though not all have been back
ported to GCC 12 yet, so yes, let's keep -Warray-bounds disabled there).

Specifically, I've been tracking:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679	Fixed 13+
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578	Fixed 12+, 11.3

And it looks like Sudip's proposed fix for this particular code is
additionally fixing unsigned vs signed as well. I think -Warray-bounds
did its job (though, with quite a confusing index range in the report).

-Kees

-- 
Kees Cook
