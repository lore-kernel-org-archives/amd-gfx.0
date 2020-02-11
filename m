Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03757C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 09:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA64320714
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 09:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ps/IiMNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA64320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6415B6E245;
	Tue, 11 Feb 2020 09:46:52 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351996E245
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 09:46:51 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m16so11370093wrx.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 01:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=NAG7aRGv5aiJOiJLa/iDSv31FEn4kWeUGnD9CWS9tKM=;
 b=ps/IiMNyhXnRPrFMYYaKwegv44PL8yELxtQChPcbf3xkdjBGlB8j55s5GP0vMeca0A
 2qGKJ7Yhluo5lNRUd6SIpul27ZwHR3brQnxltP/3O5bl8ekz+E2EJI8aOvtf5VtRoseR
 x3v5OhfawgAKirCzdAU54xP9HMpPvcpWh0i2has7yMiXSxMNBQv19d48f29SJDQ3iWSS
 d/SvowIdVLEe80ataFRJmq41ciZTgG5oCxOmUuYL2Ze4v5KeCInIIlZg+51LQd1AzkUa
 OZ0WhqtESTmv2F4b/OgAvyRKW9bE1UvQhSYhQFfqK5J+/eoe1dTOnbnwx3b+pURYDDd6
 Hyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=NAG7aRGv5aiJOiJLa/iDSv31FEn4kWeUGnD9CWS9tKM=;
 b=qoqyOPoXfDrICb54MWginEXxslOcr1i93zy3o5E12e9CpKllyS88HE72fkvWE2qV/S
 ambDbICbT/FpVNllKWK1lDUEOL/C/1vp5VqkVgfhzGJeC8JWtcjivCFQDaqR+9L7FqEp
 H85gxLWAn1KZQ3VWK/y95JpUvqiwAPcJzCxOXmq6kzNH6UIyo10Nf+X6sNVP9OX68PWw
 DWlD70P2pe6mpwmckRoNvbXo5r5dRTnAHnx+8FFY9/ttrAJzyurpcNMqszySPA2Mx5pt
 dofYIYI/3gKHv0+oeGPuk8uC+mXGlvhDyDMQHPXf1r9b5DCCwM4YKr/V/ocYizWMgGFo
 +qbw==
X-Gm-Message-State: APjAAAWzvHW6VATouTu1x46fe4Ba5MzmSppjRlKDg7bBx9vCapn/LDSQ
 BJa4lAwOY86xvxgSEltjACZp8me4
