Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564EFC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3382B20672
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3382B20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C77556E924;
	Fri, 15 Nov 2019 16:12:53 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 558C16E924
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:12:52 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id z26so10182464wmi.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:12:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H/AZcIMjmxBt0sRmA9KI49nKazdfnS8rLZbryBP3KyQ=;
 b=nX6gT5+KuQvuqseOQpKnPbhtUMzTzdqxkJJQoir/5AzjSfP3kbusvwjpS6CbODZPLE
 4XovBh8mv4dlnI8GnCm4LSTluizKLjyer47KZu2Ye85YGNQBtTXnjyOt39i239gSTgZD
 50nZzAmsw85nz+pA2efl2Pg2wOa+8BiVZkJCb3C+9p9hnZhJuqNfX8vEZg/AH8M2jYiz
 1X95SoQIjKPSNgYJo2Zg+nRTs0Lm9zZaRbgHaFl7+achQBl8EIrJZyCogYX+cKDXzC4Y
 PyQj7PeHqUZcvDLY1ENeOUoKpSxLsYmkBoqwgsCFGGI2z5xs8K01j7bvfCO8AJSjn4rz
 uTrA==
X-Gm-Message-State: APjAAAUkrNa/q+IiVF17XyX3wp2iYshA20Y9rdUTc+EjW/NOJJb+QcrE
 jCi1X5NhJw/dAunNR36LgvVbq2zyks2t0pncPo02tg==
X-Google-Smtp-Source: APXvYqyRYq93eN0YxRSnMIaInjqzIPmQQedGiMKPwLLugiEz51W3PAw5+sH922yvp39IlGYmyBNnSbGN2T9hR5Bobzc=
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr3898710wmj.127.1573834370761; 
 Fri, 15 Nov 2019 08:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20191113192937.781329-1-alexander.deucher@amd.com>
In-Reply-To: <20191113192937.781329-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Nov 2019 11:12:39 -0500
Message-ID:
 <CADnq5_PsEm8mzr_5Ryj24MjdH_0CmuKBwTpHNaskfrLq0p8udw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/nv: add asic func for fetching vbios from rom
 directly
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=H/AZcIMjmxBt0sRmA9KI49nKazdfnS8rLZbryBP3KyQ=;
 b=vEy6GJr+UJ29ra9Hn3cTa3vvufaoUOWe/AC3WsfsOvHqqdpaxgy9MbkQD5GavkO+FY
 96UuQr6q+WefotbEHJkQCQAEjU+w9LxL4EV4l2+CQDAIWma2PBChsDIujEyXzxEdvI5d
 b8eNyUxXIxs+RRc2ZK5KFb0vFghfYaSmil1R7lAVWBVwGm4ioyvWiMe9htOCdbRnxzlr
 MNA9s9CYFFwMGSUgfLXfJg9LRoZdqkNNDEYrhsKM3Qe62dqJf9dqDiB6LYGXyrl/7inf
 p5GJyYYF4Gh+Yw0rDg9qWt9JQUPrav9kp7s+CxUfV2Ag9LtexAqF8++4lFDUb4+mCsvn
 gbzA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115161239.DA4OsNI3xg2NWtbEjmQtxXcVBBrZVVQAUkPvswdJhak@z>

UGluZz8KCk9uIFdlZCwgTm92IDEzLCAyMDE5IGF0IDI6MjkgUE0gQWxleCBEZXVjaGVyIDxhbGV4
ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gTmVlZGVkIGFzIGEgZmFsbGJhY2sgaWYgdGhl
IHZiaW9zIGNhbid0IGJlIGZldGNoZWQgYnkgb3RoZXIgbWVhbnMuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L252LmMKPiBpbmRleCA3MjgzZDYxOThiODkuLmFkMDRkMWQ2ZTljNyAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYwo+IEBAIC00MCw2ICs0MCw3IEBACj4gICNpbmNs
dWRlICJnYy9nY18xMF8xXzBfc2hfbWFzay5oIgo+ICAjaW5jbHVkZSAiaGRwL2hkcF81XzBfMF9v
ZmZzZXQuaCIKPiAgI2luY2x1ZGUgImhkcC9oZHBfNV8wXzBfc2hfbWFzay5oIgo+ICsjaW5jbHVk
ZSAic211aW8vc211aW9fMTFfMF8wX29mZnNldC5oIgo+Cj4gICNpbmNsdWRlICJzb2MxNS5oIgo+
ICAjaW5jbHVkZSAic29jMTVfY29tbW9uLmgiCj4gQEAgLTE1Niw4ICsxNTcsMjcgQEAgc3RhdGlj
IGJvb2wgbnZfcmVhZF9kaXNhYmxlZF9iaW9zKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+
ICBzdGF0aWMgYm9vbCBudl9yZWFkX2Jpb3NfZnJvbV9yb20oc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4ICpiaW9zLCB1MzIg
bGVuZ3RoX2J5dGVzKQo+ICB7Cj4gLSAgICAgICAvKiBUT0RPOiB3aWxsIGltcGxlbWVudCBpdCB3
aGVuIFNNVSBoZWFkZXIgaXMgYXZhaWxhYmxlICovCj4gLSAgICAgICByZXR1cm4gZmFsc2U7Cj4g
KyAgICAgICB1MzIgKmR3X3B0cjsKPiArICAgICAgIHUzMiBpLCBsZW5ndGhfZHc7Cj4gKwo+ICsg
ICAgICAgaWYgKGJpb3MgPT0gTlVMTCkKPiArICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+
ICsgICAgICAgaWYgKGxlbmd0aF9ieXRlcyA9PSAwKQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7Cj4gKyAgICAgICAvKiBBUFUgdmJpb3MgaW1hZ2UgaXMgcGFydCBvZiBzYmlvcyBpbWFn
ZSAqLwo+ICsgICAgICAgaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkKPiArICAgICAgICAg
ICAgICAgcmV0dXJuIGZhbHNlOwo+ICsKPiArICAgICAgIGR3X3B0ciA9ICh1MzIgKiliaW9zOwo+
ICsgICAgICAgbGVuZ3RoX2R3ID0gQUxJR04obGVuZ3RoX2J5dGVzLCA0KSAvIDQ7Cj4gKwo+ICsg
ICAgICAgLyogc2V0IHJvbSBpbmRleCB0byAwICovCj4gKyAgICAgICBXUkVHMzIoU09DMTVfUkVH
X09GRlNFVChTTVVJTywgMCwgbW1ST01fSU5ERVgpLCAwKTsKPiArICAgICAgIC8qIHJlYWQgb3V0
IHRoZSByb20gZGF0YSAqLwo+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IGxlbmd0aF9kdzsgaSsr
KQo+ICsgICAgICAgICAgICAgICBkd19wdHJbaV0gPSBSUkVHMzIoU09DMTVfUkVHX09GRlNFVChT
TVVJTywgMCwgbW1ST01fREFUQSkpOwo+ICsKPiArICAgICAgIHJldHVybiB0cnVlOwo+ICB9Cj4K
PiAgc3RhdGljIHN0cnVjdCBzb2MxNV9hbGxvd2VkX3JlZ2lzdGVyX2VudHJ5IG52X2FsbG93ZWRf
cmVhZF9yZWdpc3RlcnNbXSA9IHsKPiAtLQo+IDIuMjMuMAo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
