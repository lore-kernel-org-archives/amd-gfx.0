Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B96C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824EB611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824EB611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F636F516;
	Thu, 20 May 2021 19:28:06 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0992C6F516;
 Thu, 20 May 2021 19:28:02 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 v13-20020a4ac00d0000b029020b43b918eeso4039301oop.9; 
 Thu, 20 May 2021 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4k80R92raKX44try8NOlI5SNEciXr8tCWt15U235ZOY=;
 b=u5HMyC2dzOhRwetk6bFz5gxLMOhluu4CAuFx5YJ9V3fbc/xw/CgL5YRqYjhGiyTW5n
 3AqF3gy2HlXhnwJ0kZfowlu0bDBzz2toiJdGn95DqPqVNTsAq0ZvJ8Q+HfHXnQFAJuEF
 B+gCJPmEySu7ANm9VWs7g6r1aM2vci0dafOoH+ksiVn0CwsVL6/mH8ppdwz8MJ+DT1dH
 cN2WQhb020RIVtBZqgNHNS43F6T9b8ou7Tw2j7gfAgwHfcUZzHUmMxfsECPsBFofyL2r
 nzo8wZzOG+rq6dVItNbWteQlyBTRaS5mpPUPrcawglZWe15fu50Our5mUlnK1SJ8Yxdo
 NrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4k80R92raKX44try8NOlI5SNEciXr8tCWt15U235ZOY=;
 b=XNNeTunGN9J3S58R5ygvSPe52uDTGD4mmgU38AwB+tNWzcCa0RjfK3KCKiZygD9YBb
 baguhCmE7mzkfmmWPkI8CnFy64dU/HZVlbI1O6gTfIgsN7ksAOxGb1PryAOnqLdWp79h
 mj1LyzClvTUlIvcrR/xPYG039u3B33wSsIkvdvdnlZkBigXOFAkLtjyg8JUCEM7G6zSq
 XHHCjdLIiVnSR3+0vx3IALX/cXcUaiyOp2W+hy/TDJkKntqA7Tf1nHD2asr/0Tcw4MaH
 iQV8JEmL4laIIMSMP226tt4t1NbAazvIrduGPf1151gYC7jsChYgmJK5KqGrz8Z0En9z
 tZfA==
X-Gm-Message-State: AOAM5323Hl4lEvqWVpbzufa8QEMfUZkKj0doxtsPKCh2l2yXlf5V1HZT
 Bv1y5qm27J2Pt6Oji/7/oKJbbaYG3v1xugFewCuboUuw
X-Google-Smtp-Source: ABdhPJw/G1SAe+q/1vmFaWI1wZ9doKKFcivmwBNweNkYvrpMqu9DHVkQfhze30Eo9Oia8iZcUi5SWEhoaNXsk7+gfII=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr4993114oor.61.1621538882348;
 Thu, 20 May 2021 12:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-35-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-35-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:27:51 -0400
