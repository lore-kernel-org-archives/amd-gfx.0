Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83EDC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 11:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5482067C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 11:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRkWhfe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5482067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEB8893D5;
	Tue, 18 Aug 2020 11:02:34 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460C9893D5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 11:02:33 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id p20so17856690wrf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 04:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=n45bNhp+FPDeaG+yD3qptmxnSuIfB6EWWmn9ppGkTkE=;
 b=XRkWhfe8nxjNFmNMozZHk0GCVwhN4h7a96P8BYx4myRUcLTS5lpxOIFLfwvaQmLnkz
 L3K0A/5vBV0TM+NmTQN0tDh2rSSGJm/1bw4RdQPAEZhA3hnHBEwHE1DshRf168Ay4KXA
 TgonbqklqvD/ZMc/AB8Kr0aSP+DeSnvahcrRQHt+woWWpNF6dizr4ktrsPrtBjoXwdBp
 zkgkmzJ5I+lKoqAHGeXyiLQKEu2AzQjZlMMJfoxIdh/3sWQ5HBIhtmjV1a18UWA2tKFO
 JP7CI/EFNgNHcDbrBsDcFuqE3crgy9kiDnHZOH4jUP1fm15JGimVPv/cv9ojS8OTNkwo
 GfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=n45bNhp+FPDeaG+yD3qptmxnSuIfB6EWWmn9ppGkTkE=;
 b=VMbN0Z6YYBexvS2fkPtMomeRRY6TlKsEtpi//4LaIjD66OW2e+g3gOMXP8tpvRP5zL
 7xtqQzCJFVlqXkJKc86UDMuCIBiNZPGp1Pc1Gv0AJ+opLxjiFz8pi+lTfzxaFq0+NwwQ
 nGMtCxcuQyemFr41Lhy4VelbcS+lKOvmaizNJHS8AJnD2NSHtMxQXNiGZ/diD5a3R8kW
 Ok4g/fNHaLghgwtciC3cfpquELll/1EHANGNEoLW05TIPHBPjrHJvNMKvdfL7y2vTEye
 fdG7pm7OrW1BItpEkk+8TpEcUnnpRIyw4G2a+RuLUZj8qz4f+N93v8c+eXoouioT+c3x
 IbZg==
X-Gm-Message-State: AOAM533fLO9kQR+hnHtR8V0kcbTbqNH+dKBz6FMFHidssR+nzyV6tH62
 B12RUWJlHnlNgx2ARwNbBDU=
X-Google-Smtp-Source: ABdhPJwJjnM+rikjYf/9AMZ8fqKItLtmLtKFfafOCrG4rl/bTB19Ra7u+PtltlORSGQBiMy6lrhnIw==
X-Received: by 2002:adf:c983:: with SMTP id f3mr19429457wrh.348.1597748551888; 
 Tue, 18 Aug 2020 04:02:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o3sm34192555wru.64.2020.08.18.04.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 04:02:31 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix amdgpu_bo_release_notify() comment error
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200817073535.699-1-kevin1.wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6a915eec-e4a2-a010-9c4c-d409c3c7ae9b@gmail.com>
Date: Tue, 18 Aug 2020 13:02:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817073535.699-1-kevin1.wang@amd.com>
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
Cc: Felix.Kuehling@amd.com, Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTcuMDguMjAgdW0gMDk6MzUgc2NocmllYiBLZXZpbiBXYW5nOgo+IGZpeCBhbWRncHVfYm9f
cmVsZWFzZV9ub3RpZnkoKSBjb21tZW50IGVycm9yLgo+Cj4gU2lnbmVkLW9mZi1ieTogS2V2aW4g
V2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X29iamVjdC5jCj4gaW5kZXggM2Q5NWIzZWRiNjM1Li40Y2I3NTBlZDY4NTEgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTEzMDEs
NyArMTMwMSw3IEBAIHZvaWQgYW1kZ3B1X2JvX21vdmVfbm90aWZ5KHN0cnVjdCB0dG1fYnVmZmVy
X29iamVjdCAqYm8sCj4gICB9Cj4gICAKPiAgIC8qKgo+IC0gKiBhbWRncHVfYm9fbW92ZV9ub3Rp
ZnkgLSBub3RpZmljYXRpb24gYWJvdXQgYSBCTyBiZWluZyByZWxlYXNlZAo+ICsgKiBhbWRncHVf
Ym9fcmVsZWFzZV9ub3RpZnkgLSBub3RpZmljYXRpb24gYWJvdXQgYSBCTyBiZWluZyByZWxlYXNl
ZAo+ICAgICogQGJvOiBwb2ludGVyIHRvIGEgYnVmZmVyIG9iamVjdAo+ICAgICoKPiAgICAqIFdp
cGVzIFZSQU0gYnVmZmVycyB3aG9zZSBjb250ZW50cyBzaG91bGQgbm90IGJlIGxlYWtlZCBiZWZv
cmUgdGhlCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
