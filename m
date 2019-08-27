From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/display: remove unused function
 setFieldWithMask
Date: Tue, 27 Aug 2019 10:20:13 -0400
Message-ID: <CADnq5_Pe-qnTWZrDxmC=xqHJBQ_SkaBv8go9mVWWp7MciC4NHA@mail.gmail.com>
References: <20190827070925.16080-1-yuehaibing@huawei.com>
 <fb49a1d9-8405-4f88-6f9a-af863bd0f657@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <fb49a1d9-8405-4f88-6f9a-af863bd0f657@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Harry Wentland <hwentlan@amd.com>
Cc: "Tatla, Harmanprit" <Harmanprit.Tatla@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, YueHaibing <yuehaibing@huawei.com>, "Othman, Ahmad" <Ahmad.Othman@amd.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alvin.lee3@amd.com" <alvin.lee3@amd.com>, "airlied@linux.ie" <airlied@linux.ie>, "Bernstein,
 Eric" <Eric.Bernstein@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gVHVlLCBBdWcgMjcsIDIwMTkgYXQgMTA6MDEgQU0gSGFycnkgV2VudGxhbmQgPGh3ZW50bGFu
QGFtZC5jb20+IHdyb3RlOgo+Cj4gT24gMjAxOS0wOC0yNyAzOjA5IGEubS4sIFl1ZUhhaWJpbmcg
d3JvdGU6Cj4gPiBBZnRlciBjb21taXQgYTlmNTRjZTNjNjAzICgiZHJtL2FtZC9kaXNwbGF5OiBS
ZWZhY3RvcmluZyBWVEVNIiksCj4gPiB0aGVyZSBpcyBubyBjYWxsZXIgaW4gdHJlZS4KPiA+Cj4g
PiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+IFNpZ25lZC1vZmYt
Ynk6IFl1ZUhhaWJpbmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4KPgo+IFJldmlld2VkLWJ5OiBI
YXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPgoKQXBwbGllZC4gIFRoYW5r
cyEKCkFsZXgKCj4gSGFycnkKPgo+ID4gLS0tCj4gPiAgLi4uL2RybS9hbWQvZGlzcGxheS9tb2R1
bGVzL2luZm9fcGFja2V0L2luZm9fcGFja2V0LmMgfCAxOSAtLS0tLS0tLS0tLS0tLS0tLS0tCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDE5IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmZvX3BhY2tldC9pbmZvX3BhY2tl
dC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaW5mb19wYWNrZXQvaW5m
b19wYWNrZXQuYwo+ID4gaW5kZXggNWY0Yjk4ZC4uZDg4NWQ2NCAxMDA2NDQKPiA+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2luZm9fcGFja2V0L2luZm9fcGFja2V0
LmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2luZm9fcGFj
a2V0L2luZm9fcGFja2V0LmMKPiA+IEBAIC0xMTQsMjUgKzExNCw2IEBAIGVudW0gQ29sb3JpbWV0
cnlZQ0NEUCB7Cj4gPiAgICAgICBDb2xvcmltZXRyeVlDQ19EUF9JVFUyMDIwWUNiQ3IgID0gNywK
PiA+ICB9Owo+ID4KPiA+IC12b2lkIHNldEZpZWxkV2l0aE1hc2sodW5zaWduZWQgY2hhciAqZGVz
dCwgdW5zaWduZWQgaW50IG1hc2ssIHVuc2lnbmVkIGludCB2YWx1ZSkKPiA+IC17Cj4gPiAtICAg
ICB1bnNpZ25lZCBpbnQgc2hpZnQgPSAwOwo+ID4gLQo+ID4gLSAgICAgaWYgKCFtYXNrIHx8ICFk
ZXN0KQo+ID4gLSAgICAgICAgICAgICByZXR1cm47Cj4gPiAtCj4gPiAtICAgICB3aGlsZSAoISgo
bWFzayA+PiBzaGlmdCkgJiAxKSkKPiA+IC0gICAgICAgICAgICAgc2hpZnQrKzsKPiA+IC0KPiA+
IC0gICAgIC8vcmVzZXQKPiA+IC0gICAgICpkZXN0ID0gKmRlc3QgJiB+bWFzazsKPiA+IC0gICAg
IC8vc2V0Cj4gPiAtICAgICAvL2RvbnQgbGV0IHZhbHVlIHNwYW4gcGFzdCBtYXNrCj4gPiAtICAg
ICB2YWx1ZSA9IHZhbHVlICYgKG1hc2sgPj4gc2hpZnQpOwo+ID4gLSAgICAgLy9pbnNlcnQgdmFs
dWUKPiA+IC0gICAgICpkZXN0ID0gKmRlc3QgfCAodmFsdWUgPDwgc2hpZnQpOwo+ID4gLX0KPiA+
IC0KPiA+ICB2b2lkIG1vZF9idWlsZF92c2NfaW5mb3BhY2tldChjb25zdCBzdHJ1Y3QgZGNfc3Ry
ZWFtX3N0YXRlICpzdHJlYW0sCj4gPiAgICAgICAgICAgICAgIHN0cnVjdCBkY19pbmZvX3BhY2tl
dCAqaW5mb19wYWNrZXQpCj4gPiAgewo+ID4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVs
