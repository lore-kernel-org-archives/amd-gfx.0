From: Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Possible use_mm() mis-uses
Date: Thu, 23 Aug 2018 14:07:26 +0800
Message-ID: <20180823060726.GY3674@zhen-hp.sh.intel.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
Reply-To: Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1958943124=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e50816ec-cf5e-4848-93d0-dacc28f816fc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Joonas Lahtinen <joonas.lahtinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, DRI <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, KVM list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, intel-gfx <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, intel-gvt-dev-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Zhi Wang <zhi.a.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>


--===============1958943124==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2wYUONsACSj9OMJp"
Content-Disposition: inline


--2wYUONsACSj9OMJp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.08.22 20:20:46 +0200, Paolo Bonzini wrote:
> On 22/08/2018 18:44, Linus Torvalds wrote:
> > An example of something that *isn't* right, is the i915 kvm interface,
> > which does
> >=20
> >         use_mm(kvm->mm);
> >=20
> > on an mm that was initialized in virt/kvm/kvm_main.c using
> >=20
> >         mmgrab(current->mm);
> >         kvm->mm =3D current->mm;
> >=20
> > which is *not* right. Using "mmgrab()" does indeed guarantee the
> > lifetime of the 'struct mm_struct' itself, but it does *not* guarantee
> > the lifetime of the page tables. You need to use "mmget()" and
> > "mmput()", which get the reference to the actual process address
> > space!
> >=20
> > Now, it is *possible* that the kvm use is correct too, because kvm
> > does register a mmu_notifier chain, and in theory you can avoid the
> > proper refcounting by just making sure the mmu "release" notifier
> > kills any existing uses, but I don't really see kvm doing that. Kvm
> > does register a release notifier, but that just flushes the shadow
> > page tables, it doesn't kill any use_mm() use by some i915 use case.
>=20
> Yes, KVM is correct but the i915 bits are at least fishy.  It's probably
> as simple as adding a mmget/mmput pair respectively in kvmgt_guest_init
> and kvmgt_guest_exit, or maybe mmget_not_zero.
>=20

yeah, that's the clear way to fix this imo. We only depend on guest
life cycle to access guest memory properly. Here's proposed fix, will
verify and integrate it later.

Thanks!

=46rom 5e5a8d0409aa150884adf5a4d0b956fd0b9906b3 Mon Sep 17 00:00:00 2001
=46rom: Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Date: Thu, 23 Aug 2018 14:08:06 +0800
Subject: [PATCH] drm/i915/gvt: Fix life cycle reference on KVM mm

Handle guest mm access life cycle properly with mmget()/mmput()
through guest init()/exit(). As noted by Linus, use_mm() depends
on valid live page table but KVM's mmgrab() doesn't guarantee that.
As vGPU usage depends on guest VM life cycle, need to make sure to
use mmget()/mmput() to guarantee VM address access.

Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Zhi Wang <zhi.a.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Zhenyu Wang <zhenyuw-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kv=
mgt.c
index 71751be329e3..4a0988747d08 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -32,6 +32,7 @@
 #include <linux/device.h>
 #include <linux/mm.h>
 #include <linux/mmu_context.h>
+#include <linux/sched/mm.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/rbtree.h>
@@ -1614,9 +1615,16 @@ static int kvmgt_guest_init(struct mdev_device *mdev)
 	if (__kvmgt_vgpu_exist(vgpu, kvm))
 		return -EEXIST;
=20
+	if (!mmget_not_zero(kvm->mm)) {
+		gvt_vgpu_err("Can't get KVM mm reference\n");
+		return -EINVAL;
+	}
+
 	info =3D vzalloc(sizeof(struct kvmgt_guest_info));
-	if (!info)
+	if (!info) {
+		mmput(kvm->mm);
 		return -ENOMEM;
+	}
=20
 	vgpu->handle =3D (unsigned long)info;
 	info->vgpu =3D vgpu;
@@ -1647,6 +1655,8 @@ static bool kvmgt_guest_exit(struct kvmgt_guest_info =
*info)
 	debugfs_remove(info->debugfs_cache_entries);
=20
 	kvm_page_track_unregister_notifier(info->kvm, &info->track_node);
+	if (info->kvm->mm)
+		mmput(info->kvm->mm);
 	kvm_put_kvm(info->kvm);
 	kvmgt_protect_table_destroy(info);
 	gvt_cache_destroy(info->vgpu);
--=20
2.18.0


--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--2wYUONsACSj9OMJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCW35PHgAKCRCxBBozTXgY
J4LFAJ99b1TIDFon7b9sGFLWJkzv50c5xQCghRlDGlBNwjiFFg8X7BHNED7lJXc=
=6X2z
-----END PGP SIGNATURE-----

--2wYUONsACSj9OMJp--

--===============1958943124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1958943124==--
