Return-Path: <SRS0=MNBo=HS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCC1C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0ABB64D9F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Feb 2021 14:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ABB64D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E42F6E199;
	Tue, 16 Feb 2021 14:10:56 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 041136E199
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 14:10:55 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id y18so12219448edw.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Feb 2021 06:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Nf1kJBruaDIXePE/JhgvOCpUNRRszgrO77QLCDRRPEY=;
 b=lb3Xk3oQQ56jRUvIuncI0t1hVTcicjCN1WhoIA2vpemfC1CceHBwghvu4FgCiYj8v0
 iodDB1OjXqm7MJGnwJug+5NicTSABXKADvN0Ew0nx9jvfC1T6GAl10VNA6dtyuzHNVEW
 A21zFgLJqtiXqRTdmzAoXsMX2tUQ8cMaR5YvK7ozT7HqojzaVY4c0klLPmNOKt36fnlt
 M80buI0wMakEJJjwkcmJvbz6LfAVOZYyx5bFZQyV+VnWRBjwUMzomLJe3TfCpIsfbWQ7
 VzOpkVV4osXkJhVqv3Pi7cw48cJAZbfnaOOXmpILML+MggdRnLrnWWBV3KLS8sK8ZWer
 Q23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Nf1kJBruaDIXePE/JhgvOCpUNRRszgrO77QLCDRRPEY=;
 b=mk9wwcBTBjPhGOWF0X6DsVEYLfkXWspFgW7VE6teqmo08Nh5UpcW0HOHRfWJM5EI1a
 fErbz0XiW9GtgghJhY4zx3WSrOVjum8E93G9ij/ZdRglLgZ5goKj9CGqbnHpE44jyZ9i
 4N/px4ULihAzMs7bOOki04Lsf9HCE4tOddU2L1CruI+rn66l9mnN7fEX4O87kfqIlhYn
 jhl/usbI8C2eUBRrTjByWLnv1fMLINWpbsLuzzAKMkpxKLzhXzPE3iKXI8Vq3r0s5Zmq
 9x0/GkL6T/9qBtjG9bnkyCosJ8btChxtrFceelT92ak+5aCGgYkQHxvyIzLrMUnOe1NK
 h0lA==
X-Gm-Message-State: AOAM533aWWGG332PVTFOkk7n7due2aiLbGciooypU8vQ3+Usa8Civap8
 CYEre2KJ+n7K16GD2HSSNUQ=
X-Google-Smtp-Source: ABdhPJxmaBCK3JTvqnyywGBFVndk/Yb4lD1mdYKaj3UMMNWU/ZjoA5WwNpFAUQZCqIrc6oDqZPt88g==
X-Received: by 2002:a05:6402:2210:: with SMTP id
 cq16mr20972357edb.148.1613484653822; 
 Tue, 16 Feb 2021 06:10:53 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:47a7:bac2:5556:22a8?
 ([2a02:908:1252:fb60:47a7:bac2:5556:22a8])
 by smtp.gmail.com with ESMTPSA id bw22sm6388921ejb.78.2021.02.16.06.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Feb 2021 06:10:53 -0800 (PST)
Subject: Re: [PATCH] drm/radeon: OLAND boards don't have VCE
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210216140903.1655665-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <05089968-3719-84d7-b277-d0530e725fc1@gmail.com>
Date: Tue, 16 Feb 2021 15:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210216140903.1655665-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMDIuMjEgdW0gMTU6MDkgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gRGlzYWJsZSBpdCBv
biB0aG9zZSBib2FyZHMuICBObyBmdW5jdGlvbmFsIGNoYW5nZSwgdGhpcyBqdXN0Cj4gcmVtb3Zl
cyB0aGUgbWVzc2FnZSBhYm91dCBWQ0UgZmFpbGluZyB0byBpbml0aWFsaXplLgo+Cj4gQnVnOiBo
dHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5NzMyNwo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmll
d2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fYXNpYy5jIHwgMyArKysKPiAgIGRy
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZjZS5jICB8IDEgLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi92Y2VfdjFfMC5jICAgIHwgMSAtCj4gICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9hc2ljLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9h
c2ljLmMKPiBpbmRleCA4YmVjYmUwOWFmMmYuLmJmYWNmOGZlNWNjMSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9hc2ljLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9hc2ljLmMKPiBAQCAtMjQ3OCw2ICsyNDc4LDkgQEAgaW50IHJhZGVv
bl9hc2ljX2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gICAJCWlmIChyZGV2LT5m
YW1pbHkgPT0gQ0hJUF9IQUlOQU4pIHsKPiAgIAkJCXJkZXYtPmhhc191dmQgPSBmYWxzZTsKPiAg
IAkJCXJkZXYtPmhhc192Y2UgPSBmYWxzZTsKPiArCQl9IGVsc2UgaWYgKHJkZXYtPmZhbWlseSA9
PSBDSElQX09MQU5EKSB7Cj4gKwkJCXJkZXYtPmhhc191dmQgPSB0cnVlOwo+ICsJCQlyZGV2LT5o
YXNfdmNlID0gZmFsc2U7Cj4gICAJCX0gZWxzZSB7Cj4gICAJCQlyZGV2LT5oYXNfdXZkID0gdHJ1
ZTsKPiAgIAkJCXJkZXYtPmhhc192Y2UgPSB0cnVlOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL3JhZGVvbl92Y2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X3ZjZS5jCj4gaW5kZXggYTQ1MDQ5NzM2OGIyLi41MTFhOTQyZTg1MWQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdmNlLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl92Y2UuYwo+IEBAIC02OCw3ICs2OCw2IEBAIGludCByYWRlb25fdmNl
X2luaXQoc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCj4gICAJY2FzZSBDSElQX1RBSElUSToK
PiAgIAljYXNlIENISVBfUElUQ0FJUk46Cj4gICAJY2FzZSBDSElQX1ZFUkRFOgo+IC0JY2FzZSBD
SElQX09MQU5EOgo+ICAgCWNhc2UgQ0hJUF9BUlVCQToKPiAgIAkJZndfbmFtZSA9IEZJUk1XQVJF
X1RBSElUSTsKPiAgIAkJYnJlYWs7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRl
b24vdmNlX3YxXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlX3YxXzAuYwo+IGluZGV4
IDcwYzVkYTIxNDFkNy4uYmRmYmNmMTRiODY0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vdmNlX3YxXzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vdmNlX3Yx
XzAuYwo+IEBAIC0xNjksNyArMTY5LDYgQEAgaW50IHZjZV92MV8wX2xvYWRfZncoc3RydWN0IHJh
ZGVvbl9kZXZpY2UgKnJkZXYsIHVpbnQzMl90ICpkYXRhKQo+ICAgCQljaGlwX2lkID0gMHgwMTAw
MDAxNTsKPiAgIAkJYnJlYWs7Cj4gICAJY2FzZSBDSElQX1BJVENBSVJOOgo+IC0JY2FzZSBDSElQ
X09MQU5EOgo+ICAgCQljaGlwX2lkID0gMHgwMTAwMDAxNjsKPiAgIAkJYnJlYWs7Cj4gICAJY2Fz
ZSBDSElQX0FSVUJBOgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
