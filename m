Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBCBC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5662A6191F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 13:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5662A6191F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8943B6E466;
	Mon, 22 Mar 2021 13:23:35 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08DC489842
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 09:42:43 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id o19so18450454edc.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=mWDx6LGWqKmTugVQB+RZhSRPV/9NQuf3t6ukSDfHbtM=;
 b=zLnQN1BKcjyZe65XOT4yrBFqQ5ULN5KR0Fl/MBpKUiI3GgeUbnT9t9aR0Xr+ru0Tgq
 0CwWh78q0moLORc+GxWBLP14ANCs0Mdcekz7SS4LPx4wmX2AlcWYWEN8Tyjnqp5WiHXQ
 /uLAXQ0+MDFh2pTHbz/xVwoRUeWRlZaG8MXoQ/p0bmE2NlqfA8ylNR3dHNcD5uA+yMcZ
 c+701ybyd42mIT3LI2ddd1wUybb1G+L+n6t3wfEDlc9EtRio8eCgx0yJH6O0hFAbP5wb
 n2aQX0VaSkqwJa2VlCy5vmtseH2sDfB4RGzrUSkipnZ8b/aFURUo7K5Awbi21/l9JuOL
 p4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mWDx6LGWqKmTugVQB+RZhSRPV/9NQuf3t6ukSDfHbtM=;
 b=ryClKF2wK8I7MOuGllre04b8jkqawlRAO0A7YlfG0IagT8RbfZ9H6tj4uxuJqJmu0a
 kC+haZde9ZaNA0osSNJ0vB/JwjjcxgaPvvobrraXPCWeU8dSNVqXihnvylyx6wzxFW6F
 jnuxDMUOxSbbXeXrTTq5sqULM+IICLrSZXNZfwWfkvUpBXlm4GTUcqDs6fuU0MUTUFpY
 bSFY9sDAcCG4n180LZ6bY6yr7yb6EZOmMIOcsgxuS4iUdxijiss64b5zM1uoHD9gqHyG
 pU9KWoYSZyH7NvShcm/Wt3VpDUhNKTNPiT2fPLEeCECKsVgMshfFrHdddFltm/r6qOVn
 oG2Q==
X-Gm-Message-State: AOAM533SEAbTcVijhRvrDC6B9MvC86WDlZpSwEzHBHPvgnxNg9/T/nbM
 RpaKzZNt5oTLdXNE1GcgHkQ9sg==
X-Google-Smtp-Source: ABdhPJy3z3Z8+l0pNFhQ/mQfjrlh1KC2Nmei6U2tEPgAdqEA579zIx9f0Uo1WfoXP7O8PR2sfia7/A==
X-Received: by 2002:a05:6402:50c8:: with SMTP id
 h8mr24198283edb.360.1616406161640; 
 Mon, 22 Mar 2021 02:42:41 -0700 (PDT)
Received: from dell ([91.110.221.180])
 by smtp.gmail.com with ESMTPSA id s20sm11021804edu.93.2021.03.22.02.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 02:42:41 -0700 (PDT)
