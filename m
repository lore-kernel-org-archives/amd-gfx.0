From: Mike Lothian <mike-4+n8WJKc9ve9FHfhHBbuYA@public.gmane.org>
Subject: Re: [PATCH 063/100] drm/amd/display: Add DCE12 bios parser support
Date: Thu, 03 Aug 2017 21:04:12 +0000
Message-ID: <CAHbf0-Fi5VBRjXJ53AgdHE3vv4PoLqtxXa2EFK_wO21peK6cTw@mail.gmail.com>
References: <1490041835-11255-1-git-send-email-alexander.deucher@amd.com>
 <1490041835-11255-49-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0016315626=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490041835-11255-49-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>

--===============0016315626==
Content-Type: multipart/alternative; boundary="94eb2c112c3e9b79ce0555dfb991"

--94eb2c112c3e9b79ce0555dfb991
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I've just tested out the new amd-staging-drm-next branch and noticed the
following warning caused by this patch

drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c: In function
=E2=80=98get_embedded_panel_info_v2_1=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c:1335:3:
warning: overflow in implicit constant conversion [-Woverflow]
   lvds->lcd_timing.miscinfo & ATOM_INTERLACE;
   ^~~~

Cheers

Mike

On Mon, 20 Mar 2017 at 20:35 Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
>
> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2085
> ++++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.h |   33 +
>  .../display/dc/bios/bios_parser_types_internal2.h  |   74 +
>  .../gpu/drm/amd/display/dc/bios/command_table2.c   |  813 ++++++++
>  .../gpu/drm/amd/display/dc/bios/command_table2.h   |  105 +
>  .../amd/display/dc/bios/command_table_helper2.c    |  260 +++
>  .../amd/display/dc/bios/command_table_helper2.h    |   82 +
>  .../dc/bios/dce112/command_table_helper2_dce112.c  |  418 ++++
>  .../dc/bios/dce112/command_table_helper2_dce112.h  |   34 +
>  9 files changed, 3904 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/bios/bios_parser_types_internal2.h
>  create mode 100644 drivers/gpu/drm/amd/display/dc/bios/command_table2.c
>  create mode 100644 drivers/gpu/drm/amd/display/dc/bios/command_table2.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.h
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.c
>  create mode 100644
> drivers/gpu/drm/amd/display/dc/bios/dce112/command_table_helper2_dce112.h
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> new file mode 100644
> index 0000000..f6e77da
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -0,0 +1,2085 @@
> +/*
> + * Copyright 2012-15 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"),
> + * to deal in the Software without restriction, including without
> limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
> SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES
> OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include "dm_services.h"
> +
> +#define _BIOS_PARSER_2_
> +
> +#include "ObjectID.h"
> +#include "atomfirmware.h"
> +#include "atomfirmwareid.h"
> +
> +#include "dc_bios_types.h"
> +#include "include/grph_object_ctrl_defs.h"
> +#include "include/bios_parser_interface.h"
> +#include "include/i2caux_interface.h"
> +#include "include/logger_interface.h"
> +
> +#include "command_table2.h"
> +
> +#include "bios_parser_helper.h"
> +#include "command_table_helper2.h"
> +#include "bios_parser2.h"
> +#include "bios_parser_types_internal2.h"
> +#include "bios_parser_interface.h"
> +
> +#define LAST_RECORD_TYPE 0xff
> +
> +
> +struct i2c_id_config_access {
> +       uint8_t bfI2C_LineMux:4;
> +       uint8_t bfHW_EngineID:3;
> +       uint8_t bfHW_Capable:1;
> +       uint8_t ucAccess;
> +};
> +
> +static enum object_type object_type_from_bios_object_id(
> +       uint32_t bios_object_id);
> +
> +static enum object_enum_id enum_id_from_bios_object_id(uint32_t
> bios_object_id);
> +
> +static struct graphics_object_id object_id_from_bios_object_id(
> +       uint32_t bios_object_id);
> +
> +static uint32_t id_from_bios_object_id(enum object_type type,
> +       uint32_t bios_object_id);
> +
> +static uint32_t gpu_id_from_bios_object_id(uint32_t bios_object_id);
> +
> +static enum encoder_id encoder_id_from_bios_object_id(uint32_t
> bios_object_id);
> +
> +static enum connector_id connector_id_from_bios_object_id(
> +                                               uint32_t bios_object_id);
> +
> +static enum generic_id generic_id_from_bios_object_id(uint32_t
> bios_object_id);
> +
> +static enum bp_result get_gpio_i2c_info(struct bios_parser *bp,
> +       struct atom_i2c_record *record,
> +       struct graphics_object_i2c_info *info);
> +
> +static enum bp_result bios_parser_get_firmware_info(
> +       struct dc_bios *dcb,
> +       struct firmware_info *info);
> +
> +static enum bp_result bios_parser_get_encoder_cap_info(
> +       struct dc_bios *dcb,
> +       struct graphics_object_id object_id,
> +       struct bp_encoder_cap_info *info);
> +
> +static enum bp_result get_firmware_info_v3_1(
> +       struct bios_parser *bp,
> +       struct firmware_info *info);
> +
> +static struct atom_hpd_int_record *get_hpd_record(struct bios_parser *bp=
,
> +               struct atom_display_object_path_v2 *object);
> +
> +static struct atom_encoder_caps_record *get_encoder_cap_record(
> +       struct bios_parser *bp,
> +       struct atom_display_object_path_v2 *object);
> +
> +#define BIOS_IMAGE_SIZE_OFFSET 2
> +#define BIOS_IMAGE_SIZE_UNIT 512
> +
> +#define DATA_TABLES(table) (bp->master_data_tbl->listOfdatatables.table)
> +
> +
> +static void destruct(struct bios_parser *bp)
> +{
> +       if (bp->base.bios_local_image)
> +               dm_free(bp->base.bios_local_image);
> +
> +       if (bp->base.integrated_info)
> +               dm_free(bp->base.integrated_info);
> +}
> +
> +static void firmware_parser_destroy(struct dc_bios **dcb)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(*dcb);
> +
> +       if (!bp) {
> +               BREAK_TO_DEBUGGER();
> +               return;
> +       }
> +
> +       destruct(bp);
> +
> +       dm_free(bp);
> +       *dcb =3D NULL;
> +}
> +
> +static void get_atom_data_table_revision(
> +       struct atom_common_table_header *atom_data_tbl,
> +       struct atom_data_revision *tbl_revision)
> +{
> +       if (!tbl_revision)
> +               return;
> +
> +       /* initialize the revision to 0 which is invalid revision */
> +       tbl_revision->major =3D 0;
> +       tbl_revision->minor =3D 0;
> +
> +       if (!atom_data_tbl)
> +               return;
> +
> +       tbl_revision->major =3D
> +                       (uint32_t) atom_data_tbl->format_revision & 0x3f;
> +       tbl_revision->minor =3D
> +                       (uint32_t) atom_data_tbl->content_revision & 0x3f=
;
> +}
> +
> +static struct graphics_object_id object_id_from_bios_object_id(
> +       uint32_t bios_object_id)
> +{
> +       enum object_type type;
> +       enum object_enum_id enum_id;
> +       struct graphics_object_id go_id =3D { 0 };
> +
> +       type =3D object_type_from_bios_object_id(bios_object_id);
> +
> +       if (type =3D=3D OBJECT_TYPE_UNKNOWN)
> +               return go_id;
> +
> +       enum_id =3D enum_id_from_bios_object_id(bios_object_id);
> +
> +       if (enum_id =3D=3D ENUM_ID_UNKNOWN)
> +               return go_id;
> +
> +       go_id =3D dal_graphics_object_id_init(
> +                       id_from_bios_object_id(type, bios_object_id),
> +                                                               enum_id,
> type);
> +
> +       return go_id;
> +}
> +
> +static enum object_type object_type_from_bios_object_id(uint32_t
> bios_object_id)
> +{
> +       uint32_t bios_object_type =3D (bios_object_id & OBJECT_TYPE_MASK)
> +                               >> OBJECT_TYPE_SHIFT;
> +       enum object_type object_type;
> +
> +       switch (bios_object_type) {
> +       case GRAPH_OBJECT_TYPE_GPU:
> +               object_type =3D OBJECT_TYPE_GPU;
> +               break;
> +       case GRAPH_OBJECT_TYPE_ENCODER:
> +               object_type =3D OBJECT_TYPE_ENCODER;
> +               break;
> +       case GRAPH_OBJECT_TYPE_CONNECTOR:
> +               object_type =3D OBJECT_TYPE_CONNECTOR;
> +               break;
> +       case GRAPH_OBJECT_TYPE_ROUTER:
> +               object_type =3D OBJECT_TYPE_ROUTER;
> +               break;
> +       case GRAPH_OBJECT_TYPE_GENERIC:
> +               object_type =3D OBJECT_TYPE_GENERIC;
> +               break;
> +       default:
> +               object_type =3D OBJECT_TYPE_UNKNOWN;
> +               break;
> +       }
> +
> +       return object_type;
> +}
> +
> +static enum object_enum_id enum_id_from_bios_object_id(uint32_t
> bios_object_id)
> +{
> +       uint32_t bios_enum_id =3D
> +                       (bios_object_id & ENUM_ID_MASK) >> ENUM_ID_SHIFT;
> +       enum object_enum_id id;
> +
> +       switch (bios_enum_id) {
> +       case GRAPH_OBJECT_ENUM_ID1:
> +               id =3D ENUM_ID_1;
> +               break;
> +       case GRAPH_OBJECT_ENUM_ID2:
> +               id =3D ENUM_ID_2;
> +               break;
> +       case GRAPH_OBJECT_ENUM_ID3:
> +               id =3D ENUM_ID_3;
> +               break;
> +       case GRAPH_OBJECT_ENUM_ID4:
> +               id =3D ENUM_ID_4;
> +               break;
> +       case GRAPH_OBJECT_ENUM_ID5:
> +               id =3D ENUM_ID_5;
> +               break;
> +       case GRAPH_OBJECT_ENUM_ID6:
> +               id =3D ENUM_ID_6;
> +               break;
> +       case GRAPH_OBJECT_ENUM_ID7:
> +               id =3D ENUM_ID_7;
> +               break;
> +       default:
> +               id =3D ENUM_ID_UNKNOWN;
> +               break;
> +       }
> +
> +       return id;
> +}
> +
> +static uint32_t id_from_bios_object_id(enum object_type type,
> +       uint32_t bios_object_id)
> +{
> +       switch (type) {
> +       case OBJECT_TYPE_GPU:
> +               return gpu_id_from_bios_object_id(bios_object_id);
> +       case OBJECT_TYPE_ENCODER:
> +               return
> (uint32_t)encoder_id_from_bios_object_id(bios_object_id);
> +       case OBJECT_TYPE_CONNECTOR:
> +               return (uint32_t)connector_id_from_bios_object_id(
> +                               bios_object_id);
> +       case OBJECT_TYPE_GENERIC:
> +               return generic_id_from_bios_object_id(bios_object_id);
> +       default:
> +               return 0;
> +       }
> +}
> +
> +uint32_t gpu_id_from_bios_object_id(uint32_t bios_object_id)
> +{
> +       return (bios_object_id & OBJECT_ID_MASK) >> OBJECT_ID_SHIFT;
> +}
> +
> +static enum encoder_id encoder_id_from_bios_object_id(uint32_t
> bios_object_id)
> +{
> +       uint32_t bios_encoder_id =3D
> gpu_id_from_bios_object_id(bios_object_id);
> +       enum encoder_id id;
> +
> +       switch (bios_encoder_id) {
> +       case ENCODER_OBJECT_ID_INTERNAL_LVDS:
> +               id =3D ENCODER_ID_INTERNAL_LVDS;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_TMDS1:
> +               id =3D ENCODER_ID_INTERNAL_TMDS1;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_TMDS2:
> +               id =3D ENCODER_ID_INTERNAL_TMDS2;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_DAC1:
> +               id =3D ENCODER_ID_INTERNAL_DAC1;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_DAC2:
> +               id =3D ENCODER_ID_INTERNAL_DAC2;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_LVTM1:
> +               id =3D ENCODER_ID_INTERNAL_LVTM1;
> +               break;
> +       case ENCODER_OBJECT_ID_HDMI_INTERNAL:
> +               id =3D ENCODER_ID_INTERNAL_HDMI;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_TMDS1:
> +               id =3D ENCODER_ID_INTERNAL_KLDSCP_TMDS1;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_DAC1:
> +               id =3D ENCODER_ID_INTERNAL_KLDSCP_DAC1;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_DAC2:
> +               id =3D ENCODER_ID_INTERNAL_KLDSCP_DAC2;
> +               break;
> +       case ENCODER_OBJECT_ID_MVPU_FPGA:
> +               id =3D ENCODER_ID_EXTERNAL_MVPU_FPGA;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_DDI:
> +               id =3D ENCODER_ID_INTERNAL_DDI;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
> +               id =3D ENCODER_ID_INTERNAL_UNIPHY;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_KLDSCP_LVTMA:
> +               id =3D ENCODER_ID_INTERNAL_KLDSCP_LVTMA;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
> +               id =3D ENCODER_ID_INTERNAL_UNIPHY1;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
> +               id =3D ENCODER_ID_INTERNAL_UNIPHY2;
> +               break;
> +       case ENCODER_OBJECT_ID_ALMOND: /* ENCODER_OBJECT_ID_NUTMEG */
> +               id =3D ENCODER_ID_EXTERNAL_NUTMEG;
> +               break;
> +       case ENCODER_OBJECT_ID_TRAVIS:
> +               id =3D ENCODER_ID_EXTERNAL_TRAVIS;
> +               break;
> +       case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
> +               id =3D ENCODER_ID_INTERNAL_UNIPHY3;
> +               break;
> +       default:
> +               id =3D ENCODER_ID_UNKNOWN;
> +               ASSERT(0);
> +               break;
> +       }
> +
> +       return id;
> +}
> +
> +static enum connector_id connector_id_from_bios_object_id(
> +       uint32_t bios_object_id)
> +{
> +       uint32_t bios_connector_id =3D
> gpu_id_from_bios_object_id(bios_object_id);
> +
> +       enum connector_id id;
> +
> +       switch (bios_connector_id) {
> +       case CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_I:
> +               id =3D CONNECTOR_ID_SINGLE_LINK_DVII;
> +               break;
> +       case CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I:
> +               id =3D CONNECTOR_ID_DUAL_LINK_DVII;
> +               break;
> +       case CONNECTOR_OBJECT_ID_SINGLE_LINK_DVI_D:
> +               id =3D CONNECTOR_ID_SINGLE_LINK_DVID;
> +               break;
> +       case CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D:
> +               id =3D CONNECTOR_ID_DUAL_LINK_DVID;
> +               break;
> +       case CONNECTOR_OBJECT_ID_VGA:
> +               id =3D CONNECTOR_ID_VGA;
> +               break;
> +       case CONNECTOR_OBJECT_ID_HDMI_TYPE_A:
> +               id =3D CONNECTOR_ID_HDMI_TYPE_A;
> +               break;
> +       case CONNECTOR_OBJECT_ID_LVDS:
> +               id =3D CONNECTOR_ID_LVDS;
> +               break;
> +       case CONNECTOR_OBJECT_ID_PCIE_CONNECTOR:
> +               id =3D CONNECTOR_ID_PCIE;
> +               break;
> +       case CONNECTOR_OBJECT_ID_HARDCODE_DVI:
> +               id =3D CONNECTOR_ID_HARDCODE_DVI;
> +               break;
> +       case CONNECTOR_OBJECT_ID_DISPLAYPORT:
> +               id =3D CONNECTOR_ID_DISPLAY_PORT;
> +               break;
> +       case CONNECTOR_OBJECT_ID_eDP:
> +               id =3D CONNECTOR_ID_EDP;
> +               break;
> +       case CONNECTOR_OBJECT_ID_MXM:
> +               id =3D CONNECTOR_ID_MXM;
> +               break;
> +       default:
> +               id =3D CONNECTOR_ID_UNKNOWN;
> +               break;
> +       }
> +
> +       return id;
> +}
> +
> +enum generic_id generic_id_from_bios_object_id(uint32_t bios_object_id)
> +{
> +       uint32_t bios_generic_id =3D
> gpu_id_from_bios_object_id(bios_object_id);
> +
> +       enum generic_id id;
> +
> +       switch (bios_generic_id) {
> +       case GENERIC_OBJECT_ID_MXM_OPM:
> +               id =3D GENERIC_ID_MXM_OPM;
> +               break;
> +       case GENERIC_OBJECT_ID_GLSYNC:
> +               id =3D GENERIC_ID_GLSYNC;
> +               break;
> +       case GENERIC_OBJECT_ID_STEREO_PIN:
> +               id =3D GENERIC_ID_STEREO;
> +               break;
> +       default:
> +               id =3D GENERIC_ID_UNKNOWN;
> +               break;
> +       }
> +
> +       return id;
> +}
> +
> +static uint8_t bios_parser_get_connectors_number(struct dc_bios *dcb)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       unsigned int count =3D 0;
> +       unsigned int i;
> +
> +       for (i =3D 0; i < bp->object_info_tbl.v1_4->number_of_path; i++) =
{
> +               if (bp->object_info_tbl.v1_4->display_path[i].encoderobji=
d
> !=3D 0
> +                               &&
> +               bp->object_info_tbl.v1_4->display_path[i].display_objid !=
=3D
> 0)
> +                       count++;
> +       }
> +       return count;
> +}
> +
> +static struct graphics_object_id bios_parser_get_encoder_id(
> +       struct dc_bios *dcb,
> +       uint32_t i)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       struct graphics_object_id object_id =3D dal_graphics_object_id_in=
it(
> +               0, ENUM_ID_UNKNOWN, OBJECT_TYPE_UNKNOWN);
> +
> +       if (bp->object_info_tbl.v1_4->number_of_path > i)
> +               object_id =3D object_id_from_bios_object_id(
> +               bp->object_info_tbl.v1_4->display_path[i].encoderobjid);
> +
> +       return object_id;
> +}
> +
> +static struct graphics_object_id bios_parser_get_connector_id(
> +       struct dc_bios *dcb,
> +       uint8_t i)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       struct graphics_object_id object_id =3D dal_graphics_object_id_in=
it(
> +               0, ENUM_ID_UNKNOWN, OBJECT_TYPE_UNKNOWN);
> +       struct object_info_table *tbl =3D &bp->object_info_tbl;
> +       struct display_object_info_table_v1_4 *v1_4 =3D tbl->v1_4;
> +
> +       if (v1_4->number_of_path > i) {
> +               /* If display_objid is generic object id,  the encoderObj
> +                * /extencoderobjId should be 0
> +                */
> +               if (v1_4->display_path[i].encoderobjid !=3D 0 &&
> +                               v1_4->display_path[i].display_objid !=3D =
0)
> +                       object_id =3D object_id_from_bios_object_id(
> +
>  v1_4->display_path[i].display_objid);
> +       }
> +
> +       return object_id;
> +}
> +
> +
> +/*  TODO:  GetNumberOfSrc*/
> +
> +static uint32_t bios_parser_get_dst_number(struct dc_bios *dcb,
> +       struct graphics_object_id id)
> +{
> +       /* connector has 1 Dest, encoder has 0 Dest */
> +       switch (id.type) {
> +       case OBJECT_TYPE_ENCODER:
> +               return 0;
> +       case OBJECT_TYPE_CONNECTOR:
> +               return 1;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +/*  removed getSrcObjList, getDestObjList*/
> +
> +
> +static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
> +       struct graphics_object_id object_id, uint32_t index,
> +       struct graphics_object_id *src_object_id)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       unsigned int i;
> +       enum bp_result  bp_result =3D BP_RESULT_BADINPUT;
> +       struct graphics_object_id obj_id =3D {0};
> +       struct object_info_table *tbl =3D &bp->object_info_tbl;
> +
> +       if (!src_object_id)
> +               return bp_result;
> +
> +       switch (object_id.type) {
> +       /* Encoder's Source is GPU.  BIOS does not provide GPU, since all
> +        * displaypaths point to same GPU (0x1100).  Hardcode GPU object
> type
> +        */
> +       case OBJECT_TYPE_ENCODER:
> +               /* TODO: since num of src must be less than 2.
> +                * If found in for loop, should break.
> +                * DAL2 implementation may be changed too
> +                */
> +               for (i =3D 0; i < tbl->v1_4->number_of_path; i++) {
> +                       obj_id =3D object_id_from_bios_object_id(
> +                       tbl->v1_4->display_path[i].encoderobjid);
> +                       if (object_id.type =3D=3D obj_id.type &&
> +                                       object_id.id =3D=3D obj_id.id &&
> +                                               object_id.enum_id =3D=3D
> +                                                       obj_id.enum_id) {
> +                               *src_object_id =3D
> +                               object_id_from_bios_object_id(0x1100);
> +                               /* break; */
> +                       }
> +               }
> +               bp_result =3D BP_RESULT_OK;
> +               break;
> +       case OBJECT_TYPE_CONNECTOR:
> +               for (i =3D 0; i < tbl->v1_4->number_of_path; i++) {
> +                       obj_id =3D object_id_from_bios_object_id(
> +                               tbl->v1_4->display_path[i].display_objid)=
;
> +
> +                       if (object_id.type =3D=3D obj_id.type &&
> +                               object_id.id =3D=3D obj_id.id &&
> +                                       object_id.enum_id =3D=3D
> obj_id.enum_id) {
> +                               *src_object_id =3D
> +                               object_id_from_bios_object_id(
> +                               tbl->v1_4->display_path[i].encoderobjid);
> +                               /* break; */
> +                       }
> +               }
> +               bp_result =3D BP_RESULT_OK;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return bp_result;
> +}
> +
> +static enum bp_result bios_parser_get_dst_obj(struct dc_bios *dcb,
> +       struct graphics_object_id object_id, uint32_t index,
> +       struct graphics_object_id *dest_object_id)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       unsigned int i;
> +       enum bp_result  bp_result =3D BP_RESULT_BADINPUT;
> +       struct graphics_object_id obj_id =3D {0};
> +       struct object_info_table *tbl =3D &bp->object_info_tbl;
> +
> +       if (!dest_object_id)
> +               return BP_RESULT_BADINPUT;
> +
> +       switch (object_id.type) {
> +       case OBJECT_TYPE_ENCODER:
> +               /* TODO: since num of src must be less than 2.
> +                * If found in for loop, should break.
> +                * DAL2 implementation may be changed too
> +                */
> +               for (i =3D 0; i < tbl->v1_4->number_of_path; i++) {
> +                       obj_id =3D object_id_from_bios_object_id(
> +                               tbl->v1_4->display_path[i].encoderobjid);
> +                       if (object_id.type =3D=3D obj_id.type &&
> +                                       object_id.id =3D=3D obj_id.id &&
> +                                               object_id.enum_id =3D=3D
> +                                                       obj_id.enum_id) {
> +                               *dest_object_id =3D
> +                                       object_id_from_bios_object_id(
> +                               tbl->v1_4->display_path[i].display_objid)=
;
> +                               /* break; */
> +                       }
> +               }
> +               bp_result =3D BP_RESULT_OK;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return bp_result;
> +}
> +
> +
> +/* from graphics_object_id, find display path which includes the
> object_id */
> +static struct atom_display_object_path_v2 *get_bios_object(
> +       struct bios_parser *bp,
> +       struct graphics_object_id id)
> +{
> +       unsigned int i;
> +       struct graphics_object_id obj_id =3D {0};
> +
> +       switch (id.type) {
> +       case OBJECT_TYPE_ENCODER:
> +               for (i =3D 0; i < bp->object_info_tbl.v1_4->number_of_pat=
h;
> i++) {
> +                       obj_id =3D object_id_from_bios_object_id(
> +
>  bp->object_info_tbl.v1_4->display_path[i].encoderobjid);
> +                       if (id.type =3D=3D obj_id.type &&
> +                                       id.id =3D=3D obj_id.id &&
> +                                               id.enum_id =3D=3D
> obj_id.enum_id)
> +                               return
> +                               &bp->object_info_tbl.v1_4->display_path[i=
];
> +               }
> +       case OBJECT_TYPE_CONNECTOR:
> +       case OBJECT_TYPE_GENERIC:
> +               /* Both Generic and Connector Object ID
> +                * will be stored on display_objid
> +               */
> +               for (i =3D 0; i < bp->object_info_tbl.v1_4->number_of_pat=
h;
> i++) {
> +                       obj_id =3D object_id_from_bios_object_id(
> +
>  bp->object_info_tbl.v1_4->display_path[i].display_objid
> +                       );
> +                       if (id.type =3D=3D obj_id.type &&
> +                                       id.id =3D=3D obj_id.id &&
> +                                               id.enum_id =3D=3D
> obj_id.enum_id)
> +                               return
> +                               &bp->object_info_tbl.v1_4->display_path[i=
];
> +               }
> +       default:
> +               return NULL;
> +       }
> +}
> +
> +static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
> +       struct graphics_object_id id,
> +       struct graphics_object_i2c_info *info)
> +{
> +       uint32_t offset;
> +       struct atom_display_object_path_v2 *object;
> +       struct atom_common_record_header *header;
> +       struct atom_i2c_record *record;
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!info)
> +               return BP_RESULT_BADINPUT;
> +
> +       object =3D get_bios_object(bp, id);
> +
> +       if (!object)
> +               return BP_RESULT_BADINPUT;
> +
> +       offset =3D object->disp_recordoffset + bp->object_info_tbl_offset=
;
> +
> +       for (;;) {
> +               header =3D GET_IMAGE(struct atom_common_record_header,
> offset);
> +
> +               if (!header)
> +                       return BP_RESULT_BADBIOSTABLE;
> +
> +               if (header->record_type =3D=3D LAST_RECORD_TYPE ||
> +                       !header->record_size)
> +                       break;
> +
> +               if (header->record_type =3D=3D ATOM_I2C_RECORD_TYPE
> +                       && sizeof(struct atom_i2c_record) <=3D
> +
>  header->record_size) {
> +                       /* get the I2C info */
> +                       record =3D (struct atom_i2c_record *) header;
> +
> +                       if (get_gpio_i2c_info(bp, record, info) =3D=3D
> +
>  BP_RESULT_OK)
> +                               return BP_RESULT_OK;
> +               }
> +
> +               offset +=3D header->record_size;
> +       }
> +
> +       return BP_RESULT_NORECORD;
> +}
> +
> +static enum bp_result get_gpio_i2c_info(
> +       struct bios_parser *bp,
> +       struct atom_i2c_record *record,
> +       struct graphics_object_i2c_info *info)
> +{
> +       struct atom_gpio_pin_lut_v2_1 *header;
> +       uint32_t count =3D 0;
> +       unsigned int table_index =3D 0;
> +
> +       if (!info)
> +               return BP_RESULT_BADINPUT;
> +
> +       /* get the GPIO_I2C info */
> +       if (!DATA_TABLES(gpio_pin_lut))
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       header =3D GET_IMAGE(struct atom_gpio_pin_lut_v2_1,
> +                                       DATA_TABLES(gpio_pin_lut));
> +       if (!header)
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       if (sizeof(struct atom_common_table_header) +
> +                       sizeof(struct atom_gpio_pin_assignment) >
> +                       le16_to_cpu(header->table_header.structuresize))
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       /* TODO: is version change? */
> +       if (header->table_header.content_revision !=3D 1)
> +               return BP_RESULT_UNSUPPORTED;
> +
> +       /* get data count */
> +       count =3D (le16_to_cpu(header->table_header.structuresize)
> +                       - sizeof(struct atom_common_table_header))
> +                               / sizeof(struct atom_gpio_pin_assignment)=
;
> +
> +       table_index =3D record->i2c_id  & I2C_HW_LANE_MUX;
> +
> +       if (count < table_index) {
> +               bool find_valid =3D false;
> +
> +               for (table_index =3D 0; table_index < count; table_index+=
+) {
> +                       if (((record->i2c_id & I2C_HW_CAP) =3D=3D (
> +                       header->gpio_pin[table_index].gpio_id &
> +                                                       I2C_HW_CAP)) &&
> +                       ((record->i2c_id & I2C_HW_ENGINE_ID_MASK)  =3D=3D
> +                       (header->gpio_pin[table_index].gpio_id &
> +                                               I2C_HW_ENGINE_ID_MASK)) &=
&
> +                       ((record->i2c_id & I2C_HW_LANE_MUX) =3D=3D
> +                       (header->gpio_pin[table_index].gpio_id &
> +                                                       I2C_HW_LANE_MUX))=
)
> {
> +                               /* still valid */
> +                               find_valid =3D true;
> +                               break;
> +                       }
> +               }
> +               /* If we don't find the entry that we are looking for the=
n
> +                *  we will return BP_Result_BadBiosTable.
> +                */
> +               if (find_valid =3D=3D false)
> +                       return BP_RESULT_BADBIOSTABLE;
> +       }
> +
> +       /* get the GPIO_I2C_INFO */
> +       info->i2c_hw_assist =3D (record->i2c_id & I2C_HW_CAP) ? true : fa=
lse;
> +       info->i2c_line =3D record->i2c_id & I2C_HW_LANE_MUX;
> +       info->i2c_engine_id =3D (record->i2c_id & I2C_HW_ENGINE_ID_MASK) =
>>
> 4;
> +       info->i2c_slave_address =3D record->i2c_slave_addr;
> +
> +       /* TODO: check how to get register offset for en, Y, etc. */
> +       info->gpio_info.clk_a_register_index =3D
> +                       le16_to_cpu(
> +                       header->gpio_pin[table_index].data_a_reg_index);
> +       info->gpio_info.clk_a_shift =3D
> +                       header->gpio_pin[table_index].gpio_bitshift;
> +
> +       return BP_RESULT_OK;
> +}
> +
> +static enum bp_result get_voltage_ddc_info_v4(
> +       uint8_t *i2c_line,
> +       uint32_t index,
> +       struct atom_common_table_header *header,
> +       uint8_t *address)
> +{
> +       enum bp_result result =3D BP_RESULT_NORECORD;
> +       struct atom_voltage_objects_info_v4_1 *info =3D
> +               (struct atom_voltage_objects_info_v4_1 *) address;
> +
> +       uint8_t *voltage_current_object =3D
> +               (uint8_t *) (&(info->voltage_object[0]));
> +
> +       while ((address + le16_to_cpu(header->structuresize)) >
> +                                               voltage_current_object) {
> +               struct atom_i2c_voltage_object_v4 *object =3D
> +                       (struct atom_i2c_voltage_object_v4 *)
> +                                               voltage_current_object;
> +
> +               if (object->header.voltage_mode =3D=3D
> +                       ATOM_INIT_VOLTAGE_REGULATOR) {
> +                       if (object->header.voltage_type =3D=3D index) {
> +                               *i2c_line =3D object->i2c_id ^ 0x90;
> +                               result =3D BP_RESULT_OK;
> +                               break;
> +                       }
> +               }
> +
> +               voltage_current_object +=3D
> +                               le16_to_cpu(object->header.object_size);
> +       }
> +       return result;
> +}
> +
> +static enum bp_result bios_parser_get_thermal_ddc_info(
> +       struct dc_bios *dcb,
> +       uint32_t i2c_channel_id,
> +       struct graphics_object_i2c_info *info)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       struct i2c_id_config_access *config;
> +       struct atom_i2c_record record;
> +
> +       if (!info)
> +               return BP_RESULT_BADINPUT;
> +
> +       config =3D (struct i2c_id_config_access *) &i2c_channel_id;
> +
> +       record.i2c_id =3D config->bfHW_Capable;
> +       record.i2c_id |=3D config->bfI2C_LineMux;
> +       record.i2c_id |=3D config->bfHW_EngineID;
> +
> +       return get_gpio_i2c_info(bp, &record, info);
> +}
> +
> +static enum bp_result bios_parser_get_voltage_ddc_info(struct dc_bios
> *dcb,
> +       uint32_t index,
> +       struct graphics_object_i2c_info *info)
> +{
> +       uint8_t i2c_line =3D 0;
> +       enum bp_result result =3D BP_RESULT_NORECORD;
> +       uint8_t *voltage_info_address;
> +       struct atom_common_table_header *header;
> +       struct atom_data_revision revision =3D {0};
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!DATA_TABLES(voltageobject_info))
> +               return result;
> +
> +       voltage_info_address =3D get_image(&bp->base,
> +                       DATA_TABLES(voltageobject_info),
> +                       sizeof(struct atom_common_table_header));
> +
> +       header =3D (struct atom_common_table_header *) voltage_info_addre=
ss;
> +
> +       get_atom_data_table_revision(header, &revision);
> +
> +       switch (revision.major) {
> +       case 4:
> +               if (revision.minor !=3D 1)
> +                       break;
> +               result =3D get_voltage_ddc_info_v4(&i2c_line, index, head=
er,
> +                       voltage_info_address);
> +               break;
> +       }
> +
> +       if (result =3D=3D BP_RESULT_OK)
> +               result =3D bios_parser_get_thermal_ddc_info(dcb,
> +                       i2c_line, info);
> +
> +       return result;
> +}
> +
> +static enum bp_result bios_parser_get_hpd_info(
> +       struct dc_bios *dcb,
> +       struct graphics_object_id id,
> +       struct graphics_object_hpd_info *info)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       struct atom_display_object_path_v2 *object;
> +       struct atom_hpd_int_record *record =3D NULL;
> +
> +       if (!info)
> +               return BP_RESULT_BADINPUT;
> +
> +       object =3D get_bios_object(bp, id);
> +
> +       if (!object)
> +               return BP_RESULT_BADINPUT;
> +
> +       record =3D get_hpd_record(bp, object);
> +
> +       if (record !=3D NULL) {
> +               info->hpd_int_gpio_uid =3D record->pin_id;
> +               info->hpd_active =3D record->plugin_pin_state;
> +               return BP_RESULT_OK;
> +       }
> +
> +       return BP_RESULT_NORECORD;
> +}
> +
> +static struct atom_hpd_int_record *get_hpd_record(
> +       struct bios_parser *bp,
> +       struct atom_display_object_path_v2 *object)
> +{
> +       struct atom_common_record_header *header;
> +       uint32_t offset;
> +
> +       if (!object) {
> +               BREAK_TO_DEBUGGER(); /* Invalid object */
> +               return NULL;
> +       }
> +
> +       offset =3D le16_to_cpu(object->disp_recordoffset)
> +                       + bp->object_info_tbl_offset;
> +
> +       for (;;) {
> +               header =3D GET_IMAGE(struct atom_common_record_header,
> offset);
> +
> +               if (!header)
> +                       return NULL;
> +
> +               if (header->record_type =3D=3D LAST_RECORD_TYPE ||
> +                       !header->record_size)
> +                       break;
> +
> +               if (header->record_type =3D=3D ATOM_HPD_INT_RECORD_TYPE
> +                       && sizeof(struct atom_hpd_int_record) <=3D
> +
>  header->record_size)
> +                       return (struct atom_hpd_int_record *) header;
> +
> +               offset +=3D header->record_size;
> +       }
> +
> +       return NULL;
> +}
> +
> +/**
> + * bios_parser_get_gpio_pin_info
> + * Get GpioPin information of input gpio id
> + *
> + * @param gpio_id, GPIO ID
> + * @param info, GpioPin information structure
> + * @return Bios parser result code
> + * @note
> + *  to get the GPIO PIN INFO, we need:
> + *  1. get the GPIO_ID from other object table, see GetHPDInfo()
> + *  2. in DATA_TABLE.GPIO_Pin_LUT, search all records,
> + *     to get the registerA  offset/mask
> + */
> +static enum bp_result bios_parser_get_gpio_pin_info(
> +       struct dc_bios *dcb,
> +       uint32_t gpio_id,
> +       struct gpio_pin_info *info)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       struct atom_gpio_pin_lut_v2_1 *header;
> +       uint32_t count =3D 0;
> +       uint32_t i =3D 0;
> +
> +       if (!DATA_TABLES(gpio_pin_lut))
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       header =3D GET_IMAGE(struct atom_gpio_pin_lut_v2_1,
> +                                               DATA_TABLES(gpio_pin_lut)=
);
> +       if (!header)
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       if (sizeof(struct atom_common_table_header) +
> +                       sizeof(struct atom_gpio_pin_lut_v2_1)
> +                       > le16_to_cpu(header->table_header.structuresize)=
)
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       if (header->table_header.content_revision !=3D 1)
> +               return BP_RESULT_UNSUPPORTED;
> +
> +       /* Temporary hard code gpio pin info */
> +#if defined(FOR_SIMNOW_BOOT)
> +       {
> +               struct  atom_gpio_pin_assignment  gpio_pin[8] =3D {
> +                               {0x5db5, 0, 0, 1, 0},
> +                               {0x5db5, 8, 8, 2, 0},
> +                               {0x5db5, 0x10, 0x10, 3, 0},
> +                               {0x5db5, 0x18, 0x14, 4, 0},
> +                               {0x5db5, 0x1A, 0x18, 5, 0},
> +                               {0x5db5, 0x1C, 0x1C, 6, 0},
> +               };
> +
> +               count =3D 6;
> +               memmove(header->gpio_pin, gpio_pin, sizeof(gpio_pin));
> +       }
> +#else
> +       count =3D (le16_to_cpu(header->table_header.structuresize)
> +                       - sizeof(struct atom_common_table_header))
> +                               / sizeof(struct atom_gpio_pin_assignment)=
;
> +#endif
> +       for (i =3D 0; i < count; ++i) {
> +               if (header->gpio_pin[i].gpio_id !=3D gpio_id)
> +                       continue;
> +
> +               info->offset =3D
> +                       (uint32_t) le16_to_cpu(
> +
>  header->gpio_pin[i].data_a_reg_index);
> +               info->offset_y =3D info->offset + 2;
> +               info->offset_en =3D info->offset + 1;
> +               info->offset_mask =3D info->offset - 1;
> +
> +               info->mask =3D (uint32_t) (1 <<
> +                       header->gpio_pin[i].gpio_bitshift);
> +               info->mask_y =3D info->mask + 2;
> +               info->mask_en =3D info->mask + 1;
> +               info->mask_mask =3D info->mask - 1;
> +
> +               return BP_RESULT_OK;
> +       }
> +
> +       return BP_RESULT_NORECORD;
> +}
> +
> +static struct device_id device_type_from_device_id(uint16_t device_id)
> +{
> +
> +       struct device_id result_device_id;
> +
> +       switch (device_id) {
> +       case ATOM_DISPLAY_LCD1_SUPPORT:
> +               result_device_id.device_type =3D DEVICE_TYPE_LCD;
> +               result_device_id.enum_id =3D 1;
> +               break;
> +
> +       case ATOM_DISPLAY_DFP1_SUPPORT:
> +               result_device_id.device_type =3D DEVICE_TYPE_DFP;
> +               result_device_id.enum_id =3D 1;
> +               break;
> +
> +       case ATOM_DISPLAY_DFP2_SUPPORT:
> +               result_device_id.device_type =3D DEVICE_TYPE_DFP;
> +               result_device_id.enum_id =3D 2;
> +               break;
> +
> +       case ATOM_DISPLAY_DFP3_SUPPORT:
> +               result_device_id.device_type =3D DEVICE_TYPE_DFP;
> +               result_device_id.enum_id =3D 3;
> +               break;
> +
> +       case ATOM_DISPLAY_DFP4_SUPPORT:
> +               result_device_id.device_type =3D DEVICE_TYPE_DFP;
> +               result_device_id.enum_id =3D 4;
> +               break;
> +
> +       case ATOM_DISPLAY_DFP5_SUPPORT:
> +               result_device_id.device_type =3D DEVICE_TYPE_DFP;
> +               result_device_id.enum_id =3D 5;
> +               break;
> +
> +       case ATOM_DISPLAY_DFP6_SUPPORT:
> +               result_device_id.device_type =3D DEVICE_TYPE_DFP;
> +               result_device_id.enum_id =3D 6;
> +               break;
> +
> +       default:
> +               BREAK_TO_DEBUGGER(); /* Invalid device Id */
> +               result_device_id.device_type =3D DEVICE_TYPE_UNKNOWN;
> +               result_device_id.enum_id =3D 0;
> +       }
> +       return result_device_id;
> +}
> +
> +static enum bp_result bios_parser_get_device_tag(
> +       struct dc_bios *dcb,
> +       struct graphics_object_id connector_object_id,
> +       uint32_t device_tag_index,
> +       struct connector_device_tag_info *info)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       struct atom_display_object_path_v2 *object;
> +
> +       if (!info)
> +               return BP_RESULT_BADINPUT;
> +
> +       /* getBiosObject will return MXM object */
> +       object =3D get_bios_object(bp, connector_object_id);
> +
> +       if (!object) {
> +               BREAK_TO_DEBUGGER(); /* Invalid object id */
> +               return BP_RESULT_BADINPUT;
> +       }
> +
> +       info->acpi_device =3D 0; /* BIOS no longer provides this */
> +       info->dev_id =3D device_type_from_device_id(object->device_tag);
> +
> +       return BP_RESULT_OK;
> +}
> +
> +static enum bp_result get_ss_info_v4_1(
> +       struct bios_parser *bp,
> +       uint32_t id,
> +       uint32_t index,
> +       struct spread_spectrum_info *ss_info)
> +{
> +       enum bp_result result =3D BP_RESULT_OK;
> +       struct atom_display_controller_info_v4_1 *disp_cntl_tbl =3D NULL;
> +       struct atom_smu_info_v3_1 *smu_tbl =3D NULL;
> +
> +       if (!ss_info)
> +               return BP_RESULT_BADINPUT;
> +
> +       if (!DATA_TABLES(dce_info))
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       if (!DATA_TABLES(smu_info))
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       disp_cntl_tbl =3D  GET_IMAGE(struct
> atom_display_controller_info_v4_1,
> +
>  DATA_TABLES(dce_info));
> +       if (!disp_cntl_tbl)
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       smu_tbl =3D  GET_IMAGE(struct atom_smu_info_v3_1,
> DATA_TABLES(smu_info));
> +       if (!smu_tbl)
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +
> +       ss_info->type.STEP_AND_DELAY_INFO =3D false;
> +       ss_info->spread_percentage_divider =3D 1000;
> +       /* BIOS no longer uses target clock.  Always enable for now */
> +       ss_info->target_clock_range =3D 0xffffffff;
> +
> +       switch (id) {
> +       case AS_SIGNAL_TYPE_DVI:
> +               ss_info->spread_spectrum_percentage =3D
> +                               disp_cntl_tbl->dvi_ss_percentage;
> +               ss_info->spread_spectrum_range =3D
> +                               disp_cntl_tbl->dvi_ss_rate_10hz * 10;
> +               if (disp_cntl_tbl->dvi_ss_mode &
> ATOM_SS_CENTRE_SPREAD_MODE)
> +                       ss_info->type.CENTER_MODE =3D true;
> +               break;
> +       case AS_SIGNAL_TYPE_HDMI:
> +               ss_info->spread_spectrum_percentage =3D
> +                               disp_cntl_tbl->hdmi_ss_percentage;
> +               ss_info->spread_spectrum_range =3D
> +                               disp_cntl_tbl->hdmi_ss_rate_10hz * 10;
> +               if (disp_cntl_tbl->hdmi_ss_mode &
> ATOM_SS_CENTRE_SPREAD_MODE)
> +                       ss_info->type.CENTER_MODE =3D true;
> +               break;
> +       /* TODO LVDS not support anymore? */
> +       case AS_SIGNAL_TYPE_DISPLAY_PORT:
> +               ss_info->spread_spectrum_percentage =3D
> +                               disp_cntl_tbl->dp_ss_percentage;
> +               ss_info->spread_spectrum_range =3D
> +                               disp_cntl_tbl->dp_ss_rate_10hz * 10;
> +               if (disp_cntl_tbl->dp_ss_mode & ATOM_SS_CENTRE_SPREAD_MOD=
E)
> +                       ss_info->type.CENTER_MODE =3D true;
> +               break;
> +       case AS_SIGNAL_TYPE_GPU_PLL:
> +               ss_info->spread_spectrum_percentage =3D
> +                               smu_tbl->gpuclk_ss_percentage;
> +               ss_info->spread_spectrum_range =3D
> +                               smu_tbl->gpuclk_ss_rate_10hz * 10;
> +               if (smu_tbl->gpuclk_ss_mode & ATOM_SS_CENTRE_SPREAD_MODE)
> +                       ss_info->type.CENTER_MODE =3D true;
> +               break;
> +       default:
> +               result =3D BP_RESULT_UNSUPPORTED;
> +       }
> +
> +       return result;
> +}
> +
> +/**
> + * bios_parser_get_spread_spectrum_info
> + * Get spread spectrum information from the ASIC_InternalSS_Info(ver 2.1
> or
> + * ver 3.1) or SS_Info table from the VBIOS. Currently
> ASIC_InternalSS_Info
> + * ver 2.1 can co-exist with SS_Info table. Expect ASIC_InternalSS_Info
> + * ver 3.1,
> + * there is only one entry for each signal /ss id.  However, there is
> + * no planning of supporting multiple spread Sprectum entry for EverGree=
n
> + * @param [in] this
> + * @param [in] signal, ASSignalType to be converted to info index
> + * @param [in] index, number of entries that match the converted info
> index
> + * @param [out] ss_info, sprectrum information structure,
> + * @return Bios parser result code
> + */
> +static enum bp_result bios_parser_get_spread_spectrum_info(
> +       struct dc_bios *dcb,
> +       enum as_signal_type signal,
> +       uint32_t index,
> +       struct spread_spectrum_info *ss_info)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       enum bp_result result =3D BP_RESULT_UNSUPPORTED;
> +       struct atom_common_table_header *header;
> +       struct atom_data_revision tbl_revision;
> +
> +       if (!ss_info) /* check for bad input */
> +               return BP_RESULT_BADINPUT;
> +
> +       if (!DATA_TABLES(dce_info))
> +               return BP_RESULT_UNSUPPORTED;
> +
> +       header =3D GET_IMAGE(struct atom_common_table_header,
> +                                               DATA_TABLES(dce_info));
> +       get_atom_data_table_revision(header, &tbl_revision);
> +
> +       switch (tbl_revision.major) {
> +       case 4:
> +               switch (tbl_revision.minor) {
> +               case 1:
> +                       return get_ss_info_v4_1(bp, signal, index,
> ss_info);
> +               default:
> +                       break;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +       /* there can not be more then one entry for SS Info table */
> +       return result;
> +}
> +
> +static enum bp_result get_embedded_panel_info_v2_1(
> +       struct bios_parser *bp,
> +       struct embedded_panel_info *info)
> +{
> +       struct lcd_info_v2_1 *lvds;
> +
> +       if (!info)
> +               return BP_RESULT_BADINPUT;
> +
> +       if (!DATA_TABLES(lcd_info))
> +               return BP_RESULT_UNSUPPORTED;
> +
> +       lvds =3D GET_IMAGE(struct lcd_info_v2_1, DATA_TABLES(lcd_info));
> +
> +       if (!lvds)
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       /* TODO: previous vv1_3, should v2_1 */
> +       if (!((lvds->table_header.format_revision =3D=3D 2)
> +                       && (lvds->table_header.content_revision >=3D 1)))
> +               return BP_RESULT_UNSUPPORTED;
> +
> +       memset(info, 0, sizeof(struct embedded_panel_info));
> +
> +       /* We need to convert from 10KHz units into KHz units */
> +       info->lcd_timing.pixel_clk =3D
> +                       le16_to_cpu(lvds->lcd_timing.pixclk) * 10;
> +       /* usHActive does not include borders, according to VBIOS team */
> +       info->lcd_timing.horizontal_addressable =3D
> +                       le16_to_cpu(lvds->lcd_timing.h_active);
> +       /* usHBlanking_Time includes borders, so we should really be
> +        * subtractingborders duing this translation, but LVDS generally
> +        * doesn't have borders, so we should be okay leaving this as is
> for
> +        * now.  May need to revisit if we ever have LVDS with borders
> +        */
> +       info->lcd_timing.horizontal_blanking_time =3D
> +               le16_to_cpu(lvds->lcd_timing.h_blanking_time);
> +       /* usVActive does not include borders, according to VBIOS team*/
> +       info->lcd_timing.vertical_addressable =3D
> +               le16_to_cpu(lvds->lcd_timing.v_active);
> +       /* usVBlanking_Time includes borders, so we should really be
> +        * subtracting borders duing this translation, but LVDS generally
> +        * doesn't have borders, so we should be okay leaving this as is
> for
> +        * now. May need to revisit if we ever have LVDS with borders
> +        */
> +       info->lcd_timing.vertical_blanking_time =3D
> +               le16_to_cpu(lvds->lcd_timing.v_blanking_time);
> +       info->lcd_timing.horizontal_sync_offset =3D
> +               le16_to_cpu(lvds->lcd_timing.h_sync_offset);
> +       info->lcd_timing.horizontal_sync_width =3D
> +               le16_to_cpu(lvds->lcd_timing.h_sync_width);
> +       info->lcd_timing.vertical_sync_offset =3D
> +               le16_to_cpu(lvds->lcd_timing.v_sync_offset);
> +       info->lcd_timing.vertical_sync_width =3D
> +               le16_to_cpu(lvds->lcd_timing.v_syncwidth);
> +       info->lcd_timing.horizontal_border =3D lvds->lcd_timing.h_border;
> +       info->lcd_timing.vertical_border =3D lvds->lcd_timing.v_border;
> +
> +       /* not provided by VBIOS */
> +       info->lcd_timing.misc_info.HORIZONTAL_CUT_OFF =3D 0;
> +
> +       info->lcd_timing.misc_info.H_SYNC_POLARITY =3D
> +               ~(uint32_t)
> +               (lvds->lcd_timing.miscinfo & ATOM_HSYNC_POLARITY);
> +       info->lcd_timing.misc_info.V_SYNC_POLARITY =3D
> +               ~(uint32_t)
> +               (lvds->lcd_timing.miscinfo & ATOM_VSYNC_POLARITY);
> +
> +       /* not provided by VBIOS */
> +       info->lcd_timing.misc_info.VERTICAL_CUT_OFF =3D 0;
> +
> +       info->lcd_timing.misc_info.H_REPLICATION_BY2 =3D
> +               lvds->lcd_timing.miscinfo & ATOM_H_REPLICATIONBY2;
> +       info->lcd_timing.misc_info.V_REPLICATION_BY2 =3D
> +               lvds->lcd_timing.miscinfo & ATOM_V_REPLICATIONBY2;
> +       info->lcd_timing.misc_info.COMPOSITE_SYNC =3D
> +               lvds->lcd_timing.miscinfo & ATOM_COMPOSITESYNC;
> +       info->lcd_timing.misc_info.INTERLACE =3D
> +               lvds->lcd_timing.miscinfo & ATOM_INTERLACE;
> +
> +       /* not provided by VBIOS*/
> +       info->lcd_timing.misc_info.DOUBLE_CLOCK =3D 0;
> +       /* not provided by VBIOS*/
> +       info->ss_id =3D 0;
> +
> +       info->realtek_eDPToLVDS =3D
> +                       (lvds->dplvdsrxid =3D=3D eDP_TO_LVDS_REALTEK_ID ?=
 1:0);
> +
> +       return BP_RESULT_OK;
> +}
> +
> +static enum bp_result bios_parser_get_embedded_panel_info(
> +       struct dc_bios *dcb,
> +       struct embedded_panel_info *info)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +       struct atom_common_table_header *header;
> +       struct atom_data_revision tbl_revision;
> +
> +       if (!DATA_TABLES(lcd_info))
> +               return BP_RESULT_FAILURE;
> +
> +       header =3D GET_IMAGE(struct atom_common_table_header,
> +                                       DATA_TABLES(lcd_info));
> +
> +       if (!header)
> +               return BP_RESULT_BADBIOSTABLE;
> +
> +       get_atom_data_table_revision(header, &tbl_revision);
> +
> +
> +       switch (tbl_revision.major) {
> +       case 2:
> +               switch (tbl_revision.minor) {
> +               case 1:
> +                       return get_embedded_panel_info_v2_1(bp, info);
> +               default:
> +                       break;
> +               }
> +       default:
> +               break;
> +       }
> +
> +       return BP_RESULT_FAILURE;
> +}
> +
> +static uint32_t get_support_mask_for_device_id(struct device_id device_i=
d)
> +{
> +       enum dal_device_type device_type =3D device_id.device_type;
> +       uint32_t enum_id =3D device_id.enum_id;
> +
> +       switch (device_type) {
> +       case DEVICE_TYPE_LCD:
> +               switch (enum_id) {
> +               case 1:
> +                       return ATOM_DISPLAY_LCD1_SUPPORT;
> +               default:
> +                       break;
> +               }
> +               break;
> +       case DEVICE_TYPE_DFP:
> +               switch (enum_id) {
> +               case 1:
> +                       return ATOM_DISPLAY_DFP1_SUPPORT;
> +               case 2:
> +                       return ATOM_DISPLAY_DFP2_SUPPORT;
> +               case 3:
> +                       return ATOM_DISPLAY_DFP3_SUPPORT;
> +               case 4:
> +                       return ATOM_DISPLAY_DFP4_SUPPORT;
> +               case 5:
> +                       return ATOM_DISPLAY_DFP5_SUPPORT;
> +               case 6:
> +                       return ATOM_DISPLAY_DFP6_SUPPORT;
> +               default:
> +                       break;
> +               }
> +               break;
> +       default:
> +               break;
> +       };
> +
> +       /* Unidentified device ID, return empty support mask. */
> +       return 0;
> +}
> +
> +static bool bios_parser_is_device_id_supported(
> +       struct dc_bios *dcb,
> +       struct device_id id)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       uint32_t mask =3D get_support_mask_for_device_id(id);
> +
> +       return (le16_to_cpu(bp->object_info_tbl.v1_4->supporteddevices) &
> +                                                               mask) !=
=3D 0;
> +}
> +
> +static void bios_parser_post_init(
> +       struct dc_bios *dcb)
> +{
> +       /* TODO for OPM module. Need implement later */
> +}
> +
> +static uint32_t bios_parser_get_ss_entry_number(
> +       struct dc_bios *dcb,
> +       enum as_signal_type signal)
> +{
> +       /* TODO: DAL2 atomfirmware implementation does not need this.
> +        * why DAL3 need this?
> +        */
> +       return 1;
> +}
> +
> +static enum bp_result bios_parser_transmitter_control(
> +       struct dc_bios *dcb,
> +       struct bp_transmitter_control *cntl)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.transmitter_control)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.transmitter_control(bp, cntl);
> +}
> +
> +static enum bp_result bios_parser_encoder_control(
> +       struct dc_bios *dcb,
> +       struct bp_encoder_control *cntl)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.dig_encoder_control)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.dig_encoder_control(bp, cntl);
> +}
> +
> +static enum bp_result bios_parser_set_pixel_clock(
> +       struct dc_bios *dcb,
> +       struct bp_pixel_clock_parameters *bp_params)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.set_pixel_clock)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.set_pixel_clock(bp, bp_params);
> +}
> +
> +static enum bp_result bios_parser_set_dce_clock(
> +       struct dc_bios *dcb,
> +       struct bp_set_dce_clock_parameters *bp_params)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.set_dce_clock)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.set_dce_clock(bp, bp_params);
> +}
> +
> +static unsigned int bios_parser_get_smu_clock_info(
> +       struct dc_bios *dcb)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.get_smu_clock_info)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.get_smu_clock_info(bp);
> +}
> +
> +static enum bp_result bios_parser_program_crtc_timing(
> +       struct dc_bios *dcb,
> +       struct bp_hw_crtc_timing_parameters *bp_params)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.set_crtc_timing)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.set_crtc_timing(bp, bp_params);
> +}
> +
> +static enum bp_result bios_parser_enable_crtc(
> +       struct dc_bios *dcb,
> +       enum controller_id id,
> +       bool enable)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.enable_crtc)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.enable_crtc(bp, id, enable);
> +}
> +
> +static enum bp_result bios_parser_crtc_source_select(
> +       struct dc_bios *dcb,
> +       struct bp_crtc_source_select *bp_params)
> +{
> +       struct bios_parser *bp =3D BP_FROM_DCB(dcb);
> +
> +       if (!bp->cmd_tbl.select_crtc_source)
> +               return BP_RESULT_FAILURE;
> +
> +       return bp->cmd_tbl.select_crtc_source(bp, bp_params);
> +}
> +
> +static enum bp_result bios_parser_enable_di

