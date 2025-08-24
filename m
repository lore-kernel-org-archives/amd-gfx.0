Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC82CA0EED
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Aug 2025 23:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99F610E29D;
	Sun, 24 Aug 2025 23:32:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Ol6dZ/th";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C0710E29D
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Aug 2025 23:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EIJNbOg39sJJ86zt0lJEL0OPFvCkRz2zGqP860xuw3g=; b=Ol6dZ/thFWttWVffOFv7umy5Si
 wZK2aTdb0anqSiRnxpiDWosfk6tU6K+SfMJ9mA38rilU3aorB/kHJfiz9UNwu5/KZ/BoNAgOTjEkb
 NIhCmTYAalUWISdkuV3gXLFCyHZNabfuAu8kjl7/ULtKFEJG3w7qR8HpUJbCEVol/2DxJxKjkHRzM
 wQ+rH8LWymQUohGVjHv02RvjYwcNBmfPxZ9qpJTqzudssAFd7817v8TcdcX3P/8cmm+gxPrxtYCzx
 Ay0NVbbSsCKLMDdnoDPb1Qwvma5sVpi3NS1+Zkoho7XQfJQtKmJF6NrThdimu1iwVNcNdsw0u/Pta
 lD4nSn/w==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uqKCi-00198j-Fn; Mon, 25 Aug 2025 01:32:53 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 4/5] Documentation/gpu: Add more information about GC
Date: Sun, 24 Aug 2025 17:29:44 -0600
Message-ID: <20250824233149.3780127-5-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250824233149.3780127-1-siqueira@igalia.com>
References: <20250824233149.3780127-1-siqueira@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This commit introduces a diagram and a set of information that details
the different sets of schedulers available in the SE.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/gc/cu.svg    | 437 ++++++++++++++++++++++++++
 Documentation/gpu/amdgpu/gc/index.rst |  32 +-
 2 files changed, 463 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/gpu/amdgpu/gc/cu.svg

