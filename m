Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD5C38A2A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 08:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0B3207DD
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 08:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCPDgEPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0B3207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B536E145;
	Fri,  8 May 2020 08:13:10 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 572076E145;
 Fri,  8 May 2020 08:13:09 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 188so9265879wmc.2;
 Fri, 08 May 2020 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hvvHlb38AIwzio2a69BGQcdnbFfbnB1WrpBu/rnEai8=;
 b=BCPDgEPrHCBcXUvSB+ui+kZhF9a6Yini8k+bIfNuDis1bc+I7Ib8mvhu87wQ1sIiBu
 X5J8nz3oWFMZaaTYaF4xa8eb3Fp4ywZ0xAZKR0MgYi10lQMFuWZ6CcWxDqxC0PsLwLEi
 VxFpOOwcMmZhxjKB6mH+UniN39Ag6hf08y4Vh15+0jHHUFKh+TB//1cHTCYxD8TpSlmP
 zfTc6IxcEoXCLbmtv5md/iIfH3XEw0GPXi0KZMHkZnW0/oZzj/jQl1gOSD2vtI3xAV2r
 1sZuwfK6sJk9TuXWCZOAQsFe/N359e5tXpz2CtHyW+FrvhuLPcDs3GS0FqkR2jfQbuzl
 M9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=hvvHlb38AIwzio2a69BGQcdnbFfbnB1WrpBu/rnEai8=;
 b=PEP0TscVuD/c5Q6oWXmztKqkMOYTfyoqQ0qnUdFub16QdfVOTIxyiDyBcViMcopSiA
 QdJf79Nq1jgXy+Adjef6cGjH2sUq9sLWqHCoXGHK5qLt9o9bi0TnoxVpcCFiroXtJDkf
 Pg5OwErS95wpL0nzPdsQx0xCsc83JDxIg3/Nc2LA8mUe5xhH+kw9chVjguYGVy4HfzAw
 Nm1iQbjplrID1hnHdiQmhDBH/tTnKuaPPQlbeLkxIBwkitGxKwQffPuVshZzxK+yiLKe
 rVp1RnleU7esRNXBG4W767PCtP+zlXoJD/cxLJwSqioikvg3MSFf8PDfgzbYChtWhEpA
 aWkg==
X-Gm-Message-State: AGi0PubuYMIs97WW8wcI40ajhGXAr/diHqsRzAzcQf5u/SFPc3eduvEb
 tVd9f7e/VE+wxZ2+ACVnFHykhYKE
X-Google-Smtp-Source: APiQypLhBrep9nsjvCPR5A2p54Zja55VgqkR9lw0H5JuzpYxWCs+Rp96vbffjcPvmzkSJRfKExxvbg==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr15519157wmc.80.1588925587759; 
 Fri, 08 May 2020 01:13:07 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t67sm13038756wmg.40.2020.05.08.01.13.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 May 2020 01:13:07 -0700 (PDT)
Subject: Re: [PATCH 06/36] drm/amdgpu: use the unlocked drm_gem_object_put
To: Emil Velikov <emil.l.velikov@gmail.com>, dri-devel@lists.freedesktop.org
References: <20200507150822.114464-1-emil.l.velikov@gmail.com>
 <20200507150822.114464-7-emil.l.velikov@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <dc448b12-3ca8-069a-61cf-4da9e5a3ad34@gmail.com>
Date: Fri, 8 May 2020 10:13:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200507150822.114464-7-emil.l.velikov@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDcuMDUuMjAgdW0gMTc6MDcgc2NocmllYiBFbWlsIFZlbGlrb3Y6Cj4gRnJvbTogRW1pbCBW
ZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KPgo+IFRoZSBkcml2ZXIgZG9lcyBu
b3QgaG9sZCBzdHJ1Y3RfbXV0ZXgsIHRodXMgdXNpbmcgdGhlIGxvY2tlZCB2ZXJzaW9uIG9mCj4g
dGhlIGhlbHBlciBpcyBpbmNvcnJlY3QuCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIu
ZGV1Y2hlckBhbWQuY29tPgo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gRml4ZXM6IGEz
OTQxNDcxNmNhMCAoImRybS9hbWRncHU6IGFkZCBpbmRlcGVuZGVudCBETUEtYnVmIGltcG9ydCB2
OSIpOgo+IFNpZ25lZC1vZmYtYnk6IEVtaWwgVmVsaWtvdiA8ZW1pbC5sLnZlbGlrb3ZAZ21haWwu
Y29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1
Zi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rt
YV9idWYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPiBp
bmRleCA0M2Q4ZWQ3ZGJkMDAuLjY1MmM1N2EzYjg0NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwo+IEBAIC01ODcsNyArNTg3LDcgQEAgc3RydWN0
IGRybV9nZW1fb2JqZWN0ICphbWRncHVfZ2VtX3ByaW1lX2ltcG9ydChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGV2LAo+ICAgCWF0dGFjaCA9IGRtYV9idWZfZHluYW1pY19hdHRhY2goZG1hX2J1ZiwgZGV2
LT5kZXYsCj4gICAJCQkJCSZhbWRncHVfZG1hX2J1Zl9hdHRhY2hfb3BzLCBvYmopOwo+ICAgCWlm
IChJU19FUlIoYXR0YWNoKSkgewo+IC0JCWRybV9nZW1fb2JqZWN0X3B1dChvYmopOwo+ICsJCWRy
bV9nZW1fb2JqZWN0X3B1dF91bmxvY2tlZChvYmopOwo+ICAgCQlyZXR1cm4gRVJSX0NBU1QoYXR0
YWNoKTsKPiAgIAl9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
