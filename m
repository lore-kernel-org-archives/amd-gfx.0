Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0606C33CB1
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 08:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A39207FD
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf9qGrs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A39207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F206E2F2;
	Tue, 14 Jan 2020 08:32:09 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37C566E2F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 08:32:08 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id b19so12671715wmj.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 00:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9w4ySTOoqNWd1MCifCTSjAbMe1XqhtSBlFZQ4eaf0b8=;
 b=Gf9qGrs7Y2Ga3U4K16aRM1MVuAIs8D2P3lP1AYjtJNIFCE7ChW09frfL+oLj2bAly6
 eRK5E5N04RBgZPJzQGQ6fNwZBvQXAdUeMdFMTYMoGZwfLaxYbyQpXshvesC+tmS/eQVh
 cOOtEnWHlfSDtj8zZG1GqMLM6YKtgDIO4y/djFlK0st3KcwA4t0SOydoRw4Peh06PYHm
 myTdlYA4R38AXSjJOEDg8ga2cOJgUou2jPaMpm1BqagKtFPKbr5cLnv0f05VsMMjzHJS
 UCdGD0+9/KZzBoQ2aSJEDIEpLbZ9EBWq3lyuUKAI183UlsnSxb22ODxqQPKxI4l2iDq5
 bDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9w4ySTOoqNWd1MCifCTSjAbMe1XqhtSBlFZQ4eaf0b8=;
 b=m701KBTkt7iMSeQ7amF2HL/Nw7ZIL3/l9lPd8Vx9i4HboYDyoqOu4Cl8D+L3N2s4Vf
 OfOHa5SXH6qwTVYO9FHhuKW6IoHptqZmZ1YiR09+QihGIHXbhjuo7g5hvWr2kZRcQxgY
 NfuPod/W2xwwgpw7LeOhBx6T+3Eb1JUDN7FfqiEop7xxCgOboNdNTnzPdWwBiMpITB/I
 /CmO5vSpnItNLTd38rVPHyeE7zfk4v5jglb6ZoLMFYayNEYBQ/HBg5bmODkwYB40fIjl
 NtokOahBtJWZoIjL7dJzFrW0rHZFMwEJWerWIRenFnih+ricJ/NEfC4eBi5KUHt6ZKo6
 CMaw==
X-Gm-Message-State: APjAAAXO7MqeDOcM9FeUFgfBLuiYn7S3fMqvzO/cghoVwig5UdA7OkmC
 lMO4h/PLvfuCpmjnT6uMAv4Mbbkt
