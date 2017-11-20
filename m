From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [amd-staging-drm-next] regression - no fan info (sensors) on RX580
Date: Mon, 20 Nov 2017 17:57:02 -0500
Message-ID: <CADnq5_N8GO8pmOLaZszMUxt6ZA1OZyVHY3O95kN8r9FFPOncVQ@mail.gmail.com>
References: <42afc09a774d61e68c415c05371fbb3b@nuetzel-hh.de>
 <CADnq5_Pon27TVK0bKNeNVA71j27G8iDSPMq=9gZxg6VZad_Rrw@mail.gmail.com>
 <CY4PR12MB16871ED1E36D855E7781C68CFB7F0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <3ad0d897c4c5e67207b4097337ff520f@nuetzel-hh.de>
 <322466dc29fe070b9fe79fb8400fac6e@nuetzel-hh.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="f403045e486c39de13055e7201d5"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <322466dc29fe070b9fe79fb8400fac6e-0hun7QTegEsDD4udEopG9Q@public.gmane.org>
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
To: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Zhu,
 Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, DRI Devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, amd-devel <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--f403045e486c39de13055e7201d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 8, 2017 at 10:31 PM, Dieter N=C3=BCtzel <Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org> =
wrote:
> OK, got it but can't revert the commit clean.
>
> amdgpu-pci-0100
> Adapter: PCI adapter
> fan1:         873 RPM
> temp1:        +26.0=C2=B0C  (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0C=
)
>
> SOURCE/amd-staging-drm-next> git bisect good
> 0944c350c8eddf4064e7abb881dd245032fdfa23 is the first bad commit
> commit 0944c350c8eddf4064e7abb881dd245032fdfa23
> Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> Date:   Mon Sep 25 18:51:50 2017 +0800
>
>     drm/amdgpu: delete pp_enable in adev
>
>     amdgpu not care powerplay or dpm is enabled.
>     just check ip functions and pp functions
>
>     Change-Id: Iaac75d45170ef9b20e212465f837eaaa798365bd
>     Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>     Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
> :040000 040000 72361654709479890586e383ec73088e535a1cf5
> 2b6d5a75ffc3b6fd48c63e79bf28faddcc734918 M drivers

I think the attached patch should fix it.

Alex

