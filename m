Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9203DC33C99
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C0E2077B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 08:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOc06SYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C0E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1483089842;
	Tue,  7 Jan 2020 08:02:17 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F56589842
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 08:02:15 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id t14so18223999wmi.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=0IEj0M/pNKXmjC/B1OP3Lc4TjTOlSkx18x1JB3DXBrA=;
 b=OOc06SYrYjfhcEEXw7EzM6+KRtWnLUtqUeef2hLyGS732jYD+VQkJNee8cQemTDKDy
 tvSDmvxh0GOclCNL0GDGdM5+c2DTY5mmLZgY4aWMWmvjk8T3F6ki3NIuqPr4BJ75Yh5S
 sreLn5AMqwrlmoMTqaEc1PFo1/csnG1gcklgzFJp/FkQOLC9TVq/2Ub55ykK0rHRkuIn
 belHFed/7/9xP0qia4xUNHagI1uJHjQYHqpdDRMIV/4jYw1IinQwWmdctP5mTThvIaBQ
 OQ8DqZVf7d+51z6fmjo6VUhIlItgN3JR7xgd1YrsenhCjh8xkYL4Hte8lgfr5BPWsA9o
 FcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=0IEj0M/pNKXmjC/B1OP3Lc4TjTOlSkx18x1JB3DXBrA=;
 b=KMFA92PCC8yyghRAscrXB3NfOMdaqTbO1sy4FVvYPs3ad9l+xmuF/3pXMfoTnkNKp/
 ed0PJVj3fodj7vt1nznwJBH4Ih9hrQKC0DHT32uvXvwb1QNjnZAf4ggYg94Cx9BWKXF2
 f1oguauxm8JZGg2f8gDvp+fC+PhI/7c4OwT5YximU9k6cENQcuUWCz2K5iiv3317tNQ6
 kmRg60rlT6H9ylz+rQ0o/MqZ49Vwsa1UH7uRwvt0MWu5gCc0PPtjom+/KvBrKP74agja
 9yrYRAWSCOsJfueh/yPmEHoX22LsaTkuWHM85V8g2MaGkEHTfsbUe6c2u8kEoHRXxjUq
 Go5Q==
X-Gm-Message-State: APjAAAUT01zDiQUv6guu7Ob/elc0vPDGxIgdUu00OaI81HDt70z28wN5
 00Kg1zsf6/jElbuS20QmjYgXcunb
X-Google-Smtp-Source: APXvYqwkWRMj+mPSBgYLdYx3+8XylskUT/UcAWWqwVP+ayyczivIHxGgLIg5D+Gg46m1QBrgWACfJw==
X-Received: by 2002:a05:600c:20c7:: with SMTP id
 y7mr39902750wmm.21.1578384134142; 
 Tue, 07 Jan 2020 00:02:14 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v14sm74426156wrm.28.2020.01.07.00.02.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 00:02:13 -0800 (PST)
Subject: Re: [PATCH] Revert "drm/amdgpu: Set no-retry as default."
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200106204553.917237-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <5aee19ea-9798-634d-1c41-04e98397c994@gmail.com>
Date: Tue, 7 Jan 2020 09:02:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106204553.917237-1-alexander.deucher@amd.com>
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

QW0gMDYuMDEuMjAgdW0gMjE6NDUgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhpcyByZXZlcnRz
IGNvbW1pdCA1MWJmYWM3MWNhZGUzODY5NjY3OTFhOGRiODdhNTkxMjc4MWQyNDlmLgo+Cj4gVGhp
cyBjYXVzZXMgc3RhYmlsaXR5IGlzc3VlcyBvbiBzb21lIHJhdmVuIGJvYXJkcy4gIFJldmVydAo+
IGZvciBub3cgdW50aWwgYSBwcm9wZXIgZml4IGlzIGNvbXBsZXRlZC4KPgo+IEJ1ZzogaHR0cHM6
Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvaXNzdWVzLzkzNAo+IEJ1ZzogaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMDYwMTcKPiBTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyB8IDQgKystLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBpbmRleCAwZmZjOTQ0N2I1NzMuLjMwMzZl
Yzg4M2ZiNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBA
QCAtMTQyLDcgKzE0Miw3IEBAIGludCBhbWRncHVfYXN5bmNfZ2Z4X3JpbmcgPSAxOwo+ICAgaW50
IGFtZGdwdV9tY2JwID0gMDsKPiAgIGludCBhbWRncHVfZGlzY292ZXJ5ID0gLTE7Cj4gICBpbnQg
YW1kZ3B1X21lcyA9IDA7Cj4gLWludCBhbWRncHVfbm9yZXRyeSA9IDE7Cj4gK2ludCBhbWRncHVf
bm9yZXRyeTsKPiAgIGludCBhbWRncHVfZm9yY2VfYXNpY190eXBlID0gLTE7Cj4gICAKPiAgIHN0
cnVjdCBhbWRncHVfbWdwdV9pbmZvIG1ncHVfaW5mbyA9IHsKPiBAQCAtNTg4LDcgKzU4OCw3IEBA
IE1PRFVMRV9QQVJNX0RFU0MobWVzLAo+ICAgbW9kdWxlX3BhcmFtX25hbWVkKG1lcywgYW1kZ3B1
X21lcywgaW50LCAwNDQ0KTsKPiAgIAo+ICAgTU9EVUxFX1BBUk1fREVTQyhub3JldHJ5LAo+IC0J
IkRpc2FibGUgcmV0cnkgZmF1bHRzICgwID0gcmV0cnkgZW5hYmxlZCwgMSA9IHJldHJ5IGRpc2Fi
bGVkIChkZWZhdWx0KSkiKTsKPiArCSJEaXNhYmxlIHJldHJ5IGZhdWx0cyAoMCA9IHJldHJ5IGVu
YWJsZWQgKGRlZmF1bHQpLCAxID0gcmV0cnkgZGlzYWJsZWQpIik7Cj4gICBtb2R1bGVfcGFyYW1f
bmFtZWQobm9yZXRyeSwgYW1kZ3B1X25vcmV0cnksIGludCwgMDY0NCk7Cj4gICAKPiAgIC8qKgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
