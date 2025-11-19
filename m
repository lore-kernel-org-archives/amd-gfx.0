Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFB3CF2561
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 00:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 075A710E544;
	Wed, 19 Nov 2025 00:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BghQjZf3";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D106510E544
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 00:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x3gZcoy6f4l9YpCprFq9QsH7vxPgTZ9tBP0cohK9AX8=; b=BghQjZf3kAWN/WPOtbQwvG81e7
 OMho/O9TW1yNPmzaF53L7mqnSI8D0Yl6ipX0SRSgs0yvRkOQDvn38+Avi2nv2BehGRIsCRHfFTVPa
 DJxJgBeM8IuH0fmncyVnv2f94//rTCybA1ljK5tNjTmTqdS9O/5EbOudH+hp/QWgJskYmY9lOwGOr
 bedTaDZgBWyFiIxpsT689EgF7Cmt4V18fOrwrcDr478HHWqJtw+WKv9G+jce1+X3Yt7iV+Vpqmvyo
 iXRjgQaHiyCGkbEPhAvkGB886WTdK+xE3ClNLK7KGYGlEtCM/V82c21xwi+VstZtKhvYBCRwjAh8e
 K5c8LHCw==;
Received: from [104.193.135.201] (helo=debian.home.app)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vLWNR-002Mxr-Jm; Wed, 19 Nov 2025 01:48:53 +0100
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v5 5/5] Documentation/gpu: Add documentation about ring buffer
Date: Tue, 18 Nov 2025 17:45:54 -0700
Message-ID: <20251119004818.4126460-6-siqueira@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251119004818.4126460-1-siqueira@igalia.com>
References: <20251119004818.4126460-1-siqueira@igalia.com>
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

AMDGPU heavily relies on ring buffers to manage its components; as a
result, it has an elaborate mechanism of operation with multiple details
around it. This commit introduces new documentation on ring buffers,
detailing their management and expanding the explanation of Enforce
isolation. Finally, this commit also adds the documentation available in
the amdgpu_ring.c file to it.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../gpu/amdgpu/enforce_isolation.svg          |  654 +++++++
 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg |  413 +++++
 Documentation/gpu/amdgpu/index.rst            |    1 +
 .../gpu/amdgpu/no_enforce_isolation.svg       |  707 +++++++
 .../gpu/amdgpu/process-isolation.rst          |    1 +
 Documentation/gpu/amdgpu/ring-buffer.rst      |   95 +
 Documentation/gpu/amdgpu/ring_buffers.svg     | 1633 +++++++++++++++++
 Documentation/gpu/amdgpu/userq.rst            |    2 +
 8 files changed, 3506 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/enforce_isolation.svg
 create mode 100644 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
 create mode 100644 Documentation/gpu/amdgpu/no_enforce_isolation.svg
 create mode 100644 Documentation/gpu/amdgpu/ring-buffer.rst
 create mode 100644 Documentation/gpu/amdgpu/ring_buffers.svg

