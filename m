From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: Fix hard hang for S/G display BOs.
Date: Wed, 24 Jul 2019 09:43:32 +0200
Message-ID: <8e1b34f3-46b3-b252-3fa5-9a489ec8c35c@daenzer.net>
References: <1563897851-11501-1-git-send-email-andrey.grodzovsky@amd.com>
 <1563897851-11501-2-git-send-email-andrey.grodzovsky@amd.com>
 <d4c126b7-4fa5-19ff-6687-9a260927dc67@daenzer.net>
 <ced516f5-546d-cd49-6e0e-87d2528bde41@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ced516f5-546d-cd49-6e0e-87d2528bde41-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "S,
 Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wNy0yMyA3OjMxIHAubS4sIEdyb2R6b3Zza3ksIEFuZHJleSB3cm90ZToKPiBPbiA3
LzIzLzE5IDEyOjE4IFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4KPj4gQW55d2F5LCB0aGlz
IHNob3VsZCBiZSBoYW5kbGVkIGluIGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zCj4+
IGluc3RlYWQgKGUuZy4gYnkgbm90IGFsbG93aW5nIEdUVCBpZiBDT05GSUdfWDg2XzMyIGlzIGRl
ZmluZWQpLAo+IAo+IAo+IFdlIGhhdmUgZHJtX2FyY2hfY2FuX3djX21lbW9yeSBmdW5jdGlvbiB0
byBjb3ZlciBhbGwgdGhlIGNhc2VzIHdoZW4gVVNXQyAKPiBtYXBwaW5nIGlzIG5vdCBhbGxvd2Vk
LCB3aHkgdGhlIENPTkZJR19YODZfMzIgaGVyZSA/CgpJdCdzIG9uZSBjYXNlIHdoZXJlIGFtZGdw
dV9ib19kb19jcmVhdGUoKSBjbGVhcnMgdGhlCkFNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNX
QyBmbGFnLgoKCj4+IG90aGVyd2lzZSB0aGUgQk8gY291bGQgc3RpbGwgYmUgcGlubmVkIHRvIEdU
VCBsYXRlci4KPiAKPiBUaGUgb25seSBvdGhlciBsYXRlciBwbGFjZSBJIGtub3cgaXMgZG1fcGxh
bmVfaGVscGVyX3ByZXBhcmVfZmIgb2Ygd2hpY2ggCj4gSSB0YWtlIGNhcmUgaW4gcGF0Y2ggMy4g
V2hhdCBvdGhlciBwbGFjZXMgeW91IGhhdmUgaW4gbWluZCA/CgphbWRncHVfZG1hX2J1Zl9iZWdp
bl9jcHVfYWNjZXNzICYgYW1kZ3B1X21vZGVfZHVtYl9jcmVhdGUuIChXaGlsZSBub3QKaGFuZGxp
bmcgaXQgdGhlcmUgcHJvYmFibHkgd29uJ3QgY2F1c2UgaGFuZ3MsIGl0J2QgbGlrZWx5IHJlc3Vs
dCBpbgpzdXBlcmZsdW91cyBCTyBtaWdyYXRpb25zKQoKQnV0IGV2ZW4gaWYgdGhlcmUgd2VyZSBu
byBvdGhlciBwbGFjZXMgcmlnaHQgbm93LCBoYW5kbGluZyBpdCBzZXBhcmF0ZWx5CndvdWxkIGJl
IGZyYWdpbGUgV1JUIGZ1dHVyZSBhbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucyBjYWxs
ZXJzCmdldHRpbmcgaXQgd3JvbmcuCgpBbnl3YXksIHlvdSdyZSBhdHRlbXB0aW5nIHRvIGhhbmRs
ZSBpdCBpbgphbWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucyBpbiB0aGUgdjIgc2VyaWVz
LCB0aGFua3MuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgIGh0dHBzOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
