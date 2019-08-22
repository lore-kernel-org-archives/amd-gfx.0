From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 1/9] drm_dp_cec: add connector info support.
Date: Thu, 22 Aug 2019 12:40:47 +0000
Message-ID: <BN6PR12MB1809F2FD206B4E969ECBE24DF7A50@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190814104520.6001-1-darekm@google.com>
 <20190814104520.6001-2-darekm@google.com>,
 <38cda4f5-3299-2bd4-65f5-9a0f948902c6@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0353654276=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <38cda4f5-3299-2bd4-65f5-9a0f948902c6-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
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
To: Hans Verkuil <hverkuil-cisco-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Dariusz Marcinkiewicz <darekm-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Lim <Thomas.Lim-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Francis,
 David" <David.Francis-5C7GfCeVMHo@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Manasi Navare <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Li,
 Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Zuo, Jerry" <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>, Dhinakaran Pandiyan <dhinakaran.pandiyan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rodrigo Vivi <rodrigo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, "Koo,
 Anthony" <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>, "intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

--===============0353654276==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809F2FD206B4E969ECBE24DF7A50BN6PR12MB1809namp_"

--_000_BN6PR12MB1809F2FD206B4E969ECBE24DF7A50BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: Hans Verkuil <hverkuil-cisco-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Sent: Thursday, August 22, 2019 4:08 AM
To: Dariusz Marcinkiewicz <darekm-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-m=
edia-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>; nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <nouveau=
@lists.freedesktop.org>; Dhinakaran Pandiyan <dhinakaran.pandiyan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org=
>; Koo, Anthony <Anthony.Koo-5C7GfCeVMHo@public.gmane.org>; Francis, David <David.Francis-urvtwAKJhsc@public.gmane.org=
m>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zuo, Jer=
ry <Jerry.Zuo-5C7GfCeVMHo@public.gmane.org>; Ben Skeggs <bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; Li, Sun peng (Leo)=
 <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>; intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <intel-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org>; Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Rodrigo Vivi <rodrigo.vi=
vi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>; Thomas Lim <Thomas.Lim-5C7GfCeVMHo@public.gmane.org>=
; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; Manasi Navar=
e <manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Deucher, Alexander <Alexander.Deucher-urvtwAKJhsc@public.gmane.org=
m>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Ville Syrj=E4l=E4 <ville.=
syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v7 1/9] drm_dp_cec: add connector info support.

Alex, Ville/Rodrigo, Ben,

Can you (hopefully) Ack this patch so that I can merge it?

Thank you!

        Hans

