From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Revert "drm/radeon: Try evicting from CPU accessible to
 inaccessible VRAM first"
Date: Thu, 23 Mar 2017 17:10:09 +0900
Message-ID: <c56f4a6a-a17d-b9b0-311e-7100df8c7cee@daenzer.net>
References: <1490206797-15653-1-git-send-email-zmichaels@oblong.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1490206797-15653-1-git-send-email-zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
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
To: Zachary Michaels <zmichaels-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Julien Isorce <jisorce-bXq66PvbRDbQT0dZR+AlfA@public.gmane.org>

T24gMjMvMDMvMTcgMDM6MTkgQU0sIFphY2hhcnkgTWljaGFlbHMgd3JvdGU6Cj4gV2Ugd2VyZSBl
eHBlcmllbmNpbmcgYW4gaW5maW5pdGUgbG9vcCBkdWUgdG8gVlJBTSBib3MgZ2V0dGluZyBhZGRl
ZCBiYWNrCj4gdG8gdGhlIFZSQU0gbHJ1IG9uIGV2aWN0aW9uIHZpYSB0dG1fYm9fbWVtX2ZvcmNl
X3NwYWNlLAoKQ2FuIHlvdSBzaGFyZSBtb3JlIGRldGFpbHMgYWJvdXQgd2hhdCBoYXBwZW5lZD8g
SSBjYW4gaW1hZ2luZSB0aGF0Cm1vdmluZyBhIEJPIGZyb20gQ1BVIHZpc2libGUgdG8gQ1BVIGlu
dmlzaWJsZSBWUkFNIHdvdWxkIHB1dCBpdCBiYWNrIG9uCnRoZSBMUlUsIGJ1dCBuZXh0IHRpbWUg
YXJvdW5kIGl0IHNob3VsZG4ndCBoaXQgdGhpcyBjb2RlIGFueW1vcmUgYnV0IGdldApldmljdGVk
IHRvIEdUVCBkaXJlY3RseS4KCldhcyB1c2Vyc3BhY2UgbWF5YmUgcGVyZm9ybWluZyBjb25jdXJy
ZW50IENQVSBhY2Nlc3MgdG8gdGhlIEJPcyBpbiBxdWVzdGlvbj8KCgo+IGFuZCByZXZlcnRpbmcg
dGhpcyBjb21taXQgc29sdmVzIHRoZSBwcm9ibGVtLgoKSSBob3BlIHdlIGNhbiBmaW5kIGEgYmV0
dGVyIHNvbHV0aW9uLgoKCi0tIApFYXJ0aGxpbmcgTWljaGVsIETDpG56ZXIgICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgICAgaHR0cDovL3d3dy5hbWQuY29tCkxpYnJlIHNvZnR3YXJlIGVudGh1
c2lhc3QgICAgICAgICAgICAgfCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3BlcgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
