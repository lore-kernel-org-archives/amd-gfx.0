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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04B6C47089
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8320C610CC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 04:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8320C610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0A476EE0E;
	Thu, 27 May 2021 04:00:56 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0236EE0E;
 Thu, 27 May 2021 04:00:55 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 i23-20020a9d68d70000b02902dc19ed4c15so3214786oto.0; 
 Wed, 26 May 2021 21:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=APGqEQQKklVqx+e+nEY1OGGyF9cgDa3PPLqNkgcDFtE=;
 b=rod1T2rjLNLXdShw7Ee3xcuNeytqVwUBmsE+CS7Kpu0+oDCJrwSs75MoHtIRYv05Sh
 pLWZkEub70QUK/vtkQxFm25AjMRuHXziuIRJrgCTvDpx/QRFyO0VQLZQWx05GGPfpWny
 4XZ8RXpl0u2bXwf0RvlQVMHqsW/wpturxvUmoTD5Gf+kn+flUEMZn9Znp+iQzp2b4JM7
 4FbI0xd+hdRcnSGd5vNhApbwkScVen7K501N6iF4TfjMizkJVMuyPCdCxCSXIXX95bHk
 LUnot92cAmKveqIAuOiaxPwSGnGMHBf77l2ZN32aaw1lgaT7jTU5jQQtwgvU30QhoH3P
 zhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=APGqEQQKklVqx+e+nEY1OGGyF9cgDa3PPLqNkgcDFtE=;
 b=M3iZqyH9C+0UO1eeSoVCWiKKgQq727P8YDYXSP6GIQ3p3fFGxU7Yca/rvCEm+4E7hj
 YECADMbZAVqkxmzXv6TvBMexhDN/9KnSXbO3xOWv8z/0lBxIbdjKwOQuibXPWfZHF0vI
 Y1rDzxt+ukSdWDVA5Vt8rTrbnbZvc/PxV6Yd+/yss0aW2CDejF5amHh9hhcPnBd/fe7B
 5PJeAKelBGjxoMfVARGkOJzb0DMpw8texktF1AuEOTEXBxaIEIjWZLixTWU68nSrHiEu
 AA+X4jd+0F8aMvPRxuHJEErUe5PFwOdrwYc0L3OdRR8/lvxNbGuyqFfyVxdW5bNakDNT
 83Pg==
X-Gm-Message-State: AOAM532ut+8mWswVBsRQ28n9+7kcJKtu4bBCqqkiojPk5UVX87Uzcwuy
 9zTPNw+sqdU9TrgkQuqSiTw8GZHzfydku+ywvsE=
X-Google-Smtp-Source: ABdhPJwTFbg86d5m1kGBug4qpsnNlPlGtJmoEoSn/XOtNyLD3d3qLRkNElC/2g/pS6OEa4WVo7cLLlRk7eabZvjp5FE=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr1218750otl.311.1622088055142; 
 Wed, 26 May 2021 21:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210526084726.552052-1-lee.jones@linaro.org>
 <20210526084726.552052-14-lee.jones@linaro.org>
In-Reply-To: <20210526084726.552052-14-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 May 2021 00:00:44 -0400
Message-ID: <CADnq5_PLcwcmY88uecMh7FPYungfskpBgWmiy9qTJrE_k06MAQ@mail.gmail.com>
Subject: Re: [PATCH 13/34] drm/amd/display/dc/dce/dmub_outbox: Convert over to
 kernel-doc
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDQ6NDggQU0gTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9sbG93aW5n
IFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2RjZS9kbXViX291dGJveC5jOjMwOiB3YXJuaW5nOiBDYW5ub3Qg
dW5kZXJzdGFuZCAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKPgo+IENjOiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+
Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNo
cmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFp
cmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPgo+IENjOiBSb2RyaWdvIFNpcXVlaXJhIDxSb2RyaWdvLlNpcXVlaXJhQGFtZC5jb20+Cj4g
Q2M6IE1lZW5ha3NoaWt1bWFyIFNvbWFzdW5kYXJhbSA8bWVlbmFrc2hpa3VtYXIuc29tYXN1bmRh
cmFtQGFtZC5jb20+Cj4gQ2M6IEp1biBMZWkgPEp1bi5MZWlAYW1kLmNvbT4KPiBDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Cj4g
LS0tCj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX291dGJveC5jICAgIHwg
MTcgKysrKy0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
MTMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZS9kbXViX291dGJveC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RjZS9kbXViX291dGJveC5jCj4gaW5kZXggMjk1NTk2ZDFmNDdmMi4uZmFhZDg1NTVkZGJiNiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RtdWJfb3V0
Ym94LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RtdWJfb3V0
Ym94LmMKPiBAQCAtMjcsMTkgKzI3LDEwIEBACj4gICNpbmNsdWRlICJkbXViL2luYy9kbXViX2Nt
ZC5oIgo+Cj4gIC8qKgo+IC0gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKPiAtICogIEZ1bmN0aW9uOiBk
bXViX2VuYWJsZV9vdXRib3hfbm90aWZpY2F0aW9uCj4gLSAqCj4gLSAqICBAYnJpZWYKPiAtICog
ICAgICAgICAgICAgU2VuZHMgaW5ib3ggY21kIHRvIGRtdWIgdG8gZW5hYmxlIG91dGJveDEgbWVz
c2FnZXMgd2l0aCBpbnRlcnJ1cHQuCj4gLSAqICAgICAgICAgICAgIERtdWIgc2VuZHMgb3V0Ym94
MSBtZXNzYWdlIGFuZCB0cmlnZ2VycyBvdXRib3gxIGludGVycnVwdC4KPiAtICoKPiAtICogIEBw
YXJhbQo+IC0gKiAgICAgICAgICAgICBbaW5dIGRjOiBkYyBzdHJ1Y3R1cmUKPiAtICoKPiAtICog
IEByZXR1cm4KPiAtICogICAgIE5vbmUKPiAtICoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCj4gKyAqICBk
bXViX2VuYWJsZV9vdXRib3hfbm90aWZpY2F0aW9uIC0gU2VuZHMgaW5ib3ggY21kIHRvIGRtdWIg
dG8gZW5hYmxlIG91dGJveDEKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtZXNzYWdlcyB3aXRoIGludGVycnVwdC4gRG11YiBzZW5kcyBvdXRib3gxCj4gKyAqICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWVzc2FnZSBhbmQgdHJpZ2dlcnMgb3V0Ym94
MSBpbnRlcnJ1cHQuCj4gKyAqIEBkYzogZGMgc3RydWN0dXJlCj4gICAqLwo+ICB2b2lkIGRtdWJf
ZW5hYmxlX291dGJveF9ub3RpZmljYXRpb24oc3RydWN0IGRjICpkYykKPiAgewo+IC0tCj4gMi4z
MS4xCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