--94eb2c112c3e9b79ce0555dfb991
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGk8ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5O3ZlIGp1c3QgdGVzdGVk
IG91dCB0aGUgbmV3IGFtZC1zdGFnaW5nLWRybS1uZXh0IGJyYW5jaCBhbmQgbm90aWNlZCB0aGUg
Zm9sbG93aW5nIHdhcm5pbmcgY2F1c2VkIGJ5IHRoaXMgcGF0Y2g8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PjxkaXY+ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9z
L2Jpb3NfcGFyc2VyMi5jOiBJbiBmdW5jdGlvbiDigJhnZXRfZW1iZWRkZWRfcGFuZWxfaW5mb192
Ml8x4oCZOjwvZGl2PjxkaXY+ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9k
Yy9iaW9zL2Jpb3NfcGFyc2VyMi5jOjEzMzU6Mzogd2FybmluZzogb3ZlcmZsb3cgaW4gaW1wbGlj
aXQgY29uc3RhbnQgY29udmVyc2lvbiBbLVdvdmVyZmxvd108L2Rpdj48ZGl2PsKgIMKgbHZkcy0m
Z3Q7bGNkX3RpbWluZy5taXNjaW5mbyAmYW1wOyBBVE9NX0lOVEVSTEFDRTs8L2Rpdj48ZGl2PsKg
IMKgXn5+fjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Q2hlZXJzPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5NaWtlPC9kaXY+PC9kaXY+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij48ZGl2IGRpcj0ibHRyIj5PbiBNb24sIDIwIE1hciAyMDE3IGF0IDIwOjM1IEFsZXggRGV1Y2hl
ciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsZXhkZXVjaGVyQGdtYWlsLmNvbSI+YWxleGRldWNoZXJA
Z21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNv
bGlkO3BhZGRpbmctbGVmdDoxZXgiPkZyb206IEhhcnJ5IFdlbnRsYW5kICZsdDs8YSBocmVmPSJt
YWlsdG86aGFycnkud2VudGxhbmRAYW1kLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmhhcnJ5LndlbnRs
YW5kQGFtZC5jb208L2E+Jmd0Ozxicj4NCjxicj4NClNpZ25lZC1vZmYtYnk6IEhhcnJ5IFdlbnRs
YW5kICZsdDs8YSBocmVmPSJtYWlsdG86aGFycnkud2VudGxhbmRAYW1kLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPmhhcnJ5LndlbnRsYW5kQGFtZC5jb208L2E+Jmd0Ozxicj4NClNpZ25lZC1vZmYtYnk6
IEFsZXggRGV1Y2hlciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20iIHRhcmdldD0iX2JsYW5rIj5hbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPC9hPiZndDs8YnI+
DQotLS08YnI+DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFy
c2VyMi5jIHwgMjA4NSArKysrKysrKysrKysrKysrKysrKzxicj4NCsKgZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmggfMKgIMKgMzMgKzxicj4NCsKgLi4u
L2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlcl90eXBlc19pbnRlcm5hbDIuaMKgIHzCoCDCoDc0
ICs8YnI+DQrCoC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJsZTIu
Y8KgIMKgfMKgIDgxMyArKysrKysrKzxicj4NCsKgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Ymlvcy9jb21tYW5kX3RhYmxlMi5owqAgwqB8wqAgMTA1ICs8YnI+DQrCoC4uLi9hbWQvZGlzcGxh
eS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyMi5jwqAgwqAgfMKgIDI2MCArKys8YnI+DQrC
oC4uLi9hbWQvZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyMi5owqAgwqAgfMKg
IMKgODIgKzxicj4NCsKgLi4uL2RjL2Jpb3MvZGNlMTEyL2NvbW1hbmRfdGFibGVfaGVscGVyMl9k
Y2UxMTIuY8KgIHzCoCA0MTggKysrKzxicj4NCsKgLi4uL2RjL2Jpb3MvZGNlMTEyL2NvbW1hbmRf
dGFibGVfaGVscGVyMl9kY2UxMTIuaMKgIHzCoCDCoDM0ICs8YnI+DQrCoDkgZmlsZXMgY2hhbmdl
ZCwgMzkwNCBpbnNlcnRpb25zKCspPGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIyLmM8YnI+DQrCoGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNl
cjIuaDxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iaW9zL2Jpb3NfcGFyc2VyX3R5cGVzX2ludGVybmFsMi5oPGJyPg0KwqBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJs
ZTIuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iaW9zL2NvbW1hbmRfdGFibGUyLmg8YnI+DQrCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlX2hlbHBlcjIuYzxi
cj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9i
aW9zL2NvbW1hbmRfdGFibGVfaGVscGVyMi5oPGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvZGNlMTEyL2NvbW1hbmRfdGFibGVfaGVs
cGVyMl9kY2UxMTIuYzxicj4NCsKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9iaW9zL2RjZTExMi9jb21tYW5kX3RhYmxlX2hlbHBlcjJfZGNlMTEyLmg8
YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jp
b3MvYmlvc19wYXJzZXIyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9i
aW9zX3BhcnNlcjIuYzxicj4NCm5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJyPg0KaW5kZXggMDAwMDAw
MC4uZjZlNzdkYTxicj4NCi0tLSAvZGV2L251bGw8YnI+DQorKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlcjIuYzxicj4NCkBAIC0wLDAgKzEsMjA4NSBA
QDxicj4NCisvKjxicj4NCisgKiBDb3B5cmlnaHQgMjAxMi0xNSBBZHZhbmNlZCBNaWNybyBEZXZp
Y2VzLCBJbmMuPGJyPg0KKyAqPGJyPg0KKyAqIFBlcm1pc3Npb24gaXMgaGVyZWJ5IGdyYW50ZWQs
IGZyZWUgb2YgY2hhcmdlLCB0byBhbnkgcGVyc29uIG9idGFpbmluZyBhPGJyPg0KKyAqIGNvcHkg
b2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZCBkb2N1bWVudGF0aW9uIGZpbGVzICh0aGUg
JnF1b3Q7U29mdHdhcmUmcXVvdDspLDxicj4NCisgKiB0byBkZWFsIGluIHRoZSBTb2Z0d2FyZSB3
aXRob3V0IHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1pdGF0aW9uPGJyPg0KKyAq
IHRoZSByaWdodHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0cmli
dXRlLCBzdWJsaWNlbnNlLDxicj4NCisgKiBhbmQvb3Igc2VsbCBjb3BpZXMgb2YgdGhlIFNvZnR3
YXJlLCBhbmQgdG8gcGVybWl0IHBlcnNvbnMgdG8gd2hvbSB0aGU8YnI+DQorICogU29mdHdhcmUg
aXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRvIHRoZSBmb2xsb3dpbmcgY29uZGl0aW9u
czo8YnI+DQorICo8YnI+DQorICogVGhlIGFib3ZlIGNvcHlyaWdodCBub3RpY2UgYW5kIHRoaXMg
cGVybWlzc2lvbiBub3RpY2Ugc2hhbGwgYmUgaW5jbHVkZWQgaW48YnI+DQorICogYWxsIGNvcGll
cyBvciBzdWJzdGFudGlhbCBwb3J0aW9ucyBvZiB0aGUgU29mdHdhcmUuPGJyPg0KKyAqPGJyPg0K
KyAqIFRIRSBTT0ZUV0FSRSBJUyBQUk9WSURFRCAmcXVvdDtBUyBJUyZxdW90OywgV0lUSE9VVCBX
QVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUjxicj4NCisgKiBJTVBMSUVELCBJTkNMVURJ
TkcgQlVUIE5PVCBMSU1JVEVEIFRPIFRIRSBXQVJSQU5USUVTIE9GIE1FUkNIQU5UQUJJTElUWSw8
YnI+DQorICogRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTklORlJJTkdF
TUVOVC7CoCBJTiBOTyBFVkVOVCBTSEFMTDxicj4NCisgKiBUSEUgQ09QWVJJR0hUIEhPTERFUihT
KSBPUiBBVVRIT1IoUykgQkUgTElBQkxFIEZPUiBBTlkgQ0xBSU0sIERBTUFHRVMgT1I8YnI+DQor
ICogT1RIRVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9S
VCBPUiBPVEhFUldJU0UsPGJyPg0KKyAqIEFSSVNJTkcgRlJPTSwgT1VUIE9GIE9SIElOIENPTk5F
Q1RJT04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhFIFVTRSBPUjxicj4NCisgKiBPVEhFUiBERUFM
SU5HUyBJTiBUSEUgU09GVFdBUkUuPGJyPg0KKyAqPGJyPg0KKyAqIEF1dGhvcnM6IEFNRDxicj4N
CisgKjxicj4NCisgKi88YnI+DQorPGJyPg0KKyNpbmNsdWRlICZxdW90O2RtX3NlcnZpY2VzLmgm
cXVvdDs8YnI+DQorPGJyPg0KKyNkZWZpbmUgX0JJT1NfUEFSU0VSXzJfPGJyPg0KKzxicj4NCisj
aW5jbHVkZSAmcXVvdDtPYmplY3RJRC5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O2F0b21m
aXJtd2FyZS5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O2F0b21maXJtd2FyZWlkLmgmcXVv
dDs8YnI+DQorPGJyPg0KKyNpbmNsdWRlICZxdW90O2RjX2Jpb3NfdHlwZXMuaCZxdW90Ozxicj4N
CisjaW5jbHVkZSAmcXVvdDtpbmNsdWRlL2dycGhfb2JqZWN0X2N0cmxfZGVmcy5oJnF1b3Q7PGJy
Pg0KKyNpbmNsdWRlICZxdW90O2luY2x1ZGUvYmlvc19wYXJzZXJfaW50ZXJmYWNlLmgmcXVvdDs8
YnI+DQorI2luY2x1ZGUgJnF1b3Q7aW5jbHVkZS9pMmNhdXhfaW50ZXJmYWNlLmgmcXVvdDs8YnI+
DQorI2luY2x1ZGUgJnF1b3Q7aW5jbHVkZS9sb2dnZXJfaW50ZXJmYWNlLmgmcXVvdDs8YnI+DQor
PGJyPg0KKyNpbmNsdWRlICZxdW90O2NvbW1hbmRfdGFibGUyLmgmcXVvdDs8YnI+DQorPGJyPg0K
KyNpbmNsdWRlICZxdW90O2Jpb3NfcGFyc2VyX2hlbHBlci5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRl
ICZxdW90O2NvbW1hbmRfdGFibGVfaGVscGVyMi5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90
O2Jpb3NfcGFyc2VyMi5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O2Jpb3NfcGFyc2VyX3R5
cGVzX2ludGVybmFsMi5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRlICZxdW90O2Jpb3NfcGFyc2VyX2lu
dGVyZmFjZS5oJnF1b3Q7PGJyPg0KKzxicj4NCisjZGVmaW5lIExBU1RfUkVDT1JEX1RZUEUgMHhm
Zjxicj4NCis8YnI+DQorPGJyPg0KK3N0cnVjdCBpMmNfaWRfY29uZmlnX2FjY2VzcyB7PGJyPg0K
K8KgIMKgIMKgIMKgdWludDhfdCBiZkkyQ19MaW5lTXV4OjQ7PGJyPg0KK8KgIMKgIMKgIMKgdWlu
dDhfdCBiZkhXX0VuZ2luZUlEOjM7PGJyPg0KK8KgIMKgIMKgIMKgdWludDhfdCBiZkhXX0NhcGFi
bGU6MTs8YnI+DQorwqAgwqAgwqAgwqB1aW50OF90IHVjQWNjZXNzOzxicj4NCit9Ozxicj4NCis8
YnI+DQorc3RhdGljIGVudW0gb2JqZWN0X3R5cGUgb2JqZWN0X3R5cGVfZnJvbV9iaW9zX29iamVj
dF9pZCg8YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCBiaW9zX29iamVjdF9pZCk7PGJyPg0KKzxi
cj4NCitzdGF0aWMgZW51bSBvYmplY3RfZW51bV9pZCBlbnVtX2lkX2Zyb21fYmlvc19vYmplY3Rf
aWQodWludDMyX3QgYmlvc19vYmplY3RfaWQpOzxicj4NCis8YnI+DQorc3RhdGljIHN0cnVjdCBn
cmFwaGljc19vYmplY3RfaWQgb2JqZWN0X2lkX2Zyb21fYmlvc19vYmplY3RfaWQoPGJyPg0KK8Kg
IMKgIMKgIMKgdWludDMyX3QgYmlvc19vYmplY3RfaWQpOzxicj4NCis8YnI+DQorc3RhdGljIHVp
bnQzMl90IGlkX2Zyb21fYmlvc19vYmplY3RfaWQoZW51bSBvYmplY3RfdHlwZSB0eXBlLDxicj4N
CivCoCDCoCDCoCDCoHVpbnQzMl90IGJpb3Nfb2JqZWN0X2lkKTs8YnI+DQorPGJyPg0KK3N0YXRp
YyB1aW50MzJfdCBncHVfaWRfZnJvbV9iaW9zX29iamVjdF9pZCh1aW50MzJfdCBiaW9zX29iamVj
dF9pZCk7PGJyPg0KKzxicj4NCitzdGF0aWMgZW51bSBlbmNvZGVyX2lkIGVuY29kZXJfaWRfZnJv
bV9iaW9zX29iamVjdF9pZCh1aW50MzJfdCBiaW9zX29iamVjdF9pZCk7PGJyPg0KKzxicj4NCitz
dGF0aWMgZW51bSBjb25uZWN0b3JfaWQgY29ubmVjdG9yX2lkX2Zyb21fYmlvc19vYmplY3RfaWQo
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgdWludDMyX3QgYmlvc19vYmplY3RfaWQpOzxicj4NCis8YnI+
DQorc3RhdGljIGVudW0gZ2VuZXJpY19pZCBnZW5lcmljX2lkX2Zyb21fYmlvc19vYmplY3RfaWQo
dWludDMyX3QgYmlvc19vYmplY3RfaWQpOzxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBfcmVz
dWx0IGdldF9ncGlvX2kyY19pbmZvKHN0cnVjdCBiaW9zX3BhcnNlciAqYnAsPGJyPg0KK8KgIMKg
IMKgIMKgc3RydWN0IGF0b21faTJjX3JlY29yZCAqcmVjb3JkLDxicj4NCivCoCDCoCDCoCDCoHN0
cnVjdCBncmFwaGljc19vYmplY3RfaTJjX2luZm8gKmluZm8pOzxicj4NCis8YnI+DQorc3RhdGlj
IGVudW0gYnBfcmVzdWx0IGJpb3NfcGFyc2VyX2dldF9maXJtd2FyZV9pbmZvKDxicj4NCivCoCDC
oCDCoCDCoHN0cnVjdCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGZpcm13
YXJlX2luZm8gKmluZm8pOzxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBfcmVzdWx0IGJpb3Nf
cGFyc2VyX2dldF9lbmNvZGVyX2NhcF9pbmZvKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY19i
aW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBvYmpl
Y3RfaWQsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJwX2VuY29kZXJfY2FwX2luZm8gKmluZm8p
Ozxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBfcmVzdWx0IGdldF9maXJtd2FyZV9pbmZvX3Yz
XzEoPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFyc2VyICpicCw8YnI+DQorwqAgwqAg
wqAgwqBzdHJ1Y3QgZmlybXdhcmVfaW5mbyAqaW5mbyk7PGJyPg0KKzxicj4NCitzdGF0aWMgc3Ry
dWN0IGF0b21faHBkX2ludF9yZWNvcmQgKmdldF9ocGRfcmVjb3JkKHN0cnVjdCBiaW9zX3BhcnNl
ciAqYnAsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IGF0b21fZGlzcGxheV9v
YmplY3RfcGF0aF92MiAqb2JqZWN0KTs8YnI+DQorPGJyPg0KK3N0YXRpYyBzdHJ1Y3QgYXRvbV9l
bmNvZGVyX2NhcHNfcmVjb3JkICpnZXRfZW5jb2Rlcl9jYXBfcmVjb3JkKDxicj4NCivCoCDCoCDC
oCDCoHN0cnVjdCBiaW9zX3BhcnNlciAqYnAsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGF0b21f
ZGlzcGxheV9vYmplY3RfcGF0aF92MiAqb2JqZWN0KTs8YnI+DQorPGJyPg0KKyNkZWZpbmUgQklP
U19JTUFHRV9TSVpFX09GRlNFVCAyPGJyPg0KKyNkZWZpbmUgQklPU19JTUFHRV9TSVpFX1VOSVQg
NTEyPGJyPg0KKzxicj4NCisjZGVmaW5lIERBVEFfVEFCTEVTKHRhYmxlKSAoYnAtJmd0O21hc3Rl
cl9kYXRhX3RibC0mZ3Q7bGlzdE9mZGF0YXRhYmxlcy50YWJsZSk8YnI+DQorPGJyPg0KKzxicj4N
CitzdGF0aWMgdm9pZCBkZXN0cnVjdChzdHJ1Y3QgYmlvc19wYXJzZXIgKmJwKTxicj4NCit7PGJy
Pg0KK8KgIMKgIMKgIMKgaWYgKGJwLSZndDtiYXNlLmJpb3NfbG9jYWxfaW1hZ2UpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZG1fZnJlZShicC0mZ3Q7YmFzZS5iaW9zX2xvY2FsX2ltYWdl
KTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGJwLSZndDtiYXNlLmludGVncmF0ZWRfaW5m
byk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkbV9mcmVlKGJwLSZndDtiYXNlLmludGVn
cmF0ZWRfaW5mbyk7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyB2b2lkIGZpcm13YXJlX3Bh
cnNlcl9kZXN0cm95KHN0cnVjdCBkY19iaW9zICoqZGNiKTxicj4NCit7PGJyPg0KK8KgIMKgIMKg
IMKgc3RydWN0IGJpb3NfcGFyc2VyICpicCA9IEJQX0ZST01fRENCKCpkY2IpOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqBpZiAoIWJwKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQlJF
QUtfVE9fREVCVUdHRVIoKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm47PGJy
Pg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBkZXN0cnVjdChicCk7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoGRtX2ZyZWUoYnApOzxicj4NCivCoCDCoCDCoCDCoCpkY2Ig
PSBOVUxMOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgdm9pZCBnZXRfYXRvbV9kYXRhX3Rh
YmxlX3JldmlzaW9uKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9tX2NvbW1vbl90YWJsZV9o
ZWFkZXIgKmF0b21fZGF0YV90YmwsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGF0b21fZGF0YV9y
ZXZpc2lvbiAqdGJsX3JldmlzaW9uKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCF0Ymxf
cmV2aXNpb24pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqAvKiBpbml0aWFsaXplIHRoZSByZXZpc2lvbiB0byAwIHdoaWNoIGlzIGlu
dmFsaWQgcmV2aXNpb24gKi88YnI+DQorwqAgwqAgwqAgwqB0YmxfcmV2aXNpb24tJmd0O21ham9y
ID0gMDs8YnI+DQorwqAgwqAgwqAgwqB0YmxfcmV2aXNpb24tJmd0O21pbm9yID0gMDs8YnI+DQor
PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFhdG9tX2RhdGFfdGJsKTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgdGJsX3JldmlzaW9uLSZn
dDttYWpvciA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHVpbnQz
Ml90KSBhdG9tX2RhdGFfdGJsLSZndDtmb3JtYXRfcmV2aXNpb24gJmFtcDsgMHgzZjs8YnI+DQor
wqAgwqAgwqAgwqB0YmxfcmV2aXNpb24tJmd0O21pbm9yID08YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAodWludDMyX3QpIGF0b21fZGF0YV90YmwtJmd0O2NvbnRlbnRf
cmV2aXNpb24gJmFtcDsgMHgzZjs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIHN0cnVjdCBn
cmFwaGljc19vYmplY3RfaWQgb2JqZWN0X2lkX2Zyb21fYmlvc19vYmplY3RfaWQoPGJyPg0KK8Kg
IMKgIMKgIMKgdWludDMyX3QgYmlvc19vYmplY3RfaWQpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAg
wqBlbnVtIG9iamVjdF90eXBlIHR5cGU7PGJyPg0KK8KgIMKgIMKgIMKgZW51bSBvYmplY3RfZW51
bV9pZCBlbnVtX2lkOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBncmFwaGljc19vYmplY3RfaWQg
Z29faWQgPSB7IDAgfTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgdHlwZSA9IG9iamVjdF90eXBl
X2Zyb21fYmlvc19vYmplY3RfaWQoYmlvc19vYmplY3RfaWQpOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBpZiAodHlwZSA9PSBPQkpFQ1RfVFlQRV9VTktOT1dOKTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBnb19pZDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgZW51bV9pZCA9
IGVudW1faWRfZnJvbV9iaW9zX29iamVjdF9pZChiaW9zX29iamVjdF9pZCk7PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoGlmIChlbnVtX2lkID09IEVOVU1fSURfVU5LTk9XTik8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gZ29faWQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGdv
X2lkID0gZGFsX2dyYXBoaWNzX29iamVjdF9pZF9pbml0KDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlkX2Zyb21fYmlvc19vYmplY3RfaWQodHlwZSwgYmlvc19vYmpl
Y3RfaWQpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVudW1f
aWQsIHR5cGUpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gZ29faWQ7PGJyPg0KK308
YnI+DQorPGJyPg0KK3N0YXRpYyBlbnVtIG9iamVjdF90eXBlIG9iamVjdF90eXBlX2Zyb21fYmlv
c19vYmplY3RfaWQodWludDMyX3QgYmlvc19vYmplY3RfaWQpPGJyPg0KK3s8YnI+DQorwqAgwqAg
wqAgwqB1aW50MzJfdCBiaW9zX29iamVjdF90eXBlID0gKGJpb3Nfb2JqZWN0X2lkICZhbXA7IE9C
SkVDVF9UWVBFX01BU0spPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgJmd0OyZndDsgT0JKRUNUX1RZUEVfU0hJRlQ7PGJyPg0KK8KgIMKgIMKgIMKg
ZW51bSBvYmplY3RfdHlwZSBvYmplY3RfdHlwZTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3dp
dGNoIChiaW9zX29iamVjdF90eXBlKSB7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBHUkFQSF9PQkpF
Q1RfVFlQRV9HUFU6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2JqZWN0X3R5cGUgPSBP
QkpFQ1RfVFlQRV9HUFU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
K8KgIMKgIMKgIMKgY2FzZSBHUkFQSF9PQkpFQ1RfVFlQRV9FTkNPREVSOjxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoG9iamVjdF90eXBlID0gT0JKRUNUX1RZUEVfRU5DT0RFUjs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEdSQVBI
X09CSkVDVF9UWVBFX0NPTk5FQ1RPUjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvYmpl
Y3RfdHlwZSA9IE9CSkVDVF9UWVBFX0NPTk5FQ1RPUjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEdSQVBIX09CSkVDVF9UWVBFX1JPVVRF
Ujo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvYmplY3RfdHlwZSA9IE9CSkVDVF9UWVBF
X1JPVVRFUjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAg
wqAgwqBjYXNlIEdSQVBIX09CSkVDVF9UWVBFX0dFTkVSSUM6PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgb2JqZWN0X3R5cGUgPSBPQkpFQ1RfVFlQRV9HRU5FUklDOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgb2JqZWN0X3R5cGUgPSBPQkpFQ1RfVFlQRV9VTktOT1dOOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoH08YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIG9iamVjdF90eXBlOzxicj4NCit9PGJyPg0KKzxi
cj4NCitzdGF0aWMgZW51bSBvYmplY3RfZW51bV9pZCBlbnVtX2lkX2Zyb21fYmlvc19vYmplY3Rf
aWQodWludDMyX3QgYmlvc19vYmplY3RfaWQpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqB1aW50
MzJfdCBiaW9zX2VudW1faWQgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoChiaW9zX29iamVjdF9pZCAmYW1wOyBFTlVNX0lEX01BU0spICZndDsmZ3Q7IEVOVU1fSURf
U0hJRlQ7PGJyPg0KK8KgIMKgIMKgIMKgZW51bSBvYmplY3RfZW51bV9pZCBpZDs8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgc3dpdGNoIChiaW9zX2VudW1faWQpIHs8YnI+DQorwqAgwqAgwqAgwqBj
YXNlIEdSQVBIX09CSkVDVF9FTlVNX0lEMTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZCA9IEVOVU1fSURfMTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQor
wqAgwqAgwqAgwqBjYXNlIEdSQVBIX09CSkVDVF9FTlVNX0lEMjo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZCA9IEVOVU1fSURfMjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBi
cmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEdSQVBIX09CSkVDVF9FTlVNX0lEMzo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IEVOVU1fSURfMzs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEdSQVBIX09CSkVDVF9FTlVN
X0lENDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IEVOVU1fSURfNDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEdSQVBI
X09CSkVDVF9FTlVNX0lENTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IEVOVU1f
SURfNTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAg
wqBjYXNlIEdSQVBIX09CSkVDVF9FTlVNX0lENjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZCA9IEVOVU1fSURfNjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+
DQorwqAgwqAgwqAgwqBjYXNlIEdSQVBIX09CSkVDVF9FTlVNX0lENzo8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBpZCA9IEVOVU1fSURfNzs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGlkID0gRU5VTV9JRF9VTktOT1dOOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJu
IGlkOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgdWludDMyX3QgaWRfZnJvbV9iaW9zX29i
amVjdF9pZChlbnVtIG9iamVjdF90eXBlIHR5cGUsPGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3Qg
Ymlvc19vYmplY3RfaWQpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzd2l0Y2ggKHR5cGUpIHs8
YnI+DQorwqAgwqAgwqAgwqBjYXNlIE9CSkVDVF9UWVBFX0dQVTo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gZ3B1X2lkX2Zyb21fYmlvc19vYmplY3RfaWQoYmlvc19vYmplY3Rf
aWQpOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgT0JKRUNUX1RZUEVfRU5DT0RFUjo8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gKHVpbnQzMl90KWVuY29kZXJfaWRfZnJvbV9iaW9z
X29iamVjdF9pZChiaW9zX29iamVjdF9pZCk7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBPQkpFQ1Rf
VFlQRV9DT05ORUNUT1I6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuICh1aW50
MzJfdCljb25uZWN0b3JfaWRfZnJvbV9iaW9zX29iamVjdF9pZCg8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBiaW9zX29iamVjdF9pZCk7PGJyPg0K
K8KgIMKgIMKgIMKgY2FzZSBPQkpFQ1RfVFlQRV9HRU5FUklDOjxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBnZW5lcmljX2lkX2Zyb21fYmlvc19vYmplY3RfaWQoYmlvc19vYmpl
Y3RfaWQpOzxicj4NCivCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIDA7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCit9PGJyPg0KKzxicj4NCit1
aW50MzJfdCBncHVfaWRfZnJvbV9iaW9zX29iamVjdF9pZCh1aW50MzJfdCBiaW9zX29iamVjdF9p
ZCk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHJldHVybiAoYmlvc19vYmplY3RfaWQgJmFtcDsg
T0JKRUNUX0lEX01BU0spICZndDsmZ3Q7IE9CSkVDVF9JRF9TSElGVDs8YnI+DQorfTxicj4NCis8
YnI+DQorc3RhdGljIGVudW0gZW5jb2Rlcl9pZCBlbmNvZGVyX2lkX2Zyb21fYmlvc19vYmplY3Rf
aWQodWludDMyX3QgYmlvc19vYmplY3RfaWQpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqB1aW50
MzJfdCBiaW9zX2VuY29kZXJfaWQgPSBncHVfaWRfZnJvbV9iaW9zX29iamVjdF9pZChiaW9zX29i
amVjdF9pZCk7PGJyPg0KK8KgIMKgIMKgIMKgZW51bSBlbmNvZGVyX2lkIGlkOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqBzd2l0Y2ggKGJpb3NfZW5jb2Rlcl9pZCkgezxicj4NCivCoCDCoCDCoCDC
oGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfSU5URVJOQUxfTFZEUzo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZCA9IEVOQ09ERVJfSURfSU5URVJOQUxfTFZEUzs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEVOQ09ERVJfT0JKRUNU
X0lEX0lOVEVSTkFMX1RNRFMxOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gRU5D
T0RFUl9JRF9JTlRFUk5BTF9UTURTMTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVh
azs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEVOQ09ERVJfT0JKRUNUX0lEX0lOVEVSTkFMX1RNRFMy
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gRU5DT0RFUl9JRF9JTlRFUk5BTF9U
TURTMjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAg
wqBjYXNlIEVOQ09ERVJfT0JKRUNUX0lEX0lOVEVSTkFMX0RBQzE6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWQgPSBFTkNPREVSX0lEX0lOVEVSTkFMX0RBQzE7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBFTkNPREVSX09CSkVD
VF9JRF9JTlRFUk5BTF9EQUMyOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gRU5D
T0RFUl9JRF9JTlRFUk5BTF9EQUMyOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFr
Ozxicj4NCivCoCDCoCDCoCDCoGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfSU5URVJOQUxfTFZUTTE6
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQgPSBFTkNPREVSX0lEX0lOVEVSTkFMX0xW
VE0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDC
oGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfSERNSV9JTlRFUk5BTDo8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZCA9IEVOQ09ERVJfSURfSU5URVJOQUxfSERNSTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEVOQ09ERVJfT0JKRUNU
X0lEX0lOVEVSTkFMX0tMRFNDUF9UTURTMTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZCA9IEVOQ09ERVJfSURfSU5URVJOQUxfS0xEU0NQX1RNRFMxOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURf
SU5URVJOQUxfS0xEU0NQX0RBQzE6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQgPSBF
TkNPREVSX0lEX0lOVEVSTkFMX0tMRFNDUF9EQUMxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfSU5URVJO
QUxfS0xEU0NQX0RBQzI6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQgPSBFTkNPREVS
X0lEX0lOVEVSTkFMX0tMRFNDUF9EQUMyOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJy
ZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfTVZQVV9GUEdBOjxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gRU5DT0RFUl9JRF9FWFRFUk5BTF9NVlBV
X0ZQR0E7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKg
IMKgY2FzZSBFTkNPREVSX09CSkVDVF9JRF9JTlRFUk5BTF9EREk6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaWQgPSBFTkNPREVSX0lEX0lOVEVSTkFMX0RESTs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEVOQ09ERVJfT0JKRUNU
X0lEX0lOVEVSTkFMX1VOSVBIWTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IEVO
Q09ERVJfSURfSU5URVJOQUxfVU5JUEhZOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJy
ZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfSU5URVJOQUxfS0xE
U0NQX0xWVE1BOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gRU5DT0RFUl9JRF9J
TlRFUk5BTF9LTERTQ1BfTFZUTUE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7
PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBFTkNPREVSX09CSkVDVF9JRF9JTlRFUk5BTF9VTklQSFkx
Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gRU5DT0RFUl9JRF9JTlRFUk5BTF9V
TklQSFkxOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDC
oCDCoGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfSU5URVJOQUxfVU5JUEhZMjo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZCA9IEVOQ09ERVJfSURfSU5URVJOQUxfVU5JUEhZMjs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIEVOQ09E
RVJfT0JKRUNUX0lEX0FMTU9ORDogLyogRU5DT0RFUl9PQkpFQ1RfSURfTlVUTUVHICovPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQgPSBFTkNPREVSX0lEX0VYVEVSTkFMX05VVE1FRzs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNl
IEVOQ09ERVJfT0JKRUNUX0lEX1RSQVZJUzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZCA9IEVOQ09ERVJfSURfRVhURVJOQUxfVFJBVklTOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgRU5DT0RFUl9PQkpFQ1RfSURfSU5URVJO
QUxfVU5JUEhZMzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IEVOQ09ERVJfSURf
SU5URVJOQUxfVU5JUEhZMzs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+
DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0g
RU5DT0RFUl9JRF9VTktOT1dOOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFTU0VSVCgw
KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqB9
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBpZDs8YnI+DQorfTxicj4NCis8YnI+DQor
c3RhdGljIGVudW0gY29ubmVjdG9yX2lkIGNvbm5lY3Rvcl9pZF9mcm9tX2Jpb3Nfb2JqZWN0X2lk
KDxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IGJpb3Nfb2JqZWN0X2lkKTxicj4NCit7PGJyPg0K
K8KgIMKgIMKgIMKgdWludDMyX3QgYmlvc19jb25uZWN0b3JfaWQgPSBncHVfaWRfZnJvbV9iaW9z
X29iamVjdF9pZChiaW9zX29iamVjdF9pZCk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGVudW0g
Y29ubmVjdG9yX2lkIGlkOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBzd2l0Y2ggKGJpb3NfY29u
bmVjdG9yX2lkKSB7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBDT05ORUNUT1JfT0JKRUNUX0lEX1NJ
TkdMRV9MSU5LX0RWSV9JOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gQ09OTkVD
VE9SX0lEX1NJTkdMRV9MSU5LX0RWSUk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBDT05ORUNUT1JfT0JKRUNUX0lEX0RVQUxfTElOS19E
VklfSTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IENPTk5FQ1RPUl9JRF9EVUFM
X0xJTktfRFZJSTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAg
wqAgwqAgwqBjYXNlIENPTk5FQ1RPUl9PQkpFQ1RfSURfU0lOR0xFX0xJTktfRFZJX0Q6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQgPSBDT05ORUNUT1JfSURfU0lOR0xFX0xJTktfRFZJ
RDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBj
YXNlIENPTk5FQ1RPUl9PQkpFQ1RfSURfRFVBTF9MSU5LX0RWSV9EOjxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGlkID0gQ09OTkVDVE9SX0lEX0RVQUxfTElOS19EVklEOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQ09OTkVDVE9S
X09CSkVDVF9JRF9WR0E6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQgPSBDT05ORUNU
T1JfSURfVkdBOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDC
oCDCoCDCoGNhc2UgQ09OTkVDVE9SX09CSkVDVF9JRF9IRE1JX1RZUEVfQTo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBpZCA9IENPTk5FQ1RPUl9JRF9IRE1JX1RZUEVfQTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIENPTk5FQ1RP
Ul9PQkpFQ1RfSURfTFZEUzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IENPTk5F
Q1RPUl9JRF9MVkRTOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivC
oCDCoCDCoCDCoGNhc2UgQ09OTkVDVE9SX09CSkVDVF9JRF9QQ0lFX0NPTk5FQ1RPUjo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IENPTk5FQ1RPUl9JRF9QQ0lFOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQ09OTkVDVE9S
X09CSkVDVF9JRF9IQVJEQ09ERV9EVkk6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQg
PSBDT05ORUNUT1JfSURfSEFSRENPREVfRFZJOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQ09OTkVDVE9SX09CSkVDVF9JRF9ESVNQTEFZ
UE9SVDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IENPTk5FQ1RPUl9JRF9ESVNQ
TEFZX1BPUlQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKg
IMKgIMKgY2FzZSBDT05ORUNUT1JfT0JKRUNUX0lEX2VEUDo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBpZCA9IENPTk5FQ1RPUl9JRF9FRFA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBDT05ORUNUT1JfT0JKRUNUX0lEX01YTTo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IENPTk5FQ1RPUl9JRF9NWE07PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgZGVmYXVsdDo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IENPTk5FQ1RPUl9JRF9VTktOT1dOOzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoH08YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIGlkOzxicj4NCit9PGJyPg0KKzxicj4NCitlbnVt
IGdlbmVyaWNfaWQgZ2VuZXJpY19pZF9mcm9tX2Jpb3Nfb2JqZWN0X2lkKHVpbnQzMl90IGJpb3Nf
b2JqZWN0X2lkKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgYmlvc19nZW5lcmlj
X2lkID0gZ3B1X2lkX2Zyb21fYmlvc19vYmplY3RfaWQoYmlvc19vYmplY3RfaWQpOzxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqBlbnVtIGdlbmVyaWNfaWQgaWQ7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoHN3aXRjaCAoYmlvc19nZW5lcmljX2lkKSB7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBHRU5F
UklDX09CSkVDVF9JRF9NWE1fT1BNOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0g
R0VORVJJQ19JRF9NWE1fT1BNOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxi
cj4NCivCoCDCoCDCoCDCoGNhc2UgR0VORVJJQ19PQkpFQ1RfSURfR0xTWU5DOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gR0VORVJJQ19JRF9HTFNZTkM7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBHRU5FUklDX09CSkVD
VF9JRF9TVEVSRU9fUElOOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlkID0gR0VORVJJ
Q19JRF9TVEVSRU87PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8Kg
IMKgIMKgIMKgZGVmYXVsdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZCA9IEdFTkVS
SUNfSURfVU5LTk9XTjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQor
wqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBpZDs8YnI+DQorfTxi
cj4NCis8YnI+DQorc3RhdGljIHVpbnQ4X3QgYmlvc19wYXJzZXJfZ2V0X2Nvbm5lY3RvcnNfbnVt
YmVyKHN0cnVjdCBkY19iaW9zICpkY2IpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3Qg
Ymlvc19wYXJzZXIgKmJwID0gQlBfRlJPTV9EQ0IoZGNiKTs8YnI+DQorwqAgwqAgwqAgwqB1bnNp
Z25lZCBpbnQgY291bnQgPSAwOzxicj4NCivCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBpOzxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZsdDsgYnAtJmd0O29iamVjdF9pbmZv
X3RibC52MV80LSZndDtudW1iZXJfb2ZfcGF0aDsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKGJwLSZndDtvYmplY3RfaW5mb190YmwudjFfNC0mZ3Q7ZGlzcGxheV9wYXRo
W2ldLmVuY29kZXJvYmppZCAhPSAwPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJwLSZndDtvYmplY3RfaW5mb190YmwudjFfNC0mZ3Q7ZGlzcGxheV9wYXRoW2ldLmRpc3BsYXlf
b2JqaWQgIT0gMCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb3Vu
dCsrOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gY291bnQ7PGJy
Pg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyBzdHJ1Y3QgZ3JhcGhpY3Nfb2JqZWN0X2lkIGJpb3Nf
cGFyc2VyX2dldF9lbmNvZGVyX2lkKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY19iaW9zICpk
Y2IsPGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgaSk8YnI+DQorezxicj4NCivCoCDCoCDCoCDC
oHN0cnVjdCBiaW9zX3BhcnNlciAqYnAgPSBCUF9GUk9NX0RDQihkY2IpOzxicj4NCivCoCDCoCDC
oCDCoHN0cnVjdCBncmFwaGljc19vYmplY3RfaWQgb2JqZWN0X2lkID0gZGFsX2dyYXBoaWNzX29i
amVjdF9pZF9pbml0KDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAsIEVOVU1fSURfVU5L
Tk9XTiwgT0JKRUNUX1RZUEVfVU5LTk9XTik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChi
cC0mZ3Q7b2JqZWN0X2luZm9fdGJsLnYxXzQtJmd0O251bWJlcl9vZl9wYXRoICZndDsgaSk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvYmplY3RfaWQgPSBvYmplY3RfaWRfZnJvbV9iaW9z
X29iamVjdF9pZCg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicC0mZ3Q7b2JqZWN0X2lu
Zm9fdGJsLnYxXzQtJmd0O2Rpc3BsYXlfcGF0aFtpXS5lbmNvZGVyb2JqaWQpOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqByZXR1cm4gb2JqZWN0X2lkOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0
aWMgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBiaW9zX3BhcnNlcl9nZXRfY29ubmVjdG9yX2lk
KDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKg
dWludDhfdCBpKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFyc2VyICpi
cCA9IEJQX0ZST01fRENCKGRjYik7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29i
amVjdF9pZCBvYmplY3RfaWQgPSBkYWxfZ3JhcGhpY3Nfb2JqZWN0X2lkX2luaXQoPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgMCwgRU5VTV9JRF9VTktOT1dOLCBPQkpFQ1RfVFlQRV9VTktO
T1dOKTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3Qgb2JqZWN0X2luZm9fdGFibGUgKnRibCA9ICZh
bXA7YnAtJmd0O29iamVjdF9pbmZvX3RibDs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZGlzcGxh
eV9vYmplY3RfaW5mb190YWJsZV92MV80ICp2MV80ID0gdGJsLSZndDt2MV80Ozxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqBpZiAodjFfNC0mZ3Q7bnVtYmVyX29mX3BhdGggJmd0OyBpKSB7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogSWYgZGlzcGxheV9vYmppZCBpcyBnZW5lcmljIG9i
amVjdCBpZCzCoCB0aGUgZW5jb2Rlck9iajxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAq
IC9leHRlbmNvZGVyb2JqSWQgc2hvdWxkIGJlIDA8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAodjFfNC0mZ3Q7ZGlzcGxheV9w
YXRoW2ldLmVuY29kZXJvYmppZCAhPSAwICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2MV80LSZndDtkaXNwbGF5X3BhdGhbaV0u
ZGlzcGxheV9vYmppZCAhPSAwKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoG9iamVjdF9pZCA9IG9iamVjdF9pZF9mcm9tX2Jpb3Nfb2JqZWN0X2lkKDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHYx
XzQtJmd0O2Rpc3BsYXlfcGF0aFtpXS5kaXNwbGF5X29iamlkKTs8YnI+DQorwqAgwqAgwqAgwqB9
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBvYmplY3RfaWQ7PGJyPg0KK308YnI+DQor
PGJyPg0KKzxicj4NCisvKsKgIFRPRE86wqAgR2V0TnVtYmVyT2ZTcmMqLzxicj4NCis8YnI+DQor
c3RhdGljIHVpbnQzMl90IGJpb3NfcGFyc2VyX2dldF9kc3RfbnVtYmVyKHN0cnVjdCBkY19iaW9z
ICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBpZCk8YnI+
DQorezxicj4NCivCoCDCoCDCoCDCoC8qIGNvbm5lY3RvciBoYXMgMSBEZXN0LCBlbmNvZGVyIGhh
cyAwIERlc3QgKi88YnI+DQorwqAgwqAgwqAgwqBzd2l0Y2ggKGlkLnR5cGUpIHs8YnI+DQorwqAg
wqAgwqAgwqBjYXNlIE9CSkVDVF9UWVBFX0VOQ09ERVI6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIDA7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBPQkpFQ1RfVFlQRV9DT05ORUNU
T1I6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIDE7PGJyPg0KK8KgIMKgIMKg
IMKgZGVmYXVsdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQor
wqAgwqAgwqAgwqB9PGJyPg0KK308YnI+DQorPGJyPg0KKy8qwqAgcmVtb3ZlZCBnZXRTcmNPYmpM
aXN0LCBnZXREZXN0T2JqTGlzdCovPGJyPg0KKzxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBf
cmVzdWx0IGJpb3NfcGFyc2VyX2dldF9zcmNfb2JqKHN0cnVjdCBkY19iaW9zICpkY2IsPGJyPg0K
K8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBvYmplY3RfaWQsIHVpbnQzMl90
IGluZGV4LDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBncmFwaGljc19vYmplY3RfaWQgKnNyY19v
YmplY3RfaWQpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYmlvc19wYXJzZXIgKmJw
ID0gQlBfRlJPTV9EQ0IoZGNiKTs8YnI+DQorwqAgwqAgwqAgwqB1bnNpZ25lZCBpbnQgaTs8YnI+
DQorwqAgwqAgwqAgwqBlbnVtIGJwX3Jlc3VsdMKgIGJwX3Jlc3VsdCA9IEJQX1JFU1VMVF9CQURJ
TlBVVDs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZ3JhcGhpY3Nfb2JqZWN0X2lkIG9ial9pZCA9
IHswfTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3Qgb2JqZWN0X2luZm9fdGFibGUgKnRibCA9ICZh
bXA7YnAtJmd0O29iamVjdF9pbmZvX3RibDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFz
cmNfb2JqZWN0X2lkKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBicF9yZXN1
bHQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHN3aXRjaCAob2JqZWN0X2lkLnR5cGUpIHs8YnI+
DQorwqAgwqAgwqAgwqAvKiBFbmNvZGVyJiMzOTtzIFNvdXJjZSBpcyBHUFUuwqAgQklPUyBkb2Vz
IG5vdCBwcm92aWRlIEdQVSwgc2luY2UgYWxsPGJyPg0KK8KgIMKgIMKgIMKgICogZGlzcGxheXBh
dGhzIHBvaW50IHRvIHNhbWUgR1BVICgweDExMDApLsKgIEhhcmRjb2RlIEdQVSBvYmplY3QgdHlw
ZTxicj4NCivCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoGNhc2UgT0JKRUNUX1RZUEVf
RU5DT0RFUjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBUT0RPOiBzaW5jZSBudW0g
b2Ygc3JjIG11c3QgYmUgbGVzcyB0aGFuIDIuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICogSWYgZm91bmQgaW4gZm9yIGxvb3AsIHNob3VsZCBicmVhay48YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgKiBEQUwyIGltcGxlbWVudGF0aW9uIG1heSBiZSBjaGFuZ2VkIHRvbzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGZvciAoaSA9IDA7IGkgJmx0OyB0YmwtJmd0O3YxXzQtJmd0O251bWJlcl9vZl9wYXRoOyBpKysp
IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvYmpfaWQgPSBvYmpl
Y3RfaWRfZnJvbV9iaW9zX29iamVjdF9pZCg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB0YmwtJmd0O3YxXzQtJmd0O2Rpc3BsYXlfcGF0aFtpXS5lbmNvZGVyb2JqaWQp
Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChvYmplY3RfaWQu
dHlwZSA9PSBvYmpfaWQudHlwZSAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGEgaHJlZj0iaHR0cDovL29i
amVjdF9pZC5pZCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+b2JqZWN0X2lkLmlk
PC9hPiA9PSA8YSBocmVmPSJodHRwOi8vb2JqX2lkLmlkIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdl
dD0iX2JsYW5rIj5vYmpfaWQuaWQ8L2E+ICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBv
YmplY3RfaWQuZW51bV9pZCA9PTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9ial9p
ZC5lbnVtX2lkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKnNyY19vYmplY3RfaWQgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9iamVjdF9pZF9mcm9tX2Jpb3Nfb2JqZWN0X2lkKDB4MTEw
MCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
LyogYnJlYWs7ICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBicF9yZXN1bHQgPSBCUF9SRVNVTFRfT0s7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
YnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSBPQkpFQ1RfVFlQRV9DT05ORUNUT1I6PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChpID0gMDsgaSAmbHQ7IHRibC0mZ3Q7djFfNC0m
Z3Q7bnVtYmVyX29mX3BhdGg7IGkrKykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG9ial9pZCA9IG9iamVjdF9pZF9mcm9tX2Jpb3Nfb2JqZWN0X2lkKDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRibC0mZ3Q7djFf
NC0mZ3Q7ZGlzcGxheV9wYXRoW2ldLmRpc3BsYXlfb2JqaWQpOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAob2JqZWN0X2lkLnR5cGUgPT0gb2JqX2lk
LnR5cGUgJmFtcDsmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoDxhIGhyZWY9Imh0dHA6Ly9vYmplY3RfaWQuaWQiIHJlbD0ibm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPm9iamVjdF9pZC5pZDwvYT4gPT0gPGEgaHJlZj0iaHR0cDovL29i
al9pZC5pZCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+b2JqX2lkLmlkPC9hPiAm
YW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgb2JqZWN0X2lkLmVudW1faWQgPT0gb2JqX2lkLmVudW1faWQpIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqc3Jj
X29iamVjdF9pZCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgb2JqZWN0X2lkX2Zyb21fYmlvc19vYmplY3RfaWQoPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGJsLSZndDt2MV80LSZndDtkaXNw
bGF5X3BhdGhbaV0uZW5jb2Rlcm9iamlkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBicmVhazsgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJwX3Jlc3VsdCA9IEJQX1JFU1VMVF9PSzs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoH08YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIGJwX3Jlc3VsdDs8YnI+DQorfTxicj4NCis8YnI+
DQorc3RhdGljIGVudW0gYnBfcmVzdWx0IGJpb3NfcGFyc2VyX2dldF9kc3Rfb2JqKHN0cnVjdCBk
Y19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBv
YmplY3RfaWQsIHVpbnQzMl90IGluZGV4LDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBncmFwaGlj
c19vYmplY3RfaWQgKmRlc3Rfb2JqZWN0X2lkKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3Ry
dWN0IGJpb3NfcGFyc2VyICpicCA9IEJQX0ZST01fRENCKGRjYik7PGJyPg0KK8KgIMKgIMKgIMKg
dW5zaWduZWQgaW50IGk7PGJyPg0KK8KgIMKgIMKgIMKgZW51bSBicF9yZXN1bHTCoCBicF9yZXN1
bHQgPSBCUF9SRVNVTFRfQkFESU5QVVQ7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNz
X29iamVjdF9pZCBvYmpfaWQgPSB7MH07PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IG9iamVjdF9p
bmZvX3RhYmxlICp0YmwgPSAmYW1wO2JwLSZndDtvYmplY3RfaW5mb190Ymw7PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoGlmICghZGVzdF9vYmplY3RfaWQpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIEJQX1JFU1VMVF9CQURJTlBVVDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
c3dpdGNoIChvYmplY3RfaWQudHlwZSkgezxicj4NCivCoCDCoCDCoCDCoGNhc2UgT0JKRUNUX1RZ
UEVfRU5DT0RFUjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBUT0RPOiBzaW5jZSBu
dW0gb2Ygc3JjIG11c3QgYmUgbGVzcyB0aGFuIDIuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgICogSWYgZm91bmQgaW4gZm9yIGxvb3AsIHNob3VsZCBicmVhay48YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgKiBEQUwyIGltcGxlbWVudGF0aW9uIG1heSBiZSBjaGFuZ2VkIHRvbzxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGZvciAoaSA9IDA7IGkgJmx0OyB0YmwtJmd0O3YxXzQtJmd0O251bWJlcl9vZl9wYXRoOyBp
KyspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvYmpfaWQgPSBv
YmplY3RfaWRfZnJvbV9iaW9zX29iamVjdF9pZCg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0YmwtJmd0O3YxXzQtJmd0O2Rpc3BsYXlfcGF0aFtp
XS5lbmNvZGVyb2JqaWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChvYmplY3RfaWQudHlwZSA9PSBvYmpfaWQudHlwZSAmYW1wOyZhbXA7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGEg
aHJlZj0iaHR0cDovL29iamVjdF9pZC5pZCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFu
ayI+b2JqZWN0X2lkLmlkPC9hPiA9PSA8YSBocmVmPSJodHRwOi8vb2JqX2lkLmlkIiByZWw9Im5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5vYmpfaWQuaWQ8L2E+ICZhbXA7JmFtcDs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBvYmplY3RfaWQuZW51bV9pZCA9PTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoG9ial9pZC5lbnVtX2lkKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKmRlc3Rfb2JqZWN0X2lkID08YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvYmplY3Rf
aWRfZnJvbV9iaW9zX29iamVjdF9pZCg8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB0YmwtJmd0O3YxXzQtJmd0O2Rpc3BsYXlfcGF0aFtpXS5kaXNw
bGF5X29iamlkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAvKiBicmVhazsgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGJwX3Jlc3VsdCA9IEJQX1JFU1VMVF9PSzs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKg
IMKgIMKgcmV0dXJuIGJwX3Jlc3VsdDs8YnI+DQorfTxicj4NCis8YnI+DQorPGJyPg0KKy8qIGZy
b20gZ3JhcGhpY3Nfb2JqZWN0X2lkLCBmaW5kIGRpc3BsYXkgcGF0aCB3aGljaCBpbmNsdWRlcyB0
aGUgb2JqZWN0X2lkICovPGJyPg0KK3N0YXRpYyBzdHJ1Y3QgYXRvbV9kaXNwbGF5X29iamVjdF9w
YXRoX3YyICpnZXRfYmlvc19vYmplY3QoPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFy
c2VyICpicCw8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZ3JhcGhpY3Nfb2JqZWN0X2lkIGlkKTxi
cj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgdW5zaWduZWQgaW50IGk7PGJyPg0KK8KgIMKgIMKgIMKg
c3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBvYmpfaWQgPSB7MH07PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoHN3aXRjaCAoaWQudHlwZSkgezxicj4NCivCoCDCoCDCoCDCoGNhc2UgT0JKRUNUX1RZ
UEVfRU5DT0RFUjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgKGkgPSAwOyBpICZs
dDsgYnAtJmd0O29iamVjdF9pbmZvX3RibC52MV80LSZndDtudW1iZXJfb2ZfcGF0aDsgaSsrKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgb2JqX2lkID0gb2JqZWN0
X2lkX2Zyb21fYmlvc19vYmplY3RfaWQoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgYnAtJmd0O29iamVjdF9pbmZvX3RibC52MV80LSZndDtkaXNwbGF5X3BhdGhbaV0u
ZW5jb2Rlcm9iamlkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBp
ZiAoaWQudHlwZSA9PSBvYmpfaWQudHlwZSAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgPGEgaHJlZj0iaHR0
cDovL2lkLmlkIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5pZC5pZDwvYT4gPT0g
PGEgaHJlZj0iaHR0cDovL29ial9pZC5pZCIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFu
ayI+b2JqX2lkLmlkPC9hPiAmYW1wOyZhbXA7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWQuZW51bV9p
ZCA9PSBvYmpfaWQuZW51bV9pZCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm48YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAmYW1wO2JwLSZndDtvYmplY3RfaW5mb190YmwudjFfNC0mZ3Q7
ZGlzcGxheV9wYXRoW2ldOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAg
wqAgwqAgwqBjYXNlIE9CSkVDVF9UWVBFX0NPTk5FQ1RPUjo8YnI+DQorwqAgwqAgwqAgwqBjYXNl
IE9CSkVDVF9UWVBFX0dFTkVSSUM6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogQm90
aCBHZW5lcmljIGFuZCBDb25uZWN0b3IgT2JqZWN0IElEPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICogd2lsbCBiZSBzdG9yZWQgb24gZGlzcGxheV9vYmppZDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yIChpID0gMDsg
aSAmbHQ7IGJwLSZndDtvYmplY3RfaW5mb190YmwudjFfNC0mZ3Q7bnVtYmVyX29mX3BhdGg7IGkr
Kykgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9ial9pZCA9IG9i
amVjdF9pZF9mcm9tX2Jpb3Nfb2JqZWN0X2lkKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJwLSZndDtvYmplY3RfaW5mb190YmwudjFfNC0mZ3Q7ZGlzcGxheV9wYXRo
W2ldLmRpc3BsYXlfb2JqaWQ8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqApOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChpZC50eXBl
ID09IG9ial9pZC50eXBlICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA8YSBocmVmPSJodHRwOi8vaWQuaWQi
IHJlbD0ibm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmlkLmlkPC9hPiA9PSA8YSBocmVmPSJo
dHRwOi8vb2JqX2lkLmlkIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5vYmpfaWQu
aWQ8L2E+ICZhbXA7JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZC5lbnVtX2lkID09IG9ial9p
ZC5lbnVtX2lkKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCZhbXA7YnAtJmd0O29iamVjdF9pbmZvX3RibC52MV80LSZndDtkaXNwbGF5X3Bh
dGhbaV07PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoGRl
ZmF1bHQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7PGJyPg0KK8Kg
IMKgIMKgIMKgfTxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlv
c19wYXJzZXJfZ2V0X2kyY19pbmZvKHN0cnVjdCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKg
IMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBpZCw8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3Qg
Z3JhcGhpY3Nfb2JqZWN0X2kyY19pbmZvICppbmZvKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKg
dWludDMyX3Qgb2Zmc2V0Ozxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9tX2Rpc3BsYXlfb2Jq
ZWN0X3BhdGhfdjIgKm9iamVjdDs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYXRvbV9jb21tb25f
cmVjb3JkX2hlYWRlciAqaGVhZGVyOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9tX2kyY19y
ZWNvcmQgKnJlY29yZDs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYmlvc19wYXJzZXIgKmJwID0g
QlBfRlJPTV9EQ0IoZGNiKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFpbmZvKTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfQkFESU5QVVQ7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoG9iamVjdCA9IGdldF9iaW9zX29iamVjdChicCwgaWQpOzxicj4N
Cis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIW9iamVjdCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqByZXR1cm4gQlBfUkVTVUxUX0JBRElOUFVUOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBv
ZmZzZXQgPSBvYmplY3QtJmd0O2Rpc3BfcmVjb3Jkb2Zmc2V0ICsgYnAtJmd0O29iamVjdF9pbmZv
X3RibF9vZmZzZXQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGZvciAoOzspIHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBoZWFkZXIgPSBHRVRfSU1BR0Uoc3RydWN0IGF0b21fY29tbW9u
X3JlY29yZF9oZWFkZXIsIG9mZnNldCk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGlmICghaGVhZGVyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJldHVybiBCUF9SRVNVTFRfQkFEQklPU1RBQkxFOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpZiAoaGVhZGVyLSZndDtyZWNvcmRfdHlwZSA9PSBMQVNUX1JFQ09SRF9UWVBF
IHx8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIWhlYWRlci0mZ3Q7
cmVjb3JkX3NpemUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJl
YWs7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChoZWFkZXItJmd0O3Jl
Y29yZF90eXBlID09IEFUT01fSTJDX1JFQ09SRF9UWVBFPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJmFtcDsmYW1wOyBzaXplb2Yoc3RydWN0IGF0b21faTJjX3JlY29y
ZCkgJmx0Oz08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBoZWFkZXItJmd0O3JlY29y
ZF9zaXplKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogZ2V0
IHRoZSBJMkMgaW5mbyAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHJlY29yZCA9IChzdHJ1Y3QgYXRvbV9pMmNfcmVjb3JkICopIGhlYWRlcjs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGdldF9ncGlvX2kyY19pbmZv
KGJwLCByZWNvcmQsIGluZm8pID09PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgQlBfUkVTVUxUX09LKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfT0s7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBvZmZzZXQg
Kz0gaGVhZGVyLSZndDtyZWNvcmRfc2l6ZTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfTk9SRUNPUkQ7PGJyPg0KK308YnI+DQorPGJy
Pg0KK3N0YXRpYyBlbnVtIGJwX3Jlc3VsdCBnZXRfZ3Bpb19pMmNfaW5mbyg8YnI+DQorwqAgwqAg
wqAgwqBzdHJ1Y3QgYmlvc19wYXJzZXIgKmJwLDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9t
X2kyY19yZWNvcmQgKnJlY29yZCw8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZ3JhcGhpY3Nfb2Jq
ZWN0X2kyY19pbmZvICppbmZvKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGF0b21f
Z3Bpb19waW5fbHV0X3YyXzEgKmhlYWRlcjs8YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCBjb3Vu
dCA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgdW5zaWduZWQgaW50IHRhYmxlX2luZGV4ID0gMDs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFpbmZvKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBCUF9SRVNVTFRfQkFESU5QVVQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8q
IGdldCB0aGUgR1BJT19JMkMgaW5mbyAqLzxicj4NCivCoCDCoCDCoCDCoGlmICghREFUQV9UQUJM
RVMoZ3Bpb19waW5fbHV0KSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBf
UkVTVUxUX0JBREJJT1NUQUJMRTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaGVhZGVyID0gR0VU
X0lNQUdFKHN0cnVjdCBhdG9tX2dwaW9fcGluX2x1dF92Ml8xLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoERBVEFfVEFCTEVT
KGdwaW9fcGluX2x1dCkpOzxicj4NCivCoCDCoCDCoCDCoGlmICghaGVhZGVyKTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfQkFEQklPU1RBQkxFOzxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqBpZiAoc2l6ZW9mKHN0cnVjdCBhdG9tX2NvbW1vbl90YWJsZV9oZWFk
ZXIpICs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzaXplb2Yoc3Ry
dWN0IGF0b21fZ3Bpb19waW5fYXNzaWdubWVudCkgJmd0Ozxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGxlMTZfdG9fY3B1KGhlYWRlci0mZ3Q7dGFibGVfaGVhZGVyLnN0
cnVjdHVyZXNpemUpKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNV
TFRfQkFEQklPU1RBQkxFOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBUT0RPOiBpcyB2ZXJz
aW9uIGNoYW5nZT8gKi88YnI+DQorwqAgwqAgwqAgwqBpZiAoaGVhZGVyLSZndDt0YWJsZV9oZWFk
ZXIuY29udGVudF9yZXZpc2lvbiAhPSAxKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dHVybiBCUF9SRVNVTFRfVU5TVVBQT1JURUQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIGdl
dCBkYXRhIGNvdW50ICovPGJyPg0KK8KgIMKgIMKgIMKgY291bnQgPSAobGUxNl90b19jcHUoaGVh
ZGVyLSZndDt0YWJsZV9oZWFkZXIuc3RydWN0dXJlc2l6ZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAtIHNpemVvZihzdHJ1Y3QgYXRvbV9jb21tb25fdGFibGVfaGVh
ZGVyKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAvIHNpemVvZihzdHJ1Y3QgYXRvbV9ncGlvX3Bpbl9hc3NpZ25tZW50KTs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgdGFibGVfaW5kZXggPSByZWNvcmQtJmd0O2kyY19pZMKgICZhbXA7IEkyQ19I
V19MQU5FX01VWDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKGNvdW50ICZsdDsgdGFibGVf
aW5kZXgpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBib29sIGZpbmRfdmFsaWQgPSBm
YWxzZTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZm9yICh0YWJsZV9pbmRl
eCA9IDA7IHRhYmxlX2luZGV4ICZsdDsgY291bnQ7IHRhYmxlX2luZGV4KyspIHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoKChyZWNvcmQtJmd0O2kyY19pZCAm
YW1wOyBJMkNfSFdfQ0FQKSA9PSAoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgaGVhZGVyLSZndDtncGlvX3Bpblt0YWJsZV9pbmRleF0uZ3Bpb19pZCAmYW1wOzxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEkyQ19IV19DQVApKSAmYW1wOyZhbXA7PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKChyZWNvcmQtJmd0O2kyY19pZCAm
YW1wOyBJMkNfSFdfRU5HSU5FX0lEX01BU0spwqAgPT08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAoaGVhZGVyLSZndDtncGlvX3Bpblt0YWJsZV9pbmRleF0uZ3Bpb19p
ZCAmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEkyQ19IV19FTkdJTkVfSURfTUFTSykpICZhbXA7
JmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoKHJlY29yZC0m
Z3Q7aTJjX2lkICZhbXA7IEkyQ19IV19MQU5FX01VWCkgPT08YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAoaGVhZGVyLSZndDtncGlvX3Bpblt0YWJsZV9pbmRleF0uZ3Bp
b19pZCAmYW1wOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEkyQ19IV19MQU5FX01V
WCkpKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLyogc3RpbGwgdmFsaWQgKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBmaW5kX3ZhbGlkID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIElmIHdlIGRvbiYjMzk7dCBmaW5kIHRoZSBl
bnRyeSB0aGF0IHdlIGFyZSBsb29raW5nIGZvciB0aGVuPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICrCoCB3ZSB3aWxsIHJldHVybiBCUF9SZXN1bHRfQmFkQmlvc1RhYmxlLjxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChmaW5kX3ZhbGlkID09IGZhbHNlKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiBCUF9SRVNVTFRfQkFEQklPU1RBQkxFOzxicj4NCivCoCDCoCDCoCDCoH08
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogZ2V0IHRoZSBHUElPX0kyQ19JTkZPICovPGJyPg0K
K8KgIMKgIMKgIMKgaW5mby0mZ3Q7aTJjX2h3X2Fzc2lzdCA9IChyZWNvcmQtJmd0O2kyY19pZCAm
YW1wOyBJMkNfSFdfQ0FQKSA/IHRydWUgOiBmYWxzZTs8YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZn
dDtpMmNfbGluZSA9IHJlY29yZC0mZ3Q7aTJjX2lkICZhbXA7IEkyQ19IV19MQU5FX01VWDs8YnI+
DQorwqAgwqAgwqAgwqBpbmZvLSZndDtpMmNfZW5naW5lX2lkID0gKHJlY29yZC0mZ3Q7aTJjX2lk
ICZhbXA7IEkyQ19IV19FTkdJTkVfSURfTUFTSykgJmd0OyZndDsgNDs8YnI+DQorwqAgwqAgwqAg
wqBpbmZvLSZndDtpMmNfc2xhdmVfYWRkcmVzcyA9IHJlY29yZC0mZ3Q7aTJjX3NsYXZlX2FkZHI7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIFRPRE86IGNoZWNrIGhvdyB0byBnZXQgcmVnaXN0
ZXIgb2Zmc2V0IGZvciBlbiwgWSwgZXRjLiAqLzxicj4NCivCoCDCoCDCoCDCoGluZm8tJmd0O2dw
aW9faW5mby5jbGtfYV9yZWdpc3Rlcl9pbmRleCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgbGUxNl90b19jcHUoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgaGVhZGVyLSZndDtncGlvX3Bpblt0YWJsZV9pbmRleF0uZGF0YV9hX3JlZ19p
bmRleCk7PGJyPg0KK8KgIMKgIMKgIMKgaW5mby0mZ3Q7Z3Bpb19pbmZvLmNsa19hX3NoaWZ0ID08
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBoZWFkZXItJmd0O2dwaW9f
cGluW3RhYmxlX2luZGV4XS5ncGlvX2JpdHNoaWZ0Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBy
ZXR1cm4gQlBfUkVTVUxUX09LOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgZW51bSBicF9y
ZXN1bHQgZ2V0X3ZvbHRhZ2VfZGRjX2luZm9fdjQoPGJyPg0KK8KgIMKgIMKgIMKgdWludDhfdCAq
aTJjX2xpbmUsPGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgaW5kZXgsPGJyPg0KK8KgIMKgIMKg
IMKgc3RydWN0IGF0b21fY29tbW9uX3RhYmxlX2hlYWRlciAqaGVhZGVyLDxicj4NCivCoCDCoCDC
oCDCoHVpbnQ4X3QgKmFkZHJlc3MpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBlbnVtIGJwX3Jl
c3VsdCByZXN1bHQgPSBCUF9SRVNVTFRfTk9SRUNPUkQ7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0
IGF0b21fdm9sdGFnZV9vYmplY3RzX2luZm9fdjRfMSAqaW5mbyA9PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgKHN0cnVjdCBhdG9tX3ZvbHRhZ2Vfb2JqZWN0c19pbmZvX3Y0XzEgKikgYWRk
cmVzczs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgdWludDhfdCAqdm9sdGFnZV9jdXJyZW50X29i
amVjdCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKHVpbnQ4X3QgKikgKCZhbXA7KGlu
Zm8tJmd0O3ZvbHRhZ2Vfb2JqZWN0WzBdKSk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHdoaWxl
ICgoYWRkcmVzcyArIGxlMTZfdG9fY3B1KGhlYWRlci0mZ3Q7c3RydWN0dXJlc2l6ZSkpICZndDs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB2b2x0YWdlX2N1cnJlbnRfb2JqZWN0KSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IGF0b21faTJjX3ZvbHRhZ2Vfb2JqZWN0X3Y0ICpvYmpl
Y3QgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChzdHJ1Y3QgYXRv
bV9pMmNfdm9sdGFnZV9vYmplY3RfdjQgKik8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB2b2x0YWdlX2N1
cnJlbnRfb2JqZWN0Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAob2Jq
ZWN0LSZndDtoZWFkZXIudm9sdGFnZV9tb2RlID09PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgQVRPTV9JTklUX1ZPTFRBR0VfUkVHVUxBVE9SKSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG9iamVjdC0mZ3Q7aGVhZGVyLnZvbHRh
Z2VfdHlwZSA9PSBpbmRleCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCppMmNfbGluZSA9IG9iamVjdC0mZ3Q7aTJjX2lkIF4gMHg5MDs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHQg
PSBCUF9SRVNVTFRfT0s7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgfTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgdm9sdGFnZV9jdXJyZW50X29iamVjdCArPTxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxlMTZfdG9fY3B1KG9iamVjdC0m
Z3Q7aGVhZGVyLm9iamVjdF9zaXplKTs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKg
IMKgcmV0dXJuIHJlc3VsdDs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBfcmVz
dWx0IGJpb3NfcGFyc2VyX2dldF90aGVybWFsX2RkY19pbmZvKDxicj4NCivCoCDCoCDCoCDCoHN0
cnVjdCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgaTJjX2NoYW5uZWxf
aWQsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pMmNfaW5mbyAqaW5m
byk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBiaW9zX3BhcnNlciAqYnAgPSBCUF9G
Uk9NX0RDQihkY2IpOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBpMmNfaWRfY29uZmlnX2FjY2Vz
cyAqY29uZmlnOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9tX2kyY19yZWNvcmQgcmVjb3Jk
Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWluZm8pPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIEJQX1JFU1VMVF9CQURJTlBVVDs8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgY29uZmlnID0gKHN0cnVjdCBpMmNfaWRfY29uZmlnX2FjY2VzcyAqKSAmYW1wO2kyY19jaGFu
bmVsX2lkOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZWNvcmQuaTJjX2lkID0gY29uZmlnLSZn
dDtiZkhXX0NhcGFibGU7PGJyPg0KK8KgIMKgIMKgIMKgcmVjb3JkLmkyY19pZCB8PSBjb25maWct
Jmd0O2JmSTJDX0xpbmVNdXg7PGJyPg0KK8KgIMKgIMKgIMKgcmVjb3JkLmkyY19pZCB8PSBjb25m
aWctJmd0O2JmSFdfRW5naW5lSUQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBnZXRf
Z3Bpb19pMmNfaW5mbyhicCwgJmFtcDtyZWNvcmQsIGluZm8pOzxicj4NCit9PGJyPg0KKzxicj4N
CitzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlvc19wYXJzZXJfZ2V0X3ZvbHRhZ2VfZGRjX2luZm8o
c3RydWN0IGRjX2Jpb3MgKmRjYiw8YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCBpbmRleCw8YnI+
DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZ3JhcGhpY3Nfb2JqZWN0X2kyY19pbmZvICppbmZvKTxicj4N
Cit7PGJyPg0KK8KgIMKgIMKgIMKgdWludDhfdCBpMmNfbGluZSA9IDA7PGJyPg0KK8KgIMKgIMKg
IMKgZW51bSBicF9yZXN1bHQgcmVzdWx0ID0gQlBfUkVTVUxUX05PUkVDT1JEOzxicj4NCivCoCDC
oCDCoCDCoHVpbnQ4X3QgKnZvbHRhZ2VfaW5mb19hZGRyZXNzOzxicj4NCivCoCDCoCDCoCDCoHN0
cnVjdCBhdG9tX2NvbW1vbl90YWJsZV9oZWFkZXIgKmhlYWRlcjs8YnI+DQorwqAgwqAgwqAgwqBz
dHJ1Y3QgYXRvbV9kYXRhX3JldmlzaW9uIHJldmlzaW9uID0gezB9Ozxicj4NCivCoCDCoCDCoCDC
oHN0cnVjdCBiaW9zX3BhcnNlciAqYnAgPSBCUF9GUk9NX0RDQihkY2IpOzxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqBpZiAoIURBVEFfVEFCTEVTKHZvbHRhZ2VvYmplY3RfaW5mbykpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIHJlc3VsdDs8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgdm9sdGFnZV9pbmZvX2FkZHJlc3MgPSBnZXRfaW1hZ2UoJmFtcDticC0mZ3Q7YmFzZSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQVRBX1RBQkxFUyh2b2x0YWdl
b2JqZWN0X2luZm8pLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNp
emVvZihzdHJ1Y3QgYXRvbV9jb21tb25fdGFibGVfaGVhZGVyKSk7PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoGhlYWRlciA9IChzdHJ1Y3QgYXRvbV9jb21tb25fdGFibGVfaGVhZGVyICopIHZvbHRh
Z2VfaW5mb19hZGRyZXNzOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBnZXRfYXRvbV9kYXRhX3Rh
YmxlX3JldmlzaW9uKGhlYWRlciwgJmFtcDtyZXZpc2lvbik7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoHN3aXRjaCAocmV2aXNpb24ubWFqb3IpIHs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIDQ6PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHJldmlzaW9uLm1pbm9yICE9IDEpPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmVzdWx0ID0gZ2V0X3ZvbHRhZ2VfZGRjX2luZm9fdjQoJmFtcDtpMmNf
bGluZSwgaW5kZXgsIGhlYWRlciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB2b2x0YWdlX2luZm9fYWRkcmVzcyk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
YnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAocmVz
dWx0ID09IEJQX1JFU1VMVF9PSyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHQg
PSBiaW9zX3BhcnNlcl9nZXRfdGhlcm1hbF9kZGNfaW5mbyhkY2IsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaTJjX2xpbmUsIGluZm8pOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqByZXR1cm4gcmVzdWx0Ozxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgZW51bSBi
cF9yZXN1bHQgYmlvc19wYXJzZXJfZ2V0X2hwZF9pbmZvKDxicj4NCivCoCDCoCDCoCDCoHN0cnVj
dCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9p
ZCBpZCw8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZ3JhcGhpY3Nfb2JqZWN0X2hwZF9pbmZvICpp
bmZvKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFyc2VyICpicCA9IEJQ
X0ZST01fRENCKGRjYik7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGF0b21fZGlzcGxheV9vYmpl
Y3RfcGF0aF92MiAqb2JqZWN0Ozxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9tX2hwZF9pbnRf
cmVjb3JkICpyZWNvcmQgPSBOVUxMOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWluZm8p
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEJQX1JFU1VMVF9CQURJTlBVVDs8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgb2JqZWN0ID0gZ2V0X2Jpb3Nfb2JqZWN0KGJwLCBpZCk7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICghb2JqZWN0KTxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfQkFESU5QVVQ7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoHJlY29yZCA9IGdldF9ocGRfcmVjb3JkKGJwLCBvYmplY3QpOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqBpZiAocmVjb3JkICE9IE5VTEwpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpbmZvLSZndDtocGRfaW50X2dwaW9fdWlkID0gcmVjb3JkLSZndDtwaW5faWQ7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgaW5mby0mZ3Q7aHBkX2FjdGl2ZSA9IHJlY29yZC0mZ3Q7cGx1
Z2luX3Bpbl9zdGF0ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVT
VUxUX09LOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJu
IEJQX1JFU1VMVF9OT1JFQ09SRDs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIHN0cnVjdCBh
dG9tX2hwZF9pbnRfcmVjb3JkICpnZXRfaHBkX3JlY29yZCg8YnI+DQorwqAgwqAgwqAgwqBzdHJ1
Y3QgYmlvc19wYXJzZXIgKmJwLDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9tX2Rpc3BsYXlf
b2JqZWN0X3BhdGhfdjIgKm9iamVjdCk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBh
dG9tX2NvbW1vbl9yZWNvcmRfaGVhZGVyICpoZWFkZXI7PGJyPg0KK8KgIMKgIMKgIMKgdWludDMy
X3Qgb2Zmc2V0Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIW9iamVjdCkgezxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoEJSRUFLX1RPX0RFQlVHR0VSKCk7IC8qIEludmFsaWQgb2Jq
ZWN0ICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7PGJyPg0KK8Kg
IMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBvZmZzZXQgPSBsZTE2X3RvX2NwdShv
YmplY3QtJmd0O2Rpc3BfcmVjb3Jkb2Zmc2V0KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCsgYnAtJmd0O29iamVjdF9pbmZvX3RibF9vZmZzZXQ7PGJyPg0KKzxicj4N
CivCoCDCoCDCoCDCoGZvciAoOzspIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBoZWFk
ZXIgPSBHRVRfSU1BR0Uoc3RydWN0IGF0b21fY29tbW9uX3JlY29yZF9oZWFkZXIsIG9mZnNldCk7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghaGVhZGVyKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBOVUxMOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoaGVhZGVyLSZndDtyZWNvcmRfdHlwZSA9PSBM
QVNUX1JFQ09SRF9UWVBFIHx8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIWhlYWRlci0mZ3Q7cmVjb3JkX3NpemUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlm
IChoZWFkZXItJmd0O3JlY29yZF90eXBlID09IEFUT01fSFBEX0lOVF9SRUNPUkRfVFlQRTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZhbXA7JmFtcDsgc2l6ZW9mKHN0
cnVjdCBhdG9tX2hwZF9pbnRfcmVjb3JkKSAmbHQ7PTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGhlYWRlci0mZ3Q7cmVjb3JkX3NpemUpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgcmV0dXJuIChzdHJ1Y3QgYXRvbV9ocGRfaW50X3JlY29yZCAqKSBoZWFk
ZXI7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG9mZnNldCArPSBoZWFkZXIt
Jmd0O3JlY29yZF9zaXplOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgcmV0dXJuIE5VTEw7PGJyPg0KK308YnI+DQorPGJyPg0KKy8qKjxicj4NCisgKiBiaW9zX3Bh
cnNlcl9nZXRfZ3Bpb19waW5faW5mbzxicj4NCisgKiBHZXQgR3Bpb1BpbiBpbmZvcm1hdGlvbiBv
ZiBpbnB1dCBncGlvIGlkPGJyPg0KKyAqPGJyPg0KKyAqIEBwYXJhbSBncGlvX2lkLCBHUElPIElE
PGJyPg0KKyAqIEBwYXJhbSBpbmZvLCBHcGlvUGluIGluZm9ybWF0aW9uIHN0cnVjdHVyZTxicj4N
CisgKiBAcmV0dXJuIEJpb3MgcGFyc2VyIHJlc3VsdCBjb2RlPGJyPg0KKyAqIEBub3RlPGJyPg0K
KyAqwqAgdG8gZ2V0IHRoZSBHUElPIFBJTiBJTkZPLCB3ZSBuZWVkOjxicj4NCisgKsKgIDEuIGdl
dCB0aGUgR1BJT19JRCBmcm9tIG90aGVyIG9iamVjdCB0YWJsZSwgc2VlIEdldEhQREluZm8oKTxi
cj4NCisgKsKgIDIuIGluIERBVEFfVEFCTEUuR1BJT19QaW5fTFVULCBzZWFyY2ggYWxsIHJlY29y
ZHMsPGJyPg0KKyAqwqAgwqAgwqB0byBnZXQgdGhlIHJlZ2lzdGVyQcKgIG9mZnNldC9tYXNrPGJy
Pg0KKyAqLzxicj4NCitzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlvc19wYXJzZXJfZ2V0X2dwaW9f
cGluX2luZm8oPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGRjX2Jpb3MgKmRjYiw8YnI+DQorwqAg
wqAgwqAgwqB1aW50MzJfdCBncGlvX2lkLDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBncGlvX3Bp
bl9pbmZvICppbmZvKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFyc2Vy
ICpicCA9IEJQX0ZST01fRENCKGRjYik7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGF0b21fZ3Bp
b19waW5fbHV0X3YyXzEgKmhlYWRlcjs8YnI+DQorwqAgwqAgwqAgwqB1aW50MzJfdCBjb3VudCA9
IDA7PGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgaSA9IDA7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoGlmICghREFUQV9UQUJMRVMoZ3Bpb19waW5fbHV0KSk8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX0JBREJJT1NUQUJMRTs8YnI+DQorPGJyPg0KK8KgIMKg
IMKgIMKgaGVhZGVyID0gR0VUX0lNQUdFKHN0cnVjdCBhdG9tX2dwaW9fcGluX2x1dF92Ml8xLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoERBVEFfVEFCTEVTKGdwaW9fcGluX2x1dCkpOzxicj4NCivCoCDC
oCDCoCDCoGlmICghaGVhZGVyKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBC
UF9SRVNVTFRfQkFEQklPU1RBQkxFOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoc2l6ZW9m
KHN0cnVjdCBhdG9tX2NvbW1vbl90YWJsZV9oZWFkZXIpICs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzaXplb2Yoc3RydWN0IGF0b21fZ3Bpb19waW5fbHV0X3YyXzEp
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmd0OyBsZTE2X3RvX2Nw
dShoZWFkZXItJmd0O3RhYmxlX2hlYWRlci5zdHJ1Y3R1cmVzaXplKSk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX0JBREJJT1NUQUJMRTs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgaWYgKGhlYWRlci0mZ3Q7dGFibGVfaGVhZGVyLmNvbnRlbnRfcmV2aXNpb24g
IT0gMSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX1VOU1VQ
UE9SVEVEOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBUZW1wb3JhcnkgaGFyZCBjb2RlIGdw
aW8gcGluIGluZm8gKi88YnI+DQorI2lmIGRlZmluZWQoRk9SX1NJTU5PV19CT09UKTxicj4NCivC
oCDCoCDCoCDCoHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3TCoCBhdG9tX2dw
aW9fcGluX2Fzc2lnbm1lbnTCoCBncGlvX3Bpbls4XSA9IHs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7MHg1ZGI1LCAwLCAwLCAxLCAwfSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7MHg1ZGI1
LCA4LCA4LCAyLCAwfSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB7MHg1ZGI1LCAweDEwLCAweDEwLCAzLCAwfSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7MHg1ZGI1LCAweDE4LCAweDE0LCA0
LCAwfSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB7MHg1ZGI1LCAweDFBLCAweDE4LCA1LCAwfSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB7MHg1ZGI1LCAweDFDLCAweDFDLCA2LCAwfSw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjb3VudCA9IDY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWVtbW92ZSho
ZWFkZXItJmd0O2dwaW9fcGluLCBncGlvX3Bpbiwgc2l6ZW9mKGdwaW9fcGluKSk7PGJyPg0KK8Kg
IMKgIMKgIMKgfTxicj4NCisjZWxzZTxicj4NCivCoCDCoCDCoCDCoGNvdW50ID0gKGxlMTZfdG9f
Y3B1KGhlYWRlci0mZ3Q7dGFibGVfaGVhZGVyLnN0cnVjdHVyZXNpemUpPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLSBzaXplb2Yoc3RydWN0IGF0b21fY29tbW9uX3Rh
YmxlX2hlYWRlcikpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgLyBzaXplb2Yoc3RydWN0IGF0b21fZ3Bpb19waW5fYXNzaWdubWVudCk7PGJyPg0K
KyNlbmRpZjxicj4NCivCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBjb3VudDsgKytpKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGhlYWRlci0mZ3Q7Z3Bpb19waW5baV0u
Z3Bpb19pZCAhPSBncGlvX2lkKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoGNvbnRpbnVlOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbmZvLSZn
dDtvZmZzZXQgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCh1aW50
MzJfdCkgbGUxNl90b19jcHUoPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaGVhZGVyLSZndDtncGlvX3BpbltpXS5kYXRhX2Ff
cmVnX2luZGV4KTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbmZvLSZndDtvZmZzZXRf
eSA9IGluZm8tJmd0O29mZnNldCArIDI7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW5m
by0mZ3Q7b2Zmc2V0X2VuID0gaW5mby0mZ3Q7b2Zmc2V0ICsgMTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpbmZvLSZndDtvZmZzZXRfbWFzayA9IGluZm8tJmd0O29mZnNldCAtIDE7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGluZm8tJmd0O21hc2sgPSAodWludDMy
X3QpICgxICZsdDsmbHQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aGVhZGVyLSZndDtncGlvX3BpbltpXS5ncGlvX2JpdHNoaWZ0KTs8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBpbmZvLSZndDttYXNrX3kgPSBpbmZvLSZndDttYXNrICsgMjs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpbmZvLSZndDttYXNrX2VuID0gaW5mby0mZ3Q7bWFzayArIDE7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW5mby0mZ3Q7bWFza19tYXNrID0gaW5mby0m
Z3Q7bWFzayAtIDE7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBC
UF9SRVNVTFRfT0s7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBy
ZXR1cm4gQlBfUkVTVUxUX05PUkVDT1JEOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgc3Ry
dWN0IGRldmljZV9pZCBkZXZpY2VfdHlwZV9mcm9tX2RldmljZV9pZCh1aW50MTZfdCBkZXZpY2Vf
aWQpPGJyPg0KK3s8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGRldmljZV9pZCByZXN1
bHRfZGV2aWNlX2lkOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBzd2l0Y2ggKGRldmljZV9pZCkg
ezxicj4NCivCoCDCoCDCoCDCoGNhc2UgQVRPTV9ESVNQTEFZX0xDRDFfU1VQUE9SVDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVW
SUNFX1RZUEVfTENEOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9kZXZpY2Vf
aWQuZW51bV9pZCA9IDE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQVRPTV9ESVNQTEFZX0RGUDFfU1VQUE9SVDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVW
SUNFX1RZUEVfREZQOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9kZXZpY2Vf
aWQuZW51bV9pZCA9IDE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQVRPTV9ESVNQTEFZX0RGUDJfU1VQUE9SVDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVW
SUNFX1RZUEVfREZQOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9kZXZpY2Vf
aWQuZW51bV9pZCA9IDI7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQVRPTV9ESVNQTEFZX0RGUDNfU1VQUE9SVDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVW
SUNFX1RZUEVfREZQOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9kZXZpY2Vf
aWQuZW51bV9pZCA9IDM7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQVRPTV9ESVNQTEFZX0RGUDRfU1VQUE9SVDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVW
SUNFX1RZUEVfREZQOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9kZXZpY2Vf
aWQuZW51bV9pZCA9IDQ7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQVRPTV9ESVNQTEFZX0RGUDVfU1VQUE9SVDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVW
SUNFX1RZUEVfREZQOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9kZXZpY2Vf
aWQuZW51bV9pZCA9IDU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGNhc2UgQVRPTV9ESVNQTEFZX0RGUDZfU1VQUE9SVDo8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVW
SUNFX1RZUEVfREZQOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdF9kZXZpY2Vf
aWQuZW51bV9pZCA9IDY7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
Kzxicj4NCivCoCDCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
QlJFQUtfVE9fREVCVUdHRVIoKTsgLyogSW52YWxpZCBkZXZpY2UgSWQgKi88YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lkLmRldmljZV90eXBlID0gREVWSUNFX1RZ
UEVfVU5LTk9XTjs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXN1bHRfZGV2aWNlX2lk
LmVudW1faWQgPSAwOzxicj4NCivCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqByZXR1cm4g
cmVzdWx0X2RldmljZV9pZDs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBfcmVz
dWx0IGJpb3NfcGFyc2VyX2dldF9kZXZpY2VfdGFnKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBk
Y19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGdyYXBoaWNzX29iamVjdF9pZCBj
b25uZWN0b3Jfb2JqZWN0X2lkLDxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IGRldmljZV90YWdf
aW5kZXgsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGNvbm5lY3Rvcl9kZXZpY2VfdGFnX2luZm8g
KmluZm8pPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYmlvc19wYXJzZXIgKmJwID0g
QlBfRlJPTV9EQ0IoZGNiKTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYXRvbV9kaXNwbGF5X29i
amVjdF9wYXRoX3YyICpvYmplY3Q7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICghaW5mbyk8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX0JBRElOUFVUOzxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBnZXRCaW9zT2JqZWN0IHdpbGwgcmV0dXJuIE1YTSBv
YmplY3QgKi88YnI+DQorwqAgwqAgwqAgwqBvYmplY3QgPSBnZXRfYmlvc19vYmplY3QoYnAsIGNv
bm5lY3Rvcl9vYmplY3RfaWQpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIW9iamVjdCkg
ezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEJSRUFLX1RPX0RFQlVHR0VSKCk7IC8qIElu
dmFsaWQgb2JqZWN0IGlkICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIEJQ
X1JFU1VMVF9CQURJTlBVVDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoGluZm8tJmd0O2FjcGlfZGV2aWNlID0gMDsgLyogQklPUyBubyBsb25nZXIgcHJvdmlkZXMg
dGhpcyAqLzxicj4NCivCoCDCoCDCoCDCoGluZm8tJmd0O2Rldl9pZCA9IGRldmljZV90eXBlX2Zy
b21fZGV2aWNlX2lkKG9iamVjdC0mZ3Q7ZGV2aWNlX3RhZyk7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoHJldHVybiBCUF9SRVNVTFRfT0s7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyBlbnVt
IGJwX3Jlc3VsdCBnZXRfc3NfaW5mb192NF8xKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBiaW9z
X3BhcnNlciAqYnAsPGJyPg0KK8KgIMKgIMKgIMKgdWludDMyX3QgaWQsPGJyPg0KK8KgIMKgIMKg
IMKgdWludDMyX3QgaW5kZXgsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IHNwcmVhZF9zcGVjdHJ1
bV9pbmZvICpzc19pbmZvKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgZW51bSBicF9yZXN1bHQg
cmVzdWx0ID0gQlBfUkVTVUxUX09LOzxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBhdG9tX2Rpc3Bs
YXlfY29udHJvbGxlcl9pbmZvX3Y0XzEgKmRpc3BfY250bF90YmwgPSBOVUxMOzxicj4NCivCoCDC
oCDCoCDCoHN0cnVjdCBhdG9tX3NtdV9pbmZvX3YzXzEgKnNtdV90YmwgPSBOVUxMOzxicj4NCis8
YnI+DQorwqAgwqAgwqAgwqBpZiAoIXNzX2luZm8pPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgcmV0dXJuIEJQX1JFU1VMVF9CQURJTlBVVDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYg
KCFEQVRBX1RBQkxFUyhkY2VfaW5mbykpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0
dXJuIEJQX1JFU1VMVF9CQURCSU9TVEFCTEU7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICgh
REFUQV9UQUJMRVMoc211X2luZm8pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biBCUF9SRVNVTFRfQkFEQklPU1RBQkxFOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBkaXNwX2Nu
dGxfdGJsID3CoCBHRVRfSU1BR0Uoc3RydWN0IGF0b21fZGlzcGxheV9jb250cm9sbGVyX2luZm9f
djRfMSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQVRBX1RBQkxFUyhkY2VfaW5m
bykpOzxicj4NCivCoCDCoCDCoCDCoGlmICghZGlzcF9jbnRsX3RibCk8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX0JBREJJT1NUQUJMRTs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgc211X3RibCA9wqAgR0VUX0lNQUdFKHN0cnVjdCBhdG9tX3NtdV9pbmZvX3Yz
XzEsIERBVEFfVEFCTEVTKHNtdV9pbmZvKSk7PGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFzbXVfdGJs
KTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfQkFEQklPU1RB
QkxFOzxicj4NCis8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3NfaW5mby0mZ3Q7dHlwZS5TVEVQ
X0FORF9ERUxBWV9JTkZPID0gZmFsc2U7PGJyPg0KK8KgIMKgIMKgIMKgc3NfaW5mby0mZ3Q7c3By
ZWFkX3BlcmNlbnRhZ2VfZGl2aWRlciA9IDEwMDA7PGJyPg0KK8KgIMKgIMKgIMKgLyogQklPUyBu
byBsb25nZXIgdXNlcyB0YXJnZXQgY2xvY2suwqAgQWx3YXlzIGVuYWJsZSBmb3Igbm93ICovPGJy
Pg0KK8KgIMKgIMKgIMKgc3NfaW5mby0mZ3Q7dGFyZ2V0X2Nsb2NrX3JhbmdlID0gMHhmZmZmZmZm
Zjs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3dpdGNoIChpZCkgezxicj4NCivCoCDCoCDCoCDC
oGNhc2UgQVNfU0lHTkFMX1RZUEVfRFZJOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNz
X2luZm8tJmd0O3NwcmVhZF9zcGVjdHJ1bV9wZXJjZW50YWdlID08YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaXNwX2NudGxfdGJsLSZndDtkdmlf
c3NfcGVyY2VudGFnZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzc19pbmZvLSZndDtz
cHJlYWRfc3BlY3RydW1fcmFuZ2UgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoGRpc3BfY250bF90YmwtJmd0O2R2aV9zc19yYXRlXzEwaHogKiAx
MDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGlzcF9jbnRsX3RibC0mZ3Q7ZHZp
X3NzX21vZGUgJmFtcDsgQVRPTV9TU19DRU5UUkVfU1BSRUFEX01PREUpPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3NfaW5mby0mZ3Q7dHlwZS5DRU5URVJfTU9ERSA9
IHRydWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKg
IMKgY2FzZSBBU19TSUdOQUxfVFlQRV9IRE1JOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNzX2luZm8tJmd0O3NwcmVhZF9zcGVjdHJ1bV9wZXJjZW50YWdlID08YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaXNwX2NudGxfdGJsLSZndDto
ZG1pX3NzX3BlcmNlbnRhZ2U7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3NfaW5mby0m
Z3Q7c3ByZWFkX3NwZWN0cnVtX3JhbmdlID08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaXNwX2NudGxfdGJsLSZndDtoZG1pX3NzX3JhdGVfMTBo
eiAqIDEwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChkaXNwX2NudGxfdGJsLSZn
dDtoZG1pX3NzX21vZGUgJmFtcDsgQVRPTV9TU19DRU5UUkVfU1BSRUFEX01PREUpPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3NfaW5mby0mZ3Q7dHlwZS5DRU5URVJf
TU9ERSA9IHRydWU7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8Kg
IMKgIMKgIMKgLyogVE9ETyBMVkRTIG5vdCBzdXBwb3J0IGFueW1vcmU/ICovPGJyPg0KK8KgIMKg
IMKgIMKgY2FzZSBBU19TSUdOQUxfVFlQRV9ESVNQTEFZX1BPUlQ6PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3NfaW5mby0mZ3Q7c3ByZWFkX3NwZWN0cnVtX3BlcmNlbnRhZ2UgPTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpc3BfY250
bF90YmwtJmd0O2RwX3NzX3BlcmNlbnRhZ2U7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3NfaW5mby0mZ3Q7c3ByZWFkX3NwZWN0cnVtX3JhbmdlID08YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaXNwX2NudGxfdGJsLSZndDtkcF9zc19y
YXRlXzEwaHogKiAxMDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZGlzcF9jbnRs
X3RibC0mZ3Q7ZHBfc3NfbW9kZSAmYW1wOyBBVE9NX1NTX0NFTlRSRV9TUFJFQURfTU9ERSk8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzc19pbmZvLSZndDt0eXBlLkNF
TlRFUl9NT0RFID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+
DQorwqAgwqAgwqAgwqBjYXNlIEFTX1NJR05BTF9UWVBFX0dQVV9QTEw6PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc3NfaW5mby0mZ3Q7c3ByZWFkX3NwZWN0cnVtX3BlcmNlbnRhZ2UgPTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNtdV90
YmwtJmd0O2dwdWNsa19zc19wZXJjZW50YWdlOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNzX2luZm8tJmd0O3NwcmVhZF9zcGVjdHJ1bV9yYW5nZSA9PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc211X3RibC0mZ3Q7Z3B1Y2xrX3NzX3Jh
dGVfMTBoeiAqIDEwOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmIChzbXVfdGJsLSZn
dDtncHVjbGtfc3NfbW9kZSAmYW1wOyBBVE9NX1NTX0NFTlRSRV9TUFJFQURfTU9ERSk8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzc19pbmZvLSZndDt0eXBlLkNFTlRF
Ul9NT0RFID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQor
wqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJlc3VsdCA9
IEJQX1JFU1VMVF9VTlNVUFBPUlRFRDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoHJldHVybiByZXN1bHQ7PGJyPg0KK308YnI+DQorPGJyPg0KKy8qKjxicj4NCisg
KiBiaW9zX3BhcnNlcl9nZXRfc3ByZWFkX3NwZWN0cnVtX2luZm88YnI+DQorICogR2V0IHNwcmVh
ZCBzcGVjdHJ1bSBpbmZvcm1hdGlvbiBmcm9tIHRoZSBBU0lDX0ludGVybmFsU1NfSW5mbyh2ZXIg
Mi4xIG9yPGJyPg0KKyAqIHZlciAzLjEpIG9yIFNTX0luZm8gdGFibGUgZnJvbSB0aGUgVkJJT1Mu
IEN1cnJlbnRseSBBU0lDX0ludGVybmFsU1NfSW5mbzxicj4NCisgKiB2ZXIgMi4xIGNhbiBjby1l
eGlzdCB3aXRoIFNTX0luZm8gdGFibGUuIEV4cGVjdCBBU0lDX0ludGVybmFsU1NfSW5mbzxicj4N
CisgKiB2ZXIgMy4xLDxicj4NCisgKiB0aGVyZSBpcyBvbmx5IG9uZSBlbnRyeSBmb3IgZWFjaCBz
aWduYWwgL3NzIGlkLsKgIEhvd2V2ZXIsIHRoZXJlIGlzPGJyPg0KKyAqIG5vIHBsYW5uaW5nIG9m
IHN1cHBvcnRpbmcgbXVsdGlwbGUgc3ByZWFkIFNwcmVjdHVtIGVudHJ5IGZvciBFdmVyR3JlZW48
YnI+DQorICogQHBhcmFtIFtpbl0gdGhpczxicj4NCisgKiBAcGFyYW0gW2luXSBzaWduYWwsIEFT
U2lnbmFsVHlwZSB0byBiZSBjb252ZXJ0ZWQgdG8gaW5mbyBpbmRleDxicj4NCisgKiBAcGFyYW0g
W2luXSBpbmRleCwgbnVtYmVyIG9mIGVudHJpZXMgdGhhdCBtYXRjaCB0aGUgY29udmVydGVkIGlu
Zm8gaW5kZXg8YnI+DQorICogQHBhcmFtIFtvdXRdIHNzX2luZm8sIHNwcmVjdHJ1bSBpbmZvcm1h
dGlvbiBzdHJ1Y3R1cmUsPGJyPg0KKyAqIEByZXR1cm4gQmlvcyBwYXJzZXIgcmVzdWx0IGNvZGU8
YnI+DQorICovPGJyPg0KK3N0YXRpYyBlbnVtIGJwX3Jlc3VsdCBiaW9zX3BhcnNlcl9nZXRfc3By
ZWFkX3NwZWN0cnVtX2luZm8oPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGRjX2Jpb3MgKmRjYiw8
YnI+DQorwqAgwqAgwqAgwqBlbnVtIGFzX3NpZ25hbF90eXBlIHNpZ25hbCw8YnI+DQorwqAgwqAg
wqAgwqB1aW50MzJfdCBpbmRleCw8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3Qgc3ByZWFkX3NwZWN0
cnVtX2luZm8gKnNzX2luZm8pPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYmlvc19w
YXJzZXIgKmJwID0gQlBfRlJPTV9EQ0IoZGNiKTs8YnI+DQorwqAgwqAgwqAgwqBlbnVtIGJwX3Jl
c3VsdCByZXN1bHQgPSBCUF9SRVNVTFRfVU5TVVBQT1JURUQ7PGJyPg0KK8KgIMKgIMKgIMKgc3Ry
dWN0IGF0b21fY29tbW9uX3RhYmxlX2hlYWRlciAqaGVhZGVyOzxicj4NCivCoCDCoCDCoCDCoHN0
cnVjdCBhdG9tX2RhdGFfcmV2aXNpb24gdGJsX3JldmlzaW9uOzxicj4NCis8YnI+DQorwqAgwqAg
wqAgwqBpZiAoIXNzX2luZm8pIC8qIGNoZWNrIGZvciBiYWQgaW5wdXQgKi88YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX0JBRElOUFVUOzxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqBpZiAoIURBVEFfVEFCTEVTKGRjZV9pbmZvKSk8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX1VOU1VQUE9SVEVEOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqBoZWFkZXIgPSBHRVRfSU1BR0Uoc3RydWN0IGF0b21fY29tbW9uX3RhYmxlX2hlYWRl
ciw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBEQVRBX1RBQkxFUyhkY2VfaW5mbykpOzxicj4NCivCoCDC
oCDCoCDCoGdldF9hdG9tX2RhdGFfdGFibGVfcmV2aXNpb24oaGVhZGVyLCAmYW1wO3RibF9yZXZp
c2lvbik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHN3aXRjaCAodGJsX3JldmlzaW9uLm1ham9y
KSB7PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSA0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN3aXRjaCAodGJsX3JldmlzaW9uLm1pbm9yKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgY2FzZSAxOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biBnZXRfc3NfaW5mb192NF8xKGJwLCBzaWduYWwsIGluZGV4LCBzc19pbmZvKTs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoH08YnI+
DQorwqAgwqAgwqAgwqAvKiB0aGVyZSBjYW4gbm90IGJlIG1vcmUgdGhlbiBvbmUgZW50cnkgZm9y
IFNTIEluZm8gdGFibGUgKi88YnI+DQorwqAgwqAgwqAgwqByZXR1cm4gcmVzdWx0Ozxicj4NCit9
PGJyPg0KKzxicj4NCitzdGF0aWMgZW51bSBicF9yZXN1bHQgZ2V0X2VtYmVkZGVkX3BhbmVsX2lu
Zm9fdjJfMSg8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYmlvc19wYXJzZXIgKmJwLDxicj4NCivC
oCDCoCDCoCDCoHN0cnVjdCBlbWJlZGRlZF9wYW5lbF9pbmZvICppbmZvKTxicj4NCit7PGJyPg0K
K8KgIMKgIMKgIMKgc3RydWN0IGxjZF9pbmZvX3YyXzEgKmx2ZHM7PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoGlmICghaW5mbyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBf
UkVTVUxUX0JBRElOUFVUOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIURBVEFfVEFCTEVT
KGxjZF9pbmZvKSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxU
X1VOU1VQUE9SVEVEOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBsdmRzID0gR0VUX0lNQUdFKHN0
cnVjdCBsY2RfaW5mb192Ml8xLCBEQVRBX1RBQkxFUyhsY2RfaW5mbykpOzxicj4NCis8YnI+DQor
wqAgwqAgwqAgwqBpZiAoIWx2ZHMpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJu
IEJQX1JFU1VMVF9CQURCSU9TVEFCTEU7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoC8qIFRPRE86
IHByZXZpb3VzIHZ2MV8zLCBzaG91bGQgdjJfMSAqLzxicj4NCivCoCDCoCDCoCDCoGlmICghKChs
dmRzLSZndDt0YWJsZV9oZWFkZXIuZm9ybWF0X3JldmlzaW9uID09IDIpPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmFtcDsmYW1wOyAobHZkcy0mZ3Q7dGFibGVfaGVh
ZGVyLmNvbnRlbnRfcmV2aXNpb24gJmd0Oz0gMSkpKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBCUF9SRVNVTFRfVU5TVVBQT1JURUQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oG1lbXNldChpbmZvLCAwLCBzaXplb2Yoc3RydWN0IGVtYmVkZGVkX3BhbmVsX2luZm8pKTs8YnI+
DQorPGJyPg0KK8KgIMKgIMKgIMKgLyogV2UgbmVlZCB0byBjb252ZXJ0IGZyb20gMTBLSHogdW5p
dHMgaW50byBLSHogdW5pdHMgKi88YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5n
LnBpeGVsX2NsayA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGUx
Nl90b19jcHUobHZkcy0mZ3Q7bGNkX3RpbWluZy5waXhjbGspICogMTA7PGJyPg0KK8KgIMKgIMKg
IMKgLyogdXNIQWN0aXZlIGRvZXMgbm90IGluY2x1ZGUgYm9yZGVycywgYWNjb3JkaW5nIHRvIFZC
SU9TIHRlYW0gKi88YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5nLmhvcml6b250
YWxfYWRkcmVzc2FibGUgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGxlMTZfdG9fY3B1KGx2ZHMtJmd0O2xjZF90aW1pbmcuaF9hY3RpdmUpOzxicj4NCivCoCDCoCDC
oCDCoC8qIHVzSEJsYW5raW5nX1RpbWUgaW5jbHVkZXMgYm9yZGVycywgc28gd2Ugc2hvdWxkIHJl
YWxseSBiZTxicj4NCivCoCDCoCDCoCDCoCAqIHN1YnRyYWN0aW5nYm9yZGVycyBkdWluZyB0aGlz
IHRyYW5zbGF0aW9uLCBidXQgTFZEUyBnZW5lcmFsbHk8YnI+DQorwqAgwqAgwqAgwqAgKiBkb2Vz
biYjMzk7dCBoYXZlIGJvcmRlcnMsIHNvIHdlIHNob3VsZCBiZSBva2F5IGxlYXZpbmcgdGhpcyBh
cyBpcyBmb3I8YnI+DQorwqAgwqAgwqAgwqAgKiBub3cuwqAgTWF5IG5lZWQgdG8gcmV2aXNpdCBp
ZiB3ZSBldmVyIGhhdmUgTFZEUyB3aXRoIGJvcmRlcnM8YnI+DQorwqAgwqAgwqAgwqAgKi88YnI+
DQorwqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5nLmhvcml6b250YWxfYmxhbmtpbmdfdGlt
ZSA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGUxNl90b19jcHUobHZkcy0mZ3Q7bGNk
X3RpbWluZy5oX2JsYW5raW5nX3RpbWUpOzxicj4NCivCoCDCoCDCoCDCoC8qIHVzVkFjdGl2ZSBk
b2VzIG5vdCBpbmNsdWRlIGJvcmRlcnMsIGFjY29yZGluZyB0byBWQklPUyB0ZWFtKi88YnI+DQor
wqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5nLnZlcnRpY2FsX2FkZHJlc3NhYmxlID08YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBsZTE2X3RvX2NwdShsdmRzLSZndDtsY2RfdGltaW5n
LnZfYWN0aXZlKTs8YnI+DQorwqAgwqAgwqAgwqAvKiB1c1ZCbGFua2luZ19UaW1lIGluY2x1ZGVz
IGJvcmRlcnMsIHNvIHdlIHNob3VsZCByZWFsbHkgYmU8YnI+DQorwqAgwqAgwqAgwqAgKiBzdWJ0
cmFjdGluZyBib3JkZXJzIGR1aW5nIHRoaXMgdHJhbnNsYXRpb24sIGJ1dCBMVkRTIGdlbmVyYWxs
eTxicj4NCivCoCDCoCDCoCDCoCAqIGRvZXNuJiMzOTt0IGhhdmUgYm9yZGVycywgc28gd2Ugc2hv
dWxkIGJlIG9rYXkgbGVhdmluZyB0aGlzIGFzIGlzIGZvcjxicj4NCivCoCDCoCDCoCDCoCAqIG5v
dy4gTWF5IG5lZWQgdG8gcmV2aXNpdCBpZiB3ZSBldmVyIGhhdmUgTFZEUyB3aXRoIGJvcmRlcnM8
YnI+DQorwqAgwqAgwqAgwqAgKi88YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5n
LnZlcnRpY2FsX2JsYW5raW5nX3RpbWUgPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxl
MTZfdG9fY3B1KGx2ZHMtJmd0O2xjZF90aW1pbmcudl9ibGFua2luZ190aW1lKTs8YnI+DQorwqAg
wqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5nLmhvcml6b250YWxfc3luY19vZmZzZXQgPTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxlMTZfdG9fY3B1KGx2ZHMtJmd0O2xjZF90aW1pbmcu
aF9zeW5jX29mZnNldCk7PGJyPg0KK8KgIMKgIMKgIMKgaW5mby0mZ3Q7bGNkX3RpbWluZy5ob3Jp
em9udGFsX3N5bmNfd2lkdGggPTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxlMTZfdG9f
Y3B1KGx2ZHMtJmd0O2xjZF90aW1pbmcuaF9zeW5jX3dpZHRoKTs8YnI+DQorwqAgwqAgwqAgwqBp
bmZvLSZndDtsY2RfdGltaW5nLnZlcnRpY2FsX3N5bmNfb2Zmc2V0ID08YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBsZTE2X3RvX2NwdShsdmRzLSZndDtsY2RfdGltaW5nLnZfc3luY19vZmZz
ZXQpOzxicj4NCivCoCDCoCDCoCDCoGluZm8tJmd0O2xjZF90aW1pbmcudmVydGljYWxfc3luY193
aWR0aCA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbGUxNl90b19jcHUobHZkcy0mZ3Q7
bGNkX3RpbWluZy52X3N5bmN3aWR0aCk7PGJyPg0KK8KgIMKgIMKgIMKgaW5mby0mZ3Q7bGNkX3Rp
bWluZy5ob3Jpem9udGFsX2JvcmRlciA9IGx2ZHMtJmd0O2xjZF90aW1pbmcuaF9ib3JkZXI7PGJy
Pg0KK8KgIMKgIMKgIMKgaW5mby0mZ3Q7bGNkX3RpbWluZy52ZXJ0aWNhbF9ib3JkZXIgPSBsdmRz
LSZndDtsY2RfdGltaW5nLnZfYm9yZGVyOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBub3Qg
cHJvdmlkZWQgYnkgVkJJT1MgKi88YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5n
Lm1pc2NfaW5mby5IT1JJWk9OVEFMX0NVVF9PRkYgPSAwOzxicj4NCis8YnI+DQorwqAgwqAgwqAg
wqBpbmZvLSZndDtsY2RfdGltaW5nLm1pc2NfaW5mby5IX1NZTkNfUE9MQVJJVFkgPTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoH4odWludDMyX3QpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKGx2ZHMtJmd0O2xjZF90aW1pbmcubWlzY2luZm8gJmFtcDsgQVRPTV9IU1lOQ19QT0xB
UklUWSk7PGJyPg0KK8KgIMKgIMKgIMKgaW5mby0mZ3Q7bGNkX3RpbWluZy5taXNjX2luZm8uVl9T
WU5DX1BPTEFSSVRZID08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB+KHVpbnQzMl90KTxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChsdmRzLSZndDtsY2RfdGltaW5nLm1pc2NpbmZv
ICZhbXA7IEFUT01fVlNZTkNfUE9MQVJJVFkpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBu
b3QgcHJvdmlkZWQgYnkgVkJJT1MgKi88YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGlt
aW5nLm1pc2NfaW5mby5WRVJUSUNBTF9DVVRfT0ZGID0gMDs8YnI+DQorPGJyPg0KK8KgIMKgIMKg
IMKgaW5mby0mZ3Q7bGNkX3RpbWluZy5taXNjX2luZm8uSF9SRVBMSUNBVElPTl9CWTIgPTxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGx2ZHMtJmd0O2xjZF90aW1pbmcubWlzY2luZm8gJmFt
cDsgQVRPTV9IX1JFUExJQ0FUSU9OQlkyOzxicj4NCivCoCDCoCDCoCDCoGluZm8tJmd0O2xjZF90
aW1pbmcubWlzY19pbmZvLlZfUkVQTElDQVRJT05fQlkyID08YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBsdmRzLSZndDtsY2RfdGltaW5nLm1pc2NpbmZvICZhbXA7IEFUT01fVl9SRVBMSUNB
VElPTkJZMjs8YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZndDtsY2RfdGltaW5nLm1pc2NfaW5mby5D
T01QT1NJVEVfU1lOQyA9PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbHZkcy0mZ3Q7bGNk
X3RpbWluZy5taXNjaW5mbyAmYW1wOyBBVE9NX0NPTVBPU0lURVNZTkM7PGJyPg0KK8KgIMKgIMKg
IMKgaW5mby0mZ3Q7bGNkX3RpbWluZy5taXNjX2luZm8uSU5URVJMQUNFID08YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBsdmRzLSZndDtsY2RfdGltaW5nLm1pc2NpbmZvICZhbXA7IEFUT01f
SU5URVJMQUNFOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAvKiBub3QgcHJvdmlkZWQgYnkgVkJJ
T1MqLzxicj4NCivCoCDCoCDCoCDCoGluZm8tJmd0O2xjZF90aW1pbmcubWlzY19pbmZvLkRPVUJM
RV9DTE9DSyA9IDA7PGJyPg0KK8KgIMKgIMKgIMKgLyogbm90IHByb3ZpZGVkIGJ5IFZCSU9TKi88
YnI+DQorwqAgwqAgwqAgwqBpbmZvLSZndDtzc19pZCA9IDA7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoGluZm8tJmd0O3JlYWx0ZWtfZURQVG9MVkRTID08YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAobHZkcy0mZ3Q7ZHBsdmRzcnhpZCA9PSBlRFBfVE9fTFZEU19SRUFM
VEVLX0lEID8gMTowKTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIEJQX1JFU1VMVF9P
Szs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBfcmVzdWx0IGJpb3NfcGFyc2Vy
X2dldF9lbWJlZGRlZF9wYW5lbF9pbmZvKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY19iaW9z
ICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGVtYmVkZGVkX3BhbmVsX2luZm8gKmluZm8p
PGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYmlvc19wYXJzZXIgKmJwID0gQlBfRlJP
TV9EQ0IoZGNiKTs8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgYXRvbV9jb21tb25fdGFibGVfaGVh
ZGVyICpoZWFkZXI7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGF0b21fZGF0YV9yZXZpc2lvbiB0
YmxfcmV2aXNpb247PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICghREFUQV9UQUJMRVMobGNk
X2luZm8pKTxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfRkFJ
TFVSRTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaGVhZGVyID0gR0VUX0lNQUdFKHN0cnVjdCBh
dG9tX2NvbW1vbl90YWJsZV9oZWFkZXIsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgREFUQV9UQUJMRVMobGNkX2luZm8pKTs8
YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgaWYgKCFoZWFkZXIpPGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcmV0dXJuIEJQX1JFU1VMVF9CQURCSU9TVEFCTEU7PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoGdldF9hdG9tX2RhdGFfdGFibGVfcmV2aXNpb24oaGVhZGVyLCAmYW1wO3RibF9yZXZp
c2lvbik7PGJyPg0KKzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBzd2l0Y2ggKHRibF9yZXZpc2lv
bi5tYWpvcikgezxicj4NCivCoCDCoCDCoCDCoGNhc2UgMjo8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzd2l0Y2ggKHRibF9yZXZpc2lvbi5taW5vcikgezxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNhc2UgMTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gZ2V0X2VtYmVkZGVkX3BhbmVsX2luZm9fdjJfMShicCwgaW5mbyk7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0K
K8KgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8
YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNV
TFRfRkFJTFVSRTs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIHVpbnQzMl90IGdldF9zdXBw
b3J0X21hc2tfZm9yX2RldmljZV9pZChzdHJ1Y3QgZGV2aWNlX2lkIGRldmljZV9pZCk8YnI+DQor
ezxicj4NCivCoCDCoCDCoCDCoGVudW0gZGFsX2RldmljZV90eXBlIGRldmljZV90eXBlID0gZGV2
aWNlX2lkLmRldmljZV90eXBlOzxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IGVudW1faWQgPSBk
ZXZpY2VfaWQuZW51bV9pZDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3dpdGNoIChkZXZpY2Vf
dHlwZSkgezxicj4NCivCoCDCoCDCoCDCoGNhc2UgREVWSUNFX1RZUEVfTENEOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHN3aXRjaCAoZW51bV9pZCkgezxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNhc2UgMTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gQVRPTV9ESVNQTEFZX0xDRDFfU1VQUE9SVDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIERFVklDRV9UWVBFX0RGUDo8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2ggKGVudW1faWQpIHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIDE6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgcmV0dXJuIEFUT01fRElTUExBWV9ERlAxX1NVUFBPUlQ7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY2FzZSAyOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHJldHVybiBBVE9NX0RJU1BMQVlfREZQMl9TVVBQT1JUOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNhc2UgMzo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm4gQVRPTV9ESVNQTEFZX0RGUDNfU1VQUE9SVDs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBjYXNlIDQ6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgcmV0dXJuIEFUT01fRElTUExBWV9ERlA0X1NVUFBPUlQ7PGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY2FzZSA1Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHJldHVybiBBVE9NX0RJU1BMQVlfREZQNV9TVVBQT1JUOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNhc2UgNjo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZXR1cm4gQVRPTV9ESVNQTEFZX0RGUDZfU1VQUE9SVDs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH08YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoH07PGJyPg0KKzxicj4NCivC
oCDCoCDCoCDCoC8qIFVuaWRlbnRpZmllZCBkZXZpY2UgSUQsIHJldHVybiBlbXB0eSBzdXBwb3J0
IG1hc2suICovPGJyPg0KK8KgIMKgIMKgIMKgcmV0dXJuIDA7PGJyPg0KK308YnI+DQorPGJyPg0K
K3N0YXRpYyBib29sIGJpb3NfcGFyc2VyX2lzX2RldmljZV9pZF9zdXBwb3J0ZWQoPGJyPg0KK8Kg
IMKgIMKgIMKgc3RydWN0IGRjX2Jpb3MgKmRjYiw8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZGV2
aWNlX2lkIGlkKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFyc2VyICpi
cCA9IEJQX0ZST01fRENCKGRjYik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHVpbnQzMl90IG1h
c2sgPSBnZXRfc3VwcG9ydF9tYXNrX2Zvcl9kZXZpY2VfaWQoaWQpOzxicj4NCis8YnI+DQorwqAg
wqAgwqAgwqByZXR1cm4gKGxlMTZfdG9fY3B1KGJwLSZndDtvYmplY3RfaW5mb190YmwudjFfNC0m
Z3Q7c3VwcG9ydGVkZGV2aWNlcykgJmFtcDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBtYXNrKSAhPSAwOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgdm9p
ZCBiaW9zX3BhcnNlcl9wb3N0X2luaXQoPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGRjX2Jpb3Mg
KmRjYik8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoC8qIFRPRE8gZm9yIE9QTSBtb2R1bGUuIE5l
ZWQgaW1wbGVtZW50IGxhdGVyICovPGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyB1aW50MzJf
dCBiaW9zX3BhcnNlcl9nZXRfc3NfZW50cnlfbnVtYmVyKDxicj4NCivCoCDCoCDCoCDCoHN0cnVj
dCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgZW51bSBhc19zaWduYWxfdHlwZSBzaWdu
YWwpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqAvKiBUT0RPOiBEQUwyIGF0b21maXJtd2FyZSBp
bXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBuZWVkIHRoaXMuPGJyPg0KK8KgIMKgIMKgIMKgICogd2h5
IERBTDMgbmVlZCB0aGlzPzxicj4NCivCoCDCoCDCoCDCoCAqLzxicj4NCivCoCDCoCDCoCDCoHJl
dHVybiAxOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlvc19w
YXJzZXJfdHJhbnNtaXR0ZXJfY29udHJvbCg8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZGNfYmlv
cyAqZGNiLDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBicF90cmFuc21pdHRlcl9jb250cm9sICpj
bnRsKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFyc2VyICpicCA9IEJQ
X0ZST01fRENCKGRjYik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICghYnAtJmd0O2NtZF90
YmwudHJhbnNtaXR0ZXJfY29udHJvbCk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gQlBfUkVTVUxUX0ZBSUxVUkU7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBicC0m
Z3Q7Y21kX3RibC50cmFuc21pdHRlcl9jb250cm9sKGJwLCBjbnRsKTs8YnI+DQorfTxicj4NCis8
YnI+DQorc3RhdGljIGVudW0gYnBfcmVzdWx0IGJpb3NfcGFyc2VyX2VuY29kZXJfY29udHJvbCg8
YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZGNfYmlvcyAqZGNiLDxicj4NCivCoCDCoCDCoCDCoHN0
cnVjdCBicF9lbmNvZGVyX2NvbnRyb2wgKmNudGwpPGJyPg0KK3s8YnI+DQorwqAgwqAgwqAgwqBz
dHJ1Y3QgYmlvc19wYXJzZXIgKmJwID0gQlBfRlJPTV9EQ0IoZGNiKTs8YnI+DQorPGJyPg0KK8Kg
IMKgIMKgIMKgaWYgKCFicC0mZ3Q7Y21kX3RibC5kaWdfZW5jb2Rlcl9jb250cm9sKTxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfRkFJTFVSRTs8YnI+DQorPGJy
Pg0KK8KgIMKgIMKgIMKgcmV0dXJuIGJwLSZndDtjbWRfdGJsLmRpZ19lbmNvZGVyX2NvbnRyb2wo
YnAsIGNudGwpOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgZW51bSBicF9yZXN1bHQgYmlv
c19wYXJzZXJfc2V0X3BpeGVsX2Nsb2NrKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY19iaW9z
ICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJwX3BpeGVsX2Nsb2NrX3BhcmFtZXRlcnMg
KmJwX3BhcmFtcyk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBiaW9zX3BhcnNlciAq
YnAgPSBCUF9GUk9NX0RDQihkY2IpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWJwLSZn
dDtjbWRfdGJsLnNldF9waXhlbF9jbG9jayk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBy
ZXR1cm4gQlBfUkVTVUxUX0ZBSUxVUkU7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBi
cC0mZ3Q7Y21kX3RibC5zZXRfcGl4ZWxfY2xvY2soYnAsIGJwX3BhcmFtcyk7PGJyPg0KK308YnI+
DQorPGJyPg0KK3N0YXRpYyBlbnVtIGJwX3Jlc3VsdCBiaW9zX3BhcnNlcl9zZXRfZGNlX2Nsb2Nr
KDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKgIMKgIMKg
c3RydWN0IGJwX3NldF9kY2VfY2xvY2tfcGFyYW1ldGVycyAqYnBfcGFyYW1zKTxicj4NCit7PGJy
Pg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFyc2VyICpicCA9IEJQX0ZST01fRENCKGRjYik7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICghYnAtJmd0O2NtZF90Ymwuc2V0X2RjZV9jbG9j
ayk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxUX0ZBSUxVUkU7
PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBicC0mZ3Q7Y21kX3RibC5zZXRfZGNlX2Ns
b2NrKGJwLCBicF9wYXJhbXMpOzxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgdW5zaWduZWQg
aW50IGJpb3NfcGFyc2VyX2dldF9zbXVfY2xvY2tfaW5mbyg8YnI+DQorwqAgwqAgwqAgwqBzdHJ1
Y3QgZGNfYmlvcyAqZGNiKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgc3RydWN0IGJpb3NfcGFy
c2VyICpicCA9IEJQX0ZST01fRENCKGRjYik7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmICgh
YnAtJmd0O2NtZF90YmwuZ2V0X3NtdV9jbG9ja19pbmZvKTxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiBCUF9SRVNVTFRfRkFJTFVSRTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKg
cmV0dXJuIGJwLSZndDtjbWRfdGJsLmdldF9zbXVfY2xvY2tfaW5mbyhicCk7PGJyPg0KK308YnI+
DQorPGJyPg0KK3N0YXRpYyBlbnVtIGJwX3Jlc3VsdCBiaW9zX3BhcnNlcl9wcm9ncmFtX2NydGNf
dGltaW5nKDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBkY19iaW9zICpkY2IsPGJyPg0KK8KgIMKg
IMKgIMKgc3RydWN0IGJwX2h3X2NydGNfdGltaW5nX3BhcmFtZXRlcnMgKmJwX3BhcmFtcyk8YnI+
DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBiaW9zX3BhcnNlciAqYnAgPSBCUF9GUk9NX0RD
QihkY2IpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWJwLSZndDtjbWRfdGJsLnNldF9j
cnRjX3RpbWluZyk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gQlBfUkVTVUxU
X0ZBSUxVUkU7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBicC0mZ3Q7Y21kX3RibC5z
ZXRfY3J0Y190aW1pbmcoYnAsIGJwX3BhcmFtcyk7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRp
YyBlbnVtIGJwX3Jlc3VsdCBiaW9zX3BhcnNlcl9lbmFibGVfY3J0Yyg8YnI+DQorwqAgwqAgwqAg
wqBzdHJ1Y3QgZGNfYmlvcyAqZGNiLDxicj4NCivCoCDCoCDCoCDCoGVudW0gY29udHJvbGxlcl9p
ZCBpZCw8YnI+DQorwqAgwqAgwqAgwqBib29sIGVuYWJsZSk8YnI+DQorezxicj4NCivCoCDCoCDC
oCDCoHN0cnVjdCBiaW9zX3BhcnNlciAqYnAgPSBCUF9GUk9NX0RDQihkY2IpOzxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqBpZiAoIWJwLSZndDtjbWRfdGJsLmVuYWJsZV9jcnRjKTxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybiBCUF9SRVNVTFRfRkFJTFVSRTs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgcmV0dXJuIGJwLSZndDtjbWRfdGJsLmVuYWJsZV9jcnRjKGJwLCBpZCwgZW5h
YmxlKTs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIGVudW0gYnBfcmVzdWx0IGJpb3NfcGFy
c2VyX2NydGNfc291cmNlX3NlbGVjdCg8YnI+DQorwqAgwqAgwqAgwqBzdHJ1Y3QgZGNfYmlvcyAq
ZGNiLDxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBicF9jcnRjX3NvdXJjZV9zZWxlY3QgKmJwX3Bh
cmFtcyk8YnI+DQorezxicj4NCivCoCDCoCDCoCDCoHN0cnVjdCBiaW9zX3BhcnNlciAqYnAgPSBC
UF9GUk9NX0RDQihkY2IpOzxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAoIWJwLSZndDtjbWRf
dGJsLnNlbGVjdF9jcnRjX3NvdXJjZSk8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1
cm4gQlBfUkVTVUxUX0ZBSUxVUkU7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVybiBicC0m
Z3Q7Y21kX3RibC5zZWxlY3RfY3J0Y19zb3VyY2UoYnAsIGJwX3BhcmFtcyk7PGJyPg0KK308YnI+
DQorPGJyPg0KK3N0YXRpYyBlbnVtIGJwX3Jlc3VsdCBiaW9zX3BhcnNlcl9lbmFibGVfZGk8L2Js
b2NrcXVvdGU+PC9kaXY+DQo=
--94eb2c112c3e9b79ce0555dfb991--

--===============0016315626==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0016315626==--
