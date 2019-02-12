From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: "ring gfx timeout" with Vega 64 on mesa 19.0.0-rc2 and kernel
 5.0.0-rc6 (GPU reset still not works)
Date: Tue, 12 Feb 2019 15:51:05 +0000
Message-ID: <f419438e-4c50-9b5b-d0fd-db60816257b4@amd.com>
References: <CABXGCsOakru4=RMrhpocLhN99LwKp4q1-UfFJrEUh7q4UeKJ_g@mail.gmail.com>
 <47477f0a-76dd-2f33-ff38-01f8216cffcc@amd.com>
 <CABXGCsMMOx+Ay7Dkjfy1bKcvnsqEE0v2XnZzLNVM3ygM4G2PWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABXGCsMMOx+Ay7Dkjfy1bKcvnsqEE0v2XnZzLNVM3ygM4G2PWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <F6B1A9C8F42B6F40A10EBD48280182D5-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

VGhleSBhcmUgdXNlZnVsLiBJIGFtIGdvbm5hIHRha2UgYSBsb29rIGxhdGVyLg0KDQpBbmRyZXkN
Cg0KT24gMi8xMi8xOSAxMDo0OSBBTSwgTWlraGFpbCBHYXZyaWxvdiB3cm90ZToNCj4gT24gVHVl
LCAxMiBGZWIgMjAxOSBhdCAyMDoyMywgR3JvZHpvdnNreSwgQW5kcmV5DQo+IDxBbmRyZXkuR3Jv
ZHpvdnNreUBhbWQuY29tPiB3cm90ZToNCj4+IEl0IHNob3VsZCByZWNvdmVyIHlvdSAtIHNvIHRo
aXMgbG9va3MgbGlrZSBhIGJ1Zy4gSSBub3RpY2VkIGluIG9uZSBvZg0KPj4gdGhlIGNhbGwgdHJh
Y2VzIHRoaXMgLSBkcm1fYXRvbWljX2hlbHBlcl9zdXNwZW5kIHdoaWNoIHBvaW50cyB0byBzeXN0
ZW0NCj4+IGdvaW5nIGludG8gc2xlZXAgbW9kZSwgaXMgaXQgd2hhdCBoYXBwZW5lZCwgZGlkIGl0
IGhhbmcgd2hlbiBzeXN0ZW0NCj4+IHRyaWVkIHRvIHNsZWVwID8NCj4+DQo+IEl0J3Mgd2VpcmQg
YmVjYXVzZSB0aGUgY29tcHV0ZXIgd2FzIG5vdCBlbnRlciBpbiBzbGVlcCBtb2RlLiBJIGFtIHN1
cmUuDQo+IFN0ZXBzIGZvciByZXByb2R1Y2U6DQo+IDEuIExhdW5jaCBTaGFkb3cgb2YgVGhlIHRv
bWIgUmlkZXIgb24gUHJvdG9uDQo+IDIuIFdhaXQgc29tZSB0aW1lIHVudGlsIG1vdXNlIHN0b3Ag
cmVzcG9uZA0KPiAzLiBEdW1wIGdmeCwgd2F2ZXMgYW5kIGFsbCBvdGhlciBkdW1wcyBpbmNsdWRp
bmcgZG1lc2cNCj4NCj4gQW5kIG9mIGNvdXJzZSB0aGUgcG93ZXIgYnV0dG9uIChidXR0b24gd2hp
Y2ggZW50ZXIgaW4gc2xlZXAgbW9kZSkgd2FzDQo+IG5vdCBwcmVzc2VkLg0KPg0KPiBTbyB0aGUg
bmV3IGR1bXBzIGhhcyBhbnkgbmV3IHVzZWZ1bCBpbmZvPyBPciB0aGV5IGFyZSBwb2ludGxlc3M/
DQo+IC0tDQo+IEJlc3QgUmVnYXJkcywNCj4gTWlrZSBHYXZyaWxvdi4NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
