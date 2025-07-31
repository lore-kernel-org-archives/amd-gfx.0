Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03C5C87FCC
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAF410E74E;
	Thu, 31 Jul 2025 09:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HrJChgH7";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F7110E749
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:23 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4589180b266so3596755e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955061; x=1754559861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQZ3amjLKGDO7/cq361c3mlJi7gMn+7mhQ1BW/Klo8Y=;
 b=HrJChgH786AENRHbM+Illv1jys05aGZqKRnP1vHlUgu6/OFQodYOkeYh/Dhe/3MbAz
 /bmyV6NHEqcyuCiqY5B8qUd5rkH428CwqcxViQiCzO039U+7Jf7Z2/RZnjYXKGzbtiRo
 3elgP+BNiulPQnbep1j9bWmXamx3+2I7d74pI/IBzp1oa0rxWWy4VdheetveXzT/PkT5
 B+02uuscUtf1VTNBvdmDLsINhIRV+hEjAj1cRsKdcFZaUqlTEXD/pBromvKRygDNEN0X
 MwM8WEGGkg49QSwvZcPfT1hwMPTdij2hbo1uQiO7WgCyP05gJigOCU75ztYyy8vgLs7W
 C5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955061; x=1754559861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQZ3amjLKGDO7/cq361c3mlJi7gMn+7mhQ1BW/Klo8Y=;
 b=N3te10c8BYnrT8PbqWhyhOVek2+LS0eoTDIUpW2f0q0ckDOeUKfsXNguS2o6c1/iqw
 VrpQhIE8H6I4qQaYcRFLcNHJtVnl5/Uxb+guQQwrqU+EIZW5j2RliQ4SAkc+JSMIB6qe
 fxkl+kPeMB4MiE8k5sJzQlGm21ukk8SIke84XAiaekOhnePK5yxisH6Qp/pi0wXIKQDw
 p4k9Q9I9eafldScQVMCa8zs0CC0BxETm+X6ld4lApOj3pUfirufmJ03nCFiktWKTf3SN
 qvBC1G4EcYcRIo0zqZabgtZC2XqTRaldMJjsBVC8wBX0oZZnhEf4Q/L1rvCgJpgBt2c2
 Useg==
X-Gm-Message-State: AOJu0YyYvhCKwRwkzf8s9BfQMNivFooUDUzTwB6wSHhUzBmwmJYOE037
 /YD0J95aWQKnlMHoiAdoV/U4bWYsFGurybNvPraB7I8TQBO0ZsTWFhrmqd1i5w==
X-Gm-Gg: ASbGnctvqCxZiAc9I0GIZdZ7GFi31k5KhfmX9Ej8xYDB8LJR8++0n6KMD+zouvC28/a
 /ikxAANeASCABkPHF/rzMXzhOhhoCcq6Ckz+xvsjM5x3TW7fQaZTnAEd+MDLr+xUis42kxU3DWV
 EGPk97nC9ZY4lsVGr0oaI7GBbtWJrQ3XFrgsPo3XSfSynuB3OHI6221B4mXoW+ip9Hhxk8mn4pk
 y56URysj1wtZXd4s32kJ4TlqTTene671PedPyj2sW/9fgJJPBV/YatXLwAGkkLmxKNNwhuj5Mj6
 qKSJz7Lr/rAl4OoKoipS2MADSBl5QXXQVbz1C6kCtH8BBhOEj+MRaah4oBEqaDw5QBqjxbv0JE7
 Ze4bWssN4rQ1rEqg8HKX4zo5G9jXH88DWV181TPPmOm43BqhmHrjazNA5B5grq0MTlaGtnEmL/E
 CgwFuI3x/kK1W8SXBETTE=
X-Google-Smtp-Source: AGHT+IEvzU+zdVIO7juH2RzoFLWOe8WePU4n955XiDe6ckkONAQhGy8rPMmvEj6+mLZgrpsSMSDCOw==
X-Received: by 2002:a05:600c:c1d7:10b0:450:d386:1afb with SMTP id
 5b1f17b1804b1-45892d5e314mr45245955e9.9.1753955061487; 
 Thu, 31 Jul 2025 02:44:21 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:20 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/7] drm/amd/display: Don't print errors for nonexistent
 connectors
Date: Thu, 31 Jul 2025 11:43:51 +0200
Message-ID: <20250731094352.29528-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
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

When getting the number of connectors, the VBIOS reports
the number of valid indices, but it doesn't say which indices
are valid, and not every valid index has an actual connector.
If we don't find a connector on an index, that is not an error.

Considering these are not actual errors, don't litter the logs.

Fixes: 60df5628144b ("drm/amd/display: handle invalid connector indices")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c |  5 +----
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 67f08495b7e6..154fd2c18e88 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -174,11 +174,8 @@ static struct graphics_object_id bios_parser_get_connector_id(
 		return object_id;
 	}
 
-	if (tbl->ucNumberOfObjects <= i) {
-		dm_error("Can't find connector id %d in connector table of size %d.\n",
-			 i, tbl->ucNumberOfObjects);
+	if (tbl->ucNumberOfObjects <= i)
 		return object_id;
-	}
 
 	id = le16_to_cpu(tbl->asObjects[i].usObjectID);
 	object_id = object_id_from_bios_object_id(id);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index cf3893a2f8ce..33d6a5116aad 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -217,11 +217,24 @@ static bool create_links(
 		connectors_num,
 		num_virtual_links);
 
-	// condition loop on link_count to allow skipping invalid indices
+	/* When getting the number of connectors, the VBIOS reports the number of valid indices,
+	 * but it doesn't say which indices are valid, and not every index has an actual connector.
+	 * So, if we don't find a connector on an index, that is not an error.
+	 *
+	 * - There is no guarantee that the first N indices will be valid
+	 * - VBIOS may report a higher amount of valid indices than there are actual connectors
+	 * - Some VBIOS have valid configurations for more connectors than there actually are
+	 *   on the card. This may be because the manufacturer used the same VBIOS for different
+	 *   variants of the same card.
+	 */
 	for (i = 0; dc->link_count < connectors_num && i < MAX_LINKS; i++) {
+		struct graphics_object_id connector_id = bios->funcs->get_connector_id(bios, i);
 		struct link_init_data link_init_params = {0};
 		struct dc_link *link;
 
+		if (connector_id.id == CONNECTOR_ID_UNKNOWN)
+			continue;
+
 		DC_LOG_DC("BIOS object table - printing link object info for connector number: %d, link_index: %d", i, dc->link_count);
 
 		link_init_params.ctx = dc->ctx;
-- 
2.50.1

