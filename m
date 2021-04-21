Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F6CC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 10:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853E16144A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 10:28:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853E16144A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F70A6E97A;
	Wed, 21 Apr 2021 10:28:59 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 845766E97B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 10:28:58 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id bx20so47597102edb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 03:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=4VN/mXBzEztIfZHi0A95HKvzF8qmIUWqkE3/s7+zPBg=;
 b=lnGrdNEcwz6qBCDOLBh/f+uemhVrnB6Jh9t4IPucZTcQfyAanOCPj6yTxd1z4L8mds
 fd4Hfs+Uhs5S9vnVp8hnfsGVz9xIQrfxfrKYyZnqvSLNJLnKMtcc3a9TUMRWOi4DLaNA
 qdlv2u382JCV52MsJK6wCSF3w0mrk03zCB+buGw8No2zybWPLmH3KRNVhGL07dPOnk19
 Y8n44vjIPMu5LmpHGZMTIhtvU0UZLnzgPC004Pif/XsJMQ/FZkHqHnFmXMPAjFS3cERL
 Xdc+urhHrthgcc40larvd5hFn5oRy8ZOY2WPmABEMGj8UGvlwqmYL6IUDKbJhGy88xNF
 86IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4VN/mXBzEztIfZHi0A95HKvzF8qmIUWqkE3/s7+zPBg=;
 b=g+KPNWURar5oTYNOvleHRfQoO52PHN80WMlrhk0r5Le0Qp6VDPczynr/edrIo/aX7x
 XUqFf5LJ96LCSp75562oYpkDilqz/vKpY6NrppO7INSpXVdCnQvZBSs8CReR9pVuirDz
 82sJ9058H0ceKUg66MyHq4bZWmGEIbM24wwHxFJ6DLzhCpWCJB337T33Kii9f4bUE06f
 Zzi1y8VIaJmVoPlSL2vzHtxBn5tbBdS42+hr+8EY1HeB4sg6xzHfJyAMaIv4u7AFBYNl
 /XpIcx+fORCC/xDQcQfymQFovQt8WSj0shBxrz/a+GSld/WZJIZ7DmN3kCyzTMinnhRI
 RX7g==
X-Gm-Message-State: AOAM531LdQ6ThRabXleHoFgArepW4EbO+Xdeos8vR3UNR3SO+scfBURs
 vXQ42Wa8qovDiM4RtAqDEG0=
X-Google-Smtp-Source: ABdhPJydWoap9rxUO26B69xYcSCqgS2OCM1LvqIW7b+HuK1boTV8tZAoV0bXdUt+CsUZ6toVX6cu5A==
X-Received: by 2002:a05:6402:4a:: with SMTP id
 f10mr37600938edu.85.1619000937300; 
 Wed, 21 Apr 2021 03:28:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:30c1:a1b7:433d:2c5d?
 ([2a02:908:1252:fb60:30c1:a1b7:433d:2c5d])
 by smtp.gmail.com with ESMTPSA id k5sm3135747edk.46.2021.04.21.03.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Apr 2021 03:28:56 -0700 (PDT)
Subject: Re: [PATCH] amdgpu: fix GEM obj leak in
 amdgpu_display_user_framebuffer_create
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <20210421091635.77483-1-contact@emersion.fr>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <93008f80-edeb-de1c-35ca-15bbe872f8dc@gmail.com>
Date: Wed, 21 Apr 2021 12:28:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210421091635.77483-1-contact@emersion.fr>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDQuMjEgdW0gMTE6MTYgc2NocmllYiBTaW1vbiBTZXI6Cj4gVGhpcyBlcnJvciBjb2Rl
LXBhdGggaXMgbWlzc2luZyBhIGRybV9nZW1fb2JqZWN0X3B1dCBjYWxsLiBPdGhlcgo+IGVycm9y
IGNvZGUtcGF0aHMgYXJlIGZpbmUuCgpHb29kIGNhdGNoLiBGb3Igc29tZSBleHRyYSBwb2ludHMg
eW91IGNvdWxkIGNoYW5nZSB0aGUgZXJyb3IgaGFuZGxpbmcgCmludG8gdXNpbmcgZ290byBlcnJv
ciBpbnN0ZWFkIG9mIGhhbmQgd2lyaW5nIGl0LgoKRWl0aGVyIHdheSBwYXRjaCBpcyBSZXZpZXdl
ZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKVGhhbmtz
LApDaHJpc3RpYW4uCgo+Cj4gU2lnbmVkLW9mZi1ieTogU2ltb24gU2VyIDxjb250YWN0QGVtZXJz
aW9uLmZyPgo+IEZpeGVzOiAxNzY5MTUyYWM2NGIgKCJkcm0vYW1kZ3B1OiBGYWlsIGZiIGNyZWF0
aW9uIGZyb20gaW1wb3J0ZWQgZG1hLWJ1ZnMuICh2MikiKQo+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6IEhhcnJ5IFdlbnRsYW5kIDxod2VudGxhbkBh
bWQuY29tPgo+IENjOiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFt
ZC5jb20+Cj4gQ2M6IEJhcyBOaWV1d2VuaHVpemVuIDxiYXNAYmFzbmlldXdlbmh1aXplbi5ubD4K
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgfCAx
ICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gaW5kZXggNDhjYjMzZTViMzgyLi4xOTUz
MjIzZWNkYmEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rpc3BsYXkuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNw
bGF5LmMKPiBAQCAtOTQ0LDYgKzk0NCw3IEBAIGFtZGdwdV9kaXNwbGF5X3VzZXJfZnJhbWVidWZm
ZXJfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCj4gICAJZG9tYWlucyA9IGFtZGdwdV9k
aXNwbGF5X3N1cHBvcnRlZF9kb21haW5zKGRybV90b19hZGV2KGRldiksIGJvLT5mbGFncyk7Cj4g
ICAJaWYgKG9iai0+aW1wb3J0X2F0dGFjaCAmJiAhKGRvbWFpbnMgJiBBTURHUFVfR0VNX0RPTUFJ
Tl9HVFQpKSB7Cj4gICAJCWRybV9kYmdfa21zKGRldiwgIkNhbm5vdCBjcmVhdGUgZnJhbWVidWZm
ZXIgZnJvbSBpbXBvcnRlZCBkbWFfYnVmXG4iKTsKPiArCQlkcm1fZ2VtX29iamVjdF9wdXQob2Jq
KTsKPiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gICAJfQo+ICAgCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
