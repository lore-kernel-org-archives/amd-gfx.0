From: Joe Barnett <thejoe-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: HMM related? memory leakage
Date: Tue, 1 Oct 2019 08:13:04 -0700
Message-ID: <CAHpbJO-Vmb7d6Dc3hMdquVE0-Ptc-H8vVLauQWQGKBMd3AGotg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1825350231=="
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

--===============1825350231==
Content-Type: multipart/alternative; boundary="000000000000b9d8a30593dacab3"

--000000000000b9d8a30593dacab3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In the development version of ubuntu, using a 5.3 kernel, running the
dolphin emulator appears to leak memory (there may be other apps that
trigger the same issue, but haven't run into them).  The "used" memory
reported by top grows until the app exits, and does not get freed at that
time.  This is on a dell xps 2-in-1 with hybrid intel/amd-vega-m graphics,
and DRI_PRIME=3D1.  Some more details at downstream bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1844962

Running a kernel bisection to find the offending commit shows this:

899fbde1464639e3d12eaffdad8481a59b367fcb is the first bad commit
commit 899fbde1464639e3d12eaffdad8481a59b367fcb
Author: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Date:   Thu Dec 13 15:35:28 2018 -0500

    drm/amdgpu: replace get_user_pages with HMM mirror helpers

    Use HMM helper function hmm_vma_fault() to get physical pages backing
    userptr and start CPU page table update track of those pages. Then use
    hmm_vma_range_done() to check if those pages are updated before
    amdgpu_cs_submit for gfx or before user queues are resumed for kfd.

    If userptr pages are updated, for gfx, amdgpu_cs_ioctl will restart
    from scratch, for kfd, restore worker is rescheduled to retry.

    HMM simplify the CPU page table concurrent update check, so remove
    guptasklock, mmu_invalidations, last_set_pages fields from
    amdgpu_ttm_tt struct.

    HMM does not pin the page (increase page ref count), so remove related
    operations like release_pages(), put_page(), mark_page_dirty().

    Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

:040000 040000 0c9f0e2e82e5e4d2d3a4c0daea22eb911244b771
fdcdc7c80f5383486962edf4561e205b55bd8c21 M drivers


$ git bisect log
# bad: [f74c2bb98776e2de508f4d607cd519873065118e] Linux 5.3-rc8
# good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect start 'v5.3-rc8' 'v5.0'
# good: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag
'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
git bisect good a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
# good: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag
'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
git bisect good a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
# good: [8f6ccf6159aed1f04c6d179f61f6fb2691261e84] Merge tag 'clone3-v5.3'
of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect good 8f6ccf6159aed1f04c6d179f61f6fb2691261e84
# good: [8f6ccf6159aed1f04c6d179f61f6fb2691261e84] Merge tag 'clone3-v5.3'
of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect good 8f6ccf6159aed1f04c6d179f61f6fb2691261e84
# bad: [be8454afc50f43016ca8b6130d9673bdd0bd56ec] Merge tag
'drm-next-2019-07-16' of git://anongit.freedesktop.org/drm/drm
git bisect bad be8454afc50f43016ca8b6130d9673bdd0bd56ec
# bad: [be8454afc50f43016ca8b6130d9673bdd0bd56ec] Merge tag
'drm-next-2019-07-16' of git://anongit.freedesktop.org/drm/drm
git bisect bad be8454afc50f43016ca8b6130d9673bdd0bd56ec
# good: [d72619706abc4aa7e540ea882dae883cee7cc3b3] Merge tag 'tty-5.3-rc1'
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty
git bisect good d72619706abc4aa7e540ea882dae883cee7cc3b3
# bad: [83145f110eb2ada9d54fcbcf416c02de126381c1] drm/amdgpu: don't
invalidate caches in RELEASE_MEM, only do the writeback
git bisect bad 83145f110eb2ada9d54fcbcf416c02de126381c1
# bad: [b239c01727459ba08c44b79e6225d3c58723f282] drm/amdgpu: add mcbp
driver parameter
git bisect bad b239c01727459ba08c44b79e6225d3c58723f282
# good: [e1dc68a4b149d47536cd001d0d0abadbb62d37bd] drm: atmel-hlcdc: avoid
initializing cfg with zero
git bisect good e1dc68a4b149d47536cd001d0d0abadbb62d37bd
# bad: [c53e4db71276bf257b09010935a04bdafddd458e] drm/amdgpu: cancel
late_init_work before gpu reset
git bisect bad c53e4db71276bf257b09010935a04bdafddd458e
# good: [2da4605dce38b84cd2e5b86686f43adae1b2cacb] drm/amd/display: Use DCN
functions instead of DCE
git bisect good 2da4605dce38b84cd2e5b86686f43adae1b2cacb
# bad: [1c1e53f7f2ce191e6787d3d0648fe8ce7088ceaa] drm/amd/doc: Add XGMI
sysfs documentation
git bisect bad 1c1e53f7f2ce191e6787d3d0648fe8ce7088ceaa
# good: [89cd9d23e9a74d94f0db5bbbaf2ef1f6ede36ae5] drm/amdkfd: avoid HMM
change cause circular lock
git bisect good 89cd9d23e9a74d94f0db5bbbaf2ef1f6ede36ae5
# bad: [0803e7a9e850f9d6397c594d6c6deac9b2b6d696] drm/amdkfd: Allocate hiq
and sdma mqd from mqd trunk
git bisect bad 0803e7a9e850f9d6397c594d6c6deac9b2b6d696
# bad: [972fcdb52fe865a2f639e3200b97e648f34a0f41] drm/amdkfd: Introduce
asic-specific mqd_manager_init function
git bisect bad 972fcdb52fe865a2f639e3200b97e648f34a0f41
# bad: [6c55d6e90e68a4789cbd72a0287026d4dfb4a9f9] drm/amdkfd: support
concurrent userptr update for HMM
git bisect bad 6c55d6e90e68a4789cbd72a0287026d4dfb4a9f9
# bad: [ad595b8634f36f04bf69bef4eff854091d94f8b3] drm/amdgpu: fix HMM
config dependency issue
git bisect bad ad595b8634f36f04bf69bef4eff854091d94f8b3
# bad: [899fbde1464639e3d12eaffdad8481a59b367fcb] drm/amdgpu: replace
get_user_pages with HMM mirror helpers
git bisect bad 899fbde1464639e3d12eaffdad8481a59b367fcb
# first bad commit: [899fbde1464639e3d12eaffdad8481a59b367fcb] drm/amdgpu:
replace get_user_pages with HMM mirror helpers

Let me know if I can provide more information.
Thanks,
-Joe

--000000000000b9d8a30593dacab3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>In the development version of ubuntu, using a 5.3 ker=
nel, running the dolphin emulator appears to leak memory (there may be othe=
r apps that trigger the same issue, but haven&#39;t run into them).=C2=A0 T=
he &quot;used&quot; memory reported by top grows until the app exits, and d=
oes not get freed at that time.=C2=A0 This is on a dell xps 2-in-1 with hyb=
rid intel/amd-vega-m graphics, and DRI_PRIME=3D1.=C2=A0 Some more details a=
t downstream bug report: <a href=3D"https://bugs.launchpad.net/ubuntu/+sour=
ce/linux/+bug/1844962">https://bugs.launchpad.net/ubuntu/+source/linux/+bug=
/1844962</a></div><div><br></div><div>Running a kernel bisection to find th=
e offending commit shows this:</div><div><br></div><div>899fbde1464639e3d12=
eaffdad8481a59b367fcb is the first bad commit<br>commit 899fbde1464639e3d12=
eaffdad8481a59b367fcb<br>Author: Philip Yang &lt;<a href=3D"mailto:Philip.Y=
ang-5C7GfCeVMHo@public.gmane.org">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>Date: =C2=A0 Thu Dec 13 15:35:2=
8 2018 -0500<br><br>=C2=A0 =C2=A0 drm/amdgpu: replace get_user_pages with H=
MM mirror helpers<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Use HMM helper functio=
n hmm_vma_fault() to get physical pages backing<br>=C2=A0 =C2=A0 userptr an=
d start CPU page table update track of those pages. Then use<br>=C2=A0 =C2=
=A0 hmm_vma_range_done() to check if those pages are updated before<br>=C2=
=A0 =C2=A0 amdgpu_cs_submit for gfx or before user queues are resumed for k=
fd.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 If userptr pages are updated, for gf=
x, amdgpu_cs_ioctl will restart<br>=C2=A0 =C2=A0 from scratch, for kfd, res=
tore worker is rescheduled to retry.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 HMM=
 simplify the CPU page table concurrent update check, so remove<br>=C2=A0 =
=C2=A0 guptasklock, mmu_invalidations, last_set_pages fields from<br>=C2=A0=
 =C2=A0 amdgpu_ttm_tt struct.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 HMM does n=
ot pin the page (increase page ref count), so remove related<br>=C2=A0 =C2=
=A0 operations like release_pages(), put_page(), mark_page_dirty().<br>=C2=
=A0 =C2=A0 <br>=C2=A0 =C2=A0 Signed-off-by: Philip Yang &lt;<a href=3D"mail=
to:Philip.Yang-5C7GfCeVMHo@public.gmane.org">Philip.Yang-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>=C2=A0 =C2=A0 Review=
ed-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">Felix.K=
uehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>=C2=A0 =C2=A0 Reviewed-by: Christian K=C3=B6nig =
&lt;<a href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">christian.koenig-5C7GfCeVMHo@public.gmane.org</a=
>&gt;<br>=C2=A0 =C2=A0 Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:al=
exander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br><br>:040000 0=
40000 0c9f0e2e82e5e4d2d3a4c0daea22eb911244b771 fdcdc7c80f5383486962edf4561e=
205b55bd8c21 M	drivers<br><br><br>$ git bisect log<br># bad: [f74c2bb98776e=
2de508f4d607cd519873065118e] Linux 5.3-rc8<br># good: [1c163f4c7b3f621efff9=
b28a47abb36f7378d783] Linux 5.0<br>git bisect start &#39;v5.3-rc8&#39; &#39=
;v5.0&#39;<br># good: [a2d635decbfa9c1e4ae15cb05b68b2559f7f827c] Merge tag =
&#39;drm-next-2019-05-09&#39; of git://<a href=3D"http://anongit.freedeskto=
p.org/drm/drm">anongit.freedesktop.org/drm/drm</a><br>git bisect good a2d63=
5decbfa9c1e4ae15cb05b68b2559f7f827c<br># good: [a2d635decbfa9c1e4ae15cb05b6=
8b2559f7f827c] Merge tag &#39;drm-next-2019-05-09&#39; of git://<a href=3D"=
http://anongit.freedesktop.org/drm/drm">anongit.freedesktop.org/drm/drm</a>=
<br>git bisect good a2d635decbfa9c1e4ae15cb05b68b2559f7f827c<br># good: [8f=
6ccf6159aed1f04c6d179f61f6fb2691261e84] Merge tag &#39;clone3-v5.3&#39; of =
git://<a href=3D"http://git.kernel.org/pub/scm/linux/kernel/git/brauner/lin=
ux">git.kernel.org/pub/scm/linux/kernel/git/brauner/linux</a><br>git bisect=
 good 8f6ccf6159aed1f04c6d179f61f6fb2691261e84<br># good: [8f6ccf6159aed1f0=
