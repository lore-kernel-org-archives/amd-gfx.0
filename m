Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75993C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 18:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F130E10E5C6;
	Thu,  2 Feb 2023 18:05:33 +0000 (UTC)
X-Greylist: delayed 759 seconds by postgrey-1.36 at gabe;
 Thu, 02 Feb 2023 17:53:29 UTC
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33E9E10E15B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1675360407; bh=mN21eH/XPnPq9kXuZrjxHtctM5qZSpOe1u7MdwrZ9zQ=;
 h=X-UI-Sender-Class:Subject:From:To:Date;
 b=k2sgI/iePeFTG95EhM6bpRBSnw5oIEMBeYR0A+DvE2ZezymJEfEXT/tm27J5bvEth
 uEVK9sYTqWR8qxlJrRxqiPijQ8967V8o700mhfRyGOkCgALSkkcRKbCODvyoYz1GzU
 7+9ZOpGhojsW9od8e1RQuQYbGR6IglnwPyfuv33CuqLBEwaDZ6t/1ziWhN7Dr0SDNZ
 iNveXhKpn9Gfj9LLzOfC3WvuicLXbL+bSX/6jj6U0zlezr+xRhJGA+6zb4cBNpIJhY
 A7T6QDN28lS5reBZrDxkcEPhmVSM22Q/lb+Pqxkg/lL/4TAIUaHrU7UlDvCLIv9wGR
 yj0BzMnBBHWJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYLii-1p9lpF3o38-00VXsR for
 <amd-gfx@lists.freedesktop.org>; Thu, 02 Feb 2023 18:40:48 +0100
Message-ID: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
Subject: [PATCH] drm/amd: fix memory leak in amdgpu_cs_sync_rings
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Thu, 02 Feb 2023 18:40:45 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:i5yE1HN6bET0YP4a/qcQLUlDdP4se0en6eFR68wttDnbCYTB45J
 jURyhgYxgdq1FhaXN181zUmvpt+6Lw4b0oLdQ9KEgKokJoJlvhzsPKZhuX9+WSeCTRlBrSw
 OufF46uYzGWMoQFEWEeJQZc7e3e840+XWeo0KebAIcZBsbWN6bl/HI0ROeez+o5vU5LTk72
 jmZoFPu2ETJ1BCttzyQEQ==
UI-OutboundReport: notjunk:1;M01:P0:N3GkSDQMxwo=;FgbrDn/ujakhF1vHeTVltPYg74D
 6OqlwrKirQ4zXAU0HIOHjQgrHDbU0rgnJ7YokKDJrpLPwZgBCqPtziZ+BNH8w6VBo4GRZM7Zm
 k8dcyVtn2RgJCpwCIs5VFvUF/hPb+r1qQCGf6Kz+5GP4gTSi9HFZNvfwc51hgzqg8N/ZiMWoJ
 c/jRoHdPqqq4QpNpzzDjguExHvZxO6lz9kUdGoJN122qr3QhEx47O3/dwYWH7NLbIusERVgyI
 F3c02H/RSnlVygL7KJLAkIDO69LKIx1e5H7TZpDV1trJF2MXk1GIZFpqE44uhlcTq4Z3RGX8D
 YPOirrfGUFCOibDeP/PAuhZfITkuR4VmW3vyxamTQ2N3dLmbNzFLb2TctuAQvMQjZgu4/+0uO
 eE+dBR2Sjd568Z+Grf/DS+zm5CSQ38Jb+l+gSMPm27YuEKdVMr8Vbx/Ecbcg2V16tCy+jF2ad
 23JK6ZHaxcmz6IcnAX/TfJSWLsOrX7e/+1VuTA4sO6g/Je6jlXw5bO2nUj8uE5JbJXuRgR21X
 q3JmcRtsQ4c4qm2V6EokixPHBXUbrdOOzREvl60HoyzrDxZaDSAkoW+l/0bl8VjEoHh2MC3ld
 OTuuoDqQnAJkn+rcKVZHG+ZBvAIOH3AftCmRkIr3xj7xPbhaTPzPdDbJo3SPJrlVlLtgi3HI1
 lXS8914I6dLs+4AQd9LeaobhVWesjwWSyrA4MzuSsPTj4b/IPqn5V2uMbAzUBvEVJ1w5NpY/M
 I9L7QvPeONDSTZS5wk+on6xXM0oJyH24fR1QPk9+KoWrLgk6OpREFlH3giyk137YFIVyAtF56
 w5V0SIzyvqH2CTX/QCSXBBqUadyb8jUgK4cxZqcGB7iJgTekWNJVtxdjpbA+4qocdJNtQ7pVE
 1bBRH5yywEenbj7Wkc+07TYtQQ0ZCh8TRiZguiqMM60tCRTRA9VT8fmi+5jzzhdM3B0NMwHOH
 HjWJag==
X-Mailman-Approved-At: Thu, 02 Feb 2023 18:05:32 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_sync_get_fence deletes the returned fence from the syncobj, so
the refcount of fence needs to lowered to avoid a memory leak:
https://gitlab.freedesktop.org/drm/amd/-/issues/2360

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 0f4cb41078c1..08eced097bd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1222,10 +1222,13 @@ static int amdgpu_cs_sync_rings(struct
amdgpu_cs_parser *p)
                 * next job actually sees the results from the previous
one
                 * before we start executing on the same scheduler
ring.
                 */
-               if (!s_fence || s_fence->sched !=3D sched)
+               if (!s_fence || s_fence->sched !=3D sched) {
+                       dma_fence_put(fence);
                        continue;
+               }
=20
                r =3D amdgpu_sync_fence(&p->gang_leader->explicit_sync,
fence);
+               dma_fence_put(fence);
                if (r)
                        return r;
        }


Bert Karwatzki
