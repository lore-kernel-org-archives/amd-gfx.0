From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Update VM function point when VM state changed.
Date: Wed, 14 Aug 2019 17:06:24 +0200
Message-ID: <d21d6399-fe1d-72b1-167a-c117c2a34a6b@gmail.com>
References: <1565794853-25275-1-git-send-email-gaba@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1565794853-25275-1-git-send-email-gaba-5C7GfCeVMHo@public.gmane.org>
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
To: Gang Ba <gaba-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Ba, Gang" <Gang.Ba-5C7GfCeVMHo@public.gmane.org>

QW0gMTQuMDguMTkgdW0gMTc6MDEgc2NocmllYiBHYW5nIEJhOgo+IENoYW5nZS1JZDogSWJjZmFk
YTU2MGEwMGM5YWVlYmZkOTIyYWU0OGRlOTIwZTQ0YTU4NjYKPiBTaWduZWQtb2ZmLWJ5OiBHYW5n
IEJhIDxnYWJhQGFtZC5jb20+CgpHb29kIGNhdGNoLCBidXQgdGhlcmUgaXMgYSBwcm9ibGVtIGJl
bG93LgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwg
NiArKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gaW5kZXggYzFiYWYzZC4uNzJkZDQzNCAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTI4NjIsNiArMjg2
MiwxMiBAQCBpbnQgYW1kZ3B1X3ZtX21ha2VfY29tcHV0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sIHVucwo+ICAgCVdBUk5fT05DRSgodm0tPnVzZV9j
cHVfZm9yX3VwZGF0ZSAmJiAhYW1kZ3B1X2dtY192cmFtX2Z1bGxfdmlzaWJsZSgmYWRldi0+Z21j
KSksCj4gICAJCSAgIkNQVSB1cGRhdGUgb2YgVk0gcmVjb21tZW5kZWQgb25seSBmb3IgbGFyZ2Ug
QkFSIHN5c3RlbVxuIik7Cj4gICAKPiArCWlmICh2bS0+dXNlX2NwdV9mb3JfdXBkYXRlKQo+ICsJ
CXZtLT51cGRhdGVfZnVuY3MgPSAmYW1kZ3B1X3ZtX2NwdV9mdW5jczsKPiArCWVsc2UKPiArCQl2
bS0+dXBkYXRlX2Z1bmNzID0gJmFtZGdwdV92bV9zZG1hX2Z1bmNzOwo+ICsJdm0tPmxhc3RfdXBk
YXRlID0gTlVMTDsKCllvdSBjYW4ndCBqdXN0IHNldCBsYXN0X3VwZGF0ZSB0byBOVUxMIG9yIHlv
dXIgd291bGQgbGVhayB0aGUgbWVtb3J5IHRoZSAKZmVuY2Ugb2NjdXBpZXMuIFNvIHRoaXMgbmVl
ZHMgdG8gYmU6CgpkbWFfZmVuY2VfcHV0KHZtLT5sYXN0X3VwZGF0ZSk7CnZtLT5sYXN0X3VwZGF0
ZSA9IE5VTEw7CgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+ICsKPiAgIAlpZiAodm0tPnBhc2lkKSB7
Cj4gICAJCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
