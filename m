From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/8] drm/amd/pp: Add a new pp feature mask bit for OD
 feature
Date: Wed, 17 Jan 2018 05:18:02 +0000
Message-ID: <CY4PR12MB1687D1DC52DD0B927387E1C0FBE90@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1516104175-27651-1-git-send-email-Rex.Zhu@amd.com>
 <CANOLnOOmS-uUXg=KdstpXw4ok8cMEQHo1JwLD9LDDfu7+X878w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CANOLnOOmS-uUXg=KdstpXw4ok8cMEQHo1JwLD9LDDfu7+X878w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: 'Grazvydas Ignotas' <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogR3JhenZ5ZGFzIElnbm90YXMgW21h
aWx0bzpub3Rhc2FzQGdtYWlsLmNvbV0gDQpTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMTcsIDIw
MTggMTo1MyBBTQ0KVG86IFpodSwgUmV4DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS84XSBkcm0vYW1kL3BwOiBBZGQgYSBuZXcgcHAgZmVh
dHVyZSBtYXNrIGJpdCBmb3IgT0QgZmVhdHVyZQ0KDQpPbiBUdWUsIEphbiAxNiwgMjAxOCBhdCAy
OjAyIFBNLCBSZXggWmh1IDxSZXguWmh1QGFtZC5jb20+IHdyb3RlOg0KPiB3aGVuIHRoaXMgYml0
IHdhcyBzZXQgb24gbW9kdWxlIGxvYWQsDQo+IGRyaXZlciB3aWxsIGFsbG93IHRoZSB1c2VyIG92
ZXIvdW5kZXIgZ3B1IGNsb2NrIGFuZCB2b2x0YWdlIHRocm91Z2ggDQo+IHN5c2ZzLg0KPg0KPiBi
eSBkZWZhdWx0LCB0aGlzIGJpdCB3YXMgbm90IHNldC4NCj4NCj4gUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmV4
IFpodSA8UmV4LlpodUBhbWQuY29tPg0KPiArICAgICAgIGlmIChod21nci0+ZmVhdHVyZV9tYXNr
ICYgUFBfT1ZFUl9EUklWRVJfTUFTSykNCg0KPj5QUF9PVkVSRFJJVkVfTUFTSz8gSSBiZWxpZXZl
ICJvdmVyZHJpdmUiIGlzIGEgc2luZ2xlIHdvcmQuDQoNClllcywgT3ZlckRyaXZlIGFzIGEgcG93
ZXIgZmVhdHVyZS4gU28gYmV0dGVyIGNoYW5nZSB0byBQUF9PVkVSRFJJVkVfTUFTSy4NClRoYW5r
cy4NCg0KDQpCZXN0IFJlZ2FyZHMNClJleA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
