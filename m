From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/3] Enable Scatter Gather for Picasso.
Date: Tue, 23 Jul 2019 16:14:57 +0000
Message-ID: <005b0f93-d3a4-99eb-ff42-615512ceada4@amd.com>
References: <1563897851-11501-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1563897851-11501-1-git-send-email-andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <ABA99BFF14F94D458DDCD0801DE014B0-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Wu,
 Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>

U2VyaWVzIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQoNCkFtIDIzLjA3LjE5IHVtIDE4OjA0IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zz
a3k6DQo+IFRoaXMgc2VyaWVzIGVuYWJsZXMgUy9HIGZvciBQaWNhc3NvLg0KPiBGaXJzdCAyIHBh
dGNoZXMgZml4IGEgaGFyZCBoYW5nIGludHJvZHVjZWQgYnkgcGxhY2luZyB0aGUgZGlzcGxheQ0K
PiBCTyBpbiBHVFQgbWVtb3J5IGJlY2F1c2Ugb2YgSFcgaXNzdWVzIHdpdGggY2FjaGVkIG1hcHBp
bmdzDQo+IGFuZCB0aGUgdGhpcmQgcGF0Y2ggZW5hYmxlcyBTL0cuDQo+DQo+IEFuZHJleSBHcm9k
em92c2t5ICgyKToNCj4gICAgZHJtL2FtZGdwdTogRml4IGhhcmQgaGFuZyBmb3IgUy9HIGRpc3Bs
YXkgQk9zLg0KPiAgICBkcm0vYW1kL2Rpc3BsYXk6IE9ubHkgYWxsb3cgcy9nIHdoZW4gVVNXQyBm
bGFnIGlzIHNldC4NCj4NCj4gU2hpcmlzaCBTICgxKToNCj4gICAgZHJtL2FtZDogZW5hYmxlIFMv
RyBmb3IgUkFWRU4gY2hpcA0KPg0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kaXNwbGF5LmMgICAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9mYi5jICAgICAgICAgICAgfCAxNCArKysrKysrKysrKy0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYyAgICAgICAgICAgfCAgNCArKystDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8ICA0ICsr
LS0NCj4gICA0IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0p
DQo+DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
