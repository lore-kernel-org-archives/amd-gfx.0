Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4063FC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F3061469
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 06:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F3061469
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8816789E0C;
	Tue, 11 May 2021 06:53:17 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D77689E0C;
 Tue, 11 May 2021 06:53:16 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id c22so26292ejd.12;
 Mon, 10 May 2021 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2jkTp6CRBtUK9Xe7YzSIk6qlU4V38aTXcT5xUBl3Hx0=;
 b=TOUNaz+xsdqPimiz469u/x3purtYPRpRu6hBR8TLs9nUC5429LO7mY/QovOL1CGetx
 0vfxSSIxgPzdCvBgiuxzs/f/IdmuMkS5GK7bp5LaEly41GRegKJoTHJ/+U6NpmkZ32Jl
 KCXYWQQwisf9fsFZSN9LfcL97bmWnXk1typUHtQ68YQTF3CH9uBkvt28fnjV7X+njtVB
 2lz4t/YwrPYWfb2TIPnEwldLbizJ67I6fbJM3hlG7BeOkkgj1bkAaaJJprKxsGJv4V0l
 Iav4m40VIVWWRtrezVGUnmY4pzS+Fv5He53U+Svw4XIqIOqSgIbj1y/VT9xVGPBuy/WS
 sZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2jkTp6CRBtUK9Xe7YzSIk6qlU4V38aTXcT5xUBl3Hx0=;
 b=Mef2QZddb5PCUsvTjt949m+h7B/vYSRtmwO8P9IAhSEjMxmdb5rPSb7Ge/2xJd2ydO
 dGWVz8NrnU5/3puTvpbMLKjOyp4ZyqtyrqyE8xVEBC0roSp5gght3tAUHBBFKZulD0Jh
 457f4zsHeCiH3YuDZKrIb/IKrzJqt7T3IzJ9Z6IayszHRaUtTjLMXUNeWsLQ0la0m37i
 jfohbTA/OqhhNMDAzUnwgfTIY4bPfRA7xP+vtjM3keY8Qqs3UhjiYsatBQB+AQadDSX4
 CGsuuupkB+GbF9xvkYpvEFnsXripNyimelG/Cz1ufOzGkF4M+8CGQe1OEVkVTXhK/2aF
 CxPA==
X-Gm-Message-State: AOAM530xbAcVIfwk9HogMMQqclYIr9iOqUyVm3oe5B8vaSNoErLyDPXJ
 EbhO43fl8hgLs3eDooej/H4=
X-Google-Smtp-Source: ABdhPJyS74P0xsvp+V+uc1STXMetJ1Q2dQ8sWN37hGTxDoTUr8uQnue5LZRPSJSug9rxYuPW/UstOA==
X-Received: by 2002:a17:906:a403:: with SMTP id
 l3mr30693501ejz.251.1620715994883; 
 Mon, 10 May 2021 23:53:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:c3ab:ee01:d547:2c4e?
 ([2a02:908:1252:fb60:c3ab:ee01:d547:2c4e])
 by smtp.gmail.com with ESMTPSA id ch30sm13573570edb.92.2021.05.10.23.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 23:53:14 -0700 (PDT)
Subject: Re: [PATCH v6 12/16] drm/amdgpu: Prevent any job recoveries after
 device is unplugged.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210510163625.407105-1-andrey.grodzovsky@amd.com>
 <20210510163625.407105-13-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eda13789-95c7-42c2-320b-b29d5d95e465@gmail.com>
