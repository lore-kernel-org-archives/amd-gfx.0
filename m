From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/ttm: swap consecutive allocated cached pages
Date: Mon, 4 Dec 2017 13:13:35 +0100
Message-ID: <133b2274-927e-231f-0887-a9113f4bf7fe@gmail.com>
References: <20171204114224.27712-1-christian.koenig@amd.com>
 <53e107e3-533a-eb68-26cc-9a764281eb56@daenzer.net>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <53e107e3-533a-eb68-26cc-9a764281eb56@daenzer.net>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Hongbo.He@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

QW0gMDQuMTIuMjAxNyB1bSAxMjo1MSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDIwMTct
MTItMDQgMTI6NDIgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFdoZW4gd2UgZGV0ZWN0
IGNvbnNlY3V0aXZlIGFsbG9jYXRpb24gb2YgcGFnZXMgc3dhcCB0aGVtIHRvIGF2b2lkCj4+IGFj
Y2lkZW50YWxseSBmcmVlaW5nIHRoZW0gYXMgaHVnZSBwYWdlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IC0tLQo+PiAg
IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYyB8IDggKysrKysrKysKPj4gICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9w
YWdlX2FsbG9jLmMKPj4gaW5kZXggYzgyZDk0Y2JiYWJjLi42MDQwMTM1MGEwMWEgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3BhZ2VfYWxsb2MuYwo+PiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vdHRtL3R0bV9wYWdlX2FsbG9jLmMKPj4gQEAgLTkyMSw2ICs5MjEsMTQgQEAg
c3RhdGljIGludCB0dG1fZ2V0X3BhZ2VzKHN0cnVjdCBwYWdlICoqcGFnZXMsIHVuc2lnbmVkIG5w
YWdlcywgaW50IGZsYWdzLAo+PiAgIAkJCQlyZXR1cm4gLUVOT01FTTsKPj4gICAJCQl9Cj4+ICAg
Cj4+ICsJCQkvKiBTd2FwIHRoZSBwYWdlcyBpZiB3ZSBkZXRlY3QgY29uc2VjdXRpdmUgb3JkZXIg
Ki8KPj4gKwkJCWlmIChpICYmIHBhZ2VzW2kgLSAxXSA9PSBwIC0gMSkgewo+PiArCQkJCXN0cnVj
dCBwYWdlICp0bXAgPSBwOwo+PiArCj4+ICsJCQkJcCA9IHBhZ2VzW2kgLSAxXTsKPj4gKwkJCQlw
YWdlc1tpIC0gMV0gPSB0bXA7Cj4+ICsJCQl9Cj4+ICsKPiBTaG91bGQgYmUgKHNvbWV0aGluZyBs
aWtlKToKPgo+IAkJaWYgKGkgJiYgcGFnZXNbaSAtIDFdID09IHAgLSAxKQo+IAkJCXN3YXAocGFn
ZXNbaSAtIDFdLCBwKTsKCkdvb2QgcG9pbnQsIHVwZGF0ZXMgcGF0Y2hlcyBzZW5kIG91dCBhIGZl
dyBzZWNvbmRzIGFnby4KClBsZWFzZSByZXZpZXcsCkNocmlzdGlhbi4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