X-Google-Smtp-Source: APXvYqzKCxkHRdLiDuKBMYPTcgyJ9LdbKlZm3+6yaZO5Z4ddMEImX4o0NEoSbMJSyrgrdKmUupqe1g==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr7514655wrm.248.1581414409822; 
 Tue, 11 Feb 2020 01:46:49 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b16sm2871700wmj.39.2020.02.11.01.46.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Feb 2020 01:46:49 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Do not move root PT bo to relocated list
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200211023245.3092-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <21e97807-d7ad-8181-89da-eae0da17628a@gmail.com>
Date: Tue, 11 Feb 2020 10:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200211023245.3092-1-xinhui.pan@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDIuMjAgdW0gMDM6MzIgc2NocmllYiB4aW5odWkgcGFuOgo+IEFzIHJvb3QgUEQgaGFz
IG5vIHBhcmVudCwgd2UganVzdCBuZWVkIG1vdmUgaXRzIHN0YXR1cyB0byBpZGxlLgo+Cj4gU3Vn
Z2VzdGVkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4g
U2lnbmVkLW9mZi1ieTogeGluaHVpIHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+IENDOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMzQgKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggY2M1
NmVhYmExOTExLi4wYmUyOTNlYjI3NzMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYwo+IEBAIC0yMjksMTkgKzIyOSw2IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9i
b19ldmljdGVkKHN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqdm1fYm8pCj4gICAJZWxzZQo+ICAg
CQlsaXN0X21vdmVfdGFpbCgmdm1fYm8tPnZtX3N0YXR1cywgJnZtLT5ldmljdGVkKTsKPiAgIH0K
PiAtCj4gLS8qKgo+IC0gKiBhbWRncHVfdm1fYm9fcmVsb2NhdGVkIC0gdm1fYm8gaXMgcmVsb2Fj
dGVkCj4gLSAqCj4gLSAqIEB2bV9ibzogdm1fYm8gd2hpY2ggaXMgcmVsb2NhdGVkCj4gLSAqCj4g
LSAqIFN0YXRlIGZvciBQRHMvUFRzIHdoaWNoIG5lZWRzIHRvIHVwZGF0ZSB0aGVpciBwYXJlbnQg
UEQuCj4gLSAqLwo+IC1zdGF0aWMgdm9pZCBhbWRncHVfdm1fYm9fcmVsb2NhdGVkKHN0cnVjdCBh
bWRncHVfdm1fYm9fYmFzZSAqdm1fYm8pCj4gLXsKPiAtCWxpc3RfbW92ZSgmdm1fYm8tPnZtX3N0
YXR1cywgJnZtX2JvLT52bS0+cmVsb2NhdGVkKTsKPiAtfQo+IC0KPiAgIC8qKgo+ICAgICogYW1k
Z3B1X3ZtX2JvX21vdmVkIC0gdm1fYm8gaXMgbW92ZWQKPiAgICAqCj4gQEAgLTI4NCw2ICsyNzEs
MjIgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2JvX2ludmFsaWRhdGVkKHN0cnVjdCBhbWRncHVf
dm1fYm9fYmFzZSAqdm1fYm8pCj4gICAJc3Bpbl91bmxvY2soJnZtX2JvLT52bS0+aW52YWxpZGF0
ZWRfbG9jayk7Cj4gICB9Cj4gICAKPiArLyoqCj4gKyAqIGFtZGdwdV92bV9ib19yZWxvY2F0ZWQg
LSB2bV9ibyBpcyByZWxvYWN0ZWQKPiArICoKPiArICogQHZtX2JvOiB2bV9ibyB3aGljaCBpcyBy
ZWxvY2F0ZWQKPiArICoKPiArICogU3RhdGUgZm9yIFBEcy9QVHMgd2hpY2ggbmVlZHMgdG8gdXBk
YXRlIHRoZWlyIHBhcmVudCBQRC4KPiArICogRm9yIHRoZSByb290IFBELCBqdXN0IG1vdmUgdG8g
aWRsZSBzdGF0ZS4KPiArICovCj4gK3N0YXRpYyB2b2lkIGFtZGdwdV92bV9ib19yZWxvY2F0ZWQo
c3RydWN0IGFtZGdwdV92bV9ib19iYXNlICp2bV9ibykKPiArewo+ICsJaWYgKHZtX2JvLT5iby0+
cGFyZW50KQo+ICsJCWxpc3RfbW92ZSgmdm1fYm8tPnZtX3N0YXR1cywgJnZtX2JvLT52bS0+cmVs
b2NhdGVkKTsKPiArCWVsc2UKPiArCQlhbWRncHVfdm1fYm9faWRsZSh2bV9ibyk7Cj4gK30KPiAr
Cj4gICAvKioKPiAgICAqIGFtZGdwdV92bV9ib19kb25lIC0gdm1fYm8gaXMgZG9uZQo+ICAgICoK
PiBAQCAtNjkxLDEwICs2OTQsNyBAQCBpbnQgYW1kZ3B1X3ZtX3ZhbGlkYXRlX3B0X2JvcyhzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sCj4gICAJCQlhbWRn
cHVfdm1fYm9fbW92ZWQoYm9fYmFzZSk7Cj4gICAJCX0gZWxzZSB7Cj4gICAJCQl2bS0+dXBkYXRl
X2Z1bmNzLT5tYXBfdGFibGUoYm8pOwo+IC0JCQlpZiAoYm8tPnBhcmVudCkKPiAtCQkJCWFtZGdw
dV92bV9ib19yZWxvY2F0ZWQoYm9fYmFzZSk7Cj4gLQkJCWVsc2UKPiAtCQkJCWFtZGdwdV92bV9i
b19pZGxlKGJvX2Jhc2UpOwo+ICsJCQlhbWRncHVfdm1fYm9fcmVsb2NhdGVkKGJvX2Jhc2UpOwo+
ICAgCQl9Cj4gICAJfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
