Return-Path: <SRS0=j4R+=ZO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23413C432C0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0123720715
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2019 18:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0123720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9598D6F547;
	Fri, 22 Nov 2019 18:24:15 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35416F547;
 Fri, 22 Nov 2019 18:24:14 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id t1so9770558wrv.4;
 Fri, 22 Nov 2019 10:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EUebLe9HHF+JBDPm1PDOzLXkVPJUxFB6cAl/yRm/mOg=;
 b=JzKNI72k6SN3w9HgliDDzynaTEBVnZr8+tt2lg8U8jcCJ4+ZrMfGMICFXpMAPv9bhr
 kmzoylzmK2umdEi17DtbwLhaRD1k9FAvIEmfrk8B+RNem8yevlTlzov8d9HW8/h17QIX
 J4GMW0M8roXkaWq2B2oXS/VCcXDgY7CAXbl3A+o9jnBT2vwsU/PPv52MDSSwWvTYJOHB
 I0vd1paKxc+wRo9FnJj2B0CL2koUEeWXBGGeHJU9ehtD7BwQVTSFTQrwtvFI/U8Y2yMx
 ZmNSkYu6irQTOk4KdzIJPhZuZuwo613dv49v+Lasp/Xp1QOylfXGpkWQCqa8qsUnBDcD
 XG5A==
X-Gm-Message-State: APjAAAU24RHjV/2LNuS36Z7pVPBniHIkvyF/C+LYmvr/00N8qHvXYHuT
 JT4rRCP9Wu3nTavzIDYq32QC/BMPcss8cQ6ao50=
X-Google-Smtp-Source: APXvYqzX9fUGNo37XOhv8jBVKMnVD0YvB1dG4I8v4K3X02lHaSjhwjYsWxgzLxMQbwc8wnDLxckveiqk6h41Yu54vbM=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr18982651wre.11.1574447053295; 
 Fri, 22 Nov 2019 10:24:13 -0800 (PST)
MIME-Version: 1.0
References: <1574394172-18216-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1574394172-18216-1-git-send-email-zhengbin13@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Nov 2019 13:24:01 -0500
Message-ID:
 <CADnq5_NpbWYTG_1OzO7r6ioziQngQTKtQErsd5MWNjzRNFNKRA@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/amd: Use ARRAY_SIZE
To: zhengbin <zhengbin13@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=EUebLe9HHF+JBDPm1PDOzLXkVPJUxFB6cAl/yRm/mOg=;
 b=pJCRi8aqJv83LGeUettHYF73eSj6241WALue3yKd0tOGjLZoYs6Inpwmqgf1qjhAaW
 3KOCouv/R1eZW0l5Xj329X9pmBzWr39uPiyJogK2Cfnitbf/x9pt4fHMVG/LVLQbZ5Iq
 zK6F/3GIRHL7YYofaoAY/BaY75AtcUdzn0INgYMpWlYNHCHqNgRLks5nz1NRXZk0ZFFR
 MS/Mov0NYOCsihdzan/0skarO/sLXAtEBuGmrnzXoeSSscJCVu1C81z4UDTbR3ztGs2x
 Yg72DD9LD6k4o3njaChqmLQ05fVPqkufgujzyA+RQEzhJFaqOwlo2aJVtIvB793oWQz3
 XBjg==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Quan, Evan" <evan.quan@amd.com>,
 Rex Zhu <rex.zhu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122182401.WSrKuKG4OFJZNjsW8fjG_DwQOktVoa422hm8Wl3DYl8@z>

QXBwbGllZCB0aGUgc2VyaWVzLiAgVGhhbmtzIQoKQWxleAoKT24gRnJpLCBOb3YgMjIsIDIwMTkg
YXQgNDowMSBBTSB6aGVuZ2JpbiA8emhlbmdiaW4xM0BodWF3ZWkuY29tPiB3cm90ZToKPgo+IHpo
ZW5nYmluICgyKToKPiAgIGRybS9hbWQvcG93ZXJwbGF5OiBVc2UgQVJSQVlfU0laRSBmb3Igc211
N19wcm9maWxpbmcKPiAgIGRybS9hbWRncHU6IFVzZSBBUlJBWV9TSVpFIGZvciBzb3Nfb2xkX3Zl
cnNpb25zCj4KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvcHNwX3YzXzEuYyAgICAgICAg
ICAgIHwgMiArLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3
bWdyLmMgfCAyICstCj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Cj4gLS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4gZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
