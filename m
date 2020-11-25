Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9EC56202
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 17:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B67206D8
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 17:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y4noN/Au"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B67206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCBD26EA54;
	Wed, 25 Nov 2020 17:03:04 +0000 (UTC)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 860E26EA55
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 17:03:03 +0000 (UTC)
Received: by mail-oi1-x241.google.com with SMTP id k26so3601158oiw.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=IUsoYH9UfIVVcykEVMChFcFvDOVK9fjkUz5PsSbBKY4=;
 b=Y4noN/AuajGaOeCp9TzS3SGgouUAz0CxwuuMoGRc/JZvjiJ56AzhZqQIX3TDoanYOh
 tailsffkXB3uZoaASZcZPXk5HyHaVawfXUgasvjni6h19HM4Y+w3XgRDNYCpregAYwzD
 3No2Ay6/Hf8JvZGgrxyYpgb2wILYCFehtLAY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=IUsoYH9UfIVVcykEVMChFcFvDOVK9fjkUz5PsSbBKY4=;
 b=bStLeEDslYhOsAfAl8FdWSoQFhHXf8XRm9m3zlu1yza3EGSf4GggEqNpp3IeV18c3j
 rQoxHU8QnVONE3GmGN+ONp0yGxnmQebLQCDEEzboGoARFeMt0WCqjMsBSKzx7cyh7NHK
 /btjhLHLNSme8dXizpGc2L5sMsdMqGJFpWz1ter+CFkeMa0xb+HFsLWFP500y1HHGHBs
 UxphOmnbzoikqAn3b8Gn2Zik8Kv/spT6ggk881DA0Bgd3WIjotYUOoj/KvIgjBrIEv/f
 6DI2fW+uDRmiCOw9NLPUQ9aFKqSsI7EGLgxc5Uhlg/Nn+ZUdP34f8PbkXSNKURnGkgRP
 dX4g==
X-Gm-Message-State: AOAM530vW5SG/cqAYhnLwLAeU+0UdETSPsQwSwoyltSCOF5tY3LVQZ1T
 epAPN5tS2D8EDWp9XdmrXnobYZ6COqzgnzor2F7KBw==
X-Google-Smtp-Source: ABdhPJwfM9p0Re3rpoo3rBTEznJf7PPtniciR2ZDsggmBTCHLyfTiUzfMOtkaiOAd9de2fHXv+OSW5v4fArBG+1X4ZE=
X-Received: by 2002:aca:4f14:: with SMTP id d20mr2886595oib.14.1606323782777; 
 Wed, 25 Nov 2020 09:03:02 -0800 (PST)
MIME-Version: 1.0
References: <1605936082-3099-6-git-send-email-andrey.grodzovsky@amd.com>
 <28332cf0-612c-10bd-c64e-fff6e1f18653@gmail.com>
 <320ff94c-78f4-b9a5-4c6f-40f7ce162bd3@amd.com>
 <41b35672-2dd6-13e2-8383-c65279fdb648@gmail.com>
 <e2f4f1dc-2a2a-face-87b2-6d61ed7d3305@amd.com>
 <01280cba-56b8-77c6-b40f-d7e69a5ad4c6@amd.com>
 <0ceca974-80f8-feb3-d5e9-5182f35bb2c4@amd.com>
 <20288c45-270c-3ed7-2ac4-eeb6e5c50776@amd.com>
 <2df98c1a-8ed4-fb87-f8f7-e3962e8d9c52@amd.com>
 <041210e5-e237-b72e-dcbc-17027d057c55@gmail.com>
 <20201125104021.GV401619@phenom.ffwll.local>
 <71683ae7-f443-c15a-7003-6ba4ad3d4b15@gmail.com>
 <6669f4ca-bfca-e54e-6d24-ee1bff0c17db@daenzer.net>
