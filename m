From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/radeon: Bail earlier when radeon.cik_/si_support=0 is
 passed
Date: Tue, 10 Sep 2019 10:50:49 +0200
Message-ID: <22da19aa-0ab4-ab48-ab70-037ec41c2f87@daenzer.net>
References: <20190907203238.232005-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190907203238.232005-1-hdegoede@redhat.com>
Content-Language: en-CA
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Hans de Goede <hdegoede@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T24gMjAxOS0wOS0wNyAxMDozMiBwLm0uLCBIYW5zIGRlIEdvZWRlIHdyb3RlOgo+IEJhaWwgZnJv
bSB0aGUgcGNpX2RyaXZlciBwcm9iZSBmdW5jdGlvbiBpbnN0ZWFkIG9mIGZyb20gdGhlIGRybV9k
cml2ZXIKPiBsb2FkIGZ1bmN0aW9uLgo+IAo+IFRoaXMgYXZvaWQgL2Rldi9kcmkvY2FyZDAgdGVt
cG9yYXJpbHkgZ2V0dGluZyByZWdpc3RlcmVkIGFuZCB0aGVuCj4gdW5yZWdpc3RlcmVkIGFnYWlu
LCBzZW5kaW5nIHVud2FudGVkIGFkZCAvIHJlbW92ZSB1ZGV2IGV2ZW50cyB0bwo+IHVzZXJzcGFj
ZS4KPiAKPiBTcGVjaWZpY2FsbHkgdGhpcyBhdm9pZHMgdHJpZ2dlcmluZyB0aGUgKHVzZXJzcGFj
ZSkgYnVnIGZpeGVkIGJ5IHRoaXMKPiBwbHltb3V0aCBtZXJnZS1yZXF1ZXN0Ogo+IGh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9wbHltb3V0aC9wbHltb3V0aC9tZXJnZV9yZXF1ZXN0cy81
OQo+IAo+IE5vdGUgdGhhdCBkZXNwaXRlIHRoYXQgYmVpbmcgYW4gdXNlcnNwYWNlIGJ1Zywgbm90
IHNlbmRpbmcgdW5uZWNlc3NhcnkKPiB1ZGV2IGV2ZW50cyBpcyBhIGdvb2QgaWRlYSBpbiBnZW5l
cmFsLgo+IAo+IEJ1Z0xpbms6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5j
Z2k/aWQ9MTQ5MDQ5MAo+IFNpZ25lZC1vZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJl
ZGhhdC5jb20+CgpSZXZpZXdlZC1ieTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5j
b20+CgoKYW1kZ3B1IHNob3VsZCBiZSBjaGFuZ2VkIGNvcnJlc3BvbmRpbmdseSBhcyB3ZWxsLgoK
Ci0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgaHR0cHM6Ly9yZWRoYXQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAg
ICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWw=
