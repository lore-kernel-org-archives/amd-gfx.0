From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 02/11] drm/amdgpu: validate the VM root PD from the VM code
Date: Thu, 23 Aug 2018 10:46:18 +0800
Message-ID: <5B7E1FFA.7010503@amd.com>
References: <20180822150517.2330-1-christian.koenig@amd.com>
 <20180822150517.2330-2-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180822150517.2330-2-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UGF0Y2ggMiB+IDYgYXJlCgpSZXZpZXdlZC1ieTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0Bh
bWQuY29tPgoKSmVycnkKCk9uIDA4LzIyLzIwMTggMTE6MDUgUE0sIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6Cj4gUHJlcGFyYXRpb24gZm9yIGZvbGxvd2luZyBjaGFuZ2VzLiBUaGlzIHZhbGlkYXRl
cyB0aGUgcm9vdCBQRCB0d2ljZSwKPiBidXQgdGhlIG92ZXJoZWFkIG9mIHRoYXQgc2hvdWxkIGJl
IG1pbmltYWwuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyB8IDggKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
IGluZGV4IDczYjhkY2FmNjZlNi4uNTNjZTk5ODJhNWVlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBAQCAtMjkxLDExICsyOTEsMTEgQEAgaW50IGFtZGdwdV92
bV92YWxpZGF0ZV9wdF9ib3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBhbWRn
cHVfdm0gKnZtLAo+ICAgCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShib19iYXNlLCB0bXAsICZ2
bS0+ZXZpY3RlZCwgdm1fc3RhdHVzKSB7Cj4gICAJCXN0cnVjdCBhbWRncHVfYm8gKmJvID0gYm9f
YmFzZS0+Ym87Cj4KPiAtCQlpZiAoYm8tPnBhcmVudCkgewo+IC0JCQlyID0gdmFsaWRhdGUocGFy
YW0sIGJvKTsKPiAtCQkJaWYgKHIpCj4gLQkJCQlicmVhazsKPiArCQlyID0gdmFsaWRhdGUocGFy
YW0sIGJvKTsKPiArCQlpZiAocikKPiArCQkJYnJlYWs7Cj4KPiArCQlpZiAoYm8tPnBhcmVudCkg
ewo+ICAgCQkJc3Bpbl9sb2NrKCZnbG9iLT5scnVfbG9jayk7Cj4gICAJCQl0dG1fYm9fbW92ZV90
b19scnVfdGFpbCgmYm8tPnRibyk7Cj4gICAJCQlpZiAoYm8tPnNoYWRvdykKPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
