Return-Path: <SRS0=HxJR=EZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0FCC2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 08:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8EC2064B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 08:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOcUDrXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8EC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70AC76E500;
	Thu, 19 Nov 2020 08:03:14 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05946E500
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2020 08:03:13 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id y17so6544389ejh.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2020 00:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gNGE/P57A1hAYJCjarjkCrAEBUNhamcqmeaW1ctxo7I=;
 b=gOcUDrXMJlA4W9igGIuq7wqdgOwNqoGkK8p15d65IAU/7xmrtjK2n18V8qj11AmZ5+
 3CI09XGmw/3Oc3gAOD8SVP1lZgjnKa/63tJ05JOFnKnZK1BZqi3wVQj4uwf6RkLdumTS
 1HdeQY6pCR8H/Qbq/WQdmHOMVi9IOQjlCizAmkNeyddGJzKEJgOduPfrzGNmN5kgSS6f
 /77pEFgLVTKFvzzBQLaxsv21HkXqOwTZ80zWhuJ/9Uz0CusznG1k6OYvtX1jwMVBo7ES
 DS67weJKIVPNWbCs2snSYMK0fnPDLyz8tUXxt/tMVovfNsmvnQBPWTnlR6Az6CH40GZF
 FPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=gNGE/P57A1hAYJCjarjkCrAEBUNhamcqmeaW1ctxo7I=;
 b=Hlsg8fa2YuFpyifT9AaNs+WqVdOxBfslrjNRf/+KIXlh4sM1z79jR8Nbbjva3ZHWi2
 eQ0sJ+Q0LNARxImHkqxg+4lJBvgBrN+iYHkNyeKeYCZFkoRxa9qUH4A9oM4a3eqYnseL
 eAju6C64DLFUzIlkmK0NmABSfneUhoXu6se9G7OyjPUngqj5Y+COgb5yfG+iHYlRbFGh
 wfTrvkEoR6Q/URCPwiY/iqyr3xco7rxhouZpw/GRBQct+8tT4w9oVCEwBYTlA2hLmEYR
 jl+QVzF6ZMwf5J35qhHZC+izSaUO3vE5hhTfdf+r6lH0ubx8Jo2XQPzgc0dNsJSiuTn2
 TFgg==
X-Gm-Message-State: AOAM531Bbfa8iRHaanIkXfcO5wy9q/nfSwtvA9Iza3BkscCoqD58VzUl
 aMx+d30e0PbDT2WyEmjZMSUYFloUoSU=
X-Google-Smtp-Source: ABdhPJwqcHxWmT4KIcpEC7lu8V1zWj8xVKHYTMGXRWf6H50j4Vc1+LwQyFP6t6tLgZrhiY1Uw994Gg==
X-Received: by 2002:a17:906:f753:: with SMTP id
 jp19mr26783271ejb.280.1605772992496; 
 Thu, 19 Nov 2020 00:03:12 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u2sm2193239edo.65.2020.11.19.00.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2020 00:03:11 -0800 (PST)
Subject: Re: [PATCH v3 3/5] drm/amdgpu/vcn: add test for dec vcn software ring
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
 <1605716641-22176-4-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2efd5e78-cdfb-f66c-2a50-bb8aab60d8de@gmail.com>
