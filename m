From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH split] Improve pipe split between amdgpu and amdkfd
Date: Thu, 13 Apr 2017 17:35:25 -0400
Message-ID: <20170413213542.18802-1-andresx7@gmail.com>
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
Cc: andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

VGhpcyBpcyBhIHNwbGl0IG9mIHBhdGNoZXMgdGhhdCBhcmUgcmVhZHkgdG8gbGFuZCBmcm9tIHRo
ZSBzZXJpZXM6CkFkZCBzdXBwb3J0IGZvciBoaWdoIHByaW9yaXR5IHNjaGVkdWxpbmcgaW4gYW1k
Z3B1IHY4CgpJJ3ZlIGluY2x1ZGVkIEZlbGl4IGFuZCBBbGV4J3MgZmVlZGJhY2sgZnJvbSB0aGUg
dGhyZWFkIGFib3ZlLiBUaGlzIGluY2x1ZGVzOgogKiBTZXBhcmF0ZSBNRUNfSFBEX1NJWkUgcmVu
YW1lIGludG8gYSBzZXBhcmF0ZSBwYXRjaCAocGF0Y2ggMDEpCiAqIEFkZGVkIGEgcGF0Y2ggdG8g
Zml4IHRoZSBrZ2RfaHFkX2xvYWQgYnVnIEZlbGl4IHBvaW50ZWQgb3V0IChwYXRjaCAwNikKICog
Rml4ZXMgZm9yIHZhcmlvdXMgb2ZmLWJ5LW9uZSBlcnJvcnMKICogVXNlIGdmeF92OF8wX2RlYWN0
aXZhdGVfaHFkCgpPbmx5IGNvbW1lbnQgSSBkaWRuJ3QgYWRkcmVzcyB3YXMgY2hhbmdpbmcgdGhl
IHF1ZXVlIGFsbG9jYXRpb24gcG9saWN5IGZvcgpnZng5IChzaW1pbGFyIHRvIGdmeDcvOCkuIFNl
ZSBpbmxpbmUgcmVwbHkgaW4gdGhhdCB0aHJlYWQgZm9yIG1vcmUgZGV0YWlscwpvbiB3aHkgdGhp
cyB3YXMgc2tpcHBlZC4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
