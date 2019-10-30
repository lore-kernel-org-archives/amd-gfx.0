Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99D8CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29C320874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 14:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29C320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7046EA17;
	Wed, 30 Oct 2019 14:00:22 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B4E6EA17
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 14:00:20 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a15so2419049wrf.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 07:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WRmOLNs+m8WsvDRZXiZ/Qz6rZ/WzggeY8SF6hJzd3zI=;
 b=ugWX9EvVHQcqNXxJk+RQxfyZeSojPyTBeVUZ6WawfeH+NaVqnug7A6TbxaE1Plzoqa
 0t+aaX+EB3rAvTL0acD6g4xWQzpZgiTM8iYjQYbSaqutXREbTlRNHxMzQ6rITtzlJhHZ
 hrljxp14UIUP4NLXwM8en9HX+kfNPX5qqaTRjsFUBKgBHk9j5TvEtpWCUiTvrIUwQerd
 vxuraDx9qOVTV1e57SzWDH1KAN4d2i0STG/KZYFIuFeJ1JjmMrFGJc+vZAlzXZ2pqmqx
 R1smrsUTJ92i5tD7PJGuQ+bXKKdSp6hbqWUtGNQpCXuVtNNdN2kuvhNtckeBKKQBcbNG
 MMEA==
X-Gm-Message-State: APjAAAW+pdTGRdbUtOFdX/myB85VyfQ1nAwUw7r1Qb4ADvtalbRjIFF8
 FFJt8CrAxNZ5bhzZ+N8RKb12Ybukhca9djiBs0k=
X-Google-Smtp-Source: APXvYqzf7t5YiVLjx1Jl9an29gd+hAbPWj8sUkolxo/ymB+LZdw6QThRBtTlWn3RDvApOoymhdrIIQTzbKFl8gHAgyE=
X-Received: by 2002:adf:828c:: with SMTP id 12mr49781wrc.40.1572444019135;
 Wed, 30 Oct 2019 07:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191029113635.16161-1-xiaojie.yuan@amd.com>
In-Reply-To: <20191029113635.16161-1-xiaojie.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Oct 2019 10:00:07 -0400
Message-ID:
 <CADnq5_N+aUssBh6WSxUEMZTuAk-7j+CgCwSg2coQhJnGpWL4vQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx10: fix mqd backup/restore for gfx rings
To: "Yuan, Xiaojie" <Xiaojie.Yuan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=WRmOLNs+m8WsvDRZXiZ/Qz6rZ/WzggeY8SF6hJzd3zI=;
 b=mOan7zN/04N60HpjywKJZHaxm89LMxYajvjNpczaE3X3Au+3BrpykZggn4ktno0XXY
 6SJLl9U8lOnAT8fW/y93Kx9ymygc+kiSYhGaa3wdb1JjZx8yjWYGt1xFcV1B9RLo+kQh
 gSMBrTvaisbwmrm0kydE3kEOCFcX5QlV5mixGz75M1oItHvBdtDTq8s1DB4AuTmAuBGF
 hCt+Uj201c36krSXBQ3FE/nVKLHuRKarEPWfvMnwTyjpsDiyS/DZRUhjUeCcwO5+3UOK
 gz/LyCZEepMvnX/3yiSmhuU8gPu3DIHGZii88xQfSjRJwcggxkeN1s2o21ZMz9s3fzQT
 Z3qw==
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
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030140007.BfRvSLABtJiAroP1sYXihzGCvMl77qHdGP82py7wFZ4@z>

