From: Shawn Starr <shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org>
Subject: [REGRESSION][drm-next-4.10-wip][CIK] Mobile Bonaire - Hangs on
 hibernation commmit 86f8c599b09c916f9aad30563271440dbd79213a
Date: Fri, 02 Dec 2016 11:15:36 -0500
Message-ID: <2915875.5HliZOPTc4@segfault>
References: <2621170.33kZe0Otco@segfault>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <2621170.33kZe0Otco@segfault>
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

T24gTW9uZGF5LCBPY3RvYmVyIDMxLCAyMDE2IDE6NTY6MjcgQU0gRVNUIFNoYXduIFN0YXJyIHdy
b3RlOgo+IExvb2tzIGxpa2UgcmVjZW50IGNoYW5nZXMgc29tZXdoZXJlIGJyb2tlIGhpYmVybmF0
aW9uIGZvciBtZSwgaSdsbCBoYXZlIHRvCj4gYmlzZWN0IHRvIHNlZSB3aGljaCBwYXRjaCBkaWQg
c28uCj4gCj4gVGhhbmtzLAo+IFNoYXduCgpIZWxsbyBBTUQgRm9sa3MsCgpJIGRpZCBmaW5kIHRo
ZSByZWdyZXNzaW9uOgoKaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9OTg1MTMKCldoaWxlIGl0IHNlZW1zIGNvdW50ZXJpbnR1aXRpdmUsIHJldmVydGluZyBjb21t
aXQgCjg2ZjhjNTk5YjA5YzkxNmY5YWFkMzA1NjMyNzE0NDBkYmQ3OTIxM2EgYWxsb3dzIG1lIHRv
IGhpYmVybmF0ZS4KCkkgdHlwaWNhbGx5IHVzZSBoaWJlcm5hdGUgYW5kIHJlYm9vdCwgdnMgaGli
ZXJuYXRlIGFuZCBwb3dlciBvZmYsIHVubGVzcyB0aGlzIApzb21laG93IGRpZmZlcnMuCgpUaGlz
IGJ1ZyBpcyBzdGlsbCBoYXBwZW5zIGluIGxpbnV4IDQuOS1yYzcgYW5kIGluIGRybS1uZXh0LTQu
MTAtd2lwIGJyYW5jaGVzLgoKQW55b25lIGZyb20gQU1EIG1pZ2h0IGJlIGFibGUgdG8gdW5kZXJz
dGFuZCB3aHkgdGhpcyBjb2RlIGJyZWFrcyBvbiBhIG1vYmlsZSAKQ0lLIHBhcnQ/CgpUaGFua3Ms
ClNoYXduCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
