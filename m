From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Thu, 26 Apr 2018 08:34:05 -0400
Message-ID: <611911a3-2858-200c-d5f8-679c5f41ee3a@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <874ljyu98e.fsf-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
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
To: "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
Cc: David.Panariti-5C7GfCeVMHo@public.gmane.org, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org

CgpPbiAwNC8yNS8yMDE4IDA4OjAxIFBNLCBFcmljIFcuIEJpZWRlcm1hbiB3cm90ZToKPiBBbmRy
ZXkgR3JvZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4gd3JpdGVzOgo+Cj4+IE9u
IDA0LzI1LzIwMTggMDE6MTcgUE0sIE9sZWcgTmVzdGVyb3Ygd3JvdGU6Cj4+PiBPbiAwNC8yNSwg
QW5kcmV5IEdyb2R6b3Zza3kgd3JvdGU6Cj4+Pj4gaGVyZSAoZHJtX3NjaGVkX2VudGl0eV9maW5p
KSBpcyBhbHNvIGEgYmFkIGlkZWEsIGJ1dCB3ZSBzdGlsbCB3YW50IHRvIGJlCj4+Pj4gYWJsZSB0
byBleGl0IGltbWVkaWF0ZWx5Cj4+Pj4gYW5kIG5vdCB3YWl0IGZvciBHUFUgam9icyBjb21wbGV0
aW9uIHdoZW4gdGhlIHJlYXNvbiBmb3IgcmVhY2hpbmcgdGhpcyBjb2RlCj4+Pj4gaXMgYmVjYXVz
ZSBvZiBLSUxMCj4+Pj4gc2lnbmFsIHRvIHRoZSB1c2VyIHByb2Nlc3Mgd2hvIG9wZW5lZCB0aGUg
ZGV2aWNlIGZpbGUuCj4+PiBDYW4geW91IGhvb2sgZl9vcC0+Zmx1c2ggbWV0aG9kPwo+PiBCdXQg
dGhpcyBvbmUgaXMgY2FsbGVkIGZvciBlYWNoIHRhc2sgcmVsZWFzaW5nIGEgcmVmZXJlbmNlIHRv
IHRoZSB0aGUgZmlsZSwgc28KPj4gbm90IHN1cmUgSSBzZWUgaG93IHRoaXMgc29sdmVzIHRoZSBw
cm9ibGVtLgo+IFRoZSBiaWcgcXVlc3Rpb24gaXMgd2h5IGRvIHlvdSBuZWVkIHRvIHdhaXQgZHVy
aW5nIHRoZSBmaW5hbCBjbG9zaW5nIGEKPiBmaWxlPwo+Cj4gVGhlIHdhaXQgY2FuIGJlIHRlcm1p
bmF0ZWQgc28gdGhlIHdhaXQgZG9lcyBub3QgYXBwZWFyIHRvIGJlIHNpbXBseSBhCj4gbWF0dGVy
IG9mIGNvcnJlY3RuZXNzLgoKV2VsbCwgYXMgSSB1bmRlcnN0YW5kIGl0LCBpdCBqdXN0IG1lYW5z
IHRoYXQgeW91IGRvbid0IHdhbnQgdG8gYWJydXB0bHkgCnRlcm1pbmF0ZSBHUFUgd29yayBpbiBw
cm9ncmVzcyB3aXRob3V0IGEgZ29vZApyZWFzb24gKHN1Y2ggYXMgS0lMTCBzaWduYWwpLiBXaGVu
IHdlIGV4aXQgd2UgYXJlIGdvaW5nIHRvIHJlbGVhc2UgCnZhcmlvdXMgcmVzb3VyY2VzIEdQVSBp
cyBzdGlsbCB1c2luZyBzbyB3ZSBlaXRoZXIKd2FpdCBmb3IgaXQgdG8gY29tcGxldGUgb3IgdGVy
bWluYXRlIHRoZSByZW1haW5pbmcgam9icy4KCkFuZHJleQoKPgo+IEVyaWMKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
