Return-Path: <SRS0=q3BR=7P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E3C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0578F206A2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2020 18:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t10q8/kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0578F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B16E26E455;
	Tue,  2 Jun 2020 18:59:24 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF5F6E455
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2020 18:59:23 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id d128so4236409wmc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2020 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bIcdRmZB8os4JtLHzrMzgmYxY6W9M6szPkp+BdedmZA=;
 b=t10q8/kQ0uXBba6hDgcnlgkEJ+g/zeaTCIkp5Xpw/4Is3mC59eDIqxc8O9fFdMxmpF
 AwVXCTugsbTcGoLsxCHIC80T2dWRTMHfpl2IUc/FBnR6GJx1nbhCLLqgm4dPIV6vDzSu
 nQpl+k4VEl+3S0/062LOt6yOCBiznayPoQiDdzgBerI0moI48A0tw4oSPjAUoVj0yUs2
 jebuJVJMMqOuBOHmyNktr33Ut9MRYxBzWF1FlYf5w4C2YHHYrzNDitIkzbTCYE01Dpim
 majiVRGB1omrO8ezu/iocL4GMxYHpWm4xMMThlSyVJhKzubyuOp/iFPK0g7Qi11VNlAV
 HVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bIcdRmZB8os4JtLHzrMzgmYxY6W9M6szPkp+BdedmZA=;
 b=TczM+9bmJDsNiaYCfkcv/1XZYOqTDxMuAr1hlJa+yoQXIqoAqaPHdkMKJkhM0TT+Bm
 vs3djcO/CCTgvPNu5NEGI7MsJGmCZeTzyibkMhnJqTbRs+Bt0yewVySbzLJoa0T0LFHk
 kplngNqP8bGaBunMo8q/egPGWhCVn6p0W9IdnD3xKBS40+eUllF5h0C8gRhhJbKwqEv2
 JdV3P8qsbdNXrkY6syHjRR7VjvtOHWuFkHKU6gPcfDJQwUX4sAho80G27ub662Bt9+/7
 d6KDGRSfXDECRe1tuhmV+pPb7Oc3MHttKHl8HYOk+MIML7WLHX1VZW8CUhIfaQ+P/rup
 bBdw==
X-Gm-Message-State: AOAM533rPiznQlOCmtUZUreTu9tZXSIWFnQNUIygGtr4w1pV8QiNKZdl
 pqfufXdLhlPDfJzFyAdb3/9xlb1cmUWoyZ3zBPw0lgGJ
X-Google-Smtp-Source: ABdhPJyITNt5sV8WAu7FeoFG3qyf4ngrTaVXMjvZaibLBfmI/I3WFn7gIJ7finEF3rKgjK5bzF2vXmXmHl8vjYdSpNY=
X-Received: by 2002:a7b:cd96:: with SMTP id y22mr5419913wmj.56.1591124362300; 
 Tue, 02 Jun 2020 11:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
 <20200601180239.1267430-58-alexander.deucher@amd.com>
 <78297506-1670-da85-21d0-b6a32dc945c2@gmail.com>