diff --git a/Documentation/gpu/amdgpu/enforce_isolation.svg b/Documentation/gpu/amdgpu/enforce_isolation.svg
new file mode 100644
index 000000000000..2630681f1cb9
--- /dev/null
+++ b/Documentation/gpu/amdgpu/enforce_isolation.svg
@@ -0,0 +1,654 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="67.794067mm"
+   height="88.643349mm"
+   viewBox="0 0 67.794066 88.643348"
+   version="1.1"
+   id="svg1"
+   inkscape:version="1.4.2 (ebf0e940d0, 2025-05-08)"
+   sodipodi:docname="enforce_isolation.svg"
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
+     inkscape:zoom="3.5754724"
+     inkscape:cx="200.95247"
+     inkscape:cy="182.77305"
+     inkscape:window-width="3840"
+     inkscape:window-height="2083"
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
+       id="Dot"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Dot"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.5)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
+         sodipodi:nodetypes="sssss"
+         id="path98" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="marker99"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Dot"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.5)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
+         sodipodi:nodetypes="sssss"
+         id="path99" />
+    </marker>
+  </defs>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(71.49059,-1.1271925)">
+    <g
+       id="g15"
+       transform="matrix(0.42247861,0,0,0.42247861,-70.575576,-25.242317)">
+      <path
+         id="path33"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g14">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path34"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path35"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path36"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path37"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path38"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path39"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path40"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path41"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path42"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path43"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path44-1"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path45-8"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <rect
+       style="fill:#afe9c6;stroke:#16502d;stroke-width:0.257104;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+       id="rect80"
+       width="25.076588"
+       height="10.493422"
+       x="-71.362038"
+       y="79.148567"
+       ry="1.4529352" />
+    <rect
+       style="fill:#80e5ff;stroke:#00aad4;stroke-width:0.257104;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+       id="rect81"
+       width="32.714355"
+       height="10.436013"
+       x="-40.481403"
+       y="79.177269"
+       ry="1.4449863" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.53042px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-59.013123"
+       y="86.726654"
+       id="text14-7"><tspan
+         sodipodi:role="line"
+         x="-59.013123"
+         y="86.726654"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.53042px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan14-7">GFX</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.53042px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-24.387218"
+       y="85.975647"
+       id="text95"><tspan
+         sodipodi:role="line"
+         x="-24.387218"
+         y="85.975647"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.53042px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan95">Compute</tspan></text>
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M -58.079264,78.410023 V 69.962845"
+       id="path127"
+       sodipodi:nodetypes="cc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:2.90242px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-61.752651"
+       y="3.1995225"
+       id="text112"><tspan
+         sodipodi:role="line"
+         x="-61.752651"
+         y="3.1995225"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.90242px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan112">Processes</tspan></text>
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.247306;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:1.48383, 1.48383;stroke-dashoffset:0"
+       id="rect113"
+       width="64.703476"
+       height="19.562067"
+       x="-68.52655"
+       y="4.468956"
+       ry="1.6976216" />
+    <g
+       id="g84"
+       transform="matrix(0.25710378,0,0,0.25710378,0.68647434,8.7899633)">
+      <g
+         id="g83">
+        <circle
+           style="fill:#ffffff;stroke:#ff00ff;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+           id="circle137"
+           cx="-225.65012"
+           cy="20.747513"
+           r="30.822298" />
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="-225.65012"
+         y="26.8181"
+         id="text113"><tspan
+           sodipodi:role="line"
+           x="-225.65012"
+           y="26.8181"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.400612"
+           id="tspan113">A</tspan></text>
+    </g>
+    <g
+       id="g85"
+       transform="matrix(0.25710378,0,0,0.25710378,20.618429,8.7899633)">
+      <circle
+         style="fill:#ffffff;stroke:#ff9955;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+         id="circle112"
+         cx="-207.94376"
+         cy="20.747513"
+         r="30.822298" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="-208.25702"
+         y="26.792702"
+         id="text114"><tspan
+           sodipodi:role="line"
+           x="-208.25702"
+           y="26.792702"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+           id="tspan114">B</tspan></text>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-56.126556"
+       y="51.72607"
+       id="text6"><tspan
+         sodipodi:role="line"
+         x="-56.126556"
+         y="51.72607"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+         id="tspan6">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:2.26752px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-57.861526"
+       y="58.416431"
+       id="text136"><tspan
+         sodipodi:role="line"
+         x="-57.861526"
+         y="58.416431"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan136">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="-57.861526"
+         y="61.250832"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan137">Buffer</tspan></text>
+    <g
+       id="g80"
+       transform="matrix(0.42247861,0,0,0.42247861,-37.21188,-25.242317)">
+      <path
+         id="path67"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g79">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path68"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path69"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path70"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path71"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path72"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path73"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path74"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path75"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path76"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path77"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path78"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path79"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:2.26752px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-24.497828"
+       y="58.416431"
+       id="text81"><tspan
+         sodipodi:role="line"
+         x="-24.497828"
+         y="58.416431"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan80">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="-24.497828"
+         y="61.250832"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan81">Buffer</tspan></text>
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M -24.338879,78.410023 V 69.962845"
+       id="path81"
+       sodipodi:nodetypes="cc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-52.574932"
+       y="53.340443"
+       id="text82"><tspan
+         sodipodi:role="line"
+         x="-52.574932"
+         y="53.340443"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+         id="tspan82">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-50.045757"
+       y="57.376377"
+       id="text83"><tspan
+         sodipodi:role="line"
+         x="-50.045757"
+         y="57.376377"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+         id="tspan83">A</tspan></text>
+    <g
+       id="g1"
+       transform="translate(0,-16.057901)">
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-12.593401"
+         y="57.349865"
+         id="text83-59"><tspan
+           sodipodi:role="line"
+           x="-12.593401"
+           y="57.349865"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-7">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-9.8666544"
+         y="57.349865"
+         id="text83-59-3"><tspan
+           sodipodi:role="line"
+           x="-9.8666544"
+           y="57.349865"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-7-6">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-24.724035"
+         y="57.3466"
+         id="text83-5-9"><tspan
+           sodipodi:role="line"
+           x="-24.724035"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-2">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-22.315107"
+         y="57.3466"
+         id="text83-5-9-9"><tspan
+           sodipodi:role="line"
+           x="-22.315107"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-2-5">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-19.937738"
+         y="57.3466"
+         id="text83-5-9-9-7"><tspan
+           sodipodi:role="line"
+           x="-19.937738"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.102999"
+           id="tspan83-4-2-5-2">B</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-17.56146"
+         y="57.3466"
+         id="text83-5-9-9-7-0"><tspan
+           sodipodi:role="line"
+           x="-17.56146"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.102999"
+           id="tspan83-4-2-5-2-6">B</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-15.185183"
+         y="57.3466"
+         id="text83-5-9-9-7-0-4"><tspan
+           sodipodi:role="line"
+           x="-15.185183"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.102999"
+           id="tspan83-4-2-5-2-6-9">B</tspan></text>
+    </g>
+    <g
+       id="g2"
+       transform="translate(0,-16.057901)">
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-46.032711"
+         y="57.349865"
+         id="text83-7"><tspan
+           sodipodi:role="line"
+           x="-46.032711"
+           y="57.349865"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-8">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-42.773308"
+         y="57.349865"
+         id="text83-7-4"><tspan
+           sodipodi:role="line"
+           x="-42.773308"
+           y="57.349865"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-8-3">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-55.041409"
+         y="57.3466"
+         id="text83-5"><tspan
+           sodipodi:role="line"
+           x="-55.041409"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-57.982994"
+         y="57.3466"
+         id="text83-5-3"><tspan
+           sodipodi:role="line"
+           x="-57.982994"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-5">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-52.099823"
+         y="57.3466"
+         id="text83-5-6"><tspan
+           sodipodi:role="line"
+           x="-52.099823"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-9">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-49.158237"
+         y="57.3466"
+         id="text83-5-6-5"><tspan
+           sodipodi:role="line"
+           x="-49.158237"
+           y="57.3466"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-9-2">C</tspan></text>
+    </g>
+    <g
+       id="g86"
+       transform="matrix(0.25710378,0,0,0.25710378,17.422136,8.7899633)">
+      <circle
+         style="fill:#ffffff;stroke:#ff0000;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+         id="circle84"
+         cx="-121.9205"
+         cy="20.747513"
+         r="30.822298" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="-122.11524"
+         y="26.792702"
+         id="text84"><tspan
+           sodipodi:role="line"
+           x="-122.11524"
+           y="26.792702"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.400612"
+           id="tspan84">C</tspan></text>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-size:2.17681px;font-family:'Linux Libertine O';-inkscape-font-specification:'Linux Libertine O';text-align:start;letter-spacing:1.26323px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#000000;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+       x="-140.03215"
+       y="26.074423"
+       id="text86"><tspan
+         sodipodi:role="line"
+         id="tspan86"
+         style="stroke-width:0.257104"
+         x="-140.03215"
+         y="26.074423" /></text>
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.463569;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+       id="rect89"
+       width="62.753353"
+       height="10.962811"
+       x="-68.911674"
+       y="32.218185" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:2.26751px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+       x="-37.552006"
+       y="35.595592"
+       id="text89"><tspan
+         sodipodi:role="line"
+         x="-37.552006"
+         y="35.595592"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26751px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+         id="tspan89">Enforce Isolation</tspan></text>
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M -57.807162,48.273529 V 44.392491"
+       id="path90"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M -24.512426,48.273529 V 44.392491"
+       id="path91"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#ff00ff;stroke:#ff00ff;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+       d="m -57.329023,22.418572 v 9.208373"
+       id="path1" />
+    <path
+       style="fill:#ff00ff;stroke:#ff9955;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+       d="m -32.844695,22.418572 v 9.208373"
+       id="path2" />
+    <path
+       style="fill:#ff00ff;stroke:#ff0000;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+       d="m -13.924085,22.418572 v 9.208373"
+       id="path4" />
+    <path
+       style="fill:none;stroke:#ff00ff;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+       d="m -57.329023,22.418572 v 5.174952 h 20.852017 v 4.033421"
+       id="path5"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+       d="m -13.924085,22.418572 v 3.652908 h -34.777483 v 5.555465"
+       id="path6"
+       sodipodi:nodetypes="cccc" />
+  </g>
+</svg>
diff --git a/Documentation/gpu/amdgpu/gfx_pipeline_seq.svg b/Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
new file mode 100644
index 000000000000..2f2c8fa98059
--- /dev/null
+++ b/Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
@@ -0,0 +1,413 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="141.76276mm"
+   height="51.906979mm"
+   viewBox="0 0 141.76275 51.906979"
+   version="1.1"
+   id="svg1"
+   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
+   sodipodi:docname="gfx_pipeline_seq.svg"
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
+     inkscape:zoom="1.2641204"
+     inkscape:cx="470.28748"
+     inkscape:cy="63.680643"
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
+  </defs>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(23.062206,-30.75877)">
+    <rect
+       style="fill:#ffffff;stroke:none;stroke-width:0.694678;stroke-linecap:square;stroke-dasharray:4.16805, 4.16805"
+       id="rect1"
+       width="141.76276"
+       height="51.906979"
+       x="-23.062206"
+       y="30.75877" />
+    <g
+       id="g28"
+       transform="matrix(1.0835493,0,0,1.0835493,-30.079831,-159.17628)">
+      <path
+         id="path18"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g27">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path19"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path20"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path21"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path22"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path23"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path24"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path25"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path26"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path27"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path28"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path29"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path30"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.92107px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.434083"
+       x="23.133495"
+       y="52.750404"
+       id="text24"><tspan
+         sodipodi:role="line"
+         x="23.133495"
+         y="52.750404"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:3.92107px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.434083"
+         id="tspan24">IB<tspan
+   style="font-size:3.92107px;baseline-shift:sub;fill:#ff9955;stroke-width:0.434083"
+   id="tspan27">b</tspan></tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.88054px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.434083"
+       x="2.4917324"
+       y="55.12072"
+       id="text139"><tspan
+         sodipodi:role="line"
+         x="2.4917324"
+         y="55.12072"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.88054px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.434083"
+         id="tspan138">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="2.4917324"
+         y="63.721394"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.88054px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.434083"
+         id="tspan139">Buffer</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:3.92107px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.434083"
+       x="22.115709"
+       y="65.117416"
+       id="text18"><tspan
+         sodipodi:role="line"
+         x="22.115709"
+         y="65.117416"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:3.92107px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#87decd;stroke-width:0.434083"
+         id="tspan18">IB<tspan
+   style="font-size:3.92107px;baseline-shift:sub;fill:#87decd;stroke-width:0.434083"
+   id="tspan17">c</tspan></tspan></text>
+    <g
+       id="g62"
+       transform="matrix(0.69467788,0,0,0.69467788,-104.6214,-57.027324)">
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="221.50526"
+         y="173.96935"
+         id="text48"><tspan
+           sodipodi:role="line"
+           x="221.50526"
+           y="173.96935"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#37abc8;stroke-width:0.400612"
+           id="tspan48">SX</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="238.1783"
+         y="173.96935"
+         id="text49"><tspan
+           sodipodi:role="line"
+           x="238.1783"
+           y="173.96935"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#37abc8;stroke-width:0.400612"
+           id="tspan49">GE</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="255.66414"
+         y="173.96935"
+         id="text50"><tspan
+           sodipodi:role="line"
+           x="255.66414"
+           y="173.96935"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#37abc8;stroke-width:0.400612"
+           id="tspan50">SPI</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="273.01663"
+         y="173.96935"
+         id="text51"><tspan
+           sodipodi:role="line"
+           x="273.01663"
+           y="173.96935"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+           id="tspan51">SC</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="289.11816"
+         y="173.97888"
+         id="text52"><tspan
+           sodipodi:role="line"
+           x="289.11816"
+           y="173.97888"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+           id="tspan52">PA</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff2a2a;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="311.40778"
+         y="174.08365"
+         id="text53"><tspan
+           sodipodi:role="line"
+           x="311.40778"
+           y="174.08365"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff2a2a;stroke-width:0.400612"
+           id="tspan53">Cache</tspan></text>
+      <path
+         style="fill:none;stroke:#000000;stroke-width:0.529167;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="m 226.31089,171.70241 h 6.95598"
+         id="path53"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:none;stroke:#000000;stroke-width:0.529167;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="m 242.81883,171.70241 h 6.95598"
+         id="path54"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:none;stroke:#000000;stroke-width:0.529167;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="m 261.37781,171.70241 h 6.95598"
+         id="path55"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:none;stroke:#000000;stroke-width:0.529167;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="m 277.50475,171.70241 h 6.95598"
+         id="path56"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:none;stroke:#000000;stroke-width:0.529167;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="m 294.08254,171.70241 h 6.95598"
+         id="path57"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:none;stroke:#000000;stroke-width:0.529167;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="m 189.90312,171.70241 h 26.34385"
+         id="path60"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:none;stroke:#000000;stroke-width:0.529167;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+         d="m 311.60514,176.14239 v 9.61994 H 184.98772"
+         id="path61"
+         sodipodi:nodetypes="ccc" />
+    </g>
+    <path
+       style="fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+       d="m 40.698106,46.362333 4.844663,13.377322"
+       id="path62"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+       d="m 52.62426,46.362333 4.844663,13.377322"
+       id="path63"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+       d="m 64.55042,46.362333 4.844663,13.377322"
+       id="path64"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+       d="m 75.962512,46.362333 4.844663,13.377322"
+       id="path65"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#37c871;stroke:#00d455;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+       d="m 87.580235,46.362333 4.844663,13.377322"
+       id="path66"
+       sodipodi:nodetypes="cc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.4112px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.278297"
+       x="37.018822"
+       y="45.730473"
+       id="text2"><tspan
+         sodipodi:role="line"
+         x="37.018822"
+         y="45.730473"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#37abc8;stroke-width:0.278297"
+         id="tspan2">SX</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.4112px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.278297"
+       x="48.601212"
+       y="45.730473"
+       id="text3"><tspan
+         sodipodi:role="line"
+         x="48.601212"
+         y="45.730473"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#37abc8;stroke-width:0.278297"
+         id="tspan3">GE</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.4112px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#37abc8;fill-opacity:1;stroke:none;stroke-width:0.278297"
+       x="60.748234"
+       y="45.730473"
+       id="text4"><tspan
+         sodipodi:role="line"
+         x="60.748234"
+         y="45.730473"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#37abc8;stroke-width:0.278297"
+         id="tspan4">SPI</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.4112px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.278297"
+       x="72.802635"
+       y="45.730473"
+       id="text11"><tspan
+         sodipodi:role="line"
+         x="72.802635"
+         y="45.730473"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.278297"
+         id="tspan11">SC</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.4112px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.278297"
+       x="83.988014"
+       y="45.737099"
+       id="text13"><tspan
+         sodipodi:role="line"
+         x="83.988014"
+         y="45.737099"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.278297"
+         id="tspan13">PA</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:4.4112px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff2a2a;fill-opacity:1;stroke:none;stroke-width:0.278297"
+       x="99.472122"
+       y="45.809875"
+       id="text14"><tspan
+         sodipodi:role="line"
+         x="99.472122"
+         y="45.809875"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:4.4112px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff2a2a;stroke-width:0.278297"
+         id="tspan14">Cache</tspan></text>
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 40.357179,44.155689 h 4.832165"
+       id="path44"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 51.82488,44.155689 h 4.832165"
+       id="path45"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 64.717393,44.155689 h 4.832165"
+       id="path46"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 75.920422,44.155689 h 4.832165"
+       id="path47"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 87.436645,44.155689 h 4.832166"
+       id="path48"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 24.215741,44.155689 h 7.813702"
+       id="path58"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#000000;stroke-width:0.367601;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWideHeavy)"
+       d="m 100.63732,46.931607 v 6.68276 H 29.848557"
+       id="path59"
+       sodipodi:nodetypes="ccc" />
+  </g>
+</svg>
diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 45523e9860fc..8732084186a4 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -8,6 +8,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
 .. toctree::
 
    driver-core
