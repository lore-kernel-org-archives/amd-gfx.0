From: Dave Airlie <airlied@gmail.com>
Subject: sync_file rcu adoption and semaphore changes.
Date: Wed, 15 Mar 2017 14:27:45 +1000
Message-ID: <20170315042749.13259-1-airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

T2theSBJJ3ZlIGxpc3RlbmVkIGFuZCBwZW9wbGUgc2FpZCB0aGlzIHNob3VsZCB1c2UgcmN1LCBz
byBJJ3ZlCnRyaWVkIHRvIHdvcmsgb3V0IHdoYXQgdGhhdCBsb29rcyBsaWtlLCBhbmQgSSBwcmVz
ZW50IG15IGZpcnN0IHBhc3MKYXQgdXNpbmcgcmN1IGZvciBzeW5jX2ZpbGUuIEknbSBwcmV0dHkg
c3VyZSBJJ3ZlIHByb2JhYmx5IG1pc3NlZCBzb21lCmZ1bmRhbWVudGFsIHRoaW5ncyBoZXJlLgoK
QXMgdG8gQ2hyaXMncyByZXNlcnZlcmF0aW9uX29iamVjdCBxdWVzdGlvbnMsIHllcyBpdCBkb2Vz
IHRoZSByY3Ugc3R1ZmYKYW5kIEkgc3VwcG9zZSBpdCBkb2VzIHRoZSBleGNsdXNpdmUgZmVuY2Ug
KHdpdGggMCBzaGFyZWQgZmVuY2VzKSwgc28Kd2UnZCB3YW50IHRvIG1ha2Ugc3luY19maWxlIHdy
YXAgcmVzZXJ2YXRpb24gb2JqZWN0cywgbm90IHNlbWFwaG9yZXMsCnNpbmNlIHRoZSBtYWluIHJl
YXNvbiBJJ20gYXQgc3luYyBmaWxlcyBpbiB0aGUgZmlyc3QgcGxhY2UgaXMgdGhlIGZpbGUKcGFy
dCBmb3Igc2hhcmluZyB0aGVtIGJldHdlZW4gcHJvY2Vzc2VzLgoKRGF2ZS4KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
