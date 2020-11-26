Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A4DC56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 15:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9E7721D46
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 15:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQrjIXs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9E7721D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F80F6E967;
	Thu, 26 Nov 2020 15:49:40 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE066E98B;
 Thu, 26 Nov 2020 15:49:39 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id r22so2748543edw.6;
 Thu, 26 Nov 2020 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=QN+FVEUZmyt5RNWeA1F05R4E4PnEkkh79B7aisQ+j0w=;
 b=ZQrjIXs1Nx119suE8bD/Ex3bf6zv/BatTKXOVIdqnXbc+YpCCiDPWz5vgYRye2CvfI
 zrmf16r62UmseT3q88s14ko9tr6mwTKfKMOMgdidN90I59tMWGY3aA6u4nzg0JR6E8xH
 RCRooUei4Da1wl2pltkcps6jTm0GMYRs7cJSwZMGwr97U1TMb8+0QYeOtmrWjlJrGAAZ
 323LJ09AEfQyYdcFbAn5q07Eyw5dnU3lP4Ul58QepC/UZBqKp+mxR2PveGiDvlC1CudR
 q+yj4sP3GkS1bJDe8B4Dm2tCwZxZncizdpn3B3Em16HQBCmzXmroxeeREbAXYslEDlco
 JtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QN+FVEUZmyt5RNWeA1F05R4E4PnEkkh79B7aisQ+j0w=;
 b=SNIZTHyrzqXf0NvanqOi/R/nTmazcm/YZRR6cHDJoAdeNvUnpeIbh8lfJhqM1EUZre
 BwaPeuVvidUgX5o9HTDK/Sk1m0tPbLeaN5Nyn3+xSXuBpu5LPYTfdMxgY4NRmLuLNcPZ
 8bKWU9v8N3BtZqbtORoyYTF5KyuxFYFiofcExBKmU/RuIIuh3kt+o3zwWFEp3qE6/8bl
 h2mz3lQy+6xqGaKCWur1G7XEZjTeaHiiZsOnXN6pEsPPnhnESbmJoXSSqfDSZCCU+mza
 Ap1FckORVl/pGpCOPQ3vC/BLedVxDhnoEBbrDZ+FcCtfm8fuiPwMSc20gHqkAXw+UNTr
 1iSA==
X-Gm-Message-State: AOAM5325/fdcIcZWgS+F775nlt3vXaLII9GITcJ3Pf62CgCYc5pv6tni
 9GbE8kTOkTegPNd6js2pfYlf9vNrans=
X-Google-Smtp-Source: ABdhPJz3j4i/kB0kZ9vsUXS3qGSYxj3KG4rsfCqJ3yEXbotkjgGRHwtq9x1V7qyDk1NiNHW/nZ3fOQ==
X-Received: by 2002:a50:c30d:: with SMTP id a13mr3119176edb.89.1606405778568; 
 Thu, 26 Nov 2020 07:49:38 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c30sm3476014edd.68.2020.11.26.07.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2020 07:49:37 -0800 (PST)
