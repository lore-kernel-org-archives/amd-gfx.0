Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818C9C64E7B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2BC2076E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 22:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU80lPUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2BC2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6637289C17;
	Mon, 30 Nov 2020 22:59:55 +0000 (UTC)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F7989C17;
 Mon, 30 Nov 2020 22:59:54 +0000 (UTC)
Received: by mail-oi1-x242.google.com with SMTP id j15so16090074oih.4;
 Mon, 30 Nov 2020 14:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=k+dbsDk0Oc0svCZNoINarBhbwsNQCNzrJCy0UzhKJ2U=;
 b=jU80lPUmgMBiZbtn5YYCQWnBhyeiMUPfXlAFdEJfLfs//Xmn+UlLptEHVgPlgLbIdj
 t48doM8eGwuwyKYqhA79YyEonl4YXKIFRQF6rNTUxZIkrel3TG5K75AGbpr7/PaJu3x0
 xwJS7zT9bszVpl9sv+KxcudNiGDW1RisH1CyvNOiNxe6XFXoCH2OI5qVbCJTRAHU2IeM
 EmOpxaOmQhUk3+lUGXRh5KA+EWBYOF60RbNRozDiBM23JYscCgfMhv7cxCyfF0vAsgVl
 yJaL+yjrO25vhDtJNqdi2Ok+PbALGayx5utuRer+/lNs/vATDVs5NJfIZ3ChMVMkmCTg
 g0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=k+dbsDk0Oc0svCZNoINarBhbwsNQCNzrJCy0UzhKJ2U=;
 b=G6gb37iq9mkrR+JGGdatzbHmjLLZWfPVRe/T1FC2xnWj4Rxj5NZDF6kLvVljElSz1i
 6WV+fCI3uPiIbTzkFXexV1JxDiH4a6feRuXHuxtSZptcrgvhPuTDgTI8DKT6HCeGhHhc
 ZyWSyT8dnmI2FQnKItw0Dw0UwYILhQyH65JxRGLwifMYD9AFDw2Cd6eOsjSckgcSDQpu
 xAS8ObdPOgPXyFx0ZHgO/n0Z4wK0VWBLpG3ipyZ9GIcSiGQUMrx3M8VwNfi9ou5Fmmgp
 1pjbun7wEngdrdqccp7Tm/PAcqfYzg7LwpJIWrKg9H/AzxOzrMb75RJPClTYhC9Tn858
 /scw==
X-Gm-Message-State: AOAM531G3UcG/wWKfddEYyqYeMyfN/L5MGcOxZuxRzUSHectAA5aNr/R
 3GIhUSUqneb/DZaDkta2mqobKUqs0ahnwTcYcqY=
X-Google-Smtp-Source: ABdhPJz5yXnb6dYRUf/M4cilyKszP6fQrBYdqs9uhYKVOv0GI5qHljJuuc9EaeFJRT2LbGV5izvmz+pCCKK95yFUamY=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr54520oib.120.1606777193523;
 Mon, 30 Nov 2020 14:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20201124193824.1118741-1-lee.jones@linaro.org>
 <20201124193824.1118741-37-lee.jones@linaro.org>
In-Reply-To: <20201124193824.1118741-37-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 17:59:42 -0500
Message-ID: <CADnq5_OWFTtQ_V+UxtfeqpPER1ZuZSkkbD+6zO5Fa5t1GkUsvw@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amd/pm/inc/smu_v11_0: Mark
 'smu11_thermal_policy' as __maybe_unused
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBOb3YgMjQsIDIwMjAgYXQgMjo0NSBQTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+IEl0J3MgdXNlZCBpbiBzb21lLCBidXQgbm90IGFsbCBzb3VyY2Ug
ZmlsZXMgd2hpY2ggaW5jbHVkZSAnc211X3YxMV8wLmgnLgo+Cj4gRml4ZXMgdGhlIGZvbGxvd2lu
ZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4KPiAgSW4gZmlsZSBpbmNsdWRlZCBmcm9t
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL3BtL3N3c211L3NtdTExL3NtdV92MTFfMC5j
OjM2Ogo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9pbmMvc211X3YxMV8wLmg6
NjE6NDM6IHdhcm5pbmc6IOKAmHNtdTExX3RoZXJtYWxfcG9saWN54oCZIGRlZmluZWQgYnV0IG5v
dCB1c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4gIDYxIHwgc3RhdGljIGNvbnN0IHN0
cnVjdCBzbXVfdGVtcGVyYXR1cmVfcmFuZ2Ugc211MTFfdGhlcm1hbF9wb2xpY3lbXSA9Cj4gIHwg
Xn5+fn5+fn5+fn5+fn5+fn5+fn4KPgo+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+Cj4gQ2M6IERhbmll
bCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IFNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVkLiAgVGhhbmtzIQoK
QWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211X3YxMV8wLmggfCAz
ICsrLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvc211X3YxMV8wLmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjExXzAuaAo+IGluZGV4IGVmZjM5NmM3YTI4
MWYuLjk3NDJhMDJlN2IxNmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9p
bmMvc211X3YxMV8wLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9zbXVfdjEx
XzAuaAo+IEBAIC01OCw3ICs1OCw4IEBACj4gICNkZWZpbmUgQ1RGX09GRlNFVF9IT1RTUE9UICAg
ICAgICAgICAgIDUKPiAgI2RlZmluZSBDVEZfT0ZGU0VUX01FTSAgICAgICAgICAgICAgICAgNQo+
Cj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgc211X3RlbXBlcmF0dXJlX3JhbmdlIHNtdTExX3RoZXJt
YWxfcG9saWN5W10gPQo+ICtzdGF0aWMgY29uc3QKPiArc3RydWN0IHNtdV90ZW1wZXJhdHVyZV9y
YW5nZSBfX21heWJlX3VudXNlZCBzbXUxMV90aGVybWFsX3BvbGljeVtdID0KPiAgewo+ICAgICAg
ICAgey0yNzMxNTAsICA5OTAwMCwgOTkwMDAsIC0yNzMxNTAsIDk5MDAwLCA5OTAwMCwgLTI3MzE1
MCwgOTkwMDAsIDk5MDAwfSwKPiAgICAgICAgIHsgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIw
MDAwLCAxMjAwMDAsIDEyMDAwMCwgMTIwMDAwLCAxMjAwMDAsIDEyMDAwMH0sCj4gLS0KPiAyLjI1
LjEKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
ZHJpLWRldmVsIG1haWxpbmcgbGlzdAo+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
PiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