4c6d179f61f6fb2691261e84] Merge tag &#39;clone3-v5.3&#39; of git://<a href=
=3D"http://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux">git.kerne=
l.org/pub/scm/linux/kernel/git/brauner/linux</a><br>git bisect good 8f6ccf6=
159aed1f04c6d179f61f6fb2691261e84<br># bad: [be8454afc50f43016ca8b6130d9673=
bdd0bd56ec] Merge tag &#39;drm-next-2019-07-16&#39; of git://<a href=3D"htt=
p://anongit.freedesktop.org/drm/drm">anongit.freedesktop.org/drm/drm</a><br=
>git bisect bad be8454afc50f43016ca8b6130d9673bdd0bd56ec<br># bad: [be8454a=
fc50f43016ca8b6130d9673bdd0bd56ec] Merge tag &#39;drm-next-2019-07-16&#39; =
of git://<a href=3D"http://anongit.freedesktop.org/drm/drm">anongit.freedes=
ktop.org/drm/drm</a><br>git bisect bad be8454afc50f43016ca8b6130d9673bdd0bd=
56ec<br># good: [d72619706abc4aa7e540ea882dae883cee7cc3b3] Merge tag &#39;t=
ty-5.3-rc1&#39; of git://<a href=3D"http://git.kernel.org/pub/scm/linux/ker=
nel/git/gregkh/tty">git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty</a><=
br>git bisect good d72619706abc4aa7e540ea882dae883cee7cc3b3<br># bad: [8314=
5f110eb2ada9d54fcbcf416c02de126381c1] drm/amdgpu: don&#39;t invalidate cach=
es in RELEASE_MEM, only do the writeback<br>git bisect bad 83145f110eb2ada9=
d54fcbcf416c02de126381c1<br># bad: [b239c01727459ba08c44b79e6225d3c58723f28=
2] drm/amdgpu: add mcbp driver parameter<br>git bisect bad b239c01727459ba0=
8c44b79e6225d3c58723f282<br># good: [e1dc68a4b149d47536cd001d0d0abadbb62d37=
bd] drm: atmel-hlcdc: avoid initializing cfg with zero<br>git bisect good e=
1dc68a4b149d47536cd001d0d0abadbb62d37bd<br># bad: [c53e4db71276bf257b090109=
35a04bdafddd458e] drm/amdgpu: cancel late_init_work before gpu reset<br>git=
 bisect bad c53e4db71276bf257b09010935a04bdafddd458e<br># good: [2da4605dce=