On 8/14/19 12:44 PM, Dariusz Marcinkiewicz wrote:
> Pass the connector info to the CEC adapter. This makes it possible
> to associate the CEC adapter with the corresponding drm connector.
>
> Signed-off-by: Dariusz Marcinkiewicz <darekm-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Hans Verkuil <hverkuil-cisco-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> Tested-by: Hans Verkuil <hverkuil-cisco-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> ---
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 +-
>  drivers/gpu/drm/drm_dp_cec.c                  | 25 ++++++++++++-------
>  drivers/gpu/drm/i915/display/intel_dp.c       |  4 +--
>  drivers/gpu/drm/nouveau/nouveau_connector.c   |  3 +--
>  include/drm/drm_dp_helper.h                   | 17 ++++++-------
>  5 files changed, 27 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 16218a202b591..5ec14efd4d8cb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -416,7 +416,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_=
display_manager *dm,
>
>        drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
>        drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
> -                                   aconnector->base.name, dm->adev->dev)=
;
> +                                   &aconnector->base);
>        aconnector->mst_mgr.cbs =3D &dm_mst_cbs;
>        drm_dp_mst_topology_mgr_init(
>                &aconnector->mst_mgr,
> diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec.c
> index b15cee85b702b..b457c16c3a8bb 100644
> --- a/drivers/gpu/drm/drm_dp_cec.c
> +++ b/drivers/gpu/drm/drm_dp_cec.c
> @@ -8,7 +8,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
> +#include <drm/drm_connector.h>
>  #include <drm/drm_dp_helper.h>
> +#include <drm/drmP.h>
>  #include <media/cec.h>
>
>  /*
> @@ -295,7 +297,10 @@ static void drm_dp_cec_unregister_work(struct work_s=
truct *work)
>   */
>  void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid=
)
>  {
> -     u32 cec_caps =3D CEC_CAP_DEFAULTS | CEC_CAP_NEEDS_HPD;
> +     struct drm_connector *connector =3D aux->cec.connector;
> +     u32 cec_caps =3D CEC_CAP_DEFAULTS | CEC_CAP_NEEDS_HPD |
> +                    CEC_CAP_CONNECTOR_INFO;
> +     struct cec_connector_info conn_info;
>        unsigned int num_las =3D 1;
>        u8 cap;
>
> @@ -344,13 +349,17 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *aux, co=
nst struct edid *edid)
>
>        /* Create a new adapter */
>        aux->cec.adap =3D cec_allocate_adapter(&drm_dp_cec_adap_ops,
> -                                          aux, aux->cec.name, cec_caps,
> +                                          aux, connector->name, cec_caps=
,
>                                             num_las);
>        if (IS_ERR(aux->cec.adap)) {
>                aux->cec.adap =3D NULL;
>                goto unlock;
>        }
> -     if (cec_register_adapter(aux->cec.adap, aux->cec.parent)) {
> +
> +     cec_fill_conn_info_from_drm(&conn_info, connector);
> +     cec_s_conn_info(aux->cec.adap, &conn_info);
> +
> +     if (cec_register_adapter(aux->cec.adap, connector->dev->dev)) {
>                cec_delete_adapter(aux->cec.adap);
>                aux->cec.adap =3D NULL;
>        } else {
> @@ -406,22 +415,20 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);
>  /**
>   * drm_dp_cec_register_connector() - register a new connector
>   * @aux: DisplayPort AUX channel
> - * @name: name of the CEC device
> - * @parent: parent device
> + * @connector: drm connector
>   *
>   * A new connector was registered with associated CEC adapter name and
>   * CEC adapter parent device. After registering the name and parent
>   * drm_dp_cec_set_edid() is called to check if the connector supports
>   * CEC and to register a CEC adapter if that is the case.
>   */
> -void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char *n=
ame,
> -                                struct device *parent)
> +void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> +                                struct drm_connector *connector)
>  {
>        WARN_ON(aux->cec.adap);
>        if (WARN_ON(!aux->transfer))
>                return;
> -     aux->cec.name =3D name;
> -     aux->cec.parent =3D parent;
> +     aux->cec.connector =3D connector;
>        INIT_DELAYED_WORK(&aux->cec.unregister_work,
>                          drm_dp_cec_unregister_work);
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 1092499115760..de2486fe7bf2d 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -5497,7 +5497,6 @@ static int
>  intel_dp_connector_register(struct drm_connector *connector)
>  {
>        struct intel_dp *intel_dp =3D intel_attached_dp(connector);
> -     struct drm_device *dev =3D connector->dev;
>        int ret;
>
>        ret =3D intel_connector_register(connector);
> @@ -5512,8 +5511,7 @@ intel_dp_connector_register(struct drm_connector *c=
onnector)
>        intel_dp->aux.dev =3D connector->kdev;
>        ret =3D drm_dp_aux_register(&intel_dp->aux);
>        if (!ret)
> -             drm_dp_cec_register_connector(&intel_dp->aux,
> -                                           connector->name, dev->dev);
> +             drm_dp_cec_register_connector(&intel_dp->aux, connector);
>        return ret;
>  }
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index 330d7d29a6e34..8aa703347eb54 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1416,8 +1416,7 @@ nouveau_connector_create(struct drm_device *dev,
>        switch (type) {
>        case DRM_MODE_CONNECTOR_DisplayPort:
>        case DRM_MODE_CONNECTOR_eDP:
> -             drm_dp_cec_register_connector(&nv_connector->aux,
> -                                           connector->name, dev->dev);
> +             drm_dp_cec_register_connector(&nv_connector->aux, connector=
);
>                break;
>        }
>
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index 8364502f92cfe..7972b925a952b 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1230,20 +1230,19 @@ struct drm_dp_aux_msg {
>
>  struct cec_adapter;
>  struct edid;
> +struct drm_connector;
>
>  /**
>   * struct drm_dp_aux_cec - DisplayPort CEC-Tunneling-over-AUX
>   * @lock: mutex protecting this struct
>   * @adap: the CEC adapter for CEC-Tunneling-over-AUX support.
> - * @name: name of the CEC adapter
> - * @parent: parent device of the CEC adapter
> + * @connector: the connector this CEC adapter is associated with
>   * @unregister_work: unregister the CEC adapter
>   */
>  struct drm_dp_aux_cec {
>        struct mutex lock;
>        struct cec_adapter *adap;
> -     const char *name;
> -     struct device *parent;
> +     struct drm_connector *connector;
>        struct delayed_work unregister_work;
>  };
>
> @@ -1451,8 +1450,8 @@ drm_dp_has_quirk(const struct drm_dp_desc *desc, en=
um drm_dp_quirk quirk)
>
>  #ifdef CONFIG_DRM_DP_CEC
>  void drm_dp_cec_irq(struct drm_dp_aux *aux);
> -void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char *n=
ame,
> -                                struct device *parent);
> +void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> +                                struct drm_connector *connector);
>  void drm_dp_cec_unregister_connector(struct drm_dp_aux *aux);
>  void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct edid *edid=
);
>  void drm_dp_cec_unset_edid(struct drm_dp_aux *aux);
> @@ -1461,9 +1460,9 @@ static inline void drm_dp_cec_irq(struct drm_dp_aux=
 *aux)
