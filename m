From: Pratik Vishwakarma <Pratik.Vishwakarma-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/3] Fix S3 entry crashes
Date: Wed,  6 Jun 2018 14:55:39 +0530
Message-ID: <1528277142-20316-1-git-send-email-Pratik.Vishwakarma@amd.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Harry.Wentland-5C7GfCeVMHo@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org

VGhpcyBwYXRjaCBzZXJpZXMgcmVzb2x2ZXMgY3Jhc2hlcyBvYnNlcnZlZCBkdXJpbmcgUzMgZW50
cnkuCkZpcnN0IHBhdGNoIHJlbW92ZXMgdGhlIGN1cnNvciBCTyBoYWNrIHdoaWNoIGNhdXNlcyBj
cmFzaGVzCm1lbnRpb25lZCBpbiBwYXRjaGVzIDIgYW5kIDMuIFBhdGNoZXMgMiBhbmQgMyBhZGQg
TlVMTApjaGVja3MgdG8gcHJldmVudCBjcmFzaGluZyB0aGUgc3lzdGVtLgoKUHJhdGlrIFZpc2h3
YWthcm1hICgzKToKICBkcm0vYW1kL2Rpc3BsYXk6IFJlbW92ZSBjdXJzb3IgaGFjayBmb3IgUzMK
ICBkcm0vYW1kL2FtZGdwdTogRml4IGNyYXNoIGluIGFtZGdwdV9ib19yZXNlcnZlCiAgZHJtL2Ft
ZC9hbWRncHU6IEZpeCBOVUxMIHBvaW50ZXIgT09QUyBkdXJpbmcgUzMKCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggICAgICAgIHwgIDIgKysKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICAgICAgICAgfCAxNyArKysrKysrKysrKysr
LS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8
IDExIC0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDE1IGRl
bGV0aW9ucygtKQoKLS0gCjEuOS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
