From: "Francis, David" <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/display: Don't replace the dc_state for fast
 updates
Date: Thu, 1 Aug 2019 19:25:30 +0000
Message-ID: <BN8PR12MB3217433D27E25905A31FC8EFEFDE0@BN8PR12MB3217.namprd12.prod.outlook.com>
References: <20190731162604.28509-1-nicholas.kazlauskas@amd.com>
 <20190731162604.28509-3-nicholas.kazlauskas@amd.com>,
 <CADnq5_O+v6GC+DYOXkPRwT6S9tjiRs9uNEntS4wdCZVTUpmdAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0975900379=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_O+v6GC+DYOXkPRwT6S9tjiRs9uNEntS4wdCZVTUpmdAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-CA
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0975900379==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB3217433D27E25905A31FC8EFEFDE0BN8PR12MB3217namp_"

--_000_BN8PR12MB3217433D27E25905A31FC8EFEFDE0BN8PR12MB3217namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: August 1, 2019 2:58:56 PM
To: Kazlauskas, Nicholas <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Li, Sun peng (Leo) <Sunpe=
ng.Li-5C7GfCeVMHo@public.gmane.org>; Francis, David <David.Francis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/display: Don't replace the dc_state for fa=
st updates

On Wed, Jul 31, 2019 at 12:26 PM Nicholas Kazlauskas
<nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org> wrote:
>
> [Why]
> DRM private objects have no hw_done/flip_done fencing mechanism on their
> own and cannot be used to sequence commits accordingly.
>
> When issuing commits that don't touch the same set of hardware resources
> like page-flips on different CRTCs we can run into the issue below
> because of this:
>
> 1. Client requests non-blocking Commit #1, has a new dc_state #1,
> state is swapped, commit tail is deferred to work queue
>
> 2. Client requests non-blocking Commit #2, has a new dc_state #2,
> state is swapped, commit tail is deferred to work queue
>
> 3. Commit #2 work starts, commit tail finishes,
> atomic state is cleared, dc_state #1 is freed
>
> 4. Commit #1 work starts,
> commit tail encounters null pointer deref on dc_state #1
>
> In order to change the DC state as in the private object we need to
> ensure that we wait for all outstanding commits to finish and that
> any other pending commits must wait for the current one to finish as
> well.
>
> We do this for MEDIUM and FULL updates. But not for FAST updates, nor
> would we want to since it would cause stuttering from the delays.
>
> FAST updates that go through dm_determine_update_type_for_commit always
> create a new dc_state and lock the DRM private object if there are
> any changed planes.
>
> We need the old state to validate, but we don't actually need the new
> state here.
>
> [How]
> If the commit isn't a full update then the use after free can be
> resolved by simply discarding the new state entirely and retaining
> the existing one instead.
>
> With this change the sequence above can be reexamined. Commit #2 will
> still free Commit #1's reference, but before this happens we actually
> added an additional reference as part of Commit #2.
>
> If an update comes in during this that needs to change the dc_state
> it will need to wait on Commit #1 and Commit #2 to finish. Then it'll
> swap the state, finish the work in commit tail and drop the last
> reference on Commit #2's dc_state.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D204181
> Cc: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
> Cc: David Francis <david.francis-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4c90662e9fa2..fe5291b16193 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7288,6 +7288,29 @@ static int amdgpu_dm_atomic_check(struct drm_devic=
e *dev,
>                         ret =3D -EINVAL;
>                         goto fail;
>                 }
> +       } else {
> +               /*
> +                * The commit is a fast update. Fast updates shouldn't ch=
ange
> +                * the DC context, affect global validation, and can have=
 their
> +                * commit work done in parallel with other commits not to=
uching
> +                * the same resource. If we have a new DC context as part=
 of
> +                * the DM atomic state from validation we need to free it=
 and
> +                * retain the existing one instead.
> +                */
> +               struct dm_atomic_state *new_dm_state, *old_dm_state;
> +
> +               new_dm_state =3D dm_atomic_get_new_state(state);
> +               old_dm_state =3D dm_atomic_get_old_state(state);
> +
> +               if (new_dm_state && old_dm_state) {
> +                       if (new_dm_state->context)
> +                               dc_release_state(new_dm_state->context);
> +
> +                       new_dm_state->context =3D old_dm_state->context;
> +
> +                       if (old_dm_state->context)
> +                               dc_retain_state(old_dm_state->context);
> +               }
>         }
>
>         /* Must be success */
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN8PR12MB3217433D27E25905A31FC8EFEFDE0BN8PR12MB3217namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<span>Reviewed-by: David Francis &lt;david.francis-5C7GfCeVMHo@public.gmane.org&gt;</span>
<p style=3D"margin-top:0;margin-bottom:0"></p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> August 1, 2019 2:58:56 PM<br>
<b>To:</b> Kazlauskas, Nicholas &lt;Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; Li, Sun peng=
 (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; Francis, David &lt;David.Francis-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amd/display: Don't replace the dc_state=
 for fast updates</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Wed, Jul 31, 2019 at 12:26 PM Nicholas Kazlausk=
as<br>
&lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; [Why]<br>
&gt; DRM private objects have no hw_done/flip_done fencing mechanism on the=
ir<br>
&gt; own and cannot be used to sequence commits accordingly.<br>
&gt;<br>
&gt; When issuing commits that don't touch the same set of hardware resourc=
es<br>
&gt; like page-flips on different CRTCs we can run into the issue below<br>
&gt; because of this:<br>
&gt;<br>
&gt; 1. Client requests non-blocking Commit #1, has a new dc_state #1,<br>
&gt; state is swapped, commit tail is deferred to work queue<br>
&gt;<br>
&gt; 2. Client requests non-blocking Commit #2, has a new dc_state #2,<br>
&gt; state is swapped, commit tail is deferred to work queue<br>
&gt;<br>
&gt; 3. Commit #2 work starts, commit tail finishes,<br>
&gt; atomic state is cleared, dc_state #1 is freed<br>
&gt;<br>
&gt; 4. Commit #1 work starts,<br>
&gt; commit tail encounters null pointer deref on dc_state #1<br>
&gt;<br>
&gt; In order to change the DC state as in the private object we need to<br=
>
&gt; ensure that we wait for all outstanding commits to finish and that<br>
&gt; any other pending commits must wait for the current one to finish as<b=
r>
&gt; well.<br>
&gt;<br>
&gt; We do this for MEDIUM and FULL updates. But not for FAST updates, nor<=
br>
&gt; would we want to since it would cause stuttering from the delays.<br>
&gt;<br>
&gt; FAST updates that go through dm_determine_update_type_for_commit alway=
s<br>
&gt; create a new dc_state and lock the DRM private object if there are<br>
&gt; any changed planes.<br>
&gt;<br>
&gt; We need the old state to validate, but we don't actually need the new<=
br>
&gt; state here.<br>
&gt;<br>
&gt; [How]<br>
&gt; If the commit isn't a full update then the use after free can be<br>
&gt; resolved by simply discarding the new state entirely and retaining<br>
&gt; the existing one instead.<br>
&gt;<br>
&gt; With this change the sequence above can be reexamined. Commit #2 will<=
br>
&gt; still free Commit #1's reference, but before this happens we actually<=
br>
&gt; added an additional reference as part of Commit #2.<br>
&gt;<br>
&gt; If an update comes in during this that needs to change the dc_state<br=
>
&gt; it will need to wait on Commit #1 and Commit #2 to finish. Then it'll<=
br>
&gt; swap the state, finish the work in commit tail and drop the last<br>
&gt; reference on Commit #2's dc_state.<br>
&gt;<br>
&gt; Bugzilla: <a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D204=
181">https://bugzilla.kernel.org/show_bug.cgi?id=3D204181</a><br>
&gt; Cc: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Cc: David Francis &lt;david.francis-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
<br>
Series is:<br>
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;<br>
&gt;&nbsp; 1 file changed, 23 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 4c90662e9fa2..fe5291b16193 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br=
>
&gt; @@ -7288,6 &#43;7288,29 @@ static int amdgpu_dm_atomic_check(struct dr=
m_device *dev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
et =3D -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g=
oto fail;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * The commit is a fast update. Fast updates shoul=
dn't change<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * the DC context, affect global validation, and c=
an have their<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * commit work done in parallel with other commits=
 not touching<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * the same resource. If we have a new DC context =
as part of<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * the DM atomic state from validation we need to =
free it and<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * retain the existing one instead.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dm_atomic_state *new_dm_state, *old_dm_state;<br=
>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; new_dm_state =3D dm_atomic_get_new_state(state);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; old_dm_state =3D dm_atomic_get_old_state(state);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (new_dm_state &amp;&amp; old_dm_state) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (new=
_dm_state-&gt;context)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_release_state(new_dm_state-&gt;=
context);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new_dm_=
state-&gt;context =3D old_dm_state-&gt;context;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (old=
_dm_state-&gt;context)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dc_retain_state(old_dm_state-&gt;c=
ontext);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Must be success */<=
br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB3217433D27E25905A31FC8EFEFDE0BN8PR12MB3217namp_--

--===============0975900379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0975900379==--