>  {
>  }
>
> -static inline void drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> -                                              const char *name,
> -                                              struct device *parent)
> +static inline void
> +drm_dp_cec_register_connector(struct drm_dp_aux *aux,
> +                           struct drm_connector *connector)
>  {
>  }
>
>


--_000_BN6PR12MB1809F2FD206B4E969ECBE24DF7A50BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Hans Verkuil &lt;hver=
kuil-cisco-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, August 22, 2019 4:08 AM<br>
<b>To:</b> Dariusz Marcinkiewicz &lt;darekm-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org&gt;; dri-devel@lists=
.freedesktop.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; linux-media@vger.=
kernel.org &lt;linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br>
<b>Cc:</b> David Airlie &lt;airlied-cv59FeDIM0c@public.gmane.org&gt;; nouveau-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org &lt;nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Dhinakaran Pandiyan &lt;dhinaka=
ran.pandiyan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt;; Koo, Anthony &lt;Anthony.Koo-5C7GfCeVMHo@public.gmane.org&gt;; Franc=
is, David &lt;David.Francis-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
 &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Zuo, Jerry &lt;Jerry.Zuo-5C7GfCeVMHo@public.gmane.org&gt=
;; Ben Skeggs &lt;bskeggs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li=
@amd.com&gt;; intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;intel-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org&gt;; Maxime Ripard &lt;mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org&gt;; Rodrigo Vivi &lt;rodr=
igo.vivi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt;;
 Sean Paul &lt;sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org&gt;; Thomas Lim &lt;Thomas.Lim-5C7GfCeVMHo@public.gmane.org&gt;; =
linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org &lt;linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;; Manasi N=
avare &lt;manasi.d.navare-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org&gt;; Deucher, Alexander &lt;Alexander.D=
eucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;;
 Ville Syrj=E4l=E4 &lt;ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH v7 1/9] drm_dp_cec: add connector info support.<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Alex, Ville/Rodrigo, Ben,<br>
