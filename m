Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A01C43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 07:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D1520684
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 07:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUkeDmeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D1520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33F07890A8;
	Wed, 16 Sep 2020 07:40:54 +0000 (UTC)
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECF76E9CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 07:40:53 +0000 (UTC)
Received: by mail-lf1-x141.google.com with SMTP id q8so5886718lfb.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=LrUpowfMDhwJYm9pFVHS2sdAME2a8SvufABQVyq3kpY=;
 b=lUkeDmeqduj9bpYpvBiIPnwnJb3pDfxsuZWuZp1+hnIv5gd3aEwH5Im1W7bzRkFsq6
 uFJqyKkQKcA47IRYLfnE0xQtSfwW370Di9hN7a7AJo8qBwgusMJzQ0gOWUECmA3kFNVP
 slqiwGZRrlZZ+oni0WCBd/hf6M6wS47TmuAafZxw/4sVs8VTqmKsjV9izLoqGc6S5J/U
 YHqU7l+miMFMqC7XE35r7AonfSMi1300NtlmLXrE6hC8ryFxFxO6lm8j492WzkQt6E4M
 1g7nBv/Y4lUICZvvaULskgRIqDAgHTzvBVS2XiKloz8b1wwyl5zsGko3sNLEQ1CEph+7
 mMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=LrUpowfMDhwJYm9pFVHS2sdAME2a8SvufABQVyq3kpY=;
 b=gBCsg34bRPqDpa/tHE8TCOPTyjJfjCv3ro1OzEpCivFhylxtApdy3zC0S/oZ+7Ehlw
 xVWXXi73y6hxU74D+J6GhWgFm65I7I94+pU0GZReyhRMj1mbvlZ6PIXay27AxxKbAmHi
 +yb9vFIN21CgktA/AUAtLFV2XUKyMtExB0XPZwy7+Kuhp4ZklRX3aYIUjjXCa5oLlCfA
 fusGySfTZufJsq5N7MVpg0U9AmWFBKloFtjrK1GbtWspLQ0MmjD9giItkpy+s/v5b/cv
 Ddd9yEUc0UuXjDtGSXd6Iqp6I5UUXmYR/O+qojCBUdqSsuBirlhzg7KWQ7JQV12WeOKu
 0bWw==
X-Gm-Message-State: AOAM531gIENEJA1JJGJy6VpOupOs29QvQDoGwvsOqOOTz+xYjcw9Iajf
 rWnMxlVlym3EERW7lUD8a1in8fPJVLc=
