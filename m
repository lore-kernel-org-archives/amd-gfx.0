Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5343AC5DF60
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 09:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7D82166E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 09:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7D82166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95A66F3C3;
	Thu,  7 Nov 2019 09:21:45 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A2D6F3C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 09:21:44 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id a11so2134450wra.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 01:21:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=iuzLZJua0/Ei169HqYF1ueXWyWEXjaQZjOxEkhO9seQ=;
 b=MKx+5igcckU5EBuydoI+t5xm7PmZTGub8skjNcfw0nqOSQp6lQTf+HtM1d5mQlJcow
 fzzhQr4+nJGpezw5qsxpF9ZzWmY5pQ10n14XPCu0P89qSLHLOV7tX3Xp46FKOIYvYVLl
 QytaFUoaQQ0EdgYgBEKoXHZtp6MbaFnQeFEyyJN1C8G9VFBgmNCPPQyC8xTWpCyFaVAi
 nF96J/7wGdmlepY2jaEHCIx54na3/8/uYoJJhuuCMgNxX9ulIoLXDlKVeNuQy8tQdyuS
 BJu5Ye5UK7OCVTEUKr0AXSllavPCtSo6hGRVUi+FTHUV6SiSP0s9HqQnwuxf6xQqyk5c
 8/dQ==
X-Gm-Message-State: APjAAAVsbHuUHOlC0QkA84BCz/vDYphuajXUoqCekbPNAG1kijzpc5Oy
 F3urXWhOycmw1KVsja/WvrM=
X-Google-Smtp-Source: APXvYqxIVxoYjxFrbK88bXYuyQXBB8KRfA5TVhWTcPQZyqQToWIL6bovSnZjs5O07WuBJM/NmsbWzQ==
X-Received: by 2002:adf:f651:: with SMTP id x17mr1947078wrp.114.1573118502732; 
 Thu, 07 Nov 2019 01:21:42 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id h205sm1474736wmf.35.2019.11.07.01.21.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 07 Nov 2019 01:21:42 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure
To: "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1e2cd740-f023-cc9d-42b8-338f08c3333d@gmail.com>
Date: Thu, 7 Nov 2019 10:21:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=iuzLZJua0/Ei169HqYF1ueXWyWEXjaQZjOxEkhO9seQ=;
 b=e/ZP9ONB8Q8Rg8QTrVCHZAqJFdhrSpA9jjHJ/OSP5XBAPu63rSNK/chlwJ/FYsUnvQ
 qIfcAFHtYmrNcxI1EeoA1jfeoCRHwXwY+gtoV95sJmHdVAIkhlDVznFDOlz6x82jkHte
 zCf+KzjBnsUo7iBDNrLWwF3cTdqlmI1lBjIXeXsZtt1Xsvqml9PiBJEojXb1T2JbAEPF
 o64cXqC6frLBifpAHJRUcRde+F1W7Q+iYIZiMist4IuOH6F8nc2eSNhicRegr2Zdz6yp
 Z4foFmwrocwpFt6lqULRTS04cZlWmukYkzi6Ru3NyYrKRgnacfLDfpCXI+jkB86LiTMf
 bf8g==
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107092141.KVBFREMFEHadyfN1W_ktrqIuSZIiD_uCO8J1oyOqa4k@z>

