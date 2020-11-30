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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA39C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:28:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF9022073C
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo2J2scH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF9022073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5242C6E90D;
	Mon, 30 Nov 2020 22:28:02 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0428F6E906;
 Mon, 30 Nov 2020 22:28:01 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id x15so654504otp.4;
 Mon, 30 Nov 2020 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xuRtX6/QiaNBrOSJvmHFpdILv2m6h3ItAI8etLSug9U=;
 b=Mo2J2scHtsnoTZFWYGhE2uXgYqBTvm9E3lZMPEU0ZVHhNVT0CrkmVWj66h4usWZ0Nc
 z1npRNGi4I4TtXoo1vAwFLj5NUCOI0EW9T+g/RtOlH3pzFj1E4e+E6O+sjvcmljF7uXf
 JFhPMsOWUFvVdWG3DYYS2ocMiS7uuWNjcYmsgyDU2AEyay6wtOze/XdTymR9YxfIi//8
 gCFAADaQlvpmzXHAn+m5WaLE4Bd0LIbVWFBxa66vgWtfO3AfDqKYgvHhDYTdOI/w9IEL
 Ej666kK4WSD7J1XxYBLgryYUnc5nQYRkZjB54xTbTrlvaYU+njufh77czUen2hiW7EPH
 S2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xuRtX6/QiaNBrOSJvmHFpdILv2m6h3ItAI8etLSug9U=;
 b=Wxl7UMKXsqjNit1/SWEFcEB19q77DJiwNclPqyiDXxf6Nhqxu43VxU+k6ThMreom+W
 mD2fU9eXZ41T9A7bFvk04JcBy9dsxWEAYdbNnOc23YWDqxjfMVD7Jc0kw2sZAhcqmbb+
 mqOYDDe2KtWP6SNZlEczBs1NsIw6D1hZrd7iwAbOhka/qe146P6zZ847srgjRRAhBoJz
 prng+cKmBHijcxa1yNbVNhRIaVI6p+h/Xep2ftCWbfJIetujniTncmvbkaIOO8UhlRsg
 9wiAJE+vJiB8/I1R8K4OMNDDlRwmHaJeSvb15Z2mGg82S/WKyjwSPEIuROnIeCCIsSY9
 XY7w==
X-Gm-Message-State: AOAM531lCif+wIcLFm3P9dy4L5zgVLnDwaFirtCBalPZpJ5yF1vcPYvS
 QWgHy+yFesqyX2nYFW0N6gtgdbigBLPbV9q2aok=
X-Google-Smtp-Source: ABdhPJy0KwDsxXP6JRVNfDVpAEFaTtaZkp9jq6qZhHXUijRsOTzPSOs6EA+yOy2zvn/Vm7oqTG3k8RZxDzhYX2QgcHg=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18762365otg.311.1606775278931; 
 Mon, 30 Nov 2020 14:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-21-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-21-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 17:27:47 -0500
