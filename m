From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 01/35] drm/amd/display: Use udelay when waiting between
 aux retries
Date: Fri, 1 Feb 2019 21:20:56 +0000
Message-ID: <058665e8-0241-8fc1-8a2a-9f1d7484b29e@amd.com>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-2-Bhawanpreet.Lakha@amd.com>
 <20190201173141.GA3838@freedom>
 <fda8f6ec-5a75-6456-3034-f3714b304b77@amd.com>
 <20190201200830.GA7069@freedom> <20190201204706.GA8286@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190201204706.GA8286@freedom>
Content-Language: en-US
Content-ID: <B994337E59B7594D88355D658A6586CC-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Barberiz, John" <John.Barberiz-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQoNCk9uIDIwMTktMDItMDEgMzo0NyBwLm0uLCBzeWx2YWluLmJlcnRyYW5kQGdtYWlsLmNvbSB3
cm90ZToNCj4gT24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDg6MDg6MzBQTSArMDAwMCwgc3lsdmFp
bi5iZXJ0cmFuZEBnbWFpbC5jb20gd3JvdGU6DQo+PiBEbyB5b3UgbWVhbiBub24tREMgZGlzcGxh
eXBvcnQgcmVsYXRlZCBjb2RlIGlzIGFscmVhZHkgdXNpbmcgdWRlbGF5IGluc3RlYWQNCj4+IG9m
IG1zbGVlcCBvbiBsaW51eD8NCj4gDQo+IEkgZ3JlcC1lZCBhbWRncHUgZGlzcGxheXBvcnQgYXRv
bWJpb3MgY29kZSwgZ290IHVkZWxheSg0MDApIG9ubHkuDQo+IERpZCB0aGUgc2FtZSBvbiBkcm0g
Kl9kcF8qIGZpbGVzLCBnb3Qgc2ltaWxhciB1ZGVsYXlzIHdpdGggb25seSBhIHZlcnkgc2xvdw0K
PiBtc2xlZXAgKHdoaWNoIHNlZW1zIGp1c3RpZmllZCB0aGVyZSkuDQo+IA0KPiBCdXQgSSBkaWQg
bm90IGdldCBhbnkgdWRlbGF5cyB3aXRoIHRoZSByYW5nZSBvZiAxbXMgZm9yICJyZXRyaWVzIi4g
TWF5YmUgaXQNCj4gd291bGQgYmUgYSBnb29kIGlkZWEgdG8gYSBzaW1pbGFyIGRlbGF5IG9uIG5v
bi1EQyBkaXNwbGF5cG9ydCBjb2RlPyBUaGF0IHdvdWxkDQo+IGdpdmUgbW9yZSB0aW1lIHRvICJz
bG93IiBkaXNwbGF5b3J0IG1vbml0b3JzIHRvIHRpbWVvdXQgb24gdGhlaXIgc2lkZS4NCj4gDQoN
CkRSTSdzIEFVWCBjb2RlIHVzZXMgdXNsZWVwX3JhbmdlIGluIGRybV9kcF9kcGNkX2FjY2Vzcy4N
Cg0KSGFycnkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
