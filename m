From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] Add support for high priority scheduling in amdgpu v4
Date: Fri, 3 Mar 2017 14:51:26 +0100
Message-ID: <f946ac29-6501-d550-2df0-515e0439bc8c@vodafone.de>
References: <20170302214448.4146-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170302214448.4146-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UGxlYXNlIGFkZCBBY2tzIGFuZCBSZXZpZXdzIHRvIHlvdXIgcGF0Y2hlcyB3aGVuIHNlbmRpbmcg
dGhlbSBvdXQgYWdhaW4uCgpJJ20gdG90YWxseSBsb29zaW5nIHRyYWNrIHdoYXQgSSd2ZSBsb29r
ZWQgYXQgYW5kIHdoYXQgbm90LgoKQnV0IGluIGdlbmVyYWwgdGhlIHdob2xlIHNldCBzdGFydHMg
dG8gbG9vayByYXRoZXIgZ29vZCB0byBtZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCkFtIDAyLjAz
LjIwMTcgdW0gMjI6NDQgc2NocmllYiBBbmRyZXMgUm9kcmlndWV6Ogo+IFRoaXMgcmV2aXNpb24g
aW1wbGVtZW50cyBDaHJpc3RpYW4ncyBsYXRlc3QgZmVlZGJhY2s6Cj4KPiAxKSBBdm9pZCBpbmRp
cmVjdGlvbiBpbiBhbWRncHVfcXVldWVfbWFuYWdlciwgY2FsbCB0aGUgbWFwIGZ1bmN0aW9ucyBk
aXJlY3RseQo+IDIpIERyb3AgcmVmY291bnRpbmcgcGF0Y2ggZm9yIGFtZGdwdV9qb2IKPiAzKSBS
ZXN0b3JlIHJpbmcgcHJpb3JpdHkgZnJvbSBhbWRncHVfam9iX2ZyZWVfY2IoKQo+Cj4KPiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFp
bGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
