From: Harry Wentland <hwentlan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/2] drm/amd/display: Add HDR output metadata support for
 amdgpu
Date: Wed, 29 May 2019 23:31:54 +0000
Message-ID: <77396fec-944e-291b-38fe-588e899fcb62@amd.com>
References: <20190528190836.10738-1-nicholas.kazlauskas@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190528190836.10738-1-nicholas.kazlauskas-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <05A941C32605ED42926038A3A3AA4B8E-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Kazlauskas, Nicholas" <Nicholas.Kazlauskas-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOS0wNS0yOCAzOjA4IHAubS4sIE5pY2hvbGFzIEthemxhdXNrYXMgd3JvdGU6DQo+IFRo
aXMgcGF0Y2ggc2VyaWVzIGVuYWJsZXMgSERSIG91dHB1dCBtZXRhZGF0YSBzdXBwb3J0IGluIGFt
ZGdwdSB1c2luZyB0aGUNCj4gRFJNIEhEUiBpbnRlcmZhY2UgbWVyZ2VkIGluIGRybS1taXNjLW5l
eHQuIEVuYWJsZWQgZm9yIERDRSBhbmQgRENOIEFTSUNzDQo+IG92ZXIgRFAgYW5kIEhETUkuDQo+
IA0KPiBJdCdzIGxpbWl0ZWQgdG8gc3RhdGljIEhEUiBtZXRhZGF0YSBzdXBwb3J0IGZvciBub3cg
c2luY2UgdGhhdCdzIGFsbCB0aGUNCj4gRFJNIGludGVyZmFjZSBzdXBwb3J0cy4gSXQgcmVxdWly
ZXMgYSBtb2Rlc2V0IGZvciBlbnRlcmluZyBhbmQgZXhpdGluZyBIRFINCj4gYnV0IHRoZSBtZXRh
ZGF0YSBjYW4gYmUgY2hhbmdlZCB3aXRob3V0IG9uZS4NCj4gDQo+IENjOiBIYXJyeSBXZW50bGFu
ZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4gDQoNClNlcmllcyBpcw0KUmV2aWV3ZWQtYnk6
IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+IE5p
Y2hvbGFzIEthemxhdXNrYXMgKDIpOg0KPiAgIGRybS9hbWQvZGlzcGxheTogRXhwb3NlIEhEUiBv
dXRwdXQgbWV0YWRhdGEgZm9yIHN1cHBvcnRlZCBjb25uZWN0b3JzDQo+ICAgZHJtL2FtZC9kaXNw
bGF5OiBPbmx5IGZvcmNlIG1vZGVzZXRzIHdoZW4gdG9nZ2xpbmcgSERSDQo+IA0KPiAgLi4uL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMTU1ICsrKysrKysrKysr
KysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1MSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
