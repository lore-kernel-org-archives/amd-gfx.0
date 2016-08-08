From: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Wrong shift in dce_v8_0_afmt_update_ACR() under dce_v8_0.c?
Date: Mon, 8 Aug 2016 17:43:32 -0400
Message-ID: <cd6f0c44-3307-ced9-aac6-fe6cbb8842ea@gmail.com>
Reply-To: alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
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

SGksCgpXaGlsZSBsb29raW5nIGludG8gZGNlX3Y4XzAuYywgSSBzdHVtYmxlZCB1cG9uIHNvbWV0
aGluZyB0aGF0IG1pZ2h0IGJlIAp3cm9uZyBkY2VfdjhfMF9hZm10X3VwZGF0ZV9BQ1IoKS4gV2Ug
Y2FuIHJlYWQ6CgpXUkVHMzIobW1IRE1JX0FDUl8zMl8wICsgb2Zmc2V0LCAoYWNyLmN0c18zMmto
eiA8PCAKSERNSV9BQ1JfNDRfMF9fSERNSV9BQ1JfQ1RTXzQ0X19TSElGVCkpOwoKSG93ZXZlciwg
SSdtIG1vc3RseSBzdXJlIGl0IHNob3VsZCBiZSAobHVja2lseSwgdGhlIHNoaWZ0IGlzIG9mIHRo
ZSBzYW1lIAp2YWx1ZSk6CgpXUkVHMzIobW1IRE1JX0FDUl8zMl8wICsgb2Zmc2V0LCAoYWNyLmN0
c18zMmtoeiA8PCAKSERNSV9BQ1JfMzJfMF9fSERNSV9BQ1JfQ1RTXzMyX19TSElGVCkpOwoKQ2hl
ZXJzCgotLSAKQWxleGFuZHJlIERlbWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
