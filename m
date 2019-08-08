From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: next/master build: 230 builds: 5 failed, 225 passed, 6 errors,
 1344 warnings (next-20190805)
Date: Thu, 8 Aug 2019 12:20:53 -0700
Message-ID: <768ee31a-c870-4237-f38a-b176378072b6@roeck-us.net>
References: <5d47f990.1c69fb81.a5d88.ee1f@mx.google.com>
 <20190805111205.GB6432@sirena.org.uk> <20190808184149.GA441@roeck-us.net>
 <CADnq5_NL6+AohC-3HJa+84k50ewqYLMy_VuFmgY=aw872JFf-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CADnq5_NL6+AohC-3HJa+84k50ewqYLMy_VuFmgY=aw872JFf-A@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: David Zhou <David1.Zhou@amd.com>, kernel-build-reports@lists.linaro.org, David Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <dennis.li@amd.com>, Mark Brown <broonie@kernel.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

T24gOC84LzE5IDExOjUzIEFNLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4gT24gVGh1LCBBdWcgOCwg
MjAxOSBhdCAyOjUzIFBNIEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4gd3JvdGU6
Cj4+Cj4+IE9uIE1vbiwgQXVnIDA1LCAyMDE5IGF0IDEyOjEyOjA1UE0gKzAxMDAsIE1hcmsgQnJv
d24gd3JvdGU6Cj4+PiBPbiBNb24sIEF1ZyAwNSwgMjAxOSBhdCAwMjo0MDozMkFNIC0wNzAwLCBr
ZXJuZWxjaS5vcmcgYm90IHdyb3RlOgo+Pj4KPj4+IFRvZGF5J3MgLW5leHQgZmFpbHMgdG8gYnVp
bGQgYW4gYXJtIGFsbG1vZGNvbmZpZyBkdWUgdG86Cj4+Pgo+Pj4+IGFsbG1vZGNvbmZpZyAoYXJt
LCBnY2MtOCkg4oCUIEZBSUwsIDIgZXJyb3JzLCAxNiB3YXJuaW5ncywgMCBzZWN0aW9uIG1pc21h
dGNoZXMKPj4+Pgo+Pj4+IEVycm9yczoKPj4+PiAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYzoyNzk6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9m
IGZ1bmN0aW9uICdyZWFkcSc7IGRpZCB5b3UgbWVhbiAncmVhZGInPyBbLVdlcnJvcj1pbXBsaWNp
dC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPj4+PiAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kZXZpY2UuYzoyOTg6MzogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9m
IGZ1bmN0aW9uICd3cml0ZXEnOyBkaWQgeW91IG1lYW4gJ3dyaXRlYic/IFstV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+Pj4KPj4+IGR1ZSB0byA0ZmExYzZhNjc5YmIwIChk
cm0vYW1kZ3B1OiBhZGQgUlJFRzY0L1dSRUc2NChfUENJRSkgb3BlcmF0aW9ucykKPj4+IHdoaWNo
IGludHJvZHVjZXMgdXNlIG9mIHJlYWRxKCkgYW5kIHdyaXRlcSgpLgo+Pgo+PiBBRkFJQ1MgdGhp
cyBwcm9ibGVtIGFmZmVjdHMgYWxsIDMyLWJpdCBidWlsZHMsIGluY2x1ZGluZyBpMzg2Lgo+PiBJ
cyBpdCBpbiB0aGUgcHJvY2VzcyBvZiBiZWluZyBmaXhlZCwgb3Igc2hvdWxkIHdlIHN1Ym1pdCBh
Cj4+IHBhdGNoIGxpbWl0aW5nIERSTV9BTURHUFUgdG8gNjQtYml0IGJ1aWxkcyA/Cj4gCj4gWWVz
LCB0aGUgZml4IGlzIGJlaW5nIGRpc2N1c3NlZCBoZXJlOgo+IGh0dHBzOi8vcGF0Y2h3b3JrLmZy
ZWVkZXNrdG9wLm9yZy9wYXRjaC8zMjIyMTMvCj4gCgpQbGVhc2Ugbm90ZSB0aGF0IHRoaXMgZG9l
cyBmYWlsIGZvciBpMzg2ICgzMi1iaXQgeDg2KSBidWlsZHMsIGNvbnRyYXJ5IHRvIHRoZSBpbmZv
cm1hdGlvbgppbiB0aGF0IGRpc2N1c3Npb24uIEFsc28sIGZyb20gbG9va2luZyBpbnRvIHRoZSBr
ZXJuZWwsIEkgb25seSBzZWUgcmVhZHEvd3JpdGVxIGRlZmluZWQKZm9yIGFyY2gveDg2IGluIDY0
LWJpdCBtb2RlOyBzZWUgYXJjaC94ODYvaW5jbHVkZS9hc20vaW8uaC4KCkd1ZW50ZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
