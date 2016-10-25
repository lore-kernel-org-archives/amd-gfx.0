From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/vce3: only enable 3 rings on new enough
 firmware
Date: Tue, 25 Oct 2016 09:57:15 -0400
Message-ID: <CADnq5_OfbJVSvdqMvSGTP40pa1OGNsX94M8qbpNbqA39y8eGNQ@mail.gmail.com>
References: <1477402897-9116-1-git-send-email-alexander.deucher@amd.com>
 <7d04c8bf-c1e1-dd0f-7ee8-dfc48d64afa0@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c05dd62dc11a3053fb0e275
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7d04c8bf-c1e1-dd0f-7ee8-dfc48d64afa0-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--94eb2c05dd62dc11a3053fb0e275
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 25, 2016 at 9:49 AM, Christian K=C3=B6nig
<deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org> wrote:
> Am 25.10.2016 um 15:41 schrieb Alex Deucher:
>>
>> Older firmware versions don't support 3 rings.
>>
>> fixes:
>> https://bugs.freedesktop.org/show_bug.cgi?id=3D98016
>>
>> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> index 5ed2930..55cfc53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
>> @@ -382,6 +382,10 @@ static int vce_v3_0_sw_init(void *handle)
>>         if (r)
>>                 return r;
>>   +     /* 52.8.3 required for 3 ring support */
>> +       if (adev->vce.fw_version < 0x34080300)
>
>
> Could you add a define like we do in amdgpu_uvd.c for the firmware?
> 0x34080300 is not so easily readable if you don't know what to look for.
>
> Only nice to have, so either way patch is Reviewed-by: Christian K=C3=B6n=
ig
> <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Done.

Alex


>
> Regards,
> Christian.
>
>
>> +               adev->vce.num_rings =3D 2;
>> +
>>         r =3D amdgpu_vce_resume(adev);
>>         if (r)
>>                 return r;
>
>
>

--94eb2c05dd62dc11a3053fb0e275
Content-Type: text/x-patch; charset=UTF-8;
	name="0001-drm-amdgpu-vce3-only-enable-3-rings-on-new-enough-fi.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-vce3-only-enable-3-rings-on-new-enough-fi.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iupk3gfv0

RnJvbSA4MGI3MGRmMTQwZGJhZWQxNjQ4MzFjZjUyM2E0ZDVhMTgyNDBiNTM5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFR1ZSwgMjUgT2N0IDIwMTYgMDk6Mzc6MzcgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1L3ZjZTM6IG9ubHkgZW5hYmxlIDMgcmluZ3Mgb24gbmV3IGVub3VnaCBmaXJt
d2FyZQogKHYyKQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNo
YXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKT2xkZXIgZmlybXdh
cmUgdmVyc2lvbnMgZG9uJ3Qgc3VwcG9ydCAzIHJpbmdzLgoKZml4ZXM6Cmh0dHBzOi8vYnVncy5m
cmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTk4MDE2Cgp2MjogdXNlIGRlZmluZSBmb3Ig
ZncgdmVyc2lvbgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMgfCA2
ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS92Y2VfdjNfMC5jCmluZGV4IDVlZDI5MzAuLjM5ZjAzZjEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZjZV92M18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNlX3YzXzAuYwpAQCAtNTIsNiArNTIsOCBAQAogI2RlZmluZSBWQ0VfVjNf
MF9TVEFDS19TSVpFCSg2NCAqIDEwMjQpCiAjZGVmaW5lIFZDRV9WM18wX0RBVEFfU0laRQkoKDE2
ICogMTAyNCAqIEFNREdQVV9NQVhfVkNFX0hBTkRMRVMpICsgKDUyICogMTAyNCkpCiAKKyNkZWZp
bmUgRldfNTJfOF8zCSgoNTIgPDwgMjQpIHwgKDggPDwgMTYpIHwgKDMgPDwgOCkpCisKIHN0YXRp
YyB2b2lkIHZjZV92M18wX21jX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgaW50
IGlkeCk7CiBzdGF0aWMgdm9pZCB2Y2VfdjNfMF9zZXRfcmluZ19mdW5jcyhzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldik7CiBzdGF0aWMgdm9pZCB2Y2VfdjNfMF9zZXRfaXJxX2Z1bmNzKHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKQEAgLTM4Miw2ICszODQsMTAgQEAgc3RhdGljIGludCB2
Y2VfdjNfMF9zd19pbml0KHZvaWQgKmhhbmRsZSkKIAlpZiAocikKIAkJcmV0dXJuIHI7CiAKKwkv
KiA1Mi44LjMgcmVxdWlyZWQgZm9yIDMgcmluZyBzdXBwb3J0ICovCisJaWYgKGFkZXYtPnZjZS5m
d192ZXJzaW9uIDwgRldfNTJfOF8zKQorCQlhZGV2LT52Y2UubnVtX3JpbmdzID0gMjsKKwogCXIg
PSBhbWRncHVfdmNlX3Jlc3VtZShhZGV2KTsKIAlpZiAocikKIAkJcmV0dXJuIHI7Ci0tIAoyLjUu
NQoK
--94eb2c05dd62dc11a3053fb0e275
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--94eb2c05dd62dc11a3053fb0e275--