+   ring-buffer
    amd-hardware-list-info
    module-parameters
    gc/index
diff --git a/Documentation/gpu/amdgpu/no_enforce_isolation.svg b/Documentation/gpu/amdgpu/no_enforce_isolation.svg
new file mode 100644
index 000000000000..b224615e1611
--- /dev/null
+++ b/Documentation/gpu/amdgpu/no_enforce_isolation.svg
@@ -0,0 +1,707 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="68.949203mm"
+   height="86.909332mm"
+   viewBox="0 0 68.949202 86.909332"
+   version="1.1"
+   id="svg1"
+   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
+   sodipodi:docname="enforce_isolation.svg"
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
+     inkscape:zoom="1.7877362"
+     inkscape:cx="291.15034"
+     inkscape:cy="332.54347"
+     inkscape:window-width="3072"
+     inkscape:window-height="1651"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="g61" />
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
+       id="Dot"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Dot"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.5)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
+         sodipodi:nodetypes="sssss"
+         id="path98" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="marker99"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Dot"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.5)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
+         sodipodi:nodetypes="sssss"
+         id="path99" />
+    </marker>
+  </defs>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(72.009598,0.94510132)">
+    <g
+       id="g61">
+      <rect
+         style="fill:#ffffff;stroke:none;stroke-width:0.25654;stroke-linecap:square;stroke-dasharray:none"
+         id="rect6"
+         width="68.949203"
+         height="86.909332"
+         x="-72.009598"
+         y="-0.94510132" />
+      <g
+         id="g15"
+         transform="matrix(0.42247861,0,0,0.42247861,-70.575576,-29.756289)">
+        <path
+           id="path33"
+           style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+           d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+        <g
+           id="g14">
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 46.31405,200.72093 h 6.430134"
+             id="path34"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="M 7.6848605,200.72093 H 14.114993"
+             id="path35"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 30.103415,176.7326 v 6.43014"
+             id="path36"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="M 30.103415,215.50586 V 221.936"
+             id="path37"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 36.501694,214.1052 3.21507,5.56866"
+             id="path38"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 36.501694,184.66805 3.21507,-5.56866"
+             id="path39"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 23.652811,184.66805 -3.21507,-5.56866"
+             id="path40"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 23.652811,214.05288 -3.21507,5.56866"
+             id="path41"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 43.31839,208.65101 4.546794,4.5468"
+             id="path42"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 43.31839,189.96525 4.546794,-4.5468"
+             id="path43"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="M 17.202394,189.96525 12.6556,185.41845"
+             id="path44-1"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 16.940766,208.65101 -4.546794,4.5468"
+             id="path45-8"
+             sodipodi:nodetypes="cc" />
+        </g>
+      </g>
+      <rect
+         style="fill:#afe9c6;stroke:#16502d;stroke-width:0.257104;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+         id="rect80"
+         width="25.076588"
+         height="10.493422"
+         x="-71.362038"
+         y="74.63459"
+         ry="1.4529352" />
+      <rect
+         style="fill:#80e5ff;stroke:#00aad4;stroke-width:0.257104;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+         id="rect81"
+         width="32.714355"
+         height="10.436013"
+         x="-40.481403"
+         y="74.663292"
+         ry="1.4449863" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.53042px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-59.013123"
+         y="82.212669"
+         id="text14-7"><tspan
+           sodipodi:role="line"
+           x="-59.013123"
+           y="82.212669"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.53042px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+           id="tspan14-7">GFX</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:6.53042px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-24.387218"
+         y="81.46167"
+         id="text95"><tspan
+           sodipodi:role="line"
+           x="-24.387218"
+           y="81.46167"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.53042px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+           id="tspan95">Compute</tspan></text>
+      <path
+         style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+         d="M -58.079264,73.89605 V 65.448872"
+         id="path127"
+         sodipodi:nodetypes="cc" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.90242px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-61.752651"
+         y="3.1995225"
+         id="text112"><tspan
+           sodipodi:role="line"
+           x="-61.752651"
+           y="3.1995225"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.90242px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+           id="tspan112">Processes</tspan></text>
+      <rect
+         style="fill:none;stroke:#000000;stroke-width:0.247306;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:1.48383, 1.48383;stroke-dashoffset:0"
+         id="rect113"
+         width="64.703476"
+         height="19.562067"
+         x="-68.52655"
+         y="4.468956"
+         ry="1.6976216" />
+      <g
+         id="g84"
+         transform="matrix(0.25710378,0,0,0.25710378,0.68647434,8.7899633)">
+        <g
+           id="g83">
+          <circle
+             style="fill:#ffffff;stroke:#ff00ff;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+             id="circle137"
+             cx="-225.65012"
+             cy="20.747513"
+             r="30.822298" />
+        </g>
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+           x="-225.65012"
+           y="26.8181"
+           id="text113"><tspan
+             sodipodi:role="line"
+             x="-225.65012"
+             y="26.8181"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.400612"
+             id="tspan113">A</tspan></text>
+      </g>
+      <g
+         id="g85"
+         transform="matrix(0.25710378,0,0,0.25710378,20.618429,8.7899633)">
+        <circle
+           style="fill:#ffffff;stroke:#ff9955;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+           id="circle112"
+           cx="-207.94376"
+           cy="20.747513"
+           r="30.822298" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+           x="-208.25702"
+           y="26.792702"
+           id="text114"><tspan
+             sodipodi:role="line"
+             x="-208.25702"
+             y="26.792702"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+             id="tspan114">B</tspan></text>
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-56.126556"
+         y="47.212101"
+         id="text6"><tspan
+           sodipodi:role="line"
+           x="-56.126556"
+           y="47.212101"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan6">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.26752px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-57.861526"
+         y="53.902462"
+         id="text136"><tspan
+           sodipodi:role="line"
+           x="-57.861526"
+           y="53.902462"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+           id="tspan136">Ring</tspan><tspan
+           sodipodi:role="line"
+           x="-57.861526"
+           y="56.736862"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+           id="tspan137">Buffer</tspan></text>
+      <g
+         id="g80"
+         transform="matrix(0.42247861,0,0,0.42247861,-37.21188,-29.756289)">
+        <path
+           id="path67"
+           style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+           d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+        <g
+           id="g79">
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 46.31405,200.72093 h 6.430134"
+             id="path68"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="M 7.6848605,200.72093 H 14.114993"
+             id="path69"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 30.103415,176.7326 v 6.43014"
+             id="path70"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="M 30.103415,215.50586 V 221.936"
+             id="path71"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 36.501694,214.1052 3.21507,5.56866"
+             id="path72"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 36.501694,184.66805 3.21507,-5.56866"
+             id="path73"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 23.652811,184.66805 -3.21507,-5.56866"
+             id="path74"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 23.652811,214.05288 -3.21507,5.56866"
+             id="path75"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 43.31839,208.65101 4.546794,4.5468"
+             id="path76"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 43.31839,189.96525 4.546794,-4.5468"
+             id="path77"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="M 17.202394,189.96525 12.6556,185.41845"
+             id="path78"
+             sodipodi:nodetypes="cc" />
+          <path
+             style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+             d="m 16.940766,208.65101 -4.546794,4.5468"
+             id="path79"
+             sodipodi:nodetypes="cc" />
+        </g>
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.26752px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-24.497828"
+         y="53.902462"
+         id="text81"><tspan
+           sodipodi:role="line"
+           x="-24.497828"
+           y="53.902462"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+           id="tspan80">Ring</tspan><tspan
+           sodipodi:role="line"
+           x="-24.497828"
+           y="56.736862"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.26752px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.102999"
+           id="tspan81">Buffer</tspan></text>
+      <path
+         style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+         d="M -24.338879,73.89605 V 65.448872"
+         id="path81"
+         sodipodi:nodetypes="cc" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-52.574932"
+         y="48.826473"
+         id="text82"><tspan
+           sodipodi:role="line"
+           x="-52.574932"
+           y="48.826473"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan82">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-50.045757"
+         y="52.862404"
+         id="text83"><tspan
+           sodipodi:role="line"
+           x="-50.045757"
+           y="52.862404"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-31.907158"
+         y="58.226768"
+         id="text83-59"><tspan
+           sodipodi:role="line"
+           x="-31.907158"
+           y="58.226768"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-7">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-32.436516"
+         y="53.169308"
+         id="text83-59-3"><tspan
+           sodipodi:role="line"
+           x="-32.436516"
+           y="53.169308"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-7-6">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-65.422112"
+         y="57.972916"
+         id="text83-7"><tspan
+           sodipodi:role="line"
+           x="-65.422112"
+           y="57.972916"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-8">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff00ff;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-65.713165"
+         y="52.732723"
+         id="text83-7-4"><tspan
+           sodipodi:role="line"
+           x="-65.713165"
+           y="52.732723"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff00ff;stroke-width:0.102999"
+           id="tspan83-8-3">A</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-52.897129"
+         y="61.668709"
+         id="text83-5"><tspan
+           sodipodi:role="line"
+           x="-52.897129"
+           y="61.668709"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-19.174068"
+         y="49.045818"
+         id="text83-5-9"><tspan
+           sodipodi:role="line"
+           x="-19.174068"
+           y="49.045818"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-2">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-16.531792"
+         y="53.259804"
+         id="text83-5-9-9"><tspan
+           sodipodi:role="line"
+           x="-16.531792"
+           y="53.259804"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-2-5">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-19.325029"
+         y="61.488995"
+         id="text83-5-9-9-7"><tspan
+           sodipodi:role="line"
+           x="-19.325029"
+           y="61.488995"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.102999"
+           id="tspan83-4-2-5-2">B</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-22.869593"
+         y="63.231686"
+         id="text83-5-9-9-7-0"><tspan
+           sodipodi:role="line"
+           x="-22.869593"
+           y="63.231686"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.102999"
+           id="tspan83-4-2-5-2-6">B</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-26.235374"
+         y="63.331181"
+         id="text83-5-9-9-7-0-4"><tspan
+           sodipodi:role="line"
+           x="-26.235374"
+           y="63.331181"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.102999"
+           id="tspan83-4-2-5-2-6-9">B</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-56.235538"
+         y="63.072704"
+         id="text83-5-6"><tspan
+           sodipodi:role="line"
+           x="-56.235538"
+           y="63.072704"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-9">C</tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:2.17681px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:0.102999"
+         x="-59.697765"
+         y="63.066635"
+         id="text83-5-6-5"><tspan
+           sodipodi:role="line"
+           x="-59.697765"
+           y="63.066635"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:2.17681px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.102999"
+           id="tspan83-4-9-2">C</tspan></text>
+      <circle
+         style="fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         id="path83"
+         cx="-50.145481"
+         cy="57.387428"
+         r="1.0712636" />
+      <circle
+         style="fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         id="path83-7"
+         cx="-16.886913"
+         cy="57.596024"
+         r="1.0712636" />
+      <circle
+         style="fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         id="path83-7-7"
+         cx="-29.53648"
+         cy="60.832634"
+         r="1.0712636" />
+      <circle
+         style="fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         id="path83-7-7-9"
+         cx="-29.751556"
+         cy="48.260994"
+         r="1.0712636" />
+      <circle
+         style="fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         id="path83-4"
+         cx="-63.051891"
+         cy="60.73439"
+         r="1.0712636" />
+      <circle
+         style="fill:#ffcc00;stroke:#00d455;stroke-width:0.213261;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         id="path83-4-2"
+         cx="-63.022129"
+         cy="48.24374"
+         r="1.0712636" />
+      <g
+         id="g86"
+         transform="matrix(0.25710378,0,0,0.25710378,17.422136,8.7899633)">
+        <circle
+           style="fill:#ffffff;stroke:#ff0000;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+           id="circle84"
+           cx="-121.9205"
+           cy="20.747513"
+           r="30.822298" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+           x="-122.11524"
+           y="26.792702"
+           id="text84"><tspan
+             sodipodi:role="line"
+             x="-122.11524"
+             y="26.792702"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.400612"
+             id="tspan84">C</tspan></text>
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-size:2.17681px;font-family:'Linux Libertine O';-inkscape-font-specification:'Linux Libertine O';text-align:start;letter-spacing:1.26323px;writing-mode:lr-tb;direction:ltr;text-anchor:start;fill:none;stroke:#000000;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         x="-140.03215"
+         y="26.074423"
+         id="text86"><tspan
+           sodipodi:role="line"
+           id="tspan86"
+           style="stroke-width:0.257104"
+           x="-140.03215"
+           y="26.074423" /></text>
+      <g
+         id="g90"
+         transform="matrix(0.25710378,0,0,0.25710378,18.175509,7.82134)">
+        <rect
+           style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect86"
+           width="92.604057"
+           height="26.883123"
+           x="-338.30258"
+           y="93.635468" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:8.81944px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+           x="-291.13989"
+           y="110.58046"
+           id="text88"><tspan
+             sodipodi:role="line"
+             x="-291.13989"
+             y="110.58046"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:8.81944px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+             id="tspan88">Enforce Isolation</tspan></text>
+      </g>
+      <g
+         id="g89"
+         transform="matrix(0.25710378,0,0,0.25710378,18.606009,7.82134)">
+        <rect
+           style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+           id="rect89"
+           width="119.67937"
+           height="26.749132"
+           x="-219.35185"
+           y="93.702461" />
+        <text
+           xml:space="preserve"
+           style="font-style:normal;font-weight:normal;font-size:8.81944px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+           x="-159.57832"
+           y="110.40636"
+           id="text89"><tspan
+             sodipodi:role="line"
+             x="-159.57832"
+             y="110.40636"
+             style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:8.81944px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+             id="tspan89">Enforce Isolation</tspan></text>
+      </g>
+      <path
+         style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+         d="M -57.807162,43.759556 V 39.878518"
+         id="path90"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:#de8787;stroke:#000000;stroke-width:0.385656;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+         d="M -24.512426,43.759556 V 39.878518"
+         id="path91"
+         sodipodi:nodetypes="cc" />
+      <path
+         style="fill:#ff00ff;stroke:#ff00ff;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+         d="m -57.329023,22.418572 v 9.208373"
+         id="path1" />
+      <path
+         style="fill:#ff00ff;stroke:#ff9955;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+         d="m -32.844695,22.418572 v 9.208373"
+         id="path2" />
+      <path
+         style="fill:#ff00ff;stroke:#ff0000;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+         d="m -13.924085,22.418572 v 9.208373"
+         id="path4" />
+      <path
+         style="fill:none;stroke:#ff00ff;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+         d="m -57.329023,22.418572 v 5.174952 h 20.852017 v 4.033421"
+         id="path5"
+         sodipodi:nodetypes="cccc" />
+      <path
+         style="fill:none;stroke:#ff0000;stroke-width:0.257104;stroke-linecap:square;stroke-dasharray:none;marker-end:url(#ArrowWideHeavy)"
+         d="m -13.924085,22.418572 v 3.652908 h -34.777483 v 5.555465"
+         id="path6"
+         sodipodi:nodetypes="cccc" />
+    </g>
+  </g>
+</svg>
diff --git a/Documentation/gpu/amdgpu/process-isolation.rst b/Documentation/gpu/amdgpu/process-isolation.rst
index 25b06ffefc33..03c4288aa8b1 100644
--- a/Documentation/gpu/amdgpu/process-isolation.rst
+++ b/Documentation/gpu/amdgpu/process-isolation.rst
@@ -1,3 +1,4 @@
+.. _amdgpu-process-isolation:
 .. SPDX-License-Identifier: GPL-2.0
 
 =========================
