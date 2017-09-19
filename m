From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Correct bytes limit for SDMA 3.0 copy and
 fill
Date: Tue, 19 Sep 2017 13:15:29 +0200
Message-ID: <aec291f8-a03e-3688-3568-1a6149c21884@gmail.com>
References: <1505762316-13975-1-git-send-email-yong.zhao@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1505762316-13975-1-git-send-email-yong.zhao-5C7GfCeVMHo@public.gmane.org>
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
To: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTguMDkuMjAxNyB1bSAyMToxOCBzY2hyaWViIFlvbmcgWmhhbzoKPiBDaGFuZ2UtSWQ6IEkx
MGZjNWVmYmMzMDMwNTZjNWM1YzRkYzRmNGRkMmMzMTg2NTk1YTkxCj4gU2lnbmVkLW9mZi1ieTog
WW9uZyBaaGFvIDx5b25nLnpoYW9AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92M18wLmMgfCA0ICsrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3YzXzAuYwo+IGluZGV4IDcyOGMwZDguLjRlN2ZlMDcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92M18wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zZG1hX3YzXzAuYwo+IEBAIC0xNzMwLDExICsxNzMwLDExIEBAIHN0YXRpYyB2
b2lkIHNkbWFfdjNfMF9lbWl0X2ZpbGxfYnVmZmVyKHN0cnVjdCBhbWRncHVfaWIgKmliLAo+ICAg
fQo+ICAgCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9idWZmZXJfZnVuY3Mgc2RtYV92
M18wX2J1ZmZlcl9mdW5jcyA9IHsKPiAtCS5jb3B5X21heF9ieXRlcyA9IDB4MWZmZmZmLAo+ICsJ
LmNvcHlfbWF4X2J5dGVzID0gMHgzZmZmZTAsIC8qIG5vdCAweDNmZmZmZiBkdWUgdG8gSFcgbGlt
aXRhdGlvbiovCj4gICAJLmNvcHlfbnVtX2R3ID0gNywKPiAgIAkuZW1pdF9jb3B5X2J1ZmZlciA9
IHNkbWFfdjNfMF9lbWl0X2NvcHlfYnVmZmVyLAo+ICAgCj4gLQkuZmlsbF9tYXhfYnl0ZXMgPSAw
eDFmZmZmZiwKPiArCS5maWxsX21heF9ieXRlcyA9IDB4M2ZmZmUwLCAvKiBub3QgMHgzZmZmZmYg
ZHVlIHRvIEhXIGxpbWl0YXRpb24qLwo+ICAgCS5maWxsX251bV9kdyA9IDUsCj4gICAJLmVtaXRf
ZmlsbF9idWZmZXIgPSBzZG1hX3YzXzBfZW1pdF9maWxsX2J1ZmZlciwKPiAgIH07CgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
