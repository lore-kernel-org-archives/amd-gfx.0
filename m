From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/7] drm/amdgpu: remove job->adev
Date: Tue, 17 Jul 2018 10:25:19 +0200
Message-ID: <692a1562-d269-9855-6cce-0a00bbcee1d2@gmail.com>
References: <20180713151949.13665-1-christian.koenig@amd.com>
 <20180713151949.13665-6-christian.koenig@amd.com>
 <e0930c99-0221-23b4-7357-9e7eee16945e@daenzer.net>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <e0930c99-0221-23b4-7357-9e7eee16945e-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTYuMDcuMjAxOCB1bSAxNzo1MCBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTgt
MDctMTMgMDU6MTkgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFdlIGNhbiBnZXQgdGhh
dCBmcm9tIHRoZSByaW5nLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gVGhpcyBjaGFuZ2UgaW50cm9kdWNlZCB0aGUgYXR0
YWNoZWQgb29wcyB3aGVuIHJ1bm5pbmcgdGhlIHBpZ2xpdAo+IG1heC10ZXh0dXJlLXNpemUgdGVz
dCwgYWZ0ZXIgd2hpY2ggdGhlIHRlc3QgcHJvY2VzcyBoYW5ncy4KPgo+IE5vdGUgdGhhdCB0aGUg
dGVzdCBhbHdheXMgdHJpZ2dlcnMgdGhlIG91dCBvZiBtZW1vcnkgY29uZGl0aW9uIGluCj4gYW1k
Z3B1X2NzX2lvY3RsLCBidXQgYmVmb3JlIHRoaXMgY2hhbmdlIHRoYXQgd2FzIGhhbmRsZWQgZ3Jh
Y2VmdWxseS4KClNvcnJ5IGZvciB0aGUgbm9pc2UuIEkgZGlkbid0IHRob3VnaHQgYWJvdXQgdGhl
IHBvc3NpYmlsaXR5IG9mIApkZXN0cm95aW5nIHRoZSBqb2IgYmVmb3JlIHRoZSBzY2hlZHVsZXIg
d2FzIGRldGVybWluZWQuCgpQYXRjaCB0byBmaXggdGhpcyB3YXMganVzdCBwdXNoZWQgdG8gYW1k
LXN0YWdpbmctZHJtLW5leHQuCgpSZWdhcmRzLApDaHJpc3RpYW4uCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
