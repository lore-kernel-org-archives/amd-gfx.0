Return-Path: <SRS0=IZgh=DY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6ECC433DF
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2020 11:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F202520704
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2020 11:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg0WO+pM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F202520704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567B56E0A1;
	Sat, 17 Oct 2020 11:52:01 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D0A6E072
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2020 11:52:00 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id e2so8171481wme.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2020 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=e8DaKCmJgsVTz8bGXjHo0e0W7xYpJ3ZMcypQgpchjw0=;
 b=eg0WO+pMSozKPuMLg+ilwiliZ3pOUOxDJkWAMAXOEim7BxbMO+HZyOCvW9kdXYlI8k
 foC5bUFcSAzXiJoOdsLIm7jPnNrTnUwaiqtceK8BoePNlzuoHHFpwL9K07zArQSNShWk
 e8yWr7Ch9zwPsiok8OAimlpyY8ZcZnLbqF5vLRrQvl7RJzgJH8M1uiN+F5vsaNJ6Sb+5
 WPkskte6cUNFbGEmTXgYaH9GV/ny6kFo42lHW74M2ASZVpMTvmMCAMc2AHbWTvUTEIrh
 mah47fs4Jc51/e1WkMoFa3DxiUJebJRN1Qxj72pokGdkcvgcsUDxCZh3+wVxmJ6WAPMI
 /jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=e8DaKCmJgsVTz8bGXjHo0e0W7xYpJ3ZMcypQgpchjw0=;
 b=RkTaSTCVnyWwd0PqanhgpBqTRBfaad8j/Yf4L/5w63kRGEja92MYb9d8pMxcq4dfKt
 svlbB4ndLCrZIktUQDLHe6wmjEI9oy62h7mkpCzV/Q5nr0GxrVbQQqVFI/znWtJTOZhq
 El21sJbA8Ac3fPrrkbMja53ITi99dkUrCtZJx80q/AS0NAi9QZHKPY4fpAZaf7BINaH3
 4ZLJfgdt+MlFaUOfM1c5P6vZqP6MI7cEzHM40+JUS0gZeN92EboHPdAYl/VP3OCX/2fh
 cIH9EBBArKtDkr2KuvbwG9vpKqfAHWtMTCDXstBekvymYRXx0kwxG7rLIvq/q1CThgG8
 3IjQ==
X-Gm-Message-State: AOAM532/uV2OthkkLGp2UAzIbM6Lp1aPhYCZy45sOQKKxLmV+Wvfta9u
 iH6AshwJ2L6b//dl3kfoEaU=
X-Google-Smtp-Source: ABdhPJy+UHT/n1QydJDcB7A1PDHiT0SvHDE5XEBEPBkNTIK5YJTHwe14YYhFao1hAwsrnGUY8fzWvg==
X-Received: by 2002:a1c:ddc2:: with SMTP id u185mr8443451wmg.21.1602935519239; 
 Sat, 17 Oct 2020 04:51:59 -0700 (PDT)
Received: from [192.168.137.56]
 (dynamic-002-244-048-143.2.244.pool.telefonica.de. [2.244.48.143])
 by smtp.gmail.com with ESMTPSA id n5sm8364098wrm.2.2020.10.17.04.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 04:51:58 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/gmc10: remove dummy read workaround for newer
 chips
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201016165735.1232180-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d3870a0d-1d9c-7e82-344e-d7e5eafabe99@gmail.com>
Date: Sat, 17 Oct 2020 13:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016165735.1232180-1-alexander.deucher@amd.com>
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

QW0gMTYuMTAuMjAgdW0gMTg6NTcgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gU2llbm5hIENpY2hs
aWQgYW5kIG5ld2VyIGhhdmUgYSBodyBmaXggc28gbm8gbG9uZ2VyIHJlcXVpcmUKPiB0aGUgd29y
a2Fyb3VuZC4KPgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Yx
MF8wLmMgfCA2ICsrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jCj4gaW5k
ZXggZjdhODQxN2IyOTQ2Li40MGFmMTc2MTAyMDcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjEwXzAuY2JyYWhtYS9hbWQtc3RhZ2luZy1kcm0tbmV4dAo+IEBAIC0xMDcsNyAr
MTA3LDggQEAgc3RhdGljIGludCBnbWNfdjEwXzBfcHJvY2Vzc19pbnRlcnJ1cHQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsCj4gICAJCSAqIGJlIHVwZGF0ZWQgdG8gYXZvaWQgcmVhZGluZyBh
biBpbmNvcnJlY3QgdmFsdWUgZHVlIHRvCj4gICAJCSAqIHRoZSBuZXcgZmFzdCBHUkJNIGludGVy
ZmFjZS4KPiAgIAkJICovCj4gLQkJaWYgKGVudHJ5LT52bWlkX3NyYyA9PSBBTURHUFVfR0ZYSFVC
XzApCj4gKwkJaWYgKChlbnRyeS0+dm1pZF9zcmMgPT0gQU1ER1BVX0dGWEhVQl8wKSAmJgo+ICsJ
CSAgICAoYWRldi0+YXNpY190eXBlIDwgQ0hJUF9TSUVOTkFfQ0lDSExJRCkpCj4gICAJCQlSUkVH
MzIoaHViLT52bV9sMl9wcm9fZmF1bHRfc3RhdHVzKTsKPiAgIAo+ICAgCQlzdGF0dXMgPSBSUkVH
MzIoaHViLT52bV9sMl9wcm9fZmF1bHRfc3RhdHVzKTsKPiBAQCAtMjMyLDcgKzIzMyw4IEBAIHN0
YXRpYyB2b2lkIGdtY192MTBfMF9mbHVzaF92bV9odWIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHVpbnQzMl90IHZtaWQsCj4gICAJICogSXNzdWUgYSBkdW1teSByZWFkIHRvIHdhaXQgZm9y
IHRoZSBBQ0sgcmVnaXN0ZXIgdG8gYmUgY2xlYXJlZAo+ICAgCSAqIHRvIGF2b2lkIGEgZmFsc2Ug
QUNLIGR1ZSB0byB0aGUgbmV3IGZhc3QgR1JCTSBpbnRlcmZhY2UuCj4gICAJICovCj4gLQlpZiAo
dm1odWIgPT0gQU1ER1BVX0dGWEhVQl8wKQo+ICsJaWYgKCh2bWh1YiA9PSBBTURHUFVfR0ZYSFVC
XzApICYmCj4gKwkgICAgKGFkZXYtPmFzaWNfdHlwZSA8IENISVBfU0lFTk5BX0NJQ0hMSUQpKQo+
ICAgCQlSUkVHMzJfTk9fS0lRKGh1Yi0+dm1faW52X2VuZzBfcmVxICsgaHViLT5lbmdfZGlzdGFu
Y2UgKiBlbmcpOwo+ICAgCj4gICAJLyogV2FpdCBmb3IgQUNLIHdpdGggYSBkZWxheS4qLwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
