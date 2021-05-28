Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63739C47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2459E61355
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 08:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2459E61355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB8996F47D;
	Fri, 28 May 2021 08:01:52 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2F66F47D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 08:01:52 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id q7so4047844lfr.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 01:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fkEiQZXKuUSKXy2s1+8iDS973fcF9WDUpSCL4s8HXFA=;
 b=KYKYIpJX9NoTPpFiglvxkRPqp8aJXrJSZgv8RcKPJhbXsC8ry81KPe+aRzpLQyyJNa
 KD63+aZVaodWzVuOu/roy5SQr6Ihfi5JKORleWB4xT5g+eXNCjExtz0xw/QgGjqbhJB1
 u4Aelnn3Jikfj6NVqcSKkt04mU8vvkz2B9efAMBatWiM6MExHNX2SC7GenzpNqZmcJ18
 QldV2UTSvT/Sob3ln3HIf2fq11yCnuRjjBlRzeSI2jjyMw4AVqnNMR8I6IUQeVU3QjHl
 QoGKiR4C325qk1NvpXDY5PJw8YJa01aAIuSEQwlo1t/+Ev/EMfVU+x/BgdX4cHHlkpjR
 jVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fkEiQZXKuUSKXy2s1+8iDS973fcF9WDUpSCL4s8HXFA=;
 b=exQfX/739/Wu6WfNJ4DlquX2wxu5KUSps3khqUZ51NCgUKPVzoaA+PrI6+cIdJ4t4S
 16SmvkfSGAO9mnQK1WNyyCR2btYqIVKiCIFgKhDYEaotM3ec4FcGdwATXoXm4J7ri5mF
 8ir8pXTF1EXWlze7yjh34komUiwskukH1Wi8vno+edOAAz4arOHL16XdsC9GfNd5P+OU
 vCjSu3VzfnMi+B6beZ9JtnuFx3hYyofowpmw7gVH0Fl4h4U1SSufjRc/ufIv+AgqG1LX
 CszU7ynD07zvLrjnNe6Uzw6uLbsoflrEQR9pOUvluUqaUPhz35EGP4IgBbmLTp2tlLAI
 ywmg==
X-Gm-Message-State: AOAM530ON7GJgmmp8Wo1y8OiZvcTQATYBLbMcfjp4vjVK6y/pCELAEBu
 rpSTALD3v7KwTSWwYdeDMhE=
X-Google-Smtp-Source: ABdhPJztzGaHi0vD/I3Z1s+O3lNNrDAkmLEAt9fsCERU0PiC/wguRnxAZ3/4ZkP8sIbeYXKCD6vBCg==
X-Received: by 2002:a05:6512:308a:: with SMTP id
 z10mr4874865lfd.601.1622188910608; 
 Fri, 28 May 2021 01:01:50 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2960:4608:1392:c6ae?
 ([2a02:908:1252:fb60:2960:4608:1392:c6ae])
 by smtp.gmail.com with ESMTPSA id t1sm405142lfp.168.2021.05.28.01.01.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 May 2021 01:01:50 -0700 (PDT)
Subject: Re: [PATCH v2 5/6] drm/amdgpu: remove unused code
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210527115343.20133-1-nirmoy.das@amd.com>
 <20210527115343.20133-5-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <24aa35b5-4358-7f17-0308-1974ac22a8bc@gmail.com>
