From: "Quan, Evan" <Evan.Quan@amd.com>
Subject: RE: [PATCH 0/2] remove some set but not used variables in hwmgr
Date: Mon, 11 Nov 2019 04:04:43 +0000
Message-ID: <MN2PR12MB3344DA10AF60C2C0E8D9FD0EE4740@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1573443956-76489-1-git-send-email-zhengbin13@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1573443956-76489-1-git-send-email-zhengbin13@huawei.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: zhengbin <zhengbin13@huawei.com>, "rex.zhu@amd.com" <rex.zhu@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

U2VyaWVzIGlzIHJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgoKPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IHpoZW5nYmluIDx6aGVuZ2JpbjEzQGh1
YXdlaS5jb20+Cj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAxOSAxMTo0NiBBTQo+IFRv
OiByZXguemh1QGFtZC5jb207IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPjsgRGV1Y2hl
ciwKPiBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlz
dGlhbgo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBaaG91LCBEYXZpZChDaHVuTWluZykK
PiA8RGF2aWQxLlpob3VAYW1kLmNvbT47IGFpcmxpZWRAbGludXguaWU7IGRhbmllbEBmZndsbC5j
aDsgYW1kLQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBDYzogemhlbmdiaW4xM0BodWF3ZWkuY29tCj4gU3ViamVjdDogW1BBVENI
IDAvMl0gcmVtb3ZlIHNvbWUgc2V0IGJ1dCBub3QgdXNlZCB2YXJpYWJsZXMgaW4gaHdtZ3IKPiAK
PiB6aGVuZ2JpbiAoMik6Cj4gICBkcm0vYW1kL3Bvd2VycGxheTogcmVtb3ZlIHNldCBidXQgbm90
IHVzZWQgdmFyaWFibGUKPiAgICAgJ3ZiaW9zX3ZlcnNpb24nLCdkYXRhJwo+ICAgZHJtL2FtZC9w
b3dlcnBsYXk6IHJlbW92ZSBzZXQgYnV0IG5vdCB1c2VkIHZhcmlhYmxlICdkYXRhJwo+IAo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMgICB8IDQgLS0t
LQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9od21nci92ZWdhMTBfaHdtZ3IuYyB8
IDIgLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQo+IAo+IC0tCj4gMi43LjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZl
bCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
