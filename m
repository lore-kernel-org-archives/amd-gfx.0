From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/ttm: Fix accounting error when fail to get pages
 for pool
Date: Wed, 16 Aug 2017 19:02:57 +0900
Message-ID: <177a0567-733d-8b72-5051-fe8d2b9dbafb@daenzer.net>
References: <1502868046-32511-1-git-send-email-Xiangliang.Yu@amd.com>
 <BLUPR12MB044923B80FB13FACC4DA726E84820@BLUPR12MB0449.namprd12.prod.outlook.com>
 <8f64cef6-e7f7-e245-93b9-a0d1bbc411aa@vodafone.de>
 <140f09b5-32de-eb00-c2b1-8a660182344d@amd.com>
 <BY2PR1201MB0935AC81E9620D14D382CFF8EB820@BY2PR1201MB0935.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB0935AC81E9620D14D382CFF8EB820-O28G1zQ8oGkaqtME6NEo1mrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Yu, Xiangliang" <Xiangliang.Yu-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTYvMDgvMTcgMDY6NDMgUE0sIFl1LCBYaWFuZ2xpYW5nIHdyb3RlOgo+IEkgZG9u4oCZdCBr
bm93LCBidXQgaXQgaXMgb2J2aW91cyBpc3N1ZS4gTGF0ZXIgSeKAmWxsIHJ1biB0ZXN0IHdpdGgg
dGhlIHBhdGNoLgoKSW4gdGhlIGZ1dHVyZSwgcGxlYXNlIHRlc3QgcGF0Y2hlcyBiZWZvcmUgc3Vi
bWl0dGluZyB0aGVtIGZvciByZXZpZXcuIDopCgoKLS0gCkVhcnRobGluZyBNaWNoZWwgRMOkbnpl
ciAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICBodHRwOi8vd3d3LmFtZC5jb20KTGlicmUg
c29mdHdhcmUgZW50aHVzaWFzdCAgICAgICAgICAgICB8ICAgICAgICAgICAgIE1lc2EgYW5kIFgg
ZGV2ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
