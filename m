From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix S3 resume failre.
Date: Thu, 19 Jul 2018 14:30:05 -0400
Message-ID: <CADnq5_Om34fPU5uY_ChVv7b2jAJcP36-Auv6q-2a=Jf=d_L_KA@mail.gmail.com>
References: <1532013596-26662-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180719153902.GA5565@intel.com>
 <86de8654-1bff-ad56-9e72-9ec1eb2e7f76@amd.com>
 <13eee582-a100-4c36-e3c6-ad6f96f40efd@daenzer.net>
 <020d0b20-32f5-8974-06a7-5ef015ddca87@amd.com>
 <455ebec7-b2cf-0f8e-3fbc-be192d0913c0@daenzer.net>
 <7406a2c5-56ed-15f0-7007-25a806218a79@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="00000000000044ca3305715e5e62"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7406a2c5-56ed-15f0-7007-25a806218a79-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <harry.wentland-5C7GfCeVMHo@public.gmane.org>, Christian Koenig <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

--00000000000044ca3305715e5e62
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 19, 2018 at 1:07 PM, Andrey Grodzovsky
<Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org> wrote:
>
>
> On 07/19/2018 12:59 PM, Michel D=C3=A4nzer wrote:
>>
>> On 2018-07-19 06:53 PM, Andrey Grodzovsky wrote:
>>>
>>>
>>> On 07/19/2018 12:47 PM, Michel D=C3=A4nzer wrote:
>>>>
>>>> On 2018-07-19 06:33 PM, Andrey Grodzovsky wrote:
>>>>>
>>>>> On 07/19/2018 11:39 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
>>>>>>
>>>>>> On Thu, Jul 19, 2018 at 11:19:56AM -0400, Andrey Grodzovsky wrote:
>>>>>>>
>>>>>>> Problem:
>>>>>>> FB is still not unpinned during the first run of amdgpu_bo_evict_vr=
am
>>>>>>> and so it's left for the second run, but during second run the SDMA
>>>>>>> for
>>>>>>> moving buffer around already disabled and you have to do
>>>>>>> it with CPU, but FB is not in visible VRAM and hence the eviction
>>>>>>> failure
>>>>>>> leading later to resume failure.
>>>>>>>
>>>>>>> Fix:
>>>>>>> When DAL in use get a pointer to FB from crtc->primary->state rathe=
r
>>>>>>> then from crtc->primary which is not set for DAL since it supports
>>>>>>> atomic KMS.
>>>>>>>
>>>>>>> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=3D107065
>>>>>>> Fixes e00fb85 drm: Stop updating plane->crtc/fb/old_fb on atomic
>>>>>>> drivers
>>>>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index 709e4a3..dd9ebf7 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -2642,7 +2642,8 @@ int amdgpu_device_suspend(struct drm_device
>>>>>>> *dev, bool suspend, bool fbcon)
>>>>>>>         /* unpin the front buffers and cursors */
>>>>>>>         list_for_each_entry(crtc, &dev->mode_config.crtc_list, head=
)
>>>>>>> {
>>>>>>>             struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc=
);
>>>>>>> -        struct drm_framebuffer *fb =3D crtc->primary->fb;
>>>>>>> +         struct drm_framebuffer *fb =3D
>>>>>>> amdgpu_device_has_dc_support(adev) ?
>>>>>>> +                 crtc->primary->state->fb : crtc->primary->fb;
>>>>>>
>>>>>> So apparently you haven't yet turned off the planes here. If I'm
>>>>>> reading things right amdgpu_device_ip_suspend() should end up doing
>>>>>> that through drm_atomic_helper_suspend(). So it looks like like now
>>>>>> you'll end up unpinning the same bos twice. Doesn't that mess up
>>>>>> some kind of refcount or something?
>>>>>
>>>>> amdgpu_bo_unpin has a guard against that, amdgpu_bo_unreserve is less
>>>>> clear.
>>>>
>>>> BO reservation shouldn't an issue here, BOs are only reserved for a
>>>> short time around (un)pinning them.
>>>>
>>>>
>>>>>> To me it would seem better to susped the display before trying
>>>>>> to evict the bos.
>>>>>
>>>>> Yea, i was aware of that and indeed DAL shouldn't rely on the code in
>>>>> amdgpu_device_suspend to unpin
>>>>> front buffer and cursor since the atomic helper should do it. Problem
>>>>> is
>>>>> that during amdgpu_device_ip_suspend
>>>>> the SDMA engine gets suspended too, so you have to embed another
>>>>> eviction in between, after display is suspended but before
>>>>> SDMA and this forces ordering between them which kind of already in
>>>>> place (amd_ip_block_type) but still it's an extra constrain.
>>>>
>>>> Ville's point (which I basically agree with) is that the display
>>>> hardware should be turned off before evicting VRAM the first time, in
>>>> which case no second eviction should be necessary (for this purpose).
>>>
>>> Display HW is turned off as part of all IPs in a loop inside
>>> amdgpu_device_ip_suspend.
>>> Are you suggesting to extract the  display HW turn off from inside
>>> amdgpu_device_ip_suspend and place it
>>> before the first call to amdgpu_bo_evict_vram ?
>>
>> In a nutshell, yes.
>>
>> Or maybe it would be easier to move the amdgpu_bo_evict_vram call down
>> to somewhere called from amdgpu_device_ip_suspend?
>
>
> I can move the BEFORE and AFTER calls to amdgpu_bo_evict_vram inside
> amdgpu_device_ip_suspend
> such that the first one is called AFTER display is shut off, while the
> second in the very end of the function.
> I am just not sure what's gonna be the side effect of evicting after bunc=
h
> of blocks (such as GMC) are already disabled.

