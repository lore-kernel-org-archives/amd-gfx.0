Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD8BCA9EBC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 19:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CAB21D81
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 19:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CAB21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4F86EB7B;
	Fri, 25 Oct 2019 19:36:38 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 091826EB7B;
 Fri, 25 Oct 2019 19:36:37 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id p4so3617527wrm.8;
 Fri, 25 Oct 2019 12:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vKgsFbx8Ep6iOXlXatCgfl2QJqYHidBhx0D+NEJMyLo=;
 b=RRhuzKI8c4U1p+tdQFWcguF/6qY4TK7fPkqRCJzzF0phVPVkm7DGkg+rYS1K2vnN7o
 Ih/Ad2rU46+GfAyLfOYwMTGd39IKE/XgTmGQbpf//yixfPlhOGp/k9CHHu6l4WBva12J
 BhiZpxc1W4qt5yUR0SfcOgJA96YU6xseTcpRWifTTtrCn9jLZuvzA3c9vqtqS04mOpw7
 sIgDUGaokvU61221wxS+Nqn+cHfXkBDrtvHdteAzIR8N8T3/AsOCOIaOThp05jQk4/zh
 sNtVqpPksyIrmUSF1TyZf3SwC70Z5W+g+cmW9/cjfi266MqvS1XDwRC1kz+FOcGULjZf
 2TPA==
X-Gm-Message-State: APjAAAVPw9ttrbcuZZQElvoDDWV6+xZM0KW5qQTlHcyrtVrha6aOJaHD
 7/w1r11z2IIws9X6rgJ6FrB0rIUS/Z5ibE5IXZQ=
X-Google-Smtp-Source: APXvYqwMDwW4AyIxm3bcNrPMq1dwCxnVICIYRR/Y5+vKCesA43Yg/x9R3k2Irdc3Pwz6VVvg8ChPIZGNsdg/LFMO7nw=
X-Received: by 2002:a5d:6ac3:: with SMTP id u3mr4661857wrw.206.1572032195543; 
 Fri, 25 Oct 2019 12:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191019073242.21652-1-wambui@karuga.xyz>
 <2bed3fab-e84d-226d-b552-1ac088fc5d9c@amd.com>
In-Reply-To: <2bed3fab-e84d-226d-b552-1ac088fc5d9c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Oct 2019 15:36:23 -0400
Message-ID:
 <CADnq5_PeCmE-rmUaVDXtLNi20aMzYkeoLUtxHr9yT7P0Nix+qw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove assignment for return value
To: Harry Wentland <hwentlan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=vKgsFbx8Ep6iOXlXatCgfl2QJqYHidBhx0D+NEJMyLo=;
 b=OYW0esZZ6B8EKsDTY2vGfRPRy99SJ3ZPr9FUu3Pu00ygV96AVxKm2XvVThu2GBAKBE
 IP8FqmojtSAn97B4Lnko6Vl/CndCsFkjQRCZk0Qxwx9aYtaPvvzHsKjf1zUQjW0VfNR/
 WtSXgiVb0XdlwJ/9mBbEY/qE/44PoZJUbuVFtiHJjj/PSHL4+SSu77q6wDgeS91MArDg
 CFKAaEIYWSsWWAjy1u4icShmr+I5DJekVSuWShrkT7XD0obab0nMc9O4eML32tB31tqm
 ebfh++CM8OfUbK+c4gTIw2SnurUjVhfdzazZWgqY7dIsctZ870wOjpFN4wqwrhNzpQnM
 5eXQ==
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
Cc: "airlied@linux.ie" <airlied@linux.ie>, Wambui Karuga <wambui@karuga.xyz>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "outreachy-kernel@googlegroups.com" <outreachy-kernel@googlegroups.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025193623.On9tJ7dROSbEYuh_NQKw50WCJdxG-2coMqO7Vg1d_Uc@z>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFdlZCwgT2N0IDIzLCAyMDE5IGF0IDExOjA5IEFN
IEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBhbWQuY29tPiB3cm90ZToKPgo+IE9uIDIwMTktMTAt
MTkgMzozMiBhLm0uLCBXYW1idWkgS2FydWdhIHdyb3RlOgo+ID4gUmVtb3ZlIHVubmVjZXNzYXJ5
IGFzc2lnbm1lbnQgZm9yIHJldHVybiB2YWx1ZSBhbmQgaGF2ZSB0aGUKPiA+IGZ1bmN0aW9uIHJl
dHVybiB0aGUgcmVxdWlyZWQgdmFsdWUgZGlyZWN0bHkuCj4gPiBJc3N1ZSBmb3VuZCBieSBjb2Nj
aW5lbGxlOgo+ID4gQEAKPiA+IGxvY2FsIGlkZXhwcmVzc2lvbiByZXQ7Cj4gPiBleHByZXNzaW9u
IGU7Cj4gPiBAQAo+ID4KPiA+IC1yZXQgPQo+ID4gK3JldHVybgo+ID4gICAgICBlOwo+ID4gLXJl
dHVybiByZXQ7Cj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogV2FtYnVpIEthcnVnYSA8d2FtYnVpQGth
cnVnYS54eXo+Cj4KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guCj4KPiBSZXZpZXdlZC1ieTogSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+Cj4KPiBIYXJyeQo+Cj4KPiA+IC0t
LQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgfCA4ICsrLS0tLS0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vY2lrLmMKPiA+IGluZGV4IDYyZWFiODJhNjRmOS4uZGFmZjlhMmFmM2JlIDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYwo+ID4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9jaWsuYwo+ID4gQEAgLTIyMSw5ICsyMjEsNyBAQCBpbnQgY2lfZ2V0X3Rl
bXAoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gPiAgICAgICBlbHNlCj4gPiAgICAgICAg
ICAgICAgIGFjdHVhbF90ZW1wID0gdGVtcCAmIDB4MWZmOwo+ID4KPiA+IC0gICAgIGFjdHVhbF90
ZW1wID0gYWN0dWFsX3RlbXAgKiAxMDAwOwo+ID4gLQo+ID4gLSAgICAgcmV0dXJuIGFjdHVhbF90
ZW1wOwo+ID4gKyAgICAgcmV0dXJuIGFjdHVhbF90ZW1wICogMTAwMDsKPiA+ICB9Cj4gPgo+ID4g
IC8qIGdldCB0ZW1wZXJhdHVyZSBpbiBtaWxsaWRlZ3JlZXMgKi8KPiA+IEBAIC0yMzksOSArMjM3
LDcgQEAgaW50IGt2X2dldF90ZW1wKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ID4gICAg
ICAgZWxzZQo+ID4gICAgICAgICAgICAgICBhY3R1YWxfdGVtcCA9IDA7Cj4gPgo+ID4gLSAgICAg
YWN0dWFsX3RlbXAgPSBhY3R1YWxfdGVtcCAqIDEwMDA7Cj4gPiAtCj4gPiAtICAgICByZXR1cm4g
YWN0dWFsX3RlbXA7Cj4gPiArICAgICByZXR1cm4gYWN0dWFsX3RlbXAgKiAxMDAwOwo+ID4gIH0K
PiA+Cj4gPiAgLyoKPiA+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
