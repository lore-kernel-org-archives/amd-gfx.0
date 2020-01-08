Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F095C00523
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 10:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AA020692
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 10:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO6l4ZTY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AA020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DCE6E886;
	Wed,  8 Jan 2020 10:19:28 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0312A6E886
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 10:19:27 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d139so16160924wmd.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=abIkF3jSIGQY9KmdzaVzHsSGCYstJ8ljAla4Na3j13Q=;
 b=HO6l4ZTYtIXgq3BaPacSBf7vMZVtgy5WjP/G9kyzw6DzDFOUEHl+V68S/Fra8XR9QA
 zlYsD8VMowVgoiJ7uOOybfm0FRRMrcn51EFpCEIubaZuxX7UjjAJgE/DmVz1z/KhRjU+
 IDWKsTKCgyrfVU7qNyB2l35ShSIWR7ZKpAkVWwN5mk+97ma6GDvIhhJD/NBQ44Xz1LvG
 y/9vThIqdWN4XWRlZ0MYIODXFLVDh4XwZquQZqqPyIqLrvuAQxEL2Q65+Fd2L1vy8nuM
 rqHw7xnoEupfwWTggEHjoOJL3ZGbRnH1bYtc1bWzgIwHKavU2DXqNIsmmVvCA3vFxs7V
 dakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=abIkF3jSIGQY9KmdzaVzHsSGCYstJ8ljAla4Na3j13Q=;
 b=CZxbDVbqZ5JVcArMg0qmCM9FiF0x0OJ45e0yutOnvoDJxyjO/ygmTlbFN/0Kq20i8B
 cXabtgHQHnGjInF6Q9g/Jr1BGR0AAD8v4BCPAIjIAknphbTyrXy/rWbcvC33z4kPzhji
 Y+cw31kQP0nKD2hw7IAD/7y/e5NXWgzKaHZSmVgKqZMOO+oHVNeK6utOuO1w5sRiRuEL
 G2ZkYVrAF1ax4XYxvexMnqNLHJKpgAGQYSOCi1e31dia24uiFUN895pO1IiQ4alFZopB
 YSaM9rfGtdJLkQcbTl+WY4B2qvmrCSu4B16E9p5U5e3QMfYV1wiQtxZ/OyeFyLalcdVE
 N47g==
X-Gm-Message-State: APjAAAUKN5aCt/wNPZdkcE757B2b88cB/Si0AXcnfy0mOEyU7UQmUdnV
 UwhWApj5nUCLK9glwOOdAJU=
