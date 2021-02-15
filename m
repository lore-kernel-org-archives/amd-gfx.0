Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC199C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 13:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E7A60200
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 13:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E7A60200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1996489F07;
	Mon, 15 Feb 2021 13:32:53 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E335989F07
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 13:32:51 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id bl23so11148225ejb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 05:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=FkKYBoNj9QJk0D+pIRhjfSXlq9U9Qt3Bn0Jsjx75ULw=;
 b=di1Sy2B58dyPhkBKcindJySVqlCiqTKo4M0km4Qd1nDIqwvZuPbIsPHwTcA6lXcGdV
 ZiSOW8BZHeo8jxFyLrAkC0ZRhb6z6lLr4LoI4fcROH8k1BFHtYe8KquZHFwKAI1YbB54
 kxsxthzVBhaFVhrkLMY20ACiiJc7HUXAth26K4wJqRlsABt6lcXcF2Y8qmdYfgz+dXP7
 dvpyKHkenWuTcsPZyT6/mTOfxnDhuSni+cea6AEbg7GwfpN0UweaV908ShN0tVFlHV+6
 e0koNhMHv1wVDIBzaRgJApkRRo5uA6/66n6X19bgvCVZue9kKPHunlEUepWPMo+zlKz3
 y1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FkKYBoNj9QJk0D+pIRhjfSXlq9U9Qt3Bn0Jsjx75ULw=;
 b=bMHGXoDN+Zu9rPbMjpE0vS+QoJPqNWBQLas1h/TEq9mNI0xosRNOPQR2Qm8QIuv0Fs
 J030FKyO4JNW5MPrAK69iynn2l+svcJfLTkdoH3BiexhL2Fw73NR2zKeIayvqFUVz6aF
 24Back1wLQNSGn+p24FdOsxC2iL34YBwoE5LWISb0mEO0ZaZpm+ZmYc4BGvRMdDQL0f3
 W5o1/NaZ9g6a60S+isvXaUymF83oKZakKZoodq+mHN1Wts3VLLa61LPcZ1ic8vupHTZ0
 9gvpw6N1tRo48yNRkAs/DjJKemFXL4olCB19CfF4tYhtJ9AK3/R2KN1zkYOPZmfH2kaZ
 5PDw==
X-Gm-Message-State: AOAM530DscpTHJvADzjcIRuNazr1fyjrjNrOaOyAcv1ULSM+amwtaKw8
 +cC732DWDBVbzoLtWdileLA=
X-Google-Smtp-Source: ABdhPJw5RNkQ/+7lWWhChVNlrsjmXcEGo8lcXYLkHsZtHWPF0amVLb9mBXMn5oQv1b8+8OseftizwA==
X-Received: by 2002:a17:906:a3d5:: with SMTP id
 ca21mr15819221ejb.192.1613395970595; 
 Mon, 15 Feb 2021 05:32:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:3e90:5494:cc4a:73e5?
 ([2a02:908:1252:fb60:3e90:5494:cc4a:73e5])
 by smtp.gmail.com with ESMTPSA id bo12sm10442774ejb.93.2021.02.15.05.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 05:32:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Set GTT_USWC flag to enable freesync v2
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20210215114336.89977-1-christian.koenig@amd.com>
 <0a679d74-6066-0ed8-26f8-2d02b6db5210@gmail.com>
 <BYAPR12MB3126F7B79F9EB3510813A837F2889@BYAPR12MB3126.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4c47a2b0-8274-93ef-560f-e9eb31d7530b@gmail.com>
