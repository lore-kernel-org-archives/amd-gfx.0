Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_STARTS_WITH_NUMS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD4CA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 17:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F985205C9
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 17:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F985205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 467866E5C3;
	Thu, 24 Oct 2019 17:33:16 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E3C6E5C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 17:33:14 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id w18so26473532wrt.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2019 10:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AABhKq5nBSKUH4EY+9oKF8lEmOdhYtMpMndp66YW3eE=;
 b=bhmTB3YMn9NXC0Q3etNwqLbOrIOhnvXSUqzlgPEk3ihiH4l8/Gkg0QDU8rnDMspG7P
 HAlTa4L2jsW+GwT6k2WYcprQCy2ZclTLG+0DwYnB2fchoGjWNT27yrygZux+2jjBJSvs
 sP/lPcHdxaK1cJuI5XBqlW/flvE+38UeJy1kpoWJVhinBtAcnHuWGLUS7dshDIGblagl
 zc4tiF+cto8ZNfxIqjDOdQp6hozWftbfZUazKP9fofPQEkMCg4nn1lz5faNfl3vUXfnJ
 VKFjxcT/gFl0DeNHVB+KxnTyO1TUy4Q34kn6HeWttOdoAMGXumULs9cpD3X15hLm35FC
 YfTQ==
X-Gm-Message-State: APjAAAUqyBlUa8HFAbUkg2Xwl/ftt3M9EUs4RRzKC5iNHwWZhH4y1dsZ
 6L6MOLXndXl36+GFY2+VGMKTAkZF5SlXtqx7q3g=
X-Google-Smtp-Source: APXvYqwrJg0poJeYnbGwVhGKneZxosqoPTv82+VAgchF9L0DxHrUNQpw4YNe6Pl4zl5oLhAmvvlyIGC1o0bky3seVe0=
X-Received: by 2002:adf:ec90:: with SMTP id z16mr4692833wrn.110.1571938393464; 
 Thu, 24 Oct 2019 10:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHL+j0_2ir=8hHDoyqizweOUSV6XfqC-UCD15WuJ9vvptNLr0g@mail.gmail.com>
 <CADnq5_N0r8O2vQapGaary0L-OfdTdz-ezcMJK90+Gy2sPujYcw@mail.gmail.com>
 <CAHL+j08qsu1pSOZPLB9-XWw9ZmT2OamaWPBJV4T3Vzx_C8cD7g@mail.gmail.com>
 <67658520-b3f4-d2f9-7247-dd434ab5c30b@amd.com>
 <CAHL+j0-Nm+6VFXi_w4iciNdG40zubpqvh1RXs3MFfXJK2mFr0Q@mail.gmail.com>
 <CAHL+j0_=r1XBOzwiQmbZTVoRsZ5=Du3pAPd_n7pia81FegdHhw@mail.gmail.com>
 <57826a9e-5842-4ddd-a456-67d1d1b9a9ce@amd.com>
 <CAHL+j0-NJ8F4RpMJ5m9_9gk_t+zhwFwVmG6MMy4TBYa4XjnWEA@mail.gmail.com>
 <CADnq5_MTYe5z0gbtY0eCnUax2D=HZYBQF7YWPS86pikDXGVWOA@mail.gmail.com>
 <CAHL+j0_Dn9VZ7CN-yaaFP4kk39gWTKu4fLZ6SN4Dj17e2z+4RQ@mail.gmail.com>
 <CAHL+j08BgqmOoQHnsfE3xtZFsz14cOZ=Xui3o7mENJd3Fq0z0g@mail.gmail.com>
 <CAHL+j0-E83G4+xYDcJ2xB2abF9DXA78CXfP9LrVVktTmvsBYvg@mail.gmail.com>
 <CAHL+j0-D=AX7==2RRTXDaKEQwid8x817XO-upaDmCemMpvEF6Q@mail.gmail.com>
 <CADnq5_OL2ra6k8HHnAc=2Zp=bkKA6pLmGDacS3V+6RYHPgwtjg@mail.gmail.com>
In-Reply-To: <CADnq5_OL2ra6k8HHnAc=2Zp=bkKA6pLmGDacS3V+6RYHPgwtjg@mail.gmail.com>
From: Sylvain Munaut <246tnt@gmail.com>
Date: Thu, 24 Oct 2019 19:33:33 +0200
Message-ID:
 <CAHL+j0_LNy+R3A6DW7MKojW0XycOhCBeCHzA9LenaFvkwM0JWg@mail.gmail.com>
Subject: Re: Spontaneous reboots when using RX 560
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=AABhKq5nBSKUH4EY+9oKF8lEmOdhYtMpMndp66YW3eE=;
 b=gTqY5j0+uNTAHKX+gAspVKYAYGi1zAD68XXwJzeQqbflUyrqTQe8j1miu1TtjTDNEs
 /cNE73wSvK6FQ+P6N5Ptv5ODyP/YRSR5oWl2shZoUYjk4Hay+kjJjnKr9mrznlXlm2hb
 oP8NP2Uq972StBsB7PNnTp5IB3FmLXoCJwF60V6pi2Ek9pxo56iIGJS17ih6dX5hwHur
 XVFObIACJ1e/ckjCP5QWN/53yWAtaO5Roq7mWO2fQd3B40Gel5wfnhHcIl4bteKAaX1R
 kC3quw/xvdwMopcqK+BPyTeq6qTlKO0P81WQnOI6eXBZqEiTieCnxGn9/AF+t5NbKMpC
 dmcA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024173333.eA56wHBK4ucfTQFVLe58siAKChPMIClEIUPnq9CTnt4@z>

SGksCgo+IENhbiB5b3Ugc2VuZCBtZSBhIGNvcHkgb2YgdGhlIHZiaW9zIGZyb20gdGhhdCBib2Fy
ZD8KPgo+IChhcyByb290KQo+ICh1c2UgbHNwY2kgdG8gZ2V0IHRoZSBidXMgaWQpCj4gY2QgL3N5
cy9idXMvcGNpL2RldmljZXMvPHBjaSBidXMgaWQ+Cj4gZWNobyAxID4gcm9tCj4gY2F0IHJvbSA+
IC90bXAvdmJpb3Mucm9tCj4gZWNobyAwID4gcm9tCgpTdXJlLCBzZW50IGFzIHByaXZhdGUgbWVz
c2FnZS4KCkFsc28sIEkgZ290IGhvbGQgb2YgYSBSWDU3MCBmcm9tIGFub3RoZXIgdmVuZG9yIGFu
ZCB0ZXN0ZWQgdGhhdC4gV29ya3MKZmluZSwgbm8gY3Jhc2ggZXZlbiBkdXJpbmcgc3RyZXNzIHRl
c3RzIC8gYmVuY2htYXJrcy4KCkNoZWVycywKCiAgICBTeWx2YWluCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
