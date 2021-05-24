Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A41C04FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 19:25:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A63613FC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 19:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A63613FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84DB66E91C;
	Mon, 24 May 2021 19:25:46 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B726E91C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 May 2021 19:25:44 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id n2so43468996ejy.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 May 2021 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=6g30Jr3gi294txvYDw/FdE/OcIJ1BIfyfrFexzVIPIA=;
 b=XVIwOfz/CpK4FEeBpCoM+5khe88DZRzuwwwsp+gpoMibzn4+j9mPLUpfC/U5s7EGUw
 4FcujGF0mcR8t04ttTf9BO0HXdPQX+hUxqnJXenNpht/TNxxlwwG2b4es4oiMf/2F6Y6
 BlTkQWjyqiCL+PFIjYRzYJXNQkOpUlrqK/hDB71KDswdK7ObfaIncnhETZTGq5PwHKIz
 sTamjtgpn1a2yWi//Ndkp4kP27fIqW7HDofi6cV8POPdz2lXzGiVXsWxuWT7rcQzvT8u
 4vqRS63nN1JQx+kkw+1ENoPF71gnKv74eiELVPhQ/ZnS750TiWsOuGTWZhFS6A1hNySz
 /sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=6g30Jr3gi294txvYDw/FdE/OcIJ1BIfyfrFexzVIPIA=;
 b=oZyNWg7P9dVY9WJKaDF3i+5xJccZFuncZWCFmakjtfLGo/8kRgMh/3mrYE3IVzaQkT
 yuzDA/i+QID96QSippM3VhTRKPbDmOsD4cNyWJpG6wljR+9xoNNsesDV6cmyaBG0+HGT
 O4iHr409qP3HHZzZ+rpkse7Cz3moiq/3HHI4dEEbG/aSwZomHIXwGK/lYp0K7suqsxEk
 8ZGu6m6zN8+Z5g30Y5dxkk0zgRsdb9liR+I0/Cn5OFeP5vtSoM7q9GTzQKOF84TltyL3
 FTfJ9a98uHyMW9YPgRCIyzZqvV+JbQVQBa2gEk0i0imwNOcWm08PXsdYQ4Nm6zfhRSPQ
 RWcg==
X-Gm-Message-State: AOAM5329kegcL72muAfwVV44ry1/4gTOtFEVc4zOuMXfSLieNLh/Ym6L
 oO/6x5vATFrMWnk13t25mZjTfz1gt4LCi5WJk4S55j8jNdM=
X-Google-Smtp-Source: ABdhPJwKAF8//gdtN28l1udA8BjCc81MLVgl53ZFI6NqESi2RTsXmsSyTlYKxQ9i+WHLU+ApHoiDrB1LL15xQTMETiI=
X-Received: by 2002:a17:906:2a56:: with SMTP id
 k22mr25265871eje.551.1621884342881; 
 Mon, 24 May 2021 12:25:42 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Mon, 24 May 2021 20:25:31 +0100
Message-ID: <CAEzXK1pXrnXpBfzZ9c-8MsYpoDCRt86F7yU=uLi52i96u8+SQA@mail.gmail.com>
Subject: Regression: bisected: AMDGPU causes Kernel Bad page state OOPS
 starting with kernels 5.11.x, 5.12.x, 5.13-rc
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGksCgpBTURHUFUgd2FzIHdvcmtpbmcgZmluZSBvbiBteSBhcm1oZiBzeXN0ZW1zIHdpdGggNS4x
MC54IGFuZCBwcmV2aW91cwprZXJuZWxzIGFuZCBhIFJYNTUwIGNhcmQuIFVuZm9ydHVuYXRlbHkg
SSBoYXZlIG9ubHkgbm93IHRlc3RlZCBrZXJuZWxzCjUuMTEueCwgNS4xMi54IGFuZCA1LjEzLXJj
IGFuZCBhbGwgYXJlIG5vdyBzaG93aW5nIHByb2JsZW1zIGxpa2UgdGhpcwpvbmU6Ck1heSAxMCAy
MDoyMzoxNCBwaWNvbG8ga2VybmVsOiBbICAgMTguOTY3NjI2XSBCVUc6IEJhZCBwYWdlIHN0YXRl
IGluCnByb2Nlc3MgZ25vbWUtc2hlbGwgIHBmbjo3OGMwOApNYXkgMTAgMjA6MjM6MTQgcGljb2xv
IGtlcm5lbDogWyAgIDE4Ljk3Mzc1MF0gcGFnZTpjZTJlOTcxNyByZWZjb3VudDoyCm1hcGNvdW50
OjEgbWFwcGluZzoxN2VkY2VkMCBpbmRleDoweDEwOWU5IHBmbjoweDc4YzA4Ck1heSAxMCAyMDoy
MzoxNCBwaWNvbG8ga2VybmVsOiBbICAgMTguOTczNzYzXSBhb3BzOjB4YzBlMTJmNTQgaW5vOjMw
ZAoKRnVsbCBLZXJuZWwgYm9vdCBsb2cgaXMgaGVyZQpodHRwczovL3Bhc3RlYmluLmNvbS9wY3VV
V1hiagoKSSd2ZSBiaXNlY3RlZCBhbmQgdHJhY2VkIHRoZSBwcm9ibGVtIHRvIHRoaXMgY29tbWl0
OgplOTNiMmRhOTc5OWU1Y2I5Nzc2MDk2OWYzZTFmMDJhNWJkYWMyOWZlIGlzIHRoZSBmaXJzdCBi
YWQgY29tbWl0CmNvbW1pdCBlOTNiMmRhOTc5OWU1Y2I5Nzc2MDk2OWYzZTFmMDJhNWJkYWMyOWZl
CkF1dGhvcjogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpEYXRl
OiAgIFNhdCBPY3QgMjQgMTM6MTE6MjkgMjAyMCArMDIwMAoKICAgIGRybS9hbWRncHU6IHN3aXRj
aCB0byBuZXcgYWxsb2NhdG9yIHYyCgogICAgSXQgc2hvdWxkIGJlIGFibGUgdG8gaGFuZGxlIGFs
bCBjYXNlcyBoZXJlLgoKICAgIHYyOiBmaXggZGVidWdmcyBhcyB3ZWxsCgogICAgU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgogICAgUmV2
aWV3ZWQtYnk6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+CiAgICBSZXZpZXdlZC1i
eTogTWFkaGF2IENoYXVoYW4gPG1hZGhhdi5jaGF1aGFuQGFtZC5jb20+CiAgICBUZXN0ZWQtYnk6
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+CiAgICBMaW5rOiBodHRwczovL3BhdGNod29y
ay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMzk3MDg2Lz9zZXJpZXM9ODMwNTEmcmV2PTEKCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCA0NSArKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzMSBk
ZWxldGlvbnMoLSkKCkRldGFpbGVkIGJpc2VjdCBsb2cgaXMgaGVyZToKaHR0cHM6Ly9iaW4ucHJp
dmFjeXRvb2xzLmlvLz9hODhhZTYzZmI5NWZhMWMxI0V0ckM0cXhHV2ptZ3k1QzNkQnpYRkdxanhj
N3puVEtVTHR6NGN4b1lGeFc1CgpCZXN0IHJlZ2FyZHMsCkx1w61zIE1lbmRlcwpBcGFyYXBpIGRl
dmVsb3BlcgpQaEQgU3R1ZGVudCAmIFJlc2VhcmNoZXIKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
