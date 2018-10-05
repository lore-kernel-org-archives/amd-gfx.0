From: Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Add variable refresh property to DRM CRTC
Date: Fri, 5 Oct 2018 11:10:59 +0300
Message-ID: <20181005111059.1cd71f95@eldfell>
References: <20180924181537.12092-1-nicholas.kazlauskas@amd.com>
 <20180924181537.12092-3-nicholas.kazlauskas@amd.com>
 <20180924183826.GX5565@intel.com>
 <4aa1583c-2be0-8cec-2857-6c3e489965b4@amd.com>
 <20180924202655.GA9144@intel.com>
 <bb8b3e03-94ce-3f0e-0947-ac0aaa4ff8a9@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0263141873=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <bb8b3e03-94ce-3f0e-0947-ac0aaa4ff8a9@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc: nicolai.haehnle@amd.com, michel@daenzer.net, Marek.Olsak@amd.com, amd-gfx@lists.freedesktop.org, manasi.d.navare@intel.com, dri-devel@lists.freedesktop.org, Alexander.Deucher@amd.com, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

--===============0263141873==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/G4YD1lCusOclL75HPWdsxxp"; protocol="application/pgp-signature"

--Sig_/G4YD1lCusOclL75HPWdsxxp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have a somewhat of my own view on what would be involved with VRR,
and I'd like to hear what you think of it. Comments inline.


On Tue, 25 Sep 2018 09:51:37 -0400
"Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com> wrote:

> On 09/24/2018 04:26 PM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Mon, Sep 24, 2018 at 03:06:02PM -0400, Kazlauskas, Nicholas wrote: =
=20
> >> On 09/24/2018 02:38 PM, Ville Syrj=C3=A4l=C3=A4 wrote: =20
> >>> On Mon, Sep 24, 2018 at 02:15:36PM -0400, Nicholas Kazlauskas wrote: =
=20
> >>>> Variable refresh rate algorithms have typically been enabled only
> >>>> when the display is covered by a single source of content.
> >>>>
> >>>> This patch introduces a new default CRTC property that helps
> >>>> hint to the driver when the CRTC composition is suitable for variable
> >>>> refresh rate algorithms. Userspace can set this property dynamically
> >>>> as the composition changes.
> >>>>
> >>>> Whether the variable refresh rate algorithms are active will still
> >>>> depend on the CRTC being suitable and the connector being capable
> >>>> and enabled by the user for variable refresh rate support.
> >>>>
> >>>> It is worth noting that while the property is atomic it isn't filter=
ed
> >>>> from legacy userspace queries. This allows for Xorg userspace drivers
> >>>> to implement support in non-atomic setups.
> >>>>
> >>>> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

...

> >>> Actually I don't understand why this per-crtc thing is being added at
> >>> all. You already have the prop on the connector. Why do we want to
> >>> make life more difficult by requiring the thing to be set on both the
> >>> crtc and connector? =20
> >>
> >> It doesn't make much sense without both.
> >>
> >> The user can globally enable or disable the variable_refresh_enabled on
> >> the connector. This is the user's preference.
> >>
> >> What they don't control is the variable_refresh - the content hint that
> >> userspace specifies when the CRTC contents are suitable for enabling
> >> variable refresh features (like adaptive sync). This is userspace's
> >> preference. =20
> >=20
> > By userspace I guess you mean the compositor/display server. I don't
> > really see why the kernel has to be involved like this in a userspace
> > policy matter. If the compositor doesn't think vrr is a good idea then
> > it could simply choose to disable the prop on the connector even when
> > requested by its clients. =20
>=20
> The properties are both a kernel and userspace API so I think it's=20
> important to think about the usecase and API usage for both.
>=20
> In a DRM driver the variable refresh capability will be determined by=20
> connector type and the display that's connected. The driver needs a way=20
> to track this if it's going to be sending any sort of packet over the=20
> connector. The capability property provides a method for the driver to=20
> do this while also exposing this information to the userspace for queryin=
g.
>=20
> The variable_refresh_enabled property exists because not all users will=20
> want this feature enabled. I think it makes sense to place this=20
> alongside the capability property on the connector because of their=20
> relation and because of the ease of access for the end user in existing=20
> userspace stacks - xrandr makes this easy.

