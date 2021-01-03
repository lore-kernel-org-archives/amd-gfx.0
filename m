Return-Path: <SRS0=L9B0=GG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF99C433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Jan 2021 16:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7904E20936
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Jan 2021 16:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7904E20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB04B892FE;
	Sun,  3 Jan 2021 16:10:52 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7803892FE
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Jan 2021 16:10:51 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id t16so4102493ejf.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Jan 2021 08:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pw/sClNsr+nucWweo1/7ZgzrbX9hWSee/x4lIP+m670=;
 b=WJqaV6DA2AOQrlqJdAQKJ3+7J+z4LDpK3Lu5puwAn/vjXLEwQgJp2BCpH4vnQ7AWA8
 FJMZ+RV6ktNMrflPgUDc1hJee9RysW6AGk0bCrUtye2IohQqg66x1b2ZziolcmDslg7G
 bKpyNCiFxrJQBrMjwlDKetxpS/f3nQUuQ1KGOnEHJX59yproLlimPkT4DC6PKpLUIauZ
 SI2bxpJqUwQje7gf3aoqixiExYQijaboeGcEqLkGGgJdFou7FqwVJZX5UzHfRCAVOMK7
 SiQLpdp8nUkbHjO717CBiLJB2bnpQlfFYq/Hd0nI5Cmwr+DcqiIkCtLOB27pPzJoh2/1
 /Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=pw/sClNsr+nucWweo1/7ZgzrbX9hWSee/x4lIP+m670=;
 b=A0wufSccfHqwC1Em2AP9z2LI1H3WwmoxGIFnFkpPoYzkknt+fmYcPStsI2rMMKjOvT
 f2HlkYZ5w6N9lzL1nrg7K0SFq3TgXEMBqVssHWyDztsXOz7xnzsED+ZOuoAc8WhVtfqM
 ezFCasxMh35nyB91QEmmFmqQXE7GQ7b3kcDwfDA8bPwrMKUoWCb1J2Jn8WCLWM0qmHIm
 TE5qerpxPvKuYo2+FIGAtW/qyikkV55xoYftwCM1Sh5yZnl33UyGMWm0wUD6Ge+eXGA8
 8zF3W4ncGHf3xNf+LaEQ2ZeTjNacvVLH5MkShxirdQ4LYz5sQc439SrRS0FzrbcSTK6Q
 GZ0A==
X-Gm-Message-State: AOAM532RE++Qd/m1xwamWo99Nq67GuhXOSe723S1YWWjyjUngxYgrEfV
 i4nJ8d0fMrdoqTjw18n09xLGBl12xXM=
X-Google-Smtp-Source: ABdhPJycIjzGEPMhxEDNFEF4/KklXIV6hRokVBCb/OfXKrO/UwQYRDK75FFGVqCnevwZmTdkfoAETQ==
X-Received: by 2002:a17:906:98d4:: with SMTP id
 zd20mr64076714ejb.532.1609690250499; 
 Sun, 03 Jan 2021 08:10:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s19sm42939518edx.7.2021.01.03.08.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jan 2021 08:10:49 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix potential NULL pointer when
 check_atom_bios() fails
To: Jiawei Gu <Jiawei.Gu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201231084741.11865-1-Jiawei.Gu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8f624104-d074-9d92-7d6c-bb28d7f4ea78@gmail.com>
Date: Sun, 3 Jan 2021 17:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201231084741.11865-1-Jiawei.Gu@amd.com>
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
Cc: emily.deng@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzEuMTIuMjAgdW0gMDk6NDcgc2NocmllYiBKaWF3ZWkgR3U6Cj4gQXNpYyBmdW5jcyBwb2lu
dGVyIG5lZWRzIGJlaW5nIGNoZWNrZWQgd2hldGhlciBpcyBOVUxMLiBCZWNhdXNlIHdoZW4KPiBj
aGVja19hdG9tX2Jpb3MoKSBmYWlscyBpbiByZXFfaW5pdF9kYXRhIGhhbmRzaGFrZSwgYXNpYyBm
dW5jcyBwb2ludGVyCj4gaXMgbm90IGluaXRpYWxpemVkIHlldC4KCk1obSwgSSdtIHdvbmRlcmlu
ZyBpZiB3ZSBzaG91bGRuJ3QgY2hhbmdlIHRoZSBpbml0IHNlcXVlbmNlIHRoZW4uIFRoZSAKYXNp
Y19mdW5jcyBpcyBzb21ldGhpbmcgcHJldHR5IGZ1bmRhbWVudGFsLgoKPiBTaWduZWQtb2ZmLWJ5
OiBKaWF3ZWkgR3UgPEppYXdlaS5HdUBhbWQuY29tPgoKQWNrZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIG5vdy4KCj4gLS0tCj4gICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jIHwgNSArKystLQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2Jpb3MuYwo+IGluZGV4IDYzMzNjYWRhMWUwOS4uZWZkZjYzOWY2
NTkzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iaW9z
LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmlvcy5jCj4gQEAg
LTE1NSw3ICsxNTUsNyBAQCBzdGF0aWMgYm9vbCBhbWRncHVfcmVhZF9iaW9zX2Zyb21fcm9tKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCXU4IGhlYWRlcltBTURfVkJJT1NfU0lHTkFU
VVJFX0VORCsxXSA9IHswfTsKPiAgIAlpbnQgbGVuOwo+ICAgCj4gLQlpZiAoIWFkZXYtPmFzaWNf
ZnVuY3MtPnJlYWRfYmlvc19mcm9tX3JvbSkKPiArCWlmICghYWRldi0+YXNpY19mdW5jcyB8fCAh
YWRldi0+YXNpY19mdW5jcy0+cmVhZF9iaW9zX2Zyb21fcm9tKQo+ICAgCQlyZXR1cm4gZmFsc2U7
Cj4gICAKPiAgIAkvKiB2YWxpZGF0ZSBWQklPUyBzaWduYXR1cmUgKi8KPiBAQCAtMzQ4LDcgKzM0
OCw4IEBAIHN0YXRpYyBib29sIGFtZGdwdV9yZWFkX2Rpc2FibGVkX2Jpb3Moc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4gICAJaWYgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkKPiAgIAkJ
cmV0dXJuIGlncF9yZWFkX2Jpb3NfZnJvbV92cmFtKGFkZXYpOwo+ICAgCWVsc2UKPiAtCQlyZXR1
cm4gYW1kZ3B1X2FzaWNfcmVhZF9kaXNhYmxlZF9iaW9zKGFkZXYpOwo+ICsJCXJldHVybiAoIWFk
ZXYtPmFzaWNfZnVuY3MgfHwgIWFkZXYtPmFzaWNfZnVuY3MtPnJlYWRfZGlzYWJsZWRfYmlvcykg
Pwo+ICsJCQlmYWxzZSA6IGFtZGdwdV9hc2ljX3JlYWRfZGlzYWJsZWRfYmlvcyhhZGV2KTsKPiAg
IH0KPiAgIAo+ICAgI2lmZGVmIENPTkZJR19BQ1BJCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
