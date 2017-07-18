From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/ttm: Implement vm_operations_struct.access v2
Date: Tue, 18 Jul 2017 10:21:37 -0400
Message-ID: <29a8a358-3afd-a854-3041-e4282da9f313@daenzer.net>
References: <1500350223-4913-1-git-send-email-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1500350223-4913-1-git-send-email-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTcvMDcvMTcgMTE6NTcgUE0sIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IEFsbG93cyBnZGIg
dG8gYWNjZXNzIGNvbnRlbnRzIG9mIHVzZXIgbW9kZSBtYXBwZWQgQk9zLiBTeXN0ZW0gbWVtb3J5
Cj4gaXMgaGFuZGxlZCBieSBUVE0gdXNpbmcga21hcC4gT3RoZXIgbWVtb3J5IHBvb2xzIHJlcXVp
cmUgYSBuZXcgZHJpdmVyCj4gY2FsbGJhY2sgaW4gdHRtX2JvX2RyaXZlci4KPiAKPiB2MjoKPiAq
IGttYXAgb25seSBvbmUgcGFnZSBhdCBhIHRpbWUKPiAqIHN3YXAgaW4gQk8gaWYgbmVlZGVkCj4g
KiBtYWtlIGRyaXZlciBjYWxsYmFjayBtb3JlIGdlbmVyaWMgdG8gaGFuZGxlIHByaXZhdGUgbWVt
b3J5IHBvb2xzCj4gKiBkb2N1bWVudCBjYWxsYmFjayByZXR1cm4gdmFsdWUKPiAqIFdBUk5fT04g
LT4gV0FSTl9PTl9PTkNFCj4gCj4gU2lnbmVkLW9mZi1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4
Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5k
YWVuemVyQGFtZC5jb20+CgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50
aHVzaWFzdCAgICAgICAgICB8ICAgICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
