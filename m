From: Andreas Boll <andreas.boll.dev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add HDMI audio support for si dce6
Date: Tue, 21 Feb 2017 13:45:18 +0100
Message-ID: <CACiKqBccrTmW1B6Pgc58u2rk5_mEWigSUZg5zrvRWkVm5h6r3g@mail.gmail.com>
References: <1487673594-1452-1-git-send-email-Xiaojie.Yuan@amd.com>
 <d2ba0088-cac6-7674-a6e7-d00d7f69b68c@folklore1984.net>
 <1e362d8c-d028-b787-8c2d-d952eaf741ef@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1e362d8c-d028-b787-8c2d-d952eaf741ef-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

MjAxNy0wMi0yMSAxMzoxNiBHTVQrMDE6MDAgQ2hyaXN0aWFuIEvDtm5pZyA8ZGVhdGhzaW1wbGVA
dm9kYWZvbmUuZGU+Ogo+IE5vdCBtdWNoIG9mIGFuIGlzc3VlLCBidXQgd2hlbiBzZW5kaW5nIG91
dCBhIHNlY29uZCB2ZXJzaW9uIG9mIGEgcGF0Y2ggd2UKPiB1c3VhbGx5IHB1dCBhIHYyIG9uIHRo
ZSBzdWJqZWN0IGxpbmUgdG8gaW5kaWNhdGUgdGhhdC4KPgo+IEFkZGl0aW9uYWwgdG8gdGhhdCB0
aGUgcGF0Y2ggYWxzbyBuZWVkcyBhdCBsZWFzdCBhIGxpdHRsZSBiaXQgb2YgY29tbWl0Cj4gbWVz
c2FnZS4KPgo+IFdpdGggdGhhdCBmaXhlZCBpdCBpcyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPi4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+
CgpIaSBDaHJpc3RpYW4sCgpBRkFJSyB0aGVyZSdzIG5vIHYxIG9uIHRoZSBwdWJsaWMgbWwuCkkg
Z3Vlc3MgeW91IG1pZ2h0IGJlIGNvbmZ1c2luZyBIRE1JIHdpdGggRFAgYXVkaW8gc3VwcG9ydCBm
b3IgU0kuClRoaXMgcGF0Y2ggaXMgYWJvdXQgSERNSSBhdWRpby4gVGhlIG90aGVyIG9uZSBpcyBh
Ym91dCBEUCBhdWRpbyBbMV0uCgpUaGFua3MsCkFuZHJlYXMKClsxXSBodHRwczovL3BhdGNod29y
ay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMTM5OTMyLwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
