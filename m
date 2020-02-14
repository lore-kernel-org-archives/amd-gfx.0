Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A91C3B1A2
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC8C2475A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 16:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUMYpxGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC8C2475A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFBB46FB24;
	Fri, 14 Feb 2020 16:22:40 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAE76FB19;
 Fri, 14 Feb 2020 16:22:39 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z3so11596267wru.3;
 Fri, 14 Feb 2020 08:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=F8W0MotfQnPEa/KdyFQF0W7kLEtQWwDAo9vyrtiU5Gk=;
 b=GUMYpxGiCyf3qvAsvG9GusvIKRkK0vVL0zi86+QpCsvqgQqnwyviEn/Oa968Apl0lw
 TDkrkAfVE8rjwJJGnmolzZR0Bu7nzRD7qAtBsTqSb4umtQk+CALu8EeDwnA+qSBCAy1v
 HvfKlm67BY2KYScY/BL/cA9d9/9gn7XEKLfG5gpqW9ETdmOCv1yRTzIp/+GSKvywAsD6
 Af3fZFvf6OLSy3vA7ITY9h1qKtmccPUjr1I3Th/WdCPcKhGPGvA4d5UPj61gicYg9BPF
 XgJDA+4BuTs2iru68xpoVLqoyhfLDOzDb9rfQK2fdpjdzqNMcsHE3XCMZLQCKjpBweIq
 TE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=F8W0MotfQnPEa/KdyFQF0W7kLEtQWwDAo9vyrtiU5Gk=;
 b=RSvbrRni8Eq5qD3pQk1NpmOHw5vXgaaHKdL2j6Dpex6rpoVogdX4Nc+vi1evJuv47i
 MoSUq6/7sta5ps3t1FeTlKGaXaCsoISmeb7JrAHSkSfadge4m8QqTiIhaK9SaCeAmOcb
 A5I78U5Z0M3PTJ0Z70oaEO167yjoiLAeY36YOgEG0GZVz35aOx5e+nwYlldaJmRQj+Cd
 5opRiNe+GGRgYyP2NRHshowsdxH1wm9QysZ6DKleUPL5luKvjqY2+71p4jz6YKzhW3R5
 olP//3kWlx0pR5nit88wP8Lqg3c8b73v0Ku3uGkW/3O2ZFa6W8m7W0h8UBCw1VWAeXSy
 xIMQ==
X-Gm-Message-State: APjAAAUOhOFbrP4X3VwLBMIiFP12Jc7ps+HbAivywnHQFHkIzIp/3bDD
 5P7HZ8Xw8EVlgzVIMPSzTRMcDhgsEYhkH/nCzdU=
X-Google-Smtp-Source: APXvYqwr8VK9pA0btz3BZPR8gMaxqgRSDNoIunzZqG4iZhOozas0m6WDC9tRV0qGzH0B/KyocD/tTa393fURFpVYEd0=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr5088220wrn.124.1581697358169; 
 Fri, 14 Feb 2020 08:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org>
 <20200214154854.6746-408-sashal@kernel.org>
In-Reply-To: <20200214154854.6746-408-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Feb 2020 11:22:27 -0500
Message-ID: <CADnq5_MMLNtb=3LLHsYnXtONQf4NWNgV226w2=OFk3JpCRj3sA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 408/542] drm/amdgpu: add the lost mutex_init
 back
To: Sasha Levin <sashal@kernel.org>
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBGZWIgMTQsIDIwMjAgYXQgMTA6NTcgQU0gU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IEZyb206ICJQYW4sIFhpbmh1aSIgPFhpbmh1aS5QYW5AYW1kLmNv
bT4KPgo+IFsgVXBzdHJlYW0gY29tbWl0IGJkMDUyMjExMjMzMjY2M2UzODZkZjFiODY0MjA1MjQ2
M2VhOWIzYjkgXQo+Cj4gSW5pdGlhbGl6ZSBub3RpZmllcl9sb2NrLgo+Cj4gQnVnOiBodHRwczov
L2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC9pc3N1ZXMvMTAxNgo+IFJldmlld2VkLWJ5
OiBGZWlmZWkgWHUgPEZlaWZlaS5YdUBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogeGluaHVp
IHBhbiA8eGluaHVpLnBhbkBhbWQuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8
c2FzaGFsQGtlcm5lbC5vcmc+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBpbmRleCAzMzJi
OWMyNGEyY2QwLi5hMmY3ODhhZDdlMWM2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC0yNzk3LDYgKzI3OTcsNyBAQCBpbnQgYW1kZ3B1X2Rl
dmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgICAgICAgbXV0ZXhfaW5p
dCgmYWRldi0+bm90aWZpZXJfbG9jayk7Cj4gICAgICAgICBtdXRleF9pbml0KCZhZGV2LT52aXJ0
LmRwbV9tdXRleCk7Cj4gICAgICAgICBtdXRleF9pbml0KCZhZGV2LT5wc3AubXV0ZXgpOwo+ICsg
ICAgICAgbXV0ZXhfaW5pdCgmYWRldi0+bm90aWZpZXJfbG9jayk7Cj4KClRoaXMgcGF0Y2ggaXMg
bm90IHJlbGV2YW50IGhlcmUuICBUaGUgc2FtZSBtdXRleCBpcyBhbHJlYWR5CmluaXRpYWxpemVk
IDMgbGluZXMgYWJvdmUuCgpBbGV4CgoKPiAgICAgICAgIHIgPSBhbWRncHVfZGV2aWNlX2NoZWNr
X2FyZ3VtZW50cyhhZGV2KTsKPiAgICAgICAgIGlmIChyKQo+IC0tCj4gMi4yMC4xCj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
