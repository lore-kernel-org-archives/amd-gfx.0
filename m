Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B719C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 06:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2EB10E137;
	Fri, 10 Jul 2026 06:46:21 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945F310E137
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:46:19 +0000 (UTC)
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-oplh1GaGMxGlAtAhTQJOTQ-1; Fri,
 10 Jul 2026 02:39:55 -0400
X-MC-Unique: oplh1GaGMxGlAtAhTQJOTQ-1
X-Mimecast-MFC-AGG-ID: oplh1GaGMxGlAtAhTQJOTQ_1783665595
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EB14195605F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:55 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEFF630001A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:53 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] amd/dc: move custom_float definition into custom_float.h
Date: Fri, 10 Jul 2026 16:37:42 +1000
Message-ID: <20260710063946.2262582-2-airlied@gmail.com>
In-Reply-To: <20260710063946.2262582-1-airlied@gmail.com>
References: <20260710063946.2262582-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iVux5ozFNI7FUsTo4NZ2GLtBaywNy0qHilcm7YXQ3Is_1783665595
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
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

From: Dave Airlie <airlied@redhat.com>

Drop the unused custom_float_value and the spl one.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/inc/custom_float.h   |  7 ++++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h         | 13 -------------
 .../gpu/drm/amd/display/dc/sspl/spl_custom_float.h  |  7 -------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/custom_float.h b/drivers/gp=
u/drm/amd/display/dc/inc/custom_float.h
index f57239672216..c408fee8e181 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/custom_float.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/custom_float.h
@@ -28,7 +28,12 @@
=20
 #include "bw_fixed.h"
 #include "hw_shared.h"
-#include "opp.h"
+
+struct custom_float_format {
+        uint32_t mantissa_bits;
+        uint32_t exponenta_bits;
+        bool sign;
+};
=20
=20
 bool convert_to_custom_float_format(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/=
amd/display/dc/inc/hw/opp.h
index 73cc34ea7726..ce30eab16f86 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -142,19 +142,6 @@ enum channel_name {
 =09CHANNEL_NAME_BLUE
 };
=20
-struct custom_float_format {
-=09uint32_t mantissa_bits;
-=09uint32_t exponenta_bits;
-=09bool sign;
-};
-
-struct custom_float_value {
-=09uint32_t mantissa;
-=09uint32_t exponenta;
-=09uint32_t value;
-=09bool negative;
-};
-
 struct hw_x_point {
 =09uint32_t custom_float_x;
 =09struct fixed31_32 x;
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h b/drive=
rs/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
index f3fd8d30e638..60620537ae3e 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
@@ -14,13 +14,6 @@ struct spl_custom_float_format {
 =09bool sign;
 };
=20
-struct spl_custom_float_value {
-=09uint32_t mantissa;
-=09uint32_t exponenta;
-=09uint32_t value;
-=09bool negative;
-};
-
 bool SPL_NAMESPACE(spl_convert_to_custom_float_format(
 =09struct spl_fixed31_32 value,
 =09const struct spl_custom_float_format *format,
--=20
2.54.0

