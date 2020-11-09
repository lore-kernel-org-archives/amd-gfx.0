Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66397C2D0A3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 16:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A202206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 16:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovpCxEuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A202206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACADF89A75;
	Mon,  9 Nov 2020 16:11:20 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA8C589A92
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 16:10:55 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id t67so4090270wmt.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=XVBP+n0VN9eN/C2Jba9mEU16D1fWrV9bkOxgoHmqowE=;
 b=ovpCxEuW57eNQuSsfoObUTndr+bipuROJRQTcCSVncULvKVS9SyR+rzkpi5I6sUEhe
 5TxIvy0CQg8ufCAJz0rrG5Y8c3PSTT0m3CCLztv1xrQeTd6KVVNy9RRTKj8UawzcPFuX
 J/i8JGdCrNq+Jg6tZcOQQGSLMDaF2tYOpbtqZzfg5xLFxPl3fhqN2AIXVjYkfYJ3rQZ8
 8YmBTSOEa8WHMlHsqKxLQh2iitZnPJuFa46+xFExDlDcNuiOx4n6iO7/yxMedduL8x9J
 3jEo/JJbd3xiwfNiex4U6vOft6qs8o6sWN+jDI7wcYq/NYlgr/itbe2jJAMnaAAvTh8V
 Wh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=XVBP+n0VN9eN/C2Jba9mEU16D1fWrV9bkOxgoHmqowE=;
 b=DO5EoFWeXxw0PErfXYrbx1pHL3A6/Z6LHJvy56h0zBGCupNKmQMXTHViHuQKnUPwBy
 9+Uyx71uR2yoQit/PoV8Jh8854UBzJoBLYCUgBIwD/+xXMdSAy+JfFG4T1uRfJevu9cU
 tFMpolV0OcBhD8XK4zfMUdd2Bq7158XTUnGHtnCG+XTGO9ui4Thf3lmZ3KFMF2T9fIXJ
 OKMC7onEm+Y3Y4F345fO1VPqsJ9s02rjoYyVs0iF26ee+R95se02TcCctSA1W1xuAVEE
 OWMJ9BR8KHuX7Vtnf24d2YNd6oCyg3PN06AN7cYK+ToETJEa9kFO0OWnU3LjzfHZ+u6d
 kzJg==
X-Gm-Message-State: AOAM532c2S150pdtMpVcNdNW1IBH07Jnz/DLGNQlD2Km6xZV0lijaZew
 KyJrsleJ33UFBfq8Up9B9NiBew==
X-Google-Smtp-Source: ABdhPJxQvHFpa9rWHRtMcdHxH++0UXHHx4BiJVp+45GpHvO8bsRDcBMFvyMavXb/jg3d+O1vYTmIrA==
X-Received: by 2002:a1c:df04:: with SMTP id w4mr61037wmg.3.1604938254577;
 Mon, 09 Nov 2020 08:10:54 -0800 (PST)
Received: from dell ([91.110.221.180])
 by smtp.gmail.com with ESMTPSA id b17sm13872467wru.12.2020.11.09.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 08:10:53 -0800 (PST)
Date: Mon, 9 Nov 2020 16:10:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 10/19] drm/radeon/radeon: Move prototype into shared header
Message-ID: <20201109161050.GW2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-11-lee.jones@linaro.org>
 <20201107142651.GA1014611@ravnborg.org>
 <20201109110603.GV2063125@dell>
 <20201109152530.GA1888045@ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201109152530.GA1888045@ravnborg.org>
X-Mailman-Approved-At: Mon, 09 Nov 2020 16:11:19 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAwOSBOb3YgMjAyMCwgU2FtIFJhdm5ib3JnIHdyb3RlOgoKPiBIaSBMZWUsCj4gPiA+
IAo+ID4gPiBPdGhlciBwdWJsaWMgZnVuY3Rpb25zIGluIHJhZGVvbl9kZXZpY2UuYyBoYXZlIHRo
ZWlyIHByb3RvdHlwZSBpbgo+ID4gPiByYWRlb24uaCAtIGZvciBleGFtcGxlIHJhZGVvbl9pc19w
eCgpCj4gPiA+IAo+ID4gPiBBZGQgcmFkZW9uX2RldmljZV9pc192aXJ0dWFsKCkgdGhlcmUgc28g
d2UgYXZvaWlkIHRoaXMgbmV3IGhlYWRlci4KPiA+IAo+ID4gT2ggeWVzLCBJIHJlbWVtYmVyIHdo
eSB0aGlzIHdhc24ndCBhIHN1aXRhYmxlIHNvbHV0aW9uIG5vdzoKPiA+IAo+ID4gVGhlIG1hY3Jv
ICJyYWRlb25faW5pdCIgaW4gcmFkZW9uLmggY2xhc2hlcyB3aXRoIHRoZSBpbml0IGZ1bmN0aW9u
IG9mCj4gPiB0aGUgc2FtZSBuYW1lIGluIHJhZGVvbl9kcnYuYzoKPiA+IAo+ID4gICBJbiBmaWxl
IGluY2x1ZGVkIGZyb20gZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmM6NTM6Cj4g
PiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jOjYyMDozMTogZXJyb3I6IGV4
cGVjdGVkIGlkZW50aWZpZXIgb3Ig4oCYKOKAmSBiZWZvcmUg4oCYdm9pZOKAmQo+ID4gICA2MjAg
fCBzdGF0aWMgaW50IF9faW5pdCByYWRlb25faW5pdCh2b2lkKQo+IC4uLgo+ID4gCj4gPiBIb3cg
d291bGQgeW91IGxpa2UgbWUgdG8gbW92ZSBmb3J3YXJkPwo+IAo+IEZpeCB0aGUgdGhvdXNhbmQg
b2Ygd2FybmluZ3MgaW4gb3RoZXIgcGxhY2VzIDotKQo+IEkgd2lsbCB0YWtlIGEgbG9vayBhdCBy
YWRlb24gYW5kIHBvc3QgYSBuZXcgc2VyaWVzIGJhc2VkIG9uIHlvdXIgd29yawo+IHdpdGggYWxs
IFc9MSB3YXJuaW5ncyBmaXhlZC4KCkknbGwgZHJvcCB0aGlzIHBhdGNoIGFuZCBjYXJyeSBvbiBw
bG91Z2hpbmcgdGhyb3VnaCB0aGUgcmVzdCBvZiB0aGVtLgoKLS0gCkxlZSBKb25lcyBb5p2O55C8
5pavXQpTZW5pb3IgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9y
ZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZh
Y2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
