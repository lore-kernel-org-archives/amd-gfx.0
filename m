From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Add new asic(vega12) support in pp_psm.c
Date: Wed, 21 Mar 2018 13:33:50 +0000
Message-ID: <BN6PR12MB180959F999425BD7F8741E79F7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1521632074-17444-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0282020664=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521632074-17444-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0282020664==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180959F999425BD7F8741E79F7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB180959F999425BD7F8741E79F7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, March 21, 2018 7:34:34 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amd/pp: Add new asic(vega12) support in pp_psm.c

In new asics, no power state management in driver,
no need to implement related callback functions.
add some ps checks in pp_psm.c

Revert "drm/amd/powerplay: add new pp_psm infrastructure for vega12 (v2)"
This reverts commit 7d1a63f3aa331b853e41f92d0e7890ed31de8c13.

Change-Id: Ic31d3f475f94399d3136bff8be454f290e3c1e50
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/Makefile       |   4 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c       | 270 +++++++++++++++++=
+---
 .../gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c    | 262 -----------------=
---
 .../gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h    |  40 ---
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c   |  76 ------
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h   |  40 ---
 6 files changed, 239 insertions(+), 453 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c
 delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile b/drivers/gpu/drm=
/amd/powerplay/hwmgr/Makefile
index 9446dbc475..faf9c88 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile
@@ -31,9 +31,9 @@ HARDWARE_MGR =3D hwmgr.o processpptables.o \
                 smu7_clockpowergating.o \
                 vega10_processpptables.o vega10_hwmgr.o vega10_powertune.o=
 \
                 vega10_thermal.o smu10_hwmgr.o pp_psm.o\
-               pp_overdriver.o smu_helper.o pp_psm_legacy.o pp_psm_new.o \
                 vega12_processpptables.o vega12_hwmgr.o \
-               vega12_powertune.o vega12_thermal.o
+               vega12_powertune.o vega12_thermal.o \
+               pp_overdriver.o smu_helper.o

 AMD_PP_HWMGR =3D $(addprefix $(AMD_PP_PATH)/hwmgr/,$(HARDWARE_MGR))

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm=
/amd/powerplay/hwmgr/pp_psm.c
index 295ab9f..0f2851b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
@@ -21,65 +21,269 @@
  *
  */

+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
 #include "pp_psm.h"