diff --git a/Documentation/gpu/amdgpu/gc/cu.svg b/Documentation/gpu/amdgpu/gc/cu.svg
new file mode 100644
index 000000000000..10bdb3e24b65
--- /dev/null
+++ b/Documentation/gpu/amdgpu/gc/cu.svg
@@ -0,0 +1,437 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="411.03354mm"
+   height="213.48447mm"
+   viewBox="0 0 411.03354 213.48447"
+   version="1.1"
+   id="svg1"
+   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
+   sodipodi:docname="cu.svg"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <sodipodi:namedview
+     id="namedview1"
+     pagecolor="#ffffff"
+     bordercolor="#000000"
+     borderopacity="0.25"
+     inkscape:showpageshadow="2"
+     inkscape:pageopacity="0.0"
+     inkscape:pagecheckerboard="0"
+     inkscape:deskcolor="#d1d1d1"
+     inkscape:document-units="mm"
+     inkscape:zoom="1"
+     inkscape:cx="606.5"
+     inkscape:cy="161.5"
+     inkscape:window-width="3072"
+     inkscape:window-height="1651"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="layer1"
+     showguides="false" />
+  <defs
+     id="defs1">
+    <symbol
+       id="AigaSymbols.svg:RightArrow">
+      <title
+         id="title272">Right Arrow</title>
+      <path
+         d="M 63,36 41,58 H 26 L 42,42 H 10 V 30 H 42 L 26,14 h 15 z"
+         style="stroke:none"
+         id="path272" />
+    </symbol>
+  </defs>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(-21.831087,-67.399327)">
+    <rect
+       style="fill:#ffffff;stroke-width:1;stroke-dasharray:1, 1"
+       id="rect2"
+       width="413.01459"
+       height="215.10625"
+       x="21.037336"
+       y="67.39933"
+       ry="0" />
+    <rect
+       style="fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke-dasharray:none"
+       id="rect1"
+       width="171.65263"
+       height="98.433296"
+       x="22.326748"
+       y="80.365692" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:'Linux Libertine O';-inkscape-font-specification:'Linux Libertine O';text-align:start;letter-spacing:4.91331px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#00d400;stroke:#00d400;stroke-width:1;stroke-dasharray:none"
+       x="45.418606"
+       y="231.96919"
+       id="text12"><tspan
+         sodipodi:role="line"
+         id="tspan12"
+         style="stroke-width:1"
+         x="45.418606"
+         y="231.96919" /></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="220.24004"
+       y="72.225327"
+       id="text14-7"><tspan
+         sodipodi:role="line"
+         x="220.24004"
+         y="72.225327"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan14-7">Dual Compute Unite (CU)</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="88.634293"
+       y="100.9926"
+       id="text14-7-5"><tspan
+         sodipodi:role="line"
+         x="88.634293"
+         y="100.9926"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan21">Schedulers</tspan></text>
+    <rect
+       style="fill:none;stroke:#aa0000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect20"
+       width="165.53069"
+       height="21.603296"
+       x="26.396732"
+       y="87.214386" />
+    <rect
+       style="fill:none;stroke:#008000;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect32"
+       width="72.816223"
+       height="59.460701"
+       x="119.51908"
+       y="111.4128" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="155.79736"
+       y="119.94101"
+       id="text32"><tspan
+         sodipodi:role="line"
+         x="155.79736"
+         y="119.94101"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan32">SGPR</tspan></text>
+    <rect
+       style="fill:none;stroke:#00ccff;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect33"
+       width="72.123314"
+       height="12.543721"
+       x="34.27282"
+       y="126.84049" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="70.584946"
+       y="135.25613"
+       id="text33"><tspan
+         sodipodi:role="line"
+         x="70.584946"
+         y="135.25613"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan33">Float ALU</tspan></text>
+    <rect
+       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect34"
+       width="72.123314"
+       height="12.543721"
+       x="34.27282"
+       y="141.15512" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="70.584946"
+       y="149.54356"
+       id="text34"><tspan
+         sodipodi:role="line"
+         x="70.584946"
+         y="149.54356"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan34">Integer ALU</tspan></text>
+    <rect
+       style="fill:none;stroke:#536c53;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect35"
+       width="72.123314"
+       height="12.543721"
+       x="34.27282"
+       y="155.4696" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="70.711952"
+       y="163.18179"
+       id="text35"><tspan
+         sodipodi:role="line"
+         x="70.711952"
+         y="163.18179"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan35">Accelerators (e.g., AI)</tspan></text>
+    <rect
+       style="fill:none;stroke:#aaffcc;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect36"
+       width="87.45388"
+       height="60.884953"
+       x="26.806004"
+       y="110.89911" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="70.532944"
+       y="119.94102"
+       id="text36"><tspan
+         sodipodi:role="line"
+         x="70.532944"
+         y="119.94102"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan36">VGPR</tspan></text>
+    <rect
+       style="fill:none;stroke:#00ccff;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect37"
+       width="52.815948"
+       height="12.68323"
+       x="130.37912"
+       y="126.77074" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="156.77298"
+       y="135.22902"
+       id="text37"><tspan
+         sodipodi:role="line"
+         x="156.77298"
+         y="135.22902"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan38">Scalar Unit</tspan></text>
+    <rect
+       style="fill:#ffffff;stroke:#8080ff;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect39"
+       width="23.488506"
+       height="199.71252"
+       x="196.07666"
+       y="80.442635" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="207.6935"
+       y="178.88779"
+       id="text39"><tspan
+         sodipodi:role="line"
+         x="207.6935"
+         y="178.88779"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan39">Scalar</tspan><tspan
+         sodipodi:role="line"
+         x="207.6935"
+         y="185.94334"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan40">Cache</tspan></text>
+    <rect
+       style="fill:#ffffff;stroke:#8080ff;stroke-width:1;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect40"
+       width="36.175877"
+       height="199.38167"
+       x="222.0493"
+       y="80.60807" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="240.29651"
+       y="175.36002"
+       id="text42"><tspan
+         sodipodi:role="line"
+         x="240.29651"
+         y="175.36002"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan42">Shader</tspan><tspan
+         sodipodi:role="line"
+         x="240.29651"
+         y="182.41557"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan43">Instruction</tspan><tspan
+         sodipodi:role="line"
+         x="240.29651"
+         y="189.47112"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan44">Cache</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="117.62655"
+       y="86.0942"
+       id="text46"><tspan
+         sodipodi:role="line"
+         x="117.62655"
+         y="86.0942"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan46">Block #1</tspan></text>
+    <rect
+       style="fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke-dasharray:none"
+       id="rect46"
+       width="171.65263"
+       height="98.433296"
+       x="22.326748"
+       y="181.95483" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="117.62655"
+       y="192.60635"
+       id="text47"><tspan
+         sodipodi:role="line"
+         x="117.62655"
+         y="192.60635"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan47">Block #2</tspan></text>
+    <rect
+       style="fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke-dasharray:none"
+       id="rect47"
+       width="171.65263"
+       height="98.433296"
+       x="260.71634"
+       y="80.884003" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="356.01614"
+       y="91.535522"
+       id="text48"><tspan
+         sodipodi:role="line"
+         x="356.01614"
+         y="91.535522"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan48">Block #3</tspan></text>
+    <rect
+       style="fill:#ffffff;stroke:#000000;stroke-width:0.991321;stroke-dasharray:none"
+       id="rect48"
+       width="171.65263"
+       height="98.433296"
+       x="260.71634"
+       y="181.16109" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="356.01614"
+       y="191.81261"
+       id="text49"><tspan
+         sodipodi:role="line"
+         x="356.01614"
+         y="191.81261"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan49">Block #4</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-size:5.64444px;font-family:'Linux Libertine O';-inkscape-font-specification:'Linux Libertine O';text-align:start;letter-spacing:4.91331px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#8080ff;stroke-width:1"
+       x="178.00336"
+       y="42.984257"
+       id="text5"><tspan
+         sodipodi:role="line"
+         id="tspan5"
+         style="stroke-width:1" /></text>
+    <g
+       id="g8"
+       transform="translate(-14.022917,61.780208)">
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="127.87695"
+         y="38.251671"
+         id="text1"><tspan
+           sodipodi:role="line"
+           x="127.87695"
+           y="38.251671"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan1">CP</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#0000ff;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="151.68944"
+         y="34.369583"
+         id="text2"><tspan
+           sodipodi:role="line"
+           x="151.68944"
+           y="34.369583"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#0000ff;stroke-width:0.0690111"
+           id="tspan2">CPC</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#008000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="151.68944"
+         y="41.990528"
+         id="text3"><tspan
+           sodipodi:role="line"
+           x="151.68944"
+           y="41.990528"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#008000;stroke-width:0.0690111"
+           id="tspan3">CPG</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="169.2464"
+         y="37.757202"
+         id="text4"><tspan
+           sodipodi:role="line"
+           x="169.2464"
+           y="37.757202"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.0690111"
+           id="tspan4">CPF</tspan></text>
+      <use
+         xlink:href="#AigaSymbols.svg:RightArrow"
+         style="fill:#000000;stroke:#000000"
+         id="use1"
+         transform="matrix(0.11481918,0,0,0.11481918,134.58602,32.103116)" />
+      <rect
+         style="fill:none;stroke:#8080ff;stroke-width:0.5;stroke-dasharray:none"
+         id="rect5"
+         width="33.919868"
+         height="16.754484"
+         x="142.33916"
+         y="27.961687" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:11.2889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="161.22551"
+         y="39.187115"
+         id="text6"><tspan
+           sodipodi:role="line"
+           x="161.22551"
+           y="39.187115"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan6">}</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:22.5778px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="123.70975"
+         y="42.513233"
+         id="text7"><tspan
+           sodipodi:role="line"
+           x="123.70975"
+           y="42.513233"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:22.5778px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan7">(</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:22.5778px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="-180.12157"
+         y="42.513233"
+         id="text8"
+         transform="scale(-1,1)"><tspan
+           sodipodi:role="line"
+           x="-180.12157"
+           y="42.513233"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:22.5778px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan8">(</tspan></text>
+    </g>
+  </g>
+</svg>
diff --git a/Documentation/gpu/amdgpu/gc/index.rst b/Documentation/gpu/amdgpu/gc/index.rst
index ff6e9ef5cbee..19f2ba53ee49 100644
--- a/Documentation/gpu/amdgpu/gc/index.rst
+++ b/Documentation/gpu/amdgpu/gc/index.rst
@@ -10,16 +10,36 @@ producer-consumer problem, where the CPU fills out a buffer with operations
 the buffer are called Command Packets, which can be summarized as a compressed
 way of transmitting command information to the graphics controller.
 
