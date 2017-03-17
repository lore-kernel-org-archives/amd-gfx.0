From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] Use LRU mapping policy for SDMA engines
Date: Fri, 17 Mar 2017 14:52:47 -0400
Message-ID: <20170317185249.2952-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org, andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

UHJldmlvdXNseSB3ZSBkaXNjdXNzZWQgc29tZSBpc3N1ZXMgd2l0aCBhcHBseWluZyB0aGUgTFJV
IG1hcHBpbmcgcG9saWN5CnRvIHRoZSBTRE1BIGVuZ2luZXMuIE1haW5seSwgaWYgYm90aCByaW5n
IGlkcyBlbmQgdXAgYWxpYXNlZCB0byB0aGUgc2FtZQpIVyBibG9jaywgdGhlIHRvdGFsIHRyYW5z
ZmVyIGJhbmR3aXRoIGFuIGFwcGxpY2F0aW9uIGNhbiBhY2hpZXZlIHdpbGwgYmUKc2V2ZXJlbHkg
aW1wYWN0ZWQuIEUuZy4gYW4gYXBwIHVzZXMgb25lIFNETUEgcmluZyBmb3IgdXBsb2FkIGFuZCBv
bmUgZm9yCmRvd25sb2FkLgoKVGhpcyBzbWFsbCBzZXJpZXMgcHJldmVudHMgcmluZyBpZCBhbGlh
c2luZyBhbmQgZW5hYmxlcyBMUlUgbWFwcGluZyBmb3IgdGhlCkRNQSBpcCBibG9ja3MuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
