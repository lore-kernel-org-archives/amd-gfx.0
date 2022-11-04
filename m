Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 14:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 613CB10E0BA;
	Fri,  4 Nov 2022 14:06:50 +0000 (UTC)
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Fri, 04 Nov 2022 09:34:55 UTC
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C4010E722
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:34:54 +0000 (UTC)
X-UUID: 32913851603f47d2be2b81d5d1fe5aed-20221104
X-CPASD-INFO: 0578b3f4e4614849936321507eaf5c19
 @eYVxWI9llGSRVHh9g3t_c1lkZmNiXVV_eZ-
 Bl2OTXVmVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBhXoZgUZB3f3dxWJNhlg==
X-CLOUD-ID: 0578b3f4e4614849936321507eaf5c19
X-CPASD-SUMMARY: SIP:-1, APTIP:-2.0, KEY:0.0, FROMBLOCK:1, OB:1.0, URL:-5,
 TVAL:172.
 0, ESV:0.0, ECOM:-5.0, ML:0.0, FD:0.0, CUTS:464.0, IP:-2.0, MAL:-5.0, PHF:-5.0,
 PHC:-5
 .0, SPF:4.0, EDMS:-5, IPLABEL:4480.0, FROMTO:0, AD:0, FFOB:1.0, CFOB:1.0, SPC:0,
 SIG:-
 5, AUF:1, DUF:7527, ACD:131, DCD:131, SL:0, EISP:0, AG:0, CFC:0.342, CFSR:0.25,
 UAT:0, R
 AF:0, IMG:-5.0, DFA:0, DTA:0, IBL:-2.0, ADI:-5, SBL:0, REDM:0, REIP:0, ESB:0,
 ATTNUM:0, EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 32913851603f47d2be2b81d5d1fe5aed-20221104
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 32913851603f47d2be2b81d5d1fe5aed-20221104
X-User: tanglongjun@kylinos.cn
Received: from localhost [(116.128.244.169)] by mailgw
 (envelope-from <tanglongjun@kylinos.cn>) (Generic MTA)
 with ESMTP id 946662046; Fri, 04 Nov 2022 17:29:53 +0800
From: LongJun Tang <tanglongjun@kylinos.cn>
To: alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
 harry.wentland@amd.com, aurabindo.pillai@amd.com
Subject: [PATCH v1] drm/amd/display: Have risk for memory exhaustion
Date: Fri,  4 Nov 2022 17:29:31 +0800
Message-Id: <20221104092931.20226-1-tanglongjun@kylinos.cn>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Fri, 04 Nov 2022 14:06:47 +0000
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
Cc: LongJun Tang <tanglongjun@kylinos.cn>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, lange_tang@163.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In dcn*_clock_source_create when dcn*_clk_src_construct fails allocated
clk_src needs release. A local attack could use this to cause memory
exhaustion.

Signed-off-by: LongJun Tang <tanglongjun@kylinos.cn>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 8 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 020f512e9690..9b7e786bd4a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1323,6 +1323,7 @@ static struct clock_source *dcn30_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index f04595b750ab..7c1225046544 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1288,6 +1288,7 @@ static struct clock_source *dcn301_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index b925b6ddde5a..73ae1146dad5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -458,6 +458,7 @@ static struct clock_source *dcn302_clock_source_create(struct dc_context *ctx, s
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 527d5c902878..0ea97eeec5a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -425,6 +425,7 @@ static struct clock_source *dcn303_clock_source_create(struct dc_context *ctx, s
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index fddc21a5a04c..b02aa8874efb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1625,6 +1625,7 @@ static struct clock_source *dcn31_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 58746c437554..b2ff29e5f93c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1623,6 +1623,7 @@ static struct clock_source *dcn31_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a88dd7b3d1c1..71730b6666b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -829,6 +829,7 @@ static struct clock_source *dcn32_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 61087f2385a9..d3980fc243c9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -828,6 +828,7 @@ static struct clock_source *dcn321_clock_source_create(
 		return &clk_src->base;
 	}
 
+	kfree(clk_src);
 	BREAK_TO_DEBUGGER();
 	return NULL;
 }
-- 
2.17.1


No virus found
		Checked by Hillstone Network AntiVirus
