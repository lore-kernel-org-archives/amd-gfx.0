Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8705C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 19:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6080764E0F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 19:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6080764E0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23BC06E929;
	Mon, 15 Feb 2021 19:11:35 +0000 (UTC)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D016E927;
 Mon, 15 Feb 2021 19:11:33 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id e5so6945074otb.11;
 Mon, 15 Feb 2021 11:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vyYLUpmU6IFRJn6DkBKZeMcUTefwAqDTD3LpFwE2YRQ=;
 b=rDBXPPfdjkQEcUimIMOZ9aaFzfzO8+xnlCYgYQ3JYTiqLSTBLZL/k8vns9Ay9aM1pT
 W61lEwJNeibCKdPJpXJXd97lDPSZ3ET1aHvUkyTZQTSQqB7RcY/SJ7F1tyAoCgsuPfnd
 nlyeJjlW+UW4LXEDMG80mek+H5aMYRUMqa9fOmIkx7Xu7yANlTT0vpErmyKgrA3/8Odb
 ZKCpW3sT5FlFtaVBvmMtODwiUZPyvJDFD38DmfDqqnF8ckhoWP3oH/TJ9Ket6VLOLmIh
 DZtFOUY+e3dx5XxRby1NlZ1nlyTqH4gHKTh0if/F8d+QY3u3xneaOlP9N5KGL/9WIkcJ
 2uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vyYLUpmU6IFRJn6DkBKZeMcUTefwAqDTD3LpFwE2YRQ=;
 b=hOeQbhC2VD25h4ZY3OtBiJloFr/96/6XF17ZMwiPuD8L51HMSbFvMjEbVct7vh6cuT
 WHNquO0rB93dXw3p/HTANgCpiif5Pn3LwGZD5FwCjPaMVdf9FulKUvQ2mzNC3ExAn49i
 7Dxvd87Ff2F6bAKjl/2C54RpZzDzeCnJKN+KKardIEpIuD2zTsD7a879Gg0hFmtKLtA7
 bZAGVyIJJavbSsZMuDp3WHz4O/wukwQof/2LBFKIP8z8aPHyk6PkIojHNJfb/0mXqdXC
 nkzcg1L8QiXAUQTntO+97f73c49bDBKIVMXRvYm1t0yc1h6e+W4W6zp6wmUeF/kfVhsC
 uptA==
X-Gm-Message-State: AOAM533DAuZyxW9mC22Bv0ywrnbFRHFjem3I2mMLEsGuU3OnWLpqoBRR
 n3xMv60gV4ARSjvBTBvnfWoyxJGxRk7qTmY0BDc=
X-Google-Smtp-Source: ABdhPJx/Vn6fcl5sqAzH0f80Fk2jbYVMI6anacnhUcIiN4wTSQDpSzu7jDeQYQ/knjwSk88tz0gSAcjzdwbccBFSLMc=
X-Received: by 2002:a9d:12f2:: with SMTP id
 g105mr13136151otg.132.1613416293415; 
 Mon, 15 Feb 2021 11:11:33 -0800 (PST)
MIME-Version: 1.0
References: <1613384489-3102-1-git-send-email-chen45464546@163.com>
 <e045d7ad-c9a5-e956-7efc-b0b1a7db1247@amd.com>
In-Reply-To: <e045d7ad-c9a5-e956-7efc-b0b1a7db1247@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Feb 2021 14:11:22 -0500
Message-ID: <CADnq5_M7g1=i9Dqrks2Z1tZfV=+HMwfnfaFCyMyAc9tu4kBQ5g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Remove unused function pointer typedef
 radeon_packet3_check_t
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Dave Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Chen Lin <chen.lin5@zte.com.cn>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Chen Lin <chen45464546@163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIE1vbiwgRmViIDE1LCAyMDIxIGF0IDU6NDMgQU0g
Q2hyaXN0aWFuIEvDtm5pZwo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPgo+Cj4K
PiBBbSAxNS4wMi4yMSB1bSAxMToyMSBzY2hyaWViIENoZW4gTGluOgo+ID4gRnJvbTogQ2hlbiBM
aW4gPGNoZW4ubGluNUB6dGUuY29tLmNuPgo+ID4KPiA+IFJlbW92ZSB0aGUgJ3JhZGVvbl9wYWNr
ZXQzX2NoZWNrX3QnIHR5cGVkZWYgYXMgaXQgaXMgbm90IHVzZWQuCj4gPgo+ID4gU2lnbmVkLW9m
Zi1ieTogQ2hlbiBMaW4gPGNoZW4ubGluNUB6dGUuY29tLmNuPgo+Cj4gUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+ID4gLS0tCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmggfCAgICAzIC0tLQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb24uaCBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uLmgKPiA+
IGluZGV4IDVmM2FkYmEuLmExYzM4YjUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbi5oCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbi5o
Cj4gPiBAQCAtMTExMSw5ICsxMTExLDYgQEAgc3RydWN0IHJhZGVvbl9jc19wYWNrZXQgewo+ID4g
ICB0eXBlZGVmIGludCAoKnJhZGVvbl9wYWNrZXQwX2NoZWNrX3QpKHN0cnVjdCByYWRlb25fY3Nf
cGFyc2VyICpwLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHJhZGVvbl9jc19wYWNrZXQgKnBrdCwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGlkeCwgdW5zaWduZWQgcmVnKTsKPiA+IC10eXBlZGVmIGludCAoKnJh
ZGVvbl9wYWNrZXQzX2NoZWNrX3QpKHN0cnVjdCByYWRlb25fY3NfcGFyc2VyICpwLAo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJhZGVvbl9jc19wYWNrZXQg
KnBrdCk7Cj4gPiAtCj4gPgo+ID4gICAvKgo+ID4gICAgKiBBR1AKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
