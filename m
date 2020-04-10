Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A9FC2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 14:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA7620A8B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 14:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2LVw8Ir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA7620A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26C06ECF8;
	Fri, 10 Apr 2020 14:52:20 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBA16ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 14:52:19 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id y24so2966373wma.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=H6a4Waha3pFDatJ+7bkmSlIc0vJ2DgD/wQN8+sLZmwI=;
 b=j2LVw8IrF5+8FQzauR0J6whZWr4zD8Sd3nkDWXHMUQdhkXo1ipg/K11oNWPNPmUaBI
 nx1NHsHcOK6kn2tNC2hyigpiPQWCsVALGqzSASuuaWEp6zwreD49q5+MpvAQLlVslrPm
 kAiiMgQcmQFnTNaBNi1hI/dFTfW4FF6LG1cAh5k8E93woerpvKPRByiXEWEZDwCCbx59
 MxduG9VZBp14g/Yw4iovDApmlrh1zKWP4co5u2jS2pu5wcuPFusxm4kMpNGPsENqyTNJ
 hKIGOBT3yOZ9DICR/yk2U2cTxfu//lH4G2WwiMAf0KajbJpR4qk45I3YAsnnrD8kH68J
 uc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=H6a4Waha3pFDatJ+7bkmSlIc0vJ2DgD/wQN8+sLZmwI=;
 b=CQZRXYsSppN8WcqfEHjpJ+D9v0fdJ806ZhfHbXTum5MgyEOUwAyD5T6ajCPZ9WrRLB
 QlYaBFMJtWJdQpP5I9Eix0VKSM+0s1pp43j2hmCx0c78QcbCDwxqNc29ng8HGwB7l2qD
 //nkGy2ZANRh8GDAmPT2I3gnAowYQ2ZxYfcIYUr8x+TsOcsjf+RC/bkWASuzOqBNyxPz
 0vgpYebj8bFLstatte5TS8uF5n31I/PnCtVGv9TswUQSuoaC9L/UsHxdwqZlufdCWNrt
 tmEaQWsBC666p+PUCzOpHrqpHEa+FvuqGcvoNcy+I2AGPdMjOiH8wbuUsO0zVPt71lLg
 VQQA==
X-Gm-Message-State: AGi0PuYZIOXI52LL/8z7qlh/gQWmvDK45kBcrZ7e6aSgtQRMnujTGG/a
 a+6SGhP6japgZu5Sgedcjfo=
X-Google-Smtp-Source: APiQypKzBCC8QJkDBjoOk2phRbnZd19D1/pOC1Gvprqf3Utruurw2nL7tVfK0LfoRgiXZoUP4a41xQ==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr5558734wmg.117.1586530338189; 
 Fri, 10 Apr 2020 07:52:18 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o67sm3242450wmo.5.2020.04.10.07.52.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:52:17 -0700 (PDT)
Subject: Re: [PATCH 1/3] drm/amdgpu/ring: add no_scheduler flag
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200410124959.1489394-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4a44933b-b1f7-4f9c-8c42-3a85a2ec78c5@gmail.com>
Date: Fri, 10 Apr 2020 16:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200410124959.1489394-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDQuMjAgdW0gMTQ6NDkgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhpcyBhbGxvd3Mg
SVBzIHRvIGZsYWcgd2hldGhlciBhIHNwZWNpZmljIHJpbmcgcmVxdWlyZXMKPiBhIEdQVSBzY2hl
ZHVsZXIgb3Igbm90LiAgRS5nLiwgc29tZXRpbWVzIGluc3RhbmNlcyBvZiBhbgo+IElQIGFyZSBh
c3ltbWV0cmljIGFuZCBoYXZlIGRpZmZlcmVudCBjYXBhYmlsaXRpZXMuCj4KPiBSZXZpZXdlZC1i
eTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IGZvciB0aGUgc2VyaWVz
LgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmMgfCAz
ICsrLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaCB8IDEgKwo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuYwo+IGluZGV4IDVmMzZiZDU4MjAy
YS4uNDg2M2U5MWM1NTMzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yaW5nLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cmluZy5jCj4gQEAgLTI2MSw3ICsyNjEsOCBAQCBpbnQgYW1kZ3B1X3JpbmdfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgCW11dGV4
X2luaXQoJnJpbmctPnByaW9yaXR5X211dGV4KTsKPiAgIAo+ICAgCWlmIChyaW5nLT5mdW5jcy0+
dHlwZSA+PSBBTURHUFVfUklOR19UWVBFX0dGWCAmJgo+IC0JICAgIHJpbmctPmZ1bmNzLT50eXBl
IDw9IEFNREdQVV9SSU5HX1RZUEVfVkNOX0pQRUcpIHsKPiArCSAgICByaW5nLT5mdW5jcy0+dHlw
ZSA8PSBBTURHUFVfUklOR19UWVBFX1ZDTl9KUEVHICYmCj4gKwkgICAgIXJpbmctPm5vX3NjaGVk
dWxlcikgewo+ICAgCQlod19pcCA9IHJpbmctPmZ1bmNzLT50eXBlOwo+ICAgCQludW1fc2NoZWQg
PSAmYWRldi0+Z3B1X3NjaGVkW2h3X2lwXVtod19wcmlvXS5udW1fc2NoZWRzOwo+ICAgCQlhZGV2
LT5ncHVfc2NoZWRbaHdfaXBdW2h3X3ByaW9dLnNjaGVkWygqbnVtX3NjaGVkKSsrXSA9Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nLmggYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmluZy5oCj4gaW5kZXggZWZkNzYyN2IzZjY5
Li5mNjE2NjRlZTQ5NDAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3JpbmcuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
aW5nLmgKPiBAQCAtMjM4LDYgKzIzOCw3IEBAIHN0cnVjdCBhbWRncHVfcmluZyB7Cj4gICAJdW5z
aWduZWQJCXZtX2ludl9lbmc7Cj4gICAJc3RydWN0IGRtYV9mZW5jZQkqdm1pZF93YWl0Owo+ICAg
CWJvb2wJCQloYXNfY29tcHV0ZV92bV9idWc7Cj4gKwlib29sCQkJbm9fc2NoZWR1bGVyOwo+ICAg
Cj4gICAJYXRvbWljX3QJCW51bV9qb2JzW0RSTV9TQ0hFRF9QUklPUklUWV9NQVhdOwo+ICAgCXN0
cnVjdCBtdXRleAkJcHJpb3JpdHlfbXV0ZXg7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
