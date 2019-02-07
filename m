From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH] drm/sched: Always trace the dependencies we wait on, to fix a race.
Date: Thu, 07 Feb 2019 15:10:34 -0800
Message-ID: <87tvhf2o0l.fsf@anholt.net>
References: <20181207191653.30118-1-eric@anholt.net> <ba4a98f4-062e-0cb4-bd22-a0a191385f82@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ba4a98f4-062e-0cb4-bd22-a0a191385f82@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Koenig, Christian" <Christian.Koenig@amd.com> writes:

> Am 07.12.18 um 20:16 schrieb Eric Anholt:
>> The entity->dependency can go away completely once we've called
>> drm_sched_entity_add_dependency_cb() (if the cb is called before we
>> get around to tracing).  The tracepoint is more useful if we trace
>> every dependency instead of just ones that get callbacks installed,
>> anyway, so just do that.
>>
>> Fixes any easy-to-produce OOPS when tracing the scheduler on V3D with
>> "perf record -a -e gpu_scheduler:.\* glxgears" and DEBUG_SLAB enabled.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Going to pick that up for upstream and will add with a CC: stable.

Looks like this got misplaced.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlxcuuoACgkQtdYpNtH8
nujinQ/+JBLbUT9vbfUdcTVKTfrdcnYbes8xTWxScWMNxRyF/D5P/sVdpAPHssaj
ExnhiCSKwKJEFvVTJ8j9IHoCXcm0WKO7j9BzLq1HMjQhmZHzyZGp+tzny4kxnlud
1oVVuwx2EwckpHA/fP9YZ0m2L25fcgCzx4FMVxoqP5Zs6Tq0AB3KXj+VyE0YseCR
uAk1QKyXHijt0YMvW8q4j5k2UQG7GMbX8Bas43RI7Tn67FLXsJkaTId36BtGAz2+
C5E+/amXYYyFstBTglx5LKH6DX0EZvvET7IEOkJ4ZKH3cYZBCnUXMlqsKj5w4dwc
lrJHFEmJQZ8cxAby+EKBfw9PWugmjVtN25E6/nqEaV4tyqp0+I2jEWj3Ht5TTxCA
JlSiIUCyFhjGx92pAXkiVIGuPiFEg+Cg0tooQTzNkPXC3XXxGdkyW930xmAxOLZw
owGHKRkCdwQQ7sHUA4AvV+2Jcm/fA1Ecd7PS1epYZL6xJ7fDm4gjtQvxi/y1rF6G
sByNPpxwvbRHbpFfg1b+Ehb6eO9Xf0XsjbSILDLdGXI8Pagy2m8LNBFCZICa7GhC
+7DmbaESv2We9ZIg5gA0I7ewiWM5VuwDu6/NitimM7Gga9HYJnfc5a5Mb4EWnTzk
C9JDKdBgrYtKb+zCKyQRFF8AKOme+ldEfPrFxKcQsQXdCCw48n4=
=RJdr
-----END PGP SIGNATURE-----
--=-=-=--
