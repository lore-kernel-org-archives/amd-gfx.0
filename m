From: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/4] [libdrm] support PRT and replace interface
Date: Thu, 16 Mar 2017 13:24:35 +0000
Message-ID: <DM5PR12MB1818F32360F8B7E3BB71D511FF260@DM5PR12MB1818.namprd12.prod.outlook.com>
References: <1489636601-31486-1-git-send-email-Jerry.Zhang@amd.com>
 <2a70a1b2-dbe9-a3ee-99ea-2d0af4c3baf7@vodafone.de>
 <DM5PR12MB1818645A40DE984A08DD20B2FF260@DM5PR12MB1818.namprd12.prod.outlook.com>
 <84eaf027-5fb3-4fa8-c0fc-88281f7e61d7@vodafone.de>,
 <f24666c5-ee24-7b72-1706-16da59260379@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f24666c5-ee24-7b72-1706-16da59260379-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SGkgTWljaGVsLAoKdGhhdCdzIHJlYWxseSBoZWxwIG1lIDopCnRoYW5rcy4KClJlZ2FyZHMsCkpl
cnJ5KEp1bndlaSBaaGFuZykKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KRnJvbTogTWljaGVsIETDpG56ZXIgPG1pY2hlbEBkYWVuemVyLm5ldD4KU2VudDogVGh1cnNk
YXksIE1hcmNoIDE2LCAyMDE3IDU6NDI6NTMgUE0KVG86IENocmlzdGlhbiBLw7ZuaWc7IFpoYW5n
LCBKZXJyeQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU3ViamVjdDogUmU6IFtQ
QVRDSCAwLzRdIFtsaWJkcm1dIHN1cHBvcnQgUFJUIGFuZCByZXBsYWNlIGludGVyZmFjZQoKT24g
MTYvMDMvMTcgMDY6MjggUE0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gQW0gMTYuMDMuMjAx
NyB1bSAxMDoxNCBzY2hyaWViIFpoYW5nLCBKZXJyeToKPj4KPj4gU28gSSBwcmVwYXJlIHRoZSBw
YXRjaCAyIHRvIHVzZSB0aGUgaW5wdXQgZmxhZ3M6Cj4+ICAgICAgKiBbUEFUQ0ggMi80XSBhbWRn
cHU6IHNldCB2YSBmbGFnIHdpdGggaW5wdXQgcGFyYW1ldGVyCj4KPiBOaWNvbGFpIGhhbmRsZWQg
Ym90aCBpc3N1ZXMgYnkgY3JlYXRpbmcgYSBuZXcgZnVuY3Rpb24gd2hlcmUgdGhlIEJPIGlzCj4g
b3B0aW9uYWwgYW5kIHRoZSBmbGFncyB0YWtlbiBpbnRvIGFjY291bnQuCj4KPiBQbGVhc2UgdGFr
ZSBhIGxvb2sgYXQgaGlzIHBhdGNoZXMsIHRoZXkgYXJlIG9uIHRoZSBtYWlsaW5nIGxpc3QuCgpP
ciBvbiBQYXRjaHdvcms6CgpodHRwczovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcHJvamVj
dC9hbWQteG9yZy1kZHgvcGF0Y2hlcy8/c3VibWl0dGVyPTE1NjczCgoKU3BlYWtpbmcgb2YgUGF0
Y2h3b3JrLCBpdCdzIGFjY3VtdWxhdGluZyBhIGxvdCBvZiBzdGFsZSBwYXRjaGVzLgpFdmVyeWJv
ZHkgc3VibWl0dGluZyBwYXRjaGVzLCBwbGVhc2UgYXQgbGVhc3QgcGVyaW9kaWNhbGx5IGdvIHRo
cm91Z2gKeW91ciBwYXRjaGVzIGFuZCBjaGFuZ2UgdGhlaXIgc3RhdGUgYXMgYXBwcm9wcmlhdGUu
CgoKLS0KRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAg
ICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
