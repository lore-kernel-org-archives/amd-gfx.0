From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/amd/powerplay: Delete a redundant memory setting in
 vega20_set_default_od8_setttings()
Date: Mon, 17 Jun 2019 14:34:15 +0200
Message-ID: <de3f6a5e-8ac4-bc8e-0d0c-3a4a5db283e9@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Evan Quan <evan.quan@amd.com>, Rex Zhu <rex.zhu@amd.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 17 Jun 2019 14:24:14 +0200

The memory was set to zero already by a call of the function =E2=80=9Ckzal=
loc=E2=80=9D.
Thus remove an extra call of the function =E2=80=9Cmemset=E2=80=9D for thi=
s purpose.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/=
amd/powerplay/vega20_ppt.c
index 4aa8f5a69c4c..62497ad66a39 100644
=2D-- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -1295,7 +1295,6 @@ static int vega20_set_default_od8_setttings(struct s=
mu_context *smu)
 	if (!table_context->od8_settings)
 		return -ENOMEM;

-	memset(table_context->od8_settings, 0, sizeof(struct vega20_od8_settings=
));
 	od8_settings =3D (struct vega20_od8_settings *)table_context->od8_settin=
gs;

 	if (smu_feature_is_enabled(smu, FEATURE_DPM_SOCCLK_BIT)) {
=2D-
2.22.0
