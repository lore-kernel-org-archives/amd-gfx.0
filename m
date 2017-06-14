From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Question about porting VCE1 to amdgpu
Date: Wed, 14 Jun 2017 16:22:04 +0000
Message-ID: <CAPEhTTGyy4jehNXhe93h=kB29ThOxctWzuaiwrfjkyDVu5wMww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0818965764=="
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
To: Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0818965764==
Content-Type: multipart/alternative; boundary="001a113e36269078ac0551edf4d1"

--001a113e36269078ac0551edf4d1
Content-Type: text/plain; charset="UTF-8"

Hi,

I've been working on porting VCE1 from radeon to amdgpu in the last few
weeks. I'm pretty much done and I've enabled the functionality to see how
it goes. However, I ended up with an error on the firmware validation (size
doesn't seem to fit), thus failing completely in loading the driver. I'm
testing on a R9 280X (Tahiti).

Three questions then:
- Would we need a different firmware version with a different "hdr" for the
amdgpu driver?
- Wouldn't it be better to continue loading the driver while having VCE
disabled IF we fail when loading or validating the FW? Completely failing
to load the driver for this reason seems overkill IMO, since nothing has
been loaded in memory and no registry have been modified up to that point.
- Would it be a good idea to send a patch as a RFC so some of you could
help me finish the job and maybe pinpoint where the last modifications need
to be done?

Thank you!
Alexandre Demers

--001a113e36269078ac0551edf4d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;ve been working on porting VC=
E1 from radeon to amdgpu in the last few weeks. I&#39;m pretty much done an=
d I&#39;ve enabled the functionality to see how it goes. However, I ended u=
p with an error on the firmware validation (size doesn&#39;t seem to fit), =
thus failing completely in loading the driver. I&#39;m testing on a R9 280X=
 (Tahiti).</div><div><br></div><div>Three questions then:</div><div>- Would=
 we need a different firmware version with a different &quot;hdr&quot; for =
the amdgpu driver?</div><div>- Wouldn&#39;t it be better to continue loadin=
g the driver while having VCE disabled IF we fail when loading or validatin=
g the FW? Completely failing to load the driver for this reason seems overk=
ill IMO, since nothing has been loaded in memory and no registry have been =
modified up to that point.</div><div>- Would it be a good idea to send a pa=
tch as a RFC so some of you could help me finish the job and maybe pinpoint=
 where the last modifications need to be done?</div><div><br></div><div>Tha=
nk you!</div><div>Alexandre Demers</div></div>

--001a113e36269078ac0551edf4d1--

--===============0818965764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0818965764==--
