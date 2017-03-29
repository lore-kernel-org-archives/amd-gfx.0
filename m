From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: drivers/gpu/drm/radeon/r100.c:3303]: (style) Redundant condition
Date: Wed, 29 Mar 2017 18:09:49 -0400
Message-ID: <CADnq5_MBC2ZEC4kUWU4Q_wz1Nzz3mtyZE9wibh6ZpFRaX9jM8g@mail.gmail.com>
References: <HE1PR0801MB1865D31CD715BAE301A5143C9C330@HE1PR0801MB1865.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=94eb2c19ac20cd0ba3054be5d53f
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <HE1PR0801MB1865D31CD715BAE301A5143C9C330-TrivKwPZaC6VEZXSXRKha0dOKmgb957onBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "alexander.deucher-5C7GfCeVMHo@public.gmane.org" <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>

--94eb2c19ac20cd0ba3054be5d53f
Content-Type: text/plain; charset=UTF-8

On Mon, Mar 27, 2017 at 6:07 AM, David Binderman <dcb314-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hello there,
>
> linux-4.11-rc4/drivers/gpu/drm/radeon/r100.c:3303]: (style) Redundant condition: If 'EXPR == 11', the comparison 'EXPR <= 12' is always true.
>
> Source code is
>
>     } else if (rdev->family == CHIP_RV350 ||
>            rdev->family <= CHIP_RV380) {
>

Fixed in the attached patch.


> Also in the same file:
>
> [drivers/gpu/drm/radeon/r100.c:2550]: (style) Variable 'tmp' is assigned a value
>  that is never used.
> [drivers/gpu/drm/radeon/r100.c:2875]: (style) Variable 'tmp' is assigned a value
>  that is never used.

These are intended.  The registers are read back to to post the previous write.

Alex

--94eb2c19ac20cd0ba3054be5d53f
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-drm-radeon-fix-typo-in-bandwidth-calculation.patch"
Content-Disposition: attachment;
	filename="0001-drm-radeon-fix-typo-in-bandwidth-calculation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j0vix39s0

RnJvbSBiYzAyYmU1NmVmYTRjMTQ3NjIyYzY5Y2ZjMjc3MmI5YTExNmFiNWY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFdlZCwgMjkgTWFyIDIwMTcgMTg6MDM6MjcgLTA0MDAKU3ViamVjdDogW1BBVENI
XSBkcm0vcmFkZW9uOiBmaXggdHlwbyBpbiBiYW5kd2lkdGggY2FsY3VsYXRpb24KClRoZSBSVjN4
eCBzZXR0aW5ncyB3ZXJlIGdldHRpbmcgYXBwbGllZCB0byBhbGwgb2xkZXIgYXNpY3MKcmF0aGVy
IHRoYW4ganVzdCBSVjN4eC4KClJlcG9ydGVkLWJ5OiBEYXZpZCBCaW5kZXJtYW4gPGRjYjMxNEBo
b3RtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjEwMC5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yMTAwLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Ix
MDAuYwppbmRleCBlMzM5OTMxLi44MzQ0OTQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3IxMDAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3IxMDAuYwpAQCAtMzMw
MSw3ICszMzAxLDcgQEAgdm9pZCByMTAwX2JhbmR3aWR0aF91cGRhdGUoc3RydWN0IHJhZGVvbl9k
ZXZpY2UgKnJkZXYpCiAJCW1lbV90cnAgPSAoKHRlbXAgPj4gOCkgJiAweDcpICsgMTsKIAkJbWVt
X3RyYXMgPSAoKHRlbXAgPj4gMTEpICYgMHhmKSArIDQ7CiAJfSBlbHNlIGlmIChyZGV2LT5mYW1p
bHkgPT0gQ0hJUF9SVjM1MCB8fAotCQkgICByZGV2LT5mYW1pbHkgPD0gQ0hJUF9SVjM4MCkgewor
CQkgICByZGV2LT5mYW1pbHkgPT0gQ0hJUF9SVjM4MCkgewogCQkvKiBydjN4MCAqLwogCQltZW1f
dHJjZCA9ICh0ZW1wICYgMHg3KSArIDM7CiAJCW1lbV90cnAgPSAoKHRlbXAgPj4gOCkgJiAweDcp
ICsgMzsKLS0gCjIuNS41Cgo=
--94eb2c19ac20cd0ba3054be5d53f
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--94eb2c19ac20cd0ba3054be5d53f--
