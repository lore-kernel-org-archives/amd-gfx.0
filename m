Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED77BC35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 20:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF97C20720
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 20:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7c5tWkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF97C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FA38990D;
	Wed,  5 Feb 2020 20:59:36 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D70F58990D
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 20:59:35 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a9so4492020wmj.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 12:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zsEgbdltqLgdoSGK0ofzlJ8J8ihZgeZQpWkPWEMwvXk=;
 b=F7c5tWkGGrMEjhDKYjhe33bZlxveyBiknpmvz0Xj80HTPjbGv1Yy2lPYyz5gEbpjoL
 5H5xwATYLpwCabI5DKUCs18/MjBw+677lQigzj+rvkF6Wg0Q+T1jxZcVOst63HSzTzi1
 zqezNoFyDQBUuT96kOB60XR2MuNX4kRE9XU/m5hPgMiiYAP0+gTsv5E5bwNqPndqoj0A
 yPOxGaaIGcgX8wAflOsf6bX25VwWmXA4ekt6XooiIvZGOp8fDlQhNAsPe3bvPoG7j7rK
 HyBYk8n8OcAOAzFlmkEF4win1cQHz9M3InXkip/R8LEfcJEURmh2sx5rBlRln83GD5Ql
 9gtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zsEgbdltqLgdoSGK0ofzlJ8J8ihZgeZQpWkPWEMwvXk=;
 b=gKHdyLkTC2Qfz/xtl871iv923lw+/LPt+udT68Ro76Q4qmZfSFaf8sKYzjTOpZqxZx
 n/ajjnPpsAASy6GtL02V0if50lhjM9mPzyZrxBrSZ+ONHz3kvS5HqS6xMJMVXvY9bPkG
 QpF02xXbhTlDwzLE1840GzUwdXdIgVwMPyzlCQAcFBF64eV5fE4Wn1a+V2kpBW+gHG6/
 zAoZbxWyx3FjX94T+WaJtbkrO9+IWLaBvDTlMrxZEOJdkUYY5En+GpLBJD6uT6e4PqCk
 qGK99HMMrQcvmBFS4USVhdA5gSleNwB66HNOCHp5Hx8b1GCiETVvxNHJwjXDfHq+djYN
 Dv/w==
X-Gm-Message-State: APjAAAXITF4n1NRUvracgQngDR4+wg2CgLApKY3FLDgumrYvyHTFyxaB
 nj03AIVxGp2Dq/9dcbr7I7JfyET1I/7OsEGpYq8MOA==
X-Google-Smtp-Source: APXvYqwfnSwEkjEvXmUW5iqsEnkrBDYuT3qYQzxAm9NDNV7oHl1lZuR0yld50yWLuNvpDF0keN7VpGKlyNI7oAR+m2s=
X-Received: by 2002:a05:600c:2c53:: with SMTP id
 r19mr7698854wmg.39.1580936374544; 
 Wed, 05 Feb 2020 12:59:34 -0800 (PST)
MIME-Version: 1.0
References: <20200205152238.45258-1-christian.koenig@amd.com>
 <20200205152238.45258-4-christian.koenig@amd.com>
