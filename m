From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu] Fix hang when entering into dpms-off
 mode
Date: Fri, 1 Mar 2019 09:43:11 +0100
Message-ID: <a274ff35-60ba-d735-2656-0508556ad5b1@daenzer.net>
References: <1551322325-19958-1-git-send-email-aaron.liu@amd.com>
 <dd111c99-c1f9-d1d7-5c40-3fcf7b75b1ea@daenzer.net>
 <814ff51d-cde2-8a3e-6755-fd656a900a87@daenzer.net>
 <DM6PR12MB361173B0EF321F8862519D85F0760@DM6PR12MB3611.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM6PR12MB361173B0EF321F8862519D85F0760-lmeGfMZKVrGUZgGQSl7qawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Aaron" <Aaron.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMjAxOS0wMy0wMSA3OjM3IGEubS4sIExpdSwgQWFyb24gd3JvdGU6Cj4gQE1pY2hlbCBEw6Ru
emVyLAo+IAo+IEkgaGF2ZSByZXZpZXdlZCB5b3VyIHBhdGNoIGFuZCB2ZXJpZmllZCBpdCBwYXNz
ZWQuCgpUaGFua3MgQWFyb24sIHNvIEkgYXNzdW1lIEkgY2FuIGFkZAoKUmV2aWV3ZWQtYnk6IEFh
cm9uIExpdSA8YWFyb24ubGl1QGFtZC5jb20+ClRlc3RlZC1ieTogQWFyb24gTGl1IDxhYXJvbi5s
aXVAYW1kLmNvbT4KCj8KCgo+IEkgY291bGRuJ3QgbWVyZ2UgdGhpcyBtZXJnZSByZXF1ZXN0IHRv
IHlvdXIgbWFzdGVyIG1hbnVhbGx5LgoKRG9uJ3Qgd29ycnksIEknbGwgbWVyZ2UgaXQgdmlhIHRo
ZSBHaXRMYWIgbWVyZ2UgcmVxdWVzdCBVSS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVy
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgaHR0cHM6Ly93d3cuYW1kLmNvbQpMaWJyZSBz
b2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBk
ZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
