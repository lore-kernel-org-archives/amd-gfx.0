Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772F6C07E99
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 18:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28E2611CC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 18:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28E2611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B318A89D79;
	Mon, 12 Jul 2021 18:35:56 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 938DB89D79
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jul 2021 18:35:55 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 e203-20020a4a55d40000b029025f4693434bso1331921oob.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jul 2021 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3ZzJt5zsgvGbU38v5a7n+FXJpb7h1OVy581gEbHA2rY=;
 b=vFL8iV1RiFwD+VIIRxdehPmyjo+l7xX8uaTqG54Ai57p05A7de+ihuXOvEHwCgZt7s
 m3qFiDl6XQUbMgl7SALbiGIfGREf6X5IopsEzGO193LeH3gXhK6EQP+xFD9saXC0T5DJ
 AE7GV5htE/scgf7vfcqjrUBY2al5bgJrFB4zez0OP3UBJfehPxeIdarM71Mre4IRYhjP
 q/EadP/wsgIi4obwNASTthGsrtw0aStdVkzfpvpu9PzbMWu4fbWNB4wZGRRzFiht2U/m
 v0Rs/6HONHkWajkq9Rwf5RinXtB15PMC91ySKEb9s70zzybVp9NuE/h2mozAcdHvuEiK
 8wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3ZzJt5zsgvGbU38v5a7n+FXJpb7h1OVy581gEbHA2rY=;
 b=DNMz1T3P+m4uWKshi2lBBFjBUiVjCwTGeRhK9RtQEWbUlxFVw7VO1fXxtYwYcP0f4R
 g50PuwGGas5SnNjtoEm70lyTIiUS/BiQ8QsEy1WwxBtcmqE9oCW5nj/yL4PsHJdjHGFa
 LLrX2T9WhZuDGGCwy26wqzcbk4qOkDntuVLbM6b48M40Wub2YWrSndGiXmlr2Faxc1mx
 a7kGq4rWH0BbnEH8iagLNVx3EDDKAqIArFxUhdkm2d7jqg4Fh9kf3PLCDVyayb5UCNIa
 lB3AjGGOBEQcc7QH5Poriq1KaoYBJORQ/H9lnHsomWz8RTT7qEFpnUwJlqCodP6hZsBo
 h1ug==
X-Gm-Message-State: AOAM532VOvOw4JI0WU94/JpqKhR0N7An8m59HtyNR1odeGhUh/1orewc
 HhXbZNIemizu9FpUy1gXcz/YwVyvpUC5KxKgXSM=
X-Google-Smtp-Source: ABdhPJxwr4GVH2v2MYJVr8wV5+znOUZvISl5MmCBKi/AxFYvexwHpT3IcdhZMaLPrZ+ErX3nDO+vUQLxf07XzsCHnPg=
X-Received: by 2002:a4a:be93:: with SMTP id o19mr434757oop.61.1626114954968;
 Mon, 12 Jul 2021 11:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOHtt3_wfx1kpcjA3s63x+TaHS8DmCSk629OAN+Bi5nZzwrb5Q@mail.gmail.com>
In-Reply-To: <CAOHtt3_wfx1kpcjA3s63x+TaHS8DmCSk629OAN+Bi5nZzwrb5Q@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Jul 2021 14:35:44 -0400
Message-ID: <CADnq5_Mx3oR6SGSz9R3muVrv4zLhYJt8Zf=uDnNx9p6mXfbGUA@mail.gmail.com>
Subject: Re: Waiting for fences timed out on MacBook Pro 2019
To: =?UTF-8?Q?Tomasz_Mo=C5=84?= <desowin@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKdWwgMTIsIDIwMjEgYXQgNTo1NyBBTSBUb21hc3ogTW/FhCA8ZGVzb3dpbkBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gSGVsbG8sCj4KPiBJIGFtIGhhdmluZyB0cm91YmxlIGdldHRpbmcg
TGludXggdG8gcnVuIG9uIE1hY0Jvb2sgUHJvIDIwMTkgd2l0aAo+IFJhZGVvbiBQcm8gVmVnYSAy
MCA0IEdCLiBCYXNpY2FsbHkgYXMgc29vbiBhcyBncmFwaGljYWwgdXNlciBpbnRlcmZhY2UKPiBz
dGFydHMsIHRoZSB3aG9sZSBzeXN0ZW0gZnJlZXplcy4gVGhpcyBoYXBwZW5zIHdpdGggZXZlcnkg
TGludXgga2VybmVsCj4gdmVyc2lvbiBJIGhhdmUgdHJpZWQgb3ZlciB0aGUgbGFzdCBmZXcgbW9u
dGhzLCBpbmNsdWRpbmcgNS4xMy4KCklmIHRoaXMgaXMgYSByZWdyZXNzaW9uLCBjYW4geW91IGJp
c2VjdD8KCkFsZXgKCgo+Cj4gVXNpbmcgU1NIIEkgaGF2ZSBiZWVuIGFibGUgdG8gcmVhZCBkbWVz
ZyBvdXRwdXQ6Cj4gWyAgMjA3LjExMzE0NF0gW2RybTphbWRncHVfZG1fYXRvbWljX2NvbW1pdF90
YWlsIFthbWRncHVdXSAqRVJST1IqCj4gV2FpdGluZyBmb3IgZmVuY2VzIHRpbWVkIG91dCEKPiBb
ICAyMDcuMTEzMTY4XSBbZHJtOmFtZGdwdV9kbV9hdG9taWNfY29tbWl0X3RhaWwgW2FtZGdwdV1d
ICpFUlJPUioKPiBXYWl0aW5nIGZvciBmZW5jZXMgdGltZWQgb3V0IQo+IFsgIDIxMi4wMjk4NjZd
IFtkcm06YW1kZ3B1X2pvYl90aW1lZG91dCBbYW1kZ3B1XV0gKkVSUk9SKiByaW5nIGdmeAo+IHRp
bWVvdXQsIHNpZ25hbGVkIHNlcT0xMDIyLCBlbWl0dGVkIHNlcT0xMDI0Cj4gWyAgMjEyLjAzMDA4
M10gW2RybTphbWRncHVfam9iX3RpbWVkb3V0IFthbWRncHVdXSAqRVJST1IqIFByb2Nlc3MKPiBp
bmZvcm1hdGlvbjogcHJvY2VzcyBYb3JnIHBpZCA5MTggdGhyZWFkIFhvcmc6Y3MwIHBpZCA5MTkK
PiBbICAyMTIuMDMwMjc2XSBhbWRncHUgMDAwMDowMzowMC4wOiBhbWRncHU6IEdQVSByZXNldCBi
ZWdpbiEKPiBbICAyMTYuMDMwMjg2XSBhbWRncHUgMDAwMDowMzowMC4wOiBhbWRncHU6IGZhaWxl
ZCB0byBzdXNwZW5kIGRpc3BsYXkgYXVkaW8KPiBbICAyMjcuMzk2NTkzXSBhcHBsZXNtYzogZHJp
dmVyIGluaXQgZmFpbGVkIChyZXQ9LTUpIQo+Cj4gSG93IGRvIEkgZGVidWcgdGhpcyBmdXJ0aGVy
Pwo+Cj4gQmVzdCByZWdhcmRzLAo+IFRvbWFzeiBNb8WECj4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
