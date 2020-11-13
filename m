Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E50C61DD8
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704262222F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4jQUyvQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704262222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D156E5CE;
	Fri, 13 Nov 2020 17:27:57 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02856E5CD;
 Fri, 13 Nov 2020 17:27:55 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id u12so3544895wrt.0;
 Fri, 13 Nov 2020 09:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Aoo3XC1xgkYP3AILMBs2qRa84a7jg1GfVsNZfCCxg90=;
 b=r4jQUyvQq8wNfbGuxU+JtPca5mypNLnmvOXEMwng+VCakuiFj8gz9iosMJm7gJUXqy
 3abfKQCGunVWsmPZBfSVR123NsiqQKdGql142pa6Q4+bWhT1ibLbEnuUQewH0dso5PBX
 0iJmYnEXsuw9wWmqvRSwbtEXzIsQjdzwOLhy/mx0lyVBUqaV6mujatZH6A8+HDKJfIr/
 BRl/FMeW0LHfufZhrwCaYEC3SEOfNOIkUd/vTr75+b1fnMEQc7LjnnKPTn7FsXCnK+5R
 fOxlnuZVM1nQ95LtjzaMUq/RCkw7YtmrNp8VboKMK49R+OYs/bZMBTDTI0aq/rxvFOn3
 UECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Aoo3XC1xgkYP3AILMBs2qRa84a7jg1GfVsNZfCCxg90=;
 b=qWxkBaTuacywy9LtE9FCsgHu7r8RksIhkQehi2l+aRZeJrxEL+DJK867ak0RSL27YY
 UUiTMf++GIlJSKkVgaFffAecsKyTAyr388gXcGhirQMmjGun3mGg9/AgHLJHtOEHFTLl
 FavwubqmI8v/jt1egpQ67iiYrmYh6Qnk49j9e7HZ4LYcA65Bd/HUtwa4LLK/RQNPyQ1K
 5P/1rvMsrkLVSF8Gq6zAv4FTMEZltUed5sev1xoWB4FtubTUcv71jQecEYuTbVa1wrbM
 y4l/oD9BC+MW0inqOAwYWJEASYdjQCKM1ZKJFVgg0BXh3JCWRC7dPxXTCtkQyPtoBJNy
 +KMA==
X-Gm-Message-State: AOAM533cMsI3Wgsd26vBNAo/4nroX9H5GmY2xEPZfXp++K9vjkW+q3Wz
 +dJT3fPcg3Gag/RhY/2fmyTkv5RviKvGqYyA1Ks=
X-Google-Smtp-Source: ABdhPJyU763L3HQHIS0PPLGIYKDLP9HCwyeqI8Bd+rjzwFY33/WRlgaDonxguETxNniMFVJGuSnI8DtIIg1RJPZiRng=
X-Received: by 2002:adf:8028:: with SMTP id 37mr4685613wrk.111.1605288469699; 
 Fri, 13 Nov 2020 09:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-26-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-26-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:27:38 -0500
Message-ID: <CADnq5_NN81LB=FiwRnALOV3PWZKjicZh93BaBEcO=D_E1wHn0w@mail.gmail.com>
Subject: Re: [PATCH 25/40] drm/amd/amdgpu/amdgpu_debugfs: Demote obvious abuse
 of kernel-doc formatting
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

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmM6MzA4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdmJyBub3QgZGVz
Y3JpYmVkIGluICdhbWRncHVfZGVidWdmc19yZWdzX3JlYWQnCj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmM6MzA4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0
ZXIgb3IgbWVtYmVyICdidWYnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9kZWJ1Z2ZzX3JlZ3Nf
cmVhZCcKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYzozMDg6
IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3NpemUnIG5vdCBkZXNjcmli
ZWQgaW4gJ2FtZGdwdV9kZWJ1Z2ZzX3JlZ3NfcmVhZCcKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RlYnVnZnMuYzozMDg6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBv
ciBtZW1iZXIgJ3Bvcycgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X2RlYnVnZnNfcmVnc19yZWFk
Jwo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jOjMxNzogd2Fy
bmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZicgbm90IGRlc2NyaWJlZCBpbiAn
YW1kZ3B1X2RlYnVnZnNfcmVnc193cml0ZScKPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RlYnVnZnMuYzozMTc6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1i
ZXIgJ2J1Zicgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X2RlYnVnZnNfcmVnc193cml0ZScKPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYzozMTc6IHdhcm5pbmc6
IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3NpemUnIG5vdCBkZXNjcmliZWQgaW4gJ2Ft
ZGdwdV9kZWJ1Z2ZzX3JlZ3Nfd3JpdGUnCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZWJ1Z2ZzLmM6MzE3OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVy
ICdwb3MnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9kZWJ1Z2ZzX3JlZ3Nfd3JpdGUnCj4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5vcmc+Cj4gQ2M6IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1z
aWdAbGlzdHMubGluYXJvLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYyB8IDQgKystLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCj4gaW5kZXggNWMxZjM3MjVjNzQxMC4uYTY2
NjdhMmNhMGRiMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGVidWdmcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
YnVnZnMuYwo+IEBAIC0zMDAsNyArMzAwLDcgQEAgc3RhdGljIGludCAgYW1kZ3B1X2RlYnVnZnNf
cHJvY2Vzc19yZWdfb3AoYm9vbCByZWFkLCBzdHJ1Y3QgZmlsZSAqZiwKPiAgICAgICAgIHJldHVy
biByZXN1bHQ7Cj4gIH0KPgo+IC0vKioKPiArLyoKPiAgICogYW1kZ3B1X2RlYnVnZnNfcmVnc19y
ZWFkIC0gQ2FsbGJhY2sgZm9yIHJlYWRpbmcgTU1JTyByZWdpc3RlcnMKPiAgICovCj4gIHN0YXRp
YyBzc2l6ZV90IGFtZGdwdV9kZWJ1Z2ZzX3JlZ3NfcmVhZChzdHJ1Y3QgZmlsZSAqZiwgY2hhciBf
X3VzZXIgKmJ1ZiwKPiBAQCAtMzA5LDcgKzMwOSw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9k
ZWJ1Z2ZzX3JlZ3NfcmVhZChzdHJ1Y3QgZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwKPiAgICAg
ICAgIHJldHVybiBhbWRncHVfZGVidWdmc19wcm9jZXNzX3JlZ19vcCh0cnVlLCBmLCBidWYsIHNp
emUsIHBvcyk7Cj4gIH0KPgo+IC0vKioKPiArLyoKPiAgICogYW1kZ3B1X2RlYnVnZnNfcmVnc193
cml0ZSAtIENhbGxiYWNrIGZvciB3cml0aW5nIE1NSU8gcmVnaXN0ZXJzCj4gICAqLwo+ICBzdGF0
aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19yZWdzX3dyaXRlKHN0cnVjdCBmaWxlICpmLCBjb25z
dCBjaGFyIF9fdXNlciAqYnVmLAo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
