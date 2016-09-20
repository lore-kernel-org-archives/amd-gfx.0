From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/radeon: Provide page_flip_target hook
Date: Tue, 20 Sep 2016 11:59:15 +0900
Message-ID: <73bb9197-16a5-856d-ffe8-8fdfe007ca3c@daenzer.net>
References: <1470281981-18172-1-git-send-email-michel@daenzer.net>
 <1470281981-18172-5-git-send-email-michel@daenzer.net>
 <dccd9347-afc4-83a6-8014-20692e71fd03@gmail.com>
 <71aaa221-ad52-25db-f6dc-18c368d57efa@daenzer.net>
 <b00edbdc-c467-3f33-5a07-32def2961190@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b00edbdc-c467-3f33-5a07-32def2961190-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Mario Kleiner <mario.kleiner.de-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTcvMDkvMTYgMDk6NDEgUE0sIE1hcmlvIEtsZWluZXIgd3JvdGU6Cj4gSGkgTWljaGVsLAo+
IAo+IGFsbCB5b3VyIHBhdGNoZXMsIGJvdGggdGhlIGFscmVhZHkgbWVyZ2VkIGtlcm5lbCBiaXRz
IGluIHJhZGVvbi9hbWRncHUKPiBhbmQgYWxzbyBhbGwgdGhlIHVzZXJzcGFjZSBiaXRzIGluIGxp
YmRybS9hdGktZGR4L2FtZGdwdS1kZHggYXJlIGFsbAo+IAo+IFJldmlld2VkLWFuZC10ZXN0ZWQt
Ynk6IE1hcmlvIEtsZWluZXIgPG1hcmlvLmtsZWluZXIuZGVAZ21haWwuY29tPgo+IAo+IEkgc3Vj
Y2Vzc2Z1bGx5IHRlc3RlZCB3aXRoIG9sZC9jdXJyZW50IHVzZXJzcGFjZSBhbmQgdGhlIG5ldyB1
c2Vyc3BhY2UKPiBwYXRjaGVzIGZyb20geW91ciBvd24gbGliZHJtL2F0aS1kZHgvYW1kZ3B1LWRk
eCByZXBvcywgdW5kZXIgcmFkZW9uLWttcwo+IHdpdGggSEQtNTc3MCBhbmQgYW1kZ3B1LWttcyB3
aXRoIFI5IDM4MCwgdW5kZXIgRFJJMiBhbmQgRFJJMy9QcmVzZW50Cj4gd2l0aCB0aGUgbmV3IHVz
ZXJzcGFjZSBhbmQgYXQgbGVhc3QgRFJJMy9QcmVzZW50IHdpdGggdGhlIG9sZC9jdXJyZW50Cj4g
dXNlcnNwYWNlIChjYW4ndCBxdWl0ZSByZW1lbWJlciBpZiBpIGFsc28gdGVzdGVkIHdpdGggRFJJ
MiBvbgo+IG9sZC9jdXJyZW50IHVzZXJzcGFjZSwgYnV0IHByb2JhYmx5KS4gSGFyZHdhcmUgbWVh
c3VyZWQgdGltaW5nIHRlc3RzIGFsbAo+IHdvcmsgZmluZS4KPiAKPiBTbyBhbGwgaXMgZ29vZCwg
ZXhjZXB0IGZvciBwcmUtRENFNCB3aXRob3V0IHBmbGlwIGlycXMsIGJ1dCBmb3IgdGhhdCBzZWUK
PiB0aGUgcGF0Y2hzZXQgaSBqdXN0IHNlbnQgb3V0LCB3aGljaCBzaG91bGQgbWFrZSB0aG9zZSBv
bGQgYXNpY3Mgd29yawo+IHdlbGwgYXMgd2VsbC4KClRoYW5rcyBmb3IgdGhlIHRlc3RpbmcgYW5k
IHBhdGNoZXMhCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