38b84cd2e5b86686f43adae1b2cacb] drm/amd/display: Use DCN functions instead =
of DCE<br>git bisect good 2da4605dce38b84cd2e5b86686f43adae1b2cacb<br># bad=
: [1c1e53f7f2ce191e6787d3d0648fe8ce7088ceaa] drm/amd/doc: Add XGMI sysfs do=
cumentation<br>git bisect bad 1c1e53f7f2ce191e6787d3d0648fe8ce7088ceaa<br>#=
 good: [89cd9d23e9a74d94f0db5bbbaf2ef1f6ede36ae5] drm/amdkfd: avoid HMM cha=
nge cause circular lock<br>git bisect good 89cd9d23e9a74d94f0db5bbbaf2ef1f6=
ede36ae5<br># bad: [0803e7a9e850f9d6397c594d6c6deac9b2b6d696] drm/amdkfd: A=
llocate hiq and sdma mqd from mqd trunk<br>git bisect bad 0803e7a9e850f9d63=
97c594d6c6deac9b2b6d696<br># bad: [972fcdb52fe865a2f639e3200b97e648f34a0f41=
] drm/amdkfd: Introduce asic-specific mqd_manager_init function<br>git bise=
ct bad 972fcdb52fe865a2f639e3200b97e648f34a0f41<br># bad: [6c55d6e90e68a478=
9cbd72a0287026d4dfb4a9f9] drm/amdkfd: support concurrent userptr update for=
 HMM<br>git bisect bad 6c55d6e90e68a4789cbd72a0287026d4dfb4a9f9<br># bad: [=
ad595b8634f36f04bf69bef4eff854091d94f8b3] drm/amdgpu: fix HMM config depend=
ency issue<br>git bisect bad ad595b8634f36f04bf69bef4eff854091d94f8b3<br># =
bad: [899fbde1464639e3d12eaffdad8481a59b367fcb] drm/amdgpu: replace get_use=
r_pages with HMM mirror helpers<br>git bisect bad 899fbde1464639e3d12eaffda=
d8481a59b367fcb<br># first bad commit: [899fbde1464639e3d12eaffdad8481a59b3=
67fcb] drm/amdgpu: replace get_user_pages with HMM mirror helpers</div><div=
><br></div><div>Let me know if I can provide more information.</div><div>Th=
anks,</div><div>-Joe<br></div></div>

--000000000000b9d8a30593dacab3--

--===============1825350231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1825350231==--
