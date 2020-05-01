Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077D6C4724C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 19:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D201F216FD
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nEPB/kPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D201F216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EF9F6ED3D;
	Fri,  1 May 2020 19:08:04 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C3EF6ED26
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 18:20:50 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id g26so4736583qtv.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2020 11:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sDjIEM+eSzMwryve6HfF6tWEHpQ1YVsnKklV3y9mbGo=;
 b=nEPB/kPUVu64ALDJjlHG9rMKTiO65lpugPdBC30Nczov+tgzGXPn6wpmV85NOyxRh5
 3llmUpX+zBdGg9ao+A8Dyp3OnqDyGBYB6vqDjCxOxw5mjJPKQo6DB/cC07qH7cSXDWlk
 xT4JrOhmLTygWIPY4TatqdbFhJhSZImrg17m9LM8AKb8xkfmkMFcSYAOisggYpw2tOSK
 s3vV/30613M9nsClks7/z1Whk4BcpdM8wHMSt0GTIsR5+hRulh2NImOiBoJFW/rg1wOH
 inAEReWsuS05YfwJRAyPScaLj42vxYgfD6RLvZrbk1XcHFRCd2h2j5a1KLt7/kD3PyeZ
 vl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sDjIEM+eSzMwryve6HfF6tWEHpQ1YVsnKklV3y9mbGo=;
 b=WmbSCbcyNnUeGjqF1Wdm6FlAFTlWe0G1znRW08XN/Z4/kDi7VWAZNv6GAF9gCZ6r5I
 Cq8OQXV0kI2bm+Bp+FwrcrXDR4FPvuHISNRSchlAWIly5TixSuHKNSvn7ugQXRpEXiWc
 4Ogr9hUgs6N562WxcGihVPjmSWA6G5zSL1+ef6bJXpsH6P1kGg4MKc6q6GreRhQ26soE
 I5Zzlxly5yUCHIHczHR3TUhGidDZ74idgWoVKHzwjU1ZhmA8W6NsWFJe9pjomFmtRDzL
 KeQkBzGWn871jCAWkFWDIjX3ZuVcD6iOPhxHqWmIASoOx5AJ6jCcoclhSWOcOD4KzIu7
 W4xw==
X-Gm-Message-State: AGi0PubgfYk3FT7uevnwWPcns/Q6zvfVqOyZxZEpeQsWIePACHCjLvDP
 FpWH1TvZei/wYnLCkw9iObhdMA==
X-Google-Smtp-Source: APiQypLnto+0lS8NZSLIiaARckcdYZmXp5cRSri5MnUXK85RufiSt8ijYevAzNOi5g9Dq58iHtdy2g==
X-Received: by 2002:ac8:3254:: with SMTP id y20mr5176017qta.67.1588357249676; 
 Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id n92sm3048968qtd.68.2020.05.01.11.20.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jUaHI-0006oH-Ci; Fri, 01 May 2020 15:20:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH hmm v2 0/5] Adjust hmm_range_fault() API
