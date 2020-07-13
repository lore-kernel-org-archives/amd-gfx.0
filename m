Return-Path: <SRS0=fQkT=AY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04BBC433E8
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 20:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E0920720
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2020 20:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nL2QSyRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E0920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B21EF6E82C;
	Mon, 13 Jul 2020 20:31:30 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEBF6E826;
 Mon, 13 Jul 2020 20:31:28 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id g20so14941020edm.4;
 Mon, 13 Jul 2020 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HnzQkPBt2OC+k9du8OZiIZUdaNF8CWZvobQFWZtz7PY=;
 b=nL2QSyRF4VdhkxgtyvoDIeRb4RfXopS6tkMpm+IFtrPuzigJardjBCFktXQ//PRpIJ
 bqFBi+hg+kUy5bDekzDKXUyylgLe3CHHJG2ppWdO/NS+ljwhP3heCpJdh4lk2NnMEUfU
 ddiMB88lFu0EW/lhkvLbxvu1bX74yl9SAZxy9VD+XJIZZm5g3+WyjM+H36R+72nSUcMz
 hc2JzL2X+Qo8w0sxB69fJLfnqx/NUH8RQtLqZrOAgD/3Ui26wZjCVvHKl4TO8elowm48
 XFQilIER6Vwww/OgWOMYlYRXQ6cLge8urHT9+cBR2T8i9MGj0F5ZMoR7SyOYMpB3H1Yz
 A2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HnzQkPBt2OC+k9du8OZiIZUdaNF8CWZvobQFWZtz7PY=;
 b=e/mHFoAta7kiuy4Qwx2AP9ex/qkH+XTdBP+c9BDa2mTW5kz1+aBNb0gtFI+yvhOl+Q
 WeiENtLSNRg1HMziYatr3CcKSh93C+Ik3eOsBRtSdMDoGX3YfA/B+LehZsq4oGjpG1PV
 6Wi/CWz1HgAedYxdy4XUAQTaN4T3U7f4Fock5lMKy+fN17dv7pKU4bwKx/GYF+QIR392
 kpzya8tBVgq1Yhe+HGLCy2zcBCBae5VBX8SjMgPe99+GnWTpqPB5JUkZOYJaJnp8ppUE
 ueG1nBl/XPPIGHwy6QPTnLC0XTSc+fPcP7ceAekBuOLuC8lFPu4FkosaOp7EPVEzulSp
 WNYA==
X-Gm-Message-State: AOAM533cUpTb7jSWy2Q95+Pbhx+jivYvMyfzp++fQNZbsu68POmiy8Ed
 QBuw6PZCOfpXOIRIEp8G3DqeWnVTD+tVLHH3B1g=
X-Google-Smtp-Source: ABdhPJxPAYikRaQY/XMVDWezfOW6Iwk/c5G8BcDCGjjzvlG6bojjnVvJlH11+w5rhFd3jK7dVcdAJfhqlzC5TvPI8KA=
X-Received: by 2002:a50:ee8a:: with SMTP id f10mr1094484edr.383.1594672287315; 
 Mon, 13 Jul 2020 13:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-2-daniel.vetter@ffwll.ch>
 <20c0a95b-8367-4f26-d058-1cb265255283@amd.com>
 <20200713162610.GS3278063@phenom.ffwll.local>
 <e9e838fb-ec83-f7e0-e978-b57d8892b3f0@amd.com>
In-Reply-To: <e9e838fb-ec83-f7e0-e978-b57d8892b3f0@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 14 Jul 2020 06:31:15 +1000
Message-ID: <CAPM=9tyTd0OqtdX+pGhGm3K1odNkG5EEL+0DZwL=NiVkogOujQ@mail.gmail.com>
Subject: Re: [PATCH 01/25] dma-fence: basic lockdep annotations
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@intel.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCAxNCBKdWwgMjAyMCBhdCAwMjozOSwgQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+IEFtIDEzLjA3LjIwIHVtIDE4OjI2IHNjaHJpZWIg
RGFuaWVsIFZldHRlcjoKPiA+IEhpIENocmlzdGlhbiwKPiA+Cj4gPiBPbiBXZWQsIEp1bCAwOCwg
MjAyMCBhdCAwNDo1NzoyMVBNICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+ID4+IENv
dWxkIHdlIG1lcmdlIHRoaXMgY29udHJvbGxlZCBieSBhIHNlcGFyYXRlIGNvbmZpZyBvcHRpb24/
Cj4gPj4KPiA+PiBUaGlzIHdheSB3ZSBjb3VsZCBoYXZlIHRoZSBjaGVja3MgdXBzdHJlYW0gd2l0
aG91dCBoYXZpbmcgdG8gZml4IGFsbCB0aGUKPiA+PiBzdHVmZiBiZWZvcmUgd2UgZG8gdGhpcz8K
PiA+IERpc2N1c3Npb25zIGRpZWQgb3V0IGEgYml0LCBkbyB5b3UgY29uc2lkZXIgdGhpcyBhIGJs
b2NrZXIgZm9yIHRoZSBmaXJzdAo+ID4gdHdvIHBhdGNoZXMsIG9yIGdvb2QgZm9yIGFuIGFjayBv
biB0aGVzZT8KPgo+IFllcywgSSB0aGluayB0aGUgZmlyc3QgdHdvIGNhbiBiZSBtZXJnZWQgd2l0
aG91dCBjYXVzaW5nIGFueSBwYWluLiBGZWVsCj4gZnJlZSB0byBhZGQgbXkgYWIgb24gdGhlbS4K
Pgo+IEFuZCB0aGUgdGhpcmQgb25lIGNhbiBnbyBpbiBpbW1lZGlhdGVseSBhcyB3ZWxsLgoKQWNr
ZWQtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+IGZvciB0aGUgZmlyc3QgMiAr
CmluZGVmaW5pdGUgZXhwbGFpbnMuCgpEYXZlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
