From: "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH] drm/amd/powerplay: remove variable 'result' set but not
 used
Date: Mon, 18 Nov 2019 06:50:58 +0000
Message-ID: <MN2PR12MB3344A9DA952F41ADDAD6142AE44D0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573875799-83572-1-git-send-email-chenwandun@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Wandun <chenwandun@huawei.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Thanks. But it's better to return the 'result' out on 'result !=3D 0'.

Regards,
Evan
-----Original Message-----
From: Chen Wandun <chenwandun@huawei.com>=20
Sent: Saturday, November 16, 2019 11:43 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@a=
md.com>; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; li=
nux-kernel@vger.kernel.org
Cc: chenwandun@huawei.com
Subject: [PATCH] drm/amd/powerplay: remove variable 'result' set but not us=
ed

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c: In function =
vegam_populate_smc_boot_level:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/vegam_smumgr.c:1364:6: warni=
ng: variable result set but not used [-Wunused-but-set-variable]

Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2068eb0..fad78bf 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -1361,20 +1361,19 @@ static int vegam_populate_smc_uvd_level(struct pp_h=
wmgr *hwmgr,
 static int vegam_populate_smc_boot_level(struct pp_hwmgr *hwmgr,
 		struct SMU75_Discrete_DpmTable *table)
 {
-	int result =3D 0;
 	struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend);
=20
 	table->GraphicsBootLevel =3D 0;
 	table->MemoryBootLevel =3D 0;
=20
 	/* find boot level from dpm table */
-	result =3D phm_find_boot_level(&(data->dpm_table.sclk_table),
-			data->vbios_boot_state.sclk_bootup_value,
-			(uint32_t *)&(table->GraphicsBootLevel));
+	phm_find_boot_level(&(data->dpm_table.sclk_table),
+			    data->vbios_boot_state.sclk_bootup_value,
+			    (uint32_t *)&(table->GraphicsBootLevel));
=20
-	result =3D phm_find_boot_level(&(data->dpm_table.mclk_table),
-			data->vbios_boot_state.mclk_bootup_value,
-			(uint32_t *)&(table->MemoryBootLevel));
+	phm_find_boot_level(&(data->dpm_table.mclk_table),
+			    data->vbios_boot_state.mclk_bootup_value,
+			    (uint32_t *)&(table->MemoryBootLevel));
=20
 	table->BootVddc  =3D data->vbios_boot_state.vddc_bootup_value *
 			VOLTAGE_SCALE;
--=20
2.7.4
