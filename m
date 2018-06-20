From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] dma-buf: remove kmap_atomic interface
Date: Wed, 20 Jun 2018 16:04:20 +0200
Message-ID: <5d337ffc-6c4c-dafb-abb2-151d9d4aeaea@gmail.com>
References: <20180601120020.11520-1-christian.koenig@amd.com>
 <20180601120020.11520-2-christian.koenig@amd.com>
 <20180618081845.GV3438@phenom.ffwll.local>
 <2bcb34c3-b729-e3ea-fb8c-2471e4ed56d6@amd.com>
 <CAKMK7uEvhMF92ifA=7xQ=9GR3NofZNExCDTHZTtikmujJTZ89A@mail.gmail.com>
 <c0552d8a-1c64-c99b-6ef8-83e253c49d30@gmail.com>
 <CAKMK7uHHZn=H6px-yiXy7tVmmQy6GHrwGtG+B7or1ThsrriFDA@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------A5D8D9BBDF0CC7F56BB3F0B4"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAKMK7uHHZn=H6px-yiXy7tVmmQy6GHrwGtG+B7or1ThsrriFDA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
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
To: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is a multi-part message in MIME format.
--------------A5D8D9BBDF0CC7F56BB3F0B4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.06.2018 um 14:52 schrieb Daniel Vetter:
> On Wed, Jun 20, 2018 at 2:46 PM, Christian König
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> [SNIP]
>>> Go ahead, that's the point of commit rights. dim might complain if you
>>> cherry picked them and didn't pick them up using dim apply though ...
>>
>> I've fixed up the Link tags, but when I try "dim push-branch drm-misc-next"
>> I only get the error message "error: dst ref refs/heads/drm-misc-next
>> receives from more than one src."
>>
>> Any idea what is going wrong here?
> Sounds like multiple upstreams for your local drm-misc-next branch,
> and git then can't decide which one to pick. If you delete the branch
> and create it using dim checkout drm-misc-next this shouldn't happen.
> We're trying to fit into existing check-outs and branches, but if you
> set things up slightly different than dim would have you're off script
> and there's limited support for that.
>
> Alternative check out your .git/config and remove the other upstreams.
> Or attach your git config if this isn't the issue (I'm just doing some
> guessing here).

I've tried to delete my drm-misc-next branch and recreate it, but that 
doesn't seem to help.

Attached is my .git/config, but at least on first glance it looks ok as 
well.

Any ideas?

Thanks,
Christian.

> -Daniel
>
>


--------------A5D8D9BBDF0CC7F56BB3F0B4
Content-Type: text/plain; charset=UTF-8;
 name="config"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="config"

W2NvcmVdCglyZXBvc2l0b3J5Zm9ybWF0dmVyc2lvbiA9IDAKCWZpbGVtb2RlID0gdHJ1ZQoJ
YmFyZSA9IGZhbHNlCglsb2dhbGxyZWZ1cGRhdGVzID0gdHJ1ZQpbcmVtb3RlICJvcmlnaW4i
XQoJdXJsID0gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdAoJZmV0Y2ggPSArcmVmcy9oZWFkcy8qOnJlZnMvcmVtb3Rl
cy9vcmlnaW4vKgpbYnJhbmNoICJtYXN0ZXIiXQoJcmVtb3RlID0gb3JpZ2luCgltZXJnZSA9
IHJlZnMvaGVhZHMvbWFzdGVyCltyZW1vdGUgImRybS10aXAiXQoJdXJsID0gc3NoOi8vZ2l0
LmZyZWVkZXNrdG9wLm9yZy9naXQvZHJtLXRpcAoJZmV0Y2ggPSArcmVmcy9oZWFkcy8qOnJl
ZnMvcmVtb3Rlcy9kcm0tdGlwLyoKW2JyYW5jaCAibWFpbnRhaW5lci10b29scyJdCglyZW1v
dGUgPSBkcm0tdGlwCgltZXJnZSA9IHJlZnMvaGVhZHMvbWFpbnRhaW5lci10b29scwpbYnJh
bmNoICJyZXJlcmUtY2FjaGUiXQoJcmVtb3RlID0gZHJtLXRpcAoJbWVyZ2UgPSByZWZzL2hl
YWRzL3JlcmVyZS1jYWNoZQpbYnJhbmNoICJkcm0tdGlwIl0KCXJlbW90ZSA9IGRybS10aXAK
CW1lcmdlID0gcmVmcy9oZWFkcy9kcm0tdGlwCltyZW1vdGUgImFpcmxpZWQiXQoJdXJsID0g
Z2l0Oi8vcGVvcGxlLmZyZWVkZXNrdG9wLm9yZy9+YWlybGllZC9saW51eAoJZmV0Y2ggPSAr
cmVmcy9oZWFkcy8qOnJlZnMvcmVtb3Rlcy9haXJsaWVkLyoKW3JlbW90ZSAic291bmQiXQoJ
dXJsID0gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rp
d2FpL3NvdW5kLmdpdAoJZmV0Y2ggPSArcmVmcy9oZWFkcy8qOnJlZnMvcmVtb3Rlcy9zb3Vu
ZC8qCltyZW1vdGUgImRybS1pbnRlbCJdCgl1cmwgPSBzc2g6Ly9naXQuZnJlZWRlc2t0b3Au
b3JnL2dpdC9kcm0vZHJtLWludGVsCglmZXRjaCA9ICtyZWZzL2hlYWRzLyo6cmVmcy9yZW1v
dGVzL2RybS1pbnRlbC8qCltyZW1vdGUgImRybS1hbWQiXQoJdXJsID0gc3NoOi8vZ2l0LmZy
ZWVkZXNrdG9wLm9yZy9naXQvZHJtL2RybS1hbWQKCWZldGNoID0gK3JlZnMvaGVhZHMvKjpy
ZWZzL3JlbW90ZXMvZHJtLWFtZC8qCltyZW1vdGUgImRybSJdCgl1cmwgPSBzc2g6Ly9naXQu
ZnJlZWRlc2t0b3Aub3JnL2dpdC9kcm0vZHJtCglmZXRjaCA9ICtyZWZzL2hlYWRzLyo6cmVm
cy9yZW1vdGVzL2RybS8qCltyZW1vdGUgImRybS1taXNjIl0KCXVybCA9IHNzaDovL2dpdC5m
cmVlZGVza3RvcC5vcmcvZ2l0L2RybS9kcm0tbWlzYwoJZmV0Y2ggPSArcmVmcy9oZWFkcy8q
OnJlZnMvcmVtb3Rlcy9kcm0tbWlzYy8qCltyZW1vdGUgImJha2VyIl0KCXVybCA9IHNzaDov
L2Jha2VyLmxvY2FsL3Vzci9zcmMvbGludXgKCWZldGNoID0gK3JlZnMvaGVhZHMvKjpyZWZz
L3JlbW90ZXMvYmFrZXIvKgpbYnJhbmNoICJkcm0tbWlzYy1uZXh0Il0KCXJlbW90ZSA9IGRy
bS1taXNjCgltZXJnZSA9IHJlZnMvaGVhZHMvZHJtLW1pc2MtbmV4dAo=
--------------A5D8D9BBDF0CC7F56BB3F0B4
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------A5D8D9BBDF0CC7F56BB3F0B4--
