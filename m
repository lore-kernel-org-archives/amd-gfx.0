Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22754C49361
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E245C613D1
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 20:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E245C613D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890A689020;
	Fri, 18 Jun 2021 20:33:38 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8B389016;
 Fri, 18 Jun 2021 20:33:37 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 h24-20020a9d64180000b029036edcf8f9a6so10953246otl.3; 
 Fri, 18 Jun 2021 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0lqhtlNOacqNuU9HVlYS2QY7iZE+rcKx/NRXadqAqMk=;
 b=AuSfHwDEDhrhZndV8N8LFsf/T1gLt0SL4Kr2SNUF3Pc/mezMmFtpzDBDHqrAsZUjOm
 IRy03UanKoPueyLJxxyoLwi+7yWLwc1lE2fQ43tMiNmxgh+UQyYW3eDQZEGvBUoTnFoj
 +W3JlBI2s3t6P+TdabfSmM9EOHIXcrktMpAx6Z8ZPVkBgpCN4pW/H43hJYBKtTXrXlNc
 cU0YcDuTzY89LB2/chwHDZe20OZ1MOmyeksmzE80G7z+nWE7K/jmpMIHeolUcG+xslRh
 OdMkZqqVcKl668REH5zuplzsz+5hxYSztvpMIQWLSN9pjFs59J2hBmTmeE+tjuO2FgUP
 0GAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0lqhtlNOacqNuU9HVlYS2QY7iZE+rcKx/NRXadqAqMk=;
 b=SWMoLh0Nz64HAbJSGXrnuk69GoD2FBfa+A/ttIPW/9lKx8XuUAg19plqKMp6JkqaAM
 3Kn2FY9en/nwgrLBB03LIxHNZxcbVRxwkD09Goc7oMqvsSkQVLPTUDjBnsMx6sYATiPT
 SHP7TxAAM5uLx9l67JQgeqgSJ4KqM9534+w40bQWZTvumhUtO/4M56cSF0FrMWTNImsz
 5BSogtYoVccW1PnlU3qa98PiuvgBgYyQbmVE67QpX7M4tDwWlUKaJEfzqCEZKWJY9YUB
 eDHy5V0gL8nSUSOzjJ8v2qX54nyt4OGPBvtK5Cc1Ws5fHGFdPJVvjAhLbAcIgK9xxa8V
 R20A==
X-Gm-Message-State: AOAM531qkg4WQV7SiMMrjsvOpMrhhXjM4cjtanp7GzQxSiY20YOj4aoV
 PUg4lzU0R8xJrLXnM/1/9lgWEqGSg3qyC9SYuh4=
X-Google-Smtp-Source: ABdhPJyjQScV8NzchfGaMSY3StM8W4pyefE41t+e7LgjnMwAVnpBNSxJU4R9UsEIdEPTSE9noHheT+zInrDw6nypnQE=
X-Received: by 2002:a05:6830:33ef:: with SMTP id
 i15mr11028481otu.311.1624048416499; 
 Fri, 18 Jun 2021 13:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210617023109.204591-1-pulehui@huawei.com>
 <fa86062f-cb45-245b-1bf0-494ffcd33908@amd.com>
In-Reply-To: <fa86062f-cb45-245b-1bf0-494ffcd33908@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Jun 2021 16:33:25 -0400
Message-ID: <CADnq5_OOQqWf9yTcSwN=U8+1VbyfD-f_RfhQ+Gura_BJkspZmg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix gcc unused variable warning
To: Harry Wentland <harry.wentland@amd.com>
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
Cc: "Cyr, Aric" <aric.cyr@amd.com>, jinlong zhang <jinlong.zhang@amd.com>,
 Anson Jacob <Anson.Jacob@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Wesley Chalmers <Wesley.Chalmers@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, xinhui pan <Xinhui.Pan@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 zhangjinhao2@huawei.com, Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Pu Lehui <pulehui@huawei.com>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Martin Tsai <martin.tsai@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, Jimmy.Kizito@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgSnVuIDE3LCAyMDIxIGF0IDI6NDMgUE0g
SGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+IHdyb3RlOgo+Cj4gT24gMjAy
MS0wNi0xNiAxMDozMSBwLm0uLCBQdSBMZWh1aSB3cm90ZToKPiA+IEdDQyByZXBvcnRzIHRoZSBm
b2xsb3dpbmcgd2FybmluZyB3aXRoIFc9MToKPiA+Cj4gPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jOjM2MzU6MTc6Cj4gPiB3YXJuaW5n
Ogo+ID4gIHZhcmlhYmxlIOKAmHN0YXR1c+KAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlXQo+ID4gICAzNjM1IHwgIGVudW0gZGNfc3RhdHVzIHN0YXR1cyA9IERD
X0VSUk9SX1VORVhQRUNURUQ7Cj4gPiAgICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+Cj4g
Pgo+ID4gVGhlIHZhcmlhYmxlIHNob3VsZCBiZSB1c2VkIGZvciBlcnJvciBjaGVjaywgbGV0J3Mg
Zml4IGl0Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFB1IExlaHVpIDxwdWxlaHVpQGh1YXdlaS5j
b20+Cj4KPiBSZXZpZXdlZC1ieTogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5j
b20+Cj4KPiBIYXJyeQo+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rX2RwLmMgfCA0ICsrKysKPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX2xpbmtfZHAuYwo+ID4gaW5kZXggZmNiNjM1Yzg1MzMwLi5jZjI5MjY1ODcwYzggMTAw
NjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19saW5r
X2RwLmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bmtfZHAuYwo+ID4gQEAgLTM2ODEsNiArMzY4MSwxMCBAQCBib29sIGRwX3JldHJpZXZlX2x0dHBy
X2NhcChzdHJ1Y3QgZGNfbGluayAqbGluaykKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIERQX0xUX1RVTkFCTEVfUEhZX1JFUEVBVEVSX0ZJRUxEX0RBVEFfU1RSVUNUVVJFX1JFViwK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGx0dHByX2RwY2RfZGF0YSwKPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihsdHRwcl9kcGNkX2RhdGEpKTsKPiA+
ICsgICAgICAgICAgICAgaWYgKHN0YXR1cyAhPSBEQ19PSykgewo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIGRtX2Vycm9yKCIlczogUmVhZCBMVFRQUiBjYXBzIGRhdGEgZmFpbGVkLlxuIiwgX19m
dW5jX18pOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsKPiA+ICsgICAg
ICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgICAgICAgbGluay0+ZHBjZF9jYXBzLmx0dHByX2Nh
cHMucmV2aXNpb24ucmF3ID0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGx0dHBy
X2RwY2RfZGF0YVtEUF9MVF9UVU5BQkxFX1BIWV9SRVBFQVRFUl9GSUVMRF9EQVRBX1NUUlVDVFVS
RV9SRVYgLQo+ID4KPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
