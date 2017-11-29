From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: remove init of CIK VMIDs 8-16 for amdkfd
Date: Wed, 29 Nov 2017 17:57:26 +0100
Message-ID: <71a95f03-0775-f20a-d6df-2725fe212e80@daenzer.net>
References: <1511969038-3094-1-git-send-email-oded.gabbay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1511969038-3094-1-git-send-email-oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0xMS0yOSAwNDoyMyBQTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gVk1JRHMgOC0xNiBp
biBLYXZlcmkgd2VyZSByZXNlcnZlZCBmb3IgdXNlIGJ5IHRoZSBhbWRrZmQgZHJpdmVyLgo+IEJl
Y2F1c2Ugd2UgcmVtb3ZlZCBhbWRrZmQgc3VwcG9ydCBmcm9tIHJhZGVvbiwgdGhvc2UgVk1JRHMg
YXJlIG5vdwo+IHVzZWQgYnkgcmFkZW9uIGFuZCBhcmUgaW5pdGlhbGl6ZWQgYnkgcmFkZW9uLgo+
IAo+IFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgZnVuY3Rpb24gdGhhdCBpbml0aWFsaXplZCB0aG9z
ZSBWTUlEcyBmb3IgYW1ka2ZkCj4gdXNlLgo+IFRoaXMgaW5pdGlhbGl6YXRpb24gb3ZlcnJpZGRl
biB0aGUgcmFkZW9uIGluaXRpYWxpemF0aW9uIGFuZCBjYXVzZWQgR1BVCj4gZmF1bHRzIGFuZCBH
VUkgY3Jhc2hlZC4KPiAKPiBUaGlzIGJ1ZyB3YXMgZm91bmQgYnkgTWljaGVsIETDpG56ZXIuCj4g
Cj4gU2lnbmVkLW9mZi1ieTogT2RlZCBHYWJiYXkgPG9kZWQuZ2FiYmF5QGdtYWlsLmNvbT4KClB1
c2hlZCB0byBvdXIgaW50ZXJuYWwgYW1kLXN0YWdpbmctZHJtLW5leHQgYnJhbmNoLCB3aXRoIHNv
bWUKbW9kaWZpY2F0aW9ucyB0byB0aGUgdGFncyBpbiB0aGUgY29tbWl0IGxvZywgdGhhbmtzIQoK
CkFsZXgsIHRoaXMgbmVlZHMgdG8gZ28gaW50byA0LjE1LgoKCi0tIApFYXJ0aGxpbmcgTWljaGVs
IETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29t
CkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNh
IGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
