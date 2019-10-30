Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439B1CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 17:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205E320659
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 17:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205E320659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C051B6E9CD;
	Wed, 30 Oct 2019 17:50:08 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38696E9CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 17:50:07 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id g19so3150812wmh.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 10:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=U/W8X+w91DH6PZFNzMJXepa3c4xobrGDvjIs0EL33UM=;
 b=jFuTpj5oDoXzxq74kvrESnrkMQvfOqjnN5+BWLPRxVVXGtQlfQ8BG+1jJagz6iWUOn
 G05RMs85A/upjc+PyEEu/+yQMwl8GSHeUSUEYTJdbguk12YB6eo8NbxmisNd+HS/Nj4H
 0Jc8XY6fCZe+pfZ3vx1N6QvGQvwHk+srzd7zeqVo69ZBg8HF5UmWrzg9odEYf5o1hZ2I
 3v31jCFt2Wlj6B3OVFq079WX9HjxiIWqabAj3Q3cNo51u6FgnBP3yWgVjk/vaWoLa+xK
 geaCNXXcx/naCkGQYViqUv6/eeZrUY7YVOjE2q/+e5yhb9anG93550CFkKq4rvYyKdA8
 FN8Q==
X-Gm-Message-State: APjAAAX3f68CddyXRHl59WQA077zctZOngakXoH6cxisSDyKpmtlYVpl
 dd41BQG1DBKGQO9dmqjPIU8=
X-Google-Smtp-Source: APXvYqyQcfE3TsbJsgLJNFLOql8OLIAyGOGdGMxXNELdLRLJ1FESgnWWYNQuUV3WZe/hE87DDygshQ==
X-Received: by 2002:a05:600c:2904:: with SMTP id
 i4mr605130wmd.158.1572457806259; 
 Wed, 30 Oct 2019 10:50:06 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d8sm1005325wrr.71.2019.10.30.10.50.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Oct 2019 10:50:05 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/arcturus: properly set BANK_SELECT and
 FRAGMENT_SIZE
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191030173225.243413-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2a08ca4b-948e-9173-6eb7-13d3fd992c43@gmail.com>
Date: Wed, 30 Oct 2019 18:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030173225.243413-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=U/W8X+w91DH6PZFNzMJXepa3c4xobrGDvjIs0EL33UM=;
 b=NQaO8cV8bBfEjsw0jqidGIItVQLyoLXdg3zzRsKNj54Mhxak+spXtw0O8N1tDWO7qm
 JwNSXtXOJLcga8NiK/ooB2UymrZYLsGrVX9Eis0IDAnQdIbBaAhsRVYSBYn4+8NXg/eg
 znmhGzRcNPdXXTOPp+VYPK9xNNQ2k/kxMxUQ6SK7YOBq8QZCniRwkH+6fBSpOAARBoFC
 XkhsBPgR1Q9Z7Md94PamknFKht0IQCjvy1h9FwN408Es/o7IkmJNe9huAUwdwyjTzT4X
 tKnVBON+5diOnlYp+LiNH7grQqnKZ2izOMywOfoNzQOIXZ8KVnqa8qccWxdCSu9wkBrV
 P8aA==
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030175004.61Un0rbNSHNSt69VLVuMLKme5cAHZ9MQTPKk3wgbv88@z>

QW0gMzAuMTAuMTkgdW0gMTg6MzIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhlc2Ugd2VyZSBu
b3QgYWxpZ25lZCBmb3Igb3B0aW1hbCBwZXJmb3JtYW5jZSBmb3IgR1BVVk0uCj4KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21taHViX3Y5XzQuYyB8IDkgKysrKysrKysr
Cj4gICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gaW5kZXggNjU3OTcwZjllYmZiLi4yYzVhZGZlODAzYTIg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4gQEAgLTIxOSw2
ICsyMTksMTUgQEAgc3RhdGljIHZvaWQgbW1odWJfdjlfNF9pbml0X2NhY2hlX3JlZ3Moc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGludCBodWJpZCkKPiAgIAkJCSAgICBodWJpZCAqIE1NSFVC
X0lOU1RBTkNFX1JFR0lTVEVSX09GRlNFVCwgdG1wKTsKPiAgIAo+ICAgCXRtcCA9IG1tVk1MMlBG
MF9WTV9MMl9DTlRMM19ERUZBVUxUOwo+ICsJaWYgKGFkZXYtPmdtYy50cmFuc2xhdGVfZnVydGhl
cikgewo+ICsJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTUwyUEYwX1ZNX0wyX0NOVEwzLCBC
QU5LX1NFTEVDVCwgMTIpOwo+ICsJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTUwyUEYwX1ZN
X0wyX0NOVEwzLAo+ICsJCQkJICAgIEwyX0NBQ0hFX0JJR0tfRlJBR01FTlRfU0laRSwgOSk7Cj4g
Kwl9IGVsc2Ugewo+ICsJCXRtcCA9IFJFR19TRVRfRklFTEQodG1wLCBWTUwyUEYwX1ZNX0wyX0NO
VEwzLCBCQU5LX1NFTEVDVCwgOSk7Cj4gKwkJdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIFZNTDJQ
RjBfVk1fTDJfQ05UTDMsCj4gKwkJCQkgICAgTDJfQ0FDSEVfQklHS19GUkFHTUVOVF9TSVpFLCA2
KTsKPiArCX0KPiAgIAlXUkVHMzJfU09DMTVfT0ZGU0VUKE1NSFVCLCAwLCBtbVZNTDJQRjBfVk1f
TDJfQ05UTDMsCj4gICAJCQkgICAgaHViaWQgKiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RFUl9PRkZT
RVQsIHRtcCk7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
