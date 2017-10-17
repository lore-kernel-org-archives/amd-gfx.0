From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Trigger bug when allocation fails.
Date: Tue, 17 Oct 2017 19:26:06 -0400
Message-ID: <2253fac9-e831-d489-f73d-96c38eb445c4@amd.com>
References: <20171017174554.13930-1-tom.stdenis@amd.com>
 <d035e531-09e5-0307-4340-7c96685dc60e@gmail.com>
 <49649733-17eb-4d9a-a523-340be9a6a0e2@amd.com>
 <13db5809-f805-7289-f901-3d675b24faf5@amd.com>
 <ef080a5a-f1f2-e386-defd-c5c72fd61d33@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ef080a5a-f1f2-e386-defd-c5c72fd61d33-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0xMC0xNyAwNjowNSBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4gCj4gCj4g
T24gMTAvMTcvMjAxNyAwNToxMSBQTSwgVG9tIFN0IERlbmlzIHdyb3RlOgo+PiBJJ20gb2sgd2l0
aCBub3QgcHVzaGluZyBteSBjb21taXQgYW5kIHNpbXBseSBhZGRpbmcgYW4gZWxzZSBicmFuY2gg
dGhhdCBzZXRzIHRoZSBwb2ludGVyIHRvIE5VTEwuCj4+Cj4+IChtYXliZSBwdXQgYSBXQVJOX09O
IHRvIGdpdmUgY29udGV4dD8pCj4gCj4gU2VlbXMgcmVhc29uYWJsZSB0byBtZS4KPiBIYXJyeSA/
Cj4gCgpTdXJlLgoKSGFycnkKCj4gQW5kcmV5Cj4gCj4+Cj4+IFRvbQo+Pgo+PiBPbiAxNy8xMC8x
NyAwNDo0MiBQTSwgQW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDEwLzE3
LzIwMTcgMDQ6MTIgUE0sIE5pY29sYWkgSMOkaG5sZSB3cm90ZToKPj4+PiBPbiAxNy4xMC4yMDE3
IDE5OjQ1LCBUb20gU3QgRGVuaXMgd3JvdGU6Cj4+Pj4+IElmIHRoZSBhbGxvY2F0aW9uIGZhaWxz
IGluIGFtZGdwdV9kbV9jb25uZWN0b3JfZnVuY3NfcmVzZXQoKSB0aGUKPj4+Pj4gQVBJIGNhbm5v
dCBjb250aW51ZSBzbyB0cmlnZ2VyIGEgQlVHX09OLgo+Pj4+Cj4+Pj4gVGhhdCBzZWVtcyBxdWVz
dGlvbmFibGUgdG8gYmUgaG9uZXN0LiBUaGUgZHJtX2F0b21pY19oZWxwZXIgdmVyc2lvbiBvZiB0
aGlzIGZ1bmN0aW9uIGVuZHMgdXAgc2V0dGluZyBjb25uZWN0b3ItPnN0YXRlID0gTlVMTDsgaW4g
dGhpcyBjYXNlLgo+Pj4KPj4+IEkgc2VlIGl0IG5vdywgaXQgd2lsbCBwcm9wYWdhdGUgYmFjayB0
byB1c2VyIG1vZGUgYXMgLUVOT01FTSwgc28gaSBndWVzcyBpdCdzIGdvb2QganVzdCBzZXQgaXQg
YXMgTlVMTC4KPj4+Cj4+PiBUaGFua3MsCj4+PiBBbmRyZXkKPj4+Cj4+Pj4KPj4+PiBDaGVlcnMs
Cj4+Pj4gTmljb2xhaQo+Pj4+Cj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFRvbSBTdCBEZW5p
cyA8dG9tLnN0ZGVuaXNAYW1kLmNvbT4KPj4+Pj4gLS0tCj4+Pj4+IMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAxICsKPj4+Pj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+Pj4+PiBpbmRleCA1OGUyOWEy
YTVjYTYuLmFjNThiYTRmMTBjZiAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+Pj4+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4+Pj4+IEBAIC0yNzIyLDYgKzI3
MjIsNyBAQCB2b2lkIGFtZGdwdV9kbV9jb25uZWN0b3JfZnVuY3NfcmVzZXQoc3RydWN0IGRybV9j
b25uZWN0b3IgKmNvbm5lY3RvcikKPj4+Pj4gwqDCoMKgwqDCoCBrZnJlZShzdGF0ZSk7Cj4+Pj4+
IMKgwqDCoMKgwqDCoMKgIHN0YXRlID0ga3phbGxvYyhzaXplb2YoKnN0YXRlKSwgR0ZQX0tFUk5F
TCk7Cj4+Pj4+ICvCoMKgwqAgQlVHX09OKHN0YXRlID09IE5VTEwpOwo+Pj4+PiDCoMKgwqDCoMKg
wqDCoCBpZiAoc3RhdGUpIHsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXRlLT5zY2FsaW5n
ID0gUk1YX09GRjsKPj4+Pj4KPj4+Pgo+Pj4+Cj4+Pgo+Pgo+IApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