I'm not sure I understood your intention here. Do you mean that you
expect games (e.g. via Mesa) to toggle the connector property via RandR
to tell if they wish for VRR?

The RandR interface is for display configuration utilities, like the UIs
that desktop environments use to configure monitors. It should not be
used by applications like games to modify anything. I believe there are
lots of apps out there that enrage users by abusing RandR, but one
should not base an interface design on such abuse.

If games are not using RandR to communicate the wish for VRR, what do
they use? Does the X11 Present extension have something for it?

What is the application-facing API to request VRR, is it in GLX, EGL,
Vulkan, something else?

Btw. I would not expect xrandr to qualify as proper userspace to
validate new kernel UABI, like new properties. Did you have something
else for the userspace settable connector property?

> The variable_refresh CRTC property exists for a few reasons.
>=20
> Userspace needs a method via the atomic API to let a DRM driver know=20
> that it wants variable frame timing to be enabled. The connector enable=20
> property certainly satisfies this condition - but I think there are=20
> other to take into consideration here.

I agree that this CRTC property makes sense.

> Whenever I mentioned variable refresh "features", what I really meant=20
> was operating in one of two modes:
>=20
> (1) Letting the driver and hardware adjust refresh automatically based=20
> on the flip rate on a CRTC from a single application
>=20
> (2) Setting a fixed frame duration based on the flip rate on a CRTC from=
=20
> a single application

I wonder if that's too much magic in the kernel... what would be wrong
with simply flipping ASAP when VRR is active?

How will userspace be able to predict coming flip opportunities if the
kernel does so much magic?

> In both cases the important thing to note is that they're both dependent=
=20
> on how often a CRTC is flipping. There's also the "requirement" for=20
> single application in both cases - if there are multiple applications=20
> issuing flips then the hardware can't determine the correct content=20
> rate. The resulting user experience is going to be negative as the=20
> monitor seemingly adjusts to a random rate.
>=20
> With the existing kernelspace and userspace stacks a DRM driver can't=20
> reasonably understand whether a single application is flipping or not=20
> and what variable refresh "mode" to operate in - these both depend on=20
> what's happening in userspace.
>=20
> These factors are decided in userspace when interfacing with a DRM CRTC.=
=20
> The userspace integration patches I've posted alongside this interface=20
> demonstrate this usage - checks are done against a CRTC to see if the=20
> application fully covers the surface and the automatic adjustment mode=20
> is only enabled for when flips are issued for the CRTC originating from=20
> that application.
>=20
> Determining which connectors use the CRTC can certainly be done and the=20
> property could be changed there, but I don't think this logically=20
> follows from the API usage described above.
>=20
> The reasoning behind this being a default property on the CRTC is that I=
=20
> don't think userspace should need to keep track of what's actually=20
> connected using the CRTC. A user can hotplug displays at will or=20
> enable/disable variable refresh support via their display's OSD.=20
> Capabilities can change and this is only something a driver really needs=
=20
> to concern themselves with - the driver is what sends the control=20
> packets to the hardware.

Userspace must already track carefully what is connected and what is
driven through which CRTC, otherwise it cannot drive the KMS API
correctly.

> I probably could have gone into more detail about some of this in the=20
> cover letter itself for these patchsets. These patches were actually a=20
> connector only interface originally but evolved after developing the=20
> actual implementation.
>=20
> >  =20
> >>
> >> When both preferences agree, only then will variable refresh features =
be
> >> enabled.
> >>
> >> The reasoning for the split is because not all content is suitable for
> >> variable refresh. Desktop environments, web browsers, etc only typical=
ly
> >> flip when needed - which will result in display flickering.

Flickering? What do you mean?

> >>
> >> The userspace integration as part of these patches demonstrates enabli=
ng
> >> variable_refresh on the CRTC selectively.


I believe that VRR on X11 would probably depend on these bits:

1. Hardware capability
	Whether the monitor, the CRTC hardware, and the kernel driver
	all agree that VRR is possible.

2. User preference
	A toggle on the desktop environment's display settings
	application to allow or disallow VRR. After all, video mode
	configuration is here too, and ideally applications should not
	mess with the video mode directly.

3. Application preference
	Whether the application, e.g. a game, is prepared to deal with
	VRR and wishes it to be enabled.

