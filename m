From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [amd-staging-drm-next] power1: Watt numbers do not appear since
 some days (Polaris 20)
Date: Sat, 21 Apr 2018 15:13:02 -0400
Message-ID: <CADnq5_Ni7Hww58SuuXTZ7AddMLNfmmZ29aod+atnxhh-G+dbXw@mail.gmail.com>
References: <cf1e1ef452a8072d9772eea44b2e8922@nuetzel-hh.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="001a11471274052d28056a60981c"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <cf1e1ef452a8072d9772eea44b2e8922-0hun7QTegEsDD4udEopG9Q@public.gmane.org>
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
To: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org>, Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, amd-devel <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--001a11471274052d28056a60981c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Rex

On Fri, Apr 20, 2018 at 9:25 PM, Dieter N=C3=BCtzel <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org> =
wrote:
> Hello Harry and Alex,
>
> Watt numbers are broken for some days (5 to 7).
>
> Polaris 20 (RX580), Sapphire Nitro+, 8 GB
>
> amdgpu-pci-0100
> Adapter: PCI adapter
> vddgfx:       +0.75 V
> fan1:        1048 RPM
> temp1:        +28.0=C2=B0C  (crit =3D +94.0=C2=B0C, hyst =3D -273.1=C2=B0=
C)
> power1:        0.00 W  (cap =3D 175.00 W)
>
> Should I open a ticket, bisect?


Should be fixed with this patch.

Alex


>
> Thanks,
> Dieter
>
> PS I do have litte time, summer in spring (April) here in 'good old
> Germany'...

--001a11471274052d28056a60981c
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-powerplay-actually-return-the-power-with-.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-powerplay-actually-return-the-power-with-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg9rgwj60

RnJvbSAzZmU1Y2ZjODVmODQzYjJlZjY2MjU1MjE1NTM1YTE4YWRhMDY4YTJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFNhdCwgMjEgQXByIDIwMTggMTQ6MDk6NTkgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L3Bvd2VycGxheTogYWN0dWFsbHkgcmV0dXJuIHRoZSBwb3dlciB3aXRoIHRo
ZSBuZXcKIHF1ZXJ5CgpTZXQgcXVlcnkgdG8gdGhlIHBvd2VyIHZhbHVlIHNvIHdlIGFjdHVhbGx5
IHJldHVybiBpdC4gIEZpeGVzCm5vIHBvd2VyIHZhbHVlIHJldHVybmVkIG9uIGFzaWNzIHdpdGgg
dGhlIG5ldyBxdWVyeS4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9z
bXU3X2h3bWdyLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYwppbmRleCA3
MjBhYzQ3ZDMzNjUuLjkwYWQxYjBmZmI5YSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2h3bWdyL3NtdTdfaHdtZ3IuYwpAQCAtMzM0MCw2ICszMzQwLDcgQEAgc3RhdGlj
IGludCBzbXU3X2dldF9ncHVfcG93ZXIoc3RydWN0IHBwX2h3bWdyICpod21nciwgdTMyICpxdWVy
eSkKIAogCXNtdW1fc2VuZF9tc2dfdG9fc21jX3dpdGhfcGFyYW1ldGVyKGh3bWdyLCBQUFNNQ19N
U0dfR2V0Q3VyclBrZ1B3ciwgMCk7CiAJdG1wID0gY2dzX3JlYWRfcmVnaXN0ZXIoaHdtZ3ItPmRl
dmljZSwgbW1TTUNfTVNHX0FSR18wKTsKKwkqcXVlcnkgPSB0bXA7CiAKIAlpZiAodG1wICE9IDAp
CiAJCXJldHVybiAwOwotLSAKMi4xMy42Cgo=
--001a11471274052d28056a60981c
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--001a11471274052d28056a60981c--
