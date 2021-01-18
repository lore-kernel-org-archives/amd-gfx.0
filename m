Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84A0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 15:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71CE122228
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 15:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CE122228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9AE6E492;
	Mon, 18 Jan 2021 15:04:35 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4DEF6E438
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 15:04:33 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id rv9so5325322ejb.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 07:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=57dceN0nNSHMFSpUTR9mZ/PJCtkCjHJnRN39GU+AIog=;
 b=Vzn27hA5RRDdGc5DamlNfSkmoAzK9oNeFN5EvTyHMPmrKPuyDI5iVPVoFIBidN21TF
 9Xk5/4NPAey/owjiya5b2cxaOutVxtB4n0HXeEwwrvVrqRIgZwvaXQ3x+WXjyghnItMQ
 V/c2pUWEbPuzR0WKAhgA529/2nxZUH5Su/NVcwGoXuLcJNTmpkAoJQekxky30amqb5G4
 WUt9GkDdALL/ajOwS3SaDjYLFDWxmbBr42qo+zW0ZzRTh2GfX3E2P66Iyu5aj3FDKSIS
 352QO+AseC9HBHqxDOcXQorzV1WRtaDq+2yTRT0fediWI1HRfHiNGWIxrkJIx4hZd+RZ
 X0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=57dceN0nNSHMFSpUTR9mZ/PJCtkCjHJnRN39GU+AIog=;
 b=V+/txiB/REWrIwFyl7Q4BTvPyYoOGtVqcEHEUtmHlxIN5UhIHBuPeALTQbDDwGOOrg
 D8hbMYn/MAAsIdovNPtIQfODq9sh8ug8xthI1KDHsb7dgv18s6xvB7cuu32gQaV0aa66
 6MKwIVbNRuuzDPxUcjVikVq4fz1O6lCNp8X7Yr7FML79wnLFwKBtB0us2HgrgIulWqbt
 vvWhTHk1DAuxNnv6sSv4EvIZS6Q8ZKJVLaSXQOEkfgfU0cATC8laa/iuB110Gn9hS2w3
 AED1LpsePvSNWOuWXljcuvCxA9aXMyoKq/GnRznXfTCsGF7oMd4YsLX14Dwe6+YyM6Rf
 iZrw==
X-Gm-Message-State: AOAM533I0mdz+oRBUHxn7PhFC9a72GXCIDYyW8/7uBN61spF+FinOBnC
 ip8PI/XPgqMC68vujb3PpNgJhgf+6o0=
X-Google-Smtp-Source: ABdhPJxASva1ilGZ2lrVCwrvcPO5K/TwbkL+boPDnFqn3hysMvBuqgMOxFzXCVbhFfB4aMAte0iqbg==
X-Received: by 2002:a17:906:fcae:: with SMTP id
 qw14mr70055ejb.245.1610982271869; 
 Mon, 18 Jan 2021 07:04:31 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id cb4sm9525036ejb.82.2021.01.18.07.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jan 2021 07:04:31 -0800 (PST)
Subject: Re: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210115182423.32368-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <cea118cc-b9d0-0052-bc4f-d40a2bdd07ce@gmail.com>
Date: Mon, 18 Jan 2021 16:04:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115182423.32368-1-Felix.Kuehling@amd.com>
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

QW0gMTUuMDEuMjEgdW0gMTk6MjQgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBST0NtIHVzZXIg
bW9kZSBkZXBlbmRzIG9uIHVzZXJwdHIgc3VwcG9ydC4gV2l0aG91dCBpdCwgS0ZEIGlzIGJhc2lj
YWxseQo+IHVzZWxlc3MuCj4KPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
S2NvbmZpZyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPiBpbmRleCBlOGZiMTBjNDFmMTYuLjI4MDBiMmJiMjUy
MiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZwo+IEBAIC04LDUgKzgsNiBAQCBj
b25maWcgSFNBX0FNRAo+ICAgCWRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiAoWDg2XzY0IHx8IEFS
TTY0IHx8IFBQQzY0KQo+ICAgCWltcGx5IEFNRF9JT01NVV9WMiBpZiBYODZfNjQKPiAgIAlzZWxl
Y3QgTU1VX05PVElGSUVSCj4gKwlzZWxlY3QgRFJNX0FNREdQVV9VU0VSUFRSCj4gICAJaGVscAo+
ICAgCSAgRW5hYmxlIHRoaXMgaWYgeW91IHdhbnQgdG8gdXNlIEhTQSBmZWF0dXJlcyBvbiBBTUQg
R1BVIGRldmljZXMuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
