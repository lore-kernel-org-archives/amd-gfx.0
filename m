From: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 18/23] drm/amdgpu: add new maroc to identify virtualization ip
 block
Date: Sun, 18 Dec 2016 00:16:40 +0800
Message-ID: <1481991405-30422-19-git-send-email-Xiangliang.Yu@amd.com>
References: <1481991405-30422-1-git-send-email-Xiangliang.Yu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1481991405-30422-1-git-send-email-Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dl.SRDC_SW_GPUVirtualization-5C7GfCeVMHo@public.gmane.org
Cc: Xiangliang Yu <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>

Q3JlYXRlIGEgbmV3IGlwIGJsb2NrIGZvciB2aXJ0dWFsaXphdGlvbiwgaXRzIG1haW4gcm9sZSBp
cyB0byBtYWtlCnZpcnR1YWwgY29kZSBpbmRlcGVuZGVudCBhbmQgZmxleGlibGUsIGFuZCBhbHNv
IGVhcnkgdG8gbWFpbnRhaW5lcgp2aXJ0dWFsaXphdGlvbiBjb2RlLgoKU2lnbmVkLW9mZi1ieTog
WGlhbmdsaWFuZyBZdSA8WGlhbmdsaWFuZy5ZdUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9hbWRfc2hhcmVkLmggfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRfc2hh
cmVkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYW1kX3NoYXJlZC5oCmluZGV4IDll
NTU1YzcuLmNlMzY4MzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9h
bWRfc2hhcmVkLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FtZF9zaGFyZWQu
aApAQCAtNjksNiArNjksNyBAQCBlbnVtIGFtZF9pcF9ibG9ja190eXBlIHsKIAlBTURfSVBfQkxP
Q0tfVFlQRV9TTUMsCiAJQU1EX0lQX0JMT0NLX1RZUEVfRENFLAogCUFNRF9JUF9CTE9DS19UWVBF
X0dGWCwKKwlBTURfSVBfQkxPQ0tfVFlQRV9YR1BVLAogCUFNRF9JUF9CTE9DS19UWVBFX1NETUEs
CiAJQU1EX0lQX0JMT0NLX1RZUEVfVVZELAogCUFNRF9JUF9CTE9DS19UWVBFX1ZDRSwKLS0gCjIu
Ny40CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
