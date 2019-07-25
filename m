From: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature status
 function in smu
Date: Thu, 25 Jul 2019 08:49:04 +0000
Message-ID: <MN2PR12MB33098222156F946AA7EABB26ECC10@MN2PR12MB3309.namprd12.prod.outlook.com>
References: <20190725051057.28862-1-kevin1.wang@amd.com>,
 <20190725051057.28862-5-kevin1.wang@amd.com>
 <MN2PR12MB32966C19A3EF83A1E868B25CA2C10@MN2PR12MB3296.namprd12.prod.outlook.com>,
 <MN2PR12MB334476A964852FD3B092B385E4C10@MN2PR12MB3344.namprd12.prod.outlook.com>
 <MN2PR12MB32968D539CA68CCE3E4AFFB6A2C10@MN2PR12MB3296.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0365835198=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB32968D539CA68CCE3E4AFFB6A2C10-rweVpJHSKTqAm9ToKNQgFgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Feng, Kenneth" <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>

--===============0365835198==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB33098222156F946AA7EABB26ECC10MN2PR12MB3309namp_"

--_000_MN2PR12MB33098222156F946AA7EABB26ECC10MN2PR12MB3309namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Any other user mode tool use the "ppfeature" sysfs interface?

Thanks,
Ray

From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, July 25, 2019 4:44 PM
To: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zhang, H=
awking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@amd.c=
om>
Cc: Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org>; Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature status f=
unction in smu

in fact, i don't want to change this sysfs name from "ppfeatures" to "pp_fe=
atures",
but it seems that don't have same name format with other pp sysfs node.
the other powerplay sysfs name have "pp_" prefix, i think we'd better to ch=
ange it name to "pp_features"

eg:
pp_cur_state    pp_dpm_fclk  pp_dpm_pcie  pp_dpm_socclk  pp_force_state  pp=
_num_states          pp_sclk_od
pp_dpm_dcefclk  pp_dpm_mclk  pp_dpm_sclk  pp_features    pp_mclk_od      pp=
_power_profile_mode  pp_table

@Deucher, Alexander<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> @Zhang, Hawking<mailt=
o:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

Could you give us some idea about it,
Thanks.

Best Regards,
Kevin
________________________________
From: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org<mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, July 25, 2019 4:30 PM
To: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>; am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <amd-gfx@=
lists.freedesktop.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher@=
amd.com>>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Feng, =
Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>
Subject: RE: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature status f=
unction in smu


To keep backward compatibility, we cannot change the sysfs file naming.

But it's a good idea to summarize these as common APIs.



Regards,

Evan

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of Wang, Kevin(Yang)
Sent: Thursday, July 25, 2019 4:10 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher@=
amd.com>>; Huang, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Feng, =
Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>
Subject: Re: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature status f=
unction in smu



add sample data from sysfs pp_features with this patch.



print format:

index. feature name (Hardware Message ID): state



sudo find /sys -name "pp_features" -exec cat {} \;

features high: 0x00000623 low: 0xb3cdaffb

00. DPM_PREFETCHER       ( 0) : enabeld

01. DPM_GFXCLK           ( 1) : enabeld

02. DPM_UCLK             ( 3) : enabeld

03. DPM_SOCCLK           ( 4) : enabeld

04. DPM_MP0CLK           ( 5) : enabeld

05. DPM_LINK             ( 6) : enabeld

06. DPM_DCEFCLK          ( 7) : enabeld

07. DS_GFXCLK            (10) : enabeld

08. DS_SOCCLK            (11) : enabeld

09. DS_LCLK              (12) : disabled

10. PPT                  (23) : enabeld

11. TDC                  (24) : enabeld

12. THERMAL              (33) : enabeld

13. RM                   (35) : disabled

14. DS_DCEFCLK           (13) : enabeld

15. ACDC                 (28) : enabeld

16. VR0HOT               (29) : enabeld

17. VR1HOT               (30) : disabled

18. FW_CTF               (31) : enabeld

19. LED_DISPLAY          (36) : disabled

20. FAN_CONTROL          (32) : enabeld

21. GFX_EDC              (25) : enabeld

22. GFXOFF               (17) : disabled

23. DPM_GFX_PACE         ( 2) : disabled

24. MEM_VDDCI_SCALING    ( 8) : enabeld

25. MEM_MVDD_SCALING     ( 9) : enabeld

26. DS_UCLK              (14) : disabled

27. GFX_ULV              (15) : enabeld

28. FW_DSTATE            (16) : enabeld

29. BACO                 (18) : enabeld

30. VCN_PG               (19) : enabeld

31. JPEG_PG              (20) : disabled

32. USB_PG               (21) : disabled

33. RSMU_SMN_CG          (22) : enabeld

34. APCC_PLUS            (26) : disabled

35. GTHR                 (27) : disabled

36. GFX_DCS              (34) : disabled

37. GFX_SS               (37) : enabeld

38. OUT_OF_BAND_MONITOR  (38) : disabled

39. TEMP_DEPENDENT_VMIN  (39) : disabled

40. MMHUB_PG             (40) : disabled

41. ATHUB_PG             (41) : enabeld



________________________________

From: Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, July 25, 2019 1:11 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: Feng, Kenneth <Kenneth.Feng-5C7GfCeVMHo@public.gmane.org<mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org>>; Huan=
g, Ray <Ray.Huang-5C7GfCeVMHo@public.gmane.org<mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org>>; Deucher, Alexander <A=
lexander.Deucher-5C7GfCeVMHo@public.gmane.org<mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>; Wang, Kevin(Ya=
ng) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org<mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature status funct=
ion in smu



1. Unified feature enable status format in sysfs
2. Rename ppfeature to pp_features to adapt other pp sysfs node name
3. this function support all asic, not asic related function.

Signed-off-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org<mailto:kevin1.wang-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c        |  24 +--
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  61 +++++++
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |   8 +-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    | 165 ------------------
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 153 ----------------
 5 files changed, 75 insertions(+), 336 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 866097d5cf26..9e8e8a65d9bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -788,10 +788,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct de=
vice *dev,
 }

 /**
- * DOC: ppfeatures
+ * DOC: pp_features
  *
  * The amdgpu driver provides a sysfs API for adjusting what powerplay
- * features to be enabled. The file ppfeatures is used for this. And
+ * features to be enabled. The file pp_features is used for this. And
  * this is only available for Vega10 and later dGPUs.
  *
  * Reading back the file will show you the followings:
@@ -803,7 +803,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct devi=
ce *dev,
  * the corresponding bit from original ppfeature masks and input the
  * new ppfeature masks.
  */
