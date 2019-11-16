Return-Path: <SRS0=bOP+=ZI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BFBC432C3
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 09:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D570220723
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 09:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D570220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FB36E073;
	Sat, 16 Nov 2019 09:28:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 669E76E06B
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 09:28:39 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f3so12979658wmc.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 01:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=kWlrxvl/H9q4u8GHnFWtJe8HGZ/ejHnHO5pa8sg0oRA=;
 b=ArBVyRRmqCXT6PodF7cyHeDkU1njdkl+nakhHlJXxKVWCoQe7FDuz8wetV3wG/s7IQ
 cnGVAkdB3HeJP/jVXlA+Tf5J/N61TJfZPzh56V8ydJY6kqFU/Eg8aug9sw01RDAXiHEm
 /ts3Wd89YmDyxE7IQGi12y3rdkgRQhwcGLTyi8Ct0QnmK69v9gZSVgkNhIY2P5wGSmQz
 mVgrcpbNMWLcoK1Zx/9TbqRzlJwIdj50gzNQAWwNdQtv2QKg3x++4IG9F66u18tt1PY1
 zxhZmXeG9jZzB3WyaAgPNmOs5BemR4uurnrMfxg2rylYqpqItXWVJ0eqXXO0VUW7xBJL
 +XSg==
X-Gm-Message-State: APjAAAXRmBWLQmDoMWVzXAxhe7zhSfnukAyWM28HFhxaxVN5F+xIWcnp
 fgOYKGxpVAJHLW4VPnfaJbb0ooS5
X-Google-Smtp-Source: APXvYqyPkaTLATJwkcJwpdNX3cx305aoabSGssEtWCiNiWzUODF37DwpbctE3V/oKWbdWU7vl5EHQA==
X-Received: by 2002:a1c:106:: with SMTP id 6mr18508491wmb.33.1573896518130;
 Sat, 16 Nov 2019 01:28:38 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t134sm13681098wmt.24.2019.11.16.01.28.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Nov 2019 01:28:37 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/amdgpu: disable gfxoff on original raven
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191115152850.618879-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <efa13d7c-5748-50c0-226a-5e5b5984c686@gmail.com>
Date: Sat, 16 Nov 2019 10:28:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115152850.618879-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kWlrxvl/H9q4u8GHnFWtJe8HGZ/ejHnHO5pa8sg0oRA=;
 b=vcXqZzHc7O9LaL23lDlu/ATv0qaFPT0mB0IQuF1/BECHEmiChLblZKe4VruQs+2qXf
 hloQ0+MyLtxroNvsrbYRJnFzydTgYmqG2Vc9AxBWIs2JzoYjIWRZQk19Rrj8qfd0ifyU
 hqjsIwNv43rEsELzQvwTby3in+1wnC2TLhYMbpoVkLKOCpiF3uEze9L0LVsYGjYnD7QF
 wpW7RBTyEfTyAVrmXx/ebsz15ZOun6wSeIdtXtG2OoljkfFplaYnDY6iEBw3FoLgV0Cr
 XVTD/PGoqGMVsgMd5PoPckZ1LueGreSpEjgi+/1NJa54CK/YZOgrD3/veWi4E9wHFLif
 l+fA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191116092835.sW1lv7jyBL-IImd-fEK3CAv4VTn1spRPJ_XFDXU7XYo@z>

QW0gMTUuMTEuMTkgdW0gMTY6Mjggc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhlcmUgYXJlIHN0
aWxsIGNvbWJpbmF0aW9ucyBvZiBzYmlvcyBhbmQgZmlybXdhcmUgdGhhdAo+IGFyZSBub3Qgc3Rh
YmxlLgo+Cj4gQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lk
PTIwNDY4OQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+IGZvciB0aGUgc2VyaWVzLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dmeF92OV8wLmMgfCA5ICsrKysrKystLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5
XzAuYwo+IGluZGV4IGM3YWU2ODVkNmY3NC4uYTcwMzRhZjFjNDFlIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCj4gQEAgLTEwNTEsOCArMTA1MSwxMyBAQCBzdGF0aWMg
dm9pZCBnZnhfdjlfMF9jaGVja19pZl9uZWVkX2dmeG9mZihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKPiAgIAljYXNlIENISVBfVkVHQTIwOgo+ICAgCQlicmVhazsKPiAgIAljYXNlIENISVBf
UkFWRU46Cj4gLQkJaWYgKCEoYWRldi0+cmV2X2lkID49IDB4OCB8fCBhZGV2LT5wZGV2LT5kZXZp
Y2UgPT0gMHgxNWQ4KQo+IC0JCQkmJigoYWRldi0+Z2Z4LnJsY19md192ZXJzaW9uICE9IDEwNiAm
Jgo+ICsJCS8qIERpc2FibGUgR0ZYT0ZGIG9uIG9yaWdpbmFsIHJhdmVuLiAgVGhlcmUgYXJlIGNv
bWJpbmF0aW9ucwo+ICsJCSAqIG9mIHNiaW9zIGFuZCBwbGF0Zm9ybXMgdGhhdCBhcmUgbm90IHN0
YWJsZS4KPiArCQkgKi8KPiArCQlpZiAoIShhZGV2LT5yZXZfaWQgPj0gMHg4IHx8IGFkZXYtPnBk
ZXYtPmRldmljZSA9PSAweDE1ZDgpKQo+ICsJCQlhZGV2LT5wbS5wcF9mZWF0dXJlICY9IH5QUF9H
RlhPRkZfTUFTSzsKPiArCQllbHNlIGlmICghKGFkZXYtPnJldl9pZCA+PSAweDggfHwgYWRldi0+
cGRldi0+ZGV2aWNlID09IDB4MTVkOCkKPiArCQkJICYmKChhZGV2LT5nZngucmxjX2Z3X3ZlcnNp
b24gIT0gMTA2ICYmCj4gICAJCQkgICAgIGFkZXYtPmdmeC5ybGNfZndfdmVyc2lvbiA8IDUzMSkg
fHwKPiAgIAkJCSAgICAoYWRldi0+Z2Z4LnJsY19md192ZXJzaW9uID09IDUzODE1KSB8fAo+ICAg
CQkJICAgIChhZGV2LT5nZngucmxjX2ZlYXR1cmVfdmVyc2lvbiA8IDEpIHx8CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
