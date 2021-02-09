Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192F2C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 16:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21EB64E9D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 16:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21EB64E9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1EF6E0DE;
	Tue,  9 Feb 2021 16:54:23 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 035B46E082;
 Tue,  9 Feb 2021 16:53:15 +0000 (UTC)
Date: Tue, 9 Feb 2021 17:53:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1612889594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLhz1mOsEx0W6YGz0MQO18zVKKP5dP/ZMkeQk0P5Pc0=;
 b=VssEa+oStlp146jqyc3ZrvBXNI7g3TJUDh/VJDsRLj+Gs1WOjbooyaID/DuIdnShJa4nMx
 20Pz+7QeK8ymrTuRIYB53RtqJNzcg6eWB19U5mQL2SYojF6wyIFESpDkeZDtpFmA2Ugb8/
 IU0n+g9NfkjB2WvIY4ELR0kentxL/WsKrsftqon75PlKTjGlSgty/wKY329j2KyKqHVf2f
 9MZkzwzwr5zotT5qmmwLOQz6XtA1+VkDpGzNw6gAlzRP9FpzN5gATGa/XpZOM4roHbgKB1
 1JIY9QRWzg89MsYSteDzrV++anRrzgnK+8421auxSBdosTZ9eMQCs/DoFmg98g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1612889594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLhz1mOsEx0W6YGz0MQO18zVKKP5dP/ZMkeQk0P5Pc0=;
 b=zhSMo+t85v3qW2upAa6ffMtMdEgZ0ZQVFJfYU/Hi3m+W/S4q1CS9IMHzRqx7T/WGTRWrEU
 MUUoy7LxaJHz7cBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 0/3] drm/amdgpu: Remove in_interrupt() usage.
Message-ID: <20210209165312.bq2yn73fqidt7hgl@linutronix.de>
References: <20210209124439.408140-1-bigeasy@linutronix.de>
 <41d0f7db-c2b4-f618-42a7-da9f7cdb76b4@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41d0f7db-c2b4-f618-42a7-da9f7cdb76b4@amd.com>
X-Mailman-Approved-At: Tue, 09 Feb 2021 16:54:22 +0000
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMi0wOSAxMzo1MDozMSBbKzAxMDBdLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+
IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
IGZvciB0aGUgc2VyaWVzLgoKVGhhbmsgeW91LgpBbnkgY2hhbmNlIHlvdSBjb3VsZCBnaXZlIG1l
IGEgaGFuZCB3aXRoIHRoZSByZW1haW5pbmcgdGhyZWUgdXNlcnMKd2l0aGluIHRoZSBhbWRncHUg
ZHJpdmVyPyBJIGRvbid0IGtub3cgaWYgdGhlIGluX2ludGVycnVwdCgpIGNoZWNrIGNhbgpiZSBs
aW1pdGVkIHRvIGNlcnRhaW4gY2FsbGVycy4KV2hhdCBJIG5vdGljZWQgd2hpbGUgdHJhY2luZyB2
NS4xMCBpcyB0aGlzOgoKfCAgICAgICAgICAgICBYb3JnLTIyNTcgICAgWzAwN10gZC4uLiA1NzI2
MS42MjAwNDM6IGFtZGdwdV9kZXZpY2Vfd3JlZzogMHg2OTlmLCAweDAwMDAxYmNmLCAweDAwMDAw
MTAwCnwgID0+IHRyYWNlX2V2ZW50X3Jhd19ldmVudF9hbWRncHVfZGV2aWNlX3dyZWcKfCAgPT4g
YW1kZ3B1X2RldmljZV93cmVnLnBhcnQuMAp8ICA9PiBkY2UxMTBfYXJtX3ZlcnRfaW50cgp8ICA9
PiBkY2UxMTBfdmJsYW5rX3NldAp8ICA9PiBkbV9lbmFibGVfdmJsYW5rCnwgID0+IGRybV92Ymxh
bmtfZW5hYmxlCnwgID0+IGRybV92YmxhbmtfZ2V0CnwgID0+IGRybV93YWl0X3ZibGFua19pb2N0
bAp8ICA9PiBkcm1faW9jdGxfa2VybmVsCnwgID0+IGRybV9pb2N0bAp8ICA9PiBhbWRncHVfZHJt
X2lvY3RsCnwgID0+IF9feDY0X3N5c19pb2N0bAp8ICA9PiBkb19zeXNjYWxsXzY0CnwgID0+IGVu
dHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZQoKSSB0aGluayB0aGF0IGFtZGdwdV9kZXZpY2Vf
d3JlZygpIC0+IGFtZGdwdV9raXFfd3JlZygpIGNvdWxkIGJlIGludm9rZWQuCkl0IGRvZXNuJ3Qg
aGVyZSBiZWNhdXNlIGFtZGdwdV9zcmlvdl9ydW50aW1lKCkgaXMgZmFsc2UuClRoZSB0cmFjZSBz
YXlzIGBkJyB3aGljaCBtZWFucyBpbnRlcnJ1cHRzIGFyZSBkaXNhYmxlZCBidXQKaW5faW50ZXJy
dXB0KCkgd2lsbCByZXR1cm4gZmFsc2UgaW4gdGhpcyBjYXNlIChubyBJUlEvc29mdGlycSkuCgpT
ZWJhc3RpYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
