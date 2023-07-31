Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A17FC0015E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 08:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B0010E327;
	Tue,  1 Aug 2023 08:27:47 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.36 at gabe;
 Mon, 31 Jul 2023 10:00:32 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42A710E1C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690797631; x=1691402431; i=spasswolf@web.de;
 bh=9RQG2VbKYDSZuh4TP7WDRuMW4rpRHwsYs5UOzzjkLj8=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
 b=g+FomkFN/G4cKl20y4LwL25R1z0qgFTX4xYwggbVOQ6tQfL34U1JEDGRR1/4qayd6tDc2W3
 cEbfMnf6Ziui2idyEczs+fYHMMCgNhp8MZBRPJxm4xdUS45nS/dytNY3hlbiYzvb4S5bpCgL/
 sq4jC9L0I6BIp/EW6ZtZ9jLJEVCZKxkdZP0X4l5gWuaADXgCWLKPr3xCl9mUPCInrtIfJRfAv
 hfC6lU1elDT3BzKPjKQ/dOfSi8SgDMaGMj0OIlN5tg+z4tluKOuNhZo88wxhsaQSUPJs5Cgte
 gxD0QofOpNbrQNi2N/Qx73Gi+SZGrBXhN4XypR6LhtDh9AGfapsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwR4R-1pYART2esX-00sHE8; Mon, 31
 Jul 2023 11:55:22 +0200
Message-ID: <ed355ece1ef4da99c020f311c0c34933c75d869a.camel@web.de>
Subject: [PATCH] gpu: drm: amd: amdgpu: Fix calls to dev_{info,err}
From: Bert Karwatzki <spasswolf@web.de>
To: amd-gfx@lists.freedesktop.org
Date: Mon, 31 Jul 2023 11:55:22 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sagmMBdln4kotc5WAJSE2EDH4MtFJpUf0BkTvDK1t0N43RGuYys
 12S5c0aFS5+SRjqzkwxtUyPACZIBt/1HOMXK9xvjcl5hCagYaZiZmd6O4kkkRQnNkgNMtDY
 AVcyWlqG3Tk+lZ/cBzmIKtI9PscSebmSVinI1JLcZO7uuj6Fl+2BRXUUbbV7OcFgKhudObI
 Vt+6Tp5jKhTk4gte8Em4A==
UI-OutboundReport: notjunk:1;M01:P0:6g1a09C2hkU=;v53oG2KkmG2S8lD+JGCKhOrqXb3
 ca0CAuDkao9lBW2fNfNt5ekRQMcZOOCEhnJM+bqnw7VmGGFMz1mC9WXDKt4EHEPUXFygyMUp4
 ioW1lkgsCiwA/ag5Lw6JV81dUEqcxSu/OqSfgULwbd93fVWZQIXPNNq8+iDT39sRk/JXr/n2o
 pgcisNxfM3HvdCGv/bz50tuERr/5GPopxN1Zuz7O/RGS2p//au5NRZ+tKQY1Pu/+8GpG7Uv+N
 hH5tOsBoqsgU5b7uOBs/e92bYRIQk/xY3OpIaxLNYywnWjmXf5PvF4uzvoJZt+ozG9tcoLz4F
 RaBbYrclox7Asocr9SuBOtiQ4Hs5j4HEg/8mWiKLGL+b0yyM0M+Evcs1O/Sk8YHnoquvfiAFR
 DF5A2tHAc/T8E6gP8vqkXognZf18dLYnJ0hb0mgCQ8RPEZJZcPrrxSDtc7G75MljC75KrwBqF
 UeEOLk7yZLvszIBTKEAreelkrvibN4DLBsDsYiLSmkGXC5+seZeSzesJGlN9TxYtnMRfRJU4S
 mpWXorXt8/WrVraTmVfwDmbVjNIYHlVzvRepPUlNR6kqTvY0hBHECnWTCeWsJalhEax4BCCVN
 ivFoN0c+ODWMvFLahF5ou+2zlYijNjzsxrGEKMNjtD7WDfQYBLKhE/QrBdDEGi31tJV2JoYm5
 ny2jKvA5T60WeZWu1s9/XDcUmPk6rcYCbpVECLBTfyhWQa3yXRuEgUS8HE35cCiJdlSjsPlJr
 b/c+N77nt3mRr9mhz0AHOpf1nmfE6c9dr4phz3Q0D2kp60twfcIlb45Z901bzAIikVhQM+Fkx
 ZF+pAw8jtnCPJU+Ae8oHJXgkAWC4SiMIUJtKoexG8z3L2aO37Jngn/P8JlqJ+twPX4MQ/+MzZ
 queetHOMPDsZ+VCd7YCWv9JjIzVaHYVZGFeoybHfp8sH40m2mXeSS1cLJcxMDEGkLe3k0EBo3
 NHIvPF2LqGSrkxzgKShY1f9947A=
