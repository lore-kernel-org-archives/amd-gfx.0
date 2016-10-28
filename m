From: Mike Lothian <mike@fireburn.co.uk>
Subject: Re: [PATCH] drm/i915: Before pageflip,
 also wait for shared dmabuf fences.
Date: Fri, 28 Oct 2016 18:37:26 +0000
Message-ID: <CAHbf0-H0owRAp_VXWd84E03OiPKXSE0jZ1=+OAtvoKuoSyt_=A@mail.gmail.com>
References: <3f4643cb-52a9-d7ae-439b-5f6fc6e718cc@vodafone.de>
 <20160922063625.GD22164@dvetter-linux.ger.corp.intel.com>
 <b95726e7-6bf6-a1b8-2a63-0758b1b185e2@vodafone.de>
 <CAKMK7uF13M7d8qRRwKs_8M-QHjnuB7k3jshTUDnccTTQf6unog@mail.gmail.com>
 <ddf99e2a-5f9a-41b9-9fde-af7bfd522572@vodafone.de>
 <CAKMK7uEidoKbTO-m3KSz8UmQhF+uorg2-cWY8UpOXjZ_9MCxLg@mail.gmail.com>
 <d2430ff8-43bd-bff2-9b02-847cabfd56c0@vodafone.de>
 <ed1a57a4-1409-6d07-998a-2b54f466f710@daenzer.net>
 <20160923120954.GH22164@dvetter-linux.ger.corp.intel.com>
 <8c21f70a-7f96-480e-9784-93f2d48f52bb@daenzer.net>
 <20160926080419.GV20761@phenom.ffwll.local>
 <CAHbf0-HZ6EotqwgvkxRTdRF97xB3qBA=DRKAzaAXguV_PR_P8w@mail.gmail.com>
 <d74d34a7-5221-d282-d9d1-b0e1007fc0c7@daenzer.net>
 <c77a2cb9-1f0e-f1a3-aedd-a111cd6ba8e8@vodafone.de>
 <e92512c7-4fb5-6fa1-e93f-0322d1537c46@daenzer.net>
 <CAHbf0-GGMWZrhB+PKpc-QbD__6fqB4pQVFfN+gzLWNhi+DuG3Q@mail.gmail.com>
 <720351a2-7597-aee3-58ce-9d65cad5762f@daenzer.net>
 <7eb19a73-a558-d2e6-bd8d-34fe95045dfd@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11471a14071c2f053ff127a8
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <7eb19a73-a558-d2e6-bd8d-34fe95045dfd@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mario Kleiner <mario.kleiner.de@gmail.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple@vodafone.de>, Daniel Vetter <daniel@ffwll.ch>
Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

--001a11471a14071c2f053ff127a8
Content-Type: multipart/alternative; boundary=001a11471a14071c29053ff127a6

--001a11471a14071c29053ff127a6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mario

That fixes the tearing, it's been replaced with a strange stutter, like
it's only showing half the number of frames being reported - it's really
noticeable in tomb raider

Thanks for your work on this, the stutter is much more manageable than the
tearing was

I've attached the patch that applies cleanly to 4.10-wip



On Fri, 28 Oct 2016 at 18:37 Mario Kleiner <mario.kleiner.de@gmail.com>
wrote:

>
>
> On 10/28/2016 03:34 AM, Michel D=C3=A4nzer wrote:
> > On 27/10/16 10:33 PM, Mike Lothian wrote:
> >>
> >> Just another gentle ping to see where you are with this?
> >
> > I haven't got a chance to look into this any further.
> >
> >
>
> Fwiw., as a proof of concept, the attached experimental patch does work
> as tested on Intel HD Haswell + AMD R9 380 Tonga under amdgpu and
> DRI3/Present when applied to drm-next (updated from a few days ago).
> With DRI_PRIME=3D1 tearing for page-flipped fullscreen windows is gone
> under all loads. The tearing with "windowed" windows now looks as
> expected for regular tearing not related to Prime.
>
> ftrace confirms the i915 driver's pageflip function is waiting on the
> fence in reservation_object_wait_timeout_rcu() as it should.
>
> That entry->tv.shared needs to be set false for such buffers in
> amdgpu_bo_list_set() makes sense to me, as that is part of the buffer
> validation for command stream submission. There are other places in the
> driver where tv.shared is set, which i didn't check so far.
>
> I don't know which of these would need to be updated with a "exported
> bo" check as well, e.g., for video decoding or maybe gpu compute? Adding
> or removing the check to amdgpu_gem_va_update_vm(), e.g., made no
> difference. I assume that makes sense because that functions seems to
> deal with amdgpu internal vm page tables or page table entries for such
> a bo, not with something visible to external clients?
>
> All i can say is it fixes 3D rendering under DRI3 + Prime + pageflipping
> without causing any obvious new problems.
>
> -mario
>

