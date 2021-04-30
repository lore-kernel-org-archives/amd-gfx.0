Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A750C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2790361418
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2790361418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94A036F4D9;
	Fri, 30 Apr 2021 13:33:38 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105426F4D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 13:33:38 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id u3so26584572eja.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=a9khQ3vXOb/9VxCp+WOlHlN/Wsjgo+v6vC4W8W942Ys=;
 b=q6F3AvkH/c828mjmORSzbSEhkEhWcUJ2+neT41u+Wt8gvsQeZ4yWro9wvLKHcA3zja
 3Y4l0IhDpoPEvLzH4sfCz38vrSglzpEpuL24ZHGmfXFdWMzOd0y2cAplC242murPf0j5
 fND4a3MD2Fvl1wAmCPFlQ4O0lJUnb/lph3v2TS8D/WkcTQ/ujSHC57SjaSdknVadesIN
 wiSCMYF/xvOoyddFhfsYvB/mIhMWFiYAfBafOmcTnXvfBFawl/pR10Y1Q3QDjENm5co4
 ckhjyg5kl88elEBpdlqDRyig4YpEae1X1t4deFcIYX+LRgNjHk1COKScuW1gV8i3+hKM
 rpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=a9khQ3vXOb/9VxCp+WOlHlN/Wsjgo+v6vC4W8W942Ys=;
 b=jjYabmyrXuefM1IH24ptzJC4eGw29A+K2H22qHqszD4vURkql1vbt1P8jQg3+/wHRc
 rus/Bw4aLnlcFEETGSsqCRTWRlZLnAtKYB3vvvJwpWyN8OjfsfVQad4+Im95vuDIuffu
 EcEgRwNZq03rXYFunku5QNeDYKmVoE5n1TKgoGPZl/qLXnhjYPH03ibAu2+qiMFupmvq
 weGSJ4D3khrdlI0WtyJwtMA/zrzliW5qIN42fs1FFdnv8Scvq/Z2NTJF6NUyw8yvkJTo
 SrMX2LLxMwEiU1CllTz1CkGd+t8VghK9JwnltuzjqiAzH2/bslkKyeNiL0PUqXBuKYWx
 8Y2Q==
X-Gm-Message-State: AOAM533oyv9Sr68GpJ7qOR5x3whbunu3j2WBVBY9H+CFq2KwiObRWGfW
 BrJGmmsqjswxDbeBPq+kYGc=
X-Google-Smtp-Source: ABdhPJwsXIIZWYIH5zFpA/PZ1VNkThIg5JF5FxPfF6NCqXExMyMr9lT9E5cHI7Ywpjg7FCwErcrv2w==
X-Received: by 2002:a17:906:3458:: with SMTP id
 d24mr4568076ejb.54.1619789616743; 
 Fri, 30 Apr 2021 06:33:36 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:aa4a:1229:bd1a:d432?
 ([2a02:908:1252:fb60:aa4a:1229:bd1a:d432])
 by smtp.gmail.com with ESMTPSA id d15sm1285137edu.86.2021.04.30.06.33.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Apr 2021 06:33:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: remove excess function parameter
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210430133227.23338-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b58b317e-f6a7-9ea2-5f99-9c05aedf37cb@gmail.com>
Date: Fri, 30 Apr 2021 15:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210430133227.23338-1-nirmoy.das@amd.com>
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
Cc: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMzAuMDQuMjEgdW0gMTU6MzIgc2NocmllYiBOaXJtb3kgRGFzOgo+IEZpeCBiZWxvdyBodG1s
ZG9jcyBidWlsZCB3YXJuaW5nOgo+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmM6MjgwODoKPiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICd2bV9jb250
ZXh0JyBkZXNjcmlwdGlvbiBpbiAnYW1kZ3B1X3ZtX2luaXQnCj4KPiBTaWduZWQtb2ZmLWJ5OiBO
aXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvD
tm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMSAtCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxl
dGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCBk
YWU1MTk5MmM2MDcuLmYyNTEzYmU3Mjk4MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jCj4gQEAgLTI3OTYsNyArMjc5Niw2IEBAIGxvbmcgYW1kZ3B1X3ZtX3dhaXRf
aWRsZShzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwgbG9uZyB0aW1lb3V0KQo+ICAgICoKPiAgICAqIEBh
ZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKPiAgICAqIEB2bTogcmVxdWVzdGVkIHZtCj4gLSAq
IEB2bV9jb250ZXh0OiBJbmRpY2F0ZXMgaWYgaXQgR0ZYIG9yIENvbXB1dGUgY29udGV4dAo+ICAg
ICogQHBhc2lkOiBQcm9jZXNzIGFkZHJlc3Mgc3BhY2UgaWRlbnRpZmllcgo+ICAgICoKPiAgICAq
IEluaXQgQHZtIGZpZWxkcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
