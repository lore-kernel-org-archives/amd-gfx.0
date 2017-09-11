From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 07/28] drm/amd/display: USB-C to HDMI dongle not light
Date: Tue, 12 Sep 2017 06:20:01 +1000
Message-ID: <CAPM=9tz4tiJoPmrqhuVMQvntXPhnSQ2632FVtinnxzAdFp7OLg@mail.gmail.com>
References: <20170911180930.13561-1-harry.wentland@amd.com>
 <20170911180930.13561-8-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082986003=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170911180930.13561-8-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2082986003==
Content-Type: multipart/alternative; boundary="f403043ee078cbf5fb0558efa681"

--f403043ee078cbf5fb0558efa681
Content-Type: text/plain; charset="UTF-8"

This seems to lack a commit msg

Dave.

On 12 Sep. 2017 4:15 am, "Harry Wentland" <harry.wentland-5C7GfCeVMHo@public.gmane.org> wrote:

> From: Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
>
> Signed-off-by: Hersen Wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 ++++---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c     | 32
> +++++++++++++++--------
>  drivers/gpu/drm/amd/display/dc/dc.h               |  8 +++++-
>  3 files changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7a408d753be8..9b5158cceece 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -639,7 +639,7 @@ int amdgpu_dm_display_resume(struct amdgpu_device
> *adev )
>                         continue;
>
>                 mutex_lock(&aconnector->hpd_lock);
> -               dc_link_detect(aconnector->dc_link, false);
> +               dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
>                 aconnector->dc_sink = NULL;
>                 amdgpu_dm_update_connector_after_detect(aconnector);
>                 mutex_unlock(&aconnector->hpd_lock);
> @@ -870,7 +870,7 @@ static void handle_hpd_irq(void *param)
>          * since (for MST case) MST does this in it's own context.
>          */
>         mutex_lock(&aconnector->hpd_lock);
> -       if (dc_link_detect(aconnector->dc_link, false)) {
> +       if (dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD)) {
>                 amdgpu_dm_update_connector_after_detect(aconnector);
>
>
> @@ -980,7 +980,7 @@ static void handle_hpd_rx_irq(void *param)
>         if (dc_link_handle_hpd_rx_irq(aconnector->dc_link, NULL) &&
>                         !is_mst_root_connector) {
>                 /* Downstream Port status changed. */
> -               if (dc_link_detect(aconnector->dc_link, false)) {
> +               if (dc_link_detect(aconnector->dc_link,
> DETECT_REASON_HPDRX)) {
>                         amdgpu_dm_update_connector_
> after_detect(aconnector);
>
>
> @@ -1368,7 +1368,8 @@ int amdgpu_dm_initialize_drm_device(struct
> amdgpu_device *adev)
>                         goto fail_free_encoder;
>                 }
>
> -               if (dc_link_detect(dc_get_link_at_index(dm->dc, i), true))
> +               if (dc_link_detect(dc_get_link_at_index(dm->dc, i),
> +                               DETECT_REASON_BOOT))
>                         amdgpu_dm_update_connector_
> after_detect(aconnector);
>         }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index cea8dafd2edc..845ec421d861 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -355,7 +355,9 @@ static bool is_dp_sink_present(struct dc_link *link)
>   * @brief
>   * Detect output sink type
>   */
> -static enum signal_type link_detect_sink(struct dc_link *link)
> +static enum signal_type link_detect_sink(
> +       struct dc_link *link,
> +       enum dc_detect_reason reason)
>  {
>         enum signal_type result = get_basic_signal_type(
>                 link->link_enc->id, link->link_id);
> @@ -388,12 +390,17 @@ static enum signal_type link_detect_sink(struct
> dc_link *link)
>         }
>         break;
>         case CONNECTOR_ID_DISPLAY_PORT: {
> -
> -               /* Check whether DP signal detected: if not -
> -                * we assume signal is DVI; it could be corrected
> -                * to HDMI after dongle detection */
> -               if (!is_dp_sink_present(link))
> -                       result = SIGNAL_TYPE_DVI_SINGLE_LINK;
> +               /* DP HPD short pulse. Passive DP dongle will not
> +                * have short pulse
> +                */
> +               if (reason != DETECT_REASON_HPDRX) {
> +                       /* Check whether DP signal detected: if not -
> +                        * we assume signal is DVI; it could be corrected
> +                        * to HDMI after dongle detection
> +                        */
> +                       if (!is_dp_sink_present(link))
> +                               result = SIGNAL_TYPE_DVI_SINGLE_LINK;
> +               }
>         }
>         break;
>         default:
> @@ -460,9 +467,10 @@ static void detect_dp(
>         struct display_sink_capability *sink_caps,
>         bool *converter_disable_audio,
>         struct audio_support *audio_support,
> -       bool boot)
> +       enum dc_detect_reason reason)
>  {
> -       sink_caps->signal = link_detect_sink(link);
> +       bool boot = false;
> +       sink_caps->signal = link_detect_sink(link, reason);
>         sink_caps->transaction_type =
>                 get_ddc_transaction_type(sink_caps->signal);
>
> @@ -513,6 +521,8 @@ static void detect_dp(
>                          * Need check ->sink usages in case ->sink = NULL
>                          * TODO: s3 resume check
>                          */
> +                       if (reason == DETECT_REASON_BOOT)
> +                               boot = true;
>
>                         if (dm_helpers_dp_mst_start_top_mgr(
>                                 link->ctx,
> @@ -531,7 +541,7 @@ static void detect_dp(
>         }
>  }
>
> -bool dc_link_detect(struct dc_link *link, bool boot)
> +bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)
>  {
>         struct dc_sink_init_data sink_init_data = { 0 };
>         struct display_sink_capability sink_caps = { 0 };
> @@ -596,7 +606,7 @@ bool dc_link_detect(struct dc_link *link, bool boot)
>                                 link,
>                                 &sink_caps,
>                                 &converter_disable_audio,
> -                               aud_support, boot);
> +                               aud_support, reason);
>
>                         /* Active dongle downstream unplug */
>                         if (link->type == dc_connection_active_dongle
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h
> b/drivers/gpu/drm/amd/display/dc/dc.h
> index f005add1aba3..bf2d42561362 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -884,7 +884,13 @@ bool dc_link_setup_psr(struct dc_link *dc_link,
>   * true otherwise. True meaning further action is required (status update
>   * and OS notification).
>   */
> -bool dc_link_detect(struct dc_link *dc_link, bool boot);
> +enum dc_detect_reason {
> +       DETECT_REASON_BOOT,
> +       DETECT_REASON_HPD,
> +       DETECT_REASON_HPDRX,
> +};
> +
> +bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason
> reason);
>
>  /* Notify DC about DP RX Interrupt (aka Short Pulse Interrupt).
>   * Return:
> --
> 2.11.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--f403043ee078cbf5fb0558efa681
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">This seems to lack a commit msg<div dir=3D"auto"><br></di=
v><div dir=3D"auto">Dave.</div></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On 12 Sep. 2017 4:15 am, &quot;Harry Wentland&quot; &lt=
;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt; w=
rote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">From: Hersen W=
u &lt;<a href=3D"mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org">hersenxs.wu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br=
>
<br>
Signed-off-by: Hersen Wu &lt;<a href=3D"mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org">hersenx=
s.wu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Reviewed-by: Tony Cheng &lt;<a href=3D"mailto:Tony.Cheng-5C7GfCeVMHo@public.gmane.org">Tony.Chen=
g@amd.com</a>&gt;<br>
Acked-by: Harry Wentland &lt;<a href=3D"mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org">Harr=
y.Wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
=C2=A0drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c |=C2=A0 9 ++++=
---<br>
=C2=A0drivers/gpu/drm/amd/display/<wbr>dc/core/dc_link.c=C2=A0 =C2=A0 =C2=
=A0| 32 +++++++++++++++--------<br>
=C2=A0drivers/gpu/drm/amd/display/<wbr>dc/dc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +++++-<br>
=C2=A03 files changed, 33 insertions(+), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
index 7a408d753be8..9b5158cceece 100644<br>
--- a/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
+++ b/drivers/gpu/drm/amd/display/<wbr>amdgpu_dm/amdgpu_dm.c<br>
@@ -639,7 +639,7 @@ int amdgpu_dm_display_resume(<wbr>struct amdgpu_device =
*adev )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;aco=
nnector-&gt;hpd_<wbr>lock);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc_link_detect(acon=
nector-&gt;dc_<wbr>link, false);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc_link_detect(acon=
nector-&gt;dc_<wbr>link, DETECT_REASON_HPD);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aconnector-&gt;dc_s=
ink =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_dm_update_co=
nnector_<wbr>after_detect(aconnector);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;a=
connector-&gt;hpd_<wbr>lock);<br>
@@ -870,7 +870,7 @@ static void handle_hpd_irq(void *param)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* since (for MST case) MST does this in i=
t&#39;s own context.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;aconnector-&gt;hpd_<wbr>lock);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc_link_detect(aconnector-&gt;<wbr>dc_link,=
 false)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc_link_detect(aconnector-&gt;<wbr>dc_link,=
 DETECT_REASON_HPD)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 amdgpu_dm_update_co=
nnector_<wbr>after_detect(aconnector);<br>
<br>
<br>
@@ -980,7 +980,7 @@ static void handle_hpd_rx_irq(void *param)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dc_link_handle_hpd_rx_irq(<wbr>aconnector-&=
gt;dc_link, NULL) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 !is_mst_root_connector) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Downstream Port =
status changed. */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc_link_detect(=
aconnector-&gt;<wbr>dc_link, false)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc_link_detect(=
aconnector-&gt;<wbr>dc_link, DETECT_REASON_HPDRX)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_dm_update_connector_<wbr>after_detect(aconnector);<br>
<br>
<br>
@@ -1368,7 +1368,8 @@ int amdgpu_dm_initialize_drm_<wbr>device(struct amdgp=
u_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 goto fail_free_encoder;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc_link_detect(=
dc_get_link_<wbr>at_index(dm-&gt;dc, i), true))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dc_link_detect(=
dc_get_link_<wbr>at_index(dm-&gt;dc, i),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DETECT_REASON_BOOT))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 amdgpu_dm_update_connector_<wbr>after_detect(aconnector);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/<wbr>dc/core/dc_link.c b/drivers/g=
pu/drm/amd/display/<wbr>dc/core/dc_link.c<br>
index cea8dafd2edc..845ec421d861 100644<br>
--- a/drivers/gpu/drm/amd/display/<wbr>dc/core/dc_link.c<br>
+++ b/drivers/gpu/drm/amd/display/<wbr>dc/core/dc_link.c<br>
@@ -355,7 +355,9 @@ static bool is_dp_sink_present(struct dc_link *link)<br=
>
=C2=A0 * @brief<br>
=C2=A0 * Detect output sink type<br>
=C2=A0 */<br>
-static enum signal_type link_detect_sink(struct dc_link *link)<br>
+static enum signal_type link_detect_sink(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_link *link,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enum dc_detect_reason reason)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum signal_type result =3D get_basic_signal_ty=
pe(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link-&gt;link_enc-&=
gt;id, link-&gt;link_id);<br>
@@ -388,12 +390,17 @@ static enum signal_type link_detect_sink(struct dc_li=
nk *link)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case CONNECTOR_ID_DISPLAY_PORT: {<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Check whether DP=
 signal detected: if not -<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we assume signal=
 is DVI; it could be corrected<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to HDMI after do=
ngle detection */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!is_dp_sink_pre=
sent(link))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0result =3D SIGNAL_TYPE_DVI_SINGLE_LINK;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* DP HPD short pul=
se. Passive DP dongle will not<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * have short pulse=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (reason !=3D DET=
ECT_REASON_HPDRX) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* Check whether DP signal detected: if not -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * we assume signal is DVI; it could be corrected<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * to HDMI after dongle detection<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!is_dp_sink_present(link))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D SIGNAL_TYPE_DVI_SINGLE_LIN=
K;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
@@ -460,9 +467,10 @@ static void detect_dp(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct display_sink_capability *sink_caps,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool *converter_disable_audio,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct audio_support *audio_support,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0bool boot)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0enum dc_detect_reason reason)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0sink_caps-&gt;signal =3D link_detect_sink(link)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool boot =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sink_caps-&gt;signal =3D link_detect_sink(link,=
 reason);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sink_caps-&gt;transaction_type =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_ddc_transaction=
