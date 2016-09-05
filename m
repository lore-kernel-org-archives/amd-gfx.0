From: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] amdkfd: Fix possible dangling ptr in
 kfd_dbgmgr_destroy()
Date: Mon, 5 Sep 2016 14:01:23 +0300
Message-ID: <CAFCwf11L915=aBeFoKKnGgieRQqR7UcKyOiX+1zWTJnSfYzvwQ@mail.gmail.com>
References: <1472870947-11300-1-git-send-email-funfunctor@folklore1984.net>
 <1472870947-11300-5-git-send-email-funfunctor@folklore1984.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1472870947-11300-5-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gU2F0LCBTZXAgMywgMjAxNiBhdCA1OjQ5IEFNLCBFZHdhcmQgTydDYWxsYWdoYW4KPGZ1bmZ1
bmN0b3JAZm9sa2xvcmUxOTg0Lm5ldD4gd3JvdGU6Cj4gU2lnbmVkLW9mZi1ieTogRWR3YXJkIE8n
Q2FsbGFnaGFuIDxmdW5mdW5jdG9yQGZvbGtsb3JlMTk4NC5uZXQ+Cj4gLS0tCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kYmdtZ3IuYyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZGJnbWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGJnbWdyLmMK
PiBpbmRleCA1NmQ2NzYzLi44YTI2ZDVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9kYmdtZ3IuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kYmdtZ3IuYwo+IEBAIC01OCw2ICs1OCw3IEBAIHZvaWQga2ZkX2RiZ21ncl9kZXN0cm95
KHN0cnVjdCBrZmRfZGJnbWdyICpwbWdyKQo+ICAgICAgICAgaWYgKHBtZ3IgIT0gTlVMTCkgewo+
ICAgICAgICAgICAgICAgICBrZmRfZGJnbWdyX3VuaW5pdGlhbGl6ZShwbWdyKTsKPiAgICAgICAg
ICAgICAgICAga2ZyZWUocG1ncik7Cj4gKyAgICAgICAgICAgICAgIHBtZ3IgPSBOVUxMOwpwbWdy
IGlzIHBhc3NlZCBhcyBhcmd1bWVudCB0byBmdW5jdGlvbi4gVGhlcmUgaXMgbm8gcG9pbnQgb2Yg
c2V0dGluZyBpdCB0byBOVUxMLgoKT2RlZAoKPiAgICAgICAgIH0KPiAgfQo+Cj4gLS0KPiAyLjcu
NAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBh
bWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
