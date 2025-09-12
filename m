Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9BBCA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 18:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E206B10ECBE;
	Fri, 12 Sep 2025 18:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P3+JlduY";
	dkim-atps=neutral
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com
 [209.85.166.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A1AA10ECBE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 18:05:36 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id
 e9e14a558f8ab-417661ecc5eso10887225ab.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757700336; x=1758305136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMqU2klDWvxZSPSl8G9wROwoOwEP1DsAPemPOyOlVjk=;
 b=P3+JlduYTM3pwe1DLHH1WptLgRjBNOrvubi8Y1UfKFpMozTAnkfbvclc9dYyzRn3wW
 2hEBfXdwv4ATaLVSI8QZLl8WoxLPORIc97fVbrzCvQXAYGCZp+FNaavIe6zao12i6lLP
 zstEncpxN6O9/c93V+diWkNBCczUzWnym/ib3EDJABCymuVU0dccKSmLU3n652onKrHw
 nntmqXBsyY6yqPOCHML1NsBQzgrJ2hjjrV28lJWmoIpR7NERreP3QeRSl4oV7NQF+5SQ
 B1BBh6dpAlEjD3Tuw4Olm/vfyyavAXiuAxlj8ovbFNNgqoWsEKfdzVYFP4S/mHmqxuHm
 xjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757700336; x=1758305136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DMqU2klDWvxZSPSl8G9wROwoOwEP1DsAPemPOyOlVjk=;
 b=xHjBmAJmFjyNp4gQdFDBGECJq5n7qkCetcUkXirjtedD2xLzObceY6pgmmgeD/aJVE
 8VfHcGPNqe+Z9P8va+G1iMr6rwO/B+QfE2H+2BQiIQjgaDLypHz/6ejWQzq1avtxz0n8
 Sx+PIiaOkwoUk4+Io6pk8CagsyxSMwzBhawmaSqrYHqYtmugC5J/wyspi1GbM4IuN+z0
 g+rd6bEvK+Gbaw7qGPCyIVVEA1nlBaIHLjvcpQH1hCl+SJufRRXP5J745J7crVYlrkzd
 VlQQ38btkAXS78UnqwJCqHxdRD9KMU4yBEa96naYCBX+5vBJx4qXKXqGDt4S0cMwcKOh
 NWqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW+5hAvZI9ZNZNdaKVxEnGb0D9TSENXkny+WZpvr7Qvkpu8rp8WRTGJryAqb8roMpiIqwsSMCS@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyj8Dn3KlRSdBTz+xxAyWOsNK8Qf9seWiIOivA+07es8m9kxY4T
 BWioLnSgAvHg7UyA2zRY80mdNfy7q6YTSEtMo3GRWTPXrsaYCBvJW8XmwAC1CGUrStha4vEwZ0s
 k1A8YWg4g0Ec8twiVgRrzc5JLUS7GzfQ=
X-Gm-Gg: ASbGncsCiTQaQQPfM55jSpRBeW4MhKY0DEBUZy9JXCiEpWO00uKsHZ7/2Lrh/+uCRnd
 izpI6YXK8KesMsDZcwBkbMV76u7A85w67bZvFCl7HTNq1XbfDBNB0tBPVp3sAAkovptI5UOcarh
 NwaCiKascZ2ERfh8HeESeNT8ahCAQIADB/w0tXkqroILzBQPAtDef1bNGvk1ag0VTTUVtveP7ZI
 NFi4AK4BKYTcS6Ci4pMccE4HLsJLeG2jJ6rXsqQzQjWZ6ubg2vE0PSR3/Q6w2AuaUI2cfveSQ==
X-Google-Smtp-Source: AGHT+IEEeRMFvv90i5H9olTwgwB2sRaHa6ldngzy2YIcizazQ2aa//4TBnPfEQ8sUr9MfW+2k0Dr418d5PcszfMSeO0=
X-Received: by 2002:a05:6e02:19ce:b0:407:dc0b:7ba2 with SMTP id
 e9e14a558f8ab-4209d40fe6emr70635255ab.3.1757700335757; Fri, 12 Sep 2025
 11:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250908204207.8397-1-stefan.silviu.alexandru@gmail.com>
 <BL1PR12MB51442BF8FBDCE9F4A23C21D0F70CA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAB7_Ay8KKxn_unO6RiLKn=ZPrFoapHkMQjUWO6+_o0FjTkLy3A@mail.gmail.com>
 <CADnq5_PyD=_wv+kOSQ5FoyLU=YLhW3tRLc4_MX3uvM-qgim+YA@mail.gmail.com>
In-Reply-To: <CADnq5_PyD=_wv+kOSQ5FoyLU=YLhW3tRLc4_MX3uvM-qgim+YA@mail.gmail.com>
From: Silviu-Alexandru Stefan <stefan.silviu.alexandru@gmail.com>
Date: Fri, 12 Sep 2025 21:05:24 +0300
X-Gm-Features: Ac12FXzFCQGI3ybE27IeZ4Uq7-TFRjaXVoBGpWo6yj-9ssTz2c05utIJXHvaSmc
Message-ID: <CAB7_Ay9nBHWGYgg_hF0Ye6hBDOa0_krSpTRnDdOS+C-Wod33CQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Register DP aux only if used
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 9 Sept 2025 at 22:42, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Sep 9, 2025 at 1:39=E2=80=AFPM Silviu-Alexandru Stefan
> <stefan.silviu.alexandru@gmail.com> wrote:
> >
> > On Tue, 9 Sept 2025 at 00:16, Deucher, Alexander
> > <Alexander.Deucher@amd.com> wrote:
> > >
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of =
Silviu-
> > > > Alexandru =C8=98tefan
> > > > Sent: Monday, September 8, 2025 4:42 PM
> > > > To: amd-gfx@lists.freedesktop.org
> > > > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > > > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Silvi=
u-
> > > > Alexandru =C8=98tefan <stefan.silviu.alexandru@gmail.com>
> > > > Subject: [PATCH] drm/amd/display: Register DP aux only if used
> > > >
> > > > The aux channel is always registered if the connector is DP, even w=
hen the link
> > > > doesn't contain DP. When using the DisplayPort connector in DP++ mo=
de, the I2C
> > > > is done directly over the pins, not over an aux channel. The practi=
cal effect is the
> > > > creation of
> > > > 2 I2C devices for DDC, one from the actual pins, and another from t=
he aux channel.
> > > >
> > > > This generates duplicate results from tools like ddcutil, for examp=
le using a cheap
> > > > passive DP-to-DVI cable:
> > > >
> > > > Display 1
> > > >    I2C bus:  /dev/i2c-3
> > > >    DRM_connector:           card1-DP-1
> > > > ...
> > > > Display 3
> > > >    I2C bus:  /dev/i2c-7
> > > >    DRM_connector:           card1-DP-1
> > > > ...
> > > >
> > > > The "real" bus is i2c-3, while the aux i2c-7 doesn't work.
> > > >
> > > > Any read on the aux channel succeeds, but always returns an all-zer=
o buffer,
> > > > further confusing ddcutil which just says "Maximum retries exceeded=
", even if it will
> > > > never work.
> > > >
> > > > The dc_link->aux_mode is true if the link actually intends to use a=
ux for DDC I2C,
> > > > so skip registering aux unless the link is actually in aux mode.
> > >
> > > I don't think you can skip this otherwise you'll never have the other=
 bus.  E.g., if you unplug the DP++ monitor and then plug in a DP monitor, =
the aux bus won't exist and then you'll have the opposite problem.
> >
> > Hello,
> >
> > Thanks for the review. You're right, the bus doesn't come back if I
> > switch around my monitors, I should have thought of that. I was
> > thinking the extra bus has to be wrong because other things only show
> > up in /dev if something is actually there, but I guess that isn't
> > necessarily correct here.
> >
> > > You just need to use the right one based on what monitor is attached.=
  In general, userspace shouldn't be messing with the i2c buses in the firs=
t place.  If you need access to the EDIDs, the drm provides access to them.
> >
> > I want to change input source and/or brightness for 2 monitors with a
> > script, so it's more about commands over DDC than EDID. I see there is
> > a symlink "/sys/class/drm/card1-DP-1/ddc", but that has the opposite
> > issue as it always points to the non-aux i2c (good for DP++, bad for
> > normal DP).
> >
> > Would it make sense to at least update the ddc symlink when the DP
> > link changes? That way it would always point at the actual i2c being
> > used for DDC, aux or not.
> > Or should I leave it like this and figure out in userspace which bus to=
 use?
>
> I'm not sure how the symlink is managed.  If that can be handled
> dynamically that would be ok I think.
>

The symlink update can be done by just removing it and recreating it
(also tried renaming the new symlink on top of the old one, but that
gives EEXIST). The relevant code is in drm/drm_sysfs.c, though it
needs to export a new function to do this. That function can then be
called in amdgpu_dm_update_connector_after_detect to change the
symlink on hotplug.

For the initial ddc symlink, amdgpu_dm_connector_init can pick the
correct bus for drm_connector_init_with_ddc by checking aux_mode. The
Intel driver sets aux as ddc, so this part seems ok to do.

I've tested it on boot and on hotplug (physically switching the ports
used for the DP++ and DP monitors), it worked fine.

