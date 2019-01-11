From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Fully remove i2caux folder
Date: Fri, 11 Jan 2019 20:03:23 +0000
Message-ID: <BN6PR12MB180988BFAFE11BCE45991B04F7850@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1547222088-20247-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0531173456=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1547222088-20247-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0531173456==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180988BFAFE11BCE45991B04F7850BN6PR12MB1809namp_"

--_000_BN6PR12MB180988BFAFE11BCE45991B04F7850BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of sunpeng.=
li-5C7GfCeVMHo@public.gmane.org <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, January 11, 2019 10:54:48 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Li, Sun peng (Leo); Francis, David; Wentland, Harry
Subject: [PATCH] drm/amd/display: Fully remove i2caux folder

From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>

This is a follow up to:
e28e1490794d ("drm/amd/display: Remove i2caux folder")

Some files were still left, so delete all of them.

CC: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
CC: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/display/dc/i2caux/Makefile     |  99 ----
 .../dc/i2caux/dce110/i2c_hw_engine_dce110.c        | 573 -----------------=
----
 .../amd/display/dc/i2caux/dce112/i2caux_dce112.c   | 129 -----
 .../amd/display/dc/i2caux/dce112/i2caux_dce112.h   |  32 --
 .../display/dc/i2caux/dce80/i2c_sw_engine_dce80.c  | 163 ------
 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c     | 491 -----------------=
-
 6 files changed, 1487 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/Makefile
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_eng=
ine_dce110.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce=
112.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce=
112.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engi=
ne_dce80.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c

diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/Makefile b/drivers/gpu/d=
rm/amd/display/dc/i2caux/Makefile
deleted file mode 100644
index 352885c..0000000
--- a/drivers/gpu/drm/amd/display/dc/i2caux/Makefile
+++ /dev/null
@@ -1,99 +0,0 @@
-#
-# Copyright 2017 Advanced Micro Devices, Inc.
-#
-# Permission is hereby granted, free of charge, to any person obtaining a
-# copy of this software and associated documentation files (the "Software"=
),
-# to deal in the Software without restriction, including without limitatio=
n
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,
-# and/or sell copies of the Software, and to permit persons to whom the
-# Software is furnished to do so, subject to the following conditions:
-#
-# The above copyright notice and this permission notice shall be included =
in
-# all copies or substantial portions of the Software.
-#
-# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
-# OTHER DEALINGS IN THE SOFTWARE.
-#
-#
-# Makefile for the 'i2c' sub-component of DAL.
-# It provides the control and status of HW i2c engine of the adapter.
-
-I2CAUX =3D aux_engine.o engine_base.o i2caux.o i2c_engine.o \
-        i2c_generic_hw_engine.o i2c_hw_engine.o i2c_sw_engine.o
-
-AMD_DAL_I2CAUX =3D $(addprefix $(AMDDALPATH)/dc/i2caux/,$(I2CAUX))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX)
-
-##########################################################################=
#####
-# DCE 8x family
-##########################################################################=
#####
-I2CAUX_DCE80 =3D i2caux_dce80.o i2c_hw_engine_dce80.o \
-       i2c_sw_engine_dce80.o
-
-AMD_DAL_I2CAUX_DCE80 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce80/,$(I2CA=
UX_DCE80))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX_DCE80)
-
-##########################################################################=
#####
-# DCE 100 family
-##########################################################################=
#####
-I2CAUX_DCE100 =3D i2caux_dce100.o
-
-AMD_DAL_I2CAUX_DCE100 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce100/,$(I2=
CAUX_DCE100))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX_DCE100)
-
-##########################################################################=
#####
-# DCE 110 family
-##########################################################################=
#####
-I2CAUX_DCE110 =3D i2caux_dce110.o i2c_sw_engine_dce110.o i2c_hw_engine_dce=
110.o \
-       aux_engine_dce110.o
-
-AMD_DAL_I2CAUX_DCE110 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce110/,$(I2=
CAUX_DCE110))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX_DCE110)
-
-##########################################################################=
#####
-# DCE 112 family
-##########################################################################=
#####
-I2CAUX_DCE112 =3D i2caux_dce112.o
-
-AMD_DAL_I2CAUX_DCE112 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce112/,$(I2=
CAUX_DCE112))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX_DCE112)
-
-##########################################################################=
#####
-# DCN 1.0 family
-##########################################################################=
#####
-ifdef CONFIG_DRM_AMD_DC_DCN1_0
-I2CAUX_DCN1 =3D i2caux_dcn10.o
-
-AMD_DAL_I2CAUX_DCN1 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dcn10/,$(I2CAU=
X_DCN1))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX_DCN1)
-endif
-
-##########################################################################=
#####
-# DCE 120 family
-##########################################################################=
#####
-I2CAUX_DCE120 =3D i2caux_dce120.o
-
-AMD_DAL_I2CAUX_DCE120 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce120/,$(I2=
CAUX_DCE120))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX_DCE120)
-
-##########################################################################=
#####
-# Diagnostics on FPGA
-##########################################################################=
#####
-I2CAUX_DIAG =3D i2caux_diag.o
-
-AMD_DAL_I2CAUX_DIAG =3D $(addprefix $(AMDDALPATH)/dc/i2caux/diagnostics/,$=
(I2CAUX_DIAG))
-
-AMD_DISPLAY_FILES +=3D $(AMD_DAL_I2CAUX_DIAG)
-
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce=
110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
deleted file mode 100644
index 1373501..0000000
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c
+++ /dev/null
@@ -1,573 +0,0 @@
-/*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
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
- * Authors: AMD
- *
- */
-
-#include "dm_services.h"
-#include "include/logger_interface.h"
-/*
- * Pre-requisites: headers required by header of this unit
- */
-
-#include "include/i2caux_interface.h"
-#include "../engine.h"
-#include "../i2c_engine.h"
-#include "../i2c_hw_engine.h"
-#include "../i2c_generic_hw_engine.h"
-/*
- * Header of this unit
- */
-
-#include "i2c_hw_engine_dce110.h"
-
-/*
- * Post-requisites: headers required by this unit
- */
-#include "reg_helper.h"
-
-/*
- * This unit
- */
-#define DC_LOGGER \
-               hw_engine->base.base.base.ctx->logger
-
-enum dc_i2c_status {
-       DC_I2C_STATUS__DC_I2C_STATUS_IDLE,
-       DC_I2C_STATUS__DC_I2C_STATUS_USED_BY_SW,
-       DC_I2C_STATUS__DC_I2C_STATUS_USED_BY_HW
-};
-
-enum dc_i2c_arbitration {
-       DC_I2C_ARBITRATION__DC_I2C_SW_PRIORITY_NORMAL,
-       DC_I2C_ARBITRATION__DC_I2C_SW_PRIORITY_HIGH
-};
-
-
-
-/*
- * @brief
- * Cast pointer to 'struct i2c_hw_engine *'
- * to pointer 'struct i2c_hw_engine_dce110 *'
- */
-#define FROM_I2C_HW_ENGINE(ptr) \
-       container_of((ptr), struct i2c_hw_engine_dce110, base)
-/*
- * @brief
- * Cast pointer to 'struct i2c_engine *'
- * to pointer to 'struct i2c_hw_engine_dce110 *'
- */
-#define FROM_I2C_ENGINE(ptr) \
-       FROM_I2C_HW_ENGINE(container_of((ptr), struct i2c_hw_engine, base))
-
-/*
- * @brief
- * Cast pointer to 'struct engine *'
- * to 'pointer to struct i2c_hw_engine_dce110 *'
- */
-#define FROM_ENGINE(ptr) \
-       FROM_I2C_ENGINE(container_of((ptr), struct i2c_engine, base))
-
-#define CTX \
-               hw_engine->base.base.base.ctx
-
-#define REG(reg_name)\
-       (hw_engine->regs->reg_name)
-
-#undef FN
-#define FN(reg_name, field_name) \
-       hw_engine->i2c_shift->field_name, hw_engine->i2c_mask->field_name
-
-
-static void disable_i2c_hw_engine(
-       struct i2c_hw_engine_dce110 *hw_engine)
-{
-       REG_UPDATE_N(SETUP, 1, FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_ENABLE), 0=
);
-}
-
-static void release_engine(
-       struct engine *engine)
-{
-       struct i2c_hw_engine_dce110 *hw_engine =3D FROM_ENGINE(engine);
-
-       struct i2c_engine *base =3D NULL;
-       bool safe_to_reset;
-
-       base =3D &hw_engine->base.base;
-
-       /* Restore original HW engine speed */
-
-       base->funcs->set_speed(base, hw_engine->base.original_speed);
-
-       /* Release I2C */
-       REG_UPDATE(DC_I2C_ARBITRATION, DC_I2C_SW_DONE_USING_I2C_REG, 1);
-
-       /* Reset HW engine */
-       {
-               uint32_t i2c_sw_status =3D 0;
-               REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_STATUS, &i2c_sw_status)=
;
-               /* if used by SW, safe to reset */
-               safe_to_reset =3D (i2c_sw_status =3D=3D 1);
-       }
-
-       if (safe_to_reset)
-               REG_UPDATE_2(
-                       DC_I2C_CONTROL,
-                       DC_I2C_SOFT_RESET, 1,
-                       DC_I2C_SW_STATUS_RESET, 1);
-       else
-               REG_UPDATE(DC_I2C_CONTROL, DC_I2C_SW_STATUS_RESET, 1);
-
-       /* HW I2c engine - clock gating feature */
-       if (!hw_engine->engine_keep_power_up_count)
-               disable_i2c_hw_engine(hw_engine);
-}
-
-static bool setup_engine(
-       struct i2c_engine *i2c_engine)
-{
-       struct i2c_hw_engine_dce110 *hw_engine =3D FROM_I2C_ENGINE(i2c_engi=
ne);
-       uint32_t i2c_setup_limit =3D I2C_SETUP_TIME_LIMIT_DCE;
-       uint32_t  reset_length =3D 0;
-
-       if (hw_engine->base.base.setup_limit !=3D 0)
-               i2c_setup_limit =3D hw_engine->base.base.setup_limit;
-
-       /* Program pin select */
-       REG_UPDATE_6(
-                       DC_I2C_CONTROL,
-                       DC_I2C_GO, 0,
-                       DC_I2C_SOFT_RESET, 0,
-                       DC_I2C_SEND_RESET, 0,
-                       DC_I2C_SW_STATUS_RESET, 1,
-                       DC_I2C_TRANSACTION_COUNT, 0,
-                       DC_I2C_DDC_SELECT, hw_engine->engine_id);
-
-       /* Program time limit */
-       if (hw_engine->base.base.send_reset_length =3D=3D 0) {
-               /*pre-dcn*/
-               REG_UPDATE_N(
-                               SETUP, 2,
-                               FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_TIME_LIMI=
T), i2c_setup_limit,
-                               FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_ENABLE), =
1);
-       } else {
-               reset_length =3D hw_engine->base.base.send_reset_length;
-       }
-       /* Program HW priority
-        * set to High - interrupt software I2C at any time
-        * Enable restart of SW I2C that was interrupted by HW
-        * disable queuing of software while I2C is in use by HW */
-       REG_UPDATE_2(
-                       DC_I2C_ARBITRATION,
-                       DC_I2C_NO_QUEUED_SW_GO, 0,
-                       DC_I2C_SW_PRIORITY, DC_I2C_ARBITRATION__DC_I2C_SW_P=
RIORITY_NORMAL);
-
-       return true;
-}
-
-static uint32_t get_speed(
-       const struct i2c_engine *i2c_engine)
-{
-       const struct i2c_hw_engine_dce110 *hw_engine =3D FROM_I2C_ENGINE(i2=
c_engine);
-       uint32_t pre_scale =3D 0;
-
-       REG_GET(SPEED, DC_I2C_DDC1_PRESCALE, &pre_scale);
-
-       /* [anaumov] it seems following is unnecessary */
-       /*ASSERT(value.bits.DC_I2C_DDC1_PRESCALE);*/
-       return pre_scale ?
-               hw_engine->reference_frequency / pre_scale :
-               hw_engine->base.default_speed;
-}
-
-static void set_speed(
-       struct i2c_engine *i2c_engine,
-       uint32_t speed)
-{
-       struct i2c_hw_engine_dce110 *hw_engine =3D FROM_I2C_ENGINE(i2c_engi=
ne);
-
-       if (speed) {
-               if (hw_engine->i2c_mask->DC_I2C_DDC1_START_STOP_TIMING_CNTL=
)
-                       REG_UPDATE_N(
-                               SPEED, 3,
-                               FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE)=
, hw_engine->reference_frequency / speed,
-                               FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD=
), 2,
-                               FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_START_STO=
P_TIMING_CNTL), speed > 50 ? 2:1);
-               else
-                       REG_UPDATE_N(
-                               SPEED, 2,
-                               FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE)=
, hw_engine->reference_frequency / speed,
-                               FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD=
), 2);
-       }
-}
-
-static inline void reset_hw_engine(struct engine *engine)
-{
-       struct i2c_hw_engine_dce110 *hw_engine =3D FROM_ENGINE(engine);
-
-       REG_UPDATE_2(
-                       DC_I2C_CONTROL,
-                       DC_I2C_SW_STATUS_RESET, 1,
-                       DC_I2C_SW_STATUS_RESET, 1);
-}
-
-static bool is_hw_busy(struct engine *engine)
-{
-       struct i2c_hw_engine_dce110 *hw_engine =3D FROM_ENGINE(engine);
-       uint32_t i2c_sw_status =3D 0;
-
-       REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_STATUS, &i2c_sw_status);
-       if (i2c_sw_status =3D=3D DC_I2C_STATUS__DC_I2C_STATUS_IDLE)
-               return false;
-
-       reset_hw_engine(engine);
-
-       REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_STATUS, &i2c_sw_status);
-       return i2c_sw_status !=3D DC_I2C_STATUS__DC_I2C_STATUS_IDLE;
-}
-
-
-#define STOP_TRANS_PREDICAT \
-               ((hw_engine->transaction_count =3D=3D 3) || \
-                               (request->action =3D=3D I2CAUX_TRANSACTION_=
ACTION_I2C_WRITE) ||     \
-                               (request->action & I2CAUX_TRANSACTION_ACTIO=
N_I2C_READ))
-
-#define SET_I2C_TRANSACTION(id)        \
-               do {    \
-                       REG_UPDATE_N(DC_I2C_TRANSACTION##id, 5, \
-                               FN(DC_I2C_TRANSACTION0, DC_I2C_STOP_ON_NACK=
0), 1,       \
-                               FN(DC_I2C_TRANSACTION0, DC_I2C_START0), 1, =
     \
-                               FN(DC_I2C_TRANSACTION0, DC_I2C_STOP0), STOP=
_TRANS_PREDICAT ? 1:0,       \
-                               FN(DC_I2C_TRANSACTION0, DC_I2C_RW0), (0 !=
=3D (request->action & I2CAUX_TRANSACTION_ACTION_I2C_READ)),     \
-                               FN(DC_I2C_TRANSACTION0, DC_I2C_COUNT0), len=
gth);        \
-                               if (STOP_TRANS_PREDICAT)        \
-                                       last_transaction =3D true;        \
-               } while (false)
-
-
-static bool process_transaction(
-       struct i2c_hw_engine_dce110 *hw_engine,
-       struct i2c_request_transaction_data *request)
-{
-       uint32_t length =3D request->length;
-       uint8_t *buffer =3D request->data;
-       uint32_t value =3D 0;
-
-       bool last_transaction =3D false;
-
-       struct dc_context *ctx =3D NULL;
-
-       ctx =3D hw_engine->base.base.base.ctx;
-
-
-
-       switch (hw_engine->transaction_count) {
-       case 0:
-               SET_I2C_TRANSACTION(0);
-               break;
-       case 1:
-               SET_I2C_TRANSACTION(1);
-               break;
-       case 2:
-               SET_I2C_TRANSACTION(2);
-               break;
-       case 3:
-               SET_I2C_TRANSACTION(3);
-               break;
-       default:
-               /* TODO Warning ? */
-               break;
-       }
-
-
-       /* Write the I2C address and I2C data
-        * into the hardware circular buffer, one byte per entry.
-        * As an example, the 7-bit I2C slave address for CRT monitor
-        * for reading DDC/EDID information is 0b1010001.
-        * For an I2C send operation, the LSB must be programmed to 0;
-        * for I2C receive operation, the LSB must be programmed to 1. */
-       if (hw_engine->transaction_count =3D=3D 0) {
-               value =3D REG_SET_4(DC_I2C_DATA, 0,
-                                 DC_I2C_DATA_RW, false,
-                                 DC_I2C_DATA, request->address,
-                                 DC_I2C_INDEX, 0,
-                                 DC_I2C_INDEX_WRITE, 1);
-               hw_engine->buffer_used_write =3D 0;
-       } else
-               value =3D REG_SET_2(DC_I2C_DATA, 0,
-                                 DC_I2C_DATA_RW, false,
-                                 DC_I2C_DATA, request->address);
-
-       hw_engine->buffer_used_write++;
-
-       if (!(request->action & I2CAUX_TRANSACTION_ACTION_I2C_READ)) {
-               while (length) {
-                       REG_SET_2(DC_I2C_DATA, value,
-                                       DC_I2C_INDEX_WRITE, 0,
-                                       DC_I2C_DATA, *buffer++);
-                       hw_engine->buffer_used_write++;
-                       --length;
-               }
-       }
-
-       ++hw_engine->transaction_count;
-       hw_engine->buffer_used_bytes +=3D length + 1;
-
-       return last_transaction;
-}
-
-static void execute_transaction(
-       struct i2c_hw_engine_dce110 *hw_engine)
-{
-       REG_UPDATE_N(SETUP, 5,
-               FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_DATA_DRIVE_EN), 0,
-               FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_CLK_DRIVE_EN), 0,
-               FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_DATA_DRIVE_SEL), 0,
-               FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_INTRA_TRANSACTION_DELAY),=
 0,
