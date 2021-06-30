Return-Path: <SRS0=pC1i=LY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB458C11F65
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 06:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C9061A1D
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jun 2021 06:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C9061A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C10289CF9;
	Wed, 30 Jun 2021 06:48:51 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF35289CF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jun 2021 06:48:50 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id yy20so2377362ejb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=l0ZZf/KJQH1XukBCZkdMohpCZyHA3bj8IGkEX0H8w0Y=;
 b=TNFp3YNDzp1276/wzpYIjiim06SrUCTC9pjz82m48GzT0tz0xATgTvL8xGw+t265iB
 fnWcS6nDYLDdhYpdH1eRgE6OmuF+nF7UKf/PAAOy4Bnca2tjbZBsAMNFdEyqbwPfH2NE
 Vqo6wlFEjJuoFeZqv7U5y4HekSBVkHlG0qH0jzVObO8/n2JuGMG/PRzJl+n/PdJ3FfOP
 57he5LrM4M7F0J1badknwSaot086pTjKQ9tCM7yhKnW+t4iDCo+C+JISo9i5mce8mPM0
 Ae7zGzhj2VJBQ/43L+Zj66mADY4L8Kaw8vUwiTKFkwadLqI4/XjOffT3TGEyetlk1Que
 T9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=l0ZZf/KJQH1XukBCZkdMohpCZyHA3bj8IGkEX0H8w0Y=;
 b=Tgqd0zhEED+manSFJyle3GtDmutG9GPD4Ijhkoe2owbELNYzbicbDgtbmnLwP+PDXU
 9joBWX9DtuL5kLD34uIuCPavSbWrD+axOePdkL6JIZ35v5Jjwp6Mm8sdll8Y1C3S7Vy1
 DUMPdEWVrlz/1qT+SAtha6VZncMkBFdnTv4OcyB9O7NkwNABFLXWfse6Ib5PL9bpVRfR
 rwhO1I3YbYi8X7v5ctSEUwgFr2SEFmi2J0uZRFbLYwiH40AmLmkDQrZ465Pv1EtjPtLy
 3jUBIbMmdQpUASxuj+ctLYtQF2nQ8V+jtqN9m4Irwxne8rkmMYFlXhe/yGRLsrrR2vhl
 /87g==
X-Gm-Message-State: AOAM532tGAHp9lMvYnNj8D7mZNA/Ff+6Vu6uhZqaYEQ6cF2by9E5WLVh
 +uduo8W5wQ/0bJ0Z+pDkRgZwcpsYq7U=
X-Google-Smtp-Source: ABdhPJysevYuWseX7QfTc6CUpzOQ2TnujzF8hb9hyivLfmcjo4XtfUib7aGkZ9oYGjTZQTtosyAvZQ==
X-Received: by 2002:a17:906:4a96:: with SMTP id
 x22mr33351346eju.20.1625035729406; 
 Tue, 29 Jun 2021 23:48:49 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:fd79:22d7:4c21:2421?
 ([2a02:908:1252:fb60:fd79:22d7:4c21:2421])
 by smtp.gmail.com with ESMTPSA id b25sm12475058edv.9.2021.06.29.23.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jun 2021 23:48:48 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/display: drop unused variable
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210629210228.362806-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b5e5006a-d805-c8a7-8d8d-b71478c94441@gmail.com>
Date: Wed, 30 Jun 2021 08:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629210228.362806-1-alexander.deucher@amd.com>
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

QW0gMjkuMDYuMjEgdW0gMjM6MDIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gUmVtb3ZlIHVudXNl
ZCB2YXJpYWJsZS4KPgo+IEZpeGVzOiAwMDg1ODEzMTIwNWY2OSAoIlJldmVydCAiZHJtL2FtZC9k
aXNwbGF5OiBGaXggb3ZlcmxheSB2YWxpZGF0aW9uIGJ5IGNvbnNpZGVyaW5nIGN1cnNvcnMiIikK
PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1
X2RtLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9h
bWRncHVfZG0uYwo+IGluZGV4IGYxNGI1NDY4YjdlZS4uZTAzNDAxN2RhYTFhIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4g
QEAgLTEwMjIxLDcgKzEwMjIxLDcgQEAgc3RhdGljIGludCB2YWxpZGF0ZV9vdmVybGF5KHN0cnVj
dCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkKPiAgIHsKPiAgIAlpbnQgaTsKPiAgIAlzdHJ1Y3Qg
ZHJtX3BsYW5lICpwbGFuZTsKPiAtCXN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKm9sZF9wbGFuZV9z
dGF0ZSwgKm5ld19wbGFuZV9zdGF0ZTsKPiArCXN0cnVjdCBkcm1fcGxhbmVfc3RhdGUgKm5ld19w
bGFuZV9zdGF0ZTsKPiAgIAlzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpwcmltYXJ5X3N0YXRlLCAq
b3ZlcmxheV9zdGF0ZSA9IE5VTEw7Cj4gICAKPiAgIAkvKiBDaGVjayBpZiBwcmltYXJ5IHBsYW5l
IGlzIGNvbnRhaW5lZCBpbnNpZGUgb3ZlcmxheSAqLwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
