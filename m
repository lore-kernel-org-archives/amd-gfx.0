From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 6/6] drm/amdgpu: fix to remove HDP MGCG on soc15
Date: Fri, 24 Mar 2017 14:19:48 +0000
Message-ID: <BN6PR12MB16520D62905EC06E7E4A46D1F73E0@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1490334466-17596-1-git-send-email-ray.huang@amd.com>
 <1490334466-17596-7-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490334466-17596-7-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IEh1YW5nIFJ1aSBbbWFpbHRvOnJh
eS5odWFuZ0BhbWQuY29tXQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMjQsIDIwMTcgMTo0OCBBTQo+
IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyCj4g
Q2M6IEh1YW4sIEFsdmluOyBIdWFuZywgUmF5Cj4gU3ViamVjdDogW1BBVENIIDYvNl0gZHJtL2Ft
ZGdwdTogZml4IHRvIHJlbW92ZSBIRFAgTUdDRyBvbiBzb2MxNQo+IAo+IFNPQzE1IGRvZXNuJ3Qg
ZW5hYmxlIEhEUCBNR0NHIHlldC4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5o
dWFuZ0BhbWQuY29tPgoKRm9yIHRoZSBzZXJpZXM6ClJldmlld2VkLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc29jMTUuYyB8IDEgLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQo+
IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCj4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCj4gaW5kZXggZGQ3MDk4NC4uYTdhMGMy
NyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYwo+IEBAIC01NjEsNyArNTYxLDYg
QEAgc3RhdGljIGludCBzb2MxNV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCj4gIAkJ
CUFNRF9DR19TVVBQT1JUX0dGWF9DR0xTIHwKPiAgCQkJQU1EX0NHX1NVUFBPUlRfQklGX01HQ0cg
fAo+ICAJCQlBTURfQ0dfU1VQUE9SVF9CSUZfTFMgfAo+IC0JCQlBTURfQ0dfU1VQUE9SVF9IRFBf
TUdDRyB8Cj4gIAkJCUFNRF9DR19TVVBQT1JUX0hEUF9MUyB8Cj4gIAkJCUFNRF9DR19TVVBQT1JU
X0RSTV9NR0NHIHwKPiAgCQkJQU1EX0NHX1NVUFBPUlRfRFJNX0xTIHwKPiAtLQo+IDIuNy40Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
