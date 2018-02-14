From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 14/25] drm/amdkfd: Populate DRM render device minor
Date: Wed, 14 Feb 2018 09:50:22 +0100
Message-ID: <255915a6-f101-554a-9087-1fd792ee1de3@daenzer.net>
References: <1517967174-21709-1-git-send-email-Felix.Kuehling@amd.com>
 <1517967174-21709-15-git-send-email-Felix.Kuehling@amd.com>
 <16aa5300-7ddc-518a-2080-70cb31b6ad56@gmail.com>
 <5f1c33b3-b3ed-f627-9b5c-347b2399d90f@amd.com>
 <dd476550-9a48-3adc-30e6-8a94bd04833b@gmail.com>
 <d11c598a-b51f-b957-7dae-485025a1ad34@amd.com>
 <ce14b4cd-2bb7-8f19-b464-ddf9f68f45ad@amd.com>
 <cbd18308-c464-125e-ef9f-180c12a9926a@amd.com>
 <a2e39184-8db8-407d-6608-6ae211563459@amd.com>
 <8424282f-d196-3cb6-9a6e-a26f8be7d198@amd.com>
 <ebf4d6d7-2424-764f-0bc0-615240c82483@amd.com>
 <9f078a60-0cca-ba43-3e1c-c67c2b758988@amd.com>
 <c991529e-2489-169c-cc34-96ed5bb94a12@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <c991529e-2489-169c-cc34-96ed5bb94a12-5C7GfCeVMHo@public.gmane.org>
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
To: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Oak Zeng <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxOC0wMi0xMyAwODoxOCBQTSwgRmVsaXggS3VlaGxpbmcgd3JvdGU6Cj4gT24gMjAxOC0w
Mi0xMyAwMToxNSBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMTMuMDIuMjAxOCB1
bSAxODoxOCBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+Pgo+Pj4gSSBkb24ndCBzZWUgaG93IHlv
dSBjYW4gaGF2ZSBzZXBhcmF0ZSBUVE0gb2JqZWN0cyByZWZlcnJpbmcgdG8gdGhlCj4+PiBzYW1l
IG1lbW9yeS4KPj4KPj4gV2VsbCB0aGF0IGlzIHRyaXZpYWwsIHdlIGRvIHRoaXMgYWxsIHRoZSB0
aW1lIHdpdGggcHJpbWUgYW5kIEkrQSBsYXB0b3BzLgo+IAo+IEFzIEkgdW5kZXJzdGFuZCBpdCwg
eW91IHVzZSBETUFCdWYgdG8gZXhwb3J0L2ltcG9ydCBidWZmZXJzIG9uIG11bHRpcGxlCj4gZGV2
aWNlcy4gSSBiZWxpZXZlIGFsbCBkZXZpY2VzIHNoYXJlIGEgc2luZ2xlIGFtZGdwdV9ibywgd2hp
Y2ggY29udGFpbnMKPiB0aGUgdHRtX2J1ZmZlcl9vYmplY3QuCgpUaGUgZG1hLWJ1ZiBleHBvcnRl
ciBhbmQgaW1wb3J0ZXIgY2FuIGJlIGRpZmZlcmVudCBkcml2ZXJzLCBzbyB0aGlzIGlzCm5vdCBw
b3NzaWJsZS4KCgotLSAKRWFydGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAg
ICAgICAgICAgICAgIGh0dHA6Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0
ICAgICAgICAgICAgIHwgICAgICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
