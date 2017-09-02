From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: remove memset before memcpy
Date: Sat, 2 Sep 2017 15:39:59 +0300
Message-ID: <CAFCwf11po8eqAMwx6yT9gZpDEUcmf9=jSqMw-74PxVXzS64RYQ@mail.gmail.com>
References: <1504033415-25608-1-git-send-email-himanshujha199640@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1504033415-25608-1-git-send-email-himanshujha199640-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Himanshu Jha <himanshujha199640-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

T24gVHVlLCBBdWcgMjksIDIwMTcgYXQgMTA6MDMgUE0sIEhpbWFuc2h1IEpoYQo8aGltYW5zaHVq
aGExOTk2NDBAZ21haWwuY29tPiB3cm90ZToKPiBjYWxsaW5nIG1lbWNweSBpbW1lZGlhdGVseSBh
ZnRlciBtZW1zZXQgd2l0aCB0aGUgc2FtZSByZWdpb24gb2YgbWVtb3J5Cj4gbWFrZXMgbWVtc2V0
IHJlZHVuZGFudC4KPgo+IFNpZ25lZC1vZmYtYnk6IEhpbWFuc2h1IEpoYSA8aGltYW5zaHVqaGEx
OTk2NDBAZ21haWwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMgfCAxIC0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRp
b24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzc19xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzc19xdWV1ZV9tYW5hZ2VyLmMKPiBpbmRleCAxY2FlOTVlLi4wM2JlYzc2IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21hbmFnZXIu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzX3F1ZXVlX21h
bmFnZXIuYwo+IEBAIC0xNDMsNyArMTQzLDYgQEAgaW50IHBxbV9jcmVhdGVfcXVldWUoc3RydWN0
IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLAo+ICAgICAgICAgaW50IG51bV9xdWV1ZXMgPSAw
Owo+ICAgICAgICAgc3RydWN0IHF1ZXVlICpjdXI7Cj4KPiAtICAgICAgIG1lbXNldCgmcV9wcm9w
ZXJ0aWVzLCAwLCBzaXplb2Yoc3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMpKTsKPiAgICAgICAgIG1l
bWNweSgmcV9wcm9wZXJ0aWVzLCBwcm9wZXJ0aWVzLCBzaXplb2Yoc3RydWN0IHF1ZXVlX3Byb3Bl
cnRpZXMpKTsKPiAgICAgICAgIHEgPSBOVUxMOwo+ICAgICAgICAga3EgPSBOVUxMOwo+IC0tCj4g
Mi43LjQKPgoKVGhhbmtzIQpBcHBsaWVkIHRvIGFtZGtmZCAtbmV4dCB0cmVlCgpPZGVkCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
