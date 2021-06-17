Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C47C2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 15:26:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A706120A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 15:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A706120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9BE96E92D;
	Thu, 17 Jun 2021 15:26:54 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26566E929
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 15:26:53 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id i13so4556303edb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Km5LnsTDOkt6a88GymQ7/joM8b/VVxsysgCSO2T3CBk=;
 b=nK6DMWwCNPv21DsTkHl0VfZFFvgpG2ySLqleJIZbCDxzGRGV55+lLrW7OFnlM2VaXF
 T85qLbvgyNf69FTY4NrmoizfU3VrhHTPzOtTH+H0MVZ3Z54xdI4c2a9mWvaexuLkH0wd
 No9AJ/QNIm1JyDrW9iWRFmlbG8SLOwy75veDpYKclbDHZMYJasj3QquTOYs/jlqJQ2sn
 VC9bV4EIiH4thlDhUqGN6pBmlxzbYTuRIlaXI86JM2S7ZUPn19+JBWJzBuNMYWEklrgp
 VsJq+udmgXZIhCp89qGvkVwD+/fWOD6jgiNWYfJIHhmj56xSEIlAb93sScoiwiBIBHmQ
 L5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Km5LnsTDOkt6a88GymQ7/joM8b/VVxsysgCSO2T3CBk=;
 b=XYwUW16LY6Ay6bkutkJCIStZedsHFO4Qqs7bKYH5E4nNqhUkV3wNe2ziReNHCKs2ye
 wtbx0/yknR/a6Vy6xnQkWyteybVZk0QnIpbTHuS0AXei89I2Hv/zKhReW8mSmKsRAlDw
 QfVNITZTmMWuYORlE/GIUftvnSySl8c0C3zMM3TAlJ9sbEQ6sVKE7PPWYl0hCenJn75Y
 qJcyeoqsyitZaBXNT9FxymAqVqpTjSL+GswIS26CzvyU9GY0oZz8rTD90hxCrmw4XrLW
 Ue1Z5cDJTzjPrH8UBvUXN23TdRi2ZlS2QLsviEFDYIlTbIHtutMKPkHROFpJWsQtO82D
 DF4w==
X-Gm-Message-State: AOAM530ZSDizcfYR6FFKtjXjtHjja6Vv7DB/uFqTQvDsStjqPdXgwEpB
 VaLKXstgLMtO1CIgTabHm9wSj/v4C/8=