-#include "pp_psm_legacy.h"
-#include "pp_psm_new.h"

 int psm_init_power_state_table(struct pp_hwmgr *hwmgr)
 {
-       if (hwmgr->chip_id !=3D CHIP_VEGA12)
-               return psm_legacy_init_power_state_table(hwmgr);
-       else
-               return psm_new_init_power_state_table(hwmgr);
+       int result;
+       unsigned int i;
+       unsigned int table_entries;
+       struct pp_power_state *state;
+       int size;
+
+       if (hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D=3D NULL)
+               return 0;
+
+       if (hwmgr->hwmgr_func->get_power_state_size =3D=3D NULL)
+               return 0;
+
+       hwmgr->num_ps =3D table_entries =3D hwmgr->hwmgr_func->get_num_of_p=
p_table_entries(hwmgr);
+
+       hwmgr->ps_size =3D size =3D hwmgr->hwmgr_func->get_power_state_size=
(hwmgr) +
+                                         sizeof(struct pp_power_state);
+
+       if (table_entries =3D=3D 0 || size =3D=3D 0) {
+               pr_warn("Please check whether power state management is sup=
pported on this asic\n");
+               return 0;
+       }
+
+       hwmgr->ps =3D kzalloc(size * table_entries, GFP_KERNEL);
+       if (hwmgr->ps =3D=3D NULL)
+               return -ENOMEM;
+
+       hwmgr->request_ps =3D kzalloc(size, GFP_KERNEL);
+       if (hwmgr->request_ps =3D=3D NULL) {
+               kfree(hwmgr->ps);
+               hwmgr->ps =3D NULL;
+               return -ENOMEM;
+       }
+
+       hwmgr->current_ps =3D kzalloc(size, GFP_KERNEL);
+       if (hwmgr->current_ps =3D=3D NULL) {
+               kfree(hwmgr->request_ps);
+               kfree(hwmgr->ps);
+               hwmgr->request_ps =3D NULL;
+               hwmgr->ps =3D NULL;
+               return -ENOMEM;
+       }
+
+       state =3D hwmgr->ps;
+
+       for (i =3D 0; i < table_entries; i++) {
+               result =3D hwmgr->hwmgr_func->get_pp_table_entry(hwmgr, i, =
state);
+
+               if (state->classification.flags & PP_StateClassificationFla=
g_Boot) {
+                       hwmgr->boot_ps =3D state;
+                       memcpy(hwmgr->current_ps, state, size);
+                       memcpy(hwmgr->request_ps, state, size);
+               }
+
+               state->id =3D i + 1; /* assigned unique num for every power=
 state id */
+
+               if (state->classification.flags & PP_StateClassificationFla=
g_Uvd)
+                       hwmgr->uvd_ps =3D state;
+               state =3D (struct pp_power_state *)((unsigned long)state + =
size);
+       }
+
+       return 0;
 }

 int psm_fini_power_state_table(struct pp_hwmgr *hwmgr)
 {
-       if (hwmgr->chip_id !=3D CHIP_VEGA12)
-               return psm_legacy_fini_power_state_table(hwmgr);
-       else
-               return psm_new_fini_power_state_table(hwmgr);
+       if (hwmgr =3D=3D NULL)
+               return -EINVAL;
+
+       if (!hwmgr->ps)
+               return 0;
+
+       kfree(hwmgr->current_ps);
+       kfree(hwmgr->request_ps);
+       kfree(hwmgr->ps);
+       hwmgr->request_ps =3D NULL;
+       hwmgr->ps =3D NULL;
+       hwmgr->current_ps =3D NULL;
+       return 0;
+}
+
+static int psm_get_ui_state(struct pp_hwmgr *hwmgr,
+                               enum PP_StateUILabel ui_label,
+                               unsigned long *state_id)
+{
+       struct pp_power_state *state;
+       int table_entries;
+       int i;
+
+       table_entries =3D hwmgr->num_ps;
+       state =3D hwmgr->ps;
+
+       for (i =3D 0; i < table_entries; i++) {
+               if (state->classification.ui_label & ui_label) {
+                       *state_id =3D state->id;
+                       return 0;
+               }
+               state =3D (struct pp_power_state *)((unsigned long)state + =
hwmgr->ps_size);
+       }
+       return -EINVAL;
+}
+
+static int psm_get_state_by_classification(struct pp_hwmgr *hwmgr,
+                                       enum PP_StateClassificationFlag fla=
g,
+                                       unsigned long *state_id)
+{
+       struct pp_power_state *state;
+       int table_entries;
+       int i;
+
+       table_entries =3D hwmgr->num_ps;
+       state =3D hwmgr->ps;
+
+       for (i =3D 0; i < table_entries; i++) {
+               if (state->classification.flags & flag) {
+                       *state_id =3D state->id;
+                       return 0;
+               }
+               state =3D (struct pp_power_state *)((unsigned long)state + =
hwmgr->ps_size);
+       }
+       return -EINVAL;
+}
+
+static int psm_set_states(struct pp_hwmgr *hwmgr, unsigned long state_id)
+{
+       struct pp_power_state *state;
+       int table_entries;
+       int i;
+
+       table_entries =3D hwmgr->num_ps;
+
+       state =3D hwmgr->ps;
+
+       for (i =3D 0; i < table_entries; i++) {
+               if (state->id =3D=3D state_id) {
+                       memcpy(hwmgr->request_ps, state, hwmgr->ps_size);
+                       return 0;
+               }
+               state =3D (struct pp_power_state *)((unsigned long)state + =
hwmgr->ps_size);
+       }
+       return -EINVAL;
 }

 int psm_set_boot_states(struct pp_hwmgr *hwmgr)
 {
-       if (hwmgr->chip_id !=3D CHIP_VEGA12)
-               return psm_legacy_set_boot_states(hwmgr);
-       else
-               return psm_new_set_boot_states(hwmgr);
+       unsigned long state_id;
+       int ret =3D -EINVAL;
+
+       if (!hwmgr->ps)
+               return 0;
+
+       if (!psm_get_state_by_classification(hwmgr, PP_StateClassificationF=
lag_Boot,
+                                       &state_id))
+               ret =3D psm_set_states(hwmgr, state_id);
+
+       return ret;
 }

 int psm_set_performance_states(struct pp_hwmgr *hwmgr)
 {
-       if (hwmgr->chip_id !=3D CHIP_VEGA12)
-               return psm_legacy_set_performance_states(hwmgr);
-       else
-               return psm_new_set_performance_states(hwmgr);
+       unsigned long state_id;
+       int ret =3D -EINVAL;
+
+       if (!hwmgr->ps)
+               return 0;
+
+       if (!psm_get_ui_state(hwmgr, PP_StateUILabel_Performance,
+                                       &state_id))
+               ret =3D psm_set_states(hwmgr, state_id);
+
+       return ret;
 }

 int psm_set_user_performance_state(struct pp_hwmgr *hwmgr,
                                         enum PP_StateUILabel label_id,
                                         struct pp_power_state **state)
 {
-       if (hwmgr->chip_id !=3D CHIP_VEGA12)
-               return psm_legacy_set_user_performance_state(hwmgr,
-                               label_id,
-                               state);
+       int table_entries;
+       int i;
+
+       if (!hwmgr->ps)
+               return 0;
+
+       table_entries =3D hwmgr->num_ps;
+       *state =3D hwmgr->ps;
+
+restart_search:
+       for (i =3D 0; i < table_entries; i++) {
+               if ((*state)->classification.ui_label & label_id)
+                       return 0;
+               *state =3D (struct pp_power_state *)((uintptr_t)*state + hw=
mgr->ps_size);
+       }
+
+       switch (label_id) {
+       case PP_StateUILabel_Battery:
+       case PP_StateUILabel_Balanced:
+               label_id =3D PP_StateUILabel_Performance;
+               goto restart_search;
+       default:
+               break;
+       }
+       return -EINVAL;
+}
+
+static void power_state_management(struct pp_hwmgr *hwmgr,
+                                               struct pp_power_state *new_=
ps)
+{
+       struct pp_power_state *pcurrent;
+       struct pp_power_state *requested;
+       bool equal;
+
+       if (new_ps !=3D NULL)
+               requested =3D new_ps;
         else
-               return psm_new_set_user_performance_state(hwmgr,
-                               label_id,
-                               state);
+               requested =3D hwmgr->request_ps;
+
+       pcurrent =3D hwmgr->current_ps;
+
+       phm_apply_state_adjust_rules(hwmgr, requested, pcurrent);
+       if (pcurrent =3D=3D NULL || (0 !=3D phm_check_states_equal(hwmgr,
+                       &pcurrent->hardware, &requested->hardware, &equal))=
)
+               equal =3D false;
+
+       if (!equal || phm_check_smc_update_required_for_display_configurati=
on(hwmgr)) {
+               phm_set_power_state(hwmgr, &pcurrent->hardware, &requested-=
>hardware);
+               memcpy(hwmgr->current_ps, hwmgr->request_ps, hwmgr->ps_size=
);
+       }
 }

 int psm_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool skip,
                                                 struct pp_power_state *new=
_ps)
 {
-       if (hwmgr->chip_id !=3D CHIP_VEGA12)
-               return psm_legacy_adjust_power_state_dynamic(hwmgr,
-                               skip,
-                               new_ps);
-       else
-               return psm_new_adjust_power_state_dynamic(hwmgr,
-                               skip,
-                               new_ps);
+       uint32_t index;
+       long workload;
+
+       if (skip)
+               return 0;
+
+       phm_display_configuration_changed(hwmgr);
+
+       if (hwmgr->ps)
+               power_state_management(hwmgr, new_ps);
+
+       phm_notify_smc_display_config_after_ps_adjustment(hwmgr);
+
+       if (!phm_force_dpm_levels(hwmgr, hwmgr->request_dpm_level))
+               hwmgr->dpm_level =3D hwmgr->request_dpm_level;
+
+       if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
+               index =3D fls(hwmgr->workload_mask);
+               index =3D index > 0 && index <=3D Workload_Policy_Max ? ind=
ex - 1 : 0;
+               workload =3D hwmgr->workload_setting[index];
+
+               if (hwmgr->power_profile_mode !=3D workload && hwmgr->hwmgr=
_func->set_power_profile_mode)
+                       hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &w=
orkload, 0);
+       }
+
+       return 0;
 }
