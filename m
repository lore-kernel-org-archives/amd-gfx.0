From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] drm/amdgpu: extend profiling mode.
Date: Wed, 11 Jan 2017 22:46:32 +0000
Message-ID: <5876B5C8.1010401@gmail.com>
References: <1483944700-3842-1-git-send-email-Rex.Zhu@amd.com>
 <1483944700-3842-4-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483944700-3842-4-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UmV4IFpodSB3cm90ZToKPiBpbiBwcm9maWxpbmcgbW9kZSwgcG93ZXJwbGF5IHdpbGwgZml4IHBv
d2VyIHN0YXRlCj4gYXMgc3RhYmxlIGFzIHBvc3NpYmxlLmFuZCBkaXNhYmxlIGdmeCBjZyBhbmQg
TEJQVyBmZWF0dXJlLgo+Cj4gcHJvZmlsZV9zdGFuZGFyZDogYXMgYSBwcmVyZXF1aXNpdGUsIGVu
c3VyZSBwb3dlciBhbmQgdGhlcm1hbAo+IHN1c3RhaW5hYmxlLCBzZXQgY2xvY2tzIHJhdGlvIGFz
IGNsb3NlIHRvIHRoZSBoaWdoZXN0IGNsb2NrCj4gcmF0aW8gYXMgcG9zc2libGUuCj4gcHJvZmls
ZV9taW5fc2NsazogZml4IG1jbGsgYXMgcHJvZmlsZV9ub3JtYWwsIHNldCBsb3dlc3Qgc2Nsawo+
IHByb2ZpbGVfbWluX21jbGs6IGZpeCBzY2xrIGFzIHByb2ZpbGVfbm9ybWFsLCBzZXQgbG93ZXN0
IG1jbGsKPiBwcm9maWxlX3BlYWs6IHNldCBoaWdoZXN0IHNjbGsgYW5kIG1jbGssIHBvd2VyIGFu
ZCB0aGVybWFsIG5vdAo+IHN1c3RhaW5hYmxlCj4gcHJvZmlsZV9leGl0OiBleGl0IHByb2ZpbGUg
bW9kZS4gZW5hYmxlIGdmeCBjZy9sYnB3IGZlYXR1cmUuCgpUZXN0aW5nIFI5IDI4NSBUb25nYSBv
biBkcm0tbmV4dC00LjExLXdpcAoKVGhpcyBjb21taXQgaGFzIHRoZSBlZmZlY3QgdGhhdCBkb2lu
ZwoKZWNobyBoaWdoID4gL3N5cy9jbGFzcy9kcm0vY2FyZDAvZGV2aWNlL3Bvd2VyX2RwbV9mb3Jj
ZV9wZXJmb3JtYW5jZV9sZXZlbAoKaW5zdGFudGx5IGZvcmNlcyBmYW4gdG8gKEkgZ3Vlc3MpIG1h
eCwgd2hlcmUgbm9ybWFsbHkgaXQgZG9lc24ndApuZWVkIGFueXRoaW5nIGxpa2UgYXMgZmFzdCB3
aXRoIHRoZSBjbG9ja3MgaGlnaCB3aGVuIGRvaW5nIG5vdGhpbmcgZWxzZS4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
