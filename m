From: Min Xu <min.xu.public-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)
Date: Mon, 29 Jan 2018 11:56:45 -0800
Message-ID: <CAJKuQOfP56P0Zq5kSmMjHAY74x_yTzcsgPbaRZj1h4K=iPBuwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1892594541=="
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

--===============1892594541==
Content-Type: multipart/alternative; boundary="94eb2c1c0ce86478190563efa5e5"

--94eb2c1c0ce86478190563efa5e5
Content-Type: text/plain; charset="UTF-8"

Dear AMD GFX developers,

I just got a HP Envy x360 laptop and I am trying to run linux on it. I want
to first thank you all for the great work on the amdgpu driver. Without it,
people like me wants to run Linux would be stuck with windows.

I suspect that my issue is a new issue that hasn't been reported before,
therefore, I am writing to you to see if there indeed is a new issue and
whether there is a workaround.

I have compiled the latest kernel from the amd-staging-drm-next branch last
night. I think the kernel "works" with my GPU. The previous two kernels I
tried (4.14 and 4.15 final release) either doesn't support this card or
just simply hang the system most of the time.

The issue I have is that the graphic card seems to never switch to the high
resolution mode of the monitor. The kernel would boot with the default
800x600 VGA graphics and then stuck. The monitor continuous to display the
content written to the 800x600 console (some kernel booting messages) after
amdgpu takes over. I can see from kernel dmesg the amdgpu driver found my
card and initialized it and seems to be all happy about it. Yet, nothing
new is displayed on the monitor. The monitor just stuck at the content of
the 800x600 graphics.

The keyboard works in this situation. Kernel is alive and I can reboot it
by pressing <ctrl>+<alt>+<del> and I saw from the log file the system
restarts just fine.

I have tried different noobs of the amdgpu driver, like
amdgpu.exp_hw_support=1, si_support=0, etc. Nothing seems to work. I just
stuck with not able to switch to 1920x1080.

I suspect that this is related to my firmware version. I confirmed the
latest firmware is installed on my /usr/lib/firmware/ dir. The reason I
suspect that it is a firmware issue is that I got the machine just 2 days
ago and I have updated windows 10 to build 1709, which is very new. I
suspect that windows have updated the GPU's firmware and the linux driver
isn't working with it. If so, is there a way to force a firmware load from
the linux side (i.e. a downgrade).

Other users on the internet has report success with this particular machine
with 4.15 kernel. Given that 4.15 doesn't work for me, the only thing that
I could think of is the firmware version.

Any other ideas?


Thanks a lot,
Min

--94eb2c1c0ce86478190563efa5e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear AMD GFX developers,<div><br></div><div>I just got a H=
P Envy x360 laptop and I am trying to run linux on it. I want to first than=
k you all for the great work on the amdgpu driver. Without it, people like =
me wants to run Linux would be stuck with windows.</div><div><br></div><div=
>I suspect that my issue is a new issue that hasn&#39;t been reported befor=
e, therefore, I am writing to you to see if there indeed is a new issue and=
 whether there is a workaround.</div><div><br></div><div>I have compiled th=
e latest kernel from the amd-staging-drm-next branch last night. I think th=
e kernel &quot;works&quot; with my GPU. The previous two kernels I tried (4=
.14 and 4.15 final release) either doesn&#39;t support this card or just si=
mply hang the system most of the time.</div><div><br></div><div>The issue I=
 have is that the graphic card seems to never switch to the high resolution=
 mode of the monitor. The kernel would boot with the default 800x600 VGA gr=
aphics and then stuck. The monitor continuous to display the content writte=
n to the 800x600 console (some kernel booting messages) after amdgpu takes =
over. I can see from kernel dmesg the amdgpu driver found my card and initi=
alized it and seems to be all happy about it. Yet, nothing new is displayed=
 on the monitor. The monitor just stuck at the content of the 800x600 graph=
ics.</div><div><br></div><div>The keyboard works in this situation. Kernel =
is alive and I can reboot it by pressing &lt;ctrl&gt;+&lt;alt&gt;+&lt;del&g=
t; and I saw from the log file the system restarts just fine.</div><div><br=
></div><div>I have tried different noobs of the amdgpu driver, like amdgpu.=
exp_hw_support=3D1, si_support=3D0, etc. Nothing seems to work. I just stuc=
k with not able to switch to 1920x1080.</div><div><br></div><div>I suspect =
that this is related to my firmware version. I confirmed the latest firmwar=
e is installed on my /usr/lib/firmware/ dir. The reason I suspect that it i=
s a firmware issue is that I got the machine just 2 days ago and I have upd=
ated windows 10 to build 1709, which is very new. I suspect that windows ha=
ve updated the GPU&#39;s firmware and the linux driver isn&#39;t working wi=
th it. If so, is there a way to force a firmware load from the linux side (=
i.e. a downgrade).</div><div><br></div><div>Other users on the internet has=
 report success with this particular machine with 4.15 kernel. Given that 4=
.15 doesn&#39;t work for me, the only thing that I could think of is the fi=
rmware version.</div><div><br></div><div>Any other ideas?</div><div>=C2=A0<=
/div><div><br></div><div>Thanks a lot,</div><div>Min</div><div><br></div></=
div>

--94eb2c1c0ce86478190563efa5e5--

--===============1892594541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1892594541==--
