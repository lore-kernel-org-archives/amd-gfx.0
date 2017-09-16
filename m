From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: disable hard reset in hibernate for APUs
Date: Sat, 16 Sep 2017 14:18:41 +0200
Message-ID: <91e94ecd-4e65-abb6-99d6-19601b78ae38@gmail.com>
References: <1505499768-602-1-git-send-email-alexander.deucher@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505499768-602-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMTUuMDkuMjAxNyB1bSAyMDoyMiBzY2hyaWViIEFsZXggRGV1Y2hlcjoKPiBGaXhlcyBhIGhp
YmVybmF0aW9uIHJlZ3Jlc3Npb24gb24gQVBVcy4KPgo+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5r
ZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0xOTE1NzEKPiBGaXhlczogMjc0YWQ2NWM5ZDAyYmRj
IChkcm0vcmFkZW9uOiBoYXJkIHJlc2V0IHI2MDAgYW5kIG5ld2VyIEdQVSB3aGVuIGhpYmVybmF0
aW5nLikKPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFt
ZC5jb20+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgoKPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+IC0tLQo+ICAgZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2RldmljZS5jCj4gaW5kZXggOTk3MTMxZC4uZmZjMTBjYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX2RldmljZS5jCj4gQEAgLTE2NjMsNyArMTY2Myw3IEBAIGludCByYWRlb25f
c3VzcGVuZF9rbXMoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgYm9vbCBzdXNwZW5kLAo+ICAgCXJh
ZGVvbl9hZ3Bfc3VzcGVuZChyZGV2KTsKPiAgIAo+ICAgCXBjaV9zYXZlX3N0YXRlKGRldi0+cGRl
dik7Cj4gLQlpZiAoZnJlZXplICYmIHJkZXYtPmZhbWlseSA+PSBDSElQX0NFREFSKSB7Cj4gKwlp
ZiAoZnJlZXplICYmIHJkZXYtPmZhbWlseSA+PSBDSElQX0NFREFSICYmICEocmRldi0+ZmxhZ3Mg
JiBSQURFT05fSVNfSUdQKSkgewo+ICAgCQlyZGV2LT5hc2ljLT5hc2ljX3Jlc2V0KHJkZXYsIHRy
dWUpOwo+ICAgCQlwY2lfcmVzdG9yZV9zdGF0ZShkZXYtPnBkZXYpOwo+ICAgCX0gZWxzZSBpZiAo
c3VzcGVuZCkgewoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
