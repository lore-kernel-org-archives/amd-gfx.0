Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7427BC63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4A820725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8GJtZV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4A820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FE28925F;
	Mon, 30 Nov 2020 22:44:56 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 574FC8925F;
 Mon, 30 Nov 2020 22:44:55 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id f12so12951152oto.10;
 Mon, 30 Nov 2020 14:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9eou7H4jUQYuMP40Vx2X7n5sdb9mdDkeKlmAnOCDMKk=;
 b=F8GJtZV0IDEsWCjG1kzv2MF1f+nIQbW4a9h0GlctfNufh5gZzzr2xi8E5QRtMsQLiu
 z5RiLnA1ZVEsTIu5ebHv5nf0nCIzV26e2ReLZCHtQR2wr/8nkW7DXAirLx33ztC8vHJ2
 iZA/NiFaY3ZMiMdgTm3xagDdlZskNmiotAGdbyNJJybxzmGV9O7W9hooXoxH3Bgrh9M9
 NGo5pZVEMJIAUclrZMfewAOT4uDM9beYKq7vmoeAu210qa3FHBE+hUyU6LhqlZnn3/Uw
 qHCuuE3Q6xcLxKHQ37R9hqIBrEp7As3a4jlNy4fGEbUiinHm5+JBJJEh0vCFCfn3TACq
 xe8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9eou7H4jUQYuMP40Vx2X7n5sdb9mdDkeKlmAnOCDMKk=;
 b=IzgsF1sBmLWj9TDXJXWBGFv/upPfkfQrjSzlxpxPXsaenRUeJ2TccHtNZ1M9xjWnVr
 tGEHYMN74ja70PD3kfIJEZyV+rCsNgIwGdEAnjFzd80XJtzFecps1Pif4/UtuxXfVpNs
 Rl8cZAlYZNIvaSA0Vpe7L8OzStr0v4CPFTYvjCnoCy9eG41zBD80vugaBuXtcpLym/yP
 FySXq3dSKACzqgd4iYOkNLtmHGTtoEWGH0LR8FHLZ95+J44YRqrnIXhA2tVFFVFVfTIq
 Cn8ytcWOSynDhhaaM1/GXRr+qSGILWYo3TaEuXa8sB5Xu1DZlbq0Hwba+6bHCh/SB+h7
 BaQA==
X-Gm-Message-State: AOAM533PLGkLt18+C3U2hMK3Ra5MJQJvA4Xr17nl+02YUw++Wr+tU4ok
 WVupE9BMytJfdy/NH+J5mDEnCmVFbZcV/KAUZ5Q=
X-Google-Smtp-Source: ABdhPJyv2GldrfqUXKNWguuCyw1r0o+rVIKgOCIw6Di6iY04CaqLyUTz+fvR1dByMsH//fFcavJ3RqADmaOJ43vm3cs=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18812087otg.311.1606776294749; 
 Mon, 30 Nov 2020 14:44:54 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-32-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-32-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 17:44:43 -0500
Message-ID: <CADnq5_PHJnXaDbj=Y5zGoXgx+kD2aiN8LPDM52FqOxU2w15GJQ@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/amdgpu/jpeg_v2_0: Add some missing
 kernel-doc descriptions
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jOjQ5
ODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYWRkcicgbm90IGRlc2Ny
aWJlZCBpbiAnanBlZ192Ml8wX2RlY19yaW5nX2VtaXRfZmVuY2UnCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jOjQ5ODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVy
IG9yIG1lbWJlciAnc2VxJyBub3QgZGVzY3JpYmVkIGluICdqcGVnX3YyXzBfZGVjX3JpbmdfZW1p
dF9mZW5jZScKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmM6NDk4OiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmbGFncycgbm90IGRlc2NyaWJl
ZCBpbiAnanBlZ192Ml8wX2RlY19yaW5nX2VtaXRfZmVuY2UnCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2pwZWdfdjJfMC5jOjQ5ODogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFt
ZXRlciAnZmVuY2UnIGRlc2NyaXB0aW9uIGluICdqcGVnX3YyXzBfZGVjX3JpbmdfZW1pdF9mZW5j
ZScKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml8wLmM6NTQ5OiB3YXJuaW5n
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdqb2InIG5vdCBkZXNjcmliZWQgaW4gJ2pw
ZWdfdjJfMF9kZWNfcmluZ19lbWl0X2liJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9q
cGVnX3YyXzAuYzo1NDk6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2Zs
YWdzJyBub3QgZGVzY3JpYmVkIGluICdqcGVnX3YyXzBfZGVjX3JpbmdfZW1pdF9pYicKPgo+IENj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3Rp
YW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUg
PGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4K
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+CgpBcHBsaWVkIHdpdGggbWlub3IgZml4ZXMuICBUaGFua3MhCgpBbGV4Cgo+IC0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYyB8IDYgKysrKystCj4g
IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzAuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jCj4gaW5kZXggNmI4MGRjZWE4MGVjOC4uMTVj
MDIyNGQ0OGIwNiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVn
X3YyXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfMC5jCj4g
QEAgLTQ4OSw3ICs0ODksOSBAQCB2b2lkIGpwZWdfdjJfMF9kZWNfcmluZ19pbnNlcnRfZW5kKHN0
cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgICoganBlZ192Ml8wX2RlY19yaW5nX2VtaXRfZmVu
Y2UgLSBlbWl0IGFuIGZlbmNlICYgdHJhcCBjb21tYW5kCj4gICAqCj4gICAqIEByaW5nOiBhbWRn
cHVfcmluZyBwb2ludGVyCj4gLSAqIEBmZW5jZTogZmVuY2UgdG8gZW1pdAo+ICsgKiBAYWRkcjog
YWRkcmVzcwo+ICsgKiBAc2VxOiBzZXF1ZW5jZSBudW1iZXIKPiArICogQGZsYWdzOiBmZW5jZSBy
ZWxhdGVkIGZsYWdzCj4gICAqCj4gICAqIFdyaXRlIGEgZmVuY2UgYW5kIGEgdHJhcCBjb21tYW5k
IHRvIHRoZSByaW5nLgo+ICAgKi8KPiBAQCAtNTM4LDcgKzU0MCw5IEBAIHZvaWQganBlZ192Ml8w
X2RlY19yaW5nX2VtaXRfZmVuY2Uoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1NjQgYWRkciwg
dTY0IHNlcSwKPiAgICoganBlZ192Ml8wX2RlY19yaW5nX2VtaXRfaWIgLSBleGVjdXRlIGluZGly
ZWN0IGJ1ZmZlcgo+ICAgKgo+ICAgKiBAcmluZzogYW1kZ3B1X3JpbmcgcG9pbnRlcgo+ICsgKiBA
am9iOiBqb2IgdG8gcmV0cml2ZSB2bWlkIGZyb20KPiAgICogQGliOiBpbmRpcmVjdCBidWZmZXIg
dG8gZXhlY3V0ZQo+ICsgKiBAZmxhZ3M6IHVudXNlZAo+ICAgKgo+ICAgKiBXcml0ZSByaW5nIGNv
bW1hbmRzIHRvIGV4ZWN1dGUgdGhlIGluZGlyZWN0IGJ1ZmZlci4KPiAgICovCj4gLS0KPiAyLjI1
LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
ZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
