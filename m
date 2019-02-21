From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] [RFC] drm/ttm: Don't init dma32_zone on 64-bit systems
Date: Thu, 21 Feb 2019 16:57:39 +0000
Message-ID: <2a76cb48-10f1-6df2-5b40-8d5b4c52acc4@amd.com>
References: <1550271712-13069-1-git-send-email-Felix.Kuehling@amd.com>
 <8538a294-eeab-9c87-ae10-83695149f808@shipmail.org>
 <254ca765-adc2-5ddf-280f-6cb3643f6e1f@amd.com>
 <d90f7ab569b636db0968c80dad9eb16ce7bf1eab.camel@vmware.com>
 <89c4b66a-152a-d0f3-4ce0-d89f6ef822bb@gmail.com>
 <eaad8f2dc24e98c68036801ccd6a871586033d31.camel@vmware.com>
 <2be5739a-fe9a-f436-48a2-fb420cb97a13@amd.com>
 <19a0abdbd60c251a63975a7ddff31c35a5eb0a31.camel@vmware.com>
 <71b105f0-c350-a957-74b4-57066e39e047@amd.com>
 <02031c0fe1b4af05bdc07155647cc88c445dcccf.camel@vmware.com>
 <4423e7aa-2153-5305-91c2-8d212ae1786b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4423e7aa-2153-5305-91c2-8d212ae1786b-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <F6B9D773E82588488FBF3B2A61C1C959-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Thomas Hellstrom <thellstrom-pghWNbHTmq7QT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "thomas-4+hqylr40dJg9hUCZPvPmw@public.gmane.org" <thomas-4+hqylr40dJg9hUCZPvPmw@public.gmane.org>

DQpPbiAyMDE5LTAyLTIxIDI6NTkgYS5tLiwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6DQo+IE9u
IHg4NiB3aXRoIEhJR0hNRU0gdGhlcmUgaXMgbm8gZG1hMzIgem9uZS4gV2h5IGRvIHdlIG5lZWQg
b25lIG9uDQo+Pj4geDg2XzY0PyBDYW4gd2UgbWFrZSB4ODZfNjQgbW9yZSBsaWtlIEhJR0hNRU0g
aW5zdGVhZD8NCj4+Pg0KPj4+IFJlZ2FyZHMsDQo+Pj4gICAgICBGZWxpeA0KPj4+DQo+PiBJSVJD
IHdpdGggeDg2LCB0aGUga2VybmVsIHpvbmUgaXMgYWx3YXlzIHNtYWxsZXIgdGhhbiBhbnkgZG1h
MzIgem9uZSwNCj4+IHNvIHdlJ2QgYWx3YXlzIGV4aGF1c3QgdGhlIGtlcm5lbCB6b25lIGJlZm9y
ZSBkbWEzMiBhbnl3YXkuDQo+Pg0KPj4gTm90IHN1cmUgd2h5IHdlIGhhdmUgZG1hMzIgb24geDg2
IHdpdGhvdXQgaGlnaG1lbSwgdGhvdWdoLiBzb3VuZHMNCj4+IHN1cGVyZmxvdXMgYnV0IGhhcm1s
ZXNzLg0KPiBXZWxsIERNQTMyIGRlbm90ZXMgbWVtb3J5IHdoaWNoIGlzIGFjY2Vzc2libGUgYnkg
ZGV2aWNlcyB3aG8gY2FuIG9ubHkgZG8NCj4gMzJiaXQgYWRkcmVzc2luZy4gQW5kIElJUkMgd2Ug
Y2FuIGFjdHVhbGx5IGRvIERNQTMyIHRvIGhpZ2htZW0gc2luY2UNCj4gc29tZXRoaW5nIGxpa2Ug
Mi40LiouDQo+DQo+IEJlY2F1c2Ugb2YgdGhpcyBpdCBpcyBhY3R1YWxseSBpcnJlbGV2YW50IGlm
IHlvdSBoYXZlIGhpZ2htZW0gb3Igbm90LA0KPiB3aGF0IG1hdHRlcnMgZm9yIERNQTMyIGlzIGlm
IHlvdSBoYXZlIGFuIElPTU1VIG9yIG5vdC4NCg0KQXJlIHlvdSBzYXlpbmcgd2Ugc2hvdWxkIGhh
dmUgYSBkbWEzMl96b25lIGV2ZW4gb24geDg2IHdpdGggSElHSE1FTT8NCg0KDQo+DQo+IFNvIGV2
ZW4gb24geDg2XzY0IHlvdSBhY3R1YWxseSBkbyBuZWVkIHRoZSBETUEzMiB6b25lIGlmIHlvdSBk
b24ndCBoYXZlDQo+IGFuIElPTU1VIHdoaWNoIHJlbWFwcyBhbGwgbWVtb3J5IGZvciBkZXZpY2Vz
IHdoaWNoIGNhbid0IGRpcmVjdGx5DQo+IGFkZHJlc3MgaXQuDQoNCldoeSBpcyBETUEzMiBzcGVj
aWFsIGluIHRoaXMgd2F5PyBGb3IgZXhhbXBsZSBBTUQgR0ZYOCBHUFVzIHN1cHBvcnQgDQo0MC1i
aXQgRE1BLiBCdXQgd2UgZG9uJ3QgaGF2ZSBhIHNwZWNpYWwgem9uZSBmb3IgdGhhdC4NCg0KSG93
IGNvbW1vbiBpcyBpdCB0byBoYXZlIGRldmljZXMgdGhhdCBuZWVkIERNQTMyIG9uIGFuIHg4Nl82
NCBzeXN0ZW0/DQoNClJlZ2FyZHMsDQogwqAgRmVsaXgNCg0KDQo+DQo+IFJlZ2FyZHMsDQo+IENo
cmlzdGlhbi4NCj4NCj4+IC9UaG9tYXMNCj4+DQo+Pg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
