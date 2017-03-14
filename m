From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [rfc] amdgpu/sync_file shared semaphores
Date: Tue, 14 Mar 2017 10:50:49 +1000
Message-ID: <20170314005054.7487-1-airlied@gmail.com>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

VGhpcyBjb250YWlucyBvbmUgbGliZHJtIHBhdGNoIGFuZCA0IGtlcm5lbCBwYXRjaGVzLgoKVGhl
IGdvYWwgaXMgdG8gaW1wbGVtZW50IHRoZSBWdWxrYW4gS0hSX2V4dGVybmFsX3NlbWFwaG9yZV9m
ZCBpbnRlcmZhY2UKZm9yIHBlcm1hbmVudCBzZW1hcGhvcmUgYmVoYXZpb3VyIGZvciByYWR2LgoK
VGhpcyBjb2RlIHRyaWVzIHRvIGVuaGFuY2Ugc3luYyBmaWxlIHRvIGFkZCB0aGUgcmVxdWlyZWQg
YmVoYXZpb3VyCih3aGljaCBpcyBtb3N0bHkgYmVpbmcgYWJsZSB0byByZXBsYWNlIHRoZSBmZW5j
ZSBiYWNraW5nIHRoZSBzeW5jIGZpbGUpLAppdCBhbHNvIGludHJvZHVjZXMgbmV3IEFQSSB0byBh
bWRncHUgdG8gY3JlYXRlL2Rlc3Ryb3kvZXhwb3J0L2ltcG9ydCB0aGUKc3luY19maWxlcyB3aGlj
aCB3ZSBzdG9yZSBpbiBhbiBpZHIgdGhlcmUsIHJhdGhlciB0aGFuIGZkcy4KClRoZXJlIGlzIGEg
cG9zc2liaWxpdHkgd2Ugc2hvdWxkIHNoYXJlIHRoZSBhbWRncHVfc2VtIG9iamVjdCB0cmFja2lu
Zwpjb2RlIGZvciBvdGhlciBkcml2ZXJzLCBtYXliZSB3ZSBzaG91bGQgbW92ZSB0aGF0IHRvIHN5
bmNfZmlsZSBhcyB3ZWxsLApidXQgSSdtIG9wZW4gdG8gc3VnZ2VzdGlvbnMgZm9yIHdoZXRoZXIg
dGhpcyBpcyBhIHVzZWZ1bCBhcHByb2FjaCBmb3IKb3RoZXIgZHJpdmVycy4KCkRhdmUuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
