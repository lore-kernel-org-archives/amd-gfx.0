From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH libdrm] amdgpu: add mmhub ras inject unit test
Date: Fri, 16 Aug 2019 13:12:08 +0200
Message-ID: <b6cde318-e453-8a89-095c-69708f0981ef@gmail.com>
References: <20190816110401.11069-1-guchun.chen@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190816110401.11069-1-guchun.chen-5C7GfCeVMHo@public.gmane.org>
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
To: Guchun Chen <guchun.chen-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Hawking.Zhang-5C7GfCeVMHo@public.gmane.org, Dennis.Li-5C7GfCeVMHo@public.gmane.org, flora.cui-5C7GfCeVMHo@public.gmane.org, Tao.Zhou1-5C7GfCeVMHo@public.gmane.org
Cc: Candice.Li-5C7GfCeVMHo@public.gmane.org

V2VsbCB0aGlzIGRvZXNuJ3QgbG9vayBsaWtlIEMgdG8gbWUuIERpZCB3ZSBhZGRlZCBhIGNvbmZp
Z3VyYXRpb24gZmlsZSAKZm9yIHRoZSByYXMgdW5pdCB0ZXN0cyBvciBzb21ldGhpbmcgbGlrZSB0
aGF0PwoKQ2hyaXN0aWFuLgoKQW0gMTYuMDguMTkgdW0gMTM6MDQgc2NocmllYiBHdWNodW4gQ2hl
bjoKPiBDaGFuZ2UtSWQ6IElhNzZiOTUxNjJmNWY2ZjQxOWY3MGI1M2VmNDQzYmNlYWYyZTA5MmUw
Cj4gU2lnbmVkLW9mZi1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVuQGFtZC5jb20+Cj4gLS0t
Cj4gICBkYXRhL2FtZGdwdV9yYXMuanNvbiB8IDEwICsrKysrKysrKysKPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZGF0YS9hbWRncHVfcmFzLmpz
b24gYi9kYXRhL2FtZGdwdV9yYXMuanNvbgo+IGluZGV4IDI2ZmQ5NDY1Li40ODRmMTJmMiAxMDA2
NDQKPiAtLS0gYS9kYXRhL2FtZGdwdV9yYXMuanNvbgo+ICsrKyBiL2RhdGEvYW1kZ3B1X3Jhcy5q
c29uCj4gQEAgLTEyMSw2ICsxMjEsOSBAQAo+ICAgICAgICAgICAgICAgICAgICJ1dGNfYXRjbDJf
Y2FjaGVfNGtfYmFuayI6IDExMQo+ICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICB9LAo+ICsg
ICAgICAgICJtbWh1YiI6IHsKPiArICAgICAgICAgICAgImluZGV4IjogMwo+ICsgICAgICAgIH0s
Cj4gICAgICAgfSwKPiAgICAgICAidHlwZSI6IHsKPiAgICAgICAgICAgInBhcml0eSI6IDEsCj4g
QEAgLTI2Myw1ICsyNjYsMTIgQEAKPiAgICAgICAgICAgICAgICJhZGRyZXNzIjogMCwKPiAgICAg
ICAgICAgICAgICJ2YWx1ZSI6IDAKPiAgICAgICAgICAgfSwKPiArICAgICAgICB7Cj4gKyAgICAg
ICAgICAgICJuYW1lIjogInJhc19tbWh1Yi4xLjAiLAo+ICsgICAgICAgICAgICAiYmxvY2siOiAi
bW1odWIiLAo+ICsgICAgICAgICAgICAidHlwZSI6ICJzaW5nbGVfY29ycmVjdGFibGUiLAo+ICsg
ICAgICAgICAgICAiYWRkcmVzcyI6IDAsCj4gKyAgICAgICAgICAgICJ2YWx1ZSI6IDAKPiArICAg
ICAgICB9LAo+ICAgICAgIF0KPiAgIH0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
