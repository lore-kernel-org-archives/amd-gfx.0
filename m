From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 09/12] drm/amdgpu/sriov:return -ENODEV if gpu reseted
Date: Tue, 10 Oct 2017 10:17:08 +0200
Message-ID: <3c027592-f381-aa63-7648-711e650b8fbe@daenzer.net>
References: <1506751432-21789-1-git-send-email-Monk.Liu@amd.com>
 <1506751432-21789-10-git-send-email-Monk.Liu@amd.com>
 <6e81d8b0-267a-1ea8-b228-93286fc6a954@gmail.com>
 <BLUPR12MB0449531313F50BE080F7746D84740@BLUPR12MB0449.namprd12.prod.outlook.com>
 <71b411c8-21a6-fe9b-ed33-7928571a88da@gmail.com>
 <BLUPR12MB04492B28DF57EACE2149562D84750@BLUPR12MB0449.namprd12.prod.outlook.com>
 <85c67ae9-bfe2-390a-79d0-6e5872b9be62@amd.com>
 <0c91bb14-a874-9ee6-8756-2a31eb41d5b2@daenzer.net>
 <36f5b680-c881-3b4f-0784-3cd624064004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <36f5b680-c881-3b4f-0784-3cd624064004-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTAvMTAvMTcgMDk6NTcgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTAuMTAu
MjAxNyB1bSAwOTo0NyBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+PiBPbiAxMC8xMC8xNyAwODo1
OCBBTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFzIE5pY29sYWkgZXhwbGFpbmVkIHRo
YXQgYXBwcm9hY2ggc2ltcGx5IHdvbid0IHdvcmsuCj4+Pgo+Pj4gVGhlIGZkIGlzIHVzZWQgYnkg
bW9yZSB0aGFuIGp1c3QgdGhlIGNsb3NlZCBzb3VyY2UgVnVsa2FuIGRyaXZlciBhbmQgSQo+Pj4g
dGhpbmsgZXZlbiBieSBzb21lIGNvbXBvbmVudHMgbm90IGRldmVsb3BlZCBieSBBTUQgKGNvbW1v
biBYIGNvZGU/Cj4+PiBNaWNoZWwgcGxlYXNlIGNvbW1lbnQgYXMgd2VsbCkuCj4+IFRoZSBvbmx5
IHRoaW5nIHRoYXQgY29tZXMgdG8gbWluZCBwb3NzaWJseSBtYXRjaGluZyB5b3VyIGRlc2NyaXB0
aW9uIGlzCj4+IHRoZSBnZW5lcmljIG1vZGVzZXR0aW5nIFhvcmcgZHJpdmVyLCBidXQgdGhhdCBv
bmx5IGNhbGxzIEtNUyBBUEkgaW9jdGxzLgo+PiBDb21tYW5kIHN1Ym1pc3Npb24gYW5kIG1lbW9y
eSBtYW5hZ2VtZW50IGlvY3RscyBzaG91bGQgb25seSBiZSBjYWxsZWQgYnkKPj4gaGFyZHdhcmUg
c3BlY2lmaWMgdXNlcnNwYWNlIGNvZGUuCj4gCj4gWWVhaCwgdGhhdCB3YXMgaW4gbXkgbWluZCBh
cyB3ZWxsLgo+IAo+IEJ1dCBkb2VzIHRoYXQgdXNlIHRoZSBzYW1lIGZkIGFzIHRoZSBHTCBkcml2
ZXIgdXNlZCBmb3IgR2xhbW9yPwoKWWVzLCBpdCBkb2VzLgoKCj4gSWYgeWVzIHdlIGNhbid0IGp1
c3QgY2FsbCBjbG9zZSgpIG9uIHRoYXQgZmQuCgpUcnVlLCB0aGF0J3MgYSBnb29kIHBvaW50LgoK
Ci0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAg
ICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAg
ICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
