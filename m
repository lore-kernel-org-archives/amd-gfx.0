From: Min Xu <min.xu.public-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)
Date: Mon, 29 Jan 2018 12:02:41 -0800
Message-ID: <CAJKuQOcSdHQMWO-v4M84=YrxHnu5GudNtUaN=-JhjAnsQsuVNA@mail.gmail.com>
References: <CAJKuQOfP56P0Zq5kSmMjHAY74x_yTzcsgPbaRZj1h4K=iPBuwQ@mail.gmail.com>
 <BN6PR12MB134817C964BC95F8D2B05CEAE8E50@BN6PR12MB1348.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0307129621=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB134817C964BC95F8D2B05CEAE8E50-/b2+HYfkarQX0pEhCR5T8QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0307129621==
Content-Type: multipart/alternative; boundary="94eb2c1cb0de8f833e0563efba7c"

--94eb2c1cb0de8f833e0563efba7c
Content-Type: text/plain; charset="UTF-8"

I am running archlinux, the firmware version is very new:

linux-firmware-20180119.2a713be-1


On Mon, Jan 29, 2018 at 12:01 PM, Bridgman, John <John.Bridgman-5C7GfCeVMHo@public.gmane.org>
wrote:

> Microcode for the GPU hardware blocks is not permanently updated in the
> chip, but rather is loaded at power-up. Usually the files will be
> distributed via a package with a name like linux-firmware.
>
>
>
> I didn't see a mention of which distro/version you are using but along
> with new kernel you will need a relatively new version of linux-firmware.
>
>
>
> *From:* amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] *On Behalf
> Of *Min Xu
> *Sent:* Monday, January 29, 2018 2:57 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)
>
>
>
> Dear AMD GFX developers,
>
>
>
> I just got a HP Envy x360 laptop and I am trying to run linux on it. I
> want to first thank you all for the great work on the amdgpu driver.
> Without it, people like me wants to run Linux would be stuck with windows.
>
>
>
> I suspect that my issue is a new issue that hasn't been reported before,
> therefore, I am writing to you to see if there indeed is a new issue and
> whether there is a workaround.
>
>
>
> I have compiled the latest kernel from the amd-staging-drm-next branch
> last night. I think the kernel "works" with my GPU. The previous two
> kernels I tried (4.14 and 4.15 final release) either doesn't support this
> card or just simply hang the system most of the time.
>
>
>
> The issue I have is that the graphic card seems to never switch to the
> high resolution mode of the monitor. The kernel would boot with the default
> 800x600 VGA graphics and then stuck. The monitor continuous to display the
> content written to the 800x600 console (some kernel booting messages) after
> amdgpu takes over. I can see from kernel dmesg the amdgpu driver found my
> card and initialized it and seems to be all happy about it. Yet, nothing
> new is displayed on the monitor. The monitor just stuck at the content of
> the 800x600 graphics.
>
>
>
> The keyboard works in this situation. Kernel is alive and I can reboot it
> by pressing <ctrl>+<alt>+<del> and I saw from the log file the system
> restarts just fine.
>
>
>
> I have tried different noobs of the amdgpu driver, like
> amdgpu.exp_hw_support=1, si_support=0, etc. Nothing seems to work. I just
> stuck with not able to switch to 1920x1080.
>
>
>
> I suspect that this is related to my firmware version. I confirmed the
> latest firmware is installed on my /usr/lib/firmware/ dir. The reason I
> suspect that it is a firmware issue is that I got the machine just 2 days
> ago and I have updated windows 10 to build 1709, which is very new. I
> suspect that windows have updated the GPU's firmware and the linux driver
> isn't working with it. If so, is there a way to force a firmware load from
> the linux side (i.e. a downgrade).
>
>
>
> Other users on the internet has report success with this particular
> machine with 4.15 kernel. Given that 4.15 doesn't work for me, the only
> thing that I could think of is the firmware version.
>
>
>
> Any other ideas?
>
>
>
>
>
> Thanks a lot,
>
> Min
>
>
>