Message-ID: <CADnq5_PFn-H0qEp60sBA2mUQufGnhn5awYrLRi7hfT58sJdE0w@mail.gmail.com>
Subject: Re: [PATCH 20/40] drm/amd/amdgpu/uvd_v5_0: Fix a bunch of kernel-doc
 function documentation issues
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
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NCBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmM6MTUz
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdoYW5kbGUnIG5vdCBkZXNj
cmliZWQgaW4gJ3V2ZF92NV8wX2h3X2luaXQnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3V2ZF92NV8wLmM6MTUzOiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdhZGV2
JyBkZXNjcmlwdGlvbiBpbiAndXZkX3Y1XzBfaHdfaW5pdCcKPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdXZkX3Y1XzAuYzoyMTA6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBt
ZW1iZXIgJ2hhbmRsZScgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y1XzBfaHdfZmluaScKPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYzoyMTA6IHdhcm5pbmc6IEV4Y2VzcyBm
dW5jdGlvbiBwYXJhbWV0ZXIgJ2FkZXYnIGRlc2NyaXB0aW9uIGluICd1dmRfdjVfMF9od19maW5p
Jwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jOjQ2Mzogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYWRkcicgbm90IGRlc2NyaWJlZCBpbiAndXZk
X3Y1XzBfcmluZ19lbWl0X2ZlbmNlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djVfMC5jOjQ2Mzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnc2VxJyBu
b3QgZGVzY3JpYmVkIGluICd1dmRfdjVfMF9yaW5nX2VtaXRfZmVuY2UnCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmM6NDYzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0
ZXIgb3IgbWVtYmVyICdmbGFncycgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y1XzBfcmluZ19lbWl0
X2ZlbmNlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jOjQ2Mzogd2Fy
bmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZmVuY2UnIGRlc2NyaXB0aW9uIGluICd1
dmRfdjVfMF9yaW5nX2VtaXRfZmVuY2UnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2
ZF92NV8wLmM6NTI5OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdqb2In
IG5vdCBkZXNjcmliZWQgaW4gJ3V2ZF92NV8wX3JpbmdfZW1pdF9pYicKPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYzo1Mjk6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRl
ciBvciBtZW1iZXIgJ2ZsYWdzJyBub3QgZGVzY3JpYmVkIGluICd1dmRfdjVfMF9yaW5nX2VtaXRf
aWInCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPiBDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
CgpBcHBsaWVkIHdpdGggbWlub3IgZml4ZXMuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jIHwgMTAgKysrKysrKy0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NV8wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS91dmRfdjVfMC5jCj4gaW5kZXggNmU1NzAwMWY2ZDBhYy4uM2E3NDhlYzU4
YmVjNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjVfMC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y1XzAuYwo+IEBAIC0xNDUs
NyArMTQ1LDcgQEAgc3RhdGljIGludCB1dmRfdjVfMF9zd19maW5pKHZvaWQgKmhhbmRsZSkKPiAg
LyoqCj4gICAqIHV2ZF92NV8wX2h3X2luaXQgLSBzdGFydCBhbmQgdGVzdCBVVkQgYmxvY2sKPiAg
ICoKPiAtICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgo+ICsgKiBAaGFuZGxlOiBoYW5k
bGUgdXNlZCB0byBwYXNzIGFtZGdwdV9kZXZpY2UgcG9pbnRlcgo+ICAgKgo+ICAgKiBJbml0aWFs
aXplIHRoZSBoYXJkd2FyZSwgYm9vdCB1cCB0aGUgVkNQVSBhbmQgZG8gc29tZSB0ZXN0aW5nCj4g
ICAqLwo+IEBAIC0yMDIsNyArMjAyLDcgQEAgc3RhdGljIGludCB1dmRfdjVfMF9od19pbml0KHZv
aWQgKmhhbmRsZSkKPiAgLyoqCj4gICAqIHV2ZF92NV8wX2h3X2ZpbmkgLSBzdG9wIHRoZSBoYXJk
d2FyZSBibG9jawo+ICAgKgo+IC0gKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gKyAq
IEBoYW5kbGU6IGhhbmRsZSB1c2VkIHRvIHBhc3MgYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gICAq
Cj4gICAqIFN0b3AgdGhlIFVWRCBibG9jaywgbWFyayByaW5nIGFzIG5vdCByZWFkeSBhbnkgbW9y
ZQo+ICAgKi8KPiBAQCAtNDU0LDcgKzQ1NCw5IEBAIHN0YXRpYyB2b2lkIHV2ZF92NV8wX3N0b3Ao
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAqIHV2ZF92NV8wX3JpbmdfZW1pdF9mZW5j
ZSAtIGVtaXQgYW4gZmVuY2UgJiB0cmFwIGNvbW1hbmQKPiAgICoKPiAgICogQHJpbmc6IGFtZGdw
dV9yaW5nIHBvaW50ZXIKPiAtICogQGZlbmNlOiBmZW5jZSB0byBlbWl0Cj4gKyAqIEBhZGRyOiBh
ZGRyZXNzCj4gKyAqIEBzZXE6IHNlcXVlbmNlIG51bWJlcgo+ICsgKiBAZmxhZ3M6IGZlbmNlIHJl
bGF0ZWQgZmxhZ3MKPiAgICoKPiAgICogV3JpdGUgYSBmZW5jZSBhbmQgYSB0cmFwIGNvbW1hbmQg
dG8gdGhlIHJpbmcuCj4gICAqLwo+IEBAIC01MTgsNyArNTIwLDkgQEAgc3RhdGljIGludCB1dmRf
djVfMF9yaW5nX3Rlc3RfcmluZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICAqIHV2ZF92
NV8wX3JpbmdfZW1pdF9pYiAtIGV4ZWN1dGUgaW5kaXJlY3QgYnVmZmVyCj4gICAqCj4gICAqIEBy
aW5nOiBhbWRncHVfcmluZyBwb2ludGVyCj4gKyAqIEBqb2I6IGpvYiB0byByZXRyaXZlIHZtaWQg
ZnJvbQo+ICAgKiBAaWI6IGluZGlyZWN0IGJ1ZmZlciB0byBleGVjdXRlCj4gKyAqIEBmbGFnczog
dW51c2VkCj4gICAqCj4gICAqIFdyaXRlIHJpbmcgY29tbWFuZHMgdG8gZXhlY3V0ZSB0aGUgaW5k
aXJlY3QgYnVmZmVyCj4gICAqLwo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