--001a11471a14071c29053ff127a6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Mario<div><br></div><div>That fixes the tearing, it&#39=
;s been replaced with a strange stutter, like it&#39;s only showing half th=
e number of frames being reported - it&#39;s really noticeable in tomb raid=
er</div><div><br></div><div>Thanks for your work on this, the stutter is mu=
ch more manageable than the tearing was</div><div><br></div><div>I&#39;ve a=
ttached the patch that applies cleanly to 4.10-wip</div><div><br></div><div=
>=C2=A0<br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Fri, 28 Oct 2=
016 at 18:37 Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.com=
">mario.kleiner.de@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br class=3D"gmail_msg">
<br class=3D"gmail_msg">
On 10/28/2016 03:34 AM, Michel D=C3=A4nzer wrote:<br class=3D"gmail_msg">
&gt; On 27/10/16 10:33 PM, Mike Lothian wrote:<br class=3D"gmail_msg">
&gt;&gt;<br class=3D"gmail_msg">
&gt;&gt; Just another gentle ping to see where you are with this?<br class=
=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt; I haven&#39;t got a chance to look into this any further.<br class=3D"=
gmail_msg">
&gt;<br class=3D"gmail_msg">
&gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Fwiw., as a proof of concept, the attached experimental patch does work<br =
class=3D"gmail_msg">
as tested on Intel HD Haswell + AMD R9 380 Tonga under amdgpu and<br class=
=3D"gmail_msg">
DRI3/Present when applied to drm-next (updated from a few days ago).<br cla=
ss=3D"gmail_msg">
With DRI_PRIME=3D1 tearing for page-flipped fullscreen windows is gone<br c=
lass=3D"gmail_msg">
under all loads. The tearing with &quot;windowed&quot; windows now looks as=
<br class=3D"gmail_msg">
expected for regular tearing not related to Prime.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
ftrace confirms the i915 driver&#39;s pageflip function is waiting on the<b=
r class=3D"gmail_msg">
fence in reservation_object_wait_timeout_rcu() as it should.<br class=3D"gm=
ail_msg">
<br class=3D"gmail_msg">
That entry-&gt;tv.shared needs to be set false for such buffers in<br class=
=3D"gmail_msg">
amdgpu_bo_list_set() makes sense to me, as that is part of the buffer<br cl=
ass=3D"gmail_msg">
validation for command stream submission. There are other places in the<br =
class=3D"gmail_msg">
driver where tv.shared is set, which i didn&#39;t check so far.<br class=3D=
"gmail_msg">
<br class=3D"gmail_msg">
I don&#39;t know which of these would need to be updated with a &quot;expor=
ted<br class=3D"gmail_msg">
bo&quot; check as well, e.g., for video decoding or maybe gpu compute? Addi=
ng<br class=3D"gmail_msg">
or removing the check to amdgpu_gem_va_update_vm(), e.g., made no<br class=
=3D"gmail_msg">
difference. I assume that makes sense because that functions seems to<br cl=
ass=3D"gmail_msg">
deal with amdgpu internal vm page tables or page table entries for such<br =
class=3D"gmail_msg">
a bo, not with something visible to external clients?<br class=3D"gmail_msg=
">
<br class=3D"gmail_msg">
All i can say is it fixes 3D rendering under DRI3 + Prime + pageflipping<br=
 class=3D"gmail_msg">
without causing any obvious new problems.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
-mario<br class=3D"gmail_msg">
</blockquote></div></div></div>

--001a11471a14071c29053ff127a6--

