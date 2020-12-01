Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C4C8300F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 00:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4C1206E9
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 00:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OccpJsDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4C1206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0705F89D5F;
	Tue,  1 Dec 2020 00:01:01 +0000 (UTC)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C471689D5F;
 Tue,  1 Dec 2020 00:00:59 +0000 (UTC)
Received: by mail-oi1-x244.google.com with SMTP id y74so16225811oia.11;
 Mon, 30 Nov 2020 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vwAi3j5hKUR5I3v6aaEnj4yZwa+jhIFvRIVmx73mGr4=;
 b=OccpJsDXy6hPItda+235fnSn3RIRuNx9jcOkicT3aqwbLaSal8DSKc8M2vcptYVgCF
 LTFJv5PqxAH9vQDm094SUFW1SAXEYcKoW2Z3tm3KjcoBon8LFhGAUQEj/iH94aR87SkU
 irGBc0VvtBPN3DGph717/v2k3wX5I3qWlT7YOsFG5x0kv8xRYVmXuU7qn2P7chMDDr+w
 ER1dwbim9HiWDTd+F6KiLbsoKmdoRfg5e+i6Kuzekxm5q3SGigkz0Gkvm3r/YCMdFgI/
 gbwAyHrRcaYoPjDLW/8W9MydFstmDKcBez1zQXXbyYfv5Uo1x/bVxqP+V+rThVwYcjFY
 d+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vwAi3j5hKUR5I3v6aaEnj4yZwa+jhIFvRIVmx73mGr4=;
 b=LW2mpm+0gWqXEU3AEj/LSY/pm6ecpIKrs4TP4iYw8q2luG5Fjq7F3XuelzEt71Rmco
 XGS8UkwU8RBOwP4rbqlP4MdXuhNrSZvi58jQ5UyxWCm2AHK+wJlGVc+6QmkFCMov1p62
 iCdEJ1uDRUApezvhT9MVwk7Vd4n22bsgy5CG5YjfMZp/aiaWWhhch+hrx1orBpd+CjMu
 DnG1uEcpOv0Gdb+TXApsqNdsTq+qsOzGRkJAg1U4YiRoZ0efeGhHckHdDN/fqOIZZ5jN
 UeJyCXJtQN3sUAVxwIyxAbDfNTfUyaUIxLxKXR1t9XsVoKDnbHX/tv02mXh30uXwGFx0
 ahPQ==
X-Gm-Message-State: AOAM530ehj6WMb9P6p8aJ8/3W2G1JdF3RTS8rYh9zAnK666fNIvgiVOT
 z2zgCz0gCiZ2k+Z6Ji5JaZzRU7iD5GY10+Z3OxQhfmNn
X-Google-Smtp-Source: ABdhPJx5EW3BogA2TAlZ64hzqIRBxOKmP654oJ/bpQBGF7Yyxc8Qa/aoJ30NVr2vA++NbUaH/yizaWY2sbRPKMRxuHs=
X-Received: by 2002:a54:4608:: with SMTP id p8mr28704oip.5.1606780859215; Mon,
 30 Nov 2020 16:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org>
 <20201126134240.3214176-34-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-34-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Nov 2020 19:00:47 -0500
Message-ID: <CADnq5_OoA_mGiDmW=P4CW-KYNsR9W2Fu8uFwXzm_mQGBTJqkKQ@mail.gmail.com>
Subject: Re: [PATCH 33/40] drm/amd/display/dc/inc/hw/dpp: Mark
 'dpp_input_csc_matrix' as __maybe_unused
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

T24gVGh1LCBOb3YgMjYsIDIwMjAgYXQgODo0MyBBTSBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPiB3cm90ZToKPgo+ICdkcHBfaW5wdXRfY3NjX21hdHJpeCcgaXMgdXNlZCBieSBzb21l
LCBidXQgbm90IGFsbCBzb3VyY2UgZmlsZXMgd2hpY2gKPiBpbmNsdWRlIGRwcC5oLgo+Cj4gRml4
ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6Cj4KPiAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9pbmMvaHcvZHBwLmg6NTA6NDI6IHdh
cm5pbmc6IOKAmGRwcF9pbnB1dF9jc2NfbWF0cml44oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1jb25zdC12YXJpYWJsZT1dCj4KPiBOQjogU25pcHBlZCBsb3RzIG9mIHRoZXNlIGZv
ciBicmV2aXR5Cj4KPiBDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+
Cj4gQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IENjOiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IFNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CgpBcHBsaWVk
LiAgVGhhbmtzIQoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2luYy9ody9kcHAuaCB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2luYy9ody9kcHAuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcv
ZHBwLmgKPiBpbmRleCA2NzUxMTg2ZjZmOTA0Li5kZGJlNGJiNTI3MjRhIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9pbmMvaHcvZHBwLmgKPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2h3L2RwcC5oCj4gQEAgLTQ3LDcgKzQ3LDcg
QEAgc3RydWN0IGRwcF9pbnB1dF9jc2NfbWF0cml4IHsKPiAgICAgICAgIHVpbnQxNl90IHJlZ3Zh
bFsxMl07Cj4gIH07Cj4KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBkcHBfaW5wdXRfY3NjX21hdHJp
eCBkcHBfaW5wdXRfY3NjX21hdHJpeFtdID0gewo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRwcF9p
bnB1dF9jc2NfbWF0cml4IF9fbWF5YmVfdW51c2VkIGRwcF9pbnB1dF9jc2NfbWF0cml4W10gPSB7
Cj4gICAgICAgICB7Q09MT1JfU1BBQ0VfU1JHQiwKPiAgICAgICAgICAgICAgICAgezB4MjAwMCwg
MCwgMCwgMCwgMCwgMHgyMDAwLCAwLCAwLCAwLCAwLCAweDIwMDAsIDB9IH0sCj4gICAgICAgICB7
Q09MT1JfU1BBQ0VfU1JHQl9MSU1JVEVELAo+IC0tCj4gMi4yNS4xCj4KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKPiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
