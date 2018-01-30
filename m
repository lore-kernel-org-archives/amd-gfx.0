From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: Use drm_oom_badness for amdgpu.
Date: Tue, 30 Jan 2018 07:42:46 -0500
Message-ID: <1670268a-863f-2a95-fd1d-f59e5ebdfcb3@amd.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <1516294072-17841-5-git-send-email-andrey.grodzovsky@amd.com>
 <20180130092413.GD25930@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180130092413.GD25930-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

VGhhdCBkZWZpbml0ZWx5IHdoYXQgSSBwbGFubmVkLCBqdXN0IGRpZG4ndCB3YW50IHRvIGNsdXR0
ZXIgdGhlIFJGQyB3aXRoIAptdWx0aXBsZSByZXBlYXRlZCBjaGFuZ2VzLgoKVGhhbmtzLAoKQW5k
cmV5CgoKCk9uIDAxLzMwLzIwMTggMDQ6MjQgQU0sIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gT24g
VGh1LCBKYW4gMTgsIDIwMTggYXQgMTE6NDc6NTJBTSAtMDUwMCwgQW5kcmV5IEdyb2R6b3Zza3kg
d3JvdGU6Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRyZXkuZ3JvZHpv
dnNreUBhbWQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZHJ2LmMgfCAxICsKPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYwo+PiBpbmRleCA0NmEwYzkzLi42
YTczM2NkYzggMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kcnYuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMK
Pj4gQEAgLTgyOCw2ICs4MjgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9u
cyBhbWRncHVfZHJpdmVyX2ttc19mb3BzID0gewo+PiAgICNpZmRlZiBDT05GSUdfQ09NUEFUCj4+
ICAgCS5jb21wYXRfaW9jdGwgPSBhbWRncHVfa21zX2NvbXBhdF9pb2N0bCwKPj4gICAjZW5kaWYK
Pj4gKwkub29tX2ZpbGVfYmFkbmVzcyA9IGRybV9vb21fYmFkbmVzcywKPiBXb3VsZCBiZSBuZWF0
IGlmIHdlIGNvdWxkIHJvbGwgdGhpcyBvdXQgZm9yIGFsbCBnZW0gZHJpdmVycyAob25jZSBpdCdz
IG5vCj4gbG9uZ2VyIGFuIFJGQyBvZmMpLgo+IC1EYW5pZWwKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
