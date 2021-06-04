Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858F9C4743C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52FC5613E3
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 16:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FC5613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B2B6F62A;
	Fri,  4 Jun 2021 16:57:30 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A60076F627;
 Fri,  4 Jun 2021 16:57:28 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id t140so5125352oih.0;
 Fri, 04 Jun 2021 09:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IN3SgezFLQfNZ7veTbzUM3bPaQ1v48sm/05DwTa7/PU=;
 b=tBcoFOsv6b8ruMCJzxqbZ7QxP0UdsQMhL22S84VurvWGPoKPkq0mm2qfBbxR5v5iHR
 kUqCVUVnxX0ZXiUFFV5PzTNR/SqTFJkZYe7g7OeCa6ODdLxm7Zxc2e4kLHG36z/A5gcL
 39XoA+F+kyAXsS+gxPws9Hwlswz0/oe0ZJBDWro/VPTilrdWQ2eqr9WT5vcV6UvrVABw
 VbofKoss8GTut/9QzqOLoPlbK7O8MXGQ+r4Vr6xOqedV461uOlR2Kn357m7PE1gURvKJ
 vTagEoDcDW0z03oWaiVo35xr6K20QNYslFjo4fvU42TQRr8/cf1aJyh0GVrFHXPVaUUY
 3FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IN3SgezFLQfNZ7veTbzUM3bPaQ1v48sm/05DwTa7/PU=;
 b=bc/MJyLEGFOapiuRsBvIfH30AdFX8V4wHhtqzEtBRW+tb7wbuj2yI7ym3799ibGtoP
 QWl7KWU8t7idJLSGhBYjNR0H88Q05n1qK0LDER6FbgOrxUsGNXG2UzsaZPXj+a/02tUB
 PJC8IJOGQL8uQLUXRk+VCx+rLKEVzJ4nagYRSsyym2N/jRKXNfo9k7d9AIhqiojCuwEz
 hF2cu3oG0vUAih5W/xlmMef84VK+SjlhdbB/TUnE7aR0MjIMZGVJCAhVi9Vdcl7D2Wgf
 HpXKKMmd1XwHJrIw/E5nrWTZU+YByBK+kYMSD/l/ZdJWf/EBrE0EO8TM0Y83skpXiH2U
 HSww==
X-Gm-Message-State: AOAM532ywBUX7qiLJSWp2As8gCOhuvlSrgUNU2RHY2cminxAOmZ/Cfya
 d/e+GtTtfKUKIzwHu6FXBxNcFlGgZ8DTV4zotb4=
X-Google-Smtp-Source: ABdhPJycUpGDHDmpx2H0gKioVDhBClmCP6ZvzuaN3KQq9J2gvL7XNOsEat8k57/mMr8h9vtahb00hVhbvGi77TBEjXI=
X-Received: by 2002:a05:6808:206:: with SMTP id
 l6mr10953538oie.5.1622825848035; 
 Fri, 04 Jun 2021 09:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <1622690940-10972-1-git-send-email-wanjiabing@vivo.com>
 <3d7fcdb9-990b-270b-f87b-d7fe157c6b2f@gmail.com>
In-Reply-To: <3d7fcdb9-990b-270b-f87b-d7fe157c6b2f@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Jun 2021 12:57:17 -0400
Message-ID: <CADnq5_M5p=id9EtvtNGQyM6QC6QJNNWuraMi1LyoUZir6vUeZQ@mail.gmail.com>
Subject: Re: [PATCH] drm: amdgpu: Remove unneeded semicolon in amdgpu_vm.c
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
Cc: Philip Yang <Philip.Yang@amd.com>, Wan Jiabing <wanjiabing@vivo.com>,
 Mihir Bhogilal Patel <Mihir.Patel@amd.com>, Roy Sun <Roy.Sun@amd.com>,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Nirmoy Das <nirmoy.das@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIEZyaSwgSnVuIDQsIDIwMjEgYXQgMzowMyBBTSBD
aHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6
Cj4KPiBBbSAwMy4wNi4yMSB1bSAwNToyOCBzY2hyaWViIFdhbiBKaWFiaW5nOgo+ID4gRml4IGZv
bGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6Cj4gPiAuL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jOjE3MjY6Mi0zOiBVbm5lZWRlZCBzZW1pY29sb24KPiA+Cj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXYW4gSmlhYmluZyA8d2FuamlhYmluZ0B2aXZvLmNvbT4KPgo+IFJldmlld2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4KPiA+IC0t
LQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDIgKy0KPiA+
ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiA+IGluZGV4IDI0NjAzNzEuLjIz
MTc0NWIgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiA+
IEBAIC0xNzIzLDcgKzE3MjMsNyBAQCBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5nKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ID4KPiA+ICAgICAgICAgICAgICAgYW1kZ3B1X3Jl
c19uZXh0KCZjdXJzb3IsIG51bV9lbnRyaWVzICogQU1ER1BVX0dQVV9QQUdFX1NJWkUpOwo+ID4g
ICAgICAgICAgICAgICBzdGFydCA9IHRtcDsKPiA+IC0gICAgIH07Cj4gPiArICAgICB9Cj4gPgo+
ID4gICAgICAgciA9IHZtLT51cGRhdGVfZnVuY3MtPmNvbW1pdCgmcGFyYW1zLCBmZW5jZSk7Cj4g
Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