Date: Mon, 22 Mar 2021 09:42:39 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Guchun Chen <guchun.chen@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix modprobe failure on vega series
Message-ID: <20210322094239.GN2916463@dell>
References: <20210322084230.24043-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210322084230.24043-1-guchun.chen@amd.com>
X-Mailman-Approved-At: Mon, 22 Mar 2021 13:23:34 +0000
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAyMiBNYXIgMjAyMSwgR3VjaHVuIENoZW4gd3JvdGU6Cgo+IEZpeGVzOiBkODhiMzRj
YWVlODMgKCJSZW1vdmUgc29tZSBsYXJnZSB2YXJpYWJsZXMgZnJvbSB0aGUgc3RhY2siKQo+IAo+
IFsgICA0MS4yMzIwOTddIENhbGwgVHJhY2U6Cj4gWyAgIDQxLjIzMjEwNV0gIGt2YXNwcmludGYr
MHg2Ni8weGQwCj4gWyAgIDQxLjIzMjEyMl0gIGthc3ByaW50ZisweDQ5LzB4NzAKPiBbICAgNDEu
MjMyMTM2XSAgX19kcm1fY3J0Y19pbml0X3dpdGhfcGxhbmVzKzB4MmUxLzB4MzQwIFtkcm1dCj4g
WyAgIDQxLjIzMjIxOV0gID8gY3JlYXRlX29iamVjdCsweDI2My8weDNiMAo+IFsgICA0MS4yMzIy
MzFdICBkcm1fY3J0Y19pbml0X3dpdGhfcGxhbmVzKzB4NDYvMHg2MCBbZHJtXQo+IFsgICA0MS4y
MzIzMDNdICBhbWRncHVfZG1faW5pdCsweDY5Yy8weDE3NTAgW2FtZGdwdV0KPiBbICAgNDEuMjMy
OTk4XSAgPyBwaG1fd2FpdF9mb3JfcmVnaXN0ZXJfdW5lcXVhbC5wYXJ0LjErMHg1OC8weDkwIFth
bWRncHVdCj4gWyAgIDQxLjIzMzY2Ml0gID8gc211OV93YWl0X2Zvcl9yZXNwb25zZSsweDdkLzB4
YTAgW2FtZGdwdV0KPiBbICAgNDEuMjM0Mjk0XSAgPyBzbXU5X3NlbmRfbXNnX3RvX3NtY193aXRo
X3BhcmFtZXRlcisweDc3LzB4ZDAgW2FtZGdwdV0KPiBbICAgNDEuMjM0OTEyXSAgPyBzbXVtX3Nl
bmRfbXNnX3RvX3NtY193aXRoX3BhcmFtZXRlcisweDk2LzB4MTAwIFthbWRncHVdCj4gWyAgIDQx
LjIzNTUyMF0gID8gcHNtX3NldF9zdGF0ZXMrMHg1Yy8weDYwIFthbWRncHVdCj4gWyAgIDQxLjIz
NjE2NV0gIGRtX2h3X2luaXQrMHgxMi8weDIwIFthbWRncHVdCj4gWyAgIDQxLjIzNjgzNF0gIGFt
ZGdwdV9kZXZpY2VfaW5pdCsweDE0MDIvMHgxZGYwIFthbWRncHVdCj4gWyAgIDQxLjIzNzMxNF0g
IGFtZGdwdV9kcml2ZXJfbG9hZF9rbXMrMHg2NS8weDMyMCBbYW1kZ3B1XQo+IFsgICA0MS4yMzc3
ODBdICBhbWRncHVfcGNpX3Byb2JlKzB4MTUwLzB4MjUwIFthbWRncHVdCj4gWyAgIDQxLjIzODI0
MF0gIGxvY2FsX3BjaV9wcm9iZSsweDQ3LzB4YTAKPiBbICAgNDEuMjM4MjUzXSAgcGNpX2Rldmlj
ZV9wcm9iZSsweDEwYi8weDFjMAo+IFsgICA0MS4yMzgyNjVdICByZWFsbHlfcHJvYmUrMHhmNS8w
eDRjMAo+IFsgICA0MS4yMzgyNzVdICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4ZTgvMHgxNTAKPiBb
ICAgNDEuMjM4Mjg0XSAgZGV2aWNlX2RyaXZlcl9hdHRhY2grMHg1OC8weDYwCj4gWyAgIDQxLjIz
ODI5M10gIF9fZHJpdmVyX2F0dGFjaCsweGEzLzB4MTQwCj4gWyAgIDQxLjIzODMwMV0gID8gZGV2
aWNlX2RyaXZlcl9hdHRhY2grMHg2MC8weDYwCj4gWyAgIDQxLjIzODMwOV0gID8gZGV2aWNlX2Ry
aXZlcl9hdHRhY2grMHg2MC8weDYwCj4gWyAgIDQxLjIzODMxN10gIGJ1c19mb3JfZWFjaF9kZXYr
MHg3NC8weGIwCj4gWyAgIDQxLjIzODMzMF0gID8ga21lbV9jYWNoZV9hbGxvY190cmFjZSsweDMx
YS8weDQ3MAo+IFsgICA0MS4yMzgzNDFdICBkcml2ZXJfYXR0YWNoKzB4MWUvMHgyMAo+IFsgICA0
MS4yMzgzNDhdICBidXNfYWRkX2RyaXZlcisweDE0YS8weDIyMAo+IFsgICA0MS4yMzgzNTddICA/
IDB4ZmZmZmZmZmZjMGYwOTAwMAo+IFsgICA0MS4yMzgzNjRdICBkcml2ZXJfcmVnaXN0ZXIrMHg2
MC8weDEwMAo+IFsgICA0MS4yMzgzNzNdICA/IDB4ZmZmZmZmZmZjMGYwOTAwMAo+IFsgICA0MS4y
MzgzNzldICBfX3BjaV9yZWdpc3Rlcl9kcml2ZXIrMHg1NC8weDYwCj4gWyAgIDQxLjIzODM4OV0g
IGFtZGdwdV9pbml0KzB4NjgvMHgxMDAwIFthbWRncHVdCj4gWyAgIDQxLjIzODgzNl0gIGRvX29u
ZV9pbml0Y2FsbCsweDQ4LzB4MWUwCj4gWyAgIDQxLjIzODg1MF0gID8ga21lbV9jYWNoZV9hbGxv
Y190cmFjZSsweDMxYS8weDQ3MAo+IFsgICA0MS4yMzg4NjJdICBkb19pbml0X21vZHVsZSsweDVm
LzB4MjI0Cj4gWyAgIDQxLjIzODg3Nl0gIGxvYWRfbW9kdWxlKzB4MjY2Yi8weDJlYzAKPiBbICAg
NDEuMjM4ODg3XSAgPyBzZWN1cml0eV9rZXJuZWxfcG9zdF9yZWFkX2ZpbGUrMHg1Yy8weDcwCj4g
WyAgIDQxLjIzODkwNV0gIF9fZG9fc3lzX2Zpbml0X21vZHVsZSsweGMxLzB4MTIwCj4gWyAgIDQx
LjIzODkxM10gID8gX19kb19zeXNfZmluaXRfbW9kdWxlKzB4YzEvMHgxMjAKPiBbICAgNDEuMjM4
OTI0XSAgX194NjRfc3lzX2Zpbml0X21vZHVsZSsweDFhLzB4MjAKPiBbICAgNDEuMjM4OTMyXSAg
ZG9fc3lzY2FsbF82NCsweDM3LzB4ODAKPiBbICAgNDEuMjM4OTQyXSAgZW50cnlfU1lTQ0FMTF82
NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQo+IAo+IFNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVu
IDxndWNodW4uY2hlbkBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvY2FsY3MvZGNlX2NhbGNzLmMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jCj4gaW5kZXggNTU2ZWNmYWJjOGQyLi4xMjQ0
ZmNiMGY0NDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nh
bGNzL2RjZV9jYWxjcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Nh
bGNzL2RjZV9jYWxjcy5jCj4gQEAgLTIwNTEsMTEgKzIwNTEsMTEgQEAgdm9pZCBid19jYWxjc19p
bml0KHN0cnVjdCBid19jYWxjc19kY2VpcCAqYndfZGNlaXAsCj4gIAo+ICAJZW51bSBid19jYWxj
c192ZXJzaW9uIHZlcnNpb24gPSBid19jYWxjc192ZXJzaW9uX2Zyb21fYXNpY19pZChhc2ljX2lk
KTsKPiAgCj4gLQlkY2VpcCA9IGt6YWxsb2Moc2l6ZW9mKGRjZWlwKSwgR0ZQX0tFUk5FTCk7Cj4g
KwlkY2VpcCA9IGt6YWxsb2Moc2l6ZW9mKCpkY2VpcCksIEdGUF9LRVJORUwpOwo+ICAJaWYgKCFk
Y2VpcCkKPiAgCQlyZXR1cm47Cj4gIAo+IC0JdmJpb3MgPSBremFsbG9jKHNpemVvZih2Ymlvcyks
IEdGUF9LRVJORUwpOwo+ICsJdmJpb3MgPSBremFsbG9jKHNpemVvZigqdmJpb3MpLCBHRlBfS0VS
TkVMKTsKPiAgCWlmICghdmJpb3MpIHsKPiAgCQlrZnJlZShkY2VpcCk7Cj4gIAkJcmV0dXJuOwoK
T2ggeWVzLCBvZiBjb3Vyc2UuCgpMb29rcyBsaWtlIGl0IHdhcyBtaXNzZWQgaW4gcmV2aWV3IHRv
by4KClNvcnJ5IGFib3V0IHRoZSBzY2hvb2wgYm95IGVycm9yIQoKUmV2aWV3ZWQtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNl
bmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBP
cGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sg
fCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
