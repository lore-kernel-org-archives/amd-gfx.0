From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Date: Wed, 25 Apr 2018 16:18:07 +0200
Message-ID: <20180425141807.GA8212@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
 <20180424194418.GE25142@phenom.ffwll.local>
 <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
 <20180424214027.GG25142@phenom.ffwll.local>
 <20180425132228.GC7592@redhat.com>
 <CAKMK7uF7LumuFWw3Xezw+QYDEhz6pFrJueZqFvSnmmoynYqpgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CAKMK7uF7LumuFWw3Xezw+QYDEhz6pFrJueZqFvSnmmoynYqpgQ@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: David.Panariti@amd.com, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <Alexander.Deucher@amd.com>, Andrew Morton <akpm@linux-foundation.org>, Christian =?iso-8859-1?Q?K=F6nig?= <Christian.Koenig@amd.com>, Eric Biederman <ebiederm@xmission.com>
List-Id: amd-gfx.lists.freedesktop.org

T24gMDQvMjUsIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4KPiBPbiBXZWQsIEFwciAyNSwgMjAxOCBh
dCAzOjIyIFBNLCBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24g
MDQvMjQsIERhbmllbCBWZXR0ZXIgd3JvdGU6Cj4gPj4KPiA+PiB3YWl0X2V2ZW50X2tpbGxhYmVs
IGRvZXNuJ3QgY2hlY2sgZm9yIGZhdGFsX3NpZ25hbF9wZW5kaW5nIGJlZm9yZSBjYWxsaW5nCj4g
Pj4gc2NoZWR1bGUsIHNvIGRlZmluaXRlbHkgaGFzIGEgbmljZSByYWNlIHRoZXJlLgo+ID4KPiA+
IFRoaXMgaXMgZmluZS4gU2VlIHRoZSBzaWduYWxfcGVuZGluZ19zdGF0ZSgpIGNoZWNrIGluIF9f
c2NoZWR1bGUoKS4KPiA+Cj4gPiBBbmQgdGhpcyBkb2Vzbid0IGRpZmZlciBmcm9tIHdhaXRfZXZl
bnRfaW50ZXJydXB0aWJsZSgpLCBpdCB0b28gZG9lc24ndAo+ID4gY2hlY2sgc2lnbmFsX3BlbmRp
bmcoKSwgd2UgcmVseSBvbiBzY2hlZHVsZSgpIHdoaWNoIG11c3Qgbm90IGJsb2NrIGlmIHRoZQo+
ID4gY2FsbGVyIGlzIHNpZ25hbGxlZC9raWxsZWQuCj4gPgo+ID4gVGhlIHByb2JsZW0gaXMgdGhh
dCBpdCBpcyBub3QgY2xlYXIgd2hhdCBzaG91bGQgZmF0YWxfc2lnbmFsX3BlbmRpbmcoKSBvcgo+
ID4gZXZlbiBzaWduYWxfcGVuZGluZygpIG1lYW4gYWZ0ZXIgZXhpdF9zaWduYWxzKCkuCj4KPiBV
aCwgSSB3YXMgdG90YWxseSB0aHJvd24gb2ZmIGluIGFsbCB0aGUgd2FpdF9ldmVudCogbWFjcm9z
IGFuZCBzb21laG93Cj4gbGFuZGVkIGluIHRoZSBfbG9ja2VkIHZhcmlhbnRzLCB3aGljaCBhbGwg
bmVlZCB0byByZWNoZWNrIGJlZm9yZSB0aGV5Cj4gZHJvcCB0aGUgbG9jaywgZm9yIGVmZmljaWVu
Y3kgcmVhc29ucy4gU2VlIGRvX3dhaXRfaW50cigpLgoKSnVzdCBpbiBjYXNlLCBub3RlIHRoYXQg
ZG9fd2FpdF9pbnRyKCkgaGFzIHRvIGNoZWNrIHNpZ25hbF9wZW5kaW5nKCkgZm9yCmNvbXBsZXRl
bHkgZGlmZmVyZXJlbnQgcmVhc29uLiBXZSBuZWVkIHRvIHJldHVybiBub24temVybyBjb2RlIHRv
IHN0b3AgdGhlCm1haW4gbG9vcCBpbiBfX3dhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV9sb2NrZWQo
KTsgdW5saWtlIF9fX3dhaXRfZXZlbnQoKQppdCBkb2Vzbid0IGNoZWNrIHNpZ25hbF9wZW5kaW5n
KCkgaXRzZWxmLgoKT2xlZy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ry
aS1kZXZlbAo=
