From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 03/14] drm/amdgpu: Add helper to turn an existing VM into
 a compute VM
Date: Mon, 5 Mar 2018 14:01:39 -0500
Message-ID: <023fa73a-967d-b5ad-e920-f931bfb09fee@amd.com>
References: <1520130907-5059-1-git-send-email-Felix.Kuehling@amd.com>
 <1520130907-5059-4-git-send-email-Felix.Kuehling@amd.com>
 <7416e24d-ac02-0572-4f82-fa119299de4e@gmail.com>
 <cabe8a33-57b5-6f88-2de0-f443f59b6821@amd.com>
 <4500c212-0c6d-42e1-a26a-ffec29a15831@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <4500c212-0c6d-42e1-a26a-ffec29a15831-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

Ck9uIDIwMTgtMDMtMDUgMTI6MTQgUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IEFsc28s
IHdlJ2QgbmVlZCB0byBmaXggc2hhZG93IHBhZ2UgdGFibGUgaGFuZGxpbmcgd2l0aCBDUFUgdXBk
YXRlcywgb3IKPj4gZ2V0IHJpZCBvZiBzaGFkb3cgcGFnZSB0YWJsZXMuIEknbSBub3Qgc3VyZSB3
aHkgdGhleSdyZSBuZWVkZWQsIFRCSC4KPgo+IFRoZSBpZGVhIGJlaGluZCBzaGFkb3cgcGFnZSB0
YWJsZXMgaXMgdGhhdCB5b3UgaGF2ZSB0aGUgY3VycmVudCBzdGF0ZQo+IG9mIHRoZSBwaXBlbGlu
ZSBpZiB0aGUgR1BVIGNyYXNoZXMuCgpJIHNlZS4gU28gYSBHUFUgY2FuIGJlIHJlc2V0IGluIHRo
ZSBtaWRkbGUgb2YgYSBwYWdlIHRhYmxlIHVwZGF0ZQp3aXRob3V0IGxvc2luZyBhbnl0aGluZyBh
bmQgd2l0aG91dCBoYXZpbmcgdG8gcmVjcmVhdGUgdGhlIHBhZ2UgdGFibGUKZnJvbSBzY3JhdGNo
LgoKPiBTaW5jZSB3aXRoIENQVSB1cGRhdGVzIHRoZXJlIGlzIG5vIHBpcGVsaW5lIHRoZXkgZG9l
c24ndCBtYWtlIHNlbnNlIGF0Cj4gYWxsIHdpdGggdGhlbS4gCgpUaGF0J3MgdHJ1ZSB3aGVuIGFs
bCBwYWdlIHRhYmxlIHVwZGF0ZXMgYXJlIGRvbmUgYnkgdGhlIENQVS4gSWYgd2Ugc3RhcnQKbWl4
aW5nIENQVSBhbmQgU0RNQSB1cGRhdGVzIGluIHRoZSBzYW1lIFZNLCB0aGVuIENQVSB1cGRhdGVz
IG5lZWQgdG8KdXBkYXRlIHRoZSBzaGFkb3cgcGFnZSB0YWJsZSBhcyB3ZWxsLgoKUmVnYXJkcywK
wqAgRmVsaXgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
