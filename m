From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 17/19] drm/amdgpu: Remove hard-coded assumptions about
 compute pipes
Date: Mon, 14 Aug 2017 10:53:04 -0400
Message-ID: <0eec4793-c9fa-4dfb-c8d7-41995d20e738@amd.com>
References: <1502488589-30272-1-git-send-email-Felix.Kuehling@amd.com>
 <1502488589-30272-18-git-send-email-Felix.Kuehling@amd.com>
 <CAFCwf108X+f6+jehRvykPy0NPCnYa6uHjoVAXWDvoN+35h-N5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAFCwf108X+f6+jehRvykPy0NPCnYa6uHjoVAXWDvoN+35h-N5A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxNy0wOC0xMyAwNDoyOSBBTSwgT2RlZCBHYWJiYXkgd3JvdGU6Cj4gT24gU2F0LCBBdWcg
MTIsIDIwMTcgYXQgMTI6NTYgQU0sIEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPiB3cm90ZToKPj4gUmVtb3ZlIGhhcmQtY29kZWQgYXNzdW1wdGlvbiB0aGF0IHRoZSBmaXJz
dCBjb21wdXRlIHBpcGUgaXMKPj4gcmVzZXJ2ZWQgZm9yIGFtZGdwdS4gUGlwZSAwIGFjdHVhbGx5
IG1lYW5zIHBpcGUgMCBub3cuCj4+Cj4gSWYgSSdtIGxvb2tpbmcgYXQgYW1kZ3B1X2dmeF9jb21w
dXRlX3F1ZXVlX2FjcXVpcmUoKSwgYW1kZ3B1IHRha2VzIHRoZQo+IGZpcnN0IHBpcGUsIHNvIHdv
bid0IHRoaXMgY2hhbmdlIGNvbGxpZGUgd2l0aCB0aGF0IGNvZGUgPwoKYW1kZ3B1X2dmeF9jb21w
dXRlX3F1ZXVlX2FjcXVpcmUgbWFya3MgdGhlIHF1ZXVlcyBpdCdzIHVzaW5nIGluCmFkZXYtPmdm
eC5tZWMucXVldWVfYml0bWFwLiBhbWRncHVfYW1ka2ZkX2RldmljZV9pbml0IHVzZXMgdGhhdCB0
bwppbml0aWFsaXplIHRoZSBxdWV1ZV9iaXRtYXAgaW4ga2dkMmtmZF9zaGFyZWRfcmVzb3VyY2Vz
LiBTbyBLRkQgaXMgbm90CmdvaW5nIHRvIHVzZSB0aGUgY29tcHV0ZSBxdWV1ZXMgcmVzZXJ2ZWQg
YnkgYW1kZ3B1LgoKQW5kcmVzIFJvZHJpZ3VleiBoYWQgYSBzZXJpZXMgb2YgY29tbWl0cyBhIGZl
dyBtb250aHMgYWdvIHRvIGdlbmVyYWxpemUKdGhlIGNvbXB1dGUgcXVldWUgYXNzaWdubWVudCBi
ZXR3ZWVuIGFtZGdwdSBhbmQgYW1ka2ZkLiBUaGUgaGFyZCBjb2RlZAphc3N1bXB0aW9uIHRoYXQg
cGlwZTAgaXMgdXNlZCBieSBhbWRncHUgZ29lcyBiYWNrIHRvIGJlZm9yZSBBbmRyZXMnCnBhdGNo
IHNlcmllcy4gSSB0aGluayBpdCB3YXMgb3Zlcmxvb2tlZCB3aGVuIEFuZHJlcyBtYWRlIGhpcyBj
aGFuZ2VzLgoKUmVnYXJkcywKICBGZWxpeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