--001a11471a14071c2f053ff127a8
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-drm-amdgpu-Attach-exclusive-fence-to-prime-exported-.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Attach-exclusive-fence-to-prime-exported-.patch"
Content-Transfer-Encoding: base64
Content-ID: <1580c9501f771cb66681>
X-Attachment-Id: 1580c9501f771cb66681

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKaW5kZXggMjE3ZGYyNC4uNjc1N2I5OSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKQEAgLTM5MSw2ICszOTEsNyBAQCBzdHJ1Y3Qg
YW1kZ3B1X2JvIHsKIAl1NjQJCQkJbWV0YWRhdGFfZmxhZ3M7CiAJdm9pZAkJCQkqbWV0YWRhdGE7
CiAJdTMyCQkJCW1ldGFkYXRhX3NpemU7CisJYm9vbAkJCQlwcmltZV9leHBvcnRlZDsKIAkvKiBs
aXN0IG9mIGFsbCB2aXJ0dWFsIGFkZHJlc3MgdG8gd2hpY2ggdGhpcyBibwogCSAqIGlzIGFzc29j
aWF0ZWQgdG8KIAkgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9ib19saXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYm9fbGlz
dC5jCmluZGV4IDY1MTExNWQuLjZlMWQ3YjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9ib19saXN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2JvX2xpc3QuYwpAQCAtMTMyLDcgKzEzMiwxMCBAQCBzdGF0aWMgaW50IGFtZGdw
dV9ib19saXN0X3NldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJZW50cnktPnByaW9y
aXR5ID0gbWluKGluZm9baV0uYm9fcHJpb3JpdHksCiAJCQkJICAgICAgQU1ER1BVX0JPX0xJU1Rf
TUFYX1BSSU9SSVRZKTsKIAkJZW50cnktPnR2LmJvID0gJmVudHJ5LT5yb2JqLT50Ym87Ci0JCWVu
dHJ5LT50di5zaGFyZWQgPSB0cnVlOworCQllbnRyeS0+dHYuc2hhcmVkID0gIWVudHJ5LT5yb2Jq
LT5wcmltZV9leHBvcnRlZDsKKworCQlpZiAoZW50cnktPnJvYmotPnByaW1lX2V4cG9ydGVkKQor
CQkgICAgRFJNX0RFQlVHX1BSSU1FKCJFeGNsdXNpdmUgZmVuY2UgZm9yIGV4cG9ydGVkIHByaW1l
IGJvICVwXG4iLCBlbnRyeS0+cm9iaik7CiAKIAkJaWYgKGVudHJ5LT5yb2JqLT5wcmVmZXJlZF9k
b21haW5zID09IEFNREdQVV9HRU1fRE9NQUlOX0dEUykKIAkJCWdkc19vYmogPSBlbnRyeS0+cm9i
ajsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYwppbmRleCBjZDYyZjZmLi41
NDA5OWE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2Vt
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCkBAIC01MDQs
NiArNTA0LDEyIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9nZW1fdmFfdXBkYXRlX3ZtKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LAogCiAJdHYuYm8gPSAmYm9fdmEtPmJvLT50Ym87CiAJdHYuc2hh
cmVkID0gdHJ1ZTsKKworCWlmIChib192YS0+Ym8tPnByaW1lX2V4cG9ydGVkKSB7CisJICAgIERS
TV9ERUJVR19QUklNRSgiVXBkYXRlIGZvciBleHBvcnRlZCBwcmltZSBibyAlcFxuIiwgYm9fdmEt
PmJvKTsKKwkgICAgLyogdHYuc2hhcmVkID0gZmFsc2U7ICovCisJfQorCiAJbGlzdF9hZGQoJnR2
LmhlYWQsICZsaXN0KTsKIAogCWFtZGdwdV92bV9nZXRfcGRfYm8oYm9fdmEtPnZtLCAmbGlzdCwg
JnZtX3BkKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9w
cmltZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ByaW1lLmMKaW5kZXgg
NzcwMGRjMi4uYmZiZmViOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ByaW1lLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3By
aW1lLmMKQEAgLTEyMSw1ICsxMjEsOCBAQCBzdHJ1Y3QgZG1hX2J1ZiAqYW1kZ3B1X2dlbV9wcmlt
ZV9leHBvcnQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIAlpZiAoYW1kZ3B1X3R0bV90dF9nZXRf
dXNlcm1tKGJvLT50Ym8udHRtKSkKIAkJcmV0dXJuIEVSUl9QVFIoLUVQRVJNKTsKIAorCWJvLT5w
cmltZV9leHBvcnRlZCA9IHRydWU7CisJRFJNX0RFQlVHX1BSSU1FKCJFeHBvcnRpbmcgcHJpbWUg
Ym8gJXBcbiIsIGJvKTsKKwogCXJldHVybiBkcm1fZ2VtX3ByaW1lX2V4cG9ydChkZXYsIGdvYmos
IGZsYWdzKTsKIH0K
--001a11471a14071c2f053ff127a8
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--001a11471a14071c2f053ff127a8--
