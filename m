From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Changes to let KFD use render node VMs
Date: Fri, 2 Mar 2018 08:43:29 +0100
Message-ID: <6b3c3caa-e6a6-d256-383f-303dc4150f85@amd.com>
References: <22204b36-3974-2853-f3f8-2fbd30b05418@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <22204b36-3974-2853-f3f8-2fbd30b05418-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, amd-gfx-CC+yJ3UmIYqDUpFQwHEjaQ@public.gmane.org

SGkgRmVsaXgsCgpwYXRjaCAjMyBsb29rcyBnb29kIHRvIG1lIGluIGdlbmVyYWwsIGJ1dCB3aHkg
ZG8geW91IG5lZWQgdG8gY2FjaGUgdGhlIApwZF9waHlzX2FkZHI/CgpUaGUgQk8gYWxyZWFkeSBk
b2VzIHRoYXQgYW55d2F5LCBzbyB5b3UgY2FuIGp1c3QgdXNlIAphbWRncHVfYm9fZ3B1X2FkZHIo
KSBmb3IgdGhpcyB3aGljaCBhbHNvIG1ha2VzIHNvbWUgYWRkaXRpb25hbCBjaGVja3Mgb24gCmRl
YnVnIGJ1aWxkcy4KCnBhdGNoICM1IHdlbGwgbWl4aW5nIHBvd2VyIG1hbmFnZW1lbnQgaW50byB0
aGUgVk0gZnVuY3Rpb25zIGlzIGEgY2xlYXIgTkFLLgoKVGhhdCBjZXJ0YWlubHkgZG9lc24ndCBi
ZWxvbmcgdGhlcmUsIGJ1dCB3ZSBjYW4gaGF2ZSBhIGNvdW50ZXIgaG93IG1hbnkgCmNvbXB1dGUg
Vk1zIHdlIGhhdmUgaW4gdGhlIG1hbmFnZXIuIGFtZGdwdV92bV9tYWtlX2NvbXB1dGUoKSBjYW4g
dGhlbiAKcmV0dXJuIGlmIHRoaXMgd2FzIHRoZSBmaXJzdCBWTSB0byBiZWNhbWUgYSBjb21wdXRl
IFZNIG9yIG5vdC4KClRoZSByZXN0IG9mIHRoZSBwYXRjaCBsb29rcyBnb29kIHRvIG1lLgoKUmVn
YXJkcywKQ2hyaXN0aWFuLgoKQW0gMDEuMDMuMjAxOCB1bSAyMzo1OCBzY2hyaWViIEZlbGl4IEt1
ZWhsaW5nOgo+IEhpIENocmlzdGlhbiwKPgo+IEkgaGF2ZSBhIHdvcmtpbmcgcGF0Y2ggc2VyaWVz
IGFnYWluc3QgYW1kLWtmZy1zdGFnaW5nIHRoYXQgbGV0cyBLRkQgdXNlCj4gVk1zIGZyb20gcmVu
ZGVyIG5vZGUgRkRzLCBhcyB3ZSBkaXNjdXNzZWQuIFRoZXJlIGFyZSB0d28gcGF0Y2hlcyBpbiB0
aGF0Cj4gc2VyaWVzIHRoYXQgdG91Y2ggYW1kZ3B1X3ZtLltjaF0gdGhhdCBJJ2QgbGlrZSB5b3Vy
IGZlZWRiYWNrIG9uIGJlZm9yZSBJCj4gY29tbWl0IHRoZSBjaGFuZ2VzIHRvIGFtZC1rZmQtc3Rh
Z2luZyBhbmQgaW5jbHVkZSB0aGVtIGluIG15IHVwc3RyZWFtCj4gcGF0Y2ggc2VyaWVzIGZvciBL
RkQgR1BVVk0gc3VwcG9ydC4gU2VlIGF0dGFjaGVkLgo+Cj4gVGhhbmtzLAo+ICDCoCBGZWxpeAo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
