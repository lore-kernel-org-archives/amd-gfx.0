Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774D7C19F32
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 12:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0909C10E384;
	Thu, 27 Feb 2025 12:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VBLvtYt8";
	dkim-atps=neutral
X-Greylist: delayed 553 seconds by postgrey-1.36 at gabe;
 Thu, 27 Feb 2025 12:55:11 UTC
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B431710E1C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 12:55:10 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2174A3F1D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740660357;
 bh=C+LUjjJjvbxAVjdPqXl5mWLZXkJQ1FxPBQM+o8DtSTg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VBLvtYt8cgFe46jyufz22+MXRLDbDqNJjuvcSHOS+5vxvvKC9ik6MhuQTXF3pRyzC
 Vd3pQnZT+0QU7M3VSXgkrIqo2T0bAZ2lV3z3gE6fpyLbovpSvXqYVbruJ1XTXTbuhm
 zp1rWSOtb+J4Ur/3ThIdIwKraAyPIMbnrzViAFMjPQdvnQoWYvYR4IfDzAXD8naJ83
 Q78Rq1H+82Qk3hVAS4srjgS1XTT0dFhInogXTSdWgZl/g2CAEdTNdb3yv+d7JUwKxM
 cqStr3Jw+n4TSrV6a/qX7i6uwcBR5GDKx6+Kq8eUXl/BjsxdRK8WcTpz9yFMOGNoIJ
 xxzWY/lqt6tLQ==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4398e841963so6307405e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 04:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740660356; x=1741265156;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+LUjjJjvbxAVjdPqXl5mWLZXkJQ1FxPBQM+o8DtSTg=;
 b=SglfGXuc+GX9YWfRge/nTbMAzpZibkg6qWGev+PvwPzAA7b7atBNcYFjZ69li3qRrB
 WkEHMyoMg+TnY8DNU/0mQil/PEv17a6o/CwaCx0vS/wqrGf1fC5bCq+vdYWjYaLPsODr
 vDuPjlasutNY52r9oXCAsofojiXGqJmXGps4XxvGA4DzpQlzW59R0XT67R1Lm9LprSdG
 wKwGiUG/JBbub7FJQlS4rvB29cAKDSoQgMXRY2sMkQHGrFYt84oTkO826bZlC7MoVq/w
 000P1ShPnBIb2yR19dTUuOE4UDK/zzuatvj0aXpD9THSHVx2yeG7z610DFKbwKo14zEj
 7RUQ==
X-Gm-Message-State: AOJu0YygBTeJsO+LLMQRWnpygbsRZbMTcyKWzGQUR3LbRdWHb8ZUUaqX
 jH63Csb1rubxNYvljqPTS2v9ra0rKYMa/SKQ4BIKQ6XUy9PS9XdutEu0TlUCHh17Ue6cKyvnAEg
 w04susSt2UkKoGbk6SlgT7/EL9ESuLSaNggknKS7dbWkdjx3NssdPIhI1EhfyL6ocp8hlb8/OTy
 shf74yPla6QXSGww==
X-Gm-Gg: ASbGnctTfBnWhUdwDvh7N4J/GcWVddK81bjpk356+rgdSlanlkTQVRPfj7KIJB2KuuO
 nbJlpDZ14u9eUiDhtO9kEdxoCnvku1/JOxOD5SZTvrOI9ClJ7TsPsN9GqXeInqypYnEalTPfank
 njbl0bK8xtngZNAG011mg9b3nwr95ju41iEYSHXVzAdiVIczo8SOfqZXkz877+0nYFcpWzeSa5A
 vZBCHYjsCXwnF5UJnBKlNdCaATJVxdjdgTIpdn1CN0UnAWplBf+PEJWUbgTNi4MbZKeWEuegmnh
 pZtpm3Ubcf7XE7+lqIeBPZMD14zQSEn7g+QqBpYLL77kqnvoAUOhibFwK0QtY5kk
X-Received: by 2002:a05:600c:1c04:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-439aeae1c10mr209658765e9.3.1740660356554; 
 Thu, 27 Feb 2025 04:45:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUjfXwHAgsHNFqwaN5kQWlaOfemVXiCuoAyCXg1pKUXqur1TVcL+TFU6mD/i0uyws05OoBzg==
