From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Fix "-Wmisleading-indentation" warning
Date: Wed, 6 Mar 2019 09:53:31 +0100
Message-ID: <abbd9af1-7f3e-0afb-8ac2-5bce7cb6cdf1@daenzer.net>
References: <1551814093-32107-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1551814093-32107-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-CA
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
To: sunpeng.li-5C7GfCeVMHo@public.gmane.org
Cc: JinhuiEric.Huang-5C7GfCeVMHo@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOS0wMy0wNSA4OjI4IHAubS4sIHN1bnBlbmcubGlAYW1kLmNvbSB3cm90ZToKPiBGcm9t
OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiAKPiBUaGUgZm9sbG93aW5nIHdhcm5pbmcg
aXMgc2VlbiBkdXJpbmcgY29tcGlsZToKPiAKPiAuL2luY2x1ZGUvbGludXgvaWRyLmg6MjEyOjI6
IHdhcm5pbmc6IHRoaXMg4oCYZm9y4oCZIGNsYXVzZSBkb2VzIG5vdAo+IGd1YXJkLi4uIFstV21p
c2xlYWRpbmctaW5kZW50YXRpb25dCj4gICBmb3IgKChlbnRyeSkgPSBpZHJfZ2V0X25leHQoKGlk
ciksICYoaWQpKTsgICBcCj4gICBeCj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1k
a2ZkL2tmZF9ldmVudHMuYzoxMDM4OjM6IG5vdGU6IGluCj4gZXhwYW5zaW9uIG9mIG1hY3JvIOKA
mGlkcl9mb3JfZWFjaF9lbnRyeV9jb250aW51ZeKAmQo+ICAgIGlkcl9mb3JfZWFjaF9lbnRyeV9j
b250aW51ZSgmcC0+ZXZlbnRfaWRyLCBldiwgaWQpCj4gICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+Cj4gZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vYW1ka2ZkL2tmZF9ldmVudHMu
YzoxMDQzOjQ6IG5vdGU6IC4uLnRoaXMKPiBzdGF0ZW1lbnQsIGJ1dCB0aGUgbGF0dGVyIGlzIG1p
c2xlYWRpbmdseSBpbmRlbnRlZCBhcyBpZiBpdCB3ZXJlIGd1YXJkZWQKPiBieSB0aGUg4oCYZm9y
4oCZCj4gICAgIGlmIChldi0+dHlwZSA9PSBLRkRfRVZFTlRfVFlQRV9NRU1PUlkgJiYKPiAgICAg
Xn4KPiAKPiBQbGFjZSBicmFjZXMgYXJvdW5kIHRoZSBpbmRlbnRlZCBibG9jaywgYXMgc2VlbWlu
Z2x5IGludGVuZGVkLgo+IAo+IFNpZ25lZC1vZmYtYnk6IExlbyBMaSA8c3VucGVuZy5saUBhbWQu
Y29tPgoKVGhhbmtzIExlbywgYnV0IEkgYWxyZWFkeSBzZW50IGEgZml4IGZvciB0aGlzOgoKaHR0
cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNoLzI5MDQxMC8KCgotLSAKRWFydGhs
aW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgaHR0cHM6Ly93
d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAg
ICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
