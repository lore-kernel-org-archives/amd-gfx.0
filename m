From: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] LRU map compute/SDMA user ring ids to kernel ring ids v2
Date: Fri, 21 Apr 2017 19:48:30 -0400
Message-ID: <20170421234836.18620-1-andresx7@gmail.com>
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

VjIgdXBkYXRlczoKICogUmViYXNlZAogKiBBbGwgcGF0Y2hlcyBub3cgaGF2ZSByLWIKClNlY29u
ZCBwYXJ0IG9mIHRoZSBzcGxpdCBvZiB0aGUgc2VyaWVzOgpBZGQgc3VwcG9ydCBmb3IgaGlnaCBw
cmlvcml0eSBzY2hlZHVsaW5nIGluIGFtZGdwdSB2OAoKVGhlc2UgcGF0Y2hlcyBzaG91bGQgYmUg
Y2xvc2UgdG8gYmVpbmcgZ29vZCBlbm91Z2ggdG8gbGFuZC4KClRoZSBmaXJzdCB0d28gcGF0Y2hl
cyBhcmUgc2ltcGxlIGZpeGVzIEkndmUgcG9ydGVkIGZyb20gdGhlIFJPQ20gYnJhbmNoLiBUaGVz
ZQpzdGlsbCBuZWVkIHJldmlldy4KCkkndmUgZml4ZWQgYWxsIG9mIENocmlzdGlhbidzIGNvbW1l
bnRzIGZvciBwYXRjaCAwNDoKZHJtL2FtZGdwdTogaW1wbGVtZW50IGxydSBhbWRncHVfcXVldWVf
bWdyIHBvbGljeSBmb3IgY29tcHV0ZSB2NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
