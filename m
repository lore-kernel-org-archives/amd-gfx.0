Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2FD606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RMZzsZaD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 787CA10F4A6;
	Tue,  3 Nov 2026 09:36:52 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B85910E13F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 00:02:44 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5be4a2d94adso3346643e87.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 16:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793664162; x=1794268962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TB2rTonVyZ5fK+KmoRWiGGYGmxLOK69cu5jNgurdHBU=;
 b=RMZzsZaDS2vYS52uFFU386ERJhtBqcXhJRlLYn8C6QyI/VU/fRiY64jwCc1KnChE+9
 0P0TkSG0x7RweEoB2Zn/tvw7+05HKAymIskvp57jhwlUA23e8oRZCqr3usxB1CpVqJrT
 4Aj0Evj1v9ssYKxxgc9OZvJ6zg//9B/Kf9FEY1ZJTUCJffGsvpKy1FG0a0bgXCb3zC7W
 Cv3AJM6Vi3OA7BAMbfinmj8fRH09SihDU/XLvDovJl9eN7svIRXSSd0srdvjr+Qimk6R
 wbtrPtHffUQrzpWfPRiQPY075Zxg9uqoArinyVNomRRERKV6zqXYhnzSR0c6Ttnll5Rc
 2wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793664162; x=1794268962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TB2rTonVyZ5fK+KmoRWiGGYGmxLOK69cu5jNgurdHBU=;
 b=d45Q80sZ0cTLNKEtKgv3Tuzeiwvj9+1xVyMKgUweU3AUs0J4vEY8GcJUtJl6AEjtcC
 FL5w+n2odXzFnfgZ77Z1DKGBH4smUh3GJa8TZ1/9gfToQ47yhQdnyS2lS/atR49UKNCo
 5+4v9KFeWq46zXeCrON8KtiNsixYOXOXYyVU659qRuN6bAar6PfZLrO5zU9my+7MuY/E
 LgsvWlKwYwS4UZg5+5bg47hshs3ot43Os77Ne8aCo86JbjfMbJ7/sicUVcAhE+fljVg2
 jWfdd1ypzHyAvZO92+s34pvARpfXZamDo0rnzz0tO5dN9LkDFV8cPNfLOwQ/A867DPXB
 5+yQ==
X-Gm-Message-State: APuU4Z8aHuuY2AbKrB4TsXRHKmNLKC1WAq+l+MsOtpomOPPmX0rX7UA9
 ZFbnd356Qvkocdd8ybz15Th6kX8FB6ejv1htiURjGNkM2oauNs/j+qYcnFkQM4WGLznnHAXj/jA
 =
X-Gm-Gg: AYBFou1OHyyqfzL5OJQnhj2c76Efpw3O4JJnFnFGcah4807JWK8FKb3Lu/Wj78oa+c5
 /sJn3JN2Hvw6HS2qOXhyPjiqAyPjS3YR5b3Fr5k+C+wLXhOYKSm/K8dyYMNAY+BpOgSD68Zjtfz
 9R/MaOJ8g6TcC6zRrXyBd/GJmN+sxDNoBIXrGNYGqy3XUxmBtnZYiNJlSyO4b4wqiepTC4Zu7RH
 ChNMJtVnRLVUiOUqLEjt0wogbNnJl4ntVAGCnp4SRr9B3hUGaHViPrZziawpLVy8pSsERqjPaOW
 2R6acTYPBoA8fdyRt9/qHDLKcgjOOR6ffMj8p019TNa6cTBhq1MM6KTfLOAgVerhh7/dZMgyXNV
 XeTU1vdyy31B0VrOU81b1NVfW38K13cm/kLPsXjWj3gcPKfzFdB03eblS8TtigxZQ7Rmk+Iuk58
 3SgQ0Nlkouw/9P8RVsbcaOWfg09h+Poie7tFY89IdOJXnqEhazpPRn3f7vAVyu921fbV4EdCE1y
 tx2kq8W9f/CfqDdR744kpmN5JIvZCfgLdABMDbNRCHGnGk/wcjjktAPQkMzzWoZhEsk52FJjBby
 aEnzMxIS8IIoWCxgfGHmniSGuRf3VpKwcZ/ZVG3P+vZW1jm5lvpZmHaFVardGgQlhgFhr1B+54+
 dMFoq7g==
X-Received: by 2002:a05:6512:33d2:b0:5bf:d072:fa3f with SMTP id
 2adb3069b0e04-5bfd957dd98mr3604984e87.54.1793664161803; 
 Mon, 02 Nov 2026 16:02:41 -0800 (PST)
Received: from toolbx ([195.65.209.112]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe072c8a5sm1878253e87.36.2026.11.02.16.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 16:02:41 -0800 (PST)
From: Andrei Krautsou <an9949an@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Andrei Krautsou <an9949an@gmail.com>
Subject: [PATCH] drm/amdgpu: enable MGCG/FGCG/PERF_CLK for GC 11.0.2
Date: Tue,  3 Nov 2026 03:01:30 +0300
Message-ID: <20261103000130.282357-1-an9949an@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 03 Nov 2026 09:36:47 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GC 11.0.2 (Navi33) never got the GFX MGCG, FGCG and PERF_CLK clock
gating flags. GC 11.0.0, 11.0.1 and 11.0.4 have all three, GC 11.0.3
has MGCG. The gfx_v11_0 code behind these flags is shared by all
GC 11 parts. Enable them for GC 11.0.2, same as for GC 11.0.0.

Without the flags the driver does not clear the override bits in
RLC_CGTT_MGCG_OVERRIDE (0x000605e7 under load), so this gating stays
off. On RX 7600S the GFX clock is limited by the GFX TDC limit
(68 A), in Linux and in Windows. With the gating off each MHz costs
more GFX current, so PMFW stops at a lower clock than in Windows.

vkpeak fp32-scalar for 300 s, median after the first 60 s, GFX
current is about 68 A (TDC limit) in all cases:

                          gfxclk    VDDGFX   GFLOPS
  current flags           2030 MHz  800 mV    8915
  + MGCG                  2261 MHz  873 mV    9921
  + MGCG, FGCG, PERF_CLK  2314 MHz  894 mV   10104
  Windows 11, AMD driver            910 mV   10157-10186

GFLOPS per MHz is the same, only the current per clock goes down.
Windows shows other clock sensors, so there I compare GFLOPS only.
With all three flags vkpeak is within 1% of Windows. MGCG gives most
of the gain, FGCG and PERF_CLK add about 2% more.

Tested on one laptop, ASUS TUF A16 FA617NS (RX 7600S, PMFW 82.97.0),
Fedora kernel 7.2.11, Mesa 26.2.5, with the same flags set by a local
debug patch. One 300 s vkpeak run for each setting and some gaming,
no amdgpu errors in dmesg. Suspend/resume and long runs are not
tested yet.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/6082
Signed-off-by: Andrei Krautsou <an9949an@gmail.com>
---
I have only this one Navi33 laptop. I could not find why these flags
were left off for GC 11.0.2. If there is a hardware reason (errata),
please tell me. If only FGCG or PERF_CLK is the problem, MGCG alone
still gives most of the gain (+11% GFLOPS), and I can send a v2 with
MGCG only.

Logs, register values and the Windows numbers are in the issue linked
above.

 drivers/gpu/drm/amd/amdgpu/soc21.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 599d47e..635f026 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -599,7 +599,10 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 		adev->cg_flags =
 			AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
 			AMD_CG_SUPPORT_ATHUB_MGCG |

base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
-- 
2.56.0