<br>
Can you (hopefully) Ack this patch so that I can merge it?<br>
<br>
Thank you!<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Hans<br>
<br>
On 8/14/19 12:44 PM, Dariusz Marcinkiewicz wrote:<br>
&gt; Pass the connector info to the CEC adapter. This makes it possible<br>
&gt; to associate the CEC adapter with the corresponding drm connector.<br>
&gt; <br>
&gt; Signed-off-by: Dariusz Marcinkiewicz &lt;darekm-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org&gt;<br>
&gt; Signed-off-by: Hans Verkuil &lt;hverkuil-cisco-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org&gt;<br>
&gt; Tested-by: Hans Verkuil &lt;hverkuil-cisco-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../display/amdgpu_dm/amdgpu_dm_mst_types.c&nbsp;&nbsp; |&nbsp; =
2 &#43;-<br>
&gt;&nbsp; drivers/gpu/drm/drm_dp_cec.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 25 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&gt;&nbsp; drivers/gpu/drm/i915/display/intel_dp.c&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 4 &#43;--<br>
&gt;&nbsp; drivers/gpu/drm/nouveau/nouveau_connector.c&nbsp;&nbsp; |&nbsp; =
3 &#43;--<br>
&gt;&nbsp; include/drm/drm_dp_helper.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1=
7 &#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&gt;&nbsp; 5 files changed, 27 insertions(&#43;), 24 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types=
.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c<br>
&gt; index 16218a202b591..5ec14efd4d8cb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_=
types.c<br>
&gt; @@ -416,7 &#43;416,7 @@ void amdgpu_dm_initialize_dp_connector(struct =
amdgpu_display_manager *dm,<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_aux_register(&amp;aco=
nnector-&gt;dm_dp_aux.aux);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_cec_register_connecto=
r(&amp;aconnector-&gt;dm_dp_aux.aux,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt=
;base.name, dm-&gt;adev-&gt;dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;aconn=
ector-&gt;base);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;mst_mgr.cbs =
=3D &amp;dm_mst_cbs;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_mst_topology_mgr_init=
(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;aconnector-&gt;mst_mgr,<br>
&gt; diff --git a/drivers/gpu/drm/drm_dp_cec.c b/drivers/gpu/drm/drm_dp_cec=
.c<br>
&gt; index b15cee85b702b..b457c16c3a8bb 100644<br>
&gt; --- a/drivers/gpu/drm/drm_dp_cec.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/drm_dp_cec.c<br>
&gt; @@ -8,7 &#43;8,9 @@<br>
&gt;&nbsp; #include &lt;linux/kernel.h&gt;<br>
&gt;&nbsp; #include &lt;linux/module.h&gt;<br>
&gt;&nbsp; #include &lt;linux/slab.h&gt;<br>
&gt; &#43;#include &lt;drm/drm_connector.h&gt;<br>
&gt;&nbsp; #include &lt;drm/drm_dp_helper.h&gt;<br>
&gt; &#43;#include &lt;drm/drmP.h&gt;<br>
&gt;&nbsp; #include &lt;media/cec.h&gt;<br>
&gt;&nbsp; <br>
&gt;&nbsp; /*<br>
&gt; @@ -295,7 &#43;297,10 @@ static void drm_dp_cec_unregister_work(struct=
 work_struct *work)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct ed=
id *edid)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 cec_caps =3D CEC_CAP_DEFAULTS | CEC_CAP_=
NEEDS_HPD;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connector =3D aux-=
&gt;cec.connector;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 cec_caps =3D CEC_CAP_DEFAULTS | CEC_=
CAP_NEEDS_HPD |<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CEC_CAP_CONNECTOR_INFO;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct cec_connector_info conn_info;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int num_las =3D 1;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 cap;<br>
&gt;&nbsp; <br>
&gt; @@ -344,13 &#43;349,17 @@ void drm_dp_cec_set_edid(struct drm_dp_aux *=
aux, const struct edid *edid)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Create a new adapter */<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux-&gt;cec.adap =3D cec_all=
ocate_adapter(&amp;drm_dp_cec_adap_ops,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; aux, aux-&gt;cec.name, cec_caps,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aux, connector-&gt;name, cec_caps,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_las);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (IS_ERR(aux-&gt;cec.adap)=
) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux-&gt;cec.adap =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto unlock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (cec_register_adapter(aux-&gt;cec.adap, a=
ux-&gt;cec.parent)) {<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; cec_fill_conn_info_from_drm(&amp;conn_in=
fo, connector);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; cec_s_conn_info(aux-&gt;cec.adap, &amp;c=
onn_info);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (cec_register_adapter(aux-&gt;cec.ada=
p, connector-&gt;dev-&gt;dev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; cec_delete_adapter(aux-&gt;cec.adap);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; aux-&gt;cec.adap =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; @@ -406,22 &#43;415,20 @@ EXPORT_SYMBOL(drm_dp_cec_unset_edid);<br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * drm_dp_cec_register_connector() - register a new connect=
or<br>
&gt;&nbsp;&nbsp; * @aux: DisplayPort AUX channel<br>
&gt; - * @name: name of the CEC device<br>
&gt; - * @parent: parent device<br>
&gt; &#43; * @connector: drm connector<br>
&gt;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp; * A new connector was registered with associated CEC adapt=
er name and<br>
&gt;&nbsp;&nbsp; * CEC adapter parent device. After registering the name an=
d parent<br>
&gt;&nbsp;&nbsp; * drm_dp_cec_set_edid() is called to check if the connecto=
r supports<br>
&gt;&nbsp;&nbsp; * CEC and to register a CEC adapter if that is the case.<b=
r>
&gt;&nbsp;&nbsp; */<br>
&gt; -void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char=
 *name,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *parent)<br>
&gt; &#43;void drm_dp_cec_register_connector(struct drm_dp_aux *aux,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connec=
tor)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(aux-&gt;cec.adap);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(!aux-&gt;transfe=
r))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; aux-&gt;cec.name =3D name;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; aux-&gt;cec.parent =3D parent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; aux-&gt;cec.connector =3D connector;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;aux-&=
gt;cec.unregister_work,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; drm_dp_cec_unregister_work);<br>
&gt;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm=
/i915/display/intel_dp.c<br>
&gt; index 1092499115760..de2486fe7bf2d 100644<br>
&gt; --- a/drivers/gpu/drm/i915/display/intel_dp.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/i915/display/intel_dp.c<br>
&gt; @@ -5497,7 &#43;5497,6 @@ static int<br>
&gt;&nbsp; intel_dp_connector_register(struct drm_connector *connector)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct intel_dp *intel_dp =
=3D intel_attached_dp(connector);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D connector-&gt;dev=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D intel_connector_regi=
ster(connector);<br>
&gt; @@ -5512,8 &#43;5511,7 @@ intel_dp_connector_register(struct drm_conne=
ctor *connector)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; intel_dp-&gt;aux.dev =3D con=
nector-&gt;kdev;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D drm_dp_aux_register(=
&amp;intel_dp-&gt;aux);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ret)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_dp_cec_register_connector(&amp;intel_dp-&gt;aux,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connector-&gt;name, dev-&gt;dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; drm_dp_cec_register_connector(&amp;intel_dp-&gt;aux, connector);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu=
/drm/nouveau/nouveau_connector.c<br>
&gt; index 330d7d29a6e34..8aa703347eb54 100644<br>
&gt; --- a/drivers/gpu/drm/nouveau/nouveau_connector.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/nouveau/nouveau_connector.c<br>
&gt; @@ -1416,8 &#43;1416,7 @@ nouveau_connector_create(struct drm_device *=
dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (type) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DRM_MODE_CONNECTOR_Disp=
layPort:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case DRM_MODE_CONNECTOR_eDP:=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; drm_dp_cec_register_connector(&amp;nv_connector-&gt;aux,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connector-&gt;name, dev-&gt;dev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; drm_dp_cec_register_connector(&amp;nv_connector-&gt;aux, connector)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h=
<br>
&gt; index 8364502f92cfe..7972b925a952b 100644<br>
&gt; --- a/include/drm/drm_dp_helper.h<br>
&gt; &#43;&#43;&#43; b/include/drm/drm_dp_helper.h<br>
&gt; @@ -1230,20 &#43;1230,19 @@ struct drm_dp_aux_msg {<br>
&gt;&nbsp; <br>
&gt;&nbsp; struct cec_adapter;<br>
&gt;&nbsp; struct edid;<br>
&gt; &#43;struct drm_connector;<br>
&gt;&nbsp; <br>
&gt;&nbsp; /**<br>
&gt;&nbsp;&nbsp; * struct drm_dp_aux_cec - DisplayPort CEC-Tunneling-over-A=
UX<br>
&gt;&nbsp;&nbsp; * @lock: mutex protecting this struct<br>
&gt;&nbsp;&nbsp; * @adap: the CEC adapter for CEC-Tunneling-over-AUX suppor=
t.<br>
&gt; - * @name: name of the CEC adapter<br>
&gt; - * @parent: parent device of the CEC adapter<br>
&gt; &#43; * @connector: the connector this CEC adapter is associated with<=
br>
&gt;&nbsp;&nbsp; * @unregister_work: unregister the CEC adapter<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; struct drm_dp_aux_cec {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex lock;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cec_adapter *adap;<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; const char *name;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct device *parent;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connector;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work unregist=
er_work;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; @@ -1451,8 &#43;1450,8 @@ drm_dp_has_quirk(const struct drm_dp_desc *d=
esc, enum drm_dp_quirk quirk)<br>
&gt;&nbsp; <br>
&gt;&nbsp; #ifdef CONFIG_DRM_DP_CEC<br>
&gt;&nbsp; void drm_dp_cec_irq(struct drm_dp_aux *aux);<br>
&gt; -void drm_dp_cec_register_connector(struct drm_dp_aux *aux, const char=
 *name,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *parent);<br>
&gt; &#43;void drm_dp_cec_register_connector(struct drm_dp_aux *aux,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connec=
tor);<br>
&gt;&nbsp; void drm_dp_cec_unregister_connector(struct drm_dp_aux *aux);<br=
>
&gt;&nbsp; void drm_dp_cec_set_edid(struct drm_dp_aux *aux, const struct ed=
id *edid);<br>
&gt;&nbsp; void drm_dp_cec_unset_edid(struct drm_dp_aux *aux);<br>
&gt; @@ -1461,9 &#43;1460,9 @@ static inline void drm_dp_cec_irq(struct drm=
_dp_aux *aux)<br>
&gt;&nbsp; {<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -static inline void drm_dp_cec_register_connector(struct drm_dp_aux *a=
ux,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *name,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *parent)<=
br>
&gt; &#43;static inline void<br>
&gt; &#43;drm_dp_cec_register_connector(struct drm_dp_aux *aux,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct drm_connector *connector)<br>
&gt;&nbsp; {<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809F2FD206B4E969ECBE24DF7A50BN6PR12MB1809namp_--

--===============0353654276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0353654276==--