Message-ID: <CADnq5_NqMsveaWdJGzGzx4OZ3wkHso=3T+r2RXwYBAbsFSLSOg@mail.gmail.com>
Subject: Re: [PATCH 34/38] drm/amd/amdgpu/amdgpu_vce: Fix a few incorrectly
 named functions
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDQgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNlLmM6OTg6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGFt
ZGdwdV92Y2VfaW5pdCgpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfdmNlX3N3X2luaXQoKSBp
bnN0ZWFkCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYzoyMTQ6IHdh
cm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGFtZGdwdV92Y2VfZmluaSgpLiBQcm90b3R5
cGUgd2FzIGZvciBhbWRncHVfdmNlX3N3X2ZpbmkoKSBpbnN0ZWFkCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2UuYzo1OTA6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5
cGUgZm9yIGFtZGdwdV92Y2VfY3NfdmFsaWRhdGVfYm8oKS4gUHJvdG90eXBlIHdhcyBmb3IgYW1k
Z3B1X3ZjZV92YWxpZGF0ZV9ibygpIGluc3RlYWQKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZjZS5jOjcyNDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYW1k
Z3B1X3ZjZV9jc19wYXJzZSgpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfdmNlX3JpbmdfcGFy
c2VfY3MoKSBpbnN0ZWFkCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y2Uu
Yzo5NjA6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIGFtZGdwdV92Y2VfY3NfcGFy
c2Vfdm0oKS4gUHJvdG90eXBlIHdhcyBmb3IgYW1kZ3B1X3ZjZV9yaW5nX3BhcnNlX2NzX3ZtKCkg
aW5zdGVhZAo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
PiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6
IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgo+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3Jn
Pgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwo+IENj
OiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNlLmMgfCAxMCArKysrKy0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZjZS5jCj4gaW5kZXggZWE2YTYyZjY3ZTM4MC4uN2FkODNkYTYxM2VkZCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNlLmMKPiBAQCAtODcsNyArODcsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92Y2VfZ2V0X2Rlc3Ryb3lfbXNnKHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZywgdWludDMyX3QgaGFuZGxlLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBkaXJlY3QsIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSk7Cj4KPiAgLyoq
Cj4gLSAqIGFtZGdwdV92Y2VfaW5pdCAtIGFsbG9jYXRlIG1lbW9yeSwgbG9hZCB2Y2UgZmlybXdh
cmUKPiArICogYW1kZ3B1X3ZjZV9zd19pbml0IC0gYWxsb2NhdGUgbWVtb3J5LCBsb2FkIHZjZSBm
aXJtd2FyZQo+ICAgKgo+ICAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gICAqIEBz
aXplOiBzaXplIGZvciB0aGUgbmV3IEJPCj4gQEAgLTIwNCw3ICsyMDQsNyBAQCBpbnQgYW1kZ3B1
X3ZjZV9zd19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBsb25nIHNp
emUpCj4gIH0KPgo+ICAvKioKPiAtICogYW1kZ3B1X3ZjZV9maW5pIC0gZnJlZSBtZW1vcnkKPiAr
ICogYW1kZ3B1X3ZjZV9zd19maW5pIC0gZnJlZSBtZW1vcnkKPiAgICoKPiAgICogQGFkZXY6IGFt
ZGdwdV9kZXZpY2UgcG9pbnRlcgo+ICAgKgo+IEBAIC01NzQsNyArNTc0LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfdmNlX2dldF9kZXN0cm95X21zZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVp
bnQzMl90IGhhbmRsZSwKPiAgfQo+Cj4gIC8qKgo+IC0gKiBhbWRncHVfdmNlX2NzX3ZhbGlkYXRl
X2JvIC0gbWFrZSBzdXJlIG5vdCB0byBjcm9zcyA0R0IgYm91bmRhcnkKPiArICogYW1kZ3B1X3Zj
ZV92YWxpZGF0ZV9ibyAtIG1ha2Ugc3VyZSBub3QgdG8gY3Jvc3MgNEdCIGJvdW5kYXJ5Cj4gICAq
Cj4gICAqIEBwOiBwYXJzZXIgY29udGV4dAo+ICAgKiBAaWJfaWR4OiBpbmRpcmVjdCBidWZmZXIg
dG8gdXNlCj4gQEAgLTcxNSw3ICs3MTUsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92Y2VfdmFsaWRh
dGVfaGFuZGxlKHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICB9Cj4KPiAgLyoqCj4gLSAq
IGFtZGdwdV92Y2VfY3NfcGFyc2UgLSBwYXJzZSBhbmQgdmFsaWRhdGUgdGhlIGNvbW1hbmQgc3Ry
ZWFtCj4gKyAqIGFtZGdwdV92Y2VfcmluZ19wYXJzZV9jcyAtIHBhcnNlIGFuZCB2YWxpZGF0ZSB0
aGUgY29tbWFuZCBzdHJlYW0KPiAgICoKPiAgICogQHA6IHBhcnNlciBjb250ZXh0Cj4gICAqIEBp
Yl9pZHg6IGluZGlyZWN0IGJ1ZmZlciB0byB1c2UKPiBAQCAtOTUxLDcgKzk1MSw3IEBAIGludCBh
bWRncHVfdmNlX3JpbmdfcGFyc2VfY3Moc3RydWN0IGFtZGdwdV9jc19wYXJzZXIgKnAsIHVpbnQz
Ml90IGliX2lkeCkKPiAgfQo+Cj4gIC8qKgo+IC0gKiBhbWRncHVfdmNlX2NzX3BhcnNlX3ZtIC0g
cGFyc2UgdGhlIGNvbW1hbmQgc3RyZWFtIGluIFZNIG1vZGUKPiArICogYW1kZ3B1X3ZjZV9yaW5n
X3BhcnNlX2NzX3ZtIC0gcGFyc2UgdGhlIGNvbW1hbmQgc3RyZWFtIGluIFZNIG1vZGUKPiAgICoK
PiAgICogQHA6IHBhcnNlciBjb250ZXh0Cj4gICAqIEBpYl9pZHg6IGluZGlyZWN0IGJ1ZmZlciB0
byB1c2UKPiAtLQo+IDIuMzEuMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
