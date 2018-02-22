From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amd: remove inclusion of non-existing scheduler
 directory
Date: Thu, 22 Feb 2018 09:27:30 +0100
Message-ID: <83f990cf-92ce-31e7-1734-d57c1b7242b7@amd.com>
References: <1519287709-28638-1-git-send-email-clabbe@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1519287709-28638-1-git-send-email-clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Content-Language: en-US
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
To: Corentin Labbe <clabbe-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, David1.Zhou-5C7GfCeVMHo@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Dieter-0hun7QTegEsDD4udEopG9Q@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

QW0gMjIuMDIuMjAxOCB1bSAwOToyMSBzY2hyaWViIENvcmVudGluIExhYmJlOgo+IFRoZSBzY2hl
ZHVsZXIgZGlyZWN0b3J5IHdhcyByZW1vdmVkIHZpYSBjb21taXQgMWIxZjQyZDhmZGU0ICgiZHJt
OiBtb3ZlIGFtZF9ncHVfc2NoZWR1bGVyIGludG8gY29tbW9uIGxvY2F0aW9uIikKPiBSZW1vdmUg
aXQgZnJvbSBpbmNsdWRlIHBhdGguCj4KPiBTaWduZWQtb2ZmLWJ5OiBDb3JlbnRpbiBMYWJiZSA8
Y2xhYmJlQGJheWxpYnJlLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvTWFrZWZpbGUgfCAxIC0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9NYWtlZmlsZQo+IGluZGV4IGQ2ZTViNzI3Mzg1My4uODQwOGFl
ZWFmNmMxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxl
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvTWFrZWZpbGUKPiBAQCAtMzAsNyAr
MzAsNiBAQCBGVUxMX0FNRF9ESVNQTEFZX1BBVEggPSAkKEZVTExfQU1EX1BBVEgpLyQoRElTUExB
WV9GT0xERVJfTkFNRSkKPiAgIGNjZmxhZ3MteSA6PSAtSSQoRlVMTF9BTURfUEFUSCkvaW5jbHVk
ZS9hc2ljX3JlZyBcCj4gICAJLUkkKEZVTExfQU1EX1BBVEgpL2luY2x1ZGUgXAo+ICAgCS1JJChG
VUxMX0FNRF9QQVRIKS9hbWRncHUgXAo+IC0JLUkkKEZVTExfQU1EX1BBVEgpL3NjaGVkdWxlciBc
Cj4gICAJLUkkKEZVTExfQU1EX1BBVEgpL3Bvd2VycGxheS9pbmMgXAo+ICAgCS1JJChGVUxMX0FN
RF9QQVRIKS9hY3AvaW5jbHVkZSBcCj4gICAJLUkkKEZVTExfQU1EX0RJU1BMQVlfUEFUSCkgXAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