-               FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_INTRA_BYTE_DELAY), 0);
-
-
-       REG_UPDATE_5(DC_I2C_CONTROL,
-               DC_I2C_SOFT_RESET, 0,
-               DC_I2C_SW_STATUS_RESET, 0,
-               DC_I2C_SEND_RESET, 0,
-               DC_I2C_GO, 0,
-               DC_I2C_TRANSACTION_COUNT, hw_engine->transaction_count - 1)=
;
-
-       /* start I2C transfer */
-       REG_UPDATE(DC_I2C_CONTROL, DC_I2C_GO, 1);
-
-       /* all transactions were executed and HW buffer became empty
-        * (even though it actually happens when status becomes DONE) */
-       hw_engine->transaction_count =3D 0;
-       hw_engine->buffer_used_bytes =3D 0;
-}
-
-static void submit_channel_request(
-       struct i2c_engine *engine,
-       struct i2c_request_transaction_data *request)
-{
-       request->status =3D I2C_CHANNEL_OPERATION_SUCCEEDED;
-
-       if (!process_transaction(FROM_I2C_ENGINE(engine), request))
-               return;
-
-       if (is_hw_busy(&engine->base)) {
-               request->status =3D I2C_CHANNEL_OPERATION_ENGINE_BUSY;
-               return;
-       }
-
-       execute_transaction(FROM_I2C_ENGINE(engine));
-}
-
-static void process_channel_reply(
-       struct i2c_engine *engine,
-       struct i2c_reply_transaction_data *reply)
-{
-       uint32_t length =3D reply->length;
-       uint8_t *buffer =3D reply->data;
-
-       struct i2c_hw_engine_dce110 *hw_engine =3D
-               FROM_I2C_ENGINE(engine);
-
-
-       REG_SET_3(DC_I2C_DATA, 0,
-                       DC_I2C_INDEX, hw_engine->buffer_used_write,
-                       DC_I2C_DATA_RW, 1,
-                       DC_I2C_INDEX_WRITE, 1);
-
-       while (length) {
-               /* after reading the status,
-                * if the I2C operation executed successfully
-                * (i.e. DC_I2C_STATUS_DONE =3D 1) then the I2C controller
-                * should read data bytes from I2C circular data buffer */
-
-               uint32_t i2c_data;
-
-               REG_GET(DC_I2C_DATA, DC_I2C_DATA, &i2c_data);
-               *buffer++ =3D i2c_data;
-
-               --length;
-       }
-}
-
-static enum i2c_channel_operation_result get_channel_status(
-       struct i2c_engine *i2c_engine,
-       uint8_t *returned_bytes)
-{
-       uint32_t i2c_sw_status =3D 0;
-       struct i2c_hw_engine_dce110 *hw_engine =3D FROM_I2C_ENGINE(i2c_engi=
ne);
-       uint32_t value =3D
-                       REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_STATUS, &i2c_sw=
_status);
-
-       if (i2c_sw_status =3D=3D DC_I2C_STATUS__DC_I2C_STATUS_USED_BY_SW)
-               return I2C_CHANNEL_OPERATION_ENGINE_BUSY;
-       else if (value & hw_engine->i2c_mask->DC_I2C_SW_STOPPED_ON_NACK)
-               return I2C_CHANNEL_OPERATION_NO_RESPONSE;
-       else if (value & hw_engine->i2c_mask->DC_I2C_SW_TIMEOUT)
-               return I2C_CHANNEL_OPERATION_TIMEOUT;
-       else if (value & hw_engine->i2c_mask->DC_I2C_SW_ABORTED)
-               return I2C_CHANNEL_OPERATION_FAILED;
-       else if (value & hw_engine->i2c_mask->DC_I2C_SW_DONE)
-               return I2C_CHANNEL_OPERATION_SUCCEEDED;
-
-       /*
-        * this is the case when HW used for communication, I2C_SW_STATUS
-        * could be zero
-        */
-       return I2C_CHANNEL_OPERATION_SUCCEEDED;
-}
-
-static uint32_t get_hw_buffer_available_size(
-       const struct i2c_hw_engine *engine)
-{
-       return I2C_HW_BUFFER_SIZE -
-               FROM_I2C_HW_ENGINE(engine)->buffer_used_bytes;
-}
-
-static uint32_t get_transaction_timeout(
-       const struct i2c_hw_engine *engine,
-       uint32_t length)
-{
-       uint32_t speed =3D engine->base.funcs->get_speed(&engine->base);
-
-       uint32_t period_timeout;
-       uint32_t num_of_clock_stretches;
-
-       if (!speed)
-               return 0;
-
-       period_timeout =3D (1000 * TRANSACTION_TIMEOUT_IN_I2C_CLOCKS) / spe=
ed;
-
-       num_of_clock_stretches =3D 1 + (length << 3) + 1;
-       num_of_clock_stretches +=3D
-               (FROM_I2C_HW_ENGINE(engine)->buffer_used_bytes << 3) +
-               (FROM_I2C_HW_ENGINE(engine)->transaction_count << 1);
-
-       return period_timeout * num_of_clock_stretches;
-}
-
-static void destroy(
-       struct i2c_engine **i2c_engine)
-{
-       struct i2c_hw_engine_dce110 *engine_dce110 =3D
-                       FROM_I2C_ENGINE(*i2c_engine);
-
-       dal_i2c_hw_engine_destruct(&engine_dce110->base);
-
-       kfree(engine_dce110);
-
-       *i2c_engine =3D NULL;
-}
-
-static const struct i2c_engine_funcs i2c_engine_funcs =3D {
-       .destroy =3D destroy,
-       .get_speed =3D get_speed,
-       .set_speed =3D set_speed,
-       .setup_engine =3D setup_engine,
-       .submit_channel_request =3D submit_channel_request,
-       .process_channel_reply =3D process_channel_reply,
-       .get_channel_status =3D get_channel_status,
-       .acquire_engine =3D dal_i2c_hw_engine_acquire_engine,
-};
-
-static const struct engine_funcs engine_funcs =3D {
-       .release_engine =3D release_engine,
-       .get_engine_type =3D dal_i2c_hw_engine_get_engine_type,
-       .acquire =3D dal_i2c_engine_acquire,
-       .submit_request =3D dal_i2c_hw_engine_submit_request,
-};
-
-static const struct i2c_hw_engine_funcs i2c_hw_engine_funcs =3D {
-       .get_hw_buffer_available_size =3D get_hw_buffer_available_size,
-       .get_transaction_timeout =3D get_transaction_timeout,
-       .wait_on_operation_result =3D dal_i2c_hw_engine_wait_on_operation_r=
esult,
-};
-
-static void construct(
-       struct i2c_hw_engine_dce110 *hw_engine,
-       const struct i2c_hw_engine_dce110_create_arg *arg)
-{
-       uint32_t xtal_ref_div =3D 0;
-
-       dal_i2c_hw_engine_construct(&hw_engine->base, arg->ctx);
-
-       hw_engine->base.base.base.funcs =3D &engine_funcs;
-       hw_engine->base.base.funcs =3D &i2c_engine_funcs;
-       hw_engine->base.funcs =3D &i2c_hw_engine_funcs;
-       hw_engine->base.default_speed =3D arg->default_speed;
-
-       hw_engine->regs =3D arg->regs;
-       hw_engine->i2c_shift =3D arg->i2c_shift;
-       hw_engine->i2c_mask =3D arg->i2c_mask;
-
-       hw_engine->engine_id =3D arg->engine_id;
-
-       hw_engine->buffer_used_bytes =3D 0;
-       hw_engine->transaction_count =3D 0;
-       hw_engine->engine_keep_power_up_count =3D 1;
-
-
-       REG_GET(MICROSECOND_TIME_BASE_DIV, XTAL_REF_DIV, &xtal_ref_div);
-
-       if (xtal_ref_div =3D=3D 0) {
-               DC_LOG_WARNING("Invalid base timer divider [%s]\n",
-                               __func__);
-               xtal_ref_div =3D 2;
-       }
-
-       /*Calculating Reference Clock by divding original frequency by
-        * XTAL_REF_DIV.
-        * At upper level, uint32_t reference_frequency =3D
-        *  dal_i2caux_get_reference_clock(as) >> 1
-        *  which already divided by 2. So we need x2 to get original
-        *  reference clock from ppll_info
-        */
-       hw_engine->reference_frequency =3D
-               (arg->reference_frequency * 2) / xtal_ref_div;
-}
-
-struct i2c_engine *dal_i2c_hw_engine_dce110_create(
-       const struct i2c_hw_engine_dce110_create_arg *arg)
-{
-       struct i2c_hw_engine_dce110 *engine_dce10;
-
-       if (!arg) {
-               ASSERT_CRITICAL(false);
-               return NULL;
-       }
-       if (!arg->reference_frequency) {
-               ASSERT_CRITICAL(false);
-               return NULL;
-       }
-
-       engine_dce10 =3D kzalloc(sizeof(struct i2c_hw_engine_dce110),
-                              GFP_KERNEL);
-
-       if (!engine_dce10) {
-               ASSERT_CRITICAL(false);
-               return NULL;
-       }
-
-       construct(engine_dce10, arg);
-       return &engine_dce10->base.base;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.c b=
/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.c
deleted file mode 100644
index a9db047..0000000
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.c
+++ /dev/null
@@ -1,129 +0,0 @@
-/*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
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
- * Authors: AMD
- *
- */
-
-#include "dm_services.h"
-
-#include "include/i2caux_interface.h"
-#include "../i2caux.h"
-#include "../engine.h"
-#include "../i2c_engine.h"
-#include "../i2c_sw_engine.h"
-#include "../i2c_hw_engine.h"
-
-#include "../dce110/i2caux_dce110.h"
-#include "i2caux_dce112.h"
-
-#include "../dce110/aux_engine_dce110.h"
-
-#include "../dce110/i2c_hw_engine_dce110.h"
-
-#include "dce/dce_11_2_d.h"
-#include "dce/dce_11_2_sh_mask.h"
-
-/* set register offset */
-#define SR(reg_name)\
-       .reg_name =3D mm ## reg_name
-
-/* set register offset with instance */
-#define SRI(reg_name, block, id)\
-       .reg_name =3D mm ## block ## id ## _ ## reg_name
-
-#define aux_regs(id)\
-[id] =3D {\
-       AUX_COMMON_REG_LIST(id), \
-       .AUX_RESET_MASK =3D AUX_CONTROL__AUX_RESET_MASK \
-}
-
-#define hw_engine_regs(id)\
-{\
-               I2C_HW_ENGINE_COMMON_REG_LIST(id) \
-}
-
-static const struct dce110_aux_registers dce112_aux_regs[] =3D {
-               aux_regs(0),
-               aux_regs(1),
-               aux_regs(2),
-               aux_regs(3),
-               aux_regs(4),
-               aux_regs(5),
-};
-
-static const struct dce110_i2c_hw_engine_registers dce112_hw_engine_regs[]=
 =3D {
-               hw_engine_regs(1),
-               hw_engine_regs(2),
-               hw_engine_regs(3),
-               hw_engine_regs(4),
-               hw_engine_regs(5),
-               hw_engine_regs(6)
-};
-
-static const struct dce110_i2c_hw_engine_shift i2c_shift =3D {
-               I2C_COMMON_MASK_SH_LIST_DCE110(__SHIFT)
-};
-
-static const struct dce110_i2c_hw_engine_mask i2c_mask =3D {
-               I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)
-};
-
-static void construct(
-       struct i2caux_dce110 *i2caux_dce110,
-       struct dc_context *ctx)
-{
-       dal_i2caux_dce110_construct(i2caux_dce110,
-                                   ctx,
-                                   ARRAY_SIZE(dce112_aux_regs),
-                                   dce112_aux_regs,
-                                   dce112_hw_engine_regs,
-                                   &i2c_shift,
-                                   &i2c_mask);
-}
-
-/*
- * dal_i2caux_dce110_create
- *
- * @brief
- * public interface to allocate memory for DCE11 I2CAUX
- *
- * @param
- * struct adapter_service *as - [in]
- * struct dc_context *ctx - [in]
- *
- * @return
- * pointer to the base struct of DCE11 I2CAUX
- */
-struct i2caux *dal_i2caux_dce112_create(
-       struct dc_context *ctx)
-{
-       struct i2caux_dce110 *i2caux_dce110 =3D
-               kzalloc(sizeof(struct i2caux_dce110), GFP_KERNEL);
-
-       if (!i2caux_dce110) {
-               ASSERT_CRITICAL(false);
-               return NULL;
-       }
-
-       construct(i2caux_dce110, ctx);
-       return &i2caux_dce110->base;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.h b=
/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.h
deleted file mode 100644
index 8d35453..0000000
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
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
- * Authors: AMD
- *
- */
-
-#ifndef __DAL_I2C_AUX_DCE112_H__
-#define __DAL_I2C_AUX_DCE112_H__
-
-struct i2caux *dal_i2caux_dce112_create(
-       struct dc_context *ctx);
-
-#endif /* __DAL_I2C_AUX_DCE112_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce8=
0.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
deleted file mode 100644
index c9d6cf0..0000000
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c
+++ /dev/null
@@ -1,163 +0,0 @@
-/*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
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
- * Authors: AMD
- *
- */
-
-#include "dm_services.h"
-
-/*
- * Pre-requisites: headers required by header of this unit
- */
-#include "include/i2caux_interface.h"
-#include "../engine.h"
-#include "../i2c_engine.h"
-#include "../i2c_sw_engine.h"
-
-/*
- * Header of this unit
- */
-
-#include "i2c_sw_engine_dce80.h"
-
-/*
- * Post-requisites: headers required by this unit
- */
-
-#include "dce/dce_8_0_d.h"
-#include "dce/dce_8_0_sh_mask.h"
-
-/*
- * This unit
- */
-
-/*
- * @brief
- * Cast 'struct i2c_sw_engine *'
- * to 'struct i2c_sw_engine_dce80 *'
- */
-#define FROM_I2C_SW_ENGINE(ptr) \
-       container_of((ptr), struct i2c_sw_engine_dce80, base)
-
-/*
- * @brief
- * Cast 'struct i2c_engine *'
- * to 'struct i2c_sw_engine_dce80 *'
- */
-#define FROM_I2C_ENGINE(ptr) \
-       FROM_I2C_SW_ENGINE(container_of((ptr), struct i2c_sw_engine, base))
-
-/*
- * @brief
- * Cast 'struct engine *'
- * to 'struct i2c_sw_engine_dce80 *'
- */
-#define FROM_ENGINE(ptr) \
-       FROM_I2C_ENGINE(container_of((ptr), struct i2c_engine, base))
-
-static void release_engine(
-       struct engine *engine)
-{
-
-}
-
-static void destruct(
-       struct i2c_sw_engine_dce80 *engine)
-{
-       dal_i2c_sw_engine_destruct(&engine->base);
-}
-
-static void destroy(
-       struct i2c_engine **engine)
-{
-       struct i2c_sw_engine_dce80 *sw_engine =3D FROM_I2C_ENGINE(*engine);
-
-       destruct(sw_engine);
-
-       kfree(sw_engine);
-
-       *engine =3D NULL;
-}
-
-static bool acquire_engine(
-       struct i2c_engine *engine,
-       struct ddc *ddc_handle)
-{
-       return dal_i2caux_i2c_sw_engine_acquire_engine(engine, ddc_handle);
-}
-
-static const struct i2c_engine_funcs i2c_engine_funcs =3D {
-       .acquire_engine =3D acquire_engine,
-       .destroy =3D destroy,
-       .get_speed =3D dal_i2c_sw_engine_get_speed,
-       .set_speed =3D dal_i2c_sw_engine_set_speed,
-       .setup_engine =3D dal_i2c_engine_setup_i2c_engine,
-       .submit_channel_request =3D dal_i2c_sw_engine_submit_channel_reques=
t,
-       .process_channel_reply =3D dal_i2c_engine_process_channel_reply,
-       .get_channel_status =3D dal_i2c_sw_engine_get_channel_status,
-};
-
-static const struct engine_funcs engine_funcs =3D {
-       .release_engine =3D release_engine,
-       .get_engine_type =3D dal_i2c_sw_engine_get_engine_type,
-       .acquire =3D dal_i2c_engine_acquire,
-       .submit_request =3D dal_i2c_sw_engine_submit_request,
-};
-
-static void construct(
-       struct i2c_sw_engine_dce80 *engine,
-       const struct i2c_sw_engine_dce80_create_arg *arg)
-{
-       struct i2c_sw_engine_create_arg arg_base;
-
-       arg_base.ctx =3D arg->ctx;
-       arg_base.default_speed =3D arg->default_speed;
-
-       dal_i2c_sw_engine_construct(&engine->base, &arg_base);
-
-       engine->base.base.base.funcs =3D &engine_funcs;
-       engine->base.base.funcs =3D &i2c_engine_funcs;
-       engine->base.default_speed =3D arg->default_speed;
-       engine->engine_id =3D arg->engine_id;
-}
-
-struct i2c_engine *dal_i2c_sw_engine_dce80_create(
-       const struct i2c_sw_engine_dce80_create_arg *arg)
-{
-       struct i2c_sw_engine_dce80 *engine;
-
-       if (!arg) {
-               BREAK_TO_DEBUGGER();
-               return NULL;
-       }
-
-       engine =3D kzalloc(sizeof(struct i2c_sw_engine_dce80), GFP_KERNEL);
-
-       if (!engine) {
-               BREAK_TO_DEBUGGER();
-               return NULL;
-       }
-
-       construct(engine, arg);
-       return &engine->base.base;
-}
-
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c b/drivers/gpu/d=
rm/amd/display/dc/i2caux/i2caux.c
deleted file mode 100644
index 1ad6e49..0000000
--- a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c
+++ /dev/null
@@ -1,491 +0,0 @@
-/*
- * Copyright 2012-15 Advanced Micro Devices, Inc.
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
- * Authors: AMD
- *
- */
-
-#include "dm_services.h"
-
-/*
- * Pre-requisites: headers required by header of this unit
- */
-#include "include/i2caux_interface.h"
-#include "dc_bios_types.h"
-
-/*
- * Header of this unit
- */
-
-#include "i2caux.h"
-
-/*
- * Post-requisites: headers required by this unit
- */
-
-#include "engine.h"
-#include "i2c_engine.h"
-#include "aux_engine.h"
-
-/*
- * This unit
- */
-
-#include "dce80/i2caux_dce80.h"
-
-#include "dce100/i2caux_dce100.h"
-
-#include "dce110/i2caux_dce110.h"
-
-#include "dce112/i2caux_dce112.h"
-
-#include "dce120/i2caux_dce120.h"
-
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
-#include "dcn10/i2caux_dcn10.h"
-#endif
-
-#include "diagnostics/i2caux_diag.h"
-
-/*
- * @brief
- * Plain API, available publicly
- */
-
-struct i2caux *dal_i2caux_create(
-       struct dc_context *ctx)
-{
-       if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
-               return dal_i2caux_diag_fpga_create(ctx);
-       }
-
-       switch (ctx->dce_version) {
-       case DCE_VERSION_8_0:
-       case DCE_VERSION_8_1:
-       case DCE_VERSION_8_3:
-               return dal_i2caux_dce80_create(ctx);
-       case DCE_VERSION_11_2:
-       case DCE_VERSION_11_22:
-               return dal_i2caux_dce112_create(ctx);
-       case DCE_VERSION_11_0:
-               return dal_i2caux_dce110_create(ctx);
-       case DCE_VERSION_10_0:
-               return dal_i2caux_dce100_create(ctx);
-       case DCE_VERSION_12_0:
-       case DCE_VERSION_12_1:
-               return dal_i2caux_dce120_create(ctx);
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)
-       case DCN_VERSION_1_0:
-               return dal_i2caux_dcn10_create(ctx);
-#endif
-
-#if defined(CONFIG_DRM_AMD_DC_DCN1_01)
-       case DCN_VERSION_1_01:
-               return dal_i2caux_dcn10_create(ctx);
-#endif
-       default:
-               BREAK_TO_DEBUGGER();
-               return NULL;
-       }
-}
-
-bool dal_i2caux_submit_i2c_command(
-       struct i2caux *i2caux,
-       struct ddc *ddc,
-       struct i2c_command *cmd)
-{
-       struct i2c_engine *engine;
-       uint8_t index_of_payload =3D 0;
-       bool result;
-
-       if (!ddc) {
-               BREAK_TO_DEBUGGER();
-               return false;
-       }
-
-       if (!cmd) {
-               BREAK_TO_DEBUGGER();
-               return false;
-       }
-
-       /*
-        * default will be SW, however there is a feature flag in adapter
-        * service that determines whether SW i2c_engine will be available =
or
-        * not, if sw i2c is not available we will fallback to hw. This fea=
ture
-        * flag is set to not creating sw i2c engine for every dce except d=
ce80
-        * currently
-        */
-       switch (cmd->engine) {
-       case I2C_COMMAND_ENGINE_DEFAULT:
-       case I2C_COMMAND_ENGINE_SW:
-               /* try to acquire SW engine first,
-                * acquire HW engine if SW engine not available */
-               engine =3D i2caux->funcs->acquire_i2c_sw_engine(i2caux, ddc=
);
-
-               if (!engine)
-                       engine =3D i2caux->funcs->acquire_i2c_hw_engine(
-                               i2caux, ddc);
-       break;
-       case I2C_COMMAND_ENGINE_HW:
-       default:
-               /* try to acquire HW engine first,
-                * acquire SW engine if HW engine not available */
-               engine =3D i2caux->funcs->acquire_i2c_hw_engine(i2caux, ddc=
);
-
-               if (!engine)
-                       engine =3D i2caux->funcs->acquire_i2c_sw_engine(
-                               i2caux, ddc);
-       }
-
-       if (!engine)
-               return false;
-
-       engine->funcs->set_speed(engine, cmd->speed);
-
-       result =3D true;
-
-       while (index_of_payload < cmd->number_of_payloads) {
-               bool mot =3D (index_of_payload !=3D cmd->number_of_payloads=
 - 1);
-
-               struct i2c_payload *payload =3D cmd->payloads + index_of_pa=
yload;
-
-               struct i2caux_transaction_request request =3D { 0 };
-
-               request.operation =3D payload->write ?
-                       I2CAUX_TRANSACTION_WRITE :
-                       I2CAUX_TRANSACTION_READ;
-
-               request.payload.address_space =3D
-                       I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C;
-               request.payload.address =3D (payload->address << 1) |
-                       !payload->write;
-               request.payload.length =3D payload->length;
-               request.payload.data =3D payload->data;
-
-               if (!engine->base.funcs->submit_request(
-                       &engine->base, &request, mot)) {
-                       result =3D false;
-                       break;
-               }
-
-               ++index_of_payload;
-       }
-
-       i2caux->funcs->release_engine(i2caux, &engine->base);
-
-       return result;
-}
-
-bool dal_i2caux_submit_aux_command(
-       struct i2caux *i2caux,
-       struct ddc *ddc,
-       struct aux_command *cmd)
-{
-       struct aux_engine *engine;
-       uint8_t index_of_payload =3D 0;
-       bool result;
-       bool mot;
-
-       if (!ddc) {
-               BREAK_TO_DEBUGGER();
-               return false;
-       }
-
-       if (!cmd) {
-               BREAK_TO_DEBUGGER();
-               return false;
-       }
-
-       engine =3D i2caux->funcs->acquire_aux_engine(i2caux, ddc);
-
-       if (!engine)
-               return false;
-
-       engine->delay =3D cmd->defer_delay;
-       engine->max_defer_write_retry =3D cmd->max_defer_write_retry;
-
-       result =3D true;
-
-       while (index_of_payload < cmd->number_of_payloads) {
-               struct aux_payload *payload =3D cmd->payloads + index_of_pa=
yload;
-               struct i2caux_transaction_request request =3D { 0 };
-
-               if (cmd->mot =3D=3D I2C_MOT_UNDEF)
-                       mot =3D (index_of_payload !=3D cmd->number_of_paylo=
ads - 1);
-               else
-                       mot =3D (cmd->mot =3D=3D I2C_MOT_TRUE);
-
-               request.operation =3D payload->write ?
-                       I2CAUX_TRANSACTION_WRITE :
-                       I2CAUX_TRANSACTION_READ;
-
-               if (payload->i2c_over_aux) {
-                       request.payload.address_space =3D
-                               I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C;
-
-                       request.payload.address =3D (payload->address << 1)=
 |
-                               !payload->write;
-               } else {
-                       request.payload.address_space =3D
-                               I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD;
-
-                       request.payload.address =3D payload->address;
-               }
-
-               request.payload.length =3D payload->length;
-               request.payload.data =3D payload->data;
-
-               if (!engine->base.funcs->submit_request(
-                       &engine->base, &request, mot)) {
-                       result =3D false;
-                       break;
-               }
-
-               ++index_of_payload;
-       }
-
-       i2caux->funcs->release_engine(i2caux, &engine->base);
-
-       return result;
-}
-
-static bool get_hw_supported_ddc_line(
-       struct ddc *ddc,
-       enum gpio_ddc_line *line)
-{
-       enum gpio_ddc_line line_found;
-
-       *line =3D GPIO_DDC_LINE_UNKNOWN;
-
-       if (!ddc) {
-               BREAK_TO_DEBUGGER();
-               return false;
-       }
-
-       if (!ddc->hw_info.hw_supported)
-               return false;
-
-       line_found =3D dal_ddc_get_line(ddc);
-
-       if (line_found >=3D GPIO_DDC_LINE_COUNT)
-               return false;
-
-       *line =3D line_found;
-
-       return true;
-}
-
-void dal_i2caux_configure_aux(
-       struct i2caux *i2caux,
-       struct ddc *ddc,
-       union aux_config cfg)
-{
-       struct aux_engine *engine =3D
-               i2caux->funcs->acquire_aux_engine(i2caux, ddc);
-
-       if (!engine)
-               return;
-
-       engine->funcs->configure(engine, cfg);
-
-       i2caux->funcs->release_engine(i2caux, &engine->base);
-}
-
-void dal_i2caux_destroy(
-       struct i2caux **i2caux)
-{
-       if (!i2caux || !*i2caux) {
-               BREAK_TO_DEBUGGER();
-               return;
-       }
-
-       (*i2caux)->funcs->destroy(i2caux);
-
-       *i2caux =3D NULL;
-}
-
-/*
- * @brief
- * An utility function used by 'struct i2caux' and its descendants
- */
-
-uint32_t dal_i2caux_get_reference_clock(
-               struct dc_bios *bios)
-{
-       struct dc_firmware_info info =3D { { 0 } };
-
-       if (bios->funcs->get_firmware_info(bios, &info) !=3D BP_RESULT_OK)
-               return 0;
-
-       return info.pll_info.crystal_frequency;
-}
-
-/*
- * @brief
- * i2caux
- */
-
-enum {
-       /* following are expressed in KHz */
-       DEFAULT_I2C_SW_SPEED =3D 50,
-       DEFAULT_I2C_HW_SPEED =3D 50,
-
-       DEFAULT_I2C_SW_SPEED_100KHZ =3D 100,
-       DEFAULT_I2C_HW_SPEED_100KHZ =3D 100,
-
-       /* This is the timeout as defined in DP 1.2a,
-        * 2.3.4 "Detailed uPacket TX AUX CH State Description". */
-       AUX_TIMEOUT_PERIOD =3D 400,
-
-       /* Ideally, the SW timeout should be just above 550usec
-        * which is programmed in HW.
-        * But the SW timeout of 600usec is not reliable,
-        * because on some systems, delay_in_microseconds()
-        * returns faster than it should.
-        * EPR #379763: by trial-and-error on different systems,
-        * 700usec is the minimum reliable SW timeout for polling
-        * the AUX_SW_STATUS.AUX_SW_DONE bit.
-        * This timeout expires *only* when there is
-        * AUX Error or AUX Timeout conditions - not during normal operatio=
n.
-        * During normal operation, AUX_SW_STATUS.AUX_SW_DONE bit is set
-        * at most within ~240usec. That means,
-        * increasing this timeout will not affect normal operation,
-        * and we'll timeout after
-        * SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD =3D 1600us=
ec.
-        * This timeout is especially important for
-        * resume from S3 and CTS. */
-       SW_AUX_TIMEOUT_PERIOD_MULTIPLIER =3D 4
-};
-
-struct i2c_engine *dal_i2caux_acquire_i2c_sw_engine(
-       struct i2caux *i2caux,
-       struct ddc *ddc)
-{
-       enum gpio_ddc_line line;
-       struct i2c_engine *engine =3D NULL;
-
-       if (get_hw_supported_ddc_line(ddc, &line))
-               engine =3D i2caux->i2c_sw_engines[line];
-
-       if (!engine)
-               engine =3D i2caux->i2c_generic_sw_engine;
-
-       if (!engine)
-               return NULL;
-
-       if (!engine->base.funcs->acquire(&engine->base, ddc))
-               return NULL;
-
-       return engine;
-}
-
-struct aux_engine *dal_i2caux_acquire_aux_engine(
-       struct i2caux *i2caux,
-       struct ddc *ddc)
-{
-       enum gpio_ddc_line line;
-       struct aux_engine *engine;
-
-       if (!get_hw_supported_ddc_line(ddc, &line))
-               return NULL;
-
-       engine =3D i2caux->aux_engines[line];
-
-       if (!engine)
-               return NULL;
-
-       if (!engine->base.funcs->acquire(&engine->base, ddc))
-               return NULL;
-
-       return engine;
-}
-
-void dal_i2caux_release_engine(
-       struct i2caux *i2caux,
-       struct engine *engine)
-{
-       engine->funcs->release_engine(engine);
-
-       dal_ddc_close(engine->ddc);
-
-       engine->ddc =3D NULL;
-}
-
-void dal_i2caux_construct(
-       struct i2caux *i2caux,
-       struct dc_context *ctx)
-{
-       uint32_t i =3D 0;
-
-       i2caux->ctx =3D ctx;
-       do {
-               i2caux->i2c_sw_engines[i] =3D NULL;
-               i2caux->i2c_hw_engines[i] =3D NULL;
-               i2caux->aux_engines[i] =3D NULL;
-
-               ++i;
-       } while (i < GPIO_DDC_LINE_COUNT);
-
-       i2caux->i2c_generic_sw_engine =3D NULL;
-       i2caux->i2c_generic_hw_engine =3D NULL;
-
-       i2caux->aux_timeout_period =3D
-               SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD;
-
-       if (ctx->dce_version >=3D DCE_VERSION_11_2) {
-               i2caux->default_i2c_hw_speed =3D DEFAULT_I2C_HW_SPEED_100KH=
Z;
-               i2caux->default_i2c_sw_speed =3D DEFAULT_I2C_SW_SPEED_100KH=
Z;
-       } else {
-               i2caux->default_i2c_hw_speed =3D DEFAULT_I2C_HW_SPEED;
-               i2caux->default_i2c_sw_speed =3D DEFAULT_I2C_SW_SPEED;
-       }
-}
-
-void dal_i2caux_destruct(
-       struct i2caux *i2caux)
-{
-       uint32_t i =3D 0;
-
-       if (i2caux->i2c_generic_hw_engine)
-               i2caux->i2c_generic_hw_engine->funcs->destroy(
-                       &i2caux->i2c_generic_hw_engine);
-
-       if (i2caux->i2c_generic_sw_engine)
-               i2caux->i2c_generic_sw_engine->funcs->destroy(
-                       &i2caux->i2c_generic_sw_engine);
-
-       do {
-               if (i2caux->aux_engines[i])
-                       i2caux->aux_engines[i]->funcs->destroy(
-                               &i2caux->aux_engines[i]);
-
-               if (i2caux->i2c_hw_engines[i])
-                       i2caux->i2c_hw_engines[i]->funcs->destroy(
-                               &i2caux->i2c_hw_engines[i]);
-
-               if (i2caux->i2c_sw_engines[i])
-                       i2caux->i2c_sw_engines[i]->funcs->destroy(
-                               &i2caux->i2c_sw_engines[i]);
-
-               ++i;
-       } while (i < GPIO_DDC_LINE_COUNT);
-}
-
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180988BFAFE11BCE45991B04F7850BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of sunpeng.li-5C7GfCeVMHo@public.gmane.org &lt;sunpen=
g.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, January 11, 2019 10:54:48 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Li, Sun peng (Leo); Francis, David; Wentland, Harry<br>
<b>Subject:</b> [PATCH] drm/amd/display: Fully remove i2caux folder</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
This is a follow up to:<br>
e28e1490794d (&quot;drm/amd/display: Remove i2caux folder&quot;)<br>
<br>
Some files were still left, so delete all of them.<br>
<br>
CC: David Francis &lt;David.Francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
CC: Harry Wentland &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/i2caux/Makefile&nbsp;&nbsp;&nbsp;&nbsp=
; |&nbsp; 99 ----<br>
&nbsp;.../dc/i2caux/dce110/i2c_hw_engine_dce110.c&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 573 ---------------------<br>
&nbsp;.../amd/display/dc/i2caux/dce112/i2caux_dce112.c&nbsp;&nbsp; | 129 --=
---<br>
&nbsp;.../amd/display/dc/i2caux/dce112/i2caux_dce112.h&nbsp;&nbsp; |&nbsp; =
32 --<br>
&nbsp;.../display/dc/i2caux/dce80/i2c_sw_engine_dce80.c&nbsp; | 163 ------<=
br>
&nbsp;drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c&nbsp;&nbsp;&nbsp;&nbsp=
; | 491 ------------------<br>
&nbsp;6 files changed, 1487 deletions(-)<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/Makefile<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_h=
w_engine_dce110.c<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2cau=
x_dce112.c<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2cau=
x_dce112.h<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw=
_engine_dce80.c<br>
&nbsp;delete mode 100644 drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/Makefile b/drivers/gpu/d=
rm/amd/display/dc/i2caux/Makefile<br>
deleted file mode 100644<br>
index 352885c..0000000<br>
--- a/drivers/gpu/drm/amd/display/dc/i2caux/Makefile<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,99 &#43;0,0 @@<br>
-#<br>
-# Copyright 2017 Advanced Micro Devices, Inc.<br>
-#<br>
-# Permission is hereby granted, free of charge, to any person obtaining a<=
br>
-# copy of this software and associated documentation files (the &quot;Soft=
ware&quot;),<br>
-# to deal in the Software without restriction, including without limitatio=
n<br>
-# the rights to use, copy, modify, merge, publish, distribute, sublicense,=
<br>
-# and/or sell copies of the Software, and to permit persons to whom the<br=
>
-# Software is furnished to do so, subject to the following conditions:<br>
-#<br>
-# The above copyright notice and this permission notice shall be included =
in<br>
-# all copies or substantial portions of the Software.<br>
-#<br>
-# THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIND=
, EXPRESS OR<br>
-# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,=
<br>
-# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT =
SHALL<br>
-# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR=
<br>
-# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<br=
>
-# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<br=
>
-# OTHER DEALINGS IN THE SOFTWARE.<br>
-#<br>
-#<br>
-# Makefile for the 'i2c' sub-component of DAL.<br>
-# It provides the control and status of HW i2c engine of the adapter.<br>
-<br>
-I2CAUX =3D aux_engine.o engine_base.o i2caux.o i2c_engine.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_generic_hw_engine.o i2c_hw_=
engine.o i2c_sw_engine.o<br>
-<br>
-AMD_DAL_I2CAUX =3D $(addprefix $(AMDDALPATH)/dc/i2caux/,$(I2CAUX))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX)<br>
-<br>
-##########################################################################=
#####<br>
-# DCE 8x family<br>
-##########################################################################=
#####<br>
-I2CAUX_DCE80 =3D i2caux_dce80.o i2c_hw_engine_dce80.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2c_sw_engine_dce80.o<br>
-<br>
-AMD_DAL_I2CAUX_DCE80 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce80/,$(I2CA=
UX_DCE80))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX_DCE80)<br>
-<br>
-##########################################################################=
#####<br>
-# DCE 100 family<br>
-##########################################################################=
#####<br>
-I2CAUX_DCE100 =3D i2caux_dce100.o<br>
-<br>
-AMD_DAL_I2CAUX_DCE100 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce100/,$(I2=
CAUX_DCE100))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX_DCE100)<br>
-<br>
-##########################################################################=
#####<br>
-# DCE 110 family<br>
-##########################################################################=
#####<br>
-I2CAUX_DCE110 =3D i2caux_dce110.o i2c_sw_engine_dce110.o i2c_hw_engine_dce=
110.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine_dce110.o<br>
-<br>
-AMD_DAL_I2CAUX_DCE110 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce110/,$(I2=
CAUX_DCE110))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX_DCE110)<br>
-<br>
-##########################################################################=
#####<br>
-# DCE 112 family<br>
-##########################################################################=
#####<br>
-I2CAUX_DCE112 =3D i2caux_dce112.o<br>
-<br>
-AMD_DAL_I2CAUX_DCE112 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce112/,$(I2=
CAUX_DCE112))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX_DCE112)<br>
-<br>
-##########################################################################=
#####<br>
-# DCN 1.0 family<br>
-##########################################################################=
#####<br>
-ifdef CONFIG_DRM_AMD_DC_DCN1_0<br>
-I2CAUX_DCN1 =3D i2caux_dcn10.o<br>
-<br>
-AMD_DAL_I2CAUX_DCN1 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dcn10/,$(I2CAU=
X_DCN1))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX_DCN1)<br>
-endif<br>
-<br>
-##########################################################################=
#####<br>
-# DCE 120 family<br>
-##########################################################################=
#####<br>
-I2CAUX_DCE120 =3D i2caux_dce120.o<br>
-<br>
-AMD_DAL_I2CAUX_DCE120 =3D $(addprefix $(AMDDALPATH)/dc/i2caux/dce120/,$(I2=
CAUX_DCE120))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX_DCE120)<br>
-<br>
-##########################################################################=
#####<br>
-# Diagnostics on FPGA<br>
-##########################################################################=
#####<br>
-I2CAUX_DIAG =3D i2caux_diag.o<br>
-<br>
-AMD_DAL_I2CAUX_DIAG =3D $(addprefix $(AMDDALPATH)/dc/i2caux/diagnostics/,$=
(I2CAUX_DIAG))<br>
-<br>
-AMD_DISPLAY_FILES &#43;=3D $(AMD_DAL_I2CAUX_DIAG)<br>
-<br>
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce=
110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c=
<br>
deleted file mode 100644<br>
index 1373501..0000000<br>
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/i2c_hw_engine_dce110.c<b=
r>
&#43;&#43;&#43; /dev/null<br>
@@ -1,573 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
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
- * Authors: AMD<br>
- *<br>
- */<br>
-<br>
-#include &quot;dm_services.h&quot;<br>
-#include &quot;include/logger_interface.h&quot;<br>
-/*<br>
- * Pre-requisites: headers required by header of this unit<br>
- */<br>
-<br>
-#include &quot;include/i2caux_interface.h&quot;<br>
-#include &quot;../engine.h&quot;<br>
-#include &quot;../i2c_engine.h&quot;<br>
-#include &quot;../i2c_hw_engine.h&quot;<br>
-#include &quot;../i2c_generic_hw_engine.h&quot;<br>
-/*<br>
- * Header of this unit<br>
- */<br>
-<br>
-#include &quot;i2c_hw_engine_dce110.h&quot;<br>
-<br>
-/*<br>
- * Post-requisites: headers required by this unit<br>
- */<br>
-#include &quot;reg_helper.h&quot;<br>
-<br>
-/*<br>
- * This unit<br>
- */<br>
-#define DC_LOGGER \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine-&gt;base.base.base.ctx-&gt;logger<br>
-<br>
-enum dc_i2c_status {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_STATUS__DC_I2C_STATUS_IDLE,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_STATUS__DC_I2C_STATUS_USED_BY_=
SW,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_STATUS__DC_I2C_STATUS_USED_BY_=
HW<br>
-};<br>
-<br>
-enum dc_i2c_arbitration {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_ARBITRATION__DC_I2C_SW_PRIORIT=
Y_NORMAL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_ARBITRATION__DC_I2C_SW_PRIORIT=
Y_HIGH<br>
-};<br>
-<br>
-<br>
-<br>
-/*<br>
- * @brief<br>
- * Cast pointer to 'struct i2c_hw_engine *'<br>
- * to pointer 'struct i2c_hw_engine_dce110 *'<br>
- */<br>
-#define FROM_I2C_HW_ENGINE(ptr) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of((ptr), struct i2c_hw_eng=
ine_dce110, base)<br>
-/*<br>
- * @brief<br>
- * Cast pointer to 'struct i2c_engine *'<br>
- * to pointer to 'struct i2c_hw_engine_dce110 *'<br>
- */<br>
-#define FROM_I2C_ENGINE(ptr) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_I2C_HW_ENGINE(container_of((ptr)=
, struct i2c_hw_engine, base))<br>
-<br>
-/*<br>
- * @brief<br>
- * Cast pointer to 'struct engine *'<br>
- * to 'pointer to struct i2c_hw_engine_dce110 *'<br>
- */<br>
-#define FROM_ENGINE(ptr) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_I2C_ENGINE(container_of((ptr), s=
truct i2c_engine, base))<br>
-<br>
-#define CTX \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine-&gt;base.base.base.ctx<br>
-<br>
-#define REG(reg_name)\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (hw_engine-&gt;regs-&gt;reg_name)<br>
-<br>
-#undef FN<br>
-#define FN(reg_name, field_name) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;i2c_shift-&gt;field_nam=
e, hw_engine-&gt;i2c_mask-&gt;field_name<br>
-<br>
-<br>
-static void disable_i2c_hw_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_N(SETUP, 1, FN(DC_I2C_DDC1=
_SETUP, DC_I2C_DDC1_ENABLE), 0);<br>
-}<br>
-<br>
-static void release_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engine)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e =3D FROM_ENGINE(engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *base =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool safe_to_reset;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base =3D &amp;hw_engine-&gt;base.base=
;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Restore original HW engine speed *=
/<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base-&gt;funcs-&gt;set_speed(base, hw=
_engine-&gt;base.original_speed);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Release I2C */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(DC_I2C_ARBITRATION, DC_I2C=
_SW_DONE_USING_I2C_REG, 1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset HW engine */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t i2c_sw_status =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_STATUS, &amp;i2c_sw_status);=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* if used by SW, safe to reset */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; safe_to_reset =3D (i2c_sw_status =3D=3D 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (safe_to_reset)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_UPDATE_2(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_CONTROL,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SOFT_RESE=
T, 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SW_STATUS=
_RESET, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_UPDATE(DC_I2C_CONTROL, DC_I2C_SW_STATUS_RESET, 1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* HW I2c engine - clock gating featu=
re */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!hw_engine-&gt;engine_keep_power_=
up_count)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; disable_i2c_hw_engine(hw_engine);<br>
-}<br>
-<br>
-static bool setup_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *i2c_engine)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e =3D FROM_I2C_ENGINE(i2c_engine);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i2c_setup_limit =3D I2C_SETU=
P_TIME_LIMIT_DCE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; reset_length =3D 0;<br=
>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hw_engine-&gt;base.base.setup_lim=
it !=3D 0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2c_setup_limit =3D hw_engine-&gt;base.base.setup_limit;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program pin select */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_6(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_CONTROL,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_GO, 0,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SOFT_RESE=
T, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SEND_RESE=
T, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SW_STATUS=
_RESET, 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_TRANSACTI=
ON_COUNT, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_DDC_SELEC=
T, hw_engine-&gt;engine_id);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program time limit */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hw_engine-&gt;base.base.send_rese=
t_length =3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*pre-dcn*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_UPDATE_N(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SETUP, 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_TIME_LIMI=
T), i2c_setup_limit,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_ENABLE), =
1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; reset_length =3D hw_engine-&gt;base.base.send_reset_length;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Program HW priority<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set to High - interrupt softw=
are I2C at any time<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Enable restart of SW I2C that=
 was interrupted by HW<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * disable queuing of software w=
