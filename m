Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7BC33C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 22:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5524820748
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 22:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNX9utem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5524820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB4B6F93B;
	Fri, 17 Jan 2020 22:00:52 +0000 (UTC)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DE46F93B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 22:00:51 +0000 (UTC)
Received: by mail-il1-x129.google.com with SMTP id f5so22491668ilq.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VGKBQ/L0qE48mFW99BrrF/P3uyY1DCAAVR3TeScy2Mo=;
 b=UNX9utemLE7XBncTCFd+zDxYIpjheE3CSl5+6mJEvsO5klFS+FPFtOmszZHP+d01xT
 bCtigzW2kVfg2GgCTbP+GDQ7as/36bvscia7ceSsA8oznV/nMthnFNgwMYifJVndpQ3A
 fO0qmPa6LncyW4tUsZWsyV8WijVrwWqM9VbZFOh0qLU/+w9KMqVNeD118/hO6fa9l326
 zM+I4oRYS1iSuCELmje1AUtQBI9LoxvczAqqoo03scSyrOa3tcGdW6/ygT7SEahdtCsf
 45F77oehHyWIyiDb1HIomAXHtF8x39Br+Tt3TaXS/X8DTMwGF+cRToSMHhsGJZMnSPve
 7faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VGKBQ/L0qE48mFW99BrrF/P3uyY1DCAAVR3TeScy2Mo=;
 b=eTd4zJxBd5XDp05JMgAPZNKwxzgteSiEFNs+XARAOXbDRuJEnbP/5gx9IdhtqP7G44
 3d153lD2zW8Hqz7clqe2jJYJGQ2A/0hV308Bp6vDfTc0PUVW9UslpMbUjpn4eWjilLiI
 /5gjJ0HY1cDSRzr78+h4SgiVg16GoZL58LFIzrwH1JMJb13nx0aqy7hrEj179nWX5Vtx
 GggiVQR86V44M/9tJ/hI4wgTvlIaz8VCBue+fyokBIVazHXyDxc8WusZIy3pGvYz0a5J
 nHV9z66SM/iBmf2EUEUSShYVVpS/5/UBQ2DBpBxz+8km538uB4YxRTWQBjTCoQUSX1LQ
 O2DQ==
X-Gm-Message-State: APjAAAU3DqtqIQ1nBL31KF+iAeCXEWQiznZ4WrSfHxPGwyTReGlswt6C
 Wp5Wk8RINPaXbgxJTAVHhJs+wUvUxC2gxc0FvRA=
X-Google-Smtp-Source: APXvYqzs9UbP1Kzl4X3J6DUxgpFIDnHhkn2jsgMcnFCuxmsM8v2eyV4jJvDDhOmNpsil5gODG5DHripv+1PjLdSxdiA=
X-Received: by 2002:a92:cacb:: with SMTP id m11mr638001ilq.133.1579298450932; 
 Fri, 17 Jan 2020 14:00:50 -0800 (PST)
MIME-Version: 1.0
References: <CANDnon=0S6yCCz17jUXKJ9eR_URpF2Mg9Rty4awmcDeKb0kF1w@mail.gmail.com>
In-Reply-To: <CANDnon=0S6yCCz17jUXKJ9eR_URpF2Mg9Rty4awmcDeKb0kF1w@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Fri, 17 Jan 2020 23:00:39 +0100
Message-ID: <CAD=4a=V0-k7+FU+fYgDJxeWtNJgdDXS49Qjie0KETKp6YWWjeQ@mail.gmail.com>
Subject: Re: Radeon rx 590 Fatboy on Linux still don't work
To: =?UTF-8?Q?Martin_B=C3=A5ngens?= <marbangens@gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Q291bGQgaXQgYmUgc29tZXRoaW5nIHBsYXRmb3JtIHJlbGF0ZWQ/ICJTb2NrZXQgMjAxMSBmb3Ig
Mm5kCkdlbmVyYXRpb24gQ29yZeKEoiBpNyBQcm9jZXNzb3JzICIgaXMgcHJvYmFibHkgbm90IHZl
cnkgd2VsbCB0ZXN0ZWQKdGhlc2UgZGF5cy4gSXQgc2hvdWxkIHdvcmsgb2YgY291cnNlLgoKRGVu
IGZyZSAxNyBqYW4uIDIwMjAga2wgMTg6NDggc2tyZXYgTWFydGluIELDpW5nZW5zIDxtYXJiYW5n
ZW5zQGdtYWlsLmNvbT46Cj4KPiBJIHN0aWxsIGhhdmUgcHJvYmxlbXMgd2l0aCBteSB2aWRlbyBj
YXJkLiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYWJvdXQgdGhyb3R0bGluZyBiZWF1cyBJIG9ubHkg
c2VlIHRoZSBwcm9ibGVtIHdpdGggc3BlY2lmaWMgZ2FtZXMuIExpa2UgYWxsIGdhbWVzIGFmdGVy
IDIwMTAgYW5kIG1vc3QgZ2FtZXMgYWZ0ZXIgMjAwNS4gSSBkb24ndCBrbm93IHdoYXQgaW5mb3Jt
YXRpb24gdG8gZ2l2ZSB5b3UgZGV2ZWxvcGVycy4gSSBoYXZlIHRpbWUgdG8gZG8gYW55dGhpbmcg
anVzdCB0ZWxsIG1lIGlmIHlvdSBuZWVkIG1lIHRvIHRlc3Qgc29tZXRoaW5nLgo+Cj4gd2hlbiBJ
IHBsYXkgZm9yIGV4YW1wbGUgQmFsY2sgTWVzYSBYZW4gb24gc3RlYW0gYWZ0ZXIgYWJvdXQgNS0x
MCBtaW4geG9yZyB3aWxsIGNyYXNoIGFuZCBzb21ldGltZXMgdGhlIExpbnV4IGtlcm5lbCB0b28K
Pgo+IEkgaGF2ZSBhdHRhY2hlZCBhIHBpY3R1cmUgc2hvdyB3aGF0IHRoZSBzY3JlZW4gbG9va3Mg
bGlrZSBhbmQgYSBkbWVzZyBsb2cgSSByZWNvcmRlZCByaWdodCBhZnRlciBYb3JnIGNyYXNoZWQK
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1n
ZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
