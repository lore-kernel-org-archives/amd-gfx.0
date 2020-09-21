Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABC1C4363C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 21:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F3D23A60
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 21:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onO4H/S0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F3D23A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD596E041;
	Mon, 21 Sep 2020 21:32:48 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0D06E041
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 21:32:46 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id l9so969111wme.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qkWlyy+1QF3mVF4MUAd3mnRVGPp9vGEe9Bk+q2PHLY8=;
 b=onO4H/S0lDLhIPyXlZq38JGkDsxtOm1FwK9/1dthQWlfI13nE7Ocn7LJ/9uQGWlBHI
 TWhiB4w1eSExSn1wXGvHKIx+YDrYIkU+QL36hoD6kUeLNe9E82N/om23oNKzwbLAva4u
 0EAJaeRlfLulFylj3/fYKOOkX5MOp0W8bfeIZuJ3AaY0jr78WCdvrM3H2GOdXQI0e1P3
 8JIMZQjfIKF6XmBJlU5LZvmTzrRgwcnPwKGqikvK4Z882lbb6SoXQZ+GY2Asko20eujd
 8cpO0FOcdYMc7uA8q3IRt9yCOcGX1ZeUGwauJlAXMA5cvHPKinv+S/eqNBSZGg/tBWAl
 vdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qkWlyy+1QF3mVF4MUAd3mnRVGPp9vGEe9Bk+q2PHLY8=;
 b=EQSAdzZ9a9oWAbl7a3is3e8HhggtwAfAcXA/CvoS84KXTgNhHdLWIpcPSHDnGtB5DD
 ji+87YH/WG9fZW7TPP/5C9dgRkEAYAyNBKU3MiXF5PktzhCpvzSMw7vut9H7BVp+Y23D
 pDtBcl4cF0rLdSyBuC5PxeqSEaCsPGnThsMKahWyNjZXjdNJuJgHxIrSFMJZCa7vinQT
 +Q1T8Hf583Eup9GtFLvxUuVzW5KRgy7GAaEqF5CahMcey5CF/W3+3HeXBSyLw/sIe6d4
 S8f+NZvCB9SIyZELtbJusrBamvqA/yoqnCdOWRJWIo6RvsSmDYrEqrfSGmOvArGIQGV2
 CFPQ==
X-Gm-Message-State: AOAM532x6t4ogbTnCXuDLW5RI9mOzPvT3DooXg+zltKF+fZYdklNuB/A
 GNQ5hdQEALMM72By8taiDxIByQGpVRRsQkLPWnkoNDmM
X-Google-Smtp-Source: ABdhPJzeSmzsZQ9Ej/I6rcmiU7s4Qb3THIo+QqTa/df1ZcAn6yu/KVykkwysEcRQso9qywLY53yw+fQg7HoGRehbg8Q=
X-Received: by 2002:a7b:c090:: with SMTP id r16mr1277310wmh.56.1600723964553; 
 Mon, 21 Sep 2020 14:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200921212026.364094-1-alexander.deucher@amd.com>