How about something like the attached patches?  Basically split the ip
suspend sequence in two like we do for resume.

Alex

--00000000000044ca3305715e5e62
Content-Type: text/x-patch; charset="US-ASCII";
	name="0002-drm-amdgpu-rework-suspend-and-resume-to-deal-with-at.patch"
Content-Disposition: attachment;
	filename="0002-drm-amdgpu-rework-suspend-and-resume-to-deal-with-at.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jjsw4alj0

RnJvbSAxNzM4OWE2MDdkYzkwZTg1OGM4ZTA3MjgwMGY3YmZhY2EyYzRkYjg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMTkgSnVsIDIwMTggMTM6MjQ6MzMgLTA1MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gZHJtL2FtZGdwdTogcmV3b3JrIHN1c3BlbmQgYW5kIHJlc3VtZSB0byBkZWFsIHdpdGgg
YXRvbWljCiBjaGFuZ2VzCgpVc2UgdGhlIG5ld2x5IHNwbGl0IGlwIHN1c3BlbmQgZnVuY3Rpb25z
IHRvIGRvIHN1c3BlbmQgZGlzcGxheXMKZmlyc3QgKHRvIGRlYWwgd2l0aCBhdG9taWMgc28gdGhh
dCBGQnMgY2FuIGJlIHVucGlubmVkIGJlZm9yZQphdHRlbXB0aW5nIHRvIGV2aWN0IHZyYW0pLCB0
aGVuIGV2aWN0IHZyYW0sIHRoZW4gc3VzcGVuZCB0aGUKb3RoZXIgSVBzLiAgQWxzbyBtb3ZlIHRo
ZSBub24tREMgcGlubmluZyBjb2RlIHRvIG9ubHkgYmUKY2FsbGVkIGluIHRoZSBub24tREMgY2Fz
ZXMgc2luY2UgYXRvbWljIHNob3VsZCB0YWtlIGNhcmUgb2YKREMuCgpCdWd6aWxsYTogaHR0cHM6
Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTA3MDY1CkZpeGVzIGUwMGZi
ODUgZHJtOiBTdG9wIHVwZGF0aW5nIHBsYW5lLT5jcnRjL2ZiL29sZF9mYiBvbiBhdG9taWMgZHJp
dmVycwpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgODYg
KysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDUgaW5zZXJ0
aW9ucygrKSwgNDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jCmluZGV4IDZkY2JjNDQzOTRkOS4uNDY1Yzg5MDRiMjMzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yNzA5LDQ0ICsyNzA5LDQ2
IEBAIGludCBhbWRncHVfZGV2aWNlX3N1c3BlbmQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgYm9v
bCBzdXNwZW5kLCBib29sIGZiY29uKQogCQkJZHJtX2hlbHBlcl9jb25uZWN0b3JfZHBtcyhjb25u
ZWN0b3IsIERSTV9NT0RFX0RQTVNfT0ZGKTsKIAkJfQogCQlkcm1fbW9kZXNldF91bmxvY2tfYWxs
KGRldik7Ci0JfQotCi0JYW1kZ3B1X2FtZGtmZF9zdXNwZW5kKGFkZXYpOwotCi0JLyogdW5waW4g
dGhlIGZyb250IGJ1ZmZlcnMgYW5kIGN1cnNvcnMgKi8KLQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNy
dGMsICZkZXYtPm1vZGVfY29uZmlnLmNydGNfbGlzdCwgaGVhZCkgewotCQlzdHJ1Y3QgYW1kZ3B1
X2NydGMgKmFtZGdwdV9jcnRjID0gdG9fYW1kZ3B1X2NydGMoY3J0Yyk7Ci0JCXN0cnVjdCBkcm1f
ZnJhbWVidWZmZXIgKmZiID0gY3J0Yy0+cHJpbWFyeS0+ZmI7Ci0JCXN0cnVjdCBhbWRncHVfYm8g
KnJvYmo7Ci0KLQkJaWYgKGFtZGdwdV9jcnRjLT5jdXJzb3JfYm8pIHsKLQkJCXN0cnVjdCBhbWRn
cHVfYm8gKmFvYmogPSBnZW1fdG9fYW1kZ3B1X2JvKGFtZGdwdV9jcnRjLT5jdXJzb3JfYm8pOwot
CQkJciA9IGFtZGdwdV9ib19yZXNlcnZlKGFvYmosIHRydWUpOwotCQkJaWYgKHIgPT0gMCkgewot
CQkJCWFtZGdwdV9ib191bnBpbihhb2JqKTsKLQkJCQlhbWRncHVfYm9fdW5yZXNlcnZlKGFvYmop
OworCQkJLyogdW5waW4gdGhlIGZyb250IGJ1ZmZlcnMgYW5kIGN1cnNvcnMgKi8KKwkJbGlzdF9m
b3JfZWFjaF9lbnRyeShjcnRjLCAmZGV2LT5tb2RlX2NvbmZpZy5jcnRjX2xpc3QsIGhlYWQpIHsK
KwkJCXN0cnVjdCBhbWRncHVfY3J0YyAqYW1kZ3B1X2NydGMgPSB0b19hbWRncHVfY3J0YyhjcnRj
KTsKKwkJCXN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiID0gY3J0Yy0+cHJpbWFyeS0+ZmI7CisJ
CQlzdHJ1Y3QgYW1kZ3B1X2JvICpyb2JqOworCisJCQlpZiAoYW1kZ3B1X2NydGMtPmN1cnNvcl9i
bykgeworCQkJCXN0cnVjdCBhbWRncHVfYm8gKmFvYmogPSBnZW1fdG9fYW1kZ3B1X2JvKGFtZGdw
dV9jcnRjLT5jdXJzb3JfYm8pOworCQkJCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhb2JqLCB0cnVl
KTsKKwkJCQlpZiAociA9PSAwKSB7CisJCQkJCWFtZGdwdV9ib191bnBpbihhb2JqKTsKKwkJCQkJ
YW1kZ3B1X2JvX3VucmVzZXJ2ZShhb2JqKTsKKwkJCQl9CiAJCQl9Ci0JCX0KIAotCQlpZiAoZmIg
PT0gTlVMTCB8fCBmYi0+b2JqWzBdID09IE5VTEwpIHsKLQkJCWNvbnRpbnVlOwotCQl9Ci0JCXJv
YmogPSBnZW1fdG9fYW1kZ3B1X2JvKGZiLT5vYmpbMF0pOwotCQkvKiBkb24ndCB1bnBpbiBrZXJu
ZWwgZmIgb2JqZWN0cyAqLwotCQlpZiAoIWFtZGdwdV9mYmRldl9yb2JqX2lzX2ZiKGFkZXYsIHJv
YmopKSB7Ci0JCQlyID0gYW1kZ3B1X2JvX3Jlc2VydmUocm9iaiwgdHJ1ZSk7Ci0JCQlpZiAociA9
PSAwKSB7Ci0JCQkJYW1kZ3B1X2JvX3VucGluKHJvYmopOwotCQkJCWFtZGdwdV9ib191bnJlc2Vy
dmUocm9iaik7CisJCQlpZiAoZmIgPT0gTlVMTCB8fCBmYi0+b2JqWzBdID09IE5VTEwpIHsKKwkJ
CQljb250aW51ZTsKKwkJCX0KKwkJCXJvYmogPSBnZW1fdG9fYW1kZ3B1X2JvKGZiLT5vYmpbMF0p
OworCQkJLyogZG9uJ3QgdW5waW4ga2VybmVsIGZiIG9iamVjdHMgKi8KKwkJCWlmICghYW1kZ3B1
X2ZiZGV2X3JvYmpfaXNfZmIoYWRldiwgcm9iaikpIHsKKwkJCQlyID0gYW1kZ3B1X2JvX3Jlc2Vy
dmUocm9iaiwgdHJ1ZSk7CisJCQkJaWYgKHIgPT0gMCkgeworCQkJCQlhbWRncHVfYm9fdW5waW4o
cm9iaik7CisJCQkJCWFtZGdwdV9ib191bnJlc2VydmUocm9iaik7CisJCQkJfQogCQkJfQogCQl9
CiAJfQorCisJYW1kZ3B1X2FtZGtmZF9zdXNwZW5kKGFkZXYpOworCisJciA9IGFtZGdwdV9kZXZp
Y2VfaXBfc3VzcGVuZF9waGFzZTEoYWRldik7CisKIAkvKiBldmljdCB2cmFtIG1lbW9yeSAqLwog
CWFtZGdwdV9ib19ldmljdF92cmFtKGFkZXYpOwogCiAJYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zdXNw
ZW5kKGFkZXYpOwogCi0JciA9IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZChhZGV2KTsKKwlyID0g
YW1kZ3B1X2RldmljZV9pcF9zdXNwZW5kX3BoYXNlMihhZGV2KTsKIAogCS8qIGV2aWN0IHJlbWFp
bmluZyB2cmFtIG1lbW9yeQogCSAqIFRoaXMgc2Vjb25kIGNhbGwgdG8gZXZpY3QgdnJhbSBpcyB0
byBldmljdCB0aGUgZ2FydCBwYWdlIHRhYmxlCkBAIC0yODI0LDE5ICsyODI2LDIxIEBAIGludCBh
bWRncHVfZGV2aWNlX3Jlc3VtZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBib29sIHJlc3VtZSwg
Ym9vbCBmYmNvbikKIAlpZiAocikKIAkJZ290byB1bmxvY2s7CiAKLQkvKiBwaW4gY3Vyc29ycyAq
LwotCWxpc3RfZm9yX2VhY2hfZW50cnkoY3J0YywgJmRldi0+bW9kZV9jb25maWcuY3J0Y19saXN0
LCBoZWFkKSB7Ci0JCXN0cnVjdCBhbWRncHVfY3J0YyAqYW1kZ3B1X2NydGMgPSB0b19hbWRncHVf
Y3J0YyhjcnRjKTsKLQotCQlpZiAoYW1kZ3B1X2NydGMtPmN1cnNvcl9ibykgewotCQkJc3RydWN0
IGFtZGdwdV9ibyAqYW9iaiA9IGdlbV90b19hbWRncHVfYm8oYW1kZ3B1X2NydGMtPmN1cnNvcl9i
byk7Ci0JCQlyID0gYW1kZ3B1X2JvX3Jlc2VydmUoYW9iaiwgdHJ1ZSk7Ci0JCQlpZiAociA9PSAw
KSB7Ci0JCQkJciA9IGFtZGdwdV9ib19waW4oYW9iaiwgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSk7
Ci0JCQkJaWYgKHIgIT0gMCkKLQkJCQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gcGluIGN1cnNvciBC
TyAoJWQpXG4iLCByKTsKLQkJCQlhbWRncHVfY3J0Yy0+Y3Vyc29yX2FkZHIgPSBhbWRncHVfYm9f
Z3B1X29mZnNldChhb2JqKTsKLQkJCQlhbWRncHVfYm9fdW5yZXNlcnZlKGFvYmopOworCWlmICgh
YW1kZ3B1X2RldmljZV9oYXNfZGNfc3VwcG9ydChhZGV2KSkgeworCQkvKiBwaW4gY3Vyc29ycyAq
LworCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNydGMsICZkZXYtPm1vZGVfY29uZmlnLmNydGNfbGlz
dCwgaGVhZCkgeworCQkJc3RydWN0IGFtZGdwdV9jcnRjICphbWRncHVfY3J0YyA9IHRvX2FtZGdw
dV9jcnRjKGNydGMpOworCisJCQlpZiAoYW1kZ3B1X2NydGMtPmN1cnNvcl9ibykgeworCQkJCXN0
cnVjdCBhbWRncHVfYm8gKmFvYmogPSBnZW1fdG9fYW1kZ3B1X2JvKGFtZGdwdV9jcnRjLT5jdXJz
b3JfYm8pOworCQkJCXIgPSBhbWRncHVfYm9fcmVzZXJ2ZShhb2JqLCB0cnVlKTsKKwkJCQlpZiAo
ciA9PSAwKSB7CisJCQkJCXIgPSBhbWRncHVfYm9fcGluKGFvYmosIEFNREdQVV9HRU1fRE9NQUlO
X1ZSQU0pOworCQkJCQlpZiAociAhPSAwKQorCQkJCQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gcGlu
IGN1cnNvciBCTyAoJWQpXG4iLCByKTsKKwkJCQkJYW1kZ3B1X2NydGMtPmN1cnNvcl9hZGRyID0g
YW1kZ3B1X2JvX2dwdV9vZmZzZXQoYW9iaik7CisJCQkJCWFtZGdwdV9ib191bnJlc2VydmUoYW9i
aik7CisJCQkJfQogCQkJfQogCQl9CiAJfQotLSAKMi4xMy42Cgo=
--00000000000044ca3305715e5e62
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-split-ip-suspend-into-2-phases.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-split-ip-suspend-into-2-phases.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jjsw4am81

