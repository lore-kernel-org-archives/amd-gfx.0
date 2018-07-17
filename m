From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 5/7] drm/amd/display: Decouple aux from i2c
Date: Tue, 17 Jul 2018 21:31:46 +0000
Message-ID: <MW2PR12MB258871F6CE41BD2726C6D1C0F95C0@MW2PR12MB2588.namprd12.prod.outlook.com>
References: <1531834174-4052-1-git-send-email-sunpeng.li@amd.com>
 <1531834174-4052-6-git-send-email-sunpeng.li@amd.com>,
 <CADnq5_M+TzVYtgJM=a_RxHLCDTHOwBU9obpLaqaJEO+iZ3X=3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0889784654=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_M+TzVYtgJM=a_RxHLCDTHOwBU9obpLaqaJEO+iZ3X=3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0889784654==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW2PR12MB258871F6CE41BD2726C6D1C0F95C0MW2PR12MB2588namp_"

--_000_MW2PR12MB258871F6CE41BD2726C6D1C0F95C0MW2PR12MB2588namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

In this patch, i2c is still using the old code path (nothing is changed for=
 i2c). For aux, locking is already done in drm (i2c also uses drm locks).


The new code for aux is same as the old one. Only difference is that some i=
2c code is removed from aux and aux is put in a different location to match=
 our other HW resources. As for the logic/behavior, it is exactly the same =
as before.




Bhawan



________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: July 17, 2018 12:07:30 PM
To: Li, Sun peng (Leo)
Cc: amd-gfx list; Lakha, Bhawanpreet
Subject: Re: [PATCH 5/7] drm/amd/display: Decouple aux from i2c

On Tue, Jul 17, 2018 at 9:29 AM,  <sunpeng.li-5C7GfCeVMHo@public.gmane.org> wrote:
> From: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
>
> [Why]
> Aux engine is created from i2caux layer. We want to remove this layer
> and use the engine directly.
>
> [How]
> Decouple aux engine from i2caux. Move aux engine related code to dce fold=
er and use
> dc resource pool to manage the engine. And use the engine functions direc=
tly
>

Don't i2c and aux share the same physical pins?  If so, do you have
appropriate locking to arbitrate access to the pins from either
engine?

Alex


