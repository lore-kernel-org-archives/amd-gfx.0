Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DA3C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 11:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB4CA61405
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 11:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB4CA61405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F055D6E283;
	Fri,  4 Jun 2021 11:11:41 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8A96E138;
 Fri,  4 Jun 2021 11:11:39 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id og14so8594865ejc.5;
 Fri, 04 Jun 2021 04:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=BQUG9rLBagDE3J7LSSE86X2TmT7SF5szEvUlFFOgXJw=;
 b=AKZLZ9RcuNFtFpU2HlORqN+F0aDDdPOWEF0LmofzDUBzJVQxFuF03Iopw5UfbJo6wj
 dCrODKC6J9QggYjr4fn+5Awk3p7KTQYHQBkcLM1VihBqGR1yRXvQVP6e7d/xU54vcYkB
 Kf1up2JPH+87j0n8Tibjo70vosVzALe5dWICqux0nf6Aezw7orz+x73+DWy4ZrWUyOCY
 2vqQRKvQrlthlG6farlgGqrDkOtJxzsyNp/+xeB8Q8yPAIHC0ZxoJzB//UvhLDZvn3ed
 lVZTcZaSQsWE9rpJ6UmFkZlzCo+di9rjRRMIkkDoIPzI7iQevgYFl5uiNOHowCKBgpQg
 Ng7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BQUG9rLBagDE3J7LSSE86X2TmT7SF5szEvUlFFOgXJw=;
 b=YX6bBoIie2SXnHs/tjKrh2S6yZurMXBxzwiUS/9f+L8NIj5ZnJSFvTrUr7SfDvdA0H
 3pfDJYYxHEetxbnJLLUgMICQPmZine/N0NbnlRnzNI+ASFMXgErQKTIdZY1EWKlH8Xwa
 ABTEKHYoKeH5A9goAAHxt0TX0ligxhGaZ1dbVKaqXm1Fk4juwGeo4ty274YdbjjEmRaZ
 q7b0oRYeNl7xPzymbg9W1h/jnl2h9YLBc9+43E+9aNVVnahXykc2roasFUIwjOEz8Xlm
 Rq/UpTgS7hSiMXg9pdzP2XHDCNvo16lBPokhVLNeHPEBtmGu2YMPVQzL43acZRrGo9gL
 POwg==
X-Gm-Message-State: AOAM531GlxMNNs9C0wRgXoisimhHlNNWhTO9W8qfA9bY/i/P/TNGCiSd
 qIkrTHQmWqdUxx/yuXF2izk=
X-Google-Smtp-Source: ABdhPJxwOi2L/qa3p1KrMVaJKXxi1zF8E7uZF06kEzz3kjvluKA7vA7S+LWJ1SpnGlbw7LFo89zKHg==
X-Received: by 2002:a17:906:5f93:: with SMTP id
 a19mr3677884eju.18.1622805098334; 
 Fri, 04 Jun 2021 04:11:38 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581?
 ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
 by smtp.gmail.com with ESMTPSA id dy19sm3062992edb.68.2021.06.04.04.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 04:11:37 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Use vma_lookup() in
 amdgpu_ttm_tt_get_user_pages()
To: Liam Howlett <liam.howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20210603160928.3854180-1-Liam.Howlett@Oracle.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4d2e62c7-af4c-b977-a05c-97b664b532b3@gmail.com>
Date: Fri, 4 Jun 2021 13:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210603160928.3854180-1-Liam.Howlett@Oracle.com>
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
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDYuMjEgdW0gMTg6MDkgc2NocmllYiBMaWFtIEhvd2xldHQ6Cj4gVXNlIHZtYV9sb29r
dXAoKSB0byBmaW5kIHRoZSBWTUEgYXQgYSBzcGVjaWZpYyBhZGRyZXNzLiAgQXMgdm1hX2xvb2t1
cCgpCj4gd2lsbCByZXR1cm4gTlVMTCBpZiB0aGUgYWRkcmVzcyBpcyBub3Qgd2l0aGluIGFueSBW
TUEsIHRoZSBzdGFydCBhZGRyZXNzCj4gbm8gbG9uZ2VyIG5lZWRzIHRvIGJlIHZhbGlkYXRlZC4K
Pgo+IFNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QE9yYWNsZS5j
b20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8
IDQgKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRleCA3Y2I3
ZmZkZDE5MDAuLmRmYjVjYTNmOGRhOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMKPiBAQCAtNjgwLDkgKzY4MCw5IEBAIGludCBhbWRncHVfdHRtX3R0X2dldF91
c2VyX3BhZ2VzKHN0cnVjdCBhbWRncHVfYm8gKmJvLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VzKQo+ICAg
CQlyZXR1cm4gLUVTUkNIOwo+ICAgCj4gICAJbW1hcF9yZWFkX2xvY2sobW0pOwo+IC0Jdm1hID0g
ZmluZF92bWEobW0sIHN0YXJ0KTsKPiArCXZtYSA9IHZtYV9sb29rdXAobW0sIHN0YXJ0KTsKPiAg
IAltbWFwX3JlYWRfdW5sb2NrKG1tKTsKPiAtCWlmICh1bmxpa2VseSghdm1hIHx8IHN0YXJ0IDwg
dm1hLT52bV9zdGFydCkpIHsKPiArCWlmICh1bmxpa2VseSghdm1hKSkgewo+ICAgCQlyID0gLUVG
QVVMVDsKPiAgIAkJZ290byBvdXRfcHV0bW07Cj4gICAJfQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
