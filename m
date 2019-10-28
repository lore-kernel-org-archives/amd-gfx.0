Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E450BCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 17:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BA821744
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 17:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BA821744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44566E9AE;
	Mon, 28 Oct 2019 17:56:42 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639C16E9A8;
 Mon, 28 Oct 2019 17:56:41 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t16so10896399wrr.1;
 Mon, 28 Oct 2019 10:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yAgZMtf/VMvYmjG/BeZrCrg9OryuwBnaN7WoS0QCndo=;
 b=GXiGXRebjrN7TBlcxECzunUIjqxfpfAK5d2oLhYH0strv3jjVQcMnOlPPN8W3vDQBr
 EjbabRNtojOkQgS6hrOvojivMKqz/Wu8nvZxmsj0cEREzjAhJq8LKvcqhZcXD6IZu7me
 F5xNpm5yL0pD9rH6Vim8LIYf8VW/1goZpYpDiap3gAlitX1bbIh/lxKO1Q8Kf7+KDCss
 hNtkn7881w+q8aywa7YThDgsGwn+jJgTlq9hjGSZqhifYLozSyNVs5UD2qqXcIavkcYn
 8PVi5KFwj1Xt46aCNQKje50eV7p8fIh9iKZV2T+bwAqecOuHGdrTdZO3/RIy2S5pC8Az
 iIMg==
X-Gm-Message-State: APjAAAU4pvCCyhErgZ9EZp6k5z/9SV5534TW7kdV5aHL8T5IgmLDxF/w
 2dmqO8GQv8vb5VPxiSW4/JOBMG/r/mWppFGIFdU=
X-Google-Smtp-Source: APXvYqxnORJpDwc4s1jCy3Q5X+6OC0fEfKMsIR8ZweCFnT0Pjd7LJxMWaOSFSH1x4BZ/57s6J/Kd17r2Xg5+gEdaz8Q=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr15784221wro.11.1572285399932; 
 Mon, 28 Oct 2019 10:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145149.31657-1-geert+renesas@glider.be>
 <20191021145149.31657-4-geert+renesas@glider.be>
In-Reply-To: <20191021145149.31657-4-geert+renesas@glider.be>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2019 13:56:26 -0400
Message-ID:
 <CADnq5_Mcs1EzvETV=+XjWZcbJff-bfLycYZ3N+SVE9-KA7U-Sw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amdgpu: Remove superfluous void * cast in
 debugfs_create_file() call
To: Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=yAgZMtf/VMvYmjG/BeZrCrg9OryuwBnaN7WoS0QCndo=;
 b=lsYd+IrBzjmG3qfteumSThkMdXzznfqx5E28vX8HNjBNCvlLPm2zTiCTD9/dTnIovI
 GzciN/1SNDxwcb3dI4c7inPDt3Hn1zePT9aEjzauaWC4X4XHzeI3iOssBTzebbmSBYbK
 iw9dq7cMOa+QfqT6oq7EeynrMbkg0UTIa0UaHj8aoHhyrOud3GUr+5wKjq+B52SUinmq
 rU2NppWWK8r0eepPXqrNWMhh2Byfl47OLXgNpnkgEHVaX8DxEXdrD26CeeGKb+5UpCaz
 +79sOdQIF+WoGFbd5JS8021/3NKCotJ6B/r3XblTC5bxhsVGT8XqxqSRJP6Tz2mgeWMp
 jECA==
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
Cc: Nishanth Menon <nm@ti.com>, David Airlie <airlied@linux.ie>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
 =?UTF-8?Q?Breno_Leit=C3=A3o?= <leitao@debian.org>, David@rox.of.borg,
 Herbert Xu <herbert@gondor.apana.org.au>, Kevin Hilman <khilman@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Casey Leedom <leedom@chelsio.com>, Linux PM <linux-pm@vger.kernel.org>,
 Pensando Drivers <drivers@pensando.io>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Network Development <netdev@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, Paul Mackerras <paulus@samba.org>,
 Shannon Nelson <snelson@pensando.io>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028175626.Au2Ml2QSwwCFz_yi-WVxz0aUit-CT7buNO2pQvJucyw@z>

T24gTW9uLCBPY3QgMjEsIDIwMTkgYXQgNjoyMyBQTSBHZWVydCBVeXR0ZXJob2V2ZW4KPGdlZXJ0
K3JlbmVzYXNAZ2xpZGVyLmJlPiB3cm90ZToKPgo+IFRoZXJlIGlzIG5vIG5lZWQgdG8gY2FzdCBh
IHR5cGVkIHBvaW50ZXIgdG8gYSB2b2lkIHBvaW50ZXIgd2hlbiBjYWxsaW5nCj4gYSBmdW5jdGlv
biB0aGF0IGFjY2VwdHMgdGhlIGxhdHRlci4gIFJlbW92ZSBpdCwgYXMgdGhlIGNhc3QgcHJldmVu
dHMKPiBmdXJ0aGVyIGNvbXBpbGVyIGNoZWNrcy4KPgo+IFNpZ25lZC1vZmYtYnk6IEdlZXJ0IFV5
dHRlcmhvZXZlbiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+CgpBcHBsaWVkLiAgVGhhbmtzIQoK
QWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMu
YyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCj4g
aW5kZXggNTY1MmNjNzJlZDNhOWIzYS4uYjk3YTM4YjFlMDg5YjNkNiAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RlYnVnZnMuYwo+IEBAIC0xMDkwLDggKzEwOTAs
OCBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgewo+ICAgICAgICAgYWRldi0+ZGVidWdmc19wcmVlbXB0ID0KPiAgICAgICAgICAgICAgICAg
ZGVidWdmc19jcmVhdGVfZmlsZSgiYW1kZ3B1X3ByZWVtcHRfaWIiLCAwNjAwLAo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZXYtPmRkZXYtPnByaW1hcnktPmRlYnVnZnNf
cm9vdCwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAodm9pZCAqKWFkZXYs
ICZmb3BzX2liX3ByZWVtcHQpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGFkZXYtPmRkZXYtPnByaW1hcnktPmRlYnVnZnNfcm9vdCwgYWRldiwKPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmZm9wc19pYl9wcmVlbXB0KTsKPiAgICAgICAgIGlmICgh
KGFkZXYtPmRlYnVnZnNfcHJlZW1wdCkpIHsKPiAgICAgICAgICAgICAgICAgRFJNX0VSUk9SKCJ1
bmFibGUgdG8gY3JlYXRlIGFtZGdwdV9wcmVlbXB0X2liIGRlYnVnc2ZzIGZpbGVcbiIpOwo+ICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiAtLQo+IDIuMTcuMQo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBs
aXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
