Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 15:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C5A23A9F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 15:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C5A23A9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19026E42C;
	Thu, 14 Jan 2021 15:46:43 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B266F6E1A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 10:33:54 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id c124so4068248wma.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 02:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=yaIv+nhOILu/3I9bOPLxY99wOuAF6NciDB+QzXelzGY=;
 b=x8ApzkDMlTt2JG1XTWJhNr1UKtQ6IFke3c3xr3SNGi+9jXp61r4rSclfE/x1ZsbC6E
 kc3JWmQopOjyxq44LwowQmbznGUqSL8wNXevUO002EUou0BIqTw8RYLVCiGE12+CxOX/
 fxzIAzI7B2R4ewJDEktxUkcQ9SXPjACGgvZ9SFyT7k+98Hh+k6Ffwn0+1CFwBNjXgJeC
 HZ9wtKBjT9978oC3ER0xABCm+aUUHni1g67qqK7MQvH1V6NJJE0oBi422TUbvcXF/XDo
 OhKFaCHNP4yp/yeXwV/H58LDpQdqoatqp/ojdlHvfoNnH0n1NERfvwFqNzaDrli1Oe+I
 VJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=yaIv+nhOILu/3I9bOPLxY99wOuAF6NciDB+QzXelzGY=;
 b=l73bTKN00/qrzdUvcQgMoVC9doHS8iBGtjdEneVilLT+ggpUwmkegegfzobj9eq8bk
 5zNZr/1R1ASrDUwLkXWJiPphonXjA8NY3fDd+DrR7f5uLL78i6H806XIDRMYQ5PlWtma
 laLWE2YszafcNb31oLqWkLi934FwPO2Q7xpnRjHbAKzFvC136PUm2oAiWk9X/PwBj+PT
 3yTztAMev0WF+4EX8pvAB1jQcomFR8O2pjrGVDTXabZ1oU5hiS2p9l5tuTVVCW0djoOU
 cRBy7KXuxkAJWQLCdae/QpqFUpmOAD2Xxe1JEHe1wGQXAhrUTGPCfh99/I/RkS47rwst
 zrfQ==
X-Gm-Message-State: AOAM532rVVq425BrOdOxaoANpfYxKheYb7/T6Ilciapn83Heto1PH7JI
 Urv8TqceT3ePHQFyT9tRCg+9rw==
X-Google-Smtp-Source: ABdhPJxOYTenjJAea68Lbo43i7Qv6whisJfp5qKHWu1LHfCUfeuuNEisJHD+dQOSAgNSMN4zAvV+tQ==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr3262314wmj.52.1610620433288;
 Thu, 14 Jan 2021 02:33:53 -0800 (PST)
Received: from dell ([91.110.221.178])
 by smtp.gmail.com with ESMTPSA id m17sm9413232wrn.0.2021.01.14.02.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 02:33:52 -0800 (PST)
Date: Thu, 14 Jan 2021 10:33:50 +0000
From: Lee Jones <lee.jones@linaro.org>
To: linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx@lists.freedesktop.org, Anthony Koo <Anthony.Koo@amd.com>,
 Ben Skeggs <bskeggs@redhat.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Jeremy Kolb <jkolb@brandeis.edu>, Leo Li <sunpeng.li@amd.com>,
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 Lyude Paul <lyude@redhat.com>, Mauro Rossi <issor.oruam@gmail.com>,
 Noah Abradjian <noah.abradjian@amd.com>, nouveau@lists.freedesktop.org,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH 00/30] [Set 13] Finally rid W=1 warnings from GPU
Message-ID: <20210114103350.GT3975472@dell>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
X-Mailman-Approved-At: Thu, 14 Jan 2021 15:46:42 +0000
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCAxMyBKYW4gMjAyMSwgTGVlIEpvbmVzIHdyb3RlOgoKPiBUaGlzIHNldCBpcyBwYXJ0
IG9mIGEgbGFyZ2VyIGVmZm9ydCBhdHRlbXB0aW5nIHRvIGNsZWFuLXVwIFc9MQo+IGtlcm5lbCBi
dWlsZHMsIHdoaWNoIGFyZSBjdXJyZW50bHkgb3ZlcndoZWxtaW5nbHkgcmlkZGxlZCB3aXRoCj4g
bmlnZ2x5IGxpdHRsZSB3YXJuaW5ncy4KPiAKPiAwIG91dCBvZiA1MDAwIGxlZnQhCj4gCj4gTEFT
VCBTRVQhICBZb3UncmUgYWxsIGNsZWFuLiAgQ2FuIHlvdSBiZWxpZXZlIGl0IT8KCkFoLCBmYWly
IHdhcm5pbmcgZm9yIHlvdTogd2UncmUgbm90IHlldCBkb25lLgoKQXJtIGlzIGNsZWFuLiAgVGhl
cmUgYXJlIHN0aWxsIGZpeC11cHMgcmVxdWlyZWQgZm9yIHg4NiBhbmQgUFBDLgoKSSdsbCBnZXQg
cmlnaHQgb24gaXQuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dClNlbmlvciBUZWNobmljYWwg
TGVhZCAtIERldmVsb3BlciBTZXJ2aWNlcwpMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0
d2FyZSBmb3IgQXJtIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxv
ZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
