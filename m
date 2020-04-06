Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73673C2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 19:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDBB206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 19:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ+KHHaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDBB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D716E0E0;
	Mon,  6 Apr 2020 19:02:12 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2F96E0E0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 19:02:11 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id 65so834524wrl.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JnySRaCTVOvFOB88ee6tqSrk8W46qAqf92NziYmz9iU=;
 b=VJ+KHHaNWXP22djT/iJa6KGDgscHHCfDS21wNKPjnxZhmo8eF9oLNMif9aa2hNrCCe
 Xgfdojo1iTR6xma3kBgiT3LQZeA6ua+hRsRdEkeaTzEbrTl4eQ6l1u6xTu9tx/oWJS0Y
 rt2C7KXEeSqPkoH0S1dGEY+T+l2HIzDwltNbE6fjFJP/vX8aFPk3ZkY8c6MY6cskqkFG
 2hx60OG7N8YPL47of21gzpydvUVXHyGrqVSSnPz2HNZEii5sb9md0EQvfiv5Kz2tncrB
 /1ZhyxDlb4ybStjdNabkMM6oTOBlc8qI7//spV+v3P5FbI0zEeSSphGXQF/ffgwtd8FJ
 9NYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=JnySRaCTVOvFOB88ee6tqSrk8W46qAqf92NziYmz9iU=;
 b=NSR7WIP3O/lmqyB5C2u9b9LgHiANnlDYmJCeH5zpbCj6xoXx0YYwW8FGlYdoMVK/yR
 GL4ox1I3H1YPtxjbndLtUc6bx3mTOra1fBTsRxZE70ZSNKoYvs0OTWfewnIggrCcTnHi
 GLmfiXdlpwkKdeB7YKhfmk7Q5+p2OKDUuTlaTXG0VOUgSp0uWjqt3RnsWMBD1OvkF1gb
 LTIKxfsh8L6UcnMdmhQB+qetnyXi11tSGLUDWruMQfU1Csc5/m6EPXQVO0DUd3LLRiZR
 s85T/Q8UBYFCCGGXNuaE4x6c5kES3NoIrKr3/WwXaaCJaPDKzQoYlNZNXrvTZmobdJa+
 8xWQ==
X-Gm-Message-State: AGi0Puag5XoAzB+ztiDH+wY57AAGm6352R+Y65y0z+TqCPaSfYDuVABV
 BX1nJ4LPFkJwgaZSTDiSkmYUumho
X-Google-Smtp-Source: APiQypK0IXOqZPPrh4kFXkvM8YUIyXlsOjKhhEf6sMBBpmA/amv5Cs5dN1DZl47ZySYMHpU8WNGpEQ==
X-Received: by 2002:a5d:5551:: with SMTP id g17mr679253wrw.290.1586199730013; 
 Mon, 06 Apr 2020 12:02:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y33sm12776326wrd.84.2020.04.06.12.02.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Apr 2020 12:02:09 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Print UTCL2 client ID on a gpuvm fault
To: Alex Deucher <alexdeucher@gmail.com>, Oak Zeng <Oak.Zeng@amd.com>
References: <1586194947-13405-1-git-send-email-Oak.Zeng@amd.com>
 <CADnq5_Pxhy9sjxEPZp3gTsVhEcYL7DbrRJ1ATMk21Wq4wcQ+Cg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <30e33eb2-c9a7-192c-fd49-d86af212cf7e@gmail.com>
Date: Mon, 6 Apr 2020 21:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_Pxhy9sjxEPZp3gTsVhEcYL7DbrRJ1ATMk21Wq4wcQ+Cg@mail.gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDYuMDQuMjAgdW0gMjA6NDYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gTW9uLCBBcHIg
NiwgMjAyMCBhdCAxOjQyIFBNIE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPiB3cm90ZToKPj4g
VVRDTDIgY2xpZW50IElEIGlzIHVzZWZ1bCBpbmZvcm1hdGlvbiB0byBnZXQgd2hpY2gKPj4gVVRD
TDIgY2xpZW50IGNhdXNlZCB0aGUgZ3B1dm0gZmF1bHQuIFByaW50IGl0IG91dAo+PiBmb3IgZGVi
dWcgcHVycG9zZQo+Pgo+PiBDaGFuZ2UtSWQ6IEk3MzNkMDEyN2IwZWU1M2FhNzg4ZjE5NGNlZmE1
M2NiYjU1YjQ5YzExCj4+IFNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29t
Pgo+IFJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgoKPgo+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5j
IHwgMyArKysKPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jICB8IDMg
KysrCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPj4gaW5kZXggNzhkNzY5ZS4uOTRhNjA5NiAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPj4gQEAgLTE3MCw2ICsx
NzAsOSBAQCBzdGF0aWMgaW50IGdtY192MTBfMF9wcm9jZXNzX2ludGVycnVwdChzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYWRl
di0+ZGV2LAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiR0NWTV9MMl9QUk9U
RUNUSU9OX0ZBVUxUX1NUQVRVUzoweCUwOFhcbiIsCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0YXR1cyk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYWRl
di0+ZGV2LCAiXHQgRmF1bHR5IFVUQ0wyIGNsaWVudCBJRDogMHglbHhcbiIsCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUkVHX0dFVF9GSUVMRChzdGF0dXMsCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgR0NWTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRVUywg
Q0lEKSk7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGFkZXYtPmRldiwgIlx0
IE1PUkVfRkFVTFRTOiAweCVseFxuIiwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUkVHX0dFVF9GSUVMRChzdGF0dXMsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEdDVk1fTDJfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMsIE1PUkVfRkFVTFRTKSk7Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+PiBpbmRleCA4NjA2Zjg3Li5mZWNkYmM0
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4gQEAgLTM2Miw2
ICszNjIsOSBAQCBzdGF0aWMgaW50IGdtY192OV8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2Vycihh
ZGV2LT5kZXYsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJWTV9MMl9QUk9U
RUNUSU9OX0ZBVUxUX1NUQVRVUzoweCUwOFhcbiIsCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0YXR1cyk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoYWRl
di0+ZGV2LCAiXHQgRmF1bHR5IFVUQ0wyIGNsaWVudCBJRDogMHglbHhcbiIsCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUkVHX0dFVF9GSUVMRChzdGF0dXMsCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVk1fTDJfUFJPVEVDVElPTl9GQVVMVF9TVEFUVVMsIENJ
RCkpOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycihhZGV2LT5kZXYsICJcdCBN
T1JFX0ZBVUxUUzogMHglbHhcbiIsCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFJFR19HRVRfRklFTEQoc3RhdHVzLAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBWTV9MMl9QUk9URUNUSU9OX0ZBVUxUX1NUQVRVUywgTU9SRV9GQVVMVFMpKTsKPj4gLS0KPj4g
Mi43LjQKPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