Assuming the approach is ok, I can send this patch after writing a
commit message. I also have a question about the drm_sysfs change,
should I just CC maintainers from drm-misc on the same patch or should
it be a separate one?

In the meantime here's the diff:

---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 52 ++++++++++++++-----
drivers/gpu/drm/drm_sysfs.c                   | 14 +++++
include/drm/drm_sysfs.h                       |  2 +
3 files changed, 54 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fadc6098eae..3b04998780d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -95,6 +95,7 @@
#include <drm/drm_vblank.h>
#include <drm/drm_audio_component.h>
#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_sysfs.h>

#include <media/cec-notifier.h>
#include <acpi/video.h>
@@ -3695,6 +3696,32 @@ static void update_connector_ext_caps(struct
amdgpu_dm_connector *aconnector)
               caps->min_input_signal =3D min_input_signal_override;
}

+static struct i2c_adapter * select_ddc_adapter(struct
amdgpu_dm_connector *aconnector)
+{
+       if (aconnector->dc_link && aconnector->dc_link->aux_mode) {
+               return &aconnector->dm_dp_aux.aux.ddc;
+       } else {
+               return &aconnector->i2c->base;
+       }
+}
+
+static void amdgpu_update_connector_sysfs(struct amdgpu_dm_connector
*aconnector)
+{
+       int ret;
+       struct i2c_adapter *old_ddc =3D aconnector->base.ddc;
+
+       aconnector->base.ddc =3D select_ddc_adapter(aconnector);
+
+       if (aconnector->base.ddc =3D=3D old_ddc) {
+               return;
+       }
+
+       ret =3D drm_sysfs_connector_update(&aconnector->base);
+       if (ret) {
+               drm_err(aconnector->base.dev, "failed to update
connector ddc sysfs, %d", ret);
+       }
+}
+
DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))

