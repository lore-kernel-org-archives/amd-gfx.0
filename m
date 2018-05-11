From: <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
Subject: Fix underflow on Hawaii on 18.20 release branch
Date: Fri, 11 May 2018 10:49:36 -0400
Message-ID: <1526050177-20888-1-git-send-email-mikita.lipski@amd.com>
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
To: rex.zhu-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, tim.writer-5C7GfCeVMHo@public.gmane.org, jerry.zhang-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: brahma_sw_dev-5C7GfCeVMHo@public.gmane.org

UmV4IFpodSdzIHBhdGNoIGZpeGVzIGFuIHVuZGVyZmxvdyBpc3N1ZSBvYnNlcnZlZCBvbiBIYXdh
aWkuIFRoZSBwYXRjaCBpcyAKaW4gZHJtLW5leHQtYW1kLXN0YWdpbmcgYnJhbmNoLCBuZWVkIGFu
IGFwcHJvdmFsIHRvIHBvcnQgdGhlIHBhdGNoIGludG8gMTguMjAKcmVsZWFzZSBicmFuY2ggaW4g
b3JkZXIgdG8gcmVzb2x2ZSBhIHRpY2tldCBTV0RFVi0xNTIzMzYuCgpUaGFua3MKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
