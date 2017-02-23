From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drm/amdgpu/powerplay: enable LEDs on Fiji boards
Date: Thu, 23 Feb 2017 22:50:07 +0000
Message-ID: <CAPEhTTFFTS-K-FnhvB0ma7FJymfN2EYRw3U-U_-7y8y3L6RS_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0184860524=="
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
To: Alexander Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0184860524==
Content-Type: multipart/alternative; boundary=94eb2c1989eef48f2d05493a6fe3

--94eb2c1989eef48f2d05493a6fe3
Content-Type: text/plain; charset=UTF-8

First, sorry for not replying directly as I should normally, but I'm not on
my usual computer, so I can't. That being said...

I may have my eyes in the same socket right now, but I think
fiji_setup_dpm_led_config() always returns 0.

> + if (mask)
> + smum_send_msg_to_smc_with_parameter(hwmgr->smumgr,
> +    PPSMC_MSG_LedConfig,
> +    mask);
> + return 0;
> +}

Even when "if (mask)" is true, whether
smum_send_msg_to_smc_with_parameter() succeeds or not,
fiji_setup_dpm_led_config() spits a 0 at the end.

Thus,

>* +	result = fiji_setup_dpm_led_config(hwmgr);
*>* +	PP_ASSERT_WITH_CODE(0 == result,
*>* +			    "Failed to setup dpm led config", return result);
*

will always lead to "result" being set to 0... Am I missing something?

Alexandre Demers

--94eb2c1989eef48f2d05493a6fe3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>First, sorry for not replying directly as I should no=
rmally, but I&#39;m not on my usual computer, so I can&#39;t. That being sa=
id...</div><div><br></div>I may have my eyes in the same socket right now, =
but I think fiji_setup_dpm_led_config() always returns 0.<div><br></div><di=
v>&gt; +<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>if=
 (mask)<br></div><div><div>&gt; +<span class=3D"Apple-tab-span" style=3D"wh=
ite-space:pre">		</span>smum_send_msg_to_smc_with_parameter(hwmgr-&gt;smumg=
r,</div><div>&gt; +<span class=3D"Apple-tab-span" style=3D"white-space:pre"=
>						</span> =C2=A0 =C2=A0PPSMC_MSG_LedConfig,</div><div>&gt; +<span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">						</span> =C2=A0 =C2=A0m=
ask);</div><div>&gt; +<span class=3D"Apple-tab-span" style=3D"white-space:p=
re">	</span>return 0;</div><div>&gt; +}</div></div><div><br></div><div>Even=
 when &quot;if (mask)&quot; is true, whether smum_send_msg_to_smc_with_para=
meter() succeeds or not, fiji_setup_dpm_led_config() spits a 0 at the end.<=
br></div><div><br></div><div>Thus,</div><div><pre style=3D"white-space:pre-=
wrap">&gt;<i> +	result =3D fiji_setup_dpm_led_config(hwmgr);
</i>&gt;<i> +	PP_ASSERT_WITH_CODE(0 =3D=3D result,
</i>&gt;<i> +			    &quot;Failed to setup dpm led config&quot;, return resu=
lt);
</i></pre>will always lead to &quot;result&quot; being set to 0... Am I mis=
sing something?</div><div><br></div><div>Alexandre Demers</div></div>

--94eb2c1989eef48f2d05493a6fe3--

--===============0184860524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0184860524==--
