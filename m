Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32097C433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 07:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21452072A
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 07:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCiPs3i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21452072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38FB6E912;
	Wed,  2 Sep 2020 07:17:54 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 676586E912
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 07:17:54 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id g4so3556360wrs.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2020 00:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WL7vQ05smrbVHPwM1uEBFlH0i9OTrpyCz3f3gf3Tzac=;
 b=GCiPs3i7Sv4a2n7f2yOar6iom42RmW5axZj32TjmUxgDcb+Ym3k5tNGjAD4NJFxqZC
 vPEjDW/Vre8ttAy78pmDVZl1xGzoPONGGwuVOEj5p3DpFlp84xRUtQnHf3gW3KOiUH/f
 OYANl0ODN9XoHcugR2/Fap5XyVzu4EqZDHKvk6T01oMmEBhnKxxakJZEr1HZ7l+Ej7y6
 6/vk3EVgqCZzbi69JheC9CAi87oUEtX0zNGcEuiA6JPcVa2c2x2JPwXI7xRow+hJlWCj
 tQIc2B4k5VyLbUazvgKo6SoOrPWo3Llvx3ml7OHXotNTDphTFuixS0MKvlrHUqYHu5uq
 VPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=WL7vQ05smrbVHPwM1uEBFlH0i9OTrpyCz3f3gf3Tzac=;
 b=boXibQLykvzE1xBgWSs+LSQbjY7HDbRf3rA4gbz7a+4c11utZ6Rb6ZmBrFkKVsbepE
 1FOSFIJRRvCGtMknjiVXscheGBvKL/yINu+7vxOEJ4xa/y2VJ4sa+srjdikRiAcI2cJE
 2WnnHGtRbg9l6H+oPZBPyN5U1hwEMG/ORDEkTy70mfTvRE2dUZAXkBleH0EupQ1lPuc4
 6ayAR48DjHZ9uQAJWRlEb2peDKiTDsmvb8SXDJP3EMv9bLusXfU4SEfx1YUEA7Agxo/N
 8InHL4rVIDpAfT1TxCgBY2Ypq6ps9p0HQm3kKPSxlVOeudij8Ubtj1SqMGstcovxx2Yu
 tx5A==
X-Gm-Message-State: AOAM532Wgz5yn2UaTc6j69bYLrTx8Y5nfDW3wKDSS0bNux13DcJukicI
 PDB6M+La1eprzoMRM68egWo=
X-Google-Smtp-Source: ABdhPJz4YA74XclHml5Bnrj+rTGbjruBjsz8yhqBku4Ciq/BrAlTr7oCo3D9k1834ro8m578fPNsRQ==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr5586548wrt.84.1599031073086; 
 Wed, 02 Sep 2020 00:17:53 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d190sm5561201wmd.23.2020.09.02.00.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 00:17:52 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu/gmc10: print client id string for gfxhub
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200901215125.1402033-1-alexander.deucher@amd.com>
 <20200901215125.1402033-2-alexander.deucher@amd.com>
 <e6cc8a4a-90e5-fe47-cab8-15ae730212a5@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3a3e5bfe-1a11-daa3-c42e-d9ede6da63b1@gmail.com>
