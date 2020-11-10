Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5414C388F7
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39DDF206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 21:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3d3ZNCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39DDF206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD55B89C9C;
	Tue, 10 Nov 2020 21:15:52 +0000 (UTC)
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733AF89C53;
 Tue, 10 Nov 2020 21:15:51 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id 19so3079748wmf.1;
 Tue, 10 Nov 2020 13:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pxsubSKIzvYm5GX7ose/r3DE5/fWORy3pWS1sa1asC8=;
 b=J3d3ZNCfN7YF6oUQxAhPbQLbYF5ssw9fUrPsw1Erny85gCHm5ArDSOhL8e6GrzkF2V
 9JeD4AQJWYCoRQfs2V0FFymScYHBw5H8r3Zwld1znfWyDbdjBkJ1JYvaE/IAWtjpmqxD
 3kLPY/UcL0idZzX1FwDcHdkC51aE8IFPiVuf/2tJHadsYhY+lyNDXUFIvrIi6nXXksHY
 bQfC5VlGLRnrJdSFlWP7BklZeiN/yF34YfdTy/Ce/MiqXSmNfNUfrj70okVFqetyYhAZ
 y60GsdcKDpfcBi2vOBro24XjrNSyje7VF0xYxIZW++18Pp3lqsmkA1CJiayKcQwbUYvh
 Wo4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pxsubSKIzvYm5GX7ose/r3DE5/fWORy3pWS1sa1asC8=;
 b=bvu7cmhoQil4/hq/WMQx2qJ+8zQLuhOy4E3n7ZjdWbKG9cFdU3u6UUFsqpeP260fG/
 C2HjSJFzMciSyWjAbFDb9OvThIj0qD7Ph+dJmWL9vrQoKQm+98CMlmvuAfmokwtFGOPX
 0gITC9/PhIYYvJY+PFCoUS/uUMqY8vqWX3rw438Kk05RjoT/tUHY2hSbUloE3PQypHzx
 w5pG3KkYK6g4/XrjmzraJ6bdx0TfDmWHTdByXB5NiVpYRIrtNf+fs07/IkP2brDp252c
 sTZnuDu1AcfUpoOexciV/3TIJhJ2R5wtWQ7n5b/QM5zyIRXzGiPthbFUNgZgZ0+qaDRL
 4fPQ==
X-Gm-Message-State: AOAM533qR3zpY6/yJfrt7CuxVbS0dAQQ9hHtFsdKOF3AsInvixUvXqgd
 zrM4BAXcMcL2YGHs9AWRbdzBPY/TadfYIKSXWGA=
X-Google-Smtp-Source: ABdhPJwZx/rH071+rhpAeh4rIejVLAxwyHRrjLJsRtxyfqR7h/IbMSnb9CF4BixMsn8ypO3Rs314hHkuf5bB7aQf9Eo=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr28956wma.79.1605042890238;
 Tue, 10 Nov 2020 13:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-16-lee.jones@linaro.org>
In-Reply-To: <20201105144517.1826692-16-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Nov 2020 16:14:38 -0500
Message-ID: <CADnq5_PZRM0wmrcJAGfdyFqnR68gbVQK76TrHSbJJRK1t8cT8g@mail.gmail.com>
Subject: Re: [PATCH 15/19] gpu: drm: radeon: radeon_drv: Remove unused
 variable 'ret'
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
 Alex Deucher <alexander.deucher@amd.com>, Gareth Hughes <gareth@valinux.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBOb3YgNSwgMjAyMCBhdCA5OjUyIEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6Cj4KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmM6IEluIGZ1
bmN0aW9uIOKAmHJhZGVvbl9wbW9wc19ydW50aW1lX3N1c3BlbmTigJk6Cj4gIGRyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jOjQ1NTo2OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhyZXTi
gJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KPgo+IENjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBD
YzogR2FyZXRoIEh1Z2hlcyA8Z2FyZXRoQHZhbGludXguY29tPgo+IENjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQu
ICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9k
cnYuYyB8IDMgKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYu
YyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCj4gaW5kZXggNjUwNjFjOTQ5
YWVlYS4uZjVmMWNiNzAwZDg3MyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5j
Cj4gQEAgLTQ1Miw3ICs0NTIsNiBAQCBzdGF0aWMgaW50IHJhZGVvbl9wbW9wc19ydW50aW1lX3N1
c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgcGNpX2RldiAq
cGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKPiAgICAgICAgIHN0cnVjdCBkcm1fZGV2aWNlICpkcm1f
ZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwo+IC0gICAgICAgaW50IHJldDsKPgo+ICAgICAg
ICAgaWYgKCFyYWRlb25faXNfcHgoZHJtX2RldikpIHsKPiAgICAgICAgICAgICAgICAgcG1fcnVu
dGltZV9mb3JiaWQoZGV2KTsKPiBAQCAtNDYyLDcgKzQ2MSw3IEBAIHN0YXRpYyBpbnQgcmFkZW9u
X3Btb3BzX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gICAgICAgICBkcm1f
ZGV2LT5zd2l0Y2hfcG93ZXJfc3RhdGUgPSBEUk1fU1dJVENIX1BPV0VSX0NIQU5HSU5HOwo+ICAg
ICAgICAgZHJtX2ttc19oZWxwZXJfcG9sbF9kaXNhYmxlKGRybV9kZXYpOwo+Cj4gLSAgICAgICBy
ZXQgPSByYWRlb25fc3VzcGVuZF9rbXMoZHJtX2RldiwgZmFsc2UsIGZhbHNlLCBmYWxzZSk7Cj4g
KyAgICAgICByYWRlb25fc3VzcGVuZF9rbXMoZHJtX2RldiwgZmFsc2UsIGZhbHNlLCBmYWxzZSk7
Cj4gICAgICAgICBwY2lfc2F2ZV9zdGF0ZShwZGV2KTsKPiAgICAgICAgIHBjaV9kaXNhYmxlX2Rl
dmljZShwZGV2KTsKPiAgICAgICAgIHBjaV9pZ25vcmVfaG90cGx1ZyhwZGV2KTsKPiAtLQo+IDIu
MjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRl
dmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
