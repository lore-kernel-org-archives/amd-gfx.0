Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5D6C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562E820725
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 23:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg5Lflkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562E820725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F360289CF7;
	Mon, 30 Nov 2020 23:04:07 +0000 (UTC)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B27C89CF7;
 Mon, 30 Nov 2020 23:04:07 +0000 (UTC)
Received: by mail-ot1-x344.google.com with SMTP id f48so4521717otf.8;
 Mon, 30 Nov 2020 15:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/XTX3Z66O+BazeLjFxr+puLvZ6PetLfBClwP+q5Bj0g=;
 b=dg5LflkcwriHvH2MBB/bPLeZFTWXs2sjvPKbydqgr1egeiLh1E9dYIVQGb7dBukd11
 dfiz8U8PYmp2vPhsORB42k9TFvMpkFl6lLHbRbCAoWB4jet1fbQN7XiKkGfig+CYqan1
 TtnIKPjym1jlrZDh8ngNrL1SLdVkGK/DNDtd+pgChVLGY6/eBwE2Zbi1h2+Llh/UH+v+
 upUeixBTw87v+0qfjfA+pSaCpF3W8K4Rx+BY35fLDV17huqWtlSg7itqtEXWjc1xKyU2
 Vx4pfqNG4rbpu10LtWQM/isrYJhmtzB+MXe+v687Kr5VkaBfVuvZMmp4ENlwP/9xNrop
 Ov1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/XTX3Z66O+BazeLjFxr+puLvZ6PetLfBClwP+q5Bj0g=;
 b=XE5ChRcl67Er0TcD9Bb4vWAHoJCNaSPngWjChmsnkDKMtQS0jkgon1FUN154p7+jSa
 92Ka2KEm6tQeSqYnkoEXyMrzO56k+Rrhk+xGvfRnGb910SFYTOmReZnZTn3t35CH1Ohe
 XRg/Sesfj2inyBGJDiqtLHoIs9oc+7F01zzUroz46OvRp6vT0QUPKJ29NFDtMZI5apGZ
 6oJXfj8FoJDLLA7GWFCxMdcuXcR4wkbYV4iixfNq58YIesGc1s/EAzshKpuzeGwwwGsN
 PAs5t8H81QZJg6u2W+QUf6AZxb/05sHJqZCmOmRKHD//FZgItti0FZSUimSJr1ou6EXM
 5HxA==
X-Gm-Message-State: AOAM5329+jrJKhDPplSmRltuvcTqxhONLy0Ajc5BAFQM3gRQM3aqG+js
 LqJ9I1jtvcKPpKFvnQsCjVXsTMzcgBvsV45a/Ac=
X-Google-Smtp-Source: ABdhPJzFEcs1LGYfXam7Brnq4I4Rmdbke/J7wWbeEuPhw0Yq74o/WHrC0htfeQw4Reicm+MX5kc+4IXl7vhIg4OzjLA=
X-Received: by 2002:a05:6830:22e4:: with SMTP id
 t4mr19122959otc.23.1606777445195; 
 Mon, 30 Nov 2020 15:04:05 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-41-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-41-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 18:03:53 -0500
Message-ID: <CADnq5_PwGBLKU5cZtrLH4BUep9AgzwRW9xwj+rakxC_FY9RuGw@mail.gmail.com>
Subject: Re: [PATCH 40/40] drm/amd/amdgpu/amdgpu_uvd: Add description for
 amdgpu_uvd_cs_msg_decode()'s 'buf_sizes' param
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

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91dmQuYzo1
NTU6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2J1Zl9zaXplcycgbm90
IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X3V2ZF9jc19tc2dfZGVjb2RlJwo+Cj4gQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7ZuaWci
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBTdW1p
dCBTZW13YWwgPHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6
IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxp
bmFyby5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
PgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV91dmQuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZk
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXZkLmMKPiBpbmRleCBmOGYw
Mzg0YThkOWFkLi43YzViNjBlNTM0ODIyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91dmQuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91dmQuYwo+IEBAIC01NDcsNiArNTQ3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdXZk
X2NzX3Bhc3MxKHN0cnVjdCBhbWRncHVfdXZkX2NzX2N0eCAqY3R4KQo+ICAgKgo+ICAgKiBAYWRl
djogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gICAqIEBtc2c6IHBvaW50ZXIgdG8gbWVzc2FnZSBz
dHJ1Y3R1cmUKPiArICogQGJ1Zl9zaXplczogcGxhY2Vob2xkZXIgdG8gcHV0IHRoZSBkaWZmZXJl
bnQgYnVmZmVyIGxlbmd0aHMKPiAgICoKPiAgICogUGVlayBpbnRvIHRoZSBkZWNvZGUgbWVzc2Fn
ZSBhbmQgY2FsY3VsYXRlIHRoZSBuZWNlc3NhcnkgYnVmZmVyIHNpemVzLgo+ICAgKi8KPiAtLQo+
IDIuMjUuMQo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
