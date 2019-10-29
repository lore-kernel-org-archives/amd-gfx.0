Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7734ECA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DE4208E3
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 12:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DE4208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199076E2E3;
	Tue, 29 Oct 2019 12:46:29 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5CA6E2E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 12:46:27 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id n7so2435594wmc.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 05:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=6bfDJsjdkvbEUxBh90bf8fXq09ksDOKovLx1oUdUZkA=;
 b=kiv8ta7MMKZX0xMxxIWe9byysbEKz0Le/E1icXAXk2m9WV2ZNm+FCdoYoN+T3uRY+n
 9qJOPJV9zMlozt2Yl+2ZsNjihQXHbEERkc9V7dMCA5/YcW/mGoIWoY7vNk/Vahqms5yZ
 pqYy82M3IuQJ8rRwjChUd7lHpj1MmlSXyH0IH/VHKl8Ttk5FF99Hp/bwAqbzxFoX7EFs
 s8hgSpKNfDdOKeRZTpjR4CNZq9gBex58RlsBVN54y/MjZr2Mgr9Ovr+8qBAqHiepZVos
 O9C7vdhEag2RkxYazmIURGg72hGYeejhePaMIsKfCvKxuBppOZeYw8/19Bnvx99LFuFR
 CZJA==
X-Gm-Message-State: APjAAAVHuLkhitEgzMpTt0aDoz4sT8Xnwup/6cmsoHA1xxVG35uzMh4a
 uZb0Wx2YYOQtvrhfQtiSvO5XZ5Gv
X-Google-Smtp-Source: APXvYqxanhpCHf7lUqJ0tWirgNHj1CYa0+3YqgFmP5TTYXpsDBTsVXQ/JcFY4AjdOztJqKzQ9D4btQ==
X-Received: by 2002:a1c:f714:: with SMTP id v20mr4077038wmh.55.1572353186464; 
 Tue, 29 Oct 2019 05:46:26 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id r3sm23513737wre.29.2019.10.29.05.46.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Oct 2019 05:46:25 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: add missing amdgpu_ras.h header include
To: Le Ma <le.ma@amd.com>, amd-gfx@lists.freedesktop.org
References: <1572352976-22963-1-git-send-email-le.ma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2b6a199c-7e62-764a-3cea-71c44700a0ba@gmail.com>
Date: Tue, 29 Oct 2019 13:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572352976-22963-1-git-send-email-le.ma@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6bfDJsjdkvbEUxBh90bf8fXq09ksDOKovLx1oUdUZkA=;
 b=tQnehvZd5PXokc6SPTVBlKUBI7DzMpyBWrZh/fBWAXh6nYM1jQZTaonXQ0Jfb7/UBi
 VKTZ+ROLyoP9/Mcr3eCqxRjJfNviWtFhG4HwcOFzwmag6Tb5Ftk7vUlSFKYlEynvVH7y
 j1YEqP/mweZmXKHAm2PzaKBV+moHrHL+t+IfREAvbIDtYC3TCX1oygJAQwNkA+Cf6w/+
 6HFEXDsCtimhq+U238+r0Oim1UChQ74pAu7u5jlK5tbxsMohKqKDm10bzyYKEsJloV2z
 RbOr80/qB+H6Rs+c/RlshwF7sJdN6q+wsQctNwdvdASz6aRY/23rzz28DKuDDFiLpdtf
 t+cg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Cc: Tom.StDenis@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191029124624.wDWL-JfeUD2Mo09w7njPS-bpljkP0y157NZHxxp_xoY@z>

QW0gMjkuMTAuMTkgdW0gMTM6NDIgc2NocmllYiBMZSBNYToKPiBGaXggY29tcGlsYXRpb24gZXJy
b3IuCj4KPiBDaGFuZ2UtSWQ6IEk0NjFjNTU4Nzc4ZjlhNTIzNzgyNjkzMjRkYzQxYjhkNjM5ZjNj
Y2JlCj4gU2lnbmVkLW9mZi1ieTogTGUgTWEgPGxlLm1hQGFtZC5jb20+CgpBY2tlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMKPiBpbmRleCBmY2UyMDZmLi5iYmU5YWM3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYwo+IEBAIC0zNCw2ICszNCw4IEBACj4gICAjaW5jbHVkZSAicHNw
X3YxMV8wLmgiCj4gICAjaW5jbHVkZSAicHNwX3YxMl8wLmgiCj4gICAKPiArI2luY2x1ZGUgImFt
ZGdwdV9yYXMuaCIKPiArCj4gICBzdGF0aWMgdm9pZCBwc3Bfc2V0X2Z1bmNzKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KTsKPiAgIAo+ICAgc3RhdGljIGludCBwc3BfZWFybHlfaW5pdCh2b2lk
ICpoYW5kbGUpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
