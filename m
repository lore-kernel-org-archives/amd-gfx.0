From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Intermittent errors when using amdgpu_job_submit_direct
Date: Tue, 9 Jul 2019 04:53:31 +0000
Message-ID: <885956af-be59-d218-f2e7-a0fc06042f21@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
Content-ID: <2CD2D9FBD84D8E48A254B1A76C3BCDA8-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SSdtIHNlZWluZyBzb21lIHdlaXJkIGludGVybWl0dGVudCBidWdzICh2bSBmYXVsdHMsIGhhbmdz
LCBldGMpIHdoZW4gDQp0cnlpbmcgdG8gdXNlIGFtZGdwdV9qb2Jfc3VibWl0X2RpcmVjdC4gSSdt
IHdvbmRlcmluZyBpZiB0aGVyZSBpcyBhIA0KcG9zc2liaWxpdHkgb2YgYSByYWNlIGNvbmRpdGlv
biwgd2hlbiBhIHN1Ym1pdF9kaXJlY3QgYW5kIGEgR1BVIA0Kc2NoZWR1bGVyIHRocmVhZCB0cnkg
dG8gc3VibWl0IHRvIHRoZSBzYW1lIHJpbmcgYXQgdGhlIHNhbWUgdGltZS4gSSANCmRpZG4ndCBz
ZWUgYW55IGxvY2tpbmcgdG8gYWxsb3cgbXVsdGlwbGUgdGhyZWFkcyBzYWZlbHkgc3VibWl0dGlu
ZyB0byANCnRoZSBzYW1lIHJpbmcuDQoNCkFtIEkgbWlzc2luZyBzb21ldGhpbmc/DQoNClRoYW5r
cywNCiDCoCBGZWxpeA0KDQotLSANCkYgZSBsIGkgeCAgIEsgdSBlIGggbCBpIG4gZw0KUE1UUyBT
b2Z0d2FyZSBEZXZlbG9wbWVudCBFbmdpbmVlciB8IExpbnV4IENvbXB1dGUgS2VybmVsDQoxIENv
bW1lcmNlIFZhbGxleSBEci4gRWFzdCwgTWFya2hhbSwgT04gTDNUIDdYNiBDYW5hZGENCihPKSAr
MSgyODkpNjk1LTE1OTcNCiAgICBfICAgICBfICAgXyAgIF9fX19fICAgX19fX18NCiAgIC8gXCAg
IHwgXCAvIHwgfCAgXyAgXCAgXCBfICB8DQogIC8gQSBcICB8IFxNLyB8IHwgfEQpICkgIC98X3wg
fA0KL18vIFxfXCB8X3wgfF98IHxfX19fXy8gfF9fLyBcfCAgIGZhY2Vib29rLmNvbS9BTUQgfCBh
bWQuY29tDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
