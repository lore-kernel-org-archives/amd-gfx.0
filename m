Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DE7C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1AF2073D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM3hw+ck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1AF2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278376EB75;
	Wed, 11 Dec 2019 15:50:46 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC1F6EB75
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:50:44 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id n9so7654838wmd.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 07:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=U3mcyuaxxc1C5VTrZemajTcMPdGkeVdsn1qMmckmPOY=;
 b=UM3hw+ckg+mTFHs4Vm0DHrBY91Pbo9PCC3w5WnkJReSkbrMV9G8DlkhIoNV5n2O9GD
 cMcE+3WbMHqGFWm8pno1az6OM4qecEPiX/qhspd6aGsMYRwEppIWwCNwxsRpQ4a2UeFZ
 Y7HHrwvziMSPJGcWWuwNeE1eKAgaHMUvYQdmS39Gs/8tzTzjEppA5ekVS1yU2vlfC3PG
 zMy6Z6dA7ZQNQNufIWIPqyKy0f0qRp5Qy9Qga1zGxpizMuabXrzRNoJhhSz/kWzHWPFQ
 RqsCEAQX5cXFokeYrQe4wH7WMZNcapeiC4QqIu00/8CH0Sdt5reo6KIzCkj+rR+XRfQA
 bumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=U3mcyuaxxc1C5VTrZemajTcMPdGkeVdsn1qMmckmPOY=;
 b=AzQaz3dsFyRLeU/xSQuT5nc9vclL9aSPwwbMan1QUoLTTGDlBWARZqoCctcwfbXrYZ
 /JcId5EI1jz56iVXEVHOwkEjNQb67knMXCQnBTwUGeVJr5Th2fqVxCsn2fdzVTgZusl5
 VKfiMreofCeVDjFiJ/TOFSugKmKA8WX81SWMcxDe8ylL+UNTPIuzZGdqDZSNTs6VaZG+
 pza+V1Rf7MzKe+LjjpXIW9TE+Sa/Cni65mM/tZ517CWR06Re5MJ+n8olmTNOz59RzbzQ
 GJ5+q5V9scG++x8HL6a07j4N/TDA8qbX5LehEpLeS/Y5bSHRrAPOYCqi2hXiWlCGsfX3
 mk2A==
X-Gm-Message-State: APjAAAW/rjEVnHCFdCS3SCAnHgoQrOFTv2d589sns/DilMysQUXr8kKR
 WhvxlH4exQyhhTO1p15npxw=
