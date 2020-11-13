Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C40C55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E85AB2074B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 15:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HxBZqQ1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E85AB2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A68C6E4EC;
	Fri, 13 Nov 2020 15:52:50 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5FB6E4F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 15:52:48 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id a15so9328000otf.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 07:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a2dKCMvDmQsRobe1p8uXtNfJj0W2AQadcxx+rEFBKog=;
 b=HxBZqQ1mYxd4UriyAX61UOJjsAJ6kqHTjC+3vogLGsWuZpiwY2coFWdW8tPEXkoNp9
 biaP01io1cS1zs90Bi/x2dOE5z98HGDbquHm5kYpCbh/rKZEO/ZLG7pM7Oy4HnOw6EPc
 LIj1XVcgFROC+3nYns6T8EUH8U4fBeQ0rjVU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a2dKCMvDmQsRobe1p8uXtNfJj0W2AQadcxx+rEFBKog=;
 b=anewp1U8HLWF2LbqEEXkBwpCmm5XRp53S4dQYYWlUdxYckqyDb3qIRrobnXaDeH4oJ
 vqHTnhWJ/toJ2iRNHLvvHo9+LVr0yBR/1RgjbX3HQTK8k8UF/xJ1N3NXtQFdWT2uiHpO
 qO1CFnAlN1p98wopZkm/8yl9dCzD0Kdo3wLsaXXnCU4JSJnefHbcmQYWXS30zbdx/1rS
 rIrCyzDU+Z7PL1TkhYXo3QGCuWYlf16KRQRVnIv5Po3uGRdXunhYpqQT/69Qb4BDWRyf
 uLEkGe+YfkGZ3n0i2jmKYkGnyfOL3I2AUzl3KHleodHKoUzXY1IXsrYuRUOXgofsphRc
 Ze1A==
X-Gm-Message-State: AOAM532d+EYNgSwdrSm1Vg/LzaeG5oEoCYt4+XcA8AnvCSkeLdTLBKm2
 6/pUd3i7tnnumHRIhgQU90Qa88KLzpEwQnE45gq6qA==
X-Google-Smtp-Source: ABdhPJxzojzozC2r5NeJAI/QaCtfc+rxdofOgMfUcHW7SGnA1+rVbmkM4dmKHHW00sJMNag/VxbcPrfqBwUpFyZDw+M=
X-Received: by 2002:a9d:27a5:: with SMTP id c34mr1880560otb.303.1605282763152; 
 Fri, 13 Nov 2020 07:52:43 -0800 (PST)
MIME-Version: 1.0
References: <dM9UpdTNt3rJxagA8swvzv6sXdjID2x67yd3tJg6A@cp4-web-030.plabs.ch>
 <d791cc9f-7aa5-b453-992d-1f0cf0f2a905@amd.com>
 <VvOH2mNsO3Zn9gYXOa0Vn7kKqb2MvC0MKJXONCsmsnVcPaN6dJdxoGIboXdhy4oIf147mLuUC6KejFj5TOgDisty73bUPnvds0sXL-Fp52s=@emersion.fr>
