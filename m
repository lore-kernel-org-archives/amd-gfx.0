From: Acewind <acewind-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?Q?build_on_CentOS_7=2E3_hostos=3A_too_few_arguments_to_fun?=
 =?UTF-8?Q?ction_=E2=80=98notify=5Fchange=E2=80=99?=
Date: Mon, 3 Sep 2018 10:42:39 +0800
Message-ID: <CA+B2R57QA1mpmM+Fs0MhZnrNpBNWLP9mdNMnOTDu=qdB+n_p_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1271264861=="
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

--===============1271264861==
Content-Type: multipart/alternative; boundary="00000000000059853b0574ee7f61"

--00000000000059853b0574ee7f61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After download code from
https://github.com/GPUOpen-LibrariesAndSDKs/MxGPU-Virtualization,  I try to
compile MxGPU-Virtualization-master source on my CentOS 7.3 host, but got
an error.  Do I need to change the kernel of hostos?

[root@myhost drv]# uname -r
3.10.0-514.el7.x86_64

[root@myhost drv]# make
make -C /lib/modules/3.10.0-514.el7.x86_64/build
M=3D/home/astute/zwj/MxGPU-Virtualization-master/drv modules
make[1]: Entering directory `/usr/src/kernels/3.10.0-514.el7.x86_64'
  CC [M]  /home/astute/zwj/MxGPU-Virtualization-master/drv/gim_file.o
/home/astute/zwj/MxGPU-Virtualization-master/drv/gim_file.c: In function
=E2=80=98file_truncate=E2=80=99:
/home/astute/zwj/MxGPU-Virtualization-master/drv/gim_file.c:87:2: error:
too few arguments to function =E2=80=98notify_change=E2=80=99
  ret =3D notify_change(file->f_path.dentry, &newattrs);
  ^
In file included from
/home/astute/zwj/MxGPU-Virtualization-master/drv/gim_file.c:23:0:
include/linux/fs.h:2579:12: note: declared here
 extern int notify_change(struct dentry *, struct iattr *, struct inode **)=
;
            ^
make[2]: *** [/home/astute/zwj/MxGPU-Virtualization-master/drv/gim_file.o]
Error 1
make[1]: *** [_module_/home/astute/zwj/MxGPU-Virtualization-master/drv]
Error 2
make[1]: Leaving directory `/usr/src/kernels/3.10.0-514.el7.x86_64'
make: *** [all] Error 2

--00000000000059853b0574ee7f61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div>After download code from=C2=A0<a href=3D"https://github.com/=
GPUOpen-LibrariesAndSDKs/MxGPU-Virtualization">https://github.com/GPUOpen-L=
ibrariesAndSDKs/MxGPU-Virtualization</a>,=C2=A0 I try to compile MxGPU-Virt=
ualization-master source on my CentOS 7.3 host, but got an error.=C2=A0 Do =
I need to change the kernel of hostos?</div><div dir=3D"ltr"><div><br></div=
><div><div>[root@myhost drv]# uname -r</div><div>3.10.0-514.el7.x86_64</div=
></div><div><br></div><div>[root@myhost drv]# make<br></div><div><div>make =
-C /lib/modules/3.10.0-514.el7.x86_64/build M=3D/home/astute/zwj/MxGPU-Virt=
ualization-master/drv modules</div><div>make[1]: Entering directory `/usr/s=
rc/kernels/3.10.0-514.el7.x86_64&#39;</div><div>=C2=A0 CC [M]=C2=A0 /home/a=
stute/zwj/MxGPU-Virtualization-master/drv/gim_file.o</div><div>/home/astute=
/zwj/MxGPU-Virtualization-master/drv/gim_file.c: In function =E2=80=98file_=
truncate=E2=80=99:</div><div>/home/astute/zwj/MxGPU-Virtualization-master/d=
rv/gim_file.c:87:2: error: too few arguments to function =E2=80=98notify_ch=
ange=E2=80=99</div><div>=C2=A0 ret =3D notify_change(file-&gt;f_path.dentry=
, &amp;newattrs);</div><div>=C2=A0 ^</div><div>In file included from /home/=
astute/zwj/MxGPU-Virtualization-master/drv/gim_file.c:23:0:</div><div>inclu=
de/linux/fs.h:2579:12: note: declared here</div><div>=C2=A0extern int notif=
y_change(struct dentry *, struct iattr *, struct inode **);</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^</div><div>make[2]: *** [/home/astu=
te/zwj/MxGPU-Virtualization-master/drv/gim_file.o] Error 1</div><div>make[1=
]: *** [_module_/home/astute/zwj/MxGPU-Virtualization-master/drv] Error 2</=
div><div>make[1]: Leaving directory `/usr/src/kernels/3.10.0-514.el7.x86_64=
&#39;</div><div>make: *** [all] Error 2</div></div><div><br></div></div></d=
iv></div></div></div></div>

--00000000000059853b0574ee7f61--

--===============1271264861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1271264861==--
