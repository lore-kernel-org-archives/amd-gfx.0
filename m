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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195FAC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D641A61363
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D641A61363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D6416F500;
	Thu, 20 May 2021 19:21:02 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766916F500;
 Thu, 20 May 2021 19:21:01 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 e27-20020a056820061bb029020da48eed5cso4029829oow.10; 
 Thu, 20 May 2021 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jFT2vUjneyK4vqRQTSud440oIlDIOlBm9ntEGOINv5Y=;
 b=D/khYlkLs8eViqkgfzspKIJORMK1dqfOo1QORFPm78nkMtTSIa1UQj6LQt0fIE6ssK
 O9lGaXHlOXL0EV3fv5Y7a3jr8Zi4S3yLbWxTmBOLNyY0PZvYryPpLCycq/h5tkzT2HuY
 3jV0KhJ1nlMefUkBn7EhcQ3JcPl/mvqQg2LfwO2IHXEmlwsyszD2SCOp6Oxpo90sUv48
 07FSiNdFZFri7Qmk2zpc9QYfYxH+jElnevL3fMYQsO5uiR4P7O5gYqgVfynSMG3iWNAI
 ffhBH8v2gU5bqy03nFTAr4jH8Vf9/R3ruvrIfz59jVqo0gHklxN+Pv9gT1P4hByy4TNd
 rnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jFT2vUjneyK4vqRQTSud440oIlDIOlBm9ntEGOINv5Y=;
 b=J3dqYhzER5uWhzi+1os5ZXiWWLxTP9ZJG9X46axwnjCPZoUYNrh3wIhnj7E/yWlhJw
 lStOqjT2APkWW2dWUZujB47VzLAXXxJCWanDmVpwY2xR/7rwpTzPf34AWj5ab0vBsY7l
 IldvJQiEbKMHaaqaZ2hBv0nYc7YRcm5UW5ddTmwKoZ8nmM+FPbaUmQ6yjyY+Ui4BFjpn
 Tg1shMi1vAEYmRxeT6677HY1cBkcL+HiyqbgKS2EJ+n8URyLEo48xK9WueRZUsp5szr1
 fYckow1KjJoLRJ/T62U+KMUkQzc41C0LhSdPUgjtMrvZ+Ni1askK9prlZECVPCrRbWLh
 d58g==
X-Gm-Message-State: AOAM533MiDoCD3BMi7k75YKgSPH9MC8RWhQtF1XulOWCfjrPM4CdWahv
 EoLgb4IbK7kwQvRW1CLF5nDRiNJluPoClddLc/g=
X-Google-Smtp-Source: ABdhPJwJQXId/bdVgc0jHCEOn9JarUKc13A1Cej/AgWqhMN32NoS8pW18t/ZaSTqNE9XaYPco1cgGarYCI/JzluP2as=
X-Received: by 2002:a4a:d543:: with SMTP id q3mr4945275oos.72.1621538460855;
 Thu, 20 May 2021 12:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-30-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-30-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:20:49 -0400
Message-ID: <CADnq5_PjnKC8qRMY7+TGfi2mpOXpiF-0bkm6VfB9+aqgi3bWmA@mail.gmail.com>
Subject: Re: [PATCH 29/38] drm/radeon/r100: Realign doc header with function
 'r100_cs_packet_parse_vline()'
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
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3IxMDAuYzoxNDIzOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciByMTAwX2NzX3Bh
Y2tldF9uZXh0X3ZsaW5lKCkuIFByb3RvdHlwZSB3YXMgZm9yIHIxMDBfY3NfcGFja2V0X3BhcnNl
X3ZsaW5lKCkgaW5zdGVhZAo+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBTdW1pdCBTZW13YWwgPHN1bWl0LnNlbXdhbEBs
aW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVs
Lm9yZwo+IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcKPiBTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3IxMDAuYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
MTAwLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYwo+IGluZGV4IGZjZmNhZWMyNWE5
ZWYuLjNjNGU3YzE1ZmQxNTkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
MTAwLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYwo+IEBAIC0xNDA2LDcg
KzE0MDYsNyBAQCBpbnQgcjEwMF9jc19wYXJzZV9wYWNrZXQwKHN0cnVjdCByYWRlb25fY3NfcGFy
c2VyICpwLAo+ICB9Cj4KPiAgLyoqCj4gLSAqIHIxMDBfY3NfcGFja2V0X25leHRfdmxpbmUoKSAt
IHBhcnNlIHVzZXJzcGFjZSBWTElORSBwYWNrZXQKPiArICogcjEwMF9jc19wYWNrZXRfcGFyc2Vf
dmxpbmUoKSAtIHBhcnNlIHVzZXJzcGFjZSBWTElORSBwYWNrZXQKPiAgICogQHA6ICAgICAgICAg
cGFyc2VyIHN0cnVjdHVyZSBob2xkaW5nIHBhcnNpbmcgY29udGV4dC4KPiAgICoKPiAgICogVXNl
cnNwYWNlIHNlbmRzIGEgc3BlY2lhbCBzZXF1ZW5jZSBmb3IgVkxJTkUgd2FpdHMuCj4gLS0KPiAy
LjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
