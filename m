From: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] drm/scheduler: add dynamic balancing
Date: Tue, 31 Jul 2018 16:07:32 +0530
Message-ID: <20180731103736.7813-1-nayan26deshmukh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Nayan Deshmukh <nayan26deshmukh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org

VGhpcyBpcyB0aGUgbXkgZmlyc3QgYXR0ZW1wdCB0byBpbmNsdWRlIGR5bmFtaWMgYmFsYW5jaW5n
IGFzIHBhcnQKb2YgdGhlIHNjaGVkdWxlci4gSSBoYXZlIHRyaWVkIHRvIGhhbmRsZSB0aGUgZWFz
eSBjYXNlcyBmaXJzdCB0bwpnZXQgdGhlIGJhc2ljIGltcGxlbWVudGF0aW9uIHJ1bm5pbmcuCgpQ
bGVhc2Ugc2hhcmUgeW91ciB0aG91Z2h0cyEhCgoqKiogQkxVUkIgSEVSRSAqKioKCk5heWFuIERl
c2htdWtoICg0KToKICBkcm0vc2NoZWR1bGVyOiBhZGQgYSBsaXN0IG9mIHJ1biBxdWV1ZXMgdG8g
dGhlIGVudGl0eQogIGRybS9zY2hlZHVsZXI6IGFkZCBjb3VudGVyIGZvciB0b3RhbCBqb2JzIGlu
IHNjaGVkdWxlcgogIGRybS9zY2hlZHVsZXI6IGFkZCBuZXcgZnVuY3Rpb24gdG8gZ2V0IGxlYXN0
IGxvYWRlZCBzY2hlZAogIGRybS9zY2hlZHVsZXI6IG1vdmUgaWRsZSBlbnRpdGllcyB0byBzY2hl
ZHVsZXIgd2l0aCBsZXNzIGxvYWQKCiBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL2dwdV9zY2hl
ZHVsZXIuYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KIGluY2x1ZGUvZHJt
L2dwdV9zY2hlZHVsZXIuaCAgICAgICAgICAgICAgIHwgIDkgKysrKy0KIDIgZmlsZXMgY2hhbmdl
ZCwgNjUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCi0tIAoyLjE0LjMKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
