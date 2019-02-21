From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: s2idle not working
Date: Thu, 21 Feb 2019 01:31:44 -0500
Message-ID: <CADnq5_Oxy_16yGqcfy8eyOYMaCkdL6d_Ny3qZTXdKi3bizwc1A@mail.gmail.com>
References: <CAHD83Qc9D5L-B-2R9nYWtckK=WrKkw9Hha5dwDqWt4DCAhAPSQ@mail.gmail.com>
 <CAHD83Qdhw5Jn1Wh1Q52i5UoGMCmNqnYXV=DqmZWCB28606U1iw@mail.gmail.com>
 <CADnq5_N9okwWV0B+D9p6p9D6DPToGpk_a1LbH9xFSTcxVXXA2Q@mail.gmail.com>
 <CAHD83QdHAd5Q5HCiOOg4JU2g9=Bp3uGzTstQY2sst7xQt+jFNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000823970058261a19a"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAHD83QdHAd5Q5HCiOOg4JU2g9=Bp3uGzTstQY2sst7xQt+jFNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--000000000000823970058261a19a
Content-Type: text/plain; charset="UTF-8"

On Wed, Feb 20, 2019 at 11:56 PM shahul hameed
<shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi All,
>
> I did below exoeriments:
>
> -> S2idle is working in software rendering mode(disable AMDGPU driver).
>
> -> For experiment purpose i commented suspend/resume calls of amdgpu driver, in this case S2idle worked.
>
> With above experiments it is clear that my platform supports s2idel.
> Some issue in AMDGPU suspend/resume sequence for s2idle.
> So can you please help me.

I'd suggest filing a bug (https://bugs.freedesktop.org) and attaching
your full dmesg output.  I'm not too familiar with s2idle and what
pmops paths it uses.  I suspect what is happening is that the power is
not getting fully cut the the device when s2idle is invoked, and it's
left in a bad state on resume.  Maybe something like the attached
patch might help.  That said, if the platform is not properly cutting
power to the device at s2idle time, you probably aren't saving any
power anyway.

Alex

>
> Thanks & Regards,
> Sk shahul.
>
> On Thu, Feb 21, 2019 at 3:32 AM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>
>> On Wed, Feb 20, 2019 at 4:59 PM shahul hameed
>> <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >
>> > Hi
>> >
>> > I am facing below issue. Can any one please help me to resolve it.
>>
>> As I mentioned previously, please make sure the platform supports
>> s2idle and that it is enabled in the sbios.  Does s2idle work on other
>> devices and the platform itself?
>>
>> Alex
>>
>> >
>> > Regards,
>> > Sk shahul
>> >
>> > ---------- Forwarded message ---------
>> > From: shahul hameed <shahulhameed.481-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> > Date: Wed, Feb 20, 2019, 3:13 PM
>> > Subject: s2idle not working
>> > To: <shirish.s-5C7GfCeVMHo@public.gmane.org>
>> >
>> >
>> > Hi Shirish
>> >
>> > I am porting Android_N and keenel 4.19.2 to Ryzen platform. Graphic card is gfx9.
>> > Porting is done successfully. Now i am working on suspend/resume.
>> > Suspend/resume is working fine in deep mode.
>> > But suspend/resume is not working in s2idle (Suspend to idle) mode.
>> >
>> > during resume i found error in gpu driver.
>> >
>> > [  105.862161] [drm:gfx_v9_0_hw_init [amdgpu]] *ERROR* KCQ enable failed (scratch(0xC040)=0xCAFEDEAD)
>> > [  105.862187] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v9_0> failed -22
>> > [  105.862210] [drm:amdgpu_device_resume [amdgpu]] *ERROR* amdgpu_device_ip_resume failed (-22).
>> > [  105.862215] dpm_run_callback(): pci_pm_resume+0x0/0xd6 returns -22
>> > [  105.862345] PM: Device 0000:03:00.0 failed to resume async: error -22
>> >
>> > same issue is reproduced with ubuntu16.04.
>> >
>> > Can you please help me to resolve this issue.
>> > Thanks in Advance,
>> > Regards,
>> > Sk shahul.
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--000000000000823970058261a19a
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amdgpu-possibly-reset-device-on-resume.patch"
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-possibly-reset-device-on-resume.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jse8xled0>
X-Attachment-Id: f_jse8xled0

RnJvbSA4YTUwNmUwMjZjMDkxM2IxYjBlZmFiODljYjAzYmY4MWFkMWIzYTc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMjEgRmViIDIwMTkgMDE6MjQ6MTUgLTA1MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vYW1kZ3B1OiBwb3NzaWJseSByZXNldCBkZXZpY2Ugb24gcmVzdW1lCgpJZiB0aGUgZGV2
aWNlIHdhcyBsZWZ0IGluIGEgYmFkIHN0YXRlIG9uIHJlc3VtZSBmb3JtIHN1c3BlbmQKYXR0ZW1w
dCB0byByZXNldCB0aGUgR1BVLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IGZjYWIxZmU5
YmI2OC4uNmFiMmZiM2MwYzUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCkBAIC0yODk2LDYgKzI4OTYsMTIgQEAgaW50IGFtZGdwdV9kZXZpY2VfcmVzdW1l
KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIGJvb2wgcmVzdW1lLCBib29sIGZiY29uKQogCQkJcmV0
dXJuIHI7CiAJfQogCisJaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRldikgJiYgYW1kZ3B1X2FzaWNf
bmVlZF9yZXNldF9vbl9pbml0KGFkZXYpKSB7CisJCXIgPSBhbWRncHVfYXNpY19yZXNldChhZGV2
KTsKKwkJaWYgKHIpCisJCQlyZXR1cm4gcjsKKwl9CisKIAkvKiBwb3N0IGNhcmQgKi8KIAlpZiAo
YW1kZ3B1X2RldmljZV9uZWVkX3Bvc3QoYWRldikpIHsKIAkJciA9IGFtZGdwdV9hdG9tX2FzaWNf
aW5pdChhZGV2LT5tb2RlX2luZm8uYXRvbV9jb250ZXh0KTsKLS0gCjIuMjAuMQoK
--000000000000823970058261a19a
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--000000000000823970058261a19a--
