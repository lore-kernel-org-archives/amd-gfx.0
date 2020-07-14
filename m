Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DBBB2075B
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVjMIEi6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DBBB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4866E81F;
	Tue, 14 Jul 2020 08:47:04 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A026E81F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:47:03 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q5so20324945wru.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 01:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ewE/jBM1ZQs50LVflvbX6D1jjRM7Va6yRD55ZaPOV+Q=;
 b=pVjMIEi6eSNZTpVFzG0qsVeFGExgTtjzR3qDmYiENGZLCpaSHqU0xqO6e/+TGRlf0I
 yNNy2/dCaRJ2ASQzvs7gLYKbQrqMT5EDWShYF/yyfuNJqDkD552XJurhwbGpG0PLCazA
 lrgNZwy76nSYImVGS89UBRuORY+beQvSvdmN2vXoEaCBSlNelqOC4lihW95hYM12d+xq
 VNUp61hchWeumEh8qtNxBJ/aWbsEWyZXcq44qiV4/V7L7dGzxLK5WgQdImJwT8tLmyPE
 TSBDtd3HSA86Xshj3HMu8U4MKNjAKRJf7Uvc/z+A6EefsoZS2+c/1GLg79M8QeYCkGIr
 gf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=ewE/jBM1ZQs50LVflvbX6D1jjRM7Va6yRD55ZaPOV+Q=;
 b=ENbM/ySkhiVcfhMl327v/qtrxACBXwjF1NVdY0+lfzyXEz//oXt54zhQvJTrxA08yh
 P41cXMycaTOhaV3lU8yuqP2Sxf0Rp1NH/R+APPsT1A+R0dM1URsJomnmLHVhYd9LD6lv
 aH1+l3+8FpLljTrldn7d7705wEuvF3MCucGWxwCjBQAtttljqxzKu+MJWavQofh+lBSM
 /aASXFrETHnoOGqP0xOR31ddVR6iql4qoGfT5in/U9ShM52LRWj1J3bGB8lGlwaYQRbx
 pxs/hY6sY++7p2swbGWY2E6ABgQJUSfkE8v/7bJgex/xgjDQ8Q9RdjvU1bzzVyL6rJ64
 E+Sg==
X-Gm-Message-State: AOAM531ld9DH1KmRCaUDXpyD5+9bKIOyeRF8F94Nf2IUOWNsC8m4OKW1
 ZOTIFgq3dMUMyYXFhV+NkDE=
X-Google-Smtp-Source: ABdhPJxSD+/UoHq6Z+7j5G4DIj2HlNtaBHIYC7k1IEFVj0BYU/ZigIlQi1pJh8aiMf2yfn1dyC5wsw==
X-Received: by 2002:adf:f842:: with SMTP id d2mr4223157wrq.55.1594716422035;
 Tue, 14 Jul 2020 01:47:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id n5sm3293302wmi.34.2020.07.14.01.47.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jul 2020 01:47:01 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200714080924.3722-1-xiaojie.yuan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7d2c7482-6182-613b-42db-4076e468a3d4@gmail.com>