In-Reply-To: <78297506-1670-da85-21d0-b6a32dc945c2@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2020 14:59:11 -0400
Message-ID: <CADnq5_MyXrdqe-Sp9hkuUXXD1S4keh5NerrNqNOw8Zw-NPFA=Q@mail.gmail.com>
Subject: Re: [PATCH 061/207] drm/amdgpu/mes10.1: implement the ring functions
 of mes specific
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gMiwgMjAyMCBhdCA2OjAwIEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IEFtIDAxLjA2LjIwIHVtIDIwOjAw
IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+ID4gRnJvbTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1k
LmNvbT4KPiA+Cj4gPiBJbXBsZW1lbnQgbWVzIHJpbmcgZnVuY3Rpb25zIGFuZCBzZXQgdXAgdGhl
bS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBKYWNrIFhpYW8gPEphY2suWGlhb0BhbWQuY29tPgo+
ID4gQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+
IFJldmlld2VkLWJ5OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4g
PiAtLS0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbWVzX3YxMF8xLmMgfCA0MyAr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0
aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9t
ZXNfdjEwXzEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTBfMS5jCj4gPiBp
bmRleCA0ZjdlMzQ1NjczY2EuLjgwZjY4MTJkOGVjZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L21lc192MTBfMS5jCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9tZXNfdjEwXzEuYwo+ID4gQEAgLTMzLDYgKzMzLDQ3IEBAIE1PRFVMRV9GSVJN
V0FSRSgiYW1kZ3B1L25hdmkxMF9tZXMuYmluIik7Cj4gPgo+ID4gICAjZGVmaW5lIE1FU19FT1Bf
U0laRSAgIDIwNDgKPiA+Cj4gPiArc3RhdGljIHZvaWQgbWVzX3YxMF8xX3Jpbmdfc2V0X3dwdHIo
c3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ID4gK3sKPiA+ICsgICAgIHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKPiA+ICsKPiA+ICsgICAgIGlmIChyaW5nLT51c2Vf
ZG9vcmJlbGwpIHsKPiA+ICsgICAgICAgICAgICAgYXRvbWljNjRfc2V0KChhdG9taWM2NF90Kikm
YWRldi0+d2Iud2JbcmluZy0+d3B0cl9vZmZzXSwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJpbmctPndwdHIpOwo+Cj4gVGhpcyBhdG9taWM2NF90IHR5cGUgY2FzZSBzdGlsbCBsb29r
cyBmaXNoeSB0byBtZS4gSUlSQyB3ZSBhZ3JlZWQgdG8gbm90Cj4gdXNlIHRoZW0sIGRvbid0IHdl
PwoKV2UgdXNlIHRoZW0gZm9yIGFsbCB0aGUgb3RoZXIgcmluZyBjb2RlLiAgSWYgd2UgY2hhbmdl
IGl0LCB3ZSBzaG91bGQKcHJvYmFibHkgY2hhbmdlIGl0IGV2ZXJ5d2hlcmUuICBJIGRvbid0IHRo
aW5rIHdlIGV2ZXIgYWdyZWVkIG9uIGEKcmVwbGFjZW1lbnQuCgo+Cj4gPiArICAgICAgICAgICAg
IFdET09SQkVMTDY0KHJpbmctPmRvb3JiZWxsX2luZGV4LCByaW5nLT53cHRyKTsKPiA+ICsgICAg
IH0gZWxzZSB7Cj4gPiArICAgICAgICAgICAgIEJVRygpOwo+Cj4gRG8gd2UgcmVhbGx5IG5lZWQg
dGhlIEJVRygpIGhlcmUgYW5kIGJlbG93Pwo+CgpXZSBzaG91bGRuJ3QgZXZlciBhY3R1YWxseSBo
aXQgdGhlc2UgY2FzZXMgc2luY2UgdGhlIHJpbmdzIGRvbid0IHdvcmsKd2l0aG91dCBkb29yYmVs
bHMuICBNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIGEgV0FSTl9PTigpIGlmCnNvbWVv
bmUgdHJpZXMgdG8gc2V0IHJpbmctPnVzZV9kb29yYmVsbCB0byBmYWxzZSBmb3IgTUVTLgoKQWxl
eAoKPiBDaHJpc3RpYW4uCj4KPiA+ICsgICAgIH0KPiA+ICt9Cj4gPiArCj4gPiArc3RhdGljIHU2
NCBtZXNfdjEwXzFfcmluZ19nZXRfcnB0cihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gPiAr
ewo+ID4gKyAgICAgcmV0dXJuIHJpbmctPmFkZXYtPndiLndiW3JpbmctPnJwdHJfb2Zmc107Cj4g
PiArfQo+ID4gKwo+ID4gK3N0YXRpYyB1NjQgbWVzX3YxMF8xX3JpbmdfZ2V0X3dwdHIoc3RydWN0
IGFtZGdwdV9yaW5nICpyaW5nKQo+ID4gK3sKPiA+ICsgICAgIHU2NCB3cHRyOwo+ID4gKwo+ID4g
KyAgICAgaWYgKHJpbmctPnVzZV9kb29yYmVsbCkKPiA+ICsgICAgICAgICAgICAgd3B0ciA9IGF0
b21pYzY0X3JlYWQoKGF0b21pYzY0X3QgKikKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgJnJpbmctPmFkZXYtPndiLndiW3JpbmctPndwdHJfb2Zmc10pOwo+ID4gKyAgICAg
ZWxzZQo+ID4gKyAgICAgICAgICAgICBCVUcoKTsKPiA+ICsgICAgIHJldHVybiB3cHRyOwo+ID4g
K30KPiA+ICsKPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzIG1lc192
MTBfMV9yaW5nX2Z1bmNzID0gewo+ID4gKyAgICAgLnR5cGUgPSBBTURHUFVfUklOR19UWVBFX01F
UywKPiA+ICsgICAgIC5hbGlnbl9tYXNrID0gMSwKPiA+ICsgICAgIC5ub3AgPSAwLAo+ID4gKyAg
ICAgLnN1cHBvcnRfNjRiaXRfcHRycyA9IHRydWUsCj4gPiArICAgICAuZ2V0X3JwdHIgPSBtZXNf
djEwXzFfcmluZ19nZXRfcnB0ciwKPiA+ICsgICAgIC5nZXRfd3B0ciA9IG1lc192MTBfMV9yaW5n
X2dldF93cHRyLAo+ID4gKyAgICAgLnNldF93cHRyID0gbWVzX3YxMF8xX3Jpbmdfc2V0X3dwdHIs
Cj4gPiArICAgICAuaW5zZXJ0X25vcCA9IGFtZGdwdV9yaW5nX2luc2VydF9ub3AsCj4gPiArfTsK
PiA+ICsKPiA+ICAgc3RhdGljIGludCBtZXNfdjEwXzFfYWRkX2h3X3F1ZXVlKHN0cnVjdCBhbWRn
cHVfbWVzICptZXMsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBt
ZXNfYWRkX3F1ZXVlX2lucHV0ICppbnB1dCkKPiA+ICAgewo+ID4gQEAgLTMxNSw2ICszNTYsOCBA
QCBzdGF0aWMgaW50IG1lc192MTBfMV9yaW5nX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCj4gPgo+ID4gICAgICAgcmluZyA9ICZhZGV2LT5tZXMucmluZzsKPiA+Cj4gPiArICAgICBy
aW5nLT5mdW5jcyA9ICZtZXNfdjEwXzFfcmluZ19mdW5jczsKPiA+ICsKPiA+ICAgICAgIHJpbmct
Pm1lID0gMzsKPiA+ICAgICAgIHJpbmctPnBpcGUgPSAwOwo+ID4gICAgICAgcmluZy0+cXVldWUg
PSAwOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