Date: Tue, 11 May 2021 08:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210510163625.407105-13-andrey.grodzovsky@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDUuMjEgdW0gMTg6MzYgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPiBSZXR1cm4g
RFJNX1RBU0tfU1RBVFVTX0VOT0RFViBiYWNrIHRvIHRoZSBzY2hlZHVsZXIgd2hlbiBkZXZpY2UK
PiBpcyBub3QgcHJlc2VudCBzbyB0aGV5IHRpbWVvdXQgdGltZXIgd2lsbCBub3QgYmUgcmVhcm1l
ZC4KPgo+IHY1OiBVcGRhdGUgdG8gbWF0Y2ggdXBkYXRlZCByZXR1cm4gdmFsdWVzIGluIGVudW0g
ZHJtX2dwdV9zY2hlZF9zdGF0Cj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8
YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmln
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2pvYi5jIHwgMTkgKysrKysrKysrKysrKysrKy0tLQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4gaW5kZXggNzU5YjM0Nzk5MjIxLi5kMzNlNmQ5
N2NjODkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pv
Yi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4gQEAg
LTI1LDYgKzI1LDggQEAKPiAgICNpbmNsdWRlIDxsaW51eC93YWl0Lmg+Cj4gICAjaW5jbHVkZSA8
bGludXgvc2NoZWQuaD4KPiAgIAo+ICsjaW5jbHVkZSA8ZHJtL2RybV9kcnYuaD4KPiArCj4gICAj
aW5jbHVkZSAiYW1kZ3B1LmgiCj4gICAjaW5jbHVkZSAiYW1kZ3B1X3RyYWNlLmgiCj4gICAKPiBA
QCAtMzQsNiArMzYsMTUgQEAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9zdGF0IGFtZGdwdV9q
b2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQo+ICAgCXN0cnVjdCBhbWRn
cHVfam9iICpqb2IgPSB0b19hbWRncHVfam9iKHNfam9iKTsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3Rh
c2tfaW5mbyB0aTsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7
Cj4gKwlpbnQgaWR4Owo+ICsKPiArCWlmICghZHJtX2Rldl9lbnRlcigmYWRldi0+ZGRldiwgJmlk
eCkpIHsKPiArCQlEUk1fSU5GTygiJXMgLSBkZXZpY2UgdW5wbHVnZ2VkIHNraXBwaW5nIHJlY292
ZXJ5IG9uIHNjaGVkdWxlcjolcyIsCj4gKwkJCSBfX2Z1bmNfXywgc19qb2ItPnNjaGVkLT5uYW1l
KTsKPiArCj4gKwkJLyogRWZmZWN0aXZlbHkgdGhlIGpvYiBpcyBhYm9ydGVkIGFzIHRoZSBkZXZp
Y2UgaXMgZ29uZSAqLwo+ICsJCXJldHVybiBEUk1fR1BVX1NDSEVEX1NUQVRfRU5PREVWOwo+ICsJ
fQo+ICAgCj4gICAJbWVtc2V0KCZ0aSwgMCwgc2l6ZW9mKHN0cnVjdCBhbWRncHVfdGFza19pbmZv
KSk7Cj4gICAKPiBAQCAtNDEsNyArNTIsNyBAQCBzdGF0aWMgZW51bSBkcm1fZ3B1X3NjaGVkX3N0
YXQgYW1kZ3B1X2pvYl90aW1lZG91dChzdHJ1Y3QgZHJtX3NjaGVkX2pvYiAqc19qb2IpCj4gICAJ
ICAgIGFtZGdwdV9yaW5nX3NvZnRfcmVjb3ZlcnkocmluZywgam9iLT52bWlkLCBzX2pvYi0+c19m
ZW5jZS0+cGFyZW50KSkgewo+ICAgCQlEUk1fRVJST1IoInJpbmcgJXMgdGltZW91dCwgYnV0IHNv
ZnQgcmVjb3ZlcmVkXG4iLAo+ICAgCQkJICBzX2pvYi0+c2NoZWQtPm5hbWUpOwo+IC0JCXJldHVy
biBEUk1fR1BVX1NDSEVEX1NUQVRfTk9NSU5BTDsKPiArCQlnb3RvIGV4aXQ7Cj4gICAJfQo+ICAg
Cj4gICAJYW1kZ3B1X3ZtX2dldF90YXNrX2luZm8ocmluZy0+YWRldiwgam9iLT5wYXNpZCwgJnRp
KTsKPiBAQCAtNTMsMTMgKzY0LDE1IEBAIHN0YXRpYyBlbnVtIGRybV9ncHVfc2NoZWRfc3RhdCBh
bWRncHVfam9iX3RpbWVkb3V0KHN0cnVjdCBkcm1fc2NoZWRfam9iICpzX2pvYikKPiAgIAo+ICAg
CWlmIChhbWRncHVfZGV2aWNlX3Nob3VsZF9yZWNvdmVyX2dwdShyaW5nLT5hZGV2KSkgewo+ICAg
CQlhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHJpbmctPmFkZXYsIGpvYik7Cj4gLQkJcmV0dXJu
IERSTV9HUFVfU0NIRURfU1RBVF9OT01JTkFMOwo+ICAgCX0gZWxzZSB7Cj4gICAJCWRybV9zY2hl
ZF9zdXNwZW5kX3RpbWVvdXQoJnJpbmctPnNjaGVkKTsKPiAgIAkJaWYgKGFtZGdwdV9zcmlvdl92
ZihhZGV2KSkKPiAgIAkJCWFkZXYtPnZpcnQudGRyX2RlYnVnID0gdHJ1ZTsKPiAtCQlyZXR1cm4g
RFJNX0dQVV9TQ0hFRF9TVEFUX05PTUlOQUw7Cj4gICAJfQo+ICsKPiArZXhpdDoKPiArCWRybV9k
ZXZfZXhpdChpZHgpOwo+ICsJcmV0dXJuIERSTV9HUFVfU0NIRURfU1RBVF9OT01JTkFMOwo+ICAg
fQo+ICAgCj4gICBpbnQgYW1kZ3B1X2pvYl9hbGxvYyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwgdW5zaWduZWQgbnVtX2licywKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