Date: Fri,  1 May 2020 15:20:43 -0300
Message-Id: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 01 May 2020 19:08:02 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFub3guY29tPgoKVGhlIEFQSSBpcyBhIGJp
dCBjb21wbGljYXRlZCBmb3IgdGhlIHVzZXMgd2UgYWN0dWFsbHkgaGF2ZSwgYW5kCmRpc3Vjc3Np
b25zIGZvciBzaW1wbGlmeWluZyBoYXZlIGNvbWUgdXAgYSBudW1iZXIgb2YgdGltZXMuCgpUaGlz
IHNtYWxsIHNlcmllcyByZW1vdmVzIHRoZSBjdXN0b21pemFibGUgcGZuIGZvcm1hdCBhbmQgc2lt
cGxpZmllcyB0aGUKcmV0dXJuIGNvZGUgb2YgaG1tX3JhbmdlX2ZhdWx0KCkKCkFsbCB0aGUgZHJp
dmVycyBhcmUgYWRqdXN0ZWQgdG8gcHJvY2VzcyBpbiB0aGUgc2ltcGxpZmllZCBmb3JtYXQuCkkg
d291bGQgYXBwcmVjaWF0ZWQgdGVzdGVkLWJ5J3MgZm9yIHRoZSB0d28gZHJpdmVycywgdGhhbmtz
IQoKdjI6CiAtIE1vdmUgY2FsbCBjaGFpbiB0byBjb21taXQgbWVzc2FnZQogLSBGaXggdHlwbyBv
ZiBITU1fUEZOX1JFUV9GQVVMVAogLSBNb3ZlIG5vdXZlYXVfaG1tX2NvbnZlcnRfcGZuKCkgdG8g
bm91dmVhdV9zdm0uYwogLSBBZGQgYWNrcyBhbmQgdGVzdGVkLWJ5cwp2MTogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvci8wLXYxLTRlYjcyNjg2ZGUzYys1MDYyLWhtbV9ub19mbGFnc19qZ2dAbWVs
bGFub3guY29tCgpDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+CkNjOiBKb2huIEh1
YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+CkNjOiBKw6lyw7RtZSBHbGlzc2UgPGpnbGlzc2VA
cmVkaGF0LmNvbT4KQ2M6IEJlbiBTa2VnZ3MgPGJza2VnZ3NAcmVkaGF0LmNvbT4KVG86IFJhbHBo
IENhbXBiZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4KQ2M6IG5vdXZlYXVAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBOaXJhbmphbmEgVmlzaHdhbmF0aGFwdXJhIDxuaXJhbmphbmEudmlzaHdh
bmF0aGFwdXJhQGludGVsLmNvbT4KQ2M6IGludGVsLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6ICJLdWVobGluZywgRmVsaXgiIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWci
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiAiRGF2aWQgKENodW5NaW5nKSBaaG91IiA8
RGF2aWQxLlpob3VAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNj
OiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCkNjOiAiWWFuZywgUGhpbGlwIiA8UGhpbGlwLllhbmdAYW1kLmNvbT4KVG86IGxp
bnV4LW1tQGt2YWNrLm9yZwoKSmFzb24gR3VudGhvcnBlICg1KToKICBtbS9obW06IG1ha2UgQ09O
RklHX0RFVklDRV9QUklWQVRFIGludG8gYSBzZWxlY3QKICBtbS9obW06IG1ha2UgaG1tX3Jhbmdl
X2ZhdWx0IHJldHVybiAwIG9yIC0xCiAgZHJtL2FtZGdwdTogcmVtb3ZlIGRlYWQgY29kZSBhZnRl
ciBobW1fcmFuZ2VfZmF1bHQoKQogIG1tL2htbTogcmVtb3ZlIEhNTV9QRk5fU1BFQ0lBTAogIG1t
L2htbTogcmVtb3ZlIHRoZSBjdXN0b21pemFibGUgcGZuIGZvcm1hdCBmcm9tIGhtbV9yYW5nZV9m
YXVsdAoKIERvY3VtZW50YXRpb24vdm0vaG1tLnJzdCAgICAgICAgICAgICAgICB8ICAyOCArKy0t
CiBhcmNoL3Bvd2VycGMvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8ICA1NiArKystLS0tCiBkcml2ZXJz
L2dwdS9kcm0vbm91dmVhdS9LY29uZmlnICAgICAgICAgfCAgIDIgKy0KIGRyaXZlcnMvZ3B1L2Ry
bS9ub3V2ZWF1L25vdXZlYXVfZG1lbS5jICB8ICAyNyArLS0tCiBkcml2ZXJzL2dwdS9kcm0vbm91
dmVhdS9ub3V2ZWF1X2RtZW0uaCAgfCAgIDMgKy0KIGRyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25v
dXZlYXVfc3ZtLmMgICB8ICA5NCArKysrKysrKy0tLS0KIGluY2x1ZGUvbGludXgvaG1tLmggICAg
ICAgICAgICAgICAgICAgICB8IDEwOSArKysrKy0tLS0tLS0tLQogbW0vS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICstCiBtbS9obW0uYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAxODUgKysrKysrKysrKystLS0tLS0tLS0tLS0tCiAxMCBmaWxlcyBj
aGFuZ2VkLCAyMTcgaW5zZXJ0aW9ucygrKSwgMjk2IGRlbGV0aW9ucygtKQoKLS0gCjIuMjYuMgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
