From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 15/81] drm/amd/display: Re-enable Vsync Interrupts for
 Gradual Refresh Ramp
Date: Thu, 27 Jul 2017 09:15:17 +0900
Message-ID: <711f535c-4108-fd65-4694-108cedcda8b5@daenzer.net>
References: <1500990881-6100-1-git-send-email-sunpeng.li@amd.com>
 <1500990881-6100-16-git-send-email-sunpeng.li@amd.com>
 <f1763d72-5caf-671b-df61-5064920ad67d@daenzer.net>
 <5454135a-51b2-36c6-c4a7-1544a0249894@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5454135a-51b2-36c6-c4a7-1544a0249894-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, sunpeng.li-5C7GfCeVMHo@public.gmane.org, Amy Zhang <Amy.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjYvMDcvMTcgMTA6MzQgUE0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+IE9uIDIwMTctMDct
MjUgMDk6MzQgUE0sIE1pY2hlbCBEw6RuemVyIHdyb3RlOgo+PiBPbiAyNS8wNy8xNyAxMDo1MyBQ
TSwgc3VucGVuZy5saUBhbWQuY29tIHdyb3RlOgo+Pj4gRnJvbTogQW15IFpoYW5nIDxBbXkuWmhh
bmdAYW1kLmNvbT4KPj4+Cj4+PiAtIE1ha2Ugc3VyZSBWc3luYyBpbnRlcnJ1cHRzIGFyZSBkaXNh
YmxlZCBpbiBzdGF0aWMgc2NyZWVuIGNhc2UKPj4+ICAgYW5kIGVuYWJsZWQgd2hlbiBub3QgdG8g
c2F2ZSBwb3dlcgo+Pgo+PiBXaGF0IGV4YWN0bHkgZG9lcyB0aGlzIG1lYW4/IEZXSVcsIHRoZSBp
bnRlcnJ1cHQgd2hvc2UgaGFuZGxlciBjYWxscwo+PiBkcm1faGFuZGxlX3ZibGFuaygpIG11c3Qg
YmUgZW5hYmxlZCBmcm9tIHdoZW4gdGhlCj4+IGRybV9kcml2ZXI6OmVuYWJsZV92YmxhbmsgaG9v
ayBpcyBjYWxsZWQgdW50aWwgd2hlbiB0aGUKPj4gZHJtX2RyaXZlcjo6ZGlzYWJsZV92Ymxhbmsg
aG9vayBpcyBjYWxsZWQuCj4gCj4gVGhpcyBjb21tZW50IGlzIG1pc2xlYWRpbmcgYW5kIHNob3Vs
ZCd2ZSBiZWVuIHRyaW1tZWQgd2hlbiBwcmVwYXJpbmcgdGhlCj4gcGF0Y2hlcyBmb3IgdGhlIG9w
ZW4gdHJlZS4gVGhpcyBjaGFuZ2Ugc2hvdWxkIG5vdCBoYXZlIGFuIGltcGFjdCBvbgo+IHZibGFu
ayBpbnRlcnJ1cHRzIG9uIExpbnV4LgoKVGhhdCdzIGdvb2QgdG8ga25vdy4KCj4gU29ycnkgZm9y
IHRoZSBjb25mdXNpb24uCgpObyB3b3JyaWVzLCBqdXN0IG1ha2luZyBzdXJlLgoKCi0tIApFYXJ0
aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgaHR0cDov
L3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAgfCAgICAg
ICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
