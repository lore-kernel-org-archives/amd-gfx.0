From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: BUG - unable to handle null pointer, bisected - drm/amd/display:
 add gpio lock/unlock
Date: Thu, 7 Feb 2019 16:42:15 +0100
Message-ID: <410bdfe2-8a0a-df13-0f7d-2c1191f23ab3@daenzer.net>
References: <10341067.RRd0raRtKH@eclipse>
 <7284b267-cbcb-988f-f688-078f75f87a3d@daenzer.net>
 <CADnq5_NZMMGdPvzFt1y0XU1GX7KNTtqOwY9GZg7xKSqJCK2X9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_NZMMGdPvzFt1y0XU1GX7KNTtqOwY9GZg7xKSqJCK2X9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chiawen Huang <chiawen.huang-5C7GfCeVMHo@public.gmane.org>, Tony Cheng <Tony.Cheng-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

T24gMjAxOS0wMi0wNyA0OjM3IHAubS4sIEFsZXggRGV1Y2hlciB3cm90ZToKPiBPbiBUaHUsIEZl
YiA3LCAyMDE5IGF0IDEwOjMzIEFNIE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+
IHdyb3RlOgo+Pgo+PiBPbiAyMDE5LTAyLTA2IDEwOjQ4IGEubS4sIFByemVtZWsgU29jaGEgd3Jv
dGU6Cj4+PiBHb29kIG1vcm5pbmcsCj4+Pgo+Pj4gb24gbXkgTGVub3ZvIEc1MC00NSBhNjMxMCBB
UFUgd2l0aCBSNCBNdWxsaW5zIGNvbW1pdAo+Pj4gZTI2MTU2OGY5NGQ2YzM3ZWJiOTRkM2M0YjNm
OGEzMDg1Mzc1ZGQ5ZCBpcyBjYXVzaW5nIGtlcm5lbCBPb3BzICh1bmFibGUgdG8KPj4+IGhhbmRs
ZSBOVUxMIHBvaW50ZXIpLgo+Pj4gQ3Jvc3MtY2hlY2tlZCBieSByZXZlcnRpbmcgdHJvdWJsZXNv
bWUgY29tbWl0IGFuZCBtYWNoaW5lIHdpdGhvdXQgaXQgaXMKPj4+IHdvcmtpbmcgZmluZS4KPj4K
Pj4gU2FtZSBmb3IgbWUgd2l0aCBUb25nYS4KPj4KPiAKPiBXZWlyZC4gIEknbSBub3Qgc2VlaW5n
IHRoaXMgb24gbXkgVG9uZ2EuICBXaGF0IGRpc3BsYXlzIGFyZSB5b3UgdXNpbmc/Cj4gIERWSSBo
ZXJlLgoKRFZJIGhlcmUgYXMgd2VsbCwgYnV0IGl0J3MgYWN0dWFsbHkgYSBCb25haXJlLCBzb3Jy
eSBmb3IgdGhlIGNvbmZ1c2lvbi4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAg
ICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2Fy
ZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9w
ZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
