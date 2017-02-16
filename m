From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: Use mode h/vdisplay fields to hide out of
 bounds HW cursor
Date: Thu, 16 Feb 2017 12:24:21 +0900
Message-ID: <c4231c82-da21-919d-ff67-cbff7d349038@daenzer.net>
References: <20170215023048.7337-1-michel@daenzer.net>
 <CADnq5_M_QG=Yn9uYTJjeNHoBQ2dnJkLywTLa5uaKgnYp+8RkcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_M_QG=Yn9uYTJjeNHoBQ2dnJkLywTLa5uaKgnYp+8RkcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

T24gMTUvMDIvMTcgMTE6NDcgQU0sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUdWUsIEZlYiAx
NCwgMjAxNyBhdCA5OjMwIFBNLCBNaWNoZWwgRMOkbnplciA8bWljaGVsQGRhZW56ZXIubmV0PiB3
cm90ZToKPj4gRnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4+
Cj4+IFRoZSBjcnRjX2gvdmRpc3BsYXkgZmllbGRzIG1heSBub3QgbWF0Y2ggdGhlIENSVEMgdmll
d3BvcnQgZGltZW5zaW9ucwo+PiB3aXRoIHNwZWNpYWwgbW9kZXMgc3VjaCBhcyBpbnRlcmxhY2Vk
IG9uZXMuCj4+Cj4+IEZpeGVzIHRoZSBIVyBjdXJzb3IgZGlzYXBwZWFyaW5nIGluIHRoZSBib3R0
b20gaGFsZiBvZiB0aGUgc2NyZWVuIHdpdGgKPj4gaW50ZXJsYWNlZCBtb2Rlcy4KPj4KPj4gRml4
ZXM6IDZiMTZjZjc3ODVhNCAoImRybS9yYWRlb246IEhpZGUgdGhlIEhXIGN1cnNvciB3aGlsZSBp
dCdzIG91dCBvZiBib3VuZHMiKQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+PiBSZXBv
cnRlZC1ieTogQXNodXRvc2ggS3VtYXIgPGFzaHV0b3NoLmt1bWFyQGFtZC5jb20+Cj4+IFRlc3Rl
ZC1ieTogU29ubnkgSmlhbmcgPHNvbm55LmppYW5nQGFtZC5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6
IE1pY2hlbCBEw6RuemVyIDxtaWNoZWwuZGFlbnplckBhbWQuY29tPgo+IAo+IFJldmlld2VkLWJ5
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpUaGFua3MhIFNpbmNl
IHRoaXMgZml4ZXMgYSByZWdyZXNzaW9uIGluIDQuMTAsIGFueSBjaGFuY2UgaXQgY2FuIGJlCnNu
ZWFrZWQgaW50byA0LjEwIGZpbmFsPwoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3
YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVs
b3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
