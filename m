From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Thu, 26 Apr 2018 08:52:34 -0400
Message-ID: <d6754c66-afe8-db2a-5633-d33701e22f3c@amd.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
 <611911a3-2858-200c-d5f8-679c5f41ee3a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <611911a3-2858-200c-d5f8-679c5f41ee3a-5C7GfCeVMHo@public.gmane.org>
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

CgpPbiAwNC8yNi8yMDE4IDA4OjM0IEFNLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPgo+Cj4g
T24gMDQvMjUvMjAxOCAwODowMSBQTSwgRXJpYyBXLiBCaWVkZXJtYW4gd3JvdGU6Cj4+IEFuZHJl
eSBHcm9kem92c2t5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPiB3cml0ZXM6Cj4+Cj4+PiBP
biAwNC8yNS8yMDE4IDAxOjE3IFBNLCBPbGVnIE5lc3Rlcm92IHdyb3RlOgo+Pj4+IE9uIDA0LzI1
LCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4+Pj4gaGVyZSAoZHJtX3NjaGVkX2VudGl0eV9m
aW5pKSBpcyBhbHNvIGEgYmFkIGlkZWEsIGJ1dCB3ZSBzdGlsbCB3YW50IAo+Pj4+PiB0byBiZQo+
Pj4+PiBhYmxlIHRvIGV4aXQgaW1tZWRpYXRlbHkKPj4+Pj4gYW5kIG5vdCB3YWl0IGZvciBHUFUg
am9icyBjb21wbGV0aW9uIHdoZW4gdGhlIHJlYXNvbiBmb3IgcmVhY2hpbmcgCj4+Pj4+IHRoaXMg
Y29kZQo+Pj4+PiBpcyBiZWNhdXNlIG9mIEtJTEwKPj4+Pj4gc2lnbmFsIHRvIHRoZSB1c2VyIHBy
b2Nlc3Mgd2hvIG9wZW5lZCB0aGUgZGV2aWNlIGZpbGUuCj4+Pj4gQ2FuIHlvdSBob29rIGZfb3At
PmZsdXNoIG1ldGhvZD8KPj4+IEJ1dCB0aGlzIG9uZSBpcyBjYWxsZWQgZm9yIGVhY2ggdGFzayBy
ZWxlYXNpbmcgYSByZWZlcmVuY2UgdG8gdGhlIAo+Pj4gdGhlIGZpbGUsIHNvCj4+PiBub3Qgc3Vy
ZSBJIHNlZSBob3cgdGhpcyBzb2x2ZXMgdGhlIHByb2JsZW0uCj4+IFRoZSBiaWcgcXVlc3Rpb24g
aXMgd2h5IGRvIHlvdSBuZWVkIHRvIHdhaXQgZHVyaW5nIHRoZSBmaW5hbCBjbG9zaW5nIGEKPj4g
ZmlsZT8KPj4KPj4gVGhlIHdhaXQgY2FuIGJlIHRlcm1pbmF0ZWQgc28gdGhlIHdhaXQgZG9lcyBu
b3QgYXBwZWFyIHRvIGJlIHNpbXBseSBhCj4+IG1hdHRlciBvZiBjb3JyZWN0bmVzcy4KPgo+IFdl
bGwsIGFzIEkgdW5kZXJzdGFuZCBpdCwgaXQganVzdCBtZWFucyB0aGF0IHlvdSBkb24ndCB3YW50
IHRvIAo+IGFicnVwdGx5IHRlcm1pbmF0ZSBHUFUgd29yayBpbiBwcm9ncmVzcyB3aXRob3V0IGEg
Z29vZAo+IHJlYXNvbiAoc3VjaCBhcyBLSUxMIHNpZ25hbCkuIFdoZW4gd2UgZXhpdCB3ZSBhcmUg
Z29pbmcgdG8gcmVsZWFzZSAKPiB2YXJpb3VzIHJlc291cmNlcyBHUFUgaXMgc3RpbGwgdXNpbmcg
c28gd2UgZWl0aGVyCj4gd2FpdCBmb3IgaXQgdG8gY29tcGxldGUgb3IgdGVybWluYXRlIHRoZSBy
ZW1haW5pbmcgam9icy4KCkxvb2tlZCBtb3JlIGludG8gY29kZSwgc29tZSBjb3JyZWN0aW9uLCBk
cm1fc2NoZWRfZW50aXR5X2ZpbmkgbWVhbnMgdGhlIApTVyBqb2IgcXVldWUgaXRzZWxmIGlzIGFi
b3V0IHRvIGRpZSwgc28gd2UgbXVzdAplaXRoZXIgd2FpdCBmb3IgY29tcGxldGlvbiBvciB0ZXJt
aW5hdGUgYW55IG91dHN0YW5kaW5nIGpvYnMgdGhhdCBhcmUgCnN0aWxsIGluIHRoZSBTVyBxdWV1
ZS4gQW55dGhpbmcgd2hpY2ggYWxyZWFkeSBpbiBmbGlnaHQgaW4gSFcKd2lsbCBzdGlsbCBjb21w
bGV0ZS4KCkFuZHJleQoKPgo+IEFuZHJleQo+Cj4+Cj4+IEVyaWMKPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
