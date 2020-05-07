Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191AC38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:05:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750B120CC7
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 20:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osxF1l8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750B120CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8626EA5F;
	Thu,  7 May 2020 20:05:47 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8936EA5E;
 Thu,  7 May 2020 20:05:46 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id k1so7905849wrx.4;
 Thu, 07 May 2020 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CrYfmmSwv+JySTyTYwGzP2iBGkWHIZBd7bjrJC5ooVc=;
 b=osxF1l8Nx4lZFIAChlc6L3qMDyZ32oexH7aQ5H/ozgPRyD2CaTJTecQT36EDvb0lwD
 7YpJRF3A40V4hV8WEmSMACWcLU5zAZlYT7YjqoVjRNgFlsz0K4hh00alVMMk4PVKkKCE
 GfTnfl9kxlANmoR/tQQr+lyzXAW3xT7NipidNGuM/RF0EODE8j5gfja7SSqfHYwfLkcu
 hv0CJyyzrXwyMvgutYdPr8XtlrqrhK/me9eT61vy+3MjEXwyAiQYzkmddcXujVydav66
 72CNA9OFnrjdHGL55IdU97XFvJLi5YgH6nHfdf3RDqRADGVVOkp+MySeEWYyfPWkwFxG
 tiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CrYfmmSwv+JySTyTYwGzP2iBGkWHIZBd7bjrJC5ooVc=;
 b=QcW3/Iq0FtR2XkGSYcJzEyhJeqrzu1HZRQ8uByT1bDn/0OP3bZdGQP/BXbKoSAoEKW
 dSE9ZOhuLnarJtEDvmh5DvIo1/tBCTmHn7Tew33BG6YLtg1kmkys4cRxg+sPGruUgzn2
 f+sHdhOHKSHmFlH0Onp8crzQR3XF2V9GtgKZohT7b+YAan6wl3o42UsPnDykdgFOZ/Vl
 Qq2Dsx4kV+zYGUUnCKO2BczdcBWlPMGCvpRqpfT256UVNroZAoYlPVhv+10i+IoHkJpp
 0ugcdHDGnglAwS/iqQEe5569zsf4/ZjisIAJminz18s2Cto/oFTrZeSpWIXrI9WAyEN+
 L0aw==
X-Gm-Message-State: AGi0Puahe9GnAuh3rRQW0Hu6ivM8U0vbi2lpURoZd1qCT7QY+5jNkiSt
 lNAnGT5RKChIWVl0xEPAdHgWt2o/9E0OwJr/7yo=
X-Google-Smtp-Source: APiQypKloJvDW14eWF4gCoWbXMu1WfPb9WxaMArtA+pDH2xRdXOog0Feqr5WQ78mR9b9awpNJJkchQroNzVAvOy5rsA=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr753982wrr.111.1588881945532; 
 Thu, 07 May 2020 13:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200507020221.10548-1-david1.zhou@amd.com>
 <cbbcc5b3-8860-6f44-b8ec-dd96eece6d7c@gmail.com>
In-Reply-To: <cbbcc5b3-8860-6f44-b8ec-dd96eece6d7c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 16:05:33 -0400
Message-ID: <CADnq5_POGStjWKyWs6cR7Frj6NK49Gc79SHBEJEj4Xk8q2B=NA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove me from amdgpu maintainers
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Chunming Zhou <david1.zhou@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDcsIDIwMjAgYXQgMjo0NSBBTSBD
aHJpc3RpYW4gS8O2bmlnCjxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4gd3JvdGU6
Cj4KPiBBbSAwNy4wNS4yMCB1bSAwNDowMiBzY2hyaWViIENodW5taW5nIFpob3U6Cj4gPiBHbGFk
IHRvIHNwZW5kIHRpbWUgb24ga2VybmVsIGRyaXZlciBpbiBwYXN0IHllYXJzLgo+ID4gSSd2ZSBt
b3ZlZCB0byBuZXcgZm9jdXMgaW4gdW1kIGFuZCBjb3VsZG4ndCBjb21taXQKPiA+IGVub3VnaCB0
aW1lIHRvIGRpc2N1c3Npb25zLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5taW5nIFpob3Ug
PGRhdmlkMS56aG91QGFtZC5jb20+Cj4KPiBTbyBMb25nLCBhbmQgVGhhbmtzIGZvciBBbGwgdGhl
IEZpc2ggOikKPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4KPiA+IC0tLQo+ID4gICBNQUlOVEFJTkVSUyB8IDEgLQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVS
UyBiL01BSU5UQUlORVJTCj4gPiBpbmRleCA5MzgzMTYwOTI2MzQuLjRjYTUwOGJkNGM5ZSAxMDA2
NDQKPiA+IC0tLSBhL01BSU5UQUlORVJTCj4gPiArKysgYi9NQUlOVEFJTkVSUwo+ID4gQEAgLTE0
MDY2LDcgKzE0MDY2LDYgQEAgRjogICAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcXVhbnRlbm5hCj4g
PiAgIFJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJTCj4gPiAgIE06ICBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gPiAgIE06ICBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gPiAtTTogICBEYXZpZCAoQ2h1bk1pbmcpIFpob3Ug
PERhdmlkMS5aaG91QGFtZC5jb20+Cj4gPiAgIEw6ICBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+ID4gICBTOiAgU3VwcG9ydGVkCj4gPiAgIFQ6ICBnaXQgZ2l0Oi8vcGVvcGxlLmZyZWVk
ZXNrdG9wLm9yZy9+YWdkNWYvbGludXgKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