Date: Tue, 14 Jul 2020 10:47:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714080924.3722-1-xiaojie.yuan@amd.com>
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
Cc: Le Ma <le.ma@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDcuMjAgdW0gMTA6MDkgc2NocmllYiBYaWFvamllIFl1YW46Cj4gInU2NCAqd3B0ciIg
cG9pbnRzIHRvIHRoZSB0aGUgd3B0ciB2YWx1ZSBpbiB3cml0ZSBiYWNrIGJ1ZmZlciBhbmQKPiAi
KndwdHIgPSAoKndwdHIpID4+IDI7IiByZXN1bHRzIGluIHRoZSB2YWx1ZSBiZWluZyBvdmVyd3Jp
dHRlbiBlYWNoIHRpbWUKPiB3aGVuIC0+Z2V0X3dwdHIoKSBpcyBjYWxsZWQuCj4KPiB1bXIgdXNl
cyAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9hbWRncHVfcmluZ19zZG1hMCB0byBnZXQgcnB0ci93
cHRyIGFuZAo+IGRlY29kZSByaW5nIGNvbnRlbnQgYW5kIGl0IGlzIGFmZmVjdGVkIGJ5IHRoaXMg
aXNzdWUuCj4KPiBmaXggYW5kIHNpbXBsaWZ5IHRoZSBsb2dpYyBzaW1pbGFyIGFzIHNkbWFfdjRf
MF9yaW5nX2dldF93cHRyKCkuCj4KPiBTdWdnZXN0ZWQtYnk6IExlIE1hIDxsZS5tYUBhbWQuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IFhpYW9qaWUgWXVhbiA8eGlhb2ppZS55dWFuQGFtZC5jb20+CgpO
aWNlLCBjYXRjaC4gSSdtIHdvbmRlcmluZyBob3cgdGhpcyBjb2RlIGV2ZXIgY2FtZSB0byBiZS4K
ClBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+CgpDYW4geW91IHBsZWFzZSBkb3VibGUgY2hlY2sgdGhhdCB3ZSBkb24ndCBoYXZl
IHRoYXQgbm9uc2Vuc2UgaW4gCnNkbWFfdjRfMCBvciBldmVuIG9sZGVyIGFzIHdlbGw/CgpUaGFu
a3MsCkNocmlzdGlhbi4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y1XzAuYyB8IDI2ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjVfMC5jCj4gaW5kZXggYWJiMGFiNjUzYjEwLi5lMjIzMmRkMTJkOGUgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMKPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwo+IEBAIC0zMTUsMzAgKzMx
NSwyMCBAQCBzdGF0aWMgdWludDY0X3Qgc2RtYV92NV8wX3JpbmdfZ2V0X3JwdHIoc3RydWN0IGFt
ZGdwdV9yaW5nICpyaW5nKQo+ICAgc3RhdGljIHVpbnQ2NF90IHNkbWFfdjVfMF9yaW5nX2dldF93
cHRyKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiA9IHJpbmctPmFkZXY7Cj4gLQl1NjQgKndwdHIgPSBOVUxMOwo+IC0JdWludDY0
X3QgbG9jYWxfd3B0ciA9IDA7Cj4gKwl1NjQgd3B0cjsKPiAgIAo+ICAgCWlmIChyaW5nLT51c2Vf
ZG9vcmJlbGwpIHsKPiAgIAkJLyogWFhYIGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBv
biBCRSAqLwo+IC0JCXdwdHIgPSAoKHU2NCAqKSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNd
KTsKPiAtCQlEUk1fREVCVUcoIndwdHIvZG9vcmJlbGwgYmVmb3JlIHNoaWZ0ID09IDB4JTAxNmxs
eFxuIiwgKndwdHIpOwo+IC0JCSp3cHRyID0gKCp3cHRyKSA+PiAyOwo+IC0JCURSTV9ERUJVRygi
d3B0ci9kb29yYmVsbCBhZnRlciBzaGlmdCA9PSAweCUwMTZsbHhcbiIsICp3cHRyKTsKPiArCQl3
cHRyID0gUkVBRF9PTkNFKCooKHU2NCAqKSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdKSk7
Cj4gKwkJRFJNX0RFQlVHKCJ3cHRyL2Rvb3JiZWxsIGJlZm9yZSBzaGlmdCA9PSAweCUwMTZsbHhc
biIsIHdwdHIpOwo+ICAgCX0gZWxzZSB7Cj4gLQkJdTMyIGxvd2JpdCwgaGlnaGJpdDsKPiAtCj4g
LQkJd3B0ciA9ICZsb2NhbF93cHRyOwo+IC0JCWxvd2JpdCA9IFJSRUczMihzZG1hX3Y1XzBfZ2V0
X3JlZ19vZmZzZXQoYWRldiwgcmluZy0+bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFIpKSA+PiAyOwo+
IC0JCWhpZ2hiaXQgPSBSUkVHMzIoc2RtYV92NV8wX2dldF9yZWdfb2Zmc2V0KGFkZXYsIHJpbmct
Pm1lLCBtbVNETUEwX0dGWF9SQl9XUFRSX0hJKSkgPj4gMjsKPiAtCj4gLQkJRFJNX0RFQlVHKCJ3
cHRyIFslaV1oaWdoPT0gMHglMDh4IGxvdz09MHglMDh4XG4iLAo+IC0JCQkJcmluZy0+bWUsIGhp
Z2hiaXQsIGxvd2JpdCk7Cj4gLQkJKndwdHIgPSBoaWdoYml0Owo+IC0JCSp3cHRyID0gKCp3cHRy
KSA8PCAzMjsKPiAtCQkqd3B0ciB8PSBsb3diaXQ7Cj4gKwkJd3B0ciA9IFJSRUczMihzZG1hX3Y1
XzBfZ2V0X3JlZ19vZmZzZXQoYWRldiwgcmluZy0+bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFJfSEkp
KTsKPiArCQl3cHRyID0gd3B0ciA8PCAzMjsKPiArCQl3cHRyIHw9IFJSRUczMihzZG1hX3Y1XzBf
Z2V0X3JlZ19vZmZzZXQoYWRldiwgcmluZy0+bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFIpKTsKPiAr
CQlEUk1fREVCVUcoIndwdHIgYmVmb3JlIHNoaWZ0IFslaV0gd3B0ciA9PSAweCUwMTZsbHhcbiIs
IHJpbmctPm1lLCB3cHRyKTsKPiAgIAl9Cj4gICAKPiAtCXJldHVybiAqd3B0cjsKPiArCXJldHVy
biB3cHRyID4+IDI7Cj4gICB9Cj4gICAKPiAgIC8qKgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
