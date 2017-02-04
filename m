From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Change queue/pipe split between amdkfd and amdgpu
Date: Fri,  3 Feb 2017 23:51:29 -0500
Message-ID: <20170204045142.5596-1-andresx7@gmail.com>
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
Cc: Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org, John.Bridgman-5C7GfCeVMHo@public.gmane.org

VGhlIGN1cnJlbnQgcXVldWUvcGlwZSBzcGxpdCBwb2xpY3kgaXMgZm9yIGFtZGdwdSB0byB0YWtl
IHRoZSBmaXJzdCBwaXBlIG9mCk1FQzAgYW5kIGxlYXZlIHRoZSByZXN0IGZvciBhbWRrZmQgdG8g
dXNlLiBUaGlzIHBvbGljeSBpcyB0YWtlbiBhcyBhbgphc3N1bXB0aW9uIGluIGEgZmV3IGFyZWFz
IG9mIHRoZSBpbXBsZW1lbnRhdGlvbi4KClRoaXMgcGF0Y2ggc2VyaWVzIGFpbXMgdG8gYWxsb3cg
Zm9yIGZsZXhpYmxlL3R1bmFibGUgcXVldWUvcGlwZSBzcGxpdCBwb2xpY2llcwpiZXR3ZWVuIGtn
ZCBhbmQga2ZkLiBJdCBhbHNvIHVwZGF0ZXMgdGhlIHF1ZXVlL3BpcGUgc3BsaXQgcG9saWN5IHRv
IG9uZSB0aGF0IAphbGxvd3MgYmV0dGVyIGNvbXB1dGUgYXBwIGNvbmN1cnJlbmN5IGZvciBib3Ro
IGRyaXZlcnMuCgpJbiB0aGUgcHJvY2VzcyBzb21lIGR1cGxpY2F0ZSBjb2RlIGFuZCBoYXJkY29k
ZWQgY29uc3RhbnRzIHdlcmUgcmVtb3ZlZC4KCkFueSBzdWdnZXN0aW9ucyBvciBmZWVkYmFjayBv
biBpbXByb3ZlbWVudHMgd2VsY29tZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
