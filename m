Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B8C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8566105A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 06:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8566105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBB16E8EB;
	Wed, 14 Apr 2021 06:53:01 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A936E8EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 06:53:00 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id w23so13911894ejb.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=cg1SUUgOjXZ2HI+IuMdIcyfY6xMn/bXOadAtaUq8BFQ=;
 b=T6QWneTJ4nKHQdoaOm/zNbstxapXy7HILfwpF0m2sn88QihDLIX+hnZ/5IpWZRAfcc
 Q5+/gxnzdaB79R91gaEuJHbFLlaweLPTxCv8xjFke7omAItSgkmsQb1X0Z5xjKuT6NDO
 Ksz5m111Azq8dYLFhG8H8Uh3hznm2KkG5T+ulWPmdtThF9UXkz5Yloulf2Z0+lCpNC82
 zqSpas9XYOCR/j+dQbw7LT2dkLFoicxCKrTH7qVurkb22KpXAq+jhcohzJBhDlUcJCZZ
 uYGPF6yVwCMVxHEtLCEen7vtuYEwBDdKtyUIX2TbiMDKehwDXt1iL9q2ZTMLxX1c5mxL
 rRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=cg1SUUgOjXZ2HI+IuMdIcyfY6xMn/bXOadAtaUq8BFQ=;
 b=TRMH3Vs20oDRzBHvOXgdVx+XlGOPHkdE3ZZppQsZDJPqWrGn0Q37BAF/ljv7UTMd95
 8w1LFJItgCRD6WbJ9lF1Rv/VadV0Iya4zZyOeYyWIRaaGAip7WycS5b1bpJ6bSUC/Lgx
 kwOuYlTLoEVGPCuHmtMUqM0L2S0uUs4PW7oDYs8f4BLj/GsiM/DozeIVtQ6EFmisN/P4
 LFV7Be5wSrsyBf9N4G7teqJCwhl5Ccfz1vCpcCzVbqM+t0u0A/GDu0kQ1XYlRUoV48p+
 S/Ucvc7qaw+QHBXkna4tmCwb3bTyEcgVEMmiN/KSy8QMV9vyPiez8hSOlf8KxfFVnkXf
 hEDw==
X-Gm-Message-State: AOAM5310pk4q8qwRCS+xbj+yad5pqvhDh1pBKHHlzZniyhVMzbaBOiBu
 U3rlxEaEpIEyEupl9lkF0JNUHZoa2Iw=
X-Google-Smtp-Source: ABdhPJxt9Rs1QbsuDGXaZWHHB7y5xU5IpCZlaU931FFzF045rwtfTMvN99N8JxTGZyXDJvRuAVlL0w==
X-Received: by 2002:a17:906:fa83:: with SMTP id
 lt3mr10115335ejb.299.1618383179130; 
 Tue, 13 Apr 2021 23:52:59 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:eb49:bad8:5b80:ea48?
 ([2a02:908:1252:fb60:eb49:bad8:5b80:ea48])
 by smtp.gmail.com with ESMTPSA id s11sm11042581edt.27.2021.04.13.23.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 23:52:58 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: use pre-calculated bo size
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210413205740.24120-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f785cd6d-7c3e-8967-05e6-ea144832021a@gmail.com>
Date: Wed, 14 Apr 2021 08:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413205740.24120-1-nirmoy.das@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTMuMDQuMjEgdW0gMjI6NTcgc2NocmllYiBOaXJtb3kgRGFzOgo+IFVzZSBiby0+dGJvLmJh
c2Uuc2l6ZSBpbnN0ZWFkIG9mIGNhbGN1bGF0aW5nIGl0IGZyb20gbnVtX3BhZ2VzLgoKVGhvc2Ug
ZG9uJ3QgY2xhc2ggd2l0aCB0aGUgdHdvIEkndmUgc2VuZCBvdXQgeWVzdGVyZGF5LCBkb24ndCB0
aGV5PwoKPgo+IFNpZ25lZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4K
ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIHwg
MiArLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jICAgIHwgMiAr
LQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gaW5kZXggMTM0
NWY3ZWJhMDExLi43NGVjYzBjMTg2M2YgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jCj4gQEAgLTEzNzEsNyArMTM3MSw3IEBAIHZtX2ZhdWx0X3QgYW1k
Z3B1X2JvX2ZhdWx0X3Jlc2VydmVfbm90aWZ5KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8p
Cj4gICAJaWYgKGJvLT5tZW0ubWVtX3R5cGUgIT0gVFRNX1BMX1ZSQU0pCj4gICAJCXJldHVybiAw
Owo+ICAgCj4gLQlzaXplID0gYm8tPm1lbS5udW1fcGFnZXMgPDwgUEFHRV9TSElGVDsKPiArCXNp
emUgPSBiby0+YmFzZS5zaXplOwo+ICAgCW9mZnNldCA9IGJvLT5tZW0uc3RhcnQgPDwgUEFHRV9T
SElGVDsKPiAgIAlpZiAoKG9mZnNldCArIHNpemUpIDw9IGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1f
c2l6ZSkKPiAgIAkJcmV0dXJuIDA7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYwo+IGluZGV4IDkzNmIzY2ZkZGU1NS4uMjZkZWFjZTc4NTM5IDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IEBAIC0yMDQ4LDcgKzIwNDgsNyBAQCBpbnQg
YW1kZ3B1X2ZpbGxfYnVmZmVyKHN0cnVjdCBhbWRncHVfYm8gKmJvLAo+ICAgCQkJcmV0dXJuIHI7
Cj4gICAJfQo+ICAgCj4gLQludW1fYnl0ZXMgPSBiby0+dGJvLm1lbS5udW1fcGFnZXMgPDwgUEFH
RV9TSElGVDsKPiArCW51bV9ieXRlcyA9IGJvLT50Ym8uYmFzZS5zaXplOwo+ICAgCW51bV9sb29w
cyA9IDA7Cj4gICAKPiAgIAlhbWRncHVfcmVzX2ZpcnN0KCZiby0+dGJvLm1lbSwgMCwgbnVtX2J5
dGVzLCAmY3Vyc29yKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