Subject: Re: [PATCH] drm/radeon: fix check order in radeon_bo_move
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20201125143424.1434-1-christian.koenig@amd.com>
Message-ID: <a16cc4d6-4a23-eb91-7d44-cf3ccac88db4@gmail.com>
Date: Thu, 26 Nov 2020 16:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125143424.1434-1-christian.koenig@amd.com>
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
Cc: airlied@linux.ie
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UGluZywgRGF2ZSB0aGlzIGlzIGFub3RoZXIgZml4IGZvciB0aGUgTXVsdGlob3AgcGF0Y2ggc2V0
LgoKV2l0aG91dCBpdCByYWRlb24gaXMgY29tcGxldGVseSBicm9rZW4gb24gZHJtLW1pc2MtbmV4
dC4KClRoYW5rcywKQ2hyaXN0aWFuLgoKQW0gMjUuMTEuMjAgdW0gMTU6MzQgc2NocmllYiBDaHJp
c3RpYW4gS8O2bmlnOgo+IFJlb3JkZXIgdGhlIGNvZGUgdG8gZml4IGNoZWNraW5nIGlmIGJsaXR0
aW5nIGlzIGF2YWlsYWJsZS4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3R0bS5jIHwgNTQgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX3R0bS5jCj4gaW5kZXggMGNhMzgxYjk1ZDNkLi4yYjU5ODE0MTIyNWYg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwo+IEBAIC0yMTYsMjcgKzIxNiwx
NSBAQCBzdGF0aWMgaW50IHJhZGVvbl9ib19tb3ZlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAq
Ym8sIGJvb2wgZXZpY3QsCj4gICAJc3RydWN0IHR0bV9yZXNvdXJjZSAqb2xkX21lbSA9ICZiby0+
bWVtOwo+ICAgCWludCByOwo+ICAgCj4gLQlpZiAoKG9sZF9tZW0tPm1lbV90eXBlID09IFRUTV9Q
TF9TWVNURU0gJiYKPiAtCSAgICAgbmV3X21lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1ZSQU0pIHx8
Cj4gLQkgICAgKG9sZF9tZW0tPm1lbV90eXBlID09IFRUTV9QTF9WUkFNICYmCj4gLQkgICAgIG5l
d19tZW0tPm1lbV90eXBlID09IFRUTV9QTF9TWVNURU0pKSB7Cj4gLQkJaG9wLT5mcGZuID0gMDsK
PiAtCQlob3AtPmxwZm4gPSAwOwo+IC0JCWhvcC0+bWVtX3R5cGUgPSBUVE1fUExfVFQ7Cj4gLQkJ
aG9wLT5mbGFncyA9IDA7Cj4gLQkJcmV0dXJuIC1FTVVMVElIT1A7Cj4gLQl9Cj4gLQo+ICAgCWlm
IChuZXdfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVFQpIHsKPiAgIAkJciA9IHJhZGVvbl90dG1f
dHRfYmluZChiby0+YmRldiwgYm8tPnR0bSwgbmV3X21lbSk7Cj4gICAJCWlmIChyKQo+ICAgCQkJ
cmV0dXJuIHI7Cj4gICAJfQo+IC0JcmFkZW9uX2JvX21vdmVfbm90aWZ5KGJvLCBldmljdCwgbmV3
X21lbSk7Cj4gICAKPiAgIAlyID0gdHRtX2JvX3dhaXRfY3R4KGJvLCBjdHgpOwo+ICAgCWlmIChy
KQo+IC0JCWdvdG8gZmFpbDsKPiArCQlyZXR1cm4gcjsKPiAgIAo+ICAgCS8qIENhbid0IG1vdmUg
YSBwaW5uZWQgQk8gKi8KPiAgIAlyYm8gPSBjb250YWluZXJfb2YoYm8sIHN0cnVjdCByYWRlb25f
Ym8sIHRibyk7Cj4gQEAgLTI0NiwxMiArMjM0LDEyIEBAIHN0YXRpYyBpbnQgcmFkZW9uX2JvX21v
dmUoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywgYm9vbCBldmljdCwKPiAgIAlyZGV2ID0g
cmFkZW9uX2dldF9yZGV2KGJvLT5iZGV2KTsKPiAgIAlpZiAob2xkX21lbS0+bWVtX3R5cGUgPT0g
VFRNX1BMX1NZU1RFTSAmJiBiby0+dHRtID09IE5VTEwpIHsKPiAgIAkJdHRtX2JvX21vdmVfbnVs
bChibywgbmV3X21lbSk7Cj4gLQkJcmV0dXJuIDA7Cj4gKwkJZ290byBvdXQ7Cj4gICAJfQo+ICAg
CWlmIChvbGRfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfU1lTVEVNICYmCj4gICAJICAgIG5ld19t
ZW0tPm1lbV90eXBlID09IFRUTV9QTF9UVCkgewo+ICAgCQl0dG1fYm9fbW92ZV9udWxsKGJvLCBu
ZXdfbWVtKTsKPiAtCQlyZXR1cm4gMDsKPiArCQlnb3RvIG91dDsKPiAgIAl9Cj4gICAKPiAgIAlp
ZiAob2xkX21lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1RUICYmCj4gQEAgLTI1OSwzMSArMjQ3LDM3
IEBAIHN0YXRpYyBpbnQgcmFkZW9uX2JvX21vdmUoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bywgYm9vbCBldmljdCwKPiAgIAkJcmFkZW9uX3R0bV90dF91bmJpbmQoYm8tPmJkZXYsIGJvLT50
dG0pOwo+ICAgCQl0dG1fcmVzb3VyY2VfZnJlZShibywgJmJvLT5tZW0pOwo+ICAgCQl0dG1fYm9f
YXNzaWduX21lbShibywgbmV3X21lbSk7Cj4gLQkJcmV0dXJuIDA7Cj4gKwkJZ290byBvdXQ7Cj4g
ICAJfQo+IC0JaWYgKCFyZGV2LT5yaW5nW3JhZGVvbl9jb3B5X3JpbmdfaW5kZXgocmRldildLnJl
YWR5IHx8Cj4gLQkgICAgcmRldi0+YXNpYy0+Y29weS5jb3B5ID09IE5VTEwpIHsKPiAtCQkvKiB1
c2UgbWVtY3B5ICovCj4gLQkJZ290byBtZW1jcHk7Cj4gKwlpZiAocmRldi0+cmluZ1tyYWRlb25f
Y29weV9yaW5nX2luZGV4KHJkZXYpXS5yZWFkeSAmJgo+ICsJICAgIHJkZXYtPmFzaWMtPmNvcHku
Y29weSAhPSBOVUxMKSB7Cj4gKwkJaWYgKChvbGRfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfU1lT
VEVNICYmCj4gKwkJICAgICBuZXdfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVlJBTSkgfHwKPiAr
CQkgICAgKG9sZF9tZW0tPm1lbV90eXBlID09IFRUTV9QTF9WUkFNICYmCj4gKwkJICAgICBuZXdf
bWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfU1lTVEVNKSkgewo+ICsJCQlob3AtPmZwZm4gPSAwOwo+
ICsJCQlob3AtPmxwZm4gPSAwOwo+ICsJCQlob3AtPm1lbV90eXBlID0gVFRNX1BMX1RUOwo+ICsJ
CQlob3AtPmZsYWdzID0gMDsKPiArCQkJcmV0dXJuIC1FTVVMVElIT1A7Cj4gKwkJfQo+ICsKPiAr
CQlyID0gcmFkZW9uX21vdmVfYmxpdChibywgZXZpY3QsIG5ld19tZW0sIG9sZF9tZW0pOwo+ICsJ
fSBlbHNlIHsKPiArCQlyID0gLUVOT0RFVjsKPiAgIAl9Cj4gICAKPiAtCXIgPSByYWRlb25fbW92
ZV9ibGl0KGJvLCBldmljdCwgbmV3X21lbSwgb2xkX21lbSk7Cj4gICAJaWYgKHIpIHsKPiAtbWVt
Y3B5Ogo+ICAgCQlyID0gdHRtX2JvX21vdmVfbWVtY3B5KGJvLCBjdHgsIG5ld19tZW0pOwo+IC0J
CWlmIChyKSB7Cj4gLQkJCWdvdG8gZmFpbDsKPiAtCQl9Cj4gKwkJaWYgKHIpCj4gKwkJCXJldHVy
biByOwo+ICAgCX0KPiAgIAo+ICtvdXQ6Cj4gICAJLyogdXBkYXRlIHN0YXRpc3RpY3MgKi8KPiAg
IAlhdG9taWM2NF9hZGQoKHU2NCliby0+bnVtX3BhZ2VzIDw8IFBBR0VfU0hJRlQsICZyZGV2LT5u
dW1fYnl0ZXNfbW92ZWQpOwo+ICsJcmFkZW9uX2JvX21vdmVfbm90aWZ5KGJvLCBldmljdCwgbmV3
X21lbSk7Cj4gICAJcmV0dXJuIDA7Cj4gLWZhaWw6Cj4gLQlzd2FwKCpuZXdfbWVtLCBiby0+bWVt
KTsKPiAtCXJhZGVvbl9ib19tb3ZlX25vdGlmeShibywgZmFsc2UsIG5ld19tZW0pOwo+IC0Jc3dh
cCgqbmV3X21lbSwgYm8tPm1lbSk7Cj4gLQlyZXR1cm4gcjsKPiAgIH0KPiAgIAo+ICAgc3RhdGlj
IGludCByYWRlb25fdHRtX2lvX21lbV9yZXNlcnZlKHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2
LCBzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0pCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
