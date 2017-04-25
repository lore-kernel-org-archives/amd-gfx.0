From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix gpu reset crash
Date: Tue, 25 Apr 2017 10:20:07 +0800
Message-ID: <58FEB257.2010002@amd.com>
References: <1493026850-29604-1-git-send-email-David1.Zhou@amd.com>
 <a43a71f9-b8b1-4ff3-3532-d13bdd539761@vodafone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a43a71f9-b8b1-4ff3-3532-d13bdd539761-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE35bm0MDTmnIgyNOaXpSAxNzo0NywgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4g
VGhlIHJvb3QgY2F1c2UgaXMgc29tZSByaW5nIGRvZXNuJ3QgaGF2ZSBzY2hlZHVsZXIsIGxpa2Ug
S0lRIHJpbmcKPj4KPj4gQ2hhbmdlLUlkOiBJNDIwZTg0YWRkOWNkZDlhN2ZkMWY5OTIxYjhhNWQw
YWZhM2RkMjA1OAo+PiBTaWduZWQtb2ZmLWJ5OiBDaHVubWluZyBaaG91IDxEYXZpZDEuWmhvdUBh
bWQuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4gZm9yIGJvdGguIApJIGZvcmdvdCB0byBhZGQgUkIgd2hlbiBwdXNoaW5nIHBh
dGNoZXMsIEhvdyBjYW4gSSBhZGQgaXQgYWdhaW4/CgpTb3JyeSBmb3IgdGhhdC4KRGF2aWQgWmhv
dQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4
IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
