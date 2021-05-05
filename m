Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D0C433B4
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 06:35:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E1AC60FD8
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 06:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1AC60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CBB76E42C;
	Wed,  5 May 2021 06:35:17 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 241056E252
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 06:35:15 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id r9so1048795ejj.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 May 2021 23:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=s3wHuNRF4QAKKx7SOwyoyPTcFVE/Q65PgqQxbbUGOt8=;
 b=aYmPvduH1ydRhepSy5N5Od+sSVN+H9wSc642j53EJt/SCynAllbB7uCGFk8PmXK1IH
 FILf8ARwzBD0r1t3E/u5zUUVx1nCogLQTDKY+2cwYo6sRahOxmZUWfK25ZGZp3Xi6r6K
 /V+Sf76nhmOdcS7F7qkp2y0amAb0UAXpdkjXJm6VvDRuAuszmHLI47CBikGE5GULyH6Y
 JCg7zvCEAo3U5AeInyxq5ZH6DveqizH6xoerkTCEeMywNIUWs4sHNb/c59GSA4PJlgaJ
 9CPwPUKEcbWUJOM8aZxp+euiqBUkKoPoTCJBwepG4UfH/imy20dqMEreXiBWOKgxasNI
 wbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=s3wHuNRF4QAKKx7SOwyoyPTcFVE/Q65PgqQxbbUGOt8=;
 b=mrxzVsPY0rVzuyJV1iZUwQXIDTkyTn5pk/whD8WZh93w6kHppbcH4flwjVG7JydqQx
 RhY7c9uhqZYCCbPwgBUIvfqopnAi2XU+Ucbwn7E4Gq4KcoMJyjLb728j7iSUKo9aMS5K
 rlq1Zt+DUMVtjWThDr7OL2MvtQVNO/akAr1tHk0vjGw8hgHXIP71jYO31NyWudMhR17g
 HhtVDUHy2YGpYBJhtAPV0RTQdF9D71OrmRn5W44UzMZNxkowR2Xgwa2T4kMZctuP0pGs
 c25Qv6DBUKvEsY1YMs2XyvUDfdehNiAhO+dnsHWtq/s/70A9kHRyicE+t7Bezzq59fgi
 /adA==
X-Gm-Message-State: AOAM530cCzyfYyM51yvmuMpYqia5pnxMNPsVCbhWycmyojIHYoCZ5a3R
 VIa0MSnJRleMz03zQOyhAsziQP6ZHwA=
