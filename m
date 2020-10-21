Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF9EC4363A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 11:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28FD21707
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 11:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvZNFGhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28FD21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B4D6EA8E;
	Wed, 21 Oct 2020 11:01:32 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB5F6E122
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 11:01:31 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id c15so1473945ejs.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WvU6li+jxnwCZX0jkUeOQVcvnDDaGcZ7inEi+BLoabo=;
 b=XvZNFGhITqipdVtKr76ARmipA7wi/lksf69XewUzezImd+x5ITXDgkY6LeuWITaLQ1
 WwVWG/Tpms8XjmtxLO09fddHvCQJQMJJTOEl6zlvDcxPp26Wuy6gPa0G00jVT34fxs6g
 Q+h0GwaSynD7BBLMLc08Hq86LuYaXsVOSauzMjz6YP5IJ5Wa4a8TkJlBsOClw/VHIKwC
 K6plOeFid/PHmMrtM1x9DU+TAbXqsyn+KfYnzbxTjzkNpROH0YxFmcRF+33Ar2scbXpo
 EJ0NgcAUniExwmkZLizbCLdeqxtz8UVhYR52tX8MVUzsplyOqhoTpNNG8avgmCTi6DGh
 VcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=WvU6li+jxnwCZX0jkUeOQVcvnDDaGcZ7inEi+BLoabo=;
 b=XgR888giNn7VPcDXR2YwRU0Wq1VhaIX+kF1/xkTtZpFp7TI050OQIL8CoqV4bcpLhW
 7HGwcKhGZxlMYm3UgwOzrymJjUeRmqCVjl//p4wPJGDCEAHcLro6K9JSSDWWq2JDqsgy
 Z4kTSGyoI8JZEK91rGozknCiZ6AKUl5PJzvEGrEiCErSas6+1MSlh9Pbv2ZUbcXB/vkZ
 uIYcOywNg5x1Jr62YSda+ugCcqbNERRajUWVjmA5zyTg38denp4Mq3XA3/ge3IYAiJmK
 QWHog/txOLcFY/z3UgLLwKyjH2Mgw6SQw3E3XXeqdJ5NXNbIIQ7hiP3YyK3PimrrVijT
 iEKg==
X-Gm-Message-State: AOAM532YJmsn75QlXBogIXhPkJ2AC8Df+cmNyTbpnrALnsb4xob07tgM
 oc4JnlUvnQbdJNABZQuziE0=