X-Google-Smtp-Source: ABdhPJwmSGl808dJLjU0EBrZPgXAQACFk7OY3DD4vlsluUvw5fLLXYaagB2skGHGtWuzhGipBPfz6Q==
X-Received: by 2002:a05:6402:34cc:: with SMTP id
 w12mr7160083edc.195.1623943612417; 
 Thu, 17 Jun 2021 08:26:52 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:f467:b59f:5497:b18f?
 ([2a02:908:1252:fb60:f467:b59f:5497:b18f])
 by smtp.gmail.com with ESMTPSA id v8sm4547647edc.59.2021.06.17.08.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jun 2021 08:26:51 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: remove unused parameter in amdgpu_gart_bind
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210617140948.2558103-1-yifan1.zhang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4e364b43-7cfd-1a34-9537-e40bdac0ad05@gmail.com>
Date: Thu, 17 Jun 2021 17:26:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617140948.2558103-1-yifan1.zhang@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDYuMjEgdW0gMTY6MDkgc2NocmllYiBZaWZhbiBaaGFuZzoKPiBBZnRlciBjb21taXQg
NzJhNjE2YmI5NTMzMjliZDk3YzZkNmQ0YzY0ZjNmNDBlZDc4OGEzNiwKPiBwYWdlbGlzdCBpcyBu
byBsb25nIHVzZWQgaW4gYW1kZ3B1X2dhcnRfYmluZC4gUmVtb3ZlIGl0Lgo+Cj4gU2lnbmVkLW9m
Zi1ieTogWWlmYW4gWmhhbmcgPHlpZmFuMS56aGFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5jIHwgMyArLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmggfCAzICstLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jICB8IDcgKysrLS0tLQo+ICAgMyBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMKPiBpbmRleCAxMDkxZWM1ZDM1OTIuLjlmYmQxZTYyOTQ4
YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYwo+IEBAIC0z
MDAsNyArMzAwLDYgQEAgaW50IGFtZGdwdV9nYXJ0X21hcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgdWludDY0X3Qgb2Zmc2V0LAo+ICAgICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRl
cgo+ICAgICogQG9mZnNldDogb2Zmc2V0IGludG8gdGhlIEdQVSdzIGdhcnQgYXBlcnR1cmUKPiAg
ICAqIEBwYWdlczogbnVtYmVyIG9mIHBhZ2VzIHRvIGJpbmQKPiAtICogQHBhZ2VsaXN0OiBwYWdl
cyB0byBiaW5kCj4gICAgKiBAZG1hX2FkZHI6IERNQSBhZGRyZXNzZXMgb2YgcGFnZXMKPiAgICAq
IEBmbGFnczogcGFnZSB0YWJsZSBlbnRyeSBmbGFncwo+ICAgICoKPiBAQCAtMzA5LDcgKzMwOCw3
IEBAIGludCBhbWRncHVfZ2FydF9tYXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2
NF90IG9mZnNldCwKPiAgICAqIFJldHVybnMgMCBmb3Igc3VjY2VzcywgLUVJTlZBTCBmb3IgZmFp
bHVyZS4KPiAgICAqLwo+ICAgaW50IGFtZGdwdV9nYXJ0X2JpbmQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHVpbnQ2NF90IG9mZnNldCwKPiAtCQkgICAgIGludCBwYWdlcywgc3RydWN0IHBh
Z2UgKipwYWdlbGlzdCwgZG1hX2FkZHJfdCAqZG1hX2FkZHIsCj4gKwkJICAgICBpbnQgcGFnZXMs
IGRtYV9hZGRyX3QgKmRtYV9hZGRyLAo+ICAgCQkgICAgIHVpbnQ2NF90IGZsYWdzKQo+ICAgewo+
ICAgCWlmICghYWRldi0+Z2FydC5yZWFkeSkgewo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dhcnQuaAo+IGluZGV4IGUxMDQwMjIxOTdhZS4uNmZmODdkZTYyMGRiIDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmgKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5oCj4gQEAgLTY0LDcgKzY0LDYg
QEAgaW50IGFtZGdwdV9nYXJ0X21hcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0
X3Qgb2Zmc2V0LAo+ICAgCQkgICAgaW50IHBhZ2VzLCBkbWFfYWRkcl90ICpkbWFfYWRkciwgdWlu
dDY0X3QgZmxhZ3MsCj4gICAJCSAgICB2b2lkICpkc3QpOwo+ICAgaW50IGFtZGdwdV9nYXJ0X2Jp
bmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90IG9mZnNldCwKPiAtCQkgICAg
IGludCBwYWdlcywgc3RydWN0IHBhZ2UgKipwYWdlbGlzdCwKPiAtCQkgICAgIGRtYV9hZGRyX3Qg
KmRtYV9hZGRyLCB1aW50NjRfdCBmbGFncyk7Cj4gKwkJICAgICBpbnQgcGFnZXMsIGRtYV9hZGRy
X3QgKmRtYV9hZGRyLCB1aW50NjRfdCBmbGFncyk7Cj4gICB2b2lkIGFtZGdwdV9nYXJ0X2ludmFs
aWRhdGVfdGxiKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAgICNlbmRpZgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRleCBlODAzM2I2ZjIzOTUuLjYy
OTczNjNhYjc0MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMK
PiBAQCAtODU3LDcgKzg1Nyw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9nYXJ0X2JpbmQoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCXVpbnQ2NF90IHBhZ2VfaWR4ID0gMTsKPiAg
IAo+ICAgCQlyID0gYW1kZ3B1X2dhcnRfYmluZChhZGV2LCBndHQtPm9mZnNldCwgcGFnZV9pZHgs
Cj4gLQkJCQl0dG0tPnBhZ2VzLCBndHQtPnR0bS5kbWFfYWRkcmVzcywgZmxhZ3MpOwo+ICsJCQkJ
Z3R0LT50dG0uZG1hX2FkZHJlc3MsIGZsYWdzKTsKPiAgIAkJaWYgKHIpCj4gICAJCQlnb3RvIGdh
cnRfYmluZF9mYWlsOwo+ICAgCj4gQEAgLTg3MSwxMSArODcxLDEwIEBAIHN0YXRpYyBpbnQgYW1k
Z3B1X3R0bV9nYXJ0X2JpbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCXIgPSBh
bWRncHVfZ2FydF9iaW5kKGFkZXYsCj4gICAJCQkJZ3R0LT5vZmZzZXQgKyAocGFnZV9pZHggPDwg
UEFHRV9TSElGVCksCj4gICAJCQkJdHRtLT5udW1fcGFnZXMgLSBwYWdlX2lkeCwKPiAtCQkJCSZ0
dG0tPnBhZ2VzW3BhZ2VfaWR4XSwKPiAgIAkJCQkmKGd0dC0+dHRtLmRtYV9hZGRyZXNzW3BhZ2Vf
aWR4XSksIGZsYWdzKTsKPiAgIAl9IGVsc2Ugewo+ICAgCQlyID0gYW1kZ3B1X2dhcnRfYmluZChh
ZGV2LCBndHQtPm9mZnNldCwgdHRtLT5udW1fcGFnZXMsCj4gLQkJCQkgICAgIHR0bS0+cGFnZXMs
IGd0dC0+dHRtLmRtYV9hZGRyZXNzLCBmbGFncyk7Cj4gKwkJCQkgICAgIGd0dC0+dHRtLmRtYV9h
ZGRyZXNzLCBmbGFncyk7Cj4gICAJfQo+ICAgCj4gICBnYXJ0X2JpbmRfZmFpbDoKPiBAQCAtOTUx
LDcgKzk1MCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3R0bV9iYWNrZW5kX2JpbmQoc3RydWN0IHR0
bV9kZXZpY2UgKmJkZXYsCj4gICAJLyogYmluZCBwYWdlcyBpbnRvIEdBUlQgcGFnZSB0YWJsZXMg
Ki8KPiAgIAlndHQtPm9mZnNldCA9ICh1NjQpYm9fbWVtLT5zdGFydCA8PCBQQUdFX1NISUZUOwo+
ICAgCXIgPSBhbWRncHVfZ2FydF9iaW5kKGFkZXYsIGd0dC0+b2Zmc2V0LCB0dG0tPm51bV9wYWdl
cywKPiAtCQl0dG0tPnBhZ2VzLCBndHQtPnR0bS5kbWFfYWRkcmVzcywgZmxhZ3MpOwo+ICsJCWd0
dC0+dHRtLmRtYV9hZGRyZXNzLCBmbGFncyk7Cj4gICAKPiAgIAlpZiAocikKPiAgIAkJRFJNX0VS
Uk9SKCJmYWlsZWQgdG8gYmluZCAldSBwYWdlcyBhdCAweCUwOGxsWFxuIiwKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