--94eb2c1cb0de8f833e0563efba7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am running archlinux, the firmware version is very new:<=
div><br></div><div>linux-firmware-20180119.2a713be-1<br></div><div><br></di=
v></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, J=
an 29, 2018 at 12:01 PM, Bridgman, John <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:John.Bridgman-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">John.Bridgman-5C7GfCeVMHo@public.gmane.org</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"m_-6995857010834165525WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">Microcode for the GPU har=
dware blocks is not permanently updated in the chip, but rather is loaded a=
t power-up. Usually the files will be distributed via a
 package with a name like linux-firmware. <u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d">I didn&#39;t see a mentio=
n of which distro/version you are using but along with new kernel you will =
need a relatively new version of linux-firmware.<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,&quot;sans-serif&quot;;color:#1f497d"><u></u>=C2=A0<u></u></spa=
n></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #b5c4df 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;"> amd-gfx =
[mailto:<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"=
_blank">amd-gfx-bounces@lists.<wbr>freedesktop.org</a>]
<b>On Behalf Of </b>Min Xu<br>
<b>Sent:</b> Monday, January 29, 2018 2:57 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blan=
k">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Strange issue on Vega 8 Mobile (HP Envy x360 Laptop)<u></u>=
<u></u></span></p>
</div>
</div><div><div class=3D"h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Dear AMD GFX developers,<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I just got a HP Envy x360 laptop and I am trying to =
run linux on it. I want to first thank you all for the great work on the am=
dgpu driver. Without it, people like me wants to run Linux would be stuck w=
ith windows.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I suspect that my issue is a new issue that hasn&#39=
;t been reported before, therefore, I am writing to you to see if there ind=
eed is a new issue and whether there is a workaround.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I have compiled the latest kernel from the amd-stagi=
ng-drm-next branch last night. I think the kernel &quot;works&quot; with my=
 GPU. The previous two kernels I tried (4.14 and 4.15 final release) either=
 doesn&#39;t support this card or just simply hang
 the system most of the time.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">The issue I have is that the graphic card seems to n=
ever switch to the high resolution mode of the monitor. The kernel would bo=
ot with the default 800x600 VGA graphics and then stuck. The monitor contin=
uous to display the content written
 to the 800x600 console (some kernel booting messages) after amdgpu takes o=
ver. I can see from kernel dmesg the amdgpu driver found my card and initia=
lized it and seems to be all happy about it. Yet, nothing new is displayed =
on the monitor. The monitor just
 stuck at the content of the 800x600 graphics.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">The keyboard works in this situation. Kernel is aliv=
e and I can reboot it by pressing &lt;ctrl&gt;+&lt;alt&gt;+&lt;del&gt; and =
I saw from the log file the system restarts just fine.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I have tried different noobs of the amdgpu driver, l=
ike amdgpu.exp_hw_support=3D1, si_support=3D0, etc. Nothing seems to work. =
I just stuck with not able to switch to 1920x1080.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">I suspect that this is related to my firmware versio=
n. I confirmed the latest firmware is installed on my /usr/lib/firmware/ di=
r. The reason I suspect that it is a firmware issue is that I got the machi=
ne just 2 days ago and I have updated
 windows 10 to build 1709, which is very new. I suspect that windows have u=
pdated the GPU&#39;s firmware and the linux driver isn&#39;t working with i=
t. If so, is there a way to force a firmware load from the linux side (i.e.=
 a downgrade).<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Other users on the internet has report success with =
this particular machine with 4.15 kernel. Given that 4.15 doesn&#39;t work =
for me, the only thing that I could think of is the firmware version.<u></u=
><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Any other ideas?<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks a lot,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Min<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br></div>

--94eb2c1cb0de8f833e0563efba7c--

--===============0307129621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0307129621==--