X-Google-Smtp-Source: APXvYqxcesNg8GXHGaHPRXF2/rRqb7j2AbcNDsuWUI+ZJjwSo2xixhPDn2OfQbSeqJFxHAbW98IKvw==
X-Received: by 2002:a05:600c:22c8:: with SMTP id
 8mr489144wmg.178.1576079443022; 
 Wed, 11 Dec 2019 07:50:43 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id b10sm2641020wrt.90.2019.12.11.07.50.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 07:50:42 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix license on Kconfig and Makefiles
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191211153316.1946311-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6517eb35-1ee6-7a68-68d0-1f1d24047304@gmail.com>
Date: Wed, 11 Dec 2019 16:50:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211153316.1946311-1-alexander.deucher@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMTIuMTkgdW0gMTY6MzMgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gYW1kZ3B1IGlzIE1J
VCBsaWNlbnNlZC4KPgo+IEZpeGVzOiBlYzhmMjRiN2ZhYWYzZCAoInRyZWV3aWRlOiBBZGQgU1BE
WCBsaWNlbnNlIGlkZW50aWZpZXIgLSBNYWtlZmlsZS9LY29uZmlnIikKPiBTaWduZWQtb2ZmLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tjb25maWcgICAgICAgICAgICAgICB8IDIgKy0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L0tjb25maWcgICAgICAgICAgICB8IDIgKy0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcgICAgICAgICAgICB8IDIgKy0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmlnICAgICAgICAgICB8IDIgKy0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9NYWtlZmlsZSB8IDEgKwo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL01ha2VmaWxlIHwgMSArCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZHNjL01ha2VmaWxlICAgfCAxICsKPiAgIDcgZmls
ZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tjb25maWcgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FjcC9LY29uZmlnCj4gaW5kZXggMTliYWU5MTAwZGE0Li4xMzM0MGYzNTNlYTggMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hY3AvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYWNwL0tjb25maWcKPiBAQCAtMSw0ICsxLDQgQEAKPiAtIyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1J
VAo+ICAgbWVudSAiQUNQIChBdWRpbyBDb1Byb2Nlc3NvcikgQ29uZmlndXJhdGlvbiIKPiAgIAo+
ICAgY29uZmlnIERSTV9BTURfQUNQCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L0tjb25maWcgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9LY29uZmlnCj4gaW5k
ZXggMmU5OGMwMTZjYjQ3Li45Mzc1ZTdmMTI0MjAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L0tjb25maWcKPiBAQCAtMSw0ICsxLDQgQEAKPiAtIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vbmx5Cj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVAo+ICAgY29uZmln
IERSTV9BTURHUFVfU0kKPiAgIAlib29sICJFbmFibGUgYW1kZ3B1IHN1cHBvcnQgZm9yIFNJIHBh
cnRzIgo+ICAgCWRlcGVuZHMgb24gRFJNX0FNREdQVQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2Nv
bmZpZwo+IGluZGV4IGJhMGU2ODA1N2E4OS4uYjM2NzJkMTBlYTU0IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9LY29uZmlnCj4gQEAgLTEsNCArMSw0IEBACj4gLSMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb25seQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQK
PiAgICMKPiAgICMgSGV0ZXJvZ2Vub3VzIHN5c3RlbSBhcmNoaXRlY3R1cmUgY29uZmlndXJhdGlv
bgo+ICAgIwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvS2NvbmZp
ZyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9LY29uZmlnCj4gaW5kZXggMmEyZjYyMWMw
ZDZjLi44Nzg1OGJjNTdlNjQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L0tjb25maWcKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvS2NvbmZpZwo+
IEBAIC0xLDQgKzEsNCBAQAo+IC0jIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9u
bHkKPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUCj4gICBtZW51ICJEaXNwbGF5IEVu
Z2luZSBDb25maWd1cmF0aW9uIgo+ICAgCWRlcGVuZHMgb24gRFJNICYmIERSTV9BTURHUFUKPiAg
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvTWFr
ZWZpbGUgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvTWFrZWZpbGUKPiBp
bmRleCAyZWViMDM4MTgwNzIuLjVmY2FmNzgzMzRmZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvTWFrZWZpbGUKPiBAQCAtMSwzICsxLDQgQEAKPiArIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUCj4gICAjCj4gICAjIE1ha2VmaWxlIGZvciBEQ04u
Cj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIx
L01ha2VmaWxlIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL01ha2VmaWxl
Cj4gaW5kZXggYjM2ODg5MDBkMjExLi4wNzY4NGQzZTM3NWEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL01ha2VmaWxlCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIxL01ha2VmaWxlCj4gQEAgLTEsMyArMSw0IEBACj4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVAo+ICAgIwo+ICAgIyBNYWtlZmlsZSBmb3Ig
RENOMjEuCj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RzYy9NYWtlZmlsZSBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kc2MvTWFrZWZp
bGUKPiBpbmRleCA3NDE1YjhiZjYzMTguLjNmNjY4NjhkZjE3MSAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZHNjL01ha2VmaWxlCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RzYy9NYWtlZmlsZQo+IEBAIC0xLDMgKzEsNCBAQAo+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBNSVQKPiAgICMKPiAgICMgTWFrZWZpbGUgZm9yIHRo
ZSAnZHNjJyBzdWItY29tcG9uZW50IG9mIERBTC4KPiAgIAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
