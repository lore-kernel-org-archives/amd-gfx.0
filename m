Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF6AC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 12:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9413D233A2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 12:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9413D233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1436E0CC;
	Tue,  8 Dec 2020 12:08:30 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B336E161
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 12:08:28 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id 19so8081343qkm.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 04:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Ou4Q5UfXIGzE0oucq8rE1Kmc8HqSmW02A+CD7rkuNMc=;
 b=bOVDLkE9DTEIsuRx3Luraz1j5ZQNbvNvJyikksUXNQ9AkFrarwsPDviY81pPg7a8sk
 DxWaGljib/enUntjcIj3x4bPEt/X5oPPMsaATD++Ww5Fm64UF7/FnrsAgRUDeMkfWj2a
 Slx8n6v2Zd9ZTp12wqW/4zQVkrp2yi0GJaqG7jYVU7uWEqHHkK/nZFjvbKMHvdEewysF
 h28HdzvWfuF6TNaeM3Tnf0hTCRPLnbODXo8s75meQuVX8Olq2yuhXIXRSMbtHWdUW2yk
 PWkwJo3PK8kqz+O+v6GHpUwMj77UO0Tasv6jp2JJmylwuK5u/fRDJYzj6bSL6cms2fIH
 KoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Ou4Q5UfXIGzE0oucq8rE1Kmc8HqSmW02A+CD7rkuNMc=;
 b=YW/0DbuU3WQ2V5ieaqWJPE3gZtvq/ac5IQvozULyoSF2+FIJHMdGJ6AydZUUyUJmbf
 NSTIzw0RVF1CB3uPdIeUeFOSn2gcUs5bz6qqkSJc1Lebp/i8Idsomdw0QFpJmL10idMh
 JnlKBp4c97GcBTzreJhRH75TWPVBACu/yUJ0sx38wmDrNtM+7RK8MhMJ75pbg51OM874
 Tke9EIUCr5V/8+Q3eHg+Jsw3dIeqjtd1eYoy1i02z3OwW2SdMTQD/B2Q2DYQ0ikzw76q
 SwYeXiNqkk/l+JrW2DsbXwjchwAo14iH9NIgctTn10f8Qju4idpnfUbXTSZO/Wnk8MXw
 atOg==
X-Gm-Message-State: AOAM530ZtPlxsP3rJ0M3/ROn9pLCpE/Fl91IdnQ8RddoSFS5v8Vbn8rR
 8QJky35op7qfYjaXQ6FbeFwat8Q9Hqo=
X-Google-Smtp-Source: ABdhPJzg+OdNc1Id6ZJqj00yiHxj9lbuueaANp+W+luO+vyU+MqPFF9Emz+s2il2p13zHNZlI8jeig==
X-Received: by 2002:a37:a516:: with SMTP id o22mr600525qke.17.1607429307100;
 Tue, 08 Dec 2020 04:08:27 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z20sm13741539qto.40.2020.12.08.04.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Dec 2020 04:08:26 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add the missing
 AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS flag
To: Chen Lei <chenlei18s@ict.ac.cn>, christian.koenig@amd.com,
 alexander.deucher@amd.com
References: <20201208025040.30268-1-chenlei18s@ict.ac.cn>
 <a0ee3531-194c-d388-7788-69d59e7421e2@gmail.com>
 <6502eaf9.1cc77.17641e52d45.Coremail.chenlei18s@ict.ac.cn>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <15cda96b-8555-aab1-7d18-f4243464aef3@gmail.com>
