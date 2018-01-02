From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: use raw buffer printk specifier
Date: Tue, 02 Jan 2018 14:35:45 +0200
Message-ID: <1514896545.7000.563.camel@linux.intel.com>
References: <20171221100453.6203-1-dmitry.rozhkov@linux.intel.com>
 <CADnq5_M+UujKU=gwE0KGtLaXC_9ig+DoUFNwZ+v+z8+mhx2grw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_M+UujKU=gwE0KGtLaXC_9ig+DoUFNwZ+v+z8+mhx2grw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Rozhkov <dmitry.rozhkov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gTW9uLCAyMDE4LTAxLTAxIGF0IDE2OjEyIC0wNTAwLCBBbGV4IERldWNoZXIgd3JvdGU6Cj4g
T24gVGh1LCBEZWMgMjEsIDIwMTcgYXQgNTowNCBBTSwgRG1pdHJ5IFJvemhrb3YKPiA8ZG1pdHJ5
LnJvemhrb3ZAbGludXguaW50ZWwuY29tPiB3cm90ZToKPiA+IHByaW50ayBmb3JtYXQgc3RyaW5n
cyBhY2NlcHRpbmcgYSBzaW5nbGUgc3Vic2VxdWVudCBhcmd1bWVudAo+ID4gYXJlIHNob3J0ZXIg
dGh1cyBlYXNpZXIgdG8gcmVhZC4KPiAKPiBJJ20gbm90IHN1cmUgSSBhZ3JlZSBpdCdzIGVhc2ll
ciB0byByZWFkLgo+IElNSE8sIGl0J3Mgc29tZXdoYXQgbGVzcwo+IGNsZWFyIHdoYXQncyBnb2lu
ZyBvbiwgCgpJZiB5b3UgY2hlY2sgaG93IG1hbnkgdGltZXMgJSpwaCBpcyB1c2VkIGluIHRoZSBr
ZXJuZWwuLi4gT3IgdGhlbiB5b3UKbWF5IGNvbmNlcm4gYWJvdXQgZW50aXJlIGJ1bmNoIG9mICVw
IGV4dGVuc2lvbnMgaW4gdGhlIGtlcm5lbC4KCkFueXdheSwgbWFpbiByYXRpb25hbGUgSSB0aGlu
ayBpcyBhIHN0YWNrIHVzZSBhbmQgcGVyZm9ybWFuY2UuCgpCdXQgaXQncyBzdGlsbCBhYm91dCBk
ZWJ1ZyBtZXNzYWdlcyBpbiB0aGlzIGNhc2UsIGFuZCBpbiBwYXJ0aWN1bGFyIG9ubHkKYWJvdXQg
MyBieXRlcyAoYnR3LCBpZiBuZWVkZWQgaXQgbWlnaHQgYmUgZWFzaWx5IGV4cGFuZGVkIGZvciB1
cCB0byA2NApieXRlcyBvciBldmVuIHdpdGggcnVuLXRpbWUgYWRqdXN0ZWQgbGVuZ3RoKS4KCj4g
YnV0IEkgZG9uJ3QgaGF2ZSBhIHBhcnRpY3VsYXJseSBzdHJvbmcgb3Bpbmlvbgo+IGVpdGhlciB3
YXkuICBBcHBsaWVkLgoKVGhhbmtzLgoKLS0gCkFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPgpJbnRlbCBGaW5sYW5kIE95Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