In-Reply-To: <VvOH2mNsO3Zn9gYXOa0Vn7kKqb2MvC0MKJXONCsmsnVcPaN6dJdxoGIboXdhy4oIf147mLuUC6KejFj5TOgDisty73bUPnvds0sXL-Fp52s=@emersion.fr>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 13 Nov 2020 16:52:32 +0100
Message-ID: <CAKMK7uE=O1Xu1y3MFT3ZOHPTjTov6fVZTEFQFFu59D3_QdjnEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add cursor pitch check
To: Simon Ser <contact@emersion.fr>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgOTowNyBQTSBTaW1vbiBTZXIgPGNvbnRhY3RAZW1lcnNp
b24uZnI+IHdyb3RlOgo+Cj4gQ0MgRGFuaWVsIFZldHRlciBhbmQgQmFzLCBzZWUgYmVsb3figKYK
Pgo+IE9uIFRodXJzZGF5LCBOb3ZlbWJlciAxMiwgMjAyMCA4OjU2IFBNLCBLYXpsYXVza2FzLCBO
aWNob2xhcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPiB3cm90ZToKPgo+ID4gUmV2aWV3
ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNrYXNuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20KPgo+
IFRoYW5rcyBmb3IgdGhlIHJldmlldyEKPgo+ID4gPiBDb3VwbGUgcXVlc3Rpb25zOgo+ID4gPgo+
ID4gPiAtIFRoaXMgaW1wbGVtZW50cyBhIHNpbmdsZSBjaGVjayBmb3IgYWxsIEdQVSBnZW5lcmF0
aW9ucy4gSXMgbXkKPiA+ID4gICBhc3N1bXB0aW9uIGNvcnJlY3QgaGVyZT8gSXQgc2VlbXMgbGlr
ZSB0aGlzIGNoZWNrIGlzIE9LIGZvciBhdCBsZWFzdAo+ID4gPiAgIERDTiAxLjAgYW5kIERDTiAy
LjAuCj4gPiA+Cj4gPiA+IC0gV2Ugc2hvdWxkIHJlYWxseSBpbXBsZW1lbnQgYmV0dGVyIGNoZWNr
cy4gV2hhdCBmZWF0dXJlcyBhcmUgc3VwcG9ydGVkCj4gPiA+ICAgb24gdGhlIGN1cnNvciBwbGFu
ZT8gSXMgc2NhbGluZyBzdXBwb3J0ZWQ/IElzIGNyb3BwaW5nIHN1cHBvcnRlZD8gSXMKPiA+ID4g
ICByb3RhdGlvbiBhbHdheXMgc3VwcG9ydGVkPwo+ID4gPgo+ID4KPiA+IE9uIERDRSBhbmQgRENO
IHRoZXJlIGlzIG5vIGRlZGljYXRlZCBoYXJkd2FyZSBjdXJzb3IgcGxhbmUuIFlvdSBnZXQgYQo+
ID4gY3Vyc29yIHBlciBwaXBlIGJ1dCBpdCdzIGdvaW5nIHRvIGluaGVyaXQgdGhlIHNjYWxpbmcg
YW5kIHBvc2l0aW9uaW5nCj4gPiBmcm9tIHRoZSB1bmRlcmx5aW5nIHBpcGUuCj4gPgo+ID4gVGhl
cmUncyBzb2Z0d2FyZSBsb2dpYyB0byBlbnN1cmUgd2UgcG9zaXRpb24gdGhlIGN1cnNvciBpbiB0
aGUgY29ycmVjdAo+ID4gbG9jYXRpb24gaW4gQ1JUQyBzcGFjZSBpbmRlcGVuZGVudCBvbiB0aGUg
dW5kZXJseWluZyBEUk0gcGxhbmUncyBzY2FsaW5nCj4gPiBhbmQgcG9zaXRpb25pbmcgYnV0IHRo
ZXJlJ3Mgbm8gd2F5IGZvciB1cyB0byBjb3JyZWN0IHRoZSBzY2FsaW5nLiBDdXJzb3IKPiA+IHdp
bGwgYWx3YXlzIGJlIDY0LCAxMjgsIG9yIDI1NiBpbiB0aGUgcGlwZSdzIGRlc3RpbmF0aW9uIHNw
YWNlLgo+Cj4gSW50ZXJlc3RpbmcuCj4KPiBEYW5pZWwgVmV0dGVyOiB3aGF0IHdvdWxkIGJlIHRo
ZSBiZXN0IHdheSB0byBleHBvc2UgdGhpcyB0byB1c2VyLXNwYWNlPwo+IE1heWJlIHdlIHNob3Vs
ZCBqdXN0IG1ha2UgYXRvbWljIGNvbW1pdHMgd2l0aCBhIGN1cnNvciBwbGFuZSBmYWlsIHdoZW4K
PiBzY2FsaW5nIGlzIHVzZWQgb24gdGhlIHByaW1hcnkgcGxhbmU/CgpJIHRoaW5rIHRoZXJlJ3Mg
YmVlbiBkaXNjdXNzaW9uIGZvciBhIHBpcGUgc2NhbGluZyBwcm9wZXJ0eSBvbiB0aGUKY3J0Yy4g
QXMgbG9uZyBhcyB3ZSBkb24ndCBoYXZlIHRoYXQsIGFuZCB5b3UncmUgdXNpbmcgdGhlIHBpcGUg
c2NhbGluZwp0byBzY2FsZSB0aGUgcHJpbWFyeSBwbGFuZSwgdGhlbiBJIGd1ZXNzIHlvdSBoYXZl
IHRvIHJlamVjdCB0aGUgY3Vyc29yCmlmIGl0J3MgZW5hYmxlZC4gRXhjZXB0IG1heWJlIGlmIHRo
ZSBzY2FsaW5nIGlzIHRoZSBzYW1lIG9uZSwgZHVubm8Kd2hldGhlciB0aGF0IGV2ZXIgaGFwcGVu
cy4KLURhbmllbAoKCj4gRGlzYWJsaW5nIHRoZSBjdXJzb3IgcGxhbmUgc291bmRzIGJldHRlciB0
aGFuIGRpc3BsYXlpbmcgdGhlIHdyb25nCj4gaW1hZ2UuCj4KPiA+IEN1cnNvciBjYW4gYmUgaW5k
ZXBlbmRlbnRseSByb3RhdGVkIGluIGhhcmR3YXJlIGJ1dCB0aGlzIGlzbid0IHNvbWV0aGluZwo+
ID4gd2UgZXhwb3NlIHN1cHBvcnQgZm9yIHRvIHVzZXJzcGFjZS4KPgo+IEhtbSwgSSBzZWUgdGhh
dCBjdXJzb3IgcGxhbmVzIGhhdmUgdGhlICJyb3RhdGlvbiIgcHJvcGVydHkgZXhwb3NlZDoKPgo+
ICAgICAicm90YXRpb24iOiBiaXRtYXNrIHtyb3RhdGUtMCwgcm90YXRlLTkwLCByb3RhdGUtMTgw
LCByb3RhdGUtMjcwfQo+Cj4gSW4gZmFjdCBhbGwgcGxhbmVzIGhhdmUgaXQuIEl0J3MgZG9uZSBp
biBhbWRncHVfZG1fcGxhbmVfaW5pdCAoYmVoaW5kIGEKPiBgZG0tPmFkZXYtPmFzaWNfdHlwZSA+
PSBDSElQX0JPTkFJUkVgIGNvbmRpdGlvbikuCj4KPiBJcyB0aGlzIGFuIG92ZXJzaWdodD8KPgo+
ID4gVGhlIHBpdGNoIGNoZWNrIG9mIDY0LzEyOC8yNTYgaXMgT0sgYnV0IHdlIGRvbid0IHN1cHBv
cnQgMjU2IG9uIERDRS4KPgo+IFllYWgsIEkndmUgbm90aWNlZCB0aGF0LiBUaGUgc2l6ZSBjaGVj
ayByaWdodCBhYm92ZSBzaG91bGQgY2F0Y2ggaXQKPiBpbiBtb3N0IGNhc2VzIEkgdGhpbmssIGJl
Y2F1c2UgbWF4X2N1cnNvcl9zaXplIGlzIDEyOCBvbiBEQ0UuIFNpZGUKPiBub3RlLCBtYXhfY3Vy
c29yX3NpemUgaXMgNjQgb24gRENFIDYuMC4KCgoKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUg
RW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
