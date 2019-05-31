From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 6/8] drm/amdkfd: New IOCTL to allocate queue GWS
Date: Fri, 31 May 2019 20:04:11 +0000
Message-ID: <e857f0f4-341d-1e64-0ffe-5b6812ca5b7f@amd.com>
References: <1558651263-3478-1-git-send-email-Oak.Zeng@amd.com>
 <1558651263-3478-6-git-send-email-Oak.Zeng@amd.com>
 <4f49af4d-0953-030c-bb1b-47b7a5fa7c7c@amd.com>
 <CAPM=9tzs9adV7_ef4hpgswB-S==iQizAF_=FTarVm3EYwPCg0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPM=9tzs9adV7_ef4hpgswB-S==iQizAF_=FTarVm3EYwPCg0w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <F954250BD858554AB4E3DFEE323AC8CD-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Keely, Sean" <Sean.Keely-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wNS0zMCAxMToxMyBwLm0uLCBEYXZlIEFpcmxpZSB3cm90ZToNCj4gT24gU2F0LCAy
NSBNYXkgMjAxOSBhdCAwNTo0OCwgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPiB3cm90ZToNCj4+IE9uIDIwMTktMDUtMjMgNjo0MSBwLm0uLCBaZW5nLCBPYWsgd3JvdGU6
DQo+Pj4gQWRkIGEgbmV3IGtmZCBpb2N0bCB0byBhbGxvY2F0ZSBxdWV1ZSBHV1MuIFF1ZXVlDQo+
Pj4gR1dTIGlzIHJlbGVhc2VkIG9uIHF1ZXVlIGRlc3Ryb3kuDQo+Pj4NCj4+PiBDaGFuZ2UtSWQ6
IEk2MDE1M2MyNmE1Nzc5OTJhZDg3M2U0MjkyZTc1OWU1YzNkNWJiZDE1DQo+Pj4gU2lnbmVkLW9m
Zi1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+DQo+PiBSZXZpZXdlZC1ieTogRmVsaXgg
S3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+Pg0KPiBidHcganVzdCBub3RpY2Vk
IGluIHBhc3Npbmcgd2UgYXJlIGFkZGluZyBuZXcgZmVhdHVyZXMgdG8ga2ZkLCBpcw0KPiB0aGVy
ZSBhbiBvcGVuIHNvdXJjZSBkZXZlbG9wZWQgdXNlcnNwYWNlIHRvIGdvIGFsb25nIHdpdGggdGhp
cywgdGhlcmUNCj4gbmVlZHMgdG8gYSBkZXYgYnJhbmNoIGluIHB1YmxpYyBiZWZvcmUgbmV3IGlv
Y3Rscy91YXBpIHN1cmZhY2VzIHNob3VsZA0KPiBiZSBhZGRlZCB0byB0aGUga2VybmVsLg0KPg0K
PiBUaGUgY29tbWl0cyBzaG91bGQgcHJvYmFibHkgaGF2ZSBwb2ludGVycyB0byB0aGF0IGJyYW5j
aC4NCg0KQWgsIGEgY2hpY2tlbiBhbmQgZWdnIHByb2JsZW0uIEkgdGhpbmsgdGhpcyBpcyB0aGUg
Zmlyc3QgdGltZSB3ZSdyZSANCmFkZGluZyBhIG5ldyBpb2N0bCB0byB1cHN0cmVhbSBLRkQgcmF0
aGVyIHRoYW4gdXBzdHJlYW1pbmcgb25lIHRoYXQncyANCmJlZW4gZGV2ZWxvcGVkIGludGVybmFs
bHkgZmlyc3QuIE1heWJlIG5vdCB0aGUgcmlnaHQgd2F5IHRvIGRvIGl0Lg0KDQpJIHNob3VsZCBi
ZSBhYmxlIHRvIHB1Ymxpc2ggdGhlIHVzZXIgbW9kZSBjb2RlIGluIGxpYmhzYWttdCBuZXh0IHdl
ZWsuIA0KVGhlbiB3ZSdsbCB3b3JrIG9uIGEga2ZkdGVzdCB0byB2YWxpZGF0ZSB0aGUgZmlybXdh
cmUgZnVuY3Rpb25hbGl0eS4gDQpGaW5hbGx5IHdlJ2xsIHVzZSBHV1MgZnVydGhlciB1cCB0aGUg
c29mdHdhcmUgc3RhY2sgZm9yIHN5bmNocm9uaXphdGlvbiANCm9mIGNvbmN1cnJlbnQgY29tcHV0
ZSB3b3JrZ3JvdXBzLg0KDQpSZWdhcmRzLA0KIMKgIEZlbGl4DQoNCg0KPg0KPiBEYXZlLg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
