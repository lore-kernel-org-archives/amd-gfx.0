Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D873AC47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 06:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47E3611B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 06:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47E3611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664D06E817;
	Thu, 10 Jun 2021 06:57:59 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F12F6E817
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 06:57:58 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 m41-20020a05600c3b29b02901b9e5d74f02so2584846wms.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Jun 2021 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=VFNyrT/RNBvEnPhUW1zBo6RSsCwO9RkVpp1YtGGM12g=;
 b=RkgWhj0PzJFaEuEzFkgUc0MSdRKwjUYiFmm6tc3nsTzMIx9l6zYoxSQVZSk4F1RM7S
 b4eN7kNxox//ji8gOYBSGV15hQG+qepdMGrSIskD6r2NsOZ5BwxrLRj2vMMkzk0HnYu8
 gW8dZywEz0CaRbiWXoGNjwRV9rQoKMHEg43opbvdVOd/P5uO6yP3TCzQc6LMYM4dif29
 gw+rwqiwtjtoKDlmfTiWfQcjNIUP4LYLwjUJjMhyCycAAwIrhbMqlpGf0GtCupX6Zw2C
 dhlX5Knh8xFh4/nWR7oqPXE03v8rzYmWkUap3fpZIkBqMcbFIkKTcxCSRzHvH2gYFIuc
 e1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VFNyrT/RNBvEnPhUW1zBo6RSsCwO9RkVpp1YtGGM12g=;
 b=czczsEP3LZcynIWbb+KQC/hscXe+izO/QjhaeyCPw9T72mjtZdrfdld6lhlqAVeUoB
 ayyZU9ZBg+3QFx9sOW1mNVckfQhnIvKxmP3t+eSe9wgiofyfEjc99eClslNasgygaiDJ
 OYhSFoCG5JcSLijdEsMulvqELaaVqQ7WsIizb8S+4ALW/7DEPmyoMMR2it4IyqUHaY9U
 nm04GNkSCp7WKXwnVqjZ/KJjoELwUvtHhJ8X7LPU5aEC3q6n0HNe5td5WJ79JIgM1SFl
 9JX7K7QYqEACNWi6nf/wPkaoY7ldsDa6jKqdWmfTaq65eLq80k6flfySvwdpY41Wj+Hb
 Sfjg==
X-Gm-Message-State: AOAM533vXiJTbO7L+2cT+35xUI47RpH3neo+LsuoUGA5VBjtOju96in4
 ODPSFdPvu3tDGZYwUVTKMAg=
X-Google-Smtp-Source: ABdhPJyLLLTFk88WiYWgDUkMrsL/KP0dScgssKOAbSIY+rP9ZnW0Jh4mpgOaA3HntxzGHcz7wI3Glg==
X-Received: by 2002:a1c:7d15:: with SMTP id y21mr13229840wmc.120.1623308277155; 
 Wed, 09 Jun 2021 23:57:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c285:5f9a:99f5:633e?
 ([2a02:908:1252:fb60:c285:5f9a:99f5:633e])
 by smtp.gmail.com with ESMTPSA id v15sm8191195wmj.39.2021.06.09.23.57.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 23:57:56 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: use adev_to_drm macro for consistency (v2)
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 luben.tuikov@amd.com, felix.kuehling@amd.com
References: <20210610024701.2984-1-guchun.chen@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d9ea7c13-8f27-0406-d0c9-ce41eff24c76@gmail.com>
Date: Thu, 10 Jun 2021 08:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210610024701.2984-1-guchun.chen@amd.com>
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

QW0gMTAuMDYuMjEgdW0gMDQ6NDcgc2NocmllYiBHdWNodW4gQ2hlbjoKPiBVc2UgYWRldl90b19k
cm0oKSB0byBnZXQgdG8gdGhlIGRybV9kZXZpY2UgcG9pbnRlci4KPgo+IFNpZ25lZC1vZmYtYnk6
IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBMdWJlbiBU
dWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyB8IDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyAgICAgICAgICB8IDIgKy0KPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IGluZGV4IDAxNjgxNWI3
YTc3My4uZmI2YmNjMzg2ZGUxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IEBAIC02MzksNyArNjM5LDcgQEAga2ZkX21lbV9h
dHRhY2hfZG1hYnVmKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3Qga2dkX21lbSAq
bWVtLAo+ICAgCQl9Cj4gICAJfQo+ICAgCj4gLQlnb2JqID0gYW1kZ3B1X2dlbV9wcmltZV9pbXBv
cnQoJmFkZXYtPmRkZXYsIG1lbS0+ZG1hYnVmKTsKPiArCWdvYmogPSBhbWRncHVfZ2VtX3ByaW1l
X2ltcG9ydChhZGV2X3RvX2RybShhZGV2KSwgbWVtLT5kbWFidWYpOwo+ICAgCWlmIChJU19FUlIo
Z29iaikpCj4gICAJCXJldHVybiBQVFJfRVJSKGdvYmopOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IGluZGV4IGVjOTM2Y2RlMjcyNi4uYmZiY2I5ZmYyNDUz
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuYwo+IEBAIC0yMTIy
LDcgKzIxMjIsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfcmFzX2NvdW50ZV9kdyhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspCj4gICAJc3RydWN0IGFtZGdwdV9yYXMgKmNvbiA9IGNvbnRhaW5lcl9v
Zih3b3JrLCBzdHJ1Y3QgYW1kZ3B1X3JhcywKPiAgIAkJCQkJICAgICAgcmFzX2NvdW50ZV9kZWxh
eV93b3JrLndvcmspOwo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gY29uLT5hZGV2
Owo+IC0Jc3RydWN0IGRybV9kZXZpY2UgKmRldiA9ICZhZGV2LT5kZGV2Owo+ICsJc3RydWN0IGRy
bV9kZXZpY2UgKmRldiA9IGFkZXZfdG9fZHJtKGFkZXYtPmRkZXYpOwo+ICAgCXVuc2lnbmVkIGxv
bmcgY2VfY291bnQsIHVlX2NvdW50Owo+ICAgCWludCByZXM7Cj4gICAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
