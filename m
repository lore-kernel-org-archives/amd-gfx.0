Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B77C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2A8C206DC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axsQnJGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A8C206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A16356E7D3;
	Tue, 11 Aug 2020 16:44:15 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A8A6E5D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 16:44:14 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id d6so13806397ejr.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 09:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=UgjfvW4Z6Qlf7cbvuqd5sMGzC3IZvfRU5v1wckPL0TE=;
 b=axsQnJGgtMKSSgoVbtpvyt5poQ9YgDuxlRh2zfXXvxXOlcoQMvbvnyuTR/66owAjG0
 0O1LIHNmoNnOcHmX7Fvx6HAB7nGgUq8Hnx+wpKRQoqMJwV1DMfXyXlTKGwbZfNSguX8g
 khk1kpRpp/3xvVsKwOdo34SkmMk4dApCCTiDUTDzFO0PhP77yDpxmYkUARlxGyE500BO
 Fc9KjrFpIsBoyaNp9JJl4Uyg1ymB0iwWt+AoK8A7CTyNXKj43UzGtKEJnm9eQr/wsmm2
 ovSRpyuB7kyiZO+Cdg4HAaXyQ+aDgq5FQHjUlo4uLS8eChR+hvBf7vJTjM0wCaysMWLX
 kyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=UgjfvW4Z6Qlf7cbvuqd5sMGzC3IZvfRU5v1wckPL0TE=;
 b=cASHjlpCsMoDC+AMjm61nRMhfcVYPlh/H/jE1AoqAHsup7+zb1bXYtBOfi+ZI+oud2
 0Ya+Om5e0vp6KaxVByvW2WV6b82eJC2ak1AWTMfooGTurthazA+NL+OLZCn7zqr5tQyd
 wXNri1GXm345ZfYqmZplsNxwVbj/cVhbA0LI4ZbPqZJRrOe2MMehMpn9Y6KFjSS0etgg
 LVhDr2I5Zndi7ybB3boG5QA6DthowYKbSaBQDBYsOumuKJZFYqH4D+MI47fC2tEEQDmF
 B6DG61i+MZ6IO2+6/Z0uyI3tvjSHdFYKZnqQTnSOs465lLCSSmgAyRDCcEGEbyA3Qbgd
 bG9w==
X-Gm-Message-State: AOAM533pq3QFrFUSCgPpGSslMuBvs8rLKmuJKBJD3EfB5ZCl/A+HJc4s
 JQ70+lqqzqX14H4tZVD2Oxo=
