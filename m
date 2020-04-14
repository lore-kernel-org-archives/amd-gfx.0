Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4320C2BA19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 13:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FF120644
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 13:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGW0TPdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FF120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB9D89B8F;
	Tue, 14 Apr 2020 13:51:36 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08F189B8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 13:51:34 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id f13so14389322wrm.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 06:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=U9gaYK6tgIZGBzgMfnyEPBxlxkEavNGJ5Rgvqk+Bk1M=;
 b=JGW0TPdpdLJ8P704goQKku10zP1e0y8/hu1xzXNGa/aIqDMZWByqjGUr4rDBewzaSf
 qbyi+cyL3lQX7becPx85g+fJAzVLKZnCzlMaGvsPTF8q5nx+p4K7HgUs2xM1p0yQBBGO
 wyHhxqh0awbjFuZSmGF3o4lFpbgjYFQLqsPNQe3IGtlIJt/y7t2GKj6yZWHa8y3ORyZP
 YcFS9TUa2RMQHS37Uw92wSJJJPhrlS849dx5h0vfaifX6VOUJ/8W6TR6rKV9/qqV1K/m
 fbGkgX0ryAtIPUQ2YmRXZFnqYlcww3myrWsmkoGzC5LfqACD8hBz0qg+u1Okid/nEKT3
 aajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=U9gaYK6tgIZGBzgMfnyEPBxlxkEavNGJ5Rgvqk+Bk1M=;
 b=n6GWZdckaBAcHUxDLSPRvDYUX2CoKXJm3HwBuXsh3E3Te5qQCXcTj7yt57ikHh24Ir
 D8F5GjzpGSyUFqGn8s+QzSiVHhg8me/xWMpM1QFor789hQtrjBNk+rHPxUKQ4B1J/rQb
 1cDhwrWmjj1xgJiVXrpeZNxFMkoiOj+Aa49Q6AoQYuF3HkeESoTLm0u4OIe0CvrPV97I
 kSA926NryxICsO2VSU+FadH/CBxDw0IahCYmPrBUCvA44qKmp32x4KG+6lmfwtwXhxzt
 ca/oXGa4b+/sVPD1f5RyDh0UCvIX+23GOU8ur7MKUBBGS+6a+yuxAd4C7ty5PYFI2sJr
 Iu6A==
X-Gm-Message-State: AGi0Pua2+cmRAf5tXH3CGONReaaTep29ajsSemMfKyuJF7iGPiJKzULY
 3KMK8JPyQjXxs144Y86fB0QUdz2H
X-Google-Smtp-Source: APiQypJu4pzo8w395MxJF2mFL+GWPAcsGq1mi/SfMCP0W4xNqeXgm8WkI1PhyzRB+on2AndPlUGBBw==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr25774931wrq.57.1586872293229; 
 Tue, 14 Apr 2020 06:51:33 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id q4sm20372582wmj.1.2020.04.14.06.51.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2020 06:51:32 -0700 (PDT)
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200413182026.2561-1-kent.russell@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>
Date: Tue, 14 Apr 2020 15:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200413182026.2561-1-kent.russell@amd.com>
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

