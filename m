From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drm/amdgpu: Change powerplay clock requests to mHz
Date: Fri, 2 Nov 2018 11:25:22 +0100
Message-ID: <dddbd6d5-4001-41cb-0b48-37d6a5b83387@daenzer.net>
References: <20181101190737.3583-1-David.Francis@amd.com>
 <20181101190737.3583-3-David.Francis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181101190737.3583-3-David.Francis-5C7GfCeVMHo@public.gmane.org>
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
To: David Francis <David.Francis-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0xMS0wMSA4OjA3IHAubS4sIERhdmlkIEZyYW5jaXMgd3JvdGU6Cj4gVGhpcyB3aWxs
IGNsZWFuIHVwIHBvd2VycGxheSBjb2RlLCBhcyB3ZSBhcmUgbm8gbG9uZ2VyCj4gbXVsdGlwbHlp
bmcgdGhlIGNsb2NrcyBieSAxMDAwIGluIERNIGFuZCB0aGVuIGRpdmlkaW5nIHRoZW0KPiBieSAx
MDAwIGluIHBvd2VycGxheQo+IAo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEZyYW5jaXMgPERhdmlk
LkZyYW5jaXNAYW1kLmNvbT4KCkluIHRoZSBzaG9ydGxvZywgIm1IeiIgbWVhbnMgbWlsbGloZXJ0
eiwgc2hvdWxkIGJlICJNSHoiIGZvciBtZWdhaGVydHouCgoKLS0gCkVhcnRobGluZyBNaWNoZWwg
RMOkbnplciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20K
TGlicmUgc29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2Eg
YW5kIFggZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
