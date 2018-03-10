From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/dce: Don't turn off DP sink when disconnected
Date: Sat, 10 Mar 2018 12:07:30 +0100
Message-ID: <1ffe3714-fd14-934a-801a-c5121ed76db2@daenzer.net>
References: <20180309172731.2256-1-michel@daenzer.net>
 <CADnq5_NA2OHe6eeiwou-HNNKNW0yt02_2dy3RUV2ouiDN7GjXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NA2OHe6eeiwou-HNNKNW0yt02_2dy3RUV2ouiDN7GjXw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOC0wMy0wOSAwOToyNiBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IE9uIEZyaSwgTWFy
IDksIDIwMTggYXQgMTI6MjcgUE0sIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+PiBGcm9tOiBNaWNoZWwgRMOkbnplciA8bWljaGVsLmRhZW56ZXJAYW1kLmNvbT4K
Pj4KPj4gVHVybmluZyBvZmYgdGhlIHNpbmsgaW4gdGhpcyBjYXNlIGNhdXNlcyB2YXJpb3VzIGlz
c3VlcywgYmVjYXVzZQo+PiB1c2Vyc3BhY2UgZXhwZWN0cyBpdCB0byBzdGF5IG9uIHVudGlsIGl0
IHR1cm5zIGl0IG9mZiBleHBsaWNpdGx5Lgo+Pgo+PiBJbnN0ZWFkLCB0dXJuIHRoZSBzaW5rIG9m
ZiBhbmQgYmFjayBvbiB3aGVuIGEgZGlzcGxheSBpcyBjb25uZWN0ZWQKPj4gYWdhaW4uIFRoaXMg
ZGFuY2Ugc2VlbXMgbmVjZXNzYXJ5IGZvciBsaW5rIHRyYWluaW5nIHRvIHdvcmsgY29ycmVjdGx5
Lgo+Pgo+PiBCdWd6aWxsYTogaHR0cHM6Ly9idWdzLmZyZWVkZXNrdG9wLm9yZy8xMDUzMDgKPj4g
U2lnbmVkLW9mZi1ieTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4g
Cj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
ClRoYW5rcyEgSXMgaXQgb2theSB0byBhZGQgQ2M6IHN0YWJsZSBhcyB3ZWxsPwoKCj4gQ2FyZSB0
byBzZW5kIGEgc2ltaWxhciBwYXRjaCBmb3IgcmFkZW9uIGFzIHdlbGw/CgpXaWxsIGRvLgoKCi0t
IApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
aHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAg
fCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
