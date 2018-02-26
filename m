From: Chris Wilson <chris-Y6uKTt2uX1cEflXRtASbqLVCufUGDwFn@public.gmane.org>
Subject: Re: [PATCH 21/22] dma-buf/reservation: shouldn't kfree staged when
 slot available
Date: Mon, 26 Feb 2018 10:19:02 +0000
Message-ID: <151964034205.2350.2554778746105246165@mail.alporthouse.com>
References: <1519623300-17305-1-git-send-email-Monk.Liu@amd.com>
 <afa20c31-f721-599e-7e4c-eecbf7bda70f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <afa20c31-f721-599e-7e4c-eecbf7bda70f-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UXVvdGluZyBDaHJpc3RpYW4gS8O2bmlnICgyMDE4LTAyLTI2IDA5OjQyOjE1KQo+IFdlbGwgZmly
c3Qgb2YgYWxsIHlvdSBuZWVkIHRvIHNlbmQgdGhhdCB0byBkcmktZGV2ZWwgYW5kIGV2ZW4gbGtt
bCwgc28gCj4gdGhhdCBDaHJpcyBhbmQgb3RoZXJzIGNhbiB0YWtlIGEgbG9vayBhcyB3ZWxsLgo+
IAo+IFNlY29uZCB0aGF0IHBhdGNoIGRvZXNuJ3QgbG9va3MgY29ycmVjdCB0byBtZSwgb2JqLT5z
dGFnZWQgc2hvdWxkIG5ldmVyIAo+IGJlIHJlbGF0ZWQgdG8gb2JqLT5mZW5jZS4KCkNvbmN1cnJl
ZC4gSSB3b3VsZCBzdXNwZWN0IG1pc3NpbmcgcmN1IHByb3RlY3Rpb24gYXJvdW5kIGEgcmVhZGVy
IHRvCmNhdXNlIHRoZSBpbXBsaWVkIGtlcm5lbCBvb3BzLiBJZiB5b3UgYXJlIGZpeGluZyBhIGJ1
ZywgcGxlYXNlIGRvCmluY2x1ZGUgYXMgbXVjaCBkZXRhaWxzIGFib3V0IHRoZSBidWcgYXMgeW91
IGNhbiAoc3RhY2t0cmFjZXMsCm9ic2VydmF0aW9ucyBldGMpIHNvIHRoYXQgb3RoZXIgcGVvcGxl
IHdobyBtYXkgaGF2ZSBoaXQgc29tZXRoaW5nCnNpbWlsYXIgY2FuIHNlZSBpZiB0aGlzIHBhdGNo
IG1pZ2h0IGZpeCB0aGVpciBwcm9ibGVtLCBvciBpZiB0aGV5CnJlY29nbmlzZSB0aGUgcHJvYmxl
bSBhcyBjYXVzZWQgYnkgc29tZXRoaW5nIGVsc2UuCi1DaHJpcwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
