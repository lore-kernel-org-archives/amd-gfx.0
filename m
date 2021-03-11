Return-Path: <SRS0=bDL0=IJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE42FC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 15:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CC864ECD
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Mar 2021 15:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CC864ECD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E94BD6EE1C;
	Thu, 11 Mar 2021 15:45:49 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2571D6EE19;
 Thu, 11 Mar 2021 15:45:48 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id 75so1879324otn.4;
 Thu, 11 Mar 2021 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Dj1b435OwL0C7Sqq7OdQpwXWVHQq3vgVpWO0wPZ5Dgo=;
 b=qiOeeCUDCA7u3TMTY13HPIUdlF6/asjAyl37ohmx/PGIOUfxluxExjOmgLe1NfbmpB
 UIBm3WO1Cy1R667E4Ba+sF08y5FgG6b4Bz+ZK+SCqO6eAmRRYBscVNpzB+qzDZUU1TC2
 1QPiyG4sRvjQbFdo/LQsFxxjdlnaaeGD0+54mMJX/kM76HJfH1c0UxW3g+OJRPD8mze+
 oeOjYpoHJv/a/hWpWtMgPkcukqQScgx+AUxT4G2c5W14Hni2npeaFd7Ua+hRjdohmdiA
 7+LRTDtZVgwWqAANl7YRcG4DSEZOBLjSYIkWjk67H+q+bmMImhvXEcEjCMg1Uiw1KkZ4
 RYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Dj1b435OwL0C7Sqq7OdQpwXWVHQq3vgVpWO0wPZ5Dgo=;
 b=L1A0QnI2ROs5iWQyLF7r4YLQ7OuZD3b6dXimJ57J2kAGaUVthc/bzbjuur57/k4ujV
 mYhtzU/PrhNYO3+NLFw0xbcPBeIbUkWP6tP5RO/9HuMs0t49jScxNonpt6XvWxbs4X+W
 02bCiT0W9lV8B6kmOjpYoqKlp8Yk8NlRomfDiRfK9mtgGqtnuvi2i7LU0meZS+edzWJZ
 6imlG8MQqO5d2dD8cfeSXywPwFFt9+6m2qqyDlQNhrZHOt4JkkMfY6aPeMywmlhaI5dW
 xdjABHQ3CFIepb9Xfe0H1XRvnuWVQ9qB/0XRq60aVNxts/93Vec/bVVMJdGVGpx1b5bC
 Kh9w==
X-Gm-Message-State: AOAM5329jsyE6pzuDyuI/QMcTwRmcNVt5IKv/HCaOPLQPeOZb8XXqXCB
 021HU4OTlpBRXgeu/Of44zzCunn6uhOjAfE1h/Y=
X-Google-Smtp-Source: ABdhPJwUO4kSw5whs+wB8MEk/HKoof0iWuMd4hKI17G1cVPP9pN1buIaDS2tD2VWbcF4ZrgnHpirBXzjw2RyQdgi06M=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr7758055ott.132.1615477547483; 
 Thu, 11 Mar 2021 07:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20210209124439.408140-1-bigeasy@linutronix.de>
 <41d0f7db-c2b4-f618-42a7-da9f7cdb76b4@amd.com>
In-Reply-To: <41d0f7db-c2b4-f618-42a7-da9f7cdb76b4@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Mar 2021 10:45:36 -0500
Message-ID: <CADnq5_Mzu4jePK50yzNH-vnH9tB-FUJuM_UcE2850hWM+p8yAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: Remove in_interrupt() usage.
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
Cc: David Airlie <airlied@linux.ie>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFR1ZSwgRmViIDksIDIwMjEgYXQgNzo1MCBBTSBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+Cj4gUmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9y
IHRoZSBzZXJpZXMuCj4KPiBBbSAwOS4wMi4yMSB1bSAxMzo0NCBzY2hyaWViIFNlYmFzdGlhbiBB
bmRyemVqIFNpZXdpb3I6Cj4gPiBGb2xrcywKPiA+Cj4gPiBpbiB0aGUgZGlzY3Vzc2lvbiBhYm91
dCBwcmVlbXB0IGNvdW50IGNvbnNpc3RlbmN5IGFjcm9zcyBrZXJuZWwKPiA+IGNvbmZpZ3VyYXRp
b25zOgo+ID4KPiA+ICAgaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJuZWwub3JnJTJGciUyRjIwMjAwOTE0MjA0
MjA5LjI1NjI2NjA5MyU0MGxpbnV0cm9uaXguZGUlMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q2Nocmlz
dGlhbi5rb2VuaWclNDBhbWQuY29tJTdDNjZjZmI0NDlmMGJhNDc1ZGQ3NmIwOGQ4Y2NmODdhODUl
N0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDg0NzE0ODc2
ODYyMjgzJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlq
b2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRh
PWcwNHNRb3F2Zmt1SHpwbGlnJTJGJTJCT3J1cXpteXlwSWhhcXJrS1UweGVJSjgwJTNEJmFtcDty
ZXNlcnZlZD0wCj4gPgo+ID4gaXQgd2FzIGNvbmNsdWRlZCB0aGF0IHRoZSB1c2FnZSBvZiBpbl9p
bnRlcnJ1cHQoKSBhbmQgcmVsYXRlZCBjb250ZXh0Cj4gPiBjaGVja3Mgc2hvdWxkIGJlIHJlbW92
ZWQgZnJvbSBub24tY29yZSBjb2RlLgo+ID4KPiA+IEluIHRoZSBsb25nIHJ1biwgdXNhZ2Ugb2Yg
J3ByZWVtcHRpYmxlLCBpbl8qaXJxIGV0Yy4nIHNob3VsZCBiZSBiYW5uZWQgZnJvbQo+ID4gZHJp
dmVyIGNvZGUgY29tcGxldGVseS4KPiA+Cj4gPiBUaGlzIHNlcmllcyBhZGRyZXNzZXMgcGFydHMg
b2YgdGhlIGFtZGdwdSBkcml2ZXIuICBUaGVyZSBhcmUgc3RpbGwgY2FsbCBzaXRlcwo+ID4gbGVm
dCBpbiBpbiB0aGUgYW1kZ3B1IGRyaXZlci4KPiA+Cj4gPiB2MeKApnYyOgo+ID4gICAgIC0gTGlt
aXQgdG8gYWRtZ3B1IG9ubHkKPiA+ICAgICAtIHVzZSAiYm9vbCIgaW5zdGVhZCBvZiAiYm9vbCA9
PSB0cnVlIgo+ID4KPiA+IFNlYmFzdGlhbgo+ID4KPiA+Cj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