-static ssize_t amdgpu_set_ppfeature_status(struct device *dev,
+static ssize_t amdgpu_set_pp_feature_status(struct device *dev,
                 struct device_attribute *attr,
                 const char *buf,
                 size_t count)
@@ -820,7 +820,7 @@ static ssize_t amdgpu_set_ppfeature_status(struct devic=
e *dev,
         pr_debug("featuremask =3D 0x%llx\n", featuremask);

         if (is_support_sw_smu(adev)) {
-               ret =3D smu_set_ppfeature_status(&adev->smu, featuremask);
+               ret =3D smu_sys_set_pp_feature_mask(&adev->smu, featuremask=
);
                 if (ret)
                         return -EINVAL;
         } else if (adev->powerplay.pp_funcs->set_ppfeature_status) {
@@ -832,7 +832,7 @@ static ssize_t amdgpu_set_ppfeature_status(struct devic=
e *dev,
         return count;
 }

-static ssize_t amdgpu_get_ppfeature_status(struct device *dev,
+static ssize_t amdgpu_get_pp_feature_status(struct device *dev,
                 struct device_attribute *attr,
                 char *buf)
 {
@@ -840,7 +840,7 @@ static ssize_t amdgpu_get_ppfeature_status(struct devic=
e *dev,
         struct amdgpu_device *adev =3D ddev->dev_private;

         if (is_support_sw_smu(adev)) {
-               return smu_get_ppfeature_status(&adev->smu, buf);
+               return smu_sys_get_pp_feature_mask(&adev->smu, buf);
         } else if (adev->powerplay.pp_funcs->get_ppfeature_status)
                 return amdgpu_dpm_get_ppfeature_status(adev, buf);

@@ -1500,9 +1500,9 @@ static DEVICE_ATTR(gpu_busy_percent, S_IRUGO,
 static DEVICE_ATTR(mem_busy_percent, S_IRUGO,
                 amdgpu_get_memory_busy_percent, NULL);
 static DEVICE_ATTR(pcie_bw, S_IRUGO, amdgpu_get_pcie_bw, NULL);
-static DEVICE_ATTR(ppfeatures, S_IRUGO | S_IWUSR,
-               amdgpu_get_ppfeature_status,
-               amdgpu_set_ppfeature_status);
+static DEVICE_ATTR(pp_features, S_IRUGO | S_IWUSR,
+               amdgpu_get_pp_feature_status,
+               amdgpu_set_pp_feature_status);
 static DEVICE_ATTR(unique_id, S_IRUGO, amdgpu_get_unique_id, NULL);

 static ssize_t amdgpu_hwmon_show_temp(struct device *dev,
@@ -2960,10 +2960,10 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev=
)
         if ((adev->asic_type >=3D CHIP_VEGA10) &&
             !(adev->flags & AMD_IS_APU)) {
                 ret =3D device_create_file(adev->dev,
-                               &dev_attr_ppfeatures);
+                               &dev_attr_pp_features);
                 if (ret) {
                         DRM_ERROR("failed to create device file "
-                                       "ppfeatures\n");
+                                       "pp_features\n");
                         return ret;
                 }
         }
@@ -3017,7 +3017,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *adev)
                 device_remove_file(adev->dev, &dev_attr_unique_id);
         if ((adev->asic_type >=3D CHIP_VEGA10) &&
             !(adev->flags & AMD_IS_APU))
-               device_remove_file(adev->dev, &dev_attr_ppfeatures);
+               device_remove_file(adev->dev, &dev_attr_pp_features);
 }

 void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index e881de955388..90833ff2fe00 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -55,6 +55,67 @@ const char *smu_get_feature_name(struct smu_context *smu=
, enum smu_feature_mask
         return __smu_feature_names[feature];
 }

+size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)
+{
+       size_t size =3D 0;
+       int ret =3D 0, i =3D 0;
+       uint32_t feature_mask[2] =3D { 0 };
+       int32_t feature_index =3D 0;
+       uint32_t count =3D 0;
+
+       ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2);
+       if (ret)
+               goto failed;
+
+       size =3D  sprintf(buf + size, "features high: 0x%08x low: 0x%08x\n"=
,
+                       feature_mask[1], feature_mask[0]);
+
+       for (i =3D 0; i < SMU_FEATURE_COUNT; i++) {
+               feature_index =3D smu_feature_get_index(smu, i);
+               if (feature_index < 0)
+                       continue;
+               size +=3D sprintf(buf + size, "%02d. %-20s (%2d) : %s\n",
+                              count++,
+                              smu_get_feature_name(smu, i),
+                              feature_index,
+                              !!smu_feature_is_enabled(smu, i) ? "enabeld"=
 : "disabled");
+       }
+
+failed:
+       return size;
+}
+
+int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask=
)
+{
+       int ret =3D 0;
+       uint32_t feature_mask[2] =3D { 0 };
+       uint64_t feature_2_enabled =3D 0;
+       uint64_t feature_2_disabled =3D 0;
+       uint64_t feature_enables =3D 0;
+
+       ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2);
+       if (ret)
+               return ret;
+
+       feature_enables =3D ((uint64_t)feature_mask[1] << 32 | (uint64_t)fe=
ature_mask[0]);
+
+       feature_2_enabled  =3D ~feature_enables & new_mask;
+       feature_2_disabled =3D feature_enables & ~new_mask;
+
+       if (feature_2_enabled) {
+               ret =3D smu_feature_update_enable_state(smu, feature_2_enab=
led, true);
+               if (ret)
+                       ret;
+       }
+       if (feature_2_disabled) {
+               ret =3D smu_feature_update_enable_state(smu, feature_2_disa=
bled, false);
+               if (ret)
+                       return ret;
+       }
+
+       return ret;
+}
+
 int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version, uin=
t32_t *smu_version)
 {
         int ret =3D 0;
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h
index abc2644b4c07..ac9e9d5d8a5c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -432,8 +432,6 @@ struct pptable_funcs {
                                       uint32_t *mclk_mask,
                                       uint32_t *soc_mask);
         int (*set_cpu_power_state)(struct smu_context *smu);
-       int (*set_ppfeature_status)(struct smu_context *smu, uint64_t ppfea=
tures);
-       int (*get_ppfeature_status)(struct smu_context *smu, char *buf);
         bool (*is_dpm_running)(struct smu_context *smu);
         int (*tables_init)(struct smu_context *smu, struct smu_table *tabl=
es);
         int (*set_thermal_fan_table)(struct smu_context *smu);
@@ -713,10 +711,6 @@ struct smu_funcs
         ((smu)->ppt_funcs->dpm_set_vce_enable ? (smu)->ppt_funcs->dpm_set_=
vce_enable((smu), (enable)) : 0)
 #define smu_set_xgmi_pstate(smu, pstate) \
                 ((smu)->funcs->set_xgmi_pstate ? (smu)->funcs->set_xgmi_ps=
tate((smu), (pstate)) : 0)
-#define smu_set_ppfeature_status(smu, ppfeatures) \
-       ((smu)->ppt_funcs->set_ppfeature_status ? (smu)->ppt_funcs->set_ppf=
eature_status((smu), (ppfeatures)) : -EINVAL)
-#define smu_get_ppfeature_status(smu, buf) \
-       ((smu)->ppt_funcs->get_ppfeature_status ? (smu)->ppt_funcs->get_ppf=
eature_status((smu), (buf)) : -EINVAL)
 #define smu_set_watermarks_table(smu, tab, clock_ranges) \
         ((smu)->ppt_funcs->set_watermarks_table ? (smu)->ppt_funcs->set_wa=
termarks_table((smu), (tab), (clock_ranges)) : 0)
 #define smu_get_current_clk_freq_by_table(smu, clk_type, value) \
@@ -804,5 +798,7 @@ bool smu_clk_dpm_is_enabled(struct smu_context *smu, en=
um smu_clk_type clk_type)
 int smu_feature_update_enable_state(struct smu_context *smu, uint64_t feat=
ure_mask, bool enabled);
 const char *smu_get_message_name(struct smu_context *smu, enum smu_message=
_type type);
 const char *smu_get_feature_name(struct smu_context *smu, enum smu_feature=
_mask feature);
+size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf);
+int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_mask=
);

 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index c873228bf05f..cd0920093a5e 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1422,169 +1422,6 @@ static int navi10_get_uclk_dpm_states(struct smu_co=
ntext *smu, uint32_t *clocks_
         return 0;
 }

