Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C37DC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB803221F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 22:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB803221F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD29896EC;
	Tue, 12 Jan 2021 22:04:15 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D63FA896EC;
 Tue, 12 Jan 2021 22:04:13 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id x13so3830717oto.8;
 Tue, 12 Jan 2021 14:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=20iRatogXKctWuCSvC+xfnFlPUF7GqkY4/aok3Z1trg=;
 b=r21FEgHp1vFsdhCcrMKN4hSIIgqsRz8//hcQrdf1SZO7OTrAElURZARDPSO6CZdgLJ
 DICQniV60nSGoYnQW/qgnEaANWsnS1UZ8X/aXZk7T+KEhCdomYQQUsvrY/AgXtgDev1e
 xqrXFt+LbzVdZoy4mOVnI1j9hFn7Kse7Ayt3btBCYMuE1lfI9xfJ4bzwQlqj9itQ40Zk
 zdgYOKg8JTDxMkBtNwqAP6VtG+hqBKQJSMNgt79I7kmGMcLRDLCbb8IsBBcX9qmIPq7G
 FY7qZDNQWDZasdcpWCJnfAR5rlN8On6PufVN4si7zyOzRShEpKNtTfPaEBx7oob16Lbw
 KTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=20iRatogXKctWuCSvC+xfnFlPUF7GqkY4/aok3Z1trg=;
 b=sIT0jTVLIfzS6X527WbXK/H0nOBzbXBAvy/D7FL6nCSGrqPLqE9r4gdP01rJ3cunlw
 b83Y2X768585MXL0cfN31CVYmFsXwlky0X0TQ1cM6h8rWNTI0HAPeI4VZBn1giJtwaQs
 6n1ZX7dWvzuNrcW2i52tbxDRcpT8y+toIsuTuBSIF/WwcHt/NIaPNT8RI60QBpTiWuFC
 jYbftkMhYv75Q6zsEy5rTpfMvwtk1NVtlCsjUGH4A1kwu+NIngtUy7VcaH2M963wsZL9
 ypGgb1QrMtrsTYEZvFXSmZD2WcoJckkZDMj8c8lmDS4hmpKEKQSpCNZ2BUwk/nJ4I518
 Rb5Q==
X-Gm-Message-State: AOAM5313PVzHRc1E0BVHcMesPCgBMuOS4JYhtW4/RwAWt9+5Y/oB+dsc
 m/K9l/q1kd5pgy9zvy84kzYW0nVz9E6QVLMk9mU=
X-Google-Smtp-Source: ABdhPJyfFwlgdzLPNsDb2NafsNzOVsdOGOdv1zgXDC8wcRobwTbGBFQ+8OB2KxA7P4FzPyVsTyKw/qe3+C/roofQ+wk=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr989297otl.311.1610489053276; 
 Tue, 12 Jan 2021 14:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org>
 <20210111191926.3688443-10-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-10-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jan 2021 17:04:02 -0500
Message-ID: <CADnq5_PVviC6oYp_mSeY+oYgXE3Ubvuu-sd=MHACTbiVq1mtdg@mail.gmail.com>
Subject: Re: [PATCH 09/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag:
 Include our own header containing prototypes
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
Cc: Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMjoxOSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3
YXJuaW5nKHMpOgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
Z3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuYzo1MDo2OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmGRhbF9od19mYWN0b3J5X2RpYWdfZnBnYV9pbml04oCZIFst
V21pc3NpbmctcHJvdG90eXBlc10KPgo+IENjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxh
bmRAYW1kLmNvbT4KPiBDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4gQ2M6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiBDYzogIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgo+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KCkFwcGxpZWQuICBUaGFua3MhCgpBbGV4CgoKPiAtLS0KPiAgLi4uL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuYyAgICB8IDEgKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X2ZhY3Rv
cnlfZGlhZy5jCj4gaW5kZXggZGY2ODQzMGFlYjBjMi4uYzZlMjhmNmJmMWEyNyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19m
YWN0b3J5X2RpYWcuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9ncGlv
L2RpYWdub3N0aWNzL2h3X2ZhY3RvcnlfZGlhZy5jCj4gQEAgLTI4LDYgKzI4LDcgQEAKPiAgICov
Cj4KPiAgI2luY2x1ZGUgImRtX3NlcnZpY2VzLmgiCj4gKyNpbmNsdWRlICJod19mYWN0b3J5X2Rp
YWcuaCIKPiAgI2luY2x1ZGUgImluY2x1ZGUvZ3Bpb190eXBlcy5oIgo+ICAjaW5jbHVkZSAiLi4v
aHdfZmFjdG9yeS5oIgo+Cj4gLS0KPiAyLjI1LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
