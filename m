From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/powerplay: enable LEDs on Fiji boards
Date: Fri, 24 Feb 2017 00:20:01 -0500
Message-ID: <CAPEhTTFreTa-YMQf8-fRNR5SKyTsXn2uZiSDHQvjNDC7u=wsrg@mail.gmail.com>
References: <CAPEhTTFFTS-K-FnhvB0ma7FJymfN2EYRw3U-U_-7y8y3L6RS_A@mail.gmail.com>
 <CADnq5_Np1DWnzvSaChca4rsQzX02_=HYcLTwuFVaLm51qageRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1391120348=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Np1DWnzvSaChca4rsQzX02_=HYcLTwuFVaLm51qageRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1391120348==
Content-Type: multipart/alternative; boundary=94eb2c1989eebabda305493fe187

--94eb2c1989eebabda305493fe187
Content-Type: text/plain; charset=UTF-8

On Thursday, February 23, 2017, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On Thu, Feb 23, 2017 at 5:50 PM, Alexandre Demers
> <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <javascript:;>> wrote:
> > First, sorry for not replying directly as I should normally, but I'm not
> on
> > my usual computer, so I can't. That being said...
> >
> > I may have my eyes in the same socket right now, but I think
> > fiji_setup_dpm_led_config() always returns 0.
> >
> >> + if (mask)
> >> + smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
> >> +    PPSMC_MSG_LedConfig,
> >> +    mask);
> >> + return 0;
> >> +}
> >
> > Even when "if (mask)" is true, whether smum_send_msg_to_smc_with_
> parameter()
> > succeeds or not, fiji_setup_dpm_led_config() spits a 0 at the end.
> >
> > Thus,
> >
> >> + result = fiji_setup_dpm_led_config(hwmgr);
> >> + PP_ASSERT_WITH_CODE(0 == result,
> >> +    "Failed to setup dpm led config", return result);
> >
> > will always lead to "result" being set to 0... Am I missing something?
> >
>
> Yes, that function can't fail.  I suppose we could just make it a void
> function, but I was following the same pattern of all the other
> functions in that file.
>
> Alex
>

I see. Well, if there is no forseseeable change that would justify to
return a different value, I would be tempted to go with the void. But
either way, I'll live with it.

Alexandre Demers

--94eb2c1989eebabda305493fe187
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thursday, February 23, 2017, Alex Deucher &lt;<a href=3D"mailto:alexdeuc=
her-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">On Thu, Feb 23, 2017 at 5:50 PM, Alexandre Demers<br>
&lt;<a href=3D"javascript:;" onclick=3D"_e(event, &#39;cvml&#39;, &#39;alex=
andre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&#39;)">alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:=
<br>
&gt; First, sorry for not replying directly as I should normally, but I&#39=
;m not on<br>
&gt; my usual computer, so I can&#39;t. That being said...<br>
&gt;<br>
&gt; I may have my eyes in the same socket right now, but I think<br>
&gt; fiji_setup_dpm_led_config() always returns 0.<br>
&gt;<br>
&gt;&gt; + if (mask)<br>
&gt;&gt; + smum_send_msg_to_smc_with_<wbr>parameter(hwmgr-&gt;smumgr,<br>
&gt;&gt; +=C2=A0 =C2=A0 PPSMC_MSG_LedConfig,<br>
&gt;&gt; +=C2=A0 =C2=A0 mask);<br>
&gt;&gt; + return 0;<br>
&gt;&gt; +}<br>
&gt;<br>
&gt; Even when &quot;if (mask)&quot; is true, whether smum_send_msg_to_smc_=
with_<wbr>parameter()<br>
&gt; succeeds or not, fiji_setup_dpm_led_config() spits a 0 at the end.<br>
&gt;<br>
&gt; Thus,<br>
&gt;<br>
&gt;&gt; + result =3D fiji_setup_dpm_led_config(<wbr>hwmgr);<br>
&gt;&gt; + PP_ASSERT_WITH_CODE(0 =3D=3D result,<br>
&gt;&gt; +=C2=A0 =C2=A0 &quot;Failed to setup dpm led config&quot;, return =
result);<br>
&gt;<br>
&gt; will always lead to &quot;result&quot; being set to 0... Am I missing =
something?<br>
&gt;<br>
<br>
Yes, that function can&#39;t fail.=C2=A0 I suppose we could just make it a =
void<br>
function, but I was following the same pattern of all the other<br>
functions in that file.<br>
<br>
Alex<br>
</blockquote><div><br></div><div>I see. Well, if there is no forseseeable c=
hange that would justify to return a different value, I would be tempted to=
 go with the void. But either way, I&#39;ll live with it.</div><div><br></d=
iv><div>Alexandre Demers</div>

--94eb2c1989eebabda305493fe187--

--===============1391120348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1391120348==--
