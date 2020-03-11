Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D3BC0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 21:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2304D2074B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 21:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqMaBaCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2304D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D394589650;
	Wed, 11 Mar 2020 21:16:22 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3738889650
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 21:16:22 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id r15so4587233wrx.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tLfpn3vce0nKqXguAWg2JAa5HMLRfXS41cP4hU7kVhQ=;
 b=hqMaBaCRTdX3tbwbpB1UkKx+YqQu7TaxoSxNUyjUumNG8KDqdtg80fm8lF4hzGD16u
 zOj1XUhM1nQBotUZq3MOnyAz+p99TQYFT5MMScvF+fFSWR48y7M1LRmcQLDyZevkryef
 pxV7PzoerVzfRB58zq9godj9GA2kp79oc/hN1+rJzR1Op97mXIiB6UllHuZZqStnRxGb
 MQbXXSMB158q3TCqvcsK8fwZ95kavYKnFXQazz11lCbIujoNrm5OYVOoseEhzTPFJdPS
 Tk2tAfLQoKxghM3wxDgqkFyHicYegGME0L0Z5NqfsOYT69fSmVokgnwP7w1Qj6RQsnrY
 ueLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tLfpn3vce0nKqXguAWg2JAa5HMLRfXS41cP4hU7kVhQ=;
 b=nosisbpF5E07zAmyBg/fzZCzwBnNrogjEMBCJjVbdWqktzK1O2kw6gphyY0kLcP4P8
 yoBHJVrCUuIlL9uBttAcNerwb90fMwPXZOqU+z+YLCYNRv60LeSBcJpL/2EZBrADT12K
 XkVDXO3uIWjvifx47SDdlleWzkF+eG5qS4Gwq3gPmISrzM9IgE0+hLxqI/T/5Rol8b3n
 Tqm8bJJ0lao3kIPZSs7KI5Ja4/O0tllPkuSTP8xAaqzZFDJ39AO+inGIGuBRchtERtDy
 PygLUjp6ii7Agq7RFYcosOO7SNvs4QJ/G65OjebFJgfAN3zdDl5ly8HEtNBgbWecLyqP
 5VwA==
X-Gm-Message-State: ANhLgQ02kbL5zBepnYUU0Bst1Rq606bRIHfKuDtuKnjKxWGIjBAM7Y/W
 AKqsKj5/sKvB261ZbfDZDAwzjNk+7SeQBk90LlI=
X-Google-Smtp-Source: ADFU+vtcIV6jnv/DurqprMKKxPW6mSNuSzHEpDUdTEaNgIpEI2QhF64VfCDjUtImNWVdc4cS1vJGd9XrPtDtQbpag0o=
X-Received: by 2002:a5d:5446:: with SMTP id w6mr6655257wrv.419.1583961380815; 
 Wed, 11 Mar 2020 14:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200311203321.149060-1-tom.stdenis@amd.com>
In-Reply-To: <20200311203321.149060-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Mar 2020 17:16:09 -0400
Message-ID: <CADnq5_O8ts=x39MZtKaE_xxTzNWQ6RhqxmnKR6f44aiwPFGcFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix GPR read from debugfs (v2)
To: Tom St Denis <tom.stdenis@amd.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBNYXIgMTEsIDIwMjAgYXQgNDozMyBQTSBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlz
QGFtZC5jb20+IHdyb3RlOgo+Cj4gVGhlIG9mZnNldCBpbnRvIHRoZSBhcnJheSB3YXMgc3BlY2lm
aWVkIGluIGJ5dGVzIGJ1dCBzaG91bGQKPiBiZSBpbiB0ZXJtcyBvZiAzMi1iaXQgd29yZHMuICBB
bHNvIHByZXZlbnQgbGFyZ2UgcmVhZHMgdGhhdAo+IHdvdWxkIGFsc28gY2F1c2UgYSBidWZmZXIg
b3ZlcnJlYWQuCj4KPiB2MjogIFJlYWQgZnJvbSBjb3JyZWN0IG9mZnNldCBmcm9tIGludGVybmFs
IHN0b3JhZ2UgYnVmZmVyLgo+Cj4gU2lnbmVkLW9mZi1ieTogVG9tIFN0IERlbmlzIDx0b20uc3Rk
ZW5pc0BhbWQuY29tPgo+IEFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
YnVnZnMuYyB8IDYgKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RlYnVnZnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1
Z2ZzLmMKPiBpbmRleCAwMDk0MmFmYzRlMTMuLjAyYmIxYmUxMWZmZSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+IEBAIC03ODQsMTEgKzc4NCwx
MSBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfZGVidWdmc19ncHJfcmVhZChzdHJ1Y3QgZmlsZSAq
ZiwgY2hhciBfX3VzZXIgKmJ1ZiwKPiAgICAgICAgIHNzaXplX3QgcmVzdWx0ID0gMDsKPiAgICAg
ICAgIHVpbnQzMl90IG9mZnNldCwgc2UsIHNoLCBjdSwgd2F2ZSwgc2ltZCwgdGhyZWFkLCBiYW5r
LCAqZGF0YTsKPgo+IC0gICAgICAgaWYgKHNpemUgJiAzIHx8ICpwb3MgJiAzKQo+ICsgICAgICAg
aWYgKHNpemUgPiA0MDk2IHx8IHNpemUgJiAzIHx8ICpwb3MgJiAzKQo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsKPgo+ICAgICAgICAgLyogZGVjb2RlIG9mZnNldCAqLwo+IC0gICAg
ICAgb2Zmc2V0ID0gKnBvcyAmIEdFTk1BU0tfVUxMKDExLCAwKTsKPiArICAgICAgIG9mZnNldCA9
ICgqcG9zICYgR0VOTUFTS19VTEwoMTEsIDApKSA+PiAyOwo+ICAgICAgICAgc2UgPSAoKnBvcyAm
IEdFTk1BU0tfVUxMKDE5LCAxMikpID4+IDEyOwo+ICAgICAgICAgc2ggPSAoKnBvcyAmIEdFTk1B
U0tfVUxMKDI3LCAyMCkpID4+IDIwOwo+ICAgICAgICAgY3UgPSAoKnBvcyAmIEdFTk1BU0tfVUxM
KDM1LCAyOCkpID4+IDI4Owo+IEBAIC04MjYsNyArODI2LDcgQEAgc3RhdGljIHNzaXplX3QgYW1k
Z3B1X2RlYnVnZnNfZ3ByX3JlYWQoc3RydWN0IGZpbGUgKmYsIGNoYXIgX191c2VyICpidWYsCj4g
ICAgICAgICB3aGlsZSAoc2l6ZSkgewo+ICAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWx1ZTsK
Pgo+IC0gICAgICAgICAgICAgICB2YWx1ZSA9IGRhdGFbb2Zmc2V0KytdOwo+ICsgICAgICAgICAg
ICAgICB2YWx1ZSA9IGRhdGFbcmVzdWx0ID4+IDJdOwo+ICAgICAgICAgICAgICAgICByID0gcHV0
X3VzZXIodmFsdWUsICh1aW50MzJfdCAqKWJ1Zik7Cj4gICAgICAgICAgICAgICAgIGlmIChyKSB7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcmVzdWx0ID0gcjsKPiAtLQo+IDIuMjQuMQo+Cj4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4
IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
