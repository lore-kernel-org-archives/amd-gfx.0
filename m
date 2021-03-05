Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A762C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D4D64F11
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 19:22:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D4D64F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881C46EC23;
	Fri,  5 Mar 2021 19:22:47 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BB16EC23
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 19:22:46 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id b8so2859730oti.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Mar 2021 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=skrZfzd85x66nmEFlrO7Dc1+jXvvw0x9u3WsdFuuTeo=;
 b=sA9xiKjx4iOXF+6llU6CUd/I0DR7DSUlClMJ+frCqbQHkvre/xYibylMJIs8ZzKbDK
 I65ZSYWH05elM6Q3II5bus6KqqA+ytfCp7S5i8QS+Ct+beT5NY4pHqmQxnDlODEJ0TDU
 bDHJcJQGrYm8dk3bRQBFTlYHlKSJ/mwz6zuN/E+K+0qGF5sZP504dacTu8mFobWwV3Qr
 U53WoueMpT5AY1RCUX96h0PCM7Ub8uwnWj+xyaFKsz1m2bMqeeprDEt4hi2vLBDX4gu+
 V8k3NvWZlIN7wapJ6qApOJGcVuHsexATBfedmHwaztyDjrq2a63xME5c09nckN+nE4cL
 4Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=skrZfzd85x66nmEFlrO7Dc1+jXvvw0x9u3WsdFuuTeo=;
 b=jqo0xkSXxL/6q91M+e6RDSgCjpNFbpQHKzIk0E/n6RfacNUd0V3aU5xrNbbmQ+8DaT
 FFcuMdKFAoh+Q5jYqET9djCk125lLgIaxXatoTWX9O5xNUsM70WhCpYLwcFilLRaZvmI
 EzW/HsE8pB27Q5QJZNAh3QOsqmmNFExJQkMjfPVce5sooiNq2HOIWnj7VtCj67kbj2FH
 mXiUNP0va+yJPR5xyVk+vUqrT1zSP3pFB7xzU5KQr7t2PE+IwukOEY4XZwhCPSxD5Bn7
 SjBXPUgtIye/ri/ok58z59u2dX/AiQNLFyAWppdqA/eWepbEtm5yLlBUItMhE7BuhFJn
 QUmg==
X-Gm-Message-State: AOAM531mEt1+d0c0J4f6TmKl8eI63pQEBIor1HAzj9qw0UwMTOb5lnrq
 fR63K+bNDs8pIrjMi4ljFfvbZjAVmeocbnlJNnSq+xDC
X-Google-Smtp-Source: ABdhPJxbGUdMJ5YVJY/RcYjP3GDFC8kqQ67b8Ya6sr/e4RMqVrPo2MDTRvCBJX1RQ7yPloUP5Lt+vcDrsDOrMvKWHi0=
X-Received: by 2002:a05:6830:408f:: with SMTP id
 x15mr9675201ott.132.1614972166386; 
 Fri, 05 Mar 2021 11:22:46 -0800 (PST)
