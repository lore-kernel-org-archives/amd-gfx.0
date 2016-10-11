From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 8/8] drm/amdgpu: move align_mask and nop into ring funcs
 as well
Date: Tue, 11 Oct 2016 15:26:27 +0200
Message-ID: <82e102e9-cd1b-10ce-75ca-201ef4b802d4@vodafone.de>
References: <1475676809-3061-1-git-send-email-deathsimple@vodafone.de>
 <1475676809-3061-8-git-send-email-deathsimple@vodafone.de>
 <57FCE58E.5040107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <57FCE58E.5040107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMTEuMTAuMjAxNiB1bSAxNToxMyBzY2hyaWViIEFuZHkgRnVybmlzczoKPiBDaHJpc3RpYW4g
S8O2bmlnIHdyb3RlOgo+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4+Cj4+IFRoZXkgYXJlIGNvbnN0YW50IGFzIHdlbGwuCj4KPiBJIGRpZSBvbiBk
cml2ZXIgbG9hZCB3aXRoIHRoaXMgY29tbWl0IG9uIFI5Mjg1IHRlc3Rpbmcgb24gNC45LXdpcC4K
Pgo+ClByb2JhYmx5IGp1c3QgYSB0eXBvIGluIHRoZSBoYXJkd2FyZSBoYW5kbGluZy4KCkdvaW5n
IHRvIHN3aXRjaCB0byBteSBUb25nYSBpbiBhIG1pbnV0ZSwgYnV0IEkgb25seSBnb3QgYWJvdXQg
aGFsZiBhbiAKaG91ciBsZWZ0IGJlZm9yZSBJIG5lZWQgdG8gZ2V0IG15IGRhdWdodGVyIGZyb20g
a2luZGVyZ2FydGVuLgoKQ2hyaXN0aWFuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
