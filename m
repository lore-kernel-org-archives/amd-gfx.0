Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA15C388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B8520E65
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUZMfvuH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B8520E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDFD26E8C8;
	Tue,  3 Nov 2020 17:18:47 +0000 (UTC)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97BA6E8C8
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 17:18:45 +0000 (UTC)
Received: by mail-pf1-x444.google.com with SMTP id e7so14769034pfn.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=cPZGuwRnEtMWISbzspjZkYy6nZNgw4jWnVP65wKE+CA=;
 b=fUZMfvuHYb3AXIAkabbf7ydWkI8HyTMEaZNa+E4/yE9FYgHD3zFFh9fg7IdJ0AJywQ
 K6D8rpzhiM3Ar2x4ucn9nciNhCFYi/8Owds2/OvTmzAlWxvvEIFrr47x7cA+2A/8837o
 Fdt9X0Bcaz7Q/FJEdO9cZx3dm+Pm335C0fSWLV7HS6RIStYLVPhhmM1IwUv3qfU33CbE
 NmrMOn9nclxZPsX2qeSwEoAbrxYO8xL0RVyHNYSZeohcToei0yrJR2KHvmAJ5zAe/OKM
 mDl+mTl9lR8pgEVpeAgYyO2mjYz4p31CCxAvXui67XBjtuYTNwdMx7fkAXWNhdiq+lxw
 qi2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=cPZGuwRnEtMWISbzspjZkYy6nZNgw4jWnVP65wKE+CA=;
 b=ZRNrh6UMWfKZfc7aMIBCweMQzbkKNR0AR6CO8i9wVagWreZjQC26P6zIwbJAIdolO1
 wqm0CtUa9FDS77b2tWnugbrTo9VcFQrqqXj0uVo3tU9pRp+lEwSkihez+4i9zI8XM1oU
 q+dCxuiBswygOcOBQDM//Gv1ULKKGvRe/Etd6rDLoJHk7RsrLpObo8DS9RnuYIdFDGhm
 Ncg9CuwE+Xj7aUcdGoviF/vKg3Xi8NijkkLv7SzZ5/7mcCnvzJ1XD34cd1t4Afi5WOaA
 u7zO8iNMMiQRW8pBzUAwYJwwDkolWt388F1Gn4Gp3yHx4NBkSNcbd+iGD4I6fdzlBmtj
 nA0Q==
X-Gm-Message-State: AOAM533ni7uxXa1laVh6lnj9GAv21zzYeqgyC6ggVjWVr4uzIGBBhrlq
 qy7lwFk6wzxkw4BbiO0nztr7M/0ysBQ8EsRtw+eAgt7Sbm8=
X-Google-Smtp-Source: ABdhPJwfjI1aiWuwnAsMic/rQY69hY9YFxTOPplf+Lx2aujeqE15Qn5EW3P0A2xPo9meS1/Bk2Rkhp8x0r4+HjGJ1os=
X-Received: by 2002:a63:e74a:: with SMTP id j10mr9063854pgk.208.1604423925225; 
 Tue, 03 Nov 2020 09:18:45 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A7dVst6RpB-cD_SOkkC89jVH1vp6WMv=_KkOEWJKqY_aA@mail.gmail.com>
In-Reply-To: <CAAxE2A7dVst6RpB-cD_SOkkC89jVH1vp6WMv=_KkOEWJKqY_aA@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 3 Nov 2020 12:18:09 -0500
Message-ID: <CAAxE2A7FX+8m=9wSyHW8Vwn8ubPdWpSy8TVe3-f2M2uWADU3HQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set LDS_CONFIG=0x20 on Navy Flounder to fix a
 GPU hang
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="0000000000002237f205b3370e85"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000002237f205b3370e85
Content-Type: multipart/alternative; boundary="0000000000002237ed05b3370e83"

--0000000000002237ed05b3370e83
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated patch.

Thanks,
Marek

On Tue, Nov 3, 2020 at 11:10 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:

> Please review.
>
> Thanks,
> Marek
>

--0000000000002237ed05b3370e83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Updated patch.</div><div><br></div><div>Thanks,</div>=
<div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Tue, Nov 3, 2020 at 11:10 AM Marek Ol=C5=A1=C3=A1k &=
lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v>Please review.</div><div><br></div><div>Thanks,</div><div>Marek<br></div>=
</div>
</blockquote></div>

--0000000000002237ed05b3370e83--

--0000000000002237f205b3370e85
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-set-LDS_CONFIG-0x20-on-Navy-Flounder-to-f.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-set-LDS_CONFIG-0x20-on-Navy-Flounder-to-f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kh28jt450>
X-Attachment-Id: f_kh28jt450

RnJvbSBjOTBhNGI2YTE3MGRiZWIxZDI5MTI2MTJkODQyZDJhOGE3NDc2ZWVkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogVHVlLCAzIE5vdiAyMDIwIDExOjA1OjI1IC0wNTAw
ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogc2V0IExEU19DT05GSUc9MHgyMCBvbiBOYXZ5
IEZsb3VuZGVyIHRvIGZpeCBhIEdQVQogaGFuZwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5
cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdAoKU2lnbmVkLW9mZi1ieTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDMgKysrCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwppbmRleCBmN2QyMTdkZTU4NTkuLmE3MWM5OGYwOGYzZiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTMyMTYsNiArMzIxNiw5IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfMTBfM18yW10gPQog
CVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tVEFfQ05UTF9BVVgsIDB4ZmZmN2ZmZmYs
IDB4MDEwMzAwMDApLAogCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tVVRDTDFfQ1RS
TCwgMHhmZmJmZmZmZiwgMHgwMGEwMDAwMCksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywg
MCwgbW1WR1RfR1NfTUFYX1dBVkVfSUQsIDB4MDAwMDBmZmYsIDB4MDAwMDAzZmYpCisKKwkvKiBU
aGlzIGlzIG5vdCBpbiBHREIgeWV0LiBEb24ndCByZW1vdmUgaXQuIEl0IGZpeGVzIGEgR1BVIGhh
bmcgb24gTmF2eSBGbG91bmRlci4gKi8KKwlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBt
bUxEU19DT05GSUcsICAweDAwMDAwMDIwLCAweDAwMDAwMDIwKSwKIH07CiAKIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfMTBfM192YW5nb2do
W10gPQotLSAKMi4xNy4xCgo=
--0000000000002237f205b3370e85
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--0000000000002237f205b3370e85--
