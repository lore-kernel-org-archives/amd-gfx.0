From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 3/5] Keep CRTC properties consistent
Date: Fri, 13 Apr 2018 11:12:19 +0200
Message-ID: <ce4b5d31-7256-528c-8ec1-9ca1bf3d7ed7@daenzer.net>
References: <1522094418-9102-1-git-send-email-sunpeng.li@amd.com>
 <1522094418-9102-4-git-send-email-sunpeng.li@amd.com>
 <2fbbae9b-c874-7187-9b69-0a929dcaf5cf@daenzer.net>
 <0b884ad3-c193-9eab-ca93-ff0ca0672f1e@amd.com>
 <4cd3224e-fd14-e66f-56bf-b983b8f74bc8@daenzer.net>
 <78b780f2-d075-9496-e62a-8f6de989b992@amd.com>
 <cc580a31-0679-5492-afff-2ff683ca975d@daenzer.net>
 <f915a0db-4756-91de-e9dd-336da66060e6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f915a0db-4756-91de-e9dd-336da66060e6-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNC0xMiAwNjo0OCBQTSwgTGVvIExpIHdyb3RlOgo+Cj4gQSBzaWRlIHF1ZXN0aW9u
OiBIb3cgZG9lcyB4cmFuZHIgZGlzcGxheSBsZW5ndGh5IHByb3BlcnRpZXMsIGxpa2UgTFVUcz8K
ClByZXN1bWFibHkgaXQgd291bGQgYmUgZGlzcGxheWVkIHRoZSBzYW1lIHdheSBhcyB0aGUgRURJ
RCBwcm9wZXJ0eSwgZS5nLjoKCglFRElEOgoJCTAwZmZmZmZmZmZmZmZmMDAyMmYwNmYzMjAxMDEw
MTAxCgkJMTgxYjAxMDM4MDM0MjA3ODJhNGNhNWE3NTU0ZGEyMjYKCQkxMDUwNTQyMTA4MDBiMzAw
OTUwMDgxMDBkMWMwYTljMAoJCTgxYzBhOTQwODE4MDI4M2M4MGEwNzBiMDIzNDAzMDIwCgkJMzYw
MDA2NDQyMTAwMDAxYTAwMDAwMGZkMDAzMjNjMWUKCQk1MDExMDAwYTIwMjAyMDIwMjAyMDAwMDAw
MGZjMDA0OAoJCTUwMjA0NTMyMzQzMjBhMjAyMDIwMjAyMDAwMDAwMGZmCgkJMDA0MzRlNDMzNzMy
MzQzMDVhMzc0NzBhMjAyMDAxMTEKCQkwMjAzMThiMTQ4MTAxZjA0MTMwMzAyMTIxMTY3MDMwYwoJ
CTAwMTAwMDAwMjJlMjAwMmIwMjNhODAxODcxMzgyZDQwCgkJNTgyYzQ1MDAwNjQ0MjEwMDAwMWUw
MjNhODBkMDcyMzgKCQkyZDQwMTAyYzQ1ODAwNjQ0MjEwMDAwMWUwMTFkMDA3MgoJCTUxZDAxZTIw
NmUyODU1MDAwNjQ0MjEwMDAwMWUwMTFkCgkJMDBiYzUyZDAxZTIwYjgyODU1NDAwNjQ0MjEwMDAw
MWUKCQk4YzBhZDA4YTIwZTAyZDEwMTAzZTk2MDAwNjQ0MjEwMAoJCTAwMTgwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDJmCgoKPiBDYW4gdXNlcnMgc2V0IGl0IHZpYSAtLXNldCBzdGlsbD8KCk5v
dCBzdXJlLCBtYXliZSBub3QuIElmIG5vdCwgbWF5YmUgeW91IGNhbiB3cml0ZSBhIHNpbXBsZQpw
cm9vZi1vZi1jb25jZXB0IGNsaWVudCwgdGhhdCBzaG91bGQgYWxzbyBiZSB1c2VmdWwgZm9yIHJl
dmlldyBhbmQKdGVzdGluZyBvZiB0aGVzZSBwYXRjaGVzLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
