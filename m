Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9DC33CB3
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 09:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8178B20730
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 09:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1VqfdGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8178B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E4B6F4B9;
	Fri, 17 Jan 2020 09:49:48 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967E16F4B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 09:49:47 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z3so22039132wru.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:from:to:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=c+bfw45uGCd8F0hb7XqKFYOYk11CQ9IamHznL28ZR8A=;
 b=J1VqfdGp2pTh9mR5TndYuDjtOZhsm58Z11FwOSFCBeSU7RPcW+jNmacjSeil4Fa7AD
 hGpaYC4C6Q8VgfGfBszkQyEC373T0bHWAXgesvHoBeq6XXa9WGvKqb7I9gmNQL7SQ0zR
 3CJvDgdJAqZ1i05OyZubuY58LibKZLHzyqlk8umfYyj7hPqAUCe1V0zX3xqvYwmVCZwv
 uRLqg2Zv2cmDhL0we7DROXS1fxGGGcODbhW9Qjc7JOYtjKmztTBfS1gXI0QS2mkLqTI1
 Yu+Yje/y14eykU/BjSgaMjSiJNkkVH4VVD9Nb+1Yn+UvlouwMXLUODbpC4n+I/93/S0O
 bDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:from:to:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=c+bfw45uGCd8F0hb7XqKFYOYk11CQ9IamHznL28ZR8A=;
 b=iCtInulliqdqc3RRzIDwnh9kZWRrDSmlp15rceReKUdqaEZKKDVoYEs32DZFQ9dpcr
 XX1Ch5Z3qcmKCR9k1rT7kbwngpXhgZ4uycqf2MUsSnj+AYHbs/+I3d8QPgmF0A+p8xs8
 yOSZ+eE0dTIO29BR5ghqjKFaF7QR/nQs6BkWZIjLCN9Km4cjpifQ26vGstSSBxnMJTlR
 k8ab3VMZrwg+ZjjGq8Nwsa1sc7/JhbCVlk2LP+l9F2GLsDCcbe3tarpXXrbnfSWOCG5D
 r9inkHefBSBJoE6JHLM6iIxZusoe/SaofyHeKjab7k8w41mDqNOEDknn7c3xG/esbMp4
 ZgKQ==
X-Gm-Message-State: APjAAAXpc13erfY6pmPI12MJwj+SDYq/pAfZNFwYhqZ1pmCld9+4YbQ4
 yY/Lp+TVD0GZQgUS8SNit2fLBSUz
X-Google-Smtp-Source: APXvYqykuZCiECDbbXT8phF5mVM4OoK3/e+AEJSOAQ9SKD6bbCJ61Ij7sKd85vPWfrSzlPKLnARpnA==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr2154870wrt.228.1579254586025; 
 Fri, 17 Jan 2020 01:49:46 -0800 (PST)
Received: from [192.168.137.21] (aftr-37-201-195-117.unity-media.net.
 [37.201.195.117])
 by smtp.gmail.com with ESMTPSA id f1sm34175009wrp.93.2020.01.17.01.49.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 Jan 2020 01:49:45 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add coreboot workaround for KV/KB
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Felix Kuehling <felix.kuehling@amd.com>, fredrik.bruhn@unibap.com,
 amd-gfx@lists.freedesktop.org
References: <20200116130907.22410-1-christian.koenig@amd.com>
 <c5aa1227-adc0-f7d0-1786-deec7ca681c1@amd.com>
 <3c1b6bea-d5bc-0532-9805-2eb2c1003653@gmail.com>
Message-ID: <3bed6416-b294-f998-70a1-2e9faed6b5d4@gmail.com>
Date: Fri, 17 Jan 2020 10:49:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3c1b6bea-d5bc-0532-9805-2eb2c1003653@gmail.com>
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

