Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B3C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79162610CD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 16:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79162610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6065E6EE23;
	Wed, 19 May 2021 16:40:34 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1891A6E204;
 Wed, 19 May 2021 16:40:32 +0000 (UTC)
Received: by mail-oo1-xc29.google.com with SMTP id
 i8-20020a4aa1080000b0290201edd785e7so3143101ool.1; 
 Wed, 19 May 2021 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zNCfFA3iTUAR7nfw2vDgYPSNzR16vnK0bYbOgvyHvMI=;
 b=ElwNI54ICQy3kLGRhcPRnjiEVKd3grPlIaCHCbVvlnT7UyBehL+duguyaJuDEGeNla
 LIdGAtPIvVlErfA8WvAp5FJCC1FFRQt4/WlVJTp+Pcoiqg/57+940JXyVdZuB3a7iq2L
 NYwE0kpUTx16BXX+vhmGwwPtFTiQiM+Pvd23jNVrj7OWYXvkP4vzj3xXV2BWXLBhQEJk
 N94EiZmPdTZNWD9NgsXHy9t0wyAPIjVJfY6UH9Ytw+qWHWgABlkV0tfKGImOI5juAq+K
 1wljiSP3B0bzUNflsGoTfpCOITy/YKmiw5Z4UgEjl2iPk7QSQD9jjDv7zhUQ248Kpizr
 7Huw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zNCfFA3iTUAR7nfw2vDgYPSNzR16vnK0bYbOgvyHvMI=;
 b=kna1SQJQjqwAsb0dROpt1tjq8ghchPP+M2W8H3P8kSGJD6qMNZQxpmZy5ctqVpDEEA
 UdiTYaSWmbucNI6kkTv7lHBHjTKIS5bNEot2RoEv0k+6mkXDAyZ+Ng4fEcO2/w6hZuD6
 gOSPBFz30ZR452pKvlgL8Mvxny11V6+hcjF9MpFhj50hDmM2I/nLEDqfrLDeIh9OEgI5
 +2vZ2lGimxNlObCGb3Gi8sZnsMy4mlI4xNrQJZ0FE+cZYFWZkQcd+pzVROxYuuAIx3RS
 iz7u6Elq0L4jW62TVZtDHEhtsuOB5LLj+Q7SDTjd2HOBCP/KgStdyQjXQKz7dj7NYOtM
 dhwg==
X-Gm-Message-State: AOAM532o5LB8ok+hDl+O0GjR549OBxbg/SP0jnrQklM4CIo5ad8wACbW
 3DNaovREIwv3csDJ2AQEk6THxgw+vUvsGB9c4mM=
X-Google-Smtp-Source: ABdhPJw+067c2L/99GOWZARWXw0ORPgXXpEmAbt8nOwAFfgxloS+AgmpmBOVRQ9uXbAXbjRbOfYF6KedqOaKfQta3Fk=
X-Received: by 2002:a4a:d085:: with SMTP id i5mr142853oor.61.1621442431315;
 Wed, 19 May 2021 09:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
 <f0589aff-a776-0715-e421-0d9a8cf2cc25@infradead.org>
In-Reply-To: <f0589aff-a776-0715-e421-0d9a8cf2cc25@infradead.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 May 2021 12:40:19 -0400
Message-ID: <CADnq5_OjJTfwhbEBMFoM-zux8CPDgQhi_6FHpcFYVXYn+CZR7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpu: drm: replace occurrences of invalid character
To: Randy Dunlap <rdunlap@infradead.org>
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
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Chris Wilson <chris@chris-wilson.co.uk>, David Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UHVzaGVkIG91dCB0byBkcm0tbWlzYy1uZXh0LiAgQWxzbyBmaXhlZCB1cCBNaWNoZWwncyBuYW1l
LgoKQWxleAoKT24gV2VkLCBNYXkgMTksIDIwMjEgYXQgMTE6NTYgQU0gUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gT24gNS8xOS8yMSAxOjE1IEFNLCBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgd3JvdGU6Cj4gPiBUaGVyZSBhcmUgc29tZSBwbGFjZXMgYXQgZHJt
IHRoYXQgZW5kZWQgcmVjZWl2aW5nIGEKPiA+IFJFUExBQ0VNRU5UIENIQVJBQ1RFUiBVK2ZmZmQg
KCfvv70nKSwgcHJvYmFibHkgYmVjYXVzZSBvZgo+ID4gc29tZSBiYWQgY2hhcnNldCBjb252ZXJz
aW9uLgo+ID4KPiA+IEZpeCB0aGVtIGJ5IHVzaW5nIHdoYXQgaXQgc2VlbXMgICAgICAgdG8gYmUg
dGhlIHByb3Blcgo+ID4gY2hhcmFjdGVyLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdXJvIENh
cnZhbGhvIENoZWhhYiA8bWNoZWhhYitodWF3ZWlAa2VybmVsLm9yZz4KPgo+IEFja2VkLWJ5OiBS
YW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPgo+IFRoYW5rcy4KPgo+ID4gLS0t
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21iaW9zLmggICAgICAgfCAxMCAr
KysrKy0tLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3B1X2NvbW1hbmRz
LmggfCAgMiArLQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZ3B1X2Vycm9yLmggICAg
ICAgIHwgIDIgKy0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcjEyOC9yMTI4X2Rydi5oICAgICAgICAg
ICAgICB8ICAyICstCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVs
ZXRpb25zKC0pCj4gPgo+Cj4gLS0KPiB+UmFuZHkKPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
