Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11392C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF6932070B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF6932070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF016E342;
	Mon,  2 Dec 2019 21:28:29 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF6D6E340;
 Mon,  2 Dec 2019 21:28:27 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id w15so1088330wru.4;
 Mon, 02 Dec 2019 13:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b6wqyuuSBj+yaJP2U3RhZHtIAcnpGFLYxCKWQBdhnEU=;
 b=p7QC47/2oWJUGHvzGWc7erkPGFuFH0iizfkfQ6NXjTBJs1ySHGQvGZRJlSUR84i+CT
 jMjd+tTkUoM98n65LFLhOPZtDqZ+LvxHWXtPS42W1XgaoI6nCRqifaxxVZF6+y00XKkY
 5MD6/AVfHNfHLk/GIvLXmATFSE4jBnoNEJlwwjzhnegoNXDnKGm5N/49xamPVUlOV4t+
 peyi2PrIPml1FGyiW14UPRcaDwaKOmEhpun43yVyX/mJHxPqn1hS9LfSgO0kBCI4qYQ+
 wo4pJoCS1nYD7hsdhCrgVDqzc1MpiE7qf0ZuFg0BFkSbo0O+VFj6VgVvp1DgVuswt/Wa
 c6tw==
X-Gm-Message-State: APjAAAWxrWhAr+WcqZLM5TDCWcHBd4ehmYISDKYpOsNpYnm4q6NfGjlZ
 2698gJqvDsf1zeuXJrB+/ctzHL3ClosHVC8N5kg=
X-Google-Smtp-Source: APXvYqzFdbeYniJ8C+3vMK1UhWWWKGt7E0ncQMYzvpYUlWxP3eAwgPcOs6m2rfj9xEM5I/GACYU8WF2V8SoGM7GeW0I=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr1283192wrn.50.1575322106438; 
 Mon, 02 Dec 2019 13:28:26 -0800 (PST)
MIME-Version: 1.0
References: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1574847222-51515-1-git-send-email-zhengbin13@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2019 16:28:15 -0500
Message-ID: <CADnq5_MNSUByqeE-ryW5DMkA727jDJNDGD9xVkJFLVTrqQkE-w@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/powerplay: Remove unneeded variable
To: zhengbin <zhengbin13@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=b6wqyuuSBj+yaJP2U3RhZHtIAcnpGFLYxCKWQBdhnEU=;
 b=ammpFRo1UVcl6xefaofyD/hsm43suG6BEcAw+PfNRqNSHhE0CcI0gMBRxe2Na5SUpp
 czODNX55G8WESKsz9r+hii17n18KjTw2zdXyavUEP7voLsOjcaZQb0cjOrUZaSv5/rKr
 0+eBob694e/p3/8Rna7iIP76q0CJUWZUJ7hYNCvwx1qSJv7Qy5Yha9nVhNnkLSs0iBe7
 3I/GE71VzPj8NgcHTFXZO1HAmqFGBbhMblBZ9Q0cPRDxSL+tHbTGa6OO2ntP24qzwJqy
 BXMfKIppdz9VCUz4I7i61Zlkxw89+xrOuJq9GB8M7D3kTJBB/DN+0lfMdELvvCDx382A
 qnlw==
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

QXBwbGllZCB0aGUgc2VyaWVzLiAgVGhhbmtzIQoKQWxleAoKT24gV2VkLCBOb3YgMjcsIDIwMTkg
YXQgMTI6NDIgUE0gemhlbmdiaW4gPHpoZW5nYmluMTNAaHVhd2VpLmNvbT4gd3JvdGU6Cj4KPiB6
aGVuZ2JpbiAoNSk6Cj4gICBkcm0vYW1kL3Bvd2VycGxheTogUmVtb3ZlIHVubmVlZGVkIHZhcmlh
YmxlICdyZXN1bHQnIGluIHNtdTEwX2h3bWdyLmMKPiAgIGRybS9hbWQvcG93ZXJwbGF5OiBSZW1v
dmUgdW5uZWVkZWQgdmFyaWFibGUgJ3Jlc3VsdCcgaW4gdmVnYTEwX2h3bWdyLmMKPiAgIGRybS9h
bWQvcG93ZXJwbGF5OiBSZW1vdmUgdW5uZWVkZWQgdmFyaWFibGUgJ3JldCcgaW4gc211N19od21n
ci5jCj4gICBkcm0vYW1kL3Bvd2VycGxheTogUmVtb3ZlIHVubmVlZGVkIHZhcmlhYmxlICdyZXN1
bHQnIGluIHZlZ2ExMl9od21nci5jCj4gICBkcm0vYW1kL3Bvd2VycGxheTogUmVtb3ZlIHVubmVl
ZGVkIHZhcmlhYmxlICdyZXQnIGluIGFtZGdwdV9zbXUuYwo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyAgICAgICAgIHwgOCArKystLS0tLQo+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXUxMF9od21nci5jICB8IDMgKy0tCj4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyAgIHwgNCArLS0t
Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMF9od21nci5jIHwg
MyArLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX2h3bWdy
LmMgfCA0ICstLS0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDE1IGRlbGV0
aW9ucygtKQo+Cj4gLS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