+
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c
deleted file mode 100644
index e3ac52820..0000000
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c
+++ /dev/null
@@ -1,262 +0,0 @@
-/*
- * Copyright 2017 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include "pp_psm_legacy.h"
-
-int psm_legacy_init_power_state_table(struct pp_hwmgr *hwmgr)
-{
-       int result;
-       unsigned int i;
-       unsigned int table_entries;
-       struct pp_power_state *state;
-       int size;
-
-       if (hwmgr->hwmgr_func->get_num_of_pp_table_entries =3D=3D NULL)
-               return -EINVAL;
-
-       if (hwmgr->hwmgr_func->get_power_state_size =3D=3D NULL)
-               return -EINVAL;
-
-       hwmgr->num_ps =3D table_entries =3D hwmgr->hwmgr_func->get_num_of_p=
p_table_entries(hwmgr);
-
-       hwmgr->ps_size =3D size =3D hwmgr->hwmgr_func->get_power_state_size=
(hwmgr) +
-                                         sizeof(struct pp_power_state);
-
-       hwmgr->ps =3D kzalloc(size * table_entries, GFP_KERNEL);
-       if (hwmgr->ps =3D=3D NULL)
-               return -ENOMEM;
-
-       hwmgr->request_ps =3D kzalloc(size, GFP_KERNEL);
-       if (hwmgr->request_ps =3D=3D NULL) {
-               kfree(hwmgr->ps);
-               hwmgr->ps =3D NULL;
-               return -ENOMEM;
-       }
-
-       hwmgr->current_ps =3D kzalloc(size, GFP_KERNEL);
-       if (hwmgr->current_ps =3D=3D NULL) {
-               kfree(hwmgr->request_ps);
-               kfree(hwmgr->ps);
-               hwmgr->request_ps =3D NULL;
-               hwmgr->ps =3D NULL;
-               return -ENOMEM;
-       }
-
-       state =3D hwmgr->ps;
-
-       for (i =3D 0; i < table_entries; i++) {
-               result =3D hwmgr->hwmgr_func->get_pp_table_entry(hwmgr, i, =
state);
-
-               if (state->classification.flags & PP_StateClassificationFla=
g_Boot) {
-                       hwmgr->boot_ps =3D state;
-                       memcpy(hwmgr->current_ps, state, size);
-                       memcpy(hwmgr->request_ps, state, size);
-               }
-
-               state->id =3D i + 1; /* assigned unique num for every power=
 state id */
