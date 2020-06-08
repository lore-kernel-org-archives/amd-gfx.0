Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2D3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AA52068D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnI9iW+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AA52068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785DB89DB7;
	Mon,  8 Jun 2020 19:42:44 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B59A89DB7
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 19:42:43 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id m21so14412233eds.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2020 12:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6TtIH0/X69SKy3Ns4420RcaiFgcNnfdCaNNLMnzeCjs=;
 b=gnI9iW+92rYA2WN2lIWCCQJrNKF0YJQJOm9/dqkuca+VObc5Rrk93RtVuNDsN+UvvF
 d11x36FwwEXJvB9Cx3Xg88rzcmLVkZVJcbfcVfUCBcvwOG3yub44wCUnS1Y3kQJUrwCc
 zK/hHKwrhz7PLlduybsMVQhuN/SyVLlygKTIlPYCaLtgxyUhXD3D0vhcqKUo6waTl6WR
 8wZ67OUZ+CazJHLc77ouG3b4flgUnGQR3NdHxnscRcJDJdLH1xgAr809MF8G4M8CYqCI
 Lh0LRMCFEy0I5ePxv3uIDbF4KcOEGPKNaezM0cCHGrpV6l6o3vVooeK5WYH39Sa8YwBf
 vWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=6TtIH0/X69SKy3Ns4420RcaiFgcNnfdCaNNLMnzeCjs=;
 b=RulG/gFMNkJ8qJMiwdgqLJIT3BUl0MoQ4Hd4SdOLwmq0VOElO6DstLAG+AoKPJBDlL
 BKXY/1lpZLW5LGOGTORf0US1xVAAK7iYVH+H/x9pykEzgwDpGZSAS6wvFdAiUT4/taP1
 hbGGvp53E3dI/cPRUecygkCsDxTUQuat7YrNfUrfAXRHAcla8updZcXsF2G8RpGHA9AA
 KIFrzX5e0LoWfhYruWZBqU8fy/FrRw6daGEp52ESn06xAy96sK3MUOkdlv1dU0lNokck
 NV7fOANuHfkox8dlRczypLb4ht6aTTx0it03SEIBcobyegRy7kOoRq3X5bM86t2h4Pmc
 OHUg==
X-Gm-Message-State: AOAM530Nh5KVgzE9LOFWSDG6BzLSI0hv1+PenyiRmmGPq6XcsMP5avJw
 TV4sr/95uIGwp6TNqMfvKKk=
X-Google-Smtp-Source: ABdhPJzR3okYez62vd4XTHyOehErtFtf72yTxWH0kVMl/35dz4S46Gt+bHm7BcRdnm/Sjvzj3pNhhQ==
X-Received: by 2002:a05:6402:1597:: with SMTP id
 c23mr12756013edv.372.1591645362256; 
 Mon, 08 Jun 2020 12:42:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s13sm12031313ejv.29.2020.06.08.12.42.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Jun 2020 12:42:41 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: skip BAR resizing if the bios already did it
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200608194109.224589-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <165599c6-750a-b6cc-5995-112564a4ba29@gmail.com>
Date: Mon, 8 Jun 2020 21:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200608194109.224589-1-alexander.deucher@amd.com>
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

QW0gMDguMDYuMjAgdW0gMjE6NDEgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gTm8gbmVlZCB0byBk
byBpdCBhZ2Fpbi4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgNSArKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZp
Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4
IDFkZjI4YjdiZjIyZS4uNTM5MDEwNzk4MTE2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IEBAIC05MDksNiArOTA5LDExIEBAIGludCBhbWRncHVf
ZGV2aWNlX3Jlc2l6ZV9mYl9iYXIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJaWYg
KGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKPiAgIAkJcmV0dXJuIDA7Cj4gICAKPiArCS8qIHNraXAg
aWYgdGhlIGJpb3MgaGFzIGFscmVhZHkgZW5hYmxlZCBsYXJnZSBCQVIgKi8KPiArCWlmIChhZGV2
LT5nbWMucmVhbF92cmFtX3NpemUgJiYKPiArCSAgICAocGNpX3Jlc291cmNlX2xlbihhZGV2LT5w
ZGV2LCAwKSA+PSBhZGV2LT5nbWMucmVhbF92cmFtX3NpemUpKQo+ICsJCXJldHVybiAwOwo+ICsK
PiAgIAkvKiBDaGVjayBpZiB0aGUgcm9vdCBCVVMgaGFzIDY0Yml0IG1lbW9yeSByZXNvdXJjZXMg
Ki8KPiAgIAlyb290ID0gYWRldi0+cGRldi0+YnVzOwo+ICAgCXdoaWxlIChyb290LT5wYXJlbnQp
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
