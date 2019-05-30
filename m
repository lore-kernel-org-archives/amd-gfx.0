From: Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>
Subject: drop drmP.h usage? [Was: [pull] amdgpu, amdkfd drm-next-5.3]
Date: Thu, 30 May 2019 08:30:29 +0200
Message-ID: <20190530063029.GA20000@ravnborg.org>
References: <20190529220944.14464-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190529220944.14464-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, daniel.vetter-/w4YWyX8dFk@public.gmane.org, airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

SGkgQWxleCBldCBhbGwuCgo+IC0gVmFyaW91cyBjbGVhbnVwcwoKQW55IGNoYW5jZSB0byBwZXJz
dWFkZSBvbmUgb2YgeW91IGd1eXMgdG8gc3dlZXAgdGhyb3VnaCB0aGUgYW1kIC8gcmFlZGVvbgp0
cmVlIGFuZCBkcm9wIHVzZSBvZiB0aGUgZGVwcmVjYXRlZCBoZWFkZXIgZHJtUC5oPwoKU3RhdHVz
IGF0IHRoZSBtb21lbnQgKGRybS1taXNjLW5leHQpOgokZ2l0IGdyZXAgZHJtUCB8IGN1dCAtZCAn
LycgLWYgMSAgfCB1bmlxIC1jIHwgc29ydCAtbiB8IHRhaWwgLW4gMTAKICAgICAxMSBtZXNvbgog
ICAgIDEyIG1lZGlhdGVrCiAgICAgMTMgdm13Z2Z4CiAgICAgMTUgcm9ja2NoaXAKICAgICAxNiBz
dGkKICAgICAxOCBzdW40aQogICAgIDI0IGV4eW5vcwogICAgIDI3IG5vdXZlYXUKICAgIDEwMyBy
YWRlb24KICAgIDExMCBhbWQKCm5vdXZlYXUgaXMgYWxyZWFkeSB0YWtlbiBjYXJlIG9mLCB0aGUg
Y2xlYW51cCBpcyBpbiB0aGVpciB0cmVlLgphbWQgYW5kIHJhZGVvbiBhcmUgdGhlIHR3byAid29y
c3QiIGRyaXZlcnMgaW4gdGhpcyByZXNwZWN0IGF0IHRoZQptb21lbnQuCgpUaGFua3MsCglTYW0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
