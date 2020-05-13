Return-Path: <SRS0=jMTE=63=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C3DC2D0F8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 07:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7008206F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2020 07:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OZiU+kRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7008206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21506E1E0;
	Wed, 13 May 2020 07:08:01 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39806E03F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 07:07:59 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id z25so12606936otq.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2020 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U5dnCZ5YNvHzHQjGscrcpq9MiALGgU67N8Jq5EBQuzw=;
 b=OZiU+kRVCLk5/6W0St2OK5Xb+p5aH38bGDJXr1TsF9faLdtdBKQuGuJ7Zp5SiMdew7
 euECR2vCo6+/20wE4jAyKXi43lO8iX735T4hub/MDAh5jbFqtfScDmRenqpoSLVd8NNf
 g8jnREjHPAvO3tUS/62IwHmPFGNzojTApT+lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U5dnCZ5YNvHzHQjGscrcpq9MiALGgU67N8Jq5EBQuzw=;
 b=pttnz9K1zfrZQP2UQYexfqaRb4KtbJmHmjNoaYfxZ2z9MwAqrLqPOcC+YlNYyevqBr
 oVb2sfv3Rgr3pf+s7Wt3l4F7ap1kqjaEP5CEp8/8LQE0dRkMDDyZo5Y8iVYqcm4QX+C3
 4ZdlK+VWz2ewbK4at9fybYiqJGIEBQF6DA76RCwyVjdKfugdfAjoVBENvJvUVio/WgaS
 8pWv+ST8FNmF0f3kmCw9tpKjgJnVCPyZbsk4G/7r2TgHXs6adF+yfBBXQWhfu03fTbfa
 IN8NMfGhaODY7H3kf0suWBJPW2owGlwk8CnzP6lo/ZnzpmDNy3/8GM4QU+vNaMHSSL9u
 J6VQ==
X-Gm-Message-State: AGi0PuYUKecoVVP25bwvbjt33Wx6RAdkD1BsNwXv6813OUMw9cKl+UK9
 mfgxJPC8NaLQyjFXVPKY3bnz6+eaFtZDP/z8tR1NmQ==
X-Google-Smtp-Source: APiQypLDDUNEGNzAQQ9b8u81ZQsefjAzdi6bm0eh+UnIE80cVeBpyFUq2uSk3Y7c5QYPc5UTCXnFi072V/n20RqH3kg=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr20636927otn.281.1589353679188; 
 Wed, 13 May 2020 00:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-10-daniel.vetter@ffwll.ch>
 <6cfd324e-0443-3a12-6a2c-25a546c68643@gmail.com>
In-Reply-To: <6cfd324e-0443-3a12-6a2c-25a546c68643@gmail.com>
From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 13 May 2020 09:07:48 +0200
Message-ID: <CAKMK7uEwrf=CqswANbKzF1veFER5mHPHcQxR1avLXJROOGpUvg@mail.gmail.com>
Subject: Re: [RFC 09/17] drm/amdgpu: use dma-fence annotations in cs_submit()
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
Cc: linux-rdma <linux-rdma@vger.kernel.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@intel.com>,
 "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXkgMTMsIDIwMjAgYXQgOTowMiBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBBbSAxMi4wNS4yMCB1bSAxMDo1
