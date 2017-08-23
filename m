From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: check memory allocation failure
Date: Wed, 23 Aug 2017 10:39:14 +0200
Message-ID: <9a4b653f-6445-f8d3-70c9-91ca9b059839@amd.com>
References: <20170823055236.25451-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170823055236.25451-1-christophe.jaillet@wanadoo.fr>
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
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, alexander.deucher@amd.com, airlied@linux.ie, Monk.Liu@amd.com, David1.Zhou@amd.com, AlexBin.Xie@amd.com, Jerry.Zhang@amd.com, airlied@redhat.com, marek.olsak@amd.com, john@fastquake.com, andresx7@gmail.com, ray.huang@amd.com
Cc: kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMjMuMDguMjAxNyB1bSAwNzo1MiBzY2hyaWViIENocmlzdG9waGUgSkFJTExFVDoKPiBDaGVj
ayBtZW1vcnkgYWxsb2NhdGlvbiBmYWlsdXJlIGFuZCByZXR1cm4gLUVOT01FTSBpbiBzdWNoIGEg
Y2FzZS4KPgo+ICdudW1fcG9zdF9kZXBfc3luY29ianMnIHN0aWxsIGhhcyB0byBiZSBzZXQgdG8g
MCBiZWZvcmUgdGhlIHRlc3QgaW4gb3JkZXIKPiB0byBoYXZlIGl0IGluaXRpYWxpemVkIGlmICdh
bWRncHVfY3NfcGFyc2VyX2ZpbmkoKScgaXMgY2FsbGVkIHRvIGZyZWUKPiByZXNvdXJjZXMuCj4K
PiBUaGUgY2FsbGluZyBncmFwaCB3b3VsZCBiZSwgaW4gc3VjaCBhIGNhc2UhCj4gICAgIGZhaWx1
cmUgaW4gYW1kZ3B1X2NzX3Byb2Nlc3Nfc3luY29ial9vdXRfZGVwKCkKPiAgICAgICAgLS0tPiBl
cnJvciBjb2RlIHJldHVybmVkIGJ5IGFtZGdwdV9jc19kZXBlbmRlbmNpZXMoKQo+ICAgICAgICAg
ICAtLT4gYW1kZ3B1X2NzX3BhcnNlcl9maW5pKCkgaXMgY2FsbGVkCj4KPiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPgoKUmV2
aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4g
LS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYyB8IDMgKysrCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY3MuYwo+IGluZGV4IDE1ZDRhMjhkNzNiYi4uYmFhOTBkZjkwYWVhIDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPiBAQCAtMTA3OSw2ICsxMDc5
LDkgQEAgc3RhdGljIGludCBhbWRncHVfY3NfcHJvY2Vzc19zeW5jb2JqX291dF9kZXAoc3RydWN0
IGFtZGdwdV9jc19wYXJzZXIgKnAsCj4gICAJCQkJCSAgICAgR0ZQX0tFUk5FTCk7Cj4gICAJcC0+
bnVtX3Bvc3RfZGVwX3N5bmNvYmpzID0gMDsKPiAgIAo+ICsJaWYgKCFwLT5wb3N0X2RlcF9zeW5j
b2JqcykKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCj4gICAJZm9yIChpID0gMDsgaSA8IG51bV9k
ZXBzOyArK2kpIHsKPiAgIAkJcC0+cG9zdF9kZXBfc3luY29ianNbaV0gPSBkcm1fc3luY29ial9m
aW5kKHAtPmZpbHAsIGRlcHNbaV0uaGFuZGxlKTsKPiAgIAkJaWYgKCFwLT5wb3N0X2RlcF9zeW5j
b2Jqc1tpXSkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
