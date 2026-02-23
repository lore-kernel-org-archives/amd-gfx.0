Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E65EFB819
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E3E10E508;
	Tue, 24 Feb 2026 08:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="ezrkiXfh";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059F910E3BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1771855877; x=1772460677; i=natalie.vock@gmx.de;
 bh=Cf58QLg/IunshNLzv50lDvwyhWMMdOdvRkYNUMc2x/4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ezrkiXfhNzCMzliANrFvamP+99BjhsJdO7m+jUxW+nqBYo3QXmP5+MEkmJVhQPTa
 5A7zBHomna4mqiZXlmVi8KWjVg3GPNz3/h7m1EnRwWGldNcqeeFB+i3HFNVe8kUag
 etQbQSuq7ez47sE1+DfZGDhA6Mzu7gEYP3+R7IIN/hm8y2Az9eg9On0b7WLxSBpWg
 3r/aTzqi6jB37BhNUZvVKREM9slDWPP3pcSI0gt7l73BftH1N/DvoNoIp4bebGgNr
 Efr6kZ1VU/ByeZ27ZdKLEJ/jPcfaA4j18L3Wv2QqkkY8benx7DsOuenUY3wKAJhnn
 LXCcLHcjmRZbN6I46w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rizzler.fritz.box ([88.133.252.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1w02t928L6-00CWGo; Mon, 23
 Feb 2026 15:06:07 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Ray Wu <ray.wu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Fix OOB EDID access
Date: Mon, 23 Feb 2026 15:05:45 +0100
Message-ID: <20260223140545.9640-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYsvONyK7ts5InQKmbv9xKBBEVPSJq8Vdxogo2i1w85lhwDMZI/
 cBK6ddJ13dPDMYLMkj5ERAbNFm5yl8qyL55LEvk8W90mnugP1WocJdKrcVESu8FhzTOfnkk
 CbNgVJDNRYp9PA1W+PtrP2x0sVpsY1YaJgWkIUYc6YbH1lZECkKLnSQ4VqOcY54nD004fYi
 AD4SChW4h8v2pkUm/aAGg==
UI-OutboundReport: notjunk:1;M01:P0:czPOTP2wBXI=;F5IH4TnQrplXbztfNEOW83Qv3/5
 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
 ZX5TRNxiniBiNdMQH8iCwncuoRQRm4JUTBmZz2
X-Mailman-Approved-At: Tue, 24 Feb 2026 08:33:26 +0000
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

Commit 67bc09daa8fc ("drm/amd/display: Parse all extension blocks for VSDB=
")
changed the extension block parser from going over just one block to
reading up to as many blocks as specified in edid->extensions.

This is quite obviously broken because the loop directly above goes over
the extension blocks already and filters for the first DisplayID
extension block, so edid_ext might point to any random block, perhaps
even the very last block. Reading edid->extensions * EDID_LENGTH bytes
from here will almost certainly go out-of-bounds.

I suspect the intention was instead to look at all DisplayID blocks in
the EDID, which is what this patch implements.

This is not tagged with Cc: stable because AFAICS the offending commit
didn't make it to any stable PR yet.

Fixes: 67bc09daa8fc ("drm/amd/display: Parse all extension blocks for VSDB=
")

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 50a10b4fbb3ff..128a262068ec2 100644
=2D-- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13093,7 +13093,6 @@ static int parse_amd_vsdb(struct amdgpu_dm_connect=
or *aconnector,
 	u8 *edid_ext =3D NULL;
 	int i;
 	int j =3D 0;
-	int total_ext_block_len;
=20
 	if (edid =3D=3D NULL || edid->extensions =3D=3D 0)
 		return -ENODEV;
@@ -13101,17 +13100,21 @@ static int parse_amd_vsdb(struct amdgpu_dm_conne=
ctor *aconnector,
 	/* Find DisplayID extension */
 	for (i =3D 0; i < edid->extensions; i++) {
 		edid_ext =3D (void *)(edid + (i + 1));
-		if (edid_ext[0] =3D=3D DISPLAYID_EXT)
-			break;
-	}
+		if (edid_ext[0] !=3D DISPLAYID_EXT)
+			continue;
=20
-	total_ext_block_len =3D EDID_LENGTH * edid->extensions;
-	while (j < total_ext_block_len - sizeof(struct amd_vsdb_block)) {
-		struct amd_vsdb_block *amd_vsdb =3D (struct amd_vsdb_block *)&edid_ext[=
j];
-		unsigned int ieeeId =3D (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee_=
id[1] << 8) | (amd_vsdb->ieee_id[0]);
+		j =3D 0;
+		while (j < EDID_LENGTH - sizeof(struct amd_vsdb_block)) {
+			struct amd_vsdb_block *amd_vsdb =3D (struct amd_vsdb_block *)&edid_ext=
[j];
+			unsigned int ieeeId =3D (amd_vsdb->ieee_id[2] << 16) | (amd_vsdb->ieee=
_id[1] << 8) |
+				(amd_vsdb->ieee_id[0]);
+
+			if (ieeeId !=3D HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION_=
ID ||
+					amd_vsdb->version !=3D HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_3=
) {
+				j++;
+				continue;
+			}
=20
-		if (ieeeId =3D=3D HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_IEEE_REGISTRATION=
_ID &&
-				amd_vsdb->version =3D=3D HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VERSION_=
3) {
 			u8 panel_type;
 			vsdb_info->replay_mode =3D (amd_vsdb->feature_caps & AMD_VSDB_VERSION_=
3_FEATURECAP_REPLAYMODE) ? true : false;
 			vsdb_info->amd_vsdb_version =3D HDMI_AMD_VENDOR_SPECIFIC_DATA_BLOCK_VE=
RSION_3;
@@ -13133,7 +13136,6 @@ static int parse_amd_vsdb(struct amdgpu_dm_connect=
or *aconnector,
=20
 			return true;
 		}
-		j++;
 	}
=20
 	return false;
=2D-=20
2.53.0

