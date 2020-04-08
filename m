Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF4CC2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:32:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BEAC2074F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/l5CkMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEAC2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EA46EA61;
	Wed,  8 Apr 2020 13:32:34 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D8486EA5C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 13:32:33 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id c15so7801101wro.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2020 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=obigGlvTyUe1q7+SB0wkjlasQoRXKALEAWSS3N6kci0=;
 b=k/l5CkMWeFrSfqV4e0Eta8RfvO8NNpN4I0ZQFO7pHhJ2J2HQW+abI5pZhK1hquqO7k
 m8MA8NC1WHIvfl9cR/q1I/35FKqnFP3PMJQn9S4Q/SMDebr+Rx4DuX9AuQpo6hZ9bLlq
 eEON5JPAAT1cjplR3UOp4gad3ncG3O1pPn4vR9mnl/jQLKxad+uZ+NEwrgAWrlph2xGy
 KuMFwa3CCsiBR72vHXfWJm5i1fluaSpx2qhVY5EjEEXEDSmpcxmqLupNXlfp1maD7X0L
 PrIigOe+O6Pixcjx6/a6Wxhnh/WQC1wkTDDWhmJ8iTy4CVzyKelOyX3N3wp52kLz4EUU
 8EaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=obigGlvTyUe1q7+SB0wkjlasQoRXKALEAWSS3N6kci0=;
 b=FtpvbxaYqxedMC01+WCDqx0ILD85yxpVqiLypEv5priglD4hQ98RgbpGpTjbCpsDyK
 k5ThNUhKKMC+Z5Zrb+IiBgRacS1ttvPzgulqWdJ/9U1qAfDh6ZsXy1P/VlUpuVMnA4/A
 1vIQV5ixuqv5mTyvpM88zcwUm7hGeFZA4NSU5mSs173QZtTjNXP1ilmsCWx3Tm3+1sFY
 8ca+0ZN+VYbeeyU9wc9KB5uwApdTscq6nXyNnDavTO/JPcplw3HlTrx30F1oeH/W1HIs
 4dEEL8xmmUxfdZ1dZW0qnjvVp1Ad+VtjWI7FkvcVQkNkXMjyA1/psQRwK3DtBlc+8NZo
 wXuw==
X-Gm-Message-State: AGi0PuaFYNeiw9jPjttuK3+smytE4VK5GUzqMlkqEMLJdNhi79rigddH
 gof652/KTogHvPaU+uIyTQE=
X-Google-Smtp-Source: APiQypKQwXm9WkkLVtTYaQ9e9MCYBzSFeJiRSKL6DUHbw0MtYGh14LZPnhUbn075pNflSitSq/QZMw==
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr8270833wrr.215.1586352751872; 
 Wed, 08 Apr 2020 06:32:31 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u7sm7520436wmg.41.2020.04.08.06.32.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Apr 2020 06:32:31 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/display: fix warning when compiling without
 debugfs
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200408133105.1743707-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4028718d-4549-d2e9-d0a9-8e49bcdbcac3@gmail.com>
Date: Wed, 8 Apr 2020 15:32:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200408133105.1743707-1-alexander.deucher@amd.com>
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

QW0gMDguMDQuMjAgdW0gMTU6MzEgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gZml4ZXMgdW51c2Vk
IHZhcmlhYmxlIHdhcm5pbmcuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IDExNTVmYjY4NmUzNi4uNDE3OTI1
YTBkNzM5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTQ3MzgsMTAgKzQ3MzgsMTAgQEAgYW1kZ3B1X2RtX2Nvbm5l
Y3Rvcl9hdG9taWNfZHVwbGljYXRlX3N0YXRlKHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0
b3IpCj4gICBzdGF0aWMgaW50Cj4gICBhbWRncHVfZG1fY29ubmVjdG9yX2xhdGVfcmVnaXN0ZXIo
c3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcikKPiAgIHsKPiArI2lmIGRlZmluZWQoQ09O
RklHX0RFQlVHX0ZTKQo+ICAgCXN0cnVjdCBhbWRncHVfZG1fY29ubmVjdG9yICphbWRncHVfZG1f
Y29ubmVjdG9yID0KPiAgIAkJdG9fYW1kZ3B1X2RtX2Nvbm5lY3Rvcihjb25uZWN0b3IpOwo+ICAg
Cj4gLSNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykKPiAgIAljb25uZWN0b3JfZGVidWdmc19p
bml0KGFtZGdwdV9kbV9jb25uZWN0b3IpOwo+ICAgI2VuZGlmCj4gICAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
