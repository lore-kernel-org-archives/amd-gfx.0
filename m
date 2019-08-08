From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit
 here)
Date: Thu, 8 Aug 2019 10:26:20 -0400
Message-ID: <CADnq5_P=gtz_8vNyV7At73PngbNS_-cyAnpd3aKGPUFyrK64EA@mail.gmail.com>
References: <20190806014830.7424-1-hdanton@sina.com>
 <CABXGCsMRGRpd9AoJdvZqdpqCP3QzVGzfDPiX=PzVys6QFBLAvA@mail.gmail.com>
 <CADnq5_O08v3_NUZ_zUZJFYwv_tUY7TFFz2GGudqgWEX6nh5LFA@mail.gmail.com>
 <6d5110ab-6539-378d-f643-0a1d4cf0ff73@daenzer.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0000000000002e1b8c058f9bd85e"
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <6d5110ab-6539-378d-f643-0a1d4cf0ff73@daenzer.net>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Hillf Danton <hdanton@sina.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux Memory Management List <linux-mm@kvack.org>, dri-devel <dri-devel@lists.freedesktop.org>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--0000000000002e1b8c058f9bd85e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2019 at 4:13 AM Michel D=C3=A4nzer <michel@daenzer.net> wrot=
e:
>
> On 2019-08-08 7:31 a.m., Alex Deucher wrote:
> > On Wed, Aug 7, 2019 at 11:49 PM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> >>
> >> Unfortunately error "gnome-shell: page allocation failure: order:4,
> >> mode:0x40cc0(GFP_KERNEL|__GFP_COMP),
> >> nodemask=3D(null),cpuset=3D/,mems_allowed=3D0" still happens even with
> >> applying this patch.
> >
> > I think we can just drop the kmalloc altogether.  How about this patch?
>
> Memory allocated by kvz/malloc needs to be freed with kvfree.
>

Yup, good catch.  Updated patch attached.

Alex

--0000000000002e1b8c058f9bd85e
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amd-display-use-kvmalloc-for-dc_state-v2.patch"
Content-Disposition: attachment;
	filename="0001-drm-amd-display-use-kvmalloc-for-dc_state-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz2ry4ps0>
X-Attachment-Id: f_jz2ry4ps0

RnJvbSA1YzI3YzI1Y2U3OWFjMmIxOGEzN2JjZDdkYzZmYTBiZDNkODczM2QzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgOCBBdWcgMjAxOSAwMDoyOToyMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWQvZGlzcGxheTogdXNlIGt2bWFsbG9jIGZvciBkY19zdGF0ZSAodjIpCgpJdCdzIGxh
cmdlIGFuZCBkb2Vzbid0IG5lZWQgY29udGlndW91cyBtZW1vcnkuCgp2Mjoga3ZmcmVlIHRoZSBt
ZW1vcnkuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyB8IDEx
ICsrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCmluZGV4IDI1MmI2
MjFkOTNhOS4uMjFmYjdlZTE3YzljIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvY29yZS9kYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjLmMKQEAgLTIzLDYgKzIzLDcgQEAKICAqLwogCiAjaW5jbHVkZSA8bGludXgvc2xhYi5o
PgorI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAKICNpbmNsdWRlICJkbV9zZXJ2aWNlcy5oIgogCkBA
IC0xMTgzLDggKzExODQsOCBAQCBib29sIGRjX3Bvc3RfdXBkYXRlX3N1cmZhY2VzX3RvX3N0cmVh
bShzdHJ1Y3QgZGMgKmRjKQogCiBzdHJ1Y3QgZGNfc3RhdGUgKmRjX2NyZWF0ZV9zdGF0ZShzdHJ1
Y3QgZGMgKmRjKQogewotCXN0cnVjdCBkY19zdGF0ZSAqY29udGV4dCA9IGt6YWxsb2Moc2l6ZW9m
KHN0cnVjdCBkY19zdGF0ZSksCi0JCQkJCSAgIEdGUF9LRVJORUwpOworCXN0cnVjdCBkY19zdGF0
ZSAqY29udGV4dCA9IGt2emFsbG9jKHNpemVvZihzdHJ1Y3QgZGNfc3RhdGUpLAorCQkJCQkgICAg
R0ZQX0tFUk5FTCk7CiAKIAlpZiAoIWNvbnRleHQpCiAJCXJldHVybiBOVUxMOwpAQCAtMTIwNCwx
MSArMTIwNSwxMSBAQCBzdHJ1Y3QgZGNfc3RhdGUgKmRjX2NyZWF0ZV9zdGF0ZShzdHJ1Y3QgZGMg
KmRjKQogc3RydWN0IGRjX3N0YXRlICpkY19jb3B5X3N0YXRlKHN0cnVjdCBkY19zdGF0ZSAqc3Jj
X2N0eCkKIHsKIAlpbnQgaSwgajsKLQlzdHJ1Y3QgZGNfc3RhdGUgKm5ld19jdHggPSBrbWVtZHVw
KHNyY19jdHgsCi0JCQlzaXplb2Yoc3RydWN0IGRjX3N0YXRlKSwgR0ZQX0tFUk5FTCk7CisJc3Ry
dWN0IGRjX3N0YXRlICpuZXdfY3R4ID0ga3ZtYWxsb2Moc2l6ZW9mKHN0cnVjdCBkY19zdGF0ZSks
IEdGUF9LRVJORUwpOwogCiAJaWYgKCFuZXdfY3R4KQogCQlyZXR1cm4gTlVMTDsKKwltZW1jcHko
bmV3X2N0eCwgc3JjX2N0eCwgc2l6ZW9mKHN0cnVjdCBkY19zdGF0ZSkpOwogCiAJZm9yIChpID0g
MDsgaSA8IE1BWF9QSVBFUzsgaSsrKSB7CiAJCQlzdHJ1Y3QgcGlwZV9jdHggKmN1cl9waXBlID0g
Jm5ld19jdHgtPnJlc19jdHgucGlwZV9jdHhbaV07CkBAIC0xMjQyLDcgKzEyNDMsNyBAQCBzdGF0
aWMgdm9pZCBkY19zdGF0ZV9mcmVlKHN0cnVjdCBrcmVmICprcmVmKQogewogCXN0cnVjdCBkY19z
dGF0ZSAqY29udGV4dCA9IGNvbnRhaW5lcl9vZihrcmVmLCBzdHJ1Y3QgZGNfc3RhdGUsIHJlZmNv
dW50KTsKIAlkY19yZXNvdXJjZV9zdGF0ZV9kZXN0cnVjdChjb250ZXh0KTsKLQlrZnJlZShjb250
ZXh0KTsKKwlrdmZyZWUoY29udGV4dCk7CiB9CiAKIHZvaWQgZGNfcmVsZWFzZV9zdGF0ZShzdHJ1
Y3QgZGNfc3RhdGUgKmNvbnRleHQpCi0tIAoyLjIwLjEKCg==
--0000000000002e1b8c058f9bd85e
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--0000000000002e1b8c058f9bd85e--
