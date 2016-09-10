From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: [PATCH 3/7] amdkfd: Add some missing memset zero'ing in queue init
 func
Date: Sat, 10 Sep 2016 11:31:35 +1000
Message-ID: <1473471099-16914-4-git-send-email-funfunctor@folklore1984.net>
References: <1473471099-16914-1-git-send-email-funfunctor@folklore1984.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1473471099-16914-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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

U2lnbmVkLW9mZi1ieTogRWR3YXJkIE8nQ2FsbGFnaGFuIDxmdW5mdW5jdG9yQGZvbGtsb3JlMTk4
NC5uZXQ+ClJldmlld2VkLWJ5OiBPZGVkIEdhYmJheSA8b2RlZC5nYWJiYXlAZ21haWwuY29tPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYyB8IDMgKysr
CiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX2tlcm5lbF9xdWV1ZS5jCmluZGV4IDliZWFlODcuLjI5MWM2OWQgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9rZXJuZWxfcXVldWUuYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfa2VybmVsX3F1ZXVlLmMKQEAgLTQ3LDYg
KzQ3LDkgQEAgc3RhdGljIGJvb2wgaW5pdGlhbGl6ZShzdHJ1Y3Qga2VybmVsX3F1ZXVlICprcSwg
c3RydWN0IGtmZF9kZXYgKmRldiwKIAlwcl9kZWJ1ZygiYW1ka2ZkOiBJbiBmdW5jICVzIGluaXRp
YWxpemluZyBxdWV1ZSB0eXBlICVkIHNpemUgJWRcbiIsCiAJCQlfX2Z1bmNfXywgS0ZEX1FVRVVF
X1RZUEVfSElRLCBxdWV1ZV9zaXplKTsKIAorCW1lbXNldCgmcHJvcCwgMCwgc2l6ZW9mKHByb3Ap
KTsKKwltZW1zZXQoJm5vcCwgMCwgc2l6ZW9mKG5vcCkpOworCiAJbm9wLm9wY29kZSA9IElUX05P
UDsKIAlub3AudHlwZSA9IFBNNF9UWVBFXzM7CiAJbm9wLnUzMmFsbCB8PSBQTTRfQ09VTlRfWkVS
TzsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