4. X server scenegraph
	Which windows happen to be showing on the VRR-capable output
	and does that scenegraph allow e.g. flipping straight to client
	buffers instead of having the X server copy into framebuffers
	of its own.

You mentioned that VRR probably doesn't make sense if there are
multiple windows showing in the same output, so point 4 would cover
that. Also games etc. would aim to hit the direct scanout path to avoid
wasting time in the X server copy, so it seems that requiring flips to
client buffers would be reasonable for enabling VRR. Sounds like that
is exactly how you implemented it in xf86-video-amdgpu, isn't it?

Skimming through your proposal, it seems you have covered 3 out of 4
points. Did you or I miss something? You cannot have points 2 and 3
fight over the control of the same property.

How do you envision VRR to interact with X11 compositing managers?

I presume compositing managers aim for the direct scanout path in the X
server to avoid yet another copy there, right? Does point 4 need to
exclude the Composite Overlay Window (COW) from allowed VRR windows?


Given all the above, I would like to question the choice of trying to
accommodate X11 interfaces directly in the DRM UABI. There seems to be
quite many bits controlled by different processes and VRR should be
active only when they all agree. Therefore, if you want end user
applications to rely on straight connector property pass-through via
RandR, you end up with more properties than strictly necessary,
complicating the UABI.

In other words, I agree with the criticism here by Ville and Daniel.


On the other hand, in Wayland architecture, there is only one single
userspace process you need to consider in the DRM UABI: the display
server:
- There is no separate compositing manager process.
- There is no separate application to handle user preference (point 2);
  well, not in the sense that you would need to consider it in the DRM
  UABI, because it will go through the display server that is part of
  the desktop rather than bypassing the desktop.
- There is no DRM property pass-through to end-user applications,
  instead there will be dedicated protocol extensions to let the
  display server make the final call.

Therefore, it would be fine to have just two bits:

1. Hardware capability
	Whether the monitor, the CRTC hardware, and the kernel driver
	all agree that VRR is possible.

2. - 4. Whether userspace (i.e. the display server) wants to use VRR or
	not. This would be the CRTC property.

I also believe that it would be useful to expose vmin/vmax to userspace
as properties, so that display servers and apps can plan ahead on when
they will render. I suppose that can be left for later when someone
starts working on userspace taking advantage of it, so that the proper
userspace requirement for new UABI is fulfilled.


Thanks,
pq

--Sig_/G4YD1lCusOclL75HPWdsxxp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlu3HJQACgkQI1/ltBGq
qqdc8RAArZjwPj900jAApBgmTj+Pb1ZbCZgUm3XTNvkegpqkCL+DX8zkPxcw6PEW
m0LZVg9r/z6HSsKfUewD0Bdbz0XWID2Xwclzj5Pd7/shb9V4/JCxQTXKaw2fjFOV
KmRZ/X7SMLefuDEtn9w6+6YgKfieZwdA9J6nFLfOKGcrs4AoOmfOuDoBo0O8h+Un
rruJ+he+hYBDzkOXAJTbAqSY9JG7f2JzqzQKRPZi126cJK2Jdn2wdcPt0QQe6YMG
gAbifrw5Fl+ImEhst+6fqdoXYEwbNqEft/fE40F9OS0JrUL6Sgjfg1eBYgmQPMnm
AjKvb1Nbucl71QSS/gCuJiqaQWx+0SXb4OYWgkkY6YvHydAyBRH6aamu5TG9jXNL
YcMPpK72W8CbvHpOUYc4qYX/YAKFNVwaEQ9YiB0xdEz8xHQ5Xc1ECb/AJJzTZJfm
AinqKZ/2E4auMTA/+FbTCDsZ0HLSxDf8Faf1LnvB2sY2nUgJxYhPMytmojQbmQ0A
kaUW67PX+V0vm0iDNh/sxg2eOK5YgYwGlUZXOoE6+Jqd8jcRXbXd3CtdX6IaxODo
WT6Asay33Cyhmtz/LdeMy3JFLp8JIKv1lmwSAgM9hMvLfh16kex3TUvhnQL7X/dh
wW6rGCpxY6EhhiU3KRuafJifS10NrKL9HuUZ22DuGCMAkb7eSc0=
=SHMr
-----END PGP SIGNATURE-----

--Sig_/G4YD1lCusOclL75HPWdsxxp--

--===============0263141873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0263141873==--
