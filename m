From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Limit DCN to x86 arch
Date: Tue, 23 May 2017 10:57:15 -0400
Message-ID: <46a7befe-c3de-07ec-1937-538f3cae016e@amd.com>
References: <20170519140121.14296-1-harry.wentland@amd.com>
 <f84c51b6-06f1-b4d2-c472-89265ebb26cb@vodafone.de>
 <7a8b84af-38f7-33d2-5bbb-473f2ea35bb2@amd.com>
 <CAPM=9tzcA8t-ji6qNQhycB0cezz2vH6HMixCgvKQ78cY1Y8fsA@mail.gmail.com>
 <4e0c342b-d18e-5f7a-bd30-9becd0e97e3c@amd.com>
 <013f44e3-1734-43f8-4cd7-e950ffb014f0@vodafone.de>
 <ff8918ec-ee0e-692e-4ada-cd6bd939d902@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <ff8918ec-ee0e-692e-4ada-cd6bd939d902-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dmytro Laktyushkin <Dmytro.Laktyushkin-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMTctMDUtMjMgMDk6MzcgQU0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+Cj4KPiBPbiAyMDE3
LTA1LTIwIDA0OjEzIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBcmUgeW91IGF3YXJl
IG9mIGFueW9uZSB1c2luZyBvdXIgR1BVcyBvbiBub24tWDg2IGFyY2hpdGVjdHVyZXM/IElmCj4+
IHNvLCBJIG5ldmVyIGhlYXJkIG9mIGl0Lgo+Pgo+PiBZZWFoLCB0aGVyZSBhcmUgYWN0dWFsbHkg
cXVpdGUgYSBudW1iZXIgb2YgcGVvcGxlLiBUaGF0J3Mgb25lIG9mIHRoZQo+PiByZWFzb25zIHdo
eSB3ZSBzdGlsbCBoYXZlIGEgYnVuY2ggb2YgIiNpZmRlZiBfX0JJR19FTkRJQU4iIGluIHRoZQo+
PiBhbWRncHUgc291cmNlLgo+Pgo+Cj4gSW50ZXJlc3RpbmcuIEknZCBsb3ZlIHRvIGtub3cgbW9y
ZSBhYm91dCB0aGlzLCBsaWtlIHdoaWNoIHBsYXRmb3JtcywKPiBldGMsIHNpbmNlIHNhZGx5IHdl
J3ZlIGJlZW4gcHJldHR5IHVuYXdhcmUgb2YgdGhpcy4KCkZvciBST0NtIHdlJ3JlIHdvcmtpbmcg
b24gc3VwcG9ydGluZyBBUk12OCBhbmQgUG93ZXI4LiBUaGlzIGlzIGZvcgpjb21wdXRlLCBzbyBt
b3N0bHkgaGVhZGxlc3MuIE5vdCBzdXJlIGlmIHRoZXkgd291bGQgY2FyZSBhYm91dCBkaXNwbGF5
CmluIHRoZSBmdXR1cmUuCgpSZWdhcmRzLAogIEZlbGl4CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