RnJvbSA1N2ZlMTAxYjEyNzI2NTNiNjNhYTJmZGNhYzhkZTFhNDI1MjMzNTU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMTkgSnVsIDIwMTggMTM6MTA6MDcgLTA1MDAKU3ViamVjdDogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdTogc3BsaXQgaXAgc3VzcGVuZCBpbnRvIDIgcGhhc2VzCgpXZSBuZWVk
IHRvIGRvIHNvbWUgSVBzIGVhcmxpZXIgdG8gZGVhbCB3aXRoIG9yZGVyaW5nIGlzc3VlcwpzaW1p
bGFyIHRvIGhvdyByZXN1bWUgaXMgc3BsaXQgaW50byB0d28gcGhhc2VzLiBEbyBEQ0UgZmlyc3QK
dG8gZGVhbCB3aXRoIGF0b21pYywgdGhlbiBkbyB0aGUgcmVzdC4KClNpZ25lZC1vZmYtYnk6IEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgfCA3OCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwppbmRleCA5OWE4
NjdmZDcwMzEuLjZkY2JjNDQzOTRkOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYwpAQCAtMTkyNiw3ICsxOTI2LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2Rl
dmljZV9pcF9sYXRlX2luaXRfZnVuY19oYW5kbGVyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykK
IH0KIAogLyoqCi0gKiBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmQgLSBydW4gc3VzcGVuZCBmb3Ig
aGFyZHdhcmUgSVBzCisgKiBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmRfcGhhc2UxIC0gcnVuIHN1
c3BlbmQgZm9yIGhhcmR3YXJlIElQcyAocGhhc2UgMSkKICAqCiAgKiBAYWRldjogYW1kZ3B1X2Rl
dmljZSBwb2ludGVyCiAgKgpAQCAtMTkzNiw3ICsxOTM2LDU1IEBAIHN0YXRpYyB2b2lkIGFtZGdw
dV9kZXZpY2VfaXBfbGF0ZV9pbml0X2Z1bmNfaGFuZGxlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCiAgKiBpbiBlYWNoIElQIGludG8gYSBzdGF0ZSBzdWl0YWJsZSBmb3Igc3VzcGVuZC4KICAq
IFJldHVybnMgMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1cmUuCiAg
Ki8KLWludCBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYpCitzdGF0aWMgaW50IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9waGFzZTEoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYpCit7CisJaW50IGksIHI7CisKKwlpZiAoYW1kZ3B1X3NyaW92X3Zm
KGFkZXYpKQorCQlhbWRncHVfdmlydF9yZXF1ZXN0X2Z1bGxfZ3B1KGFkZXYsIGZhbHNlKTsKKwor
CWZvciAoaSA9IGFkZXYtPm51bV9pcF9ibG9ja3MgLSAxOyBpID49IDA7IGktLSkgeworCQlpZiAo
IWFkZXYtPmlwX2Jsb2Nrc1tpXS5zdGF0dXMudmFsaWQpCisJCQljb250aW51ZTsKKwkJLyogZGlz
cGxheXMgYXJlIGhhbmRsZWQgc2VwYXJhdGVseSAqLworCQlpZiAoYWRldi0+aXBfYmxvY2tzW2ld
LnZlcnNpb24tPnR5cGUgPT0gQU1EX0lQX0JMT0NLX1RZUEVfRENFKSB7CisJCQkvKiB1bmdhdGUg
YmxvY2tzIHNvIHRoYXQgc3VzcGVuZCBjYW4gcHJvcGVybHkgc2h1dCB0aGVtIGRvd24gKi8KKwkJ
CWlmIChhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPnNldF9jbG9ja2dhdGluZ19z
dGF0ZSkgeworCQkJCXIgPSBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPnNldF9j
bG9ja2dhdGluZ19zdGF0ZSgodm9pZCAqKWFkZXYsCisJCQkJCQkJCQkJCSAgICAgQU1EX0NHX1NU
QVRFX1VOR0FURSk7CisJCQkJaWYgKHIpIHsKKwkJCQkJRFJNX0VSUk9SKCJzZXRfY2xvY2tnYXRp
bmdfc3RhdGUodW5nYXRlKSBvZiBJUCBibG9jayA8JXM+IGZhaWxlZCAlZFxuIiwKKwkJCQkJCSAg
YWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPmZ1bmNzLT5uYW1lLCByKTsKKwkJCQl9CisJCQl9
CisJCQkvKiBYWFggaGFuZGxlIGVycm9ycyAqLworCQkJciA9IGFkZXYtPmlwX2Jsb2Nrc1tpXS52
ZXJzaW9uLT5mdW5jcy0+c3VzcGVuZChhZGV2KTsKKwkJCS8qIFhYWCBoYW5kbGUgZXJyb3JzICov
CisJCQlpZiAocikgeworCQkJCURSTV9FUlJPUigic3VzcGVuZCBvZiBJUCBibG9jayA8JXM+IGZh
aWxlZCAlZFxuIiwKKwkJCQkJICBhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MtPm5h
bWUsIHIpOworCQkJfQorCQl9CisJfQorCisJaWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKKwkJ
YW1kZ3B1X3ZpcnRfcmVsZWFzZV9mdWxsX2dwdShhZGV2LCBmYWxzZSk7CisKKwlyZXR1cm4gMDsK
K30KKworLyoqCisgKiBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmRfcGhhc2UyIC0gcnVuIHN1c3Bl
bmQgZm9yIGhhcmR3YXJlIElQcyAocGhhc2UgMikKKyAqCisgKiBAYWRldjogYW1kZ3B1X2Rldmlj
ZSBwb2ludGVyCisgKgorICogTWFpbiBzdXNwZW5kIGZ1bmN0aW9uIGZvciBoYXJkd2FyZSBJUHMu
ICBUaGUgbGlzdCBvZiBhbGwgdGhlIGhhcmR3YXJlCisgKiBJUHMgdGhhdCBtYWtlIHVwIHRoZSBh
c2ljIGlzIHdhbGtlZCwgY2xvY2tnYXRpbmcgaXMgZGlzYWJsZWQgYW5kIHRoZQorICogc3VzcGVu
ZCBjYWxsYmFja3MgYXJlIHJ1bi4gIHN1c3BlbmQgcHV0cyB0aGUgaGFyZHdhcmUgYW5kIHNvZnR3
YXJlIHN0YXRlCisgKiBpbiBlYWNoIElQIGludG8gYSBzdGF0ZSBzdWl0YWJsZSBmb3Igc3VzcGVu
ZC4KKyAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBlcnJvciBjb2RlIG9uIGZhaWx1
cmUuCisgKi8KK3N0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9pcF9zdXNwZW5kX3BoYXNlMihzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKIAlpbnQgaSwgcjsKIApAQCAtMTk1Nyw2ICsyMDA1
LDkgQEAgaW50IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKIAlmb3IgKGkgPSBhZGV2LT5udW1faXBfYmxvY2tzIC0gMTsgaSA+PSAwOyBpLS0pIHsK
IAkJaWYgKCFhZGV2LT5pcF9ibG9ja3NbaV0uc3RhdHVzLnZhbGlkKQogCQkJY29udGludWU7CisJ
CS8qIGRpc3BsYXlzIGFyZSBoYW5kbGVkIGluIHBoYXNlMSAqLworCQlpZiAoYWRldi0+aXBfYmxv
Y2tzW2ldLnZlcnNpb24tPnR5cGUgPT0gQU1EX0lQX0JMT0NLX1RZUEVfRENFKQorCQkJY29udGlu
dWU7CiAJCS8qIHVuZ2F0ZSBibG9ja3Mgc28gdGhhdCBzdXNwZW5kIGNhbiBwcm9wZXJseSBzaHV0
IHRoZW0gZG93biAqLwogCQlpZiAoYWRldi0+aXBfYmxvY2tzW2ldLnZlcnNpb24tPnR5cGUgIT0g
QU1EX0lQX0JMT0NLX1RZUEVfU01DICYmCiAJCQlhZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+
ZnVuY3MtPnNldF9jbG9ja2dhdGluZ19zdGF0ZSkgewpAQCAtMTk4Miw2ICsyMDMzLDI5IEBAIGlu
dCBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJ
cmV0dXJuIDA7CiB9CiAKKy8qKgorICogYW1kZ3B1X2RldmljZV9pcF9zdXNwZW5kIC0gcnVuIHN1
c3BlbmQgZm9yIGhhcmR3YXJlIElQcworICoKKyAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50
ZXIKKyAqCisgKiBNYWluIHN1c3BlbmQgZnVuY3Rpb24gZm9yIGhhcmR3YXJlIElQcy4gIFRoZSBs
aXN0IG9mIGFsbCB0aGUgaGFyZHdhcmUKKyAqIElQcyB0aGF0IG1ha2UgdXAgdGhlIGFzaWMgaXMg
d2Fsa2VkLCBjbG9ja2dhdGluZyBpcyBkaXNhYmxlZCBhbmQgdGhlCisgKiBzdXNwZW5kIGNhbGxi
YWNrcyBhcmUgcnVuLiAgc3VzcGVuZCBwdXRzIHRoZSBoYXJkd2FyZSBhbmQgc29mdHdhcmUgc3Rh
dGUKKyAqIGluIGVhY2ggSVAgaW50byBhIHN0YXRlIHN1aXRhYmxlIGZvciBzdXNwZW5kLgorICog
UmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG5lZ2F0aXZlIGVycm9yIGNvZGUgb24gZmFpbHVyZS4KKyAq
LworaW50IGFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKK3sKKwlpbnQgcjsKKworCXIgPSBhbWRncHVfZGV2aWNlX2lwX3N1c3BlbmRfcGhhc2UxKGFk
ZXYpOworCWlmIChyKQorCQlyZXR1cm4gcjsKKwlyID0gYW1kZ3B1X2RldmljZV9pcF9zdXNwZW5k
X3BoYXNlMihhZGV2KTsKKworCXJldHVybiByOworfQorCiBzdGF0aWMgaW50IGFtZGdwdV9kZXZp
Y2VfaXBfcmVpbml0X2Vhcmx5X3NyaW92KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewog
CWludCBpLCByOwotLSAKMi4xMy42Cgo=
--00000000000044ca3305715e5e62
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--00000000000044ca3305715e5e62--
