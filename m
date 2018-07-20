From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: lock and unlock console only for
 amdgpu_fbdev_set_suspend [V2]
Date: Fri, 20 Jul 2018 09:34:25 +0200
Message-ID: <2362eda1-1e47-fd99-fdbd-c02c208d18bf@daenzer.net>
References: <1531909474-9661-1-git-send-email-shirish.s@amd.com>
 <ad4b3eec-d4d8-ceb5-dd11-e1562a82cc61@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ad4b3eec-d4d8-ceb5-dd11-e1562a82cc61-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wNy0xOSAxMToyMCBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gCj4gUG9zc2li
bGUgZm9sbG93LXVwIHdvcms6Cj4gCj4gKiBNb3ZlIHRoZSBjb25zb2xlXyh1bilsb2NrIGNhbGxz
IGludG8gYW1kZ3B1X2ZiZGV2X3NldF9zdXNwZW5kLCBvcgo+IG1heWJlIHVzZSBkcm1fZmJfaGVs
cGVyX3NldF9zdXNwZW5kX3VubG9ja2VkIGluc3RlYWQgb2YgbG9ja2luZyBvdXJzZWx2ZXMKPiAK
PiAqIE1vdmUgdGhlIGFtZGdwdV9mYmRldl9zZXRfc3VzcGVuZCBjYWxsIGluIGFtZGdwdV9kZXZp
Y2Vfc3VzcGVuZAo+IGZ1cnRoZXIgdXAsIGF0IGxlYXN0IGJlZm9yZSB0aGUgcGNpX3NldF9wb3dl
cl9zdGF0ZSBjYWxsLgoKU2hpcmlzaCwgd291bGQgeW91IGxpa2UgdG8gbG9vayBpbnRvIHRoZXNl
PwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAg
ICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
