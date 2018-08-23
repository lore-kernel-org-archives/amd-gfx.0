From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Possible use_mm() mis-uses
Date: Thu, 23 Aug 2018 10:38:17 +0200
Message-ID: <f0475190-140b-1b3d-f010-c4207964a672@redhat.com>
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
 <20180823060726.GY3674@zhen-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355754287=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180823060726.GY3674@zhen-hp.sh.intel.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, KVM list <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, USB list <linux-usb@vger.kernel.org>, amd-gfx@lists.freedesktop.org, intel-gfx <intel-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, intel-gvt-dev@lists.freedesktop.org, Linus Torvalds <torvalds@linux-foundation.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Zhi Wang <zhi.a.wang@intel.com>, Felipe Balbi <balbi@kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1355754287==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yKCsuJ1lCWrGo9UUcx8yBr6f4ZfBG0YQZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yKCsuJ1lCWrGo9UUcx8yBr6f4ZfBG0YQZ
Content-Type: multipart/mixed; boundary="4GGWDuplWg7f0Nu63V3xUzpbuLn8yYMF3";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>, Zhi Wang <zhi.a.wang@intel.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 KVM list <kvm@vger.kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>,
 USB list <linux-usb@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 DRI <dri-devel@lists.freedesktop.org>, intel-gvt-dev@lists.freedesktop.org
Message-ID: <f0475190-140b-1b3d-f010-c4207964a672@redhat.com>
Subject: Re: Possible use_mm() mis-uses
References: <CA+55aFz+Unj0zVNd79vpd41mtee3DV6tp_Ozr7WaZscqCQc9hQ@mail.gmail.com>
 <e50816ec-cf5e-4848-93d0-dacc28f816fc@redhat.com>
 <20180823060726.GY3674@zhen-hp.sh.intel.com>
In-Reply-To: <20180823060726.GY3674@zhen-hp.sh.intel.com>

--4GGWDuplWg7f0Nu63V3xUzpbuLn8yYMF3
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23/08/2018 08:07, Zhenyu Wang wrote:
> On 2018.08.22 20:20:46 +0200, Paolo Bonzini wrote:
>> On 22/08/2018 18:44, Linus Torvalds wrote:
>>> An example of something that *isn't* right, is the i915 kvm interface=
,
>>> which does
>>>
>>>         use_mm(kvm->mm);
>>>
>>> on an mm that was initialized in virt/kvm/kvm_main.c using
>>>
>>>         mmgrab(current->mm);
>>>         kvm->mm =3D current->mm;
>>>
>>> which is *not* right. Using "mmgrab()" does indeed guarantee the
>>> lifetime of the 'struct mm_struct' itself, but it does *not* guarante=
e
>>> the lifetime of the page tables. You need to use "mmget()" and
>>> "mmput()", which get the reference to the actual process address
>>> space!
>>>
>>> Now, it is *possible* that the kvm use is correct too, because kvm
>>> does register a mmu_notifier chain, and in theory you can avoid the
>>> proper refcounting by just making sure the mmu "release" notifier
>>> kills any existing uses, but I don't really see kvm doing that. Kvm
>>> does register a release notifier, but that just flushes the shadow
>>> page tables, it doesn't kill any use_mm() use by some i915 use case.
>>
>> Yes, KVM is correct but the i915 bits are at least fishy.  It's probab=
ly
>> as simple as adding a mmget/mmput pair respectively in kvmgt_guest_ini=
t
>> and kvmgt_guest_exit, or maybe mmget_not_zero.
>>
>=20
> yeah, that's the clear way to fix this imo. We only depend on guest
> life cycle to access guest memory properly. Here's proposed fix, will
> verify and integrate it later.
>=20
> Thanks!
>=20
> From 5e5a8d0409aa150884adf5a4d0b956fd0b9906b3 Mon Sep 17 00:00:00 2001
> From: Zhenyu Wang <zhenyuw@linux.intel.com>
> Date: Thu, 23 Aug 2018 14:08:06 +0800
> Subject: [PATCH] drm/i915/gvt: Fix life cycle reference on KVM mm
>=20
> Handle guest mm access life cycle properly with mmget()/mmput()
> through guest init()/exit(). As noted by Linus, use_mm() depends
> on valid live page table but KVM's mmgrab() doesn't guarantee that.
> As vGPU usage depends on guest VM life cycle, need to make sure to
> use mmget()/mmput() to guarantee VM address access.
>=20
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gv=
t/kvmgt.c
> index 71751be329e3..4a0988747d08 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -32,6 +32,7 @@
>  #include <linux/device.h>
>  #include <linux/mm.h>
>  #include <linux/mmu_context.h>
> +#include <linux/sched/mm.h>
>  #include <linux/types.h>
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
> @@ -1614,9 +1615,16 @@ static int kvmgt_guest_init(struct mdev_device *=
mdev)
>  	if (__kvmgt_vgpu_exist(vgpu, kvm))
>  		return -EEXIST;
> =20
> +	if (!mmget_not_zero(kvm->mm)) {
> +		gvt_vgpu_err("Can't get KVM mm reference\n");
> +		return -EINVAL;
> +	}
> +
>  	info =3D vzalloc(sizeof(struct kvmgt_guest_info));
> -	if (!info)
> +	if (!info) {
> +		mmput(kvm->mm);
>  		return -ENOMEM;
> +	}
> =20
>  	vgpu->handle =3D (unsigned long)info;
>  	info->vgpu =3D vgpu;
> @@ -1647,6 +1655,8 @@ static bool kvmgt_guest_exit(struct kvmgt_guest_i=
nfo *info)
>  	debugfs_remove(info->debugfs_cache_entries);
> =20
>  	kvm_page_track_unregister_notifier(info->kvm, &info->track_node);
> +	if (info->kvm->mm)
> +		mmput(info->kvm->mm);
>  	kvm_put_kvm(info->kvm);
>  	kvmgt_protect_table_destroy(info);
>  	gvt_cache_destroy(info->vgpu);
>=20



--4GGWDuplWg7f0Nu63V3xUzpbuLn8yYMF3--

--yKCsuJ1lCWrGo9UUcx8yBr6f4ZfBG0YQZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlt+cnoACgkQv/vSX3jH
roMVvggArOF9Q9tioaIkwDG2QLOx8TSHUYA9qRCRhklzSJPVaQErEZDhD9J1sONV
YeIoIB/EbC/TcJXO6ckuxzQSVIadBTuTVqbbB87LSTKIvvdSduDSckTBu0UGXw/s
RtruakF9thOpiXatOgxlJzldxZVQT0XXIdtDH8xvVr3iioXjFSbEpkVURC1He3az
EhTMtBJ0sZnGgsdQKweohqvm699prv0/CKWC03AEIRPDTj4GZ1Kdt1ntHIiBaIXV
o8cqsqDdohx1PnQAePE35tVxS6J/PqHUat1t9hmwlKajMLRYCRMR9xpRJzcZd4dk
3L/0j2nXZIlQNo1dh/jecjOvanINHw==
=5cP8
-----END PGP SIGNATURE-----

--yKCsuJ1lCWrGo9UUcx8yBr6f4ZfBG0YQZ--

--===============1355754287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1355754287==--