T24gVHVlLCBPY3QgMjksIDIwMTkgYXQgNzozNyBBTSBZdWFuLCBYaWFvamllIDxYaWFvamllLll1
YW5AYW1kLmNvbT4gd3JvdGU6Cj4KPiAxLiBubyBuZWVkIHRvIGFsbG9jYXRlIGFuIGV4dHJhIG1l
bWJlciBmb3IgJ21xZF9iYWNrdXAnIGFycmF5Cj4gMi4gYmFja3VwL3Jlc3RvcmUgbXFkIHRvL2Zy
b20gdGhlIGNvcnJlY3QgJ21xZF9iYWNrdXAnIGFycmF5IHNsb3QKPgo+IFNpZ25lZC1vZmYtYnk6
IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+CgpBY2tlZC1ieTogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2dmeC5oIHwgMiArLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYyAgfCA5ICsrKysrLS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2Z4LmgKPiBpbmRleCA0NTlhYTkwNTk1NDIuLjZkMTllNzg5MTQ5MSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmgKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Z4LmgKPiBAQCAtMjI1LDcgKzIyNSw3IEBA
IHN0cnVjdCBhbWRncHVfbWUgewo+ICAgICAgICAgdWludDMyX3QgICAgICAgICAgICAgICAgICAg
ICAgICBudW1fbWU7Cj4gICAgICAgICB1aW50MzJfdCAgICAgICAgICAgICAgICAgICAgICAgIG51
bV9waXBlX3Blcl9tZTsKPiAgICAgICAgIHVpbnQzMl90ICAgICAgICAgICAgICAgICAgICAgICAg
bnVtX3F1ZXVlX3Blcl9waXBlOwo+IC0gICAgICAgdm9pZCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqbXFkX2JhY2t1cFtBTURHUFVfTUFYX0dGWF9SSU5HUyArIDFdOwo+ICsgICAgICAgdm9p
ZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAqbXFkX2JhY2t1cFtBTURHUFVfTUFYX0dGWF9S
SU5HU107Cj4KPiAgICAgICAgIC8qIFRoZXNlIGFyZSB0aGUgcmVzb3VyY2VzIGZvciB3aGljaCBh
bWRncHUgdGFrZXMgb3duZXJzaGlwICovCj4gICAgICAgICBERUNMQVJFX0JJVE1BUChxdWV1ZV9i
aXRtYXAsIEFNREdQVV9NQVhfR0ZYX1FVRVVFUyk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3YxMF8wLmMKPiBpbmRleCBlZjE5NzVhNTMyM2EuLjJjNWRjOWI1OGUyMyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gQEAgLTMwNzUsNiArMzA3NSw3IEBA
IHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2dmeF9pbml0X3F1ZXVlKHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZykKPiAgewo+ICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5h
ZGV2Owo+ICAgICAgICAgc3RydWN0IHYxMF9nZnhfbXFkICptcWQgPSByaW5nLT5tcWRfcHRyOwo+
ICsgICAgICAgaW50IG1xZF9pZHggPSByaW5nIC0gJmFkZXYtPmdmeC5nZnhfcmluZ1swXTsKPgo+
ICAgICAgICAgaWYgKCFhZGV2LT5pbl9ncHVfcmVzZXQgJiYgIWFkZXYtPmluX3N1c3BlbmQpIHsK
PiAgICAgICAgICAgICAgICAgbWVtc2V0KCh2b2lkICopbXFkLCAwLCBzaXplb2YoKm1xZCkpOwo+
IEBAIC0zMDg2LDEyICszMDg3LDEyIEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX2dmeF9pbml0X3F1
ZXVlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgI2VuZGlmCj4gICAgICAgICAgICAgICAg
IG52X2dyYm1fc2VsZWN0KGFkZXYsIDAsIDAsIDAsIDApOwo+ICAgICAgICAgICAgICAgICBtdXRl
eF91bmxvY2soJmFkZXYtPnNyYm1fbXV0ZXgpOwo+IC0gICAgICAgICAgICAgICBpZiAoYWRldi0+
Z2Z4Lm1lLm1xZF9iYWNrdXBbQU1ER1BVX01BWF9HRlhfUklOR1NdKQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIG1lbWNweShhZGV2LT5nZngubWUubXFkX2JhY2t1cFtBTURHUFVfTUFYX0dGWF9S
SU5HU10sIG1xZCwgc2l6ZW9mKCptcWQpKTsKPiArICAgICAgICAgICAgICAgaWYgKGFkZXYtPmdm
eC5tZS5tcWRfYmFja3VwW21xZF9pZHhdKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG1lbWNw
eShhZGV2LT5nZngubWUubXFkX2JhY2t1cFttcWRfaWR4XSwgbXFkLCBzaXplb2YoKm1xZCkpOwo+
ICAgICAgICAgfSBlbHNlIGlmIChhZGV2LT5pbl9ncHVfcmVzZXQpIHsKPiAgICAgICAgICAgICAg
ICAgLyogcmVzZXQgbXFkIHdpdGggdGhlIGJhY2t1cCBjb3B5ICovCj4gLSAgICAgICAgICAgICAg
IGlmIChhZGV2LT5nZngubWUubXFkX2JhY2t1cFtBTURHUFVfTUFYX0dGWF9SSU5HU10pCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KG1xZCwgYWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBb
QU1ER1BVX01BWF9HRlhfUklOR1NdLCBzaXplb2YoKm1xZCkpOwo+ICsgICAgICAgICAgICAgICBp
ZiAoYWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBbbXFkX2lkeF0pCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgbWVtY3B5KG1xZCwgYWRldi0+Z2Z4Lm1lLm1xZF9iYWNrdXBbbXFkX2lkeF0sIHNpemVv
ZigqbXFkKSk7Cj4gICAgICAgICAgICAgICAgIC8qIHJlc2V0IHRoZSByaW5nICovCj4gICAgICAg
ICAgICAgICAgIHJpbmctPndwdHIgPSAwOwo+ICAgICAgICAgICAgICAgICBhbWRncHVfcmluZ19j
bGVhcl9yaW5nKHJpbmcpOwo+IC0tCj4gMi4yMC4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
