From: Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH v3 0/3] Enable S/G for Picasso
Date: Wed, 24 Jul 2019 10:10:39 -0400
Message-ID: <1563977442-4809-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Andrey Grodzovsky <andrey.grodzovsky-5C7GfCeVMHo@public.gmane.org>, hersenxs.wu-5C7GfCeVMHo@public.gmane.org, Christian.Koenig-5C7GfCeVMHo@public.gmane.org, shirish.s-5C7GfCeVMHo@public.gmane.org

Rmlyc3QgdHdvIHBhdGNoZXMgZml4IGEgaGFyZCBoYW5nIGludHJvZHVjZWQgYnkgcGxhY2luZyB0
aGUgZGlzcGxheSBCTyBpbiAKR1RUIG1lbW9yeSBiZWNhdXNlIG9mIEhXIGlzc3VlcyB3aXRoIGNh
Y2hlZCBtYXBwaW5ncy4gU2Vjb25kIHBhdGNoIGRvZXMKc29tZSBtaW5vciByZWFmYWN0b3Jpbmcg
dG8gcmVzdWUgY29kZSBpbiB0aHJpZCBwYXRjaC4gTGFzdCBwYXRjaCBlbmFibGVzIFMvRy4KCkFu
ZHJleSBHcm9kem92c2t5ICgyKToKICBkcm0vYW1kZ3B1OiBGaXggaGFyZCBoYW5nIGZvciBTL0cg
ZGlzcGxheSBCT3MuCiAgZHJtL2FtZGdwdTogQ3JlYXRlIGhlbHBlciB0byBjbGVhciBBTURHUFVf
R0VNX0NSRUFURV9DUFVfR1RUX1VTV0MKClNoaXJpc2ggUyAoMSk6CiAgZHJtL2FtZDogZW5hYmxl
IFMvRyBmb3IgUkFWRU4gY2hpcAoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNwbGF5LmMgICAgICAgfCAxNiArKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9mYi5jICAgICAgICAgICAgfCAgNyArKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9nZW0uYyAgICAgICAgICAgfCAgMyArLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X29iamVjdC5jICAgICAgICB8IDYzICsrKysrKysrKysrKystLS0tLS0tLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggICAgICAgIHwgIDIgKwog
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8ICAyICst
CiA2IGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQoKLS0g
CjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
