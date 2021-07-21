Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227FC12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 06:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DCD61029
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 06:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DCD61029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A87B6E906;
	Wed, 21 Jul 2021 06:37:04 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0DF6E906
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 06:37:03 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id r11so888154wro.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 23:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gEvg4umBJKTfgE08daXXgA6I5DK3F1cS/9WZPep4WfA=;
 b=U7F0rXzvB7F4F1Bw1IH2/6xr23QTsNXWU9DZAy7eYgtpvyMPwHjQJVHEVehGYCz9P4
 +/WPvQ/RJJqU5Kv3J8GOTZ5seY5KdIgc4np6mpS8tTizgqS2XOxJ5FCJER1Srad6WuBT
 Ks5iBbIOJroruukflGKbOQVp7RtmfLQk/BmHwdi8wBC+MxYHyZF/1uwHFbAjQddzGn6v
 sZNhiUovvGwnRBvAJ21pKHJRF+QWXD1YbzxPhYxQYM/Z50CXCD+PgNQ0At1sGxGJGTpF
 zXIpOG008eQAlpNF4fsZI75Ow5sK3GPUZCZpJpKunkiB9Z1jLXtxUkBlbRpNPLXyMvkX
 i/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gEvg4umBJKTfgE08daXXgA6I5DK3F1cS/9WZPep4WfA=;
 b=OV4+TH/OePgXsMpeZDc29zV9D8V8ZqoIGfsUshoCqgb4pNStS3rArSJEmj+eJEac2H
 QBUohAw8LWxVeAsYw3Pd0c3tZbwWT0FW3U6N8eyWQI1uG+8WOeTebqMmL+8O82mWd0V2
 8egltb64z6YygreTFcJ7sBAh/w4EzjoRDMXvcrH86QB2vTiUyG2yPWchwrG7UhED/wI3
 eOVKOcKkGm+pHrZnf+pDF22qKep3OPUHYIQtxy1msnzrBpwgomgjMZvG82SQJVz2+k2c
 Q6kKMBfG+N8wXMtHtdRnAXoXaw0a7d7kQPkCxsSirzRLa65OnHuDCyv2NVkFnOgFodO3
 Bfxg==
X-Gm-Message-State: AOAM532s+NNUtVlk/ZBTfS0CaB/EqG/YPvP604LbmSbhhcaR/ME9C5WQ
 8p+UNWtjwqFjj31nPSD3UXQ=
X-Google-Smtp-Source: ABdhPJz9EMZO9DGe/Tg5Z7G6+g89GfRNaxuYOeRQu7tSsCWG8uZry9EGjvHxwZ4CuSBt5+dkvF0OKQ==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr40675507wrt.224.1626849422117; 
 Tue, 20 Jul 2021 23:37:02 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:9bcf:837a:d18c:dc66?
 ([2a02:908:1252:fb60:9bcf:837a:d18c:dc66])
 by smtp.gmail.com with ESMTPSA id y6sm21267405wma.48.2021.07.20.23.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jul 2021 23:37:01 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/gfx10: fix mixed declaration and code warning
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210721031447.2333109-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eb72dadf-bcdc-deb5-2f9d-3b156d23d192@gmail.com>
Date: Wed, 21 Jul 2021 08:37:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721031447.2333109-1-alexander.deucher@amd.com>
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDcuMjEgdW0gMDU6MTQgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gTW92ZSB0aGUgZGVj
bGFyYXRpb24gdXAgdG8gdGhlIHRvcCBvZiB0aGUgZnVuY3Rpb24uCj4KPiBGaXhlczogNjMxZDU1
ZTA4OWVhYTggKCJkcm0vYW1kZ3B1OiBBZGQgZXJyb3IgbWVzc2FnZSB3aGVuIHByb2dyYW1pbmcg
cmVnaXN0ZXJzIGZhaWxzIikKPiBDYzogUm95IFN1biA8Um95LlN1bkBhbWQuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCkFja2Vk
LWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgfCAyICstCj4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gaW5kZXggY2EwNmZiMTM3Y2FjLi5kMTAyY2ZkMzZi
YTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwo+IEBAIC0xNDkz
LDYgKzE0OTMsNyBAQCBzdGF0aWMgdTMyIGdmeF92MTBfcmxjZ19ydyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdTMyIG9mZnNldCwgdTMyIHYsIHVpbnQzMgo+ICAgCXVpbnQzMl90IGkgPSAw
Owo+ICAgCXVpbnQzMl90IHJldHJpZXMgPSA1MDAwMDsKPiAgIAl1MzIgcmV0ID0gMDsKPiArCXUz
MiB0bXA7Cj4gICAKPiAgIAlzY3JhdGNoX3JlZzAgPSBhZGV2LT5ybW1pbyArCj4gICAJCSAgICAg
ICAoYWRldi0+cmVnX29mZnNldFtHQ19IV0lQXVswXVttbVNDUkFUQ0hfUkVHMF9CQVNFX0lEWF0g
KyBtbVNDUkFUQ0hfUkVHMCkgKiA0Owo+IEBAIC0xNTI2LDcgKzE1MjcsNiBAQCBzdGF0aWMgdTMy
IGdmeF92MTBfcmxjZ19ydyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIG9mZnNldCwg
dTMyIHYsIHVpbnQzMgo+ICAgCQl3cml0ZWwodiwgc2NyYXRjaF9yZWcwKTsKPiAgIAkJd3JpdGVs
KG9mZnNldCB8IGZsYWcsIHNjcmF0Y2hfcmVnMSk7Cj4gICAJCXdyaXRlbCgxLCBzcGFyZV9pbnQp
Owo+IC0JCXUzMiB0bXA7Cj4gICAKPiAgIAkJZm9yIChpID0gMDsgaSA8IHJldHJpZXM7IGkrKykg
ewo+ICAgCQkJdG1wID0gcmVhZGwoc2NyYXRjaF9yZWcxKTsKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
