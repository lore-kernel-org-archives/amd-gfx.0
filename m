Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4C7C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA1E20719
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 13:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngFMRuzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA1E20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51CD5890BD;
	Tue, 22 Sep 2020 13:59:32 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60BE78931F
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 13:59:16 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id g4so17182106wrs.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dRV0ptCejs4aHcaiSvW7yfL+uYBE590Kx4bqbhYweiQ=;
 b=ngFMRuzHzzyop6asn4wwWDKPYnLjpZswNr9rXpCny2wANoB/9sFUwlF6U3EQQo/IJi
 9UA8abPzbvJXNyO2KcYZQdps3W1QBSoe0LIdc7D+jcYBwB2Tun2lueFDendfjPCRY4ZA
 81R232CPWeMiSVwoRYYWcPWFiX+KvnwE/xq58a9e2F5xXsTWuZepeTazE6CjjVVHtLgI
 NUwOoIRqytaXxS29PdJoP6Xqz7XfDFM//9cWIskuJhQtAjCMqVUTaBFW3Skcn4404tUf
 vdBzC3ruYFVKNbAE4Yx5DJKxOQ0C+MD4WRmc5vO8WE8CwmFf1ttOFfDlhwvjK5isHjk0
 olyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dRV0ptCejs4aHcaiSvW7yfL+uYBE590Kx4bqbhYweiQ=;
 b=aLDn648FpxPEKmn3vxq+0MFwo10i+rvihCxdxMV/maEoGreOsY5Qq2Z3ggG4Z36wub
 c0aqruTWuLCQT8JeW8pdlHxQG21NNIoT7QmZJLbSPmdH0L0JylvFxDalc9DAl/EVzN5s
 7iIg7aQ2gn1et55TaRx/jx3uvcXjT48srJ/tKFl9ZlCs/OzerrtCzQzduUw6MDqflqeo
 ADa2wmeOnGzRQbcgUvkgaCX7sQ8yq+IGFXYn+DJdA1t+JCbZTc6xOnECvXY/V1166c1v
 BpRQrlA2Z5kSQw7NIktJ2pawD7Gfp4x1sZiX0ZQA3GIwwioIJ6u+llcGKOKt9q2hH8aS
 Q6/Q==
X-Gm-Message-State: AOAM532fOmKXPV3r/96HL1rmBXEUqzVpVQz217FTRyvxVYTJoJx54EN7
 FrvigEMp9fWbO9ZVxRu+UoT17uLj2GCnbA8tz3s=
X-Google-Smtp-Source: ABdhPJyDJsBqNPqqmxZJOlQSuCH5rVe6XgvFICCl2cKLApsW3pDxFCrFBKEscdtdZjqDiswsGIr6XcME8mKrGySDSm0=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr5556727wrr.111.1600783155099; 
 Tue, 22 Sep 2020 06:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200921212026.364094-1-alexander.deucher@amd.com>
 <CADnq5_M58bpM9WjFbM9NrmhwVVwtzyvFGC-3ev5J=kHaLBfs4Q@mail.gmail.com>
 <DM6PR12MB3721639FE926748D47E245F2853B0@DM6PR12MB3721.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3721639FE926748D47E245F2853B0@DM6PR12MB3721.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2020 09:59:03 -0400
