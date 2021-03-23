Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A5C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:52:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A6D61983
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A6D61983
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF8F6E0CD;
	Tue, 23 Mar 2021 14:52:08 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89FD16E0CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 14:52:07 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 s11-20020a056830124bb029021bb3524ebeso2940243otp.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7PxFNKB0BBnVjuMRwzgSYeiGelQIoL3LiXJbMXvgpCA=;
 b=K19Eom5Mpq/mmTe8IYHvU25xGMYT1eu6ET4Ojbf3Two/sEDsikr3aKvwfWmioG/8Ll
 /Z8VWWy4E3LdiWF9iVPE3br0Bz+ZgSBjrMdmWcqc/3N2rcpH9xdqNBNgi89R6D77BVeV
 /vrGa7nbm5nmqQDWsGsBP3KAkHVGxSa6+iBxGSlFLTpRpcbr/MO1XaCWAtoW1Wl1hLt5
 6R3pgSYPXjNoLGHDCFPtNaldUoy7mNLF39DloCqP+BCPnyxYPLrSuErr+Tz2s4QYNS3G
 0AwV5l5AiVhxlC7D98mHwJPKBCu1rZRGiGehf93ZaX3Cc3FSg6v08vHnEN/RsnjHzu4k
 IIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7PxFNKB0BBnVjuMRwzgSYeiGelQIoL3LiXJbMXvgpCA=;
 b=aAW2OGSXbKA8DKSVPdcPLT3lhHySFTB1V44zq+rWtPu3ejW6Gypi1/o3RhZ7eF1KSk
 DebU+mo7KsbSbT0XStGT+SfuX2SGI+xIN4IR9xbEzJPqEOnw0BteLTLO1s/QbWICFHyF
 FznQycVuHngyRYLRuiy5Nze5c4+dYnFwxXyGqVlUpi1f3s4132x/7a3fRZdl+GXx8/W0
 sRQBbfcPcEcih4ZRcsV6/SmDjX9xukhTHww3dJ0bFzyR/rRZhdBVNwgJrfAQ81pDA1Bf
 OMBcVojV9t9XvYr7NyyM4FC5XnERGVm29AP1cedZFpnVdZNSO5Iu1hMpCrPSmfaPJC1/
 yWyw==
X-Gm-Message-State: AOAM533UOXXD0AuJm80b1B+CNVJPvZ/OyNr9zH9zMDBZZbQPFuvKvInC
 CoZPIOtOYLX3ARD8MI5PuTn+l997y5nebRdOd4Y=
X-Google-Smtp-Source: ABdhPJyCD8d8eRf0fdRXEAq4dU9CkqgcQCfpdQ+uV9uu4tRTkA1PVMhfeqyKPrORLSCnZjcvDbt+twicfUw/sTBbmHI=
X-Received: by 2002:a9d:d89:: with SMTP id 9mr4759017ots.23.1616511126973;
 Tue, 23 Mar 2021 07:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210319122510.24377-1-christian.koenig@amd.com>
In-Reply-To: <20210319122510.24377-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Mar 2021 10:51:56 -0400
Message-ID: <CADnq5_MtHF5nF8P=Afy0QzvnpV5brd0zN7YtfvbXaJ1yzqjPBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove irq_src->data handling
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Emily Deng <Emily.Deng@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBNYXIgMTksIDIwMjEgYXQgODoyNSBBTSBDaHJpc3RpYW4gS8O2bmlnCjxja29lbmln
LmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBUaGF0IGlzIHVudXNlZCBmb3Ig
cXVpdGUgc29tZSB0aW1lIG5vdy4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfaXJxLmMgfCA1IC0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9pcnEuaCB8IDEgLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj4gaW5kZXggYWYwMjYxMDk0
MjFhLi4wMzQxMjU0MzQyN2EgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2lycS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lycS5jCj4gQEAgLTM4MiwxMSArMzgyLDYgQEAgdm9pZCBhbWRncHVfaXJxX2Zpbmkoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4KPiAgICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShz
cmMtPmVuYWJsZWRfdHlwZXMpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIHNyYy0+ZW5hYmxl
ZF90eXBlcyA9IE5VTEw7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNyYy0+ZGF0YSkg
ewo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAga2ZyZWUoc3JjLT5kYXRhKTsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGtmcmVlKHNyYyk7Cj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhZGV2LT5pcnEuY2xpZW50W2ldLnNvdXJjZXNbal0gPSBOVUxM
Owo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAgICAgfQo+ICAgICAg
ICAgICAgICAgICBrZnJlZShhZGV2LT5pcnEuY2xpZW50W2ldLnNvdXJjZXMpOwo+ICAgICAgICAg
ICAgICAgICBhZGV2LT5pcnEuY2xpZW50W2ldLnNvdXJjZXMgPSBOVUxMOwo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmgKPiBpbmRleCBhYzUyN2U1ZGVhZTYuLmNmNjExNjY0
ODMyMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJx
LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmgKPiBAQCAt
NjIsNyArNjIsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2lycV9zcmMgewo+ICAgICAgICAgdW5zaWduZWQg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bV90eXBlczsKPiAgICAgICAgIGF0b21p
Y190ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqZW5hYmxlZF90eXBlczsKPiAgICAg
ICAgIGNvbnN0IHN0cnVjdCBhbWRncHVfaXJxX3NyY19mdW5jcyAgICAgICAqZnVuY3M7Cj4gLSAg
ICAgICB2b2lkICpkYXRhOwo+ICB9Owo+Cj4gIHN0cnVjdCBhbWRncHVfaXJxX2NsaWVudCB7Cj4g
LS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
