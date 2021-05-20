Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A3C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62A3C61074
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 19:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A3C61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D72106F4ED;
	Thu, 20 May 2021 19:14:39 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053776F4ED;
 Thu, 20 May 2021 19:14:38 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 n32-20020a9d1ea30000b02902a53d6ad4bdso15849805otn.3; 
 Thu, 20 May 2021 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=CFznQ5UzwVzYSrYk++bKt7INj01icNDyVEHe4lOS4xc=;
 b=oE4NN5AjJr7IrcZo1Es/vlSqvlT754NfJM7Mfc3xB6CSK7ll+/YvAtbQ2mR8AmC2BT
 sqS5dDVeSrEVWayFMSVJDASe9FKfS/Wr+qazoBbhp1Mr5/3hGxEj3m4HbdwTGxSA57TV
 tsUkAfXtKbZiSLaKd7b6iQvIx1PLbFfsvdI70eiZVuoimjccc7Oj24jOCjMZq8sDyO2X
 Gv0+5ths4rebFvxoKAo+njIxd/9sGHIKha8J/mMF2dIP6p44evYd0zbysZmm2eSWaG0V
 O5f+2Aw+n+upOXSmQcSvJZizKUNdhUyUqPutN+1XKRyxG3dHqSjSG6i6PLNAiQvAa5GA
 WMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=CFznQ5UzwVzYSrYk++bKt7INj01icNDyVEHe4lOS4xc=;
 b=sAxKnkBvCFDEy87bLjHAHSxktJua9xBWVzkshEGbMcIomDDyxfEnP6dU31sFj5C+aB
 gWLtGErvZoLVr4AudBVS+ToHPFBoN5VL8lKz0sdIUhdeLeR+BrGsRq6EgUIhWsZLH6fS
 djMHsVNh0g64BdP2RP3p9wlZZQsElwI0yfgryvMFh5IUZbpYQMphELf0nFNCUdUJuC70
 PJ+O2qwGFeVW+z4V1qmULew+gO0m3y0ZRFLnr8B6U4Yp38eHLanOfJr3vgvYeIoEeQXx
 4I5umfCNdZFgig5D+ktZzsbQ5meEGJIFMM89NpJZWWuq/+b+ioQLLYpiiYg2cWRb2Edk
 eubg==
X-Gm-Message-State: AOAM530VBLJwO6Y7KmRAwflUNmapLwtBtaGwoODFSqAIIM8u3/RLXFrE
 km+WgqyZ7jmenNi2fpGrav5QzK/CoVAG+RnZf00=
X-Google-Smtp-Source: ABdhPJx25eh9IbEMpsnOwMHXas2EpZVFTY5iQRIyfyjEiHJt8Xqx1LcdVt3ezxRqHGRJRlAfp7MTX+b2xOf6Ptl94Fg=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr5103104oti.23.1621538078199; 
 Thu, 20 May 2021 12:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120248.3464013-1-lee.jones@linaro.org>
 <20210520120248.3464013-17-lee.jones@linaro.org>
