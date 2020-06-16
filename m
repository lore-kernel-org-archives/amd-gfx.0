Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D93C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C76208B3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bFVMkeeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C76208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E376E844;
	Tue, 16 Jun 2020 15:24:45 +0000 (UTC)
X-Greylist: delayed 319 seconds by postgrey-1.36 at gabe;
 Tue, 16 Jun 2020 11:28:50 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78DB16E08E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 11:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592306924;
 bh=huDFMMsaa4Ulh6re2u+THK4NQNIrYFu1wKCsPaanNcM=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=bFVMkeeLbYdQFp3BSuxqygXcgfsFbtPJ0yiOgBoy51sTxS4bFs0W/P2pa6HKvaYfM
 c24IwXg+2Ynt/3UsRomCiX7NUvA0Zvh+CKDeslZSWs266fQyQYATAgK1kK2vG2Z1FJ
 y9GjypEQb8hbl62rJc41WrKYYgZVgfxle4Wc3cIQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.138.51]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJZLX-1jjli21DK7-0031rk; Tue, 16
 Jun 2020 13:23:17 +0200
To: Chen Tao <chentao107@huawei.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdgpu/debugfs: fix memory leak when
 pm_runtime_get_sync failed
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ae59e47a-f981-9ae6-840d-1912c01b53cd@web.de>
Date: Tue, 16 Jun 2020 13:23:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:u3t9Od09Vu4D12ZCx29gsAzxYzsjg+REFMWz/C0rnIBfRWDnG16
 oCHAw26d3DReAZJDCVikivyrZ7WiXD6ncPwZw6cOBHfh2TxXzp5qUR/1gCa4yODW5cDUJwd
 mA0dWsBdL7C3WC66C8BZfc5E8ovylJZkEhgs9Rs0FlenEn6KAVa7qUtvvtpIuieH4RdqpgN
 hS43LquQ+vKn9wj+nj1WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uz3bzBcWSa0=:lwKRFgoXKZJveq82K41E1X
 K6Jrc+wp17L5WuUbFw2v26s2X11pyWP69FNRby3f9YNd+ei+C0YAln8aT/NkYZKtihQUpMG08
 S8nOd4Huehc5WbPpBhewsY5vkN2OUqW1euwu1lkbC3fdLhKAfd/Urpng1W1BHi/vQ0qoNHaLq
 ihtaMchzsTtuVmQ3Y599guFRUqNzTdsEbdoonUHjZgqW4TIBJBolxXk7aptXnCG2LVJSigTrp
 clkOeLwG7Ipeb8LaSd+JdElvCAsnPPYN01XGTAzMK6SAFnkVQqm4b/i0kDwemaZSi3R+9R4ij
 fGHSucUul1EbqujIC39ohpqa+ThNSm2feTZYS/VYkXrIPxb8IY8ulAk2iMEl5L8bVEXIVAOi2
 Nl6TkkZh2adN+eRJOPsvgjWhnO64VFWh0bPm0QQNawpWCFGdk13daP8oFxRDlfQVzC28E1dIg
 DPje41SUn8Fo41QQRY3/CH56LgzkEFuruAt2SQBoRBBIWT94ItEK69KZQtRK132DqnGAyYWRQ
 y5Ju1ro4mp2821vY0rJ6tYV/CRAk82z8g/V5MrrQb5HG0q8sEXScCIa12pwGlpIG9XhQ2evCt
 /8P4qDPdyb+JxpWTVx4CjpKMmNl7l7AlE0+p0tw6bJxk3zOU/FPlSdevpT1Cfz1FXaObOxGSx
 8iwVxcJNR+f7QnN5PqSiKNkAs3gEg1/BxjEgUOTeiShICNMTMXZQ9slKu33SL97yxbsYwHqy1
 AV3uYTkETDYnXMY0S4rj5LxQ6oRNm/UrOQ6hitqRmANu4TuLVI7f3i4ImV2D/sj0uR4Mk4B7i
 GFErQRuNmbPbC9b364jHL3AAQYXcHn04P/LBabbyPPc8KKZLjfJniovgbIkUj8QWTtnXzZj+6
 YDCN10W4COf8Am+ykBKFmNG/3d1LcXX5FsnpYDDHeRpYXc6f8PdoXlUHo2EG3PCEUCWsiwmVp
 dbTa88NOP66d0BVFayGGGaypz4/BiHaLKlIp33SssioV7eQVDhse6iJ4yW1eoE56QlyU63la1
 6wgVXjp7FOojh47wSsuiWq0zs4VurPlMtUM3Gt1GvRb2TW+QeaAuzJe1f+s5LARk/SCsmcCvk
 4t5Qi6mO/2j5/jFIdPGCRgC9P8wL2rvofSJrNwgLQLqmQF1mOn9p2QHJmU/xs918sLYZAUhTq
 VMuJXmJEyE3PHvPuO6fbWL2Zky5/PAPXJLPTTsTitwvcWyxHBYHmthpjAqIzMTtJRKXaiZuTo
 dmuFUFKMS1RnqRxhF
X-Mailman-Approved-At: Tue, 16 Jun 2020 15:24:44 +0000
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
Cc: Tom St Denis <tom.stdenis@amd.com>, Chunming Zhou <David1.Zhou@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@linux.ie>, Kangjie Lu <kjlu@umn.edu>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Navid Emamdoost <emamd001@umn.edu>, Qiushi Wu <wu000273@umn.edu>,
 Aditya Pakki <pakki001@umn.edu>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Yintian Tao <yttao@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PiBGaXggbWVtb3J5IGxlYWsgaW4gYW1kZ3B1X2RlYnVnZnNfZ3ByX3JlYWQgbm90IGZyZWVpbmcg
ZGF0YSB3aGVuCj4gcG1fcnVudGltZV9nZXRfc3luYyBmYWlsZWQuCgoqIFdvdWxkIHlvdSBsaWtl
IHRvIGltcHJvdmUgdGhlIGV4Y2VwdGlvbiBoYW5kbGluZyBhbnkgbW9yZSBmb3IgdGhpcyBzb2Z0
d2FyZSBtb2R1bGU/CgoqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgY2FsbGluZyB0aGUgZnVuY3Rp
b24g4oCccG1fcnVudGltZV9wdXRfbm9pZGxl4oCdPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