X-Google-Smtp-Source: APXvYqzqADHNAMqT7Zyv4IJYxkI5veTs+e6ZJpjn4QaWgEiSWHMzQ9HPoScZKd3PrqT7yp5FF9xMeA==
X-Received: by 2002:a1c:6389:: with SMTP id
 x131mr23913714wmb.155.1578990726716; 
 Tue, 14 Jan 2020 00:32:06 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y20sm17207416wmi.25.2020.01.14.00.32.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jan 2020 00:32:06 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: modify packet size for pm4 flush tlbs
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200114034359.33644-1-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <85c29f79-57ac-2ebd-2f22-d85b8e10701e@gmail.com>
Date: Tue, 14 Jan 2020 09:32:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200114034359.33644-1-alex.sierra@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDEuMjAgdW0gMDQ6NDMgc2NocmllYiBBbGV4IFNpZXJyYToKPiBbV2h5XQo+IFBNNCBw
YWNrZXQgc2l6ZSBmb3IgZmx1c2ggbWVzc2FnZSB3YXMgb3ZlcnNpemVkLgo+Cj4gW0hvd10KPiBQ
YWNrZXQgc2l6ZSBhZGp1c3RlZCB0byBhbGxvY2F0ZSBmbHVzaCArIGZlbmNlIHBhY2tldHMuCj4K
PiBDaGFuZ2UtSWQ6IEk5YTU3N2QyMTE4Mzk4YjMxMzkwMTE4MjlkZTEyNzg5YjJhNTc3YTE5Cj4g
U2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+CgpSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMiArLQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYyAgfCAyICstCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyB8IDMgKystCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nbWNfdjlfMC5jICB8IDMgKystCj4gICA0IGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTBfMC5jCj4gaW5kZXggZDcyYjYwZjk5N2M4Li5iMTVhMDFiZjRiMTUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+IEBAIC0zNjksNyArMzY5LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBraXFfcG00X2Z1bmNzIGdmeF92MTBfMF9raXFfcG00X2Z1bmNzID0g
ewo+ICAgCS5tYXBfcXVldWVzX3NpemUgPSA3LAo+ICAgCS51bm1hcF9xdWV1ZXNfc2l6ZSA9IDYs
Cj4gICAJLnF1ZXJ5X3N0YXR1c19zaXplID0gNywKPiAtCS5pbnZhbGlkYXRlX3RsYnNfc2l6ZSA9
IDEyLAo+ICsJLmludmFsaWRhdGVfdGxic19zaXplID0gMiwKPiAgIH07Cj4gICAKPiAgIHN0YXRp
YyB2b2lkIGdmeF92MTBfMF9zZXRfa2lxX3BtNF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiBpbmRleCA0NGNkYjZm
YzkyZmYuLmUxOTU2ZWJiMDliOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjlfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwo+IEBAIC04NTksNyArODU5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBraXFfcG00X2Z1
bmNzIGdmeF92OV8wX2tpcV9wbTRfZnVuY3MgPSB7Cj4gICAJLm1hcF9xdWV1ZXNfc2l6ZSA9IDcs
Cj4gICAJLnVubWFwX3F1ZXVlc19zaXplID0gNiwKPiAgIAkucXVlcnlfc3RhdHVzX3NpemUgPSA3
LAo+IC0JLmludmFsaWRhdGVfdGxic19zaXplID0gMTIsCj4gKwkuaW52YWxpZGF0ZV90bGJzX3Np
emUgPSAyLAo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfc2V0X2tpcV9wbTRf
ZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ21jX3YxMF8wLmMKPiBpbmRleCA4YWZkMDU4MzQ3MTQuLjBjNWJmM2JkNjQwZiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4gQEAgLTQxOCw3ICs0MTgsOCBA
QCBzdGF0aWMgaW50IGdtY192MTBfMF9mbHVzaF9ncHVfdGxiX3Bhc2lkKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAo+ICAgCj4gICAJaWYgKGFtZGdwdV9lbXVfbW9kZSA9PSAwICYmIHJpbmct
PnNjaGVkLnJlYWR5KSB7Cj4gICAJCXNwaW5fbG9jaygmYWRldi0+Z2Z4LmtpcS5yaW5nX2xvY2sp
Owo+IC0JCWFtZGdwdV9yaW5nX2FsbG9jKHJpbmcsIGtpcS0+cG1mLT5pbnZhbGlkYXRlX3RsYnNf
c2l6ZSk7Cj4gKwkJLyogMiBkd29yZHMgZmx1c2ggKyA4IGR3b3JkcyBmZW5jZSAqLwo+ICsJCWFt
ZGdwdV9yaW5nX2FsbG9jKHJpbmcsIGtpcS0+cG1mLT5pbnZhbGlkYXRlX3RsYnNfc2l6ZSArIDgp
Owo+ICAgCQlraXEtPnBtZi0+a2lxX2ludmFsaWRhdGVfdGxicyhyaW5nLAo+ICAgCQkJCQlwYXNp
ZCwgZmx1c2hfdHlwZSwgYWxsX2h1Yik7Cj4gICAJCWFtZGdwdV9mZW5jZV9lbWl0X3BvbGxpbmco
cmluZywgJnNlcSk7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dt
Y192OV8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4gaW5kZXgg
NDBhNDk2ODA0MzU2Li41NGJkYzE3ODZhYjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dtY192OV8wLmMKPiBAQCAtNTc4LDcgKzU3OCw4IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfZmx1
c2hfZ3B1X3RsYl9wYXNpZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAo+ICAgCWlm
IChyaW5nLT5zY2hlZC5yZWFkeSkgewo+ICAgCQlzcGluX2xvY2soJmFkZXYtPmdmeC5raXEucmlu
Z19sb2NrKTsKPiAtCQlhbWRncHVfcmluZ19hbGxvYyhyaW5nLCBraXEtPnBtZi0+aW52YWxpZGF0
ZV90bGJzX3NpemUpOwo+ICsJCS8qIDIgZHdvcmRzIGZsdXNoICsgOCBkd29yZHMgZmVuY2UgKi8K
PiArCQlhbWRncHVfcmluZ19hbGxvYyhyaW5nLCBraXEtPnBtZi0+aW52YWxpZGF0ZV90bGJzX3Np
emUgKyA4KTsKPiAgIAkJa2lxLT5wbWYtPmtpcV9pbnZhbGlkYXRlX3RsYnMocmluZywKPiAgIAkJ
CQkJcGFzaWQsIGZsdXNoX3R5cGUsIGFsbF9odWIpOwo+ICAgCQlhbWRncHVfZmVuY2VfZW1pdF9w
b2xsaW5nKHJpbmcsICZzZXEpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
