Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FE3CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71E4B217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 14:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E4B217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACAA6E895;
	Mon, 28 Oct 2019 14:06:20 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CAB66E88E;
 Mon, 28 Oct 2019 14:06:18 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id w18so10057769wrt.3;
 Mon, 28 Oct 2019 07:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rdC6V+W/0pKqgJwzkGX8wwGtenk6Ad4eyp94SQwYZN8=;
 b=lXkTudwduBTJdnQERLSq+f0hcLfFfSZNYp758CAVCKbjY8G7CmvEBCEcvzDIgDD+56
 yxlMBkZjr7jmcnzrRUBDdP63MnixjWRh+IGyrMiw156DTfibbZZIcvdaLgYuln3YEZHk
 PuocwfRJcMYAxUFLPDutF9e0OS9VKr46VIFJ60uCAZPHv/5dk8fDiEZUumY1m7mLcToj
 10Bs4aiEETP+e8aw0Vgoyfm647AVhJLiofGnYI0qNiTBDBVC0+wmz+WDcOsygw3vdc5J
 Py0rIgl1K4OxvLvXlXDz3gzgbbh2RMoc//FFf4rrGv0YV9TSuu4o/5U5Qa5Ieu8gQ/1o
 lp/A==
X-Gm-Message-State: APjAAAW49UCuI32QLM6/3Ou8PyDtDlrW+i41c8nSMonALrhr3lRkUTU5
 RDPXi/GJ0Akziq2qwa0eXh+GloBIa0zkhSG0ppI=
X-Google-Smtp-Source: APXvYqx93VfHYQta5r6YehJQFm4Zit5CjBpG85IfDnlOhBb4sBmoUGmL/PYIDYPF4ekeP2EWvHda9cyimGmob83AeLk=
X-Received: by 2002:adf:828c:: with SMTP id 12mr15047712wrc.40.1572271577123; 
 Mon, 28 Oct 2019 07:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191028133621.21400-1-yuehaibing@huawei.com>
In-Reply-To: <20191028133621.21400-1-yuehaibing@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2019 10:06:05 -0400
Message-ID:
 <CADnq5_Ow+W_Syo6G3ZUXJeiLbc4YU=DL1FtznaTKm=RGj4tq1g@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/powerplay: Make two functions static
To: YueHaibing <yuehaibing@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=rdC6V+W/0pKqgJwzkGX8wwGtenk6Ad4eyp94SQwYZN8=;
 b=R5HdV1xFRhfl7jlVF2ygGLA04qDiJw37QSOQZkF7MsnXM5HNM18K4iIPwjs+t3zEUg
 4c/cqHnL2KkIfbY826muE9b5MAoamhv4k7YEbjhAau9OnEU3xDZTMxabEHkjIePduZZj
 sHBbDma0c0O/cHzx7Pkwc7xNE/Zr1TEGxfqpKIGIczkz2oNIJFdkIPqtpyPp6jWbMRvc
 7VM7JHIzh42deYRq+7Pv2L01pohfPkZrcjftyBzrKZt7gOyBW1GQLkAWhHr/GC7Lwutg
 3unltK9XvVTaNIIAMyq0E9vR+o6Sz4RkgQcXuPwJQ98p9o/R0AB4H3e/T53SzUKd6b40
 8w2A==
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
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Quan,
 Evan" <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028140605.nxpyPGJ8QFGbMHU5bYBM1JvuiBgp21wpSzz0ldXfI4Q@z>

T24gTW9uLCBPY3QgMjgsIDIwMTkgYXQgOTozNyBBTSBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+IHdyb3RlOgo+Cj4gRml4IHNwYXJzZSB3YXJuaW5nczoKPgo+IGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYzoyMDUwOjU6Cj4gIHdh
cm5pbmc6IHN5bWJvbCAnYXJjdHVydXNfaTJjX2VlcHJvbV9jb250cm9sX2luaXQnIHdhcyBub3Qg
ZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jOjIwNjg6NjoKPiAgd2FybmluZzogc3ltYm9s
ICdhcmN0dXJ1c19pMmNfZWVwcm9tX2NvbnRyb2xfZmluaScgd2FzIG5vdCBkZWNsYXJlZC4gU2hv
dWxkIGl0IGJlIHN0YXRpYz8KPgo+IFJlcG9ydGVkLWJ5OiBIdWxrIFJvYm90IDxodWxrY2lAaHVh
d2VpLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5j
b20+CgpBcHBsaWVkLiAgVGhhbmtzLiAgSXMgdGhlcmUgbW9yZSB0byB0aGlzIHNlcmllcz8gIEkg
ZG9uJ3Qgc2VlIHBhdGNoZXMgMSBvciAyLgoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCj4gaW5kZXggZDQ4YTQ5ZC4uMzA5OWFjMiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9hcmN0dXJ1c19wcHQuYwo+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FyY3R1cnVzX3BwdC5jCj4gQEAg
LTIwNDcsNyArMjA0Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2FsZ29yaXRobSBhcmN0
dXJ1c19pMmNfZWVwcm9tX2kyY19hbGdvID0gewo+ICAgICAgICAgLmZ1bmN0aW9uYWxpdHkgPSBh
cmN0dXJ1c19pMmNfZWVwcm9tX2kyY19mdW5jLAo+ICB9Owo+Cj4gLWludCBhcmN0dXJ1c19pMmNf
ZWVwcm9tX2NvbnRyb2xfaW5pdChzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmNvbnRyb2wpCj4gK3N0YXRp
YyBpbnQgYXJjdHVydXNfaTJjX2VlcHJvbV9jb250cm9sX2luaXQoc3RydWN0IGkyY19hZGFwdGVy
ICpjb250cm9sKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IHRv
X2FtZGdwdV9kZXZpY2UoY29udHJvbCk7Cj4gICAgICAgICBpbnQgcmVzOwo+IEBAIC0yMDY1LDcg
KzIwNjUsNyBAQCBpbnQgYXJjdHVydXNfaTJjX2VlcHJvbV9jb250cm9sX2luaXQoc3RydWN0IGky
Y19hZGFwdGVyICpjb250cm9sKQo+ICAgICAgICAgcmV0dXJuIHJlczsKPiAgfQo+Cj4gLXZvaWQg
YXJjdHVydXNfaTJjX2VlcHJvbV9jb250cm9sX2Zpbmkoc3RydWN0IGkyY19hZGFwdGVyICpjb250
cm9sKQo+ICtzdGF0aWMgdm9pZCBhcmN0dXJ1c19pMmNfZWVwcm9tX2NvbnRyb2xfZmluaShzdHJ1
Y3QgaTJjX2FkYXB0ZXIgKmNvbnRyb2wpCj4gIHsKPiAgICAgICAgIGkyY19kZWxfYWRhcHRlcihj
b250cm9sKTsKPiAgfQo+IC0tCj4gMi43LjQKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