-static int navi10_get_ppfeature_status(struct smu_context *smu,
-                                      char *buf)
-{
-       static const char *ppfeature_name[] =3D {
-                               "DPM_PREFETCHER",
-                               "DPM_GFXCLK",
-                               "DPM_GFX_PACE",
-                               "DPM_UCLK",
-                               "DPM_SOCCLK",
-                               "DPM_MP0CLK",
-                               "DPM_LINK",
-                               "DPM_DCEFCLK",
-                               "MEM_VDDCI_SCALING",
-                               "MEM_MVDD_SCALING",
-                               "DS_GFXCLK",
-                               "DS_SOCCLK",
-                               "DS_LCLK",
-                               "DS_DCEFCLK",
-                               "DS_UCLK",
-                               "GFX_ULV",
-                               "FW_DSTATE",
-                               "GFXOFF",
-                               "BACO",
-                               "VCN_PG",
-                               "JPEG_PG",
-                               "USB_PG",
-                               "RSMU_SMN_CG",
-                               "PPT",
-                               "TDC",
-                               "GFX_EDC",
-                               "APCC_PLUS",
-                               "GTHR",
-                               "ACDC",
-                               "VR0HOT",
-                               "VR1HOT",
-                               "FW_CTF",
-                               "FAN_CONTROL",
-                               "THERMAL",
-                               "GFX_DCS",
-                               "RM",
-                               "LED_DISPLAY",
-                               "GFX_SS",
-                               "OUT_OF_BAND_MONITOR",
-                               "TEMP_DEPENDENT_VMIN",
-                               "MMHUB_PG",
-                               "ATHUB_PG"};
-       static const char *output_title[] =3D {
-                               "FEATURES",
-                               "BITMASK",
-                               "ENABLEMENT"};
-       uint64_t features_enabled;
-       uint32_t feature_mask[2];
-       int i;
-       int ret =3D 0;
-       int size =3D 0;
-
-       ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2);
-       PP_ASSERT_WITH_CODE(!ret,
-                       "[GetPPfeatureStatus] Failed to get enabled smc fea=
tures!",
-                       return ret);
-       features_enabled =3D (uint64_t)feature_mask[0] |
-                          (uint64_t)feature_mask[1] << 32;
-
-       size +=3D sprintf(buf + size, "Current ppfeatures: 0x%016llx\n", fe=
atures_enabled);
-       size +=3D sprintf(buf + size, "%-19s %-22s %s\n",
-                               output_title[0],
-                               output_title[1],
-                               output_title[2]);
-       for (i =3D 0; i < (sizeof(ppfeature_name) / sizeof(ppfeature_name[0=
])); i++) {
-               size +=3D sprintf(buf + size, "%-19s 0x%016llx %6s\n",
-                                       ppfeature_name[i],
-                                       1ULL << i,
-                                       (features_enabled & (1ULL << i)) ? =
"Y" : "N");
-       }
-
-       return size;
-}
-
-static int navi10_enable_smc_features(struct smu_context *smu,
-                                     bool enabled,
-                                     uint64_t feature_masks)
-{
-       struct smu_feature *feature =3D &smu->smu_feature;
-       uint32_t feature_low, feature_high;
-       uint32_t feature_mask[2];
-       int ret =3D 0;
-
-       feature_low =3D (uint32_t)(feature_masks & 0xFFFFFFFF);
-       feature_high =3D (uint32_t)((feature_masks & 0xFFFFFFFF00000000ULL)=
 >> 32);
-
-       if (enabled) {
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesLow,
-                                                 feature_low);
-               if (ret)
-                       return ret;
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesHigh,
-                                                 feature_high);
-               if (ret)
-                       return ret;
-       } else {
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesLow,
-                                                 feature_low);
-               if (ret)
-                       return ret;
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesHigh,
-                                                 feature_high);
-               if (ret)
-                       return ret;
-       }
-
-       ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2);
-       if (ret)
-               return ret;
-
-       mutex_lock(&feature->mutex);
-       bitmap_copy(feature->enabled, (unsigned long *)&feature_mask,
-                   feature->feature_num);
-       mutex_unlock(&feature->mutex);
-
-       return 0;
-}
-
-static int navi10_set_ppfeature_status(struct smu_context *smu,
-                                      uint64_t new_ppfeature_masks)
-{
-       uint64_t features_enabled;
-       uint32_t feature_mask[2];
-       uint64_t features_to_enable;
-       uint64_t features_to_disable;
-       int ret =3D 0;
-
-       ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2);
-       PP_ASSERT_WITH_CODE(!ret,
-                       "[SetPPfeatureStatus] Failed to get enabled smc fea=
tures!",
-                       return ret);
-       features_enabled =3D (uint64_t)feature_mask[0] |
-                          (uint64_t)feature_mask[1] << 32;
-
-       features_to_disable =3D
-               features_enabled & ~new_ppfeature_masks;
-       features_to_enable =3D
-               ~features_enabled & new_ppfeature_masks;
-
-       pr_debug("features_to_disable 0x%llx\n", features_to_disable);
-       pr_debug("features_to_enable 0x%llx\n", features_to_enable);
-
-       if (features_to_disable) {
-               ret =3D navi10_enable_smc_features(smu, false, features_to_=
disable);
-               PP_ASSERT_WITH_CODE(!ret,
-                               "[SetPPfeatureStatus] Failed to disable smc=
 features!",
-                               return ret);
-       }
-
-       if (features_to_enable) {
-               ret =3D navi10_enable_smc_features(smu, true, features_to_e=
nable);
-               PP_ASSERT_WITH_CODE(!ret,
-                               "[SetPPfeatureStatus] Failed to enable smc =
features!",
-                               return ret);
-       }
-
-       return 0;
-}
-
 static int navi10_set_peak_clock_by_device(struct smu_context *smu)
 {
         struct amdgpu_device *adev =3D smu->adev;
@@ -1689,8 +1526,6 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
         .set_watermarks_table =3D navi10_set_watermarks_table,
         .read_sensor =3D navi10_read_sensor,
         .get_uclk_dpm_states =3D navi10_get_uclk_dpm_states,
-       .get_ppfeature_status =3D navi10_get_ppfeature_status,
-       .set_ppfeature_status =3D navi10_set_ppfeature_status,
         .set_performance_level =3D navi10_set_performance_level,
         .get_thermal_temperature_range =3D navi10_get_thermal_temperature_=
range,
 };
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c
index c06a9472c3b2..52c8fc9f1ff4 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -2858,157 +2858,6 @@ static int vega20_dpm_set_vce_enable(struct smu_con=
text *smu, bool enable)
         return smu_feature_set_enabled(smu, SMU_FEATURE_DPM_VCE_BIT, enabl=
e);
 }