In-Reply-To: <20200921212026.364094-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2020 17:32:33 -0400
Message-ID: <CADnq5_M58bpM9WjFbM9NrmhwVVwtzyvFGC-3ev5J=kHaLBfs4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix wanting in print statement
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Indhcm5pbmciIGluIHByaW50IHN0YXRlbWVudC4gIEZpeGVkIGxvY2FsbHkuCgpPbiBNb24sIFNl
cCAyMSwgMjAyMCBhdCA1OjIwIFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
PiB3cm90ZToKPgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfY3Jh
dC5jOiBJbiBmdW5jdGlvbiDigJhrZmRfY3JlYXRlX2NyYXRfaW1hZ2VfdmlydHVhbOKAmToKPiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQuYzoxMzkxOjEyOiB3
YXJuaW5nOiBmb3JtYXQg4oCYJWTigJkgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlIOKAmGludOKA
mSwgYnV0IGFyZ3VtZW50IDMgaGFzIHR5cGUg4oCYc2l6ZV904oCZIHtha2Eg4oCYbG9uZyB1bnNp
Z25lZCBpbnTigJl9IFstV2Zvcm1hdD1dCj4gIDEzOTEgfCAgIHByX2RlYnVnKCJDUkFUIHNpemUg
aXMgJWQiLCBkeW5fc2l6ZSk7Cj4gICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
Cj4gLi9pbmNsdWRlL2xpbnV4L3ByaW50ay5oOjI5NzoyMTogbm90ZTogaW4gZGVmaW5pdGlvbiBv
ZiBtYWNybyDigJhwcl9mbXTigJkKPiAgIDI5NyB8ICNkZWZpbmUgcHJfZm10KGZtdCkgZm10Cj4g
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF5+fgo+IC4vaW5jbHVkZS9saW51eC9keW5hbWlj
X2RlYnVnLmg6MTQzOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX2R5bmFtaWNf
ZnVuY19jYWxs4oCZCj4gICAxNDMgfCAgX19keW5hbWljX2Z1bmNfY2FsbChfX1VOSVFVRV9JRChk
ZGVidWcpLCBmbXQsIGZ1bmMsICMjX19WQV9BUkdTX18pCj4gICAgICAgfCAgXn5+fn5+fn5+fn5+
fn5+fn5+fgo+IC4vaW5jbHVkZS9saW51eC9keW5hbWljX2RlYnVnLmg6MTUzOjI6IG5vdGU6IGlu
IGV4cGFuc2lvbiBvZiBtYWNybyDigJhfZHluYW1pY19mdW5jX2NhbGzigJkKPiAgIDE1MyB8ICBf
ZHluYW1pY19mdW5jX2NhbGwoZm10LCBfX2R5bmFtaWNfcHJfZGVidWcsICBcCj4gICAgICAgfCAg
Xn5+fn5+fn5+fn5+fn5+fn5+Cj4gLi9pbmNsdWRlL2xpbnV4L3ByaW50ay5oOjQyMDoyOiBub3Rl
OiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYZHluYW1pY19wcl9kZWJ1Z+KAmQo+ICAgNDIwIHwg
IGR5bmFtaWNfcHJfZGVidWcoZm10LCAjI19fVkFfQVJHU19fKQo+ICAgICAgIHwgIF5+fn5+fn5+
fn5+fn5+fn4KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQu
YzoxMzkxOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhwcl9kZWJ1Z+KAmQo+ICAx
MzkxIHwgICBwcl9kZWJ1ZygiQ1JBVCBzaXplIGlzICVkIiwgZHluX3NpemUpOwo+ICAgICAgIHwg
ICBefn5+fn5+fgo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2FtZGtmZC9rZmRfY3Jh
dC5jOjEzOTE6Mjc6IG5vdGU6IGZvcm1hdCBzdHJpbmcgaXMgZGVmaW5lZCBoZXJlCj4gIDEzOTEg
fCAgIHByX2RlYnVnKCJDUkFUIHNpemUgaXMgJWQiLCBkeW5fc2l6ZSk7Cj4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICAgfl4KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfAo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQKPiAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAlbGQKPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NyYXQuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX2NyYXQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMK
PiBpbmRleCBjNTBlOWY2MzRkNmMuLmQyOTgxNTI0ZGJhMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2NyYXQuYwo+IEBAIC0xMzg4LDcgKzEzODgsNyBAQCBpbnQga2ZkX2NyZWF0
ZV9jcmF0X2ltYWdlX3ZpcnR1YWwodm9pZCAqKmNyYXRfaW1hZ2UsIHNpemVfdCAqc2l6ZSwKPiAg
ICAgICAgICAgICAgICAgaWYgKCFwY3JhdF9pbWFnZSkKPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVOT01FTTsKPiAgICAgICAgICAgICAgICAgKnNpemUgPSBkeW5fc2l6ZTsKPiAt
ICAgICAgICAgICAgICAgcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAlZCIsIGR5bl9zaXplKTsKPiAr
ICAgICAgICAgICAgICAgcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAlbGQiLCBkeW5fc2l6ZSk7Cj4g
ICAgICAgICAgICAgICAgIHJldCA9IGtmZF9jcmVhdGVfdmNyYXRfaW1hZ2VfY3B1KHBjcmF0X2lt
YWdlLCBzaXplKTsKPiAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gICAgICAgICBjYXNlIENPTVBV
VEVfVU5JVF9HUFU6Cj4gLS0KPiAyLjI1LjQKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