Date: Tue, 8 Dec 2020 13:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6502eaf9.1cc77.17641e52d45.Coremail.chenlei18s@ict.ac.cn>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIGZsYWcgaXMgc2V0IGJ5IHRoZSBrZXJuZWwgd2hlbiBpdCBkZXRlY3RzIHRoYXQgY29udGln
dW91cyBWUkFNIGlzIApuZWNlc3NhcnkgYnkgYmVjYXVzZSBvZiBzb21lIGhhcmR3YXJlIHJlc3Ry
aWN0aW9uLiBJdCBzaG91bGQgbmV2ZXIgYmUgCnNldCBieSB1c2Vyc3BhY2UgbWFudWFsbHkuCgpJ
J3ZlIGFkZGVkIGdpYW50IHBhZ2Ugb3B0aW1pemF0aW9ucyBhcyBhIGJlc3QgZWZmb3J0IGhhbmRs
aW5nIHdoaWNoIAphdG9tYXRpY2FsbHkga2lja3MgaW4gd2hlbiBlbm91Z2ggVlJBTSBpcyBhdmFp
bGFibGUuIElmIFZSQU0gaXMgCmZyYWdtZW50ZWQgd2UgZmFsbCBiYWNrIHRvIGh1Z2UgcGFnZSBh
bGxvY2F0aW9ucy4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDA4LjEyLjIwIHVtIDExOjI4IHNj
aHJpZWIgQ2hlbiBMZWk6Cj4gSGkhIEkgYW0gbm90IHF1aXRlIGZhbWlsaWFyIHdpdGggaXQsIGFu
ZCBJIHdhcyB3b25kZXJpbmcgd2h5IHRoaXMgZmxhZyBpcyBibG9ja2VkLiBBcyB0aGUgVk0gc3Vi
c3lzdGVtIHN1cHBvcnRzIGdpYW50IHBhZ2VzLCBpdCBtaWdodCBiZSB1c2VmdWwgdG8gYWRkIHRo
aXMgZmxhZyBpbiBhbWRncHVfZ2VtX2NyZWF0ZV9pb2N0bC4KPgo+Cj4gJmd0OyAtLS0tLeWOn+Wn
i+mCruS7ti0tLS0tCj4gJmd0OyDlj5Hku7bkuro6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2tvZW5p
Zy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+Cj4gJmd0OyDlj5HpgIHml7bpl7Q6IDIwMjAtMTIt
MDggMTU6NDE6MDIgKOaYn+acn+S6jCkKPiAmZ3Q7IOaUtuS7tuS6ujogIkNoZW4gTGVpIiA8Y2hl
bmxlaTE4c0BpY3QuYWMuY24+LCBhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tLCBjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20KPiAmZ3Q7IOaKhOmAgTogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiAmZ3Q7IOS4u+mimDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogYWRkIHRoZSBtaXNzaW5n
IEFNREdQVV9HRU1fQ1JFQVRFX1ZSQU1fQ09OVElHVU9VUyBmbGFnCj4gJmd0Owo+ICZndDsgQW0g
MDguMTIuMjAgdW0gMDM6NTAgc2NocmllYiBDaGVuIExlaToKPiAmZ3Q7ICZndDsgQWRkIHRoZSBB
TURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgZmxhZyBpbiBhbWRncHVfZ2VtX2NyZWF0
ZV9pb2N0bC4KPiAmZ3Q7ICZndDsKPiAmZ3Q7ICZndDsgU2lnbmVkLW9mZi1ieTogQ2hlbiBMZWkg
PGNoZW5sZWkxOHNAaWN0LmFjLmNuPgo+ICZndDsKPiAmZ3Q7IE5BSywgdGhhdCBpcyBub3QgbWlz
c2luZyBidXQgaW50ZW50aW9uYWxseSBibG9ja2VkLgo+ICZndDsKPiAmZ3Q7IENocmlzdGlhbi4K
PiAmZ3Q7Cj4gJmd0OyAmZ3Q7IC0tLQo+ICZndDsgJmd0OyAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDEgKwo+ICZndDsgJmd0OyAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKQo+ICZndDsgJmd0Owo+ICZndDsgJmd0OyBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2dlbS5jCj4gJmd0OyAmZ3Q7IGluZGV4IDdlODI2NWRhOS4uZGExOGFlZmY3
IDEwMDY0NAo+ICZndDsgJmd0OyAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMKPiAmZ3Q7ICZndDsgKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jCj4gJmd0OyAmZ3Q7IEBAIC0yMzMsNiArMjMzLDcgQEAgaW50IGFtZGdwdV9nZW1f
Y3JlYXRlX2lvY3RsKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsCj4gJmd0OyAm
Z3Q7ICAgCQkgICAgICBBTURHUFVfR0VNX0NSRUFURV9OT19DUFVfQUNDRVNTIHwKPiAmZ3Q7ICZn
dDsgICAJCSAgICAgIEFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQyB8Cj4gJmd0OyAmZ3Q7
ICAgCQkgICAgICBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NMRUFSRUQgfAo+ICZndDsgJmd0OyAr
CQkgICAgICBBTURHUFVfR0VNX0NSRUFURV9WUkFNX0NPTlRJR1VPVVMgfAo+ICZndDsgJmd0OyAg
IAkJICAgICAgQU1ER1BVX0dFTV9DUkVBVEVfVk1fQUxXQVlTX1ZBTElEIHwKPiAmZ3Q7ICZndDsg
ICAJCSAgICAgIEFNREdQVV9HRU1fQ1JFQVRFX0VYUExJQ0lUX1NZTkMgfAo+ICZndDsgJmd0OyAg
IAkJICAgICAgQU1ER1BVX0dFTV9DUkVBVEVfRU5DUllQVEVEKSkKPiA8L2NoZW5sZWkxOHNAaWN0
LmFjLmNuPjwvY2hlbmxlaTE4c0BpY3QuYWMuY24+PC9ja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
