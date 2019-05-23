From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 01/10] drm/ttm: Make LRU removal optional.
Date: Thu, 23 May 2019 11:39:12 +0200
Message-ID: <7ab46454-17c1-c293-6215-e865798ffaa0@gmail.com>
References: <20190522125947.4592-1-christian.koenig@amd.com>
 <fbb023f9-28e7-2ac8-994f-e262da597098@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fbb023f9-28e7-2ac8-994f-e262da597098-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>, Marek.Olsak-5C7GfCeVMHo@public.gmane.org, David1.Zhou-5C7GfCeVMHo@public.gmane.org, Prike.Liang-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjMuMDUuMTkgdW0gMTE6MTUgc2NocmllYiB6aG91Y20xOgo+IE9uIDIwMTnlubQwNeaciDIy
5pelIDIwOjU5LCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBbU05JUF0KPj4gQEAgLTIwMyw3
ICsyMDQsMTAgQEAgdm9pZCB0dG1fZXVfZmVuY2VfYnVmZmVyX29iamVjdHMoc3RydWN0IAo+PiB3
d19hY3F1aXJlX2N0eCAqdGlja2V0LAo+PiByZXNlcnZhdGlvbl9vYmplY3RfYWRkX3NoYXJlZF9m
ZW5jZShiby0+cmVzdiwgZmVuY2UpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBlbHNlCj4+IHJlc2VydmF0aW9uX29iamVjdF9hZGRfZXhjbF9mZW5jZShiby0+cmVzdiwgZmVu
Y2UpOwo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0dG1fYm9fYWRkX3RvX2xydShi
byk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChsaXN0X2VtcHR5KCZiby0+
bHJ1KSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR0
bV9ib19hZGRfdG9fbHJ1KGJvKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxz
ZQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHRtX2Jv
X21vdmVfdG9fbHJ1X3RhaWwoYm8sIE5VTEwpOwo+IGNhbiB0dG1fYm9fbW92ZV90b19scnVfdGFp
bCBiZSBtb3ZlZCB0byB0dG1fZXVfcmVzZXJ2ZV9idWZmZXJzIHdoZW4gCj4gZGVsX2xydSBpcyBm
YWxzZT8KCk5vLCB0aGF0IHdvbid0IHdvcmsuCgpUaGUgQk8gbWlnaHQgaGF2ZSBtb3ZlZCB0byBh
bm90aGVyIGRvbWFpbiBhbmQgd2hlbiB3ZSBoYXZlIHRoZSAKdHRtX2JvX21vdmVfdG9fbHJ1X3Rh
aWwoKSBpbiB0aGUgcmVzZXJ2YXRpb24gd2Ugd29uJ3QgYmUgaGFuZGxpbmcgdGhpcyAKY29ycmVj
dGx5LgoKQ2hyaXN0aWFuLgoKPgo+IC1EYXZpZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
