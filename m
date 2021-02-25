Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A74C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC99964F29
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 20:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC99964F29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660B56E2C0;
	Thu, 25 Feb 2021 20:19:11 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4266E2C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 20:19:09 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id h19so8485731edb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 12:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=B/a01J/Sd4fEn4bHdsnRNb1/8NhdXZpJvcBaegXGRvE=;
 b=hGI5H8eTF3UVlpvmJq7zp7KwF04oMDzyIta67jLHPDgIHIemZFv68DMhln/TX72XqI
 YtVE64gAkotoiwF1hl1wL0wQtLM3LzreLUofA4opj6BtrP8sRvW470hibuTPGvLtzpZB
 Fq+g+f1WeiHz3nkthKidTOY4iYshAkAT1QH7fEA0OWsVjExyE4oMi6LXklgcCRGyh739
 52aJobhGBtCsYKBeCr5vKonq0MmURMQP1lfjFZKxp2tgQL5iKnMsSm0JUHIPKBb3GJTc
 EDheuip1m6L9BOb15jQswJ345bzuqU12rvMKiUqBY9mlNkr/K9xGJW9ZK4BZcYJ9+HQj
 zU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=B/a01J/Sd4fEn4bHdsnRNb1/8NhdXZpJvcBaegXGRvE=;
 b=R79j5MPvl6q24CE0M1UiTqtpk2Qw7t8XZddi3NNh4RVgJ8JnmZxA3OMlyZ6uiShzEe
 RDZHw6peLiX0Av+Bzf4P9jr7BJQNrwrHMYeLMmVmC76uAyP4IyAeYjMGuMkTk8H6QX9T
 EMH7TnDlMGPzN/rWjKxmx4lar4rjrwfjWU9SaMskkhUjFe/pIvyHvVTsBGb+YpFngkhl
 avdyXb/Z2oLEoPxAdEvmVAJ4LbAdpYBzE3QN5xYXLNyz5KkcvUjgjMCWxQ5ZSoQSgHuN
 b5jnbZx6TNN1RO68X16cu5vhXPpbzmGDAYH65M5RjiTIfTBjXMmqx3dExPW7xFj7GQyX
 JbYw==
X-Gm-Message-State: AOAM531mRhFbNrD85sQ91pkD+mwyOGn+Z5ZExcMEdTFmUFIxFtyJpLmu
 zeOklReM/8qkS29UTKg34TS+FPEhdYbzBw==