> Change-Id: Iecb609fe815dab31ed6b6100916c4b49ed6539a0
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |  22 +-
>  drivers/gpu/drm/amd/display/dc/dce/Makefile        |   2 +-
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       | 942 +++++++++++++++=
++++++
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       | 111 +++
>  .../drm/amd/display/dc/dce100/dce100_resource.c    |  42 +
>  .../drm/amd/display/dc/dce110/dce110_resource.c    |  45 +
>  .../drm/amd/display/dc/dce112/dce112_resource.c    |  47 +
>  .../drm/amd/display/dc/dce120/dce120_resource.c    |  42 +
>  .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |  44 +
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |  44 +
>  drivers/gpu/drm/amd/display/dc/i2caux/engine.h     |   1 +
>  drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   2 +-
>  drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h | 113 +++
>  drivers/gpu/drm/amd/display/dc/inc/hw/engine.h     | 106 +++
>  14 files changed, 1549 insertions(+), 14 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/engine.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_link_ddc.c
> index 08c9d73..4019fe07 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> @@ -33,10 +33,8 @@
>  #include "include/vector.h"
>  #include "core_types.h"
>  #include "dc_link_ddc.h"
> -#include "i2caux/engine.h"
> -#include "i2caux/i2c_engine.h"
> -#include "i2caux/aux_engine.h"
> -#include "i2caux/i2caux.h"
> +#include "engine.h"
> +#include "aux_engine.h"
>
>  #define AUX_POWER_UP_WA_DELAY 500
>  #define I2C_OVER_AUX_DEFER_WA_DELAY 70
> @@ -641,9 +639,9 @@ int dc_link_aux_transfer(struct ddc_service *ddc,
>                              enum aux_transaction_type type,
>                              enum i2caux_transaction_action action)
>  {
> -       struct i2caux *i2caux =3D ddc->ctx->i2caux;
>         struct ddc *ddc_pin =3D ddc->ddc_pin;
> -       struct aux_engine *engine;
> +       struct engine *engine;
> +       struct aux_engine *aux_engine;
>         enum aux_channel_operation_result operation_result;
>         struct aux_request_transaction_data aux_req;
>         struct aux_reply_transaction_data aux_rep;
> @@ -654,7 +652,8 @@ int dc_link_aux_transfer(struct ddc_service *ddc,
>         memset(&aux_req, 0, sizeof(aux_req));
>         memset(&aux_rep, 0, sizeof(aux_rep));
>
> -       engine =3D i2caux->funcs->acquire_aux_engine(i2caux, ddc_pin);
> +       engine =3D ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]=
;
> +       aux_engine =3D engine->funcs->acquire(engine, ddc_pin);
>
>         aux_req.type =3D type;
>         aux_req.action =3D action;
> @@ -664,15 +663,15 @@ int dc_link_aux_transfer(struct ddc_service *ddc,
>         aux_req.length =3D size;
>         aux_req.data =3D buffer;
>
> -       engine->funcs->submit_channel_request(engine, &aux_req);
> -       operation_result =3D engine->funcs->get_channel_status(engine, &r=
eturned_bytes);
> +       aux_engine->funcs->submit_channel_request(aux_engine, &aux_req);
> +       operation_result =3D aux_engine->funcs->get_channel_status(aux_en=
gine, &returned_bytes);
>
>         switch (operation_result) {
>         case AUX_CHANNEL_OPERATION_SUCCEEDED:
>                 res =3D returned_bytes;
>
>                 if (res <=3D size && res >=3D 0)
> -                       res =3D engine->funcs->read_channel_reply(engine,=
 size,
> +                       res =3D aux_engine->funcs->read_channel_reply(aux=
_engine, size,
>                                                                 buffer, r=
eply,
>                                                                 &status);
>
> @@ -686,8 +685,7 @@ int dc_link_aux_transfer(struct ddc_service *ddc,
>                 res =3D -1;
>                 break;
>         }
> -
> -       i2caux->funcs->release_engine(i2caux, &engine->base);
> +       aux_engine->base.funcs->release_engine(&aux_engine->base);
>         return res;
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/dr=
m/amd/display/dc/dce/Makefile
> index 11401fd..825537b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
> @@ -28,7 +28,7 @@
>
>  DCE =3D dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o =
\
>  dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
> -dce_clocks.o dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o
> +dce_clocks.o dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o
>
>
>  AMD_DAL_DCE =3D $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_aux.c
> new file mode 100644
> index 0000000..b28e212
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -0,0 +1,942 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dm_services.h"
> +#include "dce_aux.h"
> +#include "dce/dce_11_0_sh_mask.h"
> +
> +#define CTX \
> +       aux110->base.base.ctx
> +#define REG(reg_name)\
> +       (aux110->regs->reg_name)
> +
> +#define DC_LOGGER \
> +       engine->base.ctx->logger
> +
> +#include "reg_helper.h"
> +
> +#define FROM_AUX_ENGINE(ptr) \
> +       container_of((ptr), struct aux_engine_dce110, base)
> +
> +#define FROM_ENGINE(ptr) \
> +       FROM_AUX_ENGINE(container_of((ptr), struct aux_engine, base))
> +
> +#define FROM_AUX_ENGINE_ENGINE(ptr) \
> +       container_of((ptr), struct aux_engine, base)
> +enum {
> +       AUX_INVALID_REPLY_RETRY_COUNTER =3D 1,
> +       AUX_TIMED_OUT_RETRY_COUNTER =3D 2,
> +       AUX_DEFER_RETRY_COUNTER =3D 6
> +};
> +static void release_engine(
> +       struct engine *engine)
> +{
> +       struct aux_engine_dce110 *aux110 =3D FROM_ENGINE(engine);
> +
> +       dal_ddc_close(engine->ddc);
> +
> +       engine->ddc =3D NULL;
> +
> +       REG_UPDATE(AUX_ARB_CONTROL, AUX_SW_DONE_USING_AUX_REG, 1);
> +}
> +
> +#define SW_CAN_ACCESS_AUX 1
> +#define DMCU_CAN_ACCESS_AUX 2
> +
> +static bool is_engine_available(
> +       struct aux_engine *engine)
> +{
> +       struct aux_engine_dce110 *aux110 =3D FROM_AUX_ENGINE(engine);
> +
> +       uint32_t value =3D REG_READ(AUX_ARB_CONTROL);
> +       uint32_t field =3D get_reg_field_value(
> +                       value,
> +                       AUX_ARB_CONTROL,
> +                       AUX_REG_RW_CNTL_STATUS);
> +
> +       return (field !=3D DMCU_CAN_ACCESS_AUX);
> +}
> +static bool acquire_engine(
> +       struct aux_engine *engine)
> +{
> +       struct aux_engine_dce110 *aux110 =3D FROM_AUX_ENGINE(engine);
> +
> +       uint32_t value =3D REG_READ(AUX_ARB_CONTROL);
> +       uint32_t field =3D get_reg_field_value(
> +                       value,
> +                       AUX_ARB_CONTROL,
> +                       AUX_REG_RW_CNTL_STATUS);
> +       if (field =3D=3D DMCU_CAN_ACCESS_AUX)
> +               return false;
> +       /* enable AUX before request SW to access AUX */
> +       value =3D REG_READ(AUX_CONTROL);
> +       field =3D get_reg_field_value(value,
> +                               AUX_CONTROL,
> +                               AUX_EN);
> +
> +       if (field =3D=3D 0) {
> +               set_reg_field_value(
> +                               value,
> +                               1,
> +                               AUX_CONTROL,
> +                               AUX_EN);
> +
> +               if (REG(AUX_RESET_MASK)) {
> +                       /*DP_AUX block as part of the enable sequence*/
> +                       set_reg_field_value(
> +                               value,
> +                               1,
> +                               AUX_CONTROL,
> +                               AUX_RESET);
> +               }
> +
> +               REG_WRITE(AUX_CONTROL, value);
> +
> +               if (REG(AUX_RESET_MASK)) {
> +                       /*poll HW to make sure reset it done*/
> +
> +                       REG_WAIT(AUX_CONTROL, AUX_RESET_DONE, 1,
> +                                       1, 11);
> +
> +                       set_reg_field_value(
> +                               value,
> +                               0,
> +                               AUX_CONTROL,
> +                               AUX_RESET);
> +
> +                       REG_WRITE(AUX_CONTROL, value);
> +
> +                       REG_WAIT(AUX_CONTROL, AUX_RESET_DONE, 0,
> +                                       1, 11);
> +               }
> +       } /*if (field)*/
> +
> +       /* request SW to access AUX */
> +       REG_UPDATE(AUX_ARB_CONTROL, AUX_SW_USE_AUX_REG_REQ, 1);
> +
> +       value =3D REG_READ(AUX_ARB_CONTROL);
> +       field =3D get_reg_field_value(
> +                       value,
> +                       AUX_ARB_CONTROL,
> +                       AUX_REG_RW_CNTL_STATUS);
> +
> +       return (field =3D=3D SW_CAN_ACCESS_AUX);
> +}
> +
> +#define COMPOSE_AUX_SW_DATA_16_20(command, address) \
> +       ((command) | ((0xF0000 & (address)) >> 16))
> +
> +#define COMPOSE_AUX_SW_DATA_8_15(address) \
> +       ((0xFF00 & (address)) >> 8)
> +
> +#define COMPOSE_AUX_SW_DATA_0_7(address) \
> +       (0xFF & (address))
> +
> +static void submit_channel_request(
> +       struct aux_engine *engine,
> +       struct aux_request_transaction_data *request)
> +{
> +       struct aux_engine_dce110 *aux110 =3D FROM_AUX_ENGINE(engine);
> +       uint32_t value;
> +       uint32_t length;
> +
> +       bool is_write =3D
> +               ((request->type =3D=3D AUX_TRANSACTION_TYPE_DP) &&
> +                (request->action =3D=3D I2CAUX_TRANSACTION_ACTION_DP_WRI=
TE)) ||
> +               ((request->type =3D=3D AUX_TRANSACTION_TYPE_I2C) &&
> +               ((request->action =3D=3D I2CAUX_TRANSACTION_ACTION_I2C_WR=
ITE) ||
> +                (request->action =3D=3D I2CAUX_TRANSACTION_ACTION_I2C_WR=
ITE_MOT)));
> +       if (REG(AUXN_IMPCAL)) {
> +               /* clear_aux_error */
> +               REG_UPDATE_SEQ(AUXN_IMPCAL, AUXN_CALOUT_ERROR_AK,
> +                               1,
> +                               0);
> +
> +               REG_UPDATE_SEQ(AUXP_IMPCAL, AUXP_CALOUT_ERROR_AK,
> +                               1,
> +                               0);
> +
> +               /* force_default_calibrate */
> +               REG_UPDATE_1BY1_2(AUXN_IMPCAL,
> +                               AUXN_IMPCAL_ENABLE, 1,
> +                               AUXN_IMPCAL_OVERRIDE_ENABLE, 0);
> +
> +               /* bug? why AUXN update EN and OVERRIDE_EN 1 by 1 while A=
UX P toggles OVERRIDE? */
> +
> +               REG_UPDATE_SEQ(AUXP_IMPCAL, AUXP_IMPCAL_OVERRIDE_ENABLE,
> +                               1,
> +                               0);
> +       }
> +       /* set the delay and the number of bytes to write */
> +
> +       /* The length include
> +        * the 4 bit header and the 20 bit address
> +        * (that is 3 byte).
> +        * If the requested length is non zero this means
> +        * an addition byte specifying the length is required.
> +        */
> +
> +       length =3D request->length ? 4 : 3;
> +       if (is_write)
> +               length +=3D request->length;
> +
> +       REG_UPDATE_2(AUX_SW_CONTROL,
> +                       AUX_SW_START_DELAY, request->delay,
> +                       AUX_SW_WR_BYTES, length);
> +
> +       /* program action and address and payload data (if 'is_write') */
> +       value =3D REG_UPDATE_4(AUX_SW_DATA,
> +                       AUX_SW_INDEX, 0,
> +                       AUX_SW_DATA_RW, 0,
> +                       AUX_SW_AUTOINCREMENT_DISABLE, 1,
> +                       AUX_SW_DATA, COMPOSE_AUX_SW_DATA_16_20(request->a=
ction, request->address));
> +
> +       value =3D REG_SET_2(AUX_SW_DATA, value,
> +                       AUX_SW_AUTOINCREMENT_DISABLE, 0,
> +                       AUX_SW_DATA, COMPOSE_AUX_SW_DATA_8_15(request->ad=
dress));
> +
> +       value =3D REG_SET(AUX_SW_DATA, value,
> +                       AUX_SW_DATA, COMPOSE_AUX_SW_DATA_0_7(request->add=
ress));
> +
> +       if (request->length) {
> +               value =3D REG_SET(AUX_SW_DATA, value,
> +                               AUX_SW_DATA, request->length - 1);
> +       }
> +
> +       if (is_write) {
> +               /* Load the HW buffer with the Data to be sent.
> +                * This is relevant for write operation.
> +                * For read, the data recived data will be
> +                * processed in process_channel_reply().
> +                */
> +               uint32_t i =3D 0;
> +
> +               while (i < request->length) {
> +                       value =3D REG_SET(AUX_SW_DATA, value,
> +                                       AUX_SW_DATA, request->data[i]);
> +
> +                       ++i;
> +               }
> +       }
> +
> +       REG_UPDATE(AUX_INTERRUPT_CONTROL, AUX_SW_DONE_ACK, 1);
> +       REG_WAIT(AUX_SW_STATUS, AUX_SW_DONE, 0,
> +                               10, aux110->timeout_period/10);
> +       REG_UPDATE(AUX_SW_CONTROL, AUX_SW_GO, 1);
> +}
> +
> +static int read_channel_reply(struct aux_engine *engine, uint32_t size,
> +                             uint8_t *buffer, uint8_t *reply_result,
> +                             uint32_t *sw_status)
> +{
> +       struct aux_engine_dce110 *aux110 =3D FROM_AUX_ENGINE(engine);
> +       uint32_t bytes_replied;
> +       uint32_t reply_result_32;
> +
> +       *sw_status =3D REG_GET(AUX_SW_STATUS, AUX_SW_REPLY_BYTE_COUNT,
> +                            &bytes_replied);
> +
> +       /* In case HPD is LOW, exit AUX transaction */
> +       if ((*sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK))
> +               return -1;
> +
> +       /* Need at least the status byte */
> +       if (!bytes_replied)
> +               return -1;
> +
> +       REG_UPDATE_1BY1_3(AUX_SW_DATA,
> +                         AUX_SW_INDEX, 0,
> +                         AUX_SW_AUTOINCREMENT_DISABLE, 1,
> +                         AUX_SW_DATA_RW, 1);
> +
> +       REG_GET(AUX_SW_DATA, AUX_SW_DATA, &reply_result_32);
> +       reply_result_32 =3D reply_result_32 >> 4;
> +       *reply_result =3D (uint8_t)reply_result_32;
> +
> +       if (reply_result_32 =3D=3D 0) { /* ACK */
> +               uint32_t i =3D 0;
> +
> +               /* First byte was already used to get the command status =
*/
> +               --bytes_replied;
> +
> +               /* Do not overflow buffer */
> +               if (bytes_replied > size)
> +                       return -1;
> +
> +               while (i < bytes_replied) {
> +                       uint32_t aux_sw_data_val;
> +
> +                       REG_GET(AUX_SW_DATA, AUX_SW_DATA, &aux_sw_data_va=
l);
> +                       buffer[i] =3D aux_sw_data_val;
> +                       ++i;
> +               }
> +
> +               return i;
> +       }
> +
> +       return 0;
> +}
> +
> +static void process_channel_reply(
> +       struct aux_engine *engine,
> +       struct aux_reply_transaction_data *reply)
> +{
> +       int bytes_replied;
> +       uint8_t reply_result;
> +       uint32_t sw_status;
> +
> +       bytes_replied =3D read_channel_reply(engine, reply->length, reply=
->data,
> +                                          &reply_result, &sw_status);
> +
> +       /* in case HPD is LOW, exit AUX transaction */
> +       if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
> +               reply->status =3D AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON=
;
> +               return;
> +       }
> +
> +       if (bytes_replied < 0) {
> +               /* Need to handle an error case...
> +                * Hopefully, upper layer function won't call this functi=
on if
> +                * the number of bytes in the reply was 0, because there =
was
> +                * surely an error that was asserted that should have bee=
n
> +                * handled for hot plug case, this could happens
> +                */
> +               if (!(sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK))=
 {
> +                       reply->status =3D AUX_TRANSACTION_REPLY_INVALID;
> +                       ASSERT_CRITICAL(false);
> +                       return;
> +               }
> +       } else {
> +
> +               switch (reply_result) {
> +               case 0: /* ACK */
> +                       reply->status =3D AUX_TRANSACTION_REPLY_AUX_ACK;
> +               break;
> +               case 1: /* NACK */
> +                       reply->status =3D AUX_TRANSACTION_REPLY_AUX_NACK;
> +               break;
> +               case 2: /* DEFER */
> +                       reply->status =3D AUX_TRANSACTION_REPLY_AUX_DEFER=
;
> +               break;
> +               case 4: /* AUX ACK / I2C NACK */
> +                       reply->status =3D AUX_TRANSACTION_REPLY_I2C_NACK;
> +               break;
> +               case 8: /* AUX ACK / I2C DEFER */
> +                       reply->status =3D AUX_TRANSACTION_REPLY_I2C_DEFER=
;
> +               break;
> +               default:
> +                       reply->status =3D AUX_TRANSACTION_REPLY_INVALID;
> +               }
> +       }
> +}
> +
> +static enum aux_channel_operation_result get_channel_status(
> +       struct aux_engine *engine,
> +       uint8_t *returned_bytes)
> +{
> +       struct aux_engine_dce110 *aux110 =3D FROM_AUX_ENGINE(engine);
> +
> +       uint32_t value;
> +
> +       if (returned_bytes =3D=3D NULL) {
> +               /*caller pass NULL pointer*/
> +               ASSERT_CRITICAL(false);
> +               return AUX_CHANNEL_OPERATION_FAILED_REASON_UNKNOWN;
> +       }
> +       *returned_bytes =3D 0;
> +
> +       /* poll to make sure that SW_DONE is asserted */
> +       value =3D REG_WAIT(AUX_SW_STATUS, AUX_SW_DONE, 1,
> +                               10, aux110->timeout_period/10);
> +
> +       /* in case HPD is LOW, exit AUX transaction */
> +       if ((value & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK))
> +               return AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
> +
> +       /* Note that the following bits are set in 'status.bits'
> +        * during CTS 4.2.1.2 (FW 3.3.1):
> +        * AUX_SW_RX_MIN_COUNT_VIOL, AUX_SW_RX_INVALID_STOP,
> +        * AUX_SW_RX_RECV_NO_DET, AUX_SW_RX_RECV_INVALID_H.
> +        *
> +        * AUX_SW_RX_MIN_COUNT_VIOL is an internal,
> +        * HW debugging bit and should be ignored.
> +        */
> +       if (value & AUX_SW_STATUS__AUX_SW_DONE_MASK) {
> +               if ((value & AUX_SW_STATUS__AUX_SW_RX_TIMEOUT_STATE_MASK)=
 ||
> +                       (value & AUX_SW_STATUS__AUX_SW_RX_TIMEOUT_MASK))
> +                       return AUX_CHANNEL_OPERATION_FAILED_TIMEOUT;
> +
> +               else if ((value & AUX_SW_STATUS__AUX_SW_RX_INVALID_STOP_M=
ASK) ||
> +                       (value & AUX_SW_STATUS__AUX_SW_RX_RECV_NO_DET_MAS=
K) ||
> +                       (value &
> +                               AUX_SW_STATUS__AUX_SW_RX_RECV_INVALID_H_M=
ASK) ||
> +                       (value & AUX_SW_STATUS__AUX_SW_RX_RECV_INVALID_L_=
MASK))
> +                       return AUX_CHANNEL_OPERATION_FAILED_INVALID_REPLY=
;
> +
> +               *returned_bytes =3D get_reg_field_value(value,
> +                               AUX_SW_STATUS,
> +                               AUX_SW_REPLY_BYTE_COUNT);
> +
> +               if (*returned_bytes =3D=3D 0)
> +                       return
> +                       AUX_CHANNEL_OPERATION_FAILED_INVALID_REPLY;
> +               else {
> +                       *returned_bytes -=3D 1;
> +                       return AUX_CHANNEL_OPERATION_SUCCEEDED;
> +               }
> +       } else {
> +               /*time_elapsed >=3D aux_engine->timeout_period
> +                *  AUX_SW_STATUS__AUX_SW_HPD_DISCON =3D at this point
> +                */
> +               ASSERT_CRITICAL(false);
> +               return AUX_CHANNEL_OPERATION_FAILED_TIMEOUT;
> +       }
> +}
> +static void process_read_reply(
> +       struct aux_engine *engine,
> +       struct read_command_context *ctx)
> +{
> +       engine->funcs->process_channel_reply(engine, &ctx->reply);
> +
> +       switch (ctx->reply.status) {
> +       case AUX_TRANSACTION_REPLY_AUX_ACK:
> +               ctx->defer_retry_aux =3D 0;
> +               if (ctx->returned_byte > ctx->current_read_length) {
> +                       ctx->status =3D
> +                               I2CAUX_TRANSACTION_STATUS_FAILED_PROTOCOL=
_ERROR;
> +                       ctx->operation_succeeded =3D false;
> +               } else if (ctx->returned_byte < ctx->current_read_length)=
 {
> +                       ctx->current_read_length -=3D ctx->returned_byte;
> +
> +                       ctx->offset +=3D ctx->returned_byte;
> +
> +                       ++ctx->invalid_reply_retry_aux_on_ack;
> +
> +                       if (ctx->invalid_reply_retry_aux_on_ack >
> +                               AUX_INVALID_REPLY_RETRY_COUNTER) {
> +                               ctx->status =3D
> +                               I2CAUX_TRANSACTION_STATUS_FAILED_PROTOCOL=
_ERROR;
> +                               ctx->operation_succeeded =3D false;
> +                       }
> +               } else {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_SUCCEED=
ED;
> +                       ctx->transaction_complete =3D true;
> +                       ctx->operation_succeeded =3D true;
> +               }
> +       break;
> +       case AUX_TRANSACTION_REPLY_AUX_NACK:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_NACK;
> +               ctx->operation_succeeded =3D false;
> +       break;
> +       case AUX_TRANSACTION_REPLY_AUX_DEFER:
> +               ++ctx->defer_retry_aux;
> +
> +               if (ctx->defer_retry_aux > AUX_DEFER_RETRY_COUNTER) {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_=
TIMEOUT;
> +                       ctx->operation_succeeded =3D false;
> +               }
> +       break;
> +       case AUX_TRANSACTION_REPLY_I2C_DEFER:
> +               ctx->defer_retry_aux =3D 0;
> +
> +               ++ctx->defer_retry_i2c;
> +
> +               if (ctx->defer_retry_i2c > AUX_DEFER_RETRY_COUNTER) {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_=
TIMEOUT;
> +                       ctx->operation_succeeded =3D false;
> +               }
> +       break;
> +       case AUX_TRANSACTION_REPLY_HPD_DISCON:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD_DISC=
ON;
> +               ctx->operation_succeeded =3D false;
> +       break;
> +       default:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;
> +               ctx->operation_succeeded =3D false;
> +       }
> +}
> +static void process_read_request(
> +       struct aux_engine *engine,
> +       struct read_command_context *ctx)
> +{
> +       enum aux_channel_operation_result operation_result;
> +
> +       engine->funcs->submit_channel_request(engine, &ctx->request);
> +
> +       operation_result =3D engine->funcs->get_channel_status(
> +               engine, &ctx->returned_byte);
> +
> +       switch (operation_result) {
> +       case AUX_CHANNEL_OPERATION_SUCCEEDED:
> +               if (ctx->returned_byte > ctx->current_read_length) {
> +                       ctx->status =3D
> +                               I2CAUX_TRANSACTION_STATUS_FAILED_PROTOCOL=
_ERROR;
> +                       ctx->operation_succeeded =3D false;
> +               } else {
> +                       ctx->timed_out_retry_aux =3D 0;
> +                       ctx->invalid_reply_retry_aux =3D 0;
> +
> +                       ctx->reply.length =3D ctx->returned_byte;
> +                       ctx->reply.data =3D ctx->buffer;
> +
> +                       process_read_reply(engine, ctx);
> +               }
> +       break;
> +       case AUX_CHANNEL_OPERATION_FAILED_INVALID_REPLY:
> +               ++ctx->invalid_reply_retry_aux;
> +
> +               if (ctx->invalid_reply_retry_aux >
> +                       AUX_INVALID_REPLY_RETRY_COUNTER) {
> +                       ctx->status =3D
> +                               I2CAUX_TRANSACTION_STATUS_FAILED_PROTOCOL=
_ERROR;
> +                       ctx->operation_succeeded =3D false;
> +               } else
> +                       udelay(400);
> +       break;
> +       case AUX_CHANNEL_OPERATION_FAILED_TIMEOUT:
> +               ++ctx->timed_out_retry_aux;
> +
> +               if (ctx->timed_out_retry_aux > AUX_TIMED_OUT_RETRY_COUNTE=
R) {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_=
TIMEOUT;
> +                       ctx->operation_succeeded =3D false;
> +               } else {
> +                       /* DP 1.2a, table 2-58:
> +                        * "S3: AUX Request CMD PENDING:
> +                        * retry 3 times, with 400usec wait on each"
> +                        * The HW timeout is set to 550usec,
> +                        * so we should not wait here
> +                        */
> +               }
> +       break;
> +       case AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD_DISC=
ON;
> +               ctx->operation_succeeded =3D false;
> +       break;
> +       default:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;
> +               ctx->operation_succeeded =3D false;
> +       }
> +}
> +static bool read_command(
> +       struct aux_engine *engine,
> +       struct i2caux_transaction_request *request,
> +       bool middle_of_transaction)
> +{
> +       struct read_command_context ctx;
> +
> +       ctx.buffer =3D request->payload.data;
> +       ctx.current_read_length =3D request->payload.length;
> +       ctx.offset =3D 0;
> +       ctx.timed_out_retry_aux =3D 0;
> +       ctx.invalid_reply_retry_aux =3D 0;
> +       ctx.defer_retry_aux =3D 0;
> +       ctx.defer_retry_i2c =3D 0;
> +       ctx.invalid_reply_retry_aux_on_ack =3D 0;
> +       ctx.transaction_complete =3D false;
> +       ctx.operation_succeeded =3D true;
> +
> +       if (request->payload.address_space =3D=3D
> +               I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {
> +               ctx.request.type =3D AUX_TRANSACTION_TYPE_DP;
> +               ctx.request.action =3D I2CAUX_TRANSACTION_ACTION_DP_READ;
> +               ctx.request.address =3D request->payload.address;
> +       } else if (request->payload.address_space =3D=3D
> +               I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C) {
> +               ctx.request.type =3D AUX_TRANSACTION_TYPE_I2C;
> +               ctx.request.action =3D middle_of_transaction ?
> +                       I2CAUX_TRANSACTION_ACTION_I2C_READ_MOT :
> +                       I2CAUX_TRANSACTION_ACTION_I2C_READ;
> +               ctx.request.address =3D request->payload.address >> 1;
> +       } else {
> +               /* in DAL2, there was no return in such case */
> +               BREAK_TO_DEBUGGER();
> +               return false;
> +       }
> +
> +       ctx.request.delay =3D 0;
> +
> +       do {
> +               memset(ctx.buffer + ctx.offset, 0, ctx.current_read_lengt=
h);
> +
> +               ctx.request.data =3D ctx.buffer + ctx.offset;
> +               ctx.request.length =3D ctx.current_read_length;
> +
> +               process_read_request(engine, &ctx);
> +
> +               request->status =3D ctx.status;
> +
> +               if (ctx.operation_succeeded && !ctx.transaction_complete)
> +                       if (ctx.request.type =3D=3D AUX_TRANSACTION_TYPE_=
I2C)
> +                               msleep(engine->delay);
> +       } while (ctx.operation_succeeded && !ctx.transaction_complete);
> +
> +       if (request->payload.address_space =3D=3D
> +               I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {
> +               DC_LOG_I2C_AUX("READ: addr:0x%x  value:0x%x Result:%d",
> +                               request->payload.address,
> +                               request->payload.data[0],
> +                               ctx.operation_succeeded);
> +       }
> +
> +       return ctx.operation_succeeded;
> +}
> +
> +static void process_write_reply(
> +       struct aux_engine *engine,
> +       struct write_command_context *ctx)
> +{
> +       engine->funcs->process_channel_reply(engine, &ctx->reply);
> +
> +       switch (ctx->reply.status) {
> +       case AUX_TRANSACTION_REPLY_AUX_ACK:
> +               ctx->operation_succeeded =3D true;
> +
> +               if (ctx->returned_byte) {
> +                       ctx->request.action =3D ctx->mot ?
> +                       I2CAUX_TRANSACTION_ACTION_I2C_STATUS_REQUEST_MOT =
:
> +                       I2CAUX_TRANSACTION_ACTION_I2C_STATUS_REQUEST;
> +
> +                       ctx->current_write_length =3D 0;
> +
> +                       ++ctx->ack_m_retry;
> +
> +                       if (ctx->ack_m_retry > AUX_DEFER_RETRY_COUNTER) {
> +                               ctx->status =3D
> +                               I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT;
> +                               ctx->operation_succeeded =3D false;
> +                       } else
> +                               udelay(300);
> +               } else {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_SUCCEED=
ED;
> +                       ctx->defer_retry_aux =3D 0;
> +                       ctx->ack_m_retry =3D 0;
> +                       ctx->transaction_complete =3D true;
> +               }
> +       break;
> +       case AUX_TRANSACTION_REPLY_AUX_NACK:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_NACK;
> +               ctx->operation_succeeded =3D false;
> +       break;
> +       case AUX_TRANSACTION_REPLY_AUX_DEFER:
> +               ++ctx->defer_retry_aux;
> +
> +               if (ctx->defer_retry_aux > ctx->max_defer_retry) {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_=
TIMEOUT;
> +                       ctx->operation_succeeded =3D false;
> +               }
> +       break;
> +       case AUX_TRANSACTION_REPLY_I2C_DEFER:
> +               ctx->defer_retry_aux =3D 0;
> +               ctx->current_write_length =3D 0;
> +
> +               ctx->request.action =3D ctx->mot ?
> +                       I2CAUX_TRANSACTION_ACTION_I2C_STATUS_REQUEST_MOT =
:
> +                       I2CAUX_TRANSACTION_ACTION_I2C_STATUS_REQUEST;
> +
> +               ++ctx->defer_retry_i2c;
> +
> +               if (ctx->defer_retry_i2c > ctx->max_defer_retry) {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_=
TIMEOUT;
> +                       ctx->operation_succeeded =3D false;
> +               }
> +       break;
> +       case AUX_TRANSACTION_REPLY_HPD_DISCON:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD_DISC=
ON;
> +               ctx->operation_succeeded =3D false;
> +       break;
> +       default:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;
> +               ctx->operation_succeeded =3D false;
> +       }
> +}
> +static void process_write_request(
> +       struct aux_engine *engine,
> +       struct write_command_context *ctx)
> +{
> +       enum aux_channel_operation_result operation_result;
> +
> +       engine->funcs->submit_channel_request(engine, &ctx->request);
> +
> +       operation_result =3D engine->funcs->get_channel_status(
> +               engine, &ctx->returned_byte);
> +
> +       switch (operation_result) {
> +       case AUX_CHANNEL_OPERATION_SUCCEEDED:
> +               ctx->timed_out_retry_aux =3D 0;
> +               ctx->invalid_reply_retry_aux =3D 0;
> +
> +               ctx->reply.length =3D ctx->returned_byte;
> +               ctx->reply.data =3D ctx->reply_data;
> +
> +               process_write_reply(engine, ctx);
> +       break;
> +       case AUX_CHANNEL_OPERATION_FAILED_INVALID_REPLY:
> +               ++ctx->invalid_reply_retry_aux;
> +
> +               if (ctx->invalid_reply_retry_aux >
> +                       AUX_INVALID_REPLY_RETRY_COUNTER) {
> +                       ctx->status =3D
> +                               I2CAUX_TRANSACTION_STATUS_FAILED_PROTOCOL=
_ERROR;
> +                       ctx->operation_succeeded =3D false;
> +               } else
> +                       udelay(400);
> +       break;
> +       case AUX_CHANNEL_OPERATION_FAILED_TIMEOUT:
> +               ++ctx->timed_out_retry_aux;
> +
> +               if (ctx->timed_out_retry_aux > AUX_TIMED_OUT_RETRY_COUNTE=
R) {
> +                       ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_=
TIMEOUT;
> +                       ctx->operation_succeeded =3D false;
> +               } else {
> +                       /* DP 1.2a, table 2-58:
> +                        * "S3: AUX Request CMD PENDING:
> +                        * retry 3 times, with 400usec wait on each"
> +                        * The HW timeout is set to 550usec,
> +                        * so we should not wait here
> +                        */
> +               }
> +       break;
> +       case AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD_DISC=
ON;
> +               ctx->operation_succeeded =3D false;
> +       break;
> +       default:
> +               ctx->status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;
> +               ctx->operation_succeeded =3D false;
> +       }
> +}
> +static bool write_command(
> +       struct aux_engine *engine,
> +       struct i2caux_transaction_request *request,
> +       bool middle_of_transaction)
> +{
> +       struct write_command_context ctx;
> +
> +       ctx.mot =3D middle_of_transaction;
> +       ctx.buffer =3D request->payload.data;
> +       ctx.current_write_length =3D request->payload.length;
> +       ctx.timed_out_retry_aux =3D 0;
> +       ctx.invalid_reply_retry_aux =3D 0;
> +       ctx.defer_retry_aux =3D 0;
> +       ctx.defer_retry_i2c =3D 0;
> +       ctx.ack_m_retry =3D 0;
> +       ctx.transaction_complete =3D false;
> +       ctx.operation_succeeded =3D true;
> +
> +       if (request->payload.address_space =3D=3D
> +               I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {
> +               ctx.request.type =3D AUX_TRANSACTION_TYPE_DP;
> +               ctx.request.action =3D I2CAUX_TRANSACTION_ACTION_DP_WRITE=
;
> +               ctx.request.address =3D request->payload.address;
> +       } else if (request->payload.address_space =3D=3D
> +               I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C) {
> +               ctx.request.type =3D AUX_TRANSACTION_TYPE_I2C;
> +               ctx.request.action =3D middle_of_transaction ?
> +                       I2CAUX_TRANSACTION_ACTION_I2C_WRITE_MOT :
> +                       I2CAUX_TRANSACTION_ACTION_I2C_WRITE;
> +               ctx.request.address =3D request->payload.address >> 1;
> +       } else {
> +               /* in DAL2, there was no return in such case */
> +               BREAK_TO_DEBUGGER();
> +               return false;
> +       }
> +
> +       ctx.request.delay =3D 0;
> +
> +       ctx.max_defer_retry =3D
> +               (engine->max_defer_write_retry > AUX_DEFER_RETRY_COUNTER)=
 ?
> +                       engine->max_defer_write_retry : AUX_DEFER_RETRY_C=
OUNTER;
> +
> +       do {
> +               ctx.request.data =3D ctx.buffer;
> +               ctx.request.length =3D ctx.current_write_length;
> +
> +               process_write_request(engine, &ctx);
> +
> +               request->status =3D ctx.status;
> +
> +               if (ctx.operation_succeeded && !ctx.transaction_complete)
> +                       if (ctx.request.type =3D=3D AUX_TRANSACTION_TYPE_=
I2C)
> +                               msleep(engine->delay);
> +       } while (ctx.operation_succeeded && !ctx.transaction_complete);
> +
> +       if (request->payload.address_space =3D=3D
> +               I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {
> +               DC_LOG_I2C_AUX("WRITE: addr:0x%x  value:0x%x Result:%d",
> +                               request->payload.address,
> +                               request->payload.data[0],
> +                               ctx.operation_succeeded);
> +       }
> +
> +       return ctx.operation_succeeded;
> +}
> +static bool end_of_transaction_command(
> +       struct aux_engine *engine,
> +       struct i2caux_transaction_request *request)
> +{
> +       struct i2caux_transaction_request dummy_request;
> +       uint8_t dummy_data;
> +
> +       /* [tcheng] We only need to send the stop (read with MOT =3D 0)
> +        * for I2C-over-Aux, not native AUX
> +        */
> +
> +       if (request->payload.address_space !=3D
> +               I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C)
> +               return false;
> +
> +       dummy_request.operation =3D request->operation;
> +       dummy_request.payload.address_space =3D request->payload.address_=
space;
> +       dummy_request.payload.address =3D request->payload.address;
> +
> +       /*
> +        * Add a dummy byte due to some receiver quirk
> +        * where one byte is sent along with MOT =3D 0.
> +        * Ideally this should be 0.
> +        */
> +
> +       dummy_request.payload.length =3D 0;
> +       dummy_request.payload.data =3D &dummy_data;
> +
> +       if (request->operation =3D=3D I2CAUX_TRANSACTION_READ)
> +               return read_command(engine, &dummy_request, false);
> +       else
> +               return write_command(engine, &dummy_request, false);
> +
> +       /* according Syed, it does not need now DoDummyMOT */
> +}
> +bool submit_request(
> +       struct engine *engine,
> +       struct i2caux_transaction_request *request,
> +       bool middle_of_transaction)
> +{
> +       struct aux_engine *aux_engine =3D FROM_AUX_ENGINE_ENGINE(engine);
> +
> +       bool result;
> +       bool mot_used =3D true;
> +
> +       switch (request->operation) {
> +       case I2CAUX_TRANSACTION_READ:
> +               result =3D read_command(aux_engine, request, mot_used);
> +       break;
> +       case I2CAUX_TRANSACTION_WRITE:
> +               result =3D write_command(aux_engine, request, mot_used);
> +       break;
> +       default:
> +               result =3D false;
> +       }
> +
> +       /* [tcheng]
> +        * need to send stop for the last transaction to free up the AUX
> +        * if the above command fails, this would be the last transaction
> +        */
> +
> +       if (!middle_of_transaction || !result)
> +               end_of_transaction_command(aux_engine, request);
> +
> +       /* mask AUX interrupt */
> +
> +       return result;
> +}
> +enum i2caux_engine_type get_engine_type(
> +               const struct engine *engine)
> +{
> +       return I2CAUX_ENGINE_TYPE_AUX;
> +}
> +
> +static struct aux_engine *acquire(
> +       struct engine *engine,
> +       struct ddc *ddc)
> +{
> +       struct aux_engine *aux_engine =3D FROM_AUX_ENGINE_ENGINE(engine);
> +       enum gpio_result result;
> +
> +       if (aux_engine->funcs->is_engine_available) {
> +               /*check whether SW could use the engine*/
> +               if (!aux_engine->funcs->is_engine_available(aux_engine))
> +                       return NULL;
> +       }
> +
> +       result =3D dal_ddc_open(ddc, GPIO_MODE_HARDWARE,
> +               GPIO_DDC_CONFIG_TYPE_MODE_AUX);
> +
> +       if (result !=3D GPIO_RESULT_OK)
> +               return NULL;
> +
> +       if (!aux_engine->funcs->acquire_engine(aux_engine)) {
> +               dal_ddc_close(ddc);
> +               return NULL;
> +       }
> +
> +       engine->ddc =3D ddc;
> +
> +       return aux_engine;
> +}
> +
> +static const struct aux_engine_funcs aux_engine_funcs =3D {
> +       .acquire_engine =3D acquire_engine,
> +       .submit_channel_request =3D submit_channel_request,
> +       .process_channel_reply =3D process_channel_reply,
> +       .read_channel_reply =3D read_channel_reply,
> +       .get_channel_status =3D get_channel_status,
> +       .is_engine_available =3D is_engine_available,
> +};
> +
> +static const struct engine_funcs engine_funcs =3D {
> +       .release_engine =3D release_engine,
> +       .destroy_engine =3D dce110_engine_destroy,
> +       .submit_request =3D submit_request,
> +       .get_engine_type =3D get_engine_type,
> +       .acquire =3D acquire,
> +};
> +
> +void dce110_engine_destroy(struct engine **engine)
> +{
> +
> +       struct aux_engine_dce110 *engine110 =3D FROM_ENGINE(*engine);
> +
> +       kfree(engine110);
> +       *engine =3D NULL;
> +
> +}
> +struct aux_engine *dce110_aux_engine_construct(struct aux_engine_dce110 =
*aux_engine110,
> +               struct dc_context *ctx,
> +               uint32_t inst,
> +               uint32_t timeout_period,
> +               const struct dce110_aux_registers *regs)
> +{
> +       aux_engine110->base.base.ddc =3D NULL;
> +       aux_engine110->base.base.ctx =3D ctx;
> +       aux_engine110->base.delay =3D 0;
> +       aux_engine110->base.max_defer_write_retry =3D 0;
> +       aux_engine110->base.base.funcs =3D &engine_funcs;
> +       aux_engine110->base.funcs =3D &aux_engine_funcs;
> +       aux_engine110->base.base.inst =3D inst;
> +       aux_engine110->timeout_period =3D timeout_period;
> +       aux_engine110->regs =3D regs;
> +
> +       return &aux_engine110->base;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_aux.h
> new file mode 100644
> index 0000000..c6b2aec
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> @@ -0,0 +1,111 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DAL_AUX_ENGINE_DCE110_H__
> +#define __DAL_AUX_ENGINE_DCE110_H__
> +#include "aux_engine.h"
> +
> +#define AUX_COMMON_REG_LIST(id)\
> +       SRI(AUX_CONTROL, DP_AUX, id), \
> +       SRI(AUX_ARB_CONTROL, DP_AUX, id), \
> +       SRI(AUX_SW_DATA, DP_AUX, id), \
> +       SRI(AUX_SW_CONTROL, DP_AUX, id), \
> +       SRI(AUX_INTERRUPT_CONTROL, DP_AUX, id), \
> +       SRI(AUX_SW_STATUS, DP_AUX, id), \
> +       SR(AUXN_IMPCAL), \
> +       SR(AUXP_IMPCAL)
> +
> +struct dce110_aux_registers {
> +       uint32_t AUX_CONTROL;
> +       uint32_t AUX_ARB_CONTROL;
> +       uint32_t AUX_SW_DATA;
> +       uint32_t AUX_SW_CONTROL;
> +       uint32_t AUX_INTERRUPT_CONTROL;
> +       uint32_t AUX_SW_STATUS;
> +       uint32_t AUXN_IMPCAL;
> +       uint32_t AUXP_IMPCAL;
> +
> +       uint32_t AUX_RESET_MASK;
> +};
> +
> +enum { /* This is the timeout as defined in DP 1.2a,
> +        * 2.3.4 "Detailed uPacket TX AUX CH State Description".
> +        */
> +       AUX_TIMEOUT_PERIOD =3D 400,
> +
> +       /* Ideally, the SW timeout should be just above 550usec
> +        * which is programmed in HW.
> +        * But the SW timeout of 600usec is not reliable,
> +        * because on some systems, delay_in_microseconds()
> +        * returns faster than it should.
> +        * EPR #379763: by trial-and-error on different systems,
> +        * 700usec is the minimum reliable SW timeout for polling
> +        * the AUX_SW_STATUS.AUX_SW_DONE bit.
> +        * This timeout expires *only* when there is
> +        * AUX Error or AUX Timeout conditions - not during normal operat=
ion.
> +        * During normal operation, AUX_SW_STATUS.AUX_SW_DONE bit is set
> +        * at most within ~240usec. That means,
> +        * increasing this timeout will not affect normal operation,
> +        * and we'll timeout after
> +        * SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD =3D 1600=
usec.
> +        * This timeout is especially important for
> +        * resume from S3 and CTS.
> +        */
> +       SW_AUX_TIMEOUT_PERIOD_MULTIPLIER =3D 4
> +};
> +struct aux_engine_dce110 {
> +       struct aux_engine base;
> +       const struct dce110_aux_registers *regs;
> +       struct {
> +               uint32_t aux_control;
> +               uint32_t aux_arb_control;
> +               uint32_t aux_sw_data;
> +               uint32_t aux_sw_control;
> +               uint32_t aux_interrupt_control;
> +               uint32_t aux_sw_status;
> +       } addr;
> +       uint32_t timeout_period;
> +};
> +
> +struct aux_engine_dce110_init_data {
> +       uint32_t engine_id;
> +       uint32_t timeout_period;
> +       struct dc_context *ctx;
> +       const struct dce110_aux_registers *regs;
> +};
> +
> +struct aux_engine *dce110_aux_engine_construct(
> +               struct aux_engine_dce110 *aux_engine110,
> +               struct dc_context *ctx,
> +               uint32_t inst,
> +               uint32_t timeout_period,
> +               const struct dce110_aux_registers *regs);
> +
> +void dce110_engine_destroy(struct engine **engine);
> +
> +bool dce110_aux_engine_acquire(
> +       struct engine *aux_engine,
> +       struct ddc *ddc);
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> index ad8ad4e..c34c953 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> @@ -52,6 +52,7 @@
>  #include "dce/dce_10_0_sh_mask.h"
>
>  #include "dce/dce_dmcu.h"
> +#include "dce/dce_aux.h"
>  #include "dce/dce_abm.h"
>
>  #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT
> @@ -279,7 +280,20 @@ static const struct dce_opp_shift opp_shift =3D {
>  static const struct dce_opp_mask opp_mask =3D {
>         OPP_COMMON_MASK_SH_LIST_DCE_100(_MASK)
>  };
> +#define aux_engine_regs(id)\
> +[id] =3D {\
> +       AUX_COMMON_REG_LIST(id), \
> +       .AUX_RESET_MASK =3D 0 \
> +}
>
> +static const struct dce110_aux_registers aux_engine_regs[] =3D {
> +               aux_engine_regs(0),
> +               aux_engine_regs(1),
> +               aux_engine_regs(2),
> +               aux_engine_regs(3),
> +               aux_engine_regs(4),
> +               aux_engine_regs(5)
> +};
>
>  #define audio_regs(id)\
>  [id] =3D {\
> @@ -572,6 +586,23 @@ struct output_pixel_processor *dce100_opp_create(
>         return &opp->base;
>  }
>
> +struct engine *dce100_aux_engine_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct aux_engine_dce110 *aux_engine =3D
> +               kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
> +
> +       if (!aux_engine)
> +               return NULL;
> +
> +       dce110_aux_engine_construct(aux_engine, ctx, inst,
> +                                   SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AU=
X_TIMEOUT_PERIOD,
> +                                   &aux_engine_regs[inst]);
> +
> +       return &aux_engine->base.base;
> +}
> +
>  struct clock_source *dce100_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
> @@ -624,6 +655,10 @@ static void destruct(struct dce110_resource_pool *po=
ol)
>                         kfree(DCE110TG_FROM_TG(pool->base.timing_generato=
rs[i]));
>                         pool->base.timing_generators[i] =3D NULL;
>                 }
> +
> +               if (pool->base.engines[i] !=3D NULL)
> +                       dce110_engine_destroy(&pool->base.engines[i]);
> +
>         }
>
>         for (i =3D 0; i < pool->base.stream_enc_count; i++) {
> @@ -928,6 +963,13 @@ static bool construct(
>                                 "DC: failed to create output pixel proces=
sor!\n");
>                         goto res_create_fail;
>                 }
> +               pool->base.engines[i] =3D dce100_aux_engine_create(ctx, i=
);
> +               if (pool->base.engines[i] =3D=3D NULL) {
> +                       BREAK_TO_DEBUGGER();
> +                       dm_error(
> +                               "DC:failed to create aux engine!!\n");
> +                       goto res_create_fail;
> +               }
>         }
>
>         dc->caps.max_planes =3D  pool->base.pipe_count;
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index 1c902e4..4a665a2 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -49,6 +49,7 @@
>  #include "dce/dce_clock_source.h"
>  #include "dce/dce_hwseq.h"
>  #include "dce110/dce110_hw_sequencer.h"
> +#include "dce/dce_aux.h"
>  #include "dce/dce_abm.h"
>  #include "dce/dce_dmcu.h"
>
> @@ -306,6 +307,21 @@ static const struct dce_opp_mask opp_mask =3D {
>         OPP_COMMON_MASK_SH_LIST_DCE_110(_MASK)
>  };
>
> +#define aux_engine_regs(id)\
> +[id] =3D {\
> +       AUX_COMMON_REG_LIST(id), \
> +       .AUX_RESET_MASK =3D 0 \
> +}
> +
> +static const struct dce110_aux_registers aux_engine_regs[] =3D {
> +               aux_engine_regs(0),
> +               aux_engine_regs(1),
> +               aux_engine_regs(2),
> +               aux_engine_regs(3),
> +               aux_engine_regs(4),
> +               aux_engine_regs(5)
> +};
> +
>  #define audio_regs(id)\
>  [id] =3D {\
>         AUD_COMMON_REG_LIST(id)\
> @@ -588,6 +604,23 @@ static struct output_pixel_processor *dce110_opp_cre=
ate(
>         return &opp->base;
>  }
>
> +struct engine *dce110_aux_engine_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct aux_engine_dce110 *aux_engine =3D
> +               kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
> +
> +       if (!aux_engine)
> +               return NULL;
> +
> +       dce110_aux_engine_construct(aux_engine, ctx, inst,
> +                                   SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AU=
X_TIMEOUT_PERIOD,
> +                                   &aux_engine_regs[inst]);
> +
> +       return &aux_engine->base.base;
> +}
> +
>  struct clock_source *dce110_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
> @@ -651,6 +684,10 @@ static void destruct(struct dce110_resource_pool *po=
ol)
>                         kfree(DCE110TG_FROM_TG(pool->base.timing_generato=
rs[i]));
>                         pool->base.timing_generators[i] =3D NULL;
>                 }
> +
> +               if (pool->base.engines[i] !=3D NULL)
> +                       dce110_engine_destroy(&pool->base.engines[i]);
> +
>         }
>
>         for (i =3D 0; i < pool->base.stream_enc_count; i++) {
> @@ -1258,6 +1295,14 @@ static bool construct(
>                                 "DC: failed to create output pixel proces=
sor!\n");
>                         goto res_create_fail;
>                 }
> +
> +               pool->base.engines[i] =3D dce110_aux_engine_create(ctx, i=
);
> +               if (pool->base.engines[i] =3D=3D NULL) {
> +                       BREAK_TO_DEBUGGER();
> +                       dm_error(
> +                               "DC:failed to create aux engine!!\n");
> +                       goto res_create_fail;
> +               }
>         }
>
>         dc->fbc_compressor =3D dce110_compressor_create(ctx);
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index 30d5b32..caf90ae 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -49,6 +49,7 @@
>  #include "dce112/dce112_hw_sequencer.h"
>  #include "dce/dce_abm.h"
>  #include "dce/dce_dmcu.h"
> +#include "dce/dce_aux.h"
>
>  #include "reg_helper.h"
>
> @@ -314,6 +315,21 @@ static const struct dce_opp_mask opp_mask =3D {
>         OPP_COMMON_MASK_SH_LIST_DCE_112(_MASK)
>  };
>
> +#define aux_engine_regs(id)\
> +[id] =3D {\
> +       AUX_COMMON_REG_LIST(id), \
> +       .AUX_RESET_MASK =3D 0 \
> +}
> +
> +static const struct dce110_aux_registers aux_engine_regs[] =3D {
> +               aux_engine_regs(0),
> +               aux_engine_regs(1),
> +               aux_engine_regs(2),
> +               aux_engine_regs(3),
> +               aux_engine_regs(4),
> +               aux_engine_regs(5)
> +};
> +
>  #define audio_regs(id)\
>  [id] =3D {\
>         AUD_COMMON_REG_LIST(id)\
> @@ -588,6 +604,23 @@ struct output_pixel_processor *dce112_opp_create(
>         return &opp->base;
>  }
>
> +struct engine *dce112_aux_engine_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct aux_engine_dce110 *aux_engine =3D
> +               kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
> +
> +       if (!aux_engine)
> +               return NULL;
> +
> +       dce110_aux_engine_construct(aux_engine, ctx, inst,
> +                                   SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AU=
X_TIMEOUT_PERIOD,
> +                                   &aux_engine_regs[inst]);
> +
> +       return &aux_engine->base.base;
> +}
> +
>  struct clock_source *dce112_clock_source_create(
>         struct dc_context *ctx,
>         struct dc_bios *bios,
> @@ -625,6 +658,9 @@ static void destruct(struct dce110_resource_pool *poo=
l)
>                 if (pool->base.opps[i] !=3D NULL)
>                         dce110_opp_destroy(&pool->base.opps[i]);
>
> +               if (pool->base.engines[i] !=3D NULL)
> +                       dce110_engine_destroy(&pool->base.engines[i]);
> +
>                 if (pool->base.transforms[i] !=3D NULL)
>                         dce112_transform_destroy(&pool->base.transforms[i=
]);
>
> @@ -640,6 +676,10 @@ static void destruct(struct dce110_resource_pool *po=
ol)
>                         kfree(DCE110TG_FROM_TG(pool->base.timing_generato=
rs[i]));
>                         pool->base.timing_generators[i] =3D NULL;
>                 }
> +
> +               if (pool->base.engines[i] !=3D NULL)
> +                       dce110_engine_destroy(&pool->base.engines[i]);
> +
>         }
>
>         for (i =3D 0; i < pool->base.stream_enc_count; i++) {
> @@ -1208,6 +1248,13 @@ static bool construct(
>                                 "DC:failed to create output pixel process=
or!\n");
>                         goto res_create_fail;
>                 }
> +               pool->base.engines[i] =3D dce112_aux_engine_create(ctx, i=
);
> +               if (pool->base.engines[i] =3D=3D NULL) {
> +                       BREAK_TO_DEBUGGER();
> +                       dm_error(
> +                               "DC:failed to create aux engine!!\n");
> +                       goto res_create_fail;
> +               }
>         }
>
>         if (!resource_construct(num_virtual_links, dc, &pool->base,
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 8381f27..e389832 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> @@ -53,6 +53,7 @@
>  #include "dce/dce_hwseq.h"
>  #include "dce/dce_abm.h"
>  #include "dce/dce_dmcu.h"
> +#include "dce/dce_aux.h"
>
>  #include "dce/dce_12_0_offset.h"
>  #include "dce/dce_12_0_sh_mask.h"
> @@ -297,6 +298,20 @@ static const struct dce_opp_shift opp_shift =3D {
>  static const struct dce_opp_mask opp_mask =3D {
>         OPP_COMMON_MASK_SH_LIST_DCE_120(_MASK)
>  };
> + #define aux_engine_regs(id)\
> +[id] =3D {\
> +       AUX_COMMON_REG_LIST(id), \
> +       .AUX_RESET_MASK =3D 0 \
> +}
> +
> +static const struct dce110_aux_registers aux_engine_regs[] =3D {
> +               aux_engine_regs(0),
> +               aux_engine_regs(1),
> +               aux_engine_regs(2),
> +               aux_engine_regs(3),
> +               aux_engine_regs(4),
> +               aux_engine_regs(5)
> +};
>
>  #define audio_regs(id)\
>  [id] =3D {\
> @@ -361,6 +376,22 @@ struct output_pixel_processor *dce120_opp_create(
>                              ctx, inst, &opp_regs[inst], &opp_shift, &opp=
_mask);
>         return &opp->base;
>  }
> +struct engine *dce120_aux_engine_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct aux_engine_dce110 *aux_engine =3D
> +               kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
> +
> +       if (!aux_engine)
> +               return NULL;
> +
> +       dce110_aux_engine_construct(aux_engine, ctx, inst,
> +                                   SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AU=
X_TIMEOUT_PERIOD,
> +                                   &aux_engine_regs[inst]);
> +
> +       return &aux_engine->base.base;
> +}
>
>  static const struct bios_registers bios_regs =3D {
>         .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6 + NBIO_BASE(mmBIOS_SCRATCH_6=
_BASE_IDX)
> @@ -467,6 +498,10 @@ static void destruct(struct dce110_resource_pool *po=
ol)
>                         kfree(DCE110TG_FROM_TG(pool->base.timing_generato=
rs[i]));
>                         pool->base.timing_generators[i] =3D NULL;
>                 }
> +
> +               if (pool->base.engines[i] !=3D NULL)
> +                       dce110_engine_destroy(&pool->base.engines[i]);
> +
>         }
>
>         for (i =3D 0; i < pool->base.audio_count; i++) {
> @@ -984,6 +1019,13 @@ static bool construct(
>                         dm_error(
>                                 "DC: failed to create output pixel proces=
sor!\n");
>                 }
> +               pool->base.engines[i] =3D dce120_aux_engine_create(ctx, i=
);
> +                               if (pool->base.engines[i] =3D=3D NULL) {
> +                                       BREAK_TO_DEBUGGER();
> +                                       dm_error(
> +                                               "DC:failed to create aux =
engine!!\n");
> +                                       goto res_create_fail;
> +                               }
>
>                 /* check next valid pipe */
>                 j++;
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index 2ac95ec..6fb33ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -54,6 +54,7 @@
>  #include "reg_helper.h"
>
>  #include "dce/dce_dmcu.h"
> +#include "dce/dce_aux.h"
>  #include "dce/dce_abm.h"
>  /* TODO remove this include */
>
> @@ -298,6 +299,21 @@ static const struct dce_opp_mask opp_mask =3D {
>         OPP_COMMON_MASK_SH_LIST_DCE_80(_MASK)
>  };
>
> +#define aux_engine_regs(id)\
> +[id] =3D {\
> +       AUX_COMMON_REG_LIST(id), \
> +       .AUX_RESET_MASK =3D 0 \
> +}
> +
> +static const struct dce110_aux_registers aux_engine_regs[] =3D {
> +               aux_engine_regs(0),
> +               aux_engine_regs(1),
> +               aux_engine_regs(2),
> +               aux_engine_regs(3),
> +               aux_engine_regs(4),
> +               aux_engine_regs(5)
> +};
> +
>  #define audio_regs(id)\
>  [id] =3D {\
>         AUD_COMMON_REG_LIST(id)\
> @@ -448,6 +464,23 @@ static struct output_pixel_processor *dce80_opp_crea=
te(
>         return &opp->base;
>  }
>
> +struct engine *dce80_aux_engine_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct aux_engine_dce110 *aux_engine =3D
> +               kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
> +
> +       if (!aux_engine)
> +               return NULL;
> +
> +       dce110_aux_engine_construct(aux_engine, ctx, inst,
> +                                   SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AU=
X_TIMEOUT_PERIOD,
> +                                   &aux_engine_regs[inst]);
> +
> +       return &aux_engine->base.base;
> +}
> +
>  static struct stream_encoder *dce80_stream_encoder_create(
>         enum engine_id eng_id,
>         struct dc_context *ctx)
> @@ -655,6 +688,9 @@ static void destruct(struct dce110_resource_pool *poo=
l)
>                         kfree(DCE110TG_FROM_TG(pool->base.timing_generato=
rs[i]));
>                         pool->base.timing_generators[i] =3D NULL;
>                 }
> +
> +               if (pool->base.engines[i] !=3D NULL)
> +                       dce110_engine_destroy(&pool->base.engines[i]);
>         }
>
>         for (i =3D 0; i < pool->base.stream_enc_count; i++) {
> @@ -899,6 +935,14 @@ static bool dce80_construct(
>                         dm_error("DC: failed to create output pixel proce=
ssor!\n");
>                         goto res_create_fail;
>                 }
> +
> +               pool->base.engines[i] =3D dce80_aux_engine_create(ctx, i)=
;
> +               if (pool->base.engines[i] =3D=3D NULL) {
> +                       BREAK_TO_DEBUGGER();
> +                       dm_error(
> +                               "DC:failed to create aux engine!!\n");
> +                       goto res_create_fail;
> +               }
>         }
>
>         dc->caps.max_planes =3D  pool->base.pipe_count;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index 84581b3..ef8bb27 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -64,6 +64,7 @@
>  #include "reg_helper.h"
>  #include "dce/dce_abm.h"
>  #include "dce/dce_dmcu.h"
> +#include "dce/dce_aux.h"
>
>  const struct _vcs_dpi_ip_params_st dcn1_0_ip =3D {
>         .rob_buffer_size_kbytes =3D 64,
> @@ -356,6 +357,21 @@ static const struct dcn10_opp_mask opp_mask =3D {
>                 OPP_MASK_SH_LIST_DCN10(_MASK),
>  };
>
> +#define aux_engine_regs(id)\
> +[id] =3D {\
> +       AUX_COMMON_REG_LIST(id), \
> +       .AUX_RESET_MASK =3D 0 \
> +}
> +
> +static const struct dce110_aux_registers aux_engine_regs[] =3D {
> +               aux_engine_regs(0),
> +               aux_engine_regs(1),
> +               aux_engine_regs(2),
> +               aux_engine_regs(3),
> +               aux_engine_regs(4),
> +               aux_engine_regs(5)
> +};
> +
>  #define tf_regs(id)\
>  [id] =3D {\
>         TF_REG_LIST_DCN10(id),\
> @@ -578,6 +594,23 @@ static struct output_pixel_processor *dcn10_opp_crea=
te(
>         return &opp->base;
>  }
>
> +struct engine *dcn10_aux_engine_create(
> +       struct dc_context *ctx,
> +       uint32_t inst)
> +{
> +       struct aux_engine_dce110 *aux_engine =3D
> +               kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);
> +
> +       if (!aux_engine)
> +               return NULL;
> +
> +       dce110_aux_engine_construct(aux_engine, ctx, inst,
> +                                   SW_AUX_TIMEOUT_PERIOD_MULTIPLIER * AU=
X_TIMEOUT_PERIOD,
> +                                   &aux_engine_regs[inst]);
> +
> +       return &aux_engine->base.base;
> +}
> +
>  static struct mpc *dcn10_mpc_create(struct dc_context *ctx)
>  {
>         struct dcn10_mpc *mpc10 =3D kzalloc(sizeof(struct dcn10_mpc),
> @@ -826,6 +859,9 @@ static void destruct(struct dcn10_resource_pool *pool=
)
>                         kfree(DCN10TG_FROM_TG(pool->base.timing_generator=
s[i]));
>                         pool->base.timing_generators[i] =3D NULL;
>                 }
> +
> +               if (pool->base.engines[i] !=3D NULL)
> +                       pool->base.engines[i]->funcs->destroy_engine(&poo=
l->base.engines[i]);
>         }
>
>         for (i =3D 0; i < pool->base.stream_enc_count; i++)
> @@ -1255,6 +1291,14 @@ static bool construct(
>                         goto fail;
>                 }
>
> +               pool->base.engines[i] =3D dcn10_aux_engine_create(ctx, i)=
;
> +               if (pool->base.engines[i] =3D=3D NULL) {
> +                       BREAK_TO_DEBUGGER();
> +                       dm_error(
> +                               "DC:failed to create aux engine!!\n");
> +                       goto fail;
> +               }
> +
>                 /* check next valid pipe */
>                 j++;
>         }
> diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/engine.h b/drivers/gpu=
/drm/amd/display/dc/i2caux/engine.h
> index 1e8a158..b16fb1f 100644
> --- a/drivers/gpu/drm/amd/display/dc/i2caux/engine.h
> +++ b/drivers/gpu/drm/amd/display/dc/i2caux/engine.h
> @@ -96,6 +96,7 @@ struct engine_funcs {
>
>  struct engine {
>         const struct engine_funcs *funcs;
> +       uint32_t inst;
>         struct ddc *ddc;
>         struct dc_context *ctx;
>  };
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gp=
u/drm/amd/display/dc/inc/core_types.h
> index 1db26bc..2d0d4ae 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
> @@ -138,7 +138,7 @@ struct resource_pool {
>         struct output_pixel_processor *opps[MAX_PIPES];
>         struct timing_generator *timing_generators[MAX_PIPES];
>         struct stream_encoder *stream_enc[MAX_PIPES * 2];
> -
> +       struct engine *engines[MAX_PIPES];
>         struct hubbub *hubbub;
>         struct mpc *mpc;
>         struct pp_smu_funcs_rv *pp_smu;
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h b/drivers=
/gpu/drm/amd/display/dc/inc/hw/aux_engine.h
> new file mode 100644
> index 0000000..06d7e5d
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h
> @@ -0,0 +1,113 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DAL_AUX_ENGINE_H__
> +#define __DAL_AUX_ENGINE_H__
> +
> +#include "engine.h"
> +#include "include/i2caux_interface.h"
> +
> +struct aux_engine;
> +union aux_config;
> +struct aux_engine_funcs {
> +       void (*destroy)(
> +               struct aux_engine **ptr);
> +       bool (*acquire_engine)(
> +               struct aux_engine *engine);
> +       void (*configure)(
> +               struct aux_engine *engine,
> +               union aux_config cfg);
> +       void (*submit_channel_request)(
> +               struct aux_engine *engine,
> +               struct aux_request_transaction_data *request);
> +       void (*process_channel_reply)(
> +               struct aux_engine *engine,
> +               struct aux_reply_transaction_data *reply);
> +       int (*read_channel_reply)(
> +               struct aux_engine *engine,
> +               uint32_t size,
> +               uint8_t *buffer,
> +               uint8_t *reply_result,
> +               uint32_t *sw_status);
> +       enum aux_channel_operation_result (*get_channel_status)(
> +               struct aux_engine *engine,
> +               uint8_t *returned_bytes);
> +       bool (*is_engine_available)(struct aux_engine *engine);
> +};
> +struct engine;
> +struct aux_engine {
> +       struct engine base;
> +       const struct aux_engine_funcs *funcs;
> +       /* following values are expressed in milliseconds */
> +       uint32_t delay;
> +       uint32_t max_defer_write_retry;
> +
> +       bool acquire_reset;
> +};
> +struct read_command_context {
> +       uint8_t *buffer;
> +       uint32_t current_read_length;
> +       uint32_t offset;
> +       enum i2caux_transaction_status status;
> +
> +       struct aux_request_transaction_data request;
> +       struct aux_reply_transaction_data reply;
> +
> +       uint8_t returned_byte;
> +
> +       uint32_t timed_out_retry_aux;
> +       uint32_t invalid_reply_retry_aux;
> +       uint32_t defer_retry_aux;
> +       uint32_t defer_retry_i2c;
> +       uint32_t invalid_reply_retry_aux_on_ack;
> +
> +       bool transaction_complete;
> +       bool operation_succeeded;
> +};
> +struct write_command_context {
> +       bool mot;
> +
> +       uint8_t *buffer;
> +       uint32_t current_write_length;
> +       enum i2caux_transaction_status status;
> +
> +       struct aux_request_transaction_data request;
> +       struct aux_reply_transaction_data reply;
> +
> +       uint8_t returned_byte;
> +
> +       uint32_t timed_out_retry_aux;
> +       uint32_t invalid_reply_retry_aux;
> +       uint32_t defer_retry_aux;
> +       uint32_t defer_retry_i2c;
> +       uint32_t max_defer_retry;
> +       uint32_t ack_m_retry;
> +
> +       uint8_t reply_data[DEFAULT_AUX_MAX_DATA_SIZE];
> +
> +       bool transaction_complete;
> +       bool operation_succeeded;
> +};
> +#endif
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/engine.h b/drivers/gpu=
/drm/amd/display/dc/inc/hw/engine.h
> new file mode 100644
> index 0000000..1f5476f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/engine.h
> @@ -0,0 +1,106 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __DAL_ENGINE_H__
> +#define __DAL_ENGINE_H__
> +
> +#include "dc_ddc_types.h"
> +
> +enum i2caux_transaction_operation {
> +       I2CAUX_TRANSACTION_READ,
> +       I2CAUX_TRANSACTION_WRITE
> +};
> +
> +enum i2caux_transaction_address_space {
> +       I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C =3D 1,
> +       I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD
> +};
> +
> +struct i2caux_transaction_payload {
> +       enum i2caux_transaction_address_space address_space;
> +       uint32_t address;
> +       uint32_t length;
> +       uint8_t *data;
> +};
> +
> +enum i2caux_transaction_status {
> +       I2CAUX_TRANSACTION_STATUS_UNKNOWN =3D (-1L),
> +       I2CAUX_TRANSACTION_STATUS_SUCCEEDED,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_CHANNEL_BUSY,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_PROTOCOL_ERROR,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_NACK,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_INCOMPLETE,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_OPERATION,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_INVALID_OPERATION,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_BUFFER_OVERFLOW,
> +       I2CAUX_TRANSACTION_STATUS_FAILED_HPD_DISCON
> +};
> +
> +struct i2caux_transaction_request {
> +       enum i2caux_transaction_operation operation;
> +       struct i2caux_transaction_payload payload;
> +       enum i2caux_transaction_status status;
> +};
> +
> +enum i2caux_engine_type {
> +       I2CAUX_ENGINE_TYPE_UNKNOWN =3D (-1L),
> +       I2CAUX_ENGINE_TYPE_AUX,
> +       I2CAUX_ENGINE_TYPE_I2C_DDC_HW,
> +       I2CAUX_ENGINE_TYPE_I2C_GENERIC_HW,
> +       I2CAUX_ENGINE_TYPE_I2C_SW
> +};
> +
> +enum i2c_default_speed {
> +       I2CAUX_DEFAULT_I2C_HW_SPEED =3D 50,
> +       I2CAUX_DEFAULT_I2C_SW_SPEED =3D 50
> +};
> +
> +struct engine;
> +
> +struct engine_funcs {
> +       enum i2caux_engine_type (*get_engine_type)(
> +               const struct engine *engine);
> +       struct aux_engine* (*acquire)(
> +               struct engine *engine,
> +               struct ddc *ddc);
> +       bool (*submit_request)(
> +               struct engine *engine,
> +               struct i2caux_transaction_request *request,
> +               bool middle_of_transaction);
> +       void (*release_engine)(
> +               struct engine *engine);
> +       void (*destroy_engine)(
> +               struct engine **engine);
> +};
> +
> +struct engine {
> +       const struct engine_funcs *funcs;
> +       uint32_t inst;
> +       struct ddc *ddc;
> +       struct dc_context *ctx;
> +};
> +
> +#endif
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MW2PR12MB258871F6CE41BD2726C6D1C0F95C0MW2PR12MB2588namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span>In this patch, i2c is still=
 using the old code path (nothing is changed for i2c). For aux, locking is =
already done in drm (i2c also uses drm locks).</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><span><span>T<span>he new c=
ode for aux&nbsp;is same as the old one. Only difference is that some i2c c=
ode is removed from aux and aux is put in a different location to match our=
 other HW resources. As for the logic/behavior,
 it is exactly the same as before.</span></span></span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span><br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>Bhawan<br>
</span></p>
<p style=3D"margin-top:0;margin-bottom:0"><span>&nbsp; </span><br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> July 17, 2018 12:07:30 PM<br>
<b>To:</b> Li, Sun peng (Leo)<br>
<b>Cc:</b> amd-gfx list; Lakha, Bhawanpreet<br>
<b>Subject:</b> Re: [PATCH 5/7] drm/amd/display: Decouple aux from i2c</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Tue, Jul 17, 2018 at 9:29 AM,&nbsp; &lt;sunpeng=
.li-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; From: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; [Why]<br>
&gt; Aux engine is created from i2caux layer. We want to remove this layer<=
br>
&gt; and use the engine directly.<br>
&gt;<br>
&gt; [How]<br>
&gt; Decouple aux engine from i2caux. Move aux engine related code to dce f=
older and use<br>
&gt; dc resource pool to manage the engine. And use the engine functions di=
rectly<br>
&gt;<br>
<br>
Don't i2c and aux share the same physical pins?&nbsp; If so, do you have<br=
>
appropriate locking to arbitrate access to the pins from either<br>
engine?<br>
<br>
Alex<br>
<br>
<br>
&gt; Change-Id: Iecb609fe815dab31ed6b6100916c4b49ed6539a0<br>
&gt; Signed-off-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Reviewed-by: Harry Wentland &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Acked-by: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c&nbsp; |&nbsp; =
22 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dce/Makefile&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dce/dce_aux.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 942 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dce/dce_aux.h&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; | 111 &#43;&#43;&#43;<br>
&gt;&nbsp; .../drm/amd/display/dc/dce100/dce100_resource.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 42 &#43;<br>
&gt;&nbsp; .../drm/amd/display/dc/dce110/dce110_resource.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 45 &#43;<br>
&gt;&nbsp; .../drm/amd/display/dc/dce112/dce112_resource.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 47 &#43;<br>
&gt;&nbsp; .../drm/amd/display/dc/dce120/dce120_resource.c&nbsp;&nbsp;&nbsp=
; |&nbsp; 42 &#43;<br>
&gt;&nbsp; .../gpu/drm/amd/display/dc/dce80/dce80_resource.c&nbsp; |&nbsp; =
44 &#43;<br>
&gt;&nbsp; .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c&nbsp; |&nbsp; =
44 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/i2caux/engine.h&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp;&nbsp; 1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/inc/core_types.h&nbsp;&nbsp;&nbsp=
; |&nbsp;&nbsp; 2 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h | 113 &#43;&#=
43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/inc/hw/engine.h&nbsp;&nbsp;&nbsp;=
&nbsp; | 106 &#43;&#43;&#43;<br>
&gt;&nbsp; 14 files changed, 1549 insertions(&#43;), 14 deletions(-)<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c<=
br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h<=
br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/aux_eng=
ine.h<br>
&gt;&nbsp; create mode 100644 drivers/gpu/drm/amd/display/dc/inc/hw/engine.=
h<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drive=
rs/gpu/drm/amd/display/dc/core/dc_link_ddc.c<br>
&gt; index 08c9d73..4019fe07 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c<br=
>
&gt; @@ -33,10 &#43;33,8 @@<br>
&gt;&nbsp; #include &quot;include/vector.h&quot;<br>
&gt;&nbsp; #include &quot;core_types.h&quot;<br>
&gt;&nbsp; #include &quot;dc_link_ddc.h&quot;<br>
&gt; -#include &quot;i2caux/engine.h&quot;<br>
&gt; -#include &quot;i2caux/i2c_engine.h&quot;<br>
&gt; -#include &quot;i2caux/aux_engine.h&quot;<br>
&gt; -#include &quot;i2caux/i2caux.h&quot;<br>
&gt; &#43;#include &quot;engine.h&quot;<br>
&gt; &#43;#include &quot;aux_engine.h&quot;<br>
&gt;<br>
&gt;&nbsp; #define AUX_POWER_UP_WA_DELAY 500<br>
&gt;&nbsp; #define I2C_OVER_AUX_DEFER_WA_DELAY 70<br>
&gt; @@ -641,9 &#43;639,9 @@ int dc_link_aux_transfer(struct ddc_service *d=
dc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aux_transaction_type type,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; enum i2caux_transaction_action action)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux *i2caux =3D ddc-&g=
t;ctx-&gt;i2caux;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc_pin =
=3D ddc-&gt;ddc_pin;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engine;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *aux_engin=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aux_channel_opera=
tion_result operation_result;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_request_tra=
nsaction_data aux_req;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_reply_trans=
action_data aux_rep;<br>
&gt; @@ -654,7 &#43;652,8 @@ int dc_link_aux_transfer(struct ddc_service *d=
dc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;aux_req, 0=
, sizeof(aux_req));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;aux_rep, 0=
, sizeof(aux_rep));<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine =3D i2caux-&gt;funcs-&gt;=
acquire_aux_engine(i2caux, ddc_pin);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine =3D ddc-&gt;ctx-&gt;d=
c-&gt;res_pool-&gt;engines[ddc_pin-&gt;pin_data-&gt;en];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine =3D engine-&gt;fu=
ncs-&gt;acquire(engine, ddc_pin);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_req.type =3D type;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_req.action =3D act=
ion;<br>
&gt; @@ -664,15 &#43;663,15 @@ int dc_link_aux_transfer(struct ddc_service =
*ddc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_req.length =3D siz=
e;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_req.data =3D buffe=
r;<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;submit_chan=
nel_request(engine, &amp;aux_req);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_result =3D engine-&gt;=
funcs-&gt;get_channel_status(engine, &amp;returned_bytes);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine-&gt;funcs-&gt;sub=
mit_channel_request(aux_engine, &amp;aux_req);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_result =3D aux_eng=
ine-&gt;funcs-&gt;get_channel_status(aux_engine, &amp;returned_bytes);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (operation_resu=
lt) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERA=
TION_SUCCEEDED:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; res =3D returned_bytes;<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (res &lt;=3D size &amp;&amp; res &gt;=3D 0)<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D eng=
ine-&gt;funcs-&gt;read_channel_reply(engine, size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D=
 aux_engine-&gt;funcs-&gt;read_channel_reply(aux_engine, size,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; buffer, reply,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &amp;status);<br>
&gt;<br>
&gt; @@ -686,8 &#43;685,7 @@ int dc_link_aux_transfer(struct ddc_service *d=
dc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; res =3D -1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i2caux-&gt;funcs-&gt;release_eng=
ine(i2caux, &amp;engine-&gt;base);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine-&gt;base.funcs-&g=
t;release_engine(&amp;aux_engine-&gt;base);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu=
/drm/amd/display/dc/dce/Makefile<br>
&gt; index 11401fd..825537b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce/Makefile<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/Makefile<br>
&gt; @@ -28,7 &#43;28,7 @@<br>
&gt;<br>
&gt;&nbsp; DCE =3D dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_=
hwseq.o \<br>
&gt;&nbsp; dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transfo=
rm.o \<br>
&gt; -dce_clocks.o dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o<br>
&gt; &#43;dce_clocks.o dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o<b=
r>
&gt;<br>
&gt;<br>
&gt;&nbsp; AMD_DAL_DCE =3D $(addprefix $(AMDDALPATH)/dc/dce/,$(DCE))<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gp=
u/drm/amd/display/dc/dce/dce_aux.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..b28e212<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c<br>
&gt; @@ -0,0 &#43;1,942 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; * Authors: AMD<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;dm_services.h&quot;<br>
&gt; &#43;#include &quot;dce_aux.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_11_0_sh_mask.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;#define CTX \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux110-&gt;base.base.ctx<br>
&gt; &#43;#define REG(reg_name)\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (aux110-&gt;regs-&gt;reg_nam=
e)<br>
&gt; &#43;<br>
&gt; &#43;#define DC_LOGGER \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;base.ctx-&gt;logg=
er<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;reg_helper.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;#define FROM_AUX_ENGINE(ptr) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of((ptr), struct a=
ux_engine_dce110, base)<br>
&gt; &#43;<br>
&gt; &#43;#define FROM_ENGINE(ptr) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FROM_AUX_ENGINE(container_of=
((ptr), struct aux_engine, base))<br>
&gt; &#43;<br>
&gt; &#43;#define FROM_AUX_ENGINE_ENGINE(ptr) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; container_of((ptr), struct a=
ux_engine, base)<br>
&gt; &#43;enum {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_INVALID_REPLY_RETRY_COUN=
TER =3D 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_TIMED_OUT_RETRY_COUNTER =
=3D 2,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_DEFER_RETRY_COUNTER =3D =
6<br>
&gt; &#43;};<br>
&gt; &#43;static void release_engine(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engine)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x110 =3D FROM_ENGINE(engine);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dal_ddc_close(engine-&gt;ddc=
);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;ddc =3D NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(AUX_ARB_CONTROL, =
AUX_SW_DONE_USING_AUX_REG, 1);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;#define SW_CAN_ACCESS_AUX 1<br>
&gt; &#43;#define DMCU_CAN_ACCESS_AUX 2<br>
&gt; &#43;<br>
&gt; &#43;static bool is_engine_available(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine)<b=
r>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x110 =3D FROM_AUX_ENGINE(engine);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D REG_READ(=
AUX_ARB_CONTROL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t field =3D get_reg_f=
ield_value(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_ARB=
_CONTROL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_REG=
_RW_CNTL_STATUS);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (field !=3D DMCU_CAN_=
ACCESS_AUX);<br>
&gt; &#43;}<br>
&gt; &#43;static bool acquire_engine(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine)<b=
r>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x110 =3D FROM_AUX_ENGINE(engine);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value =3D REG_READ(=
AUX_ARB_CONTROL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t field =3D get_reg_f=
ield_value(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_ARB=
_CONTROL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_REG=
_RW_CNTL_STATUS);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (field =3D=3D DMCU_CAN_AC=
CESS_AUX)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable AUX before request=
 SW to access AUX */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D REG_READ(AUX_CONTR=
OL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; field =3D get_reg_field_valu=
e(value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_CONTROL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_EN);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (field =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; set_reg_field_value(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_CONTROL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_EN);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (REG(AUX_RESET_MASK)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*DP_AU=
X block as part of the enable sequence*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_reg=
_field_value(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_CONTROL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_RESET);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; REG_WRITE(AUX_CONTROL, value);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (REG(AUX_RESET_MASK)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*poll =
HW to make sure reset it done*/<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WAI=
T(AUX_CONTROL, AUX_RESET_DONE, 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 1, 11);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_reg=
_field_value(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_CONTROL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_RESET);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WRI=
TE(AUX_CONTROL, value);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WAI=
T(AUX_CONTROL, AUX_RESET_DONE, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 1, 11);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } /*if (field)*/<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* request SW to access AUX =
*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(AUX_ARB_CONTROL, =
AUX_SW_USE_AUX_REG_REQ, 1);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D REG_READ(AUX_ARB_C=
ONTROL);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; field =3D get_reg_field_valu=
e(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value,<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_ARB=
_CONTROL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_REG=
_RW_CNTL_STATUS);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (field =3D=3D SW_CAN_=
ACCESS_AUX);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;#define COMPOSE_AUX_SW_DATA_16_20(command, address) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((command) | ((0xF0000 &amp;=
 (address)) &gt;&gt; 16))<br>
&gt; &#43;<br>
&gt; &#43;#define COMPOSE_AUX_SW_DATA_8_15(address) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((0xFF00 &amp; (address)) &g=
t;&gt; 8)<br>
&gt; &#43;<br>
&gt; &#43;#define COMPOSE_AUX_SW_DATA_0_7(address) \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0xFF &amp; (address))<br>
&gt; &#43;<br>
&gt; &#43;static void submit_channel_request(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_request_transacti=
on_data *request)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x110 =3D FROM_AUX_ENGINE(engine);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t length;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_write =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((request-&gt;type =3D=3D AUX_TRANSACTION_TYPE_DP) &amp=
;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (request-&gt;action =3D=3D I2CAUX_TRANSACTION_ACT=
ION_DP_WRITE)) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((request-&gt;type =3D=3D AUX_TRANSACTION_TYPE_I2C) &am=
p;&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ((request-&gt;action =3D=3D I2CAUX_TRANSACTION_ACTION_I=
2C_WRITE) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; (request-&gt;action =3D=3D I2CAUX_TRANSACTION_ACT=
ION_I2C_WRITE_MOT)));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG(AUXN_IMPCAL)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* clear_aux_error */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; REG_UPDATE_SEQ(AUXN_IMPCAL, AUXN_CALOUT_ERROR_AK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; REG_UPDATE_SEQ(AUXP_IMPCAL, AUXP_CALOUT_ERROR_AK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* force_default_calibrate */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; REG_UPDATE_1BY1_2(AUXN_IMPCAL,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUXN_IMPCAL_ENABLE, 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUXN_IMPCAL_OVERRIDE_ENABLE, 0);<b=
r>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* bug? why AUXN update EN and OVERRIDE_EN 1 by 1 while=
 AUX P toggles OVERRIDE? */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; REG_UPDATE_SEQ(AUXP_IMPCAL, AUXP_IMPCAL_OVERRIDE_ENABLE=
,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set the delay and the num=
ber of bytes to write */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The length include<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the 4 bit header and=
 the 20 bit address<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * (that is 3 byte).<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If the requested len=
gth is non zero this means<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * an addition byte spe=
cifying the length is required.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; length =3D request-&gt;lengt=
h ? 4 : 3;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_write)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; length &#43;=3D request-&gt;length;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_2(AUX_SW_CONTROL,=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
START_DELAY, request-&gt;delay,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
WR_BYTES, length);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* program action and addres=
s and payload data (if 'is_write') */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D REG_UPDATE_4(AUX_S=
W_DATA,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
INDEX, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
DATA_RW, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
AUTOINCREMENT_DISABLE, 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
DATA, COMPOSE_AUX_SW_DATA_16_20(request-&gt;action, request-&gt;address));<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D REG_SET_2(AUX_SW_D=
ATA, value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
AUTOINCREMENT_DISABLE, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
DATA, COMPOSE_AUX_SW_DATA_8_15(request-&gt;address));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D REG_SET(AUX_SW_DAT=
A, value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_=
DATA, COMPOSE_AUX_SW_DATA_0_7(request-&gt;address));<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;length) {<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; value =3D REG_SET(AUX_SW_DATA, value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_DATA, request-&gt;length - =
1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_write) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Load the HW buffer with the Data to be sent.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * This is relevant for write operation.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * For read, the data recived data will be<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * processed in process_channel_reply().<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; while (i &lt; request-&gt;length) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =
=3D REG_SET(AUX_SW_DATA, value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; AUX_SW_DATA, request-&gt;data[i]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#=
43;i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(AUX_INTERRUPT_CON=
TROL, AUX_SW_DONE_ACK, 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_WAIT(AUX_SW_STATUS, AUX_=
SW_DONE, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10, aux110-&gt;timeout_period/10);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE(AUX_SW_CONTROL, A=
UX_SW_GO, 1);<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static int read_channel_reply(struct aux_engine *engine, uint32_t=
 size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *buffer, uint8_t *reply_result,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *sw_status)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x110 =3D FROM_AUX_ENGINE(engine);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t bytes_replied;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t reply_result_32;<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *sw_status =3D REG_GET(AUX_S=
W_STATUS, AUX_SW_REPLY_BYTE_COUNT,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &amp;bytes_replied);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In case HPD is LOW, exit =
AUX transaction */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*sw_status &amp; AUX_SW=
_STATUS__AUX_SW_HPD_DISCON_MASK))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Need at least the status =
byte */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bytes_replied)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_UPDATE_1BY1_3(AUX_SW_DAT=
A,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AUX_SW_INDEX, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AUX_SW_AUTOINCREMENT_DISABLE, 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; AUX_SW_DATA_RW, 1);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET(AUX_SW_DATA, AUX_SW_=
DATA, &amp;reply_result_32);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply_result_32 =3D reply_re=
sult_32 &gt;&gt; 4;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reply_result =3D (uint8_t)r=
eply_result_32;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reply_result_32 =3D=3D 0=
) { /* ACK */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* First byte was already used to get the command statu=
s */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; --bytes_replied;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Do not overflow buffer */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (bytes_replied &gt; size)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
-1;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; while (i &lt; bytes_replied) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t aux_sw_data_val;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REG_GET=
(AUX_SW_DATA, AUX_SW_DATA, &amp;aux_sw_data_val);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[=
i] =3D aux_sw_data_val;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#=
43;i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return i;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void process_channel_reply(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_reply_transaction=
_data *reply)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int bytes_replied;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t reply_result;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sw_status;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_replied =3D read_chann=
el_reply(engine, reply-&gt;length, reply-&gt;data,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;reply_result, &amp;sw_status);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* in case HPD is LOW, exit =
AUX transaction */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((sw_status &amp; AUX_SW_=
STATUS__AUX_SW_HPD_DISCON_MASK)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; reply-&gt;status =3D AUX_CHANNEL_OPERATION_FAILED_HPD_D=
ISCON;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bytes_replied &lt; 0) {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Need to handle an error case...<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * Hopefully, upper layer function won't call this=
 function if<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * the number of bytes in the reply was 0, because=
 there was<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * surely an error that was asserted that should h=
ave been<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * handled for hot plug case, this could happens<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!(sw_status &amp; AUX_SW_STATUS__AUX_SW_HPD_DISCON_=
MASK)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply-&=
gt;status =3D AUX_TRANSACTION_REPLY_INVALID;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ASSERT_=
CRITICAL(false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; switch (reply_result) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 0: /* ACK */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply-&=
gt;status =3D AUX_TRANSACTION_REPLY_AUX_ACK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 1: /* NACK */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply-&=
gt;status =3D AUX_TRANSACTION_REPLY_AUX_NACK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 2: /* DEFER */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply-&=
gt;status =3D AUX_TRANSACTION_REPLY_AUX_DEFER;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 4: /* AUX ACK / I2C NACK */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply-&=
gt;status =3D AUX_TRANSACTION_REPLY_I2C_NACK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case 8: /* AUX ACK / I2C DEFER */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply-&=
gt;status =3D AUX_TRANSACTION_REPLY_I2C_DEFER;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reply-&=
gt;status =3D AUX_TRANSACTION_REPLY_INVALID;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static enum aux_channel_operation_result get_channel_status(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *returned_bytes)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x110 =3D FROM_AUX_ENGINE(engine);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (returned_bytes =3D=3D NU=
LL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*caller pass NULL pointer*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ASSERT_CRITICAL(false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return AUX_CHANNEL_OPERATION_FAILED_REASON_UNKNOWN;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *returned_bytes =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* poll to make sure that SW=
_DONE is asserted */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D REG_WAIT(AUX_SW_ST=
ATUS, AUX_SW_DONE, 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10, aux110-&gt;timeout_period/10);=
<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* in case HPD is LOW, exit =
AUX transaction */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((value &amp; AUX_SW_STAT=
US__AUX_SW_HPD_DISCON_MASK))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Note that the following b=
its are set in 'status.bits'<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * during CTS 4.2.1.2 (=
FW 3.3.1):<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AUX_SW_RX_MIN_COUNT_=
VIOL, AUX_SW_RX_INVALID_STOP,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AUX_SW_RX_RECV_NO_DE=
T, AUX_SW_RX_RECV_INVALID_H.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AUX_SW_RX_MIN_COUNT_=
VIOL is an internal,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * HW debugging bit and=
 should be ignored.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (value &amp; AUX_SW_STATU=
S__AUX_SW_DONE_MASK) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if ((value &amp; AUX_SW_STATUS__AUX_SW_RX_TIMEOUT_STATE=
_MASK) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (value =
&amp; AUX_SW_STATUS__AUX_SW_RX_TIMEOUT_MASK))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
AUX_CHANNEL_OPERATION_FAILED_TIMEOUT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else if ((value &amp; AUX_SW_STATUS__AUX_SW_RX_INVALID_=
STOP_MASK) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (value =
&amp; AUX_SW_STATUS__AUX_SW_RX_RECV_NO_DET_MASK) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (value =
&amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_STATUS__AUX_SW_RX_RECV_INVA=
LID_H_MASK) ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (value =
&amp; AUX_SW_STATUS__AUX_SW_RX_RECV_INVALID_L_MASK))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
AUX_CHANNEL_OPERATION_FAILED_INVALID_REPLY;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *returned_bytes =3D get_reg_field_value(value,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_STATUS,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_SW_REPLY_BYTE_COUNT);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (*returned_bytes =3D=3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_CHA=
NNEL_OPERATION_FAILED_INVALID_REPLY;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *return=
ed_bytes -=3D 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
AUX_CHANNEL_OPERATION_SUCCEEDED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*time_elapsed &gt;=3D aux_engine-&gt;timeout_period<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; *&nbsp; AUX_SW_STATUS__AUX_SW_HPD_DISCON =3D at t=
his point<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ASSERT_CRITICAL(false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return AUX_CHANNEL_OPERATION_FAILED_TIMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;static void process_read_reply(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct read_command_context =
*ctx)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;process=
_channel_reply(engine, &amp;ctx-&gt;reply);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ctx-&gt;reply.status=
) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_A=
UX_ACK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;defer_retry_aux =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;returned_byte &gt; ctx-&gt;current_read_len=
gth) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FAILED_P=
ROTOCOL_ERROR;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else if (ctx-&gt;returned_byte &lt; ctx-&gt;current_r=
ead_length) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;current_read_length -=3D ctx-&gt;returned_byte;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;offset &#43;=3D ctx-&gt;returned_byte;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#=
43;ctx-&gt;invalid_reply_retry_aux_on_ack;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx=
-&gt;invalid_reply_retry_aux_on_ack &gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_INVALID_REPLY_RETRY_COUNTER) {=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FAILED_P=
ROTOCOL_ERROR;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D fa=
lse;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_SUCCEEDED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;transaction_complete =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_A=
UX_NACK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_NAC=
K;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_A=
UX_DEFER:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;defer_retry_aux;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;defer_retry_aux &gt; AUX_DEFER_RETRY_COUNTE=
R) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_I=
2C_DEFER:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;defer_retry_aux =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;defer_retry_i2c;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;defer_retry_i2c &gt; AUX_DEFER_RETRY_COUNTE=
R) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_H=
PD_DISCON:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD=
_DISCON;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;static void process_read_request(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct read_command_context =
*ctx)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aux_channel_operation_r=
esult operation_result;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;submit_=
channel_request(engine, &amp;ctx-&gt;request);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_result =3D engine-=
&gt;funcs-&gt;get_channel_status(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; engine, &amp;ctx-&gt;returned_byte);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (operation_result) {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_S=
UCCEEDED:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;returned_byte &gt; ctx-&gt;current_read_len=
gth) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FAILED_P=
ROTOCOL_ERROR;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;timed_out_retry_aux =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;invalid_reply_retry_aux =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;reply.length =3D ctx-&gt;returned_byte;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;reply.data =3D ctx-&gt;buffer;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process=
_read_reply(engine, ctx);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_F=
AILED_INVALID_REPLY:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;invalid_reply_retry_aux;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;invalid_reply_retry_aux &gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_INV=
ALID_REPLY_RETRY_COUNTER) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FAILED_P=
ROTOCOL_ERROR;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(=
400);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_F=
AILED_TIMEOUT:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;timed_out_retry_aux;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;timed_out_retry_aux &gt; AUX_TIMED_OUT_RETR=
Y_COUNTER) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DP 1=
.2a, table 2-58:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 &quot;S3: AUX Request CMD PENDING:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 retry 3 times, with 400usec wait on each&quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 The HW timeout is set to 550usec,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 so we should not wait here<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_F=
AILED_HPD_DISCON:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD=
_DISCON;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;static bool read_command(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_transaction_re=
quest *request,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool middle_of_transaction)<=
br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct read_command_context =
ctx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.buffer =3D request-&gt;p=
ayload.data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.current_read_length =3D =
request-&gt;payload.length;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.offset =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.timed_out_retry_aux =3D =
0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.invalid_reply_retry_aux =
=3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.defer_retry_aux =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.defer_retry_i2c =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.invalid_reply_retry_aux_=
on_ack =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.transaction_complete =3D=
 false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.operation_succeeded =3D =
true;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;payload.addr=
ess_space =3D=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.type =3D AUX_TRANSACTION_TYPE_DP;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.action =3D I2CAUX_TRANSACTION_ACTION_DP_REA=
D;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.address =3D request-&gt;payload.address;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (request-&gt;paylo=
ad.address_space =3D=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.type =3D AUX_TRANSACTION_TYPE_I2C;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.action =3D middle_of_transaction ?<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_READ_MOT :<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_READ;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.address =3D request-&gt;payload.address &gt=
;&gt; 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* in DAL2, there was no return in such case */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; BREAK_TO_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.request.delay =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; memset(ctx.buffer &#43; ctx.offset, 0, ctx.current_read=
_length);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.data =3D ctx.buffer &#43; ctx.offset;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.length =3D ctx.current_read_length;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; process_read_request(engine, &amp;ctx);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; request-&gt;status =3D ctx.status;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx.operation_succeeded &amp;&amp; !ctx.transaction=
_complete)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx=
.request.type =3D=3D AUX_TRANSACTION_TYPE_I2C)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(engine-&gt;delay);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (ctx.operation_succe=
eded &amp;&amp; !ctx.transaction_complete);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;payload.addr=
ess_space =3D=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DC_LOG_I2C_AUX(&quot;READ: addr:0x%x&nbsp; value:0x%x R=
esult:%d&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;payload.address,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;payload.data[0],<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.operation_succeeded);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ctx.operation_succeed=
ed;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static void process_write_reply(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct write_command_context=
 *ctx)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;process=
_channel_reply(engine, &amp;ctx-&gt;reply);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (ctx-&gt;reply.status=
) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_A=
UX_ACK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D true;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;returned_byte) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;request.action =3D ctx-&gt;mot ?<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_STATUS_REQUEST_MOT :<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_STATUS_REQUEST;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;current_write_length =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#=
43;ctx-&gt;ack_m_retry;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx=
-&gt;ack_m_retry &gt; AUX_DEFER_RETRY_COUNTER) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FAILED_T=
IMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D fa=
lse;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(300);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_SUCCEEDED;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;defer_retry_aux =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;ack_m_retry =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;transaction_complete =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_A=
UX_NACK:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_NAC=
K;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_A=
UX_DEFER:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;defer_retry_aux;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;defer_retry_aux &gt; ctx-&gt;max_defer_retr=
y) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_I=
2C_DEFER:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;defer_retry_aux =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;current_write_length =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;request.action =3D ctx-&gt;mot ?<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_STATUS_REQUEST_MOT :<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_STATUS_REQUEST;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;defer_retry_i2c;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;defer_retry_i2c &gt; ctx-&gt;max_defer_retr=
y) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_TRANSACTION_REPLY_H=
PD_DISCON:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD=
_DISCON;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;static void process_write_request(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct write_command_context=
 *ctx)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aux_channel_operation_r=
