From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] Update function level documentation for GPUVM v2
Date: Tue, 12 Jun 2018 17:35:55 +0200
Message-ID: <733e0aac-809b-b940-5932-95025dc34745@gmail.com>
References: <1528812303-4720-1-git-send-email-andrey.grodzovsky@amd.com>
 <fe0b61a8-000d-8679-d2f0-b7eaec4e092f@amd.com>
 <5bbb4abe-9d35-65c0-9afe-47331160e7f1@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <5bbb4abe-9d35-65c0-9afe-47331160e7f1-5C7GfCeVMHo@public.gmane.org>
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
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: michel-otUistvHUpPR7s880joybQ@public.gmane.org

VGhlcmUgYXJlIG11bHRpcGxlIG9jY2FzaW9ucyBvZiAiYWRldi0+Z21jLnZpc2libGVfdnJhbV9z
aXplIDwgCmFkZXYtPmdtYy5yZWFsX3ZyYW1fc2l6ZSIgaW4gYW1kZ3B1X2NzLmMuCgpJdCdzIGJh
c2ljYWxseSB0aGUgc2FtZSBjaGVjayBhcyBpbiBhbWRncHVfdm1faXNfbGFyZ2VfYmFyKCkuCgpJ
IHN1Z2dlc3QgdG8gbmFtZSBpdCBzb21ldGhpbmcgbGlrZSBhbWRncHVfZ21jX3ZyYW1fZnVsbF92
aXNpYmxlKCkgb3IgCnNpbWlsYXIgc2luY2UgdGhlIEJBUiBhY3R1YWxseSBkb2Vzbid0IG5lZWRz
IHRvIGJlIGxhcmdlIGZvciB0aGF0LgoKVGhhbmtzLApDaHJpc3RpYW4uCgpBbSAxMi4wNi4yMDE4
IHVtIDE3OjA2IHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4gSSBkaWRuJ3QgZmluZCB0aGF0
IGNoZWNrIGluwqAgYW1kZ3B1X2NzLmMsIGNhbiB5b3UgY2xhcmlmeSBwbGVhc2UgPwo+Cj4gQW5k
cmV5Cj4KPgo+IE9uIDA2LzEyLzIwMTggMTA6NDEgQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4+Cj4+IFVucmVsYXRlZCB0byB0aGlzIHBhdGNoLCBidXQgd2Ugc2hvdWxkIHByb2JhYmx5IG1v
dmUgdGhhdCBmdW5jdGlvbiAKPj4gaW50byBhbWRncHVfZ21jLmguCj4+Cj4+IFRoZXJlIGFyZSBh
IGNvdXBsZSBvZiBtb3JlIG9jY2FzaW9ucyBvZiB0aGF0IGNoZWNrIHdhaXRpbmcgZm9yIAo+PiBj
bGVhbnVwIGluIGFtZGdwdV9jcy5jLgo+Pgo+PiBDYW4geW91IHRha2UgY2FyZSBvZiBjbGVhbmlu
ZyB0aGF0IHVwIGFzIHdlbGw/IFRoYW5rcyBpbiBhZHZhbmNlLiAKPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QK
PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