-
-               if (state->classification.flags & PP_StateClassificationFla=
g_Uvd)
-                       hwmgr->uvd_ps =3D state;
-               state =3D (struct pp_power_state *)((unsigned long)state + =
size);
-       }
-
-       return 0;
-}
-
-int psm_legacy_fini_power_state_table(struct pp_hwmgr *hwmgr)
-{
-       if (hwmgr =3D=3D NULL)
-               return -EINVAL;
-
-       kfree(hwmgr->current_ps);
-       kfree(hwmgr->request_ps);
-       kfree(hwmgr->ps);
-       hwmgr->request_ps =3D NULL;
-       hwmgr->ps =3D NULL;
-       hwmgr->current_ps =3D NULL;
-       return 0;
-}
-
-static int get_ui_state(struct pp_hwmgr *hwmgr,
-                               enum PP_StateUILabel ui_label,
-                               unsigned long *state_id)
-{
-       struct pp_power_state *state;
-       int table_entries;
-       int i;
-
-       table_entries =3D hwmgr->num_ps;
-       state =3D hwmgr->ps;
-
-       for (i =3D 0; i < table_entries; i++) {
-               if (state->classification.ui_label & ui_label) {
-                       *state_id =3D state->id;
-                       return 0;
-               }
-               state =3D (struct pp_power_state *)((unsigned long)state + =
hwmgr->ps_size);
-       }
-       return -EINVAL;
-}
-
-static int get_state_by_classification(struct pp_hwmgr *hwmgr,
-                                       enum PP_StateClassificationFlag fla=
g,
-                                       unsigned long *state_id)
-{
-       struct pp_power_state *state;
-       int table_entries;
-       int i;
-
-       table_entries =3D hwmgr->num_ps;
-       state =3D hwmgr->ps;
-
-       for (i =3D 0; i < table_entries; i++) {
-               if (state->classification.flags & flag) {
-                       *state_id =3D state->id;
-                       return 0;
-               }
-               state =3D (struct pp_power_state *)((unsigned long)state + =
hwmgr->ps_size);
-       }
-       return -EINVAL;
-}
-
-static int set_states(struct pp_hwmgr *hwmgr, unsigned long state_id)
-{
-       struct pp_power_state *state;
-       int table_entries;
-       int i;
-
-       table_entries =3D hwmgr->num_ps;
-
-       state =3D hwmgr->ps;
-
-       for (i =3D 0; i < table_entries; i++) {
-               if (state->id =3D=3D state_id) {
-                       memcpy(hwmgr->request_ps, state, hwmgr->ps_size);
-                       return 0;
-               }
-               state =3D (struct pp_power_state *)((unsigned long)state + =
hwmgr->ps_size);
-       }
-       return -EINVAL;
-}
-
-int psm_legacy_set_boot_states(struct pp_hwmgr *hwmgr)
-{
-       unsigned long state_id;
-       int ret =3D -EINVAL;
-
-       if (!get_state_by_classification(hwmgr, PP_StateClassificationFlag_=
Boot,
-                                       &state_id))
-               ret =3D set_states(hwmgr, state_id);
-
-       return ret;
-}
-
-int psm_legacy_set_performance_states(struct pp_hwmgr *hwmgr)
-{
-       unsigned long state_id;
-       int ret =3D -EINVAL;
-
-       if (!get_ui_state(hwmgr, PP_StateUILabel_Performance,
-                                       &state_id))
-               ret =3D set_states(hwmgr, state_id);
-
-       return ret;
-}
-
-int psm_legacy_set_user_performance_state(struct pp_hwmgr *hwmgr,
-                                       enum PP_StateUILabel label_id,
-                                       struct pp_power_state **state)
-{
-       int table_entries;
-       int i;
-
-       table_entries =3D hwmgr->num_ps;
-       *state =3D hwmgr->ps;
-
-restart_search:
-       for (i =3D 0; i < table_entries; i++) {
-               if ((*state)->classification.ui_label & label_id)
-                       return 0;
-               *state =3D (struct pp_power_state *)((uintptr_t)*state + hw=
mgr->ps_size);
-       }
-
-       switch (label_id) {
-       case PP_StateUILabel_Battery:
-       case PP_StateUILabel_Balanced:
-               label_id =3D PP_StateUILabel_Performance;
-               goto restart_search;
-       default:
-               break;
-       }
-       return -EINVAL;
-}
-
-int psm_legacy_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool ski=
p,
-                                               struct pp_power_state *new_=
ps)
-{
-       struct pp_power_state *pcurrent;
-       struct pp_power_state *requested;
-       bool equal;
-       uint32_t index;
-       long workload;
-
-       if (skip)
-               return 0;
-
-       phm_display_configuration_changed(hwmgr);
-
-       if (new_ps !=3D NULL)
-               requested =3D new_ps;
-       else
-               requested =3D hwmgr->request_ps;
-
-       pcurrent =3D hwmgr->current_ps;
-
-       phm_apply_state_adjust_rules(hwmgr, requested, pcurrent);
-       if (pcurrent =3D=3D NULL || (0 !=3D phm_check_states_equal(hwmgr,
-                       &pcurrent->hardware, &requested->hardware, &equal))=
)
-               equal =3D false;
-
-       if (!equal || phm_check_smc_update_required_for_display_configurati=
on(hwmgr)) {
-               phm_set_power_state(hwmgr, &pcurrent->hardware, &requested-=
>hardware);
-               memcpy(hwmgr->current_ps, hwmgr->request_ps, hwmgr->ps_size=
);
-       }
-
-       phm_notify_smc_display_config_after_ps_adjustment(hwmgr);
-       if (!phm_force_dpm_levels(hwmgr, hwmgr->request_dpm_level))
-               hwmgr->dpm_level =3D hwmgr->request_dpm_level;
-
-       if (hwmgr->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
-               index =3D fls(hwmgr->workload_mask);
-               index =3D index > 0 && index <=3D Workload_Policy_Max ? ind=
ex - 1 : 0;
-               workload =3D hwmgr->workload_setting[index];
-
-               if (hwmgr->power_profile_mode !=3D workload && hwmgr->hwmgr=
_func->set_power_profile_mode)
-                       hwmgr->hwmgr_func->set_power_profile_mode(hwmgr, &w=
orkload, 0);
-       }
-
-       return 0;
-}
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h b/drivers/=
gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h
deleted file mode 100644
index bc99411..0000000
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright 2017 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#ifndef PP_PSM_LEGACY_H
-#define PP_PSM_LEGACY_H
-
-#include "hwmgr.h"
-
-int psm_legacy_init_power_state_table(struct pp_hwmgr *hwmgr);
-int psm_legacy_fini_power_state_table(struct pp_hwmgr *hwmgr);
-int psm_legacy_set_boot_states(struct pp_hwmgr *hwmgr);
-int psm_legacy_set_performance_states(struct pp_hwmgr *hwmgr);
-int psm_legacy_set_user_performance_state(struct pp_hwmgr *hwmgr,
-                                       enum PP_StateUILabel label_id,
-                                       struct pp_power_state **state);
-int psm_legacy_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr,
-                               bool skip,
-                               struct pp_power_state *new_ps);
-
-#endif
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/pp_psm_new.c
deleted file mode 100644
index 9eba8a1..0000000
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c
+++ /dev/null
@@ -1,76 +0,0 @@
-/*
- * Copyright 2017 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include "pp_psm_new.h"
-
-int psm_new_init_power_state_table(struct pp_hwmgr *hwmgr)
-{
-       hwmgr->ps_size =3D 0;
-       hwmgr->num_ps =3D 0;
-       hwmgr->ps =3D NULL;
-       hwmgr->request_ps =3D NULL;
-       hwmgr->current_ps =3D NULL;
-       hwmgr->boot_ps =3D NULL;
-       hwmgr->uvd_ps =3D NULL;
-
-       return 0;
-}
-
-int psm_new_fini_power_state_table(struct pp_hwmgr *hwmgr)
-{
-       return 0;
-}
-
-int psm_new_set_boot_states(struct pp_hwmgr *hwmgr)
-{
-       return 0;
-}
-
-int psm_new_set_performance_states(struct pp_hwmgr *hwmgr)
-{
-       return 0;
-}
-
-int psm_new_set_user_performance_state(struct pp_hwmgr *hwmgr,
-                                       enum PP_StateUILabel label_id,
-                                       struct pp_power_state **state)
-{
-       return 0;
-}
-
-int psm_new_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr,
-                                       bool skip,
-                                       struct pp_power_state *new_ps)
-{
-       if (skip)
-               return 0;
-
-       phm_display_configuration_changed(hwmgr);
-
-       phm_notify_smc_display_config_after_ps_adjustment(hwmgr);
-
-       return 0;
-}
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/pp_psm_new.h
deleted file mode 100644
index 5c4fabc..0000000
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * Copyright 2017 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software=
"),
- * to deal in the Software without restriction, including without limitati=
on
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included=
 in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- */
