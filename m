From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] dma_buf: remove device parameter from attach callback
Date: Fri, 1 Jun 2018 17:17:24 +0200
Message-ID: <64e8f2dd-5b09-397f-05ac-67646dfb5394@gmail.com>
References: <20180601120020.11520-1-christian.koenig@amd.com>
 <651a24e0-ac58-e5cb-d95f-c9a88bf552dc@gmail.com>
 <df02be8b-530e-b691-35f1-ed657d71a508@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <df02be8b-530e-b691-35f1-ed657d71a508-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMDEuMDYuMjAxOCB1bSAxNjowMiBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDYtMDEgMDI6MTEgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFNvcnJ5LCBhY2NpZGVu
dGFsbHkgc2VuZCB0aGlzIHNlcmllcyB3aXRob3V0IGEgY292ZXIgbGV0dGVyLgo+Pgo+PiBUaGlz
IGlzIGEgY2xlYW51cCB0byB0aGUgRE1BLWJ1ZiBpbnRlcmZhY2UsIHdoaWNoIGlzIGFsc28gYSBw
cmVyZXF1aXNpdGUKPj4gdG8gdW5waW5uZWQgRE1BLWJ1ZiBvcGVyYXRpb24uCj4+Cj4+IFBhdGNo
ICMxIGFuZCAjMiBqdXN0IHJlbW92ZSB1bnVzZWQgZnVuY3Rpb25hbGl0eSBhbmQgY2xlYW4gdXAg
Y2FsbGJhY2sKPj4gcGFyYW1ldGVycy4KPj4KPj4gUGF0Y2ggIzMgYW5kICM0IGludHJvZHVjZSB0
YWtpbmcgdGhlIHJlc2VydmF0aW9uIGxvY2sgZHVyaW5nCj4+IG1hcHBpbmcvdW5tYXBwaW5nIG9m
IERNQS1idWZzLgo+Pgo+PiBUaGlzIGludHJvZHVjZXMgYSBjb21tb24gbG9jayB3aGVyZSBib3Ro
IGV4cG9ydGVyIGFzIHdlbGwgYXMgaW1wb3J0ZXIKPj4gY2FuIHRoZW4gdXNlIGluIHRoZSBmdXR1
cmUgZm9yIHVucGlubmVkIERNQS1idWYgb3BlcmF0aW9uLgo+Pgo+PiBUaGlzIG9mIGNvdXJzZSBt
ZWFucyB0aGF0IGV4cG9ydGVycyBzaG91bGQgbm93IG5vdCB0YWtlIHRoaXMgcmVzZXJ2YXRpb24K
Pj4gbG9jayBtYW51YWxseSBhbnkgbW9yZS4gVGhlIERSTSBkcml2ZXJzIGRvbid0IHNlZW0gdG8g
YWN0dWFsbHkgZG8gdGhhdCwKPj4gYnV0IEknbSBub3QgMTAwJSBzdXJlIGFib3V0IG90aGVyIGlt
cGxlbWVudGF0aW9ucy4KPj4KPj4gUGF0Y2ggIzUgdGhlbiBtYWtlcyB1c2Ugb2YgdGhlIG5ldyBs
b2NrIHRvIHNpbXBsaWZ5IHRoZSBETUEtYnVmIGltcG9ydAo+PiBoYW5kbGluZyBpbiBhbWRncHUu
Cj4gUGxlYXNlIHJlYmFzZSB0aGlzIHNlcmllcyBvbiB0b3Agb2YKPiBodHRwczovL3BhdGNod29y
ay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMjI2MzExLyBhbmQgdXBkYXRlIHRoZQo+IGRvY3VtZW50
YXRpb24gaW4gYW1kZ3B1X3ByaW1lLmMgYXMgbmVlZGVkIGluIGVhY2ggcGF0Y2guCgpTdXJlLiBJ
biB0aGlzIGNhc2UgY2FuIHdlIGdldCB5b3VyIHBhdGNoZXMgY29tbWl0dGVkIHRvIAphbWQtc3Rh
Z2luZy1kcm0tbmV4dCBBU0FQPwoKVGhhbmtzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