Date: Fri, 28 May 2021 10:01:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527115343.20133-5-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjcuMDUuMjEgdW0gMTM6NTMgc2NocmllYiBOaXJtb3kgRGFzOgo+IFJlbW92ZSB1bnVzZWQg
Y29kZSByZWxhdGVkIHRvIHNoYWRvdyBCTy4KPgo+IHYyOiByZW1vdmluZyBzaGFkb3cgYm8gcHRy
IGZyb20gYmFzZSBjbGFzcy4KPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5k
YXNAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jIHwgMjkgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5oIHwgIDYgLS0tLS0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMzUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jCj4gaW5kZXggYTYzYjQ1MGNkNjAzLi5kYjljNjQ4MzY1NTYgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTYzOCwzNSArNjM4
LDYgQEAgaW50IGFtZGdwdV9ib19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4g
ICAJcmV0dXJuIHI7Cj4gICB9Cj4KPiAtaW50IGFtZGdwdV9ib19jcmVhdGVfc2hhZG93KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2LAo+IC0JCQkgICAgdW5zaWduZWQgbG9uZyBzaXplLAo+IC0J
CQkgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8pCj4gLXsKPiAtCXN0cnVjdCBhbWRncHVfYm9fcGFy
YW0gYnA7Cj4gLQlpbnQgcjsKPiAtCj4gLQlpZiAoYm8tPnNoYWRvdykKPiAtCQlyZXR1cm4gMDsK
PiAtCj4gLQltZW1zZXQoJmJwLCAwLCBzaXplb2YoYnApKTsKPiAtCWJwLnNpemUgPSBzaXplOwo+
IC0JYnAuZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOwo+IC0JYnAuZmxhZ3MgPSBBTURH
UFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0M7Cj4gLQlicC50eXBlID0gdHRtX2JvX3R5cGVfa2Vy
bmVsOwo+IC0JYnAucmVzdiA9IGJvLT50Ym8uYmFzZS5yZXN2Owo+IC0JYnAuYm9fcHRyX3NpemUg
PSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ibyk7Cj4gLQo+IC0JciA9IGFtZGdwdV9ib19jcmVhdGUo
YWRldiwgJmJwLCAmYm8tPnNoYWRvdyk7Cj4gLQlpZiAoIXIpIHsKPiAtCQliby0+c2hhZG93LT5w
YXJlbnQgPSBhbWRncHVfYm9fcmVmKGJvKTsKPiAtCQltdXRleF9sb2NrKCZhZGV2LT5zaGFkb3df
bGlzdF9sb2NrKTsKPiAtCQlsaXN0X2FkZF90YWlsKCZiby0+c2hhZG93LT5zaGFkb3dfbGlzdCwg
JmFkZXYtPnNoYWRvd19saXN0KTsKPiAtCQltdXRleF91bmxvY2soJmFkZXYtPnNoYWRvd19saXN0
X2xvY2spOwo+IC0JfQo+IC0KPiAtCXJldHVybiByOwo+IC19Cj4gLQo+ICAgLyoqCj4gICAgKiBh
bWRncHVfYm9fY3JlYXRlX3VzZXIgLSBjcmVhdGUgYW4gJmFtZGdwdV9ib191c2VyIGJ1ZmZlciBv
YmplY3QKPiAgICAqIEBhZGV2OiBhbWRncHUgZGV2aWNlIG9iamVjdAo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPiBpbmRleCA5YWZjY2Y2YzY2ZjIuLmZhNzUy
NTExNDhiZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmgKPiBAQCAtMTA0LDkgKzEwNCw2IEBAIHN0cnVjdCBhbWRncHVfYm8gewo+ICAgCXN0cnVjdCBh
bWRncHVfdm1fYm9fYmFzZQkqdm1fYm87Cj4gICAJLyogQ29uc3RhbnQgYWZ0ZXIgaW5pdGlhbGl6
YXRpb24gKi8KPiAgIAlzdHJ1Y3QgYW1kZ3B1X2JvCQkqcGFyZW50Owo+IC0Jc3RydWN0IGFtZGdw
dV9ibwkJKnNoYWRvdzsKPiAtCj4gLQo+Cj4gICAjaWZkZWYgQ09ORklHX01NVV9OT1RJRklFUgo+
ICAgCXN0cnVjdCBtbXVfaW50ZXJ2YWxfbm90aWZpZXIJbm90aWZpZXI7Cj4gQEAgLTMwMCw5ICsy
OTcsNiBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZV92bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKPiAgIAkJCXN0cnVjdCBhbWRncHVfYm9fdm0gKip1Ym9fcHRyKTsKPiAgIHZvaWQgYW1kZ3B1
X2JvX2ZyZWVfa2VybmVsKHN0cnVjdCBhbWRncHVfYm8gKipibywgdTY0ICpncHVfYWRkciwKPiAg
IAkJCSAgIHZvaWQgKipjcHVfYWRkcik7Cj4gLWludCBhbWRncHVfYm9fY3JlYXRlX3NoYWRvdyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAtCQkJICAgIHVuc2lnbmVkIGxvbmcgc2l6ZSwK
PiAtCQkJICAgIHN0cnVjdCBhbWRncHVfYm8gKmJvKTsKPiAgIGludCBhbWRncHVfYm9fa21hcChz
dHJ1Y3QgYW1kZ3B1X2JvICpibywgdm9pZCAqKnB0cik7Cj4gICB2b2lkICphbWRncHVfYm9fa3B0
cihzdHJ1Y3QgYW1kZ3B1X2JvICpibyk7Cj4gICB2b2lkIGFtZGdwdV9ib19rdW5tYXAoc3RydWN0
IGFtZGdwdV9ibyAqYm8pOwo+IC0tCj4gMi4zMS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