esult operation_result;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;funcs-&gt;submit_=
channel_request(engine, &amp;ctx-&gt;request);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; operation_result =3D engine-=
&gt;funcs-&gt;get_channel_status(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; engine, &amp;ctx-&gt;returned_byte);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (operation_result) {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_S=
UCCEEDED:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;timed_out_retry_aux =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;invalid_reply_retry_aux =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;reply.length =3D ctx-&gt;returned_byte;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;reply.data =3D ctx-&gt;reply_data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; process_write_reply(engine, ctx);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_F=
AILED_INVALID_REPLY:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;invalid_reply_retry_aux;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;invalid_reply_retry_aux &gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_INV=
ALID_REPLY_RETRY_COUNTER) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FAILED_P=
ROTOCOL_ERROR;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udelay(=
400);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_F=
AILED_TIMEOUT:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &#43;&#43;ctx-&gt;timed_out_retry_aux;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx-&gt;timed_out_retry_aux &gt; AUX_TIMED_OUT_RETR=
Y_COUNTER) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_TIMEOUT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx-&gt=
;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* DP 1=
.2a, table 2-58:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 &quot;S3: AUX Request CMD PENDING:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 retry 3 times, with 400usec wait on each&quot;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 The HW timeout is set to 550usec,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
 so we should not wait here<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *=
