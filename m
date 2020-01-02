Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE367C2D0C2
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 18:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C56F521582
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 18:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEEPNFfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C56F521582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8208F6E0BE;
	Thu,  2 Jan 2020 18:13:13 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60086E0BE
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 18:13:12 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id d16so40080466wre.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2020 10:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=w8aIuaXlPScfq6ZtovG63DpU5cpyrLE8agQS+SGF8e8=;
 b=BEEPNFfaMAKHRPiS9h4BMRGdsIDNLdk9LPyY3C305aWXxgDgcRBA+7d386gHriHxEt
 qlLzv9AW/uLXiIFk4ouHqzUtdinlmcGpRCjgzinxA99wfK5iESapbPrU7wKaMv0DTTXH
 nOtLVMv6w9M2sO2LxF9o9BKCw4qrOSCwdmNfmxi70dxHUU62UDpiDvJF1GRWaOiylt/N
 u/IqiJavfl4Lv9YaA5sEDplOb5smIJoK6Wxqve2xmEB/XAFGTiAtPwnnTI8XFqHvADCN
 OFvc5DXlODSycLzTcoqX/as/gZdJpVmGW3FRtpRKG3tAcjfxQW4yT2BnFWjHAkR+pC8s
 QVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=w8aIuaXlPScfq6ZtovG63DpU5cpyrLE8agQS+SGF8e8=;
 b=mF4TEonwj12PdZ56GpmofKB+lZEFhwqtED9KFUnBnakVQ9YPV9jwNaBbEvj8tP2aK/
 djzefnFPfCGabnbcxdjLV91hCkR8MZFz0SFP4yotRrt6nSBRxS/llQSpPwbvE5MBsU43
 x8ln3YUPYe90ImaCzBIHCZmJXPsOyZjlsux/Jh/UsFXj4lh8lpcxGnwDguPuN0uMVW5V
 wQan+l8HHRNXe/phXkZIYF5q6Zy8Kq/hbSiOK5YfAXwP/fxBSg7DgUl+xR6qhf1X4B1q
 GBk+TFCt1CBpzNLXaPkVogo3H3ZcQfz20CGuvbfBENOUrAzw8oWBrhbGcqm65DK3/x/u
 a5Kw==
X-Gm-Message-State: APjAAAUrKNWpxqE/kiwNyIxS+d0kvCckdt8w8qxYGDurkpnhepsDtZ4Z
 LMWJhubhFmUpwErRgoWTUFg=
X-Google-Smtp-Source: APXvYqySE+A3w8xq7RvwQP/NdgZPr+qSpHydZjMP5/LYW1oB+oK3IRv/MJtFOPdGcSH5JuibzQaYKA==
X-Received: by 2002:adf:f484:: with SMTP id l4mr83263574wro.207.1577988791346; 
 Thu, 02 Jan 2020 10:13:11 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t1sm9256741wma.43.2020.01.02.10.13.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Jan 2020 10:13:10 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/amdgpu: fix ctx init failure for asics without
 gfx ring
To: Nirmoy <nirmodas@amd.com>, christian.koenig@amd.com, Le Ma
 <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <1576755748-9800-1-git-send-email-le.ma@amd.com>
 <468e6ef3-e08c-17ad-8c83-f3efc3b04f85@amd.com>
 <cb750a50-6f57-316f-e8fd-14e39112ba53@gmail.com>
 <d0bb3341-c4c3-00be-87c1-20c3408340d1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ec36056a-4d95-7b56-f24f-72045c66b68b@gmail.com>
