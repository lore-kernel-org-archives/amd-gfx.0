From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] dc.c:use kzalloc without test
Date: Fri, 25 Oct 2019 15:32:48 -0400
Message-ID: <CADnq5_Nv9j5vDX5-Jkhy3TTiej7FcKBBOC8QQk59NQ=SsO-3pg@mail.gmail.com>
References: <1571819543-15676-1-git-send-email-zhong.shiqi@zte.com.cn>
 <fa46cad1-8845-78b7-eb6a-45942813020b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <fa46cad1-8845-78b7-eb6a-45942813020b@amd.com>
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
Cc: "airlied@linux.ie" <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Lei,
 Jun" <Jun.Lei@amd.com>, "Koo, Anthony" <Anthony.Koo@amd.com>, "David.Francis@amd.com" <David.Francis@amd.com>, "Liu,
 Wenjing" <Wenjing.Liu@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "cheng.shengyu@zte.com.cn" <cheng.shengyu@zte.com.cn>, zhongshiqi <zhong.shiqi@zte.com.cn>, "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Aidan.Wood@amd.com" <Aidan.Wood@amd.com>, "xue.zhihong@zte.com.cn" <xue.zhihong@zte.com.cn>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Park, Chris" <Chris.Park@amd.com>, "Yang, Eric" <Eric.Yang2@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Laktyushkin,
 Dmytro" <Dmytro.Laktyu>
List-Id: amd-gfx.lists.freedesktop.org

QXBwbGllZC4gIHRoYW5rcyEKCkFsZXgKCk9uIFdlZCwgT2N0IDIzLCAyMDE5IGF0IDk6MzUgQU0g
SGFycnkgV2VudGxhbmQgPGh3ZW50bGFuQGFtZC5jb20+IHdyb3RlOgo+Cj4gT24gMjAxOS0xMC0y
MyA0OjMyIGEubS4sIHpob25nc2hpcWkgd3JvdGU6Cj4gPiBkYy5jOjU4MzpudWxsIGNoZWNrIGlz
IG5lZWRlZCBhZnRlciB1c2luZyBremFsbG9jIGZ1bmN0aW9uCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogemhvbmdzaGlxaSA8emhvbmcuc2hpcWlAenRlLmNvbS5jbj4KPgo+IFJldmlld2VkLWJ5OiBI
YXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KPgo+IEhhcnJ5Cj4KPiA+IC0t
LQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgfCA0ICsrKysK
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCj4gPiBpbmRleCA1ZDFhZGVkLi40Yjg4MTljIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwo+
ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYwo+ID4gQEAg
LTU4MCw2ICs1ODAsMTAgQEAgc3RhdGljIGJvb2wgY29uc3RydWN0KHN0cnVjdCBkYyAqZGMsCj4g
PiAgI2lmZGVmIENPTkZJR19EUk1fQU1EX0RDX0RDTjJfMAo+ID4gICAgICAgLy8gQWxsb2NhdGUg
bWVtb3J5IGZvciB0aGUgdm1faGVscGVyCj4gPiAgICAgICBkYy0+dm1faGVscGVyID0ga3phbGxv
YyhzaXplb2Yoc3RydWN0IHZtX2hlbHBlciksIEdGUF9LRVJORUwpOwo+ID4gKyAgICAgaWYgKCFk
Yy0+dm1faGVscGVyKSB7Cj4gPiArICAgICAgICAgICAgIGRtX2Vycm9yKCIlczogZmFpbGVkIHRv
IGNyZWF0ZSBkYy0+dm1faGVscGVyXG4iLCBfX2Z1bmNfXyk7Cj4gPiArICAgICAgICAgICAgIGdv
dG8gZmFpbDsKPiA+ICsgICAgIH0KPiA+Cj4gPiAgI2VuZGlmCj4gPiAgICAgICBtZW1jcHkoJmRj
LT5iYl9vdmVycmlkZXMsICZpbml0X3BhcmFtcy0+YmJfb3ZlcnJpZGVzLCBzaXplb2YoZGMtPmJi
X292ZXJyaWRlcykpOwo+ID4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
ZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs
