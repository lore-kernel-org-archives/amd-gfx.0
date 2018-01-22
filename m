From: Drew Davenport <ddavenport-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: atomic debugfs files not created
Date: Mon, 22 Jan 2018 20:20:06 +0000
Message-ID: <CAMmTTa0C=7amOzgJ=QLheQVB0nX_L123UGBP4yR+AqgRErBk+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1288823501=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--===============1288823501==
Content-Type: multipart/alternative; boundary="94eb2c07d4ea95dd5f05636328ef"

--94eb2c07d4ea95dd5f05636328ef
Content-Type: text/plain; charset="UTF-8"

I was doing some debugging and found that /sys/kernel/debug/dri/0/state
doesn't get created for amdgpu. After a bit of digging around I found that
the DRIVER_ATOMIC feature flag gets set in dm_early_init in amdgpu_dm.c,
which is run after drm_debugfs_init where the atomic debugfs files would
have been created.

I tried moving DRIVER_ATOMIC to the rest of the kms_driver.driver_feature
flags in amdgpu_drv.c, and this allowed the debugfs to get created as
expected. Nothing seemed terribly broken, but I didn't test thoroughly.

Is there any reason not to move DRIVER_ATOMIC to the rest of the feature
flags? Thanks.

--94eb2c07d4ea95dd5f05636328ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I was doing some debugging and found that /sys/kernel/debu=
g/dri/0/state doesn&#39;t get created for amdgpu. After a bit of digging ar=
ound I found that the=C2=A0DRIVER_ATOMIC feature flag gets set in dm_early_=
init in amdgpu_dm.c, which is run after=C2=A0drm_debugfs_init where the ato=
mic debugfs files would have been created.<div><br></div><div>I tried movin=
g DRIVER_ATOMIC to the rest of the kms_driver.driver_feature flags in amdgp=
u_drv.c, and this allowed the debugfs to get created as expected. Nothing s=
eemed terribly broken, but I didn&#39;t test thoroughly.</div><div><br></di=
v><div>Is there any reason not to move DRIVER_ATOMIC to the rest of the fea=
ture flags? Thanks.</div></div>

--94eb2c07d4ea95dd5f05636328ef--

--===============1288823501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1288823501==--
