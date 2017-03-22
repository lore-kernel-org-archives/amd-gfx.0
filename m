From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] amdgpu: add new VA operations CLEAR and REPLACE
Date: Wed, 22 Mar 2017 11:04:25 +0800
Message-ID: <58D1E9B9.4090107@amd.com>
References: <1489730362-31095-1-git-send-email-Jerry.Zhang@amd.com>
 <1489730362-31095-2-git-send-email-Jerry.Zhang@amd.com>
 <ace47633-adf1-9055-5e08-1803f2f026c4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ace47633-adf1-9055-5e08-1803f2f026c4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?B?Tmljb2xhaSBIw6Robmxl?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: christian.koenig-5C7GfCeVMHo@public.gmane.org, nicolai.haehnle-5C7GfCeVMHo@public.gmane.org

T24gMDMvMjEvMjAxNyAwOTozMCBQTSwgTmljb2xhaSBIw6RobmxlIHdyb3RlOgo+IFRoaXMgc2hv
dWxkIHVzZSB0aGUgcHJvcGVyIHByb2NlZHVyZSBmb3IgdXBkYXRpbmcgYW1kZ3B1X2RybS5oLCBh
cyBleHBsYWluZWQgaW4KPiBpbmNsdWRlL2RybS9SRUFETUUuIEkgY2FuIHRha2UgY2FyZSBvZiB0
aGlzIGFzIHNvb24gYXMgYWxsIHRoZSBrZXJuZWwgcGF0Y2hlcwo+IGZvciBQUlQgYXJlIGluIGEg
dHJlZSB0aGF0IGRvZXNuJ3QgcmViYXNlIChpLmUuIGFnZDVmL2RybS1uZXh0LTQuMTIgb3IKPiBh
aXJsaWVkL2RybS1uZXh0KS4KClRoYW5rcywgZ290IGl0LgoKSmVycnkKPgo+IE5pY29sYWkKPgo+
IE9uIDE3LjAzLjIwMTcgMDY6NTksIEp1bndlaSBaaGFuZyB3cm90ZToKPj4gU2lnbmVkLW9mZi1i
eTogSnVud2VpIFpoYW5nIDxKZXJyeS5aaGFuZ0BhbWQuY29tPgo+PiAtLS0KPj4gIGluY2x1ZGUv
ZHJtL2FtZGdwdV9kcm0uaCB8IDIgKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykKPj4KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJtL2FtZGdwdV9kcm0uaCBiL2luY2x1ZGUv
ZHJtL2FtZGdwdV9kcm0uaAo+PiBpbmRleCA3MDAyZGM0Li5hNzNiNDBhIDEwMDY0NAo+PiAtLS0g
YS9pbmNsdWRlL2RybS9hbWRncHVfZHJtLmgKPj4gKysrIGIvaW5jbHVkZS9kcm0vYW1kZ3B1X2Ry
bS5oCj4+IEBAIC00MTAsNiArNDEwLDggQEAgc3RydWN0IGRybV9hbWRncHVfZ2VtX29wIHsKPj4K
Pj4gICNkZWZpbmUgQU1ER1BVX1ZBX09QX01BUCAgICAgICAgICAgIDEKPj4gICNkZWZpbmUgQU1E
R1BVX1ZBX09QX1VOTUFQICAgICAgICAgICAgMgo+PiArI2RlZmluZSBBTURHUFVfVkFfT1BfQ0xF
QVIgICAgICAgICAgICAzCj4+ICsjZGVmaW5lIEFNREdQVV9WQV9PUF9SRVBMQUNFICAgICAgICAg
ICAgNAo+Pgo+PiAgLyogRGVsYXkgdGhlIHBhZ2UgdGFibGUgdXBkYXRlIHRpbGwgdGhlIG5leHQg
Q1MgKi8KPj4gICNkZWZpbmUgQU1ER1BVX1ZNX0RFTEFZX1VQREFURSAgICAgICAgKDEgPDwgMCkK
Pj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