X-Google-Smtp-Source: ABdhPJwQUdOJXUt5GNqKFTG1GjkB4v+/SAImttGylhnRfl5Y80YZhO3noO19TzGXSaZV8Jtj1XXXew==
X-Received: by 2002:a17:906:5ac8:: with SMTP id
 x8mr26989637ejs.486.1597164253025; 
 Tue, 11 Aug 2020 09:44:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i26sm14604286edv.70.2020.08.11.09.44.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 09:44:12 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: print where we get the vbios image from
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200811160457.1073325-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <74eff14a-9a37-1d92-da49-fc3e53d5bf5e@gmail.com>
Date: Tue, 11 Aug 2020 18:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811160457.1073325-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDguMjAgdW0gMTg6MDQgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gQUNQSSwgUk9NLCBQ
Q0kgQkFSLCBldGMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9iaW9zLmMgfCAyOCArKysrKysrKysrKysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jCj4gaW5kZXggYjExNzJkOTNjOTljLi42MzMzY2FkYTFl
MDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Jpb3Mu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9zLmMKPiBAQCAt
NDE3LDI2ICs0MTcsNDAgQEAgc3RhdGljIGlubGluZSBib29sIGFtZGdwdV9hY3BpX3ZmY3RfYmlv
cyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAo+ICAgYm9vbCBhbWRncHVfZ2V0X2Jp
b3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICB7Cj4gLQlpZiAoYW1kZ3B1X2F0cm1f
Z2V0X2Jpb3MoYWRldikpCj4gKwlpZiAoYW1kZ3B1X2F0cm1fZ2V0X2Jpb3MoYWRldikpIHsKPiAr
CQlkZXZfaW5mbyhhZGV2LT5kZXYsICJGZXRjaGVkIFZCSU9TIGZyb20gQVRSTVxuIik7Cj4gICAJ
CWdvdG8gc3VjY2VzczsKPiArCX0KPiAgIAo+IC0JaWYgKGFtZGdwdV9hY3BpX3ZmY3RfYmlvcyhh
ZGV2KSkKPiArCWlmIChhbWRncHVfYWNwaV92ZmN0X2Jpb3MoYWRldikpIHsKPiArCQlkZXZfaW5m
byhhZGV2LT5kZXYsICJGZXRjaGVkIFZCSU9TIGZyb20gVkZDVFxuIik7Cj4gICAJCWdvdG8gc3Vj
Y2VzczsKPiArCX0KPiAgIAo+IC0JaWYgKGlncF9yZWFkX2Jpb3NfZnJvbV92cmFtKGFkZXYpKQo+
ICsJaWYgKGlncF9yZWFkX2Jpb3NfZnJvbV92cmFtKGFkZXYpKSB7Cj4gKwkJZGV2X2luZm8oYWRl
di0+ZGV2LCAiRmV0Y2hlZCBWQklPUyBmcm9tIFZSQU0gQkFSXG4iKTsKPiAgIAkJZ290byBzdWNj
ZXNzOwo+ICsJfQo+ICAgCj4gLQlpZiAoYW1kZ3B1X3JlYWRfYmlvcyhhZGV2KSkKPiArCWlmIChh
bWRncHVfcmVhZF9iaW9zKGFkZXYpKSB7Cj4gKwkJZGV2X2luZm8oYWRldi0+ZGV2LCAiRmV0Y2hl
ZCBWQklPUyBmcm9tIFJPTSBCQVJcbiIpOwo+ICAgCQlnb3RvIHN1Y2Nlc3M7Cj4gKwl9Cj4gICAK
PiAtCWlmIChhbWRncHVfcmVhZF9iaW9zX2Zyb21fcm9tKGFkZXYpKQo+ICsJaWYgKGFtZGdwdV9y
ZWFkX2Jpb3NfZnJvbV9yb20oYWRldikpIHsKPiArCQlkZXZfaW5mbyhhZGV2LT5kZXYsICJGZXRj
aGVkIFZCSU9TIGZyb20gUk9NXG4iKTsKPiAgIAkJZ290byBzdWNjZXNzOwo+ICsJfQo+ICAgCj4g
LQlpZiAoYW1kZ3B1X3JlYWRfZGlzYWJsZWRfYmlvcyhhZGV2KSkKPiArCWlmIChhbWRncHVfcmVh
ZF9kaXNhYmxlZF9iaW9zKGFkZXYpKSB7Cj4gKwkJZGV2X2luZm8oYWRldi0+ZGV2LCAiRmV0Y2hl
ZCBWQklPUyBmcm9tIGRpc2FibGVkIFJPTSBCQVJcbiIpOwo+ICAgCQlnb3RvIHN1Y2Nlc3M7Cj4g
Kwl9Cj4gICAKPiAtCWlmIChhbWRncHVfcmVhZF9wbGF0Zm9ybV9iaW9zKGFkZXYpKQo+ICsJaWYg
KGFtZGdwdV9yZWFkX3BsYXRmb3JtX2Jpb3MoYWRldikpIHsKPiArCQlkZXZfaW5mbyhhZGV2LT5k
ZXYsICJGZXRjaGVkIFZCSU9TIGZyb20gcGxhdGZvcm1cbiIpOwo+ICAgCQlnb3RvIHN1Y2Nlc3M7
Cj4gKwl9Cj4gICAKPiAgIAlEUk1fRVJST1IoIlVuYWJsZSB0byBsb2NhdGUgYSBCSU9TIFJPTVxu
Iik7Cj4gICAJcmV0dXJuIGZhbHNlOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
