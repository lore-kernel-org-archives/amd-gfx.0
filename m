From: Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Limit gpu max clock for ryzen 2400g
Date: Fri, 22 Mar 2019 14:07:11 +0200
Message-ID: <CAGyaPbD+DD1=jU6OR4Wzv2vzXP_KQUSnHBAttpLk-AN72Mb8ng@mail.gmail.com>
References: <CAGyaPbDqJMTmHyat25b63yu_zEygJwKHrrnrWyH=1vPuxiLwHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0634727052=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAGyaPbDqJMTmHyat25b63yu_zEygJwKHrrnrWyH=1vPuxiLwHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0634727052==
Content-Type: multipart/alternative; boundary="00000000000077f0ec0584adb23b"

--00000000000077f0ec0584adb23b
Content-Type: text/plain; charset="UTF-8"

Found a way how to do it by modifying amdgpu driver. If there's any better
way please let me know..

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
index 5273de3c5b98..70b9fb8d6041 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
@@ -497,6 +497,8 @@ static int smu10_populate_clock_table(struct pp_hwmgr
*hwmgr)
        smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclkFrequency);
        result = smum_get_argument(hwmgr);
//        smu10_data->gfx_max_freq_limit = result / 10 * 1000;
+    smu10_data->gfx_max_freq_limit = 50000;

--
Lauri

On Fri, Mar 22, 2019 at 12:18 PM Lauri Ehrenpreis <laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
wrote:

> Hi!
>
> Is there a way how to limit gpu max clock rate? Currently I can either
> leave the clock to automatic mode or force it to specific level
> via /sys/class/drm/card0/device/pp_dpm_sclk. But ideally I would like the
> clock to be automatically regulated but specify a different upper limit for
> power saving reasons.
>
> --
> Lauri
>

--00000000000077f0ec0584adb23b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Found a way how to do it by modifying amd=
gpu driver. If there&#39;s any better way please let me know..</div><div di=
r=3D"ltr"><br></div><div dir=3D"ltr"><div><div>diff --git a/drivers/gpu/drm=
/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/sm=
u10_hwmgr.c</div><div>index 5273de3c5b98..70b9fb8d6041 100644</div><div>---=
 a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c</div><div>+++ b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c</div><div>@@ -497,6 +497,8 @@ s=
tatic int smu10_populate_clock_table(struct pp_hwmgr *hwmgr)</div><div>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetMaxGfxclk=
Frequency);</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D smum_get_argum=
ent(hwmgr);</div><div>//=C2=A0 =C2=A0 =C2=A0 =C2=A0 smu10_data-&gt;gfx_max_=
freq_limit =3D result / 10 * 1000;</div><div>+=C2=A0 =C2=A0 smu10_data-&gt;=
gfx_max_freq_limit =3D 50000;<br></div></div><div><br></div><div>--</div><d=
iv>Lauri</div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Fri, Mar 22, 2019 at 12:18 PM Lauri Ehrenpreis &lt;<=
a href=3D"mailto:laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">laurioma-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v dir=3D"ltr">Hi!<div><br></div><div>Is there a way how to limit gpu max cl=
ock rate? Currently I can either leave the clock to automatic mode or force=
 it to specific level via=C2=A0/sys/class/drm/card0/device/pp_dpm_sclk. But=
 ideally I would like the clock to be automatically regulated but specify a=
 different upper limit for power saving reasons.</div><div><br></div><div>-=
-</div><div>Lauri</div></div></div>
</blockquote></div>

--00000000000077f0ec0584adb23b--

--===============0634727052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0634727052==--
