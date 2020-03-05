Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB8C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 12:24:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5E120717
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 12:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH+F7Zor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5E120717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F9D6E317;
	Thu,  5 Mar 2020 12:24:47 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B316E317
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 12:24:45 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id 6so1342102wre.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 04:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IJK7C6ufZzvSfEYmmUb8MImUXPRXBGoSsaGauPxQf5M=;
 b=bH+F7ZorXdDmxXXS+l6895E91rOeFTxNHs9lULvqonVwHOWpRHh8t4WwgvcQtXdinP
 2wsldqPySFdq7Qi/ucB+1tYUQe2FTL+fI6Okx0o7eOxWMunfRGKibsu1jvHMTEToPHQ7
 ffSZqk5m5IvCBqPQ0N1UMLblSMImxwN1GLAtHw3rVb6FsUPT1sIS5aENFr5ujEcQk2FG
 xaddbH64BmbzO5eV0exyLm8W75myj4oaGyRT1Uu44LJcQUdQFNfocZp6QW+ODbLnEIYH
 UQ3bcSnht3XTTFZU98NWBgMElMhgUa/Fy8BNx8XLOs2azvreylpLO7fbH3D6x4vVGvI3
 D9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IJK7C6ufZzvSfEYmmUb8MImUXPRXBGoSsaGauPxQf5M=;
 b=t9ndxqXsSX7u/DUS7jNGhZOYDwdSeV0CqZ1Blw8r8HlO0nuf6XQzy7Mtdqs+yQml74
 Wxw6jyBng8mQOeRER+ec09fIp1In+npMT5+ecDQ0tQGHfJuDe4qHxOMMHUJ8gA/dKual
 /ny2wycAHI8e3BAwZVEgnEW2CrkDWR2Q6Gb4M4SwAFdDk3yUyvSyJuAQTKq4tc6yUZih
 jxqWqqdof+bYNJt/cBnweMcRt9iAG7bBBirXuYm2tkNfA4e+H/Zo2yoNbrHbQwVa/F2R
 1+7px4/6414St3XeHVxbaWi87H6iC+B2ikmIf+il7DuIbRizmVf5n5zSCFlGP2liZtsP
 BJiA==
X-Gm-Message-State: ANhLgQ0lETHMHwzsBYiC9MeAZUVAPpaFu5GfLVHSzPdrOXIAD7L0gvIJ
 ro531erZ9U0IYrYceHJyhRIcCcDT
X-Google-Smtp-Source: ADFU+vuf2wLUOZTfAlAY5PzZHbnDPQ3z8w7akUqq2SwGAi81KyeizzW2uyvIhA7mINMR3NnNv4yUBw==
X-Received: by 2002:adf:aa9e:: with SMTP id h30mr10395680wrc.288.1583411084451; 
 Thu, 05 Mar 2020 04:24:44 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g201sm8934186wme.23.2020.03.05.04.24.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 04:24:43 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Update SPM_VMID with the job's vmid when
 application reserves the vmid
To: Jacob He <jacob.he@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200305120853.27739-1-jacob.he@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a0aadc22-a1fe-bb44-2dd9-618bc5882a56@gmail.com>
Date: Thu, 5 Mar 2020 13:24:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200305120853.27739-1-jacob.he@amd.com>
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

