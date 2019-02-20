From: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: s2idle not working
Date: Wed, 20 Feb 2019 22:52:54 +0530
Message-ID: <CAHD83Qdhw5Jn1Wh1Q52i5UoGMCmNqnYXV=DqmZWCB28606U1iw@mail.gmail.com>
References: <CAHD83Qc9D5L-B-2R9nYWtckK=WrKkw9Hha5dwDqWt4DCAhAPSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0859658333=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHD83Qc9D5L-B-2R9nYWtckK=WrKkw9Hha5dwDqWt4DCAhAPSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--===============0859658333==
Content-Type: multipart/alternative; boundary="00000000000072c8a70582569c1f"

--00000000000072c8a70582569c1f
Content-Type: text/plain; charset="UTF-8"

Hi

I am facing below issue. Can any one please help me to resolve it.

Regards,
Sk shahul

---------- Forwarded message ---------
From: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, Feb 20, 2019, 3:13 PM
Subject: s2idle not working
To: <shirish.s-5C7GfCeVMHo@public.gmane.org>


Hi Shirish

I am porting Android_N and keenel 4.19.2 to Ryzen platform. Graphic card is
gfx9.
Porting is done successfully. Now i am working on suspend/resume.
Suspend/resume is working fine in deep mode.
But suspend/resume is not working in s2idle (Suspend to idle) mode.

during resume i found error in gpu driver.

[  105.862161] [drm:gfx_v9_0_hw_init [amdgpu]] *ERROR* KCQ enable failed
(scratch(0xC040)=0xCAFEDEAD)
[  105.862187] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume
of IP block <gfx_v9_0> failed -22
[  105.862210] [drm:amdgpu_device_resume [amdgpu]] *ERROR*
amdgpu_device_ip_resume failed (-22).
[  105.862215] dpm_run_callback(): pci_pm_resume+0x0/0xd6 returns -22
[  105.862345] PM: Device 0000:03:00.0 failed to resume async: error -22

same issue is reproduced with ubuntu16.04.

Can you please help me to resolve this issue.
Thanks in Advance,
Regards,
Sk shahul.

--00000000000072c8a70582569c1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hi=C2=A0</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">I am facing below issue. Can any one please help me to resolve it=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=
=3D"auto">Sk shahul<br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr">---------- Forwarded message ---------<br>From: <strong class=3D"g=
mail_sendername" dir=3D"auto">shahul hameed</strong> <span dir=3D"ltr">&lt;=
<a href=3D"mailto:shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" rel=3D"nore=
ferrer">shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span><br>Date: Wed, Feb 20, 201=
9, 3:13 PM<br>Subject: s2idle not working<br>To:  &lt;<a href=3D"mailto:shi=
rish.s-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" rel=3D"noreferrer">shirish.s-5C7GfCeVMHo@public.gmane.org</a>&=
gt;<br></div><br><br><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Shirish</div=
><div><br></div><div><b><span style=3D"font-family:&quot;Courier&quot;;font=
-size:11pt"></span></b></div><div>I am porting Android_N and keenel 4.19.2 =
to Ryzen platform. Graphic card is gfx9.<br></div><div>Porting is done succ=
essfully. Now i am working on suspend/resume.</div><div>Suspend/resume is w=
orking fine in deep mode.</div><div>But suspend/resume is not working in s2=
idle (Suspend to idle) mode.</div><div><br></div><div>during resume i found=
 error in gpu driver.</div><div><br></div><div>[=C2=A0 105.862161] [drm:gfx=
_v9_0_hw_init [amdgpu]] *ERROR* KCQ enable failed (scratch(0xC040)=3D0xCAFE=
DEAD)<br>
[=C2=A0 105.862187] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* r=
esume of IP block &lt;gfx_v9_0&gt; failed -22<br>
[=C2=A0 105.862210] [drm:amdgpu_device_resume [amdgpu]] *ERROR* amdgpu_devi=
ce_ip_resume failed (-22).<br>
[=C2=A0 105.862215] dpm_run_callback(): pci_pm_resume+0x0/0xd6 returns -22<=
br>
[=C2=A0 105.862345] PM: Device 0000:03:00.0 failed to resume async: error -=
22</div><div><br></div><div>same issue is reproduced with ubuntu16.04.<br><=
/div><div><br></div><div>Can you please help me to resolve this issue.<br><=
/div><div>Thanks in Advance,</div><div>Regards,</div><div>Sk shahul.</div><=
/div></div>
</div></div></div>

--00000000000072c8a70582569c1f--

--===============0859658333==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0859658333==--
