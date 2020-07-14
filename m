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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB76C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E66D2075F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+dX6HwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E66D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B886E7EF;
	Tue, 14 Jul 2020 09:30:46 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3C06E7EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 09:30:45 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id o11so20478477wrv.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 02:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=52RGIXSqgLUPC1F/0QuEfUlXa+exUDcyVkr+Fzi//C4=;
 b=g+dX6HwG7tjxm7EY5JIxUxlNpbC4mYynvkPR1Fe2ur66XDnUZUsnnlGG0AdHVT2X4E
 bM0N1esyVWkFk9d9vu8ZenOOAFeKrNuhs0Rp1sEtdpAsnj5odWIK24yem9bKi5/JmUV0
 IiYNs/OwSoihBkT2lhBjDqwo1JWtBlyG2VTwNMgeESzMaeNz7BVBj8Z9cJpDe0HJ7ve3
 DlNVHCUzUeBWW6NLd1UeZFofPLE15kiA9m4+D6huz2osSlOeqtdwXz16G4e80nuiDR/S
 wTSfQ8VNdcFoE97aVxFh+oDcQCoJi6ONh63BE5pFBtgB6feHpSeZarnuEUFmjA9bcTir
 WG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=52RGIXSqgLUPC1F/0QuEfUlXa+exUDcyVkr+Fzi//C4=;
 b=FBri7I5Do9zBwPXt/9jtM40n5KJhEM/ozs/HmAyR/wDruuxOsg5i7ro+G4T4zq0Fef
 fe6Z5AZ9KstY9amGpvWhPTkJfGX4MyQ1tTX+5XshWvWcLb1vp4EPcwDQkA5cH8eHHfJ1
 Wx+pAE5+/j7eK/LsVVOubhTl4WmRYm8mujQAGa85uyPAnHSQxEHOSzlu+Jpp7KX4U933
 K/BxaGenTHPyNCADyNb+loOYcoZzobpD1Yy8VWYu/6BJI/sxQ5+Hf1jD3yi73mDjB0Ug
 Y0fwEbacFD66YfTW0Pw9OSlpVaFEmV5U91JdNagmT91St0DVKkfxBZOSPUdGMzHZw7Ci
 lHCA==
X-Gm-Message-State: AOAM530ObgylkFzUOWM+03w1JQHodlHN2+3Mjnia2mYiJDnpOtJhECfr
 Lg8wlI3ErVr5Ik6ykr8hdhY=
X-Google-Smtp-Source: ABdhPJyX3qb153Vuc5SXBpGz9uOveLph4wJ/VP9kvqRdkXCBPuuqJgv/X4uXEceMOF0Ss2lhmX0mGQ==
X-Received: by 2002:adf:f203:: with SMTP id p3mr4078811wro.331.1594719043776; 
 Tue, 14 Jul 2020 02:30:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z63sm3818419wmb.2.2020.07.14.02.30.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jul 2020 02:30:43 -0700 (PDT)