/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AUX_CHANNEL_OPERATION_F=
AILED_HPD_DISCON:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_FAILED_HPD=
_DISCON;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;status =3D I2CAUX_TRANSACTION_STATUS_UNKNOWN;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx-&gt;operation_succeeded =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;}<br>
&gt; &#43;static bool write_command(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_transaction_re=
quest *request,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool middle_of_transaction)<=
br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct write_command_context=
 ctx;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.mot =3D middle_of_transa=
ction;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.buffer =3D request-&gt;p=
ayload.data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.current_write_length =3D=
 request-&gt;payload.length;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.timed_out_retry_aux =3D =
0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.invalid_reply_retry_aux =
=3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.defer_retry_aux =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.defer_retry_i2c =3D 0;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.ack_m_retry =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.transaction_complete =3D=
 false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.operation_succeeded =3D =
true;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;payload.addr=
ess_space =3D=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.type =3D AUX_TRANSACTION_TYPE_DP;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.action =3D I2CAUX_TRANSACTION_ACTION_DP_WRI=
TE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.address =3D request-&gt;payload.address;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (request-&gt;paylo=
ad.address_space =3D=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.type =3D AUX_TRANSACTION_TYPE_I2C;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.action =3D middle_of_transaction ?<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_WRITE_MOT :<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_=
TRANSACTION_ACTION_I2C_WRITE;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.address =3D request-&gt;payload.address &gt=
;&gt; 1;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* in DAL2, there was no return in such case */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; BREAK_TO_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.request.delay =3D 0;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.max_defer_retry =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (engine-&gt;max_defer_write_retry &gt; AUX_DEFER_RETRY_=
COUNTER) ?<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-=
&gt;max_defer_write_retry : AUX_DEFER_RETRY_COUNTER;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.data =3D ctx.buffer;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ctx.request.length =3D ctx.current_write_length;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; process_write_request(engine, &amp;ctx);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; request-&gt;status =3D ctx.status;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ctx.operation_succeeded &amp;&amp; !ctx.transaction=
_complete)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx=
.request.type =3D=3D AUX_TRANSACTION_TYPE_I2C)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msleep(engine-&gt;delay);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (ctx.operation_succe=
eded &amp;&amp; !ctx.transaction_complete);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;payload.addr=
ess_space =3D=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_DPCD) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DC_LOG_I2C_AUX(&quot;WRITE: addr:0x%x&nbsp; value:0x%x =
Result:%d&quot;,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;payload.address,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; request-&gt;payload.data[0],<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx.operation_succeeded);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ctx.operation_succeed=
ed;<br>
&gt; &#43;}<br>
&gt; &#43;static bool end_of_transaction_command(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_transaction_re=
quest *request)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_transaction_re=
quest dummy_request;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t dummy_data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* [tcheng] We only need to =
send the stop (read with MOT =3D 0)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for I2C-over-Aux, no=
t native AUX<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;payload.addr=
ess_space !=3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_SPACE_I2C)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_request.operation =3D =
request-&gt;operation;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_request.payload.addres=
s_space =3D request-&gt;payload.address_space;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_request.payload.addres=
s =3D request-&gt;payload.address;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Add a dummy byte due=
 to some receiver quirk<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * where one byte is se=