X-Received: by 2002:a05:600c:1c04:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-439aeae1c10mr209658615e9.3.1740660356112; 
 Thu, 27 Feb 2025 04:45:56 -0800 (PST)
Received: from localhost (159.red-83-37-10.dynamicip.rima-tde.net.
 [83.37.10.159]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b736f74f3sm22765585e9.8.2025.02.27.04.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:45:55 -0800 (PST)
From: Sergio Costas Rodriguez <sergio.costas@canonical.com>
To: amd-gfx@lists.freedesktop.org
Cc: Sergio Costas Rodriguez <sergio.costas@canonical.com>
Subject: [PATCH] amdgpu: add env support for amdgpu.ids path
Date: Thu, 27 Feb 2025 13:45:51 +0100
Message-ID: <20250227124551.560315-1-sergio.costas@canonical.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
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

In some cases, like when building a Snap application that uses
libdrm, the `amdgpu.ids` file isn't directly available at the
compiling place, but inside a mounted folder. This forces each
application to link/bind the file from the current place
(usually at the $SNAP/gnome-platform/usr/share/libdrm/amdgpu.ids)
which is cumbersome.

This patch allows to set an environment variable, called
AMDGPU_ASIC_ID_TABLE_PATH, where the file will be also searched
if it isn't located in the default, meson-configured, path.

This patch is also available in the MESA gitlab:
https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/273
---
 README.rst              |  9 +++++++++
 amdgpu/amdgpu_asic_id.c | 14 ++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/README.rst b/README.rst
index 74608031..6532c12f 100644
--- a/README.rst
+++ b/README.rst
@@ -49,3 +49,12 @@ Then use ninja to build and install:
 
 If you are installing into a system location you will need to run install
 separately, and as root.
+
+AMDGPU ASIC table file
+----------------------
+
+The AMDGPU driver requires the `amdgpu.ids` file. It is usually located at
+`$PREFIX/share/libdrm`, but it is possible to specify an alternative path
+during runtime by setting the `AMDGPU_ASIC_ID_TABLE_PATH` environment
+variable with the full path (including the file name) of the alternative
+file.
diff --git a/amdgpu/amdgpu_asic_id.c b/amdgpu/amdgpu_asic_id.c
index a5007ffc..81a7cf7f 100644
--- a/amdgpu/amdgpu_asic_id.c
+++ b/amdgpu/amdgpu_asic_id.c
@@ -112,10 +112,16 @@ void amdgpu_parse_asic_ids(struct amdgpu_device *dev)
 	ssize_t n;
 	int line_num = 1;
 	int r = 0;
+	const char *amdgpu_asic_id_table_path = getenv("AMDGPU_ASIC_ID_TABLE_PATH");
+
+	if (amdgpu_asic_id_table_path == NULL || amdgpu_asic_id_table_path[0] == '\0') {
+		amdgpu_asic_id_table_path = AMDGPU_ASIC_ID_TABLE;
+	}
+
+	fp = fopen(amdgpu_asic_id_table_path, "r");
 
-	fp = fopen(AMDGPU_ASIC_ID_TABLE, "r");
 	if (!fp) {
-		fprintf(stderr, "%s: %s\n", AMDGPU_ASIC_ID_TABLE,
+		fprintf(stderr, "%s: %s\n", amdgpu_asic_id_table_path,
 			strerror(errno));
 		return;
 	}
@@ -132,7 +138,7 @@ void amdgpu_parse_asic_ids(struct amdgpu_device *dev)
 			continue;
 		}
 
-		drmMsg("%s version: %s\n", AMDGPU_ASIC_ID_TABLE, line);
+		drmMsg("%s version: %s\n", amdgpu_asic_id_table_path, line);
 		break;
 	}
 
@@ -150,7 +156,7 @@ void amdgpu_parse_asic_ids(struct amdgpu_device *dev)
 
 	if (r == -EINVAL) {
 		fprintf(stderr, "Invalid format: %s: line %d: %s\n",
-			AMDGPU_ASIC_ID_TABLE, line_num, line);
+			amdgpu_asic_id_table_path, line_num, line);
 	} else if (r && r != -EAGAIN) {
 		fprintf(stderr, "%s: Cannot parse ASIC IDs: %s\n",
 			__func__, strerror(-r));
-- 
2.45.2

