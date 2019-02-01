From: sylvain.bertrand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH 01/35] drm/amd/display: Use udelay when waiting between
 aux retries
Date: Fri, 1 Feb 2019 20:47:06 +0000
Message-ID: <20190201204706.GA8286@freedom>
References: <20190201152847.11151-1-Bhawanpreet.Lakha@amd.com>
 <20190201152847.11151-2-Bhawanpreet.Lakha@amd.com>
 <20190201173141.GA3838@freedom>
 <fda8f6ec-5a75-6456-3034-f3714b304b77@amd.com>
 <20190201200830.GA7069@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190201200830.GA7069@freedom>
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
To: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
Cc: "Barberiz, John" <John.Barberiz-5C7GfCeVMHo@public.gmane.org>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gRnJpLCBGZWIgMDEsIDIwMTkgYXQgMDg6MDg6MzBQTSArMDAwMCwgc3lsdmFpbi5iZXJ0cmFu
ZEBnbWFpbC5jb20gd3JvdGU6Cj4gRG8geW91IG1lYW4gbm9uLURDIGRpc3BsYXlwb3J0IHJlbGF0
ZWQgY29kZSBpcyBhbHJlYWR5IHVzaW5nIHVkZWxheSBpbnN0ZWFkCj4gb2YgbXNsZWVwIG9uIGxp
bnV4PwoKSSBncmVwLWVkIGFtZGdwdSBkaXNwbGF5cG9ydCBhdG9tYmlvcyBjb2RlLCBnb3QgdWRl
bGF5KDQwMCkgb25seS4KRGlkIHRoZSBzYW1lIG9uIGRybSAqX2RwXyogZmlsZXMsIGdvdCBzaW1p
bGFyIHVkZWxheXMgd2l0aCBvbmx5IGEgdmVyeSBzbG93Cm1zbGVlcCAod2hpY2ggc2VlbXMganVz
dGlmaWVkIHRoZXJlKS4KCkJ1dCBJIGRpZCBub3QgZ2V0IGFueSB1ZGVsYXlzIHdpdGggdGhlIHJh
bmdlIG9mIDFtcyBmb3IgInJldHJpZXMiLiBNYXliZSBpdAp3b3VsZCBiZSBhIGdvb2QgaWRlYSB0
byBhIHNpbWlsYXIgZGVsYXkgb24gbm9uLURDIGRpc3BsYXlwb3J0IGNvZGU/IFRoYXQgd291bGQK
Z2l2ZSBtb3JlIHRpbWUgdG8gInNsb3ciIGRpc3BsYXlvcnQgbW9uaXRvcnMgdG8gdGltZW91dCBv
biB0aGVpciBzaWRlLgoKLS0gClN5bHZhaW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