-static int vega20_get_enabled_smc_features(struct smu_context *smu,
-               uint64_t *features_enabled)
-{
-       uint32_t feature_mask[2] =3D {0, 0};
-       int ret =3D 0;
-
-       ret =3D smu_feature_get_enabled_mask(smu, feature_mask, 2);
-       if (ret)
-               return ret;
-
-       *features_enabled =3D ((((uint64_t)feature_mask[0] << SMU_FEATURES_=
LOW_SHIFT) & SMU_FEATURES_LOW_MASK) |
-                       (((uint64_t)feature_mask[1] << SMU_FEATURES_HIGH_SH=
IFT) & SMU_FEATURES_HIGH_MASK));
-
-       return ret;
-}
-
-static int vega20_enable_smc_features(struct smu_context *smu,
-               bool enable, uint64_t feature_mask)
-{
-       uint32_t smu_features_low, smu_features_high;
-       int ret =3D 0;
-
-       smu_features_low =3D (uint32_t)((feature_mask & SMU_FEATURES_LOW_MA=
SK) >> SMU_FEATURES_LOW_SHIFT);
-       smu_features_high =3D (uint32_t)((feature_mask & SMU_FEATURES_HIGH_=
MASK) >> SMU_FEATURES_HIGH_SHIFT);
-
-       if (enable) {
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesLow,
-                                                 smu_features_low);
-               if (ret)
-                       return ret;
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuF=
eaturesHigh,
-                                                 smu_features_high);
-               if (ret)
-                       return ret;
-       } else {
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesLow,
-                                                 smu_features_low);
-               if (ret)
-                       return ret;
-               ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmu=
FeaturesHigh,
-                                                 smu_features_high);
-               if (ret)
-                       return ret;
-       }
-
-       return 0;
-
-}
-
-static int vega20_get_ppfeature_status(struct smu_context *smu, char *buf)
-{
-       static const char *ppfeature_name[] =3D {
-                               "DPM_PREFETCHER",
-                               "GFXCLK_DPM",
-                               "UCLK_DPM",
-                               "SOCCLK_DPM",
-                               "UVD_DPM",
-                               "VCE_DPM",
-                               "ULV",
-                               "MP0CLK_DPM",
-                               "LINK_DPM",
-                               "DCEFCLK_DPM",
-                               "GFXCLK_DS",
-                               "SOCCLK_DS",
-                               "LCLK_DS",
-                               "PPT",
-                               "TDC",
-                               "THERMAL",
-                               "GFX_PER_CU_CG",
-                               "RM",
-                               "DCEFCLK_DS",
-                               "ACDC",
-                               "VR0HOT",
-                               "VR1HOT",
-                               "FW_CTF",
-                               "LED_DISPLAY",
-                               "FAN_CONTROL",
-                               "GFX_EDC",
-                               "GFXOFF",
-                               "CG",
-                               "FCLK_DPM",
-                               "FCLK_DS",
-                               "MP1CLK_DS",
-                               "MP0CLK_DS",
-                               "XGMI",
-                               "ECC"};
-       static const char *output_title[] =3D {
-                               "FEATURES",
-                               "BITMASK",
-                               "ENABLEMENT"};
-       uint64_t features_enabled;
-       int i;
-       int ret =3D 0;
-       int size =3D 0;
-
-       ret =3D vega20_get_enabled_smc_features(smu, &features_enabled);
-       if (ret)
-               return ret;
-
-       size +=3D sprintf(buf + size, "Current ppfeatures: 0x%016llx\n", fe=
atures_enabled);
-       size +=3D sprintf(buf + size, "%-19s %-22s %s\n",
-                               output_title[0],
-                               output_title[1],
-                               output_title[2]);
-       for (i =3D 0; i < GNLD_FEATURES_MAX; i++) {
-               size +=3D sprintf(buf + size, "%-19s 0x%016llx %6s\n",
-                                       ppfeature_name[i],
-                                       1ULL << i,
-                                       (features_enabled & (1ULL << i)) ? =
"Y" : "N");
-       }
-
-       return size;
-}
-
-static int vega20_set_ppfeature_status(struct smu_context *smu, uint64_t n=
ew_ppfeature_masks)
-{
-       uint64_t features_enabled;
-       uint64_t features_to_enable;
-       uint64_t features_to_disable;
-       int ret =3D 0;
-
-       if (new_ppfeature_masks >=3D (1ULL << GNLD_FEATURES_MAX))
-               return -EINVAL;
-
-       ret =3D vega20_get_enabled_smc_features(smu, &features_enabled);
-       if (ret)
-               return ret;
-
-       features_to_disable =3D
-               features_enabled & ~new_ppfeature_masks;
-       features_to_enable =3D
-               ~features_enabled & new_ppfeature_masks;
-
-       pr_debug("features_to_disable 0x%llx\n", features_to_disable);
-       pr_debug("features_to_enable 0x%llx\n", features_to_enable);
-
-       if (features_to_disable) {
-               ret =3D vega20_enable_smc_features(smu, false, features_to_=
disable);
-               if (ret)
-                       return ret;
-       }
-
-       if (features_to_enable) {
-               ret =3D vega20_enable_smc_features(smu, true, features_to_e=
nable);
-               if (ret)
-                       return ret;
-       }
-
-       return 0;
-}
-
 static bool vega20_is_dpm_running(struct smu_context *smu)
 {
         int ret =3D 0;
@@ -3311,8 +3160,6 @@ static const struct pptable_funcs vega20_ppt_funcs =
=3D {
         .force_dpm_limit_value =3D vega20_force_dpm_limit_value,
         .unforce_dpm_levels =3D vega20_unforce_dpm_levels,
         .get_profiling_clk_mask =3D vega20_get_profiling_clk_mask,
-       .set_ppfeature_status =3D vega20_set_ppfeature_status,
-       .get_ppfeature_status =3D vega20_get_ppfeature_status,
         .is_dpm_running =3D vega20_is_dpm_running,
         .set_thermal_fan_table =3D vega20_set_thermal_fan_table,
         .get_fan_speed_percent =3D vega20_get_fan_speed_percent,
--
2.22.0

--_000_MN2PR12MB33098222156F946AA7EABB26ECC10MN2PR12MB3309namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"http://sc=
hemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-=
html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsonormal0, li.xmsonormal0, div.xmsonormal0
	{mso-style-name:x_msonormal0;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsochpdefault, li.xmsochpdefault, div.xmsochpdefault
	{mso-style-name:x_msochpdefault;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.xmsohyperlink
	{mso-style-name:x_msohyperlink;
	color:#0563C1;
	text-decoration:underline;}
span.xmsohyperlinkfollowed
	{mso-style-name:x_msohyperlinkfollowed;
	color:#954F72;
	text-decoration:underline;}
span.xemailstyle20
	{mso-style-name:x_emailstyle20;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.EmailStyle27
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Any other user mode tool use the &#8220;ppfeature&#8=
221; sysfs interface?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Ray<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Wang, Kevin(Yang) &lt;Kevin1.Wang@amd.c=
om&gt; <br>
<b>Sent:</b> Thursday, July 25, 2019 4:44 PM<br>
<b>To:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &lt;A=
lexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Huang, Ray &lt;Ray.Huang-5C7GfCeVMHo@public.gmane.org&gt;; Feng, Kenneth &lt;Kenneth.=
Feng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature s=
tatus function in smu<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">in fact=
, i don't want to change this sysfs name from &quot;ppfeatures&quot; to &qu=
ot;pp_features&quot;,&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">but it =
seems that don't have same name format with other pp sysfs node.<o:p></o:p>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">the oth=
er powerplay sysfs name have &quot;pp_&quot; prefix, i think we'd&nbsp;bett=
er to change it name to &quot;pp_features&quot;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">eg:<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">pp_cur_=
state &nbsp; &nbsp;pp_dpm_fclk &nbsp;pp_dpm_pcie &nbsp;pp_dpm_socclk &nbsp;=
pp_force_state &nbsp;pp_num_states &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pp_scl=
k_od<br>
pp_dpm_dcefclk &nbsp;pp_dpm_mclk &nbsp;pp_dpm_sclk &nbsp;pp_features &nbsp;=
 &nbsp;pp_mclk_od &nbsp; &nbsp; &nbsp;pp_power_profile_mode &nbsp;pp_table<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><a id=
=3D"OWAAM782110" href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"><span style=3D"f=
ont-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Deucher, A=
lexander</span></a>&nbsp;<a id=3D"OWAAM387764" href=3D"mailto:Hawking.Zhang=
@amd.com"><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-de=
coration:none">@Zhang,
 Hawking</span></a><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Could y=
ou give us some idea about it,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks.=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Best Re=
gards,<br>
Kevin<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan-5C7GfCeVMHo@public.gmane.org"=
>Evan.Quan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, July 25, 2019 4:30 PM<br>
<b>To:</b> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kev=
in1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;;
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray=
.Huang-5C7GfCeVMHo@public.gmane.org">Ray.Huang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Feng, Kenneth &lt;<a href=3D"mai=
lto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kenneth.Feng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature s=
tatus function in smu</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal">To keep backward compatibility, we cannot change th=
e sysfs file naming.<o:p></o:p></p>
<p class=3D"xmsonormal">But it&#8217;s a good idea to summarize these as co=
mmon APIs.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xmsonormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-=
bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt=
;
<b>On Behalf Of </b>Wang, Kevin(Yang)<br>
<b>Sent:</b> Thursday, July 25, 2019 4:10 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray=
.Huang-5C7GfCeVMHo@public.gmane.org">Ray.Huang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Feng, Kenneth &lt;<a href=3D"mai=
lto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kenneth.Feng-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 5/5] drm/amd/powerplay: implment sysfs feature s=
tatus function in smu<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">add sa=
mple data from sysfs pp_features with this patch.</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">print =
format:</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">index.=
 feature name (Hardware Message ID): state</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><i><span style=3D"font-size:9.0pt;color:black">sudo=
 find /sys -name &quot;pp_features&quot; -exec cat {} \;</span></i><o:p></o=
:p></p>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">feature=
s high: 0x00000623 low: 0xb3cdaffb</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">00. DPM=
_PREFETCHER &nbsp; &nbsp; &nbsp; ( 0) : enabeld</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">01. DPM=
_GFXCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ( 1) : enabeld</span><o:p></o:p>=
</p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">02. DPM=
_UCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ( 3) : enabeld</span><o:p><=
/o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">03. DPM=
_SOCCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ( 4) : enabeld</span><o:p></o:p>=
</p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">04. DPM=
_MP0CLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ( 5) : enabeld</span><o:p></o:p>=
</p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">05. DPM=
_LINK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ( 6) : enabeld</span><o:p><=
/o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">06. DPM=
_DCEFCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;( 7) : enabeld</span><o:p></o:p>=
</p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">07. DS_=
GFXCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(10) : enabeld</span><o:p><=
/o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">08. DS_=
SOCCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(11) : enabeld</span><o:p><=
/o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">09. DS_=
LCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(12) : disabled</span>=
<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">10. PPT=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(23) : enabe=
ld</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">11. TDC=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(24) : enabe=
ld</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">12. THE=
RMAL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(33) : enabeld</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">13. RM =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (35) : disab=
led</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">14. DS_=
DCEFCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (13) : enabeld</span><o:p></o:p>=
</p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">15. ACD=
C &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (28) : enabeld</s=
pan><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">16. VR0=
HOT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (29) : enabeld</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">17. VR1=
HOT &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (30) : disabled</span>=
<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">18. FW_=
CTF &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (31) : enabeld</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">19. LED=
_DISPLAY &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(36) : disabled</span><o:p></o:p=
></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">20. FAN=
_CONTROL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(32) : enabeld</span><o:p></o:p>=
</p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">21. GFX=
_EDC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(25) : enabeld</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">22. GFX=
OFF &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (17) : disabled</span>=
<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">23. DPM=
_GFX_PACE &nbsp; &nbsp; &nbsp; &nbsp; ( 2) : disabled</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">24. MEM=
_VDDCI_SCALING &nbsp; &nbsp;( 8) : enabeld</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">25. MEM=
_MVDD_SCALING &nbsp; &nbsp; ( 9) : enabeld</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">26. DS_=
UCLK &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(14) : disabled</span>=
<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">27. GFX=
_ULV &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(15) : enabeld</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">28. FW_=
DSTATE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(16) : enabeld</span><o:p><=
/o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">29. BAC=
O &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (18) : enabeld</s=
pan><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">30. VCN=
_PG &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (19) : enabeld</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">31. JPE=
G_PG &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(20) : disabled</span>=
<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">32. USB=
_PG &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (21) : disabled</span>=
<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">33. RSM=
U_SMN_CG &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(22) : enabeld</span><o:p></o:p>=
</p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">34. APC=
C_PLUS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(26) : disabled</span><o:p>=
</o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">35. GTH=
R &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (27) : disabled</=
span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">36. GFX=
_DCS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(34) : disabled</span>=
<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">37. GFX=
_SS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (37) : enabeld</span><=
o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">38. OUT=
_OF_BAND_MONITOR &nbsp;(38) : disabled</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">39. TEM=
P_DEPENDENT_VMIN &nbsp;(39) : disabled</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">40. MMH=
UB_PG &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (40) : disabled</span><o:p>=
</o:p></p>
</div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:9.0pt;color:black">41. ATH=
UB_PG &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (41) : enabeld</span><o:p><=
/o:p></p>
</div>
<p class=3D"xmsonormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;=
</span><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wan=
g@amd.com">Kevin1.Wang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, July 25, 2019 1:11 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng-5C7GfCeVMHo@public.gmane.org">Kennet=
h.Feng-5C7GfCeVMHo@public.gmane.org</a>&gt;; Huang, Ray &lt;<a href=3D"mailto:Ray.Huang-5C7GfCeVMHo@public.gmane.org"=
>Ray.Huang-5C7GfCeVMHo@public.gmane.org</a>&gt;; Deucher, Alexander &lt;<a href=3D"mailto:Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;;
 Wang, Kevin(Yang) &lt;<a href=3D"mailto:Kevin1.Wang-5C7GfCeVMHo@public.gmane.org">Kevin1.Wang@a=
md.com</a>&gt;<br>
<b>Subject:</b> [PATCH 5/5] drm/amd/powerplay: implment sysfs feature statu=
s function in smu</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt">1. Unified feature e=
nable status format in sysfs<br>
2. Rename ppfeature to pp_features to adapt other pp sysfs node name<br>
3. this function support all asic, not asic related function.<br>
<br>
Signed-off-by: Kevin Wang &lt;<a href=3D"mailto:kevin1.wang-5C7GfCeVMHo@public.gmane.org">kevin1=
.wang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 24 &#43;--<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c&nbsp;&nbsp;&nbsp; |&nbsp; =
61 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/amdgpu_smu.h&nbsp;&nbsp;&nbsp; |&nbsp;&=
nbsp; 8 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp; | 165 --=
----------------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/vega20_ppt.c&nbsp;&nbsp;&nbsp; | 153 --=
--------------<br>
&nbsp;5 files changed, 75 insertions(&#43;), 336 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 866097d5cf26..9e8e8a65d9bf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -788,10 &#43;788,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struc=
t device *dev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * DOC: ppfeatures<br>
&#43; * DOC: pp_features<br>
&nbsp; *<br>
&nbsp; * The amdgpu driver provides a sysfs API for adjusting what powerpla=
y<br>
- * features to be enabled. The file ppfeatures is used for this. And<br>
&#43; * features to be enabled. The file pp_features is used for this. And<=
br>
&nbsp; * this is only available for Vega10 and later dGPUs.<br>
&nbsp; *<br>
&nbsp; * Reading back the file will show you the followings:<br>
@@ -803,7 &#43;803,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct =
device *dev,<br>
&nbsp; * the corresponding bit from original ppfeature masks and input the<=
br>
&nbsp; * new ppfeature masks.<br>
&nbsp; */<br>
-static ssize_t amdgpu_set_ppfeature_status(struct device *dev,<br>
&#43;static ssize_t amdgpu_set_pp_feature_status(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; const char *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; size_t count)<br>
@@ -820,7 &#43;820,7 @@ static ssize_t amdgpu_set_ppfeature_status(struct d=
evice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;featuremask=
 =3D 0x%llx\n&quot;, featuremask);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_set_ppfeature_status(&amp;adev-&gt;smu, featuremask)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_sys_set_pp_feature_mask(&amp;adev-&gt;smu, featu=
remask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerp=
lay.pp_funcs-&gt;set_ppfeature_status) {<br>
@@ -832,7 &#43;832,7 @@ static ssize_t amdgpu_set_ppfeature_status(struct d=
evice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count;<br>
&nbsp;}<br>
&nbsp;<br>
-static ssize_t amdgpu_get_ppfeature_status(struct device *dev,<br>
&#43;static ssize_t amdgpu_get_pp_feature_status(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct device_attribute *attr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; char *buf)<br>
&nbsp;{<br>
@@ -840,7 &#43;840,7 @@ static ssize_t amdgpu_get_ppfeature_status(struct d=
evice *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ddev-&gt;dev_private;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev=
)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return smu_get_ppfeature_status(&amp;adev-&gt;smu, buf);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return smu_sys_get_pp_feature_mask(&amp;adev-&gt;smu, buf);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (adev-&gt;powerp=
lay.pp_funcs-&gt;get_ppfeature_status)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return amdgpu_dpm_get_ppfeature_status(adev, buf);<br=
>
&nbsp;<br>
@@ -1500,9 &#43;1500,9 @@ static DEVICE_ATTR(gpu_busy_percent, S_IRUGO,<br>
&nbsp;static DEVICE_ATTR(mem_busy_percent, S_IRUGO,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_get_memory_busy_percent, NULL);<br>
&nbsp;static DEVICE_ATTR(pcie_bw, S_IRUGO, amdgpu_get_pcie_bw, NULL);<br>
-static DEVICE_ATTR(ppfeatures, S_IRUGO | S_IWUSR,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_get_ppfeature_status,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_set_ppfeature_status);<br>
&#43;static DEVICE_ATTR(pp_features, S_IRUGO | S_IWUSR,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_get_pp_feature_status,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_set_pp_feature_status);<br>
&nbsp;static DEVICE_ATTR(unique_id, S_IRUGO, amdgpu_get_unique_id, NULL);<b=
r>
&nbsp;<br>
&nbsp;static ssize_t amdgpu_hwmon_show_temp(struct device *dev,<br>
@@ -2960,10 &#43;2960,10 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *=
adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type &g=
t;=3D CHIP_VEGA10) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(=
adev-&gt;flags &amp; AMD_IS_APU)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D device_create_file(adev-&gt;dev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_ppfeatures);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dev_attr_pp_features);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;failed to create device file &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &quot;ppfeatures\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; &quot;pp_features\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -3017,7 &#43;3017,7 @@ void amdgpu_pm_sysfs_fini(struct amdgpu_device *a=
dev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_unique=
_id);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type &g=
t;=3D CHIP_VEGA10) &amp;&amp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(=
adev-&gt;flags &amp; AMD_IS_APU))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_ppfeatures);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; device_remove_file(adev-&gt;dev, &amp;dev_attr_pp_features);=
<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void amdgpu_pm_compute_clocks(struct amdgpu_device *adev)<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index e881de955388..90833ff2fe00 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -55,6 &#43;55,67 @@ const char *smu_get_feature_name(struct smu_context =
*smu, enum smu_feature_mask<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __smu_feature_names=
[feature];<br>
&nbsp;}<br>
&nbsp;<br>
&#43;size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)=
<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0, i =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2] =3D { 0 =
};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t feature_index =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t count =3D 0;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_m=
ask(smu, feature_mask, 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto failed;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size =3D&nbsp; sprintf(buf &#43; =
size, &quot;features high: 0x%08x low: 0x%08x\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_mask=
[1], feature_mask[0]);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_FEATURE_=
COUNT; i&#43;&#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; feature_index =3D smu_feature_get_index(smu, i);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (feature_index &lt; 0)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%02d. %-20s (%2d=
) : %s\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count&#43;&#43;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_get_feature_name(smu, i),<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_index,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !!smu_feature_is_enabled(smu, i) ? &quot;enab=
eld&quot; : &quot;disabled&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;failed:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
&#43;}<br>
&#43;<br>
&#43;int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_=
mask)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2] =3D { 0 =
};<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_2_enabled =3D 0;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_2_disabled =3D 0=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t feature_enables =3D 0;<b=
r>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_m=
ask(smu, feature_mask, 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return ret;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_enables =3D ((uint64_t)fe=
ature_mask[1] &lt;&lt; 32 | (uint64_t)feature_mask[0]);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_2_enabled&nbsp; =3D ~feat=
ure_enables &amp; new_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_2_disabled =3D feature_en=
ables &amp; ~new_mask;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_2_enabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_feature_update_enable_state(smu, feature_2_enabl=
ed, true);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (feature_2_disabled) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D smu_feature_update_enable_state(smu, feature_2_disab=
led, false);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&#43;}<br>
&#43;<br>
&nbsp;int smu_get_smc_version(struct smu_context *smu, uint32_t *if_version=
, uint32_t *smu_version)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/d=
rm/amd/powerplay/inc/amdgpu_smu.h<br>
index abc2644b4c07..ac9e9d5d8a5c 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h<br>
@@ -432,8 &#43;432,6 @@ struct pptable_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t *mclk_mask,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; uint32_t *soc_mask);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_cpu_power_state)=
(struct smu_context *smu);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_ppfeature_status)(struct sm=
u_context *smu, uint64_t ppfeatures);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_ppfeature_status)(struct sm=
u_context *smu, char *buf);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*is_dpm_running)(str=
uct smu_context *smu);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*tables_init)(struct =
smu_context *smu, struct smu_table *tables);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_thermal_fan_tabl=
e)(struct smu_context *smu);<br>
@@ -713,10 &#43;711,6 @@ struct smu_funcs<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;d=
pm_set_vce_enable ? (smu)-&gt;ppt_funcs-&gt;dpm_set_vce_enable((smu), (enab=
le)) : 0)<br>
&nbsp;#define smu_set_xgmi_pstate(smu, pstate) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;funcs-&gt;set_xgmi_pstate ? (smu)-&gt;func=
s-&gt;set_xgmi_pstate((smu), (pstate)) : 0)<br>
-#define smu_set_ppfeature_status(smu, ppfeatures) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;set_ppfeatur=
e_status ? (smu)-&gt;ppt_funcs-&gt;set_ppfeature_status((smu), (ppfeatures)=
) : -EINVAL)<br>
-#define smu_get_ppfeature_status(smu, buf) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;get_ppfeatur=
e_status ? (smu)-&gt;ppt_funcs-&gt;get_ppfeature_status((smu), (buf)) : -EI=
NVAL)<br>
&nbsp;#define smu_set_watermarks_table(smu, tab, clock_ranges) \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((smu)-&gt;ppt_funcs-&gt;s=
et_watermarks_table ? (smu)-&gt;ppt_funcs-&gt;set_watermarks_table((smu), (=
tab), (clock_ranges)) : 0)<br>
&nbsp;#define smu_get_current_clk_freq_by_table(smu, clk_type, value) \<br>
@@ -804,5 &#43;798,7 @@ bool smu_clk_dpm_is_enabled(struct smu_context *smu=
, enum smu_clk_type clk_type)<br>
&nbsp;int smu_feature_update_enable_state(struct smu_context *smu, uint64_t=
 feature_mask, bool enabled);<br>
