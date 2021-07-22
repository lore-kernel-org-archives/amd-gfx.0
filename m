Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C629CC63797
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 17:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB3F61358
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 17:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB3F61358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF366E86B;
	Thu, 22 Jul 2021 17:26:39 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C376E86B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 17:26:38 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 59-20020a9d0ac10000b0290462f0ab0800so5981296otq.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tkjJcM9kuIrvToc1Fjd4keGibDY2FDt4nTNihlvxVPQ=;
 b=StFuiFq/trZmjGCzhMcGbDw9AQhjq9VqNtAMjWx8UO+kKPmWkG4zi8qhEYedk9cZyn
 D2VRfklkyxj/VwUIAL1HiIAyp8fyzdf56HHIrbgJCgq7dCw6v36B28EdxugSfL4gSCHV
 w283S5cJnv8k++q1JGMNED/h36REMq0quWjVWbgiYuX1xNiNO43obxAOXre9HyHAvOS7
 L6XDuS1VEDbYm2kAzDhOSiHCd8VO6M65i+eLzp7N3R7HKC6UQN9L1YBYpiKYEBbG8YFV
 SvKTjyURYR0yPFFjUmgrw8VkvQqLWe6Cw+IB+9g2KKrPHqS/9ddt7xSwMzXGGA0xCxiq
 pDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tkjJcM9kuIrvToc1Fjd4keGibDY2FDt4nTNihlvxVPQ=;
 b=TQVkCvZ4Kp/rR98dDEjRqDsKL38YyToCqS0AIZbA5BWmtZg4Jed0MnWeNBWLP+zeQG
 Zs/h9DuOsMKJd+1LWj5dyBZX5xtUkvmbIEpxPQcLpktycFhU20EwSmMK43xXXEkInEZ8
 u+SQC/fAkaqvviO+MDfUgX4sSA1ZElw2GWjfy4OS6fSWbXQtsI88ldzPkl/7NwYhcRQy
 wb5GTyA7DwOFCYgGFCyhGAfn8fJjHkqiVqO3g4D2ciGRXUhJDLm1eGDqkePhJeqqNPmT
 q7zYGDm2aiMhiBLFDncMyt+I0PWOlBb+9M4nzwo7cjFwYydRbgd0xX3M+JrJ8W7zTKDK
 T5uw==
X-Gm-Message-State: AOAM532+LEHsl/kMo4tHnEF/qebEFeX5UzLjjThGJF1eZjOrZCY70zIV
 8qC9nrcKHTE7SiwKkoPVgTN7BXuydrrnuF6R8fxmjlmuF/U=
X-Google-Smtp-Source: ABdhPJyLaRWJ8lPVNtn3nsl/KpqynRDPPquHK1PIXbYDy6zsSAXFJB66NTsOyw5Z3KHTOCcfSLBq0buJYRxwc5cJJFU=
X-Received: by 2002:a05:6830:1f3b:: with SMTP id
 e27mr538311oth.311.1626974797456; 
 Thu, 22 Jul 2021 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <1953107.aqVA8tz2my@ananda>
In-Reply-To: <1953107.aqVA8tz2my@ananda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jul 2021 13:26:26 -0400
Message-ID: <CADnq5_P7M2jvJL=fZecVPUgca7XpzFWP-7Q874jeiwJwtO4jjQ@mail.gmail.com>
Subject: Re: ThinkPad T14 Gen 1 AMD switching to lowest brightness during boot
 process with 5.14-rc2
To: Martin Steigerwald <martin@lichtvoll.de>
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
Cc: Mark Pearson <markpearson@lenovo.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1LCBKdWwgMjIsIDIwMjEgYXQgMTA6MDQgQU0gTWFydGluIFN0ZWlnZXJ3YWxkIDxtYXJ0
aW5AbGljaHR2b2xsLmRlPiB3cm90ZToKPgo+IE5vdCBzdWJzY3JpYmVkLCBzbyBwbGVhc2UgQ2Mg
b24gYW5zd2VyLgo+Cj4gSGkhCj4KPiBKdXN0IGNvbXBpbGVkIDUuMTQtcmMyIGZvciBteSBUMTQg
R2VuIDEgQU1EIHdpdGggIkFNRCBSeXplbiA3IFBSTyA0NzUwVQo+IHdpdGggUmFkZW9uIEdyYXBo
aWNzIiB3aXRoIExvdyBQb3dlciBEaXNwbGF5ICg0MDAgTml0cykuCj4KPiBVc2luZyB0aGF0IGtl
cm5lbCwgdGhlIGRpc3BsYXkgc3RhcnRzIHdpdGggdGhlIHVzdWFsIGhpZ2ggYnJpZ2h0bmVzcy4K
PiBIb3dldmVyLCBkdXJpbmcgYm9vdCB0aGUgYnJpZ2h0bmVzcyBnb2VzIGRvd24gdG8gd2hhdCBh
cHBlYXJzIHRvIGJlIHRoZQo+IG1pbmltdW0uIEluIEtERSBQbGFzbWEgaG93ZXZlciB0aGUgYnJp
Z2h0bmVzcyBvZiB0aGUgZGlzcGxheSBpcyBzaG93biBhcwo+IG1heGltdW0uCj4KPiBJZiBJIG1v
dmUgYXJvdW5kIHRoZSBicmlnaHRuZXNzIHNsaWRlciBqdXN0IGEgZmV3IHBlcmNlbnQgZG93biBm
cm9tIDEwMAo+IHRvIG1heWJlIDk4JSBvciBzb21ldGhpbmcgbGlrZSB0aGF0IHRoZSBicmlnaHRu
ZXNzIGlzIGltbWVkaWF0ZWx5IHJlc2V0Cj4gdG8gaXRzIGFjdHVhbCB2YWx1ZSBkaXNwbGF5IGJ5
IHRoZSBzbGlkZXIuCj4KPiBUaGlzIGRpZCBub3QgaGFwcGVuIHdpdGggNS4xMy4KClBsZWFzZSBm
aWxlIGEgdGlja2V0IGhlcmU6Cmh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1k
Ly0vaXNzdWVzCkNhbiB5b3UgYmlzZWN0PwoKQWxleAoKPgo+IEkgYW0gc3RpbGwgb24gWDExIGFz
IHNvbWUgS0RFIFBsYXNtYSBmZWF0dXJlcyBhcmUgbm90IHlldCBhdmFpbGFibGUgZm9yCj4gV2F5
bGFuZC4KPgo+IFRoaXMgaXMgb24gRGV2dWFuIENlcmVzIOKAkyBiYXNpY2FsbHkgRGViaWFuIFNp
ZCB3aXRob3V0IFN5c3RlbWQg4oCTIHdpdGgKPiBSdW5pdCBhcyBpbml0IHN5c3RlbSwgc28gdGhl
cmUgbm8gYXV0b21hdGljIFN5c3RlbWQgYnJpZ2h0bmVzcyBsb2dpYwo+IHNob3VsZCBiZSBpbnZv
bHZlZC4KPgo+IElmIGF0dGFjaGVkIGtlcm5lbCBjb25maWd1cmF0aW9uIGlzIHN0cmlwcGVkLCBw
bGVhc2UgbGV0IG1lIGtub3cuCj4KPiBCZXN0LAo+IC0tCj4gTWFydGluX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo=
