Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E37CCA479
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 07:20:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0608B10E696;
	Mon, 20 Jun 2022 07:20:12 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.36 at gabe;
 Sat, 18 Jun 2022 16:20:41 UTC
Received: from er-systems.de (er-systems.de [148.251.68.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5755710E8F3
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jun 2022 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by er-systems.de (Postfix) with ESMTP id C1533D6006E;
 Sat, 18 Jun 2022 18:13:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by er-systems.de (Postfix) with ESMTPS id 9A85BD6006D;
 Sat, 18 Jun 2022 18:13:29 +0200 (CEST)
Date: Sat, 18 Jun 2022 18:13:28 +0200 (CEST)
From: Thomas Voegtle <tv@lio96.de>
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
 Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org
Subject: Performance drop using deinterlace_vaapi on 5.19-rcX
Message-ID: <0249066a-2e95-c21d-d16a-fba08c633c0b@lio96.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-74181308-596245421-1655568809=:14383"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV
 0.103.6/26576/Sat Jun 18 10:07:50 2022 signatures .
X-Mailman-Approved-At: Mon, 20 Jun 2022 07:20:11 +0000
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
Cc: linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74181308-596245421-1655568809=:14383
Content-Type: text/plain; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT


Hello,

I noticed a performance drop encoding a mpeg file to a h264 video using
the vaapi option deinterlace_vaapi on a Haswell i5-4570 with Linux
5.19-rc1.

A 10 minute long video takes normally 41s to convert, now with 5.19-rc1
it takes about 2m 36s.

My ffmpeg line is:
ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128
-hwaccel_output_format vaapi -i test.vdr -vf 'deinterlace_vaapi' -c:v
h264_vaapi

Removing the option deinterlace_vaapi shows no difference in performance 
between 5.18 and 5.19-rcX.


I bisected this down to:

commit 047a1b877ed48098bed71fcfb1d4891e1b54441d
Author: Christian König <christian.koenig@amd.com>
Date:   Tue Nov 23 09:33:07 2021 +0100

     dma-buf & drm/amdgpu: remove dma_resv workaround


and wasn't able to revert this one on top of 5.19-rcX.

I tried the predecessor commit:

commit 73511edf8b196e6f1ccda0fdf294ff57aa2dc9db (HEAD)
Author: Christian König <christian.koenig@amd.com>
Date:   Tue Nov 9 11:08:18 2021 +0100

     dma-buf: specify usage while adding fences to dma_resv obj v7

which is fine.

Using ffmpeg 5.0.1 with libva 2.10.0 and intel vaapi driver 2.4.1


  Best regards,

     Thomas
---74181308-596245421-1655568809=:14383--