>
> Greetings,
> Dieter
>
>
>
> Am 09.10.2017 02:19, schrieb Dieter N=C3=BCtzel:
>>
>> Sorry Rex,
>>
>> after return from our vacation,
>> I've tested latest amd-staging-drm-next (e5f6a57e350a)
>> but it is NOT solved on my RX580.
>> I'll try bisecting if I find some more time in the coming days.
>>
>> amdgpu-pci-0100
>> Adapter: PCI adapter
>> temp1:        +27.0=C2=B0C  (crit =3D  +0.0=C2=B0C, hyst =3D  +0.0=C2=B0=
C)
>>
>> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
>> [AMD/ATI] Ellesmere [Radeon RX 470/480/570/580] (rev e7) (prog-if 00
>> [VGA controller])
>>         Subsystem: Sapphire Technology Limited Radeon RX 570
>>
>> [    36.740] (--) AMDGPU(0): Chipset: "Radeon RX 580 Series" (ChipID =3D
>> 0x67df)
>>
>> Thanks,
>> Dieter
>>
>> Am 30.09.2017 05:09, schrieb Zhu, Rex:
>>>
>>> Yes, caused by the commit e37a7b4088da
>>> ("drm/amd/powerplay: tidy up ret checks in amd_powerplay.c")
>>>
>>> Replace error when split patches.
>>>
>>> Have sent the fix patch.
>>> Please review.
>>>
>>> Best Regards
>>> Rex
>>>
>>>
>>> -----Original Message-----
>>> From: Alex Deucher [mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
>>> Sent: Friday, September 29, 2017 10:11 PM
>>> To: Dieter N=C3=BCtzel; Zhu, Rex
>>> Cc: amd-devel; DRI Devel; Wentland, Harry; Michel D=C3=A4nzer
>>> Subject: Re: [amd-staging-drm-next] regression - no fan info (sensors) =
on
>>> RX580
>>>
>>> Rex, probably related to the recent cleanups in powerplay.
>>>
>>> On Fri, Sep 29, 2017 at 10:09 AM, Dieter N=C3=BCtzel <Dieter@nuetzel-hh=
.de>
>>> wrote:
>>>>
>>>> Hello all,
>>>>
>>>> since latest update
>>>>
>>>> 1d7da702e70d3c27408a3bb312c71d6be9f7bebe
>>>> drm/amd/powerplay: fix spelling mistake: "dividable" -> "divisible"
>>>>
>>>> I didn't get fan info with my RX580 (Polaris21) any longer.
>>>>
>>>> Worked with this commit:
>>>>
>>>> 786df0b89fe5a0b405d4de0a1ce03003c0743ec3
>>>> drm/amd/display: fix pflip irq registor for raven
>>>>
>>>> Sorry, I do not have full time for bisect, because we are on way to
>>>> our vacation.
>>>>
>>>> Maybe in the evening (only a few commits).
>>>>
>>>> Greetings,
>>>> Dieter
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--f403045e486c39de13055e7201d5
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-don-t-skip-attributes-when-powerplay-is-e.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-don-t-skip-attributes-when-powerplay-is-e.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ja8sjods0

RnJvbSA3MGQ1N2I0ODBlY2U2N2RiYjRjNTQyOTRmNWIzNDU0OTA0MzY4OGFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IE1vbiwgMjAgTm92IDIwMTcgMTc6NDk6NTMgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBkb24ndCBza2lwIGF0dHJpYnV0ZXMgd2hlbiBwb3dlcnBsYXkgaXMgZW5h
YmxlZAoKVGhlIGZ1bmN0aW9uIGNoZWNrcyBub24tcG93ZXJwbGF5IHN0cnVjdHVyZXMgc28gcmVn
cmVzc2VkIHdoZW4KdGhlIHBwX2VuYWJsZWQgY2hlY2sgd2FzIHJlbW92ZWQuICBUaGlzIHNob3Vs
ZCBpZGVhbGx5IGJlCmltcGxlbWVudGVkIHNpbWlsYXJseSBmb3IgcG93ZXJwbGF5LgoKRml4ZXM6
IDZkMDdmZTdiY2FlNTcgKCJkcm0vYW1kZ3B1OiBkZWxldGUgcHBfZW5hYmxlIGluIGFkZXYiKQpT
aWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BtLmMgfCA0ICsrKysKIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9wbS5jCmluZGV4IDM1MDY3NTgzNDlkYy4uNmY1NmZmNjA2ZTQzIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcG0uYwpAQCAtOTQ1LDYgKzk0NSwxMCBAQCBzdGF0aWMgdW1vZGVf
dCBod21vbl9hdHRyaWJ1dGVzX3Zpc2libGUoc3RydWN0IGtvYmplY3QgKmtvYmosCiAJc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsKIAl1bW9kZV90IGVm
ZmVjdGl2ZV9tb2RlID0gYXR0ci0+bW9kZTsKIAorCS8qIG5vIHNraXBwaW5nIGZvciBwb3dlcnBs
YXkgKi8KKwlpZiAoYWRldi0+cG93ZXJwbGF5LmNnc19kZXZpY2UpCisJCXJldHVybiBlZmZlY3Rp
dmVfbW9kZTsKKwogCS8qIFNraXAgbGltaXQgYXR0cmlidXRlcyBpZiBEUE0gaXMgbm90IGVuYWJs
ZWQgKi8KIAlpZiAoIWFkZXYtPnBtLmRwbV9lbmFibGVkICYmCiAJICAgIChhdHRyID09ICZzZW5z
b3JfZGV2X2F0dHJfdGVtcDFfY3JpdC5kZXZfYXR0ci5hdHRyIHx8Ci0tIAoyLjEzLjYKCg==
--f403045e486c39de13055e7201d5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--f403045e486c39de13055e7201d5--
