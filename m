Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC1C432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 20:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B2F20672
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 20:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B2F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B5E6E065;
	Thu, 21 Nov 2019 20:17:27 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1746E065
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 20:17:25 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id b18so5989074wrj.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 12:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AAmcWyORDJu7HSxvkUF+WF3CM69y05+HUPYOFurP62w=;
 b=DwmDP2nANrVYWRACDS5NMJ9fwoj1femGwhidrWkX13T/ByOcS3H1FysBznMQxvttR5
 B45n2c/nWm9vEW5cpCNcFU6xOCV/JQN607gtVc0lX62geszm15FJxHX2AGkpchjJ2jJH
 /veUE/8VSlq04w/0bfFYuD96ktqSvfnJ5W1xMzN0ft8rEkMoyN75fVnv9uInY45hdFaU
 txVFTkTb+amISPqL7Cf/DBITWsj5TX7kCDqjCo7/adzqrmOFVwAzNG25EARa2OrRoR+7
 vAyvi6IexiyOqR9Tb7fvVvfRSTIGbpXPwNuwflxxFmOOZZdBclTYGeDnvR5tVVc2gECw
 Cfqg==
X-Gm-Message-State: APjAAAV4EMSSWet7jrRuDFV4cuj0AkiiFRyE3b79ZxwyN3gydJwmLVR+
 RUfu6BW/wPhYOG8FCsDMwj9Na7gSeumBnH5lKl0=
X-Google-Smtp-Source: APXvYqw2URNS4F8Mc/wJesJ3kQMWomhH4Itt0lt1UDwpESat/w7Vp3f4fbauGoGd7g/OUNVLGJQLEikhB4SG0CbPq04=
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr13191741wrx.154.1574367443869; 
 Thu, 21 Nov 2019 12:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20191121201200.GA11433@freedom>
In-Reply-To: <20191121201200.GA11433@freedom>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Nov 2019 15:17:12 -0500
Message-ID:
 <CADnq5_NyGhdzq2duXaqRjJi6djQS63SfD3Cu_Maom2e6rsi-TQ@mail.gmail.com>
Subject: Re: GFX[6-9] unconditionaly "allocate" the max of sgprs and vgprs to
 align on GFX10?
To: Sylvain Bertrand <sylvain.bertrand@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=AAmcWyORDJu7HSxvkUF+WF3CM69y05+HUPYOFurP62w=;
 b=Q8Y/Vym5XdsInpr8i4CogP9HWTxeHuvhsyFuc1Aurj6w7tTQGXYScEwITM1jIWAVq2
 ZJ+ECAf359qQXMSkT9zWUl7rsYFNwvFYz6EEYFAVZSEnPte/ZT5rxl9w481AcSE0RkUA
 ld9hAbIv5guQ/5+uVF6eiY3c5PtoJzbcVXB7oahGBE8zzqcn/TqYgFnaMqxlgckh3F6Z
 FCK4FIdl0+1F2lBq6kqgbGj4BFsAGSk1OdiesuGK5JSF7L1d4Dv5cj0agp47X1a9GbjN
 3c932v97KleQ1KufO0DU1DW1ocP1EOssS47wjqDhx9p4UaHgMU0eXGvZyHdfxEmA2o92
 Xnfw==
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
Message-ID: <20191121201712.M84lBJfxK9Wt7sC3z1ic42Z_y1UFnudGTp60swOseZc@z>

Tm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4gIFdoYXQgYXJlIHlvdSBhc2tpbmcg
YWJvdXQ/CgpBbGV4CgpPbiBUaHUsIE5vdiAyMSwgMjAxOSBhdCAzOjEyIFBNIDxzeWx2YWluLmJl
cnRyYW5kQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiBIaSwKPgo+IElzIHRoaXMgYSBnb29kIGlkZWE/
IChzZWUgdGhlIGVtYWlsIHN1YmplY3QpLgo+Cj4gcmVnYXJkcywKPgo+IC0tCj4gU3lsdmFpbgo+
IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
