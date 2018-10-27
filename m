From: Federico Cuello <fedux.c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 0/7] UVD support for SI in amdgpu
Date: Sat, 27 Oct 2018 12:53:38 +0200
Message-ID: <CALs1_Lxs=kPkjgEjx5CDGOtr9kc_u2RZhKn8WO_kmRdQS+xsQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0145715132=="
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

--===============0145715132==
Content-Type: multipart/alternative; boundary="00000000000099d0dc057933a659"

--00000000000099d0dc057933a659
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Am 09.11.2017 um 11:53 schrieb Piotr Redlewski:
> > On Thu, Nov 09, 2017 at 11:09:42AM +0100, Christian K=C3=B6nig wrote:
> >> Am 09.11.2017 um 10:54 schrieb Piotr Redlewski:
> >>> On Wed, Nov 08, 2017 at 06:54:18PM -0500, Alex Deucher wrote:
> >>>> On Wed, Nov 8, 2017 at 5:38 PM, Piotr Redlewski <predlewski at
gmail.com> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Following series implements UVD support for SI in amdgpu driver.
Code is based
> >>>>> on CIK's UVD support in amdgpu and SI's UVD support in radeon
drivers. To work,
> >>>>> it requires tahiti uvd firmware with added header - I've created
simple script
> >>>>> to produce exactly this, so if anyone is interested it can be found
here:
> >>>>> https://gist.github.com/anonymous/6d974a970340f7f64b6fcc4f95267e43
> >>>>>
> >>>>> Code is based on amd-staging-drm-next branch in Alex's tree. After
applying
> >>>>> these patches, uvd boots up and seems to work ok. I've tested it
with vdpauinfo
> >>>>> and mpv.
> >>>>>
> >>>>> Some comments/issues for the patches:
> >>>>> 1. To make uvd work, I had to bring back fb location programming.
Using location
> >>>>> programmed by vbios, vram location is not available for uvd mc (at
least on my
> >>>>> machine) due to too wide address. Starting address is 40-bit long
for fb, but
> >>>>> uvd mc supports only 32-bits (judging by comments in amdgpu code
and actual code
> >>>>> in radeon driver)
> >>>> Something else must be going on.  The vram location is irrelevant
with
> >>>> respect to the limitations of UVD.  I think the limitations with UVD
> >>>> are more to do with the location of the active buffers relative to
> >>>> each other rather than the absolute location of some aperture in the
> >>>> GPU's address space.  CI has the same limitation as I recall so ther=
e
> >>>> is probably a bug somewhere.  Windows has used the fb location as se=
t
> >>>> by the vbios since evergreen, so it definitely should work.
> >>>>
> >>> If this is the case, then there must be something missing in UVD mc
controller
> >>> programming. When using vbios, I get following location:
> >>> amdgpu 0000:01:00.0: VRAM: 2048M 0x000000F400000000 -
0x000000F47FFFFFFF (2048M used)
> >>>
> >>> When UVD bo is created, it starts at address 0xf400243000 and this
value is used
> >>> for programming UVD mc offsets. Programming is done in the following
way:
> >>> addr =3D (adev->uvd.gpu_addr + AMDGPU_UVD_FIRMWARE_OFFSET) >> 3;
> >>> WREG32(mmUVD_VCPU_CACHE_OFFSET0, addr);
> >>>
> >>> Because address of the bo is wider than 32-bit, this won't work. It
would be the
> >>> same if UVD bo would be created at the beginning of the VRAM.
> >>>
> >>> Any ideas how to handle this?
> >> Are you programming UVD_LMI_EXT40_ADDR?
> >>
> >> But I'm not sure if we ever handled that correctly in the SI code.
> > Yes, I do it exactly the same as it is done in radeon (and CIK in
amdgpu):
> >   /* bits 32-39 */
> > addr =3D (adev->uvd.gpu_addr >> 32) & 0xFF;
> > WREG32(mmUVD_LMI_EXT40_ADDR, addr | (0x9 << 16) | (0x1 << 31));
>
> Ok, I've checked the firmware in the meantime and found that we never
> released firmware which supports the full 40bit addressing.
>
> That's why this will never work correctly. Going to check if we can get
> updated firmware out of the door.

Hi Christian,

Did you manage to publish the updated firmware? I can't see it in the
linux-firmware tree.

Thanks,
Federico

> Regards,
> Christian.
>
> >
> > Regards,
> > Piotr

--00000000000099d0dc057933a659
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p>&gt; Am 09.11.2017 um 11:53 schrieb Pi=
otr Redlewski:<br>
&gt; &gt; On Thu, Nov 09, 2017 at 11:09:42AM +0100, Christian K=C3=B6nig wr=
ote:<br>
&gt; &gt;&gt; Am 09.11.2017 um 10:54 schrieb Piotr Redlewski:<br>
&gt; &gt;&gt;&gt; On Wed, Nov 08, 2017 at 06:54:18PM -0500, Alex Deucher wr=
ote:<br>
&gt; &gt;&gt;&gt;&gt; On Wed, Nov 8, 2017 at 5:38 PM, Piotr Redlewski &lt;p=
redlewski at <a href=3D"http://gmail.com">gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; Hi,<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Following series implements UVD support for SI in=
 amdgpu driver. Code is based<br>
