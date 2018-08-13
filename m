From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 2/2] [RFC] amdgpu: do not free flink bo for flink_fd
Date: Mon, 13 Aug 2018 11:03:51 +0800
Message-ID: <5B70F517.1010406@amd.com>
References: <1533877508-27480-1-git-send-email-Jerry.Zhang@amd.com>
 <1533877508-27480-2-git-send-email-Jerry.Zhang@amd.com>
 <78d960c7-6feb-9ca0-c6c8-b335a06e8f21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <78d960c7-6feb-9ca0-c6c8-b335a06e8f21-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDgvMTAvMjAxOCAxMDoyMCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAxMC4w
OC4yMDE4IHVtIDA3OjA1IHNjaHJpZWIgSnVud2VpIFpoYW5nOgo+PiB0aGUgZmxpbmsgYm8gaXMg
dXNlZCB0byBleHBvcnQKPgo+IFdoeSBzaG91bGQgd2UgZG8gdGhpcz8gVGhhdCBtYWtlcyBubyBz
ZW5zZSwgdGhpcyB3YXkgd2Ugd291bGQgY3JlYXRlIGEgbWVtb3J5IGxlYWsuCgpHZXQgdGhlIHRo
b3VnaHQgZnJvbSBib19pbXBvcnQgY29kZSwgYnV0IG5lZ2xlY3RlZCB0aGUgZGV0YWlsIG9mIERS
TV9JT0NUTF9HRU1fQ0xPU0UgSU9DVEwsCnRoYXQgd2lsbCByZW1vdmUgdGhlIGJvIGhhbmRsZSBm
cm9tIGZpbHAtPm9iamVjdF9pZHIgcmF0aGVyIHRoYW4gZmlscC0+ZGV2LT5vYmplY3RfbmFtZV9p
ZHIuClRoZW4gbWFrZSBzZW5zZSBub3cuIFNvcnJ5IGZvciB0aGUgbm9pc2UuCgpKZXJyeQoKPgo+
IENocmlzdGlhbi4KPgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKdW53ZWkgWmhhbmcgPEplcnJ5Llpo
YW5nQGFtZC5jb20+Cj4+IC0tLQo+PiAgIGFtZGdwdS9hbWRncHVfYm8uYyB8IDYgLS0tLS0tCj4+
ICAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9hbWRn
cHUvYW1kZ3B1X2JvLmMgYi9hbWRncHUvYW1kZ3B1X2JvLmMKPj4gaW5kZXggNmYwYmFmMS4uNWI5
MWNmYyAxMDA2NDQKPj4gLS0tIGEvYW1kZ3B1L2FtZGdwdV9iby5jCj4+ICsrKyBiL2FtZGdwdS9h
bWRncHVfYm8uYwo+PiBAQCAtMjE5LDEyICsyMTksNiBAQCBzdGF0aWMgaW50IGFtZGdwdV9ib19l
eHBvcnRfZmxpbmsoYW1kZ3B1X2JvX2hhbmRsZSBibykKPj4gICAgICAgYm8tPmZsaW5rX25hbWUg
PSBmbGluay5uYW1lOwo+PiAtICAgIGlmIChiby0+ZGV2LT5mbGlua19mZCAhPSBiby0+ZGV2LT5m
ZCkgewo+PiAtICAgICAgICBzdHJ1Y3QgZHJtX2dlbV9jbG9zZSBhcmdzID0ge307Cj4+IC0gICAg
ICAgIGFyZ3MuaGFuZGxlID0gaGFuZGxlOwo+PiAtICAgICAgICBkcm1Jb2N0bChiby0+ZGV2LT5m
bGlua19mZCwgRFJNX0lPQ1RMX0dFTV9DTE9TRSwgJmFyZ3MpOwo+PiAtICAgIH0KPj4gLQo+PiAg
ICAgICBwdGhyZWFkX211dGV4X2xvY2soJmJvLT5kZXYtPmJvX3RhYmxlX211dGV4KTsKPj4gICAg
ICAgciA9IGhhbmRsZV90YWJsZV9pbnNlcnQoJmJvLT5kZXYtPmJvX2ZsaW5rX25hbWVzLCBiby0+
ZmxpbmtfbmFtZSwgYm8pOwo+PiAgICAgICBwdGhyZWFkX211dGV4X3VubG9jaygmYm8tPmRldi0+
Ym9fdGFibGVfbXV0ZXgpOwo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