void amdgpu_dm_update_connector_after_detect(
@@ -3818,6 +3845,7 @@ void amdgpu_dm_update_connector_after_detect(

               amdgpu_dm_update_freesync_caps(connector, aconnector->drm_ed=
id);
               update_connector_ext_caps(aconnector);
+               amdgpu_update_connector_sysfs(aconnector);
       } else {
               hdmi_cec_unset_edid(aconnector);
               drm_dp_cec_unset_edid(&aconnector->dm_dp_aux.aux);
@@ -7466,14 +7494,9 @@ static void
amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
       struct dc_link *dc_link =3D aconnector->dc_link;
       struct dc_sink *dc_em_sink =3D aconnector->dc_em_sink;
       const struct drm_edid *drm_edid;
-       struct i2c_adapter *ddc;
+       struct i2c_adapter *ddc =3D select_ddc_adapter(aconnector);
       struct drm_device *dev =3D connector->dev;

-       if (dc_link && dc_link->aux_mode)
-               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
-       else
-               ddc =3D &aconnector->i2c->base;
-
       drm_edid =3D drm_edid_read_ddc(connector, ddc);
       drm_edid_connector_update(connector, drm_edid);
       if (!drm_edid) {
@@ -7519,19 +7542,13 @@ static int get_modes(struct drm_connector *connecto=
r)
static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
{
       struct drm_connector *connector =3D &aconnector->base;
-       struct dc_link *dc_link =3D aconnector->dc_link;
       struct dc_sink_init_data init_params =3D {
                       .link =3D aconnector->dc_link,
                       .sink_signal =3D SIGNAL_TYPE_VIRTUAL
       };
       const struct drm_edid *drm_edid;
       const struct edid *edid;
-       struct i2c_adapter *ddc;
-
-       if (dc_link && dc_link->aux_mode)
-               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
-       else
-               ddc =3D &aconnector->i2c->base;
+       struct i2c_adapter *ddc =3D select_ddc_adapter(aconnector);

       drm_edid =3D drm_edid_read_ddc(connector, ddc);
       drm_edid_connector_update(connector, drm_edid);
@@ -8686,6 +8703,7 @@ static int amdgpu_dm_connector_init(struct
amdgpu_display_manager *dm,
       struct dc *dc =3D dm->dc;
       struct dc_link *link =3D dc_get_link_at_index(dc, link_index);
       struct amdgpu_i2c_adapter *i2c;
+       struct i2c_adapter *ddc;

       /* Not needed for writeback connector */
       link->priv =3D aconnector;
@@ -8705,6 +8723,12 @@ static int amdgpu_dm_connector_init(struct
amdgpu_display_manager *dm,
               goto out_free;
       }

+       if (link->aux_mode) {
+               ddc =3D &aconnector->dm_dp_aux.aux.ddc;
+       } else {
+               ddc =3D &i2c->base;
+       }
+
       connector_type =3D to_drm_connector_type(link->connector_signal);

       res =3D drm_connector_init_with_ddc(
@@ -8712,7 +8736,7 @@ static int amdgpu_dm_connector_init(struct
amdgpu_display_manager *dm,
                       &aconnector->base,
                       &amdgpu_dm_connector_funcs,
                       connector_type,
-                       &i2c->base);
+                       ddc);

       if (res) {
               drm_err(adev_to_drm(dm->adev), "connector_init failed\n");
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 60c1f26edb6..c216ee67abf 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -395,6 +395,20 @@ int drm_sysfs_connector_add_late(struct
drm_connector *connector)
       return 0;
}

+int drm_sysfs_connector_update(struct drm_connector *connector)
+{
+       if (connector->ddc) {
+               sysfs_remove_link(&connector->kdev->kobj, "ddc");
+
+               return sysfs_create_link(&connector->kdev->kobj,
+                                        &connector->ddc->dev.kobj, "ddc");
+       }
+
+       return 0;
+}
+
+EXPORT_SYMBOL_GPL(drm_sysfs_connector_update);
+
void drm_sysfs_connector_remove_early(struct drm_connector *connector)
{
       if (connector->ddc)
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index 96a5d858404..60a45a8d796 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -10,6 +10,8 @@ struct drm_property;
int drm_class_device_register(struct device *dev);
void drm_class_device_unregister(struct device *dev);

+int drm_sysfs_connector_update(struct drm_connector *connector);
+
void drm_sysfs_hotplug_event(struct drm_device *dev);
void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
void drm_sysfs_connector_property_event(struct drm_connector *connector,


Thanks,
Silviu


> Another option would be to only expose a single i2c bus for each
> physical connector and then internally the driver would use either the
> legacy i2c pins or the aux bus depending on what was connected.  That
> would prevent use of both buses independently however and it would
> make it impossible to use different i2c devices independently for each
> internal bus.
>
> Alex
>
> >
> > Thanks,
> > Silviu
> >
> >
> >
> > >
> > > Alex
> > > >
> > > > i2cdetect -y 3:
> > > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > > 00:                         -- -- -- -- -- -- -- --
> > > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- --
> > > > 40: 40 41 -- -- -- -- -- -- -- 49 -- -- -- -- -- --
> > > > 50: 50 -- -- -- -- -- -- -- -- 59 -- -- -- -- -- --
> > > > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 70: -- -- -- -- -- -- -- --
> > > >
> > > > i2cdetect -y 7:
> > > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > > 00:                         -- -- -- -- -- -- -- --
> > > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > > 70: -- -- -- -- -- -- -- --
> > > >
> > > > Signed-off-by: Silviu-Alexandru =C8=98tefan <stefan.silviu.alexandr=
u@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++=
--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > index fadc6098eae..1759071e02a 100644
> > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > @@ -7429,6 +7429,16 @@ amdgpu_dm_connector_atomic_duplicate_state(s=
truct
> > > > drm_connector *connector)
> > > >       return &new_state->base;
> > > >  }
> > > >
> > > > +static inline bool amdgpu_dm_should_register_dp_aux(
> > > > +     struct amdgpu_dm_connector *amdgpu_dm_connector) {
> > > > +     int connector_type =3D amdgpu_dm_connector->base.connector_ty=
pe;
> > > > +
> > > > +     return ((connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort=
) ||
> > > > +             (connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) &&
> > > > +            amdgpu_dm_connector->dc_link->aux_mode;
> > > > +}
> > > > +
> > > >  static int
> > > >  amdgpu_dm_connector_late_register(struct drm_connector *connector)=
  { @@ -
> > > > 7445,8 +7455,7 @@ amdgpu_dm_connector_late_register(struct drm_conn=
ector
> > > > *connector)
> > > >
> > > >       amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> > > >
> > > > -     if ((connector->connector_type =3D=3D
> > > > DRM_MODE_CONNECTOR_DisplayPort) ||
> > > > -         (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)=
) {
> > > > +     if (amdgpu_dm_should_register_dp_aux(amdgpu_dm_connector)) {
> > > >               amdgpu_dm_connector->dm_dp_aux.aux.dev =3D connector-=
>kdev;
> > > >               r =3D drm_dp_aux_register(&amdgpu_dm_connector-
> > > > >dm_dp_aux.aux);
> > > >               if (r)
> > > >
> > > > base-commit: 837f3abbfebdb355ed049c2b06b54108e2bbdf35
> > > > --
> > > > 2.51.0
> > >