diff --git a/Documentation/gpu/amdgpu/ring-buffer.rst b/Documentation/gpu/amdgpu/ring-buffer.rst
new file mode 100644
index 000000000000..cc642c21316b
--- /dev/null
+++ b/Documentation/gpu/amdgpu/ring-buffer.rst
@@ -0,0 +1,95 @@
+=============
+ Ring Buffer
+=============
+
+To handle communication between user space and kernel space, AMD GPUs use a
+ring buffer design to feed the engines (GFX, Compute, SDMA, UVD, VCE, VCN, VPE,
+etc.). See the figure below that illustrates how this communication works:
+
+.. kernel-figure:: ring_buffers.svg
+
+Ring buffers in the amdgpu work as a producer-consumer model, where userspace
+acts as the producer, constantly filling the ring buffer with GPU commands to
+be executed. Meanwhile, the GPU retrieves the information from the ring, parses
+it, and distributes the specific set of instructions between the different
+amdgpu blocks.
+
+Notice from the diagram that the ring has a Read Pointer (rptr), which
+indicates where the engine is currently reading packets from the ring, and a
+Write Pointer (wptr), which indicates how many packets software has added to
+the ring. When the rptr and wptr are equal, the ring is idle. When software
+adds packets to the ring, it updates the wptr, this causes the engine to start
+fetching and processing packets. As the engine processes packets, the rptr gets
+updates until the rptr catches up to the wptr and they are equal again.
+
+Usually, ring buffers in the driver have a limited size (search for occurrences
+of `amdgpu_ring_init()`). One of the reasons for the small ring buffer size is
+that CP (Command Processor) is capable of following addresses inserted into the
+ring; this is illustrated in the image by the reference to the IB (Indirect
+Buffer). The IB gives userspace the possibility to have an area in memory that
+CP can read and feed the hardware with extra instructions.
+
+All ASICs pre-GFX11 use what is called a kernel queue, which means
+the ring is allocated in kernel space and has some restrictions, such as not
+being able to be :ref:`preempted directly by the scheduler<amdgpu-mes>`. GFX11
+and newer support kernel queues, but also provide a new mechanism named
+:ref:`user queues<amdgpu-userq>`, where the queue is moved to the user space
+and can be mapped and unmapped via the scheduler. In practice, both queues
+insert user-space-generated GPU commands from different jobs into the requested
+component ring.
+
+Enforce Isolation
+=================
+
+.. note:: After reading this section, you might want to check the
+   :ref:`Process Isolation<amdgpu-process-isolation>` page for more details.
+
+Before examining the Enforce Isolation mechanism in the ring buffer context, it
+is helpful to briefly discuss how instructions from the ring buffer are
+processed in the graphics pipeline. Let’s expand on this topic by checking the
+diagram below that illustrates the graphics pipeline:
+
+.. kernel-figure:: gfx_pipeline_seq.svg
+
+In terms of executing instructions, the GFX pipeline follows the sequence:
+Shader Export (SX), Geometry Engine (GE), Shader Process or Input (SPI), Scan
+Converter (SC), Primitive Assembler (PA), and cache manipulation (which may
+vary across ASICs). Another common way to describe the pipeline is to use Pixel
+Shader (PS), raster, and Vertex Shader (VS) to symbolize the two shader stages.
+Now, with this pipeline in mind, let's assume that Job B causes a hang issue,
+but Job C's instruction might already be executing, leading developers to
+incorrectly identify Job C as the problematic one. This problem can be
+mitigated on multiple levels; the diagram below illustrates how to minimize
+part of this problem:
+
+.. kernel-figure:: no_enforce_isolation.svg
+
+Note from the diagram that there is no guarantee of order or a clear separation
+between instructions, which is not a problem most of the time, and is also good
+for performance. Furthermore, notice some circles between jobs in the diagram
+that represent a **fence wait** used to avoid overlapping work in the ring. At
+the end of the fence, a cache flush occurs, ensuring that when the next job
+starts, it begins in a clean state and, if issues arise, the developer can
+pinpoint the problematic process more precisely.
+
+To increase the level of isolation between jobs, there is the "Enforce
+Isolation" method described in the picture below:
+
+.. kernel-figure:: enforce_isolation.svg
+
+As shown in the diagram, enforcing isolation introduces ordering between
+submissions, since the access to GFX/Compute is serialized, think about it as
+single process at a time mode for gfx/compute. Notice that this approach has a
+significant performance impact, as it allows only one job to submit commands at
+a time. However, this option can help pinpoint the job that caused the problem.
+Although enforcing isolation improves the situation, it does not fully resolve
+the issue of precisely pinpointing bad jobs, since isolation might mask the
+problem. In summary, identifying which job caused the issue may not be precise,
+but enforcing isolation might help with the debugging.
+
+Ring Operations
+===============
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+   :internal:
+
diff --git a/Documentation/gpu/amdgpu/ring_buffers.svg b/Documentation/gpu/amdgpu/ring_buffers.svg
new file mode 100644
index 000000000000..7a6fcb19e151
--- /dev/null
+++ b/Documentation/gpu/amdgpu/ring_buffers.svg
@@ -0,0 +1,1633 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="588.32483mm"
+   height="341.81656mm"
+   viewBox="0 0 588.32483 341.81656"
+   version="1.1"
+   id="svg1"
+   inkscape:version="1.4 (e7c3feb100, 2024-10-09)"
+   sodipodi:docname="RING_BUFFER.svg"
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
+     inkscape:zoom="0.89386809"
+     inkscape:cx="1106.9866"
+     inkscape:cy="729.97348"
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
+       id="marker154"
+       refX="2"
+       refY="0"
+       orient="auto-start-reverse"
+       inkscape:stockid="Empty semicircle"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         style="fill:none;fill-rule:evenodd;stroke:context-stroke;stroke-width:1.08"
+         d="m -0.7647042,-3.0274156 c 1.656,0 3,1.344 3,3 0,1.656 -1.344,3 -3,3"
+         id="path154" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="ArrowTriangleStylized"
+       refX="0"
+       refY="0"
+       orient="auto-start-reverse"
+       inkscape:stockid="Stylized triangle arrow"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.5)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:context-stroke;stroke-width:1pt"
+         d="m 6,0 c -3,1 -7,3 -9,5 0,0 0,-4 2,-5 -2,-1 -2,-5 -2,-5 2,2 6,4 9,5 z"
+         id="path135" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="marker132"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Diamond"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.45)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 0,-7.0710768 -7.0710894,0 0,7.0710589 7.0710462,0 Z"
+         id="path132" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="Diamond"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Diamond"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.45)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 0,-7.0710768 -7.0710894,0 0,7.0710589 7.0710462,0 Z"
+         id="path131" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="ArrowWide"
+       refX="0"
+       refY="0"
+       orient="auto-start-reverse"
+       inkscape:stockid="Wide arrow"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         style="fill:none;stroke:context-stroke;stroke-width:1;stroke-linecap:butt"
+         d="M 3,-3 0,0 3,3"
+         transform="rotate(180,0.125,0)"
+         sodipodi:nodetypes="ccc"
+         id="path81" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="marker99"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Dot"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.5)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
+         sodipodi:nodetypes="sssss"
+         id="path99" />
+    </marker>
+    <marker
+       style="overflow:visible"
+       id="Dot"
+       refX="0"
+       refY="0"
+       orient="auto"
+       inkscape:stockid="Dot"
+       markerWidth="1"
+       markerHeight="1"
+       viewBox="0 0 1 1"
+       inkscape:isstock="true"
+       inkscape:collect="always"
+       preserveAspectRatio="xMidYMid">
+      <path
+         transform="scale(0.5)"
+         style="fill:context-stroke;fill-rule:evenodd;stroke:none"
+         d="M 5,0 C 5,2.76 2.76,5 0,5 -2.76,5 -5,2.76 -5,0 c 0,-2.76 2.3,-5 5,-5 2.76,0 5,2.24 5,5 z"
+         sodipodi:nodetypes="sssss"
+         id="path98" />
+    </marker>
+  </defs>
+  <g
+     inkscape:label="Layer 1"
+     inkscape:groupmode="layer"
+     id="layer1"
+     transform="translate(123.51219,3.0159921)">
+    <rect
+       style="fill:#ffffff;stroke:none;stroke-width:1;stroke-linecap:square;stroke-dasharray:1, 2;stroke-dashoffset:0"
+       id="rect167"
+       width="595.25238"
+       height="349.86984"
+       x="-128.24815"
+       y="-8.0479612" />
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:1, 2;stroke-dashoffset:0"
+       id="rect111"
+       width="500.64935"
+       height="63.365536"
+       x="-65.219322"
+       y="168.41347"
+       ry="5.4989429" />
+    <path
+       style="fill:none;stroke:#917c6f;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 24.09216,175.30492 V 125.06784 H 47.447018 V 83.98949"
+       id="path151"
+       sodipodi:nodetypes="cccc" />
+    <g
+       id="g15"
+       transform="translate(-4.735971)">
+      <path
+         id="path1"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g14">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path3"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path4"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path5"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path6"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path7"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path8"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path9"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path10"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path11"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path12"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path13"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path14"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <g
+       id="g28"
+       transform="translate(46.175717)">
+      <path
+         id="path15"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g27">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path16"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path17"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path18"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path19"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path20"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path21"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path22"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path23"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path24"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path25"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path26"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path27"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <g
+       id="g41"
+       transform="translate(102.62407)">
+      <path
+         id="path28"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g40">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path29"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path30"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path31"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path32"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path33"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path34"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path35"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path36"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path37"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path38"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path39"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path40"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <g
+       id="g54"
+       transform="translate(154.12775)">
+      <path
+         id="path41"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g53">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path42"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path43"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path44"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path45"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path46"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path47"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path48"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path49"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path50"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path51"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path52"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path53"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <g
+       id="g67"
+       transform="translate(205.37341)">
+      <path
+         id="path54"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g66">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path55"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path56"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path57"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path58"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path59"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path60"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path61"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path62"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path63"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path64"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path65"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path66"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <g
+       id="g80"
+       transform="translate(256.63043)">
+      <path
+         id="path67"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g79">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path68"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path69"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path70"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path71"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path72"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path73"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path74"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path75"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path76"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path77"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path78"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path79"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <rect
+       style="fill:#afe9c6;stroke:#16502d;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+       id="rect80"
+       width="97.534882"
+       height="40.813953"
+       x="2.9731095"
+       y="288.36279"
+       ry="5.6511626" />
+    <rect
+       style="fill:#80e5ff;stroke:#00aad4;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+       id="rect81"
+       width="199.46111"
+       height="40.391335"
+       x="110.41494"
+       y="288.57413"
+       ry="5.5926461" />
+    <rect
+       style="fill:#de8787;stroke:#a02c2c;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+       id="rect82"
+       width="81.028717"
+       height="40.88369"
+       x="321.87186"
+       y="288.32794"
+       ry="5.6608181" />
+    <g
+       id="g95"
+       transform="translate(332.1071)">
+      <path
+         id="path82"
+         style="fill:none;stroke:#000000;stroke-width:0.721067;stroke-dasharray:none"
+         d="M 30.278993,176.45537 A 22.905334,22.905334 0 0 0 7.3737955,199.36057 22.905334,22.905334 0 0 0 30.278993,222.26603 22.905334,22.905334 0 0 0 53.18445,199.36057 22.905334,22.905334 0 0 0 30.278993,176.45537 Z m 0,7.13274 a 15.772359,15.772359 0 0 1 15.77246,15.77246 15.772359,15.772359 0 0 1 -15.77246,15.77246 15.772359,15.772359 0 0 1 -15.772206,-15.77246 15.772359,15.772359 0 0 1 15.772206,-15.77246 z" />
+      <g
+         id="g94">
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 46.31405,200.72093 h 6.430134"
+           id="path83"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 7.6848605,200.72093 H 14.114993"
+           id="path84"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 30.103415,176.7326 v 6.43014"
+           id="path85"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 30.103415,215.50586 V 221.936"
+           id="path86"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,214.1052 3.21507,5.56866"
+           id="path87"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 36.501694,184.66805 3.21507,-5.56866"
+           id="path88"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,184.66805 -3.21507,-5.56866"
+           id="path89"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 23.652811,214.05288 -3.21507,5.56866"
+           id="path90"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,208.65101 4.546794,4.5468"
+           id="path91"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 43.31839,189.96525 4.546794,-4.5468"
+           id="path92"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="M 17.202394,189.96525 12.6556,185.41845"
+           id="path93"
+           sodipodi:nodetypes="cc" />
+        <path
+           style="fill:#ff00ff;stroke:#000000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+           d="m 16.940766,208.65101 -4.546794,4.5468"
+           id="path94"
+           sodipodi:nodetypes="cc" />
+      </g>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:25.4px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="51.003948"
+       y="317.83759"
+       id="text14-7"><tspan
+         sodipodi:role="line"
+         x="51.003948"
+         y="317.83759"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:25.4px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan14-7">GFX</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:25.4px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="209.95499"
+       y="314.9166"
+       id="text95"><tspan
+         sodipodi:role="line"
+         x="209.95499"
+         y="314.9166"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:25.4px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan95">Compute</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:25.4px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="361.80203"
+       y="317.83759"
+       id="text96"><tspan
+         sodipodi:role="line"
+         x="361.80203"
+         y="317.83759"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:25.4px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan96">SDMA</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:36.862px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="429.28961"
+       y="313.10159"
+       id="text97"><tspan
+         sodipodi:role="line"
+         x="429.28961"
+         y="313.10159"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan97">...</tspan></text>
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M 25.543152,285.49025 V 224.58863"
+       id="path97"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M 76.45484,285.49025 V 224.58863"
+       id="path100"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M 132.90319,285.49025 V 224.58863"
+       id="path101"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M 184.40687,285.49025 V 224.58863"
+       id="path102"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M 235.65253,285.49025 V 224.58863"
+       id="path103"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M 286.90955,285.49025 V 224.58863"
+       id="path104"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#Dot);marker-end:url(#marker99)"
+       d="M 362.38622,285.49025 V 224.58863"
+       id="path105"
+       sodipodi:nodetypes="cc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:36.862px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="261.28104"
+       y="259.52591"
+       id="text105"><tspan
+         sodipodi:role="line"
+         x="261.28104"
+         y="259.52591"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan105">...</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:36.862px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="50.998993"
+       y="259.52591"
+       id="text106"><tspan
+         sodipodi:role="line"
+         x="50.998993"
+         y="259.52591"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan106">...</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:36.862px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="382.22592"
+       y="259.52591"
+       id="text107"><tspan
+         sodipodi:role="line"
+         x="382.22592"
+         y="259.52591"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:36.862px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan107">...</tspan></text>
+    <path
+       style="fill:#de8787;stroke:#000000;stroke-width:2;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none"
+       d="M -65.568535,148.88709 H 459.54211"
+       id="path107" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:19.7556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="415.21619"
+       y="166.24187"
+       id="text108"><tspan
+         sodipodi:role="line"
+         x="415.21619"
+         y="166.24187"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:19.7556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan108">Kernel</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:19.7556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="414.91986"
+       y="138.75868"
+       id="text109"><tspan
+         sodipodi:role="line"
+         x="414.91986"
+         y="138.75868"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:19.7556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan109">Userspace</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:11.2889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="-44.396496"
+       y="199.94142"
+       id="text110"><tspan
+         sodipodi:role="line"
+         x="-44.396496"
+         y="199.94142"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan110">Kernel</tspan><tspan
+         sodipodi:role="line"
+         x="-44.396496"
+         y="214.05255"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan111">Queue</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:11.2889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="-30.39555"
+       y="53.215206"
+       id="text112"><tspan
+         sodipodi:role="line"
+         x="-30.39555"
+         y="53.215206"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan112">Processes</tspan></text>
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:9, 9;stroke-dashoffset:0"
+       id="rect113"
+       width="452.2225"
+       height="75.723717"
+       x="-60.944237"
+       y="11.868809"
+       ry="6.5714021" />
+    <circle
+       style="fill:#ffffff;stroke:#917c6f;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+       id="path111"
+       cx="47.507706"
+       cy="49.241512"
+       r="30.822298" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#917c6f;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="47.50771"
+       y="55.312099"
+       id="text113"><tspan
+         sodipodi:role="line"
+         x="47.50771"
+         y="55.312099"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#917c6f;stroke-width:0.400612"
+         id="tspan113">A</tspan></text>
+    <circle
+       style="fill:#ffffff;stroke:#ff9955;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+       id="circle112"
+       cx="176.56291"
+       cy="49.241512"
+       r="30.822298" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="176.24965"
+       y="55.286701"
+       id="text114"><tspan
+         sodipodi:role="line"
+         x="176.24965"
+         y="55.286701"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan114">B</tspan></text>
+    <circle
+       style="fill:#ffffff;stroke:#55ddff;stroke-width:1.62704;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;stroke-dashoffset:0"
+       id="circle113"
+       cx="305.61813"
+       cy="49.241512"
+       r="30.822298" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:16.9333px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="305.42337"
+       y="55.286701"
+       id="text115"><tspan
+         sodipodi:role="line"
+         x="305.42337"
+         y="55.286701"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:16.9333px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#55ddff;stroke-width:0.400612"
+         id="tspan115">C</tspan></text>
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:1.5;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:5.99998, 2.99999, 1.5, 2.99999;stroke-dashoffset:0"
+       id="rect117"
+       width="515.65753"
+       height="59.528286"
+       x="-65.221695"
+       y="278.51898"
+       ry="5.1659417" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:11.2889px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="-44.396496"
+       y="312.30948"
+       id="text118"><tspan
+         sodipodi:role="line"
+         x="-44.396496"
+         y="312.30948"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:11.2889px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan118">GPU</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="-17.792967"
+       y="194.41469"
+       id="text4"><tspan
+         sodipodi:role="line"
+         x="-17.792967"
+         y="194.41469"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.400612"
+         id="tspan4">wptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="36.248669"
+       y="163.10979"
+       id="text5"><tspan
+         sodipodi:role="line"
+         x="36.248669"
+         y="163.10979"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ff00;stroke-width:0.400612"
+         id="tspan5">rptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="28.952087"
+       y="182.41843"
+       id="text6"><tspan
+         sodipodi:role="line"
+         x="28.952087"
+         y="182.41843"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ac9d93;stroke-width:0.400612"
+         id="tspan6">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="37.832031"
+       y="186.1924"
+       id="text7"><tspan
+         sodipodi:role="line"
+         x="37.832031"
+         y="186.1924"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ac9d93;stroke-width:0.400612"
+         id="tspan7">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="37.98003"
+       y="216.31021"
+       id="text8"><tspan
+         sodipodi:role="line"
+         x="37.98003"
+         y="216.31021"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ac9d93;stroke-width:0.400612"
+         id="tspan8">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="8.1582127"
+       y="208.54025"
+       id="text9"><tspan
+         sodipodi:role="line"
+         x="8.1582127"
+         y="208.54025"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ac9d93;stroke-width:0.400612"
+         id="tspan9">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="114.03775"
+       y="196.40289"
+       id="text10"><tspan
+         sodipodi:role="line"
+         x="114.03775"
+         y="196.40289"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ac9d93;stroke-width:0.400612"
+         id="tspan10">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ac9d93;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="366.5202"
+       y="220.80096"
+       id="text11"><tspan
+         sodipodi:role="line"
+         x="366.5202"
+         y="220.80096"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ac9d93;stroke-width:0.400612"
+         id="tspan11">A</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="95.389114"
+       y="196.60231"
+       id="text12"><tspan
+         sodipodi:role="line"
+         x="95.389114"
+         y="196.60231"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan12">B</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="171.62987"
+       y="186.67509"
+       id="text13"><tspan
+         sodipodi:role="line"
+         x="171.62987"
+         y="186.67509"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan13">B</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="358.23288"
+       y="220.44789"
+       id="text14"><tspan
+         sodipodi:role="line"
+         x="358.23288"
+         y="220.44789"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan14">B</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="94.24794"
+       y="208.68309"
+       id="text15"><tspan
+         sodipodi:role="line"
+         x="94.24794"
+         y="208.68309"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#55ddff;stroke-width:0.400612"
+         id="tspan15">C</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="43.869183"
+       y="196.65234"
+       id="text16"><tspan
+         sodipodi:role="line"
+         x="43.869183"
+         y="196.65234"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#55ddff;stroke-width:0.400612"
+         id="tspan16">C</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#00ccff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="188.07849"
+       y="181.51845"
+       id="text17"><tspan
+         sodipodi:role="line"
+         x="188.07849"
+         y="181.51845"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ccff;stroke-width:0.400612"
+         id="tspan17"><tspan
+           style="font-size:4.93889px;fill:#00ccff"
+           id="tspan26">IB</tspan><tspan
+           style="font-size:3.52778px;baseline-shift:sub;fill:#00ccff"
+           id="tspan25">c</tspan></tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="349.12769"
+       y="216.0551"
+       id="text18"><tspan
+         sodipodi:role="line"
+         x="349.12769"
+         y="216.0551"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#55ddff;stroke-width:0.400612"
+         id="tspan18">C</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="43.394695"
+       y="208.58258"
+       id="text19"><tspan
+         sodipodi:role="line"
+         x="43.394695"
+         y="208.58258"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan19">B</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="29.580742"
+       y="220.72212"
+       id="text20"><tspan
+         sodipodi:role="line"
+         x="29.580742"
+         y="220.72212"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan20">B</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="13.045858"
+       y="216.32677"
+       id="text21"><tspan
+         sodipodi:role="line"
+         x="13.045858"
+         y="216.32677"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan21">B</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="21.055231"
+       y="220.72211"
+       id="text22"><tspan
+         sodipodi:role="line"
+         x="21.055231"
+         y="220.72211"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#55ddff;stroke-width:0.400612"
+         id="tspan22">C</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#55ddff;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="179.01208"
+       y="182.54855"
+       id="text23"><tspan
+         sodipodi:role="line"
+         x="179.01208"
+         y="182.54855"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#55ddff;stroke-width:0.400612"
+         id="tspan23">C</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="88.379082"
+       y="185.52925"
+       id="text24"><tspan
+         sodipodi:role="line"
+         x="88.379082"
+         y="185.52925"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan24"><tspan
+           style="font-size:4.93889px;fill:#ff9955"
+           id="tspan28">IB</tspan><tspan
+           style="font-size:3.52778px;baseline-shift:sub;fill:#ff9955"
+           id="tspan27">b</tspan></tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="97.027405"
+       y="163.10979"
+       id="text29"><tspan
+         sodipodi:role="line"
+         x="97.027405"
+         y="163.10979"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ff00;stroke-width:0.400612"
+         id="tspan29">rptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="102.24193"
+       y="229.5128"
+       id="text30"><tspan
+         sodipodi:role="line"
+         x="102.24193"
+         y="229.5128"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.400612"
+         id="tspan30">wptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="116.89307"
+       y="163.58255"
+       id="text31"><tspan
+         sodipodi:role="line"
+         x="116.89307"
+         y="163.58255"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.400612"
+         id="tspan31">wptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="104.55666"
+       y="178.91209"
+       id="text32"><tspan
+         sodipodi:role="line"
+         x="104.55666"
+         y="178.91209"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ff00;stroke-width:0.400612"
+         id="tspan32">rptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="169.33571"
+       y="163.10979"
+       id="text33"><tspan
+         sodipodi:role="line"
+         x="169.33571"
+         y="163.10979"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ff00;stroke-width:0.400612"
+         id="tspan33">rptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="198.10239"
+       y="164.21048"
+       id="text34"><tspan
+         sodipodi:role="line"
+         x="198.10239"
+         y="164.21048"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.400612"
+         id="tspan34">wptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="321.48608"
+       y="209.17052"
+       id="text35"><tspan
+         sodipodi:role="line"
+         x="321.48608"
+         y="209.17052"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff0000;stroke-width:0.400612"
+         id="tspan35">wptr</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.05556px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="381.35901"
+       y="239.92375"
+       id="text36"><tspan
+         sodipodi:role="line"
+         x="381.35901"
+         y="239.92375"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.05556px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#00ff00;stroke-width:0.400612"
+         id="tspan36">rptr</tspan></text>
+    <path
+       style="fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m 35.624746,164.89008 -2.762741,10.3107"
+       id="path80" />
+    <path
+       style="fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m -8.7253214,192.92597 h 10.67442"
+       id="path95" />
+    <path
+       style="fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="M 96.12886,165.61875 92.526458,179.0631"
+       id="path96"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m 99.252771,223.75691 -6.710739,-5.14099"
+       id="path106"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:none;stroke:#00ff00;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m 104.23449,180.8622 v 13.29071 h 4.91861"
+       id="path108"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m 117.92183,166.63928 v 12.97675"
+       id="path109"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m 198.50323,166.63928 v 12.97675"
+       id="path110"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m 169.22285,165.37383 v 13.91861"
+       id="path112"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#00ff00;stroke:#00ff00;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="m 379.21241,233.73729 -9.84194,-9.84195"
+       id="path113"
+       sodipodi:nodetypes="cc" />
+    <path
+       style="fill:#ff0000;stroke:#ff0000;stroke-width:1;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0;marker-end:url(#ArrowWide)"
+       d="M 330.44909,207.68179 H 340.077"
+       id="path114"
+       sodipodi:nodetypes="cc" />
+    <g
+       id="g127"
+       transform="translate(-243.31051,23.087859)">
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:7.76111px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="135.71123"
+         y="112.41485"
+         id="text116"><tspan
+           sodipodi:role="line"
+           x="135.71123"
+           y="112.41485"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+           id="tspan116">PM4<tspan
+   style="font-size:65%;baseline-shift:sub"
+   id="tspan117">1</tspan></tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:7.76111px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="135.39342"
+         y="122.44057"
+         id="text120"><tspan
+           sodipodi:role="line"
+           x="135.39342"
+           y="122.44057"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+           id="tspan120">PM4<tspan
+   style="font-size:65%;baseline-shift:sub"
+   id="tspan123">2</tspan></tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:7.76111px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="135.49934"
+         y="136.68669"
+         id="text122"><tspan
+           sodipodi:role="line"
+           x="135.49934"
+           y="136.68669"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+           id="tspan122">PM4<tspan
+   style="font-size:65%;baseline-shift:sub"
+   id="tspan124">n</tspan></tspan></text>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:7.76111px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="135.65942"
+         y="128.1123"
+         id="text126"><tspan
+           sodipodi:role="line"
+           x="135.65942"
+           y="128.1123"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+           id="tspan126">...</tspan></text>
+      <path
+         style="fill:none;stroke:#0000ff;stroke-width:2;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         d="m 126.12628,103.17346 h -5.32796 v 38.77576 h 5.32796"
+         id="path126"
+         sodipodi:nodetypes="cccc" />
+      <path
+         style="fill:none;stroke:#0000ff;stroke-width:2;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         d="m 143.29418,103.17346 h 5.32796 v 38.77576 h -5.32796"
+         id="path127"
+         sodipodi:nodetypes="cccc" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#ff9955;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="-7.0803289"
+       y="244.43291"
+       id="text129"><tspan
+         sodipodi:role="line"
+         x="-7.0803289"
+         y="244.43291"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#ff9955;stroke-width:0.400612"
+         id="tspan129"><tspan
+           style="font-size:7.05556px;fill:#ff9955"
+           id="tspan127">IB</tspan><tspan
+           style="font-size:3.52778px;baseline-shift:sub;fill:#ff9955"
+           id="tspan128">b</tspan></tspan></text>
+    <g
+       id="g130"
+       transform="translate(-0.5919954,-90.131448)">
+      <rect
+         style="fill:#ffff00;stroke:#ffff00;stroke-width:0.743523;stroke-linecap:square;stroke-dasharray:none;stroke-dashoffset:0"
+         id="rect130"
+         width="16.584557"
+         height="11.616416"
+         x="-21.840757"
+         y="358.62256"
+         ry="0" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-weight:normal;font-size:9.87778px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+         x="-13.612684"
+         y="367.95712"
+         id="text130"><tspan
+           sodipodi:role="line"
+           x="-13.612684"
+           y="367.95712"
+           style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:9.87778px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+           id="tspan130">CP</tspan></text>
+    </g>
+    <path
+       style="fill:none;stroke:#00d4aa;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker132);marker-end:url(#Diamond)"
+       d="M -13.431733,265.14038 V 238.02343 H 76.45484"
+       id="path130"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#00d4aa;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker132);marker-end:url(#Diamond)"
+       d="m -108.62977,169.16297 v 103.37737 h 82.669238"
+       id="path133"
+       sodipodi:nodetypes="ccc" />
+    <path
+       style="fill:none;stroke:#ff0000;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#ArrowTriangleStylized)"
+       d="M -107.14978,120.98926 V -2.5159921 H 176.92597 V 16.131894"
+       id="path134"
+       sodipodi:nodetypes="cccc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="25.324078"
+       y="197.77319"
+       id="text136"><tspan
+         sodipodi:role="line"
+         x="25.324078"
+         y="197.77319"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan136">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="25.324078"
+         y="205.71069"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan137">Buffer</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="76.235764"
+       y="197.77319"
+       id="text139"><tspan
+         sodipodi:role="line"
+         x="76.235764"
+         y="197.77319"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan138">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="76.235764"
+         y="205.71069"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan139">Buffer</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="132.68411"
+       y="197.77319"
+       id="text141"><tspan
+         sodipodi:role="line"
+         x="132.68411"
+         y="197.77319"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan140">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="132.68411"
+         y="205.71069"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan141">Buffer</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="184.18781"
+       y="197.77319"
+       id="text143"><tspan
+         sodipodi:role="line"
+         x="184.18781"
+         y="197.77319"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan142">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="184.18781"
+         y="205.71069"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan143">Buffer</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="235.43346"
+       y="197.77319"
+       id="text147"><tspan
+         sodipodi:role="line"
+         x="235.43346"
+         y="197.77319"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan146">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="235.43346"
+         y="205.71069"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan147">Buffer</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="286.69049"
+       y="197.77319"
+       id="text149"><tspan
+         sodipodi:role="line"
+         x="286.69049"
+         y="197.77319"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan148">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="286.69049"
+         y="205.71069"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan149">Buffer</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:6.35px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="362.16714"
+       y="197.77319"
+       id="text151"><tspan
+         sodipodi:role="line"
+         x="362.16714"
+         y="197.77319"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan150">Ring</tspan><tspan
+         sodipodi:role="line"
+         x="362.16714"
+         y="205.71069"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:6.35px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan151">Buffer</tspan></text>
+    <path
+       style="fill:none;stroke:#917c6f;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 134.065,175.23092 V 125.06784 H 47.638527 V 89.317459"
+       id="path158"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#917c6f;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 365.79312,175.67492 V 125.06784 H 47.447018 V 81.621506"
+       id="path159"
+       sodipodi:nodetypes="cccc" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-weight:normal;font-size:7.76111px;line-height:1.25;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.400612"
+       x="-68.488571"
+       y="250.37801"
+       id="text159"><tspan
+         sodipodi:role="line"
+         x="-68.488571"
+         y="250.37801"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan159">CP is capable of</tspan><tspan
+         sodipodi:role="line"
+         x="-68.488571"
+         y="260.07941"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan160">following the</tspan><tspan
+         sodipodi:role="line"
+         x="-68.488571"
+         y="269.78079"
+         style="font-style:normal;font-variant:normal;font-weight:bold;font-stretch:normal;font-size:7.76111px;font-family:sans-serif;-inkscape-font-specification:'sans-serif Bold';text-align:center;text-anchor:middle;fill:#1c241c;stroke-width:0.400612"
+         id="tspan161">IB address.</tspan></text>
+    <path
+       style="fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 38.977794,178.16115 V 132.60272 H 177.31847 V 80.437513"
+       id="path161"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 76.233608,174.60301 V 132.60272 H 177.31847 V 80.733511"
+       id="path162"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="m 185.48942,174.60301 v -42.00029 h -8.17095 V 81.325508"
+       id="path163"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#ff9955;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 353.76849,176.69603 V 132.60272 H 177.31847 V 82.657499"
+       id="path164"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#55ddff;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 178.37314,176.69603 V 138.67068 H 307.08591 V 81.769505"
+       id="path165"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#55ddff;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="M 84.837713,176.69603 V 138.67068 H 307.08591 V 81.769505"
+       id="path166"
+       sodipodi:nodetypes="cccc" />
+    <path
+       style="fill:none;stroke:#55ddff;stroke-width:1;stroke-linecap:square;stroke-linejoin:miter;stroke-dasharray:none;marker-start:url(#marker154)"
+       d="m 346.50011,180.10001 v -41.42933 h -39.4142 V 81.769505"
+       id="path167"
+       sodipodi:nodetypes="cccc" />
+  </g>
+</svg>
diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amdgpu/userq.rst
index ca3ea71f7888..88f54393b220 100644
--- a/Documentation/gpu/amdgpu/userq.rst
+++ b/Documentation/gpu/amdgpu/userq.rst
@@ -1,3 +1,5 @@
+.. _amdgpu-userq:
+
 ==================
  User Mode Queues
 ==================
-- 
2.51.0