In-Reply-To: <20200205152238.45258-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2020 15:59:22 -0500
Message-ID: <CADnq5_NSJXM+DHvGU+3k=trZaxTbJuS2DNasLs4m=byOcNO72A@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_access_memory
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
Cc: "Kuehling, Felix" <felix.kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VyaWVzIGlzOgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPgoKT24gV2VkLCBGZWIgNSwgMjAyMCBhdCAxMDoyMiBBTSBDaHJpc3RpYW4gS8O2bmln
Cjxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBNYWtlIHVzZSBv
ZiB0aGUgYmV0dGVyIHBlcmZvcm1hbmNlIGhlcmUgYXMgd2VsbC4KPgo+IFRoaXMgcGF0Y2ggaXMg
b25seSBjb21waWxlIHRlc3RlZCEKPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jIHwgMzggKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ICAxIGZp
bGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gaW5kZXggNThkMTQzYjI0YmEwLi41Mzhj
M2I1MmI3MTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3R0bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4g
QEAgLTE1NjUsNyArMTU2NSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9hY2Nlc3NfbWVtb3J5
KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCj4KPiAgICAgICAgIHdoaWxlIChsZW4gJiYg
cG9zIDwgYWRldi0+Z21jLm1jX3ZyYW1fc2l6ZSkgewo+ICAgICAgICAgICAgICAgICB1aW50NjRf
dCBhbGlnbmVkX3BvcyA9IHBvcyAmIH4odWludDY0X3QpMzsKPiAtICAgICAgICAgICAgICAgdWlu
dDMyX3QgYnl0ZXMgPSA0IC0gKHBvcyAmIDMpOwo+ICsgICAgICAgICAgICAgICB1aW50NjRfdCBi
eXRlcyA9IDQgLSAocG9zICYgMyk7Cj4gICAgICAgICAgICAgICAgIHVpbnQzMl90IHNoaWZ0ID0g
KHBvcyAmIDMpICogODsKPiAgICAgICAgICAgICAgICAgdWludDMyX3QgbWFzayA9IDB4ZmZmZmZm
ZmYgPDwgc2hpZnQ7Cj4KPiBAQCAtMTU3NCwyMCArMTU3NCwyOCBAQCBzdGF0aWMgaW50IGFtZGdw
dV90dG1fYWNjZXNzX21lbW9yeShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJvLAo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGJ5dGVzID0gbGVuOwo+ICAgICAgICAgICAgICAgICB9Cj4KPiAt
ICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZs
YWdzKTsKPiAtICAgICAgICAgICAgICAgV1JFRzMyX05PX0tJUShtbU1NX0lOREVYLCAoKHVpbnQz
Ml90KWFsaWduZWRfcG9zKSB8IDB4ODAwMDAwMDApOwo+IC0gICAgICAgICAgICAgICBXUkVHMzJf
Tk9fS0lRKG1tTU1fSU5ERVhfSEksIGFsaWduZWRfcG9zID4+IDMxKTsKPiAtICAgICAgICAgICAg
ICAgaWYgKCF3cml0ZSB8fCBtYXNrICE9IDB4ZmZmZmZmZmYpCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgdmFsdWUgPSBSUkVHMzJfTk9fS0lRKG1tTU1fREFUQSk7Cj4gLSAgICAgICAgICAgICAg
IGlmICh3cml0ZSkgewo+IC0gICAgICAgICAgICAgICAgICAgICAgIHZhbHVlICY9IH5tYXNrOwo+
IC0gICAgICAgICAgICAgICAgICAgICAgIHZhbHVlIHw9ICgqKHVpbnQzMl90ICopYnVmIDw8IHNo
aWZ0KSAmIG1hc2s7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX05PX0tJUShtbU1N
X0RBVEEsIHZhbHVlKTsKPiAtICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICBzcGlu
X3VubG9ja19pcnFyZXN0b3JlKCZhZGV2LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7Cj4gLSAgICAg
ICAgICAgICAgIGlmICghd3JpdGUpIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICB2YWx1ZSA9
ICh2YWx1ZSAmIG1hc2spID4+IHNoaWZ0Owo+IC0gICAgICAgICAgICAgICAgICAgICAgIG1lbWNw
eShidWYsICZ2YWx1ZSwgYnl0ZXMpOwo+ICsgICAgICAgICAgICAgICBpZiAobWFzayAhPSAweGZm
ZmZmZmZmKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmFk
ZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiArICAgICAgICAgICAgICAgICAgICAgICBXUkVH
MzJfTk9fS0lRKG1tTU1fSU5ERVgsICgodWludDMyX3QpYWxpZ25lZF9wb3MpIHwgMHg4MDAwMDAw
MCk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgV1JFRzMyX05PX0tJUShtbU1NX0lOREVYX0hJ
LCBhbGlnbmVkX3BvcyA+PiAzMSk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCF3cml0
ZSB8fCBtYXNrICE9IDB4ZmZmZmZmZmYpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICBpZiAod3JpdGUpIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZhbHVl
ICY9IH5tYXNrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFsdWUgfD0gKCoo
dWludDMyX3QgKilidWYgPDwgc2hpZnQpICYgbWFzazsKPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFdSRUczMl9OT19LSVEobW1NTV9EQVRBLCB2YWx1ZSk7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJmFkZXYtPm1taW9faWR4X2xvY2ssIGZsYWdzKTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoIXdyaXRlKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2YWx1
ZSA9ICh2YWx1ZSAmIG1hc2spID4+IHNoaWZ0Owo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbWVtY3B5KGJ1ZiwgJnZhbHVlLCBieXRlcyk7Cj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgfQo+ICsgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGJ5dGVzID0gKG5vZGVzLT5zdGFydCArIG5vZGVzLT5zaXplKSA8PCBQQUdFX1NISUZUOwo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGJ5dGVzID0gbWluKHBvcyAtIGJ5dGVzLCAodWludDY0X3Qp
bGVuICYgfjB4M3VsbCk7Cj4gKwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGFtZGdwdV9kZXZp
Y2VfdnJhbV9hY2Nlc3MoYWRldiwgcG9zLCAodWludDMyX3QgKilidWYsCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBieXRlcywgd3JpdGUpOwo+ICAg
ICAgICAgICAgICAgICB9Cj4KPiAgICAgICAgICAgICAgICAgcmV0ICs9IGJ5dGVzOwo+IC0tCj4g
Mi4xNy4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