+In the diagram below, you can see an overview of the GC, along with additional
+information about the Shader Engine (SE).
+
+.. kernel-figure:: cu.svg
+
+First of all, note that the GC can have multiple SEs, depending on the specific
+GPU/APU, and each SE has multiple Compute Units (CU). From the diagram, you can
+see that CUs have a block named Schedulers. The reason the name is in plural is
+because this hardware block is a combination of different micro-schedules: CP,
+CPF, CPC, and CPG.
+
 The component that acts as the front end between the CPU and the GPU is called
-the Command Processor (CP). This component is responsible for providing greater
+CP (Command Processor). This component is responsible for providing greater
 flexibility to the GC since CP makes it possible to program various aspects of
 the GPU pipeline. CP also coordinates the communication between the CPU and GPU
 via a mechanism named **Ring Buffers**, where the CPU appends information to
-the buffer while the GPU removes operations. It is relevant to highlight that a
-CPU can add a pointer to the Ring Buffer that points to another region of
-memory outside the Ring Buffer, and CP can handle it; this mechanism is called
-**Indirect Buffer (IB)**. CP receives and parses the Command Streams (CS), and
-writes the operations to the correct hardware blocks.
+the buffer while the GPU removes operations. Finally, CP is also responsible
+for handling Indirect Buffers (IB).
+
+After CP completes the first set of processing, which includes separate command
+packets specific to GFX and Compute, other blocks step in. To handle commands
+for the compute block, CPC (Command Processor Command) takes over, and for
+handling Graphics operations, the CPG (Command Processor Graphics) takes
+action. Another essential block to ensure the optimal utilization of CPC and
+CPG is the CPF (Command Processor Fetcher), which helps these blocks to be
+constantly fed. Note that CPG contains the PFP (Pre-Fetch Parser), ME
+(MicroEngine), and CE (Constant Engine) in the case of chips that support it.
+CPC contains MEC (MicroEngine Compute), and CPF is another hardware block that
+provides services to CPG and CPC.
+
 
 Graphics (GFX) and Compute Microcontrollers
 -------------------------------------------
-- 
2.47.2

