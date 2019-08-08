From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: The issue with page allocation 5.3 rc1-rc2 (seems drm culprit here)
Date: Thu, 8 Aug 2019 01:31:50 -0400
Message-ID: <CADnq5_O08v3_NUZ_zUZJFYwv_tUY7TFFz2GGudqgWEX6nh5LFA@mail.gmail.com>
References: <20190806014830.7424-1-hdanton@sina.com> <CABXGCsMRGRpd9AoJdvZqdpqCP3QzVGzfDPiX=PzVys6QFBLAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="00000000000097c52f058f94601e"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABXGCsMRGRpd9AoJdvZqdpqCP3QzVGzfDPiX=PzVys6QFBLAvA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Dave Airlie <airlied@gmail.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Linux Memory Management List <linux-mm@kvack.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--00000000000097c52f058f94601e
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 7, 2019 at 11:49 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, 6 Aug 2019 at 06:48, Hillf Danton <hdanton@sina.com> wrote:
> >
> > My bad, respin with one header file added.
> >
> > Hillf
> > -----8<---
> >
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> > @@ -23,6 +23,7 @@
> >   */
> >
> >  #include <linux/slab.h>
> > +#include <linux/mm.h>
> >
> >  #include "dm_services.h"
> >
> > @@ -1174,8 +1175,12 @@ struct dc_state *dc_create_state(struct
> >         struct dc_state *context = kzalloc(sizeof(struct dc_state),
> >                                            GFP_KERNEL);
> >
> > -       if (!context)
> > -               return NULL;
> > +       if (!context) {
> > +               context = kvzalloc(sizeof(struct dc_state),
> > +                                          GFP_KERNEL);
> > +               if (!context)
> > +                       return NULL;
> > +       }
> >         /* Each context must have their own instance of VBA and in order to
> >          * initialize and obtain IP and SOC the base DML instance from DC is
> >          * initially copied into every context
> > @@ -1195,8 +1200,13 @@ struct dc_state *dc_copy_state(struct dc
> >         struct dc_state *new_ctx = kmemdup(src_ctx,
> >                         sizeof(struct dc_state), GFP_KERNEL);
> >
> > -       if (!new_ctx)
> > -               return NULL;
> > +       if (!new_ctx) {
> > +               new_ctx = kvmalloc(sizeof(*new_ctx), GFP_KERNEL);
> > +               if (new_ctx)
> > +                       *new_ctx = *src_ctx;
> > +               else
> > +                       return NULL;
> > +       }
> >
> >         for (i = 0; i < MAX_PIPES; i++) {
> >                         struct pipe_ctx *cur_pipe = &new_ctx->res_ctx.pipe_ctx[i];
> > @@ -1230,7 +1240,7 @@ static void dc_state_free(struct kref *k
> >  {
> >         struct dc_state *context = container_of(kref, struct dc_state, refcount);
> >         dc_resource_state_destruct(context);
> > -       kfree(context);
> > +       kvfree(context);
> >  }
> >
> >  void dc_release_state(struct dc_state *context)
> > --
> >
>
> Unfortunately error "gnome-shell: page allocation failure: order:4,
> mode:0x40cc0(GFP_KERNEL|__GFP_COMP),
> nodemask=(null),cpuset=/,mems_allowed=0" still happens even with
> applying this patch.

I think we can just drop the kmalloc altogether.  How about this patch?

Alex

>
> Thanks.
>
>
> --
> Best Regards,
> Mike Gavrilov.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000097c52f058f94601e
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-drm-amd-display-use-kvmalloc-for-dc_state.patch"
Content-Disposition: attachment;
	filename="0001-drm-amd-display-use-kvmalloc-for-dc_state.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jz28unhl0>
X-Attachment-Id: f_jz28unhl0

RnJvbSBjM2JhNmYwNWNhM2UwMzcxMjU0ZmJmYjFhOGMwNjI3NGUzY2RiOTZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgOCBBdWcgMjAxOSAwMDoyOToyMyAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRybS9hbWQvZGlzcGxheTogdXNlIGt2bWFsbG9jIGZvciBkY19zdGF0ZQoKSXQncyBsYXJnZSBh
bmQgZG9lc24ndCBuZWVkIGNvbnRpZ3VvdXMgbWVtb3J5LgoKU2lnbmVkLW9mZi1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCA5ICsrKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGMuYwppbmRleCAyNTJiNjIxZDkzYTkuLmVmNzgwYTRlNDg0YSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYworKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCkBAIC0yMyw2ICsyMyw3IEBACiAgKi8K
IAogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRlIDxsaW51eC9tbS5oPgogCiAjaW5j
bHVkZSAiZG1fc2VydmljZXMuaCIKIApAQCAtMTE4Myw4ICsxMTg0LDggQEAgYm9vbCBkY19wb3N0
X3VwZGF0ZV9zdXJmYWNlc190b19zdHJlYW0oc3RydWN0IGRjICpkYykKIAogc3RydWN0IGRjX3N0
YXRlICpkY19jcmVhdGVfc3RhdGUoc3RydWN0IGRjICpkYykKIHsKLQlzdHJ1Y3QgZGNfc3RhdGUg
KmNvbnRleHQgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgZGNfc3RhdGUpLAotCQkJCQkgICBHRlBf
S0VSTkVMKTsKKwlzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQgPSBrdnphbGxvYyhzaXplb2Yoc3Ry
dWN0IGRjX3N0YXRlKSwKKwkJCQkJICAgIEdGUF9LRVJORUwpOwogCiAJaWYgKCFjb250ZXh0KQog
CQlyZXR1cm4gTlVMTDsKQEAgLTEyMDQsMTEgKzEyMDUsMTEgQEAgc3RydWN0IGRjX3N0YXRlICpk
Y19jcmVhdGVfc3RhdGUoc3RydWN0IGRjICpkYykKIHN0cnVjdCBkY19zdGF0ZSAqZGNfY29weV9z
dGF0ZShzdHJ1Y3QgZGNfc3RhdGUgKnNyY19jdHgpCiB7CiAJaW50IGksIGo7Ci0Jc3RydWN0IGRj
X3N0YXRlICpuZXdfY3R4ID0ga21lbWR1cChzcmNfY3R4LAotCQkJc2l6ZW9mKHN0cnVjdCBkY19z
dGF0ZSksIEdGUF9LRVJORUwpOworCXN0cnVjdCBkY19zdGF0ZSAqbmV3X2N0eCA9IGt2bWFsbG9j
KHNpemVvZihzdHJ1Y3QgZGNfc3RhdGUpLCBHRlBfS0VSTkVMKTsKIAogCWlmICghbmV3X2N0eCkK
IAkJcmV0dXJuIE5VTEw7CisJbWVtY3B5KG5ld19jdHgsIHNyY19jdHgsIHNpemVvZihzdHJ1Y3Qg
ZGNfc3RhdGUpKTsKIAogCWZvciAoaSA9IDA7IGkgPCBNQVhfUElQRVM7IGkrKykgewogCQkJc3Ry
dWN0IHBpcGVfY3R4ICpjdXJfcGlwZSA9ICZuZXdfY3R4LT5yZXNfY3R4LnBpcGVfY3R4W2ldOwot
LSAKMi4yMC4xCgo=
--00000000000097c52f058f94601e--