nt along with MOT =3D 0.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Ideally this should =
be 0.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_request.payload.length=
 =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_request.payload.data =
=3D &amp;dummy_data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (request-&gt;operation =
=3D=3D I2CAUX_TRANSACTION_READ)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return read_command(engine, &amp;dummy_request, false);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return write_command(engine, &amp;dummy_request, false)=
;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* according Syed, it does n=
ot need now DoDummyMOT */<br>
&gt; &#43;}<br>
&gt; &#43;bool submit_request(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_transaction_re=
quest *request,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool middle_of_transaction)<=
br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *aux_engin=
e =3D FROM_AUX_ENGINE_ENGINE(engine);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool result;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mot_used =3D true;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (request-&gt;operatio=
n) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I2CAUX_TRANSACTION_READ=
:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D read_command(aux_engine, request, mot_used);=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case I2CAUX_TRANSACTION_WRIT=
E:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D write_command(aux_engine, request, mot_used)=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* [tcheng]<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * need to send stop fo=
r the last transaction to free up the AUX<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * if the above command=
 fails, this would be the last transaction<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!middle_of_transaction |=
| !result)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; end_of_transaction_command(aux_engine, request);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* mask AUX interrupt */<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return result;<br>
&gt; &#43;}<br>
&gt; &#43;enum i2caux_engine_type get_engine_type(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const struct engine *engine)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return I2CAUX_ENGINE_TYPE_AU=
X;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static struct aux_engine *acquire(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine *aux_engin=
e =3D FROM_AUX_ENGINE_ENGINE(engine);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum gpio_result result;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (aux_engine-&gt;funcs-&gt=
;is_engine_available) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*check whether SW could use the engine*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!aux_engine-&gt;funcs-&gt;is_engine_available(aux_e=
ngine))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; result =3D dal_ddc_open(ddc,=
 GPIO_MODE_HARDWARE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; GPIO_DDC_CONFIG_TYPE_MODE_AUX);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (result !=3D GPIO_RESULT_=
OK)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine-&gt;funcs-&g=
t;acquire_engine(aux_engine)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dal_ddc_close(ddc);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; engine-&gt;ddc =3D ddc;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return aux_engine;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct aux_engine_funcs aux_engine_funcs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .acquire_engine =3D acquire_=
engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .submit_channel_request =3D =
submit_channel_request,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .process_channel_reply =3D p=
rocess_channel_reply,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read_channel_reply =3D read=
_channel_reply,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_channel_status =3D get_=
channel_status,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_engine_available =3D is_=
engine_available,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;static const struct engine_funcs engine_funcs =3D {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release_engine =3D release_=
engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .destroy_engine =3D dce110_e=
ngine_destroy,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .submit_request =3D submit_r=
equest,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_engine_type =3D get_eng=
ine_type,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .acquire =3D acquire,<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;void dce110_engine_destroy(struct engine **engine)<br>
&gt; &#43;{<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *en=
gine110 =3D FROM_ENGINE(*engine);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(engine110);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *engine =3D NULL;<br>
&gt; &#43;<br>
&gt; &#43;}<br>
&gt; &#43;struct aux_engine *dce110_aux_engine_construct(struct aux_engine_=
dce110 *aux_engine110,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t timeout_period,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const struct dce110_aux_registers *regs)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;base.base.=
ddc =3D NULL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;base.base.=
ctx =3D ctx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;base.delay=
 =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;base.max_d=