-
-#ifndef PP_PSM_NEW_H
-#define PP_PSM_NEW_H
-
-#include "hwmgr.h"
-
-int psm_new_init_power_state_table(struct pp_hwmgr *hwmgr);
-int psm_new_fini_power_state_table(struct pp_hwmgr *hwmgr);
-int psm_new_set_boot_states(struct pp_hwmgr *hwmgr);
-int psm_new_set_performance_states(struct pp_hwmgr *hwmgr);
-int psm_new_set_user_performance_state(struct pp_hwmgr *hwmgr,
-                                       enum PP_StateUILabel label_id,
-                                       struct pp_power_state **state);
-int psm_new_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr,
-                               bool skip,
-                               struct pp_power_state *new_ps);
-
-#endif
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180959F999425BD7F8741E79F7AA0BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Wednesday, March 21, 2018 7:34:34 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amd/pp: Add new asic(vega12) support in pp_psm.=
c</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In new asics, no power state management in driver,=
<br>
no need to implement related callback functions.<br>
add some ps checks in pp_psm.c<br>
<br>
Revert &quot;drm/amd/powerplay: add new pp_psm infrastructure for vega12 (v=
2)&quot;<br>
This reverts commit 7d1a63f3aa331b853e41f92d0e7890ed31de8c13.<br>
<br>
Change-Id: Ic31d3f475f94399d3136bff8be454f290e3c1e50<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 4 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 270 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c&nbsp;&nbsp;&nbsp; | 2=
62 --------------------<br>
&nbsp;.../gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h&nbsp;&nbsp;&nbsp; |&n=
bsp; 40 ---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c&nbsp;&nbsp; |&nbsp; =
76 ------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h&nbsp;&nbsp; |&nbsp; =
40 ---<br>
&nbsp;6 files changed, 239 insertions(&#43;), 453 deletions(-)<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.=
c<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.=
h<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c<b=
r>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h<b=
r>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile b/drivers/gpu/drm=
/amd/powerplay/hwmgr/Makefile<br>
index 9446dbc475..faf9c88 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/Makefile<br>
@@ -31,9 &#43;31,9 @@ HARDWARE_MGR =3D hwmgr.o processpptables.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; smu7_clockpowergating.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega10_processpptables.o vega10_hwmgr.o vega10_powert=
une.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega10_thermal.o smu10_hwmgr.o pp_psm.o\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pp_overdriver.o smu_helper.o pp_psm_legacy.o pp_psm_new.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; vega12_processpptables.o vega12_hwmgr.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vega12_powertune.o vega12_thermal.o<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; vega12_powertune.o vega12_thermal.o \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pp_overdriver.o smu_helper.o<br>
&nbsp;<br>
&nbsp;AMD_PP_HWMGR =3D $(addprefix $(AMD_PP_PATH)/hwmgr/,$(HARDWARE_MGR))<b=
r>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm=
/amd/powerplay/hwmgr/pp_psm.c<br>
index 295ab9f..0f2851b 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c<br>
@@ -21,65 &#43;21,269 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
&#43;#include &lt;linux/types.h&gt;<br>
&#43;#include &lt;linux/kernel.h&gt;<br>
&#43;#include &lt;linux/slab.h&gt;<br>
&nbsp;#include &quot;pp_psm.h&quot;<br>
-#include &quot;pp_psm_legacy.h&quot;<br>
-#include &quot;pp_psm_new.h&quot;<br>
&nbsp;<br>
&nbsp;int psm_init_power_state_table(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id !=3D CHIP_VEGA1=
2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_legacy_init_power_state_table(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_new_init_power_state_table(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int table_entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;get_=
num_of_pp_table_entries =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;get_=
power_state_size =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;num_ps =3D table_entrie=
s =3D hwmgr-&gt;hwmgr_func-&gt;get_num_of_pp_table_entries(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps_size =3D size =3D hw=
mgr-&gt;hwmgr_func-&gt;get_power_state_size(hwmgr) &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; sizeof(struct pp_power_state);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (table_entries =3D=3D 0 || siz=
e =3D=3D 0) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pr_warn(&quot;Please check whether power state management is=
 suppported on this asic\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps =3D kzalloc(size * t=
able_entries, GFP_KERNEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;ps =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ENOMEM;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;request_ps =3D kzalloc(=
size, GFP_KERNEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;request_ps =3D=3D N=
ULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfree(hwmgr-&gt;ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;ps =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ENOMEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;current_ps =3D kzalloc(=
size, GFP_KERNEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;current_ps =3D=3D N=
ULL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfree(hwmgr-&gt;request_ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfree(hwmgr-&gt;ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;request_ps =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;ps =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ENOMEM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entrie=
s; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; result =3D hwmgr-&gt;hwmgr_func-&gt;get_pp_table_entry(hwmgr=
, i, state);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (state-&gt;classification.flags &amp; PP_StateClassificat=
ionFlag_Boot) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;bo=
ot_ps =3D state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hwmgr=
-&gt;current_ps, state, size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hwmgr=
-&gt;request_ps, state, size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; state-&gt;id =3D i &#43; 1; /* assigned unique num for every=
 power state id */<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (state-&gt;classification.flags &amp; PP_StateClassificat=
ionFlag_Uvd)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;uv=
d_ps =3D state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#4=
3; size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psm_fini_power_state_table(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id !=3D CHIP_VEGA1=
2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_legacy_fini_power_state_table(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_new_fini_power_state_table(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;ps)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;current_ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;request_ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;request_ps =3D NULL;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;current_ps =3D NULL;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;}<br>
&#43;<br>
&#43;static int psm_get_ui_state(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_StateUILabel ui_label,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *state_id)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_p=
s;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entrie=
s; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (state-&gt;classification.ui_label &amp; ui_label) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state_id =
=3D state-&gt;id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#4=
3; hwmgr-&gt;ps_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;}<br>
&#43;<br>
&#43;static int psm_get_state_by_classification(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; enum PP_StateClassificationFlag flag,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; unsigned long *state_id)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_p=
s;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entrie=
s; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (state-&gt;classification.flags &amp; flag) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state_id =
=3D state-&gt;id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#4=
3; hwmgr-&gt;ps_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;}<br>
&#43;<br>
&#43;static int psm_set_states(struct pp_hwmgr *hwmgr, unsigned long state_=
id)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_p=
s;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entrie=
s; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (state-&gt;id =3D=3D state_id) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hwmgr=
-&gt;request_ps, state, hwmgr-&gt;ps_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#4=
3; hwmgr-&gt;ps_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psm_set_boot_states(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id !=3D CHIP_VEGA1=
2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_legacy_set_boot_states(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_new_set_boot_states(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long state_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;ps)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psm_get_state_by_classificat=
ion(hwmgr, PP_StateClassificationFlag_Boot,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &amp;state_id))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D psm_set_states(hwmgr, state_id);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psm_set_performance_states(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id !=3D CHIP_VEGA1=
2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_legacy_set_performance_states(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_new_set_performance_states(hwmgr);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long state_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;ps)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psm_get_ui_state(hwmgr, PP_S=
tateUILabel_Performance,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &amp;state_id))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D psm_set_states(hwmgr, state_id);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psm_set_user_performance_state(struct pp_hwmgr *hwmgr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; enum PP_StateUILabel label_id,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct pp_power_state **state)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id !=3D CHIP_VEGA1=
2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_legacy_set_user_performance_state(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hwmgr-&gt;ps)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_p=
s;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state =3D hwmgr-&gt;ps;<br>
&#43;<br>
&#43;restart_search:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entrie=
s; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if ((*state)-&gt;classification.ui_label &amp; label_id)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; *state =3D (struct pp_power_state *)((uintptr_t)*state &#43;=
 hwmgr-&gt;ps_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (label_id) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_StateUILabel_Battery:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_StateUILabel_Balanced:<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; label_id =3D PP_StateUILabel_Performance;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto restart_search;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&#43;}<br>
&#43;<br>
&#43;static void power_state_management(struct pp_hwmgr *hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_st=
ate *new_ps)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *pcurrent;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *requested;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool equal;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_ps !=3D NULL)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; requested =3D new_ps;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_new_set_user_performance_state(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; label_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; requested =3D hwmgr-&gt;request_ps;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcurrent =3D hwmgr-&gt;current_ps=
;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_apply_state_adjust_rules(hwmg=
r, requested, pcurrent);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pcurrent =3D=3D NULL || (0 !=
=3D phm_check_states_equal(hwmgr,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pcurren=
t-&gt;hardware, &amp;requested-&gt;hardware, &amp;equal)))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; equal =3D false;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!equal || phm_check_smc_updat=
e_required_for_display_configuration(hwmgr)) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; phm_set_power_state(hwmgr, &amp;pcurrent-&gt;hardware, &amp;=
requested-&gt;hardware);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; memcpy(hwmgr-&gt;current_ps, hwmgr-&gt;request_ps, hwmgr-&gt=
;ps_size);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psm_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool skip,=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_p=
ower_state *new_ps)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;chip_id !=3D CHIP_VEGA1=
2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_legacy_adjust_power_state_dynamic(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_ps);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return psm_new_adjust_power_state_dynamic(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_ps);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long workload;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (skip)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_display_configuration_changed=
(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;ps)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; power_state_management(hwmgr, new_ps);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_notify_smc_display_config_aft=
er_ps_adjustment(hwmgr);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!phm_force_dpm_levels(hwmgr, =
hwmgr-&gt;request_dpm_level))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; hwmgr-&gt;dpm_level =3D hwmgr-&gt;request_dpm_level;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=3D AMD_=
DPM_FORCED_LEVEL_MANUAL) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; index =3D fls(hwmgr-&gt;workload_mask);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; index =3D index &gt; 0 &amp;&amp; index &lt;=3D Workload_Pol=
icy_Max ? index - 1 : 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (hwmgr-&gt;power_profile_mode !=3D workload &amp;&amp; hw=
mgr-&gt;hwmgr_func-&gt;set_power_profile_mode)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hw=
mgr_func-&gt;set_power_profile_mode(hwmgr, &amp;workload, 0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&#43;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c b/drivers/=
gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c<br>
deleted file mode 100644<br>
index e3ac52820..0000000<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.c<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,262 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2017 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- */<br>
-<br>
-#include &lt;linux/types.h&gt;<br>
-#include &lt;linux/kernel.h&gt;<br>
-#include &lt;linux/slab.h&gt;<br>
-#include &quot;pp_psm_legacy.h&quot;<br>
-<br>
-int psm_legacy_init_power_state_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int result;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int table_entries;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;get_num_=
of_pp_table_entries =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;hwmgr_func-&gt;get_powe=
r_state_size =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;num_ps =3D table_entries =
=3D hwmgr-&gt;hwmgr_func-&gt;get_num_of_pp_table_entries(hwmgr);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps_size =3D size =3D hwmgr-=
&gt;hwmgr_func-&gt;get_power_state_size(hwmgr) &#43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; sizeof(struct pp_power_state);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps =3D kzalloc(size * table=
_entries, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;ps =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;request_ps =3D kzalloc(size=
, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;request_ps =3D=3D NULL)=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(hwmgr-&gt;ps);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;current_ps =3D kzalloc(size=
, GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;current_ps =3D=3D NULL)=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(hwmgr-&gt;request_ps);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(hwmgr-&gt;ps);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;request_ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entries; i=
&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; result =3D hwmgr-&gt;hwmgr_func-&gt;get_pp_table_entry(hwmgr, i,=
 state);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (state-&gt;classification.flags &amp; PP_StateClassificationF=
lag_Boot) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;boot_p=
s =3D state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hwmgr-&gt=
;current_ps, state, size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hwmgr-&gt=
;request_ps, state, size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; state-&gt;id =3D i &#43; 1; /* assigned unique num for every pow=
er state id */<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (state-&gt;classification.flags &amp; PP_StateClassificationF=
lag_Uvd)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;uvd_ps=
 =3D state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#43; s=
ize);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int psm_legacy_fini_power_state_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr =3D=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;current_ps);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;request_ps);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(hwmgr-&gt;ps);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;request_ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;current_ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int get_ui_state(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum PP_StateUILabel ui_label,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *state_id)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_ps;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entries; i=
&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (state-&gt;classification.ui_label &amp; ui_label) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state_id =3D st=
ate-&gt;id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#43; h=
wmgr-&gt;ps_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-}<br>
-<br>
-static int get_state_by_classification(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum PP_StateClassificationFlag flag,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; unsigned long *state_id)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_ps;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entries; i=
&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (state-&gt;classification.flags &amp; flag) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state_id =3D st=
ate-&gt;id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#43; h=
wmgr-&gt;ps_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-}<br>
-<br>
-static int set_states(struct pp_hwmgr *hwmgr, unsigned long state_id)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *state;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_ps;<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D hwmgr-&gt;ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entries; i=
&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (state-&gt;id =3D=3D state_id) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(hwmgr-&gt=
;request_ps, state, hwmgr-&gt;ps_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; state =3D (struct pp_power_state *)((unsigned long)state &#43; h=
wmgr-&gt;ps_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-}<br>
-<br>
-int psm_legacy_set_boot_states(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long state_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_state_by_classification(hwmg=
r, PP_StateClassificationFlag_Boot,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;state_id))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D set_states(hwmgr, state_id);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-int psm_legacy_set_performance_states(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long state_id;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_ui_state(hwmgr, PP_StateUILa=
bel_Performance,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &amp;state_id))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D set_states(hwmgr, state_id);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-int psm_legacy_set_user_performance_state(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum PP_StateUILabel label_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct pp_power_state **state)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int table_entries;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; table_entries =3D hwmgr-&gt;num_ps;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *state =3D hwmgr-&gt;ps;<br>
-<br>
-restart_search:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; table_entries; i=
&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((*state)-&gt;classification.ui_label &amp; label_id)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *state =3D (struct pp_power_state *)((uintptr_t)*state &#43; hwm=
gr-&gt;ps_size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (label_id) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_StateUILabel_Battery:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case PP_StateUILabel_Balanced:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; label_id =3D PP_StateUILabel_Performance;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto restart_search;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
-}<br>
-<br>
-int psm_legacy_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool ski=
p,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state =
*new_ps)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *pcurrent;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *requested;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool equal;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t index;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; long workload;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (skip)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_display_configuration_changed(hwm=
gr);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_ps !=3D NULL)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; requested =3D new_ps;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; requested =3D hwmgr-&gt;request_ps;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcurrent =3D hwmgr-&gt;current_ps;<br=
>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_apply_state_adjust_rules(hwmgr, r=
equested, pcurrent);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pcurrent =3D=3D NULL || (0 !=3D p=
hm_check_states_equal(hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;pcurrent-&g=
t;hardware, &amp;requested-&gt;hardware, &amp;equal)))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; equal =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!equal || phm_check_smc_update_re=
quired_for_display_configuration(hwmgr)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; phm_set_power_state(hwmgr, &amp;pcurrent-&gt;hardware, &amp;requ=
ested-&gt;hardware);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; memcpy(hwmgr-&gt;current_ps, hwmgr-&gt;request_ps, hwmgr-&gt;ps_=
size);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_notify_smc_display_config_after_p=
s_adjustment(hwmgr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!phm_force_dpm_levels(hwmgr, hwmg=
r-&gt;request_dpm_level))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hwmgr-&gt;dpm_level =3D hwmgr-&gt;request_dpm_level;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hwmgr-&gt;dpm_level !=3D AMD_DPM_=
FORCED_LEVEL_MANUAL) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; index =3D fls(hwmgr-&gt;workload_mask);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; index =3D index &gt; 0 &amp;&amp; index &lt;=3D Workload_Policy_=
Max ? index - 1 : 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; workload =3D hwmgr-&gt;workload_setting[index];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hwmgr-&gt;power_profile_mode !=3D workload &amp;&amp; hwmgr-=
&gt;hwmgr_func-&gt;set_power_profile_mode)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;hwmgr_=
func-&gt;set_power_profile_mode(hwmgr, &amp;workload, 0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h b/drivers/=
gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h<br>
deleted file mode 100644<br>
index bc99411..0000000<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_legacy.h<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,40 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2017 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- */<br>
-<br>
-#ifndef PP_PSM_LEGACY_H<br>
-#define PP_PSM_LEGACY_H<br>
-<br>
-#include &quot;hwmgr.h&quot;<br>
-<br>
-int psm_legacy_init_power_state_table(struct pp_hwmgr *hwmgr);<br>
-int psm_legacy_fini_power_state_table(struct pp_hwmgr *hwmgr);<br>
-int psm_legacy_set_boot_states(struct pp_hwmgr *hwmgr);<br>
-int psm_legacy_set_performance_states(struct pp_hwmgr *hwmgr);<br>
-int psm_legacy_set_user_performance_state(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum PP_StateUILabel label_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct pp_power_state **state);<br>
-int psm_legacy_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool skip,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *new_ps);<br>
-<br>
-#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/pp_psm_new.c<br>
deleted file mode 100644<br>
index 9eba8a1..0000000<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.c<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,76 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2017 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- */<br>
-<br>
-#include &lt;linux/types.h&gt;<br>
-#include &lt;linux/kernel.h&gt;<br>
-#include &lt;linux/slab.h&gt;<br>
-#include &quot;pp_psm_new.h&quot;<br>
-<br>
-int psm_new_init_power_state_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps_size =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;num_ps =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;request_ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;current_ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;boot_ps =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwmgr-&gt;uvd_ps =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int psm_new_fini_power_state_table(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int psm_new_set_boot_states(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int psm_new_set_performance_states(struct pp_hwmgr *hwmgr)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int psm_new_set_user_performance_state(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum PP_StateUILabel label_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct pp_power_state **state)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-int psm_new_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool skip,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct pp_power_state *new_ps)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (skip)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_display_configuration_changed(hwm=
gr);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phm_notify_smc_display_config_after_p=
s_adjustment(hwmgr);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h b/drivers/gpu=
/drm/amd/powerplay/hwmgr/pp_psm_new.h<br>
deleted file mode 100644<br>
index 5c4fabc..0000000<br>
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm_new.h<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,40 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2017 Advanced Micro Devices, Inc.<br>
- *<br>
- * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
- * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
- * to deal in the Software without restriction, including without limitati=
on<br>
- * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
- * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
- * Software is furnished to do so, subject to the following conditions:<br=
>
- *<br>
- * The above copyright notice and this permission notice shall be included=
 in<br>
- * all copies or substantial portions of the Software.<br>
- *<br>
- * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
- * OTHER DEALINGS IN THE SOFTWARE.<br>
- *<br>
- */<br>
-<br>
-#ifndef PP_PSM_NEW_H<br>
-#define PP_PSM_NEW_H<br>
-<br>
-#include &quot;hwmgr.h&quot;<br>
-<br>
-int psm_new_init_power_state_table(struct pp_hwmgr *hwmgr);<br>
-int psm_new_fini_power_state_table(struct pp_hwmgr *hwmgr);<br>
-int psm_new_set_boot_states(struct pp_hwmgr *hwmgr);<br>
-int psm_new_set_performance_states(struct pp_hwmgr *hwmgr);<br>
-int psm_new_set_user_performance_state(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; enum PP_StateUILabel label_id,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct pp_power_state **state);<br>
-int psm_new_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool skip,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_power_state *new_ps);<br>
-<br>
-#endif<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180959F999425BD7F8741E79F7AA0BN6PR12MB1809namp_--

--===============0282020664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0282020664==--
