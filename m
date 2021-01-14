Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2B3C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 14:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D297023A53
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D297023A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6472C6E3DB;
	Thu, 14 Jan 2021 14:06:37 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B696E3DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 14:06:35 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id b24so5279586otj.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FqVRxnaEr6fxC2Np3c8vMV9XMhe2EyasTUleGDdIiio=;
 b=D6MODicRMqbQQrqQVvw89GhxAZYUzTkESKlqdoc3nmD11tujGqgeuWnlkzNHjBMuA/
 rsCgb9LUAd5IvQ5pLw9D9I9tRD9xM2wmqMvyNJhkartSsDQx7kZsRJuu9w+zFVrLqNRG
 RXYnIam3eUm0Onzm6xxIraQEAHClT+3yvDCXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FqVRxnaEr6fxC2Np3c8vMV9XMhe2EyasTUleGDdIiio=;
 b=TojWzfaDKOQk+5jxEdkiULdBYycFiO+1pzx2M/GZZ2VsgNXZyKTxiNZvY9hu6ofxfc
 TaezDpsoPHKATltLErXJ+WTG0ZVpPOE1xjSM9lpLkd4SV2okQDTLiUsRn08zcv8Ie6x7
 RsOir3wVKax7KVNS44ru6gRU4JZHo8hHYXd46cLjNUaQl/RiHbZM3rl9u1enh1XTVbgC
 5siuvEX9RlcgwG5f+h/46WMySwl4yU8cEcxuKLqdGhwg53m/fyBOsnlVAUMNFYBWFgD2
 Eq9N2Mifu+fygloVn5K5MXmKEuTToAUkufv3nyJLsc1TGe2WvoH/7SMJ289HEw1+whfE
 1LGA==
X-Gm-Message-State: AOAM531WEx5bqa1tL3vFsePUD0BeTwojfeb2Qy2Jgnyve3g/PWimdeY4
 q4IdMarc9fzhtBsXFVKQm/m8oYs69RwY5RFtE81FxQ==
X-Google-Smtp-Source: ABdhPJyw9HaWyyzCICTVUTT7wUNnge/s8N2IbJcsIfDuGT9CYuReZqXPAG/KZccfmoHhjVFHWIs/pOYUFiPFjiTQAg8=
X-Received: by 2002:a05:6830:1bef:: with SMTP id
 k15mr4587211otb.303.1610633194394; 
 Thu, 14 Jan 2021 06:06:34 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com>
 <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
 <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
 <CABXGCsOcBMT4rL-bb4K_TzK70YmQsgNX37sHEHiqp_1kK1_UEQ@mail.gmail.com>
 <5f9e7752-68e8-aa5f-80ff-bb1196ea458d@amd.com>
In-Reply-To: <5f9e7752-68e8-aa5f-80ff-bb1196ea458d@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 14 Jan 2021 15:06:23 +0100
Message-ID: <CAKMK7uHhpEUXmJCS8=EzxYmT0R1UUF-RCRWx0guFKZo0JKTHhw@mail.gmail.com>
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBKYW4gMTQsIDIwMjEgYXQgMjo1NiBQTSBDaHJpc3RpYW4gS8O2bmlnCjxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gQW0gMTQuMDEuMjEgdW0gMDE6MjIgc2Nocmll
YiBNaWtoYWlsIEdhdnJpbG92Ogo+ID4gT24gVHVlLCAxMiBKYW4gMjAyMSBhdCAwMTo0NSwgQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPiA+PiBCdXQg
d2hhdCB5b3UgaGF2ZSBpbiB5b3VyIGxvZ3Mgc28gZmFyIGFyZSBvbmx5IHVucmVsYXRlZCBzeW1w
dG9tcywgdGhlCj4gPj4gcm9vdCBvZiB0aGUgcHJvYmxlbSBpcyB0aGF0IHNvbWVib2R5IGlzIGxl
YWtpbmcgbWVtb3J5Lgo+ID4+Cj4gPj4gV2hhdCB5b3UgY291bGQgZG8gYXMgd2VsbCBpcyB0byB0
cnkgdG8gZW5hYmxlIGttZW1sZWFrCj4gPiBJIGNhcHR1cmVkIHNvbWUgbWVtbGVha3MuCj4gPiBE
byB0aGV5IGNvbnRhaW4gYW55IHVzZWZ1bCBpbmZvcm1hdGlvbj8KPgo+IFVuZm9ydHVuYXRlbHkg
bm90IG9mIGhhbmQuCj4KPiBJIGFsc28gZG9uJ3Qgc2VlIGFueSBidWcgcmVwb3J0cyBmcm9tIG90
aGVyIHBlb3BsZSBhbmQgY2FuJ3QgcmVwcm9kdWNlCj4gdGhlIGxhc3QgYmFja3RyYWNlIHlvdSBz
ZW5kIG91dCBUVE0gaGVyZS4KPgo+IERvIHlvdSBoYXZlIGFueSBsb2NhbCBtb2RpZmljYXRpb25z
IG9yIHNwZWNpYWwgc2V0dXAgaW4geW91ciBzeXN0ZW0/Cj4gTGlrZSBicGYgc2NyaXB0cyBvciBz
b21ldGhpbmcgbGlrZSB0aGF0PwoKVGhlcmUncyBhbm90aGVyIGJ1ZyByZXBvcnQgKGZvciByY2Fy
LWR1LCBiaXNlY3RlZCB0byB0aGUgYSBzd2l0Y2ggdG8KdXNlIG1vcmUgY21hIGhlbHBlcnMpIGFi
b3V0IGxlYWtpbmcgbW1hcHMsIHdoaWNoIGtlZXBzIHRvbyBtYW55IGZiCmFsaXZlLCBzbyBtYXli
ZSB3ZSBoYXZlIGdhaW5lZCBhIHJlZmNvdW50IGxlYWsgc29tZXdoZXJlIHJlY2VudGx5LiBCdXQK
Y291bGQgYWxzbyBiZSB0b3RhbGx5IHVucmVsYXRlZC4KLURhbmllbAoKCgo+Cj4gQ2hyaXN0aWFu
Lgo+Cj4gPgo+ID4gWzFdIGh0dHBzOi8vcGFzdGViaW4uY29tL24wRkU3SHN1Cj4gPiBbMl0gaHR0
cHM6Ly9wYXN0ZWJpbi5jb20vTVVYNTVMMWsKPiA+IFszXSBodHRwczovL3Bhc3RlYmluLmNvbS9h
M0ZUN0RWRwo+ID4gWzRdIGh0dHBzOi8vcGFzdGViaW4uY29tLzFBTHZKS3o3Cj4gPgo+ID4gLS0K
PiA+IEJlc3QgUmVnYXJkcywKPiA+IE1pa2UgR2F2cmlsb3YuCj4gPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+ID4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiA+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gPiBodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPgo+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAoKCgotLSAKRGFuaWVsIFZldHRlcgpT
b2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDovL2Jsb2cuZmZ3bGwuY2gK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