In-Reply-To: <6669f4ca-bfca-e54e-6d24-ee1bff0c17db@daenzer.net>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 25 Nov 2020 18:02:51 +0100
Message-ID: <CAKMK7uFZnk22EhYQKOPctZz+-YPspWGqh4EWAO3H_stesgpVRA@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] drm/ttm: Expose ttm_tt_unpopulate for driver use
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBOb3YgMjUsIDIwMjAgYXQgNTo1NiBQTSBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRh
ZW56ZXIubmV0PiB3cm90ZToKPgo+IE9uIDIwMjAtMTEtMjUgMTo1NyBwLm0uLCBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+ID4KPiA+IFdlbGwgdGhpbmtpbmcgbW9yZSBhYm91dCB0aGlzLCBpdCBz
ZWVtcyB0byBiZSBhIGFub3RoZXIgcmVhbGx5IGdvb2QKPiA+IGFyZ3VtZW50IHdoeSBtYXBwaW5n
IHBhZ2VzIGZyb20gRE1BLWJ1ZnMgaW50byBhcHBsaWNhdGlvbiBhZGRyZXNzIHNwYWNlCj4gPiBk
aXJlY3RseSBpcyBhIHZlcnkgYmFkIGlkZWEgOikKPgo+IEFwb2xvZ2llcyBmb3IgZ29pbmcgb2Zm
IG9uIGEgdGFuZ2VudCBoZXJlLi4uCj4KPiBTaW5jZSBhbGxvd2luZyB1c2Vyc3BhY2UgbW1hcCB3
aXRoIGRtYS1idWYgZmRzIHNlZW1zIHRvIGJlIGEgdHJhcCBpbgo+IGdlbmVyYWxbMF0sIEkgd29u
ZGVyIGlmIHRoZXJlJ3MgYW55IHdheSB3ZSBjb3VsZCBzdG9wIHN1cHBvcnRpbmcgdGhhdD8KPgo+
Cj4gWzBdIEUuZy4gbXV0dGVyIGhhZCB0byBkaXNhYmxlIGhhbmRpbmcgb3V0IGRtYS1idWZzIGZv
ciBzY3JlZW4gY2FwdHVyZQo+IGJ5IGRlZmF1bHQgd2l0aCBub24taTkxNSBmb3Igbm93LCBiZWNh
dXNlIGluIHBhcnRpY3VsYXIgd2l0aCBkaXNjcmV0ZQo+IEdQVXMsIGRpcmVjdCBDUFUgcmVhZHMg
Y2FuIGJlIHVudXNhYmx5IHNsb3cgKHRoaW5rIHNpbmdsZS1kaWdpdCBmcmFtZXMKPiBwZXIgc2Vj
b25kKSwgYW5kIG9mIGNvdXJzZSB0aGVyZSdzIG90aGVyIHVzZXJzcGFjZSB3aGljaCBnb2VzICJv
b2gsCj4gZG1hLWJ1ZiwgbGV0J3MgbWFwIGFuZCByZWFkISIuCgpJIHRoaW5rIGEgcGlsZSBvZiBh
cHBsaWNhdGlvbnMgKGNyb3MgaW5jbHVkZWQpIHVzZSBpdCB0byBkbyB1cGxvYWRzCmFjcm9zcyBw
cm9jZXNzIGJvdW5kYXJpZXMuIFRoaW5rIGxvY2tlZCBkb3duIGpwZWcgZGVjb2RlciBhbmQgc3R1
ZmYKbGlrZSB0aGF0LiBGb3IgdGhhdCB1c2UtY2FzZSBpdCBzZWVtcyB0byB3b3JrIG9rLgoKQnV0
IHllYWggZG9uJ3QgcmVhZCBmcm9tIGRtYS1idWYuIEknbSBwcmV0dHkgc3VyZSBpdCdzIGRlYWQg
c2xvdyBvbgphbG1vc3QgZXZlcnl0aGluZywgZXhjZXB0IGludGVncmF0ZWQgZ3B1IHdoaWNoIGhh
dmUgQSkgYSBjb2hlcmVudApmYWJyaWMgd2l0aCB0aGUgZ3B1IGFuZCBCKSB0aGF0IGZhYnJpYyBp
cyBhY3R1YWxseSBmYXN0ZXIgZm9yCnJlbmRlcmluZyBpbiBnZW5lcmFsLCBub3QganVzdCBmb3Ig
ZGVkaWNhdGVkIGJ1ZmZlcnMgYWxsb2NhdGVkIGZvcgpkb3duL3VwbG9hZC4KLURhbmllbAotLSAK
RGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9yYXRpb24KaHR0cDov
L2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