QW0gMTMuMDQuMjAgdW0gMjA6MjAgc2NocmllYiBLZW50IFJ1c3NlbGw6Cj4gVGhpcyByZXZlcnRz
IGNvbW1pdCBjMTJiODRkNmUwZDcwZjExODVlNmRhZGRmZDEyYWZiNjcxNzkxYjZlLgo+IFRoZSBv
cmlnaW5hbCBwYXRjaCBjYXVzZXMgYSBSQVMgZXZlbnQgYW5kIHN1YnNlcXVlbnQga2VybmVsIGhh
cmQtaGFuZwo+IHdoZW4gcnVubmluZyB0aGUgS0ZETWVtb3J5VGVzdC5QdHJhY2VBY2Nlc3NJbnZp
c2libGVWcmFtIG9uIFZHMjAgYW5kCj4gQXJjdHVydXMKPgo+IGRtZXNnIG91dHB1dCBhdCBoYW5n
IHRpbWU6Cj4gW2RybV0gUkFTIGV2ZW50IG9mIHR5cGUgRVJSRVZFTlRfQVRIVUJfSU5URVJSVVBU
IGRldGVjdGVkIQo+IGFtZGdwdSAwMDAwOjY3OjAwLjA6IEdQVSByZXNldCBiZWdpbiEKPiBFdmlj
dGluZyBQQVNJRCAweDgwMDAgcXVldWVzCj4gU3RhcnRlZCBldmljdGluZyBwYXNpZCAweDgwMDAK
PiBxY20gZmVuY2Ugd2FpdCBsb29wIHRpbWVvdXQgZXhwaXJlZAo+IFRoZSBjcCBtaWdodCBiZSBp
biBhbiB1bnJlY292ZXJhYmxlIHN0YXRlIGR1ZSB0byBhbiB1bnN1Y2Nlc3NmdWwgcXVldWVzIHBy
ZWVtcHRpb24KPiBGYWlsZWQgdG8gZXZpY3QgcHJvY2VzcyBxdWV1ZXMKPiBGYWlsZWQgdG8gc3Vz
cGVuZCBwcm9jZXNzIDB4ODAwMAo+IEZpbmlzaGVkIGV2aWN0aW5nIHBhc2lkIDB4ODAwMAo+IFN0
YXJ0ZWQgcmVzdG9yaW5nIHBhc2lkIDB4ODAwMAo+IEZpbmlzaGVkIHJlc3RvcmluZyBwYXNpZCAw
eDgwMDAKPiBbZHJtXSBVVkQgVkNQVSBzdGF0ZSBtYXkgbG9zdCBkdWUgdG8gUkFTIEVSUkVWRU5U
X0FUSFVCX0lOVEVSUlVQVAo+IGFtZGdwdTogW3Bvd2VycGxheV0gRmFpbGVkIHRvIHNlbmQgbWVz
c2FnZSAweDI2LCByZXNwb25zZSAweDAKPiBhbWRncHU6IFtwb3dlcnBsYXldIEZhaWxlZCB0byBz
ZXQgc29mdCBtaW4gZ2Z4Y2xrICEKPiBhbWRncHU6IFtwb3dlcnBsYXldIEZhaWxlZCB0byB1cGxv
YWQgRFBNIEJvb3R1cCBMZXZlbHMhCj4gYW1kZ3B1OiBbcG93ZXJwbGF5XSBGYWlsZWQgdG8gc2Vu
ZCBtZXNzYWdlIDB4NywgcmVzcG9uc2UgMHgwCj4gYW1kZ3B1OiBbcG93ZXJwbGF5XSBbRGlzYWJs
ZUFsbFNNVUZlYXR1cmVzXSBGYWlsZWQgdG8gZGlzYWJsZSBhbGwgc211IGZlYXR1cmVzIQo+IGFt
ZGdwdTogW3Bvd2VycGxheV0gW0Rpc2FibGVEcG1UYXNrc10gRmFpbGVkIHRvIGRpc2FibGUgYWxs
IHNtdSBmZWF0dXJlcyEKPiBhbWRncHU6IFtwb3dlcnBsYXldIFtQb3dlck9mZkFzaWNdIEZhaWxl
ZCB0byBkaXNhYmxlIERQTSEKPiBbZHJtOmFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9waGFzZTIg
W2FtZGdwdV1dICpFUlJPUiogc3VzcGVuZCBvZiBJUCBibG9jayA8cG93ZXJwbGF5PiBmYWlsZWQg
LTUKCkRvIHlvdSBoYXZlIG1vcmUgaW5mb3JtYXRpb24gb24gd2hhdCdzIGdvaW5nIHdyb25nIGhl
cmUgc2luY2UgdGhpcyBpcyBhIApyZWFsbHkgaW1wb3J0YW50IHBhdGNoIGZvciBLRkQgZGVidWdn
aW5nLgoKPgo+IFNpZ25lZC1vZmYtYnk6IEtlbnQgUnVzc2VsbCA8a2VudC5ydXNzZWxsQGFtZC5j
b20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyB8IDI2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMK
PiBpbmRleCBjZjVkNmU1ODU2MzQuLmEzZjk5N2Y4NDAyMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMjU0LDMyICsyNTQsNiBAQCB2b2lk
IGFtZGdwdV9kZXZpY2VfdnJhbV9hY2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGxv
ZmZfdCBwb3MsCj4gICAJdWludDMyX3QgaGkgPSB+MDsKPiAgIAl1aW50NjRfdCBsYXN0Owo+ICAg
Cj4gLQo+IC0jaWZkZWYgQ09ORklHXzY0QklUCj4gLQlsYXN0ID0gbWluKHBvcyArIHNpemUsIGFk
ZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZSk7Cj4gLQlpZiAobGFzdCA+IHBvcykgewo+IC0JCXZv
aWQgX19pb21lbSAqYWRkciA9IGFkZXYtPm1tYW4uYXBlcl9iYXNlX2thZGRyICsgcG9zOwo+IC0J
CXNpemVfdCBjb3VudCA9IGxhc3QgLSBwb3M7Cj4gLQo+IC0JCWlmICh3cml0ZSkgewo+IC0JCQlt
ZW1jcHlfdG9pbyhhZGRyLCBidWYsIGNvdW50KTsKPiAtCQkJbWIoKTsKPiAtCQkJYW1kZ3B1X2Fz
aWNfZmx1c2hfaGRwKGFkZXYsIE5VTEwpOwo+IC0JCX0gZWxzZSB7Cj4gLQkJCWFtZGdwdV9hc2lj
X2ludmFsaWRhdGVfaGRwKGFkZXYsIE5VTEwpOwo+IC0JCQltYigpOwo+IC0JCQltZW1jcHlfZnJv
bWlvKGJ1ZiwgYWRkciwgY291bnQpOwo+IC0JCX0KPiAtCj4gLQkJaWYgKGNvdW50ID09IHNpemUp
Cj4gLQkJCXJldHVybjsKPiAtCj4gLQkJcG9zICs9IGNvdW50Owo+IC0JCWJ1ZiArPSBjb3VudCAv
IDQ7Cj4gLQkJc2l6ZSAtPSBjb3VudDsKPiAtCX0KPiAtI2VuZGlmCj4gLQo+ICAgCXNwaW5fbG9j
a19pcnFzYXZlKCZhZGV2LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7Cj4gICAJZm9yIChsYXN0ID0g
cG9zICsgc2l6ZTsgcG9zIDwgbGFzdDsgcG9zICs9IDQpIHsKPiAgIAkJdWludDMyX3QgdG1wID0g
cG9zID4+IDMxOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
