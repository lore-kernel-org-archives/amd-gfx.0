From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH] drm: amd: amdgpu: constify ttm_place structures.
Date: Mon, 3 Jul 2017 09:18:55 +0200
Message-ID: <e31fa321-6047-8904-bfab-6dd0d9f8667c@vodafone.de>
References: <c5a3e3c10ef3728ce16693bfff813e6269d4dd28.1498986678.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <c5a3e3c10ef3728ce16693bfff813e6269d4dd28.1498986678.git.arvind.yadav.cs@gmail.com>
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
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDIuMDcuMjAxNyB1bSAxMToxMyBzY2hyaWViIEFydmluZCBZYWRhdjoKPiB0dG1fcGxhY2Ug
YXJlIG5vdCBzdXBwb3NlZCB0byBjaGFuZ2UgYXQgcnVudGltZS4gQWxsIGZ1bmN0aW9ucwo+IHdv
cmtpbmcgd2l0aCB0dG1fcGxhY2UgcHJvdmlkZWQgYnkgPGRybS90dG0vdHRtX3BsYWNlbWVudC5o
PiB3b3JrCj4gd2l0aCBjb25zdCB0dG1fcGxhY2UuIFNvIG1hcmsgdGhlIG5vbi1jb25zdCBzdHJ1
Y3RzIGFzIGNvbnN0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogQXJ2aW5kIFlhZGF2IDxhcnZpbmQueWFk
YXYuY3NAZ21haWwuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMgfCAyICstCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBp
bmRleCA1ZGIwMjMwLi5hMmM4MzgwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwo+IEBAIC0xODYsNyArMTg2LDcgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X2V2aWN0
X2ZsYWdzKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCj4gICB7Cj4gICAJc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYoYm8tPmJkZXYpOwo+ICAgCXN0cnVj
dCBhbWRncHVfYm8gKmFibzsKPiAtCXN0YXRpYyBzdHJ1Y3QgdHRtX3BsYWNlIHBsYWNlbWVudHMg
PSB7Cj4gKwlzdGF0aWMgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSBwbGFjZW1lbnRzID0gewo+ICAg
CQkuZnBmbiA9IDAsCj4gICAJCS5scGZuID0gMCwKPiAgIAkJLmZsYWdzID0gVFRNX1BMX01BU0tf
Q0FDSElORyB8IFRUTV9QTF9GTEFHX1NZU1RFTQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
