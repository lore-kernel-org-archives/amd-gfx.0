From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdgpu: only bind VM shadows after validation v2
Date: Mon, 31 Jul 2017 12:05:01 -0400
Message-ID: <648d9f36-78e1-2a83-cc60-f8d8e29ca33e@amd.com>
References: <1501327923-19559-1-git-send-email-deathsimple@vodafone.de>
 <1501327923-19559-2-git-send-email-deathsimple@vodafone.de>
 <c9977d09-4ce2-740c-df59-d1518b351c33@amd.com>
 <19fb8035-2c18-2ee6-c0bc-baaabedb5b1f@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <19fb8035-2c18-2ee6-c0bc-baaabedb5b1f-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMTctMDctMzEgMTE6MzAgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMzEuMDcu
MjAxNyB1bSAxNzoyNCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+PiBIaSBDaHJpc3RpYW4sCj4+
Cj4+IElmIEknbSByZWFkaW5nIHRoaXMgY29ycmVjdGx5LCBub3cgeW91J3JlIG9ubHkgYmluZGlu
ZyBwYWdlIGRpcmVjdG9yaWVzLAo+PiBidXQgbm90IHRoZSBsZWFmIHBhZ2UgdGFibGVzLiBJcyB0
aGF0IGludGVudGlvbmFsPwo+Cj4gWW91IGFyZSBub3QgcmVhZGluZyB0aGlzIGNvcnJlY3RseSBJ
IHRoaW5rLgo+Cj4gTGVhdmUgcGFnZSB0YWJsZXMgZG9uIGhhdmUgcGFyZW50LT5lbnRyaWVzPT1O
VUxMIGFuZCB3ZSBjaGVjayBmb3IgdGhhdAo+IGNvbmRpdGlvbiBhZnRlciB0aGUgYmluZCBhcyBm
YXIgYXMgSSBjYW4gc2VlLgoKWWVzLCBJIHJlYWQgaXQgd3JvbmcuIE5ldmVyIG1pbmQuIFJldmll
d2VkLWJ5OiBGZWxpeCBLdWVobGluZwo8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