X-Google-Smtp-Source: ABdhPJzzm5QizH7l/lvLfwE2d365KmFF2KeNUexSHCTNKd83YVhyrTao2hi5ESncd+HsWGjpQ03cLg==
X-Received: by 2002:aa7:d2c4:: with SMTP id k4mr4880145edr.237.1614284348376; 
 Thu, 25 Feb 2021 12:19:08 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:bcf6:4057:c09:be71?
 ([2a02:908:1252:fb60:bcf6:4057:c09:be71])
 by smtp.gmail.com with ESMTPSA id y24sm1526840eds.23.2021.02.25.12.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Feb 2021 12:19:07 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: add asic callback for querying video
 codec info (v3)
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210225201614.896990-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <82351e34-6b73-91e3-a4eb-84332a45eb40@gmail.com>
Date: Thu, 25 Feb 2021 21:19:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225201614.896990-1-alexander.deucher@amd.com>
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
Cc: Leo Liu <leo.liu@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjUuMDIuMjEgdW0gMjE6MTYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhpcyB3aWxsIGJl
IHVzZWQgYnkgYSBuZXcgSU5GTyBpb2N0bCBxdWVyeSB0byBmZXRjaCB0aGUgZGVjb2RlCj4gYW5k
IGVuY29kZSBjYXBhYmlsaXRpZXMgZnJvbSB0aGUga2VybmVsIGRyaXZlciByYXRoZXIgdGhhbgo+
IGhhcmRjb2RpbmcgdGhlbSBpbiBtZXNhLiAgVGhpcyBnaXZlcyB1cyBtb3JlIGZpbmUgZ3JhaW5l
ZCBjb250cm9sCj4gb2YgY2FwYWJpbGl0aWVzIHVzaW5nIGluZm9ybWF0aW9uIHRoYXQgaXMgb25s
eSBhdmFpbGFibCBpbiB0aGUKPiBrZXJuZWwgKGUuZy4sIHBsYXRmb3JtIGxpbWl0YXRpb25zIG9y
IGJhbmR3aWR0aCByZXN0cmljdGlvbnMpLgo+Cj4gdjI6IHJlb3JkZXIgdGhlIGNvZGVjcyB0byBi
ZXR0ZXIgYWxpZ24gd2l0aCBtZXNhCj4gdjM6IGFkZCBtYXhfcGl4ZWxzX3Blcl9mcmFtZSB0byBo
YW5kbGUgdGhlIHBvcnRyYWl0IGNhc2UKPgo+IFJldmlld2VkLWJ5OiBMZW8gTGl1IDxsZW8ubGl1
QGFtZC5jb20+ICh2MikKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhlIHNlcmllcy4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHUuaCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1LmgKPiBpbmRleCAyMmU1ZDlmMjg0YzMuLjA5YWVjMTZjOGZlYiAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaAo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gQEAgLTU4Myw2ICs1ODMsMjggQEAgZW51bSBh
bWRfcmVzZXRfbWV0aG9kIHsKPiAgIAlBTURfUkVTRVRfTUVUSE9EX1BDSSwKPiAgIH07Cj4gICAK
PiArI2RlZmluZSBBTURHUFVfVklERU9fQ09ERUNfVFlQRV9NUEVHMgkJCTAKPiArI2RlZmluZSBB
TURHUFVfVklERU9fQ09ERUNfVFlQRV9NUEVHNAkJCTEKPiArI2RlZmluZSBBTURHUFVfVklERU9f
Q09ERUNfVFlQRV9WQzEJCQkyCj4gKyNkZWZpbmUgQU1ER1BVX1ZJREVPX0NPREVDX1RZUEVfTVBF
RzRfQVZDCQkzCj4gKyNkZWZpbmUgQU1ER1BVX1ZJREVPX0NPREVDX1RZUEVfSEVWQwkJCTQKPiAr
I2RlZmluZSBBTURHUFVfVklERU9fQ09ERUNfVFlQRV9KUEVHCQkJNQo+ICsjZGVmaW5lIEFNREdQ
VV9WSURFT19DT0RFQ19UWVBFX1ZQOQkJCTYKPiArI2RlZmluZSBBTURHUFVfVklERU9fQ09ERUNf
VFlQRV9BVjEJCQk3Cj4gKwo+ICtzdHJ1Y3QgYW1kZ3B1X3ZpZGVvX2NvZGVjX2luZm8gewo+ICsJ
dTMyIGNvZGVjX3R5cGU7Cj4gKwl1MzIgbWF4X3dpZHRoOwo+ICsJdTMyIG1heF9oZWlnaHQ7Cj4g
Kwl1MzIgbWF4X3BpeGVsc19wZXJfZnJhbWU7Cj4gKwl1MzIgbWF4X2xldmVsOwo+ICt9Owo+ICsK
PiArc3RydWN0IGFtZGdwdV92aWRlb19jb2RlY3Mgewo+ICsJY29uc3QgdTMyIGNvZGVjX2NvdW50
Owo+ICsJY29uc3Qgc3RydWN0IGFtZGdwdV92aWRlb19jb2RlY19pbmZvICpjb2RlY19hcnJheTsK
PiArfTsKPiArCj4gICAvKgo+ICAgICogQVNJQyBzcGVjaWZpYyBmdW5jdGlvbnMuCj4gICAgKi8K
PiBAQCAtNjI3LDYgKzY0OSw5IEBAIHN0cnVjdCBhbWRncHVfYXNpY19mdW5jcyB7Cj4gICAJdm9p
ZCAoKnByZV9hc2ljX2luaXQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAgIAkvKiBl
bnRlci9leGl0IHVtZCBzdGFibGUgcHN0YXRlICovCj4gICAJaW50ICgqdXBkYXRlX3VtZF9zdGFi
bGVfcHN0YXRlKShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBlbnRlcik7Cj4gKwkv
KiBxdWVyeSB2aWRlbyBjb2RlY3MgKi8KPiArCWludCAoKnF1ZXJ5X3ZpZGVvX2NvZGVjcykoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGJvb2wgZW5jb2RlLAo+ICsJCQkJICBjb25zdCBzdHJ1
Y3QgYW1kZ3B1X3ZpZGVvX2NvZGVjcyAqKmNvZGVjcyk7Cj4gICB9Owo+ICAgCj4gICAvKgo+IEBA
IC0xMjIxLDYgKzEyNDYsNyBAQCBpbnQgZW11X3NvY19hc2ljX2luaXQoc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpOwo+ICAgI2RlZmluZSBhbWRncHVfYXNpY19wcmVfYXNpY19pbml0KGFkZXYp
IChhZGV2KS0+YXNpY19mdW5jcy0+cHJlX2FzaWNfaW5pdCgoYWRldikpCj4gICAjZGVmaW5lIGFt
ZGdwdV9hc2ljX3VwZGF0ZV91bWRfc3RhYmxlX3BzdGF0ZShhZGV2LCBlbnRlcikgXAo+ICAgCSgo
YWRldiktPmFzaWNfZnVuY3MtPnVwZGF0ZV91bWRfc3RhYmxlX3BzdGF0ZSA/IChhZGV2KS0+YXNp
Y19mdW5jcy0+dXBkYXRlX3VtZF9zdGFibGVfcHN0YXRlKChhZGV2KSwgKGVudGVyKSkgOiAwKQo+
ICsjZGVmaW5lIGFtZGdwdV9hc2ljX3F1ZXJ5X3ZpZGVvX2NvZGVjcyhhZGV2LCBlLCBjKSAoYWRl
diktPmFzaWNfZnVuY3MtPnF1ZXJ5X3ZpZGVvX2NvZGVjcygoYWRldiksIChlKSwgKGMpKQo+ICAg
Cj4gICAjZGVmaW5lIGFtZGdwdV9pbmNfdnJhbV9sb3N0KGFkZXYpIGF0b21pY19pbmMoJigoYWRl
diktPnZyYW1fbG9zdF9jb3VudGVyKSk7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