&nbsp;const char *smu_get_message_name(struct smu_context *smu, enum smu_me=
ssage_type type);<br>
&nbsp;const char *smu_get_feature_name(struct smu_context *smu, enum smu_fe=
ature_mask feature);<br>
&#43;size_t smu_sys_get_pp_feature_mask(struct smu_context *smu, char *buf)=
;<br>
&#43;int smu_sys_set_pp_feature_mask(struct smu_context *smu, uint64_t new_=
mask);<br>
&nbsp;<br>
&nbsp;#endif<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index c873228bf05f..cd0920093a5e 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -1422,169 &#43;1422,6 @@ static int navi10_get_uclk_dpm_states(struct sm=
u_context *smu, uint32_t *clocks_<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static int navi10_get_ppfeature_status(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
har *buf)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *ppfeature_name[] =
=3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_PREFETCHER&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_GFXCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_GFX_PACE&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_UCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_SOCCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_MP0CLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_LINK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_DCEFCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MEM_VDDCI_SCALING&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MEM_MVDD_SCALING&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DS_GFXCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DS_SOCCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DS_LCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DS_DCEFCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DS_UCLK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX_ULV&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FW_DSTATE&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFXOFF&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;BACO&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;VCN_PG&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;JPEG_PG&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;USB_PG&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RSMU_SMN_CG&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;PPT&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;TDC&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX_EDC&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;APCC_PLUS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GTHR&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ACDC&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;VR0HOT&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;VR1HOT&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FW_CTF&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FAN_CONTROL&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;THERMAL&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX_DCS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;LED_DISPLAY&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX_SS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;OUT_OF_BAND_MONITOR&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;TEMP_DEPENDENT_VMIN&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MMHUB_PG&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ATHUB_PG&quot;};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *output_title[] =3D=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FEATURES&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;BITMASK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ENABLEMENT&quot;};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_mask(=
smu, feature_mask, 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[GetPPfeat=
ureStatus] Failed to get enabled smc features!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_enabled =3D (uint64_t)featur=
e_mask[0] |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (uint64_t)feature_mask[1] &lt;&lt; 32;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size,=
 &quot;Current ppfeatures: 0x%016llx\n&quot;, features_enabled);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size,=
 &quot;%-19s %-22s %s\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output_title[0],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output_title[1],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output_title[2]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; (sizeof(ppfeatur=
e_name) / sizeof(ppfeature_name[0])); i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%-19s 0x%016llx %6s\=
n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ppfeature_name[i],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 1ULL &lt;&lt; i,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (features_enabled &amp; (1ULL &lt;&lt; i)) ? &quot;Y&quot; : &quot;N&q=
uot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
-}<br>
-<br>
-static int navi10_enable_smc_features(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool en=
abled,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_=
t feature_masks)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_feature *feature =3D &amp;=
smu-&gt;smu_feature;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_low, feature_high;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_low =3D (uint32_t)(feature_ma=
sks &amp; 0xFFFFFFFF);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_high =3D (uint32_t)((feature_=
masks &amp; 0xFFFFFFFF00000000ULL) &gt;&gt; 32);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enabled) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeatur=
esLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_lo=
w);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeatur=
esHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_hi=
gh);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeatu=
resLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_lo=
w);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeatu=
resHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature_hi=
gh);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_mask(=
smu, feature_mask, 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;feature-&gt;mutex);<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bitmap_copy(feature-&gt;enabled, (uns=
igned long *)&amp;feature_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; feature-&gt;feature_num);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;feature-&gt;mutex);=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
-static int navi10_set_ppfeature_status(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
int64_t new_ppfeature_masks)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_enable;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_disable;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_mask(=
smu, feature_mask, 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[SetPPfeat=
ureStatus] Failed to get enabled smc features!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_enabled =3D (uint64_t)featur=
e_mask[0] |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (uint64_t)feature_mask[1] &lt;&lt; 32;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_to_disable =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; features_enabled &amp; ~new_ppfeature_masks;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_to_enable =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ~features_enabled &amp; new_ppfeature_masks;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;features_to_disable 0x=
%llx\n&quot;, features_to_disable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;features_to_enable 0x%=
llx\n&quot;, features_to_enable);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (features_to_disable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D navi10_enable_smc_features(smu, false, features_to_disab=
le);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[SetPPfeatureStatus] Failed to disabl=
e smc features!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (features_to_enable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D navi10_enable_smc_features(smu, true, features_to_enable=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; PP_ASSERT_WITH_CODE(!ret,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;[SetPPfeatureStatus] Failed to enable=
 smc features!&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static int navi10_set_peak_clock_by_device(struct smu_context *smu)<b=
r>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
@@ -1689,8 &#43;1526,6 @@ static const struct pptable_funcs navi10_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_watermarks_table =3D =
navi10_set_watermarks_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_sensor =3D navi10_re=
ad_sensor,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_uclk_dpm_states =3D n=
avi10_get_uclk_dpm_states,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D navi10_get_=
ppfeature_status,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D navi10_set_=
ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_performance_level =3D=
 navi10_set_performance_level,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_thermal_temperature_r=
ange =3D navi10_get_thermal_temperature_range,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/a=
md/powerplay/vega20_ppt.c<br>
index c06a9472c3b2..52c8fc9f1ff4 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c<br>
@@ -2858,157 &#43;2858,6 @@ static int vega20_dpm_set_vce_enable(struct smu=
_context *smu, bool enable)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_feature_set_ena=
bled(smu, SMU_FEATURE_DPM_VCE_BIT, enable);<br>
&nbsp;}<br>
&nbsp;<br>
-static int vega20_get_enabled_smc_features(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint64_t *features_enabled)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t feature_mask[2] =3D {0, 0};<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_feature_get_enabled_mask(=
smu, feature_mask, 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *features_enabled =3D ((((uint64_t)fe=
ature_mask[0] &lt;&lt; SMU_FEATURES_LOW_SHIFT) &amp; SMU_FEATURES_LOW_MASK)=
 |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (((uint64_t)feat=
ure_mask[1] &lt;&lt; SMU_FEATURES_HIGH_SHIFT) &amp; SMU_FEATURES_HIGH_MASK)=
);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-}<br>
-<br>
-static int vega20_enable_smc_features(struct smu_context *smu,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool enable, uint64_t feature_mask)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t smu_features_low, smu_featur=
es_high;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_features_low =3D (uint32_t)((feat=
ure_mask &amp; SMU_FEATURES_LOW_MASK) &gt;&gt; SMU_FEATURES_LOW_SHIFT);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_features_high =3D (uint32_t)((fea=
ture_mask &amp; SMU_FEATURES_HIGH_MASK) &gt;&gt; SMU_FEATURES_HIGH_SHIFT);<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeatur=
esLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_featur=
es_low);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_EnableSmuFeatur=
esHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_featur=
es_high);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeatu=
resLow,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_featur=
es_low);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D smu_send_smc_msg_with_param(smu, SMU_MSG_DisableSmuFeatu=
resHigh,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; smu_featur=
es_high);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-<br>
-}<br>
-<br>
-static int vega20_get_ppfeature_status(struct smu_context *smu, char *buf)=
<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *ppfeature_name[] =
=3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DPM_PREFETCHER&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFXCLK_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;UCLK_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;SOCCLK_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;UVD_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;VCE_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ULV&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MP0CLK_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;LINK_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DCEFCLK_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFXCLK_DS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;SOCCLK_DS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;LCLK_DS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;PPT&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;TDC&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;THERMAL&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX_PER_CU_CG&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DCEFCLK_DS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ACDC&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;VR0HOT&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;VR1HOT&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FW_CTF&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;LED_DISPLAY&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FAN_CONTROL&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFX_EDC&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;GFXOFF&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;CG&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FCLK_DPM&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FCLK_DS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MP1CLK_DS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MP0CLK_DS&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;XGMI&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ECC&quot;};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; static const char *output_title[] =3D=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;FEATURES&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;BITMASK&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;ENABLEMENT&quot;};<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int size =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_enabled_smc_featur=
es(smu, &amp;features_enabled);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size,=
 &quot;Current ppfeatures: 0x%016llx\n&quot;, features_enabled);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size &#43;=3D sprintf(buf &#43; size,=
 &quot;%-19s %-22s %s\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output_title[0],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output_title[1],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output_title[2]);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; GNLD_FEATURES_MA=
