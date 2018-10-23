From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mm: convert totalram_pages, totalhigh_pages and
 managed_pages to atomic.
Date: Mon, 22 Oct 2018 21:15:37 -0700
Message-ID: <c57bcc584b3700c483b0311881ec3ae8786f88b1.camel__35647.8217560381$1540278830$gmane$org@perches.com>
References: <1540229092-25207-1-git-send-email-arunks@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540229092-25207-1-git-send-email-arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Arun KS <arunks-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4AvxtiuMwx3w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Jeff Dike <jdike-OPE4K8JWMJJBDgjK7y7TUQ@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter
 Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joonas Lahtinen <joonas.lahtinen-VuQAYsv1560@public.gmane.org>
Cc: getarunks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

T24gTW9uLCAyMDE4LTEwLTIyIGF0IDIyOjUzICswNTMwLCBBcnVuIEtTIHdyb3RlOgo+IFJlbW92
ZSBtYW5hZ2VkX3BhZ2VfY291bnRfbG9jayBzcGlubG9jayBhbmQgaW5zdGVhZCB1c2UgYXRvbWlj
Cj4gdmFyaWFibGVzLgoKUGVyaGFwcyBiZXR0ZXIgdG8gZGVmaW5lIGFuZCB1c2UgbWFjcm9zIGZv
ciB0aGUgYWNjZXNzZXMKaW5zdGVhZCBvZiBzcGVjaWZpYyB1c2VzIG9mIGF0b21pY19sb25nXzxp
bmMvZGVjL3JlYWQ+CgpTb21ldGhpbmcgbGlrZToKCiNkZWZpbmUgdG90YWxyYW1fcGFnZXMoKQko
dW5zaWduZWQgbG9uZylhdG9taWNfbG9uZ19yZWFkKCZfdG90YWxyYW1fcGFnZXMpCiNkZWZpbmUg
dG90YWxyYW1fcGFnZXNfaW5jKCkJKHVuc2lnbmVkIGxvbmcpYXRvbWljX2xvbmdfaW5jKCZfdG90
YWxyYW1fcGFnZXMpCiNkZWZpbmUgdG90YWxyYW1fcGFnZXNfZGVjKCkJKHVuc2lnbmVkIGxvbmcp
YXRvbWljX2xvbmdfZGVjKCZfdG90YWxyYW1fcGFnZXMpCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