&gt; &gt;&gt;&gt;&gt;&gt; on CIK&#39;s UVD support in amdgpu and SI&#39;s U=
VD support in radeon drivers. To work,<br>
&gt; &gt;&gt;&gt;&gt;&gt; it requires tahiti uvd firmware with added header=
 - I&#39;ve created simple script<br>
&gt; &gt;&gt;&gt;&gt;&gt; to produce exactly this, so if anyone is interest=
ed it can be found here:<br>
&gt; &gt;&gt;&gt;&gt;&gt; <a href=3D"https://gist.github.com/anonymous/6d97=
4a970340f7f64b6fcc4f95267e43">https://gist.github.com/anonymous/6d974a97034=
0f7f64b6fcc4f95267e43</a><br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Code is based on amd-staging-drm-next branch in A=
lex&#39;s tree. After applying<br>
&gt; &gt;&gt;&gt;&gt;&gt; these patches, uvd boots up and seems to work ok.=
 I&#39;ve tested it with vdpauinfo<br>
&gt; &gt;&gt;&gt;&gt;&gt; and mpv.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Some comments/issues for the patches:<br>
&gt; &gt;&gt;&gt;&gt;&gt; 1. To make uvd work, I had to bring back fb locat=
ion programming. Using location<br>
&gt; &gt;&gt;&gt;&gt;&gt; programmed by vbios, vram location is not availab=
le for uvd mc (at least on my<br>
&gt; &gt;&gt;&gt;&gt;&gt; machine) due to too wide address. Starting addres=
s is 40-bit long for fb, but<br>
&gt; &gt;&gt;&gt;&gt;&gt; uvd mc supports only 32-bits (judging by comments=
 in amdgpu code and actual code<br>
&gt; &gt;&gt;&gt;&gt;&gt; in radeon driver)<br>
&gt; &gt;&gt;&gt;&gt; Something else must be going on.=C2=A0 The vram locat=
ion is irrelevant with<br>
&gt; &gt;&gt;&gt;&gt; respect to the limitations of UVD.=C2=A0 I think the =
limitations with UVD<br>
&gt; &gt;&gt;&gt;&gt; are more to do with the location of the active buffer=
s relative to<br>
&gt; &gt;&gt;&gt;&gt; each other rather than the absolute location of some =
aperture in the<br>
&gt; &gt;&gt;&gt;&gt; GPU&#39;s address space.=C2=A0 CI has the same limita=
tion as I recall so there<br>
&gt; &gt;&gt;&gt;&gt; is probably a bug somewhere.=C2=A0 Windows has used t=
he fb location as set<br>
&gt; &gt;&gt;&gt;&gt; by the vbios since evergreen, so it definitely should=
 work.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; If this is the case, then there must be something missing=
 in UVD mc controller<br>
&gt; &gt;&gt;&gt; programming. When using vbios, I get following location:<=
br>
&gt; &gt;&gt;&gt; amdgpu 0000:01:00.0: VRAM: 2048M 0x000000F400000000 - 0x0=
00000F47FFFFFFF (2048M used)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; When UVD bo is created, it starts at address 0xf400243000=
 and this value is used<br>
&gt; &gt;&gt;&gt; for programming UVD mc offsets. Programming is done in th=
e following way:<br>
&gt; &gt;&gt;&gt; addr =3D (adev-&gt;uvd.gpu_addr + AMDGPU_UVD_FIRMWARE_OFF=
SET) &gt;&gt; 3;<br>
&gt; &gt;&gt;&gt; WREG32(mmUVD_VCPU_CACHE_OFFSET0, addr);<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Because address of the bo is wider than 32-bit, this won&=
#39;t work. It would be the<br>
&gt; &gt;&gt;&gt; same if UVD bo would be created at the beginning of the V=
RAM.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Any ideas how to handle this?<br>
&gt; &gt;&gt; Are you programming UVD_LMI_EXT40_ADDR?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; But I&#39;m not sure if we ever handled that correctly in the=
 SI code.<br>
&gt; &gt; Yes, I do it exactly the same as it is done in radeon (and CIK in=
 amdgpu):<br>
&gt; &gt;=C2=A0=C2=A0 /* bits 32-39 */<br>
&gt; &gt; addr =3D (adev-&gt;uvd.gpu_addr &gt;&gt; 32) &amp; 0xFF;<br>
&gt; &gt; WREG32(mmUVD_LMI_EXT40_ADDR, addr | (0x9 &lt;&lt; 16) | (0x1 &lt;=
&lt; 31));<br>
&gt;<br>
&gt; Ok, I&#39;ve checked the firmware in the meantime and found that we ne=
ver<br>
&gt; released firmware which supports the full 40bit addressing.<br>
&gt;<br>
&gt; That&#39;s why this will never work correctly. Going to check if we ca=
n get<br>
&gt; updated firmware out of the door.</p><p>Hi Christian,<br></p><p>Did yo=
u manage to publish the updated firmware? I can&#39;t see it in the linux-f=
irmware tree.<br></p><p>Thanks,<br>Federico</p><div><br></div><p>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Piotr<br>
  <br>
  <br>
</p></div></div>

--00000000000099d0dc057933a659--

--===============0145715132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0145715132==--
