Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FC2C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DB4613D1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DB4613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 140F66EE15;
	Thu, 27 May 2021 04:07:29 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 606466EE15;
 Thu, 27 May 2021 04:07:27 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 n3-20020a9d74030000b029035e65d0a0b8so3170037otk.9; 
 Wed, 26 May 2021 21:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=biRP26rVUcCDUxlQKzqIiq6xaK3uwBrV/Qk9YlWx7iU=;
 b=Lvc/0ad2S41Y2inaGB+y3ko0vNk5/5PGoyTFgSAHppOljYZ8gdf8OttN1r7sGmXs4n
 GaZwmgTrDi97eVBMTi5c0TaQniyI2gX8fwXLfagTgEq3YVYBAvz8byoKJxWU25L30hDw
 bpclaMU2tQNt5tFOZhHNq2DihxDLxbO+ebX9+fF35alvl9+l4aRM0ZOSnfff/+UyFvrL
 n/gvNTbEQad8hEoUixsGpaGDtcA5EnIipLBfeXQ95JFIXar1GNZ/np9EqpprnXycsIM6
 +1H02NoCXcxx0xv30QR4AzlW02rVsSgmIwz7073qZ1axPAYh7RqJYWnztUUcsYAgh5YE
 uywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=biRP26rVUcCDUxlQKzqIiq6xaK3uwBrV/Qk9YlWx7iU=;
 b=c6uFOQzOxPLRFRU6lTI7iz0EkVMttwR5TvEJaUtJ+IEAhmmYYZYXn0mufBWK3LieEK
 Vj/YDrVBLvs2sPTT9UxBbhmSrMvN7ENSrr5v30KCqmjUlTufQIo0/KZ7lP8GqcP4ztBg
 XOvmRxHBNbIYTxfnLNcwGNGflXxElN56sYL558G+4l+5CrdSA7wvnxKLKuiktGJgzqvU
 jgNnSYCc5nNXknGABQeLbNqViEP6Dh+yUCTP5t6w3RcPY/bEHyjname8JcR5ndmyYSqD
 7jfN9V9L2FcjIewBMlOJczfp1vIFPiR7PmCBusH7qStw+j2elJrY+piZ7l1AqotiuQCr
 ZQUw==
X-Gm-Message-State: AOAM532J3ZbzkcnoKtRF6spKkZZejTFz9Td7hPveZqpZF+/84UzBPMPJ
 CQgpE0w63ZH7cqafzfmkuSwFhL0MajeFymS+Vik=
X-Google-Smtp-Source: ABdhPJzEfSXRivAnJdi6SeTD/+1xR9TKlmVtvSYaYLngnkYXEQ1fhBNMVCyLnuQnerV4Vl0wz/a7inrtQalD/snllf0=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr1241846oti.23.1622088446582; 
 Wed, 26 May 2021 21:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-16-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-16-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:07:15 -0400
Message-ID: <CADnq5_PjO_KWOU1y8kXDV77Pm56vzhGxaWow7-GFGSxqGsMr9g@mail.gmail.com>
Subject: Re: [PATCH 15/34] drm/amd/display/dc/dce110/dce110_hw_sequencer:
 Include our own header
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmM6OTI3OjY6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlMTEwX2VkcF93YWl0X2Zvcl9U
MTLigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQo+Cj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPgo+IENjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiBD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0
aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+
Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF9od19zZXF1ZW5jZXIuYyB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMKPiBpbmRleCA1ZGRlZWU5NmJmMjM1Li45
MjE5ZGI3OWYzMmI2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMKPiBAQCAtNjMsNiArNjMs
OCBAQAo+Cj4gICNpbmNsdWRlICJhdG9tZmlybXdhcmUuaCIKPgo+ICsjaW5jbHVkZSAiZGNlMTEw
X2h3X3NlcXVlbmNlci5oIgo+ICsKPiAgI2RlZmluZSBHQU1NQV9IV19QT0lOVFNfTlVNIDI1Ngo+
Cj4gIC8qCj4gLS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