Date: Mon, 15 Feb 2021 14:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB3126F7B79F9EB3510813A837F2889@BYAPR12MB3126.namprd12.prod.outlook.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIFNoYXNoYW5rLAoKQWxleCB3aGVuIGRvIHdlIHBsYW4gdGhlIG5leHQgcmViYXNlPwoK
VGhpcyBhbHNvIGRlcGVuZHMgb24gdXBzdHJlYW0gY29kZSBhbmQgY2FuJ3QgYmUgbWVyZ2VkIGlu
IAphbWQtc3RhZ2luZy1kcm0tbmV4dCBkaXJlY3RseS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFt
IDE1LjAyLjIxIHVtIDEzOjI3IHNjaHJpZWIgU2hhcm1hLCBTaGFzaGFuazoKPiBbQU1EIE9mZmlj
aWFsIFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPiBIZWxsbyBDaHJp
c3RpYW4sCj4gSSBqdXN0IHRlc3RlZCB0aGUgcGF0Y2ggd2l0aCBYb25vdGljICsgUFJJTUUsCj4K
PiBJIGNvbmZpcm0gdGhhdCBpdHMgd29ya2luZyBzYW1lIGFzIHByZXZpb3VzIHZlcnNpb24sIGZv
ciB0aGUgRnJlZXN5bmMgc2NlbmFyaW8sIGllOgo+IC0gV2l0aCB0aGlzIHBhdGNoLCBkaXNwbGF5
IGZyYW1lYnVmZmVyIGNyZWF0aW9uIGlzIHN1Y2Nlc3NmdWwsIGZsaXBzIGFyZSBjb21pbmcgYW5k
IFZSUiBwcm9wZXJ0eSBpcyBnZXR0aW5nIHNldC4KPgo+IERpZCBzb21lIG5lZ2F0aXZlIHRlc3Rp
bmcgYWxzbywKPiAtIFdpdGhvdXQgdGhpcyBwYXRjaCwgRnJlbWVidWZmZXIgY3JlYXRpb24gZmFp
bHMsIG5vIGZsaXBzLCAgYW5kIFZSUiBwcm9wZXJ0eSBkb2Vzbid0IHNldC4KPgo+IFJlZ2FyZHMK
PiBTaGFzaGFuawo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+Cj4gU2VudDogTW9uZGF5
LCBGZWJydWFyeSAxNSwgMjAyMSA1OjE1IFBNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBTaGFybWEsIFNoYXNoYW5rIDxTaGFzaGFuay5TaGFybWFAYW1kLmNvbT4KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBTZXQgR1RUX1VTV0MgZmxhZyB0byBlbmFibGUg
ZnJlZXN5bmMgdjIKPgo+IEhpIFNoYXNoYW5rLAo+Cj4gY2FuIHlvdSBnaXZlIHRoaXMgcGF0Y2gg
YSB0ZXN0IHJvdW5kPyBJbiB0aGVvcnkgaXQgc2hvdWxkIHdvcmssIGJ1dCBJJ20gbm90IDEwMCUg
c3VyZS4KPgo+IFRoYW5rcywKPiBDaHJpc3RpYW4uCj4KPiBBbSAxNS4wMi4yMSB1bSAxMjo0MyBz
Y2hyaWViIENocmlzdGlhbiBLw7ZuaWc6Cj4+IEZyb206IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hh
bmsuc2hhcm1hQGFtZC5jb20+Cj4+Cj4+IFRoaXMgcGF0Y2ggc2V0cyAnQU1ER1BVX0dFTV9DUkVB
VEVfQ1BVX0dUVF9VU1dDJyBhcyBpbnB1dCBwYXJhbWV0ZXIKPj4gZmxhZywgZHVyaW5nIG9iamVj
dCBjcmVhdGlvbiBvZiBhbiBpbXBvcnRlZCBETUEgYnVmZmVyLgo+Pgo+PiBJbiBhYnNlbmNlIG9m
IHRoaXMgZmxhZzoKPj4gMS4gRnVuY3Rpb24gYW1kZ3B1X2Rpc3BsYXlfc3VwcG9ydGVkX2RvbWFp
bnMoKSBkb2Vzbid0IGFkZAo+PiAgICAgIEFNREdQVV9HRU1fRE9NQUlOX0dUVCBhcyBzdXBwb3J0
ZWQgZG9tYWluLgo+PiAyLiBEdWUgdG8gd2hpY2gsIEZ1bmN0aW9uIGFtZGdwdV9kaXNwbGF5X3Vz
ZXJfZnJhbWVidWZmZXJfY3JlYXRlKCkKPj4gICAgICByZWZ1c2VzIHRvIGNyZWF0ZSBmcmFtZWJ1
ZmZlciBmb3IgaW1wb3J0ZWQgRE1BIGJ1ZmZlcnMuCj4+IDMuIER1ZSB0byB3aGljaCwgQWRkRkIo
KSBJT0NUTCBmYWlscy4KPj4gNC4gRHVlIHRvIHdoaWNoLCBhbWRncHVfcHJlc2VudF9jaGVja19m
bGlwKCkgY2hlY2sgZmFpbHMgaW4gRERYIDUuIER1ZQo+PiB0byB3aGljaCBERFggZHJpdmVyIGRv
ZXNuJ3QgYWxsb3cgZmxpcHMgKGdvZXMgdG8gYmxpdHRpbmcpIDYuIER1ZSB0bwo+PiB3aGljaCBz
ZXR0aW5nIEZyZWVzeW5jL1ZSUiBwcm9wZXJ0eSBmYWlscyBmb3IgUFJJTUUgYnVmZmVycy4KPj4K
Pj4gU28sIHRoaXMgcGF0Y2ggZmluYWxseSBlbmFibGVzIEZyZWVzeW5jIHdpdGggUFJJTUUgYnVm
ZmVyIG9mZmxvYWRpbmcuCj4+Cj4+IHYyIChjaGspOiBpbnN0ZWFkIG9mIGp1c3QgY2hlY2tpbmcg
dGhlIGZsYWcgd2UgY29weSBpdCBvdmVyIGlmIHRoZQo+PiAgICAgICAgICAgICBleHBvcnRlciBp
cyBhbiBhbWRncHUgZGV2aWNlIGFzIHdlbGwuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFNoYXNoYW5r
IFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gLS0tCj4+ICAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMgfCAxNCArKysrKysrKysrKy0t
LQo+PiAgICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkK
Pj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFf
YnVmLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+
IGluZGV4IGQzNzI3ZjNhYjI3Ny4uYTU0YTg3MGYwMDZjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPj4gQEAgLTQyMiwxNCArNDIyLDIyIEBA
IGFtZGdwdV9kbWFfYnVmX2NyZWF0ZV9vYmooc3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0
IGRtYV9idWYgKmRtYV9idWYpCj4+ICAgIHsKPj4gICAgCXN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9
IGRtYV9idWYtPnJlc3Y7Cj4+ICAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRybV90
b19hZGV2KGRldik7Cj4+IC0Jc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4+ICAgIAlzdHJ1Y3QgZHJt
X2dlbV9vYmplY3QgKmdvYmo7Cj4+ICsJc3RydWN0IGFtZGdwdV9ibyAqYm87Cj4+ICsJdWludDY0
X3QgZmxhZ3MgPSAwOwo+PiAgICAJaW50IHJldDsKPj4gICAgCj4+ICAgIAlkbWFfcmVzdl9sb2Nr
KHJlc3YsIE5VTEwpOwo+PiArCj4+ICsJaWYgKGRtYV9idWYtPm9wcyA9PSAmYW1kZ3B1X2RtYWJ1
Zl9vcHMpIHsKPj4gKwkJc3RydWN0IGFtZGdwdV9ibyAqb3RoZXIgPSBnZW1fdG9fYW1kZ3B1X2Jv
KGRtYV9idWYtPnByaXYpOwo+PiArCj4+ICsJCWZsYWdzIHw9IG90aGVyLT5mbGFncyAmIEFNREdQ
VV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQzsKPj4gKwl9Cj4+ICsKPj4gICAgCXJldCA9IGFtZGdw
dV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2LCBkbWFfYnVmLT5zaXplLCBQQUdFX1NJWkUsCj4+IC0J
CQlBTURHUFVfR0VNX0RPTUFJTl9DUFUsCj4+IC0JCQkwLCB0dG1fYm9fdHlwZV9zZywgcmVzdiwg
JmdvYmopOwo+PiArCQkJCSAgICAgICBBTURHUFVfR0VNX0RPTUFJTl9DUFUsIGZsYWdzLAo+PiAr
CQkJCSAgICAgICB0dG1fYm9fdHlwZV9zZywgcmVzdiwgJmdvYmopOwo+PiAgICAJaWYgKHJldCkK
Pj4gICAgCQlnb3RvIGVycm9yOwo+PiAgICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
