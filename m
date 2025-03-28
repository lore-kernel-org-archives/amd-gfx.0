Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CB7C36013
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Mar 2025 15:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2D310E339;
	Sun, 30 Mar 2025 15:24:19 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181C510EAA2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:10:30 +0000 (UTC)
Received: from [192.168.2.19] (51b692a2.dsl.pool.telekom.hu
 [::ffff:81.182.146.162]) (AUTH: CRAM-MD5 soyer@irl.hu, )
 by irl.hu with ESMTPSA
 id 000000000008063C.0000000067E6E614.0006CF10; Fri, 28 Mar 2025 19:10:28 +0100
Message-ID: <5f1cf1544eeeefaa8a3e48478e0c019f1a42304d.camel@irl.hu>
Subject: Re: [PATCH] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
From: Gergo Koteles <soyer@irl.hu>
To: Mario Limonciello <mario.limonciello@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Hung <alex.hung@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>
Date: Fri, 28 Mar 2025 19:10:27 +0100
In-Reply-To: <efae4aa5-29e4-4811-a91a-3f6182ccbe65@amd.com>
References: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
 <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
 <efae4aa5-29e4-4811-a91a-3f6182ccbe65@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 30 Mar 2025 15:24:12 +0000
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

Hi Mario,

Thanks for the suggestions!

On Fri, 2025-03-28 at 08:42 -0500, Mario Limonciello wrote:
> On 3/28/2025 06:12, Rafael J. Wysocki wrote:
> > CC: Hans
> >=20
> > On Fri, Mar 28, 2025 at 3:51=E2=80=AFAM Gergo Koteles <soyer@irl.hu> wr=
ote:
> > >=20
> > > Some Lenovo laptops incorrectly return EDID as
> > > buffer in ACPI package (instead of just a buffer)
> > > when calling _DDC.
> > >=20
> > > Calling _DDC generates this ACPI Warning:
> > > ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
> > > found Package, expected Integer/Buffer (20240827/nspredef-254)
> > >=20
> > > Use the first element of the package to get the EDID buffer.
> > >=20
> > > The DSDT:
> > >=20
> > > Name (AUOP, Package (0x01)
> > > {
> > >          Buffer (0x80)
> > >          {
> > >          ...
> > >          }
> > > })
> > >=20
> > > ...
> > >=20
> > > Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
> > > {
> > >          If ((PAID =3D=3D AUID))
> > >          {
> > >                  Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
> > >          }
> > >          ElseIf ((PAID =3D=3D IVID))
> > >          {
> > >                  Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
> > >          }
> > >          ElseIf ((PAID =3D=3D BOID))
> > >          {
> > >                  Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
> > >          }
> > >          ElseIf ((PAID =3D=3D SAID))
> > >          {
> > >                  Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
> > >          }
> > >=20
> > >          Return (Zero)
> > > }
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if av=
ailable for eDP")
> > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
> > > Signed-off-by: Gergo Koteles <soyer@irl.hu>
>=20
> FWIW the ACPI spec is clear that this /should/ be an ACPI buffer.
>=20
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/outp=
ut-device-specific-methods.html#ddc-return-the-edid-for-this-device
>=20
> That being said this is production firmware and in the wild, I don't=20
> personally see a problem with handling it this way.
>=20
> Some other improvement suggestion though below.
>=20
> > > ---
> > >   drivers/acpi/acpi_video.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > > index efdadc74e3f4..65cf36796506 100644
> > > --- a/drivers/acpi/acpi_video.c
> > > +++ b/drivers/acpi/acpi_video.c
> > > @@ -649,6 +649,9 @@ acpi_video_device_EDID(struct acpi_video_device *=
device, void **edid, int length
> > >=20
> > >          obj =3D buffer.pointer;
> > >=20
> > > +       if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package=
.count =3D=3D 1)
> > > +               obj =3D &obj->package.elements[0];
> > > +
>=20
> As the ACPI spec indicates this should be a buffer, I think it's a good=
=20
> idea to emit a FW_BUG message here so that this can be detected by users=
=20
> and tools like FWTS and the firmware can be improved in the future.
>=20
> Something like this:
>=20
> if (condition) {
> 	pr_info(FW_BUG "EDID was found in ACPI package instead of ACPI buffer");
> 	obj =3D &obj->package.elements[0];
> }
>=20

An ACPI Warning is currently being generated:

ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - found
Package, expected Integer/Buffer (20240827/nspredef-254)

This is also noticed by FWTS in the form of KlogAcpiReturnTypeMismatch
and may be noticed by users as well.

I think it is unnecessary to emit two warnings for the same problem.

However, some comments could make the code clearer. I will add some
comments to V2.


> > >          if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
> > >                  *edid =3D kmemdup(obj->buffer.pointer, obj->buffer.l=
ength, GFP_KERNEL);
> > >                  ret =3D *edid ? obj->buffer.length : -ENOMEM;
> > > @@ -658,7 +661,7 @@ acpi_video_device_EDID(struct acpi_video_device *=
device, void **edid, int length
> > >                  ret =3D -EFAULT;
> > >          }
> > >=20
> > > -       kfree(obj);
> > > +       kfree(buffer.pointer);
>=20
> Any reason for this change?  obj is assigned to buffer.pointer already.
>=20
> >=20

In the case of an ACPI package, obj points to the first element of the
package. The buffer.pointer still points to the original location.

Thanks,
Gergo