efer_write_retry =3D 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;base.base.=
funcs =3D &amp;engine_funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;base.funcs=
 =3D &amp;aux_engine_funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;base.base.=
inst =3D inst;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;timeout_pe=
riod =3D timeout_period;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux_engine110-&gt;regs =3D r=
egs;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine110-&g=
t;base;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gp=
u/drm/amd/display/dc/dce/dce_aux.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..c6b2aec<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h<br>
&gt; @@ -0,0 &#43;1,111 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; * Authors: AMD<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#ifndef __DAL_AUX_ENGINE_DCE110_H__<br>
&gt; &#43;#define __DAL_AUX_ENGINE_DCE110_H__<br>
&gt; &#43;#include &quot;aux_engine.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;#define AUX_COMMON_REG_LIST(id)\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(AUX_CONTROL, DP_AUX, id)=
, \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(AUX_ARB_CONTROL, DP_AUX,=
 id), \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(AUX_SW_DATA, DP_AUX, id)=
, \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(AUX_SW_CONTROL, DP_AUX, =
id), \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(AUX_INTERRUPT_CONTROL, D=
P_AUX, id), \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SRI(AUX_SW_STATUS, DP_AUX, i=
d), \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(AUXN_IMPCAL), \<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SR(AUXP_IMPCAL)<br>
&gt; &#43;<br>
&gt; &#43;struct dce110_aux_registers {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUX_CONTROL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUX_ARB_CONTROL;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUX_SW_DATA;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUX_SW_CONTROL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUX_INTERRUPT_CONTR=
OL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUX_SW_STATUS;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUXN_IMPCAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUXP_IMPCAL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t AUX_RESET_MASK;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;enum { /* This is the timeout as defined in DP 1.2a,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 2.3.4 &quot;Detailed=
 uPacket TX AUX CH State Description&quot;.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_TIMEOUT_PERIOD =3D 400,<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ideally, the SW timeout s=
hould be just above 550usec<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * which is programmed =
in HW.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * But the SW timeout o=
f 600usec is not reliable,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * because on some syst=
ems, delay_in_microseconds()<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * returns faster than =
it should.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * EPR #379763: by tria=
l-and-error on different systems,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 700usec is the minim=
um reliable SW timeout for polling<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the AUX_SW_STATUS.AU=
X_SW_DONE bit.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This timeout expires=
 *only* when there is<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AUX Error or AUX Tim=
eout conditions - not during normal operation.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * During normal operat=
ion, AUX_SW_STATUS.AUX_SW_DONE bit is set<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * at most within ~240u=
sec. That means,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * increasing this time=
out will not affect normal operation,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and we'll timeout af=
ter<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * SW_AUX_TIMEOUT_PERIO=
D_MULTIPLIER * AUX_TIMEOUT_PERIOD =3D 1600usec.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This timeout is espe=
cially important for<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * resume from S3 and C=
TS.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIMEOUT_PERIOD_MULTIP=
LIER =3D 4<br>
&gt; &#43;};<br>
&gt; &#43;struct aux_engine_dce110 {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine base;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dce110_aux_regi=
sters *regs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t aux_control;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t aux_arb_control;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t aux_sw_data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t aux_sw_control;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t aux_interrupt_control;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t aux_sw_status;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } addr;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout_period;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;struct aux_engine_dce110_init_data {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t engine_id;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timeout_period;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct dce110_aux_regi=
sters *regs;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;struct aux_engine *dce110_aux_engine_construct(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *aux_engine110,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t timeout_period,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const struct dce110_aux_registers *regs);<br>
&gt; &#43;<br>
&gt; &#43;void dce110_engine_destroy(struct engine **engine);<br>
&gt; &#43;<br>
&gt; &#43;bool dce110_aux_engine_acquire(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *aux_engine,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc);<br>
&gt; &#43;#endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b=
/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c<br>
&gt; index ad8ad4e..c34c953 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resourc=
e.c<br>
&gt; @@ -52,6 &#43;52,7 @@<br>
&gt;&nbsp; #include &quot;dce/dce_10_0_sh_mask.h&quot;<br>
&gt;<br>
&gt;&nbsp; #include &quot;dce/dce_dmcu.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_aux.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_abm.h&quot;<br>
&gt;<br>
&gt;&nbsp; #ifndef mmMC_HUB_RDREQ_DMIF_LIMIT<br>
&gt; @@ -279,7 &#43;280,20 @@ static const struct dce_opp_shift opp_shift =
=3D {<br>
&gt;&nbsp; static const struct dce_opp_mask opp_mask =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_COMMON_MASK_SH_LIS=
T_DCE_100(_MASK)<br>
&gt;&nbsp; };<br>
&gt; &#43;#define aux_engine_regs(id)\<br>
&gt; &#43;[id] =3D {\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST(id), \<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D 0 \<br>
&gt; &#43;}<br>
&gt;<br>
&gt; &#43;static const struct dce110_aux_registers aux_engine_regs[] =3D {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(0),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(3),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(4),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(5)<br>
&gt; &#43;};<br>
&gt;<br>
&gt;&nbsp; #define audio_regs(id)\<br>
&gt;&nbsp; [id] =3D {\<br>
&gt; @@ -572,6 &#43;586,23 @@ struct output_pixel_processor *dce100_opp_cre=
ate(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;opp-&gt;ba=
se;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;struct engine *dce100_aux_engine_create(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x_engine =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_aux_engine_construct(=
aux_engine, ctx, inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIM=
EOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aux_e=
ngine_regs[inst]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine-&gt;b=
ase.base;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; struct clock_source *dce100_clock_source_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bios *bios,<=
br>
&gt; @@ -624,6 &#43;655,10 @@ static void destruct(struct dce110_resource_p=
ool *pool)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
free(DCE110TG_FROM_TG(pool-&gt;base.timing_generators[i]));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ool-&gt;base.timing_generators[i] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] !=3D NULL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_=
engine_destroy(&amp;pool-&gt;base.engines[i]);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
ool-&gt;base.stream_enc_count; i&#43;&#43;) {<br>
&gt; @@ -928,6 &#43;963,13 @@ static bool construct(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC: failed to create o=
utput pixel processor!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto res_create_fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pool-&gt;base.engines[i] =3D dce100_aux_engine_create(c=
tx, i);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BREAK_T=
O_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_erro=
r(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create aux engi=
ne!!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto re=
s_create_fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_planes=
 =3D&nbsp; pool-&gt;base.pipe_count;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b=
/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c<br>
&gt; index 1c902e4..4a665a2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resourc=
e.c<br>
&gt; @@ -49,6 &#43;49,7 @@<br>
&gt;&nbsp; #include &quot;dce/dce_clock_source.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_hwseq.h&quot;<br>
&gt;&nbsp; #include &quot;dce110/dce110_hw_sequencer.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_aux.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_abm.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_dmcu.h&quot;<br>
&gt;<br>
&gt; @@ -306,6 &#43;307,21 @@ static const struct dce_opp_mask opp_mask =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_COMMON_MASK_SH_LIS=
T_DCE_110(_MASK)<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;#define aux_engine_regs(id)\<br>
&gt; &#43;[id] =3D {\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST(id), \<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D 0 \<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct dce110_aux_registers aux_engine_regs[] =3D {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(0),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(3),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(4),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(5)<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; #define audio_regs(id)\<br>
&gt;&nbsp; [id] =3D {\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUD_COMMON_REG_LIST(id=
)\<br>
&gt; @@ -588,6 &#43;604,23 @@ static struct output_pixel_processor *dce110_=
opp_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;opp-&gt;ba=
se;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;struct engine *dce110_aux_engine_create(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x_engine =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_aux_engine_construct(=
aux_engine, ctx, inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIM=
EOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aux_e=
ngine_regs[inst]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine-&gt;b=
ase.base;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; struct clock_source *dce110_clock_source_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bios *bios,<=
br>
&gt; @@ -651,6 &#43;684,10 @@ static void destruct(struct dce110_resource_p=
ool *pool)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
free(DCE110TG_FROM_TG(pool-&gt;base.timing_generators[i]));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ool-&gt;base.timing_generators[i] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] !=3D NULL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_=
engine_destroy(&amp;pool-&gt;base.engines[i]);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
ool-&gt;base.stream_enc_count; i&#43;&#43;) {<br>
&gt; @@ -1258,6 &#43;1295,14 @@ static bool construct(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC: failed to create o=
utput pixel processor!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto res_create_fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pool-&gt;base.engines[i] =3D dce110_aux_engine_create(c=
tx, i);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BREAK_T=
O_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_erro=
r(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create aux engi=
ne!!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto re=
s_create_fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;fbc_compressor =
=3D dce110_compressor_create(ctx);<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b=
/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c<br>
&gt; index 30d5b32..caf90ae 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resourc=
e.c<br>
&gt; @@ -49,6 &#43;49,7 @@<br>
&gt;&nbsp; #include &quot;dce112/dce112_hw_sequencer.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_abm.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_dmcu.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_aux.h&quot;<br>
&gt;<br>
&gt;&nbsp; #include &quot;reg_helper.h&quot;<br>
&gt;<br>
&gt; @@ -314,6 &#43;315,21 @@ static const struct dce_opp_mask opp_mask =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_COMMON_MASK_SH_LIS=
T_DCE_112(_MASK)<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;#define aux_engine_regs(id)\<br>
&gt; &#43;[id] =3D {\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST(id), \<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D 0 \<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct dce110_aux_registers aux_engine_regs[] =3D {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(0),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(3),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(4),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(5)<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; #define audio_regs(id)\<br>
&gt;&nbsp; [id] =3D {\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUD_COMMON_REG_LIST(id=
)\<br>
&gt; @@ -588,6 &#43;604,23 @@ struct output_pixel_processor *dce112_opp_cre=
ate(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;opp-&gt;ba=
se;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;struct engine *dce112_aux_engine_create(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x_engine =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_aux_engine_construct(=
aux_engine, ctx, inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIM=
EOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aux_e=
ngine_regs[inst]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine-&gt;b=
ase.base;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; struct clock_source *dce112_clock_source_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_bios *bios,<=
br>
&gt; @@ -625,6 &#43;658,9 @@ static void destruct(struct dce110_resource_po=
ol *pool)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.opps[i] !=3D NULL)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ce110_opp_destroy(&amp;pool-&gt;base.opps[i]);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] !=3D NULL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_=
engine_destroy(&amp;pool-&gt;base.engines[i]);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.transforms[i] !=3D NULL)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
ce112_transform_destroy(&amp;pool-&gt;base.transforms[i]);<br>
&gt;<br>
&gt; @@ -640,6 &#43;676,10 @@ static void destruct(struct dce110_resource_p=
ool *pool)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
free(DCE110TG_FROM_TG(pool-&gt;base.timing_generators[i]));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ool-&gt;base.timing_generators[i] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] !=3D NULL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_=
engine_destroy(&amp;pool-&gt;base.engines[i]);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
ool-&gt;base.stream_enc_count; i&#43;&#43;) {<br>
&gt; @@ -1208,6 &#43;1248,13 @@ static bool construct(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create ou=
tput pixel processor!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto res_create_fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pool-&gt;base.engines[i] =3D dce112_aux_engine_create(c=
tx, i);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BREAK_T=
O_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_erro=
r(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create aux engi=
ne!!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto re=
s_create_fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!resource_construc=
t(num_virtual_links, dc, &amp;pool-&gt;base,<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b=
/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
&gt; index 8381f27..e389832 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resourc=
e.c<br>
&gt; @@ -53,6 &#43;53,7 @@<br>
&gt;&nbsp; #include &quot;dce/dce_hwseq.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_abm.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_dmcu.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_aux.h&quot;<br>
&gt;<br>
&gt;&nbsp; #include &quot;dce/dce_12_0_offset.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_12_0_sh_mask.h&quot;<br>
&gt; @@ -297,6 &#43;298,20 @@ static const struct dce_opp_shift opp_shift =
=3D {<br>
&gt;&nbsp; static const struct dce_opp_mask opp_mask =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_COMMON_MASK_SH_LIS=
T_DCE_120(_MASK)<br>
&gt;&nbsp; };<br>
&gt; &#43; #define aux_engine_regs(id)\<br>
&gt; &#43;[id] =3D {\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST(id), \<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D 0 \<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct dce110_aux_registers aux_engine_regs[] =3D {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(0),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(3),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(4),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(5)<br>
&gt; &#43;};<br>
&gt;<br>
&gt;&nbsp; #define audio_regs(id)\<br>
&gt;&nbsp; [id] =3D {\<br>
&gt; @@ -361,6 &#43;376,22 @@ struct output_pixel_processor *dce120_opp_cre=
ate(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ctx, inst, &amp;opp_regs[inst], &amp;opp_shift=
, &amp;opp_mask);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;opp-&gt;ba=
se;<br>
&gt;&nbsp; }<br>
&gt; &#43;struct engine *dce120_aux_engine_create(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x_engine =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_aux_engine_construct(=
aux_engine, ctx, inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIM=
EOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aux_e=
ngine_regs[inst]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine-&gt;b=
ase.base;<br>
&gt; &#43;}<br>
&gt;<br>
&gt;&nbsp; static const struct bios_registers bios_regs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =3D mm=
BIOS_SCRATCH_6 &#43; NBIO_BASE(mmBIOS_SCRATCH_6_BASE_IDX)<br>
&gt; @@ -467,6 &#43;498,10 @@ static void destruct(struct dce110_resource_p=
ool *pool)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
free(DCE110TG_FROM_TG(pool-&gt;base.timing_generators[i]));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ool-&gt;base.timing_generators[i] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] !=3D NULL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_=
engine_destroy(&amp;pool-&gt;base.engines[i]);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
ool-&gt;base.audio_count; i&#43;&#43;) {<br>
&gt; @@ -984,6 &#43;1019,13 @@ static bool construct(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
m_error(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC: failed to create o=
utput pixel processor!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pool-&gt;base.engines[i] =3D dce120_aux_engine_create(c=
tx, i);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] =3D=
=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; BREAK_TO_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; dm_error(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:fail=
ed to create aux engine!!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; goto res_create_fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* check next valid pipe */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; j&#43;&#43;;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/d=
rivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c<br>
&gt; index 2ac95ec..6fb33ad 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.=
c<br>
&gt; @@ -54,6 &#43;54,7 @@<br>
&gt;&nbsp; #include &quot;reg_helper.h&quot;<br>
&gt;<br>
&gt;&nbsp; #include &quot;dce/dce_dmcu.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_aux.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_abm.h&quot;<br>
&gt;&nbsp; /* TODO remove this include */<br>
&gt;<br>
&gt; @@ -298,6 &#43;299,21 @@ static const struct dce_opp_mask opp_mask =3D=
 {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPP_COMMON_MASK_SH_LIS=
T_DCE_80(_MASK)<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;#define aux_engine_regs(id)\<br>
&gt; &#43;[id] =3D {\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST(id), \<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D 0 \<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct dce110_aux_registers aux_engine_regs[] =3D {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(0),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(3),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(4),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(5)<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; #define audio_regs(id)\<br>
&gt;&nbsp; [id] =3D {\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUD_COMMON_REG_LIST(id=
)\<br>
&gt; @@ -448,6 &#43;464,23 @@ static struct output_pixel_processor *dce80_o=
pp_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;opp-&gt;ba=
se;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;struct engine *dce80_aux_engine_create(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x_engine =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_aux_engine_construct(=
aux_engine, ctx, inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIM=
EOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aux_e=
ngine_regs[inst]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine-&gt;b=
ase.base;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static struct stream_encoder *dce80_stream_encoder_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum engine_id eng_id,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx=
)<br>
&gt; @@ -655,6 &#43;688,9 @@ static void destruct(struct dce110_resource_po=
ol *pool)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
free(DCE110TG_FROM_TG(pool-&gt;base.timing_generators[i]));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ool-&gt;base.timing_generators[i] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] !=3D NULL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_=
engine_destroy(&amp;pool-&gt;base.engines[i]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
ool-&gt;base.stream_enc_count; i&#43;&#43;) {<br>
&gt; @@ -899,6 &#43;935,14 @@ static bool dce80_construct(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d=
m_error(&quot;DC: failed to create output pixel processor!\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto res_create_fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pool-&gt;base.engines[i] =3D dce80_aux_engine_create(ct=
x, i);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BREAK_T=
O_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_erro=
r(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create aux engi=
ne!!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto re=
s_create_fail;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc-&gt;caps.max_planes=
 =3D&nbsp; pool-&gt;base.pipe_count;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/d=
rivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c<br>
&gt; index 84581b3..ef8bb27 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.=
c<br>
&gt; @@ -64,6 &#43;64,7 @@<br>
&gt;&nbsp; #include &quot;reg_helper.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_abm.h&quot;<br>
&gt;&nbsp; #include &quot;dce/dce_dmcu.h&quot;<br>
&gt; &#43;#include &quot;dce/dce_aux.h&quot;<br>
&gt;<br>
&gt;&nbsp; const struct _vcs_dpi_ip_params_st dcn1_0_ip =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .rob_buffer_size_kbyte=
s =3D 64,<br>
&gt; @@ -356,6 &#43;357,21 @@ static const struct dcn10_opp_mask opp_mask =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; OPP_MASK_SH_LIST_DCN10(_MASK),<br>
&gt;&nbsp; };<br>
&gt;<br>
&gt; &#43;#define aux_engine_regs(id)\<br>
&gt; &#43;[id] =3D {\<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AUX_COMMON_REG_LIST(id), \<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AUX_RESET_MASK =3D 0 \<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt; &#43;static const struct dce110_aux_registers aux_engine_regs[] =3D {<=
br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(0),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(1),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(2),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(3),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(4),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux_engine_regs(5)<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt;&nbsp; #define tf_regs(id)\<br>
&gt;&nbsp; [id] =3D {\<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TF_REG_LIST_DCN10(id),=
\<br>
&gt; @@ -578,6 &#43;594,23 @@ static struct output_pixel_processor *dcn10_o=
pp_create(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;opp-&gt;ba=
se;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt; &#43;struct engine *dcn10_aux_engine_create(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine_dce110 *au=
x_engine =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kzalloc(sizeof(struct aux_engine_dce110), GFP_KERNEL);<=
br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!aux_engine)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dce110_aux_engine_construct(=
aux_engine, ctx, inst,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SW_AUX_TIM=
EOUT_PERIOD_MULTIPLIER * AUX_TIMEOUT_PERIOD,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aux_e=
ngine_regs[inst]);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return &amp;aux_engine-&gt;b=
ase.base;<br>
&gt; &#43;}<br>
&gt; &#43;<br>
&gt;&nbsp; static struct mpc *dcn10_mpc_create(struct dc_context *ctx)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dcn10_mpc *mpc1=
0 =3D kzalloc(sizeof(struct dcn10_mpc),<br>
&gt; @@ -826,6 &#43;859,9 @@ static void destruct(struct dcn10_resource_poo=
l *pool)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
free(DCN10TG_FROM_TG(pool-&gt;base.timing_generators[i]));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p=
ool-&gt;base.timing_generators[i] =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] !=3D NULL)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pool-&g=
t;base.engines[i]-&gt;funcs-&gt;destroy_engine(&amp;pool-&gt;base.engines[i=
]);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; p=
ool-&gt;base.stream_enc_count; i&#43;&#43;)<br>
&gt; @@ -1255,6 &#43;1291,14 @@ static bool construct(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pool-&gt;base.engines[i] =3D dcn10_aux_engine_create(ct=
x, i);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (pool-&gt;base.engines[i] =3D=3D NULL) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BREAK_T=
O_DEBUGGER();<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dm_erro=
r(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;DC:failed to create aux engi=
ne!!\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fa=
il;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; /* check next valid pipe */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; j&#43;&#43;;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/engine.h b/drivers/=
gpu/drm/amd/display/dc/i2caux/engine.h<br>
&gt; index 1e8a158..b16fb1f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/i2caux/engine.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/i2caux/engine.h<br>
&gt; @@ -96,6 &#43;96,7 @@ struct engine_funcs {<br>
&gt;<br>
&gt;&nbsp; struct engine {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct engine_fu=
ncs *funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx=
;<br>
&gt;&nbsp; };<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers=
/gpu/drm/amd/display/dc/inc/core_types.h<br>
&gt; index 1db26bc..2d0d4ae 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/core_types.h<br>
&gt; @@ -138,7 &#43;138,7 @@ struct resource_pool {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct output_pixel_pr=
ocessor *opps[MAX_PIPES];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct timing_generato=
r *timing_generators[MAX_PIPES];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct stream_encoder =
*stream_enc[MAX_PIPES * 2];<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine *engines[MAX_P=
IPES];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hubbub *hubbub;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mpc *mpc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct pp_smu_funcs_rv=
 *pp_smu;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h b/driv=
ers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..06d7e5d<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h<b=
r>
&gt; @@ -0,0 &#43;1,113 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; * Authors: AMD<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#ifndef __DAL_AUX_ENGINE_H__<br>
&gt; &#43;#define __DAL_AUX_ENGINE_H__<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;engine.h&quot;<br>
&gt; &#43;#include &quot;include/i2caux_interface.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;struct aux_engine;<br>
&gt; &#43;union aux_config;<br>
&gt; &#43;struct aux_engine_funcs {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*destroy)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine **ptr);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*acquire_engine)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine *engine);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*configure)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; union aux_config cfg);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*submit_channel_reques=
t)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_request_transaction_data *request);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*process_channel_reply=
)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_reply_transaction_data *reply);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*read_channel_reply)(<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t size,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint8_t *buffer,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint8_t *reply_result,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t *sw_status);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum aux_channel_operation_r=
esult (*get_channel_status)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct aux_engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint8_t *returned_bytes);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*is_engine_available)(=
struct aux_engine *engine);<br>
&gt; &#43;};<br>
&gt; &#43;struct engine;<br>
&gt; &#43;struct aux_engine {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct engine base;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct aux_engine_func=
s *funcs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* following values are expr=
essed in milliseconds */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t delay;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_defer_write_ret=
ry;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool acquire_reset;<br>
&gt; &#43;};<br>
&gt; &#43;struct read_command_context {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *buffer;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t current_read_length=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t offset;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum i2caux_transaction_stat=
us status;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_request_transacti=
on_data request;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_reply_transaction=
_data reply;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t returned_byte;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timed_out_retry_aux=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t invalid_reply_retry=
_aux;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t defer_retry_aux;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t defer_retry_i2c;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t invalid_reply_retry=
_aux_on_ack;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool transaction_complete;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool operation_succeeded;<br=
>
&gt; &#43;};<br>
&gt; &#43;struct write_command_context {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool mot;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *buffer;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t current_write_lengt=
h;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum i2caux_transaction_stat=
us status;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_request_transacti=
on_data request;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_reply_transaction=
_data reply;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t returned_byte;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t timed_out_retry_aux=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t invalid_reply_retry=
_aux;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t defer_retry_aux;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t defer_retry_i2c;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_defer_retry;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ack_m_retry;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t reply_data[DEFAULT_A=
UX_MAX_DATA_SIZE];<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool transaction_complete;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool operation_succeeded;<br=
>
&gt; &#43;};<br>
&gt; &#43;#endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/engine.h b/drivers/=
gpu/drm/amd/display/dc/inc/hw/engine.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000..1f5476f<br>
&gt; --- /dev/null<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/inc/hw/engine.h<br>
&gt; @@ -0,0 &#43;1,106 @@<br>
&gt; &#43;/*<br>
&gt; &#43; * Copyright 2012-15 Advanced Micro Devices, Inc.<br>
&gt; &#43; *<br>
&gt; &#43; * Permission is hereby granted, free of charge, to any person ob=
taining a<br>
&gt; &#43; * copy of this software and associated documentation files (the =
&quot;Software&quot;),<br>
&gt; &#43; * to deal in the Software without restriction, including without=
 limitation<br>
