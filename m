From: Daniel Andersson <engywook-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: BUG: *ERROR* No EDID read
Date: Mon, 2 Jul 2018 21:21:24 +0200
Message-ID: <CAFwJxe7NGsS+3sKXgHRgd9f=2AsMWFP3FVwsO5T+zmN8oYBZ3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0539790689=="
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

--===============0539790689==
Content-Type: multipart/alternative; boundary="0000000000007708470570091a3b"

--0000000000007708470570091a3b
Content-Type: text/plain; charset="UTF-8"

I get:
[drm:dc_link_detect [amdgpu]] *ERROR* No EDID read.
on boot. This started happening on 4.17 and is still an issue on 4.18-rc2.

I have a Vega64 connected on Display Port to a monitor(1440p). The monitor
doesn't have any additional ports so I can't test HDMI.

xrandr:
Screen 0: minimum 320 x 200, current 1024 x 768, maximum 16384 x 16384
DisplayPort-0 connected 1024x768+0+0 (normal left inverted right x axis y
axis) 0mm x 0mm
   1024x768      60.00*
   800x600       60.32    56.25
   848x480       60.00
   640x480       59.94
DisplayPort-1 disconnected (normal left inverted right x axis y axis)
HDMI-A-0 disconnected (normal left inverted right x axis y axis)
HDMI-A-1 disconnected (normal left inverted right x axis y axis)

The 1440p resolution worked on 4.16.

Regards,
Daniel

--0000000000007708470570091a3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I get:</div><div>[drm:dc_link_detect [amdgpu]] *ERROR=
* No EDID read.</div><div>on boot. This started happening on 4.17 and is st=
ill an issue on 4.18-rc2.</div><div><br></div><div>I have a Vega64 connecte=
d on Display Port to a monitor(1440p). The monitor doesn&#39;t have any add=
itional ports so I can&#39;t test HDMI.</div><div><br></div><div>xrandr:</d=
iv><div>Screen 0: minimum 320 x 200, current 1024 x 768, maximum 16384 x 16=
384</div><div>DisplayPort-0 connected 1024x768+0+0 (normal left inverted ri=
ght x axis y axis) 0mm x 0mm</div><div>=C2=A0 =C2=A01024x768=C2=A0 =C2=A0 =
=C2=A0 60.00*=C2=A0</div><div>=C2=A0 =C2=A0800x600=C2=A0 =C2=A0 =C2=A0 =C2=
=A060.32=C2=A0 =C2=A0 56.25=C2=A0=C2=A0</div><div>=C2=A0 =C2=A0848x480=C2=
=A0 =C2=A0 =C2=A0 =C2=A060.00=C2=A0=C2=A0</div><div>=C2=A0 =C2=A0640x480=C2=
=A0 =C2=A0 =C2=A0 =C2=A059.94=C2=A0=C2=A0</div><div>DisplayPort-1 disconnec=
ted (normal left inverted right x axis y axis)</div><div>HDMI-A-0 disconnec=
ted (normal left inverted right x axis y axis)</div><div>HDMI-A-1 disconnec=
ted (normal left inverted right x axis y axis)</div><div><br></div><div>The=
 1440p resolution worked on 4.16.</div><div><br></div><div>Regards,</div><d=
iv>Daniel</div></div>

--0000000000007708470570091a3b--

--===============0539790689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0539790689==--
