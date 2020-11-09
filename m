Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6769DC2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 20:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1F8206E3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 20:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBO0ty9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1F8206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA4B89339;
	Mon,  9 Nov 2020 20:07:03 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F9B892E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 20:00:00 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id h62so673968wme.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 12:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=iSLk3+x7uenqlILFpaNoxyCB9G64i4wec0N4zPVtLds=;
 b=NBO0ty9u54emHjnfEXXnFOBSllklLV+aYFoqGVp5cQ9mAb56Dl+sd3zn/rP+aUSIzf
 DFCvXXhk001k2PTIsBSRdUzu2sUFlU6XVcNPdNhZsFvci9JTb2r6z/4FueX9Hq9e1MfU
 lzhOt4sbxh89rgwgXrX9BXrkVBx0pbqW9jaUjGALtGIA5+q9QPjAPt5ZWJlCD671pgeA
 bjemtpPIbR9qJ9S+0a7d+rfrgx6BcI5+GNi1mIE1yBCsZ4wudlv+S6WRhNhDnN6CH8nL
 FC8JRh+VSLieTqgZWyqK2OBEZ0sRn95k2W9ULT0oMOvw18vmnxJ4muh6Cb6rF+ToKQIv
 iOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=iSLk3+x7uenqlILFpaNoxyCB9G64i4wec0N4zPVtLds=;
 b=axomA6eGsAVXTZSKYi03FtAdQvX/jeJGWpJkbxcXVsAMVApAKkyyNhFr28iipR+l2V
 KMICxLiNt8DJtBgmOOjrxR09qZAiOMDKMY8KNwBKGlrcZjpnBfdznRyv9FezJ/ypBNxC
 B/TQSvHhi+QMG98kRer+QsTRymQgKuuXSSkSL4twLb8nOturU99OZo/ZY5KHAmNvVROP
 nH3wlO9Pke14FUyk2qf0xs+XrLXV/2uktAM6IYZSsXJrHYnkOocsd0oIS2asZmUa8C63
 ATPZ8iSQIPAGRHimCm7yOiCt9jZb1b1xJC1zfcYjOItohw/3hQPxwa9hzw2SQB73yJkJ
 TwLQ==
X-Gm-Message-State: AOAM533qosW0AQUfUTsaR6D+e4Rcdu8UHsjHay+ptjNtLoo/TaDaOOFA
 aDWnWAfmh13W90JbW1TW5LLzaA==
X-Google-Smtp-Source: ABdhPJwldywwbJ+oLDqj/fDJgp5SEWiJ5ZwxUHvawP8CtF53/49IYzNhHipfLfFh1313dpVLWLMYLg==
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr839625wmb.152.1604951999546; 
 Mon, 09 Nov 2020 11:59:59 -0800 (PST)
Received: from dell ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id f23sm463349wmb.43.2020.11.09.11.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 11:59:58 -0800 (PST)
Date: Mon, 9 Nov 2020 19:59:57 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 17/19] drm/radeon/radeon_kms: Fix misnaming of
 'radeon_info_ioctl's dev param
Message-ID: <20201109195957.GB2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-18-lee.jones@linaro.org>
 <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_Nys7igVo3sgzK0D4hnm=RHMrEM7Xty80jGROu_sy5svA@mail.gmail.com>
X-Mailman-Approved-At: Mon, 09 Nov 2020 20:07:01 +0000
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAwOSBOb3YgMjAyMCwgQWxleCBEZXVjaGVyIHdyb3RlOgoKPiBPbiBGcmksIE5vdiA2
LCAyMDIwIGF0IDQ6NTAgUE0gTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6
Cj4gPgo+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6
Cj4gPgo+ID4gIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jOjIyNjogd2Fybmlu
ZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZGV2JyBub3QgZGVzY3JpYmVkIGluICdy
YWRlb25faW5mb19pb2N0bCcKPiA+ICBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMu
YzoyMjY6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ3JkZXYnIGRlc2NyaXB0
aW9uIGluICdyYWRlb25faW5mb19pb2N0bCcKPiA+Cj4gPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+ID4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4KPiA+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gPiBDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiA+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3Jn
Pgo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMgfCAyICst
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMKPiA+IGluZGV4IDBkOGZiYWJmZmNlYWQu
LjIxYzIwNjc5NWMzNjQgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl9rbXMuYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMK
PiA+IEBAIC0yMTMsNyArMjEzLDcgQEAgc3RhdGljIHZvaWQgcmFkZW9uX3NldF9maWxwX3JpZ2h0
cyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAo+ID4gIC8qKgo+ID4gICAqIHJhZGVvbl9pbmZvX2lv
Y3RsIC0gYW5zd2VyIGEgZGV2aWNlIHNwZWNpZmljIHJlcXVlc3QuCj4gPiAgICoKPiA+IC0gKiBA
cmRldjogcmFkZW9uIGRldmljZSBwb2ludGVyCj4gPiArICogQGRldjogcmFkZW9uIGRldmljZSBw
b2ludGVyCj4gCj4gVGhpcyBzaG91bGQgYmU6Cj4gKyAqIEBkZXY6IGRybSBkZXZpY2UgcG9pbnRl
cgoKTWFrZXMgc2Vuc2UuICBJZiB5b3UgZG9uJ3QgZmFuY3kgZml4aW5nIHRoaXMgdXAsIEknbGwg
c2VuZCBvdXQgYQpmaXgtdXAgaW4gYSBmZXcgZGF5cy4KCi0tIApMZWUgSm9uZXMgW+adjueQvOaW
r10KU2VuaW9yIFRlY2huaWNhbCBMZWFkIC0gRGV2ZWxvcGVyIFNlcnZpY2VzCkxpbmFyby5vcmcg
4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBcm0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNl
Ym9vayB8IFR3aXR0ZXIgfCBCbG9nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
