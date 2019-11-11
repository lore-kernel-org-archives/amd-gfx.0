Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD12C17441
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 11:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1691822469
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 11:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1691822469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB7AF6EB13;
	Tue, 12 Nov 2019 11:24:21 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFAD6EB16
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 11:24:19 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a15so18058432wrf.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 03:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=tMeJVvAcBuu1J0JzcgO2oSHFM9MK70NlvQc5tfeTut4=;
 b=RMM1QCvAltkynPxjqOv4V28hlLcrQxFQKgkK5mKh6h3dgywszPmwtPC7La4O+SAjJk
 N8G5rGw07VGo/VmNgvkp+D8OF9wQscc4yydq/DzRPpNKCHMYRpIvgXbRdWt4N/YYHF2j
 6/YUlWGHuZY9vKKTkid/1wt8aHthFl7AQNnET5R9GnokEwdB6nd05VXDih+I2xncqQby
 Ke3B8DlJ4woBvg7KOAHQ6Pfbx2CJzumhcEJ2tW8ta19yUWENWBYymHWRAR1jehU5XAaO
 IAMulDfVgiB2GlXXyYFMa18r2KdihGce3dyi5Ah2Vb6m+UkatfkWF4tq+lOJ9ER5CbXv
 kgww==
X-Gm-Message-State: APjAAAXJMY93XnLfKvevBfo9cMDwoiFYoPZmw27W7ENKt5mukkkzpqKd
 YwgRyHTDIMFWmmwznCLZCG8=
X-Google-Smtp-Source: APXvYqzmJTmo1h9bza4sekc1Ram2X+AsUQxNeH0HE6JO4CJ8ZgDJO3AkQeqJ6jlCLrST2Ijt0aOPVg==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr24295042wrp.37.1573557858472; 
 Tue, 12 Nov 2019 03:24:18 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y189sm2720064wmb.13.2019.11.12.03.24.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 03:24:17 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu/vcn: finish delay work before release resources
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191111204938.836819-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <71f34fcd-5d68-3064-7f9a-54e3d46e064a@gmail.com>
Date: Mon, 11 Nov 2019 22:12:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111204938.836819-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=tMeJVvAcBuu1J0JzcgO2oSHFM9MK70NlvQc5tfeTut4=;
 b=ppbCndfUX1SxMMV1HVFj7mY1rHvr+ItUIqIiM1hxDCoQVO6bJtQCpFB5Y/ooRE1FOn
 MPeDR6QPz5Aw+kyBOcwOX++unOu9DMtNX/qQ7JcE1IYI2XoxoKHz+vBEJQ47OuPUlHUX
 M74ndrrLBwkU46c8BxEwKhhPbv+RiUqR4xthOrbGJ/mh/wBB/uvyVpNmvGrKSDJB81sZ
 Zif3GlJMeQhjs8kTnfEQiNYla40NH8guXQf6M9ri8ig0//Afuatnu3pXW8eAPw53NYHA
 IJxOEyiZrSLPTOC0UWiwij88Q9r9WTKqQpJrOb2gM9fwdEPUxDMpO9PpvriaoiDhRS2s
 umbw==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Message-ID: <20191111211215.7FCSN4QVReCjO6LPL8mqs1Jx2gG1oytLuYWBNzn30vk@z>

QW0gMTEuMTEuMTkgdW0gMjE6NDkgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gZmx1c2gvY2FuY2Vs
IGRlbGF5ZWQgd29ya3MgYmVmb3JlIGRvaW5nIGZpbmFsaXphdGlvbgo+IHRvIGF2b2lkIGNvbmN1
cnJlbnRseSByZXF1ZXN0cy4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Zjbi5jIHwgMiArKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24u
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+IGluZGV4IDMxOTll
NGE1ZmYxMi4uOWQ4NzA0NDRkN2Q2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uYwo+IEBAIC0xOTMsNiArMTkzLDggQEAgaW50IGFtZGdwdV92Y25fc3dfZmluaShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIHsKPiAgIAlpbnQgaSwgajsKPiAgIAo+ICsJ
Y2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPiArCj4gICAJ
aWYgKGFkZXYtPnZjbi5pbmRpcmVjdF9zcmFtKSB7Cj4gICAJCWFtZGdwdV9ib19mcmVlX2tlcm5l
bCgmYWRldi0+dmNuLmRwZ19zcmFtX2JvLAo+ICAgCQkJCSAgICAgICZhZGV2LT52Y24uZHBnX3Ny
YW1fZ3B1X2FkZHIsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
