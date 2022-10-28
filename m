Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48009C38A02
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 08:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E966B10E14B;
	Mon, 31 Oct 2022 08:14:37 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCC2010E871
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 16:36:21 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id k22so5229911pfd.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fiP/gtk1BinFFJgTXUZEj1NdMWlthKZ0OUfBLn7rLIU=;
 b=nimtRxz4mCnrDpP+awp+tQ1a53a8hyPg7iNtWXfhDq3ltrOL5UCs75i4rozXJGbMPX
 SDVQCO8PRkleubIaQin2/IPNBC4hc/yjrIa8pVbxkiahBacQ89eO+azcDW644Ub8H9WK
 rSEWZcGkj/DmpWCp2i1iWe6DBzQ+UBvL4XPl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fiP/gtk1BinFFJgTXUZEj1NdMWlthKZ0OUfBLn7rLIU=;
 b=F2bv8+1dWGE8nJNeFBI2e7CJPlIpJV86pU0ZDPNdodWWL/j0IDI3IL/1n5juXQCr1h
 kmQ4YOQforFmYCi3wrXVQ59ut2GhkrvAX7hHTRpfHOUZzEQkVDABKo9HOp4pQ4s0pP++
 3aew9zyQ5pkqiQvDbLzPGNb01j7usA2I1URIju+ysyjdXPXdpoL8vQK8VzpS5DHhEVa2
 pH6DjEufmMkyHNxhBDQ9xEK4oB9QBwaSBMijS3wL+rbmNS/WGVFasaVeCkiDwFylQx0A
 EiPmoFhxq2/tTIpHsS945FjOjAqE1esL2lx1O2XwSeRn5BS4Uhl5KtpI/266xmGciyOw
 djuw==
X-Gm-Message-State: ACrzQf0BiITMeIZFVzpf+h5CkdF5Sg+IOustux5VxsYAUS1CpnYGwdcO
 AicL64jna/lhk7UdqEQNvNfmwg==
X-Google-Smtp-Source: AMsMyM4EYfEXFnyMkOYnJEcYhC2e5fufT2TqnDENGZXbTy1gPAt1ADSI1/a/kujO8yVT2unTkINrkA==
X-Received: by 2002:a63:5a05:0:b0:434:23a5:a5ca with SMTP id
 o5-20020a635a05000000b0043423a5a5camr296969pgb.515.1666974981269; 
 Fri, 28 Oct 2022 09:36:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a170902ca8900b00180a7ff78ccsm3223888pld.126.2022.10.28.09.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Oct 2022 09:36:20 -0700 (PDT)
Date: Fri, 28 Oct 2022 09:36:19 -0700
From: Kees Cook <keescook@chromium.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] [next] drm/amdgpu: Replace one-element array with
 flexible-array member
Message-ID: <202210280855.9DF8E4D72@keescook>
References: <Y1tkWdwPUp+UdpM0@mail.google.com>
 <04e37ee1-53b0-97ab-d6d7-a39edfbdc2ea@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04e37ee1-53b0-97ab-d6d7-a39edfbdc2ea@amd.com>
X-Mailman-Approved-At: Mon, 31 Oct 2022 08:14:28 +0000
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
Cc: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
 Grigory Vasilyev <h0tc0d3@gmail.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Slark Xiao <slark_xiao@163.com>, Hans de Goede <hdegoede@redhat.com>,
 Claudio Suarez <cssk@net-c.es>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Rongguang Wei <weirongguang@kylinos.cn>,
 linux-hardening@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 28, 2022 at 09:18:39AM +0200, Christian König wrote:
> Am 28.10.22 um 07:10 schrieb Paulo Miguel Almeida:
> > One-element arrays are deprecated, and we are replacing them with
> > flexible array members instead. So, replace one-element array with
> > flexible-array member in struct _ATOM_FAKE_EDID_PATCH_RECORD and
> > refactor the rest of the code accordingly.
> > 
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [1].
> > 
> > Link: https://github.com/KSPP/linux/issues/79
> > Link: https://github.com/KSPP/linux/issues/238
> > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
> 
> I'm not sure if that's a good idea. We had multiple attempts to refactor
> this now and it always caused a regression.
> 
> Additional to that the header in question came from our BIOS team and isn't
> following Linux styles in general.
> 
> Alex what do you think?

Fake flexible arrays (i.e. 1-element arrays) are deprecated in Linux[1]
(and, frankly, deprecated in C since 1999 and even well before then given
the 0-sized extension that was added in GCC), so we can't continue to
bring them into kernel sources. Their use breaks both compile-time and
run-time bounds checking efforts, etc.

All that said, converting away from them can be tricky, and I think such
conversions need to explicitly show how they were checked for binary
differences[2].

Paulo, can you please check for deltas and report your findings in the
commit log? Note that add struct_size() use in the same patch may result
in binary differences, so for more complex cases, you may want to split
the 1-element conversion from the struct_size() conversions.

-Kees

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
[2] https://outflux.net/blog/archives/2022/06/24/finding-binary-differences/

-- 
Kees Cook
