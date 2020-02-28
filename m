Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6954C3F2CF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 08:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A38246A2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 08:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e50eJLVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A38246A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5146EE55;
	Fri, 28 Feb 2020 08:22:20 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCAC6EE55
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 08:22:19 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a141so2230177wme.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2020 00:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=b7ul7ZloNp40j5GNOt8AJcyOOZgSMl4BDB08Ygysy0Y=;
 b=e50eJLVBsv0UCvvWjo0XTIMcoFi5FLh+6DWINbUNVdHNhg1pqt4inGIQPbV3700XUL
 Be4+cXIK655bNVh/4yYjEg54C8G/7fbMvSFD/4EXOyCH93uIz2+Ly9HlPa8EyHKb46/d
 Ijds9KKNd9o7d++IsOFIv8e5OCVKlCqOJzRLHZt27XdCD/6Zce0TZRm0TDVZoHHWJlaS
 I5Ojjfx9EdN3pkESrFu19pNHfiGk5GlIauHc4ell9RnhG+m5iuvnywF8F+2z+EVtIHiD
 h8I5ZFawnVq4mrvEe/gAy0YwmjNFfjSiz6SsKHrJEDCxVcQb26dD+Txy7IU31nnyvP7O
 JiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=b7ul7ZloNp40j5GNOt8AJcyOOZgSMl4BDB08Ygysy0Y=;
 b=XVJFn0pta1pDObCBRxuvDjjxxZ+coGQ3NpBmit0OWMGmOZ/PIFOmNxwNrRYPGg3jAT
 g+J2RHk9h97tj9JO1eDHzbGKr1KSUXR2102LhFfndiSOWszTrmkrCvFSvSXTYCoBROmP
 JWmKtzGz9iqEVy71dYyKVhneKZAy7xpaANDSeL9sXFBBn9/UTEMbuVYT5+0J4rzYI5Yv
 FvUJxE2o7y1l9Hy3LI7ZcYHTi8vkTjzCeQqEEOU9wQaDPFzRrZrKJo0zLtzBYea4Cl8Q
 8mZs5tSMTh7TNyHzafRHhzhbZJ3VxKKIruaTxmY3c+t3jDZ9xqEfnEz2bCQfS8HCdydV
 rTcg==
X-Gm-Message-State: APjAAAVyTVXNz/kuEvPzGBRBPgjogbElAOq9lYiRdk6nxV24alHEKWjB
 r35IOyXi1td4kScMrHP/mKdl+PTW
X-Google-Smtp-Source: APXvYqyFz6Wrr8tW03YGAXFiXCdWqOPNJTE72nFiJifoYJ6gLG4QPPhEG3aHIa0kAM2NJaUj2KC+Qg==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr3687264wmt.137.1582878138145; 
 Fri, 28 Feb 2020 00:22:18 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x12sm1102794wmc.20.2020.02.28.00.22.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Feb 2020 00:22:17 -0800 (PST)
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx: fix indentation in new rlc spm code
To: Nirmoy <nirmodas@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200227201450.185953-1-alexander.deucher@amd.com>
 <20200227201450.185953-2-alexander.deucher@amd.com>
 <f6bbeab4-23a4-487f-339d-d7af49bec232@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <dab9e861-fc9e-d549-6a85-54527bc60e61@gmail.com>
