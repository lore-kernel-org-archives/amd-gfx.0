Return-Path: <SRS0=iszZ=JR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6F5C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 18:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D700760200
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Apr 2021 18:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D700760200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F056E88F;
	Tue, 20 Apr 2021 18:03:57 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA51D6E88F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 18:03:56 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id r128so35839708lff.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Apr 2021 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gE/xHk8gIJnXC0D1s5Jzn/r/flDjnavjc9ly70d96xQ=;
 b=oXhXKDYZUSYbojnBLgqcHutqlf+Or0uZisHWYxrNl0Y3lfhT3S7vZy3E1Atqtdn21p
 78nYnQOeuB5UOOOiL21d1v7CDLztCAwcH5M8BlSrn1bjHNWMslE2RN4R5ydrskECgb+h
 HcfJma6chMr/8AqnrS0hQMGHW6baBYd2M21uyOi0i/C98ClR5oo9fy1uZswQgvm0facT
 6j1epsmjE1awoH5v5jYg0TFtkibhb6By4tbBvT2p33ZP9szz4oAiZNL5SqraYFzknIMO
 wRfNAEtqzlwpPRMrHzJuP8uKHbLnirxl9QeLmc6jAq21wqNApcGhMxFMqBqppXmYosYP
 inRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gE/xHk8gIJnXC0D1s5Jzn/r/flDjnavjc9ly70d96xQ=;
 b=t7CEjzihiBUJjzO5c7nJsio6zlSWLBnJm6LsssTbszVJDKRTQPu7ZwN8QwoRSvOtX8
 dx+1eK4gSqbJjHTOKQEYQzPBNR4LzPWa+SIG9r2Mc9jq+cAGdEPI+UiHM1RxhSn75g+y
 ntydudmuXj2g5tIRu16D9IJT1TQsK1MISOh3hpAgrvNrydVI0yWWtWkvYtcwiG+3JM72
 dNdNJidqTKUDbIwJjR9ijh4Fw9Wn+9DXeBEDAAsLNR54sa5iBtI+9Vq8tuQtZJJz6EE6
 6mCjRHjlJ/veeqenro7gCO1Ej9ebwe7l6duCzMV0T7yY7hT1T5VWpdIVFlm5bInDg75A
 hh9Q==
X-Gm-Message-State: AOAM530bWICyEfoQAqNY01NOFFyzIfd4DLOib4yna7YqgHi1tqnXyfjz
 Dxl2ngC36p1sVvjE45FHWb2FjpdZbgRsRVHjSp8=
X-Google-Smtp-Source: ABdhPJyYpQQcBUd+x0BFgbdil+6Mis6ubke0BeQX4Eg4XvA8gbr42vmqTL2Fv2E4by3ywdzXQT37RfpITxsJWZbE0nE=
X-Received: by 2002:a05:6512:308d:: with SMTP id
 z13mr3925433lfd.130.1618941835264; 
 Tue, 20 Apr 2021 11:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsOifMk4+VHi4bnHCL2L_tT+Tm_Rz+KxD3ZQOowx1xms4g@mail.gmail.com>
 <293189a2-3a6b-1e50-7607-33917743b9d8@amd.com>
 <CABXGCsMMUa=0+GAHxfVdOOFO0Lx=tCa4+ongHN8rF4TAR9nVmg@mail.gmail.com>
 <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
In-Reply-To: <66f5fdcb-d414-603d-bdb8-70579335b4a2@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 20 Apr 2021 23:03:44 +0500
Message-ID: <CABXGCsP+qjMuPpi7o=mnuvcuRyViYxiT8qEsqS2kHwMSEs835A@mail.gmail.com>
Subject: Re: [BUG] VAAPI encoder cause kernel panic if encoded video in 4K
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAxNCBBcHIgMjAyMSBhdCAxMTo0OCwgQ2hyaXN0aWFuIEvDtm5pZwo8Y2tvZW5pZy5s
ZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gPj4gY29tbWl0IGY2M2RhOWFlNzU4
NDI4MDU4MmNiYzgzNGIyMGNjMThiZmIyMDNiMTQKPiA+PiBBdXRob3I6IFBoaWxpcCBZYW5nIDxQ
aGlsaXAuWWFuZ0BhbWQuY29tPgo+ID4+IERhdGU6ICAgVGh1IEFwciAxIDAwOjIyOjIzIDIwMjEg
LTA0MDAKPiA+Pgo+ID4+ICAgICAgIGRybS9hbWRncHU6IHJlc2VydmUgZmVuY2Ugc2xvdCB0byB1
cGRhdGUgcGFnZSB0YWJsZQo+ID4+Cj4KPiBUaGF0IGlzIGV4cGVjdGVkIGJlaGF2aW9yLCB0aGUg
YXBwbGljYXRpb24gaXMganVzdCBidWdneSBhbmQgY2F1c2luZyBhCj4gcGFnZSBmYXVsdCBvbiB0
aGUgR1BVLgo+Cj4gVGhlIGtlcm5lbCBzaG91bGQganVzdCBub3QgY3Jhc2ggd2l0aCBhIGJhY2t0
cmFjZS4KPgoKQW55IGNoYW5jZSB0byBzZWUgdGhpcyBjb21taXQgdG8gYmUgYmFja3BvcnRlZCB0
byA1LjEyPwpJIHBsYW4gdG8gc3VibWl0IGEgYnVnIHJlcG9ydCB0byBPQlMgZGV2cyBhbmQgZG9u
J3Qgd2FudCBteSBzeXN0ZW0gdG8KaGFuZyBhZ2FpbiBhbmQgYWdhaW4gd2hlbiBJIHdvdWxkIHRl
c3QgdGhlaXIgcGF0Y2hlcy4KCi0tIApCZXN0IFJlZ2FyZHMsCk1pa2UgR2F2cmlsb3YuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
