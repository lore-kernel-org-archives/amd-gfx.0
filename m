From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Temparary disable the sdma use pollmem
 feature for sriov.
Date: Fri, 19 Jan 2018 11:22:06 +0100
Message-ID: <ea823ba5-5bf5-8ef2-40eb-bf763e9300f8@gmail.com>
References: <1516356864-2622-1-git-send-email-Emily.Deng@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1516356864-2622-1-git-send-email-Emily.Deng-5C7GfCeVMHo@public.gmane.org>
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
To: Emily Deng <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTkuMDEuMjAxOCB1bSAxMToxNCBzY2hyaWViIEVtaWx5IERlbmc6Cj4gSXQgc3RpbGwgaGFz
IHNvbWUgc2VyaW91cyBpc3N1ZXMoZ3Vlc3QgZHJpdmVyIHJlbG9hZCBmYWlsLCBldGMpLAo+IHdo
ZW4gdXNlIHBvbGxtZW0gZmVhdHVyZSBmb3Igc2RtYTMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBFbWls
eSBEZW5nIDxFbWlseS5EZW5nQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3YzXzAuYyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjNfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92M18w
LmMKPiBpbmRleCAzZTIyYWU0Li4wZjhmNjE0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjNfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92M18wLmMKPiBAQCAtMTIwOSw3ICsxMjA5LDcgQEAgc3RhdGljIGludCBzZG1hX3Yz
XzBfc3dfaW5pdCh2b2lkICpoYW5kbGUpCj4gICAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnNkbWEu
bnVtX2luc3RhbmNlczsgaSsrKSB7Cj4gICAJCXJpbmcgPSAmYWRldi0+c2RtYS5pbnN0YW5jZVtp
XS5yaW5nOwo+ICAgCQlyaW5nLT5yaW5nX29iaiA9IE5VTEw7Cj4gLQkJaWYgKCFhbWRncHVfc3Jp
b3ZfdmYoYWRldikpIHsKPiArCQlpZiAoMSkgewoKVGhhdCBuZWVkcyBhIGNvbW1lbnQgd2h5IHdl
IGhhdmUgaXQgYW5kIEkgc3VnZ2VzdCB3cml0aW5nIHRoaXMgYXM6CgovKiBEaXNhYmxlZCBmb3Ig
bm93IGJlY2F1c2UuLi4gKi8KaWYgKHRydWUgLyogIWFtZGdwdV9zcmlvdl92ZihhZGV2KSAqLykK
ClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4gICAJCQlyaW5nLT51c2VfZG9vcmJlbGwgPSB0cnVlOwo+
ICAgCQkJcmluZy0+ZG9vcmJlbGxfaW5kZXggPSAoaSA9PSAwKSA/Cj4gICAJCQkJQU1ER1BVX0RP
T1JCRUxMX3NETUFfRU5HSU5FMCA6IEFNREdQVV9ET09SQkVMTF9zRE1BX0VOR0lORTE7CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