X; i&#43;&#43;) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size &#43;=3D sprintf(buf &#43; size, &quot;%-19s 0x%016llx %6s\=
n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ppfeature_name[i],<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 1ULL &lt;&lt; i,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (features_enabled &amp; (1ULL &lt;&lt; i)) ? &quot;Y&quot; : &quot;N&q=
uot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
-}<br>
-<br>
-static int vega20_set_ppfeature_status(struct smu_context *smu, uint64_t n=
ew_ppfeature_masks)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_enabled;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_enable;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t features_to_disable;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new_ppfeature_masks &gt;=3D (1ULL=
 &lt;&lt; GNLD_FEATURES_MAX))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D vega20_get_enabled_smc_featur=
es(smu, &amp;features_enabled);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_to_disable =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; features_enabled &amp; ~new_ppfeature_masks;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; features_to_enable =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ~features_enabled &amp; new_ppfeature_masks;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;features_to_disable 0x=
%llx\n&quot;, features_to_disable);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;features_to_enable 0x%=
llx\n&quot;, features_to_enable);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (features_to_disable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega20_enable_smc_features(smu, false, features_to_disab=
le);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (features_to_enable) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D vega20_enable_smc_features(smu, true, features_to_enable=
);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-}<br>
-<br>
&nbsp;static bool vega20_is_dpm_running(struct smu_context *smu)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
@@ -3311,8 &#43;3160,6 @@ static const struct pptable_funcs vega20_ppt_func=
s =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .force_dpm_limit_value =3D=
 vega20_force_dpm_limit_value,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .unforce_dpm_levels =3D ve=
ga20_unforce_dpm_levels,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_profiling_clk_mask =
=3D vega20_get_profiling_clk_mask,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_ppfeature_status =3D vega20_set_=
ppfeature_status,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_ppfeature_status =3D vega20_get_=
ppfeature_status,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_dpm_running =3D vega20=
_is_dpm_running,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_thermal_fan_table =3D=
 vega20_set_thermal_fan_table,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_fan_speed_percent =3D=
 vega20_get_fan_speed_percent,<br>
-- <br>
2.22.0<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB33098222156F946AA7EABB26ECC10MN2PR12MB3309namp_--

--===============0365835198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0365835198==--
