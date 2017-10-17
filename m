From: Pixel Ding <Pixel.Ding-5C7GfCeVMHo@public.gmane.org>
Subject: Make staging driver stable for SRIOV VF (1 v2)
Date: Tue, 17 Oct 2017 14:25:07 +0800
Message-ID: <1508221510-7159-1-git-send-email-Pixel.Ding@amd.com>
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
Cc: Gary.Sun-5C7GfCeVMHo@public.gmane.org, Bingley.Li-5C7GfCeVMHo@public.gmane.org

VGhpcyBpcyB0aGUgZmlyc3QgcGF0Y2ggc2VyaWVzIHRvIG1ha2UgbGF0ZXN0IHN0YWdpbmcgZHJp
dmVyCnN0YWJsZSBmb3IgU1JJT1YgVkYgb24gYm90aCBUb25nYSBhbmQgVmVnYS4gUGF0Y2hlcyBh
cmUgbWVyZ2VkCmZyb20gU1JJT1YgYnJhbmNoZXMgb3IgcmVpbXBsZW1lbnRlZCwgaW5jbHVkaW5n
IGJ1ZyBmaXhlcyBhbmQKc21hbGwgZmVhdHVyZXMgcmVxdWVzdGVkIGJ5IFNSSU9WIHVzZXJzLiAg
Cgp2MjogImRybS9hbWRncHU6IHdvcmthcm91bmQgZm9yIFZNIGZhdWx0IGNhdXNlZCBieSBTRE1B
IiBpcyBkcm9wcGVkLgoKUGxlYXNlIGhlbHAgcmV2aWV3aW5nLCBUaGFua3MuCgpbUEFUQ0ggMS8z
XSBkcm0vYW1kZ3B1OiB3b3JrYXJvdW5kIGZvciBWTSBmYXVsdCBjYXVzZWQgYnkgU0RNQQpbUEFU
Q0ggMi8zXSBkcm0vYW1kZ3B1OiByZXBvcnQgbW9yZSBhbWRncHVfZmVuY2VfaW5mbyB2MgpbUEFU
Q0ggMy8zXSBkcm0vYW1kZ3B1OiBidXN5d2FpdCBLSVEgcmVnaXN0ZXIgYWNjZXNzaW5nIHYyCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