Date: Thu, 2 Jan 2020 19:13:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d0bb3341-c4c3-00be-87c1-20c3408340d1@amd.com>
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
Cc: Feifei.Xu@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDEuMjAgdW0gMTA6NDcgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAxLzEvMjAgMTo1MiBQ
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTkuMTIuMTkgdW0gMTM6MDEgc2Nocmll
YiBOaXJtb3k6Cj4+PiBSZXZpZXdlZC1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29t
Pgo+Pj4KPj4+IE9uIDEyLzE5LzE5IDEyOjQyIFBNLCBMZSBNYSB3cm90ZToKPj4+PiBUaGlzIHdv
cmthcm91bmQgZG9lcyBub3QgYWZmZWN0IG90aGVyIGFzaWNzIGJlY2F1c2UgYW1kZ3B1IG9ubHkg
Cj4+Pj4gbmVlZCBleHBvc2UKPj4+PiBvbmUgZ2Z4IHNjaGVkIHRvIHVzZXIgZm9yIG5vdy4KPj4+
Pgo+Pj4+IENoYW5nZS1JZDogSWNhOTJiODU2NWE4OTg5OWFlYmUwZWJhN2IyYjVhMjUxNTliNDEx
ZDMKPj4+PiBTaWduZWQtb2ZmLWJ5OiBMZSBNYSA8bGUubWFAYW1kLmNvbT4KPj4+PiAtLS0KPj4+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgfCAzICsrLQo+Pj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMg
Cj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKPj4+PiBpbmRl
eCA2M2Y2MzY1Li42NGUyYmFiIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jdHguYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9jdHguYwo+Pj4+IEBAIC0xMjcsNyArMTI3LDggQEAgc3RhdGljIGludCBhbWRncHVf
Y3R4X2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgCj4+Pj4gKmFkZXYsCj4+Pj4gwqAgwqDCoMKg
wqDCoMKgwqDCoMKgIHN3aXRjaCAoaSkgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIEFN
REdQVV9IV19JUF9HRlg6Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWRzID0gYWRl
di0+Z2Z4LmdmeF9zY2hlZDsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzY2hlZCA9ICZh
ZGV2LT5nZnguZ2Z4X3JpbmdbMF0uc2NoZWQ7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c2NoZWRzID0gJnNjaGVkOwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9zY2hl
ZHMgPSAxOwo+Pgo+PiBNaG0sIHdlIHNob3VsZCBwcm9iYWJseSByYXRoZXIgZml4IHRoaXMgaGVy
ZSBhbmQgZG9uJ3QgZXhwb3NlIGEgR0ZYIAo+PiByaW5nIHdoZW4gdGhlIGhhcmR3YXJlIGRvZXNu
J3QgaGF2ZSBvbmUuCj4gSGkgQ2hyaXN0aWFuLAo+Cj4gRG8geW91IG1lYW4gYnkgbm90IGluaXRp
YWxpemluZyBlbnRpdHkgZm9yIGdmeCB3aGVuIG5vdCBhdmFpbGFibGU/CgpXZWxsIHdlIHN0aWxs
IGluaXRpYWxpemUgaXQsIGJ1dCB3aXRoIG51bV9zY2hlZHM9MC4KCkNocmlzdGlhbi4KCj4KPgo+
Pgo+PiBDaHJpc3RpYW4uCj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgQU1ER1BVX0hXX0lQX0NPTVBVVEU6Cj4+PiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdm
eCBtYWlsaW5nIGxpc3QKPj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRw
czovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsaXN0cy5mcmVlZGVza3RvcC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtZ2Z4
JmFtcDtkYXRhPTAyJTdDMDElN0NuaXJtb3kuZGFzJTQwYW1kLmNvbSU3Q2JjNWZhNDk4ZWZlODRm
Y2ZiMDBiMDhkNzhlYjk3MDQ5JTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0Mw
JTdDMCU3QzYzNzEzNDc5OTQyMTI5MTM0NyZhbXA7c2RhdGE9Rnhrd2FDcmJJVjI4SEgxOHhvcmd3
bXpSUENNQTFJOUlrUmtnRTFMRjgwWSUzRCZhbXA7cmVzZXJ2ZWQ9MCAKPj4+Cj4+Cj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