QW0gMDUuMDMuMjAgdW0gMTM6MDggc2NocmllYiBKYWNvYiBIZToKPiBTUE0gYWNjZXNzIHRoZSB2
aWRlbyBtZW1vcnkgYWNjb3JkaW5nIHRvIFNQTV9WTUlELiBJdCBzaG91bGQgYmUgdXBkYXRlZAo+
IHdpdGggdGhlIGpvYidzIHZtaWQgcmlnaHQgYmVmb3JlIHRoZSBqb2IgaXMgc2NoZWR1bGVkLiBT
UE1fVk1JRCBpcyBhCj4gZ2xvYmFsIHJlc291cmNlCj4KPiBDaGFuZ2UtSWQ6IElkMzg4MTkwODk2
MDM5OGY4N2U3Yzk1MDI2YTU0ZmY4M2ZmODI2NzAwCj4gU2lnbmVkLW9mZi1ieTogSmFjb2IgSGUg
PGphY29iLmhlQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIHwgMjAgKysrKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyMCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
Ywo+IGluZGV4IGMwMDY5NmYzMDE3ZS4uNzMzOTg4MzExOTZmIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMTA4MCw4ICsxMDgwLDEyIEBAIGludCBhbWRn
cHVfdm1fZmx1c2goc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBzdHJ1Y3QgYW1kZ3B1X2pvYiAq
am9iLAo+ICAgCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gTlVMTDsKPiAgIAlib29sIHBhc2lk
X21hcHBpbmdfbmVlZGVkID0gZmFsc2U7Cj4gICAJdW5zaWduZWQgcGF0Y2hfb2Zmc2V0ID0gMDsK
PiArCWJvb2wgdXBkYXRlX3NwbV92bWlkX25lZWRlZCA9IChqb2ItPnZtICYmIChqb2ItPnZtLT5y
ZXNlcnZlZF92bWlkW3ZtaHViXSAhPSBOVUxMKSk7Cj4gICAJaW50IHI7Cj4gICAKPiArCWlmICh1
cGRhdGVfc3BtX3ZtaWRfbmVlZGVkICYmIGFkZXYtPmdmeC5ybGMuZnVuY3MtPnVwZGF0ZV9zcG1f
dm1pZCkKPiArCQlhZGV2LT5nZngucmxjLmZ1bmNzLT51cGRhdGVfc3BtX3ZtaWQoYWRldiwgam9i
LT52bWlkKTsKPiArCj4gICAJaWYgKGFtZGdwdV92bWlkX2hhZF9ncHVfcmVzZXQoYWRldiwgaWQp
KSB7Cj4gICAJCWdkc19zd2l0Y2hfbmVlZGVkID0gdHJ1ZTsKPiAgIAkJdm1fZmx1c2hfbmVlZGVk
ID0gdHJ1ZTsKPiBAQCAtMzIxMyw2ICszMjE3LDcgQEAgaW50IGFtZGdwdV92bV9pb2N0bChzdHJ1
Y3QgZHJtX2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApCj4g
ICAJdW5pb24gZHJtX2FtZGdwdV92bSAqYXJncyA9IGRhdGE7Cj4gICAJc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYgPSBkZXYtPmRldl9wcml2YXRlOwo+ICAgCXN0cnVjdCBhbWRncHVfZnByaXYg
KmZwcml2ID0gZmlscC0+ZHJpdmVyX3ByaXY7Cj4gKwlsb25nIHRpbWVvdXQgPSBtc2Vjc190b19q
aWZmaWVzKDIwMDApOwo+ICAgCWludCByOwo+ICAgCj4gICAJc3dpdGNoIChhcmdzLT5pbi5vcCkg
ewo+IEBAIC0zMjI0LDYgKzMyMjksMjEgQEAgaW50IGFtZGdwdV92bV9pb2N0bChzdHJ1Y3QgZHJt
X2RldmljZSAqZGV2LCB2b2lkICpkYXRhLCBzdHJ1Y3QgZHJtX2ZpbGUgKmZpbHApCj4gICAJCQly
ZXR1cm4gcjsKPiAgIAkJYnJlYWs7Cj4gICAJY2FzZSBBTURHUFVfVk1fT1BfVU5SRVNFUlZFX1ZN
SUQ6Cj4gKwkJaWYgKGFtZGdwdV9zcmlvdl9ydW50aW1lKGFkZXYpKQo+ICsJCQl0aW1lb3V0ID0g
OCAqIHRpbWVvdXQ7Cj4gKwo+ICsJCS8qIFdhaXQgdm0gaWRsZSB0byBtYWtlIHN1cmUgdGhlIHZt
aWQgc2V0IGluIFNQTV9WTUlEIGlzCj4gKwkJICogbm90IHJlZmVyZW5jZWQgYW55bW9yZS4KPiAr
CQkgKi8KPiArCQlyID0gYW1kZ3B1X2JvX3Jlc2VydmUoZnByaXYtPnZtLnJvb3QuYmFzZS5ibywg
dHJ1ZSk7Cj4gKwkJaWYgKHIpCj4gKwkJCXJldHVybiByOwo+ICsKPiArCQlyID0gYW1kZ3B1X3Zt
X3dhaXRfaWRsZSgmZnByaXYtPnZtLCB0aW1lb3V0KTsKPiArCQlpZiAociA8IDApCj4gKwkJCXJl
dHVybiByOwo+ICsKPiArCQlhbWRncHVfYm9fdW5yZXNlcnZlKGZwcml2LT52bS5yb290LmJhc2Uu
Ym8pOwo+ICAgCQlhbWRncHVfdm1pZF9mcmVlX3Jlc2VydmVkKGFkZXYsICZmcHJpdi0+dm0sIEFN
REdQVV9HRlhIVUJfMCk7Cj4gICAJCWJyZWFrOwo+ICAgCWRlZmF1bHQ6CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
