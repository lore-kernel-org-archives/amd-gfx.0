Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3839FC55ABD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6DDE221EB
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 17:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2HEd60J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DDE221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954856E506;
	Fri, 13 Nov 2020 17:35:45 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE89F6E506;
 Fri, 13 Nov 2020 17:35:44 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id d142so8934128wmd.4;
 Fri, 13 Nov 2020 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S6otP4T92FhYb0o9zH9HwhqeFp2M3AuU45BWAEnFIGI=;
 b=N2HEd60JGqG0qkBalskauOSXB+NULzJV8EKlKKQjMPMSjWNTEYWuJu95YCQPjQqz15
 FpF60LB8aVIaGCA6u/ZVcbRu2YE/dT6FVxs1U60lEPoCGGkcmtGPcdaOcggTGN/1QrFq
 R+8Wo5RGM+m0Qs7VESHcr2sff3SBMkreNO64XuADvgs9MIY5qvzqf0PMjNdN6JPxSmu1
 JOHsyxCokR3/5m2Gc9DkChVCbM113VsbAcZVz+piLLtoARMZMd2/q261SmvRzXQtnKB1
 FHczIET1PuqTa9uULwmGsKDrShAe21s61rvHYbyJphqBrbxMZOTJcq5jz/sSZOngkR2B
 qN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S6otP4T92FhYb0o9zH9HwhqeFp2M3AuU45BWAEnFIGI=;
 b=C1JvIoLvK/mezfw+UxxTjxPgsQyUapv54iSQzRCh4e9Fgdl62xdUPCuiwExKuBJYVE
 G6/8eToXdUo2BtLOuqt9ESCY0Tr2cYFhRRrgzEOf/CrosKBSrRmzgfKVvvoP6OFutFRR
 qXJS7ZuvemCYKd6AmMayYz6uNXuWWyqtKs2Q+/PbMShwlnF9ni1HZkQHW9u4JhODLufh
 iOp/slczlanQ0tyPV7sW5YlPffDZGm9Z8GX5hr2i3H/mdRIPj1x49HShuIFItNyynMo0
 h4v18oxEmrZCpl3ZKY7lt6egxQdvphV4oOXjPS1VSkx96NwYaQKWBPEvPx8olGnhbgs2
 6mmQ==
X-Gm-Message-State: AOAM533MwxkOcEXWgm/ddiC9DiikQ0jnaDBxqRP0m3JgFVzN40j6SCdh
 Dgy+9N0pAImV77j7QK2a+G+32gVrXspWn2is0YQ=
X-Google-Smtp-Source: ABdhPJxF+0EsquFWFOhsdKMbhKyVEoU4mWq6nr1k3xX0fu+rqyDpbAXHH2R0sqIgLJqVkgN+428qDyu0fypinrEpH78=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr3557828wmb.39.1605288940212;
 Fri, 13 Nov 2020 09:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-41-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-41-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Nov 2020 12:35:28 -0500
Message-ID: <CADnq5_Mo5RepKQ_ZvG1VFHKtypSZXa4fvsKBD+6Z-HgSn+26gA@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amd/amdgpu/gfx_v7_0: Remove unused struct
 definition
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBOb3YgMTMsIDIwMjAgYXQgODo1MCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmM6NTIx
MTo0NTogd2FybmluZzog4oCYZ2Z4X3Y3XzBfaXBfYmxvY2vigJkgZGVmaW5lZCBidXQgbm90IHVz
ZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxlPV0KPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4g
Q2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogU3VtaXQgU2Vtd2FsIDxz
dW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51eC1tZWRp
YUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4g
U2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KCkFwcGxpZWQu
ICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djdfMC5jIHwgOSAtLS0tLS0tLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3
XzAuaCB8IDEgLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5jCj4gaW5kZXggY2IwN2JjMjFkY2JlNS4uMDRlMWU5
MmY1ZjNjZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdf
MC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuYwo+IEBAIC01
MjA4LDE1ICs1MjA4LDYgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y3XzBfZ2V0X2N1X2luZm8oc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAgICAgICBjdV9pbmZvLT5sZHNfc2l6ZSA9IDY0Owo+
ICB9Cj4KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBnZnhf
djdfMF9pcF9ibG9jayA9Cj4gLXsKPiAtICAgICAgIC50eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVf
R0ZYLAo+IC0gICAgICAgLm1ham9yID0gNywKPiAtICAgICAgIC5taW5vciA9IDAsCj4gLSAgICAg
ICAucmV2ID0gMCwKPiAtICAgICAgIC5mdW5jcyA9ICZnZnhfdjdfMF9pcF9mdW5jcywKPiAtfTsK
PiAtCj4gIGNvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBnZnhfdjdfMV9pcF9i
bG9jayA9Cj4gIHsKPiAgICAgICAgIC50eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVfR0ZYLAo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjdfMC5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y3XzAuaAo+IGluZGV4IDZmYjljMTUyNDY5MWYuLmVl
ZGNlN2QwMDdmMWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y3XzAuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92N18wLmgKPiBA
QCAtMjQsNyArMjQsNiBAQAo+ICAjaWZuZGVmIF9fR0ZYX1Y3XzBfSF9fCj4gICNkZWZpbmUgX19H
RlhfVjdfMF9IX18KPgo+IC1leHRlcm4gY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJz
aW9uIGdmeF92N18wX2lwX2Jsb2NrOwo+ICBleHRlcm4gY29uc3Qgc3RydWN0IGFtZGdwdV9pcF9i
bG9ja192ZXJzaW9uIGdmeF92N18xX2lwX2Jsb2NrOwo+ICBleHRlcm4gY29uc3Qgc3RydWN0IGFt
ZGdwdV9pcF9ibG9ja192ZXJzaW9uIGdmeF92N18yX2lwX2Jsb2NrOwo+ICBleHRlcm4gY29uc3Qg
c3RydWN0IGFtZGdwdV9pcF9ibG9ja192ZXJzaW9uIGdmeF92N18zX2lwX2Jsb2NrOwo+IC0tCj4g
Mi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmkt
ZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
