Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80028C63798
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA35206C0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 16:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYlHHhi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA35206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732496E48D;
	Tue, 24 Nov 2020 16:20:24 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C6326E440;
 Tue, 24 Nov 2020 16:20:22 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z7so7092980wrn.3;
 Tue, 24 Nov 2020 08:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XRHVrvJlQ2ukq/CC/8wyIWEOQ1Yb+bvOP9mD1Riz8v8=;
 b=VYlHHhi1Gtt/tX7oWShWAUryetvvip9qc45T3ikc6wMLDImKqrr66TQDdjRbMMfdEV
 gAMKBJ1ujkmYACJK/dJcqSpP87/s+cgXLRDRi8rCB+LyLznZKZQgqIkieXhLgAgY2CWA
 bK6qY3Fq2NRxNeKTWuSIsDrakRQvB1lIkzfH9XNwXaSU0dThhF1APRerx+j7jOJSvz9+
 uolBab+CCLKegHH/+NboVq1zwKJErR0gRgyZngI5zebT5dVWn9Hub0P/YPBrlXIAXArX
 4kpFe8b/xZlauX8pgqtKEm5c5BlBQqKb4vXS/g06n5C7XdZX4fO3LNk0TB8tltQzsrEW
 xh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XRHVrvJlQ2ukq/CC/8wyIWEOQ1Yb+bvOP9mD1Riz8v8=;
 b=TFEzw1hAaenPA5bmnyEr1T/D1617CdDa8gExprSzuLjK5QJKewBSJHp6JSMw0KdffS
 Pep3YG3l6F11ANbXUczA5e/Io0ebRh6o1VxhmRnX+8g8FMc+5CL/CfZck8u7mHhzfq9+
 8yW1ofkq82LJHQICuuDrR5d5o3eDINceN8gTZOaS2i15+TK328EfSYodDuOvhUT+ucCm
 OooU5/RFpR0K1TKHCLqdWoE3gSHqa96wHKLvpKVXsK/WroS7vvleZQIV3sqKTDjcneaa
 0U1DSL2c7vkjbfURq43RyX+FNZqD5WJPlsG4a6XGegCBo7jfhMI7MPvvOUJ8t0YvKR5z
 C+KA==
X-Gm-Message-State: AOAM532YPXjshzhaXYWzkkjObG08CegbwQI/MCYavX9JrWBU8ZJ1wYuI
 xl6hcZ0leJGmYlqPFVtoGcmTLePFhuatsrWEVPA=
X-Google-Smtp-Source: ABdhPJysvdibjEh6/FdZavSHyPtReDD/t7W/CQ8sXKWCu4ZRVqycdledwmcNtHDNrhY3dA2LcoqUh3N/pbTWlJgXkY0=
X-Received: by 2002:adf:e551:: with SMTP id z17mr6217281wrm.374.1606234821414; 
 Tue, 24 Nov 2020 08:20:21 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-35-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-35-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Nov 2020 11:20:09 -0500
Message-ID: <CADnq5_M6xVdz7R85K5MZkGeYfrQYXm+Rk7e3RkXawhy=L4WyNQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/amdgpu/uvd_v4_2: Add one and remove another
 function param description
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

T24gTW9uLCBOb3YgMjMsIDIwMjAgYXQgNjoyMCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmM6NDQ4
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmbGFncycgbm90IGRlc2Ny
aWJlZCBpbiAndXZkX3Y0XzJfcmluZ19lbWl0X2ZlbmNlJwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS91dmRfdjRfMi5jOjQ0ODogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRl
ciAnZmVuY2UnIGRlc2NyaXB0aW9uIGluICd1dmRfdjRfMl9yaW5nX2VtaXRfZmVuY2UnCj4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djRfMi5jCj4gaW5kZXggMmM4YzM1YzNiY2E1Mi4uYmYzZDFjNjM3MzliOCAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYwo+IEBAIC00MzksNyArNDM5LDcgQEAgc3RhdGlj
IHZvaWQgdXZkX3Y0XzJfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgICogQHJp
bmc6IGFtZGdwdV9yaW5nIHBvaW50ZXIKPiAgICogQGFkZHI6IGFkZHJlc3MKPiAgICogQHNlcTog
c2VxdWVuY2UgbnVtYmVyCj4gLSAqIEBmZW5jZTogZmVuY2UgdG8gZW1pdAo+ICsgKiBAZmxhZ3M6
IGZlbmNlIHJlbGF0ZWQgZmxhZ3MKPiAgICoKPiAgICogV3JpdGUgYSBmZW5jZSBhbmQgYSB0cmFw
IGNvbW1hbmQgdG8gdGhlIHJpbmcuCj4gICAqLwo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5n
IGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
