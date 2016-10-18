From: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [rfc] fix for regression in pat memory tracking in 4.9-rc1
Date: Tue, 18 Oct 2016 16:13:10 +1000
Message-ID: <1476771193-2759-1-git-send-email-airlied@gmail.com>
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
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: shawn.starr-bJEeYj9oJeDQT0dZR+AlfA@public.gmane.org

T2theSBJIHNwZW50IHNvbWUgdGltZSBsb29raW5nIGludG8gaXQsIGFuZCB0aGlzIGlzIHRoZSBy
ZXN1bHQuCgpXZSBoYXZlIHRvIG1hbnVhbGx5IGluc2VydCB0aGUgVlJBTSBCQVIgaW50byB0aGUg
cGF0IG1lbW9yeSB0cmFja2luZwp0YWJsZSBhcyBXQy4gVGhlIG9ubHkgb3RoZXIgd2F5IHRoaW5n
cyBnZXQgaW5zZXJ0ZWQgYXJlIHZpYSBpb3JlbWFwLAp3aGljaCB3ZSBuZXZlciBkbyBmb3IgdGhl
IHdob2xlIFZSQU0gQkFSLiBXZSBjb3VsZCBpbiB0aGVvcnkgbWFwCnRoZSBWUkFNIEJBUiB1c2lu
ZyB0aGUgaW9tYXAgc3R1ZmYgdGhhdCBpOTE1IHVzZXMsIGJ1dCB3ZSBkb24ndAphbmQgdGhpcyBz
ZWVtcyBlYXNpZXIgZm9yIG5vdy4KCldlIGhhdmUgdG8gZml4IHVwIGF0IGxlYXN0IG5vdXZlYXUg
YW5kIHJhZGVvbiBJIHRoaW5rIGFzIHdlbGwuCgpEYXZlLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