X-Google-Smtp-Source: ABdhPJwYgNsiqC8qo7sdRQebV8JZKFOwCDjPaRh0nnQ5i6UU2mAGjLpwb4tbUki3U49SJd/XS92Ckw==
X-Received: by 2002:a17:906:94cd:: with SMTP id
 d13mr25201815ejy.478.1620196514017; 
 Tue, 04 May 2021 23:35:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:53b:b55a:337a:bf10?
 ([2a02:908:1252:fb60:53b:b55a:337a:bf10])
 by smtp.gmail.com with ESMTPSA id e16sm2390467ejr.33.2021.05.04.23.34.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 23:35:12 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: change the default timeout for kernel compute
 queues
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210504150358.1719088-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b2b83b47-2e7b-02ea-0591-daae4dc0d3e6@gmail.com>
Date: Wed, 5 May 2021 08:34:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504150358.1719088-1-alexander.deucher@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDQuMDUuMjEgdW0gMTc6MDMgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gQ2hhbmdlIHRvIDYw
cy4gIFRoaXMgbWF0Y2hlcyB3aGF0IHdlIGFscmVhZHkgZG8gaW4gdmlydHVhbGl6YXRpb24uCj4g
SW5maW5pdGUgdGltZW91dCBjYW4gbGVhZCB0byBkZWFkbG9ja3MgaW4gdGhlIGtlcm5lbC4KPgo+
IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwg
OCArKystLS0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jICAg
IHwgNCArKy0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBp
bmRleCAzNTdmOTQwNWYxYWEuLjFiNjBmODIwNWYxNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPiBAQCAtMzE2Nyw4ICszMTY3LDggQEAgc3RhdGlj
IGludCBhbWRncHVfZGV2aWNlX2dldF9qb2JfdGltZW91dF9zZXR0aW5ncyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldikKPiAgIAlpbnQgcmV0ID0gMDsKPiAgIAo+ICAgCS8qCj4gLQkgKiBCeSBk
ZWZhdWx0IHRpbWVvdXQgZm9yIG5vbiBjb21wdXRlIGpvYnMgaXMgMTAwMDAuCj4gLQkgKiBBbmQg
dGhlcmUgaXMgbm8gdGltZW91dCBlbmZvcmNlZCBvbiBjb21wdXRlIGpvYnMuCj4gKwkgKiBCeSBk
ZWZhdWx0IHRpbWVvdXQgZm9yIG5vbiBjb21wdXRlIGpvYnMgaXMgMTAwMDAKPiArCSAqIGFuZCA2
MDAwMCBmb3IgY29tcHV0ZSBqb2JzLgo+ICAgCSAqIEluIFNSLUlPViBvciBwYXNzdGhyb3VnaCBt
b2RlLCB0aW1lb3V0IGZvciBjb21wdXRlCj4gICAJICogam9icyBhcmUgNjAwMDAgYnkgZGVmYXVs
dC4KPiAgIAkgKi8KPiBAQCAtMzE3NywxMCArMzE3Nyw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Rl
dmljZV9nZXRfam9iX3RpbWVvdXRfc2V0dGluZ3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4gICAJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKPiAgIAkJYWRldi0+Y29tcHV0ZV90aW1l
b3V0ID0gYW1kZ3B1X3NyaW92X2lzX3BwX29uZV92ZihhZGV2KSA/Cj4gICAJCQkJCW1zZWNzX3Rv
X2ppZmZpZXMoNjAwMDApIDogbXNlY3NfdG9famlmZmllcygxMDAwMCk7Cj4gLQllbHNlIGlmIChh
bWRncHVfcGFzc3Rocm91Z2goYWRldikpCj4gLQkJYWRldi0+Y29tcHV0ZV90aW1lb3V0ID0gIG1z
ZWNzX3RvX2ppZmZpZXMoNjAwMDApOwo+ICAgCWVsc2UKPiAtCQlhZGV2LT5jb21wdXRlX3RpbWVv
dXQgPSBNQVhfU0NIRURVTEVfVElNRU9VVDsKPiArCQlhZGV2LT5jb21wdXRlX3RpbWVvdXQgPSAg
bXNlY3NfdG9famlmZmllcyg2MDAwMCk7Cj4gICAKPiAgIAlpZiAoc3RybmxlbihpbnB1dCwgQU1E
R1BVX01BWF9USU1FT1VUX1BBUkFNX0xFTkdUSCkpIHsKPiAgIAkJd2hpbGUgKCh0aW1lb3V0X3Nl
dHRpbmcgPSBzdHJzZXAoJmlucHV0LCAiLCIpKSAmJgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKPiBpbmRleCBhZDhhMmMzOTFiYmQuLmQzZDc1NjU4NWRiNCAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBAQCAtMjg3LDkgKzI4Nyw5
IEBAIG1vZHVsZV9wYXJhbV9uYW1lZChtc2ksIGFtZGdwdV9tc2ksIGludCwgMDQ0NCk7Cj4gICAg
KiAgIGZvciBTRE1BIGFuZCBWaWRlby4KPiAgICAqCj4gICAgKiBCeSBkZWZhdWx0KHdpdGggbm8g
bG9ja3VwX3RpbWVvdXQgc2V0dGluZ3MpLCB0aGUgdGltZW91dCBmb3IgYWxsIG5vbi1jb21wdXRl
KEdGWCwgU0RNQSBhbmQgVmlkZW8pCj4gLSAqIGpvYnMgaXMgMTAwMDAuIEFuZCB0aGVyZSBpcyBu
byB0aW1lb3V0IGVuZm9yY2VkIG9uIGNvbXB1dGUgam9icy4KPiArICogam9icyBpcyAxMDAwMC4g
VGhlIHRpbWVvdXQgZm9yIGNvbXB1dGUgaXMgNjAwMDAuCj4gICAgKi8KPiAtTU9EVUxFX1BBUk1f
REVTQyhsb2NrdXBfdGltZW91dCwgIkdQVSBsb2NrdXAgdGltZW91dCBpbiBtcyAoZGVmYXVsdDog
Zm9yIGJhcmUgbWV0YWwgMTAwMDAgZm9yIG5vbi1jb21wdXRlIGpvYnMgYW5kIGluZmluaXR5IHRp
bWVvdXQgZm9yIGNvbXB1dGUgam9iczsgIgo+ICtNT0RVTEVfUEFSTV9ERVNDKGxvY2t1cF90aW1l
b3V0LCAiR1BVIGxvY2t1cCB0aW1lb3V0IGluIG1zIChkZWZhdWx0OiBmb3IgYmFyZSBtZXRhbCAx
MDAwMCBmb3Igbm9uLWNvbXB1dGUgam9icyBhbmQgNjAwMDAgZm9yIGNvbXB1dGUgam9iczsgIgo+
ICAgCQkiZm9yIHBhc3N0aHJvdWdoIG9yIHNyaW92LCAxMDAwMCBmb3IgYWxsIGpvYnMuIgo+ICAg
CQkiIDA6IGtlZXAgZGVmYXVsdCB2YWx1ZS4gbmVnYXRpdmU6IGluZmluaXR5IHRpbWVvdXQpLCAi
Cj4gICAJCSJmb3JtYXQ6IGZvciBiYXJlIG1ldGFsIFtOb24tQ29tcHV0ZV0gb3IgW0dGWCxDb21w
dXRlLFNETUEsVmlkZW9dOyAiCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
