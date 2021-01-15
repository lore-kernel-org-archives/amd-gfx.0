Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ADDC4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3805D2388B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 15:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3805D2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A02C6E471;
	Fri, 15 Jan 2021 15:08:48 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8506E40A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 13:44:13 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id a9so5872866wrt.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 05:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=5LGM/hQfT/m1NkcFwxn+fBavVRxtQEMQ8xJulZmCy5E=;
 b=Oxlnozo90cxu5CAM0J3D+JQovdn8yLN2MVMjxPTL76VJh4KTYWYycKAKUky0vEzYys
 Cf4lkmhAOnCgXNbq35xfFPJ7iGKpbk3QGMR6xLKyY/LMgX3qBuPcop/DCAWmG4tq70IF
 l/hoDRT2TAgiRFyuoqQKyab9c8yR6F91yb0gXRKn06z1ijD4YqCLdRBv8ZYaIh6taDqm
 mncqLG4R+aiIhbcop+fqiv2QLt/fBKgIpdC6paZg6aJdZPa1dxGvSf8VJwbkQOo6xwX6
 jjZ5JslnpgnhC0ftqwrQwha1h7QA6RGi/87/iR6UuYm4qkWN47FEffFUvpg99kBRZ4hi
 5TYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5LGM/hQfT/m1NkcFwxn+fBavVRxtQEMQ8xJulZmCy5E=;
 b=cV/cc1vC3QzMnF6KhlKTV0v07xenniW885lqXjXttfjatX7IHvhd4xPv1ym9gmitWe
 zcjym+DmrqFrmSuTVU7Yp4CPfR1a7DVvTGaXtiyZgPNfittJn2sLHLCyd9agY6HIWgtX
 wrinN62b3zJZb3eAGXZ5bzb345xLsde9RtjHan1/9xhL/Myl72dmhnxE56BkVatvq4fj
 xbaCdffb/KzpNL7U5ZaCJoIbnGxXC4V+1zN3SUE29jsFhWUX9jkLx//EyGx2ASMszVzt
 i6sBoqUWJwna2EDckPMYJa5nlyZjanR3hNybWA/hxbGDqxvFrZ7hXTrXruYo6XBtV/Tq
 J5KA==
X-Gm-Message-State: AOAM5322PpFrYUx9Eg1etFhTILYrtVUet9ANLGpb4JcDhcY7naYNpXyN
 1NOZbJzD779FoNjdq2qHOxpbyA==
X-Google-Smtp-Source: ABdhPJzhoypnV/F2NctpRHnfSgluShTklz61DpOBaUcxOgfdSX4foz4+uId70jtpVysUhuCRu8CLuQ==
X-Received: by 2002:adf:d0d0:: with SMTP id z16mr13387336wrh.209.1610718252582; 
 Fri, 15 Jan 2021 05:44:12 -0800 (PST)
Received: from dell ([91.110.221.158])
 by smtp.gmail.com with ESMTPSA id z184sm7701703wmg.7.2021.01.15.05.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Jan 2021 05:44:11 -0800 (PST)
Date: Fri, 15 Jan 2021 13:44:10 +0000
From: Lee Jones <lee.jones@linaro.org>
To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amd/display: fix the system memory page fault
 because of copy overflow
Message-ID: <20210115134410.GL3975472@dell>
References: <20210115184658.513045-1-ray.huang@amd.com>
 <1c67eae5-a77c-b6af-4f80-94b5b80733eb@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c67eae5-a77c-b6af-4f80-94b5b80733eb@gmail.com>
X-Mailman-Approved-At: Fri, 15 Jan 2021 15:08:45 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>,
 Huang Rui <ray.huang@amd.com>, changfeng.zhu@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gRnJpLCAxNSBKYW4gMjAyMSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKCj4gQW0gMTUuMDEu
