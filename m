Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F44C2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 20:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 852D720825
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 20:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852D720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDC96E41D;
	Thu, 12 Nov 2020 20:07:05 +0000 (UTC)
X-Greylist: delayed 8956 seconds by postgrey-1.36 at gabe;
 Thu, 12 Nov 2020 20:07:04 UTC
Received: from mail-40136.protonmail.ch (mail-40136.protonmail.ch
 [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E1856E41D
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 20:07:04 +0000 (UTC)
Date: Thu, 12 Nov 2020 20:06:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1605211622;
 bh=aMdnY74QL5IFUmVBmR+Q958hsa90jsMd/fiQu8c0hZE=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=Ur86OEM28+1OWCE5XiEYhAqGEGrzQeIkjSdRa4+kgOaCO4auA+pY6QoZrGmq+YWrK
 MjNMpEPlA8KznmQXafFPwGAMaZliJT6n509OqgMMxhqBNFQxSN2soOdXbdhYl9YDX8
 P9g2ZUz3Sv7UF0zHTB84wew3v5CMCxxRZqnK7uyLRpVFhwp2Ujs5zGu+HX3VBoMN5J
 B2WCKbfM5r2d7D33J+ff5NnH0gzMOTpL4vxhZOaa3USxLtMCEK5UrENqG9BiM7WCeb
 wwxJLiM0MPqXMwKpxJZ9sTrTbH0C5gkO9Pai6RnGe6OZTh9qHRwLEnicpZk9+GFjpp
 AlHzOBYUeWYPg==
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amd/display: add cursor pitch check
Message-ID: <VvOH2mNsO3Zn9gYXOa0Vn7kKqb2MvC0MKJXONCsmsnVcPaN6dJdxoGIboXdhy4oIf147mLuUC6KejFj5TOgDisty73bUPnvds0sXL-Fp52s=@emersion.fr>
In-Reply-To: <d791cc9f-7aa5-b453-992d-1f0cf0f2a905@amd.com>
References: <dM9UpdTNt3rJxagA8swvzv6sXdjID2x67yd3tJg6A@cp4-web-030.plabs.ch>
 <d791cc9f-7aa5-b453-992d-1f0cf0f2a905@amd.com>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q0MgRGFuaWVsIFZldHRlciBhbmQgQmFzLCBzZWUgYmVsb3figKYKCk9uIFRodXJzZGF5LCBOb3Zl
bWJlciAxMiwgMjAyMCA4OjU2IFBNLCBLYXpsYXVza2FzLCBOaWNob2xhcyA8bmljaG9sYXMua2F6
bGF1c2thc0BhbWQuY29tPiB3cm90ZToKCj4gUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIEthemxhdXNr
YXNuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20KClRoYW5rcyBmb3IgdGhlIHJldmlldyEKCj4g
PiBDb3VwbGUgcXVlc3Rpb25zOgo+ID4KPiA+IC0gVGhpcyBpbXBsZW1lbnRzIGEgc2luZ2xlIGNo
ZWNrIGZvciBhbGwgR1BVIGdlbmVyYXRpb25zLiBJcyBteQo+ID4gICBhc3N1bXB0aW9uIGNvcnJl
Y3QgaGVyZT8gSXQgc2VlbXMgbGlrZSB0aGlzIGNoZWNrIGlzIE9LIGZvciBhdCBsZWFzdAo+ID4g
ICBEQ04gMS4wIGFuZCBEQ04gMi4wLgo+ID4KPiA+IC0gV2Ugc2hvdWxkIHJlYWxseSBpbXBsZW1l
bnQgYmV0dGVyIGNoZWNrcy4gV2hhdCBmZWF0dXJlcyBhcmUgc3VwcG9ydGVkCj4gPiAgIG9uIHRo
ZSBjdXJzb3IgcGxhbmU/IElzIHNjYWxpbmcgc3VwcG9ydGVkPyBJcyBjcm9wcGluZyBzdXBwb3J0
ZWQ/IElzCj4gPiAgIHJvdGF0aW9uIGFsd2F5cyBzdXBwb3J0ZWQ/Cj4gPgo+Cj4gT24gRENFIGFu
ZCBEQ04gdGhlcmUgaXMgbm8gZGVkaWNhdGVkIGhhcmR3YXJlIGN1cnNvciBwbGFuZS4gWW91IGdl
dCBhCj4gY3Vyc29yIHBlciBwaXBlIGJ1dCBpdCdzIGdvaW5nIHRvIGluaGVyaXQgdGhlIHNjYWxp
bmcgYW5kIHBvc2l0aW9uaW5nCj4gZnJvbSB0aGUgdW5kZXJseWluZyBwaXBlLgo+Cj4gVGhlcmUn
cyBzb2Z0d2FyZSBsb2dpYyB0byBlbnN1cmUgd2UgcG9zaXRpb24gdGhlIGN1cnNvciBpbiB0aGUg
Y29ycmVjdAo+IGxvY2F0aW9uIGluIENSVEMgc3BhY2UgaW5kZXBlbmRlbnQgb24gdGhlIHVuZGVy
bHlpbmcgRFJNIHBsYW5lJ3Mgc2NhbGluZwo+IGFuZCBwb3NpdGlvbmluZyBidXQgdGhlcmUncyBu
byB3YXkgZm9yIHVzIHRvIGNvcnJlY3QgdGhlIHNjYWxpbmcuIEN1cnNvcgo+IHdpbGwgYWx3YXlz
IGJlIDY0LCAxMjgsIG9yIDI1NiBpbiB0aGUgcGlwZSdzIGRlc3RpbmF0aW9uIHNwYWNlLgoKSW50
ZXJlc3RpbmcuCgpEYW5pZWwgVmV0dGVyOiB3aGF0IHdvdWxkIGJlIHRoZSBiZXN0IHdheSB0byBl
eHBvc2UgdGhpcyB0byB1c2VyLXNwYWNlPwpNYXliZSB3ZSBzaG91bGQganVzdCBtYWtlIGF0b21p
YyBjb21taXRzIHdpdGggYSBjdXJzb3IgcGxhbmUgZmFpbCB3aGVuCnNjYWxpbmcgaXMgdXNlZCBv
biB0aGUgcHJpbWFyeSBwbGFuZT8KCkRpc2FibGluZyB0aGUgY3Vyc29yIHBsYW5lIHNvdW5kcyBi
ZXR0ZXIgdGhhbiBkaXNwbGF5aW5nIHRoZSB3cm9uZwppbWFnZS4KCj4gQ3Vyc29yIGNhbiBiZSBp
bmRlcGVuZGVudGx5IHJvdGF0ZWQgaW4gaGFyZHdhcmUgYnV0IHRoaXMgaXNuJ3Qgc29tZXRoaW5n
Cj4gd2UgZXhwb3NlIHN1cHBvcnQgZm9yIHRvIHVzZXJzcGFjZS4KCkhtbSwgSSBzZWUgdGhhdCBj
dXJzb3IgcGxhbmVzIGhhdmUgdGhlICJyb3RhdGlvbiIgcHJvcGVydHkgZXhwb3NlZDoKCiAgICAi
cm90YXRpb24iOiBiaXRtYXNrIHtyb3RhdGUtMCwgcm90YXRlLTkwLCByb3RhdGUtMTgwLCByb3Rh
dGUtMjcwfQoKSW4gZmFjdCBhbGwgcGxhbmVzIGhhdmUgaXQuIEl0J3MgZG9uZSBpbiBhbWRncHVf
ZG1fcGxhbmVfaW5pdCAoYmVoaW5kIGEKYGRtLT5hZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9CT05B
SVJFYCBjb25kaXRpb24pLgoKSXMgdGhpcyBhbiBvdmVyc2lnaHQ/Cgo+IFRoZSBwaXRjaCBjaGVj
ayBvZiA2NC8xMjgvMjU2IGlzIE9LIGJ1dCB3ZSBkb24ndCBzdXBwb3J0IDI1NiBvbiBEQ0UuCgpZ
ZWFoLCBJJ3ZlIG5vdGljZWQgdGhhdC4gVGhlIHNpemUgY2hlY2sgcmlnaHQgYWJvdmUgc2hvdWxk
IGNhdGNoIGl0CmluIG1vc3QgY2FzZXMgSSB0aGluaywgYmVjYXVzZSBtYXhfY3Vyc29yX3NpemUg
aXMgMTI4IG9uIERDRS4gU2lkZQpub3RlLCBtYXhfY3Vyc29yX3NpemUgaXMgNjQgb24gRENFIDYu
MC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
