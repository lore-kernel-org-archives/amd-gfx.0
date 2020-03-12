Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD8C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBF220650
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gat37HHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBF220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87C66EAD4;
	Thu, 12 Mar 2020 14:15:38 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF78E6EAD2;
 Thu, 12 Mar 2020 14:15:36 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id n15so7650623wrw.13;
 Thu, 12 Mar 2020 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mrvIFthQhStRb0h9X0TVjnYAU7Y95l7BE/07Zs0KkmU=;
 b=Gat37HHk/IR5hOfp8StNrofQQOmpXRH6pEZ8csCcEb6VJBlyWEH/itLo+6rzB1x332
 4T0hPPvhhrsd4lpchwum7yLB3GYsA83Rge2B0luyRVmm7x3C9IWWlbwJSLx4J/IkCtWc
 3iq+9xvke8xefc2SiwEL5Zl86LRavFa8gCyUsBjsOLjrkbKK3+9GQJpDm9Sfo7Jyr8XS
 SjDczFadOF1FBblnHcM17/mvIME59SYg+fLvaow0pXNJh9aDETNsvVlH1MiFrSRBMF0G
 /yfpt4xMtixGAWXt9hjEzabm8ll+f31vjx6y9In21gFro8zXcB0/4ZrG8lHgnI4/vmjo
 CINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mrvIFthQhStRb0h9X0TVjnYAU7Y95l7BE/07Zs0KkmU=;
 b=XuobXfUffEYFkeKJiKdcJ+ea/DhOsmpHS3EmcMvVV0SuNT74cMhpYf/Fhx+6nElx7v
 rBxLnthrt738j+g/QFXs0VW92NhO7BOXRMjhdRyZHGmUXWWoRRSwDGKVjMxLA2+y8b6N
 NcXK4EXOYJndIweQSG9W13OVsVzKk6bZpggUk2kuxE4ERDQ7f8fTJf1QMzdEKUj0gW4V
 fu8SBK4Vx8WxJo0yyDa6pMH3vAfA4s9POiKjZYd+YAE49ivgotFMwff4+UoKJDWR0THT
 tt12Jm2t6dMCBfPNQ8MiqADVUIFWfgZvxpU1abuUOFMQaPfHlcd3EK/UD+Ms156ATZBy
 00aQ==
X-Gm-Message-State: ANhLgQ1C5FziLIjudIMp2SZLOUHPoo95P8lYzfEDRxP5xLy0Ylz6tCJH
 ZZ/mvekCWrA8ayK+5IJdRJgXtkEOB8q/oreGmi4=
X-Google-Smtp-Source: ADFU+vunbIhUB+upr9tvSXIUy5Rsh6w6Y/X84qlyHVsfayqsdBwr5bi936oAu3SpuUu2YFjWpTDxR6kp0SMteWKw1ns=
X-Received: by 2002:adf:f74b:: with SMTP id z11mr11805645wrp.124.1584022535408; 
 Thu, 12 Mar 2020 07:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <6c252c3d-5d0a-2a2f-4b8c-60d7622d1146@infradead.org>
In-Reply-To: <6c252c3d-5d0a-2a2f-4b8c-60d7622d1146@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Mar 2020 10:15:23 -0400
Message-ID: <CADnq5_PcQW=qf4fNx7v7Q4coLAMr755ykx+YfoxoYchHxivk3Q@mail.gmail.com>
Subject: Re: [PATCH] drm: amd/acp: fix broken menu structure
To: Randy Dunlap <rdunlap@infradead.org>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWFyIDEyLCAyMDIwIGF0IDQ6MDkgQU0g
UmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gRnJvbTogUmFu
ZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4KPiBGaXggdGhlIEtjb25maWcgZGVw
ZW5kZW5jaWVzIHNvIHRoYXQgdGhlIG1lbnUgaXMgcHJlc2VudGVkCj4gY29ycmVjdGx5IGJ5IGFk
ZGluZyBhIGRlcGVuZGVuY3kgb24gRFJNX0FNREdQVSB0byB0aGUgIm1lbnUiCj4gS2NvbmZpZyBz
dGF0ZW1lbnQuICBUaGlzIG1ha2VzIGEgY29udGludW91cyBkZXBlbmRlbmN5IG9uCj4gRFJNX0FN
REdQVSBpbiB0aGUgRFJNIEFNRCBtZW51cyBhbmQgZWxpbWluYXRlcyBhIGJyb2tlbiBtZW51Cj4g
c3RydWN0dXJlLgo+Cj4gRml4ZXM6IGE4ZmU1OGNlYzM1MSAoImRybS9hbWQ6IGFkZCBBQ1AgZHJp
dmVyIHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZy
YWRlYWQub3JnPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
Cj4gQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiBDYzog
RGF2aWQgKENodW5NaW5nKSBaaG91IDxEYXZpZDEuWmhvdUBhbWQuY29tPgo+IENjOiBNYXJ1dGhp
IEJheXlhdmFyYXB1IDxtYXJ1dGhpLmJheXlhdmFyYXB1QGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tj
b25maWcgfCAgICAxICsKPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiAtLS0g
bGludXgtbmV4dC5vcmlnL2RyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tjb25maWcKPiArKysgbGlu
dXgtbmV4dC9kcml2ZXJzL2dwdS9kcm0vYW1kL2FjcC9LY29uZmlnCj4gQEAgLTEsNSArMSw2IEBA
Cj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1JVAo+ICBtZW51ICJBQ1AgKEF1ZGlvIENv
UHJvY2Vzc29yKSBDb25maWd1cmF0aW9uIgo+ICsgICAgICAgZGVwZW5kcyBvbiBEUk1fQU1ER1BV
Cj4KPiAgY29uZmlnIERSTV9BTURfQUNQCj4gICAgICAgICBib29sICJFbmFibGUgQU1EIEF1ZGlv
IENvUHJvY2Vzc29yIElQIHN1cHBvcnQiCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
