Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EE7C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24567611AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24567611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D22F6F508;
	Thu, 20 May 2021 19:23:34 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D62E88979E;
 Thu, 20 May 2021 19:23:31 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id c3so17425082oic.8;
 Thu, 20 May 2021 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k8jbqnkIhb6Scb2ilNgSqrLUoD8EKnp1ewooO1thaYY=;
 b=ky35ahVtuQfQMvjOeiiTTPbXaYneyr4RFONeMzlHZyexsj5rX8XhdDpXsJiz3dYVul
 wYEKc3B8k42wdypOpMotQdOBiW6RXqUf466s1oEBZQU6IkBUzqApaFH279BKcODv9hry
 PkF70uZo9+I53o7qHAZUR34SlhlZoBHznh7PXCQFdZ4P27ZO3q0mS1oAkkk6diq9K7wA
 H0TVgKnJXqieJQMfk5bah0AGLFSycfWfD1VdIj7QrdhLZc3kUcsgrJHYSJ5WnDM3V1ln
 buTBOgiEZaYLxzGvxv+fah+PD2XV36vh3/drhElt98f6HpQPL7x3i7dthMbIZ7mDX0/o
 QpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k8jbqnkIhb6Scb2ilNgSqrLUoD8EKnp1ewooO1thaYY=;
 b=qRd/go/MhSE4SEa6QuL4gEbhzZhp6+Bu++aC1RzlSro0TRUymgD686xWDrsmRNB6a9
 xrm+4cy9b6Jn3c/pQv0qU7hQUEcpV74YP+UW4YVOneY+7HwPcHxA1J1V6csnlBy2Ploz
 MsL6UAuHtXDeGeCJGD6wF6BdESQjD05AWysucqAce3seLXE9WNMxHa1D9WjKyIiuSvay
 evh3xNiKQTKZAlFVK4msJykNBfBAnKT1zqZPuqXp/A4QQRhPKgGzYriYqPGMkADSfJUI
 mSOtJG9gJSTL+h25PI+YPXvvVQ4aT2czqpXk3WHcjv+fE4vkAsSQdmkeRm6NVApVHGgD
 U52g==
X-Gm-Message-State: AOAM532WB9eZsCV5nrlGyxFxDTk5q5uEUYQLKo4T7IC4xh6SloDNXvc0
 SSBd2reB0g4WPoXUyQ3P9//S7qSwrBYfv8M3Qvk=
X-Google-Smtp-Source: ABdhPJy+NQtM83k5lhJDRCaPOOpyGysTMYGPd3KkfE/RldWsZC16fzPXRl9aFd4m2P2dyrXamOmLBaNBTAo1U4tUMGA=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr4210776oie.120.1621538611248; 
 Thu, 20 May 2021 12:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-33-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-33-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:23:20 -0400
Message-ID: <CADnq5_OMyd3JpAhjAsBmZGCNTqWTV4ZSOcvTv6jJCAokBg0y=Q@mail.gmail.com>
Subject: Re: [PATCH 32/38] drm/amd/amdgpu/sdma_v4_0: Realign functions with
 their headers
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDMgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3Y0XzAuYzo3NjQ6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIHNk
bWFfdjRfMF9wYWdlX3Jpbmdfc2V0X3dwdHIoKS4gUHJvdG90eXBlIHdhcyBmb3Igc2RtYV92NF8w
X3Jpbmdfc2V0X3dwdHIoKSBpbnN0ZWFkCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nk
bWFfdjRfMC5jOjgzMDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3Igc2RtYV92NF8w
X3Jpbmdfc2V0X3dwdHIoKS4gUHJvdG90eXBlIHdhcyBmb3Igc2RtYV92NF8wX3BhZ2VfcmluZ19z
ZXRfd3B0cigpIGluc3RlYWQKPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxA
bGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJp
LWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5l
bC5vcmcKPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gU2lnbmVkLW9mZi1i
eTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAtLS0KPiAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jCj4gaW5kZXggZDE5NzE4NWY3Nzg5MC4uYWU1NDY0ZTI1MzVhOCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzAuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfMC5jCj4gQEAgLTc1NCw3ICs3NTQsNyBA
QCBzdGF0aWMgdWludDY0X3Qgc2RtYV92NF8wX3JpbmdfZ2V0X3dwdHIoc3RydWN0IGFtZGdwdV9y
aW5nICpyaW5nKQo+ICB9Cj4KPiAgLyoqCj4gLSAqIHNkbWFfdjRfMF9wYWdlX3Jpbmdfc2V0X3dw
dHIgLSBjb21taXQgdGhlIHdyaXRlIHBvaW50ZXIKPiArICogc2RtYV92NF8wX3Jpbmdfc2V0X3dw
dHIgLSBjb21taXQgdGhlIHdyaXRlIHBvaW50ZXIKPiAgICoKPiAgICogQHJpbmc6IGFtZGdwdSBy
aW5nIHBvaW50ZXIKPiAgICoKPiBAQCAtODIwLDcgKzgyMCw3IEBAIHN0YXRpYyB1aW50NjRfdCBz
ZG1hX3Y0XzBfcGFnZV9yaW5nX2dldF93cHRyKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAg
fQo+Cj4gIC8qKgo+IC0gKiBzZG1hX3Y0XzBfcmluZ19zZXRfd3B0ciAtIGNvbW1pdCB0aGUgd3Jp
dGUgcG9pbnRlcgo+ICsgKiBzZG1hX3Y0XzBfcGFnZV9yaW5nX3NldF93cHRyIC0gY29tbWl0IHRo
ZSB3cml0ZSBwb2ludGVyCj4gICAqCj4gICAqIEByaW5nOiBhbWRncHUgcmluZyBwb2ludGVyCj4g
ICAqCj4gLS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
