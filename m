Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B05CA0EEC
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 15:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210DC10E38B;
	Sat, 16 Aug 2025 15:34:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="N65VpVGB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E1FD10E38B
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 15:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Gz3nELolak9hVPfB+w3bu/M5eLqunICK5lRzgNqBxF4=; b=N65VpVGB6Azewhxr8Gx5G1Krrp
 qcHZ1bO9jxiBG5My474sz53ZdDWZg28khaEpGoKXk/jHpFilpqdYPUwsJrNPIKdoD+JRCl+B87u0O
 8Y8FDnPJK6S+8zSxhlhHy81o54s3gpxQjvdZ3/isuAYWM8ZiOR2IUAl1eJbrd7yQJ6y1a20nHo3k/
 3cuwX85y12+qzfCFWpnpKM6/PzOJaKWqciH1z7aG178d2MPtlCSfFlxUAfyAz7d2hm2msPX/Cx5zU
 ETRMFXGQdrNVrpzb1yPnsKXhSjbGl+axq+uF3ctCrLQGtyE1KLvrpTJYrIVuuLotN1OmHYtZ1Nmve
 SNyjUV/g==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1unIv0-00F9aY-B1; Sat, 16 Aug 2025 17:34:06 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 3/5] Documentation/gpu: Expand generic block information
Date: Sat, 16 Aug 2025 09:31:40 -0600
Message-ID: <20250816153315.1285182-4-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816153315.1285182-1-siqueira@igalia.com>
References: <20250816153315.1285182-1-siqueira@igalia.com>
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

This commit expands the overall explanation about AMD GPU IPs by adding
more details about their interconnection. Note that this commit includes
a diagram that provides additional information.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../gpu/amdgpu/amd_overview_block.svg         | 674 ++++++++++++++++++
 Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
 Documentation/gpu/amdgpu/driver-core.rst      |  25 +
 3 files changed, 702 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/amd_overview_block.svg

