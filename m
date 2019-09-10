From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] drm/radeon: Bail earlier when radeon.cik_/si_support=0 is
 passed
Date: Tue, 10 Sep 2019 10:36:10 +0100
Message-ID: <3c0eb318-6c30-fc98-4005-80b5c00b8f5e@redhat.com>
References: <20190907203238.232005-1-hdegoede@redhat.com>
 <22da19aa-0ab4-ab48-ab70-037ec41c2f87@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <22da19aa-0ab4-ab48-ab70-037ec41c2f87@daenzer.net>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGksCgpPbiA5LzEwLzE5IDk6NTAgQU0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+IE9uIDIwMTkt
MDktMDcgMTA6MzIgcC5tLiwgSGFucyBkZSBHb2VkZSB3cm90ZToKPj4gQmFpbCBmcm9tIHRoZSBw
Y2lfZHJpdmVyIHByb2JlIGZ1bmN0aW9uIGluc3RlYWQgb2YgZnJvbSB0aGUgZHJtX2RyaXZlcgo+
PiBsb2FkIGZ1bmN0aW9uLgo+Pgo+PiBUaGlzIGF2b2lkIC9kZXYvZHJpL2NhcmQwIHRlbXBvcmFy
aWx5IGdldHRpbmcgcmVnaXN0ZXJlZCBhbmQgdGhlbgo+PiB1bnJlZ2lzdGVyZWQgYWdhaW4sIHNl
bmRpbmcgdW53YW50ZWQgYWRkIC8gcmVtb3ZlIHVkZXYgZXZlbnRzIHRvCj4+IHVzZXJzcGFjZS4K
Pj4KPj4gU3BlY2lmaWNhbGx5IHRoaXMgYXZvaWRzIHRyaWdnZXJpbmcgdGhlICh1c2Vyc3BhY2Up
IGJ1ZyBmaXhlZCBieSB0aGlzCj4+IHBseW1vdXRoIG1lcmdlLXJlcXVlc3Q6Cj4+IGh0dHBzOi8v
Z2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9wbHltb3V0aC9wbHltb3V0aC9tZXJnZV9yZXF1ZXN0cy81
OQo+Pgo+PiBOb3RlIHRoYXQgZGVzcGl0ZSB0aGF0IGJlaW5nIGFuIHVzZXJzcGFjZSBidWcsIG5v
dCBzZW5kaW5nIHVubmVjZXNzYXJ5Cj4+IHVkZXYgZXZlbnRzIGlzIGEgZ29vZCBpZGVhIGluIGdl
bmVyYWwuCj4+Cj4+IEJ1Z0xpbms6IGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1
Zy5jZ2k/aWQ9MTQ5MDQ5MAo+PiBTaWduZWQtb2ZmLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2Vk
ZUByZWRoYXQuY29tPgo+IAo+IFJldmlld2VkLWJ5OiBNaWNoZWwgRMOkbnplciA8bWRhZW56ZXJA
cmVkaGF0LmNvbT4KClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4gSSd2ZSBkcm0gcHVzaCByaWdo
dHMsIGJ1dCBJIGd1ZXNzIHRoYXQgcmFkZW9uL2FtZApHUFUgcGF0Y2hlcyBhcmUgY29sbGVjdGVk
IGJ5IHNvbWVvbmUgQEFNRCwgc28gSSBkbyBub3QgbmVlZCB0byAvIHNob3VsZCBub3QKcHVzaCB0
aGlzIG15c2VsZiwgcmlnaHQ/Cgo+IGFtZGdwdSBzaG91bGQgYmUgY2hhbmdlZCBjb3JyZXNwb25k
aW5nbHkgYXMgd2VsbC4KCkdvb2QgcG9pbnQuIEknbSBjdXJyZW50bHkgdHJhdmVsbGluZyAoQHBs
dW1iZXJzKSBJIGNhbiBkbyB0aGlzIHdoZW4gSSdtIGJhY2sgaG9tZSwKYnV0IGZlZWwgZnJlZSB0
byBiZWF0IG1lIHRvIGl0IChpZiB5b3UgZG8gcGxlYXNlIENjIG1lIHRvIGF2b2lkIGRvdWJsZSB3
b3JrKS4KClJlZ2FyZHMsCgpIYW5zCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbA==