MIME-Version: 1.0
References: <baf76b2f-1985-6b66-c672-559742d815bf@applied-asynchrony.com>
In-Reply-To: <baf76b2f-1985-6b66-c672-559742d815bf@applied-asynchrony.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Mar 2021 14:22:35 -0500
Message-ID: <CADnq5_Nt_ytxcQ-XCjKqFfYxJkP1jJRGXLc12yBygESu70AAJw@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/amd/display: Fix nested FPU context in
 dcn21_validate_bandwidth()
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCBNYXIgNSwgMjAyMSBhdCA2OjM5IEFNIEhvbGdlciBIb2Zmc3TDpHR0ZQo8aG9sZ2Vy
QGFwcGxpZWQtYXN5bmNocm9ueS5jb20+IHdyb3RlOgo+Cj4KPiBDb21taXQgNDE0MDFhYzY3Nzkx
IGFkZGVkIEZQVSB3cmFwcGVycyB0byBkY24yMV92YWxpZGF0ZV9iYW5kd2lkdGgoKSwKPiB3aGlj
aCB3YXMgY29ycmVjdC4gVW5mb3J0dW5hdGVseSBhIG5lc3RlZCBmdW5jdGlvbiBhbHJlZHkgY29u
dGFpbmVkCj4gRENfRlBfU1RBUlQoKS9EQ19GUF9FTkQoKSBjYWxscywgd2hpY2ggcmVzdWx0cyBp
biBuZXN0ZWQgRlBVIGNvbnRleHQKPiBlbnRlci9leGl0IGFuZCBjb21wbGFpbnRzIGJ5IGtlcm5l
bF9mcHVfYmVnaW5fbWFzaygpLgo+IFRoaXMgY2FuIGJlIG9ic2VydmVkIGUuZy4gd2l0aCA1LjEw
LjIwLCB3aGljaCBiYWNrcG9ydGVkIDQxNDAxYWM2Nzc5MQo+IGFuZCBub3cgZW1pdHMgdGhlIGZv
bGxvd2luZyB3YXJuaW5nIG9uIGJvb3Q6Cj4KPiBXQVJOSU5HOiBDUFU6IDYgUElEOiA4NTggYXQg
YXJjaC94ODYva2VybmVsL2ZwdS9jb3JlLmM6MTI5IGtlcm5lbF9mcHVfYmVnaW5fbWFzaysweGE1
LzB4YzAKPiBDYWxsIFRyYWNlOgo+ICAgZGNuMjFfY2FsY3VsYXRlX3dtKzB4NDcvMHhhOTAgW2Ft
ZGdwdV0KPiAgIGRjbjIxX3ZhbGlkYXRlX2JhbmR3aWR0aF9mcCsweDE1ZC8weDJiMCBbYW1kZ3B1
XQo+ICAgZGNuMjFfdmFsaWRhdGVfYmFuZHdpZHRoKzB4MjkvMHg0MCBbYW1kZ3B1XQo+ICAgZGNf
dmFsaWRhdGVfZ2xvYmFsX3N0YXRlKzB4M2M3LzB4NGMwIFthbWRncHVdCj4KPiBUaGUgd2Fybmlu
ZyBpcyBlbWl0dGVkIGR1ZSB0byB0aGUgYWRkaXRpb25hbCBEQ19GUF9TVEFSVC9FTkQgY2FsbHMg
aW4KPiBwYXRjaF9ib3VuZGluZ19ib3goKSwgd2hpY2ggaXMgaW5saW5lZCBpbnRvIGRjbjIxX2Nh
bGN1bGF0ZV93bSgpLAo+IGl0cyBvbmx5IGNhbGxlci4gUmVtb3ZpbmcgdGhlIGNhbGxzIGJyaW5n
cyB0aGUgY29kZSBpbiBsaW5lIHdpdGgKPiBkY24yMCBhbmQgbWFrZXMgdGhlIHdhcm5pbmcgZGlz
YXBwZWFyLgo+Cj4gRml4ZXM6IDQxNDAxYWM2Nzc5MSAoImRybS9hbWQvZGlzcGxheTogQWRkIEZQ
VSB3cmFwcGVycyB0byBkY24yMV92YWxpZGF0ZV9iYW5kd2lkdGgoKSIpCj4gU2lnbmVkLW9mZi1i
eTogSG9sZ2VyIEhvZmZzdMOkdHRlIDxob2xnZXJAYXBwbGllZC1hc3luY2hyb255LmNvbT4KCkFw
cGxpZWQuICBUaGFua3MhCgpBbGV4Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMgfCA0IC0tLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY24yMS9kY24yMV9yZXNvdXJjZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjbjIxL2RjbjIxX3Jlc291cmNlLmMKPiBpbmRleCAwNzJmOGM4ODA5MjQuLjY4YmU3
M2ZlMmUyMyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNu
MjEvZGNuMjFfcmVzb3VyY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY24yMS9kY24yMV9yZXNvdXJjZS5jCj4gQEAgLTEwNjIsOCArMTA2Miw2IEBAIHN0YXRpYyB2
b2lkIHBhdGNoX2JvdW5kaW5nX2JveChzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgX3Zjc19kcGlfc29j
X2JvdW5kaW5nX2JveF9zCj4gICB7Cj4gICAgICAgICBpbnQgaTsKPgo+IC0gICAgICAgRENfRlBf
U1RBUlQoKTsKPiAtCj4gICAgICAgICBpZiAoZGMtPmJiX292ZXJyaWRlcy5zcl9leGl0X3RpbWVf
bnMpIHsKPiAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IFdNX1NFVF9DT1VOVDsgaSsr
KSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICBkYy0+Y2xrX21nci0+YndfcGFyYW1zLT53
bV90YWJsZS5lbnRyaWVzW2ldLnNyX2V4aXRfdGltZV91cyA9Cj4gQEAgLTEwODgsOCArMTA4Niw2
IEBAIHN0YXRpYyB2b2lkIHBhdGNoX2JvdW5kaW5nX2JveChzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3Qg
X3Zjc19kcGlfc29jX2JvdW5kaW5nX2JveF9zCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkYy0+YmJfb3ZlcnJpZGVzLmRyYW1fY2xvY2tfY2hhbmdlX2xhdGVuY3lfbnMgLyAxMDAw
LjA7Cj4gICAgICAgICAgICAgICAgIH0KPiAgICAgICAgIH0KPiAtCj4gLSAgICAgICBEQ19GUF9F
TkQoKTsKPiAgIH0KPgo+ICAgdm9pZCBkY24yMV9jYWxjdWxhdGVfd20oCj4gLS0KPiAyLjMwLjEK
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1k
LWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