X-Google-Smtp-Source: APXvYqxH0Y3NGZXG4nxe6I5YQyBu/q6L/jLu8Fexy49hx8klyku/kIh4s8eVfRueSLNia5CgtjyCNA==
X-Received: by 2002:a1c:61c1:: with SMTP id v184mr2907011wmb.160.1578478766664; 
 Wed, 08 Jan 2020 02:19:26 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t81sm3378331wmg.6.2020.01.08.02.19.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 02:19:25 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu: enable S/G display on PCO and RV2
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200107211320.1820393-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <43f09121-e188-17f6-8039-6b61e0063df0@gmail.com>
Date: Wed, 8 Jan 2020 11:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107211320.1820393-1-alexander.deucher@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDcuMDEuMjAgdW0gMjI6MTMgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gSXQgc2hvdWxkIHdv
cmsgb24gYWxsIFJhdmVuIHZhcmlhbnRzLCBidXQgc29tZSB1c2VycyBoYXZlCj4gcmVwb3J0ZWQg
aXNzdWVzIHdpdGggb3JpZ2luYWwgUmF2ZW4gd2l0aCBJT01NVSBlbmFibGVkLgo+IFNvIGZhciB0
aGVyZSBoYXZlIGJlZW4gbm8gaXNzdWVzIG9ic2VydmVkIHdpdGggUENPIG9yIFJWMi4KPgo+IFNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiAt
LS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgICB8IDIy
ICsrKysrKysrKysrKysrLS0tLS0KPiAgIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uYyB8IDE4ICsrKysrKysrKystLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
OCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYwo+IGluZGV4IDRlNjk5MDcxZDE0NC4uNmQ1MjBhM2Vl
YzQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNw
bGF5LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5j
Cj4gQEAgLTUxMywxMyArNTEzLDIzIEBAIHVpbnQzMl90IGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRl
ZF9kb21haW5zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCSAqIHdpbGwgbm90IGFs
bG93IFVTV0MgbWFwcGluZ3MuCj4gICAJICogQWxzbywgZG9uJ3QgYWxsb3cgR1RUIGRvbWFpbiBp
ZiB0aGUgQk8gZG9lbnMndCBoYXZlIFVTV0MgZmFsZyBzZXQuCj4gICAJICovCj4gLQlpZiAoYWRl
di0+YXNpY190eXBlID49IENISVBfQ0FSUklaTyAmJgo+IC0JICAgIGFkZXYtPmFzaWNfdHlwZSA8
IENISVBfUkFWRU4gJiYKPiAtCSAgICAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVKSAmJgo+IC0J
ICAgIChib19mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQykgJiYKPiArCWlm
ICgoYm9fZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0MpICYmCj4gICAJICAg
IGFtZGdwdV9ib19zdXBwb3J0X3Vzd2MoYm9fZmxhZ3MpICYmCj4gLQkgICAgYW1kZ3B1X2Rldmlj
ZV9hc2ljX2hhc19kY19zdXBwb3J0KGFkZXYtPmFzaWNfdHlwZSkpCj4gLQkJZG9tYWluIHw9IEFN
REdQVV9HRU1fRE9NQUlOX0dUVDsKPiArCSAgICBhbWRncHVfZGV2aWNlX2FzaWNfaGFzX2RjX3N1
cHBvcnQoYWRldi0+YXNpY190eXBlKSkgewo+ICsJCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7
Cj4gKwkJY2FzZSBDSElQX0NBUlJJWk86Cj4gKwkJY2FzZSBDSElQX1NUT05FWToKPiArCQkJZG9t
YWluIHw9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKPiArCQkJYnJlYWs7Cj4gKwkJY2FzZSBDSElQ
X1JBVkVOOgo+ICsJCQkvKiBlbmFibGUgUy9HIG9uIFBDTyBhbmQgUlYyICovCj4gKwkJCWlmIChh
ZGV2LT5yZXZfaWQgPj0gMHg4IHx8IGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDE1ZDgpCj4gKwkJ
CQlkb21haW4gfD0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOwo+ICsJCQlicmVhazsKPiArCQlkZWZh
dWx0Ogo+ICsJCQlicmVhazsKPiArCQl9Cj4gKwl9Cj4gICAjZW5kaWYKPiAgIAo+ICAgCXJldHVy
biBkb21haW47Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbS5jCj4gaW5kZXggYjk5OGIwMzgyNDc3Li4wNTExOGM4ODYwZjkgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMK
PiBAQCAtOTA2LDEzICs5MDYsMTkgQEAgc3RhdGljIGludCBhbWRncHVfZG1faW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAo+ICAgCWluaXRfZGF0YS5kY2VfZW52aXJvbm1lbnQg
PSBEQ0VfRU5WX1BST0RVQ1RJT05fRFJWOwo+ICAgCj4gLQkvKgo+IC0JICogVE9ETyBkZWJ1ZyB3
aHkgdGhpcyBkb2Vzbid0IHdvcmsgb24gUmF2ZW4KPiAtCSAqLwo+IC0JaWYgKGFkZXYtPmZsYWdz
ICYgQU1EX0lTX0FQVSAmJgo+IC0JICAgIGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX0NBUlJJWk8g
JiYKPiAtCSAgICBhZGV2LT5hc2ljX3R5cGUgPCBDSElQX1JBVkVOKQo+ICsJc3dpdGNoIChhZGV2
LT5hc2ljX3R5cGUpIHsKPiArCWNhc2UgQ0hJUF9DQVJSSVpPOgo+ICsJY2FzZSBDSElQX1NUT05F
WToKPiAgIAkJaW5pdF9kYXRhLmZsYWdzLmdwdV92bV9zdXBwb3J0ID0gdHJ1ZTsKPiArCQlicmVh
azsKPiArCWNhc2UgQ0hJUF9SQVZFTjoKPiArCQkvKiBlbmFibGUgUy9HIG9uIFBDTyBhbmQgUlYy
ICovCj4gKwkJaWYgKGFkZXYtPnJldl9pZCA+PSAweDggfHwgYWRldi0+cGRldi0+ZGV2aWNlID09
IDB4MTVkOCkKPiArCQkJaW5pdF9kYXRhLmZsYWdzLmdwdV92bV9zdXBwb3J0ID0gdHJ1ZTsKPiAr
CQlicmVhazsKPiArCWRlZmF1bHQ6Cj4gKwkJYnJlYWs7Cj4gKwl9CgpJdCBtaWdodCBiZSBhIGdv
b2QgaWRlYSB0byBlbmFibGUgZ3B1X3ZtX3N1cHBvcnQgaW5kZXBlbmRlbnQgYW55d2F5LgoKTWln
aHQgYmUgZXZlbiBhIGdvb2QgaWRlYSB0byBkbyB0aGlzIGluIGEgc2VwYXJhdGUgcGF0Y2guCgpC
dXQgZWl0aGVyIHdheSBJJ20gbm90IGFuIGV4cGVydCBvbiBob3cgdGhlIGhhcmR3YXJlIHdvcmtz
IGluIHRoaXMgYXJlYSwgCnNvIEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+IGZvciB0aGlzIHNlcmllcyAKZWl0aGVyIHdheS4KClJlZ2FyZHMsCkNo
cmlzdGlhbi4KCj4gICAKPiAgIAlpZiAoYW1kZ3B1X2RjX2ZlYXR1cmVfbWFzayAmIERDX0ZCQ19N
QVNLKQo+ICAgCQlpbml0X2RhdGEuZmxhZ3MuZmJjX3N1cHBvcnQgPSB0cnVlOwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