X-Google-Smtp-Source: ABdhPJzlalBP1klj5729ndvRPyXUIZKJJjfmDqY7+KX18hkE78wKbw1DjXKwEyDolsFI2+RnXFN2LQ==
X-Received: by 2002:a05:6512:1115:: with SMTP id
 l21mr7624027lfg.334.1600242051901; 
 Wed, 16 Sep 2020 00:40:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u1sm4735040lfu.24.2020.09.16.00.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 00:40:51 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: prevent double kfree ttm->sg
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200915215212.2669-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <75ab3abd-470f-ca65-c354-5b772f719304@gmail.com>
Date: Wed, 16 Sep 2020 09:40:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915215212.2669-1-Philip.Yang@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTUuMDkuMjAgdW0gMjM6NTIgc2NocmllYiBQaGlsaXAgWWFuZzoKPiBTZXQgdHRtLT5zZyB0
byBOVUxMIGFmdGVyIGtmcmVlLCB0byBhdm9pZCBtZW1vcnkgY29ycnVwdGlvbiBiYWNrdHJhY2U6
Cj4KPiBbICA0MjAuOTMyODEyXSBrZXJuZWwgQlVHIGF0Cj4gL2J1aWxkL2xpbnV4LWRvOWVMRi9s
aW51eC00LjE1LjAvbW0vc2x1Yi5jOjI5NSEKPiBbICA0MjAuOTM0MTgyXSBpbnZhbGlkIG9wY29k
ZTogMDAwMCBbIzFdIFNNUCBOT1BUSQo+IFsgIDQyMC45MzU0NDVdIE1vZHVsZXMgbGlua2VkIGlu
OiB4dF9jb25udHJhY2sgaXB0X01BU1FVRVJBREUKPiBbICA0MjAuOTUxMzMyXSBIYXJkd2FyZSBu
YW1lOiBEZWxsIEluYy4gUG93ZXJFZGdlIFI3NTI1LzBQWVZUMSwgQklPUwo+IDEuNS40IDA3LzA5
LzIwMjAKPiBbICA0MjAuOTUyODg3XSBSSVA6IDAwMTA6X19zbGFiX2ZyZWUrMHgxODAvMHgyZDAK
PiBbICA0MjAuOTU0NDE5XSBSU1A6IDAwMTg6ZmZmZmJlNDI2MjkxZmE2MCBFRkxBR1M6IDAwMDEw
MjQ2Cj4gWyAgNDIwLjk1NTk2M10gUkFYOiBmZmZmOWUyOTI2M2U5YzMwIFJCWDogZmZmZjllMjky
NjNlOWMzMCBSQ1g6Cj4gMDAwMDAwMDE4MTAwMDA0Ygo+IFsgIDQyMC45NTc1MTJdIFJEWDogZmZm
ZjllMjkyNjNlOWMzMCBSU0k6IGZmZmZmM2QzM2U5OGZhNDAgUkRJOgo+IGZmZmY5ZTI5N2U0MDdh
ODAKPiBbICA0MjAuOTU5MDU1XSBSQlA6IGZmZmZiZTQyNjI5MWZiMDAgUjA4OiAwMDAwMDAwMDAw
MDAwMDAxIFIwOToKPiBmZmZmZmZmZmMwZDM5YWRlCj4gWyAgNDIwLjk2MDU4N10gUjEwOiBmZmZm
YmU0MjYyOTFmYjIwIFIxMTogZmZmZjllNDlmZmRkNDAwMCBSMTI6Cj4gZmZmZjllMjk3ZTQwN2E4
MAo+IFsgIDQyMC45NjIxMDVdIFIxMzogZmZmZmYzZDMzZTk4ZmE0MCBSMTQ6IGZmZmY5ZTI5MjYz
ZTljMzAgUjE1Ogo+IGZmZmY5ZTI5NTQ0NjRmZDgKPiBbICA0MjAuOTYzNjExXSBGUzogIDAwMDA3
ZmEyZWEwOTc3ODAoMDAwMCkgR1M6ZmZmZjllMjk3ZTg0MDAwMCgwMDAwKQo+IGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAKPiBbICA0MjAuOTY1MTQ0XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAg
Q1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4gWyAgNDIwLjk2NjY2M10gQ1IyOiAwMDAwN2YxNmJmZmZl
ZmI4IENSMzogMDAwMDAwMWZmMGM2MjAwMCBDUjQ6Cj4gMDAwMDAwMDAwMDM0MGVlMAo+IFsgIDQy
MC45NjgxOTNdIENhbGwgVHJhY2U6Cj4gWyAgNDIwLjk2OTcwM10gID8gX19wYWdlX2NhY2hlX3Jl
bGVhc2UrMHgzYy8weDIyMAo+IFsgIDQyMC45NzEyOTRdICA/IGFtZGdwdV90dG1fdHRfdW5wb3B1
bGF0ZSsweDVlLzB4ODAgW2FtZGdwdV0KPiBbICA0MjAuOTcyNzg5XSAga2ZyZWUrMHgxNjgvMHgx
ODAKPiBbICA0MjAuOTc0MzUzXSAgPyBhbWRncHVfdHRtX3R0X3NldF91c2VyX3BhZ2VzKzB4NjQv
MHhjMCBbYW1kZ3B1XQo+IFsgIDQyMC45NzU4NTBdICA/IGtmcmVlKzB4MTY4LzB4MTgwCj4gWyAg
NDIwLjk3NzQwM10gIGFtZGdwdV90dG1fdHRfdW5wb3B1bGF0ZSsweDVlLzB4ODAgW2FtZGdwdV0K
PiBbICA0MjAuOTc4ODg4XSAgdHRtX3R0X3VucG9wdWxhdGUucGFydC4xMCsweDUzLzB4NjAgW2Ft
ZHR0bV0KPiBbICA0MjAuOTgwMzU3XSAgdHRtX3R0X2Rlc3Ryb3kucGFydC4xMSsweDRmLzB4NjAg
W2FtZHR0bV0KPiBbICA0MjAuOTgxODE0XSAgdHRtX3R0X2Rlc3Ryb3krMHgxMy8weDIwIFthbWR0
dG1dCj4gWyAgNDIwLjk4MzI3M10gIHR0bV9ib19jbGVhbnVwX21lbXR5cGVfdXNlKzB4MzYvMHg4
MCBbYW1kdHRtXQo+IFsgIDQyMC45ODQ3MjVdICB0dG1fYm9fcmVsZWFzZSsweDFjOS8weDM2MCBb
YW1kdHRtXQo+IFsgIDQyMC45ODYxNjddICBhbWR0dG1fYm9fcHV0KzB4MjQvMHgzMCBbYW1kdHRt
XQo+IFsgIDQyMC45ODc2NjNdICBhbWRncHVfYm9fdW5yZWYrMHgxZS8weDMwIFthbWRncHVdCj4g
WyAgNDIwLjk4OTE2NV0gIGFtZGdwdV9hbWRrZmRfZ3B1dm1fYWxsb2NfbWVtb3J5X29mX2dwdSsw
eDljYS8weGIxMAo+IFthbWRncHVdCj4gWyAgNDIwLjk5MDY2Nl0gIGtmZF9pb2N0bF9hbGxvY19t
ZW1vcnlfb2ZfZ3B1KzB4ZWYvMHgyYzAgW2FtZGdwdV0KPgo+IFNpZ25lZC1vZmYtYnk6IFBoaWxp
cCBZYW5nIDxQaGlsaXAuWWFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAxICsKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4
IDhiNzA0NDUxYTE4Yy4uNGIzYWI5YTI1ZTkxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYwo+IEBAIC0xMDc2LDYgKzEwNzYsNyBAQCBzdGF0aWMgaW50IGFtZGdw
dV90dG1fdHRfcGluX3VzZXJwdHIoc3RydWN0IHR0bV90dCAqdHRtKQo+ICAgCj4gICByZWxlYXNl
X3NnOgo+ICAgCWtmcmVlKHR0bS0+c2cpOwo+ICsJdHRtLT5zZyA9IE5VTEw7Cj4gICAJcmV0dXJu
IHI7Cj4gICB9Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
