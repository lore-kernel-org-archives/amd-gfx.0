From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] Skip IH re-route on Vega SR-IOV
Date: Tue, 7 May 2019 09:36:43 +0200
Message-ID: <1b5b40b0-0d3c-8374-f423-5c50617fca9a@gmail.com>
References: <1557202115-24444-1-git-send-email-Trigger.Huang@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1557202115-24444-1-git-send-email-Trigger.Huang-5C7GfCeVMHo@public.gmane.org>
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
To: Trigger Huang <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

V2UgaW50ZW50aW9uYWxseSBkaWRuJ3QgZG8gdGhpcyB0byBtYWtlIHN1cmUgdGhhdCB0aGUgY29t
bWFuZHMgYXJlIAppZ25vcmVkIGJ5IHRoZSBQU1AgZmlybXdhcmUuCgpJIGhhdmUgbm8gc3Ryb25n
IG9waW5pb24gb24gaWYgd2Ugc2hvdWxkIGRvIHRoaXMgb3Igbm90LCBidXQgdGhlIFBTUCAKZmly
bXdhcmUgZ3V5cyBtaWdodCBoYXZlLgoKQ2hyaXN0aWFuLgoKQW0gMDcuMDUuMTkgdW0gMDY6MDgg
c2NocmllYiBUcmlnZ2VyIEh1YW5nOgo+IElIIHJlLXJvdXRlIGlzIG5vdCBzdXBwb3J0ZWQgb24g
VmVnYSBTUi1JT1YsIG5lZWQgdG8gYmUgc2tpcHBlZAo+Cj4gVHJpZ2dlciBIdWFuZyAoMik6Cj4g
ICAgZHJtL2FtZGdwdTogU2tpcCBJSCByZXJvdXRlIGluIFZlZ2ExMCBTUi1JT1YgVkYKPiAgICBk
cm0vYW1kZ3B1OiBTa2lwIElIIHJlcm91dGUgaW4gVmVnYTIwIFNSLUlPViBWRgo+Cj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjExXzAuYyB8IDQgKysrKwo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvcHNwX3YzXzEuYyAgfCA0ICsrKysKPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