Message-ID: <CADnq5_OHSmBu4Jk5nsy_O8SVdA0Cs-S0GSt+tQV_SHqY+hKUzw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix wanting in print statement
To: "Russell, Kent" <Kent.Russell@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q2FuIEkgZ2V0IGFuIFJCPwoKT24gVHVlLCBTZXAgMjIsIDIwMjAgYXQgOTo1NiBBTSBSdXNzZWxs
LCBLZW50IDxLZW50LlJ1c3NlbGxAYW1kLmNvbT4gd3JvdGU6Cj4KPiBbQU1EIFB1YmxpYyBVc2Vd
Cj4KPiBUaGFua3MgQWxleCwgc29ycnkgYWJvdXQgdGhhdCEKPgo+ICBLZW50Cj4KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gPiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnPiBPbiBCZWhhbGYgT2YgQWxleCBEZXVjaGVyCj4gPiBTZW50
OiBNb25kYXksIFNlcHRlbWJlciAyMSwgMjAyMCA1OjMzIFBNCj4gPiBUbzogYW1kLWdmeCBsaXN0
IDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4KPiA+IENjOiBEZXVjaGVyLCBBbGV4YW5k
ZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+Cj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vYW1ka2ZkOiBmaXggd2FudGluZyBpbiBwcmludCBzdGF0ZW1lbnQKPiA+Cj4gPiAid2Fybmlu
ZyIgaW4gcHJpbnQgc3RhdGVtZW50LiAgRml4ZWQgbG9jYWxseS4KPiA+Cj4gPiBPbiBNb24sIFNl
cCAyMSwgMjAyMCBhdCA1OjIwIFBNIEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
PiB3cm90ZToKPiA+ID4KPiA+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1ka2Zk
L2tmZF9jcmF0LmM6IEluIGZ1bmN0aW9uCj4gPiDigJhrZmRfY3JlYXRlX2NyYXRfaW1hZ2Vfdmly
dHVhbOKAmToKPiA+ID4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1ka2ZkL2tmZF9j
cmF0LmM6MTM5MToxMjogd2FybmluZzogZm9ybWF0IOKAmCVk4oCZCj4gPiBleHBlY3RzIGFyZ3Vt
ZW50IG9mIHR5cGUg4oCYaW504oCZLCBidXQgYXJndW1lbnQgMyBoYXMgdHlwZSDigJhzaXplX3Ti
gJkge2FrYSDigJhsb25nIHVuc2lnbmVkIGludOKAmX0gWy0KPiA+IFdmb3JtYXQ9XQo+ID4gPiAg
MTM5MSB8ICAgcHJfZGVidWcoIkNSQVQgc2l6ZSBpcyAlZCIsIGR5bl9zaXplKTsKPiA+ID4gICAg
ICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+Cj4gPiA+IC4vaW5jbHVkZS9saW51eC9w
cmludGsuaDoyOTc6MjE6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8g4oCYcHJfZm104oCZ
Cj4gPiA+ICAgMjk3IHwgI2RlZmluZSBwcl9mbXQoZm10KSBmbXQKPiA+ID4gICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgIF5+fgo+ID4gPiAuL2luY2x1ZGUvbGludXgvZHluYW1pY19kZWJ1Zy5o
OjE0MzoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8KPiA+IOKAmF9fZHluYW1pY19mdW5j
X2NhbGzigJkKPiA+ID4gICAxNDMgfCAgX19keW5hbWljX2Z1bmNfY2FsbChfX1VOSVFVRV9JRChk
ZGVidWcpLCBmbXQsIGZ1bmMsICMjX19WQV9BUkdTX18pCj4gPiA+ICAgICAgIHwgIF5+fn5+fn5+
fn5+fn5+fn5+fn4KPiA+ID4gLi9pbmNsdWRlL2xpbnV4L2R5bmFtaWNfZGVidWcuaDoxNTM6Mjog
bm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvCj4gPiDigJhfZHluYW1pY19mdW5jX2NhbGzigJkK
PiA+ID4gICAxNTMgfCAgX2R5bmFtaWNfZnVuY19jYWxsKGZtdCwgX19keW5hbWljX3ByX2RlYnVn
LCAgXAo+ID4gPiAgICAgICB8ICBefn5+fn5+fn5+fn5+fn5+fn4KPiA+ID4gLi9pbmNsdWRlL2xp
bnV4L3ByaW50ay5oOjQyMDoyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCYZHluYW1p
Y19wcl9kZWJ1Z+KAmQo+ID4gPiAgIDQyMCB8ICBkeW5hbWljX3ByX2RlYnVnKGZtdCwgIyNfX1ZB
X0FSR1NfXykKPiA+ID4gICAgICAgfCAgXn5+fn5+fn5+fn5+fn5+fgo+ID4gPiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQuYzoxMzkxOjM6IG5vdGU6IGluIGV4
cGFuc2lvbiBvZiBtYWNybwo+ID4g4oCYcHJfZGVidWfigJkKPiA+ID4gIDEzOTEgfCAgIHByX2Rl
YnVnKCJDUkFUIHNpemUgaXMgJWQiLCBkeW5fc2l6ZSk7Cj4gPiA+ICAgICAgIHwgICBefn5+fn5+
fgo+ID4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9hbWRrZmQva2ZkX2NyYXQuYzox
MzkxOjI3OiBub3RlOiBmb3JtYXQgc3RyaW5nIGlzCj4gPiBkZWZpbmVkIGhlcmUKPiA+ID4gIDEz
OTEgfCAgIHByX2RlYnVnKCJDUkFUIHNpemUgaXMgJWQiLCBkeW5fc2l6ZSk7Cj4gPiA+ICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgIH5eCj4gPiA+ICAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8Cj4gPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQKPiA+ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgJWxkCj4gPiA+Cj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
PiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jIHwg
MiArLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
Cj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
Y3JhdC5jCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPiA+ID4g
aW5kZXggYzUwZTlmNjM0ZDZjLi5kMjk4MTUyNGRiYTAgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYwo+ID4gPiBAQCAtMTM4OCw3ICsxMzg4LDcgQEAgaW50
IGtmZF9jcmVhdGVfY3JhdF9pbWFnZV92aXJ0dWFsKHZvaWQgKipjcmF0X2ltYWdlLCBzaXplX3QK
PiA+ICpzaXplLAo+ID4gPiAgICAgICAgICAgICAgICAgaWYgKCFwY3JhdF9pbWFnZSkKPiA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4gPiA+ICAgICAgICAgICAg
ICAgICAqc2l6ZSA9IGR5bl9zaXplOwo+ID4gPiAtICAgICAgICAgICAgICAgcHJfZGVidWcoIkNS
QVQgc2l6ZSBpcyAlZCIsIGR5bl9zaXplKTsKPiA+ID4gKyAgICAgICAgICAgICAgIHByX2RlYnVn
KCJDUkFUIHNpemUgaXMgJWxkIiwgZHluX3NpemUpOwo+ID4gPiAgICAgICAgICAgICAgICAgcmV0
ID0ga2ZkX2NyZWF0ZV92Y3JhdF9pbWFnZV9jcHUocGNyYXRfaW1hZ2UsIHNpemUpOwo+ID4gPiAg
ICAgICAgICAgICAgICAgYnJlYWs7Cj4gPiA+ICAgICAgICAgY2FzZSBDT01QVVRFX1VOSVRfR1BV
Ogo+ID4gPiAtLQo+ID4gPiAyLjI1LjQKPiA+ID4KPiA+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+ID4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpc3RzLmZyZWVkZXNrdG9w
Lm9yCj4gPiBnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLQo+ID4gZ2Z4JmFtcDtkYXRhPTAy
JTdDMDElN0NrZW50LnJ1c3NlbGwlNDBhbWQuY29tJTdDNjExZmMyNTczNWUwNDFmYmQzZDcwOGQ4
NWU3NQo+ID4gZTM1NSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAl
N0M2MzczNjMyMDc3MjE3Mzc3NjYmYW1wOwo+ID4gc2RhdGE9QnZNUkNQWUswV3VYVEpBb3ROTUZm
RzdsQm4ydDRkWW9nRFVvUlpRclRkQSUzRCZhbXA7cmVzZXJ2ZWQ9MApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
