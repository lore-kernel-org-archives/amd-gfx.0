From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: [PATCH xf86-video-ati 0/4] Fixes ported from / inspired by
 modesetting driver changes
Date: Tue, 25 Oct 2016 17:41:24 +0900
Message-ID: <20161025084128.25410-1-michel@daenzer.net>
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpIYW5zIGRlIEdv
ZWRlICgxKToKICBQUklNRTogRml4IHN3YXBwaW5nIG9mIHByb3ZpZGVyIHNpbmsgLyBzb3VyY2Ug
Y2FwYWJpbGl0aWVzCgpNaWNoZWwgRMOkbnplciAoMyk6CiAgRG9uJ3QgcmVseSBvbiByYW5kcl9j
cnRjLT5zY2Fub3V0X3BpeG1hcCBpbiBkcm1tb2RlX3NldF9zY2Fub3V0X3BpeG1hcAogIEFsd2F5
cyBjYWxsIFBpeG1hcFN0b3BEaXJ0eVRyYWNraW5nIGluIGRybW1vZGVfc2V0X3NjYW5vdXRfcGl4
bWFwCiAgQ29uc3VtZSBhbGwgYXZhaWxhYmxlIHVkZXYgZXZlbnRzIGF0IG9uY2UKCiBzcmMvZHJt
bW9kZV9kaXNwbGF5LmMgfCAzMCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KIHNyYy9y
YWRlb25fa21zLmMgICAgICB8ICA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pCgotLSAKMi4xMC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
