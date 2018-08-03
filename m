From: "Zhang, Jerry (Junwei)" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 1/6] amdgpu: always add all BOs to lockup table
Date: Fri, 3 Aug 2018 11:13:31 +0800
Message-ID: <5B63C85B.6030103@amd.com>
References: <20180802140452.23894-1-christian.koenig@amd.com>
 <2ede6f59-a1e6-fe9e-396f-2cc961db6df5@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2ede6f59-a1e6-fe9e-396f-2cc961db6df5-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?UTF-8?B?Q2hy?= =?UTF-8?B?aXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDgvMDIvMjAxOCAxMDo1NSBQTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gT24gMjAxOC0w
OC0wMiAwNDowNCBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gVGhpcyB3YXkgd2UgY2Fu
IGFsd2F5cyBmaW5kIGEgQk8gc3RydWN0dXJlIGJ5IGl0cyBoYW5kbGUuCj4+Cj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPgo+IFR5
cG8gaW4gdGhlIHNob3J0bG9nOiBzaG91bGQgYmUgImxvb2t1cCIgaW5zdGVhZCBvZiAibG9ja3Vw
Ii4KPgo+IEFsc28sIHRoaXMgcGF0Y2ggc2hvdWxkIHJlYWxseSBiZSBhZnRlciBwYXRjaCA0Lgo+
Cj4KPj4gQEAgLTI0MCwxNCArMjM3LDExIEBAIGludCBhbWRncHVfYm9fZXhwb3J0KGFtZGdwdV9i
b19oYW5kbGUgYm8sCj4+ICAgCQlyZXR1cm4gMDsKPj4KPj4gICAJY2FzZSBhbWRncHVfYm9faGFu
ZGxlX3R5cGVfa21zOgo+PiAtCQlhbWRncHVfYWRkX2hhbmRsZV90b190YWJsZShibyk7Cj4+IC0J
CS8qIGZhbGwgdGhyb3VnaCAqLwo+PiAgIAljYXNlIGFtZGdwdV9ib19oYW5kbGVfdHlwZV9rbXNf
bm9pbXBvcnQ6Cj4+ICAgCQkqc2hhcmVkX2hhbmRsZSA9IGJvLT5oYW5kbGU7Cj4+ICAgCQlyZXR1
cm4gMDsKPgo+IFRoaXMgaXMgYSBiaXQgdW5mb3J0dW5hdGUsIGFtZGdwdV9ib19oYW5kbGVfdHlw
ZV9rbXNfbm9pbXBvcnQgb25seSBqdXN0Cj4gbGFuZGVkIHRoaXMgd2VlayBmb3IgdGhlIDIuNC45
MyByZWxlYXNlLCBub3cgaXQnbGwgYWxyZWFkeSBiZSB1c2VsZXNzCj4gbm9pc2UuLi4gQSBiaXQg
bW9yZSBjb29yZGluYXRpb24gd291bGQgaGF2ZSBiZWVuIG5pY2UuIDopCgpCVFcsIHRoZXJlIGlz
IGEgc2NoZWR1bGUgZm9yIHRoYXQgcmVsZWFzZT8KCkkgbWVhbiBpZiBhbWRncHVfYm9faGFuZGxl
X3R5cGVfa21zX25vaW1wb3J0IGlzIG1lcmdlZCBpbiB0aGUgcmVsZWFzZSBhdCBsYXN0IG1pbnV0
ZS4KR2VuZXJhbGx5IHdlIG1heSB3YWl0IGZvciBzb21lIHZlcmlmaWNhdGlvbiBvciBwcm9jZXNz
IGZvciBhIHJlbGVhc2UuCmlmIHRoZSBmdW5jIGhhcyB0byBnbyB0aHJvdWdoIGEgdmVyaWZpY2F0
aW9uL3Byb2Nlc3MsIHRoYXQgbWF5YmUgbm90IGhhcHBlbiBpbiBhIHdlZWsuCgpKZXJyeQoKPgo+
Cj4gQW55d2F5LCB3aXRoIHRoZSB0eXBvIGluIHBhdGNoIDMgZml4ZWQsIHBhdGNoZXMgMiAmIDQt
NiBhcmUKPgo+IFJldmlld2VkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1k
LmNvbT4KPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