MjEgdW0gMTk6NDYgc2NocmllYiBIdWFuZyBSdWk6Cj4gPiBUaGUgYnVmZmVyIGlzIGFsbG9jYXRl
ZCB3aXRoIHRoZSBzaXplIG9mIHBvaW50ZXIgYW5kIGNvcHkgd2l0aCB0aGUgc2l6ZSBvZgo+ID4g
ZGF0YSBzdHJ1Y3R1cmUuIFRoZW4gdHJpZ2dlciB0aGUgc3lzdGVtIG1lbW9yeSBwYWdlIGZhdWx0
LiBVc2UgdGhlCj4gPiBvcmlnbmFsIGRhdGEgc3RydWN0dXJlIHRvIGdldCB0aGUgb2JqZWN0IHNp
emUuCj4gPiAKPiA+IEZpeGVzOiBhOGUzMDAwNWIgZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNf
bGluazogTW92ZSBzb21lIGxvY2FsIGRhdGEKPiA+IGZyb20gdGhlIHN0YWNrIHRvIHRoZSBoZWFw
Cj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Cj4g
PiBDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KPiA+IC0tLQo+ID4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMgfCA0ICsrLS0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+IAo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+ID4gaW5k
ZXggNjk1NzNkNjcwNTZkLi43MzE3ODk3OGFlNzQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5rLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmsuYwo+ID4gQEAgLTEzODAsNyArMTM4MCw3
IEBAIHN0YXRpYyBib29sIGRjX2xpbmtfY29uc3RydWN0KHN0cnVjdCBkY19saW5rICpsaW5rLAo+
ID4gICAJRENfTE9HR0VSX0lOSVQoZGNfY3R4LT5sb2dnZXIpOwo+ID4gLQlpbmZvID0ga3phbGxv
YyhzaXplb2YoaW5mbyksIEdGUF9LRVJORUwpOwo+ID4gKwlpbmZvID0ga3phbGxvYyhzaXplb2Yo
c3RydWN0IGludGVncmF0ZWRfaW5mbyksIEdGUF9LRVJORUwpOwo+IAo+IFRoYXQgc2hvdWxkIHBy
b2JhYmx5IGJlIHNpemVvZigqaW5mbykgaW5zdGVhZCwgd2UgdXN1YWxseSB0cnkgdG8gYXZvaWQK
PiBzaXplb2Yoc3RydWN0IC4uLikgaW4gdGhlIGtlcm5lbC4KPiAKPiBUaGVyZSBhcmUgc29tZSBh
dXRvbWF0ZWQgc2NyaXB0cyBpbiBwbGFjZSB3aGljaCB3aWxsIHNlbmQgeW91IGEgcGF0Y2ggdG8K
PiBjaGFuZ2UgaXQgb3RoZXJ3aXNlLgo+IAo+ID4gICAJaWYgKCFpbmZvKQo+ID4gICAJCWdvdG8g
Y3JlYXRlX2ZhaWw7Cj4gPiBAQCAtMTU0NSw3ICsxNTQ1LDcgQEAgc3RhdGljIGJvb2wgZGNfbGlu
a19jb25zdHJ1Y3Qoc3RydWN0IGRjX2xpbmsgKmxpbmssCj4gPiAgIAl9Cj4gPiAgIAlpZiAoYmlv
cy0+aW50ZWdyYXRlZF9pbmZvKQo+ID4gLQkJbWVtY3B5KGluZm8sIGJpb3MtPmludGVncmF0ZWRf
aW5mbywgc2l6ZW9mKCppbmZvKSk7Cj4gPiArCQltZW1jcHkoaW5mbywgYmlvcy0+aW50ZWdyYXRl
ZF9pbmZvLCBzaXplb2Yoc3RydWN0IGludGVncmF0ZWRfaW5mbykpOwo+IAo+IFRoaXMgY2FuIHRo
ZW4gYWxzbyBzdGF5IGFzIGl0IGlzLgo+IAo+IEFwYXJ0IGZyb20gdGhhdCBnb29kIGNhdGNoLgoK
WWVzLCBhZ3JlZWQuCgpTb3JyeSBmb3IgdGhlIGZ1c3MuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzm
lq9dClNlbmlvciBUZWNobmljYWwgTGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3Jn
IOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFj
ZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
