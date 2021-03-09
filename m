Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1FFC433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54916523F
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 12:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54916523F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 523926E49C;
	Tue,  9 Mar 2021 12:40:03 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B3646E49C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 12:40:01 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id hs11so27225318ejc.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Mar 2021 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=m2c+ix45eCsGuRluPK59QmSZHlWmoT1FyPkTRpQKmC4=;
 b=PP7ocw/Vn6GGMGlwCqFo93i8Cp4mbWUtrirRkaYQoA8CGW15w7Mjiw3qGqQmP4uBAz
 V4IngWVdyMPl6ZeY8g4GMv2Tb2JLmYZJBSyuFDN53psiF3w3CfHXcbFP2KKd/fKmTai5
 hhkheMCfLBXbju/wzV2KXY0GIw0cxHcAk/z/8/dD9iZf3O2nR1GAG26Lr+j8hf8lJVoL
 99Qi+lvuTI33dpqAFI6gqZTFH2DMHplgzmmwFO5e5qGakMOciUOufzxYamtKM823uyeU
 00oM90s17DxeL/CzT85KaPQTnVtChKuplXToSJczACfsjj94DCWseOWssWoK/pcKFBSm
 3ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=m2c+ix45eCsGuRluPK59QmSZHlWmoT1FyPkTRpQKmC4=;
 b=n89CHI+rVjPTxyNIJQRn+1MZEkAKFKNoHBeWlVB0yG9IAkZsqDrGeUuPBJkgXlFVxh
 nU+ir+hi31Wwkml0NIgSYzAQ3BkH/oaWiiDwg7kN6aYa0O1NNUZn9r2NcM2Ca8C9xdBR
 4AHplZuyy1221h6whCTmzF/I0hiEZYunyrp7L/mudGKpcHb3D4I5/1Z4c/C2NiMi8F6E
 M34g1VLS26l3nevfBajnppCSP4THxEmW/leZosvSot3RHvqVrjJqqpeOVThlqsuBcL8A
 rvYts+Afn6grnKe9LXtGZaUgWlBsB8cOh4T2A+dDRekLEip+caUwhOD7isyDQO3OAh5q
 JkAg==
X-Gm-Message-State: AOAM5330ldfbcW7epnSAhwf1cF//n9vwYv9Up5MV9ooBkXXIlD09A3DD
 xwj6CpSTCjDa8KJiLwqWcPYU2skXzfP5OQ==
X-Google-Smtp-Source: ABdhPJyVzagQnvn100wt4wOq9R38BSwq5IEjONqNs3XgqD4lOYlqJejlGxgJ4abd5VbTw1ICC3eEyw==
X-Received: by 2002:a17:906:2312:: with SMTP id
 l18mr20616875eja.468.1615293600226; 
 Tue, 09 Mar 2021 04:40:00 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe?
 ([2a02:908:1252:fb60:7f9b:4f7c:c70d:c3fe])
 by smtp.gmail.com with ESMTPSA id h10sm9236902edk.17.2021.03.09.04.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Mar 2021 04:39:59 -0800 (PST)
Subject: Re: [PATCH 3/5] drm/amdgpu: fb BO should be ttm_bo_type_device
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210309084659.37649-1-nirmoy.das@amd.com>
 <20210309084659.37649-3-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <03c65172-7b17-7b80-7b15-cc687fb45fa0@gmail.com>
Date: Tue, 9 Mar 2021 13:39:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210309084659.37649-3-nirmoy.das@amd.com>
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

QW0gMDkuMDMuMjEgdW0gMDk6NDYgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZCIEJPIHNob3VsZCBu
b3QgYmUgdHRtX2JvX3R5cGVfa2VybmVsIHR5cGUgYW5kCj4gYW1kZ3B1ZmJfY3JlYXRlX3Bpbm5l
ZF9vYmplY3QoKSBwaW5zIHRoZSBGQiBCTyBhbnl3YXkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJt
b3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+Cj4gQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9mYi5jIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2ZiLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIu
Ywo+IGluZGV4IDUxY2Q0OWM2ZjM4Zi4uMjQwMTBjYWNmN2QwIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMKPiBAQCAtMTQ2LDcgKzE0Niw3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1ZmJfY3JlYXRlX3Bpbm5lZF9vYmplY3Qoc3RydWN0IGFtZGdwdV9mYmRldiAqcmZiZGV2
LAo+ICAgCXNpemUgPSBtb2RlX2NtZC0+cGl0Y2hlc1swXSAqIGhlaWdodDsKPiAgIAlhbGlnbmVk
X3NpemUgPSBBTElHTihzaXplLCBQQUdFX1NJWkUpOwo+ICAgCXJldCA9IGFtZGdwdV9nZW1fb2Jq
ZWN0X2NyZWF0ZShhZGV2LCBhbGlnbmVkX3NpemUsIDAsIGRvbWFpbiwgZmxhZ3MsCj4gLQkJCQkg
ICAgICAgdHRtX2JvX3R5cGVfa2VybmVsLCBOVUxMLCAmZ29iaik7Cj4gKwkJCQkgICAgICAgdHRt
X2JvX3R5cGVfZGV2aWNlLCBOVUxMLCAmZ29iaik7CgpDYW4geW91IGRvdWJsZSBjaGVjayBpZiB3
ZSBzdGlsbCBuZWVkIHRoZSB0dG1fYm9fdHlwZV8qIHBhcmFtZXRlciB0byAKYW1kZ3B1X2dlbV9v
YmplY3RfY3JlYXRlKCkgYWZ0ZXIgYWxpZ25pbmcgdGhpcz8KClRoYW5rcywKQ2hyaXN0aWFuLgoK
PiAgIAlpZiAocmV0KSB7Cj4gICAJCXByX2VycigiZmFpbGVkIHRvIGFsbG9jYXRlIGZyYW1lYnVm
ZmVyICglZClcbiIsIGFsaWduZWRfc2l6ZSk7Cj4gICAJCXJldHVybiAtRU5PTUVNOwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