OSBzY2hyaWViIERhbmllbCBWZXR0ZXI6Cj4gPiBUaGlzIGlzIGEgYml0IHRyaWNreSwgc2luY2Ug
LT5ub3RpZmllcl9sb2NrIGlzIGhlbGQgd2hpbGUgY2FsbGluZwo+ID4gZG1hX2ZlbmNlX3dhaXQg
d2UgbXVzdCBlbnN1cmUgdGhhdCBhbHNvIHRoZSByZWFkIHNpZGUgKGkuZS4KPiA+IGRtYV9mZW5j
ZV9iZWdpbl9zaWduYWxsaW5nKSBpcyBvbiB0aGUgc2FtZSBzaWRlLiBJZiB3ZSBtaXggdGhpcyB1
cAo+ID4gbG9ja2RlcCBjb21wbGFpbnRzLCBhbmQgdGhhdCdzIGFnYWluIHdoeSB3ZSB3YW50IHRv
IGhhdmUgdGhlc2UKPiA+IGFubm90YXRpb25zLgo+ID4KPiA+IEEgbmljZSBzaWRlIGVmZmVjdCBv
ZiB0aGlzIGlzIHRoYXQgYmVjYXVzZSBvZiB0aGUgZnNfcmVjbGFpbSBwcmltaW5nCj4gPiBmb3Ig
ZG1hX2ZlbmNlX2VuYWJsZSBsb2NrZGVwIG5vdyBhdXRvbWF0aWNhbGx5IGNoZWNrcyBmb3IgdXMg
dGhhdAo+ID4gbm90aGluZyBpbiBoZXJlIGFsbG9jYXRlcyBtZW1vcnksIHdpdGhvdXQgZXZlbiBy
dW5uaW5nIGFueSB1c2VycHRyCj4gPiB3b3JrbG9hZHMuCj4gPgo+ID4gQ2M6IGxpbnV4LW1lZGlh
QHZnZXIua2VybmVsLm9yZwo+ID4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+
ID4gQ2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnCj4gPiBDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiA+IENjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4g
PiBDYzogQ2hyaXMgV2lsc29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+Cj4gPiBDYzogTWFh
cnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4KPiA+IENj
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiBTaWduZWQt
b2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWwudmV0dGVyQGludGVsLmNvbT4KPiA+IC0tLQo+
ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDUgKysrKysKPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gPiBpbmRleCA3NjUzZjYyYjFiMmQuLjZkYjNmM2M2Mjli
MCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5j
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+ID4gQEAg
LTEyMTMsNiArMTIxMyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3N1Ym1pdChzdHJ1Y3QgYW1k
Z3B1X2NzX3BhcnNlciAqcCwKPiA+ICAgICAgIHN0cnVjdCBhbWRncHVfam9iICpqb2I7Cj4gPiAg
ICAgICB1aW50NjRfdCBzZXE7Cj4gPiAgICAgICBpbnQgcjsKPiA+ICsgICAgIGJvb2wgZmVuY2Vf
Y29va2llOwo+ID4KPiA+ICAgICAgIGpvYiA9IHAtPmpvYjsKPiA+ICAgICAgIHAtPmpvYiA9IE5V
TEw7Cj4gPiBAQCAtMTIyNyw2ICsxMjI4LDggQEAgc3RhdGljIGludCBhbWRncHVfY3Nfc3VibWl0
KHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ID4gICAgICAgICovCj4gPiAgICAgICBtdXRl
eF9sb2NrKCZwLT5hZGV2LT5ub3RpZmllcl9sb2NrKTsKPiA+Cj4gPiArICAgICBmZW5jZV9jb29r
aWUgPSBkbWFfZmVuY2VfYmVnaW5fc2lnbmFsbGluZygpOwo+ID4gKwo+ID4gICAgICAgLyogSWYg
dXNlcnB0ciBhcmUgaW52YWxpZGF0ZWQgYWZ0ZXIgYW1kZ3B1X2NzX3BhcnNlcl9ib3MoKSwgcmV0
dXJuCj4gPiAgICAgICAgKiAtRUFHQUlOLCBkcm1Jb2N0bCBpbiBsaWJkcm0gd2lsbCByZXN0YXJ0
IHRoZSBhbWRncHVfY3NfaW9jdGwuCj4gPiAgICAgICAgKi8KPiA+IEBAIC0xMjY0LDEyICsxMjY3
LDE0IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3N1Ym1pdChzdHJ1Y3QgYW1kZ3B1X2NzX3BhcnNl
ciAqcCwKPiA+ICAgICAgIGFtZGdwdV92bV9tb3ZlX3RvX2xydV90YWlsKHAtPmFkZXYsICZmcHJp
di0+dm0pOwo+ID4KPiA+ICAgICAgIHR0bV9ldV9mZW5jZV9idWZmZXJfb2JqZWN0cygmcC0+dGlj
a2V0LCAmcC0+dmFsaWRhdGVkLCBwLT5mZW5jZSk7Cj4gPiArICAgICBkbWFfZmVuY2VfZW5kX3Np
Z25hbGxpbmcoZmVuY2VfY29va2llKTsKPgo+IE1obSwgdGhpcyBjb3VsZCBjb21lIGVhcmxpZXIg
aW4gdGhlb3J5LiBFLmcuIGFmdGVyIHB1c2hpbmcgdGhlIGpvYiB0bwo+IHRoZSBzY2hlZHVsZXIu
CgpZZWFoLCBJIGhhdmUgbm90IG11Y2ggY2x1ZSBhYm91dCBob3cgYW1kZ3B1IHdvcmtzIDotKSBJ
biBwcmFjdGljZSBpdApkb2Vzbid0IG1hdHRlciBtdWNoLCBzaW5jZSB0aGUgZW5jbG9zaW5nIGFk
ZXYtPm5vdGlmaWVyX2xvY2sgaXMgYSBsb3QKbW9yZSBzdHJpY3QgYWJvdXQgd2hhdCBpdCBhbGxv
d3MgdGhhbiB0aGUgZG1hX2ZlbmNlIHNpZ25hbGxpbmcgZmFrZQpsb2NrLgotRGFuaWVsCgo+Cj4g
Q2hyaXN0aWFuLgo+Cj4gPiAgICAgICBtdXRleF91bmxvY2soJnAtPmFkZXYtPm5vdGlmaWVyX2xv
Y2spOwo+ID4KPiA+ICAgICAgIHJldHVybiAwOwo+ID4KPiA+ICAgZXJyb3JfYWJvcnQ6Cj4gPiAg
ICAgICBkcm1fc2NoZWRfam9iX2NsZWFudXAoJmpvYi0+YmFzZSk7Cj4gPiArICAgICBkbWFfZmVu
Y2VfZW5kX3NpZ25hbGxpbmcoZmVuY2VfY29va2llKTsKPiA+ICAgICAgIG11dGV4X3VubG9jaygm
cC0+YWRldi0+bm90aWZpZXJfbG9jayk7Cj4gPgo+ID4gICBlcnJvcl91bmxvY2s6Cj4KCgotLSAK
RGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KKzQxICgw
KSA3OSAzNjUgNTcgNDggLSBodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
