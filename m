Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCCAC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:10:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80C223B1C
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 17:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80C223B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866FD6E0CE;
	Thu, 14 Jan 2021 17:10:38 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B16D6E0CE;
 Thu, 14 Jan 2021 17:10:38 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id a109so5867046otc.1;
 Thu, 14 Jan 2021 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z89knoWulPFq9AYPACpXwaMY0188RFnbZEaPd/jNiKk=;
 b=tKAOn7wfX5dFLUtkHs5SgiCpg1B9NAPXGFtpimqRlTRZJsi0tl0L3JYgib5/ajRIGf
 ely26qXO1Nteyw06CCfCYDTgTQUlYAkvMBK9aBgvAb3Vh3ZY2Ij2Xxjp/nQoHyHKHRc9
 59xmQFuWE6OgBtDvzsJncdPkInyr1964i3XQfJjcXkNUDHJ90gKkaOjKRU6CvQraRxXv
 VPZBfJvtAJZpDSavnA6kf+65zPB/0LQJk6341l+2eGD2QKbVKS3SorB1Ywvxzrsixgtt
 xKIICykn9PEXHW+obXPHvqcTNRERgii8P+xIqq3Z6P9NYVVEeGuI7+Y6RjrH+YYuO1YL
 UDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z89knoWulPFq9AYPACpXwaMY0188RFnbZEaPd/jNiKk=;
 b=No2/ywPrLDXhMKQpH+1f7y58h1svOgvGbHa3gNO1AaCDPEkWiDVYgvBMNzrBo6G3EK
 CJgsT6lzd6yHON56Gotr+zFTuB7OB+isyRGP+KqIoiWYV4wGNqPKCSRGMlwyFvu1MgFn
 2+3iyundURAWhdCjSyGjwlTP02KsMFLZpTHCY/A+C4rPDkDJQhbKAgguymDptdo4Qxw/
 P1SL8w+YNSA2cJINVctc9quMHqHqlIUHiPhZmkdEUlu8fQvqGxzLQdi5G0FUpz75m9GJ
 0+BDP3UkItHkgD3x8BbqvIm0910QKCKYqr4S5j9ArSeHLq7wyuI1qNMGxrN417eMXEkv
 uT1w==
X-Gm-Message-State: AOAM5312rO2Pka3GqZCOaSjrK35DGcfxe81tMvpCdNkArHOGLLbXKzC4
 1QB3XUhRQkZahiKBikmlQ8Icg2AdFrW3uXVKcu8=
X-Google-Smtp-Source: ABdhPJxc4EKBNhvIxgoVQrOwTw3tJp6sS8rPoeHL+a74xvW4077JQ3w61iZAjTAB4y2hrlkfm80E7XAaNiEvcLdAXFM=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr5189891otb.23.1610644237565; 
 Thu, 14 Jan 2021 09:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org>
 <20210113080752.1003793-10-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-10-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Jan 2021 12:10:26 -0500
Message-ID: <CADnq5_OsqCBxMDGrY003+br1SR0=howMW=xynPXs_t1o-dF2jQ@mail.gmail.com>
Subject: Re: [PATCH 09/30] drm/amd/display/dc/dce112/dce112_resource: Include
 our own header file containing prototypes
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
 Alex Deucher <alexander.deucher@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgMzowOCBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlMTEyL2RjZTExMl9yZXNvdXJjZS5jOjg4Mzo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yIOKAmGRjZTExMl92YWxpZGF0ZV9iYW5kd2lkdGjigJkgWy1XbWlzc2luZy1wcm90
b3R5cGVzXQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTEx
Mi9kY2UxMTJfcmVzb3VyY2UuYzoxMDA4OjE2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5
cGUgZm9yIOKAmGRjZTExMl9hZGRfc3RyZWFtX3RvX2N0eOKAmSBbLVdtaXNzaW5nLXByb3RvdHlw
ZXNdCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlMTEyL2Rj
ZTExMl9yZXNvdXJjZS5jOjE0MDc6MjM6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBm
b3Ig4oCYZGNlMTEyX2NyZWF0ZV9yZXNvdXJjZV9wb29s4oCZIFstV21pc3NpbmctcHJvdG90eXBl
c10KPgo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPiBDYzog
TGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzog
RGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBBbnRob255IEtvbyA8QW50aG9u
eS5Lb29AYW1kLmNvbT4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzog
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoKQWxleAoKPiAtLS0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2Uu
YyB8IDQgKysrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEx
Mi9kY2UxMTJfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2Ux
MTIvZGNlMTEyX3Jlc291cmNlLmMKPiBpbmRleCBjNjhlNTc2YTIxOTkwLi5lZTU1Y2RhODU0YmY0
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTIvZGNl
MTEyX3Jlc291cmNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNl
MTEyL2RjZTExMl9yZXNvdXJjZS5jCj4gQEAgLTU5LDcgKzU5LDkgQEAKPiAgI2luY2x1ZGUgImRj
ZS9kY2VfMTFfMl9zaF9tYXNrLmgiCj4KPiAgI2luY2x1ZGUgImRjZTEwMC9kY2UxMDBfcmVzb3Vy
Y2UuaCIKPiAtI2RlZmluZSBEQ19MT0dHRVIgXAo+ICsjaW5jbHVkZSAiZGNlMTEyX3Jlc291cmNl
LmgiCj4gKwo+ICsjZGVmaW5lIERDX0xPR0dFUiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwKPiAgICAgICAgICAgICAgICAgZGMtPmN0eC0+bG9nZ2VyCj4KPiAgI2lmbmRlZiBtbURQX0RQ
SFlfSU5URVJOQUxfQ1RSTAo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