_type(sink_<wbr>caps-&gt;signal);<br>
<br>
@@ -513,6 +521,8 @@ static void detect_dp(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* Need check -&gt;sink usages in case -&gt;sink =3D NULL<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0* TODO: s3 resume check<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (reason =3D=3D DETECT_REASON_BOOT)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0boot =3D true;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (dm_helpers_dp_mst_start_top_<wbr>mgr(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link-&gt;ctx,<br>
@@ -531,7 +541,7 @@ static void detect_dp(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-bool dc_link_detect(struct dc_link *link, bool boot)<br>
+bool dc_link_detect(struct dc_link *link, enum dc_detect_reason reason)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dc_sink_init_data sink_init_data =3D { 0=
 };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct display_sink_capability sink_caps =3D { =
0 };<br>
@@ -596,7 +606,7 @@ bool dc_link_detect(struct dc_link *link, bool boot)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 link,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;sink_caps,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;converter_disable_audio,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aud_support, boot);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aud_support, reason);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Active dongle downstream unplug */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (link-&gt;type =3D=3D dc_connection_active_dongle<br>
diff --git a/drivers/gpu/drm/amd/display/<wbr>dc/dc.h b/drivers/gpu/drm/amd=
/display/<wbr>dc/dc.h<br>
index f005add1aba3..bf2d42561362 100644<br>
--- a/drivers/gpu/drm/amd/display/<wbr>dc/dc.h<br>
+++ b/drivers/gpu/drm/amd/display/<wbr>dc/dc.h<br>
@@ -884,7 +884,13 @@ bool dc_link_setup_psr(struct dc_link *dc_link,<br>
=C2=A0 * true otherwise. True meaning further action is required (status up=
date<br>
=C2=A0 * and OS notification).<br>
=C2=A0 */<br>
-bool dc_link_detect(struct dc_link *dc_link, bool boot);<br>
+enum dc_detect_reason {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DETECT_REASON_BOOT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DETECT_REASON_HPD,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0DETECT_REASON_HPDRX,<br>
+};<br>
+<br>
+bool dc_link_detect(struct dc_link *dc_link, enum dc_detect_reason reason)=
;<br>
<br>
=C2=A0/* Notify DC about DP RX Interrupt (aka Short Pulse Interrupt).<br>
=C2=A0 * Return:<br>
--<br>
2.11.0<br>
<br>
______________________________<wbr>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/<wbr>mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div></div>

--f403043ee078cbf5fb0558efa681--

--===============2082986003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2082986003==--