Date: Wed, 2 Sep 2020 09:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e6cc8a4a-90e5-fe47-cab8-15ae730212a5@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMDkuMjAgdW0gMDQ6MzIgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBTaG91bGQgdGhl
cmUgYSBjb3JyZXNwb25kaW5nIGNoYW5nZSBpbiBtbWh1Yl92Ml8wLmM/CgpJdCB3b3VsZCBiZSBh
dCBsZWFzdCBuaWNlIHRvIGhhdmUuCgpNYXliZSB3ZSBzaG91bGQgcHV0IGEgcG9pbnRlciB0byB0
aGUgYXJyYXkgYW5kIGl0cyBzaXplIGludG8gdGhlIGh1YiAKc3RydWN0dXJlIGluc3RlYWQ/CgpB
bnl3YXkgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4gZm9yIG5vdy4KCkNocmlzdGlhbi4KCj4KPiBPdGhlciB0aGFuIHRoYXQsIHRoZSBzZXJp
ZXMgaXMKPgo+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4KPgo+IE9uIDIwMjAtMDktMDEgNTo1MSBwLm0uLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+
IFByaW50IHRoZSBuYW1lIG9mIHRoZSBjbGllbnQgcmF0aGVyIHRoYW4gdGhlIG51bWJlci7CoCBU
aGlzCj4+IG1ha2VzIGl0IGVhc2llciB0byBkZWJ1ZyB3aGF0IGJsb2NrIGlzIGNhdXNpbmcgdGhl
IGZhdWx0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnho
dWJfdjJfMC5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrLS0tCj4+IMKgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92Ml8xLmMgfCAzMCArKysrKysrKysrKysrKysrKysrKyst
LS0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3Yy
XzAuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5jCj4+IGlu
ZGV4IDc2YWNkN2Y3NzIzZS4uYjg4MmFjNTk4NzlhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhodWJfdjJfMC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dmeGh1Yl92Ml8wLmMKPj4gQEAgLTMxLDYgKzMxLDI3IEBACj4+IMKgIMKgICNp
bmNsdWRlICJzb2MxNV9jb21tb24uaCIKPj4gwqAgK3N0YXRpYyBjb25zdCBjaGFyICpnZnhodWJf
Y2xpZW50X2lkc1tdID0gewo+PiArwqDCoMKgICJDQi9EQiIsCj4+ICvCoMKgwqAgIlJlc2VydmVk
IiwKPj4gK8KgwqDCoCAiR0UxIiwKPj4gK8KgwqDCoCAiR0UyIiwKPj4gK8KgwqDCoCAiQ1BGIiwK
Pj4gK8KgwqDCoCAiQ1BDIiwKPj4gK8KgwqDCoCAiQ1BHIiwKPj4gK8KgwqDCoCAiUkxDIiwKPj4g
K8KgwqDCoCAiVENQIiwKPj4gK8KgwqDCoCAiU1FDIChpbnN0KSIsCj4+ICvCoMKgwqAgIlNRQyAo
ZGF0YSkiLAo+PiArwqDCoMKgICJTUUciLAo+PiArwqDCoMKgICJSZXNlcnZlZCIsCj4+ICvCoMKg
wqAgIlNETUEwIiwKPj4gK8KgwqDCoCAiU0RNQTEiLAo+PiArwqDCoMKgICJHQ1IiLAo+PiArwqDC
oMKgICJTRE1BMiIsCj4+ICvCoMKgwqAgIlNETUEzIiwKPj4gK307Cj4+ICsKPj4gwqAgc3RhdGlj
IHVpbnQzMl90IGdmeGh1Yl92Ml8wX2dldF9pbnZhbGlkYXRlX3JlcSh1bnNpZ25lZCBpbnQgdm1p
ZCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdWludDMyX3QgZmx1c2hfdHlwZSkKPj4gwqAgewo+PiBAQCAtNTUsMTIgKzc2LDE1IEBA
IHN0YXRpYyB2b2lkCj4+IMKgIGdmeGh1Yl92Ml8wX3ByaW50X2wyX3Byb3RlY3Rpb25fZmF1bHRf
c3RhdHVzKHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldiwKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBzdGF0dXMpCj4+
IMKgIHsKPj4gK8KgwqDCoCB1MzIgY2lkID0gUkVHX0dFVF9GSUVMRChzdGF0dXMsCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgR0NWTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRV
UywgQ0lEKTsKPj4gKwo+PiDCoMKgwqDCoMKgIGRldl9lcnIoYWRldi0+ZGV2LAo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgIkdDVk1fTDJfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVM6MHglMDhYXG4iLAo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzKTsKPj4gLcKgwqDCoCBkZXZfZXJyKGFkZXYtPmRl
diwgIlx0IEZhdWx0eSBVVENMMiBjbGllbnQgSUQ6IDB4JWx4XG4iLAo+PiAtwqDCoMKgwqDCoMKg
wqAgUkVHX0dFVF9GSUVMRChzdGF0dXMsCj4+IC3CoMKgwqDCoMKgwqDCoCBHQ1ZNX0wyX1BST1RF
Q1RJT05fRkFVTFRfU1RBVFVTLCBDSUQpKTsKPj4gK8KgwqDCoCBkZXZfZXJyKGFkZXYtPmRldiwg
Ilx0IEZhdWx0eSBVVENMMiBjbGllbnQgSUQ6ICVzICgweCV4KVxuIiwKPj4gK8KgwqDCoMKgwqDC
oMKgIGNpZCA+PSBBUlJBWV9TSVpFKGdmeGh1Yl9jbGllbnRfaWRzKSA/ICJ1bmtub3duIiA6IAo+
PiBnZnhodWJfY2xpZW50X2lkc1tjaWRdLAo+PiArwqDCoMKgwqDCoMKgwqAgY2lkKTsKPj4gwqDC
oMKgwqDCoCBkZXZfZXJyKGFkZXYtPmRldiwgIlx0IE1PUkVfRkFVTFRTOiAweCVseFxuIiwKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgIFJFR19HRVRfRklFTEQoc3RhdHVzLAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgR0NWTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRVUywgTU9SRV9GQVVMVFMpKTsKPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeGh1Yl92Ml8xLmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4aHViX3YyXzEuYwo+PiBpbmRleCA4MGM5
MDZhMDM4M2YuLjIzN2E5ZmY1YWZhMCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvZ2Z4aHViX3YyXzEuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhodWJfdjJfMS5jCj4+IEBAIC0zMSw2ICszMSwyNyBAQAo+PiDCoCDCoCAjaW5jbHVkZSAi
c29jMTVfY29tbW9uLmgiCj4+IMKgICtzdGF0aWMgY29uc3QgY2hhciAqZ2Z4aHViX2NsaWVudF9p
ZHNbXSA9IHsKPj4gK8KgwqDCoCAiQ0IvREIiLAo+PiArwqDCoMKgICJSZXNlcnZlZCIsCj4+ICvC
oMKgwqAgIkdFMSIsCj4+ICvCoMKgwqAgIkdFMiIsCj4+ICvCoMKgwqAgIkNQRiIsCj4+ICvCoMKg
wqAgIkNQQyIsCj4+ICvCoMKgwqAgIkNQRyIsCj4+ICvCoMKgwqAgIlJMQyIsCj4+ICvCoMKgwqAg
IlRDUCIsCj4+ICvCoMKgwqAgIlNRQyAoaW5zdCkiLAo+PiArwqDCoMKgICJTUUMgKGRhdGEpIiwK
Pj4gK8KgwqDCoCAiU1FHIiwKPj4gK8KgwqDCoCAiUmVzZXJ2ZWQiLAo+PiArwqDCoMKgICJTRE1B
MCIsCj4+ICvCoMKgwqAgIlNETUExIiwKPj4gK8KgwqDCoCAiR0NSIiwKPj4gK8KgwqDCoCAiU0RN
QTIiLAo+PiArwqDCoMKgICJTRE1BMyIsCj4+ICt9Owo+PiArCj4+IMKgIHN0YXRpYyB1aW50MzJf
dCBnZnhodWJfdjJfMV9nZXRfaW52YWxpZGF0ZV9yZXEodW5zaWduZWQgaW50IHZtaWQsCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVp
bnQzMl90IGZsdXNoX3R5cGUpCj4+IMKgIHsKPj4gQEAgLTU1LDEyICs3NiwxNSBAQCBzdGF0aWMg
dm9pZAo+PiDCoCBnZnhodWJfdjJfMV9wcmludF9sMl9wcm90ZWN0aW9uX2ZhdWx0X3N0YXR1cyhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFkZXYsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3Qgc3RhdHVzKQo+PiDCoCB7Cj4+
ICvCoMKgwqAgdTMyIGNpZCA9IFJFR19HRVRfRklFTEQoc3RhdHVzLAo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEdDVk1fTDJfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMsIENJRCk7
Cj4+ICsKPj4gwqDCoMKgwqDCoCBkZXZfZXJyKGFkZXYtPmRldiwKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgICJHQ1ZNX0wyX1BST1RFQ1RJT05fRkFVTFRfU1RBVFVTOjB4JTA4WFxuIiwKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHN0YXR1cyk7Cj4+IC3CoMKgwqAgZGV2X2VycihhZGV2LT5kZXYsICJcdCBG
YXVsdHkgVVRDTDIgY2xpZW50IElEOiAweCVseFxuIiwKPj4gLcKgwqDCoMKgwqDCoMKgIFJFR19H
RVRfRklFTEQoc3RhdHVzLAo+PiAtwqDCoMKgwqDCoMKgwqAgR0NWTV9MMl9QUk9URUNUSU9OX0ZB
VUxUX1NUQVRVUywgQ0lEKSk7Cj4+ICvCoMKgwqAgZGV2X2VycihhZGV2LT5kZXYsICJcdCBGYXVs
dHkgVVRDTDIgY2xpZW50IElEOiAlcyAoMHgleClcbiIsCj4+ICvCoMKgwqDCoMKgwqDCoCBjaWQg
Pj0gQVJSQVlfU0laRShnZnhodWJfY2xpZW50X2lkcykgPyAidW5rbm93biIgOiAKPj4gZ2Z4aHVi
X2NsaWVudF9pZHNbY2lkXSwKPj4gK8KgwqDCoMKgwqDCoMKgIGNpZCk7Cj4+IMKgwqDCoMKgwqAg
ZGV2X2VycihhZGV2LT5kZXYsICJcdCBNT1JFX0ZBVUxUUzogMHglbHhcbiIsCj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCBSRUdfR0VUX0ZJRUxEKHN0YXR1cywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIEdD
Vk1fTDJfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMsIE1PUkVfRkFVTFRTKSk7Cj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcg
bGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