QW0gMDYuMTEuMTkgdW0gMTg6MjYgc2NocmllYiBaZW5nLCBPYWs6Cj4gRXhwbGFpbiBmaWVsZHMg
bGlrZSBhcGVyX2Jhc2UsIGFncF9zdGFydCBldGMuIFRoZSBkZWZpbml0aW9uCj4gb2YgdGhvc2Ug
ZmllbGRzIGFyZSBjb25mdXNpbmcgYXMgdGhleSBhcmUgZnJvbSBkaWZmZXJlbnQgdmlldwo+IChD
UFUgb3IgR1BVKS4gQWRkIGNvbW1lbnRzIGZvciBlYXNpZXIgdW5kZXJzdGFuZC4KPgo+IENoYW5n
ZS1JZDogSTAyYzJhMjdjZDBkYmMyMDU0OThlYjg2YWFmYTcyMmYyZTBjMjVmZTYKPiBTaWduZWQt
b2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+IGluZGV4IDU1NWQ4ZTUuLjEzNTZmZjkgMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4gQEAgLTEyNywxOCArMTI3
LDQ0IEBAIHN0cnVjdCBhbWRncHVfeGdtaSB7Cj4gICB9Owo+ICAgCj4gICBzdHJ1Y3QgYW1kZ3B1
X2dtYyB7Cj4gKwkvKiBGQidzIHBoeXNpY2FsIGFkZHJlc3MgaW4gTU1JTyBzcGFjZSAoZm9yIENQ
VSB0bwo+ICsJICogbWFwIEZCKS4gVGhpcyBpcyBkaWZmZXJlbnQgY29tcGFyZWQgdG8gdGhlIGFw
Zy8KPiArCSAqIGdhcnQvdnJhbV9zdGFydC9lbmQgZmllbGQgYXMgdGhlIGxhdGVyIGlzIGZyb20K
PiArCSAqIEdQVSdzIHZpZXcgYW5kIGFwZXJfYmFzZSBpcyBmcm9tIENQVSdzIHZpZXcuCj4gKwkg
Ki8KPiAgIAlyZXNvdXJjZV9zaXplX3QJCWFwZXJfc2l6ZTsKPiAgIAlyZXNvdXJjZV9zaXplX3QJ
CWFwZXJfYmFzZTsKPiAgIAkvKiBmb3Igc29tZSBjaGlwcyB3aXRoIDw9IDMyTUIgd2UgbmVlZCB0
byBsaWUKPiAgIAkgKiBhYm91dCB2cmFtIHNpemUgbmVhciBtYyBmYiBsb2NhdGlvbiAqLwo+ICAg
CXU2NAkJCW1jX3ZyYW1fc2l6ZTsKPiAgIAl1NjQJCQl2aXNpYmxlX3ZyYW1fc2l6ZTsKPiArCS8q
IEFQRyBhcGVydHVyZSBzdGFydCBhbmQgZW5kIGluIE1DIGFkZHJlc3Mgc3BhY2UKPiArCSAqIERy
aXZlciBmaW5kIGEgaG9sZSBpbiB0aGUgTUMgYWRkcmVzcyBzcGFjZQo+ICsJICogdG8gcGxhY2Ug
QUdQIGJ5IHNldHRpbmcgTUNfVk1fQUdQX0JPVC9UT1AgcmVnaXN0ZXJzCj4gKwkgKiBVbmRlciBW
TUlEMCwgbG9naWNhbCBhZGRyZXNzID09IE1DIGFkZHJlc3MKPiArCSAqIEFHUCBhcGVydHVyZSBp
cyB1c2VkIHRvIHNpbXVsYXRlIEZCIGluIFpGQiBjYXNlCj4gKwkgKi8KClJlYWxseSBuaWNlIGlt
cHJvdmVtZW50LiBBbGV4IG5vdGVkIGFzIHdlbGwgcGxlYXNlIG1lbnRpb24gdGhlIHBhZ2UgCnRh
YmxlIHVzZSBjYXNlIGhlcmUgYXMgd2VsbC4KCkFkZGl0aW9uYWwgdG8gdGhhdCB3ZSBhbHNvIGhh
dmUgYSB1c2UgY2FzZSBmb3IgZGlzcGxheSBzY2Fub3V0LCBidXQgdGhhdCAKb25lIGlzIGN1cnJl
bnRseSBub3QgaW1wbGVtZW50ZWQgeWV0LiBNaWdodCBiZSBhIGdvb2QgaWRlYSB0byBtZW50aW9u
IAp0aGF0IGFzIHdlbGwuCgpXaXRoIHRoYXQgZml4ZWQgdGhlIHBhdGNoIGlzIFJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KClJlZ2FyZHMs
CkNocmlzdGlhbi4KCj4gICAJdTY0CQkJYWdwX3NpemU7Cj4gICAJdTY0CQkJYWdwX3N0YXJ0Owo+
ICAgCXU2NAkJCWFncF9lbmQ7Cj4gKwkvKiBHQVJUIGFwZXJ0dXJlIHN0YXJ0IGFuZCBlbmQgaW4g
TUMgYWRkcmVzcyBzcGFjZQo+ICsJICogRHJpdmVyIGZpbmQgYSBob2xlIGluIHRoZSBNQyBhZGRy
ZXNzIHNwYWNlCj4gKwkgKiB0byBwbGFjZSBHQVJUIGJ5IHNldHRpbmcgVk1fQ09OVEVYVDBfUEFH
RV9UQUJMRV9TVEFSVC9FTkRfQUREUgo+ICsJICogcmVnaXN0ZXJzCj4gKwkgKiBVbmRlciBWTUlE
MCwgbG9naWNhbCBhZGRyZXNzIGluc2lkZSBHQVJUIGFwZXJ0dXJlIHdpbGwKPiArCSAqIGJlIHRy
YW5zbGF0ZWQgdGhyb3VnaCBncHV2bSBnYXJ0IHBhZ2UgdGFibGUgdG8gYWNjZXNzCj4gKwkgKiBw
YWdlZCBzeXN0ZW0gbWVtb3J5Cj4gKwkgKi8KPiAgIAl1NjQJCQlnYXJ0X3NpemU7Cj4gICAJdTY0
CQkJZ2FydF9zdGFydDsKPiAgIAl1NjQJCQlnYXJ0X2VuZDsKPiArCS8qIEZyYW1lIGJ1ZmZlciBh
cGVydHVyZSBvZiB0aGlzIEdQVSBkZXZpY2UuIERpZmZlcmVudCBmcm9tCj4gKwkgKiBmYl9zdGFy
dCAoc2VlIGJlbG93KSwgdGhpcyBvbmx5IGNvdmVycyB0aGUgbG9jYWwgR1BVIGRldmljZS4KPiAr
CSAqIERyaXZlciBnZXQgZmJfc3RhcnQgZnJvbSBNQ19WTV9GQl9MT0NBVElPTl9CQVNFIChzZXQg
YnkgdmJpb3MpCj4gKwkgKiBhbmQgY2FsY3VsYXRlIHZyYW1fc3RhcnQgb2YgdGhpcyBsb2NhbCBk
ZXZpY2UgYnkgYWRkaW5nIGFuCj4gKwkgKiBvZmZzZXQgaW5zaWRlIHRoZSBYR01JIGhpdmUuCj4g
KwkgKiBVbmRlciBWTUlEMCwgbG9naWNhbCBhZGRyZXNzID09IE1DIGFkZHJlc3MKPiArCSAqLwo+
ICAgCXU2NAkJCXZyYW1fc3RhcnQ7Cj4gICAJdTY0CQkJdnJhbV9lbmQ7Cj4gICAJLyogRkIgcmVn
aW9uICwgaXQncyBzYW1lIGFzIGxvY2FsIHZyYW0gcmVnaW9uIGluIHNpbmdsZSBHUFUsIGluIFhH
TUkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
