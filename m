From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 0/4] KFD: Mapping-specific MTYPEs on Arcturus
Date: Fri, 23 Aug 2019 21:33:45 +0000
Message-ID: <20190823213249.10749-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

VGhpcyBpcyBhIHNpbXBsaWZpZWQgdmVyc2lvbiBvZiBPYWsncyBwYXRjaCBzZXJpZXMsIGFkZHJl
c3Npbmcgc29tZSBvZgp0aGUgY29uY2VybnMgcmFpc2VkIGR1cmluZyBjb2RlIHJldmlldy4gUGF0
Y2hlcyAxLTMgYXJlIHRha2VuIGRpcmVjdGx5CmZyb20gT2FrJ3Mgc2VyaWVzLiBQYXRjaCA0IGlz
IGEgc2ltcGxpZmllZCB2ZXJzaW9uIG9mIE9haydzIHBhdGNoZXMKMyBhbmQgNSB0aGF0IGtlZXBz
IGFsbCB0aGUgS0ZEIG1lbW9yeSB0eXBlIGFic3RyYWN0aW9ucyBvdXQgb2YgdGhlIEdNQwpJUC12
ZXJzaW9uLXNwZWNpZmljIGNvZGUuCgpDb21waWxlIHRlc3RlZCBvbmx5LgoKRmVsaXggS3VlaGxp
bmcgKDEpOgogIGRybS9hbWRncHU6IERldGVybWluZyBQVEUgZmxhZ3Mgc2VwYXJhdGVseSBmb3Ig
ZWFjaCBtYXBwaW5nCgpPYWsgWmVuZyAoMyk6CiAgZHJtL2FtZGdwdTogRXh0ZW5kcyBhbWRncHUg
dm0gZGVmaW5pdGlvbnMKICBkcm0vYW1kZ3B1OiBTdXBwb3J0IG5ldyBhcmN0dXJ1cyBtdHlwZQog
IGRybS9hbWRncHU6IFN1cHBvcnQgc25vb3BlZCBQVEUgZmxhZwoKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuaCAgICB8ICAyICstCiAuLi4vZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYyAgfCA2MCArKysrKysrKysrKysrKy0tLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCAgICAgICAgfCAgOSArKy0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgICAgICAgICB8ICA2ICsrCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2luY2x1ZGUvdmVnYTEwX2VudW0uaCAgICAgfCAgMSArCiBpbmNsdWRlL3Vh
cGkvZHJtL2FtZGdwdV9kcm0uaCAgICAgICAgICAgICAgICAgfCAgNCArKwogNiBmaWxlcyBjaGFu
Z2VkLCA2MyBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
