From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 05/15] drm/amd/display: Fix gamma colour corruption for 10
 bit surfaces
Date: Wed, 1 Mar 2017 10:17:00 +0900
Message-ID: <440e5b55-ec15-a939-1626-f546208e37df@daenzer.net>
References: <20170301002620.24595-1-harry.wentland@amd.com>
 <20170301002620.24595-6-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170301002620.24595-6-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Cc: Jordan Lazare <Jordan.Lazare-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMDEvMDMvMTcgMDk6MjYgQU0sIEhhcnJ5IFdlbnRsYW5kIHdyb3RlOgo+IEZyb206IEpvcmRh
biBMYXphcmUgPEpvcmRhbi5MYXphcmVAYW1kLmNvbT4KPiAKPiBHYW1tYSBMVVQgc2hvdWxkbid0
IGJlIHVzZWQgZm9yIDEwLWJpdCBhbmQgYWJvdmUuIFNob3VsZCBpbnN0ZWFkIGJlCj4gdXNpbmcg
cHJlc2NhbGUgYW5kIGJ5cGFzc2luZyBpbnB1dCBnYW1tYS4KPiAKPiBDaGFuZ2UtSWQ6IEk1NWMw
OGM3NDZiYjFlMWFiMTczOWU0NzE2MmRkZjA2ZGIxMmZlODczCj4gU2lnbmVkLW9mZi1ieTogSm9y
ZGFuIExhemFyZSA8Sm9yZGFuLkxhemFyZUBhbWQuY29tPgo+IEFja2VkLWJ5OiBIYXJyeSBXZW50
bGFuZCA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogVG9ueSBDaGVuZyA8
VG9ueS5DaGVuZ0BhbWQuY29tPgo+IC0tLQo+ICAuLi4vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2Rj
ZTExMF9od19zZXF1ZW5jZXIuYyAgICB8IDE1ICsrKystCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2U4MC9NYWtlZmlsZSAgICAgIHwgIDMgKy0KPiAgLi4uL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlODAvZGNlODBfaXBwX2dhbW1hLmMgfCA3MSAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCgpUaGUgcmVtb3ZhbCBvZiBkY2U4MF9pcHBfZ2FtbWEuYyBhbmQgY29ycmVzcG9uZGlu
ZyBNYWtlZmlsZSBjaGFuZ2UgbG9va3MKdW5yZWxhdGVkIGFuZCBzaG91bGQgYmUgYSBzZXBhcmF0
ZSBjaGFuZ2UuCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwg
ICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUgc29mdHdhcmUgZW50aHVzaWFz
dCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFggZGV2ZWxvcGVyCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
