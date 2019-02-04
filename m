From: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Use context parameters to enable FBC
Date: Mon, 4 Feb 2019 15:55:42 +0000
Message-ID: <78992e14-85f2-8b11-cc60-1d5455448992@amd.com>
References: <1549272004-30469-1-git-send-email-shirish.s@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1549272004-30469-1-git-send-email-shirish.s-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
Content-ID: <BB50705E8285EB4B99563678685C06D2-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMi0wNCA0OjIwIGEubS4sIFMsIFNoaXJpc2ggd3JvdGU6DQo+IFtXaGF0XQ0KPiBG
QkMgZmFpbHMgdG8gZ2V0IGVuYWJsZWQgd2hlbiBzd2l0Y2hlZCBiZXR3ZWVuIExJTkVBUihjb25z
b2xlL1ZUKQ0KPiBhbmQgbm9uLUxJTkVBUihHVUkpIGJhc2VkIHJlbmRlcmluZyBkdWUgdG8gZGVm
YXVsdCB2YWx1ZSBvZg0KPiB0aWxpbmcgaW5mbyBzdG9yZWQgaW4gdGhlIGN1cnJlbnRfc3RhdGUg
d2hpY2ggaXMgdXNlZCBmb3IgZGVjaWRpbmcNCj4gd2hldGhlciBvciBub3QgdG8gdHVybiBGQkMg
b24gb3Igb2ZmLg0KPiANCj4gW0hvd10NCj4gVXNlIGNvbnRleHQgc3RydWN0dXJlJ3MgdGlsaW5n
IGluZm9ybWF0aW9uIHdoaWNoIGlzIGNvaGVyYW50IHdpdGgNCj4gdGhlIHNjcmVlbiB1cGRhdGVz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2hpcmlzaCBTIDxzaGlyaXNoLnNAYW1kLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19z
ZXF1ZW5jZXIuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMNCj4gaW5kZXggZGIwZWY0MS4u
ZmQ3Y2Q1YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMNCj4gQEAgLTI1MzUsNyArMjUz
NSw3IEBAIHN0YXRpYyB2b2lkIGRjZTExMF9hcHBseV9jdHhfZm9yX3N1cmZhY2UoDQo+ICAJfQ0K
PiAgDQo+ICAJaWYgKGRjLT5mYmNfY29tcHJlc3NvcikNCj4gLQkJZW5hYmxlX2ZiYyhkYywgZGMt
PmN1cnJlbnRfc3RhdGUpOw0KPiArCQllbmFibGVfZmJjKGRjLCBjb250ZXh0KTsNCg0KTG9va3Mg
Z29vZCwgYnV0IEknZCB3YW50IFJvbWEncyBSQi4NCg0KQWNrZWQtYnk6IEhhcnJ5IFdlbnRsYW5k
IDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0KDQo+ICB9DQo+ICANCj4gIHN0YXRp
YyB2b2lkIGRjZTExMF9wb3dlcl9kb3duX2ZlKHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBwaXBlX2N0
eCAqcGlwZV9jdHgpDQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