hile I2C is in use by HW */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_2(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_ARBITRATI=
ON,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_NO_QUEUED=
_SW_GO, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SW_PRIORI=
TY, DC_I2C_ARBITRATION__DC_I2C_SW_PRIORITY_NORMAL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
-static uint32_t get_speed(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_engine *i2c_engine)<=
br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_hw_engine_dce110 *hw=
_engine =3D FROM_I2C_ENGINE(i2c_engine);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t pre_scale =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(SPEED, DC_I2C_DDC1_PRESCALE, =
&amp;pre_scale);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* [anaumov] it seems following is un=
necessary */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*ASSERT(value.bits.DC_I2C_DDC1_PRESC=
ALE);*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pre_scale ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine-&gt;reference_frequency / pre_scale :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine-&gt;base.default_speed;<br>
-}<br>
-<br>
-static void set_speed(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *i2c_engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t speed)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e =3D FROM_I2C_ENGINE(i2c_engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (speed) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (hw_engine-&gt;i2c_mask-&gt;DC_I2C_DDC1_START_STOP_TIMING_CNT=
L)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_N(<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SPEED, 3,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE)=
, hw_engine-&gt;reference_frequency / speed,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD=
), 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_START_STO=
P_TIMING_CNTL), speed &gt; 50 ? 2:1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_N(<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SPEED, 2,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_PRESCALE)=
, hw_engine-&gt;reference_frequency / speed,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_DDC1_SPEED, DC_I2C_DDC1_THRESHOLD=
), 2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
-static inline void reset_hw_engine(struct engine *engine)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e =3D FROM_ENGINE(engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_2(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_CONTROL,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SW_STATUS=
_RESET, 1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_SW_STATUS=
_RESET, 1);<br>
-}<br>
-<br>
-static bool is_hw_busy(struct engine *engine)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e =3D FROM_ENGINE(engine);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i2c_sw_status =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_S=
TATUS, &amp;i2c_sw_status);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i2c_sw_status =3D=3D DC_I2C_STATU=
S__DC_I2C_STATUS_IDLE)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_hw_engine(engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(DC_I2C_SW_STATUS, DC_I2C_SW_S=
TATUS, &amp;i2c_sw_status);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return i2c_sw_status !=3D DC_I2C_STAT=
US__DC_I2C_STATUS_IDLE;<br>
-}<br>
-<br>
-<br>
-#define STOP_TRANS_PREDICAT \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ((hw_engine-&gt;transaction_count =3D=3D 3) || \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (request-&gt;action =3D=3D I2CAUX_TRANSACTI=
ON_ACTION_I2C_WRITE) ||&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (request-&gt;action &amp; I2CAUX_TRANSACTIO=
N_ACTION_I2C_READ))<br>
-<br>
-#define SET_I2C_TRANSACTION(id)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; do {&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_N(DC_=
I2C_TRANSACTION##id, 5, \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_TRANSACTION0, DC_I2C_STOP_ON_NACK=
0), 1,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_TRANSACTION0, DC_I2C_START0), 1,&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_TRANSACTION0, DC_I2C_STOP0), STOP=
_TRANS_PREDICAT ? 1:0,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_TRANSACTION0, DC_I2C_RW0), (0 !=
=3D (request-&gt;action &amp; I2CAUX_TRANSACTION_ACTION_I2C_READ)),&nbsp;&n=
bsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FN(DC_I2C_TRANSACTION0, DC_I2C_COUNT0), len=
gth);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (STOP_TRANS_PREDICAT)&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; last_transaction =3D true;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } while (false)<br>
-<br>
-<br>
-static bool process_transaction(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_request_transaction_data *=
request)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t length =3D request-&gt;lengt=
h;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *buffer =3D request-&gt;data;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool last_transaction =3D false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx =3D hw_engine-&gt;base.base.base.=
ctx;<br>
-<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (hw_engine-&gt;transaction_cou=
nt) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SET_I2C_TRANSACTION(0);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SET_I2C_TRANSACTION(1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SET_I2C_TRANSACTION(2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 3:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SET_I2C_TRANSACTION(3);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* TODO Warning ? */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Write the I2C address and I2C data=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * into the hardware circular bu=
ffer, one byte per entry.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * As an example, the 7-bit I2C =
slave address for CRT monitor<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for reading DDC/EDID informat=
ion is 0b1010001.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * For an I2C send operation, th=
e LSB must be programmed to 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for I2C receive operation, th=
e LSB must be programmed to 1. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (hw_engine-&gt;transaction_count =
=3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D REG_SET_4(DC_I2C_DATA, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_DATA_RW, false,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_DATA, request-&gt;addres=
s,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_INDEX, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_INDEX_WRITE, 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine-&gt;buffer_used_write =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; value =3D REG_SET_2(DC_I2C_DATA, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_DATA_RW, false,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_DATA, request-&gt;addres=
s);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;buffer_used_write&#43;&=
#43;;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(request-&gt;action &amp; I2CAUX=
_TRANSACTION_ACTION_I2C_READ)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; while (length) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_2(DC_I2C=
_DATA, value,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DC_I2C_INDEX_WRITE, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; DC_I2C_DATA, *buffer&#43;&#43;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;bu=
ffer_used_write&#43;&#43;;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --length;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#43;hw_engine-&gt;transaction_c=
ount;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;buffer_used_bytes &#43;=
=3D length &#43; 1;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return last_transaction;<br>
-}<br>
-<br>
-static void execute_transaction(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_N(SETUP, 5,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_DATA_DRIVE_EN), 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_CLK_DRIVE_EN), 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_DATA_DRIVE_SEL), 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_INTRA_TRANSACTION_DELAY), 0,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FN(DC_I2C_DDC1_SETUP, DC_I2C_DDC1_INTRA_BYTE_DELAY), 0);<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_5(DC_I2C_CONTROL,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DC_I2C_SOFT_RESET, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DC_I2C_SW_STATUS_RESET, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DC_I2C_SEND_RESET, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DC_I2C_GO, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DC_I2C_TRANSACTION_COUNT, hw_engine-&gt;transaction_count - 1);<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* start I2C transfer */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(DC_I2C_CONTROL, DC_I2C_GO,=
 1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* all transactions were executed and=
 HW buffer became empty<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (even though it actually happ=
ens when status becomes DONE) */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;transaction_count =3D 0=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;buffer_used_bytes =3D 0=
;<br>
-}<br>
-<br>
-static void submit_channel_request(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_request_transaction_data *=
request)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;status =3D I2C_CHANNEL_OP=
ERATION_SUCCEEDED;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!process_transaction(FROM_I2C_ENG=
INE(engine), request))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_hw_busy(&amp;engine-&gt;base))=
 {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request-&gt;status =3D I2C_CHANNEL_OPERATION_ENGINE_BUSY;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; execute_transaction(FROM_I2C_ENGINE(e=
ngine));<br>
-}<br>
-<br>
-static void process_channel_reply(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_reply_transaction_data *re=
ply)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t length =3D reply-&gt;length;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *buffer =3D reply-&gt;data;<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FROM_I2C_ENGINE(engine);<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_SET_3(DC_I2C_DATA, 0,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_INDEX, hw=
_engine-&gt;buffer_used_write,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_DATA_RW, =
1,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DC_I2C_INDEX_WRI=
TE, 1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (length) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* after reading the status,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * if the I2C operation executed successfully<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * (i.e. DC_I2C_STATUS_DONE =3D 1) then the I2C controller<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * should read data bytes from I2C circular data buffer */<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t i2c_data;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; REG_GET(DC_I2C_DATA, DC_I2C_DATA, &amp;i2c_data);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; *buffer&#43;&#43; =3D i2c_data;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; --length;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
-static enum i2c_channel_operation_result get_channel_status(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *i2c_engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *returned_bytes)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i2c_sw_status =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e =3D FROM_I2C_ENGINE(i2c_engine);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(DC_I2C_S=
W_STATUS, DC_I2C_SW_STATUS, &amp;i2c_sw_status);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i2c_sw_status =3D=3D DC_I2C_STATU=
S__DC_I2C_STATUS_USED_BY_SW)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return I2C_CHANNEL_OPERATION_ENGINE_BUSY;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (value &amp; hw_engine-&gt;i2=
c_mask-&gt;DC_I2C_SW_STOPPED_ON_NACK)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return I2C_CHANNEL_OPERATION_NO_RESPONSE;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (value &amp; hw_engine-&gt;i2=
c_mask-&gt;DC_I2C_SW_TIMEOUT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return I2C_CHANNEL_OPERATION_TIMEOUT;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (value &amp; hw_engine-&gt;i2=
c_mask-&gt;DC_I2C_SW_ABORTED)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return I2C_CHANNEL_OPERATION_FAILED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (value &amp; hw_engine-&gt;i2=
c_mask-&gt;DC_I2C_SW_DONE)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return I2C_CHANNEL_OPERATION_SUCCEEDED;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * this is the case when HW used=
 for communication, I2C_SW_STATUS<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * could be zero<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return I2C_CHANNEL_OPERATION_SUCCEEDE=
D;<br>
-}<br>
-<br>
-static uint32_t get_hw_buffer_available_size(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_hw_engine *engine)<b=
r>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return I2C_HW_BUFFER_SIZE -<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FROM_I2C_HW_ENGINE(engine)-&gt;buffer_used_bytes;<br>
-}<br>
-<br>
-static uint32_t get_transaction_timeout(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_hw_engine *engine,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t length)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t speed =3D engine-&gt;base.fu=
ncs-&gt;get_speed(&amp;engine-&gt;base);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t period_timeout;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t num_of_clock_stretches;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!speed)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; period_timeout =3D (1000 * TRANSACTIO=
N_TIMEOUT_IN_I2C_CLOCKS) / speed;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_of_clock_stretches =3D 1 &#43; (l=
ength &lt;&lt; 3) &#43; 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_of_clock_stretches &#43;=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (FROM_I2C_HW_ENGINE(engine)-&gt;buffer_used_bytes &lt;&lt; 3) &#=
43;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (FROM_I2C_HW_ENGINE(engine)-&gt;transaction_count &lt;&lt; 1);<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return period_timeout * num_of_clock_=
stretches;<br>
-}<br>
-<br>
-static void destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine **i2c_engine)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *engine_d=
ce110 =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_I2C_ENGINE(=
*i2c_engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_i2c_hw_engine_destruct(&amp;engin=
e_dce110-&gt;base);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(engine_dce110);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *i2c_engine =3D NULL;<br>
-}<br>
-<br>
-static const struct i2c_engine_funcs i2c_engine_funcs =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .destroy =3D destroy,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_speed =3D get_speed,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_speed =3D set_speed,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup_engine =3D setup_engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .submit_channel_request =3D submit_ch=
annel_request,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process_channel_reply =3D process_ch=
annel_reply,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_channel_status =3D get_channel_s=
tatus,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .acquire_engine =3D dal_i2c_hw_engine=
_acquire_engine,<br>
-};<br>
-<br>
-static const struct engine_funcs engine_funcs =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release_engine =3D release_engine,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_engine_type =3D dal_i2c_hw_engin=
e_get_engine_type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .acquire =3D dal_i2c_engine_acquire,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .submit_request =3D dal_i2c_hw_engine=
_submit_request,<br>
-};<br>
-<br>
-static const struct i2c_hw_engine_funcs i2c_hw_engine_funcs =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_hw_buffer_available_size =3D get=
_hw_buffer_available_size,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_transaction_timeout =3D get_tran=
saction_timeout,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .wait_on_operation_result =3D dal_i2c=
_hw_engine_wait_on_operation_result,<br>
-};<br>
-<br>
-static void construct(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *hw_engin=
e,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_hw_engine_dce110_cre=
ate_arg *arg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t xtal_ref_div =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_i2c_hw_engine_construct(&amp;hw_e=
ngine-&gt;base, arg-&gt;ctx);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;base.base.base.funcs =
=3D &amp;engine_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;base.base.funcs =3D &am=
p;i2c_engine_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;base.funcs =3D &amp;i2c=
_hw_engine_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;base.default_speed =3D =
arg-&gt;default_speed;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;regs =3D arg-&gt;regs;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;i2c_shift =3D arg-&gt;i=
2c_shift;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;i2c_mask =3D arg-&gt;i2=
c_mask;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;engine_id =3D arg-&gt;e=
ngine_id;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;buffer_used_bytes =3D 0=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;transaction_count =3D 0=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;engine_keep_power_up_co=
unt =3D 1;<br>
-<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(MICROSECOND_TIME_BASE_DIV, XT=
AL_REF_DIV, &amp;xtal_ref_div);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xtal_ref_div =3D=3D 0) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DC_LOG_WARNING(&quot;Invalid base timer divider [%s]\n&quot;,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __func__);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; xtal_ref_div =3D 2;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*Calculating Reference Clock by divd=
ing original frequency by<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * XTAL_REF_DIV.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * At upper level, uint32_t refe=
rence_frequency =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; dal_i2caux_get_referenc=
e_clock(as) &gt;&gt; 1<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; which already divided b=
y 2. So we need x2 to get original<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; reference clock from pp=
ll_info<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hw_engine-&gt;reference_frequency =3D=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (arg-&gt;reference_frequency * 2) / xtal_ref_div;<br>
-}<br>
-<br>
-struct i2c_engine *dal_i2c_hw_engine_dce110_create(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_hw_engine_dce110_cre=
ate_arg *arg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_hw_engine_dce110 *engine_d=
ce10;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!arg) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ASSERT_CRITICAL(false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!arg-&gt;reference_frequency) {<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ASSERT_CRITICAL(false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine_dce10 =3D kzalloc(sizeof(struc=
t i2c_hw_engine_dce110),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; GFP_KERNEL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine_dce10) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ASSERT_CRITICAL(false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; construct(engine_dce10, arg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;engine_dce10-&gt;base.bas=
e;<br>
-}<br>
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.c b=
/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.c<br>
deleted file mode 100644<br>
index a9db047..0000000<br>
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.c<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,129 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
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
- * Authors: AMD<br>
- *<br>
- */<br>
-<br>
-#include &quot;dm_services.h&quot;<br>
-<br>
-#include &quot;include/i2caux_interface.h&quot;<br>
-#include &quot;../i2caux.h&quot;<br>
-#include &quot;../engine.h&quot;<br>
-#include &quot;../i2c_engine.h&quot;<br>
-#include &quot;../i2c_sw_engine.h&quot;<br>
-#include &quot;../i2c_hw_engine.h&quot;<br>
-<br>
-#include &quot;../dce110/i2caux_dce110.h&quot;<br>
-#include &quot;i2caux_dce112.h&quot;<br>
-<br>
-#include &quot;../dce110/aux_engine_dce110.h&quot;<br>
-<br>
-#include &quot;../dce110/i2c_hw_engine_dce110.h&quot;<br>
-<br>
-#include &quot;dce/dce_11_2_d.h&quot;<br>
-#include &quot;dce/dce_11_2_sh_mask.h&quot;<br>
-<br>
-/* set register offset */<br>
-#define SR(reg_name)\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reg_name =3D mm ## reg_name<br>
-<br>
-/* set register offset with instance */<br>
-#define SRI(reg_name, block, id)\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reg_name =3D mm ## block ## id ## _ =
## reg_name<br>
-<br>
-#define aux_regs(id)\<br>
-[id] =3D {\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST(id), \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D AUX_CONTROL__AUX_=
RESET_MASK \<br>
-}<br>
-<br>
-#define hw_engine_regs(id)\<br>
-{\<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; I2C_HW_ENGINE_COMMON_REG_LIST(id) \<br>
-}<br>
-<br>
-static const struct dce110_aux_registers dce112_aux_regs[] =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aux_regs(0),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aux_regs(1),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aux_regs(2),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aux_regs(3),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aux_regs(4),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; aux_regs(5),<br>
-};<br>
-<br>
-static const struct dce110_i2c_hw_engine_registers dce112_hw_engine_regs[]=
 =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine_regs(1),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine_regs(2),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine_regs(3),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine_regs(4),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine_regs(5),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; hw_engine_regs(6)<br>
-};<br>
-<br>
-static const struct dce110_i2c_hw_engine_shift i2c_shift =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; I2C_COMMON_MASK_SH_LIST_DCE110(__SHIFT)<br>
-};<br>
-<br>
-static const struct dce110_i2c_hw_engine_mask i2c_mask =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; I2C_COMMON_MASK_SH_LIST_DCE110(_MASK)<br>
-};<br>
-<br>
-static void construct(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_dce110 *i2caux_dce110,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_i2caux_dce110_construct(i2caux_dc=
e110,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ARRAY_SIZE(dce112_a=
ux_regs),<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce112_aux_regs,<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce112_hw_engine_re=
gs,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2c_shift,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2c_mask);<br>
-}<br>
-<br>
-/*<br>
- * dal_i2caux_dce110_create<br>
- *<br>
- * @brief<br>
- * public interface to allocate memory for DCE11 I2CAUX<br>
- *<br>
- * @param<br>
- * struct adapter_service *as - [in]<br>
- * struct dc_context *ctx - [in]<br>
- *<br>
- * @return<br>
- * pointer to the base struct of DCE11 I2CAUX<br>
- */<br>
-struct i2caux *dal_i2caux_dce112_create(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_dce110 *i2caux_dce110 =
=3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kzalloc(sizeof(struct i2caux_dce110), GFP_KERNEL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!i2caux_dce110) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ASSERT_CRITICAL(false);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; construct(i2caux_dce110, ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;i2caux_dce110-&gt;base;<b=
r>
-}<br>
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.h b=
/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.h<br>
deleted file mode 100644<br>
index 8d35453..0000000<br>
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce112/i2caux_dce112.h<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,32 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
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
- * Authors: AMD<br>
- *<br>
- */<br>
-<br>
-#ifndef __DAL_I2C_AUX_DCE112_H__<br>
-#define __DAL_I2C_AUX_DCE112_H__<br>
-<br>
-struct i2caux *dal_i2caux_dce112_create(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx);<br>
-<br>
-#endif /* __DAL_I2C_AUX_DCE112_H__ */<br>
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce8=
0.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c<br>
deleted file mode 100644<br>
index c9d6cf0..0000000<br>
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce80/i2c_sw_engine_dce80.c<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,163 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
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
- * Authors: AMD<br>
- *<br>
- */<br>
-<br>
-#include &quot;dm_services.h&quot;<br>
-<br>
-/*<br>
- * Pre-requisites: headers required by header of this unit<br>
- */<br>
-#include &quot;include/i2caux_interface.h&quot;<br>
-#include &quot;../engine.h&quot;<br>
-#include &quot;../i2c_engine.h&quot;<br>
-#include &quot;../i2c_sw_engine.h&quot;<br>
-<br>
-/*<br>
- * Header of this unit<br>
- */<br>
-<br>
-#include &quot;i2c_sw_engine_dce80.h&quot;<br>
-<br>
-/*<br>
- * Post-requisites: headers required by this unit<br>
- */<br>
-<br>
-#include &quot;dce/dce_8_0_d.h&quot;<br>
-#include &quot;dce/dce_8_0_sh_mask.h&quot;<br>
-<br>
-/*<br>
- * This unit<br>
- */<br>
-<br>
-/*<br>
- * @brief<br>
- * Cast 'struct i2c_sw_engine *'<br>
- * to 'struct i2c_sw_engine_dce80 *'<br>
- */<br>
-#define FROM_I2C_SW_ENGINE(ptr) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of((ptr), struct i2c_sw_eng=
ine_dce80, base)<br>
-<br>
-/*<br>
- * @brief<br>
- * Cast 'struct i2c_engine *'<br>
- * to 'struct i2c_sw_engine_dce80 *'<br>
- */<br>
-#define FROM_I2C_ENGINE(ptr) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_I2C_SW_ENGINE(container_of((ptr)=
, struct i2c_sw_engine, base))<br>
-<br>
-/*<br>
- * @brief<br>
- * Cast 'struct engine *'<br>
- * to 'struct i2c_sw_engine_dce80 *'<br>
- */<br>
-#define FROM_ENGINE(ptr) \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_I2C_ENGINE(container_of((ptr), s=
truct i2c_engine, base))<br>
-<br>
-static void release_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engine)<br>
-{<br>
-<br>
-}<br>
-<br>
-static void destruct(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_sw_engine_dce80 *engine)<b=
r>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_i2c_sw_engine_destruct(&amp;engin=
e-&gt;base);<br>
-}<br>
-<br>
-static void destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine **engine)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_sw_engine_dce80 *sw_engine=
 =3D FROM_I2C_ENGINE(*engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; destruct(sw_engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sw_engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *engine =3D NULL;<br>
-}<br>
-<br>
-static bool acquire_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc_handle)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dal_i2caux_i2c_sw_engine_acqui=
re_engine(engine, ddc_handle);<br>
-}<br>
-<br>
-static const struct i2c_engine_funcs i2c_engine_funcs =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .acquire_engine =3D acquire_engine,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .destroy =3D destroy,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_speed =3D dal_i2c_sw_engine_get_=
speed,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_speed =3D dal_i2c_sw_engine_set_=
speed,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .setup_engine =3D dal_i2c_engine_setu=
p_i2c_engine,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .submit_channel_request =3D dal_i2c_s=
w_engine_submit_channel_request,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process_channel_reply =3D dal_i2c_en=
gine_process_channel_reply,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_channel_status =3D dal_i2c_sw_en=
gine_get_channel_status,<br>
-};<br>
-<br>
-static const struct engine_funcs engine_funcs =3D {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release_engine =3D release_engine,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_engine_type =3D dal_i2c_sw_engin=
e_get_engine_type,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .acquire =3D dal_i2c_engine_acquire,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .submit_request =3D dal_i2c_sw_engine=
_submit_request,<br>
-};<br>
-<br>
-static void construct(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_sw_engine_dce80 *engine,<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_sw_engine_dce80_crea=
te_arg *arg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_sw_engine_create_arg arg_b=
ase;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arg_base.ctx =3D arg-&gt;ctx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arg_base.default_speed =3D arg-&gt;de=
fault_speed;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_i2c_sw_engine_construct(&amp;engi=
ne-&gt;base, &amp;arg_base);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;base.base.base.funcs =3D &=
amp;engine_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;base.base.funcs =3D &amp;i=
2c_engine_funcs;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;base.default_speed =3D arg=
-&gt;default_speed;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;engine_id =3D arg-&gt;engi=
ne_id;<br>
-}<br>
-<br>
-struct i2c_engine *dal_i2c_sw_engine_dce80_create(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct i2c_sw_engine_dce80_crea=
te_arg *arg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_sw_engine_dce80 *engine;<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!arg) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine =3D kzalloc(sizeof(struct i2c_=
sw_engine_dce80), GFP_KERNEL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; construct(engine, arg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;engine-&gt;base.base;<br>
-}<br>
-<br>
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c b/drivers/gpu/d=
rm/amd/display/dc/i2caux/i2caux.c<br>
deleted file mode 100644<br>
index 1ad6e49..0000000<br>
--- a/drivers/gpu/drm/amd/display/dc/i2caux/i2caux.c<br>
&#43;&#43;&#43; /dev/null<br>
@@ -1,491 &#43;0,0 @@<br>
-/*<br>
- * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
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
- * Authors: AMD<br>
- *<br>
- */<br>
-<br>
-#include &quot;dm_services.h&quot;<br>
-<br>
-/*<br>
- * Pre-requisites: headers required by header of this unit<br>
- */<br>
-#include &quot;include/i2caux_interface.h&quot;<br>
-#include &quot;dc_bios_types.h&quot;<br>
-<br>
-/*<br>
- * Header of this unit<br>
- */<br>
-<br>
-#include &quot;i2caux.h&quot;<br>
-<br>
-/*<br>
- * Post-requisites: headers required by this unit<br>
- */<br>
-<br>
-#include &quot;engine.h&quot;<br>
-#include &quot;i2c_engine.h&quot;<br>
-#include &quot;aux_engine.h&quot;<br>
-<br>
-/*<br>
- * This unit<br>
- */<br>
-<br>
-#include &quot;dce80/i2caux_dce80.h&quot;<br>
-<br>
-#include &quot;dce100/i2caux_dce100.h&quot;<br>
-<br>
-#include &quot;dce110/i2caux_dce110.h&quot;<br>
-<br>
-#include &quot;dce112/i2caux_dce112.h&quot;<br>
-<br>
-#include &quot;dce120/i2caux_dce120.h&quot;<br>
-<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
-#include &quot;dcn10/i2caux_dcn10.h&quot;<br>
-#endif<br>
-<br>
-#include &quot;diagnostics/i2caux_diag.h&quot;<br>
-<br>
-/*<br>
- * @brief<br>
- * Plain API, available publicly<br>
- */<br>
-<br>
-struct i2caux *dal_i2caux_create(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_FPGA_MAXIMUS_DC(ctx-&gt;dce_en=
vironment)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_diag_fpga_create(ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ctx-&gt;dce_version) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_8_0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_8_1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_8_3:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_dce80_create(ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_11_2:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_11_22:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_dce112_create(ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_11_0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_dce110_create(ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_10_0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_dce100_create(ctx);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_12_0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCE_VERSION_12_1:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_dce120_create(ctx);<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_0:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_dcn10_create(ctx);<br>
-#endif<br>
-<br>
-#if defined(CONFIG_DRM_AMD_DC_DCN1_01)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DCN_VERSION_1_01:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return dal_i2caux_dcn10_create(ctx);<br>
-#endif<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
-bool dal_i2caux_submit_i2c_command(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_command *cmd)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *engine;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t index_of_payload =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool result;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ddc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * default will be SW, however t=
here is a feature flag in adapter<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * service that determines wheth=
er SW i2c_engine will be available or<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * not, if sw i2c is not availab=
le we will fallback to hw. This feature<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * flag is set to not creating s=
w i2c engine for every dce except dce80<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * currently<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (cmd-&gt;engine) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I2C_COMMAND_ENGINE_DEFAULT:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I2C_COMMAND_ENGINE_SW:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* try to acquire SW engine first,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * acquire HW engine if SW engine not available */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; engine =3D i2caux-&gt;funcs-&gt;acquire_i2c_sw_engine(i2caux, dd=
c);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine =3D i2cau=
x-&gt;funcs-&gt;acquire_i2c_hw_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux, ddc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I2C_COMMAND_ENGINE_HW:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* try to acquire HW engine first,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * acquire SW engine if HW engine not available */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; engine =3D i2caux-&gt;funcs-&gt;acquire_i2c_hw_engine(i2caux, dd=
c);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine =3D i2cau=
x-&gt;funcs-&gt;acquire_i2c_sw_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux, ddc);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;set_speed(engine=
, cmd-&gt;speed);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (index_of_payload &lt; cmd-&gt;=
number_of_payloads) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; bool mot =3D (index_of_payload !=3D cmd-&gt;number_of_payloads -=
 1);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct i2c_payload *payload =3D cmd-&gt;payloads &#43; index_of_=
payload;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct i2caux_transaction_request request =3D { 0 };<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.operation =3D payload-&gt;write ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTI=
ON_WRITE :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTI=
ON_READ;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.payload.address_space =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTI=
ON_ADDRESS_SPACE_I2C;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.payload.address =3D (payload-&gt;address &lt;&lt; 1) |<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !payload-&gt;wri=
te;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.payload.length =3D payload-&gt;length;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.payload.data =3D payload-&gt;data;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!engine-&gt;base.funcs-&gt;submit_request(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;engine-&gt;=
base, &amp;request, mot)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D false=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &#43;&#43;index_of_payload;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;funcs-&gt;release_engine(i=
2caux, &amp;engine-&gt;base);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
-bool dal_i2caux_submit_aux_command(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_command *cmd)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t index_of_payload =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool result;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mot;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ddc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine =3D i2caux-&gt;funcs-&gt;acqui=
re_aux_engine(i2caux, ddc);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;delay =3D cmd-&gt;defer_de=
lay;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;max_defer_write_retry =3D =
cmd-&gt;max_defer_write_retry;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (index_of_payload &lt; cmd-&gt;=
number_of_payloads) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct aux_payload *payload =3D cmd-&gt;payloads &#43; index_of_=
payload;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct i2caux_transaction_request request =3D { 0 };<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (cmd-&gt;mot =3D=3D I2C_MOT_UNDEF)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mot =3D (index_o=
f_payload !=3D cmd-&gt;number_of_payloads - 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mot =3D (cmd-&gt=
;mot =3D=3D I2C_MOT_TRUE);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.operation =3D payload-&gt;write ?<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTI=
ON_WRITE :<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTI=
ON_READ;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (payload-&gt;i2c_over_aux) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request.payload.=
address_space =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request.payload.=
address =3D (payload-&gt;address &lt;&lt; 1) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !payload-&gt;write;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request.payload.=
address_space =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request.payload.=
address =3D payload-&gt;address;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.payload.length =3D payload-&gt;length;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; request.payload.data =3D payload-&gt;data;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!engine-&gt;base.funcs-&gt;submit_request(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;engine-&gt;=
base, &amp;request, mot)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D false=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &#43;&#43;index_of_payload;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;funcs-&gt;release_engine(i=
2caux, &amp;engine-&gt;base);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
-}<br>
-<br>
-static bool get_hw_supported_ddc_line(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum gpio_ddc_line *line)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum gpio_ddc_line line_found;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *line =3D GPIO_DDC_LINE_UNKNOWN;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ddc) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ddc-&gt;hw_info.hw_supported)<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; line_found =3D dal_ddc_get_line(ddc);=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (line_found &gt;=3D GPIO_DDC_LINE_=
COUNT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *line =3D line_found;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
-}<br>
-<br>
-void dal_i2caux_configure_aux(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union aux_config cfg)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;funcs-&gt;acquire_aux_engine(i2caux, ddc);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;configure(engine=
, cfg);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;funcs-&gt;release_engine(i=
2caux, &amp;engine-&gt;base);<br>
-}<br>
-<br>
-void dal_i2caux_destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux **i2caux)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!i2caux || !*i2caux) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; BREAK_TO_DEBUGGER();<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*i2caux)-&gt;funcs-&gt;destroy(i2cau=
x);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *i2caux =3D NULL;<br>
-}<br>
-<br>
-/*<br>
- * @brief<br>
- * An utility function used by 'struct i2caux' and its descendants<br>
- */<br>
-<br>
-uint32_t dal_i2caux_get_reference_clock(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; struct dc_bios *bios)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_firmware_info info =3D { { =
0 } };<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bios-&gt;funcs-&gt;get_firmware_i=
nfo(bios, &amp;info) !=3D BP_RESULT_OK)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return info.pll_info.crystal_frequenc=
y;<br>
-}<br>
-<br>
-/*<br>
- * @brief<br>
- * i2caux<br>
- */<br>
-<br>
-enum {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* following are expressed in KHz */<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEFAULT_I2C_SW_SPEED =3D 50,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEFAULT_I2C_HW_SPEED =3D 50,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEFAULT_I2C_SW_SPEED_100KHZ =3D 100,<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEFAULT_I2C_HW_SPEED_100KHZ =3D 100,<=
br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This is the timeout as defined in =
DP 1.2a,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2.3.4 &quot;Detailed uPacket =
TX AUX CH State Description&quot;. */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_TIMEOUT_PERIOD =3D 400,<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ideally, the SW timeout should be =
just above 550usec<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which is programmed in HW.<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * But the SW timeout of 600usec=
 is not reliable,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because on some systems, dela=
y_in_microseconds()<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * returns faster than it should=
.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * EPR #379763: by trial-and-err=
or on different systems,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 700usec is the minimum reliab=
le SW timeout for polling<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the AUX_SW_STATUS.AUX_SW_DONE=
 bit.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This timeout expires *only* w=
hen there is<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AUX Error or AUX Timeout cond=
itions - not during normal operation.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * During normal operation, AUX_=
SW_STATUS.AUX_SW_DONE bit is set<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * at most within ~240usec. That=
 means,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * increasing this timeout will =
not affect normal operation,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and we'll timeout after<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SW_AUX_TIMEOUT_PERIOD_MULTIPL=
IER * AUX_TIMEOUT_PERIOD =3D 1600usec.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This timeout is especially im=
portant for<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * resume from S3 and CTS. */<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIMEOUT_PERIOD_MULTIPLIER =3D =
4<br>
-};<br>
-<br>
-struct i2c_engine *dal_i2caux_acquire_i2c_sw_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum gpio_ddc_line line;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_engine *engine =3D NULL;<b=
r>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (get_hw_supported_ddc_line(ddc, &a=
mp;line))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; engine =3D i2caux-&gt;i2c_sw_engines[line];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; engine =3D i2caux-&gt;i2c_generic_sw_engine;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine-&gt;base.funcs-&gt;acquir=
e(&amp;engine-&gt;base, ddc))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return engine;<br>
-}<br>
-<br>
-struct aux_engine *dal_i2caux_acquire_aux_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum gpio_ddc_line line;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!get_hw_supported_ddc_line(ddc, &=
amp;line))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine =3D i2caux-&gt;aux_engines[lin=
e];<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!engine-&gt;base.funcs-&gt;acquir=
e(&amp;engine-&gt;base, ddc))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return engine;<br>
-}<br>
-<br>
-void dal_i2caux_release_engine(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engine)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;release_engine(e=
ngine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_ddc_close(engine-&gt;ddc);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;ddc =3D NULL;<br>
-}<br>
-<br>
-void dal_i2caux_construct(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;ctx =3D ctx;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;i2c_sw_engines[i] =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;i2c_hw_engines[i] =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;aux_engines[i] =3D NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &#43;&#43;i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (i &lt; GPIO_DDC_LINE_COUNT);=
<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;i2c_generic_sw_engine =3D =
NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;i2c_generic_hw_engine =3D =
NULL;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;aux_timeout_period =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx-&gt;dce_version &gt;=3D DCE_V=
ERSION_11_2) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;default_i2c_hw_speed =3D DEFAULT_I2C_HW_SPEED_100KHZ;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;default_i2c_sw_speed =3D DEFAULT_I2C_SW_SPEED_100KHZ;=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;default_i2c_hw_speed =3D DEFAULT_I2C_HW_SPEED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;default_i2c_sw_speed =3D DEFAULT_I2C_SW_SPEED;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-}<br>
-<br>
-void dal_i2caux_destruct(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i2caux-&gt;i2c_generic_hw_engine)=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;i2c_generic_hw_engine-&gt;funcs-&gt;destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2caux-&gt;=
i2c_generic_hw_engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i2caux-&gt;i2c_generic_sw_engine)=
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; i2caux-&gt;i2c_generic_sw_engine-&gt;funcs-&gt;destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2caux-&gt;=
i2c_generic_sw_engine);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i2caux-&gt;aux_engines[i])<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;aux_e=
ngines[i]-&gt;funcs-&gt;destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2caux-&gt;aux_engines[i]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i2caux-&gt;i2c_hw_engines[i])<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;i2c_h=
w_engines[i]-&gt;funcs-&gt;destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2caux-&gt;i2c_hw_engines[i]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (i2caux-&gt;i2c_sw_engines[i])<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;i2c_s=
w_engines[i]-&gt;funcs-&gt;destroy(<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;i2caux-&gt;i2c_sw_engines[i]);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; &#43;&#43;i;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (i &lt; GPIO_DDC_LINE_COUNT);=
<br>
-}<br>
-<br>
-- <br>
2.7.4<br>
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

--_000_BN6PR12MB180988BFAFE11BCE45991B04F7850BN6PR12MB1809namp_--

--===============0531173456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0531173456==--
