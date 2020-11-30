Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FD3C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45CC520709
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8emkxQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CC520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8506E8F7;
	Mon, 30 Nov 2020 22:13:00 +0000 (UTC)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 744AF897D4;
 Mon, 30 Nov 2020 22:12:59 +0000 (UTC)
Received: by mail-ot1-x343.google.com with SMTP id z23so9248923oti.13;
 Mon, 30 Nov 2020 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ko/Y/d940PG7gzeTfAkhVNOkEcH+zDyjEv09WIfO+ts=;
 b=c8emkxQ4UGyIzOdTalRXEKd9zWQiFAIoHc/XMWNhZMW/pJmLgbb2c50mQ+fBBqCYrE
 xKAz6avQRxYUfXqsOPwneeJV7ng+h8rvNzW/UJXzNjsST+NLmzc1TPzDEmOgccK90o6R
 H1drjJbrYNlTpUu5xPR+hv5jA0aD1mOATn9z62pvu1UGVo36s9LR0zLAb5wELbMj74OY
 jCdoxGwCoqvUN7hl3ahokowwR1z9NsKWUSXv+JhtUXahehUlibFPoDFF7ZV0mHy0I5o0
 0MHZ2wlZ88SMoVi5KdfPrpomX3VSyYXVFlqq8IVTNQ/oCGDYhMfbw9bgwWyEfWq4F82K
 +tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ko/Y/d940PG7gzeTfAkhVNOkEcH+zDyjEv09WIfO+ts=;
 b=QC3D9AjaJ/tElqJY5M7EO0UYCe4d8EBl2r2C/iHhwE8NyyccV+22CLNfsZBPspqRx7
 MyPeL/+qmwE/QwEOHfT9zlAv6wFvBU7HXhsufEzlM7+g2K807DQGhgJfJrubBRvnHopO
 XUoFhZB9yq575miP7FJBVpeebaNejoYqV0axtGW5XoPj24ZDU+JgRUFbV87rwvMav8Q+
 GWRmDWM201E6Hdi9cQABSR74rC9XY+zoTze0O28RAgPNE7nUqvub5DQPFN2oKyyFKf+z
 jXbO3dF+3qZFvRUFWjiVKzmlKKNF9RdkJtmsTZaZLSYARik3uC2QszJalaUUNPJXWIbg
 BXYw==
X-Gm-Message-State: AOAM533EyJzdIH3o75j0CnQBJnUUs7tO0GJiJFzzf+X072Y/Eh6+7hiD
 LS41ocPVVJ5TUNQ15npaD5fzVW4MGwi/UDx1Suo=
X-Google-Smtp-Source: ABdhPJzwfwaCH6CxO0QiLpZdVxucsgVTZu/e6PxyEz7vwJkJCVTbuKu5kldkBXaL6jGb5EaGJEK8TK17U27ERsMPAVg=
X-Received: by 2002:a9d:4713:: with SMTP id a19mr19151847otf.132.1606774378866; 
 Mon, 30 Nov 2020 14:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-14-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-14-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 17:12:47 -0500
Message-ID: <CADnq5_Pewh8FRTiEeHMbj8+zVFgfZP2KA9hPq1Unu1t4SjDkkQ@mail.gmail.com>
Subject: Re: [PATCH 13/40] drm/amd/amdgpu/dce_v11_0: Supply description for
 function param 'async'
To: Lee Jones <lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NCBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jOjI1
NTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYXN5bmMnIG5vdCBkZXNj
cmliZWQgaW4gJ2RjZV92MTFfMF9wYWdlX2ZsaXAnCj4KPiBDYzogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+IENjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgo+
IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IEx1YmVuIFR1aWtvdiA8
bHViZW4udHVpa292QGFtZC5jb20+Cj4gQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBM
ZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKQXBwbGllZC4gIFRoYW5rcyEKCkFsZXgK
Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jIHwgMSArCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZGNlX3YxMV8wLmMKPiBpbmRleCBjNjJjNTZhNjlmZGE2Li4xYjZmZjA0NzAwMTE4IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTFfMC5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3YxMV8wLmMKPiBAQCAtMjQ2LDYgKzI0Niw3
IEBAIHN0YXRpYyB2b2lkIGRjZV92MTFfMF9wYWdlZmxpcF9pbnRlcnJ1cHRfZmluaShzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKPiAgICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgo+
ICAgKiBAY3J0Y19pZDogY3J0YyB0byBjbGVhbnVwIHBhZ2VmbGlwIG9uCj4gICAqIEBjcnRjX2Jh
c2U6IG5ldyBhZGRyZXNzIG9mIHRoZSBjcnRjIChHUFUgTUMgYWRkcmVzcykKPiArICogQGFzeW5j
OiBhc3luY2hyb25vdXMgZmxpcAo+ICAgKgo+ICAgKiBUcmlnZ2VycyB0aGUgYWN0dWFsIHBhZ2Vm
bGlwIGJ5IHVwZGF0aW5nIHRoZSBwcmltYXJ5Cj4gICAqIHN1cmZhY2UgYmFzZSBhZGRyZXNzLgo+
IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