&gt; &#43; * the rights to use, copy, modify, merge, publish, distribute, s=
ublicense,<br>
&gt; &#43; * and/or sell copies of the Software, and to permit persons to w=
hom the<br>
&gt; &#43; * Software is furnished to do so, subject to the following condi=
tions:<br>
&gt; &#43; *<br>
&gt; &#43; * The above copyright notice and this permission notice shall be=
 included in<br>
&gt; &#43; * all copies or substantial portions of the Software.<br>
&gt; &#43; *<br>
&gt; &#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY O=
F ANY KIND, EXPRESS OR<br>
&gt; &#43; * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHA=
NTABILITY,<br>
&gt; &#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN=
 NO EVENT SHALL<br>
&gt; &#43; * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, =
DAMAGES OR<br>
&gt; &#43; * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTH=
ERWISE,<br>
&gt; &#43; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE=
 USE OR<br>
&gt; &#43; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt; &#43; *<br>
&gt; &#43; * Authors: AMD<br>
&gt; &#43; *<br>
&gt; &#43; */<br>
&gt; &#43;<br>
&gt; &#43;#ifndef __DAL_ENGINE_H__<br>
&gt; &#43;#define __DAL_ENGINE_H__<br>
&gt; &#43;<br>
&gt; &#43;#include &quot;dc_ddc_types.h&quot;<br>
&gt; &#43;<br>
&gt; &#43;enum i2caux_transaction_operation {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_READ,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_WRITE<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;enum i2caux_transaction_address_space {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_S=
PACE_I2C =3D 1,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_ADDRESS_S=
PACE_DPCD<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;struct i2caux_transaction_payload {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum i2caux_transaction_addr=
ess_space address_space;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t address;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t length;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t *data;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;enum i2caux_transaction_status {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_UN=
KNOWN =3D (-1L),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_SU=
CCEEDED,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_CHANNEL_BUSY,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_TIMEOUT,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_PROTOCOL_ERROR,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_NACK,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_INCOMPLETE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_OPERATION,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_INVALID_OPERATION,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_BUFFER_OVERFLOW,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_TRANSACTION_STATUS_FA=
ILED_HPD_DISCON<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;struct i2caux_transaction_request {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum i2caux_transaction_oper=
ation operation;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2caux_transaction_pa=
yload payload;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum i2caux_transaction_stat=
us status;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;enum i2caux_engine_type {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_ENGINE_TYPE_UNKNOWN =
=3D (-1L),<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_ENGINE_TYPE_AUX,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_ENGINE_TYPE_I2C_DDC_H=
W,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_ENGINE_TYPE_I2C_GENER=
IC_HW,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_ENGINE_TYPE_I2C_SW<br=
>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;enum i2c_default_speed {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_DEFAULT_I2C_HW_SPEED =
=3D 50,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I2CAUX_DEFAULT_I2C_SW_SPEED =
=3D 50<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;struct engine;<br>
&gt; &#43;<br>
&gt; &#43;struct engine_funcs {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum i2caux_engine_type (*ge=
t_engine_type)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; const struct engine *engine);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct aux_engine* (*acquire=
)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct ddc *ddc);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool (*submit_request)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct engine *engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct i2caux_transaction_request *request,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bool middle_of_transaction);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*release_engine)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct engine *engine);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*destroy_engine)(<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct engine **engine);<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;struct engine {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct engine_funcs *f=
uncs;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t inst;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ddc *ddc;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dc_context *ctx;<br>
&gt; &#43;};<br>
&gt; &#43;<br>
&gt; &#43;#endif<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_MW2PR12MB258871F6CE41BD2726C6D1C0F95C0MW2PR12MB2588namp_--

--===============0889784654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0889784654==--