Date: Fri, 28 Feb 2020 09:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f6bbeab4-23a4-487f-339d-d7af49bec232@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VyaWVzIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+IGFzIHdlbGwuCgpBbSAyNy4wMi4yMCB1bSAyMTozMyBzY2hyaWViIE5pcm1veToK
PiBzZXJpZXMgUmV2aWV3ZWQtYnk6TmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgo+Cj4g
T24gMi8yNy8yMCA5OjE0IFBNLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+IGZpeGVzIHdhcm5pbmdz
IHdpdGggLVdtaXNsZWFkaW5nLWluZGVudGF0aW9uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDYgKysrLS0tCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmPCoCB8IDYgKysrLS0tCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmPCoCB8IDYgKysrLS0tCj4+IMKgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmPCoCB8IDYgKysrLS0tCj4+IMKgIDQgZmlsZXMg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyAKPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+PiBpbmRleCBjYjM0MjFlMjVhZGMuLjBk
YzNlZDY5NGZlOCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3YxMF8wLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMK
Pj4gQEAgLTEwMTYsOSArMTAxNiw5IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3JsY19pbml0KHN0
cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHI7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCAtwqDCoMKgIC8qIGluaXQgc3BtIHZt
aWQgd2l0aCAweGYgKi8KPj4gLcKgwqDCoCBpZiAoYWRldi0+Z2Z4LnJsYy5mdW5jcy0+dXBkYXRl
X3NwbV92bWlkKQo+PiAtwqDCoMKgwqDCoMKgwqAgYWRldi0+Z2Z4LnJsYy5mdW5jcy0+dXBkYXRl
X3NwbV92bWlkKGFkZXYsIDB4Zik7Cj4+ICvCoMKgwqAgLyogaW5pdCBzcG0gdm1pZCB3aXRoIDB4
ZiAqLwo+PiArwqDCoMKgIGlmIChhZGV2LT5nZngucmxjLmZ1bmNzLT51cGRhdGVfc3BtX3ZtaWQp
Cj4+ICvCoMKgwqDCoMKgwqDCoCBhZGV2LT5nZngucmxjLmZ1bmNzLT51cGRhdGVfc3BtX3ZtaWQo
YWRldiwgMHhmKTsKPj4gwqAgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgfQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYyAKPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCj4+IGluZGV4IDM5N2M2MmM1ODQzNi4uNzMz
ZDM5OGM2MWNjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djdfMC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMKPj4g
QEAgLTMzNDYsOSArMzM0Niw5IEBAIHN0YXRpYyBpbnQgZ2Z4X3Y3XzBfcmxjX2luaXQoc3RydWN0
IAo+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gcjsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIC3CoMKgwqAgLyogaW5pdCBzcG0gdm1pZCB3
aXRoIDB4ZiAqLwo+PiAtwqDCoMKgIGlmIChhZGV2LT5nZngucmxjLmZ1bmNzLT51cGRhdGVfc3Bt
X3ZtaWQpCj4+IC3CoMKgwqDCoMKgwqDCoCBhZGV2LT5nZngucmxjLmZ1bmNzLT51cGRhdGVfc3Bt
X3ZtaWQoYWRldiwgMHhmKTsKPj4gK8KgwqDCoCAvKiBpbml0IHNwbSB2bWlkIHdpdGggMHhmICov
Cj4+ICvCoMKgwqAgaWYgKGFkZXYtPmdmeC5ybGMuZnVuY3MtPnVwZGF0ZV9zcG1fdm1pZCkKPj4g
K8KgwqDCoMKgwqDCoMKgIGFkZXYtPmdmeC5ybGMuZnVuY3MtPnVwZGF0ZV9zcG1fdm1pZChhZGV2
LCAweGYpOwo+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiDCoCB9Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjhfMC5jIAo+PiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8wLmMKPj4gaW5kZXggMjk0YWJmZjllZmI3Li4zOTNhMTMy
NGRhYTkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OF8w
LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y4XzAuYwo+PiBAQCAt
MTMxOCw5ICsxMzE4LDkgQEAgc3RhdGljIGludCBnZnhfdjhfMF9ybGNfaW5pdChzdHJ1Y3QgCj4+
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgLcKgwqDCoCAvKiBpbml0IHNwbSB2bWlkIHdpdGgg
MHhmICovCj4+IC3CoMKgwqAgaWYgKGFkZXYtPmdmeC5ybGMuZnVuY3MtPnVwZGF0ZV9zcG1fdm1p
ZCkKPj4gLcKgwqDCoMKgwqDCoMKgIGFkZXYtPmdmeC5ybGMuZnVuY3MtPnVwZGF0ZV9zcG1fdm1p
ZChhZGV2LCAweGYpOwo+PiArwqDCoMKgIC8qIGluaXQgc3BtIHZtaWQgd2l0aCAweGYgKi8KPj4g
K8KgwqDCoCBpZiAoYWRldi0+Z2Z4LnJsYy5mdW5jcy0+dXBkYXRlX3NwbV92bWlkKQo+PiArwqDC
oMKgwqDCoMKgwqAgYWRldi0+Z2Z4LnJsYy5mdW5jcy0+dXBkYXRlX3NwbV92bWlkKGFkZXYsIDB4
Zik7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+IMKgIH0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+PiBpbmRleCAxZDVmZDVmMTdhMzAuLjk5NjJlZjgwZGE5
MiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4+IEBAIC0xODQ3
LDkgKzE4NDcsOSBAQCBzdGF0aWMgaW50IGdmeF92OV8wX3JsY19pbml0KHN0cnVjdCAKPj4gYW1k
Z3B1X2RldmljZSAqYWRldikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+PiDCoMKgwqDC
oMKgIH0KPj4gwqAgLcKgwqDCoCAvKiBpbml0IHNwbSB2bWlkIHdpdGggMHhmICovCj4+IC3CoMKg
wqAgaWYgKGFkZXYtPmdmeC5ybGMuZnVuY3MtPnVwZGF0ZV9zcG1fdm1pZCkKPj4gLcKgwqDCoMKg
wqDCoMKgIGFkZXYtPmdmeC5ybGMuZnVuY3MtPnVwZGF0ZV9zcG1fdm1pZChhZGV2LCAweGYpOwo+
PiArwqDCoMKgIC8qIGluaXQgc3BtIHZtaWQgd2l0aCAweGYgKi8KPj4gK8KgwqDCoCBpZiAoYWRl
di0+Z2Z4LnJsYy5mdW5jcy0+dXBkYXRlX3NwbV92bWlkKQo+PiArwqDCoMKgwqDCoMKgwqAgYWRl
di0+Z2Z4LnJsYy5mdW5jcy0+dXBkYXRlX3NwbV92bWlkKGFkZXYsIDB4Zik7Cj4+IMKgIMKgwqDC
oMKgwqAgcmV0dXJuIDA7Cj4+IMKgIH0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