diff --git a/Documentation/gpu/amdgpu/amd_overview_block.svg b/Documentation/gpu/amdgpu/amd_overview_block.svg
new file mode 100644
index 000000000000..8d9ae95bd9a5
--- /dev/null
+++ b/Documentation/gpu/amdgpu/amd_overview_block.svg
@@ -0,0 +1,674 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="237.4014mm"
+   height="160.98259mm"
+   viewBox="0 0 237.4014 160.98259"
+   version="1.1"
+   id="svg1"
+   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
+   sodipodi:docname="amd_overview_block.svg"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
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
+     inkscape:zoom="2"
+     inkscape:cx="436.25"
+     inkscape:cy="313.75"
+     inkscape:window-width="3072"
+     inkscape:window-height="1651"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="layer1" />
+  <defs
+     id="defs1">
+    <marker
+       style="overflow:visible"
+       id="ArrowWideHeavy"
+       refX="0"
+       refY="0"
+       orient="auto-start-reverse"
+       inkscape:stockid="Wide, heavy arrow"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="m 1,0 -3,3 h -2 l 3,-3 -3,-3 h 2 z"
+         id="path3" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="ArrowWideRounded"
+       refX="0"
+       refY="0"
+       orient="auto-start-reverse"
+       inkscape:stockid="Wide, rounded arrow"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         style="fill:none;stroke:context-stroke;stroke-width:1;stroke-linecap:round"
+         d="M 3,-3 0,0 3,3"
+         transform="rotate(180,0.125,0)"
+         sodipodi:nodetypes="ccc"
+         id="path2" />
+    </marker>
+  </defs>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(9.9255824,-64.69615)">
+    <rect
+       style="fill:#ffffff;stroke:none;stroke-width:0.999747"
+       id="rect5"
+       width="239.13895"
+       height="162.38739"
+       x="-10.311751"
+       y="63.871342" />
+    <rect
+       style="fill:#ffffff;stroke:#000000;stroke-width:0.79375"
+       id="rect1"
+       width="174.55814"
+       height="140.23256"
+       x="22.263056"
+       y="65.093025" />
+    <rect
+       style="fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dasharray:none"
+       id="rect2"
+       width="5.0232558"
+       height="104.23256"
+       x="28.674419"
+       y="72.418602" />
+    <rect
+       style="fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dasharray:none"
+       id="rect3"
+       width="5.0232558"
+       height="104.23256"
+       x="185.44186"
+       y="72.418602" />
+    <rect
+       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
+       id="rect8-5"
+       width="3.8659263"
+       height="4.2845292"
+       x="48.522045"
+       y="75.819946" />
+    <rect
+       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
+       id="rect9"
+       width="3.8659263"
+       height="4.2845292"
+       x="168.14684"
+       y="75.68573" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.9389px;font-family:'Linux Libertine O';-inkscape-font-specification:'Linux Libertine O';text-align:start;letter-spacing:4.91331px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:#00d400;stroke:#00d400;stroke-width:1;stroke-dasharray:none"
+       x="45.418606"
+       y="216.62791"
+       id="text12"><tspan
+         sodipodi:role="line"
+         id="tspan12"
+         style="stroke-width:1"
+         x="45.418606"
+         y="216.62791" /></text>
+    <g
+       id="g34">
+      <rect
+         style="fill:#ffffff;stroke:#008033;stroke-width:1;stroke-dasharray:none"
+         id="rect7"
+         width="19.539951"
+         height="6.9818101"
+         x="22.811832"
+         y="210.3201" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="52.663685"
+         y="216.07796"
+         id="text68"><tspan
+           sodipodi:role="line"
+           x="52.663685"
+           y="216.07796"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#008033;stroke-width:0.0690111"
+           id="tspan68">UMC</tspan></text>
+    </g>
+    <g
+       id="g29"
+       transform="translate(-0.52916667)">
+      <rect
+         style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
+         id="rect8"
+         width="3.8659263"
+         height="4.2845292"
+         x="22.782616"
+         y="220.36148" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="48.966854"
+         y="224.15474"
+         id="text13"><tspan
+           sodipodi:role="line"
+           x="48.966854"
+           y="224.15474"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ff00;stroke-width:0.0690111"
+           id="tspan13">Memory hub</tspan></text>
+    </g>
+    <rect
+       style="fill:#ffffff;stroke:#0000ff;stroke-width:1;stroke-dasharray:none"
+       id="rect13"
+       width="28.674419"
+       height="11.302325"
+       x="43.988369"
+       y="192.98618" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="58.325581"
+       y="200.90428"
+       id="text14"><tspan
+         sodipodi:role="line"
+         x="58.325581"
+         y="200.90428"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan14">DCN</tspan></text>
+    <g
+       id="g12"
+       transform="translate(-1.8520837,2.3812496)">
+      <g
+         id="g13">
+        <rect
+           style="fill:#ffffff;stroke:#ffd42a;stroke-width:1;stroke-dasharray:none"
+           id="rect15"
+           width="28.674419"
+           height="11.302325"
+           x="114.87544"
+           y="169.54433"
+           ry="2.6458333" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+           x="129.06978"
+           y="177.46243"
+           id="text15"><tspan
+             sodipodi:role="line"
+             x="129.06978"
+             y="177.46243"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+             id="tspan15">PSP</tspan></text>
+      </g>
+    </g>
+    <path
+       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
+       d="m 73.88372,201.92338 h 43.74419 V 184.5631"
+       id="path16"
+       sodipodi:nodetypes="ccc" />
+    <rect
+       style="fill:#ffffff;stroke:#00ccff;stroke-width:1;stroke-dasharray:none"
+       id="rect16"
+       width="40.220226"
+       height="11.1272"
+       x="150.82011"
+       y="193.07373" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="170.78101"
+       y="200.90428"
+       id="text16"><tspan
+         sodipodi:role="line"
+         x="170.78101"
+         y="200.90428"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan16">PCIe (NBIO)</tspan></text>
+    <g
+       id="g11"
+       transform="translate(-5.0270833,-8.8635417)">
+      <rect
+         style="fill:#ffffff;stroke:#5f5fd3;stroke-width:1;stroke-dasharray:none"
+         id="rect19"
+         width="28.674419"
+         height="11.302325"
+         x="146.1279"
+         y="132.70711" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="160.75085"
+         y="140.62521"
+         id="text19"><tspan
+           sodipodi:role="line"
+           x="160.75085"
+           y="140.62521"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan19">VCN</tspan></text>
+    </g>
+    <g
+       id="g5"
+       transform="translate(0,5.8208336)">
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="110.18288"
+         y="73.872185"
+         id="text14-7"><tspan
+           sodipodi:role="line"
+           x="110.18288"
+           y="73.872185"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan14-7">Graphics &amp; Compute (GC)</tspan></text>
+      <g
+         id="g4"
+         transform="translate(10.583333)">
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+           x="58.022533"
+           y="83.518799"
+           id="text14-7-5"><tspan
+             sodipodi:role="line"
+             x="58.022533"
+             y="83.518799"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+             id="tspan14-7-6">Shader</tspan><tspan
+             sodipodi:role="line"
+             x="58.022533"
+             y="90.574348"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+             id="tspan20">Engine(SE)</tspan><tspan
+             sodipodi:role="line"
+             x="58.022533"
+             y="97.629898"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+             id="tspan21">#1</tspan></text>
+        <rect
+           style="fill:none;stroke:#aa0000;stroke-width:1.01356;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect20"
+           width="31.954243"
+           height="22.038303"
+           x="42.18652"
+           y="77.410309" />
+      </g>
+      <g
+         id="g3"
+         transform="translate(14.287499,-0.66146851)">
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+           x="97.020706"
+           y="91.105995"
+           id="text24"><tspan
+             sodipodi:role="line"
+             x="97.020706"
+             y="91.105995"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+             id="tspan24">SE #2</tspan></text>
+        <rect
+           style="fill:none;stroke:#aa0000;stroke-width:1.01356;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect24"
+           width="31.954243"
+           height="22.038303"
+           x="81.080269"
+           y="78.071777" />
+      </g>
+      <g
+         id="g2"
+         transform="translate(-3.96875)">
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:5.64444px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+           x="158.03574"
+           y="90.444527"
+           id="text30"><tspan
+             sodipodi:role="line"
+             x="158.03574"
+             y="90.444527"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:5.64444px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+             id="tspan30">SE #N</tspan></text>
+        <rect
+           style="fill:none;stroke:#aa0000;stroke-width:1.01356;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect30"
+           width="31.954243"
+           height="22.038303"
+           x="141.93443"
+           y="77.410309" />
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="132.011"
+         y="88.873962"
+         id="text4"><tspan
+           sodipodi:role="line"
+           x="132.011"
+           y="88.873962"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan4">...</tspan></text>
+      <rect
+         style="fill:none;stroke:#ff8080;stroke-width:1;stroke-dasharray:none"
+         id="rect4"
+         width="126.7475"
+         height="35.863121"
+         x="46.912045"
+         y="68.129692" />
+    </g>
+    <g
+       id="g10"
+       transform="translate(-8.807217,1.0583333)">
+      <rect
+         style="fill:#ffffff;stroke:#ff6600;stroke-width:1;stroke-dasharray:none"
+         id="rect10"
+         width="50.551014"
+         height="10.992874"
+         x="65.641136"
+         y="122.93423" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="91.040474"
+         y="130.69762"
+         id="text10"><tspan
+           sodipodi:role="line"
+           x="91.040474"
+           y="130.69762"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan10">SMU</tspan></text>
+    </g>
+    <rect
+       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
+       id="rect14"
+       width="3.8659263"
+       height="4.2845292"
+       x="164.57497"
+       y="125.16281" />
+    <rect
+       style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
+       id="rect18"
+       width="3.8659263"
+       height="4.2845292"
+       x="67.340591"
+       y="194.48364" />
+    <g
+       id="g25"
+       transform="translate(165.76146,89.164578)">
+      <g
+         id="g17"
+         transform="translate(-127.72192,-84.269792)">
+        <rect
+           style="fill:#ffffff;stroke:#ff00ff;stroke-width:1;stroke-dasharray:none"
+           id="rect17"
+           width="50.551014"
+           height="10.992874"
+           x="83.42868"
+           y="140.39673" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+           x="108.55814"
+           y="148.16011"
+           id="text17"><tspan
+             sodipodi:role="line"
+             x="108.55814"
+             y="148.16011"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+             id="tspan17">SDMA</tspan></text>
+      </g>
+      <g
+         id="g24">
+        <rect
+           style="fill:#00d400;stroke:#00d400;stroke-width:0.348444;stroke-dasharray:none"
+           id="rect21"
+           width="3.8659263"
+           height="4.2845292"
+           x="0.79788309"
+           y="57.429478" />
+      </g>
+    </g>
+    <path
+       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0;marker-end:url(#ArrowWideRounded)"
+       d="M 56.046208,126.07948 H 51.151416 V 110.60136"
+       id="path21"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1,1;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 107.63996,129.38677 h 31.91723"
+       id="path22" />
+    <g
+       id="g26"
+       transform="translate(103.05521,-16.801041)">
+      <path
+         style="fill:none;stroke:#ff6600;stroke-width:0.684499;stroke-dasharray:0.684499, 0.684499;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="M 14.374335,237.26538 H 29.87027"
+         id="path23" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff6600;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="41.690811"
+         y="239.50058"
+         id="text23"><tspan
+           sodipodi:role="line"
+           x="41.690811"
+           y="239.50058"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff6600;stroke-width:0.0690111"
+           id="tspan23">Reset</tspan></text>
+    </g>
+    <path
+       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0;marker-end:url(#ArrowWideRounded)"
+       d="m 56.046208,133.69217 h -4.894792 v 58.07604"
+       id="path24"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#ff6600;stroke-width:1;stroke-dasharray:1,1;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 95.977781,134.7651 v 15.92063 l 23.944789,0.007"
+       id="path25"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
+       d="m 116.34935,212.1162 h 16.22753"
+       id="path26"
+       sodipodi:nodetypes="cc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff6600;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="159.95955"
+       y="214.49745"
+       id="text26"><tspan
+         sodipodi:role="line"
+         x="159.95955"
+         y="214.49745"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ffd42a;stroke-width:0.0690111"
+         id="tspan26">PSP Interaction</tspan></text>
+    <path
+       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
+       d="m 142.93997,177.05254 12.78794,1e-5 v -20.13841"
+       id="path27"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
+       d="m 154.31705,177.05254 24.03273,1e-5 v -47.79807 h -6.87917"
+       id="path28"
+       sodipodi:nodetypes="cccc" />
+    <rect
+       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
+       id="rect31"
+       width="28.449656"
+       height="23.148542"
+       x="-9.3648224"
+       y="152.25124" />
+    <rect
+       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
+       id="rect32"
+       width="28.449656"
+       height="23.148542"
+       x="-9.3648224"
+       y="71.817902" />
+    <rect
+       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
+       id="rect33"
+       width="28.449656"
+       height="23.148542"
+       x="198.46539"
+       y="152.25124" />
+    <rect
+       style="fill:#008033;stroke:#008033;stroke-width:1.12152;stroke-dasharray:none"
+       id="rect34"
+       width="28.449656"
+       height="23.148542"
+       x="198.46539"
+       y="71.817902" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.93889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="-124.65836"
+       y="32.94923"
+       id="text34"
+       transform="rotate(-90)"><tspan
+         sodipodi:role="line"
+         x="-124.65836"
+         y="32.94923"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#008033;stroke-width:0.0690111"
+         id="tspan34">UMC</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.93889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#008033;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="-124.65836"
+       y="189.71486"
+       id="text35"
+       transform="rotate(-90)"><tspan
+         sodipodi:role="line"
+         x="-124.65836"
+         y="189.71486"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.93889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#008033;stroke-width:0.0690111"
+         id="tspan35">UMC</tspan></text>
+    <path
+       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
+       d="M 69.069766,195.36981 V 166.59317 H 34.403946"
+       id="path35"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
+       d="M 69.167488,195.36981 V 166.59317 H 184.79581"
+       id="path36"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
+       d="m 33.58103,118.30671 h 141.39539 v 30.03021"
+       id="path37"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
+       d="m 166.53415,126.77338 h 19.0256"
+       id="path38"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
+       d="m 166.53415,148.99838 h 19.0256"
+       id="path39"
+       sodipodi:nodetypes="cc" />
+    <g
+       id="g40"
+       transform="translate(0,-1.8520833)">
+      <circle
+         style="fill:#ff8080;stroke:#ff2a2a;stroke-width:0.7;stroke-dasharray:none;stroke-dashoffset:0"
+         id="path40"
+         cx="7.2723336"
+         cy="194.07741"
+         r="10.186459" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:4.23333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+         x="7.1728497"
+         y="195.6649"
+         id="text40"><tspan
+           sodipodi:role="line"
+           x="7.1728492"
+           y="195.6649"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+           id="tspan40">Firmware</tspan></text>
+    </g>
+    <path
+       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
+       d="m 34.063928,174.00984 78.801482,0.26458"
+       id="path41"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#ffd42a;stroke-width:1;stroke-dasharray:8, 1;stroke-dashoffset:0"
+       d="M 8.1347613,181.0213 27.537285,174.27442"
+       id="path42"
+       sodipodi:nodetypes="cc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="4.5742564"
+       y="84.897125"
+       id="text42"><tspan
+         sodipodi:role="line"
+         x="4.5742559"
+         y="84.897125"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan42">Memory</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="4.5742564"
+       y="165.33046"
+       id="text43"><tspan
+         sodipodi:role="line"
+         x="4.5742559"
+         y="165.33046"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan43">Memory</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="212.40446"
+       y="165.33046"
+       id="text44"><tspan
+         sodipodi:role="line"
+         x="212.40446"
+         y="165.33046"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan44">Memory</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.0690111"
+       x="212.40446"
+       y="84.897125"
+       id="text45"><tspan
+         sodipodi:role="line"
+         x="212.40446"
+         y="84.897125"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.0690111"
+         id="tspan45">Memory</tspan></text>
+    <path
+       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
+       d="m 171.56123,77.957755 13.99852,0"
+       id="path45"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#00d455;stroke-width:1;stroke-dasharray:1, 1;stroke-dashoffset:0"
+       d="m 34.639355,77.957755 h 13.99852"
+       id="path46"
+       sodipodi:nodetypes="cc" />
+  </g>
+</svg>
diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index eb72e6f6d4f1..a3f9565d655b 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -227,6 +227,9 @@ we have a dedicated glossary for Display Core at
     TOC
       Table of Contents
 
+    UMC
+      Unified Memory Controller
+
     UMSCH
       User Mode Scheduler
 
diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
index 81256318e93c..f47199c04d8f 100644
--- a/Documentation/gpu/amdgpu/driver-core.rst
+++ b/Documentation/gpu/amdgpu/driver-core.rst
@@ -77,6 +77,31 @@ VCN (Video Core Next)
     decode.  It's exposed to userspace for user mode drivers (VA-API,
     OpenMAX, etc.)
 
+It is important to note that these blocks can interact with each other. The
+picture below illustrates some of the components and their interconnection:
+
+.. kernel-figure:: amd_overview_block.svg
+
+In the diagram, memory-related blocks are represented by a green color. Notice
+that specific IPs have a green block that represents a small hardware block
+named 'hub', which is responsible for interfacing with memory (pre-vega devices
+have a dedicated block for that, named GMC). In the driver code, you can
+identify this component by looking for the suffix hub, for example: gfxhub,
+dchub, mmhub, vmhub, etc. All memory hubs are connected in the UMC, which in
+turn is connected to memory blocks.
+
+There is some level of protection for certain elements in memory, and the PSP
+plays an essential role in this area. For example, when a specific firmware is
+loaded into the memory, PSP takes an action to ensure that the firmware has a
+valid signature. Another use of PSP is to support the TA (e.g., HDCP) and
+encrypted memory via TMZ.
+
+Another IP that deserves attention is the SMU, as it is connected to all the
+other IPs. SMU will help put the GPU in optimal utilization by taking into
+account performance and power consumption. SMU helps other blocks to set up a
+proper clock configuration. Another feature of SMU is the support for resetting
+every component.
+
 .. _pipes-and-queues-description:
 
 GFX, Compute, and SDMA Overall Behavior
-- 
2.47.2

