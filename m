From: Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdkfd: Integer overflows in ioctl
Date: Wed, 25 Apr 2018 12:05:40 -0400
Message-ID: <06344e65-8cfa-d0f9-b966-c59fd2b16834@amd.com>
References: <20180424133549.GB10167@mwanda>
 <e2b7b3c1-cadb-330f-53a8-57568d4bc877@amd.com>
 <20180425092155.ibca4sdsxr553ouv@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180425092155.ibca4sdsxr553ouv@mwanda>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>

T24gMjAxOC0wNC0yNSAwNToyMSBBTSwgRGFuIENhcnBlbnRlciB3cm90ZToKPiBPbiBUdWUsIEFw
ciAyNCwgMjAxOCBhdCAwMjo1ODoxMFBNIC0wNDAwLCBGZWxpeCBLdWVobGluZyB3cm90ZToKPj4g
UmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Pgo+
PiBXZSBjb3VsZCBwcm9iYWJseSBhZGQgYSBzYW5pdHkgY2hlY2sgZm9yIG5fZGV2aWNlcyB0byBh
dm9pZCB1c2VyIG1vZGUKPj4gY2F1c2luZyBleGNlc3NpdmUgbWVtb3J5IGFsbG9jYXRpb25zIGlu
IHRoZSBrZXJuZWwuIFRoZXJlIGlzIG5vIGdvb2QKPj4gcmVhc29uIGZvciB0aGlzIHRvIGJlIGJp
Z2dlciB0aGFuIHRoZSBudW1iZXIgb2YgR1BVcyBpbiB0aGUgc3lzdGVtLiBUaGUKPj4gbWF4aW11
bSBudW1iZXIgb2YgR1BVcyBzdXBwb3J0ZWQgZHVlIHRvIGRldmljZSBtaW5vciBsaW1pdCBpbiBE
Uk0gaXMgMTI4Lgo+Pgo+IDEyOCBpcyBzb3J0IG9mIGEgbWFnaWMgbnVtYmVyLiAgSXMgdGhlcmUg
YSBNQVhfR1BVIGRlZmluZSBvciBzb21ldGhpbmc/CkFjdHVhbGx5LCBsb29raW5nIGF0IGRybV9t
aW5vcl9hbGxvYyBpbiBkcm1fZmlsZS5jLCB0aGUgbWF4aW11bSBpcyBvbmx5CjY0IEdQVXMuIEl0
J3MganVzdCBhIG1hZ2ljIG51bWJlciBpbiB0aGUgY29kZS4gVGhlcmUgaXMgbm8gI2RlZmluZSBv
cgplbnVtIGZvciB0aGlzLgoKUmVnYXJkcywKwqAgRmVsaXgKCgo+Cj4gcmVnYXJkcywKPiBkYW4g
Y2FycGVudGVyCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
