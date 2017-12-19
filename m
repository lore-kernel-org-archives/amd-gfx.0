From: =?ISO-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: Topaz mistakenly reported as vf
Date: Tue, 19 Dec 2017 09:50:44 +0200
Message-ID: <2232774.d6XA96ciAX@localhost>
References: <2405754.qoBN6c2ta5@bee> <12522973.cAA0sX3idh@localhost>
 <BY2PR1201MB0935ECB9DDC4DE571DF65433EB0F0@BY2PR1201MB0935.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3268520.Pp8NGv4lD9"
Content-Transfer-Encoding: 7Bit
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB0935ECB9DDC4DE571DF65433EB0F0-O28G1zQ8oGkaqtME6NEo1mrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.

--nextPart3268520.Pp8NGv4lD9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Tuesday, 19 December 2017 09:44:00 EET Yu, Xiangliang wrote:
> We can add ASIC check in vi_detect_hw_virtualization function to avoid to
> entry error path. I'll submit patch later.
>=20
> Thanks!

	Awesome, thanks!

	Also, I noticed the following patch in case you can consider it for=20
upstream.

	Best regards.

	Jos=E9.
--nextPart3268520.Pp8NGv4lD9
Content-Disposition: attachment; filename="0001-Release-the-mutex-hold-before-backtracing-for-not-su.patch"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset="UTF-8"; name="0001-Release-the-mutex-hold-before-backtracing-for-not-su.patch"

=46rom dc691db50dbfb213aaee2b76574a5e8de2d7bca0 Mon Sep 17 00:00:00 2001
=46rom: =3D?UTF-8?q?Jos=3DC3=3DA9=3D20Pekkarinen?=3D <koalinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Tue, 19 Dec 2017 09:39:50 +0200
Subject: [PATCH] Release the mutex hold before backtracing for not supported
 mxgpu.
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Jos=C3=A9 Pekkarinen <koalinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
=2D--
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_vi.c
index c25a831f94ec..cac1d8b003e6 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -307,6 +307,7 @@ void xgpu_vi_init_golden_registers(struct amdgpu_device=
 *adev)
 						 xgpu_tonga_golden_common_all));
 		break;
 	default:
+		mutex_unlock(&adev->grbm_idx_mutex);
 		BUG_ON("Doesn't support chip type.\n");
 		break;
 	}
=2D-=20
2.13.6


--nextPart3268520.Pp8NGv4lD9
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--nextPart3268520.Pp8NGv4lD9--