In-Reply-To: <20210520120248.3464013-17-lee.jones@linaro.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 May 2021 15:14:27 -0400
Message-ID: <CADnq5_MXLwMR7XsEiu1pAJ9d8cm6uHA7S4jtuqf-9z=kHbuMww@mail.gmail.com>
Subject: Re: [PATCH 16/38] drm/amd/amdgpu/si_dma: Fix some function name
 disparity
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
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFRodSwgTWF5IDIwLCAyMDIxIGF0IDg6MDQgQU0g
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4gd3JvdGU6Cj4KPiBGaXhlcyB0aGUgZm9s
bG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKPgo+ICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zaV9kbWEuYzozMjA6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9y
IGNpa19kbWFfdm1fY29weV9wdGUoKS4gUHJvdG90eXBlIHdhcyBmb3Igc2lfZG1hX3ZtX2NvcHlf
cHRlKCkgaW5zdGVhZAo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kbWEuYzo0MTI6
IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIHNpX2RtYV9wYWRfaWIoKS4gUHJvdG90
eXBlIHdhcyBmb3Igc2lfZG1hX3JpbmdfcGFkX2liKCkgaW5zdGVhZAo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zaV9kbWEuYzo0MjU6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUg
Zm9yIGNpa19zZG1hX3JpbmdfZW1pdF9waXBlbGluZV9zeW5jKCkuIFByb3RvdHlwZSB3YXMgZm9y
IHNpX2RtYV9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYygpIGluc3RlYWQKPgo+IENjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmln
IiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IENjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRA
bGludXguaWU+Cj4gQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPiBDYzogU3Vt
aXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KPiBDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENj
OiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5s
aW5hcm8ub3JnCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmMgfCA2ICsrKy0t
LQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2RtYS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmMKPiBpbmRleCBjYjcwM2UzMDcyMzhkLi4xOTVi
NDViY2I4YWQ5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NpX2Rt
YS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZG1hLmMKPiBAQCAtMzA1
LDcgKzMwNSw3IEBAIHN0YXRpYyBpbnQgc2lfZG1hX3JpbmdfdGVzdF9pYihzdHJ1Y3QgYW1kZ3B1
X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91dCkKPiAgfQo+Cj4gIC8qKgo+IC0gKiBjaWtfZG1hX3Zt
X2NvcHlfcHRlIC0gdXBkYXRlIFBURXMgYnkgY29weWluZyB0aGVtIGZyb20gdGhlIEdBUlQKPiAr
ICogc2lfZG1hX3ZtX2NvcHlfcHRlIC0gdXBkYXRlIFBURXMgYnkgY29weWluZyB0aGVtIGZyb20g
dGhlIEdBUlQKPiAgICoKPiAgICogQGliOiBpbmRpcmVjdCBidWZmZXIgdG8gZmlsbCB3aXRoIGNv
bW1hbmRzCj4gICAqIEBwZTogYWRkciBvZiB0aGUgcGFnZSBlbnRyeQo+IEBAIC00MDIsNyArNDAy
LDcgQEAgc3RhdGljIHZvaWQgc2lfZG1hX3ZtX3NldF9wdGVfcGRlKHN0cnVjdCBhbWRncHVfaWIg
KmliLAo+ICB9Cj4KPiAgLyoqCj4gLSAqIHNpX2RtYV9wYWRfaWIgLSBwYWQgdGhlIElCIHRvIHRo
ZSByZXF1aXJlZCBudW1iZXIgb2YgZHcKPiArICogc2lfZG1hX3JpbmdfcGFkX2liIC0gcGFkIHRo
ZSBJQiB0byB0aGUgcmVxdWlyZWQgbnVtYmVyIG9mIGR3Cj4gICAqCj4gICAqIEByaW5nOiBhbWRn
cHVfcmluZyBwb2ludGVyCj4gICAqIEBpYjogaW5kaXJlY3QgYnVmZmVyIHRvIGZpbGwgd2l0aCBw
YWRkaW5nCj4gQEAgLTQxNSw3ICs0MTUsNyBAQCBzdGF0aWMgdm9pZCBzaV9kbWFfcmluZ19wYWRf
aWIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLCBzdHJ1Y3QgYW1kZ3B1X2liICppYikKPiAgfQo+
Cj4gIC8qKgo+IC0gKiBjaWtfc2RtYV9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYyAtIHN5bmMgdGhl
IHBpcGVsaW5lCj4gKyAqIHNpX2RtYV9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYyAtIHN5bmMgdGhl
IHBpcGVsaW5lCj4gICAqCj4gICAqIEByaW5nOiBhbWRncHVfcmluZyBwb2ludGVyCj4gICAqCj4g
LS0KPiAyLjMxLjEKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