Subject: Re: [PATCH v2] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()
To: Xiaojie Yuan <xiaojie.yuan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200714090959.21777-1-xiaojie.yuan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9e6142ee-2cc7-5e93-58a5-3bd13990ceaa@gmail.com>
Date: Tue, 14 Jul 2020 11:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200714090959.21777-1-xiaojie.yuan@amd.com>
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
Cc: Le Ma <le.ma@amd.com>, likun.gao@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMDcuMjAgdW0gMTE6MDkgc2NocmllYiBYaWFvamllIFl1YW46Cj4gInU2NCAqd3B0ciIg
cG9pbnRzIHRvIHRoZSB0aGUgd3B0ciB2YWx1ZSBpbiB3cml0ZSBiYWNrIGJ1ZmZlciBhbmQKPiAi
KndwdHIgPSAoKndwdHIpID4+IDI7IiByZXN1bHRzIGluIHRoZSB2YWx1ZSBiZWluZyBvdmVyd3Jp
dHRlbiBlYWNoIHRpbWUKPiB3aGVuIC0+Z2V0X3dwdHIoKSBpcyBjYWxsZWQuCj4KPiB1bXIgdXNl
cyAvc3lzL2tlcm5lbC9kZWJ1Zy9kcmkvMC9hbWRncHVfcmluZ19zZG1hMCB0byBnZXQgcnB0ci93
cHRyIGFuZAo+IGRlY29kZSByaW5nIGNvbnRlbnQgYW5kIGl0IGlzIGFmZmVjdGVkIGJ5IHRoaXMg
aXNzdWUuCj4KPiBmaXggYW5kIHNpbXBsaWZ5IHRoZSBsb2dpYyBzaW1pbGFyIGFzIHNkbWFfdjRf
MF9yaW5nX2dldF93cHRyKCkuCj4KPiB2MjogZml4IGZvciBzZG1hNS4yIGFzIHdlbGwKPgo+IFN1
Z2dlc3RlZC1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogWGlhb2pp
ZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NV8wLmMgfCAyNiArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCAyNiArKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAz
NiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zZG1hX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCj4g
aW5kZXggYWJiMGFiNjUzYjEwLi5lMjIzMmRkMTJkOGUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y1XzAuYwo+IEBAIC0zMTUsMzAgKzMxNSwyMCBAQCBzdGF0aWMgdWludDY0
X3Qgc2RtYV92NV8wX3JpbmdfZ2V0X3JwdHIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAg
c3RhdGljIHVpbnQ2NF90IHNkbWFfdjVfMF9yaW5nX2dldF93cHRyKHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZykKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFk
ZXY7Cj4gLQl1NjQgKndwdHIgPSBOVUxMOwo+IC0JdWludDY0X3QgbG9jYWxfd3B0ciA9IDA7Cj4g
Kwl1NjQgd3B0cjsKPiAgIAo+ICAgCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpIHsKPiAgIAkJLyog
WFhYIGNoZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBvbiBCRSAqLwo+IC0JCXdwdHIgPSAo
KHU2NCAqKSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdKTsKPiAtCQlEUk1fREVCVUcoIndw
dHIvZG9vcmJlbGwgYmVmb3JlIHNoaWZ0ID09IDB4JTAxNmxseFxuIiwgKndwdHIpOwo+IC0JCSp3
cHRyID0gKCp3cHRyKSA+PiAyOwo+IC0JCURSTV9ERUJVRygid3B0ci9kb29yYmVsbCBhZnRlciBz
aGlmdCA9PSAweCUwMTZsbHhcbiIsICp3cHRyKTsKPiArCQl3cHRyID0gUkVBRF9PTkNFKCooKHU2
NCAqKSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdKSk7Cj4gKwkJRFJNX0RFQlVHKCJ3cHRy
L2Rvb3JiZWxsIGJlZm9yZSBzaGlmdCA9PSAweCUwMTZsbHhcbiIsIHdwdHIpOwo+ICAgCX0gZWxz
ZSB7Cj4gLQkJdTMyIGxvd2JpdCwgaGlnaGJpdDsKPiAtCj4gLQkJd3B0ciA9ICZsb2NhbF93cHRy
Owo+IC0JCWxvd2JpdCA9IFJSRUczMihzZG1hX3Y1XzBfZ2V0X3JlZ19vZmZzZXQoYWRldiwgcmlu
Zy0+bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFIpKSA+PiAyOwo+IC0JCWhpZ2hiaXQgPSBSUkVHMzIo
c2RtYV92NV8wX2dldF9yZWdfb2Zmc2V0KGFkZXYsIHJpbmctPm1lLCBtbVNETUEwX0dGWF9SQl9X
UFRSX0hJKSkgPj4gMjsKPiAtCj4gLQkJRFJNX0RFQlVHKCJ3cHRyIFslaV1oaWdoPT0gMHglMDh4
IGxvdz09MHglMDh4XG4iLAo+IC0JCQkJcmluZy0+bWUsIGhpZ2hiaXQsIGxvd2JpdCk7Cj4gLQkJ
KndwdHIgPSBoaWdoYml0Owo+IC0JCSp3cHRyID0gKCp3cHRyKSA8PCAzMjsKPiAtCQkqd3B0ciB8
PSBsb3diaXQ7Cj4gKwkJd3B0ciA9IFJSRUczMihzZG1hX3Y1XzBfZ2V0X3JlZ19vZmZzZXQoYWRl
diwgcmluZy0+bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFJfSEkpKTsKPiArCQl3cHRyID0gd3B0ciA8
PCAzMjsKPiArCQl3cHRyIHw9IFJSRUczMihzZG1hX3Y1XzBfZ2V0X3JlZ19vZmZzZXQoYWRldiwg
cmluZy0+bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFIpKTsKPiArCQlEUk1fREVCVUcoIndwdHIgYmVm
b3JlIHNoaWZ0IFslaV0gd3B0ciA9PSAweCUwMTZsbHhcbiIsIHJpbmctPm1lLCB3cHRyKTsKPiAg
IAl9Cj4gICAKPiAtCXJldHVybiAqd3B0cjsKPiArCXJldHVybiB3cHRyID4+IDI7Cj4gICB9Cj4g
ICAKPiAgIC8qKgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1h
X3Y1XzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCj4gaW5kZXgg
MWVmMTRiNjEwYTRmLi44MjRmM2UyM2MzZDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NV8yLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zZG1hX3Y1XzIuYwo+IEBAIC0yNjIsMzAgKzI2MiwyMCBAQCBzdGF0aWMgdWludDY0X3Qgc2Rt
YV92NV8yX3JpbmdfZ2V0X3JwdHIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICAgc3RhdGlj
IHVpbnQ2NF90IHNkbWFfdjVfMl9yaW5nX2dldF93cHRyKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7Cj4g
LQl1NjQgKndwdHIgPSBOVUxMOwo+IC0JdWludDY0X3QgbG9jYWxfd3B0ciA9IDA7Cj4gKwl1NjQg
d3B0cjsKPiAgIAo+ICAgCWlmIChyaW5nLT51c2VfZG9vcmJlbGwpIHsKPiAgIAkJLyogWFhYIGNo
ZWNrIGlmIHN3YXBwaW5nIGlzIG5lY2Vzc2FyeSBvbiBCRSAqLwo+IC0JCXdwdHIgPSAoKHU2NCAq
KSZhZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdKTsKPiAtCQlEUk1fREVCVUcoIndwdHIvZG9v
cmJlbGwgYmVmb3JlIHNoaWZ0ID09IDB4JTAxNmxseFxuIiwgKndwdHIpOwo+IC0JCSp3cHRyID0g
KCp3cHRyKSA+PiAyOwo+IC0JCURSTV9ERUJVRygid3B0ci9kb29yYmVsbCBhZnRlciBzaGlmdCA9
PSAweCUwMTZsbHhcbiIsICp3cHRyKTsKPiArCQl3cHRyID0gUkVBRF9PTkNFKCooKHU2NCAqKSZh
ZGV2LT53Yi53YltyaW5nLT53cHRyX29mZnNdKSk7Cj4gKwkJRFJNX0RFQlVHKCJ3cHRyL2Rvb3Ji
ZWxsIGJlZm9yZSBzaGlmdCA9PSAweCUwMTZsbHhcbiIsIHdwdHIpOwo+ICAgCX0gZWxzZSB7Cj4g
LQkJdTMyIGxvd2JpdCwgaGlnaGJpdDsKPiAtCj4gLQkJd3B0ciA9ICZsb2NhbF93cHRyOwo+IC0J
CWxvd2JpdCA9IFJSRUczMihzZG1hX3Y1XzJfZ2V0X3JlZ19vZmZzZXQoYWRldiwgcmluZy0+bWUs
IG1tU0RNQTBfR0ZYX1JCX1dQVFIpKSA+PiAyOwo+IC0JCWhpZ2hiaXQgPSBSUkVHMzIoc2RtYV92
NV8yX2dldF9yZWdfb2Zmc2V0KGFkZXYsIHJpbmctPm1lLCBtbVNETUEwX0dGWF9SQl9XUFRSX0hJ
KSkgPj4gMjsKPiAtCj4gLQkJRFJNX0RFQlVHKCJ3cHRyIFslaV1oaWdoPT0gMHglMDh4IGxvdz09
MHglMDh4XG4iLAo+IC0JCQkJcmluZy0+bWUsIGhpZ2hiaXQsIGxvd2JpdCk7Cj4gLQkJKndwdHIg
PSBoaWdoYml0Owo+IC0JCSp3cHRyID0gKCp3cHRyKSA8PCAzMjsKPiAtCQkqd3B0ciB8PSBsb3di
aXQ7Cj4gKwkJd3B0ciA9IFJSRUczMihzZG1hX3Y1XzJfZ2V0X3JlZ19vZmZzZXQoYWRldiwgcmlu
Zy0+bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFJfSEkpKTsKPiArCQl3cHRyID0gd3B0ciA8PCAzMjsK
PiArCQl3cHRyIHw9IFJSRUczMihzZG1hX3Y1XzJfZ2V0X3JlZ19vZmZzZXQoYWRldiwgcmluZy0+
bWUsIG1tU0RNQTBfR0ZYX1JCX1dQVFIpKTsKPiArCQlEUk1fREVCVUcoIndwdHIgYmVmb3JlIHNo
aWZ0IFslaV0gd3B0ciA9PSAweCUwMTZsbHhcbiIsIHJpbmctPm1lLCB3cHRyKTsKPiAgIAl9Cj4g
ICAKPiAtCXJldHVybiAqd3B0cjsKPiArCXJldHVybiB3cHRyID4+IDI7Cj4gICB9Cj4gICAKPiAg
IC8qKgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
