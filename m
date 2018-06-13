From: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Partially revert commit 2dc80b006
Date: Wed, 13 Jun 2018 13:02:16 -0400
Message-ID: <CABE_ZV1Ga1pV5jiVuZtDoOdp1en5EEo=quYJawDSxhh0QevbmQ@mail.gmail.com>
References: <1528890013-23490-1-git-send-email-Rex.Zhu@amd.com>
 <6526fa0b-474e-102c-6577-5723427970a9@gmail.com>
 <CABE_ZV06N+_JcnqJMU=78DKNwGMwxpEsg7Tr0Xgw0x=-hyc6bw@mail.gmail.com>
 <CY4PR12MB1687387C53D92564048587ECFB7E0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0300539058=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687387C53D92564048587ECFB7E0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0300539058==
Content-Type: multipart/alternative; boundary="000000000000fd572d056e88f10d"

--000000000000fd572d056e88f10d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

thank you. Every effort to make the patches easier to follow is appreciated=
.

Jan

On Wed, Jun 13, 2018 at 10:39 AM, Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org> wrote:

> Hi Jan,
>
>
> Thanks for your suggestion. Obvious the patch title was inappropriate. I
> will update it.
>
> In fact, I originally plan to send this patch internally for discussion.
> So just thought that "Revert xxxxx" can cause the attention.
>
> Best Regards
> Rex
>
>
>
>
> ------------------------------
> *From:* jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org <jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org> on
> behalf of Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
> *Sent:* Wednesday, June 13, 2018 9:30 PM
> *To:* Koenig, Christian
> *Cc:* Zhu, Rex; amd-gfx list
> *Subject:* Re: [PATCH] drm/amdgpu: Partially revert commit 2dc80b006
>
> Hi,
>
> can you please improve the commit message?
> seeing "Revert $HASH" conveys zero information about the code change.
> I'm sorry for bringing this up again, but following AMDGPU/Radeon driver
> development is an exercise in frustration for anyone who is not on AMD's
> payroll.
> git commit logs like:
> "revert XYZ" or "fix bug #123" make it really cumbersome to actually look
> at history and pick interesting/breaking commits.
>
> thanks,
> Jan
>
> On Wed, Jun 13, 2018 at 8:46 AM, Christian K=C3=B6nig <
> ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Am 13.06.2018 um 13:40 schrieb Rex Zhu:
>
> Move the CG enablement out of delay worker thread.
>
> 1. CG/PG enablement are part of gpu hw ip initialize, we should
> wait for them complete. otherwise, there are some potential conflicts,
> for example, Suspend and CG enablement concurrently.
> 2. better run ib test after hw initialize completely. That is to say,
>     ib test should be after CG/PG enablement. otherwise, the test will
>     not cover the cg/pg/poweroff enable case.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
>
> Yeah, that thought came to my mind as well.
>
> Essentially the IB test should simulate a submission from userspace to
> make sure that the stack is working as expected. I think it was just move=
d
> before CG/PG to avoid issues with that, which is actually not very clever=
.
>
> Patch is Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, bu=
t
> there could be some fallout we could need to deal with.
>
> Thanks,
> Christian.
>
>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9647f54..90b78c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1709,10 +1709,6 @@ static int amdgpu_device_ip_late_set_cg_state(stru=
ct
> amdgpu_device *adev)
>         if (amdgpu_emu_mode =3D=3D 1)
>                 return 0;
>   -     r =3D amdgpu_ib_ring_tests(adev);
> -       if (r)
> -               DRM_ERROR("ib ring test failed (%d).\n", r);
> -
>         for (i =3D 0; i < adev->num_ip_blocks; i++) {
>                 if (!adev->ip_blocks[i].status.valid)
>                         continue;
> @@ -1793,6 +1789,9 @@ static int amdgpu_device_ip_late_init(struct
> amdgpu_device *adev)
>                 }
>         }
>   +     amdgpu_device_ip_late_set_cg_state(adev);
> +       amdgpu_device_ip_late_set_pg_state(adev);
> +
>         queue_delayed_work(system_wq, &adev->late_init_work,
>                            msecs_to_jiffies(AMDGPU_RESUME_MS));
>   @@ -1921,8 +1920,11 @@ static void amdgpu_device_ip_late_init_func_hand=
ler(struct
> work_struct *work)
>   {
>         struct amdgpu_device *adev =3D
>                 container_of(work, struct amdgpu_device,
> late_init_work.work);
> -       amdgpu_device_ip_late_set_cg_state(adev);
> -       amdgpu_device_ip_late_set_pg_state(adev);
> +       int r;
> +
> +       r =3D amdgpu_ib_ring_tests(adev);
> +       if (r)
> +               DRM_ERROR("ib ring test failed (%d).\n", r);
>   }
>     /**
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>

--000000000000fd572d056e88f10d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thank you. Every effort to make the patches easier to foll=
ow is appreciated.<div><br></div><div>Jan</div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Jun 13, 2018 at 10:39 AM, Zhu, =
Rex <span dir=3D"ltr">&lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_bla=
nk">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>




<div dir=3D"ltr">
<div id=3D"m_-4588253181105417594divtagdefaultwrapper" style=3D"font-size:1=
2pt;color:#000000;font-family:Calibri,Helvetica,sans-serif" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Jan,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
Thanks for your suggestion. Obvious the patch title was i<span>nappropriate=
. I will update it.</span>
<div><br>
<span></span>
<div>In fact,=C2=A0I originally plan to send this patch internally for disc=
ussion.=C2=A0 So just thought that &quot;Revert xxxxx&quot; can cause the a=
ttention.</div>
<div><br>
</div>
<div>Best Regards</div>
<div>Rex</div>
<div><br>
<span></span>
<div><br>
</div>
<div><br>
<br>
<div style=3D"color:rgb(0,0,0)">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"m_-4588253181105417594divRplyFwdMsg" dir=3D"ltr"><font face=3D"C=
alibri, sans-serif" style=3D"font-size:11pt" color=3D"#000000"><b>From:</b>=
 <a href=3D"mailto:jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org" target=3D"_blank">jv356@s=
carletmail.rutgers.edu</a> &lt;<a href=3D"mailto:jv356-nChP9VK/LToysehGhLVACKSKJzFMqGTb@public.gmane.org=
edu" target=3D"_blank">jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org</a><wbr>&gt; on behalf=
 of Jan Vesely &lt;<a href=3D"mailto:jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org" target=3D"_bla=
nk">jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Wednesday, June 13, 2018 9:30 PM<br>
<b>To:</b> Koenig, Christian<br>
<b>Cc:</b> Zhu, Rex; amd-gfx list<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Partially revert commit 2dc80b006</=
font>
<div>=C2=A0</div>
</div><div><div class=3D"h5">

<div>
<div dir=3D"ltr">Hi,
<div><br>
</div>
<div>can you please improve the commit message?</div>
<div>seeing &quot;Revert $HASH&quot; conveys zero information about the cod=
e change.</div>
<div>I&#39;m sorry for bringing this up again, but following AMDGPU/Radeon =
driver development is an exercise in frustration for anyone who is not on A=
MD&#39;s payroll.</div>
<div>git commit logs like:</div>
<div>&quot;revert XYZ&quot; or &quot;fix bug #123&quot; make it really cumb=
ersome to actually look at history and pick interesting/breaking commits.</=
div>
<div><br>
</div>
<div>thanks,</div>
<div>Jan</div>
</div>
<div class=3D"m_-4588253181105417594x_gmail_extra"><br>
<div class=3D"m_-4588253181105417594x_gmail_quote">On Wed, Jun 13, 2018 at =
8:46 AM, Christian K=C3=B6nig <span dir=3D"ltr">
&lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" id=3D"m_-4588253181=
105417594LPlnk23845" class=3D"m_-4588253181105417594OWAAutoLink" target=3D"=
_blank">ckoenig.leichtzumerken@gmail.<wbr>com</a>&gt;</span> wrote:<br>
<blockquote class=3D"m_-4588253181105417594x_gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span>Am 13.06.2018 um 13:40 schrieb Rex Zhu:<br>
<blockquote class=3D"m_-4588253181105417594x_gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Move the CG enablement out of delay worker thread.<br>
<br>
1. CG/PG enablement are part of gpu hw ip initialize, we should<br>
wait for them complete. otherwise, there are some potential conflicts,<br>
for example, Suspend and CG enablement concurrently.<br>
2. better run ib test after hw initialize completely. That is to say,<br>
=C2=A0 =C2=A0 ib test should be after CG/PG enablement. otherwise, the test=
 will<br>
=C2=A0 =C2=A0 not cover the cg/pg/poweroff enable case.<br>
<br>
Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" id=3D"m_-4588=
253181105417594LPlnk396741" class=3D"m_-4588253181105417594OWAAutoLink" tar=
get=3D"_blank">Rex.Zhu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
</blockquote>
<br>
</span>Yeah, that thought came to my mind as well.<br>
<br>
Essentially the IB test should simulate a submission from userspace to make=
 sure that the stack is working as expected. I think it was just moved befo=
re CG/PG to avoid issues with that, which is actually not very clever.<br>
<br>
Patch is Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.=
koenig-5C7GfCeVMHo@public.gmane.org" id=3D"m_-4588253181105417594LPlnk442308" class=3D"m_-458825=
3181105417594OWAAutoLink" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt=
;, but there could be some fallout we could need to deal with.<br>
<br>
Thanks,<br>
Christian.
<div class=3D"m_-4588253181105417594x_HOEnZb">
<div class=3D"m_-4588253181105417594x_h5"><br>
<br>
<blockquote class=3D"m_-4588253181105417594x_gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
=C2=A0 drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_device.c | 14 ++++++++------<=
br>
=C2=A0 1 file changed, 8 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
index 9647f54..90b78c7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
@@ -1709,10 +1709,6 @@ static int amdgpu_device_ip_late_set_cg_s<wbr>tate(s=
truct amdgpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (amdgpu_emu_mode =3D=3D 1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ib_ring_tests(adev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;ib =
ring test failed (%d).\n&quot;, r);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt; adev-&gt;num_ip_blocks; i+=
+) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!adev-&gt;ip_bl=
ocks[i].<a href=3D"http://status.va" id=3D"m_-4588253181105417594LPlnk71040=
4" class=3D"m_-4588253181105417594OWAAutoLink" target=3D"_blank">status.va<=
/a><wbr>lid)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;<br>
@@ -1793,6 +1789,9 @@ static int amdgpu_device_ip_late_init(str<wbr>uct amd=
gpu_device *adev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0amdgpu_device_ip_late_set_cg_<wbr>state(adev);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_ip_late_set_pg_<wbr>state(adev);<=
br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_delayed_work(system_wq, &amp;adev-&gt;lat=
e_init_work,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0msecs_to_jiffies(AMDGPU_RESUM<wbr>E_MS));<br>
=C2=A0 @@ -1921,8 +1920,11 @@ static void amdgpu_device_ip_late_init_fun<wb=
r>c_handler(struct work_struct *work)<br>
=C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct amdgpu_device *adev =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 container_of(work, =
struct amdgpu_device, <a href=3D"http://late_init_work.work" rel=3D"norefer=
rer" id=3D"m_-4588253181105417594LPlnk420709" class=3D"m_-45882531811054175=
94OWAAutoLink" target=3D"_blank">
late_init_work.work</a>);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_ip_late_set_cg_<wbr>state(adev);<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_device_ip_late_set_pg_<wbr>state(adev);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int r;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_ib_ring_tests(adev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (r)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_ERROR(&quot;ib =
ring test failed (%d).\n&quot;, r);<br>
=C2=A0 }<br>
=C2=A0 =C2=A0 /**<br>
</blockquote>
<br>
</div>
</div>
<div class=3D"m_-4588253181105417594x_HOEnZb">
<div class=3D"m_-4588253181105417594x_h5">______________________________<wb=
r>_________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" id=3D"m_-45882531811054175=
94LPlnk537513" class=3D"m_-4588253181105417594OWAAutoLink" target=3D"_blank=
">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" id=3D"m_-4588253181105417594LPlnk798304" class=3D"m_-45882531811=
05417594OWAAutoLink" target=3D"_blank">https://lists.freedesktop.org/<wbr>m=
ailman/listinfo/amd-gfx</a><br>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div></div></div>
</div>
</div>
</div>
</div>
</div>

</blockquote></div><br></div>

--000000000000fd572d056e88f10d--

--===============0300539058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0300539058==--
