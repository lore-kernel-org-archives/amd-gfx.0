From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH -next] drm/amdkfd: Make function kfd_dev_is_large_bar()
 static
Date: Tue, 24 Apr 2018 12:13:35 +0300
Message-ID: <CAFCwf13NW33eX4T9hYyLJ1Q8Yk+1hdmyfkDTaD2AY=05Ce6VaA@mail.gmail.com>
References: <1522376727-136554-1-git-send-email-weiyongjun1@huawei.com>
 <623cef28-530e-21af-e90c-64905f5c84b5@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <623cef28-530e-21af-e90c-64905f5c84b5-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gTW9uLCBBcHIgMiwgMjAxOCBhdCA5OjAzIFBNLCBGZWxpeCBLdWVobGluZyA8ZmVsaXgua3Vl
aGxpbmdAYW1kLmNvbT4gd3JvdGU6Cj4gVGhpcyBwYXRjaCBpcyBSZXZpZXdlZC1ieTogRmVsaXgg
S3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+Cj4KPgo+IE9uIDIwMTgtMDMtMjkgMTA6
MjUgUE0sIFdlaSBZb25nanVuIHdyb3RlOgo+PiBGaXhlcyB0aGUgZm9sbG93aW5nIHNwYXJzZSB3
YXJuaW5nOgo+Pgo+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jOjEx
NTA6Njogd2FybmluZzoKPj4gIHN5bWJvbCAna2ZkX2Rldl9pc19sYXJnZV9iYXInIHdhcyBub3Qg
ZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFdlaSBZ
b25nanVuIDx3ZWl5b25nanVuMUBodWF3ZWkuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgfCAyICstCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfY2hhcmRldi5jCj4+IGluZGV4IGNkNjc5Y2YuLmZiNWQ5OTcgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2NoYXJkZXYuYwo+PiBAQCAtMTE0Nyw3ICsxMTQ3LDcg
QEAgc3RhdGljIGludCBrZmRfaW9jdGxfYWNxdWlyZV92bShzdHJ1Y3QgZmlsZSAqZmlsZXAsIHN0
cnVjdCBrZmRfcHJvY2VzcyAqcCwKPj4gICAgICAgcmV0dXJuIHJldDsKPj4gIH0KPj4KPj4gLWJv
b2wga2ZkX2Rldl9pc19sYXJnZV9iYXIoc3RydWN0IGtmZF9kZXYgKmRldikKPj4gK3N0YXRpYyBi
b29sIGtmZF9kZXZfaXNfbGFyZ2VfYmFyKHN0cnVjdCBrZmRfZGV2ICpkZXYpCj4+ICB7Cj4+ICAg
ICAgIHN0cnVjdCBrZmRfbG9jYWxfbWVtX2luZm8gbWVtX2luZm87Cj4+Cj4KVGhhbmtzLCBhbHJl
YWR5IGFwcGxpZWQgdGhlIGZpeCBmcm9tIHRoZSBrYnVpbGQgcm9ib3QuCk9kZWQKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
