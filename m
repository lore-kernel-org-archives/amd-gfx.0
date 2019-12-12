Return-Path: <SRS0=4UhO=2C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A217AC43603
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73538214AF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2019 08:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAETlDuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73538214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32EDB6EC7C;
	Thu, 12 Dec 2019 08:15:19 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEED6EC7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 08:15:17 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id f4so3014357wmj.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2019 00:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=OlqqiWvSB5SY60b1MuXs9E6YKhn+19Um7uaeP3MfSMM=;
 b=mAETlDuCHMbusoSD49FPxCDbD/iCFHbiDzsvrthez7PzZX40BFEMSBqgLnD8qjsg9l
 6/zGSPPMzQzc/4mXtXfHJcSp1omdMixr/HRt+OlYi/2SkmzaRRBxI8NYbu0Qo7gkpKjE
 Sfpz7WnvoEBxvVIHJPPn4grE0Es5TWmil+nUIaKScmU9AuVCn93LI5MYkLA+y/O5mnf5
 dcVqZbBFUZKsrOni226dJE9IZ25bobUpOaUxpsgEhuBYLs8oR7FCSvZ4964LOuvaGvhW
 Nj79rCzkqYOOpCxkH4q9/sakBrCWguQD8SSNmktYiCjWYjZsDx0gtc2gPJlVRf5AiWEB
 fNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=OlqqiWvSB5SY60b1MuXs9E6YKhn+19Um7uaeP3MfSMM=;
 b=NzYbOlT90iWDIlFaGkMwh6mfXK5a98zObW/iHv09UYt79v3n9L2sw15nh2YyTE0rDr
 4z/03WEIXxyJmOeVoHxg/llD6NIp1vrC+pqFGqD2+fXN1LTGGNrx0O+4Bm+PHKB5Tku6
 zFmwNBNYpxuRpNMQmOXeW/ibNwQ18aP+X0QPd7EHQk1hnkyxAYEtfPIpjz60bvR2rZ3J
 f3peb8a77ZyalVm6FEJNBe6baO8cM+atI6sqPVu5ejY3ioZjHg445zK5R0xXehEMAxsY
 iElLFK680xeObzrzzP4r9g4u+PojO8NTgG5sFwDe3R4ohr3Ggz7lgGO5OYXiw4/x/hAJ
 OCRA==
X-Gm-Message-State: APjAAAVIH6WoYyfC66PDyMHCRS5+tfuu2DzuAsjozFr/v2eD+WynX1Gx
 2QICknBCet0Tyon9fevm70F5MDGl
X-Google-Smtp-Source: APXvYqwoT1hQejVF/JYUBXejiacL3o5BtVvUyLChmUOluidL+mQbatP663nXH/gXikl4bwJwMR8lqw==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr5019712wme.77.1576138516244; 
 Thu, 12 Dec 2019 00:15:16 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id m187sm5226667wmm.16.2019.12.12.00.15.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Dec 2019 00:15:15 -0800 (PST)
Subject: Re: [PATCH] Revert "drm/amdgpu: dont schedule jobs while in reset"
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191211164230.2027237-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0824a56a-239c-9165-ea2c-78aa01784049@gmail.com>
Date: Thu, 12 Dec 2019 09:15:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191211164230.2027237-1-alexander.deucher@amd.com>
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

QW0gMTEuMTIuMTkgdW0gMTc6NDIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhpcyByZXZlcnRz
IGNvbW1pdCBmMmVmYzZlNjAwODljOTljMzQyYTZiN2RhNDdmMTAzN2UwNmM0Mjk2Lgo+Cj4gVGhp
cyB3YXMgZml4ZWQgcHJvcGVybHkgZm9yIDUuNSwgYnV0IGNhbWUgYmFjayB2aWEgNS40IG1lcmdl
Cj4gaW50byBkcm0tbmV4dCwgc28gcmV2ZXJ0IGl0IGFnYWluLgo+Cj4gU2lnbmVkLW9mZi1ieTog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENo
cmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCA1ICstLS0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gaW5kZXggMmNkYWYzYjJhNzIxLi42NjE0ZDhhNmY0
YzggMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5j
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2N0eC5jCj4gQEAgLTYw
NCwxMSArNjA0LDggQEAgdm9pZCBhbWRncHVfY3R4X21ncl9lbnRpdHlfZmluaShzdHJ1Y3QgYW1k
Z3B1X2N0eF9tZ3IgKm1ncikKPiAgIAkJCWNvbnRpbnVlOwo+ICAgCQl9Cj4gICAKPiAtCQlmb3Ig
KGkgPSAwOyBpIDwgbnVtX2VudGl0aWVzOyBpKyspIHsKPiAtCQkJbXV0ZXhfbG9jaygmY3R4LT5h
ZGV2LT5sb2NrX3Jlc2V0KTsKPiArCQlmb3IgKGkgPSAwOyBpIDwgbnVtX2VudGl0aWVzOyBpKysp
Cj4gICAJCQlkcm1fc2NoZWRfZW50aXR5X2ZpbmkoJmN0eC0+ZW50aXRpZXNbMF1baV0uZW50aXR5
KTsKPiAtCQkJbXV0ZXhfdW5sb2NrKCZjdHgtPmFkZXYtPmxvY2tfcmVzZXQpOwo+IC0JCX0KPiAg
IAl9Cj4gICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