X-Google-Smtp-Source: ABdhPJxN3LmuPaizKdCAAc+njfpsKH80x981Y63/7Fx/zgsJfR/8MSWdbxP1d3oqbTJ/6a35Q1tgpQ==
X-Received: by 2002:a17:906:9396:: with SMTP id
 l22mr2833706ejx.36.1603278090036; 
 Wed, 21 Oct 2020 04:01:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y25sm1905580edr.7.2020.10.21.04.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2020 04:01:29 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm/amdgpu: add support to configure MALL for
 sienna_cichlid (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201020202617.2465215-1-alexander.deucher@amd.com>
 <20201020202617.2465215-2-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6eb36beb-6b24-9b15-95d5-7d6e105266f8@gmail.com>
Date: Wed, 21 Oct 2020 13:01:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201020202617.2465215-2-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAuMTAuMjAgdW0gMjI6MjYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gRnJvbTogTGlrdW4g
R2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KPgo+IEVuYWJsZSBNZW1vcnkgQWNjZXNzIGF0IExhc3Qg
TGV2ZWwgKE1BTEwpIGZlYXR1cmUgZm9yIHNpZW5uYV9jaWNobGlkLgo+Cj4gdjI6IGRyb3AgbW9k
dWxlIG9wdGlvbi4gIFdlIG5lZWQgdG8gYWRkIFVBUEkgc28gdXNlcnNwYWNlIGNhbgo+IHJlcXVl
c3QgTUFMTCBwZXIgYnVmZmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogTGlrdW4gR2FvIDxMaWt1bi5H
YW9AYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogSGF3a2luZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0Bh
bWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmggfCAzICsrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgfCAz
ICsrLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCAyICstCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gaW5kZXggZmZlYTNiODliOWRhLi45
MjlkN2NiOTJkYzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+
IEBAIC03Niw2ICs3Niw5IEBAIHN0cnVjdCBhbWRncHVfYm9fbGlzdF9lbnRyeTsKPiAgIC8qIFBU
RSBpcyBoYW5kbGVkIGFzIFBERSBmb3IgVkVHQTEwIChUcmFuc2xhdGUgRnVydGhlcikgKi8KPiAg
ICNkZWZpbmUgQU1ER1BVX1BURV9URgkJKDFVTEwgPDwgNTYpCj4gICAKPiArLyogTUFMTCBub2Fs
bG9jIGZvciBzaWVubmFfY2ljaGxpZCwgcmVzZXJ2ZWQgZm9yIG9sZGVyIEFTSUNzICAqLwo+ICsj
ZGVmaW5lIEFNREdQVV9QVEVfTk9BTExPQwkoMVVMTCA8PCA1OCkKPiArCj4gICAvKiBQREUgQmxv
Y2sgRnJhZ21lbnQgU2l6ZSBmb3IgVkVHQTEwICovCj4gICAjZGVmaW5lIEFNREdQVV9QREVfQkZT
KGEpCSgodWludDY0X3QpYSA8PCA1OSkKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192MTBfMC5jCj4gaW5kZXggNDBhZjE3NjEwMjA3Li5lZjM4NWE1MjkwMTMgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IEBAIC00ODYsNyArNDg2LDggQEAgc3Rh
dGljIHZvaWQgZ21jX3YxMF8wX2VtaXRfcGFzaWRfbWFwcGluZyhzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcsIHVuc2lnbmVkIHZtaWQKPiAgIC8qCj4gICAgKiBQVEUgZm9ybWF0IG9uIE5BVkkgMTA6
Cj4gICAgKiA2Mzo1OSByZXNlcnZlZAo+IC0gKiA1ODo1NyByZXNlcnZlZAo+ICsgKiA1OCByZXNl
cnZlZCBhbmQgZm9yIHNpZW5uYV9jaWNobGlkIGlzIHVzZWQgZm9yIE1BTEwgbm9hbGxvYwo+ICsg
KiA1NyByZXNlcnZlZAo+ICAgICogNTYgRgo+ICAgICogNTUgTAo+ICAgICogNTQgcmVzZXJ2ZWQK
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzIuYwo+IGluZGV4IDE4ZWNhMGQ0ZGJj
Yy4uYWU2MTU4NDU2MDk0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjVfMi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8y
LmMKPiBAQCAtNzA3LDcgKzcwNyw3IEBAIHN0YXRpYyBpbnQgc2RtYV92NV8yX2dmeF9yZXN1bWUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJCXRlbXAgJj0gMHhGRjBGRkY7Cj4gICAJ
CXRlbXAgfD0gKChDQUNIRV9SRUFEX1BPTElDWV9MMl9fREVGQVVMVCA8PCAxMikgfAo+ICAgCQkJ
IChDQUNIRV9XUklURV9QT0xJQ1lfTDJfX0RFRkFVTFQgPDwgMTQpIHwKPiAtCQkJIDB4MDEwMDAw
MDApOwo+ICsJCQkgU0RNQTBfVVRDTDFfUEFHRV9fTExDX05PQUxMT0NfTUFTSyk7Cj4gICAJCVdS
RUczMihzZG1hX3Y1XzJfZ2V0X3JlZ19vZmZzZXQoYWRldiwgaSwgbW1TRE1BMF9VVENMMV9QQUdF
KSwgdGVtcCk7Cj4gICAKPiAgIAkJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHsKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
