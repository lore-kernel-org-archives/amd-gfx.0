Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D33C432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE1AF20718
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 14:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1AF20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71CCF6EB1C;
	Thu, 14 Nov 2019 14:50:00 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3666EB1C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 14:49:59 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id l7so6787048wrp.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 06:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YuMX35PPS8aXuq43tj/suaGYpayVfdV6aGlfRx6fz74=;
 b=qLUZ2c7SSzdt9H1jQIW60ecIL9vHaHSN3X8oxfnZYg8FWsP04QzOeZJW50ycyazcgo
 x70jSK7JS8/0BZv3jvBnw8IBGiOybsUJCGDWUYKEJkUzjmUG001v4Qd7Ddt2/ivgkRRE
 S5QK7nxr55vCF7tb1i2uEIAfzI8D+kBOtLeJSDr1O+trMCKY96X0SJyMVe/dG7c5hIZX
 7RhvT+LR/bBtrA9NyztWyya0EUph0PkJlFEO+AG0Eyp9vS7k6qhYYcr0s7CFgMLsVxOb
 kiOJH2KU49Tc1Ig7X69p2n4eAgsf07e3FtXEhtVag7i/ph7znmzpUjs5G3KzvyESfDEm
 vBuw==
X-Gm-Message-State: APjAAAWK1hCtfAll4QNfH8bjtZdaMup7fvXF46LnMLfBTpEtiADkfwaK
 fzYmAyP7TlN3CseEB3uP43SB4OQHQORqBfDdxd5epQ==
X-Google-Smtp-Source: APXvYqx968qaLLpFFDoHzqozWx8Esp3doJ7NrBLORv9HzKa628RIvMngPhTzOnB8YnaSeetJ5EPKlStr6Sf31sOqVbs=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr8383703wre.11.1573742998407;
 Thu, 14 Nov 2019 06:49:58 -0800 (PST)
MIME-Version: 1.0
References: <05ccc016-243e-a1de-10e1-e7ad19605baa@fedoraproject.org>
In-Reply-To: <05ccc016-243e-a1de-10e1-e7ad19605baa@fedoraproject.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Nov 2019 09:49:46 -0500
Message-ID:
 <CADnq5_PxdXv3FchuDyjXcUTmCkpK6n0XBvoyx99FNztxfj4sLA@mail.gmail.com>
Subject: Re: [Regression] Broken Raven Ridge firmware on kernel 5.3.11 and up
To: Luya Tshimbalanga <luya@fedoraproject.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=YuMX35PPS8aXuq43tj/suaGYpayVfdV6aGlfRx6fz74=;
 b=KSG+c0BfjbUp1sIBeX1FU/701Xbdg2qOZD4blqwGDGQtSh21l9gfIR94eRtcIwpNRx
 H8boBR4JZuJZmrjFv7n9zMcBKlvgJVbH53QcJbcjg2a9fhhqtWn6LVpuO/Cub/MP01v4
 SS7T6bFydPi/WLNeLWwMX0mjyvIk2jRfSavnXjS9k9DkcsxYX9vcl1gY7P20FEpMpmHM
 ywKHDO2oBiH7a498TxfyCfq0X07TjWovgzIXlcdjpFzF1lOcSNQZlp4TxXcWrsdl8OwR
 4hwGKe+BVs4lLuIr6z3mHJi+VTNs6AEzVcPnf2Spbn1daHPuYRk85W8jj3sAoRrjZl4V
 M5fg==
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114144946.D26drY75sA9OEI1CPuHTeU54vXdLhuosDrgKFXL-FCc@z>

T24gVGh1LCBOb3YgMTQsIDIwMTkgYXQgMTozNCBBTSBMdXlhIFRzaGltYmFsYW5nYQo8bHV5YUBm
ZWRvcmFwcm9qZWN0Lm9yZz4gd3JvdGU6Cj4KPiBIZWxsbyB0ZWFtLAo+Cj4gSSBmaWxlZCBhIGJ1
ZyBvbiB0aGUga2VybmVsIHdpdGggYSBicm9rZW4gUmF2ZW4gUmlkZ2UgZmlybXdhcmUgcmVzdWx0
aW5nCj4gYSBibGFuayBzY3JlZW4gdGh1cyB1bmFibGUgdG8gYm9vdCB0byBlaXRoZXIgZ3JhcGhp
Y2FsIGFuZCB0ZXh0IG1vZGUuCj4gQ291bGQgc29tZW9uZSBpbnZlc3RpZ2F0ZSB0aGUgaXNzdWUg
b246Cj4KPiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIwNTUy
MSB3aGljaCBpbmNsdWRlIHRoZQo+IGRtZXNnIGxvZwo+Cj4gVGhlIGZpcm13YXJlIHN0aWxsIHdv
cmtzIG9uIGtlcm5lbCA1LjMuOSBJIGN1cnJlbnRseSB1c2UuCgpUaGUga2VybmVsIGlzIG5vdCBh
YmxlIHRvIGZpbmQgdGhlIGZpcm13YXJlLiAgUGxlYXNlIG1ha2Ugc3VyZSB0aGUKZmlybXdhcmUg
aXMgaW4gdGhlIGluaXRyZCBpZiB1c2luZyBvbmUsIG9yIGluIHRoZSBrZXJuZWwgaWYgeW91IGJ1
aWx0CnRoZSBkcml2ZXIgaW50byB0aGUga2VybmVsLgoKQWxleAoKPgo+Cj4gVGhhbmtzIGluIGFk
dmFuY2UuCj4KPiAtLQo+IEx1eWEgVHNoaW1iYWxhbmdhCj4gRmVkb3JhIERlc2lnbiBUZWFtCj4g
RmVkb3JhIERlc2lnbiBTdWl0ZSBtYWludGFpbmVyCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4
