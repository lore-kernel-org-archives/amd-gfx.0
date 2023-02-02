Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E077FC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Feb 2023 19:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAB810E5E2;
	Thu,  2 Feb 2023 19:10:29 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Thu, 02 Feb 2023 19:07:43 UTC
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DE9010E5E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Feb 2023 19:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1675364861; bh=TQjvO93Kgz2n7oRGSsIjxzZoFjGjOpFSZVKs3wGdiNQ=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=cB1mnt81fjj1ts4BOA4wFtQo+Eh7JggQcsnx7njGMRgftYUytd3H2neiABrUE2HOP
 /M67XeHp6ERs9Flr3L5hQYYrPV5CxnGRh11DwlNYKafW+F64bPxGa6Gwd86shEJm07
 U1lTb7C7nFxxc32GbiimS+DSLcyyD+ARDF1+vglPntI2Wh8exCD7+zo0q5SesPh+EF
 3a+8by5Ppt/GjrXELzMQIUpK8PWJJWcCHsONWjQ8pYwcpZIZc1dAoZIFAhOVmTcjQ5
 B2jWizH908Is/bR42yDNFWLIJ4v5reDzDVxLmrOsi4W76p/coCfQFNLrfn04dMldbo
 Ty7CeR61Ltuag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRQJ-1ohjrW10m7-00htoq; Thu, 02
 Feb 2023 20:02:37 +0100
Message-ID: <3b590ba0f11d24b8c6c39c3d38250129c1116af4.camel@web.de>
Subject: Re: [PATCH] drm/amd: fix memory leak in amdgpu_cs_sync_rings
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 02 Feb 2023 20:02:36 +0100
In-Reply-To: <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
References: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
 <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:hk/4gEUuoSO/dtpol5oD489qNq9aSVHTwIN1UAnFO68US/ByvdZ
 Eqiggg7j5QniOMXmrlKuMDJo8ufaWLG1xwHdgcRORJMRf5C3TDtb6nFO8puhBgR5QDfmrkt
 4VU6p2l6GkN+VJWUX2QeMK8pATNObC+HKeUU60IG1+dc/srFJ1A1b59wWpwSJykJ8W/vj6k
 cN3IQjilhm1odf6+QogiQ==
UI-OutboundReport: notjunk:1;M01:P0:f8wrG3vUCiY=;JsEsPIi1gGgMPQUtqOL0yWr5Z51
 hd4ZWqjumkndjC4rZwfeDuG1ECb5zuLJDHkSkG8ipPWACGyYqIdQN2GnMoRT0qhm/83dJqBQ/
 TqF9IIKPvQTOCvCZlnFS16oSX+z04bK2FSdJwRAIww9JNkE7Ld31IfS8RA3CTLKHSNwU980xG
 YLHc58axzV/deolL21yereLqcmEfRK8XQR6+e6fKB9h5fmdn4LpfPpp2dHoX1qxfUCY+IiQNO
 Tz8PANqaRRCG63pN70sxOFO/6xneHyEUQHRQPEWj3+qUnpu2BWrCgjJg0cLcqSax2QRuAISul
 XFILtNxo1lj5C9s69LDWbTtTWnIQ05v/Qfd6gsa+sumVX/jaLqmlpXH+MvsiyqbiIWJ3z9irY
 TvF9Wkft5tLHKvQ1EjHWPTTHWrYoCf4Ey88WElJKtatWbzGjpdRdg3D0+5TojdHAhCSY32ugp
 /kjqO42SWedOc6sZ5UtWiJvFPXr9zosghA8SaaZe+eSAPweY93OyIrLZ3jjcYZXt6RcfHCnEi
 W3ZJxNYGegfkCvdn/HnRyu+lUyNn11LQP9jTd4bE4OBlVDf2aVV/89oPkmFrlO6YSZxycIg6o
 fMBn9GkdnffNbTdu74pDFcf/7US4WjjAi45SzR2BPH6mYdvfDAjfSxhA/APOb8pzjPIbc0/fX
 nl9G+Jsp7U6PNJNRFQzcRMymIuKGFsZ9I3Kq9QXchDxH/PV2OBYnjZsAHIShSdlCONf/S5b16
 f18F9AluyKAmEGn6kD416fvc+fCgdFIRid9OSdVfSBEBRQs6gzGNehHM/vAAvdHaw6wydGMXa
 jkN2vCMaN6w9sYbjV5pG1N4+Kjp9HJOKK1NToFHuIVpzvNZRem7Bq7eLhLFRxH8hPGmCrqgns
 bc+pv/aJrDiKxHiUHlAkivAQxfJJ7YZo5SDwjaYKP6D0bQQ8qA05jbTOrLqcm1J3qCCOpEzgx
 rnYH9/0xjNQW+bKcF333rVQkMKk=
X-Mailman-Approved-At: Thu, 02 Feb 2023 19:10:27 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I hope I got it right this time:
Here is the fix for
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2360

From 6e064c9565ef0da890f3fcb2a4f6a8cd44a12fdb Mon Sep 17 00:00:00 2001
From: Bert Karwatzki <spasswolf@web.de>
Date: Thu, 2 Feb 2023 19:50:27 +0100
Subject: [PATCH] Fix memory leak in amdgpu_cs_sync_rings.

Signed-off-by: Bert Karwatzki <spasswolf@web.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 0f4cb41078c1..08eced097bd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1222,10 +1222,13 @@ static int amdgpu_cs_sync_rings(struct
amdgpu_cs_parser *p)
 		 * next job actually sees the results from the
previous one
 		 * before we start executing on the same scheduler
ring.
 		 */
-		if (!s_fence || s_fence->sched !=3D sched)
+		if (!s_fence || s_fence->sched !=3D sched) {
+			dma_fence_put(fence);
 			continue;
+		}
=20
 		r =3D amdgpu_sync_fence(&p->gang_leader->explicit_sync,
fence);
+		dma_fence_put(fence);
 		if (r)
 			return r;
 	}
--=20
2.39.1


Bert Karwatzki
