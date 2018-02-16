From: Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] Creating and enabling BT I2S controller instance for AMD
 APUs
Date: Fri, 16 Feb 2018 14:14:02 +0530
Message-ID: <1518770646-8538-1-git-send-email-Vijendar.Mukunda@amd.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, Vijendar Mukunda <Vijendar.Mukunda-5C7GfCeVMHo@public.gmane.org>

VGhpcyBwYXRjaCBzZXQgdXBkYXRlcyB0aGUgQU1EIEdQVSBkcml2ZXJzLgpUaGlzIHBhdGNoIHNl
dCBjcmVhdGVzIEJUIEkyUyBjb250cm9sbGVyIGluc3RhbmNlLgpEZWZhdWx0IGVuYWJsZWQgSTJT
IGNvbnRyb2xsZXIgaW5zdGFuY2UgaXMgSTJTIFNQIGluc3RhbmNlLgpUaGVyZSBpcyBhIHJlcXVp
cmVtZW50IHRvIGVuYWJsZSBCVCBJMlMgY29udHJvbGxlciBJbnN0YW5jZSBhbG9uZyB3aXRoIEky
UyBTUCBjb250cm9sbGVyIGluc3RhbmNlLgoKVGhlIGN1cnJlbnQgY29kZSBpcyBiYXNlZCBvbiBk
cm0tbmV4dCBicmFuY2guCgpBa3NodSBBZ3Jhd2FsICgyKToKICBkcm0vYW1kL2FtZGdwdTogQWRk
cyBEV19JMlNfUVVJUktfQ09NUF9QQVJBTTEgdG8gQlQgcGxheWJhY2sKICBkcm0vYW1kL2FtZGdw
dTogRml4ZXMgcmVzb3VyY2UgY29uZmxpY3QgaXNzdWUgb24gQlQgaW5zdGFuY2UKClZpamVuZGFy
IE11a3VuZGEgKDIpOgogIGRybS9hbWQvYW1kZ3B1OiBjcmVhdGluZyB0d28gSTJTIGluc3RhbmNl
cyBmb3Igc3RvbmV5L2N6CiAgZHJtL2FtZC9hbWRncHU6IEVuYWJsaW5nIEJUIEkyUyBjb25maWcg
Zm9yIG11eGVkIHBpbnMKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwLmMg
fCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3
NSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKLS0gCjIuNy40CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
