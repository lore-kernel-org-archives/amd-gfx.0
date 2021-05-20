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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC05C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046466105A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046466105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30A286E433;
	Thu, 20 May 2021 19:24:10 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE5CF6E431;
 Thu, 20 May 2021 19:24:05 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 u25-20020a0568302319b02902ac3d54c25eso15904225ote.1; 
 Thu, 20 May 2021 12:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uDEsiQtbchmRIITN3UCJ9tWbvJK1S8JafoWC9Tf39fo=;
 b=cT527s+sufXiRjfevP2Z86/uo3kcGD/J3zfs21rZAvE9FxI/yXy4JxlWbMvo3xV8nw
 31J9i5dKdSOAY8W5i7n7sVEz/f45QGFodvdQ2PgvkF1O64CrRQ3LuSf7N8zMu4nU5bmd
 dPksVTTUuwMI9AaXqhPaWyFaaf/U5KkmA2c/sKtwJB3uQDoYEKf39Oq4ks//qmm7Bg3M
 mzcyotkXXBQBsJDlz72MxszK2dLyM+zdIfVTREUOyfRIEoYKUV991fUHX6XB2gD8qVpp
 s3EIUQpeY3jMSwMKdj5lwwbAgFDIq3vwDq8hYHKLM14ibVCSYstqzQKIFjZYvWLxL0Qk
 Wi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uDEsiQtbchmRIITN3UCJ9tWbvJK1S8JafoWC9Tf39fo=;
 b=GSd8yWJShOJ0PIdsqN2lQWZWj2tCI5y9Tx3avb4RG7Qd6WzJeOMeLtgB2mF5JkLM/N
 ZY07BYQCsmqyQu1kc5h/uzLWJXPWuxTduqVK1qkv4zU9bHW/56su4EzTZy+0IEfvmbZc
 KmPKZxL1/zy9tCWHDfGnefMgli59tXSwCIvjJeAjbXl8r92K9uQl+4Ts30lLNG7RuRVR
 ObUW+7hkwum2U648lmUMoxtoXNX1BVADyBqrEwTIEp8V9nKaPQnaE2ASBPOcos5h7ZVA
 8d4Q7leb6yctsb4vPVHAjhsgZoYR9wyZzTY/lCaUCfwOAttYbSV+qwODPUT7MisoSeHg
 V2sQ==
X-Gm-Message-State: AOAM530fitopju49gOQOacZ3UpNobBtwmjxzP0bNa/soMBxuDbxKZHsO
 QDkhAv49YBvBO1nI2J2Soo8MFbrskZNU5yrlDgs=
X-Google-Smtp-Source: ABdhPJyzye1K6JHvOg90QPOZBsYe6gdLyPfrjFwT1au75ov5XHlqzFhSAKtHadiPVsL4JEI9JtvR32tUOIE95DLglKc=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr5126794oti.23.1621538645387; 
 Thu, 20 May 2021 12:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-34-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-34-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:23:54 -0400
Message-ID: <CADnq5_N-V0uGfGtwTQGhQrT+ex7jG0t3ipu4+EBxzAEq6m_Jug@mail.gmail.com>
Subject: Re: [PATCH 33/38] drm/amd/amdgpu/sdma_v5_0: Fix typo in function name
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

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDQgQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zZG1hX3Y1XzAuYzo1NjM6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIHNk
bWFfdl8wX2N0eF9zd2l0Y2hfZW5hYmxlKCkuIFByb3RvdHlwZSB3YXMgZm9yIHNkbWFfdjVfMF9j
dHhfc3dpdGNoX2VuYWJsZSgpIGluc3RlYWQKPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogU3VtaXQgU2Vtd2FsIDxzdW1p
dC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBsaW51eC1tZWRpYUB2
Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnCj4gU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiAtLS0KPiAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgfCAyICstCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvc2RtYV92NV8wLmMKPiBpbmRleCA3NWQ3MzEwZjg0MzkyLi4yYTJiOWQ1MGFmYjcwIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMKPiBAQCAtNTcxLDcgKzU3
MSw3IEBAIHN0YXRpYyB2b2lkIHNkbWFfdjVfMF9ybGNfc3RvcChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgfQo+Cj4gIC8qKgo+IC0gKiBzZG1hX3ZfMF9jdHhfc3dpdGNoX2VuYWJsZSAt
IHN0b3AgdGhlIGFzeW5jIGRtYSBlbmdpbmVzIGNvbnRleHQgc3dpdGNoCj4gKyAqIHNkbWFfdjVf
MF9jdHhfc3dpdGNoX2VuYWJsZSAtIHN0b3AgdGhlIGFzeW5jIGRtYSBlbmdpbmVzIGNvbnRleHQg
c3dpdGNoCj4gICAqCj4gICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAgICogQGVu
YWJsZTogZW5hYmxlL2Rpc2FibGUgdGhlIERNQSBNRXMgY29udGV4dCBzd2l0Y2guCj4gLS0KPiAy
LjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
