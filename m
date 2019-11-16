Return-Path: <SRS0=bOP+=ZI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54080C43141
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339DB216F4
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339DB216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C53B6E180;
	Sat, 16 Nov 2019 16:28:34 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3086E180
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 16:28:31 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id r10so14358830wrx.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 08:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=za3z+X1eZvkcDkdrH+tKgT42RrZGcEEa2bLAvmhyQCI=;
 b=LWT4rYGvdEdFEp3fr7oV+V4sTgVrCo+ofMKybM2qR8jDop63imVNOHZ3yxoT478uTH
 eN8NmwZTm62xN2sxZhQr6XQC40L0zDI+WC1nnxaZ3X83GOsiZD6QBpQvueTxH3Vjk00j
 Q09DmDW8eJQe31d+A3H++TYBPJNo3L1AlPAHeoP1SRTh6tXdNbsWql6KzpUE+oNRSt2s
 vCj/CSlhW4he/HrAC4QkB+O3iXz9CvWLj7jqD4624YSgVEr+9OjdOJylAqa3IS4wqm92
 9sF41mrwZ1FfV/0SctFjz70LfQ/tJiyUnp/u6vVw/4oEqIPB1vUGfBHOPdqJ+mdQiqIT
 o/FA==
X-Gm-Message-State: APjAAAVINn15g+0HvAeE77DZUvBvH8KB8X4numF90Ljp6W5paWcZM+Pc
 tdX5VSQrCOZlnLFUIBLvphJyMcFGjZHY9zmdp/I=
X-Google-Smtp-Source: APXvYqyllf/ZJp1ZmVfORDrjPICWsatkOUh9QT8/o6LLxGGzR0vTrPkOFbTZqeaJ2mnNEdQHV+sImgrDelaFbUs/SkE=
X-Received: by 2002:adf:f010:: with SMTP id j16mr22411389wro.206.1573921710518; 
 Sat, 16 Nov 2019 08:28:30 -0800 (PST)
MIME-Version: 1.0
References: <54001452.28591.1573888462309@localhost>
In-Reply-To: <54001452.28591.1573888462309@localhost>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 16 Nov 2019 11:28:19 -0500
Message-ID:
 <CADnq5_O-5qW6o=96iJoBf=0ZjJWA+RjcYiuRuLfWXpsG=m_JpQ@mail.gmail.com>
Subject: Re: Rebasing of amd-staging-drm-next
To: "Babutzka, Martin" <martin.babutzka@online.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=za3z+X1eZvkcDkdrH+tKgT42RrZGcEEa2bLAvmhyQCI=;
 b=jr4W/pvqWmrCbENeE2Xz2jbPYy8KomXs33NSnG0oua5BtaRTZEAfPeCfWDy4atiZAt
 H/Aay7+CBaYUJSV0pNxHBesE4E5bNeH5NI/iekg5iaNNYmiaoo/XiMrHJKSg/EBRcxKz
 NYB3qnH/HL5YCCZY52fkWqRc9LX1apzuYVQV7uXr05NBUi9JYjUcl4LFLwiBKC/IM+5U
 gsmwnTLYFckRIsojbZHQxt4niTiJxvB2OaLJ6pCLgu4t8cFam7pAIQfVbTsbLBd6Cbc6
 Wy8D0Q9VdiDsrOmz/a1Jf5hwfdleDKTbB9sBDINYgcmVOhYkxTu2su2YULAZg1qyapKd
 OMHA==
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
Message-ID: <20191116162819.k7gUbJ0QcUGqWSQfYls4MAc6BFZBAiPhzkF6GNg-F8g@z>

SXQgcm91Z2hseSBmb2xsb3dzIGRybS1uZXh0LiAgSWYgeW91IHdhbnQgc29tZXRoaW5nIG1vcmUg
dXAgdG8gZGF0ZSwKeW91IGNhbiB1c2UgbXkgZHJtLW5leHQgYnJhbmNoOgpodHRwczovL2NnaXQu
ZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eC9sb2cvP2g9ZHJtLW5leHQKCkFsZXgKCk9uIFNh
dCwgTm92IDE2LCAyMDE5IGF0IDExOjI1IEFNIEJhYnV0emthLCBNYXJ0aW4KPG1hcnRpbi5iYWJ1
dHprYUBvbmxpbmUuZGU+IHdyb3RlOgo+Cj4gRGVhciBBTUQgZGV2ZWxvcGVycywKPgo+IEFyZSB0
aGVyZSBwbGFucyB0byByZWJhc2UgdGhlIHN0YWdpbmcga2VubmVsIHRvIDUuND8gV291bGQgYmUg
Z3JlYXQgYmVjYXVzZSA1LjMgZG9lcyBub3QgYnVpbGRzIHByb3Blcmx5IGZvciBtZS4KPgo+IE1h
bnkgcmVnYXJkcywKPiBNYXJ0aW4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