X-Mailman-Approved-At: Tue, 01 Aug 2023 08:27:46 +0000
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "SHANMUGAM,
 SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Commit b0bd0a92b8158ea9c809d885e0f0c21518bdbd14 introduced
dev_{info,err} calls which failed (leading to a hang on boot) because of a=
n
incorrect usage of the container_of macro. This fixes the error by introdu=
cing
a pointer to the device as an additional element in struct amdgpu_atpx and
struct radeon_atpx.

Fixes: https://gitlab.freedesktop.org/drm/amd/-/issues/2744
Signed-off-by: Bert Karwatzki <spasswolf@web.de>
=2D--
 .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 40 +++++++++----------
 drivers/gpu/drm/radeon/radeon_atpx_handler.c  | 30 +++++++-------
 2 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 6f241c574665..29242ecec7b0 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -37,6 +37,7 @@ struct amdgpu_atpx_functions {

 struct amdgpu_atpx {
 	acpi_handle handle;
+	struct device *dev;
 	struct amdgpu_atpx_functions functions;
 	bool is_hybrid;
 	bool dgpu_req_power_for_displays;
@@ -104,22 +105,20 @@ void *amdgpu_atpx_get_dhandle(void)
 /**
  * amdgpu_atpx_call - call an ATPX method
  *
- * @handle: acpi handle
+ * @atpx: amdgpu atpx struct
  * @function: the ATPX function to execute
  * @params: ATPX function params
  *
  * Executes the requested ATPX function (all asics).
  * Returns a pointer to the acpi output buffer.
  */
-static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int functi=
on,
+static union acpi_object *amdgpu_atpx_call(struct amdgpu_atpx *atpx, int
function,
 					   struct acpi_buffer *params)
 {
 	acpi_status status;
 	union acpi_object atpx_arg_elements[2];
 	struct acpi_object_list atpx_arg;
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev =3D container_of(handle, struct acpi_device,
handle);
-	struct device *dev =3D &adev->dev;

 	atpx_arg.count =3D 2;
 	atpx_arg.pointer =3D &atpx_arg_elements[0];
@@ -137,11 +136,11 @@ static union acpi_object *amdgpu_atpx_call(acpi_hand=
le
handle, int function,
 		atpx_arg_elements[1].integer.value =3D 0;
 	}

-	status =3D acpi_evaluate_object(handle, NULL, &atpx_arg, &buffer);
+	status =3D acpi_evaluate_object(atpx->handle, NULL, &atpx_arg, &buffer);

 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
-		dev_err(dev, "failed to evaluate ATPX got %s\n",
+		dev_err(atpx->dev, "failed to evaluate ATPX got %s\n",
 			acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
@@ -183,15 +182,13 @@ static void amdgpu_atpx_parse_functions(struct
amdgpu_atpx_functions *f, u32 mas
 static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
 {
 	u32 valid_bits =3D 0;
-	struct acpi_device *adev =3D container_of(atpx->handle, struct
acpi_device, handle);
-	struct device *dev =3D &adev->dev;

 	if (atpx->functions.px_params) {
 		union acpi_object *info;
 		struct atpx_px_params output;
 		size_t size;

-		info =3D amdgpu_atpx_call(atpx->handle,
ATPX_FUNCTION_GET_PX_PARAMETERS, NULL);
+		info =3D amdgpu_atpx_call(atpx, ATPX_FUNCTION_GET_PX_PARAMETERS,
NULL);
 		if (!info)
 			return -EIO;

@@ -199,7 +196,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *at=
px)

 		size =3D *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
+			dev_err(atpx->dev, "ATPX buffer is too small: %zu\n",
size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -232,11 +229,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *=
atpx)
 	atpx->is_hybrid =3D false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
 		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
-			dev_info(dev, "ATPX Hybrid Graphics, forcing to
ATPX\n");
+			dev_info(atpx->dev, "ATPX Hybrid Graphics, forcing to
ATPX\n");
 			atpx->functions.power_cntl =3D true;
 			atpx->is_hybrid =3D false;
 		} else {
-			dev_info(dev, "ATPX Hybrid Graphics\n");
+			dev_info(atpx->dev, "ATPX Hybrid Graphics\n");
 			/*
 			 * Disable legacy PM methods only when pcie port PM is
usable,
 			 * otherwise the device might fail to power off or
power on.
@@ -269,10 +266,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu=
_atpx
*atpx)
 	struct atpx_verify_interface output;
 	size_t size;
 	int err =3D 0;
-	struct acpi_device *adev =3D container_of(atpx->handle, struct
acpi_device, handle);
-	struct device *dev =3D &adev->dev;

-	info =3D amdgpu_atpx_call(atpx->handle, ATPX_FUNCTION_VERIFY_INTERFACE,
NULL);
+	info =3D amdgpu_atpx_call(atpx, ATPX_FUNCTION_VERIFY_INTERFACE, NULL);
 	if (!info)
 		return -EIO;

@@ -280,7 +275,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_=
atpx
*atpx)

 	size =3D *(u16 *) info->buffer.pointer;
 	if (size < 8) {
-		printk("ATPX buffer is too small: %zu\n", size);
+		dev_err(atpx->dev, "ATPX buffer is too small: %zu\n", size);
 		err =3D -EINVAL;
 		goto out;
 	}
@@ -289,7 +284,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_=
atpx
*atpx)
 	memcpy(&output, info->buffer.pointer, size);

 	/* TODO: check version? */
-	dev_info(dev, "ATPX version %u, functions 0x%08x\n",
+	dev_info(atpx->dev, "ATPX version %u, functions 0x%08x\n",
 		 output.version, output.function_bits);

 	amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
@@ -320,7 +315,7 @@ static int amdgpu_atpx_set_discrete_state(struct amdgp=
u_atpx
*atpx, u8 state)
 		input.dgpu_state =3D state;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D amdgpu_atpx_call(atpx->handle,
+		info =3D amdgpu_atpx_call(atpx,
 					ATPX_FUNCTION_POWER_CONTROL,
 					&params);
 		if (!info)
@@ -356,7 +351,7 @@ static int amdgpu_atpx_switch_disp_mux(struct amdgpu_a=
tpx
*atpx, u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D amdgpu_atpx_call(atpx->handle,
+		info =3D amdgpu_atpx_call(atpx,
 					ATPX_FUNCTION_DISPLAY_MUX_CONTROL,
 					&params);
 		if (!info)
@@ -388,7 +383,7 @@ static int amdgpu_atpx_switch_i2c_mux(struct amdgpu_at=
px
*atpx, u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D amdgpu_atpx_call(atpx->handle,
+		info =3D amdgpu_atpx_call(atpx,
 					ATPX_FUNCTION_I2C_MUX_CONTROL,
 					&params);
 		if (!info)
@@ -420,7 +415,7 @@ static int amdgpu_atpx_switch_start(struct amdgpu_atpx
*atpx, u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D amdgpu_atpx_call(atpx->handle,
+		info =3D amdgpu_atpx_call(atpx,
					ATPX_FUNCTION_GRAPHICS_DEVICE_SWITCH_START_NOTIFICATION,
 					&params);
 		if (!info)
@@ -452,7 +447,7 @@ static int amdgpu_atpx_switch_end(struct amdgpu_atpx *=
atpx,
u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D amdgpu_atpx_call(atpx->handle,
+		info =3D amdgpu_atpx_call(atpx,
					ATPX_FUNCTION_GRAPHICS_DEVICE_SWITCH_END_NOTIFICATION,
 					&params);
 		if (!info)
@@ -533,6 +528,7 @@ static bool amdgpu_atpx_pci_probe_handle(struct pci_de=
v
*pdev)
 	}
 	amdgpu_atpx_priv.dhandle =3D dhandle;
 	amdgpu_atpx_priv.atpx.handle =3D atpx_handle;
+	amdgpu_atpx_priv.atpx.dev =3D &pdev->dev;
 	return true;
 }

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index fb4d931fdf18..f6a005520b55 100644
=2D-- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -26,6 +26,7 @@ struct radeon_atpx_functions {

 struct radeon_atpx {
 	acpi_handle handle;
+	struct device *dev;
 	struct radeon_atpx_functions functions;
 	bool is_hybrid;
 	bool dgpu_req_power_for_displays;
@@ -87,15 +88,13 @@ bool radeon_atpx_dgpu_req_power_for_displays(void) {
  * Executes the requested ATPX function (all asics).
  * Returns a pointer to the acpi output buffer.
  */
-static union acpi_object *radeon_atpx_call(acpi_handle handle, int functi=
on,
+static union acpi_object *radeon_atpx_call(struct radeon_atpx *atpx, int
function,
 					   struct acpi_buffer *params)
 {
 	acpi_status status;
 	union acpi_object atpx_arg_elements[2];
 	struct acpi_object_list atpx_arg;
 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_device *adev =3D container_of(handle, struct acpi_device,
handle);
-	struct device *dev =3D &adev->dev;

 	atpx_arg.count =3D 2;
 	atpx_arg.pointer =3D &atpx_arg_elements[0];
@@ -113,11 +112,11 @@ static union acpi_object *radeon_atpx_call(acpi_hand=
le
handle, int function,
 		atpx_arg_elements[1].integer.value =3D 0;
 	}

-	status =3D acpi_evaluate_object(handle, NULL, &atpx_arg, &buffer);
+	status =3D acpi_evaluate_object(atpx->handle, NULL, &atpx_arg, &buffer);

 	/* Fail only if calling the method fails and ATPX is supported */
 	if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
-		dev_err(dev, "failed to evaluate ATPX got %s\n",
+		dev_err(atpx->dev, "failed to evaluate ATPX got %s\n",
 			acpi_format_exception(status));
 		kfree(buffer.pointer);
 		return NULL;
@@ -159,15 +158,13 @@ static void radeon_atpx_parse_functions(struct
radeon_atpx_functions *f, u32 mas
 static int radeon_atpx_validate(struct radeon_atpx *atpx)
 {
 	u32 valid_bits =3D 0;
-	struct acpi_device *adev =3D container_of(atpx->handle, struct
acpi_device, handle);
-	struct device *dev =3D &adev->dev;

 	if (atpx->functions.px_params) {
 		union acpi_object *info;
 		struct atpx_px_params output;
 		size_t size;

-		info =3D radeon_atpx_call(atpx->handle,
ATPX_FUNCTION_GET_PX_PARAMETERS, NULL);
+		info =3D radeon_atpx_call(atpx, ATPX_FUNCTION_GET_PX_PARAMETERS,
NULL);
 		if (!info)
 			return -EIO;

@@ -175,7 +172,7 @@ static int radeon_atpx_validate(struct radeon_atpx *at=
px)

 		size =3D *(u16 *) info->buffer.pointer;
 		if (size < 10) {
-			dev_err(dev, "ATPX buffer is too small: %zu\n", size);
+			dev_err(atpx->dev, "ATPX buffer is too small: %zu\n",
size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -206,7 +203,7 @@ static int radeon_atpx_validate(struct radeon_atpx *at=
px)

 	atpx->is_hybrid =3D false;
 	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
-		dev_info(dev, "ATPX Hybrid Graphics\n");
+		dev_info(atpx->dev, "ATPX Hybrid Graphics\n");
 		/*
 		 * Disable legacy PM methods only when pcie port PM is usable,
 		 * otherwise the device might fail to power off or power on.
@@ -235,7 +232,7 @@ static int radeon_atpx_verify_interface(struct radeon_=
atpx
*atpx)
 	size_t size;
 	int err =3D 0;

-	info =3D radeon_atpx_call(atpx->handle, ATPX_FUNCTION_VERIFY_INTERFACE,
NULL);
+	info =3D radeon_atpx_call(atpx, ATPX_FUNCTION_VERIFY_INTERFACE, NULL);
 	if (!info)
 		return -EIO;

@@ -283,7 +280,7 @@ static int radeon_atpx_set_discrete_state(struct radeo=
n_atpx
*atpx, u8 state)
 		input.dgpu_state =3D state;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D radeon_atpx_call(atpx->handle,
+		info =3D radeon_atpx_call(atpx,
 					ATPX_FUNCTION_POWER_CONTROL,
 					&params);
 		if (!info)
@@ -319,7 +316,7 @@ static int radeon_atpx_switch_disp_mux(struct radeon_a=
tpx
*atpx, u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D radeon_atpx_call(atpx->handle,
+		info =3D radeon_atpx_call(atpx,
 					ATPX_FUNCTION_DISPLAY_MUX_CONTROL,
 					&params);
 		if (!info)
@@ -351,7 +348,7 @@ static int radeon_atpx_switch_i2c_mux(struct radeon_at=
px
*atpx, u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D radeon_atpx_call(atpx->handle,
+		info =3D radeon_atpx_call(atpx,
 					ATPX_FUNCTION_I2C_MUX_CONTROL,
 					&params);
 		if (!info)
@@ -383,7 +380,7 @@ static int radeon_atpx_switch_start(struct radeon_atpx
*atpx, u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D radeon_atpx_call(atpx->handle,
+		info =3D radeon_atpx_call(atpx,
					ATPX_FUNCTION_GRAPHICS_DEVICE_SWITCH_START_NOTIFICATION,
 					&params);
 		if (!info)
@@ -415,7 +412,7 @@ static int radeon_atpx_switch_end(struct radeon_atpx *=
atpx,
u16 mux_id)
 		input.mux =3D mux_id;
 		params.length =3D input.size;
 		params.pointer =3D &input;
-		info =3D radeon_atpx_call(atpx->handle,
+		info =3D radeon_atpx_call(atpx,
					ATPX_FUNCTION_GRAPHICS_DEVICE_SWITCH_END_NOTIFICATION,
 					&params);
 		if (!info)
@@ -495,6 +492,7 @@ static bool radeon_atpx_pci_probe_handle(struct pci_de=
v
*pdev)

 	radeon_atpx_priv.dhandle =3D dhandle;
 	radeon_atpx_priv.atpx.handle =3D atpx_handle;
+	radeon_atpx_priv.atpx.dev =3D &pdev->dev;
 	return true;
 }

=2D-
2.39.2

If the introduction of new elements to {amdgpu,radeon}_atpx is to not want=
ed I
think using pr_{info,err} instead of dev_{info_err} is fine here.

Bert Karwatzki