QW0gMTcuMDEuMjAgdW0gMDk6MTcgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDE3LjAx
LjIwIHVtIDAzOjAxIHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IE9uIDIwMjAtMDEtMTYgODow
OSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IENvcmVib290IHNlZW1zIHRvIGhhdmUgYSBw
cm9ibGVtIGNvcnJlY3RseSBzZXR0aW5nIHVwIGFjY2VzcyB0byB0aGUgCj4+PiBzdG9sZW4gVlJB
TQo+Pj4gb24gS1YvS0IuIFVzZSB0aGUgZGlyZWN0IGFjY2VzcyBvbmx5IHdoZW4gbmVjZXNzYXJ5
Lgo+Pgo+PiBJJ20gbm90IHN1cmUgd2hhdCB5b3UgbWVhbiBieSAibmVjZXNzYXJ5Ii4KPgo+IE5l
Y2Vzc2FyeSBmb3IgYmV0dGVyIHBlcmZvcm1hbmNlLgo+Cj4+Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4gLS0tCj4+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jIHwgMyArKy0KPj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYyAKPj4+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYwo+Pj4gaW5kZXggMTlkNWIxMzNl
MWQ3Li45ZGE5NTk2YTM2MzggMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjdfMC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djdfMC5jCj4+PiBAQCAtMzgxLDcgKzM4MSw4IEBAIHN0YXRpYyBpbnQgZ21jX3Y3XzBfbWNfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4+ICphZGV2KQo+Pj4gwqDCoMKgwqDCoCBhZGV2LT5n
bWMuYXBlcl9zaXplID0gcGNpX3Jlc291cmNlX2xlbihhZGV2LT5wZGV2LCAwKTsKPj4+IMKgIMKg
ICNpZmRlZiBDT05GSUdfWDg2XzY0Cj4+PiAtwqDCoMKgIGlmIChhZGV2LT5mbGFncyAmIEFNRF9J
U19BUFUpIHsKPj4+ICvCoMKgwqAgaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSAmJgo+Pj4g
K8KgwqDCoMKgwqDCoMKgIGFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSA+IGFkZXYtPmdtYy5hcGVy
X3NpemUpIHsKPj4KPj4gQ1BVIGFjY2VzcyB0byB0aGUgd2hvbGUgVlJBTSBpc24ndCByZWFsbHkg
bmVjZXNzYXJ5LiBJIHRob3VnaHQgdGhlIAo+PiBtYWluIG1vdGl2YXRpb24gZm9yIGFjY2Vzc2lu
ZyBGQiBkaXJlY3RseSBvbiBBUFVzIHdhcyBiZXR0ZXIgCj4+IHBlcmZvcm1hbmNlLiBZb3UncmUg
ZGlzYWJsaW5nIHRoYXQgb3B0aW1pemF0aW9uIG9uIGFsbCBBUFVzIHdoZXJlIHRoZSAKPj4gRkIg
aXMgc21hbGxlciB0aGFuIHRoZSBhcGVydHVyZSBzaXplLgo+Cj4gQ29ycmVjdCwgeWVzLiBGb3Ig
c29tZSByZWFzb24gY29yZWJvb3Qgc2VlbXMgdG8gZXhwbGljaXRseSBzZXR1cCB0aGUgCj4gbWVt
b3J5IHVzZWQgZm9yIHRoZSBGQiBhcyB3cml0ZS1wcm90ZWN0ZWQuCj4KPiBUaGUgR1BVIGNhbiBz
dGlsbCByZWFkL3dyaXRlIGl0IG5vcm1hbGx5IGNhdXNlIGl0IGlnbm9yZXMgdGhhdCAKPiBwcm90
ZWN0aW9uLCBidXQgdGhlIENQVSBjYW4ndCBjaGFuZ2UgdGhlIEZCIG1lbW9yeSBhbnkgbW9yZSB3
aXRoIHRoYXQgCj4gc2V0dXAuCj4KPiBObyBpZGVhIHdoeSB0aGV5IGRvIHRoaXMsIG1vc3QgbGlr
ZWx5IGp1c3QgYW4gb3ZlciBjb25zZXJ2YXRpdmUgCj4gcHJvdGVjdGlvbiBvZiBhIHJlc2VydmVk
IGFyZWEgb2YgbWVtb3J5LgoKQW5kIHdoYXQgSSBmb3Jnb3Q6IElmIGFueWJvZHkgaGFzIGEgZ29v
ZCBjb250YWN0IGZyb20gdGhlIGNvcmVib290IGd1eXMgCnRoZW4gcGxlYXNlIHNwZWFrIHVwLgoK
V291bGQgYmUgbmljZSB0byBoYXZlIGEgYmV0dGVyIHNvbHV0aW9uIGZvciB0aGlzLgoKQ2hyaXN0
aWFuLgoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFJlZ2FyZHMsCj4+IMKgIEZl
bGl4Cj4+Cj4+Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+Z21jLmFwZXJfYmFzZSA9ICgo
dTY0KVJSRUczMihtbU1DX1ZNX0ZCX09GRlNFVCkpIDw8IDIyOwo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGFkZXYtPmdtYy5hcGVyX3NpemUgPSBhZGV2LT5nbWMucmVhbF92cmFtX3NpemU7Cj4+PiDC
oMKgwqDCoMKgIH0KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
