From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: Harmonize CIK ASIC support in radeon and amdgpu (v2)
Date: Wed, 26 Apr 2017 16:15:48 -0400
Message-ID: <588f3a43-3f29-e733-1ffd-154878303f0f@amd.com>
References: <1491866474-1016-1-git-send-email-Felix.Kuehling@amd.com>
 <ac35e641-6fd9-a5d1-c4d9-35e71fa9eb08@daenzer.net>
 <cbcc54ec-c86f-f0eb-715e-f66790b5f964@amd.com>
 <340a5310-e6d1-5e09-81aa-d7106bcdca02@daenzer.net>
 <dedfed15-00b3-83ff-aca7-f4dffff8cc09@amd.com>
 <4bd2c7cf-a555-6cee-a863-b56ee824f9ad@daenzer.net>
 <f2f87cd4-c6c5-7c62-3035-d2f1584d7f00@amd.com>
 <cebca833-9e3f-86c5-8100-feca6ea590e5@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------A6AF2110F14533662A875FCB"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cebca833-9e3f-86c5-8100-feca6ea590e5-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------A6AF2110F14533662A875FCB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On 17-04-25 02:28 AM, Michel Dänzer wrote:
> On 22/04/17 02:05 AM, Felix Kuehling wrote:
>> __setup doesn't work in modules.
> Right. We could build something like
> drivers/video/fbdev/core/fb_cmdline.c:video_setup() into the kernel to
> handle this, but it's a bit ugly, which is one reason why I was leaning
> towards:
>
>
>> s8250_options is only compiled if the driver is not a module.
> That doesn't prevent us from using __module_param_call directly, does it?
>
> Although, that still doesn't work as I envision if only one driver's
> option is set e.g. in /etc/modprobe.d/*.conf .
>
>
> So, I'm starting to think we need a shared module for this, which
> provides one or multiple module parameters to choose which driver to use
> for CIK/SI[0], and provides the result to the amdgpu/radeon drivers.
> That might make things easier for amdgpu-pro / other standalone amdgpu
> versions in the long run as well, as they could add files to
> /etc/modprobe.d/ choosing themselves by default, without having to
> blacklist radeon.
>
> What do you guys think?

Hi Michel,

You said in an earlier email that it doesn't have to be convenient. With
that in mind, I went back to a minimalistic solution that doesn't need
any additional Kconfig options and only uses two module parameters (one
in radeon, one in amdgpu).

I'm attaching my WIP patches for reference (currently based on
amd-kfd-staging). For an official review I'd rebase them on
amd-staging-4.9, remove the #if-0-ed hack that didn't work out, and add
the same for SI.

Can everyone can agree that this is good enough?

Regards,
  Felix

>
>
> [0] or possibly even more fine-grained in the future
>


--------------A6AF2110F14533662A875FCB
Content-Type: text/x-patch;
	name="0001-drm-radeon-Add-module-param-to-control-CIK-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-drm-radeon-Add-module-param-to-control-CIK-support.patc";
	filename*1="h"

>From e1d5fc320dbe2f60d922c466986863489f4bfe77 Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 20 Apr 2017 14:41:34 -0400
Subject: [PATCH 1/2] drm/radeon: Add module param to control CIK support

If AMDGPU supports CIK, add a module parameter to control CIK
support in radeon. It's off by default in radeon, while it will be
on by default in AMDGPU.

Change-Id: Ib594f7359b9b3143c859b3be5c0244a9a2a773cd
Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/radeon/radeon.h     |  4 ++++
 drivers/gpu/drm/radeon/radeon_drv.c |  6 ++++++
 drivers/gpu/drm/radeon/radeon_kms.c | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 5f16bf3..a05aaea 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -116,6 +116,10 @@
 extern int radeon_uvd;
 extern int radeon_vce;
 
+#ifdef CONFIG_DRM_AMDGPU_CIK
+extern int radeon_cik_support;
+#endif
+
 /*
  * Copy from radeon_drv.h so we don't have to include both and have conflicting
  * symbol;
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 2e5d680..2cdb01b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -301,6 +301,12 @@ static inline void radeon_unregister_atpx_handler(void) {}
 MODULE_PARM_DESC(vce, "vce enable/disable vce support (1 = enable, 0 = disable)");
 module_param_named(vce, radeon_vce, int, 0444);
 
+#ifdef CONFIG_DRM_AMDGPU_CIK
+int radeon_cik_support = 0;
+MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled (default))");
+module_param_named(cik_support, radeon_cik_support, int, 0444);
+#endif
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index d6d58bc..28ab255 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -99,6 +99,24 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	struct radeon_device *rdev;
 	int r, acpi_status;
 
+#ifdef CONFIG_DRM_AMDGPU_CIK
+	if (!radeon_cik_support) {
+		switch (flags & RADEON_FAMILY_MASK) {
+		case CHIP_KAVERI:
+		case CHIP_BONAIRE:
+		case CHIP_HAWAII:
+		case CHIP_KABINI:
+		case CHIP_MULLINS:
+			dev_warn(dev->dev,
+				 "CIK support provided by amdgpu.\n");
+			dev_warn(dev->dev,
+		"Use radeon.cik_support=1 amdgpu.cik_support=0 to override.\n"
+				);
+			return -ENODEV;
+		}
+	}
+#endif
+
 	rdev = kzalloc(sizeof(struct radeon_device), GFP_KERNEL);
 	if (rdev == NULL) {
 		return -ENOMEM;
-- 
1.9.1


--------------A6AF2110F14533662A875FCB
Content-Type: text/x-patch;
	name="0002-drm-amdgpu-Add-module-param-to-control-CIK-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-drm-amdgpu-Add-module-param-to-control-CIK-support.patc";
	filename*1="h"

>From 18d4b8b6282215073c3c6762f36c9009b1218f3c Mon Sep 17 00:00:00 2001
From: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Date: Thu, 20 Apr 2017 14:42:04 -0400
Subject: [PATCH 2/2] drm/amdgpu: Add module param to control CIK support

If AMDGPU supports CIK, add a module parameter to control CIK
support. It's on by default in AMDGPU, while it is off by default
in radeon.

Change-Id: Ica1296beae96b1c5f48698c06cfd2453fe1ff080
Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 41 ++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 15 ++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e6e623a..eaf980d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -113,6 +113,10 @@
 extern int amdgpu_cntl_sb_buf_per_se;
 extern int amdgpu_param_buf_per_se;
 
+#ifdef CONFIG_DRM_AMDGPU_CIK
+extern int amdgpu_cik_support;
+#endif
+
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d19ac0f..654a782 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -239,6 +239,12 @@
 MODULE_PARM_DESC(param_buf_per_se, "the size of Off-Chip Pramater Cache per Shader Engine (default depending on gfx)");
 module_param_named(param_buf_per_se, amdgpu_param_buf_per_se, int, 0444);
 
+#ifdef CONFIG_DRM_AMDGPU_CIK
+int amdgpu_cik_support = 1;
+MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
+module_param_named(cik_support, amdgpu_cik_support, int, 0444);
+#endif
+
 
 static const struct pci_device_id pciidlist[] = {
 #ifdef  CONFIG_DRM_AMDGPU_SI
@@ -787,12 +793,45 @@ long amdgpu_drm_ioctl(struct file *filp,
 	.driver.pm = &amdgpu_pm_ops,
 };
 
-
+#if 0
+static int radeon_cik_support = 0;
+static int param_set(const char *val, const struct kernel_param *kp)
+{
+	return kstrtoint(val, 0, kp.arg);
+}
+static struct kernel_param_ops radeon_force_cik_param_ops = {
+	.flags = 0,
+	.set = param_set,
+	.get = NULL,
+	.free = NULL
+};
+static struct kernel_param radeon_cik_support_param = {
+	.name = "radeon.cik_support",
+	.mod = THIS_MODULE,
+	.ops = radeon_cik_support_param_ops,
+	.perm = 0444,
+	.level = -1,
+	.flags = 0,
+	.arg = &radeon_cik_support
+};
+#endif
 
 static int __init amdgpu_init(void)
 {
 	int r;
 
+#if 0
+	/* Doesn't work because saved_command_line isn't exported to
+	 * modules */
+	r = parse_args("amdgpu", saved_command_line,
+		       &radeon_cik_support_param, 1,
+		       -32768, 32767, NULL, NULL);
+	if (r)
+		return r;
+
+	amdgpu_cik_support = !radeon_cik_support;
+#endif
+
 	r = amdgpu_sync_init();
 	if (r)
 		goto error_sync;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6443e24..e51c92f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -88,6 +88,21 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	struct amdgpu_device *adev;
 	int r, acpi_status;
 
+#ifdef CONFIG_DRM_AMDGPU_CIK
+	if (!amdgpu_cik_support) {
+		switch (flags & AMD_ASIC_MASK) {
+		case CHIP_KAVERI:
+		case CHIP_BONAIRE:
+		case CHIP_HAWAII:
+		case CHIP_KABINI:
+		case CHIP_MULLINS:
+			dev_warn(dev->dev,
+				 "CIK support disabled by module param\n");
+			return -ENODEV;
+		}
+	}
+#endif
+
 	adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);
 	if (adev == NULL) {
 		return -ENOMEM;
-- 
1.9.1


--------------A6AF2110F14533662A875FCB
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------A6AF2110F14533662A875FCB--
