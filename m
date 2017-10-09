From: Andy Furniss <adf.lists-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: CPU usage/threading on agd5f 4.15-wip
Date: Mon, 9 Oct 2017 18:37:35 +0100
Message-ID: <55cfac3b-5486-250d-077c-cb5891b4e9b8@gmail.com>
References: <321a77c8-a7ab-945f-cdf9-ad8e69f42713@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <321a77c8-a7ab-945f-cdf9-ad8e69f42713-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

QW5keSBGdXJuaXNzIHdyb3RlOgo+IE9uIDQuMTUtd2lwIHdpdGggcGF0Y2hlcyB0aGF0IG1ha2Ug
cG93ZXJwbGF5IHdvcmsgSSBoYXZlIGFuIGlzc3VlIHdpdGggCj4gb25lIGdhbWUgPSB1bnJlYWwg
dG91cm5hbWVudCBhbHBoYS4KPiAKPiBUaGlzIGRvZXNuJ3Qgc2VlbSB0byBhZmZlY3Qgb3RoZXIg
dGhpbmdzIGxpa2UgeG9ub3RpYyBvciB1bmlnaW5lIGRlbW9zLgo+IAo+IElzc3VlID0gb24gZml4
ZXMgNC4xNCBhbmQgb3RoZXIgb2xkZXIga2VybmVscyBJJ3ZlIHRyaWVkLCB0aGUgZ2FtZSBpcyBP
SyAKPiBpc2ggcGVyZiB3aXNlLCAyMC00MCBmcHMuCj4gCj4gT24gNC4xNS13aXAgaXRzIDEwZnBz
LiBVc2luZyBIVUQgb25lIG9idmlvdXMgZGlmZmVyZW5jZSBpcyB0aGF0IHRoZSBzbG93IAo+IGNh
c2UgaXMgb25seSBtb3N0bHkgdXNpbmcgb25lIGNwdSBjb3JlLCBvbiBhIGdvb2Qga2VybmVsIGFs
bCA0IG9mIG15IG9sZCAKPiBwaGVub20gMiB4NCBhcmUgdXNlZC4KPiAKPiBCb3RoIGtlcm5lbHMg
c2VlbSBiYXNlZCBvbiA0LjEzLXJjNSBzbyBJIGd1ZXNzIGl0J3Mgc29tZXRoaW5nIGFtZGdwdS4K
PiAKPiBUcm91YmxlIGlzLCBJIGNhbid0IGJpc2VjdCA0LjE1LXdpcCwgZ29pbmcgYmFjayBuZWFy
IG9yID4gMjAwIGNvbW1pdHMgSSAKPiBsb2NrIHNvb24gYWZ0ZXIgc3RhcnR4Lgo+IAo+IFNvIGlz
IHRoZXJlIGFueSBjaGFuZ2UgZGV2cyBjYW4gdGhpbmsgb2YgdGhhdCB3b3VsZCBjYXVzZSB0aGlz
PwoKSSBmaWxlZCBhIGJ1ZyBmb3IgdGhpcyBzbyBJIGNvdWxkIHVwbG9hZCBzb21lIHNjcmVlbiBz
aG90cy4KCklzc3VlIHJlbWFpbnMgd2l0aCB1cGRhdGVkIDQuMTUtd2lwLgoKaHR0cHM6Ly9idWdz
LmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTAzMTc1CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
