From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nhaehnle@gmail.com>
Subject: [PATCH 0/2] drm/ttm, amdgpu: fix use-after-free in recent deadlock fix
Date: Tue, 14 Feb 2017 10:18:43 +0100
Message-ID: <20170214091845.1225-1-nhaehnle@gmail.com>
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
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

SGkgYWxsLAoKYmFzZWQgb24gbXkgY3VycmVudCB0aGVvcnkgb24gaG93IGEgZGVhZGxvY2sgY291
bGQgaGFwcGVuIGluIHRoZQpidWZmZXIgYWxsb2NhdGlvbiBjb2RlLCB0aGVzZSB0d28gcGF0Y2hl
cyBzaG91bGQgZml4IHRoZSBkZWFkbG9jawp3aXRob3V0IGhhdmluZyBhIHVzZS1hZnRlci1mcmVl
LgoKSSdtIHN0aWxsIHdvcmtpbmcgb24gYSB3YXkgdG8gY2xlYW4gdXAgdGhlIHR0bV9ib19pbml0
IHNlcXVlbmNlCm92ZXJhbGwsIGJ1dCBJJ20gc2VwYXJhdGluZyB0aGVzZSB0d28gb3V0IGZvciBh
IGhvcGVmdWxseSBxdWljayBmaXgsCnNpbmNlIGluIG15IGJvb2sgdXNlLWFmdGVyLWZyZWVzIGFy
ZSB3b3JzZSB0aGFuIGRlYWRsb2Nrcy4KClNhbXVlbCwgSSdkIHZlcnkgbXVjaCBhcHByZWNpYXRl
IGlmIHlvdSBjb3VsZCBjaGVjayB0aGF0IHRoZQpkZWFkbG9ja3MgaW4gSGl0bWFuIHJlbWFpbiBm
aXhlZCB3aXRoIHRoZXNlIHR3byBwYXRjaGVzLgoKVGhhbmtzLApOaWNvbGFpCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBs
aXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
