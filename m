From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] remove some set but not used variables in hwmgr
Date: Mon, 11 Nov 2019 12:52:03 -0500
Message-ID: <CADnq5_Nq2SBJRCrrfy-OQBk=kSokq+KY+YdaTZ3WM5BuiM3Gxw@mail.gmail.com>
References: <1573443956-76489-1-git-send-email-zhengbin13@huawei.com>
 <MN2PR12MB3344DA10AF60C2C0E8D9FD0EE4740@MN2PR12MB3344.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MN2PR12MB3344DA10AF60C2C0E8D9FD0EE4740-rweVpJHSKToDMgCC8P//OwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, zhengbin <zhengbin13-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "rex.zhu-5C7GfCeVMHo@public.gmane.org" <rex.zhu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

QXBwbGllZC4gIFRoYW5rcyEKCkFsZXgKCk9uIFN1biwgTm92IDEwLCAyMDE5IGF0IDExOjA0IFBN
IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPiB3cm90ZToKPgo+IFNlcmllcyBpcyByZXZp
ZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KPgo+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPiA+IEZyb206IHpoZW5nYmluIDx6aGVuZ2JpbjEzQGh1YXdlaS5jb20+
Cj4gPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDExLCAyMDE5IDExOjQ2IEFNCj4gPiBUbzogcmV4
LnpodUBhbWQuY29tOyBRdWFuLCBFdmFuIDxFdmFuLlF1YW5AYW1kLmNvbT47IERldWNoZXIsCj4g
PiBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlh
bgo+ID4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IFpob3UsIERhdmlkKENodW5NaW5nKQo+
ID4gPERhdmlkMS5aaG91QGFtZC5jb20+OyBhaXJsaWVkQGxpbnV4LmllOyBkYW5pZWxAZmZ3bGwu
Y2g7IGFtZC0KPiA+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKPiA+IENjOiB6aGVuZ2JpbjEzQGh1YXdlaS5jb20KPiA+IFN1YmplY3Q6
IFtQQVRDSCAwLzJdIHJlbW92ZSBzb21lIHNldCBidXQgbm90IHVzZWQgdmFyaWFibGVzIGluIGh3
bWdyCj4gPgo+ID4gemhlbmdiaW4gKDIpOgo+ID4gICBkcm0vYW1kL3Bvd2VycGxheTogcmVtb3Zl
IHNldCBidXQgbm90IHVzZWQgdmFyaWFibGUKPiA+ICAgICAndmJpb3NfdmVyc2lvbicsJ2RhdGEn
Cj4gPiAgIGRybS9hbWQvcG93ZXJwbGF5OiByZW1vdmUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJs
ZSAnZGF0YScKPiA+Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211
N19od21nci5jICAgfCA0IC0tLS0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9o
d21nci92ZWdhMTBfaHdtZ3IuYyB8IDIgLS0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDYgZGVsZXRp
b25zKC0pCj4gPgo+ID4gLS0KPiA+IDIuNy40Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKPiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
