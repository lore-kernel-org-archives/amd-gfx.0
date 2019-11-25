Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F289C43215
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:59:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DF720748
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 14:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DF720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085B48916C;
	Mon, 25 Nov 2019 14:59:46 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FAA78916C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 14:59:44 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id j18so91069wmk.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 06:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Qhl1u3lfTfcvs7z4NDIoMEL/nUpKjiQ+wyvFXBVYgw=;
 b=F4E2JsWaDYXpPP9FvyYtiTdEeVlnmNhTlaX7+YgAC6C374wduv7MARZdnyzgo4RsGe
 QY2VfGjIJo4NJFCsDoCcuRgZHtGsaWQPH15dHaWpklnnzWAZNzScrI7UPB3oHTSLRyqL
 Uz4KewggmLp0xq3m4UMNSQFzb9xPIN9H0zKeWEXjQik2H392MfO5lX013GKvFbe3XHXW
 n4AzAC1Ez5LxZOOR9OJHSXBCgJEEGNSNshMCsKRgv3XlUh+mf5btcfv40LSKUP4fS0No
 0kPUdSe8FNELmk9Eeypr4L/ha2sIwFWTmN5khChOcOmg3umni9b9swJvYdiu75xgab+0
 uSBw==
X-Gm-Message-State: APjAAAWHMCJfP6eVYTVLng5lzyq/POfPgZ7T9/16d0jv7SaTTFHg9Skc
 LJjfgxWgzhJ3KFhhZ5pTFKokK9v4K03vAVh0tv1ang==
X-Google-Smtp-Source: APXvYqyoiOE60mPZNAi1DPDB7Fsu7I3e4gAhRCFY/N7TtboIs5HND3DkGHzPqfkwXvu4rcCFb2SK6r3WSO2nl4WRe/A=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr30393957wmi.67.1574693983167; 
 Mon, 25 Nov 2019 06:59:43 -0800 (PST)
MIME-Version: 1.0
References: <2068915477.1923611.1574622916022.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <2068915477.1923611.1574622916022.JavaMail.zimbra@raptorengineeringinc.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Nov 2019 09:59:32 -0500
Message-ID:
 <CADnq5_OTVUDrkBda-RtVpKdEY4vKZvq-fLfW0u71g9C4TWXHdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] amdgpu: Enable KFD on POWER systems
To: Timothy Pearson <tpearson@raptorengineering.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=8Qhl1u3lfTfcvs7z4NDIoMEL/nUpKjiQ+wyvFXBVYgw=;
 b=NHYmnulBhbrTQaiLh/0ifx/p/v+JDyKDOSqP/pkEXWOk5VLTxiHOY/RxG5GqaUWQL4
 /A7i/IrSQ9dyd0L71C9vBj3nBlYE1cYDmuTxOagp2+TxtbDzALELeki0C1f86KAcCh8m
 fi1GSxqqFDSCZQHDU6t10GDMZ5S8sosCyU0wQE+Na8/1tVaMfCMfR+ZZJdE2UM/nav6v
 2GbD0qZvvbCq1NtagM1T5CwfEnVlGoCKHu7KPkDz50yxKAh0mR0k57H7zi90Y7PtTbCc
 xN1jp9zhFF7RAPH+aoE1HO1Kej4Cy2e+H6314d5AaN+fzJu4tXNOf+uAQYHWH/aUZFBi
 T47g==
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
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125145932.s6p3wbNcBHIX1_BxjBrANRDE7UynZB3VNm9My-EcODM@z>

T24gU3VuLCBOb3YgMjQsIDIwMTkgYXQgMjoxNSBQTSBUaW1vdGh5IFBlYXJzb24KPHRwZWFyc29u
QHJhcHRvcmVuZ2luZWVyaW5nLmNvbT4gd3JvdGU6Cj4KPiBLRkQgaGFzIGJlZW4gdmVyaWZpZWQg
dG8gZnVuY3Rpb24gb24gUE9XRVIgc3lzdGVtcyAoVGFsb3MgSUkgLyBWZWdhIDY0KS4KPiBJdCBz
aG91bGQgYmUgYXZhaWxhYmxlIGFzIGEga2VybmVsIGNvbmZpZ3VyYXRpb24gb3B0aW9uIG9uIHRo
ZXNlIHN5c3RlbXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBUaW1vdGh5IFBlYXJzb24gPHRwZWFyc29u
QHJhcHRvcmVuZ2luZWVyaW5nLmNvbT4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnIHwgMiArLQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQvS2NvbmZpZwo+IGluZGV4IGExYTM1ZDRkNTk0Yi4uYmEwZTY4MDU3YTg5IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4gQEAgLTUsNyArNSw3IEBACj4KPiAgY29uZmlnIEhT
QV9BTUQKPiAgICAgICAgIGJvb2wgIkhTQSBrZXJuZWwgZHJpdmVyIGZvciBBTUQgR1BVIGRldmlj
ZXMiCj4gLSAgICAgICBkZXBlbmRzIG9uIERSTV9BTURHUFUgJiYgKFg4Nl82NCB8fCBBUk02NCkK
PiArICAgICAgIGRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiAoWDg2XzY0IHx8IEFSTTY0IHx8IFBQ
QzY0KQo+ICAgICAgICAgaW1wbHkgQU1EX0lPTU1VX1YyIGlmIFg4Nl82NAo+ICAgICAgICAgc2Vs
ZWN0IE1NVV9OT1RJRklFUgo+ICAgICAgICAgaGVscAo+IC0tCj4gMi4yMC4xCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeA==