Date: Thu, 19 Nov 2020 09:03:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605716641-22176-4-git-send-email-James.Zhu@amd.com>
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMTEuMjAgdW0gMTc6MjMgc2NocmllYiBKYW1lcyBaaHU6Cj4gQWRkIHZjbiBzb2Z0d2Fy
ZSByaW5nIGRlY29kZSByaW5nIHRlc3QgYW5kIGRlY29kZSBpYiB0ZXN0Lgo+Cj4gU2lnbmVkLW9m
Zi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogTGVvIExp
dSA8bGVvLmxpdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdmNuLmMgfCAxMjEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxMjEgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uYwo+IGluZGV4IDMyMjUxZGIuLjFjOTcyNDQgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4gQEAgLTQ1Niw2ICs0NTYsMzcgQEAg
aW50IGFtZGdwdV92Y25fZGVjX3JpbmdfdGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmlu
ZykKPiAgIAlyZXR1cm4gcjsKPiAgIH0KPiAgIAo+ICtpbnQgYW1kZ3B1X3Zjbl9kZWNfc3dfcmlu
Z190ZXN0X3Jpbmcoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQo+ICt7Cj4gKwlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7Cj4gKwl1aW50MzJfdCBycHRyOwo+ICsJdW5z
aWduZWQgaW50IGk7Cj4gKwlpbnQgcjsKPiArCj4gKwlpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYp
KQo+ICsJCXJldHVybiAwOwo+ICsKPiArCXIgPSBhbWRncHVfcmluZ19hbGxvYyhyaW5nLCAxNik7
Cj4gKwlpZiAocikKPiArCQlyZXR1cm4gcjsKPiArCj4gKwlycHRyID0gYW1kZ3B1X3JpbmdfZ2V0
X3JwdHIocmluZyk7Cj4gKwo+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgVkNOX0RFQ19TV19D
TURfRU5EKTsKPiArCWFtZGdwdV9yaW5nX2NvbW1pdChyaW5nKTsKPiArCj4gKwlmb3IgKGkgPSAw
OyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsKPiArCQlpZiAoYW1kZ3B1X3JpbmdfZ2V0
X3JwdHIocmluZykgIT0gcnB0cikKPiArCQkJYnJlYWs7Cj4gKwkJdWRlbGF5KDEpOwo+ICsJfQo+
ICsKPiArCWlmIChpID49IGFkZXYtPnVzZWNfdGltZW91dCkKPiArCQlyID0gLUVUSU1FRE9VVDsK
PiArCj4gKwlyZXR1cm4gcjsKPiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNf
c2VuZF9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgCQkJCSAgIHN0cnVjdCBhbWRn
cHVfYm8gKmJvLAo+ICAgCQkJCSAgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKPiBAQCAtNjAx
LDYgKzYzMiw5NiBAQCBpbnQgYW1kZ3B1X3Zjbl9kZWNfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZywgbG9uZyB0aW1lb3V0KQo+ICAgCXJldHVybiByOwo+ICAgfQo+ICAgCj4g
K3N0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9kZWNfc3dfc2VuZF9tc2coc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nLAo+ICsJCQkJICAgc3RydWN0IGFtZGdwdV9ibyAqYm8sCj4gKwkJCQkgICBzdHJ1Y3Qg
ZG1hX2ZlbmNlICoqZmVuY2UpCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfdmNuX2RlY29kZV9idWZm
ZXIgKmRlY29kZV9idWZmZXIgPSBOVUxMOwo+ICsJY29uc3QgdW5zaWduZWQgaW50IGliX3NpemVf
ZHcgPSA2NDsKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRldjsKPiAr
CXN0cnVjdCBkbWFfZmVuY2UgKmYgPSBOVUxMOwo+ICsJc3RydWN0IGFtZGdwdV9qb2IgKmpvYjsK
PiArCXN0cnVjdCBhbWRncHVfaWIgKmliOwo+ICsJdWludDY0X3QgYWRkcjsKPiArCWludCBpLCBy
Owo+ICsKPiArCXIgPSBhbWRncHVfam9iX2FsbG9jX3dpdGhfaWIoYWRldiwgaWJfc2l6ZV9kdyAq
IDQsCj4gKwkJCQlBTURHUFVfSUJfUE9PTF9ESVJFQ1QsICZqb2IpOwo+ICsJaWYgKHIpCj4gKwkJ
Z290byBlcnI7Cj4gKwo+ICsJaWIgPSAmam9iLT5pYnNbMF07Cj4gKwlhZGRyID0gYW1kZ3B1X2Jv
X2dwdV9vZmZzZXQoYm8pOwo+ICsJaWItPmxlbmd0aF9kdyA9IDA7Cj4gKwo+ICsJaWItPnB0cltp
Yi0+bGVuZ3RoX2R3KytdID0gc2l6ZW9mKHN0cnVjdCBhbWRncHVfdmNuX2RlY29kZV9idWZmZXIp
ICsgODsKPiArCWliLT5wdHJbaWItPmxlbmd0aF9kdysrXSA9IGNwdV90b19sZTMyKEFNREdQVV9W
Q05fSUJfRkxBR19ERUNPREVfQlVGRkVSKTsKPiArCWRlY29kZV9idWZmZXIgPSAoc3RydWN0IGFt
ZGdwdV92Y25fZGVjb2RlX2J1ZmZlciAqKSYoaWItPnB0cltpYi0+bGVuZ3RoX2R3XSk7Cj4gKwlp
Yi0+bGVuZ3RoX2R3ICs9IHNpemVvZihzdHJ1Y3QgYW1kZ3B1X3Zjbl9kZWNvZGVfYnVmZmVyKSAv
IDQ7Cj4gKwltZW1zZXQoZGVjb2RlX2J1ZmZlciwgMCwgc2l6ZW9mKHN0cnVjdCBhbWRncHVfdmNu
X2RlY29kZV9idWZmZXIpKTsKPiArCj4gKwlkZWNvZGVfYnVmZmVyLT52YWxpZF9idWZfZmxhZyB8
PSBjcHVfdG9fbGUzMihBTURHUFVfVkNOX0NNRF9GTEFHX01TR19CVUZGRVIpOwo+ICsJZGVjb2Rl
X2J1ZmZlci0+bXNnX2J1ZmZlcl9hZGRyZXNzX2hpID0gY3B1X3RvX2xlMzIoYWRkciA+PiAzMik7
Cj4gKwlkZWNvZGVfYnVmZmVyLT5tc2dfYnVmZmVyX2FkZHJlc3NfbG8gPSBjcHVfdG9fbGUzMihh
ZGRyKTsKPiArCj4gKwlmb3IgKGkgPSBpYi0+bGVuZ3RoX2R3OyBpIDwgaWJfc2l6ZV9kdzsgKytp
KQo+ICsJCWliLT5wdHJbaV0gPSAweDA7Cj4gKwo+ICsJciA9IGFtZGdwdV9qb2Jfc3VibWl0X2Rp
cmVjdChqb2IsIHJpbmcsICZmKTsKPiArCWlmIChyKQo+ICsJCWdvdG8gZXJyX2ZyZWU7Cj4gKwo+
ICsJYW1kZ3B1X2JvX2ZlbmNlKGJvLCBmLCBmYWxzZSk7Cj4gKwlhbWRncHVfYm9fdW5yZXNlcnZl
KGJvKTsKPiArCWFtZGdwdV9ib191bnJlZigmYm8pOwo+ICsKPiArCWlmIChmZW5jZSkKPiArCQkq
ZmVuY2UgPSBkbWFfZmVuY2VfZ2V0KGYpOwo+ICsJZG1hX2ZlbmNlX3B1dChmKTsKPiArCj4gKwly
ZXR1cm4gMDsKPiArCj4gK2Vycl9mcmVlOgo+ICsJYW1kZ3B1X2pvYl9mcmVlKGpvYik7Cj4gKwo+
ICtlcnI6Cj4gKwlhbWRncHVfYm9fdW5yZXNlcnZlKGJvKTsKPiArCWFtZGdwdV9ib191bnJlZigm
Ym8pOwo+ICsJcmV0dXJuIHI7Cj4gK30KPiArCj4gK2ludCBhbWRncHVfdmNuX2RlY19zd19yaW5n
X3Rlc3RfaWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBsb25nIHRpbWVvdXQpCj4gK3sKPiAr
CXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlID0gTlVMTDsKPiArCXN0cnVjdCBhbWRncHVfYm8gKmJv
Owo+ICsJbG9uZyByOwo+ICsKPiArCXIgPSBhbWRncHVfdmNuX2RlY19nZXRfY3JlYXRlX21zZyhy
aW5nLCAxLCAmYm8pOwo+ICsJaWYgKHIpCj4gKwkJZ290byBlcnJvcjsKPiArCj4gKwlyID0gYW1k
Z3B1X3Zjbl9kZWNfc3dfc2VuZF9tc2cocmluZywgYm8sIE5VTEwpOwo+ICsJaWYgKHIpCj4gKwkJ
Z290byBlcnJvcjsKPiArCXIgPSBhbWRncHVfdmNuX2RlY19nZXRfZGVzdHJveV9tc2cocmluZywg
MSwgJmJvKTsKPiArCWlmIChyKQo+ICsJCWdvdG8gZXJyb3I7Cj4gKwo+ICsJciA9IGFtZGdwdV92
Y25fZGVjX3N3X3NlbmRfbXNnKHJpbmcsIGJvLCAmZmVuY2UpOwo+ICsJaWYgKHIpCj4gKwkJZ290
byBlcnJvcjsKPiArCj4gKwlyID0gZG1hX2ZlbmNlX3dhaXRfdGltZW91dChmZW5jZSwgZmFsc2Us
IHRpbWVvdXQpOwo+ICsJaWYgKHIgPT0gMCkKPiArCQlyID0gLUVUSU1FRE9VVDsKPiArCWVsc2Ug
aWYgKHIgPiAwKQo+ICsJCXIgPSAwOwo+ICsKPiArCWRtYV9mZW5jZV9wdXQoZmVuY2UpOwo+ICtl
cnJvcjoKPiArCXJldHVybiByOwo+ICt9Cj4gKwo+ICAgaW50IGFtZGdwdV92Y25fZW5jX3Jpbmdf
dGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
