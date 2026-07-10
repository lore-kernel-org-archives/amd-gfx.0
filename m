Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4D1C44506
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 06:46:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A3A610F797;
	Fri, 10 Jul 2026 06:46:11 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213BC10F797
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:46:10 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-5g_PwdxOOPS3p0ajSRGD5g-1; Fri,
 10 Jul 2026 02:40:00 -0400
X-MC-Unique: 5g_PwdxOOPS3p0ajSRGD5g-1
X-Mimecast-MFC-AGG-ID: 5g_PwdxOOPS3p0ajSRGD5g_1783665600
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E41BE1801376
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:59 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8E45530001A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:58 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] amd/dc/spl: drop unused function.
Date: Fri, 10 Jul 2026 16:37:44 +1000
Message-ID: <20260710063946.2262582-4-airlied@gmail.com>
In-Reply-To: <20260710063946.2262582-1-airlied@gmail.com>
References: <20260710063946.2262582-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U5LSdxr8VwtK1yh62KgApMEIzLPkB587u6iSBMnkk_M_1783665600
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

This function is never called anywhere.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c | 17 -----------------
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h |  2 --
 2 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm=
/amd/display/dc/sspl/dc_spl.c
index d8aebaff7c3f..4e73996e7779 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -1915,20 +1915,3 @@ bool SPL_NAMESPACE(spl_calculate_scaler_params(struc=
t spl_in *spl_in, struct spl
=20
 =09return res;
 }
-
-/* External interface to get number of taps only */
-bool SPL_NAMESPACE(spl_get_number_of_taps(struct spl_in *spl_in, struct sp=
l_out *spl_out))
-{
-=09bool res =3D false;
-=09bool enable_easf_v =3D false;
-=09bool enable_easf_h =3D false;
-=09bool enable_isharp =3D false;
-=09struct spl_scratch spl_scratch;
-=09struct dscl_prog_data *dscl_prog_data =3D spl_out->dscl_prog_data;
-=09const struct spl_scaler_data *data =3D &spl_scratch.scl_data;
-
-=09res =3D spl_calculate_number_of_taps(spl_in, &spl_scratch, spl_out,
-=09=09&enable_easf_v, &enable_easf_h, &enable_isharp);
-=09spl_set_taps_data(dscl_prog_data, data);
-=09return res;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h b/drivers/gpu/drm=
/amd/display/dc/sspl/dc_spl.h
index f9503c368db5..a53a2c1f5508 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.h
@@ -14,6 +14,4 @@
=20
 bool SPL_NAMESPACE(spl_calculate_scaler_params(struct spl_in *spl_in, stru=
ct spl_out *spl_out));
=20
-bool SPL_NAMESPACE(spl_get_number_of_taps(struct spl_in *spl_in, struct sp=
l_out *spl_out));
-
 #endif /* __DC_SPL_H__ */
--=20
2.54.0

